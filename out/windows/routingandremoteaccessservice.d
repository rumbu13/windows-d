module windows.routingandremoteaccessservice;

public import system;
public import windows.kernel;
public import windows.mib;
public import windows.security;
public import windows.systemservices;
public import windows.winsock;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

enum RASAPIVERSION
{
    RASAPIVERSION_500 = 1,
    RASAPIVERSION_501 = 2,
    RASAPIVERSION_600 = 3,
    RASAPIVERSION_601 = 4,
}

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
    _Anonymous_e__Union Anonymous;
}

struct HRASCONN__
{
    int unused;
}

struct tagRASCONNW
{
    uint dwSize;
    HRASCONN__* hrasconn;
    ushort szEntryName;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szPhonebook;
    uint dwSubEntry;
    Guid guidEntry;
    uint dwFlags;
    LUID luid;
    Guid guidCorrelationId;
}

struct tagRASCONNA
{
    uint dwSize;
    HRASCONN__* hrasconn;
    byte szEntryName;
    byte szDeviceType;
    byte szDeviceName;
    byte szPhonebook;
    uint dwSubEntry;
    Guid guidEntry;
    uint dwFlags;
    LUID luid;
    Guid guidCorrelationId;
}

enum tagRASCONNSTATE
{
    RASCS_OpenPort = 0,
    RASCS_PortOpened = 1,
    RASCS_ConnectDevice = 2,
    RASCS_DeviceConnected = 3,
    RASCS_AllDevicesConnected = 4,
    RASCS_Authenticate = 5,
    RASCS_AuthNotify = 6,
    RASCS_AuthRetry = 7,
    RASCS_AuthCallback = 8,
    RASCS_AuthChangePassword = 9,
    RASCS_AuthProject = 10,
    RASCS_AuthLinkSpeed = 11,
    RASCS_AuthAck = 12,
    RASCS_ReAuthenticate = 13,
    RASCS_Authenticated = 14,
    RASCS_PrepareForCallback = 15,
    RASCS_WaitForModemReset = 16,
    RASCS_WaitForCallback = 17,
    RASCS_Projected = 18,
    RASCS_StartAuthentication = 19,
    RASCS_CallbackComplete = 20,
    RASCS_LogonNetwork = 21,
    RASCS_SubEntryConnected = 22,
    RASCS_SubEntryDisconnected = 23,
    RASCS_ApplySettings = 24,
    RASCS_Interactive = 4096,
    RASCS_RetryAuthentication = 4097,
    RASCS_CallbackSetByCaller = 4098,
    RASCS_PasswordExpired = 4099,
    RASCS_InvokeEapUI = 4100,
    RASCS_Connected = 8192,
    RASCS_Disconnected = 8193,
}

enum tagRASCONNSUBSTATE
{
    RASCSS_None = 0,
    RASCSS_Dormant = 1,
    RASCSS_Reconnecting = 2,
    RASCSS_Reconnected = 8192,
}

struct tagRASCONNSTATUSW
{
    uint dwSize;
    tagRASCONNSTATE rasconnstate;
    uint dwError;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE rasconnsubstate;
}

struct tagRASCONNSTATUSA
{
    uint dwSize;
    tagRASCONNSTATE rasconnstate;
    uint dwError;
    byte szDeviceType;
    byte szDeviceName;
    byte szPhoneNumber;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
    tagRASCONNSUBSTATE rasconnsubstate;
}

struct tagRASDIALPARAMSW
{
    uint dwSize;
    ushort szEntryName;
    ushort szPhoneNumber;
    ushort szCallbackNumber;
    ushort szUserName;
    ushort szPassword;
    ushort szDomain;
    uint dwSubEntry;
    uint dwCallbackId;
    uint dwIfIndex;
    const(wchar)* szEncPassword;
}

struct tagRASDIALPARAMSA
{
    uint dwSize;
    byte szEntryName;
    byte szPhoneNumber;
    byte szCallbackNumber;
    byte szUserName;
    byte szPassword;
    byte szDomain;
    uint dwSubEntry;
    uint dwCallbackId;
    uint dwIfIndex;
    const(char)* szEncPassword;
}

struct tagRASEAPINFO
{
    uint dwSizeofEapInfo;
    ubyte* pbEapInfo;
}

struct RASDEVSPECIFICINFO
{
    uint dwSize;
    ubyte* pbDevSpecificInfo;
}

struct tagRASDIALEXTENSIONS
{
    uint dwSize;
    uint dwfOptions;
    HWND hwndParent;
    uint reserved;
    uint reserved1;
    tagRASEAPINFO RasEapInfo;
    BOOL fSkipPppAuth;
    RASDEVSPECIFICINFO RasDevSpecificInfo;
}

struct tagRASENTRYNAMEW
{
    uint dwSize;
    ushort szEntryName;
    uint dwFlags;
    ushort szPhonebookPath;
}

struct tagRASENTRYNAMEA
{
    uint dwSize;
    byte szEntryName;
    uint dwFlags;
    byte szPhonebookPath;
}

enum tagRASPROJECTION
{
    RASP_Amb = 65536,
    RASP_PppNbf = 32831,
    RASP_PppIpx = 32811,
    RASP_PppIp = 32801,
    RASP_PppCcp = 33021,
    RASP_PppLcp = 49185,
    RASP_PppIpv6 = 32855,
}

struct tagRASAMBW
{
    uint dwSize;
    uint dwError;
    ushort szNetBiosError;
    ubyte bLana;
}

struct tagRASAMBA
{
    uint dwSize;
    uint dwError;
    byte szNetBiosError;
    ubyte bLana;
}

struct tagRASPPPNBFW
{
    uint dwSize;
    uint dwError;
    uint dwNetBiosError;
    ushort szNetBiosError;
    ushort szWorkstationName;
    ubyte bLana;
}

struct tagRASPPPNBFA
{
    uint dwSize;
    uint dwError;
    uint dwNetBiosError;
    byte szNetBiosError;
    byte szWorkstationName;
    ubyte bLana;
}

struct tagRASIPXW
{
    uint dwSize;
    uint dwError;
    ushort szIpxAddress;
}

struct tagRASPPPIPXA
{
    uint dwSize;
    uint dwError;
    byte szIpxAddress;
}

struct tagRASPPPIPW
{
    uint dwSize;
    uint dwError;
    ushort szIpAddress;
    ushort szServerIpAddress;
    uint dwOptions;
    uint dwServerOptions;
}

struct tagRASPPPIPA
{
    uint dwSize;
    uint dwError;
    byte szIpAddress;
    byte szServerIpAddress;
    uint dwOptions;
    uint dwServerOptions;
}

struct tagRASPPPIPV6
{
    uint dwSize;
    uint dwError;
    ubyte bLocalInterfaceIdentifier;
    ubyte bPeerInterfaceIdentifier;
    ubyte bLocalCompressionProtocol;
    ubyte bPeerCompressionProtocol;
}

struct tagRASPPPLCPW
{
    uint dwSize;
    BOOL fBundled;
    uint dwError;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwEapTypeId;
    uint dwServerAuthenticationProtocol;
    uint dwServerAuthenticationData;
    uint dwServerEapTypeId;
    BOOL fMultilink;
    uint dwTerminateReason;
    uint dwServerTerminateReason;
    ushort szReplyMessage;
    uint dwOptions;
    uint dwServerOptions;
}

struct tagRASPPPLCPA
{
    uint dwSize;
    BOOL fBundled;
    uint dwError;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwEapTypeId;
    uint dwServerAuthenticationProtocol;
    uint dwServerAuthenticationData;
    uint dwServerEapTypeId;
    BOOL fMultilink;
    uint dwTerminateReason;
    uint dwServerTerminateReason;
    byte szReplyMessage;
    uint dwOptions;
    uint dwServerOptions;
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
    uint dwIPv4NegotiationError;
    in_addr ipv4Address;
    in_addr ipv4ServerAddress;
    uint dwIPv4Options;
    uint dwIPv4ServerOptions;
    uint dwIPv6NegotiationError;
    ubyte bInterfaceIdentifier;
    ubyte bServerInterfaceIdentifier;
    BOOL fBundled;
    BOOL fMultilink;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwServerAuthenticationProtocol;
    uint dwServerAuthenticationData;
    uint dwEapTypeId;
    uint dwServerEapTypeId;
    uint dwLcpOptions;
    uint dwLcpServerOptions;
    uint dwCcpError;
    uint dwCcpCompressionAlgorithm;
    uint dwCcpServerCompressionAlgorithm;
    uint dwCcpOptions;
    uint dwCcpServerOptions;
}

struct RASIKEV2_PROJECTION_INFO
{
    uint dwIPv4NegotiationError;
    in_addr ipv4Address;
    in_addr ipv4ServerAddress;
    uint dwIPv6NegotiationError;
    in6_addr ipv6Address;
    in6_addr ipv6ServerAddress;
    uint dwPrefixLength;
    uint dwAuthenticationProtocol;
    uint dwEapTypeId;
    uint dwFlags;
    uint dwEncryptionMethod;
    uint numIPv4ServerAddresses;
    in_addr* ipv4ServerAddresses;
    uint numIPv6ServerAddresses;
    in6_addr* ipv6ServerAddresses;
}

enum RASPROJECTION_INFO_TYPE
{
    PROJECTION_INFO_TYPE_PPP = 1,
    PROJECTION_INFO_TYPE_IKEv2 = 2,
}

enum IKEV2_ID_PAYLOAD_TYPE
{
    IKEV2_ID_PAYLOAD_TYPE_INVALID = 0,
    IKEV2_ID_PAYLOAD_TYPE_IPV4_ADDR = 1,
    IKEV2_ID_PAYLOAD_TYPE_FQDN = 2,
    IKEV2_ID_PAYLOAD_TYPE_RFC822_ADDR = 3,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED1 = 4,
    IKEV2_ID_PAYLOAD_TYPE_ID_IPV6_ADDR = 5,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED2 = 6,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED3 = 7,
    IKEV2_ID_PAYLOAD_TYPE_RESERVED4 = 8,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_DN = 9,
    IKEV2_ID_PAYLOAD_TYPE_DER_ASN1_GN = 10,
    IKEV2_ID_PAYLOAD_TYPE_KEY_ID = 11,
    IKEV2_ID_PAYLOAD_TYPE_MAX = 12,
}

struct RAS_PROJECTION_INFO
{
    RASAPIVERSION version;
    RASPROJECTION_INFO_TYPE type;
    _Anonymous_e__Union Anonymous;
}

alias RASDIALFUNC = extern(Windows) void function(uint param0, tagRASCONNSTATE param1, uint param2);
alias RASDIALFUNC1 = extern(Windows) void function(HRASCONN__* param0, uint param1, tagRASCONNSTATE param2, uint param3, uint param4);
alias RASDIALFUNC2 = extern(Windows) uint function(uint param0, uint param1, HRASCONN__* param2, uint param3, tagRASCONNSTATE param4, uint param5, uint param6);
struct tagRASDEVINFOW
{
    uint dwSize;
    ushort szDeviceType;
    ushort szDeviceName;
}

