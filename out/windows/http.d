module windows.http;

public import windows.core;
public import windows.networkdrivers : SOCKADDR_STORAGE_LH;
public import windows.systemservices : BOOL, HANDLE, OVERLAPPED, SECURITY_ATTRIBUTES, ULARGE_INTEGER;
public import windows.wininet : INTERNET_SCHEME;
public import windows.winsock : SOCKADDR;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    HttpServerAuthenticationProperty         = 0x00000000,
    HttpServerLoggingProperty                = 0x00000001,
    HttpServerQosProperty                    = 0x00000002,
    HttpServerTimeoutsProperty               = 0x00000003,
    HttpServerQueueLengthProperty            = 0x00000004,
    HttpServerStateProperty                  = 0x00000005,
    HttpServer503VerbosityProperty           = 0x00000006,
    HttpServerBindingProperty                = 0x00000007,
    HttpServerExtendedAuthenticationProperty = 0x00000008,
    HttpServerListenEndpointProperty         = 0x00000009,
    HttpServerChannelBindProperty            = 0x0000000a,
    HttpServerProtectionLevelProperty        = 0x0000000b,
}
alias HTTP_SERVER_PROPERTY = int;

enum : int
{
    HttpEnabledStateActive   = 0x00000000,
    HttpEnabledStateInactive = 0x00000001,
}
alias HTTP_ENABLED_STATE = int;

enum : int
{
    Http503ResponseVerbosityBasic   = 0x00000000,
    Http503ResponseVerbosityLimited = 0x00000001,
    Http503ResponseVerbosityFull    = 0x00000002,
}
alias HTTP_503_RESPONSE_VERBOSITY = int;

enum : int
{
    HttpQosSettingTypeBandwidth       = 0x00000000,
    HttpQosSettingTypeConnectionLimit = 0x00000001,
    HttpQosSettingTypeFlowRate        = 0x00000002,
}
alias HTTP_QOS_SETTING_TYPE = int;

enum : int
{
    IdleConnectionTimeout = 0x00000000,
    HeaderWaitTimeout     = 0x00000001,
}
alias HTTP_SERVICE_CONFIG_TIMEOUT_KEY = int;

enum : int
{
    HttpNone        = 0x00000000,
    HttpTlsThrottle = 0x00000001,
}
alias HTTP_SERVICE_CONFIG_SETTING_KEY = int;

enum : int
{
    HttpServiceBindingTypeNone = 0x00000000,
    HttpServiceBindingTypeW    = 0x00000001,
    HttpServiceBindingTypeA    = 0x00000002,
}
alias HTTP_SERVICE_BINDING_TYPE = int;

enum : int
{
    HttpAuthenticationHardeningLegacy = 0x00000000,
    HttpAuthenticationHardeningMedium = 0x00000001,
    HttpAuthenticationHardeningStrict = 0x00000002,
}
alias HTTP_AUTHENTICATION_HARDENING_LEVELS = int;

enum : int
{
    HttpLoggingTypeW3C  = 0x00000000,
    HttpLoggingTypeIIS  = 0x00000001,
    HttpLoggingTypeNCSA = 0x00000002,
    HttpLoggingTypeRaw  = 0x00000003,
}
alias HTTP_LOGGING_TYPE = int;

enum : int
{
    HttpLoggingRolloverSize    = 0x00000000,
    HttpLoggingRolloverDaily   = 0x00000001,
    HttpLoggingRolloverWeekly  = 0x00000002,
    HttpLoggingRolloverMonthly = 0x00000003,
    HttpLoggingRolloverHourly  = 0x00000004,
}
alias HTTP_LOGGING_ROLLOVER_TYPE = int;

enum : int
{
    HttpProtectionLevelUnrestricted   = 0x00000000,
    HttpProtectionLevelEdgeRestricted = 0x00000001,
    HttpProtectionLevelRestricted     = 0x00000002,
}
alias HTTP_PROTECTION_LEVEL_TYPE = int;

enum : int
{
    HttpSchemeHttp    = 0x00000000,
    HttpSchemeHttps   = 0x00000001,
    HttpSchemeMaximum = 0x00000002,
}
alias _HTTP_URI_SCHEME = int;

enum : int
{
    HttpVerbUnparsed  = 0x00000000,
    HttpVerbUnknown   = 0x00000001,
    HttpVerbInvalid   = 0x00000002,
    HttpVerbOPTIONS   = 0x00000003,
    HttpVerbGET       = 0x00000004,
    HttpVerbHEAD      = 0x00000005,
    HttpVerbPOST      = 0x00000006,
    HttpVerbPUT       = 0x00000007,
    HttpVerbDELETE    = 0x00000008,
    HttpVerbTRACE     = 0x00000009,
    HttpVerbCONNECT   = 0x0000000a,
    HttpVerbTRACK     = 0x0000000b,
    HttpVerbMOVE      = 0x0000000c,
    HttpVerbCOPY      = 0x0000000d,
    HttpVerbPROPFIND  = 0x0000000e,
    HttpVerbPROPPATCH = 0x0000000f,
    HttpVerbMKCOL     = 0x00000010,
    HttpVerbLOCK      = 0x00000011,
    HttpVerbUNLOCK    = 0x00000012,
    HttpVerbSEARCH    = 0x00000013,
    HttpVerbMaximum   = 0x00000014,
}
alias HTTP_VERB = int;

enum : int
{
    HttpHeaderCacheControl       = 0x00000000,
    HttpHeaderConnection         = 0x00000001,
    HttpHeaderDate               = 0x00000002,
    HttpHeaderKeepAlive          = 0x00000003,
    HttpHeaderPragma             = 0x00000004,
    HttpHeaderTrailer            = 0x00000005,
    HttpHeaderTransferEncoding   = 0x00000006,
    HttpHeaderUpgrade            = 0x00000007,
    HttpHeaderVia                = 0x00000008,
    HttpHeaderWarning            = 0x00000009,
    HttpHeaderAllow              = 0x0000000a,
    HttpHeaderContentLength      = 0x0000000b,
    HttpHeaderContentType        = 0x0000000c,
    HttpHeaderContentEncoding    = 0x0000000d,
    HttpHeaderContentLanguage    = 0x0000000e,
    HttpHeaderContentLocation    = 0x0000000f,
    HttpHeaderContentMd5         = 0x00000010,
    HttpHeaderContentRange       = 0x00000011,
    HttpHeaderExpires            = 0x00000012,
    HttpHeaderLastModified       = 0x00000013,
    HttpHeaderAccept             = 0x00000014,
    HttpHeaderAcceptCharset      = 0x00000015,
    HttpHeaderAcceptEncoding     = 0x00000016,
    HttpHeaderAcceptLanguage     = 0x00000017,
    HttpHeaderAuthorization      = 0x00000018,
    HttpHeaderCookie             = 0x00000019,
    HttpHeaderExpect             = 0x0000001a,
    HttpHeaderFrom               = 0x0000001b,
    HttpHeaderHost               = 0x0000001c,
    HttpHeaderIfMatch            = 0x0000001d,
    HttpHeaderIfModifiedSince    = 0x0000001e,
    HttpHeaderIfNoneMatch        = 0x0000001f,
    HttpHeaderIfRange            = 0x00000020,
    HttpHeaderIfUnmodifiedSince  = 0x00000021,
    HttpHeaderMaxForwards        = 0x00000022,
    HttpHeaderProxyAuthorization = 0x00000023,
    HttpHeaderReferer            = 0x00000024,
    HttpHeaderRange              = 0x00000025,
    HttpHeaderTe                 = 0x00000026,
    HttpHeaderTranslate          = 0x00000027,
    HttpHeaderUserAgent          = 0x00000028,
    HttpHeaderRequestMaximum     = 0x00000029,
    HttpHeaderAcceptRanges       = 0x00000014,
    HttpHeaderAge                = 0x00000015,
    HttpHeaderEtag               = 0x00000016,
    HttpHeaderLocation           = 0x00000017,
    HttpHeaderProxyAuthenticate  = 0x00000018,
    HttpHeaderRetryAfter         = 0x00000019,
    HttpHeaderServer             = 0x0000001a,
    HttpHeaderSetCookie          = 0x0000001b,
    HttpHeaderVary               = 0x0000001c,
    HttpHeaderWwwAuthenticate    = 0x0000001d,
    HttpHeaderResponseMaximum    = 0x0000001e,
    HttpHeaderMaximum            = 0x00000029,
}
alias HTTP_HEADER_ID = int;

