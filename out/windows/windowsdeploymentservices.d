// Written in the D programming language.

module windows.windowsdeploymentservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE, ULARGE_INTEGER;
public import windows.windowsandmessaging : LPARAM, WPARAM;
public import windows.windowsprogramming : HKEY, SYSTEMTIME;

extern(Windows):


// Enums


alias WDS_CLI_IMAGE_TYPE = int;
enum : int
{
    WDS_CLI_IMAGE_TYPE_UNKNOWN = 0x00000000,
    WDS_CLI_IMAGE_TYPE_WIM     = 0x00000001,
    WDS_CLI_IMAGE_TYPE_VHD     = 0x00000002,
    WDS_CLI_IMAGE_TYPE_VHDX    = 0x00000003,
}

alias WDS_CLI_FIRMWARE_TYPE = int;
enum : int
{
    WDS_CLI_FIRMWARE_UNKNOWN = 0x00000000,
    WDS_CLI_FIRMWARE_BIOS    = 0x00000001,
    WDS_CLI_FIRMWARE_EFI     = 0x00000002,
}

alias WDS_CLI_IMAGE_PARAM_TYPE = int;
enum : int
{
    WDS_CLI_IMAGE_PARAM_UNKNOWN             = 0x00000000,
    WDS_CLI_IMAGE_PARAM_SPARSE_FILE         = 0x00000001,
    WDS_CLI_IMAGE_PARAM_SUPPORTED_FIRMWARES = 0x00000002,
}

///This structure is used by the WdsTransportServerRegisterCallback function.
alias TRANSPORTPROVIDER_CALLBACK_ID = int;
enum : int
{
    ///Identifies the WdsTransportProviderCreateInstance callback.
    WDS_TRANSPORTPROVIDER_CREATE_INSTANCE      = 0x00000000,
    ///Identifies the WdsTransportProviderCompareContent callback.
    WDS_TRANSPORTPROVIDER_COMPARE_CONTENT      = 0x00000001,
    ///Identifies the WdsTransportProviderOpenContent callback.
    WDS_TRANSPORTPROVIDER_OPEN_CONTENT         = 0x00000002,
    ///Identifies the WdsTransportProviderUserAccessCheck callback.
    WDS_TRANSPORTPROVIDER_USER_ACCESS_CHECK    = 0x00000003,
    ///Identifies the WdsTransportProviderGetContentSize callback.
    WDS_TRANSPORTPROVIDER_GET_CONTENT_SIZE     = 0x00000004,
    ///Identifies the WdsTransportProviderReadContent callback.
    WDS_TRANSPORTPROVIDER_READ_CONTENT         = 0x00000005,
    ///Identifies the WdsTransportProviderCloseContent callback.
    WDS_TRANSPORTPROVIDER_CLOSE_CONTENT        = 0x00000006,
    ///Identifies the WdsTransportProviderCloseInstance callback.
    WDS_TRANSPORTPROVIDER_CLOSE_INSTANCE       = 0x00000007,
    ///Identifies the WdsTransportProviderShutdown callback.
    WDS_TRANSPORTPROVIDER_SHUTDOWN             = 0x00000008,
    ///Identifies the WdsTransportProviderDumpState callback.
    WDS_TRANSPORTPROVIDER_DUMP_STATE           = 0x00000009,
    ///Identifies the WdsTransportProviderRefreshSettings callback.
    WDS_TRANSPORTPROVIDER_REFRESH_SETTINGS     = 0x0000000a,
    ///Identifies the WdsTransportProviderGetContentMetadata callback.
    WDS_TRANSPORTPROVIDER_GET_CONTENT_METADATA = 0x0000000b,
    WDS_TRANSPORTPROVIDER_MAX_CALLBACKS        = 0x0000000c,
}

///This enumeration is received by the WdsTransportClientRegisterCallback function.
alias TRANSPORTCLIENT_CALLBACK_ID = int;
enum : int
{
    ///Identifies the PFN_WdsTransportClientSessionStart callback.
    WDS_TRANSPORTCLIENT_SESSION_START     = 0x00000000,
    ///Identifies the PFN_WdsTransportClientReceiveContents callback.
    WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS  = 0x00000001,
    ///Identifies the PFN_WdsTransportClientSessionComplete callback.
    WDS_TRANSPORTCLIENT_SESSION_COMPLETE  = 0x00000002,
    ///Identifies the PFN_WdsTransportClientReceiveMetadata callback.
    WDS_TRANSPORTCLIENT_RECEIVE_METADATA  = 0x00000003,
    ///Identifies the PFN_WdsTransportClientSessionStartEx callback.
    WDS_TRANSPORTCLIENT_SESSION_STARTEX   = 0x00000004,
    WDS_TRANSPORTCLIENT_SESSION_NEGOTIATE = 0x00000005,
    WDS_TRANSPORTCLIENT_MAX_CALLBACKS     = 0x00000006,
}

///Indicates which WDS features are installed on the WDS server.
alias WDSTRANSPORT_FEATURE_FLAGS = int;
enum : int
{
    ///The server has the WDS administrator pack installed. This feature is used for managing WDS local or remote WDS
    ///servers.
    WdsTptFeatureAdminPack        = 0x00000001,
    ///The server has the WDS Transport Server role installed. This feature provides a generic, extensible transport
    ///platform that can be used by any application. Generally, this role has to be installed on the server for most of
    ///the WdsTptMgmt functionality to be available. Without this role, only limited functionality about the server's
    ///install state would be available through WdsTptMgmt.
    WdsTptFeatureTransportServer  = 0x00000002,
    WdsTptFeatureDeploymentServer = 0x00000004,
}

///Specifies which protocols the WDS transport server supports.
alias WDSTRANSPORT_PROTOCOL_FLAGS = int;
enum : int
{
    ///Indicates that the server supports the Unicast transmission protocol.
    WdsTptProtocolUnicast   = 0x00000001,
    WdsTptProtocolMulticast = 0x00000002,
}

///Determines the type of multicast sessions used for transmitting objects covered by this namespace.
alias WDSTRANSPORT_NAMESPACE_TYPE = int;
enum : int
{
    ///Default value that indicates that the namespace type is not yet known. This could also be the case if a new
    ///namespace type was introduced in later server versions and this version of WdsTptMgmt has not been updated to
    ///fully recognize and classify it.
    WdsTptNamespaceTypeUnknown                  = 0x00000000,
    ///Indicates that multicast sessions are to be created automatically by the server based on incoming requests from
    ///clients. The server independently decides when to start or end these sessions to optimize performance and reduce
    ///network congestion.
    WdsTptNamespaceTypeAutoCast                 = 0x00000001,
    ///Indicates that multicast sessions for this namespace are to be scheduled such that they start only when the
    ///administrator manually launches them.
    WdsTptNamespaceTypeScheduledCastManualStart = 0x00000002,
    WdsTptNamespaceTypeScheduledCastAutoStart   = 0x00000003,
}

///Indicates what action a WDS client should take when it is disconnected from the session.
alias WDSTRANSPORT_DISCONNECT_TYPE = int;
enum : int
{
    ///Default value that indicates that the disconnection type is not known.
    WdsTptDisconnectUnknown  = 0x00000000,
    ///Indicates that the client should leave the session and fallback to an alternate mechanism for retrieving data.
    ///For example, a client disconnected from a multicast session can try using unicast instead.
    WdsTptDisconnectFallback = 0x00000001,
    WdsTptDisconnectAbort    = 0x00000002,
}

///Specifies what action needs to be taken when notifying WDS transport services, such as rereading their settings
///following a configuration change.
alias WDSTRANSPORT_SERVICE_NOTIFICATION = int;
enum : int
{
    ///Default value that indicates that the notification type is not known.
    WdsTptServiceNotifyUnknown      = 0x00000000,
    WdsTptServiceNotifyReadSettings = 0x00000001,
}

///Indicates the type of IP address.
alias WDSTRANSPORT_IP_ADDRESS_TYPE = int;
enum : int
{
    ///Default value that indicates that the IP address type has not yet been determined.
    WdsTptIpAddressUnknown = 0x00000000,
    ///Indicates an IPv4 address.
    WdsTptIpAddressIpv4    = 0x00000001,
    WdsTptIpAddressIpv6    = 0x00000002,
}

///Indicates the source from which the WDS multicast provider obtains a multicast address for a new session.
alias WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE = int;
enum : int
{
    ///Default value that indicates that the IP address source is not known.
    WdsTptIpAddressSourceUnknown = 0x00000000,
    ///Indicates that the server should use the Multicast Address Dynamic Client Allocation Protocol (MADCAP) to obtain
    ///a multicast IP address. MADCAP is a protocol that enables applications to obtain, renew, and release multicast
    ///addresses, and its functionality is often included in DHCP servers, such as the Microsoft DHCP Server role.
    WdsTptIpAddressSourceDhcp    = 0x00000001,
    WdsTptIpAddressSourceRange   = 0x00000002,
}

///Defines settings that are used by WDS transport protocols to optimize data transfer on the network. The network
///profile setting values are optimized for different network speeds and in most cases should not be changed. A custom
///network profile is included to enable administrators to try different values and find what suits their network best.
alias WDSTRANSPORT_NETWORK_PROFILE_TYPE = int;
enum : int
{
    ///Default value that indicates that the network profile is not known.
    WdsTptNetworkProfileUnknown = 0x00000000,
    ///Indicates that the server should use the custom network profile. This is a profile whose settings can be directly
    ///modified by administrators if they need to further customize their settings rather than use one of the fixed,
    ///inbox profiles. Note that settings for this profile start with values identical to those of the 100-Mbps profile.
    WdsTptNetworkProfileCustom  = 0x00000001,
    ///Indicates that the server should use the 10-Mbps network profile, which is optimized for slow 10-Mbps networks.
    WdsTptNetworkProfile10Mbps  = 0x00000002,
    ///Indicates that the server should use the 100-Mbps network profile, which is optimized for mainstream 100-Mbps
    ///networks. This is the default profile selected for use on a freshly installed WDS server.
    WdsTptNetworkProfile100Mbps = 0x00000003,
    WdsTptNetworkProfile1Gbps   = 0x00000004,
}

///Configures which WDS components have diagnostics enabled. WDS diagnostics log events to the system event log.
alias WDSTRANSPORT_DIAGNOSTICS_COMPONENT_FLAGS = int;
enum : int
{
    ///Diagnostics are enabled for the PXE component of WDS, which answers requests from clients performing a PXE
    ///network boot. This component is typically used by the WDS Deployment Server role but is also available for
    ///various third-party applications that use the WDS Transport Server role.
    WdsTptDiagnosticsComponentPxe         = 0x00000001,
    ///Diagnostics are enabled for the TFTP component of WDS, which handles simple file transfers from clients that are
    ///typically in a pre-boot environment. This component is typically used by the WDS Deployment Server role but is
    ///also available for various third-party applications that use the WDS Transport Server role.
    WdsTptDiagnosticsComponentTftp        = 0x00000002,
    ///Diagnostics are enabled for the Image Server component of WDS, which handles client requests for enumerating
    ///operating system images on the server. This component is typically used by the WDS Deployment Server role.
    WdsTptDiagnosticsComponentImageServer = 0x00000004,
    WdsTptDiagnosticsComponentMulticast   = 0x00000008,
}

///Specifies the type of automatic actions a WDS transport server, running on Windows Server 2008 R2, should use to
///handle a client computer that is slowing the multicast transmission.
alias WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE = int;
enum : int
{
    ///Default value that indicates the automatic action used to handle slow client computers is not known.
    WdsTptSlowClientHandlingUnknown        = 0x00000000,
    ///Indicates that the server takes no action on any clients that are slowing the multicast transmission.
    WdsTptSlowClientHandlingNone           = 0x00000001,
    ///Indicates that the server detects clients that are slowing the multicast transmission below a configured
    ///threshold. Depending on a configurable setting, the server disconnects the slow clients from the multicast
    ///transmission or instructs the slow clients to fallback to an alternate mechanism for retrieving data. For
    ///example, a client disconnected from a multicast session can try using unicast instead.
    WdsTptSlowClientHandlingAutoDisconnect = 0x00000002,
    WdsTptSlowClientHandlingMultistream    = 0x00000003,
}

///Specifies which policy WDS transport services should use when allocating UDP ports.
alias WDSTRANSPORT_UDP_PORT_POLICY = int;
enum : int
{
    ///Use Windows Sockets (Winsock) to get a dynamic UDP port.
    WdsTptUdpPortPolicyDynamic = 0x00000000,
    ///Assign a fixed UDP port from a specified range of UDP ports.
    WdsTptUdpPortPolicyFixed   = 0x00000001,
}

///Indicates which features are supported by the WDS TFTP server.
alias WDSTRANSPORT_TFTP_CAPABILITY = int;
enum : int
{
    ///Indicates that the maximum block size used by the server can be configured.
    WdsTptTftpCapMaximumBlockSize = 0x00000001,
    WdsTptTftpCapVariableWindow   = 0x00000002,
}

// Constants


enum : int
{
    WdsCliFlagEnumFilterVersion  = 0x00000001,
    WdsCliFlagEnumFilterFirmware = 0x00000002,
}

enum : int
{
    WDS_LOG_TYPE_CLIENT_STARTED                          = 0x00000002,
    WDS_LOG_TYPE_CLIENT_FINISHED                         = 0x00000003,
    WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED                   = 0x00000004,
    WDS_LOG_TYPE_CLIENT_APPLY_STARTED                    = 0x00000005,
    WDS_LOG_TYPE_CLIENT_APPLY_FINISHED                   = 0x00000006,
    WDS_LOG_TYPE_CLIENT_GENERIC_MESSAGE                  = 0x00000007,
    WDS_LOG_TYPE_CLIENT_UNATTEND_MODE                    = 0x00000008,
    WDS_LOG_TYPE_CLIENT_TRANSFER_START                   = 0x00000009,
    WDS_LOG_TYPE_CLIENT_TRANSFER_END                     = 0x0000000a,
    WDS_LOG_TYPE_CLIENT_TRANSFER_DOWNGRADE               = 0x0000000b,
    WDS_LOG_TYPE_CLIENT_DOMAINJOINERROR                  = 0x0000000c,
    WDS_LOG_TYPE_CLIENT_POST_ACTIONS_START               = 0x0000000d,
    WDS_LOG_TYPE_CLIENT_POST_ACTIONS_END                 = 0x0000000e,
    WDS_LOG_TYPE_CLIENT_APPLY_STARTED_2                  = 0x0000000f,
    WDS_LOG_TYPE_CLIENT_APPLY_FINISHED_2                 = 0x00000010,
    WDS_LOG_TYPE_CLIENT_DOMAINJOINERROR_2                = 0x00000011,
    WDS_LOG_TYPE_CLIENT_DRIVER_PACKAGE_NOT_ACCESSIBLE    = 0x00000012,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_START   = 0x00000013,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_END     = 0x00000014,
    WDS_LOG_TYPE_CLIENT_OFFLINE_DRIVER_INJECTION_FAILURE = 0x00000015,
}

enum : int
{
    WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED3 = 0x00000017,
    WDS_LOG_TYPE_CLIENT_MAX_CODE        = 0x00000018,
}

enum : int
{
    WDS_LOG_LEVEL_ERROR   = 0x00000001,
    WDS_LOG_LEVEL_WARNING = 0x00000002,
    WDS_LOG_LEVEL_INFO    = 0x00000003,
}

enum : int
{
    WDS_CLI_MSG_COMPLETE = 0x00000001,
    WDS_CLI_MSG_PROGRESS = 0x00000002,
    WDS_CLI_MSG_TEXT     = 0x00000003,
}

// Callbacks

///Defines a callback function that can receive debugging messages from the WDS client.
///Params:
///    pwszFormat = A pointer to a null-terminated string value that contains a formatted string.
alias PFN_WdsCliTraceFunction = void function(const(wchar)* pwszFormat, byte* Params);
///Defines a callback function that WDS can call for progress notification and error messages during a file or image
///transfer.
///Params:
///    dwMessageId = The type of message and the meaning of the <i>lParam</i> parameter. This parameter can have only one of the
///                  following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                  id="WDS_CLI_MSG_START"></a><a id="wds_cli_msg_start"></a><dl> <dt><b>WDS_CLI_MSG_START</b></dt> <dt>0</dt> </dl>
///                  </td> <td width="60%"> The transfer start message. The <i>lParam</i> parameter is a pointer to a
///                  <b>LARGE_INTEGER</b> value containing the file size of the transfer. </td> </tr> <tr> <td width="40%"><a
///                  id="WDS_CLI_MSG_COMPLETE"></a><a id="wds_cli_msg_complete"></a><dl> <dt><b>WDS_CLI_MSG_COMPLETE</b></dt>
///                  <dt>1</dt> </dl> </td> <td width="60%"> The transfer complete message. The <i>lParam</i> parameter is an
///                  <b>HRESULT</b> value. </td> </tr> <tr> <td width="40%"><a id="WDS_CLI_MSG_PROGRESS"></a><a
///                  id="wds_cli_msg_progress"></a><dl> <dt><b>WDS_CLI_MSG_PROGRESS</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
///                  The transfer progress message. The <i>lParam</i> parameter is a <b>ULONG</b> value that is the percentage of
///                  transfer completed. </td> </tr> <tr> <td width="40%"><a id="WDS_CLI_MSG_TEXT"></a><a
///                  id="wds_cli_msg_text"></a><dl> <dt><b>WDS_CLI_MSG_TEXT</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The
///                  informational message. The <i>lParam</i> parameter is pointer to a debugging string that can be used for
///                  diagnostic purposes. </td> </tr> </table>
///    wParam = This message parameter should always be set to the value of the transfer handle returned by the
///             WdsCliTransferImage or WdsCliTransferFile function.
///    lParam = The meaning of the value contained by this parameter depends upon the <i>dwMessageId</i> parameter.
///    pvUserData = A pointer to optional user information attached to this session by the WdsCliTransferImage or WdsCliTransferFile
///                 function.
alias PFN_WdsCliCallback = void function(uint dwMessageId, WPARAM wParam, LPARAM lParam, void* pvUserData);
///The PFN_WdsTransportClientSessionStart callback is called at the start of a multicast session to indicate file size
///and other server side information about the file to the consumer.
///Params:
///    hSessionKey = The handle belonging to the session that is being started.
///    pCallerData = Pointer to the caller specific data for this session. This data was specified in the call to
///                  WdsTransportClientStartSession.
///    ullFileSize = 
alias PFN_WdsTransportClientSessionStart = void function(HANDLE hSessionKey, void* pCallerData, 
                                                         ULARGE_INTEGER* ullFileSize);