struct tagRASDEVINFOA
{
    uint dwSize;
    byte szDeviceType;
    byte szDeviceName;
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
    uint dwSize;
    uint dwfOptions;
    uint dwCountryID;
    uint dwCountryCode;
    byte szAreaCode;
    byte szLocalPhoneNumber;
    uint dwAlternateOffset;
    RASIPADDR ipaddr;
    RASIPADDR ipaddrDns;
    RASIPADDR ipaddrDnsAlt;
    RASIPADDR ipaddrWins;
    RASIPADDR ipaddrWinsAlt;
    uint dwFrameSize;
    uint dwfNetProtocols;
    uint dwFramingProtocol;
    byte szScript;
    byte szAutodialDll;
    byte szAutodialFunc;
    byte szDeviceType;
    byte szDeviceName;
    byte szX25PadType;
    byte szX25Address;
    byte szX25Facilities;
    byte szX25UserData;
    uint dwChannels;
    uint dwReserved1;
    uint dwReserved2;
    uint dwSubEntries;
    uint dwDialMode;
    uint dwDialExtraPercent;
    uint dwDialExtraSampleSeconds;
    uint dwHangUpExtraPercent;
    uint dwHangUpExtraSampleSeconds;
    uint dwIdleDisconnectSeconds;
    uint dwType;
    uint dwEncryptionType;
    uint dwCustomAuthKey;
    Guid guidId;
    byte szCustomDialDll;
    uint dwVpnStrategy;
    uint dwfOptions2;
    uint dwfOptions3;
    byte szDnsSuffix;
    uint dwTcpWindowSize;
    byte szPrerequisitePbk;
    byte szPrerequisiteEntry;
    uint dwRedialCount;
    uint dwRedialPause;
    in6_addr ipv6addrDns;
    in6_addr ipv6addrDnsAlt;
    uint dwIPv4InterfaceMetric;
    uint dwIPv6InterfaceMetric;
    in6_addr ipv6addr;
    uint dwIPv6PrefixLength;
    uint dwNetworkOutageTime;
    byte szIDi;
    byte szIDr;
    BOOL fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL fDisableIKEv2Fragmentation;
}

struct tagRASENTRYW
{
    uint dwSize;
    uint dwfOptions;
    uint dwCountryID;
    uint dwCountryCode;
    ushort szAreaCode;
    ushort szLocalPhoneNumber;
    uint dwAlternateOffset;
    RASIPADDR ipaddr;
    RASIPADDR ipaddrDns;
    RASIPADDR ipaddrDnsAlt;
    RASIPADDR ipaddrWins;
    RASIPADDR ipaddrWinsAlt;
    uint dwFrameSize;
    uint dwfNetProtocols;
    uint dwFramingProtocol;
    ushort szScript;
    ushort szAutodialDll;
    ushort szAutodialFunc;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szX25PadType;
    ushort szX25Address;
    ushort szX25Facilities;
    ushort szX25UserData;
    uint dwChannels;
    uint dwReserved1;
    uint dwReserved2;
    uint dwSubEntries;
    uint dwDialMode;
    uint dwDialExtraPercent;
    uint dwDialExtraSampleSeconds;
    uint dwHangUpExtraPercent;
    uint dwHangUpExtraSampleSeconds;
    uint dwIdleDisconnectSeconds;
    uint dwType;
    uint dwEncryptionType;
    uint dwCustomAuthKey;
    Guid guidId;
    ushort szCustomDialDll;
    uint dwVpnStrategy;
    uint dwfOptions2;
    uint dwfOptions3;
    ushort szDnsSuffix;
    uint dwTcpWindowSize;
    ushort szPrerequisitePbk;
    ushort szPrerequisiteEntry;
    uint dwRedialCount;
    uint dwRedialPause;
    in6_addr ipv6addrDns;
    in6_addr ipv6addrDnsAlt;
    uint dwIPv4InterfaceMetric;
    uint dwIPv6InterfaceMetric;
    in6_addr ipv6addr;
    uint dwIPv6PrefixLength;
    uint dwNetworkOutageTime;
    ushort szIDi;
    ushort szIDr;
    BOOL fIsImsConfig;
    IKEV2_ID_PAYLOAD_TYPE IdiType;
    IKEV2_ID_PAYLOAD_TYPE IdrType;
    BOOL fDisableIKEv2Fragmentation;
}

alias ORASADFUNC = extern(Windows) BOOL function(HWND param0, const(char)* param1, uint param2, uint* param3);
struct tagRASADPARAMS
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
}

alias RASADFUNCA = extern(Windows) BOOL function(const(char)* param0, const(char)* param1, tagRASADPARAMS* param2, uint* param3);
alias RASADFUNCW = extern(Windows) BOOL function(const(wchar)* param0, const(wchar)* param1, tagRASADPARAMS* param2, uint* param3);
struct tagRASSUBENTRYA
{
    uint dwSize;
    uint dwfFlags;
    byte szDeviceType;
    byte szDeviceName;
    byte szLocalPhoneNumber;
    uint dwAlternateOffset;
}

struct tagRASSUBENTRYW
{
    uint dwSize;
    uint dwfFlags;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szLocalPhoneNumber;
    uint dwAlternateOffset;
}

struct tagRASCREDENTIALSA
{
    uint dwSize;
    uint dwMask;
    byte szUserName;
    byte szPassword;
    byte szDomain;
}

struct tagRASCREDENTIALSW
{
    uint dwSize;
    uint dwMask;
    ushort szUserName;
    ushort szPassword;
    ushort szDomain;
}

struct tagRASAUTODIALENTRYA
{
    uint dwSize;
    uint dwFlags;
    uint dwDialingLocation;
    byte szEntry;
}

struct tagRASAUTODIALENTRYW
{
    uint dwSize;
    uint dwFlags;
    uint dwDialingLocation;
    ushort szEntry;
}

struct tagRASEAPUSERIDENTITYA
{
    byte szUserName;
    uint dwSizeofEapInfo;
    ubyte pbEapInfo;
}

struct tagRASEAPUSERIDENTITYW
{
    ushort szUserName;
    uint dwSizeofEapInfo;
    ubyte pbEapInfo;
}

alias PFNRASGETBUFFER = extern(Windows) uint function(ubyte** ppBuffer, uint* pdwSize);
alias PFNRASFREEBUFFER = extern(Windows) uint function(ubyte* pBufer);
alias PFNRASSENDBUFFER = extern(Windows) uint function(HANDLE hPort, ubyte* pBuffer, uint dwSize);
alias PFNRASRECEIVEBUFFER = extern(Windows) uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize, uint dwTimeOut, HANDLE hEvent);
alias PFNRASRETRIEVEBUFFER = extern(Windows) uint function(HANDLE hPort, ubyte* pBuffer, uint* pdwSize);
alias RasCustomScriptExecuteFn = extern(Windows) uint function(HANDLE hPort, const(wchar)* lpszPhonebook, const(wchar)* lpszEntryName, PFNRASGETBUFFER pfnRasGetBuffer, PFNRASFREEBUFFER pfnRasFreeBuffer, PFNRASSENDBUFFER pfnRasSendBuffer, PFNRASRECEIVEBUFFER pfnRasReceiveBuffer, PFNRASRETRIEVEBUFFER pfnRasRetrieveBuffer, HWND hWnd, tagRASDIALPARAMSA* pRasDialParams, void* pvReserved);
struct tagRASCOMMSETTINGS
{
    uint dwSize;
    ubyte bParity;
    ubyte bStop;
    ubyte bByteSize;
    ubyte bAlign;
}

alias PFNRASSETCOMMSETTINGS = extern(Windows) uint function(HANDLE hPort, tagRASCOMMSETTINGS* pRasCommSettings, void* pvReserved);
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

alias RasCustomHangUpFn = extern(Windows) uint function(HRASCONN__* hRasConn);
alias RasCustomDialFn = extern(Windows) uint function(HINSTANCE hInstDll, tagRASDIALEXTENSIONS* lpRasDialExtensions, const(wchar)* lpszPhonebook, tagRASDIALPARAMSA* lpRasDialParams, uint dwNotifierType, void* lpvNotifier, HRASCONN__** lphRasConn, uint dwFlags);
alias RasCustomDeleteEntryNotifyFn = extern(Windows) uint function(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, uint dwFlags);
struct tagRASUPDATECONN
{
    RASAPIVERSION version;
    uint dwSize;
    uint dwFlags;
    uint dwIfIndex;
    tagRASTUNNELENDPOINT localEndPoint;
    tagRASTUNNELENDPOINT remoteEndPoint;
}

alias RASPBDLGFUNCW = extern(Windows) void function(uint param0, uint param1, const(wchar)* param2, void* param3);
alias RASPBDLGFUNCA = extern(Windows) void function(uint param0, uint param1, const(char)* param2, void* param3);
struct tagRASNOUSERW
{
    uint dwSize;
    uint dwFlags;
    uint dwTimeoutMs;
    ushort szUserName;
    ushort szPassword;
    ushort szDomain;
}

struct tagRASNOUSERA
{
    uint dwSize;
    uint dwFlags;
    uint dwTimeoutMs;
    byte szUserName;
    byte szPassword;
    byte szDomain;
}

struct tagRASPBDLGW
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
    uint dwCallbackId;
    RASPBDLGFUNCW pCallback;
    uint dwError;
    uint reserved;
    uint reserved2;
}

struct tagRASPBDLGA
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
    uint dwCallbackId;
    RASPBDLGFUNCA pCallback;
    uint dwError;
    uint reserved;
    uint reserved2;
}

struct tagRASENTRYDLGW
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
    ushort szEntry;
    uint dwError;
    uint reserved;
    uint reserved2;
}

struct tagRASENTRYDLGA
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
    byte szEntry;
    uint dwError;
    uint reserved;
    uint reserved2;
}

struct tagRASDIALDLG
{
    uint dwSize;
    HWND hwndOwner;
    uint dwFlags;
    int xDlg;
    int yDlg;
    uint dwSubEntry;
    uint dwError;
    uint reserved;
    uint reserved2;
}

alias RasCustomDialDlgFn = extern(Windows) BOOL function(HINSTANCE hInstDll, uint dwFlags, const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, const(wchar)* lpszPhoneNumber, tagRASDIALDLG* lpInfo, void* pvInfo);
alias RasCustomEntryDlgFn = extern(Windows) BOOL function(HINSTANCE hInstDll, const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, tagRASENTRYDLGA* lpInfo, uint dwFlags);
enum ROUTER_INTERFACE_TYPE
{
    ROUTER_IF_TYPE_CLIENT = 0,
    ROUTER_IF_TYPE_HOME_ROUTER = 1,
    ROUTER_IF_TYPE_FULL_ROUTER = 2,
    ROUTER_IF_TYPE_DEDICATED = 3,
    ROUTER_IF_TYPE_INTERNAL = 4,
    ROUTER_IF_TYPE_LOOPBACK = 5,
    ROUTER_IF_TYPE_TUNNEL1 = 6,
    ROUTER_IF_TYPE_DIALOUT = 7,
    ROUTER_IF_TYPE_MAX = 8,
}

