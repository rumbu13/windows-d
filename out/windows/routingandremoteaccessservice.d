module windows.routingandremoteaccessservice;

public import windows.core;
public import windows.kernel : LUID;
public import windows.mib : MIB_IPMCAST_MFE;
public import windows.security : CRYPTOAPI_BLOB;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.winsock : in6_addr, in_addr;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    RASAPIVERSION_500 = 0x00000001,
    RASAPIVERSION_501 = 0x00000002,
    RASAPIVERSION_600 = 0x00000003,
    RASAPIVERSION_601 = 0x00000004,
}
alias RASAPIVERSION = int;

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
alias tagRASCONNSTATE = int;

enum : int
{
    RASCSS_None         = 0x00000000,
    RASCSS_Dormant      = 0x00000001,
    RASCSS_Reconnecting = 0x00000002,
    RASCSS_Reconnected  = 0x00002000,
}
alias tagRASCONNSUBSTATE = int;

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
alias tagRASPROJECTION = int;

enum : int
{
    PROJECTION_INFO_TYPE_PPP   = 0x00000001,
    PROJECTION_INFO_TYPE_IKEv2 = 0x00000002,
}
alias RASPROJECTION_INFO_TYPE = int;

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
alias IKEV2_ID_PAYLOAD_TYPE = int;

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
alias ROUTER_INTERFACE_TYPE = int;

enum : int
{
    ROUTER_IF_STATE_UNREACHABLE  = 0x00000000,
    ROUTER_IF_STATE_DISCONNECTED = 0x00000001,
    ROUTER_IF_STATE_CONNECTING   = 0x00000002,
    ROUTER_IF_STATE_CONNECTED    = 0x00000003,
}
alias ROUTER_CONNECTION_STATE = int;

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
alias RAS_PORT_CONDITION = int;

enum : int
{
    RAS_HARDWARE_OPERATIONAL = 0x00000000,
    RAS_HARDWARE_FAILURE     = 0x00000001,
}
alias RAS_HARDWARE_CONDITION = int;

enum : int
{
    RAS_QUAR_STATE_NORMAL      = 0x00000000,
    RAS_QUAR_STATE_QUARANTINE  = 0x00000001,
    RAS_QUAR_STATE_PROBATION   = 0x00000002,
    RAS_QUAR_STATE_NOT_CAPABLE = 0x00000003,
}
alias RAS_QUARANTINE_STATE = int;

enum : int
{
    MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT        = 0x00000001,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT            = 0x00000002,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT = 0x00000003,
    MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT       = 0x00000004,
    MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT     = 0x00000005,
    MPRAPI_OBJECT_TYPE_IF_CUSTOM_CONFIG_OBJECT      = 0x00000006,
}
alias MPRAPI_OBJECT_TYPE = int;

enum : int
{
    MPR_VPN_TS_IPv4_ADDR_RANGE = 0x00000007,
    MPR_VPN_TS_IPv6_ADDR_RANGE = 0x00000008,
}
alias MPR_VPN_TS_TYPE = int;

enum : int
{
    ANY_SOURCE  = 0x00000000,
    ALL_SOURCES = 0x00000001,
}
alias MGM_ENUM_TYPES = int;

enum : int
{
    RTM_ENTITY_REGISTERED   = 0x00000000,
    RTM_ENTITY_DEREGISTERED = 0x00000001,
    RTM_ROUTE_EXPIRED       = 0x00000002,
    RTM_CHANGE_NOTIFICATION = 0x00000003,
}
alias RTM_EVENT_TYPE = int;

// Callbacks

alias RASDIALFUNC = void function(uint param0, tagRASCONNSTATE param1, uint param2);
alias RASDIALFUNC1 = void function(HRASCONN__* param0, uint param1, tagRASCONNSTATE param2, uint param3, 
                                   uint param4);
alias RASDIALFUNC2 = uint function(size_t param0, uint param1, HRASCONN__* param2, uint param3, 
                                   tagRASCONNSTATE param4, uint param5, uint param6);
alias ORASADFUNC = BOOL function(HWND param0, const(char)* param1, uint param2, uint* param3);
alias RASADFUNCA = BOOL function(const(char)* param0, const(char)* param1, tagRASADPARAMS* param2, uint* param3);
alias RASADFUNCW = BOOL function(const(wchar)* param0, const(wchar)* param1, tagRASADPARAMS* param2, uint* param3);
alias PFNRASGETBUFFER = uint function(ubyte** ppBuffer, uint* pdwSize);
alias PFNRASFREEBUFFER = uint function(ubyte* pBufer);
alias PFNRASSENDBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint dwSize);
alias PFNRASRECEIVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize, uint dwTimeOut, 
                                          HANDLE hEvent);
alias PFNRASRETRIEVEBUFFER = uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize);
alias RasCustomScriptExecuteFn = uint function(HANDLE hPort, const(wchar)* lpszPhonebook, 
                                               const(wchar)* lpszEntryName, PFNRASGETBUFFER pfnRasGetBuffer, 
                                               PFNRASFREEBUFFER pfnRasFreeBuffer, PFNRASSENDBUFFER pfnRasSendBuffer, 
                                               PFNRASRECEIVEBUFFER pfnRasReceiveBuffer, 
                                               PFNRASRETRIEVEBUFFER pfnRasRetrieveBuffer, HWND hWnd, 
                                               tagRASDIALPARAMSA* pRasDialParams, void* pvReserved);
alias PFNRASSETCOMMSETTINGS = uint function(HANDLE hPort, tagRASCOMMSETTINGS* pRasCommSettings, void* pvReserved);
alias RasCustomHangUpFn = uint function(HRASCONN__* hRasConn);
alias RasCustomDialFn = uint function(HINSTANCE hInstDll, tagRASDIALEXTENSIONS* lpRasDialExtensions, 
                                      const(wchar)* lpszPhonebook, tagRASDIALPARAMSA* lpRasDialParams, 
                                      uint dwNotifierType, void* lpvNotifier, HRASCONN__** lphRasConn, uint dwFlags);
alias RasCustomDeleteEntryNotifyFn = uint function(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, 
                                                   uint dwFlags);
alias RASPBDLGFUNCW = void function(size_t param0, uint param1, const(wchar)* param2, void* param3);
alias RASPBDLGFUNCA = void function(size_t param0, uint param1, const(char)* param2, void* param3);
alias RasCustomDialDlgFn = BOOL function(HINSTANCE hInstDll, uint dwFlags, const(wchar)* lpszPhonebook, 
                                         const(wchar)* lpszEntry, const(wchar)* lpszPhoneNumber, 
                                         tagRASDIALDLG* lpInfo, void* pvInfo);
alias RasCustomEntryDlgFn = BOOL function(HINSTANCE hInstDll, const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, 
                                          tagRASENTRYDLGA* lpInfo, uint dwFlags);
alias PMPRADMINGETIPADDRESSFORUSER = uint function(ushort* param0, ushort* param1, uint* param2, int* param3);
alias PMPRADMINRELEASEIPADRESS = void function(ushort* param0, ushort* param1, uint* param2);
alias PMPRADMINGETIPV6ADDRESSFORUSER = uint function(ushort* param0, ushort* param1, in6_addr* param2, int* param3);
alias PMPRADMINRELEASEIPV6ADDRESSFORUSER = void function(ushort* param0, ushort* param1, in6_addr* param2);
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
                                                             RAS_CONNECTION_2* param2, RAS_CONNECTION_3 param3);
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
alias _EVENT_CALLBACK = uint function(ptrdiff_t RtmRegHandle, RTM_EVENT_TYPE EventType, void* Context1, 
                                      void* Context2);
alias RTM_EVENT_CALLBACK = uint function();
alias PRTM_EVENT_CALLBACK = uint function();
alias _ENTITY_METHOD = void function(ptrdiff_t CallerHandle, ptrdiff_t CalleeHandle, 
                                     RTM_ENTITY_METHOD_INPUT* Input, RTM_ENTITY_METHOD_OUTPUT* Output);
alias RTM_ENTITY_EXPORT_METHOD = void function();
alias PRTM_ENTITY_EXPORT_METHOD = void function();

// Structs


struct RASIPADDR
{
    ubyte a;
    ubyte b;
    ubyte c;
    ubyte d;
}

struct tagRASTUNNELENDPOINT
{
    uint dwType;
    union
    {
        in_addr  ipv4;
        in6_addr ipv6;
    }
}

struct HRASCONN__
{
    int unused;
}

struct tagRASCONNW
{
    uint        dwSize;
    HRASCONN__* hrasconn;
    ushort[257] szEntryName;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[260] szPhonebook;
    uint        dwSubEntry;
    GUID        guidEntry;
    uint        dwFlags;
    LUID        luid;
    GUID        guidCorrelationId;
}

struct tagRASCONNA
{
    uint        dwSize;
    HRASCONN__* hrasconn;
    byte[257]   szEntryName;
    byte[17]    szDeviceType;
    byte[129]   szDeviceName;
    byte[260]   szPhonebook;
    uint        dwSubEntry;
    GUID        guidEntry;
    uint        dwFlags;
    LUID        luid;
    GUID        guidCorrelationId;
}

struct tagRASCONNSTATUSW
{
    uint                 dwSize;
    tagRASCONNSTATE      rasconnstate;
    uint                 dwError;
    ushort[17]           szDeviceType;
    ushort[129]          szDeviceName;
    ushort[129]          szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE   rasconnsubstate;
}

struct tagRASCONNSTATUSA
{
    uint                 dwSize;
    tagRASCONNSTATE      rasconnstate;
    uint                 dwError;
    byte[17]             szDeviceType;
    byte[129]            szDeviceName;
    byte[129]            szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE   rasconnsubstate;
}

struct tagRASDIALPARAMSW
{
    uint          dwSize;
    ushort[257]   szEntryName;
    ushort[129]   szPhoneNumber;
    ushort[129]   szCallbackNumber;
    ushort[257]   szUserName;
    ushort[257]   szPassword;
    ushort[16]    szDomain;
    uint          dwSubEntry;
    size_t        dwCallbackId;
    uint          dwIfIndex;
    const(wchar)* szEncPassword;
}

