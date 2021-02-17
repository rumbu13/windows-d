// Written in the D programming language.

module windows.networkpolicyserver;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;

extern(Windows):


// Enums


///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>ATTRIBUTEID</b> enumeration type enumerates the RADIUS attributes supported by the SDO API.
alias ATTRIBUTEID = uint;
enum : uint
{
    ///Specifies a value equal to zero, and used as the <b>NULL</b> terminator in an array of attributes.
    ATTRIBUTE_UNDEFINED                                  = 0x00000000,
    ///Specifies the minimum value for values of this enumeration type.
    ATTRIBUTE_MIN_VALUE                                  = 0x00000001,
    ///Specifies the name of the user to be authenticated. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_USER_NAME                           = 0x00000001,
    ///Specifies the password of the user to be authenticated. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_USER_PASSWORD                       = 0x00000002,
    ///Specifies the password provided by the user in response to an MD5 Challenge Handshake Authentication Protocol
    ///(CHAP) challenge. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CHAP_PASSWORD                       = 0x00000003,
    ///Specifies the Network Access Server (NAS) IP address. An Access-Request should specify either an NAS IP address
    ///or an NAS identifier. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_NAS_IP_ADDRESS                      = 0x00000004,
    ///Specifies the physical or virtual private network (VPN) through which the user is connecting to the NAS. Note
    ///that this value is not a port number in the sense of TCP or UDP. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_NAS_PORT                            = 0x00000005,
    ///Specifies the type of service the user has requested or the type of service to be provided. For more information,
    ///see RFC 2865.
    RADIUS_ATTRIBUTE_SERVICE_TYPE                        = 0x00000006,
    ///Specifies the type of framed protocol to use for framed access, for example SLIP, PPP, or ARAP (AppleTalk Remote
    ///Access Protocol). For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_PROTOCOL                     = 0x00000007,
    ///Specifies the IP address that is configured for the user requesting authentication. This attribute is typically
    ///returned by the authentication provider. However, the NAS may use it in an authentication request to specify a
    ///preferred IP address. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_IP_ADDRESS                   = 0x00000008,
    ///Specifies the IP network mask for a user that is a router to a network. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_IP_NETMASK                   = 0x00000009,
    ///Specifies the routing method for a user that is a router to a network. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_ROUTING                      = 0x0000000a,
    ///Specifies the filter list for the user requesting authentication. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FILTER_ID                           = 0x0000000b,
    ///Specifies the Maximum Transmission Unit (MTU) for the user. This attribute is used in cases where the MTU is not
    ///negotiated through some other means, such as PPP. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_MTU                          = 0x0000000c,
    ///Specifies a compression protocol to use for the connection. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_COMPRESSION                  = 0x0000000d,
    ///Specifies the system with which to connect the user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_LOGIN_IP_HOST                       = 0x0000000e,
    ///Specifies the service to use to connect the user to the host specified by <b>raatLoginIPHost</b>. For more
    ///information, see RFC 2865.
    RADIUS_ATTRIBUTE_LOGIN_SERVICE                       = 0x0000000f,
    ///Specifies the port to which to connect the user. This attribute is present only if the <b>raatLoginService</b>
    ///attribute is present. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_LOGIN_TCP_PORT                      = 0x00000010,
    ///This value is currently unassigned.
    RADIUS_ATTRIBUTE_UNASSIGNED1                         = 0x00000011,
    ///Specifies a message to display to the user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_REPLY_MESSAGE                       = 0x00000012,
    ///Specifies a callback number. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CALLBACK_NUMBER                     = 0x00000013,
    ///Specifies a location to call back. The value of this attribute is interpreted by the NAS. For more information,
    ///see RFC 2865.
    RADIUS_ATTRIBUTE_CALLBACK_ID                         = 0x00000014,
    ///This value is currently unassigned. The value field in for this type is also undefined.
    RADIUS_ATTRIBUTE_UNASSIGNED2                         = 0x00000015,
    ///Specifies routing information to configure on the NAS for the user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_ROUTE                        = 0x00000016,
    ///Specifies the IPX network number to configure for the user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_IPX_NETWORK                  = 0x00000017,
    ///Specifies state information provided to the client by the server. Refer to RFC 2865 for detailed information
    ///about this value. The value field in for this type is a pointer.
    RADIUS_ATTRIBUTE_STATE                               = 0x00000018,
    ///Specifies a value that is provided to the NAS by the authentication provider. The NAS should use this value when
    ///communicating with the accounting provider. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CLASS                               = 0x00000019,
    ///Specifies a field for vendor-supplied extended attributes. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_VENDOR_SPECIFIC                     = 0x0000001a,
    ///Specifies the maximum number of seconds for which to provide service to the user. After this time, the session is
    ///terminated. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_SESSION_TIMEOUT                     = 0x0000001b,
    ///Specifies the maximum number of consecutive seconds the session can be idle. If the idle time exceeds this value,
    ///the session is terminated. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_IDLE_TIMEOUT                        = 0x0000001c,
    ///Specifies an action the server performs when time the connection terminates. Refer to the above-referenced files
    ///for detailed information about this value. The value field in for this type is 32-bit integral value. For more
    ///information, see RFC 2865.
    RADIUS_ATTRIBUTE_TERMINATION_ACTION                  = 0x0000001d,
    ///Specifies the number that the user dialed to connect to the NAS. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CALLED_STATION_ID                   = 0x0000001e,
    ///Specifies the number from which the user is calling. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CALLING_STATION_ID                  = 0x0000001f,
    ///Specifies the NAS identifier. An Access-Request should specify either an NAS identifier or an NAS IP address. For
    ///more information, see RFC 2865.
    RADIUS_ATTRIBUTE_NAS_IDENTIFIER                      = 0x00000020,
    ///Specifies a value that a proxy server includes when forwarding an authentication request. For more information,
    ///see RFC 2865.
    RADIUS_ATTRIBUTE_PROXY_STATE                         = 0x00000021,
    ///Specifies an attribute that is not currently used for authentication on Windows. For more information, see RFC
    ///2865.
    RADIUS_ATTRIBUTE_LOGIN_LAT_SERVICE                   = 0x00000022,
    ///Specifies an attribute that is not currently used for authentication on Windows. For more information, see RFC
    ///2865.
    RADIUS_ATTRIBUTE_LOGIN_LAT_NODE                      = 0x00000023,
    ///Specifies an attribute that is not currently used for authentication on Windows. For more information, see RFC
    ///2865.
    RADIUS_ATTRIBUTE_LOGIN_LAT_GROUP                     = 0x00000024,
    ///Specifies the AppleTalk network number for the user when the user is another router. The value field in for this
    ///type is 32-bit integral value. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_LINK               = 0x00000025,
    ///Specifies the AppleTalk network number that the NAS should use to allocate an AppleTalk node for the user. This
    ///attribute is used only when the user is not another router. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_NET                = 0x00000026,
    ///Specifies the AppleTalk default zone for the user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_FRAMED_APPLETALK_ZONE               = 0x00000027,
    ///Specifies whether the accounting provider should start or stop accounting for the user. For more information, see
    ///RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_STATUS_TYPE                    = 0x00000028,
    ///Specifies the length of time that the client has been attempting to send the current request. For more
    ///information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_DELAY_TIME                     = 0x00000029,
    ///Specifies the number of octets that have been received during the current accounting session. For more
    ///information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_INPUT_OCTETS                   = 0x0000002a,
    ///Specifies the number of octets that were sent during the current accounting session. For more information, see
    ///RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_OUTPUT_OCTETS                  = 0x0000002b,
    ///Specifies a value to enable the identification of matching start and stop records within a log file. The start
    ///and stop records are sent in the <b>raatAcctStatusType</b> attribute. For more information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_SESSION_ID                     = 0x0000002c,
    ///Specifies, to the accounting provider, how the user was authenticated; for example by Windows Directory Services,
    ///RADIUS, or some other authentication provider. For more information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_AUTHENTIC                      = 0x0000002d,
    ///Specifies the number of seconds that have elapsed in the current accounting session. For more information, see
    ///RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_SESSION_TIME                   = 0x0000002e,
    ///Specifies the number of packets that are received during the current accounting session. For more information,
    ///see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_INPUT_PACKETS                  = 0x0000002f,
    ///Specifies the number of packets that are sent during the current accounting session. For more information, see
    ///RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_OUTPUT_PACKETS                 = 0x00000030,
    ///Specifies how the current accounting session was terminated. For more information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_TERMINATE_CAUSE                = 0x00000031,
    ///Specifies a value to enable the identification of related accounting sessions within a log file. For more
    ///information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_MULTI_SSN_ID                   = 0x00000032,
    ///Specifies the number of links if the current accounting session is using a multilink connection. For more
    ///information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_LINK_COUNT                     = 0x00000033,
    ///Specifies the CHAP challenge sent by the NAS to a CHAP user. For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_CHAP_CHALLENGE                      = 0x0000003c,
    ///Specifies the type of the port through which the user is connecting, for example, asynchronous, ISDN, virtual.
    ///For more information, see RFC 2865.
    RADIUS_ATTRIBUTE_NAS_PORT_TYPE                       = 0x0000003d,
    ///Specifies the number of ports the NAS should make available to the user for multilink sessions. For more
    ///information, see RFC 2865.
    RADIUS_ATTRIBUTE_PORT_LIMIT                          = 0x0000003e,
    ///Specifies an attribute that is not currently used for authentication on Windows. For more information, see RFC
    ///2865.
    RADIUS_ATTRIBUTE_LOGIN_LAT_PORT                      = 0x0000003f,
    ///Specifies the tunneling protocol used. The following list lists valid tunnel types. <table> <tr> <th>Tunnel type
    ///value</th> <th>Description</th> </tr> <tr> <td>1</td> <td>Point-to-Point Tunneling Protocol (PPTP)</td> </tr>
    ///<tr> <td>2</td> <td>Layer Two Forwarding (L2F)</td> </tr> <tr> <td>3</td> <td>Layer Two Tunneling Protocol
    ///(L2TP)</td> </tr> <tr> <td>4</td> <td>Ascend Tunnel Management Protocol (ATMP)</td> </tr> <tr> <td>5</td>
    ///<td>Virtual Tunneling Protocol (VTP)</td> </tr> <tr> <td>6</td> <td>IP Authentication Header in the
    ///Tunnel-mode</td> </tr> <tr> <td>7</td> <td>IP-in-IP Encapsulation (IP-IP)</td> </tr> <tr> <td>8</td> <td>Minimal
    ///IP-in-IP Encapsulation (MIN-IP-IP)</td> </tr> <tr> <td>9</td> <td>IP Encapsulating Security Payload in the
    ///Tunnel-mode (ESP)</td> </tr> <tr> <td>10</td> <td>Generic Route Encapsulation (GRE)</td> </tr> <tr> <td>11</td>
    ///<td>Bay Dial Virtual Services (DVS)</td> </tr> <tr> <td>12</td> <td>IP-in-IP Tunneling</td> </tr> </table>
    RADIUS_ATTRIBUTE_TUNNEL_TYPE                         = 0x00000040,
    ///Specifies which transport medium to use when creating a tunnel for those protocols (such as L2TP) that can
    ///operate over multiple transports. The following list lists valid medium types. <table> <tr> <th>Medium type
    ///value</th> <th>Description</th> </tr> <tr> <td>1</td> <td>IPv4 (IP version 4)</td> </tr> <tr> <td>2</td> <td>IPv6
    ///(IP version 6)</td> </tr> <tr> <td>3</td> <td>OSI Network Service Access Points (NSAP) Signaling Protocol (see
    ///ISO 8348 and ITU-T X.213).</td> </tr> <tr> <td>4</td> <td>High-Level Data Link Control (HDLC) Protocol (8-bit
    ///multidrop)</td> </tr> <tr> <td>5</td> <td>Bolt Beranek and Newman, Inc. (BBN) Report 1822</td> </tr> <tr>
    ///<td>6</td> <td>IEEE 802 (includes all 802 media plus Ethernet "canonical format")</td> </tr> <tr> <td>7</td>
    ///<td>E.163 Plain Old Telephone Service (POTS)</td> </tr> <tr> <td>8</td> <td>E.164 Switched Multimegabit Data
    ///Service (SMDS), Frame Relay, Asynchronous Transfer Mode (ATM)</td> </tr> <tr> <td>9</td> <td>F.69 (Telex)</td>
    ///</tr> <tr> <td>10</td> <td>X.121 (X.25, Frame Relay)</td> </tr> <tr> <td>11</td> <td>Internetwork Packet Exchange
    ///(IPX)</td> </tr> <tr> <td>12</td> <td>AppleTalk</td> </tr> <tr> <td>13</td> <td>Decnet IV</td> </tr> <tr>
    ///<td>14</td> <td>Banyan Vines</td> </tr> <tr> <td>15</td> <td>E.164 with NSAP format subaddress</td> </tr>
    ///</table>
    RADIUS_ATTRIBUTE_TUNNEL_MEDIUM_TYPE                  = 0x00000041,
    ///Specifies the address of the initiator end of the tunnel.
    RADIUS_ATTRIBUTE_TUNNEL_CLIENT_ENDPT                 = 0x00000042,
    ///Specifies the address of the server end of the tunnel.
    RADIUS_ATTRIBUTE_TUNNEL_SERVER_ENDPT                 = 0x00000043,
    ///Specifies an identifier assigned to the tunnel session. For more information, see RFC 2867.
    RADIUS_ATTRIBUTE_ACCT_TUNNEL_CONN                    = 0x00000044,
    ///The password for authenticating to the remote server.
    RADIUS_ATTRIBUTE_TUNNEL_PASSWORD                     = 0x00000045,
    ///Specifies a password to use for AppleTalk Remote Access Protocol (ARAP) authentication. For more information, see
    ///RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_PASSWORD                       = 0x00000046,
    ///Specifies information that an NAS should send back to the user in an ARAP "feature flags" packet. For more
    ///information, see RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_FEATURES                       = 0x00000047,
    ///Specifies how to use the ARAP zone list for the user. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_ZONE_ACCESS                    = 0x00000048,
    ///Specifies an ARAP security module to use during a secondary authentication phase between the NAS and the user.
    ///The value field for this type is a 32-bit integral. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_SECURITY                       = 0x00000049,
    ///Specifies the data to use with an ARAP security module. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_SECURITY_DATA                  = 0x0000004a,
    ///Specifies the number of password retry attempts to permit the user access. The value field for this type is a
    ///32-bit integral value.
    RADIUS_ATTRIBUTE_PASSWORD_RETRY                      = 0x0000004b,
    ///Specifies whether the NAS should echo the user response to a challenge. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_PROMPT                              = 0x0000004c,
    ///Specifies information about the type of connection the user is using. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_CONNECT_INFO                        = 0x0000004d,
    ///Specifies user-profile information in communications between RADIUS Proxy Servers and RADIUS Proxy Clients. For
    ///more information, see RFC 2869.
    RADIUS_ATTRIBUTE_CONFIGURATION_TOKEN                 = 0x0000004e,
    ///Specifies that EAP information be sent directly between the user and the authentication provider. For more
    ///information, see RFC 2869.
    RADIUS_ATTRIBUTE_EAP_MESSAGE                         = 0x0000004f,
    ///Specifies a signature to include with CHAP, EAP, or ARAP packets. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_SIGNATURE                           = 0x00000050,
    ///Group ID for a particular tunneled session.
    RADIUS_ATTRIBUTE_TUNNEL_PVT_GROUP_ID                 = 0x00000051,
    ///Specifies a tunnel to which a session is assigned.
    RADIUS_ATTRIBUTE_TUNNEL_ASSIGNMENT_ID                = 0x00000052,
    ///Relative preference assigned to each tunnel when more than one set of tunneling attributes is returned to the
    ///tunnel initiator.
    RADIUS_ATTRIBUTE_TUNNEL_PREFERENCE                   = 0x00000053,
    ///Specifies the response to a Apple Remote Access Protocol (ARAP) challenge. In ARAP, either the server or the
    ///client responds to challenges. For more information, see RFC 2869.
    RADIUS_ATTRIBUTE_ARAP_CHALLENGE_RESPONSE             = 0x00000054,
    ///Indicates the number of seconds between each interim update for this specific session. This value can only appear
    ///in the Access-Accept message. For more information, see RFC 2866.
    RADIUS_ATTRIBUTE_ACCT_INTERIM_INTERVAL               = 0x00000055,
    ///Specifies the IPv6 Address of the NAS that requests authentication of the user. It should be unique to the NAS
    ///within the scope of the RADIUS server. It is only used in an Access-Request packet. For more information, see the
    ///NAS-IPv6-Address section in RFC 3162.
    RADIUS_ATTRIBUTE_NAS_IPv6_ADDRESS                    = 0x0000005f,
    ///Specifies the IPv6 interface identifier to be configured for the user. It may be used in an Access-Accept packet.
    ///For more information, see the Framed-Interface-Id section in RFC 3162.
    RADIUS_ATTRIBUTE_FRAMED_INTERFACE_ID                 = 0x00000060,
    ///Specifies an IPv6 prefix (and corresponding route) to be configured for the user. It may be used in an
    ///Access-Accept packet and can appear multiple times. For more information, see the Framed-IPv6-Prefix section in
    ///RFC 3162.
    RADIUS_ATTRIBUTE_FRAMED_IPv6_PREFIX                  = 0x00000061,
    ///Specifies the system with which to connect the user, when the ratLoginService attribute is included. It may be
    ///used in an Access-Accept packet. For more information, see the Login-IPv6-Host section in RFC 3162.
    RADIUS_ATTRIBUTE_LOGIN_IPv6_HOST                     = 0x00000062,
    ///Specifies routing information to be configured for the user on the NAS. It is used in an Access-Accept packet and
    ///can appear multiple times. For more information, see the Framed-IPv6-Route section in RFC 3162.
    RADIUS_ATTRIBUTE_FRAMED_IPv6_ROUTE                   = 0x00000063,
    ///Specifies the name of an assigned pool that should be used to assign an IPv6 prefix for the user. If a NAS does
    ///not support multiple prefix pools, the NAS must ignore this attribute. For more information, see the
    ///Framed-IPv6-Pool section in RFC 3162.
    RADIUS_ATTRIBUTE_FRAMED_IPv6_POOL                    = 0x00000064,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IP_ADDRESS         = 0x00001000,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_RADIUS_CALLBACK_NUMBER           = 0x00001001,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NP_CALLING_STATION_ID                  = 0x00001002,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_NP_CALLING_STATION_ID            = 0x00001003,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_ROUTE              = 0x00001004,
    ///Specifies that the user's dial-in properties are ignored.
    IAS_ATTRIBUTE_IGNORE_USER_DIALIN_PROPERTIES          = 0x00001005,
    ///Time periods and days of week during which user is allowed to connect.
    IAS_ATTRIBUTE_NP_TIME_OF_DAY                         = 0x00001006,
    ///Phone number dialed by user.
    IAS_ATTRIBUTE_NP_CALLED_STATION_ID                   = 0x00001007,
    ///Port types permitted for a connection.
    IAS_ATTRIBUTE_NP_ALLOWED_PORT_TYPES                  = 0x00001008,
    ///Authentication types permitted for a connection.
    IAS_ATTRIBUTE_NP_AUTHENTICATION_TYPE                 = 0x00001009,
    ///EAP encryption modes permitted for a connection.
    IAS_ATTRIBUTE_NP_ALLOWED_EAP_TYPE                    = 0x0000100a,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SHARED_SECRET                          = 0x0000100b,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_IP_ADDRESS                      = 0x0000100c,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_PACKET_HEADER                   = 0x0000100d,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_TOKEN_GROUPS                           = 0x0000100e,
    ///Specifies whether dial-in access is available for a given user.
    IAS_ATTRIBUTE_ALLOW_DIALIN                           = 0x0000100f,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_REQUEST_ID                             = 0x00001010,
    ///The target data to which an attribute manipulation rule is applied. Attribute manipulation was previously known
    ///as 'realms processing'. See the online help for Internet Authentication Service for more information on attribute
    ///manipulation.
    IAS_ATTRIBUTE_MANIPULATION_TARGET                    = 0x00001011,
    ///The manipulation rule to apply to the data specified by the Manipulation-Target attribute. See the online help
    ///for Internet Authentication Service for more information on attribute manipulation.
    IAS_ATTRIBUTE_MANIPULATION_RULE                      = 0x00001012,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_ORIGINAL_USER_NAME                     = 0x00001013,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_VENDOR_TYPE                     = 0x00001014,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_UDP_PORT                        = 0x00001015,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_CHALLENGE                          = 0x00001016,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_RESPONSE                           = 0x00001017,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_DOMAIN                             = 0x00001018,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_ERROR                              = 0x00001019,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_CPW1                               = 0x0000101a,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_CPW2                               = 0x0000101b,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_LM_ENC_PW                          = 0x0000101c,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_NT_ENC_PW                          = 0x0000101d,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP_MPPE_KEYS                          = 0x0000101e,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_AUTHENTICATION_TYPE                    = 0x0000101f,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_NAME                            = 0x00001020,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NT4_ACCOUNT_NAME                       = 0x00001021,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_FULLY_QUALIFIED_USER_NAME              = 0x00001022,
    ///Specifies groups used for the policy conditions.
    IAS_ATTRIBUTE_NTGROUPS                               = 0x00001023,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EAP_FRIENDLY_NAME                      = 0x00001024,
    ///The type of authentication provider to use.
    IAS_ATTRIBUTE_AUTH_PROVIDER_TYPE                     = 0x00001025,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_ACCT_AUTH_TYPE                          = 0x00001026,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_ACCT_EAP_TYPE                           = 0x00001027,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PACKET_TYPE                            = 0x00001028,
    ///The name of the RADIUS server or server group that provides authentication.
    IAS_ATTRIBUTE_AUTH_PROVIDER_NAME                     = 0x00001029,
    ///The type of accounting provider to use.
    IAS_ATTRIBUTE_ACCT_PROVIDER_TYPE                     = 0x0000102a,
    ///The name of the RADIUS server that provides accounting.
    IAS_ATTRIBUTE_ACCT_PROVIDER_NAME                     = 0x0000102b,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_MPPE_SEND_KEY                           = 0x0000102c,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_MPPE_RECV_KEY                           = 0x0000102d,
    ///Specifies an MS-CHAP reason-for-failure code. This attribute is returned in the Failure packet Message field. For
    ///more information, see Request for Comments (RFC) 2433.
    IAS_ATTRIBUTE_REASON_CODE                            = 0x0000102e,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_FILTER                                  = 0x0000102f,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP2_RESPONSE                          = 0x00001030,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP2_SUCCESS                           = 0x00001031,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_CHAP2_CPW                               = 0x00001032,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_RAS_VENDOR                              = 0x00001033,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_RAS_VERSION                             = 0x00001034,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NP_NAME                                = 0x00001035,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_PRIMARY_DNS_SERVER                      = 0x00001036,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_SECONDARY_DNS_SERVER                    = 0x00001037,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_PRIMARY_NBNS_SERVER                     = 0x00001038,
    ///See Request for Comments (RFC) 2548, Microsoft Vendor-specific RADIUS Attributes.
    MS_ATTRIBUTE_SECONDARY_NBNS_SERVER                   = 0x00001039,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PROXY_POLICY_NAME                      = 0x0000103a,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PROVIDER_TYPE                          = 0x0000103b,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PROVIDER_NAME                          = 0x0000103c,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_REMOTE_SERVER_ADDRESS                  = 0x0000103d,
    ///Specifies whether NPS automatically generates the class attribute. NPS automatically generates the class
    ///attribute by default.
    IAS_ATTRIBUTE_GENERATE_CLASS_ATTRIBUTE               = 0x0000103e,
    ///Specifies the name of the client generating a request.
    MS_ATTRIBUTE_RAS_CLIENT_NAME                         = 0x0000103f,
    ///Specifies the version of the client generating a request.
    MS_ATTRIBUTE_RAS_CLIENT_VERSION                      = 0x00001040,
    ///Specifies the certificate purpose or usage object identifiers (OIDs), in dotted decimal notation, that are
    ///allowed when performing certificate-based authentication with EAP-TLS.
    IAS_ATTRIBUTE_ALLOWED_CERTIFICATE_EKU                = 0x00001041,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EXTENSION_STATE                        = 0x00001042,
    ///Specifies whether NPS automatically generates the session timeout based on user account expiration and
    ///time-of-day restrictions. NPS does not automatically generate the session timeout by default.
    IAS_ATTRIBUTE_GENERATE_SESSION_TIMEOUT               = 0x00001043,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SESSION_TIMEOUT                        = 0x00001044,
    ///Specifies the IP traffic filter used by the Routing and Remote Access service when the connection is in a
    ///restricted state.
    MS_ATTRIBUTE_QUARANTINE_IPFILTER                     = 0x00001045,
    ///Specifies the time (in seconds) that the connection can remain in a restricted state before being disconnected.
    MS_ATTRIBUTE_QUARANTINE_SESSION_TIMEOUT              = 0x00001046,
    ///Specifies the SID of the user requesting access.
    MS_ATTRIBUTE_USER_SECURITY_IDENTITY                  = 0x00001047,
    ///Specifies that Windows authorization is enabled for users authenticated by the remote RADIUS server for example,
    ///allows use with Passport user mapping.
    IAS_ATTRIBUTE_REMOTE_RADIUS_TO_WINDOWS_USER_MAPPING  = 0x00001048,
    ///Specifies the UPN suffix of the Passport to Windows user mapping.
    IAS_ATTRIBUTE_PASSPORT_USER_MAPPING_UPN_SUFFIX       = 0x00001049,
    ///Used to set the tag byte for any tunnel attributes in the profile. If this is not set, the default is zero.
    IAS_ATTRIBUTE_TUNNEL_TAG                             = 0x0000104a,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NP_PEAPUPFRONT_ENABLED                 = 0x0000104b,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CERTIFICATE_EKU                        = 0x00001fa1,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EAP_CONFIG                             = 0x00001fa2,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PEAP_EMBEDDED_EAP_TYPEID               = 0x00001fa3,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PEAP_FAST_ROAMED_SESSION               = 0x00001fa4,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EAP_TYPEID                             = 0x00001fa5,
    ///This attribute is reserved for system use.
    MS_ATTRIBUTE_EAP_TLV                                 = 0x00001fa6,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_REJECT_REASON_CODE                     = 0x00001fa7,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PROXY_EAP_CONFIG                       = 0x00001fa8,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EAP_SESSION                            = 0x00001fa9,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_IS_REPLAY                              = 0x00001faa,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLEAR_TEXT_PASSWORD                    = 0x00001fab,
    ///Specifies the type of identity check to perform.
    MS_ATTRIBUTE_IDENTITY_TYPE                           = 0x00001fac,
    ///Specifies which group of DHCP scopes correspond to the client requesting access.
    MS_ATTRIBUTE_SERVICE_CLASS                           = 0x00001fad,
    ///Vendor-specific attribute used to carry the name of a special DHCP user class, as specified in RFC 3004, called
    ///Network Access Protection (NAP) user class.
    MS_ATTRIBUTE_QUARANTINE_USER_CLASS                   = 0x00001fae,
    ///Specifies the target quarantine state of the client.
    MS_ATTRIBUTE_QUARANTINE_STATE                        = 0x00001faf,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_OVERRIDE_RAP_AUTH                      = 0x00001fb0,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PEAP_CHANNEL_UP                        = 0x00001fb1,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NAME_MAPPED                            = 0x00001fb2,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_POLICY_ENFORCED                        = 0x00001fb3,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_MACHINE_NTGROUPS                       = 0x00001fb4,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_USER_NTGROUPS                          = 0x00001fb5,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_MACHINE_TOKEN_GROUPS                   = 0x00001fb6,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_USER_TOKEN_GROUPS                      = 0x00001fb7,
    ///Specifies the amount of time a host has to become conformant with network policy.
    MS_ATTRIBUTE_QUARANTINE_GRACE_TIME                   = 0x00001fb8,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_URL                         = 0x00001fb9,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS               = 0x00001fba,
    ///Vendor-specific attribute that specifies if the client is capable of reporting its state to the network access
    ///server (NAS). It must be one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>0</td> <td> The client sent a Statement of Health (SoH).</td> </tr> <tr> <td>1</td> <td> The client did not
    ///send an SoH.</td> </tr> </table>
    MS_ATTRIBUTE_NOT_QUARANTINE_CAPABLE                  = 0x00001fbb,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_RESULT        = 0x00001fbc,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_SYSTEM_HEALTH_VALIDATORS    = 0x00001fbd,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_MACHINE_NAME                           = 0x00001fbe,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NT4_MACHINE_NAME                       = 0x00001fbf,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_SESSION_HANDLE              = 0x00001fc0,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_FULLY_QUALIFIED_MACHINE_NAME           = 0x00001fc1,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_FIXUP_SERVERS_CONFIGURATION = 0x00001fc2,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_QUARANTINE_COMPATIBLE           = 0x00001fc3,
    ///Specifies the access type of a network access server (NAS). A NAS may send this attribute to a RADIUS server to
    ///indicate the type of this NAS in an Access-Request message.
    MS_ATTRIBUTE_NETWORK_ACCESS_SERVER_TYPE              = 0x00001fc4,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_SESSION_ID                  = 0x00001fc5,
    ///Vendor-specific attribute used as a hint for dynamic selection of a preconfigured Internet Protocol security
    ///(IPsec) policy by the client requesting access.
    MS_ATTRIBUTE_AFW_QUARANTINE_ZONE                     = 0x00001fc6,
    ///Vendor-specific attribute used as a hint for dynamic selection of a preconfigured IPsec policy by the client
    ///requesting access.
    MS_ATTRIBUTE_AFW_PROTECTION_LEVEL                    = 0x00001fc7,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_QUARANTINE_UPDATE_NON_COMPLIANT        = 0x00001fc8,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_REQUEST_START_TIME                     = 0x00001fc9,
    ///Vendor-specific attribute used to communicate the machine name of the client requesting network access.
    MS_ATTRIBUTE_MACHINE_NAME                            = 0x00001fca,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_CLIENT_IPv6_ADDRESS                    = 0x00001fcb,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_INTERFACE_ID       = 0x00001fcc,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_PREFIX        = 0x00001fcd,
    IAS_ATTRIBUTE_SAVED_RADIUS_FRAMED_IPv6_ROUTE         = 0x00001fce,
    MS_ATTRIBUTE_QUARANTINE_GRACE_TIME_CONFIGURATION     = 0x00001fcf,
    ///Vendor-specific attribute used to limit the inbound and/or outbound access of the endpoint client.
    MS_ATTRIBUTE_IPv6_FILTER                             = 0x00001fd0,
    ///Specifies a list of servers that should be reachable by a quarantined client so that it may remediate itself.
    MS_ATTRIBUTE_IPV4_REMEDIATION_SERVERS                = 0x00001fd1,
    ///Specifies a list of servers that should be reachable by a quarantined client so that it may remediate itself.
    MS_ATTRIBUTE_IPV6_REMEDIATION_SERVERS                = 0x00001fd2,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_PROXY_RETRY_COUNT                      = 0x00001fd3,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_MACHINE_INVENTORY                      = 0x00001fd4,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_ABSOLUTE_TIME                          = 0x00001fd5,
    ///Vendor-specific attribute used only to carry Statement of Health (SoH) information when EAP is not used. A RADIUS
    ///server may send it to an network access server (NAS) in an Access-Accept message.
    MS_ATTRIBUTE_QUARANTINE_SOH                          = 0x00001fd6,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_EAP_TYPES_CONFIGURED_IN_PROXYPOLICY    = 0x00001fd7,
    ///Vendor-specific attribute specifying the location group name for the HCAP entity.
    MS_ATTRIBUTE_HCAP_LOCATION_GROUP_NAME                = 0x00001fd8,
    ///Specifies the additional Quarantine state information for a user requesting access to this NAS.
    MS_ATTRIBUTE_EXTENDED_QUARANTINE_STATE               = 0x00001fd9,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SOH_CARRIER_EAPTLV                     = 0x00001fda,
    ///An NAS may use this attribute to pass the group name of the user requesting network access to a RADIUS server,
    ///which may then use this information to make authentication or authorization decisions.
    MS_ATTRIBUTE_HCAP_USER_GROUPS                        = 0x00001fdb,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_SAVED_MACHINE_HEALTHCHECK_ONLY         = 0x00001fdc,
    ///Multiple instances of this attribute can be present at one time.
    IAS_ATTRIBUTE_POLICY_EVALUATED_SHV                   = 0x00001fdd,
    ///TBD
    MS_ATTRIBUTE_RAS_CORRELATION_ID                      = 0x00001fde,
    ///An NAS may use this attribute to pass the name of the user requesting network access to a RADIUS server, which
    ///may then use this information to make authentication or authorization decisions.
    MS_ATTRIBUTE_HCAP_USER_NAME                          = 0x00001fdf,
    ///This attribute is reserved for system use.
    IAS_ATTRIBUTE_NT4_HCAP_ACCOUNT_NAME                  = 0x00001fe0,
    ///SID for IAS_ATTRIBUTE_NT4_ACCOUNT_NAME or IAS_ATTRIBUTE_NT4_HCAP_ACCOUNT_NAME regardless of whether the later is
    ///a user account or a machine account.
    IAS_ATTRIBUTE_USER_TOKEN_SID                         = 0x00001fe1,
    ///SID for IAS_ATTRIBUTE_NT4_MACHINE_NAME.
    IAS_ATTRIBUTE_MACHINE_TOKEN_SID                      = 0x00001fe2,
    ///TBD
    IAS_ATTRIBUTE_MACHINE_VALIDATED                      = 0x00001fe3,
    ///Specifies the IPv4 address of the user.
    MS_ATTRIBUTE_USER_IPv4_ADDRESS                       = 0x00001fe4,
    ///Specifies the IPv4 address of the user.
    MS_ATTRIBUTE_USER_IPv6_ADDRESS                       = 0x00001fe5,
    ///Vendor-specific attribute for TS Gateway Device Redirection flags.
    MS_ATTRIBUTE_TSG_DEVICE_REDIRECTION                  = 0x00001fe6,
    ///TBD
    IAS_ATTRIBUTE_ACCEPT_REASON_CODE                     = 0x00001fe7,
    ///TBD
    IAS_ATTRIBUTE_LOGGING_RESULT                         = 0x00001fe8,
    ///TBD
    IAS_ATTRIBUTE_SERVER_IP_ADDRESS                      = 0x00001fe9,
    ///TBD
    IAS_ATTRIBUTE_SERVER_IPv6_ADDRESS                    = 0x00001fea,
    ///TBD
    IAS_ATTRIBUTE_RADIUS_USERNAME_ENCODING_ASCII         = 0x00001feb,
    MS_ATTRIBUTE_RAS_ROUTING_DOMAIN_ID                   = 0x00001fec,
    IAS_ATTRIBUTE_CERTIFICATE_THUMBPRINT                 = 0x0000203a,
    ///Specifies the encryption type of the user's connection.
    RAS_ATTRIBUTE_ENCRYPTION_TYPE                        = 0xffffffa6,
    ///Specifies the whether encryption is Allowed, Required, or None (disallowed). For more information, see RFC 2548.
    RAS_ATTRIBUTE_ENCRYPTION_POLICY                      = 0xffffffa7,
    ///Specifies whether bandwidth allocation protocol (BAP) is required.
    RAS_ATTRIBUTE_BAP_REQUIRED                           = 0xffffffa8,
    ///Time in seconds for the capacity utilization calculation.
    RAS_ATTRIBUTE_BAP_LINE_DOWN_TIME                     = 0xffffffa9,
    ///Percent of capacity utilized at which to bring a line down for this user.
    RAS_ATTRIBUTE_BAP_LINE_DOWN_LIMIT                    = 0xffffffaa,
}