///The PFN_WdsTransportClientSessionStart callback is called at the start of a multicast session to indicate file size
///and other server side information about the file to the consumer.
///Params:
///    hSessionKey = The handle belonging to the session that is being started.
///    pCallerData = Pointer to the caller specific data for this session. This data was specified in the call to
///                  WdsTransportClientStartSession.
alias PFN_WdsTransportClientSessionStartEx = void function(HANDLE hSessionKey, void* pCallerData, 
                                                           TRANSPORTCLIENT_SESSION_INFO* Info);
///PFN_WdsTransportClientReceiveMetadata is an optional callback that a consumer may register to receive metadata type
///information about a file. This information is provided by the content provider and is opaque to the multicast client
///and server.
///Params:
///    hSessionKey = The handle belonging to the session that is being started.
///    pCallerData = Pointer to the caller specific data for this session. This data was specified in the call to
///                  WdsTransportClientStartSession function.
///    pMetadata = Data provided by the content provider that is associated with this object in some manner.
alias PFN_WdsTransportClientReceiveMetadata = void function(HANDLE hSessionKey, void* pCallerData, char* pMetadata, 
                                                            uint ulSize);
///The PFN_WdsTransportClientReceiveContents callback is used by the multicast client to indicate that a block of data
///is ready to be used.
///Params:
///    hSessionKey = The handle belonging to the session that is being started.
///    pCallerData = Pointer to the user data for this session. This data was specified in the call to the
///                  WdsTransportClientStartSession function.
///    pContents = 
///    ulSize = The size of the data in <i>pCallerData</i>.
///    pullContentOffset = 
alias PFN_WdsTransportClientReceiveContents = void function(HANDLE hSessionKey, void* pCallerData, char* pContents, 
                                                            uint ulSize, ULARGE_INTEGER* pullContentOffset);
///The PFN_WdsTransportClientSessionCompete callback is used by the client to indicate that no more callbacks will be
///sent to the consumer and that the session either completed successfully or encountered a non-recoverable error.
///Params:
///    hSessionKey = The handle belonging to the session that is being started.
///    pCallerData = Pointer to the caller specific data for this session. This data was specified in the call to
///                  WdsTransportClientStartSession function.
///    dwError = The overall status of the file transfer. If the session succeeded, this value will be set to
///              <b>ERROR_SUCCESS</b>. If the session did not succeed, the error code for the session will be set.
alias PFN_WdsTransportClientSessionComplete = void function(HANDLE hSessionKey, void* pCallerData, uint dwError);
alias PFN_WdsTransportClientSessionNegotiate = void function(HANDLE hSessionKey, void* pCallerData, 
                                                             TRANSPORTCLIENT_SESSION_INFO* pInfo, 
                                                             HANDLE hNegotiateKey);

// Structs


///Contains credentials used to authorize a client session.
struct WDS_CLI_CRED
{
    ///The user name associated with the credentials.
    const(wchar)* pwszUserName;
    ///The domain for the user name associated with the credentials.
    const(wchar)* pwszDomain;
    ///The password for the user name associated with the credentials.
    const(wchar)* pwszPassword;
}

///The <b>PXE_DHCP_OPTION</b> structure can be used with the Windows Deployment Services PXE Server API.
struct PXE_DHCP_OPTION
{
    ///A DHCP option type.
    ubyte    OptionType;
    ///Length of the option value.
    ubyte    OptionLength;
    ubyte[1] OptionValue;
}

///The <b>PXE_DHCP_MESSAGE</b> structure can be used with the Windows Deployment Services PXE Server API.
struct PXE_DHCP_MESSAGE
{
align (1):
    ///Operation (op) field
    ubyte           Operation;
    ///Hardware Address Type (htype) field
    ubyte           HardwareAddressType;
    ///Hardware Address Length (hlen) field
    ubyte           HardwareAddressLength;
    ubyte           HopCount;
    uint            TransactionID;
    ///Seconds Since Boot (secs) field
    ushort          SecondsSinceBoot;
    ///This parameter is reserved.
    ushort          Reserved;
    ///Client IP Address (ciaddr) field
    uint            ClientIpAddress;
    uint            YourIpAddress;
    uint            BootstrapServerAddress;
    uint            RelayAgentIpAddress;
    ubyte[16]       HardwareAddress;
    ubyte[64]       HostName;
    ubyte[128]      BootFileName;
    union
    {
    align (1):
        ubyte[4] bMagicCookie;
        uint     uMagicCookie;
    }
    PXE_DHCP_OPTION Option;
}

///The <b>PXE_DHCPV6_OPTION</b> structure can be used with the Windows Deployment Services PXE Server API. For more
///information about the DHCPv6 option code, developers should refer to the Dynamic Host Configuration Protocol for IPv6
///(RFC 3315) maintained by The Internet Engineering Task Force (IETF).
struct PXE_DHCPV6_OPTION
{
align (1):
    ///A DHCPv6 option type.
    ushort   OptionCode;
    ///Length of the option value.
    ushort   DataLength;
    ubyte[1] Data;
}

///Describes the fields in common between the PXE_DHCPV6_MESSAGE and PXE_DHCPV6_RELAY_MESSAGE structures. For more
///information about the DHCPv6 messages, developers should refer to the Dynamic Host Configuration Protocol for IPv6
///(RFC 3315) maintained by The Internet Engineering Task Force (IETF).
struct PXE_DHCPV6_MESSAGE_HEADER
{
    ///The DHCPv6 Message Type.
    ubyte    MessageType;
    ubyte[1] Message;
}

///A DHCPV6 message. For more information about the DHCPv6 messages, developers should refer to the Dynamic Host
///Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task Force (IETF).
struct PXE_DHCPV6_MESSAGE
{
    ///The DHCPv6 message type.
    ubyte                MessageType;
    ///Byte 1 of the transaction-id in the DHCPv6 message.
    ubyte                TransactionIDByte1;
    ///Byte 2 of the transaction-id the DHCPv6 message.
    ubyte                TransactionIDByte2;
    ///Byte 3 of the transaction-id DHCPv6 message.
    ubyte                TransactionIDByte3;
    PXE_DHCPV6_OPTION[1] Options;
}

///Provides the DHCPV6 relay message. MessageType, HopCount, LinkAddress, and Options fields that are described by RFC
///3315 section 7. For more information about DHCPV6 message type, hop count, link address, and options, developers
///should refer to the Dynamic Host Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering
///Task Force (IETF).
struct PXE_DHCPV6_RELAY_MESSAGE
{
    ///The message type
    ubyte                MessageType;
    ///The hop count
    ubyte                HopCount;
    ///The link address
    ubyte[16]            LinkAddress;
    ///The peer address
    ubyte[16]            PeerAddress;
    PXE_DHCPV6_OPTION[1] Options;
}

///Describes a provider.
struct PXE_PROVIDER
{
    ///Size of the <b>PXE_PROVIDER</b> structure.
    uint          uSizeOfStruct;
    ///Address of a null-terminated string that specifies the display name of the provider. This name is displayed to
    ///the user and must be unique among registered providers.
    const(wchar)* pwszName;
    ///Address of a null-terminated string that specifies the full path to the provider DLL.
    const(wchar)* pwszFilePath;
    ///Indicates whether the provider is critical. If a critical provider fails, the WDS server will also fail.
    BOOL          bIsCritical;
    ///Index of a provider in the list of registered providers.
    uint          uIndex;
}

///Specifies the network address for a packet.
struct PXE_ADDRESS
{
    ///Indicates how the structure should be interpreted and which of the members of the structure are valid. <table>
    ///<tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PXE_ADDR_BROADCAST"></a><a
    ///id="pxe_addr_broadcast"></a><dl> <dt><b>PXE_ADDR_BROADCAST</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%">
    ///For transmitted packets, this flag specifies that this packet should be broadcast on the network. If the
    ///<b>PXE_ADDR_USE_PORT</b> flag is set, then the <b>uPort</b> member specifies the port number to use; otherwise
    ///the source port number of the received packet is used as the destination port number. This flag cannot be
    ///combined with <b>PXE_ADDR_USE_ADDR</b>. For received packets, this flag indicates that the packet was set to the
    ///server using a broadcast address. The <b>uPort</b> member indicates the port on which the packet was received, in
    ///host byte order. The <b>bAddress</b> and <b>uAddrLen</b> members are filled with the broadcast address used.
    ///</td> </tr> <tr> <td width="40%"><a id="PXE_ADDR_USE_PORT"></a><a id="pxe_addr_use_port"></a><dl>
    ///<dt><b>PXE_ADDR_USE_PORT</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> For transmitted packets, this flag
    ///specifies that the <b>uPort</b> member is valid and should be used as the destination port when the packet is
    ///sent. The <b>uPort</b> member must be in host byte order. For received packets, this flag indicates that the
    ///packet was not received as a broadcast. </td> </tr> <tr> <td width="40%"><a id="PXE_ADDR_USE_ADDR"></a><a
    ///id="pxe_addr_use_addr"></a><dl> <dt><b>PXE_ADDR_USE_ADDR</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%">
    ///For transmitted packets, this flag specifies that the <b>bAddress</b> and <b>uAddrLen</b> members are valid and
    ///should be used as the destination address of the packet. For received packets, this flag is always set. </td>
    ///</tr> <tr> <td width="40%"><a id="PXE_ADDR_USE_DHCP_RULES"></a><a id="pxe_addr_use_dhcp_rules"></a><dl>
    ///<dt><b>PXE_ADDR_USE_DHCP_RULES</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> For transmitted packets,
    ///this flag specifies that the received packet is a valid DHCP packet, and that the DHCP rules for relay agent
    ///should be used to determine the destination address and port. If this flag is specified then <b>bAddress</b>,
    ///<b>uIpAddress</b>, <b>uAddrLen</b>, and <b>uPort</b> are ignored. For received packets, this flag is not used.
    ///</td> </tr> </table>
    uint   uFlags;
    union
    {
        ubyte[16] bAddress;
        uint      uIpAddress;
    }
    ///Length of the address (<b>bAddress</b> or <b>uIpAddress</b>). For more information, see the description for the
    ///<b>uFlags</b> member.
    uint   uAddrLen;
    ///Port number for the packet. For more information, see the description for the <b>uFlags</b> member.
    ushort uPort;
}

///Describes packets nested in OPTION_RELAY_MSG message. For more information about OPTION_RELAY_MSG and RELAY-FORW
///messages, developers should refer to the Dynamic Host Configuration Protocol for IPv6 (RFC 3315) maintained by The
///Internet Engineering Task Force (IETF).
struct PXE_DHCPV6_NESTED_RELAY_MESSAGE
{
    ///A pointer to the nested RELAY-FORW message.
    PXE_DHCPV6_RELAY_MESSAGE* pRelayMessage;
    ///A pointer to the size of the nested RELAY-FORW message.
    uint   cbRelayMessage;
    ///If the nested RELAY-FORW message contains <b>OPTION_INTERFACE_ID</b>, this is a pointer to the option payload.
    ///Otherwise, this field will be <b>NULL</b>.
    void*  pInterfaceIdOption;
    ushort cbInterfaceIdOption;
}

///This structure is used by the WdsTransportProviderInitialize callback function.
struct WDS_TRANSPORTPROVIDER_INIT_PARAMS
{
    ///The length of this structure.
    uint   ulLength;
    ///The multicast server's version.
    uint   ulMcServerVersion;
    ///An open handle to the registry key where this provider should store and retrieve its settings.
    HKEY   hRegistryKey;
    HANDLE hProvider;
}

///This structure is used by the <i>WdsTransportProviderInitialize</i> callback function.
struct WDS_TRANSPORTPROVIDER_SETTINGS
{
    ///The length of this structure. The version of the api that this provider implements.
    uint ulLength;
    uint ulProviderVersion;
}

///This structure is used by the PFN_WdsTransportClientSessionStartEx callback function.
struct TRANSPORTCLIENT_SESSION_INFO
{
    ///The length of this structure in bytes.
    uint           ulStructureLength;
    ///The size of the file, in bytes.
    ULARGE_INTEGER ullFileSize;
    uint           ulBlockSize;
}

///This structure is used by the WdsTransportClientStartSession function.
struct WDS_TRANSPORTCLIENT_REQUEST
{
    ///The length of this structure in bytes.
    uint          ulLength;
    ///The version of the API that the caller is built against. The multicast client may reject the request based on
    ///this value. This member must contain the following value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td width="40%"><a id="WDS_TRANSPORT_CLIENT_CURRENT_API_VERSION"></a><a
    ///id="wds_transport_client_current_api_version"></a><dl> <dt><b>WDS_TRANSPORT_CLIENT_CURRENT_API_VERSION</b></dt>
    ///<dt>1</dt> </dl> </td> <td width="60%"> The current version. </td> </tr> </table>
    uint          ulApiVersion;
    ///This member can contain one of the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///width="40%"><a id="WDS_TRANSPORTCLIENT_AUTH"></a><a id="wds_transportclient_auth"></a><dl>
    ///<dt><b>WDS_TRANSPORTCLIENT_AUTH</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> Authentication information
    ///about this user will be sent to the server. The server will use this information to determine if the user has
    ///access to this file. </td> </tr> <tr> <td width="40%"><a id="WDS_TRANSPORTCLIENT_NO_AUTH"></a><a
    ///id="wds_transportclient_no_auth"></a><dl> <dt><b>WDS_TRANSPORTCLIENT_NO_AUTH</b></dt> <dt>0x2</dt> </dl> </td>
    ///<td width="60%"> No authentication information will be sent to the server. If the server is not configured to
    ///accept these requests, the request will fail. </td> </tr> </table>
    uint          ulAuthLevel;
    ///Server name.
    const(wchar)* pwszServer;
    ///Namespace of the object to retrieve.
    const(wchar)* pwszNamespace;
    ///Specifies the name of the object to retrieve. Object names are provider dependent.
    const(wchar)* pwszObjectName;
    ///Specifies how much data in bytes the consumer can store in its queue. Once this threshold is reached, the client
    ///will not send any more writes to the consumer until some memory is released with WdsTransportClientCompleteWrite.
    uint          ulCacheSize;
    ///Specifies the protocol to be used for this transfer. This member can contain the following value. <table> <tr>
    ///<th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WDS_TRANSPORTCLIENT_PROTOCOL_MULTICAST"></a><a
    ///id="wds_transportclient_protocol_multicast"></a><dl> <dt><b>WDS_TRANSPORTCLIENT_PROTOCOL_MULTICAST</b></dt>
    ///<dt>0x00000001</dt> </dl> </td> <td width="60%"> The file will be transferred using an efficient multicast
    ///protocol. </td> </tr> </table>
    uint          ulProtocol;
    ///Protocol data structure for the protocol. The structure is <b>NULL</b> for
    ///<b>WDS_TRANSPORTCLIENT_PROTOCOL_MULTICAST</b> protocol.
    void*         pvProtocolData;
    uint          ulProtocolDataLength;
}

struct WDS_TRANSPORTCLIENT_CALLBACKS
{
    PFN_WdsTransportClientSessionStart SessionStart;
    PFN_WdsTransportClientSessionStartEx SessionStartEx;
    PFN_WdsTransportClientReceiveContents ReceiveContents;
    PFN_WdsTransportClientReceiveMetadata ReceiveMetadata;
    PFN_WdsTransportClientSessionComplete SessionComplete;
    PFN_WdsTransportClientSessionNegotiate SessionNegotiate;
}

// Functions

///Closes a handle to a WDS session or image, and releases resources.
///Params:
///    Handle = A handle to a WDS session or image. This function can close handles opened with the WdsCliCreateSession or
///             WdsCliFindFirstImage functions.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliClose(HANDLE Handle);

///Registers a callback function that will receive debugging messages.
///Params:
///    pfn = A pointer to a PFN_WdsCliTraceFunction callback function that receives debugging messages.
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliRegisterTrace(PFN_WdsCliTraceFunction pfn);

///This function can be used to free the array of string values that gets allocated by the WdsCliObtainDriverPackages
///function.
///Params:
///    ppwszArray = Pointer to the array of string values being freed.
///    ulCount = Number of strings in the array that is pointed to by <i>ppwszArray</i>.
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFreeStringArray(char* ppwszArray, uint ulCount);

///Starts the enumeration of images stored on a WDS server and returns a find handle that references the first image.
///Params:
///    hSession = A handle to a session with a WDS server. This was a handle returned by the WdsCliCreateSession function.
///    phFindHandle = Pointer to a <b>HANDLE</b> value that receives the find handle. If the function succeeds, the find handle will
///                   reference the first image stored on the WDS server. If the function is unsuccessful, this parameter is unchanged.
///                   Use the WdsCliFindNextImage function to advance the reference of the find handle to the next image. <div
///                   class="alert"><b>Note</b> Information about the image can only be obtained from the find handle by using the
///                   image information functions of the WDS client API.</div> <div> </div>
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFindFirstImage(HANDLE hSession, ptrdiff_t* phFindHandle);

///Advances the reference of a find handle to the next image stored on a WDS server.
///Params:
///    Handle = The find handle returned by the WdsCliFindFirstImage function. If the <b>WdsCliFindNextImage</b> function is
///             successful, the reference of the find handle is advanced to the next image stored on the WDS server.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>. If the function succeeds, and the end of the enumeration has
///    been reached, the return is <b>HRESULT_FROM_WIN32(ERROR_NO_MORE_FILES)</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFindNextImage(HANDLE Handle);

///Returns the image enumeration flag for the current image handle.
///Params:
///    Handle = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///             advanced using the WdsCliFindNextImage function.
///    pdwFlags = A pointer to a value that receives the enumeration flag value. This parameter can have the following values
///               <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="WdsCliFlagEnumFilterVersion"></a><a id="wdscliflagenumfilterversion"></a><a
///               id="WDSCLIFLAGENUMFILTERVERSION"></a><dl> <dt><b>WdsCliFlagEnumFilterVersion</b></dt> <dt>1</dt> </dl> </td> <td
///               width="60%"> The WDS client only shows images that have the same version as the boot image. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetEnumerationFlags(HANDLE Handle, uint* pdwFlags);