enum : int
{
    HttpLogDataTypeFields = 0x00000000,
}
alias HTTP_LOG_DATA_TYPE = int;

enum : int
{
    HttpDataChunkFromMemory          = 0x00000000,
    HttpDataChunkFromFileHandle      = 0x00000001,
    HttpDataChunkFromFragmentCache   = 0x00000002,
    HttpDataChunkFromFragmentCacheEx = 0x00000003,
    HttpDataChunkMaximum             = 0x00000004,
}
alias HTTP_DATA_CHUNK_TYPE = int;

enum : int
{
    DelegateRequestReservedProperty = 0x00000000,
}
alias HTTP_DELEGATE_REQUEST_PROPERTY_ID = int;

enum : int
{
    HttpAuthStatusSuccess          = 0x00000000,
    HttpAuthStatusNotAuthenticated = 0x00000001,
    HttpAuthStatusFailure          = 0x00000002,
}
alias HTTP_AUTH_STATUS = int;

enum : int
{
    HttpRequestAuthTypeNone      = 0x00000000,
    HttpRequestAuthTypeBasic     = 0x00000001,
    HttpRequestAuthTypeDigest    = 0x00000002,
    HttpRequestAuthTypeNTLM      = 0x00000003,
    HttpRequestAuthTypeNegotiate = 0x00000004,
    HttpRequestAuthTypeKerberos  = 0x00000005,
}
alias HTTP_REQUEST_AUTH_TYPE = int;

enum : int
{
    HttpRequestSizingTypeTlsHandshakeLeg1ClientData = 0x00000000,
    HttpRequestSizingTypeTlsHandshakeLeg1ServerData = 0x00000001,
    HttpRequestSizingTypeTlsHandshakeLeg2ClientData = 0x00000002,
    HttpRequestSizingTypeTlsHandshakeLeg2ServerData = 0x00000003,
    HttpRequestSizingTypeHeaders                    = 0x00000004,
    HttpRequestSizingTypeMax                        = 0x00000005,
}
alias HTTP_REQUEST_SIZING_TYPE = int;

enum : int
{
    HttpRequestTimingTypeConnectionStart                = 0x00000000,
    HttpRequestTimingTypeDataStart                      = 0x00000001,
    HttpRequestTimingTypeTlsCertificateLoadStart        = 0x00000002,
    HttpRequestTimingTypeTlsCertificateLoadEnd          = 0x00000003,
    HttpRequestTimingTypeTlsHandshakeLeg1Start          = 0x00000004,
    HttpRequestTimingTypeTlsHandshakeLeg1End            = 0x00000005,
    HttpRequestTimingTypeTlsHandshakeLeg2Start          = 0x00000006,
    HttpRequestTimingTypeTlsHandshakeLeg2End            = 0x00000007,
    HttpRequestTimingTypeTlsAttributesQueryStart        = 0x00000008,
    HttpRequestTimingTypeTlsAttributesQueryEnd          = 0x00000009,
    HttpRequestTimingTypeTlsClientCertQueryStart        = 0x0000000a,
    HttpRequestTimingTypeTlsClientCertQueryEnd          = 0x0000000b,
    HttpRequestTimingTypeHttp2StreamStart               = 0x0000000c,
    HttpRequestTimingTypeHttp2HeaderDecodeStart         = 0x0000000d,
    HttpRequestTimingTypeHttp2HeaderDecodeEnd           = 0x0000000e,
    HttpRequestTimingTypeRequestHeaderParseStart        = 0x0000000f,
    HttpRequestTimingTypeRequestHeaderParseEnd          = 0x00000010,
    HttpRequestTimingTypeRequestRoutingStart            = 0x00000011,
    HttpRequestTimingTypeRequestRoutingEnd              = 0x00000012,
    HttpRequestTimingTypeRequestQueuedForInspection     = 0x00000013,
    HttpRequestTimingTypeRequestDeliveredForInspection  = 0x00000014,
    HttpRequestTimingTypeRequestReturnedAfterInspection = 0x00000015,
    HttpRequestTimingTypeRequestQueuedForDelegation     = 0x00000016,
    HttpRequestTimingTypeRequestDeliveredForDelegation  = 0x00000017,
    HttpRequestTimingTypeRequestReturnedAfterDelegation = 0x00000018,
    HttpRequestTimingTypeRequestQueuedForIO             = 0x00000019,
    HttpRequestTimingTypeRequestDeliveredForIO          = 0x0000001a,
    HttpRequestTimingTypeHttp3StreamStart               = 0x0000001b,
    HttpRequestTimingTypeHttp3HeaderDecodeStart         = 0x0000001c,
    HttpRequestTimingTypeHttp3HeaderDecodeEnd           = 0x0000001d,
    HttpRequestTimingTypeMax                            = 0x0000001e,
}
alias HTTP_REQUEST_TIMING_TYPE = int;

enum : int
{
    HttpRequestInfoTypeAuth                 = 0x00000000,
    HttpRequestInfoTypeChannelBind          = 0x00000001,
    HttpRequestInfoTypeSslProtocol          = 0x00000002,
    HttpRequestInfoTypeSslTokenBindingDraft = 0x00000003,
    HttpRequestInfoTypeSslTokenBinding      = 0x00000004,
    HttpRequestInfoTypeRequestTiming        = 0x00000005,
    HttpRequestInfoTypeTcpInfoV0            = 0x00000006,
    HttpRequestInfoTypeRequestSizing        = 0x00000007,
    HttpRequestInfoTypeQuicStats            = 0x00000008,
    HttpRequestInfoTypeTcpInfoV1            = 0x00000009,
}
alias HTTP_REQUEST_INFO_TYPE = int;

enum : int
{
    HttpResponseInfoTypeMultipleKnownHeaders   = 0x00000000,
    HttpResponseInfoTypeAuthenticationProperty = 0x00000001,
    HttpResponseInfoTypeQoSProperty            = 0x00000002,
    HttpResponseInfoTypeChannelBind            = 0x00000003,
}
alias HTTP_RESPONSE_INFO_TYPE = int;