///The values of the <b>NEW_LOG_FILE_FREQUENCY</b> enumeration type specify how frequently new log files are created.
alias NEW_LOG_FILE_FREQUENCY = int;
enum : int
{
    ///Allows the log file to grow without limit. Do not create new log files periodically.
    IAS_LOGGING_UNLIMITED_SIZE         = 0x00000000,
    ///Creates a new log file each day.
    IAS_LOGGING_DAILY                  = 0x00000001,
    ///Creates a new log file each week.
    IAS_LOGGING_WEEKLY                 = 0x00000002,
    ///Creates a new log file each month.
    IAS_LOGGING_MONTHLY                = 0x00000003,
    ///Creates a new log file when the log file reaches a particular size.
    IAS_LOGGING_WHEN_FILE_SIZE_REACHES = 0x00000004,
}

///The values of the <b>AUTHENTICATION_TYPE</b> enumerated type are used to specify the authentication method.
alias AUTHENTICATION_TYPE = int;
enum : int
{
    ///Specifies the authorization type as invalid.
    IAS_AUTH_INVALID     = 0x00000000,
    ///Specifies the authorization type as PAP.
    IAS_AUTH_PAP         = 0x00000001,
    ///Specifies the authorization type as MD5CHAP.
    IAS_AUTH_MD5CHAP     = 0x00000002,
    ///Specifies the authorization type as MSCHAP.
    IAS_AUTH_MSCHAP      = 0x00000003,
    ///Specifies the authorization type as MSCHAP2.
    IAS_AUTH_MSCHAP2     = 0x00000004,
    ///Specifies the authorization type as EAP.
    IAS_AUTH_EAP         = 0x00000005,
    ///Specifies the authorization type as PEAP.
    IAS_AUTH_ARAP        = 0x00000006,
    ///Specifies that there is not authorization type.
    IAS_AUTH_NONE        = 0x00000007,
    ///Specifies the authorization type as custom.
    IAS_AUTH_CUSTOM      = 0x00000008,
    ///Specifies the authorization type as <b>MSCHAP_CPW</b>.
    IAS_AUTH_MSCHAP_CPW  = 0x00000009,
    ///Specifies the authorization type as <b>MSCHAP2_CPW</b>.
    IAS_AUTH_MSCHAP2_CPW = 0x0000000a,
    ///Specifies the authorization type as <b>PEAP</b>.
    IAS_AUTH_PEAP        = 0x0000000b,
}

