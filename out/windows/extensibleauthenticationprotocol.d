module windows.extensibleauthenticationprotocol;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : IXMLDOMNode;
public import windows.xmlhttpextendedrequest : IXMLDOMDocument2;

extern(Windows):


// Enums


enum : int
{
    raatMinimum                = 0x00000000,
    raatUserName               = 0x00000001,
    raatUserPassword           = 0x00000002,
    raatMD5CHAPPassword        = 0x00000003,
    raatNASIPAddress           = 0x00000004,
    raatNASPort                = 0x00000005,
    raatServiceType            = 0x00000006,
    raatFramedProtocol         = 0x00000007,
    raatFramedIPAddress        = 0x00000008,
    raatFramedIPNetmask        = 0x00000009,
    raatFramedRouting          = 0x0000000a,
    raatFilterId               = 0x0000000b,
    raatFramedMTU              = 0x0000000c,
    raatFramedCompression      = 0x0000000d,
    raatLoginIPHost            = 0x0000000e,
    raatLoginService           = 0x0000000f,
    raatLoginTCPPort           = 0x00000010,
    raatUnassigned17           = 0x00000011,
    raatReplyMessage           = 0x00000012,
    raatCallbackNumber         = 0x00000013,
    raatCallbackId             = 0x00000014,
    raatUnassigned21           = 0x00000015,
    raatFramedRoute            = 0x00000016,
    raatFramedIPXNetwork       = 0x00000017,
    raatState                  = 0x00000018,
    raatClass                  = 0x00000019,
    raatVendorSpecific         = 0x0000001a,
    raatSessionTimeout         = 0x0000001b,
    raatIdleTimeout            = 0x0000001c,
    raatTerminationAction      = 0x0000001d,
    raatCalledStationId        = 0x0000001e,
    raatCallingStationId       = 0x0000001f,
    raatNASIdentifier          = 0x00000020,
    raatProxyState             = 0x00000021,
    raatLoginLATService        = 0x00000022,
    raatLoginLATNode           = 0x00000023,
    raatLoginLATGroup          = 0x00000024,
    raatFramedAppleTalkLink    = 0x00000025,
    raatFramedAppleTalkNetwork = 0x00000026,
    raatFramedAppleTalkZone    = 0x00000027,
    raatAcctStatusType         = 0x00000028,
    raatAcctDelayTime          = 0x00000029,
    raatAcctInputOctets        = 0x0000002a,
    raatAcctOutputOctets       = 0x0000002b,
    raatAcctSessionId          = 0x0000002c,
    raatAcctAuthentic          = 0x0000002d,
    raatAcctSessionTime        = 0x0000002e,
    raatAcctInputPackets       = 0x0000002f,
    raatAcctOutputPackets      = 0x00000030,
    raatAcctTerminateCause     = 0x00000031,
    raatAcctMultiSessionId     = 0x00000032,
    raatAcctLinkCount          = 0x00000033,
    raatAcctEventTimeStamp     = 0x00000037,
    raatMD5CHAPChallenge       = 0x0000003c,
    raatNASPortType            = 0x0000003d,
    raatPortLimit              = 0x0000003e,
    raatLoginLATPort           = 0x0000003f,
    raatTunnelType             = 0x00000040,
    raatTunnelMediumType       = 0x00000041,
    raatTunnelClientEndpoint   = 0x00000042,
    raatTunnelServerEndpoint   = 0x00000043,
    raatARAPPassword           = 0x00000046,
    raatARAPFeatures           = 0x00000047,
    raatARAPZoneAccess         = 0x00000048,
    raatARAPSecurity           = 0x00000049,
    raatARAPSecurityData       = 0x0000004a,
    raatPasswordRetry          = 0x0000004b,
    raatPrompt                 = 0x0000004c,
    raatConnectInfo            = 0x0000004d,
    raatConfigurationToken     = 0x0000004e,
    raatEAPMessage             = 0x0000004f,
    raatSignature              = 0x00000050,
    raatARAPChallengeResponse  = 0x00000054,
    raatAcctInterimInterval    = 0x00000055,
    raatNASIPv6Address         = 0x0000005f,
    raatFramedInterfaceId      = 0x00000060,
    raatFramedIPv6Prefix       = 0x00000061,
    raatLoginIPv6Host          = 0x00000062,
    raatFramedIPv6Route        = 0x00000063,
    raatFramedIPv6Pool         = 0x00000064,
    raatARAPGuestLogon         = 0x00001fa0,
    raatCertificateOID         = 0x00001fa1,
    raatEAPConfiguration       = 0x00001fa2,
    raatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    raatInnerEAPTypeId         = 0x00001fa3,
    raatPEAPFastRoamedSession  = 0x00001fa4,
    raatFastRoamedSession      = 0x00001fa4,
    raatEAPTLV                 = 0x00001fa6,
    raatCredentialsChanged     = 0x00001fa7,
    raatCertificateThumbprint  = 0x0000203a,
    raatPeerId                 = 0x00002328,
    raatServerId               = 0x00002329,
    raatMethodId               = 0x0000232a,
    raatEMSK                   = 0x0000232b,
    raatSessionId              = 0x0000232c,
    raatReserved               = 0xffffffff,
}
alias RAS_AUTH_ATTRIBUTE_TYPE = int;