///Returns an image handle for the current image in an image enumeration.
///Params:
///    FindHandle = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///                 advanced using the WdsCliFindNextImage function.
///    phImageHandle = A pointer to a location that contains an image handle for the current image referenced by the find handle.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHandleFromFindHandle(HANDLE FindHandle, ptrdiff_t* phImageHandle);

///Returns an image handle from a completed transfer handle. The handle is to the local copy of the image that's been
///transferred from the server to the client.
///Params:
///    hTransfer = A WDS transfer handle that has completed the transfer. This can be the handle returned by the WdsCliTransferImage
///                or WdsCliTransferFile functions.
///    phImageHandle = A pointer to a location that contains an image handle.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHandleFromTransferHandle(HANDLE hTransfer, ptrdiff_t* phImageHandle);

///Starts a new session with a WDS server.
///Params:
///    pwszServer = A pointer to a string value that contains the name or IP address of the WDS server.
///    pCred = A pointer to a WDS_CLI_CRED structure that contains the client's credentials. This parameter can be null for a
///            session without authentication.
///    phSession = A pointer to a handle for the new session. This parameter is unmodified if the function is unsuccessful.
///Returns:
///    If the function succeeds, the return value is <b>TRUE</b>. If the function fails, the return value is
///    <b>FALSE</b>. To get extended error information, call GetLastError.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliCreateSession(const(wchar)* pwszServer, WDS_CLI_CRED* pCred, ptrdiff_t* phSession);

///Converts a session with a WDS server into an authenticated session.
///Params:
///    hSession = A handle to a session with a WDS server. This was a handle returned by the WdsCliCreateSession function.
///    pCred = Pointer to a WDS_CLI_CRED structure that contains the client's credentials.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliAuthorizeSession(HANDLE hSession, WDS_CLI_CRED* pCred);

///Initializes logging for the WDS client.
///Params:
///    hSession = A handle to a session with a WDS server. This was a handle returned by the WdsCliCreateSession function.
///    ulClientArchitecture = A constant that identifies the processor architecture of the client. This parameter can have one of the following
///                           values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                           id="PROCESSOR_ARCHITECTURE_AMD64"></a><a id="processor_architecture_amd64"></a><dl>
///                           <dt><b>PROCESSOR_ARCHITECTURE_AMD64</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> The image is an x64 image
///                           (AMD AMD64 or Intel EM64T). </td> </tr> <tr> <td width="40%"><a id="PROCESSOR_ARCHITECTURE_IA64"></a><a
///                           id="processor_architecture_ia64"></a><dl> <dt><b>PROCESSOR_ARCHITECTURE_IA64</b></dt> <dt>6</dt> </dl> </td> <td
///                           width="60%"> The image is an Itanium-based system image. </td> </tr> <tr> <td width="40%"><a
///                           id="PROCESSOR_ARCHITECTURE_INTEL"></a><a id="processor_architecture_intel"></a><dl>
///                           <dt><b>PROCESSOR_ARCHITECTURE_INTEL</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The image is a 32-bit Intel
///                           x86 image. </td> </tr> </table>
///    pwszClientId = A pointer to a string value that contains a GUID that represents this WDS client. This is typically the GUID for
///                   the System Management BIOS (SMBIOS.)
///    pwszClientAddress = A pointer to a string value that contains the network address of the WDS client. This is typically the IP address
///                        in string form, for example, "127.0.0.1".
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>. If logging has already been initialize for the session, the
///    return value is <b>HRESULT_FROM_WIN32(ERROR_ALREADY_INITIALIZED)</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliInitializeLog(HANDLE hSession, uint ulClientArchitecture, const(wchar)* pwszClientId, 
                            const(wchar)* pwszClientAddress);

///Sends a log event to the WDS server.
///Params:
///    hSession = A handle to a session with a WDS server. This was a handle returned by the WdsCliCreateSession function.
///    ulLogLevel = Indicates the threshold severity required to log an event. The WDS server will log events only if the server log
///                 level is greater than or equal to the value specified. This parameter can have one of the following values.
///    ulMessageCode = The type of message that is being logged. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                    width="40%"><a id="WDS_LOG_TYPE_CLIENT_ERROR"></a><a id="wds_log_type_client_error"></a><dl>
///                    <dt><b>WDS_LOG_TYPE_CLIENT_ERROR</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> A client error message. An
///                    additional parameter of type <b>PWSTR</b> that describes the error is required. </td> </tr> <tr> <td
///                    width="40%"><a id="WDS_LOG_TYPE_CLIENT_STARTED"></a><a id="wds_log_type_client_started"></a><dl>
///                    <dt><b>WDS_LOG_TYPE_CLIENT_STARTED</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> A client started message. No
///                    additional parameters are required. </td> </tr> <tr> <td width="40%"><a id="WDS_LOG_TYPE_CLIENT_FINISHED"></a><a
///                    id="wds_log_type_client_finished"></a><dl> <dt><b>WDS_LOG_TYPE_CLIENT_FINISHED</b></dt> <dt>3</dt> </dl> </td>
///                    <td width="60%"> A client finished message. No additional parameters are required. </td> </tr> <tr> <td
///                    width="40%"><a id="WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED"></a><a id="wds_log_type_client_image_selected"></a><dl>
///                    <dt><b>WDS_LOG_TYPE_CLIENT_IMAGE_SELECTED</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> A client image
///                    selected message. Two additional parameters of type <b>PWSTR</b> are required. The first is the Image Name and
///                    the second is the Group Name. </td> </tr> <tr> <td width="40%"><a id="WDS_LOG_TYPE_CLIENT_APPLY_STARTED"></a><a
///                    id="wds_log_type_client_apply_started"></a><dl> <dt><b>WDS_LOG_TYPE_CLIENT_APPLY_STARTED</b></dt> <dt>5</dt>
///                    </dl> </td> <td width="60%"> No additional parameters are required. </td> </tr> <tr> <td width="40%"><a
///                    id="WDS_LOG_TYPE_CLIENT_APPLY_FINISHED"></a><a id="wds_log_type_client_apply_finished"></a><dl>
///                    <dt><b>WDS_LOG_TYPE_CLIENT_APPLY_FINISHED</b></dt> <dt>6</dt> </dl> </td> <td width="60%"> No additional
///                    parameters are required. </td> </tr> <tr> <td width="40%"><a id="WDS_LOG_TYPE_CLIENT_GENERIC_MESSAGE"></a><a
///                    id="wds_log_type_client_generic_message"></a><dl> <dt><b>WDS_LOG_TYPE_CLIENT_GENERIC_MESSAGE</b></dt> <dt>7</dt>
///                    </dl> </td> <td width="60%"> A generic message. An additional parameter of type <b>PWSTR</b> that contains the
///                    message is required. </td> </tr> <tr> <td width="40%"><a id="WDS_LOG_TYPE_CLIENT_MAX_CODE"></a><a
///                    id="wds_log_type_client_max_code"></a><dl> <dt><b>WDS_LOG_TYPE_CLIENT_MAX_CODE</b></dt> <dt>8</dt> </dl> </td>
///                    <td width="60%"> Used to determine an out-of-range index. Values greater than or equal to
///                    <b>WDS_LOG_TYPE_CLIENT_MAX_CODE</b> are not valid. </td> </tr> </table>
///    arg4 = The quantity and type of the additional arguments varies with the value of the <i>ulMessageCode</i> parameter.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliLog(HANDLE hSession, uint ulLogLevel, uint ulMessageCode);

///Returns the name of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains the name of the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageName(HANDLE hIfh, ushort** ppwszValue);

///Returns a description of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains a description of the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageDescription(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageType(HANDLE hIfh, WDS_CLI_IMAGE_TYPE* pImageType);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageFiles(HANDLE hIfh, ushort*** pppwszFiles, uint* pdwCount);

///Returns the default language of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains the default language for the current
///                 image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLanguage(HANDLE hIfh, ushort** ppwszValue);

///Returns an array of languages supported by the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    pppszValues = A pointer to a pointer to an array of null-terminated string values. Each element in the array contains a
///                  language of the current image.
///    pdwNumValues = Pointer to a value that contains the number of languages in the <i>pppszValues</i> parameter.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLanguages(HANDLE hIfh, byte*** pppszValues, uint* pdwNumValues);

///Returns the version of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains the version of the current version.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageVersion(HANDLE hIfh, ushort** ppwszValue);

///Returns the path to the file that contains the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string that contains the relative path of the image file for the
///                 current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImagePath(HANDLE hIfh, ushort** ppwszValue);

///Returns the index within the Windows Imaging Format(WIM) file for the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    pdwValue = A pointer to a value that contains the image index for the current image WIM file.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageIndex(HANDLE hIfh, uint* pdwValue);

///Returns the processor architecture for the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    pdwValue = Pointer to a value that describes the processor architecture of the current image. This parameter can have one of
///               the following values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="PROCESSOR_ARCHITECTURE_AMD64"></a><a id="processor_architecture_amd64"></a><dl>
///               <dt><b>PROCESSOR_ARCHITECTURE_AMD64</b></dt> <dt>9</dt> </dl> </td> <td width="60%"> The image is an x64 image
///               (AMD AMD64 or Intel EM64T). </td> </tr> <tr> <td width="40%"><a id="PROCESSOR_ARCHITECTURE_IA64"></a><a
///               id="processor_architecture_ia64"></a><dl> <dt><b>PROCESSOR_ARCHITECTURE_IA64</b></dt> <dt>6</dt> </dl> </td> <td
///               width="60%"> The image is an Itanium-based system image. </td> </tr> <tr> <td width="40%"><a
///               id="PROCESSOR_ARCHITECTURE_INTEL"></a><a id="processor_architecture_intel"></a><dl>
///               <dt><b>PROCESSOR_ARCHITECTURE_INTEL</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The image is a 32-bit Intel
///               x86 image. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageArchitecture(HANDLE hIfh, uint* pdwValue);

///Returns the last-modification time of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppSysTimeValue = A pointer to a pointer to a SYSTEMTIME structure that contains the last-modified time of the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLastModifiedTime(HANDLE hIfh, SYSTEMTIME** ppSysTimeValue);

///Returns the size of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    pullValue = A pointer to a value that contains the size of the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageSize(HANDLE hIfh, ulong* pullValue);

///Returns the Hardware Abstraction Layer (HAL) name for the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains the HAL name for the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHalName(HANDLE hIfh, ushort** ppwszValue);

///Returns the name of the image group for the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a null-terminated string value that contains the name of the image group for the current image.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageGroup(HANDLE hIfh, ushort** ppwszValue);

///Returns the namespace of the current image.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    ppwszValue = A pointer to a pointer to a null-terminated string value that contains the namespace of the current image. If
///                 there is no namespace associated with this image, this returns null or an empty string.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageNamespace(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageParameter(HANDLE hIfh, WDS_CLI_IMAGE_PARAM_TYPE ParamType, char* pResponse, 
                                uint uResponseLen);

///Returns the size of the current file transfer.
///Params:
///    hIfh = A find handle returned by the WdsCliFindFirstImage function. The image referenced by the find handle can be
///           advanced using the WdsCliFindNextImage function.
///    pullValue = A pointer to a value that contains the size of the current transfer.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetTransferSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI")
void WdsCliSetTransferBufferSize(uint ulSizeInBytes);

///Transfers an image from a WDS server to the WDS client.
///Params:
///    hImage = A WDS image handle that refers to a remote image.
///    pwszLocalPath = A pointer to a null-terminated string value that contains the full path to the local location to store the image
///                    file being transferred.
///    dwFlags = Options associated with the file transfer. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="WDS_CLI_TRANSFER_ASYNCHRONOUS"></a><a id="wds_cli_transfer_asynchronous"></a><dl>
///              <dt><b>WDS_CLI_TRANSFER_ASYNCHRONOUS</b></dt> </dl> </td> <td width="60%"> This flag specifies an asynchronous
///              transfer. </td> </tr> </table>
///    dwReserved = This parameter is reserved.
///    pfnWdsCliCallback = A pointer to an optional callback function that will receive callbacks for this transfer.
///    pvUserData = A pointer to optional user information that can be passed to the callback function.
///    phTransfer = A pointer to a transfer handle that can be used with the WdsCliWaitForTransfer or WdsCliCancelTransfer functions
///                 to wait for the transfer to complete or to cancel the transfer.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliTransferImage(HANDLE hImage, const(wchar)* pwszLocalPath, uint dwFlags, uint dwReserved, 
                            PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, ptrdiff_t* phTransfer);

///Transfers a file from a WDS server to the WDS client using a multicast transfer protocol.
///Params:
///    pwszServer = A pointer to a null-terminated string value that contains the WDS server name.
///    pwszNamespace = A pointer to a null-terminated string value that contains the multicast namespace name for the image.
///    pwszRemoteFilePath = A pointer to a null-terminated string value that contains the full path for the remote location from which to
///                         copy the file being transferred.
///    pwszLocalFilePath = A pointer to a null-terminated string value that contains the full path to the local location to store the file
///                        being transferred.
///    dwFlags = Options associated with the file transfer. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///              width="40%"><a id="WDS_CLI_TRANSFER_ASYNCHRONOUS"></a><a id="wds_cli_transfer_asynchronous"></a><dl>
///              <dt><b>WDS_CLI_TRANSFER_ASYNCHRONOUS</b></dt> </dl> </td> <td width="60%"> This flag specifies an asynchronous
///              transfer. </td> </tr> </table>
///    dwReserved = This parameter is reserved.
///    pfnWdsCliCallback = A pointer to an optional callback function for this transfer.
///    pvUserData = A pointer to optional user information that can be passed to the callback function.
///    phTransfer = A pointer to a transfer handle that can be used with the WdsCliWaitForTransfer or WdsCliCancelTransfer functions
///                 to wait for the transfer to complete or to cancel the transfer.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliTransferFile(const(wchar)* pwszServer, const(wchar)* pwszNamespace, const(wchar)* pwszRemoteFilePath, 
                           const(wchar)* pwszLocalFilePath, uint dwFlags, uint dwReserved, 
                           PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, ptrdiff_t* phTransfer);

///Cancels a WDS transfer operation.
///Params:
///    hTransfer = A handle for the WDS transfer operation being canceled. This can be the handle returned by the
///                WdsCliTransferImage or WdsCliTransferFile functions.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliCancelTransfer(HANDLE hTransfer);

///Waits for an image or file transfer to complete.
///Params:
///    hTransfer = A WDS transfer handle for the transfer being canceled. This can be the handle returned by the WdsCliTransferImage
///                or WdsCliTransferFile functions.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliWaitForTransfer(HANDLE hTransfer);

///This function obtains from a WDS image, the driver packages (INF files) that can be used on this computer. The
///WdsCliFreeStringArray function can be used to free the array of string values allocated by this function.
///Params:
///    hImage = A handle to a WDS image.
///    ppwszServerName = A pointer to a pointer to a string value that receives the IP address of the server hosting the driver packages.
///    pppwszDriverPackages = An array of string values that are the full paths for the driver packages (INF files.) The Internet Protocol (IP)
///                           address, rather than a computer name, is returned as part of the path. For example, a string value
///                           <b>\\172.31.224.245\REMINST\Stores\Drivers\driver.inf</b> in the array gives the full path to driver.inf. <div
///                           class="code"></div>
///    pulCount = The number of driver packages returned by <i>pppwszDriverPackages</i>.
///Returns:
///    If the function succeeds, the return is <b>S_OK</b>.
///    
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliObtainDriverPackages(HANDLE hImage, ushort** ppwszServerName, ushort*** pppwszDriverPackages, 
                                   uint* pulCount);

///This function obtains the driver packages (INF files) that are applicable to the specified WDS driver query XML. The
///WdsCliFreeStringArray function can be used to free the array of string values allocated by this function. The
///WdsCliGetDriverQueryXml function can be used to generate the required driver query XML string.
///Params:
///    hSession = A handle to a session with the WDS server. This handle is returned by the WdsCliCreateSession function.
///    pwszMachineInfo = A pointer to a string containing WDS driver query XML which can be generated by calling the
///                      WdsCliGetDriverQueryXml function.
///    ppwszServerName = A pointer to a pointer to a string value that receives the IP address of the server hosting the driver packages.
///    pppwszDriverPackages = An array of string values that are the full paths for the driver packages (INF files.) The Internet Protocol (IP)
///                           address, rather than a computer name, is returned as part of the path. For example, a string value
///                           <b>\\172.31.224.245\REMINST\Stores\Drivers\driver.inf</b> in the array gives the full path to driver.inf.
///    pulCount = The number of driver packages returned by pppwszDriverPackages.
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliObtainDriverPackagesEx(HANDLE hSession, const(wchar)* pwszMachineInfo, ushort** ppwszServerName, 
                                     ushort*** pppwszDriverPackages, uint* pulCount);

///This function generates an XML string which can be used to query a WDS server for driver packages using the
///WdsCliObtainDriverPackagesEx function. The target OS information section of the WDS driver query XML is generated if
///the path to the Windows directory of the applied image is specified.
///Params:
///    pwszWinDirPath = The path to the Windows directory of the applied image. This parameter is optional. If it is specified, the
///                     section of the WDS driver query XML for the target operating system is generated.
///    ppwszDriverQuery = A pointer to a pointer to a string that receives the generated WDS driver query XML. The caller has to free this
///                       buffer using "delete\[\]\(\*ppwszDriverQuery\)".
@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetDriverQueryXml(const(wchar)* pwszWinDirPath, ushort** ppwszDriverQuery);

