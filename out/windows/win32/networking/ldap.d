// Written in the D programming language.

module windows.win32.networking.ldap;

public import windows.core;
public import windows.win32.foundation : BOOLEAN, CHAR, HANDLE, PSTR, PWSTR, WIN32_ERROR;
public import windows.win32.security.authentication.identity : SecPkgContext_IssuerListInfoEx;
public import windows.win32.security.cryptography : CERT_CONTEXT;

extern(Windows) @nogc nothrow:


// Enums


alias LDAP_RETCODE = int;
enum : int
{
    LDAP_SUCCESS                    = 0x00000000,
    LDAP_OPERATIONS_ERROR           = 0x00000001,
    LDAP_PROTOCOL_ERROR             = 0x00000002,
    LDAP_TIMELIMIT_EXCEEDED         = 0x00000003,
    LDAP_SIZELIMIT_EXCEEDED         = 0x00000004,
    LDAP_COMPARE_FALSE              = 0x00000005,
    LDAP_COMPARE_TRUE               = 0x00000006,
    LDAP_AUTH_METHOD_NOT_SUPPORTED  = 0x00000007,
    LDAP_STRONG_AUTH_REQUIRED       = 0x00000008,
    LDAP_REFERRAL_V2                = 0x00000009,
    LDAP_PARTIAL_RESULTS            = 0x00000009,
    LDAP_REFERRAL                   = 0x0000000a,
    LDAP_ADMIN_LIMIT_EXCEEDED       = 0x0000000b,
    LDAP_UNAVAILABLE_CRIT_EXTENSION = 0x0000000c,
    LDAP_CONFIDENTIALITY_REQUIRED   = 0x0000000d,
    LDAP_SASL_BIND_IN_PROGRESS      = 0x0000000e,
    LDAP_NO_SUCH_ATTRIBUTE          = 0x00000010,
    LDAP_UNDEFINED_TYPE             = 0x00000011,
    LDAP_INAPPROPRIATE_MATCHING     = 0x00000012,
    LDAP_CONSTRAINT_VIOLATION       = 0x00000013,
    LDAP_ATTRIBUTE_OR_VALUE_EXISTS  = 0x00000014,
    LDAP_INVALID_SYNTAX             = 0x00000015,
    LDAP_NO_SUCH_OBJECT             = 0x00000020,
    LDAP_ALIAS_PROBLEM              = 0x00000021,
    LDAP_INVALID_DN_SYNTAX          = 0x00000022,
    LDAP_IS_LEAF                    = 0x00000023,
    LDAP_ALIAS_DEREF_PROBLEM        = 0x00000024,
    LDAP_INAPPROPRIATE_AUTH         = 0x00000030,
    LDAP_INVALID_CREDENTIALS        = 0x00000031,
    LDAP_INSUFFICIENT_RIGHTS        = 0x00000032,
    LDAP_BUSY                       = 0x00000033,
    LDAP_UNAVAILABLE                = 0x00000034,
    LDAP_UNWILLING_TO_PERFORM       = 0x00000035,
    LDAP_LOOP_DETECT                = 0x00000036,
    LDAP_SORT_CONTROL_MISSING       = 0x0000003c,
    LDAP_OFFSET_RANGE_ERROR         = 0x0000003d,
    LDAP_NAMING_VIOLATION           = 0x00000040,
    LDAP_OBJECT_CLASS_VIOLATION     = 0x00000041,
    LDAP_NOT_ALLOWED_ON_NONLEAF     = 0x00000042,
    LDAP_NOT_ALLOWED_ON_RDN         = 0x00000043,
    LDAP_ALREADY_EXISTS             = 0x00000044,
    LDAP_NO_OBJECT_CLASS_MODS       = 0x00000045,
    LDAP_RESULTS_TOO_LARGE          = 0x00000046,
    LDAP_AFFECTS_MULTIPLE_DSAS      = 0x00000047,
    LDAP_VIRTUAL_LIST_VIEW_ERROR    = 0x0000004c,
    LDAP_OTHER                      = 0x00000050,
    LDAP_SERVER_DOWN                = 0x00000051,
    LDAP_LOCAL_ERROR                = 0x00000052,
    LDAP_ENCODING_ERROR             = 0x00000053,
    LDAP_DECODING_ERROR             = 0x00000054,
    LDAP_TIMEOUT                    = 0x00000055,
    LDAP_AUTH_UNKNOWN               = 0x00000056,
    LDAP_FILTER_ERROR               = 0x00000057,
    LDAP_USER_CANCELLED             = 0x00000058,
    LDAP_PARAM_ERROR                = 0x00000059,
    LDAP_NO_MEMORY                  = 0x0000005a,
    LDAP_CONNECT_ERROR              = 0x0000005b,
    LDAP_NOT_SUPPORTED              = 0x0000005c,
    LDAP_NO_RESULTS_RETURNED        = 0x0000005e,
    LDAP_CONTROL_NOT_FOUND          = 0x0000005d,
    LDAP_MORE_RESULTS_TO_RETURN     = 0x0000005f,
    LDAP_CLIENT_LOOP                = 0x00000060,
    LDAP_REFERRAL_LIMIT_EXCEEDED    = 0x00000061,
}

// Constants


enum : int
{
    LBER_ERROR   = 0xffffffff,
    LBER_DEFAULT = 0xffffffff,
}

enum : uint
{
    LDAP_UNICODE  = 0x00000001U,
    LDAP_PORT     = 0x00000185U,
    LDAP_SSL_PORT = 0x0000027cU,
}

enum : uint
{
    LDAP_GC_PORT     = 0x00000cc4U,
    LDAP_SSL_GC_PORT = 0x00000cc5U,
}

enum : uint
{
    LDAP_VERSION1 = 0x00000001U,
    LDAP_VERSION2 = 0x00000002U,
    LDAP_VERSION3 = 0x00000003U,
    LDAP_VERSION  = 0x00000002U,
}

enum int LDAP_BIND_CMD = 0x00000060;
enum int LDAP_UNBIND_CMD = 0x00000042;
enum int LDAP_SEARCH_CMD = 0x00000063;
enum int LDAP_MODIFY_CMD = 0x00000066;

enum : int
{
    LDAP_ADD_CMD    = 0x00000068,
    LDAP_DELETE_CMD = 0x0000004a,
}

enum int LDAP_MODRDN_CMD = 0x0000006c;
enum int LDAP_COMPARE_CMD = 0x0000006e;
enum int LDAP_ABANDON_CMD = 0x00000050;
enum int LDAP_SESSION_CMD = 0x00000071;
enum int LDAP_EXTENDED_CMD = 0x00000077;

enum : int
{
    LDAP_RES_BIND          = 0x00000061,
    LDAP_RES_SEARCH_ENTRY  = 0x00000064,
    LDAP_RES_SEARCH_RESULT = 0x00000065,
    LDAP_RES_MODIFY        = 0x00000067,
    LDAP_RES_ADD           = 0x00000069,
    LDAP_RES_DELETE        = 0x0000006b,
    LDAP_RES_MODRDN        = 0x0000006d,
    LDAP_RES_COMPARE       = 0x0000006f,
    LDAP_RES_SESSION       = 0x00000072,
    LDAP_RES_REFERRAL      = 0x00000073,
    LDAP_RES_EXTENDED      = 0x00000078,
    LDAP_RES_ANY           = 0xffffffff,
}

enum : uint
{
    LDAP_INVALID_CMD = 0x000000ffU,
    LDAP_INVALID_RES = 0x000000ffU,
}

enum : int
{
    LDAP_AUTH_SIMPLE    = 0x00000080,
    LDAP_AUTH_SASL      = 0x00000083,
    LDAP_AUTH_OTHERKIND = 0x00000086,
}