struct tagRASDIALPARAMSA
{
    uint         dwSize;
    byte[257]    szEntryName;
    byte[129]    szPhoneNumber;
    byte[129]    szCallbackNumber;
    byte[257]    szUserName;
    byte[257]    szPassword;
    byte[16]     szDomain;
    uint         dwSubEntry;
    size_t       dwCallbackId;
    uint         dwIfIndex;
    const(char)* szEncPassword;
}

struct tagRASEAPINFO
{
    uint   dwSizeofEapInfo;
    ubyte* pbEapInfo;
}

struct RASDEVSPECIFICINFO
{
    uint   dwSize;
    ubyte* pbDevSpecificInfo;
}

struct tagRASDIALEXTENSIONS
{
    uint               dwSize;
    uint               dwfOptions;
    HWND               hwndParent;
    size_t             reserved;
    size_t             reserved1;
    tagRASEAPINFO      RasEapInfo;
    BOOL               fSkipPppAuth;
    RASDEVSPECIFICINFO RasDevSpecificInfo;
}

struct tagRASENTRYNAMEW
{
    uint        dwSize;
    ushort[257] szEntryName;
    uint        dwFlags;
    ushort[261] szPhonebookPath;
}

struct tagRASENTRYNAMEA
{
    uint      dwSize;
    byte[257] szEntryName;
    uint      dwFlags;
    byte[261] szPhonebookPath;
}

struct tagRASAMBW
{
    uint       dwSize;
    uint       dwError;
    ushort[17] szNetBiosError;
    ubyte      bLana;
}

struct tagRASAMBA
{
    uint     dwSize;
    uint     dwError;
    byte[17] szNetBiosError;
    ubyte    bLana;
}

struct tagRASPPPNBFW
{
    uint       dwSize;
    uint       dwError;
    uint       dwNetBiosError;
    ushort[17] szNetBiosError;
    ushort[17] szWorkstationName;
    ubyte      bLana;
}

struct tagRASPPPNBFA
{
    uint     dwSize;
    uint     dwError;
    uint     dwNetBiosError;
    byte[17] szNetBiosError;
    byte[17] szWorkstationName;
    ubyte    bLana;
}

struct tagRASIPXW
{
    uint       dwSize;
    uint       dwError;
    ushort[22] szIpxAddress;
}

struct tagRASPPPIPXA
{
    uint     dwSize;
    uint     dwError;
    byte[22] szIpxAddress;
}

struct tagRASPPPIPW
{
    uint       dwSize;
    uint       dwError;
    ushort[16] szIpAddress;
    ushort[16] szServerIpAddress;
    uint       dwOptions;
    uint       dwServerOptions;
}

struct tagRASPPPIPA
{
    uint     dwSize;
    uint     dwError;
    byte[16] szIpAddress;
    byte[16] szServerIpAddress;
    uint     dwOptions;
    uint     dwServerOptions;
}

struct tagRASPPPIPV6
{
    uint     dwSize;
    uint     dwError;
    ubyte[8] bLocalInterfaceIdentifier;
    ubyte[8] bPeerInterfaceIdentifier;
    ubyte[2] bLocalCompressionProtocol;
    ubyte[2] bPeerCompressionProtocol;
}

struct tagRASPPPLCPW
{
    uint         dwSize;
    BOOL         fBundled;
    uint         dwError;
    uint         dwAuthenticationProtocol;
    uint         dwAuthenticationData;
    uint         dwEapTypeId;
    uint         dwServerAuthenticationProtocol;
    uint         dwServerAuthenticationData;
    uint         dwServerEapTypeId;
    BOOL         fMultilink;
    uint         dwTerminateReason;
    uint         dwServerTerminateReason;
    ushort[1024] szReplyMessage;
    uint         dwOptions;
    uint         dwServerOptions;
}

struct tagRASPPPLCPA
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
    byte[1024] szReplyMessage;
    uint       dwOptions;
    uint       dwServerOptions;
}

struct tagRASPPPCCP
{
    uint dwSize;
    uint dwError;
    uint dwCompressionAlgorithm;
    uint dwOptions;
    uint dwServerCompressionAlgorithm;
    uint dwServerOptions;
}

struct RASPPP_PROJECTION_INFO
{
    uint     dwIPv4NegotiationError;
    in_addr  ipv4Address;
    in_addr  ipv4ServerAddress;
    uint     dwIPv4Options;
    uint     dwIPv4ServerOptions;
    uint     dwIPv6NegotiationError;
    ubyte[8] bInterfaceIdentifier;
    ubyte[8] bServerInterfaceIdentifier;
    BOOL     fBundled;
    BOOL     fMultilink;
    uint     dwAuthenticationProtocol;
    uint     dwAuthenticationData;
    uint     dwServerAuthenticationProtocol;
    uint     dwServerAuthenticationData;
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

struct RASIKEV2_PROJECTION_INFO
{
    uint      dwIPv4NegotiationError;
    in_addr   ipv4Address;
    in_addr   ipv4ServerAddress;
    uint      dwIPv6NegotiationError;
    in6_addr  ipv6Address;
    in6_addr  ipv6ServerAddress;
    uint      dwPrefixLength;
    uint      dwAuthenticationProtocol;
    uint      dwEapTypeId;
    uint      dwFlags;
    uint      dwEncryptionMethod;
    uint      numIPv4ServerAddresses;
    in_addr*  ipv4ServerAddresses;
    uint      numIPv6ServerAddresses;
    in6_addr* ipv6ServerAddresses;
}

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

struct tagRASDEVINFOW
{
    uint        dwSize;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
}

struct tagRASDEVINFOA
{
    uint      dwSize;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
}

struct RASCTRYINFO
{
    uint dwSize;
    uint dwCountryID;
    uint dwNextCountryID;
    uint dwCountryCode;
    uint dwCountryNameOffset;
}

struct tagRASENTRYA
{
    uint      dwSize;
    uint      dwfOptions;
    uint      dwCountryID;
    uint      dwCountryCode;
    byte[11]  szAreaCode;
    byte[129] szLocalPhoneNumber;
    uint      dwAlternateOffset;
    RASIPADDR ipaddr;
    RASIPADDR ipaddrDns;
    RASIPADDR ipaddrDnsAlt;
    RASIPADDR ipaddrWins;
    RASIPADDR ipaddrWinsAlt;
    uint      dwFrameSize;
    uint      dwfNetProtocols;
    uint      dwFramingProtocol;
    byte[260] szScript;
    byte[260] szAutodialDll;
    byte[260] szAutodialFunc;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
    byte[33]  szX25PadType;
    byte[201] szX25Address;
    byte[201] szX25Facilities;
    byte[201] szX25UserData;
    uint      dwChannels;
    uint      dwReserved1;
    uint      dwReserved2;
    uint      dwSubEntries;
    uint      dwDialMode;
    uint      dwDialExtraPercent;
    uint      dwDialExtraSampleSeconds;
    uint      dwHangUpExtraPercent;
    uint      dwHangUpExtraSampleSeconds;
    uint      dwIdleDisconnectSeconds;
    uint      dwType;
    uint      dwEncryptionType;
    uint      dwCustomAuthKey;
    GUID      guidId;
    byte[260] szCustomDialDll;
    uint      dwVpnStrategy;
    uint      dwfOptions2;
    uint      dwfOptions3;
    byte[256] szDnsSuffix;
    uint      dwTcpWindowSize;
    byte[260] szPrerequisitePbk;
    byte[257] szPrerequisiteEntry;
    uint      dwRedialCount;
    uint      dwRedialPause;
    in6_addr  ipv6addrDns;
    in6_addr  ipv6addrDnsAlt;
    uint      dwIPv4InterfaceMetric;
    uint      dwIPv6InterfaceMetric;
    in6_addr  ipv6addr;
    uint      dwIPv6PrefixLength;
    uint      dwNetworkOutageTime;
    byte[257] szIDi;
    byte[257] szIDr;
    BOOL      fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL      fDisableIKEv2Fragmentation;
}

struct tagRASENTRYW
{
    uint        dwSize;
    uint        dwfOptions;
    uint        dwCountryID;
    uint        dwCountryCode;
    ushort[11]  szAreaCode;
    ushort[129] szLocalPhoneNumber;
    uint        dwAlternateOffset;
    RASIPADDR   ipaddr;
    RASIPADDR   ipaddrDns;
    RASIPADDR   ipaddrDnsAlt;
    RASIPADDR   ipaddrWins;
    RASIPADDR   ipaddrWinsAlt;
    uint        dwFrameSize;
    uint        dwfNetProtocols;
    uint        dwFramingProtocol;
    ushort[260] szScript;
    ushort[260] szAutodialDll;
    ushort[260] szAutodialFunc;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[33]  szX25PadType;
    ushort[201] szX25Address;
    ushort[201] szX25Facilities;
    ushort[201] szX25UserData;
    uint        dwChannels;
    uint        dwReserved1;
    uint        dwReserved2;
    uint        dwSubEntries;
    uint        dwDialMode;
    uint        dwDialExtraPercent;
    uint        dwDialExtraSampleSeconds;
    uint        dwHangUpExtraPercent;
    uint        dwHangUpExtraSampleSeconds;
    uint        dwIdleDisconnectSeconds;
    uint        dwType;
    uint        dwEncryptionType;
    uint        dwCustomAuthKey;
    GUID        guidId;
    ushort[260] szCustomDialDll;
    uint        dwVpnStrategy;
    uint        dwfOptions2;
    uint        dwfOptions3;
    ushort[256] szDnsSuffix;
    uint        dwTcpWindowSize;
    ushort[260] szPrerequisitePbk;
    ushort[257] szPrerequisiteEntry;
    uint        dwRedialCount;
    uint        dwRedialPause;
    in6_addr    ipv6addrDns;
    in6_addr    ipv6addrDnsAlt;
    uint        dwIPv4InterfaceMetric;
    uint        dwIPv6InterfaceMetric;
    in6_addr    ipv6addr;
    uint        dwIPv6PrefixLength;
    uint        dwNetworkOutageTime;
    ushort[257] szIDi;
    ushort[257] szIDr;
    BOOL        fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL        fDisableIKEv2Fragmentation;
}

struct tagRASADPARAMS
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int  xDlg;
    int  yDlg;
}