enum : int
{
    EAPACTION_NoAction                   = 0x00000000,
    EAPACTION_Authenticate               = 0x00000001,
    EAPACTION_Done                       = 0x00000002,
    EAPACTION_SendAndDone                = 0x00000003,
    EAPACTION_Send                       = 0x00000004,
    EAPACTION_SendWithTimeout            = 0x00000005,
    EAPACTION_SendWithTimeoutInteractive = 0x00000006,
    EAPACTION_IndicateTLV                = 0x00000007,
    EAPACTION_IndicateIdentity           = 0x00000008,
}
alias PPP_EAP_ACTION = int;

enum : int
{
    eatMinimum                = 0x00000000,
    eatUserName               = 0x00000001,
    eatUserPassword           = 0x00000002,
    eatMD5CHAPPassword        = 0x00000003,
    eatNASIPAddress           = 0x00000004,
    eatNASPort                = 0x00000005,
    eatServiceType            = 0x00000006,
    eatFramedProtocol         = 0x00000007,
    eatFramedIPAddress        = 0x00000008,
    eatFramedIPNetmask        = 0x00000009,
    eatFramedRouting          = 0x0000000a,
    eatFilterId               = 0x0000000b,
    eatFramedMTU              = 0x0000000c,
    eatFramedCompression      = 0x0000000d,
    eatLoginIPHost            = 0x0000000e,
    eatLoginService           = 0x0000000f,
    eatLoginTCPPort           = 0x00000010,
    eatUnassigned17           = 0x00000011,
    eatReplyMessage           = 0x00000012,
    eatCallbackNumber         = 0x00000013,
    eatCallbackId             = 0x00000014,
    eatUnassigned21           = 0x00000015,
    eatFramedRoute            = 0x00000016,
    eatFramedIPXNetwork       = 0x00000017,
    eatState                  = 0x00000018,
    eatClass                  = 0x00000019,
    eatVendorSpecific         = 0x0000001a,
    eatSessionTimeout         = 0x0000001b,
    eatIdleTimeout            = 0x0000001c,
    eatTerminationAction      = 0x0000001d,
    eatCalledStationId        = 0x0000001e,
    eatCallingStationId       = 0x0000001f,
    eatNASIdentifier          = 0x00000020,
    eatProxyState             = 0x00000021,
    eatLoginLATService        = 0x00000022,
    eatLoginLATNode           = 0x00000023,
    eatLoginLATGroup          = 0x00000024,
    eatFramedAppleTalkLink    = 0x00000025,
    eatFramedAppleTalkNetwork = 0x00000026,
    eatFramedAppleTalkZone    = 0x00000027,
    eatAcctStatusType         = 0x00000028,
    eatAcctDelayTime          = 0x00000029,
    eatAcctInputOctets        = 0x0000002a,
    eatAcctOutputOctets       = 0x0000002b,
    eatAcctSessionId          = 0x0000002c,
    eatAcctAuthentic          = 0x0000002d,
    eatAcctSessionTime        = 0x0000002e,
    eatAcctInputPackets       = 0x0000002f,
    eatAcctOutputPackets      = 0x00000030,
    eatAcctTerminateCause     = 0x00000031,
    eatAcctMultiSessionId     = 0x00000032,
    eatAcctLinkCount          = 0x00000033,
    eatAcctEventTimeStamp     = 0x00000037,
    eatMD5CHAPChallenge       = 0x0000003c,
    eatNASPortType            = 0x0000003d,
    eatPortLimit              = 0x0000003e,
    eatLoginLATPort           = 0x0000003f,
    eatTunnelType             = 0x00000040,
    eatTunnelMediumType       = 0x00000041,
    eatTunnelClientEndpoint   = 0x00000042,
    eatTunnelServerEndpoint   = 0x00000043,
    eatARAPPassword           = 0x00000046,
    eatARAPFeatures           = 0x00000047,
    eatARAPZoneAccess         = 0x00000048,
    eatARAPSecurity           = 0x00000049,
    eatARAPSecurityData       = 0x0000004a,
    eatPasswordRetry          = 0x0000004b,
    eatPrompt                 = 0x0000004c,
    eatConnectInfo            = 0x0000004d,
    eatConfigurationToken     = 0x0000004e,
    eatEAPMessage             = 0x0000004f,
    eatSignature              = 0x00000050,
    eatARAPChallengeResponse  = 0x00000054,
    eatAcctInterimInterval    = 0x00000055,
    eatNASIPv6Address         = 0x0000005f,
    eatFramedInterfaceId      = 0x00000060,
    eatFramedIPv6Prefix       = 0x00000061,
    eatLoginIPv6Host          = 0x00000062,
    eatFramedIPv6Route        = 0x00000063,
    eatFramedIPv6Pool         = 0x00000064,
    eatARAPGuestLogon         = 0x00001fa0,
    eatCertificateOID         = 0x00001fa1,
    eatEAPConfiguration       = 0x00001fa2,
    eatPEAPEmbeddedEAPTypeId  = 0x00001fa3,
    eatPEAPFastRoamedSession  = 0x00001fa4,
    eatFastRoamedSession      = 0x00001fa4,
    eatEAPTLV                 = 0x00001fa6,
    eatCredentialsChanged     = 0x00001fa7,
    eatInnerEapMethodType     = 0x00001fa8,
    eatClearTextPassword      = 0x00001fab,
    eatQuarantineSoH          = 0x00001fd6,
    eatCertificateThumbprint  = 0x0000203a,
    eatPeerId                 = 0x00002328,
    eatServerId               = 0x00002329,
    eatMethodId               = 0x0000232a,
    eatEMSK                   = 0x0000232b,
    eatSessionId              = 0x0000232c,
    eatReserved               = 0xffffffff,
}
alias EAP_ATTRIBUTE_TYPE = int;

