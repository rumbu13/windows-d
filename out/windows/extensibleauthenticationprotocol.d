// Written in the D programming language.

module windows.extensibleauthenticationprotocol;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : IXMLDOMNode;
public import windows.xmlhttpextendedrequest : IXMLDOMDocument2;

extern(Windows):


// Enums


///The <b>RAS_AUTH_ATTRIBUTE_TYPE</b> enumerated type specifies attribute values used for session authentication.
///Further details for values in this enumerated type are obtained by referring to one of the four following references:
///RFC 2865, RFC 2866, RFC 2869, or RFC 2868.
alias RAS_AUTH_ATTRIBUTE_TYPE = int;
enum : int
{
    ///Specifies a value equal to zero, and used as the <b>NULL</b> terminator in any array of RAS_AUTH_ATTRIBUTE
    ///structures.
    raatMinimum                = 0x00000000,
    ///Specifies the name of the user to be authenticated. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///pointer. For more information, see RFC 2865.
    raatUserName               = 0x00000001,
    ///Specifies the password of the user to be authenticated. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///pointer. For more information, see RFC 2865.
    raatUserPassword           = 0x00000002,
    ///Specifies the password provided by the user in response to an MD5 Challenge Handshake Authentication Protocol
    ///(CHAP) challenge. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC
    ///2865.
    raatMD5CHAPPassword        = 0x00000003,
    ///Specifies the Network Access Server (NAS) IP address. An Access-Request should specify either an NAS IP address
    ///or an NAS identifier. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more
    ///information, see RFC 2865.
    raatNASIPAddress           = 0x00000004,
    ///Specifies the physical or virtual private network (VPN) through which the user is connecting to the NAS. Note
    ///that this value is not a port number in the sense of TCP or UDP. The value field in RAS_AUTH_ATTRIBUTE for this
    ///type is a 32-bit integral value. For more information, see RFC 2865.
    raatNASPort                = 0x00000005,
    ///Specifies the type of service the user has requested or the type of service to be provided. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2865.
    raatServiceType            = 0x00000006,
    ///Specifies the type of framed protocol to use for framed access, for example SLIP, PPP, or ARAP (AppleTalk Remote
    ///Access Protocol). The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more
    ///information, see RFC 2865.
    raatFramedProtocol         = 0x00000007,
    ///Specifies the IP address that is configured for the user requesting authentication. This attribute is typically
    ///returned by the authentication provider. However, the NAS may use it in an authentication request to specify a
    ///preferred IP address. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more
    ///information, see RFC 2865.
    raatFramedIPAddress        = 0x00000008,
    ///Specifies the IP network mask for a user that is a router to a network. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a 32-bit integral value. For more information, see RFC 2865.
    raatFramedIPNetmask        = 0x00000009,
    ///Specifies the routing method for a user that is a router to a network. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a 32-bit integral value. For more information, see RFC 2865.
    raatFramedRouting          = 0x0000000a,
    ///Specifies the filter list for the user requesting authentication. The value field in RAS_AUTH_ATTRIBUTE for this
    ///type is a pointer. For more information, see RFC 2865.
    raatFilterId               = 0x0000000b,
    ///Specifies the Maximum Transmission Unit (MTU) for the user. This attribute is used in cases where the MTU is not
    ///negotiated through some other means, such as PPP. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit
    ///integral value. For more information, see RFC 2865.
    raatFramedMTU              = 0x0000000c,
    ///Specifies a compression protocol to use for the connection. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2865.
    raatFramedCompression      = 0x0000000d,
    ///Specifies the system with which to connect the user. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///32-bit integral value. For more information, see RFC 2865.
    raatLoginIPHost            = 0x0000000e,
    ///Specifies the service to use to connect the user to the host specified by <b>raatLoginIPHost</b>. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2865.
    raatLoginService           = 0x0000000f,
    ///Specifies the port to which to connect the user. This attribute is present only if the <b>raatLoginService</b>
    ///attribute is present. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more
    ///information, see RFC 2865.
    raatLoginTCPPort           = 0x00000010,
    ///This value is currently unassigned.
    raatUnassigned17           = 0x00000011,
    ///Specifies a message to display to the user. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For
    ///more information, see RFC 2865.
    raatReplyMessage           = 0x00000012,
    ///Specifies a callback number. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more
    ///information, see RFC 2865.
    raatCallbackNumber         = 0x00000013,
    ///Specifies a location to call back. The value of this attribute is interpreted by the NAS. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2865.
    raatCallbackId             = 0x00000014,
    ///This value is currently unassigned. The value field in RAS_AUTH_ATTRIBUTE for this type is also undefined.
    raatUnassigned21           = 0x00000015,
    ///Specifies routing information to configure on the NAS for the user. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a pointer. For more information, see RFC 2865.
    raatFramedRoute            = 0x00000016,
    ///Specifies the IPX network number to configure for the user. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2865.
    raatFramedIPXNetwork       = 0x00000017,
    ///Specifies state information provided to the client by the server. Refer to RFC 2865 for detailed information
    ///about this value. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer.
    raatState                  = 0x00000018,
    ///Specifies a value that is provided to the NAS by the authentication provider. The NAS should use this value when
    ///communicating with the accounting provider. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For
    ///more information, see RFC 2865.
    raatClass                  = 0x00000019,
    ///Specifies a field for vendor-supplied extended attributes. The value field in RAS_AUTH_ATTRIBUTE for this type is
    ///a pointer. For more information, see RFC 2865.
    raatVendorSpecific         = 0x0000001a,
    ///Specifies the maximum number of seconds for which to provide service to the user. After this time, the session is
    ///terminated. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information,
    ///see RFC 2865.
    raatSessionTimeout         = 0x0000001b,
    ///Specifies the maximum number of consecutive seconds the session can be idle. If the idle time exceeds this value,
    ///the session is terminated. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For
    ///more information, see RFC 2865.
    raatIdleTimeout            = 0x0000001c,
    ///Specifies an action the server performs when time the connection terminates. Refer to the above-referenced files
    ///for detailed information about this value. The value field in RAS_AUTH_ATTRIBUTE for this type is 32-bit integral
    ///value. For more information, see RFC 2865.
    raatTerminationAction      = 0x0000001d,
    ///Specifies the number that the user dialed to connect to the NAS. The value field in RAS_AUTH_ATTRIBUTE for this
    ///type is a pointer. For more information, see RFC 2865.
    raatCalledStationId        = 0x0000001e,
    ///Specifies the number from which the user is calling. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///pointer. For more information, see RFC 2865.
    raatCallingStationId       = 0x0000001f,
    ///Specifies the NAS identifier. An Access-Request should specify either an NAS identifier or an NAS IP address. The
    ///value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2865.
    raatNASIdentifier          = 0x00000020,
    ///Specifies a value that a proxy server includes when forwarding an authentication request. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2865.
    raatProxyState             = 0x00000021,
    ///Specifies an attribute that is not currently used for authentication on Windows 2000. For more information, see
    ///RFC 2865.
    raatLoginLATService        = 0x00000022,
    ///Specifies an attribute that is not currently used for authentication on Windows 2000. For more information, see
    ///RFC 2865.
    raatLoginLATNode           = 0x00000023,
    ///Specifies an attribute that is not currently used for authentication on Windows 2000. For more information, see
    ///RFC 2865.
    raatLoginLATGroup          = 0x00000024,
    ///Specifies the AppleTalk network number for the user when the user is another router. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is 32-bit integral value. For more information, see RFC 2865.
    raatFramedAppleTalkLink    = 0x00000025,
    ///Specifies the AppleTalk network number that the NAS should use to allocate an AppleTalk node for the user. This
    ///attribute is used only when the user is not another router. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2865.
    raatFramedAppleTalkNetwork = 0x00000026,
    ///Specifies the AppleTalk default zone for the user. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///pointer. For more information, see RFC 2865.
    raatFramedAppleTalkZone    = 0x00000027,
    ///Specifies whether the accounting provider should start or stop accounting for the user. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctStatusType         = 0x00000028,
    ///Specifies the length of time that the client has been attempting to send the current request. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctDelayTime          = 0x00000029,
    ///Specifies the number of octets that have been received during the current accounting session. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctInputOctets        = 0x0000002a,
    ///Specifies the number of octets that were sent during the current accounting session. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctOutputOctets       = 0x0000002b,
    ///Specifies a value to enable the identification of matching start and stop records within a log file. The start
    ///and stop records are sent in the <b>raatAcctStatusType</b> attribute. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a pointer. For more information, see RFC 2866.
    raatAcctSessionId          = 0x0000002c,
    ///Specifies, to the accounting provider, how the user was authenticated; for example by Windows 2000 Directory
    ///Services, RADIUS, or some other authentication provider. The value field in RAS_AUTH_ATTRIBUTEfor this type is a
    ///32-bit integral value. For more information, see RFC 2866.
    raatAcctAuthentic          = 0x0000002d,
    ///Specifies the number of seconds that have elapsed in the current accounting session. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctSessionTime        = 0x0000002e,
    ///Specifies the number of packets that have been received during the current accounting session. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctInputPackets       = 0x0000002f,
    ///Specifies the number of packets that have been sent during the current accounting session. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctOutputPackets      = 0x00000030,
    ///Specifies how the current accounting session was terminated. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctTerminateCause     = 0x00000031,
    ///Specifies a value to enable the identification of related accounting sessions within a log file. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctMultiSessionId     = 0x00000032,
    ///Specifies the number of links if the current accounting session is using a multilink connection. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2866.
    raatAcctLinkCount          = 0x00000033,
    ///Specifies an attribute that is included in an accounting request packet. It specifies the time that the event
    ///took place. The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information,
    ///see the RFC 2869 Internet draft.
    raatAcctEventTimeStamp     = 0x00000037,
    ///Specifies the CHAP challenge sent by the NAS to a CHAP user. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a pointer. For more information, see RFC 2865.
    raatMD5CHAPChallenge       = 0x0000003c,
    ///Specifies the type of the port through which the user is connecting, for example, asynchronous, ISDN, virtual.
    ///The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC
    ///2865.
    raatNASPortType            = 0x0000003d,
    ///Specifies the number of ports the NAS should make available to the user for multilink sessions. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral value. For more information, see RFC 2865.
    raatPortLimit              = 0x0000003e,
    ///Specifies an attribute that is not currently used for authentication on Windows 2000. For more information, see
    ///RFC 2865.
    raatLoginLATPort           = 0x0000003f,
    ///Specifies the tunneling protocol used. The following table lists valid tunnel types. <table> <tr> <th>Tunnel Type
    ///Value</th> <th>Description</th> </tr> <tr> <td>1</td> <td>Point-to-Point Tunneling Protocol (PPTP)</td> </tr>
    ///<tr> <td>2</td> <td>Layer Two Forwarding (L2F)</td> </tr> <tr> <td>3</td> <td>Layer Two Tunneling Protocol
    ///(L2TP)</td> </tr> <tr> <td>4</td> <td>Ascend Tunnel Management Protocol (ATMP)</td> </tr> <tr> <td>5</td>
    ///<td>Virtual Tunneling Protocol (VTP)</td> </tr> <tr> <td>6</td> <td>IP Authentication Header in the
    ///Tunnel-mode</td> </tr> <tr> <td>7</td> <td>IP-in-IP Encapsulation (IP-IP)</td> </tr> <tr> <td>8</td> <td>Minimal
    ///IP-in-IP Encapsulation (MIN-IP-IP)</td> </tr> <tr> <td>9</td> <td>IP Encapsulating Security Payload in the
    ///Tunnel-mode (ESP)</td> </tr> <tr> <td>10</td> <td>Generic Route Encapsulation (GRE)</td> </tr> <tr> <td>11</td>
    ///<td>Bay Dial Virtual Services (DVS)</td> </tr> <tr> <td>12</td> <td>IP-in-IP Tunneling</td> </tr> </table>
    raatTunnelType             = 0x00000040,
    ///Specifies which transport medium to use when creating a tunnel for those protocols (such as L2TP) that can
    ///operate over multiple transports. The following table lists valid medium types. <table> <tr> <th>Medium Type
    ///Value</th> <th>Description</th> </tr> <tr> <td>1</td> <td>IPv4 (IP version 4)</td> </tr> <tr> <td>2</td> <td>IPv6
    ///(IP version 6)</td> </tr> <tr> <td>3</td> <td>NSAP</td> </tr> <tr> <td>4</td> <td>HDLC (8-bit multidrop)</td>
    ///</tr> <tr> <td>5</td> <td>BBN 1822</td> </tr> <tr> <td>6</td> <td>802 (includes all 802 media plus Ethernet
    ///"canonical format")</td> </tr> <tr> <td>7</td> <td>E.163 (POTS)</td> </tr> <tr> <td>8</td> <td>E.164 (SMDS, Frame
    ///Relay, ATM)</td> </tr> <tr> <td>9</td> <td>F.69 (Telex)</td> </tr> <tr> <td>10</td> <td>X.121 (X.25, Frame
    ///Relay)</td> </tr> <tr> <td>11</td> <td>IPX</td> </tr> <tr> <td>12</td> <td>Appletalk</td> </tr> <tr> <td>13</td>
    ///<td>Decnet IV</td> </tr> <tr> <td>14</td> <td>Banyan Vines</td> </tr> <tr> <td>15</td> <td>E.164 with NSAP format
    ///subaddress</td> </tr> </table>
    raatTunnelMediumType       = 0x00000041,
    ///Points to the address of the initiator end of the tunnel.
    raatTunnelClientEndpoint   = 0x00000042,
    ///Points to the address of the server end of the tunnel.
    raatTunnelServerEndpoint   = 0x00000043,
    ///Specifies a password to use for AppleTalk Remote Access Protocol (ARAP) authentication. The value field in
    ///RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2869 .
    raatARAPPassword           = 0x00000046,
    ///Specifies information that an NAS should send back to the user in an ARAP "feature flags" packet. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2869.
    raatARAPFeatures           = 0x00000047,
    ///Specifies how to use the ARAP zone list for the user. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///32-bit integral value. For more information, see RFC 2869.
    raatARAPZoneAccess         = 0x00000048,
    ///Specifies an ARAP security module to use during a secondary authentication phase between the NAS and the user.
    ///The value field in RAS_AUTH_ATTRIBUTE for this type is a 32-bit integral. For more information, see RFC 2869.
    raatARAPSecurity           = 0x00000049,
    ///Specifies the data to use with an ARAP security module. The value field in RAS_AUTH_ATTRIBUTE for this type is a
    ///pointer. For more information, see RFC 2869.
    raatARAPSecurityData       = 0x0000004a,
    ///Specifies the number of password retry attempts to permit the user access. The value field in RAS_AUTH_ATTRIBUTE
    ///for this type is a 32-bit integral value.
    raatPasswordRetry          = 0x0000004b,
    ///Specifies whether the NAS should echo the user response to a challenge. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a 32-bit integral value. For more information, see RFC 2869.
    raatPrompt                 = 0x0000004c,
    ///Specifies information about the type of connection the user is using. The value field in RAS_AUTH_ATTRIBUTE for
    ///this type is a Pointer. For more information, see RFC 2869.
    raatConnectInfo            = 0x0000004d,
    ///Specifies user-profile information in communications between RADIUS Proxy Servers and RADIUS Proxy Clients. The
    ///value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2869.
    raatConfigurationToken     = 0x0000004e,
    ///Specifies that EAP information be sent directly between the user and the authentication provider. The value field
    ///in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more information, see RFC 2869.
    raatEAPMessage             = 0x0000004f,
    ///Specifies a signature to include with CHAP, EAP, or ARAP packets. The value field in RAS_AUTH_ATTRIBUTE for this
    ///type is a pointer. For more information, RFC 2869.
    raatSignature              = 0x00000050,
    ///Specifies the response to a Apple Remote Access Protocol (ARAP) challenge. In ARAP, either the server or the
    ///client may respond to challenges. The value field in RAS_AUTH_ATTRIBUTE for this type is a pointer. For more
    ///information, see RFC 2869.
    raatARAPChallengeResponse  = 0x00000054,
    ///Specifies the time, in seconds, between accounting updates. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2869.
    raatAcctInterimInterval    = 0x00000055,
    raatNASIPv6Address         = 0x0000005f,
    raatFramedInterfaceId      = 0x00000060,
    raatFramedIPv6Prefix       = 0x00000061,
    raatLoginIPv6Host          = 0x00000062,
    raatFramedIPv6Route        = 0x00000063,
    raatFramedIPv6Pool         = 0x00000064,
    ///Specifies a Apple Remote Access Protocol (ARAP) guest logon. The value field in RAS_AUTH_ATTRIBUTE for this type
    ///is a 32-bit integral value. For more information, see RFC 2869.
    raatARAPGuestLogon         = 0x00001fa0,
    ///Reserved for internal use only.
    raatCertificateOID         = 0x00001fa1,
    ///Reserved for internal use only.
    raatEAPConfiguration       = 0x00001fa2,
    ///Reserved for internal use only.
    raatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    raatInnerEAPTypeId         = 0x00001fa3,
    ///Reserved for internal use only.
    raatPEAPFastRoamedSession  = 0x00001fa4,
    raatFastRoamedSession      = 0x00001fa4,
    ///Indicates and EAP-TLV attribute.
    raatEAPTLV                 = 0x00001fa6,
    raatCredentialsChanged     = 0x00001fa7,
    raatCertificateThumbprint  = 0x0000203a,
    raatPeerId                 = 0x00002328,
    raatServerId               = 0x00002329,
    raatMethodId               = 0x0000232a,
    raatEMSK                   = 0x0000232b,
    raatSessionId              = 0x0000232c,
    ///The value field in RAS_AUTH_ATTRIBUTE for this type is undefined.
    raatReserved               = 0xffffffff,
}

///The <b>PPP_EAP_ACTION</b> enumerated type specifies actions that the Connection Manager should take on behalf of the
///authentication protocol.
alias PPP_EAP_ACTION = int;
enum : int
{
    ///Directs the Connection Manager to be passive.
    EAPACTION_NoAction                   = 0x00000000,
    ///Directs the Connection Manager to invoke the authentication provider to authenticate the user.
    EAPACTION_Authenticate               = 0x00000001,
    ///Directs the Connection Manager Service to end the authentication session. <b>EAPACTION_Done</b> indicates that
    ///the <b>dwAuthResultCode</b> member of the PPP_EAP_OUTPUT structure is set with an appropriate value.
    EAPACTION_Done                       = 0x00000002,
    ///Directs the Connection Manager to send a message (without a time out), then end the authentication session.
    ///<b>EAPACTION_SendAndDone</b> indicates that the <b>dwAuthResultCode</b> member of the PPP_EAP_OUTPUT structure is
    ///set with an appropriate value.
    EAPACTION_SendAndDone                = 0x00000003,
    ///Directs the Connection Manager to send a message without setting a time out to wait for a reply.
    EAPACTION_Send                       = 0x00000004,
    ///Directs the Connection Manager to send a message and set a time out to wait for a reply.
    EAPACTION_SendWithTimeout            = 0x00000005,
    ///Directs the Connection Manager to send a message and set a time out to wait for a reply, but instructs the
    ///Connection Manager not to increment the retry counter.
    EAPACTION_SendWithTimeoutInteractive = 0x00000006,
    ///Reserved for system use.
    EAPACTION_IndicateTLV                = 0x00000007,
    ///Reserved for system use.
    EAPACTION_IndicateIdentity           = 0x00000008,
}

