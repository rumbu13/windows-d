module windows.http;

public import system;
public import windows.networkdrivers;
public import windows.systemservices;
public import windows.wininet;
public import windows.winsock;
public import windows.windowsprogramming;

extern(Windows):

enum HTTP_SERVER_PROPERTY
{
    HttpServerAuthenticationProperty = 0,
    HttpServerLoggingProperty = 1,
    HttpServerQosProperty = 2,
    HttpServerTimeoutsProperty = 3,
    HttpServerQueueLengthProperty = 4,
    HttpServerStateProperty = 5,
    HttpServer503VerbosityProperty = 6,
    HttpServerBindingProperty = 7,
    HttpServerExtendedAuthenticationProperty = 8,
    HttpServerListenEndpointProperty = 9,
    HttpServerChannelBindProperty = 10,
    HttpServerProtectionLevelProperty = 11,
}

struct HTTP_PROPERTY_FLAGS
{
    uint _bitfield;
}

enum HTTP_ENABLED_STATE
{
    HttpEnabledStateActive = 0,
    HttpEnabledStateInactive = 1,
}

struct HTTP_STATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HTTP_ENABLED_STATE State;
}

enum HTTP_503_RESPONSE_VERBOSITY
{
    Http503ResponseVerbosityBasic = 0,
    Http503ResponseVerbosityLimited = 1,
    Http503ResponseVerbosityFull = 2,
}

enum HTTP_QOS_SETTING_TYPE
{
    HttpQosSettingTypeBandwidth = 0,
    HttpQosSettingTypeConnectionLimit = 1,
    HttpQosSettingTypeFlowRate = 2,
}

struct HTTP_QOS_SETTING_INFO
{
    HTTP_QOS_SETTING_TYPE QosType;
    void* QosSetting;
}

struct HTTP_CONNECTION_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint MaxConnections;
}

struct HTTP_BANDWIDTH_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint MaxBandwidth;
}

struct HTTP_FLOWRATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint MaxBandwidth;
    uint MaxPeakBandwidth;
    uint BurstSize;
}

enum HTTP_SERVICE_CONFIG_TIMEOUT_KEY
{
    IdleConnectionTimeout = 0,
    HeaderWaitTimeout = 1,
}

struct HTTP_SERVICE_CONFIG_TIMEOUT_SET
{
    HTTP_SERVICE_CONFIG_TIMEOUT_KEY KeyDesc;
    ushort ParamDesc;
}

struct HTTP_TIMEOUT_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    ushort EntityBody;
    ushort DrainEntityBody;
    ushort RequestQueue;
    ushort IdleConnection;
    ushort HeaderWait;
    uint MinSendRate;
}

enum HTTP_SERVICE_CONFIG_SETTING_KEY
{
    HttpNone = 0,
    HttpTlsThrottle = 1,
}

struct HTTP_SERVICE_CONFIG_SETTING_SET
{
    HTTP_SERVICE_CONFIG_SETTING_KEY KeyDesc;
    uint ParamDesc;
}

struct HTTP_LISTEN_ENDPOINT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    ubyte EnableSharing;
}

struct HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
{
    ushort DomainNameLength;
    const(wchar)* DomainName;
    ushort RealmLength;
    const(wchar)* Realm;
}

struct HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
{
    ushort RealmLength;
    const(wchar)* Realm;
}

struct HTTP_SERVER_AUTHENTICATION_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint AuthSchemes;
    ubyte ReceiveMutualAuth;
    ubyte ReceiveContextHandle;
    ubyte DisableNTLMCredentialCaching;
    ubyte ExFlags;
    HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS DigestParams;
    HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS BasicParams;
}

enum HTTP_SERVICE_BINDING_TYPE
{
    HttpServiceBindingTypeNone = 0,
    HttpServiceBindingTypeW = 1,
    HttpServiceBindingTypeA = 2,
}

struct HTTP_SERVICE_BINDING_BASE
{
    HTTP_SERVICE_BINDING_TYPE Type;
}

struct HTTP_SERVICE_BINDING_A
{
    HTTP_SERVICE_BINDING_BASE Base;
    const(char)* Buffer;
    uint BufferSize;
}

struct HTTP_SERVICE_BINDING_W
{
    HTTP_SERVICE_BINDING_BASE Base;
    const(wchar)* Buffer;
    uint BufferSize;
}

enum HTTP_AUTHENTICATION_HARDENING_LEVELS
{
    HttpAuthenticationHardeningLegacy = 0,
    HttpAuthenticationHardeningMedium = 1,
    HttpAuthenticationHardeningStrict = 2,
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
    uint ChannelTokenSize;
    uint Flags;
}

struct HTTP_REQUEST_TOKEN_BINDING_INFO
{
    ubyte* TokenBinding;
    uint TokenBindingSize;
    ubyte* EKM;
    uint EKMSize;
    ubyte KeyType;
}

enum HTTP_LOGGING_TYPE
{
    HttpLoggingTypeW3C = 0,
    HttpLoggingTypeIIS = 1,
    HttpLoggingTypeNCSA = 2,
    HttpLoggingTypeRaw = 3,
}

enum HTTP_LOGGING_ROLLOVER_TYPE
{
    HttpLoggingRolloverSize = 0,
    HttpLoggingRolloverDaily = 1,
    HttpLoggingRolloverWeekly = 2,
    HttpLoggingRolloverMonthly = 3,
    HttpLoggingRolloverHourly = 4,
}

struct HTTP_LOGGING_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint LoggingFlags;
    const(wchar)* SoftwareName;
    ushort SoftwareNameLength;
    ushort DirectoryNameLength;
    const(wchar)* DirectoryName;
    HTTP_LOGGING_TYPE Format;
    uint Fields;
    void* pExtFields;
    ushort NumOfExtFields;
    ushort MaxRecordSize;
    HTTP_LOGGING_ROLLOVER_TYPE RolloverType;
    uint RolloverSize;
    void* pSecurityDescriptor;
}

struct HTTP_BINDING_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HANDLE RequestQueueHandle;
}