enum : int
{
    EapConfigInputUsername        = 0x00000000,
    EapConfigInputPassword        = 0x00000001,
    EapConfigInputNetworkUsername = 0x00000002,
    EapConfigInputNetworkPassword = 0x00000003,
    EapConfigInputPin             = 0x00000004,
    EapConfigInputPSK             = 0x00000005,
    EapConfigInputEdit            = 0x00000006,
    EapConfigSmartCardUsername    = 0x00000007,
    EapConfigSmartCardError       = 0x00000008,
}
alias EAP_CONFIG_INPUT_FIELD_TYPE = int;

enum : int
{
    EapCredReq        = 0x00000000,
    EapCredResp       = 0x00000001,
    EapCredExpiryReq  = 0x00000002,
    EapCredExpiryResp = 0x00000003,
    EapCredLogonReq   = 0x00000004,
    EapCredLogonResp  = 0x00000005,
}
alias EAP_INTERACTIVE_UI_DATA_TYPE = int;

enum : int
{
    emptPropCipherSuiteNegotiation     = 0x00000000,
    emptPropMutualAuth                 = 0x00000001,
    emptPropIntegrity                  = 0x00000002,
    emptPropReplayProtection           = 0x00000003,
    emptPropConfidentiality            = 0x00000004,
    emptPropKeyDerivation              = 0x00000005,
    emptPropKeyStrength64              = 0x00000006,
    emptPropKeyStrength128             = 0x00000007,
    emptPropKeyStrength256             = 0x00000008,
    emptPropKeyStrength512             = 0x00000009,
    emptPropKeyStrength1024            = 0x0000000a,
    emptPropDictionaryAttackResistance = 0x0000000b,
    emptPropFastReconnect              = 0x0000000c,
    emptPropCryptoBinding              = 0x0000000d,
    emptPropSessionIndependence        = 0x0000000e,
    emptPropFragmentation              = 0x0000000f,
    emptPropChannelBinding             = 0x00000010,
    emptPropNap                        = 0x00000011,
    emptPropStandalone                 = 0x00000012,
    emptPropMppeEncryption             = 0x00000013,
    emptPropTunnelMethod               = 0x00000014,
    emptPropSupportsConfig             = 0x00000015,
    emptPropCertifiedMethod            = 0x00000016,
    emptPropHiddenMethod               = 0x00000017,
    emptPropMachineAuth                = 0x00000018,
    emptPropUserAuth                   = 0x00000019,
    emptPropIdentityPrivacy            = 0x0000001a,
    emptPropMethodChaining             = 0x0000001b,
    emptPropSharedStateEquivalence     = 0x0000001c,
    emptLegacyMethodPropertyFlag       = 0x0000001f,
    emptPropVendorSpecific             = 0x000000ff,
}
alias EAP_METHOD_PROPERTY_TYPE = int;

