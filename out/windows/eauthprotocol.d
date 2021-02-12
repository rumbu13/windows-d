module windows.eauthprotocol;

public import system;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.xmlhttpextendedrequest;

extern(Windows):

enum RAS_AUTH_ATTRIBUTE_TYPE
{
    raatMinimum = 0,
    raatUserName = 1,
    raatUserPassword = 2,
    raatMD5CHAPPassword = 3,
    raatNASIPAddress = 4,
    raatNASPort = 5,
    raatServiceType = 6,
    raatFramedProtocol = 7,
    raatFramedIPAddress = 8,
    raatFramedIPNetmask = 9,
    raatFramedRouting = 10,
    raatFilterId = 11,
    raatFramedMTU = 12,
    raatFramedCompression = 13,
    raatLoginIPHost = 14,
    raatLoginService = 15,
    raatLoginTCPPort = 16,
    raatUnassigned17 = 17,
    raatReplyMessage = 18,
    raatCallbackNumber = 19,
    raatCallbackId = 20,
    raatUnassigned21 = 21,
    raatFramedRoute = 22,
    raatFramedIPXNetwork = 23,
    raatState = 24,
    raatClass = 25,
    raatVendorSpecific = 26,
    raatSessionTimeout = 27,
    raatIdleTimeout = 28,
    raatTerminationAction = 29,
    raatCalledStationId = 30,
    raatCallingStationId = 31,
    raatNASIdentifier = 32,
    raatProxyState = 33,
    raatLoginLATService = 34,
    raatLoginLATNode = 35,
    raatLoginLATGroup = 36,
    raatFramedAppleTalkLink = 37,
    raatFramedAppleTalkNetwork = 38,
    raatFramedAppleTalkZone = 39,
    raatAcctStatusType = 40,
    raatAcctDelayTime = 41,
    raatAcctInputOctets = 42,
    raatAcctOutputOctets = 43,
    raatAcctSessionId = 44,
    raatAcctAuthentic = 45,
    raatAcctSessionTime = 46,
    raatAcctInputPackets = 47,
    raatAcctOutputPackets = 48,
    raatAcctTerminateCause = 49,
    raatAcctMultiSessionId = 50,
    raatAcctLinkCount = 51,
    raatAcctEventTimeStamp = 55,
    raatMD5CHAPChallenge = 60,
    raatNASPortType = 61,
    raatPortLimit = 62,
    raatLoginLATPort = 63,
    raatTunnelType = 64,
    raatTunnelMediumType = 65,
    raatTunnelClientEndpoint = 66,
    raatTunnelServerEndpoint = 67,
    raatARAPPassword = 70,
    raatARAPFeatures = 71,
    raatARAPZoneAccess = 72,
    raatARAPSecurity = 73,
    raatARAPSecurityData = 74,
    raatPasswordRetry = 75,
    raatPrompt = 76,
    raatConnectInfo = 77,
    raatConfigurationToken = 78,
    raatEAPMessage = 79,
    raatSignature = 80,
    raatARAPChallengeResponse = 84,
    raatAcctInterimInterval = 85,
    raatNASIPv6Address = 95,
    raatFramedInterfaceId = 96,
    raatFramedIPv6Prefix = 97,
    raatLoginIPv6Host = 98,
    raatFramedIPv6Route = 99,
    raatFramedIPv6Pool = 100,
    raatARAPGuestLogon = 8096,
    raatCertificateOID = 8097,
    raatEAPConfiguration = 8098,
    raatPEAPEmbeddedEAPTypeId = 8099,
    raatInnerEAPTypeId = 8099,
    raatPEAPFastRoamedSession = 8100,
    raatFastRoamedSession = 8100,
    raatEAPTLV = 8102,
    raatCredentialsChanged = 8103,
    raatCertificateThumbprint = 8250,
    raatPeerId = 9000,
    raatServerId = 9001,
    raatMethodId = 9002,
    raatEMSK = 9003,
    raatSessionId = 9004,
    raatReserved = -1,
}

struct NgcTicketContext
{
    ushort wszTicket;
    uint hKey;
    HANDLE hImpersonateToken;
}

struct RAS_AUTH_ATTRIBUTE
{
    RAS_AUTH_ATTRIBUTE_TYPE raaType;
    uint dwLength;
    void* Value;
}

struct PPP_EAP_PACKET
{
    ubyte Code;
    ubyte Id;
    ubyte Length;
    ubyte Data;
}