///Registers a provider with the system. Providers use this function during installation to register with the system. On
///successful registration, a registry key handle is returned that should be used to store configuration information.
///Params:
///    pszProviderName = Address of a null terminated string that specifies the display name of the provider. This name is displayed to
///                      the user and must be unique among registered providers.
///    pszModulePath = Address of a null-terminated string that specifies the full path to the provider DLL.
///    Index = Index into the list of providers. Any existing providers are shifted down if necessary. The administrator can
///            rearrange the providers as needed, so no assumptions should be made about the order of providers. <table> <tr>
///            <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PXE_REG_INDEX_TOP"></a><a
///            id="pxe_reg_index_top"></a><dl> <dt><b>PXE_REG_INDEX_TOP</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Add the
///            provider to the top of the list to be the first to receive client requests. </td> </tr> <tr> <td width="40%"><a
///            id="PXE_REG_INDEX_BOTTOM"></a><a id="pxe_reg_index_bottom"></a><dl> <dt><b>PXE_REG_INDEX_BOTTOM</b></dt>
///            <dt>0xFFFFFFFF</dt> </dl> </td> <td width="60%"> Add the provider to the bottom of the list. </td> </tr> </table>
///    bIsCritical = Indicates whether the provider is critical. If a critical provider fails, the WDS server will also fail.
///    phProviderKey = Address of a <b>HKEY</b> where the configuration should be stored. The provider will receive a handle to this
///                    same key as the <i>hProviderKey</i> parameter to its PxeProviderInitialize callback.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderRegister(const(wchar)* pszProviderName, const(wchar)* pszModulePath, uint Index, BOOL bIsCritical, 
                         HKEY* phProviderKey);

///Removes a provider from the list of registered providers.
///Params:
///    pszProviderName = Display name for provider from the call to the PxeProviderRegister function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderUnRegister(const(wchar)* pszProviderName);

///Returns the index of the specified provider in the list of registered providers.
///Params:
///    pszProviderName = Friendly name for the provider from the call to the PxeProviderRegister function.
///    puIndex = Address of a <b>ULONG</b> that will receive the index of the provider.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderQueryIndex(const(wchar)* pszProviderName, uint* puIndex);

///Starts an enumeration of registered providers.
///Params:
///    phEnum = Address of a <b>HANDLE</b> that on successful return can be used with the PxeProviderEnumNext function to
///             enumerate providers. When the enumeration handle is no longer needed, use the PxeProviderEnumClose function to
///             close the enumeration.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderEnumFirst(HANDLE* phEnum);

///Enumerates registered providers.
///Params:
///    hEnum = <b>HANDLE</b> returned by the PxeProviderEnumFirst function.
///    ppProvider = Address of a PXE_PROVIDER structure with the <b>uSizeOfStruct</b> member filled in with the size of the
///                 structure. On return this structure is filled in with provider information. This structure can be freed with the
///                 PxeProviderFreeInfo function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderEnumNext(HANDLE hEnum, PXE_PROVIDER** ppProvider);

///Closes the enumeration of providers opened by the PxeProviderEnumFirst function.
///Params:
///    hEnum = <b>HANDLE</b> returned by the PxeProviderEnumFirst function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderEnumClose(HANDLE hEnum);

///Frees memory allocated by the PxeProviderEnumNext function.
///Params:
///    pProvider = Address of a PXE_PROVIDER structure returned from the PxeProviderEnumNext function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderFreeInfo(PXE_PROVIDER* pProvider);

///Registers callback functions for different notification events.
///Params:
///    hProvider = <b>HANDLE</b> passed to the PxeProviderInitialize function.
///    CallbackType = Specifies the callback that is being registered. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                   width="40%"><a id="PXE_CALLBACK_RECV_REQUEST"></a><a id="pxe_callback_recv_request"></a><dl>
///                   <dt><b>PXE_CALLBACK_RECV_REQUEST</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Register the
///                   PxeProviderRecvRequest callback. This callback must be registered while the provider is processing the
///                   PxeProviderInitialize function or the provider will be shut down. </td> </tr> <tr> <td width="40%"><a
///                   id="PXE_CALLBACK_SHUTDOWN"></a><a id="pxe_callback_shutdown"></a><dl> <dt><b>PXE_CALLBACK_SHUTDOWN</b></dt>
///                   <dt>1</dt> </dl> </td> <td width="60%"> Register the PxeProviderShutdown callback. This callback must be
///                   registered while the provider is processing the PxeProviderInitialize function or the provider will be shut down.
///                   </td> </tr> <tr> <td width="40%"><a id="PXE_CALLBACK_SERVICE_CONTROL"></a><a
///                   id="pxe_callback_service_control"></a><dl> <dt><b>PXE_CALLBACK_SERVICE_CONTROL</b></dt> <dt>2</dt> </dl> </td>
///                   <td width="60%"> Register the PxeProviderServiceControl callback. </td> </tr> <tr> <td width="40%"><a
///                   id="PXE_CALLBACK_MAX"></a><a id="pxe_callback_max"></a><dl> <dt><b>PXE_CALLBACK_MAX</b></dt> <dt>3</dt> </dl>
///                   </td> <td width="60%"> Used to determine an out-of-range index. Values greater than or equal to
///                   <b>PXE_CALLBACK_MAX</b> are not valid. </td> </tr> </table>
///    pCallbackFunction = Address of the callback function. The function signature varies depending on the <i>CallbackType</i> parameter.
///    pContext = Context value to be passed to the callback function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeRegisterCallback(HANDLE hProvider, uint CallbackType, void* pCallbackFunction, void* pContext);

///Sends a packet to a client request.
///Params:
///    hClientRequest = Handle to the client request received in the PxeProviderRecvRequest callback.
///    pPacket = Pointer to packet allocated by the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pPacket</i> parameter.
///    pAddress = Pointer to a PXE_ADDRESS structure that contains the destination address of the packet. If the <i>pAddress</i>
///               parameter is <b>NULL</b>, then the packet is sent to the source address of the client request.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeSendReply(HANDLE hClientRequest, char* pPacket, uint uPacketLen, PXE_ADDRESS* pAddress);

///Passes the results of processing the client request asynchronously. This function should be called only if the
///PxeProviderRecvRequest function returns <b>ERROR_IO_PENDING</b>.
///Params:
///    hClientRequest = Handle to the request received from the client.
///    Action = Specifies the action that the system should take for this client request. The following table lists the possible
///             values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PXE_BA_NBP"></a><a
///             id="pxe_ba_nbp"></a><dl> <dt><b>PXE_BA_NBP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The provider replied
///             to the client with a standard DHCP response packet that contains the path to the Network Boot Program. Returning
///             this action means that the provider successfully completed the client request by calling the PxeSendReply
///             function at least once. </td> </tr> <tr> <td width="40%"><a id="PXE_BA_CUSTOM"></a><a id="pxe_ba_custom"></a><dl>
///             <dt><b>PXE_BA_CUSTOM</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The provider replied to the client by using
///             a custom response that does not conform to DHCP specifications. Returning this action means that the provider
///             successfully completed the client request by calling the PxeSendReply function at least once. </td> </tr> <tr>
///             <td width="40%"><a id="PXE_BA_IGNORE"></a><a id="pxe_ba_ignore"></a><dl> <dt><b>PXE_BA_IGNORE</b></dt> <dt>3</dt>
///             </dl> </td> <td width="60%"> The provider does not want to service the client request and the request should not
///             be passed to the next provider. All resources associated with the client request are released and the client
///             request is ignored. Providers can also use this value if they recognize the client but the request was malformed.
///             </td> </tr> <tr> <td width="40%"><a id="PXE_BA_REJECTED"></a><a id="pxe_ba_rejected"></a><dl>
///             <dt><b>PXE_BA_REJECTED</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The provider does not want to service the
///             client request. The system passes the request to the next provider in the list of registered providers. If this
///             was the last provider in the list, then all resources associated with the client request are released and client
///             request is ignored. </td> </tr> </table>
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeAsyncRecvDone(HANDLE hClientRequest, uint Action);

///Adds a trace entry to the PXE log.
///Params:
///    hProvider = <b>HANDLE</b> passed to the PxeProviderInitialize function.
///    Severity = Severity of trace entry. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///               id="PXE_TRACE_VERBOSE"></a><a id="pxe_trace_verbose"></a><dl> <dt><b>PXE_TRACE_VERBOSE</b></dt>
///               <dt>0x00010000</dt> </dl> </td> <td width="60%"> The trace entry is verbose and would primarily be useful when
///               debugging. </td> </tr> <tr> <td width="40%"><a id="PXE_TRACE_INFO"></a><a id="pxe_trace_info"></a><dl>
///               <dt><b>PXE_TRACE_INFO</b></dt> <dt>0x00020000</dt> </dl> </td> <td width="60%"> The trace entry is informational,
///               but does not indicate a warning condition. </td> </tr> <tr> <td width="40%"><a id="PXE_TRACE_WARNING"></a><a
///               id="pxe_trace_warning"></a><dl> <dt><b>PXE_TRACE_WARNING</b></dt> <dt>0x00040000</dt> </dl> </td> <td
///               width="60%"> The trace message indicates a warning. </td> </tr> <tr> <td width="40%"><a
///               id="PXE_TRACE_ERROR"></a><a id="pxe_trace_error"></a><dl> <dt><b>PXE_TRACE_ERROR</b></dt> <dt>0x00080000</dt>
///               </dl> </td> <td width="60%"> The trace message indicates an error condition. </td> </tr> <tr> <td width="40%"><a
///               id="PXE_TRACE_FATAL"></a><a id="pxe_trace_fatal"></a><dl> <dt><b>PXE_TRACE_FATAL</b></dt> <dt>0x00100000</dt>
///               </dl> </td> <td width="60%"> The trace message indicates a fatal error condition. </td> </tr> </table>
///    pszFormat = Address of a buffer that contains a printf-style format string.
///    arg4 = Optional arguments. The number and type of argument parameters depend on the format control string pointed to by
///           the <i>pszFormat</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeTrace(HANDLE hProvider, uint Severity, const(wchar)* pszFormat);

@DllImport("WDSPXE")
uint PxeTraceV(HANDLE hProvider, uint Severity, const(wchar)* pszFormat, byte* Params);

///Allocates a packet to be sent with the PxeSendReply function.
///Params:
///    hProvider = <b>HANDLE</b> passed to the PxeProviderInitialize function.
///    hClientRequest = Handle to the client request received in the PxeProviderRecvRequest callback.
///    uSize = Size of the buffer to be allocated.
///Returns:
///    Address of allocated buffer, or <b>NULL</b> if the allocation failed. For extended error information, use the
///    GetLastError function.
///    
@DllImport("WDSPXE")
void* PxePacketAllocate(HANDLE hProvider, HANDLE hClientRequest, uint uSize);

///Frees a packet allocated by the PxePacketAllocate function.
///Params:
///    hProvider = <b>HANDLE</b> passed to the PxeProviderInitialize function.
///    hClientRequest = Handle to the client request received in the PxeProviderRecvRequest callback.
///    pPacket = Pointer to packet allocated by the PxePacketAllocate function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxePacketFree(HANDLE hProvider, HANDLE hClientRequest, void* pPacket);

///Specifies attributes for the provider.
///Params:
///    hProvider = <b>HANDLE</b> passed to the PxeProviderInitialize function.
///    Attribute = Identifies the attribute to set. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                id="PXE_PROV_ATTR_FILTER"></a><a id="pxe_prov_attr_filter"></a><dl> <dt><b>PXE_PROV_ATTR_FILTER</b></dt>
///                <dt>0</dt> </dl> </td> <td width="60%"> The <i>pParameterBuffer</i> parameter points to a <b>ULONG</b>. </td>
///                </tr> <tr> <td width="40%"><a id="PXE_PROV_ATTR_FILTER_IPV6"></a><a id="pxe_prov_attr_filter_ipv6"></a><dl>
///                <dt><b>PXE_PROV_ATTR_FILTER_IPV6</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The <i>pParameterBuffer</i>
///                parameter points to a <b>ULONG</b>. Use this attribute with DHCPv6 packets. Available beginning with Windows 8
///                and Windows Server 2012. </td> </tr> <tr> <td width="40%"><a id="PXE_PROV_ATTR_IPV6_CAPABLE"></a><a
///                id="pxe_prov_attr_ipv6_capable"></a><dl> <dt><b>PXE_PROV_ATTR_IPV6_CAPABLE</b></dt> <dt>2</dt> </dl> </td> <td
///                width="60%"> Pointer to a <b>BOOL</b> value that is TRUE to indicate the provider is capable of processing IPv6
///                packets. By default, the server assumes a provider is not capable of processing IPv6 packets and will not deliver
///                them. Available beginning with Windows 8 and Windows Server 2012. </td> </tr> </table>
///    pParameterBuffer = Pointer to a buffer. The size and contents of this buffer vary depending on the value of the <i>Attribute</i>
///                       parameter. If <i>Attribute</i> is PXE_PROV_ATTR_FILTER, the buffer contains one of the following values. <table>
///                       <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="PXE_PROV_FILTER_ALL"></a><a
///                       id="pxe_prov_filter_all"></a><dl> <dt><b>PXE_PROV_FILTER_ALL</b></dt> <dt>0x0000</dt> </dl> </td> <td
///                       width="60%"> Provider is to see all packets. </td> </tr> <tr> <td width="40%"><a
///                       id="PXE_PROV_FILTER_DHCP_ONLY"></a><a id="pxe_prov_filter_dhcp_only"></a><dl>
///                       <dt><b>PXE_PROV_FILTER_DHCP_ONLY</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Provider will see only
///                       DHCP packets. If <b>PXE_PROV_ATTR_FILTER_IPV6</b>, the provider will see only only DHCPv6 packets </td> </tr>
///                       <tr> <td width="40%"><a id="PXE_PROV_FILTER_PXE_ONLY"></a><a id="pxe_prov_filter_pxe_only"></a><dl>
///                       <dt><b>PXE_PROV_FILTER_PXE_ONLY</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Provider will see only DHCP
///                       packets that specify the DHCP Vendor Class Identifier option (60) as "PXEClient". If
///                       <b>PXE_PROV_ATTR_FILTER_IPV6</b>, provider will see only packets that specify a DHCPv6 OPTION_VENDOR_CLASS
///                       containing the “PXEClient”. </td> </tr> </table>
///    uParamLen = The size of the buffer pointed to by the <i>pParameterBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeProviderSetAttribute(HANDLE hProvider, uint Attribute, char* pParameterBuffer, uint uParamLen);

///Initializes a response packet as a DHCP reply packet.
///Params:
///    pRecvPacket = Address of a valid DHCP packet received from the client in the PxeProviderRecvRequest callback.
///    uRecvPacketLen = Length of the packet pointed to by the <i>pRecvPacket</i> parameter.
///    pReplyPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uMaxReplyPacketLen = Allocated length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    puReplyPacketLen = Address of a <b>ULONG</b> that on successful completion will receive the length of the packet pointed to by the
///                       <i>pReplyPacket</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpInitialize(char* pRecvPacket, uint uRecvPacketLen, char* pReplyPacket, uint uMaxReplyPacketLen, 
                       uint* puReplyPacketLen);

///Initializes a response packet as a DHCPv6 reply packet. For RELAY-FORW messages, this function initializes the
///message type, hop count, link address and peer address. For other DHCPv6 request types, this function initializes the
///message type and transaction ID. In all cases, the option payload of the produced packet will be empty. For more
///information about RELAY-FORW messages, developers should refer to the Dynamic Host Configuration Protocol for IPv6
///(RFC 3315) maintained by The Internet Engineering Task Force (IETF).
///Params:
///    pRequest = Address of a valid DHCPv6 packet received from the client in the PxeProviderRecvRequest callback.
///    cbRequest = Length of the packet pointed to by the <i>pRequest</i> parameter.
///    pReply = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    cbReply = Allocated length of the packet pointed to by the <i>pReply</i> parameter.
///    pcbReplyUsed = Address of a <b>ULONG</b> that on successful completion will receive the length of the packet pointed to by the
///                   <i>pReply</i> parameter.
@DllImport("WDSPXE")
uint PxeDhcpv6Initialize(char* pRequest, uint cbRequest, char* pReply, uint cbReply, uint* pcbReplyUsed);

///Appends a DHCP option to the reply packet.
///Params:
///    pReplyPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uMaxReplyPacketLen = Allocated length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    puReplyPacketLen = Address of a <b>ULONG</b> that on successful completion will receive the length of the packet pointed to by the
///                       <i>pReplyPacket</i> parameter.
///    bOption = DHCP option to add to the packet.
///    bOptionLen = Length of the option value pointed to by the <i>pValue</i> parameter. This parameter is ignored if the
///                 <i>bOption</i> parameter is End Option (0xFF) or Pad Option (0x00).
///    pValue = Address of the buffer that contains the DHCP option value. This parameter is ignored if the <i>bOption</i>
///             parameter is End Option (0xFF) or Pad Option (0x00).
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpAppendOption(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ubyte bOption, 
                         ubyte bOptionLen, char* pValue);

///Appends a DHCPv6 option to the reply packet.
///Params:
///    pReply = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    cbReply = The total size in bytes allocated for the buffer that is pointed to by <i>pReply</i>.
///    pcbReplyUsed = On entry, this is the number of bytes of the buffer pointed to by <i>pReply</i> that are currently used. On
///                   success of the function, this is updated to the number of bytes used after appending the option.
///    wOptionType = DHCPv6 option to add to the packet.
///    cbOption = Length of the option value pointed to by the <i>pOption</i> parameter.
///    pOption = Address of the buffer that contains the DHCPv6 option value.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpv6AppendOption(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort wOptionType, ushort cbOption, 
                           char* pOption);

///Appends a DHCP option to the reply packet.
///Params:
///    pReplyPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uMaxReplyPacketLen = Allocated length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    puReplyPacketLen = Address of a <b>ULONG</b> that on successful completion will receive the length of the packet pointed to by the
///                       <i>pReplyPacket</i> parameter.
///    uBufferLen = Length of the option value pointed to by the <i>pBuffer</i> parameter.
///    pBuffer = Address of the buffer that contains the DHCP option value.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpAppendOptionRaw(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ushort uBufferLen, 
                            char* pBuffer);

///Appends a DHCPv6 option to the reply packet.
///Params:
///    pReply = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    cbReply = Allocated length of the packet pointed to by the <i>pReply</i> parameter.
///    pcbReplyUsed = On entry, this is the number of bytes of the buffer pointed to by <i>pReply</i> that are currently used. On
///                   success of the function, this is updated to the number of bytes used after appending the option.
///    cbBuffer = Length of the option value pointed to by the <i>pBuffer</i> parameter.
///    pBuffer = Address of the buffer that contains the DHCPv6 option value. The buffer must contain the encoded option code and
///              option size. For more information about encoding the option code and option size, developers should refer to the
///              Dynamic Host Configuration Protocol for IPv6 RFC 3315 maintained by The Internet Engineering Task Force (IETF).
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpv6AppendOptionRaw(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort cbBuffer, char* pBuffer);

