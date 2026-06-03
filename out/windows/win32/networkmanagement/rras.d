// Written in the D programming language.

module windows.win32.networkmanagement.rras;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, FILETIME, HANDLE, HINSTANCE,
                                         HWND, LUID, PSTR, PWSTR;
public import windows.win32.networkmanagement.iphelper : MIB_IPMCAST_MFE;
public import windows.win32.networking.winsock : IN6_ADDR, IN_ADDR;
public import windows.win32.security.cryptography : CRYPT_INTEGER_BLOB;

extern(Windows) @nogc nothrow:


// Enums


alias MPR_INTERFACE_DIAL_MODE = uint;
enum : uint
{
    MPRDM_DialFirst    = 0x00000000U,
    MPRDM_DialAll      = 0x00000001U,
    MPRDM_DialAsNeeded = 0x00000002U,
}

alias RASENTRY_DIAL_MODE = uint;
enum : uint
{
    RASEDM_DialAll      = 0x00000001U,
    RASEDM_DialAsNeeded = 0x00000002U,
}

alias RAS_FLAGS = uint;
enum : uint
{
    RAS_FLAGS_PPP_CONNECTION     = 0x00000001U,
    RAS_FLAGS_MESSENGER_PRESENT  = 0x00000002U,
    RAS_FLAGS_QUARANTINE_PRESENT = 0x00000008U,
    RAS_FLAGS_ARAP_CONNECTION    = 0x00000010U,
    RAS_FLAGS_IKEV2_CONNECTION   = 0x00000010U,
    RAS_FLAGS_DORMANT            = 0x00000020U,
}

alias MPR_ET = uint;
enum : uint
{
    MPR_ET_None       = 0x00000000U,
    MPR_ET_Require    = 0x00000001U,
    MPR_ET_RequireMax = 0x00000002U,
    MPR_ET_Optional   = 0x00000003U,
}

alias RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA = uint;
enum : uint
{
    RASLCPAD_CHAP_MD5  = 0x00000005U,
    RASLCPAD_CHAP_MS   = 0x00000080U,
    RASLCPAD_CHAP_MSV2 = 0x00000081U,
}

alias PPP_LCP = uint;
enum : uint
{
    PPP_LCP_PAP  = 0x0000c023U,
    PPP_LCP_CHAP = 0x0000c223U,
    PPP_LCP_EAP  = 0x0000c227U,
    PPP_LCP_SPAP = 0x0000c027U,
}

alias RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL = uint;
enum : uint
{
    RASLCPAP_PAP  = 0x0000c023U,
    RASLCPAP_SPAP = 0x0000c027U,
    RASLCPAP_CHAP = 0x0000c223U,
    RASLCPAP_EAP  = 0x0000c227U,
}

alias PPP_LCP_INFO_AUTH_DATA = uint;
enum : uint
{
    PPP_LCP_CHAP_MD5  = 0x00000005U,
    PPP_LCP_CHAP_MS   = 0x00000080U,
    PPP_LCP_CHAP_MSV2 = 0x00000081U,
}

alias RASIKEV_PROJECTION_INFO_FLAGS = uint;
enum : uint
{
    RASIKEv2_FLAGS_MOBIKESUPPORTED  = 0x00000001U,
    RASIKEv2_FLAGS_BEHIND_NAT       = 0x00000002U,
    RASIKEv2_FLAGS_SERVERBEHIND_NAT = 0x00000004U,
}

alias MPR_VS = uint;
enum : uint
{
    MPR_VS_Default   = 0x00000000U,
    MPR_VS_PptpOnly  = 0x00000001U,
    MPR_VS_PptpFirst = 0x00000002U,
    MPR_VS_L2tpOnly  = 0x00000003U,
    MPR_VS_L2tpFirst = 0x00000004U,
}

alias SECURITY_MESSAGE_MSG_ID = uint;
enum : uint
{
    SECURITYMSG_SUCCESS = 0x00000001U,
    SECURITYMSG_FAILURE = 0x00000002U,
    SECURITYMSG_ERROR   = 0x00000003U,
}

alias RASAPIVERSION = int;
enum : int
{
    RASAPIVERSION_500 = 0x00000001,
    RASAPIVERSION_501 = 0x00000002,
    RASAPIVERSION_600 = 0x00000003,
    RASAPIVERSION_601 = 0x00000004,
}

alias RASCONNSTATE = int;
enum : int
{
    RASCS_OpenPort             = 0x00000000,
    RASCS_PortOpened           = 0x00000001,
    RASCS_ConnectDevice        = 0x00000002,
    RASCS_DeviceConnected      = 0x00000003,
    RASCS_AllDevicesConnected  = 0x00000004,
    RASCS_Authenticate         = 0x00000005,
    RASCS_AuthNotify           = 0x00000006,
    RASCS_AuthRetry            = 0x00000007,
    RASCS_AuthCallback         = 0x00000008,
    RASCS_AuthChangePassword   = 0x00000009,
    RASCS_AuthProject          = 0x0000000a,
    RASCS_AuthLinkSpeed        = 0x0000000b,
    RASCS_AuthAck              = 0x0000000c,
    RASCS_ReAuthenticate       = 0x0000000d,
    RASCS_Authenticated        = 0x0000000e,
    RASCS_PrepareForCallback   = 0x0000000f,
    RASCS_WaitForModemReset    = 0x00000010,
    RASCS_WaitForCallback      = 0x00000011,
    RASCS_Projected            = 0x00000012,
    RASCS_StartAuthentication  = 0x00000013,
    RASCS_CallbackComplete     = 0x00000014,
    RASCS_LogonNetwork         = 0x00000015,
    RASCS_SubEntryConnected    = 0x00000016,
    RASCS_SubEntryDisconnected = 0x00000017,
    RASCS_ApplySettings        = 0x00000018,
    RASCS_Interactive          = 0x00001000,
    RASCS_RetryAuthentication  = 0x00001001,
    RASCS_CallbackSetByCaller  = 0x00001002,
    RASCS_PasswordExpired      = 0x00001003,
    RASCS_InvokeEapUI          = 0x00001004,
    RASCS_Connected            = 0x00002000,
    RASCS_Disconnected         = 0x00002001,
}

alias RASCONNSUBSTATE = int;
enum : int
{
    RASCSS_None         = 0x00000000,
    RASCSS_Dormant      = 0x00000001,
    RASCSS_Reconnecting = 0x00000002,
    RASCSS_Reconnected  = 0x00002000,
}

