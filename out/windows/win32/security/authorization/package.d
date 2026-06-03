// Written in the D programming language.

module windows.win32.security.authorization;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, HANDLE, HRESULT, HWND, LUID,
                                         PSTR, PWSTR, VARIANT_BOOL, WIN32_ERROR;
public import windows.win32.security : ACE_FLAGS, ACE_HEADER, ACL, GENERIC_MAPPING,
                                       OBJECT_SECURITY_INFORMATION, OBJECT_TYPE_LIST,
                                       PSECURITY_DESCRIPTOR, PSID, SID,
                                       SID_AND_ATTRIBUTES, SYSTEM_AUDIT_OBJECT_ACE_FLAGS,
                                       TOKEN_GROUPS;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE;
public import windows.win32.system.variant : VARIANT;

extern(Windows) @nogc nothrow:


// Enums


alias AUTHZ_RESOURCE_MANAGER_FLAGS = uint;
enum : uint
{
    AUTHZ_RM_FLAG_NO_AUDIT                       = 0x00000001U,
    AUTHZ_RM_FLAG_INITIALIZE_UNDER_IMPERSONATION = 0x00000002U,
    AUTHZ_RM_FLAG_NO_CENTRAL_ACCESS_POLICIES     = 0x00000004U,
}

alias AUTHZ_ACCESS_CHECK_FLAGS = uint;
enum : uint
{
    AUTHZ_ACCESS_CHECK_NO_DEEP_COPY_SD = 0x00000001U,
}

alias AUTHZ_INITIALIZE_OBJECT_ACCESS_AUDIT_EVENT_FLAGS = uint;
enum : uint
{
    AUTHZ_NO_SUCCESS_AUDIT = 0x00000001U,
    AUTHZ_NO_FAILURE_AUDIT = 0x00000002U,
    AUTHZ_NO_ALLOC_STRINGS = 0x00000004U,
}

alias TREE_SEC_INFO = uint;
enum : uint
{
    TREE_SEC_INFO_SET                 = 0x00000001U,
    TREE_SEC_INFO_RESET               = 0x00000002U,
    TREE_SEC_INFO_RESET_KEEP_EXPLICIT = 0x00000003U,
}

alias AUTHZ_GENERATE_RESULTS = uint;
enum : uint
{
    AUTHZ_GENERATE_SUCCESS_AUDIT = 0x00000001U,
    AUTHZ_GENERATE_FAILURE_AUDIT = 0x00000002U,
}

alias ACTRL_ACCESS_ENTRY_ACCESS_FLAGS = uint;
enum : uint
{
    ACTRL_ACCESS_ALLOWED = 0x00000001U,
    ACTRL_ACCESS_DENIED  = 0x00000002U,
    ACTRL_AUDIT_SUCCESS  = 0x00000004U,
    ACTRL_AUDIT_FAILURE  = 0x00000008U,
}