///Validates that a packet is a DHCP packet.
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pPacket</i> parameter.
///    bRequestPacket = Indicates whether the packet is a request packet. The following table lists the possible values. <table> <tr>
///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///                     <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Packet to be validated is a request packet from the
///                     client. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///                     <dt>0</dt> </dl> </td> <td width="60%"> Packet to be validated is a packet generated by the server. </td> </tr>
///                     </table>
///    pbPxeOptionPresent = Address of a <b>BOOL</b> that is set to <b>TRUE</b> if the packet is a valid DHCP packet that contains the Vendor
///                         Class Identifier option (60) with the value set to "PXEClient".
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpIsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

///Validates that a packet is a valid DHCPv6 packet. For more information about valid DHCPv6 packets, developers should
///refer to the Dynamic Host Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task
///Force (IETF).
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pPacket</i> parameter.
///    bRequestPacket = Indicates whether the packet is a request packet. The following table lists the possible values. <table> <tr>
///                     <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="TRUE"></a><a id="true"></a><dl>
///                     <dt><b>TRUE</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Packet to be validated is a request packet from the
///                     client. </td> </tr> <tr> <td width="40%"><a id="FALSE"></a><a id="false"></a><dl> <dt><b>FALSE</b></dt>
///                     <dt>0</dt> </dl> </td> <td width="60%"> Packet to be validated is a packet generated by the server. </td> </tr>
///                     </table>
///    pbPxeOptionPresent = Address of a <b>BOOL</b> that is set to <b>TRUE</b> if the packet is a valid DHCPv6 packet.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeDhcpv6IsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

///Retrieves an option value from a DHCP packet.
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    uInstance = One-based index that specifies which instance of the <i>bOption</i> parameter to retrieve.
///    bOption = Option whose value will be retrieved.
///    pbOptionLen = Address of <b>BYTE</b> which will receive the length of the option value.
///    ppOptionValue = Address of <b>PVOID</b> which will receive the address of the option value inside the packet.
///Returns:
///    Common return values are listed in the following table. For all other failures, an appropriate Windows error code
///    is returned. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The option was found and a pointer to
///    the value was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> <dt>2
///    (0x2)</dt> </dl> </td> <td width="60%"> The option was not located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13 (0xD)</dt> </dl> </td> <td width="60%"> The packet is not a valid DHCP
///    packet. This test is not as thorough as the tests used by the PxeDhcpIsValid function; only the packet length and
///    magic cookie are verified. </td> </tr> </table>
///    
@DllImport("WDSPXE")
uint PxeDhcpGetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ubyte bOption, ubyte* pbOptionLen, 
                           void** ppOptionValue);

///Retrieves an option value from a DHCPv6 packet.
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    uInstance = One-based index that specifies which instance of the <i>wOption</i> parameter to retrieve.
///    wOption = Option whose value will be retrieved.
///    pwOptionLen = Address of <b>WORD</b> which will receive the length of the option value.
///    ppOptionValue = Address of <b>PVOID</b> which will receive the address of the option value inside the packet.
///Returns:
///    Common return values are listed in the following table. For all other failures, an appropriate Windows error code
///    is returned. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The option was found and a pointer to
///    the value was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> <dt>2
///    (0x2)</dt> </dl> </td> <td width="60%"> The option was not located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13 (0xD)</dt> </dl> </td> <td width="60%"> The packet is not a valid
///    DHCPv6 packet. This test is not as thorough as the tests used by the PxeDhcpv6IsValid function; only the packet
///    length and magic cookie are verified. </td> </tr> </table>
///    
@DllImport("WDSPXE")
uint PxeDhcpv6GetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ushort wOption, ushort* pwOptionLen, 
                             void** ppOptionValue);

///Retrieves an option value from the Vendor Specific Information field (43) of a DHCP packet.
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    bOption = Option whose value will be retrieved.
///    uInstance = One-based index that specifies which instance of the <i>bOption</i> parameter to retrieve.
///    pbOptionLen = Address of <b>BYTE</b> which will receive the length of the option value.
///    ppOptionValue = Address of <b>PVOID</b> which will receive the address of the option value inside the packet.
///Returns:
///    Common return values are listed in the following table. For all other failures, an appropriate Windows error code
///    is returned. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The option was found and a pointer to
///    the value was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> <dt>2
///    (0x2)</dt> </dl> </td> <td width="60%"> The option was not located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13 (0xD)</dt> </dl> </td> <td width="60%"> The packet is not a valid DHCP
///    packet. This test is not as thorough as the tests used by the PxeDhcpIsValid function; only the packet length and
///    magic cookie are verified. </td> </tr> </table>
///    
@DllImport("WDSPXE")
uint PxeDhcpGetVendorOptionValue(char* pPacket, uint uPacketLen, ubyte bOption, uint uInstance, ubyte* pbOptionLen, 
                                 void** ppOptionValue);

///Retrieves option values from the OPTION_VENDOR_OPTS (17) field of a DHCPv6 packet.
///Params:
///    pPacket = Pointer to a reply packet allocated with the PxePacketAllocate function.
///    uPacketLen = Length of the packet pointed to by the <i>pReplyPacket</i> parameter.
///    dwEnterpriseNumber = An Enterprise Number assigned to the vendor of the option by the Internet Assigned Numbers Authority (IANA). For
///                         more information about assigned Enterprise Numbers, developers should refer to the Dynamic Host Configuration
///                         Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task Force (IETF).
///    wOption = Option whose value will be retrieved.
///    uInstance = One-based index that specifies which instance of the <i>wOption</i> parameter to retrieve.
///    pwOptionLen = Address of <b>WORD</b> which will receive the length of the option value.
///    ppOptionValue = Address of <b>PVOID</b> which will receive the address of the option value inside the packet.
///Returns:
///    Common return values are listed in the following table. For all other failures, an appropriate Windows error code
///    is returned. <table> <tr> <th>Return code/value</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_SUCCESS</b></dt> <dt>0 (0x0)</dt> </dl> </td> <td width="60%"> The option was found and a pointer to
///    the value was returned. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> <dt>2
///    (0x2)</dt> </dl> </td> <td width="60%"> The option was not located. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> <dt>13 (0xD)</dt> </dl> </td> <td width="60%"> The packet is not a valid DHCP
///    packet. This test is not as thorough as the tests used by the PxeDhcpv6IsValid function; only the packet length
///    and magic cookie are verified. </td> </tr> </table>
///    
@DllImport("WDSPXE")
uint PxeDhcpv6GetVendorOptionValue(char* pPacket, uint uPacketLen, uint dwEnterpriseNumber, ushort wOption, 
                                   uint uInstance, ushort* pwOptionLen, void** ppOptionValue);

///This function can be used by a provider to parse RELAY-FORW messages and their nested OPTION_RELAY_MSG messages. The
///information returned can be used to construct a RELAY-REPL packet using the PxeDhcpv6CreateRelayRepl function. For
///more information about RELAY-FORW and OPTION_RELAY_MSG messages, developers should refer to the Dynamic Host
///Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task Force (IETF).
///Params:
///    pRelayForwPacket = Specifies a pointer to a DHCPv6 RELAY-FORW message.
///    uRelayForwPacketLen = The size in bytes of the RELAY-FORW message pointed to by the <i>pRelayForwPacket</i> parameter.
///    pRelayMessages = An array of PXE_DHCPV6_NESTED_RELAY_MESSAGE structures initialized by this routine. The array’s size is
///                     specified by <i>nRelayMessages</i>. Elements of this array are initialized to point to the nested chain of relay
///                     packets encoded in OPTION_RELAY_MSG. Index 0 is the outermost nested OPTION_RELAY_MSG packet. As the index
///                     increases the pointers correspond to more deeply nested OPTION_RELAY_MSG packets.
///    nRelayMessages = The size of the array, in number of array elements, pointed to by the <i>pRelayMessages</i> parameter.
///    pnRelayMessages = Specifies a pointer to a <b>ULONG</b> value which on success receives the actual number of elements written into
///                      the <i>pRelayMessages</i> array.
///    ppInnerPacket = Specifies a pointer to a <b>PVOID</b> value which on success is set to the start of the innermost packet in the
///                    relay chain. This is the original client request packet.
///    pcbInnerPacket = Specifies a pointer to a <b>ULONG</b> value which on success will be set to the size, in bytes, of the innermost
///                     packet in the relay chain which is the original client request packet.
@DllImport("WDSPXE")
uint PxeDhcpv6ParseRelayForw(char* pRelayForwPacket, uint uRelayForwPacketLen, char* pRelayMessages, 
                             uint nRelayMessages, uint* pnRelayMessages, ubyte** ppInnerPacket, uint* pcbInnerPacket);

///Generates a RELAY-REPL message. For more information about RELAY-REPL and RELAY-FORW messages, developers should
///refer to the Dynamic Host Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task
///Force (IETF).
///Params:
///    pRelayMessages = An array of <b>PXE_DHCPV6_NESTED_RELAY_FORW</b> structures which together specify the sequence of nested
///                     RELAY-FORW packets. This value can be obtained from the <i>pRelayMessages</i> parameter of
///                     PxeDhcpv6ParseRelayForw.
///    nRelayMessages = The number of elements in the array pointed to by the <i>pRelayMessages</i> argument.
///    pInnerPacket = A pointer to a packet which is the server’s response to the innermost packet in the RELAY-FORW chain.
///    cbInnerPacket = The size of the packet pointed to by the <i>pInnerPacket</i> argument.
///    pReplyBuffer = A pointer to a buffer used to construct the outer RELAY-REPL packet. This buffer receives the nested response
///                   packet and the nested RELAY-REPL chain specified by the <i>pRelayMessages</i> parameter.
///    cbReplyBuffer = The size of the buffer in bytes pointed to by <i>pRelyBuffer</i>.
///    pcbReplyBuffer = On success, this is set to the actual size of the RELAY-REPL packet in the buffer pointed to by
///                     <i>pRelyBuffer</i>.
@DllImport("WDSPXE")
uint PxeDhcpv6CreateRelayRepl(char* pRelayMessages, uint nRelayMessages, char* pInnerPacket, uint cbInnerPacket, 
                              char* pReplyBuffer, uint cbReplyBuffer, uint* pcbReplyBuffer);

///Returns information about the PXE server.
///Params:
///    uInfoType = Selects the information that will be returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="PXE_GSI_TRACE_ENABLED"></a><a id="pxe_gsi_trace_enabled"></a><dl>
///                <dt><b>PXE_GSI_TRACE_ENABLED</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Returns a <b>BOOL</b> that
///                indicates whether tracing is enabled for the server. <b>TRUE</b> indicates that tracing is enabled. </td> </tr>
///                </table>
///    pBuffer = Address of a buffer that will receive the results of the query. The size and format of the results depends on the
///              value of the <i>uInfoType</i> parameter.
///    uBufferLen = Size of buffer pointed to by the <i>pBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeGetServerInfo(uint uInfoType, char* pBuffer, uint uBufferLen);

///Returns information about the PXE server. For more information about the OPTION_SERVERID option, developers should
///refer to the Dynamic Host Configuration Protocol for IPv6 (RFC 3315) maintained by The Internet Engineering Task
///Force (IETF).
///Params:
///    uInfoType = Selects the information that will be returned. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
///                width="40%"><a id="PXE_GSI_TRACE_ENABLED"></a><a id="pxe_gsi_trace_enabled"></a><dl>
///                <dt><b>PXE_GSI_TRACE_ENABLED</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Returns a <b>BOOL</b> that
///                indicates whether tracing is enabled for the server. <b>TRUE</b> indicates that tracing is enabled. </td> </tr>
///                <tr> <td width="40%"><a id="PXE_GSI_SERVER_DUID"></a><a id="pxe_gsi_server_duid"></a><dl>
///                <dt><b>PXE_GSI_SERVER_DUID</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Returns a byte array that corresponds
///                to the DHCPv6 DUID that is sent to DHCPv6 PXE clients in response packets in the OPTION_SERVERID option.
///                <b>PXE_GSI_SERVER_DUID</b> cannot be used with PxeGetServerInfo. </td> </tr> </table>
///    pBuffer = Address of a buffer that will receive the results of the query. The size and format of the results depends on the
///              value of the <i>uInfoType</i> parameter.
///    uBufferLen = Size of buffer pointed to by the <i>pBuffer</i> parameter.
///    puBufferUsed = Size of buffer pointed to by the <i>pBuffer</i> parameter.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSPXE")
uint PxeGetServerInfoEx(uint uInfoType, char* pBuffer, uint uBufferLen, uint* puBufferUsed);

///Registers a provider callback with the multicast server.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
///    CallbackId = The value of this parameter is a TRANSPORTPROVIDER_CALLBACK_ID structure.
///    pfnCallback = Pointer to the function pointer associated with this id.
@DllImport("WDSMC")
HRESULT WdsTransportServerRegisterCallback(HANDLE hProvider, TRANSPORTPROVIDER_CALLBACK_ID CallbackId, 
                                           void* pfnCallback);

///Provides status of read operation.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
///    ulBytesRead = The number of bytes read.
///    pvUserData = User data specified by WdsTransportProviderReadContent.
///    hReadResult = The status of this read operation.
@DllImport("WDSMC")
HRESULT WdsTransportServerCompleteRead(HANDLE hProvider, uint ulBytesRead, void* pvUserData, HRESULT hReadResult);

///Sends a debugging message.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
///    Severity = Severity level of the message.
///    pwszFormat = A pointer to a null-terminated string value that contains a formatted string.
///    arg4 = Additional arguments.
@DllImport("WDSMC")
HRESULT WdsTransportServerTrace(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat);

///Sends a debugging message.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
///    Severity = Severity level of the message.
///    pwszFormat = A pointer to a null-terminated string value that contains a formatted string.
///    Params = A list of parameters used by the formatted string.
@DllImport("WDSMC")
HRESULT WdsTransportServerTraceV(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat, byte* Params);

///Allocates a buffer in memory.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
@DllImport("WDSMC")
void* WdsTransportServerAllocateBuffer(HANDLE hProvider, uint ulBufferSize);

///Releases memory used by a buffer.
///Params:
///    hProvider = Handle to the provider. This handle was given to the provider in the WdsTransportProviderInitialize function.
///    pvBuffer = Pointer to location of buffer to be released.
@DllImport("WDSMC")
HRESULT WdsTransportServerFreeBuffer(HANDLE hProvider, void* pvBuffer);

///Initializes the Multicast Client. This function should be called before any other function is called in the multicast
///client.
@DllImport("WDSTPTC")
uint WdsTransportClientInitialize();

///Initiates a multicast file transfer.
///Params:
///    pSessionRequest = Pointer to a WDS_TRANSPORTCLIENT_REQUEST structure that contains all the details required to initiate the
///                      multicast session. The format of this structure is described below.
///    pCallerData = User supplied pointer that will be provided with every callback for this session.
///    hSessionKey = Buffer that will receive the address of a handle that the consumer can use to uniquely identify this session to
///                  the client.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientInitializeSession(WDS_TRANSPORTCLIENT_REQUEST* pSessionRequest, void* pCallerData, 
                                         ptrdiff_t* hSessionKey);

///Registers a callback with the multicast client.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession.
///    CallbackId = Identifier specifying which callback is being registered. This parameter receives a TRANSPORTCLIENT_CALLBACK_ID
///                 enumeration value. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl>
///                 <dt>WDS_TRANSPORTCLIENT_SESSION_START</dt> </dl> </td> <td width="60%"> Identifies the
///                 PFN_WdsTransportClientSessionStart callback. This callback is required. </td> </tr> <tr> <td width="40%"> <dl>
///                 <dt>WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS</dt> </dl> </td> <td width="60%"> Identifies the
///                 PFN_WdsTransportClientReceiveContents callback. This callback is required. </td> </tr> <tr> <td width="40%"> <dl>
///                 <dt>WDS_TRANSPORTCLIENT_SESSION_COMPLETE</dt> </dl> </td> <td width="60%"> Identifies the
///                 PFN_WdsTransportClientSessionComplete callback. This callback is required. </td> </tr> <tr> <td width="40%"> <dl>
///                 <dt>WDS_TRANSPORTCLIENT_RECEIVE_METADATA</dt> </dl> </td> <td width="60%"> Identifies the
///                 PFN_WdsTransportClientReceiveMetadata callback. This callback is optional. </td> </tr> </table>
///    pfnCallback = Pointer to the function pointer associated with this id.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientRegisterCallback(HANDLE hSessionKey, TRANSPORTCLIENT_CALLBACK_ID CallbackId, 
                                        void* pfnCallback);

///Initiates a multicast file transfer.
///Params:
///    hSessionKey = The handle returned by the WdsTransportClientInitializeSession session.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientStartSession(HANDLE hSessionKey);

///Indicates that all processing on a block of data is finished, and that the multicast client may purge this block of
///data from its cache to make room for further receives.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession.
///    ulSize = The size of the block being released.
///    pullOffset = The offset of the block being released.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientCompleteReceive(HANDLE hSessionKey, uint ulSize, ULARGE_INTEGER* pullOffset);

///Releases the resources associated with a session in the client.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession. This session will eventually complete
///                  with an error code of <b>ERROR_CANCELLED</b> to the callback PFN_WdsTransportClientSessionComplete callback.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientCancelSession(HANDLE hSessionKey);

@DllImport("WDSTPTC")
uint WdsTransportClientCancelSessionEx(HANDLE hSessionKey, uint dwErrorCode);

///Blocks until either the multicast session is complete or the specified timeout is reached.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession.
///    uTimeout = A timeout, in milliseconds.
@DllImport("WDSTPTC")
uint WdsTransportClientWaitForCompletion(HANDLE hSessionKey, uint uTimeout);

