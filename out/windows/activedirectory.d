module windows.activedirectory;

public import windows.core;
public import windows.automation : BSTR, DISPPARAMS, EXCEPINFO, IDispatch, IEnumVARIANT, IPropertyBag, ITypeInfo,
                                   VARIANT;
public import windows.com : HRESULT, IDataObject, IPersist, IUnknown;
public import windows.controls : LPFNADDPROPSHEETPAGE;
public import windows.gdi : HICON;
public import windows.security : LSA_FOREST_TRUST_INFORMATION;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LARGE_INTEGER;
public import windows.winsock : SOCKET_ADDRESS;
public import windows.windowsandmessaging : DLGPROC, HWND, LPARAM, WPARAM;
public import windows.windowsprogramming : FILETIME, HKEY, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    ADSTYPE_INVALID                = 0x00000000,
    ADSTYPE_DN_STRING              = 0x00000001,
    ADSTYPE_CASE_EXACT_STRING      = 0x00000002,
    ADSTYPE_CASE_IGNORE_STRING     = 0x00000003,
    ADSTYPE_PRINTABLE_STRING       = 0x00000004,
    ADSTYPE_NUMERIC_STRING         = 0x00000005,
    ADSTYPE_BOOLEAN                = 0x00000006,
    ADSTYPE_INTEGER                = 0x00000007,
    ADSTYPE_OCTET_STRING           = 0x00000008,
    ADSTYPE_UTC_TIME               = 0x00000009,
    ADSTYPE_LARGE_INTEGER          = 0x0000000a,
    ADSTYPE_PROV_SPECIFIC          = 0x0000000b,
    ADSTYPE_OBJECT_CLASS           = 0x0000000c,
    ADSTYPE_CASEIGNORE_LIST        = 0x0000000d,
    ADSTYPE_OCTET_LIST             = 0x0000000e,
    ADSTYPE_PATH                   = 0x0000000f,
    ADSTYPE_POSTALADDRESS          = 0x00000010,
    ADSTYPE_TIMESTAMP              = 0x00000011,
    ADSTYPE_BACKLINK               = 0x00000012,
    ADSTYPE_TYPEDNAME              = 0x00000013,
    ADSTYPE_HOLD                   = 0x00000014,
    ADSTYPE_NETADDRESS             = 0x00000015,
    ADSTYPE_REPLICAPOINTER         = 0x00000016,
    ADSTYPE_FAXNUMBER              = 0x00000017,
    ADSTYPE_EMAIL                  = 0x00000018,
    ADSTYPE_NT_SECURITY_DESCRIPTOR = 0x00000019,
    ADSTYPE_UNKNOWN                = 0x0000001a,
    ADSTYPE_DN_WITH_BINARY         = 0x0000001b,
    ADSTYPE_DN_WITH_STRING         = 0x0000001c,
}
alias ADSTYPEENUM = int;

enum : int
{
    ADS_SECURE_AUTHENTICATION = 0x00000001,
    ADS_USE_ENCRYPTION        = 0x00000002,
    ADS_USE_SSL               = 0x00000002,
    ADS_READONLY_SERVER       = 0x00000004,
    ADS_PROMPT_CREDENTIALS    = 0x00000008,
    ADS_NO_AUTHENTICATION     = 0x00000010,
    ADS_FAST_BIND             = 0x00000020,
    ADS_USE_SIGNING           = 0x00000040,
    ADS_USE_SEALING           = 0x00000080,
    ADS_USE_DELEGATION        = 0x00000100,
    ADS_SERVER_BIND           = 0x00000200,
    ADS_NO_REFERRAL_CHASING   = 0x00000400,
    ADS_AUTH_RESERVED         = 0x80000000,
}
alias ADS_AUTHENTICATION_ENUM = int;

enum : int
{
    ADS_STATUS_S_OK                    = 0x00000000,
    ADS_STATUS_INVALID_SEARCHPREF      = 0x00000001,
    ADS_STATUS_INVALID_SEARCHPREFVALUE = 0x00000002,
}
alias ADS_STATUSENUM = int;

enum : int
{
    ADS_DEREF_NEVER     = 0x00000000,
    ADS_DEREF_SEARCHING = 0x00000001,
    ADS_DEREF_FINDING   = 0x00000002,
    ADS_DEREF_ALWAYS    = 0x00000003,
}
alias ADS_DEREFENUM = int;

enum : int
{
    ADS_SCOPE_BASE     = 0x00000000,
    ADS_SCOPE_ONELEVEL = 0x00000001,
    ADS_SCOPE_SUBTREE  = 0x00000002,
}
alias ADS_SCOPEENUM = int;

enum : int
{
    ADSIPROP_ASYNCHRONOUS     = 0x00000000,
    ADSIPROP_DEREF_ALIASES    = 0x00000001,
    ADSIPROP_SIZE_LIMIT       = 0x00000002,
    ADSIPROP_TIME_LIMIT       = 0x00000003,
    ADSIPROP_ATTRIBTYPES_ONLY = 0x00000004,
    ADSIPROP_SEARCH_SCOPE     = 0x00000005,
    ADSIPROP_TIMEOUT          = 0x00000006,
    ADSIPROP_PAGESIZE         = 0x00000007,
    ADSIPROP_PAGED_TIME_LIMIT = 0x00000008,
    ADSIPROP_CHASE_REFERRALS  = 0x00000009,
    ADSIPROP_SORT_ON          = 0x0000000a,
    ADSIPROP_CACHE_RESULTS    = 0x0000000b,
    ADSIPROP_ADSIFLAG         = 0x0000000c,
}
alias ADS_PREFERENCES_ENUM = int;

enum : int
{
    ADSI_DIALECT_LDAP = 0x00000000,
    ADSI_DIALECT_SQL  = 0x00000001,
}
alias ADSI_DIALECT_ENUM = int;

enum : int
{
    ADS_CHASE_REFERRALS_NEVER       = 0x00000000,
    ADS_CHASE_REFERRALS_SUBORDINATE = 0x00000020,
    ADS_CHASE_REFERRALS_EXTERNAL    = 0x00000040,
    ADS_CHASE_REFERRALS_ALWAYS      = 0x00000060,
}
alias ADS_CHASE_REFERRALS_ENUM = int;

enum : int
{
    ADS_SEARCHPREF_ASYNCHRONOUS     = 0x00000000,
    ADS_SEARCHPREF_DEREF_ALIASES    = 0x00000001,
    ADS_SEARCHPREF_SIZE_LIMIT       = 0x00000002,
    ADS_SEARCHPREF_TIME_LIMIT       = 0x00000003,
    ADS_SEARCHPREF_ATTRIBTYPES_ONLY = 0x00000004,
    ADS_SEARCHPREF_SEARCH_SCOPE     = 0x00000005,
    ADS_SEARCHPREF_TIMEOUT          = 0x00000006,
    ADS_SEARCHPREF_PAGESIZE         = 0x00000007,
    ADS_SEARCHPREF_PAGED_TIME_LIMIT = 0x00000008,
    ADS_SEARCHPREF_CHASE_REFERRALS  = 0x00000009,
    ADS_SEARCHPREF_SORT_ON          = 0x0000000a,
    ADS_SEARCHPREF_CACHE_RESULTS    = 0x0000000b,
    ADS_SEARCHPREF_DIRSYNC          = 0x0000000c,
    ADS_SEARCHPREF_TOMBSTONE        = 0x0000000d,
    ADS_SEARCHPREF_VLV              = 0x0000000e,
    ADS_SEARCHPREF_ATTRIBUTE_QUERY  = 0x0000000f,
    ADS_SEARCHPREF_SECURITY_MASK    = 0x00000010,
    ADS_SEARCHPREF_DIRSYNC_FLAG     = 0x00000011,
    ADS_SEARCHPREF_EXTENDED_DN      = 0x00000012,
}
alias ADS_SEARCHPREF_ENUM = int;

enum : int
{
    ADS_PASSWORD_ENCODE_REQUIRE_SSL = 0x00000000,
    ADS_PASSWORD_ENCODE_CLEAR       = 0x00000001,
}
alias ADS_PASSWORD_ENCODING_ENUM = int;

enum : int
{
    ADS_PROPERTY_CLEAR  = 0x00000001,
    ADS_PROPERTY_UPDATE = 0x00000002,
    ADS_PROPERTY_APPEND = 0x00000003,
    ADS_PROPERTY_DELETE = 0x00000004,
}
alias ADS_PROPERTY_OPERATION_ENUM = int;

enum : int
{
    ADS_SYSTEMFLAG_DISALLOW_DELETE           = 0x80000000,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_RENAME       = 0x40000000,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_MOVE         = 0x20000000,
    ADS_SYSTEMFLAG_CONFIG_ALLOW_LIMITED_MOVE = 0x10000000,
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_RENAME    = 0x08000000,
    ADS_SYSTEMFLAG_DOMAIN_DISALLOW_MOVE      = 0x04000000,
    ADS_SYSTEMFLAG_CR_NTDS_NC                = 0x00000001,
    ADS_SYSTEMFLAG_CR_NTDS_DOMAIN            = 0x00000002,
    ADS_SYSTEMFLAG_ATTR_NOT_REPLICATED       = 0x00000001,
    ADS_SYSTEMFLAG_ATTR_IS_CONSTRUCTED       = 0x00000004,
}
alias ADS_SYSTEMFLAG_ENUM = int;

enum : int
{
    ADS_GROUP_TYPE_GLOBAL_GROUP       = 0x00000002,
    ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = 0x00000004,
    ADS_GROUP_TYPE_LOCAL_GROUP        = 0x00000004,
    ADS_GROUP_TYPE_UNIVERSAL_GROUP    = 0x00000008,
    ADS_GROUP_TYPE_SECURITY_ENABLED   = 0x80000000,
}
alias ADS_GROUP_TYPE_ENUM = int;

enum : int
{
    ADS_UF_SCRIPT                                 = 0x00000001,
    ADS_UF_ACCOUNTDISABLE                         = 0x00000002,
    ADS_UF_HOMEDIR_REQUIRED                       = 0x00000008,
    ADS_UF_LOCKOUT                                = 0x00000010,
    ADS_UF_PASSWD_NOTREQD                         = 0x00000020,
    ADS_UF_PASSWD_CANT_CHANGE                     = 0x00000040,
    ADS_UF_ENCRYPTED_TEXT_PASSWORD_ALLOWED        = 0x00000080,
    ADS_UF_TEMP_DUPLICATE_ACCOUNT                 = 0x00000100,
    ADS_UF_NORMAL_ACCOUNT                         = 0x00000200,
    ADS_UF_INTERDOMAIN_TRUST_ACCOUNT              = 0x00000800,
    ADS_UF_WORKSTATION_TRUST_ACCOUNT              = 0x00001000,
    ADS_UF_SERVER_TRUST_ACCOUNT                   = 0x00002000,
    ADS_UF_DONT_EXPIRE_PASSWD                     = 0x00010000,
    ADS_UF_MNS_LOGON_ACCOUNT                      = 0x00020000,
    ADS_UF_SMARTCARD_REQUIRED                     = 0x00040000,
    ADS_UF_TRUSTED_FOR_DELEGATION                 = 0x00080000,
    ADS_UF_NOT_DELEGATED                          = 0x00100000,
    ADS_UF_USE_DES_KEY_ONLY                       = 0x00200000,
    ADS_UF_DONT_REQUIRE_PREAUTH                   = 0x00400000,
    ADS_UF_PASSWORD_EXPIRED                       = 0x00800000,
    ADS_UF_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x01000000,
}
alias ADS_USER_FLAG_ENUM = int;

enum : int
{
    ADS_RIGHT_DELETE                 = 0x00010000,
    ADS_RIGHT_READ_CONTROL           = 0x00020000,
    ADS_RIGHT_WRITE_DAC              = 0x00040000,
    ADS_RIGHT_WRITE_OWNER            = 0x00080000,
    ADS_RIGHT_SYNCHRONIZE            = 0x00100000,
    ADS_RIGHT_ACCESS_SYSTEM_SECURITY = 0x01000000,
    ADS_RIGHT_GENERIC_READ           = 0x80000000,
    ADS_RIGHT_GENERIC_WRITE          = 0x40000000,
    ADS_RIGHT_GENERIC_EXECUTE        = 0x20000000,
    ADS_RIGHT_GENERIC_ALL            = 0x10000000,
    ADS_RIGHT_DS_CREATE_CHILD        = 0x00000001,
    ADS_RIGHT_DS_DELETE_CHILD        = 0x00000002,
    ADS_RIGHT_ACTRL_DS_LIST          = 0x00000004,
    ADS_RIGHT_DS_SELF                = 0x00000008,
    ADS_RIGHT_DS_READ_PROP           = 0x00000010,
    ADS_RIGHT_DS_WRITE_PROP          = 0x00000020,
    ADS_RIGHT_DS_DELETE_TREE         = 0x00000040,
    ADS_RIGHT_DS_LIST_OBJECT         = 0x00000080,
    ADS_RIGHT_DS_CONTROL_ACCESS      = 0x00000100,
}
alias ADS_RIGHTS_ENUM = int;

enum : int
{
    ADS_ACETYPE_ACCESS_ALLOWED                 = 0x00000000,
    ADS_ACETYPE_ACCESS_DENIED                  = 0x00000001,
    ADS_ACETYPE_SYSTEM_AUDIT                   = 0x00000002,
    ADS_ACETYPE_ACCESS_ALLOWED_OBJECT          = 0x00000005,
    ADS_ACETYPE_ACCESS_DENIED_OBJECT           = 0x00000006,
    ADS_ACETYPE_SYSTEM_AUDIT_OBJECT            = 0x00000007,
    ADS_ACETYPE_SYSTEM_ALARM_OBJECT            = 0x00000008,
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK        = 0x00000009,
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK         = 0x0000000a,
    ADS_ACETYPE_ACCESS_ALLOWED_CALLBACK_OBJECT = 0x0000000b,
    ADS_ACETYPE_ACCESS_DENIED_CALLBACK_OBJECT  = 0x0000000c,
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK          = 0x0000000d,
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK          = 0x0000000e,
    ADS_ACETYPE_SYSTEM_AUDIT_CALLBACK_OBJECT   = 0x0000000f,
    ADS_ACETYPE_SYSTEM_ALARM_CALLBACK_OBJECT   = 0x00000010,
}
alias ADS_ACETYPE_ENUM = int;

enum : int
{
    ADS_ACEFLAG_INHERIT_ACE              = 0x00000002,
    ADS_ACEFLAG_NO_PROPAGATE_INHERIT_ACE = 0x00000004,
    ADS_ACEFLAG_INHERIT_ONLY_ACE         = 0x00000008,
    ADS_ACEFLAG_INHERITED_ACE            = 0x00000010,
    ADS_ACEFLAG_VALID_INHERIT_FLAGS      = 0x0000001f,
    ADS_ACEFLAG_SUCCESSFUL_ACCESS        = 0x00000040,
    ADS_ACEFLAG_FAILED_ACCESS            = 0x00000080,
}
alias ADS_ACEFLAG_ENUM = int;

enum : int
{
    ADS_FLAG_OBJECT_TYPE_PRESENT           = 0x00000001,
    ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT = 0x00000002,
}
alias ADS_FLAGTYPE_ENUM = int;

enum : int
{
    ADS_SD_CONTROL_SE_OWNER_DEFAULTED       = 0x00000001,
    ADS_SD_CONTROL_SE_GROUP_DEFAULTED       = 0x00000002,
    ADS_SD_CONTROL_SE_DACL_PRESENT          = 0x00000004,
    ADS_SD_CONTROL_SE_DACL_DEFAULTED        = 0x00000008,
    ADS_SD_CONTROL_SE_SACL_PRESENT          = 0x00000010,
    ADS_SD_CONTROL_SE_SACL_DEFAULTED        = 0x00000020,
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERIT_REQ = 0x00000100,
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERIT_REQ = 0x00000200,
    ADS_SD_CONTROL_SE_DACL_AUTO_INHERITED   = 0x00000400,
    ADS_SD_CONTROL_SE_SACL_AUTO_INHERITED   = 0x00000800,
    ADS_SD_CONTROL_SE_DACL_PROTECTED        = 0x00001000,
    ADS_SD_CONTROL_SE_SACL_PROTECTED        = 0x00002000,
    ADS_SD_CONTROL_SE_SELF_RELATIVE         = 0x00008000,
}
alias ADS_SD_CONTROL_ENUM = int;

enum : int
{
    ADS_SD_REVISION_DS = 0x00000004,
}
alias ADS_SD_REVISION_ENUM = int;