enum ROUTER_CONNECTION_STATE
{
    ROUTER_IF_STATE_UNREACHABLE = 0,
    ROUTER_IF_STATE_DISCONNECTED = 1,
    ROUTER_IF_STATE_CONNECTING = 2,
    ROUTER_IF_STATE_CONNECTED = 3,
}

struct MPR_INTERFACE_0
{
    ushort wszInterfaceName;
    HANDLE hInterface;
    BOOL fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint fUnReachabilityReasons;
    uint dwLastError;
}

struct MPR_IPINIP_INTERFACE_0
{
    ushort wszFriendlyName;
    Guid Guid;
}

struct MPR_INTERFACE_1
{
    ushort wszInterfaceName;
    HANDLE hInterface;
    BOOL fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint fUnReachabilityReasons;
    uint dwLastError;
    const(wchar)* lpwsDialoutHoursRestriction;
}

struct MPR_INTERFACE_2
{
    ushort wszInterfaceName;
    HANDLE hInterface;
    BOOL fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint fUnReachabilityReasons;
    uint dwLastError;
    uint dwfOptions;
    ushort szLocalPhoneNumber;
    const(wchar)* szAlternates;
    uint ipaddr;
    uint ipaddrDns;
    uint ipaddrDnsAlt;
    uint ipaddrWins;
    uint ipaddrWinsAlt;
    uint dwfNetProtocols;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szX25PadType;
    ushort szX25Address;
    ushort szX25Facilities;
    ushort szX25UserData;
    uint dwChannels;
    uint dwSubEntries;
    uint dwDialMode;
    uint dwDialExtraPercent;
    uint dwDialExtraSampleSeconds;
    uint dwHangUpExtraPercent;
    uint dwHangUpExtraSampleSeconds;
    uint dwIdleDisconnectSeconds;
    uint dwType;
    uint dwEncryptionType;
    uint dwCustomAuthKey;
    uint dwCustomAuthDataSize;
    ubyte* lpbCustomAuthData;
    Guid guidId;
    uint dwVpnStrategy;
}

struct MPR_INTERFACE_3
{
    ushort wszInterfaceName;
    HANDLE hInterface;
    BOOL fEnabled;
    ROUTER_INTERFACE_TYPE dwIfType;
    ROUTER_CONNECTION_STATE dwConnectionState;
    uint fUnReachabilityReasons;
    uint dwLastError;
    uint dwfOptions;
    ushort szLocalPhoneNumber;
    const(wchar)* szAlternates;
    uint ipaddr;
    uint ipaddrDns;
    uint ipaddrDnsAlt;
    uint ipaddrWins;
    uint ipaddrWinsAlt;
    uint dwfNetProtocols;
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szX25PadType;
    ushort szX25Address;
    ushort szX25Facilities;
    ushort szX25UserData;
    uint dwChannels;
    uint dwSubEntries;
    uint dwDialMode;
    uint dwDialExtraPercent;
    uint dwDialExtraSampleSeconds;
    uint dwHangUpExtraPercent;
    uint dwHangUpExtraSampleSeconds;
    uint dwIdleDisconnectSeconds;
    uint dwType;
    uint dwEncryptionType;
    uint dwCustomAuthKey;
    uint dwCustomAuthDataSize;
    ubyte* lpbCustomAuthData;
    Guid guidId;
    uint dwVpnStrategy;
    uint AddressCount;
    in6_addr ipv6addrDns;
    in6_addr ipv6addrDnsAlt;
    in6_addr* ipv6addr;
}

struct MPR_DEVICE_0
{
    ushort szDeviceType;
    ushort szDeviceName;
}

struct MPR_DEVICE_1
{
    ushort szDeviceType;
    ushort szDeviceName;
    ushort szLocalPhoneNumber;
    const(wchar)* szAlternates;
}

struct MPR_CREDENTIALSEX_0
{
    uint dwSize;
    ubyte* lpbCredentialsInfo;
}

struct MPR_CREDENTIALSEX_1
{
    uint dwSize;
    ubyte* lpbCredentialsInfo;
}

struct MPR_TRANSPORT_0
{
    uint dwTransportId;
    HANDLE hTransport;
    ushort wszTransportName;
}

struct MPR_IFTRANSPORT_0
{
    uint dwTransportId;
    HANDLE hIfTransport;
    ushort wszIfTransportName;
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

enum RAS_PORT_CONDITION
{
    RAS_PORT_NON_OPERATIONAL = 0,
    RAS_PORT_DISCONNECTED = 1,
    RAS_PORT_CALLING_BACK = 2,
    RAS_PORT_LISTENING = 3,
    RAS_PORT_AUTHENTICATING = 4,
    RAS_PORT_AUTHENTICATED = 5,
    RAS_PORT_INITIALIZING = 6,
}

enum RAS_HARDWARE_CONDITION
{
    RAS_HARDWARE_OPERATIONAL = 0,
    RAS_HARDWARE_FAILURE = 1,
}

struct RAS_PORT_0
{
    HANDLE hPort;
    HANDLE hConnection;
    RAS_PORT_CONDITION dwPortCondition;
    uint dwTotalNumberOfCalls;
    uint dwConnectDuration;
    ushort wszPortName;
    ushort wszMediaName;
    ushort wszDeviceName;
    ushort wszDeviceType;
}

struct RAS_PORT_1
{
    HANDLE hPort;
    HANDLE hConnection;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint dwLineSpeed;
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
}

struct RAS_PORT_2
{
    HANDLE hPort;
    HANDLE hConnection;
    uint dwConn_State;
    ushort wszPortName;
    ushort wszMediaName;
    ushort wszDeviceName;
    ushort wszDeviceType;
    RAS_HARDWARE_CONDITION dwHardwareCondition;
    uint dwLineSpeed;
    uint dwCrcErr;
    uint dwSerialOverRunErrs;
    uint dwTimeoutErr;
    uint dwAlignmentErr;
    uint dwHardwareOverrunErr;
    uint dwFramingErr;
    uint dwBufferOverrunErr;
    uint dwCompressionRatioIn;
    uint dwCompressionRatioOut;
    uint dwTotalErrors;
    ulong ullBytesXmited;
    ulong ullBytesRcved;
    ulong ullFramesXmited;
    ulong ullFramesRcved;
    ulong ullBytesTxUncompressed;
    ulong ullBytesTxCompressed;
    ulong ullBytesRcvUncompressed;
    ulong ullBytesRcvCompressed;
}

struct PPP_NBFCP_INFO
{
    uint dwError;
    ushort wszWksta;
}

struct PPP_IPCP_INFO
{
    uint dwError;
    ushort wszAddress;
    ushort wszRemoteAddress;
}

struct PPP_IPCP_INFO2
{
    uint dwError;
    ushort wszAddress;
    ushort wszRemoteAddress;
    uint dwOptions;
    uint dwRemoteOptions;
}

struct PPP_IPXCP_INFO
{
    uint dwError;
    ushort wszAddress;
}

struct PPP_ATCP_INFO
{
    uint dwError;
    ushort wszAddress;
}

struct PPP_IPV6_CP_INFO
{
    uint dwVersion;
    uint dwSize;
    uint dwError;
    ubyte bInterfaceIdentifier;
    ubyte bRemoteInterfaceIdentifier;
    uint dwOptions;
    uint dwRemoteOptions;
    ubyte bPrefix;
    uint dwPrefixLength;
}

struct PPP_INFO
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO ip;
    PPP_IPXCP_INFO ipx;
    PPP_ATCP_INFO at;
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
    PPP_ATCP_INFO at;
    PPP_CCP_INFO ccp;
    PPP_LCP_INFO lcp;
}

struct PPP_INFO_3
{
    PPP_NBFCP_INFO nbf;
    PPP_IPCP_INFO2 ip;
    PPP_IPV6_CP_INFO ipv6;
    PPP_CCP_INFO ccp;
    PPP_LCP_INFO lcp;
}

struct RAS_CONNECTION_0
{
    HANDLE hConnection;
    HANDLE hInterface;
    uint dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint dwConnectionFlags;
    ushort wszInterfaceName;
    ushort wszUserName;
    ushort wszLogonDomain;
    ushort wszRemoteComputer;
}

struct RAS_CONNECTION_1
{
    HANDLE hConnection;
    HANDLE hInterface;
    PPP_INFO PppInfo;
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
}

struct RAS_CONNECTION_2
{
    HANDLE hConnection;
    ushort wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    Guid guid;
    PPP_INFO_2 PppInfo2;
}

enum RAS_QUARANTINE_STATE
{
    RAS_QUAR_STATE_NORMAL = 0,
    RAS_QUAR_STATE_QUARANTINE = 1,
    RAS_QUAR_STATE_PROBATION = 2,
    RAS_QUAR_STATE_NOT_CAPABLE = 3,
}

struct RAS_CONNECTION_3
{
    uint dwVersion;
    uint dwSize;
    HANDLE hConnection;
    ushort wszUserName;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    Guid guid;
    PPP_INFO_3 PppInfo3;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME timer;
}

struct RAS_USER_0
{
    ubyte bfPrivilege;
    ushort wszPhoneNumber;
}

struct RAS_USER_1
{
    ubyte bfPrivilege;
    ushort wszPhoneNumber;
    ubyte bfPrivilege2;
}

struct MPR_FILTER_0
{
    BOOL fEnable;
}

struct MPRAPI_OBJECT_HEADER
{
    ubyte revision;
    ubyte type;
    ushort size;
}

enum MPRAPI_OBJECT_TYPE
{
    MPRAPI_OBJECT_TYPE_RAS_CONNECTION_OBJECT = 1,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_OBJECT = 2,
    MPRAPI_OBJECT_TYPE_MPR_SERVER_SET_CONFIG_OBJECT = 3,
    MPRAPI_OBJECT_TYPE_AUTH_VALIDATION_OBJECT = 4,
    MPRAPI_OBJECT_TYPE_UPDATE_CONNECTION_OBJECT = 5,
    MPRAPI_OBJECT_TYPE_IF_CUSTOM_CONFIG_OBJECT = 6,
}

struct PPP_PROJECTION_INFO
{
    uint dwIPv4NegotiationError;
    ushort wszAddress;
    ushort wszRemoteAddress;
    uint dwIPv4Options;
    uint dwIPv4RemoteOptions;
    ulong IPv4SubInterfaceIndex;
    uint dwIPv6NegotiationError;
    ubyte bInterfaceIdentifier;
    ubyte bRemoteInterfaceIdentifier;
    ubyte bPrefix;
    uint dwPrefixLength;
    ulong IPv6SubInterfaceIndex;
    uint dwLcpError;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwRemoteAuthenticationProtocol;
    uint dwRemoteAuthenticationData;
    uint dwLcpTerminateReason;
    uint dwLcpRemoteTerminateReason;
    uint dwLcpOptions;
    uint dwLcpRemoteOptions;
    uint dwEapTypeId;
    uint dwRemoteEapTypeId;
    uint dwCcpError;
    uint dwCompressionAlgorithm;
    uint dwCcpOptions;
    uint dwRemoteCompressionAlgorithm;
    uint dwCcpRemoteOptions;
}

