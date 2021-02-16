module windows.windowsdeploymentservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE, ULARGE_INTEGER;
public import windows.windowsandmessaging : LPARAM, WPARAM;
public import windows.windowsprogramming : HKEY, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    WDS_CLI_IMAGE_TYPE_UNKNOWN = 0x00000000,
    WDS_CLI_IMAGE_TYPE_WIM     = 0x00000001,
    WDS_CLI_IMAGE_TYPE_VHD     = 0x00000002,
    WDS_CLI_IMAGE_TYPE_VHDX    = 0x00000003,
}
alias WDS_CLI_IMAGE_TYPE = int;

enum : int
{
    WDS_CLI_FIRMWARE_UNKNOWN = 0x00000000,
    WDS_CLI_FIRMWARE_BIOS    = 0x00000001,
    WDS_CLI_FIRMWARE_EFI     = 0x00000002,
}
alias WDS_CLI_FIRMWARE_TYPE = int;

enum : int
{
    WDS_CLI_IMAGE_PARAM_UNKNOWN             = 0x00000000,
    WDS_CLI_IMAGE_PARAM_SPARSE_FILE         = 0x00000001,
    WDS_CLI_IMAGE_PARAM_SUPPORTED_FIRMWARES = 0x00000002,
}
alias WDS_CLI_IMAGE_PARAM_TYPE = int;

enum : int
{
    WDS_TRANSPORTPROVIDER_CREATE_INSTANCE      = 0x00000000,
    WDS_TRANSPORTPROVIDER_COMPARE_CONTENT      = 0x00000001,
    WDS_TRANSPORTPROVIDER_OPEN_CONTENT         = 0x00000002,
    WDS_TRANSPORTPROVIDER_USER_ACCESS_CHECK    = 0x00000003,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_SIZE     = 0x00000004,
    WDS_TRANSPORTPROVIDER_READ_CONTENT         = 0x00000005,
    WDS_TRANSPORTPROVIDER_CLOSE_CONTENT        = 0x00000006,
    WDS_TRANSPORTPROVIDER_CLOSE_INSTANCE       = 0x00000007,
    WDS_TRANSPORTPROVIDER_SHUTDOWN             = 0x00000008,
    WDS_TRANSPORTPROVIDER_DUMP_STATE           = 0x00000009,
    WDS_TRANSPORTPROVIDER_REFRESH_SETTINGS     = 0x0000000a,
    WDS_TRANSPORTPROVIDER_GET_CONTENT_METADATA = 0x0000000b,
    WDS_TRANSPORTPROVIDER_MAX_CALLBACKS        = 0x0000000c,
}
alias TRANSPORTPROVIDER_CALLBACK_ID = int;

enum : int
{
    WDS_TRANSPORTCLIENT_SESSION_START     = 0x00000000,
    WDS_TRANSPORTCLIENT_RECEIVE_CONTENTS  = 0x00000001,
    WDS_TRANSPORTCLIENT_SESSION_COMPLETE  = 0x00000002,
    WDS_TRANSPORTCLIENT_RECEIVE_METADATA  = 0x00000003,
    WDS_TRANSPORTCLIENT_SESSION_STARTEX   = 0x00000004,
    WDS_TRANSPORTCLIENT_SESSION_NEGOTIATE = 0x00000005,
    WDS_TRANSPORTCLIENT_MAX_CALLBACKS     = 0x00000006,
}
alias TRANSPORTCLIENT_CALLBACK_ID = int;

enum : int
{
    WdsTptFeatureAdminPack        = 0x00000001,
    WdsTptFeatureTransportServer  = 0x00000002,
    WdsTptFeatureDeploymentServer = 0x00000004,
}
alias WDSTRANSPORT_FEATURE_FLAGS = int;

enum : int
{
    WdsTptProtocolUnicast   = 0x00000001,
    WdsTptProtocolMulticast = 0x00000002,
}
alias WDSTRANSPORT_PROTOCOL_FLAGS = int;