enum HTTP_PROTECTION_LEVEL_TYPE
{
    HttpProtectionLevelUnrestricted = 0,
    HttpProtectionLevelEdgeRestricted = 1,
    HttpProtectionLevelRestricted = 2,
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

enum _HTTP_URI_SCHEME
{
    HttpSchemeHttp = 0,
    HttpSchemeHttps = 1,
    HttpSchemeMaximum = 2,
}

enum HTTP_VERB
{
    HttpVerbUnparsed = 0,
    HttpVerbUnknown = 1,
    HttpVerbInvalid = 2,
    HttpVerbOPTIONS = 3,
    HttpVerbGET = 4,
    HttpVerbHEAD = 5,
    HttpVerbPOST = 6,
    HttpVerbPUT = 7,
    HttpVerbDELETE = 8,
    HttpVerbTRACE = 9,
    HttpVerbCONNECT = 10,
    HttpVerbTRACK = 11,
    HttpVerbMOVE = 12,
    HttpVerbCOPY = 13,
    HttpVerbPROPFIND = 14,
    HttpVerbPROPPATCH = 15,
    HttpVerbMKCOL = 16,
    HttpVerbLOCK = 17,
    HttpVerbUNLOCK = 18,
    HttpVerbSEARCH = 19,
    HttpVerbMaximum = 20,
}

enum HTTP_HEADER_ID
{
    HttpHeaderCacheControl = 0,
    HttpHeaderConnection = 1,
    HttpHeaderDate = 2,
    HttpHeaderKeepAlive = 3,
    HttpHeaderPragma = 4,
    HttpHeaderTrailer = 5,
    HttpHeaderTransferEncoding = 6,
    HttpHeaderUpgrade = 7,
    HttpHeaderVia = 8,
    HttpHeaderWarning = 9,
    HttpHeaderAllow = 10,
    HttpHeaderContentLength = 11,
    HttpHeaderContentType = 12,
    HttpHeaderContentEncoding = 13,
    HttpHeaderContentLanguage = 14,
    HttpHeaderContentLocation = 15,
    HttpHeaderContentMd5 = 16,
    HttpHeaderContentRange = 17,
    HttpHeaderExpires = 18,
    HttpHeaderLastModified = 19,
    HttpHeaderAccept = 20,
    HttpHeaderAcceptCharset = 21,
    HttpHeaderAcceptEncoding = 22,
    HttpHeaderAcceptLanguage = 23,
    HttpHeaderAuthorization = 24,
    HttpHeaderCookie = 25,
    HttpHeaderExpect = 26,
    HttpHeaderFrom = 27,
    HttpHeaderHost = 28,
    HttpHeaderIfMatch = 29,
    HttpHeaderIfModifiedSince = 30,
    HttpHeaderIfNoneMatch = 31,
    HttpHeaderIfRange = 32,
    HttpHeaderIfUnmodifiedSince = 33,
    HttpHeaderMaxForwards = 34,
    HttpHeaderProxyAuthorization = 35,
    HttpHeaderReferer = 36,
    HttpHeaderRange = 37,
    HttpHeaderTe = 38,
    HttpHeaderTranslate = 39,
    HttpHeaderUserAgent = 40,
    HttpHeaderRequestMaximum = 41,
    HttpHeaderAcceptRanges = 20,
    HttpHeaderAge = 21,
    HttpHeaderEtag = 22,
    HttpHeaderLocation = 23,
    HttpHeaderProxyAuthenticate = 24,
    HttpHeaderRetryAfter = 25,
    HttpHeaderServer = 26,
    HttpHeaderSetCookie = 27,
    HttpHeaderVary = 28,
    HttpHeaderWwwAuthenticate = 29,
    HttpHeaderResponseMaximum = 30,
    HttpHeaderMaximum = 41,
}

struct HTTP_KNOWN_HEADER
{
    ushort RawValueLength;
    const(char)* pRawValue;
}

struct HTTP_UNKNOWN_HEADER
{
    ushort NameLength;
    ushort RawValueLength;
    const(char)* pName;
    const(char)* pRawValue;
}

enum HTTP_LOG_DATA_TYPE
{
    HttpLogDataTypeFields = 0,
}

struct HTTP_LOG_DATA
{
    HTTP_LOG_DATA_TYPE Type;
}

struct HTTP_LOG_FIELDS_DATA
{
    HTTP_LOG_DATA Base;
    ushort UserNameLength;
    ushort UriStemLength;
    ushort ClientIpLength;
    ushort ServerNameLength;
    ushort ServiceNameLength;
    ushort ServerIpLength;
    ushort MethodLength;
    ushort UriQueryLength;
    ushort HostLength;
    ushort UserAgentLength;
    ushort CookieLength;
    ushort ReferrerLength;
    const(wchar)* UserName;
    const(wchar)* UriStem;
    const(char)* ClientIp;
    const(char)* ServerName;
    const(char)* ServiceName;
    const(char)* ServerIp;
    const(char)* Method;
    const(char)* UriQuery;
    const(char)* Host;
    const(char)* UserAgent;
    const(char)* Cookie;
    const(char)* Referrer;
    ushort ServerPort;
    ushort ProtocolStatus;
    uint Win32Status;
    HTTP_VERB MethodNum;
    ushort SubStatus;
}

enum HTTP_DATA_CHUNK_TYPE
{
    HttpDataChunkFromMemory = 0,
    HttpDataChunkFromFileHandle = 1,
    HttpDataChunkFromFragmentCache = 2,
    HttpDataChunkFromFragmentCacheEx = 3,
    HttpDataChunkMaximum = 4,
}

struct HTTP_DATA_CHUNK
{
    HTTP_DATA_CHUNK_TYPE DataChunkType;
    _Anonymous_e__Union Anonymous;
}

struct HTTP_REQUEST_HEADERS
{
    ushort UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER KnownHeaders;
}

struct HTTP_RESPONSE_HEADERS
{
    ushort UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER KnownHeaders;
}

enum HTTP_DELEGATE_REQUEST_PROPERTY_ID
{
    DelegateRequestReservedProperty = 0,
}

struct HTTP_DELEGATE_REQUEST_PROPERTY_INFO
{
    HTTP_DELEGATE_REQUEST_PROPERTY_ID ProperyId;
    uint PropertyInfoLength;
    void* PropertyInfo;
}

struct HTTP_TRANSPORT_ADDRESS
{
    SOCKADDR* pRemoteAddress;
    SOCKADDR* pLocalAddress;
}

struct HTTP_COOKED_URL
{
    ushort FullUrlLength;
    ushort HostLength;
    ushort AbsPathLength;
    ushort QueryStringLength;
    const(wchar)* pFullUrl;
    const(wchar)* pHost;
    const(wchar)* pAbsPath;
    const(wchar)* pQueryString;
}

enum HTTP_AUTH_STATUS
{
    HttpAuthStatusSuccess = 0,
    HttpAuthStatusNotAuthenticated = 1,
    HttpAuthStatusFailure = 2,
}

enum HTTP_REQUEST_AUTH_TYPE
{
    HttpRequestAuthTypeNone = 0,
    HttpRequestAuthTypeBasic = 1,
    HttpRequestAuthTypeDigest = 2,
    HttpRequestAuthTypeNTLM = 3,
    HttpRequestAuthTypeNegotiate = 4,
    HttpRequestAuthTypeKerberos = 5,
}

struct HTTP_SSL_CLIENT_CERT_INFO
{
    uint CertFlags;
    uint CertEncodedSize;
    ubyte* pCertEncoded;
    HANDLE Token;
    ubyte CertDeniedByMapper;
}

struct HTTP_SSL_INFO
{
    ushort ServerCertKeySize;
    ushort ConnectionKeySize;
    uint ServerCertIssuerSize;
    uint ServerCertSubjectSize;
    const(char)* pServerCertIssuer;
    const(char)* pServerCertSubject;
    HTTP_SSL_CLIENT_CERT_INFO* pClientCertInfo;
    uint SslClientCertNegotiated;
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

enum HTTP_REQUEST_SIZING_TYPE
{
    HttpRequestSizingTypeTlsHandshakeLeg1ClientData = 0,
    HttpRequestSizingTypeTlsHandshakeLeg1ServerData = 1,
    HttpRequestSizingTypeTlsHandshakeLeg2ClientData = 2,
    HttpRequestSizingTypeTlsHandshakeLeg2ServerData = 3,
    HttpRequestSizingTypeHeaders = 4,
    HttpRequestSizingTypeMax = 5,
}

struct HTTP_REQUEST_SIZING_INFO
{
    ulong Flags;
    uint RequestIndex;
    uint RequestSizingCount;
    ulong RequestSizing;
}

enum HTTP_REQUEST_TIMING_TYPE
{
    HttpRequestTimingTypeConnectionStart = 0,
    HttpRequestTimingTypeDataStart = 1,
    HttpRequestTimingTypeTlsCertificateLoadStart = 2,
    HttpRequestTimingTypeTlsCertificateLoadEnd = 3,
    HttpRequestTimingTypeTlsHandshakeLeg1Start = 4,
    HttpRequestTimingTypeTlsHandshakeLeg1End = 5,
    HttpRequestTimingTypeTlsHandshakeLeg2Start = 6,
    HttpRequestTimingTypeTlsHandshakeLeg2End = 7,
    HttpRequestTimingTypeTlsAttributesQueryStart = 8,
    HttpRequestTimingTypeTlsAttributesQueryEnd = 9,
    HttpRequestTimingTypeTlsClientCertQueryStart = 10,
    HttpRequestTimingTypeTlsClientCertQueryEnd = 11,
    HttpRequestTimingTypeHttp2StreamStart = 12,
    HttpRequestTimingTypeHttp2HeaderDecodeStart = 13,
    HttpRequestTimingTypeHttp2HeaderDecodeEnd = 14,
    HttpRequestTimingTypeRequestHeaderParseStart = 15,
    HttpRequestTimingTypeRequestHeaderParseEnd = 16,
    HttpRequestTimingTypeRequestRoutingStart = 17,
    HttpRequestTimingTypeRequestRoutingEnd = 18,
    HttpRequestTimingTypeRequestQueuedForInspection = 19,
    HttpRequestTimingTypeRequestDeliveredForInspection = 20,
    HttpRequestTimingTypeRequestReturnedAfterInspection = 21,
    HttpRequestTimingTypeRequestQueuedForDelegation = 22,
    HttpRequestTimingTypeRequestDeliveredForDelegation = 23,
    HttpRequestTimingTypeRequestReturnedAfterDelegation = 24,
    HttpRequestTimingTypeRequestQueuedForIO = 25,
    HttpRequestTimingTypeRequestDeliveredForIO = 26,
    HttpRequestTimingTypeHttp3StreamStart = 27,
    HttpRequestTimingTypeHttp3HeaderDecodeStart = 28,
    HttpRequestTimingTypeHttp3HeaderDecodeEnd = 29,
    HttpRequestTimingTypeMax = 30,
}

struct HTTP_REQUEST_TIMING_INFO
{
    uint RequestTimingCount;
    ulong RequestTiming;
}

enum HTTP_REQUEST_INFO_TYPE
{
    HttpRequestInfoTypeAuth = 0,
    HttpRequestInfoTypeChannelBind = 1,
    HttpRequestInfoTypeSslProtocol = 2,
    HttpRequestInfoTypeSslTokenBindingDraft = 3,
    HttpRequestInfoTypeSslTokenBinding = 4,
    HttpRequestInfoTypeRequestTiming = 5,
    HttpRequestInfoTypeTcpInfoV0 = 6,
    HttpRequestInfoTypeRequestSizing = 7,
    HttpRequestInfoTypeQuicStats = 8,
    HttpRequestInfoTypeTcpInfoV1 = 9,
}

struct HTTP_REQUEST_INFO
{
    HTTP_REQUEST_INFO_TYPE InfoType;
    uint InfoLength;
    void* pInfo;
}

struct HTTP_REQUEST_AUTH_INFO
{
    HTTP_AUTH_STATUS AuthStatus;
    int SecStatus;
    uint Flags;
    HTTP_REQUEST_AUTH_TYPE AuthType;
    HANDLE AccessToken;
    uint ContextAttributes;
    uint PackedContextLength;
    uint PackedContextType;
    void* PackedContext;
    uint MutualAuthDataLength;
    const(char)* pMutualAuthData;
    ushort PackageNameLength;
    const(wchar)* pPackageName;
}

struct HTTP_REQUEST_V1
{
    uint Flags;
    ulong ConnectionId;
    ulong RequestId;
    ulong UrlContext;
    HTTP_VERSION Version;
    HTTP_VERB Verb;
    ushort UnknownVerbLength;
    ushort RawUrlLength;
    const(char)* pUnknownVerb;
    const(char)* pRawUrl;
    HTTP_COOKED_URL CookedUrl;
    HTTP_TRANSPORT_ADDRESS Address;
    HTTP_REQUEST_HEADERS Headers;
    ulong BytesReceived;
    ushort EntityChunkCount;
    HTTP_DATA_CHUNK* pEntityChunks;
    ulong RawConnectionId;
    HTTP_SSL_INFO* pSslInfo;
}

struct HTTP_REQUEST_V2
{
    HTTP_REQUEST_V1 __AnonymousBase_http_L1816_C35;
    ushort RequestInfoCount;
    HTTP_REQUEST_INFO* pRequestInfo;
}

struct HTTP_RESPONSE_V1
{
    uint Flags;
    HTTP_VERSION Version;
    ushort StatusCode;
    ushort ReasonLength;
    const(char)* pReason;
    HTTP_RESPONSE_HEADERS Headers;
    ushort EntityChunkCount;
    HTTP_DATA_CHUNK* pEntityChunks;
}

enum HTTP_RESPONSE_INFO_TYPE
{
    HttpResponseInfoTypeMultipleKnownHeaders = 0,
    HttpResponseInfoTypeAuthenticationProperty = 1,
    HttpResponseInfoTypeQoSProperty = 2,
    HttpResponseInfoTypeChannelBind = 3,
}

struct HTTP_RESPONSE_INFO
{
    HTTP_RESPONSE_INFO_TYPE Type;
    uint Length;
    void* pInfo;
}

struct HTTP_MULTIPLE_KNOWN_HEADERS
{
    HTTP_HEADER_ID HeaderId;
    uint Flags;
    ushort KnownHeaderCount;
    HTTP_KNOWN_HEADER* KnownHeaders;
}

struct HTTP_RESPONSE_V2
{
    HTTP_RESPONSE_V1 __AnonymousBase_http_L2003_C36;
    ushort ResponseInfoCount;
    HTTP_RESPONSE_INFO* pResponseInfo;
}

struct HTTPAPI_VERSION
{
    ushort HttpApiMajorVersion;
    ushort HttpApiMinorVersion;
}

enum HTTP_CACHE_POLICY_TYPE
{
    HttpCachePolicyNocache = 0,
    HttpCachePolicyUserInvalidates = 1,
    HttpCachePolicyTimeToLive = 2,
    HttpCachePolicyMaximum = 3,
}

struct HTTP_CACHE_POLICY
{
    HTTP_CACHE_POLICY_TYPE Policy;
    uint SecondsToLive;
}

enum HTTP_SERVICE_CONFIG_ID
{
    HttpServiceConfigIPListenList = 0,
    HttpServiceConfigSSLCertInfo = 1,
    HttpServiceConfigUrlAclInfo = 2,
    HttpServiceConfigTimeout = 3,
    HttpServiceConfigCache = 4,
    HttpServiceConfigSslSniCertInfo = 5,
    HttpServiceConfigSslCcsCertInfo = 6,
    HttpServiceConfigSetting = 7,
    HttpServiceConfigSslCertInfoEx = 8,
    HttpServiceConfigSslSniCertInfoEx = 9,
    HttpServiceConfigSslCcsCertInfoEx = 10,
    HttpServiceConfigSslScopedCcsCertInfo = 11,
    HttpServiceConfigSslScopedCcsCertInfoEx = 12,
    HttpServiceConfigMax = 13,
}

enum HTTP_SERVICE_CONFIG_QUERY_TYPE
{
    HttpServiceConfigQueryExact = 0,
    HttpServiceConfigQueryNext = 1,
    HttpServiceConfigQueryMax = 2,
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
    const(wchar)* Host;
}

struct HTTP_SERVICE_CONFIG_SSL_CCS_KEY
{
    SOCKADDR_STORAGE_LH LocalAddress;
}

struct HTTP_SERVICE_CONFIG_SSL_PARAM
{
    uint SslHashLength;
    void* pSslHash;
    Guid AppId;
    const(wchar)* pSslCertStoreName;
    uint DefaultCertCheckMode;
    uint DefaultRevocationFreshnessTime;
    uint DefaultRevocationUrlRetrievalTimeout;
    const(wchar)* pDefaultSslCtlIdentifier;
    const(wchar)* pDefaultSslCtlStoreName;
    uint DefaultFlags;
}

enum HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE
{
    ExParamTypeHttp2Window = 0,
    ExParamTypeHttp2SettingsLimits = 1,
    ExParamTypeHttpPerformance = 2,
    ExParamTypeMax = 3,
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
    uint MaxBufferedSendBytes;
    uint MaxConcurrentClientStreams;
}

struct HTTP_SERVICE_CONFIG_SSL_PARAM_EX
{
    HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE ParamType;
    ulong Flags;
    _Anonymous_e__Union Anonymous;
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
    ushort AddrLength;
    SOCKADDR* pAddress;
}

struct HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY
{
    uint AddrCount;
    SOCKADDR_STORAGE_LH AddrList;
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

enum HTTP_SERVICE_CONFIG_CACHE_KEY
{
    MaxCacheResponseSize = 0,
    CacheRangeChunkSize = 1,
}

struct HTTP_SERVICE_CONFIG_CACHE_SET
{
    HTTP_SERVICE_CONFIG_CACHE_KEY KeyDesc;
    uint ParamDesc;
}

enum HTTP_REQUEST_PROPERTY
{
    HttpRequestPropertyIsb = 0,
    HttpRequestPropertyTcpInfoV0 = 1,
    HttpRequestPropertyQuicStats = 2,
    HttpRequestPropertyTcpInfoV1 = 3,
    HttpRequestPropertySni = 4,
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
    ushort Hostname;
    uint Flags;
}

struct WINHTTP_ASYNC_RESULT
{
    uint dwResult;
    uint dwError;
}

struct URL_COMPONENTS
{
    uint dwStructSize;
    const(wchar)* lpszScheme;
    uint dwSchemeLength;
    INTERNET_SCHEME nScheme;
    const(wchar)* lpszHostName;
    uint dwHostNameLength;
    ushort nPort;
    const(wchar)* lpszUserName;
    uint dwUserNameLength;
    const(wchar)* lpszPassword;
    uint dwPasswordLength;
    const(wchar)* lpszUrlPath;
    uint dwUrlPathLength;
    const(wchar)* lpszExtraInfo;
    uint dwExtraInfoLength;
}

struct WINHTTP_PROXY_INFO
{
    uint dwAccessType;
    const(wchar)* lpszProxy;
    const(wchar)* lpszProxyBypass;
}

struct WINHTTP_AUTOPROXY_OPTIONS
{
    uint dwFlags;
    uint dwAutoDetectFlags;
    const(wchar)* lpszAutoConfigUrl;
    void* lpvReserved;
    uint dwReserved;
    BOOL fAutoLogonIfChallenged;
}

struct WINHTTP_PROXY_RESULT_ENTRY
{
    BOOL fProxy;
    BOOL fBypass;
    INTERNET_SCHEME ProxyScheme;
    const(wchar)* pwszProxy;
    ushort ProxyPort;
}

struct WINHTTP_PROXY_RESULT
{
    uint cEntries;
    WINHTTP_PROXY_RESULT_ENTRY* pEntries;
}

struct WINHTTP_PROXY_RESULT_EX
{
    uint cEntries;
    WINHTTP_PROXY_RESULT_ENTRY* pEntries;
    HANDLE hProxyDetectionHandle;
    uint dwProxyInterfaceAffinity;
}

struct _WinHttpProxyNetworkKey
{
    ubyte pbBuffer;
}

struct WINHTTP_PROXY_SETTINGS
{
    uint dwStructSize;
    uint dwFlags;
    uint dwCurrentSettingsVersion;
    const(wchar)* pwszConnectionName;
    const(wchar)* pwszProxy;
    const(wchar)* pwszProxyBypass;
    const(wchar)* pwszAutoconfigUrl;
    const(wchar)* pwszAutoconfigSecondaryUrl;
    uint dwAutoDiscoveryFlags;
    const(wchar)* pwszLastKnownGoodAutoConfigUrl;
    uint dwAutoconfigReloadDelayMins;
    FILETIME ftLastKnownDetectTime;
    uint dwDetectedInterfaceIpCount;
    uint* pdwDetectedInterfaceIp;
    uint cNetworkKeys;
    _WinHttpProxyNetworkKey* pNetworkKeys;
}

struct WINHTTP_CERTIFICATE_INFO
{
    FILETIME ftExpiry;
    FILETIME ftStart;
    const(wchar)* lpszSubjectInfo;
    const(wchar)* lpszIssuerInfo;
    const(wchar)* lpszProtocolName;
    const(wchar)* lpszSignatureAlgName;
    const(wchar)* lpszEncryptionAlgName;
    uint dwKeySize;
}

struct WINHTTP_CONNECTION_INFO
{
    uint cbSize;
    SOCKADDR_STORAGE_LH LocalAddress;
    SOCKADDR_STORAGE_LH RemoteAddress;
}

enum WINHTTP_REQUEST_TIME_ENTRY
{
    WinHttpProxyDetectionStart = 0,
    WinHttpProxyDetectionEnd = 1,
    WinHttpConnectionAcquireStart = 2,
    WinHttpConnectionAcquireWaitEnd = 3,
    WinHttpConnectionAcquireEnd = 4,
    WinHttpNameResolutionStart = 5,
    WinHttpNameResolutionEnd = 6,
    WinHttpConnectionEstablishmentStart = 7,
    WinHttpConnectionEstablishmentEnd = 8,
    WinHttpTlsHandshakeClientLeg1Start = 9,
    WinHttpTlsHandshakeClientLeg1End = 10,
    WinHttpTlsHandshakeClientLeg2Start = 11,
    WinHttpTlsHandshakeClientLeg2End = 12,
    WinHttpTlsHandshakeClientLeg3Start = 13,
    WinHttpTlsHandshakeClientLeg3End = 14,
    WinHttpStreamWaitStart = 15,
    WinHttpStreamWaitEnd = 16,
    WinHttpSendRequestStart = 17,
    WinHttpSendRequestHeadersCompressionStart = 18,
    WinHttpSendRequestHeadersCompressionEnd = 19,
    WinHttpSendRequestHeadersEnd = 20,
    WinHttpSendRequestEnd = 21,
    WinHttpReceiveResponseStart = 22,
    WinHttpReceiveResponseHeadersDecompressionStart = 23,
    WinHttpReceiveResponseHeadersDecompressionEnd = 24,
    WinHttpReceiveResponseHeadersEnd = 25,
    WinHttpReceiveResponseBodyDecompressionDelta = 26,
    WinHttpReceiveResponseEnd = 27,
    WinHttpProxyTunnelStart = 28,
    WinHttpProxyTunnelEnd = 29,
    WinHttpProxyTlsHandshakeClientLeg1Start = 30,
    WinHttpProxyTlsHandshakeClientLeg1End = 31,
    WinHttpProxyTlsHandshakeClientLeg2Start = 32,
    WinHttpProxyTlsHandshakeClientLeg2End = 33,
    WinHttpProxyTlsHandshakeClientLeg3Start = 34,
    WinHttpProxyTlsHandshakeClientLeg3End = 35,
    WinHttpRequestTimeLast = 36,
    WinHttpRequestTimeMax = 64,
}

struct WINHTTP_REQUEST_TIMES
{
    uint cTimes;
    ulong rgullTimes;
}

enum WINHTTP_REQUEST_STAT_ENTRY
{
    WinHttpConnectFailureCount = 0,
    WinHttpProxyFailureCount = 1,
    WinHttpTlsHandshakeClientLeg1Size = 2,
    WinHttpTlsHandshakeServerLeg1Size = 3,
    WinHttpTlsHandshakeClientLeg2Size = 4,
    WinHttpTlsHandshakeServerLeg2Size = 5,
    WinHttpRequestHeadersSize = 6,
    WinHttpRequestHeadersCompressedSize = 7,
    WinHttpResponseHeadersSize = 8,
    WinHttpResponseHeadersCompressedSize = 9,
    WinHttpResponseBodySize = 10,
    WinHttpResponseBodyCompressedSize = 11,
    WinHttpProxyTlsHandshakeClientLeg1Size = 12,
    WinHttpProxyTlsHandshakeServerLeg1Size = 13,
    WinHttpProxyTlsHandshakeClientLeg2Size = 14,
    WinHttpProxyTlsHandshakeServerLeg2Size = 15,
    WinHttpRequestStatLast = 16,
    WinHttpRequestStatMax = 32,
}

struct WINHTTP_REQUEST_STATS
{
    ulong ullFlags;
    uint ulIndex;
    uint cStats;
    ulong rgullStats;
}

struct WINHTTP_EXTENDED_HEADER
{
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
}

struct WINHTTP_CREDS
{
    const(char)* lpszUserName;
    const(char)* lpszPassword;
    const(char)* lpszRealm;
    uint dwAuthScheme;
    const(char)* lpszHostName;
    uint dwPort;
}

struct WINHTTP_CREDS_EX
{
    const(char)* lpszUserName;
    const(char)* lpszPassword;
    const(char)* lpszRealm;
    uint dwAuthScheme;
    const(char)* lpszHostName;
    uint dwPort;
    const(char)* lpszUrl;
}

alias WINHTTP_STATUS_CALLBACK = extern(Windows) void function(void* hInternet, uint dwContext, uint dwInternetStatus, void* lpvStatusInformation, uint dwStatusInformationLength);
alias LPWINHTTP_STATUS_CALLBACK = extern(Windows) void function();
struct WINHTTP_CURRENT_USER_IE_PROXY_CONFIG
{
    BOOL fAutoDetect;
    const(wchar)* lpszAutoConfigUrl;
    const(wchar)* lpszProxy;
    const(wchar)* lpszProxyBypass;
}

enum WINHTTP_WEB_SOCKET_OPERATION
{
    WINHTTP_WEB_SOCKET_SEND_OPERATION = 0,
    WINHTTP_WEB_SOCKET_RECEIVE_OPERATION = 1,
    WINHTTP_WEB_SOCKET_CLOSE_OPERATION = 2,
    WINHTTP_WEB_SOCKET_SHUTDOWN_OPERATION = 3,
}

enum WINHTTP_WEB_SOCKET_BUFFER_TYPE
{
    WINHTTP_WEB_SOCKET_BINARY_MESSAGE_BUFFER_TYPE = 0,
    WINHTTP_WEB_SOCKET_BINARY_FRAGMENT_BUFFER_TYPE = 1,
    WINHTTP_WEB_SOCKET_UTF8_MESSAGE_BUFFER_TYPE = 2,
    WINHTTP_WEB_SOCKET_UTF8_FRAGMENT_BUFFER_TYPE = 3,
    WINHTTP_WEB_SOCKET_CLOSE_BUFFER_TYPE = 4,
}

enum WINHTTP_WEB_SOCKET_CLOSE_STATUS
{
    WINHTTP_WEB_SOCKET_SUCCESS_CLOSE_STATUS = 1000,
    WINHTTP_WEB_SOCKET_ENDPOINT_TERMINATED_CLOSE_STATUS = 1001,
    WINHTTP_WEB_SOCKET_PROTOCOL_ERROR_CLOSE_STATUS = 1002,
    WINHTTP_WEB_SOCKET_INVALID_DATA_TYPE_CLOSE_STATUS = 1003,
    WINHTTP_WEB_SOCKET_EMPTY_CLOSE_STATUS = 1005,
    WINHTTP_WEB_SOCKET_ABORTED_CLOSE_STATUS = 1006,
    WINHTTP_WEB_SOCKET_INVALID_PAYLOAD_CLOSE_STATUS = 1007,
    WINHTTP_WEB_SOCKET_POLICY_VIOLATION_CLOSE_STATUS = 1008,
    WINHTTP_WEB_SOCKET_MESSAGE_TOO_BIG_CLOSE_STATUS = 1009,
    WINHTTP_WEB_SOCKET_UNSUPPORTED_EXTENSIONS_CLOSE_STATUS = 1010,
    WINHTTP_WEB_SOCKET_SERVER_ERROR_CLOSE_STATUS = 1011,
    WINHTTP_WEB_SOCKET_SECURE_HANDSHAKE_ERROR_CLOSE_STATUS = 1015,
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

@DllImport("HTTPAPI.dll")
uint HttpInitialize(HTTPAPI_VERSION Version, uint Flags, void* pReserved);

@DllImport("HTTPAPI.dll")
uint HttpTerminate(uint Flags, void* pReserved);

@DllImport("HTTPAPI.dll")
uint HttpCreateHttpHandle(int* RequestQueueHandle, uint Reserved);

@DllImport("HTTPAPI.dll")
uint HttpCreateRequestQueue(HTTPAPI_VERSION Version, const(wchar)* Name, SECURITY_ATTRIBUTES* SecurityAttributes, uint Flags, int* RequestQueueHandle);

@DllImport("HTTPAPI.dll")
uint HttpCloseRequestQueue(HANDLE RequestQueueHandle);

@DllImport("HTTPAPI.dll")
uint HttpSetRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength, uint Reserved1, void* Reserved2);

@DllImport("HTTPAPI.dll")
uint HttpQueryRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength, uint Reserved1, uint* ReturnLength, void* Reserved2);

@DllImport("HTTPAPI.dll")
uint HttpShutdownRequestQueue(HANDLE RequestQueueHandle);

@DllImport("HTTPAPI.dll")
uint HttpReceiveClientCertificate(HANDLE RequestQueueHandle, ulong ConnectionId, uint Flags, char* SslClientCertInfo, uint SslClientCertInfoSize, uint* BytesReceived, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpCreateServerSession(HTTPAPI_VERSION Version, ulong* ServerSessionId, uint Reserved);

@DllImport("HTTPAPI.dll")
uint HttpCloseServerSession(ulong ServerSessionId);

@DllImport("HTTPAPI.dll")
uint HttpQueryServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength, uint* ReturnLength);

@DllImport("HTTPAPI.dll")
uint HttpSetServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength);

@DllImport("HTTPAPI.dll")
uint HttpAddUrl(HANDLE RequestQueueHandle, const(wchar)* FullyQualifiedUrl, void* Reserved);

@DllImport("HTTPAPI.dll")
uint HttpRemoveUrl(HANDLE RequestQueueHandle, const(wchar)* FullyQualifiedUrl);

@DllImport("HTTPAPI.dll")
uint HttpCreateUrlGroup(ulong ServerSessionId, ulong* pUrlGroupId, uint Reserved);

@DllImport("HTTPAPI.dll")
uint HttpCloseUrlGroup(ulong UrlGroupId);

@DllImport("HTTPAPI.dll")
uint HttpAddUrlToUrlGroup(ulong UrlGroupId, const(wchar)* pFullyQualifiedUrl, ulong UrlContext, uint Reserved);

@DllImport("HTTPAPI.dll")
uint HttpRemoveUrlFromUrlGroup(ulong UrlGroupId, const(wchar)* pFullyQualifiedUrl, uint Flags);

@DllImport("HTTPAPI.dll")
uint HttpSetUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength);