struct tagRASSUBENTRYA
{
    uint      dwSize;
    uint      dwfFlags;
    byte[17]  szDeviceType;
    byte[129] szDeviceName;
    byte[129] szLocalPhoneNumber;
    uint      dwAlternateOffset;
}

struct tagRASSUBENTRYW
{
    uint        dwSize;
    uint        dwfFlags;
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
    ushort[129] szLocalPhoneNumber;
    uint        dwAlternateOffset;
}

struct tagRASCREDENTIALSA
{
    uint      dwSize;
    uint      dwMask;
    byte[257] szUserName;
    byte[257] szPassword;
    byte[16]  szDomain;
}

struct tagRASCREDENTIALSW
{
    uint        dwSize;
    uint        dwMask;
    ushort[257] szUserName;
    ushort[257] szPassword;
    ushort[16]  szDomain;
}

struct tagRASAUTODIALENTRYA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwDialingLocation;
    byte[257] szEntry;
}

struct tagRASAUTODIALENTRYW
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwDialingLocation;
    ushort[257] szEntry;
}

struct tagRASEAPUSERIDENTITYA
{
    byte[257] szUserName;
    uint      dwSizeofEapInfo;
    ubyte[1]  pbEapInfo;
}

struct tagRASEAPUSERIDENTITYW
{
    ushort[257] szUserName;
    uint        dwSizeofEapInfo;
    ubyte[1]    pbEapInfo;
}

struct tagRASCOMMSETTINGS
{
    uint  dwSize;
    ubyte bParity;
    ubyte bStop;
    ubyte bByteSize;
    ubyte bAlign;
}

struct tagRASCUSTOMSCRIPTEXTENSIONS
{
    uint dwSize;
    PFNRASSETCOMMSETTINGS pfnRasSetCommSettings;
}

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

struct tagRASUPDATECONN
{
    RASAPIVERSION        version_;
    uint                 dwSize;
    uint                 dwFlags;
    uint                 dwIfIndex;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
}

struct tagRASNOUSERW
{
    uint        dwSize;
    uint        dwFlags;
    uint        dwTimeoutMs;
    ushort[257] szUserName;
    ushort[257] szPassword;
    ushort[16]  szDomain;
}

struct tagRASNOUSERA
{
    uint      dwSize;
    uint      dwFlags;
    uint      dwTimeoutMs;
    byte[257] szUserName;
    byte[257] szPassword;
    byte[16]  szDomain;
}

struct tagRASPBDLGW
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

struct tagRASPBDLGA
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

struct tagRASENTRYDLGW
{
    uint        dwSize;
    HWND        hwndOwner;
    uint        dwFlags;
    int         xDlg;
    int         yDlg;
    ushort[257] szEntry;
    uint        dwError;
    size_t      reserved;
    size_t      reserved2;
}

struct tagRASENTRYDLGA
{
    uint      dwSize;
    HWND      hwndOwner;
    uint      dwFlags;
    int       xDlg;
    int       yDlg;
    byte[257] szEntry;
    uint      dwError;
    size_t    reserved;
    size_t    reserved2;
}

struct tagRASDIALDLG
{
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

struct MPR_INTERFACE_0
{
    ushort[257] wszInterfaceName;
    HANDLE      hInterface;
    BOOL        fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint        fUnReachabilityReasons;
    uint        dwLastError;
}

struct MPR_IPINIP_INTERFACE_0
{
    ushort[257] wszFriendlyName;
    GUID        Guid;
}

struct MPR_INTERFACE_1
{
    ushort[257]   wszInterfaceName;
    HANDLE        hInterface;
    BOOL          fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint          fUnReachabilityReasons;
    uint          dwLastError;
    const(wchar)* lpwsDialoutHoursRestriction;
}

struct MPR_INTERFACE_2
{
    ushort[257]   wszInterfaceName;
    HANDLE        hInterface;
    BOOL          fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint          fUnReachabilityReasons;
    uint          dwLastError;
    uint          dwfOptions;
    ushort[129]   szLocalPhoneNumber;
    const(wchar)* szAlternates;
    uint          ipaddr;
    uint          ipaddrDns;
    uint          ipaddrDnsAlt;
    uint          ipaddrWins;
    uint          ipaddrWinsAlt;
    uint          dwfNetProtocols;
    ushort[17]    szDeviceType;
    ushort[129]   szDeviceName;
    ushort[33]    szX25PadType;
    ushort[201]   szX25Address;
    ushort[201]   szX25Facilities;
    ushort[201]   szX25UserData;
    uint          dwChannels;
    uint          dwSubEntries;
    uint          dwDialMode;
    uint          dwDialExtraPercent;
    uint          dwDialExtraSampleSeconds;
    uint          dwHangUpExtraPercent;
    uint          dwHangUpExtraSampleSeconds;
    uint          dwIdleDisconnectSeconds;
    uint          dwType;
    uint          dwEncryptionType;
    uint          dwCustomAuthKey;
    uint          dwCustomAuthDataSize;
    ubyte*        lpbCustomAuthData;
    GUID          guidId;
    uint          dwVpnStrategy;
}

struct MPR_INTERFACE_3
{
    ushort[257]   wszInterfaceName;
    HANDLE        hInterface;
    BOOL          fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint          fUnReachabilityReasons;
    uint          dwLastError;
    uint          dwfOptions;
    ushort[129]   szLocalPhoneNumber;
    const(wchar)* szAlternates;
    uint          ipaddr;
    uint          ipaddrDns;
    uint          ipaddrDnsAlt;
    uint          ipaddrWins;
    uint          ipaddrWinsAlt;
    uint          dwfNetProtocols;
    ushort[17]    szDeviceType;
    ushort[129]   szDeviceName;
    ushort[33]    szX25PadType;
    ushort[201]   szX25Address;
    ushort[201]   szX25Facilities;
    ushort[201]   szX25UserData;
    uint          dwChannels;
    uint          dwSubEntries;
    uint          dwDialMode;
    uint          dwDialExtraPercent;
    uint          dwDialExtraSampleSeconds;
    uint          dwHangUpExtraPercent;
    uint          dwHangUpExtraSampleSeconds;
    uint          dwIdleDisconnectSeconds;
    uint          dwType;
    uint          dwEncryptionType;
    uint          dwCustomAuthKey;
    uint          dwCustomAuthDataSize;
    ubyte*        lpbCustomAuthData;
    GUID          guidId;
    uint          dwVpnStrategy;
    uint          AddressCount;
    in6_addr      ipv6addrDns;
    in6_addr      ipv6addrDnsAlt;
    in6_addr*     ipv6addr;
}

struct MPR_DEVICE_0
{
    ushort[17]  szDeviceType;
    ushort[129] szDeviceName;
}

struct MPR_DEVICE_1
{
    ushort[17]    szDeviceType;
    ushort[129]   szDeviceName;
    ushort[129]   szLocalPhoneNumber;
    const(wchar)* szAlternates;
}

struct MPR_CREDENTIALSEX_0
{
    uint   dwSize;
    ubyte* lpbCredentialsInfo;
}

struct MPR_CREDENTIALSEX_1
{
    uint   dwSize;
    ubyte* lpbCredentialsInfo;
}

struct MPR_TRANSPORT_0
{
    uint       dwTransportId;
    HANDLE     hTransport;
    ushort[41] wszTransportName;
}

struct MPR_IFTRANSPORT_0
{
    uint       dwTransportId;
    HANDLE     hIfTransport;
    ushort[41] wszIfTransportName;
}

struct MPR_SERVER_0
{
    BOOL fLanOnlyMode;
    uint dwUpTime;
    uint dwTotalPorts;
    uint dwPortsInUse;
}

struct MPR_SERVER_1
{
    uint dwNumPptpPorts;
    uint dwPptpPortFlags;
    uint dwNumL2tpPorts;
    uint dwL2tpPortFlags;
}

struct MPR_SERVER_2
{
    uint dwNumPptpPorts;
    uint dwPptpPortFlags;
    uint dwNumL2tpPorts;
    uint dwL2tpPortFlags;
    uint dwNumSstpPorts;
    uint dwSstpPortFlags;
}

struct RAS_PORT_0
{
    HANDLE             hPort;
    HANDLE             hConnection;
    RAS_PORT_CONDITION dwPortCondition;
    uint               dwTotalNumberOfCalls;
    uint               dwConnectDuration;
    ushort[17]         wszPortName;
    ushort[17]         wszMediaName;
    ushort[129]        wszDeviceName;
    ushort[17]         wszDeviceType;
}

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
    HANDLE      hPort;
    HANDLE      hConnection;
    uint        dwConn_State;
    ushort[17]  wszPortName;
    ushort[17]  wszMediaName;
    ushort[129] wszDeviceName;
    ushort[17]  wszDeviceType;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint        dwLineSpeed;
    uint        dwCrcErr;
    uint        dwSerialOverRunErrs;
    uint        dwTimeoutErr;
    uint        dwAlignmentErr;
    uint        dwHardwareOverrunErr;
    uint        dwFramingErr;
    uint        dwBufferOverrunErr;
    uint        dwCompressionRatioIn;
    uint        dwCompressionRatioOut;
    uint        dwTotalErrors;
    ulong       ullBytesXmited;
    ulong       ullBytesRcved;
    ulong       ullFramesXmited;
    ulong       ullFramesRcved;
    ulong       ullBytesTxUncompressed;
    ulong       ullBytesTxCompressed;
    ulong       ullBytesRcvUncompressed;
    ulong       ullBytesRcvCompressed;
}

struct PPP_NBFCP_INFO
{
    uint       dwError;
    ushort[17] wszWksta;
}

struct PPP_IPCP_INFO
{
    uint       dwError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
}

struct PPP_IPCP_INFO2
{
    uint       dwError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
    uint       dwOptions;
    uint       dwRemoteOptions;
}

struct PPP_IPXCP_INFO
{
    uint       dwError;
    ushort[23] wszAddress;
}