///The <b>EAP_ATTRIBUTE_TYPE</b> enumeration defines the set of possible EAP attribute types available on an
///authenticating entity. Further details for values in this enumerated type are obtained by referring to one of the
///following references: RFC 2865, RFC 2866, RFC 2869, RFC 2868, RFC 3162, RFC 3579, or RFC 3580.
alias EAP_ATTRIBUTE_TYPE = int;
enum : int
{
    ///Specifies a value equal to zero, and used as the <b>NULL</b> terminator in any array of EAP_ATTRIBUTE structures.
    ///This attribute type is consumed by PPP client supplicants.
    eatMinimum                = 0x00000000,
    ///Specifies the name of the user to be authenticated. This attribute type is also used when the user's password is
    ///changed. For Routing and Remote Access Service (RRAS) authentication sessions, the identity string (name) of the
    ///authenticating user is sent to IAS as part of the request attributes. The <b>pValue</b> member of EAP_ATTRIBUTE
    ///for this type points to a multi-byte string with no NULL termination character. For more information, see RFC
    ///2865. This attribute type is exported by MS-CHAPv2 methods and by PEAP methods. It is consumed by PPP server
    ///supplicants.
    eatUserName               = 0x00000001,
    ///Specifies the password of the user to be authenticated. The <b>pValue</b> member of EAP_ATTRIBUTE for this type
    ///points to a byte string. For more information, see RFC 2865.
    eatUserPassword           = 0x00000002,
    ///Specifies the password provided by the user in response to an MD5 Challenge Handshake Authentication Protocol
    ///(CHAP) challenge. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more
    ///information, see RFC 2865.
    eatMD5CHAPPassword        = 0x00000003,
    ///Specifies the IP address of the Network Access Server (NAS) that is requesting user authentication. An
    ///Access-Request should specify either an NAS IP address or an NAS identifier. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 2865.
    eatNASIPAddress           = 0x00000004,
    ///Specifies the physical or virtual private network (VPN) through which the user is connecting to the NAS. Note
    ///that this value is not a port number in the sense of TCP or UDP. The <b>pValue</b> member of EAP_ATTRIBUTE for
    ///this type points to a byte string. For more information, see RFC 2865.
    eatNASPort                = 0x00000005,
    ///Specifies the type of service the user has requested or the type of service to be provided. The <b>pValue</b>
    ///member of EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 2865.
    eatServiceType            = 0x00000006,
    ///Specifies the type of framed protocol to use for framed access, for example SLIP, PPP, or ARAP (AppleTalk Remote
    ///Access Protocol). The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more
    ///information, see RFC 2865.
    eatFramedProtocol         = 0x00000007,
    ///Specifies the IP address that is configured for the user requesting authentication. This attribute is typically
    ///returned by the authentication provider. However, the NAS may use it in an authentication request to specify a
    ///preferred IP address. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more
    ///information, see RFC 2865.
    eatFramedIPAddress        = 0x00000008,
    ///Specifies the IP network mask for a user that is a router to a network. For more information, see RFC 2865. This
    ///attribute type is not used by EAPHost methods or supplicants.
    eatFramedIPNetmask        = 0x00000009,
    ///Specifies the routing method for a user that is a router to a network. For more information, see RFC 2865. This
    ///attribute type is not used by EAPHost methods or supplicants.
    eatFramedRouting          = 0x0000000a,
    ///Specifies the name of the filter list for the user requesting authentication. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 2865.
    eatFilterId               = 0x0000000b,
    ///Specifies the Maximum Transmission Unit (MTU) for the user. This attribute is used in cases where the MTU is not
    ///negotiated through some other means, such as PPP. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points
    ///to a byte string. For more information, see RFC 2865.
    eatFramedMTU              = 0x0000000c,
    ///Specifies a compression protocol to use for the connection. For more information, see RFC 2865. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatFramedCompression      = 0x0000000d,
    ///Specifies the system with which to connect the user. For more information, see RFC 2865. This attribute type is
    ///not used by EAPHost methods or supplicants.
    eatLoginIPHost            = 0x0000000e,
    ///Specifies the service to use to connect the user to the host specified by <b>eatLoginIPHost</b>. For more
    ///information, see RFC 2865. This attribute type is not used by EAPHost methods or supplicants.
    eatLoginService           = 0x0000000f,
    ///Specifies the port to which to connect the user. This attribute is present only if the <b>eatLoginService</b>
    ///attribute is present. For more information, see RFC 2865. This attribute type is not used by EAPHost methods or
    ///supplicants.
    eatLoginTCPPort           = 0x00000010,
    ///This value is currently unassigned. This attribute type is not used by EAPHost methods or supplicants.
    eatUnassigned17           = 0x00000011,
    ///Specifies a message to display to the user. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a
    ///byte string. For more information, see RFC 2865. This attribute type consumed by the PPP server supplicant. This
    ///attribute type should not be used by any other method or supplicant. <b>eatEAPMessage</b> should be used to sent
    ///displayable messages whenever possible. For more information, see RFC 3580.
    eatReplyMessage           = 0x00000012,
    ///Specifies a callback number. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For
    ///more information, see RFC 2865.
    eatCallbackNumber         = 0x00000013,
    ///Specifies a location to call back. The value of this attribute is interpreted by the NAS. The <b>pValue</b>
    ///member of EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 2865.
    eatCallbackId             = 0x00000014,
    ///This value is currently unassigned. This attribute type is not used by EAPHost methods or supplicants.
    eatUnassigned21           = 0x00000015,
    ///Specifies routing information to configure on the NAS for the user. For more information, see RFC 2865. This
    ///attribute type is not used by EAPHost methods or supplicants.
    eatFramedRoute            = 0x00000016,
    ///Specifies the IPX network number to configure for the user. For more information, see RFC 2865. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatFramedIPXNetwork       = 0x00000017,
    ///Specifies state information provided to the client by the server. For RRAS authentication sessions, if
    ///authentication completed successfully and IAS returned attributes, then this state information is saved and used
    ///as input when constructing the request attributes for IAS during the next packet cycle. The <b>pValue</b> member
    ///of EAP_ATTRIBUTE for this type points to a byte string. Refer to RFC 2865 for detailed information about this
    ///value. This attribute type is consumed by PPP server supplicants.
    eatState                  = 0x00000018,
    ///Specifies a value that is provided to the NAS by the authentication provider. The NAS should use this value when
    ///communicating with the accounting provider. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a
    ///byte string. For more information, see RFC 2865.
    eatClass                  = 0x00000019,
    ///Specifies a field for vendor-supplied extended attributes. This field is used to store Microsoft Point-to-Point
    ///Encryption (MPPE) keys consumed by the 802.1X supplicant. For more information, see RFC 2865. The following table
    ///shows the structure of the data pointed to by the <b>pValue</b> member of EAP_ATTRIBUTE for this type. <table>
    ///<tr> <th>First Byte</th> <th>Last Byte </th> <th>Description</th> </tr> <tr> <td>0</td> <td>3</td> <td>Length: 4
    ///bytesThe vendor identifier. This field always has a value of 311. </td> </tr> <tr> <td>4</td> <td>4</td>
    ///<td>Length: 1 byteThe type of MPPE key. If the attribute refers to a MPPE send key, then this field has a value
    ///of 16. If the attribute refers to a MPPE receive key, then this field has a value of 17. </td> </tr> <tr>
    ///<td>5</td> <td>5</td> <td>Length: 1 byteThe MPPE vendor-specific attribute length. This field always has a value
    ///of 52. </td> </tr> <tr> <td>6</td> <td>7</td> <td>Length: 2 bytesSalt. This field always has a value of 0. </td>
    ///</tr> <tr> <td>8</td> <td>8</td> <td>Length: 1 byteThe MPPE key length. This field always has a value of 32.
    ///</td> </tr> <tr> <td>9</td> <td>40</td> <td>Length: 32 bytesThe MPPE key. The field contents are as follows:<ul>
    ///<li>For MPPE send keys used on a client, this field contains the first 32 bytes (bytes 0-31) of the master
    ///session key (MSK). </li> <li>For MPPE send keys used on a server, this field contains the second 32 bytes (bytes
    ///32-63) of the MSK.</li> <li>For MPPE receive keys used on a client, this field contains the second 32 bytes
    ///(bytes 32-63) of the MSK. </li> <li>For MPPE receive keys used on a server, this field contains the first 32
    ///bytes (bytes 0-31) of the MSK.</li> </ul> </td> </tr> <tr> <td>41</td> <td>55</td> <td>Length: 15 bytesPadding.
    ///</td> </tr> </table> This attribute type is consumed by 802.1X supplicants.
    eatVendorSpecific         = 0x0000001a,
    ///Specifies the maximum number of seconds for which to provide service to the user. After this time, the session is
    ///terminated. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more
    ///information, see RFC 2865. This attribute type is typically used by EAP methods to set the timeout duration for
    ///authentication within an Access-Challenge packet. The duration of the timeout is determined by IAS, not the EAP
    ///method. For RRAS authentication sessions, if authentication succeeded and there is a pending packet to be sent,
    ///the packet is sent with an interactive timeout if the corresponding <b>eatSessionTimeout</b> value is greater
    ///than 10. This attribute type is consumed by PPP server supplicants.
    eatSessionTimeout         = 0x0000001b,
    ///Specifies the maximum number of consecutive seconds the session can be idle. If the idle time exceeds this value,
    ///the session is terminated. For more information, see RFC 2865. This attribute type is not used by EAPHost methods
    ///or supplicants.
    eatIdleTimeout            = 0x0000001c,
    ///Specifies an action the server performs when time the connection terminates. Refer to the above-referenced files
    ///for detailed information about this value. For more information, see RFC 2865. This attribute type is not used by
    ///EAPHost methods or supplicants.
    eatTerminationAction      = 0x0000001d,
    ///Specifies the phone number called using Dialed Number Identification (DNIS) or similar technology. The phone
    ///number called by the user may be different than the phone number from which the call originated. This attribute
    ///type may also be used to store other types of information, such as MAC addresses. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 3580.
    eatCalledStationId        = 0x0000001e,
    ///Specifies the originating phone number for a call, using Automatic Number Identification (ANI) or similar
    ///technology. This attribute type may also be used to store other types of information, such as MAC addresses. The
    ///<b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 3580.
    eatCallingStationId       = 0x0000001f,
    ///Specifies the NAS identifier. An Access-Request should specify either an NAS identifier or an NAS IP address. The
    ///<b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 2865.
    eatNASIdentifier          = 0x00000020,
    ///Specifies a value that a proxy server includes when forwarding an authentication request. For more information,
    ///see RFC 2865. This attribute type is not used by EAPHost methods or supplicants.
    eatProxyState             = 0x00000021,
    ///Not used. For more information, see RFC 2865.
    eatLoginLATService        = 0x00000022,
    ///Not used. For more information, see RFC 2865.
    eatLoginLATNode           = 0x00000023,
    ///Not used. For more information, see RFC 2865.
    eatLoginLATGroup          = 0x00000024,
    ///Specifies the AppleTalk network number for the user when the user is another router. For more information, see
    ///RFC 2865. This attribute type is not used by EAPHost methods or supplicants.
    eatFramedAppleTalkLink    = 0x00000025,
    ///Specifies the AppleTalk network number that the NAS should use to allocate an AppleTalk node for the user. This
    ///attribute is used only when the user is not another router. For more information, see RFC 2865. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatFramedAppleTalkNetwork = 0x00000026,
    ///Specifies the AppleTalk default zone for the user. For more information, see RFC 2865. This attribute type is not
    ///used by EAPHost methods or supplicants.
    eatFramedAppleTalkZone    = 0x00000027,
    ///Specifies whether the accounting provider should start or stop accounting for the user. For more information, see
    ///RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctStatusType         = 0x00000028,
    ///Specifies the length of time that the client has been attempting to send the current request. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctDelayTime          = 0x00000029,
    ///Specifies the number of octets that have been received during the current accounting session. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctInputOctets        = 0x0000002a,
    ///Specifies the number of octets that were sent during the current accounting session. For more information, see
    ///RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctOutputOctets       = 0x0000002b,
    ///Specifies a value to enable the identification of matching start and stop records within a log file. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctSessionId          = 0x0000002c,
    ///Specifies, to the accounting provider, how the user was authenticated; for example by Directory Services, RADIUS,
    ///or some other authentication provider. For more information, see RFC 2866. This attribute type is not used by
    ///EAPHost methods or supplicants.
    eatAcctAuthentic          = 0x0000002d,
    ///Specifies the number of seconds that have elapsed in the current accounting session. For more information, see
    ///RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctSessionTime        = 0x0000002e,
    ///Specifies the number of packets that have been received during the current accounting session. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctInputPackets       = 0x0000002f,
    ///Specifies the number of packets that have been sent during the current accounting session. For more information,
    ///see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctOutputPackets      = 0x00000030,
    ///Specifies how the current accounting session was terminated. For more information, see RFC 2866. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatAcctTerminateCause     = 0x00000031,
    ///Specifies a value to enable the identification of related accounting sessions within a log file. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctMultiSessionId     = 0x00000032,
    ///Specifies the number of links if the current accounting session is using a multilink connection. For more
    ///information, see RFC 2866. This attribute type is not used by EAPHost methods or supplicants.
    eatAcctLinkCount          = 0x00000033,
    ///Specifies an attribute that is included in an accounting request packet. It specifies the time that the event
    ///took place. For more information, see RFC 2869. This attribute type is not used by EAPHost methods or
    ///supplicants.
    eatAcctEventTimeStamp     = 0x00000037,
    ///Specifies the CHAP challenge sent by the NAS to a CHAP user. For more information, see RFC 2865. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatMD5CHAPChallenge       = 0x0000003c,
    ///Specifies the type of the port through which NAS is authenticating the user, for example, asynchronous, ISDN,
    ///virtual. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For more information,
    ///see RFC 2865.
    eatNASPortType            = 0x0000003d,
    ///Specifies the number of ports the NAS should make available to the user for multilink sessions. For more
    ///information, see RFC 2865. This attribute type is not used by EAPHost methods or supplicants.
    eatPortLimit              = 0x0000003e,
    ///Not used. For more information, see RFC 2865.
    eatLoginLATPort           = 0x0000003f,
    ///Specifies the tunneling protocol used. This attribute type is not used by EAPHost methods or supplicants.
    eatTunnelType             = 0x00000040,
    ///Specifies which transport medium to use when creating a tunnel for those protocols (such as L2TP) that can
    ///operate over multiple transports. This attribute type is not used by EAPHost methods or supplicants.
    eatTunnelMediumType       = 0x00000041,
    ///Points to the address of the initiator end of the tunnel. This attribute type is not used by EAPHost methods or
    ///supplicants.
    eatTunnelClientEndpoint   = 0x00000042,
    ///Points to the address of the server end of the tunnel. This attribute type is not used by EAPHost methods or
    ///supplicants.
    eatTunnelServerEndpoint   = 0x00000043,
    ///Specifies a password to use for AppleTalk Remote Access Protocol (ARAP) authentication. For more information, see
    ///RFC 2869. This attribute type is not used by EAPHost methods or supplicants.
    eatARAPPassword           = 0x00000046,
    ///Specifies information that an NAS should send back to the user in an ARAP "feature flags" packet. For more
    ///information, see RFC 2869. This attribute type is not used by EAPHost methods or supplicants.
    eatARAPFeatures           = 0x00000047,
    ///Specifies how to use the ARAP zone list for the user. For more information, see RFC 2869. This attribute type is
    ///not used by EAPHost methods or supplicants.
    eatARAPZoneAccess         = 0x00000048,
    ///Specifies an ARAP security module to use during a secondary authentication phase between the NAS and the user.
    ///For more information, see RFC 2869. This attribute type is not used by EAPHost methods or supplicants.
    eatARAPSecurity           = 0x00000049,
    ///Specifies the data to use with an ARAP security module. For more information, see RFC 2869. This attribute type
    ///is not used by EAPHost methods or supplicants.
    eatARAPSecurityData       = 0x0000004a,
    ///Specifies the number of password retry attempts to permit the user access. This attribute type is deprecated for
    ///EAP and RADIUS/EAP. For more information, see RFC 3579. This attribute type is not used by EAPHost methods or
    ///supplicants.
    eatPasswordRetry          = 0x0000004b,
    ///Specifies whether the NAS should echo the user response to a challenge. For more information, see RFC 2869. This
    ///attribute type is not used by EAPHost methods or supplicants.
    eatPrompt                 = 0x0000004c,
    ///Specifies information about the type of connection the user is using. For more information, see RFC 2869. This
    ///attribute type is not used by EAPHost methods or supplicants.
    eatConnectInfo            = 0x0000004d,
    ///Specifies user-profile information in communications between RADIUS Proxy Servers and RADIUS Proxy Clients. For
    ///more information, see RFC 2869. This attribute type is not used by EAPHost methods or supplicants.
    eatConfigurationToken     = 0x0000004e,
    ///Specifies that EAP information be sent directly between the user and the authentication provider. For RRAS
    ///authentication sessions, this attribute type is used to retrieve the EAP message from the authenticator and send
    ///the message to the client. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For
    ///more information, see RFC 2869. This attribute type is consumed by PPP server supplicants.
    eatEAPMessage             = 0x0000004f,
    ///Specifies a signature to include with CHAP, EAP, or ARAP packets. For more information, RFC 2869. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatSignature              = 0x00000050,
    ///Specifies the response to a Apple Remote Access Protocol (ARAP) challenge. In ARAP, either the server or the
    ///client may respond to challenges. For more information, see RFC 2869. This attribute type is not used by EAPHost
    ///methods or supplicants.
    eatARAPChallengeResponse  = 0x00000054,
    ///Specifies the time, in seconds, between accounting updates. For more information, see RFC 2869. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatAcctInterimInterval    = 0x00000055,
    ///The IPv6 address of the NAS requesting user authentication. This address should be unique to the NAS within the
    ///scope of the RADIUS server. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. For
    ///more information, see RFC 3162.
    eatNASIPv6Address         = 0x0000005f,
    ///The IPv6 interface identifier to be configured for the user. The <b>pValue</b> member of EAP_ATTRIBUTE for this
    ///type points to a byte string. For more information, see RFC 3162.
    eatFramedInterfaceId      = 0x00000060,
    ///The IPv6 prefix (and corresponding route) to be configured for the user. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a byte string. For more information, see RFC 3162.
    eatFramedIPv6Prefix       = 0x00000061,
    ///Not used.
    eatLoginIPv6Host          = 0x00000062,
    ///Not used.
    eatFramedIPv6Route        = 0x00000063,
    ///Not used.
    eatFramedIPv6Pool         = 0x00000064,
    ///Specifies a Apple Remote Access Protocol (ARAP) guest logon. For more information, see RFC 2869. This attribute
    ///type is not used by EAPHost methods or supplicants.
    eatARAPGuestLogon         = 0x00001fa0,
    ///The object identifier (OID) present on the certificate. This attribute type is used in certificate-based
    ///authentication sessions. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte string. This
    ///attribute type is exported by EAP-TLS and NPS methods.
    eatCertificateOID         = 0x00001fa1,
    ///Not used.
    eatEAPConfiguration       = 0x00001fa2,
    ///The identifier of the inner EAP method used in PEAP authentication. The <b>pValue</b> member of EAP_ATTRIBUTE for
    ///this type points to a DWORD. Only the least significant byte of the DWORD is meaningful. This attribute type is
    ///exported by PEAP methods and is not consumed by any supplicant.
    eatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    ///Specifies whether PEAP fast reconnect is used by the authenticator. The <b>pValue</b> member of EAP_ATTRIBUTE for
    ///this type points to a DWORD. If <b>pValue</b> points to 0, then fast reconnect is not used by the authenticator.
    ///If <b>pValue</b> points to a nonzero value, then fast reconnect is used by the authenticator. This attribute type
    ///is exported by PEAP methods and consumed by PPP client supplicants.
    eatPEAPFastRoamedSession  = 0x00001fa4,
    ///TBD
    eatFastRoamedSession      = 0x00001fa4,
    ///An EAP-TLV attribute. This attribute type is used to handle statement of health (SoH) requests and SoH responses
    ///from the server. The following table shows the structure of the data pointed to by the <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type. <table> <tr> <th>First Byte</th> <th>Last Byte </th> <th>Description</th> </tr> <tr>
    ///<td>0</td> <td>1</td> <td>Length: 2 bytesThe buffer type. This field always has a value of 7. </td> </tr> <tr>
    ///<td>2</td> <td>3</td> <td>Length: 2 bytesThe length of the remaining contents of the buffer. For SoH requests
    ///from the server, this field has a value of 6. For SoH responses from the server, calculate the length by adding 8
    ///to the number of bytes in the SoH payload. </td> </tr> <tr> <td>4</td> <td>7</td> <td>Length: 4 bytesThe vendor
    ///identifier. This field always has a value of 311. </td> </tr> <tr> <td>8</td> <td>9</td> <td>Length: 2 bytesThe
    ///SoH type. For SoH requests from the server, this field has a value of 2. For SoH responses from the server, this
    ///field has a value of 3. </td> </tr> <tr> <td>10</td> <td>11</td> <td>Length: 2 bytesThe number of bytes of data
    ///in the SoH payload. </td> </tr> <tr> <td>12</td> <td></td> <td>Length: VariableThe SoH payload returned by the
    ///NAP system. The supplicant should not attempt to interpret this data. </td> </tr> </table> This attribute type is
    ///consumed by PPP client supplicants and by EAPHost supplicants.
    eatEAPTLV                 = 0x00001fa6,
    ///Specifies whether credentials have changed during EAP authentication. The <b>pValue</b> member of EAP_ATTRIBUTE
    ///for this type points to a DWORD. If <b>pValue</b> points to 0, then the credentials have not changed. If
    ///<b>pValue</b> points to a nonzero value, then credentials have changed. This attribute type may be exported by
    ///MS-CHAPv2 methods, and is consumed by PPP client supplicants.
    eatCredentialsChanged     = 0x00001fa7,
    ///The inner EAP method used inside native tunnel methods. The <b>pValue</b> member of EAP_ATTRIBUTE for this type
    ///points to an EAP_METHOD_TYPE structure. This attribute type is exported by EAP methods.
    eatInnerEapMethodType     = 0x00001fa8,
    ///The password, in clear text, of the user to be authenticated. This attribute type is sent by EAP methods that use
    ///EAPHost to raise the identity user interface. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to
    ///an EAP_METHOD_TYPE structure. This attribute type is exported by EAPHost.
    eatClearTextPassword      = 0x00001fab,
    ///Contains SoH request and response information used during EAP authentication. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a byte string. This attribute type is exported by EAPHost and PEAP methods,
    ///and consumed by PPP server supplicants.
    eatQuarantineSoH          = 0x00001fd6,
    ///TBD
    eatCertificateThumbprint  = 0x0000203a,
    ///The peer identity provided in the identity response message (EAP-Response/Identity). This identity may be
    ///different than the peer identity authenticated by the EAP method. The <b>pValue</b> member of EAP_ATTRIBUTE for
    ///this type points to an ASCII string. The string will be <b>NULL</b> if the EAP peer identity does not exist. For
    ///more information, see the Key Management Framework draft specification. This attribute type is exported by EAP
    ///methods and consumed by supplicants.
    eatPeerId                 = 0x00002328,
    ///The identity of the server used when the EAP method authenticates to the server. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to an ASCII string. The string will be <b>NULL</b> if an EAP method does not
    ///define a method-specific peer identity. For more information, see the Key Management Framework draft
    ///specification. This attribute type is exported by EAP methods and consumed by supplicants.
    eatServerId               = 0x00002329,
    ///A temporally unique method identifier that identifies an EAP session of a given type between an peer and a
    ///server. Any EAP method that derives keys must specify this attribute type. The <b>pValue</b> member of
    ///EAP_ATTRIBUTE for this type points to a DWORD. For more information, see the Key Management Framework draft
    ///specification. This attribute type is exported by EAPHost methods and other EAP methods, and consumed by
    ///supplicants.
    eatMethodId               = 0x0000232a,
    ///The extended session master key (EMSK). This key material is derived between the peer and the server, and should
    ///not be shared with a third party. The <b>pValue</b> member of EAP_ATTRIBUTE for this type points to a byte
    ///string, which should contain at least 64 octets of key material. For more information, see the Key Management
    ///Framework draft specification. This attribute type is exported by EAP methods and consumed by supplicants.
    eatEMSK                   = 0x0000232b,
    ///Windows Vista with SP1 or later: An attribute type that carries the session identity.
    eatSessionId              = 0x0000232c,
    ///Not used.
    eatReserved               = 0xffffffff,
}