enum : int
{
    HttpCachePolicyNocache         = 0x00000000,
    HttpCachePolicyUserInvalidates = 0x00000001,
    HttpCachePolicyTimeToLive      = 0x00000002,
    HttpCachePolicyMaximum         = 0x00000003,
}
alias HTTP_CACHE_POLICY_TYPE = int;

enum : int
{
    HttpServiceConfigIPListenList           = 0x00000000,
    HttpServiceConfigSSLCertInfo            = 0x00000001,
    HttpServiceConfigUrlAclInfo             = 0x00000002,
    HttpServiceConfigTimeout                = 0x00000003,
    HttpServiceConfigCache                  = 0x00000004,
    HttpServiceConfigSslSniCertInfo         = 0x00000005,
    HttpServiceConfigSslCcsCertInfo         = 0x00000006,
    HttpServiceConfigSetting                = 0x00000007,
    HttpServiceConfigSslCertInfoEx          = 0x00000008,
    HttpServiceConfigSslSniCertInfoEx       = 0x00000009,
    HttpServiceConfigSslCcsCertInfoEx       = 0x0000000a,
    HttpServiceConfigSslScopedCcsCertInfo   = 0x0000000b,
    HttpServiceConfigSslScopedCcsCertInfoEx = 0x0000000c,
    HttpServiceConfigMax                    = 0x0000000d,
}
alias HTTP_SERVICE_CONFIG_ID = int;

enum : int
{
    HttpServiceConfigQueryExact = 0x00000000,
    HttpServiceConfigQueryNext  = 0x00000001,
    HttpServiceConfigQueryMax   = 0x00000002,
}
alias HTTP_SERVICE_CONFIG_QUERY_TYPE = int;

enum : int
{
    ExParamTypeHttp2Window         = 0x00000000,
    ExParamTypeHttp2SettingsLimits = 0x00000001,
    ExParamTypeHttpPerformance     = 0x00000002,
    ExParamTypeMax                 = 0x00000003,
}
alias HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE = int;

enum : int
{
    MaxCacheResponseSize = 0x00000000,
    CacheRangeChunkSize  = 0x00000001,
}
alias HTTP_SERVICE_CONFIG_CACHE_KEY = int;

enum : int
{
    HttpRequestPropertyIsb       = 0x00000000,
    HttpRequestPropertyTcpInfoV0 = 0x00000001,
    HttpRequestPropertyQuicStats = 0x00000002,
    HttpRequestPropertyTcpInfoV1 = 0x00000003,
    HttpRequestPropertySni       = 0x00000004,
}
alias HTTP_REQUEST_PROPERTY = int;

enum : int
{
    WinHttpProxyDetectionStart                      = 0x00000000,
    WinHttpProxyDetectionEnd                        = 0x00000001,
    WinHttpConnectionAcquireStart                   = 0x00000002,
    WinHttpConnectionAcquireWaitEnd                 = 0x00000003,
    WinHttpConnectionAcquireEnd                     = 0x00000004,
    WinHttpNameResolutionStart                      = 0x00000005,
    WinHttpNameResolutionEnd                        = 0x00000006,
    WinHttpConnectionEstablishmentStart             = 0x00000007,
    WinHttpConnectionEstablishmentEnd               = 0x00000008,
    WinHttpTlsHandshakeClientLeg1Start              = 0x00000009,
    WinHttpTlsHandshakeClientLeg1End                = 0x0000000a,
    WinHttpTlsHandshakeClientLeg2Start              = 0x0000000b,
    WinHttpTlsHandshakeClientLeg2End                = 0x0000000c,
    WinHttpTlsHandshakeClientLeg3Start              = 0x0000000d,
    WinHttpTlsHandshakeClientLeg3End                = 0x0000000e,
    WinHttpStreamWaitStart                          = 0x0000000f,
    WinHttpStreamWaitEnd                            = 0x00000010,
    WinHttpSendRequestStart                         = 0x00000011,
    WinHttpSendRequestHeadersCompressionStart       = 0x00000012,
    WinHttpSendRequestHeadersCompressionEnd         = 0x00000013,
    WinHttpSendRequestHeadersEnd                    = 0x00000014,
    WinHttpSendRequestEnd                           = 0x00000015,
    WinHttpReceiveResponseStart                     = 0x00000016,
    WinHttpReceiveResponseHeadersDecompressionStart = 0x00000017,
    WinHttpReceiveResponseHeadersDecompressionEnd   = 0x00000018,
    WinHttpReceiveResponseHeadersEnd                = 0x00000019,
    WinHttpReceiveResponseBodyDecompressionDelta    = 0x0000001a,
    WinHttpReceiveResponseEnd                       = 0x0000001b,
    WinHttpProxyTunnelStart                         = 0x0000001c,
    WinHttpProxyTunnelEnd                           = 0x0000001d,
    WinHttpProxyTlsHandshakeClientLeg1Start         = 0x0000001e,
    WinHttpProxyTlsHandshakeClientLeg1End           = 0x0000001f,
    WinHttpProxyTlsHandshakeClientLeg2Start         = 0x00000020,
    WinHttpProxyTlsHandshakeClientLeg2End           = 0x00000021,
    WinHttpProxyTlsHandshakeClientLeg3Start         = 0x00000022,
    WinHttpProxyTlsHandshakeClientLeg3End           = 0x00000023,
    WinHttpRequestTimeLast                          = 0x00000024,
    WinHttpRequestTimeMax                           = 0x00000040,
}
alias WINHTTP_REQUEST_TIME_ENTRY = int;

enum : int
{
    WinHttpConnectFailureCount             = 0x00000000,
    WinHttpProxyFailureCount               = 0x00000001,
    WinHttpTlsHandshakeClientLeg1Size      = 0x00000002,
    WinHttpTlsHandshakeServerLeg1Size      = 0x00000003,
    WinHttpTlsHandshakeClientLeg2Size      = 0x00000004,
    WinHttpTlsHandshakeServerLeg2Size      = 0x00000005,
    WinHttpRequestHeadersSize              = 0x00000006,
    WinHttpRequestHeadersCompressedSize    = 0x00000007,
    WinHttpResponseHeadersSize             = 0x00000008,
    WinHttpResponseHeadersCompressedSize   = 0x00000009,
    WinHttpResponseBodySize                = 0x0000000a,
    WinHttpResponseBodyCompressedSize      = 0x0000000b,
    WinHttpProxyTlsHandshakeClientLeg1Size = 0x0000000c,
    WinHttpProxyTlsHandshakeServerLeg1Size = 0x0000000d,
    WinHttpProxyTlsHandshakeClientLeg2Size = 0x0000000e,
    WinHttpProxyTlsHandshakeServerLeg2Size = 0x0000000f,
    WinHttpRequestStatLast                 = 0x00000010,
    WinHttpRequestStatMax                  = 0x00000020,
}
alias WINHTTP_REQUEST_STAT_ENTRY = int;

enum : int
{
    WINHTTP_WEB_SOCKET_SEND_OPERATION     = 0x00000000,
    WINHTTP_WEB_SOCKET_RECEIVE_OPERATION  = 0x00000001,
    WINHTTP_WEB_SOCKET_CLOSE_OPERATION    = 0x00000002,
    WINHTTP_WEB_SOCKET_SHUTDOWN_OPERATION = 0x00000003,
}
alias WINHTTP_WEB_SOCKET_OPERATION = int;