///The <b>IDENTITY_TYPE</b> enumerated type defines the different possible values for <b>MS_ATTRIBUTE_IDENTITY_TYPE</b>.
alias IDENTITY_TYPE = int;
enum : int
{
    IAS_IDENTITY_NO_DEFAULT = 0x00000001,
}

///Each value from the <b>ATTRIBUTESYNTAX</b> enumeration type specifies a possible attribute syntax.
alias ATTRIBUTESYNTAX = int;
enum : int
{
    ///The attribute is of type Boolean.
    IAS_SYNTAX_BOOLEAN          = 0x00000001,
    ///The attribute is of type integer.
    IAS_SYNTAX_INTEGER          = 0x00000002,
    ///The attribute is an enumerator.
    IAS_SYNTAX_ENUMERATOR       = 0x00000003,
    ///The attribute is an Internet address.
    IAS_SYNTAX_INETADDR         = 0x00000004,
    ///The attribute is a text string.
    IAS_SYNTAX_STRING           = 0x00000005,
    ///The attribute is a byte (octet) string.
    IAS_SYNTAX_OCTETSTRING      = 0x00000006,
    ///The attribute is a time in coordinated universal time format.
    IAS_SYNTAX_UTCTIME          = 0x00000007,
    ///The attribute and its type are vendor-specific.
    IAS_SYNTAX_PROVIDERSPECIFIC = 0x00000008,
    ///The attribute is of type unsigned integer.
    IAS_SYNTAX_UNSIGNEDINTEGER  = 0x00000009,
    ///The attribute is an IPv6 address.
    IAS_SYNTAX_INETADDR6        = 0x0000000a,
}