///The <b>EAP_CONFIG_INPUT_FIELD_TYPE</b> enumeration defines a set of possible input field types available when
///querying for user credentials.
alias EAP_CONFIG_INPUT_FIELD_TYPE = int;
enum : int
{
    ///The input field contains a user's application logon name.
    EapConfigInputUsername        = 0x00000000,
    ///The input field contains a user's application logon password.
    EapConfigInputPassword        = 0x00000001,
    ///The input field contains a user's network logon name. This is used as an alternate logon user name for
    ///<b>EapConfigInputUsername</b>.
    EapConfigInputNetworkUsername = 0x00000002,
    ///The input field contains a user's network login password. This is used as an alternate logon password for
    ///<b>EapConfigInputPassword</b>.
    EapConfigInputNetworkPassword = 0x00000003,
    ///The input field contains the user's network access PIN.
    EapConfigInputPin             = 0x00000004,
    ///The input field contains the user's Flexible Authentication via Secure Tunneling (EAP-FAST) Pre-Shared Key(PSK).
    EapConfigInputPSK             = 0x00000005,
    ///The input field contains a generic logon token string.
    EapConfigInputEdit            = 0x00000006,
    ///Windows 7 or later: The input field contains the username from a smartcard certificate.
    EapConfigSmartCardUsername    = 0x00000007,
    ///Windows 7 or later: If an authentication using a smartcard did not succeed in the previous attempt of the current
    ///session, this input field contains an error message citing the failure reason.
    EapConfigSmartCardError       = 0x00000008,
}

///The <b>EAP_INTERACTIVE_UI_DATA_TYPE</b> enumeration specifies the set of types of interactive UI context data
///supplied to certain supplicant API calls.
alias EAP_INTERACTIVE_UI_DATA_TYPE = int;
enum : int
{
    ///The data contains an EAP security credential retry request.
    EapCredReq        = 0x00000000,
    ///The data contains an EAP security credential retry response.
    EapCredResp       = 0x00000001,
    ///The data contains an EAP security credential expiration request.
    EapCredExpiryReq  = 0x00000002,
    ///The data contains an EAP security credential expiration response.
    EapCredExpiryResp = 0x00000003,
    ///The data contains an EAP security credential logon request.
    EapCredLogonReq   = 0x00000004,
    ///The data contains an EAP security credential logon response.
    EapCredLogonResp  = 0x00000005,
}

///The <b>EAP_METHOD_PROPERTY_TYPE</b> enumeration specifies the set of possible EAP method properties.
alias EAP_METHOD_PROPERTY_TYPE = int;
enum : int
{
    ///Boolean method property for specifying the support for cipher suite negotiation.
    emptPropCipherSuiteNegotiation     = 0x00000000,
    ///Boolean method property for specifying the support for mutual authentication.
    emptPropMutualAuth                 = 0x00000001,
    ///Boolean method property for specifying the support for message integrity.
    emptPropIntegrity                  = 0x00000002,
    ///Boolean method property for specifying the support for replay protection.
    emptPropReplayProtection           = 0x00000003,
    ///Boolean method property for specifying the support for encrypting EAP messages.
    emptPropConfidentiality            = 0x00000004,
    ///Boolean method property for specifying the support for deriving exportable keying materials.
    emptPropKeyDerivation              = 0x00000005,
    ///Boolean method property for specifying the support for key length of at least 64 bits.
    emptPropKeyStrength64              = 0x00000006,
    ///Boolean method property for specifying the support for key length of at least 128 bits.
    emptPropKeyStrength128             = 0x00000007,
    ///Boolean method property for specifying the support for key length of at least 256 bits.
    emptPropKeyStrength256             = 0x00000008,
    ///Boolean method property for specifying the support for key length of at least 512 bits.
    emptPropKeyStrength512             = 0x00000009,
    ///Boolean method property for specifying the support for key length of at least 1024 bits.
    emptPropKeyStrength1024            = 0x0000000a,
    ///Boolean method property for specifying the support for preventing offline attack that has a work factor based on
    ///the number of passwords in an attacker’s dictionary.
    emptPropDictionaryAttackResistance = 0x0000000b,
    ///Boolean method property for specifying the support for establishing a security association in a smaller number of
    ///round trips by using the cached parameters of a previous successful authentication.
    emptPropFastReconnect              = 0x0000000c,
    ///Boolean method property for specifying the support for preventing man-in-the-middle attacks in a tunneling
    ///method. The method supporting cryptobinding demonstrates to the EAP server that a single entity has acted as the
    ///EAP peer for all methods executed within a tunnel method.
    emptPropCryptoBinding              = 0x0000000d,
    ///Boolean method property for specifying that passive attacks (such as capture of the EAP conversation) or active
    ///attacks (including compromise of the MSK or EMSK) do not compromise subsequent or prior MSKs or EMSKs.
    emptPropSessionIndependence        = 0x0000000e,
    ///Boolean method property for specifying the support for fragmentation and reassembly of EAP packets exceeding the
    ///MTU size.
    emptPropFragmentation              = 0x0000000f,
    ///Boolean method property for specifying the ability to communicate integrity-protected channel properties, such as
    ///endpoint identifiers, which can be compared to values communicated using out of band mechanisms, such as an
    ///Authentication, Authorization, and Accounting (AAA) protocol or the lower layer protocol.
    emptPropChannelBinding             = 0x00000010,
    ///Boolean method property for specifying the support for Network Access Protection.
    emptPropNap                        = 0x00000011,
    ///Boolean method property for specifying the support for execution of the method on a standalone computer.
    emptPropStandalone                 = 0x00000012,
    ///Boolean method property for specifying the support for Microsoft Point-to-Point Encryption (MPPE) protocol
    ///encryption.
    emptPropMppeEncryption             = 0x00000013,
    ///Boolean method property for specifying the ability of the method to tunnel other EAP methods.
    emptPropTunnelMethod               = 0x00000014,
    ///Boolean method property for specifying the support for method configuration and user interface.
    emptPropSupportsConfig             = 0x00000015,
    ///Boolean method property for specifying if the method was certified by the EAP Certification Program (ECP).
    emptPropCertifiedMethod            = 0x00000016,
    ///Boolean method property for specifying a hidden method.
    emptPropHiddenMethod               = 0x00000017,
    ///Boolean method property for specifying the support for computer authentication.
    emptPropMachineAuth                = 0x00000018,
    ///Boolean method property for specifying the support for user authentication.
    emptPropUserAuth                   = 0x00000019,
    ///Boolean method property for specifying the support for identity privacy.
    emptPropIdentityPrivacy            = 0x0000001a,
    ///Boolean method property for specifying the support for method chaining.
    emptPropMethodChaining             = 0x0000001b,
    ///Boolean method property for specifying the support for shared state equivalence as defined in RFC4017.
    emptPropSharedStateEquivalence     = 0x0000001c,
    ///<b>DWORD</b> property method for values sent prior to Windows 7.
    emptLegacyMethodPropertyFlag       = 0x0000001f,
    ///String property method for specifying any vendor-specific property of the EAP method.
    emptPropVendorSpecific             = 0x000000ff,
}

///The <b>EAP_METHOD_PROPERTY_VALUE_TYPE</b> enumeration defines the set of possible data types for an EAP method
///property value.
alias EAP_METHOD_PROPERTY_VALUE_TYPE = int;
enum : int
{
    ///The method property value is of type <b>BOOL</b>.
    empvtBool   = 0x00000000,
    ///The method property value is of type <b>DWORD</b>.
    empvtDword  = 0x00000001,
    ///The method property value is a pointer to a value of type <b>BYTE</b>.
    empvtString = 0x00000002,
}

///The <b>EapCredentialType</b> enumeration defines the set of possible EAP credentials that can be passed to the
///EapPeerGetConfigBlobAndUserBlob function.
enum EapCredentialType : int
{
    ///The EAP method has no credential passed to it. The method must attempt a machine authentication.
    EAP_EMPTY_CREDENTIAL             = 0x00000000,
    ///The EAP method uses a username and password for authentication. The credentials are passed using the
    ///EapUsernamePasswordCredential structure.
    EAP_USERNAME_PASSWORD_CREDENTIAL = 0x00000001,
    ///The EAP method uses the logged-on user credentials for authentication.
    EAP_WINLOGON_CREDENTIAL          = 0x00000002,
    ///The EAP method uses a certificate present on the system for authentication. The credential is passed as an
    ///EapCertificateCredential structure.
    EAP_CERTIFICATE_CREDENTIAL       = 0x00000003,
    ///The EAP method uses a SIM for authentication. This is passed as an EapSimCredential structure.
    EAP_SIM_CREDENTIAL               = 0x00000004,
}

///Defines the set of possible reasons that describe the results returned by an EAP method to a supplicant.
enum EapHostPeerMethodResultReason : int
{
    ///Authentication was successful.
    EapHostPeerMethodResultAltSuccessReceived = 0x00000001,
    ///The method timed out waiting for a response.
    EapHostPeerMethodResultTimeout            = 0x00000002,
    ///The authentication process was completely normally.
    EapHostPeerMethodResultFromMethod         = 0x00000003,
}

///Defines the set of actions an EAP authenticator or peer method can indicate to a supplicant during authentication.
enum EapHostPeerResponseAction : int
{
    ///The supplicant should discard the request as it is not usable by EAP.
    EapHostPeerResponseDiscard             = 0x00000000,
    ///The supplicant should send the indicated packet to the authenticator.
    EapHostPeerResponseSend                = 0x00000001,
    ///The supplicant should act on EAP attributes returned by the EAP authenticator.
    EapHostPeerResponseResult              = 0x00000002,
    ///The supplicant should invoke a user interface dialog on the client.
    EapHostPeerResponseInvokeUi            = 0x00000003,
    ///The supplicant should generate a context-specific response to the EAP authenticator request.
    EapHostPeerResponseRespond             = 0x00000004,
    ///The EAPHost has started authentication.
    EapHostPeerResponseStartAuthentication = 0x00000005,
    ///The supplicant should generate no response to the EAP authenticator request.
    EapHostPeerResponseNone                = 0x00000006,
}

///Defines the set of possible authentication parameter values.
enum EapHostPeerAuthParams : int
{
    ///Contains the current status of authentication for the supplicant.
    EapHostPeerAuthStatus           = 0x00000001,
    ///Contains the user identity of the supplicant.
    EapHostPeerIdentity             = 0x00000002,
    ///Contains extended user identity information for the supplicant from the identity packet.
    EapHostPeerIdentityExtendedInfo = 0x00000003,
    ///Windows 7 or later: Contains NAP-related information for the supplicant in an
    ///[EapHostPeerNapInfo](/windows/win32/eaphost/eaphostpeernapinfo) structure.
    EapHostNapInfo                  = 0x00000004,
}

///Defines the set of possible EAP authentication session status values during the authentication process.
alias EAPHOST_AUTH_STATUS = int;
enum : int
{
    ///The EAP authentication session is no longer valid.
    EapHostInvalidSession       = 0x00000000,
    ///The authentication session has not started yet.
    EapHostAuthNotStarted       = 0x00000001,
    ///The supplicant is providing a user identity in order to begin the EAP authentication session.
    EapHostAuthIdentityExchange = 0x00000002,
    ///The supplicant is negotiating the EAP method type to use for authentication.
    EapHostAuthNegotiatingType  = 0x00000003,
    ///The authentication session is in progress.
    EapHostAuthInProgress       = 0x00000004,
    ///The EAP authentication session completed successfully, and authentication was successful.
    EapHostAuthSucceeded        = 0x00000005,
    ///The EAP authentication session completed successfully, but authentication failed.
    EapHostAuthFailed           = 0x00000006,
}

///Defines the set of possible isolation state values of a machine. The isolation state of a machine determines its
///network connectivity.
alias ISOLATION_STATE = int;
enum : int
{
    ///The client's access to the network is unknown.
    ISOLATION_STATE_UNKNOWN           = 0x00000000,
    ///The client has unrestricted full access to the network.
    ISOLATION_STATE_NOT_RESTRICTED    = 0x00000001,
    ///The client has probationary access to the network for a limited amount of time during which time they must fix
    ///their system.
    ISOLATION_STATE_IN_PROBATION      = 0x00000002,
    ///The client has restricted access to the network; the client is allowed access to some servers only from which
    ///they can obtain necessary information and patches to update themselves to become healthy.
    ISOLATION_STATE_RESTRICTED_ACCESS = 0x00000003,
}

///The <b>EapCode</b> enumeration defines the set of EAP packet types.
enum EapCode : int
{
    ///The lowest possible value for an EAP packet type code.
    EapCodeMinimum  = 0x00000001,
    ///A request packet sent by the authenticator to the supplicant.
    EapCodeRequest  = 0x00000001,
    ///A response packet sent by the supplicant to the authenticator.
    EapCodeResponse = 0x00000002,
    ///A successful authentication attempt.
    EapCodeSuccess  = 0x00000003,
    ///A failed authentication attempt.
    EapCodeFailure  = 0x00000004,
    ///The highest possible value for an EAP packet type code.
    EapCodeMaximum  = 0x00000004,
}

///Defines the set of response instructions sent by the authenticator to the supplicant or EAP peer method.
alias EAP_METHOD_AUTHENTICATOR_RESPONSE_ACTION = int;
enum : int
{
    ///The supplicant should discard the response as it is not usable by EAPHost.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_DISCARD         = 0x00000000,
    ///The supplicant should send the indicated packet to the authenticator.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_SEND            = 0x00000001,
    ///The supplicant should act on EAP attributes returned by the authenticator.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESULT          = 0x00000002,
    ///The supplicant should generate a context-specific response to the authenticator request.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESPOND         = 0x00000003,
    ///The authenticator method has started authentication of the supplicant.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_AUTHENTICATE    = 0x00000004,
    ///The peer method should return the handle for the user identity of the supplicant.
    EAP_METHOD_AUTHENTICATOR_RESPONSE_HANDLE_IDENTITY = 0x00000005,
}

///Defines the set of actions an EAP authenticator can indicate to a supplicant or EAP peer method during
///authentication.
enum EapPeerMethodResponseAction : int
{
    ///The supplicant should discard the request as it is not usable by EAP.
    EapPeerMethodResponseActionDiscard  = 0x00000000,
    ///The supplicant should send the indicated packet to the authenticator.
    EapPeerMethodResponseActionSend     = 0x00000001,
    ///The supplicant should act on EAP attributes returned by the EAP authenticator.
    EapPeerMethodResponseActionResult   = 0x00000002,
    ///The EAP peer method should invoke a user interface dialog on the client.
    EapPeerMethodResponseActionInvokeUI = 0x00000003,
    ///The supplicant should generate a context-specific response to the EAP authenticator request.
    EapPeerMethodResponseActionRespond  = 0x00000004,
    ///The supplicant should generate no response to the EAP authenticator request.
    EapPeerMethodResponseActionNone     = 0x00000005,
}

///Defines the set of results of an EAP authentication session returned by an EAP authenticator method to an EAP peer
///method.
enum EapPeerMethodResultReason : int
{
    ///The success or failure of the authentication session is unknown or indeterminate.
    EapPeerMethodResultUnknown = 0x00000001,
    ///Authentication was successful.
    EapPeerMethodResultSuccess = 0x00000002,
    ///Authentication failed.
    EapPeerMethodResultFailure = 0x00000003,
}

///Indicates to the authenticator method the amount of time to wait for user input after the packet is sent. The timeout
///value can be set to none.
alias EAP_AUTHENTICATOR_SEND_TIMEOUT = int;
enum : int
{
    ///Sends the packet and never times out; the user can enter a response at any time.
    EAP_AUTHENTICATOR_SEND_TIMEOUT_NONE        = 0x00000000,
    ///Sends the packet and waits for a standard period of time for a response.
    EAP_AUTHENTICATOR_SEND_TIMEOUT_BASIC       = 0x00000001,
    ///Sends the packet and waits for a response for a longer period of time to allow for an interactive session.
    EAP_AUTHENTICATOR_SEND_TIMEOUT_INTERACTIVE = 0x00000002,
}

// Callbacks

///A callback prototype that notifies the supplicant that there is a change in the Statement of Health (SoH) and
///re-authentication of a Network Access Protection (NAP) system connection is required. For the user to receive visual
///notification of a change in the SoH, the callback must remain in place until after authentication is complete. <div
///class="alert"><b>Note</b> Never cancel the callback while re-authentication is in progress and the network connection
///is still valid. Never attempt to use any other mechanism to notify the supplicant that the SoH has changed.
///</div><div> </div>
///Params:
///    connectionId = A GUID provided by the supplicant to EAPHost. This value specifies the logical network connection to
///                   re-authenticate.
///    pContextData = Context data provided to EAPHost by the supplicant. This context data can be used by the supplicant for
///                   re-authentication.
alias NotificationHandler = void function(GUID connectionId, void* pContextData);

// Structs


struct NgcTicketContext
{
    ushort[45] wszTicket;
    size_t     hKey;
    HANDLE     hImpersonateToken;
}

///The <b>RAS_AUTH_ATTRIBUTE</b> structure is used to pass authentication attributes, of type RAS_AUTH_ATTRIBUTE_TYPE,
///during an EAP session.
struct RAS_AUTH_ATTRIBUTE
{
    ///Specifies the type of attribute, as defined in the RAS_AUTH_ATTRIBUTE_TYPE enumerated type.
    RAS_AUTH_ATTRIBUTE_TYPE raaType;
    ///Specifies the length in bytes of the value of this attribute. If the <b>Value</b> member is a pointer,
    ///<b>dwLength</b> specifies the length of the buffer pointed to. If the <b>Value</b> member is the value itself,
    ///<b>dwLength</b> specifies how much of the length of the <b>Value</b> member is taken up by the value.
    uint  dwLength;
    ///Specifies the value of the attribute. Although this member is of the <b>PVOID</b> type, this member sometimes
    ///contains the value of the attribute rather than pointing to the value. The only way to know whether to interpret
    ///the <b>Value</b> member as a pointer to the value or the value itself, is to check the <b>raaType</b> member. See
    ///the reference page for RAS_AUTH_ATTRIBUTE_TYPE for information about how the <b>Value</b> member should be
    ///interpreted for different types.
    void* Value;
}

///The <b>PPP_EAP_PACKET</b> structure specifies information about a packet being processed by the authentication
///protocol.
struct PPP_EAP_PACKET
{
    ///Specifies the type of packet that is sent or received by the authentication protocol. This parameter is one of
    ///the four following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="EAPCODE_Request"></a><a id="eapcode_request"></a><a id="EAPCODE_REQUEST"></a><dl>
    ///<dt><b>EAPCODE_Request</b></dt> </dl> </td> <td width="60%"> The packet is a request. </td> </tr> <tr> <td
    ///width="40%"><a id="EAPCODE_Response"></a><a id="eapcode_response"></a><a id="EAPCODE_RESPONSE"></a><dl>
    ///<dt><b>EAPCODE_Response</b></dt> </dl> </td> <td width="60%"> The packet is a response. </td> </tr> <tr> <td
    ///width="40%"><a id="EAPCODE_Success"></a><a id="eapcode_success"></a><a id="EAPCODE_SUCCESS"></a><dl>
    ///<dt><b>EAPCODE_Success</b></dt> </dl> </td> <td width="60%"> The packet indicates success. </td> </tr> <tr> <td
    ///width="40%"><a id="EAPCODE_Failure"></a><a id="eapcode_failure"></a><a id="EAPCODE_FAILURE"></a><dl>
    ///<dt><b>EAPCODE_Failure</b></dt> </dl> </td> <td width="60%"> The packet indicates failure. </td> </tr> </table>
    ubyte    Code;
    ///Specifies the identifier of the packet. The authentication protocol is responsible for maintaining packet counts
    ///for sessions, as that packet count pertains to EAP activity.
    ubyte    Id;
    ///Specifies the length of the packet.
    ubyte[2] Length;
    ///Specifies the data transmitted by this packet. If the packet is a request or a response packet, the first byte of
    ///this member signifies its type. For more information about packet types and requirements for type reservation,
    ///refer to RFC 2284.
    ubyte[1] Data;
}