enum : int
{
    ADS_NAME_TYPE_1779                    = 0x00000001,
    ADS_NAME_TYPE_CANONICAL               = 0x00000002,
    ADS_NAME_TYPE_NT4                     = 0x00000003,
    ADS_NAME_TYPE_DISPLAY                 = 0x00000004,
    ADS_NAME_TYPE_DOMAIN_SIMPLE           = 0x00000005,
    ADS_NAME_TYPE_ENTERPRISE_SIMPLE       = 0x00000006,
    ADS_NAME_TYPE_GUID                    = 0x00000007,
    ADS_NAME_TYPE_UNKNOWN                 = 0x00000008,
    ADS_NAME_TYPE_USER_PRINCIPAL_NAME     = 0x00000009,
    ADS_NAME_TYPE_CANONICAL_EX            = 0x0000000a,
    ADS_NAME_TYPE_SERVICE_PRINCIPAL_NAME  = 0x0000000b,
    ADS_NAME_TYPE_SID_OR_SID_HISTORY_NAME = 0x0000000c,
}
alias ADS_NAME_TYPE_ENUM = int;

enum : int
{
    ADS_NAME_INITTYPE_DOMAIN = 0x00000001,
    ADS_NAME_INITTYPE_SERVER = 0x00000002,
    ADS_NAME_INITTYPE_GC     = 0x00000003,
}
alias ADS_NAME_INITTYPE_ENUM = int;

enum : int
{
    ADS_OPTION_SERVERNAME                = 0x00000000,
    ADS_OPTION_REFERRALS                 = 0x00000001,
    ADS_OPTION_PAGE_SIZE                 = 0x00000002,
    ADS_OPTION_SECURITY_MASK             = 0x00000003,
    ADS_OPTION_MUTUAL_AUTH_STATUS        = 0x00000004,
    ADS_OPTION_QUOTA                     = 0x00000005,
    ADS_OPTION_PASSWORD_PORTNUMBER       = 0x00000006,
    ADS_OPTION_PASSWORD_METHOD           = 0x00000007,
    ADS_OPTION_ACCUMULATIVE_MODIFICATION = 0x00000008,
    ADS_OPTION_SKIP_SID_LOOKUP           = 0x00000009,
}
alias ADS_OPTION_ENUM = int;

enum : int
{
    ADS_SECURITY_INFO_OWNER = 0x00000001,
    ADS_SECURITY_INFO_GROUP = 0x00000002,
    ADS_SECURITY_INFO_DACL  = 0x00000004,
    ADS_SECURITY_INFO_SACL  = 0x00000008,
}
alias ADS_SECURITY_INFO_ENUM = int;

enum : int
{
    ADS_SETTYPE_FULL     = 0x00000001,
    ADS_SETTYPE_PROVIDER = 0x00000002,
    ADS_SETTYPE_SERVER   = 0x00000003,
    ADS_SETTYPE_DN       = 0x00000004,
}
alias ADS_SETTYPE_ENUM = int;

enum : int
{
    ADS_FORMAT_WINDOWS           = 0x00000001,
    ADS_FORMAT_WINDOWS_NO_SERVER = 0x00000002,
    ADS_FORMAT_WINDOWS_DN        = 0x00000003,
    ADS_FORMAT_WINDOWS_PARENT    = 0x00000004,
    ADS_FORMAT_X500              = 0x00000005,
    ADS_FORMAT_X500_NO_SERVER    = 0x00000006,
    ADS_FORMAT_X500_DN           = 0x00000007,
    ADS_FORMAT_X500_PARENT       = 0x00000008,
    ADS_FORMAT_SERVER            = 0x00000009,
    ADS_FORMAT_PROVIDER          = 0x0000000a,
    ADS_FORMAT_LEAF              = 0x0000000b,
}
alias ADS_FORMAT_ENUM = int;

enum : int
{
    ADS_DISPLAY_FULL       = 0x00000001,
    ADS_DISPLAY_VALUE_ONLY = 0x00000002,
}
alias ADS_DISPLAY_ENUM = int;

enum : int
{
    ADS_ESCAPEDMODE_DEFAULT = 0x00000001,
    ADS_ESCAPEDMODE_ON      = 0x00000002,
    ADS_ESCAPEDMODE_OFF     = 0x00000003,
    ADS_ESCAPEDMODE_OFF_EX  = 0x00000004,
}
alias ADS_ESCAPE_MODE_ENUM = int;

enum : int
{
    ADS_PATH_FILE      = 0x00000001,
    ADS_PATH_FILESHARE = 0x00000002,
    ADS_PATH_REGISTRY  = 0x00000003,
}
alias ADS_PATHTYPE_ENUM = int;

enum : int
{
    ADS_SD_FORMAT_IID       = 0x00000001,
    ADS_SD_FORMAT_RAW       = 0x00000002,
    ADS_SD_FORMAT_HEXSTRING = 0x00000003,
}
alias ADS_SD_FORMAT_ENUM = int;

enum : int
{
    DS_MANGLE_UNKNOWN                      = 0x00000000,
    DS_MANGLE_OBJECT_RDN_FOR_DELETION      = 0x00000001,
    DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT = 0x00000002,
}
alias DS_MANGLE_FOR = int;

enum : int
{
    DS_UNKNOWN_NAME            = 0x00000000,
    DS_FQDN_1779_NAME          = 0x00000001,
    DS_NT4_ACCOUNT_NAME        = 0x00000002,
    DS_DISPLAY_NAME            = 0x00000003,
    DS_UNIQUE_ID_NAME          = 0x00000006,
    DS_CANONICAL_NAME          = 0x00000007,
    DS_USER_PRINCIPAL_NAME     = 0x00000008,
    DS_CANONICAL_NAME_EX       = 0x00000009,
    DS_SERVICE_PRINCIPAL_NAME  = 0x0000000a,
    DS_SID_OR_SID_HISTORY_NAME = 0x0000000b,
    DS_DNS_DOMAIN_NAME         = 0x0000000c,
}
alias DS_NAME_FORMAT = int;

enum : int
{
    DS_NAME_NO_FLAGS              = 0x00000000,
    DS_NAME_FLAG_SYNTACTICAL_ONLY = 0x00000001,
    DS_NAME_FLAG_EVAL_AT_DC       = 0x00000002,
    DS_NAME_FLAG_GCVERIFY         = 0x00000004,
    DS_NAME_FLAG_TRUST_REFERRAL   = 0x00000008,
}
alias DS_NAME_FLAGS = int;

enum : int
{
    DS_NAME_NO_ERROR                     = 0x00000000,
    DS_NAME_ERROR_RESOLVING              = 0x00000001,
    DS_NAME_ERROR_NOT_FOUND              = 0x00000002,
    DS_NAME_ERROR_NOT_UNIQUE             = 0x00000003,
    DS_NAME_ERROR_NO_MAPPING             = 0x00000004,
    DS_NAME_ERROR_DOMAIN_ONLY            = 0x00000005,
    DS_NAME_ERROR_NO_SYNTACTICAL_MAPPING = 0x00000006,
    DS_NAME_ERROR_TRUST_REFERRAL         = 0x00000007,
}
alias DS_NAME_ERROR = int;

enum : int
{
    DS_SPN_DNS_HOST  = 0x00000000,
    DS_SPN_DN_HOST   = 0x00000001,
    DS_SPN_NB_HOST   = 0x00000002,
    DS_SPN_DOMAIN    = 0x00000003,
    DS_SPN_NB_DOMAIN = 0x00000004,
    DS_SPN_SERVICE   = 0x00000005,
}
alias DS_SPN_NAME_TYPE = int;

enum : int
{
    DS_SPN_ADD_SPN_OP     = 0x00000000,
    DS_SPN_REPLACE_SPN_OP = 0x00000001,
    DS_SPN_DELETE_SPN_OP  = 0x00000002,
}
alias DS_SPN_WRITE_OP = int;

enum : int
{
    DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER = 0x00000000,
    DS_REPSYNCALL_WIN32_ERROR_REPLICATING       = 0x00000001,
    DS_REPSYNCALL_SERVER_UNREACHABLE            = 0x00000002,
}
alias DS_REPSYNCALL_ERROR = int;

enum : int
{
    DS_REPSYNCALL_EVENT_ERROR          = 0x00000000,
    DS_REPSYNCALL_EVENT_SYNC_STARTED   = 0x00000001,
    DS_REPSYNCALL_EVENT_SYNC_COMPLETED = 0x00000002,
    DS_REPSYNCALL_EVENT_FINISHED       = 0x00000003,
}
alias DS_REPSYNCALL_EVENT = int;

enum : int
{
    DS_KCC_TASKID_UPDATE_TOPOLOGY = 0x00000000,
}
alias DS_KCC_TASKID = int;

enum : int
{
    DS_REPL_INFO_NEIGHBORS                   = 0x00000000,
    DS_REPL_INFO_CURSORS_FOR_NC              = 0x00000001,
    DS_REPL_INFO_METADATA_FOR_OBJ            = 0x00000002,
    DS_REPL_INFO_KCC_DSA_CONNECT_FAILURES    = 0x00000003,
    DS_REPL_INFO_KCC_DSA_LINK_FAILURES       = 0x00000004,
    DS_REPL_INFO_PENDING_OPS                 = 0x00000005,
    DS_REPL_INFO_METADATA_FOR_ATTR_VALUE     = 0x00000006,
    DS_REPL_INFO_CURSORS_2_FOR_NC            = 0x00000007,
    DS_REPL_INFO_CURSORS_3_FOR_NC            = 0x00000008,
    DS_REPL_INFO_METADATA_2_FOR_OBJ          = 0x00000009,
    DS_REPL_INFO_METADATA_2_FOR_ATTR_VALUE   = 0x0000000a,
    DS_REPL_INFO_METADATA_EXT_FOR_ATTR_VALUE = 0x0000000b,
    DS_REPL_INFO_TYPE_MAX                    = 0x0000000c,
}
alias DS_REPL_INFO_TYPE = int;

enum : int
{
    DS_REPL_OP_TYPE_SYNC        = 0x00000000,
    DS_REPL_OP_TYPE_ADD         = 0x00000001,
    DS_REPL_OP_TYPE_DELETE      = 0x00000002,
    DS_REPL_OP_TYPE_MODIFY      = 0x00000003,
    DS_REPL_OP_TYPE_UPDATE_REFS = 0x00000004,
}
alias DS_REPL_OP_TYPE = int;

enum : int
{
    DsRole_RoleStandaloneWorkstation   = 0x00000000,
    DsRole_RoleMemberWorkstation       = 0x00000001,
    DsRole_RoleStandaloneServer        = 0x00000002,
    DsRole_RoleMemberServer            = 0x00000003,
    DsRole_RoleBackupDomainController  = 0x00000004,
    DsRole_RolePrimaryDomainController = 0x00000005,
}
alias DSROLE_MACHINE_ROLE = int;

enum : int
{
    DsRoleServerUnknown = 0x00000000,
    DsRoleServerPrimary = 0x00000001,
    DsRoleServerBackup  = 0x00000002,
}
alias DSROLE_SERVER_STATE = int;

enum : int
{
    DsRolePrimaryDomainInfoBasic = 0x00000001,
    DsRoleUpgradeStatus          = 0x00000002,
    DsRoleOperationState         = 0x00000003,
}
alias DSROLE_PRIMARY_DOMAIN_INFO_LEVEL = int;

enum : int
{
    DsRoleOperationIdle       = 0x00000000,
    DsRoleOperationActive     = 0x00000001,
    DsRoleOperationNeedReboot = 0x00000002,
}
alias DSROLE_OPERATION_STATE = int;

// Callbacks