///Retrieves the current status of an ongoing or complete multicast transmission from the multicast client.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession.
///    puStatus = The current status of the transfer. This can be one of the following values. <table> <tr> <th>Value</th>
///               <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>WDS_TRANSPORTCLIENT_STATUS_IN_PROGRESS</dt> </dl> </td> <td
///               width="60%"> The multicast session is still in progress. </td> </tr> <tr> <td width="40%"> <dl>
///               <dt>WDS_TRANSPORTCLIENT_STATUS_SUCCESS</dt> </dl> </td> <td width="60%"> The multicast session completed
///               successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt>WDS_TRANSPORTCLIENT_STATUS_FAILURE</dt> </dl> </td> <td
///               width="60%"> The multicast session failed. </td> </tr> </table>
///    puErrorCode = If puStatus is set to <b>WDS_TRANSPORTCLIENT_STATUS_FAILURE</b>, this field will be set to the error code of the
///                  session.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientQueryStatus(HANDLE hSessionKey, uint* puStatus, uint* puErrorCode);

///Releases the resources associated with a session in the client.
///Params:
///    hSessionKey = Unique handle returned by the call to WdsTransportClientInitializeSession. After this handle has been used with
///                  the <b>WdsTransportClientCloseSession</b>, it cannot be used again with the WdsTransportClientCancelSession
///                  function.
///Returns:
///    If the function succeeds, the return value is <b>ERROR_SUCCESS</b>.
///    
@DllImport("WDSTPTC")
uint WdsTransportClientCloseSession(HANDLE hSessionKey);

///Increments the reference count on a buffer owned by the multicast client.
///Params:
///    pvBuffer = The buffer on which to increment the reference count.
@DllImport("WDSTPTC")
uint WdsTransportClientAddRefBuffer(void* pvBuffer);

///Decrements the reference count on a buffer owned by the multicast client.
///Params:
///    pvBuffer = The buffer on which to decrement the reference count.
@DllImport("WDSTPTC")
uint WdsTransportClientReleaseBuffer(void* pvBuffer);

///Shuts down the multicast client.
@DllImport("WDSTPTC")
uint WdsTransportClientShutdown();

///Receives a handle to the packet sent by the network boot program.
///Params:
///    pPacket = A pointer to the packet received from the WDS client. The packet must be a valid DHCP packet.
///    uPacketLen = The length of the packet, in bytes.
///    pbPacketType = A value that indicates the type of boot program that sent the packet. The bit flags in the following table can be
///                   combined. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
///                   id="WDSBP_PK_TYPE_DHCP"></a><a id="wdsbp_pk_type_dhcp"></a><dl> <dt><b>WDSBP_PK_TYPE_DHCP</b></dt> <dt>1</dt>
///                   </dl> </td> <td width="60%"> The presence of this value indicates that the packet is a DHCP packet. </td> </tr>
///                   <tr> <td width="40%"><a id="WDSBP_PK_TYPE_WDSNBP"></a><a id="wdsbp_pk_type_wdsnbp"></a><dl>
///                   <dt><b>WDSBP_PK_TYPE_WDSNBP</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> This presence of this value
///                   indicates that the DHCP packet came from the WDS network boot program. If this value is absent the type of client
///                   was not recognized. </td> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_BCD"></a><a
///                   id="wdsbp_pk_type_bcd"></a><dl> <dt><b>WDSBP_PK_TYPE_BCD</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The
///                   presence of this value indicates that the packet contains a path to a Boot Configuration Data (BCD) file. </td>
///                   </tr> </table>
///    phHandle = A handle to the packet. This handle can be used by the WdsBpQueryOption function and must be closed using the
///               WdsBpCloseHandle function.
@DllImport("WDSBP")
uint WdsBpParseInitialize(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

///Receives a handle to the packet sent by the network boot program.
///Params:
///    pPacket = A pointer to the packet received from the WDS client. The packet must be a valid DHCPv6 packet.
///    uPacketLen = The length of the packet, in bytes.
///    pbPacketType = A value that indicates the type of boot program that sent the packet. The bit flags in the following table can be
///                   combined except <b>WDSBP_PK_TYPE_DHCP</b> and <b>WDSBP_PK_TYPE_DHCPV6</b> are mutually exclusive. <table> <tr>
///                   <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_DHCP"></a><a
///                   id="wdsbp_pk_type_dhcp"></a><dl> <dt><b>WDSBP_PK_TYPE_DHCP</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The
///                   presence of this value indicates that the packet is a DHCP packet. This value is mutually exclusive of
///                   <b>WDSBP_PK_TYPE_DHCPV6</b>. </td> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_WDSNBP"></a><a
///                   id="wdsbp_pk_type_wdsnbp"></a><dl> <dt><b>WDSBP_PK_TYPE_WDSNBP</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
///                   This presence of this value indicates that the DHCPv6 packet came from the WDS network boot program. If this
///                   value is absent the type of client was not recognized. </td> </tr> <tr> <td width="40%"><a
///                   id="WDSBP_PK_TYPE_BCD"></a><a id="wdsbp_pk_type_bcd"></a><dl> <dt><b>WDSBP_PK_TYPE_BCD</b></dt> <dt>4</dt> </dl>
///                   </td> <td width="60%"> The presence of this value indicates that the packet contains a path to a Boot
///                   Configuration Data (BCD) file. </td> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_DHCPV6"></a><a
///                   id="wdsbp_pk_type_dhcpv6"></a><dl> <dt><b>WDSBP_PK_TYPE_DHCPV6</b></dt> <dt>8</dt> </dl> </td> <td width="60%">
///                   The presence of this value indicates that the packet is a DHCPV6 packet. This value is mutually exclusive of
///                   <b>WDSBP_PK_TYPE_DHCP</b>. </td> </tr> </table>
///    phHandle = A handle to the packet. This handle can be used by the WdsBpQueryOption function and must be closed using the
///               WdsBpCloseHandle function.
@DllImport("WDSBP")
uint WdsBpParseInitializev6(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

///Constructs options for the WDS network boot program.
///Params:
///    bPacketType = The type of boot program. This parameter may have one of the following values. <table> <tr> <th>Value</th>
///                  <th>Meaning</th> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_WDSNBP"></a><a
///                  id="wdsbp_pk_type_wdsnbp"></a><dl> <dt><b>WDSBP_PK_TYPE_WDSNBP</b></dt> <dt>2</dt> </dl> </td> <td width="60%">
///                  Specify this value to build a boot program using options for the "wdsnbp.com" boot program. The "wdsnbp.com" boot
///                  program is the WDS network boot program for IPv4 PXE on legacy BIOS systems and does not support other systems.
///                  </td> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_BCD"></a><a id="wdsbp_pk_type_bcd"></a><dl>
///                  <dt><b>WDSBP_PK_TYPE_BCD</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Specify this value to build a boot
///                  program using the <b>WDSBP_OPT_BCD_FILE_PATH</b> option. It may be used with "wdsnbp.com" or other boot programs.
///                  </td> </tr> <tr> <td width="40%"><a id="WDSBP_PK_TYPE_DHCPV6"></a><a id="wdsbp_pk_type_dhcpv6"></a><dl>
///                  <dt><b>WDSBP_PK_TYPE_DHCPV6</b></dt> <dt>8</dt> </dl> </td> <td width="60%"> Specify this value to indicate that
///                  the packet contains a path to a Boot Configuration Data (BCD) file. Use this value for any and all DHCPv6
///                  options. The presence of this value indicates that the packet contains a path to a Boot Configuration Data (BCD)
///                  file. </td> </tr> </table>
///    phHandle = A pointer to the handle to the packet. This handle can be used by the WdsBpAddOption function to add options for
///               the WDS network boot program. After all the options have been added, use the WdsBpGetOptionBuffer function to add
///               these to the DHCP options list sent to WDS network boot program. The handle must be closed using the
///               WdsBpCloseHandle function.
@DllImport("WDSBP")
uint WdsBpInitialize(ubyte bPacketType, HANDLE* phHandle);

///Closes the specified handle.
///Params:
///    hHandle = A handle to be closed. This can be a handle obtained using the WdsBpParseInitialize or WdsBpInitialize functions.
@DllImport("WDSBP")
uint WdsBpCloseHandle(HANDLE hHandle);

///Returns the value of an option from the parsed packet.
///Params:
///    hHandle = A handle returned by the WdsBpParseInitialize function.
///    uOption = Specifies the option to add to the packet.
///    uValueLen = The total number of bytes of memory pointed to by the <i>pValue</i> parameter. To determine the number of bytes
///                required to store the value for the option, set <i>uValueLen</i> to zero and <i>pValue</i> to <b>NULL</b>; the
///                <b>WdsBpQueryOption</b> function returns <b>ERROR_INSUFFICIENT_BUFFER</b>, and the location pointed to by the
///                <i>puBytes</i> parameter receives the number of bytes required for the value.
///    pValue = The value of the option is returned in this buffer.
///    puBytes = If the buffer is large enough for the value, this parameter receives the number of bytes copied to <i>pValue</i>.
///              If not enough space is available, this parameter receives the total number of bytes required to store the value.
@DllImport("WDSBP")
uint WdsBpQueryOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue, uint* puBytes);

///Adds an option to the packet.
///Params:
///    hHandle = A handle returned by the WdsBpInitialize function.
///    uOption = Specifies the option to add to the packet.
///    uValueLen = The length, in bytes, for the value.
///    pValue = A pointer to a location that contains the value for the option.
@DllImport("WDSBP")
uint WdsBpAddOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue);

///Copies information into a buffer that should be added to your DHCP packet options.
///Params:
///    hHandle = A handle to the packet. This handle must have been returned by the WdsBpInitialize function.
///    uBufferLen = The total number of bytes of memory pointed to by the <i>pBuffer</i> parameter. To determine the amount of memory
///                 required, call the <b>WdsBpGetOptionBuffer</b> function with <i>uBufferLen</i> set to zero and <i>pBuffer</i> set
///                 to <b>NULL</b>. The location pointed to by the <i>puBytes</i> parameter then receives the size required.
///    pBuffer = A pointer to a location in memory that receives the information that is being sent to the network boot program.
///    puBytes = The number of bytes copied to the buffer.
@DllImport("WDSBP")
uint WdsBpGetOptionBuffer(HANDLE hHandle, uint uBufferLen, char* pBuffer, uint* puBytes);


// Interfaces

@GUID("70590B16-F146-46BD-BD9D-4AAA90084BF5")
struct WdsTransportCacheable;

@GUID("C7F18B09-391E-436E-B10B-C3EF46F2C34F")
struct WdsTransportCollection;

@GUID("F21523F6-837C-4A58-AF99-8A7E27F8FF59")
struct WdsTransportManager;

@GUID("EA19B643-4ADF-4413-942C-14F379118760")
struct WdsTransportServer;

@GUID("C7BEEAAD-9F04-4923-9F0C-FBF52BC7590F")
struct WdsTransportSetupManager;

@GUID("8743F674-904C-47CA-8512-35FE98F6B0AC")
struct WdsTransportConfigurationManager;

@GUID("F08CDB63-85DE-4A28-A1A9-5CA3E7EFDA73")
struct WdsTransportNamespaceManager;

@GUID("65ACEADC-2F0B-4F43-9F4D-811865D8CEAD")
struct WdsTransportServicePolicy;

@GUID("EB3333E1-A7AD-46F5-80D6-6B740204E509")
struct WdsTransportDiagnosticsPolicy;

@GUID("3C6BC3F4-6418-472A-B6F1-52D457195437")
struct WdsTransportMulticastSessionPolicy;

@GUID("D8385768-0732-4EC1-95EA-16DA581908A1")
struct WdsTransportNamespace;

@GUID("B091F5A8-6A99-478D-B23B-09E8FEE04574")
struct WdsTransportNamespaceAutoCast;

@GUID("BADC1897-7025-44EB-9108-FB61C4055792")
struct WdsTransportNamespaceScheduledCast;

@GUID("D3E1A2AA-CAAC-460E-B98A-47F9F318A1FA")
struct WdsTransportNamespaceScheduledCastManualStart;

@GUID("A1107052-122C-4B81-9B7C-386E6855383F")
struct WdsTransportNamespaceScheduledCastAutoStart;

@GUID("0A891FE7-4A3F-4C65-B6F2-1467619679EA")
struct WdsTransportContent;

@GUID("749AC4E0-67BC-4743-BFE5-CACB1F26F57F")
struct WdsTransportSession;

@GUID("66D2C5E9-0FF6-49EC-9733-DAFB1E01DF1C")
struct WdsTransportClient;

@GUID("50343925-7C5C-4C8C-96C4-AD9FA5005FBA")
struct WdsTransportTftpClient;

@GUID("C8E9DCA2-3241-4E4D-B806-BC74019DFEDA")
struct WdsTransportTftpManager;

@GUID("E0BE741F-5A75-4EB9-8A2D-5E189B45F327")
struct WdsTransportContentProvider;

///Provides caching for objects that handle persistent data. This interface can be inherited by other interfaces that
///represent persisted objects.
@GUID("46AD894B-0BAB-47DC-84B2-7B553F1D8F80")
interface IWdsTransportCacheable : IDispatch
{
    ///Receives a value that indicates whether object data has been modified. This property is read-only.
    HRESULT get_Dirty(short* pbDirty);
    ///Discards all changes made to the object data members by clearing the IWdsTransportCacheable::Dirty property and
    ///then calling the object's IWdsTransportCacheable::Refresh method to reread the current object data.
    HRESULT Discard();
    ///Refreshes the object data members by rereading their values from the underlying data store. This is allowed only
    ///if the object's IWdsTransportCacheable::Dirty property has been set.
    HRESULT Refresh();
    ///Commits object data members to the underlying data store if the IWdsTransportCacheable::Dirty property has been
    ///set. Otherwise, the method returns with no action.
    HRESULT Commit();
}

///Represents a collection of Windows Deployment Services (WDS) transport management objects.
@GUID("B8BA4B1A-2FF4-43AB-996C-B2B10A91A6EB")
interface IWdsTransportCollection : IDispatch
{
    ///Receives the number of objects in this collection. This property is read-only.
    HRESULT get_Count(uint* pulCount);
    ///Receives a pointer to the object that matches the specified index. This property is read/write.
    HRESULT get_Item(uint ulIndex, IDispatch* ppVal);
    ///Receives a pointer to an enumerator that can be used to iterate over the objects in this collection. This
    ///property is read-only.
    HRESULT get__NewEnum(IUnknown* ppVal);
}

///Manages a WDS transport server. This is the top-level interface into the Windows Deployment Services (WDS) Transport
///Management API and the only interface that can be created using the <b>CoCreateInstance</b> function.
@GUID("5B0D35F5-1B13-4AFD-B878-6526DC340B5D")
interface IWdsTransportManager : IDispatch
{
    ///Creates an object of the IWdsTransportServer interface that can be used to manage a WDS transport server. The
    ///method confirms that the system can reach a WDS transport server with the specified name.
    ///Params:
    ///    bszServerName = The name of the WDS transport server to be represented by this object. This can be a NetBIOS name or a fully
    ///                    qualified DNS name. If the value is an empty string, the object represents the local computer.
    ///    ppWdsTransportServer = A pointer to the object of the IWdsTransportServer interface.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT GetWdsTransportServer(BSTR bszServerName, IWdsTransportServer* ppWdsTransportServer);
}

///Represents a WDS transport server. A WDS client can use an object of this interface to manage setup, configuration,
///and namespace tasks on the server.
@GUID("09CCD093-830D-4344-A30A-73AE8E8FCA90")
interface IWdsTransportServer : IDispatch
{
    ///Returns the name of the server represented by this object. This property is read-only.
    HRESULT get_Name(BSTR* pbszName);
    ///Returns a pointer to the object of an IWdsTransportSetupManager interface used to manage the setup functionality
    ///on this server. This property is read-only.
    HRESULT get_SetupManager(IWdsTransportSetupManager* ppWdsTransportSetupManager);
    ///Returns a pointer to the object of an IWdsTransportConfigurationManager interface used to manage the
    ///configuration of this server. This property is read-only.
    HRESULT get_ConfigurationManager(IWdsTransportConfigurationManager* ppWdsTransportConfigurationManager);
    ///Returns a pointer to the object of an IWdsTransportNamespaceManager interface used to manage namespaces on this
    ///server. This property is read-only.
    HRESULT get_NamespaceManager(IWdsTransportNamespaceManager* ppWdsTransportNamespaceManager);
    ///Disconnects a WDS client from a transport session and specifies what action the WDS client should take upon
    ///disconnection.
    ///Params:
    ///    ulClientId = A unique ID for the WDS that was generated by the WDS transport server.
    ///    DisconnectionType = A value of the WDSTRANSPORT_DISCONNECT_TYPE enumeration that specifies what action the WDS client should take
    ///                        upon disconnection from the WDS server.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT DisconnectClient(uint ulClientId, WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

///This interface inherits from the IWdsTransportServer interface and extends it. It is available beginning with Windows
///Server 2012. A client application can obtain an interface pointer to an instance of the <b>IWdsTransportServer2</b>
///interface by first getting an interface pointer to the IWdsTransportServer interface and then using the
///IUnknown::QueryInterface Method.
@GUID("256E999F-6DF4-4538-81B9-857B9AB8FB47")
interface IWdsTransportServer2 : IWdsTransportServer
{
    ///Receives a pointer to the object of the IWdsTransportTftpManager interface used to manage the WDS TFTP server.
    ///This property is available beginning with Windows Server 2012. This property is read-only.
    HRESULT get_TftpManager(IWdsTransportTftpManager* ppWdsTransportTftpManager);
}

///Manages setup tasks on a WDS transport server.
@GUID("F7238425-EFA8-40A4-AEF9-C98D969C0B75")
interface IWdsTransportSetupManager : IDispatch
{
    ///Receives a value that indicates the operating system version of the WDS server. This property is read-only.
    HRESULT get_Version(ulong* pullVersion);
    ///Receives a value that indicates which WDS features are installed on the server. This property is read/write.
    HRESULT get_InstalledFeatures(uint* pulInstalledFeatures);
    ///Receives a value that indicates which transport protocols are supported by the WDS server. This property is
    ///read-only.
    HRESULT get_Protocols(uint* pulProtocols);
    ///Enables an application run on a client computer to register a content provider DLL. This makes the provider
    ///available for use by the WDS transport server.
    ///Params:
    ///    bszName = The name of the content provider to be registered. This name must be unique on the server.
    ///    bszDescription = A description of the content provider that can be read by an administrator.
    ///    bszFilePath = The full path to the DLL that implements the content provider. The path can include environment variables.
    ///    bszInitializationRoutine = The name of a function exported by the content provider that the WDS transport server can use to initialize
    ///                               the provider.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RegisterContentProvider(BSTR bszName, BSTR bszDescription, BSTR bszFilePath, 
                                    BSTR bszInitializationRoutine);
    ///Enables an application run on a client computer to deregister a content provider. This makes the provider no
    ///longer available for use by the WDS transport server.
    ///Params:
    ///    bszName = The name of the content provider to be deregistered.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT DeregisterContentProvider(BSTR bszName);
}