///The <b>PPP_EAP_INPUT</b> structure is used in the interaction between the RAS Connection Manager Service PPP
///implementation and the EAP. This structure provides user information, and facilitates the use of authentication
///providers, such as a RADIUS server.
struct PPP_EAP_INPUT
{
    ///Specifies the size in bytes of the <b>PPP_EAP_INPUT</b> structure. The value of this member can be used to
    ///distinguish between current and future versions of this structure.
    uint                dwSizeInBytes;
    ///Specifies zero or more of the following flags that qualify the authentication process. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="RAS_EAP_FLAG_ROUTER"></a><a
    ///id="ras_eap_flag_router"></a><dl> <dt><b>RAS_EAP_FLAG_ROUTER</b></dt> </dl> </td> <td width="60%"> Specifies
    ///whether the computer dialing in is a router or a RAS client. If the computer is a router, this parameter should
    ///be set. </td> </tr> <tr> <td width="40%"><a id="RAS_EAP_FLAG_NON_INTERACTIVE"></a><a
    ///id="ras_eap_flag_non_interactive"></a><dl> <dt><b>RAS_EAP_FLAG_NON_INTERACTIVE</b></dt> </dl> </td> <td
    ///width="60%"> Specifies that the authentication protocol should not bring up a user-interface. If the
    ///authentication protocol is not able to determine the identity from the data supplied, it should return the error
    ///code <b>ERROR_INTERACTIVE_MODE</b>, which is defined in raserror.h. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_EAP_FLAG_LOGON"></a><a id="ras_eap_flag_logon"></a><dl> <dt><b>RAS_EAP_FLAG_LOGON</b></dt> </dl> </td>
    ///<td width="60%"> Specifies that the user data from obtained from Winlogon. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_EAP_FLAG_FIRST_LINK"></a><a id="ras_eap_flag_first_link"></a><dl> <dt><b>RAS_EAP_FLAG_FIRST_LINK</b></dt>
    ///</dl> </td> <td width="60%"> Indicates that this connection is the first link in a multilink connection. See
    ///[Multilink and Callback Connections](/windows/win32/eap/multilink-and-callback-connections) for more information.
    ///</td> </tr> <tr> <td width="40%"><a id="RAS_EAP_FLAG_GUEST_ACCESS"></a><a id="ras_eap_flag_guest_access"></a><dl>
    ///<dt><b>RAS_EAP_FLAG_GUEST_ACCESS</b></dt> </dl> </td> <td width="60%"> Specified if the client wants guest
    ///access. This flag is normally used in the case of a wireless connection such that if the authentication fails for
    ///N number of consecutive tries the wireless client, if configured to request guest access, then does so by passing
    ///this flag. The RADIUS server should be setup to permit guest access. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_EAP_FLAG_8021X_AUTH"></a><a id="ras_eap_flag_8021x_auth"></a><dl> <dt><b>RAS_EAP_FLAG_8021X_AUTH</b></dt>
    ///</dl> </td> <td width="60%"> Specifies that this session is executing in a wireless context. </td> </tr> <tr> <td
    ///width="40%"><a id="RAS_EAP_FLAG_RESUME_FROM_HIBERNATE"></a><a id="ras_eap_flag_resume_from_hibernate"></a><dl>
    ///<dt><b>RAS_EAP_FLAG_RESUME_FROM_HIBERNATE</b></dt> </dl> </td> <td width="60%"> Specifies that this is the first
    ///call after the machine has resumed from hibernation. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_EAP_FLAG_PEAP_UPFRONT"></a><a id="ras_eap_flag_peap_upfront"></a><dl>
    ///<dt><b>RAS_EAP_FLAG_PEAP_UPFRONT</b></dt> </dl> </td> <td width="60%"> Specifies that PEAP is enabled at the
    ///beginning of the IAS pipeline. </td> </tr> <tr> <td width="40%"><a id="RAS_EAP_FLAG_ALTERNATIVE_USER_DB"></a><a
    ///id="ras_eap_flag_alternative_user_db"></a><dl> <dt><b>RAS_EAP_FLAG_ALTERNATIVE_USER_DB</b></dt> </dl> </td> <td
    ///width="60%"> Specifies that the user database is not Active Directory. </td> </tr> <tr> <td width="40%"><a
    ///id="RAS_EAP_FLAG_PRE_LOGON"></a><a id="ras_eap_flag_pre_logon"></a><dl> <dt><b>RAS_EAP_FLAG_PRE_LOGON</b></dt>
    ///</dl> </td> <td width="60%"> Specifies that the credentials for the user or a computer account should be obtained
    ///in a secure fashion without raising multiple UI instances. </td> </tr> </table>
    uint                fFlags;
    ///Specifies whether the authentication protocol is operating on the server or client. A value of <b>TRUE</b>
    ///indicates that the authentication protocol is operating on the server as the authenticator. A value of
    ///<b>FALSE</b> indicates that the authentication protocol is operating on the client as the process to be
    ///authenticated.
    BOOL                fAuthenticator;
    ///Pointer to a Unicode string that identifies the user requesting authentication. This string is of the form
    ///domain\user or machine\user. If the authentication protocol is able to derive the user's identity from an
    ///additional source, for example a certificate, it should verify that the derived identity matches the value of
    ///<b>pwszIdentity</b>.
    ushort*             pwszIdentity;
    ///Pointer to a Unicode string that contains the user's account password. Available only if <b>fAuthenticator</b> is
    ///<b>FALSE</b>. This member may be <b>NULL</b>.
    ushort*             pwszPassword;
    ///Specifies the identifier of the initial EAP packet sent by the DLL. This value is incremented by one for each
    ///subsequent request packet.
    ubyte               bInitialId;
    ///Pointer to an array of RAS_AUTH_ATTRIBUTE structures. The array is terminated by a structure with an
    ///<b>raaType</b> member that has a value of <b>raatMinimum</b> (see RAS_AUTH_ATTRIBUTE_TYPE). During the
    ///RasEapBegin call, this array contains attributes that describe the currently dialed-in user. When the
    ///<b>fAuthenticationComplete</b> member is <b>TRUE</b>, this array may contain attributes returned by the
    ///authentication provider.
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    ///Specifies a Boolean value that indicates whether the authentication provider has authenticated the user. A value
    ///of <b>TRUE</b> indicates authentication completion. Check the <b>dwAuthResultCode</b> member to determine if the
    ///authentication was successful. Ignore this member if the authentication protocol is not using an authentication
    ///provider.
    BOOL                fAuthenticationComplete;
    ///Specifies the result of the authentication provider's authentication process. Successful authentication results
    ///in <b>NO_ERROR</b>. Authentication failure codes for <b>dwAuthResultCode</b> must come only from Winerror.h,
    ///Raserror.h or Mprerror.h. Ignore this field if the authentication protocol is not using an authentication
    ///provider.
    uint                dwAuthResultCode;
    ///Handle to an impersonation token for the user requesting authentication. This member is valid only on the client
    ///side. For more information on impersonation tokens, see Access Tokens.
    HANDLE              hTokenImpersonateUser;
    ///Specifies that authentication was successful. RAS sets this member to <b>TRUE</b> if the client receives an
    ///Network Control Protocol (NCP) packet even though the client has not yet received an EAP success packet. A value
    ///of <b>FALSE</b> indicates that no NCP packet has been received. The EAP success packet is a non-acknowledged
    ///packet. Therefore, it may be lost and not resent by the server. In this situation, the receipt of an NCP packet
    ///indicates that authentication was successful, since the server has moved on to the NCP phase of PPP. Examine this
    ///member only on the client side.
    BOOL                fSuccessPacketReceived;
    ///Specifies whether information is available from the interactive user interface. Default is <b>FALSE</b>. RAS sets
    ///this member to <b>TRUE</b> whenever the user exits from the authentication protocol's interactive user interface.
    BOOL                fDataReceivedFromInteractiveUI;
    ///Pointer to data received from the authentication protocol's interactive user interface. This pointer is
    ///non-<b>NULL</b> if the <b>fDataReceivedFromInteractiveUI</b> member is <b>TRUE</b> and the interactive user
    ///interface did, in fact, return data. Otherwise, this pointer is <b>NULL</b>. If non-<b>NULL</b>, the
    ///authentication protocol should make a copy of the data in its own memory space. RAS frees the memory occupied by
    ///this data on return from the call in which the <b>PPP_EAP_INPUT</b> structure was passed. To free the memory, RAS
    ///calls the RasEapFreeMemory function.
    ubyte*              pDataFromInteractiveUI;
    ///Specifies the size, in bytes, of the data pointed to by <b>pDataFromInteractiveUI</b>. If no data is returned
    ///from the interactive user interface, this member is zero.
    uint                dwSizeOfDataFromInteractiveUI;
    ///Pointer to connection data received from the authentication protocol's configuration user interface. This data is
    ///available only when the <b>PPP_EAP_INPUT</b> structure is passed in RasEapBegin. It is not available in calls to
    ///RasEapMakeMessage. The authentication protocol should make a copy of this data in its own memory space. RAS frees
    ///the memory occupied by this data on return from the call in which the <b>PPP_EAP_INPUT</b> structure was passed.
    ///To free the memory, RAS calls the RasEapFreeMemory function. If the authentication protocol's configuration user
    ///interface does not return any data, this member is <b>NULL</b>.
    ubyte*              pConnectionData;
    ///Specifies the size in bytes of the data pointed to by <b>pConnectionData</b>. If <b>pConnectionData</b> is
    ///<b>NULL</b>, this member is zero.
    uint                dwSizeOfConnectionData;
    ///Pointer to user data received from the authentication protocol's RasEapGetIdentity function on the client
    ///computer. If the authentication protocol does not implement <b>RasEapGetIdentity</b>, this member points to data
    ///from the registry for this user. This data is available only when the <b>PPP_EAP_INPUT</b> structure is passed in
    ///RasEapBegin. It is not available in calls to RasEapMakeMessage. The authentication protocol should make a copy of
    ///this data in its own memory space. RAS frees the memory occupied by this data on return from the call in which
    ///the <b>PPP_EAP_INPUT</b> structure was passed. If the RasEapGetIdentity function is not implemented or did not
    ///return any data, and no data exists for the user in the registry, this member is <b>NULL</b>.
    ubyte*              pUserData;
    ///Specifies the size, in bytes, of the data pointed to by <b>pUserData</b>. If <b>pUserData</b> is <b>NULL</b>,
    ///this member is zero.
    uint                dwSizeOfUserData;
    ///This member is reserved.
    HANDLE              hReserved;
    GUID                guidConnectionId;
    BOOL                isVpn;
}

///The authentication protocol uses the <b>PPP_EAP_OUTPUT</b> structure to communicate requests and status information
///to the Connection Manager on return from calls to RasEapMakeMessage.
struct PPP_EAP_OUTPUT
{
    ///Specifies the size of this structure.
    uint                dwSizeInBytes;
    ///Specifies a PPP_EAP_ACTION value. The Connection Manager carries out this action on behalf of the authentication
    ///protocol.
    PPP_EAP_ACTION      Action;
    ///Specifies whether authentication was successful. Any nonzero value for <b>dwAuthResultCode</b> indicates failure.
    ///The failure code must come from Winerror.h, Raserror.h or Mprerror.h. This member is valid only if the
    ///<b>Action</b> member has a value of <b>EAPACTION_Done</b> or <b>EAPACTION_SendAndDone</b>.
    uint                dwAuthResultCode;
    ///Pointer to an optional array of RAS_AUTH_ATTRIBUTE structures. The array is terminated by a structure with an
    ///<b>raaType</b> member that has a value of <b>raatMinimum</b> (see RAS_AUTH_ATTRIBUTE_TYPE). This member should be
    ///set on the authenticator side when <b>Action</b> is <b>EAPACTION_Authenticate</b>, or when <b>Action</b> is
    ///<b>EAPACTION_Done</b> or <b>EAPACTION_SendAndDone</b> and <b>dwAuthResultCode</b> is zero. When <b>Action</b> is
    ///<b>EAPACTION_Authenticate</b>, the array may contain additional attributes necessary to authenticate the user,
    ///e.g. the user-password. If the authentication protocol passes in only the user name, RAS does not invoke the
    ///authentication provider to authenticate the user, Instead, RAS just passes back the current attributes for the
    ///user. When <b>Action</b> is <b>EAPACTION_Done</b> or <b>EAPACTION_SendAndDone</b>, and <b>dwAuthResultCode</b> is
    ///zero, the array may contain additional attributes to assign to the user. These attributes overwrite any
    ///attributes of the same type returned by the authentication provider. The authentication protocol frees this
    ///memory in its RasEapEnd function.
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    ///Specifies whether RAS should invoke the authentication protocol's interactive UI. If the authentication protocol
    ///sets this member to <b>TRUE</b>, RAS invokes the interactive UI, by calling the RasEapInvokeInteractiveUI
    ///function provided by the authentication protocol.
    BOOL                fInvokeInteractiveUI;
    ///Pointer to context data that RAS should pass in the call to RasEapInvokeInteractiveUI. The authentication
    ///protocol should free this memory in its implementation of RasEapEnd.
    ubyte*              pUIContextData;
    ///Specifies the size of the context data that RAS should pass in the call to RasEapInvokeInteractiveUI.
    uint                dwSizeOfUIContextData;
    ///Specifies whether RAS should save the information pointed to by the <b>pConnectionData</b> member. If
    ///<b>fSaveConnectionData</b> is <b>TRUE</b>, RAS will save the data in the phone book. Only valid for the process
    ///that is being authenticated.
    BOOL                fSaveConnectionData;
    ///Identifies data specific to the connection, that is, data not specific to any particular user. If the
    ///<b>fSaveConnectionData</b> member is <b>TRUE</b>, RAS saves the connection data in the phone book. The
    ///authentication protocol should free the memory occupied by this data during the call to RasEapEnd.
    ubyte*              pConnectionData;
    ///Specifies the size, in bytes, of the data pointed to by the <b>pConnectionData</b> member.
    uint                dwSizeOfConnectionData;
    ///Specifies whether RAS should save the user data pointed to by the <b>pUserData</b> member. If this parameter is
    ///<b>TRUE</b>, RAS saves the user-specific data in the registry under <b>HKEY_CURRENT_USER</b>.
    BOOL                fSaveUserData;
    ///Pointer to user data that RAS should save in the registry. RAS saves this data in the registry under
    ///<b>HKEY_CURRENT_USER</b>. The authentication protocol should free this memory during the call to RasEapEnd.
    ubyte*              pUserData;
    ///Specifies the size in bytes of the data pointed to by <b>pUserData</b>.
    uint                dwSizeOfUserData;
    NgcTicketContext*   pNgcKerbTicket;
    BOOL                fSaveToCredMan;
}

///The <b>PPP_EAP_INFO</b> structure provides information to the Connection Manager about the authentication protocol,
///including pointers to functions located in the EAP DLL.
struct PPP_EAP_INFO
{
    ///Specifies the size of the <b>PPP_EAP_INFO</b> structure. RAS passes in this value to the EAP DLL. The DLL uses
    ///this value to determine which version of the <b>PPP_EAP_INFO</b> structure RAS is using.
    uint      dwSizeInBytes;
    ///Specifies a particular authentication protocol. This identifier must be unique throughout industry-wide
    ///implementation of EAP. The implementer of an authentication protocol must obtain this identifier from the
    ///Internet Assigned Numbers Authority (IANA).
    uint      dwEapTypeId;
    ///Pointer to the RasEapInitialize function for the authentication protocol. The authentication protocol sets the
    ///value of this member. The authentication protocol may set this member to <b>NULL</b>, in which case the protocol
    ///does not require RAS to call this function.
    ptrdiff_t RasEapInitialize;
    ///Pointer to the RasEapBegin function for the requested authentication protocol. The authentication protocol sets
    ///the value of this member. This member may be <b>NULL</b>, in which case, the authentication protocol does not
    ///require any initialization. If this member is <b>NULL</b>, RAS ignores the <b>RasEapEnd</b> member.
    ptrdiff_t RasEapBegin;
    ///Pointer to the RasEapEnd function for the authentication protocol. The authentication protocol sets the value of
    ///this member.
    ptrdiff_t RasEapEnd;
    ///Pointer to the RasEapMakeMessage function for the requested authentication protocol. The authentication protocol
    ///sets the value of this member.
    ptrdiff_t RasEapMakeMessage;
}

struct LEGACY_IDENTITY_UI_PARAMS
{
    uint          eapType;
    uint          dwFlags;
    uint          dwSizeofConnectionData;
    ubyte*        pConnectionData;
    uint          dwSizeofUserData;
    ubyte*        pUserData;
    uint          dwSizeofUserDataOut;
    ubyte*        pUserDataOut;
    const(wchar)* pwszIdentity;
    uint          dwError;
}

struct LEGACY_INTERACTIVE_UI_PARAMS
{
    uint   eapType;
    uint   dwSizeofContextData;
    ubyte* pContextData;
    uint   dwSizeofInteractiveUIData;
    ubyte* pInteractiveUIData;
    uint   dwError;
}

///The <b>EAP_TYPE</b> structure contains type and vendor identification information for an EAP method.
struct EAP_TYPE
{
    ///The numeric type code for this EAP method. <div class="alert"><b>Note</b> For more information on the allocation
    ///of EAP method types, see section 6.2 of RFC 3748.</div> <div> </div>
    ubyte type;
    ///The vendor ID for the EAP method.
    uint  dwVendorId;
    ///The numeric type code for the vendor of this EAP method.
    uint  dwVendorType;
}

///The <b>EAP_METHOD_TYPE</b> structure contains type, identification, and author information about an EAP method.
struct EAP_METHOD_TYPE
{
    ///EAP_TYPE structure that contains the ID for the EAP method as well as specific vendor information.
    EAP_TYPE eapType;
    ///The numeric ID for the author of the EAP method.
    uint     dwAuthorId;
}

///The <b>EAP_METHOD_INFO</b> structure contains information about an EAP method.
struct EAP_METHOD_INFO
{
    ///EAP_METHOD_TYPE structure that identifies the EAP method.
    EAP_METHOD_TYPE  eaptype;
    ///Pointer to a zero-terminated Unicode string that contains the name of the EAP method's author.
    const(wchar)*    pwszAuthorName;
    ///Pointer to a zero-terminated Unicode string that contains the display name of the EAP method.
    const(wchar)*    pwszFriendlyName;
    ///Set of flags that describe specific properties of the EAP method. For flag descriptions, see [EAP Method
    ///Properties](/windows/win32/eaphost/eap-method-properties).
    uint             eapProperties;
    ///Pointer to an <b>EAP_METHOD_INFO</b> structure that contains information about the inner method.
    EAP_METHOD_INFO* pInnerMethodInfo;
}

///The <b>EAP_METHOD_INFO_EX</b> structure contains information about an EAP method.
struct EAP_METHOD_INFO_EX
{
    ///An EAP_METHOD_TYPE structure that identifies the EAP method.
    EAP_METHOD_TYPE eaptype;
    ///Pointer to a zero-terminated Unicode string that contains the name of the EAP method's author.
    const(wchar)*   pwszAuthorName;
    ///Pointer to a zero-terminated Unicode string that contains the display name of the EAP method.
    const(wchar)*   pwszFriendlyName;
    ///Set of flags that describe specific properties of the EAP methods. For flag descriptions, see [EAP Method
    ///Properties](/windows/win32/eaphost/eap-method-properties).
    uint            eapProperties;
    ///Pointer to an EAP_METHOD_INFO_ARRAY_EX structure that contains information about all of the EAP methods installed
    ///on the client computer.
    EAP_METHOD_INFO_ARRAY_EX* pInnerMethodInfoArray;
}

///The <b>EAP_METHOD_INFO_ARRAY</b> structure contains information on EAP methods installed on the client computer.
///After populating <b>EAP_METHOD_INFO_ARRAY</b>, EAPHost passes this method information to the supplicant.
struct EAP_METHOD_INFO_ARRAY
{
    ///The number of EAP_METHOD_INFO structures in <b>pEapMethods</b>.
    uint             dwNumberOfMethods;
    ///Pointer to the address of the first element in an array of EAP_METHOD_INFO structures. The total number of
    ///elements is specified in <b>dwNumberOfMethods</b>.
    EAP_METHOD_INFO* pEapMethods;
}

///The <b>EAP_METHOD_INFO_ARRAY_EX</b> structure contains information about all of the EAP methods installed on the
///client computer. After populating <b>EAP_METHOD_INFO_ARRAY_EX</b>, EAPHost passes this method information to the
///supplicant.
struct EAP_METHOD_INFO_ARRAY_EX
{
    ///The number of EAP_METHOD_INFO_EX structures in <b>pEapMethods</b>.
    uint                dwNumberOfMethods;
    ///Pointer to the address of the first element in an array of EAP_METHOD_INFO_EX structures. The total number of
    ///elements is specified in <b>dwNumberOfMethods</b>.
    EAP_METHOD_INFO_EX* pEapMethods;
}