alias LPCQADDFORMSPROC = HRESULT function(LPARAM lParam, CQFORM* pForm);
alias LPCQADDPAGESPROC = HRESULT function(LPARAM lParam, const(GUID)* clsidForm, CQPAGE* pPage);
alias LPCQPAGEPROC = HRESULT function(CQPAGE* pPage, HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias LPDSENUMATTRIBUTES = HRESULT function(LPARAM lParam, const(wchar)* pszAttributeName, 
                                            const(wchar)* pszDisplayName, uint dwFlags);
alias BFFCALLBACK = int function(HWND hwnd, uint uMsg, LPARAM lParam, LPARAM lpData);

// Structs


struct CQFORM
{
    uint          cbStruct;
    uint          dwFlags;
    GUID          clsid;
    HICON         hIcon;
    const(wchar)* pszTitle;
}

struct CQPAGE
{
    uint         cbStruct;
    uint         dwFlags;
    LPCQPAGEPROC pPageProc;
    HINSTANCE    hInstance;
    int          idPageName;
    int          idPageTemplate;
    DLGPROC      pDlgProc;
    LPARAM       lParam;
}

struct OPENQUERYWINDOW
{
    uint          cbStruct;
    uint          dwFlags;
    GUID          clsidHandler;
    void*         pHandlerParameters;
    GUID          clsidDefaultForm;
    IPersistQuery pPersistQuery;
    union
    {
        void*        pFormParameters;
        IPropertyBag ppbFormParameters;
    }
}

struct ADS_OCTET_STRING
{
    uint   dwLength;
    ubyte* lpValue;
}

struct ADS_NT_SECURITY_DESCRIPTOR
{
    uint   dwLength;
    ubyte* lpValue;
}

struct ADS_PROV_SPECIFIC
{
    uint   dwLength;
    ubyte* lpValue;
}

struct ADS_CASEIGNORE_LIST
{
    ADS_CASEIGNORE_LIST* Next;
    const(wchar)*        String;
}

struct ADS_OCTET_LIST
{
    ADS_OCTET_LIST* Next;
    uint            Length;
    ubyte*          Data;
}

struct ADS_PATH
{
    uint          Type;
    const(wchar)* VolumeName;
    const(wchar)* Path;
}

struct ADS_POSTALADDRESS
{
    ushort[6]* PostalAddress;
}

struct ADS_TIMESTAMP
{
    uint WholeSeconds;
    uint EventID;
}

struct ADS_BACKLINK
{
    uint          RemoteID;
    const(wchar)* ObjectName;
}

struct ADS_TYPEDNAME
{
    const(wchar)* ObjectName;
    uint          Level;
    uint          Interval;
}

struct ADS_HOLD
{
    const(wchar)* ObjectName;
    uint          Amount;
}

struct ADS_NETADDRESS
{
    uint   AddressType;
    uint   AddressLength;
    ubyte* Address;
}

struct ADS_REPLICAPOINTER
{
    const(wchar)*   ServerName;
    uint            ReplicaType;
    uint            ReplicaNumber;
    uint            Count;
    ADS_NETADDRESS* ReplicaAddressHints;
}

struct ADS_FAXNUMBER
{
    const(wchar)* TelephoneNumber;
    uint          NumberOfBits;
    ubyte*        Parameters;
}

struct ADS_EMAIL
{
    const(wchar)* Address;
    uint          Type;
}

struct ADS_DN_WITH_BINARY
{
    uint          dwLength;
    ubyte*        lpBinaryValue;
    const(wchar)* pszDNString;
}

struct ADS_DN_WITH_STRING
{
    const(wchar)* pszStringValue;
    const(wchar)* pszDNString;
}

struct ADSVALUE
{
    ADSTYPEENUM dwType;
    union
    {
        ushort*              DNString;
        ushort*              CaseExactString;
        ushort*              CaseIgnoreString;
        ushort*              PrintableString;
        ushort*              NumericString;
        uint                 Boolean;
        uint                 Integer;
        ADS_OCTET_STRING     OctetString;
        SYSTEMTIME           UTCTime;
        LARGE_INTEGER        LargeInteger;
        ushort*              ClassName;
        ADS_PROV_SPECIFIC    ProviderSpecific;
        ADS_CASEIGNORE_LIST* pCaseIgnoreList;
        ADS_OCTET_LIST*      pOctetList;
        ADS_PATH*            pPath;
        ADS_POSTALADDRESS*   pPostalAddress;
        ADS_TIMESTAMP        Timestamp;
        ADS_BACKLINK         BackLink;
        ADS_TYPEDNAME*       pTypedName;
        ADS_HOLD             Hold;
        ADS_NETADDRESS*      pNetAddress;
        ADS_REPLICAPOINTER*  pReplicaPointer;
        ADS_FAXNUMBER*       pFaxNumber;
        ADS_EMAIL            Email;
        ADS_NT_SECURITY_DESCRIPTOR SecurityDescriptor;
        ADS_DN_WITH_BINARY*  pDNWithBinary;
        ADS_DN_WITH_STRING*  pDNWithString;
    }
}

struct ADS_ATTR_INFO
{
    const(wchar)* pszAttrName;
    uint          dwControlCode;
    ADSTYPEENUM   dwADsType;
    ADSVALUE*     pADsValues;
    uint          dwNumValues;
}

struct ADS_OBJECT_INFO
{
    const(wchar)* pszRDN;
    const(wchar)* pszObjectDN;
    const(wchar)* pszParentDN;
    const(wchar)* pszSchemaDN;
    const(wchar)* pszClassName;
}

struct ads_searchpref_info
{
    ADS_SEARCHPREF_ENUM dwSearchPref;
    ADSVALUE            vValue;
    ADS_STATUSENUM      dwStatus;
}

struct ads_search_column
{
    const(wchar)* pszAttrName;
    ADSTYPEENUM   dwADsType;
    ADSVALUE*     pADsValues;
    uint          dwNumValues;
    HANDLE        hReserved;
}

struct ADS_ATTR_DEF
{
    const(wchar)* pszAttrName;
    ADSTYPEENUM   dwADsType;
    uint          dwMinRange;
    uint          dwMaxRange;
    BOOL          fMultiValued;
}

struct ADS_CLASS_DEF
{
    const(wchar)* pszClassName;
    uint          dwMandatoryAttrs;
    ushort**      ppszMandatoryAttrs;
    uint          optionalAttrs;
    ushort***     ppszOptionalAttrs;
    uint          dwNamingAttrs;
    ushort***     ppszNamingAttrs;
    uint          dwSuperClasses;
    ushort***     ppszSuperClasses;
    BOOL          fIsContainer;
}

struct ADS_SORTKEY
{
    const(wchar)* pszAttrType;
    const(wchar)* pszReserved;
    ubyte         fReverseorder;
}

struct ADS_VLV
{
    uint          dwBeforeCount;
    uint          dwAfterCount;
    uint          dwOffset;
    uint          dwContentCount;
    const(wchar)* pszTarget;
    uint          dwContextIDLength;
    ubyte*        lpContextID;
}

struct DSOBJECT
{
    uint dwFlags;
    uint dwProviderFlags;
    uint offsetName;
    uint offsetClass;
}

struct DSOBJECTNAMES
{
    GUID        clsidNamespace;
    uint        cItems;
    DSOBJECT[1] aObjects;
}

struct DSDISPLAYSPECOPTIONS
{
    uint dwSize;
    uint dwFlags;
    uint offsetAttribPrefix;
    uint offsetUserName;
    uint offsetPassword;
    uint offsetServer;
    uint offsetServerConfigPath;
}

struct DSPROPERTYPAGEINFO
{
    uint offsetString;
}

struct DOMAINDESC
{
    const(wchar)* pszName;
    const(wchar)* pszPath;
    const(wchar)* pszNCName;
    const(wchar)* pszTrustParent;
    const(wchar)* pszObjectClass;
    uint          ulFlags;
    BOOL          fDownLevel;
    DOMAINDESC*   pdChildList;
    DOMAINDESC*   pdNextSibling;
}

struct DOMAIN_TREE
{
    uint          dsSize;
    uint          dwCount;
    DOMAINDESC[1] aDomains;
}

struct DSCLASSCREATIONINFO
{
    uint    dwFlags;
    GUID    clsidWizardDialog;
    GUID    clsidWizardPrimaryPage;
    uint    cWizardExtensions;
    GUID[1] aWizardExtensions;
}

struct DSBROWSEINFOW
{
    uint          cbStruct;
    HWND          hwndOwner;
    const(wchar)* pszCaption;
    const(wchar)* pszTitle;
    const(wchar)* pszRoot;
    const(wchar)* pszPath;
    uint          cchPath;
    uint          dwFlags;
    BFFCALLBACK   pfnCallback;
    LPARAM        lParam;
    uint          dwReturnFormat;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pszObjectClass;
    uint          cchObjectClass;
}

struct DSBROWSEINFOA
{
    uint          cbStruct;
    HWND          hwndOwner;
    const(char)*  pszCaption;
    const(char)*  pszTitle;
    const(wchar)* pszRoot;
    const(wchar)* pszPath;
    uint          cchPath;
    uint          dwFlags;
    BFFCALLBACK   pfnCallback;
    LPARAM        lParam;
    uint          dwReturnFormat;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pszObjectClass;
    uint          cchObjectClass;
}

struct DSBITEMW
{
    uint          cbStruct;
    const(wchar)* pszADsPath;
    const(wchar)* pszClass;
    uint          dwMask;
    uint          dwState;
    uint          dwStateMask;
    ushort[64]    szDisplayName;
    ushort[260]   szIconLocation;
    int           iIconResID;
}

struct DSBITEMA
{
    uint          cbStruct;
    const(wchar)* pszADsPath;
    const(wchar)* pszClass;
    uint          dwMask;
    uint          dwState;
    uint          dwStateMask;
    byte[64]      szDisplayName;
    byte[260]     szIconLocation;
    int           iIconResID;
}

struct DSOP_UPLEVEL_FILTER_FLAGS
{
    uint flBothModes;
    uint flMixedModeOnly;
    uint flNativeModeOnly;
}

struct DSOP_FILTER_FLAGS
{
    DSOP_UPLEVEL_FILTER_FLAGS Uplevel;
    uint flDownlevel;
}

struct DSOP_SCOPE_INIT_INFO
{
    uint              cbSize;
    uint              flType;
    uint              flScope;
    DSOP_FILTER_FLAGS FilterFlags;
    const(wchar)*     pwzDcName;
    const(wchar)*     pwzADsPath;
    HRESULT           hr;
}

struct DSOP_INIT_INFO
{
    uint          cbSize;
    const(wchar)* pwzTargetComputer;
    uint          cDsScopeInfos;
    DSOP_SCOPE_INIT_INFO* aDsScopeInfos;
    uint          flOptions;
    uint          cAttributesToFetch;
    ushort**      apwzAttributeNames;
}

struct DS_SELECTION
{
    const(wchar)* pwzName;
    const(wchar)* pwzADsPath;
    const(wchar)* pwzClass;
    const(wchar)* pwzUPN;
    VARIANT*      pvarFetchedAttributes;
    uint          flScopeType;
}

struct DS_SELECTION_LIST
{
    uint            cItems;
    uint            cFetchedAttributes;
    DS_SELECTION[1] aDsSelection;
}

struct DSQUERYINITPARAMS
{
    uint          cbStruct;
    uint          dwFlags;
    const(wchar)* pDefaultScope;
    const(wchar)* pDefaultSaveLocation;
    const(wchar)* pUserName;
    const(wchar)* pPassword;
    const(wchar)* pServer;
}

struct DSCOLUMN
{
    uint dwFlags;
    int  fmt;
    int  cx;
    int  idsName;
    int  offsetProperty;
    uint dwReserved;
}

struct DSQUERYPARAMS
{
    uint        cbStruct;
    uint        dwFlags;
    HINSTANCE   hInstance;
    int         offsetQuery;
    int         iColumns;
    uint        dwReserved;
    DSCOLUMN[1] aColumns;
}

struct DSQUERYCLASSLIST
{
    uint    cbStruct;
    int     cClasses;
    uint[1] offsetClass;
}

struct DSA_NEWOBJ_DISPINFO
{
    uint          dwSize;
    HICON         hObjClassIcon;
    const(wchar)* lpszWizTitle;
    const(wchar)* lpszContDisplayName;
}

struct ADSPROPINITPARAMS
{
    uint             dwSize;
    uint             dwFlags;
    HRESULT          hr;
    IDirectoryObject pDsObj;
    const(wchar)*    pwzCN;
    ADS_ATTR_INFO*   pWritableAttrs;
}

struct ADSPROPERROR
{
    HWND          hwndPage;
    const(wchar)* pszPageTitle;
    const(wchar)* pszObjPath;
    const(wchar)* pszObjClass;
    HRESULT       hr;
    const(wchar)* pszError;
}

struct SCHEDULE_HEADER
{
    uint Type;
    uint Offset;
}

struct SCHEDULE
{
    uint               Size;
    uint               Bandwidth;
    uint               NumberOfSchedules;
    SCHEDULE_HEADER[1] Schedules;
}

struct DS_NAME_RESULT_ITEMA
{
    uint         status;
    const(char)* pDomain;
    const(char)* pName;
}

struct DS_NAME_RESULTA
{
    uint cItems;
    DS_NAME_RESULT_ITEMA* rItems;
}

struct DS_NAME_RESULT_ITEMW
{
    uint          status;
    const(wchar)* pDomain;
    const(wchar)* pName;
}

struct DS_NAME_RESULTW
{
    uint cItems;
    DS_NAME_RESULT_ITEMW* rItems;
}

struct DS_REPSYNCALL_SYNCA
{
    const(char)* pszSrcId;
    const(char)* pszDstId;
    const(char)* pszNC;
    GUID*        pguidSrc;
    GUID*        pguidDst;
}

struct DS_REPSYNCALL_SYNCW
{
    const(wchar)* pszSrcId;
    const(wchar)* pszDstId;
    const(wchar)* pszNC;
    GUID*         pguidSrc;
    GUID*         pguidDst;
}

struct DS_REPSYNCALL_ERRINFOA
{
    const(char)*        pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint                dwWin32Err;
    const(char)*        pszSrcId;
}

struct DS_REPSYNCALL_ERRINFOW
{
    const(wchar)*       pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint                dwWin32Err;
    const(wchar)*       pszSrcId;
}

struct DS_REPSYNCALL_UPDATEA
{
    DS_REPSYNCALL_EVENT  event;
    DS_REPSYNCALL_ERRINFOA* pErrInfo;
    DS_REPSYNCALL_SYNCA* pSync;
}

struct DS_REPSYNCALL_UPDATEW
{
    DS_REPSYNCALL_EVENT  event;
    DS_REPSYNCALL_ERRINFOW* pErrInfo;
    DS_REPSYNCALL_SYNCW* pSync;
}

struct DS_SITE_COST_INFO
{
    uint errorCode;
    uint cost;
}

struct DS_SCHEMA_GUID_MAPA
{
    GUID         guid;
    uint         guidType;
    const(char)* pName;
}

struct DS_SCHEMA_GUID_MAPW
{
    GUID          guid;
    uint          guidType;
    const(wchar)* pName;
}

struct DS_DOMAIN_CONTROLLER_INFO_1A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    BOOL         fIsPdc;
    BOOL         fDsEnabled;
}

struct DS_DOMAIN_CONTROLLER_INFO_1W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    BOOL          fIsPdc;
    BOOL          fDsEnabled;
}

struct DS_DOMAIN_CONTROLLER_INFO_2A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* SiteObjectName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    const(char)* NtdsDsaObjectName;
    BOOL         fIsPdc;
    BOOL         fDsEnabled;
    BOOL         fIsGc;
    GUID         SiteObjectGuid;
    GUID         ComputerObjectGuid;
    GUID         ServerObjectGuid;
    GUID         NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_2W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* SiteObjectName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    const(wchar)* NtdsDsaObjectName;
    BOOL          fIsPdc;
    BOOL          fDsEnabled;
    BOOL          fIsGc;
    GUID          SiteObjectGuid;
    GUID          ComputerObjectGuid;
    GUID          ServerObjectGuid;
    GUID          NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_3A
{
    const(char)* NetbiosName;
    const(char)* DnsHostName;
    const(char)* SiteName;
    const(char)* SiteObjectName;
    const(char)* ComputerObjectName;
    const(char)* ServerObjectName;
    const(char)* NtdsDsaObjectName;
    BOOL         fIsPdc;
    BOOL         fDsEnabled;
    BOOL         fIsGc;
    BOOL         fIsRodc;
    GUID         SiteObjectGuid;
    GUID         ComputerObjectGuid;
    GUID         ServerObjectGuid;
    GUID         NtdsDsaObjectGuid;
}

struct DS_DOMAIN_CONTROLLER_INFO_3W
{
    const(wchar)* NetbiosName;
    const(wchar)* DnsHostName;
    const(wchar)* SiteName;
    const(wchar)* SiteObjectName;
    const(wchar)* ComputerObjectName;
    const(wchar)* ServerObjectName;
    const(wchar)* NtdsDsaObjectName;
    BOOL          fIsPdc;
    BOOL          fDsEnabled;
    BOOL          fIsGc;
    BOOL          fIsRodc;
    GUID          SiteObjectGuid;
    GUID          ComputerObjectGuid;
    GUID          ServerObjectGuid;
    GUID          NtdsDsaObjectGuid;
}

struct DS_REPL_NEIGHBORW
{
    const(wchar)* pszNamingContext;
    const(wchar)* pszSourceDsaDN;
    const(wchar)* pszSourceDsaAddress;
    const(wchar)* pszAsyncIntersiteTransportDN;
    uint          dwReplicaFlags;
    uint          dwReserved;
    GUID          uuidNamingContextObjGuid;
    GUID          uuidSourceDsaObjGuid;
    GUID          uuidSourceDsaInvocationID;
    GUID          uuidAsyncIntersiteTransportObjGuid;
    long          usnLastObjChangeSynced;
    long          usnAttributeFilter;
    FILETIME      ftimeLastSyncSuccess;
    FILETIME      ftimeLastSyncAttempt;
    uint          dwLastSyncResult;
    uint          cNumConsecutiveSyncFailures;
}

struct DS_REPL_NEIGHBORW_BLOB
{
    uint     oszNamingContext;
    uint     oszSourceDsaDN;
    uint     oszSourceDsaAddress;
    uint     oszAsyncIntersiteTransportDN;
    uint     dwReplicaFlags;
    uint     dwReserved;
    GUID     uuidNamingContextObjGuid;
    GUID     uuidSourceDsaObjGuid;
    GUID     uuidSourceDsaInvocationID;
    GUID     uuidAsyncIntersiteTransportObjGuid;
    long     usnLastObjChangeSynced;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    FILETIME ftimeLastSyncAttempt;
    uint     dwLastSyncResult;
    uint     cNumConsecutiveSyncFailures;
}

struct DS_REPL_NEIGHBORSW
{
    uint                 cNumNeighbors;
    uint                 dwReserved;
    DS_REPL_NEIGHBORW[1] rgNeighbor;
}

struct DS_REPL_CURSOR
{
    GUID uuidSourceDsaInvocationID;
    long usnAttributeFilter;
}

struct DS_REPL_CURSOR_2
{
    GUID     uuidSourceDsaInvocationID;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
}

struct DS_REPL_CURSOR_3W
{
    GUID          uuidSourceDsaInvocationID;
    long          usnAttributeFilter;
    FILETIME      ftimeLastSyncSuccess;
    const(wchar)* pszSourceDsaDN;
}

struct DS_REPL_CURSOR_BLOB
{
    GUID     uuidSourceDsaInvocationID;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    uint     oszSourceDsaDN;
}

struct DS_REPL_CURSORS
{
    uint              cNumCursors;
    uint              dwReserved;
    DS_REPL_CURSOR[1] rgCursor;
}

struct DS_REPL_CURSORS_2
{
    uint                cNumCursors;
    uint                dwEnumerationContext;
    DS_REPL_CURSOR_2[1] rgCursor;
}

struct DS_REPL_CURSORS_3W
{
    uint                 cNumCursors;
    uint                 dwEnumerationContext;
    DS_REPL_CURSOR_3W[1] rgCursor;
}

struct DS_REPL_ATTR_META_DATA
{
    const(wchar)* pszAttributeName;
    uint          dwVersion;
    FILETIME      ftimeLastOriginatingChange;
    GUID          uuidLastOriginatingDsaInvocationID;
    long          usnOriginatingChange;
    long          usnLocalChange;
}

struct DS_REPL_ATTR_META_DATA_2
{
    const(wchar)* pszAttributeName;
    uint          dwVersion;
    FILETIME      ftimeLastOriginatingChange;
    GUID          uuidLastOriginatingDsaInvocationID;
    long          usnOriginatingChange;
    long          usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
}

struct DS_REPL_ATTR_META_DATA_BLOB
{
    uint     oszAttributeName;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    uint     oszLastOriginatingDsaDN;
}

struct DS_REPL_OBJ_META_DATA
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA[1] rgMetaData;
}

struct DS_REPL_OBJ_META_DATA_2
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA_2[1] rgMetaData;
}

struct DS_REPL_KCC_DSA_FAILUREW
{
    const(wchar)* pszDsaDN;
    GUID          uuidDsaObjGuid;
    FILETIME      ftimeFirstFailure;
    uint          cNumFailures;
    uint          dwLastResult;
}

struct DS_REPL_KCC_DSA_FAILUREW_BLOB
{
    uint     oszDsaDN;
    GUID     uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    uint     cNumFailures;
    uint     dwLastResult;
}

struct DS_REPL_KCC_DSA_FAILURESW
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_KCC_DSA_FAILUREW[1] rgDsaFailure;
}

struct DS_REPL_OPW
{
    FILETIME        ftimeEnqueued;
    uint            ulSerialNumber;
    uint            ulPriority;
    DS_REPL_OP_TYPE OpType;
    uint            ulOptions;
    const(wchar)*   pszNamingContext;
    const(wchar)*   pszDsaDN;
    const(wchar)*   pszDsaAddress;
    GUID            uuidNamingContextObjGuid;
    GUID            uuidDsaObjGuid;
}

struct DS_REPL_OPW_BLOB
{
    FILETIME        ftimeEnqueued;
    uint            ulSerialNumber;
    uint            ulPriority;
    DS_REPL_OP_TYPE OpType;
    uint            ulOptions;
    uint            oszNamingContext;
    uint            oszDsaDN;
    uint            oszDsaAddress;
    GUID            uuidNamingContextObjGuid;
    GUID            uuidDsaObjGuid;
}

struct DS_REPL_PENDING_OPSW
{
    FILETIME       ftimeCurrentOpStarted;
    uint           cNumPendingOps;
    DS_REPL_OPW[1] rgPendingOp;
}

