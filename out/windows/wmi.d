module windows.wmi;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL;

extern(Windows):


// Enums


enum : int
{
    WBEMPATH_INFO_ANON_LOCAL_MACHINE    = 0x00000001,
    WBEMPATH_INFO_HAS_MACHINE_NAME      = 0x00000002,
    WBEMPATH_INFO_IS_CLASS_REF          = 0x00000004,
    WBEMPATH_INFO_IS_INST_REF           = 0x00000008,
    WBEMPATH_INFO_HAS_SUBSCOPES         = 0x00000010,
    WBEMPATH_INFO_IS_COMPOUND           = 0x00000020,
    WBEMPATH_INFO_HAS_V2_REF_PATHS      = 0x00000040,
    WBEMPATH_INFO_HAS_IMPLIED_KEY       = 0x00000080,
    WBEMPATH_INFO_CONTAINS_SINGLETON    = 0x00000100,
    WBEMPATH_INFO_V1_COMPLIANT          = 0x00000200,
    WBEMPATH_INFO_V2_COMPLIANT          = 0x00000400,
    WBEMPATH_INFO_CIM_COMPLIANT         = 0x00000800,
    WBEMPATH_INFO_IS_SINGLETON          = 0x00001000,
    WBEMPATH_INFO_IS_PARENT             = 0x00002000,
    WBEMPATH_INFO_SERVER_NAMESPACE_ONLY = 0x00004000,
    WBEMPATH_INFO_NATIVE_PATH           = 0x00008000,
    WBEMPATH_INFO_WMI_PATH              = 0x00010000,
    WBEMPATH_INFO_PATH_HAD_SERVER       = 0x00020000,
}
alias tag_WBEM_PATH_STATUS_FLAG = int;

enum : int
{
    WBEMPATH_CREATE_ACCEPT_RELATIVE   = 0x00000001,
    WBEMPATH_CREATE_ACCEPT_ABSOLUTE   = 0x00000002,
    WBEMPATH_CREATE_ACCEPT_ALL        = 0x00000004,
    WBEMPATH_TREAT_SINGLE_IDENT_AS_NS = 0x00000008,
}
alias tag_WBEM_PATH_CREATE_FLAG = int;

enum : int
{
    WBEMPATH_COMPRESSED                    = 0x00000001,
    WBEMPATH_GET_RELATIVE_ONLY             = 0x00000002,
    WBEMPATH_GET_SERVER_TOO                = 0x00000004,
    WBEMPATH_GET_SERVER_AND_NAMESPACE_ONLY = 0x00000008,
    WBEMPATH_GET_NAMESPACE_ONLY            = 0x00000010,
    WBEMPATH_GET_ORIGINAL                  = 0x00000020,
}
alias tag_WBEM_GET_TEXT_FLAGS = int;

enum : int
{
    WBEMPATH_TEXT       = 0x00000001,
    WBEMPATH_QUOTEDTEXT = 0x00000002,
}
alias tag_WBEM_GET_KEY_FLAGS = int;

enum : int
{
    WMIQ_ANALYSIS_RPN_SEQUENCE         = 0x00000001,
    WMIQ_ANALYSIS_ASSOC_QUERY          = 0x00000002,
    WMIQ_ANALYSIS_PROP_ANALYSIS_MATRIX = 0x00000003,
    WMIQ_ANALYSIS_QUERY_TEXT           = 0x00000004,
    WMIQ_ANALYSIS_RESERVED             = 0x08000000,
}
alias WMIQ_ANALYSIS_TYPE = int;

enum : int
{
    WMIQ_RPN_TOKEN_EXPRESSION    = 0x00000001,
    WMIQ_RPN_TOKEN_AND           = 0x00000002,
    WMIQ_RPN_TOKEN_OR            = 0x00000003,
    WMIQ_RPN_TOKEN_NOT           = 0x00000004,
    WMIQ_RPN_OP_UNDEFINED        = 0x00000000,
    WMIQ_RPN_OP_EQ               = 0x00000001,
    WMIQ_RPN_OP_NE               = 0x00000002,
    WMIQ_RPN_OP_GE               = 0x00000003,
    WMIQ_RPN_OP_LE               = 0x00000004,
    WMIQ_RPN_OP_LT               = 0x00000005,
    WMIQ_RPN_OP_GT               = 0x00000006,
    WMIQ_RPN_OP_LIKE             = 0x00000007,
    WMIQ_RPN_OP_ISA              = 0x00000008,
    WMIQ_RPN_OP_ISNOTA           = 0x00000009,
    WMIQ_RPN_OP_ISNULL           = 0x0000000a,
    WMIQ_RPN_OP_ISNOTNULL        = 0x0000000b,
    WMIQ_RPN_LEFT_PROPERTY_NAME  = 0x00000001,
    WMIQ_RPN_RIGHT_PROPERTY_NAME = 0x00000002,
    WMIQ_RPN_CONST2              = 0x00000004,
    WMIQ_RPN_CONST               = 0x00000008,
    WMIQ_RPN_RELOP               = 0x00000010,
    WMIQ_RPN_LEFT_FUNCTION       = 0x00000020,
    WMIQ_RPN_RIGHT_FUNCTION      = 0x00000040,
    WMIQ_RPN_GET_TOKEN_TYPE      = 0x00000001,
    WMIQ_RPN_GET_EXPR_SHAPE      = 0x00000002,
    WMIQ_RPN_GET_LEFT_FUNCTION   = 0x00000003,
    WMIQ_RPN_GET_RIGHT_FUNCTION  = 0x00000004,
    WMIQ_RPN_GET_RELOP           = 0x00000005,
    WMIQ_RPN_NEXT_TOKEN          = 0x00000001,
    WMIQ_RPN_FROM_UNARY          = 0x00000001,
    WMIQ_RPN_FROM_PATH           = 0x00000002,
    WMIQ_RPN_FROM_CLASS_LIST     = 0x00000004,
    WMIQ_RPN_FROM_MULTIPLE       = 0x00000008,
}
alias WMIQ_RPN_TOKEN_FLAGS = int;

enum : int
{
    WMIQ_ASSOCQ_ASSOCIATORS            = 0x00000001,
    WMIQ_ASSOCQ_REFERENCES             = 0x00000002,
    WMIQ_ASSOCQ_RESULTCLASS            = 0x00000004,
    WMIQ_ASSOCQ_ASSOCCLASS             = 0x00000008,
    WMIQ_ASSOCQ_ROLE                   = 0x00000010,
    WMIQ_ASSOCQ_RESULTROLE             = 0x00000020,
    WMIQ_ASSOCQ_REQUIREDQUALIFIER      = 0x00000040,
    WMIQ_ASSOCQ_REQUIREDASSOCQUALIFIER = 0x00000080,
    WMIQ_ASSOCQ_CLASSDEFSONLY          = 0x00000100,
    WMIQ_ASSOCQ_KEYSONLY               = 0x00000200,
    WMIQ_ASSOCQ_SCHEMAONLY             = 0x00000400,
    WMIQ_ASSOCQ_CLASSREFSONLY          = 0x00000800,
}
alias WMIQ_ASSOCQ_FLAGS = int;

enum : int
{
    WMIQ_LF1_BASIC_SELECT                = 0x00000001,
    WMIQ_LF2_CLASS_NAME_IN_QUERY         = 0x00000002,
    WMIQ_LF3_STRING_CASE_FUNCTIONS       = 0x00000003,
    WMIQ_LF4_PROP_TO_PROP_TESTS          = 0x00000004,
    WMIQ_LF5_COUNT_STAR                  = 0x00000005,
    WMIQ_LF6_ORDER_BY                    = 0x00000006,
    WMIQ_LF7_DISTINCT                    = 0x00000007,
    WMIQ_LF8_ISA                         = 0x00000008,
    WMIQ_LF9_THIS                        = 0x00000009,
    WMIQ_LF10_COMPEX_SUBEXPRESSIONS      = 0x0000000a,
    WMIQ_LF11_ALIASING                   = 0x0000000b,
    WMIQ_LF12_GROUP_BY_HAVING            = 0x0000000c,
    WMIQ_LF13_WMI_WITHIN                 = 0x0000000d,
    WMIQ_LF14_SQL_WRITE_OPERATIONS       = 0x0000000e,
    WMIQ_LF15_GO                         = 0x0000000f,
    WMIQ_LF16_SINGLE_LEVEL_TRANSACTIONS  = 0x00000010,
    WMIQ_LF17_QUALIFIED_NAMES            = 0x00000011,
    WMIQ_LF18_ASSOCIATONS                = 0x00000012,
    WMIQ_LF19_SYSTEM_PROPERTIES          = 0x00000013,
    WMIQ_LF20_EXTENDED_SYSTEM_PROPERTIES = 0x00000014,
    WMIQ_LF21_SQL89_JOINS                = 0x00000015,
    WMIQ_LF22_SQL92_JOINS                = 0x00000016,
    WMIQ_LF23_SUBSELECTS                 = 0x00000017,
    WMIQ_LF24_UMI_EXTENSIONS             = 0x00000018,
    WMIQ_LF25_DATEPART                   = 0x00000019,
    WMIQ_LF26_LIKE                       = 0x0000001a,
    WMIQ_LF27_CIM_TEMPORAL_CONSTRUCTS    = 0x0000001b,
    WMIQ_LF28_STANDARD_AGGREGATES        = 0x0000001c,
    WMIQ_LF29_MULTI_LEVEL_ORDER_BY       = 0x0000001d,
    WMIQ_LF30_WMI_PRAGMAS                = 0x0000001e,
    WMIQ_LF31_QUALIFIER_TESTS            = 0x0000001f,
    WMIQ_LF32_SP_EXECUTE                 = 0x00000020,
    WMIQ_LF33_ARRAY_ACCESS               = 0x00000021,
    WMIQ_LF34_UNION                      = 0x00000022,
    WMIQ_LF35_COMPLEX_SELECT_TARGET      = 0x00000023,
    WMIQ_LF36_REFERENCE_TESTS            = 0x00000024,
    WMIQ_LF37_SELECT_INTO                = 0x00000025,
    WMIQ_LF38_BASIC_DATETIME_TESTS       = 0x00000026,
    WMIQ_LF39_COUNT_COLUMN               = 0x00000027,
    WMIQ_LF40_BETWEEN                    = 0x00000028,
    WMIQ_LF_LAST                         = 0x00000028,
}
alias tag_WMIQ_LANGUAGE_FEATURES = int;

enum : int
{
    WMIQ_RPNF_WHERE_CLAUSE_PRESENT = 0x00000001,
    WMIQ_RPNF_QUERY_IS_CONJUNCTIVE = 0x00000002,
    WMIQ_RPNF_QUERY_IS_DISJUNCTIVE = 0x00000004,
    WMIQ_RPNF_PROJECTION           = 0x00000008,
    WMIQ_RPNF_FEATURE_SELECT_STAR  = 0x00000010,
    WMIQ_RPNF_EQUALITY_TESTS_ONLY  = 0x00000020,
    WMIQ_RPNF_COUNT_STAR           = 0x00000040,
    WMIQ_RPNF_QUALIFIED_NAMES_USED = 0x00000080,
    WMIQ_RPNF_SYSPROP_CLASS_USED   = 0x00000100,
    WMIQ_RPNF_PROP_TO_PROP_TESTS   = 0x00000200,
    WMIQ_RPNF_ORDER_BY             = 0x00000400,
    WMIQ_RPNF_ISA_USED             = 0x00000800,
    WMIQ_RPNF_GROUP_BY_HAVING      = 0x00001000,
    WMIQ_RPNF_ARRAY_ACCESS_USED    = 0x00002000,
}
alias tag_WMIQ_RPNQ_FEATURE = int;

enum : int
{
    WBEM_GENUS_CLASS    = 0x00000001,
    WBEM_GENUS_INSTANCE = 0x00000002,
}
alias WBEM_GENUS_TYPE = int;

enum : int
{
    WBEM_FLAG_CREATE_OR_UPDATE  = 0x00000000,
    WBEM_FLAG_UPDATE_ONLY       = 0x00000001,
    WBEM_FLAG_CREATE_ONLY       = 0x00000002,
    WBEM_FLAG_UPDATE_COMPATIBLE = 0x00000000,
    WBEM_FLAG_UPDATE_SAFE_MODE  = 0x00000020,
    WBEM_FLAG_UPDATE_FORCE_MODE = 0x00000040,
    WBEM_MASK_UPDATE_MODE       = 0x00000060,
    WBEM_FLAG_ADVISORY          = 0x00010000,
}
alias WBEM_CHANGE_FLAG_TYPE = int;

enum : int
{
    WBEM_FLAG_RETURN_IMMEDIATELY     = 0x00000010,
    WBEM_FLAG_RETURN_WBEM_COMPLETE   = 0x00000000,
    WBEM_FLAG_BIDIRECTIONAL          = 0x00000000,
    WBEM_FLAG_FORWARD_ONLY           = 0x00000020,
    WBEM_FLAG_NO_ERROR_OBJECT        = 0x00000040,
    WBEM_FLAG_RETURN_ERROR_OBJECT    = 0x00000000,
    WBEM_FLAG_SEND_STATUS            = 0x00000080,
    WBEM_FLAG_DONT_SEND_STATUS       = 0x00000000,
    WBEM_FLAG_ENSURE_LOCATABLE       = 0x00000100,
    WBEM_FLAG_DIRECT_READ            = 0x00000200,
    WBEM_FLAG_SEND_ONLY_SELECTED     = 0x00000000,
    WBEM_RETURN_WHEN_COMPLETE        = 0x00000000,
    WBEM_RETURN_IMMEDIATELY          = 0x00000010,
    WBEM_MASK_RESERVED_FLAGS         = 0x0001f000,
    WBEM_FLAG_USE_AMENDED_QUALIFIERS = 0x00020000,
    WBEM_FLAG_STRONG_VALIDATION      = 0x00100000,
}
alias WBEM_GENERIC_FLAG_TYPE = int;

enum : int
{
    WBEM_STATUS_COMPLETE                       = 0x00000000,
    WBEM_STATUS_REQUIREMENTS                   = 0x00000001,
    WBEM_STATUS_PROGRESS                       = 0x00000002,
    WBEM_STATUS_LOGGING_INFORMATION            = 0x00000100,
    WBEM_STATUS_LOGGING_INFORMATION_PROVIDER   = 0x00000200,
    WBEM_STATUS_LOGGING_INFORMATION_HOST       = 0x00000400,
    WBEM_STATUS_LOGGING_INFORMATION_REPOSITORY = 0x00000800,
    WBEM_STATUS_LOGGING_INFORMATION_ESS        = 0x00001000,
}
alias WBEM_STATUS_TYPE = int;