enum : uint
{
    LDAP_FILTER_AND        = 0x000000a0U,
    LDAP_FILTER_OR         = 0x000000a1U,
    LDAP_FILTER_NOT        = 0x000000a2U,
    LDAP_FILTER_EQUALITY   = 0x000000a3U,
    LDAP_FILTER_SUBSTRINGS = 0x000000a4U,
    LDAP_FILTER_GE         = 0x000000a5U,
    LDAP_FILTER_LE         = 0x000000a6U,
    LDAP_FILTER_PRESENT    = 0x00000087U,
    LDAP_FILTER_APPROX     = 0x000000a8U,
    LDAP_FILTER_EXTENSIBLE = 0x000000a9U,
}

enum : int
{
    LDAP_SUBSTRING_INITIAL = 0x00000080,
    LDAP_SUBSTRING_ANY     = 0x00000081,
    LDAP_SUBSTRING_FINAL   = 0x00000082,
}

enum : uint
{
    LDAP_DEREF_NEVER     = 0x00000000U,
    LDAP_DEREF_SEARCHING = 0x00000001U,
    LDAP_DEREF_FINDING   = 0x00000002U,
    LDAP_DEREF_ALWAYS    = 0x00000003U,
}

enum uint LDAP_NO_LIMIT = 0x00000000U;

enum : uint
{
    LDAP_OPT_DNS             = 0x00000001U,
    LDAP_OPT_CHASE_REFERRALS = 0x00000002U,
}

enum uint LDAP_OPT_RETURN_REFS = 0x00000004U;

enum : const(wchar)*
{
    LDAP_CONTROL_REFERRALS_W = "1.2.840.113556.1.4.616",
    // Native encoding: ansi
    LDAP_CONTROL_REFERRALS   = "1.2.840.113556.1.4.616",
}

enum : uint
{
    LDAP_MOD_ADD     = 0x00000000U,
    LDAP_MOD_DELETE  = 0x00000001U,
    LDAP_MOD_REPLACE = 0x00000002U,
    LDAP_MOD_BVALUES = 0x00000080U,
}

enum : uint
{
    LDAP_OPT_API_INFO       = 0x00000000U,
    LDAP_OPT_DESC           = 0x00000001U,
    LDAP_OPT_DEREF          = 0x00000002U,
    LDAP_OPT_SIZELIMIT      = 0x00000003U,
    LDAP_OPT_TIMELIMIT      = 0x00000004U,
    LDAP_OPT_THREAD_FN_PTRS = 0x00000005U,
}

enum : uint
{
    LDAP_OPT_REBIND_FN          = 0x00000006U,
    LDAP_OPT_REBIND_ARG         = 0x00000007U,
    LDAP_OPT_REFERRALS          = 0x00000008U,
    LDAP_OPT_RESTART            = 0x00000009U,
    LDAP_OPT_SSL                = 0x0000000aU,
    LDAP_OPT_IO_FN_PTRS         = 0x0000000bU,
    LDAP_OPT_CACHE_FN_PTRS      = 0x0000000dU,
    LDAP_OPT_CACHE_STRATEGY     = 0x0000000eU,
    LDAP_OPT_CACHE_ENABLE       = 0x0000000fU,
    LDAP_OPT_REFERRAL_HOP_LIMIT = 0x00000010U,
}

enum uint LDAP_OPT_PROTOCOL_VERSION = 0x00000011U;

enum : uint
{
    LDAP_OPT_VERSION          = 0x00000011U,
    LDAP_OPT_API_FEATURE_INFO = 0x00000015U,
}

enum : uint
{
    LDAP_OPT_HOST_NAME        = 0x00000030U,
    LDAP_OPT_ERROR_NUMBER     = 0x00000031U,
    LDAP_OPT_ERROR_STRING     = 0x00000032U,
    LDAP_OPT_SERVER_ERROR     = 0x00000033U,
    LDAP_OPT_SERVER_EXT_ERROR = 0x00000034U,
}

enum uint LDAP_OPT_HOST_REACHABLE = 0x0000003eU;

enum : uint
{
    LDAP_OPT_PING_KEEP_ALIVE = 0x00000036U,
    LDAP_OPT_PING_WAIT_TIME  = 0x00000037U,
    LDAP_OPT_PING_LIMIT      = 0x00000038U,
    LDAP_OPT_DNSDOMAIN_NAME  = 0x0000003bU,
}

enum uint LDAP_OPT_GETDSNAME_FLAGS = 0x0000003dU;
enum uint LDAP_OPT_PROMPT_CREDENTIALS = 0x0000003fU;
enum uint LDAP_OPT_AUTO_RECONNECT = 0x00000091U;

enum : uint
{
    LDAP_OPT_SSPI_FLAGS     = 0x00000092U,
    LDAP_OPT_SSL_INFO       = 0x00000093U,
    LDAP_OPT_TLS            = 0x0000000aU,
    LDAP_OPT_TLS_INFO       = 0x00000093U,
    LDAP_OPT_SIGN           = 0x00000095U,
    LDAP_OPT_ENCRYPT        = 0x00000096U,
    LDAP_OPT_SASL_METHOD    = 0x00000097U,
    LDAP_OPT_AREC_EXCLUSIVE = 0x00000098U,
}

enum uint LDAP_OPT_SECURITY_CONTEXT = 0x00000099U;

enum : uint
{
    LDAP_OPT_ROOTDSE_CACHE        = 0x0000009aU,
    LDAP_OPT_TCP_KEEPALIVE        = 0x00000040U,
    LDAP_OPT_FAST_CONCURRENT_BIND = 0x00000041U,
}

enum : uint
{
    LDAP_OPT_SEND_TIMEOUT          = 0x00000042U,
    LDAP_OPT_SCH_FLAGS             = 0x00000043U,
    LDAP_OPT_SOCKET_BIND_ADDRESSES = 0x00000044U,
}

enum : uint
{
    LDAP_OPT_CLDAP_TIMEOUT           = 0x00000045U,
    LDAP_OPT_CLDAP_TRIES             = 0x00000046U,
    LDAP_OPT_ANONYMOUS_MAX_VAL_RANGE = 0x00000047U,
}

enum uint LDAP_CHASE_SUBORDINATE_REFERRALS = 0x00000020U;
enum uint LDAP_CHASE_EXTERNAL_REFERRALS = 0x00000040U;

enum : uint
{
    LDAP_SCOPE_BASE     = 0x00000000U,
    LDAP_SCOPE_ONELEVEL = 0x00000001U,
    LDAP_SCOPE_SUBTREE  = 0x00000002U,
}

enum : uint
{
    LDAP_MSG_ONE      = 0x00000000U,
    LDAP_MSG_ALL      = 0x00000001U,
    LDAP_MSG_RECEIVED = 0x00000002U,
}

enum : uint
{
    LBER_USE_DER            = 0x00000001U,
    LBER_USE_INDEFINITE_LEN = 0x00000002U,
}

enum uint LBER_TRANSLATE_STRINGS = 0x00000004U;
enum uint LAPI_MAJOR_VER1 = 0x00000001U;
enum uint LAPI_MINOR_VER1 = 0x00000001U;

enum : uint
{
    LDAP_API_INFO_VERSION = 0x00000001U,
    LDAP_API_VERSION      = 0x000007d4U,
}

enum : uint
{
    LDAP_VERSION_MIN = 0x00000002U,
    LDAP_VERSION_MAX = 0x00000003U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_VENDOR_NAME   = "Microsoft Corporation.",
    LDAP_VENDOR_NAME_W = "Microsoft Corporation.",
}

enum uint LDAP_VENDOR_VERSION = 0x000001feU;
enum uint LDAP_FEATURE_INFO_VERSION = 0x00000001U;

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_SORT_OID        = "1.2.840.113556.1.4.473",
    LDAP_SERVER_SORT_OID_W      = "1.2.840.113556.1.4.473",
    // Native encoding: ansi
    LDAP_SERVER_RESP_SORT_OID   = "1.2.840.113556.1.4.474",
    LDAP_SERVER_RESP_SORT_OID_W = "1.2.840.113556.1.4.474",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_PAGED_RESULT_OID_STRING   = "1.2.840.113556.1.4.319",
    LDAP_PAGED_RESULT_OID_STRING_W = "1.2.840.113556.1.4.319",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_CONTROL_VLVREQUEST    = "2.16.840.1.113730.3.4.9",
    LDAP_CONTROL_VLVREQUEST_W  = "2.16.840.1.113730.3.4.9",
    // Native encoding: ansi
    LDAP_CONTROL_VLVRESPONSE   = "2.16.840.1.113730.3.4.10",
    LDAP_CONTROL_VLVRESPONSE_W = "2.16.840.1.113730.3.4.10",
}

