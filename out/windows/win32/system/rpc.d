// Written in the D programming language.

module windows.win32.system.rpc;

public import windows.core;
public import windows.win32.foundation : BOOL, FILETIME, HANDLE, HRESULT, HWND, LUID,
                                         PSTR, PWSTR, SYSTEMTIME;
public import windows.win32.security.cryptography : CERT_CONTEXT;
public import windows.win32.system.com : IRpcChannelBuffer, IRpcStubBuffer, IUnknown,
                                         RPC_C_IMP_LEVEL;
public import windows.win32.system.io : OVERLAPPED;

extern(Windows) @nogc nothrow:


// Enums


alias RPC_C_QOS_CAPABILITIES = uint;
enum : uint
{
    RPC_C_QOS_CAPABILITIES_DEFAULT                     = 0x00000000U,
    RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH                 = 0x00000001U,
    RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC                = 0x00000002U,
    RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY               = 0x00000004U,
    RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE     = 0x00000008U,
    RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT               = 0x00000010U,
    RPC_C_QOS_CAPABILITIES_SCHANNEL_FULL_AUTH_IDENTITY = 0x00000020U,
}

alias RPC_C_QOS_IDENTITY = uint;
enum : uint
{
    RPC_C_QOS_IDENTITY_STATIC  = 0x00000000U,
    RPC_C_QOS_IDENTITY_DYNAMIC = 0x00000001U,
}

alias RPC_C_AUTHN_INFO_TYPE = uint;
enum : uint
{
    RPC_C_AUTHN_INFO_NONE      = 0x00000000U,
    RPC_C_AUTHN_INFO_TYPE_HTTP = 0x00000001U,
}

alias RPC_C_HTTP_FLAGS = uint;
enum : uint
{
    RPC_C_HTTP_FLAG_USE_SSL                      = 0x00000001U,
    RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME        = 0x00000002U,
    RPC_C_HTTP_FLAG_IGNORE_CERT_CN_INVALID       = 0x00000008U,
    RPC_C_HTTP_FLAG_ENABLE_CERT_REVOCATION_CHECK = 0x00000010U,
}