struct PPP_ATCP_INFO
{
    uint       dwError;
    ushort[33] wszAddress;
}

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

struct PPP_INFO
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO  ip;
    PPP_IPXCP_INFO ipx;
    PPP_ATCP_INFO  at;
}

struct PPP_CCP_INFO
{
    uint dwError;
    uint dwCompressionAlgorithm;
    uint dwOptions;
    uint dwRemoteCompressionAlgorithm;
    uint dwRemoteOptions;
}

struct PPP_LCP_INFO
{
    uint dwError;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwRemoteAuthenticationProtocol;
    uint dwRemoteAuthenticationData;
    uint dwTerminateReason;
    uint dwRemoteTerminateReason;
    uint dwOptions;
    uint dwRemoteOptions;
    uint dwEapTypeId;
    uint dwRemoteEapTypeId;
}

struct PPP_INFO_2
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO2 ip;
    PPP_IPXCP_INFO ipx;
    PPP_ATCP_INFO  at;
    PPP_CCP_INFO   ccp;
    PPP_LCP_INFO   lcp;
}

struct PPP_INFO_3
{
    PPP_NBFCP_INFO   nbf;
    PPP_IPCP_INFO2   ip;
    PPP_IPV6_CP_INFO ipv6;
    PPP_CCP_INFO     ccp;
    PPP_LCP_INFO     lcp;
}

struct RAS_CONNECTION_0
{
    HANDLE      hConnection;
    HANDLE      hInterface;
    uint        dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint        dwConnectionFlags;
    ushort[257] wszInterfaceName;
    ushort[257] wszUserName;
    ushort[16]  wszLogonDomain;
    ushort[17]  wszRemoteComputer;
}

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

struct RAS_CONNECTION_2
{
    HANDLE      hConnection;
    ushort[257] wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    GUID        guid;
    PPP_INFO_2  PppInfo2;
}

struct RAS_CONNECTION_3
{
    uint                 dwVersion;
    uint                 dwSize;
    HANDLE               hConnection;
    ushort[257]          wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    GUID                 guid;
    PPP_INFO_3           PppInfo3;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME             timer;
}

struct RAS_USER_0
{
    ubyte       bfPrivilege;
    ushort[129] wszPhoneNumber;
}

struct RAS_USER_1
{
    ubyte       bfPrivilege;
    ushort[129] wszPhoneNumber;
    ubyte       bfPrivilege2;
}

struct MPR_FILTER_0
{
    BOOL fEnable;
}

struct MPRAPI_OBJECT_HEADER
{
    ubyte  revision;
    ubyte  type;
    ushort size;
}

struct PPP_PROJECTION_INFO
{
    uint       dwIPv4NegotiationError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
    uint       dwIPv4Options;
    uint       dwIPv4RemoteOptions;
    ulong      IPv4SubInterfaceIndex;
    uint       dwIPv6NegotiationError;
    ubyte[8]   bInterfaceIdentifier;
    ubyte[8]   bRemoteInterfaceIdentifier;
    ubyte[8]   bPrefix;
    uint       dwPrefixLength;
    ulong      IPv6SubInterfaceIndex;
    uint       dwLcpError;
    uint       dwAuthenticationProtocol;
    uint       dwAuthenticationData;
    uint       dwRemoteAuthenticationProtocol;
    uint       dwRemoteAuthenticationData;
    uint       dwLcpTerminateReason;
    uint       dwLcpRemoteTerminateReason;
    uint       dwLcpOptions;
    uint       dwLcpRemoteOptions;
    uint       dwEapTypeId;
    uint       dwRemoteEapTypeId;
    uint       dwCcpError;
    uint       dwCompressionAlgorithm;
    uint       dwCcpOptions;
    uint       dwRemoteCompressionAlgorithm;
    uint       dwCcpRemoteOptions;
}

struct PPP_PROJECTION_INFO2
{
    uint       dwIPv4NegotiationError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
    uint       dwIPv4Options;
    uint       dwIPv4RemoteOptions;
    ulong      IPv4SubInterfaceIndex;
    uint       dwIPv6NegotiationError;
    ubyte[8]   bInterfaceIdentifier;
    ubyte[8]   bRemoteInterfaceIdentifier;
    ubyte[8]   bPrefix;
    uint       dwPrefixLength;
    ulong      IPv6SubInterfaceIndex;
    uint       dwLcpError;
    uint       dwAuthenticationProtocol;
    uint       dwAuthenticationData;
    uint       dwRemoteAuthenticationProtocol;
    uint       dwRemoteAuthenticationData;
    uint       dwLcpTerminateReason;
    uint       dwLcpRemoteTerminateReason;
    uint       dwLcpOptions;
    uint       dwLcpRemoteOptions;
    uint       dwEapTypeId;
    uint       dwEmbeddedEAPTypeId;
    uint       dwRemoteEapTypeId;
    uint       dwCcpError;
    uint       dwCompressionAlgorithm;
    uint       dwCcpOptions;
    uint       dwRemoteCompressionAlgorithm;
    uint       dwCcpRemoteOptions;
}

struct IKEV2_PROJECTION_INFO
{
    uint       dwIPv4NegotiationError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
    ulong      IPv4SubInterfaceIndex;
    uint       dwIPv6NegotiationError;
    ubyte[8]   bInterfaceIdentifier;
    ubyte[8]   bRemoteInterfaceIdentifier;
    ubyte[8]   bPrefix;
    uint       dwPrefixLength;
    ulong      IPv6SubInterfaceIndex;
    uint       dwOptions;
    uint       dwAuthenticationProtocol;
    uint       dwEapTypeId;
    uint       dwCompressionAlgorithm;
    uint       dwEncryptionMethod;
}

struct IKEV2_PROJECTION_INFO2
{
    uint       dwIPv4NegotiationError;
    ushort[16] wszAddress;
    ushort[16] wszRemoteAddress;
    ulong      IPv4SubInterfaceIndex;
    uint       dwIPv6NegotiationError;
    ubyte[8]   bInterfaceIdentifier;
    ubyte[8]   bRemoteInterfaceIdentifier;
    ubyte[8]   bPrefix;
    uint       dwPrefixLength;
    ulong      IPv6SubInterfaceIndex;
    uint       dwOptions;
    uint       dwAuthenticationProtocol;
    uint       dwEapTypeId;
    uint       dwEmbeddedEAPTypeId;
    uint       dwCompressionAlgorithm;
    uint       dwEncryptionMethod;
}

struct PROJECTION_INFO
{
    ubyte projectionInfoType;
    union
    {
        PPP_PROJECTION_INFO PppProjectionInfo;
        IKEV2_PROJECTION_INFO Ikev2ProjectionInfo;
    }
}

struct PROJECTION_INFO2
{
    ubyte projectionInfoType;
    union
    {
        PPP_PROJECTION_INFO2 PppProjectionInfo;
        IKEV2_PROJECTION_INFO2 Ikev2ProjectionInfo;
    }
}

struct RAS_CONNECTION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint                 dwConnectionFlags;
    ushort[257]          wszInterfaceName;
    ushort[257]          wszUserName;
    ushort[16]           wszLogonDomain;
    ushort[17]           wszRemoteComputer;
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
    ushort[65]           wszRemoteEndpointAddress;
    ushort[65]           wszLocalEndpointAddress;
    PROJECTION_INFO      ProjectionInfo;
    HANDLE               hConnection;
    HANDLE               hInterface;
}

struct RAS_CONNECTION_4
{
    uint                 dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint                 dwConnectionFlags;
    ushort[257]          wszInterfaceName;
    ushort[257]          wszUserName;
    ushort[16]           wszLogonDomain;
    ushort[17]           wszRemoteComputer;
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
    ushort[65]           wszRemoteEndpointAddress;
    ushort[65]           wszLocalEndpointAddress;
    PROJECTION_INFO2     ProjectionInfo;
    HANDLE               hConnection;
    HANDLE               hInterface;
    uint                 dwDeviceType;
}