///The <b>EAP_ERROR</b> structure contains information about an error that occurred during an EAPHost operation.
struct EAP_ERROR
{
    ///Error code from winerror.h.
    uint            dwWinError;
    ///An EAP_METHOD_TYPE structure that identifies the EAP method that raised the error.
    EAP_METHOD_TYPE type;
    ///The reason code for the error.
    uint            dwReasonCode;
    ///A unique ID that identifies cause of error in EAPHost. An EAP method can define a new GUID and associate the GUID
    ///with a specific root cause. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Default"></a><a id="guid_eaphost_default"></a><a id="GUID_EAPHOST_DEFAULT"></a><dl>
    ///<dt><b>GUID_EapHost_Default</b></dt> <dt>{0x00000000, 0x0000, 0x0000, 0, 0, 0, 0, 0, 0, 0, 0}</dt> </dl> </td>
    ///<td width="60%"> The default error cause. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_MethodDLLNotFound"></a><a id="guid_eaphost_cause_methoddllnotfound"></a><a
    ///id="GUID_EAPHOST_CAUSE_METHODDLLNOTFOUND"></a><dl> <dt><b>GUID_EapHost_Cause_MethodDLLNotFound</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 1}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///cannot locate the DLL for the EAP method. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_EapNegotiationFailed"></a><a id="guid_eaphost_cause_eapnegotiationfailed"></a><a
    ///id="GUID_EAPHOST_CAUSE_EAPNEGOTIATIONFAILED"></a><dl> <dt><b>GUID_EapHost_Cause_EapNegotiationFailed</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x1C}}</dt> </dl> </td> <td width="60%"> The
    ///authentication failed because Windows does not have the authentication method required for this network. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_ThirdPartyMethod_Host_Reset"></a><a
    ///id="guid_eaphost_cause_thirdpartymethod_host_reset"></a><a
    ///id="GUID_EAPHOST_CAUSE_THIRDPARTYMETHOD_HOST_RESET"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_ThirdPartyMethod_Host_Reset</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 2, 0x12}}</dt> </dl> </td> <td width="60%"> The host of the third party method is not
    ///responding and was automatically restarted. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_XmlMalformed"></a><a id="guid_eaphost_cause_xmlmalformed"></a><a
    ///id="GUID_EAPHOST_CAUSE_XMLMALFORMED"></a><dl> <dt><b>GUID_EapHost_Cause_XmlMalformed</b></dt> <dt>{0x9612fc67,
    ///0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x1D}}</dt> </dl> </td> <td width="60%"> The EAPHost
    ///configuration schema validation failed. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_MethodDoesNotSupportOperation"></a><a
    ///id="guid_eaphost_cause_methoddoesnotsupportoperation"></a><a
    ///id="GUID_EAPHOST_CAUSE_METHODDOESNOTSUPPORTOPERATION"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_MethodDoesNotSupportOperation</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x1E}}</dt> </dl> </td> <td width="60%"> EAPHost returns this error when a configured EAP
    ///method does not support a requested operation (procedure call). </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_EapQecInaccessible"></a><a id="guid_eaphost_cause_eapqecinaccessible"></a><a
    ///id="GUID_EAPHOST_CAUSE_EAPQECINACCESSIBLE"></a><dl> <dt><b>GUID_EapHost_Cause_EapQecInaccessible</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 3, 0x12}}</dt> </dl> </td> <td width="60%">
    ///EAPHost not able to communicate with EAP quarantine enforcement client (QEC) on a Network Access Protection (NAP)
    ///enabled client. This error may occur when the NAP service is not responding. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Generic_AuthFailure"></a><a id="guid_eaphost_cause_generic_authfailure"></a><a
    ///id="GUID_EAPHOST_CAUSE_GENERIC_AUTHFAILURE"></a><dl> <dt><b>GUID_EapHost_Cause_Generic_AuthFailure</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 1, 4}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///returns this error on a generic, unspecified authentication failure. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_IdentityUnknown"></a><a id="guid_eaphost_cause_identityunknown"></a><a
    ///id="GUID_EAPHOST_CAUSE_IDENTITYUNKNOWN"></a><dl> <dt><b>GUID_EapHost_Cause_IdentityUnknown</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 2, 4}}</dt> </dl> </td> <td width="60%"> EAPHost
    ///returns this error if the authenticator fails the authentication after the peer identity was submitted. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_CertStoreInaccessible"></a><a
    ///id="guid_eaphost_cause_certstoreinaccessible"></a><a id="GUID_EAPHOST_CAUSE_CERTSTOREINACCESSIBLE"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_CertStoreInaccessible</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 4}}</dt> </dl> </td> <td width="60%"> Neither the authenticator or peer can access the certificate
    ///store. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertExpired"></a><a
    ///id="guid_eaphost_cause_user_certexpired"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTEXPIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertExpired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 9}}</dt> </dl> </td> <td width="60%"> EAPHost found an expired user certificate. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_User_CertInvalid"></a><a id="guid_eaphost_cause_user_certinvalid"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_CERTINVALID"></a><dl> <dt><b>GUID_EapHost_Cause_User_CertInvalid</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0xA}}</dt> </dl> </td> <td width="60%"> The
    ///user certificate being user for authentication does not have proper extended key usage (EKU) set. </td> </tr>
    ///<tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertNotFound"></a><a
    ///id="guid_eaphost_cause_user_certnotfound"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xB}}</dt> </dl> </td> <td width="60%"> EAPHost could not find a user certificate for authentication. </td>
    ///</tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertOtherError"></a><a
    ///id="guid_eaphost_cause_user_certothererror"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTOTHERERROR"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertOtherError</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 0xC}}</dt> </dl> </td> <td width="60%"> An unknown error occurred with the user certification being used
    ///for authentication. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_CertRejected"></a><a
    ///id="guid_eaphost_cause_user_certrejected"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTREJECTED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertRejected</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xD}}</dt> </dl> </td> <td width="60%"> The authenticator rejected the user certification. </td> </tr> <tr>
    ///<td width="40%"><a id="GUID_EapHost_Cause_User_CertRevoked"></a><a
    ///id="guid_eaphost_cause_user_certrevoked"></a><a id="GUID_EAPHOST_CAUSE_USER_CERTREVOKED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CertRevoked</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0,
    ///0, 0, 0xE}}</dt> </dl> </td> <td width="60%"> The user certificate being used for authentication has been
    ///revoked. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_User_Account_OtherProblem"></a><a
    ///id="guid_eaphost_cause_user_account_otherproblem"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_ACCOUNT_OTHERPROBLEM"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_Account_OtherProblem</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 0xE}}</dt> </dl> </td> <td width="60%"> An EAP failure was received after an identity exchange,
    ///indicating the likelihood of a problem with the authenticating user's account. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_User_CredsRejected"></a><a
    ///id="guid_eaphost_cause_user_credsrejected"></a><a id="GUID_EAPHOST_CAUSE_USER_CREDSREJECTED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_CredsRejected</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 2, 0xE}}</dt> </dl> </td> <td width="60%"> The authenticator rejected user credentials for authentication.
    ///</td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Cause_Server_CertExpired"></a><a
    ///id="guid_eaphost_cause_server_certexpired"></a><a id="GUID_EAPHOST_CAUSE_SERVER_CERTEXPIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_CertExpired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 5}}</dt> </dl> </td> <td width="60%"> EAPHost found an expired server certificate. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_Server_CertInvalid"></a><a
    ///id="guid_eaphost_cause_server_certinvalid"></a><a id="GUID_EAPHOST_CAUSE_SERVER_CERTINVALID"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_CertInvalid</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8,
    ///0, 0, 0, 6}}</dt> </dl> </td> <td width="60%"> The server certificate being user for authentication does not have
    ///a proper extended key usage (EKU) set. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_CertNotFound"></a><a id="guid_eaphost_cause_server_certnotfound"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_CERTNOTFOUND"></a><dl> <dt><b>GUID_EapHost_Cause_Server_CertNotFound</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 7}} </dt> </dl> </td> <td width="60%"> EAPHost
    ///could not find the server certificate for authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_CertOtherError"></a><a id="guid_eaphost_cause_server_certothererror"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_CERTOTHERERROR"></a><dl> <dt><b>GUID_EapHost_Cause_Server_CertOtherError</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 1, 8}}</dt> </dl> </td> <td width="60%"> An
    ///unknown error occurred with the server certificate. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_CertRevoked"></a><a id="guid_eaphost_cause_server_certrevoked"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_CERTREVOKED"></a><dl> <dt><b>GUID_EapHost_Cause_Server_CertRevoked</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 8}}</dt> </dl> </td> <td width="60%"> The
    ///server certificate being used for authentication has been revoked. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_User_Root_CertExpired"></a><a id="guid_eaphost_cause_user_root_certexpired"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTEXPIRED"></a><dl> <dt><b>GUID_EapHost_Cause_User_Root_CertExpired</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0xF}}</dt> </dl> </td> <td width="60%"> The
    ///trusted root certificate needed for user certificate validation has expired. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_User_Root_CertInvalid"></a><a id="guid_eaphost_cause_user_root_certinvalid"></a><a
    ///id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTINVALID"></a><dl> <dt><b>GUID_EapHost_Cause_User_Root_CertInvalid</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x10}}</dt> </dl> </td> <td width="60%"> The
    ///authentication failed because the root certificate used for this network is invalid. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Cause_User_Root_CertNotFound"></a><a
    ///id="guid_eaphost_cause_user_root_certnotfound"></a><a id="GUID_EAPHOST_CAUSE_USER_ROOT_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_User_Root_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 0, 0x11}}</dt> </dl> </td> <td width="60%"> EAPHost could not find a certificate in a trusted root
    ///certificate store for user certification validation. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_Root_CertNotFound"></a><a id="guid_eaphost_cause_server_root_certnotfound"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_ROOT_CERTNOTFOUND"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_Root_CertNotFound</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8,
    ///0xd8, 0, 0, 1, 0x12}}</dt> </dl> </td> <td width="60%"> EAPHost could not find a root certificate in a trusted
    ///root certificate store for the server certification validation. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Cause_Server_Root_CertNameRequired"></a><a
    ///id="guid_eaphost_cause_server_root_certnamerequired"></a><a
    ///id="GUID_EAPHOST_CAUSE_SERVER_ROOT_CERTNAMEREQUIRED"></a><dl>
    ///<dt><b>GUID_EapHost_Cause_Server_Root_CertNameRequired</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x12}}</dt> </dl> </td> <td width="60%"> The authentication failed because the certificate
    ///on the server computer does not have a server name specified. </td> </tr> </table>
    GUID            rootCauseGuid;
    ///A unique ID that maps to a localizable string that identifies the repair action that can be taken to fix the
    ///reported error. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_ContactSysadmin"></a><a id="guid_eaphost_repair_contactsysadmin"></a><a
    ///id="GUID_EAPHOST_REPAIR_CONTACTSYSADMIN"></a><dl> <dt><b>GUID_EapHost_Repair_ContactSysadmin</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 2}}</dt> </dl> </td> <td width="60%"> The user
    ///should contact the network administrator. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_Retry_Authentication"></a><a id="guid_eaphost_repair_retry_authentication"></a><a
    ///id="GUID_EAPHOST_REPAIR_RETRY_AUTHENTICATION"></a><dl> <dt><b>GUID_EapHost_Repair_Retry_Authentication</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 1, 0x1B}}</dt> </dl> </td> <td width="60%"> The
    ///user should try to connect to the network again. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_User_AuthFailure"></a><a id="guid_eaphost_repair_user_authfailure"></a><a
    ///id="GUID_EAPHOST_REPAIR_USER_AUTHFAILURE"></a><dl> <dt><b>GUID_EapHost_Repair_User_AuthFailure</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x19}}</dt> </dl> </td> <td width="60%"> The
    ///user should enter valid credentials for network authentication. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_User_GetNewCert"></a><a id="guid_eaphost_repair_user_getnewcert"></a><a
    ///id="GUID_EAPHOST_REPAIR_USER_GETNEWCERT"></a><dl> <dt><b>GUID_EapHost_Repair_User_GetNewCert</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x1A}} </dt> </dl> </td> <td width="60%"> The
    ///user should obtain an updated certificate from the network administrator. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Repair_User_SelectValidCert"></a><a id="guid_eaphost_repair_user_selectvalidcert"></a><a
    ///id="GUID_EAPHOST_REPAIR_USER_SELECTVALIDCERT"></a><dl> <dt><b>GUID_EapHost_Repair_User_SelectValidCert</b></dt>
    ///<dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e, 0xa8, 0xd8, 0, 0, 0, 0x1B}} </dt> </dl> </td> <td width="60%"> The
    ///user should use a different and valid user certificate for authentication with the network. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Repair_Server_ClientSelectServerCert"></a><a
    ///id="guid_eaphost_repair_server_clientselectservercert"></a><a
    ///id="GUID_EAPHOST_REPAIR_SERVER_CLIENTSELECTSERVERCERT"></a><dl>
    ///<dt><b>GUID_EapHost_Repair_Server_ClientSelectServerCert</b></dt> <dt>{0x9612fc67, 0x6150, 0x4209, {0xa8, 0x5e,
    ///0xa8, 0xd8, 0, 0, 0, 0x19}}</dt> </dl> </td> <td width="60%"> The user should use a different and valid server
    ///certificate for authentication with the network. </td> </tr> </table>
    GUID            repairGuid;
    ///A unique ID that maps to a localizable string that specifies an URL for a page that contains additional
    ///information about an error or repair message. An EAP method can potentially define a new GUID and associate with
    ///one specific help link. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_EapConfigureTypes"></a><a id="guid_eaphost_help_eapconfiguretypes"></a><a
    ///id="GUID_EAPHOST_HELP_EAPCONFIGURETYPES"></a><dl> <dt><b>GUID_EapHost_Help_EapConfigureTypes</b></dt> </dl> </td>
    ///<td width="60%"> The URL for the page with more information about configuring EAP types. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Help_FailedAuth"></a><a id="guid_eaphost_help_failedauth"></a><a
    ///id="GUID_EAPHOST_HELP_FAILEDAUTH"></a><dl> <dt><b>GUID_EapHost_Help_FailedAuth</b></dt> </dl> </td> <td
    ///width="60%"> The URL for the page with more information about authentication failures. </td> </tr> <tr> <td
    ///width="40%"><a id="GUID_EapHost_Help_ObtainingCerts"></a><a id="guid_eaphost_help_obtainingcerts"></a><a
    ///id="GUID_EAPHOST_HELP_OBTAININGCERTS"></a><dl> <dt><b>GUID_EapHost_Help_ObtainingCerts</b></dt> <dt>{0xf535eea3,
    ///0x1bdd, 0x46ca, {0xa2, 0xfc, 0xa6, 0x65, 0x59, 0x39, 0xb7, 0xe8}}</dt> </dl> </td> <td width="60%"> The URL for
    ///the page with more information about getting EAP certificates. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_SelectingCerts"></a><a id="guid_eaphost_help_selectingcerts"></a><a
    ///id="GUID_EAPHOST_HELP_SELECTINGCERTS"></a><dl> <dt><b>GUID_EapHost_Help_SelectingCerts</b></dt> </dl> </td> <td
    ///width="60%"> The URL for the page with more information about selecting the appropriate certificate to use for
    ///authentication. </td> </tr> <tr> <td width="40%"><a id="GUID_EapHost_Help_SetupEapServer"></a><a
    ///id="guid_eaphost_help_setupeapserver"></a><a id="GUID_EAPHOST_HELP_SETUPEAPSERVER"></a><dl>
    ///<dt><b>GUID_EapHost_Help_SetupEapServer</b></dt> </dl> </td> <td width="60%"> The URL for the page with more
    ///information about setting up an EAP server. </td> </tr> <tr> <td width="40%"><a
    ///id="GUID_EapHost_Help_Troubleshooting"></a><a id="guid_eaphost_help_troubleshooting"></a><a
    ///id="GUID_EAPHOST_HELP_TROUBLESHOOTING"></a><dl> <dt><b>GUID_EapHost_Help_Troubleshooting</b></dt>
    ///<dt>{0x33307acf, 0x0698, 0x41ba, {0xb0, 0x14, 0xea, 0x0a, 0x2e, 0xb8, 0xd0, 0xa8}}</dt> </dl> </td> <td
    ///width="60%"> The URL for the page with more information about troubleshooting. </td> </tr> </table>
    GUID            helpLinkGuid;
    ///A localized and readable string that describes the root cause of the error.
    const(wchar)*   pRootCauseString;
    ///A localized and readable string that describes the possible repair action.
    const(wchar)*   pRepairString;
}

///The <b>EAP_ATTRIBUTE</b> structure contains an EAP attribute.
struct EAP_ATTRIBUTE
{
    ///An EAP_ATTRIBUTE_TYPE enumeration value that describes the type of the EAP attribute value supplied in
    ///<b>pValue</b>.
    EAP_ATTRIBUTE_TYPE eaType;
    ///The size, in bytes, of <b>pValue</b>.
    uint               dwLength;
    ///Pointer to a byte buffer that contains the data value of the attribute.
    ubyte*             pValue;
}

///The <b>EAP_ATTRIBUTES</b> structure contains an array of EAP attributes.
struct EAP_ATTRIBUTES
{
    ///The number of EAP_ATTRIBUTE structures in <b>pAttribs</b>.
    uint           dwNumberOfAttributes;
    EAP_ATTRIBUTE* pAttribs;
}

///The <b>EAP_CONFIG_INPUT_FIELD_DATA</b> structure contains the data associated with a single input field.
struct EAP_CONFIG_INPUT_FIELD_DATA
{
    ///The size, in bytes, of the <b>EAP_CONFIG_INPUT_FIELD_DATA</b> structure. This field is used for versioning
    ///purposes.
    uint          dwSize;
    ///An EAP_CONFIG_INPUT_FIELD_TYPE enumeration value that specifies the type of the input field.
    EAP_CONFIG_INPUT_FIELD_TYPE Type;
    ///A set of flag values that describe properties of the EAP configuration input field. <table> <tr> <th>Value</th>
    ///<th>Meaning</th> </tr> <tr> <td width="40%"><a id="EAP_UI_INPUT_FIELD_PROPS_DEFAULT"></a><a
    ///id="eap_ui_input_field_props_default"></a><dl> <dt><b>EAP_UI_INPUT_FIELD_PROPS_DEFAULT</b></dt> <dt>0X00000000
    ///</dt> </dl> </td> <td width="60%"> Windows Vista with SP1 or later: Represents the default property value for
    ///input field entries displayed in the UI. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_CONFIG_INPUT_FIELD_PROPS_DEFAULT"></a><a id="eap_config_input_field_props_default"></a><dl>
    ///<dt><b>EAP_CONFIG_INPUT_FIELD_PROPS_DEFAULT</b></dt> <dt>0X00000000 </dt> </dl> </td> <td width="60%"> Represents
    ///the default property value for configuration input field entries displayed in the UI. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_UI_INPUT_FIELD_PROPS_NON_DISPLAYABLE"></a><a
    ///id="eap_ui_input_field_props_non_displayable"></a><dl> <dt><b>EAP_UI_INPUT_FIELD_PROPS_NON_DISPLAYABLE</b></dt>
    ///<dt>0X00000001 </dt> </dl> </td> <td width="60%"> Windows Vista with SP1 or later: Specifies that input field
    ///entries will not be displayed in the UI (a password or PIN number, for example). </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_CONFIG_INPUT_FIELD_PROPS_NON_DISPLAYABLE"></a><a
    ///id="eap_config_input_field_props_non_displayable"></a><dl>
    ///<dt><b>EAP_CONFIG_INPUT_FIELD_PROPS_NON_DISPLAYABLE</b></dt> <dt>0X00000001 </dt> </dl> </td> <td width="60%">
    ///Specifies that configuration input field entries will not be displayed in the UI (a password or PIN number, for
    ///example). </td> </tr> <tr> <td width="40%"><a id="EAP_UI_INPUT_FIELD_PROPS_NON_PERSIST"></a><a
    ///id="eap_ui_input_field_props_non_persist"></a><dl> <dt><b>EAP_UI_INPUT_FIELD_PROPS_NON_PERSIST</b></dt>
    ///<dt>0X00000002 </dt> </dl> </td> <td width="60%"> Windows Vista with SP1 or later: Indicates that the EAP method
    ///will not cache the field data; the supplicant must cache the field data for roaming. </td> </tr> <tr> <td
    ///width="40%"><a id="EAP_CONFIG_INPUT_FIELD_PROPS_NON_PERSIST"></a><a
    ///id="eap_config_input_field_props_non_persist"></a><dl> <dt><b>EAP_CONFIG_INPUT_FIELD_PROPS_NON_PERSIST</b></dt>
    ///<dt>0X00000002 </dt> </dl> </td> <td width="60%"> Indicates that the EAP method will not cache the field data;
    ///the supplicant must cache the field data for roaming. </td> </tr> <tr> <td width="40%"><a
    ///id="EAP_UI_INPUT_FIELD_PROPS_READ_ONLY"></a><a id="eap_ui_input_field_props_read_only"></a><dl>
    ///<dt><b>EAP_UI_INPUT_FIELD_PROPS_READ_ONLY</b></dt> <dt>0x00000004</dt> </dl> </td> <td width="60%"> Windows Vista
    ///with SP1 or later: Indicates that the input field is read-only and cannot be edited. </td> </tr> </table>
    uint          dwFlagProps;
    ///A pointer to a zero-terminated Unicode string that contains the label for the input field. The caller must free
    ///the inner pointers using the function EapHostPeerFreeMemory, starting at the innermost pointer. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="MAX_EAP_CONFIG_INPUT_FIELD_LENGTH"></a><a
    ///id="max_eap_config_input_field_length"></a><dl> <dt><b>MAX_EAP_CONFIG_INPUT_FIELD_LENGTH</b></dt> <dt>256</dt>
    ///</dl> </td> <td width="60%"> Specifies the maximum supported length of an input field. </td> </tr> </table>
    const(wchar)* pwszLabel;
    ///A pointer to a zero-terminated Unicode string that contains the data entered by the user into the input field.
    ///This value is initially empty. It is populated in a Single-Sign-On (SSO) scenario and returned to EAPHost with a
    ///call to EapHostPeerQueryUserBlobFromCredentialInputFields. The caller must free the inner pointers using the
    ///function EapHostPeerFreeMemory, starting at the innermost pointer. <table> <tr> <th>Value</th> <th>Meaning</th>
    ///</tr> <tr> <td width="40%"><a id="MAX_EAP_CONFIG_INPUT_FIELD_VALUE_LENGTH"></a><a
    ///id="max_eap_config_input_field_value_length"></a><dl> <dt><b>MAX_EAP_CONFIG_INPUT_FIELD_VALUE_LENGTH</b></dt>
    ///<dt>1024</dt> </dl> </td> <td width="60%"> Specifies the maximum supported length of an input field. </td> </tr>
    ///</table>
    const(wchar)* pwszData;
    ///The minimum length, in bytes, allowed for data entered by the user into the EAP configuration dialog box input
    ///field.
    uint          dwMinDataLength;
    ///The maximum length, in bytes, allowed for data entered by the user into the EAP configuration dialog box input
    ///field.
    uint          dwMaxDataLength;
}

///The <b>EAP_CONFIG_INPUT_FIELD_ARRAY</b> structure contains a set of EAP_CONFIG_INPUT_FIELD_DATA structures that
///collectively contain the user input field data obtained from the user.
struct EAP_CONFIG_INPUT_FIELD_ARRAY
{
    ///The version of the EAP_CONFIG_INPUT_FIELD_DATA structures pointed to by <b>pFields</b>. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="EAP_CREDENTIAL_VERSION"></a><a
    ///id="eap_credential_version"></a><dl> <dt><b>EAP_CREDENTIAL_VERSION</b></dt> <dt>1</dt> </dl> </td> <td
    ///width="60%"> The version of the EAP credentials supplied by the user. </td> </tr> </table>
    uint dwVersion;
    ///The total number of elements in the array specified by <b>pFields</b>.
    uint dwNumberOfFields;
    ///Pointer to an array of EAP_CONFIG_INPUT_FIELD_DATA structures that contain specific user input data obtained from
    ///an EAP configuration dialog box.
    EAP_CONFIG_INPUT_FIELD_DATA* pFields;
}

///The <b>EAP_CRED_EXPIRY_REQ</b> structure contains both the old and new EAP credentials for credential expiry
///operations.
struct EAP_CRED_EXPIRY_REQ
{
    ///EAP_CONFIG_INPUT_FIELD_ARRAY structure that contains the old EAP credentials.
    EAP_CONFIG_INPUT_FIELD_ARRAY curCreds;
    ///EAP_CONFIG_INPUT_FIELD_ARRAY structure that contains the new EAP credentials.
    EAP_CONFIG_INPUT_FIELD_ARRAY newCreds;
}