enum : int
{
    WBEM_NO_WAIT  = 0x00000000,
    WBEM_INFINITE = 0xffffffff,
}
alias WBEM_TIMEOUT_TYPE = int;

enum : int
{
    WBEM_FLAG_ALWAYS                    = 0x00000000,
    WBEM_FLAG_ONLY_IF_TRUE              = 0x00000001,
    WBEM_FLAG_ONLY_IF_FALSE             = 0x00000002,
    WBEM_FLAG_ONLY_IF_IDENTICAL         = 0x00000003,
    WBEM_MASK_PRIMARY_CONDITION         = 0x00000003,
    WBEM_FLAG_KEYS_ONLY                 = 0x00000004,
    WBEM_FLAG_REFS_ONLY                 = 0x00000008,
    WBEM_FLAG_LOCAL_ONLY                = 0x00000010,
    WBEM_FLAG_PROPAGATED_ONLY           = 0x00000020,
    WBEM_FLAG_SYSTEM_ONLY               = 0x00000030,
    WBEM_FLAG_NONSYSTEM_ONLY            = 0x00000040,
    WBEM_MASK_CONDITION_ORIGIN          = 0x00000070,
    WBEM_FLAG_CLASS_OVERRIDES_ONLY      = 0x00000100,
    WBEM_FLAG_CLASS_LOCAL_AND_OVERRIDES = 0x00000200,
    WBEM_MASK_CLASS_CONDITION           = 0x00000300,
}
alias WBEM_CONDITION_FLAG_TYPE = int;

enum : int
{
    WBEM_FLAVOR_DONT_PROPAGATE                  = 0x00000000,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_INSTANCE      = 0x00000001,
    WBEM_FLAVOR_FLAG_PROPAGATE_TO_DERIVED_CLASS = 0x00000002,
    WBEM_FLAVOR_MASK_PROPAGATION                = 0x0000000f,
    WBEM_FLAVOR_OVERRIDABLE                     = 0x00000000,
    WBEM_FLAVOR_NOT_OVERRIDABLE                 = 0x00000010,
    WBEM_FLAVOR_MASK_PERMISSIONS                = 0x00000010,
    WBEM_FLAVOR_ORIGIN_LOCAL                    = 0x00000000,
    WBEM_FLAVOR_ORIGIN_PROPAGATED               = 0x00000020,
    WBEM_FLAVOR_ORIGIN_SYSTEM                   = 0x00000040,
    WBEM_FLAVOR_MASK_ORIGIN                     = 0x00000060,
    WBEM_FLAVOR_NOT_AMENDED                     = 0x00000000,
    WBEM_FLAVOR_AMENDED                         = 0x00000080,
    WBEM_FLAVOR_MASK_AMENDED                    = 0x00000080,
}
alias WBEM_FLAVOR_TYPE = int;

enum : int
{
    WBEM_FLAG_DEEP      = 0x00000000,
    WBEM_FLAG_SHALLOW   = 0x00000001,
    WBEM_FLAG_PROTOTYPE = 0x00000002,
}
alias WBEM_QUERY_FLAG_TYPE = int;

enum : int
{
    WBEM_ENABLE            = 0x00000001,
    WBEM_METHOD_EXECUTE    = 0x00000002,
    WBEM_FULL_WRITE_REP    = 0x00000004,
    WBEM_PARTIAL_WRITE_REP = 0x00000008,
    WBEM_WRITE_PROVIDER    = 0x00000010,
    WBEM_REMOTE_ACCESS     = 0x00000020,
    WBEM_RIGHT_SUBSCRIBE   = 0x00000040,
    WBEM_RIGHT_PUBLISH     = 0x00000080,
}
alias WBEM_SECURITY_FLAGS = int;

enum : int
{
    WBEM_FLAG_EXCLUDE_OBJECT_QUALIFIERS   = 0x00000010,
    WBEM_FLAG_EXCLUDE_PROPERTY_QUALIFIERS = 0x00000020,
}
alias tag_WBEM_LIMITATION_FLAG_TYPE = int;

enum : int
{
    WBEM_FLAG_NO_FLAVORS = 0x00000001,
}
alias WBEM_TEXT_FLAG_TYPE = int;

enum : int
{
    WBEM_COMPARISON_INCLUDE_ALL     = 0x00000000,
    WBEM_FLAG_IGNORE_QUALIFIERS     = 0x00000001,
    WBEM_FLAG_IGNORE_OBJECT_SOURCE  = 0x00000002,
    WBEM_FLAG_IGNORE_DEFAULT_VALUES = 0x00000004,
    WBEM_FLAG_IGNORE_CLASS          = 0x00000008,
    WBEM_FLAG_IGNORE_CASE           = 0x00000010,
    WBEM_FLAG_IGNORE_FLAVOR         = 0x00000020,
}
alias WBEM_COMPARISON_FLAG = int;

enum : int
{
    WBEM_FLAG_ALLOW_READ = 0x00000001,
}
alias tag_WBEM_LOCKING = int;

enum : int
{
    CIM_ILLEGAL    = 0x00000fff,
    CIM_EMPTY      = 0x00000000,
    CIM_SINT8      = 0x00000010,
    CIM_UINT8      = 0x00000011,
    CIM_SINT16     = 0x00000002,
    CIM_UINT16     = 0x00000012,
    CIM_SINT32     = 0x00000003,
    CIM_UINT32     = 0x00000013,
    CIM_SINT64     = 0x00000014,
    CIM_UINT64     = 0x00000015,
    CIM_REAL32     = 0x00000004,
    CIM_REAL64     = 0x00000005,
    CIM_BOOLEAN    = 0x0000000b,
    CIM_STRING     = 0x00000008,
    CIM_DATETIME   = 0x00000065,
    CIM_REFERENCE  = 0x00000066,
    CIM_CHAR16     = 0x00000067,
    CIM_OBJECT     = 0x0000000d,
    CIM_FLAG_ARRAY = 0x00002000,
}
alias CIMTYPE_ENUMERATION = int;

enum : int
{
    WBEM_FLAG_BACKUP_RESTORE_DEFAULT        = 0x00000000,
    WBEM_FLAG_BACKUP_RESTORE_FORCE_SHUTDOWN = 0x00000001,
}
alias WBEM_BACKUP_RESTORE_FLAGS = int;

enum : int
{
    WBEM_FLAG_REFRESH_AUTO_RECONNECT    = 0x00000000,
    WBEM_FLAG_REFRESH_NO_AUTO_RECONNECT = 0x00000001,
}
alias WBEM_REFRESHER_FLAGS = int;

enum : int
{
    WBEM_SHUTDOWN_UNLOAD_COMPONENT = 0x00000001,
    WBEM_SHUTDOWN_WMI              = 0x00000002,
    WBEM_SHUTDOWN_OS               = 0x00000003,
}
alias tag_WBEM_SHUTDOWN_FLAGS = int;

enum : int
{
    WBEMSTATUS_FORMAT_NEWLINE    = 0x00000000,
    WBEMSTATUS_FORMAT_NO_NEWLINE = 0x00000001,
}
alias tag_WBEMSTATUS_FORMAT = int;

enum : int
{
    WBEM_MAX_IDENTIFIER      = 0x00001000,
    WBEM_MAX_QUERY           = 0x00004000,
    WBEM_MAX_PATH            = 0x00002000,
    WBEM_MAX_OBJECT_NESTING  = 0x00000040,
    WBEM_MAX_USER_PROPERTIES = 0x00000400,
}
alias WBEM_LIMITS = int;