struct DS_REPL_VALUE_META_DATA
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint          cbData;
    ubyte*        pbData;
    FILETIME      ftimeDeleted;
    FILETIME      ftimeCreated;
    uint          dwVersion;
    FILETIME      ftimeLastOriginatingChange;
    GUID          uuidLastOriginatingDsaInvocationID;
    long          usnOriginatingChange;
    long          usnLocalChange;
}

struct DS_REPL_VALUE_META_DATA_2
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint          cbData;
    ubyte*        pbData;
    FILETIME      ftimeDeleted;
    FILETIME      ftimeCreated;
    uint          dwVersion;
    FILETIME      ftimeLastOriginatingChange;
    GUID          uuidLastOriginatingDsaInvocationID;
    long          usnOriginatingChange;
    long          usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
}

struct DS_REPL_VALUE_META_DATA_EXT
{
    const(wchar)* pszAttributeName;
    const(wchar)* pszObjectDn;
    uint          cbData;
    ubyte*        pbData;
    FILETIME      ftimeDeleted;
    FILETIME      ftimeCreated;
    uint          dwVersion;
    FILETIME      ftimeLastOriginatingChange;
    GUID          uuidLastOriginatingDsaInvocationID;
    long          usnOriginatingChange;
    long          usnLocalChange;
    const(wchar)* pszLastOriginatingDsaDN;
    uint          dwUserIdentifier;
    uint          dwPriorLinkState;
    uint          dwCurrentLinkState;
}

struct DS_REPL_VALUE_META_DATA_BLOB
{
    uint     oszAttributeName;
    uint     oszObjectDn;
    uint     cbData;
    uint     obData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    uint     oszLastOriginatingDsaDN;
}

struct DS_REPL_VALUE_META_DATA_BLOB_EXT
{
    uint     oszAttributeName;
    uint     oszObjectDn;
    uint     cbData;
    uint     obData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    uint     oszLastOriginatingDsaDN;
    uint     dwUserIdentifier;
    uint     dwPriorLinkState;
    uint     dwCurrentLinkState;
}

struct DS_REPL_ATTR_VALUE_META_DATA
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA[1] rgMetaData;
}

struct DS_REPL_ATTR_VALUE_META_DATA_2
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_2[1] rgMetaData;
}

struct DS_REPL_ATTR_VALUE_META_DATA_EXT
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_EXT[1] rgMetaData;
}

struct DS_REPL_QUEUE_STATISTICSW
{
    FILETIME ftimeCurrentOpStarted;
    uint     cNumPendingOps;
    FILETIME ftimeOldestSync;
    FILETIME ftimeOldestAdd;
    FILETIME ftimeOldestMod;
    FILETIME ftimeOldestDel;
    FILETIME ftimeOldestUpdRefs;
}

struct DSROLE_PRIMARY_DOMAIN_INFO_BASIC
{
    DSROLE_MACHINE_ROLE MachineRole;
    uint                Flags;
    const(wchar)*       DomainNameFlat;
    const(wchar)*       DomainNameDns;
    const(wchar)*       DomainForestName;
    GUID                DomainGuid;
}

struct DSROLE_UPGRADE_STATUS_INFO
{
    uint                OperationState;
    DSROLE_SERVER_STATE PreviousServerState;
}

struct DSROLE_OPERATION_STATE_INFO
{
    DSROLE_OPERATION_STATE OperationState;
}

struct DOMAIN_CONTROLLER_INFOA
{
    const(char)* DomainControllerName;
    const(char)* DomainControllerAddress;
    uint         DomainControllerAddressType;
    GUID         DomainGuid;
    const(char)* DomainName;
    const(char)* DnsForestName;
    uint         Flags;
    const(char)* DcSiteName;
    const(char)* ClientSiteName;
}

struct DOMAIN_CONTROLLER_INFOW
{
    const(wchar)* DomainControllerName;
    const(wchar)* DomainControllerAddress;
    uint          DomainControllerAddressType;
    GUID          DomainGuid;
    const(wchar)* DomainName;
    const(wchar)* DnsForestName;
    uint          Flags;
    const(wchar)* DcSiteName;
    const(wchar)* ClientSiteName;
}

struct DS_DOMAIN_TRUSTSW
{
    const(wchar)* NetbiosDomainName;
    const(wchar)* DnsDomainName;
    uint          Flags;
    uint          ParentIndex;
    uint          TrustType;
    uint          TrustAttributes;
    void*         DomainSid;
    GUID          DomainGuid;
}

struct DS_DOMAIN_TRUSTSA
{
    const(char)* NetbiosDomainName;
    const(char)* DnsDomainName;
    uint         Flags;
    uint         ParentIndex;
    uint         TrustType;
    uint         TrustAttributes;
    void*        DomainSid;
    GUID         DomainGuid;
}

alias GetDcContextHandle = ptrdiff_t;

// Functions

@DllImport("ACTIVEDS")
HRESULT ADsGetObject(const(wchar)* lpszPathName, const(GUID)* riid, void** ppObject);

@DllImport("ACTIVEDS")
HRESULT ADsBuildEnumerator(IADsContainer pADsContainer, IEnumVARIANT* ppEnumVariant);

@DllImport("ACTIVEDS")
HRESULT ADsFreeEnumerator(IEnumVARIANT pEnumVariant);

@DllImport("ACTIVEDS")
HRESULT ADsEnumerateNext(IEnumVARIANT pEnumVariant, uint cElements, VARIANT* pvar, uint* pcElementsFetched);

@DllImport("ACTIVEDS")
HRESULT ADsBuildVarArrayStr(char* lppPathNames, uint dwPathNames, VARIANT* pVar);

@DllImport("ACTIVEDS")
HRESULT ADsBuildVarArrayInt(uint* lpdwObjectTypes, uint dwObjectTypes, VARIANT* pVar);

@DllImport("ACTIVEDS")
HRESULT ADsOpenObject(const(wchar)* lpszPathName, const(wchar)* lpszUserName, const(wchar)* lpszPassword, 
                      uint dwReserved, const(GUID)* riid, void** ppObject);

@DllImport("ACTIVEDS")
HRESULT ADsGetLastError(uint* lpError, const(wchar)* lpErrorBuf, uint dwErrorBufLen, const(wchar)* lpNameBuf, 
                        uint dwNameBufLen);

@DllImport("ACTIVEDS")
void ADsSetLastError(uint dwErr, const(wchar)* pszError, const(wchar)* pszProvider);

@DllImport("ACTIVEDS")
void* AllocADsMem(uint cb);

@DllImport("ACTIVEDS")
BOOL FreeADsMem(void* pMem);

@DllImport("ACTIVEDS")
void* ReallocADsMem(void* pOldMem, uint cbOld, uint cbNew);

@DllImport("ACTIVEDS")
ushort* AllocADsStr(const(wchar)* pStr);

@DllImport("ACTIVEDS")
BOOL FreeADsStr(const(wchar)* pStr);

@DllImport("ACTIVEDS")
BOOL ReallocADsStr(ushort** ppStr, const(wchar)* pStr);

@DllImport("ACTIVEDS")
HRESULT ADsEncodeBinaryData(ubyte* pbSrcData, uint dwSrcLen, ushort** ppszDestData);

@DllImport("ACTIVEDS")
HRESULT ADsDecodeBinaryData(const(wchar)* szSrcData, ubyte** ppbDestData, uint* pdwDestLen);

@DllImport("ACTIVEDS")
HRESULT PropVariantToAdsType(VARIANT* pVariant, uint dwNumVariant, ADSVALUE** ppAdsValues, uint* pdwNumValues);

@DllImport("ACTIVEDS")
HRESULT AdsTypeToPropVariant(ADSVALUE* pAdsValues, uint dwNumValues, VARIANT* pVariant);

@DllImport("ACTIVEDS")
void AdsFreeAdsValues(ADSVALUE* pAdsValues, uint dwNumValues);

@DllImport("ACTIVEDS")
HRESULT BinarySDToSecurityDescriptor(void* pSecurityDescriptor, VARIANT* pVarsec, const(wchar)* pszServerName, 
                                     const(wchar)* userName, const(wchar)* passWord, uint dwFlags);

@DllImport("ACTIVEDS")
HRESULT SecurityDescriptorToBinarySD(VARIANT vVarSecDes, void** ppSecurityDescriptor, uint* pdwSDLength, 
                                     const(wchar)* pszServerName, const(wchar)* userName, const(wchar)* passWord, 
                                     uint dwFlags);

@DllImport("dsuiext")
int DsBrowseForContainerW(DSBROWSEINFOW* pInfo);

@DllImport("dsuiext")
int DsBrowseForContainerA(DSBROWSEINFOA* pInfo);

@DllImport("dsuiext")
HICON DsGetIcon(uint dwFlags, const(wchar)* pszObjectClass, int cxImage, int cyImage);

@DllImport("dsuiext")
HRESULT DsGetFriendlyClassName(const(wchar)* pszObjectClass, const(wchar)* pszBuffer, uint cchBuffer);

@DllImport("dsprop")
HRESULT ADsPropCreateNotifyObj(IDataObject pAppThdDataObj, const(wchar)* pwzADsObjName, HWND* phNotifyObj);

@DllImport("dsprop")
BOOL ADsPropGetInitInfo(HWND hNotifyObj, ADSPROPINITPARAMS* pInitParams);

@DllImport("dsprop")
BOOL ADsPropSetHwndWithTitle(HWND hNotifyObj, HWND hPage, byte* ptzTitle);

@DllImport("dsprop")
BOOL ADsPropSetHwnd(HWND hNotifyObj, HWND hPage);

@DllImport("dsprop")
BOOL ADsPropCheckIfWritable(const(ushort)* pwzAttr, const(ADS_ATTR_INFO)* pWritableAttrs);

@DllImport("dsprop")
BOOL ADsPropSendErrorMessage(HWND hNotifyObj, ADSPROPERROR* pError);

@DllImport("dsprop")
BOOL ADsPropShowErrorDialog(HWND hNotifyObj, HWND hPage);

@DllImport("DSPARSE")
uint DsMakeSpnW(const(wchar)* ServiceClass, const(wchar)* ServiceName, const(wchar)* InstanceName, 
                ushort InstancePort, const(wchar)* Referrer, uint* pcSpnLength, const(wchar)* pszSpn);

@DllImport("DSPARSE")
uint DsMakeSpnA(const(char)* ServiceClass, const(char)* ServiceName, const(char)* InstanceName, 
                ushort InstancePort, const(char)* Referrer, uint* pcSpnLength, const(char)* pszSpn);