struct ROUTER_CUSTOM_IKEv2_POLICY0
{
    uint dwIntegrityMethod;
    uint dwEncryptionMethod;
    uint dwCipherTransformConstant;
    uint dwAuthTransformConstant;
    uint dwPfsGroup;
    uint dwDhGroup;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG0
{
    uint           dwSaLifeTime;
    uint           dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

struct MPR_IF_CUSTOMINFOEX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG0 customIkev2Config;
}

struct MPR_CERT_EKU
{
    uint    dwSize;
    BOOL    IsEKUOID;
    ushort* pwszEKU;
}

struct VPN_TS_IP_ADDRESS
{
    ushort Type;
    union
    {
        in_addr  v4;
        in6_addr v6;
    }
}

struct _MPR_VPN_SELECTOR
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
    uint               numTsi;
    uint               numTsr;
    _MPR_VPN_SELECTOR* tsI;
    _MPR_VPN_SELECTOR* tsR;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG2
{
    uint           dwSaLifeTime;
    uint           dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
    uint           dwMmSaLifeTime;
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
    uint            dwIdleTimeout;
    uint            dwNetworkBlackoutTime;
    uint            dwSaLifeTime;
    uint            dwSaDataSizeForRenegotiation;
    uint            dwConfigOptions;
    uint            dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB  machineCertificateName;
    uint            dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint            dwTotalEkus;
    MPR_CERT_EKU*   certificateEKUs;
    CRYPTOAPI_BLOB  machineCertificateHash;
    uint            dwMmSaLifeTime;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG1
{
    uint           dwSaLifeTime;
    uint           dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
}

struct MPR_IF_CUSTOMINFOEX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG1 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS3
{
    uint            dwIdleTimeout;
    uint            dwNetworkBlackoutTime;
    uint            dwSaLifeTime;
    uint            dwSaDataSizeForRenegotiation;
    uint            dwConfigOptions;
    uint            dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB  machineCertificateName;
    uint            dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint            dwTotalEkus;
    MPR_CERT_EKU*   certificateEKUs;
    CRYPTOAPI_BLOB  machineCertificateHash;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS2
{
    uint            dwIdleTimeout;
    uint            dwNetworkBlackoutTime;
    uint            dwSaLifeTime;
    uint            dwSaDataSizeForRenegotiation;
    uint            dwConfigOptions;
    uint            dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB  machineCertificateName;
    uint            dwEncryptionType;
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

struct IKEV2_CONFIG_PARAMS
{
    uint dwNumPorts;
    uint dwPortFlags;
    uint dwTunnelConfigParamFlags;
    IKEV2_TUNNEL_CONFIG_PARAMS4 TunnelConfigParams;
}

struct PPTP_CONFIG_PARAMS
{
    uint dwNumPorts;
    uint dwPortFlags;
}

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

struct L2TP_CONFIG_PARAMS0
{
    uint dwNumPorts;
    uint dwPortFlags;
}

struct SSTP_CERT_INFO
{
    BOOL           isDefault;
    CRYPTOAPI_BLOB certBlob;
}

struct SSTP_CONFIG_PARAMS
{
    uint           dwNumPorts;
    uint           dwPortFlags;
    BOOL           isUseHttps;
    uint           certAlgorithm;
    SSTP_CERT_INFO sstpCertDetails;
}

struct MPRAPI_TUNNEL_CONFIG_PARAMS0
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS  SstpConfigParams;
}

struct MPRAPI_TUNNEL_CONFIG_PARAMS1
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS  PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS  SstpConfigParams;
    GRE_CONFIG_PARAMS0  GREConfigParams;
}

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

struct MPR_SERVER_SET_CONFIG_EX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

struct MPR_SERVER_SET_CONFIG_EX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

struct AUTH_VALIDATION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    HANDLE               hRasConnection;
    ushort[257]          wszUserName;
    ushort[16]           wszLogonDomain;
    uint                 AuthInfoSize;
    ubyte[1]             AuthInfo;
}

struct RAS_UPDATE_CONNECTION
{
    MPRAPI_OBJECT_HEADER Header;
    uint                 dwIfIndex;
    ushort[65]           wszLocalEndpointAddress;
    ushort[65]           wszRemoteEndpointAddress;
}

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

struct SECURITY_MESSAGE
{
    uint      dwMsgId;
    ptrdiff_t hPort;
    uint      dwError;
    byte[257] UserName;
    byte[16]  Domain;
}

struct RAS_SECURITY_INFO
{
    uint      LastError;
    uint      BytesReceived;
    byte[129] DeviceName;
}

struct MGM_IF_ENTRY
{
    uint dwIfIndex;
    uint dwIfNextHopAddr;
    BOOL bIGMP;
    BOOL bIsEnabled;
}

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

struct SOURCE_GROUP_ENTRY
{
    uint dwSourceAddr;
    uint dwSourceMask;
    uint dwGroupAddr;
    uint dwGroupMask;
}

struct RTM_REGN_PROFILE
{
    uint MaxNextHopsInRoute;
    uint MaxHandlesInEnum;
    uint ViewsSupported;
    uint NumberOfViews;
}

struct RTM_NET_ADDRESS
{
    ushort    AddressFamily;
    ushort    NumBits;
    ubyte[16] AddrBits;
}

struct RTM_PREF_INFO
{
    uint Metric;
    uint Preference;
}

struct RTM_NEXTHOP_LIST
{
    ushort       NumNextHops;
    ptrdiff_t[1] NextHops;
}

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

struct RTM_ENTITY_INFO
{
    ushort        RtmInstanceId;
    ushort        AddressFamily;
    RTM_ENTITY_ID EntityId;
}

struct RTM_ENTITY_METHOD_INPUT
{
    uint     MethodType;
    uint     InputSize;
    ubyte[1] InputData;
}

struct RTM_ENTITY_METHOD_OUTPUT
{
    uint     MethodType;
    uint     MethodStatus;
    uint     OutputSize;
    ubyte[1] OutputData;
}

struct RTM_ENTITY_EXPORT_METHODS
{
    uint         NumMethods;
    ptrdiff_t[1] Methods;
}

// Functions

@DllImport("RASAPI32")
uint RasDialA(tagRASDIALEXTENSIONS* param0, const(char)* param1, tagRASDIALPARAMSA* param2, uint param3, 
              void* param4, HRASCONN__** param5);

@DllImport("RASAPI32")
uint RasDialW(tagRASDIALEXTENSIONS* param0, const(wchar)* param1, tagRASDIALPARAMSW* param2, uint param3, 
              void* param4, HRASCONN__** param5);

@DllImport("RASAPI32")
uint RasEnumConnectionsA(tagRASCONNA* param0, uint* param1, uint* param2);

@DllImport("RASAPI32")
uint RasEnumConnectionsW(tagRASCONNW* param0, uint* param1, uint* param2);

@DllImport("RASAPI32")
uint RasEnumEntriesA(const(char)* param0, const(char)* param1, tagRASENTRYNAMEA* param2, uint* param3, 
                     uint* param4);

@DllImport("RASAPI32")
uint RasEnumEntriesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYNAMEW* param2, uint* param3, 
                     uint* param4);

@DllImport("RASAPI32")
uint RasGetConnectStatusA(HRASCONN__* param0, tagRASCONNSTATUSA* param1);

@DllImport("RASAPI32")
uint RasGetConnectStatusW(HRASCONN__* param0, tagRASCONNSTATUSW* param1);

@DllImport("RASAPI32")
uint RasGetErrorStringA(uint ResourceId, const(char)* lpszString, uint InBufSize);

@DllImport("RASAPI32")
uint RasGetErrorStringW(uint ResourceId, const(wchar)* lpszString, uint InBufSize);

@DllImport("RASAPI32")
uint RasHangUpA(HRASCONN__* param0);

@DllImport("RASAPI32")
uint RasHangUpW(HRASCONN__* param0);

@DllImport("RASAPI32")
uint RasGetProjectionInfoA(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

@DllImport("RASAPI32")
uint RasGetProjectionInfoW(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

@DllImport("RASAPI32")
uint RasCreatePhonebookEntryA(HWND param0, const(char)* param1);

@DllImport("RASAPI32")
uint RasCreatePhonebookEntryW(HWND param0, const(wchar)* param1);

@DllImport("RASAPI32")
uint RasEditPhonebookEntryA(HWND param0, const(char)* param1, const(char)* param2);

@DllImport("RASAPI32")
uint RasEditPhonebookEntryW(HWND param0, const(wchar)* param1, const(wchar)* param2);

@DllImport("RASAPI32")
uint RasSetEntryDialParamsA(const(char)* param0, tagRASDIALPARAMSA* param1, BOOL param2);

@DllImport("RASAPI32")
uint RasSetEntryDialParamsW(const(wchar)* param0, tagRASDIALPARAMSW* param1, BOOL param2);

@DllImport("RASAPI32")
uint RasGetEntryDialParamsA(const(char)* param0, tagRASDIALPARAMSA* param1, int* param2);

@DllImport("RASAPI32")
uint RasGetEntryDialParamsW(const(wchar)* param0, tagRASDIALPARAMSW* param1, int* param2);

@DllImport("RASAPI32")
uint RasEnumDevicesA(tagRASDEVINFOA* param0, uint* param1, uint* param2);

@DllImport("RASAPI32")
uint RasEnumDevicesW(tagRASDEVINFOW* param0, uint* param1, uint* param2);

@DllImport("RASAPI32")
uint RasGetCountryInfoA(RASCTRYINFO* param0, uint* param1);

@DllImport("RASAPI32")
uint RasGetCountryInfoW(RASCTRYINFO* param0, uint* param1);

@DllImport("RASAPI32")
uint RasGetEntryPropertiesA(const(char)* param0, const(char)* param1, tagRASENTRYA* param2, uint* param3, 
                            ubyte* param4, uint* param5);

@DllImport("RASAPI32")
uint RasGetEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYW* param2, uint* param3, 
                            ubyte* param4, uint* param5);

@DllImport("RASAPI32")
uint RasSetEntryPropertiesA(const(char)* param0, const(char)* param1, tagRASENTRYA* param2, uint param3, 
                            ubyte* param4, uint param5);

@DllImport("RASAPI32")
uint RasSetEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYW* param2, uint param3, 
                            ubyte* param4, uint param5);

@DllImport("RASAPI32")
uint RasRenameEntryA(const(char)* param0, const(char)* param1, const(char)* param2);

@DllImport("RASAPI32")
uint RasRenameEntryW(const(wchar)* param0, const(wchar)* param1, const(wchar)* param2);

@DllImport("RASAPI32")
uint RasDeleteEntryA(const(char)* param0, const(char)* param1);

@DllImport("RASAPI32")
uint RasDeleteEntryW(const(wchar)* param0, const(wchar)* param1);

@DllImport("RASAPI32")
uint RasValidateEntryNameA(const(char)* param0, const(char)* param1);

@DllImport("RASAPI32")
uint RasValidateEntryNameW(const(wchar)* param0, const(wchar)* param1);

@DllImport("RASAPI32")
uint RasConnectionNotificationA(HRASCONN__* param0, HANDLE param1, uint param2);

@DllImport("RASAPI32")
uint RasConnectionNotificationW(HRASCONN__* param0, HANDLE param1, uint param2);

@DllImport("RASAPI32")
uint RasGetSubEntryHandleA(HRASCONN__* param0, uint param1, HRASCONN__** param2);

@DllImport("RASAPI32")
uint RasGetSubEntryHandleW(HRASCONN__* param0, uint param1, HRASCONN__** param2);

@DllImport("RASAPI32")
uint RasGetCredentialsA(const(char)* param0, const(char)* param1, tagRASCREDENTIALSA* param2);

@DllImport("RASAPI32")
uint RasGetCredentialsW(const(wchar)* param0, const(wchar)* param1, tagRASCREDENTIALSW* param2);

@DllImport("RASAPI32")
uint RasSetCredentialsA(const(char)* param0, const(char)* param1, tagRASCREDENTIALSA* param2, BOOL param3);

@DllImport("RASAPI32")
uint RasSetCredentialsW(const(wchar)* param0, const(wchar)* param1, tagRASCREDENTIALSW* param2, BOOL param3);