enum : int
{
    WBEM_NO_ERROR                             = 0x00000000,
    WBEM_S_NO_ERROR                           = 0x00000000,
    WBEM_S_SAME                               = 0x00000000,
    WBEM_S_FALSE                              = 0x00000001,
    WBEM_S_ALREADY_EXISTS                     = 0x00040001,
    WBEM_S_RESET_TO_DEFAULT                   = 0x00040002,
    WBEM_S_DIFFERENT                          = 0x00040003,
    WBEM_S_TIMEDOUT                           = 0x00040004,
    WBEM_S_NO_MORE_DATA                       = 0x00040005,
    WBEM_S_OPERATION_CANCELLED                = 0x00040006,
    WBEM_S_PENDING                            = 0x00040007,
    WBEM_S_DUPLICATE_OBJECTS                  = 0x00040008,
    WBEM_S_ACCESS_DENIED                      = 0x00040009,
    WBEM_S_PARTIAL_RESULTS                    = 0x00040010,
    WBEM_S_SOURCE_NOT_AVAILABLE               = 0x00040017,
    WBEM_E_FAILED                             = 0x80041001,
    WBEM_E_NOT_FOUND                          = 0x80041002,
    WBEM_E_ACCESS_DENIED                      = 0x80041003,
    WBEM_E_PROVIDER_FAILURE                   = 0x80041004,
    WBEM_E_TYPE_MISMATCH                      = 0x80041005,
    WBEM_E_OUT_OF_MEMORY                      = 0x80041006,
    WBEM_E_INVALID_CONTEXT                    = 0x80041007,
    WBEM_E_INVALID_PARAMETER                  = 0x80041008,
    WBEM_E_NOT_AVAILABLE                      = 0x80041009,
    WBEM_E_CRITICAL_ERROR                     = 0x8004100a,
    WBEM_E_INVALID_STREAM                     = 0x8004100b,
    WBEM_E_NOT_SUPPORTED                      = 0x8004100c,
    WBEM_E_INVALID_SUPERCLASS                 = 0x8004100d,
    WBEM_E_INVALID_NAMESPACE                  = 0x8004100e,
    WBEM_E_INVALID_OBJECT                     = 0x8004100f,
    WBEM_E_INVALID_CLASS                      = 0x80041010,
    WBEM_E_PROVIDER_NOT_FOUND                 = 0x80041011,
    WBEM_E_INVALID_PROVIDER_REGISTRATION      = 0x80041012,
    WBEM_E_PROVIDER_LOAD_FAILURE              = 0x80041013,
    WBEM_E_INITIALIZATION_FAILURE             = 0x80041014,
    WBEM_E_TRANSPORT_FAILURE                  = 0x80041015,
    WBEM_E_INVALID_OPERATION                  = 0x80041016,
    WBEM_E_INVALID_QUERY                      = 0x80041017,
    WBEM_E_INVALID_QUERY_TYPE                 = 0x80041018,
    WBEM_E_ALREADY_EXISTS                     = 0x80041019,
    WBEM_E_OVERRIDE_NOT_ALLOWED               = 0x8004101a,
    WBEM_E_PROPAGATED_QUALIFIER               = 0x8004101b,
    WBEM_E_PROPAGATED_PROPERTY                = 0x8004101c,
    WBEM_E_UNEXPECTED                         = 0x8004101d,
    WBEM_E_ILLEGAL_OPERATION                  = 0x8004101e,
    WBEM_E_CANNOT_BE_KEY                      = 0x8004101f,
    WBEM_E_INCOMPLETE_CLASS                   = 0x80041020,
    WBEM_E_INVALID_SYNTAX                     = 0x80041021,
    WBEM_E_NONDECORATED_OBJECT                = 0x80041022,
    WBEM_E_READ_ONLY                          = 0x80041023,
    WBEM_E_PROVIDER_NOT_CAPABLE               = 0x80041024,
    WBEM_E_CLASS_HAS_CHILDREN                 = 0x80041025,
    WBEM_E_CLASS_HAS_INSTANCES                = 0x80041026,
    WBEM_E_QUERY_NOT_IMPLEMENTED              = 0x80041027,
    WBEM_E_ILLEGAL_NULL                       = 0x80041028,
    WBEM_E_INVALID_QUALIFIER_TYPE             = 0x80041029,
    WBEM_E_INVALID_PROPERTY_TYPE              = 0x8004102a,
    WBEM_E_VALUE_OUT_OF_RANGE                 = 0x8004102b,
    WBEM_E_CANNOT_BE_SINGLETON                = 0x8004102c,
    WBEM_E_INVALID_CIM_TYPE                   = 0x8004102d,
    WBEM_E_INVALID_METHOD                     = 0x8004102e,
    WBEM_E_INVALID_METHOD_PARAMETERS          = 0x8004102f,
    WBEM_E_SYSTEM_PROPERTY                    = 0x80041030,
    WBEM_E_INVALID_PROPERTY                   = 0x80041031,
    WBEM_E_CALL_CANCELLED                     = 0x80041032,
    WBEM_E_SHUTTING_DOWN                      = 0x80041033,
    WBEM_E_PROPAGATED_METHOD                  = 0x80041034,
    WBEM_E_UNSUPPORTED_PARAMETER              = 0x80041035,
    WBEM_E_MISSING_PARAMETER_ID               = 0x80041036,
    WBEM_E_INVALID_PARAMETER_ID               = 0x80041037,
    WBEM_E_NONCONSECUTIVE_PARAMETER_IDS       = 0x80041038,
    WBEM_E_PARAMETER_ID_ON_RETVAL             = 0x80041039,
    WBEM_E_INVALID_OBJECT_PATH                = 0x8004103a,
    WBEM_E_OUT_OF_DISK_SPACE                  = 0x8004103b,
    WBEM_E_BUFFER_TOO_SMALL                   = 0x8004103c,
    WBEM_E_UNSUPPORTED_PUT_EXTENSION          = 0x8004103d,
    WBEM_E_UNKNOWN_OBJECT_TYPE                = 0x8004103e,
    WBEM_E_UNKNOWN_PACKET_TYPE                = 0x8004103f,
    WBEM_E_MARSHAL_VERSION_MISMATCH           = 0x80041040,
    WBEM_E_MARSHAL_INVALID_SIGNATURE          = 0x80041041,
    WBEM_E_INVALID_QUALIFIER                  = 0x80041042,
    WBEM_E_INVALID_DUPLICATE_PARAMETER        = 0x80041043,
    WBEM_E_TOO_MUCH_DATA                      = 0x80041044,
    WBEM_E_SERVER_TOO_BUSY                    = 0x80041045,
    WBEM_E_INVALID_FLAVOR                     = 0x80041046,
    WBEM_E_CIRCULAR_REFERENCE                 = 0x80041047,
    WBEM_E_UNSUPPORTED_CLASS_UPDATE           = 0x80041048,
    WBEM_E_CANNOT_CHANGE_KEY_INHERITANCE      = 0x80041049,
    WBEM_E_CANNOT_CHANGE_INDEX_INHERITANCE    = 0x80041050,
    WBEM_E_TOO_MANY_PROPERTIES                = 0x80041051,
    WBEM_E_UPDATE_TYPE_MISMATCH               = 0x80041052,
    WBEM_E_UPDATE_OVERRIDE_NOT_ALLOWED        = 0x80041053,
    WBEM_E_UPDATE_PROPAGATED_METHOD           = 0x80041054,
    WBEM_E_METHOD_NOT_IMPLEMENTED             = 0x80041055,
    WBEM_E_METHOD_DISABLED                    = 0x80041056,
    WBEM_E_REFRESHER_BUSY                     = 0x80041057,
    WBEM_E_UNPARSABLE_QUERY                   = 0x80041058,
    WBEM_E_NOT_EVENT_CLASS                    = 0x80041059,
    WBEM_E_MISSING_GROUP_WITHIN               = 0x8004105a,
    WBEM_E_MISSING_AGGREGATION_LIST           = 0x8004105b,
    WBEM_E_PROPERTY_NOT_AN_OBJECT             = 0x8004105c,
    WBEM_E_AGGREGATING_BY_OBJECT              = 0x8004105d,
    WBEM_E_UNINTERPRETABLE_PROVIDER_QUERY     = 0x8004105f,
    WBEM_E_BACKUP_RESTORE_WINMGMT_RUNNING     = 0x80041060,
    WBEM_E_QUEUE_OVERFLOW                     = 0x80041061,
    WBEM_E_PRIVILEGE_NOT_HELD                 = 0x80041062,
    WBEM_E_INVALID_OPERATOR                   = 0x80041063,
    WBEM_E_LOCAL_CREDENTIALS                  = 0x80041064,
    WBEM_E_CANNOT_BE_ABSTRACT                 = 0x80041065,
    WBEM_E_AMENDED_OBJECT                     = 0x80041066,
    WBEM_E_CLIENT_TOO_SLOW                    = 0x80041067,
    WBEM_E_NULL_SECURITY_DESCRIPTOR           = 0x80041068,
    WBEM_E_TIMED_OUT                          = 0x80041069,
    WBEM_E_INVALID_ASSOCIATION                = 0x8004106a,
    WBEM_E_AMBIGUOUS_OPERATION                = 0x8004106b,
    WBEM_E_QUOTA_VIOLATION                    = 0x8004106c,
    WBEM_E_RESERVED_001                       = 0x8004106d,
    WBEM_E_RESERVED_002                       = 0x8004106e,
    WBEM_E_UNSUPPORTED_LOCALE                 = 0x8004106f,
    WBEM_E_HANDLE_OUT_OF_DATE                 = 0x80041070,
    WBEM_E_CONNECTION_FAILED                  = 0x80041071,
    WBEM_E_INVALID_HANDLE_REQUEST             = 0x80041072,
    WBEM_E_PROPERTY_NAME_TOO_WIDE             = 0x80041073,
    WBEM_E_CLASS_NAME_TOO_WIDE                = 0x80041074,
    WBEM_E_METHOD_NAME_TOO_WIDE               = 0x80041075,
    WBEM_E_QUALIFIER_NAME_TOO_WIDE            = 0x80041076,
    WBEM_E_RERUN_COMMAND                      = 0x80041077,
    WBEM_E_DATABASE_VER_MISMATCH              = 0x80041078,
    WBEM_E_VETO_DELETE                        = 0x80041079,
    WBEM_E_VETO_PUT                           = 0x8004107a,
    WBEM_E_INVALID_LOCALE                     = 0x80041080,
    WBEM_E_PROVIDER_SUSPENDED                 = 0x80041081,
    WBEM_E_SYNCHRONIZATION_REQUIRED           = 0x80041082,
    WBEM_E_NO_SCHEMA                          = 0x80041083,
    WBEM_E_PROVIDER_ALREADY_REGISTERED        = 0x80041084,
    WBEM_E_PROVIDER_NOT_REGISTERED            = 0x80041085,
    WBEM_E_FATAL_TRANSPORT_ERROR              = 0x80041086,
    WBEM_E_ENCRYPTED_CONNECTION_REQUIRED      = 0x80041087,
    WBEM_E_PROVIDER_TIMED_OUT                 = 0x80041088,
    WBEM_E_NO_KEY                             = 0x80041089,
    WBEM_E_PROVIDER_DISABLED                  = 0x8004108a,
    WBEMESS_E_REGISTRATION_TOO_BROAD          = 0x80042001,
    WBEMESS_E_REGISTRATION_TOO_PRECISE        = 0x80042002,
    WBEMESS_E_AUTHZ_NOT_PRIVILEGED            = 0x80042003,
    WBEMMOF_E_EXPECTED_QUALIFIER_NAME         = 0x80044001,
    WBEMMOF_E_EXPECTED_SEMI                   = 0x80044002,
    WBEMMOF_E_EXPECTED_OPEN_BRACE             = 0x80044003,
    WBEMMOF_E_EXPECTED_CLOSE_BRACE            = 0x80044004,
    WBEMMOF_E_EXPECTED_CLOSE_BRACKET          = 0x80044005,
    WBEMMOF_E_EXPECTED_CLOSE_PAREN            = 0x80044006,
    WBEMMOF_E_ILLEGAL_CONSTANT_VALUE          = 0x80044007,
    WBEMMOF_E_EXPECTED_TYPE_IDENTIFIER        = 0x80044008,
    WBEMMOF_E_EXPECTED_OPEN_PAREN             = 0x80044009,
    WBEMMOF_E_UNRECOGNIZED_TOKEN              = 0x8004400a,
    WBEMMOF_E_UNRECOGNIZED_TYPE               = 0x8004400b,
    WBEMMOF_E_EXPECTED_PROPERTY_NAME          = 0x8004400c,
    WBEMMOF_E_TYPEDEF_NOT_SUPPORTED           = 0x8004400d,
    WBEMMOF_E_UNEXPECTED_ALIAS                = 0x8004400e,
    WBEMMOF_E_UNEXPECTED_ARRAY_INIT           = 0x8004400f,
    WBEMMOF_E_INVALID_AMENDMENT_SYNTAX        = 0x80044010,
    WBEMMOF_E_INVALID_DUPLICATE_AMENDMENT     = 0x80044011,
    WBEMMOF_E_INVALID_PRAGMA                  = 0x80044012,
    WBEMMOF_E_INVALID_NAMESPACE_SYNTAX        = 0x80044013,
    WBEMMOF_E_EXPECTED_CLASS_NAME             = 0x80044014,
    WBEMMOF_E_TYPE_MISMATCH                   = 0x80044015,
    WBEMMOF_E_EXPECTED_ALIAS_NAME             = 0x80044016,
    WBEMMOF_E_INVALID_CLASS_DECLARATION       = 0x80044017,
    WBEMMOF_E_INVALID_INSTANCE_DECLARATION    = 0x80044018,
    WBEMMOF_E_EXPECTED_DOLLAR                 = 0x80044019,
    WBEMMOF_E_CIMTYPE_QUALIFIER               = 0x8004401a,
    WBEMMOF_E_DUPLICATE_PROPERTY              = 0x8004401b,
    WBEMMOF_E_INVALID_NAMESPACE_SPECIFICATION = 0x8004401c,
    WBEMMOF_E_OUT_OF_RANGE                    = 0x8004401d,
    WBEMMOF_E_INVALID_FILE                    = 0x8004401e,
    WBEMMOF_E_ALIASES_IN_EMBEDDED             = 0x8004401f,
    WBEMMOF_E_NULL_ARRAY_ELEM                 = 0x80044020,
    WBEMMOF_E_DUPLICATE_QUALIFIER             = 0x80044021,
    WBEMMOF_E_EXPECTED_FLAVOR_TYPE            = 0x80044022,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES       = 0x80044023,
    WBEMMOF_E_MULTIPLE_ALIASES                = 0x80044024,
    WBEMMOF_E_INCOMPATIBLE_FLAVOR_TYPES2      = 0x80044025,
    WBEMMOF_E_NO_ARRAYS_RETURNED              = 0x80044026,
    WBEMMOF_E_MUST_BE_IN_OR_OUT               = 0x80044027,
    WBEMMOF_E_INVALID_FLAGS_SYNTAX            = 0x80044028,
    WBEMMOF_E_EXPECTED_BRACE_OR_BAD_TYPE      = 0x80044029,
    WBEMMOF_E_UNSUPPORTED_CIMV22_QUAL_VALUE   = 0x8004402a,
    WBEMMOF_E_UNSUPPORTED_CIMV22_DATA_TYPE    = 0x8004402b,
    WBEMMOF_E_INVALID_DELETEINSTANCE_SYNTAX   = 0x8004402c,
    WBEMMOF_E_INVALID_QUALIFIER_SYNTAX        = 0x8004402d,
    WBEMMOF_E_QUALIFIER_USED_OUTSIDE_SCOPE    = 0x8004402e,
    WBEMMOF_E_ERROR_CREATING_TEMP_FILE        = 0x8004402f,
    WBEMMOF_E_ERROR_INVALID_INCLUDE_FILE      = 0x80044030,
    WBEMMOF_E_INVALID_DELETECLASS_SYNTAX      = 0x80044031,
}
alias WBEMSTATUS = int;

enum : int
{
    WMI_OBJ_TEXT_CIM_DTD_2_0 = 0x00000001,
    WMI_OBJ_TEXT_WMI_DTD_2_0 = 0x00000002,
    WMI_OBJ_TEXT_WMI_EXT1    = 0x00000003,
    WMI_OBJ_TEXT_WMI_EXT2    = 0x00000004,
    WMI_OBJ_TEXT_WMI_EXT3    = 0x00000005,
    WMI_OBJ_TEXT_WMI_EXT4    = 0x00000006,
    WMI_OBJ_TEXT_WMI_EXT5    = 0x00000007,
    WMI_OBJ_TEXT_WMI_EXT6    = 0x00000008,
    WMI_OBJ_TEXT_WMI_EXT7    = 0x00000009,
    WMI_OBJ_TEXT_WMI_EXT8    = 0x0000000a,
    WMI_OBJ_TEXT_WMI_EXT9    = 0x0000000b,
    WMI_OBJ_TEXT_WMI_EXT10   = 0x0000000c,
    WMI_OBJ_TEXT_LAST        = 0x0000000d,
}
alias WMI_OBJ_TEXT = int;

enum : int
{
    WBEM_FLAG_CHECK_ONLY       = 0x00000001,
    WBEM_FLAG_AUTORECOVER      = 0x00000002,
    WBEM_FLAG_WMI_CHECK        = 0x00000004,
    WBEM_FLAG_CONSOLE_PRINT    = 0x00000008,
    WBEM_FLAG_DONT_ADD_TO_LIST = 0x00000010,
    WBEM_FLAG_SPLIT_FILES      = 0x00000020,
    WBEM_FLAG_STORE_FILE       = 0x00000100,
}
alias WBEM_COMPILER_OPTIONS = int;

enum : int
{
    WBEM_FLAG_CONNECT_REPOSITORY_ONLY = 0x00000040,
    WBEM_FLAG_CONNECT_USE_MAX_WAIT    = 0x00000080,
    WBEM_FLAG_CONNECT_PROVIDERS       = 0x00000100,
}
alias WBEM_CONNECT_OPTIONS = int;

enum : int
{
    WBEM_FLAG_UNSECAPP_DEFAULT_CHECK_ACCESS = 0x00000000,
    WBEM_FLAG_UNSECAPP_CHECK_ACCESS         = 0x00000001,
    WBEM_FLAG_UNSECAPP_DONT_CHECK_ACCESS    = 0x00000002,
}
alias WBEM_UNSECAPP_FLAG_TYPE = int;

enum : int
{
    WBEM_FLAG_SHORT_NAME = 0x00000001,
    WBEM_FLAG_LONG_NAME  = 0x00000002,
}
alias tag_WBEM_INFORMATION_FLAG_TYPE = int;

enum : int
{
    WBEM_REQUIREMENTS_START_POSTFILTER      = 0x00000000,
    WBEM_REQUIREMENTS_STOP_POSTFILTER       = 0x00000001,
    WBEM_REQUIREMENTS_RECHECK_SUBSCRIPTIONS = 0x00000002,
}
alias tag_WBEM_PROVIDER_REQUIREMENTS_TYPE = int;

enum : int
{
    WBEM_S_INITIALIZED         = 0x00000000,
    WBEM_S_LIMITED_SERVICE     = 0x00043001,
    WBEM_S_INDIRECTLY_UPDATED  = 0x00043002,
    WBEM_S_SUBJECT_TO_SDS      = 0x00043003,
    WBEM_E_RETRY_LATER         = 0x80043001,
    WBEM_E_RESOURCE_CONTENTION = 0x80043002,
}
alias tag_WBEM_EXTRA_RETURN_CODES = int;

enum : int
{
    WBEM_FLAG_OWNER_UPDATE = 0x00010000,
}
alias tag_WBEM_PROVIDER_FLAGS = int;

enum : int
{
    WBEM_FLAG_BATCH_IF_NEEDED = 0x00000000,
    WBEM_FLAG_MUST_BATCH      = 0x00000001,
    WBEM_FLAG_MUST_NOT_BATCH  = 0x00000002,
}
alias tag_WBEM_BATCH_TYPE = int;

enum WbemChangeFlagEnum : int
{
    wbemChangeFlagCreateOrUpdate   = 0x00000000,
    wbemChangeFlagUpdateOnly       = 0x00000001,
    wbemChangeFlagCreateOnly       = 0x00000002,
    wbemChangeFlagUpdateCompatible = 0x00000000,
    wbemChangeFlagUpdateSafeMode   = 0x00000020,
    wbemChangeFlagUpdateForceMode  = 0x00000040,
    wbemChangeFlagStrongValidation = 0x00000080,
    wbemChangeFlagAdvisory         = 0x00010000,
}