enum uint LDAP_API_FEATURE_VIRTUAL_LIST_VIEW = 0x000003e9U;
enum uint LDAP_VLVINFO_VERSION = 0x00000001U;

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_START_TLS_OID   = "1.3.6.1.4.1.1466.20037",
    LDAP_START_TLS_OID_W = "1.3.6.1.4.1.1466.20037",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_TTL_EXTENDED_OP_OID   = "1.3.6.1.4.1.1466.101.119.1",
    LDAP_TTL_EXTENDED_OP_OID_W = "1.3.6.1.4.1.1466.101.119.1",
}

enum uint LDAP_OPT_REFERRAL_CALLBACK = 0x00000070U;
enum uint LDAP_OPT_CLIENT_CERTIFICATE = 0x00000080U;
enum uint LDAP_OPT_SERVER_CERTIFICATE = 0x00000081U;
enum uint LDAP_OPT_REF_DEREF_CONN_PER_MSG = 0x00000094U;

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_FORCE_UPDATE_OID   = "1.2.840.113556.1.4.1974",
    LDAP_SERVER_FORCE_UPDATE_OID_W = "1.2.840.113556.1.4.1974",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_PERMISSIVE_MODIFY_OID   = "1.2.840.113556.1.4.1413",
    LDAP_SERVER_PERMISSIVE_MODIFY_OID_W = "1.2.840.113556.1.4.1413",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_SHOW_DELETED_OID    = "1.2.840.113556.1.4.417",
    LDAP_SERVER_SHOW_DELETED_OID_W  = "1.2.840.113556.1.4.417",
    // Native encoding: ansi
    LDAP_SERVER_SHOW_RECYCLED_OID   = "1.2.840.113556.1.4.2064",
    LDAP_SERVER_SHOW_RECYCLED_OID_W = "1.2.840.113556.1.4.2064",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_EXPECTED_ENTRY_COUNT_OID   = "1.2.840.113556.1.4.2211",
    LDAP_SERVER_EXPECTED_ENTRY_COUNT_OID_W = "1.2.840.113556.1.4.2211",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_SEARCH_HINTS_OID   = "1.2.840.113556.1.4.2206",
    LDAP_SERVER_SEARCH_HINTS_OID_W = "1.2.840.113556.1.4.2206",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SEARCH_HINT_INDEX_ONLY_OID        = "1.2.840.113556.1.4.2207",
    LDAP_SEARCH_HINT_INDEX_ONLY_OID_W      = "1.2.840.113556.1.4.2207",
    // Native encoding: ansi
    LDAP_SEARCH_HINT_SOFT_SIZE_LIMIT_OID   = "1.2.840.113556.1.4.2210",
    LDAP_SEARCH_HINT_SOFT_SIZE_LIMIT_OID_W = "1.2.840.113556.1.4.2210",
    // Native encoding: ansi
    LDAP_SEARCH_HINT_REQUIRED_INDEX_OID    = "1.2.840.113556.1.4.2306",
    LDAP_SEARCH_HINT_REQUIRED_INDEX_OID_W  = "1.2.840.113556.1.4.2306",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_UPDATE_STATS_OID   = "1.2.840.113556.1.4.2205",
    LDAP_SERVER_UPDATE_STATS_OID_W = "1.2.840.113556.1.4.2205",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_UPDATE_STATS_USN_OID            = "1.2.840.113556.1.4.2208",
    LDAP_UPDATE_STATS_USN_OID_W          = "1.2.840.113556.1.4.2208",
    // Native encoding: ansi
    LDAP_UPDATE_STATS_INVOCATIONID_OID   = "1.2.840.113556.1.4.2209",
    LDAP_UPDATE_STATS_INVOCATIONID_OID_W = "1.2.840.113556.1.4.2209",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_GET_STATS_OID               = "1.2.840.113556.1.4.970",
    LDAP_SERVER_GET_STATS_OID_W             = "1.2.840.113556.1.4.970",
    // Native encoding: ansi
    LDAP_SERVER_SHOW_DEACTIVATED_LINK_OID   = "1.2.840.113556.1.4.2065",
    LDAP_SERVER_SHOW_DEACTIVATED_LINK_OID_W = "1.2.840.113556.1.4.2065",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_POLICY_HINTS_DEPRECATED_OID   = "1.2.840.113556.1.4.2066",
    LDAP_SERVER_POLICY_HINTS_DEPRECATED_OID_W = "1.2.840.113556.1.4.2066",
    // Native encoding: ansi
    LDAP_SERVER_POLICY_HINTS_OID              = "1.2.840.113556.1.4.2239",
    LDAP_SERVER_POLICY_HINTS_OID_W            = "1.2.840.113556.1.4.2239",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_RANGE_OPTION_OID   = "1.2.840.113556.1.4.802",
    LDAP_SERVER_RANGE_OPTION_OID_W = "1.2.840.113556.1.4.802",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_CROSSDOM_MOVE_TARGET_OID   = "1.2.840.113556.1.4.521",
    LDAP_SERVER_CROSSDOM_MOVE_TARGET_OID_W = "1.2.840.113556.1.4.521",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_NOTIFICATION_OID   = "1.2.840.113556.1.4.528",
    LDAP_SERVER_NOTIFICATION_OID_W = "1.2.840.113556.1.4.528",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_SHUTDOWN_NOTIFY_OID   = "1.2.840.113556.1.4.1907",
    LDAP_SERVER_SHUTDOWN_NOTIFY_OID_W = "1.2.840.113556.1.4.1907",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_LAZY_COMMIT_OID      = "1.2.840.113556.1.4.619",
    LDAP_SERVER_LAZY_COMMIT_OID_W    = "1.2.840.113556.1.4.619",
    // Native encoding: ansi
    LDAP_SERVER_SD_FLAGS_OID         = "1.2.840.113556.1.4.801",
    LDAP_SERVER_SD_FLAGS_OID_W       = "1.2.840.113556.1.4.801",
    // Native encoding: ansi
    LDAP_SERVER_TREE_DELETE_EX_OID   = "1.2.840.113556.1.4.2204",
    LDAP_SERVER_TREE_DELETE_EX_OID_W = "1.2.840.113556.1.4.2204",
    // Native encoding: ansi
    LDAP_SERVER_TREE_DELETE_OID      = "1.2.840.113556.1.4.805",
    LDAP_SERVER_TREE_DELETE_OID_W    = "1.2.840.113556.1.4.805",
    // Native encoding: ansi
    LDAP_SERVER_ASQ_OID              = "1.2.840.113556.1.4.1504",
    LDAP_SERVER_ASQ_OID_W            = "1.2.840.113556.1.4.1504",
    // Native encoding: ansi
    LDAP_SERVER_DIRSYNC_OID          = "1.2.840.113556.1.4.841",
    LDAP_SERVER_DIRSYNC_OID_W        = "1.2.840.113556.1.4.841",
    // Native encoding: ansi
    LDAP_SERVER_DIRSYNC_EX_OID       = "1.2.840.113556.1.4.2090",
    LDAP_SERVER_DIRSYNC_EX_OID_W     = "1.2.840.113556.1.4.2090",
    // Native encoding: ansi
    LDAP_SERVER_EXTENDED_DN_OID      = "1.2.840.113556.1.4.529",
    LDAP_SERVER_EXTENDED_DN_OID_W    = "1.2.840.113556.1.4.529",
    // Native encoding: ansi
    LDAP_SERVER_VERIFY_NAME_OID      = "1.2.840.113556.1.4.1338",
    LDAP_SERVER_VERIFY_NAME_OID_W    = "1.2.840.113556.1.4.1338",
    // Native encoding: ansi
    LDAP_SERVER_DOMAIN_SCOPE_OID     = "1.2.840.113556.1.4.1339",
    LDAP_SERVER_DOMAIN_SCOPE_OID_W   = "1.2.840.113556.1.4.1339",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_SEARCH_OPTIONS_OID   = "1.2.840.113556.1.4.1340",
    LDAP_SERVER_SEARCH_OPTIONS_OID_W = "1.2.840.113556.1.4.1340",
}