struct PPP_PROJECTION_INFO2
{
    uint dwIPv4NegotiationError;
    ushort wszAddress;
    ushort wszRemoteAddress;
    uint dwIPv4Options;
    uint dwIPv4RemoteOptions;
    ulong IPv4SubInterfaceIndex;
    uint dwIPv6NegotiationError;
    ubyte bInterfaceIdentifier;
    ubyte bRemoteInterfaceIdentifier;
    ubyte bPrefix;
    uint dwPrefixLength;
    ulong IPv6SubInterfaceIndex;
    uint dwLcpError;
    uint dwAuthenticationProtocol;
    uint dwAuthenticationData;
    uint dwRemoteAuthenticationProtocol;
    uint dwRemoteAuthenticationData;
    uint dwLcpTerminateReason;
    uint dwLcpRemoteTerminateReason;
    uint dwLcpOptions;
    uint dwLcpRemoteOptions;
    uint dwEapTypeId;
    uint dwEmbeddedEAPTypeId;
    uint dwRemoteEapTypeId;
    uint dwCcpError;
    uint dwCompressionAlgorithm;
    uint dwCcpOptions;
    uint dwRemoteCompressionAlgorithm;
    uint dwCcpRemoteOptions;
}

struct IKEV2_PROJECTION_INFO
{
    uint dwIPv4NegotiationError;
    ushort wszAddress;
    ushort wszRemoteAddress;
    ulong IPv4SubInterfaceIndex;
    uint dwIPv6NegotiationError;
    ubyte bInterfaceIdentifier;
    ubyte bRemoteInterfaceIdentifier;
    ubyte bPrefix;
    uint dwPrefixLength;
    ulong IPv6SubInterfaceIndex;
    uint dwOptions;
    uint dwAuthenticationProtocol;
    uint dwEapTypeId;
    uint dwCompressionAlgorithm;
    uint dwEncryptionMethod;
}

struct IKEV2_PROJECTION_INFO2
{
    uint dwIPv4NegotiationError;
    ushort wszAddress;
    ushort wszRemoteAddress;
    ulong IPv4SubInterfaceIndex;
    uint dwIPv6NegotiationError;
    ubyte bInterfaceIdentifier;
    ubyte bRemoteInterfaceIdentifier;
    ubyte bPrefix;
    uint dwPrefixLength;
    ulong IPv6SubInterfaceIndex;
    uint dwOptions;
    uint dwAuthenticationProtocol;
    uint dwEapTypeId;
    uint dwEmbeddedEAPTypeId;
    uint dwCompressionAlgorithm;
    uint dwEncryptionMethod;
}

struct PROJECTION_INFO
{
    ubyte projectionInfoType;
    _Anonymous_e__Union Anonymous;
}

struct PROJECTION_INFO2
{
    ubyte projectionInfoType;
    _Anonymous_e__Union Anonymous;
}

struct RAS_CONNECTION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    uint dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint dwConnectionFlags;
    ushort wszInterfaceName;
    ushort wszUserName;
    ushort wszLogonDomain;
    ushort wszRemoteComputer;
    Guid guid;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME probationTime;
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
    uint dwNumSwitchOvers;
    ushort wszRemoteEndpointAddress;
    ushort wszLocalEndpointAddress;
    PROJECTION_INFO ProjectionInfo;
    HANDLE hConnection;
    HANDLE hInterface;
}

struct RAS_CONNECTION_4
{
    uint dwConnectDuration;
    ROUTER_INTERFACE_TYPE dwInterfaceType;
    uint dwConnectionFlags;
    ushort wszInterfaceName;
    ushort wszUserName;
    ushort wszLogonDomain;
    ushort wszRemoteComputer;
    Guid guid;
    RAS_QUARANTINE_STATE rasQuarState;
    FILETIME probationTime;
    FILETIME connectionStartTime;
    ulong ullBytesXmited;
    ulong ullBytesRcved;
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
    uint dwNumSwitchOvers;
    ushort wszRemoteEndpointAddress;
    ushort wszLocalEndpointAddress;
    PROJECTION_INFO2 ProjectionInfo;
    HANDLE hConnection;
    HANDLE hInterface;
    uint dwDeviceType;
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
    uint dwSaLifeTime;
    uint dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
}

struct MPR_IF_CUSTOMINFOEX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG0 customIkev2Config;
}

struct MPR_CERT_EKU
{
    uint dwSize;
    BOOL IsEKUOID;
    ushort* pwszEKU;
}

struct VPN_TS_IP_ADDRESS
{
    ushort Type;
    _Anonymous_e__Union Anonymous;
}

enum MPR_VPN_TS_TYPE
{
    MPR_VPN_TS_IPv4_ADDR_RANGE = 7,
    MPR_VPN_TS_IPv6_ADDR_RANGE = 8,
}

struct _MPR_VPN_SELECTOR
{
    MPR_VPN_TS_TYPE type;
    ubyte protocolId;
    ushort portStart;
    ushort portEnd;
    ushort tsPayloadId;
    VPN_TS_IP_ADDRESS addrStart;
    VPN_TS_IP_ADDRESS addrEnd;
}

struct MPR_VPN_TRAFFIC_SELECTORS
{
    uint numTsi;
    uint numTsr;
    _MPR_VPN_SELECTOR* tsI;
    _MPR_VPN_SELECTOR* tsR;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG2
{
    uint dwSaLifeTime;
    uint dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
    uint dwMmSaLifeTime;
    MPR_VPN_TRAFFIC_SELECTORS vpnTrafficSelectors;
}

struct MPR_IF_CUSTOMINFOEX2
{
    MPRAPI_OBJECT_HEADER Header;
    uint dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG2 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS4
{
    uint dwIdleTimeout;
    uint dwNetworkBlackoutTime;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    uint dwConfigOptions;
    uint dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB machineCertificateName;
    uint dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint dwTotalEkus;
    MPR_CERT_EKU* certificateEKUs;
    CRYPTOAPI_BLOB machineCertificateHash;
    uint dwMmSaLifeTime;
}

struct ROUTER_IKEv2_IF_CUSTOM_CONFIG1
{
    uint dwSaLifeTime;
    uint dwSaDataSize;
    CRYPTOAPI_BLOB certificateName;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    CRYPTOAPI_BLOB certificateHash;
}

struct MPR_IF_CUSTOMINFOEX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint dwFlags;
    ROUTER_IKEv2_IF_CUSTOM_CONFIG1 customIkev2Config;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS3
{
    uint dwIdleTimeout;
    uint dwNetworkBlackoutTime;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    uint dwConfigOptions;
    uint dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB machineCertificateName;
    uint dwEncryptionType;
    ROUTER_CUSTOM_IKEv2_POLICY0* customPolicy;
    uint dwTotalEkus;
    MPR_CERT_EKU* certificateEKUs;
    CRYPTOAPI_BLOB machineCertificateHash;
}

struct IKEV2_TUNNEL_CONFIG_PARAMS2
{
    uint dwIdleTimeout;
    uint dwNetworkBlackoutTime;
    uint dwSaLifeTime;
    uint dwSaDataSizeForRenegotiation;
    uint dwConfigOptions;
    uint dwTotalCertificates;
    CRYPTOAPI_BLOB* certificateNames;
    CRYPTOAPI_BLOB machineCertificateName;
    uint dwEncryptionType;
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
    BOOL isDefault;
    CRYPTOAPI_BLOB certBlob;
}

struct SSTP_CONFIG_PARAMS
{
    uint dwNumPorts;
    uint dwPortFlags;
    BOOL isUseHttps;
    uint certAlgorithm;
    SSTP_CERT_INFO sstpCertDetails;
}

struct MPRAPI_TUNNEL_CONFIG_PARAMS0
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS SstpConfigParams;
}

struct MPRAPI_TUNNEL_CONFIG_PARAMS1
{
    IKEV2_CONFIG_PARAMS IkeConfigParams;
    PPTP_CONFIG_PARAMS PptpConfigParams;
    L2TP_CONFIG_PARAMS1 L2tpConfigParams;
    SSTP_CONFIG_PARAMS SstpConfigParams;
    GRE_CONFIG_PARAMS0 GREConfigParams;
}

struct MPR_SERVER_EX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint fLanOnlyMode;
    uint dwUpTime;
    uint dwTotalPorts;
    uint dwPortsInUse;
    uint Reserved;
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

struct MPR_SERVER_EX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint fLanOnlyMode;
    uint dwUpTime;
    uint dwTotalPorts;
    uint dwPortsInUse;
    uint Reserved;
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

struct MPR_SERVER_SET_CONFIG_EX0
{
    MPRAPI_OBJECT_HEADER Header;
    uint setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS0 ConfigParams;
}

struct MPR_SERVER_SET_CONFIG_EX1
{
    MPRAPI_OBJECT_HEADER Header;
    uint setConfigForProtocols;
    MPRAPI_TUNNEL_CONFIG_PARAMS1 ConfigParams;
}

struct AUTH_VALIDATION_EX
{
    MPRAPI_OBJECT_HEADER Header;
    HANDLE hRasConnection;
    ushort wszUserName;
    ushort wszLogonDomain;
    uint AuthInfoSize;
    ubyte AuthInfo;
}

struct RAS_UPDATE_CONNECTION
{
    MPRAPI_OBJECT_HEADER Header;
    uint dwIfIndex;
    ushort wszLocalEndpointAddress;
    ushort wszRemoteEndpointAddress;
}

alias PMPRADMINGETIPADDRESSFORUSER = extern(Windows) uint function(ushort* param0, ushort* param1, uint* param2, int* param3);
alias PMPRADMINRELEASEIPADRESS = extern(Windows) void function(ushort* param0, ushort* param1, uint* param2);
alias PMPRADMINGETIPV6ADDRESSFORUSER = extern(Windows) uint function(ushort* param0, ushort* param1, in6_addr* param2, int* param3);
alias PMPRADMINRELEASEIPV6ADDRESSFORUSER = extern(Windows) void function(ushort* param0, ushort* param1, in6_addr* param2);
alias PMPRADMINACCEPTNEWCONNECTION = extern(Windows) BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINACCEPTNEWCONNECTION2 = extern(Windows) BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, RAS_CONNECTION_2* param2);
alias PMPRADMINACCEPTNEWCONNECTION3 = extern(Windows) BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWLINK = extern(Windows) BOOL function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION = extern(Windows) void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION2 = extern(Windows) void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, RAS_CONNECTION_2* param2);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATION3 = extern(Windows) void function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, RAS_CONNECTION_2* param2, RAS_CONNECTION_3 param3);
alias PMPRADMINLINKHANGUPNOTIFICATION = extern(Windows) void function(RAS_PORT_0* param0, RAS_PORT_1* param1);
alias PMPRADMINTERMINATEDLL = extern(Windows) uint function();
alias PMPRADMINACCEPTREAUTHENTICATION = extern(Windows) BOOL function(RAS_CONNECTION_0* param0, RAS_CONNECTION_1* param1, RAS_CONNECTION_2* param2, RAS_CONNECTION_3* param3);
alias PMPRADMINACCEPTNEWCONNECTIONEX = extern(Windows) BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTREAUTHENTICATIONEX = extern(Windows) BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINACCEPTTUNNELENDPOINTCHANGEEX = extern(Windows) BOOL function(RAS_CONNECTION_EX* param0);
alias PMPRADMINCONNECTIONHANGUPNOTIFICATIONEX = extern(Windows) void function(RAS_CONNECTION_EX* param0);
alias PMPRADMINRASVALIDATEPREAUTHENTICATEDCONNECTIONEX = extern(Windows) uint function(AUTH_VALIDATION_EX* param0);
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
    uint dwMsgId;
    int hPort;
    uint dwError;
    byte UserName;
    byte Domain;
}