enum WbemFlagEnum : int
{
    wbemFlagReturnImmediately    = 0x00000010,
    wbemFlagReturnWhenComplete   = 0x00000000,
    wbemFlagBidirectional        = 0x00000000,
    wbemFlagForwardOnly          = 0x00000020,
    wbemFlagNoErrorObject        = 0x00000040,
    wbemFlagReturnErrorObject    = 0x00000000,
    wbemFlagSendStatus           = 0x00000080,
    wbemFlagDontSendStatus       = 0x00000000,
    wbemFlagEnsureLocatable      = 0x00000100,
    wbemFlagDirectRead           = 0x00000200,
    wbemFlagSendOnlySelected     = 0x00000000,
    wbemFlagUseAmendedQualifiers = 0x00020000,
    wbemFlagGetDefault           = 0x00000000,
    wbemFlagSpawnInstance        = 0x00000001,
    wbemFlagUseCurrentTime       = 0x00000001,
}

enum WbemQueryFlagEnum : int
{
    wbemQueryFlagDeep      = 0x00000000,
    wbemQueryFlagShallow   = 0x00000001,
    wbemQueryFlagPrototype = 0x00000002,
}

enum WbemTextFlagEnum : int
{
    wbemTextFlagNoFlavors = 0x00000001,
}

enum WbemTimeout : int
{
    wbemTimeoutInfinite = 0xffffffff,
}

enum WbemComparisonFlagEnum : int
{
    wbemComparisonFlagIncludeAll          = 0x00000000,
    wbemComparisonFlagIgnoreQualifiers    = 0x00000001,
    wbemComparisonFlagIgnoreObjectSource  = 0x00000002,
    wbemComparisonFlagIgnoreDefaultValues = 0x00000004,
    wbemComparisonFlagIgnoreClass         = 0x00000008,
    wbemComparisonFlagIgnoreCase          = 0x00000010,
    wbemComparisonFlagIgnoreFlavor        = 0x00000020,
}

enum WbemCimtypeEnum : int
{
    wbemCimtypeSint8     = 0x00000010,
    wbemCimtypeUint8     = 0x00000011,
    wbemCimtypeSint16    = 0x00000002,
    wbemCimtypeUint16    = 0x00000012,
    wbemCimtypeSint32    = 0x00000003,
    wbemCimtypeUint32    = 0x00000013,
    wbemCimtypeSint64    = 0x00000014,
    wbemCimtypeUint64    = 0x00000015,
    wbemCimtypeReal32    = 0x00000004,
    wbemCimtypeReal64    = 0x00000005,
    wbemCimtypeBoolean   = 0x0000000b,
    wbemCimtypeString    = 0x00000008,
    wbemCimtypeDatetime  = 0x00000065,
    wbemCimtypeReference = 0x00000066,
    wbemCimtypeChar16    = 0x00000067,
    wbemCimtypeObject    = 0x0000000d,
}

enum WbemErrorEnum : int
{
    wbemNoErr                           = 0x00000000,
    wbemErrFailed                       = 0x80041001,
    wbemErrNotFound                     = 0x80041002,
    wbemErrAccessDenied                 = 0x80041003,
    wbemErrProviderFailure              = 0x80041004,
    wbemErrTypeMismatch                 = 0x80041005,
    wbemErrOutOfMemory                  = 0x80041006,
    wbemErrInvalidContext               = 0x80041007,
    wbemErrInvalidParameter             = 0x80041008,
    wbemErrNotAvailable                 = 0x80041009,
    wbemErrCriticalError                = 0x8004100a,
    wbemErrInvalidStream                = 0x8004100b,
    wbemErrNotSupported                 = 0x8004100c,
    wbemErrInvalidSuperclass            = 0x8004100d,
    wbemErrInvalidNamespace             = 0x8004100e,
    wbemErrInvalidObject                = 0x8004100f,
    wbemErrInvalidClass                 = 0x80041010,
    wbemErrProviderNotFound             = 0x80041011,
    wbemErrInvalidProviderRegistration  = 0x80041012,
    wbemErrProviderLoadFailure          = 0x80041013,
    wbemErrInitializationFailure        = 0x80041014,
    wbemErrTransportFailure             = 0x80041015,
    wbemErrInvalidOperation             = 0x80041016,
    wbemErrInvalidQuery                 = 0x80041017,
    wbemErrInvalidQueryType             = 0x80041018,
    wbemErrAlreadyExists                = 0x80041019,
    wbemErrOverrideNotAllowed           = 0x8004101a,
    wbemErrPropagatedQualifier          = 0x8004101b,
    wbemErrPropagatedProperty           = 0x8004101c,
    wbemErrUnexpected                   = 0x8004101d,
    wbemErrIllegalOperation             = 0x8004101e,
    wbemErrCannotBeKey                  = 0x8004101f,
    wbemErrIncompleteClass              = 0x80041020,
    wbemErrInvalidSyntax                = 0x80041021,
    wbemErrNondecoratedObject           = 0x80041022,
    wbemErrReadOnly                     = 0x80041023,
    wbemErrProviderNotCapable           = 0x80041024,
    wbemErrClassHasChildren             = 0x80041025,
    wbemErrClassHasInstances            = 0x80041026,
    wbemErrQueryNotImplemented          = 0x80041027,
    wbemErrIllegalNull                  = 0x80041028,
    wbemErrInvalidQualifierType         = 0x80041029,
    wbemErrInvalidPropertyType          = 0x8004102a,
    wbemErrValueOutOfRange              = 0x8004102b,
    wbemErrCannotBeSingleton            = 0x8004102c,
    wbemErrInvalidCimType               = 0x8004102d,
    wbemErrInvalidMethod                = 0x8004102e,
    wbemErrInvalidMethodParameters      = 0x8004102f,
    wbemErrSystemProperty               = 0x80041030,
    wbemErrInvalidProperty              = 0x80041031,
    wbemErrCallCancelled                = 0x80041032,
    wbemErrShuttingDown                 = 0x80041033,
    wbemErrPropagatedMethod             = 0x80041034,
    wbemErrUnsupportedParameter         = 0x80041035,
    wbemErrMissingParameter             = 0x80041036,
    wbemErrInvalidParameterId           = 0x80041037,
    wbemErrNonConsecutiveParameterIds   = 0x80041038,
    wbemErrParameterIdOnRetval          = 0x80041039,
    wbemErrInvalidObjectPath            = 0x8004103a,
    wbemErrOutOfDiskSpace               = 0x8004103b,
    wbemErrBufferTooSmall               = 0x8004103c,
    wbemErrUnsupportedPutExtension      = 0x8004103d,
    wbemErrUnknownObjectType            = 0x8004103e,
    wbemErrUnknownPacketType            = 0x8004103f,
    wbemErrMarshalVersionMismatch       = 0x80041040,
    wbemErrMarshalInvalidSignature      = 0x80041041,
    wbemErrInvalidQualifier             = 0x80041042,
    wbemErrInvalidDuplicateParameter    = 0x80041043,
    wbemErrTooMuchData                  = 0x80041044,
    wbemErrServerTooBusy                = 0x80041045,
    wbemErrInvalidFlavor                = 0x80041046,
    wbemErrCircularReference            = 0x80041047,
    wbemErrUnsupportedClassUpdate       = 0x80041048,
    wbemErrCannotChangeKeyInheritance   = 0x80041049,
    wbemErrCannotChangeIndexInheritance = 0x80041050,
    wbemErrTooManyProperties            = 0x80041051,
    wbemErrUpdateTypeMismatch           = 0x80041052,
    wbemErrUpdateOverrideNotAllowed     = 0x80041053,
    wbemErrUpdatePropagatedMethod       = 0x80041054,
    wbemErrMethodNotImplemented         = 0x80041055,
    wbemErrMethodDisabled               = 0x80041056,
    wbemErrRefresherBusy                = 0x80041057,
    wbemErrUnparsableQuery              = 0x80041058,
    wbemErrNotEventClass                = 0x80041059,
    wbemErrMissingGroupWithin           = 0x8004105a,
    wbemErrMissingAggregationList       = 0x8004105b,
    wbemErrPropertyNotAnObject          = 0x8004105c,
    wbemErrAggregatingByObject          = 0x8004105d,
    wbemErrUninterpretableProviderQuery = 0x8004105f,
    wbemErrBackupRestoreWinmgmtRunning  = 0x80041060,
    wbemErrQueueOverflow                = 0x80041061,
    wbemErrPrivilegeNotHeld             = 0x80041062,
    wbemErrInvalidOperator              = 0x80041063,
    wbemErrLocalCredentials             = 0x80041064,
    wbemErrCannotBeAbstract             = 0x80041065,
    wbemErrAmendedObject                = 0x80041066,
    wbemErrClientTooSlow                = 0x80041067,
    wbemErrNullSecurityDescriptor       = 0x80041068,
    wbemErrTimeout                      = 0x80041069,
    wbemErrInvalidAssociation           = 0x8004106a,
    wbemErrAmbiguousOperation           = 0x8004106b,
    wbemErrQuotaViolation               = 0x8004106c,
    wbemErrTransactionConflict          = 0x8004106d,
    wbemErrForcedRollback               = 0x8004106e,
    wbemErrUnsupportedLocale            = 0x8004106f,
    wbemErrHandleOutOfDate              = 0x80041070,
    wbemErrConnectionFailed             = 0x80041071,
    wbemErrInvalidHandleRequest         = 0x80041072,
    wbemErrPropertyNameTooWide          = 0x80041073,
    wbemErrClassNameTooWide             = 0x80041074,
    wbemErrMethodNameTooWide            = 0x80041075,
    wbemErrQualifierNameTooWide         = 0x80041076,
    wbemErrRerunCommand                 = 0x80041077,
    wbemErrDatabaseVerMismatch          = 0x80041078,
    wbemErrVetoPut                      = 0x80041079,
    wbemErrVetoDelete                   = 0x8004107a,
    wbemErrInvalidLocale                = 0x80041080,
    wbemErrProviderSuspended            = 0x80041081,
    wbemErrSynchronizationRequired      = 0x80041082,
    wbemErrNoSchema                     = 0x80041083,
    wbemErrProviderAlreadyRegistered    = 0x80041084,
    wbemErrProviderNotRegistered        = 0x80041085,
    wbemErrFatalTransportError          = 0x80041086,
    wbemErrEncryptedConnectionRequired  = 0x80041087,
    wbemErrRegistrationTooBroad         = 0x80042001,
    wbemErrRegistrationTooPrecise       = 0x80042002,
    wbemErrTimedout                     = 0x80043001,
    wbemErrResetToDefault               = 0x80043002,
}

enum WbemAuthenticationLevelEnum : int
{
    wbemAuthenticationLevelDefault      = 0x00000000,
    wbemAuthenticationLevelNone         = 0x00000001,
    wbemAuthenticationLevelConnect      = 0x00000002,
    wbemAuthenticationLevelCall         = 0x00000003,
    wbemAuthenticationLevelPkt          = 0x00000004,
    wbemAuthenticationLevelPktIntegrity = 0x00000005,
    wbemAuthenticationLevelPktPrivacy   = 0x00000006,
}

enum WbemImpersonationLevelEnum : int
{
    wbemImpersonationLevelAnonymous   = 0x00000001,
    wbemImpersonationLevelIdentify    = 0x00000002,
    wbemImpersonationLevelImpersonate = 0x00000003,
    wbemImpersonationLevelDelegate    = 0x00000004,
}

enum WbemPrivilegeEnum : int
{
    wbemPrivilegeCreateToken          = 0x00000001,
    wbemPrivilegePrimaryToken         = 0x00000002,
    wbemPrivilegeLockMemory           = 0x00000003,
    wbemPrivilegeIncreaseQuota        = 0x00000004,
    wbemPrivilegeMachineAccount       = 0x00000005,
    wbemPrivilegeTcb                  = 0x00000006,
    wbemPrivilegeSecurity             = 0x00000007,
    wbemPrivilegeTakeOwnership        = 0x00000008,
    wbemPrivilegeLoadDriver           = 0x00000009,
    wbemPrivilegeSystemProfile        = 0x0000000a,
    wbemPrivilegeSystemtime           = 0x0000000b,
    wbemPrivilegeProfileSingleProcess = 0x0000000c,
    wbemPrivilegeIncreaseBasePriority = 0x0000000d,
    wbemPrivilegeCreatePagefile       = 0x0000000e,
    wbemPrivilegeCreatePermanent      = 0x0000000f,
    wbemPrivilegeBackup               = 0x00000010,
    wbemPrivilegeRestore              = 0x00000011,
    wbemPrivilegeShutdown             = 0x00000012,
    wbemPrivilegeDebug                = 0x00000013,
    wbemPrivilegeAudit                = 0x00000014,
    wbemPrivilegeSystemEnvironment    = 0x00000015,
    wbemPrivilegeChangeNotify         = 0x00000016,
    wbemPrivilegeRemoteShutdown       = 0x00000017,
    wbemPrivilegeUndock               = 0x00000018,
    wbemPrivilegeSyncAgent            = 0x00000019,
    wbemPrivilegeEnableDelegation     = 0x0000001a,
    wbemPrivilegeManageVolume         = 0x0000001b,
}

enum WbemObjectTextFormatEnum : int
{
    wbemObjectTextFormatCIMDTD20 = 0x00000001,
    wbemObjectTextFormatWMIDTD20 = 0x00000002,
}

enum WbemConnectOptionsEnum : int
{
    wbemConnectFlagUseMaxWait = 0x00000080,
}

// Structs


struct SWbemQueryQualifiedName
{
    uint     m_uVersion;
    uint     m_uTokenType;
    uint     m_uNameListSize;
    ushort** m_ppszNameList;
    BOOL     m_bArraysUsed;
    int*     m_pbArrayElUsed;
    uint*    m_puArrayIndex;
}

union tag_SWbemRpnConst
{
    const(wchar)* m_pszStrVal;
    BOOL          m_bBoolVal;
    int           m_lLongVal;
    uint          m_uLongVal;
    double        m_dblVal;
    long          m_lVal64;
    long          m_uVal64;
}

struct SWbemRpnQueryToken
{
    uint              m_uVersion;
    uint              m_uTokenType;
    uint              m_uSubexpressionShape;
    uint              m_uOperator;
    SWbemQueryQualifiedName* m_pRightIdent;
    SWbemQueryQualifiedName* m_pLeftIdent;
    uint              m_uConstApparentType;
    tag_SWbemRpnConst m_Const;
    uint              m_uConst2ApparentType;
    tag_SWbemRpnConst m_Const2;
    const(wchar)*     m_pszRightFunc;
    const(wchar)*     m_pszLeftFunc;
}