@DllImport("HTTPAPI.dll")
uint HttpQueryUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, char* PropertyInformation, uint PropertyInformationLength, uint* ReturnLength);

@DllImport("HTTPAPI.dll")
uint HttpPrepareUrl(void* Reserved, uint Flags, const(wchar)* Url, ushort** PreparedUrl);

@DllImport("HTTPAPI.dll")
uint HttpReceiveHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, char* RequestBuffer, uint RequestBufferLength, uint* BytesReturned, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpReceiveRequestEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, char* EntityBuffer, uint EntityBufferLength, uint* BytesReturned, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpSendHttpResponse(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, HTTP_RESPONSE_V2* HttpResponse, HTTP_CACHE_POLICY* CachePolicy, uint* BytesSent, void* Reserved1, uint Reserved2, OVERLAPPED* Overlapped, HTTP_LOG_DATA* LogData);

@DllImport("HTTPAPI.dll")
uint HttpSendResponseEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, ushort EntityChunkCount, char* EntityChunks, uint* BytesSent, void* Reserved1, uint Reserved2, OVERLAPPED* Overlapped, HTTP_LOG_DATA* LogData);

@DllImport("HTTPAPI.dll")
uint HttpDeclarePush(HANDLE RequestQueueHandle, ulong RequestId, HTTP_VERB Verb, const(wchar)* Path, const(char)* Query, HTTP_REQUEST_HEADERS* Headers);