struct RAS_SECURITY_INFO
{
    uint LastError;
    uint BytesReceived;
    byte DeviceName;
}

alias RASSECURITYPROC = extern(Windows) uint function();
struct MGM_IF_ENTRY
{
    uint dwIfIndex;
    uint dwIfNextHopAddr;
    BOOL bIGMP;
    BOOL bIsEnabled;
}

alias PMGM_RPF_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint* pdwInIfIndex, uint* pdwInIfNextHopAddr, uint* pdwUpStreamNbr, uint dwHdrSize, ubyte* pbPacketHdr, ubyte* pbRoute);
alias PMGM_CREATION_ALERT_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwInIfIndex, uint dwInIfNextHopAddr, uint dwIfCount, MGM_IF_ENTRY* pmieOutIfList);
alias PMGM_PRUNE_ALERT_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr, BOOL bMemberDelete, uint* pdwTimeout);
alias PMGM_JOIN_ALERT_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, BOOL bMemberUpdate);
alias PMGM_WRONG_IF_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwGroupAddr, uint dwIfIndex, uint dwIfNextHopAddr, uint dwHdrSize, ubyte* pbPacketHdr);
alias PMGM_LOCAL_JOIN_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_LOCAL_LEAVE_CALLBACK = extern(Windows) uint function(uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_DISABLE_IGMP_CALLBACK = extern(Windows) uint function(uint dwIfIndex, uint dwIfNextHopAddr);
alias PMGM_ENABLE_IGMP_CALLBACK = extern(Windows) uint function(uint dwIfIndex, uint dwIfNextHopAddr);
struct ROUTING_PROTOCOL_CONFIG
{
    uint dwCallbackFlags;
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

enum MGM_ENUM_TYPES
{
    ANY_SOURCE = 0,
    ALL_SOURCES = 1,
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
    ushort AddressFamily;
    ushort NumBits;
    ubyte AddrBits;
}

struct RTM_PREF_INFO
{
    uint Metric;
    uint Preference;
}

struct RTM_NEXTHOP_LIST
{
    ushort NumNextHops;
    int NextHops;
}

struct RTM_DEST_INFO
{
    int DestHandle;
    RTM_NET_ADDRESS DestAddress;
    FILETIME LastChanged;
    uint BelongsToViews;
    uint NumberOfViews;
    _Anonymous_e__Struct ViewInfo;
}

struct RTM_ROUTE_INFO
{
    int DestHandle;
    int RouteOwner;
    int Neighbour;
    ubyte State;
    ubyte Flags1;
    ushort Flags;
    RTM_PREF_INFO PrefInfo;
    uint BelongsToViews;
    void* EntitySpecificInfo;
    RTM_NEXTHOP_LIST NextHopsList;
}

struct RTM_NEXTHOP_INFO
{
    RTM_NET_ADDRESS NextHopAddress;
    int NextHopOwner;
    uint InterfaceIndex;
    ushort State;
    ushort Flags;
    void* EntitySpecificInfo;
    int RemoteNextHop;
}

struct RTM_ENTITY_ID
{
    _Anonymous_e__Union Anonymous;
}

struct RTM_ENTITY_INFO
{
    ushort RtmInstanceId;
    ushort AddressFamily;
    RTM_ENTITY_ID EntityId;
}

enum RTM_EVENT_TYPE
{
    RTM_ENTITY_REGISTERED = 0,
    RTM_ENTITY_DEREGISTERED = 1,
    RTM_ROUTE_EXPIRED = 2,
    RTM_CHANGE_NOTIFICATION = 3,
}

alias _EVENT_CALLBACK = extern(Windows) uint function(int RtmRegHandle, RTM_EVENT_TYPE EventType, void* Context1, void* Context2);
alias RTM_EVENT_CALLBACK = extern(Windows) uint function();
alias PRTM_EVENT_CALLBACK = extern(Windows) uint function();
struct RTM_ENTITY_METHOD_INPUT
{
    uint MethodType;
    uint InputSize;
    ubyte InputData;
}

struct RTM_ENTITY_METHOD_OUTPUT
{
    uint MethodType;
    uint MethodStatus;
    uint OutputSize;
    ubyte OutputData;
}

alias _ENTITY_METHOD = extern(Windows) void function(int CallerHandle, int CalleeHandle, RTM_ENTITY_METHOD_INPUT* Input, RTM_ENTITY_METHOD_OUTPUT* Output);
alias RTM_ENTITY_EXPORT_METHOD = extern(Windows) void function();
alias PRTM_ENTITY_EXPORT_METHOD = extern(Windows) void function();
struct RTM_ENTITY_EXPORT_METHODS
{
    uint NumMethods;
    int Methods;
}

@DllImport("RASAPI32.dll")
uint RasDialA(tagRASDIALEXTENSIONS* param0, const(char)* param1, tagRASDIALPARAMSA* param2, uint param3, void* param4, HRASCONN__** param5);

@DllImport("RASAPI32.dll")
uint RasDialW(tagRASDIALEXTENSIONS* param0, const(wchar)* param1, tagRASDIALPARAMSW* param2, uint param3, void* param4, HRASCONN__** param5);

@DllImport("RASAPI32.dll")
uint RasEnumConnectionsA(tagRASCONNA* param0, uint* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasEnumConnectionsW(tagRASCONNW* param0, uint* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasEnumEntriesA(const(char)* param0, const(char)* param1, tagRASENTRYNAMEA* param2, uint* param3, uint* param4);

@DllImport("RASAPI32.dll")
uint RasEnumEntriesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYNAMEW* param2, uint* param3, uint* param4);

@DllImport("RASAPI32.dll")
uint RasGetConnectStatusA(HRASCONN__* param0, tagRASCONNSTATUSA* param1);

@DllImport("RASAPI32.dll")
uint RasGetConnectStatusW(HRASCONN__* param0, tagRASCONNSTATUSW* param1);

@DllImport("RASAPI32.dll")
uint RasGetErrorStringA(uint ResourceId, const(char)* lpszString, uint InBufSize);

@DllImport("RASAPI32.dll")
uint RasGetErrorStringW(uint ResourceId, const(wchar)* lpszString, uint InBufSize);

@DllImport("RASAPI32.dll")
uint RasHangUpA(HRASCONN__* param0);

@DllImport("RASAPI32.dll")
uint RasHangUpW(HRASCONN__* param0);

@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoA(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoW(HRASCONN__* param0, tagRASPROJECTION param1, void* param2, uint* param3);

@DllImport("RASAPI32.dll")
uint RasCreatePhonebookEntryA(HWND param0, const(char)* param1);

@DllImport("RASAPI32.dll")
uint RasCreatePhonebookEntryW(HWND param0, const(wchar)* param1);

@DllImport("RASAPI32.dll")
uint RasEditPhonebookEntryA(HWND param0, const(char)* param1, const(char)* param2);

@DllImport("RASAPI32.dll")
uint RasEditPhonebookEntryW(HWND param0, const(wchar)* param1, const(wchar)* param2);

@DllImport("RASAPI32.dll")
uint RasSetEntryDialParamsA(const(char)* param0, tagRASDIALPARAMSA* param1, BOOL param2);

@DllImport("RASAPI32.dll")
uint RasSetEntryDialParamsW(const(wchar)* param0, tagRASDIALPARAMSW* param1, BOOL param2);

@DllImport("RASAPI32.dll")
uint RasGetEntryDialParamsA(const(char)* param0, tagRASDIALPARAMSA* param1, int* param2);

@DllImport("RASAPI32.dll")
uint RasGetEntryDialParamsW(const(wchar)* param0, tagRASDIALPARAMSW* param1, int* param2);

@DllImport("RASAPI32.dll")
uint RasEnumDevicesA(tagRASDEVINFOA* param0, uint* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasEnumDevicesW(tagRASDEVINFOW* param0, uint* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasGetCountryInfoA(RASCTRYINFO* param0, uint* param1);

@DllImport("RASAPI32.dll")
uint RasGetCountryInfoW(RASCTRYINFO* param0, uint* param1);

@DllImport("RASAPI32.dll")
uint RasGetEntryPropertiesA(const(char)* param0, const(char)* param1, tagRASENTRYA* param2, uint* param3, ubyte* param4, uint* param5);

@DllImport("RASAPI32.dll")
uint RasGetEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYW* param2, uint* param3, ubyte* param4, uint* param5);

@DllImport("RASAPI32.dll")
uint RasSetEntryPropertiesA(const(char)* param0, const(char)* param1, tagRASENTRYA* param2, uint param3, ubyte* param4, uint param5);

@DllImport("RASAPI32.dll")
uint RasSetEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, tagRASENTRYW* param2, uint param3, ubyte* param4, uint param5);

@DllImport("RASAPI32.dll")
uint RasRenameEntryA(const(char)* param0, const(char)* param1, const(char)* param2);

@DllImport("RASAPI32.dll")
uint RasRenameEntryW(const(wchar)* param0, const(wchar)* param1, const(wchar)* param2);

@DllImport("RASAPI32.dll")
uint RasDeleteEntryA(const(char)* param0, const(char)* param1);

@DllImport("RASAPI32.dll")
uint RasDeleteEntryW(const(wchar)* param0, const(wchar)* param1);

@DllImport("RASAPI32.dll")
uint RasValidateEntryNameA(const(char)* param0, const(char)* param1);

@DllImport("RASAPI32.dll")
uint RasValidateEntryNameW(const(wchar)* param0, const(wchar)* param1);

@DllImport("RASAPI32.dll")
uint RasConnectionNotificationA(HRASCONN__* param0, HANDLE param1, uint param2);

@DllImport("RASAPI32.dll")
uint RasConnectionNotificationW(HRASCONN__* param0, HANDLE param1, uint param2);

@DllImport("RASAPI32.dll")
uint RasGetSubEntryHandleA(HRASCONN__* param0, uint param1, HRASCONN__** param2);

@DllImport("RASAPI32.dll")
uint RasGetSubEntryHandleW(HRASCONN__* param0, uint param1, HRASCONN__** param2);

@DllImport("RASAPI32.dll")
uint RasGetCredentialsA(const(char)* param0, const(char)* param1, tagRASCREDENTIALSA* param2);

@DllImport("RASAPI32.dll")
uint RasGetCredentialsW(const(wchar)* param0, const(wchar)* param1, tagRASCREDENTIALSW* param2);

@DllImport("RASAPI32.dll")
uint RasSetCredentialsA(const(char)* param0, const(char)* param1, tagRASCREDENTIALSA* param2, BOOL param3);

@DllImport("RASAPI32.dll")
uint RasSetCredentialsW(const(wchar)* param0, const(wchar)* param1, tagRASCREDENTIALSW* param2, BOOL param3);

@DllImport("RASAPI32.dll")
uint RasGetSubEntryPropertiesA(const(char)* param0, const(char)* param1, uint param2, tagRASSUBENTRYA* param3, uint* param4, ubyte* param5, uint* param6);

@DllImport("RASAPI32.dll")
uint RasGetSubEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, uint param2, tagRASSUBENTRYW* param3, uint* param4, ubyte* param5, uint* param6);

@DllImport("RASAPI32.dll")
uint RasSetSubEntryPropertiesA(const(char)* param0, const(char)* param1, uint param2, tagRASSUBENTRYA* param3, uint param4, ubyte* param5, uint param6);

@DllImport("RASAPI32.dll")
uint RasSetSubEntryPropertiesW(const(wchar)* param0, const(wchar)* param1, uint param2, tagRASSUBENTRYW* param3, uint param4, ubyte* param5, uint param6);

@DllImport("RASAPI32.dll")
uint RasGetAutodialAddressA(const(char)* param0, uint* param1, tagRASAUTODIALENTRYA* param2, uint* param3, uint* param4);

@DllImport("RASAPI32.dll")
uint RasGetAutodialAddressW(const(wchar)* param0, uint* param1, tagRASAUTODIALENTRYW* param2, uint* param3, uint* param4);

@DllImport("RASAPI32.dll")
uint RasSetAutodialAddressA(const(char)* param0, uint param1, tagRASAUTODIALENTRYA* param2, uint param3, uint param4);

@DllImport("RASAPI32.dll")
uint RasSetAutodialAddressW(const(wchar)* param0, uint param1, tagRASAUTODIALENTRYW* param2, uint param3, uint param4);

@DllImport("RASAPI32.dll")
uint RasEnumAutodialAddressesA(char* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, uint* lpdwcRasAutodialAddresses);

@DllImport("RASAPI32.dll")
uint RasEnumAutodialAddressesW(char* lppRasAutodialAddresses, uint* lpdwcbRasAutodialAddresses, uint* lpdwcRasAutodialAddresses);

@DllImport("RASAPI32.dll")
uint RasGetAutodialEnableA(uint param0, int* param1);

@DllImport("RASAPI32.dll")
uint RasGetAutodialEnableW(uint param0, int* param1);

@DllImport("RASAPI32.dll")
uint RasSetAutodialEnableA(uint param0, BOOL param1);

@DllImport("RASAPI32.dll")
uint RasSetAutodialEnableW(uint param0, BOOL param1);

@DllImport("RASAPI32.dll")
uint RasGetAutodialParamA(uint param0, void* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasGetAutodialParamW(uint param0, void* param1, uint* param2);

@DllImport("RASAPI32.dll")
uint RasSetAutodialParamA(uint param0, void* param1, uint param2);

@DllImport("RASAPI32.dll")
uint RasSetAutodialParamW(uint param0, void* param1, uint param2);

@DllImport("RASAPI32.dll")
uint RasGetPCscf(const(wchar)* lpszPCscf);

@DllImport("RASAPI32.dll")
uint RasInvokeEapUI(HRASCONN__* param0, uint param1, tagRASDIALEXTENSIONS* param2, HWND param3);

@DllImport("RASAPI32.dll")
uint RasGetLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry, RAS_STATS* lpStatistics);

@DllImport("RASAPI32.dll")
uint RasGetConnectionStatistics(HRASCONN__* hRasConn, RAS_STATS* lpStatistics);

@DllImport("RASAPI32.dll")
uint RasClearLinkStatistics(HRASCONN__* hRasConn, uint dwSubEntry);

@DllImport("RASAPI32.dll")
uint RasClearConnectionStatistics(HRASCONN__* hRasConn);

@DllImport("RASAPI32.dll")
uint RasGetEapUserDataA(HANDLE hToken, const(char)* pszPhonebook, const(char)* pszEntry, ubyte* pbEapData, uint* pdwSizeofEapData);

@DllImport("RASAPI32.dll")
uint RasGetEapUserDataW(HANDLE hToken, const(wchar)* pszPhonebook, const(wchar)* pszEntry, ubyte* pbEapData, uint* pdwSizeofEapData);

@DllImport("RASAPI32.dll")
uint RasSetEapUserDataA(HANDLE hToken, const(char)* pszPhonebook, const(char)* pszEntry, ubyte* pbEapData, uint dwSizeofEapData);

@DllImport("RASAPI32.dll")
uint RasSetEapUserDataW(HANDLE hToken, const(wchar)* pszPhonebook, const(wchar)* pszEntry, ubyte* pbEapData, uint dwSizeofEapData);

@DllImport("RASAPI32.dll")
uint RasGetCustomAuthDataA(const(char)* pszPhonebook, const(char)* pszEntry, char* pbCustomAuthData, uint* pdwSizeofCustomAuthData);

@DllImport("RASAPI32.dll")
uint RasGetCustomAuthDataW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, char* pbCustomAuthData, uint* pdwSizeofCustomAuthData);

@DllImport("RASAPI32.dll")
uint RasSetCustomAuthDataA(const(char)* pszPhonebook, const(char)* pszEntry, char* pbCustomAuthData, uint dwSizeofCustomAuthData);

@DllImport("RASAPI32.dll")
uint RasSetCustomAuthDataW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, char* pbCustomAuthData, uint dwSizeofCustomAuthData);

@DllImport("RASAPI32.dll")
uint RasGetEapUserIdentityW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, uint dwFlags, HWND hwnd, tagRASEAPUSERIDENTITYW** ppRasEapUserIdentity);