struct tag_SWbemRpnTokenList
{
    uint m_uVersion;
    uint m_uTokenType;
    uint m_uNumTokens;
}

struct SWbemRpnEncodedQuery
{
    uint                 m_uVersion;
    uint                 m_uTokenType;
    ulong                m_uParsedFeatureMask;
    uint                 m_uDetectedArraySize;
    uint*                m_puDetectedFeatures;
    uint                 m_uSelectListSize;
    SWbemQueryQualifiedName** m_ppSelectList;
    uint                 m_uFromTargetType;
    const(wchar)*        m_pszOptionalFromPath;
    uint                 m_uFromListSize;
    ushort**             m_ppszFromList;
    uint                 m_uWhereClauseSize;
    SWbemRpnQueryToken** m_ppRpnWhereClause;
    double               m_dblWithinPolling;
    double               m_dblWithinWindow;
    uint                 m_uOrderByListSize;
    ushort**             m_ppszOrderByList;
    uint*                m_uOrderDirectionEl;
}

struct tag_SWbemAnalysisMatrix
{
    uint          m_uVersion;
    uint          m_uMatrixType;
    const(wchar)* m_pszProperty;
    uint          m_uPropertyType;
    uint          m_uEntries;
    void**        m_pValues;
    int*          m_pbTruthTable;
}

struct tag_SWbemAnalysisMatrixList
{
    uint m_uVersion;
    uint m_uMatrixType;
    uint m_uNumMatrices;
    tag_SWbemAnalysisMatrix* m_pMatrices;
}

struct SWbemAssocQueryInf
{
    uint          m_uVersion;
    uint          m_uAnalysisType;
    uint          m_uFeatureMask;
    IWbemPath     m_pPath;
    const(wchar)* m_pszPath;
    const(wchar)* m_pszQueryText;
    const(wchar)* m_pszResultClass;
    const(wchar)* m_pszAssocClass;
    const(wchar)* m_pszRole;
    const(wchar)* m_pszResultRole;
    const(wchar)* m_pszRequiredQualifier;
    const(wchar)* m_pszRequiredAssocQualifier;
}

struct WBEM_COMPILE_STATUS_INFO
{
    int     lPhaseError;
    HRESULT hRes;
    int     ObjectNum;
    int     FirstLine;
    int     LastLine;
    uint    dwOutFlags;
}

// Interfaces

@GUID("CF4CC405-E2C5-4DDD-B3CE-5E7582D8C9FA")
struct WbemDefPath;

@GUID("EAC8A024-21E2-4523-AD73-A71A0AA2F56A")
struct WbemQuery;

@GUID("4590F811-1D3A-11D0-891F-00AA004B2E24")
struct WbemLocator;

@GUID("674B6698-EE92-11D0-AD71-00C04FD8FDFF")
struct WbemContext;

@GUID("49BD2028-1523-11D1-AD79-00C04FD8FDFF")
struct UnsecuredApartment;

@GUID("9A653086-174F-11D2-B5F9-00104B703EFD")
struct WbemClassObject;

@GUID("6DAF9757-2E37-11D2-AEC9-00C04FB68820")
struct MofCompiler;

@GUID("EB87E1BD-3233-11D2-AEC9-00C04FB68820")
struct WbemStatusCodeText;

@GUID("C49E32C6-BC8B-11D2-85D4-00105A1F8304")
struct WbemBackupRestore;

@GUID("C71566F2-561E-11D1-AD87-00C04FD8FDFF")
struct WbemRefresher;

@GUID("8D1C559D-84F0-4BB3-A7D5-56A7435A9BA6")
struct WbemObjectTextSrc;

@GUID("CB8555CC-9128-11D1-AD9B-00C04FD8FDFF")
struct WbemAdministrativeLocator;

@GUID("CD184336-9128-11D1-AD9B-00C04FD8FDFF")
struct WbemAuthenticatedLocator;

@GUID("443E7B79-DE31-11D2-B340-00104BCC4B4A")
struct WbemUnauthenticatedLocator;

@GUID("4CFC7932-0F9D-4BEF-9C32-8EA2A6B56FCB")
struct WbemDecoupledRegistrar;

@GUID("F5F75737-2843-4F22-933D-C76A97CDA62F")
struct WbemDecoupledBasicEventProvider;

@GUID("76A64158-CB41-11D1-8B02-00600806D9B6")
struct SWbemLocator;

@GUID("9AED384E-CE8B-11D1-8B05-00600806D9B6")
struct SWbemNamedValueSet;

@GUID("5791BC26-CE9C-11D1-97BF-0000F81E849C")
struct SWbemObjectPath;

@GUID("C2FEEEAC-CFCD-11D1-8B05-00600806D9B6")
struct SWbemLastError;

@GUID("75718C9A-F029-11D1-A1AC-00C04FB6C223")
struct SWbemSink;

@GUID("47DFBE54-CF76-11D3-B38F-00105A1F473A")
struct SWbemDateTime;

@GUID("D269BF5C-D9C1-11D3-B38F-00105A1F473A")
struct SWbemRefresher;

@GUID("04B83D63-21AE-11D2-8B33-00600806D9B6")
struct SWbemServices;

@GUID("62E522DC-8CF3-40A8-8B2E-37D595651E40")
struct SWbemServicesEx;

@GUID("04B83D62-21AE-11D2-8B33-00600806D9B6")
struct SWbemObject;

@GUID("D6BDAFB2-9435-491F-BB87-6AA0F0BC31A2")
struct SWbemObjectEx;

@GUID("04B83D61-21AE-11D2-8B33-00600806D9B6")
struct SWbemObjectSet;

@GUID("04B83D60-21AE-11D2-8B33-00600806D9B6")
struct SWbemNamedValue;

@GUID("04B83D5F-21AE-11D2-8B33-00600806D9B6")
struct SWbemQualifier;

@GUID("04B83D5E-21AE-11D2-8B33-00600806D9B6")
struct SWbemQualifierSet;

@GUID("04B83D5D-21AE-11D2-8B33-00600806D9B6")
struct SWbemProperty;

@GUID("04B83D5C-21AE-11D2-8B33-00600806D9B6")
struct SWbemPropertySet;

@GUID("04B83D5B-21AE-11D2-8B33-00600806D9B6")
struct SWbemMethod;

@GUID("04B83D5A-21AE-11D2-8B33-00600806D9B6")
struct SWbemMethodSet;

@GUID("04B83D58-21AE-11D2-8B33-00600806D9B6")
struct SWbemEventSource;

@GUID("B54D66E9-2287-11D2-8B33-00600806D9B6")
struct SWbemSecurity;

@GUID("26EE67BC-5804-11D2-8B4A-00600806D9B6")
struct SWbemPrivilege;

@GUID("26EE67BE-5804-11D2-8B4A-00600806D9B6")
struct SWbemPrivilegeSet;

@GUID("8C6854BC-DE4B-11D3-B390-00105A1F473A")
struct SWbemRefreshableItem;

@GUID("9AE62877-7544-4BB0-AA26-A13824659ED6")
interface IWbemPathKeyList : IUnknown
{
    HRESULT GetCount(uint* puKeyCount);
    HRESULT SetKey(const(wchar)* wszName, uint uFlags, uint uCimType, void* pKeyVal);
    HRESULT SetKey2(const(wchar)* wszName, uint uFlags, uint uCimType, VARIANT* pKeyVal);
    HRESULT GetKey(uint uKeyIx, uint uFlags, uint* puNameBufSize, const(wchar)* pszKeyName, uint* puKeyValBufSize, 
                   void* pKeyVal, uint* puApparentCimType);
    HRESULT GetKey2(uint uKeyIx, uint uFlags, uint* puNameBufSize, const(wchar)* pszKeyName, VARIANT* pKeyValue, 
                    uint* puApparentCimType);
    HRESULT RemoveKey(const(wchar)* wszName, uint uFlags);
    HRESULT RemoveAllKeys(uint uFlags);
    HRESULT MakeSingleton(ubyte bSet);
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    HRESULT GetText(int lFlags, uint* puBuffLength, const(wchar)* pszText);
}

@GUID("3BC15AF2-736C-477E-9E51-238AF8667DCC")
interface IWbemPath : IUnknown
{
    HRESULT SetText(uint uMode, const(wchar)* pszPath);
    HRESULT GetText(int lFlags, uint* puBuffLength, const(wchar)* pszText);
    HRESULT GetInfo(uint uRequestedInfo, ulong* puResponse);
    HRESULT SetServer(const(wchar)* Name);
    HRESULT GetServer(uint* puNameBufLength, const(wchar)* pName);
    HRESULT GetNamespaceCount(uint* puCount);
    HRESULT SetNamespaceAt(uint uIndex, const(wchar)* pszName);
    HRESULT GetNamespaceAt(uint uIndex, uint* puNameBufLength, const(wchar)* pName);
    HRESULT RemoveNamespaceAt(uint uIndex);
    HRESULT RemoveAllNamespaces();
    HRESULT GetScopeCount(uint* puCount);
    HRESULT SetScope(uint uIndex, const(wchar)* pszClass);
    HRESULT SetScopeFromText(uint uIndex, const(wchar)* pszText);
    HRESULT GetScope(uint uIndex, uint* puClassNameBufSize, const(wchar)* pszClass, IWbemPathKeyList* pKeyList);
    HRESULT GetScopeAsText(uint uIndex, uint* puTextBufSize, const(wchar)* pszText);
    HRESULT RemoveScope(uint uIndex);
    HRESULT RemoveAllScopes();
    HRESULT SetClassName(const(wchar)* Name);
    HRESULT GetClassNameA(uint* puBuffLength, const(wchar)* pszName);
    HRESULT GetKeyList(IWbemPathKeyList* pOut);
    HRESULT CreateClassPart(int lFlags, const(wchar)* Name);
    HRESULT DeleteClassPart(int lFlags);
    BOOL    IsRelative(const(wchar)* wszMachine, const(wchar)* wszNamespace);
    BOOL    IsRelativeOrChild(const(wchar)* wszMachine, const(wchar)* wszNamespace, int lFlags);
    BOOL    IsLocal(const(wchar)* wszMachine);
    BOOL    IsSameClassName(const(wchar)* wszClass);
}

@GUID("81166F58-DD98-11D3-A120-00105A1F515A")
interface IWbemQuery : IUnknown
{
    HRESULT Empty();
    HRESULT SetLanguageFeatures(uint uFlags, uint uArraySize, uint* puFeatures);
    HRESULT TestLanguageFeatures(uint uFlags, uint* uArraySize, uint* puFeatures);
    HRESULT Parse(const(wchar)* pszLang, const(wchar)* pszQuery, uint uFlags);
    HRESULT GetAnalysis(uint uAnalysisType, uint uFlags, void** pAnalysis);
    HRESULT FreeMemory(void* pMem);
    HRESULT GetQueryInfo(uint uAnalysisType, uint uInfoId, uint uBufSize, void* pDestBuf);
}

@GUID("DC12A681-737F-11CF-884D-00AA004B2E24")
interface IWbemClassObject : IUnknown
{
    HRESULT GetQualifierSet(IWbemQualifierSet* ppQualSet);
    HRESULT Get(const(wchar)* wszName, int lFlags, VARIANT* pVal, int* pType, int* plFlavor);
    HRESULT Put(const(wchar)* wszName, int lFlags, VARIANT* pVal, int Type);
    HRESULT Delete(const(wchar)* wszName);
    HRESULT GetNames(const(wchar)* wszQualifierName, int lFlags, VARIANT* pQualifierVal, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lEnumFlags);
    HRESULT Next(int lFlags, BSTR* strName, VARIANT* pVal, int* pType, int* plFlavor);
    HRESULT EndEnumeration();
    HRESULT GetPropertyQualifierSet(const(wchar)* wszProperty, IWbemQualifierSet* ppQualSet);
    HRESULT Clone(IWbemClassObject* ppCopy);
    HRESULT GetObjectText(int lFlags, BSTR* pstrObjectText);
    HRESULT SpawnDerivedClass(int lFlags, IWbemClassObject* ppNewClass);
    HRESULT SpawnInstance(int lFlags, IWbemClassObject* ppNewInstance);
    HRESULT CompareTo(int lFlags, IWbemClassObject pCompareTo);
    HRESULT GetPropertyOrigin(const(wchar)* wszName, BSTR* pstrClassName);
    HRESULT InheritsFrom(const(wchar)* strAncestor);
    HRESULT GetMethod(const(wchar)* wszName, int lFlags, IWbemClassObject* ppInSignature, 
                      IWbemClassObject* ppOutSignature);
    HRESULT PutMethod(const(wchar)* wszName, int lFlags, IWbemClassObject pInSignature, 
                      IWbemClassObject pOutSignature);
    HRESULT DeleteMethod(const(wchar)* wszName);
    HRESULT BeginMethodEnumeration(int lEnumFlags);
    HRESULT NextMethod(int lFlags, BSTR* pstrName, IWbemClassObject* ppInSignature, 
                       IWbemClassObject* ppOutSignature);
    HRESULT EndMethodEnumeration();
    HRESULT GetMethodQualifierSet(const(wchar)* wszMethod, IWbemQualifierSet* ppQualSet);
    HRESULT GetMethodOrigin(const(wchar)* wszMethodName, BSTR* pstrClassName);
}

@GUID("49353C9A-516B-11D1-AEA6-00C04FB68820")
interface IWbemObjectAccess : IWbemClassObject
{
    HRESULT GetPropertyHandle(const(wchar)* wszPropertyName, int* pType, int* plHandle);
    HRESULT WritePropertyValue(int lHandle, int lNumBytes, const(ubyte)* aData);
    HRESULT ReadPropertyValue(int lHandle, int lBufferSize, int* plNumBytes, ubyte* aData);
    HRESULT ReadDWORD(int lHandle, uint* pdw);
    HRESULT WriteDWORD(int lHandle, uint dw);
    HRESULT ReadQWORD(int lHandle, ulong* pqw);
    HRESULT WriteQWORD(int lHandle, ulong pw);
    HRESULT GetPropertyInfoByHandle(int lHandle, BSTR* pstrName, int* pType);
    HRESULT Lock(int lFlags);
    HRESULT Unlock(int lFlags);
}