enum : int
{
    WINHTTP_WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE  = 0x00000000,
    WINHTTP_WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE = 0x00000001,
    WINHTTP_WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE    = 0x00000002,
    WINHTTP_WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE   = 0x00000003,
    WINHTTP_WEB_SOCKET_CLOSE_BUFFER_TYPE           = 0x00000004,
}
alias WINHTTP_WEB_SOCKET_BUFFER_TYPE = int;

enum : int
{
    WINHTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS                = 0x000003e8,
    WINHTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS    = 0x000003e9,
    WINHTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS         = 0x000003ea,
    WINHTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS      = 0x000003eb,
    WINHTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS                  = 0x000003ed,
    WINHTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS                = 0x000003ee,
    WINHTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS        = 0x000003ef,
    WINHTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS       = 0x000003f0,
    WINHTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS        = 0x000003f1,
    WINHTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 0x000003f2,
    WINHTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS           = 0x000003f3,
    WINHTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 0x000003f7,
}
alias WINHTTP_WEB_SOCKET_CLOSE_STATUS = int;

// Callbacks

alias WINHTTP_STATUS_CALLBACK = void function(void* hInternet, size_t dwContext, uint dwInternetStatus, 
                                              void* lpvStatusInformation, uint dwStatusInformationLength);
alias LPWINHTTP_STATUS_CALLBACK = void function();

// Structs


struct HTTP_PROPERTY_FLAGS
{
    uint _bitfield46;
}

struct HTTP_STATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HTTP_ENABLED_STATE  State;
}

struct HTTP_QOS_SETTING_INFO
{
    HTTP_QOS_SETTING_TYPE QosType;
    void* QosSetting;
}

struct HTTP_CONNECTION_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxConnections;
}

struct HTTP_BANDWIDTH_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxBandwidth;
}

struct HTTP_FLOWRATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxBandwidth;
    uint                MaxPeakBandwidth;
    uint                BurstSize;
}

struct HTTP_SERVICE_CONFIG_TIMEOUT_SET
{
    HTTP_SERVICE_CONFIG_TIMEOUT_KEY KeyDesc;
    ushort ParamDesc;
}

struct HTTP_TIMEOUT_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    ushort              EntityBody;
    ushort              DrainEntityBody;
    ushort              RequestQueue;
    ushort              IdleConnection;
    ushort              HeaderWait;
    uint                MinSendRate;
}

struct HTTP_SERVICE_CONFIG_SETTING_SET
{
    HTTP_SERVICE_CONFIG_SETTING_KEY KeyDesc;
    uint ParamDesc;
}

struct HTTP_LISTEN_ENDPOINT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    ubyte               EnableSharing;
}

struct HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
{
    ushort        DomainNameLength;
    const(wchar)* DomainName;
    ushort        RealmLength;
    const(wchar)* Realm;
}

struct HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
{
    ushort        RealmLength;
    const(wchar)* Realm;
}

struct HTTP_SERVER_AUTHENTICATION_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                AuthSchemes;
    ubyte               ReceiveMutualAuth;
    ubyte               ReceiveContextHandle;
    ubyte               DisableNTLMCredentialCaching;
    ubyte               ExFlags;
    HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS DigestParams;
    HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS BasicParams;
}

struct HTTP_SERVICE_BINDING_BASE
{
    HTTP_SERVICE_BINDING_TYPE Type;
}

struct HTTP_SERVICE_BINDING_A
{
    HTTP_SERVICE_BINDING_BASE Base;
    const(char)* Buffer;
    uint         BufferSize;
}

struct HTTP_SERVICE_BINDING_W
{
    HTTP_SERVICE_BINDING_BASE Base;
    const(wchar)* Buffer;
    uint          BufferSize;
}

struct HTTP_CHANNEL_BIND_INFO
{
    HTTP_AUTHENTICATION_HARDENING_LEVELS Hardening;
    uint Flags;
    HTTP_SERVICE_BINDING_BASE** ServiceNames;
    uint NumberOfServiceNames;
}

struct HTTP_REQUEST_CHANNEL_BIND_STATUS
{
    HTTP_SERVICE_BINDING_BASE* ServiceName;
    ubyte* ChannelToken;
    uint   ChannelTokenSize;
    uint   Flags;
}

struct HTTP_REQUEST_TOKEN_BINDING_INFO
{
    ubyte* TokenBinding;
    uint   TokenBindingSize;
    ubyte* EKM;
    uint   EKMSize;
    ubyte  KeyType;
}

struct HTTP_LOGGING_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                LoggingFlags;
    const(wchar)*       SoftwareName;
    ushort              SoftwareNameLength;
    ushort              DirectoryNameLength;
    const(wchar)*       DirectoryName;
    HTTP_LOGGING_TYPE   Format;
    uint                Fields;
    void*               pExtFields;
    ushort              NumOfExtFields;
    ushort              MaxRecordSize;
    HTTP_LOGGING_ROLLOVER_TYPE RolloverType;
    uint                RolloverSize;
    void*               pSecurityDescriptor;
}

struct HTTP_BINDING_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HANDLE              RequestQueueHandle;
}

struct HTTP_PROTECTION_LEVEL_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HTTP_PROTECTION_LEVEL_TYPE Level;
}

struct HTTP_BYTE_RANGE
{
    ULARGE_INTEGER StartingOffset;
    ULARGE_INTEGER Length;
}

struct HTTP_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct HTTP_KNOWN_HEADER
{
    ushort       RawValueLength;
    const(char)* pRawValue;
}

struct HTTP_UNKNOWN_HEADER
{
    ushort       NameLength;
    ushort       RawValueLength;
    const(char)* pName;
    const(char)* pRawValue;
}

struct HTTP_LOG_DATA
{
    HTTP_LOG_DATA_TYPE Type;
}

struct HTTP_LOG_FIELDS_DATA
{
    HTTP_LOG_DATA Base;
    ushort        UserNameLength;
    ushort        UriStemLength;
    ushort        ClientIpLength;
    ushort        ServerNameLength;
    ushort        ServiceNameLength;
    ushort        ServerIpLength;
    ushort        MethodLength;
    ushort        UriQueryLength;
    ushort        HostLength;
    ushort        UserAgentLength;
    ushort        CookieLength;
    ushort        ReferrerLength;
    const(wchar)* UserName;
    const(wchar)* UriStem;
    const(char)*  ClientIp;
    const(char)*  ServerName;
    const(char)*  ServiceName;
    const(char)*  ServerIp;
    const(char)*  Method;
    const(char)*  UriQuery;
    const(char)*  Host;
    const(char)*  UserAgent;
    const(char)*  Cookie;
    const(char)*  Referrer;
    ushort        ServerPort;
    ushort        ProtocolStatus;
    uint          Win32Status;
    HTTP_VERB     MethodNum;
    ushort        SubStatus;
}