@DllImport("RASAPI32.dll")
uint RasGetEapUserIdentityA(const(char)* pszPhonebook, const(char)* pszEntry, uint dwFlags, HWND hwnd, tagRASEAPUSERIDENTITYA** ppRasEapUserIdentity);

@DllImport("RASAPI32.dll")
void RasFreeEapUserIdentityW(tagRASEAPUSERIDENTITYW* pRasEapUserIdentity);

@DllImport("RASAPI32.dll")
void RasFreeEapUserIdentityA(tagRASEAPUSERIDENTITYA* pRasEapUserIdentity);

@DllImport("RASAPI32.dll")
uint RasDeleteSubEntryA(const(char)* pszPhonebook, const(char)* pszEntry, uint dwSubentryId);

@DllImport("RASAPI32.dll")
uint RasDeleteSubEntryW(const(wchar)* pszPhonebook, const(wchar)* pszEntry, uint dwSubEntryId);

@DllImport("RASAPI32.dll")
uint RasUpdateConnection(HRASCONN__* hrasconn, tagRASUPDATECONN* lprasupdateconn);

@DllImport("RASAPI32.dll")
uint RasGetProjectionInfoEx(HRASCONN__* hrasconn, RAS_PROJECTION_INFO* pRasProjection, uint* lpdwSize);

@DllImport("RASDLG.dll")
BOOL RasPhonebookDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, tagRASPBDLGA* lpInfo);

@DllImport("RASDLG.dll")
BOOL RasPhonebookDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, tagRASPBDLGW* lpInfo);

@DllImport("RASDLG.dll")
BOOL RasEntryDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, tagRASENTRYDLGA* lpInfo);

@DllImport("RASDLG.dll")
BOOL RasEntryDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, tagRASENTRYDLGW* lpInfo);

@DllImport("RASDLG.dll")
BOOL RasDialDlgA(const(char)* lpszPhonebook, const(char)* lpszEntry, const(char)* lpszPhoneNumber, tagRASDIALDLG* lpInfo);

