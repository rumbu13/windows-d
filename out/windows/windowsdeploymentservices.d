module windows.windowsdeploymentservices;

public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

struct WDS_CLI_CRED
{
    const(wchar)* pwszUserName;
    const(wchar)* pwszDomain;
    const(wchar)* pwszPassword;
}

alias PFN_WdsCliTraceFunction = extern(Windows) void function(const(wchar)* pwszFormat, byte* Params);
enum WDS_CLI_IMAGE_TYPE
{
    WDS_CLI_IMAGE_TYPE_UNKNOWN = 0,
    WDS_CLI_IMAGE_TYPE_WIM = 1,
    WDS_CLI_IMAGE_TYPE_VHD = 2,
    WDS_CLI_IMAGE_TYPE_VHDX = 3,
}

enum WDS_CLI_FIRMWARE_TYPE
{
    WDS_CLI_FIRMWARE_UNKNOWN = 0,
    WDS_CLI_FIRMWARE_BIOS = 1,
    WDS_CLI_FIRMWARE_EFI = 2,
}

enum WDS_CLI_IMAGE_PARAM_TYPE
{
    WDS_CLI_IMAGE_PARAM_UNKNOWN = 0,
    WDS_CLI_IMAGE_PARAM_SPARSE_FILE = 1,
    WDS_CLI_IMAGE_PARAM_SUPPORTED_FIRMWARES = 2,
}

alias PFN_WdsCliCallback = extern(Windows) void function(uint dwMessageId, WPARAM wParam, LPARAM lParam, void* pvUserData);
struct PXE_DHCP_OPTION
{
    ubyte OptionType;
    ubyte OptionLength;
    ubyte OptionValue;
}

struct PXE_DHCP_MESSAGE
{
    ubyte Operation;
    ubyte HardwareAddressType;
    ubyte HardwareAddressLength;
    ubyte HopCount;
    uint TransactionID;
    ushort SecondsSinceBoot;
    ushort Reserved;
    uint ClientIpAddress;
    uint YourIpAddress;
    uint BootstrapServerAddress;
    uint RelayAgentIpAddress;
    ubyte HardwareAddress;
    ubyte HostName;
    ubyte BootFileName;
    _Anonymous_e__Union Anonymous;
    PXE_DHCP_OPTION Option;
}

struct PXE_DHCPV6_OPTION
{
    ushort OptionCode;
    ushort DataLength;
    ubyte Data;
}

struct PXE_DHCPV6_MESSAGE_HEADER
{
    ubyte MessageType;
    ubyte Message;
}

struct PXE_DHCPV6_MESSAGE
{
    ubyte MessageType;
    ubyte TransactionIDByte1;
    ubyte TransactionIDByte2;
    ubyte TransactionIDByte3;
    PXE_DHCPV6_OPTION Options;
}

struct PXE_DHCPV6_RELAY_MESSAGE
{
    ubyte MessageType;
    ubyte HopCount;
    ubyte LinkAddress;
    ubyte PeerAddress;
    PXE_DHCPV6_OPTION Options;
}

struct PXE_PROVIDER
{
    uint uSizeOfStruct;
    const(wchar)* pwszName;
    const(wchar)* pwszFilePath;
    BOOL bIsCritical;
    uint uIndex;
}

struct PXE_ADDRESS
{
    uint uFlags;
    _Anonymous_e__Union Anonymous;
    uint uAddrLen;
    ushort uPort;
}

struct PXE_DHCPV6_NESTED_RELAY_MESSAGE
{
    PXE_DHCPV6_RELAY_MESSAGE* pRelayMessage;
    uint cbRelayMessage;
    void* pInterfaceIdOption;
    ushort cbInterfaceIdOption;
}

enum TRANSPORTPROVIDER_CALLBACK_ID
{
    WDS_TRANSPORTPROVIDER_CREATE_INSTANCE = 0,
    WDS_TRANSPORTPROVIDER_COMPARE_CONTENT = 1,
    WDS_TRANSPORTPROVIDER_OPEN_CONTENT = 2,
    WDS_TRANSPORTPROVIDER_USER_ACCESS_CHECK = 3,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_SIZE = 4,
    WDS_TRANSPORTPROVIDER_READ_CONTENT = 5,
    WDS_TRANSPORTPROVIDER_CLOSE_CONTENT = 6,
    WDS_TRANSPORTPROVIDER_CLOSE_INSTANCE = 7,
    WDS_TRANSPORTPROVIDER_SHUTDOWN = 8,
    WDS_TRANSPORTPROVIDER_DUMP_STATE = 9,
    WDS_TRANSPORTPROVIDER_REFRESH_SETTINGS = 10,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_METADATA = 11,
    WDS_TRANSPORTPROVIDER_MAX_CALLBACKS = 12,
}

struct WDS_TRANSPORTPROVIDER_INIT_PARAMS
{
    uint ulLength;
    uint ulMcServerVersion;
    HKEY hRegistryKey;
    HANDLE hProvider;
}

struct WDS_TRANSPORTPROVIDER_SETTINGS
{
    uint ulLength;
    uint ulProviderVersion;
}

enum TRANSPORTCLIENT_CALLBACK_ID
{
    WDS_TRANSPORTCLIENT_SESSION_START = 0,
    WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS = 1,
    WDS_TRANSPORTCLIENT_SESSION_COMPLETE = 2,
    WDS_TRANSPORTCLIENT_RECEIVE_METADATA = 3,
    WDS_TRANSPORTCLIENT_SESSION_STARTEX = 4,
    WDS_TRANSPORTCLIENT_SESSION_NEGOTIATE = 5,
    WDS_TRANSPORTCLIENT_MAX_CALLBACKS = 6,
}

struct TRANSPORTCLIENT_SESSION_INFO
{
    uint ulStructureLength;
    ULARGE_INTEGER ullFileSize;
    uint ulBlockSize;
}