///This interface inherits from the IWdsTransportSetupManager interface and extends it. It is available beginning with
///Windows Server 2012. A client application can obtain an interface pointer to an instance of the
///<b>IWdsTransportSetupManager2</b> interface by first getting an interface pointer to the IWdsTransportSetupManager
///interface and then using the IUnknown::QueryInterface Method.
@GUID("02BE79DA-7E9E-4366-8B6E-2AA9A91BE47F")
interface IWdsTransportSetupManager2 : IWdsTransportSetupManager
{
    ///Receives a mask of WDSTRANSPORT_TFTP_CAPABILITY values that indicates which WDS TFTP features are supported by
    ///the WDS TFTP server. This property is read-only.
    HRESULT get_TftpCapabilities(uint* pulTftpCapabilities);
    ///Receives a pointer to an instance of the IWdsTransportCollection interface. The collection contains objects of
    ///the IWdsTransportContentProvider interface for the content providers registered on the server. This property is
    ///available beginning with Windows Server 2012. This property is read-only.
    HRESULT get_ContentProviders(IWdsTransportCollection* ppProviderCollection);
}

///Manages the configuration of a WDS transport server.
@GUID("84CC4779-42DD-4792-891E-1321D6D74B44")
interface IWdsTransportConfigurationManager : IDispatch
{
    ///Receives an interface pointer to the Configuration Manager's Service Policy object. This object can be used to
    ///configure service parameters such as the multicast IP address source and the active network profile. This
    ///property is read-only.
    HRESULT get_ServicePolicy(IWdsTransportServicePolicy* ppWdsTransportServicePolicy);
    ///Receives an interface pointer to the Configuration Manager's Diagnostics Policy object. The object can be used to
    ///configure diagnostics settings that WDS transport server components enable for diagnostic event logging. This
    ///property is read-only.
    HRESULT get_DiagnosticsPolicy(IWdsTransportDiagnosticsPolicy* ppWdsTransportDiagnosticsPolicy);
    ///Receives a value that indicates whether WDS transport services are running on the server. This property is
    ///read-only.
    HRESULT get_WdsTransportServicesRunning(short bRealtimeStatus, short* pbServicesRunning);
    ///Sets all WDS transport services to Auto-Start mode.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT EnableWdsTransportServices();
    ///Sets all WDS transport services to Disabled mode.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT DisableWdsTransportServices();
    ///Starts all WDS transport services. This method provides the means to change the running state of WDS transport
    ///services without changing their configuration.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT StartWdsTransportServices();
    ///Stops all WDS transport services. This method provides the means to change the running state of WDS transport
    ///services without changing their configuration.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT StopWdsTransportServices();
    ///Stops and then restarts any WDS transport services that are running. If no services are running, the method
    ///returns with <b>S_OK</b> without further action.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RestartWdsTransportServices();
    ///Sends a notification to WDS transport services. The notification value is translated to the appropriate WDS
    ///transport service controls, and then these controls are sent to the appropriate services.
    ///Params:
    ///    ServiceNotification = A value of the WDSTRANSPORT_SERVICE_NOTIFICATION enumeration that specifies the type of service notification
    ///                          to be sent.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT NotifyWdsTransportServices(WDSTRANSPORT_SERVICE_NOTIFICATION ServiceNotification);
}

///This interface inherits from the IWdsTransportConfigurationManager interface and extends it with configuration
///settings, such as multicast session policy, that are available beginning with Windows Server 2008 R2. A client
///application can obtain an interface pointer to an instance of the <b>IWdsTransportConfigurationManager2</b> interface
///by first getting an interface pointer to the IWdsTransportConfigurationManager interface and then using the
///IUnknown::QueryInterface Method.
@GUID("D0D85CAF-A153-4F1D-A9DD-96F431C50717")
interface IWdsTransportConfigurationManager2 : IWdsTransportConfigurationManager
{
    ///Receives an interface pointer to the Configuration Manager’s Multicast Session Policy object. This object can
    ///be used to configure multicast session parameters that are available beginning with Windows Server 2008 R2. This
    ///property is read-only.
    HRESULT get_MulticastSessionPolicy(IWdsTransportMulticastSessionPolicy* ppWdsTransportMulticastSessionPolicy);
}

///Manages namespaces on a WDS transport server.
@GUID("3E22D9F6-3777-4D98-83E1-F98696717BA3")
interface IWdsTransportNamespaceManager : IDispatch
{
    ///Creates an object of an IWdsTransportNamespace interface that can be registered on the current WDS transport
    ///server.
    ///Params:
    ///    NamespaceType = The type of the new namespace object. This can be one of the namespace types listed by the
    ///                    WDSTRANSPORT_NAMESPACE_TYPE enumeration.
    ///    bszNamespaceName = The name of the new namespace object. If an application attempts to register this namespace with a WDS
    ///                       transport server, WDS confirms that the name is unique.
    ///    bszContentProvider = The name of the content provider to be associated with the new namespace object.
    ///    bszConfiguration = The configuration information used by the content provider. The format of this information is defined by the
    ///                       content provider. The value can be an empty string if no parameter is required.
    ///    ppWdsTransportNamespace = A pointer to the object of an IWdsTransportNamespace interface created by this method.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT CreateNamespace(WDSTRANSPORT_NAMESPACE_TYPE NamespaceType, BSTR bszNamespaceName, 
                            BSTR bszContentProvider, BSTR bszConfiguration, 
                            IWdsTransportNamespace* ppWdsTransportNamespace);
    ///Retrieves, by name, an object of an IWdsTransportNamespace interface. The name should be registered with the
    ///namespace on the WDS transport server.
    ///Params:
    ///    bszNamespaceName = The name of the namespace for which an object is being returned. The namespace should be registered with the
    ///                       WDS transport server.
    ///    ppWdsTransportNamespace = A pointer to the object of an IWdsTransportNamespace interface that matches the specified name.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RetrieveNamespace(BSTR bszNamespaceName, IWdsTransportNamespace* ppWdsTransportNamespace);
    ///Returns a collection of objects of the IWdsTransportNamespace interface that represent namespaces on the server
    ///that match specified criteria.
    ///Params:
    ///    bszContentProvider = The name of the content provider for which namespaces are to be returned. If an empty string is specified,
    ///                         the method returns the namespaces for all content providers.
    ///    bszNamespaceName = The name of the namespace for which instances are to be returned. If an empty string is specified, the method
    ///                       returns all namespaces for the selected content providers.
    ///    bIncludeTombstones = A value of true specifies that the method should include in the results any namespaces that have been
    ///                         deregistered while still having active sessions on the server. This enables an application to register
    ///                         another namespace with the name.
    ///    ppWdsTransportNamespaces = A pointer to the object of an IWdsTransportCollection interface. This represents a collection of objects of
    ///                               an IWdsTransportNamespace interface that match the specified criteria.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RetrieveNamespaces(BSTR bszContentProvider, BSTR bszNamespaceName, short bIncludeTombstones, 
                               IWdsTransportCollection* ppWdsTransportNamespaces);
}

///This interface provides a method to retrieve all the clients currently connected to the TFTP server.
@GUID("1327A7C8-AE8A-4FB3-8150-136227C37E9A")
interface IWdsTransportTftpManager : IDispatch
{
    ///Returns a pointer to the object of an IWdsTransportCollection interface containing a collection of objects of the
    ///IWdsTransportTftpClient interface for the clients currently connected to the TFTP server.
    ///Params:
    ///    ppWdsTransportTftpClients = A pointer to a pointer to an object of the IWdsTransportCollection interface.
    HRESULT RetrieveTftpClients(IWdsTransportCollection* ppWdsTransportTftpClients);
}

///Represents the service policy part of the WDS transport server's configuration.
@GUID("B9468578-9F2B-48CC-B27A-A60799C2750C")
interface IWdsTransportServicePolicy : IWdsTransportCacheable
{
    ///Enables a WDS client computer to configure, for a specified type of IP address, the IP address source from which
    ///the WDS transport server obtains a multicast address. This property is read/write.
    HRESULT get_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE* pSourceType);
    ///Enables a WDS client computer to configure, for a specified type of IP address, the IP address source from which
    ///the WDS transport server obtains a multicast address. This property is read/write.
    HRESULT put_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE SourceType);
    ///Enables a WDS client computer to configure the start of a multicast IP address range for a specified type of IP
    ///address. This property is read/write.
    HRESULT get_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszStartIpAddress);
    ///Enables a WDS client computer to configure the start of a multicast IP address range for a specified type of IP
    ///address. This property is read/write.
    HRESULT put_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszStartIpAddress);
    ///Enables a WDS client computer to configure the end of a multicast IP address range for a specified type of IP
    ///address. This property is read/write.
    HRESULT get_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszEndIpAddress);
    ///Enables a WDS client computer to configure the end of a multicast IP address range for a specified type of IP
    ///address. This property is read/write.
    HRESULT put_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszEndIpAddress);
    ///Enables a WDS client computer to configure the start of a UDP port range that is used by WDS transport services.
    ///This property is read/write.
    HRESULT get_StartPort(uint* pulStartPort);
    ///Enables a WDS client computer to configure the start of a UDP port range that is used by WDS transport services.
    ///This property is read/write.
    HRESULT put_StartPort(uint ulStartPort);
    ///Enables a WDS client computer to configure the end of a UDP port range that is used by WDS transport services.
    ///This property is read/write.
    HRESULT get_EndPort(uint* pulEndPort);
    ///Enables a WDS client computer to configure the end of a UDP port range that is used by WDS transport services.
    ///This property is read/write.
    HRESULT put_EndPort(uint ulEndPort);
    ///Enables a client computer to configure the network profile that is used by the WDS Transport Server. <b>Windows
    ///Server 2008 R2: </b>This property is ignored and has no effect. This property is ignored and has no effect. A WDS
    ///Transport Server on Windows Server 2008 R2 automatically uses the optimal network profile. This property is
    ///read/write.
    HRESULT get_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE* pProfileType);
    ///Enables a client computer to configure the network profile that is used by the WDS Transport Server. <b>Windows
    ///Server 2008 R2: </b>This property is ignored and has no effect. This property is ignored and has no effect. A WDS
    ///Transport Server on Windows Server 2008 R2 automatically uses the optimal network profile. This property is
    ///read/write.
    HRESULT put_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE ProfileType);
}

///This interface inherits from the IWdsTransportServicePolicy interface and extends it beginning with Windows Server
///2012. A client application can obtain an interface pointer to an instance of the <b>IWdsTransportServicePolicy2</b>
///interface by first getting an interface pointer to the IWdsTransportServicePolicy interface and then using the
///IUnknown::QueryInterface Method.
@GUID("65C19E5C-AA7E-4B91-8944-91E0E5572797")
interface IWdsTransportServicePolicy2 : IWdsTransportServicePolicy
{
    ///Recieves the WDSTRANSPORT_UDP_PORT_POLICY value that specifies the UDP port allocation policy to be used by WDS
    ///transport services. The value enables a WDS client computer to configure the UDP port allocation policy. This
    ///property is read/write.
    HRESULT get_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY* pUdpPortPolicy);
    ///Recieves the WDSTRANSPORT_UDP_PORT_POLICY value that specifies the UDP port allocation policy to be used by WDS
    ///transport services. The value enables a WDS client computer to configure the UDP port allocation policy. This
    ///property is read/write.
    HRESULT put_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY UdpPortPolicy);
    ///Receives a value for the maximum block size used by the TFTP server. The value enables a WDS client computer to
    ///configure the maximum block size. This property is read/write.
    HRESULT get_TftpMaximumBlockSize(uint* pulTftpMaximumBlockSize);
    ///Receives a value for the maximum block size used by the TFTP server. The value enables a WDS client computer to
    ///configure the maximum block size. This property is read/write.
    HRESULT put_TftpMaximumBlockSize(uint ulTftpMaximumBlockSize);
    ///Receives a WDSTRANSPORT_TFTP_CAPABILITY value that specifies whether variable-window extension is enabled on the
    ///TFTP server. The value enables a WDS client computer to configure the WDS TFTP server to use variable-window
    ///extensions. This property is read/write.
    HRESULT get_EnableTftpVariableWindowExtension(short* pbEnableTftpVariableWindowExtension);
    ///Receives a WDSTRANSPORT_TFTP_CAPABILITY value that specifies whether variable-window extension is enabled on the
    ///TFTP server. The value enables a WDS client computer to configure the WDS TFTP server to use variable-window
    ///extensions. This property is read/write.
    HRESULT put_EnableTftpVariableWindowExtension(short bEnableTftpVariableWindowExtension);
}

///Represents the diagnostics policy part of the WDS transport server's configuration.
@GUID("13B33EFC-7856-4F61-9A59-8DE67B6B87B6")
interface IWdsTransportDiagnosticsPolicy : IWdsTransportCacheable
{
    ///Receives or sets a value that enables a WDS client to configure diagnostic logging on the server. This property
    ///is read/write.
    HRESULT get_Enabled(short* pbEnabled);
    ///Receives or sets a value that enables a WDS client to configure diagnostic logging on the server. This property
    ///is read/write.
    HRESULT put_Enabled(short bEnabled);
    ///Enables a WDS client to configure which WDS transport components have event logging. This property is read/write.
    HRESULT get_Components(uint* pulComponents);
    ///Enables a WDS client to configure which WDS transport components have event logging. This property is read/write.
    HRESULT put_Components(uint ulComponents);
}

///This interface represents the multicast session policy portion of a WDS Transport server’s configuration. For
///example, a client can use this interface to configure the multicast session parameters that specify the method for
///handling a slow client and the threshold for automatic disconnection.
@GUID("4E5753CF-68EC-4504-A951-4A003266606B")
interface IWdsTransportMulticastSessionPolicy : IWdsTransportCacheable
{
    ///Sets or retrieves a WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE value that indicates the method used by the server to
    ///handle clients that are slowing down a multicast transmission. This property is read/write.
    HRESULT get_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE* pSlowClientHandling);
    ///Sets or retrieves a WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE value that indicates the method used by the server to
    ///handle clients that are slowing down a multicast transmission. This property is read/write.
    HRESULT put_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE SlowClientHandling);
    ///Sets or retrieves the threshold transmission rate, in kilobytes per second, used by the server. If the server has
    ///been configured to handle slow clients using the auto-disconnect method, the server disconnects clients that slow
    ///the transmission rate below this threshold value. This property can be used to get or set the value of the
    ///threshold transmission rate regardless of which method the server is using to handle slow clients. This property
    ///is read/write.
    HRESULT get_AutoDisconnectThreshold(uint* pulThreshold);
    ///Sets or retrieves the threshold transmission rate, in kilobytes per second, used by the server. If the server has
    ///been configured to handle slow clients using the auto-disconnect method, the server disconnects clients that slow
    ///the transmission rate below this threshold value. This property can be used to get or set the value of the
    ///threshold transmission rate regardless of which method the server is using to handle slow clients. This property
    ///is read/write.
    HRESULT put_AutoDisconnectThreshold(uint ulThreshold);
    ///Receives the maximum number of multicast streams per transmission used by the server. If the server is configured
    ///to handle slow clients using the multistream method, the server detects clients that slow transmission below this
    ///maximum and moves them to lower-speed streams of the same multicast transmission. The server cannot move legacy
    ///clients that do not support the multistream handling option, and in this case, the server disconnects the client
    ///or instructs the client to fallback depending upon the SlowClientFallback property. This property can be used to
    ///get or set the maximum stream count regardless of which method the server is using to handle slow clients. This
    ///property is read/write.
    HRESULT get_MultistreamStreamCount(uint* pulStreamCount);
    ///Receives the maximum number of multicast streams per transmission used by the server. If the server is configured
    ///to handle slow clients using the multistream method, the server detects clients that slow transmission below this
    ///maximum and moves them to lower-speed streams of the same multicast transmission. The server cannot move legacy
    ///clients that do not support the multistream handling option, and in this case, the server disconnects the client
    ///or instructs the client to fallback depending upon the SlowClientFallback property. This property can be used to
    ///get or set the maximum stream count regardless of which method the server is using to handle slow clients. This
    ///property is read/write.
    HRESULT put_MultistreamStreamCount(uint ulStreamCount);
    ///Receives a value that indicates the fallback policy requested by the server when automatically disconnecting slow
    ///clients from a multicast transmission. A value of <b>VARIANT_FALSE</b> requests that the client disconnect from
    ///the server and discontinue any further attempts to get the content from this server. A value of
    ///<b>VARIANT_TRUE</b> requests that the client use any alternative method available to the client to get the
    ///content, for example unicasting. This property can be used to get or set the fallback policy regardless of which
    ///method the server is using to handle slow clients. This policy is only used when the server is automatically
    ///disconnecting a slow client from a multicast transmission. An administrator manually disconnecting a client, can
    ///specify the fallback method. This property is read/write.
    HRESULT get_SlowClientFallback(short* pbClientFallback);
    ///Receives a value that indicates the fallback policy requested by the server when automatically disconnecting slow
    ///clients from a multicast transmission. A value of <b>VARIANT_FALSE</b> requests that the client disconnect from
    ///the server and discontinue any further attempts to get the content from this server. A value of
    ///<b>VARIANT_TRUE</b> requests that the client use any alternative method available to the client to get the
    ///content, for example unicasting. This property can be used to get or set the fallback policy regardless of which
    ///method the server is using to handle slow clients. This policy is only used when the server is automatically
    ///disconnecting a slow client from a multicast transmission. An administrator manually disconnecting a client, can
    ///specify the fallback method. This property is read/write.
    HRESULT put_SlowClientFallback(short bClientFallback);
}