enum : uint
{
    SERVER_SEARCH_FLAG_DOMAIN_SCOPE = 0x00000001U,
    SERVER_SEARCH_FLAG_PHANTOM_ROOT = 0x00000002U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_QUOTA_CONTROL_OID   = "1.2.840.113556.1.4.1852",
    LDAP_SERVER_QUOTA_CONTROL_OID_W = "1.2.840.113556.1.4.1852",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_RANGE_RETRIEVAL_NOERR_OID   = "1.2.840.113556.1.4.1948",
    LDAP_SERVER_RANGE_RETRIEVAL_NOERR_OID_W = "1.2.840.113556.1.4.1948",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_DN_INPUT_OID       = "1.2.840.113556.1.4.2026",
    LDAP_SERVER_DN_INPUT_OID_W     = "1.2.840.113556.1.4.2026",
    // Native encoding: ansi
    LDAP_SERVER_SET_OWNER_OID      = "1.2.840.113556.1.4.2255",
    LDAP_SERVER_SET_OWNER_OID_W    = "1.2.840.113556.1.4.2255",
    // Native encoding: ansi
    LDAP_SERVER_BYPASS_QUOTA_OID   = "1.2.840.113556.1.4.2256",
    LDAP_SERVER_BYPASS_QUOTA_OID_W = "1.2.840.113556.1.4.2256",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_LINK_TTL_OID   = "1.2.840.113556.1.4.2309",
    LDAP_SERVER_LINK_TTL_OID_W = "1.2.840.113556.1.4.2309",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_BECOME_DOM_MASTER      = "becomeDomainMaster",
    LDAP_OPATT_BECOME_DOM_MASTER_W    = "becomeDomainMaster",
    // Native encoding: ansi
    LDAP_OPATT_BECOME_RID_MASTER      = "becomeRidMaster",
    LDAP_OPATT_BECOME_RID_MASTER_W    = "becomeRidMaster",
    // Native encoding: ansi
    LDAP_OPATT_BECOME_SCHEMA_MASTER   = "becomeSchemaMaster",
    LDAP_OPATT_BECOME_SCHEMA_MASTER_W = "becomeSchemaMaster",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_RECALC_HIERARCHY   = "recalcHierarchy",
    LDAP_OPATT_RECALC_HIERARCHY_W = "recalcHierarchy",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SCHEMA_UPDATE_NOW   = "schemaUpdateNow",
    LDAP_OPATT_SCHEMA_UPDATE_NOW_W = "schemaUpdateNow",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_BECOME_PDC          = "becomePdc",
    LDAP_OPATT_BECOME_PDC_W        = "becomePdc",
    // Native encoding: ansi
    LDAP_OPATT_FIXUP_INHERITANCE   = "fixupInheritance",
    LDAP_OPATT_FIXUP_INHERITANCE_W = "fixupInheritance",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_INVALIDATE_RID_POOL   = "invalidateRidPool",
    LDAP_OPATT_INVALIDATE_RID_POOL_W = "invalidateRidPool",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_ABANDON_REPL            = "abandonReplication",
    LDAP_OPATT_ABANDON_REPL_W          = "abandonReplication",
    // Native encoding: ansi
    LDAP_OPATT_DO_GARBAGE_COLLECTION   = "doGarbageCollection",
    LDAP_OPATT_DO_GARBAGE_COLLECTION_W = "doGarbageCollection",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SUBSCHEMA_SUBENTRY   = "subschemaSubentry",
    LDAP_OPATT_SUBSCHEMA_SUBENTRY_W = "subschemaSubentry",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_CURRENT_TIME      = "currentTime",
    LDAP_OPATT_CURRENT_TIME_W    = "currentTime",
    // Native encoding: ansi
    LDAP_OPATT_SERVER_NAME       = "serverName",
    LDAP_OPATT_SERVER_NAME_W     = "serverName",
    // Native encoding: ansi
    LDAP_OPATT_NAMING_CONTEXTS   = "namingContexts",
    LDAP_OPATT_NAMING_CONTEXTS_W = "namingContexts",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_DEFAULT_NAMING_CONTEXT   = "defaultNamingContext",
    LDAP_OPATT_DEFAULT_NAMING_CONTEXT_W = "defaultNamingContext",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SUPPORTED_CONTROL   = "supportedControl",
    LDAP_OPATT_SUPPORTED_CONTROL_W = "supportedControl",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_HIGHEST_COMMITTED_USN   = "highestCommitedUSN",
    LDAP_OPATT_HIGHEST_COMMITTED_USN_W = "highestCommitedUSN",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SUPPORTED_LDAP_VERSION    = "supportedLDAPVersion",
    LDAP_OPATT_SUPPORTED_LDAP_VERSION_W  = "supportedLDAPVersion",
    // Native encoding: ansi
    LDAP_OPATT_SUPPORTED_LDAP_POLICIES   = "supportedLDAPPolicies",
    LDAP_OPATT_SUPPORTED_LDAP_POLICIES_W = "supportedLDAPPolicies",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SCHEMA_NAMING_CONTEXT   = "schemaNamingContext",
    LDAP_OPATT_SCHEMA_NAMING_CONTEXT_W = "schemaNamingContext",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_CONFIG_NAMING_CONTEXT   = "configurationNamingContext",
    LDAP_OPATT_CONFIG_NAMING_CONTEXT_W = "configurationNamingContext",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_ROOT_DOMAIN_NAMING_CONTEXT   = "rootDomainNamingContext",
    LDAP_OPATT_ROOT_DOMAIN_NAMING_CONTEXT_W = "rootDomainNamingContext",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SUPPORTED_SASL_MECHANISM   = "supportedSASLMechanisms",
    LDAP_OPATT_SUPPORTED_SASL_MECHANISM_W = "supportedSASLMechanisms",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_DNS_HOST_NAME       = "dnsHostName",
    LDAP_OPATT_DNS_HOST_NAME_W     = "dnsHostName",
    // Native encoding: ansi
    LDAP_OPATT_LDAP_SERVICE_NAME   = "ldapServiceName",
    LDAP_OPATT_LDAP_SERVICE_NAME_W = "ldapServiceName",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_DS_SERVICE_NAME   = "dsServiceName",
    LDAP_OPATT_DS_SERVICE_NAME_W = "dsServiceName",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_OPATT_SUPPORTED_CAPABILITIES   = "supportedCapabilities",
    LDAP_OPATT_SUPPORTED_CAPABILITIES_W = "supportedCapabilities",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_OID                   = "1.2.840.113556.1.4.800",
    LDAP_CAP_ACTIVE_DIRECTORY_OID_W                 = "1.2.840.113556.1.4.800",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_V51_OID               = "1.2.840.113556.1.4.1670",
    LDAP_CAP_ACTIVE_DIRECTORY_V51_OID_W             = "1.2.840.113556.1.4.1670",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_LDAP_INTEG_OID        = "1.2.840.113556.1.4.1791",
    LDAP_CAP_ACTIVE_DIRECTORY_LDAP_INTEG_OID_W      = "1.2.840.113556.1.4.1791",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_ADAM_OID              = "1.2.840.113556.1.4.1851",
    LDAP_CAP_ACTIVE_DIRECTORY_ADAM_OID_W            = "1.2.840.113556.1.4.1851",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_PARTIAL_SECRETS_OID   = "1.2.840.113556.1.4.1920",
    LDAP_CAP_ACTIVE_DIRECTORY_PARTIAL_SECRETS_OID_W = "1.2.840.113556.1.4.1920",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_V60_OID               = "1.2.840.113556.1.4.1935",
    LDAP_CAP_ACTIVE_DIRECTORY_V60_OID_W             = "1.2.840.113556.1.4.1935",
    LDAP_CAP_ACTIVE_DIRECTORY_V61_OID               = "1.2.840.113556.1.4.1935",
    LDAP_CAP_ACTIVE_DIRECTORY_V61_OID_W             = "1.2.840.113556.1.4.1935",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_V61_R2_OID            = "1.2.840.113556.1.4.2080",
    LDAP_CAP_ACTIVE_DIRECTORY_V61_R2_OID_W          = "1.2.840.113556.1.4.2080",
    // Native encoding: ansi
    LDAP_CAP_ACTIVE_DIRECTORY_W8_OID                = "1.2.840.113556.1.4.2237",
    LDAP_CAP_ACTIVE_DIRECTORY_W8_OID_W              = "1.2.840.113556.1.4.2237",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_MATCHING_RULE_BIT_AND                 = "1.2.840.113556.1.4.803",
    LDAP_MATCHING_RULE_BIT_AND_W               = "1.2.840.113556.1.4.803",
    // Native encoding: ansi
    LDAP_MATCHING_RULE_BIT_OR                  = "1.2.840.113556.1.4.804",
    LDAP_MATCHING_RULE_BIT_OR_W                = "1.2.840.113556.1.4.804",
    // Native encoding: ansi
    LDAP_MATCHING_RULE_TRANSITIVE_EVALUATION   = "1.2.840.113556.1.4.1941",
    LDAP_MATCHING_RULE_TRANSITIVE_EVALUATION_W = "1.2.840.113556.1.4.1941",
    // Native encoding: ansi
    LDAP_MATCHING_RULE_DN_BINARY_COMPLEX       = "1.2.840.113556.1.4.2253",
    LDAP_MATCHING_RULE_DN_BINARY_COMPLEX_W     = "1.2.840.113556.1.4.2253",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LDAP_SERVER_FAST_BIND_OID       = "1.2.840.113556.1.4.1781",
    LDAP_SERVER_FAST_BIND_OID_W     = "1.2.840.113556.1.4.1781",
    // Native encoding: ansi
    LDAP_SERVER_WHO_AM_I_OID        = "1.3.6.1.4.1.4203.1.11.3",
    LDAP_SERVER_WHO_AM_I_OID_W      = "1.3.6.1.4.1.4203.1.11.3",
    // Native encoding: ansi
    LDAP_SERVER_BATCH_REQUEST_OID   = "1.2.840.113556.1.4.2212",
    LDAP_SERVER_BATCH_REQUEST_OID_W = "1.2.840.113556.1.4.2212",
}

