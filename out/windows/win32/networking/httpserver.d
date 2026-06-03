// Written in the D programming language.

module windows.win32.networking.httpserver;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, HANDLE, HRESULT, PSTR, PWSTR;
public import windows.win32.networking.winsock : SOCKADDR, SOCKADDR_STORAGE;
public import windows.win32.security : PSECURITY_DESCRIPTOR, SECURITY_ATTRIBUTES;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias HTTP_RECEIVE_HTTP_REQUEST_FLAGS = uint;
enum : uint
{
    HTTP_RECEIVE_REQUEST_FLAG_COPY_BODY  = 0x00000001U,
    HTTP_RECEIVE_REQUEST_FLAG_FLUSH_BODY = 0x00000002U,
}

alias HTTP_INITIALIZE = uint;
enum : uint
{
    HTTP_INITIALIZE_CONFIG = 0x00000002U,
    HTTP_INITIALIZE_SERVER = 0x00000001U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_server_property
alias HTTP_SERVER_PROPERTY = int;
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
    HttpServerDelegationProperty             = 0x00000010,
    HttpServerFastForwardingProperty         = 0x00000012,
    HttpServerRequestInfoProperty            = 0x00000013,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_enabled_state
alias HTTP_ENABLED_STATE = int;
enum : int
{
    HttpEnabledStateActive   = 0x00000000,
    HttpEnabledStateInactive = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_503_response_verbosity
alias HTTP_503_RESPONSE_VERBOSITY = int;
enum : int
{
    Http503ResponseVerbosityBasic   = 0x00000000,
    Http503ResponseVerbosityLimited = 0x00000001,
    Http503ResponseVerbosityFull    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_qos_setting_type
alias HTTP_QOS_SETTING_TYPE = int;
enum : int
{
    HttpQosSettingTypeBandwidth       = 0x00000000,
    HttpQosSettingTypeConnectionLimit = 0x00000001,
    HttpQosSettingTypeFlowRate        = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_service_config_timeout_key
alias HTTP_SERVICE_CONFIG_TIMEOUT_KEY = int;
enum : int
{
    IdleConnectionTimeout = 0x00000000,
    HeaderWaitTimeout     = 0x00000001,
}

alias HTTP_SERVICE_CONFIG_SETTING_KEY = int;
enum : int
{
    HttpNone        = 0x00000000,
    HttpTlsThrottle = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_service_binding_type
alias HTTP_SERVICE_BINDING_TYPE = int;
enum : int
{
    HttpServiceBindingTypeNone = 0x00000000,
    HttpServiceBindingTypeW    = 0x00000001,
    HttpServiceBindingTypeA    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_authentication_hardening_levels
alias HTTP_AUTHENTICATION_HARDENING_LEVELS = int;
enum : int
{
    HttpAuthenticationHardeningLegacy = 0x00000000,
    HttpAuthenticationHardeningMedium = 0x00000001,
    HttpAuthenticationHardeningStrict = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_logging_type
alias HTTP_LOGGING_TYPE = int;
enum : int
{
    HttpLoggingTypeW3C  = 0x00000000,
    HttpLoggingTypeIIS  = 0x00000001,
    HttpLoggingTypeNCSA = 0x00000002,
    HttpLoggingTypeRaw  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_logging_rollover_type
alias HTTP_LOGGING_ROLLOVER_TYPE = int;
enum : int
{
    HttpLoggingRolloverSize    = 0x00000000,
    HttpLoggingRolloverDaily   = 0x00000001,
    HttpLoggingRolloverWeekly  = 0x00000002,
    HttpLoggingRolloverMonthly = 0x00000003,
    HttpLoggingRolloverHourly  = 0x00000004,
}

alias HTTP_PROTECTION_LEVEL_TYPE = int;
enum : int
{
    HttpProtectionLevelUnrestricted   = 0x00000000,
    HttpProtectionLevelEdgeRestricted = 0x00000001,
    HttpProtectionLevelRestricted     = 0x00000002,
}

alias HTTP_SCHEME = int;
enum : int
{
    HttpSchemeHttp    = 0x00000000,
    HttpSchemeHttps   = 0x00000001,
    HttpSchemeMaximum = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_verb
alias HTTP_VERB = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_header_id
alias HTTP_HEADER_ID = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_log_data_type
alias HTTP_LOG_DATA_TYPE = int;
enum : int
{
    HttpLogDataTypeFields = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_data_chunk_type
alias HTTP_DATA_CHUNK_TYPE = int;
enum : int
{
    HttpDataChunkFromMemory                = 0x00000000,
    HttpDataChunkFromFileHandle            = 0x00000001,
    HttpDataChunkFromFragmentCache         = 0x00000002,
    HttpDataChunkFromFragmentCacheEx       = 0x00000003,
    HttpDataChunkTrailers                  = 0x00000004,
    HttpDataChunkFromWinHttpFastForwarding = 0x00000005,
    HttpDataChunkMaximum                   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_delegate_request_property_id
alias HTTP_DELEGATE_REQUEST_PROPERTY_ID = int;
enum : int
{
    DelegateRequestReservedProperty    = 0x00000000,
    DelegateRequestDelegateUrlProperty = 0x00000001,
}

alias HTTP_CREATE_REQUEST_QUEUE_PROPERTY_ID = int;
enum : int
{
    CreateRequestQueueExternalIdProperty = 0x00000001,
    CreateRequestQueueMax                = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_auth_status
alias HTTP_AUTH_STATUS = int;
enum : int
{
    HttpAuthStatusSuccess          = 0x00000000,
    HttpAuthStatusNotAuthenticated = 0x00000001,
    HttpAuthStatusFailure          = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_request_auth_type
alias HTTP_REQUEST_AUTH_TYPE = int;
enum : int
{
    HttpRequestAuthTypeNone      = 0x00000000,
    HttpRequestAuthTypeBasic     = 0x00000001,
    HttpRequestAuthTypeDigest    = 0x00000002,
    HttpRequestAuthTypeNTLM      = 0x00000003,
    HttpRequestAuthTypeNegotiate = 0x00000004,
    HttpRequestAuthTypeKerberos  = 0x00000005,
}

alias HTTP_REQUEST_SIZING_TYPE = int;
enum : int
{
    HttpRequestSizingTypeTlsHandshakeLeg1ClientData = 0x00000000,
    HttpRequestSizingTypeTlsHandshakeLeg1ServerData = 0x00000001,
    HttpRequestSizingTypeTlsHandshakeLeg2ClientData = 0x00000002,
    HttpRequestSizingTypeTlsHandshakeLeg2ServerData = 0x00000003,
    HttpRequestSizingTypeHeaders                    = 0x00000004,
    HttpRequestSizingTypeMax                        = 0x00000005,
}

alias HTTP_REQUEST_TIMING_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_request_info_type
alias HTTP_REQUEST_INFO_TYPE = int;
enum : int
{
    HttpRequestInfoTypeAuth                           = 0x00000000,
    HttpRequestInfoTypeChannelBind                    = 0x00000001,
    HttpRequestInfoTypeSslProtocol                    = 0x00000002,
    HttpRequestInfoTypeSslTokenBindingDraft           = 0x00000003,
    HttpRequestInfoTypeSslTokenBinding                = 0x00000004,
    HttpRequestInfoTypeRequestTiming                  = 0x00000005,
    HttpRequestInfoTypeTcpInfoV0                      = 0x00000006,
    HttpRequestInfoTypeRequestSizing                  = 0x00000007,
    HttpRequestInfoTypeQuicStats                      = 0x00000008,
    HttpRequestInfoTypeTcpInfoV1                      = 0x00000009,
    HttpRequestInfoTypeQuicStatsV2                    = 0x0000000a,
    HttpRequestInfoTypeTcpInfoV2                      = 0x0000000b,
    HttpRequestInfoTypeTransportIdleConnectionTimeout = 0x0000000c,
    HttpRequestInfoTypeDscpTag                        = 0x0000000d,
    HttpRequestInfoTypeInitialPacketTtl               = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_response_info_type
alias HTTP_RESPONSE_INFO_TYPE = int;
enum : int
{
    HttpResponseInfoTypeMultipleKnownHeaders   = 0x00000000,
    HttpResponseInfoTypeAuthenticationProperty = 0x00000001,
    HttpResponseInfoTypeQoSProperty            = 0x00000002,
    HttpResponseInfoTypeChannelBind            = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_cache_policy_type
alias HTTP_CACHE_POLICY_TYPE = int;
enum : int
{
    HttpCachePolicyNocache         = 0x00000000,
    HttpCachePolicyUserInvalidates = 0x00000001,
    HttpCachePolicyTimeToLive      = 0x00000002,
    HttpCachePolicyMaximum         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_service_config_id
alias HTTP_SERVICE_CONFIG_ID = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_service_config_query_type
alias HTTP_SERVICE_CONFIG_QUERY_TYPE = int;
enum : int
{
    HttpServiceConfigQueryExact = 0x00000000,
    HttpServiceConfigQueryNext  = 0x00000001,
    HttpServiceConfigQueryMax   = 0x00000002,
}

alias HTTP_SSL_SERVICE_CONFIG_EX_PARAM_TYPE = int;
enum : int
{
    ExParamTypeHttp2Window          = 0x00000000,
    ExParamTypeHttp2SettingsLimits  = 0x00000001,
    ExParamTypeHttpPerformance      = 0x00000002,
    ExParamTypeTlsRestrictions      = 0x00000003,
    ExParamTypeErrorHeaders         = 0x00000004,
    ExParamTypeTlsSessionTicketKeys = 0x00000005,
    ExParamTypeCertConfig           = 0x00000006,
    ExParamTypeMax                  = 0x00000007,
}

alias HTTP_PERFORMANCE_PARAM_TYPE = int;
enum : int
{
    PerformanceParamSendBufferingFlags         = 0x00000000,
    PerformanceParamAggressiveICW              = 0x00000001,
    PerformanceParamMaxSendBufferSize          = 0x00000002,
    PerformanceParamMaxConcurrentClientStreams = 0x00000003,
    PerformanceParamMaxReceiveBufferSize       = 0x00000004,
    PerformanceParamDecryptOnSspiThread        = 0x00000005,
    PerformanceParamMax                        = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_service_config_cache_key
alias HTTP_SERVICE_CONFIG_CACHE_KEY = int;
enum : int
{
    MaxCacheResponseSize = 0x00000000,
    CacheRangeChunkSize  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_request_property
alias HTTP_REQUEST_PROPERTY = int;
enum : int
{
    HttpRequestPropertyIsb                            = 0x00000000,
    HttpRequestPropertyTcpInfoV0                      = 0x00000001,
    HttpRequestPropertyQuicStats                      = 0x00000002,
    HttpRequestPropertyTcpInfoV1                      = 0x00000003,
    HttpRequestPropertySni                            = 0x00000004,
    HttpRequestPropertyStreamError                    = 0x00000005,
    HttpRequestPropertyWskApiTimings                  = 0x00000006,
    HttpRequestPropertyQuicApiTimings                 = 0x00000007,
    HttpRequestPropertyQuicStatsV2                    = 0x00000008,
    HttpRequestPropertyQuicStreamStats                = 0x00000009,
    HttpRequestPropertyTcpInfoV2                      = 0x0000000a,
    HttpRequestPropertyTlsClientHello                 = 0x0000000b,
    HttpRequestPropertyTransportIdleConnectionTimeout = 0x0000000c,
    HttpRequestPropertyDscpTag                        = 0x0000000d,
    HttpRequestPropertyTlsCipherInfo                  = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ne-http-http_feature_id
alias HTTP_FEATURE_ID = int;
enum : int
{
    HttpFeatureUnknown                              = 0x00000000,
    HttpFeatureResponseTrailers                     = 0x00000001,
    HttpFeatureApiTimings                           = 0x00000002,
    HttpFeatureDelegateEx                           = 0x00000003,
    HttpFeatureHttp3                                = 0x00000004,
    HttpFeatureTlsSessionTickets                    = 0x00000005,
    HttpFeatureDisableTlsSessionId                  = 0x00000006,
    HttpFeatureTlsDualCerts                         = 0x00000007,
    HttpFeatureAutomaticChunkedEncoding             = 0x00000008,
    HttpFeatureDedicatedReqQueueDelegationType      = 0x00000009,
    HttpFeatureFastForwardResponse                  = 0x0000000a,
    HttpFeatureCacheTlsClientHello                  = 0x0000000b,
    HttpFeatureIdleConnectionTimeoutRequestProperty = 0x0000000c,
    HttpFeatureDisableAiaFlag                       = 0x0000000d,
    HttpFeatureDscp                                 = 0x0000000e,
    HttpFeatureQueryCipherInfo                      = 0x0000000f,
    HttpFeatureQueryInitialPacketTtl                = 0x00000010,
    HttpFeatureTlsHandshakePerformanceCounters      = 0x00000011,
    HttpFeatureLast                                 = 0x00000012,
    HttpFeaturemax                                  = 0xffffffff,
}

// Constants


enum uint HTTP_DEMAND_CBT = 0x00000004U;
enum uint HTTP_MAX_SERVER_QUEUE_LENGTH = 0x7fffffffU;
enum uint HTTP_MIN_SERVER_QUEUE_LENGTH = 0x00000001U;

enum : uint
{
    HTTP_AUTH_ENABLE_BASIC                               = 0x00000001U,
    HTTP_AUTH_ENABLE_DIGEST                              = 0x00000002U,
    HTTP_AUTH_ENABLE_NTLM                                = 0x00000004U,
    HTTP_AUTH_ENABLE_NEGOTIATE                           = 0x00000008U,
    HTTP_AUTH_ENABLE_KERBEROS                            = 0x00000010U,
    HTTP_AUTH_EX_FLAG_ENABLE_KERBEROS_CREDENTIAL_CACHING = 0x00000001U,
}

enum uint HTTP_AUTH_EX_FLAG_CAPTURE_CREDENTIAL = 0x00000002U;

enum : uint
{
    HTTP_CHANNEL_BIND_PROXY                 = 0x00000001U,
    HTTP_CHANNEL_BIND_PROXY_COHOSTING       = 0x00000020U,
    HTTP_CHANNEL_BIND_NO_SERVICE_NAME_CHECK = 0x00000002U,
    HTTP_CHANNEL_BIND_DOTLESS_SERVICE       = 0x00000004U,
    HTTP_CHANNEL_BIND_SECURE_CHANNEL_TOKEN  = 0x00000008U,
    HTTP_CHANNEL_BIND_CLIENT_SERVICE        = 0x00000010U,
}

enum : uint
{
    HTTP_LOG_FIELD_DATE           = 0x00000001U,
    HTTP_LOG_FIELD_TIME           = 0x00000002U,
    HTTP_LOG_FIELD_CLIENT_IP      = 0x00000004U,
    HTTP_LOG_FIELD_USER_NAME      = 0x00000008U,
    HTTP_LOG_FIELD_SITE_NAME      = 0x00000010U,
    HTTP_LOG_FIELD_COMPUTER_NAME  = 0x00000020U,
    HTTP_LOG_FIELD_SERVER_IP      = 0x00000040U,
    HTTP_LOG_FIELD_METHOD         = 0x00000080U,
    HTTP_LOG_FIELD_URI_STEM       = 0x00000100U,
    HTTP_LOG_FIELD_URI_QUERY      = 0x00000200U,
    HTTP_LOG_FIELD_STATUS         = 0x00000400U,
    HTTP_LOG_FIELD_WIN32_STATUS   = 0x00000800U,
    HTTP_LOG_FIELD_BYTES_SENT     = 0x00001000U,
    HTTP_LOG_FIELD_BYTES_RECV     = 0x00002000U,
    HTTP_LOG_FIELD_TIME_TAKEN     = 0x00004000U,
    HTTP_LOG_FIELD_SERVER_PORT    = 0x00008000U,
    HTTP_LOG_FIELD_USER_AGENT     = 0x00010000U,
    HTTP_LOG_FIELD_COOKIE         = 0x00020000U,
    HTTP_LOG_FIELD_REFERER        = 0x00040000U,
    HTTP_LOG_FIELD_VERSION        = 0x00080000U,
    HTTP_LOG_FIELD_HOST           = 0x00100000U,
    HTTP_LOG_FIELD_SUB_STATUS     = 0x00200000U,
    HTTP_LOG_FIELD_STREAM_ID      = 0x08000000U,
    HTTP_LOG_FIELD_STREAM_ID_EX   = 0x10000000U,
    HTTP_LOG_FIELD_TRANSPORT_TYPE = 0x20000000U,
    HTTP_LOG_FIELD_CLIENT_PORT    = 0x00400000U,
    HTTP_LOG_FIELD_URI            = 0x00800000U,
    HTTP_LOG_FIELD_SITE_ID        = 0x01000000U,
    HTTP_LOG_FIELD_REASON         = 0x02000000U,
    HTTP_LOG_FIELD_QUEUE_NAME     = 0x04000000U,
    HTTP_LOG_FIELD_CORRELATION_ID = 0x40000000U,
    HTTP_LOG_FIELD_FAULT_CODE     = 0x80000000U,
}

enum ulong HTTP_LOG_FIELD_EXT_FAULT_CODE_EXT = 0x0000000000000001UL;

enum : uint
{
    HTTP_LOGGING_FLAG_LOCAL_TIME_ROLLOVER = 0x00000001U,
    HTTP_LOGGING_FLAG_USE_UTF8_CONVERSION = 0x00000002U,
    HTTP_LOGGING_FLAG_LOG_ERRORS_ONLY     = 0x00000004U,
    HTTP_LOGGING_FLAG_LOG_SUCCESS_ONLY    = 0x00000008U,
}

enum : uint
{
    HTTP_CREATE_REQUEST_QUEUE_FLAG_OPEN_EXISTING = 0x00000001U,
    HTTP_CREATE_REQUEST_QUEUE_FLAG_CONTROLLER    = 0x00000002U,
    HTTP_CREATE_REQUEST_QUEUE_FLAG_DELEGATION    = 0x00000008U,
}

enum uint HTTP_RECEIVE_REQUEST_ENTITY_BODY_FLAG_FILL_BUFFER = 0x00000001U;

enum : uint
{
    HTTP_SEND_RESPONSE_FLAG_DISCONNECT         = 0x00000001U,
    HTTP_SEND_RESPONSE_FLAG_MORE_DATA          = 0x00000002U,
    HTTP_SEND_RESPONSE_FLAG_BUFFER_DATA        = 0x00000004U,
    HTTP_SEND_RESPONSE_FLAG_ENABLE_NAGLING     = 0x00000008U,
    HTTP_SEND_RESPONSE_FLAG_PROCESS_RANGES     = 0x00000020U,
    HTTP_SEND_RESPONSE_FLAG_OPAQUE             = 0x00000040U,
    HTTP_SEND_RESPONSE_FLAG_GOAWAY             = 0x00000100U,
    HTTP_SEND_RESPONSE_FLAG_AUTOMATIC_CHUNKING = 0x00000200U,
}

enum uint HTTP_FLUSH_RESPONSE_FLAG_RECURSIVE = 0x00000001U;
enum uint HTTP_URL_FLAG_REMOVE_ALL = 0x00000001U;
enum uint HTTP_RECEIVE_SECURE_CHANNEL_TOKEN = 0x00000001U;
enum uint HTTP_RECEIVE_FULL_CHAIN = 0x00000002U;

enum : uint
{
    HTTP_REQUEST_SIZING_INFO_FLAG_TCP_FAST_OPEN          = 0x00000001U,
    HTTP_REQUEST_SIZING_INFO_FLAG_TLS_SESSION_RESUMPTION = 0x00000002U,
    HTTP_REQUEST_SIZING_INFO_FLAG_TLS_FALSE_START        = 0x00000004U,
    HTTP_REQUEST_SIZING_INFO_FLAG_FIRST_REQUEST          = 0x00000008U,
}

enum uint HTTP_REQUEST_AUTH_FLAG_TOKEN_FOR_CACHED_CRED = 0x00000001U;

enum : uint
{
    HTTP_REQUEST_FLAG_MORE_ENTITY_BODY_EXISTS          = 0x00000001U,
    HTTP_REQUEST_FLAG_IP_ROUTED                        = 0x00000002U,
    HTTP_REQUEST_FLAG_HTTP2                            = 0x00000004U,
    HTTP_REQUEST_FLAG_HTTP3                            = 0x00000008U,
    HTTP_REQUEST_FLAG_FAST_FORWARDING_ALLOWED          = 0x00000010U,
    HTTP_REQUEST_FLAG_FAST_FORWARDING_RESPONSE_ALLOWED = 0x00000010U,
}

enum : uint
{
    HTTP_RESPONSE_FLAG_MULTIPLE_ENCODINGS_AVAILABLE = 0x00000001U,
    HTTP_RESPONSE_FLAG_MORE_ENTITY_BODY_EXISTS      = 0x00000002U,
}

enum uint HTTP_RESPONSE_INFO_FLAGS_PRESERVE_ORDER = 0x00000001U;

enum : uint
{
    HTTP_CERT_CHECK_MODE_NO_REVOCATION            = 0x00000001U,
    HTTP_CERT_CHECK_MODE_CACHED_REVOCATION        = 0x00000002U,
    HTTP_CERT_CHECK_MODE_USE_REVOCATION_FRESHNESS = 0x00000004U,
    HTTP_CERT_CHECK_MODE_CACHED_URLS              = 0x00000008U,
    HTTP_CERT_CHECK_MODE_NO_AIA                   = 0x00000010U,
    HTTP_CERT_CHECK_MODE_NO_USAGE_CHECK           = 0x00010000U,
}

enum : uint
{
    HTTP_SSL_CERT_SHA_HASH_LENGTH   = 0x00000014U,
    HTTP_SSL_CERT_STORE_NAME_LENGTH = 0x00000080U,
}

enum : uint
{
    HTTP_SERVICE_CONFIG_SSL_FLAG_USE_DS_MAPPER             = 0x00000001U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_NEGOTIATE_CLIENT_CERT     = 0x00000002U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_NO_RAW_FILTER             = 0x00000004U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_REJECT                    = 0x00000008U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_HTTP2             = 0x00000010U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_QUIC              = 0x00000020U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_TLS13             = 0x00000040U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_OCSP_STAPLING     = 0x00000080U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_ENABLE_TOKEN_BINDING      = 0x00000100U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_LOG_EXTENDED_EVENTS       = 0x00000200U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_LEGACY_TLS        = 0x00000400U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_ENABLE_SESSION_TICKET     = 0x00000800U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_TLS12             = 0x00001000U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_ENABLE_CLIENT_CORRELATION = 0x00002000U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_DISABLE_SESSION_ID        = 0x00004000U,
    HTTP_SERVICE_CONFIG_SSL_FLAG_ENABLE_CACHE_CLIENT_HELLO = 0x00008000U,
}

enum : uint
{
    HTTP_REQUEST_PROPERTY_SNI_HOST_MAX_LENGTH = 0x000000ffU,
    HTTP_REQUEST_PROPERTY_SNI_FLAG_SNI_USED   = 0x00000001U,
    HTTP_REQUEST_PROPERTY_SNI_FLAG_NO_SNI     = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_version
enum const(wchar)* HTTP_VERSION_ = "HTTP/1.0";

// Structs


@RAIIFree!HttpCloseRequestQueue
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
//STRUCT ATTR: MetadataTypedefAttribute : CustomAttributeSig([], [])
struct HTTP_REQUEST_QUEUE_HANDLE
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_property_flags
struct HTTP_PROPERTY_FLAGS
{
    // Native bit field: Present: [0]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_state_info
struct HTTP_STATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    HTTP_ENABLED_STATE  State;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_qos_setting_info
struct HTTP_QOS_SETTING_INFO
{
    HTTP_QOS_SETTING_TYPE QosType;
    void* QosSetting;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_connection_limit_info
struct HTTP_CONNECTION_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxConnections;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_bandwidth_limit_info
struct HTTP_BANDWIDTH_LIMIT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxBandwidth;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_flowrate_info
struct HTTP_FLOWRATE_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                MaxBandwidth;
    uint                MaxPeakBandwidth;
    uint                BurstSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_timeout_set
struct HTTP_SERVICE_CONFIG_TIMEOUT_SET
{
    HTTP_SERVICE_CONFIG_TIMEOUT_KEY KeyDesc;
    ushort ParamDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_timeout_limit_info
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_listen_endpoint_info
struct HTTP_LISTEN_ENDPOINT_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    BOOLEAN             EnableSharing;
}

struct HTTP_FAST_FORWARD_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    BOOLEAN             EnableFastForwarding;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_server_authentication_digest_params
struct HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS
{
    ushort DomainNameLength;
    PWSTR  DomainName;
    ushort RealmLength;
    PWSTR  Realm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_server_authentication_basic_params
struct HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS
{
    ushort RealmLength;
    PWSTR  Realm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_server_authentication_info
struct HTTP_SERVER_AUTHENTICATION_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    uint                AuthSchemes;
    BOOLEAN             ReceiveMutualAuth;
    BOOLEAN             ReceiveContextHandle;
    BOOLEAN             DisableNTLMCredentialCaching;
    ubyte               ExFlags;
    HTTP_SERVER_AUTHENTICATION_DIGEST_PARAMS DigestParams;
    HTTP_SERVER_AUTHENTICATION_BASIC_PARAMS BasicParams;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_binding_base
struct HTTP_SERVICE_BINDING_BASE
{
    HTTP_SERVICE_BINDING_TYPE Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_binding_a
struct HTTP_SERVICE_BINDING_A
{
    HTTP_SERVICE_BINDING_BASE Base;
    PSTR Buffer;
    uint BufferSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_binding_w
struct HTTP_SERVICE_BINDING_W
{
    HTTP_SERVICE_BINDING_BASE Base;
    PWSTR Buffer;
    uint  BufferSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_channel_bind_info
struct HTTP_CHANNEL_BIND_INFO
{
    HTTP_AUTHENTICATION_HARDENING_LEVELS Hardening;
    uint Flags;
    HTTP_SERVICE_BINDING_BASE** ServiceNames;
    uint NumberOfServiceNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_channel_bind_status
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_logging_info
struct HTTP_LOGGING_INFO
{
    HTTP_PROPERTY_FLAGS  Flags;
    uint                 LoggingFlags;
    const(PWSTR)         SoftwareName;
    ushort               SoftwareNameLength;
    ushort               DirectoryNameLength;
    const(PWSTR)         DirectoryName;
    HTTP_LOGGING_TYPE    Format;
    uint                 Fields;
    void*                pExtFields;
    ushort               NumOfExtFields;
    ushort               MaxRecordSize;
    HTTP_LOGGING_ROLLOVER_TYPE RolloverType;
    uint                 RolloverSize;
    PSECURITY_DESCRIPTOR pSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_binding_info
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

struct HTTP_REQUEST_INFO_PROPERTY_INFO
{
    HTTP_PROPERTY_FLAGS Flags;
    ulong               RequestInfoFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_byte_range
struct HTTP_BYTE_RANGE
{
    ulong StartingOffset;
    ulong Length;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_version
struct HTTP_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_known_header
struct HTTP_KNOWN_HEADER
{
    ushort      RawValueLength;
    const(PSTR) pRawValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_unknown_header
struct HTTP_UNKNOWN_HEADER
{
    ushort      NameLength;
    ushort      RawValueLength;
    const(PSTR) pName;
    const(PSTR) pRawValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_log_data
struct HTTP_LOG_DATA
{
    HTTP_LOG_DATA_TYPE Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_log_fields_data
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
    PWSTR         UserName;
    PWSTR         UriStem;
    PSTR          ClientIp;
    PSTR          ServerName;
    PSTR          ServiceName;
    PSTR          ServerIp;
    PSTR          Method;
    PSTR          UriQuery;
    PSTR          Host;
    PSTR          UserAgent;
    PSTR          Cookie;
    PSTR          Referrer;
    ushort        ServerPort;
    ushort        ProtocolStatus;
    uint          Win32Status;
    HTTP_VERB     MethodNum;
    ushort        SubStatus;
}

struct HTTP_WINHTTP_FAST_FORWARDING_DATA
{
    ubyte[16] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_data_chunk
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
            ushort       FragmentNameLength;
            const(PWSTR) pFragmentName;
        }
        struct FromFragmentCacheEx
        {
            HTTP_BYTE_RANGE ByteRange;
            const(PWSTR)    pFragmentName;
        }
        struct Trailers
        {
            ushort               TrailerCount;
            HTTP_UNKNOWN_HEADER* pTrailers;
        }
        struct FromWinHttpFastForwarding
        {
            HTTP_WINHTTP_FAST_FORWARDING_DATA WhFastForwardingData;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_headers
struct HTTP_REQUEST_HEADERS
{
    ushort               UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort               TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER[41] KnownHeaders;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_response_headers
struct HTTP_RESPONSE_HEADERS
{
    ushort               UnknownHeaderCount;
    HTTP_UNKNOWN_HEADER* pUnknownHeaders;
    ushort               TrailerCount;
    HTTP_UNKNOWN_HEADER* pTrailers;
    HTTP_KNOWN_HEADER[30] KnownHeaders;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_delegate_request_property_info
struct HTTP_DELEGATE_REQUEST_PROPERTY_INFO
{
    HTTP_DELEGATE_REQUEST_PROPERTY_ID PropertyId;
    uint  PropertyInfoLength;
    void* PropertyInfo;
}

struct HTTP_CREATE_REQUEST_QUEUE_PROPERTY_INFO
{
    HTTP_CREATE_REQUEST_QUEUE_PROPERTY_ID PropertyId;
    uint  PropertyInfoLength;
    void* PropertyInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_transport_address
struct HTTP_TRANSPORT_ADDRESS
{
    SOCKADDR* pRemoteAddress;
    SOCKADDR* pLocalAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_cooked_url
struct HTTP_COOKED_URL
{
    ushort       FullUrlLength;
    ushort       HostLength;
    ushort       AbsPathLength;
    ushort       QueryStringLength;
    const(PWSTR) pFullUrl;
    const(PWSTR) pHost;
    const(PWSTR) pAbsPath;
    const(PWSTR) pQueryString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_ssl_client_cert_info
struct HTTP_SSL_CLIENT_CERT_INFO
{
    uint    CertFlags;
    uint    CertEncodedSize;
    ubyte*  pCertEncoded;
    HANDLE  Token;
    BOOLEAN CertDeniedByMapper;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_ssl_info
struct HTTP_SSL_INFO
{
    ushort      ServerCertKeySize;
    ushort      ConnectionKeySize;
    uint        ServerCertIssuerSize;
    uint        ServerCertSubjectSize;
    const(PSTR) pServerCertIssuer;
    const(PSTR) pServerCertSubject;
    HTTP_SSL_CLIENT_CERT_INFO* pClientCertInfo;
    uint        SslClientCertNegotiated;
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

struct HTTP_REQUEST_TRANSPORT_IDLE_CONNECTION_TIMEOUT_INFO
{
    ushort TransportIdleConnectionTimeout;
}

struct HTTP_REQUEST_DSCP_INFO
{
    ubyte DscpTag;
}

struct HTTP_REQUEST_INITIAL_PACKET_TTL_INFO
{
    ubyte InitialPacketTtl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_info
struct HTTP_REQUEST_INFO
{
    HTTP_REQUEST_INFO_TYPE InfoType;
    uint  InfoLength;
    void* pInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_auth_info
struct HTTP_REQUEST_AUTH_INFO
{
    HTTP_AUTH_STATUS AuthStatus;
    HRESULT          SecStatus;
    uint             Flags;
    HTTP_REQUEST_AUTH_TYPE AuthType;
    HANDLE           AccessToken;
    uint             ContextAttributes;
    uint             PackedContextLength;
    uint             PackedContextType;
    void*            PackedContext;
    uint             MutualAuthDataLength;
    PSTR             pMutualAuthData;
    ushort           PackageNameLength;
    PWSTR            pPackageName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_v1
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
    const(PSTR)          pUnknownVerb;
    const(PSTR)          pRawUrl;
    HTTP_COOKED_URL      CookedUrl;
    HTTP_TRANSPORT_ADDRESS Address;
    HTTP_REQUEST_HEADERS Headers;
    ulong                BytesReceived;
    ushort               EntityChunkCount;
    HTTP_DATA_CHUNK*     pEntityChunks;
    ulong                RawConnectionId;
    HTTP_SSL_INFO*       pSslInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_v2
struct HTTP_REQUEST_V2
{
    HTTP_REQUEST_V1    Base;
    ushort             RequestInfoCount;
    HTTP_REQUEST_INFO* pRequestInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_response_v1
struct HTTP_RESPONSE_V1
{
    uint             Flags;
    HTTP_VERSION     Version;
    ushort           StatusCode;
    ushort           ReasonLength;
    const(PSTR)      pReason;
    HTTP_RESPONSE_HEADERS Headers;
    ushort           EntityChunkCount;
    HTTP_DATA_CHUNK* pEntityChunks;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_response_info
struct HTTP_RESPONSE_INFO
{
    HTTP_RESPONSE_INFO_TYPE Type;
    uint  Length;
    void* pInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_multiple_known_headers
struct HTTP_MULTIPLE_KNOWN_HEADERS
{
    HTTP_HEADER_ID     HeaderId;
    uint               Flags;
    ushort             KnownHeaderCount;
    HTTP_KNOWN_HEADER* KnownHeaders;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_response_v2
struct HTTP_RESPONSE_V2
{
    HTTP_RESPONSE_V1    Base;
    ushort              ResponseInfoCount;
    HTTP_RESPONSE_INFO* pResponseInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-httpapi_version
struct HTTPAPI_VERSION
{
    ushort HttpApiMajorVersion;
    ushort HttpApiMinorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_cache_policy
struct HTTP_CACHE_POLICY
{
    HTTP_CACHE_POLICY_TYPE Policy;
    uint SecondsToLive;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_key
struct HTTP_SERVICE_CONFIG_SSL_KEY
{
    SOCKADDR* pIpPort;
}

struct HTTP_SERVICE_CONFIG_SSL_KEY_EX
{
    SOCKADDR_STORAGE IpPort;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_sni_key
struct HTTP_SERVICE_CONFIG_SSL_SNI_KEY
{
    SOCKADDR_STORAGE IpPort;
    PWSTR            Host;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_ccs_key
struct HTTP_SERVICE_CONFIG_SSL_CCS_KEY
{
    SOCKADDR_STORAGE LocalAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_param
struct HTTP_SERVICE_CONFIG_SSL_PARAM
{
    uint  SslHashLength;
    void* pSslHash;
    GUID  AppId;
    PWSTR pSslCertStoreName;
    uint  DefaultCertCheckMode;
    uint  DefaultRevocationFreshnessTime;
    uint  DefaultRevocationUrlRetrievalTimeout;
    PWSTR pDefaultSslCtlIdentifier;
    PWSTR pDefaultSslCtlStoreName;
    uint  DefaultFlags;
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
    HTTP_PERFORMANCE_PARAM_TYPE Type;
    uint  BufferSize;
    void* Buffer;
}

struct HTTP_TLS_RESTRICTIONS_PARAM
{
    uint  RestrictionCount;
    void* TlsRestrictions;
}

struct HTTP_ERROR_HEADERS_PARAM
{
    ushort               StatusCode;
    ushort               HeaderCount;
    HTTP_UNKNOWN_HEADER* Headers;
}

struct HTTP_TLS_SESSION_TICKET_KEYS_PARAM
{
    uint  SessionTicketKeyCount;
    void* SessionTicketKeys;
}

struct HTTP_CERT_CONFIG_ENTRY
{
    ubyte[20]  CertHash;
    wchar[128] CertStoreName;
}

struct HTTP_CERT_CONFIG_PARAM
{
    uint CertConfigCount;
    HTTP_CERT_CONFIG_ENTRY* CertConfigs;
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
        HTTP_TLS_RESTRICTIONS_PARAM HttpTlsRestrictionsParam;
        HTTP_ERROR_HEADERS_PARAM HttpErrorHeadersParam;
        HTTP_TLS_SESSION_TICKET_KEYS_PARAM HttpTlsSessionTicketKeysParam;
        HTTP_CERT_CONFIG_PARAM HttpCertConfigParam;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_set
struct HTTP_SERVICE_CONFIG_SSL_SET
{
    HTTP_SERVICE_CONFIG_SSL_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM ParamDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_sni_set
struct HTTP_SERVICE_CONFIG_SSL_SNI_SET
{
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_SSL_PARAM ParamDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_ccs_set
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_query
struct HTTP_SERVICE_CONFIG_SSL_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_KEY KeyDesc;
    uint dwToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_sni_query
struct HTTP_SERVICE_CONFIG_SSL_SNI_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_SSL_SNI_KEY KeyDesc;
    uint dwToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ssl_ccs_query
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ip_listen_param
struct HTTP_SERVICE_CONFIG_IP_LISTEN_PARAM
{
    ushort    AddrLength;
    SOCKADDR* pAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_ip_listen_query
struct HTTP_SERVICE_CONFIG_IP_LISTEN_QUERY
{
    uint                AddrCount;
    SOCKADDR_STORAGE[1] AddrList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_urlacl_key
struct HTTP_SERVICE_CONFIG_URLACL_KEY
{
    PWSTR pUrlPrefix;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_urlacl_param
struct HTTP_SERVICE_CONFIG_URLACL_PARAM
{
    PWSTR pStringSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_urlacl_set
struct HTTP_SERVICE_CONFIG_URLACL_SET
{
    HTTP_SERVICE_CONFIG_URLACL_KEY KeyDesc;
    HTTP_SERVICE_CONFIG_URLACL_PARAM ParamDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_urlacl_query
struct HTTP_SERVICE_CONFIG_URLACL_QUERY
{
    HTTP_SERVICE_CONFIG_QUERY_TYPE QueryDesc;
    HTTP_SERVICE_CONFIG_URLACL_KEY KeyDesc;
    uint dwToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_service_config_cache_set
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
    wchar[256] Hostname;
    uint       Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/ns-http-http_request_property_stream_error
struct HTTP_REQUEST_PROPERTY_STREAM_ERROR
{
    uint ErrorCode;
}

struct HTTP_WSK_API_TIMINGS
{
    ulong ConnectCount;
    ulong ConnectSum;
    ulong DisconnectCount;
    ulong DisconnectSum;
    ulong SendCount;
    ulong SendSum;
    ulong ReceiveCount;
    ulong ReceiveSum;
    ulong ReleaseCount;
    ulong ReleaseSum;
    ulong ControlSocketCount;
    ulong ControlSocketSum;
}

struct HTTP_QUIC_STREAM_API_TIMINGS
{
    ulong OpenCount;
    ulong OpenSum;
    ulong CloseCount;
    ulong CloseSum;
    ulong StartCount;
    ulong StartSum;
    ulong ShutdownCount;
    ulong ShutdownSum;
    ulong SendCount;
    ulong SendSum;
    ulong ReceiveSetEnabledCount;
    ulong ReceiveSetEnabledSum;
    ulong GetParamCount;
    ulong GetParamSum;
    ulong SetParamCount;
    ulong SetParamSum;
    ulong SetCallbackHandlerCount;
    ulong SetCallbackHandlerSum;
}

struct HTTP_QUIC_CONNECTION_API_TIMINGS
{
    ulong OpenTime;
    ulong CloseTime;
    ulong StartTime;
    ulong ShutdownTime;
    ulong SecConfigCreateTime;
    ulong SecConfigDeleteTime;
    ulong GetParamCount;
    ulong GetParamSum;
    ulong SetParamCount;
    ulong SetParamSum;
    ulong SetCallbackHandlerCount;
    ulong SetCallbackHandlerSum;
    HTTP_QUIC_STREAM_API_TIMINGS ControlStreamTimings;
}

struct HTTP_QUIC_API_TIMINGS
{
    HTTP_QUIC_CONNECTION_API_TIMINGS ConnectionTimings;
    HTTP_QUIC_STREAM_API_TIMINGS StreamTimings;
}

struct HTTP_QUIC_STREAM_REQUEST_STATS
{
    ulong StreamWaitStart;
    ulong StreamWaitEnd;
    ulong RequestHeadersCompressionStart;
    ulong RequestHeadersCompressionEnd;
    ulong ResponseHeadersDecompressionStart;
    ulong ResponseHeadersDecompressionEnd;
    ulong RequestHeadersCompressedSize;
    ulong ResponseHeadersCompressedSize;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpInitialize(HTTPAPI_VERSION Version, HTTP_INITIALIZE Flags, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpTerminate(HTTP_INITIALIZE Flags, 
                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCreateHttpHandle(HANDLE* RequestQueueHandle, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCreateRequestQueue(HTTPAPI_VERSION Version, const(PWSTR) Name, SECURITY_ATTRIBUTES* SecurityAttributes, 
                            uint Flags, HTTP_REQUEST_QUEUE_HANDLE* RequestQueueHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCloseRequestQueue(HTTP_REQUEST_QUEUE_HANDLE RequestQueueHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpSetRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                                 uint PropertyInformationLength, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved1, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpQueryRequestQueueProperty(HANDLE RequestQueueHandle, HTTP_SERVER_PROPERTY Property, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                                   uint PropertyInformationLength, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved1, 
                                   uint* ReturnLength, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved2);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/nf-http-httpsetrequestproperty
@DllImport("HTTPAPI.dll")
uint HttpSetRequestProperty(HANDLE RequestQueueHandle, ulong Id, HTTP_REQUEST_PROPERTY PropertyId, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Input, 
                            uint InputPropertySize, OVERLAPPED* Overlapped);

@DllImport("HTTPAPI.dll")
uint HttpQueryRequestProperty(HANDLE RequestQueueHandle, ulong Id, HTTP_REQUEST_PROPERTY PropertyId, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* Qualifier, 
                              uint QualifierSize, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* Output, 
                              uint OutputBufferSize, uint* BytesReturned, OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpShutdownRequestQueue(HANDLE RequestQueueHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpReceiveClientCertificate(HANDLE RequestQueueHandle, ulong ConnectionId, uint Flags, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/HTTP_SSL_CLIENT_CERT_INFO* SslClientCertInfo, 
                                  uint SslClientCertInfoSize, uint* BytesReceived, 
                                  /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCreateServerSession(HTTPAPI_VERSION Version, ulong* ServerSessionId, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCloseServerSession(ulong ServerSessionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpQueryServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                                    uint PropertyInformationLength, uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpSetServerSessionProperty(ulong ServerSessionId, HTTP_SERVER_PROPERTY Property, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                                  uint PropertyInformationLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpAddUrl(HANDLE RequestQueueHandle, const(PWSTR) FullyQualifiedUrl, 
                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpRemoveUrl(HANDLE RequestQueueHandle, const(PWSTR) FullyQualifiedUrl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCreateUrlGroup(ulong ServerSessionId, ulong* pUrlGroupId, 
                        /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCloseUrlGroup(ulong UrlGroupId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpAddUrlToUrlGroup(ulong UrlGroupId, const(PWSTR) pFullyQualifiedUrl, ulong UrlContext, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpRemoveUrlFromUrlGroup(ulong UrlGroupId, const(PWSTR) pFullyQualifiedUrl, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpSetUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                             uint PropertyInformationLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpQueryUrlGroupProperty(ulong UrlGroupId, HTTP_SERVER_PROPERTY Property, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* PropertyInformation, 
                               uint PropertyInformationLength, uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("HTTPAPI.dll")
uint HttpPrepareUrl(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, const(PWSTR) Url, 
                    PWSTR* PreparedUrl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpReceiveHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, HTTP_RECEIVE_HTTP_REQUEST_FLAGS Flags, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/HTTP_REQUEST_V2* RequestBuffer, 
                            uint RequestBufferLength, uint* BytesReturned, 
                            /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpReceiveRequestEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* EntityBuffer, 
                                  uint EntityBufferLength, uint* BytesReturned, 
                                  /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpSendHttpResponse(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, HTTP_RESPONSE_V2* HttpResponse, 
                          HTTP_CACHE_POLICY* CachePolicy, uint* BytesSent, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved1, 
                          /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved2, 
                          /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped, 
                          HTTP_LOG_DATA* LogData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpSendResponseEntityBody(HANDLE RequestQueueHandle, ulong RequestId, uint Flags, ushort EntityChunkCount, 
                                HTTP_DATA_CHUNK* EntityChunks, uint* BytesSent, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* Reserved1, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved2, 
                                /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped, 
                                HTTP_LOG_DATA* LogData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("HTTPAPI.dll")
uint HttpDeclarePush(HANDLE RequestQueueHandle, ulong RequestId, HTTP_VERB Verb, const(PWSTR) Path, 
                     const(PSTR) Query, HTTP_REQUEST_HEADERS* Headers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpWaitForDisconnect(HANDLE RequestQueueHandle, ulong ConnectionId, 
                           /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/nf-http-httpwaitfordisconnectex
@DllImport("HTTPAPI.dll")
uint HttpWaitForDisconnectEx(HANDLE RequestQueueHandle, ulong ConnectionId, 
                             /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Reserved, 
                             /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpCancelHttpRequest(HANDLE RequestQueueHandle, ulong RequestId, 
                           /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpWaitForDemandStart(HANDLE RequestQueueHandle, 
                            /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/nf-http-httpisfeaturesupported
@DllImport("HTTPAPI.dll")
BOOL HttpIsFeatureSupported(HTTP_FEATURE_ID FeatureId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/nf-http-httpdelegaterequestex
@DllImport("HTTPAPI.dll")
uint HttpDelegateRequestEx(HANDLE RequestQueueHandle, HANDLE DelegateQueueHandle, ulong RequestId, 
                           ulong DelegateUrlGroupId, uint PropertyInfoSetSize, 
                           HTTP_DELEGATE_REQUEST_PROPERTY_INFO* PropertyInfoSet);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/http/nf-http-httpfindurlgroupid
@DllImport("HTTPAPI.dll")
uint HttpFindUrlGroupId(const(PWSTR) FullyQualifiedUrl, HANDLE RequestQueueHandle, ulong* UrlGroupId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpFlushResponseCache(HANDLE RequestQueueHandle, const(PWSTR) UrlPrefix, uint Flags, 
                            /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpAddFragmentToCache(HANDLE RequestQueueHandle, const(PWSTR) UrlPrefix, HTTP_DATA_CHUNK* DataChunk, 
                            HTTP_CACHE_POLICY* CachePolicy, 
                            /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpReadFragmentFromCache(HANDLE RequestQueueHandle, const(PWSTR) UrlPrefix, HTTP_BYTE_RANGE* ByteRange, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* Buffer, 
                               uint BufferLength, uint* BytesRead, 
                               /*PARAM ATTR: RetainedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("HTTPAPI.dll")
uint HttpSetServiceConfiguration(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE ServiceHandle, 
                                 HTTP_SERVICE_CONFIG_ID ConfigId, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pConfigInformation, 
                                 uint ConfigInformationLength, 
                                 /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.15063))], [])
@DllImport("HTTPAPI.dll")
uint HttpUpdateServiceConfiguration(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE Handle, 
                                    HTTP_SERVICE_CONFIG_ID ConfigId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ConfigInfo, 
                                    uint ConfigInfoLength, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* Overlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpDeleteServiceConfiguration(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE ServiceHandle, 
                                    HTTP_SERVICE_CONFIG_ID ConfigId, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pConfigInformation, 
                                    uint ConfigInformationLength, 
                                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* pOverlapped);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("HTTPAPI.dll")
uint HttpQueryServiceConfiguration(/*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/HANDLE ServiceHandle, 
                                   HTTP_SERVICE_CONFIG_ID ConfigId, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pInput, 
                                   uint InputLength, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pOutput, 
                                   uint OutputLength, uint* pReturnLength, 
                                   /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/OVERLAPPED* pOverlapped);

@DllImport("HTTPAPI.dll")
uint HttpGetExtension(HTTPAPI_VERSION Version, uint Extension, void* Buffer, uint BufferSize);