@GUID("DC12A680-737F-11CF-884D-00AA004B2E24")
interface IWbemQualifierSet : IUnknown
{
    HRESULT Get(const(wchar)* wszName, int lFlags, VARIANT* pVal, int* plFlavor);
    HRESULT Put(const(wchar)* wszName, VARIANT* pVal, int lFlavor);
    HRESULT Delete(const(wchar)* wszName);
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lFlags);
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pVal, int* plFlavor);
    HRESULT EndEnumeration();
}

@GUID("9556DC99-828C-11CF-A37E-00AA003240C7")
interface IWbemServices : IUnknown
{
    HRESULT OpenNamespace(const(ushort)* strNamespace, int lFlags, IWbemContext pCtx, 
                          IWbemServices* ppWorkingNamespace, IWbemCallResult* ppResult);
    HRESULT CancelAsyncCall(IWbemObjectSink pSink);
    HRESULT QueryObjectSink(int lFlags, IWbemObjectSink* ppResponseHandler);
    HRESULT GetObjectA(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, IWbemClassObject* ppObject, 
                       IWbemCallResult* ppCallResult);
    HRESULT GetObjectAsync(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pResponseHandler);
    HRESULT PutClass(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT PutClassAsync(IWbemClassObject pObject, int lFlags, IWbemContext pCtx, 
                          IWbemObjectSink pResponseHandler);
    HRESULT DeleteClass(const(ushort)* strClass, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT DeleteClassAsync(const(ushort)* strClass, int lFlags, IWbemContext pCtx, 
                             IWbemObjectSink pResponseHandler);
    HRESULT CreateClassEnum(const(ushort)* strSuperclass, int lFlags, IWbemContext pCtx, 
                            IEnumWbemClassObject* ppEnum);
    HRESULT CreateClassEnumAsync(const(ushort)* strSuperclass, int lFlags, IWbemContext pCtx, 
                                 IWbemObjectSink pResponseHandler);
    HRESULT PutInstance(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, IWbemCallResult* ppCallResult);
    HRESULT PutInstanceAsync(IWbemClassObject pInst, int lFlags, IWbemContext pCtx, 
                             IWbemObjectSink pResponseHandler);
    HRESULT DeleteInstance(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, 
                           IWbemCallResult* ppCallResult);
    HRESULT DeleteInstanceAsync(const(ushort)* strObjectPath, int lFlags, IWbemContext pCtx, 
                                IWbemObjectSink pResponseHandler);
    HRESULT CreateInstanceEnum(const(ushort)* strFilter, int lFlags, IWbemContext pCtx, 
                               IEnumWbemClassObject* ppEnum);
    HRESULT CreateInstanceEnumAsync(const(ushort)* strFilter, int lFlags, IWbemContext pCtx, 
                                    IWbemObjectSink pResponseHandler);
    HRESULT ExecQuery(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, 
                      IEnumWbemClassObject* ppEnum);
    HRESULT ExecQueryAsync(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pResponseHandler);
    HRESULT ExecNotificationQuery(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, 
                                  IWbemContext pCtx, IEnumWbemClassObject* ppEnum);
    HRESULT ExecNotificationQueryAsync(const(ushort)* strQueryLanguage, const(ushort)* strQuery, int lFlags, 
                                       IWbemContext pCtx, IWbemObjectSink pResponseHandler);
    HRESULT ExecMethod(const(ushort)* strObjectPath, const(ushort)* strMethodName, int lFlags, IWbemContext pCtx, 
                       IWbemClassObject pInParams, IWbemClassObject* ppOutParams, IWbemCallResult* ppCallResult);
    HRESULT ExecMethodAsync(const(ushort)* strObjectPath, const(ushort)* strMethodName, int lFlags, 
                            IWbemContext pCtx, IWbemClassObject pInParams, IWbemObjectSink pResponseHandler);
}

@GUID("DC12A687-737F-11CF-884D-00AA004B2E24")
interface IWbemLocator : IUnknown
{
    HRESULT ConnectServer(const(ushort)* strNetworkResource, const(ushort)* strUser, const(ushort)* strPassword, 
                          const(ushort)* strLocale, int lSecurityFlags, const(ushort)* strAuthority, 
                          IWbemContext pCtx, IWbemServices* ppNamespace);
}

@GUID("7C857801-7381-11CF-884D-00AA004B2E24")
interface IWbemObjectSink : IUnknown
{
    HRESULT Indicate(int lObjectCount, char* apObjArray);
    HRESULT SetStatus(int lFlags, HRESULT hResult, BSTR strParam, IWbemClassObject pObjParam);
}

@GUID("027947E1-D731-11CE-A357-000000000001")
interface IEnumWbemClassObject : IUnknown
{
    HRESULT Reset();
    HRESULT Next(int lTimeout, uint uCount, char* apObjects, uint* puReturned);
    HRESULT NextAsync(uint uCount, IWbemObjectSink pSink);
    HRESULT Clone(IEnumWbemClassObject* ppEnum);
    HRESULT Skip(int lTimeout, uint nCount);
}

@GUID("44ACA675-E8FC-11D0-A07C-00C04FB68820")
interface IWbemCallResult : IUnknown
{
    HRESULT GetResultObject(int lTimeout, IWbemClassObject* ppResultObject);
    HRESULT GetResultString(int lTimeout, BSTR* pstrResultString);
    HRESULT GetResultServices(int lTimeout, IWbemServices* ppServices);
    HRESULT GetCallStatus(int lTimeout, int* plStatus);
}

@GUID("44ACA674-E8FC-11D0-A07C-00C04FB68820")
interface IWbemContext : IUnknown
{
    HRESULT Clone(IWbemContext* ppNewCopy);
    HRESULT GetNames(int lFlags, SAFEARRAY** pNames);
    HRESULT BeginEnumeration(int lFlags);
    HRESULT Next(int lFlags, BSTR* pstrName, VARIANT* pValue);
    HRESULT EndEnumeration();
    HRESULT SetValue(const(wchar)* wszName, int lFlags, VARIANT* pValue);
    HRESULT GetValue(const(wchar)* wszName, int lFlags, VARIANT* pValue);
    HRESULT DeleteValue(const(wchar)* wszName, int lFlags);
    HRESULT DeleteAll();
}

@GUID("1CFABA8C-1523-11D1-AD79-00C04FD8FDFF")
interface IUnsecuredApartment : IUnknown
{
    HRESULT CreateObjectStub(IUnknown pObject, IUnknown* ppStub);
}

@GUID("31739D04-3471-4CF4-9A7C-57A44AE71956")
interface IWbemUnsecuredApartment : IUnsecuredApartment
{
    HRESULT CreateSinkStub(IWbemObjectSink pSink, uint dwFlags, const(wchar)* wszReserved, IWbemObjectSink* ppStub);
}

@GUID("EB87E1BC-3233-11D2-AEC9-00C04FB68820")
interface IWbemStatusCodeText : IUnknown
{
    HRESULT GetErrorCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
    HRESULT GetFacilityCodeText(HRESULT hRes, uint LocaleId, int lFlags, BSTR* MessageText);
}

@GUID("C49E32C7-BC8B-11D2-85D4-00105A1F8304")
interface IWbemBackupRestore : IUnknown
{
    HRESULT Backup(const(wchar)* strBackupToFile, int lFlags);
    HRESULT Restore(const(wchar)* strRestoreFromFile, int lFlags);
}

@GUID("A359DEC5-E813-4834-8A2A-BA7F1D777D76")
interface IWbemBackupRestoreEx : IWbemBackupRestore
{
    HRESULT Pause();
    HRESULT Resume();
}

@GUID("49353C99-516B-11D1-AEA6-00C04FB68820")
interface IWbemRefresher : IUnknown
{
    HRESULT Refresh(int lFlags);
}

@GUID("2705C288-79AE-11D2-B348-00105A1F8177")
interface IWbemHiPerfEnum : IUnknown
{
    HRESULT AddObjects(int lFlags, uint uNumObjects, int* apIds, IWbemObjectAccess* apObj);
    HRESULT RemoveObjects(int lFlags, uint uNumObjects, int* apIds);
    HRESULT GetObjects(int lFlags, uint uNumObjects, IWbemObjectAccess* apObj, uint* puReturned);
    HRESULT RemoveAll(int lFlags);
}

@GUID("49353C92-516B-11D1-AEA6-00C04FB68820")
interface IWbemConfigureRefresher : IUnknown
{
    HRESULT AddObjectByPath(IWbemServices pNamespace, const(wchar)* wszPath, int lFlags, IWbemContext pContext, 
                            IWbemClassObject* ppRefreshable, int* plId);
    HRESULT AddObjectByTemplate(IWbemServices pNamespace, IWbemClassObject pTemplate, int lFlags, 
                                IWbemContext pContext, IWbemClassObject* ppRefreshable, int* plId);
    HRESULT AddRefresher(IWbemRefresher pRefresher, int lFlags, int* plId);
    HRESULT Remove(int lId, int lFlags);
    HRESULT AddEnum(IWbemServices pNamespace, const(wchar)* wszClassName, int lFlags, IWbemContext pContext, 
                    IWbemHiPerfEnum* ppEnum, int* plId);
}

@GUID("E7D35CFA-348B-485E-B524-252725D697CA")
interface IWbemObjectSinkEx : IWbemObjectSink
{
    HRESULT WriteMessage(uint uChannel, const(ushort)* strMessage);
    HRESULT WriteError(IWbemClassObject pObjError, ubyte* puReturned);
    HRESULT PromptUser(const(ushort)* strMessage, ubyte uPromptType, ubyte* puReturned);
    HRESULT WriteProgress(const(ushort)* strActivity, const(ushort)* strCurrentOperation, 
                          const(ushort)* strStatusDescription, uint uPercentComplete, uint uSecondsRemaining);
    HRESULT WriteStreamParameter(const(ushort)* strName, VARIANT* vtValue, uint ulType, uint ulFlags);
}

@GUID("B7B31DF9-D515-11D3-A11C-00105A1F515A")
interface IWbemShutdown : IUnknown
{
    HRESULT Shutdown(int uReason, uint uMaxMilliseconds, IWbemContext pCtx);
}

@GUID("BFBF883A-CAD7-11D3-A11B-00105A1F515A")
interface IWbemObjectTextSrc : IUnknown
{
    HRESULT GetText(int lFlags, IWbemClassObject pObj, uint uObjTextFormat, IWbemContext pCtx, BSTR* strText);
    HRESULT CreateFromText(int lFlags, BSTR strText, uint uObjTextFormat, IWbemContext pCtx, 
                           IWbemClassObject* pNewObj);
}

@GUID("6DAF974E-2E37-11D2-AEC9-00C04FB68820")
interface IMofCompiler : IUnknown
{
    HRESULT CompileFile(const(wchar)* FileName, const(wchar)* ServerAndNamespace, const(wchar)* User, 
                        const(wchar)* Authority, const(wchar)* Password, int lOptionFlags, int lClassFlags, 
                        int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    HRESULT CompileBuffer(int BuffSize, char* pBuffer, const(wchar)* ServerAndNamespace, const(wchar)* User, 
                          const(wchar)* Authority, const(wchar)* Password, int lOptionFlags, int lClassFlags, 
                          int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
    HRESULT CreateBMOF(const(wchar)* TextFileName, const(wchar)* BMOFFileName, const(wchar)* ServerAndNamespace, 
                       int lOptionFlags, int lClassFlags, int lInstanceFlags, WBEM_COMPILE_STATUS_INFO* pInfo);
}

@GUID("CE61E841-65BC-11D0-B6BD-00AA003240C7")
interface IWbemPropertyProvider : IUnknown
{
    HRESULT GetProperty(int lFlags, const(ushort)* strLocale, const(ushort)* strClassMapping, 
                        const(ushort)* strInstMapping, const(ushort)* strPropMapping, VARIANT* pvValue);
    HRESULT PutProperty(int lFlags, const(ushort)* strLocale, const(ushort)* strClassMapping, 
                        const(ushort)* strInstMapping, const(ushort)* strPropMapping, const(VARIANT)* pvValue);
}

@GUID("E246107B-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemUnboundObjectSink : IUnknown
{
    HRESULT IndicateToConsumer(IWbemClassObject pLogicalConsumer, int lNumObjects, char* apObjects);
}

@GUID("E245105B-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemEventProvider : IUnknown
{
    HRESULT ProvideEvents(IWbemObjectSink pSink, int lFlags);
}

@GUID("580ACAF8-FA1C-11D0-AD72-00C04FD8FDFF")
interface IWbemEventProviderQuerySink : IUnknown
{
    HRESULT NewQuery(uint dwId, ushort* wszQueryLanguage, ushort* wszQuery);
    HRESULT CancelQuery(uint dwId);
}

@GUID("631F7D96-D993-11D2-B339-00105A1F4AAF")
interface IWbemEventProviderSecurity : IUnknown
{
    HRESULT AccessCheck(ushort* wszQueryLanguage, ushort* wszQuery, int lSidLength, char* pSid);
}

@GUID("E246107A-B06E-11D0-AD61-00C04FD8FDFF")
interface IWbemEventConsumerProvider : IUnknown
{
    HRESULT FindConsumer(IWbemClassObject pLogicalConsumer, IWbemUnboundObjectSink* ppConsumer);
}

@GUID("1BE41571-91DD-11D1-AEB2-00C04FB68820")
interface IWbemProviderInitSink : IUnknown
{
    HRESULT SetStatus(int lStatus, int lFlags);
}

@GUID("1BE41572-91DD-11D1-AEB2-00C04FB68820")
interface IWbemProviderInit : IUnknown
{
    HRESULT Initialize(const(wchar)* wszUser, int lFlags, const(wchar)* wszNamespace, const(wchar)* wszLocale, 
                       IWbemServices pNamespace, IWbemContext pCtx, IWbemProviderInitSink pInitSink);
}

@GUID("49353C93-516B-11D1-AEA6-00C04FB68820")
interface IWbemHiPerfProvider : IUnknown
{
    HRESULT QueryInstances(IWbemServices pNamespace, ushort* wszClass, int lFlags, IWbemContext pCtx, 
                           IWbemObjectSink pSink);
    HRESULT CreateRefresher(IWbemServices pNamespace, int lFlags, IWbemRefresher* ppRefresher);
    HRESULT CreateRefreshableObject(IWbemServices pNamespace, IWbemObjectAccess pTemplate, 
                                    IWbemRefresher pRefresher, int lFlags, IWbemContext pContext, 
                                    IWbemObjectAccess* ppRefreshable, int* plId);
    HRESULT StopRefreshing(IWbemRefresher pRefresher, int lId, int lFlags);
    HRESULT CreateRefreshableEnum(IWbemServices pNamespace, const(wchar)* wszClass, IWbemRefresher pRefresher, 
                                  int lFlags, IWbemContext pContext, IWbemHiPerfEnum pHiPerfEnum, int* plId);
    HRESULT GetObjects(IWbemServices pNamespace, int lNumObjects, char* apObj, int lFlags, IWbemContext pContext);
}

@GUID("1005CBCF-E64F-4646-BCD3-3A089D8A84B4")
interface IWbemDecoupledRegistrar : IUnknown
{
    HRESULT Register(int a_Flags, IWbemContext a_Context, const(wchar)* a_User, const(wchar)* a_Locale, 
                     const(wchar)* a_Scope, const(wchar)* a_Registration, IUnknown pIUnknown);
    HRESULT UnRegister();
}

@GUID("631F7D97-D993-11D2-B339-00105A1F4AAF")
interface IWbemProviderIdentity : IUnknown
{
    HRESULT SetRegistrationObject(int lFlags, IWbemClassObject pProvReg);
}

@GUID("86336D20-CA11-4786-9EF1-BC8A946B42FC")
interface IWbemDecoupledBasicEventProvider : IWbemDecoupledRegistrar
{
    HRESULT GetSink(int a_Flags, IWbemContext a_Context, IWbemObjectSink* a_Sink);
    HRESULT GetService(int a_Flags, IWbemContext a_Context, IWbemServices* a_Service);
}

@GUID("3AE0080A-7E3A-4366-BF89-0FEEDC931659")
interface IWbemEventSink : IWbemObjectSink
{
    HRESULT SetSinkSecurity(int lSDLength, char* pSD);
    HRESULT IsActive();
    HRESULT GetRestrictedSink(int lNumQueries, char* awszQueries, IUnknown pCallback, IWbemEventSink* ppSink);
    HRESULT SetBatchingParameters(int lFlags, uint dwMaxBufferSize, uint dwMaxSendLatency);
}

@GUID("76A6415C-CB41-11D1-8B02-00600806D9B6")
interface ISWbemServices : IDispatch
{
    HRESULT Get(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, ISWbemObject* objWbemObject);
    HRESULT GetAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                     IDispatch objWbemAsyncContext);
    HRESULT Delete(BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync(IDispatch objWbemSink, BSTR strObjectPath, int iFlags, IDispatch objWbemNamedValueSet, 
                        IDispatch objWbemAsyncContext);
    HRESULT InstancesOf(BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesOfAsync(IDispatch objWbemSink, BSTR strClass, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT SubclassesOf(BSTR strSuperclass, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesOfAsync(IDispatch objWbemSink, BSTR strSuperclass, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                      ISWbemObjectSet* objWbemObjectSet);
    HRESULT ExecQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int lFlags, 
                           IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT AssociatorsOf(BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                          BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                          BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                          ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsOfAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strAssocClass, BSTR strResultClass, 
                               BSTR strResultRole, BSTR strRole, short bClassesOnly, short bSchemaOnly, 
                               BSTR strRequiredAssocQualifier, BSTR strRequiredQualifier, int iFlags, 
                               IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ReferencesTo(BSTR strObjectPath, BSTR strResultClass, BSTR strRole, short bClassesOnly, 
                         short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesToAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strResultClass, BSTR strRole, 
                              short bClassesOnly, short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                              IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecNotificationQuery(BSTR strQuery, BSTR strQueryLanguage, int iFlags, IDispatch objWbemNamedValueSet, 
                                  ISWbemEventSource* objWbemEventSource);
    HRESULT ExecNotificationQueryAsync(IDispatch objWbemSink, BSTR strQuery, BSTR strQueryLanguage, int iFlags, 
                                       IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod(BSTR strObjectPath, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                       IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync(IDispatch objWbemSink, BSTR strObjectPath, BSTR strMethodName, 
                            IDispatch objWbemInParameters, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415B-CB41-11D1-8B02-00600806D9B6")
interface ISWbemLocator : IDispatch
{
    HRESULT ConnectServer(BSTR strServer, BSTR strNamespace, BSTR strUser, BSTR strPassword, BSTR strLocale, 
                          BSTR strAuthority, int iSecurityFlags, IDispatch objWbemNamedValueSet, 
                          ISWbemServices* objWbemServices);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415A-CB41-11D1-8B02-00600806D9B6")
interface ISWbemObject : IDispatch
{
    HRESULT Put_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                      IDispatch objWbemAsyncContext);
    HRESULT Delete_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT DeleteAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                         IDispatch objWbemAsyncContext);
    HRESULT Instances_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT InstancesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                            IDispatch objWbemAsyncContext);
    HRESULT Subclasses_(int iFlags, IDispatch objWbemNamedValueSet, ISWbemObjectSet* objWbemObjectSet);
    HRESULT SubclassesAsync_(IDispatch objWbemSink, int iFlags, IDispatch objWbemNamedValueSet, 
                             IDispatch objWbemAsyncContext);
    HRESULT Associators_(BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, BSTR strRole, 
                         short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                         BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                         ISWbemObjectSet* objWbemObjectSet);
    HRESULT AssociatorsAsync_(IDispatch objWbemSink, BSTR strAssocClass, BSTR strResultClass, BSTR strResultRole, 
                              BSTR strRole, short bClassesOnly, short bSchemaOnly, BSTR strRequiredAssocQualifier, 
                              BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                              IDispatch objWbemAsyncContext);
    HRESULT References_(BSTR strResultClass, BSTR strRole, short bClassesOnly, short bSchemaOnly, 
                        BSTR strRequiredQualifier, int iFlags, IDispatch objWbemNamedValueSet, 
                        ISWbemObjectSet* objWbemObjectSet);
    HRESULT ReferencesAsync_(IDispatch objWbemSink, BSTR strResultClass, BSTR strRole, short bClassesOnly, 
                             short bSchemaOnly, BSTR strRequiredQualifier, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT ExecMethod_(BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                        IDispatch objWbemNamedValueSet, ISWbemObject* objWbemOutParameters);
    HRESULT ExecMethodAsync_(IDispatch objWbemSink, BSTR strMethodName, IDispatch objWbemInParameters, int iFlags, 
                             IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
    HRESULT Clone_(ISWbemObject* objWbemObject);
    HRESULT GetObjectText_(int iFlags, BSTR* strObjectText);
    HRESULT SpawnDerivedClass_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT SpawnInstance_(int iFlags, ISWbemObject* objWbemObject);
    HRESULT CompareTo_(IDispatch objWbemObject, int iFlags, short* bResult);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_Properties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT get_Methods_(ISWbemMethodSet* objWbemMethodSet);
    HRESULT get_Derivation_(VARIANT* strClassNameArray);
    HRESULT get_Path_(ISWbemObjectPath* objWbemObjectPath);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("76A6415F-CB41-11D1-8B02-00600806D9B6")
interface ISWbemObjectSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strObjectPath, int iFlags, ISWbemObject* objWbemObject);
    HRESULT get_Count(int* iCount);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT ItemIndex(int lIndex, ISWbemObject* objWbemObject);
}

@GUID("76A64164-CB41-11D1-8B02-00600806D9B6")
interface ISWbemNamedValue : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
}

@GUID("CF2376EA-CE8C-11D1-8B05-00600806D9B6")
interface ISWbemNamedValueSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varValue, int iFlags, ISWbemNamedValue* objWbemNamedValue);
    HRESULT Remove(BSTR strName, int iFlags);
    HRESULT Clone(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT DeleteAll();
}

@GUID("79B05932-D3B7-11D1-8B06-00600806D9B6")
interface ISWbemQualifier : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_PropagatesToSubclass(short* bPropagatesToSubclass);
    HRESULT put_PropagatesToSubclass(short bPropagatesToSubclass);
    HRESULT get_PropagatesToInstance(short* bPropagatesToInstance);
    HRESULT put_PropagatesToInstance(short bPropagatesToInstance);
    HRESULT get_IsOverridable(short* bIsOverridable);
    HRESULT put_IsOverridable(short bIsOverridable);
    HRESULT get_IsAmended(short* bIsAmended);
}

@GUID("9B16ED16-D3DF-11D1-8B08-00600806D9B6")
interface ISWbemQualifierSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR name, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, VARIANT* varVal, short bPropagatesToSubclass, short bPropagatesToInstance, 
                short bIsOverridable, int iFlags, ISWbemQualifier* objWbemQualifier);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("1A388F98-D4BA-11D1-8B09-00600806D9B6")
interface ISWbemProperty : IDispatch
{
    HRESULT get_Value(VARIANT* varValue);
    HRESULT put_Value(VARIANT* varValue);
    HRESULT get_Name(BSTR* strName);
    HRESULT get_IsLocal(short* bIsLocal);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_CIMType(WbemCimtypeEnum* iCimType);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
    HRESULT get_IsArray(short* bIsArray);
}

@GUID("DEA0A7B2-D4BA-11D1-8B09-00600806D9B6")
interface ISWbemPropertySet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemProperty* objWbemProperty);
    HRESULT get_Count(int* iCount);
    HRESULT Add(BSTR strName, WbemCimtypeEnum iCIMType, short bIsArray, int iFlags, 
                ISWbemProperty* objWbemProperty);
    HRESULT Remove(BSTR strName, int iFlags);
}

@GUID("422E8E90-D955-11D1-8B09-00600806D9B6")
interface ISWbemMethod : IDispatch
{
    HRESULT get_Name(BSTR* strName);
    HRESULT get_Origin(BSTR* strOrigin);
    HRESULT get_InParameters(ISWbemObject* objWbemInParameters);
    HRESULT get_OutParameters(ISWbemObject* objWbemOutParameters);
    HRESULT get_Qualifiers_(ISWbemQualifierSet* objWbemQualifierSet);
}

@GUID("C93BA292-D955-11D1-8B09-00600806D9B6")
interface ISWbemMethodSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(BSTR strName, int iFlags, ISWbemMethod* objWbemMethod);
    HRESULT get_Count(int* iCount);
}

@GUID("27D54D92-0EBE-11D2-8B22-00600806D9B6")
interface ISWbemEventSource : IDispatch
{
    HRESULT NextEvent(int iTimeoutMs, ISWbemObject* objWbemObject);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
}

@GUID("5791BC27-CE9C-11D1-97BF-0000F81E849C")
interface ISWbemObjectPath : IDispatch
{
    HRESULT get_Path(BSTR* strPath);
    HRESULT put_Path(BSTR strPath);
    HRESULT get_RelPath(BSTR* strRelPath);
    HRESULT put_RelPath(BSTR strRelPath);
    HRESULT get_Server(BSTR* strServer);
    HRESULT put_Server(BSTR strServer);
    HRESULT get_Namespace(BSTR* strNamespace);
    HRESULT put_Namespace(BSTR strNamespace);
    HRESULT get_ParentNamespace(BSTR* strParentNamespace);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT put_DisplayName(BSTR strDisplayName);
    HRESULT get_Class(BSTR* strClass);
    HRESULT put_Class(BSTR strClass);
    HRESULT get_IsClass(short* bIsClass);
    HRESULT SetAsClass();
    HRESULT get_IsSingleton(short* bIsSingleton);
    HRESULT SetAsSingleton();
    HRESULT get_Keys(ISWbemNamedValueSet* objWbemNamedValueSet);
    HRESULT get_Security_(ISWbemSecurity* objWbemSecurity);
    HRESULT get_Locale(BSTR* strLocale);
    HRESULT put_Locale(BSTR strLocale);
    HRESULT get_Authority(BSTR* strAuthority);
    HRESULT put_Authority(BSTR strAuthority);
}

@GUID("D962DB84-D4BB-11D1-8B09-00600806D9B6")
interface ISWbemLastError : ISWbemObject
{
}

@GUID("75718CA0-F029-11D1-A1AC-00C04FB6C223")
interface ISWbemSinkEvents : IDispatch
{
}

@GUID("75718C9F-F029-11D1-A1AC-00C04FB6C223")
interface ISWbemSink : IDispatch
{
    HRESULT Cancel();
}

@GUID("B54D66E6-2287-11D2-8B33-00600806D9B6")
interface ISWbemSecurity : IDispatch
{
    HRESULT get_ImpersonationLevel(WbemImpersonationLevelEnum* iImpersonationLevel);
    HRESULT put_ImpersonationLevel(WbemImpersonationLevelEnum iImpersonationLevel);
    HRESULT get_AuthenticationLevel(WbemAuthenticationLevelEnum* iAuthenticationLevel);
    HRESULT put_AuthenticationLevel(WbemAuthenticationLevelEnum iAuthenticationLevel);
    HRESULT get_Privileges(ISWbemPrivilegeSet* objWbemPrivilegeSet);
}

@GUID("26EE67BD-5804-11D2-8B4A-00600806D9B6")
interface ISWbemPrivilege : IDispatch
{
    HRESULT get_IsEnabled(short* bIsEnabled);
    HRESULT put_IsEnabled(short bIsEnabled);
    HRESULT get_Name(BSTR* strDisplayName);
    HRESULT get_DisplayName(BSTR* strDisplayName);
    HRESULT get_Identifier(WbemPrivilegeEnum* iPrivilege);
}

@GUID("26EE67BF-5804-11D2-8B4A-00600806D9B6")
interface ISWbemPrivilegeSet : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(WbemPrivilegeEnum iPrivilege, ISWbemPrivilege* objWbemPrivilege);
    HRESULT get_Count(int* iCount);
    HRESULT Add(WbemPrivilegeEnum iPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
    HRESULT Remove(WbemPrivilegeEnum iPrivilege);
    HRESULT DeleteAll();
    HRESULT AddAsString(BSTR strPrivilege, short bIsEnabled, ISWbemPrivilege* objWbemPrivilege);
}

@GUID("D2F68443-85DC-427E-91D8-366554CC754C")
interface ISWbemServicesEx : ISWbemServices
{
    HRESULT Put(ISWbemObjectEx objWbemObject, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemObjectPath* objWbemObjectPath);
    HRESULT PutAsync(ISWbemSink objWbemSink, ISWbemObjectEx objWbemObject, int iFlags, 
                     IDispatch objWbemNamedValueSet, IDispatch objWbemAsyncContext);
}

@GUID("269AD56A-8A67-4129-BC8C-0506DCFE9880")
interface ISWbemObjectEx : ISWbemObject
{
    HRESULT Refresh_(int iFlags, IDispatch objWbemNamedValueSet);
    HRESULT get_SystemProperties_(ISWbemPropertySet* objWbemPropertySet);
    HRESULT GetText_(WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, IDispatch objWbemNamedValueSet, 
                     BSTR* bsText);
    HRESULT SetFromText_(BSTR bsText, WbemObjectTextFormatEnum iObjectTextFormat, int iFlags, 
                         IDispatch objWbemNamedValueSet);
}

@GUID("5E97458A-CF77-11D3-B38F-00105A1F473A")
interface ISWbemDateTime : IDispatch
{
    HRESULT get_Value(BSTR* strValue);
    HRESULT put_Value(BSTR strValue);
    HRESULT get_Year(int* iYear);
    HRESULT put_Year(int iYear);
    HRESULT get_YearSpecified(short* bYearSpecified);
    HRESULT put_YearSpecified(short bYearSpecified);
    HRESULT get_Month(int* iMonth);
    HRESULT put_Month(int iMonth);
    HRESULT get_MonthSpecified(short* bMonthSpecified);
    HRESULT put_MonthSpecified(short bMonthSpecified);
    HRESULT get_Day(int* iDay);
    HRESULT put_Day(int iDay);
    HRESULT get_DaySpecified(short* bDaySpecified);
    HRESULT put_DaySpecified(short bDaySpecified);
    HRESULT get_Hours(int* iHours);
    HRESULT put_Hours(int iHours);
    HRESULT get_HoursSpecified(short* bHoursSpecified);
    HRESULT put_HoursSpecified(short bHoursSpecified);
    HRESULT get_Minutes(int* iMinutes);
    HRESULT put_Minutes(int iMinutes);
    HRESULT get_MinutesSpecified(short* bMinutesSpecified);
    HRESULT put_MinutesSpecified(short bMinutesSpecified);
    HRESULT get_Seconds(int* iSeconds);
    HRESULT put_Seconds(int iSeconds);
    HRESULT get_SecondsSpecified(short* bSecondsSpecified);
    HRESULT put_SecondsSpecified(short bSecondsSpecified);
    HRESULT get_Microseconds(int* iMicroseconds);
    HRESULT put_Microseconds(int iMicroseconds);
    HRESULT get_MicrosecondsSpecified(short* bMicrosecondsSpecified);
    HRESULT put_MicrosecondsSpecified(short bMicrosecondsSpecified);
    HRESULT get_UTC(int* iUTC);
    HRESULT put_UTC(int iUTC);
    HRESULT get_UTCSpecified(short* bUTCSpecified);
    HRESULT put_UTCSpecified(short bUTCSpecified);
    HRESULT get_IsInterval(short* bIsInterval);
    HRESULT put_IsInterval(short bIsInterval);
    HRESULT GetVarDate(short bIsLocal, double* dVarDate);
    HRESULT SetVarDate(double dVarDate, short bIsLocal);
    HRESULT GetFileTime(short bIsLocal, BSTR* strFileTime);
    HRESULT SetFileTime(BSTR strFileTime, short bIsLocal);
}

@GUID("14D8250E-D9C2-11D3-B38F-00105A1F473A")
interface ISWbemRefresher : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pUnk);
    HRESULT Item(int iIndex, ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT get_Count(int* iCount);
    HRESULT Add(ISWbemServicesEx objWbemServices, BSTR bsInstancePath, int iFlags, IDispatch objWbemNamedValueSet, 
                ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT AddEnum(ISWbemServicesEx objWbemServices, BSTR bsClassName, int iFlags, IDispatch objWbemNamedValueSet, 
                    ISWbemRefreshableItem* objWbemRefreshableItem);
    HRESULT Remove(int iIndex, int iFlags);
    HRESULT Refresh(int iFlags);
    HRESULT get_AutoReconnect(short* bCount);
    HRESULT put_AutoReconnect(short bCount);
    HRESULT DeleteAll();
}

@GUID("5AD4BF92-DAAB-11D3-B38F-00105A1F473A")
interface ISWbemRefreshableItem : IDispatch
{
    HRESULT get_Index(int* iIndex);
    HRESULT get_Refresher(ISWbemRefresher* objWbemRefresher);
    HRESULT get_IsSet(short* bIsSet);
    HRESULT get_Object(ISWbemObjectEx* objWbemObject);
    HRESULT get_ObjectSet(ISWbemObjectSet* objWbemObjectSet);
    HRESULT Remove(int iFlags);
}


// GUIDs

const GUID CLSID_MofCompiler                     = GUIDOF!MofCompiler;
const GUID CLSID_SWbemDateTime                   = GUIDOF!SWbemDateTime;
const GUID CLSID_SWbemEventSource                = GUIDOF!SWbemEventSource;
const GUID CLSID_SWbemLastError                  = GUIDOF!SWbemLastError;
const GUID CLSID_SWbemLocator                    = GUIDOF!SWbemLocator;
const GUID CLSID_SWbemMethod                     = GUIDOF!SWbemMethod;
const GUID CLSID_SWbemMethodSet                  = GUIDOF!SWbemMethodSet;
const GUID CLSID_SWbemNamedValue                 = GUIDOF!SWbemNamedValue;
const GUID CLSID_SWbemNamedValueSet              = GUIDOF!SWbemNamedValueSet;
const GUID CLSID_SWbemObject                     = GUIDOF!SWbemObject;
const GUID CLSID_SWbemObjectEx                   = GUIDOF!SWbemObjectEx;
const GUID CLSID_SWbemObjectPath                 = GUIDOF!SWbemObjectPath;
const GUID CLSID_SWbemObjectSet                  = GUIDOF!SWbemObjectSet;
const GUID CLSID_SWbemPrivilege                  = GUIDOF!SWbemPrivilege;
const GUID CLSID_SWbemPrivilegeSet               = GUIDOF!SWbemPrivilegeSet;
const GUID CLSID_SWbemProperty                   = GUIDOF!SWbemProperty;
const GUID CLSID_SWbemPropertySet                = GUIDOF!SWbemPropertySet;
const GUID CLSID_SWbemQualifier                  = GUIDOF!SWbemQualifier;
const GUID CLSID_SWbemQualifierSet               = GUIDOF!SWbemQualifierSet;
const GUID CLSID_SWbemRefreshableItem            = GUIDOF!SWbemRefreshableItem;
const GUID CLSID_SWbemRefresher                  = GUIDOF!SWbemRefresher;
const GUID CLSID_SWbemSecurity                   = GUIDOF!SWbemSecurity;
const GUID CLSID_SWbemServices                   = GUIDOF!SWbemServices;
const GUID CLSID_SWbemServicesEx                 = GUIDOF!SWbemServicesEx;
const GUID CLSID_SWbemSink                       = GUIDOF!SWbemSink;
const GUID CLSID_UnsecuredApartment              = GUIDOF!UnsecuredApartment;
const GUID CLSID_WbemAdministrativeLocator       = GUIDOF!WbemAdministrativeLocator;
const GUID CLSID_WbemAuthenticatedLocator        = GUIDOF!WbemAuthenticatedLocator;
const GUID CLSID_WbemBackupRestore               = GUIDOF!WbemBackupRestore;
const GUID CLSID_WbemClassObject                 = GUIDOF!WbemClassObject;
const GUID CLSID_WbemContext                     = GUIDOF!WbemContext;
const GUID CLSID_WbemDecoupledBasicEventProvider = GUIDOF!WbemDecoupledBasicEventProvider;
const GUID CLSID_WbemDecoupledRegistrar          = GUIDOF!WbemDecoupledRegistrar;
const GUID CLSID_WbemDefPath                     = GUIDOF!WbemDefPath;
const GUID CLSID_WbemLocator                     = GUIDOF!WbemLocator;
const GUID CLSID_WbemObjectTextSrc               = GUIDOF!WbemObjectTextSrc;
const GUID CLSID_WbemQuery                       = GUIDOF!WbemQuery;
const GUID CLSID_WbemRefresher                   = GUIDOF!WbemRefresher;
const GUID CLSID_WbemStatusCodeText              = GUIDOF!WbemStatusCodeText;
const GUID CLSID_WbemUnauthenticatedLocator      = GUIDOF!WbemUnauthenticatedLocator;

const GUID IID_IEnumWbemClassObject             = GUIDOF!IEnumWbemClassObject;
const GUID IID_IMofCompiler                     = GUIDOF!IMofCompiler;
const GUID IID_ISWbemDateTime                   = GUIDOF!ISWbemDateTime;
const GUID IID_ISWbemEventSource                = GUIDOF!ISWbemEventSource;
const GUID IID_ISWbemLastError                  = GUIDOF!ISWbemLastError;
const GUID IID_ISWbemLocator                    = GUIDOF!ISWbemLocator;
const GUID IID_ISWbemMethod                     = GUIDOF!ISWbemMethod;
const GUID IID_ISWbemMethodSet                  = GUIDOF!ISWbemMethodSet;
const GUID IID_ISWbemNamedValue                 = GUIDOF!ISWbemNamedValue;
const GUID IID_ISWbemNamedValueSet              = GUIDOF!ISWbemNamedValueSet;
const GUID IID_ISWbemObject                     = GUIDOF!ISWbemObject;
const GUID IID_ISWbemObjectEx                   = GUIDOF!ISWbemObjectEx;
const GUID IID_ISWbemObjectPath                 = GUIDOF!ISWbemObjectPath;
const GUID IID_ISWbemObjectSet                  = GUIDOF!ISWbemObjectSet;
const GUID IID_ISWbemPrivilege                  = GUIDOF!ISWbemPrivilege;
const GUID IID_ISWbemPrivilegeSet               = GUIDOF!ISWbemPrivilegeSet;
const GUID IID_ISWbemProperty                   = GUIDOF!ISWbemProperty;
const GUID IID_ISWbemPropertySet                = GUIDOF!ISWbemPropertySet;
const GUID IID_ISWbemQualifier                  = GUIDOF!ISWbemQualifier;
const GUID IID_ISWbemQualifierSet               = GUIDOF!ISWbemQualifierSet;
const GUID IID_ISWbemRefreshableItem            = GUIDOF!ISWbemRefreshableItem;
const GUID IID_ISWbemRefresher                  = GUIDOF!ISWbemRefresher;
const GUID IID_ISWbemSecurity                   = GUIDOF!ISWbemSecurity;
const GUID IID_ISWbemServices                   = GUIDOF!ISWbemServices;
const GUID IID_ISWbemServicesEx                 = GUIDOF!ISWbemServicesEx;
const GUID IID_ISWbemSink                       = GUIDOF!ISWbemSink;
const GUID IID_ISWbemSinkEvents                 = GUIDOF!ISWbemSinkEvents;
const GUID IID_IUnsecuredApartment              = GUIDOF!IUnsecuredApartment;
const GUID IID_IWbemBackupRestore               = GUIDOF!IWbemBackupRestore;
const GUID IID_IWbemBackupRestoreEx             = GUIDOF!IWbemBackupRestoreEx;
const GUID IID_IWbemCallResult                  = GUIDOF!IWbemCallResult;
const GUID IID_IWbemClassObject                 = GUIDOF!IWbemClassObject;
const GUID IID_IWbemConfigureRefresher          = GUIDOF!IWbemConfigureRefresher;
const GUID IID_IWbemContext                     = GUIDOF!IWbemContext;
const GUID IID_IWbemDecoupledBasicEventProvider = GUIDOF!IWbemDecoupledBasicEventProvider;
const GUID IID_IWbemDecoupledRegistrar          = GUIDOF!IWbemDecoupledRegistrar;
const GUID IID_IWbemEventConsumerProvider       = GUIDOF!IWbemEventConsumerProvider;
const GUID IID_IWbemEventProvider               = GUIDOF!IWbemEventProvider;
const GUID IID_IWbemEventProviderQuerySink      = GUIDOF!IWbemEventProviderQuerySink;
const GUID IID_IWbemEventProviderSecurity       = GUIDOF!IWbemEventProviderSecurity;
const GUID IID_IWbemEventSink                   = GUIDOF!IWbemEventSink;
const GUID IID_IWbemHiPerfEnum                  = GUIDOF!IWbemHiPerfEnum;
const GUID IID_IWbemHiPerfProvider              = GUIDOF!IWbemHiPerfProvider;
const GUID IID_IWbemLocator                     = GUIDOF!IWbemLocator;
const GUID IID_IWbemObjectAccess                = GUIDOF!IWbemObjectAccess;
const GUID IID_IWbemObjectSink                  = GUIDOF!IWbemObjectSink;
const GUID IID_IWbemObjectSinkEx                = GUIDOF!IWbemObjectSinkEx;
const GUID IID_IWbemObjectTextSrc               = GUIDOF!IWbemObjectTextSrc;
const GUID IID_IWbemPath                        = GUIDOF!IWbemPath;
const GUID IID_IWbemPathKeyList                 = GUIDOF!IWbemPathKeyList;
const GUID IID_IWbemPropertyProvider            = GUIDOF!IWbemPropertyProvider;
const GUID IID_IWbemProviderIdentity            = GUIDOF!IWbemProviderIdentity;
const GUID IID_IWbemProviderInit                = GUIDOF!IWbemProviderInit;
const GUID IID_IWbemProviderInitSink            = GUIDOF!IWbemProviderInitSink;
const GUID IID_IWbemQualifierSet                = GUIDOF!IWbemQualifierSet;
const GUID IID_IWbemQuery                       = GUIDOF!IWbemQuery;
const GUID IID_IWbemRefresher                   = GUIDOF!IWbemRefresher;
const GUID IID_IWbemServices                    = GUIDOF!IWbemServices;
const GUID IID_IWbemShutdown                    = GUIDOF!IWbemShutdown;
const GUID IID_IWbemStatusCodeText              = GUIDOF!IWbemStatusCodeText;
const GUID IID_IWbemUnboundObjectSink           = GUIDOF!IWbemUnboundObjectSink;
const GUID IID_IWbemUnsecuredApartment          = GUIDOF!IWbemUnsecuredApartment;