enum : int
{
    WdsTptNamespaceTypeUnknown                  = 0x00000000,
    WdsTptNamespaceTypeAutoCast                 = 0x00000001,
    WdsTptNamespaceTypeScheduledCastManualStart = 0x00000002,
    WdsTptNamespaceTypeScheduledCastAutoStart   = 0x00000003,
}
alias WDSTRANSPORT_NAMESPACE_TYPE = int;

enum : int
{
    WdsTptDisconnectUnknown  = 0x00000000,
    WdsTptDisconnectFallback = 0x00000001,
    WdsTptDisconnectAbort    = 0x00000002,
}
alias WDSTRANSPORT_DISCONNECT_TYPE = int;

enum : int
{
    WdsTptServiceNotifyUnknown      = 0x00000000,
    WdsTptServiceNotifyReadSettings = 0x00000001,
}
alias WDSTRANSPORT_SERVICE_NOTIFICATION = int;

enum : int
{
    WdsTptIpAddressUnknown = 0x00000000,
    WdsTptIpAddressIpv4    = 0x00000001,
    WdsTptIpAddressIpv6    = 0x00000002,
}
alias WDSTRANSPORT_IP_ADDRESS_TYPE = int;

enum : int
{
    WdsTptIpAddressSourceUnknown = 0x00000000,
    WdsTptIpAddressSourceDhcp    = 0x00000001,
    WdsTptIpAddressSourceRange   = 0x00000002,
}
alias WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE = int;

enum : int
{
    WdsTptNetworkProfileUnknown = 0x00000000,
    WdsTptNetworkProfileCustom  = 0x00000001,
    WdsTptNetworkProfile10Mbps  = 0x00000002,
    WdsTptNetworkProfile100Mbps = 0x00000003,
    WdsTptNetworkProfile1Gbps   = 0x00000004,
}
alias WDSTRANSPORT_NETWORK_PROFILE_TYPE = int;

enum : int
{
    WdsTptDiagnosticsComponentPxe         = 0x00000001,
    WdsTptDiagnosticsComponentTftp        = 0x00000002,
    WdsTptDiagnosticsComponentImageServer = 0x00000004,
    WdsTptDiagnosticsComponentMulticast   = 0x00000008,
}
alias WDSTRANSPORT_DIAGNOSTICS_COMPONENT_FLAGS = int;

enum : int
{
    WdsTptSlowClientHandlingUnknown        = 0x00000000,
    WdsTptSlowClientHandlingNone           = 0x00000001,
    WdsTptSlowClientHandlingAutoDisconnect = 0x00000002,
    WdsTptSlowClientHandlingMultistream    = 0x00000003,
}
alias WDSTRANSPORT_SLOW_CLIENT_HANDLING_TYPE = int;

enum : int
{
    WdsTptUdpPortPolicyDynamic = 0x00000000,
    WdsTptUdpPortPolicyFixed   = 0x00000001,
}
alias WDSTRANSPORT_UDP_PORT_POLICY = int;

enum : int
{
    WdsTptTftpCapMaximumBlockSize = 0x00000001,
    WdsTptTftpCapVariableWindow   = 0x00000002,
}
alias WDSTRANSPORT_TFTP_CAPABILITY = int;

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

alias PFN_WdsCliTraceFunction = void function(const(wchar)* pwszFormat, byte* Params);
alias PFN_WdsCliCallback = void function(uint dwMessageId, WPARAM wParam, LPARAM lParam, void* pvUserData);
alias PFN_WdsTransportClientSessionStart = void function(HANDLE hSessionKey, void* pCallerData, 
                                                         ULARGE_INTEGER* ullFileSize);
alias PFN_WdsTransportClientSessionStartEx = void function(HANDLE hSessionKey, void* pCallerData, 
                                                           TRANSPORTCLIENT_SESSION_INFO* Info);
alias PFN_WdsTransportClientReceiveMetadata = void function(HANDLE hSessionKey, void* pCallerData, char* pMetadata, 
                                                            uint ulSize);