///The <b>EAP_UI_DATA_FORMAT</b> union specifies the value of the attribute stored in the <i>pbUiData</i> member of the
///EAP_INTERACTIVE_UI_DATA structure. The structure of the <b>EAP_UI_DATA_FORMAT</b> union depends on the value of
///<i>dwDataType</i> as specified in EAP_INTERACTIVE_UI_DATA.
union EAP_UI_DATA_FORMAT
{
    ///case(<i>EapCredReq</i>) If [EAP_CRED_REQ](/windows/win32/eaphost/eap-cred-req)structure. case(<i>EapCredResp</i>)
    ///If [EAP_CRED_RESP](/windows/win32/eaphost/eap-cred-resp) structure
    EAP_CONFIG_INPUT_FIELD_ARRAY* credData;
    ///case(<i>eapCredExpiryReq</i>) If <i>dwDataType</i> specifies a credential expiry request
    ///(<i>eapCredExpiryReq</i>), then the data pointed to by this parameter is defined by EAP_CRED_EXPIRY_REQ
    ///structure. case(<i>eapCredExpiryResp</i>) If <i>dwDataType</i> specifies a credential expiry response type
    ///(<i>eapCredExpiryResp</i>), then this parameter is defined by EAP_CRED_EXPIRY_RESP structure
    EAP_CRED_EXPIRY_REQ* credExpiryData;
    ///case(<i>EapCredLogonReq</i>) If [EAP_CRED_LOGON_REQ](/windows/win32/eaphost/eap-cred-logon-req) structure.
    ///case(<i>EapCredLogonResp</i>) If [EAP_CRED_LOGON_RESP](/windows/win32/eaphost/eap-cred-logon-resp) structure
    EAP_CONFIG_INPUT_FIELD_ARRAY* credLogonData;
}

///The <b>EAP_INTERACTIVE_UI_DATA</b> structure contains configuration information for interactive UI components raised
///on an EAP supplicant.
struct EAP_INTERACTIVE_UI_DATA
{
    ///The version of this data structure. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///id="EAP_INTERACTIVE_UI_DATA_VERSION"></a><a id="eap_interactive_ui_data_version"></a><dl>
    ///<dt><b>EAP_INTERACTIVE_UI_DATA_VERSION</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The version of the EAP
    ///interactive UI data. </td> </tr> </table>
    uint               dwVersion;
    ///The size of this entire structure, in bytes.
    uint               dwSize;
    ///An EAP_INTERACTIVE_UI_DATA_TYPE value that specifies the type of data pointed to by <i>pbUiData</i>.
    EAP_INTERACTIVE_UI_DATA_TYPE dwDataType;
    ///The size of the data pointed to by <i>pbUiData</i>, in bytes.
    uint               cbUiData;
    ///A pointer to an EAP_UI_DATA_FORMAT union that contains information about specific user interface components that
    ///correspond to the type specified in <i>dwDataType</i>.
    EAP_UI_DATA_FORMAT pbUiData;
}

///The <b>EAP_METHOD_PROPERTY_VALUE_BOOL</b> structure contains a Boolean value of an EAP method property.
struct EAP_METHOD_PROPERTY_VALUE_BOOL
{
    ///The size, in bytes, of <b>value</b>.
    uint length;
    ///<b>BOOL</b> value of the method property.
    BOOL value;
}

///The <b>EAP_METHOD_PROPERTY_VALUE_DWORD</b> structure contains the DWORD value of an EAP method property.
struct EAP_METHOD_PROPERTY_VALUE_DWORD
{
    ///The size, in bytes, of <b>value</b>.
    uint length;
    ///A DWORD value of the method property.
    uint value;
}

///The <b>EAP_METHOD_PROPERTY_VALUE_STRING</b> structure contains the string value of an EAP method property.
struct EAP_METHOD_PROPERTY_VALUE_STRING
{
    ///The size, in bytes, of <b>value</b>.
    uint   length;
    ubyte* value;
}

///The <b>EAP_METHOD_PROPERTY_VALUE</b> union contains the value of an EAP method property.
union EAP_METHOD_PROPERTY_VALUE
{
    ///case(<i>empvtBool</i>) If eapMethodPropertyValueType specifies a Boolean type (<i>empvtBool</i>), the data
    ///pointed to by this parameter is defined by the EAP_METHOD_PROPERTY_VALUE_BOOL structure.
    EAP_METHOD_PROPERTY_VALUE_BOOL empvBool;
    ///case(<i>empvDword</i>) If eapMethodPropertyValueType specifies a DWORD type (empvtDword), the data pointed to by
    ///this parameter is defined by the EAP_METHOD_PROPERTY_VALUE_DWORD structure.
    EAP_METHOD_PROPERTY_VALUE_DWORD empvDword;
    ///case(<i>empvString</i>) If eapMethodPropertyValueType specifies a BYTE *(empvtString), the data pointed to by
    ///this parameter is defined by the EAP_METHOD_PROPERTY_VALUE_STRING structure.
    EAP_METHOD_PROPERTY_VALUE_STRING empvString;
}

///An <b>EAP_METHOD_PROPERTY</b> structure contains an EAP method property.
struct EAP_METHOD_PROPERTY
{
    ///An EAP_METHOD_PROPERTY_TYPE enumeration value that describes the type of the EAP method property.
    EAP_METHOD_PROPERTY_TYPE eapMethodPropertyType;
    ///An EAP_METHOD_PROPERTY_VALUE_TYPE enumeration value that describes the data type of the value specified in
    ///<b>eapMethodPropertyValue</b>.
    EAP_METHOD_PROPERTY_VALUE_TYPE eapMethodPropertyValueType;
    ///An EAP_METHOD_PROPERTY_VALUE union that contains the method property value.
    EAP_METHOD_PROPERTY_VALUE eapMethodPropertyValue;
}

///The <b>EAP_METHOD_PROPERTY_ARRAY</b> structure contains an array of EAP method properties.
struct EAP_METHOD_PROPERTY_ARRAY
{
    ///The number of EAP_METHOD_PROPERTY structures in <b>pMethodProperty</b>.
    uint                 dwNumberOfProperties;
    ///Pointer to the address of the first element in an array of EAP_METHOD_PROPERTY structures. The total number of
    ///elements is specified in <b>dwNumberOfProperties</b>.
    EAP_METHOD_PROPERTY* pMethodProperty;
}

struct EAPHOST_IDENTITY_UI_PARAMS
{
    EAP_METHOD_TYPE eapMethodType;
    uint            dwFlags;
    uint            dwSizeofConnectionData;
    ubyte*          pConnectionData;
    uint            dwSizeofUserData;
    ubyte*          pUserData;
    uint            dwSizeofUserDataOut;
    ubyte*          pUserDataOut;
    const(wchar)*   pwszIdentity;
    uint            dwError;
    EAP_ERROR*      pEapError;
}

struct EAPHOST_INTERACTIVE_UI_PARAMS
{
    uint       dwSizeofContextData;
    ubyte*     pContextData;
    uint       dwSizeofInteractiveUIData;
    ubyte*     pInteractiveUIData;
    uint       dwError;
    EAP_ERROR* pEapError;
}

///The **EapUsernamePasswordCredential** structure contains the username and password that is used by the EAP method for
///authenticating the user.
struct EapUsernamePasswordCredential
{
    ///A NULL-terminated Unicode string that contains the username that needs authentication. The username uses the
    ///format user@domain or domain\user.
    const(wchar)* username;
    ///A NULL-terminated Unicode string that contains the password to verify the user. The password is encrypted using
    ///the [CredProtect](../wincred/nf-wincred-credprotectw.md) function. The EAP method must use the
    ///[CredUnprotect](../wincred/nf-wincred-credunprotecta.md) function to retrieve the unencrypted password.
    const(wchar)* password;
}

///The <b>EapCertificateCredential</b> structure contains information about the certificate that the EAP method uses for
///authentication.
struct EapCertificateCredential
{
    ///SHA1 hash of the certificate.
    ubyte[20]     certHash;
    ///If the certificate is present on the system and strong private key protection is turned on for this certificate,
    ///this field contains the password to access the certificate.
    const(wchar)* password;
}

///The <b>EapSimCredential</b> structure contains information about the SIM that is used by the EAP method for
///authentication.
struct EapSimCredential
{
    ///A NULL-terminated Unicode string that contains the ICC-ID of the SIM.
    const(wchar)* iccID;
}

union EapCredentialTypeData
{
    EapUsernamePasswordCredential username_password;
    EapCertificateCredential certificate;
    EapSimCredential sim;
}

///The <b>EapCredential</b> structure contains information about the credentials type and the appropriate credentials.
///This is passed as an input to the EapPeerGetConfigBlobAndUserBlob API.
struct EapCredential
{
    ///The EapCredentialType for the credentials passed in the <i>credentials</i> parameter.
    EapCredentialType credType;
    ///Structure that holds the pointer to the credential data. If <b>credType</b> is set to
    ///<b>EAP_EMPTY_CREDENTIAL</b>, specify a NULL value for credentials. If <b>credType</b> is set to
    ///<b>EAP_USERNAME_PASSWORD_CREDENTIAL</b>, use an EapUsernamePasswordCredential structure to specify the username
    ///and password to use for the credentials. If <b>credType</b> is set to <b>EAP_WINLOGON_CREDENTIAL</b>, specify a
    ///NULL value for credentials. If <b>credType</b> is set to <b>EAP_CERTIFICATE_CREDENTIAL</b>, use an
    ///EapCertificateCredential structure for credentials to specify the certificate hash and a password (in case the
    ///certificate is password protected). If <b>credType</b> is set to <b>EAP_SIM_CREDENTIAL</b>, use an
    ///EapSimCredential structure for credentials to specify the ICC-ID of the selected SIM.
    EapCredentialTypeData credData;
}

///The <b>EAPHOST_AUTH_INFO</b> structure describes current authentication information throughout different stages of
///the EAP authentication process.
struct EAPHOST_AUTH_INFO
{
    ///An EAPHOST_AUTH_STATUS enumeration value that specifies the current status of the authentication session.
    EAPHOST_AUTH_STATUS status;
    ///An error value, either from winerror.h or elsewhere (Raserror.h), that indicates the last error raised during the
    ///authentication process.
    uint                dwErrorCode;
    ///A reason code that specifies the reason the error in <b>dwErrorCode</b> was raised.
    uint                dwReasonCode;
}

///The <b>EapHostPeerMethodResult</b> structure contains the result data generated by EAPHost during an authentication
///session that is then passed to an EAP method.
struct EapHostPeerMethodResult
{
    ///If <b>TRUE</b>, the supplicant was successfully authenticated; if <b>FALSE</b>, it was not.
    BOOL             fIsSuccess;
    ///Contains a reason code if the supplicant could not be authenticated.
    uint             dwFailureReasonCode;
    ///If <b>TRUE</b>, the connection data specified in <b>pConnectionData</b> data must be persisted to disk;
    ///otherwise, it does not need to be saved.
    BOOL             fSaveConnectionData;
    ///The size, in bytes, of <b>pConnectionData</b>.
    uint             dwSizeofConnectionData;
    ubyte*           pConnectionData;
    ///If <b>TRUE</b>, the user data specified in <b>pUserData</b> data must be persisted to disk; otherwise, it does
    ///not need to be saved.
    BOOL             fSaveUserData;
    ///The size, in bytes, of <b>pUserData</b>.
    uint             dwSizeofUserData;
    ubyte*           pUserData;
    ///Pointer to an EAP_ATTRIBUTES array structure that contains attributes of the authentication session.
    EAP_ATTRIBUTES*  pAttribArray;
    ///An ISOLATION_STATElink value that indicates the isolation state of the authentication session connection.
    ISOLATION_STATE  isolationState;
    ///A pointer to an EAP_METHOD_INFO structure that contains information about the EAP method that performed
    ///authentication for the supplicant.
    EAP_METHOD_INFO* pEapMethodInfo;
    ///A pointer to the EAP_ERROR structure that contains any errors raised by EAPHost during the execution of this
    ///function call. After consuming the error data, this memory must be freed by calling EapHostPeerFreeEapError.
    EAP_ERROR*       pEapError;
}

///The <b>EapPacket</b> structure contains a packet of opaque data sent during an EAP authentication session.
struct EapPacket
{
    ///An EapCode enumeration value that identifies the packet type.
    ubyte    Code;
    ///The packet ID number.
    ubyte    Id;
    ///The length of the entire packet
    ubyte[2] Length;
    ///The packet message data. This opaque data block continues after the first byte for <b>Length</b> - 1 bytes.
    ubyte[1] Data;
}

///Contains authentication results returned by an EAP authenticator method.
struct EAP_METHOD_AUTHENTICATOR_RESULT
{
    ///If <b>TRUE</b>, the supplicant was successfully authenticated; if <b>FALSE</b>, it was not.
    BOOL            fIsSuccess;
    ///Contains a reason code if the supplicant could not be authenticated. Reason codes are generally expected to
    ///originate from winerror.h.
    uint            dwFailureReason;
    ///A pointer to an EAP_ATTRIBUTES structure that contains the EAP attributes returned by the authentication session.
    EAP_ATTRIBUTES* pAuthAttribs;
}

///Contains the action information returned by an EAP peer method.
struct EapPeerMethodOutput
{
    ///EapPeerMethodResponseAction enumeration value that indicates the response EAPHost should take as a result of the
    ///EAP peer method operation.
    EapPeerMethodResponseAction action;
    ///If <b>TRUE</b>, allows EAPHost to raise a notification to the user; otherwise, do not allow notifications.
    BOOL fAllowNotifications;
}

///Contains result data generated by an EAP method during authentication.
struct EapPeerMethodResult
{
    ///If <b>TRUE</b>, the supplicant was successfully authenticated; if <b>FALSE</b>, it was not.
    BOOL              fIsSuccess;
    ///Contains a reason code if the supplicant could not be authenticated.
    uint              dwFailureReasonCode;
    ///If <b>TRUE</b>, the connection data specified in <b>pConnectionData</b> data must be persisted to disk;
    ///otherwise, it does not need to be saved.
    BOOL              fSaveConnectionData;
    ///The size, in bytes, of <b>pConnectionData</b>.
    uint              dwSizeofConnectionData;
    ///A pointer to a byte buffer that contains information on the connection over which the EAP authentication session
    ///is held. The buffer can contain no more than <i>dwSizeOfConnectionData</i> elements.
    ubyte*            pConnectionData;
    ///If <b>TRUE</b>, the user data specified in <b>pUserData</b> data must be persisted to disk; otherwise, it does
    ///not need to be saved.
    BOOL              fSaveUserData;
    ///The size, in bytes, of <i>pUserData</i>.
    uint              dwSizeofUserData;
    ///A pointer to a byte buffer that contains information on the supplicant user that requested the EAP authentication
    ///session.The buffer can contain no more than <i>dwSizeofUserData</i> elements.
    ubyte*            pUserData;
    ///A pointer to an EAP_ATTRIBUTES array structure that contains the EAP attributes returned by the authentication
    ///session.
    EAP_ATTRIBUTES*   pAttribArray;
    ///A pointer to the EAP_ERROR structure that contains any errors raised during the execution of this function call.
    ///After consuming the error data, this memory must be freed by passing a pointer to EapPeerFreeErrorMemory.
    EAP_ERROR*        pEapError;
    ///Kerberos ticket.
    NgcTicketContext* pNgcKerbTicket;
    ///Whether or not to save to Credential Manager.
    BOOL              fSaveToCredMan;
}

///Contains a set of function pointers to the EAPHost Peer Method APIs.
struct EAP_PEER_METHOD_ROUTINES
{
    ///The implementer-defined structure version. <div class="alert"><b>Note</b> Values for this field are not defined
    ///by Microsoft.</div> <div> </div>
    uint      dwVersion;
    ///A pointer to an EAP_TYPE structure that contains the vendor information on the implementer of the APIs pointed to
    ///by the members of this structure.
    EAP_TYPE* pEapType;
    ///A function pointer for EapPeerInitialize.
    ptrdiff_t EapPeerInitialize;
    ///A function pointer for EapPeerGetIdentity.
    ptrdiff_t EapPeerGetIdentity;
    ///A function pointer for EapPeerBeginSession.
    ptrdiff_t EapPeerBeginSession;
    ///A function pointer for EapPeerSetCredentials.
    ptrdiff_t EapPeerSetCredentials;
    ///A function pointer for EapPeerProcessRequestPacket.
    ptrdiff_t EapPeerProcessRequestPacket;
    ///A function pointer for EapPeerGetResponsePacket.
    ptrdiff_t EapPeerGetResponsePacket;
    ///A function pointer for EapPeerGetResult.
    ptrdiff_t EapPeerGetResult;
    ///A function pointer for EapPeerGetUIContext.
    ptrdiff_t EapPeerGetUIContext;
    ///A function pointer for EapPeerSetUIContext.
    ptrdiff_t EapPeerSetUIContext;
    ///A function pointer for EapPeerGetResponseAttributes.
    ptrdiff_t EapPeerGetResponseAttributes;
    ///A function pointer for EapPeerSetResponseAttributes.
    ptrdiff_t EapPeerSetResponseAttributes;
    ///A function pointer for EapPeerEndSession.
    ptrdiff_t EapPeerEndSession;
    ///A function pointer for EapPeerShutdown.
    ptrdiff_t EapPeerShutdown;
}

///Contains a set of function pointers to the EAPHost Authenticator Method APIs.
struct EAP_AUTHENTICATOR_METHOD_ROUTINES
{
    ///The implementer defined structure version. <div class="alert"><b>Note</b> Values for this field are not defined
    ///by Microsoft.</div> <div> </div>
    uint             dwSizeInBytes;
    ///A pointer to an EAP_METHOD_TYPE structure that contains the vendor information on the implementor of the APIs
    ///pointed to by this structure's members.
    EAP_METHOD_TYPE* pEapType;
    ///Function pointer to EapMethodAuthenticatorInitialize.
    ptrdiff_t        EapMethodAuthenticatorInitialize;
    ///Function pointer to EapMethodAuthenticatorBeginSession.
    ptrdiff_t        EapMethodAuthenticatorBeginSession;
    ///Function pointer to EapMethodAuthenticatorUpdateInnerMethodParams.
    ptrdiff_t        EapMethodAuthenticatorUpdateInnerMethodParams;
    ///Function pointer to EapMethodAuthenticatorReceivePacket.
    ptrdiff_t        EapMethodAuthenticatorReceivePacket;
    ///Function pointer to EapMethodAuthenticatorSendPacket.
    ptrdiff_t        EapMethodAuthenticatorSendPacket;
    ///Function pointer to EapMethodAuthenticatorGetAttributes.
    ptrdiff_t        EapMethodAuthenticatorGetAttributes;
    ///Function pointer to EapMethodAuthenticatorSetAttributes.
    ptrdiff_t        EapMethodAuthenticatorSetAttributes;
    ///Function pointer to EapMethodAuthenticatorGetResult.
    ptrdiff_t        EapMethodAuthenticatorGetResult;
    ///Function pointer to EapMethodAuthenticatorEndSession.
    ptrdiff_t        EapMethodAuthenticatorEndSession;
    ///Function pointer to EapMethodAuthenticatorShutdown.
    ptrdiff_t        EapMethodAuthenticatorShutdown;
}

// Functions

///Enumerates all EAP methods installed and available for use, including legacy EAP Methods.
///Params:
///    pEapMethodInfoArray = A pointer to an EAP_METHOD_INFO_ARRAY structure for installed EAP methods. The caller should free the inner
///                          pointers using the function EapHostPeerFreeMemory, starting at the innermost pointer.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerGetMethods(EAP_METHOD_INFO_ARRAY* pEapMethodInfoArray, EAP_ERROR** ppEapError);

///The <b>EapHostPeerGetMethodProperties</b> function is used to retrieve the properties of an EAP method given the
///connection and user data.
///Params:
///    dwVersion = The version number of the API. Set this parameter to zero.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    eapMethodType = An EAP_METHOD_TYPE structure that specifies the EAP method the supplicant is to use.
///    hUserImpersonationToken = A handle to the user impersonation token to use in this session.
///    dwEapConnDataSize = The size, in bytes, of the connection data buffer provided in <i>pbEapConnData</i>.
///    pbEapConnData = Connection data used for the EAP method. If set to <b>NULL</b>, the static property of the method, as configured
///                    in the registry, is returned.
///    dwUserDataSize = The size, in bytes, of the user data buffer provided in <i>pbUserData</i>.
///    pbUserData = A pointer to a byte buffer that contains the opaque user data BLOB. This parameter can be <b>NULL</b>.
///    pMethodPropertyArray = A pointer to the method properties array EAP_METHOD_PROPERTY_ARRAY. Caller should free the inner pointers using
///                           EapHostPeerFreeMemory starting at the innermost pointer. The caller should free an <b>empvString</b> value only
///                           when the type is <b>empvtString</b>.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by passing a pointer to
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerGetMethodProperties(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                                    HANDLE hUserImpersonationToken, uint dwEapConnDataSize, char* pbEapConnData, 
                                    uint dwUserDataSize, char* pbUserData, 
                                    EAP_METHOD_PROPERTY_ARRAY* pMethodPropertyArray, EAP_ERROR** ppEapError);

///Starts the configuration user interface of the specified EAP method. <b>EapHostPeerInvokeConfigUI</b> must be called
///on threads that have COM initialized for Single Threaded Apartment (STA). This can be achieved by calling COM API
///CoInitialize; when the supplicant has finished with the STA thread CoUninitialize must be called before exiting.
///Params:
///    hwndParent = The handle of the parent window under which configuration dialog appears.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    eapMethodType = An EAP_METHOD_TYPE structure that specifies the EAP method.
///    dwSizeOfConfigIn = The size of input configuration. May be set to 0 (zero).
///    pConfigIn = A pointer to a byte buffer that contains configuration elements. The buffer is of size <i>dwSizeOfConfigIn</i>.
///                This parameter can be <b>NULL</b>, if <i>dwSizeOfConfigIn</i> is set to 0 (zero).
///    pdwSizeOfConfigOut = A pointer to a DWORD that specifies the size of the buffer pointed to by <i>ppConfigOut</i>.
///    ppConfigOut = A pointer to a pointer to a byte buffer that contains updated configuration data from the user. After consuming
///                  the data, this memory must be freed by calling EapHostPeerFreeMemory.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerInvokeConfigUI(HWND hwndParent, uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, 
                               char* pConfigIn, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_ERROR** ppEapError);