enum : int
{
    empvtBool   = 0x00000000,
    empvtDword  = 0x00000001,
    empvtString = 0x00000002,
}
alias EAP_METHOD_PROPERTY_VALUE_TYPE = int;

enum EapCredentialType : int
{
    EAP_EMPTY_CREDENTIAL             = 0x00000000,
    EAP_USERNAME_PASSWORD_CREDENTIAL = 0x00000001,
    EAP_WINLOGON_CREDENTIAL          = 0x00000002,
    EAP_CERTIFICATE_CREDENTIAL       = 0x00000003,
    EAP_SIM_CREDENTIAL               = 0x00000004,
}

enum EapHostPeerMethodResultReason : int
{
    EapHostPeerMethodResultAltSuccessReceived = 0x00000001,
    EapHostPeerMethodResultTimeout            = 0x00000002,
    EapHostPeerMethodResultFromMethod         = 0x00000003,
}

enum EapHostPeerResponseAction : int
{
    EapHostPeerResponseDiscard             = 0x00000000,
    EapHostPeerResponseSend                = 0x00000001,
    EapHostPeerResponseResult              = 0x00000002,
    EapHostPeerResponseInvokeUi            = 0x00000003,
    EapHostPeerResponseRespond             = 0x00000004,
    EapHostPeerResponseStartAuthentication = 0x00000005,
    EapHostPeerResponseNone                = 0x00000006,
}

enum EapHostPeerAuthParams : int
{
    EapHostPeerAuthStatus           = 0x00000001,
    EapHostPeerIdentity             = 0x00000002,
    EapHostPeerIdentityExtendedInfo = 0x00000003,
    EapHostNapInfo                  = 0x00000004,
}

enum : int
{
    EapHostInvalidSession       = 0x00000000,
    EapHostAuthNotStarted       = 0x00000001,
    EapHostAuthIdentityExchange = 0x00000002,
    EapHostAuthNegotiatingType  = 0x00000003,
    EapHostAuthInProgress       = 0x00000004,
    EapHostAuthSucceeded        = 0x00000005,
    EapHostAuthFailed           = 0x00000006,
}
alias EAPHOST_AUTH_STATUS = int;

enum : int
{
    ISOLATION_STATE_UNKNOWN           = 0x00000000,
    ISOLATION_STATE_NOT_RESTRICTED    = 0x00000001,
    ISOLATION_STATE_IN_PROBATION      = 0x00000002,
    ISOLATION_STATE_RESTRICTED_ACCESS = 0x00000003,
}
alias ISOLATION_STATE = int;

enum EapCode : int
{
    EapCodeMinimum  = 0x00000001,
    EapCodeRequest  = 0x00000001,
    EapCodeResponse = 0x00000002,
    EapCodeSuccess  = 0x00000003,
    EapCodeFailure  = 0x00000004,
    EapCodeMaximum  = 0x00000004,
}

enum : int
{
    EAP_METHOD_AUTHENTICATOR_RESPONSE_DISCARD         = 0x00000000,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_SEND            = 0x00000001,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESULT          = 0x00000002,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_RESPOND         = 0x00000003,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_AUTHENTICATE    = 0x00000004,
    EAP_METHOD_AUTHENTICATOR_RESPONSE_HANDLE_IDENTITY = 0x00000005,
}
alias EAP_METHOD_AUTHENTICATOR_RESPONSE_ACTION = int;

enum EapPeerMethodResponseAction : int
{
    EapPeerMethodResponseActionDiscard  = 0x00000000,
    EapPeerMethodResponseActionSend     = 0x00000001,
    EapPeerMethodResponseActionResult   = 0x00000002,
    EapPeerMethodResponseActionInvokeUI = 0x00000003,
    EapPeerMethodResponseActionRespond  = 0x00000004,
    EapPeerMethodResponseActionNone     = 0x00000005,
}