enum : uint
{
    LDAP_DIRSYNC_OBJECT_SECURITY       = 0x00000001U,
    LDAP_DIRSYNC_ANCESTORS_FIRST_ORDER = 0x00000800U,
}

enum : uint
{
    LDAP_DIRSYNC_PUBLIC_DATA_ONLY   = 0x00002000U,
    LDAP_DIRSYNC_INCREMENTAL_VALUES = 0x80000000U,
    LDAP_DIRSYNC_ROPAS_DATA_ONLY    = 0x40000000U,
}

enum uint LDAP_POLICYHINT_APPLY_FULLPWDPOLICY = 0x00000001U;

// Callbacks

alias DBGPRINT = uint function(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PSTR) Format);
alias QUERYFORCONNECTION = uint function(LDAP* PrimaryConnection, LDAP* ReferralFromConnection, 
                                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR NewDN, 
                                         /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR HostName, 
                                         uint PortNumber, void* SecAuthIdentity, void* CurrentUserToken, 
                                         LDAP** ConnectionToUse);
alias NOTIFYOFNEWCONNECTION = BOOLEAN function(LDAP* PrimaryConnection, LDAP* ReferralFromConnection, 
                                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR NewDN, 
                                               /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR HostName, 
                                               LDAP* NewConnection, uint PortNumber, void* SecAuthIdentity, 
                                               void* CurrentUser, uint ErrorCodeFromBind);
alias DEREFERENCECONNECTION = uint function(LDAP* PrimaryConnection, LDAP* ConnectionToDereference);
alias QUERYCLIENTCERT = BOOLEAN function(LDAP* Connection, SecPkgContext_IssuerListInfoEx* trusted_CAs, 
                                         CERT_CONTEXT** ppCertificate);
alias VERIFYSERVERCERT = BOOLEAN function(LDAP* Connection, CERT_CONTEXT** pServerCert);

// Structs