struct PPP_EAP_INPUT
{
    uint dwSizeInBytes;
    uint fFlags;
    BOOL fAuthenticator;
    ushort* pwszIdentity;
    ushort* pwszPassword;
    ubyte bInitialId;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL fAuthenticationComplete;
    uint dwAuthResultCode;
    HANDLE hTokenImpersonateUser;
    BOOL fSuccessPacketReceived;
    BOOL fDataReceivedFromInteractiveUI;
    ubyte* pDataFromInteractiveUI;
    uint dwSizeOfDataFromInteractiveUI;
    ubyte* pConnectionData;
    uint dwSizeOfConnectionData;
    ubyte* pUserData;
    uint dwSizeOfUserData;
    HANDLE hReserved;
    Guid guidConnectionId;
    BOOL isVpn;
}

enum PPP_EAP_ACTION
{
    EAPACTION_NoAction = 0,
    EAPACTION_Authenticate = 1,
    EAPACTION_Done = 2,
    EAPACTION_SendAndDone = 3,
    EAPACTION_Send = 4,
    EAPACTION_SendWithTimeout = 5,
    EAPACTION_SendWithTimeoutInteractive = 6,
    EAPACTION_IndicateTLV = 7,
    EAPACTION_IndicateIdentity = 8,
}

struct PPP_EAP_OUTPUT
{
    uint dwSizeInBytes;
    PPP_EAP_ACTION Action;
    uint dwAuthResultCode;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL fInvokeInteractiveUI;
    ubyte* pUIContextData;
    uint dwSizeOfUIContextData;
    BOOL fSaveConnectionData;
    ubyte* pConnectionData;
    uint dwSizeOfConnectionData;
    BOOL fSaveUserData;
    ubyte* pUserData;
    uint dwSizeOfUserData;
    NgcTicketContext* pNgcKerbTicket;
    BOOL fSaveToCredMan;
}

struct PPP_EAP_INFO
{
    uint dwSizeInBytes;
    uint dwEapTypeId;
    int RasEapInitialize;
    int RasEapBegin;
    int RasEapEnd;
    int RasEapMakeMessage;
}

struct LEGACY_IDENTITY_UI_PARAMS
{
    uint eapType;
    uint dwFlags;
    uint dwSizeofConnectionData;
    ubyte* pConnectionData;
    uint dwSizeofUserData;
    ubyte* pUserData;
    uint dwSizeofUserDataOut;
    ubyte* pUserDataOut;
    const(wchar)* pwszIdentity;
    uint dwError;
}

struct LEGACY_INTERACTIVE_UI_PARAMS
{
    uint eapType;
    uint dwSizeofContextData;
    ubyte* pContextData;
    uint dwSizeofInteractiveUIData;
    ubyte* pInteractiveUIData;
    uint dwError;
}

const GUID IID_IRouterProtocolConfig = {0x66A2DB16, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]};
@GUID(0x66A2DB16, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]);
interface IRouterProtocolConfig : IUnknown
{
    HRESULT AddProtocol(ushort* pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, uint dwFlags, IUnknown pRouter, uint uReserved1);
    HRESULT RemoveProtocol(ushort* pszMachineName, uint dwTransportId, uint dwProtocolId, HWND hWnd, uint dwFlags, IUnknown pRouter, uint uReserved1);
}

const GUID IID_IAuthenticationProviderConfig = {0x66A2DB17, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]};
@GUID(0x66A2DB17, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]);
interface IAuthenticationProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, uint* puConnectionParam);
    HRESULT Uninitialize(uint uConnectionParam);
    HRESULT Configure(uint uConnectionParam, HWND hWnd, uint dwFlags, uint uReserved1, uint uReserved2);
    HRESULT Activate(uint uConnectionParam, uint uReserved1, uint uReserved2);
    HRESULT Deactivate(uint uConnectionParam, uint uReserved1, uint uReserved2);
}

const GUID IID_IAccountingProviderConfig = {0x66A2DB18, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]};
@GUID(0x66A2DB18, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]);
interface IAccountingProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, uint* puConnectionParam);
    HRESULT Uninitialize(uint uConnectionParam);
    HRESULT Configure(uint uConnectionParam, HWND hWnd, uint dwFlags, uint uReserved1, uint uReserved2);
    HRESULT Activate(uint uConnectionParam, uint uReserved1, uint uReserved2);
    HRESULT Deactivate(uint uConnectionParam, uint uReserved1, uint uReserved2);
}