struct HTTP_DATA_CHUNK
{
    HTTP_DATA_CHUNK_TYPE DataChunkType;
    union
    {
        struct FromMemory
        {
            void* pBuffer;
            uint  BufferLength;
        }
        struct FromFileHandle
        {
            HTTP_BYTE_RANGE ByteRange;
            HANDLE          FileHandle;
        }
        struct FromFragmentCache
        {
            ushort        FragmentNameLength;
            const(wchar)* pFragmentName;
        }
        struct FromFragmentCacheEx
        {
            HTTP_BYTE_RANGE ByteRange;
            const(wchar)*   pFragmentName;
        }
    }
}

struct HTTP_REQUEST_HEADERS
{
    ushort               UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort               TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER[41] KnownHeaders;
}

struct HTTP_RESPONSE_HEADERS
{
    ushort               UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort               TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER[30] KnownHeaders;
}

struct HTTP_DELEGATE_REQUEST_PROPERTY_INFO
{
    HTTP_DELEGATE_REQUEST_PROPERTY_ID ProperyId;
    uint  PropertyInfoLength;
    void* PropertyInfo;
}

struct HTTP_TRANSPORT_ADDRESS
{
    SOCKADDR* pRemoteAddress;
    SOCKADDR* pLocalAddress;
}

struct HTTP_COOKED_URL
{
    ushort        FullUrlLength;
    ushort        HostLength;
    ushort        AbsPathLength;
    ushort        QueryStringLength;
    const(wchar)* pFullUrl;
    const(wchar)* pHost;
    const(wchar)* pAbsPath;
    const(wchar)* pQueryString;
}

struct HTTP_SSL_CLIENT_CERT_INFO
{
    uint   CertFlags;
    uint   CertEncodedSize;
    ubyte* pCertEncoded;
    HANDLE Token;
    ubyte  CertDeniedByMapper;
}

struct HTTP_SSL_INFO
{
    ushort       ServerCertKeySize;
    ushort       ConnectionKeySize;
    uint         ServerCertIssuerSize;
    uint         ServerCertSubjectSize;
    const(char)* pServerCertIssuer;
    const(char)* pServerCertSubject;
    HTTP_SSL_CLIENT_CERT_INFO* pClientCertInfo;
    uint         SslClientCertNegotiated;
}

struct HTTP_SSL_PROTOCOL_INFO
{
    uint Protocol;
    uint CipherType;
    uint CipherStrength;
    uint HashType;
    uint HashStrength;
    uint KeyExchangeType;
    uint KeyExchangeStrength;
}

struct HTTP_REQUEST_SIZING_INFO
{
    ulong    Flags;
    uint     RequestIndex;
    uint     RequestSizingCount;
    ulong[5] RequestSizing;
}

struct HTTP_REQUEST_TIMING_INFO
{
    uint      RequestTimingCount;
    ulong[30] RequestTiming;
}

struct HTTP_REQUEST_INFO
{
    HTTP_REQUEST_INFO_TYPE InfoType;
    uint  InfoLength;
    void* pInfo;
}

struct HTTP_REQUEST_AUTH_INFO
{
    HTTP_AUTH_STATUS AuthStatus;
    int              SecStatus;
    uint             Flags;
    HTTP_REQUEST_AUTH_TYPE AuthType;
    HANDLE           AccessToken;
    uint             ContextAttributes;
    uint             PackedContextLength;
    uint             PackedContextType;
    void*            PackedContext;
    uint             MutualAuthDataLength;
    const(char)*     pMutualAuthData;
    ushort           PackageNameLength;
    const(wchar)*    pPackageName;
}

struct HTTP_REQUEST_V1
{
    uint                 Flags;
    ulong                ConnectionId;
    ulong                RequestId;
    ulong                UrlContext;
    HTTP_VERSION         Version;
    HTTP_VERB            Verb;
    ushort               UnknownVerbLength;
    ushort               RawUrlLength;
    const(char)*         pUnknownVerb;
    const(char)*         pRawUrl;
    HTTP_COOKED_URL      CookedUrl;
    HTTP_TRANSPORT_ADDRESS Address;
    HTTP_REQUEST_HEADERS Headers;
    ulong                BytesReceived;
    ushort               EntityChunkCount;
    HTTP_DATA_CHUNK*     pEntityChunks;
    ulong                RawConnectionId;
    HTTP_SSL_INFO*       pSslInfo;
}

struct HTTP_REQUEST_V2
{
    HTTP_REQUEST_V1    __AnonymousBase_http_L1816_C35;
    ushort             RequestInfoCount;
    HTTP_REQUEST_INFO* pRequestInfo;
}

struct HTTP_RESPONSE_V1
{
    uint             Flags;
    HTTP_VERSION     Version;
    ushort           StatusCode;
    ushort           ReasonLength;
    const(char)*     pReason;
    HTTP_RESPONSE_HEADERS Headers;
    ushort           EntityChunkCount;
    HTTP_DATA_CHUNK* pEntityChunks;
}

struct HTTP_RESPONSE_INFO
{
    HTTP_RESPONSE_INFO_TYPE Type;
    uint  Length;
    void* pInfo;
}

struct HTTP_MULTIPLE_KNOWN_HEADERS
{
    HTTP_HEADER_ID     HeaderId;
    uint               Flags;
    ushort             KnownHeaderCount;
    HTTP_KNOWN_HEADER* KnownHeaders;
}

struct HTTP_RESPONSE_V2
{
    HTTP_RESPONSE_V1    __AnonymousBase_http_L2003_C36;
    ushort              ResponseInfoCount;
    HTTP_RESPONSE_INFO* pResponseInfo;
}

struct HTTPAPI_VERSION
{
    ushort HttpApiMajorVersion;
    ushort HttpApiMinorVersion;
}

struct HTTP_CACHE_POLICY
{
    HTTP_CACHE_POLICY_TYPE Policy;
    uint SecondsToLive;
}

struct HTTP_SERVICE_CONFIG_SSL_KEY
{
    SOCKADDR* pIpPort;
}

struct HTTP_SERVICE_CONFIG_SSL_KEY_EX
{
    SOCKADDR_STORAGE_LH IpPort;
}