struct PLDAPSearch
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldap
struct LDAP
{
    struct ld_sb
    {
        size_t    sb_sd;
        ubyte[41] Reserved1;
        size_t    sb_naddr;
        ubyte[24] Reserved2;
    }
    PSTR      ld_host;
    uint      ld_version;
    ubyte     ld_lberoptions;
    uint      ld_deref;
    uint      ld_timelimit;
    uint      ld_sizelimit;
    uint      ld_errno;
    PSTR      ld_matched;
    PSTR      ld_error;
    uint      ld_msgid;
    ubyte[25] Reserved3;
    uint      ld_cldaptries;
    uint      ld_cldaptimeout;
    uint      ld_refhoplimit;
    uint      ld_options;
    uint      ld_anonymousmaxvalrange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldap_timeval
struct LDAP_TIMEVAL
{
    int tv_sec;
    int tv_usec;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldap_berval
struct LDAP_BERVAL
{
    uint bv_len;
    PSTR bv_val;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapmessage
struct LDAPMessage
{
    uint         lm_msgid;
    uint         lm_msgtype;
    void*        lm_ber;
    LDAPMessage* lm_chain;
    LDAPMessage* lm_next;
    uint         lm_time;
    LDAP*        Connection;
    void*        Request;
    uint         lm_returncode;
    ushort       lm_referral;
    BOOLEAN      lm_chased;
    BOOLEAN      lm_eom;
    BOOLEAN      ConnectionReferenced;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapcontrola
struct LDAPControlA
{
    PSTR        ldctl_oid;
    LDAP_BERVAL ldctl_value;
    BOOLEAN     ldctl_iscritical;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapcontrolw
struct LDAPControlW
{
    PWSTR       ldctl_oid;
    LDAP_BERVAL ldctl_value;
    BOOLEAN     ldctl_iscritical;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapmodw
struct LDAPModW
{
    uint  mod_op;
    PWSTR mod_type;
    union mod_vals
    {
        PWSTR*        modv_strvals;
        LDAP_BERVAL** modv_bvals;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapmoda
struct LDAPModA
{
    uint mod_op;
    PSTR mod_type;
    union mod_vals
    {
        PSTR*         modv_strvals;
        LDAP_BERVAL** modv_bvals;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-berelement
struct BerElement
{
    PSTR opaque;
}

struct LDAP_VERSION_INFO
{
    uint lv_size;
    uint lv_major;
    uint lv_minor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapapiinfoa
struct LDAPAPIInfoA
{
    int    ldapai_info_version;
    int    ldapai_api_version;
    int    ldapai_protocol_version;
    byte** ldapai_extensions;
    PSTR   ldapai_vendor_name;
    int    ldapai_vendor_version;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapapiinfow
struct LDAPAPIInfoW
{
    int    ldapai_info_version;
    int    ldapai_api_version;
    int    ldapai_protocol_version;
    PWSTR* ldapai_extensions;
    PWSTR  ldapai_vendor_name;
    int    ldapai_vendor_version;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapapifeatureinfoa
struct LDAPAPIFeatureInfoA
{
    int  ldapaif_info_version;
    PSTR ldapaif_name;
    int  ldapaif_version;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapapifeatureinfow
struct LDAPAPIFeatureInfoW
{
    int   ldapaif_info_version;
    PWSTR ldapaif_name;
    int   ldapaif_version;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapsortkeyw
struct LDAPSortKeyW
{
    PWSTR   sk_attrtype;
    PWSTR   sk_matchruleoid;
    BOOLEAN sk_reverseorder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapsortkeya
struct LDAPSortKeyA
{
    PSTR    sk_attrtype;
    PSTR    sk_matchruleoid;
    BOOLEAN sk_reverseorder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldapvlvinfo
struct LDAPVLVInfo
{
    int          ldvlv_version;
    uint         ldvlv_before_count;
    uint         ldvlv_after_count;
    uint         ldvlv_offset;
    uint         ldvlv_count;
    LDAP_BERVAL* ldvlv_attrvalue;
    LDAP_BERVAL* ldvlv_context;
    void*        ldvlv_extradata;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winldap/ns-winldap-ldap_referral_callback
struct LDAP_REFERRAL_CALLBACK
{
    uint               SizeOfCallbacks;
    QUERYFORCONNECTION QueryForConnection;
    NOTIFYOFNEWCONNECTION NotifyRoutine;
    DEREFERENCECONNECTION DereferenceRoutine;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_openW(const(PWSTR) HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_openA(const(PSTR) HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_initW(const(PWSTR) HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_initA(const(PSTR) HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_sslinitW(PWSTR HostName, uint PortNumber, int secure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_sslinitA(PSTR HostName, uint PortNumber, int secure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_connect(LDAP* ld, LDAP_TIMEVAL* timeout);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_open(PSTR HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_init(PSTR HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_sslinit(PSTR HostName, uint PortNumber, int secure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* cldap_openW(PWSTR HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* cldap_openA(PSTR HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* cldap_open(PSTR HostName, uint PortNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_unbind(LDAP* ld);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_unbind_s(LDAP* ld);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_get_option(LDAP* ld, int option, void* outvalue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_get_optionW(LDAP* ld, int option, void* outvalue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_set_option(LDAP* ld, int option, const(void)* invalue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_set_optionW(LDAP* ld, int option, const(void)* invalue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bindW(LDAP* ld, PWSTR dn, PWSTR passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bindA(LDAP* ld, PSTR dn, PSTR passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bind_sW(LDAP* ld, PWSTR dn, PWSTR passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bind_sA(LDAP* ld, PSTR dn, PSTR passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bindW(LDAP* ld, PWSTR dn, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bindA(LDAP* ld, PSTR dn, 
                /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bind_sW(LDAP* ld, PWSTR dn, 
                  /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bind_sA(LDAP* ld, PSTR dn, 
                  /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_sasl_bindA(LDAP* ExternalHandle, const(PSTR) DistName, const(PSTR) AuthMechanism, 
                    const(LDAP_BERVAL)* cred, LDAPControlA** ServerCtrls, LDAPControlA** ClientCtrls, 
                    int* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_sasl_bindW(LDAP* ExternalHandle, const(PWSTR) DistName, const(PWSTR) AuthMechanism, 
                    const(LDAP_BERVAL)* cred, LDAPControlW** ServerCtrls, LDAPControlW** ClientCtrls, 
                    int* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_sasl_bind_sA(LDAP* ExternalHandle, const(PSTR) DistName, const(PSTR) AuthMechanism, 
                      const(LDAP_BERVAL)* cred, LDAPControlA** ServerCtrls, LDAPControlA** ClientCtrls, 
                      LDAP_BERVAL** ServerData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_sasl_bind_sW(LDAP* ExternalHandle, const(PWSTR) DistName, const(PWSTR) AuthMechanism, 
                      const(LDAP_BERVAL)* cred, LDAPControlW** ServerCtrls, LDAPControlW** ClientCtrls, 
                      LDAP_BERVAL** ServerData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bind(LDAP* ld, const(PSTR) dn, const(PSTR) passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_simple_bind_s(LDAP* ld, const(PSTR) dn, const(PSTR) passwd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bind(LDAP* ld, const(PSTR) dn, const(PSTR) cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_bind_s(LDAP* ld, const(PSTR) dn, const(PSTR) cred, uint method);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_searchW(LDAP* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_searchA(LDAP* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_sW(LDAP* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly, 
                    LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_sA(LDAP* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                    LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_stW(LDAP* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, uint attrsonly, 
                     LDAP_TIMEVAL* timeout, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_stA(LDAP* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                     LDAP_TIMEVAL* timeout, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_extW(LDAP* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, 
                      uint attrsonly, LDAPControlW** ServerControls, LDAPControlW** ClientControls, uint TimeLimit, 
                      uint SizeLimit, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_extA(LDAP* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                      LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint TimeLimit, uint SizeLimit, 
                      uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_ext_sW(LDAP* ld, const(PWSTR) base, uint scope_, const(PWSTR) filter, ushort** attrs, 
                        uint attrsonly, LDAPControlW** ServerControls, LDAPControlW** ClientControls, 
                        LDAP_TIMEVAL* timeout, uint SizeLimit, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_ext_sA(LDAP* ld, const(PSTR) base, uint scope_, const(PSTR) filter, byte** attrs, uint attrsonly, 
                        LDAPControlA** ServerControls, LDAPControlA** ClientControls, LDAP_TIMEVAL* timeout, 
                        uint SizeLimit, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search(LDAP* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_s(LDAP* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_st(LDAP* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                    LDAP_TIMEVAL* timeout, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_ext(LDAP* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                     LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint TimeLimit, uint SizeLimit, 
                     uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_ext_s(LDAP* ld, PSTR base, uint scope_, PSTR filter, byte** attrs, uint attrsonly, 
                       LDAPControlA** ServerControls, LDAPControlA** ClientControls, LDAP_TIMEVAL* timeout, 
                       uint SizeLimit, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_check_filterW(LDAP* ld, PWSTR SearchFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_check_filterA(LDAP* ld, PSTR SearchFilter);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modifyW(LDAP* ld, PWSTR dn, LDAPModW** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modifyA(LDAP* ld, PSTR dn, LDAPModA** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_sW(LDAP* ld, PWSTR dn, LDAPModW** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_sA(LDAP* ld, PSTR dn, LDAPModA** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_extW(LDAP* ld, const(PWSTR) dn, LDAPModW** mods, LDAPControlW** ServerControls, 
                      LDAPControlW** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_extA(LDAP* ld, const(PSTR) dn, LDAPModA** mods, LDAPControlA** ServerControls, 
                      LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_ext_sW(LDAP* ld, const(PWSTR) dn, LDAPModW** mods, LDAPControlW** ServerControls, 
                        LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_ext_sA(LDAP* ld, const(PSTR) dn, LDAPModA** mods, LDAPControlA** ServerControls, 
                        LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify(LDAP* ld, PSTR dn, LDAPModA** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_s(LDAP* ld, PSTR dn, LDAPModA** mods);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_ext(LDAP* ld, const(PSTR) dn, LDAPModA** mods, LDAPControlA** ServerControls, 
                     LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modify_ext_s(LDAP* ld, const(PSTR) dn, LDAPModA** mods, LDAPControlA** ServerControls, 
                       LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2W(LDAP* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName, 
                   int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2A(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                   int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdnW(LDAP* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdnA(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2_sW(LDAP* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName, 
                     int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2_sA(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                     int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn_sW(LDAP* ExternalHandle, const(PWSTR) DistinguishedName, const(PWSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn_sA(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                  int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn2_s(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName, 
                    int DeleteOldRdn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_modrdn_s(LDAP* ExternalHandle, const(PSTR) DistinguishedName, const(PSTR) NewDistinguishedName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_extW(LDAP* ld, const(PWSTR) dn, const(PWSTR) NewRDN, const(PWSTR) NewParent, int DeleteOldRdn, 
                      LDAPControlW** ServerControls, LDAPControlW** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_extA(LDAP* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                      LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_ext_sW(LDAP* ld, const(PWSTR) dn, const(PWSTR) NewRDN, const(PWSTR) NewParent, int DeleteOldRdn, 
                        LDAPControlW** ServerControls, LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_ext_sA(LDAP* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                        LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_ext(LDAP* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                     LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_rename_ext_s(LDAP* ld, const(PSTR) dn, const(PSTR) NewRDN, const(PSTR) NewParent, int DeleteOldRdn, 
                       LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_addW(LDAP* ld, PWSTR dn, LDAPModW** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_addA(LDAP* ld, PSTR dn, LDAPModA** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_sW(LDAP* ld, PWSTR dn, LDAPModW** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_sA(LDAP* ld, PSTR dn, LDAPModA** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_extW(LDAP* ld, const(PWSTR) dn, LDAPModW** attrs, LDAPControlW** ServerControls, 
                   LDAPControlW** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_extA(LDAP* ld, const(PSTR) dn, LDAPModA** attrs, LDAPControlA** ServerControls, 
                   LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_ext_sW(LDAP* ld, const(PWSTR) dn, LDAPModW** attrs, LDAPControlW** ServerControls, 
                     LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_ext_sA(LDAP* ld, const(PSTR) dn, LDAPModA** attrs, LDAPControlA** ServerControls, 
                     LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add(LDAP* ld, PSTR dn, LDAPModA** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_s(LDAP* ld, PSTR dn, LDAPModA** attrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_ext(LDAP* ld, const(PSTR) dn, LDAPModA** attrs, LDAPControlA** ServerControls, 
                  LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_add_ext_s(LDAP* ld, const(PSTR) dn, LDAPModA** attrs, LDAPControlA** ServerControls, 
                    LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compareW(LDAP* ld, const(PWSTR) dn, const(PWSTR) attr, PWSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compareA(LDAP* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_sW(LDAP* ld, const(PWSTR) dn, const(PWSTR) attr, PWSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_sA(LDAP* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare(LDAP* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_s(LDAP* ld, const(PSTR) dn, const(PSTR) attr, PSTR value);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_extW(LDAP* ld, const(PWSTR) dn, const(PWSTR) Attr, const(PWSTR) Value, LDAP_BERVAL* Data, 
                       LDAPControlW** ServerControls, LDAPControlW** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_extA(LDAP* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                       LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_ext_sW(LDAP* ld, const(PWSTR) dn, const(PWSTR) Attr, const(PWSTR) Value, LDAP_BERVAL* Data, 
                         LDAPControlW** ServerControls, LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_ext_sA(LDAP* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                         LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_ext(LDAP* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                      LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_compare_ext_s(LDAP* ld, const(PSTR) dn, const(PSTR) Attr, const(PSTR) Value, LDAP_BERVAL* Data, 
                        LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_deleteW(LDAP* ld, const(PWSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_deleteA(LDAP* ld, const(PSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_sW(LDAP* ld, const(PWSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_sA(LDAP* ld, const(PSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_extW(LDAP* ld, const(PWSTR) dn, LDAPControlW** ServerControls, LDAPControlW** ClientControls, 
                      uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_extA(LDAP* ld, const(PSTR) dn, LDAPControlA** ServerControls, LDAPControlA** ClientControls, 
                      uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_ext_sW(LDAP* ld, const(PWSTR) dn, LDAPControlW** ServerControls, LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_ext_sA(LDAP* ld, const(PSTR) dn, LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete(LDAP* ld, PSTR dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_s(LDAP* ld, PSTR dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_ext(LDAP* ld, const(PSTR) dn, LDAPControlA** ServerControls, LDAPControlA** ClientControls, 
                     uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_delete_ext_s(LDAP* ld, const(PSTR) dn, LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_abandon(LDAP* ld, uint msgid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_result(LDAP* ld, uint msgid, uint all, LDAP_TIMEVAL* timeout, LDAPMessage** res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_msgfree(LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_result2error(LDAP* ld, LDAPMessage* res, uint freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_resultW(LDAP* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PWSTR* MatchedDNs, 
                        PWSTR* ErrorMessage, ushort*** Referrals, LDAPControlW*** ServerControls, BOOLEAN Freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_resultA(LDAP* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PSTR* MatchedDNs, 
                        PSTR* ErrorMessage, byte*** Referrals, LDAPControlA*** ServerControls, BOOLEAN Freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_extended_resultA(LDAP* Connection, LDAPMessage* ResultMessage, PSTR* ResultOID, 
                                 LDAP_BERVAL** ResultData, BOOLEAN Freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_extended_resultW(LDAP* Connection, LDAPMessage* ResultMessage, PWSTR* ResultOID, 
                                 LDAP_BERVAL** ResultData, BOOLEAN Freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_controls_freeA(LDAPControlA** Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_control_freeA(LDAPControlA* Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_controls_freeW(LDAPControlW** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_control_freeW(LDAPControlW* Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_free_controlsW(LDAPControlW** Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_free_controlsA(LDAPControlA** Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_result(LDAP* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, PSTR* MatchedDNs, 
                       PSTR* ErrorMessage, PSTR** Referrals, LDAPControlA*** ServerControls, BOOLEAN Freeit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_controls_free(LDAPControlA** Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_control_free(LDAPControlA* Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_free_controls(LDAPControlA** Controls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR ldap_err2stringW(uint err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_err2stringA(uint err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_err2string(uint err);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ldap_perror(LDAP* ld, const(PSTR) msg);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAPMessage* ldap_first_entry(LDAP* ld, LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAPMessage* ldap_next_entry(LDAP* ld, LDAPMessage* entry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_entries(LDAP* ld, LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR ldap_first_attributeW(LDAP* ld, LDAPMessage* entry, BerElement** ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_first_attributeA(LDAP* ld, LDAPMessage* entry, BerElement** ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_first_attribute(LDAP* ld, LDAPMessage* entry, BerElement** ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR ldap_next_attributeW(LDAP* ld, LDAPMessage* entry, BerElement* ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_next_attributeA(LDAP* ld, LDAPMessage* entry, BerElement* ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_next_attribute(LDAP* ld, LDAPMessage* entry, BerElement* ptr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR* ldap_get_valuesW(LDAP* ld, LDAPMessage* entry, const(PWSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR* ldap_get_valuesA(LDAP* ld, LDAPMessage* entry, const(PSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR* ldap_get_values(LDAP* ld, LDAPMessage* entry, const(PSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_lenW(LDAP* ExternalHandle, LDAPMessage* Message, const(PWSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_lenA(LDAP* ExternalHandle, LDAPMessage* Message, const(PSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_len(LDAP* ExternalHandle, LDAPMessage* Message, const(PSTR) attr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_valuesW(PWSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_valuesA(PSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_values(PSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_values_len(LDAP_BERVAL** vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_value_freeW(PWSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_value_freeA(PSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_value_free(PSTR* vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_value_free_len(LDAP_BERVAL** vals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR ldap_get_dnW(LDAP* ld, LDAPMessage* entry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_get_dnA(LDAP* ld, LDAPMessage* entry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_get_dn(LDAP* ld, LDAPMessage* entry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR* ldap_explode_dnW(const(PWSTR) dn, uint notypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR* ldap_explode_dnA(const(PSTR) dn, uint notypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR* ldap_explode_dn(const(PSTR) dn, uint notypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PWSTR ldap_dn2ufnW(const(PWSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_dn2ufnA(const(PSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PSTR ldap_dn2ufn(const(PSTR) dn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ldap_memfreeW(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR Block);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ldap_memfreeA(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Block);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ber_bvfree(LDAP_BERVAL* bv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ldap_memfree(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Block);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_ufn2dnW(const(PWSTR) ufn, PWSTR* pDn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_ufn2dnA(const(PSTR) ufn, PSTR* pDn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_ufn2dn(const(PSTR) ufn, PSTR* pDn);

@DllImport("WLDAP32.dll")
uint ldap_startup(LDAP_VERSION_INFO* version_, HANDLE* Instance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_cleanup(HANDLE hInstance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_escape_filter_elementW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR sourceFilterElement, 
                                 uint sourceLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR destFilterElement, 
                                 uint destLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_escape_filter_elementA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR sourceFilterElement, 
                                 uint sourceLength, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR destFilterElement, 
                                 uint destLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_escape_filter_element(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/PSTR sourceFilterElement, 
                                uint sourceLength, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSTR destFilterElement, 
                                uint destLength);

@DllImport("WLDAP32.dll")
uint ldap_set_dbg_flags(uint NewFlags);

@DllImport("WLDAP32.dll")
void ldap_set_dbg_routine(DBGPRINT DebugPrintRoutine);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int LdapUTF8ToUnicode(const(PSTR) lpSrcStr, int cchSrc, PWSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int LdapUnicodeToUTF8(const(PWSTR) lpSrcStr, int cchSrc, PSTR lpDestStr, int cchDest);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_sort_controlA(LDAP* ExternalHandle, LDAPSortKeyA** SortKeys, ubyte IsCritical, 
                               LDAPControlA** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_sort_controlW(LDAP* ExternalHandle, LDAPSortKeyW** SortKeys, ubyte IsCritical, 
                               LDAPControlW** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_sort_controlA(LDAP* ExternalHandle, LDAPControlA** Control, uint* Result, PSTR* Attribute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_sort_controlW(LDAP* ExternalHandle, LDAPControlW** Control, uint* Result, PWSTR* Attribute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_sort_control(LDAP* ExternalHandle, LDAPSortKeyA** SortKeys, ubyte IsCritical, 
                              LDAPControlA** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_sort_control(LDAP* ExternalHandle, LDAPControlA** Control, uint* Result, PSTR* Attribute);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_encode_sort_controlW(LDAP* ExternalHandle, LDAPSortKeyW** SortKeys, LDAPControlW* Control, 
                               BOOLEAN Criticality);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_encode_sort_controlA(LDAP* ExternalHandle, LDAPSortKeyA** SortKeys, LDAPControlA* Control, 
                               BOOLEAN Criticality);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_page_controlW(LDAP* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                               LDAPControlW** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_page_controlA(LDAP* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                               LDAPControlA** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_page_controlW(LDAP* ExternalHandle, LDAPControlW** ServerControls, uint* TotalCount, 
                              LDAP_BERVAL** Cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_page_controlA(LDAP* ExternalHandle, LDAPControlA** ServerControls, uint* TotalCount, 
                              LDAP_BERVAL** Cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_create_page_control(LDAP* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, 
                              LDAPControlA** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_page_control(LDAP* ExternalHandle, LDAPControlA** ServerControls, uint* TotalCount, 
                             LDAP_BERVAL** Cookie);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PLDAPSearch ldap_search_init_pageW(LDAP* ExternalHandle, const(PWSTR) DistinguishedName, uint ScopeOfSearch, 
                                   const(PWSTR) SearchFilter, ushort** AttributeList, uint AttributesOnly, 
                                   LDAPControlW** ServerControls, LDAPControlW** ClientControls, uint PageTimeLimit, 
                                   uint TotalSizeLimit, LDAPSortKeyW** SortKeys);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PLDAPSearch ldap_search_init_pageA(LDAP* ExternalHandle, const(PSTR) DistinguishedName, uint ScopeOfSearch, 
                                   const(PSTR) SearchFilter, byte** AttributeList, uint AttributesOnly, 
                                   LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint PageTimeLimit, 
                                   uint TotalSizeLimit, LDAPSortKeyA** SortKeys);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
PLDAPSearch ldap_search_init_page(LDAP* ExternalHandle, const(PSTR) DistinguishedName, uint ScopeOfSearch, 
                                  const(PSTR) SearchFilter, byte** AttributeList, uint AttributesOnly, 
                                  LDAPControlA** ServerControls, LDAPControlA** ClientControls, uint PageTimeLimit, 
                                  uint TotalSizeLimit, LDAPSortKeyA** SortKeys);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_get_next_page(LDAP* ExternalHandle, PLDAPSearch SearchHandle, uint PageSize, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_get_next_page_s(LDAP* ExternalHandle, PLDAPSearch SearchHandle, LDAP_TIMEVAL* timeout, uint PageSize, 
                          uint* TotalCount, LDAPMessage** Results);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_get_paged_count(LDAP* ExternalHandle, PLDAPSearch SearchBlock, uint* TotalCount, LDAPMessage* Results);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_search_abandon_page(LDAP* ExternalHandle, PLDAPSearch SearchBlock);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_create_vlv_controlW(LDAP* ExternalHandle, LDAPVLVInfo* VlvInfo, ubyte IsCritical, LDAPControlW** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_create_vlv_controlA(LDAP* ExternalHandle, LDAPVLVInfo* VlvInfo, ubyte IsCritical, LDAPControlA** Control);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_parse_vlv_controlW(LDAP* ExternalHandle, LDAPControlW** Control, uint* TargetPos, uint* ListCount, 
                            LDAP_BERVAL** Context, int* ErrCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ldap_parse_vlv_controlA(LDAP* ExternalHandle, LDAPControlA** Control, uint* TargetPos, uint* ListCount, 
                            LDAP_BERVAL** Context, int* ErrCode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_start_tls_sW(LDAP* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, 
                       LDAPControlW** ServerControls, LDAPControlW** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_start_tls_sA(LDAP* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, 
                       LDAPControlA** ServerControls, LDAPControlA** ClientControls);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
BOOLEAN ldap_stop_tls_s(LDAP* ExternalHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAPMessage* ldap_first_reference(LDAP* ld, LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAPMessage* ldap_next_reference(LDAP* ld, LDAPMessage* entry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_count_references(LDAP* ld, LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_referenceW(LDAP* Connection, LDAPMessage* ResultMessage, PWSTR** Referrals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_referenceA(LDAP* Connection, LDAPMessage* ResultMessage, PSTR** Referrals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_parse_reference(LDAP* Connection, LDAPMessage* ResultMessage, PSTR** Referrals);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_extended_operationW(LDAP* ld, const(PWSTR) Oid, LDAP_BERVAL* Data, LDAPControlW** ServerControls, 
                              LDAPControlW** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_extended_operationA(LDAP* ld, const(PSTR) Oid, LDAP_BERVAL* Data, LDAPControlA** ServerControls, 
                              LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_extended_operation_sA(LDAP* ExternalHandle, PSTR Oid, LDAP_BERVAL* Data, LDAPControlA** ServerControls, 
                                LDAPControlA** ClientControls, PSTR* ReturnedOid, LDAP_BERVAL** ReturnedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_extended_operation_sW(LDAP* ExternalHandle, PWSTR Oid, LDAP_BERVAL* Data, LDAPControlW** ServerControls, 
                                LDAPControlW** ClientControls, PWSTR* ReturnedOid, LDAP_BERVAL** ReturnedData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_extended_operation(LDAP* ld, const(PSTR) Oid, LDAP_BERVAL* Data, LDAPControlA** ServerControls, 
                             LDAPControlA** ClientControls, uint* MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ldap_close_extended_op(LDAP* ld, uint MessageNumber);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint LdapGetLastError();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
WIN32_ERROR LdapMapErrorToWin32(/*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(LDAP_RETCODE))], [])*/uint LdapError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP* ldap_conn_from_msg(LDAP* PrimaryConn, LDAPMessage* res);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
BerElement* ber_init(LDAP_BERVAL* pBerVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ber_free(BerElement* pBerElement, int fbuf);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
void ber_bvecfree(LDAP_BERVAL** pBerVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
LDAP_BERVAL* ber_bvdup(LDAP_BERVAL* pBerVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
BerElement* ber_alloc_t(int options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ber_skip_tag(BerElement* pBerElement, uint* pLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ber_peek_tag(BerElement* pBerElement, uint* pLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ber_first_element(BerElement* pBerElement, uint* pLen, CHAR** ppOpaque);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ber_next_element(BerElement* pBerElement, uint* pLen, PSTR opaque);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ber_flatten(BerElement* pBerElement, LDAP_BERVAL** pBerVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
int ber_printf(BerElement* pBerElement, PSTR fmt);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("WLDAP32.dll")
uint ber_scanf(BerElement* pBerElement, PSTR fmt);