const GUID IID_IEAPProviderConfig = {0x66A2DB19, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]};
@GUID(0x66A2DB19, 0xD706, 0x11D0, [0xA3, 0x7B, 0x00, 0xC0, 0x4F, 0xC9, 0xDA, 0x04]);
interface IEAPProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, uint dwEapTypeId, uint* puConnectionParam);
    HRESULT Uninitialize(uint dwEapTypeId, uint uConnectionParam);
    HRESULT ServerInvokeConfigUI(uint dwEapTypeId, uint uConnectionParam, HWND hWnd, uint uReserved1, uint uReserved2);
    HRESULT RouterInvokeConfigUI(uint dwEapTypeId, uint uConnectionParam, HWND hwndParent, uint dwFlags, ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, ubyte** ppConnectionDataOut, uint* pdwSizeOfConnectionDataOut);
    HRESULT RouterInvokeCredentialsUI(uint dwEapTypeId, uint uConnectionParam, HWND hwndParent, uint dwFlags, ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, ubyte* pUserDataIn, uint dwSizeOfUserDataIn, ubyte** ppUserDataOut, uint* pdwSizeOfUserDataOut);
}

const GUID IID_IEAPProviderConfig2 = {0xD565917A, 0x85C4, 0x4466, [0x85, 0x6E, 0x67, 0x1C, 0x37, 0x42, 0xEA, 0x9A]};
@GUID(0xD565917A, 0x85C4, 0x4466, [0x85, 0x6E, 0x67, 0x1C, 0x37, 0x42, 0xEA, 0x9A]);
interface IEAPProviderConfig2 : IEAPProviderConfig
{
    HRESULT ServerInvokeConfigUI2(uint dwEapTypeId, uint uConnectionParam, HWND hWnd, const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut);
    HRESULT GetGlobalConfig(uint dwEapTypeId, ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut);
}

const GUID IID_IEAPProviderConfig3 = {0xB78ECD12, 0x68BB, 0x4F86, [0x9B, 0xF0, 0x84, 0x38, 0xDD, 0x3B, 0xE9, 0x82]};
@GUID(0xB78ECD12, 0x68BB, 0x4F86, [0x9B, 0xF0, 0x84, 0x38, 0xDD, 0x3B, 0xE9, 0x82]);
interface IEAPProviderConfig3 : IEAPProviderConfig2
{
    HRESULT ServerInvokeCertificateConfigUI(uint dwEapTypeId, uint uConnectionParam, HWND hWnd, const(ubyte)* pConfigDataIn, uint dwSizeOfConfigDataIn, ubyte** ppConfigDataOut, uint* pdwSizeOfConfigDataOut, uint uReserved);
}