enum EapPeerMethodResultReason : int
{
    EapPeerMethodResultUnknown = 0x00000001,
    EapPeerMethodResultSuccess = 0x00000002,
    EapPeerMethodResultFailure = 0x00000003,
}

enum : int
{
    EAP_AUTHENTICATOR_SEND_TIMEOUT_NONE        = 0x00000000,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_BASIC       = 0x00000001,
    EAP_AUTHENTICATOR_SEND_TIMEOUT_INTERACTIVE = 0x00000002,
}
alias EAP_AUTHENTICATOR_SEND_TIMEOUT = int;

// Callbacks

alias NotificationHandler = void function(GUID connectionId, void* pContextData);

// Structs


struct NgcTicketContext
{
    ushort[45] wszTicket;
    size_t     hKey;
    HANDLE     hImpersonateToken;
}

struct RAS_AUTH_ATTRIBUTE
{
    RAS_AUTH_ATTRIBUTE_TYPE raaType;
    uint  dwLength;
    void* Value;
}

struct PPP_EAP_PACKET
{
    ubyte    Code;
    ubyte    Id;
    ubyte[2] Length;
    ubyte[1] Data;
}

struct PPP_EAP_INPUT
{
    uint                dwSizeInBytes;
    uint                fFlags;
    BOOL                fAuthenticator;
    ushort*             pwszIdentity;
    ushort*             pwszPassword;
    ubyte               bInitialId;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL                fAuthenticationComplete;
    uint                dwAuthResultCode;
    HANDLE              hTokenImpersonateUser;
    BOOL                fSuccessPacketReceived;
    BOOL                fDataReceivedFromInteractiveUI;
    ubyte*              pDataFromInteractiveUI;
    uint                dwSizeOfDataFromInteractiveUI;
    ubyte*              pConnectionData;
    uint                dwSizeOfConnectionData;
    ubyte*              pUserData;
    uint                dwSizeOfUserData;
    HANDLE              hReserved;
    GUID                guidConnectionId;
    BOOL                isVpn;
}

struct PPP_EAP_OUTPUT
{
    uint                dwSizeInBytes;
    PPP_EAP_ACTION      Action;
    uint                dwAuthResultCode;
    RAS_AUTH_ATTRIBUTE* pUserAttributes;
    BOOL                fInvokeInteractiveUI;
    ubyte*              pUIContextData;
    uint                dwSizeOfUIContextData;
    BOOL                fSaveConnectionData;
    ubyte*              pConnectionData;
    uint                dwSizeOfConnectionData;
    BOOL                fSaveUserData;
    ubyte*              pUserData;
    uint                dwSizeOfUserData;
    NgcTicketContext*   pNgcKerbTicket;
    BOOL                fSaveToCredMan;
}