@DllImport("RASAPI32")
uint RasGetSubEntryPropertiesA(const(char)* param0, const(char)* param1, uint param2, tagRASSUBENTRYA* param3, 
                               uint* param4, ubyte* param5, uint* param6);

@DllImport("RASAPI32")
uint RasGetSubEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, uint param2, tagRASSUBENTRYW* param3, 
                               uint* param4, ubyte* param5, uint* param6);

@DllImport("RASAPI32")
uint RasSetSubEntryPropertiesA(const(char)* param0, const(char)* param1, uint param2, tagRASSUBENTRYA* param3, 
                               uint param4, ubyte* param5, uint param6);

@DllImport("RASAPI32")
uint RasSetSubEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, uint param2, tagRASSUBENTRYW* param3, 
                               uint param4, ubyte* param5, uint param6);

@DllImport("RASAPI32")
uint RasGetAutodialAddressA(const(char)* param0, uint* param1, tagRASAUTODIALENTRYA* param2, uint* param3, 
                            uint* param4);

@DllImport("RASAPI32")
uint RasGetAutodialAddressW(const(wchar)* param0, uint* param1, tagRASAUTODIALENTRYW* param2, uint* param3, 
                            uint* param4);

@DllImport("RASAPI32")
uint RasSetAutodialAddressA(const(char)* param0, uint param1, tagRASAUTODIALENTRYA* param2, uint param3, 
                            uint param4);

@DllImport("RASAPI32")
uint RasSetAutodialAddressW(const(wchar)* param0, uint param1, tagRASAUTODIALENTRYW* param2, uint param3, 
                            uint param4);

@DllImport("RASAPI32")
uint RasEnumAutodialAddressesA(char* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, 
                               uint* lpdwcRasAutodialAddresses);

@DllImport("RASAPI32")
uint RasEnumAutodialAddressesW(char* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, 
                               uint* lpdwcRasAutodialAddresses);

@DllImport("RASAPI32")
uint RasGetAutodialEnableA(uint param0, int* param1);

@DllImport("RASAPI32")
uint RasGetAutodialEnableW(uint param0, int* param1);

@DllImport("RASAPI32")
uint RasSetAutodialEnableA(uint param0, BOOL param1);

@DllImport("RASAPI32")
uint RasSetAutodialEnableW(uint param0, BOOL param1);

@DllImport("RASAPI32")
uint RasGetAutodialParamA(uint param0, void* param1, uint* param2);

@DllImport("RASAPI32")
uint RasGetAutodialParamW(uint param0, void* param1, uint* param2);

@DllImport("RASAPI32")
uint RasSetAutodialParamA(uint param0, void* param1, uint param2);

@DllImport("RASAPI32")
uint RasSetAutodialParamW(uint param0, void* param1, uint param2);

@DllImport("RASAPI32")
uint RasGetPCscf(const(wchar)* lpszPCscf);

@DllImport("RASAPI32")
uint RasInvokeEapUI(HRASCONN__* param0, uint param1, tagRASDIALEXTENSIONS* param2, HWND param3);

@DllImport("RASAPI32")
uint RasGetLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry, RAS_STATS* lpStatistics);

@DllImport("RASAPI32")
uint RasGetConnectionStatistics(HRASCONN__* hRasConn, RAS_STATS* lpStatistics);

@DllImport("RASAPI32")
uint RasClearLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry);

@DllImport("RASAPI32")
uint RasClearConnectionStatistics(HRASCONN__* hRasConn);

@DllImport("RASAPI32")
uint RasGetEapUserDataA(HANDLE hToken, const(char)* pszPhonebook, const(char)* pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

@DllImport("RASAPI32")
uint RasGetEapUserDataW(HANDLE hToken, const(wchar)* pszPhonebook, const(wchar)* pszEntry, ubyte* pbEapData, 
                        uint* pdwSizeofEapData);

@DllImport("RASAPI32")
uint RasSetEapUserDataA(HANDLE hToken, const(char)* pszPhonebook, const(char)* pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

@DllImport("RASAPI32")
uint RasSetEapUserDataW(HANDLE hToken, const(wchar)* pszPhonebook, const(wchar)* pszEntry, ubyte* pbEapData, 
                        uint dwSizeofEapData);

@DllImport("RASAPI32")
uint RasGetCustomAuthDataA(const(char)* pszPhonebook, const(char)* pszEntry, char* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

@DllImport("RASAPI32")
uint RasGetCustomAuthDataW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, char* pbCustomAuthData, 
                           uint* pdwSizeofCustomAuthData);

@DllImport("RASAPI32")
uint RasSetCustomAuthDataA(const(char)* pszPhonebook, const(char)* pszEntry, char* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

@DllImport("RASAPI32")
uint RasSetCustomAuthDataW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, char* pbCustomAuthData, 
                           uint dwSizeofCustomAuthData);

@DllImport("RASAPI32")
uint RasGetEapUserIdentityW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, uint dwFlags, HWND hwnd, 
                            tagRASEAPUSERIDENTITYW** ppRasEapUserIdentity);

@DllImport("RASAPI32")
uint RasGetEapUserIdentityA(const(char)* pszPhonebook, const(char)* pszEntry, uint dwFlags, HWND hwnd, 
                            tagRASEAPUSERIDENTITYA** ppRasEapUserIdentity);

@DllImport("RASAPI32")
void RasFreeEapUserIdentityW(tagRASEAPUSERIDENTITYW* pRasEapUserIdentity);

@DllImport("RASAPI32")
void RasFreeEapUserIdentityA(tagRASEAPUSERIDENTITYA* pRasEapUserIdentity);

@DllImport("RASAPI32")
uint RasDeleteSubEntryA(const(char)* pszPhonebook, const(char)* pszEntry, uint dwSubentryId);

@DllImport("RASAPI32")
uint RasDeleteSubEntryW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, uint dwSubEntryId);

@DllImport("RASAPI32")
uint RasUpdateConnection(HRASCONN__* hrasconn, tagRASUPDATECONN* lprasupdateconn);

@DllImport("RASAPI32")
uint RasGetProjectionInfoEx(HRASCONN__* hrasconn, RAS_PROJECTION_INFO* pRasProjection, uint* lpdwSize);

@DllImport("RASDLG")
BOOL RasPhonebookDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, tagRASPBDLGA* lpInfo);

@DllImport("RASDLG")
BOOL RasPhonebookDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, tagRASPBDLGW* lpInfo);

@DllImport("RASDLG")
BOOL RasEntryDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, tagRASENTRYDLGA* lpInfo);

@DllImport("RASDLG")
BOOL RasEntryDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, tagRASENTRYDLGW* lpInfo);

@DllImport("RASDLG")
BOOL RasDialDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, const(char)* lpszPhoneNumber, 
                 tagRASDIALDLG* lpInfo);

@DllImport("RASDLG")
BOOL RasDialDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, const(wchar)* lpszPhoneNumber, 
                 tagRASDIALDLG* lpInfo);

@DllImport("MPRAPI")
uint MprAdminConnectionEnumEx(ptrdiff_t hRasServer, MPRAPI_OBJECT_HEADER* pObjectHeader, uint dwPreferedMaxLen, 
                              uint* lpdwEntriesRead, uint* lpdwTotalEntries, RAS_CONNECTION_EX** ppRasConn, 
                              uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprAdminConnectionGetInfoEx(ptrdiff_t hRasServer, HANDLE hRasConnection, RAS_CONNECTION_EX* pRasConnection);

@DllImport("MPRAPI")
uint MprAdminServerGetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_EX1* pServerInfo);

@DllImport("MPRAPI")
uint MprAdminServerSetInfoEx(ptrdiff_t hMprServer, MPR_SERVER_SET_CONFIG_EX1* pServerInfo);

@DllImport("MPRAPI")
uint MprConfigServerGetInfoEx(HANDLE hMprConfig, MPR_SERVER_EX1* pServerInfo);

@DllImport("MPRAPI")
uint MprConfigServerSetInfoEx(HANDLE hMprConfig, MPR_SERVER_SET_CONFIG_EX1* pSetServerConfig);

@DllImport("MPRAPI")
uint MprAdminUpdateConnection(ptrdiff_t hRasServer, HANDLE hRasConnection, 
                              RAS_UPDATE_CONNECTION* pRasUpdateConnection);

@DllImport("MPRAPI")
uint MprAdminIsServiceInitialized(const(wchar)* lpwsServerName, int* fIsServiceInitialized);