///Allows the user to determine what kind of credentials are required by the methods to perform authentication in a
///Single-Sign-On (SSO) scenario.
///Params:
///    hUserImpersonationToken = A handle to the user impersonation token to use in this session.
///    eapMethodType = An EAP_METHOD_TYPE structure that identifies the EAP method the supplicant is to use.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    dwEapConnDataSize = The size, in bytes, of the connection data buffer provided in <i>pbEapConnData.</i>
///    pbEapConnData = Connection data used for the EAP method.
///    pEapConfigInputFieldArray = A pointer to an EAP_METHOD_INFO_ARRAY structure for installed EAP methods. The caller should free the inner
///                                pointers using the function EapHostPeerFreeMemory, starting at the innermost pointer.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by passing a pointer to
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerQueryCredentialInputFields(HANDLE hUserImpersonationToken, EAP_METHOD_TYPE eapMethodType, 
                                           uint dwFlags, uint dwEapConnDataSize, char* pbEapConnData, 
                                           EAP_CONFIG_INPUT_FIELD_ARRAY* pEapConfigInputFieldArray, 
                                           EAP_ERROR** ppEapError);

///The <b>EapHostPeerQueryUserBlobFromCredentialInputFields</b> function obtains a credential BLOB that can be used to
///start authentication from user input received from the Single-Sign-On (SSO) UI.
///Params:
///    hUserImpersonationToken = A handle to the user impersonation token to use in this session.
///    eapMethodType = An EAP_METHOD_TYPE structure that specifies the type of EAP authentication to use for this session.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    dwEapConnDataSize = The size, in bytes, of the connection data buffer provided in <i>pConnectionData.</i>
///    pbEapConnData = Connection data used for the EAP method.
///    pEapConfigInputFieldArray = A pointer to an EAP_CONFIG_INPUT_FIELD_ARRAY structure the contains the UI input field data. The caller should
///                                free the inner pointers using the function EapHostPeerFreeMemory, starting at the innermost pointer.
///    pdwUserBlobSize = A pointer to a DWORD that specifies the size, in bytes, of the buffer pointed to by <i>ppbUserBlob</i>. If this
///                      value is not set to zero, then a pointer to a buffer of the size specified in this parameter must be supplied to
///                      <i>ppbUserBlob</i>.
///    ppbUserBlob = A pointer to the credential BLOB that can be used in authentication. Memory must be freed by calling
///                  EapHostPeerFreeMemory. If a non-null value is supplied for this parameter (meaning that an existing data BLOB is
///                  passed to it), the supplied data BLOB will be updated and returned in this parameter. If a non-NULL BLOB value is
///                  supplied, the LocalAlloc function should be used.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerQueryUserBlobFromCredentialInputFields(HANDLE hUserImpersonationToken, 
                                                       EAP_METHOD_TYPE eapMethodType, uint dwFlags, 
                                                       uint dwEapConnDataSize, char* pbEapConnData, 
                                                       const(EAP_CONFIG_INPUT_FIELD_ARRAY)* pEapConfigInputFieldArray, 
                                                       uint* pdwUserBlobSize, char* ppbUserBlob, 
                                                       EAP_ERROR** ppEapError);

///This function is called by tunnel methods to invoke the identity UI of the inner methods. This function returns the
///identity as well as credentials to use in order to start the authentication.
///Params:
///    dwVersion = The version number of the API. Must be set to zero.
///    eapMethodType = An EAP_METHOD_TYPE structure that specifies the type of EAP authentication to use for this session.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    hwndParent = Handle of the parent window under which the configuration dialog will show up.
///    dwSizeofConnectionData = Size of the buffer indicated by the <i>pConnectionData</i> parameter, in bytes.
///    pConnectionData = Pointer to configuration data that is used for the EAP method.
///    dwSizeofUserData = Size of the buffer indicated by the <i>pUserData</i> parameter, in bytes.
///    pUserData = Pointer to user credential information that pertains to this authentication.
///    pdwSizeOfUserDataOut = Size of the buffer set to receive the user data returned by the <i>ppUserDataOut</i> parameter, in bytes.
///    ppUserDataOut = A pointer to a pointer to a buffer that contains user data information returned by the method. After use, this
///                    memory must be freed by calling EapHostPeerFreeMemory.
///    ppwszIdentity = A pointer to a NULL-terminated user identity string. After use, this memory must be freed by calling
///                    EapHostPeerFreeMemory.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised during the execution of this
///                 function call. After consuming the error data, this memory must be freed by calling EapHostPeerFreeErrorMemory.
///    ppvReserved = Reserved for future use.
@DllImport("eappcfg")
uint EapHostPeerInvokeIdentityUI(uint dwVersion, EAP_METHOD_TYPE eapMethodType, uint dwFlags, HWND hwndParent, 
                                 uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, 
                                 char* pUserData, uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, 
                                 ushort** ppwszIdentity, EAP_ERROR** ppEapError, void** ppvReserved);

///Raises an interactive user interface used to get credentials from the user. For example, this function can be used to
///raise a UI that retrieves credentials from a smart card, and prompts the user to enter the corresponding PIN.
///<b>EapHostPeerInvokeInteractiveUI</b> must be called on threads that have COM initialized for Single Threaded
///Apartment. This can be achieved by calling COM API CoInitialize; when the supplicant has finished with the STA thread
///CoUninitialize must be called before exiting.
///Params:
///    hwndParent = The handle of the parent window under which configuration dialog appears.
///    dwSizeofUIContextData = The size, in bytes, of the buffer pointed to by the <i>pUIContextData</i> parameter.
///    pUIContextData = A pointer to a buffer that contains the supplicant UI context data from EAPHost. The context data is returned by
///                     EapHostPeerGetUIContext. The buffer is of size <i>dwSizeOfUIContextData</i>.
///    pdwSizeOfDataFromInteractiveUI = A pointer to a DWORD that represents the size, in bytes, of the buffer pointed to by the
///                                     <i>ppDataFromInteractiveUI</i> parameter.
///    ppDataFromInteractiveUI = A pointer to a pointer to a byte buffer that contains data from the interactive UI necessary for authentication
///                              to continue. The parameter <i>ppDataFromInteractiveUI</i> should be passed to EapHostPeerSetUIContext as the IN
///                              parameter <i>pUIContextData</i>. After consuming the data, this memory must be freed by calling
///                              EapHostPeerFreeMemory. The buffer is of size <i>pdwSizeofDataFromInteractiveUI</i>.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerInvokeInteractiveUI(HWND hwndParent, uint dwSizeofUIContextData, char* pUIContextData, 
                                    uint* pdwSizeOfDataFromInteractiveUI, ubyte** ppDataFromInteractiveUI, 
                                    EAP_ERROR** ppEapError);

///The <b>EapHostPeerQueryInteractiveUIInputFields</b> function obtains the input fields for interactive UI components
///to be raised on the supplicant.
///Params:
///    dwVersion = The version number of the API. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="EAPHOST_PEER_API_VERSION"></a><a id="eaphost_peer_api_version"></a><dl>
///                <dt><b>EAPHOST_PEER_API_VERSION</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The version of the EAPHost peer
///                API. </td> </tr> </table>
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    dwSizeofUIContextData = The size of the context data in <i>pUIContextData</i>, in bytes.
///    pUIContextData = Pointer to a BLOB that contains UI context data, represented as inner pointers to field data. These inner
///                     pointers must be freed by passing them to EapHostPeerFreeMemory, starting with the innermost pointer.
///    pEapInteractiveUIData = Pointer that receives an EAP_INTERACTIVE_UI_DATA structure that contains configuration information for
///                            interactive UI components raised on an EAP supplicant. The caller should free the inner pointers using the
///                            function EapHostPeerFreeMemory, starting at the innermost pointer.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
///    ppvReserved = Reserved for future use. This parameter must be set to 0.
@DllImport("eappcfg")
uint EapHostPeerQueryInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                              char* pUIContextData, EAP_INTERACTIVE_UI_DATA* pEapInteractiveUIData, 
                                              EAP_ERROR** ppEapError, void** ppvReserved);

///The <b>EapHostPeerQueryUIBlobFromInteractiveUIInputFields</b> function converts user information into a user BLOB
///that can be consumed by EAPHost run-time functions.
///Params:
///    dwVersion = The version number of the API. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="EAPHOST_PEER_API_VERSION"></a><a id="eaphost_peer_api_version"></a><dl>
///                <dt><b>EAPHOST_PEER_API_VERSION</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The version of the EAPHost Peer
///                APIs. </td> </tr> </table>
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    dwSizeofUIContextData = The size of the context data in <i>pUIContextData</i>, in bytes.
///    pUIContextData = Pointer to a BLOB that contains UI context data, represented as inner pointers to field data. These inner
///                     pointers must be freed by passing them to EapHostPeerFreeMemory, starting with the innermost pointer.
///    pEapInteractiveUIData = Pointer that receives an EAP_INTERACTIVE_UI_DATA structure that contains configuration information for
///                            interactive UI components raised on an EAP supplicant.
///    pdwSizeOfDataFromInteractiveUI = A pointer to a DWORD that specifies the size, in bytes, of the buffer pointed to by
///                                     <i>ppDataFromInteractiveUI</i>. If this value is not set to zero, then a pointer to a buffer of the size
///                                     specified in this parameter must be supplied to <i>ppDataFromInteractiveUI</i>.
///    ppDataFromInteractiveUI = Pointer that receives a credentials BLOB that can be used in authentication. The caller should free the inner
///                              pointers using the function EapHostPeerFreeMemory, starting at the innermost pointer. If a non-null value is
///                              supplied for this parameter (meaning that an existing data BLOB is passed to it), the supplied data BLOB will be
///                              updated and returned in this parameter. If a non-NULL BLOB value is supplied, the LocalAlloc function should be
///                              used.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
///    ppvReserved = Reserved for future use. This parameter must be set to 0.
@DllImport("eappcfg")
uint EapHostPeerQueryUIBlobFromInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                                        char* pUIContextData, 
                                                        const(EAP_INTERACTIVE_UI_DATA)* pEapInteractiveUIData, 
                                                        uint* pdwSizeOfDataFromInteractiveUI, 
                                                        ubyte** ppDataFromInteractiveUI, EAP_ERROR** ppEapError, 
                                                        void** ppvReserved);

///Converts XML into the configuration BLOB. When the supplicant starts authentication or calls
///EapHostPeerInvokeConfigUI, the supplicant calls <b>EapHostPeerConfigXml2Blob</b> to convert the XML configuration
///into a BLOB. The XML data to be converted could originate from a <b>EapHostPeerConfigBlob2Xml</b> call, or the data
///could originate from a XML created by a system administrator or other XML author.
///Params:
///    dwFlags = Not used. Set to 0.
///    pConfigDoc = Sends a pointer to the XML configuration to be converted.
///    pdwSizeOfConfigOut = A pointer to the size, in bytes, of the configuration BLOB.
///    ppConfigOut = A pointer to a pointer to a byte buffer that contains the configuration data converted from XML. The
///                  configuration data is created inside [EapHostConfig Schema](/windows/win32/eaphost/eaphostconfigschema-schema)
///                  element. The buffer is of size <i>pdwSizeOfConfigOut</i>. After consuming the data, this memory must be freed by
///                  calling EapHostPeerFreeMemory.
///    pEapMethodType = A pointer to an EAP_METHOD_TYPE structure referred to in the XML document.
///    ppEapError = A pointer a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution of
///                 this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerConfigXml2Blob(uint dwFlags, IXMLDOMNode pConfigDoc, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

///Generates the credentials BLOB. The credentials BLOB contains only user data such as user name, password, and PIN. A
///configuration BLOB, in contrast, contains the settings that control the behavior of the method.
///Params:
///    dwFlags = Not used. Set to 0.
///    pCredentialsDoc = A pointer to an XML node of a document that contains credentials which are either user or machine credentials
///                      depending on the configuration passed in. The XML document is created with the [EapHostUserCredentials
///                      Schema](/windows/win32/eaphost/eaphostusercredentialsschema-schema).
///    dwSizeOfConfigIn = The size, in bytes, of the buffer pointed to by the <i>pConfigIn</i> parameter.
///    pConfigIn = A pointer to a byte buffer that contains a configuration BLOB for which the credentials are configured. The
///                buffer is of size <i>dwSizeofConfigIn</i>.
///    pdwSizeOfCredentialsOut = The size, in bytes, of the buffer pointed to by <i>ppCredentialsOut</i>.
///    ppCredentialsOut = A pointer to a pointer to a byte buffer that receives the credentials BLOB buffer generated by the input XML. The
///                       buffer can is of size <i>pdwSizeofCredentialsOut</i>. After consuming the data, this memory must be freed by
///                       calling EapHostPeerFreeMemory.
///    pEapMethodType = A pointer to an EAP_METHOD_TYPE structure referred to in the XML document.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerCredentialsXml2Blob(uint dwFlags, IXMLDOMNode pCredentialsDoc, uint dwSizeOfConfigIn, 
                                    char* pConfigIn, uint* pdwSizeOfCredentialsOut, ubyte** ppCredentialsOut, 
                                    EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

///Converts the configuration BLOB to XML. The configuration BLOB is returned when the supplicant called one of the
///following methods.<ul> <li> EapHostPeerConfigXml2Blob </li> <li> EapHostPeerInvokeConfigUI </li> <li>
///EapHostPeerGetResult - via the EapHostPeerMethodResult structure</li> </ul>
///Params:
///    dwFlags = Not used. Set to 0.
///    eapMethodType = Refers to an EAP_METHOD_TYPE structure that is referred to in the XML document.
///    dwSizeOfConfigIn = The size, in bytes, of the configuration BLOB.
///    pConfigIn = A pointer to a buffer that contains the configuration BLOB to convert. The buffer is of size
///                <i>dwSizeOfConfigIn</i>.
///    ppConfigDoc = A pointer to a pointer to an XML document that contains the converted configuration. If the EAP method does not
///                  support the [EapHostConfig Schema](/windows/win32/eaphost/eaphostconfigschema-schema) element.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised by EAPHost during the execution
///                 of this function call. After consuming the error data, this memory must be freed by calling
///                 EapHostPeerFreeErrorMemory.
@DllImport("eappcfg")
uint EapHostPeerConfigBlob2Xml(uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, char* pConfigIn, 
                               IXMLDOMDocument2* ppConfigDoc, EAP_ERROR** ppEapError);

///Frees memory returned by the configuration APIs. Do not use this function to free memory allocated to an EAP_ERROR
///structure. Use EapHostPeerFreeErrorMemory to free error memory.
///Params:
///    pData = A pointer to the memory to free.
@DllImport("eappcfg")
void EapHostPeerFreeMemory(ubyte* pData);

///Frees memory allocated to an [EAPHost supplicant configuration
///function](/windows/win32/eaphost/eap-host-supplicant-configuration-functions) fails. The
///<b>EapHostPeerFreeErrorMemory</b> function is used only for freeing EAP_ERROR structures returned by EAPHost
///configuration APIs, while the EapHostPeerFreeEapError function is used for freeing <b>EAP_ERROR</b> structures
///returned by EAPHost run-time APIs. If any of the following configuration APIs functions are called, and an EAP_ERROR
///is returned, <b>EapHostPeerFreeErrorMemory</b> must be called to free the memory:<ul> <li> EapHostPeerConfigBlob2Xml
///</li> <li> EapHostPeerConfigXml2Blob </li> <li> EapHostPeerCredentialsXml2Blob </li> <li> EapHostPeerInvokeConfigUI
///</li> <li> EapHostPeerQueryCredentialsInputFields </li> <li> EapHostPeerQueryUserBlobFromCredentialsInputFields </li>
///</ul> <div class="alert"><b>Note</b> EAPHost run-time APIs are defined in eappapis.h. EAPHost configuration APIs are
///defined in EapHostPeerConfigApis.h. </div><div> </div>
///Params:
///    pEapError = A pointer to an EAP_ERROR structure that contains the error data to free.
@DllImport("eappcfg")
void EapHostPeerFreeErrorMemory(EAP_ERROR* pEapError);

///Initializes an EAPHost authentication session. The <b>EapHostPeerInitialize</b> function must be called before any
///other peer or supplicant function is called. If the <b>EapHostPeerInitialize</b> function fails, do not call any
///other EAPHost run-time API. <div class="alert"><b>Note</b> The other EAPHost configuration APIs aren't affected by
///the failure of <b>EAPHostPeerInitialize.</b></div> <div> </div>
@DllImport("eappprxy")
uint EapHostPeerInitialize();

///Uninitializes all EAPHost authentication sessions. The <b>EapHostPeerUninitialize</b> function must be called after
///you are finished calling EAPHost supplicant run-time functions. In addition, if any re-authentication is expected for
///any reason it is best to call <b>EapHostPeerUninitialize</b>.
@DllImport("eappprxy")
void EapHostPeerUninitialize();

///Starts an EAP authentication session. If the <b>EapHostPeerBeginSession</b> function succeeds, the caller must also
///call EapHostPeerEndSession to end the authentication session. The latter function must be called regardless of
///whether functions other than <b>EapHostPeerBeginSession</b> succeed or fail. If re-authentication is required,
///regardless of the reason, the interface represented by the parameter <i>pConnectionId</i> will be unregistered. In
///cases where <i>pConnectionId</i> is unregistered, you must also call EapHostPeerClearConnection to remove the
///connection. Never call <b>EapHostPeerBeginSession</b> again on an interface without calling EapHostPeerEndSession.
///Only one authentication session can be active on the interface specified by <i>pConnectionId</i>.
///Params:
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the new EAP authentication
///              session behavior.
///    eapType = An EAP_METHOD_TYPE structure that specifies the type of EAP authentication to use for this session.
///    pAttributeArray = Pointer to an EapAttributes structure that specifies the EAP attributes of the entity to authenticate.
///    hTokenImpersonateUser = Handle to the user impersonation token to use in this session.
///    dwSizeofConnectionData = The size, in bytes, of the connection data buffer provided in <i>pConnectionData</i>.
///    pConnectionData = Describes the configuration used for authentication. <b>NULL</b> connection data is considered valid. The method
///                      should work with the default configuration.
///    dwSizeofUserData = The size, in bytes, of the user data buffer provided in <i>pUserData</i>.
///    pUserData = A pointer to a byte buffer that contains the opaque user data BLOB containing user data returned from the
///                EapPeerGetIdentity function. User data may include credentials or certificates used for authentication.
///                <i>pUserData</i> can be <b>NULL</b>. The interpretation of a <b>NULL</b> pointer depends on the implementation of
///                a method. The user data consists of user or machine credentials used for authentication. Typically the user data
///                depends on the configuration data. If <b>EAP_FLAG_PREFER_ALT_CREDENTIALS</b> is indicated in <i>dwflags</i>, then
///                credentials passed into EapPeerBeginSession are preferred to all other forms of credential retrieval, even if
///                configuration data passed into <i>pConnectionData</i> requests a different mode of credential retrieval. If
///                passing credentials into <b>EapPeerBeginSession</b> fails, then EAPHost resorts to method specific credential
///                retrieval, in which case credentials could be obtained from a file, Windows login, or a certificate store, for
///                example. The EAP method author defines both the default credentials and alternate credentials. For example, in
///                the case of EAP-MSCHAPv2 the default credentials are Windows credentials obtained from winlogon, and alternate
///                credentials are the credentials (user name, password, domain) passed into <i>pUserData</i>.
///    dwMaxSendPacketSize = The maximum size, in bytes, of an EAP packet that can be sent during the session.
///    pConnectionId = A pointer to a GUID value that uniquely identifies the logical network interface over which the authentication of
///                    the supplicant will take place. If the supplicant seeks re-authentication after a NAP health change, it should
///                    provide a unique GUID. The parameter should be <b>NULL</b> when this function is called by a tunneling method to
///                    start its inner method. When the <i>pConnectionId</i> parameter is <b>NULL</b>, the <i>func</i> and
///                    <i>pContextData</i> parameters are ignored.
///    func = A NotificationHandler function pointer that provides the callback used by EAPHost to notify the supplicant when
///           re-authentication is needed. If the function handler is <b>NULL</b>, the <i>pContextData</i> parameter is
///           ignored. If the function handler is <b>NULL</b>, it also means that the caller is not interested in SoH change
///           notification from the EAP quarantine enforcement client (QEC). The following code shows a NotificationHandler
///           callback call. <pre class="syntax" xml:space="preserve"><code>func(*pConnectionId, pContextData);</code></pre>
///    pContextData = A pointer to re-authentication context data that the supplicant will associate with the connection when
///                   <i>func</i> is called. This parameter can be <b>NULL</b>.
///    pSessionId = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                 session on the EAPHost server.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerBeginSession(uint dwFlags, EAP_METHOD_TYPE eapType, const(EAP_ATTRIBUTES)* pAttributeArray, 
                             HANDLE hTokenImpersonateUser, uint dwSizeofConnectionData, 
                             const(ubyte)* pConnectionData, uint dwSizeofUserData, const(ubyte)* pUserData, 
                             uint dwMaxSendPacketSize, const(GUID)* pConnectionId, NotificationHandler func, 
                             void* pContextData, uint* pSessionId, EAP_ERROR** ppEapError);

///Is called by the supplicant every time the supplicant receives a packet that EAPHost needs to process.
///<b>EapHostPeerProcessReceivedPacket</b> should be called only after a successful call to EapHostPeerBeginSession.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession. <i>sessionHandle</i> can be zero if the supplicant receives a new identity request not
///                    associated with any session.
///    cbReceivePacket = The size, in bytes, of the received packet buffer pointed to by the <i>cbReceivePacket</i> parameter.
///    pReceivePacket = A pointer to a buffer that contains the incoming EAP data received by the supplicant.
///    pEapOutput = A pointer to an EapHostPeerResponseAction value that indicates the supplicant should take appropriate action.
///                 Typically the supplicant either calls another method on EAPHost or acts on its own.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerProcessReceivedPacket(uint sessionHandle, uint cbReceivePacket, const(ubyte)* pReceivePacket, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