struct PPP_EAP_INFO
{
    uint      dwSizeInBytes;
    uint      dwEapTypeId;
    ptrdiff_t RasEapInitialize;
    ptrdiff_t RasEapBegin;
    ptrdiff_t RasEapEnd;
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

struct EAP_TYPE
{
    ubyte type;
    uint  dwVendorId;
    uint  dwVendorType;
}

struct EAP_METHOD_TYPE
{
    EAP_TYPE eapType;
    uint     dwAuthorId;
}

struct EAP_METHOD_INFO
{
    EAP_METHOD_TYPE  eaptype;
    const(wchar)*    pwszAuthorName;
    const(wchar)*    pwszFriendlyName;
    uint             eapProperties;
    EAP_METHOD_INFO* pInnerMethodInfo;
}

struct EAP_METHOD_INFO_EX
{
    EAP_METHOD_TYPE eaptype;
    const(wchar)*   pwszAuthorName;
    const(wchar)*   pwszFriendlyName;
    uint            eapProperties;
    EAP_METHOD_INFO_ARRAY_EX* pInnerMethodInfoArray;
}

struct EAP_METHOD_INFO_ARRAY
{
    uint             dwNumberOfMethods;
    EAP_METHOD_INFO* pEapMethods;
}

struct EAP_METHOD_INFO_ARRAY_EX
{
    uint                dwNumberOfMethods;
    EAP_METHOD_INFO_EX* pEapMethods;
}

struct EAP_ERROR
{
    uint            dwWinError;
    EAP_METHOD_TYPE type;
    uint            dwReasonCode;
    GUID            rootCauseGuid;
    GUID            repairGuid;
    GUID            helpLinkGuid;
    const(wchar)*   pRootCauseString;
    const(wchar)*   pRepairString;
}

struct EAP_ATTRIBUTE
{
    EAP_ATTRIBUTE_TYPE eaType;
    uint               dwLength;
    ubyte*             pValue;
}

struct EAP_ATTRIBUTES
{
    uint           dwNumberOfAttributes;
    EAP_ATTRIBUTE* pAttribs;
}

struct EAP_CONFIG_INPUT_FIELD_DATA
{
    uint          dwSize;
    EAP_CONFIG_INPUT_FIELD_TYPE Type;
    uint          dwFlagProps;
    const(wchar)* pwszLabel;
    const(wchar)* pwszData;
    uint          dwMinDataLength;
    uint          dwMaxDataLength;
}

struct EAP_CONFIG_INPUT_FIELD_ARRAY
{
    uint dwVersion;
    uint dwNumberOfFields;
    EAP_CONFIG_INPUT_FIELD_DATA* pFields;
}

struct EAP_CRED_EXPIRY_REQ
{
    EAP_CONFIG_INPUT_FIELD_ARRAY curCreds;
    EAP_CONFIG_INPUT_FIELD_ARRAY newCreds;
}

union EAP_UI_DATA_FORMAT
{
    EAP_CONFIG_INPUT_FIELD_ARRAY* credData;
    EAP_CRED_EXPIRY_REQ* credExpiryData;
    EAP_CONFIG_INPUT_FIELD_ARRAY* credLogonData;
}

struct EAP_INTERACTIVE_UI_DATA
{
    uint               dwVersion;
    uint               dwSize;
    EAP_INTERACTIVE_UI_DATA_TYPE dwDataType;
    uint               cbUiData;
    EAP_UI_DATA_FORMAT pbUiData;
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
    uint   length;
    ubyte* value;
}

union EAP_METHOD_PROPERTY_VALUE
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
    uint                 dwNumberOfProperties;
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

struct EapUsernamePasswordCredential
{
    const(wchar)* username;
    const(wchar)* password;
}

struct EapCertificateCredential
{
    ubyte[20]     certHash;
    const(wchar)* password;
}

struct EapSimCredential
{
    const(wchar)* iccID;
}

union EapCredentialTypeData
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

struct EAPHOST_AUTH_INFO
{
    EAPHOST_AUTH_STATUS status;
    uint                dwErrorCode;
    uint                dwReasonCode;
}

struct EapHostPeerMethodResult
{
    BOOL             fIsSuccess;
    uint             dwFailureReasonCode;
    BOOL             fSaveConnectionData;
    uint             dwSizeofConnectionData;
    ubyte*           pConnectionData;
    BOOL             fSaveUserData;
    uint             dwSizeofUserData;
    ubyte*           pUserData;
    EAP_ATTRIBUTES*  pAttribArray;
    ISOLATION_STATE  isolationState;
    EAP_METHOD_INFO* pEapMethodInfo;
    EAP_ERROR*       pEapError;
}

struct EapPacket
{
    ubyte    Code;
    ubyte    Id;
    ubyte[2] Length;
    ubyte[1] Data;
}

struct EAP_METHOD_AUTHENTICATOR_RESULT
{
    BOOL            fIsSuccess;
    uint            dwFailureReason;
    EAP_ATTRIBUTES* pAuthAttribs;
}

struct EapPeerMethodOutput
{
    EapPeerMethodResponseAction action;
    BOOL fAllowNotifications;
}

struct EapPeerMethodResult
{
    BOOL              fIsSuccess;
    uint              dwFailureReasonCode;
    BOOL              fSaveConnectionData;
    uint              dwSizeofConnectionData;
    ubyte*            pConnectionData;
    BOOL              fSaveUserData;
    uint              dwSizeofUserData;
    ubyte*            pUserData;
    EAP_ATTRIBUTES*   pAttribArray;
    EAP_ERROR*        pEapError;
    NgcTicketContext* pNgcKerbTicket;
    BOOL              fSaveToCredMan;
}

struct EAP_PEER_METHOD_ROUTINES
{
    uint      dwVersion;
    EAP_TYPE* pEapType;
    ptrdiff_t EapPeerInitialize;
    ptrdiff_t EapPeerGetIdentity;
    ptrdiff_t EapPeerBeginSession;
    ptrdiff_t EapPeerSetCredentials;
    ptrdiff_t EapPeerProcessRequestPacket;
    ptrdiff_t EapPeerGetResponsePacket;
    ptrdiff_t EapPeerGetResult;
    ptrdiff_t EapPeerGetUIContext;
    ptrdiff_t EapPeerSetUIContext;
    ptrdiff_t EapPeerGetResponseAttributes;
    ptrdiff_t EapPeerSetResponseAttributes;
    ptrdiff_t EapPeerEndSession;
    ptrdiff_t EapPeerShutdown;
}

struct EAP_AUTHENTICATOR_METHOD_ROUTINES
{
    uint             dwSizeInBytes;
    EAP_METHOD_TYPE* pEapType;
    ptrdiff_t        EapMethodAuthenticatorInitialize;
    ptrdiff_t        EapMethodAuthenticatorBeginSession;
    ptrdiff_t        EapMethodAuthenticatorUpdateInnerMethodParams;
    ptrdiff_t        EapMethodAuthenticatorReceivePacket;
    ptrdiff_t        EapMethodAuthenticatorSendPacket;
    ptrdiff_t        EapMethodAuthenticatorGetAttributes;
    ptrdiff_t        EapMethodAuthenticatorSetAttributes;
    ptrdiff_t        EapMethodAuthenticatorGetResult;
    ptrdiff_t        EapMethodAuthenticatorEndSession;
    ptrdiff_t        EapMethodAuthenticatorShutdown;
}

// Functions

@DllImport("eappcfg")
uint EapHostPeerGetMethods(EAP_METHOD_INFO_ARRAY* pEapMethodInfoArray, EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerGetMethodProperties(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                                    HANDLE hUserImpersonationToken, uint dwEapConnDataSize, char* pbEapConnData, 
                                    uint dwUserDataSize, char* pbUserData, 
                                    EAP_METHOD_PROPERTY_ARRAY* pMethodPropertyArray, EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerInvokeConfigUI(HWND hwndParent, uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, 
                               char* pConfigIn, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerQueryCredentialInputFields(HANDLE hUserImpersonationToken, EAP_METHOD_TYPE eapMethodType, 
                                           uint dwFlags, uint dwEapConnDataSize, char* pbEapConnData, 
                                           EAP_CONFIG_INPUT_FIELD_ARRAY* pEapConfigInputFieldArray, 
                                           EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerQueryUserBlobFromCredentialInputFields(HANDLE hUserImpersonationToken, 
                                                       EAP_METHOD_TYPE eapMethodType, uint dwFlags, 
                                                       uint dwEapConnDataSize, char* pbEapConnData, 
                                                       const(EAP_CONFIG_INPUT_FIELD_ARRAY)* pEapConfigInputFieldArray, 
                                                       uint* pdwUserBlobSize, char* ppbUserBlob, 
                                                       EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerInvokeIdentityUI(uint dwVersion, EAP_METHOD_TYPE eapMethodType, uint dwFlags, HWND hwndParent, 
                                 uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, 
                                 char* pUserData, uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, 
                                 ushort** ppwszIdentity, EAP_ERROR** ppEapError, void** ppvReserved);

@DllImport("eappcfg")
uint EapHostPeerInvokeInteractiveUI(HWND hwndParent, uint dwSizeofUIContextData, char* pUIContextData, 
                                    uint* pdwSizeOfDataFromInteractiveUI, ubyte** ppDataFromInteractiveUI, 
                                    EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerQueryInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                              char* pUIContextData, EAP_INTERACTIVE_UI_DATA* pEapInteractiveUIData, 
                                              EAP_ERROR** ppEapError, void** ppvReserved);

@DllImport("eappcfg")
uint EapHostPeerQueryUIBlobFromInteractiveUIInputFields(uint dwVersion, uint dwFlags, uint dwSizeofUIContextData, 
                                                        char* pUIContextData, 
                                                        const(EAP_INTERACTIVE_UI_DATA)* pEapInteractiveUIData, 
                                                        uint* pdwSizeOfDataFromInteractiveUI, 
                                                        ubyte** ppDataFromInteractiveUI, EAP_ERROR** ppEapError, 
                                                        void** ppvReserved);

@DllImport("eappcfg")
uint EapHostPeerConfigXml2Blob(uint dwFlags, IXMLDOMNode pConfigDoc, uint* pdwSizeOfConfigOut, ubyte** ppConfigOut, 
                               EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerCredentialsXml2Blob(uint dwFlags, IXMLDOMNode pCredentialsDoc, uint dwSizeOfConfigIn, 
                                    char* pConfigIn, uint* pdwSizeOfCredentialsOut, ubyte** ppCredentialsOut, 
                                    EAP_METHOD_TYPE* pEapMethodType, EAP_ERROR** ppEapError);

@DllImport("eappcfg")
uint EapHostPeerConfigBlob2Xml(uint dwFlags, EAP_METHOD_TYPE eapMethodType, uint dwSizeOfConfigIn, char* pConfigIn, 
                               IXMLDOMDocument2* ppConfigDoc, EAP_ERROR** ppEapError);

@DllImport("eappcfg")
void EapHostPeerFreeMemory(ubyte* pData);

@DllImport("eappcfg")
void EapHostPeerFreeErrorMemory(EAP_ERROR* pEapError);

@DllImport("eappprxy")
uint EapHostPeerInitialize();

@DllImport("eappprxy")
void EapHostPeerUninitialize();

@DllImport("eappprxy")
uint EapHostPeerBeginSession(uint dwFlags, EAP_METHOD_TYPE eapType, const(EAP_ATTRIBUTES)* pAttributeArray, 
                             HANDLE hTokenImpersonateUser, uint dwSizeofConnectionData, 
                             const(ubyte)* pConnectionData, uint dwSizeofUserData, const(ubyte)* pUserData, 
                             uint dwMaxSendPacketSize, const(GUID)* pConnectionId, NotificationHandler func, 
                             void* pContextData, uint* pSessionId, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerProcessReceivedPacket(uint sessionHandle, uint cbReceivePacket, const(ubyte)* pReceivePacket, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetSendPacket(uint sessionHandle, uint* pcbSendPacket, ubyte** ppSendPacket, 
                              EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetResult(uint sessionHandle, EapHostPeerMethodResultReason reason, 
                          EapHostPeerMethodResult* ppResult, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetUIContext(uint sessionHandle, uint* pdwSizeOfUIContextData, ubyte** ppUIContextData, 
                             EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerSetUIContext(uint sessionHandle, uint dwSizeOfUIContextData, const(ubyte)* pUIContextData, 
                             EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetResponseAttributes(uint sessionHandle, EAP_ATTRIBUTES* pAttribs, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerSetResponseAttributes(uint sessionHandle, const(EAP_ATTRIBUTES)* pAttribs, 
                                      EapHostPeerResponseAction* pEapOutput, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetAuthStatus(uint sessionHandle, EapHostPeerAuthParams authParam, uint* pcbAuthData, 
                              ubyte** ppAuthData, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerEndSession(uint sessionHandle, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
uint EapHostPeerGetDataToUnplumbCredentials(GUID* pConnectionIdThatLastSavedCreds, 
                                            int* phCredentialImpersonationToken, uint sessionHandle, 
                                            EAP_ERROR** ppEapError, int* fSaveToCredMan);

@DllImport("eappprxy")
uint EapHostPeerClearConnection(GUID* pConnectionId, EAP_ERROR** ppEapError);

@DllImport("eappprxy")
void EapHostPeerFreeEapError(EAP_ERROR* pEapError);

@DllImport("eappprxy")
uint EapHostPeerGetIdentity(uint dwVersion, uint dwFlags, EAP_METHOD_TYPE eapMethodType, 
                            uint dwSizeofConnectionData, char* pConnectionData, uint dwSizeofUserData, 
                            char* pUserData, HANDLE hTokenImpersonateUser, int* pfInvokeUI, 
                            uint* pdwSizeOfUserDataOut, ubyte** ppUserDataOut, ushort** ppwszIdentity, 
                            EAP_ERROR** ppEapError, ubyte** ppvReserved);

@DllImport("eappprxy")
uint EapHostPeerGetEncryptedPassword(uint dwSizeofPassword, const(wchar)* szPassword, ushort** ppszEncPassword);

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

@GUID("66A2DB19-D706-11D0-A37B-00C04FC9DA04")
interface IEAPProviderConfig : IUnknown
{
    HRESULT Initialize(ushort* pszMachineName, uint dwEapTypeId, size_t* puConnectionParam);
    HRESULT Uninitialize(uint dwEapTypeId, size_t uConnectionParam);
    HRESULT ServerInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hWnd, size_t uReserved1, 
                                 size_t uReserved2);
    HRESULT RouterInvokeConfigUI(uint dwEapTypeId, size_t uConnectionParam, HWND hwndParent, uint dwFlags, 
                                 ubyte* pConnectionDataIn, uint dwSizeOfConnectionDataIn, 
                                 ubyte** ppConnectionDataOut, uint* pdwSizeOfConnectionDataOut);
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