///The values of the <b>ATTRIBUTERESTRICTIONS</b> enumeration type specify restrictions on how a particular attribute
///can be used.
alias ATTRIBUTERESTRICTIONS = int;
enum : int
{
    ///Specifies whether the attribute is multivalued.
    MULTIVALUED             = 0x00000001,
    ///Specifies whether the attribute is allowed in a Network Access Policy (NAP) profile.
    ALLOWEDINPROFILE        = 0x00000002,
    ///Specifies whether the attribute is allowed in an NAP condition.
    ALLOWEDINCONDITION      = 0x00000004,
    ///Specifies whether the attribute is allowed in an NAP profile for a network request proxy.
    ALLOWEDINPROXYPROFILE   = 0x00000008,
    ///Specifies whether the attribute is allowed in an NAP condition for a network request proxy.
    ALLOWEDINPROXYCONDITION = 0x00000010,
    ///Specifies whether the attribute is allowed in a VPN dialup connection.
    ALLOWEDINVPNDIALUP      = 0x00000020,
    ///Specifies whether the attribute is allowed in an 8021x connection.
    ALLOWEDIN8021X          = 0x00000040,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>ATTRIBUTEFILTER</b> enumerated type defines the usage cases for the NPS dictionary attributes.
alias ATTRIBUTEFILTER = int;
enum : int
{
    ATTRIBUTE_FILTER_NONE        = 0x00000000,
    ATTRIBUTE_FILTER_VPN_DIALUP  = 0x00000001,
    ATTRIBUTE_FILTER_IEEE_802_1x = 0x00000002,
}

///The values of the <b>ATTRIBUTEINFO</b> type enumerate characteristics of a specified attribute.
alias ATTRIBUTEINFO = int;
enum : int
{
    ///The name of the attribute.
    NAME         = 0x00000001,
    ///The syntax of the attribute.
    SYNTAX       = 0x00000002,
    ///Restrictions on how the attribute can be used.
    RESTRICTIONS = 0x00000003,
    ///Description of the attribute.
    DESCRIPTION  = 0x00000004,
    ///The vendor ID for Vendor Specific Attributes (VSA).
    VENDORID     = 0x00000005,
    ///The Lightweight Directory Access Protocol (LDAP) name for the attribute.
    LDAPNAME     = 0x00000006,
    ///The attribute type for Vendor Specific Attributes (VSA).
    VENDORTYPE   = 0x00000007,
}

///The values of the <b>IASCOMMONPROPERTIES</b> enumeration type enumerate properties that are present in all SDO
///objects.
alias IASCOMMONPROPERTIES = int;
enum : int
{
    ///This property is reserved.
    PROPERTY_SDO_RESERVED       = 0x00000000,
    ///The program ID for the SDO object.
    PROPERTY_SDO_CLASS          = 0x00000001,
    ///The name of the SDO object.
    PROPERTY_SDO_NAME           = 0x00000002,
    ///Reserved for future use.
    PROPERTY_SDO_DESCRIPTION    = 0x00000003,
    ///Reserved for future use.
    PROPERTY_SDO_ID             = 0x00000004,
    ///The name of the datastore for the object.
    PROPERTY_SDO_DATASTORE_NAME = 0x00000005,
    PROPERTY_SDO_TEMPLATE_GUID  = 0x00000006,
    PROPERTY_SDO_OPAQUE         = 0x00000007,
    ///Indicates the start of USERPROPERTIES.
    PROPERTY_SDO_START          = 0x00000400,
}

///The values of the <b>USERPROPERTIES</b> enumeration type enumerate the user properties supported by the SDO API.
alias USERPROPERTIES = int;
enum : int
{
    ///The number from which the user must call.
    PROPERTY_USER_CALLING_STATION_ID               = 0x00000400,
    ///The number stored in the user interface when calling-station ID is disabled.
    PROPERTY_USER_SAVED_CALLING_STATION_ID         = 0x00000401,
    ///The number at which to callback this user.
    PROPERTY_USER_RADIUS_CALLBACK_NUMBER           = 0x00000402,
    ///Specifies static routes assigned to this user.
    PROPERTY_USER_RADIUS_FRAMED_ROUTE              = 0x00000403,
    ///Specifies a static IP address assigned to this user.
    PROPERTY_USER_RADIUS_FRAMED_IP_ADDRESS         = 0x00000404,
    ///The callback number stored in the user interface when callback is disabled.
    PROPERTY_USER_SAVED_RADIUS_CALLBACK_NUMBER     = 0x00000405,
    ///The routes stored in the user interface when static routes are disabled.
    PROPERTY_USER_SAVED_RADIUS_FRAMED_ROUTE        = 0x00000406,
    ///The static IP address stored in the user interface when static IP addresses are disabled.
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IP_ADDRESS   = 0x00000407,
    ///Specifies whether dial-in allowed, denied, or determined by policy.
    PROPERTY_USER_ALLOW_DIALIN                     = 0x00000408,
    ///Specifies whether callback is enabled for this user. See RAS_USER_1 for more information about the possible
    ///values for this property.
    PROPERTY_USER_SERVICE_TYPE                     = 0x00000409,
    ///Specifies routing information to be configured for the user on the NAS. See the Framed-IPv6-Route section in RFC
    ///3162 for more information.
    PROPERTY_USER_RADIUS_FRAMED_IPV6_ROUTE         = 0x0000040a,
    ///Specifies saved routing information for the user on the NAS. See the Framed-IPv6-Route section in RFC 3162 for
    ///more information.
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_ROUTE   = 0x0000040b,
    ///Used for IPv6. Specifies the interface identifier to be configured for the user. See the Framed-Interface-Id
    ///section in RFC 3162 for more information.
    PROPERTY_USER_RADIUS_FRAMED_INTERFACE_ID       = 0x0000040c,
    ///Used for IPv6. Specifies the saved interface identifier for the user. See the Framed-Interface-Id section in RFC
    ///3162 for more information.
    PROPERTY_USER_SAVED_RADIUS_FRAMED_INTERFACE_ID = 0x0000040d,
    ///Specifies an IPv6 prefix (and corresponding route) to be configured for the user. See the Framed-IPv6-Prefix
    ///section in RFC 3162 for more information.
    PROPERTY_USER_RADIUS_FRAMED_IPV6_PREFIX        = 0x0000040e,
    ///Specifies an IPv6 prefix (and corresponding route) saved for the user. See the Framed-IPv6-Prefix section in RFC
    ///3162 for more information.
    PROPERTY_USER_SAVED_RADIUS_FRAMED_IPV6_PREFIX  = 0x0000040f,
}

///The values of the <b>DICTIONARYPROPERTIES</b> properties type enumerate properties associated with the attribute
///dictionary.
alias DICTIONARYPROPERTIES = int;
enum : int
{
    ///The collection of all possible attributes.
    PROPERTY_DICTIONARY_ATTRIBUTES_COLLECTION = 0x00000400,
    ///The location of the datastore that contains the dictionary. This property is read-only.
    PROPERTY_DICTIONARY_LOCATION              = 0x00000401,
}

///The values of the <b>ATTRIBUTEPROPERTIES</b> type enumerate properties for a RADIUS dictionary attribute.
alias ATTRIBUTEPROPERTIES = int;
enum : int
{
    ///The ID of the attribute.
    PROPERTY_ATTRIBUTE_ID                       = 0x00000400,
    ///The vendor ID for Vendor Specific Attributes (VSA).
    PROPERTY_ATTRIBUTE_VENDOR_ID                = 0x00000401,
    ///The vendor-specific type ID for Vendor Specific Attributes (VSA).
    PROPERTY_ATTRIBUTE_VENDOR_TYPE_ID           = 0x00000402,
    ///Specifies whether the attribute is enumerable.
    PROPERTY_ATTRIBUTE_IS_ENUMERABLE            = 0x00000403,
    ///The IDs for an enumerable attribute.
    PROPERTY_ATTRIBUTE_ENUM_NAMES               = 0x00000404,
    ///The values for an enumerable attribute.
    PROPERTY_ATTRIBUTE_ENUM_VALUES              = 0x00000405,
    ///Specifies the syntax of the attribute.
    PROPERTY_ATTRIBUTE_SYNTAX                   = 0x00000406,
    ///Specifies whether multiple instances of this attribute are allowed.
    PROPERTY_ATTRIBUTE_ALLOW_MULTIPLE           = 0x00000407,
    ///Specifies the Open Database Connectivity (ODBC) ordinal.
    PROPERTY_ATTRIBUTE_ALLOW_LOG_ORDINAL        = 0x00000408,
    ///Specifies whether this attribute is allowed in the profile for a Network Access Policy (NAP).
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROFILE         = 0x00000409,
    ///Specifies whether this attribute is allowed in a condition for a Network Access Policy (NAP).
    PROPERTY_ATTRIBUTE_ALLOW_IN_CONDITION       = 0x0000040a,
    ///The display name for the attribute.
    PROPERTY_ATTRIBUTE_DISPLAY_NAME             = 0x0000040b,
    ///Specifies the value for the attribute.
    PROPERTY_ATTRIBUTE_VALUE                    = 0x0000040c,
    ///Specifies whether the attribute is allowed in an NAP profile for a network request proxy.
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_PROFILE   = 0x0000040d,
    ///Specifies whether the attribute is allowed in an NAP condition for a network request proxy.
    PROPERTY_ATTRIBUTE_ALLOW_IN_PROXY_CONDITION = 0x0000040e,
    ///Used by NPS user interface to mark whether an attribute is used in profiles for VPN scenario.
    PROPERTY_ATTRIBUTE_ALLOW_IN_VPNDIALUP       = 0x0000040f,
    ///Used by NPS user interface to mark whether an attribute is used in profiles for 802.1X scenario.
    PROPERTY_ATTRIBUTE_ALLOW_IN_8021X           = 0x00000410,
    ///Used by filter configuration attributes MS_ATTRIBUTE_FILTER and MS_ATTRIBUTE_QUARANTINE_IPFILTER. See MS-Filter
    ///section in RFC 2548 for more information.
    PROPERTY_ATTRIBUTE_ENUM_FILTERS             = 0x00000411,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///values of the <b>IASPROPERTIES</b> enumeration type enumerate properties related to NPS.
alias IASPROPERTIES = int;
enum : int
{
    ///The collection of RADIUS server groups.
    PROPERTY_IAS_RADIUSSERVERGROUPS_COLLECTION      = 0x00000400,
    ///The collection of Network Access Policies (NAP).
    PROPERTY_IAS_POLICIES_COLLECTION                = 0x00000401,
    ///The collection of profiles for the network access policies.
    PROPERTY_IAS_PROFILES_COLLECTION                = 0x00000402,
    ///The collection of protocols used by NPS.
    PROPERTY_IAS_PROTOCOLS_COLLECTION               = 0x00000403,
    ///The collection of auditors used by NPS.
    PROPERTY_IAS_AUDITORS_COLLECTION                = 0x00000404,
    ///The collection of request handlers used by NPS.
    PROPERTY_IAS_REQUESTHANDLERS_COLLECTION         = 0x00000405,
    ///The collection of Network Access Policies for connection request processing.
    PROPERTY_IAS_PROXYPOLICIES_COLLECTION           = 0x00000406,
    ///The collection of profiles for connection request processing.
    PROPERTY_IAS_PROXYPROFILES_COLLECTION           = 0x00000407,
    ///Used by the Remediation Server settings of NPS user interface.
    PROPERTY_IAS_REMEDIATIONSERVERGROUPS_COLLECTION = 0x00000408,
    ///Used by the System Health Validator Template settings of NPS user interface.
    PROPERTY_IAS_SHVTEMPLATES_COLLECTION            = 0x00000409,
}

alias TEMPLATESPROPERTIES = int;
enum : int
{
    PROPERTY_TEMPLATES_POLICIES_TEMPLATES                = 0x00000400,
    PROPERTY_TEMPLATES_PROFILES_TEMPLATES                = 0x00000401,
    PROPERTY_TEMPLATES_PROFILES_COLLECTION               = 0x00000402,
    PROPERTY_TEMPLATES_PROXYPOLICIES_TEMPLATES           = 0x00000403,
    PROPERTY_TEMPLATES_PROXYPROFILES_TEMPLATES           = 0x00000404,
    PROPERTY_TEMPLATES_PROXYPROFILES_COLLECTION          = 0x00000405,
    PROPERTY_TEMPLATES_REMEDIATIONSERVERGROUPS_TEMPLATES = 0x00000406,
    PROPERTY_TEMPLATES_SHVTEMPLATES_TEMPLATES            = 0x00000407,
    PROPERTY_TEMPLATES_CLIENTS_TEMPLATES                 = 0x00000408,
    PROPERTY_TEMPLATES_RADIUSSERVERS_TEMPLATES           = 0x00000409,
    PROPERTY_TEMPLATES_SHAREDSECRETS_TEMPLATES           = 0x0000040a,
    PROPERTY_TEMPLATES_IPFILTERS_TEMPLATES               = 0x0000040b,
}

///The values of the <b>CLIENTPROPERTIES</b> type enumerate the properties of a RADIUS client. The SDO computer is the
///RADIUS server.
alias CLIENTPROPERTIES = int;
enum : int
{
    ///Specifies whether the RADIUS server checks for a digital signature. <div class="alert"><b>Note</b> If client and
    ///server use Extensible Authentication Protocol (EAP), then they use digital signatures regardless of this
    ///property.</div> <div> </div>
    PROPERTY_CLIENT_REQUIRE_SIGNATURE     = 0x00000400,
    ///This value indicates that the property is not used at this time.
    PROPERTY_CLIENT_UNUSED                = 0x00000401,
    ///The secret shared by both the RADIUS client and RADIUS server.
    PROPERTY_CLIENT_SHARED_SECRET         = 0x00000402,
    ///The manufacturer of the Network Access Server (NAS), that is the RADIUS client.
    PROPERTY_CLIENT_NAS_MANUFACTURER      = 0x00000403,
    ///The IP address of the RADIUS client.
    PROPERTY_CLIENT_ADDRESS               = 0x00000404,
    ///Used by NPS user interface to indicate whether a RADIUS Client can receive NAP specific quarantine attributes.
    PROPERTY_CLIENT_QUARANTINE_COMPATIBLE = 0x00000405,
    ///Specifies if the RADIUS Client is enabled. If the RADIUS Client is not enabled, the configuration is present but
    ///it is not applied by NPS.
    PROPERTY_CLIENT_ENABLED               = 0x00000406,
    PROPERTY_CLIENT_SECRET_TEMPLATE_GUID  = 0x00000407,
}

///The values of the <b>VENDORPROPERTIES</b> enumeration type specify properties of objects in the vendors collection.
alias VENDORPROPERTIES = int;
enum : int
{
    ///The SMI Network Management Private Enterprise Code assigned to this vendor by the Internet Assigned Numbers
    ///Authority (IANA).
    PROPERTY_NAS_VENDOR_ID = 0x00000400,
}

///The <b>PROFILEPROPERTIES</b> enumeration type enumerates properties associated with a profile.
alias PROFILEPROPERTIES = int;
enum : int
{
    ///The attributes associated with the profile.
    PROPERTY_PROFILE_ATTRIBUTES_COLLECTION  = 0x00000400,
    PROPERTY_PROFILE_IPFILTER_TEMPLATE_GUID = 0x00000401,
}

///The values of the <b>POLICYPROPERTIES</b> enumeration type enumerate properties of a Network Access Policy (NAP).
alias POLICYPROPERTIES = int;
enum : int
{
    ///String that contains all the text of the conditions. Do not use this property to access the Conditions; use the
    ///<b>PROPERTY_POLICY_CONDITIONS_COLLECTION</b> instead.
    PROPERTY_POLICY_CONSTRAINT            = 0x00000400,
    ///Specifies the relative position of this policy with respect to other policies. In the UI, the upper-most policy
    ///in the UI has a merit value of 1, the next one down has a merit value of 2, and so on. You cannot set the merit
    ///value of a policy when you first create the object. A new policy object is always applied in the same merit
    ///location. To order your policies, create the policy object and set its values. Apply all the changes to the
    ///object, and then set the appropriate merit value and apply the changes.
    PROPERTY_POLICY_MERIT                 = 0x00000401,
    ///This property is reserved.
    PROPERTY_POLICY_UNUSED0               = 0x00000402,
    ///This property is reserved.
    PROPERTY_POLICY_UNUSED1               = 0x00000403,
    ///Specifies the profile name. This property is used by the system to associate the policy with the profile.
    PROPERTY_POLICY_PROFILE_NAME          = 0x00000404,
    ///Specifies the name of the profile associated with the policy. This property is not currently used. Use
    ///<b>PROPERTY_POLICY_PROFILE_NAME</b> instead.
    PROPERTY_POLICY_ACTION                = 0x00000405,
    ///Specifies the conditions for this network access policy.
    PROPERTY_POLICY_CONDITIONS_COLLECTION = 0x00000406,
    ///Used by NPS user interface in policy evaluation. If the policy is not enabled, its configuration is present but
    ///it is not applied.
    PROPERTY_POLICY_ENABLED               = 0x00000407,
    ///Used by NPS user interface to tag a set of policies to be applicable only for a specified kind of RADIUS client
    ///(or source). For example, a policy tagged by "DHCP Server."
    PROPERTY_POLICY_SOURCETAG             = 0x00000408,
}

///The values of the <b>CONDITIONPROPERTIES</b> enumeration type specify the properties of a Network Access Policy (NAP)
///condition.
alias CONDITIONPROPERTIES = int;
enum : int
{
    ///The text of the NAP condition.
    PROPERTY_CONDITION_TEXT = 0x00000400,
}

///The values in the <b>RADIUSSERVERGROUPPROPERTIES</b> enumeration type enumerate properties of a RADIUS server group.
alias RADIUSSERVERGROUPPROPERTIES = int;
enum : int
{
    ///The collection of servers in the RADIUS server group.
    PROPERTY_RADIUSSERVERGROUP_SERVERS_COLLECTION = 0x00000400,
}

///The values of the <b>RADIUSSERVERPROPERTIES</b> enumeration type enumerate the properties of the RADIUS server, that
///is the SDO computer.
alias RADIUSSERVERPROPERTIES = int;
enum : int
{
    ///Comma separated list of the UDP ports over which RADIUS authentication packets are sent and received.
    PROPERTY_RADIUSSERVER_AUTH_PORT                 = 0x00000400,
    ///The shared secret for authentication.
    PROPERTY_RADIUSSERVER_AUTH_SECRET               = 0x00000401,
    ///Comma separated list of the UDP ports over which RADIUS authentication packets are sent and received.
    PROPERTY_RADIUSSERVER_ACCT_PORT                 = 0x00000402,
    ///The shared secret for accounting.
    PROPERTY_RADIUSSERVER_ACCT_SECRET               = 0x00000403,
    ///The IP address of the server, or a DNS name that corresponds to the server.
    PROPERTY_RADIUSSERVER_ADDRESS                   = 0x00000404,
    ///Specifies whether to forward, that is proxy, accounting packets.
    PROPERTY_RADIUSSERVER_FORWARD_ACCT_ONOFF        = 0x00000405,
    ///Specifies the priority for server. Lower priorities have higher precedence.
    PROPERTY_RADIUSSERVER_PRIORITY                  = 0x00000406,
    ///Specifies the weight for the server. If two servers have the same priority, then weight is used to determine
    ///which server is used.
    PROPERTY_RADIUSSERVER_WEIGHT                    = 0x00000407,
    ///Specifies the timeout for the server.
    PROPERTY_RADIUSSERVER_TIMEOUT                   = 0x00000408,
    ///The number of packets that can be dropped in a row before the server is considered unavailable.
    PROPERTY_RADIUSSERVER_MAX_LOST                  = 0x00000409,
    ///Number of seconds that are waited before checking if an unavailable server is available again.
    PROPERTY_RADIUSSERVER_BLACKOUT                  = 0x0000040a,
    ///Specifies whether the Message-Authenticator attribute of RFC 3579 is sent by the server or not. It is always sent
    ///for EAP authentications.
    PROPERTY_RADIUSSERVER_SEND_SIGNATURE            = 0x0000040b,
    PROPERTY_RADIUSSERVER_AUTH_SECRET_TEMPLATE_GUID = 0x0000040c,
    PROPERTY_RADIUSSERVER_ACCT_SECRET_TEMPLATE_GUID = 0x0000040d,
}

///The values of the <b>REMEDIATIONSERVERGROUPPROPERTIES</b> enumeration type enumerate the properties of a remediation
///server group.
alias REMEDIATIONSERVERGROUPPROPERTIES = int;
enum : int
{
    ///The collection of servers in the remediation server group.
    PROPERTY_REMEDIATIONSERVERGROUP_SERVERS_COLLECTION = 0x00000400,
}

///The values of the <b>REMEDIATIONSERVERPROPERTIES</b> enumeration type enumerate the properties of a remediation
///server.
alias REMEDIATIONSERVERPROPERTIES = int;
enum : int
{
    ///IP address value for a Remediation Server. Used in Network Policy Server (NPS) user interface.
    PROPERTY_REMEDIATIONSERVER_ADDRESS       = 0x00000400,
    ///Host-name for a Remediation Server. Used in NPS user interface.
    PROPERTY_REMEDIATIONSERVER_FRIENDLY_NAME = 0x00000401,
}

///The values of the <b>SHVTEMPLATEPROPERTIES</b> enumeration type enumerate the properties of a System Health Validator
///(SHV) template.
alias SHVTEMPLATEPROPERTIES = int;
enum : int
{
    PROPERTY_SHV_COMBINATION_TYPE = 0x00000400,
    PROPERTY_SHV_LIST             = 0x00000401,
    PROPERTY_SHVCONFIG_LIST       = 0x00000402,
}

alias IPFILTERPROPERTIES = int;
enum : int
{
    PROPERTY_IPFILTER_ATTRIBUTES_COLLECTION = 0x00000400,
}

alias SHAREDSECRETPROPERTIES = int;
enum : int
{
    PROPERTY_SHAREDSECRET_STRING = 0x00000400,
}

///The values of the <b>IASCOMPONENTPROPERTIES</b> enumeration type enumerate identifiers for an SDO object.
alias IASCOMPONENTPROPERTIES = int;
enum : int
{
    ///The component ID for the SDO object.
    PROPERTY_COMPONENT_ID      = 0x00000400,
    ///The program ID for the SDO object.
    PROPERTY_COMPONENT_PROG_ID = 0x00000401,
    ///The start value for RADIUS Protocol properties, defined for convenience.
    PROPERTY_COMPONENT_START   = 0x00000402,
}

///The values of the <b>PROTOCOLPROPERTIES</b> enumeration type enumerate properties of an authentication protocol.
alias PROTOCOLPROPERTIES = int;
enum : int
{
    ///The value is reserved for system use.
    PROPERTY_PROTOCOL_REQUEST_HANDLER = 0x00000402,
    PROPERTY_PROTOCOL_START           = 0x00000403,
}

///The values of the <b>RADIUSPROPERTIES</b> enumeration type enumerate properties of the Microsoft RADIUS protocol SDO.
alias RADIUSPROPERTIES = int;
enum : int
{
    ///The TCP port used for RADIUS accounting.
    PROPERTY_RADIUS_ACCOUNTING_PORT     = 0x00000403,
    ///The TCP port used for RADIUS authentication.
    PROPERTY_RADIUS_AUTHENTICATION_PORT = 0x00000404,
    ///The collection of clients for this RADIUS server.
    PROPERTY_RADIUS_CLIENTS_COLLECTION  = 0x00000405,
    ///The collection of vendors for this RADIUS server.
    PROPERTY_RADIUS_VENDORS_COLLECTION  = 0x00000406,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///values of the <b>NTEVENTLOGPROPERTIES</b> enumeration type enumerate what types of events should be logged in the NT
///Event Log.
alias NTEVENTLOGPROPERTIES = int;
enum : int
{
    ///Specifies how the reporting of NPS Error events occurs in the Windows event log. In Windows XP, there is no UI
    ///element that corresponds to this property
    PROPERTY_EVENTLOG_LOG_APPLICATION_EVENTS = 0x00000402,
    ///Specifies whether discarded and rejected packets are logged.
    PROPERTY_EVENTLOG_LOG_MALFORMED          = 0x00000403,
    PROPERTY_EVENTLOG_LOG_DEBUG              = 0x00000404,
}

///The values of the <b>NAMESPROPERTIES</b> enumeration type enumerate properties related to the name of the user
///requesting network access.
alias NAMESPROPERTIES = int;
enum : int
{
    PROPERTY_NAMES_REALMS = 0x00000402,
}

///The values of the <b>NTSAMPROPERTIES</b> enumeration type specify properties related to the NT Security Accounts
///Manager (SAM).
alias NTSAMPROPERTIES = int;
enum : int
{
    PROPERTY_NTSAM_ALLOW_LM_AUTHENTICATION = 0x00000402,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///values of the <b>ACCOUNTINGPROPERTIES</b> type enumerate properties that control what types of packets are logged and
///characteristics of the log file.
alias ACCOUNTINGPROPERTIES = int;
enum : int
{
    ///Specifies whether accounting packets are logged.
    PROPERTY_ACCOUNTING_LOG_ACCOUNTING             = 0x00000402,
    ///Specifies whether interim accounting packets are logged.
    PROPERTY_ACCOUNTING_LOG_ACCOUNTING_INTERIM     = 0x00000403,
    ///Specifies whether authentication packets are logged.
    PROPERTY_ACCOUNTING_LOG_AUTHENTICATION         = 0x00000404,
    ///Specifies how frequently a new log file is created. This property takes a value from the NEW_LOG_FILE_FREQUENCY
    ///enumeration type.
    PROPERTY_ACCOUNTING_LOG_OPEN_NEW_FREQUENCY     = 0x00000405,
    ///Specifies a file size. The system creates a new log file if the current log file reaches this size, and the
    ///<b>PROPERTY_ACCOUNTING_LOG_OPEN_NEW_FREQUENCY</b> property is set to the value
    ///IAS_LOGGING_WHEN_FILE_SIZE_REACHES.
    PROPERTY_ACCOUNTING_LOG_OPEN_NEW_SIZE          = 0x00000406,
    ///The file-system path to the directory where the log file is located. This path does not include the filename. It
    ///also does not include a trailing backslash.
    PROPERTY_ACCOUNTING_LOG_FILE_DIRECTORY         = 0x00000407,
    ///Specifies whether the log should be in NPS format or database convertible format. This property can have the
    ///following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td>0 (<b>VARIANT_FALSE</b>)</td>
    ///<td>NPS Format</td> </tr> <tr> <td>0xFFFF (<b>VARIANT_TRUE</b>)</td> <td>Database Convertible Format</td> </tr>
    ///</table>
    PROPERTY_ACCOUNTING_LOG_IAS1_FORMAT            = 0x00000408,
    ///Not used.
    PROPERTY_ACCOUNTING_LOG_ENABLE_LOGGING         = 0x00000409,
    ///Causes the accounting log to be deleted when full.
    PROPERTY_ACCOUNTING_LOG_DELETE_IF_FULL         = 0x0000040a,
    ///Maximum number of concurrent SQL server sessions.
    PROPERTY_ACCOUNTING_SQL_MAX_SESSIONS           = 0x0000040b,
    ///Causes NPS to log interim access-request/access-challenge pairs for an EAP session. Otherwise, it only logs the
    ///final access-request/access-accept/reject.
    PROPERTY_ACCOUNTING_LOG_AUTHENTICATION_INTERIM = 0x0000040c,
    PROPERTY_ACCOUNTING_LOG_FILE_IS_BACKUP         = 0x0000040d,
    PROPERTY_ACCOUNTING_DISCARD_REQUEST_ON_FAILURE = 0x0000040e,
}

///The values of the <b>NAPPROPERTIES</b> enumeration type specify properties for Network Access Policies (NAP).
alias NAPPROPERTIES = int;
enum : int
{
    ///The network access policies collection.
    PROPERTY_NAP_POLICIES_COLLECTION  = 0x00000402,
    ///Collection of System Health Validator (SHV) templates. See NAP documentation for more information on SHV.
    PROPERTY_SHV_TEMPLATES_COLLECTION = 0x00000403,
}

///The values in the <b>RADIUSPROXYPROPERTIES</b> enumeration type enumerate properties related to the RADIUS proxy
///service.
alias RADIUSPROXYPROPERTIES = int;
enum : int
{
    ///The collection of RADIUS proxy server groups.
    PROPERTY_RADIUSPROXY_SERVERGROUPS = 0x00000402,
}

///The values of the <b>REMEDIATIONSERVERSPROPERTIES</b> enumeration type enumerate the properties of a set of
///remediation server groups.
alias REMEDIATIONSERVERSPROPERTIES = int;
enum : int
{
    PROPERTY_REMEDIATIONSERVERS_SERVERGROUPS = 0x00000402,
}

///The <b>SHV_COMBINATION_TYPE</b> enumeration type specifies the type of a System Health Validator (SHV) combination.
alias SHV_COMBINATION_TYPE = int;
enum : int
{
    SHV_COMBINATION_TYPE_ALL_PASS                 = 0x00000000,
    SHV_COMBINATION_TYPE_ALL_FAIL                 = 0x00000001,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_PASS         = 0x00000002,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_FAIL         = 0x00000003,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_INFECTED     = 0x00000004,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_TRANSITIONAL = 0x00000005,
    SHV_COMBINATION_TYPE_ONE_OR_MORE_UNKNOWN      = 0x00000006,
    ///Use this constant to test whether the value is in range.
    SHV_COMBINATION_TYPE_MAX                      = 0x00000007,
}

///The values of the <b>SERVICE_TYPE</b> enumeration type specify the type of service administered from the SDO API.
alias SERVICE_TYPE = int;
enum : int
{
    ///The service is Internet Authentication Service (IAS) or Network Policy Server (NPS). <div
    ///class="alert"><b>Note</b> Internet Authentication Service was renamed Network Policy Server starting with Windows
    ///Server 2008.</div> <div> </div>
    SERVICE_TYPE_IAS       = 0x00000000,
    ///The service is the Remote Access Service.
    SERVICE_TYPE_RAS       = 0x00000001,
    ///The service is the Remote Access Management Service.
    SERVICE_TYPE_RAMGMTSVC = 0x00000002,
    ///Use this constant to test whether the value is in range.
    SERVICE_TYPE_MAX       = 0x00000003,
}

///The values of the <b>IASOSTYPE</b> enumeration type specify what type of operating system the client requesting
///authentication (SDO computer) is running.
alias IASOSTYPE = int;
enum : int
{
    ///Not supported.
    SYSTEM_TYPE_NT4_WORKSTATION    = 0x00000000,
    ///Not supported.
    SYSTEM_TYPE_NT5_WORKSTATION    = 0x00000001,
    ///The SDO computer is running Windows Vista.
    SYSTEM_TYPE_NT6_WORKSTATION    = 0x00000002,
    SYSTEM_TYPE_NT6_1_WORKSTATION  = 0x00000003,
    SYSTEM_TYPE_NT6_2_WORKSTATION  = 0x00000004,
    SYSTEM_TYPE_NT6_3_WORKSTATION  = 0x00000005,
    SYSTEM_TYPE_NT10_0_WORKSTATION = 0x00000006,
    ///Not supported.
    SYSTEM_TYPE_NT4_SERVER         = 0x00000007,
    ///Not supported.
    SYSTEM_TYPE_NT5_SERVER         = 0x00000008,
    ///The SDO computer is running Windows Server 2008.
    SYSTEM_TYPE_NT6_SERVER         = 0x00000009,
    SYSTEM_TYPE_NT6_1_SERVER       = 0x0000000a,
    SYSTEM_TYPE_NT6_2_SERVER       = 0x0000000b,
    SYSTEM_TYPE_NT6_3_SERVER       = 0x0000000c,
    SYSTEM_TYPE_NT10_0_SERVER      = 0x0000000d,
}

///The values of the <b>IASDOMAINTYPE</b> enumeration type specify whether the SDO computer is part of a domain, and if
///so, what type of domain.
alias IASDOMAINTYPE = int;
enum : int
{
    ///The SDO computer is running in stand-alone mode.
    DOMAIN_TYPE_NONE  = 0x00000000,
    ///Not supported.
    DOMAIN_TYPE_NT4   = 0x00000001,
    ///The SDO computer is part of a Windows domain running in native mode.
    DOMAIN_TYPE_NT5   = 0x00000002,
    ///The SDO computer is part of a Windows domain running in mixed mode.
    DOMAIN_TYPE_MIXED = 0x00000003,
}

///The values of the <b>IASDATASTORE</b> enumeration indicate the possible storage locations for SDO data.
alias IASDATASTORE = int;
enum : int
{
    ///The SDO data is stored locally on the SDO computer.
    DATA_STORE_LOCAL     = 0x00000000,
    ///The SDO data is stored in the Active Directory.
    DATA_STORE_DIRECTORY = 0x00000001,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RADIUS_ATTRIBUTE_TYPE</b> type enumerates the possible types for a RADIUS attribute.
alias RADIUS_ATTRIBUTE_TYPE = int;
enum : int
{
    ///This value is equal to zero, and used as the null-terminator in any array of RADIUS_ATTRIBUTE structures.
    ratMinimum                = 0x00000000,
    ///Specifies the name of the user to be authenticated. The value field in RADIUS_ATTRIBUTE for this type is a
    ///pointer. See RFC 2865 for more information. Also see User Identification Attributes.
    ratUserName               = 0x00000001,
    ///Specifies the password of the user to be authenticated. The value field in RADIUS_ATTRIBUTE for this type is a
    ///pointer. See RFC 2865 for more information.
    ratUserPassword           = 0x00000002,
    ///Specifies the password provided by the user in response to an Challenge Handshake Authentication Protocol (CHAP)
    ///challenge. The value field in RADIUS_ATTRIBUTE for this type is a pointer. See RFC 2865 for more information.
    ratCHAPPassword           = 0x00000003,
    ///Specifies the NAS IP address. An Access-Request should specify either an NAS IP address or an NAS identifier. The
    ///value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more information.
    ratNASIPAddress           = 0x00000004,
    ///Identifies the physical or virtual private network (VPN) through which the user is connecting to the NAS. Note
    ///that this value is not a port number in the sense of TCP or UDP. The value field in RADIUS_ATTRIBUTE for this
    ///type is a 32-bit integral value. See RFC 2865 for more information.
    ratNASPort                = 0x00000005,
    ///Specifies the type of service the user has requested or the type of service to be provided. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more information.
    ratServiceType            = 0x00000006,
    ///Specifies the type of framed protocol to use for framed access, for example SLIP, PPP, or ARAP (AppleTalk Remote
    ///Access Protocol). The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for
    ///more information.
    ratFramedProtocol         = 0x00000007,
    ///Specifies the IP address that will be configured for the user requesting authentication. This attribute is
    ///typically returned by the authentication provider. However, the NAS may use it in an authentication request to
    ///specify a preferred IP address. The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See
    ///RFC 2865 for more information.
    ratFramedIPAddress        = 0x00000008,
    ///Specifies the IP network mask for a user that is a router to a network. The value field in RADIUS_ATTRIBUTE for
    ///this type is a 32-bit integral value. See RFC 2865 for more information.
    ratFramedIPNetmask        = 0x00000009,
    ///Specifies the routing method for a user that is a router to a network. The value field in RADIUS_ATTRIBUTE for
    ///this type is a 32-bit integral value. See RFC 2865 for more information.
    ratFramedRouting          = 0x0000000a,
    ///Identifies the filter list for the user requesting authentication. The value field in RADIUS_ATTRIBUTE for this
    ///type is a pointer. See RFC 2865 for more information.
    ratFilterId               = 0x0000000b,
    ///Specifies the Maximum Transmission Unit (MTU) for the user. This attribute is used in cases where the MTU is not
    ///negotiated through some other means, such as PPP. The value field in RADIUS_ATTRIBUTE for this type is a 32-bit
    ///integral value. See RFC 2865 for more information.
    ratFramedMTU              = 0x0000000c,
    ///Specifies a compression protocol to use for the connection. The value field in RADIUS_ATTRIBUTE for this type is
    ///a 32-bit integral value. See RFC 2865 for more information
    ratFramedCompression      = 0x0000000d,
    ///Specifies the system with which to connect the user. The value field in RADIUS_ATTRIBUTE for this type is a
    ///32-bit integral value. See RFC 2865 for more information.
    ratLoginIPHost            = 0x0000000e,
    ///Specifies the service to use to connect the user to the host specified by <b>ratLoginIPHost</b>. The value field
    ///in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more information.
    ratLoginService           = 0x0000000f,
    ///Specifies the port to which to connect the user. This attribute is present only if the <b>ratLoginService</b>
    ///attribute is present. The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865
    ///for more information.
    ratLoginPort              = 0x00000010,
    ///Specifies a message to display to the user. The value field in RADIUS_ATTRIBUTE for this type is a pointer. See
    ///RFC 2865 for more information.
    ratReplyMessage           = 0x00000012,
    ///Specifies a callback number. The value field in RADIUS_ATTRIBUTE for this type is a pointer. See RFC 2865 for
    ///more information.
    ratCallbackNumber         = 0x00000013,
    ///Identifies a location to callback. The value of this attribute is interpreted by the NAS. The value field in
    ///RADIUS_ATTRIBUTE for this type is a pointer. See RFC 2865 for more information.
    ratCallbackId             = 0x00000014,
    ///Provides routing information to configure on the NAS for the user. The value field in RADIUS_ATTRIBUTE for this
    ///type is a pointer. See RFC 2865 for more information.
    ratFramedRoute            = 0x00000016,
    ///Specifies the IPX network number to configure for the user. The value field in RADIUS_ATTRIBUTE for this type is
    ///a 32-bit integral value. See RFC 2865 for more information.
    ratFramedIPXNetwork       = 0x00000017,
    ///This attribute is included in Access-Challenge and Access-Accept communications between the server and the
    ///client. Please refer to RFC 2865 for detailed information about this value. The value field in RADIUS_ATTRIBUTE
    ///for this type is a pointer.
    ratState                  = 0x00000018,
    ///Specifies a value that is provided to the NAS by the authentication provider. The NAS should use this value when
    ///communicating with the accounting provider. The value field in RADIUS_ATTRIBUTE for this type is a pointer. See
    ///RFC 2865 for more information.
    ratClass                  = 0x00000019,
    ///Allows vendors to provide their own extended attributes. The value field in RADIUS_ATTRIBUTE for this type is a
    ///pointer. See RFC 2865 for more information.
    ratVendorSpecific         = 0x0000001a,
    ///Specifies the maximum number of seconds for which to provide service to the user. After this time, the session is
    ///terminated. The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more
    ///information.
    ratSessionTimeout         = 0x0000001b,
    ///Specifies the maximum number of consecutive seconds the session can be idle. If the idle time exceeds this value,
    ///the session is terminated. The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC
    ///2865 for more information.
    ratIdleTimeout            = 0x0000001c,
    ///Indicates what action the NAS should take when the specified service is completed. It is only used in
    ///Access-Accept packets. The value field in RADIUS_ATTRIBUTE for this type is 32-bit integral value. See RFC 2865
    ///for more information.
    ratTerminationAction      = 0x0000001d,
    ///Specifies the number that the user dialed to connect to the NAS. The value field in RADIUS_ATTRIBUTE for this
    ///type is a pointer. See RFC 2865 for more information.
    ratCalledStationId        = 0x0000001e,
    ///Specifies the number from which the user is calling. The value field in RADIUS_ATTRIBUTE for this type is a
    ///pointer. See RFC 2865 for more information.
    ratCallingStationId       = 0x0000001f,
    ///Specifies the NAS identifier. An Access-Request should specify either an NAS identifier or an NAS IP address. The
    ///value field in RADIUS_ATTRIBUTE for this type is a pointer. See RFC 2865 for more information.
    ratNASIdentifier          = 0x00000020,
    ///Specifies a value that a proxy server includes when forwarding an authentication request. The value field in
    ///RADIUS_ATTRIBUTE for this type is a pointer. See RFC 2865 for more information.
    ratProxyState             = 0x00000021,
    ///This attribute is not currently used for authentication on Windows. See RFC 2865 for more information.
    ratLoginLATService        = 0x00000022,
    ///This attribute is not currently used for authentication on Windows. See RFC 2865 for more information.
    ratLoginLATNode           = 0x00000023,
    ///This attribute is not currently used for authentication on Windows. See RFC 2865 for more information.
    ratLoginLATGroup          = 0x00000024,
    ///Specifies the AppleTalk network number for a user that is another router. The value field in RADIUS_ATTRIBUTE for
    ///this type is 32-bit integral value. See RFC 2865 for more information.
    ratFramedAppleTalkLink    = 0x00000025,
    ///Specifies the AppleTalk network number that the NAS should use to allocate an AppleTalk node for the user. This
    ///attribute is used only when the user is not another router. The value field in RADIUS_ATTRIBUTE for this type is
    ///a 32-bit integral value. See RFC 2865 for more information.
    ratFramedAppleTalkNetwork = 0x00000026,
    ///Specifies the AppleTalk default zone for the user. The value field in RADIUS_ATTRIBUTE for this type is a
    ///pointer. See RFC 2865 for more information.
    ratFramedAppleTalkZone    = 0x00000027,
    ///Specifies whether the accounting provider should start or stop accounting for the user. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctStatusType         = 0x00000028,
    ///Specifies the length of time that the client has been attempting to send the current request. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctDelayTime          = 0x00000029,
    ///Specifies the number of octets that have been received during the current accounting session. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctInputOctets        = 0x0000002a,
    ///Specifies the number of octets sent during the current accounting session. The value field in RADIUS_ATTRIBUTE
    ///for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctOutputOctets       = 0x0000002b,
    ///Specifies a value to enable the identification of matching start and stop records within a log file. The start
    ///and stop records are sent in the <b>ratAcctStatusType</b> attribute. The value field in RADIUS_ATTRIBUTE for this
    ///type is a pointer. See RFC 2866 for more information.
    ratAcctSessionId          = 0x0000002c,
    ///Specifies, to the accounting provider, how the user was authenticated. The value field in RADIUS_ATTRIBUTE for
    ///this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctAuthentic          = 0x0000002d,
    ///Specifies the number of seconds that have elapsed in the current accounting session. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctSessionTime        = 0x0000002e,
    ///Specifies the number of packets that have been received during the current accounting session. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctInputPackets       = 0x0000002f,
    ///Specifies the number of packets that have been sent during the current accounting session. The value field in
    ///RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2866 for more information.
    ratAcctOutputPackets      = 0x00000030,
    ///Specifies how the current accounting session was terminated. The value field in RADIUS_ATTRIBUTE for this type is
    ///a 32-bit integral value. See RFC 2866 for more information.
    ratAcctTerminationCause   = 0x00000031,
    ///Specifies the CHAP challenge sent by the NAS to a CHAP user. The value field in RADIUS_ATTRIBUTE for this type is
    ///a pointer. See RFC 2865 for more information.
    ratCHAPChallenge          = 0x0000003c,
    ///Specifies the type of the port through which the user is connecting, for example, asynchronous, ISDN, virtual.
    ///The value field in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more information.
    ratNASPortType            = 0x0000003d,
    ///Specifies the number of ports the NAS should make available to the user for multilink sessions. The value field
    ///in RADIUS_ATTRIBUTE for this type is a 32-bit integral value. See RFC 2865 for more information
    ratPortLimit              = 0x0000003e,
    ///Specifies either the tunneling protocol or protocols to be used (in the case of a tunnel initiator) or specifies
    ///the tunneling protocol in use (in the case of a tunnel terminator). See RFC 2868 for more information.
    ratTunnelType             = 0x00000040,
    ///Specifies the transport medium to use when creating a tunnel for protocols, such as L2TP, that can operate over
    ///multiple transports. See RFC 2868 for more information.
    ratMediumType             = 0x00000041,
    ///May contain a password to be used to authenticate to a remote server. It may only be included in an Access-Accept
    ///packet.
    ratTunnelPassword         = 0x00000045,
    ///Specifies the group ID for a particular tunneled session.
    ratTunnelPrivateGroupID   = 0x00000051,
    ///Specifies the IPv6 Address of the NAS that requests authentication of the user. It should be unique to the NAS
    ///within the scope of the RADIUS server. It is only used in an Access-Request packet. See the NAS-IPv6-Address
    ///section in RFC 3162 for more information.
    ratNASIPv6Address         = 0x0000005f,
    ///Specifies the IPv6 interface identifier to be configured for the user. It may be used in an Access-Accept packet.
    ///See the Framed-Interface-Id section in RFC 3162 for more information.
    ratFramedInterfaceId      = 0x00000060,
    ///Specifies an IPv6 prefix (and corresponding route) to be configured for the user. It may be used in an
    ///Access-Accept packet and can appear multiple times. See the Framed-IPv6-Prefix section in RFC 3162 for more
    ///information.
    ratFramedIPv6Prefix       = 0x00000061,
    ///Specifies the system with which to connect the user, when the ratLoginService attribute is included. It may be
    ///used in an Access-Accept packet. See the Login-IPv6-Host section in RFC 3162 for more information.
    ratLoginIPv6Host          = 0x00000062,
    ///Specifies routing information to be configured for the user on the NAS. It is used in an Access-Accept packet and
    ///can appear multiple times. See the Framed-IPv6-Route section in RFC 3162 for more information.
    ratFramedIPv6Route        = 0x00000063,
    ///Specifies the name of an assigned pool that should be used to assign an IPv6 prefix for the user. If a NAS does
    ///not support multiple prefix pools, the NAS must ignore this attribute. See the Framed-IPv6-Pool section in RFC
    ///3162 for more information.
    ratFramedIPv6Pool         = 0x00000064,
    ///Specifies the request type code. This is an extended, read-only attribute, used only in the
    ///RadiusExtensionProcess and RadiusExtensionProcessEx functions. Its contents can be interpreted by comparing it
    ///with RADIUS_CODE enumeration values.
    ratCode                   = 0x00000106,
    ///Specifies the request identifier. This is an extended, read-only attribute.
    ratIdentifier             = 0x00000107,
    ///Specifies the request authenticator. This is an extended, read-only attribute.
    ratAuthenticator          = 0x00000108,
    ///Specifies the source IP address. This is an extended, read-only attribute.
    ratSrcIPAddress           = 0x00000109,
    ///Specifies the source IP port. This is an extended, read-only attribute.
    ratSrcPort                = 0x0000010a,
    ///Specifies the authentication provider. The value for this attribute is taken from the
    ///RADIUS_AUTHENTICATION_PROVIDER enumerated type. This is an extended, read-only attribute.
    ratProvider               = 0x0000010b,
    ///Specifies the user name with the realm removed. See User Identification Attributes for more information. This is
    ///an extended attribute.
    ratStrippedUserName       = 0x0000010c,
    ///Specifies the fully qualified user name. See User Identification Attributes for more information. This is an
    ///extended attribute.
    ratFQUserName             = 0x0000010d,
    ///Specifies a remote access policy name. This is an extended attribute.
    ratPolicyName             = 0x0000010e,
    ///Specifies a unique ID for the request. This is a read-only attribute.
    ratUniqueId               = 0x0000010f,
    ///This attribute is used to pass state information between extensions.
    ratExtensionState         = 0x00000110,
    ///Specifies an EAP-TLV packet. For more information about the EAP-TLV packet format, see IETF EAP Working Draft.
    ratEAPTLV                 = 0x00000111,
    ///Specifies the reason code for a RADIUS Reject. For more information, see RADIUS_REJECT_REASON_CODE.
    ratRejectReasonCode       = 0x00000112,
    ///Specifies the Connection Request Policy Name that matched this RADIUS packet.
    ratCRPPolicyName          = 0x00000113,
    ///Specifies the remote RADIUS server group name for request forwarding. If the Authentication indicated by
    ///<b>ratProvider</b> is a proxy, the extension DLL can change the <b>ratProviderName</b> to indicate which remote
    ///server group the request should be forwarded to.
    ratProviderName           = 0x00000114,
    ///Specifies the user password in clear text. To support authorization databases using PEAP-MSChapv2, the extension
    ///DLL retrieves the user password from the database and sends it to NPS.
    ratClearTextPassword      = 0x00000115,
    ///Source IPv6 address. It is not a standard RADIUS attribute. It corresponds to the internal attribute
    ///IAS_ATTRIBUTE_CLIENT_IPv6_ADDRESS. This is a read-only attribute.
    ratSrcIPv6Address         = 0x00000116,
    ratCertificateThumbprint  = 0x00000117,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_CODE</b> enumeration type enumerates the possible RADIUS packet codes.
alias RADIUS_CODE = int;
enum : int
{
    ///The packet type is unrecognized. This is used to indicate that the disposition of a request is not being set by
    ///this extension DLL.
    rcUnknown            = 0x00000000,
    ///RADIUS Access-Request packet. See RFC 2865 for more information.
    rcAccessRequest      = 0x00000001,
    ///RADIUS Access-Accept packet. See RFC 2865 for more information.
    rcAccessAccept       = 0x00000002,
    ///RADIUS Access-Reject packet. See RFC 2865 for more information.
    rcAccessReject       = 0x00000003,
    ///RADIUS Accounting-Request packet. See RFC 2866 for more information.
    rcAccountingRequest  = 0x00000004,
    ///RADIUS Accounting-Response packet. See RFC 2866 for more information.
    rcAccountingResponse = 0x00000005,
    ///RADIUS Access-Challenge packet. See RFC 2865 for more information.
    rcAccessChallenge    = 0x0000000b,
    ///The packet was discarded.
    rcDiscard            = 0x00000100,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RADIUS_AUTHENTICATION_PROVIDER</b> type enumerates the possible authentication providers that NPS can use.
alias RADIUS_AUTHENTICATION_PROVIDER = int;
enum : int
{
    ///The authentication provider is unknown.
    rapUnknown   = 0x00000000,
    ///A users' file provides the authentication information.
    rapUsersFile = 0x00000001,
    ///Authentication is provided by a RADIUS proxy server.
    rapProxy     = 0x00000002,
    ///Authentication is provided by Windows Domain Authentication.
    rapWindowsNT = 0x00000003,
    ///Authentication is provided by a Microsoft Commercial Internet System (MCIS) database.
    rapMCIS      = 0x00000004,
    ///Authentication is provided by an Open Database Connectivity (ODBC) compliant database.
    rapODBC      = 0x00000005,
    ///Access is unauthenticated.
    rapNone      = 0x00000006,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_REJECT_REASON_CODE</b> enumeration defines the possible RADIUS packet reject codes.
alias RADIUS_REJECT_REASON_CODE = int;
enum : int
{
    ///Reason code undefined.
    rrrcUndefined             = 0x00000000,
    ///The authentication attempt is using a user name that does not correspond to any known account.
    rrrcAccountUnknown        = 0x00000001,
    ///The authentication attempt is using a user name that corresponds to an account that has been disabled by an
    ///administrator.
    rrrcAccountDisabled       = 0x00000002,
    ///The authentication attempt is using a user name that corresponds to an account that has expired, either by
    ///exceeding its natural expiration lifetime or by administrative action.
    rrrcAccountExpired        = 0x00000003,
    ///The authentication process has failed; possibly due to incorrect credentials.
    rrrcAuthenticationFailure = 0x00000004,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_DATA_TYPE</b> type enumerates the possible data type for a RADIUS attribute or extended attribute.
alias RADIUS_DATA_TYPE = int;
enum : int
{
    ///The value is a pointer to an unknown data type.
    rdtUnknown     = 0x00000000,
    ///The value of the attribute is a pointer to a character string.
    rdtString      = 0x00000001,
    ///The value of the attribute is a 32-bit <b>DWORD</b> value that represents an address.
    rdtAddress     = 0x00000002,
    ///The value of the attribute is a 32-bit <b>DWORD</b> value that represents an integer.
    rdtInteger     = 0x00000003,
    ///The value of the attribute is a 32-bit <b>DWORD</b> value that represents a time.
    rdtTime        = 0x00000004,
    ///The value of the attribute is a <b>BYTE*</b> value that represents an IPv6 address.
    rdtIpv6Address = 0x00000005,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RADIUS_ACTION</b> type enumerates the responses that a NPS Extension DLL can generate in response to an
///Access-Request.
alias RADIUS_ACTION = int;
enum : int
{
    ///NPS continues to process the request. NPS also continues to call RadiusExtensionProcess in other Extension DLLs.
    raContinue = 0x00000000,
    ///Return an Access-Reject packet. The Access-Request is declined. In this case, NPS does not call
    ///RadiusExtensionProcess in any other Extension DLLs.
    raReject   = 0x00000001,
    ///NPS accepts the Access-Request. NPS does not continue to call RadiusExtensionProcess in this case. However, it
    ///does continue to obtain authorizations for the user requesting access.
    raAccept   = 0x00000002,
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_EXTENSION_POINT</b> enumeration type enumerates the possible points in the RADIUS request process when the
///RadiusExtensionProcess2 function can be called.
alias RADIUS_EXTENSION_POINT = int;
enum : int
{
    ///Indicates that the RadiusExtensionProcess2 function is called at the point in the request process where
    ///authentication occurs.
    repAuthentication = 0x00000000,
    ///Indicates that the RadiusExtensionProcess2 function is called at the point in the request process where
    ///authorization occurs.
    repAuthorization  = 0x00000001,
}

// Callbacks

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RadiusExtensionInit</b> function is an application-defined function and is called by NPS while the service is
///starting up. Use <b>RadiusExtensionInit</b> to perform any initialization operations for the Extension DLL.
///Params:
///    Arg1 = 
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value should be
///    an appropriate error code from WinError.h.
///    
alias PRADIUS_EXTENSION_INIT = uint function();
///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RadiusExtensionTerm</b> function is an application-defined function and is called by NPS prior to unloading the
///Extension DLL. Use <b>RadiusExtensionTerm</b> to perform any clean-up operations for the Extension DLL.
///Params:
///    Arg1 = 
alias PRADIUS_EXTENSION_TERM = void function();
///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RadiusExtensionProcess</b> function is an application-defined function and is called by NPS for each
///authentication or accounting packet that NPS receives from the network access server (NAS).
///Params:
///    pAttrs = Pointer to an array of attributes from the request. The array is terminated by an attribute with
///             <b>dwAttrType</b> set to <b>ratMinimum</b>. These attributes should be treated as read-only; they should not be
///             modified by <b>RadiusExtensionProcess</b>. Also, these attributes should not be referenced in any way after
///             <b>RadiusExtensionProcess</b> returns.
///    pfAction = Pointer to a value of type RADIUS_ACTION, initially set to <b>raContinue</b>. This parameter specifies the action
///               that NPS should take in response to an Access-Request.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value should be
///    an appropriate error code from Winerror.h.
///    
alias PRADIUS_EXTENSION_PROCESS = uint function(const(RADIUS_ATTRIBUTE)* pAttrs, RADIUS_ACTION* pfAction);
///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<i>RadiusExtensionProcessEx</i> function is an application-defined function and is called by NPS for each
///authentication or accounting packet that NPS receives from the network access server (NAS). This function is similar
///to RadiusExtensionProcess. However, <i>RadiusExtensionProcessEx</i> enables the Extension DLL to append attributes to
///the authentication response.
///Params:
///    pInAttrs = Pointer to an array of attributes from the request. The array is terminated by an attribute with
///               <b>dwAttrType</b> set to <b>ratMinimum</b>. These attributes should be treated as read-only; they should not be
///               modified by <i>RadiusExtensionProcessEx</i>. Also, these attributes should not be referenced in any way after
///               <i>RadiusExtensionProcessEx</i> returns.
///    pOutAttrs = Pointer to an array of attributes provided by the NPS Extension DLL. The array is terminated by an attribute with
///                <b>dwAttrType</b> set to <b>ratMinimum</b>. NPS adds these attributes to the authentication response. The NPS
///                Extension DLL allocates the memory for the array of attributes. NPS calls RadiusExtensionFreeAttributes to free
///                the memory occupied by the array of attributes.
///    pfAction = Pointer to a value of type RADIUS_ACTION, initially set to <b>raContinue</b>. This parameter specifies the action
///               that NPS should take in response to an Access-Request.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value should be
///    an appropriate error code from WinError.h.
///    
alias PRADIUS_EXTENSION_PROCESS_EX = uint function(const(RADIUS_ATTRIBUTE)* pInAttrs, RADIUS_ATTRIBUTE** pOutAttrs, 
                                                   RADIUS_ACTION* pfAction);
///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RadiusExtensionFreeAttributes</b> function is an application-defined function and is called by NPS to free the
///memory occupied by attributes returned by RadiusExtensionProcessEx.
///Params:
///    pAttrs = Pointer to an array of attributes. The <b>RadiusExtensionFreeAttributes</b> function should deallocate the memory
///             occupied by these attributes. These attributes were returned in the <i>pOutAttrs</i> parameter in a previous call
///             to the RadiusExtensionProcessEx function.
alias PRADIUS_EXTENSION_FREE_ATTRIBUTES = void function(RADIUS_ATTRIBUTE* pAttrs);
///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<i>RadiusExtensionProcess2</i> function is an application defined-function and is called by NPS for each
///authentication or accounting packet that NPS receives from the network access server (NAS). This function is similar
///to RadiusExtensionProcess. However, <i>RadiusExtensionProcess2</i> enables an Extension DLL to add, modify, and
///remove attributes to and from the authentication request or response.
///Params:
///    pECB = Pointer to a RADIUS_EXTENSION_CONTROL_BLOCK structure. The members of this structure contain values and function
///           pointers that enable the NPS Extension DLL to process the RADIUS packet.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. If the function fails, the return value should be
///    an appropriate error code from WinError.h.
///    
alias PRADIUS_EXTENSION_PROCESS_2 = uint function(RADIUS_EXTENSION_CONTROL_BLOCK* pECB);

// Structs


///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_ATTRIBUTE</b> structure represents a RADIUS attribute or an extended attribute.
struct RADIUS_ATTRIBUTE
{
    ///Stores a value from the RADIUS_ATTRIBUTE_TYPE enumeration. This value specifies the type of the attribute
    ///represented by the <b>RADIUS_ATTRIBUTE</b> structure.
    uint             dwAttrType;
    ///Stores a value from the RADIUS_DATA_TYPE enumeration. This value specifies the type of the value stored in the
    ///union that contains the <b>dwValue</b> and <b>lpValue</b> members.
    RADIUS_DATA_TYPE fDataType;
    ///Stores the length, in bytes, of the data. The <b>cbDataLength</b> member is used only if <b>lpValue</b> member is
    ///used.
    uint             cbDataLength;
    union
    {
        uint          dwValue;
        const(ubyte)* lpValue;
    }
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS.</div><div> </div>The
///<b>RADIUS_VSA_FORMAT</b> structure represents the format of the string portion of a RADIUS vendor-specific attribute.
struct RADIUS_VSA_FORMAT
{
    ///The SMI Network Management Private Enterprise Code of the vendor for this attribute.
    ubyte[4] VendorId;
    ///Numeric identifier for the attribute assigned by the vendor.
    ubyte    VendorType;
    ///The combined size of the <b>VendorType</b>, <b>VendorLength</b>, <b>AttributeSpecific</b> members.
    ubyte    VendorLength;
    ///Array of bytes that contains information for this attribute.
    ubyte[1] AttributeSpecific;
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RADIUS_ATTRIBUTE_ARRAY</b> structure represents an array of attributes.
struct RADIUS_ATTRIBUTE_ARRAY
{
    ///Specifies the size of the structure.
    uint             cbSize;
    ///Pointer to the Add function provided by NPS. NPS sets the value of the member.
    ptrdiff_t        Add;
    ///Pointer to the AttributeAt function provided by NPS. NPS sets the value of the member. The AttributeAt function
    ///returns a const pointer to the specified attribute within the array.
    const(ptrdiff_t) AttributeAt;
    ///Pointer to the GetSize function provided by NPS. NPS sets the value of the member. The GetSize function returns
    ///the size of the attribute array. The GetSize function returns the size of the attribute array, not the largest
    ///index. Because attribute arrays use zero-based indexes, the size of the array is one greater than the largest
    ///index.
    ptrdiff_t        GetSize;
    ///Pointer to the InsertAt function provided by NPS. NPS sets the value of the member. The InsertAt function inserts
    ///the specified attribute at the specified index in the array. When the InsertAt function inserts a new attribute
    ///into the array, it increments the index of the pre-existing attribute at this index. Similarly, it increments the
    ///index of any pre-existing attributes at higher indexes. To append an attribute to the end of the attribute array,
    ///use the Add function.
    ptrdiff_t        InsertAt;
    ///Pointer to the RemoveAt function provided by NPS. NPS sets the value of the member. The RemoveAt function removes
    ///the attribute at the specified index in the array. When the RemoveAt function removes an attribute from the
    ///array, it decrements the index of any pre-existing attributes at higher indexes.
    ptrdiff_t        RemoveAt;
    ///Pointer to the SetAt function provided by NPS. NPS sets the value of the member. The SetAt function replaces the
    ///attribute at the specified index with the specified attribute.
    ptrdiff_t        SetAt;
}

///<div class="alert"><b>Note</b> Internet Authentication Service (IAS) was renamed Network Policy Server (NPS) starting
///with Windows Server 2008. The content of this topic applies to both IAS and NPS. Throughout the text, NPS is used to
///refer to all versions of the service, including the versions originally referred to as IAS.</div><div> </div>The
///<b>RADIUS_EXTENSION_CONTROL_BLOCK</b> structure provides information about the current RADIUS request. It also
///provides functions for obtaining the attributes associated with the request, and for setting the disposition of the
///request.
struct RADIUS_EXTENSION_CONTROL_BLOCK
{
    ///Specifies the size of the structure.
    uint        cbSize;
    ///Specifies the version of the structure.
    uint        dwVersion;
    ///Specifies a value of type RADIUS_EXTENSION_POINT that indicates at what point in the request process
    ///RadiusExtensionProcess2 was called.
    RADIUS_EXTENSION_POINT repPoint;
    ///Specifies a value of type RADIUS_CODE that specifies the type of RADIUS request received by the Internet
    ///Authentication Service server.
    RADIUS_CODE rcRequestType;
    ///Specifies a value of type RADIUS_CODE that indicates the disposition of the RADIUS request.
    RADIUS_CODE rcResponseType;
    ///Pointer to the GetRequest function provided by NPS. NPS sets the value of this member. The GetRequest function
    ///returns the attributes received in the RADIUS request process and any internal attributes describing the request
    ///state. The Extension DLL can modify the attributes in the RADIUS request. For example, if NPS is acting as a
    ///RADIUS proxy, an Extension DLL could filter which attributes are forwarded to the remote RADIUS server. To modify
    ///the attributes, the Extension DLL uses the functions provided as members of the RADIUS_ATTRIBUTE_ARRAY structure.
    ptrdiff_t   GetRequest;
    ///Pointer to the GetResponse function provided by NPS. NPS sets the value of this member. The GetRequest function
    ///returns the attributes received in the RADIUS request process and any internal attributes describing the request
    ///state. An Extension DLL can use GetResponse to retrieve and modify the attributes for any valid response type
    ///regardless of the request's current disposition. For example, an Extension DLL could set the response type to
    ///rcAccessAccept, but still add attributes to those returned in the case of an rcAccessReject. The response
    ///specified by the Extension DLL (rcAccessAccept in this example) could be overridden during further processing. To
    ///modify the attributes, the Extension DLL uses the functions provided as members of the RADIUS_ATTRIBUTE_ARRAY
    ///structure.
    ptrdiff_t   GetResponse;
    ///Pointer to the SetResponseType function provided by NPS. NPS sets the value of this member. The SetResponseType
    ///function sets the final disposition of the request. Note that the disposition set by the Extension DLL can be
    ///overridden during further processing. For example, the Extension DLL may set the response type to
    ///<b>rcAccessAccept</b>, but during further processing, the response can be changed to <b>rcAccessReject</b>.
    ptrdiff_t   SetResponseType;
}

// Interfaces

@GUID("E9218AE7-9E91-11D1-BF60-0080C7846BC0")
struct SdoMachine;

///Use the <b>ISdoMachine</b> interface to attach to an SDO computer, obtain information about the SDO computer, and
///obtain interfaces to other SDO objects.
@GUID("479F6E75-49A2-11D2-8ECA-00C04FC2F519")
interface ISdoMachine : IDispatch
{
    ///The <b>Attach</b> method attaches to an SDO computer. Attaching to an SDO computer is the first step is using the
    ///SDO API to administer that computer.
    ///Params:
    ///    bstrComputerName = Specifies a BSTR variable that contains the name of the computer to which to attach. If this parameter
    ///                       specifies a <b>NULL</b> string, the local computer is attached.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If a computer is already attached, the return value
    ///    is <b>E_FAIL</b>. The method may also return one of the following error codes.
    ///    
    HRESULT Attach(BSTR bstrComputerName);
    ///The <b>GetDictionarySDO</b> method retrieves an interface for an attribute-dictionary SDO.
    ///Params:
    ///    ppDictionarySDO = Pointer to an ISdoDictionary.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetDictionarySDO(IUnknown* ppDictionarySDO);
    ///The <b>GetServiceSDO</b> method retrieves a Server Data Object (SDO) for the specified service.
    ///Params:
    ///    eDataStore = Specifies a value from the IASDATASTORE enumeration type.
    ///    bstrServiceName = Specifies a BSTR that contains the service name. This parameter is one of the following values.
    ///    ppServiceSDO = Pointer to a pointer that points to an IUnknown interface pointer. Use the QueryInterface method of this
    ///                   <b>IUnknown</b> interface to obtain an IDispatch interface for the ISdoServiceControl object.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetServiceSDO(IASDATASTORE eDataStore, BSTR bstrServiceName, IUnknown* ppServiceSDO);
    ///The <b>GetUserSDO</b> method retrieves an interface to the Server Data Object (SDO) for the specified user.
    ///Params:
    ///    eDataStore = Specifies a value from the IASDATASTORE enumeration type.
    ///    bstrUserName = Specifies a BSTR that contains the name of the user. The name can be in Lightweight Directory Access Protocol
    ///                   (LDAP) format, or in Security Accounts Manager (SAM) format.
    ///    ppUserSDO = Pointer to a pointer that points to an IUnknown interface pointer. Use the QueryInterface method of this
    ///                <b>IUnknown</b> interface to obtain an IDispatch interface to an ISdo object for the specified user.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetUserSDO(IASDATASTORE eDataStore, BSTR bstrUserName, IUnknown* ppUserSDO);
    ///The <b>GetOSType</b> method retrieves the type of operating system running on the SDO computer.
    ///Params:
    ///    eOSType = Pointer to an IASOSTYPE variable that receives the type of the operating system on the SDO computer.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetOSType(IASOSTYPE* eOSType);
    ///The <b>GetDomainType</b> retrieves the type of domain in which the SDO computer resides.
    ///Params:
    ///    eDomainType = Pointer to an IASDOMAINTYPE variable that receives the type of the domain in which the SDO computer resides.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetDomainType(IASDOMAINTYPE* eDomainType);
    ///The <b>IsDirectoryAvailable</b> method tests whether an Active Directory service is available on the SDO
    ///computer.
    ///Params:
    ///    boolDirectoryAvailable = Specifies whether the Active Directory is available. If the Active Directory is available, this parameter is
    ///                             <b>TRUE</b>. Otherwise, it is <b>FALSE</b>.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT IsDirectoryAvailable(short* boolDirectoryAvailable);
    ///The <b>GetAttachedComputer</b> method retrieves the name of the computer that is currently attached as an SDO
    ///computer.
    ///Params:
    ///    bstrComputerName = Pointer to a BSTR that receives the name of the computer that is the currently-attached SDO computer.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If no computer is currently attached, the return
    ///    value is <b>E_FAIL</b>. The method may also return one of the following error codes.
    ///    
    HRESULT GetAttachedComputer(BSTR* bstrComputerName);
    HRESULT GetSDOSchema(IUnknown* ppSDOSchema);
}

@GUID("518E5FFE-D8CE-4F7E-A5DB-B40A35419D3B")
interface ISdoMachine2 : ISdoMachine
{
    HRESULT GetTemplatesSDO(BSTR bstrServiceName, IUnknown* ppTemplatesSDO);
    HRESULT EnableTemplates();
    HRESULT SyncConfigAgainstTemplates(BSTR bstrServiceName, IUnknown* ppConfigRoot, IUnknown* ppTemplatesRoot, 
                                       short bForcedSync);
    HRESULT ImportRemoteTemplates(IUnknown pLocalTemplatesRoot, BSTR bstrRemoteMachineName);
    HRESULT Reload();
}

///Use the <b>ISdoServiceControl</b> interface to control the service being administered on the SDO computer.
@GUID("479F6E74-49A2-11D2-8ECA-00C04FC2F519")
interface ISdoServiceControl : IDispatch
{
    HRESULT StartServiceA();
    ///The <b>StopService</b> method shuts down the service administered through SDO.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT StopService();
    ///The <b>GetServiceStatus</b> method retrieves the status of the service being administered through SDO.
    ///Params:
    ///    status = Pointer to a <b>LONG</b> variable that contains the status of the service. The status is one of the following
    ///             values.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetServiceStatus(int* status);
    ///The <b>ResetService</b> method resets the service administered by the SDO API. Resetting the service causes the
    ///service to refresh its data.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT ResetService();
}

///Use the <b>ISdo</b> interface to store, retrieve, and update Server Data Objects (SDO) information.
@GUID("56BC53DE-96DB-11D1-BF3F-000000000000")
interface ISdo : IDispatch
{
    ///The <b>GetPropertyInfo</b> method retrieves a pointer to an <b>ISdoPropertyInfo</b> interface for the specified
    ///property. <b>Warning: </b>The <b>ISdoPropertyInfo</b> interface is unsupported and the use of this method to
    ///access it is discouraged.
    ///Params:
    ///    Id = Specifies the ID of an existing property.
    ///    ppPropertyInfo = Pointer to a pointer that receives the address of an <b>ISdoPropertyInfo</b> interface for the specified
    ///                     property.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetPropertyInfo(int Id, IUnknown* ppPropertyInfo);
    ///The <b>GetProperty</b> method retrieves the value of the specified property.
    ///Params:
    ///    Id = Specifies the ID of an existing property.
    ///    pValue = Pointer to a VARIANT that contains the value of the property.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetProperty(int Id, VARIANT* pValue);
    ///The <b>PutProperty</b> method sets the value of the specified property.
    ///Params:
    ///    Id = Specifies the ID of an existing property.
    ///    pValue = Pointer to a VARIANT that contains the value for that property.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT PutProperty(int Id, VARIANT* pValue);
    ///The <b>ResetProperty</b> method resets the specified property to its default value.
    ///Params:
    ///    Id = Specifies the ID of an existing property.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT ResetProperty(int Id);
    ///The <b>Apply</b> method writes to persistent storage the changes made by calls to the ISdo::PutProperty method.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Apply();
    ///The <b>Restore</b> method reloads the values of the Server Data Objects (SDO) properties from persistent storage.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Restore();
    ///The <b>get__NewEnum</b> method retrieves an IEnumVARIANT interface for the Server Data Objects (SDO) properties.
    ///Params:
    ///    ppEnumVARIANT = Pointer to a pointer that, on successful return, points to an IUnknown interface pointer. Use this
    ///                    <b>IUnknown</b> interface pointer with its QueryInterface method to obtain an IEnumVARIANT interface.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnumVARIANT);
}

///Use the <b>ISdoCollection</b> interface to manipulate a collection of SDO objects.
@GUID("56BC53E2-96DB-11D1-BF3F-000000000000")
interface ISdoCollection : IDispatch
{
    ///The <b>get_Count</b> method returns the number of items in the collection.
    ///Params:
    ///    pCount = Pointer to a <b>LONG</b> that contains the number of items in the collection.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT get_Count(int* pCount);
    ///The <b>Add</b> method adds an item to the Server Data Objects (SDO) collection.
    ///Params:
    ///    bstrName = Specifies the name of the SDO Object. This parameter may be <b>NULL</b>.
    ///    ppItem = Pointer to an <b>IDispatch</b> interface pointer for the Item to add. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Add(BSTR bstrName, IDispatch* ppItem);
    ///The <b>Remove</b> method removes the specified item from the collection.
    ///Params:
    ///    pItem = Pointer to an IDispatch interface that specifies the item to remove. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Remove(IDispatch pItem);
    ///The <b>RemoveAll</b> method removes all the items from the collection.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT RemoveAll();
    ///The <b>Reload</b> method reloads all the objects in the collection from the underlying datastore.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Reload();
    ///The <b>IsNameUnique</b> method tests whether the specified name is unique in the collection.
    ///Params:
    ///    bstrName = Specifies the name to test.
    ///    pBool = Pointer to a <b>VARIANT</b> that specifies whether the name is unique. The returned value is
    ///            <b>VARIANT_TRUE</b> if the name is unique, <b>VARIANT_FALSE</b> otherwise.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT IsNameUnique(BSTR bstrName, short* pBool);
    ///The <b>Item</b> method retrieves the specified item from the collection.
    ///Params:
    ///    Name = Pointer to a VARIANT. Store the name of the object in a BSTR in this <b>VARIANT</b>.
    ///    pItem = Pointer to an interface pointer that receives the address of an IDispatch interface for the object.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the object is not found in the collection, the
    ///    return value is <b>DISP_E_MEMBERNOTFOUND</b>. Otherwise, if the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT Item(VARIANT* Name, IDispatch* pItem);
    ///The <b>get__NewEnum</b> method retrieves an IEnumVARIANT interface for a Server Data Objects (SDO) collection.
    ///Params:
    ///    ppEnumVARIANT = Pointer to an IUnknown interface pointer. On successful return the <b>IUnknown</b> interface pointer, points
    ///                    to an IEnumVARIANT interface. This parameter must not be <b>NULL</b>.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnumVARIANT);
}

@GUID("8AA85302-D2E2-4E20-8B1F-A571E437D6C9")
interface ITemplateSdo : ISdo
{
    HRESULT AddToCollection(BSTR bstrName, IDispatch pCollection, IDispatch* ppItem);
    HRESULT AddToSdo(BSTR bstrName, IDispatch pSdoTarget, IDispatch* ppItem);
    HRESULT AddToSdoAsProperty(IDispatch pSdoTarget, int id);
}

///Use the <b>ISdoDictionaryOld</b> interface to manipulate the dictionary of Remote Access Dial-In User Service
///(RADIUS) attributes.
@GUID("D432E5F4-53D8-11D2-9A3A-00C04FB998AC")
interface ISdoDictionaryOld : IDispatch
{
    ///The <b>EnumAttributes</b> method retrieves the values of the specified attributes.
    ///Params:
    ///    Id = On input, a pointer to a VARIANT that specifies the attributes to enumerate. If the type of this
    ///         <b>VARIANT</b>, given by <b>V_VT</b>(Id), is <b>VT_EMPTY</b>, <b>ISdoDictionaryOld::EnumAttributes</b>
    ///         enumerates all the attributes. If the type is <b>VT_I4</b>, then the value of the <b>VARIANT</b> is the ID of
    ///         the attribute to enumerate. On output, pointer to a SAFEARRAY that contains the IDs of the enumerated
    ///         attributes.
    ///    pValues = Pointer to a SAFEARRAY that contains the values of the enumerated attributes.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT EnumAttributes(VARIANT* Id, VARIANT* pValues);
    ///The <b>GetAttributeInfo</b> retrieves information for the specified attribute.
    ///Params:
    ///    Id = Specifies the ID for the attribute.
    ///    pInfoIDs = Pointer to an array of information IDs. This pointer cannot be <b>NULL</b>.
    ///    pInfoValues = Pointer to a SAFEARRAY of information values.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT GetAttributeInfo(ATTRIBUTEID Id, VARIANT* pInfoIDs, VARIANT* pInfoValues);
    ///The <b>EnumAttributeValues</b> method retrieves the values for an enumerable attribute.
    ///Params:
    ///    Id = Specifies the ID of the attribute.
    ///    pValueIds = On successful return points to a SAFEARRAY of value IDs for the enumerable attribute. If the attribute is not
    ///                enumerable, points to a VT_EMPTY variant.
    ///    pValuesDesc = On successful return points to a SAFEARRAY of value descriptions for the enumerable attribute. If the
    ///                  attribute is not enumerable, points to a VT_EMPTY variant.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT EnumAttributeValues(ATTRIBUTEID Id, VARIANT* pValueIds, VARIANT* pValuesDesc);
    ///The <b>CreateAttribute</b> method creates a new attribute object and returns an IDispatch interface to it.
    ///Params:
    ///    Id = Specifies a value from the enumeration type ATTRIBUTEID. This value specifies the type of attribute to
    ///         create.
    ///    ppAttributeObject = Pointer to a pointer to an IDispatch interface pointer for the created attribute object.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method fails, the return value is one of the
    ///    following error codes.
    ///    
    HRESULT CreateAttribute(ATTRIBUTEID Id, IDispatch* ppAttributeObject);
    ///The <b>GetAttributeID</b> method retrieves the ID for the specified attribute.
    ///Params:
    ///    bstrAttributeName = Specifies the name of the attribute. This name is either the Lightweight Directory Access Protocol (LDAP)
    ///                        name, or the display name for the attribute.
    ///    pId = Pointer to an ATTRIBUTEID that receives the ID of the specified attribute.
    ///Returns:
    ///    If the method succeeds the return value is <b>S_OK</b>. If the method does not find the attribute, the return
    ///    value is <b>DISP_E_MEMBERNOTFOUND</b>. If the method fails, the return value is one of the following error
    ///    codes.
    ///    
    HRESULT GetAttributeID(BSTR bstrAttributeName, ATTRIBUTEID* pId);
}


// GUIDs

const GUID CLSID_SdoMachine = GUIDOF!SdoMachine;

const GUID IID_ISdo               = GUIDOF!ISdo;
const GUID IID_ISdoCollection     = GUIDOF!ISdoCollection;
const GUID IID_ISdoDictionaryOld  = GUIDOF!ISdoDictionaryOld;
const GUID IID_ISdoMachine        = GUIDOF!ISdoMachine;
const GUID IID_ISdoMachine2       = GUIDOF!ISdoMachine2;
const GUID IID_ISdoServiceControl = GUIDOF!ISdoServiceControl;
const GUID IID_ITemplateSdo       = GUIDOF!ITemplateSdo;