alias PFN_WdsTransportClientSessionStart = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, ULARGE_INTEGER* ullFileSize);
alias PFN_WdsTransportClientSessionStartEx = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, TRANSPORTCLIENT_SESSION_INFO* Info);
alias PFN_WdsTransportClientReceiveMetadata = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, char* pMetadata, uint ulSize);
alias PFN_WdsTransportClientReceiveContents = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, char* pContents, uint ulSize, ULARGE_INTEGER* pullContentOffset);
alias PFN_WdsTransportClientSessionComplete = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, uint dwError);
alias PFN_WdsTransportClientSessionNegotiate = extern(Windows) void function(HANDLE hSessionKey, void* pCallerData, TRANSPORTCLIENT_SESSION_INFO* pInfo, HANDLE hNegotiateKey);
struct WDS_TRANSPORTCLIENT_REQUEST
{
    uint ulLength;
    uint ulApiVersion;
    uint ulAuthLevel;
    const(wchar)* pwszServer;
    const(wchar)* pwszNamespace;
    const(wchar)* pwszObjectName;
    uint ulCacheSize;
    uint ulProtocol;
    void* pvProtocolData;
    uint ulProtocolDataLength;
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

const GUID CLSID_WdsTransportCacheable = {0x70590B16, 0xF146, 0x46BD, [0xBD, 0x9D, 0x4A, 0xAA, 0x90, 0x08, 0x4B, 0xF5]};
@GUID(0x70590B16, 0xF146, 0x46BD, [0xBD, 0x9D, 0x4A, 0xAA, 0x90, 0x08, 0x4B, 0xF5]);
struct WdsTransportCacheable;

const GUID CLSID_WdsTransportCollection = {0xC7F18B09, 0x391E, 0x436E, [0xB1, 0x0B, 0xC3, 0xEF, 0x46, 0xF2, 0xC3, 0x4F]};
@GUID(0xC7F18B09, 0x391E, 0x436E, [0xB1, 0x0B, 0xC3, 0xEF, 0x46, 0xF2, 0xC3, 0x4F]);
struct WdsTransportCollection;

const GUID CLSID_WdsTransportManager = {0xF21523F6, 0x837C, 0x4A58, [0xAF, 0x99, 0x8A, 0x7E, 0x27, 0xF8, 0xFF, 0x59]};
@GUID(0xF21523F6, 0x837C, 0x4A58, [0xAF, 0x99, 0x8A, 0x7E, 0x27, 0xF8, 0xFF, 0x59]);
struct WdsTransportManager;

const GUID CLSID_WdsTransportServer = {0xEA19B643, 0x4ADF, 0x4413, [0x94, 0x2C, 0x14, 0xF3, 0x79, 0x11, 0x87, 0x60]};
@GUID(0xEA19B643, 0x4ADF, 0x4413, [0x94, 0x2C, 0x14, 0xF3, 0x79, 0x11, 0x87, 0x60]);
struct WdsTransportServer;

const GUID CLSID_WdsTransportSetupManager = {0xC7BEEAAD, 0x9F04, 0x4923, [0x9F, 0x0C, 0xFB, 0xF5, 0x2B, 0xC7, 0x59, 0x0F]};
@GUID(0xC7BEEAAD, 0x9F04, 0x4923, [0x9F, 0x0C, 0xFB, 0xF5, 0x2B, 0xC7, 0x59, 0x0F]);
struct WdsTransportSetupManager;

const GUID CLSID_WdsTransportConfigurationManager = {0x8743F674, 0x904C, 0x47CA, [0x85, 0x12, 0x35, 0xFE, 0x98, 0xF6, 0xB0, 0xAC]};
@GUID(0x8743F674, 0x904C, 0x47CA, [0x85, 0x12, 0x35, 0xFE, 0x98, 0xF6, 0xB0, 0xAC]);
struct WdsTransportConfigurationManager;

const GUID CLSID_WdsTransportNamespaceManager = {0xF08CDB63, 0x85DE, 0x4A28, [0xA1, 0xA9, 0x5C, 0xA3, 0xE7, 0xEF, 0xDA, 0x73]};
@GUID(0xF08CDB63, 0x85DE, 0x4A28, [0xA1, 0xA9, 0x5C, 0xA3, 0xE7, 0xEF, 0xDA, 0x73]);
struct WdsTransportNamespaceManager;

const GUID CLSID_WdsTransportServicePolicy = {0x65ACEADC, 0x2F0B, 0x4F43, [0x9F, 0x4D, 0x81, 0x18, 0x65, 0xD8, 0xCE, 0xAD]};
@GUID(0x65ACEADC, 0x2F0B, 0x4F43, [0x9F, 0x4D, 0x81, 0x18, 0x65, 0xD8, 0xCE, 0xAD]);
struct WdsTransportServicePolicy;

const GUID CLSID_WdsTransportDiagnosticsPolicy = {0xEB3333E1, 0xA7AD, 0x46F5, [0x80, 0xD6, 0x6B, 0x74, 0x02, 0x04, 0xE5, 0x09]};
@GUID(0xEB3333E1, 0xA7AD, 0x46F5, [0x80, 0xD6, 0x6B, 0x74, 0x02, 0x04, 0xE5, 0x09]);
struct WdsTransportDiagnosticsPolicy;

const GUID CLSID_WdsTransportMulticastSessionPolicy = {0x3C6BC3F4, 0x6418, 0x472A, [0xB6, 0xF1, 0x52, 0xD4, 0x57, 0x19, 0x54, 0x37]};
@GUID(0x3C6BC3F4, 0x6418, 0x472A, [0xB6, 0xF1, 0x52, 0xD4, 0x57, 0x19, 0x54, 0x37]);
struct WdsTransportMulticastSessionPolicy;

const GUID CLSID_WdsTransportNamespace = {0xD8385768, 0x0732, 0x4EC1, [0x95, 0xEA, 0x16, 0xDA, 0x58, 0x19, 0x08, 0xA1]};
@GUID(0xD8385768, 0x0732, 0x4EC1, [0x95, 0xEA, 0x16, 0xDA, 0x58, 0x19, 0x08, 0xA1]);
struct WdsTransportNamespace;

const GUID CLSID_WdsTransportNamespaceAutoCast = {0xB091F5A8, 0x6A99, 0x478D, [0xB2, 0x3B, 0x09, 0xE8, 0xFE, 0xE0, 0x45, 0x74]};
@GUID(0xB091F5A8, 0x6A99, 0x478D, [0xB2, 0x3B, 0x09, 0xE8, 0xFE, 0xE0, 0x45, 0x74]);
struct WdsTransportNamespaceAutoCast;

const GUID CLSID_WdsTransportNamespaceScheduledCast = {0xBADC1897, 0x7025, 0x44EB, [0x91, 0x08, 0xFB, 0x61, 0xC4, 0x05, 0x57, 0x92]};
@GUID(0xBADC1897, 0x7025, 0x44EB, [0x91, 0x08, 0xFB, 0x61, 0xC4, 0x05, 0x57, 0x92]);
struct WdsTransportNamespaceScheduledCast;

const GUID CLSID_WdsTransportNamespaceScheduledCastManualStart = {0xD3E1A2AA, 0xCAAC, 0x460E, [0xB9, 0x8A, 0x47, 0xF9, 0xF3, 0x18, 0xA1, 0xFA]};
@GUID(0xD3E1A2AA, 0xCAAC, 0x460E, [0xB9, 0x8A, 0x47, 0xF9, 0xF3, 0x18, 0xA1, 0xFA]);
struct WdsTransportNamespaceScheduledCastManualStart;

const GUID CLSID_WdsTransportNamespaceScheduledCastAutoStart = {0xA1107052, 0x122C, 0x4B81, [0x9B, 0x7C, 0x38, 0x6E, 0x68, 0x55, 0x38, 0x3F]};
@GUID(0xA1107052, 0x122C, 0x4B81, [0x9B, 0x7C, 0x38, 0x6E, 0x68, 0x55, 0x38, 0x3F]);
struct WdsTransportNamespaceScheduledCastAutoStart;

const GUID CLSID_WdsTransportContent = {0x0A891FE7, 0x4A3F, 0x4C65, [0xB6, 0xF2, 0x14, 0x67, 0x61, 0x96, 0x79, 0xEA]};
@GUID(0x0A891FE7, 0x4A3F, 0x4C65, [0xB6, 0xF2, 0x14, 0x67, 0x61, 0x96, 0x79, 0xEA]);
struct WdsTransportContent;

const GUID CLSID_WdsTransportSession = {0x749AC4E0, 0x67BC, 0x4743, [0xBF, 0xE5, 0xCA, 0xCB, 0x1F, 0x26, 0xF5, 0x7F]};
@GUID(0x749AC4E0, 0x67BC, 0x4743, [0xBF, 0xE5, 0xCA, 0xCB, 0x1F, 0x26, 0xF5, 0x7F]);
struct WdsTransportSession;

const GUID CLSID_WdsTransportClient = {0x66D2C5E9, 0x0FF6, 0x49EC, [0x97, 0x33, 0xDA, 0xFB, 0x1E, 0x01, 0xDF, 0x1C]};
@GUID(0x66D2C5E9, 0x0FF6, 0x49EC, [0x97, 0x33, 0xDA, 0xFB, 0x1E, 0x01, 0xDF, 0x1C]);
struct WdsTransportClient;

const GUID CLSID_WdsTransportTftpClient = {0x50343925, 0x7C5C, 0x4C8C, [0x96, 0xC4, 0xAD, 0x9F, 0xA5, 0x00, 0x5F, 0xBA]};
@GUID(0x50343925, 0x7C5C, 0x4C8C, [0x96, 0xC4, 0xAD, 0x9F, 0xA5, 0x00, 0x5F, 0xBA]);
struct WdsTransportTftpClient;

const GUID CLSID_WdsTransportTftpManager = {0xC8E9DCA2, 0x3241, 0x4E4D, [0xB8, 0x06, 0xBC, 0x74, 0x01, 0x9D, 0xFE, 0xDA]};
@GUID(0xC8E9DCA2, 0x3241, 0x4E4D, [0xB8, 0x06, 0xBC, 0x74, 0x01, 0x9D, 0xFE, 0xDA]);
struct WdsTransportTftpManager;

const GUID CLSID_WdsTransportContentProvider = {0xE0BE741F, 0x5A75, 0x4EB9, [0x8A, 0x2D, 0x5E, 0x18, 0x9B, 0x45, 0xF3, 0x27]};
@GUID(0xE0BE741F, 0x5A75, 0x4EB9, [0x8A, 0x2D, 0x5E, 0x18, 0x9B, 0x45, 0xF3, 0x27]);
struct WdsTransportContentProvider;

enum WDSTRANSPORT_FEATURE_FLAGS
{
    WdsTptFeatureAdminPack = 1,
    WdsTptFeatureTransportServer = 2,
    WdsTptFeatureDeploymentServer = 4,
}

enum WDSTRANSPORT_PROTOCOL_FLAGS
{
    WdsTptProtocolUnicast = 1,
    WdsTptProtocolMulticast = 2,
}

enum WDSTRANSPORT_NAMESPACE_TYPE
{
    WdsTptNamespaceTypeUnknown = 0,
    WdsTptNamespaceTypeAutoCast = 1,
    WdsTptNamespaceTypeScheduledCastManualStart = 2,
    WdsTptNamespaceTypeScheduledCastAutoStart = 3,
}

enum WDSTRANSPORT_DISCONNECT_TYPE
{
    WdsTptDisconnectUnknown = 0,
    WdsTptDisconnectFallback = 1,
    WdsTptDisconnectAbort = 2,
}

enum WDSTRANSPORT_SERVICE_NOTIFICATION
{
    WdsTptServiceNotifyUnknown = 0,
    WdsTptServiceNotifyReadSettings = 1,
}

enum WDSTRANSPORT_IP_ADDRESS_TYPE
{
    WdsTptIpAddressUnknown = 0,
    WdsTptIpAddressIpv4 = 1,
    WdsTptIpAddressIpv6 = 2,
}

enum WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE
{
    WdsTptIpAddressSourceUnknown = 0,
    WdsTptIpAddressSourceDhcp = 1,
    WdsTptIpAddressSourceRange = 2,
}

enum WDSTRANSPORT_NETWORK_PROFILE_TYPE
{
    WdsTptNetworkProfileUnknown = 0,
    WdsTptNetworkProfileCustom = 1,
    WdsTptNetworkProfile10Mbps = 2,
    WdsTptNetworkProfile100Mbps = 3,
    WdsTptNetworkProfile1Gbps = 4,
}

enum WDSTRANSPORT_DIAGNOSTICS_COMPONENT_FLAGS
{
    WdsTptDiagnosticsComponentPxe = 1,
    WdsTptDiagnosticsComponentTftp = 2,
    WdsTptDiagnosticsComponentImageServer = 4,
    WdsTptDiagnosticsComponentMulticast = 8,
}

enum WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE
{
    WdsTptSlowClientHandlingUnknown = 0,
    WdsTptSlowClientHandlingNone = 1,
    WdsTptSlowClientHandlingAutoDisconnect = 2,
    WdsTptSlowClientHandlingMultistream = 3,
}

enum WDSTRANSPORT_UDP_PORT_POLICY
{
    WdsTptUdpPortPolicyDynamic = 0,
    WdsTptUdpPortPolicyFixed = 1,
}

enum WDSTRANSPORT_TFTP_CAPABILITY
{
    WdsTptTftpCapMaximumBlockSize = 1,
    WdsTptTftpCapVariableWindow = 2,
}

const GUID IID_IWdsTransportCacheable = {0x46AD894B, 0x0BAB, 0x47DC, [0x84, 0xB2, 0x7B, 0x55, 0x3F, 0x1D, 0x8F, 0x80]};
@GUID(0x46AD894B, 0x0BAB, 0x47DC, [0x84, 0xB2, 0x7B, 0x55, 0x3F, 0x1D, 0x8F, 0x80]);
interface IWdsTransportCacheable : IDispatch
{
    HRESULT get_Dirty(short* pbDirty);
    HRESULT Discard();
    HRESULT Refresh();
    HRESULT Commit();
}

const GUID IID_IWdsTransportCollection = {0xB8BA4B1A, 0x2FF4, 0x43AB, [0x99, 0x6C, 0xB2, 0xB1, 0x0A, 0x91, 0xA6, 0xEB]};
@GUID(0xB8BA4B1A, 0x2FF4, 0x43AB, [0x99, 0x6C, 0xB2, 0xB1, 0x0A, 0x91, 0xA6, 0xEB]);
interface IWdsTransportCollection : IDispatch
{
    HRESULT get_Count(uint* pulCount);
    HRESULT get_Item(uint ulIndex, IDispatch* ppVal);
    HRESULT get__NewEnum(IUnknown* ppVal);
}

const GUID IID_IWdsTransportManager = {0x5B0D35F5, 0x1B13, 0x4AFD, [0xB8, 0x78, 0x65, 0x26, 0xDC, 0x34, 0x0B, 0x5D]};
@GUID(0x5B0D35F5, 0x1B13, 0x4AFD, [0xB8, 0x78, 0x65, 0x26, 0xDC, 0x34, 0x0B, 0x5D]);
interface IWdsTransportManager : IDispatch
{
    HRESULT GetWdsTransportServer(BSTR bszServerName, IWdsTransportServer* ppWdsTransportServer);
}

const GUID IID_IWdsTransportServer = {0x09CCD093, 0x830D, 0x4344, [0xA3, 0x0A, 0x73, 0xAE, 0x8E, 0x8F, 0xCA, 0x90]};
@GUID(0x09CCD093, 0x830D, 0x4344, [0xA3, 0x0A, 0x73, 0xAE, 0x8E, 0x8F, 0xCA, 0x90]);
interface IWdsTransportServer : IDispatch
{
    HRESULT get_Name(BSTR* pbszName);
    HRESULT get_SetupManager(IWdsTransportSetupManager* ppWdsTransportSetupManager);
    HRESULT get_ConfigurationManager(IWdsTransportConfigurationManager* ppWdsTransportConfigurationManager);
    HRESULT get_NamespaceManager(IWdsTransportNamespaceManager* ppWdsTransportNamespaceManager);
    HRESULT DisconnectClient(uint ulClientId, WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

const GUID IID_IWdsTransportServer2 = {0x256E999F, 0x6DF4, 0x4538, [0x81, 0xB9, 0x85, 0x7B, 0x9A, 0xB8, 0xFB, 0x47]};
@GUID(0x256E999F, 0x6DF4, 0x4538, [0x81, 0xB9, 0x85, 0x7B, 0x9A, 0xB8, 0xFB, 0x47]);
interface IWdsTransportServer2 : IWdsTransportServer
{
    HRESULT get_TftpManager(IWdsTransportTftpManager* ppWdsTransportTftpManager);
}

const GUID IID_IWdsTransportSetupManager = {0xF7238425, 0xEFA8, 0x40A4, [0xAE, 0xF9, 0xC9, 0x8D, 0x96, 0x9C, 0x0B, 0x75]};
@GUID(0xF7238425, 0xEFA8, 0x40A4, [0xAE, 0xF9, 0xC9, 0x8D, 0x96, 0x9C, 0x0B, 0x75]);
interface IWdsTransportSetupManager : IDispatch
{
    HRESULT get_Version(ulong* pullVersion);
    HRESULT get_InstalledFeatures(uint* pulInstalledFeatures);
    HRESULT get_Protocols(uint* pulProtocols);
    HRESULT RegisterContentProvider(BSTR bszName, BSTR bszDescription, BSTR bszFilePath, BSTR bszInitializationRoutine);
    HRESULT DeregisterContentProvider(BSTR bszName);
}

const GUID IID_IWdsTransportSetupManager2 = {0x02BE79DA, 0x7E9E, 0x4366, [0x8B, 0x6E, 0x2A, 0xA9, 0xA9, 0x1B, 0xE4, 0x7F]};
@GUID(0x02BE79DA, 0x7E9E, 0x4366, [0x8B, 0x6E, 0x2A, 0xA9, 0xA9, 0x1B, 0xE4, 0x7F]);
interface IWdsTransportSetupManager2 : IWdsTransportSetupManager
{
    HRESULT get_TftpCapabilities(uint* pulTftpCapabilities);
    HRESULT get_ContentProviders(IWdsTransportCollection* ppProviderCollection);
}

const GUID IID_IWdsTransportConfigurationManager = {0x84CC4779, 0x42DD, 0x4792, [0x89, 0x1E, 0x13, 0x21, 0xD6, 0xD7, 0x4B, 0x44]};
@GUID(0x84CC4779, 0x42DD, 0x4792, [0x89, 0x1E, 0x13, 0x21, 0xD6, 0xD7, 0x4B, 0x44]);
interface IWdsTransportConfigurationManager : IDispatch
{
    HRESULT get_ServicePolicy(IWdsTransportServicePolicy* ppWdsTransportServicePolicy);
    HRESULT get_DiagnosticsPolicy(IWdsTransportDiagnosticsPolicy* ppWdsTransportDiagnosticsPolicy);
    HRESULT get_WdsTransportServicesRunning(short bRealtimeStatus, short* pbServicesRunning);
    HRESULT EnableWdsTransportServices();
    HRESULT DisableWdsTransportServices();
    HRESULT StartWdsTransportServices();
    HRESULT StopWdsTransportServices();
    HRESULT RestartWdsTransportServices();
    HRESULT NotifyWdsTransportServices(WDSTRANSPORT_SERVICE_NOTIFICATION ServiceNotification);
}

const GUID IID_IWdsTransportConfigurationManager2 = {0xD0D85CAF, 0xA153, 0x4F1D, [0xA9, 0xDD, 0x96, 0xF4, 0x31, 0xC5, 0x07, 0x17]};
@GUID(0xD0D85CAF, 0xA153, 0x4F1D, [0xA9, 0xDD, 0x96, 0xF4, 0x31, 0xC5, 0x07, 0x17]);
interface IWdsTransportConfigurationManager2 : IWdsTransportConfigurationManager
{
    HRESULT get_MulticastSessionPolicy(IWdsTransportMulticastSessionPolicy* ppWdsTransportMulticastSessionPolicy);
}

const GUID IID_IWdsTransportNamespaceManager = {0x3E22D9F6, 0x3777, 0x4D98, [0x83, 0xE1, 0xF9, 0x86, 0x96, 0x71, 0x7B, 0xA3]};
@GUID(0x3E22D9F6, 0x3777, 0x4D98, [0x83, 0xE1, 0xF9, 0x86, 0x96, 0x71, 0x7B, 0xA3]);
interface IWdsTransportNamespaceManager : IDispatch
{
    HRESULT CreateNamespace(WDSTRANSPORT_NAMESPACE_TYPE NamespaceType, BSTR bszNamespaceName, BSTR bszContentProvider, BSTR bszConfiguration, IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT RetrieveNamespace(BSTR bszNamespaceName, IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT RetrieveNamespaces(BSTR bszContentProvider, BSTR bszNamespaceName, short bIncludeTombstones, IWdsTransportCollection* ppWdsTransportNamespaces);
}

const GUID IID_IWdsTransportTftpManager = {0x1327A7C8, 0xAE8A, 0x4FB3, [0x81, 0x50, 0x13, 0x62, 0x27, 0xC3, 0x7E, 0x9A]};
@GUID(0x1327A7C8, 0xAE8A, 0x4FB3, [0x81, 0x50, 0x13, 0x62, 0x27, 0xC3, 0x7E, 0x9A]);
interface IWdsTransportTftpManager : IDispatch
{
    HRESULT RetrieveTftpClients(IWdsTransportCollection* ppWdsTransportTftpClients);
}

const GUID IID_IWdsTransportServicePolicy = {0xB9468578, 0x9F2B, 0x48CC, [0xB2, 0x7A, 0xA6, 0x07, 0x99, 0xC2, 0x75, 0x0C]};
@GUID(0xB9468578, 0x9F2B, 0x48CC, [0xB2, 0x7A, 0xA6, 0x07, 0x99, 0xC2, 0x75, 0x0C]);
interface IWdsTransportServicePolicy : IWdsTransportCacheable
{
    HRESULT get_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE* pSourceType);
    HRESULT put_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE SourceType);
    HRESULT get_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszStartIpAddress);
    HRESULT put_StartIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszStartIpAddress);
    HRESULT get_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR* pbszEndIpAddress);
    HRESULT put_EndIpAddress(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, BSTR bszEndIpAddress);
    HRESULT get_StartPort(uint* pulStartPort);
    HRESULT put_StartPort(uint ulStartPort);
    HRESULT get_EndPort(uint* pulEndPort);
    HRESULT put_EndPort(uint ulEndPort);
    HRESULT get_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE* pProfileType);
    HRESULT put_NetworkProfile(WDSTRANSPORT_NETWORK_PROFILE_TYPE ProfileType);
}