@DllImport("eappcfg.dll")
uint EapHostPeerGetMethods(EAP_METHOD_INFO_ARRAY* pEapMethodInfoArray, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerGetMethodProperties(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, HANDLE hUserImpersonationToken, uint dwEapConnDataSize, char* pbEapConnData, uint dwUserDataSize, char* pbUserData, EAP_METHOD_PROPERTY_ARRAY* pMethodPropertyArray, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerInvokeConfigUI(HWND hwndParent, uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, char* pConfigIn, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerQueryCredentialInputFields(HANDLE hUserImpersonationToken, EAP_METHOD_TYPE eapMethodType, uint dwFlags, uint dwEapConnDataSize, char* pbEapConnData, EAP_CONFIG_INPUT_FIELD_ARRAY* pEapConfigInputFieldArray, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerQueryUserBlobFromCredentialInputFields(HANDLE hUserImpersonationToken, EAP_METHOD_TYPE eapMethodType, uint dwFlags, uint dwEapConnDataSize, char* pbEapConnData, const(EAP_CONFIG_INPUT_FIELD_ARRAY)* pEapConfigInputFieldArray, uint* pdwUserBlobSize, char* ppbUserBlob, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerInvokeIdentityUI(uint dwVersion, EAP_METHOD_TYPE eapMethodType, uint dwFlags, HWND hwndParent, uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, char* pUserData, uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, ushort** ppwszIdentity, EAP_ERROR** ppEapError, void** ppvReserved);

@DllImport("eappcfg.dll")
uint EapHostPeerInvokeInteractiveUI(HWND hwndParent, uint dwSizeofUIContextData, char* pUIContextData, uint* pdwSizeOfDataFromInteractiveUI, ubyte** ppDataFromInteractiveUI, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerQueryInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, char* pUIContextData, EAP_INTERACTIVE_UI_DATA* pEapInteractiveUIData, EAP_ERROR** ppEapError, void** ppvReserved);

@DllImport("eappcfg.dll")
uint EapHostPeerQueryUIBlobFromInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, char* pUIContextData, const(EAP_INTERACTIVE_UI_DATA)* pEapInteractiveUIData, uint* pdwSizeOfDataFromInteractiveUI, ubyte** ppDataFromInteractiveUI, EAP_ERROR** ppEapError, void** ppvReserved);

@DllImport("eappcfg.dll")
uint EapHostPeerConfigXml2Blob(uint dwFlags, IXMLDOMNode pConfigDoc, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerCredentialsXml2Blob(uint dwFlags, IXMLDOMNode pCredentialsDoc, uint dwSizeOfConfigIn, char* pConfigIn, uint* pdwSizeOfCredentialsOut, ubyte** ppCredentialsOut, EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
uint EapHostPeerConfigBlob2Xml(uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, char* pConfigIn, IXMLDOMDocument2* ppConfigDoc, EAP_ERROR** ppEapError);

@DllImport("eappcfg.dll")
void EapHostPeerFreeMemory(ubyte* pData);

@DllImport("eappcfg.dll")
void EapHostPeerFreeErrorMemory(EAP_ERROR* pEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerInitialize();

@DllImport("eappprxy.dll")
void EapHostPeerUninitialize();

@DllImport("eappprxy.dll")
uint EapHostPeerBeginSession(uint dwFlags, EAP_METHOD_TYPE eapType, const(EAP_ATTRIBUTES)* pAttributeArray, HANDLE hTokenImpersonateUser, uint dwSizeofConnectionData, const(ubyte)* pConnectionData, uint dwSizeofUserData, const(ubyte)* pUserData, uint dwMaxSendPacketSize, const(Guid)* pConnectionId, NotificationHandler func, void* pContextData, uint* pSessionId, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerProcessReceivedPacket(uint sessionHandle, uint cbReceivePacket, const(ubyte)* pReceivePacket, EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetSendPacket(uint sessionHandle, uint* pcbSendPacket, ubyte** ppSendPacket, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetResult(uint sessionHandle, EapHostPeerMethodResultReason reason, EapHostPeerMethodResult* ppResult, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetUIContext(uint sessionHandle, uint* pdwSizeOfUIContextData, ubyte** ppUIContextData, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerSetUIContext(uint sessionHandle, uint dwSizeOfUIContextData, const(ubyte)* pUIContextData, EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetResponseAttributes(uint sessionHandle, EAP_ATTRIBUTES* pAttribs, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerSetResponseAttributes(uint sessionHandle, const(EAP_ATTRIBUTES)* pAttribs, EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetAuthStatus(uint sessionHandle, EapHostPeerAuthParams authParam, uint* pcbAuthData, ubyte** ppAuthData, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerEndSession(uint sessionHandle, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetDataToUnplumbCredentials(Guid* pConnectionIdThatLastSavedCreds, int* phCredentialImpersonationToken, uint sessionHandle, EAP_ERROR** ppEapError, int* fSaveToCredMan);

@DllImport("eappprxy.dll")
uint EapHostPeerClearConnection(Guid* pConnectionId, EAP_ERROR** ppEapError);

@DllImport("eappprxy.dll")
void EapHostPeerFreeEapError(EAP_ERROR* pEapError);

@DllImport("eappprxy.dll")
uint EapHostPeerGetIdentity(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, char* pUserData, HANDLE hTokenImpersonateUser, int* pfInvokeUI, uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, ushort** ppwszIdentity, EAP_ERROR** ppEapError, ubyte** ppvReserved);

@DllImport("eappprxy.dll")
uint EapHostPeerGetEncryptedPassword(uint dwSizeofPassword, const(wchar)* szPassword, ushort** ppszEncPassword);

@DllImport("eappprxy.dll")
void EapHostPeerFreeRuntimeMemory(ubyte* pData);

struct EAP_TYPE
{
    ubyte type;
    uint dwVendorId;
    uint dwVendorType;
}

struct EAP_METHOD_TYPE
{
    EAP_TYPE eapType;
    uint dwAuthorId;
}

struct EAP_METHOD_INFO
{
    EAP_METHOD_TYPE eaptype;
    const(wchar)* pwszAuthorName;
    const(wchar)* pwszFriendlyName;
    uint eapProperties;
    EAP_METHOD_INFO* pInnerMethodInfo;
}

struct EAP_METHOD_INFO_EX
{
    EAP_METHOD_TYPE eaptype;
    const(wchar)* pwszAuthorName;
    const(wchar)* pwszFriendlyName;
    uint eapProperties;
    EAP_METHOD_INFO_ARRAY_EX* pInnerMethodInfoArray;
}

struct EAP_METHOD_INFO_ARRAY
{
    uint dwNumberOfMethods;
    EAP_METHOD_INFO* pEapMethods;
}

struct EAP_METHOD_INFO_ARRAY_EX
{
    uint dwNumberOfMethods;
    EAP_METHOD_INFO_EX* pEapMethods;
}

struct EAP_ERROR
{
    uint dwWinError;
    EAP_METHOD_TYPE type;
    uint dwReasonCode;
    Guid rootCauseGuid;
    Guid repairGuid;
    Guid helpLinkGuid;
    const(wchar)* pRootCauseString;
    const(wchar)* pRepairString;
}

enum EAP_ATTRIBUTE_TYPE
{
    eatMinimum = 0,
    eatUserName = 1,
    eatUserPassword = 2,
    eatMD5CHAPPassword = 3,
    eatNASIPAddress = 4,
    eatNASPort = 5,
    eatServiceType = 6,
    eatFramedProtocol = 7,
    eatFramedIPAddress = 8,
    eatFramedIPNetmask = 9,
    eatFramedRouting = 10,
    eatFilterId = 11,
    eatFramedMTU = 12,
    eatFramedCompression = 13,
    eatLoginIPHost = 14,
    eatLoginService = 15,
    eatLoginTCPPort = 16,
    eatUnassigned17 = 17,
    eatReplyMessage = 18,
    eatCallbackNumber = 19,
    eatCallbackId = 20,
    eatUnassigned21 = 21,
    eatFramedRoute = 22,
    eatFramedIPXNetwork = 23,
    eatState = 24,
    eatClass = 25,
    eatVendorSpecific = 26,
    eatSessionTimeout = 27,
    eatIdleTimeout = 28,
    eatTerminationAction = 29,
    eatCalledStationId = 30,
    eatCallingStationId = 31,
    eatNASIdentifier = 32,
    eatProxyState = 33,
    eatLoginLATService = 34,
    eatLoginLATNode = 35,
    eatLoginLATGroup = 36,
    eatFramedAppleTalkLink = 37,
    eatFramedAppleTalkNetwork = 38,
    eatFramedAppleTalkZone = 39,
    eatAcctStatusType = 40,
    eatAcctDelayTime = 41,
    eatAcctInputOctets = 42,
    eatAcctOutputOctets = 43,
    eatAcctSessionId = 44,
    eatAcctAuthentic = 45,
    eatAcctSessionTime = 46,
    eatAcctInputPackets = 47,
    eatAcctOutputPackets = 48,
    eatAcctTerminateCause = 49,
    eatAcctMultiSessionId = 50,
    eatAcctLinkCount = 51,
    eatAcctEventTimeStamp = 55,
    eatMD5CHAPChallenge = 60,
    eatNASPortType = 61,
    eatPortLimit = 62,
    eatLoginLATPort = 63,
    eatTunnelType = 64,
    eatTunnelMediumType = 65,
    eatTunnelClientEndpoint = 66,
    eatTunnelServerEndpoint = 67,
    eatARAPPassword = 70,
    eatARAPFeatures = 71,
    eatARAPZoneAccess = 72,
    eatARAPSecurity = 73,
    eatARAPSecurityData = 74,
    eatPasswordRetry = 75,
    eatPrompt = 76,
    eatConnectInfo = 77,
    eatConfigurationToken = 78,
    eatEAPMessage = 79,
    eatSignature = 80,
    eatARAPChallengeResponse = 84,
    eatAcctInterimInterval = 85,
    eatNASIPv6Address = 95,
    eatFramedInterfaceId = 96,
    eatFramedIPv6Prefix = 97,
    eatLoginIPv6Host = 98,
    eatFramedIPv6Route = 99,
    eatFramedIPv6Pool = 100,
    eatARAPGuestLogon = 8096,
    eatCertificateOID = 8097,
    eatEAPConfiguration = 8098,
    eatPEAPEmbeddedEAPTypeId = 8099,
    eatPEAPFastRoamedSession = 8100,
    eatFastRoamedSession = 8100,
    eatEAPTLV = 8102,
    eatCredentialsChanged = 8103,
    eatInnerEapMethodType = 8104,
    eatClearTextPassword = 8107,
    eatQuarantineSoH = 8150,
    eatCertificateThumbprint = 8250,
    eatPeerId = 9000,
    eatServerId = 9001,
    eatMethodId = 9002,
    eatEMSK = 9003,
    eatSessionId = 9004,
    eatReserved = -1,
}

struct EAP_ATTRIBUTE
{
    EAP_ATTRIBUTE_TYPE eaType;
    uint dwLength;
    ubyte* pValue;
}

struct EAP_ATTRIBUTES
{
    uint dwNumberOfAttributes;
    EAP_ATTRIBUTE* pAttribs;
}

enum EAP_CONFIG_INPUT_FIELD_TYPE
{
    EapConfigInputUsername = 0,
    EapConfigInputPassword = 1,
    EapConfigInputNetworkUsername = 2,
    EapConfigInputNetworkPassword = 3,
    EapConfigInputPin = 4,
    EapConfigInputPSK = 5,
    EapConfigInputEdit = 6,
    EapConfigSmartCardUsername = 7,
    EapConfigSmartCardError = 8,
}

struct EAP_CONFIG_INPUT_FIELD_DATA
{
    uint dwSize;
    EAP_CONFIG_INPUT_FIELD_TYPE Type;
    uint dwFlagProps;
    const(wchar)* pwszLabel;
    const(wchar)* pwszData;
    uint dwMinDataLength;
    uint dwMaxDataLength;
}

struct EAP_CONFIG_INPUT_FIELD_ARRAY
{
    uint dwVersion;
    uint dwNumberOfFields;
    EAP_CONFIG_INPUT_FIELD_DATA* pFields;
}

enum EAP_INTERACTIVE_UI_DATA_TYPE
{
    EapCredReq = 0,
    EapCredResp = 1,
    EapCredExpiryReq = 2,
    EapCredExpiryResp = 3,
    EapCredLogonReq = 4,
    EapCredLogonResp = 5,
}

struct EAP_CRED_EXPIRY_REQ
{
    EAP_CONFIG_INPUT_FIELD_ARRAY curCreds;
    EAP_CONFIG_INPUT_FIELD_ARRAY newCreds;
}

struct EAP_UI_DATA_FORMAT
{
    EAP_CONFIG_INPUT_FIELD_ARRAY* credData;
    EAP_CRED_EXPIRY_REQ* credExpiryData;
    EAP_CONFIG_INPUT_FIELD_ARRAY* credLogonData;
}

struct EAP_INTERACTIVE_UI_DATA
{
    uint dwVersion;
    uint dwSize;
    EAP_INTERACTIVE_UI_DATA_TYPE dwDataType;
    uint cbUiData;
    EAP_UI_DATA_FORMAT pbUiData;
}

enum EAP_METHOD_PROPERTY_TYPE
{
    emptPropCipherSuiteNegotiation = 0,
    emptPropMutualAuth = 1,
    emptPropIntegrity = 2,
    emptPropReplayProtection = 3,
    emptPropConfidentiality = 4,
    emptPropKeyDerivation = 5,
    emptPropKeyStrength64 = 6,
    emptPropKeyStrength128 = 7,
    emptPropKeyStrength256 = 8,
    emptPropKeyStrength512 = 9,
    emptPropKeyStrength1024 = 10,
    emptPropDictionaryAttackResistance = 11,
    emptPropFastReconnect = 12,
    emptPropCryptoBinding = 13,
    emptPropSessionIndependence = 14,
    emptPropFragmentation = 15,
    emptPropChannelBinding = 16,
    emptPropNap = 17,
    emptPropStandalone = 18,
    emptPropMppeEncryption = 19,
    emptPropTunnelMethod = 20,
    emptPropSupportsConfig = 21,
    emptPropCertifiedMethod = 22,
    emptPropHiddenMethod = 23,
    emptPropMachineAuth = 24,
    emptPropUserAuth = 25,
    emptPropIdentityPrivacy = 26,
    emptPropMethodChaining = 27,
    emptPropSharedStateEquivalence = 28,
    emptLegacyMethodPropertyFlag = 31,
    emptPropVendorSpecific = 255,
}

enum EAP_METHOD_PROPERTY_VALUE_TYPE
{
    empvtBool = 0,
    empvtDword = 1,
    empvtString = 2,
}

struct EAP_METHOD_PROPERTY_VALUE_BOOL
{
    uint length;
    BOOL value;
}

struct EAP_METHOD_PROPERTY_VALUE_DWORD
{
    uint length;
    uint value;
}

struct EAP_METHOD_PROPERTY_VALUE_STRING
{
    uint length;
    ubyte* value;
}

struct EAP_METHOD_PROPERTY_VALUE
{
    EAP_METHOD_PROPERTY_VALUE_BOOL empvBool;
    EAP_METHOD_PROPERTY_VALUE_DWORD empvDword;
    EAP_METHOD_PROPERTY_VALUE_STRING empvString;
}

struct EAP_METHOD_PROPERTY
{
    EAP_METHOD_PROPERTY_TYPE eapMethodPropertyType;
    EAP_METHOD_PROPERTY_VALUE_TYPE eapMethodPropertyValueType;
    EAP_METHOD_PROPERTY_VALUE eapMethodPropertyValue;
}

struct EAP_METHOD_PROPERTY_ARRAY
{
    uint dwNumberOfProperties;
    EAP_METHOD_PROPERTY* pMethodProperty;
}

struct EAPHOST_IDENTITY_UI_PARAMS
{
    EAP_METHOD_TYPE eapMethodType;
    uint dwFlags;
    uint dwSizeofConnectionData;
    ubyte* pConnectionData;
    uint dwSizeofUserData;
    ubyte* pUserData;
    uint dwSizeofUserDataOut;
    ubyte* pUserDataOut;
    const(wchar)* pwszIdentity;
    uint dwError;
    EAP_ERROR* pEapError;
}

struct EAPHOST_INTERACTIVE_UI_PARAMS
{
    uint dwSizeofContextData;
    ubyte* pContextData;
    uint dwSizeofInteractiveUIData;
    ubyte* pInteractiveUIData;
    uint dwError;
    EAP_ERROR* pEapError;
}

enum EapCredentialType
{
    EAP_EMPTY_CREDENTIAL = 0,
    EAP_USERNAME_PASSWORD_CREDENTIAL = 1,
    EAP_WINLOGON_CREDENTIAL = 2,
    EAP_CERTIFICATE_CREDENTIAL = 3,
    EAP_SIM_CREDENTIAL = 4,
}

struct EapUsernamePasswordCredential
{
    const(wchar)* username;
    const(wchar)* password;
}

struct EapCertificateCredential
{
    ubyte certHash;
    const(wchar)* password;
}

struct EapSimCredential
{
    const(wchar)* iccID;
}

struct EapCredentialTypeData
{
    EapUsernamePasswordCredential username_password;
    EapCertificateCredential certificate;
    EapSimCredential sim;
}

struct EapCredential
{
    EapCredentialType credType;
    EapCredentialTypeData credData;
}

enum EapHostPeerMethodResultReason
{
    EapHostPeerMethodResultAltSuccessReceived = 1,
    EapHostPeerMethodResultTimeout = 2,
    EapHostPeerMethodResultFromMethod = 3,
}

enum EapHostPeerResponseAction
{
    EapHostPeerResponseDiscard = 0,
    EapHostPeerResponseSend = 1,
    EapHostPeerResponseResult = 2,
    EapHostPeerResponseInvokeUi = 3,
    EapHostPeerResponseRespond = 4,
    EapHostPeerResponseStartAuthentication = 5,
    EapHostPeerResponseNone = 6,
}

enum EapHostPeerAuthParams
{
    EapHostPeerAuthStatus = 1,
    EapHostPeerIdentity = 2,
    EapHostPeerIdentityExtendedInfo = 3,
    EapHostNapInfo = 4,
}

enum EAPHOST_AUTH_STATUS
{
    EapHostInvalidSession = 0,
    EapHostAuthNotStarted = 1,
    EapHostAuthIdentityExchange = 2,
    EapHostAuthNegotiatingType = 3,
    EapHostAuthInProgress = 4,
    EapHostAuthSucceeded = 5,
    EapHostAuthFailed = 6,
}

struct EAPHOST_AUTH_INFO
{
    EAPHOST_AUTH_STATUS status;
    uint dwErrorCode;
    uint dwReasonCode;
}

enum ISOLATION_STATE
{
    ISOLATION_STATE_UNKNOWN = 0,
    ISOLATION_STATE_NOT_RESTRICTED = 1,
    ISOLATION_STATE_IN_PROBATION = 2,
    ISOLATION_STATE_RESTRICTED_ACCESS = 3,
}

struct EapHostPeerMethodResult
{
    BOOL fIsSuccess;
    uint dwFailureReasonCode;
    BOOL fSaveConnectionData;
    uint dwSizeofConnectionData;
    ubyte* pConnectionData;
    BOOL fSaveUserData;
    uint dwSizeofUserData;
    ubyte* pUserData;
    EAP_ATTRIBUTES* pAttribArray;
    ISOLATION_STATE isolationState;
    EAP_METHOD_INFO* pEapMethodInfo;
    EAP_ERROR* pEapError;
}

struct EapPacket
{
    ubyte Code;
    ubyte Id;
    ubyte Length;
    ubyte Data;
}

enum EapCode
{
    EapCodeMinimum = 1,
    EapCodeRequest = 1,
    EapCodeResponse = 2,
    EapCodeSuccess = 3,
    EapCodeFailure = 4,
    EapCodeMaximum = 4,
}

alias NotificationHandler = extern(Windows) void function(Guid connectionId, void* pContextData);
enum EAP_METHOD_AUTHENTICATOR_RESPONSE_ACTION
{
    EAP_METHOD_AUTHENTICATOR_RESPONSE_DISCARD = 0,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_SEND = 1,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESULT = 2,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESPOND = 3,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_AUTHENTICATE = 4,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_HANDLE_IDENTITY = 5,
}

struct EAP_METHOD_AUTHENTICATOR_RESULT
{
    BOOL fIsSuccess;
    uint dwFailureReason;
    EAP_ATTRIBUTES* pAuthAttribs;
}

enum EapPeerMethodResponseAction
{
    EapPeerMethodResponseActionDiscard = 0,
    EapPeerMethodResponseActionSend = 1,
    EapPeerMethodResponseActionResult = 2,
    EapPeerMethodResponseActionInvokeUI = 3,
    EapPeerMethodResponseActionRespond = 4,
    EapPeerMethodResponseActionNone = 5,
}

struct EapPeerMethodOutput
{
    EapPeerMethodResponseAction action;
    BOOL fAllowNotifications;
}

enum EapPeerMethodResultReason
{
    EapPeerMethodResultUnknown = 1,
    EapPeerMethodResultSuccess = 2,
    EapPeerMethodResultFailure = 3,
}

struct EapPeerMethodResult
{
    BOOL fIsSuccess;
    uint dwFailureReasonCode;
    BOOL fSaveConnectionData;
    uint dwSizeofConnectionData;
    ubyte* pConnectionData;
    BOOL fSaveUserData;
    uint dwSizeofUserData;
    ubyte* pUserData;
    EAP_ATTRIBUTES* pAttribArray;
    EAP_ERROR* pEapError;
    NgcTicketContext* pNgcKerbTicket;
    BOOL fSaveToCredMan;
}

struct EAP_PEER_METHOD_ROUTINES
{
    uint dwVersion;
    EAP_TYPE* pEapType;
    int EapPeerInitialize;
    int EapPeerGetIdentity;
    int EapPeerBeginSession;
    int EapPeerSetCredentials;
    int EapPeerProcessRequestPacket;
    int EapPeerGetResponsePacket;
    int EapPeerGetResult;
    int EapPeerGetUIContext;
    int EapPeerSetUIContext;
    int EapPeerGetResponseAttributes;
    int EapPeerSetResponseAttributes;
    int EapPeerEndSession;
    int EapPeerShutdown;
}

enum EAP_AUTHENTICATOR_SEND_TIMEOUT
{
    EAP_AUTHENTICATOR_SEND_TIMEOUT_NONE = 0,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_BASIC = 1,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_INTERACTIVE = 2,
}

struct EAP_AUTHENTICATOR_METHOD_ROUTINES
{
    uint dwSizeInBytes;
    EAP_METHOD_TYPE* pEapType;
    int EapMethodAuthenticatorInitialize;
    int EapMethodAuthenticatorBeginSession;
    int EapMethodAuthenticatorUpdateInnerMethodParams;
    int EapMethodAuthenticatorReceivePacket;
    int EapMethodAuthenticatorSendPacket;
    int EapMethodAuthenticatorGetAttributes;
    int EapMethodAuthenticatorSetAttributes;
    int EapMethodAuthenticatorGetResult;
    int EapMethodAuthenticatorEndSession;
    int EapMethodAuthenticatorShutdown;
}