@DllImport("RASDLG.dll")
BOOL RasDialDlgW(const(wchar)* lpszPhonebook, const(wchar)* lpszEntry, const(wchar)* lpszPhoneNumber, tagRASDIALDLG* lpInfo);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionEnumEx(int hRasServer, MPRAPI_OBJECT_HEADER* pObjectHeader, uint dwPreferedMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, RAS_CONNECTION_EX** ppRasConn, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionGetInfoEx(int hRasServer, HANDLE hRasConnection, RAS_CONNECTION_EX* pRasConnection);

@DllImport("MPRAPI.dll")
uint MprAdminServerGetInfoEx(int hMprServer, MPR_SERVER_EX1* pServerInfo);

@DllImport("MPRAPI.dll")
uint MprAdminServerSetInfoEx(int hMprServer, MPR_SERVER_SET_CONFIG_EX1* pServerInfo);

@DllImport("MPRAPI.dll")
uint MprConfigServerGetInfoEx(HANDLE hMprConfig, MPR_SERVER_EX1* pServerInfo);

@DllImport("MPRAPI.dll")
uint MprConfigServerSetInfoEx(HANDLE hMprConfig, MPR_SERVER_SET_CONFIG_EX1* pSetServerConfig);

@DllImport("MPRAPI.dll")
uint MprAdminUpdateConnection(int hRasServer, HANDLE hRasConnection, RAS_UPDATE_CONNECTION* pRasUpdateConnection);

@DllImport("MPRAPI.dll")
uint MprAdminIsServiceInitialized(const(wchar)* lpwsServerName, int* fIsServiceInitialized);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCustomInfoEx(int hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCustomInfoEx(int hMprServer, HANDLE hInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceSetCustomInfoEx(HANDLE hMprConfig, HANDLE hRouterInterface, MPR_IF_CUSTOMINFOEX2* pCustomInfo);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionEnum(int hRasServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprAdminPortEnum(int hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionGetInfo(int hRasServer, uint dwLevel, HANDLE hRasConnection, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminPortGetInfo(int hRasServer, uint dwLevel, HANDLE hPort, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionClearStats(int hRasServer, HANDLE hRasConnection);

@DllImport("MPRAPI.dll")
uint MprAdminPortClearStats(int hRasServer, HANDLE hPort);

@DllImport("MPRAPI.dll")
uint MprAdminPortReset(int hRasServer, HANDLE hPort);

@DllImport("MPRAPI.dll")
uint MprAdminPortDisconnect(int hRasServer, HANDLE hPort);

@DllImport("MPRAPI.dll")
uint MprAdminConnectionRemoveQuarantine(HANDLE hRasServer, HANDLE hRasConnection, BOOL fIsIpAddress);

@DllImport("MPRAPI.dll")
uint MprAdminUserGetInfo(const(wchar)* lpszServer, const(wchar)* lpszUser, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminUserSetInfo(const(wchar)* lpszServer, const(wchar)* lpszUser, uint dwLevel, const(ubyte)* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminSendUserMessage(int hMprServer, HANDLE hConnection, const(wchar)* lpwszMessage);

@DllImport("MPRAPI.dll")
uint MprAdminGetPDCServer(const(wchar)* lpszDomain, const(wchar)* lpszServer, const(wchar)* lpszPDCServer);

@DllImport("MPRAPI.dll")
BOOL MprAdminIsServiceRunning(const(wchar)* lpwsServerName);

@DllImport("MPRAPI.dll")
uint MprAdminServerConnect(const(wchar)* lpwsServerName, int* phMprServer);

@DllImport("MPRAPI.dll")
void MprAdminServerDisconnect(int hMprServer);

@DllImport("MPRAPI.dll")
uint MprAdminServerGetCredentials(int hMprServer, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminServerSetCredentials(int hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminBufferFree(void* pBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminGetErrorString(uint dwError, ushort** lplpwsErrorString);

@DllImport("MPRAPI.dll")
uint MprAdminServerGetInfo(int hMprServer, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminServerSetInfo(int hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminEstablishDomainRasServer(const(wchar)* pszDomain, const(wchar)* pszMachine, BOOL bEnable);

@DllImport("MPRAPI.dll")
uint MprAdminIsDomainRasServer(const(wchar)* pszDomain, const(wchar)* pszMachine, int* pbIsRasServer);

@DllImport("MPRAPI.dll")
uint MprAdminTransportCreate(int hMprServer, uint dwTransportId, const(wchar)* lpwsTransportName, ubyte* pGlobalInfo, uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, const(wchar)* lpwsDLLPath);

@DllImport("MPRAPI.dll")
uint MprAdminTransportSetInfo(int hMprServer, uint dwTransportId, ubyte* pGlobalInfo, uint dwGlobalInfoSize, ubyte* pClientInterfaceInfo, uint dwClientInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprAdminTransportGetInfo(int hMprServer, uint dwTransportId, ubyte** ppGlobalInfo, uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, uint* lpdwClientInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprAdminDeviceEnum(int hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint* lpdwTotalEntries);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetHandle(int hMprServer, const(wchar)* lpwsInterfaceName, HANDLE* phInterface, BOOL fIncludeClientInterfaces);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceCreate(int hMprServer, uint dwLevel, ubyte* lpbBuffer, HANDLE* phInterface);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetInfo(int hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetInfo(int hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDelete(int hMprServer, HANDLE hInterface);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDeviceGetInfo(int hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, ubyte** lplpBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDeviceSetInfo(int hMprServer, HANDLE hInterface, uint dwIndex, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportRemove(int hMprServer, HANDLE hInterface, uint dwTransportId);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportAdd(int hMprServer, HANDLE hInterface, uint dwTransportId, ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportGetInfo(int hMprServer, HANDLE hInterface, uint dwTransportId, ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceTransportSetInfo(int hMprServer, HANDLE hInterface, uint dwTransportId, ubyte* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceEnum(int hMprServer, uint dwLevel, ubyte** lplpbBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCredentials(const(wchar)* lpwsServer, const(wchar)* lpwsInterfaceName, const(wchar)* lpwsUserName, const(wchar)* lpwsDomainName, const(wchar)* lpwsPassword);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCredentials(const(wchar)* lpwsServer, const(wchar)* lpwsInterfaceName, const(wchar)* lpwsUserName, const(wchar)* lpwsPassword, const(wchar)* lpwsDomainName);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceSetCredentialsEx(int hMprServer, HANDLE hInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceGetCredentialsEx(int hMprServer, HANDLE hInterface, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceConnect(int hMprServer, HANDLE hInterface, HANDLE hEvent, BOOL fSynchronous);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceDisconnect(int hMprServer, HANDLE hInterface);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceUpdateRoutes(int hMprServer, HANDLE hInterface, uint dwProtocolId, HANDLE hEvent);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceQueryUpdateResult(int hMprServer, HANDLE hInterface, uint dwProtocolId, uint* lpdwUpdateResult);

@DllImport("MPRAPI.dll")
uint MprAdminInterfaceUpdatePhonebookInfo(int hMprServer, HANDLE hInterface);

@DllImport("MPRAPI.dll")
uint MprAdminRegisterConnectionNotification(int hMprServer, HANDLE hEventNotification);

@DllImport("MPRAPI.dll")
uint MprAdminDeregisterConnectionNotification(int hMprServer, HANDLE hEventNotification);

@DllImport("MPRAPI.dll")
uint MprAdminMIBServerConnect(const(wchar)* lpwsServerName, int* phMibServer);

@DllImport("MPRAPI.dll")
void MprAdminMIBServerDisconnect(int hMibServer);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryCreate(int hMibServer, uint dwPid, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryDelete(int hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntrySet(int hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpEntry, uint dwEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGet(int hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGetFirst(int hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBEntryGetNext(int hMibServer, uint dwProtocolId, uint dwRoutingPid, void* lpInEntry, uint dwInEntrySize, void** lplpOutEntry, uint* lpOutEntrySize);

@DllImport("MPRAPI.dll")
uint MprAdminMIBBufferFree(void* pBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigServerInstall(uint dwLevel, void* pBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigServerConnect(const(wchar)* lpwsServerName, HANDLE* phMprConfig);

@DllImport("MPRAPI.dll")
void MprConfigServerDisconnect(HANDLE hMprConfig);

@DllImport("MPRAPI.dll")
uint MprConfigServerRefresh(HANDLE hMprConfig);

@DllImport("MPRAPI.dll")
uint MprConfigBufferFree(void* pBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigServerGetInfo(HANDLE hMprConfig, uint dwLevel, ubyte** lplpbBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigServerSetInfo(int hMprServer, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigServerBackup(HANDLE hMprConfig, const(wchar)* lpwsPath);

@DllImport("MPRAPI.dll")
uint MprConfigServerRestore(HANDLE hMprConfig, const(wchar)* lpwsPath);

@DllImport("MPRAPI.dll")
uint MprConfigTransportCreate(HANDLE hMprConfig, uint dwTransportId, const(wchar)* lpwsTransportName, char* pGlobalInfo, uint dwGlobalInfoSize, char* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, const(wchar)* lpwsDLLPath, HANDLE* phRouterTransport);

@DllImport("MPRAPI.dll")
uint MprConfigTransportDelete(HANDLE hMprConfig, HANDLE hRouterTransport);

@DllImport("MPRAPI.dll")
uint MprConfigTransportGetHandle(HANDLE hMprConfig, uint dwTransportId, HANDLE* phRouterTransport);

@DllImport("MPRAPI.dll")
uint MprConfigTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, char* pGlobalInfo, uint dwGlobalInfoSize, char* pClientInterfaceInfo, uint dwClientInterfaceInfoSize, const(wchar)* lpwsDLLPath);

@DllImport("MPRAPI.dll")
uint MprConfigTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterTransport, ubyte** ppGlobalInfo, uint* lpdwGlobalInfoSize, ubyte** ppClientInterfaceInfo, uint* lpdwClientInterfaceInfoSize, ushort** lplpwsDLLPath);

@DllImport("MPRAPI.dll")
uint MprConfigTransportEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceCreate(HANDLE hMprConfig, uint dwLevel, ubyte* lpbBuffer, HANDLE* phRouterInterface);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceDelete(HANDLE hMprConfig, HANDLE hRouterInterface);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetHandle(HANDLE hMprConfig, const(wchar)* lpwsInterfaceName, HANDLE* phRouterInterface);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, uint* lpdwBufferSize);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte* lpbBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceEnum(HANDLE hMprConfig, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportAdd(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, const(wchar)* lpwsTransportName, char* pInterfaceInfo, uint dwInterfaceInfoSize, HANDLE* phRouterIfTransport);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportRemove(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportGetHandle(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwTransportId, HANDLE* phRouterIfTransport);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportGetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, ubyte** ppInterfaceInfo, uint* lpdwInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportSetInfo(HANDLE hMprConfig, HANDLE hRouterInterface, HANDLE hRouterIfTransport, char* pInterfaceInfo, uint dwInterfaceInfoSize);

@DllImport("MPRAPI.dll")
uint MprConfigInterfaceTransportEnum(HANDLE hMprConfig, HANDLE hRouterInterface, uint dwLevel, ubyte** lplpBuffer, uint dwPrefMaxLen, uint* lpdwEntriesRead, uint* lpdwTotalEntries, uint* lpdwResumeHandle);

@DllImport("MPRAPI.dll")
uint MprConfigGetFriendlyName(HANDLE hMprConfig, const(wchar)* pszGuidName, const(wchar)* pszBuffer, uint dwBufferSize);

@DllImport("MPRAPI.dll")
uint MprConfigGetGuidName(HANDLE hMprConfig, const(wchar)* pszFriendlyName, const(wchar)* pszBuffer, uint dwBufferSize);

@DllImport("MPRAPI.dll")
uint MprConfigFilterGetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, char* lpBuffer);

@DllImport("MPRAPI.dll")
uint MprConfigFilterSetInfo(HANDLE hMprConfig, uint dwLevel, uint dwTransportId, ubyte* lpBuffer);

@DllImport("MPRAPI.dll")
uint MprInfoCreate(uint dwVersion, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoDelete(void* lpHeader);

@DllImport("MPRAPI.dll")
uint MprInfoRemoveAll(void* lpHeader, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoDuplicate(void* lpHeader, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoBlockAdd(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, char* lpItemData, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoBlockRemove(void* lpHeader, uint dwInfoType, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoBlockSet(void* lpHeader, uint dwInfoType, uint dwItemSize, uint dwItemCount, char* lpItemData, void** lplpNewHeader);

@DllImport("MPRAPI.dll")
uint MprInfoBlockFind(void* lpHeader, uint dwInfoType, uint* lpdwItemSize, uint* lpdwItemCount, ubyte** lplpItemData);

@DllImport("MPRAPI.dll")
uint MprInfoBlockQuerySize(void* lpHeader);

@DllImport("rtm.dll")
uint MgmRegisterMProtocol(ROUTING_PROTOCOL_CONFIG* prpiInfo, uint dwProtocolId, uint dwComponentId, HANDLE* phProtocol);

@DllImport("rtm.dll")
uint MgmDeRegisterMProtocol(HANDLE hProtocol);

@DllImport("rtm.dll")
uint MgmTakeInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

@DllImport("rtm.dll")
uint MgmReleaseInterfaceOwnership(HANDLE hProtocol, uint dwIfIndex, uint dwIfNextHopAddr);

@DllImport("rtm.dll")
uint MgmGetProtocolOnInterface(uint dwIfIndex, uint dwIfNextHopAddr, uint* pdwIfProtocolId, uint* pdwIfComponentId);

@DllImport("rtm.dll")
uint MgmAddGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

@DllImport("rtm.dll")
uint MgmDeleteGroupMembershipEntry(HANDLE hProtocol, uint dwSourceAddr, uint dwSourceMask, uint dwGroupAddr, uint dwGroupMask, uint dwIfIndex, uint dwIfNextHopIPAddr, uint dwFlags);

@DllImport("rtm.dll")
uint MgmGetMfe(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer);

@DllImport("rtm.dll")
uint MgmGetFirstMfe(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm.dll")
uint MgmGetNextMfe(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm.dll")
uint MgmGetMfeStats(MIB_IPMCAST_MFE* pimm, uint* pdwBufferSize, ubyte* pbBuffer, uint dwFlags);

@DllImport("rtm.dll")
uint MgmGetFirstMfeStats(uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, uint dwFlags);

@DllImport("rtm.dll")
uint MgmGetNextMfeStats(MIB_IPMCAST_MFE* pimmStart, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries, uint dwFlags);

@DllImport("rtm.dll")
uint MgmGroupEnumerationStart(HANDLE hProtocol, MGM_ENUM_TYPES metEnumType, HANDLE* phEnumHandle);

@DllImport("rtm.dll")
uint MgmGroupEnumerationGetNext(HANDLE hEnum, uint* pdwBufferSize, ubyte* pbBuffer, uint* pdwNumEntries);

@DllImport("rtm.dll")
uint MgmGroupEnumerationEnd(HANDLE hEnum);

@DllImport("rtm.dll")
uint RtmConvertNetAddressToIpv6AddressAndLength(RTM_NET_ADDRESS* pNetAddress, in6_addr* pAddress, uint* pLength, uint dwAddressSize);

@DllImport("rtm.dll")
uint RtmConvertIpv6AddressAndLengthToNetAddress(RTM_NET_ADDRESS* pNetAddress, in6_addr Address, uint dwLength, uint dwAddressSize);

@DllImport("rtm.dll")
uint RtmRegisterEntity(RTM_ENTITY_INFO* RtmEntityInfo, RTM_ENTITY_EXPORT_METHODS* ExportMethods, RTM_EVENT_CALLBACK EventCallback, BOOL ReserveOpaquePointer, RTM_REGN_PROFILE* RtmRegProfile, int* RtmRegHandle);

@DllImport("rtm.dll")
uint RtmDeregisterEntity(int RtmRegHandle);

@DllImport("rtm.dll")
uint RtmGetRegisteredEntities(int RtmRegHandle, uint* NumEntities, int* EntityHandles, RTM_ENTITY_INFO* EntityInfos);

@DllImport("rtm.dll")
uint RtmReleaseEntities(int RtmRegHandle, uint NumEntities, int* EntityHandles);

@DllImport("rtm.dll")
uint RtmLockDestination(int RtmRegHandle, int DestHandle, BOOL Exclusive, BOOL LockDest);

@DllImport("rtm.dll")
uint RtmGetOpaqueInformationPointer(int RtmRegHandle, int DestHandle, void** OpaqueInfoPointer);

@DllImport("rtm.dll")
uint RtmGetEntityMethods(int RtmRegHandle, int EntityHandle, uint* NumMethods, PRTM_ENTITY_EXPORT_METHOD ExptMethods);

@DllImport("rtm.dll")
uint RtmInvokeMethod(int RtmRegHandle, int EntityHandle, RTM_ENTITY_METHOD_INPUT* Input, uint* OutputSize, RTM_ENTITY_METHOD_OUTPUT* Output);

@DllImport("rtm.dll")
uint RtmBlockMethods(int RtmRegHandle, HANDLE TargetHandle, ubyte TargetType, uint BlockingFlag);

@DllImport("rtm.dll")
uint RtmGetEntityInfo(int RtmRegHandle, int EntityHandle, RTM_ENTITY_INFO* EntityInfo);

@DllImport("rtm.dll")
uint RtmGetDestInfo(int RtmRegHandle, int DestHandle, uint ProtocolId, uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm.dll")
uint RtmGetRouteInfo(int RtmRegHandle, int RouteHandle, RTM_ROUTE_INFO* RouteInfo, RTM_NET_ADDRESS* DestAddress);

@DllImport("rtm.dll")
uint RtmGetNextHopInfo(int RtmRegHandle, int NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm.dll")
uint RtmReleaseEntityInfo(int RtmRegHandle, RTM_ENTITY_INFO* EntityInfo);

@DllImport("rtm.dll")
uint RtmReleaseDestInfo(int RtmRegHandle, RTM_DEST_INFO* DestInfo);

@DllImport("rtm.dll")
uint RtmReleaseRouteInfo(int RtmRegHandle, RTM_ROUTE_INFO* RouteInfo);

@DllImport("rtm.dll")
uint RtmReleaseNextHopInfo(int RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm.dll")
uint RtmAddRouteToDest(int RtmRegHandle, int* RouteHandle, RTM_NET_ADDRESS* DestAddress, RTM_ROUTE_INFO* RouteInfo, uint TimeToLive, int RouteListHandle, uint NotifyType, int NotifyHandle, uint* ChangeFlags);

@DllImport("rtm.dll")
uint RtmDeleteRouteToDest(int RtmRegHandle, int RouteHandle, uint* ChangeFlags);

@DllImport("rtm.dll")
uint RtmHoldDestination(int RtmRegHandle, int DestHandle, uint TargetViews, uint HoldTime);

@DllImport("rtm.dll")
uint RtmGetRoutePointer(int RtmRegHandle, int RouteHandle, RTM_ROUTE_INFO** RoutePointer);

@DllImport("rtm.dll")
uint RtmLockRoute(int RtmRegHandle, int RouteHandle, BOOL Exclusive, BOOL LockRoute, RTM_ROUTE_INFO** RoutePointer);

@DllImport("rtm.dll")
uint RtmUpdateAndUnlockRoute(int RtmRegHandle, int RouteHandle, uint TimeToLive, int RouteListHandle, uint NotifyType, int NotifyHandle, uint* ChangeFlags);

@DllImport("rtm.dll")
uint RtmGetExactMatchDestination(int RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm.dll")
uint RtmGetMostSpecificDestination(int RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint ProtocolId, uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm.dll")
uint RtmGetLessSpecificDestination(int RtmRegHandle, int DestHandle, uint ProtocolId, uint TargetViews, RTM_DEST_INFO* DestInfo);

@DllImport("rtm.dll")
uint RtmGetExactMatchRoute(int RtmRegHandle, RTM_NET_ADDRESS* DestAddress, uint MatchingFlags, RTM_ROUTE_INFO* RouteInfo, uint InterfaceIndex, uint TargetViews, int* RouteHandle);

@DllImport("rtm.dll")
uint RtmIsBestRoute(int RtmRegHandle, int RouteHandle, uint* BestInViews);

@DllImport("rtm.dll")
uint RtmAddNextHop(int RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, int* NextHopHandle, uint* ChangeFlags);

@DllImport("rtm.dll")
uint RtmFindNextHop(int RtmRegHandle, RTM_NEXTHOP_INFO* NextHopInfo, int* NextHopHandle, RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm.dll")
uint RtmDeleteNextHop(int RtmRegHandle, int NextHopHandle, RTM_NEXTHOP_INFO* NextHopInfo);

@DllImport("rtm.dll")
uint RtmGetNextHopPointer(int RtmRegHandle, int NextHopHandle, RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm.dll")
uint RtmLockNextHop(int RtmRegHandle, int NextHopHandle, BOOL Exclusive, BOOL LockNextHop, RTM_NEXTHOP_INFO** NextHopPointer);

@DllImport("rtm.dll")
uint RtmCreateDestEnum(int RtmRegHandle, uint TargetViews, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, uint ProtocolId, int* RtmEnumHandle);

@DllImport("rtm.dll")
uint RtmGetEnumDests(int RtmRegHandle, int EnumHandle, uint* NumDests, RTM_DEST_INFO* DestInfos);

@DllImport("rtm.dll")
uint RtmReleaseDests(int RtmRegHandle, uint NumDests, RTM_DEST_INFO* DestInfos);

@DllImport("rtm.dll")
uint RtmCreateRouteEnum(int RtmRegHandle, int DestHandle, uint TargetViews, uint EnumFlags, RTM_NET_ADDRESS* StartDest, uint MatchingFlags, RTM_ROUTE_INFO* CriteriaRoute, uint CriteriaInterface, int* RtmEnumHandle);

@DllImport("rtm.dll")
uint RtmGetEnumRoutes(int RtmRegHandle, int EnumHandle, uint* NumRoutes, int* RouteHandles);

@DllImport("rtm.dll")
uint RtmReleaseRoutes(int RtmRegHandle, uint NumRoutes, int* RouteHandles);

@DllImport("rtm.dll")
uint RtmCreateNextHopEnum(int RtmRegHandle, uint EnumFlags, RTM_NET_ADDRESS* NetAddress, int* RtmEnumHandle);

@DllImport("rtm.dll")
uint RtmGetEnumNextHops(int RtmRegHandle, int EnumHandle, uint* NumNextHops, int* NextHopHandles);

@DllImport("rtm.dll")
uint RtmReleaseNextHops(int RtmRegHandle, uint NumNextHops, int* NextHopHandles);

@DllImport("rtm.dll")
uint RtmDeleteEnumHandle(int RtmRegHandle, int EnumHandle);

@DllImport("rtm.dll")
uint RtmRegisterForChangeNotification(int RtmRegHandle, uint TargetViews, uint NotifyFlags, void* NotifyContext, int* NotifyHandle);

@DllImport("rtm.dll")
uint RtmGetChangedDests(int RtmRegHandle, int NotifyHandle, uint* NumDests, RTM_DEST_INFO* ChangedDests);

@DllImport("rtm.dll")
uint RtmReleaseChangedDests(int RtmRegHandle, int NotifyHandle, uint NumDests, RTM_DEST_INFO* ChangedDests);

@DllImport("rtm.dll")
uint RtmIgnoreChangedDests(int RtmRegHandle, int NotifyHandle, uint NumDests, int* ChangedDests);

@DllImport("rtm.dll")
uint RtmGetChangeStatus(int RtmRegHandle, int NotifyHandle, int DestHandle, int* ChangeStatus);

@DllImport("rtm.dll")
uint RtmMarkDestForChangeNotification(int RtmRegHandle, int NotifyHandle, int DestHandle, BOOL MarkDest);

@DllImport("rtm.dll")
uint RtmIsMarkedForChangeNotification(int RtmRegHandle, int NotifyHandle, int DestHandle, int* DestMarked);

@DllImport("rtm.dll")
uint RtmDeregisterFromChangeNotification(int RtmRegHandle, int NotifyHandle);

@DllImport("rtm.dll")
uint RtmCreateRouteList(int RtmRegHandle, int* RouteListHandle);

@DllImport("rtm.dll")
uint RtmInsertInRouteList(int RtmRegHandle, int RouteListHandle, uint NumRoutes, int* RouteHandles);

@DllImport("rtm.dll")
uint RtmCreateRouteListEnum(int RtmRegHandle, int RouteListHandle, int* RtmEnumHandle);

@DllImport("rtm.dll")
uint RtmGetListEnumRoutes(int RtmRegHandle, int EnumHandle, uint* NumRoutes, char* RouteHandles);

@DllImport("rtm.dll")
uint RtmDeleteRouteList(int RtmRegHandle, int RouteListHandle);

@DllImport("rtm.dll")
uint RtmReferenceHandles(int RtmRegHandle, uint NumHandles, HANDLE* RtmHandles);