const GUID IID_IWdsTransportServicePolicy2 = {0x65C19E5C, 0xAA7E, 0x4B91, [0x89, 0x44, 0x91, 0xE0, 0xE5, 0x57, 0x27, 0x97]};
@GUID(0x65C19E5C, 0xAA7E, 0x4B91, [0x89, 0x44, 0x91, 0xE0, 0xE5, 0x57, 0x27, 0x97]);
interface IWdsTransportServicePolicy2 : IWdsTransportServicePolicy
{
    HRESULT get_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY* pUdpPortPolicy);
    HRESULT put_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY UdpPortPolicy);
    HRESULT get_TftpMaximumBlockSize(uint* pulTftpMaximumBlockSize);
    HRESULT put_TftpMaximumBlockSize(uint ulTftpMaximumBlockSize);
    HRESULT get_EnableTftpVariableWindowExtension(short* pbEnableTftpVariableWindowExtension);
    HRESULT put_EnableTftpVariableWindowExtension(short bEnableTftpVariableWindowExtension);
}

const GUID IID_IWdsTransportDiagnosticsPolicy = {0x13B33EFC, 0x7856, 0x4F61, [0x9A, 0x59, 0x8D, 0xE6, 0x7B, 0x6B, 0x87, 0xB6]};
@GUID(0x13B33EFC, 0x7856, 0x4F61, [0x9A, 0x59, 0x8D, 0xE6, 0x7B, 0x6B, 0x87, 0xB6]);
interface IWdsTransportDiagnosticsPolicy : IWdsTransportCacheable
{
    HRESULT get_Enabled(short* pbEnabled);
    HRESULT put_Enabled(short bEnabled);
    HRESULT get_Components(uint* pulComponents);
    HRESULT put_Components(uint ulComponents);
}