struct HTTP_SERVICE_CONFIG_SSL_SNI_KEY
{
    SOCKADDR_STORAGE_LH IpPort;
    const(wchar)*       Host;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_KEY
{
    SOCKADDR_STORAGE_LH LocalAddress;
}

struct HTTP_SERVICE_CONFIG_SSL_PARAM
{
    uint          SslHashLength;
    void*         pSslHash;
    GUID          AppId;
    const(wchar)* pSslCertStoreName;
    uint          DefaultCertCheckMode;
    uint          DefaultRevocationFreshnessTime;
    uint          DefaultRevocationUrlRetrievalTimeout;
    const(wchar)* pDefaultSslCtlIdentifier;
    const(wchar)* pDefaultSslCtlStoreName;
    uint          DefaultFlags;
}

struct HTTP2_WINDOW_SIZE_PARAM
{
    uint Http2ReceiveWindowSize;
}

struct HTTP2_SETTINGS_LIMITS_PARAM
{
    uint Http2MaxSettingsPerFrame;
    uint Http2MaxSettingsPerMinute;
}

struct HTTP_PERFORMANCE_PARAM
{
    ulong SendBufferingFlags;
    ubyte EnableAggressiveICW;
    uint  MaxBufferedSendBytes;
    uint  MaxConcurrentClientStreams;
}

struct HTTP_SERVICE_CONFIG_SSL_PARAM_EX
{
    HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE ParamType;
    ulong Flags;
    union
    {
        HTTP2_WINDOW_SIZE_PARAM Http2WindowSizeParam;
        HTTP2_SETTINGS_LIMITS_PARAM Http2SettingsLimitsParam;
        HTTP_PERFORMANCE_PARAM HttpPerformanceParam;
    }
}

struct HTTP_SERVICE_CONFIG_SSL_SET
{
    HTTP_SERVICE_CONFIG_SSL_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_SNI_SET
{
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_SET
{
    HTTP_SERVICE_CONFIG_SSL_CCS_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_SET_EX
{
    HTTP_SERVICE_CONFIG_SSL_KEY_EX KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM_EX ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_SNI_SET_EX
{
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM_EX ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_SET_EX
{
    HTTP_SERVICE_CONFIG_SSL_CCS_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM_EX ParamDesc;
}

struct HTTP_SERVICE_CONFIG_SSL_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_KEY KeyDesc;
    uint dwToken;
}

struct HTTP_SERVICE_CONFIG_SSL_SNI_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    uint dwToken;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_CCS_KEY KeyDesc;
    uint dwToken;
}

struct HTTP_SERVICE_CONFIG_SSL_QUERY_EX
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_KEY_EX KeyDesc;
    uint dwToken;
    HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE ParamType;
}

struct HTTP_SERVICE_CONFIG_SSL_SNI_QUERY_EX
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    uint dwToken;
    HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE ParamType;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_QUERY_EX
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_CCS_KEY KeyDesc;
    uint dwToken;
    HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE ParamType;
}

struct HTTP_SERVICE_CONFIG_IP_LISTEN_PARAM
{
    ushort    AddrLength;
    SOCKADDR* pAddress;
}

struct HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY
{
    uint AddrCount;
    SOCKADDR_STORAGE_LH[1] AddrList;
}

struct HTTP_SERVICE_CONFIG_URLACL_KEY
{
    const(wchar)* pUrlPrefix;
}

struct HTTP_SERVICE_CONFIG_URLACL_PARAM
{
    const(wchar)* pStringSecurityDescriptor;
}

struct HTTP_SERVICE_CONFIG_URLACL_SET
{
    HTTP_SERVICE_CONFIG_URLACL_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_URLACL_PARAM ParamDesc;
}

struct HTTP_SERVICE_CONFIG_URLACL_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_URLACL_KEY KeyDesc;
    uint dwToken;
}

struct HTTP_SERVICE_CONFIG_CACHE_SET
{
    HTTP_SERVICE_CONFIG_CACHE_KEY KeyDesc;
    uint ParamDesc;
}

struct HTTP_QUERY_REQUEST_QUALIFIER_TCP
{
    ulong Freshness;
}

struct HTTP_QUERY_REQUEST_QUALIFIER_QUIC
{
    ulong Freshness;
}

struct HTTP_REQUEST_PROPERTY_SNI
{
    ushort[256] Hostname;
    uint        Flags;
}

struct WINHTTP_ASYNC_RESULT
{
    size_t dwResult;
    uint   dwError;
}

struct URL_COMPONENTS
{
    uint            dwStructSize;
    const(wchar)*   lpszScheme;
    uint            dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(wchar)*   lpszHostName;
    uint            dwHostNameLength;
    ushort          nPort;
    const(wchar)*   lpszUserName;
    uint            dwUserNameLength;
    const(wchar)*   lpszPassword;
    uint            dwPasswordLength;
    const(wchar)*   lpszUrlPath;
    uint            dwUrlPathLength;
    const(wchar)*   lpszExtraInfo;
    uint            dwExtraInfoLength;
}

struct WINHTTP_PROXY_INFO
{
    uint          dwAccessType;
    const(wchar)* lpszProxy;
    const(wchar)* lpszProxyBypass;
}

struct WINHTTP_AUTOPROXY_OPTIONS
{
    uint          dwFlags;
    uint          dwAutoDetectFlags;
    const(wchar)* lpszAutoConfigUrl;
    void*         lpvReserved;
    uint          dwReserved;
    BOOL          fAutoLogonIfChallenged;
}

struct WINHTTP_PROXY_RESULT_ENTRY
{
    BOOL            fProxy;
    BOOL            fBypass;
    INTERNET_SCHEME ProxyScheme;
    const(wchar)*   pwszProxy;
    ushort          ProxyPort;
}

struct WINHTTP_PROXY_RESULT
{
    uint cEntries;
    WINHTTP_PROXY_RESULT_ENTRY* pEntries;
}

struct WINHTTP_PROXY_RESULT_EX
{
    uint   cEntries;
    WINHTTP_PROXY_RESULT_ENTRY* pEntries;
    HANDLE hProxyDetectionHandle;
    uint   dwProxyInterfaceAffinity;
}

struct _WinHttpProxyNetworkKey
{
    ubyte[128] pbBuffer;
}

struct WINHTTP_PROXY_SETTINGS
{
    uint          dwStructSize;
    uint          dwFlags;
    uint          dwCurrentSettingsVersion;
    const(wchar)* pwszConnectionName;
    const(wchar)* pwszProxy;
    const(wchar)* pwszProxyBypass;
    const(wchar)* pwszAutoconfigUrl;
    const(wchar)* pwszAutoconfigSecondaryUrl;
    uint          dwAutoDiscoveryFlags;
    const(wchar)* pwszLastKnownGoodAutoConfigUrl;
    uint          dwAutoconfigReloadDelayMins;
    FILETIME      ftLastKnownDetectTime;
    uint          dwDetectedInterfaceIpCount;
    uint*         pdwDetectedInterfaceIp;
    uint          cNetworkKeys;
    _WinHttpProxyNetworkKey* pNetworkKeys;
}

struct WINHTTP_CERTIFICATE_INFO
{
    FILETIME      ftExpiry;
    FILETIME      ftStart;
    const(wchar)* lpszSubjectInfo;
    const(wchar)* lpszIssuerInfo;
    const(wchar)* lpszProtocolName;
    const(wchar)* lpszSignatureAlgName;
    const(wchar)* lpszEncryptionAlgName;
    uint          dwKeySize;
}

struct WINHTTP_CONNECTION_INFO
{
align (4):
    uint                cbSize;
    SOCKADDR_STORAGE_LH LocalAddress;
    SOCKADDR_STORAGE_LH RemoteAddress;
}

struct WINHTTP_REQUEST_TIMES
{
align (4):
    uint      cTimes;
    ulong[64] rgullTimes;
}

struct WINHTTP_REQUEST_STATS
{
align (4):
    ulong     ullFlags;
    uint      ulIndex;
    uint      cStats;
    ulong[32] rgullStats;
}

struct WINHTTP_EXTENDED_HEADER
{
    union
    {
        const(wchar)* pwszName;
        const(char)*  pszName;
    }
    union
    {
        const(wchar)* pwszValue;
        const(char)*  pszValue;
    }
}

struct WINHTTP_CREDS
{
    const(char)* lpszUserName;
    const(char)* lpszPassword;
    const(char)* lpszRealm;
    uint         dwAuthScheme;
    const(char)* lpszHostName;
    uint         dwPort;
}

struct WINHTTP_CREDS_EX
{
    const(char)* lpszUserName;
    const(char)* lpszPassword;
    const(char)* lpszRealm;
    uint         dwAuthScheme;
    const(char)* lpszHostName;
    uint         dwPort;
    const(char)* lpszUrl;
}

struct WINHTTP_CURRENT_USER_IE_PROXY_CONFIG
{
    BOOL          fAutoDetect;
    const(wchar)* lpszAutoConfigUrl;
    const(wchar)* lpszProxy;
    const(wchar)* lpszProxyBypass;
}

struct WINHTTP_WEB_SOCKET_ASYNC_RESULT
{
    WINHTTP_ASYNC_RESULT AsyncResult;
    WINHTTP_WEB_SOCKET_OPERATION Operation;
}

struct WINHTTP_WEB_SOCKET_STATUS
{
    uint dwBytesTransferred;
    WINHTTP_WEB_SOCKET_BUFFER_TYPE eBufferType;
}

// Functions

@DllImport("HTTPAPI")
uint HttpInitialize(HTTPAPI_VERSION Version, uint Flags, void* pReserved);

@DllImport("HTTPAPI")
uint HttpTerminate(uint Flags, void* pReserved);

@DllImport("HTTPAPI")
uint HttpCreateHttpHandle(ptrdiff_t* RequestQueueHandle, uint Reserved);

@DllImport("HTTPAPI")
uint HttpCreateRequestQueue(HTTPAPI_VERSION Version, const(wchar)* Name, SECURITY_ATTRIBUTES* SecurityAttributes, 
                            uint Flags, ptrdiff_t* RequestQueueHandle);

@DllImport("HTTPAPI")
uint HttpCloseRequestQueue(HANDLE RequestQueueHandle);

@DllImport("HTTPAPI")
uint HttpSetRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, 
                                 char* PropertyInformation, uint PropertyInformationLength, uint Reserved1, 
                                 void* Reserved2);