///Is called by the supplicant when the supplicant needs to obtains a packet from EAPHost to send to the authenticator.
///<b>EapHostPeerGetSendPacket</b> is called when the supplicant receives the EapHostPeerResponseAction enumerator from
///the server.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    pcbSendPacket = A pointer to a DWORD that specifies the maximum size, in bytes, of the buffer pointed to by <i>ppSendPacket</i>.
///                    <b>EapHostPeerGetSendPacket</b> on return is the size of the actual data pointed to by <i>ppSendPacket</i>.
///    ppSendPacket = A pointer to a pointer to a buffer that contains the packet data returned by the EAP module. The buffer is
///                   allocated by EAPHost.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerGetSendPacket(uint sessionHandle, uint* pcbSendPacket, ubyte** ppSendPacket, 
                              EAP_ERROR** ppEapError);

///Obtains the authentication result for the specified EAP authentication session.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    reason = An EapHostPeerMethodResultReason enumeration value that specifies the reason code for the authentication result
///             returned in <i>ppResult</i>.
///    ppResult = A pointer to a EapHostPeerMethodResultReason structure that contains the authentication results. EAPHost fills
///               this structure with authentication related information defined in EapHostPeerMethodResult.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. Supplicants must refer to this parameter to
///                 determine if the authentication was successful. After using the error data, free this memory by calling
///                 EapHostPeerFreeEapError.
///Returns:
///    If the function succeeds, the return value is <b>NO_ERROR</b>. The return value does not indicate if the
///    authentication was successful. Supplicants must refer to the <i>ppEapError</i> parameter to determine the
///    authentication result. If the function fails, the return value should be an appropriate error code from
///    Winerror.h, Raserror.h, or Mprerror.h.
///    
@DllImport("eappprxy")
uint EapHostPeerGetResult(uint sessionHandle, EapHostPeerMethodResultReason reason, 
                          EapHostPeerMethodResult* ppResult, EAP_ERROR** ppEapError);

///Obtains the user interface context for the supplicant from EAPHost if the UI is to be raised.
///<b>EAPHostPeerGetUIContext</b> is always followed by the following functions.<ul> <li>
///EapHostPeerInvokeInteractiveUI, and</li> <li> EapHostPeerSetUIContext </li> </ul>
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    pdwSizeOfUIContextData = A pointer to a value that specifies the size, in bytes, of the UI context data buffer returned in
///                             <i>ppUIContextData</i>.
///    ppUIContextData = A pointer to a pointer to a buffer that contains the supplicant UI context data from EAPHost. The address pointed
///                      to by this parameter is passed to EapHostPeerInvokeInteractiveUI as IN parameter <i>pUIContextData</i>.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerGetUIContext(uint sessionHandle, uint* pdwSizeOfUIContextData, ubyte** ppUIContextData, 
                             EAP_ERROR** ppEapError);

///Provides a new or updated user interface context to the EAP peer method loaded on EAPHost after the UI has been
///raised. For more information about raising the UI, see EapHostPeerGetUIContext. <b>EapHostPeerSetUIContext</b> sets
///the UI context data that was received from a call to EapHostPeerInvokeInteractiveUI.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    dwSizeOfUIContextData = The size, in bytes, of the user interface context data buffer provided in <i>pUIContextData</i>.
///    pUIContextData = A pointer to a byte buffer that contains the new supplicant UI context data to be set on EAPHost. The data is
///                     returned from the EapHostPeerInvokeInteractiveUI OUT parameter.
///    pEapOutput = A pointer to an EapHostPeerResponseAction enumeration value that specifies the action code for the next step the
///                 supplicant must take as a response.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerSetUIContext(uint sessionHandle, uint dwSizeOfUIContextData, const(ubyte)* pUIContextData, 
                             EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

///Obtains an array of EAP authentication attributes from EAPHost. After calling <b>EapHostPeerGetResponseAttributes</b>
///and finishing the processing of EAP attributes, the supplicant should call EapHostPeerSetResponseAttributes.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    pAttribs = A pointer to an EAP_ATTRIBUTES structure that contains an array of EAP authentication response attributes for the
///               supplicant.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerGetResponseAttributes(uint sessionHandle, EAP_ATTRIBUTES* pAttribs, EAP_ERROR** ppEapError);

///Provides updated EAP authentication attributes to EAPHost.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    pAttribs = A pointer to an EapAttributes structure that contains an array of new EAP authentication response attributes to
///               set for the supplicant on EAPHost.
///    pEapOutput = A pointer to an EapHostPeerResponseAction enumeration value that specifies the action code for the next step the
///                 supplicant must take as a response.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerSetResponseAttributes(uint sessionHandle, const(EAP_ATTRIBUTES)* pAttribs, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

///Obtains the supplicant's current EAP authentication status from EAPHost.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    authParam = An EapHostPeerAuthParams enumeration value that specifies the type of EAP authentication data to obtain from
///                EAPHost. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="EapHostPeerAuthStatus"></a><a id="eaphostpeerauthstatus"></a><a id="EAPHOSTPEERAUTHSTATUS"></a><dl>
///                <dt><b>EapHostPeerAuthStatus</b></dt> </dl> </td> <td width="60%"> <i>ppAuthData</i> contains a EAPHOST_AUTH_INFO
///                structure. </td> </tr> <tr> <td width="40%"><a id="EapHostPeerIdentity"></a><a id="eaphostpeeridentity"></a><a
///                id="EAPHOSTPEERIDENTITY"></a><dl> <dt><b>EapHostPeerIdentity</b></dt> </dl> </td> <td width="60%">
///                <i>ppAuthData</i> contains a <b>WCHAR</b> buffer. </td> </tr> <tr> <td width="40%"><a
///                id="EapHostPeerIdentityExtendedInfo"></a><a id="eaphostpeeridentityextendedinfo"></a><a
///                id="EAPHOSTPEERIDENTITYEXTENDEDINFO"></a><dl> <dt><b>EapHostPeerIdentityExtendedInfo</b></dt> </dl> </td> <td
///                width="60%"> <i>ppAuthData</i> contains a <b>CHAR</b> buffer. </td> </tr> <tr> <td width="40%"><a
///                id="EapHostNapInfo"></a><a id="eaphostnapinfo"></a><a id="EAPHOSTNAPINFO"></a><dl> <dt><b>EapHostNapInfo</b></dt>
///                </dl> </td> <td width="60%"> Windows 7 or later: [EapHostPeerNapInfo](/windows/win32/eaphost/eaphostpeernapinfo)
///                structure. </td> </tr> </table>
///    pcbAuthData = The size, in bytes, of the EAP authentication data buffer pointed to by the <i>ppAuthData</i> parameter.
///    ppAuthData = A pointer to a pointer to a byte buffer that contains the authentication data from EAPHost. The format of this
///                 data depends on the value supplied in <i>authParam</i>.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerGetAuthStatus(uint sessionHandle, EapHostPeerAuthParams authParam, uint* pcbAuthData, 
                              ubyte** ppAuthData, EAP_ERROR** ppEapError);

///Terminates the current EAP authentication session between EAPHost and the calling supplicant, and clears data stored
///for the session.After this call the session is no longer valid.
///Params:
///    sessionHandle = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                    session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                    EapHostPeerBeginSession.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerEndSession(uint sessionHandle, EAP_ERROR** ppEapError);

///Returns the<b> Connection Id</b>,<b>User Impersonation Token</b> and <b>Eaphost Process Id </b>used by EAPHost to
///save the credentials for SSO. This data is needed to unplumb previously plumbed credentials. <div
///class="alert"><b>Important</b> Unplumbing of credentials (plumbed as part of the SSO experience) on disconnection is
///no longer performed by EAPHost. Unplumbing of credentials now needs to be performed by the supplicant. </div><div>
///</div>
///Params:
///    pConnectionIdThatLastSavedCreds = The GUID of the EAP peer session that last plumbed credentials.
///    phCredentialImpersonationToken = Handle to impersonate the user at the time of plumbing credentials. The user can be impersonated by a call to
///                                     <b>ImpersonateLoggedOnUser</b>.
///    sessionHandle = A pseudo handle to the EAPHost process. This is the __int3264 value returned to EAPHost when it called
///                    GetCurrentProcess.
///    ppEapError = A pointer to an <b>EAP_SESSIONID</b> structure that contains the unique handle for this EAP authentication
///                 session on the EAPHost server. This handle is returned in the <i>pSessionId</i> parameter in a previous call to
///                 EapHostPeerBeginSession.
///    fSaveToCredMan = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                     function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                     errors raised during the execution of this function call is received. After using the error data, free this
///                     memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerGetDataToUnplumbCredentials(GUID* pConnectionIdThatLastSavedCreds, 
                                            int* phCredentialImpersonationToken, uint sessionHandle, 
                                            EAP_ERROR** ppEapError, int* fSaveToCredMan);

///Clears the authentication session connection. After <b>EapHostPeerClearConnection</b> is called, all states
///associated with <i>pConnectionId</i> are deleted, and no re-authentication associated with this GUID will be
///initiated. In addition, all future callbacks to the NotificationHandler callback function (which was passed by the
///calling supplicant in a previous call to EapHostPeerBeginSession) are halted.
///Params:
///    pConnectionId = A pointer to a GUID value that uniquely identifies a logical network interface for a connection to terminate
///                    between the supplicant and the EAPHost. This connection ID must have been provided in a previous call to
///                    EapHostPeerBeginSession.
///    ppEapError = A pointer to the address of an EAP_ERROR structure. The address should be set to <b>NULL</b> before calling this
///                 function. If error data is available, a pointer to the address of an <b>EAP_ERROR</b> structure that contains any
///                 errors raised during the execution of this function call is received. After using the error data, free this
///                 memory by calling EapHostPeerFreeEapError.
@DllImport("eappprxy")
uint EapHostPeerClearConnection(GUID* pConnectionId, EAP_ERROR** ppEapError);

///Frees EAP_ERROR structures returned by EAPHost run-time APIs. In contrast, the EapHostPeerFreeErrorMemory function is
///used only for freeing EAP_ERROR structures returned by EAPHost configuration APIs. If any of the following run-time
///APIs are called and an EAP_ERROR is returned, <b>EapHostPeerFreeEapError</b> must be called to free the memory:<ul>
///<li> EapHostPeerBeginSession </li> <li> EapHostPeerClearConnection </li> <li> EapHostPeerEndSession </li> <li>
///EapHostPeerGetAuthStatus </li> <li> EapHostPeerGetResponseAttributes </li> <li> EapHostPeerGetResult </li> <li>
///EapHostPeerGetSendPacket </li> <li> EapHostPeerGetUIContext </li> <li> EapHostPeerProcessReceivedPacket </li> <li>
///EapHostPeerSetResponseAttributes </li> <li> EapHostPeerSetUIContext </li> </ul> <div class="alert"><b>Note</b>
///EAPHost run-time APIs are defined in eappapis.h. EAPHost configuration APIs are defined in
///EapHostPeerConfigApis.h.</div><div> </div>
///Params:
///    pEapError = A pointer to an EAP_ERROR structure that contains the error data to free.
@DllImport("eappprxy")
void EapHostPeerFreeEapError(EAP_ERROR* pEapError);

///This function is called by tunnel methods to request identity information from the inner methods. This function
///returns the identity and user credential information.
///Params:
///    dwVersion = The version number of the API. Must be set to zero.
///    dwFlags = A combination of [EAP flags](/windows/win32/eaphost/eap-method-flags) that describe the EAP authentication
///              session behavior.
///    eapMethodType = An EAP_METHOD_TYPE structure that specifies the type of EAP authentication to use for this session.
///    dwSizeofConnectionData = Size of the buffer indicated by the <i>pConnectionData</i> parameter, in bytes.
///    pConnectionData = Pointer to configuration data that is used for the EAP method.
///    dwSizeofUserData = Size of the buffer indicated by the <i>pUserData</i> parameter, in bytes.
///    pUserData = Pointer to user credential information that pertains to this authentication session.
///    hTokenImpersonateUser = Impersonation token for a logged-on user to collect user-related information.
///    pfInvokeUI = Returns <b>TRUE</b> if the user identity and user data blob aren't returned successfully, and the method seeks to
///                 collect the information from the user through the user interface dialog.
///    pdwSizeOfUserDataOut = Size of the buffer indicated by the <i>ppUserDataOut</i> parameter, in bytes.
///    ppUserDataOut = User data information returned by the method. After use, this memory must be freed by calling
///                    EapHostPeerFreeRuntimeMemory.
///    ppwszIdentity = A pointer to a NULL-terminated user identity string. After use, this memory must be freed by calling
///                    EapHostPeerFreeRuntimeMemory.
///    ppEapError = A pointer to a pointer to an EAP_ERROR structure that contains any errors raised during the execution of this
///                 function call. After consuming the error data, this memory must be freed by calling EapHostPeerFreeErrorMemory.
///    ppvReserved = Reserved for future use
@DllImport("eappprxy")
uint EapHostPeerGetIdentity(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                            uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, 
                            char* pUserData, HANDLE hTokenImpersonateUser, int* pfInvokeUI, 
                            uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, ushort** ppwszIdentity, 
                            EAP_ERROR** ppEapError, ubyte** ppvReserved);

@DllImport("eappprxy")
uint EapHostPeerGetEncryptedPassword(uint dwSizeofPassword, const(wchar)* szPassword, ushort** ppszEncPassword);

///Releases the memory space used during run-time.
///Params:
///    pData = A pointer to a buffer returned by any EapHost peer run-time API.
@DllImport("eappprxy")
void EapHostPeerFreeRuntimeMemory(ubyte* pData);


// Interfaces

@GUID("66A2DB16-D706-11D0-A37B-00C04FC9DA04")
interface IRouterProtocolConfig : IUnknown
{
    HRESULT AddProtocol(ushort* pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, uint dwFlags, 
                        IUnknown pRouter, size_t uReserved1);
    HRESULT RemoveProtocol(ushort* pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, uint dwFlags, 
                           IUnknown pRouter, size_t uReserved1);
}

@GUID("66A2DB17-D706-11D0-A37B-00C04FC9DA04")
interface IAuthenticationProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, size_t* puConnectionParam);
    HRESULT Uninitialize(size_t uConnectionParam);
    HRESULT Configure(size_t uConnectionParam, HWND hWnd, uint dwFlags, size_t uReserved1, size_t uReserved2);
    HRESULT Activate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
    HRESULT Deactivate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
}

@GUID("66A2DB18-D706-11D0-A37B-00C04FC9DA04")
interface IAccountingProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, size_t* puConnectionParam);
    HRESULT Uninitialize(size_t uConnectionParam);
    HRESULT Configure(size_t uConnectionParam, HWND hWnd, uint dwFlags, size_t uReserved1, size_t uReserved2);
    HRESULT Activate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
    HRESULT Deactivate(size_t uConnectionParam, size_t uReserved1, size_t uReserved2);
}

///The **IEAPProviderConfig** interface is used to initialize, configure and shut down EAP configuration sessions.
@GUID("66A2DB19-D706-11D0-A37B-00C04FC9DA04")
interface IEAPProviderConfig : IUnknown
{
    ///The system calls the <b>Initialize</b> method to initialize an EAP configuration session with the specified
    ///computer.
    ///Params:
    ///    pszMachineName = Pointer to a null-terminated string that contains the name of the computer on which to configure EAP. String
    ///                     length is not limited.
    ///    dwEapTypeId = Specifies the EAP for which to initialize a configuration session.
    ///    puConnectionParam = Pointer to an unsigned integer variable. On successful return, the value of this variable identifies this
    ///                        configuration session.
    ///Returns:
    ///    If the function succeeds, the return value should be <b>S_OK</b>. If the function fails, the return value
    ///    should be one of the following codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Non-specific error. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method failed because it was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. </td> </tr> </table>
    ///    
    HRESULT Initialize(ushort* pszMachineName, uint dwEapTypeId, size_t* puConnectionParam);
    ///The system calls the <b>Uninitialize</b> method to shut down the specified EAP configuration session.
    ///Params:
    ///    dwEapTypeId = Specifies the EAP for which to shut down the configuration session.
    ///    uConnectionParam = Specifies the configuration session to shut down.
    ///Returns:
    ///    If the function succeeds, the return value should be <b>S_OK</b>. If the function fails, the return value
    ///    should be one of the following codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Non-specific error. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method failed because it was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. </td> </tr> </table>
    ///    
    HRESULT Uninitialize(uint dwEapTypeId, size_t uConnectionParam);
    ///The system calls the <b>ServerInvokeConfigUI</b> method to invoke the configuration user interface for EAP
    ///authentication between a remote access client and server.
    ///Params:
    ///    dwEapTypeId = Specifies the EAP for which to invoke the configuration user interface.
    ///    uConnectionParam = Specifies the configuration session for which to invoke the user interface.
    ///    hWnd = Handle to the parent window for the configuration user interface.
    ///    uReserved1 = This parameter is reserved and should be zero.
    ///    uReserved2 = This parameter is reserved and should be zero.
    ///Returns:
    ///    If the function succeeds, the return value should be <b>S_OK</b>. If the function fails, the return value
    ///    should be one of the following codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Non-specific error. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method failed because it was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. </td> </tr> </table>
    ///    
    HRESULT ServerInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, size_t uReserved1, 
                                 size_t uReserved2);
    ///The system calls the <b>RouterInvokeConfigUI</b> method to invoke the configuration user interface for EAP
    ///authentication between two routers.
    ///Params:
    ///    dwEapTypeId = Specifies the EAP for which to invoke the configuration user interface.
    ///    uConnectionParam = Specifies the configuration session for which to invoke the user interface.
    ///    hwndParent = Handle to the parent window for the configuration user interface.
    ///    dwFlags = Specifies the RAS_EAP_FLAG_ROUTER flag. This is the only valid flag for this parameter. It indicates that
    ///              authentication is between two routers. This parameter always includes this flag.
    ///    pConnectionDataIn = Pointer to the current configuration data for the interface.
    ///    dwSizeOfConnectionDataIn = Specifies the size of the current configuration data pointed to by the <i>pConnectionDataIn</i> parameter.
    ///    ppConnectionDataOut = Pointer to a pointer to a buffer that contains the new configuration data for the interface.
    ///    pdwSizeOfConnectionDataOut = Pointer to a <b>DWORD</b> variable to receive the size of the new configuration data.
    ///Returns:
    ///    If the function succeeds, the return value should be <b>S_OK</b>. If the function fails, the return value
    ///    should be one of the following codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Non-specific error. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method failed because it was unable to allocate required memory. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. </td> </tr> </table>
    ///    
    HRESULT RouterInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hwndParent, uint dwFlags, 
                                 ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, 
                                 ubyte** ppConnectionDataOut, uint* pdwSizeOfConnectionDataOut);
    ///The system calls the <b>RouterInvokeCredentialsUI</b> method to invoke the credentials user interface for EAP
    ///authentication between two routers.
    ///Params:
    ///    dwEapTypeId = Specifies the EAP for which to invoke the configuration user interface.
    ///    uConnectionParam = Specifies the configuration session for which to invoke the user interface.
    ///    hwndParent = Handle to the parent window for the configuration user interface.
    ///    dwFlags = Specifies the RAS_EAP_FLAG_ROUTER flag. This is the only valid flag for this parameter. It indicates that
    ///              authentication is between two routers. This parameter always includes this flag.
    ///    pConnectionDataIn = Pointer to the current configuration data for the interface.
    ///    dwSizeOfConnectionDataIn = Specifies the size of the current configuration data pointed to by the <i>pConnectionDataIn</i> parameter.
    ///    pUserDataIn = Pointer to the current credential data for the interface.
    ///    dwSizeOfUserDataIn = Specifies the size of the current credentials data.
    ///    ppUserDataOut = Pointer to a pointer to a buffer to receive the new credentials data for the interface.
    ///    pdwSizeOfUserDataOut = Pointer to a <b>DWORD</b> variable to receive the size of the new credentials data.
    ///Returns:
    ///    If the function succeeds, the return value should be <b>S_OK</b>. If the function fails, the return value
    ///    should be one of the following codes. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> Non-specific error. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is
    ///    invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%">
    ///    The method failed because it was unable to allocate the required memory. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. </td> </tr>
    ///    </table>
    ///    
    HRESULT RouterInvokeCredentialsUI(uint dwEapTypeId, size_t uConnectionParam, HWND hwndParent, uint dwFlags, 
                                      ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, ubyte* pUserDataIn, 
                                      uint dwSizeOfUserDataIn, ubyte** ppUserDataOut, uint* pdwSizeOfUserDataOut);
}

@GUID("D565917A-85C4-4466-856E-671C3742EA9A")
interface IEAPProviderConfig2 : IEAPProviderConfig
{
    HRESULT ServerInvokeConfigUI2(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, 
                                  const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, ubyte** ppConfigDataOut, 
                                  uint* pdwSizeOfConfigDataOut);
    HRESULT GetGlobalConfig(uint dwEapTypeId, ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut);
}

@GUID("B78ECD12-68BB-4F86-9BF0-8438DD3BE982")
interface IEAPProviderConfig3 : IEAPProviderConfig2
{
    HRESULT ServerInvokeCertificateConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, 
                                            const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, 
                                            ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut, size_t uReserved);
}


// GUIDs


const GUID IID_IAccountingProviderConfig     = GUIDOF!IAccountingProviderConfig;
const GUID IID_IAuthenticationProviderConfig = GUIDOF!IAuthenticationProviderConfig;
const GUID IID_IEAPProviderConfig            = GUIDOF!IEAPProviderConfig;
const GUID IID_IEAPProviderConfig2           = GUIDOF!IEAPProviderConfig2;
const GUID IID_IEAPProviderConfig3           = GUIDOF!IEAPProviderConfig3;
const GUID IID_IRouterProtocolConfig         = GUIDOF!IRouterProtocolConfig;