alias RPC_C_HTTP_AUTHN_TARGET = uint;
enum : uint
{
    RPC_C_HTTP_AUTHN_TARGET_SERVER = 0x00000001U,
    RPC_C_HTTP_AUTHN_TARGET_PROXY  = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Rpc/rpc-status
alias RPC_STATUS = int;
enum : int
{
    RPC_S_OK                           = 0x00000000,
    RPC_S_ACCESS_DENIED                = 0x00000005,
    RPC_S_INVALID_ARG                  = 0x00000057,
    RPC_S_OUT_OF_MEMORY                = 0x0000000e,
    RPC_S_OUT_OF_THREADS               = 0x000000a4,
    RPC_S_INVALID_LEVEL                = 0x00000057,
    RPC_S_BUFFER_TOO_SMALL             = 0x0000007a,
    RPC_S_INVALID_SECURITY_DESC        = 0x0000053a,
    RPC_S_SERVER_OUT_OF_MEMORY         = 0x0000046a,
    RPC_S_ASYNC_CALL_PENDING           = 0x000003e5,
    RPC_S_UNKNOWN_PRINCIPAL            = 0x00000534,
    RPC_S_TIMEOUT                      = 0x000005b4,
    RPC_S_RUNTIME_UNINITIALIZED        = 0x00000001,
    RPC_S_NOT_ENOUGH_QUOTA             = 0x00000718,
    RPC_S_INVALID_STRING_BINDING       = 0x000006a4,
    RPC_S_WRONG_KIND_OF_BINDING        = 0x000006a5,
    RPC_S_INVALID_BINDING              = 0x000006a6,
    RPC_S_PROTSEQ_NOT_SUPPORTED        = 0x000006a7,
    RPC_S_INVALID_RPC_PROTSEQ          = 0x000006a8,
    RPC_S_INVALID_STRING_UUID          = 0x000006a9,
    RPC_S_INVALID_ENDPOINT_FORMAT      = 0x000006aa,
    RPC_S_INVALID_NET_ADDR             = 0x000006ab,
    RPC_S_NO_ENDPOINT_FOUND            = 0x000006ac,
    RPC_S_INVALID_TIMEOUT              = 0x000006ad,
    RPC_S_OBJECT_NOT_FOUND             = 0x000006ae,
    RPC_S_ALREADY_REGISTERED           = 0x000006af,
    RPC_S_TYPE_ALREADY_REGISTERED      = 0x000006b0,
    RPC_S_ALREADY_LISTENING            = 0x000006b1,
    RPC_S_NO_PROTSEQS_REGISTERED       = 0x000006b2,
    RPC_S_NOT_LISTENING                = 0x000006b3,
    RPC_S_UNKNOWN_MGR_TYPE             = 0x000006b4,
    RPC_S_UNKNOWN_IF                   = 0x000006b5,
    RPC_S_NO_BINDINGS                  = 0x000006b6,
    RPC_S_NO_PROTSEQS                  = 0x000006b7,
    RPC_S_CANT_CREATE_ENDPOINT         = 0x000006b8,
    RPC_S_OUT_OF_RESOURCES             = 0x000006b9,
    RPC_S_SERVER_UNAVAILABLE           = 0x000006ba,
    RPC_S_SERVER_TOO_BUSY              = 0x000006bb,
    RPC_S_INVALID_NETWORK_OPTIONS      = 0x000006bc,
    RPC_S_NO_CALL_ACTIVE               = 0x000006bd,
    RPC_S_CALL_FAILED                  = 0x000006be,
    RPC_S_CALL_FAILED_DNE              = 0x000006bf,
    RPC_S_PROTOCOL_ERROR               = 0x000006c0,
    RPC_S_PROXY_ACCESS_DENIED          = 0x000006c1,
    RPC_S_UNSUPPORTED_TRANS_SYN        = 0x000006c2,
    RPC_S_UNSUPPORTED_TYPE             = 0x000006c4,
    RPC_S_INVALID_TAG                  = 0x000006c5,
    RPC_S_INVALID_BOUND                = 0x000006c6,
    RPC_S_NO_ENTRY_NAME                = 0x000006c7,
    RPC_S_INVALID_NAME_SYNTAX          = 0x000006c8,
    RPC_S_UNSUPPORTED_NAME_SYNTAX      = 0x000006c9,
    RPC_S_UUID_NO_ADDRESS              = 0x000006cb,
    RPC_S_DUPLICATE_ENDPOINT           = 0x000006cc,
    RPC_S_UNKNOWN_AUTHN_TYPE           = 0x000006cd,
    RPC_S_MAX_CALLS_TOO_SMALL          = 0x000006ce,
    RPC_S_STRING_TOO_LONG              = 0x000006cf,
    RPC_S_PROTSEQ_NOT_FOUND            = 0x000006d0,
    RPC_S_PROCNUM_OUT_OF_RANGE         = 0x000006d1,
    RPC_S_BINDING_HAS_NO_AUTH          = 0x000006d2,
    RPC_S_UNKNOWN_AUTHN_SERVICE        = 0x000006d3,
    RPC_S_UNKNOWN_AUTHN_LEVEL          = 0x000006d4,
    RPC_S_INVALID_AUTH_IDENTITY        = 0x000006d5,
    RPC_S_UNKNOWN_AUTHZ_SERVICE        = 0x000006d6,
    EPT_S_INVALID_ENTRY                = 0x000006d7,
    EPT_S_CANT_PERFORM_OP              = 0x000006d8,
    EPT_S_NOT_REGISTERED               = 0x000006d9,
    RPC_S_NOTHING_TO_EXPORT            = 0x000006da,
    RPC_S_INCOMPLETE_NAME              = 0x000006db,
    RPC_S_INVALID_VERS_OPTION          = 0x000006dc,
    RPC_S_NO_MORE_MEMBERS              = 0x000006dd,
    RPC_S_NOT_ALL_OBJS_UNEXPORTED      = 0x000006de,
    RPC_S_INTERFACE_NOT_FOUND          = 0x000006df,
    RPC_S_ENTRY_ALREADY_EXISTS         = 0x000006e0,
    RPC_S_ENTRY_NOT_FOUND              = 0x000006e1,
    RPC_S_NAME_SERVICE_UNAVAILABLE     = 0x000006e2,
    RPC_S_INVALID_NAF_ID               = 0x000006e3,
    RPC_S_CANNOT_SUPPORT               = 0x000006e4,
    RPC_S_NO_CONTEXT_AVAILABLE         = 0x000006e5,
    RPC_S_INTERNAL_ERROR               = 0x000006e6,
    RPC_S_ZERO_DIVIDE                  = 0x000006e7,
    RPC_S_ADDRESS_ERROR                = 0x000006e8,
    RPC_S_FP_DIV_ZERO                  = 0x000006e9,
    RPC_S_FP_UNDERFLOW                 = 0x000006ea,
    RPC_S_FP_OVERFLOW                  = 0x000006eb,
    RPC_S_CALL_IN_PROGRESS             = 0x000006ff,
    RPC_S_NO_MORE_BINDINGS             = 0x0000070e,
    RPC_S_NO_INTERFACES                = 0x00000719,
    RPC_S_CALL_CANCELLED               = 0x0000071a,
    RPC_S_BINDING_INCOMPLETE           = 0x0000071b,
    RPC_S_COMM_FAILURE                 = 0x0000071c,
    RPC_S_UNSUPPORTED_AUTHN_LEVEL      = 0x0000071d,
    RPC_S_NO_PRINC_NAME                = 0x0000071e,
    RPC_S_NOT_RPC_ERROR                = 0x0000071f,
    RPC_S_UUID_LOCAL_ONLY              = 0x00000720,
    RPC_S_SEC_PKG_ERROR                = 0x00000721,
    RPC_S_NOT_CANCELLED                = 0x00000722,
    RPC_S_COOKIE_AUTH_FAILED           = 0x00000729,
    RPC_S_DO_NOT_DISTURB               = 0x0000072a,
    RPC_S_SYSTEM_HANDLE_COUNT_EXCEEDED = 0x0000072b,
    RPC_S_SYSTEM_HANDLE_TYPE_MISMATCH  = 0x0000072c,
    RPC_S_GROUP_MEMBER_NOT_FOUND       = 0x0000076a,
    EPT_S_CANT_CREATE                  = 0x0000076b,
    RPC_S_INVALID_OBJECT               = 0x0000076c,
    RPC_S_SEND_INCOMPLETE              = 0x00000779,
    RPC_S_INVALID_ASYNC_HANDLE         = 0x0000077a,
    RPC_S_INVALID_ASYNC_CALL           = 0x0000077b,
    RPC_S_ENTRY_TYPE_MISMATCH          = 0x00000782,
    RPC_S_NOT_ALL_OBJS_EXPORTED        = 0x00000783,
    RPC_S_INTERFACE_NOT_EXPORTED       = 0x00000784,
    RPC_S_PROFILE_NOT_ADDED            = 0x00000785,
    RPC_S_PRF_ELT_NOT_ADDED            = 0x00000786,
    RPC_S_PRF_ELT_NOT_REMOVED          = 0x00000787,
    RPC_S_GRP_ELT_NOT_ADDED            = 0x00000788,
    RPC_S_GRP_ELT_NOT_REMOVED          = 0x00000789,
}

alias GROUP_NAME_SYNTAX = uint;
enum : uint
{
    RPC_C_NS_SYNTAX_DEFAULT = 0x00000000U,
    RPC_C_NS_SYNTAX_DCE     = 0x00000003U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_winnt_auth_identity_w
alias SEC_WINNT_AUTH_IDENTITY = uint;
enum : uint
{
    SEC_WINNT_AUTH_IDENTITY_ANSI    = 0x00000001U,
    SEC_WINNT_AUTH_IDENTITY_UNICODE = 0x00000002U,
}

alias RPC_BINDING_HANDLE_OPTIONS_FLAGS = uint;
enum : uint
{
    RPC_BHO_NONCAUSAL  = 0x00000001U,
    RPC_BHO_DONTLINGER = 0x00000002U,
}

alias RPC_HTTP_REDIRECTOR_STAGE = int;
enum : int
{
    RPCHTTP_RS_REDIRECT  = 0x00000001,
    RPCHTTP_RS_ACCESS_1  = 0x00000002,
    RPCHTTP_RS_SESSION   = 0x00000003,
    RPCHTTP_RS_ACCESS_2  = 0x00000004,
    RPCHTTP_RS_INTERFACE = 0x00000005,
}

alias RPC_ADDRESS_CHANGE_TYPE = int;
enum : int
{
    PROTOCOL_NOT_LOADED     = 0x00000001,
    PROTOCOL_LOADED         = 0x00000002,
    PROTOCOL_ADDRESS_CHANGE = 0x00000003,
}

alias LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION = int;
enum : int
{
    MarshalDirectionMarshal   = 0x00000000,
    MarshalDirectionUnmarshal = 0x00000001,
}

enum RpcPerfCounters : int
{
    RpcCurrentUniqueUser         = 0x00000001,
    RpcBackEndConnectionAttempts = 0x00000002,
    RpcBackEndConnectionFailed   = 0x00000003,
    RpcRequestsPerSecond         = 0x00000004,
    RpcIncomingConnections       = 0x00000005,
    RpcIncomingBandwidth         = 0x00000006,
    RpcOutgoingBandwidth         = 0x00000007,
    RpcAttemptedLbsDecisions     = 0x00000008,
    RpcFailedLbsDecisions        = 0x00000009,
    RpcAttemptedLbsMessages      = 0x0000000a,
    RpcFailedLbsMessages         = 0x0000000b,
    RpcLastCounter               = 0x0000000c,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpc_notification_types
alias RPC_NOTIFICATION_TYPES = int;
enum : int
{
    RpcNotificationTypeNone     = 0x00000000,
    RpcNotificationTypeEvent    = 0x00000001,
    RpcNotificationTypeApc      = 0x00000002,
    RpcNotificationTypeIoc      = 0x00000003,
    RpcNotificationTypeHwnd     = 0x00000004,
    RpcNotificationTypeCallback = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpc_async_event
alias RPC_ASYNC_EVENT = int;
enum : int
{
    RpcCallComplete     = 0x00000000,
    RpcSendComplete     = 0x00000001,
    RpcReceiveComplete  = 0x00000002,
    RpcClientDisconnect = 0x00000003,
    RpcClientCancel     = 0x00000004,
}

enum ExtendedErrorParamTypes : int
{
    eeptAnsiString    = 0x00000001,
    eeptUnicodeString = 0x00000002,
    eeptLongVal       = 0x00000003,
    eeptShortVal      = 0x00000004,
    eeptPointerVal    = 0x00000005,
    eeptNone          = 0x00000006,
    eeptBinary        = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpclocaladdressformat
enum RpcLocalAddressFormat : int
{
    rlafInvalid = 0x00000000,
    rlafIPv4    = 0x00000001,
    rlafIPv6    = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpccalltype
enum RpcCallType : int
{
    rctInvalid    = 0x00000000,
    rctNormal     = 0x00000001,
    rctTraining   = 0x00000002,
    rctGuaranteed = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpccallclientlocality
enum RpcCallClientLocality : int
{
    rcclInvalid               = 0x00000000,
    rcclLocal                 = 0x00000001,
    rcclRemote                = 0x00000002,
    rcclClientUnknownLocality = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ne-rpcasync-rpc_notifications
alias RPC_NOTIFICATIONS = int;
enum : int
{
    RpcNotificationCallNone         = 0x00000000,
    RpcNotificationClientDisconnect = 0x00000001,
    RpcNotificationCallCancel       = 0x00000002,
}

alias USER_MARSHAL_CB_TYPE = int;
enum : int
{
    USER_MARSHAL_CB_BUFFER_SIZE = 0x00000000,
    USER_MARSHAL_CB_MARSHALL    = 0x00000001,
    USER_MARSHAL_CB_UNMARSHALL  = 0x00000002,
    USER_MARSHAL_CB_FREE        = 0x00000003,
}

alias IDL_CS_CONVERT = int;
enum : int
{
    IDL_CS_NO_CONVERT         = 0x00000000,
    IDL_CS_IN_PLACE_CONVERT   = 0x00000001,
    IDL_CS_NEW_BUFFER_CONVERT = 0x00000002,
}

alias XLAT_SIDE = int;
enum : int
{
    XLAT_SERVER = 0x00000001,
    XLAT_CLIENT = 0x00000002,
}

alias system_handle_t = int;
enum : int
{
    SYSTEM_HANDLE_FILE               = 0x00000000,
    SYSTEM_HANDLE_SEMAPHORE          = 0x00000001,
    SYSTEM_HANDLE_EVENT              = 0x00000002,
    SYSTEM_HANDLE_MUTEX              = 0x00000003,
    SYSTEM_HANDLE_PROCESS            = 0x00000004,
    SYSTEM_HANDLE_TOKEN              = 0x00000005,
    SYSTEM_HANDLE_SECTION            = 0x00000006,
    SYSTEM_HANDLE_REG_KEY            = 0x00000007,
    SYSTEM_HANDLE_THREAD             = 0x00000008,
    SYSTEM_HANDLE_COMPOSITION_OBJECT = 0x00000009,
    SYSTEM_HANDLE_SOCKET             = 0x0000000a,
    SYSTEM_HANDLE_JOB                = 0x0000000b,
    SYSTEM_HANDLE_PIPE               = 0x0000000c,
    SYSTEM_HANDLE_MAX                = 0x0000000c,
    SYSTEM_HANDLE_INVALID            = 0x000000ff,
}

alias STUB_PHASE = int;
enum : int
{
    STUB_UNMARSHAL              = 0x00000000,
    STUB_CALL_SERVER            = 0x00000001,
    STUB_MARSHAL                = 0x00000002,
    STUB_CALL_SERVER_NO_HRESULT = 0x00000003,
}

alias PROXY_PHASE = int;
enum : int
{
    PROXY_CALCSIZE    = 0x00000000,
    PROXY_GETBUFFER   = 0x00000001,
    PROXY_MARSHAL     = 0x00000002,
    PROXY_SENDRECEIVE = 0x00000003,
    PROXY_UNMARSHAL   = 0x00000004,
}

alias MIDL_ES_CODE = int;
enum : int
{
    MES_ENCODE       = 0x00000000,
    MES_DECODE       = 0x00000001,
    MES_ENCODE_NDR64 = 0x00000002,
}

alias MIDL_ES_HANDLE_STYLE = int;
enum : int
{
    MES_INCREMENTAL_HANDLE    = 0x00000000,
    MES_FIXED_BUFFER_HANDLE   = 0x00000001,
    MES_DYNAMIC_BUFFER_HANDLE = 0x00000002,
}

alias EXPR_TOKEN = int;
enum : int
{
    FC_EXPR_START   = 0x00000000,
    FC_EXPR_ILLEGAL = 0x00000000,
    FC_EXPR_CONST32 = 0x00000001,
    FC_EXPR_CONST64 = 0x00000002,
    FC_EXPR_VAR     = 0x00000003,
    FC_EXPR_OPER    = 0x00000004,
    FC_EXPR_NOOP    = 0x00000005,
    FC_EXPR_END     = 0x00000006,
}

// Constants


enum : uint
{
    RPC_C_BINDING_INFINITE_TIMEOUT = 0x0000000aU,
    RPC_C_BINDING_MIN_TIMEOUT      = 0x00000000U,
    RPC_C_BINDING_DEFAULT_TIMEOUT  = 0x00000005U,
    RPC_C_BINDING_MAX_TIMEOUT      = 0x00000009U,
}

enum int RPC_C_CANCEL_INFINITE_TIMEOUT = 0xffffffff;
enum uint RPC_C_LISTEN_MAX_CALLS_DEFAULT = 0x000004d2U;
enum uint RPC_C_PROTSEQ_MAX_REQS_DEFAULT = 0x0000000aU;
enum uint RPC_C_BIND_TO_ALL_NICS = 0x00000001U;

enum : uint
{
    RPC_C_USE_INTERNET_PORT = 0x00000001U,
    RPC_C_USE_INTRANET_PORT = 0x00000002U,
}

enum uint RPC_C_DONT_FAIL = 0x00000004U;
enum uint RPC_C_RPCHTTP_USE_LOAD_BALANCE = 0x00000008U;
enum uint RPC_C_TRY_ENFORCE_MAX_CALLS = 0x00000010U;

enum : uint
{
    RPC_C_MQ_TEMPORARY             = 0x00000000U,
    RPC_C_MQ_PERMANENT             = 0x00000001U,
    RPC_C_MQ_CLEAR_ON_OPEN         = 0x00000002U,
    RPC_C_MQ_USE_EXISTING_SECURITY = 0x00000004U,
}

enum : uint
{
    RPC_C_MQ_AUTHN_LEVEL_NONE          = 0x00000000U,
    RPC_C_MQ_AUTHN_LEVEL_PKT_INTEGRITY = 0x00000008U,
    RPC_C_MQ_AUTHN_LEVEL_PKT_PRIVACY   = 0x00000010U,
}

enum : uint
{
    RPC_C_MQ_EXPRESS            = 0x00000000U,
    RPC_C_MQ_RECOVERABLE        = 0x00000001U,
    RPC_C_MQ_JOURNAL_NONE       = 0x00000000U,
    RPC_C_MQ_JOURNAL_DEADLETTER = 0x00000001U,
    RPC_C_MQ_JOURNAL_ALWAYS     = 0x00000002U,
}

enum : uint
{
    RPC_C_OPT_MQ_DELIVERY            = 0x00000001U,
    RPC_C_OPT_MQ_PRIORITY            = 0x00000002U,
    RPC_C_OPT_MQ_JOURNAL             = 0x00000003U,
    RPC_C_OPT_MQ_ACKNOWLEDGE         = 0x00000004U,
    RPC_C_OPT_MQ_AUTHN_SERVICE       = 0x00000005U,
    RPC_C_OPT_MQ_AUTHN_LEVEL         = 0x00000006U,
    RPC_C_OPT_MQ_TIME_TO_REACH_QUEUE = 0x00000007U,
    RPC_C_OPT_MQ_TIME_TO_BE_RECEIVED = 0x00000008U,
}

enum uint RPC_C_OPT_BINDING_NONCAUSAL = 0x00000009U;
enum uint RPC_C_OPT_SECURITY_CALLBACK = 0x0000000aU;

enum : uint
{
    RPC_C_OPT_UNIQUE_BINDING         = 0x0000000bU,
    RPC_C_OPT_MAX_OPTIONS            = 0x0000000cU,
    RPC_C_OPT_CALL_TIMEOUT           = 0x0000000cU,
    RPC_C_OPT_DONT_LINGER            = 0x0000000dU,
    RPC_C_OPT_TRANS_SEND_BUFFER_SIZE = 0x00000005U,
}

enum : uint
{
    RPC_C_OPT_TRUST_PEER    = 0x0000000eU,
    RPC_C_OPT_ASYNC_BLOCK   = 0x0000000fU,
    RPC_C_OPT_OPTIMIZE_TIME = 0x00000010U,
}

enum uint RPC_C_FULL_CERT_CHAIN = 0x00000001U;

enum : uint
{
    RPC_C_STATS_CALLS_IN  = 0x00000000U,
    RPC_C_STATS_CALLS_OUT = 0x00000001U,
    RPC_C_STATS_PKTS_IN   = 0x00000002U,
    RPC_C_STATS_PKTS_OUT  = 0x00000003U,
}

enum : uint
{
    RPC_C_AUTHN_NONE          = 0x00000000U,
    RPC_C_AUTHN_DCE_PRIVATE   = 0x00000001U,
    RPC_C_AUTHN_DCE_PUBLIC    = 0x00000002U,
    RPC_C_AUTHN_DEC_PUBLIC    = 0x00000004U,
    RPC_C_AUTHN_GSS_NEGOTIATE = 0x00000009U,
    RPC_C_AUTHN_WINNT         = 0x0000000aU,
    RPC_C_AUTHN_GSS_SCHANNEL  = 0x0000000eU,
    RPC_C_AUTHN_GSS_KERBEROS  = 0x00000010U,
    RPC_C_AUTHN_DPA           = 0x00000011U,
    RPC_C_AUTHN_MSN           = 0x00000012U,
    RPC_C_AUTHN_DIGEST        = 0x00000015U,
    RPC_C_AUTHN_KERNEL        = 0x00000014U,
    RPC_C_AUTHN_NEGO_EXTENDER = 0x0000001eU,
    RPC_C_AUTHN_PKU2U         = 0x0000001fU,
    RPC_C_AUTHN_LIVE_SSP      = 0x00000020U,
    RPC_C_AUTHN_LIVEXP_SSP    = 0x00000023U,
    RPC_C_AUTHN_CLOUD_AP      = 0x00000024U,
    RPC_C_AUTHN_MSONLINE      = 0x00000052U,
    RPC_C_AUTHN_MQ            = 0x00000064U,
}

enum int RPC_C_AUTHN_DEFAULT = 0xffffffff;

enum : int
{
    RPC_C_SECURITY_QOS_VERSION   = 0x00000001,
    RPC_C_SECURITY_QOS_VERSION_1 = 0x00000001,
    RPC_C_SECURITY_QOS_VERSION_2 = 0x00000002,
}

enum : uint
{
    RPC_C_HTTP_AUTHN_SCHEME_BASIC     = 0x00000001U,
    RPC_C_HTTP_AUTHN_SCHEME_NTLM      = 0x00000002U,
    RPC_C_HTTP_AUTHN_SCHEME_PASSPORT  = 0x00000004U,
    RPC_C_HTTP_AUTHN_SCHEME_DIGEST    = 0x00000008U,
    RPC_C_HTTP_AUTHN_SCHEME_NEGOTIATE = 0x00000010U,
    RPC_C_HTTP_AUTHN_SCHEME_CERT      = 0x00010000U,
}

enum : int
{
    RPC_C_SECURITY_QOS_VERSION_3 = 0x00000003,
    RPC_C_SECURITY_QOS_VERSION_4 = 0x00000004,
    RPC_C_SECURITY_QOS_VERSION_5 = 0x00000005,
}

enum : uint
{
    RPC_PROTSEQ_TCP  = 0x00000001U,
    RPC_PROTSEQ_NMP  = 0x00000002U,
    RPC_PROTSEQ_LRPC = 0x00000003U,
    RPC_PROTSEQ_HTTP = 0x00000004U,
}

enum uint RPC_BHT_OBJECT_UUID_VALID = 0x00000001U;
enum uint RPC_BHO_EXCLUSIVE_AND_GUARANTEED = 0x00000004U;

enum : uint
{
    RPC_C_AUTHZ_NONE    = 0x00000000U,
    RPC_C_AUTHZ_NAME    = 0x00000001U,
    RPC_C_AUTHZ_DCE     = 0x00000002U,
    RPC_C_AUTHZ_DEFAULT = 0xffffffffU,
}

enum uint DCE_C_ERROR_STRING_LEN = 0x00000100U;

enum : uint
{
    RPC_C_EP_ALL_ELTS      = 0x00000000U,
    RPC_C_EP_MATCH_BY_IF   = 0x00000001U,
    RPC_C_EP_MATCH_BY_OBJ  = 0x00000002U,
    RPC_C_EP_MATCH_BY_BOTH = 0x00000003U,
}

enum : uint
{
    RPC_C_VERS_ALL        = 0x00000001U,
    RPC_C_VERS_COMPATIBLE = 0x00000002U,
    RPC_C_VERS_EXACT      = 0x00000003U,
    RPC_C_VERS_MAJOR_ONLY = 0x00000004U,
    RPC_C_VERS_UPTO       = 0x00000005U,
}

enum : uint
{
    RPC_C_MGMT_INQ_IF_IDS         = 0x00000000U,
    RPC_C_MGMT_INQ_PRINC_NAME     = 0x00000001U,
    RPC_C_MGMT_INQ_STATS          = 0x00000002U,
    RPC_C_MGMT_IS_SERVER_LISTEN   = 0x00000003U,
    RPC_C_MGMT_STOP_SERVER_LISTEN = 0x00000004U,
}

enum uint RPC_C_PARM_MAX_PACKET_LENGTH = 0x00000001U;
enum uint RPC_C_PARM_BUFFER_LENGTH = 0x00000002U;

enum : uint
{
    RPC_IF_AUTOLISTEN                   = 0x00000001U,
    RPC_IF_OLE                          = 0x00000002U,
    RPC_IF_ALLOW_UNKNOWN_AUTHORITY      = 0x00000004U,
    RPC_IF_ALLOW_SECURE_ONLY            = 0x00000008U,
    RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH = 0x00000010U,
}

enum uint RPC_IF_ALLOW_LOCAL_ONLY = 0x00000020U;

enum : uint
{
    RPC_IF_SEC_NO_CACHE       = 0x00000040U,
    RPC_IF_SEC_CACHE_PER_PROC = 0x00000080U,
}

enum uint RPC_IF_ASYNC_CALLBACK = 0x00000100U;
enum uint RPC_FW_IF_FLAG_DCOM = 0x00000001U;
enum uint RPC_C_NOTIFY_ON_SEND_COMPLETE = 0x00000001U;
enum uint MaxNumberOfEEInfoParams = 0x00000004U;
enum uint RPC_EEINFO_VERSION = 0x00000001U;
enum uint EEInfoPreviousRecordsMissing = 0x00000001U;
enum uint EEInfoNextRecordsMissing = 0x00000002U;
enum uint EEInfoUseFileTime = 0x00000004U;

enum : uint
{
    EEInfoGCCOM = 0x0000000bU,
    EEInfoGCFRS = 0x0000000cU,
}

enum uint RPC_CALL_ATTRIBUTES_VERSION = 0x00000002U;
enum uint RPC_QUERY_SERVER_PRINCIPAL_NAME = 0x00000002U;
enum uint RPC_QUERY_CLIENT_PRINCIPAL_NAME = 0x00000004U;
enum uint RPC_QUERY_CALL_LOCAL_ADDRESS = 0x00000008U;

enum : uint
{
    RPC_QUERY_CLIENT_PID      = 0x00000010U,
    RPC_QUERY_IS_CLIENT_LOCAL = 0x00000020U,
}

enum uint RPC_QUERY_NO_AUTH_REQUIRED = 0x00000040U;
enum uint RPC_QUERY_CLIENT_ID = 0x00000080U;

enum : uint
{
    RPC_CALL_STATUS_CANCELLED    = 0x00000001U,
    RPC_CALL_STATUS_DISCONNECTED = 0x00000002U,
}

enum : uint
{
    RPC_CONTEXT_HANDLE_DEFAULT_FLAGS  = 0x00000000U,
    RPC_CONTEXT_HANDLE_FLAGS          = 0x30000000U,
    RPC_CONTEXT_HANDLE_SERIALIZE      = 0x10000000U,
    RPC_CONTEXT_HANDLE_DONT_SERIALIZE = 0x20000000U,
}

enum uint RPC_TYPE_STRICT_CONTEXT_HANDLE = 0x40000000U;
enum uint RPC_TYPE_DISCONNECT_EVENT_CONTEXT_HANDLE = 0x80000000U;

enum : uint
{
    RPC_NCA_FLAGS_DEFAULT    = 0x00000000U,
    RPC_NCA_FLAGS_IDEMPOTENT = 0x00000001U,
    RPC_NCA_FLAGS_BROADCAST  = 0x00000002U,
    RPC_NCA_FLAGS_MAYBE      = 0x00000004U,
}

enum uint RPCFLG_HAS_GUARANTEE = 0x00000010U;
enum uint RPCFLG_WINRT_REMOTE_ASYNC = 0x00000020U;

enum : uint
{
    RPC_BUFFER_COMPLETE = 0x00001000U,
    RPC_BUFFER_PARTIAL  = 0x00002000U,
    RPC_BUFFER_EXTRA    = 0x00004000U,
    RPC_BUFFER_ASYNC    = 0x00008000U,
    RPC_BUFFER_NONOTIFY = 0x00010000U,
}

enum : uint
{
    RPCFLG_MESSAGE       = 0x01000000U,
    RPCFLG_AUTO_COMPLETE = 0x08000000U,
}

enum : uint
{
    RPCFLG_LOCAL_CALL        = 0x10000000U,
    RPCFLG_INPUT_SYNCHRONOUS = 0x20000000U,
}

enum uint RPCFLG_ASYNCHRONOUS = 0x40000000U;

enum : uint
{
    RPCFLG_NON_NDR            = 0x80000000U,
    RPCFLG_HAS_MULTI_SYNTAXES = 0x02000000U,
    RPCFLG_HAS_CALLBACK       = 0x04000000U,
}

enum : uint
{
    RPCFLG_ACCESSIBILITY_BIT1 = 0x00100000U,
    RPCFLG_ACCESSIBILITY_BIT2 = 0x00200000U,
    RPCFLG_ACCESS_LOCAL       = 0x00400000U,
}

enum uint NDR_CUSTOM_OR_DEFAULT_ALLOCATOR = 0x10000000U;
enum uint NDR_DEFAULT_ALLOCATOR = 0x20000000U;
enum uint RPCFLG_NDR64_CONTAINS_ARM_LAYOUT = 0x04000000U;
enum uint RPCFLG_SENDER_WAITING_FOR_REPLY = 0x00800000U;
enum uint RPC_FLAGS_VALID_BIT = 0x00008000U;
enum uint NT351_INTERFACE_SIZE = 0x00000040U;
enum uint RPC_INTERFACE_HAS_PIPES = 0x00000001U;

enum : uint
{
    RPC_SYSTEM_HANDLE_FREE_UNRETRIEVED    = 0x00000001U,
    RPC_SYSTEM_HANDLE_FREE_RETRIEVED      = 0x00000002U,
    RPC_SYSTEM_HANDLE_FREE_ALL            = 0x00000003U,
    RPC_SYSTEM_HANDLE_FREE_ERROR_ON_CLOSE = 0x00000004U,
}

enum : uint
{
    TRANSPORT_TYPE_CN   = 0x00000001U,
    TRANSPORT_TYPE_DG   = 0x00000002U,
    TRANSPORT_TYPE_LPC  = 0x00000004U,
    TRANSPORT_TYPE_WMSG = 0x00000008U,
}

enum : uint
{
    RPC_P_ADDR_FORMAT_TCP_IPV4 = 0x00000001U,
    RPC_P_ADDR_FORMAT_TCP_IPV6 = 0x00000002U,
}

enum : uint
{
    RPC_C_OPT_SESSION_ID         = 0x00000006U,
    RPC_C_OPT_COOKIE_AUTH        = 0x00000007U,
    RPC_C_OPT_RESOURCE_TYPE_UUID = 0x00000008U,
}

enum : uint
{
    RPC_PROXY_CONNECTION_TYPE_IN_PROXY  = 0x00000000U,
    RPC_PROXY_CONNECTION_TYPE_OUT_PROXY = 0x00000001U,
}

enum : uint
{
    RPC_C_OPT_PRIVATE_SUPPRESS_WAKE    = 0x00000001U,
    RPC_C_OPT_PRIVATE_DO_NOT_DISTURB   = 0x00000002U,
    RPC_C_OPT_PRIVATE_BREAK_ON_SUSPEND = 0x00000003U,
}

enum : uint
{
    RPC_C_PROFILE_DEFAULT_ELT   = 0x00000000U,
    RPC_C_PROFILE_ALL_ELT       = 0x00000001U,
    RPC_C_PROFILE_ALL_ELTS      = 0x00000001U,
    RPC_C_PROFILE_MATCH_BY_IF   = 0x00000002U,
    RPC_C_PROFILE_MATCH_BY_MBR  = 0x00000003U,
    RPC_C_PROFILE_MATCH_BY_BOTH = 0x00000004U,
}

enum int RPC_C_NS_DEFAULT_EXP_AGE = 0xffffffff;

enum : uint
{
    TARGET_IS_NT1012_OR_LATER         = 0x00000001U,
    TARGET_IS_NT102_OR_LATER          = 0x00000001U,
    TARGET_IS_NT100_OR_LATER          = 0x00000001U,
    TARGET_IS_NT63_OR_LATER           = 0x00000001U,
    TARGET_IS_NT62_OR_LATER           = 0x00000001U,
    TARGET_IS_NT61_OR_LATER           = 0x00000001U,
    TARGET_IS_NT60_OR_LATER           = 0x00000001U,
    TARGET_IS_NT51_OR_LATER           = 0x00000001U,
    TARGET_IS_NT50_OR_LATER           = 0x00000001U,
    TARGET_IS_NT40_OR_LATER           = 0x00000001U,
    TARGET_IS_NT351_OR_WIN95_OR_LATER = 0x00000001U,
}

enum uint cbNDRContext = 0x00000014U;

enum : uint
{
    USER_CALL_IS_ASYNC             = 0x00000100U,
    USER_CALL_NEW_CORRELATION_DESC = 0x00000200U,
}

enum int MIDL_WINRT_TYPE_SERIALIZATION_INFO_CURRENT_VERSION = 0x00000001;

enum : uint
{
    USER_MARSHAL_FC_BYTE   = 0x00000001U,
    USER_MARSHAL_FC_CHAR   = 0x00000002U,
    USER_MARSHAL_FC_SMALL  = 0x00000003U,
    USER_MARSHAL_FC_USMALL = 0x00000004U,
    USER_MARSHAL_FC_WCHAR  = 0x00000005U,
    USER_MARSHAL_FC_SHORT  = 0x00000006U,
    USER_MARSHAL_FC_USHORT = 0x00000007U,
    USER_MARSHAL_FC_LONG   = 0x00000008U,
    USER_MARSHAL_FC_ULONG  = 0x00000009U,
    USER_MARSHAL_FC_FLOAT  = 0x0000000aU,
    USER_MARSHAL_FC_HYPER  = 0x0000000bU,
    USER_MARSHAL_FC_DOUBLE = 0x0000000cU,
}

enum uint INVALID_FRAGMENT_ID = 0x00000000U;
enum uint NDR64_FC_EXPLICIT_HANDLE = 0x00000000U;

enum : uint
{
    NDR64_FC_BIND_GENERIC   = 0x00000001U,
    NDR64_FC_BIND_PRIMITIVE = 0x00000002U,
}

enum : uint
{
    NDR64_FC_AUTO_HANDLE     = 0x00000003U,
    NDR64_FC_CALLBACK_HANDLE = 0x00000004U,
}

enum uint NDR64_FC_NO_HANDLE = 0x00000005U;
enum uint __RPCPROXY_H_VERSION__ = 0x000001ddU;
enum int MidlInterceptionInfoVersionOne = 0x00000001;
enum int MidlWinrtTypeSerializationInfoVersionOne = 0x00000001;

// Callbacks

alias PFN_RPC_ALLOCATE = void* function(size_t param0);
alias PFN_RPC_FREE = void function(void* param0);
alias RPC_OBJECT_INQ_FN = void function(GUID* ObjectUuid, GUID* TypeUuid, RPC_STATUS* Status);
alias RPC_IF_CALLBACK_FN = RPC_STATUS function(void* InterfaceUuid, void* Context);
alias RPC_SECURITY_CALLBACK_FN = void function(void* Context);
alias RPC_NEW_HTTP_PROXY_CHANNEL = RPC_STATUS function(RPC_HTTP_REDIRECTOR_STAGE RedirectorStage, PWSTR ServerName, 
                                                       PWSTR ServerPort, PWSTR RemoteUser, PWSTR AuthType, 
                                                       void* ResourceUuid, void* SessionId, void* Interface, 
                                                       void* Reserved, uint Flags, PWSTR* NewServerName, 
                                                       PWSTR* NewServerPort);
alias RPC_HTTP_PROXY_FREE_STRING = void function(PWSTR String);
alias RPC_AUTH_KEY_RETRIEVAL_FN = void function(void* Arg, PWSTR ServerPrincName, uint KeyVer, void** Key, 
                                                RPC_STATUS* Status);
alias RPC_MGMT_AUTHORIZATION_FN = int function(void* ClientBinding, uint RequestedMgmtOperation, 
                                               RPC_STATUS* Status);
alias RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN = void function(void* IfGroup, void* IdleCallbackContext, 
                                                           uint IsGroupIdle);
alias RPC_FORWARD_FUNCTION = RPC_STATUS function(GUID* InterfaceId, RPC_VERSION* InterfaceVersion, GUID* ObjectId, 
                                                 ubyte* Rpcpro, void** ppDestEndpoint);
alias RPC_ADDRESS_CHANGE_FN = void function(void* arg);
alias RPC_DISPATCH_FUNCTION = void function(RPC_MESSAGE* Message);
alias PRPC_RUNDOWN = void function(void* AssociationContext);
alias RPCLT_PDU_FILTER_FUNC = void function(void* Buffer, uint BufferLength, int fDatagram);
alias RPC_SETFILTER_FUNC = void function(RPCLT_PDU_FILTER_FUNC pfnFilter);
alias RPC_BLOCKING_FN = RPC_STATUS function(void* hWnd, void* Context, void* hSyncEvent);
alias I_RpcProxyIsValidMachineFn = RPC_STATUS function(PWSTR Machine, PWSTR DotMachine, uint PortNumber);
alias I_RpcProxyGetClientAddressFn = RPC_STATUS function(void* Context, PSTR Buffer, uint* BufferLength);
alias I_RpcProxyGetConnectionTimeoutFn = RPC_STATUS function(uint* ConnectionTimeout);
alias I_RpcPerformCalloutFn = RPC_STATUS function(void* Context, RDR_CALLOUT_STATE* CallOutState, 
                                                  RPC_HTTP_REDIRECTOR_STAGE Stage);
alias I_RpcFreeCalloutStateFn = void function(RDR_CALLOUT_STATE* CallOutState);
alias I_RpcProxyGetClientSessionAndResourceUUID = RPC_STATUS function(void* Context, int* SessionIdPresent, 
                                                                      GUID* SessionId, int* ResourceIdPresent, 
                                                                      GUID* ResourceId);
alias I_RpcProxyFilterIfFn = RPC_STATUS function(void* Context, GUID* IfUuid, ushort IfMajorVersion, int* fAllow);
alias I_RpcProxyUpdatePerfCounterFn = void function(RpcPerfCounters Counter, int ModifyTrend, uint Size);
alias I_RpcProxyUpdatePerfCounterBackendServerFn = void function(ushort* MachineName, int IsConnectEvent);
alias PFN_RPCNOTIFICATION_ROUTINE = void function(RPC_ASYNC_STATE* pAsync, void* Context, RPC_ASYNC_EVENT Event);
alias NDR_RUNDOWN = void function(void* context);
alias NDR_NOTIFY_ROUTINE = void function();
alias NDR_NOTIFY2_ROUTINE = void function(ubyte flag);
alias EXPR_EVAL = void function(MIDL_STUB_MESSAGE* param0);
alias GENERIC_BINDING_ROUTINE = void* function(void* param0);
alias GENERIC_UNBIND_ROUTINE = void function(void* param0, ubyte* param1);
alias XMIT_HELPER_ROUTINE = void function(MIDL_STUB_MESSAGE* param0);
alias USER_MARSHAL_SIZING_ROUTINE = uint function(uint* param0, uint param1, void* param2);
alias USER_MARSHAL_MARSHALLING_ROUTINE = ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_UNMARSHALLING_ROUTINE = ubyte* function(uint* param0, ubyte* param1, void* param2);
alias USER_MARSHAL_FREEING_ROUTINE = void function(uint* param0, void* param1);
alias CS_TYPE_NET_SIZE_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, uint ulLocalBufferSize, 
                                               IDL_CS_CONVERT* conversionType, uint* pulNetworkBufferSize, 
                                               uint* pStatus);
alias CS_TYPE_LOCAL_SIZE_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, uint ulNetworkBufferSize, 
                                                 IDL_CS_CONVERT* conversionType, uint* pulLocalBufferSize, 
                                                 uint* pStatus);
alias CS_TYPE_TO_NETCS_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, void* pLocalData, 
                                               uint ulLocalDataLength, ubyte* pNetworkData, 
                                               uint* pulNetworkDataLength, uint* pStatus);
alias CS_TYPE_FROM_NETCS_ROUTINE = void function(void* hBinding, uint ulNetworkCodeSet, ubyte* pNetworkData, 
                                                 uint ulNetworkDataLength, uint ulLocalBufferSize, void* pLocalData, 
                                                 uint* pulLocalDataLength, uint* pStatus);
alias CS_TAG_GETTING_ROUTINE = void function(void* hBinding, int fServerSide, uint* pulSendingTag, 
                                             uint* pulDesiredReceivingTag, uint* pulReceivingTag, uint* pStatus);
alias STUB_THUNK = void function(MIDL_STUB_MESSAGE* param0);
alias SERVER_ROUTINE = int function();
alias RPC_CLIENT_ALLOC = void* function(size_t Size);
alias RPC_CLIENT_FREE = void function(void* Ptr);
alias MIDL_ES_ALLOC = void function(void* state, byte** pbuffer, uint* psize);
alias MIDL_ES_WRITE = void function(void* state, PSTR buffer, uint size);
alias MIDL_ES_READ = void function(void* state, byte** pbuffer, uint* psize);

// Structs


struct PNDR_ASYNC_MESSAGE
{
    ptrdiff_t Value;
}

struct PNDR_CORRELATION_INFO
{
    ptrdiff_t Value;
}

struct _NDR_PROC_CONTEXT
{
    ptrdiff_t Value;
}

struct NDR_ALLOC_ALL_NODES_CONTEXT
{
    ptrdiff_t Value;
}

struct NDR_POINTER_QUEUE_STATE
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_vector
struct RPC_BINDING_VECTOR
{
    uint     Count;
    void[1]* BindingH; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-uuid_vector
struct UUID_VECTOR
{
    uint     Count;
    GUID[1]* Uuid; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_if_id
struct RPC_IF_ID
{
    GUID   Uuid;
    ushort VersMajor;
    ushort VersMinor;
}

struct RPC_PROTSEQ_VECTORA
{
    uint      Count;
    ubyte[1]* Protseq; // Flexible array
}

struct RPC_PROTSEQ_VECTORW
{
    uint       Count;
    ushort[1]* Protseq; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_policy
struct RPC_POLICY
{
    uint Length;
    uint EndpointFlags;
    uint NICFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_stats_vector
struct RPC_STATS_VECTOR
{
    uint    Count;
    uint[1] Stats; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_if_id_vector
struct RPC_IF_ID_VECTOR
{
    uint          Count;
    RPC_IF_ID[1]* IfId; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos
struct RPC_SECURITY_QOS
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-sec_winnt_auth_identity_w
struct SEC_WINNT_AUTH_IDENTITY_W
{
    ushort* User;
    uint    UserLength;
    ushort* Domain;
    uint    DomainLength;
    ushort* Password;
    uint    PasswordLength;
    SEC_WINNT_AUTH_IDENTITY Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-sec_winnt_auth_identity_a
struct SEC_WINNT_AUTH_IDENTITY_A
{
    ubyte* User;
    uint   UserLength;
    ubyte* Domain;
    uint   DomainLength;
    ubyte* Password;
    uint   PasswordLength;
    SEC_WINNT_AUTH_IDENTITY Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_w
struct RPC_HTTP_TRANSPORT_CREDENTIALS_W
{
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ushort*          ServerCertificateSubject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_a
struct RPC_HTTP_TRANSPORT_CREDENTIALS_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ubyte*           ServerCertificateSubject;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_v2_w
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_W
{
    SEC_WINNT_AUTH_IDENTITY_W* TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ushort*          ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_W* ProxyCredentials;
    uint             NumberOfProxyAuthnSchemes;
    uint*            ProxyAuthnSchemes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_v2_a
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V2_A
{
    SEC_WINNT_AUTH_IDENTITY_A* TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ubyte*           ServerCertificateSubject;
    SEC_WINNT_AUTH_IDENTITY_A* ProxyCredentials;
    uint             NumberOfProxyAuthnSchemes;
    uint*            ProxyAuthnSchemes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_v3_w
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_W
{
    void*            TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ushort*          ServerCertificateSubject;
    void*            ProxyCredentials;
    uint             NumberOfProxyAuthnSchemes;
    uint*            ProxyAuthnSchemes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_http_transport_credentials_v3_a
struct RPC_HTTP_TRANSPORT_CREDENTIALS_V3_A
{
    void*            TransportCredentials;
    RPC_C_HTTP_FLAGS Flags;
    RPC_C_HTTP_AUTHN_TARGET AuthenticationTarget;
    uint             NumberOfAuthnSchemes;
    uint*            AuthnSchemes;
    ubyte*           ServerCertificateSubject;
    void*            ProxyCredentials;
    uint             NumberOfProxyAuthnSchemes;
    uint*            ProxyAuthnSchemes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v2_w
struct RPC_SECURITY_QOS_V2_W
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v2_a
struct RPC_SECURITY_QOS_V2_A
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v3_w
struct RPC_SECURITY_QOS_V3_W
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void*              Sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v3_a
struct RPC_SECURITY_QOS_V3_A
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void*              Sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v4_w
struct RPC_SECURITY_QOS_V4_W
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void*              Sid;
    uint               EffectiveOnly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v4_a
struct RPC_SECURITY_QOS_V4_A
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void*              Sid;
    uint               EffectiveOnly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v5_w
struct RPC_SECURITY_QOS_V5_W
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_W* HttpCredentials;
    }
    void*              Sid;
    uint               EffectiveOnly;
    void*              ServerSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_security_qos_v5_a
struct RPC_SECURITY_QOS_V5_A
{
    uint               Version;
    RPC_C_QOS_CAPABILITIES Capabilities;
    RPC_C_QOS_IDENTITY IdentityTracking;
    RPC_C_IMP_LEVEL    ImpersonationType;
    RPC_C_AUTHN_INFO_TYPE AdditionalSecurityInfoType;
    union u
    {
        RPC_HTTP_TRANSPORT_CREDENTIALS_A* HttpCredentials;
    }
    void*              Sid;
    uint               EffectiveOnly;
    void*              ServerSecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_handle_template_v1_w
struct RPC_BINDING_HANDLE_TEMPLATE_V1_W
{
    uint    Version;
    uint    Flags;
    uint    ProtocolSequence;
    ushort* NetworkAddress;
    ushort* StringEndpoint;
    union u1
    {
        ushort* Reserved;
    }
    GUID    ObjectUuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_handle_template_v1_a
struct RPC_BINDING_HANDLE_TEMPLATE_V1_A
{
    uint   Version;
    uint   Flags;
    uint   ProtocolSequence;
    ubyte* NetworkAddress;
    ubyte* StringEndpoint;
    union u1
    {
        ubyte* Reserved;
    }
    GUID   ObjectUuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_handle_security_v1_w
struct RPC_BINDING_HANDLE_SECURITY_V1_W
{
    uint              Version;
    ushort*           ServerPrincName;
    uint              AuthnLevel;
    uint              AuthnSvc;
    SEC_WINNT_AUTH_IDENTITY_W* AuthIdentity;
    RPC_SECURITY_QOS* SecurityQos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_handle_security_v1_a
struct RPC_BINDING_HANDLE_SECURITY_V1_A
{
    uint              Version;
    ubyte*            ServerPrincName;
    uint              AuthnLevel;
    uint              AuthnSvc;
    SEC_WINNT_AUTH_IDENTITY_A* AuthIdentity;
    RPC_SECURITY_QOS* SecurityQos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_binding_handle_options_v1
struct RPC_BINDING_HANDLE_OPTIONS_V1
{
    uint Version;
    RPC_BINDING_HANDLE_OPTIONS_FLAGS Flags;
    uint ComTimeout;
    uint CallTimeout;
}

struct RPC_CLIENT_INFORMATION1
{
    ubyte* UserName;
    ubyte* ComputerName;
    ushort Privilege;
    uint   AuthFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_endpoint_templatew
struct RPC_ENDPOINT_TEMPLATEW
{
    uint  Version;
    PWSTR ProtSeq;
    PWSTR Endpoint;
    void* SecurityDescriptor;
    uint  Backlog;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_endpoint_templatea
struct RPC_ENDPOINT_TEMPLATEA
{
    uint  Version;
    PSTR  ProtSeq;
    PSTR  Endpoint;
    void* SecurityDescriptor;
    uint  Backlog;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_interface_templatea
struct RPC_INTERFACE_TEMPLATEA
{
    uint               Version;
    void*              IfSpec;
    GUID*              MgrTypeUuid;
    void*              MgrEpv;
    uint               Flags;
    uint               MaxCalls;
    uint               MaxRpcSize;
    RPC_IF_CALLBACK_FN IfCallback;
    UUID_VECTOR*       UuidVector;
    PSTR               Annotation;
    void*              SecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/ns-rpcdce-rpc_interface_templatew
struct RPC_INTERFACE_TEMPLATEW
{
    uint               Version;
    void*              IfSpec;
    GUID*              MgrTypeUuid;
    void*              MgrEpv;
    uint               Flags;
    uint               MaxCalls;
    uint               MaxRpcSize;
    RPC_IF_CALLBACK_FN IfCallback;
    UUID_VECTOR*       UuidVector;
    PWSTR              Annotation;
    void*              SecurityDescriptor;
}

struct RPC_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct RPC_SYNTAX_IDENTIFIER
{
    GUID        SyntaxGUID;
    RPC_VERSION SyntaxVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdcep/ns-rpcdcep-rpc_message
struct RPC_MESSAGE
{
    void* Handle;
    uint  DataRepresentation;
    void* Buffer;
    uint  BufferLength;
    uint  ProcNum;
    RPC_SYNTAX_IDENTIFIER* TransferSyntax;
    void* RpcInterfaceInformation;
    void* ReservedForRuntime;
    void* ManagerEpv;
    void* ImportContext;
    uint  RpcFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdcep/ns-rpcdcep-rpc_dispatch_table
struct RPC_DISPATCH_TABLE
{
    uint      DispatchTableCount;
    RPC_DISPATCH_FUNCTION DispatchTable;
    ptrdiff_t Reserved;
}

struct RPC_PROTSEQ_ENDPOINT
{
    ubyte* RpcProtocolSequence;
    ubyte* Endpoint;
}

struct RPC_SERVER_INTERFACE
{
    uint                Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint                RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    void*               DefaultManagerEpv;
    const(void)*        InterpreterInfo;
    uint                Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdcep/ns-rpcdcep-rpc_client_interface
struct RPC_CLIENT_INTERFACE
{
    uint                Length;
    RPC_SYNTAX_IDENTIFIER InterfaceId;
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    uint                RpcProtseqEndpointCount;
    RPC_PROTSEQ_ENDPOINT* RpcProtseqEndpoint;
    size_t              Reserved;
    const(void)*        InterpreterInfo;
    uint                Flags;
}

struct RPC_SEC_CONTEXT_KEY_INFO
{
    uint EncryptAlgorithm;
    uint KeySize;
    uint SignatureAlgorithm;
}

struct RPC_TRANSFER_SYNTAX
{
    GUID   Uuid;
    ushort VersMajor;
    ushort VersMinor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdcep/ns-rpcdcep-rpc_c_opt_cookie_auth_descriptor
struct RPC_C_OPT_COOKIE_AUTH_DESCRIPTOR
{
    uint BufferSize;
    PSTR Buffer;
}

struct RDR_CALLOUT_STATE
{
    RPC_STATUS LastError;
    void*      LastEEInfo;
    RPC_HTTP_REDIRECTOR_STAGE LastCalledStage;
    ushort*    ServerName;
    ushort*    ServerPort;
    ushort*    RemoteUser;
    ushort*    AuthType;
    ubyte      ResourceTypePresent;
    ubyte      SessionIdPresent;
    ubyte      InterfacePresent;
    GUID       ResourceType;
    GUID       SessionId;
    RPC_SYNTAX_IDENTIFIER Interface;
    void*      CertContext;
}

struct I_RpcProxyCallbackInterface
{
    I_RpcProxyIsValidMachineFn IsValidMachineFn;
    I_RpcProxyGetClientAddressFn GetClientAddressFn;
    I_RpcProxyGetConnectionTimeoutFn GetConnectionTimeoutFn;
    I_RpcPerformCalloutFn PerformCalloutFn;
    I_RpcFreeCalloutStateFn FreeCalloutStateFn;
    I_RpcProxyGetClientSessionAndResourceUUID GetClientSessionAndResourceUUIDFn;
    I_RpcProxyFilterIfFn ProxyFilterIfFn;
    I_RpcProxyUpdatePerfCounterFn RpcProxyUpdatePerfCounterFn;
    I_RpcProxyUpdatePerfCounterBackendServerFn RpcProxyUpdatePerfCounterBackendServerFn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_async_notification_info
union RPC_ASYNC_NOTIFICATION_INFO
{
    struct APC
    {
        PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
        HANDLE hThread;
    }
    struct IOC
    {
        HANDLE      hIOPort;
        uint        dwNumberOfBytesTransferred;
        size_t      dwCompletionKey;
        OVERLAPPED* lpOverlapped;
    }
    struct IntPtr
    {
        HWND hWnd;
        uint Msg;
    }
    HANDLE hEvent;
    PFN_RPCNOTIFICATION_ROUTINE NotificationRoutine;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_async_state
struct RPC_ASYNC_STATE
{
    uint            Size;
    uint            Signature;
    int             Lock;
    uint            Flags;
    void*           StubInfo;
    void*           UserInfo;
    void*           RuntimeInfo;
    RPC_ASYNC_EVENT Event;
    RPC_NOTIFICATION_TYPES NotificationType;
    RPC_ASYNC_NOTIFICATION_INFO u;
    ptrdiff_t[4]    Reserved;
}

struct BinaryParam
{
    void* Buffer;
    short Size;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_ee_info_param
struct RPC_EE_INFO_PARAM
{
    ExtendedErrorParamTypes ParameterType;
    union u
    {
        PSTR        AnsiString;
        PWSTR       UnicodeString;
        int         LVal;
        short       SVal;
        ulong       PVal;
        BinaryParam BVal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_extended_error_info
struct RPC_EXTENDED_ERROR_INFO
{
    uint                 Version;
    PWSTR                ComputerName;
    uint                 ProcessID;
    union u
    {
        SYSTEMTIME SystemTime;
        FILETIME   FileTime;
    }
    uint                 GeneratingComponent;
    uint                 Status;
    ushort               DetectionLocation;
    ushort               Flags;
    int                  NumberOfParameters;
    RPC_EE_INFO_PARAM[4] Parameters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_error_enum_handle
struct RPC_ERROR_ENUM_HANDLE
{
    uint  Signature;
    void* CurrentPos;
    void* Head;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_call_local_address_v1
struct RPC_CALL_LOCAL_ADDRESS_V1
{
    uint  Version;
    void* Buffer;
    uint  BufferSize;
    RpcLocalAddressFormat AddressFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_call_attributes_v1_w
struct RPC_CALL_ATTRIBUTES_V1_W
{
    uint    Version;
    uint    Flags;
    uint    ServerPrincipalNameBufferLength;
    ushort* ServerPrincipalName;
    uint    ClientPrincipalNameBufferLength;
    ushort* ClientPrincipalName;
    uint    AuthenticationLevel;
    uint    AuthenticationService;
    BOOL    NullSession;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_call_attributes_v1_a
struct RPC_CALL_ATTRIBUTES_V1_A
{
    uint   Version;
    uint   Flags;
    uint   ServerPrincipalNameBufferLength;
    ubyte* ServerPrincipalName;
    uint   ClientPrincipalNameBufferLength;
    ubyte* ClientPrincipalName;
    uint   AuthenticationLevel;
    uint   AuthenticationService;
    BOOL   NullSession;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_call_attributes_v2_w
struct RPC_CALL_ATTRIBUTES_V2_W
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ushort*     ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ushort*     ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    RpcCallClientLocality IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/ns-rpcasync-rpc_call_attributes_v2_a
struct RPC_CALL_ATTRIBUTES_V2_A
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ubyte*      ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ubyte*      ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    uint        IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
}

struct RPC_CALL_ATTRIBUTES_V3_W
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ushort*     ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ushort*     ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    RpcCallClientLocality IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
    uint        ClientIdentifierBufferLength;
    ubyte*      ClientIdentifier;
}

struct RPC_CALL_ATTRIBUTES_V3_A
{
    uint        Version;
    uint        Flags;
    uint        ServerPrincipalNameBufferLength;
    ubyte*      ServerPrincipalName;
    uint        ClientPrincipalNameBufferLength;
    ubyte*      ClientPrincipalName;
    uint        AuthenticationLevel;
    uint        AuthenticationService;
    BOOL        NullSession;
    BOOL        KernelModeCaller;
    uint        ProtocolSequence;
    uint        IsClientLocal;
    HANDLE      ClientPID;
    uint        CallStatus;
    RpcCallType CallType;
    RPC_CALL_LOCAL_ADDRESS_V1* CallLocalAddress;
    ushort      OpNum;
    GUID        InterfaceUuid;
    uint        ClientIdentifierBufferLength;
    ubyte*      ClientIdentifier;
}

struct RPC_IMPORT_CONTEXT_P
{
    void*               LookupContext;
    void*               ProposedHandle;
    RPC_BINDING_VECTOR* Bindings;
}

struct NDR_SCONTEXT
{
    void[2]* pad;
    void*    userContext;
}

struct SCONTEXT_QUEUE
{
    uint           NumberOfObjects;
    NDR_SCONTEXT** ArrayOfObjects;
}

struct ARRAY_INFO
{
    int   Dimension;
    uint* BufferConformanceMark;
    uint* BufferVarianceMark;
    uint* MaxCountArray;
    uint* OffsetArray;
    uint* ActualCountArray;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/ns-rpcndr-midl_stub_message
struct MIDL_STUB_MESSAGE
{
    RPC_MESSAGE*       RpcMsg;
    ubyte*             Buffer;
    ubyte*             BufferStart;
    ubyte*             BufferEnd;
    ubyte*             BufferMark;
    uint               BufferLength;
    uint               MemorySize;
    ubyte*             Memory;
    ubyte              IsClient;
    ubyte              Pad;
    ushort             uFlags2;
    int                ReuseBuffer;
    NDR_ALLOC_ALL_NODES_CONTEXT* pAllocAllNodesContext;
    NDR_POINTER_QUEUE_STATE* pPointerQueueState;
    int                IgnoreEmbeddedPointers;
    ubyte*             PointerBufferMark;
    ubyte              CorrDespIncrement;
    ubyte              uFlags;
    ushort             UniquePtrCount;
    size_t             MaxCount;
    uint               Offset;
    uint               ActualCount;
    PFN_RPC_ALLOCATE   pfnAllocate;
    PFN_RPC_FREE       pfnFree;
    ubyte*             StackTop;
    ubyte*             pPresentedType;
    ubyte*             pTransmitType;
    void*              SavedHandle;
    const(MIDL_STUB_DESC)* StubDesc;
    FULL_PTR_XLAT_TABLES* FullPtrXlatTables;
    uint               FullPtrRefId;
    uint               PointerLength;
    // Native bit field: fInDontFree: [0], fDontCallFreeInst: [1], fUnused1: [2], fHasReturn: [3], fHasExtensions: [4], fHasNewCorrDesc: [5], fIsIn: [6], fIsOut: [7], fIsOicf: [8], fBufferValid: [9], fHasMemoryValidateCallback: [10], fInFree: [11], fNeedMCCP: [12], fUnused2: [13-15], fUnused3: [16-31]
    int                _bitfield0;
    uint               dwDestContext;
    void*              pvDestContext;
    NDR_SCONTEXT**     SavedContextHandles;
    int                ParamNumber;
    IRpcChannelBuffer  pRpcChannelBuffer;
    ARRAY_INFO*        pArrayInfo;
    uint*              SizePtrCountArray;
    uint*              SizePtrOffsetArray;
    uint*              SizePtrLengthArray;
    void*              pArgQueue;
    uint               dwStubPhase;
    void*              LowStackMark;
    PNDR_ASYNC_MESSAGE pAsyncMsg;
    PNDR_CORRELATION_INFO pCorrInfo;
    ubyte*             pCorrMemory;
    void*              pMemoryList;
    ptrdiff_t          pCSInfo;
    ubyte*             ConformanceMark;
    ubyte*             VarianceMark;
    ptrdiff_t          Unused;
    _NDR_PROC_CONTEXT* pContext;
    void*              ContextHandleHash;
    void*              pUserMarshalList;
    ubyte*             pFullPtrFormat;
    ptrdiff_t          Reserved51_4;
    ptrdiff_t          Reserved51_5;
}

struct GENERIC_BINDING_ROUTINE_PAIR
{
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

struct GENERIC_BINDING_INFO
{
    void* pObj;
    uint  Size;
    GENERIC_BINDING_ROUTINE pfnBind;
    GENERIC_UNBIND_ROUTINE pfnUnbind;
}

struct XMIT_ROUTINE_QUINTUPLE
{
    XMIT_HELPER_ROUTINE pfnTranslateToXmit;
    XMIT_HELPER_ROUTINE pfnTranslateFromXmit;
    XMIT_HELPER_ROUTINE pfnFreeXmit;
    XMIT_HELPER_ROUTINE pfnFreeInst;
}

struct USER_MARSHAL_ROUTINE_QUADRUPLE
{
    USER_MARSHAL_SIZING_ROUTINE pfnBufferSize;
    USER_MARSHAL_MARSHALLING_ROUTINE pfnMarshall;
    USER_MARSHAL_UNMARSHALLING_ROUTINE pfnUnmarshall;
    USER_MARSHAL_FREEING_ROUTINE pfnFree;
}

struct USER_MARSHAL_CB
{
    uint                 Flags;
    MIDL_STUB_MESSAGE*   pStubMsg;
    ubyte*               pReserve;
    uint                 Signature;
    USER_MARSHAL_CB_TYPE CBType;
    ubyte*               pFormat;
    ubyte*               pTypeFormat;
}

struct MALLOC_FREE_STRUCT
{
    ptrdiff_t pfnAllocate;
    ptrdiff_t pfnFree;
}

struct COMM_FAULT_OFFSETS
{
    short CommOffset;
    short FaultOffset;
}

struct NDR_CS_SIZE_CONVERT_ROUTINES
{
    CS_TYPE_NET_SIZE_ROUTINE pfnNetSize;
    CS_TYPE_TO_NETCS_ROUTINE pfnToNetCs;
    CS_TYPE_LOCAL_SIZE_ROUTINE pfnLocalSize;
    CS_TYPE_FROM_NETCS_ROUTINE pfnFromNetCs;
}

struct NDR_CS_ROUTINES
{
    NDR_CS_SIZE_CONVERT_ROUTINES* pSizeConvertRoutines;
    CS_TAG_GETTING_ROUTINE* pTagGettingRoutines;
}

struct NDR_EXPR_DESC
{
    const(ushort)* pOffset;
    ubyte*         pFormatExpr;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/ns-rpcndr-midl_stub_desc
struct MIDL_STUB_DESC
{
    void*               RpcInterfaceInformation;
    PFN_RPC_ALLOCATE    pfnAllocate;
    PFN_RPC_FREE        pfnFree;
    union IMPLICIT_HANDLE_INFO
    {
        void** pAutoHandle;
        void** pPrimitiveHandle;
        GENERIC_BINDING_INFO* pGenericBindingInfo;
    }
    const(NDR_RUNDOWN)* apfnNdrRundownRoutines;
    const(GENERIC_BINDING_ROUTINE_PAIR)* aGenericBindingRoutinePairs;
    const(EXPR_EVAL)*   apfnExprEval;
    const(XMIT_ROUTINE_QUINTUPLE)* aXmitQuintuple;
    const(ubyte)*       pFormatTypes;
    int                 fCheckBounds;
    uint                Version;
    MALLOC_FREE_STRUCT* pMallocFreeStruct;
    int                 MIDLVersion;
    const(COMM_FAULT_OFFSETS)* CommFaultOffsets;
    const(USER_MARSHAL_ROUTINE_QUADRUPLE)* aUserMarshalQuadruple;
    const(NDR_NOTIFY_ROUTINE)* NotifyRoutineTable;
    size_t              mFlags;
    const(NDR_CS_ROUTINES)* CsRoutineTables;
    void*               ProxyServerInfo;
    const(NDR_EXPR_DESC)* pExprInfo;
}

struct MIDL_FORMAT_STRING
{
    short    Pad;
    ubyte[1] Format;
}

struct MIDL_METHOD_PROPERTY
{
    uint   Id;
    size_t Value;
}

struct MIDL_METHOD_PROPERTY_MAP
{
    uint Count;
    const(MIDL_METHOD_PROPERTY)* Properties;
}

struct MIDL_INTERFACE_METHOD_PROPERTIES
{
    ushort MethodCount;
    const(MIDL_METHOD_PROPERTY_MAP)** MethodProperties;
}

struct MIDL_SERVER_INFO
{
    MIDL_STUB_DESC*    pStubDesc;
    const(SERVER_ROUTINE)* DispatchTable;
    ubyte*             ProcString;
    const(ushort)*     FmtStringOffset;
    const(STUB_THUNK)* ThunkTable;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    size_t             nCount;
    MIDL_SYNTAX_INFO*  pSyntaxInfo;
}

struct MIDL_STUBLESS_PROXY_INFO
{
    MIDL_STUB_DESC*   pStubDesc;
    ubyte*            ProcFormatString;
    const(ushort)*    FormatStringOffset;
    RPC_SYNTAX_IDENTIFIER* pTransferSyntax;
    size_t            nCount;
    MIDL_SYNTAX_INFO* pSyntaxInfo;
}

struct MIDL_SYNTAX_INFO
{
    RPC_SYNTAX_IDENTIFIER TransferSyntax;
    RPC_DISPATCH_TABLE* DispatchTable;
    ubyte*              ProcString;
    const(ushort)*      FmtStringOffset;
    ubyte*              TypeString;
    const(void)*        aUserMarshalQuadruple;
    const(MIDL_INTERFACE_METHOD_PROPERTIES)* pMethodProperties;
    size_t              pReserved2;
}

union CLIENT_CALL_RETURN
{
    void*     Pointer;
    ptrdiff_t Simple;
}

struct FULL_PTR_XLAT_TABLES
{
    void*     RefIdToPointer;
    void*     PointerToRefId;
    uint      NextRefId;
    XLAT_SIDE XlatSide;
}

struct MIDL_INTERCEPTION_INFO
{
    uint           Version;
    ubyte*         ProcString;
    const(ushort)* ProcFormatOffsetTable;
    uint           ProcCount;
    ubyte*         TypeString;
}

struct MIDL_WINRT_TYPE_SERIALIZATION_INFO
{
    uint            Version;
    ubyte*          TypeFormatString;
    ushort          FormatStringSize;
    ushort          TypeOffset;
    MIDL_STUB_DESC* StubDesc;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/ns-rpcndr-ndr_user_marshal_info_level1
struct NDR_USER_MARSHAL_INFO_LEVEL1
{
    void*             Buffer;
    uint              BufferSize;
    ptrdiff_t         pfnAllocate;
    ptrdiff_t         pfnFree;
    IRpcChannelBuffer pRpcChannelBuffer;
    size_t[5]         Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/ns-rpcndr-ndr_user_marshal_info
struct NDR_USER_MARSHAL_INFO
{
    uint InformationLevel;
    union
    {
        NDR_USER_MARSHAL_INFO_LEVEL1 Level1;
    }
}

struct MIDL_TYPE_PICKLING_INFO
{
    uint      Version;
    uint      Flags;
    size_t[3] Reserved;
}

struct NDR64_PROC_FLAGS
{
    // Native bit field: HandleType: [0-2], ProcType: [3-5], IsInterpreted: [6-7], IsObject: [8], IsAsync: [9], IsEncode: [10], IsDecode: [11], UsesFullPtrPackage: [12], UsesRpcSmPackage: [13], UsesPipes: [14], HandlesExceptions: [15-16], ServerMustSize: [17], ClientMustSize: [18], HasReturn: [19], HasComplexReturn: [20], ServerHasCorrelation: [21], ClientHasCorrelation: [22], HasNotify: [23], HasOtherExtensions: [24], HasBigByValueParam: [25], HasArmParamLayout: [26], Reserved: [27-31]
    uint _bitfield0;
}

struct NDR64_RPC_FLAGS
{
    // Native bit field: Idempotent: [0], Broadcast: [1], Maybe: [2], Reserved0: [3], HasGuarantee: [4], Reserved1: [5-7], Message: [8], Reserved2: [9-12], InputSynchronous: [13], Asynchronous: [14], WinrtRemoteAsync: [15]
    ushort _bitfield0;
}

struct NDR64_PROC_FORMAT
{
    uint   Flags;
    uint   StackSize;
    uint   ConstantClientBufferSize;
    uint   ConstantServerBufferSize;
    ushort RpcFlags;
    ushort FloatDoubleMask;
    ushort NumberOfParams;
    ushort ExtensionSize;
}

struct NDR64_PARAM_FLAGS
{
    // Native bit field: MustSize: [0], MustFree: [1], IsPipe: [2], IsIn: [3], IsOut: [4], IsReturn: [5], IsBasetype: [6], IsByValue: [7], IsSimpleRef: [8], IsDontCallFreeInst: [9], SaveForAsyncFinish: [10], IsPartialIgnore: [11], IsForceAllocate: [12], Reserved: [13-14], UseCache: [15]
    ushort _bitfield0;
}

struct NDR64_PARAM_FORMAT
{
    void*             Type;
    NDR64_PARAM_FLAGS Attributes;
    ushort            Reserved;
    uint              StackOffset;
}

struct NDR64_RANGE_FORMAT
{
    ubyte  FormatCode;
    ubyte  RangeType;
    ushort Reserved;
    long   MinValue;
    long   MaxValue;
}

struct NDR64_CONTEXT_HANDLE_FLAGS
{
    // Native bit field: CannotBeNull: [0], Serialize: [1], NoSerialize: [2], Strict: [3], IsReturn: [4], IsOut: [5], IsIn: [6], IsViaPointer: [7]
    ubyte _bitfield0;
}

struct NDR64_CONTEXT_HANDLE_FORMAT
{
    ubyte FormatCode;
    ubyte ContextFlags;
    ubyte RundownRoutineIndex;
    ubyte Ordinal;
}

struct NDR64_BIND_PRIMITIVE
{
    ubyte  HandleType;
    ubyte  Flags;
    ushort StackOffset;
    ushort Reserved;
}

struct NDR64_BIND_GENERIC
{
    ubyte  HandleType;
    ubyte  Flags;
    ushort StackOffset;
    ubyte  RoutineIndex;
    ubyte  Size;
}

struct NDR64_BIND_CONTEXT
{
    ubyte  HandleType;
    ubyte  Flags;
    ushort StackOffset;
    ubyte  RoutineIndex;
    ubyte  Ordinal;
}

union NDR64_BINDINGS
{
    NDR64_BIND_PRIMITIVE Primitive;
    NDR64_BIND_GENERIC   Generic;
    NDR64_BIND_CONTEXT   Context;
}

struct NDR64_BIND_AND_NOTIFY_EXTENSION
{
    NDR64_BIND_CONTEXT Binding;
    ushort             NotifyIndex;
}

struct NDR64_SYSTEM_HANDLE_FORMAT
{
    ubyte FormatCode;
    ubyte HandleType;
    uint  DesiredAccess;
}

struct NDR64_POINTER_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort Reserved;
    void*  Pointee;
}

struct NDR64_NO_REPEAT_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort Reserved1;
    uint   Reserved2;
}

struct NDR64_POINTER_INSTANCE_HEADER_FORMAT
{
    uint Offset;
    uint Reserved;
}

struct NDR64_POINTER_REPEAT_FLAGS
{
    // Native bit field: SetCorrMark: [0], Reserved: [1-7]
    ubyte _bitfield0;
}

struct NDR64_REPEAT_FORMAT
{
    ubyte  FormatCode;
    NDR64_POINTER_REPEAT_FLAGS Flags;
    ushort Reserved;
    uint   Increment;
    uint   OffsetToArray;
    uint   NumberOfPointers;
}

struct NDR64_FIXED_REPEAT_FORMAT
{
    NDR64_REPEAT_FORMAT RepeatFormat;
    uint                Iterations;
    uint                Reserved;
}

struct NDR64_IID_FLAGS
{
    // Native bit field: ConstantIID: [0], Reserved: [1-7]
    ubyte _bitfield0;
}

struct NDR64_CONSTANT_IID_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort Reserved;
    GUID   Guid;
}

struct NDR64_IID_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort Reserved;
    void*  IIDDescriptor;
}

struct NDR64_STRUCTURE_FLAGS
{
    // Native bit field: HasPointerInfo: [0], HasMemberInfo: [1], HasConfArray: [2], HasOrigPointerInfo: [3], HasOrigMemberInfo: [4], Reserved1: [5], Reserved2: [6], Reserved3: [7]
    ubyte _bitfield0;
}

struct NDR64_STRUCTURE_HEADER_FORMAT
{
    ubyte FormatCode;
    ubyte Alignment;
    NDR64_STRUCTURE_FLAGS Flags;
    ubyte Reserve;
    uint  MemorySize;
}

struct NDR64_CONF_STRUCTURE_HEADER_FORMAT
{
    ubyte FormatCode;
    ubyte Alignment;
    NDR64_STRUCTURE_FLAGS Flags;
    ubyte Reserve;
    uint  MemorySize;
    void* ArrayDescription;
}

struct NDR64_BOGUS_STRUCTURE_HEADER_FORMAT
{
    ubyte FormatCode;
    ubyte Alignment;
    NDR64_STRUCTURE_FLAGS Flags;
    ubyte Reserve;
    uint  MemorySize;
    void* OriginalMemberLayout;
    void* OriginalPointerLayout;
    void* PointerLayout;
}

struct NDR64_CONF_BOGUS_STRUCTURE_HEADER_FORMAT
{
    ubyte FormatCode;
    ubyte Alignment;
    NDR64_STRUCTURE_FLAGS Flags;
    ubyte Dimensions;
    uint  MemorySize;
    void* OriginalMemberLayout;
    void* OriginalPointerLayout;
    void* PointerLayout;
    void* ConfArrayDescription;
}

struct NDR64_SIMPLE_MEMBER_FORMAT
{
    ubyte  FormatCode;
    ubyte  Reserved1;
    ushort Reserved2;
    uint   Reserved3;
}

struct NDR64_MEMPAD_FORMAT
{
    ubyte  FormatCode;
    ubyte  Reserve1;
    ushort MemPad;
    uint   Reserved2;
}

struct NDR64_EMBEDDED_COMPLEX_FORMAT
{
    ubyte  FormatCode;
    ubyte  Reserve1;
    ushort Reserve2;
    void*  Type;
}

struct NDR64_BUFFER_ALIGN_FORMAT
{
    ubyte  FormatCode;
    ubyte  Alignment;
    ushort Reserved;
    uint   Reserved2;
}

struct NDR64_SIMPLE_REGION_FORMAT
{
    ubyte  FormatCode;
    ubyte  Alignment;
    ushort RegionSize;
    uint   Reserved;
}

struct NDR64_ENCAPSULATED_UNION
{
    ubyte FormatCode;
    ubyte Alignment;
    ubyte Flags;
    ubyte SwitchType;
    uint  MemoryOffset;
    uint  MemorySize;
    uint  Reserved;
}

struct NDR64_NON_ENCAPSULATED_UNION
{
    ubyte FormatCode;
    ubyte Alignment;
    ubyte Flags;
    ubyte SwitchType;
    uint  MemorySize;
    void* Switch;
    uint  Reserved;
}

struct NDR64_UNION_ARM_SELECTOR
{
    ubyte  Reserved1;
    ubyte  Alignment;
    ushort Reserved2;
    uint   Arms;
}

struct NDR64_UNION_ARM
{
    long  CaseValue;
    void* Type;
    uint  Reserved;
}

struct NDR64_ARRAY_FLAGS
{
    // Native bit field: HasPointerInfo: [0], HasElementInfo: [1], IsMultiDimensional: [2], IsArrayofStrings: [3], Reserved1: [4], Reserved2: [5], Reserved3: [6], Reserved4: [7]
    ubyte _bitfield0;
}

struct NDR64_ARRAY_ELEMENT_INFO
{
    uint  ElementMemSize;
    void* Element;
}

struct NDR64_FIX_ARRAY_HEADER_FORMAT
{
    ubyte             FormatCode;
    ubyte             Alignment;
    NDR64_ARRAY_FLAGS Flags;
    ubyte             Reserved;
    uint              TotalSize;
}

struct NDR64_CONF_ARRAY_HEADER_FORMAT
{
    ubyte             FormatCode;
    ubyte             Alignment;
    NDR64_ARRAY_FLAGS Flags;
    ubyte             Reserved;
    uint              ElementSize;
    void*             ConfDescriptor;
}

struct NDR64_CONF_VAR_ARRAY_HEADER_FORMAT
{
    ubyte             FormatCode;
    ubyte             Alignment;
    NDR64_ARRAY_FLAGS Flags;
    ubyte             Reserved;
    uint              ElementSize;
    void*             ConfDescriptor;
    void*             VarDescriptor;
}

struct NDR64_VAR_ARRAY_HEADER_FORMAT
{
    ubyte             FormatCode;
    ubyte             Alignment;
    NDR64_ARRAY_FLAGS Flags;
    ubyte             Reserved;
    uint              TotalSize;
    uint              ElementSize;
    void*             VarDescriptor;
}

struct NDR64_BOGUS_ARRAY_HEADER_FORMAT
{
    ubyte             FormatCode;
    ubyte             Alignment;
    NDR64_ARRAY_FLAGS Flags;
    ubyte             NumberDims;
    uint              NumberElements;
    void*             Element;
}

struct NDR64_CONF_VAR_BOGUS_ARRAY_HEADER_FORMAT
{
    NDR64_BOGUS_ARRAY_HEADER_FORMAT FixedArrayFormat;
    void* ConfDescription;
    void* VarDescription;
    void* OffsetDescription;
}

struct NDR64_STRING_FLAGS
{
    // Native bit field: IsSized: [0], IsRanged: [1], Reserved3: [2], Reserved4: [3], Reserved5: [4], Reserved6: [5], Reserved7: [6], Reserved8: [7]
    ubyte _bitfield0;
}

struct NDR64_STRING_HEADER_FORMAT
{
    ubyte              FormatCode;
    NDR64_STRING_FLAGS Flags;
    ushort             ElementSize;
}

struct NDR64_NON_CONFORMANT_STRING_FORMAT
{
    NDR64_STRING_HEADER_FORMAT Header;
    uint TotalSize;
}

struct NDR64_RANGED_STRING_FORMAT
{
    NDR64_STRING_HEADER_FORMAT Header;
    uint  Reserved;
    ulong Min;
    ulong Max;
}

struct NDR64_CONFORMANT_STRING_FORMAT
{
    NDR64_STRING_HEADER_FORMAT Header;
}

struct NDR64_SIZED_CONFORMANT_STRING_FORMAT
{
    NDR64_STRING_HEADER_FORMAT Header;
    void* SizeDescription;
}

struct NDR64_EXPR_OPERATOR
{
    ubyte ExprType;
    ubyte Operator;
    ubyte CastType;
    ubyte Reserved;
}

struct NDR64_EXPR_CONST32
{
    ubyte  ExprType;
    ubyte  Reserved;
    ushort Reserved1;
    uint   ConstValue;
}

struct NDR64_EXPR_CONST64
{
    ubyte  ExprType;
    ubyte  Reserved;
    ushort Reserved1;
    long   ConstValue;
}

struct NDR64_EXPR_VAR
{
    ubyte  ExprType;
    ubyte  VarType;
    ushort Reserved;
    uint   Offset;
}

struct NDR64_EXPR_NOOP
{
    ubyte  ExprType;
    ubyte  Size;
    ushort Reserved;
}

struct NDR64_TRANSMIT_AS_FLAGS
{
    // Native bit field: PresentedTypeIsArray: [0], PresentedTypeAlign4: [1], PresentedTypeAlign8: [2], Reserved: [3-7]
    ubyte _bitfield0;
}

struct NDR64_TRANSMIT_AS_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort RoutineIndex;
    ushort TransmittedTypeWireAlignment;
    ushort MemoryAlignment;
    uint   PresentedTypeMemorySize;
    uint   TransmittedTypeBufferSize;
    void*  TransmittedType;
}

struct NDR64_USER_MARSHAL_FLAGS
{
    // Native bit field: Reserved: [0-4], IID: [5], RefPointer: [6], UniquePointer: [7]
    ubyte _bitfield0;
}

struct NDR64_USER_MARSHAL_FORMAT
{
    ubyte  FormatCode;
    ubyte  Flags;
    ushort RoutineIndex;
    ushort TransmittedTypeWireAlignment;
    ushort MemoryAlignment;
    uint   UserTypeMemorySize;
    uint   TransmittedTypeBufferSize;
    void*  TransmittedType;
}

struct NDR64_PIPE_FLAGS
{
    // Native bit field: Reserved1: [0-4], HasRange: [5], BlockCopy: [6], Reserved2: [7]
    ubyte _bitfield0;
}

struct NDR64_PIPE_FORMAT
{
    ubyte FormatCode;
    ubyte Flags;
    ubyte Alignment;
    ubyte Reserved;
    void* Type;
    uint  MemorySize;
    uint  BufferSize;
}

struct NDR64_RANGE_PIPE_FORMAT
{
    ubyte FormatCode;
    ubyte Flags;
    ubyte Alignment;
    ubyte Reserved;
    void* Type;
    uint  MemorySize;
    uint  BufferSize;
    uint  MinValue;
    uint  MaxValue;
}

struct NDR64_TYPE_STRICT_CONTEXT_HANDLE
{
    ubyte  FormatCode;
    ubyte  RealFormatCode;
    ushort Reserved;
    void*  Type;
    uint   CtxtFlags;
    uint   CtxtID;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
HRESULT IUnknown_QueryInterface_Proxy(IUnknown This, const(GUID)* riid, void** ppvObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
uint IUnknown_AddRef_Proxy(IUnknown This);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
uint IUnknown_Release_Proxy(IUnknown This);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingFree(void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetOption(void* hBinding, uint option, size_t optionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqOption(void* hBinding, uint option, size_t* pOptionValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingFromStringBindingA(PSTR StringBinding, void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingFromStringBindingW(PWSTR StringBinding, void** Binding);

@DllImport("RPCRT4.dll")
RPC_STATUS RpcSsGetContextBinding(void* ContextHandle, void** Binding);

@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqMaxCalls(void* Binding, uint* MaxCalls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqObject(void* Binding, GUID* ObjectUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingReset(void* Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetObject(void* Binding, GUID* ObjectUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqDefaultProtectLevel(uint AuthnSvc, uint* AuthnLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingToStringBindingA(void* Binding, PSTR* StringBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingToStringBindingW(void* Binding, PWSTR* StringBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingVectorFree(RPC_BINDING_VECTOR** BindingVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringBindingComposeA(PSTR ObjUuid, PSTR ProtSeq, PSTR NetworkAddr, PSTR Endpoint, PSTR Options, 
                                    PSTR* StringBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringBindingComposeW(PWSTR ObjUuid, PWSTR ProtSeq, PWSTR NetworkAddr, PWSTR Endpoint, PWSTR Options, 
                                    PWSTR* StringBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringBindingParseA(PSTR StringBinding, PSTR* ObjUuid, PSTR* Protseq, PSTR* NetworkAddr, 
                                  PSTR* Endpoint, PSTR* NetworkOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringBindingParseW(PWSTR StringBinding, PWSTR* ObjUuid, PWSTR* Protseq, PWSTR* NetworkAddr, 
                                  PWSTR* Endpoint, PWSTR* NetworkOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringFreeA(PSTR* String);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcStringFreeW(PWSTR* String);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcIfInqId(void* RpcIfHandle, RPC_IF_ID* RpcIfId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNetworkIsProtseqValidA(PSTR Protseq);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNetworkIsProtseqValidW(PWSTR Protseq);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqComTimeout(void* Binding, uint* Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtSetComTimeout(void* Binding, uint Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtSetCancelTimeout(int Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNetworkInqProtseqsA(RPC_PROTSEQ_VECTORA** ProtseqVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNetworkInqProtseqsW(RPC_PROTSEQ_VECTORW** ProtseqVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcObjectInqType(GUID* ObjUuid, GUID* TypeUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcObjectSetInqFn(RPC_OBJECT_INQ_FN InquiryFn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcObjectSetType(GUID* ObjUuid, GUID* TypeUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcProtseqVectorFreeA(RPC_PROTSEQ_VECTORA** ProtseqVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcProtseqVectorFreeW(RPC_PROTSEQ_VECTORW** ProtseqVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqBindings(RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqBindingsEx(void* SecurityDescriptor, RPC_BINDING_VECTOR** BindingVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqIf(void* IfSpec, GUID* MgrTypeUuid, void** MgrEpv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerListen(uint MinimumCallThreads, uint MaxCalls, uint DontWait);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterIf(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterIfEx(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, 
                                 RPC_IF_CALLBACK_FN IfCallback);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterIf2(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, 
                                uint MaxRpcSize, RPC_IF_CALLBACK_FN IfCallbackFn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterIf3(void* IfSpec, GUID* MgrTypeUuid, void* MgrEpv, uint Flags, uint MaxCalls, 
                                uint MaxRpcSize, RPC_IF_CALLBACK_FN IfCallback, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUnregisterIf(void* IfSpec, GUID* MgrTypeUuid, uint WaitForCallsToComplete);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUnregisterIfEx(void* IfSpec, GUID* MgrTypeUuid, int RundownContextHandles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseAllProtseqs(uint MaxCalls, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseAllProtseqsEx(uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseAllProtseqsIf(uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseAllProtseqsIfEx(uint MaxCalls, void* IfSpec, void* SecurityDescriptor, RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqA(PSTR Protseq, uint MaxCalls, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqExA(PSTR Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqW(PWSTR Protseq, uint MaxCalls, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqExW(PWSTR Protseq, uint MaxCalls, void* SecurityDescriptor, RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqEpA(PSTR Protseq, uint MaxCalls, PSTR Endpoint, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqEpExA(PSTR Protseq, uint MaxCalls, PSTR Endpoint, void* SecurityDescriptor, 
                                    RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqEpW(PWSTR Protseq, uint MaxCalls, PWSTR Endpoint, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqEpExW(PWSTR Protseq, uint MaxCalls, PWSTR Endpoint, void* SecurityDescriptor, 
                                    RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqIfA(PSTR Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqIfExA(PSTR Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                                    RPC_POLICY* Policy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqIfW(PWSTR Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUseProtseqIfExW(PWSTR Protseq, uint MaxCalls, void* IfSpec, void* SecurityDescriptor, 
                                    RPC_POLICY* Policy);

@DllImport("RPCRT4.dll")
void RpcServerYield();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtStatsVectorFree(RPC_STATS_VECTOR** StatsVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqStats(void* Binding, RPC_STATS_VECTOR** Statistics);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtIsServerListening(void* Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtStopServerListening(void* Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtWaitServerListen();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtSetServerStackSize(uint ThreadStackSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsDontSerializeContext();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEnableIdleCleanup();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqIfIds(void* Binding, RPC_IF_ID_VECTOR** IfIdVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcIfIdVectorFree(RPC_IF_ID_VECTOR** IfIdVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqServerPrincNameA(void* Binding, uint AuthnSvc, PSTR* ServerPrincName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtInqServerPrincNameW(void* Binding, uint AuthnSvc, PWSTR* ServerPrincName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqDefaultPrincNameA(uint AuthnSvc, PSTR* PrincName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqDefaultPrincNameW(uint AuthnSvc, PWSTR* PrincName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpResolveBinding(void* Binding, void* IfSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNsBindingInqEntryNameA(void* Binding, uint EntryNameSyntax, PSTR* EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcNsBindingInqEntryNameW(void* Binding, uint EntryNameSyntax, PWSTR* EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingCreateA(RPC_BINDING_HANDLE_TEMPLATE_V1_A* Template, 
                             RPC_BINDING_HANDLE_SECURITY_V1_A* Security, RPC_BINDING_HANDLE_OPTIONS_V1* Options, 
                             void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingCreateW(RPC_BINDING_HANDLE_TEMPLATE_V1_W* Template, 
                             RPC_BINDING_HANDLE_SECURITY_V1_W* Security, RPC_BINDING_HANDLE_OPTIONS_V1* Options, 
                             void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqBindingHandle(void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcImpersonateClient(void* BindingHandle);

@DllImport("RPCRT4.dll")
RPC_STATUS RpcImpersonateClient2(void* BindingHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcRevertToSelfEx(void* BindingHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcRevertToSelf();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcImpersonateClientContainer(void* BindingHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcRevertContainerImpersonation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthClientA(void* ClientBinding, void** Privs, PSTR* ServerPrincName, uint* AuthnLevel, 
                                    uint* AuthnSvc, uint* AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthClientW(void* ClientBinding, void** Privs, PWSTR* ServerPrincName, uint* AuthnLevel, 
                                    uint* AuthnSvc, uint* AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthClientExA(void* ClientBinding, void** Privs, PSTR* ServerPrincName, uint* AuthnLevel, 
                                      uint* AuthnSvc, uint* AuthzSvc, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthClientExW(void* ClientBinding, void** Privs, PWSTR* ServerPrincName, uint* AuthnLevel, 
                                      uint* AuthnSvc, uint* AuthzSvc, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthInfoA(void* Binding, PSTR* ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                                  void** AuthIdentity, uint* AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthInfoW(void* Binding, PWSTR* ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                                  void** AuthIdentity, uint* AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetAuthInfoA(void* Binding, PSTR ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                                  void* AuthIdentity, uint AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetAuthInfoExA(void* Binding, PSTR ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                                    void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQos);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetAuthInfoW(void* Binding, PWSTR ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                                  void* AuthIdentity, uint AuthzSvc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingSetAuthInfoExW(void* Binding, PWSTR ServerPrincName, uint AuthnLevel, uint AuthnSvc, 
                                    void* AuthIdentity, uint AuthzSvc, RPC_SECURITY_QOS* SecurityQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthInfoExA(void* Binding, PSTR* ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                                    void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, 
                                    RPC_SECURITY_QOS* SecurityQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingInqAuthInfoExW(void* Binding, PWSTR* ServerPrincName, uint* AuthnLevel, uint* AuthnSvc, 
                                    void** AuthIdentity, uint* AuthzSvc, uint RpcQosVersion, 
                                    RPC_SECURITY_QOS* SecurityQOS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerCompleteSecurityCallback(void* BindingHandle, RPC_STATUS Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterAuthInfoA(PSTR ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                                      void* Arg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerRegisterAuthInfoW(PWSTR ServerPrincName, uint AuthnSvc, RPC_AUTH_KEY_RETRIEVAL_FN GetKeyFn, 
                                      void* Arg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingServerFromClient(void* ClientBinding, void** ServerBinding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcRaiseException(RPC_STATUS exception);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcTestCancel();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerTestCancel(void* BindingHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcCancelThread(void* Thread);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcCancelThreadEx(void* Thread, int Timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidCreate(GUID* Uuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidCreateSequential(GUID* Uuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidToStringA(const(GUID)* Uuid, PSTR* StringUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidFromStringA(PSTR StringUuid, GUID* Uuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidToStringW(const(GUID)* Uuid, PWSTR* StringUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidFromStringW(PWSTR StringUuid, GUID* Uuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
int UuidCompare(GUID* Uuid1, GUID* Uuid2, RPC_STATUS* Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS UuidCreateNil(GUID* NilUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
int UuidEqual(GUID* Uuid1, GUID* Uuid2, RPC_STATUS* Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ushort UuidHash(GUID* Uuid, RPC_STATUS* Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
int UuidIsNil(GUID* Uuid, RPC_STATUS* Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpRegisterNoReplaceA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                                   PSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpRegisterNoReplaceW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                                   PWSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpRegisterA(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                          PSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpRegisterW(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector, 
                          PWSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcEpUnregister(void* IfSpec, RPC_BINDING_VECTOR* BindingVector, UUID_VECTOR* UuidVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS DceErrorInqTextA(RPC_STATUS RpcStatus, PSTR ErrorText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS DceErrorInqTextW(RPC_STATUS RpcStatus, PWSTR ErrorText);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEpEltInqBegin(void* EpBinding, uint InquiryType, RPC_IF_ID* IfId, uint VersOption, 
                                GUID* ObjectUuid, void*** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEpEltInqDone(void*** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEpEltInqNextA(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                                PSTR* Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEpEltInqNextW(void** InquiryContext, RPC_IF_ID* IfId, void** Binding, GUID* ObjectUuid, 
                                PWSTR* Annotation);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcdce/nf-rpcdce-rpcmgmtepunregister
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtEpUnregister(void* EpBinding, RPC_IF_ID* IfId, void* Binding, GUID* ObjectUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcMgmtSetAuthorizationFn(RPC_MGMT_AUTHORIZATION_FN AuthorizationFn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
int RpcExceptionFilter(uint ExceptionCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupCreateW(RPC_INTERFACE_TEMPLATEW* Interfaces, uint NumIfs, 
                                          RPC_ENDPOINT_TEMPLATEW* Endpoints, uint NumEndpoints, uint IdlePeriod, 
                                          RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                          void* IdleCallbackContext, void** IfGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupCreateA(RPC_INTERFACE_TEMPLATEA* Interfaces, uint NumIfs, 
                                          RPC_ENDPOINT_TEMPLATEA* Endpoints, uint NumEndpoints, uint IdlePeriod, 
                                          RPC_INTERFACE_GROUP_IDLE_CALLBACK_FN IdleCallbackFn, 
                                          void* IdleCallbackContext, void** IfGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupClose(void* IfGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupActivate(void* IfGroup);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupDeactivate(void* IfGroup, uint ForceDeactivation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInterfaceGroupInqBindings(void* IfGroup, RPC_BINDING_VECTOR** BindingVector);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcNegotiateTransferSyntax(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcGetBufferWithObject(RPC_MESSAGE* Message, GUID* ObjectUuid);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcSendReceive(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcFreeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcSend(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcReceive(RPC_MESSAGE* Message, uint Size);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcFreePipeBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcReallocPipeBuffer(RPC_MESSAGE* Message, uint NewSize);

@DllImport("RPCRT4.dll")
void I_RpcRequestMutex(void** Mutex);

@DllImport("RPCRT4.dll")
void I_RpcClearMutex(void* Mutex);

@DllImport("RPCRT4.dll")
void I_RpcDeleteMutex(void* Mutex);

@DllImport("RPCRT4.dll")
void* I_RpcAllocate(uint Size);

@DllImport("RPCRT4.dll")
void I_RpcFree(void* Object);

@DllImport("RPCRT4.dll")
void I_RpcPauseExecution(uint Milliseconds);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcGetExtendedError();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcSystemHandleTypeSpecificWork(void* Handle, ubyte ActualType, ubyte IdlType, 
                                             LRPC_SYSTEM_HANDLE_MARSHAL_DIRECTION MarshalDirection);

@DllImport("RPCRT4.dll")
void* I_RpcGetCurrentCallHandle();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcNsInterfaceExported(uint EntryNameSyntax, ushort* EntryName, 
                                    RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcNsInterfaceUnexported(uint EntryNameSyntax, ushort* EntryName, 
                                      RPC_SERVER_INTERFACE* RpcInterfaceInformation);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingToStaticStringBindingW(void* Binding, ushort** StringBinding);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqSecurityContext(void* Binding, void** SecurityContextHandle);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqSecurityContextKeyInfo(void* Binding, void* KeyInfo);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqWireIdForSnego(void* Binding, ubyte* WireId);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqMarshalledTargetInfo(void* Binding, uint* MarshalledTargetInfoSize, 
                                               PSTR* MarshalledTargetInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqLocalClientPID(void* Binding, uint* Pid);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingHandleToAsyncHandle(void* Binding, void** AsyncHandle);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcNsBindingSetEntryNameW(void* Binding, uint EntryNameSyntax, PWSTR EntryName);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcNsBindingSetEntryNameA(void* Binding, uint EntryNameSyntax, PSTR EntryName);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerUseProtseqEp2A(PSTR NetworkAddress, PSTR Protseq, uint MaxCalls, PSTR Endpoint, 
                                     void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerUseProtseqEp2W(PWSTR NetworkAddress, PWSTR Protseq, uint MaxCalls, PWSTR Endpoint, 
                                     void* SecurityDescriptor, void* Policy);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerUseProtseq2W(PWSTR NetworkAddress, PWSTR Protseq, uint MaxCalls, void* SecurityDescriptor, 
                                   void* Policy);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerUseProtseq2A(PSTR NetworkAddress, PSTR Protseq, uint MaxCalls, void* SecurityDescriptor, 
                                   void* Policy);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerStartService(PWSTR Protseq, PWSTR Endpoint, void* IfSpec);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqDynamicEndpointW(void* Binding, PWSTR* DynamicEndpoint);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqDynamicEndpointA(void* Binding, PSTR* DynamicEndpoint);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerCheckClientRestriction(void* Context);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqTransportType(void* Binding, uint* Type);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcIfInqTransferSyntaxes(void* RpcIfHandle, RPC_TRANSFER_SYNTAX* TransferSyntaxes, 
                                      uint TransferSyntaxSize, uint* TransferSyntaxCount);

@DllImport("RPCRT4.dll")
RPC_STATUS I_UuidCreate(GUID* Uuid);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingCopy(void* SourceBinding, void** DestinationBinding);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingIsClientLocal(void* BindingHandle, uint* ClientLocalFlag);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingCreateNP(PWSTR ServerName, PWSTR ServiceName, PWSTR NetworkOptions, void** Binding);

@DllImport("RPCRT4.dll")
void I_RpcSsDontSerializeContext();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerRegisterForwardFunction(RPC_FORWARD_FUNCTION* pForwardFunction);

@DllImport("RPCRT4.dll")
RPC_ADDRESS_CHANGE_FN* I_RpcServerInqAddressChangeFn();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerSetAddressChangeFn(RPC_ADDRESS_CHANGE_FN* pAddressChangeFn);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerInqLocalConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerInqRemoteConnAddress(void* Binding, void* Buffer, uint* BufferSize, uint* AddressFormat);

@DllImport("RPCRT4.dll")
void I_RpcSessionStrictContextHandle();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcTurnOnEEInfoPropagation();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerInqTransportType(uint* Type);

@DllImport("RPCRT4.dll")
int I_RpcMapWin32Status(RPC_STATUS Status);

@DllImport("RPCRT4.dll")
void I_RpcRecordCalloutFailure(RPC_STATUS RpcStatus, RDR_CALLOUT_STATE* CallOutState, ushort* DllName);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcMgmtEnableDedicatedThreadPool();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcGetDefaultSD(void** ppSecurityDescriptor);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcOpenClientProcess(void* Binding, uint DesiredAccess, void** ClientProcess);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingIsServerLocal(void* Binding, uint* ServerLocalFlag);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingSetPrivateOption(void* hBinding, uint option, size_t optionValue);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerSubscribeForDisconnectNotification(void* Binding, void* hEvent);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerGetAssociationID(void* Binding, uint* AssociationID);

@DllImport("RPCRT4.dll")
int I_RpcServerDisableExceptionFilter();

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerSubscribeForDisconnectNotification2(void* Binding, void* hEvent, GUID* SubscriptionId);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcServerUnsubscribeForDisconnectNotification(void* Binding, GUID SubscriptionId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingExportA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                               UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingUnexportA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingExportW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, RPC_BINDING_VECTOR* BindingVec, 
                               UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingUnexportW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingExportPnPA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingUnexportPnPA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingExportPnPW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingUnexportPnPW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, UUID_VECTOR* ObjectVector);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingLookupBeginA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, GUID* ObjUuid, 
                                    uint BindingMaxCount, void** LookupContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingLookupBeginW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, GUID* ObjUuid, 
                                    uint BindingMaxCount, void** LookupContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingLookupNext(void* LookupContext, RPC_BINDING_VECTOR** BindingVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingLookupDone(void** LookupContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupDeleteA(GROUP_NAME_SYNTAX GroupNameSyntax, PSTR GroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrAddA(uint GroupNameSyntax, PSTR GroupName, uint MemberNameSyntax, PSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrRemoveA(uint GroupNameSyntax, PSTR GroupName, uint MemberNameSyntax, PSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrInqBeginA(uint GroupNameSyntax, PSTR GroupName, uint MemberNameSyntax, 
                                  void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrInqNextA(void* InquiryContext, PSTR* MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupDeleteW(GROUP_NAME_SYNTAX GroupNameSyntax, PWSTR GroupName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrAddW(uint GroupNameSyntax, PWSTR GroupName, uint MemberNameSyntax, PWSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrRemoveW(uint GroupNameSyntax, PWSTR GroupName, uint MemberNameSyntax, PWSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrInqBeginW(uint GroupNameSyntax, PWSTR GroupName, uint MemberNameSyntax, 
                                  void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrInqNextW(void* InquiryContext, PWSTR* MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsGroupMbrInqDone(void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileDeleteA(uint ProfileNameSyntax, PSTR ProfileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltAddA(uint ProfileNameSyntax, PSTR ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                               PSTR MemberName, uint Priority, PSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltRemoveA(uint ProfileNameSyntax, PSTR ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                                  PSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltInqBeginA(uint ProfileNameSyntax, PSTR ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                                    uint VersOption, uint MemberNameSyntax, PSTR MemberName, void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltInqNextA(void* InquiryContext, RPC_IF_ID* IfId, PSTR* MemberName, uint* Priority, 
                                   PSTR* Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileDeleteW(uint ProfileNameSyntax, PWSTR ProfileName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltAddW(uint ProfileNameSyntax, PWSTR ProfileName, RPC_IF_ID* IfId, uint MemberNameSyntax, 
                               PWSTR MemberName, uint Priority, PWSTR Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltRemoveW(uint ProfileNameSyntax, PWSTR ProfileName, RPC_IF_ID* IfId, 
                                  uint MemberNameSyntax, PWSTR MemberName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltInqBeginW(uint ProfileNameSyntax, PWSTR ProfileName, uint InquiryType, RPC_IF_ID* IfId, 
                                    uint VersOption, uint MemberNameSyntax, PWSTR MemberName, void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltInqNextW(void* InquiryContext, RPC_IF_ID* IfId, PWSTR* MemberName, uint* Priority, 
                                   PWSTR* Annotation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsProfileEltInqDone(void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryObjectInqBeginA(uint EntryNameSyntax, PSTR EntryName, void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryObjectInqBeginW(uint EntryNameSyntax, PWSTR EntryName, void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryObjectInqNext(void* InquiryContext, GUID* ObjUuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryObjectInqDone(void** InquiryContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryExpandNameA(uint EntryNameSyntax, PSTR EntryName, PSTR* ExpandedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtBindingUnexportA(uint EntryNameSyntax, PSTR EntryName, RPC_IF_ID* IfId, uint VersOption, 
                                     UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryCreateA(uint EntryNameSyntax, PSTR EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryDeleteA(uint EntryNameSyntax, PSTR EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryInqIfIdsA(uint EntryNameSyntax, PSTR EntryName, RPC_IF_ID_VECTOR** IfIdVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtHandleSetExpAge(void* NsHandle, uint ExpirationAge);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtInqExpAge(uint* ExpirationAge);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtSetExpAge(uint ExpirationAge);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsEntryExpandNameW(uint EntryNameSyntax, PWSTR EntryName, PWSTR* ExpandedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtBindingUnexportW(uint EntryNameSyntax, PWSTR EntryName, RPC_IF_ID* IfId, uint VersOption, 
                                     UUID_VECTOR* ObjectUuidVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryCreateW(uint EntryNameSyntax, PWSTR EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryDeleteW(uint EntryNameSyntax, PWSTR EntryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsMgmtEntryInqIfIdsW(uint EntryNameSyntax, PWSTR EntryName, RPC_IF_ID_VECTOR** IfIdVec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingImportBeginA(uint EntryNameSyntax, PSTR EntryName, void* IfSpec, GUID* ObjUuid, 
                                    void** ImportContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingImportBeginW(uint EntryNameSyntax, PWSTR EntryName, void* IfSpec, GUID* ObjUuid, 
                                    void** ImportContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingImportNext(void* ImportContext, void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingImportDone(void** ImportContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCNS4.dll")
RPC_STATUS RpcNsBindingSelect(RPC_BINDING_VECTOR* BindingVec, void** Binding);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncRegisterInfo(RPC_ASYNC_STATE* pAsync);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncInitializeHandle(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/RPC_ASYNC_STATE* pAsync, 
                                    uint Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncGetCallStatus(RPC_ASYNC_STATE* pAsync);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncCompleteCall(RPC_ASYNC_STATE* pAsync, void* Reply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcAsyncCancelCall(RPC_ASYNC_STATE* pAsync, BOOL fAbort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorStartEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorGetNextRecord(RPC_ERROR_ENUM_HANDLE* EnumHandle, BOOL CopyStrings, 
                                 RPC_EXTENDED_ERROR_INFO* ErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorEndEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorResetEnumeration(RPC_ERROR_ENUM_HANDLE* EnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorGetNumberOfRecords(RPC_ERROR_ENUM_HANDLE* EnumHandle, int* Records);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorSaveErrorInfo(RPC_ERROR_ENUM_HANDLE* EnumHandle, void** ErrorBlob, size_t* BlobSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorLoadErrorInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* ErrorBlob, 
                                 size_t BlobSize, RPC_ERROR_ENUM_HANDLE* EnumHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcErrorAddRecord(RPC_EXTENDED_ERROR_INFO* ErrorInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
void RpcErrorClearInformation();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcGetAuthorizationContextForClient(void* ClientBinding, BOOL ImpersonateOnReturn, void* Reserved1, 
                                               long* pExpirationTime, LUID Reserved2, uint Reserved3, 
                                               void* Reserved4, void** pAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcFreeAuthorizationContext(void** pAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSsContextLockExclusive(void* ServerBindingHandle, void* UserContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSsContextLockShared(void* ServerBindingHandle, void* UserContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqCallAttributesW(void* ClientBinding, void* RpcCallAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerInqCallAttributesA(void* ClientBinding, void* RpcCallAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerSubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, 
                                             RPC_NOTIFICATION_TYPES NotificationType, 
                                             RPC_ASYNC_NOTIFICATION_INFO* NotificationInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcServerUnsubscribeForNotification(void* Binding, RPC_NOTIFICATIONS Notification, 
                                               uint* NotificationsQueued);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingBind(RPC_ASYNC_STATE* pAsync, void* Binding, void* IfSpec);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcBindingUnbind(void* Binding);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcAsyncSetHandle(RPC_MESSAGE* Message, RPC_ASYNC_STATE* pAsync);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcAsyncAbortCall(RPC_ASYNC_STATE* pAsync, uint ExceptionCode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcasync/nf-rpcasync-i_rpcexceptionfilter
@DllImport("RPCRT4.dll")
int I_RpcExceptionFilter(uint ExceptionCode);

@DllImport("RPCRT4.dll")
RPC_STATUS I_RpcBindingInqClientTokenAttributes(void* Binding, LUID* TokenId, LUID* AuthenticationId, 
                                                LUID* ModifiedId);

@DllImport("RPCNS4.dll")
RPC_STATUS I_RpcNsGetBuffer(RPC_MESSAGE* Message);

@DllImport("RPCNS4.dll")
RPC_STATUS I_RpcNsSendReceive(RPC_MESSAGE* Message, void** Handle);

@DllImport("RPCNS4.dll")
void I_RpcNsRaiseException(RPC_MESSAGE* Message, RPC_STATUS Status);

@DllImport("RPCNS4.dll")
RPC_STATUS I_RpcReBindBuffer(RPC_MESSAGE* Message);

@DllImport("RPCRT4.dll")
void* NDRCContextBinding(ptrdiff_t CContext);

@DllImport("RPCRT4.dll")
void NDRCContextMarshall(ptrdiff_t CContext, void* pBuff);

@DllImport("RPCRT4.dll")
void NDRCContextUnmarshall(ptrdiff_t* pCContext, void* hBinding, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
void NDRSContextMarshall(NDR_SCONTEXT* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NDRSContextUnmarshall(void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
void NDRSContextMarshallEx(void* BindingHandle, NDR_SCONTEXT* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn);

@DllImport("RPCRT4.dll")
void NDRSContextMarshall2(void* BindingHandle, NDR_SCONTEXT* CContext, void* pBuff, NDR_RUNDOWN userRunDownIn, 
                          void* CtxGuard, uint Flags);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NDRSContextUnmarshallEx(void* BindingHandle, void* pBuff, uint DataRepresentation);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NDRSContextUnmarshall2(void* BindingHandle, void* pBuff, uint DataRepresentation, void* CtxGuard, 
                                     uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsDestroyClientContext(void** ContextHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrSimpleTypeMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrSimpleStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrComplexStructMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrFixedArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/nf-rpcndr-ndrconformantarraymarshall
@DllImport("RPCRT4.dll")
ubyte* NdrConformantArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrVaryingArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrComplexArrayMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrNonConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrConformantStringMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrNonEncapsulatedUnionMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrByteCountPointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrXmitOrRepAsMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrInterfacePointerMarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrClientContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, ptrdiff_t ContextHandle, int fCheck);

@DllImport("RPCRT4.dll")
void NdrServerContextMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT* ContextHandle, NDR_RUNDOWN RundownRoutine);

@DllImport("RPCRT4.dll")
void NdrServerContextNewMarshall(MIDL_STUB_MESSAGE* pStubMsg, NDR_SCONTEXT* ContextHandle, 
                                 NDR_RUNDOWN RundownRoutine, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrSimpleTypeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte FormatChar);

@DllImport("RPCRT4.dll")
ubyte* NdrRangeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
void NdrCorrelationInitialize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory, uint CacheSize, uint flags);

@DllImport("RPCRT4.dll")
void NdrCorrelationPass(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
void NdrCorrelationFree(MIDL_STUB_MESSAGE* pStubMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrSimpleStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                            ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrComplexStructUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrFixedArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrConformantArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                    ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrConformantVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                           ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrVaryingArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrComplexArrayUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrNonConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                        ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrConformantStringUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                      ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrNonEncapsulatedUnionUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                         ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrByteCountPointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
ubyte* NdrXmitOrRepAsUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, ubyte fMustAlloc);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
ubyte* NdrInterfacePointerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte** ppMemory, ubyte* pFormat, 
                                     ubyte fMustAlloc);

@DllImport("RPCRT4.dll")
void NdrClientContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ptrdiff_t* pContextHandle, void* BindHandle);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NdrServerContextUnmarshall(MIDL_STUB_MESSAGE* pStubMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NdrContextHandleInitialize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
NDR_SCONTEXT* NdrServerContextNewUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrSimpleStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrComplexStructBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrFixedArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rpcndr/nf-rpcndr-ndrconformantarraybuffersize
@DllImport("RPCRT4.dll")
void NdrConformantArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrVaryingArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrComplexArrayBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonConformantStringBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonEncapsulatedUnionBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrByteCountPointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrXmitOrRepAsBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrUserMarshalBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrInterfacePointerBufferSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
void NdrContextHandleSize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrPointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrSimpleStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantVaryingStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrComplexStructMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrFixedArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrVaryingArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrComplexArrayMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrNonConformantStringMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrNonEncapsulatedUnionMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrXmitOrRepAsMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrUserMarshalMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
uint NdrInterfacePointerMemorySize(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrSimpleStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexStructFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrFixedArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConformantVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrVaryingArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrComplexArrayFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrNonEncapsulatedUnionFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrByteCountPointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrXmitOrRepAsFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrUserMarshalFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrInterfacePointerFree(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pMemory, ubyte* pFormat);

@DllImport("RPCRT4.dll")
void NdrConvert2(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, int NumberParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrConvert(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat);

@DllImport("RPCRT4.dll")
ubyte* NdrUserMarshalSimpleTypeConvert(uint* pFlags, ubyte* pBuffer, ubyte FormatChar);

@DllImport("RPCRT4.dll")
void NdrClientInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                            uint ProcNum);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitializeNew(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4.dll")
void NdrServerInitializePartial(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                                uint RequestedBufferSize);

@DllImport("RPCRT4.dll")
void NdrClientInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                         uint ProcNum);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitialize(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor);

@DllImport("RPCRT4.dll")
ubyte* NdrServerInitializeUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, MIDL_STUB_DESC* pStubDescriptor, 
                                     RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrServerInitializeMarshall(RPC_MESSAGE* pRpcMsg, MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
ubyte* NdrGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4.dll")
ubyte* NdrNsGetBuffer(MIDL_STUB_MESSAGE* pStubMsg, uint BufferLength, void* Handle);

@DllImport("RPCRT4.dll")
ubyte* NdrSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd);

@DllImport("RPCRT4.dll")
ubyte* NdrNsSendReceive(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pBufferEnd, void** pAutoHandle);

@DllImport("RPCRT4.dll")
void NdrFreeBuffer(MIDL_STUB_MESSAGE* pStubMsg);

@DllImport("RPCRT4.dll")
HRESULT NdrGetDcomProtocolVersion(MIDL_STUB_MESSAGE* pStubMsg, RPC_VERSION* pVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrClientCall2(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrDcomAsyncClientCall(MIDL_STUB_DESC* pStubDescriptor, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrAsyncServerCall(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
int NdrDcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                         uint* pdwStubPhase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
int NdrStubCall2(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrServerCall2(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
RPC_STATUS NdrMapCommAndFaultStatus(MIDL_STUB_MESSAGE* pStubMsg, uint* pCommStatus, uint* pFaultStatus, 
                                    RPC_STATUS Status);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void* RpcSsAllocate(size_t Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsDisableAllocate();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsEnableAllocate();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsFree(void* NodeToFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void* RpcSsGetThreadHandle();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsSetClientAllocFree(RPC_CLIENT_ALLOC ClientAlloc, RPC_CLIENT_FREE ClientFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsSetThreadHandle(void* Id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void RpcSsSwapClientAllocFree(RPC_CLIENT_ALLOC ClientAlloc, RPC_CLIENT_FREE ClientFree, 
                              RPC_CLIENT_ALLOC* OldClientAlloc, RPC_CLIENT_FREE* OldClientFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void* RpcSmAllocate(size_t Size, RPC_STATUS* pStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmClientFree(void* pNodeToFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmDestroyClientContext(void** ContextHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmDisableAllocate();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmEnableAllocate();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmFree(void* NodeToFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void* RpcSmGetThreadHandle(RPC_STATUS* pStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmSetClientAllocFree(RPC_CLIENT_ALLOC ClientAlloc, RPC_CLIENT_FREE ClientFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmSetThreadHandle(void* Id);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcSmSwapClientAllocFree(RPC_CLIENT_ALLOC ClientAlloc, RPC_CLIENT_FREE ClientFree, 
                                    RPC_CLIENT_ALLOC* OldClientAlloc, RPC_CLIENT_FREE* OldClientFree);

@DllImport("RPCRT4.dll")
void NdrRpcSsEnableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void NdrRpcSsDisableAllocate(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void NdrRpcSmSetClientToOsf(MIDL_STUB_MESSAGE* pMessage);

@DllImport("RPCRT4.dll")
void* NdrRpcSmClientAllocate(size_t Size);

@DllImport("RPCRT4.dll")
void NdrRpcSmClientFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
void* NdrRpcSsDefaultAllocate(size_t Size);

@DllImport("RPCRT4.dll")
void NdrRpcSsDefaultFree(void* NodeToFree);

@DllImport("RPCRT4.dll")
FULL_PTR_XLAT_TABLES* NdrFullPointerXlatInit(uint NumberOfPointers, XLAT_SIDE XlatSide);

@DllImport("RPCRT4.dll")
void NdrFullPointerXlatFree(FULL_PTR_XLAT_TABLES* pXlatTables);

@DllImport("RPCRT4.dll")
void* NdrAllocate(MIDL_STUB_MESSAGE* pStubMsg, size_t Len);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrClearOutParameters(MIDL_STUB_MESSAGE* pStubMsg, ubyte* pFormat, void* ArgAddr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void* NdrOleAllocate(size_t Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
void NdrOleFree(void* NodeToFree);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS NdrGetUserMarshalInfo(uint* pFlags, uint InformationLevel, NDR_USER_MARSHAL_INFO* pMarshalInfo);

@DllImport("RPCRT4.dll")
RPC_STATUS NdrCreateServerInterfaceFromStub(IRpcStubBuffer pStub, RPC_SERVER_INTERFACE* pServerIf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrClientCall3(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN Ndr64AsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN Ndr64DcomAsyncClientCall(MIDL_STUBLESS_PROXY_INFO* pProxyInfo, uint nProcNum, 
                                            void* pReturnValue);

@DllImport("RPCRT4.dll")
void Ndr64AsyncServerCall64(RPC_MESSAGE* pRpcMsg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
void Ndr64AsyncServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
int Ndr64DcomAsyncStubCall(IRpcStubBuffer pThis, IRpcChannelBuffer pChannel, RPC_MESSAGE* pRpcMsg, 
                           uint* pdwStubPhase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
int NdrStubCall3(void* pThis, void* pChannel, RPC_MESSAGE* pRpcMsg, uint* pdwStubPhase);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
void NdrServerCallAll(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrServerCallNdr64(RPC_MESSAGE* pRpcMsg);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreClientMarshall(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreServerUnmarshall(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreClientBufferSize(MIDL_STUB_MESSAGE* pStubMsg, void* pMemory);

@DllImport("RPCRT4.dll")
void NdrPartialIgnoreServerInitialize(MIDL_STUB_MESSAGE* pStubMsg, void** ppMemory, ubyte* pFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("RPCRT4.dll")
void RpcUserFree(void* AsyncHandle, void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesEncodeIncrementalHandleCreate(void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, 
                                            void** pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesDecodeIncrementalHandleCreate(void* UserState, MIDL_ES_READ ReadFn, void** pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesIncrementalHandleReset(void* Handle, void* UserState, MIDL_ES_ALLOC AllocFn, MIDL_ES_WRITE WriteFn, 
                                     MIDL_ES_READ ReadFn, MIDL_ES_CODE Operation);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesEncodeFixedBufferHandleCreate(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR pBuffer, 
                                            uint BufferSize, uint* pEncodedSize, void** pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesEncodeDynBufferHandleCreate(byte** pBuffer, uint* pEncodedSize, void** pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesDecodeBufferHandleCreate(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR Buffer, 
                                       uint BufferSize, void** pHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesBufferHandleReset(void* Handle, uint HandleStyle, MIDL_ES_CODE Operation, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/byte** pBuffer, 
                                uint BufferSize, uint* pEncodedSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesHandleFree(void* Handle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS MesInqProcEncodingId(void* Handle, RPC_SYNTAX_IDENTIFIER* pInterfaceId, uint* pProcNum);

@DllImport("RPCRT4.dll")
size_t NdrMesSimpleTypeAlignSize(void* param0);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeDecode(void* Handle, void* pObject, short Size);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, const(void)* pObject, short Size);

@DllImport("RPCRT4.dll")
size_t NdrMesTypeAlignSize(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, 
                           const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
size_t NdrMesTypeAlignSize2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                            const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeFree2(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, const(MIDL_STUB_DESC)* pStubDesc, 
                     ubyte* pFormatString, void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesProcEncodeDecode(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode2(void* Handle, const(MIDL_STUB_DESC)* pStubDesc, ubyte* pFormatString);

@DllImport("RPCRT4.dll")
size_t NdrMesTypeAlignSize3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                            const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, 
                            uint nTypeIndex, const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeEncode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                       const(void)* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeDecode3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                       const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                       void* pObject);

@DllImport("RPCRT4.dll")
void NdrMesTypeFree3(void* Handle, const(MIDL_TYPE_PICKLING_INFO)* pPicklingInfo, 
                     const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(uint)** ArrTypeOffset, uint nTypeIndex, 
                     void* pObject);

@DllImport("RPCRT4.dll")
CLIENT_CALL_RETURN NdrMesProcEncodeDecode3(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, 
                                           uint nProcNum, void* pReturnValue);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeDecodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, void* pObject, 
                               short Size);

@DllImport("RPCRT4.dll")
void NdrMesSimpleTypeEncodeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo, const(void)* pObject, 
                               short Size);

@DllImport("RPCRT4.dll")
size_t NdrMesSimpleTypeAlignSizeAll(void* Handle, const(MIDL_STUBLESS_PROXY_INFO)* pProxyInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcCertGeneratePrincipalNameW(const(CERT_CONTEXT)* Context, uint Flags, PWSTR* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("RPCRT4.dll")
RPC_STATUS RpcCertGeneratePrincipalNameA(const(CERT_CONTEXT)* Context, uint Flags, PSTR* pBuffer);