const GUID IID_IWdsTransportMulticastSessionPolicy = {0x4E5753CF, 0x68EC, 0x4504, [0xA9, 0x51, 0x4A, 0x00, 0x32, 0x66, 0x60, 0x6B]};
@GUID(0x4E5753CF, 0x68EC, 0x4504, [0xA9, 0x51, 0x4A, 0x00, 0x32, 0x66, 0x60, 0x6B]);
interface IWdsTransportMulticastSessionPolicy : IWdsTransportCacheable
{
    HRESULT get_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE* pSlowClientHandling);
    HRESULT put_SlowClientHandling(WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE SlowClientHandling);
    HRESULT get_AutoDisconnectThreshold(uint* pulThreshold);
    HRESULT put_AutoDisconnectThreshold(uint ulThreshold);
    HRESULT get_MultistreamStreamCount(uint* pulStreamCount);
    HRESULT put_MultistreamStreamCount(uint ulStreamCount);
    HRESULT get_SlowClientFallback(short* pbClientFallback);
    HRESULT put_SlowClientFallback(short bClientFallback);
}

const GUID IID_IWdsTransportNamespace = {0xFA561F57, 0xFBEF, 0x4ED3, [0xB0, 0x56, 0x12, 0x7C, 0xB1, 0xB3, 0x3B, 0x84]};
@GUID(0xFA561F57, 0xFBEF, 0x4ED3, [0xB0, 0x56, 0x12, 0x7C, 0xB1, 0xB3, 0x3B, 0x84]);
interface IWdsTransportNamespace : IDispatch
{
    HRESULT get_Type(WDSTRANSPORT_NAMESPACE_TYPE* pType);
    HRESULT get_Id(uint* pulId);
    HRESULT get_Name(BSTR* pbszName);
    HRESULT put_Name(BSTR bszName);
    HRESULT get_FriendlyName(BSTR* pbszFriendlyName);
    HRESULT put_FriendlyName(BSTR bszFriendlyName);
    HRESULT get_Description(BSTR* pbszDescription);
    HRESULT put_Description(BSTR bszDescription);
    HRESULT get_ContentProvider(BSTR* pbszContentProvider);
    HRESULT put_ContentProvider(BSTR bszContentProvider);
    HRESULT get_Configuration(BSTR* pbszConfiguration);
    HRESULT put_Configuration(BSTR bszConfiguration);
    HRESULT get_Registered(short* pbRegistered);
    HRESULT get_Tombstoned(short* pbTombstoned);
    HRESULT get_TombstoneTime(double* pTombstoneTime);
    HRESULT get_TransmissionStarted(short* pbTransmissionStarted);
    HRESULT Register();
    HRESULT Deregister(short bTerminateSessions);
    HRESULT Clone(IWdsTransportNamespace* ppWdsTransportNamespaceClone);
    HRESULT Refresh();
    HRESULT RetrieveContents(IWdsTransportCollection* ppWdsTransportContents);
}