alias PFN_WdsTransportClientReceiveContents = void function(HANDLE hSessionKey, void* pCallerData, char* pContents, 
                                                            uint ulSize, ULARGE_INTEGER* pullContentOffset);
alias PFN_WdsTransportClientSessionComplete = void function(HANDLE hSessionKey, void* pCallerData, uint dwError);
alias PFN_WdsTransportClientSessionNegotiate = void function(HANDLE hSessionKey, void* pCallerData, 
                                                             TRANSPORTCLIENT_SESSION_INFO* pInfo, 
                                                             HANDLE hNegotiateKey);

// Structs


struct WDS_CLI_CRED
{
    const(wchar)* pwszUserName;
    const(wchar)* pwszDomain;
    const(wchar)* pwszPassword;
}

struct PXE_DHCP_OPTION
{
    ubyte    OptionType;
    ubyte    OptionLength;
    ubyte[1] OptionValue;
}

struct PXE_DHCP_MESSAGE
{
align (1):
    ubyte           Operation;
    ubyte           HardwareAddressType;
    ubyte           HardwareAddressLength;
    ubyte           HopCount;
    uint            TransactionID;
    ushort          SecondsSinceBoot;
    ushort          Reserved;
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

struct PXE_DHCPV6_OPTION
{
align (1):
    ushort   OptionCode;
    ushort   DataLength;
    ubyte[1] Data;
}

struct PXE_DHCPV6_MESSAGE_HEADER
{
    ubyte    MessageType;
    ubyte[1] Message;
}

struct PXE_DHCPV6_MESSAGE
{
    ubyte                MessageType;
    ubyte                TransactionIDByte1;
    ubyte                TransactionIDByte2;
    ubyte                TransactionIDByte3;
    PXE_DHCPV6_OPTION[1] Options;
}

struct PXE_DHCPV6_RELAY_MESSAGE
{
    ubyte                MessageType;
    ubyte                HopCount;
    ubyte[16]            LinkAddress;
    ubyte[16]            PeerAddress;
    PXE_DHCPV6_OPTION[1] Options;
}

struct PXE_PROVIDER
{
    uint          uSizeOfStruct;
    const(wchar)* pwszName;
    const(wchar)* pwszFilePath;
    BOOL          bIsCritical;
    uint          uIndex;
}

struct PXE_ADDRESS
{
    uint   uFlags;
    union
    {
        ubyte[16] bAddress;
        uint      uIpAddress;
    }
    uint   uAddrLen;
    ushort uPort;
}

struct PXE_DHCPV6_NESTED_RELAY_MESSAGE
{
    PXE_DHCPV6_RELAY_MESSAGE* pRelayMessage;
    uint   cbRelayMessage;
    void*  pInterfaceIdOption;
    ushort cbInterfaceIdOption;
}

struct WDS_TRANSPORTPROVIDER_INIT_PARAMS
{
    uint   ulLength;
    uint   ulMcServerVersion;
    HKEY   hRegistryKey;
    HANDLE hProvider;
}

struct WDS_TRANSPORTPROVIDER_SETTINGS
{
    uint ulLength;
    uint ulProviderVersion;
}

struct TRANSPORTCLIENT_SESSION_INFO
{
    uint           ulStructureLength;
    ULARGE_INTEGER ullFileSize;
    uint           ulBlockSize;
}

struct WDS_TRANSPORTCLIENT_REQUEST
{
    uint          ulLength;
    uint          ulApiVersion;
    uint          ulAuthLevel;
    const(wchar)* pwszServer;
    const(wchar)* pwszNamespace;
    const(wchar)* pwszObjectName;
    uint          ulCacheSize;
    uint          ulProtocol;
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

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliClose(HANDLE Handle);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliRegisterTrace(PFN_WdsCliTraceFunction pfn);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFreeStringArray(char* ppwszArray, uint ulCount);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFindFirstImage(HANDLE hSession, ptrdiff_t* phFindHandle);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliFindNextImage(HANDLE Handle);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetEnumerationFlags(HANDLE Handle, uint* pdwFlags);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHandleFromFindHandle(HANDLE FindHandle, ptrdiff_t* phImageHandle);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHandleFromTransferHandle(HANDLE hTransfer, ptrdiff_t* phImageHandle);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliCreateSession(const(wchar)* pwszServer, WDS_CLI_CRED* pCred, ptrdiff_t* phSession);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliAuthorizeSession(HANDLE hSession, WDS_CLI_CRED* pCred);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliInitializeLog(HANDLE hSession, uint ulClientArchitecture, const(wchar)* pwszClientId, 
                            const(wchar)* pwszClientAddress);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliLog(HANDLE hSession, uint ulLogLevel, uint ulMessageCode);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageName(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageDescription(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageType(HANDLE hIfh, WDS_CLI_IMAGE_TYPE* pImageType);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageFiles(HANDLE hIfh, ushort*** pppwszFiles, uint* pdwCount);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLanguage(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLanguages(HANDLE hIfh, byte*** pppszValues, uint* pdwNumValues);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageVersion(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImagePath(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageIndex(HANDLE hIfh, uint* pdwValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageArchitecture(HANDLE hIfh, uint* pdwValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageLastModifiedTime(HANDLE hIfh, SYSTEMTIME** ppSysTimeValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageHalName(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageGroup(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageNamespace(HANDLE hIfh, ushort** ppwszValue);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetImageParameter(HANDLE hIfh, WDS_CLI_IMAGE_PARAM_TYPE ParamType, char* pResponse, 
                                uint uResponseLen);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetTransferSize(HANDLE hIfh, ulong* pullValue);

@DllImport("WDSCLIENTAPI")
void WdsCliSetTransferBufferSize(uint ulSizeInBytes);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliTransferImage(HANDLE hImage, const(wchar)* pwszLocalPath, uint dwFlags, uint dwReserved, 
                            PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, ptrdiff_t* phTransfer);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliTransferFile(const(wchar)* pwszServer, const(wchar)* pwszNamespace, const(wchar)* pwszRemoteFilePath, 
                           const(wchar)* pwszLocalFilePath, uint dwFlags, uint dwReserved, 
                           PFN_WdsCliCallback pfnWdsCliCallback, void* pvUserData, ptrdiff_t* phTransfer);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliCancelTransfer(HANDLE hTransfer);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliWaitForTransfer(HANDLE hTransfer);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliObtainDriverPackages(HANDLE hImage, ushort** ppwszServerName, ushort*** pppwszDriverPackages, 
                                   uint* pulCount);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliObtainDriverPackagesEx(HANDLE hSession, const(wchar)* pwszMachineInfo, ushort** ppwszServerName, 
                                     ushort*** pppwszDriverPackages, uint* pulCount);

@DllImport("WDSCLIENTAPI")
HRESULT WdsCliGetDriverQueryXml(const(wchar)* pwszWinDirPath, ushort** ppwszDriverQuery);

@DllImport("WDSPXE")
uint PxeProviderRegister(const(wchar)* pszProviderName, const(wchar)* pszModulePath, uint Index, BOOL bIsCritical, 
                         HKEY* phProviderKey);

@DllImport("WDSPXE")
uint PxeProviderUnRegister(const(wchar)* pszProviderName);

@DllImport("WDSPXE")
uint PxeProviderQueryIndex(const(wchar)* pszProviderName, uint* puIndex);

@DllImport("WDSPXE")
uint PxeProviderEnumFirst(HANDLE* phEnum);

@DllImport("WDSPXE")
uint PxeProviderEnumNext(HANDLE hEnum, PXE_PROVIDER** ppProvider);

@DllImport("WDSPXE")
uint PxeProviderEnumClose(HANDLE hEnum);

@DllImport("WDSPXE")
uint PxeProviderFreeInfo(PXE_PROVIDER* pProvider);

@DllImport("WDSPXE")
uint PxeRegisterCallback(HANDLE hProvider, uint CallbackType, void* pCallbackFunction, void* pContext);

@DllImport("WDSPXE")
uint PxeSendReply(HANDLE hClientRequest, char* pPacket, uint uPacketLen, PXE_ADDRESS* pAddress);

@DllImport("WDSPXE")
uint PxeAsyncRecvDone(HANDLE hClientRequest, uint Action);

@DllImport("WDSPXE")
uint PxeTrace(HANDLE hProvider, uint Severity, const(wchar)* pszFormat);

@DllImport("WDSPXE")
uint PxeTraceV(HANDLE hProvider, uint Severity, const(wchar)* pszFormat, byte* Params);

@DllImport("WDSPXE")
void* PxePacketAllocate(HANDLE hProvider, HANDLE hClientRequest, uint uSize);

@DllImport("WDSPXE")
uint PxePacketFree(HANDLE hProvider, HANDLE hClientRequest, void* pPacket);

@DllImport("WDSPXE")
uint PxeProviderSetAttribute(HANDLE hProvider, uint Attribute, char* pParameterBuffer, uint uParamLen);

@DllImport("WDSPXE")
uint PxeDhcpInitialize(char* pRecvPacket, uint uRecvPacketLen, char* pReplyPacket, uint uMaxReplyPacketLen, 
                       uint* puReplyPacketLen);

@DllImport("WDSPXE")
uint PxeDhcpv6Initialize(char* pRequest, uint cbRequest, char* pReply, uint cbReply, uint* pcbReplyUsed);

@DllImport("WDSPXE")
uint PxeDhcpAppendOption(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ubyte bOption, 
                         ubyte bOptionLen, char* pValue);

@DllImport("WDSPXE")
uint PxeDhcpv6AppendOption(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort wOptionType, ushort cbOption, 
                           char* pOption);

@DllImport("WDSPXE")
uint PxeDhcpAppendOptionRaw(char* pReplyPacket, uint uMaxReplyPacketLen, uint* puReplyPacketLen, ushort uBufferLen, 
                            char* pBuffer);

@DllImport("WDSPXE")
uint PxeDhcpv6AppendOptionRaw(char* pReply, uint cbReply, uint* pcbReplyUsed, ushort cbBuffer, char* pBuffer);

@DllImport("WDSPXE")
uint PxeDhcpIsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

@DllImport("WDSPXE")
uint PxeDhcpv6IsValid(char* pPacket, uint uPacketLen, BOOL bRequestPacket, int* pbPxeOptionPresent);

@DllImport("WDSPXE")
uint PxeDhcpGetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ubyte bOption, ubyte* pbOptionLen, 
                           void** ppOptionValue);

@DllImport("WDSPXE")
uint PxeDhcpv6GetOptionValue(char* pPacket, uint uPacketLen, uint uInstance, ushort wOption, ushort* pwOptionLen, 
                             void** ppOptionValue);

@DllImport("WDSPXE")
uint PxeDhcpGetVendorOptionValue(char* pPacket, uint uPacketLen, ubyte bOption, uint uInstance, ubyte* pbOptionLen, 
                                 void** ppOptionValue);

@DllImport("WDSPXE")
uint PxeDhcpv6GetVendorOptionValue(char* pPacket, uint uPacketLen, uint dwEnterpriseNumber, ushort wOption, 
                                   uint uInstance, ushort* pwOptionLen, void** ppOptionValue);

@DllImport("WDSPXE")
uint PxeDhcpv6ParseRelayForw(char* pRelayForwPacket, uint uRelayForwPacketLen, char* pRelayMessages, 
                             uint nRelayMessages, uint* pnRelayMessages, ubyte** ppInnerPacket, uint* pcbInnerPacket);

@DllImport("WDSPXE")
uint PxeDhcpv6CreateRelayRepl(char* pRelayMessages, uint nRelayMessages, char* pInnerPacket, uint cbInnerPacket, 
                              char* pReplyBuffer, uint cbReplyBuffer, uint* pcbReplyBuffer);

@DllImport("WDSPXE")
uint PxeGetServerInfo(uint uInfoType, char* pBuffer, uint uBufferLen);

@DllImport("WDSPXE")
uint PxeGetServerInfoEx(uint uInfoType, char* pBuffer, uint uBufferLen, uint* puBufferUsed);

@DllImport("WDSMC")
HRESULT WdsTransportServerRegisterCallback(HANDLE hProvider, TRANSPORTPROVIDER_CALLBACK_ID CallbackId, 
                                           void* pfnCallback);

@DllImport("WDSMC")
HRESULT WdsTransportServerCompleteRead(HANDLE hProvider, uint ulBytesRead, void* pvUserData, HRESULT hReadResult);

@DllImport("WDSMC")
HRESULT WdsTransportServerTrace(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat);

@DllImport("WDSMC")
HRESULT WdsTransportServerTraceV(HANDLE hProvider, uint Severity, const(wchar)* pwszFormat, byte* Params);

@DllImport("WDSMC")
void* WdsTransportServerAllocateBuffer(HANDLE hProvider, uint ulBufferSize);

@DllImport("WDSMC")
HRESULT WdsTransportServerFreeBuffer(HANDLE hProvider, void* pvBuffer);

@DllImport("WDSTPTC")
uint WdsTransportClientInitialize();

@DllImport("WDSTPTC")
uint WdsTransportClientInitializeSession(WDS_TRANSPORTCLIENT_REQUEST* pSessionRequest, void* pCallerData, 
                                         ptrdiff_t* hSessionKey);

@DllImport("WDSTPTC")
uint WdsTransportClientRegisterCallback(HANDLE hSessionKey, TRANSPORTCLIENT_CALLBACK_ID CallbackId, 
                                        void* pfnCallback);

@DllImport("WDSTPTC")
uint WdsTransportClientStartSession(HANDLE hSessionKey);

@DllImport("WDSTPTC")
uint WdsTransportClientCompleteReceive(HANDLE hSessionKey, uint ulSize, ULARGE_INTEGER* pullOffset);

@DllImport("WDSTPTC")
uint WdsTransportClientCancelSession(HANDLE hSessionKey);

@DllImport("WDSTPTC")
uint WdsTransportClientCancelSessionEx(HANDLE hSessionKey, uint dwErrorCode);

@DllImport("WDSTPTC")
uint WdsTransportClientWaitForCompletion(HANDLE hSessionKey, uint uTimeout);

@DllImport("WDSTPTC")
uint WdsTransportClientQueryStatus(HANDLE hSessionKey, uint* puStatus, uint* puErrorCode);

@DllImport("WDSTPTC")
uint WdsTransportClientCloseSession(HANDLE hSessionKey);

@DllImport("WDSTPTC")
uint WdsTransportClientAddRefBuffer(void* pvBuffer);

@DllImport("WDSTPTC")
uint WdsTransportClientReleaseBuffer(void* pvBuffer);

@DllImport("WDSTPTC")
uint WdsTransportClientShutdown();

@DllImport("WDSBP")
uint WdsBpParseInitialize(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

@DllImport("WDSBP")
uint WdsBpParseInitializev6(char* pPacket, uint uPacketLen, ubyte* pbPacketType, HANDLE* phHandle);

@DllImport("WDSBP")
uint WdsBpInitialize(ubyte bPacketType, HANDLE* phHandle);

@DllImport("WDSBP")
uint WdsBpCloseHandle(HANDLE hHandle);

@DllImport("WDSBP")
uint WdsBpQueryOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue, uint* puBytes);

@DllImport("WDSBP")
uint WdsBpAddOption(HANDLE hHandle, uint uOption, uint uValueLen, char* pValue);

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

@GUID("46AD894B-0BAB-47DC-84B2-7B553F1D8F80")
interface IWdsTransportCacheable : IDispatch
{
    HRESULT get_Dirty(short* pbDirty);
    HRESULT Discard();
    HRESULT Refresh();
    HRESULT Commit();
}

@GUID("B8BA4B1A-2FF4-43AB-996C-B2B10A91A6EB")
interface IWdsTransportCollection : IDispatch
{
    HRESULT get_Count(uint* pulCount);
    HRESULT get_Item(uint ulIndex, IDispatch* ppVal);
    HRESULT get__NewEnum(IUnknown* ppVal);
}

@GUID("5B0D35F5-1B13-4AFD-B878-6526DC340B5D")
interface IWdsTransportManager : IDispatch
{
    HRESULT GetWdsTransportServer(BSTR bszServerName, IWdsTransportServer* ppWdsTransportServer);
}

@GUID("09CCD093-830D-4344-A30A-73AE8E8FCA90")
interface IWdsTransportServer : IDispatch
{
    HRESULT get_Name(BSTR* pbszName);
    HRESULT get_SetupManager(IWdsTransportSetupManager* ppWdsTransportSetupManager);
    HRESULT get_ConfigurationManager(IWdsTransportConfigurationManager* ppWdsTransportConfigurationManager);
    HRESULT get_NamespaceManager(IWdsTransportNamespaceManager* ppWdsTransportNamespaceManager);
    HRESULT DisconnectClient(uint ulClientId, WDSTRANSPORT_DISCONNECT_TYPE DisconnectionType);
}

@GUID("256E999F-6DF4-4538-81B9-857B9AB8FB47")
interface IWdsTransportServer2 : IWdsTransportServer
{
    HRESULT get_TftpManager(IWdsTransportTftpManager* ppWdsTransportTftpManager);
}

@GUID("F7238425-EFA8-40A4-AEF9-C98D969C0B75")
interface IWdsTransportSetupManager : IDispatch
{
    HRESULT get_Version(ulong* pullVersion);
    HRESULT get_InstalledFeatures(uint* pulInstalledFeatures);
    HRESULT get_Protocols(uint* pulProtocols);
    HRESULT RegisterContentProvider(BSTR bszName, BSTR bszDescription, BSTR bszFilePath, 
                                    BSTR bszInitializationRoutine);
    HRESULT DeregisterContentProvider(BSTR bszName);
}

@GUID("02BE79DA-7E9E-4366-8B6E-2AA9A91BE47F")
interface IWdsTransportSetupManager2 : IWdsTransportSetupManager
{
    HRESULT get_TftpCapabilities(uint* pulTftpCapabilities);
    HRESULT get_ContentProviders(IWdsTransportCollection* ppProviderCollection);
}

@GUID("84CC4779-42DD-4792-891E-1321D6D74B44")
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

@GUID("D0D85CAF-A153-4F1D-A9DD-96F431C50717")
interface IWdsTransportConfigurationManager2 : IWdsTransportConfigurationManager
{
    HRESULT get_MulticastSessionPolicy(IWdsTransportMulticastSessionPolicy* ppWdsTransportMulticastSessionPolicy);
}

@GUID("3E22D9F6-3777-4D98-83E1-F98696717BA3")
interface IWdsTransportNamespaceManager : IDispatch
{
    HRESULT CreateNamespace(WDSTRANSPORT_NAMESPACE_TYPE NamespaceType, BSTR bszNamespaceName, 
                            BSTR bszContentProvider, BSTR bszConfiguration, 
                            IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT RetrieveNamespace(BSTR bszNamespaceName, IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT RetrieveNamespaces(BSTR bszContentProvider, BSTR bszNamespaceName, short bIncludeTombstones, 
                               IWdsTransportCollection* ppWdsTransportNamespaces);
}

@GUID("1327A7C8-AE8A-4FB3-8150-136227C37E9A")
interface IWdsTransportTftpManager : IDispatch
{
    HRESULT RetrieveTftpClients(IWdsTransportCollection* ppWdsTransportTftpClients);
}

@GUID("B9468578-9F2B-48CC-B27A-A60799C2750C")
interface IWdsTransportServicePolicy : IWdsTransportCacheable
{
    HRESULT get_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE* pSourceType);
    HRESULT put_IpAddressSource(WDSTRANSPORT_IP_ADDRESS_TYPE AddressType, 
                                WDSTRANSPORT_IP_ADDRESS_SOURCE_TYPE SourceType);
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

@GUID("65C19E5C-AA7E-4B91-8944-91E0E5572797")
interface IWdsTransportServicePolicy2 : IWdsTransportServicePolicy
{
    HRESULT get_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY* pUdpPortPolicy);
    HRESULT put_UdpPortPolicy(WDSTRANSPORT_UDP_PORT_POLICY UdpPortPolicy);
    HRESULT get_TftpMaximumBlockSize(uint* pulTftpMaximumBlockSize);
    HRESULT put_TftpMaximumBlockSize(uint ulTftpMaximumBlockSize);
    HRESULT get_EnableTftpVariableWindowExtension(short* pbEnableTftpVariableWindowExtension);
    HRESULT put_EnableTftpVariableWindowExtension(short bEnableTftpVariableWindowExtension);
}

@GUID("13B33EFC-7856-4F61-9A59-8DE67B6B87B6")
interface IWdsTransportDiagnosticsPolicy : IWdsTransportCacheable
{
    HRESULT get_Enabled(short* pbEnabled);
    HRESULT put_Enabled(short bEnabled);
    HRESULT get_Components(uint* pulComponents);
    HRESULT put_Components(uint ulComponents);
}

@GUID("4E5753CF-68EC-4504-A951-4A003266606B")
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

@GUID("FA561F57-FBEF-4ED3-B056-127CB1B33B84")
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

@GUID("AD931A72-C4BD-4C41-8FBC-59C9C748DF9E")
interface IWdsTransportNamespaceAutoCast : IWdsTransportNamespace
{
}

@GUID("3840CECF-D76C-416E-A4CC-31C741D2874B")
interface IWdsTransportNamespaceScheduledCast : IWdsTransportNamespace
{
    HRESULT StartTransmission();
}

@GUID("013E6E4C-E6A7-4FB5-B7FF-D9F5DA805C31")
interface IWdsTransportNamespaceScheduledCastManualStart : IWdsTransportNamespaceScheduledCast
{
}

@GUID("D606AF3D-EA9C-4219-961E-7491D618D9B9")
interface IWdsTransportNamespaceScheduledCastAutoStart : IWdsTransportNamespaceScheduledCast
{
    HRESULT get_MinimumClients(uint* pulMinimumClients);
    HRESULT put_MinimumClients(uint ulMinimumClients);
    HRESULT get_StartTime(double* pStartTime);
    HRESULT put_StartTime(double StartTime);
}

@GUID("D405D711-0296-4AB4-A860-AC7D32E65798")
interface IWdsTransportContent : IDispatch
{
    HRESULT get_Namespace(IWdsTransportNamespace* ppWdsTransportNamespace);
    HRESULT get_Id(uint* pulId);
    HRESULT get_Name(BSTR* pbszName);
    HRESULT RetrieveSessions(IWdsTransportCollection* ppWdsTransportSessions);
    HRESULT Terminate();
}

@GUID("F4EFEA88-65B1-4F30-A4B9-2793987796FB")
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

@GUID("B5DBC93A-CABE-46CA-837F-3E44E93C6545")
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

@GUID("B022D3AE-884D-4D85-B146-53320E76EF62")
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

@GUID("B9489F24-F219-4ACF-AAD7-265C7C08A6AE")
interface IWdsTransportContentProvider : IDispatch
{
    HRESULT get_Name(BSTR* pbszName);
    HRESULT get_Description(BSTR* pbszDescription);
    HRESULT get_FilePath(BSTR* pbszFilePath);
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