@DllImport("DSPARSE")
uint DsCrackSpnA(const(char)* pszSpn, uint* pcServiceClass, const(char)* ServiceClass, uint* pcServiceName, 
                 const(char)* ServiceName, uint* pcInstanceName, const(char)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsCrackSpnW(const(wchar)* pszSpn, uint* pcServiceClass, const(wchar)* ServiceClass, uint* pcServiceName, 
                 const(wchar)* ServiceName, uint* pcInstanceName, const(wchar)* InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsQuoteRdnValueW(uint cUnquotedRdnValueLength, const(wchar)* psUnquotedRdnValue, uint* pcQuotedRdnValueLength, 
                      const(wchar)* psQuotedRdnValue);

@DllImport("DSPARSE")
uint DsQuoteRdnValueA(uint cUnquotedRdnValueLength, const(char)* psUnquotedRdnValue, uint* pcQuotedRdnValueLength, 
                      const(char)* psQuotedRdnValue);

@DllImport("DSPARSE")
uint DsUnquoteRdnValueW(uint cQuotedRdnValueLength, const(wchar)* psQuotedRdnValue, uint* pcUnquotedRdnValueLength, 
                        const(wchar)* psUnquotedRdnValue);

@DllImport("DSPARSE")
uint DsUnquoteRdnValueA(uint cQuotedRdnValueLength, const(char)* psQuotedRdnValue, uint* pcUnquotedRdnValueLength, 
                        const(char)* psUnquotedRdnValue);

@DllImport("DSPARSE")
uint DsGetRdnW(char* ppDN, uint* pcDN, ushort** ppKey, uint* pcKey, ushort** ppVal, uint* pcVal);

@DllImport("DSPARSE")
BOOL DsCrackUnquotedMangledRdnW(const(wchar)* pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

@DllImport("DSPARSE")
BOOL DsCrackUnquotedMangledRdnA(const(char)* pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

@DllImport("DSPARSE")
BOOL DsIsMangledRdnValueW(const(wchar)* pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

@DllImport("DSPARSE")
BOOL DsIsMangledRdnValueA(const(char)* pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

@DllImport("DSPARSE")
BOOL DsIsMangledDnA(const(char)* pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE")
BOOL DsIsMangledDnW(const(wchar)* pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE")
uint DsCrackSpn2A(const(char)* pszSpn, uint cSpn, uint* pcServiceClass, const(char)* ServiceClass, 
                  uint* pcServiceName, const(char)* ServiceName, uint* pcInstanceName, const(char)* InstanceName, 
                  ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsCrackSpn2W(const(wchar)* pszSpn, uint cSpn, uint* pcServiceClass, const(wchar)* ServiceClass, 
                  uint* pcServiceName, const(wchar)* ServiceName, uint* pcInstanceName, const(wchar)* InstanceName, 
                  ushort* pInstancePort);

@DllImport("DSPARSE")
uint DsCrackSpn3W(const(wchar)* pszSpn, uint cSpn, uint* pcHostName, const(wchar)* HostName, uint* pcInstanceName, 
                  const(wchar)* InstanceName, ushort* pPortNumber, uint* pcDomainName, const(wchar)* DomainName, 
                  uint* pcRealmName, const(wchar)* RealmName);

@DllImport("DSPARSE")
uint DsCrackSpn4W(const(wchar)* pszSpn, uint cSpn, uint* pcHostName, const(wchar)* HostName, uint* pcInstanceName, 
                  const(wchar)* InstanceName, uint* pcPortName, const(wchar)* PortName, uint* pcDomainName, 
                  const(wchar)* DomainName, uint* pcRealmName, const(wchar)* RealmName);

@DllImport("NTDSAPI")
uint DsBindW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindA(const(char)* DomainControllerName, const(char)* DnsDomainName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithCredW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, 
                     HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithCredA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, 
                     HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithSpnW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, 
                    const(wchar)* ServicePrincipalName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithSpnA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, 
                    const(char)* ServicePrincipalName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithSpnExW(const(wchar)* DomainControllerName, const(wchar)* DnsDomainName, void* AuthIdentity, 
                      const(wchar)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindWithSpnExA(const(char)* DomainControllerName, const(char)* DnsDomainName, void* AuthIdentity, 
                      const(char)* ServicePrincipalName, uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindByInstanceW(const(wchar)* ServerName, const(wchar)* Annotation, GUID* InstanceGuid, 
                       const(wchar)* DnsDomainName, void* AuthIdentity, const(wchar)* ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindByInstanceA(const(char)* ServerName, const(char)* Annotation, GUID* InstanceGuid, 
                       const(char)* DnsDomainName, void* AuthIdentity, const(char)* ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindToISTGW(const(wchar)* SiteName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindToISTGA(const(char)* SiteName, HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsBindingSetTimeout(HANDLE hDS, uint cTimeoutSecs);

@DllImport("NTDSAPI")
uint DsUnBindW(HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsUnBindA(HANDLE* phDS);

@DllImport("NTDSAPI")
uint DsMakePasswordCredentialsW(const(wchar)* User, const(wchar)* Domain, const(wchar)* Password, 
                                void** pAuthIdentity);

@DllImport("NTDSAPI")
uint DsMakePasswordCredentialsA(const(char)* User, const(char)* Domain, const(char)* Password, 
                                void** pAuthIdentity);

@DllImport("NTDSAPI")
void DsFreePasswordCredentials(void* AuthIdentity);

@DllImport("NTDSAPI")
uint DsCrackNamesW(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, char* rpNames, DS_NAME_RESULTW** ppResult);

@DllImport("NTDSAPI")
uint DsCrackNamesA(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, char* rpNames, DS_NAME_RESULTA** ppResult);

@DllImport("NTDSAPI")
void DsFreeNameResultW(DS_NAME_RESULTW* pResult);

@DllImport("NTDSAPI")
void DsFreeNameResultA(DS_NAME_RESULTA* pResult);

@DllImport("NTDSAPI")
uint DsGetSpnA(DS_SPN_NAME_TYPE ServiceType, const(char)* ServiceClass, const(char)* ServiceName, 
               ushort InstancePort, ushort cInstanceNames, char* pInstanceNames, char* pInstancePorts, uint* pcSpn, 
               byte*** prpszSpn);

@DllImport("NTDSAPI")
uint DsGetSpnW(DS_SPN_NAME_TYPE ServiceType, const(wchar)* ServiceClass, const(wchar)* ServiceName, 
               ushort InstancePort, ushort cInstanceNames, char* pInstanceNames, char* pInstancePorts, uint* pcSpn, 
               ushort*** prpszSpn);

@DllImport("NTDSAPI")
void DsFreeSpnArrayA(uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI")
void DsFreeSpnArrayW(uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI")
uint DsWriteAccountSpnA(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(char)* pszAccount, uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI")
uint DsWriteAccountSpnW(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(wchar)* pszAccount, uint cSpn, char* rpszSpn);

@DllImport("NTDSAPI")
uint DsClientMakeSpnForTargetServerW(const(wchar)* ServiceClass, const(wchar)* ServiceName, uint* pcSpnLength, 
                                     const(wchar)* pszSpn);

@DllImport("NTDSAPI")
uint DsClientMakeSpnForTargetServerA(const(char)* ServiceClass, const(char)* ServiceName, uint* pcSpnLength, 
                                     const(char)* pszSpn);

@DllImport("NTDSAPI")
uint DsServerRegisterSpnA(DS_SPN_WRITE_OP Operation, const(char)* ServiceClass, const(char)* UserObjectDN);

@DllImport("NTDSAPI")
uint DsServerRegisterSpnW(DS_SPN_WRITE_OP Operation, const(wchar)* ServiceClass, const(wchar)* UserObjectDN);

@DllImport("NTDSAPI")
uint DsReplicaSyncA(HANDLE hDS, const(char)* NameContext, const(GUID)* pUuidDsaSrc, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaSyncW(HANDLE hDS, const(wchar)* NameContext, const(GUID)* pUuidDsaSrc, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaAddA(HANDLE hDS, const(char)* NameContext, const(char)* SourceDsaDn, const(char)* TransportDn, 
                   const(char)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaAddW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* SourceDsaDn, const(wchar)* TransportDn, 
                   const(wchar)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaDelA(HANDLE hDS, const(char)* NameContext, const(char)* DsaSrc, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaDelW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* DsaSrc, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaModifyA(HANDLE hDS, const(char)* NameContext, const(GUID)* pUuidSourceDsa, const(char)* TransportDn, 
                      const(char)* SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, 
                      uint ModifyFields, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaModifyW(HANDLE hDS, const(wchar)* NameContext, const(GUID)* pUuidSourceDsa, 
                      const(wchar)* TransportDn, const(wchar)* SourceDsaAddress, const(SCHEDULE)* pSchedule, 
                      uint ReplicaFlags, uint ModifyFields, uint Options);

@DllImport("NTDSAPI")
uint DsReplicaUpdateRefsA(HANDLE hDS, const(char)* NameContext, const(char)* DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

@DllImport("NTDSAPI")
uint DsReplicaUpdateRefsW(HANDLE hDS, const(wchar)* NameContext, const(wchar)* DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

@DllImport("NTDSAPI")
uint DsReplicaSyncAllA(HANDLE hDS, const(char)* pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOA*** pErrors);

@DllImport("NTDSAPI")
uint DsReplicaSyncAllW(HANDLE hDS, const(wchar)* pszNameContext, uint ulFlags, BOOL*********** pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOW*** pErrors);

@DllImport("NTDSAPI")
uint DsRemoveDsServerW(HANDLE hDs, const(wchar)* ServerDN, const(wchar)* DomainDN, int* fLastDcInDomain, 
                       BOOL fCommit);

@DllImport("NTDSAPI")
uint DsRemoveDsServerA(HANDLE hDs, const(char)* ServerDN, const(char)* DomainDN, int* fLastDcInDomain, 
                       BOOL fCommit);

@DllImport("NTDSAPI")
uint DsRemoveDsDomainW(HANDLE hDs, const(wchar)* DomainDN);

@DllImport("NTDSAPI")
uint DsRemoveDsDomainA(HANDLE hDs, const(char)* DomainDN);

@DllImport("NTDSAPI")
uint DsListSitesA(HANDLE hDs, DS_NAME_RESULTA** ppSites);

@DllImport("NTDSAPI")
uint DsListSitesW(HANDLE hDs, DS_NAME_RESULTW** ppSites);

@DllImport("NTDSAPI")
uint DsListServersInSiteA(HANDLE hDs, const(char)* site, DS_NAME_RESULTA** ppServers);

@DllImport("NTDSAPI")
uint DsListServersInSiteW(HANDLE hDs, const(wchar)* site, DS_NAME_RESULTW** ppServers);

@DllImport("NTDSAPI")
uint DsListDomainsInSiteA(HANDLE hDs, const(char)* site, DS_NAME_RESULTA** ppDomains);

@DllImport("NTDSAPI")
uint DsListDomainsInSiteW(HANDLE hDs, const(wchar)* site, DS_NAME_RESULTW** ppDomains);

@DllImport("NTDSAPI")
uint DsListServersForDomainInSiteA(HANDLE hDs, const(char)* domain, const(char)* site, DS_NAME_RESULTA** ppServers);

@DllImport("NTDSAPI")
uint DsListServersForDomainInSiteW(HANDLE hDs, const(wchar)* domain, const(wchar)* site, 
                                   DS_NAME_RESULTW** ppServers);

@DllImport("NTDSAPI")
uint DsListInfoForServerA(HANDLE hDs, const(char)* server, DS_NAME_RESULTA** ppInfo);

@DllImport("NTDSAPI")
uint DsListInfoForServerW(HANDLE hDs, const(wchar)* server, DS_NAME_RESULTW** ppInfo);

@DllImport("NTDSAPI")
uint DsListRolesA(HANDLE hDs, DS_NAME_RESULTA** ppRoles);

@DllImport("NTDSAPI")
uint DsListRolesW(HANDLE hDs, DS_NAME_RESULTW** ppRoles);

@DllImport("NTDSAPI")
uint DsQuerySitesByCostW(HANDLE hDS, const(wchar)* pwszFromSite, char* rgwszToSites, uint cToSites, uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

@DllImport("NTDSAPI")
uint DsQuerySitesByCostA(HANDLE hDS, const(char)* pszFromSite, char* rgszToSites, uint cToSites, uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

@DllImport("NTDSAPI")
void DsQuerySitesFree(DS_SITE_COST_INFO* rgSiteInfo);

@DllImport("NTDSAPI")
uint DsMapSchemaGuidsA(HANDLE hDs, uint cGuids, char* rGuids, DS_SCHEMA_GUID_MAPA** ppGuidMap);

@DllImport("NTDSAPI")
void DsFreeSchemaGuidMapA(DS_SCHEMA_GUID_MAPA* pGuidMap);

@DllImport("NTDSAPI")
uint DsMapSchemaGuidsW(HANDLE hDs, uint cGuids, char* rGuids, DS_SCHEMA_GUID_MAPW** ppGuidMap);

@DllImport("NTDSAPI")
void DsFreeSchemaGuidMapW(DS_SCHEMA_GUID_MAPW* pGuidMap);

@DllImport("NTDSAPI")
uint DsGetDomainControllerInfoA(HANDLE hDs, const(char)* DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

@DllImport("NTDSAPI")
uint DsGetDomainControllerInfoW(HANDLE hDs, const(wchar)* DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

@DllImport("NTDSAPI")
void DsFreeDomainControllerInfoA(uint InfoLevel, uint cInfo, char* pInfo);

@DllImport("NTDSAPI")
void DsFreeDomainControllerInfoW(uint InfoLevel, uint cInfo, char* pInfo);

@DllImport("NTDSAPI")
uint DsReplicaConsistencyCheck(HANDLE hDS, DS_KCC_TASKID TaskID, uint dwFlags);

@DllImport("NTDSAPI")
uint DsReplicaVerifyObjectsW(HANDLE hDS, const(wchar)* NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

@DllImport("NTDSAPI")
uint DsReplicaVerifyObjectsA(HANDLE hDS, const(char)* NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

@DllImport("NTDSAPI")
uint DsReplicaGetInfoW(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(wchar)* pszObject, 
                       GUID* puuidForSourceDsaObjGuid, void** ppInfo);

@DllImport("NTDSAPI")
uint DsReplicaGetInfo2W(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(wchar)* pszObject, 
                        GUID* puuidForSourceDsaObjGuid, const(wchar)* pszAttributeName, const(wchar)* pszValue, 
                        uint dwFlags, uint dwEnumerationContext, void** ppInfo);

@DllImport("NTDSAPI")
void DsReplicaFreeInfo(DS_REPL_INFO_TYPE InfoType, void* pInfo);

@DllImport("NTDSAPI")
uint DsAddSidHistoryW(HANDLE hDS, uint Flags, const(wchar)* SrcDomain, const(wchar)* SrcPrincipal, 
                      const(wchar)* SrcDomainController, void* SrcDomainCreds, const(wchar)* DstDomain, 
                      const(wchar)* DstPrincipal);

@DllImport("NTDSAPI")
uint DsAddSidHistoryA(HANDLE hDS, uint Flags, const(char)* SrcDomain, const(char)* SrcPrincipal, 
                      const(char)* SrcDomainController, void* SrcDomainCreds, const(char)* DstDomain, 
                      const(char)* DstPrincipal);

@DllImport("NTDSAPI")
uint DsInheritSecurityIdentityW(HANDLE hDS, uint Flags, const(wchar)* SrcPrincipal, const(wchar)* DstPrincipal);

@DllImport("NTDSAPI")
uint DsInheritSecurityIdentityA(HANDLE hDS, uint Flags, const(char)* SrcPrincipal, const(char)* DstPrincipal);

@DllImport("DSROLE")
uint DsRoleGetPrimaryDomainInformation(const(wchar)* lpServer, DSROLE_PRIMARY_DOMAIN_INFO_LEVEL InfoLevel, 
                                       ubyte** Buffer);

@DllImport("DSROLE")
void DsRoleFreeMemory(void* Buffer);

@DllImport("logoncli")
uint DsGetDcNameA(const(char)* ComputerName, const(char)* DomainName, GUID* DomainGuid, const(char)* SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOA** DomainControllerInfo);

@DllImport("logoncli")
uint DsGetDcNameW(const(wchar)* ComputerName, const(wchar)* DomainName, GUID* DomainGuid, const(wchar)* SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOW** DomainControllerInfo);

@DllImport("logoncli")
uint DsGetSiteNameA(const(char)* ComputerName, byte** SiteName);

@DllImport("logoncli")
uint DsGetSiteNameW(const(wchar)* ComputerName, ushort** SiteName);

@DllImport("logoncli")
uint DsValidateSubnetNameW(const(wchar)* SubnetName);

@DllImport("logoncli")
uint DsValidateSubnetNameA(const(char)* SubnetName);

@DllImport("logoncli")
uint DsAddressToSiteNamesW(const(wchar)* ComputerName, uint EntryCount, char* SocketAddresses, ushort*** SiteNames);

@DllImport("logoncli")
uint DsAddressToSiteNamesA(const(char)* ComputerName, uint EntryCount, char* SocketAddresses, byte*** SiteNames);

@DllImport("logoncli")
uint DsAddressToSiteNamesExW(const(wchar)* ComputerName, uint EntryCount, char* SocketAddresses, 
                             ushort*** SiteNames, ushort*** SubnetNames);

@DllImport("logoncli")
uint DsAddressToSiteNamesExA(const(char)* ComputerName, uint EntryCount, char* SocketAddresses, byte*** SiteNames, 
                             byte*** SubnetNames);

@DllImport("logoncli")
uint DsEnumerateDomainTrustsW(const(wchar)* ServerName, uint Flags, DS_DOMAIN_TRUSTSW** Domains, uint* DomainCount);

@DllImport("logoncli")
uint DsEnumerateDomainTrustsA(const(char)* ServerName, uint Flags, DS_DOMAIN_TRUSTSA** Domains, uint* DomainCount);

@DllImport("logoncli")
uint DsGetForestTrustInformationW(const(wchar)* ServerName, const(wchar)* TrustedDomainName, uint Flags, 
                                  LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

@DllImport("logoncli")
uint DsMergeForestTrustInformationW(const(wchar)* DomainName, LSA_FOREST_TRUST_INFORMATION* NewForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION* OldForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION** MergedForestTrustInfo);

@DllImport("logoncli")
uint DsGetDcSiteCoverageW(const(wchar)* ServerName, uint* EntryCount, ushort*** SiteNames);

@DllImport("logoncli")
uint DsGetDcSiteCoverageA(const(char)* ServerName, uint* EntryCount, byte*** SiteNames);

@DllImport("logoncli")
uint DsDeregisterDnsHostRecordsW(const(wchar)* ServerName, const(wchar)* DnsDomainName, GUID* DomainGuid, 
                                 GUID* DsaGuid, const(wchar)* DnsHostName);

@DllImport("logoncli")
uint DsDeregisterDnsHostRecordsA(const(char)* ServerName, const(char)* DnsDomainName, GUID* DomainGuid, 
                                 GUID* DsaGuid, const(char)* DnsHostName);

@DllImport("logoncli")
uint DsGetDcOpenW(const(wchar)* DnsName, uint OptionFlags, const(wchar)* SiteName, GUID* DomainGuid, 
                  const(wchar)* DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

@DllImport("logoncli")
uint DsGetDcOpenA(const(char)* DnsName, uint OptionFlags, const(char)* SiteName, GUID* DomainGuid, 
                  const(char)* DnsForestName, uint DcFlags, GetDcContextHandle* RetGetDcContext);

@DllImport("logoncli")
uint DsGetDcNextW(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  ushort** DnsHostName);

@DllImport("logoncli")
uint DsGetDcNextA(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  byte** DnsHostName);

@DllImport("logoncli")
void DsGetDcCloseW(HANDLE GetDcContextHandle);


// Interfaces

@GUID("72D3EDC2-A4C4-11D0-8533-00C04FD8D503")
struct PropertyEntry;

@GUID("7B9E38B0-A97C-11D0-8534-00C04FD8D503")
struct PropertyValue;

@GUID("B75AC000-9BDD-11D0-852C-00C04FD8D503")
struct AccessControlEntry;

@GUID("B85EA052-9BDD-11D0-852C-00C04FD8D503")
struct AccessControlList;

@GUID("B958F73C-9BDD-11D0-852C-00C04FD8D503")
struct SecurityDescriptor;

@GUID("927971F5-0939-11D1-8BE1-00C04FD8D503")
struct LargeInteger;

@GUID("274FAE1F-3626-11D1-A3A4-00C04FB950DC")
struct NameTranslate;

@GUID("15F88A55-4680-11D1-A3B4-00C04FB950DC")
struct CaseIgnoreList;

@GUID("A5062215-4681-11D1-A3B4-00C04FB950DC")
struct FaxNumber;

@GUID("B0B71247-4080-11D1-A3AC-00C04FB950DC")
struct NetAddress;

@GUID("1241400F-4680-11D1-A3B4-00C04FB950DC")
struct OctetList;

@GUID("8F92A857-478E-11D1-A3B4-00C04FB950DC")
struct Email;

@GUID("B2538919-4080-11D1-A3AC-00C04FB950DC")
struct Path;

@GUID("F5D1BADF-4080-11D1-A3AC-00C04FB950DC")
struct ReplicaPointer;

@GUID("B2BED2EB-4080-11D1-A3AC-00C04FB950DC")
struct Timestamp;

@GUID("0A75AFCD-4680-11D1-A3B4-00C04FB950DC")
struct PostalAddress;

@GUID("FCBF906F-4080-11D1-A3AC-00C04FB950DC")
struct BackLink;

@GUID("B33143CB-4080-11D1-A3AC-00C04FB950DC")
struct TypedName;

@GUID("B3AD3E13-4080-11D1-A3AC-00C04FB950DC")
struct Hold;

@GUID("080D0D78-F421-11D0-A36E-00C04FB950DC")
struct Pathname;

@GUID("50B6327F-AFD1-11D2-9CB9-0000F87A369E")
struct ADSystemInfo;

@GUID("66182EC4-AFD1-11D2-9CB9-0000F87A369E")
struct WinNTSystemInfo;

@GUID("7E99C0A3-F935-11D2-BA96-00C04FB6D0D1")
struct DNWithBinary;

@GUID("334857CC-F934-11D2-BA96-00C04FB6D0D1")
struct DNWithString;

@GUID("F270C64A-FFB8-4AE4-85FE-3A75E5347966")
struct ADsSecurityUtility;

@GUID("8CFCEE30-39BD-11D0-B8D1-00A024AB2DBB")
interface IQueryForm : IUnknown
{
    HRESULT Initialize(HKEY hkForm);
    HRESULT AddForms(LPCQADDFORMSPROC pAddFormsProc, LPARAM lParam);
    HRESULT AddPages(LPCQADDPAGESPROC pAddPagesProc, LPARAM lParam);
}

@GUID("1A3114B8-A62E-11D0-A6C5-00A0C906AF45")
interface IPersistQuery : IPersist
{
    HRESULT WriteString(const(wchar)* pSection, const(wchar)* pValueName, const(wchar)* pValue);
    HRESULT ReadString(const(wchar)* pSection, const(wchar)* pValueName, const(wchar)* pBuffer, int cchBuffer);
    HRESULT WriteInt(const(wchar)* pSection, const(wchar)* pValueName, int value);
    HRESULT ReadInt(const(wchar)* pSection, const(wchar)* pValueName, int* pValue);
    HRESULT WriteStruct(const(wchar)* pSection, const(wchar)* pValueName, void* pStruct, uint cbStruct);
    HRESULT ReadStruct(const(wchar)* pSection, const(wchar)* pValueName, void* pStruct, uint cbStruct);
    HRESULT Clear();
}

@GUID("AB50DEC0-6F1D-11D0-A1C4-00AA00C16E65")
interface ICommonQuery : IUnknown
{
    HRESULT OpenQueryWindow(HWND hwndParent, OPENQUERYWINDOW* pQueryWnd, IDataObject* ppDataObject);
}

@GUID("FD8256D0-FD15-11CE-ABC4-02608C9E7553")
interface IADs : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_Class(BSTR* retval);
    HRESULT get_GUID(BSTR* retval);
    HRESULT get_ADsPath(BSTR* retval);
    HRESULT get_Parent(BSTR* retval);
    HRESULT get_Schema(BSTR* retval);
    HRESULT GetInfo();
    HRESULT SetInfo();
    HRESULT Get(BSTR bstrName, VARIANT* pvProp);
    HRESULT Put(BSTR bstrName, VARIANT vProp);
    HRESULT GetEx(BSTR bstrName, VARIANT* pvProp);
    HRESULT PutEx(int lnControlCode, BSTR bstrName, VARIANT vProp);
    HRESULT GetInfoEx(VARIANT vProperties, int lnReserved);
}

@GUID("001677D0-FD16-11CE-ABC4-02608C9E7553")
interface IADsContainer : IDispatch
{
    HRESULT get_Count(int* retval);
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Filter(VARIANT* pVar);
    HRESULT put_Filter(VARIANT Var);
    HRESULT get_Hints(VARIANT* pvFilter);
    HRESULT put_Hints(VARIANT vHints);
    HRESULT GetObjectA(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    HRESULT Create(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    HRESULT Delete(BSTR bstrClassName, BSTR bstrRelativeName);
    HRESULT CopyHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
    HRESULT MoveHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
}

@GUID("72B945E0-253B-11CF-A988-00AA006BC149")
interface IADsCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT Add(BSTR bstrName, VARIANT vItem);
    HRESULT Remove(BSTR bstrItemToBeRemoved);
    HRESULT GetObjectA(BSTR bstrName, VARIANT* pvItem);
}

@GUID("451A0030-72EC-11CF-B03B-00AA006E0975")
interface IADsMembers : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT get_Filter(VARIANT* pvFilter);
    HRESULT put_Filter(VARIANT pvFilter);
}

@GUID("C6F602B6-8F69-11D0-8528-00C04FD8D503")
interface IADsPropertyList : IDispatch
{
    HRESULT get_PropertyCount(int* plCount);
    HRESULT Next(VARIANT* pVariant);
    HRESULT Skip(int cElements);
    HRESULT Reset();
    HRESULT Item(VARIANT varIndex, VARIANT* pVariant);
    HRESULT GetPropertyItem(BSTR bstrName, int lnADsType, VARIANT* pVariant);
    HRESULT PutPropertyItem(VARIANT varData);
    HRESULT ResetPropertyItem(VARIANT varEntry);
    HRESULT PurgePropertyList();
}

@GUID("05792C8E-941F-11D0-8529-00C04FD8D503")
interface IADsPropertyEntry : IDispatch
{
    HRESULT Clear();
    HRESULT get_Name(BSTR* retval);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_ControlCode(int* retval);
    HRESULT put_ControlCode(int lnControlCode);
    HRESULT get_Values(VARIANT* retval);
    HRESULT put_Values(VARIANT vValues);
}

@GUID("79FA9AD0-A97C-11D0-8534-00C04FD8D503")
interface IADsPropertyValue : IDispatch
{
    HRESULT Clear();
    HRESULT get_ADsType(int* retval);
    HRESULT put_ADsType(int lnADsType);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
    HRESULT get_CaseExactString(BSTR* retval);
    HRESULT put_CaseExactString(BSTR bstrCaseExactString);
    HRESULT get_CaseIgnoreString(BSTR* retval);
    HRESULT put_CaseIgnoreString(BSTR bstrCaseIgnoreString);
    HRESULT get_PrintableString(BSTR* retval);
    HRESULT put_PrintableString(BSTR bstrPrintableString);
    HRESULT get_NumericString(BSTR* retval);
    HRESULT put_NumericString(BSTR bstrNumericString);
    HRESULT get_Boolean(int* retval);
    HRESULT put_Boolean(int lnBoolean);
    HRESULT get_Integer(int* retval);
    HRESULT put_Integer(int lnInteger);
    HRESULT get_OctetString(VARIANT* retval);
    HRESULT put_OctetString(VARIANT vOctetString);
    HRESULT get_SecurityDescriptor(IDispatch* retval);
    HRESULT put_SecurityDescriptor(IDispatch pSecurityDescriptor);
    HRESULT get_LargeInteger(IDispatch* retval);
    HRESULT put_LargeInteger(IDispatch pLargeInteger);
    HRESULT get_UTCTime(double* retval);
    HRESULT put_UTCTime(double daUTCTime);
}

@GUID("306E831C-5BC7-11D1-A3B8-00C04FB950DC")
interface IADsPropertyValue2 : IDispatch
{
    HRESULT GetObjectProperty(int* lnADsType, VARIANT* pvProp);
    HRESULT PutObjectProperty(int lnADsType, VARIANT vProp);
}

@GUID("86AB4BBE-65F6-11D1-8C13-00C04FD8D503")
interface IPrivateDispatch : IUnknown
{
    HRESULT ADSIInitializeDispatchManager(int dwExtensionId);
    HRESULT ADSIGetTypeInfoCount(uint* pctinfo);
    HRESULT ADSIGetTypeInfo(uint itinfo, uint lcid, ITypeInfo* pptinfo);
    HRESULT ADSIGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgdispid);
    HRESULT ADSIInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                       VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

@GUID("89126BAB-6EAD-11D1-8C18-00C04FD8D503")
interface IPrivateUnknown : IUnknown
{
    HRESULT ADSIInitializeObject(BSTR lpszUserName, BSTR lpszPassword, int lnReserved);
    HRESULT ADSIReleaseObject();
}

@GUID("3D35553C-D2B0-11D1-B17B-0000F87593A0")
interface IADsExtension : IUnknown
{
    HRESULT Operate(uint dwCode, VARIANT varData1, VARIANT varData2, VARIANT varData3);
    HRESULT PrivateGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgDispid);
    HRESULT PrivateInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                          VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

@GUID("B2BD0902-8878-11D1-8C21-00C04FD8D503")
interface IADsDeleteOps : IDispatch
{
    HRESULT DeleteObject(int lnFlags);
}

@GUID("28B96BA0-B330-11CF-A9AD-00AA006BC149")
interface IADsNamespaces : IADs
{
    HRESULT get_DefaultContainer(BSTR* retval);
    HRESULT put_DefaultContainer(BSTR bstrDefaultContainer);
}

@GUID("C8F93DD0-4AE0-11CF-9E73-00AA004A5691")
interface IADsClass : IADs
{
    HRESULT get_PrimaryInterface(BSTR* retval);
    HRESULT get_CLSID(BSTR* retval);
    HRESULT put_CLSID(BSTR bstrCLSID);
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Abstract(short* retval);
    HRESULT put_Abstract(short fAbstract);
    HRESULT get_Auxiliary(short* retval);
    HRESULT put_Auxiliary(short fAuxiliary);
    HRESULT get_MandatoryProperties(VARIANT* retval);
    HRESULT put_MandatoryProperties(VARIANT vMandatoryProperties);
    HRESULT get_OptionalProperties(VARIANT* retval);
    HRESULT put_OptionalProperties(VARIANT vOptionalProperties);
    HRESULT get_NamingProperties(VARIANT* retval);
    HRESULT put_NamingProperties(VARIANT vNamingProperties);
    HRESULT get_DerivedFrom(VARIANT* retval);
    HRESULT put_DerivedFrom(VARIANT vDerivedFrom);
    HRESULT get_AuxDerivedFrom(VARIANT* retval);
    HRESULT put_AuxDerivedFrom(VARIANT vAuxDerivedFrom);
    HRESULT get_PossibleSuperiors(VARIANT* retval);
    HRESULT put_PossibleSuperiors(VARIANT vPossibleSuperiors);
    HRESULT get_Containment(VARIANT* retval);
    HRESULT put_Containment(VARIANT vContainment);
    HRESULT get_Container(short* retval);
    HRESULT put_Container(short fContainer);
    HRESULT get_HelpFileName(BSTR* retval);
    HRESULT put_HelpFileName(BSTR bstrHelpFileName);
    HRESULT get_HelpFileContext(int* retval);
    HRESULT put_HelpFileContext(int lnHelpFileContext);
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

@GUID("C8F93DD3-4AE0-11CF-9E73-00AA004A5691")
interface IADsProperty : IADs
{
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Syntax(BSTR* retval);
    HRESULT put_Syntax(BSTR bstrSyntax);
    HRESULT get_MaxRange(int* retval);
    HRESULT put_MaxRange(int lnMaxRange);
    HRESULT get_MinRange(int* retval);
    HRESULT put_MinRange(int lnMinRange);
    HRESULT get_MultiValued(short* retval);
    HRESULT put_MultiValued(short fMultiValued);
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

@GUID("C8F93DD2-4AE0-11CF-9E73-00AA004A5691")
interface IADsSyntax : IADs
{
    HRESULT get_OleAutoDataType(int* retval);
    HRESULT put_OleAutoDataType(int lnOleAutoDataType);
}

@GUID("A05E03A2-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsLocality : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

@GUID("A1CD2DC6-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsO : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
}

@GUID("A2F733B8-EFFE-11CF-8ABC-00C04FD8D503")
interface IADsOU : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_LocalityName(BSTR* retval);
    HRESULT put_LocalityName(BSTR bstrLocalityName);
    HRESULT get_PostalAddress(BSTR* retval);
    HRESULT put_PostalAddress(BSTR bstrPostalAddress);
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_FaxNumber(BSTR* retval);
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_BusinessCategory(BSTR* retval);
    HRESULT put_BusinessCategory(BSTR bstrBusinessCategory);
}

@GUID("00E4C220-FD16-11CE-ABC4-02608C9E7553")
interface IADsDomain : IADs
{
    HRESULT get_IsWorkgroup(short* retval);
    HRESULT get_MinPasswordLength(int* retval);
    HRESULT put_MinPasswordLength(int lnMinPasswordLength);
    HRESULT get_MinPasswordAge(int* retval);
    HRESULT put_MinPasswordAge(int lnMinPasswordAge);
    HRESULT get_MaxPasswordAge(int* retval);
    HRESULT put_MaxPasswordAge(int lnMaxPasswordAge);
    HRESULT get_MaxBadPasswordsAllowed(int* retval);
    HRESULT put_MaxBadPasswordsAllowed(int lnMaxBadPasswordsAllowed);
    HRESULT get_PasswordHistoryLength(int* retval);
    HRESULT put_PasswordHistoryLength(int lnPasswordHistoryLength);
    HRESULT get_PasswordAttributes(int* retval);
    HRESULT put_PasswordAttributes(int lnPasswordAttributes);
    HRESULT get_AutoUnlockInterval(int* retval);
    HRESULT put_AutoUnlockInterval(int lnAutoUnlockInterval);
    HRESULT get_LockoutObservationInterval(int* retval);
    HRESULT put_LockoutObservationInterval(int lnLockoutObservationInterval);
}

@GUID("EFE3CC70-1D9F-11CF-B1F3-02608C9E7553")
interface IADsComputer : IADs
{
    HRESULT get_ComputerID(BSTR* retval);
    HRESULT get_Site(BSTR* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_PrimaryUser(BSTR* retval);
    HRESULT put_PrimaryUser(BSTR bstrPrimaryUser);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_Role(BSTR* retval);
    HRESULT put_Role(BSTR bstrRole);
    HRESULT get_OperatingSystem(BSTR* retval);
    HRESULT put_OperatingSystem(BSTR bstrOperatingSystem);
    HRESULT get_OperatingSystemVersion(BSTR* retval);
    HRESULT put_OperatingSystemVersion(BSTR bstrOperatingSystemVersion);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Processor(BSTR* retval);
    HRESULT put_Processor(BSTR bstrProcessor);
    HRESULT get_ProcessorCount(BSTR* retval);
    HRESULT put_ProcessorCount(BSTR bstrProcessorCount);
    HRESULT get_MemorySize(BSTR* retval);
    HRESULT put_MemorySize(BSTR bstrMemorySize);
    HRESULT get_StorageCapacity(BSTR* retval);
    HRESULT put_StorageCapacity(BSTR bstrStorageCapacity);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

@GUID("EF497680-1D9F-11CF-B1F3-02608C9E7553")
interface IADsComputerOperations : IADs
{
    HRESULT Status(IDispatch* ppObject);
    HRESULT Shutdown(short bReboot);
}

@GUID("27636B00-410F-11CF-B1FF-02608C9E7553")
interface IADsGroup : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT Members(IADsMembers* ppMembers);
    HRESULT IsMember(BSTR bstrMember, short* bMember);
    HRESULT Add(BSTR bstrNewItem);
    HRESULT Remove(BSTR bstrItemToBeRemoved);
}

@GUID("3E37E320-17E2-11CF-ABC4-02608C9E7553")
interface IADsUser : IADs
{
    HRESULT get_BadLoginAddress(BSTR* retval);
    HRESULT get_BadLoginCount(int* retval);
    HRESULT get_LastLogin(double* retval);
    HRESULT get_LastLogoff(double* retval);
    HRESULT get_LastFailedLogin(double* retval);
    HRESULT get_PasswordLastChanged(double* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Division(BSTR* retval);
    HRESULT put_Division(BSTR bstrDivision);
    HRESULT get_Department(BSTR* retval);
    HRESULT put_Department(BSTR bstrDepartment);
    HRESULT get_EmployeeID(BSTR* retval);
    HRESULT put_EmployeeID(BSTR bstrEmployeeID);
    HRESULT get_FullName(BSTR* retval);
    HRESULT put_FullName(BSTR bstrFullName);
    HRESULT get_FirstName(BSTR* retval);
    HRESULT put_FirstName(BSTR bstrFirstName);
    HRESULT get_LastName(BSTR* retval);
    HRESULT put_LastName(BSTR bstrLastName);
    HRESULT get_OtherName(BSTR* retval);
    HRESULT put_OtherName(BSTR bstrOtherName);
    HRESULT get_NamePrefix(BSTR* retval);
    HRESULT put_NamePrefix(BSTR bstrNamePrefix);
    HRESULT get_NameSuffix(BSTR* retval);
    HRESULT put_NameSuffix(BSTR bstrNameSuffix);
    HRESULT get_Title(BSTR* retval);
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_Manager(BSTR* retval);
    HRESULT put_Manager(BSTR bstrManager);
    HRESULT get_TelephoneHome(VARIANT* retval);
    HRESULT put_TelephoneHome(VARIANT vTelephoneHome);
    HRESULT get_TelephoneMobile(VARIANT* retval);
    HRESULT put_TelephoneMobile(VARIANT vTelephoneMobile);
    HRESULT get_TelephoneNumber(VARIANT* retval);
    HRESULT put_TelephoneNumber(VARIANT vTelephoneNumber);
    HRESULT get_TelephonePager(VARIANT* retval);
    HRESULT put_TelephonePager(VARIANT vTelephonePager);
    HRESULT get_FaxNumber(VARIANT* retval);
    HRESULT put_FaxNumber(VARIANT vFaxNumber);
    HRESULT get_OfficeLocations(VARIANT* retval);
    HRESULT put_OfficeLocations(VARIANT vOfficeLocations);
    HRESULT get_PostalAddresses(VARIANT* retval);
    HRESULT put_PostalAddresses(VARIANT vPostalAddresses);
    HRESULT get_PostalCodes(VARIANT* retval);
    HRESULT put_PostalCodes(VARIANT vPostalCodes);
    HRESULT get_SeeAlso(VARIANT* retval);
    HRESULT put_SeeAlso(VARIANT vSeeAlso);
    HRESULT get_AccountDisabled(short* retval);
    HRESULT put_AccountDisabled(short fAccountDisabled);
    HRESULT get_AccountExpirationDate(double* retval);
    HRESULT put_AccountExpirationDate(double daAccountExpirationDate);
    HRESULT get_GraceLoginsAllowed(int* retval);
    HRESULT put_GraceLoginsAllowed(int lnGraceLoginsAllowed);
    HRESULT get_GraceLoginsRemaining(int* retval);
    HRESULT put_GraceLoginsRemaining(int lnGraceLoginsRemaining);
    HRESULT get_IsAccountLocked(short* retval);
    HRESULT put_IsAccountLocked(short fIsAccountLocked);
    HRESULT get_LoginHours(VARIANT* retval);
    HRESULT put_LoginHours(VARIANT vLoginHours);
    HRESULT get_LoginWorkstations(VARIANT* retval);
    HRESULT put_LoginWorkstations(VARIANT vLoginWorkstations);
    HRESULT get_MaxLogins(int* retval);
    HRESULT put_MaxLogins(int lnMaxLogins);
    HRESULT get_MaxStorage(int* retval);
    HRESULT put_MaxStorage(int lnMaxStorage);
    HRESULT get_PasswordExpirationDate(double* retval);
    HRESULT put_PasswordExpirationDate(double daPasswordExpirationDate);
    HRESULT get_PasswordMinimumLength(int* retval);
    HRESULT put_PasswordMinimumLength(int lnPasswordMinimumLength);
    HRESULT get_PasswordRequired(short* retval);
    HRESULT put_PasswordRequired(short fPasswordRequired);
    HRESULT get_RequireUniquePassword(short* retval);
    HRESULT put_RequireUniquePassword(short fRequireUniquePassword);
    HRESULT get_EmailAddress(BSTR* retval);
    HRESULT put_EmailAddress(BSTR bstrEmailAddress);
    HRESULT get_HomeDirectory(BSTR* retval);
    HRESULT put_HomeDirectory(BSTR bstrHomeDirectory);
    HRESULT get_Languages(VARIANT* retval);
    HRESULT put_Languages(VARIANT vLanguages);
    HRESULT get_Profile(BSTR* retval);
    HRESULT put_Profile(BSTR bstrProfile);
    HRESULT get_LoginScript(BSTR* retval);
    HRESULT put_LoginScript(BSTR bstrLoginScript);
    HRESULT get_Picture(VARIANT* retval);
    HRESULT put_Picture(VARIANT vPicture);
    HRESULT get_HomePage(BSTR* retval);
    HRESULT put_HomePage(BSTR bstrHomePage);
    HRESULT Groups(IADsMembers* ppGroups);
    HRESULT SetPassword(BSTR NewPassword);
    HRESULT ChangePassword(BSTR bstrOldPassword, BSTR bstrNewPassword);
}

@GUID("B15160D0-1226-11CF-A985-00AA006BC149")
interface IADsPrintQueue : IADs
{
    HRESULT get_PrinterPath(BSTR* retval);
    HRESULT put_PrinterPath(BSTR bstrPrinterPath);
    HRESULT get_Model(BSTR* retval);
    HRESULT put_Model(BSTR bstrModel);
    HRESULT get_Datatype(BSTR* retval);
    HRESULT put_Datatype(BSTR bstrDatatype);
    HRESULT get_PrintProcessor(BSTR* retval);
    HRESULT put_PrintProcessor(BSTR bstrPrintProcessor);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Location(BSTR* retval);
    HRESULT put_Location(BSTR bstrLocation);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_DefaultJobPriority(int* retval);
    HRESULT put_DefaultJobPriority(int lnDefaultJobPriority);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_BannerPage(BSTR* retval);
    HRESULT put_BannerPage(BSTR bstrBannerPage);
    HRESULT get_PrintDevices(VARIANT* retval);
    HRESULT put_PrintDevices(VARIANT vPrintDevices);
    HRESULT get_NetAddresses(VARIANT* retval);
    HRESULT put_NetAddresses(VARIANT vNetAddresses);
}

@GUID("124BE5C0-156E-11CF-A986-00AA006BC149")
interface IADsPrintQueueOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT PrintJobs(IADsCollection* pObject);
    HRESULT Pause();
    HRESULT Resume();
    HRESULT Purge();
}

@GUID("32FB6780-1ED0-11CF-A988-00AA006BC149")
interface IADsPrintJob : IADs
{
    HRESULT get_HostPrintQueue(BSTR* retval);
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_TimeSubmitted(double* retval);
    HRESULT get_TotalPages(int* retval);
    HRESULT get_Size(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_Priority(int* retval);
    HRESULT put_Priority(int lnPriority);
    HRESULT get_StartTime(double* retval);
    HRESULT put_StartTime(double daStartTime);
    HRESULT get_UntilTime(double* retval);
    HRESULT put_UntilTime(double daUntilTime);
    HRESULT get_Notify(BSTR* retval);
    HRESULT put_Notify(BSTR bstrNotify);
    HRESULT get_NotifyPath(BSTR* retval);
    HRESULT put_NotifyPath(BSTR bstrNotifyPath);
}

@GUID("9A52DB30-1ECF-11CF-A988-00AA006BC149")
interface IADsPrintJobOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT get_TimeElapsed(int* retval);
    HRESULT get_PagesPrinted(int* retval);
    HRESULT get_Position(int* retval);
    HRESULT put_Position(int lnPosition);
    HRESULT Pause();
    HRESULT Resume();
}

@GUID("68AF66E0-31CA-11CF-A98A-00AA006BC149")
interface IADsService : IADs
{
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_DisplayName(BSTR* retval);
    HRESULT put_DisplayName(BSTR bstrDisplayName);
    HRESULT get_Version(BSTR* retval);
    HRESULT put_Version(BSTR bstrVersion);
    HRESULT get_ServiceType(int* retval);
    HRESULT put_ServiceType(int lnServiceType);
    HRESULT get_StartType(int* retval);
    HRESULT put_StartType(int lnStartType);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_StartupParameters(BSTR* retval);
    HRESULT put_StartupParameters(BSTR bstrStartupParameters);
    HRESULT get_ErrorControl(int* retval);
    HRESULT put_ErrorControl(int lnErrorControl);
    HRESULT get_LoadOrderGroup(BSTR* retval);
    HRESULT put_LoadOrderGroup(BSTR bstrLoadOrderGroup);
    HRESULT get_ServiceAccountName(BSTR* retval);
    HRESULT put_ServiceAccountName(BSTR bstrServiceAccountName);
    HRESULT get_ServiceAccountPath(BSTR* retval);
    HRESULT put_ServiceAccountPath(BSTR bstrServiceAccountPath);
    HRESULT get_Dependencies(VARIANT* retval);
    HRESULT put_Dependencies(VARIANT vDependencies);
}

@GUID("5D7B33F0-31CA-11CF-A98A-00AA006BC149")
interface IADsServiceOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT Start();
    HRESULT Stop();
    HRESULT Pause();
    HRESULT Continue();
    HRESULT SetPassword(BSTR bstrNewPassword);
}

@GUID("A89D1900-31CA-11CF-A98A-00AA006BC149")
interface IADsFileService : IADsService
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

@GUID("A02DED10-31CA-11CF-A98A-00AA006BC149")
interface IADsFileServiceOperations : IADsServiceOperations
{
    HRESULT Sessions(IADsCollection* ppSessions);
    HRESULT Resources(IADsCollection* ppResources);
}

@GUID("EB6DCAF0-4B83-11CF-A995-00AA006BC149")
interface IADsFileShare : IADs
{
    HRESULT get_CurrentUserCount(int* retval);
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_HostComputer(BSTR* retval);
    HRESULT put_HostComputer(BSTR bstrHostComputer);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

@GUID("398B7DA0-4AAB-11CF-AE2C-00AA006EBFB9")
interface IADsSession : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Computer(BSTR* retval);
    HRESULT get_ComputerPath(BSTR* retval);
    HRESULT get_ConnectTime(int* retval);
    HRESULT get_IdleTime(int* retval);
}

@GUID("34A05B20-4AAB-11CF-AE2C-00AA006EBFB9")
interface IADsResource : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Path(BSTR* retval);
    HRESULT get_LockCount(int* retval);
}

@GUID("DDF2891E-0F9C-11D0-8AD4-00C04FD8D503")
interface IADsOpenDSObject : IDispatch
{
    HRESULT OpenDSObject(BSTR lpszDNName, BSTR lpszUserName, BSTR lpszPassword, int lnReserved, 
                         IDispatch* ppOleDsObj);
}

@GUID("E798DE2C-22E4-11D0-84FE-00C04FD8D503")
interface IDirectoryObject : IUnknown
{
    HRESULT GetObjectInformation(ADS_OBJECT_INFO** ppObjInfo);
    HRESULT GetObjectAttributes(ushort** pAttributeNames, uint dwNumberAttributes, 
                                ADS_ATTR_INFO** ppAttributeEntries, uint* pdwNumAttributesReturned);
    HRESULT SetObjectAttributes(ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                                uint* pdwNumAttributesModified);
    HRESULT CreateDSObject(const(wchar)* pszRDNName, ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                           IDispatch* ppObject);
    HRESULT DeleteDSObject(const(wchar)* pszRDNName);
}

@GUID("109BA8EC-92F0-11D0-A790-00C04FD8D5A8")
interface IDirectorySearch : IUnknown
{
    HRESULT SetSearchPreference(ads_searchpref_info* pSearchPrefs, uint dwNumPrefs);
    HRESULT ExecuteSearch(const(wchar)* pszSearchFilter, ushort** pAttributeNames, uint dwNumberAttributes, 
                          ptrdiff_t* phSearchResult);
    HRESULT AbandonSearch(ptrdiff_t phSearchResult);
    HRESULT GetFirstRow(ptrdiff_t hSearchResult);
    HRESULT GetNextRow(ptrdiff_t hSearchResult);
    HRESULT GetPreviousRow(ptrdiff_t hSearchResult);
    HRESULT GetNextColumnName(ptrdiff_t hSearchHandle, ushort** ppszColumnName);
    HRESULT GetColumn(ptrdiff_t hSearchResult, const(wchar)* szColumnName, ads_search_column* pSearchColumn);
    HRESULT FreeColumn(ads_search_column* pSearchColumn);
    HRESULT CloseSearchHandle(ptrdiff_t hSearchResult);
}

@GUID("75DB3B9C-A4D8-11D0-A79C-00C04FD8D5A8")
interface IDirectorySchemaMgmt : IUnknown
{
    HRESULT EnumAttributes(ushort** ppszAttrNames, uint dwNumAttributes, ADS_ATTR_DEF** ppAttrDefinition, 
                           uint* pdwNumAttributes);
    HRESULT CreateAttributeDefinition(const(wchar)* pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT WriteAttributeDefinition(const(wchar)* pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    HRESULT DeleteAttributeDefinition(const(wchar)* pszAttributeName);
    HRESULT EnumClasses(ushort** ppszClassNames, uint dwNumClasses, ADS_CLASS_DEF** ppClassDefinition, 
                        uint* pdwNumClasses);
    HRESULT WriteClassDefinition(const(wchar)* pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT CreateClassDefinition(const(wchar)* pszClassName, ADS_CLASS_DEF* pClassDefinition);
    HRESULT DeleteClassDefinition(const(wchar)* pszClassName);
}

@GUID("1346CE8C-9039-11D0-8528-00C04FD8D503")
interface IADsAggregatee : IUnknown
{
    HRESULT ConnectAsAggregatee(IUnknown pOuterUnknown);
    HRESULT DisconnectAsAggregatee();
    HRESULT RelinquishInterface(const(GUID)* riid);
    HRESULT RestoreInterface(const(GUID)* riid);
}

@GUID("52DB5FB0-941F-11D0-8529-00C04FD8D503")
interface IADsAggregator : IUnknown
{
    HRESULT ConnectAsAggregator(IUnknown pAggregatee);
    HRESULT DisconnectAsAggregator();
}

@GUID("B4F3A14C-9BDD-11D0-852C-00C04FD8D503")
interface IADsAccessControlEntry : IDispatch
{
    HRESULT get_AccessMask(int* retval);
    HRESULT put_AccessMask(int lnAccessMask);
    HRESULT get_AceType(int* retval);
    HRESULT put_AceType(int lnAceType);
    HRESULT get_AceFlags(int* retval);
    HRESULT put_AceFlags(int lnAceFlags);
    HRESULT get_Flags(int* retval);
    HRESULT put_Flags(int lnFlags);
    HRESULT get_ObjectType(BSTR* retval);
    HRESULT put_ObjectType(BSTR bstrObjectType);
    HRESULT get_InheritedObjectType(BSTR* retval);
    HRESULT put_InheritedObjectType(BSTR bstrInheritedObjectType);
    HRESULT get_Trustee(BSTR* retval);
    HRESULT put_Trustee(BSTR bstrTrustee);
}

@GUID("B7EE91CC-9BDD-11D0-852C-00C04FD8D503")
interface IADsAccessControlList : IDispatch
{
    HRESULT get_AclRevision(int* retval);
    HRESULT put_AclRevision(int lnAclRevision);
    HRESULT get_AceCount(int* retval);
    HRESULT put_AceCount(int lnAceCount);
    HRESULT AddAce(IDispatch pAccessControlEntry);
    HRESULT RemoveAce(IDispatch pAccessControlEntry);
    HRESULT CopyAccessList(IDispatch* ppAccessControlList);
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("B8C787CA-9BDD-11D0-852C-00C04FD8D503")
interface IADsSecurityDescriptor : IDispatch
{
    HRESULT get_Revision(int* retval);
    HRESULT put_Revision(int lnRevision);
    HRESULT get_Control(int* retval);
    HRESULT put_Control(int lnControl);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_OwnerDefaulted(short* retval);
    HRESULT put_OwnerDefaulted(short fOwnerDefaulted);
    HRESULT get_Group(BSTR* retval);
    HRESULT put_Group(BSTR bstrGroup);
    HRESULT get_GroupDefaulted(short* retval);
    HRESULT put_GroupDefaulted(short fGroupDefaulted);
    HRESULT get_DiscretionaryAcl(IDispatch* retval);
    HRESULT put_DiscretionaryAcl(IDispatch pDiscretionaryAcl);
    HRESULT get_DaclDefaulted(short* retval);
    HRESULT put_DaclDefaulted(short fDaclDefaulted);
    HRESULT get_SystemAcl(IDispatch* retval);
    HRESULT put_SystemAcl(IDispatch pSystemAcl);
    HRESULT get_SaclDefaulted(short* retval);
    HRESULT put_SaclDefaulted(short fSaclDefaulted);
    HRESULT CopySecurityDescriptor(IDispatch* ppSecurityDescriptor);
}

@GUID("9068270B-0939-11D1-8BE1-00C04FD8D503")
interface IADsLargeInteger : IDispatch
{
    HRESULT get_HighPart(int* retval);
    HRESULT put_HighPart(int lnHighPart);
    HRESULT get_LowPart(int* retval);
    HRESULT put_LowPart(int lnLowPart);
}

@GUID("B1B272A3-3625-11D1-A3A4-00C04FB950DC")
interface IADsNameTranslate : IDispatch
{
    HRESULT put_ChaseReferral(int lnChaseReferral);
    HRESULT Init(int lnSetType, BSTR bstrADsPath);
    HRESULT InitEx(int lnSetType, BSTR bstrADsPath, BSTR bstrUserID, BSTR bstrDomain, BSTR bstrPassword);
    HRESULT Set(int lnSetType, BSTR bstrADsPath);
    HRESULT Get(int lnFormatType, BSTR* pbstrADsPath);
    HRESULT SetEx(int lnFormatType, VARIANT pvar);
    HRESULT GetEx(int lnFormatType, VARIANT* pvar);
}

@GUID("7B66B533-4680-11D1-A3B4-00C04FB950DC")
interface IADsCaseIgnoreList : IDispatch
{
    HRESULT get_CaseIgnoreList(VARIANT* retval);
    HRESULT put_CaseIgnoreList(VARIANT vCaseIgnoreList);
}

@GUID("A910DEA9-4680-11D1-A3B4-00C04FB950DC")
interface IADsFaxNumber : IDispatch
{
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_Parameters(VARIANT* retval);
    HRESULT put_Parameters(VARIANT vParameters);
}

@GUID("B21A50A9-4080-11D1-A3AC-00C04FB950DC")
interface IADsNetAddress : IDispatch
{
    HRESULT get_AddressType(int* retval);
    HRESULT put_AddressType(int lnAddressType);
    HRESULT get_Address(VARIANT* retval);
    HRESULT put_Address(VARIANT vAddress);
}

@GUID("7B28B80F-4680-11D1-A3B4-00C04FB950DC")
interface IADsOctetList : IDispatch
{
    HRESULT get_OctetList(VARIANT* retval);
    HRESULT put_OctetList(VARIANT vOctetList);
}

@GUID("97AF011A-478E-11D1-A3B4-00C04FB950DC")
interface IADsEmail : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_Address(BSTR* retval);
    HRESULT put_Address(BSTR bstrAddress);
}

@GUID("B287FCD5-4080-11D1-A3AC-00C04FB950DC")
interface IADsPath : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_VolumeName(BSTR* retval);
    HRESULT put_VolumeName(BSTR bstrVolumeName);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
}

@GUID("F60FB803-4080-11D1-A3AC-00C04FB950DC")
interface IADsReplicaPointer : IDispatch
{
    HRESULT get_ServerName(BSTR* retval);
    HRESULT put_ServerName(BSTR bstrServerName);
    HRESULT get_ReplicaType(int* retval);
    HRESULT put_ReplicaType(int lnReplicaType);
    HRESULT get_ReplicaNumber(int* retval);
    HRESULT put_ReplicaNumber(int lnReplicaNumber);
    HRESULT get_Count(int* retval);
    HRESULT put_Count(int lnCount);
    HRESULT get_ReplicaAddressHints(VARIANT* retval);
    HRESULT put_ReplicaAddressHints(VARIANT vReplicaAddressHints);
}

@GUID("8452D3AB-0869-11D1-A377-00C04FB950DC")
interface IADsAcl : IDispatch
{
    HRESULT get_ProtectedAttrName(BSTR* retval);
    HRESULT put_ProtectedAttrName(BSTR bstrProtectedAttrName);
    HRESULT get_SubjectName(BSTR* retval);
    HRESULT put_SubjectName(BSTR bstrSubjectName);
    HRESULT get_Privileges(int* retval);
    HRESULT put_Privileges(int lnPrivileges);
    HRESULT CopyAcl(IDispatch* ppAcl);
}

@GUID("B2F5A901-4080-11D1-A3AC-00C04FB950DC")
interface IADsTimestamp : IDispatch
{
    HRESULT get_WholeSeconds(int* retval);
    HRESULT put_WholeSeconds(int lnWholeSeconds);
    HRESULT get_EventID(int* retval);
    HRESULT put_EventID(int lnEventID);
}

@GUID("7ADECF29-4680-11D1-A3B4-00C04FB950DC")
interface IADsPostalAddress : IDispatch
{
    HRESULT get_PostalAddress(VARIANT* retval);
    HRESULT put_PostalAddress(VARIANT vPostalAddress);
}

@GUID("FD1302BD-4080-11D1-A3AC-00C04FB950DC")
interface IADsBackLink : IDispatch
{
    HRESULT get_RemoteID(int* retval);
    HRESULT put_RemoteID(int lnRemoteID);
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
}

@GUID("B371A349-4080-11D1-A3AC-00C04FB950DC")
interface IADsTypedName : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Level(int* retval);
    HRESULT put_Level(int lnLevel);
    HRESULT get_Interval(int* retval);
    HRESULT put_Interval(int lnInterval);
}

@GUID("B3EB3B37-4080-11D1-A3AC-00C04FB950DC")
interface IADsHold : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Amount(int* retval);
    HRESULT put_Amount(int lnAmount);
}

@GUID("46F14FDA-232B-11D1-A808-00C04FD8D5A8")
interface IADsObjectOptions : IDispatch
{
    HRESULT GetOption(int lnOption, VARIANT* pvValue);
    HRESULT SetOption(int lnOption, VARIANT vValue);
}

@GUID("D592AED4-F420-11D0-A36E-00C04FB950DC")
interface IADsPathname : IDispatch
{
    HRESULT Set(BSTR bstrADsPath, int lnSetType);
    HRESULT SetDisplayType(int lnDisplayType);
    HRESULT Retrieve(int lnFormatType, BSTR* pbstrADsPath);
    HRESULT GetNumElements(int* plnNumPathElements);
    HRESULT GetElement(int lnElementIndex, BSTR* pbstrElement);
    HRESULT AddLeafElement(BSTR bstrLeafElement);
    HRESULT RemoveLeafElement();
    HRESULT CopyPath(IDispatch* ppAdsPath);
    HRESULT GetEscapedElement(int lnReserved, BSTR bstrInStr, BSTR* pbstrOutStr);
    HRESULT get_EscapedMode(int* retval);
    HRESULT put_EscapedMode(int lnEscapedMode);
}

@GUID("5BB11929-AFD1-11D2-9CB9-0000F87A369E")
interface IADsADSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_SiteName(BSTR* retval);
    HRESULT get_DomainShortName(BSTR* retval);
    HRESULT get_DomainDNSName(BSTR* retval);
    HRESULT get_ForestDNSName(BSTR* retval);
    HRESULT get_PDCRoleOwner(BSTR* retval);
    HRESULT get_SchemaRoleOwner(BSTR* retval);
    HRESULT get_IsNativeMode(short* retval);
    HRESULT GetAnyDCName(BSTR* pszDCName);
    HRESULT GetDCSiteName(BSTR szServer, BSTR* pszSiteName);
    HRESULT RefreshSchemaCache();
    HRESULT GetTrees(VARIANT* pvTrees);
}

@GUID("6C6D65DC-AFD1-11D2-9CB9-0000F87A369E")
interface IADsWinNTSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_DomainName(BSTR* retval);
    HRESULT get_PDC(BSTR* retval);
}

@GUID("7E99C0A2-F935-11D2-BA96-00C04FB6D0D1")
interface IADsDNWithBinary : IDispatch
{
    HRESULT get_BinaryValue(VARIANT* retval);
    HRESULT put_BinaryValue(VARIANT vBinaryValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

@GUID("370DF02E-F934-11D2-BA96-00C04FB6D0D1")
interface IADsDNWithString : IDispatch
{
    HRESULT get_StringValue(BSTR* retval);
    HRESULT put_StringValue(BSTR bstrStringValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

@GUID("A63251B2-5F21-474B-AB52-4A8EFAD10895")
interface IADsSecurityUtility : IDispatch
{
    HRESULT GetSecurityDescriptor(VARIANT varPath, int lPathFormat, int lFormat, VARIANT* pVariant);
    HRESULT SetSecurityDescriptor(VARIANT varPath, int lPathFormat, VARIANT varData, int lDataFormat);
    HRESULT ConvertSecurityDescriptor(VARIANT varSD, int lDataFormat, int lOutFormat, VARIANT* pResult);
    HRESULT get_SecurityMask(int* retval);
    HRESULT put_SecurityMask(int lnSecurityMask);
}

@GUID("7CABCF1E-78F5-11D2-960C-00C04FA31A86")
interface IDsBrowseDomainTree : IUnknown
{
    HRESULT BrowseTo(HWND hwndParent, ushort** ppszTargetPath, uint dwFlags);
    HRESULT GetDomains(DOMAIN_TREE** ppDomainTree, uint dwFlags);
    HRESULT FreeDomains(DOMAIN_TREE** ppDomainTree);
    HRESULT FlushCachedDomains();
    HRESULT SetComputer(const(wchar)* pszComputerName, const(wchar)* pszUserName, const(wchar)* pszPassword);
}

@GUID("1AB4A8C0-6A0B-11D2-AD49-00C04FA31A86")
interface IDsDisplaySpecifier : IUnknown
{
    HRESULT SetServer(const(wchar)* pszServer, const(wchar)* pszUserName, const(wchar)* pszPassword, uint dwFlags);
    HRESULT SetLanguageID(ushort langid);
    HRESULT GetDisplaySpecifier(const(wchar)* pszObjectClass, const(GUID)* riid, void** ppv);
    HRESULT GetIconLocation(const(wchar)* pszObjectClass, uint dwFlags, const(wchar)* pszBuffer, int cchBuffer, 
                            int* presid);
    HICON   GetIcon(const(wchar)* pszObjectClass, uint dwFlags, int cxIcon, int cyIcon);
    HRESULT GetFriendlyClassName(const(wchar)* pszObjectClass, const(wchar)* pszBuffer, int cchBuffer);
    HRESULT GetFriendlyAttributeName(const(wchar)* pszObjectClass, const(wchar)* pszAttributeName, 
                                     const(wchar)* pszBuffer, uint cchBuffer);
    BOOL    IsClassContainer(const(wchar)* pszObjectClass, const(wchar)* pszADsPath, uint dwFlags);
    HRESULT GetClassCreationInfo(const(wchar)* pszObjectClass, DSCLASSCREATIONINFO** ppdscci);
    HRESULT EnumClassAttributes(const(wchar)* pszObjectClass, LPDSENUMATTRIBUTES pcbEnum, LPARAM lParam);
    ADSTYPEENUM GetAttributeADsType(const(wchar)* pszAttributeName);
}

interface IDsObjectPicker : IUnknown
{
    HRESULT Initialize(DSOP_INIT_INFO* pInitInfo);
    HRESULT InvokeDialog(HWND hwndParent, IDataObject* ppdoSelections);
}

interface IDsObjectPickerCredentials : IDsObjectPicker
{
    HRESULT SetCredentials(const(wchar)* szUserName, const(wchar)* szPassword);
}

interface IDsAdminCreateObj : IUnknown
{
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(wchar)* lpszClassName);
    HRESULT CreateModal(HWND hwndParent, IADs* ppADsObj);
}

interface IDsAdminNewObj : IUnknown
{
    HRESULT SetButtons(uint nCurrIndex, BOOL bValid);
    HRESULT GetPageCounts(int* pnTotal, int* pnStartIndex);
}

interface IDsAdminNewObjPrimarySite : IUnknown
{
    HRESULT CreateNew(const(wchar)* pszName);
    HRESULT Commit();
}

interface IDsAdminNewObjExt : IUnknown
{
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(wchar)* lpszClassName, 
                       IDsAdminNewObj pDsAdminNewObj, DSA_NEWOBJ_DISPINFO* pDispInfo);
    HRESULT AddPages(LPFNADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);
    HRESULT SetObject(IADs pADsObj);
    HRESULT WriteData(HWND hWnd, uint uContext);
    HRESULT OnError(HWND hWnd, HRESULT hr, uint uContext);
    HRESULT GetSummaryInfo(BSTR* pBstrText);
}

interface IDsAdminNotifyHandler : IUnknown
{
    HRESULT Initialize(IDataObject pExtraInfo, uint* puEventFlags);
    HRESULT Begin(uint uEvent, IDataObject pArg1, IDataObject pArg2, uint* puFlags, BSTR* pBstr);
    HRESULT Notify(uint nItem, uint uFlags);
    HRESULT End();
}


// GUIDs

const GUID CLSID_ADSystemInfo       = GUIDOF!ADSystemInfo;
const GUID CLSID_ADsSecurityUtility = GUIDOF!ADsSecurityUtility;
const GUID CLSID_AccessControlEntry = GUIDOF!AccessControlEntry;
const GUID CLSID_AccessControlList  = GUIDOF!AccessControlList;
const GUID CLSID_BackLink           = GUIDOF!BackLink;
const GUID CLSID_CaseIgnoreList     = GUIDOF!CaseIgnoreList;
const GUID CLSID_DNWithBinary       = GUIDOF!DNWithBinary;
const GUID CLSID_DNWithString       = GUIDOF!DNWithString;
const GUID CLSID_Email              = GUIDOF!Email;
const GUID CLSID_FaxNumber          = GUIDOF!FaxNumber;
const GUID CLSID_Hold               = GUIDOF!Hold;
const GUID CLSID_LargeInteger       = GUIDOF!LargeInteger;
const GUID CLSID_NameTranslate      = GUIDOF!NameTranslate;
const GUID CLSID_NetAddress         = GUIDOF!NetAddress;
const GUID CLSID_OctetList          = GUIDOF!OctetList;
const GUID CLSID_Path               = GUIDOF!Path;
const GUID CLSID_Pathname           = GUIDOF!Pathname;
const GUID CLSID_PostalAddress      = GUIDOF!PostalAddress;
const GUID CLSID_PropertyEntry      = GUIDOF!PropertyEntry;
const GUID CLSID_PropertyValue      = GUIDOF!PropertyValue;
const GUID CLSID_ReplicaPointer     = GUIDOF!ReplicaPointer;
const GUID CLSID_SecurityDescriptor = GUIDOF!SecurityDescriptor;
const GUID CLSID_Timestamp          = GUIDOF!Timestamp;
const GUID CLSID_TypedName          = GUIDOF!TypedName;
const GUID CLSID_WinNTSystemInfo    = GUIDOF!WinNTSystemInfo;

const GUID IID_IADs                      = GUIDOF!IADs;
const GUID IID_IADsADSystemInfo          = GUIDOF!IADsADSystemInfo;
const GUID IID_IADsAccessControlEntry    = GUIDOF!IADsAccessControlEntry;
const GUID IID_IADsAccessControlList     = GUIDOF!IADsAccessControlList;
const GUID IID_IADsAcl                   = GUIDOF!IADsAcl;
const GUID IID_IADsAggregatee            = GUIDOF!IADsAggregatee;
const GUID IID_IADsAggregator            = GUIDOF!IADsAggregator;
const GUID IID_IADsBackLink              = GUIDOF!IADsBackLink;
const GUID IID_IADsCaseIgnoreList        = GUIDOF!IADsCaseIgnoreList;
const GUID IID_IADsClass                 = GUIDOF!IADsClass;
const GUID IID_IADsCollection            = GUIDOF!IADsCollection;
const GUID IID_IADsComputer              = GUIDOF!IADsComputer;
const GUID IID_IADsComputerOperations    = GUIDOF!IADsComputerOperations;
const GUID IID_IADsContainer             = GUIDOF!IADsContainer;
const GUID IID_IADsDNWithBinary          = GUIDOF!IADsDNWithBinary;
const GUID IID_IADsDNWithString          = GUIDOF!IADsDNWithString;
const GUID IID_IADsDeleteOps             = GUIDOF!IADsDeleteOps;
const GUID IID_IADsDomain                = GUIDOF!IADsDomain;
const GUID IID_IADsEmail                 = GUIDOF!IADsEmail;
const GUID IID_IADsExtension             = GUIDOF!IADsExtension;
const GUID IID_IADsFaxNumber             = GUIDOF!IADsFaxNumber;
const GUID IID_IADsFileService           = GUIDOF!IADsFileService;
const GUID IID_IADsFileServiceOperations = GUIDOF!IADsFileServiceOperations;
const GUID IID_IADsFileShare             = GUIDOF!IADsFileShare;
const GUID IID_IADsGroup                 = GUIDOF!IADsGroup;
const GUID IID_IADsHold                  = GUIDOF!IADsHold;
const GUID IID_IADsLargeInteger          = GUIDOF!IADsLargeInteger;
const GUID IID_IADsLocality              = GUIDOF!IADsLocality;
const GUID IID_IADsMembers               = GUIDOF!IADsMembers;
const GUID IID_IADsNameTranslate         = GUIDOF!IADsNameTranslate;
const GUID IID_IADsNamespaces            = GUIDOF!IADsNamespaces;
const GUID IID_IADsNetAddress            = GUIDOF!IADsNetAddress;
const GUID IID_IADsO                     = GUIDOF!IADsO;
const GUID IID_IADsOU                    = GUIDOF!IADsOU;
const GUID IID_IADsObjectOptions         = GUIDOF!IADsObjectOptions;
const GUID IID_IADsOctetList             = GUIDOF!IADsOctetList;
const GUID IID_IADsOpenDSObject          = GUIDOF!IADsOpenDSObject;
const GUID IID_IADsPath                  = GUIDOF!IADsPath;
const GUID IID_IADsPathname              = GUIDOF!IADsPathname;
const GUID IID_IADsPostalAddress         = GUIDOF!IADsPostalAddress;
const GUID IID_IADsPrintJob              = GUIDOF!IADsPrintJob;
const GUID IID_IADsPrintJobOperations    = GUIDOF!IADsPrintJobOperations;
const GUID IID_IADsPrintQueue            = GUIDOF!IADsPrintQueue;
const GUID IID_IADsPrintQueueOperations  = GUIDOF!IADsPrintQueueOperations;
const GUID IID_IADsProperty              = GUIDOF!IADsProperty;
const GUID IID_IADsPropertyEntry         = GUIDOF!IADsPropertyEntry;
const GUID IID_IADsPropertyList          = GUIDOF!IADsPropertyList;
const GUID IID_IADsPropertyValue         = GUIDOF!IADsPropertyValue;
const GUID IID_IADsPropertyValue2        = GUIDOF!IADsPropertyValue2;
const GUID IID_IADsReplicaPointer        = GUIDOF!IADsReplicaPointer;
const GUID IID_IADsResource              = GUIDOF!IADsResource;
const GUID IID_IADsSecurityDescriptor    = GUIDOF!IADsSecurityDescriptor;
const GUID IID_IADsSecurityUtility       = GUIDOF!IADsSecurityUtility;
const GUID IID_IADsService               = GUIDOF!IADsService;
const GUID IID_IADsServiceOperations     = GUIDOF!IADsServiceOperations;
const GUID IID_IADsSession               = GUIDOF!IADsSession;
const GUID IID_IADsSyntax                = GUIDOF!IADsSyntax;
const GUID IID_IADsTimestamp             = GUIDOF!IADsTimestamp;
const GUID IID_IADsTypedName             = GUIDOF!IADsTypedName;
const GUID IID_IADsUser                  = GUIDOF!IADsUser;
const GUID IID_IADsWinNTSystemInfo       = GUIDOF!IADsWinNTSystemInfo;
const GUID IID_ICommonQuery              = GUIDOF!ICommonQuery;
const GUID IID_IDirectoryObject          = GUIDOF!IDirectoryObject;
const GUID IID_IDirectorySchemaMgmt      = GUIDOF!IDirectorySchemaMgmt;
const GUID IID_IDirectorySearch          = GUIDOF!IDirectorySearch;
const GUID IID_IDsBrowseDomainTree       = GUIDOF!IDsBrowseDomainTree;
const GUID IID_IDsDisplaySpecifier       = GUIDOF!IDsDisplaySpecifier;
const GUID IID_IPersistQuery             = GUIDOF!IPersistQuery;
const GUID IID_IPrivateDispatch          = GUIDOF!IPrivateDispatch;
const GUID IID_IPrivateUnknown           = GUIDOF!IPrivateUnknown;
const GUID IID_IQueryForm                = GUIDOF!IQueryForm;