const GUID IID_IWdsTransportNamespaceAutoCast = {0xAD931A72, 0xC4BD, 0x4C41, [0x8F, 0xBC, 0x59, 0xC9, 0xC7, 0x48, 0xDF, 0x9E]};
@GUID(0xAD931A72, 0xC4BD, 0x4C41, [0x8F, 0xBC, 0x59, 0xC9, 0xC7, 0x48, 0xDF, 0x9E]);
interface IWdsTransportNamespaceAutoCast : IWdsTransportNamespace
{
}

const GUID IID_IWdsTransportNamespaceScheduledCast = {0x3840CECF, 0xD76C, 0x416E, [0xA4, 0xCC, 0x31, 0xC7, 0x41, 0xD2, 0x87, 0x4B]};
@GUID(0x3840CECF, 0xD76C, 0x416E, [0xA4, 0xCC, 0x31, 0xC7, 0x41, 0xD2, 0x87, 0x4B]);
interface IWdsTransportNamespaceScheduledCast : IWdsTransportNamespace
{
    HRESULT StartTransmission();
}

const GUID IID_IWdsTransportNamespaceScheduledCastManualStart = {0x013E6E4C, 0xE6A7, 0x4FB5, [0xB7, 0xFF, 0xD9, 0xF5, 0xDA, 0x80, 0x5C, 0x31]};
@GUID(0x013E6E4C, 0xE6A7, 0x4FB5, [0xB7, 0xFF, 0xD9, 0xF5, 0xDA, 0x80, 0x5C, 0x31]);
interface IWdsTransportNamespaceScheduledCastManualStart : IWdsTransportNamespaceScheduledCast
{
}