alias AUTHZ_SECURITY_ATTRIBUTE_FLAGS = uint;
enum : uint
{
    AUTHZ_SECURITY_ATTRIBUTE_NON_INHERITABLE      = 0x00000001U,
    AUTHZ_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE = 0x00000002U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-se_object_type
alias SE_OBJECT_TYPE = int;
enum : int
{
    SE_UNKNOWN_OBJECT_TYPE     = 0x00000000,
    SE_FILE_OBJECT             = 0x00000001,
    SE_SERVICE                 = 0x00000002,
    SE_PRINTER                 = 0x00000003,
    SE_REGISTRY_KEY            = 0x00000004,
    SE_LMSHARE                 = 0x00000005,
    SE_KERNEL_OBJECT           = 0x00000006,
    SE_WINDOW_OBJECT           = 0x00000007,
    SE_DS_OBJECT               = 0x00000008,
    SE_DS_OBJECT_ALL           = 0x00000009,
    SE_PROVIDER_DEFINED_OBJECT = 0x0000000a,
    SE_WMIGUID_OBJECT          = 0x0000000b,
    SE_REGISTRY_WOW64_32KEY    = 0x0000000c,
    SE_REGISTRY_WOW64_64KEY    = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-trustee_type
alias TRUSTEE_TYPE = int;
enum : int
{
    TRUSTEE_IS_UNKNOWN          = 0x00000000,
    TRUSTEE_IS_USER             = 0x00000001,
    TRUSTEE_IS_GROUP            = 0x00000002,
    TRUSTEE_IS_DOMAIN           = 0x00000003,
    TRUSTEE_IS_ALIAS            = 0x00000004,
    TRUSTEE_IS_WELL_KNOWN_GROUP = 0x00000005,
    TRUSTEE_IS_DELETED          = 0x00000006,
    TRUSTEE_IS_INVALID          = 0x00000007,
    TRUSTEE_IS_COMPUTER         = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-trustee_form
alias TRUSTEE_FORM = int;
enum : int
{
    TRUSTEE_IS_SID              = 0x00000000,
    TRUSTEE_IS_NAME             = 0x00000001,
    TRUSTEE_BAD_FORM            = 0x00000002,
    TRUSTEE_IS_OBJECTS_AND_SID  = 0x00000003,
    TRUSTEE_IS_OBJECTS_AND_NAME = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-multiple_trustee_operation
alias MULTIPLE_TRUSTEE_OPERATION = int;
enum : int
{
    NO_MULTIPLE_TRUSTEE    = 0x00000000,
    TRUSTEE_IS_IMPERSONATE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-access_mode
alias ACCESS_MODE = int;
enum : int
{
    NOT_USED_ACCESS   = 0x00000000,
    GRANT_ACCESS      = 0x00000001,
    SET_ACCESS        = 0x00000002,
    DENY_ACCESS       = 0x00000003,
    REVOKE_ACCESS     = 0x00000004,
    SET_AUDIT_SUCCESS = 0x00000005,
    SET_AUDIT_FAILURE = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ne-accctrl-prog_invoke_setting
alias PROG_INVOKE_SETTING = int;
enum : int
{
    ProgressInvokeNever        = 0x00000001,
    ProgressInvokeEveryObject  = 0x00000002,
    ProgressInvokeOnError      = 0x00000003,
    ProgressCancelOperation    = 0x00000004,
    ProgressRetryOperation     = 0x00000005,
    ProgressInvokePrePostError = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/adtgen/ne-adtgen-audit_param_type
alias AUDIT_PARAM_TYPE = int;
enum : int
{
    APT_None           = 0x00000001,
    APT_String         = 0x00000002,
    APT_Ulong          = 0x00000003,
    APT_Pointer        = 0x00000004,
    APT_Sid            = 0x00000005,
    APT_LogonId        = 0x00000006,
    APT_ObjectTypeList = 0x00000007,
    APT_Luid           = 0x00000008,
    APT_Guid           = 0x00000009,
    APT_Time           = 0x0000000a,
    APT_Int64          = 0x0000000b,
    APT_IpAddress      = 0x0000000c,
    APT_LogonIdWithSid = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ne-authz-authz_security_attribute_operation
alias AUTHZ_SECURITY_ATTRIBUTE_OPERATION = int;
enum : int
{
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE        = 0x00000000,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL = 0x00000001,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD         = 0x00000002,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE      = 0x00000003,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ne-authz-authz_sid_operation
alias AUTHZ_SID_OPERATION = int;
enum : int
{
    AUTHZ_SID_OPERATION_NONE        = 0x00000000,
    AUTHZ_SID_OPERATION_REPLACE_ALL = 0x00000001,
    AUTHZ_SID_OPERATION_ADD         = 0x00000002,
    AUTHZ_SID_OPERATION_DELETE      = 0x00000003,
    AUTHZ_SID_OPERATION_REPLACE     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ne-authz-authz_context_information_class
alias AUTHZ_CONTEXT_INFORMATION_CLASS = int;
enum : int
{
    AuthzContextInfoUserSid            = 0x00000001,
    AuthzContextInfoGroupsSids         = 0x00000002,
    AuthzContextInfoRestrictedSids     = 0x00000003,
    AuthzContextInfoPrivileges         = 0x00000004,
    AuthzContextInfoExpirationTime     = 0x00000005,
    AuthzContextInfoServerContext      = 0x00000006,
    AuthzContextInfoIdentifier         = 0x00000007,
    AuthzContextInfoSource             = 0x00000008,
    AuthzContextInfoAll                = 0x00000009,
    AuthzContextInfoAuthenticationId   = 0x0000000a,
    AuthzContextInfoSecurityAttributes = 0x0000000b,
    AuthzContextInfoDeviceSids         = 0x0000000c,
    AuthzContextInfoUserClaims         = 0x0000000d,
    AuthzContextInfoDeviceClaims       = 0x0000000e,
    AuthzContextInfoAppContainerSid    = 0x0000000f,
    AuthzContextInfoCapabilitySids     = 0x00000010,
}

alias AUTHZ_AUDIT_EVENT_INFORMATION_CLASS = int;
enum : int
{
    AuthzAuditEventInfoFlags          = 0x00000001,
    AuthzAuditEventInfoOperationType  = 0x00000002,
    AuthzAuditEventInfoObjectType     = 0x00000003,
    AuthzAuditEventInfoObjectName     = 0x00000004,
    AuthzAuditEventInfoAdditionalInfo = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/ne-azroles-az_prop_constants
alias AZ_PROP_CONSTANTS = int;
enum : int
{
    AZ_PROP_NAME                                  = 0x00000001,
    AZ_PROP_DESCRIPTION                           = 0x00000002,
    AZ_PROP_WRITABLE                              = 0x00000003,
    AZ_PROP_APPLICATION_DATA                      = 0x00000004,
    AZ_PROP_CHILD_CREATE                          = 0x00000005,
    AZ_MAX_APPLICATION_NAME_LENGTH                = 0x00000200,
    AZ_MAX_OPERATION_NAME_LENGTH                  = 0x00000040,
    AZ_MAX_TASK_NAME_LENGTH                       = 0x00000040,
    AZ_MAX_SCOPE_NAME_LENGTH                      = 0x00010000,
    AZ_MAX_GROUP_NAME_LENGTH                      = 0x00000040,
    AZ_MAX_ROLE_NAME_LENGTH                       = 0x00000040,
    AZ_MAX_NAME_LENGTH                            = 0x00010000,
    AZ_MAX_DESCRIPTION_LENGTH                     = 0x00000400,
    AZ_MAX_APPLICATION_DATA_LENGTH                = 0x00001000,
    AZ_SUBMIT_FLAG_ABORT                          = 0x00000001,
    AZ_SUBMIT_FLAG_FLUSH                          = 0x00000002,
    AZ_MAX_POLICY_URL_LENGTH                      = 0x00010000,
    AZ_AZSTORE_FLAG_CREATE                        = 0x00000001,
    AZ_AZSTORE_FLAG_MANAGE_STORE_ONLY             = 0x00000002,
    AZ_AZSTORE_FLAG_BATCH_UPDATE                  = 0x00000004,
    AZ_AZSTORE_FLAG_AUDIT_IS_CRITICAL             = 0x00000008,
    AZ_AZSTORE_FORCE_APPLICATION_CLOSE            = 0x00000010,
    AZ_AZSTORE_NT6_FUNCTION_LEVEL                 = 0x00000020,
    AZ_AZSTORE_FLAG_MANAGE_ONLY_PASSIVE_SUBMIT    = 0x00008000,
    AZ_PROP_AZSTORE_DOMAIN_TIMEOUT                = 0x00000064,
    AZ_AZSTORE_DEFAULT_DOMAIN_TIMEOUT             = 0x00003a98,
    AZ_PROP_AZSTORE_SCRIPT_ENGINE_TIMEOUT         = 0x00000065,
    AZ_AZSTORE_MIN_DOMAIN_TIMEOUT                 = 0x000001f4,
    AZ_AZSTORE_MIN_SCRIPT_ENGINE_TIMEOUT          = 0x00001388,
    AZ_AZSTORE_DEFAULT_SCRIPT_ENGINE_TIMEOUT      = 0x0000afc8,
    AZ_PROP_AZSTORE_MAX_SCRIPT_ENGINES            = 0x00000066,
    AZ_AZSTORE_DEFAULT_MAX_SCRIPT_ENGINES         = 0x00000078,
    AZ_PROP_AZSTORE_MAJOR_VERSION                 = 0x00000067,
    AZ_PROP_AZSTORE_MINOR_VERSION                 = 0x00000068,
    AZ_PROP_AZSTORE_TARGET_MACHINE                = 0x00000069,
    AZ_PROP_AZTORE_IS_ADAM_INSTANCE               = 0x0000006a,
    AZ_PROP_OPERATION_ID                          = 0x000000c8,
    AZ_PROP_TASK_OPERATIONS                       = 0x0000012c,
    AZ_PROP_TASK_BIZRULE                          = 0x0000012d,
    AZ_PROP_TASK_BIZRULE_LANGUAGE                 = 0x0000012e,
    AZ_PROP_TASK_TASKS                            = 0x0000012f,
    AZ_PROP_TASK_BIZRULE_IMPORTED_PATH            = 0x00000130,
    AZ_PROP_TASK_IS_ROLE_DEFINITION               = 0x00000131,
    AZ_MAX_TASK_BIZRULE_LENGTH                    = 0x00010000,
    AZ_MAX_TASK_BIZRULE_LANGUAGE_LENGTH           = 0x00000040,
    AZ_MAX_TASK_BIZRULE_IMPORTED_PATH_LENGTH      = 0x00000200,
    AZ_MAX_BIZRULE_STRING                         = 0x00010000,
    AZ_PROP_GROUP_TYPE                            = 0x00000190,
    AZ_GROUPTYPE_LDAP_QUERY                       = 0x00000001,
    AZ_GROUPTYPE_BASIC                            = 0x00000002,
    AZ_GROUPTYPE_BIZRULE                          = 0x00000003,
    AZ_PROP_GROUP_APP_MEMBERS                     = 0x00000191,
    AZ_PROP_GROUP_APP_NON_MEMBERS                 = 0x00000192,
    AZ_PROP_GROUP_LDAP_QUERY                      = 0x00000193,
    AZ_MAX_GROUP_LDAP_QUERY_LENGTH                = 0x00001000,
    AZ_PROP_GROUP_MEMBERS                         = 0x00000194,
    AZ_PROP_GROUP_NON_MEMBERS                     = 0x00000195,
    AZ_PROP_GROUP_MEMBERS_NAME                    = 0x00000196,
    AZ_PROP_GROUP_NON_MEMBERS_NAME                = 0x00000197,
    AZ_PROP_GROUP_BIZRULE                         = 0x00000198,
    AZ_PROP_GROUP_BIZRULE_LANGUAGE                = 0x00000199,
    AZ_PROP_GROUP_BIZRULE_IMPORTED_PATH           = 0x0000019a,
    AZ_MAX_GROUP_BIZRULE_LENGTH                   = 0x00010000,
    AZ_MAX_GROUP_BIZRULE_LANGUAGE_LENGTH          = 0x00000040,
    AZ_MAX_GROUP_BIZRULE_IMPORTED_PATH_LENGTH     = 0x00000200,
    AZ_PROP_ROLE_APP_MEMBERS                      = 0x000001f4,
    AZ_PROP_ROLE_MEMBERS                          = 0x000001f5,
    AZ_PROP_ROLE_OPERATIONS                       = 0x000001f6,
    AZ_PROP_ROLE_TASKS                            = 0x000001f8,
    AZ_PROP_ROLE_MEMBERS_NAME                     = 0x000001f9,
    AZ_PROP_SCOPE_BIZRULES_WRITABLE               = 0x00000258,
    AZ_PROP_SCOPE_CAN_BE_DELEGATED                = 0x00000259,
    AZ_PROP_CLIENT_CONTEXT_USER_DN                = 0x000002bc,
    AZ_PROP_CLIENT_CONTEXT_USER_SAM_COMPAT        = 0x000002bd,
    AZ_PROP_CLIENT_CONTEXT_USER_DISPLAY           = 0x000002be,
    AZ_PROP_CLIENT_CONTEXT_USER_GUID              = 0x000002bf,
    AZ_PROP_CLIENT_CONTEXT_USER_CANONICAL         = 0x000002c0,
    AZ_PROP_CLIENT_CONTEXT_USER_UPN               = 0x000002c1,
    AZ_PROP_CLIENT_CONTEXT_USER_DNS_SAM_COMPAT    = 0x000002c3,
    AZ_PROP_CLIENT_CONTEXT_ROLE_FOR_ACCESS_CHECK  = 0x000002c4,
    AZ_PROP_CLIENT_CONTEXT_LDAP_QUERY_DN          = 0x000002c5,
    AZ_PROP_APPLICATION_AUTHZ_INTERFACE_CLSID     = 0x00000320,
    AZ_PROP_APPLICATION_VERSION                   = 0x00000321,
    AZ_MAX_APPLICATION_VERSION_LENGTH             = 0x00000200,
    AZ_PROP_APPLICATION_NAME                      = 0x00000322,
    AZ_PROP_APPLICATION_BIZRULE_ENABLED           = 0x00000323,
    AZ_PROP_APPLY_STORE_SACL                      = 0x00000384,
    AZ_PROP_GENERATE_AUDITS                       = 0x00000385,
    AZ_PROP_POLICY_ADMINS                         = 0x00000386,
    AZ_PROP_POLICY_READERS                        = 0x00000387,
    AZ_PROP_DELEGATED_POLICY_USERS                = 0x00000388,
    AZ_PROP_POLICY_ADMINS_NAME                    = 0x00000389,
    AZ_PROP_POLICY_READERS_NAME                   = 0x0000038a,
    AZ_PROP_DELEGATED_POLICY_USERS_NAME           = 0x0000038b,
    AZ_CLIENT_CONTEXT_SKIP_GROUP                  = 0x00000001,
    AZ_CLIENT_CONTEXT_SKIP_LDAP_QUERY             = 0x00000001,
    AZ_CLIENT_CONTEXT_GET_GROUP_RECURSIVE         = 0x00000002,
    AZ_CLIENT_CONTEXT_GET_GROUPS_STORE_LEVEL_ONLY = 0x00000002,
}

// Constants


enum : uint
{
    SDDL_REVISION_1 = 0x00000001U,
    SDDL_REVISION   = 0x00000001U,
}

enum : const(wchar)*
{
    SDDL_OWNER     = "O",
    SDDL_GROUP     = "G",
    SDDL_DACL      = "D",
    SDDL_SACL      = "S",
    SDDL_PROTECTED = "P",
}

enum : const(wchar)*
{
    SDDL_AUTO_INHERIT_REQ = "AR",
    SDDL_AUTO_INHERITED   = "AI",
}

enum const(wchar)* SDDL_NULL_ACL = "NO_ACCESS_CONTROL";

enum : const(wchar)*
{
    SDDL_ACCESS_ALLOWED = "A",
    SDDL_ACCESS_DENIED  = "D",
}

enum : const(wchar)*
{
    SDDL_OBJECT_ACCESS_ALLOWED = "OA",
    SDDL_OBJECT_ACCESS_DENIED  = "OD",
}

enum : const(wchar)*
{
    SDDL_AUDIT        = "AU",
    SDDL_ALARM        = "AL",
    SDDL_OBJECT_AUDIT = "OU",
    SDDL_OBJECT_ALARM = "OL",
}

enum const(wchar)* SDDL_MANDATORY_LABEL = "ML";
enum const(wchar)* SDDL_PROCESS_TRUST_LABEL = "TL";

enum : const(wchar)*
{
    SDDL_CALLBACK_ACCESS_ALLOWED = "XA",
    SDDL_CALLBACK_ACCESS_DENIED  = "XD",
}

enum const(wchar)* SDDL_RESOURCE_ATTRIBUTE = "RA";
enum const(wchar)* SDDL_SCOPED_POLICY_ID = "SP";

enum : const(wchar)*
{
    SDDL_CALLBACK_AUDIT                 = "XU",
    SDDL_CALLBACK_OBJECT_ACCESS_ALLOWED = "ZA",
}

enum const(wchar)* SDDL_ACCESS_FILTER = "FL";

enum : const(wchar)*
{
    SDDL_INT               = "TI",
    SDDL_UINT              = "TU",
    SDDL_WSTRING           = "TS",
    SDDL_SID               = "TD",
    SDDL_BLOB              = "TX",
    SDDL_BOOLEAN           = "TB",
    SDDL_CONTAINER_INHERIT = "CI",
}

enum const(wchar)* SDDL_OBJECT_INHERIT = "OI";
enum const(wchar)* SDDL_NO_PROPAGATE = "NP";

enum : const(wchar)*
{
    SDDL_INHERIT_ONLY = "IO",
    SDDL_INHERITED    = "ID",
}

enum const(wchar)* SDDL_CRITICAL = "CR";
enum const(wchar)* SDDL_TRUST_PROTECTED_FILTER = "TP";

enum : const(wchar)*
{
    SDDL_AUDIT_SUCCESS = "SA",
    SDDL_AUDIT_FAILURE = "FA",
}

enum const(wchar)* SDDL_READ_PROPERTY = "RP";
enum const(wchar)* SDDL_WRITE_PROPERTY = "WP";
enum const(wchar)* SDDL_CREATE_CHILD = "CC";
enum const(wchar)* SDDL_DELETE_CHILD = "DC";
enum const(wchar)* SDDL_LIST_CHILDREN = "LC";
enum const(wchar)* SDDL_SELF_WRITE = "SW";
enum const(wchar)* SDDL_LIST_OBJECT = "LO";
enum const(wchar)* SDDL_DELETE_TREE = "DT";
enum const(wchar)* SDDL_CONTROL_ACCESS = "CR";
enum const(wchar)* SDDL_READ_CONTROL = "RC";

enum : const(wchar)*
{
    SDDL_WRITE_DAC   = "WD",
    SDDL_WRITE_OWNER = "WO",
}

enum const(wchar)* SDDL_STANDARD_DELETE = "SD";

enum : const(wchar)*
{
    SDDL_GENERIC_ALL     = "GA",
    SDDL_GENERIC_READ    = "GR",
    SDDL_GENERIC_WRITE   = "GW",
    SDDL_GENERIC_EXECUTE = "GX",
}

enum : const(wchar)*
{
    SDDL_FILE_ALL     = "FA",
    SDDL_FILE_READ    = "FR",
    SDDL_FILE_WRITE   = "FW",
    SDDL_FILE_EXECUTE = "FX",
}

enum : const(wchar)*
{
    SDDL_KEY_ALL     = "KA",
    SDDL_KEY_READ    = "KR",
    SDDL_KEY_WRITE   = "KW",
    SDDL_KEY_EXECUTE = "KX",
}

enum : const(wchar)*
{
    SDDL_NO_WRITE_UP   = "NW",
    SDDL_NO_READ_UP    = "NR",
    SDDL_NO_EXECUTE_UP = "NX",
}

enum uint SDDL_ALIAS_SIZE = 0x00000002U;

enum : const(wchar)*
{
    SDDL_DOMAIN_ADMINISTRATORS = "DA",
    SDDL_DOMAIN_GUESTS         = "DG",
    SDDL_DOMAIN_USERS          = "DU",
}

enum const(wchar)* SDDL_ENTERPRISE_DOMAIN_CONTROLLERS = "ED";
enum const(wchar)* SDDL_DOMAIN_DOMAIN_CONTROLLERS = "DD";
enum const(wchar)* SDDL_DOMAIN_COMPUTERS = "DC";

enum : const(wchar)*
{
    SDDL_BUILTIN_ADMINISTRATORS = "BA",
    SDDL_BUILTIN_GUESTS         = "BG",
    SDDL_BUILTIN_USERS          = "BU",
}

enum : const(wchar)*
{
    SDDL_LOCAL_ADMIN = "LA",
    SDDL_LOCAL_GUEST = "LG",
}

enum const(wchar)* SDDL_ACCOUNT_OPERATORS = "AO";
enum const(wchar)* SDDL_BACKUP_OPERATORS = "BO";
enum const(wchar)* SDDL_PRINTER_OPERATORS = "PO";
enum const(wchar)* SDDL_SERVER_OPERATORS = "SO";
enum const(wchar)* SDDL_AUTHENTICATED_USERS = "AU";
enum const(wchar)* SDDL_PERSONAL_SELF = "PS";

enum : const(wchar)*
{
    SDDL_CREATOR_OWNER = "CO",
    SDDL_CREATOR_GROUP = "CG",
}

enum const(wchar)* SDDL_LOCAL_SYSTEM = "SY";
enum const(wchar)* SDDL_POWER_USERS = "PU";
enum const(wchar)* SDDL_EVERYONE = "WD";
enum const(wchar)* SDDL_REPLICATOR = "RE";
enum const(wchar)* SDDL_INTERACTIVE = "IU";

enum : const(wchar)*
{
    SDDL_NETWORK         = "NU",
    SDDL_SERVICE         = "SU",
    SDDL_RESTRICTED_CODE = "RC",
}

enum const(wchar)* SDDL_WRITE_RESTRICTED_CODE = "WR";
enum const(wchar)* SDDL_ANONYMOUS = "AN";
enum const(wchar)* SDDL_SCHEMA_ADMINISTRATORS = "SA";
enum const(wchar)* SDDL_CERT_SERV_ADMINISTRATORS = "CA";
enum const(wchar)* SDDL_RAS_SERVERS = "RS";
enum const(wchar)* SDDL_ENTERPRISE_ADMINS = "EA";
enum const(wchar)* SDDL_GROUP_POLICY_ADMINS = "PA";
enum const(wchar)* SDDL_ALIAS_PREW2KCOMPACC = "RU";
enum const(wchar)* SDDL_LOCAL_SERVICE = "LS";
enum const(wchar)* SDDL_NETWORK_SERVICE = "NS";
enum const(wchar)* SDDL_REMOTE_DESKTOP = "RD";
enum const(wchar)* SDDL_NETWORK_CONFIGURATION_OPS = "NO";

enum : const(wchar)*
{
    SDDL_PERFMON_USERS = "MU",
    SDDL_PERFLOG_USERS = "LU",
}

enum const(wchar)* SDDL_IIS_USERS = "IS";
enum const(wchar)* SDDL_CRYPTO_OPERATORS = "CY";
enum const(wchar)* SDDL_OWNER_RIGHTS = "OW";
enum const(wchar)* SDDL_EVENT_LOG_READERS = "ER";
enum const(wchar)* SDDL_ENTERPRISE_RO_DCs = "RO";
enum const(wchar)* SDDL_CERTSVC_DCOM_ACCESS = "CD";
enum const(wchar)* SDDL_ALL_APP_PACKAGES = "AC";
enum const(wchar)* SDDL_RDS_REMOTE_ACCESS_SERVERS = "RA";
enum const(wchar)* SDDL_RDS_ENDPOINT_SERVERS = "ES";
enum const(wchar)* SDDL_RDS_MANAGEMENT_SERVERS = "MS";
enum const(wchar)* SDDL_USER_MODE_DRIVERS = "UD";
enum const(wchar)* SDDL_HYPER_V_ADMINS = "HA";
enum const(wchar)* SDDL_CLONEABLE_CONTROLLERS = "CN";
enum const(wchar)* SDDL_ACCESS_CONTROL_ASSISTANCE_OPS = "AA";
enum const(wchar)* SDDL_REMOTE_MANAGEMENT_USERS = "RM";
enum const(wchar)* SDDL_AUTHORITY_ASSERTED = "AS";
enum const(wchar)* SDDL_SERVICE_ASSERTED = "SS";
enum const(wchar)* SDDL_PROTECTED_USERS = "AP";
enum const(wchar)* SDDL_KEY_ADMINS = "KA";
enum const(wchar)* SDDL_ENTERPRISE_KEY_ADMINS = "EK";
enum const(wchar)* SDDL_USER_MODE_HARDWARE_OPERATORS = "HO";
enum const(wchar)* SDDL_OPENSSH_USERS = "SH";

enum : const(wchar)*
{
    SDDL_ML_LOW         = "LW",
    SDDL_ML_MEDIUM      = "ME",
    SDDL_ML_MEDIUM_PLUS = "MP",
    SDDL_ML_HIGH        = "HI",
    SDDL_ML_SYSTEM      = "SI",
}

enum const(wchar)* SDDL_SEPERATOR = ";";
enum const(wchar)* SDDL_DELIMINATOR = ":";

enum : const(wchar)*
{
    SDDL_ACE_BEGIN      = "(",
    SDDL_ACE_END        = ")",
    SDDL_ACE_COND_BEGIN = "(",
    SDDL_ACE_COND_END   = ")",
}

enum : const(wchar)*
{
    SDDL_SPACE                          = " ",
    SDDL_ACE_COND_BLOB_PREFIX           = "#",
    SDDL_ACE_COND_SID_PREFIX            = "SID",
    SDDL_ACE_COND_ATTRIBUTE_PREFIX      = "@",
    SDDL_ACE_COND_USER_ATTRIBUTE_PREFIX = "@USER.",
}

enum const(wchar)* SDDL_ACE_COND_RESOURCE_ATTRIBUTE_PREFIX = "@RESOURCE.";
enum const(wchar)* SDDL_ACE_COND_DEVICE_ATTRIBUTE_PREFIX = "@DEVICE.";
enum const(wchar)* SDDL_ACE_COND_TOKEN_ATTRIBUTE_PREFIX = "@TOKEN.";

enum : uint
{
    INHERITED_ACCESS_ENTRY = 0x00000010U,
    INHERITED_PARENT       = 0x10000000U,
    INHERITED_GRANDPARENT  = 0x20000000U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ACCCTRL_DEFAULT_PROVIDERA = "Windows NT Access Provider",
    ACCCTRL_DEFAULT_PROVIDERW = "Windows NT Access Provider",
    ACCCTRL_DEFAULT_PROVIDER  = "Windows NT Access Provider",
}

enum : int
{
    TRUSTEE_ACCESS_ALLOWED  = 0x00000001,
    TRUSTEE_ACCESS_READ     = 0x00000002,
    TRUSTEE_ACCESS_WRITE    = 0x00000004,
    TRUSTEE_ACCESS_EXPLICIT = 0x00000001,
    TRUSTEE_ACCESS_ALL      = 0xffffffff,
}

enum : uint
{
    ACTRL_RESERVED         = 0x00000000U,
    ACTRL_PERM_1           = 0x00000001U,
    ACTRL_PERM_2           = 0x00000002U,
    ACTRL_PERM_3           = 0x00000004U,
    ACTRL_PERM_4           = 0x00000008U,
    ACTRL_PERM_5           = 0x00000010U,
    ACTRL_PERM_6           = 0x00000020U,
    ACTRL_PERM_7           = 0x00000040U,
    ACTRL_PERM_8           = 0x00000080U,
    ACTRL_PERM_9           = 0x00000100U,
    ACTRL_PERM_10          = 0x00000200U,
    ACTRL_PERM_11          = 0x00000400U,
    ACTRL_PERM_12          = 0x00000800U,
    ACTRL_PERM_13          = 0x00001000U,
    ACTRL_PERM_14          = 0x00002000U,
    ACTRL_PERM_15          = 0x00004000U,
    ACTRL_PERM_16          = 0x00008000U,
    ACTRL_PERM_17          = 0x00010000U,
    ACTRL_PERM_18          = 0x00020000U,
    ACTRL_PERM_19          = 0x00040000U,
    ACTRL_PERM_20          = 0x00080000U,
    ACTRL_ACCESS_PROTECTED = 0x00000001U,
}

enum uint ACTRL_SYSTEM_ACCESS = 0x04000000U;

enum : uint
{
    ACTRL_DELETE       = 0x08000000U,
    ACTRL_READ_CONTROL = 0x10000000U,
}

enum : uint
{
    ACTRL_CHANGE_ACCESS = 0x20000000U,
    ACTRL_CHANGE_OWNER  = 0x40000000U,
}

enum : uint
{
    ACTRL_SYNCHRONIZE    = 0x80000000U,
    ACTRL_STD_RIGHTS_ALL = 0xf8000000U,
}

enum : uint
{
    ACTRL_FILE_READ         = 0x00000001U,
    ACTRL_FILE_WRITE        = 0x00000002U,
    ACTRL_FILE_APPEND       = 0x00000004U,
    ACTRL_FILE_READ_PROP    = 0x00000008U,
    ACTRL_FILE_WRITE_PROP   = 0x00000010U,
    ACTRL_FILE_EXECUTE      = 0x00000020U,
    ACTRL_FILE_READ_ATTRIB  = 0x00000080U,
    ACTRL_FILE_WRITE_ATTRIB = 0x00000100U,
    ACTRL_FILE_CREATE_PIPE  = 0x00000200U,
}

enum : uint
{
    ACTRL_DIR_LIST          = 0x00000001U,
    ACTRL_DIR_CREATE_OBJECT = 0x00000002U,
    ACTRL_DIR_CREATE_CHILD  = 0x00000004U,
    ACTRL_DIR_DELETE_CHILD  = 0x00000040U,
    ACTRL_DIR_TRAVERSE      = 0x00000020U,
}

enum : uint
{
    ACTRL_KERNEL_TERMINATE    = 0x00000001U,
    ACTRL_KERNEL_THREAD       = 0x00000002U,
    ACTRL_KERNEL_VM           = 0x00000004U,
    ACTRL_KERNEL_VM_READ      = 0x00000008U,
    ACTRL_KERNEL_VM_WRITE     = 0x00000010U,
    ACTRL_KERNEL_DUP_HANDLE   = 0x00000020U,
    ACTRL_KERNEL_PROCESS      = 0x00000040U,
    ACTRL_KERNEL_SET_INFO     = 0x00000080U,
    ACTRL_KERNEL_GET_INFO     = 0x00000100U,
    ACTRL_KERNEL_CONTROL      = 0x00000200U,
    ACTRL_KERNEL_ALERT        = 0x00000400U,
    ACTRL_KERNEL_GET_CONTEXT  = 0x00000800U,
    ACTRL_KERNEL_SET_CONTEXT  = 0x00001000U,
    ACTRL_KERNEL_TOKEN        = 0x00002000U,
    ACTRL_KERNEL_IMPERSONATE  = 0x00004000U,
    ACTRL_KERNEL_DIMPERSONATE = 0x00008000U,
}

enum : uint
{
    ACTRL_PRINT_SADMIN = 0x00000001U,
    ACTRL_PRINT_SLIST  = 0x00000002U,
    ACTRL_PRINT_PADMIN = 0x00000004U,
    ACTRL_PRINT_PUSE   = 0x00000008U,
    ACTRL_PRINT_JADMIN = 0x00000010U,
}

enum : uint
{
    ACTRL_SVC_GET_INFO    = 0x00000001U,
    ACTRL_SVC_SET_INFO    = 0x00000002U,
    ACTRL_SVC_STATUS      = 0x00000004U,
    ACTRL_SVC_LIST        = 0x00000008U,
    ACTRL_SVC_START       = 0x00000010U,
    ACTRL_SVC_STOP        = 0x00000020U,
    ACTRL_SVC_PAUSE       = 0x00000040U,
    ACTRL_SVC_INTERROGATE = 0x00000080U,
    ACTRL_SVC_UCONTROL    = 0x00000100U,
}

enum : uint
{
    ACTRL_REG_QUERY                      = 0x00000001U,
    ACTRL_REG_SET                        = 0x00000002U,
    ACTRL_REG_CREATE_CHILD               = 0x00000004U,
    ACTRL_REG_LIST                       = 0x00000008U,
    ACTRL_REG_NOTIFY                     = 0x00000010U,
    ACTRL_REG_LINK                       = 0x00000020U,
    ACTRL_WIN_CLIPBRD                    = 0x00000001U,
    ACTRL_WIN_GLOBAL_ATOMS               = 0x00000002U,
    ACTRL_WIN_CREATE                     = 0x00000004U,
    ACTRL_WIN_LIST_DESK                  = 0x00000008U,
    ACTRL_WIN_LIST                       = 0x00000010U,
    ACTRL_WIN_READ_ATTRIBS               = 0x00000020U,
    ACTRL_WIN_WRITE_ATTRIBS              = 0x00000040U,
    ACTRL_WIN_SCREEN                     = 0x00000080U,
    ACTRL_WIN_EXIT                       = 0x00000100U,
    ACTRL_ACCESS_NO_OPTIONS              = 0x00000000U,
    ACTRL_ACCESS_SUPPORTS_OBJECT_ENTRIES = 0x00000001U,
}

enum : uint
{
    AUDIT_TYPE_LEGACY = 0x00000001U,
    AUDIT_TYPE_WMI    = 0x00000002U,
}

enum uint AP_ParamTypeBits = 0x00000008U;
enum int AP_ParamTypeMask = 0x000000ff;
enum uint _AUTHZ_SS_MAXSIZE = 0x00000080U;

enum : uint
{
    APF_AuditFailure = 0x00000000U,
    APF_AuditSuccess = 0x00000001U,
}

enum uint APF_ValidFlags = 0x00000001U;
enum uint AUTHZP_WPD_EVENT = 0x00000010U;
enum uint AUTHZ_ALLOW_MULTIPLE_SOURCE_INSTANCES = 0x00000001U;
enum uint AUTHZ_MIGRATED_LEGACY_PUBLISHER = 0x00000002U;
enum uint AUTHZ_AUDIT_INSTANCE_INFORMATION = 0x00000002U;
enum uint AUTHZ_SKIP_TOKEN_GROUPS = 0x00000002U;
enum uint AUTHZ_REQUIRE_S4U_LOGON = 0x00000004U;
enum uint AUTHZ_COMPUTE_PRIVILEGES = 0x00000008U;

enum : uint
{
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_INVALID            = 0x00000000U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_INT64              = 0x00000001U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_UINT64             = 0x00000002U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_STRING             = 0x00000003U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_FQBN               = 0x00000004U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_SID                = 0x00000005U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_BOOLEAN            = 0x00000006U,
    AUTHZ_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING       = 0x00000010U,
    AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION_V1 = 0x00000001U,
    AUTHZ_SECURITY_ATTRIBUTES_INFORMATION_VERSION    = 0x00000001U,
}

enum uint AUTHZ_RPC_INIT_INFO_CLIENT_VERSION_V1 = 0x00000001U;
enum uint AUTHZ_INIT_INFO_VERSION_V1 = 0x00000001U;
enum uint AUTHZ_WPD_CATEGORY_FLAG = 0x00000010U;
enum uint AUTHZ_FLAG_ALLOW_MULTIPLE_SOURCE_INSTANCES = 0x00000001U;
enum HRESULT OLESCRIPT_E_SYNTAX = HRESULT(0x80020101);

// Callbacks

alias PFN_AUTHZ_DYNAMIC_ACCESS_CHECK = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                                                     ACE_HEADER* pAce, void* pArgs, BOOL* pbAceApplicable);
alias PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, void* Args, 
                                                       SID_AND_ATTRIBUTES** pSidAttrArray, uint* pSidCount, 
                                                       SID_AND_ATTRIBUTES** pRestrictedSidAttrArray, 
                                                       uint* pRestrictedSidCount);
alias PFN_AUTHZ_FREE_DYNAMIC_GROUPS = void function(SID_AND_ATTRIBUTES* pSidAttrArray);
alias PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                                                          PSID capid, void* pArgs, 
                                                          BOOL* pCentralAccessPolicyApplicable, 
                                                          void** ppCentralAccessPolicy);
alias PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY = void function(void* pCentralAccessPolicy);
alias FN_PROGRESS = void function(PWSTR pObjectName, uint Status, PROG_INVOKE_SETTING* pInvokeSetting, void* Args, 
                                  BOOL SecuritySet);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-objects_and_sid
struct OBJECTS_AND_SID
{
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS ObjectsPresent;
    GUID ObjectTypeGuid;
    GUID InheritedObjectTypeGuid;
    SID* pSid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-objects_and_name_a
struct OBJECTS_AND_NAME_A
{
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    PSTR           ObjectTypeName;
    PSTR           InheritedObjectTypeName;
    PSTR           ptstrName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-objects_and_name_w
struct OBJECTS_AND_NAME_W
{
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    PWSTR          ObjectTypeName;
    PWSTR          InheritedObjectTypeName;
    PWSTR          ptstrName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-trustee_a
struct TRUSTEE_A
{
    TRUSTEE_A*   pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM TrusteeForm;
    TRUSTEE_TYPE TrusteeType;
    PSTR         ptstrName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-trustee_w
struct TRUSTEE_W
{
    TRUSTEE_W*   pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM TrusteeForm;
    TRUSTEE_TYPE TrusteeType;
    PWSTR        ptstrName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-explicit_access_a
struct EXPLICIT_ACCESS_A
{
    uint        grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    ACE_FLAGS   grfInheritance;
    TRUSTEE_A   Trustee;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-explicit_access_w
struct EXPLICIT_ACCESS_W
{
    uint        grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    ACE_FLAGS   grfInheritance;
    TRUSTEE_W   Trustee;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_access_entrya
struct ACTRL_ACCESS_ENTRYA
{
    TRUSTEE_A Trustee;
    ACTRL_ACCESS_ENTRY_ACCESS_FLAGS fAccessFlags;
    uint      Access;
    uint      ProvSpecificAccess;
    ACE_FLAGS Inheritance;
    PSTR      lpInheritProperty;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_access_entryw
struct ACTRL_ACCESS_ENTRYW
{
    TRUSTEE_W Trustee;
    ACTRL_ACCESS_ENTRY_ACCESS_FLAGS fAccessFlags;
    uint      Access;
    uint      ProvSpecificAccess;
    ACE_FLAGS Inheritance;
    PWSTR     lpInheritProperty;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_access_entry_lista
struct ACTRL_ACCESS_ENTRY_LISTA
{
    uint                 cEntries;
    ACTRL_ACCESS_ENTRYA* pAccessList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_access_entry_listw
struct ACTRL_ACCESS_ENTRY_LISTW
{
    uint                 cEntries;
    ACTRL_ACCESS_ENTRYW* pAccessList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_property_entrya
struct ACTRL_PROPERTY_ENTRYA
{
    PSTR lpProperty;
    ACTRL_ACCESS_ENTRY_LISTA* pAccessEntryList;
    uint fListFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_property_entryw
struct ACTRL_PROPERTY_ENTRYW
{
    PWSTR lpProperty;
    ACTRL_ACCESS_ENTRY_LISTW* pAccessEntryList;
    uint  fListFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_accessa
struct ACTRL_ACCESSA
{
    uint cEntries;
    ACTRL_PROPERTY_ENTRYA* pPropertyAccessList;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-actrl_accessw
struct ACTRL_ACCESSW
{
    uint cEntries;
    ACTRL_PROPERTY_ENTRYW* pPropertyAccessList;
}

struct TRUSTEE_ACCESSA
{
    PSTR lpProperty;
    uint Access;
    uint fAccessFlags;
    uint fReturnedAccess;
}

struct TRUSTEE_ACCESSW
{
    PWSTR lpProperty;
    uint  Access;
    uint  fAccessFlags;
    uint  fReturnedAccess;
}

struct ACTRL_OVERLAPPED
{
    union
    {
        void* Provider;
        uint  Reserved1;
    }
    uint   Reserved2;
    HANDLE hEvent;
}

struct ACTRL_ACCESS_INFOA
{
    uint fAccessPermission;
    PSTR lpAccessPermissionName;
}

struct ACTRL_ACCESS_INFOW
{
    uint  fAccessPermission;
    PWSTR lpAccessPermissionName;
}

struct ACTRL_CONTROL_INFOA
{
    PSTR lpControlId;
    PSTR lpControlName;
}

struct ACTRL_CONTROL_INFOW
{
    PWSTR lpControlId;
    PWSTR lpControlName;
}

struct FN_OBJECT_MGR_FUNCTS
{
    uint Placeholder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-inherited_froma
struct INHERITED_FROMA
{
    int  GenerationGap;
    PSTR AncestorName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/accctrl/ns-accctrl-inherited_fromw
struct INHERITED_FROMW
{
    int   GenerationGap;
    PWSTR AncestorName;
}

struct AUDIT_OBJECT_TYPE
{
    GUID   ObjectType;
    ushort Flags;
    ushort Level;
    uint   AccessMask;
}

struct AUDIT_OBJECT_TYPES
{
    ushort             Count;
    ushort             Flags;
    AUDIT_OBJECT_TYPE* pObjectTypes;
}

struct AUDIT_IP_ADDRESS
{
    ubyte[128] pIpAddress;
}

struct AUDIT_PARAM
{
    AUDIT_PARAM_TYPE Type;
    uint             Length;
    uint             Flags;
    union
    {
        size_t              Data0;
        PWSTR               String;
        size_t              u;
        SID*                psid;
        GUID*               pguid;
        uint                LogonId_LowPart;
        AUDIT_OBJECT_TYPES* pObjectTypes;
        AUDIT_IP_ADDRESS*   pIpAddress;
    }
    union
    {
        size_t Data1;
        int    LogonId_HighPart;
    }
}

struct AUDIT_PARAMS
{
    uint         Length;
    uint         Flags;
    ushort       Count;
    AUDIT_PARAM* Parameters;
}

struct AUTHZ_AUDIT_EVENT_TYPE_LEGACY
{
    ushort CategoryId;
    ushort AuditId;
    ushort ParameterCount;
}

union AUTHZ_AUDIT_EVENT_TYPE_UNION
{
    AUTHZ_AUDIT_EVENT_TYPE_LEGACY Legacy;
}

struct AUTHZ_AUDIT_EVENT_TYPE_OLD
{
    uint   Version;
    uint   dwFlags;
    int    RefCount;
    size_t hAudit;
    LUID   LinkId;
    AUTHZ_AUDIT_EVENT_TYPE_UNION u;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_access_request
struct AUTHZ_ACCESS_REQUEST
{
    uint              DesiredAccess;
    PSID              PrincipalSelfSid;
    OBJECT_TYPE_LIST* ObjectTypeList;
    uint              ObjectTypeListLength;
    void*             OptionalArguments;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_access_reply
struct AUTHZ_ACCESS_REPLY
{
    uint  ResultListLength;
    uint* GrantedAccessMask;
    AUTHZ_GENERATE_RESULTS* SaclEvaluationResults;
    uint* Error;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_security_attribute_fqbn_value
struct AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong Version;
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_security_attribute_octet_string_value
struct AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint  ValueLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_security_attribute_v1
struct AUTHZ_SECURITY_ATTRIBUTE_V1
{
    PWSTR  pName;
    ushort ValueType;
    ushort Reserved;
    AUTHZ_SECURITY_ATTRIBUTE_FLAGS Flags;
    uint   ValueCount;
    union Values
    {
        long*  pInt64;
        ulong* pUint64;
        PWSTR* ppString;
        AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE* pFqbn;
        AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* pOctetString;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_security_attributes_information
struct AUTHZ_SECURITY_ATTRIBUTES_INFORMATION
{
    ushort Version;
    ushort Reserved;
    uint   AttributeCount;
    union Attribute
    {
        AUTHZ_SECURITY_ATTRIBUTE_V1* pAttributeV1;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_rpc_init_info_client
struct AUTHZ_RPC_INIT_INFO_CLIENT
{
    ushort version_;
    PWSTR  ObjectUuid;
    PWSTR  ProtSeq;
    PWSTR  NetworkAddr;
    PWSTR  Endpoint;
    PWSTR  Options;
    PWSTR  ServerSpn;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_init_info
struct AUTHZ_INIT_INFO
{
    ushort       version_;
    const(PWSTR) szResourceManagerName;
    PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck;
    PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups;
    PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups;
    PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY pfnGetCentralAccessPolicy;
    PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY pfnFreeCentralAccessPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_registration_object_type_name_offset
struct AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
{
    PWSTR szObjectTypeName;
    uint  dwOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/authz/ns-authz-authz_source_schema_registration
struct AUTHZ_SOURCE_SCHEMA_REGISTRATION
{
    uint  dwFlags;
    PWSTR szEventSourceName;
    PWSTR szEventMessageFile;
    PWSTR szEventSourceXmlSchemaFile;
    PWSTR szEventAccessStringsFile;
    PWSTR szExecutableImagePath;
    union
    {
        void* pReserved;
        GUID* pProviderGuid;
    }
    uint  dwObjectTypeNameCount;
    AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET[1] ObjectTypeNames; // Flexible array
}

@RAIIFree!AuthzFreeHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_ACCESS_CHECK_RESULTS_HANDLE
{
    void* Value;
}

@RAIIFree!AuthzUnregisterCapChangeNotification
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE
{
    void* Value;
}

@RAIIFree!AuthzFreeContext
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_CLIENT_CONTEXT_HANDLE
{
    void* Value;
}

@RAIIFree!AuthzFreeResourceManager
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_RESOURCE_MANAGER_HANDLE
{
    void* Value;
}

@RAIIFree!AuthzFreeAuditEvent
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_AUDIT_EVENT_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_AUDIT_EVENT_TYPE_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE
{
    void* Value;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzAccessCheck(AUTHZ_ACCESS_CHECK_FLAGS Flags, AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                      AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE hAuditEvent, 
                      PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                      PSECURITY_DESCRIPTOR* OptionalSecurityDescriptorArray, uint OptionalSecurityDescriptorCount, 
                      AUTHZ_ACCESS_REPLY* pReply, AUTHZ_ACCESS_CHECK_RESULTS_HANDLE* phAccessCheckResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzCachedAccessCheck(uint Flags, AUTHZ_ACCESS_CHECK_RESULTS_HANDLE hAccessCheckResults, 
                            AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE hAuditEvent, 
                            AUTHZ_ACCESS_REPLY* pReply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzOpenObjectAudit(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                          AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE hAuditEvent, 
                          PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                          PSECURITY_DESCRIPTOR* OptionalSecurityDescriptorArray, 
                          uint OptionalSecurityDescriptorCount, AUTHZ_ACCESS_REPLY* pReply);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzFreeHandle(AUTHZ_ACCESS_CHECK_RESULTS_HANDLE hAccessCheckResults);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeResourceManager(uint Flags, PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck, 
                                    PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups, 
                                    PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups, 
                                    const(PWSTR) szResourceManagerName, 
                                    AUTHZ_RESOURCE_MANAGER_HANDLE* phAuthzResourceManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeResourceManagerEx(AUTHZ_RESOURCE_MANAGER_FLAGS Flags, AUTHZ_INIT_INFO* pAuthzInitInfo, 
                                      AUTHZ_RESOURCE_MANAGER_HANDLE* phAuthzResourceManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeRemoteResourceManager(AUTHZ_RPC_INIT_INFO_CLIENT* pRpcInitInfo, 
                                          AUTHZ_RESOURCE_MANAGER_HANDLE* phAuthzResourceManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzFreeResourceManager(AUTHZ_RESOURCE_MANAGER_HANDLE hAuthzResourceManager);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromToken(uint Flags, HANDLE TokenHandle, 
                                     AUTHZ_RESOURCE_MANAGER_HANDLE hAuthzResourceManager, long* pExpirationTime, 
                                     LUID Identifier, void* DynamicGroupArgs, 
                                     AUTHZ_CLIENT_CONTEXT_HANDLE* phAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromSid(uint Flags, PSID UserSid, AUTHZ_RESOURCE_MANAGER_HANDLE hAuthzResourceManager, 
                                   long* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, 
                                   AUTHZ_CLIENT_CONTEXT_HANDLE* phAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeContextFromAuthzContext(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                                            long* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, 
                                            AUTHZ_CLIENT_CONTEXT_HANDLE* phNewAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeCompoundContext(AUTHZ_CLIENT_CONTEXT_HANDLE UserContext, 
                                    AUTHZ_CLIENT_CONTEXT_HANDLE DeviceContext, 
                                    AUTHZ_CLIENT_CONTEXT_HANDLE* phCompoundContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzAddSidsToContext(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, SID_AND_ATTRIBUTES* Sids, 
                           uint SidCount, SID_AND_ATTRIBUTES* RestrictedSids, uint RestrictedSidCount, 
                           AUTHZ_CLIENT_CONTEXT_HANDLE* phNewAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzModifySecurityAttributes(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                                   AUTHZ_SECURITY_ATTRIBUTE_OPERATION* pOperations, 
                                   AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAttributes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzModifyClaims(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS ClaimClass, 
                       AUTHZ_SECURITY_ATTRIBUTE_OPERATION* pClaimOperations, 
                       AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pClaims);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzModifySids(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS SidClass, 
                     AUTHZ_SID_OPERATION* pSidOperations, TOKEN_GROUPS* pSids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzSetAppContainerInformation(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, PSID pAppContainerSid, 
                                     uint CapabilityCount, SID_AND_ATTRIBUTES* pCapabilitySids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzGetInformationFromContext(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext, 
                                    AUTHZ_CONTEXT_INFORMATION_CLASS InfoClass, uint BufferSize, uint* pSizeRequired, 
                                    void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzFreeContext(AUTHZ_CLIENT_CONTEXT_HANDLE hAuthzClientContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeObjectAccessAuditEvent(AUTHZ_INITIALIZE_OBJECT_ACCESS_AUDIT_EVENT_FLAGS Flags, 
                                           AUTHZ_AUDIT_EVENT_TYPE_HANDLE hAuditEventType, PWSTR szOperationType, 
                                           PWSTR szObjectType, PWSTR szObjectName, PWSTR szAdditionalInfo, 
                                           AUTHZ_AUDIT_EVENT_HANDLE* phAuditEvent, uint dwAdditionalParameterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInitializeObjectAccessAuditEvent2(uint Flags, AUTHZ_AUDIT_EVENT_TYPE_HANDLE hAuditEventType, 
                                            PWSTR szOperationType, PWSTR szObjectType, PWSTR szObjectName, 
                                            PWSTR szAdditionalInfo, PWSTR szAdditionalInfo2, 
                                            AUTHZ_AUDIT_EVENT_HANDLE* phAuditEvent, uint dwAdditionalParameterCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzFreeAuditEvent(AUTHZ_AUDIT_EVENT_HANDLE hAuditEvent);

@DllImport("AUTHZ.dll")
BOOL AuthzEvaluateSacl(AUTHZ_CLIENT_CONTEXT_HANDLE AuthzClientContext, AUTHZ_ACCESS_REQUEST* pRequest, ACL* Sacl, 
                       uint GrantedAccess, BOOL AccessGranted, BOOL* pbGenerateAudit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzInstallSecurityEventSource(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* pRegistration);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzUninstallSecurityEventSource(uint dwFlags, const(PWSTR) szEventSourceName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzEnumerateSecurityEventSources(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* Buffer, uint* pdwCount, 
                                        uint* pdwLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzRegisterSecurityEventSource(uint dwFlags, const(PWSTR) szEventSourceName, 
                                      AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE* phEventProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzUnregisterSecurityEventSource(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE* phEventProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzReportSecurityEvent(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE hEventProvider, uint dwAuditId, 
                              PSID pUserSid, uint dwCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzReportSecurityEventFromParams(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE hEventProvider, 
                                        uint dwAuditId, PSID pUserSid, AUDIT_PARAMS* pParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzRegisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE* phCapChangeSubscription, 
                                        LPTHREAD_START_ROUTINE pfnCapChangeCallback, void* pCallbackContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzUnregisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE hCapChangeSubscription);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("AUTHZ.dll")
BOOL AuthzFreeCentralAccessPolicyCache();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR SetEntriesInAclA(uint cCountOfExplicitEntries, EXPLICIT_ACCESS_A* pListOfExplicitEntries, ACL* OldAcl, 
                             ACL** NewAcl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR SetEntriesInAclW(uint cCountOfExplicitEntries, EXPLICIT_ACCESS_W* pListOfExplicitEntries, ACL* OldAcl, 
                             ACL** NewAcl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetExplicitEntriesFromAclA(ACL* pacl, uint* pcCountOfExplicitEntries, 
                                       EXPLICIT_ACCESS_A** pListOfExplicitEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetExplicitEntriesFromAclW(ACL* pacl, uint* pcCountOfExplicitEntries, 
                                       EXPLICIT_ACCESS_W** pListOfExplicitEntries);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetEffectiveRightsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pAccessRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetEffectiveRightsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pAccessRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetAuditedPermissionsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pSuccessfulAuditedRights, 
                                          uint* pFailedAuditRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetAuditedPermissionsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pSuccessfulAuditedRights, 
                                          uint* pFailedAuditRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetNamedSecurityInfoA(const(PSTR) pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, PSID* ppsidOwner, PSID* ppsidGroup, 
                                  ACL** ppDacl, ACL** ppSacl, PSECURITY_DESCRIPTOR* ppSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetNamedSecurityInfoW(const(PWSTR) pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, PSID* ppsidOwner, PSID* ppsidGroup, 
                                  ACL** ppDacl, ACL** ppSacl, PSECURITY_DESCRIPTOR* ppSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, OBJECT_SECURITY_INFORMATION SecurityInfo, 
                            PSID* ppsidOwner, PSID* ppsidGroup, ACL** ppDacl, ACL** ppSacl, 
                            PSECURITY_DESCRIPTOR* ppSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR SetNamedSecurityInfoA(PSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, PSID psidOwner, PSID psidGroup, 
                                  ACL* pDacl, ACL* pSacl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR SetNamedSecurityInfoW(PWSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, PSID psidOwner, PSID psidGroup, 
                                  ACL* pDacl, ACL* pSacl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR SetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, OBJECT_SECURITY_INFORMATION SecurityInfo, 
                            PSID psidOwner, PSID psidGroup, ACL* pDacl, ACL* pSacl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetInheritanceSourceA(PSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, BOOL Container, GUID** pObjectClassGuids, 
                                  uint GuidCount, ACL* pAcl, FN_OBJECT_MGR_FUNCTS* pfnArray, 
                                  GENERIC_MAPPING* pGenericMapping, INHERITED_FROMA* pInheritArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR GetInheritanceSourceW(PWSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                  OBJECT_SECURITY_INFORMATION SecurityInfo, BOOL Container, GUID** pObjectClassGuids, 
                                  uint GuidCount, ACL* pAcl, FN_OBJECT_MGR_FUNCTS* pfnArray, 
                                  GENERIC_MAPPING* pGenericMapping, INHERITED_FROMW* pInheritArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR FreeInheritedFromArray(INHERITED_FROMW* pInheritArray, ushort AceCnt, FN_OBJECT_MGR_FUNCTS* pfnArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR TreeResetNamedSecurityInfoA(PSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                        OBJECT_SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, 
                                        ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, 
                                        PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR TreeResetNamedSecurityInfoW(PWSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                        OBJECT_SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, 
                                        ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, FN_PROGRESS fnProgress, 
                                        PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR TreeSetNamedSecurityInfoA(PSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                      OBJECT_SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, ACL* pDacl, 
                                      ACL* pSacl, TREE_SEC_INFO dwAction, FN_PROGRESS fnProgress, 
                                      PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR TreeSetNamedSecurityInfoW(PWSTR pObjectName, SE_OBJECT_TYPE ObjectType, 
                                      OBJECT_SECURITY_INFORMATION SecurityInfo, PSID pOwner, PSID pGroup, ACL* pDacl, 
                                      ACL* pSacl, TREE_SEC_INFO dwAction, FN_PROGRESS fnProgress, 
                                      PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR BuildSecurityDescriptorA(TRUSTEE_A* pOwner, TRUSTEE_A* pGroup, uint cCountOfAccessEntries, 
                                     EXPLICIT_ACCESS_A* pListOfAccessEntries, uint cCountOfAuditEntries, 
                                     EXPLICIT_ACCESS_A* pListOfAuditEntries, PSECURITY_DESCRIPTOR pOldSD, 
                                     uint* pSizeNewSD, PSECURITY_DESCRIPTOR* pNewSD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR BuildSecurityDescriptorW(TRUSTEE_W* pOwner, TRUSTEE_W* pGroup, uint cCountOfAccessEntries, 
                                     EXPLICIT_ACCESS_W* pListOfAccessEntries, uint cCountOfAuditEntries, 
                                     EXPLICIT_ACCESS_W* pListOfAuditEntries, PSECURITY_DESCRIPTOR pOldSD, 
                                     uint* pSizeNewSD, PSECURITY_DESCRIPTOR* pNewSD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR LookupSecurityDescriptorPartsA(TRUSTEE_A** ppOwner, TRUSTEE_A** ppGroup, uint* pcCountOfAccessEntries, 
                                           EXPLICIT_ACCESS_A** ppListOfAccessEntries, uint* pcCountOfAuditEntries, 
                                           EXPLICIT_ACCESS_A** ppListOfAuditEntries, PSECURITY_DESCRIPTOR pSD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
WIN32_ERROR LookupSecurityDescriptorPartsW(TRUSTEE_W** ppOwner, TRUSTEE_W** ppGroup, uint* pcCountOfAccessEntries, 
                                           EXPLICIT_ACCESS_W** ppListOfAccessEntries, uint* pcCountOfAuditEntries, 
                                           EXPLICIT_ACCESS_W** ppListOfAuditEntries, PSECURITY_DESCRIPTOR pSD);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, PSTR pTrusteeName, uint AccessPermissions, 
                                  ACCESS_MODE AccessMode, ACE_FLAGS Inheritance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, PWSTR pTrusteeName, uint AccessPermissions, 
                                  ACCESS_MODE AccessMode, ACE_FLAGS Inheritance);

@DllImport("ADVAPI32.dll")
void BuildImpersonateExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, PSTR pTrusteeName, 
                                             TRUSTEE_A* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, 
                                             uint Inheritance);

@DllImport("ADVAPI32.dll")
void BuildImpersonateExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, PWSTR pTrusteeName, 
                                             TRUSTEE_W* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, 
                                             uint Inheritance);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithNameA(TRUSTEE_A* pTrustee, PSTR pName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithNameW(TRUSTEE_W* pTrustee, PWSTR pName);

@DllImport("ADVAPI32.dll")
void BuildImpersonateTrusteeA(TRUSTEE_A* pTrustee, TRUSTEE_A* pImpersonateTrustee);

@DllImport("ADVAPI32.dll")
void BuildImpersonateTrusteeW(TRUSTEE_W* pTrustee, TRUSTEE_W* pImpersonateTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithSidA(TRUSTEE_A* pTrustee, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithSidW(TRUSTEE_W* pTrustee, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndSidA(TRUSTEE_A* pTrustee, OBJECTS_AND_SID* pObjSid, GUID* pObjectGuid, 
                                    GUID* pInheritedObjectGuid, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndSidW(TRUSTEE_W* pTrustee, OBJECTS_AND_SID* pObjSid, GUID* pObjectGuid, 
                                    GUID* pInheritedObjectGuid, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndNameA(TRUSTEE_A* pTrustee, OBJECTS_AND_NAME_A* pObjName, SE_OBJECT_TYPE ObjectType, 
                                     PSTR ObjectTypeName, PSTR InheritedObjectTypeName, PSTR Name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void BuildTrusteeWithObjectsAndNameW(TRUSTEE_W* pTrustee, OBJECTS_AND_NAME_W* pObjName, SE_OBJECT_TYPE ObjectType, 
                                     PWSTR ObjectTypeName, PWSTR InheritedObjectTypeName, PWSTR Name);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
PSTR GetTrusteeNameA(TRUSTEE_A* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
PWSTR GetTrusteeNameW(TRUSTEE_W* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
TRUSTEE_TYPE GetTrusteeTypeA(TRUSTEE_A* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
TRUSTEE_TYPE GetTrusteeTypeW(TRUSTEE_W* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
TRUSTEE_FORM GetTrusteeFormA(TRUSTEE_A* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
TRUSTEE_FORM GetTrusteeFormW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_A* GetMultipleTrusteeA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32.dll")
TRUSTEE_W* GetMultipleTrusteeW(TRUSTEE_W* pTrustee);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertSidToStringSidA(PSID Sid, PSTR* StringSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertSidToStringSidW(PSID Sid, PWSTR* StringSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertStringSidToSidA(const(PSTR) StringSid, PSID* Sid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertStringSidToSidW(const(PWSTR) StringSid, PSID* Sid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorA(const(PSTR) StringSecurityDescriptor, 
                                                          uint StringSDRevision, 
                                                          PSECURITY_DESCRIPTOR* SecurityDescriptor, 
                                                          uint* SecurityDescriptorSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(const(PWSTR) StringSecurityDescriptor, 
                                                          uint StringSDRevision, 
                                                          PSECURITY_DESCRIPTOR* SecurityDescriptor, 
                                                          uint* SecurityDescriptorSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorA(PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                                          uint RequestedStringSDRevision, 
                                                          OBJECT_SECURITY_INFORMATION SecurityInformation, 
                                                          PSTR* StringSecurityDescriptor, 
                                                          uint* StringSecurityDescriptorLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorW(PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                                          uint RequestedStringSDRevision, 
                                                          OBJECT_SECURITY_INFORMATION SecurityInformation, 
                                                          PWSTR* StringSecurityDescriptor, 
                                                          uint* StringSecurityDescriptorLen);


// Interfaces

@GUID("b2bcff59-a757-4b0b-a1bc-ea69981da69e")
struct AzAuthorizationStore;

@GUID("5c2dc96f-8d51-434b-b33c-379bccae77c3")
struct AzBizRuleContext;

@GUID("483afb5d-70df-4e16-abdc-a1de4d015a3e")
struct AzPrincipalLocator;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazauthorizationstore
@GUID("edbd9ca9-9b82-4f6a-9e8b-98301e450f14")
interface IAzAuthorizationStore : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_domaintimeout
    HRESULT get_DomainTimeout(int* plProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_domaintimeout
    HRESULT put_DomainTimeout(int lProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_scriptenginetimeout
    HRESULT get_ScriptEngineTimeout(int* plProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_scriptenginetimeout
    HRESULT put_ScriptEngineTimeout(int lProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_maxscriptengines
    HRESULT get_MaxScriptEngines(int* plProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_maxscriptengines
    HRESULT put_MaxScriptEngines(int lProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_generateaudits
    HRESULT get_GenerateAudits(BOOL* pbProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_generateaudits
    HRESULT put_GenerateAudits(BOOL bProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-addpropertyitem
    HRESULT AddPropertyItem(AZ_PROP_CONSTANTS lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_policyadministrators
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_policyreaders
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-addpolicyadministrator
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletepolicyadministrator
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-addpolicyreader
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletepolicyreader
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-initialize
    HRESULT Initialize(AZ_PROP_CONSTANTS lFlags, BSTR bstrPolicyURL, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-updatecache
    HRESULT UpdateCache(VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-delete
    HRESULT Delete(VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_applications
    HRESULT get_Applications(IAzApplications* ppAppCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-openapplication
    HRESULT OpenApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-createapplication
    HRESULT CreateApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deleteapplication
    HRESULT DeleteApplication(BSTR bstrApplicationName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_applicationgroups
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-createapplicationgroup
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-openapplicationgroup
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deleteapplicationgroup
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_delegatedpolicyusers
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-adddelegatedpolicyuser
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletedelegatedpolicyuser
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_targetmachine
    HRESULT get_TargetMachine(BSTR* pbstrTargetMachine);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_applystoresacl
    HRESULT get_ApplyStoreSacl(BOOL* pbApplyStoreSacl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-put_applystoresacl
    HRESULT put_ApplyStoreSacl(BOOL bApplyStoreSacl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_policyadministratorsname
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_policyreadersname
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-addpolicyadministratorname
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletepolicyadministratorname
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-addpolicyreadername
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletepolicyreadername
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-get_delegatedpolicyusersname
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-adddelegatedpolicyusername
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-deletedelegatedpolicyusername
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore-closeapplication
    HRESULT CloseApplication(BSTR bstrApplicationName, int lFlag);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazauthorizationstore2
@GUID("b11e5584-d577-4273-b6c5-0973e0f8e80d")
interface IAzAuthorizationStore2 : IAzAuthorizationStore
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore2-openapplication2
    HRESULT OpenApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore2-createapplication2
    HRESULT CreateApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazauthorizationstore3
@GUID("abc08425-0c86-4fa0-9be3-7189956c926e")
interface IAzAuthorizationStore3 : IAzAuthorizationStore2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore3-isupdateneeded
    HRESULT IsUpdateNeeded(VARIANT_BOOL* pbIsUpdateNeeded);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore3-bizrulegroupsupported
    HRESULT BizruleGroupSupported(VARIANT_BOOL* pbSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore3-upgradestoresfunctionallevel
    HRESULT UpgradeStoresFunctionalLevel(int lFunctionalLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore3-isfunctionallevelupgradesupported
    HRESULT IsFunctionalLevelUpgradeSupported(int lFunctionalLevel, VARIANT_BOOL* pbSupported);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazauthorizationstore3-getschemaversion
    HRESULT GetSchemaVersion(int* plMajorVersion, int* plMinorVersion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplication
@GUID("987bc7c7-b813-4d27-bede-6ba5ae867e95")
interface IAzApplication : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_authzinterfaceclsid
    HRESULT get_AuthzInterfaceClsid(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_authzinterfaceclsid
    HRESULT put_AuthzInterfaceClsid(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_version
    HRESULT get_Version(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_version
    HRESULT put_Version(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_generateaudits
    HRESULT get_GenerateAudits(BOOL* pbProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_generateaudits
    HRESULT put_GenerateAudits(BOOL bProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_applystoresacl
    HRESULT get_ApplyStoreSacl(BOOL* pbProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-put_applystoresacl
    HRESULT put_ApplyStoreSacl(BOOL bProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_policyadministrators
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_policyreaders
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-addpolicyadministrator
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletepolicyadministrator
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-addpolicyreader
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletepolicyreader
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_scopes
    HRESULT get_Scopes(IAzScopes* ppScopeCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-openscope
    HRESULT OpenScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-createscope
    HRESULT CreateScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletescope
    HRESULT DeleteScope(BSTR bstrScopeName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_operations
    HRESULT get_Operations(IAzOperations* ppOperationCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-openoperation
    HRESULT OpenOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-createoperation
    HRESULT CreateOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deleteoperation
    HRESULT DeleteOperation(BSTR bstrOperationName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_tasks
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-opentask
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-createtask
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletetask
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_applicationgroups
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-openapplicationgroup
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-createapplicationgroup
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deleteapplicationgroup
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_roles
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-openrole
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-createrole
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deleterole
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-initializeclientcontextfromtoken
    HRESULT InitializeClientContextFromToken(ulong ullTokenHandle, VARIANT varReserved, 
                                             IAzClientContext* ppClientContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-addpropertyitem
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-initializeclientcontextfromname
    HRESULT InitializeClientContextFromName(BSTR ClientName, BSTR DomainName, VARIANT varReserved, 
                                            IAzClientContext* ppClientContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_delegatedpolicyusers
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-adddelegatedpolicyuser
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletedelegatedpolicyuser
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-initializeclientcontextfromstringsid
    HRESULT InitializeClientContextFromStringSid(BSTR SidString, int lOptions, VARIANT varReserved, 
                                                 IAzClientContext* ppClientContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_policyadministratorsname
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_policyreadersname
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-addpolicyadministratorname
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletepolicyadministratorname
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-addpolicyreadername
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletepolicyreadername
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-get_delegatedpolicyusersname
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-adddelegatedpolicyusername
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication-deletedelegatedpolicyusername
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplication2
@GUID("086a68af-a249-437c-b18d-d4d86d6a9660")
interface IAzApplication2 : IAzApplication
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication2-initializeclientcontextfromtoken2
    HRESULT InitializeClientContextFromToken2(uint ulTokenHandleLowPart, uint ulTokenHandleHighPart, 
                                              VARIANT varReserved, IAzClientContext2* ppClientContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication2-initializeclientcontext2
    HRESULT InitializeClientContext2(BSTR IdentifyingString, VARIANT varReserved, 
                                     IAzClientContext2* ppClientContext);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplications
@GUID("929b11a9-95c5-4a84-a29a-20ad42c2f16c")
interface IAzApplications : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplications-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplications-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplications-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazoperation
@GUID("5e56b24f-ea01-4d61-be44-c49b5e4eaf74")
interface IAzOperation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-get_operationid
    HRESULT get_OperationID(int* plProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-put_operationid
    HRESULT put_OperationID(int lProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazoperations
@GUID("90ef9c07-9706-49d9-af80-0438a5f3ec35")
interface IAzOperations : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperations-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperations-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperations-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iaztask
@GUID("cb94e592-2e0e-4a6c-a336-b89a6dc1e388")
interface IAzTask : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_bizrule
    HRESULT get_BizRule(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_bizrule
    HRESULT put_BizRule(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_bizrulelanguage
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_bizrulelanguage
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_bizruleimportedpath
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_bizruleimportedpath
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_isroledefinition
    HRESULT get_IsRoleDefinition(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-put_isroledefinition
    HRESULT put_IsRoleDefinition(BOOL fProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_operations
    HRESULT get_Operations(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_tasks
    HRESULT get_Tasks(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-addoperation
    HRESULT AddOperation(BSTR bstrOp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-deleteoperation
    HRESULT DeleteOperation(BSTR bstrOp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-addtask
    HRESULT AddTask(BSTR bstrTask, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-deletetask
    HRESULT DeleteTask(BSTR bstrTask, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-addpropertyitem
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iaztasks
@GUID("b338ccab-4c85-4388-8c0a-c58592bad398")
interface IAzTasks : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztasks-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztasks-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztasks-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazscope
@GUID("00e52487-e08d-4514-b62e-877d5645f5ab")
interface IAzScope : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-addpropertyitem
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_policyadministrators
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_policyreaders
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-addpolicyadministrator
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletepolicyadministrator
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-addpolicyreader
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletepolicyreader
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_applicationgroups
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-openapplicationgroup
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-createapplicationgroup
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deleteapplicationgroup
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_roles
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-openrole
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-createrole
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deleterole
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_tasks
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-opentask
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-createtask
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletetask
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_canbedelegated
    HRESULT get_CanBeDelegated(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_bizruleswritable
    HRESULT get_BizrulesWritable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_policyadministratorsname
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-get_policyreadersname
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-addpolicyadministratorname
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletepolicyadministratorname
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-addpolicyreadername
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope-deletepolicyreadername
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazscopes
@GUID("78e14853-9f5e-406d-9b91-6bdba6973510")
interface IAzScopes : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscopes-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscopes-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscopes-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplicationgroup
@GUID("f1b744cd-58a6-4e06-9fbf-36f6d779e21e")
interface IAzApplicationGroup : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_type
    HRESULT get_Type(int* plProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-put_type
    HRESULT put_Type(int lProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_ldapquery
    HRESULT get_LdapQuery(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-put_ldapquery
    HRESULT put_LdapQuery(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_appmembers
    HRESULT get_AppMembers(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_appnonmembers
    HRESULT get_AppNonMembers(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_members
    HRESULT get_Members(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_nonmembers
    HRESULT get_NonMembers(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addappmember
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deleteappmember
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addappnonmember
    HRESULT AddAppNonMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deleteappnonmember
    HRESULT DeleteAppNonMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addmember
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deletemember
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addnonmember
    HRESULT AddNonMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deletenonmember
    HRESULT DeleteNonMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addpropertyitem
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addmembername
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deletemembername
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-addnonmembername
    HRESULT AddNonMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-deletenonmembername
    HRESULT DeleteNonMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_membersname
    HRESULT get_MembersName(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup-get_nonmembersname
    HRESULT get_NonMembersName(VARIANT* pvarProp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplicationgroups
@GUID("4ce66ad5-9f3c-469d-a911-b99887a7e685")
interface IAzApplicationGroups : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroups-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroups-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroups-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazrole
@GUID("859e0d8d-62d7-41d8-a034-c0cd5d43fdfa")
interface IAzRole : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_applicationdata
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-put_applicationdata
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addappmember
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deleteappmember
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addtask
    HRESULT AddTask(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deletetask
    HRESULT DeleteTask(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addoperation
    HRESULT AddOperation(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deleteoperation
    HRESULT DeleteOperation(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addmember
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deletemember
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_writable
    HRESULT get_Writable(BOOL* pfProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-setproperty
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_appmembers
    HRESULT get_AppMembers(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_members
    HRESULT get_Members(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_operations
    HRESULT get_Operations(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_tasks
    HRESULT get_Tasks(VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addpropertyitem
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deletepropertyitem
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-submit
    HRESULT Submit(int lFlags, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-addmembername
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-deletemembername
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazrole-get_membersname
    HRESULT get_MembersName(VARIANT* pvarProp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazroles
@GUID("95e0f119-13b4-4dae-b65f-2f7d60d822e4")
interface IAzRoles : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroles-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroles-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroles-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazclientcontext
@GUID("eff1f00b-488a-466d-afd9-a401c5f9eef5")
interface IAzClientContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-accesscheck
    HRESULT AccessCheck(BSTR bstrObjectName, VARIANT varScopeNames, VARIANT varOperations, 
                        VARIANT varParameterNames, VARIANT varParameterValues, VARIANT varInterfaceNames, 
                        VARIANT varInterfaceFlags, VARIANT varInterfaces, VARIANT* pvarResults);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-getbusinessrulestring
    HRESULT GetBusinessRuleString(BSTR* pbstrBusinessRuleString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_userdn
    HRESULT get_UserDn(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_usersamcompat
    HRESULT get_UserSamCompat(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_userdisplay
    HRESULT get_UserDisplay(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_userguid
    HRESULT get_UserGuid(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_usercanonical
    HRESULT get_UserCanonical(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_userupn
    HRESULT get_UserUpn(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_userdnssamcompat
    HRESULT get_UserDnsSamCompat(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-getproperty
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-getroles
    HRESULT GetRoles(BSTR bstrScopeName, VARIANT* pvarRoleNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-get_roleforaccesscheck
    HRESULT get_RoleForAccessCheck(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext-put_roleforaccesscheck
    HRESULT put_RoleForAccessCheck(BSTR bstrProp);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazclientcontext2
@GUID("2b0c92b8-208a-488a-8f81-e4edb22111cd")
interface IAzClientContext2 : IAzClientContext
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-getassignedscopespage
    HRESULT GetAssignedScopesPage(int lOptions, int PageSize, VARIANT* pvarCursor, VARIANT* pvarScopeNames);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-addroles
    HRESULT AddRoles(VARIANT varRoles, BSTR bstrScopeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-addapplicationgroups
    HRESULT AddApplicationGroups(VARIANT varApplicationGroups);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-addstringsids
    HRESULT AddStringSids(VARIANT varStringSids);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-put_ldapquerydn
    HRESULT put_LDAPQueryDN(BSTR bstrLDAPQueryDN);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext2-get_ldapquerydn
    HRESULT get_LDAPQueryDN(BSTR* pbstrLDAPQueryDN);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazbizrulecontext
@GUID("e192f17d-d59f-455e-a152-940316cd77b2")
interface IAzBizRuleContext : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizrulecontext-put_businessruleresult
    HRESULT put_BusinessRuleResult(BOOL bResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizrulecontext-put_businessrulestring
    HRESULT put_BusinessRuleString(BSTR bstrBusinessRuleString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizrulecontext-get_businessrulestring
    HRESULT get_BusinessRuleString(BSTR* pbstrBusinessRuleString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizrulecontext-getparameter
    HRESULT GetParameter(BSTR bstrParameterName, VARIANT* pvarParameterValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazbizruleparameters
@GUID("fc17685f-e25d-4dcd-bae1-276ec9533cb5")
interface IAzBizRuleParameters : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-addparameter
    HRESULT AddParameter(BSTR bstrParameterName, VARIANT varParameterValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-addparameters
    HRESULT AddParameters(VARIANT varParameterNames, VARIANT varParameterValues);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-getparametervalue
    HRESULT GetParameterValue(BSTR bstrParameterName, VARIANT* pvarParameterValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-remove
    HRESULT Remove(BSTR varParameterName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-removeall
    HRESULT RemoveAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleparameters-get_count
    HRESULT get_Count(uint* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazbizruleinterfaces
@GUID("e94128c7-e9da-44cc-b0bd-53036f3aab3d")
interface IAzBizRuleInterfaces : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-addinterface
    HRESULT AddInterface(BSTR bstrInterfaceName, int lInterfaceFlag, VARIANT varInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-addinterfaces
    HRESULT AddInterfaces(VARIANT varInterfaceNames, VARIANT varInterfaceFlags, VARIANT varInterfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-getinterfacevalue
    HRESULT GetInterfaceValue(BSTR bstrInterfaceName, int* lInterfaceFlag, VARIANT* varInterface);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-remove
    HRESULT Remove(BSTR bstrInterfaceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-removeall
    HRESULT RemoveAll();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazbizruleinterfaces-get_count
    HRESULT get_Count(uint* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazclientcontext3
@GUID("11894fde-1deb-4b4b-8907-6d1cda1f5d4f")
interface IAzClientContext3 : IAzClientContext2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-accesscheck2
    HRESULT AccessCheck2(BSTR bstrObjectName, BSTR bstrScopeName, int lOperation, uint* plResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-isinroleassignment
    HRESULT IsInRoleAssignment(BSTR bstrScopeName, BSTR bstrRoleName, VARIANT_BOOL* pbIsInRole);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-getoperations
    HRESULT GetOperations(BSTR bstrScopeName, IAzOperations* ppOperationCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-gettasks
    HRESULT GetTasks(BSTR bstrScopeName, IAzTasks* ppTaskCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-get_bizruleparameters
    HRESULT get_BizRuleParameters(IAzBizRuleParameters* ppBizRuleParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-get_bizruleinterfaces
    HRESULT get_BizRuleInterfaces(IAzBizRuleInterfaces* ppBizRuleInterfaces);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-getgroups
    HRESULT GetGroups(BSTR bstrScopeName, 
                      /*PARAM ATTR: AssociatedEnumAttribute : CustomAttributeSig([FixedArgSig(ElementSig(AZ_PROP_CONSTANTS))], [])*/uint ulOptions, 
                      VARIANT* pGroupArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazclientcontext3-get_sids
    HRESULT get_Sids(VARIANT* pStringSidArray);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazscope2
@GUID("ee9fe8c9-c9f3-40e2-aa12-d1d8599727fd")
interface IAzScope2 : IAzScope
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-get_roledefinitions
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-createroledefinition
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-openroledefinition
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-deleteroledefinition
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-get_roleassignments
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-createroleassignment
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-openroleassignment
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazscope2-deleteroleassignment
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplication3
@GUID("181c845e-7196-4a7d-ac2e-020c0bb7a303")
interface IAzApplication3 : IAzApplication2
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-scopeexists
    HRESULT ScopeExists(BSTR bstrScopeName, VARIANT_BOOL* pbExist);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-openscope2
    HRESULT OpenScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-createscope2
    HRESULT CreateScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-deletescope2
    HRESULT DeleteScope2(BSTR bstrScopeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-get_roledefinitions
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-createroledefinition
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-openroledefinition
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-deleteroledefinition
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-get_roleassignments
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-createroleassignment
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-openroleassignment
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-deleteroleassignment
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-get_bizrulesenabled
    HRESULT get_BizRulesEnabled(VARIANT_BOOL* pbEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplication3-put_bizrulesenabled
    HRESULT put_BizRulesEnabled(VARIANT_BOOL bEnabled);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazoperation2
@GUID("1f5ea01f-44a2-4184-9c48-a75b4dcc8ccc")
interface IAzOperation2 : IAzOperation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazoperation2-roleassignments
    HRESULT RoleAssignments(BSTR bstrScopeName, VARIANT_BOOL bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazroledefinitions
@GUID("881f25a5-d755-4550-957a-d503a3b34001")
interface IAzRoleDefinitions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinitions-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinitions-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinitions-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazroledefinition
@GUID("d97fcea1-2599-44f1-9fc3-58e9fbe09466")
interface IAzRoleDefinition : IAzTask
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinition-roleassignments
    HRESULT RoleAssignments(BSTR bstrScopeName, VARIANT_BOOL bRecursive, IAzRoleAssignments* ppRoleAssignments);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinition-addroledefinition
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinition-deleteroledefinition
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroledefinition-get_roledefinitions
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazroleassignment
@GUID("55647d31-0d5a-4fa3-b4ac-2b5f9ad5ab76")
interface IAzRoleAssignment : IAzRole
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignment-addroledefinition
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignment-deleteroledefinition
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignment-get_roledefinitions
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignment-get_scope
    HRESULT get_Scope(IAzScope* ppScope);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazroleassignments
@GUID("9c80b900-fceb-4d73-a0f4-c83b0bbf2481")
interface IAzRoleAssignments : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignments-get_item
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignments-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazroleassignments-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazprincipallocator
@GUID("e5c3507d-ad6a-4992-9c7f-74ab480b44cc")
interface IAzPrincipalLocator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazprincipallocator-get_nameresolver
    HRESULT get_NameResolver(IAzNameResolver* ppNameResolver);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazprincipallocator-get_objectpicker
    HRESULT get_ObjectPicker(IAzObjectPicker* ppObjectPicker);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iaznameresolver
@GUID("504d0f15-73e2-43df-a870-a64f40714f53")
interface IAzNameResolver : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaznameresolver-namefromsid
    HRESULT NameFromSid(BSTR bstrSid, int* pSidType, BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaznameresolver-namesfromsids
    HRESULT NamesFromSids(VARIANT vSids, VARIANT* pvSidTypes, VARIANT* pvNames);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazobjectpicker
@GUID("63130a48-699a-42d8-bf01-c62ac3fb79f9")
interface IAzObjectPicker : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazobjectpicker-getprincipals
    HRESULT GetPrincipals(HWND hParentWnd, BSTR bstrTitle, VARIANT* pvSidTypes, VARIANT* pvNames, VARIANT* pvSids);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazobjectpicker-get_name
    HRESULT get_Name(BSTR* pbstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iazapplicationgroup2
@GUID("3f0613fc-b71a-464e-a11d-5b881a56cefa")
interface IAzApplicationGroup2 : IAzApplicationGroup
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-get_bizrule
    HRESULT get_BizRule(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-put_bizrule
    HRESULT put_BizRule(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-get_bizrulelanguage
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-put_bizrulelanguage
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-get_bizruleimportedpath
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-put_bizruleimportedpath
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iazapplicationgroup2-roleassignments
    HRESULT RoleAssignments(BSTR bstrScopeName, VARIANT_BOOL bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nn-azroles-iaztask2
@GUID("03a9a5ee-48c8-4832-9025-aad503c46526")
interface IAzTask2 : IAzTask
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/azroles/nf-azroles-iaztask2-roleassignments
    HRESULT RoleAssignments(BSTR bstrScopeName, VARIANT_BOOL bRecursive, IAzRoleAssignments* ppRoleAssignments);
}


// GUIDs

const GUID CLSID_AzAuthorizationStore = GUIDOF!AzAuthorizationStore;
const GUID CLSID_AzBizRuleContext     = GUIDOF!AzBizRuleContext;
const GUID CLSID_AzPrincipalLocator   = GUIDOF!AzPrincipalLocator;

const GUID IID_IAzApplication         = GUIDOF!IAzApplication;
const GUID IID_IAzApplication2        = GUIDOF!IAzApplication2;
const GUID IID_IAzApplication3        = GUIDOF!IAzApplication3;
const GUID IID_IAzApplicationGroup    = GUIDOF!IAzApplicationGroup;
const GUID IID_IAzApplicationGroup2   = GUIDOF!IAzApplicationGroup2;
const GUID IID_IAzApplicationGroups   = GUIDOF!IAzApplicationGroups;
const GUID IID_IAzApplications        = GUIDOF!IAzApplications;
const GUID IID_IAzAuthorizationStore  = GUIDOF!IAzAuthorizationStore;
const GUID IID_IAzAuthorizationStore2 = GUIDOF!IAzAuthorizationStore2;
const GUID IID_IAzAuthorizationStore3 = GUIDOF!IAzAuthorizationStore3;
const GUID IID_IAzBizRuleContext      = GUIDOF!IAzBizRuleContext;
const GUID IID_IAzBizRuleInterfaces   = GUIDOF!IAzBizRuleInterfaces;
const GUID IID_IAzBizRuleParameters   = GUIDOF!IAzBizRuleParameters;
const GUID IID_IAzClientContext       = GUIDOF!IAzClientContext;
const GUID IID_IAzClientContext2      = GUIDOF!IAzClientContext2;
const GUID IID_IAzClientContext3      = GUIDOF!IAzClientContext3;
const GUID IID_IAzNameResolver        = GUIDOF!IAzNameResolver;
const GUID IID_IAzObjectPicker        = GUIDOF!IAzObjectPicker;
const GUID IID_IAzOperation           = GUIDOF!IAzOperation;
const GUID IID_IAzOperation2          = GUIDOF!IAzOperation2;
const GUID IID_IAzOperations          = GUIDOF!IAzOperations;
const GUID IID_IAzPrincipalLocator    = GUIDOF!IAzPrincipalLocator;
const GUID IID_IAzRole                = GUIDOF!IAzRole;
const GUID IID_IAzRoleAssignment      = GUIDOF!IAzRoleAssignment;
const GUID IID_IAzRoleAssignments     = GUIDOF!IAzRoleAssignments;
const GUID IID_IAzRoleDefinition      = GUIDOF!IAzRoleDefinition;
const GUID IID_IAzRoleDefinitions     = GUIDOF!IAzRoleDefinitions;
const GUID IID_IAzRoles               = GUIDOF!IAzRoles;
const GUID IID_IAzScope               = GUIDOF!IAzScope;
const GUID IID_IAzScope2              = GUIDOF!IAzScope2;
const GUID IID_IAzScopes              = GUIDOF!IAzScopes;
const GUID IID_IAzTask                = GUIDOF!IAzTask;
const GUID IID_IAzTask2               = GUIDOF!IAzTask2;
const GUID IID_IAzTasks               = GUIDOF!IAzTasks;