alias RASPROJECTION = int;
enum : int
{
    RASP_Amb     = 0x00010000,
    RASP_PppNbf  = 0x0000803f,
    RASP_PppIpx  = 0x0000802b,
    RASP_PppIp   = 0x00008021,
    RASP_PppCcp  = 0x000080fd,
    RASP_PppLcp  = 0x0000c021,
    RASP_PppIpv6 = 0x00008057,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ne-ras-rasprojection_info_type
alias RASPROJECTION_INFO_TYPE = int;
enum : int
{
    PROJECTION_INFO_TYPE_PPP   = 0x00000001,
    PROJECTION_INFO_TYPE_IKEv2 = 0x00000002,
}

alias IKEV2_ID_PAYLOAD_TYPE = int;
enum : int
{
    IKEV2_ID_PAYLOAD_TYPE_INVALID      = 0x00000000,
    IKEV2_ID_PAYLOAD_TYPE_IPV4_ADDR    = 0x00000001,
    IKEV2_ID_PAYLOAD_TYPE_FQDN         = 0x00000002,
    IKEV2_ID_PAYLOAD_TYPE_RFC822_ADDR  = 0x00000003,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED1    = 0x00000004,
    IKEV2_ID_PAYLOAD_TYPE_ID_IPV6_ADDR = 0x00000005,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED2    = 0x00000006,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED3    = 0x00000007,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED4    = 0x00000008,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_DN  = 0x00000009,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_GN  = 0x0000000a,
    IKEV2_ID_PAYLOAD_TYPE_KEY_ID       = 0x0000000b,
    IKEV2_ID_PAYLOAD_TYPE_MAX          = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-router_interface_type
alias ROUTER_INTERFACE_TYPE = int;
enum : int
{
    ROUTER_IF_TYPE_CLIENT      = 0x00000000,
    ROUTER_IF_TYPE_HOME_ROUTER = 0x00000001,
    ROUTER_IF_TYPE_FULL_ROUTER = 0x00000002,
    ROUTER_IF_TYPE_DEDICATED   = 0x00000003,
    ROUTER_IF_TYPE_INTERNAL    = 0x00000004,
    ROUTER_IF_TYPE_LOOPBACK    = 0x00000005,
    ROUTER_IF_TYPE_TUNNEL1     = 0x00000006,
    ROUTER_IF_TYPE_DIALOUT     = 0x00000007,
    ROUTER_IF_TYPE_MAX         = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-router_connection_state
alias ROUTER_CONNECTION_STATE = int;
enum : int
{
    ROUTER_IF_STATE_UNREACHABLE  = 0x00000000,
    ROUTER_IF_STATE_DISCONNECTED = 0x00000001,
    ROUTER_IF_STATE_CONNECTING   = 0x00000002,
    ROUTER_IF_STATE_CONNECTED    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-ras_port_condition
alias RAS_PORT_CONDITION = int;
enum : int
{
    RAS_PORT_NON_OPERATIONAL = 0x00000000,
    RAS_PORT_DISCONNECTED    = 0x00000001,
    RAS_PORT_CALLING_BACK    = 0x00000002,
    RAS_PORT_LISTENING       = 0x00000003,
    RAS_PORT_AUTHENTICATING  = 0x00000004,
    RAS_PORT_AUTHENTICATED   = 0x00000005,
    RAS_PORT_INITIALIZING    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-ras_hardware_condition
alias RAS_HARDWARE_CONDITION = int;
enum : int
{
    RAS_HARDWARE_OPERATIONAL = 0x00000000,
    RAS_HARDWARE_FAILURE     = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-ras_quarantine_state
alias RAS_QUARANTINE_STATE = int;
enum : int
{
    RAS_QUAR_STATE_NORMAL      = 0x00000000,
    RAS_QUAR_STATE_QUARANTINE  = 0x00000001,
    RAS_QUAR_STATE_PROBATION   = 0x00000002,
    RAS_QUAR_STATE_NOT_CAPABLE = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ne-mprapi-mprapi_object_type
alias MPRAPI_OBJECT_TYPE = int;
enum : int
{
    MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT        = 0x00000001,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT            = 0x00000002,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT = 0x00000003,
    MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT       = 0x00000004,
    MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT     = 0x00000005,
    MPRAPI_OBJECT_TYPE_IF_CUSTOM_CONFIG_OBJECT      = 0x00000006,
}

alias MPR_VPN_TS_TYPE = int;
enum : int
{
    MPR_VPN_TS_IPv4_ADDR_RANGE = 0x00000007,
    MPR_VPN_TS_IPv6_ADDR_RANGE = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mgm/ne-mgm-mgm_enum_types
alias MGM_ENUM_TYPES = int;
enum : int
{
    ANY_SOURCE  = 0x00000000,
    ALL_SOURCES = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ne-rtmv2-rtm_event_type
alias RTM_EVENT_TYPE = int;
enum : int
{
    RTM_ENTITY_REGISTERED   = 0x00000000,
    RTM_ENTITY_DEREGISTERED = 0x00000001,
    RTM_ROUTE_EXPIRED       = 0x00000002,
    RTM_CHANGE_NOTIFICATION = 0x00000003,
}

// Constants


enum uint RASNAP_ProbationTime = 0x00000001U;

enum : uint
{
    RASTUNNELENDPOINT_UNKNOWN = 0x00000000U,
    RASTUNNELENDPOINT_IPv4    = 0x00000001U,
    RASTUNNELENDPOINT_IPv6    = 0x00000002U,
}

enum : uint
{
    RAS_MaxDeviceType  = 0x00000010U,
    RAS_MaxPhoneNumber = 0x00000080U,
}

enum : uint
{
    RAS_MaxIpAddress      = 0x0000000fU,
    RAS_MaxIpxAddress     = 0x00000015U,
    RAS_MaxEntryName      = 0x00000100U,
    RAS_MaxDeviceName     = 0x00000080U,
    RAS_MaxCallbackNumber = 0x00000080U,
}

enum : uint
{
    RAS_MaxAreaCode     = 0x0000000aU,
    RAS_MaxPadType      = 0x00000020U,
    RAS_MaxX25Address   = 0x000000c8U,
    RAS_MaxFacilities   = 0x000000c8U,
    RAS_MaxUserData     = 0x000000c8U,
    RAS_MaxReplyMessage = 0x00000400U,
}

enum uint RAS_MaxDnsSuffix = 0x00000100U;

enum : uint
{
    RASCF_AllUsers    = 0x00000001U,
    RASCF_GlobalCreds = 0x00000002U,
}

enum : uint
{
    RASCF_OwnerKnown = 0x00000004U,
    RASCF_OwnerMatch = 0x00000008U,
}

enum uint RAS_MaxIDSize = 0x00000100U;

enum : uint
{
    RASCS_PAUSED = 0x00001000U,
    RASCS_DONE   = 0x00002000U,
    RASCSS_DONE  = 0x00002000U,
}

enum uint RDEOPT_UsePrefixSuffix = 0x00000001U;
enum uint RDEOPT_PausedStates = 0x00000002U;
enum uint RDEOPT_IgnoreModemSpeaker = 0x00000004U;
enum uint RDEOPT_SetModemSpeaker = 0x00000008U;
enum uint RDEOPT_IgnoreSoftwareCompression = 0x00000010U;
enum uint RDEOPT_SetSoftwareCompression = 0x00000020U;

enum : uint
{
    RDEOPT_DisableConnectedUI = 0x00000040U,
    RDEOPT_DisableReconnectUI = 0x00000080U,
    RDEOPT_DisableReconnect   = 0x00000100U,
}

enum : uint
{
    RDEOPT_NoUser        = 0x00000200U,
    RDEOPT_PauseOnScript = 0x00000400U,
}

enum : uint
{
    RDEOPT_Router             = 0x00000800U,
    RDEOPT_CustomDial         = 0x00001000U,
    RDEOPT_UseCustomScripting = 0x00002000U,
}

enum uint RDEOPT_InvokeAutoTriggerCredentialUI = 0x00004000U;
enum uint RDEOPT_EapInfoCryptInCapable = 0x00008000U;

enum : uint
{
    REN_User     = 0x00000000U,
    REN_AllUsers = 0x00000001U,
}

enum uint RASIPO_VJ = 0x00000001U;

enum : uint
{
    RASLCPO_PFC         = 0x00000001U,
    RASLCPO_ACFC        = 0x00000002U,
    RASLCPO_SSHF        = 0x00000004U,
    RASLCPO_DES_56      = 0x00000008U,
    RASLCPO_3_DES       = 0x00000010U,
    RASLCPO_AES_128     = 0x00000020U,
    RASLCPO_AES_256     = 0x00000040U,
    RASLCPO_AES_192     = 0x00000080U,
    RASLCPO_GCM_AES_128 = 0x00000100U,
    RASLCPO_GCM_AES_192 = 0x00000200U,
    RASLCPO_GCM_AES_256 = 0x00000400U,
}

enum : uint
{
    RASCCPCA_MPPC            = 0x00000006U,
    RASCCPCA_STAC            = 0x00000005U,
    RASCCPO_Compression      = 0x00000001U,
    RASCCPO_HistoryLess      = 0x00000002U,
    RASCCPO_Encryption56bit  = 0x00000010U,
    RASCCPO_Encryption40bit  = 0x00000020U,
    RASCCPO_Encryption128bit = 0x00000040U,
}

enum : uint
{
    RASIKEv2_AUTH_MACHINECERTIFICATES = 0x00000001U,
    RASIKEv2_AUTH_EAP                 = 0x00000002U,
    RASIKEv2_AUTH_PSK                 = 0x00000003U,
}

// Native encoding: ansi
enum const(wchar)* RASDIALEVENT = "RasDialEvent";
// Microsoft documentation: https://learn.microsoft.com/windows/win32/RRAS/wm-rasdialevent
enum uint WM_RASDIALEVENT = 0x0000cccdU;

enum : uint
{
    ET_None       = 0x00000000U,
    ET_Require    = 0x00000001U,
    ET_RequireMax = 0x00000002U,
}

enum uint ET_Optional = 0x00000003U;
enum uint VS_Default = 0x00000000U;

enum : uint
{
    VS_PptpOnly  = 0x00000001U,
    VS_PptpFirst = 0x00000002U,
}

enum : uint
{
    VS_L2tpOnly  = 0x00000003U,
    VS_L2tpFirst = 0x00000004U,
}

enum : uint
{
    VS_SstpOnly  = 0x00000005U,
    VS_SstpFirst = 0x00000006U,
}

enum : uint
{
    VS_Ikev2Only  = 0x00000007U,
    VS_Ikev2First = 0x00000008U,
}

enum uint VS_GREOnly = 0x00000009U;
enum uint VS_PptpSstp = 0x0000000cU;
enum uint VS_L2tpSstp = 0x0000000dU;
enum uint VS_Ikev2Sstp = 0x0000000eU;
enum uint VS_ProtocolList = 0x0000000fU;
enum uint RASEO_UseCountryAndAreaCodes = 0x00000001U;

enum : uint
{
    RASEO_SpecificIpAddr      = 0x00000002U,
    RASEO_SpecificNameServers = 0x00000004U,
}

enum uint RASEO_IpHeaderCompression = 0x00000008U;
enum uint RASEO_RemoteDefaultGateway = 0x00000010U;
enum uint RASEO_DisableLcpExtensions = 0x00000020U;

enum : uint
{
    RASEO_TerminalBeforeDial = 0x00000040U,
    RASEO_TerminalAfterDial  = 0x00000080U,
}

enum uint RASEO_ModemLights = 0x00000100U;
enum uint RASEO_SwCompression = 0x00000200U;

enum : uint
{
    RASEO_RequireEncryptedPw    = 0x00000400U,
    RASEO_RequireMsEncryptedPw  = 0x00000800U,
    RASEO_RequireDataEncryption = 0x00001000U,
}

enum uint RASEO_NetworkLogon = 0x00002000U;
enum uint RASEO_UseLogonCredentials = 0x00004000U;
enum uint RASEO_PromoteAlternates = 0x00008000U;
enum uint RASEO_SecureLocalFiles = 0x00010000U;

enum : uint
{
    RASEO_RequireEAP  = 0x00020000U,
    RASEO_RequirePAP  = 0x00040000U,
    RASEO_RequireSPAP = 0x00080000U,
}

enum : uint
{
    RASEO_Custom             = 0x00100000U,
    RASEO_PreviewPhoneNumber = 0x00200000U,
}

enum uint RASEO_SharedPhoneNumbers = 0x00800000U;

enum : uint
{
    RASEO_PreviewUserPw = 0x01000000U,
    RASEO_PreviewDomain = 0x02000000U,
}

enum uint RASEO_ShowDialingProgress = 0x04000000U;

enum : uint
{
    RASEO_RequireCHAP      = 0x08000000U,
    RASEO_RequireMsCHAP    = 0x10000000U,
    RASEO_RequireMsCHAP2   = 0x20000000U,
    RASEO_RequireW95MSCHAP = 0x40000000U,
}

enum uint RASEO_CustomScript = 0x80000000U;

enum : uint
{
    RASEO2_SecureFileAndPrint   = 0x00000001U,
    RASEO2_SecureClientForMSNet = 0x00000002U,
}

enum uint RASEO2_DontNegotiateMultilink = 0x00000004U;
enum uint RASEO2_DontUseRasCredentials = 0x00000008U;
enum uint RASEO2_UsePreSharedKey = 0x00000010U;

enum : uint
{
    RASEO2_Internet         = 0x00000020U,
    RASEO2_DisableNbtOverIP = 0x00000040U,
}

enum uint RASEO2_UseGlobalDeviceSettings = 0x00000080U;
enum uint RASEO2_ReconnectIfDropped = 0x00000100U;
enum uint RASEO2_SharePhoneNumbers = 0x00000200U;
enum uint RASEO2_SecureRoutingCompartment = 0x00000400U;
enum uint RASEO2_UseTypicalSettings = 0x00000800U;
enum uint RASEO2_IPv6SpecificNameServers = 0x00001000U;
enum uint RASEO2_IPv6RemoteDefaultGateway = 0x00002000U;
enum uint RASEO2_RegisterIpWithDNS = 0x00004000U;
enum uint RASEO2_UseDNSSuffixForRegistration = 0x00008000U;
enum uint RASEO2_IPv4ExplicitMetric = 0x00010000U;
enum uint RASEO2_IPv6ExplicitMetric = 0x00020000U;

enum : uint
{
    RASEO2_DisableIKENameEkuCheck       = 0x00040000U,
    RASEO2_DisableClassBasedStaticRoute = 0x00080000U,
}

enum uint RASEO2_SpecificIPv6Addr = 0x00100000U;
enum uint RASEO2_DisableMobility = 0x00200000U;
enum uint RASEO2_RequireMachineCertificates = 0x00400000U;

enum : uint
{
    RASEO2_UsePreSharedKeyForIkev2Initiator = 0x00800000U,
    RASEO2_UsePreSharedKeyForIkev2Responder = 0x01000000U,
}

enum uint RASEO2_CacheCredentials = 0x02000000U;
enum uint RASEO2_AutoTriggerCapable = 0x04000000U;
enum uint RASEO2_IsThirdPartyProfile = 0x08000000U;
enum uint RASEO2_AuthTypeIsOtp = 0x10000000U;

enum : uint
{
    RASEO2_IsAlwaysOn       = 0x20000000U,
    RASEO2_IsPrivateNetwork = 0x40000000U,
}

enum uint RASEO2_PlumbIKEv2TSAsRoutes = 0x80000000U;

enum : uint
{
    RASNP_NetBEUI = 0x00000001U,
    RASNP_Ipx     = 0x00000002U,
    RASNP_Ip      = 0x00000004U,
    RASNP_Ipv6    = 0x00000008U,
}

enum : uint
{
    RASFP_Ppp  = 0x00000001U,
    RASFP_Slip = 0x00000002U,
    RASFP_Ras  = 0x00000004U,
}

enum : const(wchar)*
{
    RASDT_Modem      = "modem",
    RASDT_Isdn       = "isdn",
    RASDT_X25        = "x25",
    RASDT_Vpn        = "vpn",
    RASDT_Pad        = "pad",
    RASDT_Generic    = "GENERIC",
    RASDT_Serial     = "SERIAL",
    RASDT_FrameRelay = "FRAMERELAY",
}

enum : const(wchar)*
{
    RASDT_Atm      = "ATM",
    RASDT_Sonet    = "SONET",
    RASDT_SW56     = "SW56",
    RASDT_Irda     = "IRDA",
    RASDT_Parallel = "PARALLEL",
    RASDT_PPPoE    = "PPPoE",
}

enum : uint
{
    RASET_Phone     = 0x00000001U,
    RASET_Vpn       = 0x00000002U,
    RASET_Direct    = 0x00000003U,
    RASET_Internet  = 0x00000004U,
    RASET_Broadband = 0x00000005U,
}

enum uint RASCN_Connection = 0x00000001U;
enum uint RASCN_Disconnection = 0x00000002U;

enum : uint
{
    RASCN_BandwidthAdded   = 0x00000004U,
    RASCN_BandwidthRemoved = 0x00000008U,
}

enum : uint
{
    RASCN_Dormant      = 0x00000010U,
    RASCN_ReConnection = 0x00000020U,
}

enum uint RASCN_EPDGPacketArrival = 0x00000040U;

enum : uint
{
    RASIDS_Disabled       = 0xffffffffU,
    RASIDS_UseGlobalValue = 0x00000000U,
}

enum uint RASADFLG_PositionDlg = 0x00000001U;

enum : uint
{
    RASCM_UserName     = 0x00000001U,
    RASCM_Password     = 0x00000002U,
    RASCM_Domain       = 0x00000004U,
    RASCM_DefaultCreds = 0x00000008U,
}

enum uint RASCM_PreSharedKey = 0x00000010U;
enum uint RASCM_ServerPreSharedKey = 0x00000020U;
enum uint RASCM_DDMPreSharedKey = 0x00000040U;
enum uint RASADP_DisableConnectionQuery = 0x00000000U;
enum uint RASADP_LoginSessionDisable = 0x00000001U;
enum uint RASADP_SavedAddressesLimit = 0x00000002U;
enum uint RASADP_FailedConnectionTimeout = 0x00000003U;
enum uint RASADP_ConnectionQueryTimeout = 0x00000004U;
enum uint RASEAPF_NonInteractive = 0x00000002U;

enum : uint
{
    RASEAPF_Logon   = 0x00000004U,
    RASEAPF_Preview = 0x00000008U,
}

enum uint RCD_SingleUser = 0x00000000U;
enum uint RCD_AllUsers = 0x00000001U;

enum : uint
{
    RCD_Eap   = 0x00000002U,
    RCD_Logon = 0x00000004U,
}

enum : uint
{
    RASPBDEVENT_AddEntry    = 0x00000001U,
    RASPBDEVENT_EditEntry   = 0x00000002U,
    RASPBDEVENT_RemoveEntry = 0x00000003U,
    RASPBDEVENT_DialEntry   = 0x00000004U,
    RASPBDEVENT_EditGlobals = 0x00000005U,
    RASPBDEVENT_NoUser      = 0x00000006U,
    RASPBDEVENT_NoUserEdit  = 0x00000007U,
}

enum uint RASNOUSER_SmartCard = 0x00000001U;

enum : uint
{
    RASPBDFLAG_PositionDlg      = 0x00000001U,
    RASPBDFLAG_ForceCloseOnDial = 0x00000002U,
    RASPBDFLAG_NoUser           = 0x00000010U,
    RASPBDFLAG_UpdateDefaults   = 0x80000000U,
}

enum : uint
{
    RASEDFLAG_PositionDlg       = 0x00000001U,
    RASEDFLAG_NewEntry          = 0x00000002U,
    RASEDFLAG_CloneEntry        = 0x00000004U,
    RASEDFLAG_NoRename          = 0x00000008U,
    RASEDFLAG_ShellOwned        = 0x40000000U,
    RASEDFLAG_NewPhoneEntry     = 0x00000010U,
    RASEDFLAG_NewTunnelEntry    = 0x00000020U,
    RASEDFLAG_NewDirectEntry    = 0x00000040U,
    RASEDFLAG_NewBroadbandEntry = 0x00000080U,
}

enum : uint
{
    RASEDFLAG_InternetEntry      = 0x00000100U,
    RASEDFLAG_NAT                = 0x00000200U,
    RASEDFLAG_IncomingConnection = 0x00000400U,
}

enum : uint
{
    RASDDFLAG_PositionDlg = 0x00000001U,
    RASDDFLAG_NoPrompt    = 0x00000002U,
    RASDDFLAG_AoacRedial  = 0x00000004U,
    RASDDFLAG_LinkFailure = 0x80000000U,
}

enum const(wchar)* RRAS_SERVICE_NAME = "RemoteAccess";

enum : uint
{
    PID_IPX   = 0x0000002bU,
    PID_IP    = 0x00000021U,
    PID_IPV6  = 0x00000057U,
    PID_NBF   = 0x0000003fU,
    PID_ATALK = 0x00000029U,
}

enum : uint
{
    MPR_INTERFACE_OUT_OF_RESOURCES          = 0x00000001U,
    MPR_INTERFACE_ADMIN_DISABLED            = 0x00000002U,
    MPR_INTERFACE_CONNECTION_FAILURE        = 0x00000004U,
    MPR_INTERFACE_SERVICE_PAUSED            = 0x00000008U,
    MPR_INTERFACE_DIALOUT_HOURS_RESTRICTION = 0x00000010U,
}

enum : uint
{
    MPR_INTERFACE_NO_MEDIA_SENSE = 0x00000020U,
    MPR_INTERFACE_NO_DEVICE      = 0x00000040U,
}

enum : uint
{
    MPR_MaxDeviceType  = 0x00000010U,
    MPR_MaxPhoneNumber = 0x00000080U,
}

enum : uint
{
    MPR_MaxIpAddress      = 0x0000000fU,
    MPR_MaxIpxAddress     = 0x00000015U,
    MPR_MaxEntryName      = 0x00000100U,
    MPR_MaxDeviceName     = 0x00000080U,
    MPR_MaxCallbackNumber = 0x00000080U,
}

enum : uint
{
    MPR_MaxAreaCode   = 0x0000000aU,
    MPR_MaxPadType    = 0x00000020U,
    MPR_MaxX25Address = 0x000000c8U,
    MPR_MaxFacilities = 0x000000c8U,
    MPR_MaxUserData   = 0x000000c8U,
}

enum : uint
{
    MPRIO_SpecificIpAddr      = 0x00000002U,
    MPRIO_SpecificNameServers = 0x00000004U,
}

enum uint MPRIO_IpHeaderCompression = 0x00000008U;
enum uint MPRIO_RemoteDefaultGateway = 0x00000010U;
enum uint MPRIO_DisableLcpExtensions = 0x00000020U;
enum uint MPRIO_SwCompression = 0x00000200U;

enum : uint
{
    MPRIO_RequireEncryptedPw    = 0x00000400U,
    MPRIO_RequireMsEncryptedPw  = 0x00000800U,
    MPRIO_RequireDataEncryption = 0x00001000U,
}

enum uint MPRIO_NetworkLogon = 0x00002000U;
enum uint MPRIO_PromoteAlternates = 0x00008000U;
enum uint MPRIO_SecureLocalFiles = 0x00010000U;

enum : uint
{
    MPRIO_RequireEAP  = 0x00020000U,
    MPRIO_RequirePAP  = 0x00040000U,
    MPRIO_RequireSPAP = 0x00080000U,
}

enum uint MPRIO_SharedPhoneNumbers = 0x00800000U;

enum : uint
{
    MPRIO_RequireCHAP    = 0x08000000U,
    MPRIO_RequireMsCHAP  = 0x10000000U,
    MPRIO_RequireMsCHAP2 = 0x20000000U,
}

enum uint MPRIO_IpSecPreSharedKey = 0x80000000U;
enum uint MPRIO_RequireMachineCertificates = 0x01000000U;

enum : uint
{
    MPRIO_UsePreSharedKeyForIkev2Initiator = 0x02000000U,
    MPRIO_UsePreSharedKeyForIkev2Responder = 0x04000000U,
}

enum : uint
{
    MPRNP_Ipx  = 0x00000002U,
    MPRNP_Ip   = 0x00000004U,
    MPRNP_Ipv6 = 0x00000008U,
}

enum : const(wchar)*
{
    MPRDT_Modem      = "modem",
    MPRDT_Isdn       = "isdn",
    MPRDT_X25        = "x25",
    MPRDT_Vpn        = "vpn",
    MPRDT_Pad        = "pad",
    MPRDT_Generic    = "GENERIC",
    MPRDT_Serial     = "SERIAL",
    MPRDT_FrameRelay = "FRAMERELAY",
}

enum : const(wchar)*
{
    MPRDT_Atm      = "ATM",
    MPRDT_Sonet    = "SONET",
    MPRDT_SW56     = "SW56",
    MPRDT_Irda     = "IRDA",
    MPRDT_Parallel = "PARALLEL",
}

enum : uint
{
    MPRET_Phone  = 0x00000001U,
    MPRET_Vpn    = 0x00000002U,
    MPRET_Direct = 0x00000003U,
}

enum : uint
{
    MPRIDS_Disabled       = 0xffffffffU,
    MPRIDS_UseGlobalValue = 0x00000000U,
}

enum : uint
{
    MPR_VS_Ikev2Only  = 0x00000007U,
    MPR_VS_Ikev2First = 0x00000008U,
}

enum : uint
{
    MPR_ENABLE_RAS_ON_DEVICE     = 0x00000001U,
    MPR_ENABLE_ROUTING_ON_DEVICE = 0x00000002U,
}

enum uint IPADDRESSLEN = 0x0000000fU;
enum uint IPXADDRESSLEN = 0x00000016U;
enum uint ATADDRESSLEN = 0x00000020U;
enum uint MAXIPADRESSLEN = 0x00000040U;
enum uint PPP_IPCP_VJ = 0x00000001U;

enum : uint
{
    PPP_CCP_COMPRESSION        = 0x00000001U,
    PPP_CCP_ENCRYPTION40BITOLD = 0x00000010U,
    PPP_CCP_ENCRYPTION40BIT    = 0x00000020U,
    PPP_CCP_ENCRYPTION128BIT   = 0x00000040U,
    PPP_CCP_ENCRYPTION56BIT    = 0x00000080U,
}

enum uint PPP_CCP_HISTORYLESS = 0x01000000U;
enum uint PPP_LCP_MULTILINK_FRAMING = 0x00000001U;

enum : uint
{
    PPP_LCP_PFC         = 0x00000002U,
    PPP_LCP_ACFC        = 0x00000004U,
    PPP_LCP_SSHF        = 0x00000008U,
    PPP_LCP_DES_56      = 0x00000010U,
    PPP_LCP_3_DES       = 0x00000020U,
    PPP_LCP_AES_128     = 0x00000040U,
    PPP_LCP_AES_256     = 0x00000080U,
    PPP_LCP_AES_192     = 0x00000100U,
    PPP_LCP_GCM_AES_128 = 0x00000200U,
    PPP_LCP_GCM_AES_192 = 0x00000400U,
    PPP_LCP_GCM_AES_256 = 0x00000800U,
}

enum uint RAS_FLAGS_RAS_CONNECTION = 0x00000004U;

enum : uint
{
    RASPRIV_NoCallback       = 0x00000001U,
    RASPRIV_AdminSetCallback = 0x00000002U,
}

enum uint RASPRIV_CallerSetCallback = 0x00000004U;
enum uint RASPRIV_DialinPrivilege = 0x00000008U;
enum uint RASPRIV2_DialinPolicy = 0x00000001U;

enum : uint
{
    MPRAPI_IKEV2_AUTH_USING_CERT = 0x00000001U,
    MPRAPI_IKEV2_AUTH_USING_EAP  = 0x00000002U,
}

enum uint MPRAPI_PPP_PROJECTION_INFO_TYPE = 0x00000001U;
enum uint MPRAPI_IKEV2_PROJECTION_INFO_TYPE = 0x00000002U;
enum uint MPRAPI_RAS_CONNECTION_OBJECT_REVISION_1 = 0x00000001U;
enum uint MPRAPI_MPR_IF_CUSTOM_CONFIG_OBJECT_REVISION_1 = 0x00000001U;
enum uint MPRAPI_IF_CUSTOM_CONFIG_FOR_IKEV2 = 0x00000001U;

enum : uint
{
    MPRAPI_MPR_IF_CUSTOM_CONFIG_OBJECT_REVISION_3 = 0x00000003U,
    MPRAPI_MPR_IF_CUSTOM_CONFIG_OBJECT_REVISION_2 = 0x00000002U,
}

enum uint MPRAPI_IKEV2_SET_TUNNEL_CONFIG_PARAMS = 0x00000001U;
enum uint MPRAPI_L2TP_SET_TUNNEL_CONFIG_PARAMS = 0x00000001U;
enum uint MAX_SSTP_HASH_SIZE = 0x00000020U;

enum : uint
{
    MPRAPI_MPR_SERVER_OBJECT_REVISION_1            = 0x00000001U,
    MPRAPI_MPR_SERVER_OBJECT_REVISION_2            = 0x00000002U,
    MPRAPI_MPR_SERVER_OBJECT_REVISION_3            = 0x00000003U,
    MPRAPI_MPR_SERVER_OBJECT_REVISION_4            = 0x00000004U,
    MPRAPI_MPR_SERVER_OBJECT_REVISION_5            = 0x00000005U,
    MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_1 = 0x00000001U,
    MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_2 = 0x00000002U,
    MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_3 = 0x00000003U,
    MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_4 = 0x00000004U,
    MPRAPI_MPR_SERVER_SET_CONFIG_OBJECT_REVISION_5 = 0x00000005U,
}

enum : uint
{
    MPRAPI_SET_CONFIG_PROTOCOL_FOR_PPTP  = 0x00000001U,
    MPRAPI_SET_CONFIG_PROTOCOL_FOR_L2TP  = 0x00000002U,
    MPRAPI_SET_CONFIG_PROTOCOL_FOR_SSTP  = 0x00000004U,
    MPRAPI_SET_CONFIG_PROTOCOL_FOR_IKEV2 = 0x00000008U,
    MPRAPI_SET_CONFIG_PROTOCOL_FOR_GRE   = 0x00000010U,
}

enum uint ALLOW_NO_AUTH = 0x00000001U;
enum uint DO_NOT_ALLOW_NO_AUTH = 0x00000000U;
enum uint MPRAPI_RAS_UPDATE_CONNECTION_OBJECT_REVISION_1 = 0x00000001U;

enum : uint
{
    MPRAPI_ADMIN_DLL_VERSION_1 = 0x00000001U,
    MPRAPI_ADMIN_DLL_VERSION_2 = 0x00000002U,
}

enum uint MGM_JOIN_STATE_FLAG = 0x00000001U;
enum uint MGM_FORWARD_STATE_FLAG = 0x00000002U;

enum : uint
{
    MGM_MFE_STATS_0 = 0x00000001U,
    MGM_MFE_STATS_1 = 0x00000002U,
}

enum uint RTM_MAX_ADDRESS_SIZE = 0x00000010U;
enum uint RTM_MAX_VIEWS = 0x00000020U;

enum : uint
{
    RTM_VIEW_ID_UCAST   = 0x00000000U,
    RTM_VIEW_ID_MCAST   = 0x00000001U,
    RTM_VIEW_MASK_SIZE  = 0x00000020U,
    RTM_VIEW_MASK_NONE  = 0x00000000U,
    RTM_VIEW_MASK_ANY   = 0x00000000U,
    RTM_VIEW_MASK_UCAST = 0x00000001U,
    RTM_VIEW_MASK_MCAST = 0x00000002U,
    RTM_VIEW_MASK_ALL   = 0xffffffffU,
}

enum uint IPV6_ADDRESS_LEN_IN_BYTES = 0x00000010U;

enum : uint
{
    RTM_DEST_FLAG_NATURAL_NET   = 0x00000001U,
    RTM_DEST_FLAG_FWD_ENGIN_ADD = 0x00000002U,
    RTM_DEST_FLAG_DONT_FORWARD  = 0x00000004U,
}

enum : uint
{
    RTM_ROUTE_STATE_CREATED        = 0x00000000U,
    RTM_ROUTE_STATE_DELETING       = 0x00000001U,
    RTM_ROUTE_STATE_DELETED        = 0x00000002U,
    RTM_ROUTE_FLAGS_MARTIAN        = 0x00000001U,
    RTM_ROUTE_FLAGS_BLACKHOLE      = 0x00000002U,
    RTM_ROUTE_FLAGS_DISCARD        = 0x00000004U,
    RTM_ROUTE_FLAGS_INACTIVE       = 0x00000008U,
    RTM_ROUTE_FLAGS_LOCAL          = 0x00000010U,
    RTM_ROUTE_FLAGS_REMOTE         = 0x00000020U,
    RTM_ROUTE_FLAGS_MYSELF         = 0x00000040U,
    RTM_ROUTE_FLAGS_LOOPBACK       = 0x00000080U,
    RTM_ROUTE_FLAGS_MCAST          = 0x00000100U,
    RTM_ROUTE_FLAGS_LOCAL_MCAST    = 0x00000200U,
    RTM_ROUTE_FLAGS_LIMITED_BC     = 0x00000400U,
    RTM_ROUTE_FLAGS_ZEROS_NETBC    = 0x00001000U,
    RTM_ROUTE_FLAGS_ZEROS_SUBNETBC = 0x00002000U,
    RTM_ROUTE_FLAGS_ONES_NETBC     = 0x00004000U,
    RTM_ROUTE_FLAGS_ONES_SUBNETBC  = 0x00008000U,
}

enum : uint
{
    RTM_NEXTHOP_STATE_CREATED = 0x00000000U,
    RTM_NEXTHOP_STATE_DELETED = 0x00000001U,
    RTM_NEXTHOP_FLAGS_REMOTE  = 0x00000001U,
    RTM_NEXTHOP_FLAGS_DOWN    = 0x00000002U,
}

enum uint METHOD_TYPE_ALL_METHODS = 0xffffffffU;

enum : uint
{
    METHOD_RIP2_NEIGHBOUR_ADDR  = 0x00000001U,
    METHOD_RIP2_OUTBOUND_INTF   = 0x00000002U,
    METHOD_RIP2_ROUTE_TAG       = 0x00000004U,
    METHOD_RIP2_ROUTE_TIMESTAMP = 0x00000008U,
}

enum : uint
{
    METHOD_BGP4_AS_PATH      = 0x00000001U,
    METHOD_BGP4_PEER_ID      = 0x00000002U,
    METHOD_BGP4_PA_ORIGIN    = 0x00000004U,
    METHOD_BGP4_NEXTHOP_ATTR = 0x00000008U,
}

enum uint RTM_RESUME_METHODS = 0x00000000U;
enum uint RTM_BLOCK_METHODS = 0x00000001U;

enum : uint
{
    RTM_ROUTE_CHANGE_FIRST = 0x00000001U,
    RTM_ROUTE_CHANGE_NEW   = 0x00000002U,
    RTM_ROUTE_CHANGE_BEST  = 0x00010000U,
}

enum uint RTM_NEXTHOP_CHANGE_NEW = 0x00000001U;

enum : uint
{
    RTM_MATCH_NONE      = 0x00000000U,
    RTM_MATCH_OWNER     = 0x00000001U,
    RTM_MATCH_NEIGHBOUR = 0x00000002U,
    RTM_MATCH_PREF      = 0x00000004U,
    RTM_MATCH_NEXTHOP   = 0x00000008U,
    RTM_MATCH_INTERFACE = 0x00000010U,
    RTM_MATCH_FULL      = 0x0000ffffU,
}

enum : uint
{
    RTM_ENUM_START      = 0x00000000U,
    RTM_ENUM_NEXT       = 0x00000001U,
    RTM_ENUM_RANGE      = 0x00000002U,
    RTM_ENUM_ALL_DESTS  = 0x00000000U,
    RTM_ENUM_OWN_DESTS  = 0x01000000U,
    RTM_ENUM_ALL_ROUTES = 0x00000000U,
    RTM_ENUM_OWN_ROUTES = 0x00010000U,
}

enum uint RTM_NUM_CHANGE_TYPES = 0x00000003U;

enum : uint
{
    RTM_CHANGE_TYPE_ALL        = 0x00000001U,
    RTM_CHANGE_TYPE_BEST       = 0x00000002U,
    RTM_CHANGE_TYPE_FORWARDING = 0x00000004U,
}

enum uint RTM_NOTIFY_ONLY_MARKED_DESTS = 0x00010000U;
enum uint RASBASE = 0x00000258U;
enum uint PENDING = 0x00000258U;
enum uint ERROR_INVALID_PORT_HANDLE = 0x00000259U;
enum uint ERROR_PORT_ALREADY_OPEN = 0x0000025aU;
enum uint ERROR_BUFFER_TOO_SMALL = 0x0000025bU;
enum uint ERROR_WRONG_INFO_SPECIFIED = 0x0000025cU;
enum uint ERROR_CANNOT_SET_PORT_INFO = 0x0000025dU;
enum uint ERROR_PORT_NOT_CONNECTED = 0x0000025eU;
enum uint ERROR_EVENT_INVALID = 0x0000025fU;

enum : uint
{
    ERROR_DEVICE_DOES_NOT_EXIST     = 0x00000260U,
    ERROR_DEVICETYPE_DOES_NOT_EXIST = 0x00000261U,
}

enum uint ERROR_BUFFER_INVALID = 0x00000262U;

enum : uint
{
    ERROR_ROUTE_NOT_AVAILABLE = 0x00000263U,
    ERROR_ROUTE_NOT_ALLOCATED = 0x00000264U,
}

enum uint ERROR_INVALID_COMPRESSION_SPECIFIED = 0x00000265U;
enum uint ERROR_OUT_OF_BUFFERS = 0x00000266U;
enum uint ERROR_PORT_NOT_FOUND = 0x00000267U;
enum uint ERROR_ASYNC_REQUEST_PENDING = 0x00000268U;
enum uint ERROR_ALREADY_DISCONNECTING = 0x00000269U;

enum : uint
{
    ERROR_PORT_NOT_OPEN     = 0x0000026aU,
    ERROR_PORT_DISCONNECTED = 0x0000026bU,
}

enum uint ERROR_NO_ENDPOINTS = 0x0000026cU;

enum : uint
{
    ERROR_CANNOT_OPEN_PHONEBOOK       = 0x0000026dU,
    ERROR_CANNOT_LOAD_PHONEBOOK       = 0x0000026eU,
    ERROR_CANNOT_FIND_PHONEBOOK_ENTRY = 0x0000026fU,
}

enum uint ERROR_CANNOT_WRITE_PHONEBOOK = 0x00000270U;
enum uint ERROR_CORRUPT_PHONEBOOK = 0x00000271U;
enum uint ERROR_CANNOT_LOAD_STRING = 0x00000272U;
enum uint ERROR_KEY_NOT_FOUND = 0x00000273U;
enum uint ERROR_DISCONNECTION = 0x00000274U;
enum uint ERROR_REMOTE_DISCONNECTION = 0x00000275U;
enum uint ERROR_HARDWARE_FAILURE = 0x00000276U;
enum uint ERROR_USER_DISCONNECTION = 0x00000277U;
enum uint ERROR_INVALID_SIZE = 0x00000278U;
enum uint ERROR_PORT_NOT_AVAILABLE = 0x00000279U;
enum uint ERROR_CANNOT_PROJECT_CLIENT = 0x0000027aU;

enum : uint
{
    ERROR_UNKNOWN               = 0x0000027bU,
    ERROR_WRONG_DEVICE_ATTACHED = 0x0000027cU,
}

enum uint ERROR_BAD_STRING = 0x0000027dU;
enum uint ERROR_REQUEST_TIMEOUT = 0x0000027eU;
enum uint ERROR_CANNOT_GET_LANA = 0x0000027fU;
enum uint ERROR_NETBIOS_ERROR = 0x00000280U;
enum uint ERROR_SERVER_OUT_OF_RESOURCES = 0x00000281U;
enum uint ERROR_NAME_EXISTS_ON_NET = 0x00000282U;
enum uint ERROR_SERVER_GENERAL_NET_FAILURE = 0x00000283U;
enum uint WARNING_MSG_ALIAS_NOT_ADDED = 0x00000284U;
enum uint ERROR_AUTH_INTERNAL = 0x00000285U;
enum uint ERROR_RESTRICTED_LOGON_HOURS = 0x00000286U;
enum uint ERROR_ACCT_DISABLED = 0x00000287U;
enum uint ERROR_PASSWD_EXPIRED = 0x00000288U;
enum uint ERROR_NO_DIALIN_PERMISSION = 0x00000289U;
enum uint ERROR_SERVER_NOT_RESPONDING = 0x0000028aU;
enum uint ERROR_FROM_DEVICE = 0x0000028bU;
enum uint ERROR_UNRECOGNIZED_RESPONSE = 0x0000028cU;

enum : uint
{
    ERROR_MACRO_NOT_FOUND   = 0x0000028dU,
    ERROR_MACRO_NOT_DEFINED = 0x0000028eU,
}

enum uint ERROR_MESSAGE_MACRO_NOT_FOUND = 0x0000028fU;
enum uint ERROR_DEFAULTOFF_MACRO_NOT_FOUND = 0x00000290U;
enum uint ERROR_FILE_COULD_NOT_BE_OPENED = 0x00000291U;

enum : uint
{
    ERROR_DEVICENAME_TOO_LONG  = 0x00000292U,
    ERROR_DEVICENAME_NOT_FOUND = 0x00000293U,
}

enum : uint
{
    ERROR_NO_RESPONSES     = 0x00000294U,
    ERROR_NO_COMMAND_FOUND = 0x00000295U,
}

enum uint ERROR_WRONG_KEY_SPECIFIED = 0x00000296U;
enum uint ERROR_UNKNOWN_DEVICE_TYPE = 0x00000297U;
enum uint ERROR_ALLOCATING_MEMORY = 0x00000298U;
enum uint ERROR_PORT_NOT_CONFIGURED = 0x00000299U;
enum uint ERROR_DEVICE_NOT_READY = 0x0000029aU;
enum uint ERROR_READING_INI_FILE = 0x0000029bU;
enum uint ERROR_NO_CONNECTION = 0x0000029cU;
enum uint ERROR_BAD_USAGE_IN_INI_FILE = 0x0000029dU;

enum : uint
{
    ERROR_READING_SECTIONNAME   = 0x0000029eU,
    ERROR_READING_DEVICETYPE    = 0x0000029fU,
    ERROR_READING_DEVICENAME    = 0x000002a0U,
    ERROR_READING_USAGE         = 0x000002a1U,
    ERROR_READING_MAXCONNECTBPS = 0x000002a2U,
    ERROR_READING_MAXCARRIERBPS = 0x000002a3U,
}

enum uint ERROR_LINE_BUSY = 0x000002a4U;
enum uint ERROR_VOICE_ANSWER = 0x000002a5U;

enum : uint
{
    ERROR_NO_ANSWER   = 0x000002a6U,
    ERROR_NO_CARRIER  = 0x000002a7U,
    ERROR_NO_DIALTONE = 0x000002a8U,
}

enum uint ERROR_IN_COMMAND = 0x000002a9U;

enum : uint
{
    ERROR_WRITING_SECTIONNAME   = 0x000002aaU,
    ERROR_WRITING_DEVICETYPE    = 0x000002abU,
    ERROR_WRITING_DEVICENAME    = 0x000002acU,
    ERROR_WRITING_MAXCONNECTBPS = 0x000002adU,
    ERROR_WRITING_MAXCARRIERBPS = 0x000002aeU,
    ERROR_WRITING_USAGE         = 0x000002afU,
    ERROR_WRITING_DEFAULTOFF    = 0x000002b0U,
}

enum uint ERROR_READING_DEFAULTOFF = 0x000002b1U;
enum uint ERROR_EMPTY_INI_FILE = 0x000002b2U;
enum uint ERROR_AUTHENTICATION_FAILURE = 0x000002b3U;
enum uint ERROR_PORT_OR_DEVICE = 0x000002b4U;
enum uint ERROR_NOT_BINARY_MACRO = 0x000002b5U;
enum uint ERROR_DCB_NOT_FOUND = 0x000002b6U;

enum : uint
{
    ERROR_STATE_MACHINES_NOT_STARTED     = 0x000002b7U,
    ERROR_STATE_MACHINES_ALREADY_STARTED = 0x000002b8U,
}

enum uint ERROR_PARTIAL_RESPONSE_LOOPING = 0x000002b9U;
enum uint ERROR_UNKNOWN_RESPONSE_KEY = 0x000002baU;
enum uint ERROR_RECV_BUF_FULL = 0x000002bbU;
enum uint ERROR_CMD_TOO_LONG = 0x000002bcU;
enum uint ERROR_UNSUPPORTED_BPS = 0x000002bdU;
enum uint ERROR_UNEXPECTED_RESPONSE = 0x000002beU;
enum uint ERROR_INTERACTIVE_MODE = 0x000002bfU;
enum uint ERROR_BAD_CALLBACK_NUMBER = 0x000002c0U;
enum uint ERROR_INVALID_AUTH_STATE = 0x000002c1U;
enum uint ERROR_WRITING_INITBPS = 0x000002c2U;
enum uint ERROR_X25_DIAGNOSTIC = 0x000002c3U;
enum uint ERROR_ACCT_EXPIRED = 0x000002c4U;
enum uint ERROR_CHANGING_PASSWORD = 0x000002c5U;

enum : uint
{
    ERROR_OVERRUN                  = 0x000002c6U,
    ERROR_RASMAN_CANNOT_INITIALIZE = 0x000002c7U,
}

enum uint ERROR_BIPLEX_PORT_NOT_AVAILABLE = 0x000002c8U;
enum uint ERROR_NO_ACTIVE_ISDN_LINES = 0x000002c9U;
enum uint ERROR_NO_ISDN_CHANNELS_AVAILABLE = 0x000002caU;
enum uint ERROR_TOO_MANY_LINE_ERRORS = 0x000002cbU;
enum uint ERROR_IP_CONFIGURATION = 0x000002ccU;
enum uint ERROR_NO_IP_ADDRESSES = 0x000002cdU;

enum : uint
{
    ERROR_PPP_TIMEOUT           = 0x000002ceU,
    ERROR_PPP_REMOTE_TERMINATED = 0x000002cfU,
}

enum uint ERROR_PPP_NO_PROTOCOLS_CONFIGURED = 0x000002d0U;

enum : uint
{
    ERROR_PPP_NO_RESPONSE    = 0x000002d1U,
    ERROR_PPP_INVALID_PACKET = 0x000002d2U,
}

enum uint ERROR_PHONE_NUMBER_TOO_LONG = 0x000002d3U;

enum : uint
{
    ERROR_IPXCP_NO_DIALOUT_CONFIGURED = 0x000002d4U,
    ERROR_IPXCP_NO_DIALIN_CONFIGURED  = 0x000002d5U,
}

enum uint ERROR_IPXCP_DIALOUT_ALREADY_ACTIVE = 0x000002d6U;
enum uint ERROR_ACCESSING_TCPCFGDLL = 0x000002d7U;
enum uint ERROR_NO_IP_RAS_ADAPTER = 0x000002d8U;
enum uint ERROR_SLIP_REQUIRES_IP = 0x000002d9U;
enum uint ERROR_PROJECTION_NOT_COMPLETE = 0x000002daU;
enum uint ERROR_PROTOCOL_NOT_CONFIGURED = 0x000002dbU;

enum : uint
{
    ERROR_PPP_NOT_CONVERGING            = 0x000002dcU,
    ERROR_PPP_CP_REJECTED               = 0x000002ddU,
    ERROR_PPP_LCP_TERMINATED            = 0x000002deU,
    ERROR_PPP_REQUIRED_ADDRESS_REJECTED = 0x000002dfU,
}

enum : uint
{
    ERROR_PPP_NCP_TERMINATED    = 0x000002e0U,
    ERROR_PPP_LOOPBACK_DETECTED = 0x000002e1U,
}

enum uint ERROR_PPP_NO_ADDRESS_ASSIGNED = 0x000002e2U;
enum uint ERROR_CANNOT_USE_LOGON_CREDENTIALS = 0x000002e3U;
enum uint ERROR_TAPI_CONFIGURATION = 0x000002e4U;
enum uint ERROR_NO_LOCAL_ENCRYPTION = 0x000002e5U;
enum uint ERROR_NO_REMOTE_ENCRYPTION = 0x000002e6U;
enum uint ERROR_REMOTE_REQUIRES_ENCRYPTION = 0x000002e7U;
enum uint ERROR_IPXCP_NET_NUMBER_CONFLICT = 0x000002e8U;
enum uint ERROR_INVALID_SMM = 0x000002e9U;
enum uint ERROR_SMM_UNINITIALIZED = 0x000002eaU;
enum uint ERROR_NO_MAC_FOR_PORT = 0x000002ebU;
enum uint ERROR_SMM_TIMEOUT = 0x000002ecU;
enum uint ERROR_BAD_PHONE_NUMBER = 0x000002edU;
enum uint ERROR_WRONG_MODULE = 0x000002eeU;
enum uint ERROR_INVALID_CALLBACK_NUMBER = 0x000002efU;
enum uint ERROR_SCRIPT_SYNTAX = 0x000002f0U;
enum uint ERROR_HANGUP_FAILED = 0x000002f1U;
enum uint ERROR_BUNDLE_NOT_FOUND = 0x000002f2U;
enum uint ERROR_CANNOT_DO_CUSTOMDIAL = 0x000002f3U;
enum uint ERROR_DIAL_ALREADY_IN_PROGRESS = 0x000002f4U;
enum uint ERROR_RASAUTO_CANNOT_INITIALIZE = 0x000002f5U;
enum uint ERROR_CONNECTION_ALREADY_SHARED = 0x000002f6U;

enum : uint
{
    ERROR_SHARING_CHANGE_FAILED  = 0x000002f7U,
    ERROR_SHARING_ROUTER_INSTALL = 0x000002f8U,
}

enum uint ERROR_SHARE_CONNECTION_FAILED = 0x000002f9U;
enum uint ERROR_SHARING_PRIVATE_INSTALL = 0x000002faU;
enum uint ERROR_CANNOT_SHARE_CONNECTION = 0x000002fbU;
enum uint ERROR_NO_SMART_CARD_READER = 0x000002fcU;
enum uint ERROR_SHARING_ADDRESS_EXISTS = 0x000002fdU;
enum uint ERROR_NO_CERTIFICATE = 0x000002feU;
enum uint ERROR_SHARING_MULTIPLE_ADDRESSES = 0x000002ffU;
enum uint ERROR_FAILED_TO_ENCRYPT = 0x00000300U;
enum uint ERROR_BAD_ADDRESS_SPECIFIED = 0x00000301U;
enum uint ERROR_CONNECTION_REJECT = 0x00000302U;
enum uint ERROR_CONGESTION = 0x00000303U;
enum uint ERROR_INCOMPATIBLE = 0x00000304U;
enum uint ERROR_NUMBERCHANGED = 0x00000305U;
enum uint ERROR_TEMPFAILURE = 0x00000306U;

enum : uint
{
    ERROR_BLOCKED      = 0x00000307U,
    ERROR_DONOTDISTURB = 0x00000308U,
}

enum uint ERROR_OUTOFORDER = 0x00000309U;
enum uint ERROR_UNABLE_TO_AUTHENTICATE_SERVER = 0x0000030aU;
enum uint ERROR_SMART_CARD_REQUIRED = 0x0000030bU;
enum uint ERROR_INVALID_FUNCTION_FOR_ENTRY = 0x0000030cU;
enum uint ERROR_CERT_FOR_ENCRYPTION_NOT_FOUND = 0x0000030dU;

enum : uint
{
    ERROR_SHARING_RRAS_CONFLICT  = 0x0000030eU,
    ERROR_SHARING_NO_PRIVATE_LAN = 0x0000030fU,
}

enum uint ERROR_NO_DIFF_USER_AT_LOGON = 0x00000310U;
enum uint ERROR_NO_REG_CERT_AT_LOGON = 0x00000311U;

enum : uint
{
    ERROR_OAKLEY_NO_CERT            = 0x00000312U,
    ERROR_OAKLEY_AUTH_FAIL          = 0x00000313U,
    ERROR_OAKLEY_ATTRIB_FAIL        = 0x00000314U,
    ERROR_OAKLEY_GENERAL_PROCESSING = 0x00000315U,
    ERROR_OAKLEY_NO_PEER_CERT       = 0x00000316U,
    ERROR_OAKLEY_NO_POLICY          = 0x00000317U,
    ERROR_OAKLEY_TIMED_OUT          = 0x00000318U,
    ERROR_OAKLEY_ERROR              = 0x00000319U,
}

enum uint ERROR_UNKNOWN_FRAMED_PROTOCOL = 0x0000031aU;
enum uint ERROR_WRONG_TUNNEL_TYPE = 0x0000031bU;
enum uint ERROR_UNKNOWN_SERVICE_TYPE = 0x0000031cU;
enum uint ERROR_CONNECTING_DEVICE_NOT_FOUND = 0x0000031dU;
enum uint ERROR_NO_EAPTLS_CERTIFICATE = 0x0000031eU;
enum uint ERROR_SHARING_HOST_ADDRESS_CONFLICT = 0x0000031fU;
enum uint ERROR_AUTOMATIC_VPN_FAILED = 0x00000320U;
enum uint ERROR_VALIDATING_SERVER_CERT = 0x00000321U;
enum uint ERROR_READING_SCARD = 0x00000322U;

enum : uint
{
    ERROR_INVALID_PEAP_COOKIE_CONFIG = 0x00000323U,
    ERROR_INVALID_PEAP_COOKIE_USER   = 0x00000324U,
    ERROR_INVALID_MSCHAPV2_CONFIG    = 0x00000325U,
}

enum : uint
{
    ERROR_VPN_GRE_BLOCKED = 0x00000326U,
    ERROR_VPN_DISCONNECT  = 0x00000327U,
    ERROR_VPN_REFUSED     = 0x00000328U,
    ERROR_VPN_TIMEOUT     = 0x00000329U,
    ERROR_VPN_BAD_CERT    = 0x0000032aU,
    ERROR_VPN_BAD_PSK     = 0x0000032bU,
}

enum uint ERROR_SERVER_POLICY = 0x0000032cU;

enum : uint
{
    ERROR_BROADBAND_ACTIVE  = 0x0000032dU,
    ERROR_BROADBAND_NO_NIC  = 0x0000032eU,
    ERROR_BROADBAND_TIMEOUT = 0x0000032fU,
}

enum uint ERROR_FEATURE_DEPRECATED = 0x00000330U;
enum uint ERROR_CANNOT_DELETE = 0x00000331U;
enum uint ERROR_RASQEC_RESOURCE_CREATION_FAILED = 0x00000332U;

enum : uint
{
    ERROR_RASQEC_NAPAGENT_NOT_ENABLED   = 0x00000333U,
    ERROR_RASQEC_NAPAGENT_NOT_CONNECTED = 0x00000334U,
}

enum : uint
{
    ERROR_RASQEC_CONN_DOESNOTEXIST = 0x00000335U,
    ERROR_RASQEC_TIMEOUT           = 0x00000336U,
}

enum : uint
{
    ERROR_PEAP_CRYPTOBINDING_INVALID     = 0x00000337U,
    ERROR_PEAP_CRYPTOBINDING_NOTRECEIVED = 0x00000338U,
}

enum uint ERROR_INVALID_VPNSTRATEGY = 0x00000339U;
enum uint ERROR_EAPTLS_CACHE_CREDENTIALS_INVALID = 0x0000033aU;
enum uint ERROR_IPSEC_SERVICE_STOPPED = 0x0000033bU;
enum uint ERROR_IDLE_TIMEOUT = 0x0000033cU;
enum uint ERROR_LINK_FAILURE = 0x0000033dU;
enum uint ERROR_USER_LOGOFF = 0x0000033eU;
enum uint ERROR_FAST_USER_SWITCH = 0x0000033fU;
enum uint ERROR_HIBERNATION = 0x00000340U;
enum uint ERROR_SYSTEM_SUSPENDED = 0x00000341U;
enum uint ERROR_RASMAN_SERVICE_STOPPED = 0x00000342U;
enum uint ERROR_INVALID_SERVER_CERT = 0x00000343U;
enum uint ERROR_NOT_NAP_CAPABLE = 0x00000344U;
enum uint ERROR_INVALID_TUNNELID = 0x00000345U;
enum uint ERROR_UPDATECONNECTION_REQUEST_IN_PROCESS = 0x00000346U;
enum uint ERROR_PROTOCOL_ENGINE_DISABLED = 0x00000347U;
enum uint ERROR_INTERNAL_ADDRESS_FAILURE = 0x00000348U;
enum uint ERROR_FAILED_CP_REQUIRED = 0x00000349U;
enum uint ERROR_TS_UNACCEPTABLE = 0x0000034aU;
enum uint ERROR_MOBIKE_DISABLED = 0x0000034bU;
enum uint ERROR_CANNOT_INITIATE_MOBIKE_UPDATE = 0x0000034cU;
enum uint ERROR_PEAP_SERVER_REJECTED_CLIENT_TLV = 0x0000034dU;
enum uint ERROR_INVALID_PREFERENCES = 0x0000034eU;
enum uint ERROR_EAPTLS_SCARD_CACHE_CREDENTIALS_INVALID = 0x0000034fU;
enum uint ERROR_SSTP_COOKIE_SET_FAILURE = 0x00000350U;
enum uint ERROR_INVALID_PEAP_COOKIE_ATTRIBUTES = 0x00000351U;

enum : uint
{
    ERROR_EAP_METHOD_NOT_INSTALLED           = 0x00000352U,
    ERROR_EAP_METHOD_DOES_NOT_SUPPORT_SSO    = 0x00000353U,
    ERROR_EAP_METHOD_OPERATION_NOT_SUPPORTED = 0x00000354U,
}

enum : uint
{
    ERROR_EAP_USER_CERT_INVALID     = 0x00000355U,
    ERROR_EAP_USER_CERT_EXPIRED     = 0x00000356U,
    ERROR_EAP_USER_CERT_REVOKED     = 0x00000357U,
    ERROR_EAP_USER_CERT_OTHER_ERROR = 0x00000358U,
}

enum : uint
{
    ERROR_EAP_SERVER_CERT_INVALID     = 0x00000359U,
    ERROR_EAP_SERVER_CERT_EXPIRED     = 0x0000035aU,
    ERROR_EAP_SERVER_CERT_REVOKED     = 0x0000035bU,
    ERROR_EAP_SERVER_CERT_OTHER_ERROR = 0x0000035cU,
}

enum : uint
{
    ERROR_EAP_USER_ROOT_CERT_NOT_FOUND = 0x0000035dU,
    ERROR_EAP_USER_ROOT_CERT_INVALID   = 0x0000035eU,
    ERROR_EAP_USER_ROOT_CERT_EXPIRED   = 0x0000035fU,
}

enum : uint
{
    ERROR_EAP_SERVER_ROOT_CERT_NOT_FOUND     = 0x00000360U,
    ERROR_EAP_SERVER_ROOT_CERT_INVALID       = 0x00000361U,
    ERROR_EAP_SERVER_ROOT_CERT_NAME_REQUIRED = 0x00000362U,
}

enum uint ERROR_PEAP_IDENTITY_MISMATCH = 0x00000363U;
enum uint ERROR_DNSNAME_NOT_RESOLVABLE = 0x00000364U;
enum uint ERROR_EAPTLS_PASSWD_INVALID = 0x00000365U;
enum uint ERROR_IKEV2_PSK_INTERFACE_ALREADY_EXISTS = 0x00000366U;

enum : uint
{
    ERROR_INVALID_DESTINATION_IP   = 0x00000367U,
    ERROR_INVALID_INTERFACE_CONFIG = 0x00000368U,
}

enum uint ERROR_VPN_PLUGIN_GENERIC = 0x00000369U;
enum uint ERROR_SSO_CERT_MISSING = 0x0000036aU;
enum uint ERROR_DEVICE_COMPLIANCE = 0x0000036bU;
enum uint ERROR_PLUGIN_NOT_INSTALLED = 0x0000036cU;
enum uint ERROR_ACTION_REQUIRED = 0x0000036dU;
enum uint ERROR_WINHTTP_AUTO_PROXY_SERVICE = 0x0000036eU;
enum uint RASBASEEND = 0x0000036eU;

// Callbacks

alias RASDIALFUNC = void function(uint param0, RASCONNSTATE param1, uint param2);
alias RASDIALFUNC1 = void function(HRASCONN param0, uint param1, RASCONNSTATE param2, uint param3, uint param4);
alias RASDIALFUNC2 = uint function(size_t param0, uint param1, HRASCONN param2, uint param3, RASCONNSTATE param4, 
                                   uint param5, uint param6);
alias ORASADFUNC = BOOL function(HWND param0, PSTR param1, uint param2, uint* param3);
alias RASADFUNCA = BOOL function(PSTR param0, PSTR param1, RASADPARAMS* param2, uint* param3);
alias RASADFUNCW = BOOL function(PWSTR param0, PWSTR param1, RASADPARAMS* param2, uint* param3);
alias PFNRASGETBUFFER = uint function(ubyte** ppBuffer, uint* pdwSize);
alias PFNRASFREEBUFFER = uint function(ubyte* pBufer);
alias PFNRASSENDBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint dwSize);
alias PFNRASRECEIVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize, uint dwTimeOut, 
                                          HANDLE hEvent);
alias PFNRASRETRIEVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize);
alias RasCustomScriptExecuteFn = uint function(HANDLE hPort, const(PWSTR) lpszPhonebook, 
                                               const(PWSTR) lpszEntryName, PFNRASGETBUFFER pfnRasGetBuffer, 
                                               PFNRASFREEBUFFER pfnRasFreeBuffer, PFNRASSENDBUFFER pfnRasSendBuffer, 
                                               PFNRASRECEIVEBUFFER pfnRasReceiveBuffer, 
                                               PFNRASRETRIEVEBUFFER pfnRasRetrieveBuffer, HWND hWnd, 
                                               RASDIALPARAMSA* pRasDialParams, void* pvReserved);
alias PFNRASSETCOMMSETTINGS = uint function(HANDLE hPort, RASCOMMSETTINGS* pRasCommSettings, void* pvReserved);
alias RasCustomHangUpFn = uint function(HRASCONN hRasConn);
alias RasCustomDialFn = uint function(HINSTANCE hInstDll, RASDIALEXTENSIONS* lpRasDialExtensions, 
                                      const(PWSTR) lpszPhonebook, RASDIALPARAMSA* lpRasDialParams, 
                                      uint dwNotifierType, void* lpvNotifier, HRASCONN* lphRasConn, uint dwFlags);
alias RasCustomDeleteEntryNotifyFn = uint function(const(PWSTR) lpszPhonebook, const(PWSTR) lpszEntry, 
                                                   uint dwFlags);
alias RASPBDLGFUNCW = void function(size_t param0, uint param1, PWSTR param2, void* param3);
alias RASPBDLGFUNCA = void function(size_t param0, uint param1, PSTR param2, void* param3);
alias RasCustomDialDlgFn = BOOL function(HINSTANCE hInstDll, uint dwFlags, PWSTR lpszPhonebook, PWSTR lpszEntry, 
                                         PWSTR lpszPhoneNumber, RASDIALDLG* lpInfo, void* pvInfo);
alias RasCustomEntryDlgFn = BOOL function(HINSTANCE hInstDll, PWSTR lpszPhonebook, PWSTR lpszEntry, 
                                          RASENTRYDLGA* lpInfo, uint dwFlags);
alias PMPRADMINGETIPADDRESSFORUSER = uint function(PWSTR param0, PWSTR param1, uint* param2, BOOL* param3);
alias PMPRADMINRELEASEIPADRESS = void function(PWSTR param0, PWSTR param1, uint* param2);
alias PMPRADMINGETIPV6ADDRESSFORUSER = uint function(PWSTR param0, PWSTR param1, IN6_ADDR* param2, BOOL* param3);
alias PMPRADMINRELEASEIPV6ADDRESSFORUSER = void function(PWSTR param0, PWSTR param1, IN6_ADDR* param2);
alias PMPRADMINACCEPTNEWCONNECTION = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINACCEPTNEWCONNECTION2 = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                    RAS_CONNECTION_2* param2);
alias PMPRADMINACCEPTNEWCONNECTION3 = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                    RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWLINK = BOOL function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION2 = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                             RAS_CONNECTION_2* param2);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION3 = void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                             RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINLINKHANGUPNOTIFICATION = void function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINTERMINATEDLL = uint function();
alias PMPRADMINACCEPTREAUTHENTICATION = BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, 
                                                      RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWCONNECTIONEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTREAUTHENTICATIONEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX = BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX = void function(RAS_CONNECTION_EX* param0);
alias PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX = uint function(AUTH_VALIDATION_EX* param0);
alias RASSECURITYPROC = uint function();
alias PMGM_RPF_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, 
                                        uint* pdwInIfIndex, uint* pdwInIfNextHopAddr, uint* pdwUpStreamNbr, 
                                        uint dwHdrSize, ubyte* pbPacketHdr, ubyte* pbRoute);
alias PMGM_CREATION_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                   uint dwGroupMask, uint dwInIfIndex, uint dwInIfNextHopAddr, 
                                                   uint dwIfCount, MGM_IF_ENTRY* pmieOutIfList);
alias PMGM_PRUNE_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr, 
                                                BOOL bMemberDelete, uint* pdwTimeout);
alias PMGM_JOIN_ALERT_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                               uint dwGroupMask, BOOL bMemberUpdate);
alias PMGM_WRONG_IF_CALLBACK = uint function(uint dwSourceAddr, uint dwGroupAddr, uint dwIfIndex, 
                                             uint dwIfNextHopAddr, uint dwHdrSize, ubyte* pbPacketHdr);