@DllImport("MPRAPI")
uint MprAdminInterfaceSetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI")
uint MprAdminInterfaceGetCustomInfoEx(ptrdiff_t hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI")
uint MprConfigInterfaceGetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI")
uint MprConfigInterfaceSetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, 
                                       MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI")
uint MprAdminConnectionEnum(ptrdiff_t hRasServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprAdminPortEnum(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer, 
                      uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprAdminConnectionGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminPortGetInfo(ptrdiff_t hRasServer, uint dwLevel, HANDLE hPort, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminConnectionClearStats(ptrdiff_t hRasServer, HANDLE hRasConnection);

@DllImport("MPRAPI")
uint MprAdminPortClearStats(ptrdiff_t hRasServer, HANDLE hPort);

@DllImport("MPRAPI")
uint MprAdminPortReset(ptrdiff_t hRasServer, HANDLE hPort);

@DllImport("MPRAPI")
uint MprAdminPortDisconnect(ptrdiff_t hRasServer, HANDLE hPort);

@DllImport("MPRAPI")
uint MprAdminConnectionRemoveQuarantine(HANDLE hRasServer, HANDLE hRasConnection, BOOL fIsIpAddress);

@DllImport("MPRAPI")
uint MprAdminUserGetInfo(const(wchar)* lpszServer, const(wchar)* lpszUser, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminUserSetInfo(const(wchar)* lpszServer, const(wchar)* lpszUser, uint dwLevel, const(ubyte)* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminSendUserMessage(ptrdiff_t hMprServer, HANDLE hConnection, const(wchar)* lpwszMessage);

@DllImport("MPRAPI")
uint MprAdminGetPDCServer(const(wchar)* lpszDomain, const(wchar)* lpszServer, const(wchar)* lpszPDCServer);

@DllImport("MPRAPI")
BOOL MprAdminIsServiceRunning(const(wchar)* lpwsServerName);

@DllImport("MPRAPI")
uint MprAdminServerConnect(const(wchar)* lpwsServerName, ptrdiff_t* phMprServer);

@DllImport("MPRAPI")
void MprAdminServerDisconnect(ptrdiff_t hMprServer);

@DllImport("MPRAPI")
uint MprAdminServerGetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminServerSetCredentials(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminBufferFree(void* pBuffer);

@DllImport("MPRAPI")
uint MprAdminGetErrorString(uint dwError, ushort** lplpwsErrorString);

@DllImport("MPRAPI")
uint MprAdminServerGetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminEstablishDomainRasServer(const(wchar)* pszDomain, const(wchar)* pszMachine, BOOL bEnable);

@DllImport("MPRAPI")
uint MprAdminIsDomainRasServer(const(wchar)* pszDomain, const(wchar)* pszMachine, int* pbIsRasServer);

@DllImport("MPRAPI")
uint MprAdminTransportCreate(ptrdiff_t hMprServer, uint dwTransportId, const(wchar)* lpwsTransportName, 
                             ubyte* pGlobalInfo, uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, 
                             uint dwClientInterfaceInfoSize, const(wchar)* lpwsDLLPath);

@DllImport("MPRAPI")
uint MprAdminTransportSetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte* pGlobalInfo, uint dwGlobalInfoSize, 
                              ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprAdminTransportGetInfo(ptrdiff_t hMprServer, uint dwTransportId, ubyte** ppGlobalInfo, 
                              uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                              uint* lpdwClientInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprAdminDeviceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint* lpdwTotalEntries);

@DllImport("MPRAPI")
uint MprAdminInterfaceGetHandle(ptrdiff_t hMprServer, const(wchar)* lpwsInterfaceName, HANDLE* phInterface, 
                                BOOL fIncludeClientInterfaces);

@DllImport("MPRAPI")
uint MprAdminInterfaceCreate(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer, HANDLE* phInterface);

@DllImport("MPRAPI")
uint MprAdminInterfaceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceDelete(ptrdiff_t hMprServer, HANDLE hInterface);

@DllImport("MPRAPI")
uint MprAdminInterfaceDeviceGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte** lplpBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceDeviceSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, 
                                    ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceTransportRemove(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId);

@DllImport("MPRAPI")
uint MprAdminInterfaceTransportAdd(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                   ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprAdminInterfaceTransportGetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprAdminInterfaceTransportSetInfo(ptrdiff_t hMprServer, HANDLE hInterface, uint dwTransportId, 
                                       ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprAdminInterfaceEnum(ptrdiff_t hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, 
                           uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprAdminInterfaceSetCredentials(const(wchar)* lpwsServer, const(wchar)* lpwsInterfaceName, 
                                     const(wchar)* lpwsUserName, const(wchar)* lpwsDomainName, 
                                     const(wchar)* lpwsPassword);

@DllImport("MPRAPI")
uint MprAdminInterfaceGetCredentials(const(wchar)* lpwsServer, const(wchar)* lpwsInterfaceName, 
                                     const(wchar)* lpwsUserName, const(wchar)* lpwsPassword, 
                                     const(wchar)* lpwsDomainName);

@DllImport("MPRAPI")
uint MprAdminInterfaceSetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceGetCredentialsEx(ptrdiff_t hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprAdminInterfaceConnect(ptrdiff_t hMprServer, HANDLE hInterface, HANDLE hEvent, BOOL fSynchronous);

@DllImport("MPRAPI")
uint MprAdminInterfaceDisconnect(ptrdiff_t hMprServer, HANDLE hInterface);

@DllImport("MPRAPI")
uint MprAdminInterfaceUpdateRoutes(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, HANDLE hEvent);

@DllImport("MPRAPI")
uint MprAdminInterfaceQueryUpdateResult(ptrdiff_t hMprServer, HANDLE hInterface, uint dwProtocolId, 
                                        uint* lpdwUpdateResult);

@DllImport("MPRAPI")
uint MprAdminInterfaceUpdatePhonebookInfo(ptrdiff_t hMprServer, HANDLE hInterface);

@DllImport("MPRAPI")
uint MprAdminRegisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

@DllImport("MPRAPI")
uint MprAdminDeregisterConnectionNotification(ptrdiff_t hMprServer, HANDLE hEventNotification);

@DllImport("MPRAPI")
uint MprAdminMIBServerConnect(const(wchar)* lpwsServerName, ptrdiff_t* phMibServer);

@DllImport("MPRAPI")
void MprAdminMIBServerDisconnect(ptrdiff_t hMibServer);

@DllImport("MPRAPI")
uint MprAdminMIBEntryCreate(ptrdiff_t hMibServer, uint dwPid, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBEntryDelete(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                            uint dwEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBEntrySet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, 
                         uint dwEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBEntryGet(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                         uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBEntryGetFirst(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                              uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBEntryGetNext(ptrdiff_t hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, 
                             uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI")
uint MprAdminMIBBufferFree(void* pBuffer);

@DllImport("MPRAPI")
uint MprConfigServerInstall(uint dwLevel, void* pBuffer);

@DllImport("MPRAPI")
uint MprConfigServerConnect(const(wchar)* lpwsServerName, HANDLE* phMprConfig);

@DllImport("MPRAPI")
void MprConfigServerDisconnect(HANDLE hMprConfig);

@DllImport("MPRAPI")
uint MprConfigServerRefresh(HANDLE hMprConfig);

@DllImport("MPRAPI")
uint MprConfigBufferFree(void* pBuffer);

@DllImport("MPRAPI")
uint MprConfigServerGetInfo(HANDLE hMprConfig, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI")
uint MprConfigServerSetInfo(ptrdiff_t hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprConfigServerBackup(HANDLE hMprConfig, const(wchar)* lpwsPath);

@DllImport("MPRAPI")
uint MprConfigServerRestore(HANDLE hMprConfig, const(wchar)* lpwsPath);

@DllImport("MPRAPI")
uint MprConfigTransportCreate(HANDLE hMprConfig, uint dwTransportId, const(wchar)* lpwsTransportName, 
                              char* pGlobalInfo, uint dwGlobalInfoSize, char* pClientInterfaceInfo, 
                              uint dwClientInterfaceInfoSize, const(wchar)* lpwsDLLPath, HANDLE* phRouterTransport);

@DllImport("MPRAPI")
uint MprConfigTransportDelete(HANDLE hMprConfig, HANDLE hRouterTransport);

@DllImport("MPRAPI")
uint MprConfigTransportGetHandle(HANDLE hMprConfig, uint dwTransportId, HANDLE* phRouterTransport);

@DllImport("MPRAPI")
uint MprConfigTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, char* pGlobalInfo, 
                               uint dwGlobalInfoSize, char* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, 
                               const(wchar)* lpwsDLLPath);

@DllImport("MPRAPI")
uint MprConfigTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, ubyte** ppGlobalInfo, 
                               uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, 
                               uint* lpdwClientInterfaceInfoSize, ushort** lplpwsDLLPath);

@DllImport("MPRAPI")
uint MprConfigTransportEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprConfigInterfaceCreate(HANDLE hMprConfig, uint dwLevel, ubyte* lpbBuffer, HANDLE* phRouterInterface);

@DllImport("MPRAPI")
uint MprConfigInterfaceDelete(HANDLE hMprConfig, HANDLE hRouterInterface);

@DllImport("MPRAPI")
uint MprConfigInterfaceGetHandle(HANDLE hMprConfig, const(wchar)* lpwsInterfaceName, HANDLE* phRouterInterface);

@DllImport("MPRAPI")
uint MprConfigInterfaceGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                               uint* lpdwBufferSize);

@DllImport("MPRAPI")
uint MprConfigInterfaceSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI")
uint MprConfigInterfaceEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, 
                            uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportAdd(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                    const(wchar)* lpwsTransportName, char* pInterfaceInfo, uint dwInterfaceInfoSize, 
                                    HANDLE* phRouterIfTransport);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportRemove(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportGetHandle(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, 
                                          HANDLE* phRouterIfTransport);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, 
                                        char* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI")
uint MprConfigInterfaceTransportEnum(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, 
                                     uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, 
                                     uint* lpdwResumeHandle);

@DllImport("MPRAPI")
uint MprConfigGetFriendlyName(HANDLE hMprConfig, const(wchar)* pszGuidName, const(wchar)* pszBuffer, 
                              uint dwBufferSize);

@DllImport("MPRAPI")
uint MprConfigGetGuidName(HANDLE hMprConfig, const(wchar)* pszFriendlyName, const(wchar)* pszBuffer, 
                          uint dwBufferSize);

@DllImport("MPRAPI")
uint MprConfigFilterGetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, char* lpBuffer);

@DllImport("MPRAPI")
uint MprConfigFilterSetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

@DllImport("MPRAPI")
uint MprInfoCreate(uint dwVersion, void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoDelete(void* lpHeader);

@DllImport("MPRAPI")
uint MprInfoRemoveAll(void* lpHeader, void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoDuplicate(void* lpHeader, void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoBlockAdd(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, char* lpItemData, 
                     void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoBlockRemove(void* lpHeader, uint dwInfoType, void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoBlockSet(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, char* lpItemData, 
                     void** lplpNewHeader);

@DllImport("MPRAPI")
uint MprInfoBlockFind(void* lpHeader, uint dwInfoType, uint* lpdwItemSize, uint* lpdwItemCount, 
                      ubyte** lplpItemData);

@DllImport("MPRAPI")
uint MprInfoBlockQuerySize(void* lpHeader);

@DllImport("rtm")
uint MgmRegisterMProtocol(ROUTING_PROTOCOL_CONFIG* prpiInfo, uint dwProtocolId, uint dwComponentId, 
                          HANDLE* phProtocol);

@DllImport("rtm")
uint MgmDeRegisterMProtocol(HANDLE hProtocol);

@DllImport("rtm")
uint MgmTakeInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

@DllImport("rtm")
uint MgmReleaseInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

@DllImport("rtm")
uint MgmGetProtocolOnInterface(uint dwIfIndex, uint dwIfNextHopAddr, uint* pdwIfProtocolId, uint* pdwIfComponentId);

@DllImport("rtm")
uint MgmAddGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

@DllImport("rtm")
uint MgmDeleteGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, 
                                   uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

@DllImport("rtm")
uint MgmGetMfe(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer);

@DllImport("rtm")
uint MgmGetFirstMfe(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm")
uint MgmGetNextMfe(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm")
uint MgmGetMfeStats(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer, uint dwFlags);

@DllImport("rtm")
uint MgmGetFirstMfeStats(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, uint dwFlags);

@DllImport("rtm")
uint MgmGetNextMfeStats(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, 
                        uint dwFlags);

@DllImport("rtm")
uint MgmGroupEnumerationStart(HANDLE hProtocol, MGM_ENUM_TYPES metEnumType, HANDLE* phEnumHandle);

@DllImport("rtm")
uint MgmGroupEnumerationGetNext(HANDLE hEnum, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm")
uint MgmGroupEnumerationEnd(HANDLE hEnum);

@DllImport("rtm")
uint RtmConvertNetAddressToIpv6AddressAndLength(RTM_NET_ADDRESS* pNetAddress, in6_addr* pAddress, uint* pLength, 
                                                uint dwAddressSize);

@DllImport("rtm")
uint RtmConvertIpv6AddressAndLengthToNetAddress(RTM_NET_ADDRESS* pNetAddress, in6_addr Address, uint dwLength, 
                                                uint dwAddressSize);

@DllImport("rtm")
uint RtmRegisterEntity(RTM_ENTITY_INFO* RtmEntityInfo, RTM_ENTITY_EXPORT_METHODS* ExportMethods, 
                       RTM_EVENT_CALLBACK EventCallback, BOOL ReserveOpaquePointer, RTM_REGN_PROFILE* RtmRegProfile, 
                       ptrdiff_t* RtmRegHandle);

@DllImport("rtm")
uint RtmDeregisterEntity(ptrdiff_t RtmRegHandle);

@DllImport("rtm")
uint RtmGetRegisteredEntities(ptrdiff_t RtmRegHandle, uint* NumEntities, ptrdiff_t* EntityHandles, 
                              RTM_ENTITY_INFO* EntityInfos);

@DllImport("rtm")
uint RtmReleaseEntities(ptrdiff_t RtmRegHandle, uint NumEntities, ptrdiff_t* EntityHandles);

@DllImport("rtm")
uint RtmLockDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, BOOL Exclusive, BOOL LockDest);

@DllImport("rtm")
uint RtmGetOpaqueInformationPointer(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, void** OpaqueInfoPointer);

@DllImport("rtm")
uint RtmGetEntityMethods(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, uint* NumMethods, 
                         PRTM_ENTITY_EXPORT_METHOD ExptMethods);

@DllImport("rtm")
uint RtmInvokeMethod(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_METHOD_INPUT* Input, 
                     uint* OutputSize, RTM_ENTITY_METHOD_OUTPUT* Output);

@DllImport("rtm")
uint RtmBlockMethods(ptrdiff_t RtmRegHandle, HANDLE TargetHandle, ubyte TargetType, uint BlockingFlag);

@DllImport("rtm")
uint RtmGetEntityInfo(ptrdiff_t RtmRegHandle, ptrdiff_t EntityHandle, RTM_ENTITY_INFO* EntityInfo);

@DllImport("rtm")
uint RtmGetDestInfo(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                    RTM_DEST_INFO* DestInfo);

@DllImport("rtm")
uint RtmGetRouteInfo(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO* RouteInfo, 
                     RTM_NET_ADDRESS* DestAddress);

@DllImport("rtm")
uint RtmGetNextHopInfo(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm")
uint RtmReleaseEntityInfo(ptrdiff_t RtmRegHandle, RTM_ENTITY_INFO* EntityInfo);

@DllImport("rtm")
uint RtmReleaseDestInfo(ptrdiff_t RtmRegHandle, RTM_DEST_INFO* DestInfo);

@DllImport("rtm")
uint RtmReleaseRouteInfo(ptrdiff_t RtmRegHandle, RTM_ROUTE_INFO* RouteInfo);

@DllImport("rtm")
uint RtmReleaseNextHopInfo(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm")
uint RtmAddRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteHandle, RTM_NET_ADDRESS* DestAddress, 
                       RTM_ROUTE_INFO* RouteInfo, uint TimeToLive, ptrdiff_t RouteListHandle, uint NotifyType, 
                       ptrdiff_t NotifyHandle, uint* ChangeFlags);

@DllImport("rtm")
uint RtmDeleteRouteToDest(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* ChangeFlags);

@DllImport("rtm")
uint RtmHoldDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint HoldTime);

@DllImport("rtm")
uint RtmGetRoutePointer(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, RTM_ROUTE_INFO** RoutePointer);

@DllImport("rtm")
uint RtmLockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, BOOL Exclusive, BOOL LockRoute, 
                  RTM_ROUTE_INFO** RoutePointer);

@DllImport("rtm")
uint RtmUpdateAndUnlockRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint TimeToLive, 
                             ptrdiff_t RouteListHandle, uint NotifyType, ptrdiff_t NotifyHandle, uint* ChangeFlags);

@DllImport("rtm")
uint RtmGetExactMatchDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                 uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm")
uint RtmGetMostSpecificDestination(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, 
                                   uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm")
uint RtmGetLessSpecificDestination(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint ProtocolId, uint TargetViews, 
                                   RTM_DEST_INFO* DestInfo);

@DllImport("rtm")
uint RtmGetExactMatchRoute(ptrdiff_t RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint MatchingFlags, 
                           RTM_ROUTE_INFO* RouteInfo, uint InterfaceIndex, uint TargetViews, ptrdiff_t* RouteHandle);

@DllImport("rtm")
uint RtmIsBestRoute(ptrdiff_t RtmRegHandle, ptrdiff_t RouteHandle, uint* BestInViews);

@DllImport("rtm")
uint RtmAddNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                   uint* ChangeFlags);

@DllImport("rtm")
uint RtmFindNextHop(ptrdiff_t RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, ptrdiff_t* NextHopHandle, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm")
uint RtmDeleteNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm")
uint RtmGetNextHopPointer(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm")
uint RtmLockNextHop(ptrdiff_t RtmRegHandle, ptrdiff_t NextHopHandle, BOOL Exclusive, BOOL LockNextHop, 
                    RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm")
uint RtmCreateDestEnum(ptrdiff_t RtmRegHandle, uint TargetViews, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                       uint ProtocolId, ptrdiff_t* RtmEnumHandle);

@DllImport("rtm")
uint RtmGetEnumDests(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumDests, RTM_DEST_INFO* DestInfos);

@DllImport("rtm")
uint RtmReleaseDests(ptrdiff_t RtmRegHandle, uint NumDests, RTM_DEST_INFO* DestInfos);

@DllImport("rtm")
uint RtmCreateRouteEnum(ptrdiff_t RtmRegHandle, ptrdiff_t DestHandle, uint TargetViews, uint EnumFlags, 
                        RTM_NET_ADDRESS* StartDest, uint MatchingFlags, RTM_ROUTE_INFO* CriteriaRoute, 
                        uint CriteriaInterface, ptrdiff_t* RtmEnumHandle);

@DllImport("rtm")
uint RtmGetEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, ptrdiff_t* RouteHandles);

@DllImport("rtm")
uint RtmReleaseRoutes(ptrdiff_t RtmRegHandle, uint NumRoutes, ptrdiff_t* RouteHandles);

@DllImport("rtm")
uint RtmCreateNextHopEnum(ptrdiff_t RtmRegHandle, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, 
                          ptrdiff_t* RtmEnumHandle);

@DllImport("rtm")
uint RtmGetEnumNextHops(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumNextHops, ptrdiff_t* NextHopHandles);

@DllImport("rtm")
uint RtmReleaseNextHops(ptrdiff_t RtmRegHandle, uint NumNextHops, ptrdiff_t* NextHopHandles);

@DllImport("rtm")
uint RtmDeleteEnumHandle(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle);

@DllImport("rtm")
uint RtmRegisterForChangeNotification(ptrdiff_t RtmRegHandle, uint TargetViews, uint NotifyFlags, 
                                      void* NotifyContext, ptrdiff_t* NotifyHandle);

@DllImport("rtm")
uint RtmGetChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint* NumDests, 
                        RTM_DEST_INFO* ChangedDests);

@DllImport("rtm")
uint RtmReleaseChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, 
                            RTM_DEST_INFO* ChangedDests);

@DllImport("rtm")
uint RtmIgnoreChangedDests(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, uint NumDests, ptrdiff_t* ChangedDests);

@DllImport("rtm")
uint RtmGetChangeStatus(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, int* ChangeStatus);

@DllImport("rtm")
uint RtmMarkDestForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      BOOL MarkDest);

@DllImport("rtm")
uint RtmIsMarkedForChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle, ptrdiff_t DestHandle, 
                                      int* DestMarked);

@DllImport("rtm")
uint RtmDeregisterFromChangeNotification(ptrdiff_t RtmRegHandle, ptrdiff_t NotifyHandle);

@DllImport("rtm")
uint RtmCreateRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t* RouteListHandle);

@DllImport("rtm")
uint RtmInsertInRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, uint NumRoutes, 
                          ptrdiff_t* RouteHandles);

@DllImport("rtm")
uint RtmCreateRouteListEnum(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle, ptrdiff_t* RtmEnumHandle);

@DllImport("rtm")
uint RtmGetListEnumRoutes(ptrdiff_t RtmRegHandle, ptrdiff_t EnumHandle, uint* NumRoutes, char* RouteHandles);

@DllImport("rtm")
uint RtmDeleteRouteList(ptrdiff_t RtmRegHandle, ptrdiff_t RouteListHandle);

@DllImport("rtm")
uint RtmReferenceHandles(ptrdiff_t RtmRegHandle, uint NumHandles, HANDLE* RtmHandles);