const GUID IID_IWdsTransportNamespaceScheduledCastAutoStart = {0xD606AF3D, 0xEA9C, 0x4219, [0x96, 0x1E, 0x74, 0x91, 0xD6, 0x18, 0xD9, 0xB9]};
@GUID(0xD606AF3D, 0xEA9C, 0x4219, [0x96, 0x1E, 0x74, 0x91, 0xD6, 0x18, 0xD9, 0xB9]);
interface IWdsTransportNamespaceScheduledCastAutoStart : IWdsTransportNamespaceScheduledCast
{
    HRESULT get_MinimumClients(uint* pulMinimumClients);
    HRESULT put_MinimumClients(uint ulMinimumClients);
    HRESULT get_StartTime(double* pStartTime);
    HRESULT put_StartTime(double StartTime);
}

const GUID IID_IWdsTransportContent = {0xD405D711, 0x0296, 0x4AB4, [0xA8, 0x60, 0xAC, 0x7D, 0x32, 0xE6, 0x57, 0x98]};
@GUID(0xD405D711, 0x0296, 0x4AB4, [0xA8, 0x60, 0xAC, 0x7D, 0x32, 0xE6, 0x57, 0x98]);
interface IWdsTransportContent : IDispatch
{
    HRESULT get_Namespace(IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT get_Id(uint* pulId);
    HRESULT get_Name(BSTR* pbszName);
    HRESULT RetrieveSessions(IWdsTransportCollection* ppWdsTransportSessions);
    HRESULT Terminate();
}

const GUID IID_IWdsTransportSession = {0xF4EFEA88, 0x65B1, 0x4F30, [0xA4, 0xB9, 0x27, 0x93, 0x98, 0x77, 0x96, 0xFB]};
@GUID(0xF4EFEA88, 0x65B1, 0x4F30, [0xA4, 0xB9, 0x27, 0x93, 0x98, 0x77, 0x96, 0xFB]);
interface IWdsTransportSession : IDispatch
{
    HRESULT get_Content(IWdsTransportContent* ppWdsTransportContent);
    HRESULT get_Id(uint* pulId);
    HRESULT get_NetworkInterfaceName(BSTR* pbszNetworkInterfaceName);
    HRESULT get_NetworkInterfaceAddress(BSTR* pbszNetworkInterfaceAddress);
    HRESULT get_TransferRate(uint* pulTransferRate);
    HRESULT get_MasterClientId(uint* pulMasterClientId);
    HRESULT RetrieveClients(IWdsTransportCollection* ppWdsTransportClients);
    HRESULT Terminate();
}

const GUID IID_IWdsTransportClient = {0xB5DBC93A, 0xCABE, 0x46CA, [0x83, 0x7F, 0x3E, 0x44, 0xE9, 0x3C, 0x65, 0x45]};
@GUID(0xB5DBC93A, 0xCABE, 0x46CA, [0x83, 0x7F, 0x3E, 0x44, 0xE9, 0x3C, 0x65, 0x45]);
interface IWdsTransportClient : IDispatch
{
    HRESULT get_Session(IWdsTransportSession* ppWdsTransportSession);
    HRESULT get_Id(uint* pulId);
    HRESULT get_Name(BSTR* pbszName);
    HRESULT get_MacAddress(BSTR* pbszMacAddress);
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    HRESULT get_PercentCompletion(uint* pulPercentCompletion);
    HRESULT get_JoinDuration(uint* pulJoinDuration);
    HRESULT get_CpuUtilization(uint* pulCpuUtilization);
    HRESULT get_MemoryUtilization(uint* pulMemoryUtilization);
    HRESULT get_NetworkUtilization(uint* pulNetworkUtilization);
    HRESULT get_UserIdentity(BSTR* pbszUserIdentity);
    HRESULT Disconnect(WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

const GUID IID_IWdsTransportTftpClient = {0xB022D3AE, 0x884D, 0x4D85, [0xB1, 0x46, 0x53, 0x32, 0x0E, 0x76, 0xEF, 0x62]};
@GUID(0xB022D3AE, 0x884D, 0x4D85, [0xB1, 0x46, 0x53, 0x32, 0x0E, 0x76, 0xEF, 0x62]);
interface IWdsTransportTftpClient : IDispatch
{
    HRESULT get_FileName(BSTR* pbszFileName);
    HRESULT get_IpAddress(BSTR* pbszIpAddress);
    HRESULT get_Timeout(uint* pulTimeout);
    HRESULT get_CurrentFileOffset(ulong* pul64CurrentOffset);
    HRESULT get_FileSize(ulong* pul64FileSize);
    HRESULT get_BlockSize(uint* pulBlockSize);
    HRESULT get_WindowSize(uint* pulWindowSize);
}

const GUID IID_IWdsTransportContentProvider = {0xB9489F24, 0xF219, 0x4ACF, [0xAA, 0xD7, 0x26, 0x5C, 0x7C, 0x08, 0xA6, 0xAE]};
@GUID(0xB9489F24, 0xF219, 0x4ACF, [0xAA, 0xD7, 0x26, 0x5C, 0x7C, 0x08, 0xA6, 0xAE]);
interface IWdsTransportContentProvider : IDispatch
{
    HRESULT get_Name(BSTR* pbszName);
    HRESULT get_Description(BSTR* pbszDescription);
    HRESULT get_FilePath(BSTR* pbszFilePath);
    HRESULT get_InitializationRoutine(BSTR* pbszInitializationRoutine);
}

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliClose(HANDLE Handle);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliRegisterTrace(PFN_WdsCliTraceFunction pfn);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFreeStringArray(char* ppwszArray, uint ulCount);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFindFirstImage(HANDLE hSession, int* phFindHandle);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliFindNextImage(HANDLE Handle);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetEnumerationFlags(HANDLE Handle, uint* pdwFlags);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHandleFromFindHandle(HANDLE FindHandle, int* phImageHandle);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHandleFromTransferHandle(HANDLE hTransfer, int* phImageHandle);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliCreateSession(const(wchar)* pwszServer, WDS_CLI_CRED* pCred, int* phSession);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliAuthorizeSession(HANDLE hSession, WDS_CLI_CRED* pCred);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliInitializeLog(HANDLE hSession, uint ulClientArchitecture, const(wchar)* pwszClientId, const(wchar)* pwszClientAddress);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliLog(HANDLE hSession, uint ulLogLevel, uint ulMessageCode);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageName(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageDescription(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageType(HANDLE hIfh, WDS_CLI_IMAGE_TYPE* pImageType);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageFiles(HANDLE hIfh, ushort*** pppwszFiles, uint* pdwCount);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLanguage(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLanguages(HANDLE hIfh, byte*** pppszValues, uint* pdwNumValues);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageVersion(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImagePath(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageIndex(HANDLE hIfh, uint* pdwValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageArchitecture(HANDLE hIfh, uint* pdwValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageLastModifiedTime(HANDLE hIfh, SYSTEMTIME** ppSysTimeValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageHalName(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageGroup(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageNamespace(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetImageParameter(HANDLE hIfh, WDS_CLI_IMAGE_PARAM_TYPE ParamType, char* pResponse, uint uResponseLen);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetTransferSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI.dll")
void WdsCliSetTransferBufferSize(uint ulSizeInBytes);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliTransferImage(HANDLE hImage, const(wchar)* pwszLocalPath, uint dwFlags, uint dwReserved, PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, int* phTransfer);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliTransferFile(const(wchar)* pwszServer, const(wchar)* pwszNamespace, const(wchar)* pwszRemoteFilePath, const(wchar)* pwszLocalFilePath, uint dwFlags, uint dwReserved, PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, int* phTransfer);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliCancelTransfer(HANDLE hTransfer);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliWaitForTransfer(HANDLE hTransfer);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliObtainDriverPackages(HANDLE hImage, ushort** ppwszServerName, ushort*** pppwszDriverPackages, uint* pulCount);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliObtainDriverPackagesEx(HANDLE hSession, const(wchar)* pwszMachineInfo, ushort** ppwszServerName, ushort*** pppwszDriverPackages, uint* pulCount);

@DllImport("WDSCLIENTAPI.dll")
HRESULT WdsCliGetDriverQueryXml(const(wchar)* pwszWinDirPath, ushort** ppwszDriverQuery);

@DllImport("WDSPXE.dll")
uint PxeProviderRegister(const(wchar)* pszProviderName, const(wchar)* pszModulePath, uint Index, BOOL bIsCritical, HKEY* phProviderKey);

@DllImport("WDSPXE.dll")
uint PxeProviderUnRegister(const(wchar)* pszProviderName);

@DllImport("WDSPXE.dll")
uint PxeProviderQueryIndex(const(wchar)* pszProviderName, uint* puIndex);

@DllImport("WDSPXE.dll")
uint PxeProviderEnumFirst(HANDLE* phEnum);

@DllImport("WDSPXE.dll")
uint PxeProviderEnumNext(HANDLE hEnum, PXE_PROVIDER** ppProvider);

@DllImport("WDSPXE.dll")
uint PxeProviderEnumClose(HANDLE hEnum);

@DllImport("WDSPXE.dll")
uint PxeProviderFreeInfo(PXE_PROVIDER* pProvider);

@DllImport("WDSPXE.dll")
uint PxeRegisterCallback(HANDLE hProvider, uint CallbackType, void* pCallbackFunction, void* pContext);

@DllImport("WDSPXE.dll")
uint PxeSendReply(HANDLE hClientRequest, char* pPacket, uint uPacketLen, PXE_ADDRESS* pAddress);

@DllImport("WDSPXE.dll")
uint PxeAsyncRecvDone(HANDLE hClientRequest, uint Action);

@DllImport("WDSPXE.dll")
uint PxeTrace(HANDLE hProvider, uint Severity, const(wchar)* pszFormat);

@DllImport("WDSPXE.dll")
uint PxeTraceV(HANDLE hProvider, uint Severity, const(wchar)* pszFormat, byte* Params);

@DllImport("WDSPXE.dll")
void* PxePacketAllocate(HANDLE hProvider, HANDLE hClientRequest, uint uSize);

@DllImport("WDSPXE.dll")
uint PxePacketFree(HANDLE hProvider, HANDLE hClientRequest, void* pPacket);

@DllImport("WDSPXE.dll")
uint PxeProviderSetAttribute(HANDLE hProvider, uint Attribute, char* pParameterBuffer, uint uParamLen);

@DllImport("WDSPXE.dll")
uint PxeDhcpInitialize(char* pRecvPacket, uint uRecvPacketLen, char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6Initialize(char* pRequest, uint cbRequest, char* pReply, uint cbReply, uint* pcbReplyUsed);

@DllImport("WDSPXE.dll")
uint PxeDhcpAppendOption(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ubyte bOption, ubyte bOptionLen, char* pValue);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6AppendOption(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort wOptionType, ushort cbOption, char* pOption);

@DllImport("WDSPXE.dll")
uint PxeDhcpAppendOptionRaw(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ushort uBufferLen, char* pBuffer);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6AppendOptionRaw(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort cbBuffer, char* pBuffer);

@DllImport("WDSPXE.dll")
uint PxeDhcpIsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6IsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

@DllImport("WDSPXE.dll")
uint PxeDhcpGetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ubyte bOption, ubyte* pbOptionLen, void** ppOptionValue);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6GetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ushort wOption, ushort* pwOptionLen, void** ppOptionValue);

@DllImport("WDSPXE.dll")
uint PxeDhcpGetVendorOptionValue(char* pPacket, uint uPacketLen, ubyte bOption, uint uInstance, ubyte* pbOptionLen, void** ppOptionValue);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6GetVendorOptionValue(char* pPacket, uint uPacketLen, uint dwEnterpriseNumber, ushort wOption, uint uInstance, ushort* pwOptionLen, void** ppOptionValue);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6ParseRelayForw(char* pRelayForwPacket, uint uRelayForwPacketLen, char* pRelayMessages, uint nRelayMessages, uint* pnRelayMessages, ubyte** ppInnerPacket, uint* pcbInnerPacket);

@DllImport("WDSPXE.dll")
uint PxeDhcpv6CreateRelayRepl(char* pRelayMessages, uint nRelayMessages, char* pInnerPacket, uint cbInnerPacket, char* pReplyBuffer, uint cbReplyBuffer, uint* pcbReplyBuffer);

@DllImport("WDSPXE.dll")
uint PxeGetServerInfo(uint uInfoType, char* pBuffer, uint uBufferLen);

@DllImport("WDSPXE.dll")
uint PxeGetServerInfoEx(uint uInfoType, char* pBuffer, uint uBufferLen, uint* puBufferUsed);

@DllImport("WDSMC.dll")
HRESULT WdsTransportServerRegisterCallback(HANDLE hProvider, TRANSPORTPROVIDER_CALLBACK_ID CallbackId, void* pfnCallback);

@DllImport("WDSMC.dll")
HRESULT WdsTransportServerCompleteRead(HANDLE hProvider, uint ulBytesRead, void* pvUserData, HRESULT hReadResult);

@DllImport("WDSMC.dll")
HRESULT WdsTransportServerTrace(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat);

@DllImport("WDSMC.dll")
HRESULT WdsTransportServerTraceV(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat, byte* Params);

@DllImport("WDSMC.dll")
void* WdsTransportServerAllocateBuffer(HANDLE hProvider, uint ulBufferSize);

@DllImport("WDSMC.dll")
HRESULT WdsTransportServerFreeBuffer(HANDLE hProvider, void* pvBuffer);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientInitialize();

@DllImport("WDSTPTC.dll")
uint WdsTransportClientInitializeSession(WDS_TRANSPORTCLIENT_REQUEST* pSessionRequest, void* pCallerData, int* hSessionKey);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientRegisterCallback(HANDLE hSessionKey, TRANSPORTCLIENT_CALLBACK_ID CallbackId, void* pfnCallback);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientStartSession(HANDLE hSessionKey);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientCompleteReceive(HANDLE hSessionKey, uint ulSize, ULARGE_INTEGER* pullOffset);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientCancelSession(HANDLE hSessionKey);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientCancelSessionEx(HANDLE hSessionKey, uint dwErrorCode);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientWaitForCompletion(HANDLE hSessionKey, uint uTimeout);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientQueryStatus(HANDLE hSessionKey, uint* puStatus, uint* puErrorCode);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientCloseSession(HANDLE hSessionKey);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientAddRefBuffer(void* pvBuffer);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientReleaseBuffer(void* pvBuffer);

@DllImport("WDSTPTC.dll")
uint WdsTransportClientShutdown();

@DllImport("WDSBP.dll")
uint WdsBpParseInitialize(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

@DllImport("WDSBP.dll")
uint WdsBpParseInitializev6(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

@DllImport("WDSBP.dll")
uint WdsBpInitialize(ubyte bPacketType, HANDLE* phHandle);

@DllImport("WDSBP.dll")
uint WdsBpCloseHandle(HANDLE hHandle);

@DllImport("WDSBP.dll")
uint WdsBpQueryOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue, uint* puBytes);

@DllImport("WDSBP.dll")
uint WdsBpAddOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue);

@DllImport("WDSBP.dll")
uint WdsBpGetOptionBuffer(HANDLE hHandle, uint uBufferLen, char* pBuffer, uint* puBytes);