alias PMGM_LOCAL_JOIN_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                               uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_LOCAL_LEAVE_CALLBACK = uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_DISABLE_IGMP_CALLBACK = uint function(uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_ENABLE_IGMP_CALLBACK = uint function(uint dwIfIndex, uint dwIfNextHopAddr);
alias RTM_EVENT_CALLBACK = uint function(ptrdiff_t RtmRegHandle, RTM_EVENT_TYPE EventType, void* Context1, 
                                         void* Context2);
alias RTM_ENTITY_EXPORT_METHOD = void function(ptrdiff_t CallerHandle, ptrdiff_t CalleeHandle, 
                                               RTM_ENTITY_METHOD_INPUT* Input, RTM_ENTITY_METHOD_OUTPUT* Output);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HRASCONN
{
    void* Value;
}

version(X86_64)
{
    struct RASCONNW
    {
    align (4):
        uint       dwSize;
        HRASCONN   hrasconn;
        wchar[257] szEntryName;
        wchar[17]  szDeviceType;
        wchar[129] szDeviceName;
        wchar[260] szPhonebook;
        uint       dwSubEntry;
        GUID       guidEntry;
        uint       dwFlags;
        LUID       luid;
        GUID       guidCorrelationId;
    }
}

version(AArch64)
{
    struct RASCONNW
    {
    align (4):
        uint       dwSize;
        HRASCONN   hrasconn;
        wchar[257] szEntryName;
        wchar[17]  szDeviceType;
        wchar[129] szDeviceName;
        wchar[260] szPhonebook;
        uint       dwSubEntry;
        GUID       guidEntry;
        uint       dwFlags;
        LUID       luid;
        GUID       guidCorrelationId;
    }
}

version(X86_64)
{
    struct RASCONNA
    {
    align (4):
        uint      dwSize;
        HRASCONN  hrasconn;
        CHAR[257] szEntryName;
        CHAR[17]  szDeviceType;
        CHAR[129] szDeviceName;
        CHAR[260] szPhonebook;
        uint      dwSubEntry;
        GUID      guidEntry;
        uint      dwFlags;
        LUID      luid;
        GUID      guidCorrelationId;
    }
}

version(AArch64)
{
    struct RASCONNA
    {
    align (4):
        uint      dwSize;
        HRASCONN  hrasconn;
        CHAR[257] szEntryName;
        CHAR[17]  szDeviceType;
        CHAR[129] szDeviceName;
        CHAR[260] szPhonebook;
        uint      dwSubEntry;
        GUID      guidEntry;
        uint      dwFlags;
        LUID      luid;
        GUID      guidCorrelationId;
    }
}

version(X86_64)
{
    struct RASDIALPARAMSW
    {
    align (4):
        uint       dwSize;
        wchar[257] szEntryName;
        wchar[129] szPhoneNumber;
        wchar[129] szCallbackNumber;
        wchar[257] szUserName;
        wchar[257] szPassword;
        wchar[16]  szDomain;
        uint       dwSubEntry;
        size_t     dwCallbackId;
        uint       dwIfIndex;
        PWSTR      szEncPassword;
    }
}

version(AArch64)
{
    struct RASDIALPARAMSW
    {
    align (4):
        uint       dwSize;
        wchar[257] szEntryName;
        wchar[129] szPhoneNumber;
        wchar[129] szCallbackNumber;
        wchar[257] szUserName;
        wchar[257] szPassword;
        wchar[16]  szDomain;
        uint       dwSubEntry;
        size_t     dwCallbackId;
        uint       dwIfIndex;
        PWSTR      szEncPassword;
    }
}

version(X86_64)
{
    struct RASDIALPARAMSA
    {
    align (4):
        uint      dwSize;
        CHAR[257] szEntryName;
        CHAR[129] szPhoneNumber;
        CHAR[129] szCallbackNumber;
        CHAR[257] szUserName;
        CHAR[257] szPassword;
        CHAR[16]  szDomain;
        uint      dwSubEntry;
        size_t    dwCallbackId;
        uint      dwIfIndex;
        PSTR      szEncPassword;
    }
}

version(AArch64)
{
    struct RASDIALPARAMSA
    {
    align (4):
        uint      dwSize;
        CHAR[257] szEntryName;
        CHAR[129] szPhoneNumber;
        CHAR[129] szCallbackNumber;
        CHAR[257] szUserName;
        CHAR[257] szPassword;
        CHAR[16]  szDomain;
        uint      dwSubEntry;
        size_t    dwCallbackId;
        uint      dwIfIndex;
        PSTR      szEncPassword;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasdevspecificinfo
    struct RASDEVSPECIFICINFO
    {
    align (4):
        uint   dwSize;
        ubyte* pbDevSpecificInfo;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasdevspecificinfo
    struct RASDEVSPECIFICINFO
    {
    align (4):
        uint   dwSize;
        ubyte* pbDevSpecificInfo;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasikev2_projection_info
    struct RASIKEV2_PROJECTION_INFO
    {
    align (4):
        uint      dwIPv4NegotiationError;
        IN_ADDR   ipv4Address;
        IN_ADDR   ipv4ServerAddress;
        uint      dwIPv6NegotiationError;
        IN6_ADDR  ipv6Address;
        IN6_ADDR  ipv6ServerAddress;
        uint      dwPrefixLength;
        uint      dwAuthenticationProtocol;
        uint      dwEapTypeId;
        RASIKEV_PROJECTION_INFO_FLAGS dwFlags;
        uint      dwEncryptionMethod;
        uint      numIPv4ServerAddresses;
        IN_ADDR*  ipv4ServerAddresses;
        uint      numIPv6ServerAddresses;
        IN6_ADDR* ipv6ServerAddresses;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasikev2_projection_info
    struct RASIKEV2_PROJECTION_INFO
    {
    align (4):
        uint      dwIPv4NegotiationError;
        IN_ADDR   ipv4Address;
        IN_ADDR   ipv4ServerAddress;
        uint      dwIPv6NegotiationError;
        IN6_ADDR  ipv6Address;
        IN6_ADDR  ipv6ServerAddress;
        uint      dwPrefixLength;
        uint      dwAuthenticationProtocol;
        uint      dwEapTypeId;
        RASIKEV_PROJECTION_INFO_FLAGS dwFlags;
        uint      dwEncryptionMethod;
        uint      numIPv4ServerAddresses;
        IN_ADDR*  ipv4ServerAddresses;
        uint      numIPv6ServerAddresses;
        IN6_ADDR* ipv6ServerAddresses;
    }
}

version(X86_64)
{
    struct RASPBDLGW
    {
    align (4):
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCW pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(AArch64)
{
    struct RASPBDLGW
    {
    align (4):
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCW pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(X86_64)
{
    struct RASPBDLGA
    {
    align (4):
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCA pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(AArch64)
{
    struct RASPBDLGA
    {
    align (4):
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCA pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(X86_64)
{
    struct RASENTRYDLGW
    {
    align (4):
        uint       dwSize;
        HWND       hwndOwner;
        uint       dwFlags;
        int        xDlg;
        int        yDlg;
        wchar[257] szEntry;
        uint       dwError;
        size_t     reserved;
        size_t     reserved2;
    }
}

version(AArch64)
{
    struct RASENTRYDLGW
    {
    align (4):
        uint       dwSize;
        HWND       hwndOwner;
        uint       dwFlags;
        int        xDlg;
        int        yDlg;
        wchar[257] szEntry;
        uint       dwError;
        size_t     reserved;
        size_t     reserved2;
    }
}

version(X86_64)
{
    struct RASENTRYDLGA
    {
    align (4):
        uint      dwSize;
        HWND      hwndOwner;
        uint      dwFlags;
        int       xDlg;
        int       yDlg;
        CHAR[257] szEntry;
        uint      dwError;
        size_t    reserved;
        size_t    reserved2;
    }
}

version(AArch64)
{
    struct RASENTRYDLGA
    {
    align (4):
        uint      dwSize;
        HWND      hwndOwner;
        uint      dwFlags;
        int       xDlg;
        int       yDlg;
        CHAR[257] szEntry;
        uint      dwError;
        size_t    reserved;
        size_t    reserved2;
    }
}

struct RASIPADDR
{
    ubyte a;
    ubyte b;
    ubyte c;
    ubyte d;
}

struct RASTUNNELENDPOINT
{
    uint dwType;
    union
    {
        IN_ADDR  ipv4;
        IN6_ADDR ipv6;
    }
}

version(X86)
{
    struct RASCONNW
    {
        uint       dwSize;
        HRASCONN   hrasconn;
        wchar[257] szEntryName;
        wchar[17]  szDeviceType;
        wchar[129] szDeviceName;
        wchar[260] szPhonebook;
        uint       dwSubEntry;
        GUID       guidEntry;
        uint       dwFlags;
        LUID       luid;
        GUID       guidCorrelationId;
    }
}

version(X86)
{
    struct RASCONNA
    {
        uint      dwSize;
        HRASCONN  hrasconn;
        CHAR[257] szEntryName;
        CHAR[17]  szDeviceType;
        CHAR[129] szDeviceName;
        CHAR[260] szPhonebook;
        uint      dwSubEntry;
        GUID      guidEntry;
        uint      dwFlags;
        LUID      luid;
        GUID      guidCorrelationId;
    }
}

struct RASCONNSTATUSW
{
    uint              dwSize;
    RASCONNSTATE      rasconnstate;
    uint              dwError;
    wchar[17]         szDeviceType;
    wchar[129]        szDeviceName;
    wchar[129]        szPhoneNumber;
    RASTUNNELENDPOINT localEndPoint;
    RASTUNNELENDPOINT remoteEndPoint;
    RASCONNSUBSTATE   rasconnsubstate;
}

struct RASCONNSTATUSA
{
    uint              dwSize;
    RASCONNSTATE      rasconnstate;
    uint              dwError;
    CHAR[17]          szDeviceType;
    CHAR[129]         szDeviceName;
    CHAR[129]         szPhoneNumber;
    RASTUNNELENDPOINT localEndPoint;
    RASTUNNELENDPOINT remoteEndPoint;
    RASCONNSUBSTATE   rasconnsubstate;
}

version(X86)
{
    struct RASDIALPARAMSW
    {
        uint       dwSize;
        wchar[257] szEntryName;
        wchar[129] szPhoneNumber;
        wchar[129] szCallbackNumber;
        wchar[257] szUserName;
        wchar[257] szPassword;
        wchar[16]  szDomain;
        uint       dwSubEntry;
        size_t     dwCallbackId;
        uint       dwIfIndex;
        PWSTR      szEncPassword;
    }
}

version(X86)
{
    struct RASDIALPARAMSA
    {
        uint      dwSize;
        CHAR[257] szEntryName;
        CHAR[129] szPhoneNumber;
        CHAR[129] szCallbackNumber;
        CHAR[257] szUserName;
        CHAR[257] szPassword;
        CHAR[16]  szDomain;
        uint      dwSubEntry;
        size_t    dwCallbackId;
        uint      dwIfIndex;
        PSTR      szEncPassword;
    }
}

struct RASEAPINFO
{
align (4):
    uint   dwSizeofEapInfo;
    ubyte* pbEapInfo;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasdevspecificinfo
    struct RASDEVSPECIFICINFO
    {
        uint   dwSize;
        ubyte* pbDevSpecificInfo;
    }
}

struct RASDIALEXTENSIONS
{
align (4):
    uint               dwSize;
    uint               dwfOptions;
    HWND               hwndParent;
    size_t             reserved;
    size_t             reserved1;
    RASEAPINFO         RasEapInfo;
    BOOL               fSkipPppAuth;
    RASDEVSPECIFICINFO RasDevSpecificInfo;
}

struct RASENTRYNAMEW
{
    uint       dwSize;
    wchar[257] szEntryName;
    uint       dwFlags;
    wchar[261] szPhonebookPath;
}

struct RASENTRYNAMEA
{
    uint      dwSize;
    CHAR[257] szEntryName;
    uint      dwFlags;
    CHAR[261] szPhonebookPath;
}

struct RASAMBW
{
    uint      dwSize;
    uint      dwError;
    wchar[17] szNetBiosError;
    ubyte     bLana;
}

struct RASAMBA
{
    uint     dwSize;
    uint     dwError;
    CHAR[17] szNetBiosError;
    ubyte    bLana;
}

struct RASPPPNBFW
{
    uint      dwSize;
    uint      dwError;
    uint      dwNetBiosError;
    wchar[17] szNetBiosError;
    wchar[17] szWorkstationName;
    ubyte     bLana;
}

struct RASPPPNBFA
{
    uint     dwSize;
    uint     dwError;
    uint     dwNetBiosError;
    CHAR[17] szNetBiosError;
    CHAR[17] szWorkstationName;
    ubyte    bLana;
}

struct RASIPXW
{
    uint      dwSize;
    uint      dwError;
    wchar[22] szIpxAddress;
}

struct RASPPPIPXA
{
    uint     dwSize;
    uint     dwError;
    CHAR[22] szIpxAddress;
}

struct RASPPPIPW
{
    uint      dwSize;
    uint      dwError;
    wchar[16] szIpAddress;
    wchar[16] szServerIpAddress;
    uint      dwOptions;
    uint      dwServerOptions;
}

struct RASPPPIPA
{
    uint     dwSize;
    uint     dwError;
    CHAR[16] szIpAddress;
    CHAR[16] szServerIpAddress;
    uint     dwOptions;
    uint     dwServerOptions;
}

struct RASPPPIPV6
{
    uint     dwSize;
    uint     dwError;
    ubyte[8] bLocalInterfaceIdentifier;
    ubyte[8] bPeerInterfaceIdentifier;
    ubyte[2] bLocalCompressionProtocol;
    ubyte[2] bPeerCompressionProtocol;
}

struct RASPPPLCPW
{
    uint        dwSize;
    BOOL        fBundled;
    uint        dwError;
    uint        dwAuthenticationProtocol;
    uint        dwAuthenticationData;
    uint        dwEapTypeId;
    uint        dwServerAuthenticationProtocol;
    uint        dwServerAuthenticationData;
    uint        dwServerEapTypeId;
    BOOL        fMultilink;
    uint        dwTerminateReason;
    uint        dwServerTerminateReason;
    wchar[1024] szReplyMessage;
    uint        dwOptions;
    uint        dwServerOptions;
}

struct RASPPPLCPA
{
    uint       dwSize;
    BOOL       fBundled;
    uint       dwError;
    uint       dwAuthenticationProtocol;
    uint       dwAuthenticationData;
    uint       dwEapTypeId;
    uint       dwServerAuthenticationProtocol;
    uint       dwServerAuthenticationData;
    uint       dwServerEapTypeId;
    BOOL       fMultilink;
    uint       dwTerminateReason;
    uint       dwServerTerminateReason;
    CHAR[1024] szReplyMessage;
    uint       dwOptions;
    uint       dwServerOptions;
}

struct RASPPPCCP
{
    uint dwSize;
    uint dwError;
    uint dwCompressionAlgorithm;
    uint dwOptions;
    uint dwServerCompressionAlgorithm;
    uint dwServerOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasppp_projection_info
struct RASPPP_PROJECTION_INFO
{
    uint     dwIPv4NegotiationError;
    IN_ADDR  ipv4Address;
    IN_ADDR  ipv4ServerAddress;
    uint     dwIPv4Options;
    uint     dwIPv4ServerOptions;
    uint     dwIPv6NegotiationError;
    ubyte[8] bInterfaceIdentifier;
    ubyte[8] bServerInterfaceIdentifier;
    BOOL     fBundled;
    BOOL     fMultilink;
    RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL dwAuthenticationProtocol;
    RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA dwAuthenticationData;
    RASPPP_PROJECTION_INFO_SERVER_AUTH_PROTOCOL dwServerAuthenticationProtocol;
    RASPPP_PROJECTION_INFO_SERVER_AUTH_DATA dwServerAuthenticationData;
    uint     dwEapTypeId;
    uint     dwServerEapTypeId;
    uint     dwLcpOptions;
    uint     dwLcpServerOptions;
    uint     dwCcpError;
    uint     dwCcpCompressionAlgorithm;
    uint     dwCcpServerCompressionAlgorithm;
    uint     dwCcpOptions;
    uint     dwCcpServerOptions;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-rasikev2_projection_info
    struct RASIKEV2_PROJECTION_INFO
    {
        uint      dwIPv4NegotiationError;
        IN_ADDR   ipv4Address;
        IN_ADDR   ipv4ServerAddress;
        uint      dwIPv6NegotiationError;
        IN6_ADDR  ipv6Address;
        IN6_ADDR  ipv6ServerAddress;
        uint      dwPrefixLength;
        uint      dwAuthenticationProtocol;
        uint      dwEapTypeId;
        RASIKEV_PROJECTION_INFO_FLAGS dwFlags;
        uint      dwEncryptionMethod;
        uint      numIPv4ServerAddresses;
        IN_ADDR*  ipv4ServerAddresses;
        uint      numIPv6ServerAddresses;
        IN6_ADDR* ipv6ServerAddresses;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-ras_projection_info
struct RAS_PROJECTION_INFO
{
    RASAPIVERSION version_;
    RASPROJECTION_INFO_TYPE type;
    union
    {
        RASPPP_PROJECTION_INFO ppp;
        RASIKEV2_PROJECTION_INFO ikev2;
    }
}

struct RASDEVINFOW
{
    uint       dwSize;
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
}

struct RASDEVINFOA
{
    uint      dwSize;
    CHAR[17]  szDeviceType;
    CHAR[129] szDeviceName;
}

struct RASCTRYINFO
{
    uint dwSize;
    uint dwCountryID;
    uint dwNextCountryID;
    uint dwCountryCode;
    uint dwCountryNameOffset;
}

struct RASENTRYA
{
    uint               dwSize;
    uint               dwfOptions;
    uint               dwCountryID;
    uint               dwCountryCode;
    CHAR[11]           szAreaCode;
    CHAR[129]          szLocalPhoneNumber;
    uint               dwAlternateOffset;
    RASIPADDR          ipaddr;
    RASIPADDR          ipaddrDns;
    RASIPADDR          ipaddrDnsAlt;
    RASIPADDR          ipaddrWins;
    RASIPADDR          ipaddrWinsAlt;
    uint               dwFrameSize;
    uint               dwfNetProtocols;
    uint               dwFramingProtocol;
    CHAR[260]          szScript;
    CHAR[260]          szAutodialDll;
    CHAR[260]          szAutodialFunc;
    CHAR[17]           szDeviceType;
    CHAR[129]          szDeviceName;
    CHAR[33]           szX25PadType;
    CHAR[201]          szX25Address;
    CHAR[201]          szX25Facilities;
    CHAR[201]          szX25UserData;
    uint               dwChannels;
    uint               dwReserved1;
    uint               dwReserved2;
    uint               dwSubEntries;
    RASENTRY_DIAL_MODE dwDialMode;
    uint               dwDialExtraPercent;
    uint               dwDialExtraSampleSeconds;
    uint               dwHangUpExtraPercent;
    uint               dwHangUpExtraSampleSeconds;
    uint               dwIdleDisconnectSeconds;
    uint               dwType;
    uint               dwEncryptionType;
    uint               dwCustomAuthKey;
    GUID               guidId;
    CHAR[260]          szCustomDialDll;
    uint               dwVpnStrategy;
    uint               dwfOptions2;
    uint               dwfOptions3;
    CHAR[256]          szDnsSuffix;
    uint               dwTcpWindowSize;
    CHAR[260]          szPrerequisitePbk;
    CHAR[257]          szPrerequisiteEntry;
    uint               dwRedialCount;
    uint               dwRedialPause;
    IN6_ADDR           ipv6addrDns;
    IN6_ADDR           ipv6addrDnsAlt;
    uint               dwIPv4InterfaceMetric;
    uint               dwIPv6InterfaceMetric;
    IN6_ADDR           ipv6addr;
    uint               dwIPv6PrefixLength;
    uint               dwNetworkOutageTime;
    CHAR[257]          szIDi;
    CHAR[257]          szIDr;
    BOOL               fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL               fDisableIKEv2Fragmentation;
}

struct RASENTRYW
{
    uint               dwSize;
    uint               dwfOptions;
    uint               dwCountryID;
    uint               dwCountryCode;
    wchar[11]          szAreaCode;
    wchar[129]         szLocalPhoneNumber;
    uint               dwAlternateOffset;
    RASIPADDR          ipaddr;
    RASIPADDR          ipaddrDns;
    RASIPADDR          ipaddrDnsAlt;
    RASIPADDR          ipaddrWins;
    RASIPADDR          ipaddrWinsAlt;
    uint               dwFrameSize;
    uint               dwfNetProtocols;
    uint               dwFramingProtocol;
    wchar[260]         szScript;
    wchar[260]         szAutodialDll;
    wchar[260]         szAutodialFunc;
    wchar[17]          szDeviceType;
    wchar[129]         szDeviceName;
    wchar[33]          szX25PadType;
    wchar[201]         szX25Address;
    wchar[201]         szX25Facilities;
    wchar[201]         szX25UserData;
    uint               dwChannels;
    uint               dwReserved1;
    uint               dwReserved2;
    uint               dwSubEntries;
    RASENTRY_DIAL_MODE dwDialMode;
    uint               dwDialExtraPercent;
    uint               dwDialExtraSampleSeconds;
    uint               dwHangUpExtraPercent;
    uint               dwHangUpExtraSampleSeconds;
    uint               dwIdleDisconnectSeconds;
    uint               dwType;
    uint               dwEncryptionType;
    uint               dwCustomAuthKey;
    GUID               guidId;
    wchar[260]         szCustomDialDll;
    uint               dwVpnStrategy;
    uint               dwfOptions2;
    uint               dwfOptions3;
    wchar[256]         szDnsSuffix;
    uint               dwTcpWindowSize;
    wchar[260]         szPrerequisitePbk;
    wchar[257]         szPrerequisiteEntry;
    uint               dwRedialCount;
    uint               dwRedialPause;
    IN6_ADDR           ipv6addrDns;
    IN6_ADDR           ipv6addrDnsAlt;
    uint               dwIPv4InterfaceMetric;
    uint               dwIPv6InterfaceMetric;
    IN6_ADDR           ipv6addr;
    uint               dwIPv6PrefixLength;
    uint               dwNetworkOutageTime;
    wchar[257]         szIDi;
    wchar[257]         szIDr;
    BOOL               fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL               fDisableIKEv2Fragmentation;
}

struct RASADPARAMS
{
align (4):
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int  xDlg;
    int  yDlg;
}

struct RASSUBENTRYA
{
    uint      dwSize;
    uint      dwfFlags;
    CHAR[17]  szDeviceType;
    CHAR[129] szDeviceName;
    CHAR[129] szLocalPhoneNumber;
    uint      dwAlternateOffset;
}

struct RASSUBENTRYW
{
    uint       dwSize;
    uint       dwfFlags;
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
    wchar[129] szLocalPhoneNumber;
    uint       dwAlternateOffset;
}

struct RASCREDENTIALSA
{
    uint      dwSize;
    uint      dwMask;
    CHAR[257] szUserName;
    CHAR[257] szPassword;
    CHAR[16]  szDomain;
}

struct RASCREDENTIALSW
{
    uint       dwSize;
    uint       dwMask;
    wchar[257] szUserName;
    wchar[257] szPassword;
    wchar[16]  szDomain;
}

struct RASAUTODIALENTRYA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwDialingLocation;
    CHAR[257] szEntry;
}

struct RASAUTODIALENTRYW
{
    uint       dwSize;
    uint       dwFlags;
    uint       dwDialingLocation;
    wchar[257] szEntry;
}

struct RASEAPUSERIDENTITYA
{
    CHAR[257] szUserName;
    uint      dwSizeofEapInfo;
    ubyte[1]  pbEapInfo; // Flexible array
}

struct RASEAPUSERIDENTITYW
{
    wchar[257] szUserName;
    uint       dwSizeofEapInfo;
    ubyte[1]   pbEapInfo; // Flexible array
}

struct RASCOMMSETTINGS
{
    uint  dwSize;
    ubyte bParity;
    ubyte bStop;
    ubyte bByteSize;
    ubyte bAlign;
}

struct RASCUSTOMSCRIPTEXTENSIONS
{
align (4):
    uint dwSize;
    PFNRASSETCOMMSETTINGS pfnRasSetCommSettings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ras/ns-ras-ras_stats
struct RAS_STATS
{
    uint dwSize;
    uint dwBytesXmited;
    uint dwBytesRcved;
    uint dwFramesXmited;
    uint dwFramesRcved;
    uint dwCrcErr;
    uint dwTimeoutErr;
    uint dwAlignmentErr;
    uint dwHardwareOverrunErr;
    uint dwFramingErr;
    uint dwBufferOverrunErr;
    uint dwCompressionRatioIn;
    uint dwCompressionRatioOut;
    uint dwBps;
    uint dwConnectDuration;
}

struct RASUPDATECONN
{
    RASAPIVERSION     version_;
    uint              dwSize;
    uint              dwFlags;
    uint              dwIfIndex;
    RASTUNNELENDPOINT localEndPoint;
    RASTUNNELENDPOINT remoteEndPoint;
}

struct RASNOUSERW
{
    uint       dwSize;
    uint       dwFlags;
    uint       dwTimeoutMs;
    wchar[257] szUserName;
    wchar[257] szPassword;
    wchar[16]  szDomain;
}

struct RASNOUSERA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwTimeoutMs;
    CHAR[257] szUserName;
    CHAR[257] szPassword;
    CHAR[16]  szDomain;
}

version(X86)
{
    struct RASPBDLGW
    {
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCW pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(X86)
{
    struct RASPBDLGA
    {
        uint          dwSize;
        HWND          hwndOwner;
        uint          dwFlags;
        int           xDlg;
        int           yDlg;
        size_t        dwCallbackId;
        RASPBDLGFUNCA pCallback;
        uint          dwError;
        size_t        reserved;
        size_t        reserved2;
    }
}

version(X86)
{
    struct RASENTRYDLGW
    {
        uint       dwSize;
        HWND       hwndOwner;
        uint       dwFlags;
        int        xDlg;
        int        yDlg;
        wchar[257] szEntry;
        uint       dwError;
        size_t     reserved;
        size_t     reserved2;
    }
}

version(X86)
{
    struct RASENTRYDLGA
    {
        uint      dwSize;
        HWND      hwndOwner;
        uint      dwFlags;
        int       xDlg;
        int       yDlg;
        CHAR[257] szEntry;
        uint      dwError;
        size_t    reserved;
        size_t    reserved2;
    }
}

struct RASDIALDLG
{
align (4):
    uint   dwSize;
    HWND   hwndOwner;
    uint   dwFlags;
    int    xDlg;
    int    yDlg;
    uint   dwSubEntry;
    uint   dwError;
    size_t reserved;
    size_t reserved2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_interface_0
struct MPR_INTERFACE_0
{
    wchar[257] wszInterfaceName;
    HANDLE     hInterface;
    BOOL       fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint       fUnReachabilityReasons;
    uint       dwLastError;
}

struct MPR_IPINIP_INTERFACE_0
{
    wchar[257] wszFriendlyName;
    GUID       Guid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_interface_1
struct MPR_INTERFACE_1
{
    wchar[257] wszInterfaceName;
    HANDLE     hInterface;
    BOOL       fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint       fUnReachabilityReasons;
    uint       dwLastError;
    PWSTR      lpwsDialoutHoursRestriction;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_interface_2
struct MPR_INTERFACE_2
{
    wchar[257] wszInterfaceName;
    HANDLE     hInterface;
    BOOL       fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint       fUnReachabilityReasons;
    uint       dwLastError;
    uint       dwfOptions;
    wchar[129] szLocalPhoneNumber;
    PWSTR      szAlternates;
    uint       ipaddr;
    uint       ipaddrDns;
    uint       ipaddrDnsAlt;
    uint       ipaddrWins;
    uint       ipaddrWinsAlt;
    uint       dwfNetProtocols;
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
    wchar[33]  szX25PadType;
    wchar[201] szX25Address;
    wchar[201] szX25Facilities;
    wchar[201] szX25UserData;
    uint       dwChannels;
    uint       dwSubEntries;
    MPR_INTERFACE_DIAL_MODE dwDialMode;
    uint       dwDialExtraPercent;
    uint       dwDialExtraSampleSeconds;
    uint       dwHangUpExtraPercent;
    uint       dwHangUpExtraSampleSeconds;
    uint       dwIdleDisconnectSeconds;
    uint       dwType;
    MPR_ET     dwEncryptionType;
    uint       dwCustomAuthKey;
    uint       dwCustomAuthDataSize;
    ubyte*     lpbCustomAuthData;
    GUID       guidId;
    MPR_VS     dwVpnStrategy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_interface_3
struct MPR_INTERFACE_3
{
    wchar[257] wszInterfaceName;
    HANDLE     hInterface;
    BOOL       fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint       fUnReachabilityReasons;
    uint       dwLastError;
    uint       dwfOptions;
    wchar[129] szLocalPhoneNumber;
    PWSTR      szAlternates;
    uint       ipaddr;
    uint       ipaddrDns;
    uint       ipaddrDnsAlt;
    uint       ipaddrWins;
    uint       ipaddrWinsAlt;
    uint       dwfNetProtocols;
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
    wchar[33]  szX25PadType;
    wchar[201] szX25Address;
    wchar[201] szX25Facilities;
    wchar[201] szX25UserData;
    uint       dwChannels;
    uint       dwSubEntries;
    MPR_INTERFACE_DIAL_MODE dwDialMode;
    uint       dwDialExtraPercent;
    uint       dwDialExtraSampleSeconds;
    uint       dwHangUpExtraPercent;
    uint       dwHangUpExtraSampleSeconds;
    uint       dwIdleDisconnectSeconds;
    uint       dwType;
    MPR_ET     dwEncryptionType;
    uint       dwCustomAuthKey;
    uint       dwCustomAuthDataSize;
    ubyte*     lpbCustomAuthData;
    GUID       guidId;
    MPR_VS     dwVpnStrategy;
    uint       AddressCount;
    IN6_ADDR   ipv6addrDns;
    IN6_ADDR   ipv6addrDnsAlt;
    IN6_ADDR*  ipv6addr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_device_0
struct MPR_DEVICE_0
{
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_device_1
struct MPR_DEVICE_1
{
    wchar[17]  szDeviceType;
    wchar[129] szDeviceName;
    wchar[129] szLocalPhoneNumber;
    PWSTR      szAlternates;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_credentialsex_0
struct MPR_CREDENTIALSEX_0
{
    uint   dwSize;
    ubyte* lpbCredentialsInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_credentialsex_1
struct MPR_CREDENTIALSEX_1
{
    uint   dwSize;
    ubyte* lpbCredentialsInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_transport_0
struct MPR_TRANSPORT_0
{
    uint      dwTransportId;
    HANDLE    hTransport;
    wchar[41] wszTransportName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_iftransport_0
struct MPR_IFTRANSPORT_0
{
    uint      dwTransportId;
    HANDLE    hIfTransport;
    wchar[41] wszIfTransportName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_0
struct MPR_SERVER_0
{
    BOOL fLanOnlyMode;
    uint dwUpTime;
    uint dwTotalPorts;
    uint dwPortsInUse;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_1
struct MPR_SERVER_1
{
    uint dwNumPptpPorts;
    uint dwPptpPortFlags;
    uint dwNumL2tpPorts;
    uint dwL2tpPortFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_2
struct MPR_SERVER_2
{
    uint dwNumPptpPorts;
    uint dwPptpPortFlags;
    uint dwNumL2tpPorts;
    uint dwL2tpPortFlags;
    uint dwNumSstpPorts;
    uint dwSstpPortFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_port_0
struct RAS_PORT_0
{
    HANDLE             hPort;
    HANDLE             hConnection;
    RAS_PORT_CONDITION dwPortCondition;
    uint               dwTotalNumberOfCalls;
    uint               dwConnectDuration;
    wchar[17]          wszPortName;
    wchar[17]          wszMediaName;
    wchar[129]         wszDeviceName;
    wchar[17]          wszDeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_port_1
struct RAS_PORT_1
{
    HANDLE hPort;
    HANDLE hConnection;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint   dwLineSpeed;
    uint   dwBytesXmited;
    uint   dwBytesRcved;
    uint   dwFramesXmited;
    uint   dwFramesRcved;
    uint   dwCrcErr;
    uint   dwTimeoutErr;
    uint   dwAlignmentErr;
    uint   dwHardwareOverrunErr;
    uint   dwFramingErr;
    uint   dwBufferOverrunErr;
    uint   dwCompressionRatioIn;
    uint   dwCompressionRatioOut;
}

struct RAS_PORT_2
{
    HANDLE     hPort;
    HANDLE     hConnection;
    uint       dwConn_State;
    wchar[17]  wszPortName;
    wchar[17]  wszMediaName;
    wchar[129] wszDeviceName;
    wchar[17]  wszDeviceType;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint       dwLineSpeed;
    uint       dwCrcErr;
    uint       dwSerialOverRunErrs;
    uint       dwTimeoutErr;
    uint       dwAlignmentErr;
    uint       dwHardwareOverrunErr;
    uint       dwFramingErr;
    uint       dwBufferOverrunErr;
    uint       dwCompressionRatioIn;
    uint       dwCompressionRatioOut;
    uint       dwTotalErrors;
    ulong      ullBytesXmited;
    ulong      ullBytesRcved;
    ulong      ullFramesXmited;
    ulong      ullFramesRcved;
    ulong      ullBytesTxUncompressed;
    ulong      ullBytesTxCompressed;
    ulong      ullBytesRcvUncompressed;
    ulong      ullBytesRcvCompressed;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_nbfcp_info
struct PPP_NBFCP_INFO
{
    uint      dwError;
    wchar[17] wszWksta;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_ipcp_info
struct PPP_IPCP_INFO
{
    uint      dwError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_ipcp_info2
struct PPP_IPCP_INFO2
{
    uint      dwError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
    uint      dwOptions;
    uint      dwRemoteOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_ipxcp_info
struct PPP_IPXCP_INFO
{
    uint      dwError;
    wchar[23] wszAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_atcp_info
struct PPP_ATCP_INFO
{
    uint      dwError;
    wchar[33] wszAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_ipv6_cp_info
struct PPP_IPV6_CP_INFO
{
    uint     dwVersion;
    uint     dwSize;
    uint     dwError;
    ubyte[8] bInterfaceIdentifier;
    ubyte[8] bRemoteInterfaceIdentifier;
    uint     dwOptions;
    uint     dwRemoteOptions;
    ubyte[8] bPrefix;
    uint     dwPrefixLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_info
struct PPP_INFO
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO  ip;
    PPP_IPXCP_INFO ipx;
    PPP_ATCP_INFO  at;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_ccp_info
struct PPP_CCP_INFO
{
    uint dwError;
    uint dwCompressionAlgorithm;
    uint dwOptions;
    uint dwRemoteCompressionAlgorithm;
    uint dwRemoteOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_lcp_info
struct PPP_LCP_INFO
{
    uint    dwError;
    PPP_LCP dwAuthenticationProtocol;
    PPP_LCP_INFO_AUTH_DATA dwAuthenticationData;
    uint    dwRemoteAuthenticationProtocol;
    uint    dwRemoteAuthenticationData;
    uint    dwTerminateReason;
    uint    dwRemoteTerminateReason;
    uint    dwOptions;
    uint    dwRemoteOptions;
    uint    dwEapTypeId;
    uint    dwRemoteEapTypeId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_info_2
struct PPP_INFO_2
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO2 ip;
    PPP_IPXCP_INFO ipx;
    PPP_ATCP_INFO  at;
    PPP_CCP_INFO   ccp;
    PPP_LCP_INFO   lcp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_info_3
struct PPP_INFO_3
{
    PPP_NBFCP_INFO   nbf;
    PPP_IPCP_INFO2   ip;
    PPP_IPV6_CP_INFO ipv6;
    PPP_CCP_INFO     ccp;
    PPP_LCP_INFO     lcp;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_0
struct RAS_CONNECTION_0
{
    HANDLE     hConnection;
    HANDLE     hInterface;
    uint       dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    RAS_FLAGS  dwConnectionFlags;
    wchar[257] wszInterfaceName;
    wchar[257] wszUserName;
    wchar[16]  wszLogonDomain;
    wchar[17]  wszRemoteComputer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_1
struct RAS_CONNECTION_1
{
    HANDLE   hConnection;
    HANDLE   hInterface;
    PPP_INFO PppInfo;
    uint     dwBytesXmited;
    uint     dwBytesRcved;
    uint     dwFramesXmited;
    uint     dwFramesRcved;
    uint     dwCrcErr;
    uint     dwTimeoutErr;
    uint     dwAlignmentErr;
    uint     dwHardwareOverrunErr;
    uint     dwFramingErr;
    uint     dwBufferOverrunErr;
    uint     dwCompressionRatioIn;
    uint     dwCompressionRatioOut;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_2
struct RAS_CONNECTION_2
{
    HANDLE     hConnection;
    wchar[257] wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    GUID       guid;
    PPP_INFO_2 PppInfo2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_3
struct RAS_CONNECTION_3
{
    uint                 dwVersion;
    uint                 dwSize;
    HANDLE               hConnection;
    wchar[257]           wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    GUID                 guid;
    PPP_INFO_3           PppInfo3;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME             timer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_user_0
struct RAS_USER_0
{
    ubyte      bfPrivilege;
    wchar[129] wszPhoneNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_user_1
struct RAS_USER_1
{
    ubyte      bfPrivilege;
    wchar[129] wszPhoneNumber;
    ubyte      bfPrivilege2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_filter_0
struct MPR_FILTER_0
{
    BOOL fEnable;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mprapi_object_header
struct MPRAPI_OBJECT_HEADER
{
    ubyte  revision;
    ubyte  type;
    ushort size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_projection_info
struct PPP_PROJECTION_INFO
{
    uint      dwIPv4NegotiationError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
    uint      dwIPv4Options;
    uint      dwIPv4RemoteOptions;
    ulong     IPv4SubInterfaceIndex;
    uint      dwIPv6NegotiationError;
    ubyte[8]  bInterfaceIdentifier;
    ubyte[8]  bRemoteInterfaceIdentifier;
    ubyte[8]  bPrefix;
    uint      dwPrefixLength;
    ulong     IPv6SubInterfaceIndex;
    uint      dwLcpError;
    PPP_LCP   dwAuthenticationProtocol;
    PPP_LCP_INFO_AUTH_DATA dwAuthenticationData;
    PPP_LCP   dwRemoteAuthenticationProtocol;
    PPP_LCP_INFO_AUTH_DATA dwRemoteAuthenticationData;
    uint      dwLcpTerminateReason;
    uint      dwLcpRemoteTerminateReason;
    uint      dwLcpOptions;
    uint      dwLcpRemoteOptions;
    uint      dwEapTypeId;
    uint      dwRemoteEapTypeId;
    uint      dwCcpError;
    uint      dwCompressionAlgorithm;
    uint      dwCcpOptions;
    uint      dwRemoteCompressionAlgorithm;
    uint      dwCcpRemoteOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ppp_projection_info2
struct PPP_PROJECTION_INFO2
{
    uint      dwIPv4NegotiationError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
    uint      dwIPv4Options;
    uint      dwIPv4RemoteOptions;
    ulong     IPv4SubInterfaceIndex;
    uint      dwIPv6NegotiationError;
    ubyte[8]  bInterfaceIdentifier;
    ubyte[8]  bRemoteInterfaceIdentifier;
    ubyte[8]  bPrefix;
    uint      dwPrefixLength;
    ulong     IPv6SubInterfaceIndex;
    uint      dwLcpError;
    PPP_LCP   dwAuthenticationProtocol;
    PPP_LCP_INFO_AUTH_DATA dwAuthenticationData;
    PPP_LCP   dwRemoteAuthenticationProtocol;
    PPP_LCP_INFO_AUTH_DATA dwRemoteAuthenticationData;
    uint      dwLcpTerminateReason;
    uint      dwLcpRemoteTerminateReason;
    uint      dwLcpOptions;
    uint      dwLcpRemoteOptions;
    uint      dwEapTypeId;
    uint      dwEmbeddedEAPTypeId;
    uint      dwRemoteEapTypeId;
    uint      dwCcpError;
    uint      dwCompressionAlgorithm;
    uint      dwCcpOptions;
    uint      dwRemoteCompressionAlgorithm;
    uint      dwCcpRemoteOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ikev2_projection_info
struct IKEV2_PROJECTION_INFO
{
    uint      dwIPv4NegotiationError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
    ulong     IPv4SubInterfaceIndex;
    uint      dwIPv6NegotiationError;
    ubyte[8]  bInterfaceIdentifier;
    ubyte[8]  bRemoteInterfaceIdentifier;
    ubyte[8]  bPrefix;
    uint      dwPrefixLength;
    ulong     IPv6SubInterfaceIndex;
    uint      dwOptions;
    uint      dwAuthenticationProtocol;
    uint      dwEapTypeId;
    uint      dwCompressionAlgorithm;
    uint      dwEncryptionMethod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ikev2_projection_info2
struct IKEV2_PROJECTION_INFO2
{
    uint      dwIPv4NegotiationError;
    wchar[16] wszAddress;
    wchar[16] wszRemoteAddress;
    ulong     IPv4SubInterfaceIndex;
    uint      dwIPv6NegotiationError;
    ubyte[8]  bInterfaceIdentifier;
    ubyte[8]  bRemoteInterfaceIdentifier;
    ubyte[8]  bPrefix;
    uint      dwPrefixLength;
    ulong     IPv6SubInterfaceIndex;
    uint      dwOptions;
    uint      dwAuthenticationProtocol;
    uint      dwEapTypeId;
    uint      dwEmbeddedEAPTypeId;
    uint      dwCompressionAlgorithm;
    uint      dwEncryptionMethod;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-projection_info
struct PROJECTION_INFO
{
    ubyte projectionInfoType;
    union
    {
        PPP_PROJECTION_INFO PppProjectionInfo;
        IKEV2_PROJECTION_INFO Ikev2ProjectionInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-projection_info2
struct PROJECTION_INFO2
{
    ubyte projectionInfoType;
    union
    {
        PPP_PROJECTION_INFO2 PppProjectionInfo;
        IKEV2_PROJECTION_INFO2 Ikev2ProjectionInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_ex
struct RAS_CONNECTION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    RAS_FLAGS            dwConnectionFlags;
    wchar[257]           wszInterfaceName;
    wchar[257]           wszUserName;
    wchar[16]            wszLogonDomain;
    wchar[17]            wszRemoteComputer;
    GUID                 guid;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME             probationTime;
    uint                 dwBytesXmited;
    uint                 dwBytesRcved;
    uint                 dwFramesXmited;
    uint                 dwFramesRcved;
    uint                 dwCrcErr;
    uint                 dwTimeoutErr;
    uint                 dwAlignmentErr;
    uint                 dwHardwareOverrunErr;
    uint                 dwFramingErr;
    uint                 dwBufferOverrunErr;
    uint                 dwCompressionRatioIn;
    uint                 dwCompressionRatioOut;
    uint                 dwNumSwitchOvers;
    wchar[65]            wszRemoteEndpointAddress;
    wchar[65]            wszLocalEndpointAddress;
    PROJECTION_INFO      ProjectionInfo;
    HANDLE               hConnection;
    HANDLE               hInterface;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_connection_4
struct RAS_CONNECTION_4
{
    uint                 dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    RAS_FLAGS            dwConnectionFlags;
    wchar[257]           wszInterfaceName;
    wchar[257]           wszUserName;
    wchar[16]            wszLogonDomain;
    wchar[17]            wszRemoteComputer;
    GUID                 guid;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME             probationTime;
    FILETIME             connectionStartTime;
    ulong                ullBytesXmited;
    ulong                ullBytesRcved;
    uint                 dwFramesXmited;
    uint                 dwFramesRcved;
    uint                 dwCrcErr;
    uint                 dwTimeoutErr;
    uint                 dwAlignmentErr;
    uint                 dwHardwareOverrunErr;
    uint                 dwFramingErr;
    uint                 dwBufferOverrunErr;
    uint                 dwCompressionRatioIn;
    uint                 dwCompressionRatioOut;
    uint                 dwNumSwitchOvers;
    wchar[65]            wszRemoteEndpointAddress;
    wchar[65]            wszLocalEndpointAddress;
    PROJECTION_INFO2     ProjectionInfo;
    HANDLE               hConnection;
    HANDLE               hInterface;
    uint                 dwDeviceType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-router_custom_ikev2_policy0
struct ROUTER_CUSTOM_IKEv2_POLICY0
{
    uint dwIntegrityMethod;
    uint dwEncryptionMethod;
    uint dwCipherTransformConstant;
    uint dwAuthTransformConstant;
    uint dwPfsGroup;
    uint dwDhGroup;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-router_ikev2_if_custom_config0
struct ROUTER_IKEv2_IF_CUSTOM_CONFIG0
{
    uint               dwSaLifeTime;
    uint               dwSaDataSize;
    CRYPT_INTEGER_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_if_custominfoex0
struct MPR_IF_CUSTOMINFOEX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG0 customIkev2Config;
}

struct MPR_CERT_EKU
{
    uint  dwSize;
    BOOL  IsEKUOID;
    PWSTR pwszEKU;
}

struct VPN_TS_IP_ADDRESS
{
    ushort Type;
    union
    {
        IN_ADDR  v4;
        IN6_ADDR v6;
    }
}

struct MPR_VPN_TRAFFIC_SELECTOR
{
    MPR_VPN_TS_TYPE   type;
    ubyte             protocolId;
    ushort            portStart;
    ushort            portEnd;
    ushort            tsPayloadId;
    VPN_TS_IP_ADDRESS addrStart;
    VPN_TS_IP_ADDRESS addrEnd;
}

struct MPR_VPN_TRAFFIC_SELECTORS
{
    uint numTsi;
    uint numTsr;
    MPR_VPN_TRAFFIC_SELECTOR* tsI;
    MPR_VPN_TRAFFIC_SELECTOR* tsR;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG2
{
    uint               dwSaLifeTime;
    uint               dwSaDataSize;
    CRYPT_INTEGER_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPT_INTEGER_BLOB certificateHash;
    uint               dwMmSaLifeTime;
    MPR_VPN_TRAFFIC_SELECTORS vpnTrafficSelectors;
}

struct MPR_IF_CUSTOMINFOEX2
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG2 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS4
{
    uint                dwIdleTimeout;
    uint                dwNetworkBlackoutTime;
    uint                dwSaLifeTime;
    uint                dwSaDataSizeForRenegotiation;
    uint                dwConfigOptions;
    uint                dwTotalCertificates;
    CRYPT_INTEGER_BLOB* certificateNames;
    CRYPT_INTEGER_BLOB  machineCertificateName;
    uint                dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint                dwTotalEkus;
    MPR_CERT_EKU*       certificateEKUs;
    CRYPT_INTEGER_BLOB  machineCertificateHash;
    uint                dwMmSaLifeTime;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG1
{
    uint               dwSaLifeTime;
    uint               dwSaDataSize;
    CRYPT_INTEGER_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPT_INTEGER_BLOB certificateHash;
}

struct MPR_IF_CUSTOMINFOEX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG1 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS3
{
    uint                dwIdleTimeout;
    uint                dwNetworkBlackoutTime;
    uint                dwSaLifeTime;
    uint                dwSaDataSizeForRenegotiation;
    uint                dwConfigOptions;
    uint                dwTotalCertificates;
    CRYPT_INTEGER_BLOB* certificateNames;
    CRYPT_INTEGER_BLOB  machineCertificateName;
    uint                dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint                dwTotalEkus;
    MPR_CERT_EKU*       certificateEKUs;
    CRYPT_INTEGER_BLOB  machineCertificateHash;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ikev2_tunnel_config_params2
struct IKEV2_TUNNEL_CONFIG_PARAMS2
{
    uint                dwIdleTimeout;
    uint                dwNetworkBlackoutTime;
    uint                dwSaLifeTime;
    uint                dwSaDataSizeForRenegotiation;
    uint                dwConfigOptions;
    uint                dwTotalCertificates;
    CRYPT_INTEGER_BLOB* certificateNames;
    CRYPT_INTEGER_BLOB  machineCertificateName;
    uint                dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

struct L2TP_TUNNEL_CONFIG_PARAMS2
{
    uint dwIdleTimeout;
    uint dwEncryptionType;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint dwMmSaLifeTime;
}

struct L2TP_TUNNEL_CONFIG_PARAMS1
{
    uint dwIdleTimeout;
    uint dwEncryptionType;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ikev2_config_params
struct IKEV2_CONFIG_PARAMS
{
    uint dwNumPorts;
    uint dwPortFlags;
    uint dwTunnelConfigParamFlags;
    IKEV2_TUNNEL_CONFIG_PARAMS4 TunnelConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-pptp_config_params
struct PPTP_CONFIG_PARAMS
{
    uint dwNumPorts;
    uint dwPortFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-l2tp_config_params1
struct L2TP_CONFIG_PARAMS1
{
    uint dwNumPorts;
    uint dwPortFlags;
    uint dwTunnelConfigParamFlags;
    L2TP_TUNNEL_CONFIG_PARAMS2 TunnelConfigParams;
}

struct GRE_CONFIG_PARAMS0
{
    uint dwNumPorts;
    uint dwPortFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-l2tp_config_params0
struct L2TP_CONFIG_PARAMS0
{
    uint dwNumPorts;
    uint dwPortFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-sstp_cert_info
struct SSTP_CERT_INFO
{
    BOOL               isDefault;
    CRYPT_INTEGER_BLOB certBlob;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-sstp_config_params
struct SSTP_CONFIG_PARAMS
{
    uint           dwNumPorts;
    uint           dwPortFlags;
    BOOL           isUseHttps;
    uint           certAlgorithm;
    SSTP_CERT_INFO sstpCertDetails;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mprapi_tunnel_config_params0
struct MPRAPI_TUNNEL_CONFIG_PARAMS0
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS  SstpConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mprapi_tunnel_config_params1
struct MPRAPI_TUNNEL_CONFIG_PARAMS1
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS  SstpConfigParams;
    GRE_CONFIG_PARAMS0  GREConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_ex0
struct MPR_SERVER_EX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 fLanOnlyMode;
    uint                 dwUpTime;
    uint                 dwTotalPorts;
    uint                 dwPortsInUse;
    uint                 Reserved;
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_ex1
struct MPR_SERVER_EX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 fLanOnlyMode;
    uint                 dwUpTime;
    uint                 dwTotalPorts;
    uint                 dwPortsInUse;
    uint                 Reserved;
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_set_config_ex0
struct MPR_SERVER_SET_CONFIG_EX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mpr_server_set_config_ex1
struct MPR_SERVER_SET_CONFIG_EX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-auth_validation_ex
struct AUTH_VALIDATION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    HANDLE               hRasConnection;
    wchar[257]           wszUserName;
    wchar[16]            wszLogonDomain;
    uint                 AuthInfoSize;
    ubyte[1]             AuthInfo; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-ras_update_connection
struct RAS_UPDATE_CONNECTION
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwIfIndex;
    wchar[65]            wszLocalEndpointAddress;
    wchar[65]            wszRemoteEndpointAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mprapi/ns-mprapi-mprapi_admin_dll_callbacks
struct MPRAPI_ADMIN_DLL_CALLBACKS
{
    ubyte revision;
    PMPRADMINGETIPADDRESSFORUSER lpfnMprAdminGetIpAddressForUser;
    PMPRADMINRELEASEIPADRESS lpfnMprAdminReleaseIpAddress;
    PMPRADMINGETIPV6ADDRESSFORUSER lpfnMprAdminGetIpv6AddressForUser;
    PMPRADMINRELEASEIPV6ADDRESSFORUSER lpfnMprAdminReleaseIpV6AddressForUser;
    PMPRADMINACCEPTNEWLINK lpfnRasAdminAcceptNewLink;
    PMPRADMINLINKHANGUPNOTIFICATION lpfnRasAdminLinkHangupNotification;
    PMPRADMINTERMINATEDLL lpfnRasAdminTerminateDll;
    PMPRADMINACCEPTNEWCONNECTIONEX lpfnRasAdminAcceptNewConnectionEx;
    PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX lpfnRasAdminAcceptEndpointChangeEx;
    PMPRADMINACCEPTREAUTHENTICATIONEX lpfnRasAdminAcceptReauthenticationEx;
    PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX lpfnRasAdminConnectionHangupNotificationEx;
    PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX lpfnRASValidatePreAuthenticatedConnectionEx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rasshost/ns-rasshost-security_message
struct SECURITY_MESSAGE
{
    SECURITY_MESSAGE_MSG_ID dwMsgId;
    ptrdiff_t hPort;
    uint      dwError;
    CHAR[257] UserName;
    CHAR[16]  Domain;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rasshost/ns-rasshost-ras_security_info
struct RAS_SECURITY_INFO
{
    uint      LastError;
    uint      BytesReceived;
    CHAR[129] DeviceName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mgm/ns-mgm-mgm_if_entry
struct MGM_IF_ENTRY
{
    uint dwIfIndex;
    uint dwIfNextHopAddr;
    BOOL bIGMP;
    BOOL bIsEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mgm/ns-mgm-routing_protocol_config
struct ROUTING_PROTOCOL_CONFIG
{
    uint              dwCallbackFlags;
    PMGM_RPF_CALLBACK pfnRpfCallback;
    PMGM_CREATION_ALERT_CALLBACK pfnCreationAlertCallback;
    PMGM_PRUNE_ALERT_CALLBACK pfnPruneAlertCallback;
    PMGM_JOIN_ALERT_CALLBACK pfnJoinAlertCallback;
    PMGM_WRONG_IF_CALLBACK pfnWrongIfCallback;
    PMGM_LOCAL_JOIN_CALLBACK pfnLocalJoinCallback;
    PMGM_LOCAL_LEAVE_CALLBACK pfnLocalLeaveCallback;
    PMGM_DISABLE_IGMP_CALLBACK pfnDisableIgmpCallback;
    PMGM_ENABLE_IGMP_CALLBACK pfnEnableIgmpCallback;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mgm/ns-mgm-source_group_entry
struct SOURCE_GROUP_ENTRY
{
    uint dwSourceAddr;
    uint dwSourceMask;
    uint dwGroupAddr;
    uint dwGroupMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_regn_profile
struct RTM_REGN_PROFILE
{
    uint MaxNextHopsInRoute;
    uint MaxHandlesInEnum;
    uint ViewsSupported;
    uint NumberOfViews;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_net_address
struct RTM_NET_ADDRESS
{
    ushort    AddressFamily;
    ushort    NumBits;
    ubyte[16] AddrBits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_pref_info
struct RTM_PREF_INFO
{
    uint Metric;
    uint Preference;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_nexthop_list
struct RTM_NEXTHOP_LIST
{
    ushort       NumNextHops;
    ptrdiff_t[1] NextHops; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_dest_info
struct RTM_DEST_INFO
{
    ptrdiff_t       DestHandle;
    RTM_NET_ADDRESS DestAddress;
    FILETIME        LastChanged;
    uint            BelongsToViews;
    uint            NumberOfViews;
    struct
    {
        int       ViewId;
        uint      NumRoutes;
        ptrdiff_t Route;
        ptrdiff_t Owner;
        uint      DestFlags;
        ptrdiff_t HoldRoute;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_route_info
struct RTM_ROUTE_INFO
{
    ptrdiff_t        DestHandle;
    ptrdiff_t        RouteOwner;
    ptrdiff_t        Neighbour;
    ubyte            State;
    ubyte            Flags1;
    ushort           Flags;
    RTM_PREF_INFO    PrefInfo;
    uint             BelongsToViews;
    void*            EntitySpecificInfo;
    RTM_NEXTHOP_LIST NextHopsList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_nexthop_info
struct RTM_NEXTHOP_INFO
{
    RTM_NET_ADDRESS NextHopAddress;
    ptrdiff_t       NextHopOwner;
    uint            InterfaceIndex;
    ushort          State;
    ushort          Flags;
    void*           EntitySpecificInfo;
    ptrdiff_t       RemoteNextHop;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_entity_id
struct RTM_ENTITY_ID
{
    union
    {
        struct
        {
            uint EntityProtocolId;
            uint EntityInstanceId;
        }
        ulong EntityId;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_entity_info
struct RTM_ENTITY_INFO
{
    ushort        RtmInstanceId;
    ushort        AddressFamily;
    RTM_ENTITY_ID EntityId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_entity_method_input
struct RTM_ENTITY_METHOD_INPUT
{
    uint     MethodType;
    uint     InputSize;
    ubyte[1] InputData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_entity_method_output
struct RTM_ENTITY_METHOD_OUTPUT
{
    uint     MethodType;
    uint     MethodStatus;
    uint     OutputSize;
    ubyte[1] OutputData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rtmv2/ns-rtmv2-rtm_entity_export_methods
struct RTM_ENTITY_EXPORT_METHODS
{
    uint NumMethods;
    RTM_ENTITY_EXPORT_METHOD[1] Methods; // Flexible array
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasDialA(RASDIALEXTENSIONS* param0, const(PSTR) param1, RASDIALPARAMSA* param2, uint param3, void* param4, 
              HRASCONN* param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasDialW(RASDIALEXTENSIONS* param0, const(PWSTR) param1, RASDIALPARAMSW* param2, uint param3, void* param4, 
              HRASCONN* param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumConnectionsA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RASCONNA* param0, 
                         uint* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumConnectionsW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RASCONNW* param0, 
                         uint* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumEntriesA(const(PSTR) param0, const(PSTR) param1, RASENTRYNAMEA* param2, uint* param3, uint* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumEntriesW(const(PWSTR) param0, const(PWSTR) param1, RASENTRYNAMEW* param2, uint* param3, uint* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetConnectStatusA(HRASCONN param0, RASCONNSTATUSA* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetConnectStatusW(HRASCONN param0, RASCONNSTATUSW* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetErrorStringA(uint ResourceId, PSTR lpszString, uint InBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetErrorStringW(uint ResourceId, PWSTR lpszString, uint InBufSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasHangUpA(HRASCONN param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasHangUpW(HRASCONN param0);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoA(HRASCONN param0, RASPROJECTION param1, void* param2, uint* param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoW(HRASCONN param0, RASPROJECTION param1, void* param2, uint* param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasCreatePhonebookEntryA(HWND param0, const(PSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasCreatePhonebookEntryW(HWND param0, const(PWSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEditPhonebookEntryA(HWND param0, const(PSTR) param1, const(PSTR) param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEditPhonebookEntryW(HWND param0, const(PWSTR) param1, const(PWSTR) param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEntryDialParamsA(const(PSTR) param0, RASDIALPARAMSA* param1, BOOL param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEntryDialParamsW(const(PWSTR) param0, RASDIALPARAMSW* param1, BOOL param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEntryDialParamsA(const(PSTR) param0, RASDIALPARAMSA* param1, BOOL* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEntryDialParamsW(const(PWSTR) param0, RASDIALPARAMSW* param1, BOOL* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumDevicesA(RASDEVINFOA* param0, uint* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumDevicesW(RASDEVINFOW* param0, uint* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCountryInfoA(RASCTRYINFO* param0, uint* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCountryInfoW(RASCTRYINFO* param0, uint* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, RASENTRYA* param2, uint* param3, ubyte* param4, 
                            uint* param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, RASENTRYW* param2, uint* param3, 
                            ubyte* param4, uint* param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, RASENTRYA* param2, uint param3, ubyte* param4, 
                            uint param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, RASENTRYW* param2, uint param3, 
                            ubyte* param4, uint param5);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasRenameEntryA(const(PSTR) param0, const(PSTR) param1, const(PSTR) param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasRenameEntryW(const(PWSTR) param0, const(PWSTR) param1, const(PWSTR) param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasDeleteEntryA(const(PSTR) param0, const(PSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasDeleteEntryW(const(PWSTR) param0, const(PWSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasValidateEntryNameA(const(PSTR) param0, const(PSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasValidateEntryNameW(const(PWSTR) param0, const(PWSTR) param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasConnectionNotificationA(HRASCONN param0, HANDLE param1, uint param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasConnectionNotificationW(HRASCONN param0, HANDLE param1, uint param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetSubEntryHandleA(HRASCONN param0, uint param1, HRASCONN* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetSubEntryHandleW(HRASCONN param0, uint param1, HRASCONN* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCredentialsA(const(PSTR) param0, const(PSTR) param1, RASCREDENTIALSA* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCredentialsW(const(PWSTR) param0, const(PWSTR) param1, RASCREDENTIALSW* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetCredentialsA(const(PSTR) param0, const(PSTR) param1, RASCREDENTIALSA* param2, BOOL param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetCredentialsW(const(PWSTR) param0, const(PWSTR) param1, RASCREDENTIALSW* param2, BOOL param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetSubEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, uint param2, RASSUBENTRYA* param3, 
                               uint* param4, ubyte* param5, uint* param6);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetSubEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, uint param2, RASSUBENTRYW* param3, 
                               uint* param4, ubyte* param5, uint* param6);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetSubEntryPropertiesA(const(PSTR) param0, const(PSTR) param1, uint param2, RASSUBENTRYA* param3, 
                               uint param4, ubyte* param5, uint param6);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetSubEntryPropertiesW(const(PWSTR) param0, const(PWSTR) param1, uint param2, RASSUBENTRYW* param3, 
                               uint param4, ubyte* param5, uint param6);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialAddressA(const(PSTR) param0, uint* param1, RASAUTODIALENTRYA* param2, uint* param3, 
                            uint* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialAddressW(const(PWSTR) param0, uint* param1, RASAUTODIALENTRYW* param2, uint* param3, 
                            uint* param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialAddressA(const(PSTR) param0, uint param1, RASAUTODIALENTRYA* param2, uint param3, uint param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialAddressW(const(PWSTR) param0, uint param1, RASAUTODIALENTRYW* param2, uint param3, uint param4);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumAutodialAddressesA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR* lppRasAutodialAddresses, 
                               uint* lpdwcbRasAutodialAddresses, uint* lpdwcRasAutodialAddresses);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasEnumAutodialAddressesW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PWSTR* lppRasAutodialAddresses, 
                               uint* lpdwcbRasAutodialAddresses, uint* lpdwcRasAutodialAddresses);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialEnableA(uint param0, BOOL* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialEnableW(uint param0, BOOL* param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialEnableA(uint param0, BOOL param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialEnableW(uint param0, BOOL param1);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialParamA(uint param0, void* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetAutodialParamW(uint param0, void* param1, uint* param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialParamA(uint param0, void* param1, uint param2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetAutodialParamW(uint param0, void* param1, uint param2);

@DllImport("RASAPI32.dll")
uint RasGetPCscf(PWSTR lpszPCscf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasInvokeEapUI(HRASCONN param0, uint param1, RASDIALEXTENSIONS* param2, HWND param3);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetLinkStatistics(HRASCONN hRasConn, uint dwSubEntry, RAS_STATS* lpStatistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetConnectionStatistics(HRASCONN hRasConn, RAS_STATS* lpStatistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasClearLinkStatistics(HRASCONN hRasConn, uint dwSubEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasClearConnectionStatistics(HRASCONN hRasConn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEapUserDataA(HANDLE hToken, const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEapUserDataW(HANDLE hToken, const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEapUserDataA(HANDLE hToken, const(PSTR) pszPhonebook, const(PSTR) pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetEapUserDataW(HANDLE hToken, const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCustomAuthDataA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetCustomAuthDataW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetCustomAuthDataA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasSetCustomAuthDataW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEapUserIdentityW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, uint dwFlags, HWND hwnd, 
                            RASEAPUSERIDENTITYW** ppRasEapUserIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
uint RasGetEapUserIdentityA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, uint dwFlags, HWND hwnd, 
                            RASEAPUSERIDENTITYA** ppRasEapUserIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
void RasFreeEapUserIdentityW(RASEAPUSERIDENTITYW* pRasEapUserIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASAPI32.dll")
void RasFreeEapUserIdentityA(RASEAPUSERIDENTITYA* pRasEapUserIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RASAPI32.dll")
uint RasDeleteSubEntryA(const(PSTR) pszPhonebook, const(PSTR) pszEntry, uint dwSubentryId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RASAPI32.dll")
uint RasDeleteSubEntryW(const(PWSTR) pszPhonebook, const(PWSTR) pszEntry, uint dwSubEntryId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("RASAPI32.dll")
uint RasUpdateConnection(HRASCONN hrasconn, RASUPDATECONN* lprasupdateconn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoEx(HRASCONN hrasconn, RAS_PROJECTION_INFO* pRasProjection, uint* lpdwSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasPhonebookDlgA(PSTR lpszPhonebook, PSTR lpszEntry, RASPBDLGA* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasPhonebookDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, RASPBDLGW* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasEntryDlgA(PSTR lpszPhonebook, PSTR lpszEntry, RASENTRYDLGA* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasEntryDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, RASENTRYDLGW* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasDialDlgA(PSTR lpszPhonebook, PSTR lpszEntry, PSTR lpszPhoneNumber, RASDIALDLG* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RASDLG.dll")
BOOL RasDialDlgW(PWSTR lpszPhonebook, PWSTR lpszEntry, PWSTR lpszPhoneNumber, RASDIALDLG* lpInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionEnumEx(ptrdiff_t hRasServer, MPRAPI_OBJECT_HEADER* pObjectHeader, uint dwPreferedMaxLen, 
                              uint* lpdwEntriesRead, uint* lpdwTotalEntries, RAS_CONNECTION_EX** ppRasConn, 
                              uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionGetInfoEx(ptrdiff_t hRasServer, HANDLE hRasConnection, RAS_CONNECTION_EX* pRasConnection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerGetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_EX1* pServerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerSetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_SET_CONFIG_EX1* pServerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerGetInfoEx(HANDLE hMprConfig, MPR_SERVER_EX1* pServerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerSetInfoEx(HANDLE hMprConfig, MPR_SERVER_SET_CONFIG_EX1* pSetServerConfig);

@DllImport("MPRAPI.dll")
uint MprAdminUpdateConnection(ptrdiff_t hRasServer, HANDLE hRasConnection, 
                              RAS_UPDATE_CONNECTION* pRasUpdateConnection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprAdminIsServiceInitialized(PWSTR lpwsServerName, BOOL* fIsServiceInitialized);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2012))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceSetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionEnum(ptrdiff_t hRasServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminPortEnum(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer, 
                      uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminPortGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hPort, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionClearStats(ptrdiff_t hRasServer, HANDLE hRasConnection);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminPortClearStats(ptrdiff_t hRasServer, HANDLE hPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminPortReset(ptrdiff_t hRasServer, HANDLE hPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminPortDisconnect(ptrdiff_t hRasServer, HANDLE hPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminConnectionRemoveQuarantine(HANDLE hRasServer, HANDLE hRasConnection, BOOL fIsIpAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminUserGetInfo(const(PWSTR) lpszServer, const(PWSTR) lpszUser, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminUserSetInfo(const(PWSTR) lpszServer, const(PWSTR) lpszUser, uint dwLevel, const(ubyte)* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminSendUserMessage(ptrdiff_t hMprServer, HANDLE hConnection, PWSTR lpwszMessage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("MPRAPI.dll")
uint MprAdminGetPDCServer(const(PWSTR) lpszDomain, const(PWSTR) lpszServer, PWSTR lpszPDCServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
BOOL MprAdminIsServiceRunning(PWSTR lpwsServerName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerConnect(PWSTR lpwsServerName, ptrdiff_t* phMprServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
void MprAdminServerDisconnect(ptrdiff_t hMprServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerGetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerSetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminBufferFree(void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminGetErrorString(uint dwError, PWSTR* lplpwsErrorString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerGetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprAdminServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprAdminEstablishDomainRasServer(PWSTR pszDomain, PWSTR pszMachine, BOOL bEnable);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprAdminIsDomainRasServer(PWSTR pszDomain, PWSTR pszMachine, BOOL* pbIsRasServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminTransportCreate(ptrdiff_t hMprServer, uint dwTransportId, PWSTR lpwsTransportName, ubyte* pGlobalInfo, 
                             uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, 
                             PWSTR lpwsDLLPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminTransportSetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte* pGlobalInfo, uint dwGlobalInfoSize, 
                              ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminTransportGetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte** ppGlobalInfo, 
                              uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                              uint* lpdwClientInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminDeviceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint* lpdwTotalEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetHandle(ptrdiff_t hMprServer, PWSTR lpwsInterfaceName, HANDLE* phInterface, 
                                BOOL fIncludeClientInterfaces);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceCreate(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer, HANDLE* phInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDelete(ptrdiff_t hMprServer, HANDLE hInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDeviceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte** lplpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDeviceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportRemove(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportAdd(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                   ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                           uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCredentials(PWSTR lpwsServer, PWSTR lpwsInterfaceName, PWSTR lpwsUserName, 
                                     PWSTR lpwsDomainName, PWSTR lpwsPassword);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCredentials(PWSTR lpwsServer, PWSTR lpwsInterfaceName, PWSTR lpwsUserName, 
                                     PWSTR lpwsPassword, PWSTR lpwsDomainName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceConnect(ptrdiff_t hMprServer, HANDLE hInterface, HANDLE hEvent, BOOL fSynchronous);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDisconnect(ptrdiff_t hMprServer, HANDLE hInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceUpdateRoutes(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, HANDLE hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceQueryUpdateResult(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, 
                                        uint* lpdwUpdateResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminInterfaceUpdatePhonebookInfo(ptrdiff_t hMprServer, HANDLE hInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminRegisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminDeregisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBServerConnect(PWSTR lpwsServerName, ptrdiff_t* phMibServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
void MprAdminMIBServerDisconnect(ptrdiff_t hMibServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryCreate(ptrdiff_t hMibServer, uint dwPid, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryDelete(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                            uint dwEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntrySet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                         uint dwEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                         uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGetFirst(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                              uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGetNext(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                             uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprAdminMIBBufferFree(void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerInstall(uint dwLevel, void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerConnect(PWSTR lpwsServerName, HANDLE* phMprConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
void MprConfigServerDisconnect(HANDLE hMprConfig);

@DllImport("MPRAPI.dll")
uint MprConfigServerRefresh(HANDLE hMprConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigBufferFree(void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerGetInfo(HANDLE hMprConfig, uint dwLevel, ubyte** lplpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerBackup(HANDLE hMprConfig, PWSTR lpwsPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigServerRestore(HANDLE hMprConfig, PWSTR lpwsPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportCreate(HANDLE hMprConfig, uint dwTransportId, PWSTR lpwsTransportName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pGlobalInfo, 
                              uint dwGlobalInfoSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ubyte* pClientInterfaceInfo, 
                              uint dwClientInterfaceInfoSize, PWSTR lpwsDLLPath, HANDLE* phRouterTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportDelete(HANDLE hMprConfig, HANDLE hRouterTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportGetHandle(HANDLE hMprConfig, uint dwTransportId, HANDLE* phRouterTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pGlobalInfo, 
                               uint dwGlobalInfoSize, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pClientInterfaceInfo, 
                               uint dwClientInterfaceInfoSize, PWSTR lpwsDLLPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, ubyte** ppGlobalInfo, 
                               uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                               uint* lpdwClientInterfaceInfoSize, PWSTR* lplpwsDLLPath);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigTransportEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceCreate(HANDLE hMprConfig, uint dwLevel, ubyte* lpbBuffer, HANDLE* phRouterInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceDelete(HANDLE hMprConfig, HANDLE hRouterInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetHandle(HANDLE hMprConfig, PWSTR lpwsInterfaceName, HANDLE* phRouterInterface);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                               uint* lpdwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte* lpbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportAdd(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                    PWSTR lpwsTransportName, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ubyte* pInterfaceInfo, 
                                    uint dwInterfaceInfoSize, HANDLE* phRouterIfTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportRemove(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportGetHandle(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                          HANDLE* phRouterIfTransport);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pInterfaceInfo, 
                                        uint dwInterfaceInfoSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportEnum(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                                     uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, 
                                     uint* lpdwResumeHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigGetFriendlyName(HANDLE hMprConfig, PWSTR pszGuidName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pszBuffer, 
                              uint dwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprConfigGetGuidName(HANDLE hMprConfig, PWSTR pszFriendlyName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR pszBuffer, 
                          uint dwBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprConfigFilterGetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
@DllImport("MPRAPI.dll")
uint MprConfigFilterSetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoCreate(uint dwVersion, void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoDelete(void* lpHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoRemoveAll(void* lpHeader, void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoDuplicate(void* lpHeader, void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoBlockAdd(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, ubyte* lpItemData, 
                     void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoBlockRemove(void* lpHeader, uint dwInfoType, void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoBlockSet(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, ubyte* lpItemData, 
                     void** lplpNewHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoBlockFind(void* lpHeader, uint dwInfoType, uint* lpdwItemSize, uint* lpdwItemCount, 
                      ubyte** lplpItemData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("MPRAPI.dll")
uint MprInfoBlockQuerySize(void* lpHeader);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmRegisterMProtocol(ROUTING_PROTOCOL_CONFIG* prpiInfo, uint dwProtocolId, uint dwComponentId, 
                          HANDLE* phProtocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmDeRegisterMProtocol(HANDLE hProtocol);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmTakeInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmReleaseInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetProtocolOnInterface(uint dwIfIndex, uint dwIfNextHopAddr, uint* pdwIfProtocolId, uint* pdwIfComponentId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmAddGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmDeleteGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                   uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetMfe(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetFirstMfe(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetNextMfe(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetMfeStats(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetFirstMfeStats(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGetNextMfeStats(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, 
                        uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGroupEnumerationStart(HANDLE hProtocol, MGM_ENUM_TYPES metEnumType, HANDLE* phEnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGroupEnumerationGetNext(HANDLE hEnum, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint MgmGroupEnumerationEnd(HANDLE hEnum);

@DllImport("rtm.dll")
uint RtmConvertNetAddressToIpv6AddressAndLength(RTM_NET_ADDRESS* pNetAddress, IN6_ADDR* pAddress, uint* pLength, 
                                                uint dwAddressSize);

@DllImport("rtm.dll")
uint RtmConvertIpv6AddressAndLengthToNetAddress(RTM_NET_ADDRESS* pNetAddress, IN6_ADDR Address, uint dwLength, 
                                                uint dwAddressSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmRegisterEntity(RTM_ENTITY_INFO* RtmEntityInfo, RTM_ENTITY_EXPORT_METHODS* ExportMethods, 
                       RTM_EVENT_CALLBACK EventCallback, BOOL ReserveOpaquePointer, RTM_REGN_PROFILE* RtmRegProfile, 
                       ptrdiff_t* RtmRegHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeregisterEntity(ptrdiff_t RtmRegHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetRegisteredEntities(ptrdiff_t RtmRegHandle, uint* NumEntities, ptrdiff_t* EntityHandles, 
                              RTM_ENTITY_INFO* EntityInfos);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseEntities(ptrdiff_t RtmRegHandle, uint NumEntities, ptrdiff_t* EntityHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmLockDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, BOOL Exclusive, BOOL LockDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetOpaqueInformationPointer(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, void** OpaqueInfoPointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetEntityMethods(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, uint* NumMethods, 
                         RTM_ENTITY_EXPORT_METHOD* ExptMethods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmInvokeMethod(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_METHOD_INPUT* Input, 
                     uint* OutputSize, RTM_ENTITY_METHOD_OUTPUT* Output);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmBlockMethods(ptrdiff_t RtmRegHandle, HANDLE TargetHandle, ubyte TargetType, uint BlockingFlag);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetEntityInfo(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_INFO* EntityInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetDestInfo(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                    RTM_DEST_INFO* DestInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetRouteInfo(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO* RouteInfo, 
                     RTM_NET_ADDRESS* DestAddress);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetNextHopInfo(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseEntityInfo(ptrdiff_t RtmRegHandle, RTM_ENTITY_INFO* EntityInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseDestInfo(ptrdiff_t RtmRegHandle, RTM_DEST_INFO* DestInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseRouteInfo(ptrdiff_t RtmRegHandle, RTM_ROUTE_INFO* RouteInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseNextHopInfo(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmAddRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteHandle, RTM_NET_ADDRESS* DestAddress, 
                       RTM_ROUTE_INFO* RouteInfo, uint TimeToLive, ptrdiff_t RouteListHandle, uint NotifyType, 
                       ptrdiff_t NotifyHandle, uint* ChangeFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeleteRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* ChangeFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmHoldDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint HoldTime);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetRoutePointer(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO** RoutePointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmLockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, BOOL Exclusive, BOOL LockRoute, 
                  RTM_ROUTE_INFO** RoutePointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmUpdateAndUnlockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint TimeToLive, 
                             ptrdiff_t RouteListHandle, uint NotifyType, ptrdiff_t NotifyHandle, uint* ChangeFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetExactMatchDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                 uint TargetViews, RTM_DEST_INFO* DestInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetMostSpecificDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                   uint TargetViews, RTM_DEST_INFO* DestInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetLessSpecificDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                                   RTM_DEST_INFO* DestInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetExactMatchRoute(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint MatchingFlags, 
                           RTM_ROUTE_INFO* RouteInfo, uint InterfaceIndex, uint TargetViews, ptrdiff_t* RouteHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmIsBestRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* BestInViews);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmAddNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                   uint* ChangeFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmFindNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeleteNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetNextHopPointer(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO** NextHopPointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmLockNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, BOOL Exclusive, BOOL LockNextHop, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmCreateDestEnum(ptrdiff_t RtmRegHandle, uint TargetViews, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                       uint ProtocolId, ptrdiff_t* RtmEnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetEnumDests(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumDests, RTM_DEST_INFO* DestInfos);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseDests(ptrdiff_t RtmRegHandle, uint NumDests, RTM_DEST_INFO* DestInfos);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmCreateRouteEnum(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint EnumFlags, 
                        RTM_NET_ADDRESS* StartDest, uint MatchingFlags, RTM_ROUTE_INFO* CriteriaRoute, 
                        uint CriteriaInterface, ptrdiff_t* RtmEnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, ptrdiff_t* RouteHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseRoutes(ptrdiff_t RtmRegHandle, uint NumRoutes, ptrdiff_t* RouteHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmCreateNextHopEnum(ptrdiff_t RtmRegHandle, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                          ptrdiff_t* RtmEnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetEnumNextHops(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumNextHops, ptrdiff_t* NextHopHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseNextHops(ptrdiff_t RtmRegHandle, uint NumNextHops, ptrdiff_t* NextHopHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeleteEnumHandle(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmRegisterForChangeNotification(ptrdiff_t RtmRegHandle, uint TargetViews, uint NotifyFlags, 
                                      void* NotifyContext, ptrdiff_t* NotifyHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint* NumDests, 
                        RTM_DEST_INFO* ChangedDests);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReleaseChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, 
                            RTM_DEST_INFO* ChangedDests);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmIgnoreChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, ptrdiff_t* ChangedDests);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetChangeStatus(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, BOOL* ChangeStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmMarkDestForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      BOOL MarkDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmIsMarkedForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      BOOL* DestMarked);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeregisterFromChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmCreateRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteListHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmInsertInRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, uint NumRoutes, 
                          ptrdiff_t* RouteHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmCreateRouteListEnum(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, ptrdiff_t* RtmEnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmGetListEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, ptrdiff_t* RouteHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmDeleteRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2000))], [])
@DllImport("rtm.dll")
uint RtmReferenceHandles(ptrdiff_t RtmRegHandle, uint NumHandles, HANDLE* RtmHandles);