///Represents a namespace on a WDS transport server.
@GUID("FA561F57-FBEF-4ED3-B056-127CB1B33B84")
interface IWdsTransportNamespace : IDispatch
{
    ///Enables an application to retrieve the type of the namespace for this object. This property is read-only.
    HRESULT get_Type(WDSTRANSPORT_NAMESPACE_TYPE* pType);
    ///Receives the unique namespace ID for a namespace that has been registered on the server. The WDS transport server
    ///assigns a unique ID to each namespace that has been registered on the server. This property is read-only.
    HRESULT get_Id(uint* pulId);
    ///Sets or retrieves the name of the namespace. This property is read/write.
    HRESULT get_Name(BSTR* pbszName);
    ///Sets or retrieves the name of the namespace. This property is read/write.
    HRESULT put_Name(BSTR bszName);
    ///Sets or retrieves the user-friendly name of the namespace. This property is read/write.
    HRESULT get_FriendlyName(BSTR* pbszFriendlyName);
    ///Sets or retrieves the user-friendly name of the namespace. This property is read/write.
    HRESULT put_FriendlyName(BSTR bszFriendlyName);
    ///Sets or retrieves the description of the namespace. This property is read/write.
    HRESULT get_Description(BSTR* pbszDescription);
    ///Sets or retrieves the description of the namespace. This property is read/write.
    HRESULT put_Description(BSTR bszDescription);
    ///Sets or retrieves the content provider for the namespace. This property is read/write.
    HRESULT get_ContentProvider(BSTR* pbszContentProvider);
    ///Sets or retrieves the content provider for the namespace. This property is read/write.
    HRESULT put_ContentProvider(BSTR bszContentProvider);
    ///Sets or retrieves the configuration information for the content provider of the namespace. This property is
    ///read/write.
    HRESULT get_Configuration(BSTR* pbszConfiguration);
    ///Sets or retrieves the configuration information for the content provider of the namespace. This property is
    ///read/write.
    HRESULT put_Configuration(BSTR bszConfiguration);
    ///Returns a value that indicates whether the namespace is registered on the server. This property is read-only.
    HRESULT get_Registered(short* pbRegistered);
    ///Returns a value that indicates whether the server has saved the namespace object of a deregistered namespace in
    ///memory until all active sessions are completed or terminated. This property is read-only.
    HRESULT get_Tombstoned(short* pbTombstoned);
    ///Returns the UTC date and time when the server saved the namespace object of a deregistered namespace. This
    ///property is read-only.
    HRESULT get_TombstoneTime(double* pTombstoneTime);
    ///Receives a value that indicates whether the server has started transmitting data under this namespace. This
    ///property is read-only.
    HRESULT get_TransmissionStarted(short* pbTransmissionStarted);
    ///Registers the namespace on the server.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Register();
    ///Deregisters the namespace on the server.
    ///Params:
    ///    bTerminateSessions = A boolean value indicating if sessions should be terminated.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Deregister(short bTerminateSessions);
    ///Copies the information from this namespace object into a new, unregistered namespace object in memory.
    ///Params:
    ///    ppWdsTransportNamespaceClone = An interface pointer to a new, unregistered copy of this namespace.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Clone(IWdsTransportNamespace* ppWdsTransportNamespaceClone);
    ///Resets the property values of the namespace with values from the server.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Refresh();
    ///Retrieves a collection of active transport content objects associated with the namespace.
    ///Params:
    ///    ppWdsTransportContents = A pointer to a IWdsTransportCollection object that contains a collection of IWdsTransportContent objects that
    ///                             represent active sessions under this namespace.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RetrieveContents(IWdsTransportCollection* ppWdsTransportContents);
}

///The WDS transport server can create, start, and end multicast sessions that are hosted by a namespace object of this
///interface. This type of namespace is represented by the <b>WdsTptNamespaceTypeAutoCast</b> value of the
///WDSTRANSPORT_NAMESPACE_TYPE enumeration.
@GUID("AD931A72-C4BD-4C41-8FBC-59C9C748DF9E")
interface IWdsTransportNamespaceAutoCast : IWdsTransportNamespace
{
}

///Represents a base interface to the derived interfaces: IWdsTransportNamespaceScheduledCastManualStart and
///IWdsTransportNamespaceScheduledCastAutoStart. An administrator must start multicast sessions that are hosted by a
///namespace object of these derived interfaces.
@GUID("3840CECF-D76C-416E-A4CC-31C741D2874B")
interface IWdsTransportNamespaceScheduledCast : IWdsTransportNamespace
{
    ///Starts a transmission on a namespace.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT StartTransmission();
}

///An administrator must start transmission on an object of an <b>IWdsTransportNamespaceScheduledCastManualStart</b>
///interface. Applications can continue to join sessions of the namespace until the administrator starts transmission.
///This type of namespace is represented by the <b>WdsTptNamespaceTypeScheduledCastManualStart</b> value of the
///WDSTRANSPORT_NAMESPACE_TYPE enumeration.
@GUID("013E6E4C-E6A7-4FB5-B7FF-D9F5DA805C31")
interface IWdsTransportNamespaceScheduledCastManualStart : IWdsTransportNamespaceScheduledCast
{
}

///An administrator can specify criteria that starts transmission on an object of an
///<b>IWdsTransportNamespaceScheduledCastAutoStart</b> interface automatically. Applications can continue to join
///sessions of the namespace object until these criteria are reached. This type of namespace is represented by the
///<b>WdsTptNamespaceTypeScheduledCastAutoStart</b> value of the WDSTRANSPORT_NAMESPACE_TYPE enumeration.
@GUID("D606AF3D-EA9C-4219-961E-7491D618D9B9")
interface IWdsTransportNamespaceScheduledCastAutoStart : IWdsTransportNamespaceScheduledCast
{
    ///Retrieves or sets a condition that starts transmission automatically. Transmission starts if the number of
    ///applications that have joined sessions reaches the value of this property. This property is read/write.
    HRESULT get_MinimumClients(uint* pulMinimumClients);
    ///Retrieves or sets a condition that starts transmission automatically. Transmission starts if the number of
    ///applications that have joined sessions reaches the value of this property. This property is read/write.
    HRESULT put_MinimumClients(uint ulMinimumClients);
    ///Retrieves or sets a condition that starts transmission automatically. Transmission starts when the UTC time
    ///reaches the value of this property. This property is read/write.
    HRESULT get_StartTime(double* pStartTime);
    ///Retrieves or sets a condition that starts transmission automatically. Transmission starts when the UTC time
    ///reaches the value of this property. This property is read/write.
    HRESULT put_StartTime(double StartTime);
}

///Represents content being transmitted under a namespace over one or more sessions.
@GUID("D405D711-0296-4AB4-A860-AC7D32E65798")
interface IWdsTransportContent : IDispatch
{
    ///Receives a pointer to an object of an IWdsTransportNamespace interface that represents the namespace associated
    ///with this content. This property is read-only.
    HRESULT get_Namespace(IWdsTransportNamespace* ppWdsTransportNamespace);
    ///Receives a unique content ID that identifies this content object on the server. The WDS transport server assigns
    ///a unique ID to each content object that is being transmitted by the server. This property is read-only.
    HRESULT get_Id(uint* pulId);
    ///Receives a pointer to a string value that contains the name of the data object represented by this content
    ///object. This property is read-only.
    HRESULT get_Name(BSTR* pbszName);
    ///Retrieves a collection of active transport sessions associated with this content.
    ///Params:
    ///    ppWdsTransportSessions = A pointer to a collection of objects of the IWdsTransportSession interface that represent active sessions
    ///                             under this content.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RetrieveSessions(IWdsTransportCollection* ppWdsTransportSessions);
    ///Terminates the transmission of this content by terminating all active sessions under the content and
    ///disconnecting any clients that are joined to them.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Terminate();
}

///Represents an active transport session on the WDS transport server.
@GUID("F4EFEA88-65B1-4F30-A4B9-2793987796FB")
interface IWdsTransportSession : IDispatch
{
    ///Receives a pointer to an object of the IWdsTransportContent interface that represents an active transport session
    ///on the WDS transport server. This property is read-only.
    HRESULT get_Content(IWdsTransportContent* ppWdsTransportContent);
    ///Receives a unique session ID that identifies this session on the server. The WDS transport server assigns a
    ///unique ID to each session that transmits information on the server. This property is read-only.
    HRESULT get_Id(uint* pulId);
    ///Receives the name of the server network interface used by this transport session. This property is read-only.
    HRESULT get_NetworkInterfaceName(BSTR* pbszNetworkInterfaceName);
    ///Receives the MAC address of the server network interface used by this transport session. This property is
    ///read-only.
    HRESULT get_NetworkInterfaceAddress(BSTR* pbszNetworkInterfaceAddress);
    ///Receives the data transfer rate for this session in bytes per second. This property is read-only.
    HRESULT get_TransferRate(uint* pulTransferRate);
    ///Receives a unique client ID assigned by the WDS server that identifies the master client for this session. This
    ///property is read-only.
    HRESULT get_MasterClientId(uint* pulMasterClientId);
    ///Retrieves a collection of WDS clients joined to the transport session.
    ///Params:
    ///    ppWdsTransportClients = A collection of objects of the IWdsTransportClient interface joined to the transport session.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT RetrieveClients(IWdsTransportCollection* ppWdsTransportClients);
    ///Terminates an active session on the WDS transport server and disconnects all WDS clients joined to the session.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Terminate();
}

///Represents a WDS client that is joined to a transport session on a WDS transport server.
@GUID("B5DBC93A-CABE-46CA-837F-3E44E93C6545")
interface IWdsTransportClient : IDispatch
{
    ///Receives the transport session to which the WDS client is joined. This property is read-only.
    HRESULT get_Session(IWdsTransportSession* ppWdsTransportSession);
    ///Receives a unique client ID that identifies this WDS client on the WDS server. This property is read-only.
    HRESULT get_Id(uint* pulId);
    ///Receives the name of the WDS client on the WDS server. This property is read-only.
    HRESULT get_Name(BSTR* pbszName);
    ///Receives the MAC address of the WDS client. This property is read-only.
    HRESULT get_MacAddress(BSTR* pbszMacAddress);
    ///Receives a string value that contains the IP address of the WDS client. This property is read-only.
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    ///Receives the percentage of the current object that has been downloaded. This property is read-only.
    HRESULT get_PercentCompletion(uint* pulPercentCompletion);
    ///Receives the time elapsed, in seconds, since the WDS client joined to the transport session. This property is
    ///read-only.
    HRESULT get_JoinDuration(uint* pulJoinDuration);
    ///Receives the percentage of the WDS client’s CPU utilization. This property is read-only.
    HRESULT get_CpuUtilization(uint* pulCpuUtilization);
    ///Receives the percentage of the WDS client’s memory in use. This property is read-only.
    HRESULT get_MemoryUtilization(uint* pulMemoryUtilization);
    ///Receives the percentage of the WDS client’s network bandwidth used. This property is read-only.
    HRESULT get_NetworkUtilization(uint* pulNetworkUtilization);
    ///Receives a string representing the user identity associated with this client. This property is read-only.
    HRESULT get_UserIdentity(BSTR* pbszUserIdentity);
    ///Disconnects the WDS client from the session and specifies what action the client should take upon disconnection.
    ///Params:
    ///    DisconnectionType = A value of the WDSTRANSPORT_DISCONNECT_TYPE enumeration that specifies what action the WDS client should take
    ///                        when disconnected.
    ///Returns:
    ///    Standard HRESULT error values are used: S_OK for success; others for failure.
    ///    
    HRESULT Disconnect(WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

///This interface is used to specify information of a TFTP client session currently active in the server.
@GUID("B022D3AE-884D-4D85-B146-53320E76EF62")
interface IWdsTransportTftpClient : IDispatch
{
    ///Retrieves the name of the file being transferred in the TFTP session. This property is read-only.
    HRESULT get_FileName(BSTR* pbszFileName);
    ///Receives a string value containing the client’s IP address. This property is read-only.
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    ///Receives the timeout in seconds used to communicate with the client. This property is read-only.
    HRESULT get_Timeout(uint* pulTimeout);
    ///Receives the offset from the start of the file in bytes of the current block being transferred in the TFTP
    ///session. This property is read-only.
    HRESULT get_CurrentFileOffset(ulong* pul64CurrentOffset);
    ///Receives the size in bytes of the file being transferred. This property is read-only.
    HRESULT get_FileSize(ulong* pul64FileSize);
    ///Retrieves the block size used in the TFTP session. This property is read-only.
    HRESULT get_BlockSize(uint* pulBlockSize);
    ///Receives the current window size being used in the TFTP session. The window size used during a TFTP session can
    ///be updated by the client through ACK packets when using the variable-window TFTP extension. This property is
    ///read-only.
    HRESULT get_WindowSize(uint* pulWindowSize);
}

///Used to describe a content provider.
@GUID("B9489F24-F219-4ACF-AAD7-265C7C08A6AE")
interface IWdsTransportContentProvider : IDispatch
{
    ///Retrieves the name of the content provider. This property is read-only.
    HRESULT get_Name(BSTR* pbszName);
    ///Retrieves the description of the content provider. This property is read-only.
    HRESULT get_Description(BSTR* pbszDescription);
    ///Retrieves the path to the content provider’s DLL. This property is read-only.
    HRESULT get_FilePath(BSTR* pbszFilePath);
    ///Retrieves the name of the method called to initialize the content provider. This property is read-only.
    HRESULT get_InitializationRoutine(BSTR* pbszInitializationRoutine);
}


// GUIDs

const GUID CLSID_WdsTransportCacheable                         = GUIDOF!WdsTransportCacheable;
const GUID CLSID_WdsTransportClient                            = GUIDOF!WdsTransportClient;
const GUID CLSID_WdsTransportCollection                        = GUIDOF!WdsTransportCollection;
const GUID CLSID_WdsTransportConfigurationManager              = GUIDOF!WdsTransportConfigurationManager;
const GUID CLSID_WdsTransportContent                           = GUIDOF!WdsTransportContent;
const GUID CLSID_WdsTransportContentProvider                   = GUIDOF!WdsTransportContentProvider;
const GUID CLSID_WdsTransportDiagnosticsPolicy                 = GUIDOF!WdsTransportDiagnosticsPolicy;
const GUID CLSID_WdsTransportManager                           = GUIDOF!WdsTransportManager;
const GUID CLSID_WdsTransportMulticastSessionPolicy            = GUIDOF!WdsTransportMulticastSessionPolicy;
const GUID CLSID_WdsTransportNamespace                         = GUIDOF!WdsTransportNamespace;
const GUID CLSID_WdsTransportNamespaceAutoCast                 = GUIDOF!WdsTransportNamespaceAutoCast;
const GUID CLSID_WdsTransportNamespaceManager                  = GUIDOF!WdsTransportNamespaceManager;
const GUID CLSID_WdsTransportNamespaceScheduledCast            = GUIDOF!WdsTransportNamespaceScheduledCast;
const GUID CLSID_WdsTransportNamespaceScheduledCastAutoStart   = GUIDOF!WdsTransportNamespaceScheduledCastAutoStart;
const GUID CLSID_WdsTransportNamespaceScheduledCastManualStart = GUIDOF!WdsTransportNamespaceScheduledCastManualStart;
const GUID CLSID_WdsTransportServer                            = GUIDOF!WdsTransportServer;
const GUID CLSID_WdsTransportServicePolicy                     = GUIDOF!WdsTransportServicePolicy;
const GUID CLSID_WdsTransportSession                           = GUIDOF!WdsTransportSession;
const GUID CLSID_WdsTransportSetupManager                      = GUIDOF!WdsTransportSetupManager;
const GUID CLSID_WdsTransportTftpClient                        = GUIDOF!WdsTransportTftpClient;
const GUID CLSID_WdsTransportTftpManager                       = GUIDOF!WdsTransportTftpManager;

const GUID IID_IWdsTransportCacheable                         = GUIDOF!IWdsTransportCacheable;
const GUID IID_IWdsTransportClient                            = GUIDOF!IWdsTransportClient;
const GUID IID_IWdsTransportCollection                        = GUIDOF!IWdsTransportCollection;
const GUID IID_IWdsTransportConfigurationManager              = GUIDOF!IWdsTransportConfigurationManager;
const GUID IID_IWdsTransportConfigurationManager2             = GUIDOF!IWdsTransportConfigurationManager2;
const GUID IID_IWdsTransportContent                           = GUIDOF!IWdsTransportContent;
const GUID IID_IWdsTransportContentProvider                   = GUIDOF!IWdsTransportContentProvider;
const GUID IID_IWdsTransportDiagnosticsPolicy                 = GUIDOF!IWdsTransportDiagnosticsPolicy;
const GUID IID_IWdsTransportManager                           = GUIDOF!IWdsTransportManager;
const GUID IID_IWdsTransportMulticastSessionPolicy            = GUIDOF!IWdsTransportMulticastSessionPolicy;
const GUID IID_IWdsTransportNamespace                         = GUIDOF!IWdsTransportNamespace;
const GUID IID_IWdsTransportNamespaceAutoCast                 = GUIDOF!IWdsTransportNamespaceAutoCast;
const GUID IID_IWdsTransportNamespaceManager                  = GUIDOF!IWdsTransportNamespaceManager;
const GUID IID_IWdsTransportNamespaceScheduledCast            = GUIDOF!IWdsTransportNamespaceScheduledCast;
const GUID IID_IWdsTransportNamespaceScheduledCastAutoStart   = GUIDOF!IWdsTransportNamespaceScheduledCastAutoStart;
const GUID IID_IWdsTransportNamespaceScheduledCastManualStart = GUIDOF!IWdsTransportNamespaceScheduledCastManualStart;
const GUID IID_IWdsTransportServer                            = GUIDOF!IWdsTransportServer;
const GUID IID_IWdsTransportServer2                           = GUIDOF!IWdsTransportServer2;
const GUID IID_IWdsTransportServicePolicy                     = GUIDOF!IWdsTransportServicePolicy;
const GUID IID_IWdsTransportServicePolicy2                    = GUIDOF!IWdsTransportServicePolicy2;
const GUID IID_IWdsTransportSession                           = GUIDOF!IWdsTransportSession;
const GUID IID_IWdsTransportSetupManager                      = GUIDOF!IWdsTransportSetupManager;
const GUID IID_IWdsTransportSetupManager2                     = GUIDOF!IWdsTransportSetupManager2;
const GUID IID_IWdsTransportTftpClient                        = GUIDOF!IWdsTransportTftpClient;
const GUID IID_IWdsTransportTftpManager                       = GUIDOF!IWdsTransportTftpManager;