@DllImport("HTTPAPI.dll")
uint HttpWaitForDisconnect(HANDLE RequestQueueHandle, ulong ConnectionId, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpWaitForDisconnectEx(HANDLE RequestQueueHandle, ulong ConnectionId, uint Reserved, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpCancelHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpWaitForDemandStart(HANDLE RequestQueueHandle, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpFlushResponseCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, uint Flags, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpAddFragmentToCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, HTTP_DATA_CHUNK* DataChunk, HTTP_CACHE_POLICY* CachePolicy, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpReadFragmentFromCache(HANDLE RequestQueueHandle, const(wchar)* UrlPrefix, HTTP_BYTE_RANGE* ByteRange, char* Buffer, uint BufferLength, uint* BytesRead, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpSetServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, char* pConfigInformation, uint ConfigInformationLength, OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI.dll")
uint HttpUpdateServiceConfiguration(HANDLE Handle, HTTP_SERVICE_CONFIG_ID ConfigId, char* ConfigInfo, uint ConfigInfoLength, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpDeleteServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, char* pConfigInformation, uint ConfigInformationLength, OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI.dll")
uint HttpQueryServiceConfiguration(HANDLE ServiceHandle, HTTP_SERVICE_CONFIG_ID ConfigId, char* pInput, uint InputLength, char* pOutput, uint OutputLength, uint* pReturnLength, OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI.dll")
uint HttpGetExtension(HTTPAPI_VERSION Version, uint Extension, void* Buffer, uint BufferSize);

@DllImport("WINHTTP.dll")
WINHTTP_STATUS_CALLBACK WinHttpSetStatusCallback(void* hInternet, WINHTTP_STATUS_CALLBACK lpfnInternetCallback, uint dwNotificationFlags, uint dwReserved);

@DllImport("WINHTTP.dll")
BOOL WinHttpTimeFromSystemTime(const(SYSTEMTIME)* pst, const(wchar)* pwszTime);

@DllImport("WINHTTP.dll")
BOOL WinHttpTimeToSystemTime(const(wchar)* pwszTime, SYSTEMTIME* pst);

@DllImport("WINHTTP.dll")
BOOL WinHttpCrackUrl(const(wchar)* pwszUrl, uint dwUrlLength, uint dwFlags, URL_COMPONENTS* lpUrlComponents);

@DllImport("WINHTTP.dll")
BOOL WinHttpCreateUrl(URL_COMPONENTS* lpUrlComponents, uint dwFlags, const(wchar)* pwszUrl, uint* pdwUrlLength);

@DllImport("WINHTTP.dll")
BOOL WinHttpCheckPlatform();

@DllImport("WINHTTP.dll")
BOOL WinHttpGetDefaultProxyConfiguration(WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP.dll")
BOOL WinHttpSetDefaultProxyConfiguration(WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP.dll")
void* WinHttpOpen(const(wchar)* pszAgentW, uint dwAccessType, const(wchar)* pszProxyW, const(wchar)* pszProxyBypassW, uint dwFlags);

@DllImport("WINHTTP.dll")
BOOL WinHttpCloseHandle(void* hInternet);

@DllImport("WINHTTP.dll")
void* WinHttpConnect(void* hSession, const(wchar)* pswzServerName, ushort nServerPort, uint dwReserved);

@DllImport("WINHTTP.dll")
BOOL WinHttpReadData(void* hRequest, char* lpBuffer, uint dwNumberOfBytesToRead, uint* lpdwNumberOfBytesRead);

@DllImport("WINHTTP.dll")
BOOL WinHttpWriteData(void* hRequest, char* lpBuffer, uint dwNumberOfBytesToWrite, uint* lpdwNumberOfBytesWritten);

@DllImport("WINHTTP.dll")
BOOL WinHttpQueryDataAvailable(void* hRequest, uint* lpdwNumberOfBytesAvailable);

@DllImport("WINHTTP.dll")
BOOL WinHttpQueryOption(void* hInternet, uint dwOption, char* lpBuffer, uint* lpdwBufferLength);

@DllImport("WINHTTP.dll")
BOOL WinHttpSetOption(void* hInternet, uint dwOption, char* lpBuffer, uint dwBufferLength);

@DllImport("WINHTTP.dll")
BOOL WinHttpSetTimeouts(void* hInternet, int nResolveTimeout, int nConnectTimeout, int nSendTimeout, int nReceiveTimeout);

@DllImport("WINHTTP.dll")
void* WinHttpOpenRequest(void* hConnect, const(wchar)* pwszVerb, const(wchar)* pwszObjectName, const(wchar)* pwszVersion, const(wchar)* pwszReferrer, ushort** ppwszAcceptTypes, uint dwFlags);

@DllImport("WINHTTP.dll")
BOOL WinHttpAddRequestHeaders(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, uint dwModifiers);

@DllImport("WINHTTP.dll")
uint WinHttpAddRequestHeadersEx(void* hRequest, uint dwModifiers, ulong ullFlags, ulong ullExtra, uint cHeaders, char* pHeaders);

@DllImport("WINHTTP.dll")
BOOL WinHttpSendRequest(void* hRequest, const(wchar)* lpszHeaders, uint dwHeadersLength, char* lpOptional, uint dwOptionalLength, uint dwTotalLength, uint dwContext);

@DllImport("WINHTTP.dll")
BOOL WinHttpSetCredentials(void* hRequest, uint AuthTargets, uint AuthScheme, const(wchar)* pwszUserName, const(wchar)* pwszPassword, void* pAuthParams);

@DllImport("WINHTTP.dll")
BOOL WinHttpQueryAuthSchemes(void* hRequest, uint* lpdwSupportedSchemes, uint* lpdwFirstScheme, uint* pdwAuthTarget);

@DllImport("WINHTTP.dll")
BOOL WinHttpReceiveResponse(void* hRequest, void* lpReserved);

@DllImport("WINHTTP.dll")
BOOL WinHttpQueryHeaders(void* hRequest, uint dwInfoLevel, const(wchar)* pwszName, char* lpBuffer, uint* lpdwBufferLength, uint* lpdwIndex);

@DllImport("WINHTTP.dll")
BOOL WinHttpDetectAutoProxyConfigUrl(uint dwAutoDetectFlags, ushort** ppwstrAutoConfigUrl);

@DllImport("WINHTTP.dll")
BOOL WinHttpGetProxyForUrl(void* hSession, const(wchar)* lpcwszUrl, WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, WINHTTP_PROXY_INFO* pProxyInfo);

@DllImport("WINHTTP.dll")
uint WinHttpCreateProxyResolver(void* hSession, void** phResolver);

@DllImport("WINHTTP.dll")
uint WinHttpGetProxyForUrlEx(void* hResolver, const(wchar)* pcwszUrl, WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, uint pContext);

@DllImport("WINHTTP.dll")
uint WinHttpGetProxyForUrlEx2(void* hResolver, const(wchar)* pcwszUrl, WINHTTP_AUTOPROXY_OPTIONS* pAutoProxyOptions, uint cbInterfaceSelectionContext, char* pInterfaceSelectionContext, uint pContext);

@DllImport("WINHTTP.dll")
uint WinHttpGetProxyResult(void* hResolver, WINHTTP_PROXY_RESULT* pProxyResult);

@DllImport("WINHTTP.dll")
uint WinHttpGetProxyResultEx(void* hResolver, WINHTTP_PROXY_RESULT_EX* pProxyResultEx);

@DllImport("WINHTTP.dll")
void WinHttpFreeProxyResult(WINHTTP_PROXY_RESULT* pProxyResult);

@DllImport("WINHTTP.dll")
void WinHttpFreeProxyResultEx(WINHTTP_PROXY_RESULT_EX* pProxyResultEx);

@DllImport("WINHTTP.dll")
uint WinHttpResetAutoProxy(void* hSession, uint dwFlags);

@DllImport("WINHTTP.dll")
BOOL WinHttpGetIEProxyConfigForCurrentUser(WINHTTP_CURRENT_USER_IE_PROXY_CONFIG* pProxyConfig);

@DllImport("WINHTTP.dll")
uint WinHttpWriteProxySettings(void* hSession, BOOL fForceUpdate, WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP.dll")
uint WinHttpReadProxySettings(void* hSession, const(wchar)* pcwszConnectionName, BOOL fFallBackToDefaultSettings, BOOL fSetAutoDiscoverForDefaultSettings, uint* pdwSettingsVersion, int* pfDefaultSettingsAreReturned, WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP.dll")
void WinHttpFreeProxySettings(WINHTTP_PROXY_SETTINGS* pWinHttpProxySettings);

@DllImport("WINHTTP.dll")
uint WinHttpGetProxySettingsVersion(void* hSession, uint* pdwProxySettingsVersion);

@DllImport("WINHTTP.dll")
uint WinHttpSetProxySettingsPerUser(BOOL fProxySettingsPerUser);

@DllImport("WINHTTP.dll")
void* WinHttpWebSocketCompleteUpgrade(void* hRequest, uint pContext);

@DllImport("WINHTTP.dll")
uint WinHttpWebSocketSend(void* hWebSocket, WINHTTP_WEB_SOCKET_BUFFER_TYPE eBufferType, char* pvBuffer, uint dwBufferLength);

@DllImport("WINHTTP.dll")
uint WinHttpWebSocketReceive(void* hWebSocket, char* pvBuffer, uint dwBufferLength, uint* pdwBytesRead, WINHTTP_WEB_SOCKET_BUFFER_TYPE* peBufferType);

@DllImport("WINHTTP.dll")
uint WinHttpWebSocketShutdown(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WINHTTP.dll")
uint WinHttpWebSocketClose(void* hWebSocket, ushort usStatus, char* pvReason, uint dwReasonLength);

@DllImport("WINHTTP.dll")
uint WinHttpWebSocketQueryCloseStatus(void* hWebSocket, ushort* pusStatus, char* pvReason, uint dwReasonLength, uint* pdwReasonLengthConsumed);