@DllImport("HTTPAPI")
uint HttpQueryRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, 
                                   char* PropertyInformation, uint PropertyInformationLength, uint Reserved1, 
                                   uint* ReturnLength, void* Reserved2);

@DllImport("HTTPAPI")
uint HttpShutdownRequestQueue(HANDLE RequestQueueHandle);

@DllImport("HTTPAPI")
uint HttpReceiveClientCertificate(HANDLE RequestQueueHandle, ulong ConnectionId, uint Flags, 
                                  char* SslClientCertInfo, uint SslClientCertInfoSize, uint* BytesReceived, 
                                  OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpCreateServerSession(HTTPAPI_VERSION Version, ulong* ServerSessionId, uint Reserved);

@DllImport("HTTPAPI")
uint HttpCloseServerSession(ulong ServerSessionId);

@DllImport("HTTPAPI")
uint HttpQueryServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, 
                                    char* PropertyInformation, uint PropertyInformationLength, uint* ReturnLength);

@DllImport("HTTPAPI")
uint HttpSetServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, 
                                  uint PropertyInformationLength);

@DllImport("HTTPAPI")
uint HttpAddUrl(HANDLE RequestQueueHandle, const(wchar)* FullyQualifiedUrl, void* Reserved);

@DllImport("HTTPAPI")
uint HttpRemoveUrl(HANDLE RequestQueueHandle, const(wchar)* FullyQualifiedUrl);

@DllImport("HTTPAPI")
uint HttpCreateUrlGroup(ulong ServerSessionId, ulong* pUrlGroupId, uint Reserved);

@DllImport("HTTPAPI")
uint HttpCloseUrlGroup(ulong UrlGroupId);

@DllImport("HTTPAPI")
uint HttpAddUrlToUrlGroup(ulong UrlGroupId, const(wchar)* pFullyQualifiedUrl, ulong UrlContext, uint Reserved);

@DllImport("HTTPAPI")
uint HttpRemoveUrlFromUrlGroup(ulong UrlGroupId, const(wchar)* pFullyQualifiedUrl, uint Flags);

@DllImport("HTTPAPI")
uint HttpSetUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, 
                             uint PropertyInformationLength);

@DllImport("HTTPAPI")
uint HttpQueryUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, 
                               uint PropertyInformationLength, uint* ReturnLength);

@DllImport("HTTPAPI")
uint HttpPrepareUrl(void* Reserved, uint Flags, const(wchar)* Url, ushort** PreparedUrl);

@DllImport("HTTPAPI")
uint HttpReceiveHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, char* RequestBuffer, 
                            uint RequestBufferLength, uint* BytesReturned, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpReceiveRequestEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, char* EntityBuffer, 
                                  uint EntityBufferLength, uint* BytesReturned, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpSendHttpResponse(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, HTTP_RESPONSE_V2* HttpResponse, 
                          HTTP_CACHE_POLICY* CachePolicy, uint* BytesSent, void* Reserved1, uint Reserved2, 
                          OVERLAPPED* Overlapped, HTTP_LOG_DATA* LogData);

@DllImport("HTTPAPI")
uint HttpSendResponseEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, ushort EntityChunkCount, 
                                char* EntityChunks, uint* BytesSent, void* Reserved1, uint Reserved2, 
                                OVERLAPPED* Overlapped, HTTP_LOG_DATA* LogData);

@DllImport("HTTPAPI")
uint HttpDeclarePush(HANDLE RequestQueueHandle, ulong RequestId, HTTP_VERB Verb, const(wchar)* Path, 
                     const(char)* Query, HTTP_REQUEST_HEADERS* Headers);

@DllImport("HTTPAPI")
uint HttpWaitForDisconnect(HANDLE RequestQueueHandle, ulong ConnectionId, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpWaitForDisconnectEx(HANDLE RequestQueueHandle, ulong ConnectionId, uint Reserved, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpCancelHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpWaitForDemandStart(HANDLE RequestQueueHandle, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpFlushResponseCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, uint Flags, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpAddFragmentToCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, HTTP_DATA_CHUNK* DataChunk, 
                            HTTP_CACHE_POLICY* CachePolicy, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpReadFragmentFromCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, HTTP_BYTE_RANGE* ByteRange, 
                               char* Buffer, uint BufferLength, uint* BytesRead, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpSetServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, char* pConfigInformation, 
                                 uint ConfigInformationLength, OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI")
uint HttpUpdateServiceConfiguration(HANDLE Handle, HTTP_SERVICE_CONFIG_ID ConfigId, char* ConfigInfo, 
                                    uint ConfigInfoLength, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI")
uint HttpDeleteServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, 
                                    char* pConfigInformation, uint ConfigInformationLength, OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI")
uint HttpQueryServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, char* pInput, 
                                   uint InputLength, char* pOutput, uint OutputLength, uint* pReturnLength, 
                                   OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI")
uint HttpGetExtension(HTTPAPI_VERSION Version, uint Extension, void* Buffer, uint BufferSize);

@DllImport("WINHTTP")
WINHTTP_STATUS_CALLBACK WinHttpSetStatusCallback(void* hInternet, WINHTTP_STATUS_CALLBACK lpfnInternetCallback, 
                                                 uint dwNotificationFlags, size_t dwReserved);

@DllImport("WINHTTP")
BOOL WinHttpTimeFromSystemTime(const(SYSTEMTIME)* pst, const(wchar)* pwszTime);

@DllImport("WINHTTP")
BOOL WinHttpTimeToSystemTime(const(wchar)* pwszTime, SYSTEMTIME* pst);

@DllImport("WINHTTP")
BOOL WinHttpCrackUrl(const(wchar)* pwszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTS* lpUrlComponents);

@DllImport("WINHTTP")
BOOL WinHttpCreateUrl(URL_COMPONENTS* lpUrlComponents, uint dwFlags, const(wchar)* pwszUrl, uint* pdwUrlLength);

@DllImport("WINHTTP")
BOOL WinHttpCheckPlatform();

@DllImport("WINHTTP")
BOOL WinHttpGetDefaultProxyConfiguration(WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP")
BOOL WinHttpSetDefaultProxyConfiguration(WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP")
void* WinHttpOpen(const(wchar)* pszAgentW, uint dwAccessType, const(wchar)* pszProxyW, 
                  const(wchar)* pszProxyBypassW, uint dwFlags);

@DllImport("WINHTTP")
BOOL WinHttpCloseHandle(void* hInternet);

@DllImport("WINHTTP")
void* WinHttpConnect(void* hSession, const(wchar)* pswzServerName, ushort nServerPort, uint dwReserved);

@DllImport("WINHTTP")
BOOL WinHttpReadData(void* hRequest, char* lpBuffer, uint dwNumberOfBytesToRead, uint* lpdwNumberOfBytesRead);

@DllImport("WINHTTP")
BOOL WinHttpWriteData(void* hRequest, char* lpBuffer, uint dwNumberOfBytesToWrite, uint* lpdwNumberOfBytesWritten);

@DllImport("WINHTTP")
BOOL WinHttpQueryDataAvailable(void* hRequest, uint* lpdwNumberOfBytesAvailable);

@DllImport("WINHTTP")
BOOL WinHttpQueryOption(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WINHTTP")
BOOL WinHttpSetOption(void* hInternet, uint dwOption, char* lpBuffer, uint dwBufferLength);

@DllImport("WINHTTP")
BOOL WinHttpSetTimeouts(void* hInternet, int nResolveTimeout, int nConnectTimeout, int nSendTimeout, 
                        int nReceiveTimeout);

@DllImport("WINHTTP")
void* WinHttpOpenRequest(void* hConnect, const(wchar)* pwszVerb, const(wchar)* pwszObjectName, 
                         const(wchar)* pwszVersion, const(wchar)* pwszReferrer, ushort** ppwszAcceptTypes, 
                         uint dwFlags);

@DllImport("WINHTTP")
BOOL WinHttpAddRequestHeaders(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WINHTTP")
uint WinHttpAddRequestHeadersEx(void* hRequest, uint dwModifiers, ulong ullFlags, ulong ullExtra, uint cHeaders, 
                                char* pHeaders);

@DllImport("WINHTTP")
BOOL WinHttpSendRequest(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, char* lpOptional, 
                        uint dwOptionalLength, uint dwTotalLength, size_t dwContext);

@DllImport("WINHTTP")
BOOL WinHttpSetCredentials(void* hRequest, uint AuthTargets, uint AuthScheme, const(wchar)* pwszUserName, 
                           const(wchar)* pwszPassword, void* pAuthParams);

@DllImport("WINHTTP")
BOOL WinHttpQueryAuthSchemes(void* hRequest, uint* lpdwSupportedSchemes, uint* lpdwFirstScheme, 
                             uint* pdwAuthTarget);

@DllImport("WINHTTP")
BOOL WinHttpReceiveResponse(void* hRequest, void* lpReserved);

@DllImport("WINHTTP")
BOOL WinHttpQueryHeaders(void* hRequest, uint dwInfoLevel, const(wchar)* pwszName, char* lpBuffer, 
                         uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WINHTTP")
BOOL WinHttpDetectAutoProxyConfigUrl(uint dwAutoDetectFlags, ushort** ppwstrAutoConfigUrl);

@DllImport("WINHTTP")
BOOL WinHttpGetProxyForUrl(void* hSession, const(wchar)* lpcwszUrl, WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, 
                           WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP")
uint WinHttpCreateProxyResolver(void* hSession, void** phResolver);

@DllImport("WINHTTP")
uint WinHttpGetProxyForUrlEx(void* hResolver, const(wchar)* pcwszUrl, WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, 
                             size_t pContext);

@DllImport("WINHTTP")
uint WinHttpGetProxyForUrlEx2(void* hResolver, const(wchar)* pcwszUrl, 
                              WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, uint cbInterfaceSelectionContext, 
                              char* pInterfaceSelectionContext, size_t pContext);

@DllImport("WINHTTP")
uint WinHttpGetProxyResult(void* hResolver, WINHTTP_PROXY_RESULT* pProxyResult);

@DllImport("WINHTTP")
uint WinHttpGetProxyResultEx(void* hResolver, WINHTTP_PROXY_RESULT_EX* pProxyResultEx);

@DllImport("WINHTTP")
void WinHttpFreeProxyResult(WINHTTP_PROXY_RESULT* pProxyResult);

@DllImport("WINHTTP")
void WinHttpFreeProxyResultEx(WINHTTP_PROXY_RESULT_EX* pProxyResultEx);

@DllImport("WINHTTP")
uint WinHttpResetAutoProxy(void* hSession, uint dwFlags);

@DllImport("WINHTTP")
BOOL WinHttpGetIEProxyConfigForCurrentUser(WINHTTP_CURRENT_USER_IE_PROXY_CONFIG* pProxyConfig);

@DllImport("WINHTTP")
uint WinHttpWriteProxySettings(void* hSession, BOOL fForceUpdate, WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP")
uint WinHttpReadProxySettings(void* hSession, const(wchar)* pcwszConnectionName, BOOL fFallBackToDefaultSettings, 
                              BOOL fSetAutoDiscoverForDefaultSettings, uint* pdwSettingsVersion, 
                              int* pfDefaultSettingsAreReturned, WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP")
void WinHttpFreeProxySettings(WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP")
uint WinHttpGetProxySettingsVersion(void* hSession, uint* pdwProxySettingsVersion);

@DllImport("WINHTTP")
uint WinHttpSetProxySettingsPerUser(BOOL fProxySettingsPerUser);

@DllImport("WINHTTP")
void* WinHttpWebSocketCompleteUpgrade(void* hRequest, size_t pContext);

@DllImport("WINHTTP")
uint WinHttpWebSocketSend(void* hWebSocket, WINHTTP_WEB_SOCKET_BUFFER_TYPE eBufferType, char* pvBuffer, 
                          uint dwBufferLength);

@DllImport("WINHTTP")
uint WinHttpWebSocketReceive(void* hWebSocket, char* pvBuffer, uint dwBufferLength, uint* pdwBytesRead, 
                             WINHTTP_WEB_SOCKET_BUFFER_TYPE* peBufferType);

@DllImport("WINHTTP")
uint WinHttpWebSocketShutdown(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WINHTTP")
uint WinHttpWebSocketClose(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WINHTTP")
uint WinHttpWebSocketQueryCloseStatus(void* hWebSocket, ushort* pusStatus, char* pvReason, uint dwReasonLength, 
                                      uint* pdwReasonLengthConsumed);


