// Written in the D programming language.

module windows.win32.networking.activedirectory;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, BSTR, CHAR, FILETIME, HANDLE,
                                         HINSTANCE, HRESULT, HWND, LPARAM, PSTR,
                                         PWSTR, SYSTEMTIME, VARIANT_BOOL, WPARAM;
public import windows.win32.networking.winsock : SOCKET_ADDRESS;
public import windows.win32.security.authentication.identity : LSA_FOREST_TRUST_INFORMATION;
public import windows.win32.security : PSECURITY_DESCRIPTOR, PSID;
public import windows.win32.system.com : DISPPARAMS, EXCEPINFO, IDataObject, IDispatch,
                                         IPersist, ITypeInfo, IUnknown;
public import windows.win32.system.com.structuredstorage : IPropertyBag;
public import windows.win32.system.ole : IEnumVARIANT;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : LPFNSVADDPROPSHEETPAGE;
public import windows.win32.ui.shell : BFFCALLBACK;
public import windows.win32.ui.windowsandmessaging : DLGPROC, HICON;

extern(Windows) @nogc nothrow:


// Enums


alias ADSTYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_authentication_enum
alias ADS_AUTHENTICATION_ENUM = uint;
enum : uint
{
    ADS_SECURE_AUTHENTICATION = 0x00000001U,
    ADS_USE_ENCRYPTION        = 0x00000002U,
    ADS_USE_SSL               = 0x00000002U,
    ADS_READONLY_SERVER       = 0x00000004U,
    ADS_PROMPT_CREDENTIALS    = 0x00000008U,
    ADS_NO_AUTHENTICATION     = 0x00000010U,
    ADS_FAST_BIND             = 0x00000020U,
    ADS_USE_SIGNING           = 0x00000040U,
    ADS_USE_SEALING           = 0x00000080U,
    ADS_USE_DELEGATION        = 0x00000100U,
    ADS_SERVER_BIND           = 0x00000200U,
    ADS_NO_REFERRAL_CHASING   = 0x00000400U,
    ADS_AUTH_RESERVED         = 0x80000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_statusenum
alias ADS_STATUSENUM = int;
enum : int
{
    ADS_STATUS_S_OK                    = 0x00000000,
    ADS_STATUS_INVALID_SEARCHPREF      = 0x00000001,
    ADS_STATUS_INVALID_SEARCHPREFVALUE = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_derefenum
alias ADS_DEREFENUM = int;
enum : int
{
    ADS_DEREF_NEVER     = 0x00000000,
    ADS_DEREF_SEARCHING = 0x00000001,
    ADS_DEREF_FINDING   = 0x00000002,
    ADS_DEREF_ALWAYS    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_scopeenum
alias ADS_SCOPEENUM = int;
enum : int
{
    ADS_SCOPE_BASE     = 0x00000000,
    ADS_SCOPE_ONELEVEL = 0x00000001,
    ADS_SCOPE_SUBTREE  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_preferences_enum
alias ADS_PREFERENCES_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-adsi_dialect_enum
alias ADSI_DIALECT_ENUM = int;
enum : int
{
    ADSI_DIALECT_LDAP = 0x00000000,
    ADSI_DIALECT_SQL  = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_chase_referrals_enum
alias ADS_CHASE_REFERRALS_ENUM = int;
enum : int
{
    ADS_CHASE_REFERRALS_NEVER       = 0x00000000,
    ADS_CHASE_REFERRALS_SUBORDINATE = 0x00000020,
    ADS_CHASE_REFERRALS_EXTERNAL    = 0x00000040,
    ADS_CHASE_REFERRALS_ALWAYS      = 0x00000060,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_searchpref_enum
alias ADS_SEARCHPREF_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_password_encoding_enum
alias ADS_PASSWORD_ENCODING_ENUM = int;
enum : int
{
    ADS_PASSWORD_ENCODE_REQUIRE_SSL = 0x00000000,
    ADS_PASSWORD_ENCODE_CLEAR       = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_property_operation_enum
alias ADS_PROPERTY_OPERATION_ENUM = int;
enum : int
{
    ADS_PROPERTY_CLEAR  = 0x00000001,
    ADS_PROPERTY_UPDATE = 0x00000002,
    ADS_PROPERTY_APPEND = 0x00000003,
    ADS_PROPERTY_DELETE = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_systemflag_enum
alias ADS_SYSTEMFLAG_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_group_type_enum
alias ADS_GROUP_TYPE_ENUM = int;
enum : int
{
    ADS_GROUP_TYPE_GLOBAL_GROUP       = 0x00000002,
    ADS_GROUP_TYPE_DOMAIN_LOCAL_GROUP = 0x00000004,
    ADS_GROUP_TYPE_LOCAL_GROUP        = 0x00000004,
    ADS_GROUP_TYPE_UNIVERSAL_GROUP    = 0x00000008,
    ADS_GROUP_TYPE_SECURITY_ENABLED   = 0x80000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_user_flag_enum
alias ADS_USER_FLAG_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_rights_enum
alias ADS_RIGHTS_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_acetype_enum
alias ADS_ACETYPE_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_aceflag_enum
alias ADS_ACEFLAG_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_flagtype_enum
alias ADS_FLAGTYPE_ENUM = int;
enum : int
{
    ADS_FLAG_OBJECT_TYPE_PRESENT           = 0x00000001,
    ADS_FLAG_INHERITED_OBJECT_TYPE_PRESENT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_sd_control_enum
alias ADS_SD_CONTROL_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_sd_revision_enum
alias ADS_SD_REVISION_ENUM = int;
enum : int
{
    ADS_SD_REVISION_DS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_name_type_enum
alias ADS_NAME_TYPE_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_name_inittype_enum
alias ADS_NAME_INITTYPE_ENUM = int;
enum : int
{
    ADS_NAME_INITTYPE_DOMAIN = 0x00000001,
    ADS_NAME_INITTYPE_SERVER = 0x00000002,
    ADS_NAME_INITTYPE_GC     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_option_enum
alias ADS_OPTION_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_security_info_enum
alias ADS_SECURITY_INFO_ENUM = int;
enum : int
{
    ADS_SECURITY_INFO_OWNER = 0x00000001,
    ADS_SECURITY_INFO_GROUP = 0x00000002,
    ADS_SECURITY_INFO_DACL  = 0x00000004,
    ADS_SECURITY_INFO_SACL  = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_settype_enum
alias ADS_SETTYPE_ENUM = int;
enum : int
{
    ADS_SETTYPE_FULL     = 0x00000001,
    ADS_SETTYPE_PROVIDER = 0x00000002,
    ADS_SETTYPE_SERVER   = 0x00000003,
    ADS_SETTYPE_DN       = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_format_enum
alias ADS_FORMAT_ENUM = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_display_enum
alias ADS_DISPLAY_ENUM = int;
enum : int
{
    ADS_DISPLAY_FULL       = 0x00000001,
    ADS_DISPLAY_VALUE_ONLY = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_escape_mode_enum
alias ADS_ESCAPE_MODE_ENUM = int;
enum : int
{
    ADS_ESCAPEDMODE_DEFAULT = 0x00000001,
    ADS_ESCAPEDMODE_ON      = 0x00000002,
    ADS_ESCAPEDMODE_OFF     = 0x00000003,
    ADS_ESCAPEDMODE_OFF_EX  = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_pathtype_enum
alias ADS_PATHTYPE_ENUM = int;
enum : int
{
    ADS_PATH_FILE      = 0x00000001,
    ADS_PATH_FILESHARE = 0x00000002,
    ADS_PATH_REGISTRY  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ne-iads-ads_sd_format_enum
alias ADS_SD_FORMAT_ENUM = int;
enum : int
{
    ADS_SD_FORMAT_IID       = 0x00000001,
    ADS_SD_FORMAT_RAW       = 0x00000002,
    ADS_SD_FORMAT_HEXSTRING = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsparse/ne-dsparse-ds_mangle_for
alias DS_MANGLE_FOR = int;
enum : int
{
    DS_MANGLE_UNKNOWN                      = 0x00000000,
    DS_MANGLE_OBJECT_RDN_FOR_DELETION      = 0x00000001,
    DS_MANGLE_OBJECT_RDN_FOR_NAME_CONFLICT = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_name_format
alias DS_NAME_FORMAT = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_name_flags
alias DS_NAME_FLAGS = int;
enum : int
{
    DS_NAME_NO_FLAGS              = 0x00000000,
    DS_NAME_FLAG_SYNTACTICAL_ONLY = 0x00000001,
    DS_NAME_FLAG_EVAL_AT_DC       = 0x00000002,
    DS_NAME_FLAG_GCVERIFY         = 0x00000004,
    DS_NAME_FLAG_TRUST_REFERRAL   = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_name_error
alias DS_NAME_ERROR = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_spn_name_type
alias DS_SPN_NAME_TYPE = int;
enum : int
{
    DS_SPN_DNS_HOST  = 0x00000000,
    DS_SPN_DN_HOST   = 0x00000001,
    DS_SPN_NB_HOST   = 0x00000002,
    DS_SPN_DOMAIN    = 0x00000003,
    DS_SPN_NB_DOMAIN = 0x00000004,
    DS_SPN_SERVICE   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_spn_write_op
alias DS_SPN_WRITE_OP = int;
enum : int
{
    DS_SPN_ADD_SPN_OP     = 0x00000000,
    DS_SPN_REPLACE_SPN_OP = 0x00000001,
    DS_SPN_DELETE_SPN_OP  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_repsyncall_error
alias DS_REPSYNCALL_ERROR = int;
enum : int
{
    DS_REPSYNCALL_WIN32_ERROR_CONTACTING_SERVER = 0x00000000,
    DS_REPSYNCALL_WIN32_ERROR_REPLICATING       = 0x00000001,
    DS_REPSYNCALL_SERVER_UNREACHABLE            = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_repsyncall_event
alias DS_REPSYNCALL_EVENT = int;
enum : int
{
    DS_REPSYNCALL_EVENT_ERROR          = 0x00000000,
    DS_REPSYNCALL_EVENT_SYNC_STARTED   = 0x00000001,
    DS_REPSYNCALL_EVENT_SYNC_COMPLETED = 0x00000002,
    DS_REPSYNCALL_EVENT_FINISHED       = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_kcc_taskid
alias DS_KCC_TASKID = int;
enum : int
{
    DS_KCC_TASKID_UPDATE_TOPOLOGY = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_repl_info_type
alias DS_REPL_INFO_TYPE = int;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ne-ntdsapi-ds_repl_op_type
alias DS_REPL_OP_TYPE = int;
enum : int
{
    DS_REPL_OP_TYPE_SYNC        = 0x00000000,
    DS_REPL_OP_TYPE_ADD         = 0x00000001,
    DS_REPL_OP_TYPE_DELETE      = 0x00000002,
    DS_REPL_OP_TYPE_MODIFY      = 0x00000003,
    DS_REPL_OP_TYPE_UPDATE_REFS = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ne-dsrole-dsrole_machine_role
alias DSROLE_MACHINE_ROLE = int;
enum : int
{
    DsRole_RoleStandaloneWorkstation   = 0x00000000,
    DsRole_RoleMemberWorkstation       = 0x00000001,
    DsRole_RoleStandaloneServer        = 0x00000002,
    DsRole_RoleMemberServer            = 0x00000003,
    DsRole_RoleBackupDomainController  = 0x00000004,
    DsRole_RolePrimaryDomainController = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ne-dsrole-dsrole_server_state
alias DSROLE_SERVER_STATE = int;
enum : int
{
    DsRoleServerUnknown = 0x00000000,
    DsRoleServerPrimary = 0x00000001,
    DsRoleServerBackup  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ne-dsrole-dsrole_primary_domain_info_level
alias DSROLE_PRIMARY_DOMAIN_INFO_LEVEL = int;
enum : int
{
    DsRolePrimaryDomainInfoBasic = 0x00000001,
    DsRoleUpgradeStatus          = 0x00000002,
    DsRoleOperationState         = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ne-dsrole-dsrole_operation_state
alias DSROLE_OPERATION_STATE = int;
enum : int
{
    DsRoleOperationIdle       = 0x00000000,
    DsRoleOperationActive     = 0x00000001,
    DsRoleOperationNeedReboot = 0x00000002,
}

// Constants


enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-pageinit
    WM_ADSPROP_NOTIFY_PAGEINIT   = 0x0000084dU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-pagehwnd
    WM_ADSPROP_NOTIFY_PAGEHWND   = 0x0000084eU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-change
    WM_ADSPROP_NOTIFY_CHANGE     = 0x0000084fU,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-apply
    WM_ADSPROP_NOTIFY_APPLY      = 0x00000850U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-setfocus
    WM_ADSPROP_NOTIFY_SETFOCUS   = 0x00000851U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-foreground
    WM_ADSPROP_NOTIFY_FOREGROUND = 0x00000852U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-exit
    WM_ADSPROP_NOTIFY_EXIT       = 0x00000853U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/wm-adsprop-notify-error
    WM_ADSPROP_NOTIFY_ERROR      = 0x00000856U,
}

enum GUID CLSID_CommonQuery = GUID("83bc5ec0-6f2a-11d0-a1c4-00aa00c16e65");

enum : ulong
{
    QUERYFORM_CHANGESFORMLIST    = 0x0000000000000001UL,
    QUERYFORM_CHANGESOPTFORMLIST = 0x0000000000000002UL,
}

enum uint CQFF_NOGLOBALPAGES = 0x00000001U;
enum uint CQFF_ISOPTIONAL = 0x00000002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-initialize
enum uint CQPM_INITIALIZE = 0x00000001U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-release
    CQPM_RELEASE       = 0x00000002U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-enable
    CQPM_ENABLE        = 0x00000003U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-getparameters
    CQPM_GETPARAMETERS = 0x00000005U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-clearform
enum uint CQPM_CLEARFORM = 0x00000006U;

enum : uint
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-persist
    CQPM_PERSIST              = 0x00000007U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-help
    CQPM_HELP                 = 0x00000008U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-setdefaultparameters
    CQPM_SETDEFAULTPARAMETERS = 0x00000009U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cqpm-handlerspecific
enum uint CQPM_HANDLERSPECIFIC = 0x10000000U;
enum uint OQWF_OKCANCEL = 0x00000001U;
enum uint OQWF_DEFAULTFORM = 0x00000002U;
enum uint OQWF_SINGLESELECT = 0x00000004U;
enum uint OQWF_LOADQUERY = 0x00000008U;

enum : uint
{
    OQWF_REMOVESCOPES = 0x00000010U,
    OQWF_REMOVEFORMS  = 0x00000020U,
}

enum uint OQWF_ISSUEONOPEN = 0x00000040U;
enum uint OQWF_SHOWOPTIONAL = 0x00000080U;
enum uint OQWF_SAVEQUERYONOK = 0x00000200U;

enum : uint
{
    OQWF_HIDEMENUS    = 0x00000400U,
    OQWF_HIDESEARCHUI = 0x00000800U,
}

enum uint OQWF_PARAMISPROPERTYBAG = 0x80000000U;
enum GUID CLSID_DsAdminCreateObj = GUID("e301a009-f901-11d2-82b9-00c04f68928b");

enum : uint
{
    DSA_NEWOBJ_CTX_PRECOMMIT  = 0x00000001U,
    DSA_NEWOBJ_CTX_COMMIT     = 0x00000002U,
    DSA_NEWOBJ_CTX_POSTCOMMIT = 0x00000003U,
    DSA_NEWOBJ_CTX_CLEANUP    = 0x00000004U,
}

enum : uint
{
    DSA_NOTIFY_DEL                        = 0x00000001U,
    DSA_NOTIFY_REN                        = 0x00000002U,
    DSA_NOTIFY_MOV                        = 0x00000004U,
    DSA_NOTIFY_PROP                       = 0x00000008U,
    DSA_NOTIFY_FLAG_ADDITIONAL_DATA       = 0x00000002U,
    DSA_NOTIFY_FLAG_FORCE_ADDITIONAL_DATA = 0x00000001U,
}

enum GUID CLSID_MicrosoftDS = GUID("fe1290f0-cfbd-11cf-a330-00aa00c16e65");
enum GUID CLSID_DsPropertyPages = GUID("0d45d530-764b-11d0-a1ca-00aa00c16e65");
enum GUID CLSID_DsDomainTreeBrowser = GUID("1698790a-e2b4-11d0-b0b1-00c04fd8dca6");
enum GUID CLSID_DsDisplaySpecifier = GUID("1ab4a8c0-6a0b-11d2-ad49-00c04fa31a86");
enum GUID CLSID_DsFolderProperties = GUID("9e51e0d0-6e0f-11d2-9601-00c04fa31a86");

enum : uint
{
    DSOBJECT_ISCONTAINER   = 0x00000001U,
    DSOBJECT_READONLYPAGES = 0x80000000U,
}

enum : uint
{
    DSPROVIDER_UNUSED_0 = 0x00000001U,
    DSPROVIDER_UNUSED_1 = 0x00000002U,
    DSPROVIDER_UNUSED_2 = 0x00000004U,
    DSPROVIDER_UNUSED_3 = 0x00000008U,
    DSPROVIDER_ADVANCED = 0x00000010U,
    DSPROVIDER_AD_LDS   = 0x00000020U,
}

enum : const(wchar)*
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-dsobjectnames
    CFSTR_DSOBJECTNAMES           = "DsObjectNames",
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-ds-display-spec-options
    CFSTR_DS_DISPLAY_SPEC_OPTIONS = "DsDisplaySpecOptions",
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-ds-display-spec-options
enum const(wchar)* CFSTR_DSDISPLAYSPECOPTIONS = "DsDisplaySpecOptions";
enum const(wchar)* DS_PROP_SHELL_PREFIX = "shell";
enum const(wchar)* DS_PROP_ADMIN_PREFIX = "admin";
enum uint DSDSOF_HASUSERANDSERVERINFO = 0x00000001U;
enum uint DSDSOF_SIMPLEAUTHENTICATE = 0x00000002U;

enum : uint
{
    DSDSOF_DONTSIGNSEAL = 0x00000004U,
    DSDSOF_DSAVAILABLE  = 0x40000000U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-dspropertypageinfo
enum const(wchar)* CFSTR_DSPROPERTYPAGEINFO = "DsPropPageInfo";
enum const(wchar)* DSPROP_ATTRCHANGED_MSG = "DsPropAttrChanged";

enum : uint
{
    DBDTF_RETURNFQDN         = 0x00000001U,
    DBDTF_RETURNMIXEDDOMAINS = 0x00000002U,
    DBDTF_RETURNEXTERNAL     = 0x00000004U,
    DBDTF_RETURNINBOUND      = 0x00000008U,
    DBDTF_RETURNINOUTBOUND   = 0x00000010U,
}

enum uint DSSSF_SIMPLEAUTHENTICATE = 0x00000001U;
enum uint DSSSF_DONTSIGNSEAL = 0x00000002U;
enum uint DSSSF_DSAVAILABLE = 0x80000000U;

enum : uint
{
    DSGIF_ISNORMAL       = 0x00000000U,
    DSGIF_ISOPEN         = 0x00000001U,
    DSGIF_ISDISABLED     = 0x00000002U,
    DSGIF_ISMASK         = 0x0000000fU,
    DSGIF_GETDEFAULTICON = 0x00000010U,
}

enum uint DSGIF_DEFAULTISCONTAINER = 0x00000020U;
enum uint DSICCF_IGNORETREATASLEAF = 0x00000001U;
enum uint DSECAF_NOTLISTED = 0x00000001U;

enum : uint
{
    DSCCIF_HASWIZARDDIALOG      = 0x00000001U,
    DSCCIF_HASWIZARDPRIMARYPAGE = 0x00000002U,
}

enum : uint
{
    DSBI_NOBUTTONS     = 0x00000001U,
    DSBI_NOLINES       = 0x00000002U,
    DSBI_NOLINESATROOT = 0x00000004U,
}

enum uint DSBI_CHECKBOXES = 0x00000100U;

enum : uint
{
    DSBI_NOROOT        = 0x00010000U,
    DSBI_INCLUDEHIDDEN = 0x00020000U,
}

enum uint DSBI_EXPANDONOPEN = 0x00040000U;
enum uint DSBI_ENTIREDIRECTORY = 0x00090000U;
enum uint DSBI_RETURN_FORMAT = 0x00100000U;
enum uint DSBI_HASCREDENTIALS = 0x00200000U;
enum uint DSBI_IGNORETREATASLEAF = 0x00400000U;
enum uint DSBI_SIMPLEAUTHENTICATE = 0x00800000U;
enum uint DSBI_RETURNOBJECTCLASS = 0x01000000U;
enum uint DSBI_DONTSIGNSEAL = 0x02000000U;
enum uint DSB_MAX_DISPLAYNAME_CHARS = 0x00000040U;

enum : uint
{
    DSBF_STATE        = 0x00000001U,
    DSBF_ICONLOCATION = 0x00000002U,
}

enum uint DSBF_DISPLAYNAME = 0x00000004U;

enum : uint
{
    DSBS_CHECKED = 0x00000001U,
    DSBS_HIDDEN  = 0x00000002U,
    DSBS_ROOT    = 0x00000004U,
}

enum : uint
{
    DSBM_QUERYINSERTW = 0x00000064U,
    DSBM_QUERYINSERTA = 0x00000065U,
    DSBM_QUERYINSERT  = 0x00000064U,
}

enum uint DSBM_CHANGEIMAGESTATE = 0x00000066U;

enum : uint
{
    DSBM_HELP        = 0x00000067U,
    DSBM_CONTEXTMENU = 0x00000068U,
}

enum : uint
{
    DSBID_BANNER        = 0x00000100U,
    DSBID_CONTAINERLIST = 0x00000101U,
}

enum uint DS_FORCE_REDISCOVERY = 0x00000001U;

enum : uint
{
    DS_DIRECTORY_SERVICE_REQUIRED  = 0x00000010U,
    DS_DIRECTORY_SERVICE_PREFERRED = 0x00000020U,
}

enum uint DS_GC_SERVER_REQUIRED = 0x00000040U;
enum uint DS_PDC_REQUIRED = 0x00000080U;
enum uint DS_BACKGROUND_ONLY = 0x00000100U;
enum uint DS_IP_REQUIRED = 0x00000200U;
enum uint DS_KDC_REQUIRED = 0x00000400U;
enum uint DS_TIMESERV_REQUIRED = 0x00000800U;
enum uint DS_WRITABLE_REQUIRED = 0x00001000U;
enum uint DS_GOOD_TIMESERV_PREFERRED = 0x00002000U;
enum uint DS_AVOID_SELF = 0x00004000U;
enum uint DS_ONLY_LDAP_NEEDED = 0x00008000U;
enum uint DS_IS_FLAT_NAME = 0x00010000U;
enum uint DS_IS_DNS_NAME = 0x00020000U;
enum uint DS_TRY_NEXTCLOSEST_SITE = 0x00040000U;
enum uint DS_DIRECTORY_SERVICE_6_REQUIRED = 0x00080000U;
enum uint DS_WEB_SERVICE_REQUIRED = 0x00100000U;

enum : uint
{
    DS_DIRECTORY_SERVICE_8_REQUIRED  = 0x00200000U,
    DS_DIRECTORY_SERVICE_9_REQUIRED  = 0x00400000U,
    DS_DIRECTORY_SERVICE_10_REQUIRED = 0x00800000U,
}

enum uint DS_KEY_LIST_SUPPORT_REQUIRED = 0x01000000U;
enum uint DS_DIRECTORY_SERVICE_13_REQUIRED = 0x02000000U;

enum : uint
{
    DS_RETURN_DNS_NAME  = 0x40000000U,
    DS_RETURN_FLAT_NAME = 0x80000000U,
}

enum uint DS_PDC_FLAG = 0x00000001U;
enum uint DS_GC_FLAG = 0x00000004U;
enum uint DS_LDAP_FLAG = 0x00000008U;
enum uint DS_DS_FLAG = 0x00000010U;
enum uint DS_KDC_FLAG = 0x00000020U;
enum uint DS_TIMESERV_FLAG = 0x00000040U;
enum uint DS_CLOSEST_FLAG = 0x00000080U;
enum uint DS_WRITABLE_FLAG = 0x00000100U;
enum uint DS_GOOD_TIMESERV_FLAG = 0x00000200U;
enum uint DS_NDNC_FLAG = 0x00000400U;
enum uint DS_SELECT_SECRET_DOMAIN_6_FLAG = 0x00000800U;
enum uint DS_FULL_SECRET_DOMAIN_6_FLAG = 0x00001000U;
enum uint DS_WS_FLAG = 0x00002000U;

enum : uint
{
    DS_DS_8_FLAG  = 0x00004000U,
    DS_DS_9_FLAG  = 0x00008000U,
    DS_DS_10_FLAG = 0x00010000U,
}

enum uint DS_KEY_LIST_FLAG = 0x00020000U;
enum uint DS_DS_13_FLAG = 0x00040000U;
enum uint DS_PING_FLAGS = 0x000fffffU;
enum uint DS_DNS_CONTROLLER_FLAG = 0x20000000U;
enum uint DS_DNS_DOMAIN_FLAG = 0x40000000U;
enum uint DS_DNS_FOREST_FLAG = 0x80000000U;

enum : uint
{
    DS_DOMAIN_IN_FOREST       = 0x00000001U,
    DS_DOMAIN_DIRECT_OUTBOUND = 0x00000002U,
}

enum : uint
{
    DS_DOMAIN_TREE_ROOT      = 0x00000004U,
    DS_DOMAIN_PRIMARY        = 0x00000008U,
    DS_DOMAIN_NATIVE_MODE    = 0x00000010U,
    DS_DOMAIN_DIRECT_INBOUND = 0x00000020U,
}

enum : uint
{
    DS_GFTI_UPDATE_TDO  = 0x00000001U,
    DS_GFTI_VALID_FLAGS = 0x00000001U,
}

enum uint DS_ONLY_DO_SITE_NAME = 0x00000001U;
enum uint DS_NOTIFY_AFTER_SITE_RECORDS = 0x00000002U;

enum : GUID
{
    CLSID_DsQuery                         = GUID("8a23e65e-31c2-11d0-891c-00a024ab2dbb"),
    CLSID_DsFindObjects                   = GUID("83ee3fe1-57d9-11d0-b932-00a024ab2dbb"),
    CLSID_DsFindPeople                    = GUID("83ee3fe2-57d9-11d0-b932-00a024ab2dbb"),
    CLSID_DsFindPrinter                   = GUID("b577f070-7ee2-11d0-913f-00aa00c16e65"),
    CLSID_DsFindComputer                  = GUID("16006700-87ad-11d0-9140-00aa00c16e65"),
    CLSID_DsFindVolume                    = GUID("c1b3cbf1-886a-11d0-9140-00aa00c16e65"),
    CLSID_DsFindContainer                 = GUID("c1b3cbf2-886a-11d0-9140-00aa00c16e65"),
    CLSID_DsFindAdvanced                  = GUID("83ee3fe3-57d9-11d0-b932-00a024ab2dbb"),
    CLSID_DsFindDomainController          = GUID("538c7b7e-d25e-11d0-9742-00a0c906af45"),
    CLSID_DsFindWriteableDomainController = GUID("7cbef079-aa84-444b-bc70-68e41283eabc"),
}

enum GUID CLSID_DsFindFrsMembers = GUID("94ce4b18-b3d3-11d1-b9b4-00c04fd8d5b0");

enum : uint
{
    DSQPF_NOSAVE       = 0x00000001U,
    DSQPF_SAVELOCATION = 0x00000002U,
}

enum uint DSQPF_SHOWHIDDENOBJECTS = 0x00000004U;

enum : uint
{
    DSQPF_ENABLEADMINFEATURES    = 0x00000008U,
    DSQPF_ENABLEADVANCEDFEATURES = 0x00000010U,
}

enum uint DSQPF_HASCREDENTIALS = 0x00000020U;
enum uint DSQPF_NOCHOOSECOLUMNS = 0x00000040U;

enum : const(wchar)*
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-dsqueryparams
    CFSTR_DSQUERYPARAMS = "DsQueryParameters",
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-dsqueryscope
    CFSTR_DSQUERYSCOPE  = "DsQueryScope",
}

enum uint DSQPM_GETCLASSLIST = 0x10000000U;
enum uint DSQPM_HELPTOPICS = 0x10000001U;

enum : uint
{
    DSROLE_PRIMARY_DS_RUNNING    = 0x00000001U,
    DSROLE_PRIMARY_DS_MIXED_MODE = 0x00000002U,
}

enum uint DSROLE_UPGRADE_IN_PROGRESS = 0x00000004U;

enum : uint
{
    DSROLE_PRIMARY_DS_READONLY         = 0x00000008U,
    DSROLE_PRIMARY_DOMAIN_GUID_PRESENT = 0x01000000U,
}

enum : uint
{
    ADS_ATTR_CLEAR  = 0x00000001U,
    ADS_ATTR_UPDATE = 0x00000002U,
    ADS_ATTR_APPEND = 0x00000003U,
    ADS_ATTR_DELETE = 0x00000004U,
}

enum : uint
{
    ADS_EXT_MINEXTDISPID = 0x00000001U,
    ADS_EXT_MAXEXTDISPID = 0x00ffffffU,
}

enum : uint
{
    ADS_EXT_INITCREDENTIALS     = 0x00000001U,
    ADS_EXT_INITIALIZE_COMPLETE = 0x00000002U,
}

enum : uint
{
    DS_BEHAVIOR_WIN2000                    = 0x00000000U,
    DS_BEHAVIOR_WIN2003_WITH_MIXED_DOMAINS = 0x00000001U,
    DS_BEHAVIOR_WIN2003                    = 0x00000002U,
    DS_BEHAVIOR_WIN2008                    = 0x00000003U,
    DS_BEHAVIOR_WIN2008R2                  = 0x00000004U,
    DS_BEHAVIOR_WIN2012                    = 0x00000005U,
    DS_BEHAVIOR_WIN2012R2                  = 0x00000006U,
    DS_BEHAVIOR_WIN2016                    = 0x00000007U,
    DS_BEHAVIOR_WIN2025                    = 0x0000000aU,
    DS_BEHAVIOR_LONGHORN                   = 0x00000003U,
    DS_BEHAVIOR_WIN7                       = 0x00000004U,
    DS_BEHAVIOR_WIN8                       = 0x00000005U,
    DS_BEHAVIOR_WINBLUE                    = 0x00000006U,
    DS_BEHAVIOR_WINTHRESHOLD               = 0x00000007U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    DS_SYNCED_EVENT_NAME   = "NTDSInitialSyncsCompleted",
    DS_SYNCED_EVENT_NAME_W = "NTDSInitialSyncsCompleted",
}

enum : uint
{
    ACTRL_DS_OPEN           = 0x00000000U,
    ACTRL_DS_CREATE_CHILD   = 0x00000001U,
    ACTRL_DS_DELETE_CHILD   = 0x00000002U,
    ACTRL_DS_LIST           = 0x00000004U,
    ACTRL_DS_SELF           = 0x00000008U,
    ACTRL_DS_READ_PROP      = 0x00000010U,
    ACTRL_DS_WRITE_PROP     = 0x00000020U,
    ACTRL_DS_DELETE_TREE    = 0x00000040U,
    ACTRL_DS_LIST_OBJECT    = 0x00000080U,
    ACTRL_DS_CONTROL_ACCESS = 0x00000100U,
}

enum : uint
{
    NTDSAPI_BIND_ALLOW_DELEGATION = 0x00000001U,
    NTDSAPI_BIND_FIND_BINDING     = 0x00000002U,
    NTDSAPI_BIND_FORCE_KERBEROS   = 0x00000004U,
}

enum uint DS_REPSYNC_ASYNCHRONOUS_OPERATION = 0x00000001U;

enum : uint
{
    DS_REPSYNC_WRITEABLE           = 0x00000002U,
    DS_REPSYNC_PERIODIC            = 0x00000004U,
    DS_REPSYNC_INTERSITE_MESSAGING = 0x00000008U,
}

enum : uint
{
    DS_REPSYNC_FULL                = 0x00000020U,
    DS_REPSYNC_URGENT              = 0x00000040U,
    DS_REPSYNC_NO_DISCARD          = 0x00000080U,
    DS_REPSYNC_FORCE               = 0x00000100U,
    DS_REPSYNC_ADD_REFERENCE       = 0x00000200U,
    DS_REPSYNC_NEVER_COMPLETED     = 0x00000400U,
    DS_REPSYNC_TWO_WAY             = 0x00000800U,
    DS_REPSYNC_NEVER_NOTIFY        = 0x00001000U,
    DS_REPSYNC_INITIAL             = 0x00002000U,
    DS_REPSYNC_USE_COMPRESSION     = 0x00004000U,
    DS_REPSYNC_ABANDONED           = 0x00008000U,
    DS_REPSYNC_SELECT_SECRETS      = 0x00008000U,
    DS_REPSYNC_INITIAL_IN_PROGRESS = 0x00010000U,
}

enum uint DS_REPSYNC_PARTIAL_ATTRIBUTE_SET = 0x00020000U;

enum : uint
{
    DS_REPSYNC_REQUEUE              = 0x00040000U,
    DS_REPSYNC_NOTIFICATION         = 0x00080000U,
    DS_REPSYNC_ASYNCHRONOUS_REPLICA = 0x00100000U,
}

enum : uint
{
    DS_REPSYNC_CRITICAL         = 0x00200000U,
    DS_REPSYNC_FULL_IN_PROGRESS = 0x00400000U,
    DS_REPSYNC_PREEMPTED        = 0x00800000U,
    DS_REPSYNC_NONGC_RO_REPLICA = 0x01000000U,
}

enum uint DS_REPADD_ASYNCHRONOUS_OPERATION = 0x00000001U;

enum : uint
{
    DS_REPADD_WRITEABLE           = 0x00000002U,
    DS_REPADD_INITIAL             = 0x00000004U,
    DS_REPADD_PERIODIC            = 0x00000008U,
    DS_REPADD_INTERSITE_MESSAGING = 0x00000010U,
}

enum uint DS_REPADD_ASYNCHRONOUS_REPLICA = 0x00000020U;

enum : uint
{
    DS_REPADD_DISABLE_NOTIFICATION = 0x00000040U,
    DS_REPADD_DISABLE_PERIODIC     = 0x00000080U,
}

enum uint DS_REPADD_USE_COMPRESSION = 0x00000100U;

enum : uint
{
    DS_REPADD_NEVER_NOTIFY     = 0x00000200U,
    DS_REPADD_TWO_WAY          = 0x00000400U,
    DS_REPADD_CRITICAL         = 0x00000800U,
    DS_REPADD_SELECT_SECRETS   = 0x00001000U,
    DS_REPADD_NONGC_RO_REPLICA = 0x01000000U,
}

enum uint DS_REPDEL_ASYNCHRONOUS_OPERATION = 0x00000001U;

enum : uint
{
    DS_REPDEL_WRITEABLE           = 0x00000002U,
    DS_REPDEL_INTERSITE_MESSAGING = 0x00000004U,
}

enum : uint
{
    DS_REPDEL_IGNORE_ERRORS = 0x00000008U,
    DS_REPDEL_LOCAL_ONLY    = 0x00000010U,
    DS_REPDEL_NO_SOURCE     = 0x00000020U,
    DS_REPDEL_REF_OK        = 0x00000040U,
}

enum uint DS_REPMOD_ASYNCHRONOUS_OPERATION = 0x00000001U;

enum : uint
{
    DS_REPMOD_WRITEABLE        = 0x00000002U,
    DS_REPMOD_UPDATE_FLAGS     = 0x00000001U,
    DS_REPMOD_UPDATE_INSTANCE  = 0x00000002U,
    DS_REPMOD_UPDATE_ADDRESS   = 0x00000002U,
    DS_REPMOD_UPDATE_SCHEDULE  = 0x00000004U,
    DS_REPMOD_UPDATE_RESULT    = 0x00000008U,
    DS_REPMOD_UPDATE_TRANSPORT = 0x00000010U,
}

enum uint DS_REPUPD_ASYNCHRONOUS_OPERATION = 0x00000001U;

enum : uint
{
    DS_REPUPD_WRITEABLE        = 0x00000002U,
    DS_REPUPD_ADD_REFERENCE    = 0x00000004U,
    DS_REPUPD_DELETE_REFERENCE = 0x00000008U,
}

enum uint DS_REPUPD_REFERENCE_GCSPN = 0x00000010U;

enum : uint
{
    DS_INSTANCETYPE_IS_NC_HEAD      = 0x00000001U,
    DS_INSTANCETYPE_NC_IS_WRITEABLE = 0x00000004U,
    DS_INSTANCETYPE_NC_COMING       = 0x00000010U,
    DS_INSTANCETYPE_NC_GOING        = 0x00000020U,
}

enum : uint
{
    NTDSDSA_OPT_IS_GC                    = 0x00000001U,
    NTDSDSA_OPT_DISABLE_INBOUND_REPL     = 0x00000002U,
    NTDSDSA_OPT_DISABLE_OUTBOUND_REPL    = 0x00000004U,
    NTDSDSA_OPT_DISABLE_NTDSCONN_XLATE   = 0x00000008U,
    NTDSDSA_OPT_DISABLE_SPN_REGISTRATION = 0x00000010U,
}

enum : uint
{
    NTDSDSA_OPT_GENERATE_OWN_TOPO = 0x00000020U,
    NTDSDSA_OPT_BLOCK_RPC         = 0x00000040U,
}

enum : uint
{
    NTDSCONN_OPT_IS_GENERATED            = 0x00000001U,
    NTDSCONN_OPT_TWOWAY_SYNC             = 0x00000002U,
    NTDSCONN_OPT_OVERRIDE_NOTIFY_DEFAULT = 0x00000004U,
}

enum : uint
{
    NTDSCONN_OPT_USE_NOTIFY                    = 0x00000008U,
    NTDSCONN_OPT_DISABLE_INTERSITE_COMPRESSION = 0x00000010U,
}

enum : uint
{
    NTDSCONN_OPT_USER_OWNED_SCHEDULE = 0x00000020U,
    NTDSCONN_OPT_RODC_TOPOLOGY       = 0x00000040U,
}

enum : uint
{
    NTDSCONN_KCC_NO_REASON              = 0x00000000U,
    NTDSCONN_KCC_GC_TOPOLOGY            = 0x00000001U,
    NTDSCONN_KCC_RING_TOPOLOGY          = 0x00000002U,
    NTDSCONN_KCC_MINIMIZE_HOPS_TOPOLOGY = 0x00000004U,
}

enum uint NTDSCONN_KCC_STALE_SERVERS_TOPOLOGY = 0x00000008U;
enum uint NTDSCONN_KCC_OSCILLATING_CONNECTION_TOPOLOGY = 0x00000010U;

enum : uint
{
    NTDSCONN_KCC_INTERSITE_GC_TOPOLOGY    = 0x00000020U,
    NTDSCONN_KCC_INTERSITE_TOPOLOGY       = 0x00000040U,
    NTDSCONN_KCC_SERVER_FAILOVER_TOPOLOGY = 0x00000080U,
}

enum uint NTDSCONN_KCC_SITE_FAILOVER_TOPOLOGY = 0x00000100U;
enum uint NTDSCONN_KCC_REDUNDANT_SERVER_TOPOLOGY = 0x00000200U;
enum uint FRSCONN_PRIORITY_MASK = 0x70000000U;
enum uint FRSCONN_MAX_PRIORITY = 0x00000008U;
enum uint NTDSCONN_OPT_IGNORE_SCHEDULE_MASK = 0x80000000U;

enum : uint
{
    NTDSSETTINGS_OPT_IS_AUTO_TOPOLOGY_DISABLED            = 0x00000001U,
    NTDSSETTINGS_OPT_IS_TOPL_CLEANUP_DISABLED             = 0x00000002U,
    NTDSSETTINGS_OPT_IS_TOPL_MIN_HOPS_DISABLED            = 0x00000004U,
    NTDSSETTINGS_OPT_IS_TOPL_DETECT_STALE_DISABLED        = 0x00000008U,
    NTDSSETTINGS_OPT_IS_INTER_SITE_AUTO_TOPOLOGY_DISABLED = 0x00000010U,
}

enum : uint
{
    NTDSSETTINGS_OPT_IS_GROUP_CACHING_ENABLED             = 0x00000020U,
    NTDSSETTINGS_OPT_FORCE_KCC_WHISTLER_BEHAVIOR          = 0x00000040U,
    NTDSSETTINGS_OPT_FORCE_KCC_W2K_ELECTION               = 0x00000080U,
    NTDSSETTINGS_OPT_IS_RAND_BH_SELECTION_DISABLED        = 0x00000100U,
    NTDSSETTINGS_OPT_IS_SCHEDULE_HASHING_ENABLED          = 0x00000200U,
    NTDSSETTINGS_OPT_IS_REDUNDANT_SERVER_TOPOLOGY_ENABLED = 0x00000400U,
}

enum : uint
{
    NTDSSETTINGS_OPT_W2K3_IGNORE_SCHEDULES = 0x00000800U,
    NTDSSETTINGS_OPT_W2K3_BRIDGES_REQUIRED = 0x00001000U,
}

enum uint NTDSSETTINGS_DEFAULT_SERVER_REDUNDANCY = 0x00000002U;

enum : uint
{
    NTDSTRANSPORT_OPT_IGNORE_SCHEDULES = 0x00000001U,
    NTDSTRANSPORT_OPT_BRIDGES_REQUIRED = 0x00000002U,
}

enum : uint
{
    NTDSSITECONN_OPT_USE_NOTIFY          = 0x00000001U,
    NTDSSITECONN_OPT_TWOWAY_SYNC         = 0x00000002U,
    NTDSSITECONN_OPT_DISABLE_COMPRESSION = 0x00000004U,
}

enum : uint
{
    NTDSSITELINK_OPT_USE_NOTIFY          = 0x00000001U,
    NTDSSITELINK_OPT_TWOWAY_SYNC         = 0x00000002U,
    NTDSSITELINK_OPT_DISABLE_COMPRESSION = 0x00000004U,
}

// Native encoding: ansi
enum const(wchar)* GUID_USERS_CONTAINER_A = "a9d1ca15768811d1aded00c04fd8d5cd";
// Native encoding: ansi
enum const(wchar)* GUID_COMPUTRS_CONTAINER_A = "aa312825768811d1aded00c04fd8d5cd";
// Native encoding: ansi
enum const(wchar)* GUID_SYSTEMS_CONTAINER_A = "ab1d30f3768811d1aded00c04fd8d5cd";
// Native encoding: ansi
enum const(wchar)* GUID_DOMAIN_CONTROLLERS_CONTAINER_A = "a361b2ffffd211d1aa4b00c04fd7d83a";
// Native encoding: ansi
enum const(wchar)* GUID_INFRASTRUCTURE_CONTAINER_A = "2fbac1870ade11d297c400c04fd8d5cd";
// Native encoding: ansi
enum const(wchar)* GUID_DELETED_OBJECTS_CONTAINER_A = "18e2ea80684f11d2b9aa00c04f79f805";
// Native encoding: ansi
enum const(wchar)* GUID_LOSTANDFOUND_CONTAINER_A = "ab8153b7768811d1aded00c04fd8d5cd";
// Native encoding: ansi
enum const(wchar)* GUID_FOREIGNSECURITYPRINCIPALS_CONTAINER_A = "22b70c67d56e4efb91e9300fca3dc1aa";
// Native encoding: ansi
enum const(wchar)* GUID_PROGRAM_DATA_CONTAINER_A = "09460c08ae1e4a4ea0f64aee7daa1e5a";
// Native encoding: ansi
enum const(wchar)* GUID_MICROSOFT_PROGRAM_DATA_CONTAINER_A = "f4be92a4c777485e878e9421d53087db";
// Native encoding: ansi
enum const(wchar)* GUID_NTDS_QUOTAS_CONTAINER_A = "6227f0af1fc2410d8e3bb10615bb5b0f";
enum const(wchar)* GUID_USERS_CONTAINER_W = "a9d1ca15768811d1aded00c04fd8d5cd";
enum const(wchar)* GUID_COMPUTRS_CONTAINER_W = "aa312825768811d1aded00c04fd8d5cd";
enum const(wchar)* GUID_SYSTEMS_CONTAINER_W = "ab1d30f3768811d1aded00c04fd8d5cd";
enum const(wchar)* GUID_DOMAIN_CONTROLLERS_CONTAINER_W = "a361b2ffffd211d1aa4b00c04fd7d83a";
enum const(wchar)* GUID_INFRASTRUCTURE_CONTAINER_W = "2fbac1870ade11d297c400c04fd8d5cd";
enum const(wchar)* GUID_DELETED_OBJECTS_CONTAINER_W = "18e2ea80684f11d2b9aa00c04f79f805";
enum const(wchar)* GUID_LOSTANDFOUND_CONTAINER_W = "ab8153b7768811d1aded00c04fd8d5cd";
enum const(wchar)* GUID_FOREIGNSECURITYPRINCIPALS_CONTAINER_W = "22b70c67d56e4efb91e9300fca3dc1aa";
enum const(wchar)* GUID_PROGRAM_DATA_CONTAINER_W = "09460c08ae1e4a4ea0f64aee7daa1e5a";
enum const(wchar)* GUID_MICROSOFT_PROGRAM_DATA_CONTAINER_W = "f4be92a4c777485e878e9421d53087db";
enum const(wchar)* GUID_NTDS_QUOTAS_CONTAINER_W = "6227f0af1fc2410d8e3bb10615bb5b0f";
enum const(wchar)* GUID_MANAGED_SERVICE_ACCOUNTS_CONTAINER_W = "1EB93889E40C45DF9F0C64D23BBB6237";
enum const(wchar)* GUID_KEYS_CONTAINER_W = "683A24E2E8164BD3AF86AC3C2CF3F981";

enum : uint
{
    DS_REPSYNCALL_NO_OPTIONS                  = 0x00000000U,
    DS_REPSYNCALL_ABORT_IF_SERVER_UNAVAILABLE = 0x00000001U,
}

enum uint DS_REPSYNCALL_SYNC_ADJACENT_SERVERS_ONLY = 0x00000002U;

enum : uint
{
    DS_REPSYNCALL_ID_SERVERS_BY_DN      = 0x00000004U,
    DS_REPSYNCALL_DO_NOT_SYNC           = 0x00000008U,
    DS_REPSYNCALL_SKIP_INITIAL_CHECK    = 0x00000010U,
    DS_REPSYNCALL_PUSH_CHANGES_OUTWARD  = 0x00000020U,
    DS_REPSYNCALL_CROSS_SITE_BOUNDARIES = 0x00000040U,
}

enum uint DS_LIST_DSA_OBJECT_FOR_SERVER = 0x00000000U;
enum uint DS_LIST_DNS_HOST_NAME_FOR_SERVER = 0x00000001U;
enum uint DS_LIST_ACCOUNT_OBJECT_FOR_SERVER = 0x00000002U;
enum uint DS_ROLE_SCHEMA_OWNER = 0x00000000U;
enum uint DS_ROLE_DOMAIN_OWNER = 0x00000001U;

enum : uint
{
    DS_ROLE_PDC_OWNER            = 0x00000002U,
    DS_ROLE_RID_OWNER            = 0x00000003U,
    DS_ROLE_INFRASTRUCTURE_OWNER = 0x00000004U,
}

enum : uint
{
    DS_SCHEMA_GUID_NOT_FOUND     = 0x00000000U,
    DS_SCHEMA_GUID_ATTR          = 0x00000001U,
    DS_SCHEMA_GUID_ATTR_SET      = 0x00000002U,
    DS_SCHEMA_GUID_CLASS         = 0x00000003U,
    DS_SCHEMA_GUID_CONTROL_RIGHT = 0x00000004U,
}

enum : uint
{
    DS_KCC_FLAG_ASYNC_OP = 0x00000001U,
    DS_KCC_FLAG_DAMPED   = 0x00000002U,
}

enum uint DS_EXIST_ADVISORY_MODE = 0x00000001U;
enum uint DS_REPL_INFO_FLAG_IMPROVE_LINKED_ATTRS = 0x00000001U;

enum : uint
{
    DS_REPL_NBR_WRITEABLE          = 0x00000010U,
    DS_REPL_NBR_SYNC_ON_STARTUP    = 0x00000020U,
    DS_REPL_NBR_DO_SCHEDULED_SYNCS = 0x00000040U,
}

enum uint DS_REPL_NBR_USE_ASYNC_INTERSITE_TRANSPORT = 0x00000080U;

enum : uint
{
    DS_REPL_NBR_TWO_WAY_SYNC          = 0x00000200U,
    DS_REPL_NBR_NONGC_RO_REPLICA      = 0x00000400U,
    DS_REPL_NBR_RETURN_OBJECT_PARENTS = 0x00000800U,
}

enum : uint
{
    DS_REPL_NBR_SELECT_SECRETS        = 0x00001000U,
    DS_REPL_NBR_FULL_SYNC_IN_PROGRESS = 0x00010000U,
    DS_REPL_NBR_FULL_SYNC_NEXT_PACKET = 0x00020000U,
}

enum : uint
{
    DS_REPL_NBR_GCSPN                       = 0x00100000U,
    DS_REPL_NBR_NEVER_SYNCED                = 0x00200000U,
    DS_REPL_NBR_PREEMPTED                   = 0x01000000U,
    DS_REPL_NBR_IGNORE_CHANGE_NOTIFICATIONS = 0x04000000U,
}

enum uint DS_REPL_NBR_DISABLE_SCHEDULED_SYNC = 0x08000000U;

enum : uint
{
    DS_REPL_NBR_COMPRESS_CHANGES        = 0x10000000U,
    DS_REPL_NBR_NO_CHANGE_NOTIFICATIONS = 0x20000000U,
}

enum uint DS_REPL_NBR_PARTIAL_ATTRIBUTE_SET = 0x40000000U;

enum : const(wchar)*
{
    // Native encoding: ansi
    ADAM_SCP_SITE_NAME_STRING   = "site:",
    ADAM_SCP_SITE_NAME_STRING_W = "site:",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ADAM_SCP_PARTITION_STRING   = "partition:",
    ADAM_SCP_PARTITION_STRING_W = "partition:",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ADAM_SCP_INSTANCE_NAME_STRING   = "instance:",
    ADAM_SCP_INSTANCE_NAME_STRING_W = "instance:",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    ADAM_SCP_FSMO_STRING          = "fsmo:",
    ADAM_SCP_FSMO_STRING_W        = "fsmo:",
    // Native encoding: ansi
    ADAM_SCP_FSMO_NAMING_STRING   = "naming",
    ADAM_SCP_FSMO_NAMING_STRING_W = "naming",
    // Native encoding: ansi
    ADAM_SCP_FSMO_SCHEMA_STRING   = "schema",
    ADAM_SCP_FSMO_SCHEMA_STRING_W = "schema",
}

enum : uint
{
    ADAM_REPL_AUTHENTICATION_MODE_NEGOTIATE_PASS_THROUGH = 0x00000000U,
    ADAM_REPL_AUTHENTICATION_MODE_NEGOTIATE              = 0x00000001U,
    ADAM_REPL_AUTHENTICATION_MODE_MUTUAL_AUTH_REQUIRED   = 0x00000002U,
}

enum uint FLAG_FOREST_OPTIONAL_FEATURE = 0x00000001U;
enum uint FLAG_DOMAIN_OPTIONAL_FEATURE = 0x00000002U;
enum uint FLAG_DISABLABLE_OPTIONAL_FEATURE = 0x00000004U;
enum uint FLAG_SERVER_OPTIONAL_FEATURE = 0x00000008U;

enum : const(wchar)*
{
    // Native encoding: ansi
    GUID_RECYCLE_BIN_OPTIONAL_FEATURE_A = "d8dc6d76d0ac5e44f3b9a7f9b6744f2a",
    GUID_RECYCLE_BIN_OPTIONAL_FEATURE_W = "d8dc6d76d0ac5e44f3b9a7f9b6744f2a",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    GUID_PRIVILEGED_ACCESS_MANAGEMENT_OPTIONAL_FEATURE_A = "73e843ece8cc4046b4ab07ffe4ab5bcd",
    GUID_PRIVILEGED_ACCESS_MANAGEMENT_OPTIONAL_FEATURE_W = "73e843ece8cc4046b4ab07ffe4ab5bcd",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    GUID_DATABASE_32K_PAGES_OPTIONAL_FEATURE_A    = "c62a9852731e4f75ae2473ae2775aab8",
    GUID_DATABASE_32K_PAGES_OPTIONAL_FEATURE_W    = "c62a9852731e4f75ae2473ae2775aab8",
    // Native encoding: ansi
    GUID_DATABASE_32K_PAGES_OPTIONAL_FEATURE_BYTE = "Æ*RsOu®$s®'uª¸",
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/AD/cfstr-dsop-ds-selection-list
enum const(wchar)* CFSTR_DSOP_DS_SELECTION_LIST = "CFSTR_DSOP_DS_SELECTION_LIST";

enum : uint
{
    DSOP_SCOPE_TYPE_TARGET_COMPUTER           = 0x00000001U,
    DSOP_SCOPE_TYPE_UPLEVEL_JOINED_DOMAIN     = 0x00000002U,
    DSOP_SCOPE_TYPE_DOWNLEVEL_JOINED_DOMAIN   = 0x00000004U,
    DSOP_SCOPE_TYPE_ENTERPRISE_DOMAIN         = 0x00000008U,
    DSOP_SCOPE_TYPE_GLOBAL_CATALOG            = 0x00000010U,
    DSOP_SCOPE_TYPE_EXTERNAL_UPLEVEL_DOMAIN   = 0x00000020U,
    DSOP_SCOPE_TYPE_EXTERNAL_DOWNLEVEL_DOMAIN = 0x00000040U,
}

enum : uint
{
    DSOP_SCOPE_TYPE_WORKGROUP                    = 0x00000080U,
    DSOP_SCOPE_TYPE_USER_ENTERED_UPLEVEL_SCOPE   = 0x00000100U,
    DSOP_SCOPE_TYPE_USER_ENTERED_DOWNLEVEL_SCOPE = 0x00000200U,
}

enum : uint
{
    DSOP_SCOPE_FLAG_STARTING_SCOPE              = 0x00000001U,
    DSOP_SCOPE_FLAG_WANT_PROVIDER_WINNT         = 0x00000002U,
    DSOP_SCOPE_FLAG_WANT_PROVIDER_LDAP          = 0x00000004U,
    DSOP_SCOPE_FLAG_WANT_PROVIDER_GC            = 0x00000008U,
    DSOP_SCOPE_FLAG_WANT_SID_PATH               = 0x00000010U,
    DSOP_SCOPE_FLAG_WANT_DOWNLEVEL_BUILTIN_PATH = 0x00000020U,
}

enum : uint
{
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_USERS                    = 0x00000040U,
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_GROUPS                   = 0x00000080U,
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_COMPUTERS                = 0x00000100U,
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_CONTACTS                 = 0x00000200U,
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_SERVICE_ACCOUNTS         = 0x00000400U,
    DSOP_SCOPE_FLAG_DEFAULT_FILTER_PASSWORDSETTINGS_OBJECTS = 0x00000800U,
}

enum uint DSOP_FILTER_INCLUDE_ADVANCED_VIEW = 0x00000001U;

enum : uint
{
    DSOP_FILTER_USERS                 = 0x00000002U,
    DSOP_FILTER_BUILTIN_GROUPS        = 0x00000004U,
    DSOP_FILTER_WELL_KNOWN_PRINCIPALS = 0x00000008U,
}

enum : uint
{
    DSOP_FILTER_UNIVERSAL_GROUPS_DL = 0x00000010U,
    DSOP_FILTER_UNIVERSAL_GROUPS_SE = 0x00000020U,
}

enum : uint
{
    DSOP_FILTER_GLOBAL_GROUPS_DL       = 0x00000040U,
    DSOP_FILTER_GLOBAL_GROUPS_SE       = 0x00000080U,
    DSOP_FILTER_DOMAIN_LOCAL_GROUPS_DL = 0x00000100U,
    DSOP_FILTER_DOMAIN_LOCAL_GROUPS_SE = 0x00000200U,
}

enum : uint
{
    DSOP_FILTER_CONTACTS                 = 0x00000400U,
    DSOP_FILTER_COMPUTERS                = 0x00000800U,
    DSOP_FILTER_SERVICE_ACCOUNTS         = 0x00001000U,
    DSOP_FILTER_PASSWORDSETTINGS_OBJECTS = 0x00002000U,
}

enum : uint
{
    DSOP_DOWNLEVEL_FILTER_USERS                  = 0x80000001U,
    DSOP_DOWNLEVEL_FILTER_LOCAL_GROUPS           = 0x80000002U,
    DSOP_DOWNLEVEL_FILTER_GLOBAL_GROUPS          = 0x80000004U,
    DSOP_DOWNLEVEL_FILTER_COMPUTERS              = 0x80000008U,
    DSOP_DOWNLEVEL_FILTER_WORLD                  = 0x80000010U,
    DSOP_DOWNLEVEL_FILTER_AUTHENTICATED_USER     = 0x80000020U,
    DSOP_DOWNLEVEL_FILTER_ANONYMOUS              = 0x80000040U,
    DSOP_DOWNLEVEL_FILTER_BATCH                  = 0x80000080U,
    DSOP_DOWNLEVEL_FILTER_CREATOR_OWNER          = 0x80000100U,
    DSOP_DOWNLEVEL_FILTER_CREATOR_GROUP          = 0x80000200U,
    DSOP_DOWNLEVEL_FILTER_DIALUP                 = 0x80000400U,
    DSOP_DOWNLEVEL_FILTER_INTERACTIVE            = 0x80000800U,
    DSOP_DOWNLEVEL_FILTER_NETWORK                = 0x80001000U,
    DSOP_DOWNLEVEL_FILTER_SERVICE                = 0x80002000U,
    DSOP_DOWNLEVEL_FILTER_SYSTEM                 = 0x80004000U,
    DSOP_DOWNLEVEL_FILTER_EXCLUDE_BUILTIN_GROUPS = 0x80008000U,
    DSOP_DOWNLEVEL_FILTER_TERMINAL_SERVER        = 0x80010000U,
    DSOP_DOWNLEVEL_FILTER_ALL_WELLKNOWN_SIDS     = 0x80020000U,
    DSOP_DOWNLEVEL_FILTER_LOCAL_SERVICE          = 0x80040000U,
    DSOP_DOWNLEVEL_FILTER_NETWORK_SERVICE        = 0x80080000U,
    DSOP_DOWNLEVEL_FILTER_REMOTE_LOGON           = 0x80100000U,
    DSOP_DOWNLEVEL_FILTER_INTERNET_USER          = 0x80200000U,
    DSOP_DOWNLEVEL_FILTER_OWNER_RIGHTS           = 0x80400000U,
    DSOP_DOWNLEVEL_FILTER_SERVICES               = 0x80800000U,
    DSOP_DOWNLEVEL_FILTER_LOCAL_LOGON            = 0x81000000U,
    DSOP_DOWNLEVEL_FILTER_THIS_ORG_CERT          = 0x82000000U,
    DSOP_DOWNLEVEL_FILTER_IIS_APP_POOL           = 0x84000000U,
    DSOP_DOWNLEVEL_FILTER_ALL_APP_PACKAGES       = 0x88000000U,
    DSOP_DOWNLEVEL_FILTER_LOCAL_ACCOUNTS         = 0x90000000U,
}

enum : uint
{
    DSOP_FLAG_MULTISELECT                   = 0x00000001U,
    DSOP_FLAG_SKIP_TARGET_COMPUTER_DC_CHECK = 0x00000002U,
}

enum : uint
{
    SCHEDULE_INTERVAL  = 0x00000000U,
    SCHEDULE_BANDWIDTH = 0x00000001U,
    SCHEDULE_PRIORITY  = 0x00000002U,
}

enum : uint
{
    FACILITY_NTDSB  = 0x00000800U,
    FACILITY_BACKUP = 0x000007ffU,
    FACILITY_SYSTEM = 0x00000000U,
}

enum : HRESULT
{
    hrNone = HRESULT(0x00000000),
    hrNyi  = HRESULT(0xc0000001),
}

enum HRESULT hrInvalidParam = HRESULT(0xc7ff0001);
enum HRESULT hrError = HRESULT(0xc7ff0002);
enum HRESULT hrInvalidHandle = HRESULT(0xc7ff0003);
enum HRESULT hrRestoreInProgress = HRESULT(0xc7ff0004);
enum HRESULT hrAlreadyOpen = HRESULT(0xc7ff0005);
enum HRESULT hrInvalidRecips = HRESULT(0xc7ff0006);
enum HRESULT hrCouldNotConnect = HRESULT(0xc7ff0007);
enum HRESULT hrRestoreMapExists = HRESULT(0xc7ff0008);
enum HRESULT hrIncrementalBackupDisabled = HRESULT(0xc7ff0009);
enum HRESULT hrLogFileNotFound = HRESULT(0xc7ff000a);
enum HRESULT hrCircularLogging = HRESULT(0xc7ff000b);
enum HRESULT hrNoFullRestore = HRESULT(0xc7ff000c);
enum HRESULT hrCommunicationError = HRESULT(0xc7ff000d);
enum HRESULT hrFullBackupNotTaken = HRESULT(0xc7ff000e);
enum HRESULT hrMissingExpiryToken = HRESULT(0xc7ff000f);
enum HRESULT hrUnknownExpiryTokenFormat = HRESULT(0xc7ff0010);
enum HRESULT hrContentsExpired = HRESULT(0xc7ff0011);
enum HRESULT hrFileClose = HRESULT(0xc8000066);
enum HRESULT hrOutOfThreads = HRESULT(0xc8000067);
enum HRESULT hrTooManyIO = HRESULT(0xc8000069);
enum HRESULT hrBFNotSynchronous = HRESULT(0x880000c8);
enum HRESULT hrBFPageNotFound = HRESULT(0x880000c9);
enum HRESULT hrBFInUse = HRESULT(0xc80000ca);
enum HRESULT hrPMRecDeleted = HRESULT(0xc800012e);
enum HRESULT hrRemainingVersions = HRESULT(0x88000141);
enum HRESULT hrFLDKeyTooBig = HRESULT(0x88000190);
enum HRESULT hrFLDTooManySegments = HRESULT(0xc8000191);
enum HRESULT hrFLDNullKey = HRESULT(0x88000192);
enum HRESULT hrLogFileCorrupt = HRESULT(0xc80001f5);
enum HRESULT hrNoBackupDirectory = HRESULT(0xc80001f7);
enum HRESULT hrBackupDirectoryNotEmpty = HRESULT(0xc80001f8);
enum HRESULT hrBackupInProgress = HRESULT(0xc80001f9);
enum HRESULT hrMissingPreviousLogFile = HRESULT(0xc80001fd);
enum HRESULT hrLogWriteFail = HRESULT(0xc80001fe);
enum HRESULT hrBadLogVersion = HRESULT(0xc8000202);
enum HRESULT hrInvalidLogSequence = HRESULT(0xc8000203);
enum HRESULT hrLoggingDisabled = HRESULT(0xc8000204);
enum HRESULT hrLogBufferTooSmall = HRESULT(0xc8000205);
enum HRESULT hrLogSequenceEnd = HRESULT(0xc8000207);
enum HRESULT hrNoBackup = HRESULT(0xc8000208);
enum HRESULT hrInvalidBackupSequence = HRESULT(0xc8000209);
enum HRESULT hrBackupNotAllowedYet = HRESULT(0xc800020b);
enum HRESULT hrDeleteBackupFileFail = HRESULT(0xc800020c);
enum HRESULT hrMakeBackupDirectoryFail = HRESULT(0xc800020d);
enum HRESULT hrInvalidBackup = HRESULT(0xc800020e);
enum HRESULT hrRecoveredWithErrors = HRESULT(0xc800020f);
enum HRESULT hrMissingLogFile = HRESULT(0xc8000210);
enum HRESULT hrLogDiskFull = HRESULT(0xc8000211);
enum HRESULT hrBadLogSignature = HRESULT(0xc8000212);
enum HRESULT hrBadDbSignature = HRESULT(0xc8000213);
enum HRESULT hrBadCheckpointSignature = HRESULT(0xc8000214);
enum HRESULT hrCheckpointCorrupt = HRESULT(0xc8000215);
enum HRESULT hrDatabaseInconsistent = HRESULT(0xc8000226);
enum HRESULT hrConsistentTimeMismatch = HRESULT(0xc8000227);
enum HRESULT hrPatchFileMismatch = HRESULT(0xc8000228);

enum : HRESULT
{
    hrRestoreLogTooLow  = HRESULT(0xc8000229),
    hrRestoreLogTooHigh = HRESULT(0xc800022a),
}

enum : HRESULT
{
    hrGivenLogFileHasBadSignature = HRESULT(0xc800022b),
    hrGivenLogFileIsNotContiguous = HRESULT(0xc800022c),
}

enum HRESULT hrMissingRestoreLogFiles = HRESULT(0xc800022d);

enum : HRESULT
{
    hrExistingLogFileHasBadSignature = HRESULT(0x8800022e),
    hrExistingLogFileIsNotContiguous = HRESULT(0x8800022f),
}

enum HRESULT hrMissingFullBackup = HRESULT(0xc8000230);
enum HRESULT hrBadBackupDatabaseSize = HRESULT(0xc8000231);
enum HRESULT hrTermInProgress = HRESULT(0xc80003e8);
enum HRESULT hrFeatureNotAvailable = HRESULT(0xc80003e9);

enum : HRESULT
{
    hrInvalidName      = HRESULT(0xc80003ea),
    hrInvalidParameter = HRESULT(0xc80003eb),
}

enum HRESULT hrColumnNull = HRESULT(0x880003ec);
enum HRESULT hrBufferTruncated = HRESULT(0x880003ee);
enum HRESULT hrDatabaseAttached = HRESULT(0x880003ef);
enum HRESULT hrInvalidDatabaseId = HRESULT(0xc80003f2);

enum : HRESULT
{
    hrOutOfMemory        = HRESULT(0xc80003f3),
    hrOutOfDatabaseSpace = HRESULT(0xc80003f4),
}

enum : HRESULT
{
    hrOutOfCursors = HRESULT(0xc80003f5),
    hrOutOfBuffers = HRESULT(0xc80003f6),
}

enum : HRESULT
{
    hrTooManyIndexes = HRESULT(0xc80003f7),
    hrTooManyKeys    = HRESULT(0xc80003f8),
}

enum HRESULT hrRecordDeleted = HRESULT(0xc80003f9);
enum HRESULT hrReadVerifyFailure = HRESULT(0xc80003fa);
enum HRESULT hrOutOfFileHandles = HRESULT(0xc80003fc);
enum HRESULT hrDiskIO = HRESULT(0xc80003fe);
enum HRESULT hrInvalidPath = HRESULT(0xc80003ff);
enum HRESULT hrRecordTooBig = HRESULT(0xc8000402);
enum HRESULT hrTooManyOpenDatabases = HRESULT(0xc8000403);
enum HRESULT hrInvalidDatabase = HRESULT(0xc8000404);
enum HRESULT hrNotInitialized = HRESULT(0xc8000405);
enum HRESULT hrAlreadyInitialized = HRESULT(0xc8000406);
enum HRESULT hrFileAccessDenied = HRESULT(0xc8000408);
enum HRESULT hrBufferTooSmall = HRESULT(0xc800040e);
enum HRESULT hrSeekNotEqual = HRESULT(0x8800040f);
enum HRESULT hrTooManyColumns = HRESULT(0xc8000410);
enum HRESULT hrContainerNotEmpty = HRESULT(0xc8000413);

enum : HRESULT
{
    hrInvalidFilename = HRESULT(0xc8000414),
    hrInvalidBookmark = HRESULT(0xc8000415),
}

enum HRESULT hrColumnInUse = HRESULT(0xc8000416);
enum HRESULT hrInvalidBufferSize = HRESULT(0xc8000417);
enum HRESULT hrColumnNotUpdatable = HRESULT(0xc8000418);
enum HRESULT hrIndexInUse = HRESULT(0xc800041b);
enum HRESULT hrNullKeyDisallowed = HRESULT(0xc800041d);
enum HRESULT hrNotInTransaction = HRESULT(0xc800041e);
enum HRESULT hrNoIdleActivity = HRESULT(0x88000422);
enum HRESULT hrTooManyActiveUsers = HRESULT(0xc8000423);

enum : HRESULT
{
    hrInvalidCountry    = HRESULT(0xc8000425),
    hrInvalidLanguageId = HRESULT(0xc8000426),
    hrInvalidCodePage   = HRESULT(0xc8000427),
}

enum HRESULT hrNoWriteLock = HRESULT(0x8800042b);
enum HRESULT hrColumnSetNull = HRESULT(0x8800042c);
enum HRESULT hrVersionStoreOutOfMemory = HRESULT(0xc800042d);
enum HRESULT hrCurrencyStackOutOfMemory = HRESULT(0xc800042e);
enum HRESULT hrOutOfSessions = HRESULT(0xc800044d);
enum HRESULT hrWriteConflict = HRESULT(0xc800044e);
enum HRESULT hrTransTooDeep = HRESULT(0xc800044f);
enum HRESULT hrInvalidSesid = HRESULT(0xc8000450);
enum HRESULT hrSessionWriteConflict = HRESULT(0xc8000453);
enum HRESULT hrInTransaction = HRESULT(0xc8000454);

enum : HRESULT
{
    hrDatabaseDuplicate    = HRESULT(0xc80004b1),
    hrDatabaseInUse        = HRESULT(0xc80004b2),
    hrDatabaseNotFound     = HRESULT(0xc80004b3),
    hrDatabaseInvalidName  = HRESULT(0xc80004b4),
    hrDatabaseInvalidPages = HRESULT(0xc80004b5),
    hrDatabaseCorrupted    = HRESULT(0xc80004b6),
    hrDatabaseLocked       = HRESULT(0xc80004b7),
}

enum : HRESULT
{
    hrTableEmpty     = HRESULT(0x88000515),
    hrTableLocked    = HRESULT(0xc8000516),
    hrTableDuplicate = HRESULT(0xc8000517),
    hrTableInUse     = HRESULT(0xc8000518),
}

enum HRESULT hrObjectNotFound = HRESULT(0xc8000519);
enum HRESULT hrCannotRename = HRESULT(0xc800051a);
enum HRESULT hrDensityInvalid = HRESULT(0xc800051b);
enum HRESULT hrTableNotEmpty = HRESULT(0xc800051c);
enum HRESULT hrInvalidTableId = HRESULT(0xc800051e);
enum HRESULT hrTooManyOpenTables = HRESULT(0xc800051f);
enum HRESULT hrIllegalOperation = HRESULT(0xc8000520);
enum HRESULT hrObjectDuplicate = HRESULT(0xc8000522);
enum HRESULT hrInvalidObject = HRESULT(0xc8000524);

enum : HRESULT
{
    hrIndexCantBuild    = HRESULT(0xc8000579),
    hrIndexHasPrimary   = HRESULT(0xc800057a),
    hrIndexDuplicate    = HRESULT(0xc800057b),
    hrIndexNotFound     = HRESULT(0xc800057c),
    hrIndexMustStay     = HRESULT(0xc800057d),
    hrIndexInvalidDef   = HRESULT(0xc800057e),
    hrIndexHasClustered = HRESULT(0xc8000580),
}

enum HRESULT hrCreateIndexFailed = HRESULT(0x88000581);
enum HRESULT hrTooManyOpenIndexes = HRESULT(0xc8000582);

enum : HRESULT
{
    hrColumnLong       = HRESULT(0xc80005dd),
    hrColumnDoesNotFit = HRESULT(0xc80005df),
}

enum HRESULT hrNullInvalid = HRESULT(0xc80005e0);

enum : HRESULT
{
    hrColumnIndexed     = HRESULT(0xc80005e1),
    hrColumnTooBig      = HRESULT(0xc80005e2),
    hrColumnNotFound    = HRESULT(0xc80005e3),
    hrColumnDuplicate   = HRESULT(0xc80005e4),
    hrColumn2ndSysMaint = HRESULT(0xc80005e6),
}

enum HRESULT hrInvalidColumnType = HRESULT(0xc80005e7);
enum HRESULT hrColumnMaxTruncated = HRESULT(0x880005e8);
enum HRESULT hrColumnCannotIndex = HRESULT(0xc80005e9);
enum HRESULT hrTaggedNotNULL = HRESULT(0xc80005ea);
enum HRESULT hrNoCurrentIndex = HRESULT(0xc80005eb);
enum HRESULT hrKeyIsMade = HRESULT(0xc80005ec);
enum HRESULT hrBadColumnId = HRESULT(0xc80005ed);
enum HRESULT hrBadItagSequence = HRESULT(0xc80005ee);
enum HRESULT hrCannotBeTagged = HRESULT(0xc80005f1);
enum HRESULT hrRecordNotFound = HRESULT(0xc8000641);
enum HRESULT hrNoCurrentRecord = HRESULT(0xc8000643);
enum HRESULT hrRecordClusteredChanged = HRESULT(0xc8000644);
enum HRESULT hrKeyDuplicate = HRESULT(0xc8000645);
enum HRESULT hrAlreadyPrepared = HRESULT(0xc8000647);
enum HRESULT hrKeyNotMade = HRESULT(0xc8000648);
enum HRESULT hrUpdateNotPrepared = HRESULT(0xc8000649);
enum HRESULT hrwrnDataHasChanged = HRESULT(0x8800064a);
enum HRESULT hrerrDataHasChanged = HRESULT(0xc800064b);
enum HRESULT hrKeyChanged = HRESULT(0x88000652);
enum HRESULT hrTooManySorts = HRESULT(0xc80006a5);
enum HRESULT hrInvalidOnSort = HRESULT(0xc80006a6);
enum HRESULT hrTempFileOpenError = HRESULT(0xc800070b);
enum HRESULT hrTooManyAttachedDatabases = HRESULT(0xc800070d);
enum HRESULT hrDiskFull = HRESULT(0xc8000710);
enum HRESULT hrPermissionDenied = HRESULT(0xc8000711);

enum : HRESULT
{
    hrFileNotFound     = HRESULT(0xc8000713),
    hrFileOpenReadOnly = HRESULT(0x88000715),
}

enum HRESULT hrAfterInitialization = HRESULT(0xc800073a);
enum HRESULT hrLogCorrupted = HRESULT(0xc800073c);
enum HRESULT hrInvalidOperation = HRESULT(0xc8000772);
enum HRESULT hrAccessDenied = HRESULT(0xc8000773);
enum GUID CLSID_DsObjectPicker = GUID("17d6ccd8-3b7b-11d2-b9e0-00c04fd8dbf7");

// Callbacks

alias LPCQADDFORMSPROC = HRESULT function(LPARAM lParam, CQFORM* pForm);
alias LPCQADDPAGESPROC = HRESULT function(LPARAM lParam, const(GUID)* clsidForm, CQPAGE* pPage);
alias LPCQPAGEPROC = HRESULT function(CQPAGE* pPage, HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
alias LPDSENUMATTRIBUTES = HRESULT function(LPARAM lParam, const(PWSTR) pszAttributeName, 
                                            const(PWSTR) pszDisplayName, uint dwFlags);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/ns-cmnquery-cqform
struct CQFORM
{
    uint         cbStruct;
    uint         dwFlags;
    GUID         clsid;
    HICON        hIcon;
    const(PWSTR) pszTitle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/ns-cmnquery-cqpage
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/ns-cmnquery-openquerywindow
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_octet_string
struct ADS_OCTET_STRING
{
    uint   dwLength;
    ubyte* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_nt_security_descriptor
struct ADS_NT_SECURITY_DESCRIPTOR
{
    uint   dwLength;
    ubyte* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_prov_specific
struct ADS_PROV_SPECIFIC
{
    uint   dwLength;
    ubyte* lpValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_caseignore_list
struct ADS_CASEIGNORE_LIST
{
    ADS_CASEIGNORE_LIST* Next;
    PWSTR                String;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_octet_list
struct ADS_OCTET_LIST
{
    ADS_OCTET_LIST* Next;
    uint            Length;
    ubyte*          Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_path
struct ADS_PATH
{
    uint  Type;
    PWSTR VolumeName;
    PWSTR Path;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_postaladdress
struct ADS_POSTALADDRESS
{
    PWSTR[6] PostalAddress;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_timestamp
struct ADS_TIMESTAMP
{
    uint WholeSeconds;
    uint EventID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_backlink
struct ADS_BACKLINK
{
    uint  RemoteID;
    PWSTR ObjectName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_typedname
struct ADS_TYPEDNAME
{
    PWSTR ObjectName;
    uint  Level;
    uint  Interval;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_hold
struct ADS_HOLD
{
    PWSTR ObjectName;
    uint  Amount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_netaddress
struct ADS_NETADDRESS
{
    uint   AddressType;
    uint   AddressLength;
    ubyte* Address;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_replicapointer
struct ADS_REPLICAPOINTER
{
    PWSTR           ServerName;
    uint            ReplicaType;
    uint            ReplicaNumber;
    uint            Count;
    ADS_NETADDRESS* ReplicaAddressHints;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_faxnumber
struct ADS_FAXNUMBER
{
    PWSTR  TelephoneNumber;
    uint   NumberOfBits;
    ubyte* Parameters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_email
struct ADS_EMAIL
{
    PWSTR Address;
    uint  Type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_dn_with_binary
struct ADS_DN_WITH_BINARY
{
    uint   dwLength;
    ubyte* lpBinaryValue;
    PWSTR  pszDNString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_dn_with_string
struct ADS_DN_WITH_STRING
{
    PWSTR pszStringValue;
    PWSTR pszDNString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-adsvalue
struct ADSVALUE
{
    ADSTYPE dwType;
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
        long                 LargeInteger;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_attr_info
struct ADS_ATTR_INFO
{
    PWSTR     pszAttrName;
    uint      dwControlCode;
    ADSTYPE   dwADsType;
    ADSVALUE* pADsValues;
    uint      dwNumValues;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_object_info
struct ADS_OBJECT_INFO
{
    PWSTR pszRDN;
    PWSTR pszObjectDN;
    PWSTR pszParentDN;
    PWSTR pszSchemaDN;
    PWSTR pszClassName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_searchpref_info
struct ADS_SEARCHPREF_INFO
{
    ADS_SEARCHPREF_ENUM dwSearchPref;
    ADSVALUE            vValue;
    ADS_STATUSENUM      dwStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_search_column
struct ADS_SEARCH_COLUMN
{
    PWSTR     pszAttrName;
    ADSTYPE   dwADsType;
    ADSVALUE* pADsValues;
    uint      dwNumValues;
    HANDLE    hReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_attr_def
struct ADS_ATTR_DEF
{
    PWSTR   pszAttrName;
    ADSTYPE dwADsType;
    uint    dwMinRange;
    uint    dwMaxRange;
    BOOL    fMultiValued;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_class_def
struct ADS_CLASS_DEF
{
    PWSTR   pszClassName;
    uint    dwMandatoryAttrs;
    PWSTR*  ppszMandatoryAttrs;
    uint    optionalAttrs;
    PWSTR** ppszOptionalAttrs;
    uint    dwNamingAttrs;
    PWSTR** ppszNamingAttrs;
    uint    dwSuperClasses;
    PWSTR** ppszSuperClasses;
    BOOL    fIsContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_sortkey
struct ADS_SORTKEY
{
    PWSTR   pszAttrType;
    PWSTR   pszReserved;
    BOOLEAN fReverseorder;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/ns-iads-ads_vlv
struct ADS_VLV
{
    uint   dwBeforeCount;
    uint   dwAfterCount;
    uint   dwOffset;
    uint   dwContentCount;
    PWSTR  pszTarget;
    uint   dwContextIDLength;
    ubyte* lpContextID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsobject
struct DSOBJECT
{
    uint dwFlags;
    uint dwProviderFlags;
    uint offsetName;
    uint offsetClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsobjectnames
struct DSOBJECTNAMES
{
    GUID        clsidNamespace;
    uint        cItems;
    DSOBJECT[1] aObjects; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsdisplayspecoptions
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dspropertypageinfo
struct DSPROPERTYPAGEINFO
{
    uint offsetString;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-domaindesc
struct DOMAINDESC
{
    PWSTR       pszName;
    PWSTR       pszPath;
    PWSTR       pszNCName;
    PWSTR       pszTrustParent;
    PWSTR       pszObjectClass;
    uint        ulFlags;
    BOOL        fDownLevel;
    DOMAINDESC* pdChildList;
    DOMAINDESC* pdNextSibling;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-domain_tree
struct DOMAIN_TREE
{
    uint          dsSize;
    uint          dwCount;
    DOMAINDESC[1] aDomains; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsclasscreationinfo
struct DSCLASSCREATIONINFO
{
    uint    dwFlags;
    GUID    clsidWizardDialog;
    GUID    clsidWizardPrimaryPage;
    uint    cWizardExtensions;
    GUID[1] aWizardExtensions; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsbrowseinfow
struct DSBROWSEINFOW
{
    uint         cbStruct;
    HWND         hwndOwner;
    const(PWSTR) pszCaption;
    const(PWSTR) pszTitle;
    const(PWSTR) pszRoot;
    PWSTR        pszPath;
    uint         cchPath;
    uint         dwFlags;
    BFFCALLBACK  pfnCallback;
    LPARAM       lParam;
    uint         dwReturnFormat;
    const(PWSTR) pUserName;
    const(PWSTR) pPassword;
    PWSTR        pszObjectClass;
    uint         cchObjectClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsbrowseinfoa
struct DSBROWSEINFOA
{
    uint         cbStruct;
    HWND         hwndOwner;
    const(PSTR)  pszCaption;
    const(PSTR)  pszTitle;
    const(PWSTR) pszRoot;
    PWSTR        pszPath;
    uint         cchPath;
    uint         dwFlags;
    BFFCALLBACK  pfnCallback;
    LPARAM       lParam;
    uint         dwReturnFormat;
    const(PWSTR) pUserName;
    const(PWSTR) pPassword;
    PWSTR        pszObjectClass;
    uint         cchObjectClass;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsbitemw
struct DSBITEMW
{
    uint         cbStruct;
    const(PWSTR) pszADsPath;
    const(PWSTR) pszClass;
    uint         dwMask;
    uint         dwState;
    uint         dwStateMask;
    wchar[64]    szDisplayName;
    wchar[260]   szIconLocation;
    int          iIconResID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/ns-dsclient-dsbitema
struct DSBITEMA
{
    uint         cbStruct;
    const(PWSTR) pszADsPath;
    const(PWSTR) pszClass;
    uint         dwMask;
    uint         dwState;
    uint         dwStateMask;
    CHAR[64]     szDisplayName;
    CHAR[260]    szIconLocation;
    int          iIconResID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-dsop_uplevel_filter_flags
struct DSOP_UPLEVEL_FILTER_FLAGS
{
    uint flBothModes;
    uint flMixedModeOnly;
    uint flNativeModeOnly;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-dsop_filter_flags
struct DSOP_FILTER_FLAGS
{
    DSOP_UPLEVEL_FILTER_FLAGS Uplevel;
    uint flDownlevel;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-dsop_scope_init_info
struct DSOP_SCOPE_INIT_INFO
{
    uint              cbSize;
    uint              flType;
    uint              flScope;
    DSOP_FILTER_FLAGS FilterFlags;
    const(PWSTR)      pwzDcName;
    const(PWSTR)      pwzADsPath;
    HRESULT           hr;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-dsop_init_info
struct DSOP_INIT_INFO
{
    uint          cbSize;
    const(PWSTR)  pwzTargetComputer;
    uint          cDsScopeInfos;
    DSOP_SCOPE_INIT_INFO* aDsScopeInfos;
    uint          flOptions;
    uint          cAttributesToFetch;
    const(PWSTR)* apwzAttributeNames;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-ds_selection
struct DS_SELECTION
{
    PWSTR    pwzName;
    PWSTR    pwzADsPath;
    PWSTR    pwzClass;
    PWSTR    pwzUPN;
    VARIANT* pvarFetchedAttributes;
    uint     flScopeType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/ns-objsel-ds_selection_list
struct DS_SELECTION_LIST
{
    uint            cItems;
    uint            cFetchedAttributes;
    DS_SELECTION[1] aDsSelection; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsquery/ns-dsquery-dsqueryinitparams
struct DSQUERYINITPARAMS
{
    uint  cbStruct;
    uint  dwFlags;
    PWSTR pDefaultScope;
    PWSTR pDefaultSaveLocation;
    PWSTR pUserName;
    PWSTR pPassword;
    PWSTR pServer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsquery/ns-dsquery-dscolumn
struct DSCOLUMN
{
    uint dwFlags;
    int  fmt;
    int  cx;
    int  idsName;
    int  offsetProperty;
    uint dwReserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsquery/ns-dsquery-dsqueryparams
struct DSQUERYPARAMS
{
    uint        cbStruct;
    uint        dwFlags;
    HINSTANCE   hInstance;
    int         offsetQuery;
    int         iColumns;
    uint        dwReserved;
    DSCOLUMN[1] aColumns; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsquery/ns-dsquery-dsqueryclasslist
struct DSQUERYCLASSLIST
{
    uint    cbStruct;
    int     cClasses;
    uint[1] offsetClass; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/ns-dsadmin-dsa_newobj_dispinfo
struct DSA_NEWOBJ_DISPINFO
{
    uint  dwSize;
    HICON hObjClassIcon;
    PWSTR lpszWizTitle;
    PWSTR lpszContDisplayName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/adsprop/ns-adsprop-adspropinitparams
struct ADSPROPINITPARAMS
{
    uint             dwSize;
    uint             dwFlags;
    HRESULT          hr;
    IDirectoryObject pDsObj;
    PWSTR            pwzCN;
    ADS_ATTR_INFO*   pWritableAttrs;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/adsprop/ns-adsprop-adsproperror
struct ADSPROPERROR
{
    HWND    hwndPage;
    PWSTR   pszPageTitle;
    PWSTR   pszObjPath;
    PWSTR   pszObjClass;
    HRESULT hr;
    PWSTR   pszError;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schedule/ns-schedule-schedule_header
struct SCHEDULE_HEADER
{
    uint Type;
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schedule/ns-schedule-schedule
struct SCHEDULE
{
    uint               Size;
    uint               Bandwidth;
    uint               NumberOfSchedules;
    SCHEDULE_HEADER[1] Schedules; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_name_result_itema
struct DS_NAME_RESULT_ITEMA
{
    uint status;
    PSTR pDomain;
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_name_resulta
struct DS_NAME_RESULTA
{
    uint cItems;
    DS_NAME_RESULT_ITEMA* rItems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_name_result_itemw
struct DS_NAME_RESULT_ITEMW
{
    uint  status;
    PWSTR pDomain;
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_name_resultw
struct DS_NAME_RESULTW
{
    uint cItems;
    DS_NAME_RESULT_ITEMW* rItems;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_synca
struct DS_REPSYNCALL_SYNCA
{
    PSTR  pszSrcId;
    PSTR  pszDstId;
    PSTR  pszNC;
    GUID* pguidSrc;
    GUID* pguidDst;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_syncw
struct DS_REPSYNCALL_SYNCW
{
    PWSTR pszSrcId;
    PWSTR pszDstId;
    PWSTR pszNC;
    GUID* pguidSrc;
    GUID* pguidDst;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_errinfoa
struct DS_REPSYNCALL_ERRINFOA
{
    PSTR                pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint                dwWin32Err;
    PSTR                pszSrcId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_errinfow
struct DS_REPSYNCALL_ERRINFOW
{
    PWSTR               pszSvrId;
    DS_REPSYNCALL_ERROR error;
    uint                dwWin32Err;
    PWSTR               pszSrcId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_updatea
struct DS_REPSYNCALL_UPDATEA
{
    DS_REPSYNCALL_EVENT  event;
    DS_REPSYNCALL_ERRINFOA* pErrInfo;
    DS_REPSYNCALL_SYNCA* pSync;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repsyncall_updatew
struct DS_REPSYNCALL_UPDATEW
{
    DS_REPSYNCALL_EVENT  event;
    DS_REPSYNCALL_ERRINFOW* pErrInfo;
    DS_REPSYNCALL_SYNCW* pSync;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_site_cost_info
struct DS_SITE_COST_INFO
{
    uint errorCode;
    uint cost;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_schema_guid_mapa
struct DS_SCHEMA_GUID_MAPA
{
    GUID guid;
    uint guidType;
    PSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_schema_guid_mapw
struct DS_SCHEMA_GUID_MAPW
{
    GUID  guid;
    uint  guidType;
    PWSTR pName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_1a
struct DS_DOMAIN_CONTROLLER_INFO_1A
{
    PSTR NetbiosName;
    PSTR DnsHostName;
    PSTR SiteName;
    PSTR ComputerObjectName;
    PSTR ServerObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_1w
struct DS_DOMAIN_CONTROLLER_INFO_1W
{
    PWSTR NetbiosName;
    PWSTR DnsHostName;
    PWSTR SiteName;
    PWSTR ComputerObjectName;
    PWSTR ServerObjectName;
    BOOL  fIsPdc;
    BOOL  fDsEnabled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_2a
struct DS_DOMAIN_CONTROLLER_INFO_2A
{
    PSTR NetbiosName;
    PSTR DnsHostName;
    PSTR SiteName;
    PSTR SiteObjectName;
    PSTR ComputerObjectName;
    PSTR ServerObjectName;
    PSTR NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    GUID SiteObjectGuid;
    GUID ComputerObjectGuid;
    GUID ServerObjectGuid;
    GUID NtdsDsaObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_2w
struct DS_DOMAIN_CONTROLLER_INFO_2W
{
    PWSTR NetbiosName;
    PWSTR DnsHostName;
    PWSTR SiteName;
    PWSTR SiteObjectName;
    PWSTR ComputerObjectName;
    PWSTR ServerObjectName;
    PWSTR NtdsDsaObjectName;
    BOOL  fIsPdc;
    BOOL  fDsEnabled;
    BOOL  fIsGc;
    GUID  SiteObjectGuid;
    GUID  ComputerObjectGuid;
    GUID  ServerObjectGuid;
    GUID  NtdsDsaObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_3a
struct DS_DOMAIN_CONTROLLER_INFO_3A
{
    PSTR NetbiosName;
    PSTR DnsHostName;
    PSTR SiteName;
    PSTR SiteObjectName;
    PSTR ComputerObjectName;
    PSTR ServerObjectName;
    PSTR NtdsDsaObjectName;
    BOOL fIsPdc;
    BOOL fDsEnabled;
    BOOL fIsGc;
    BOOL fIsRodc;
    GUID SiteObjectGuid;
    GUID ComputerObjectGuid;
    GUID ServerObjectGuid;
    GUID NtdsDsaObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_domain_controller_info_3w
struct DS_DOMAIN_CONTROLLER_INFO_3W
{
    PWSTR NetbiosName;
    PWSTR DnsHostName;
    PWSTR SiteName;
    PWSTR SiteObjectName;
    PWSTR ComputerObjectName;
    PWSTR ServerObjectName;
    PWSTR NtdsDsaObjectName;
    BOOL  fIsPdc;
    BOOL  fDsEnabled;
    BOOL  fIsGc;
    BOOL  fIsRodc;
    GUID  SiteObjectGuid;
    GUID  ComputerObjectGuid;
    GUID  ServerObjectGuid;
    GUID  NtdsDsaObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_neighborw
struct DS_REPL_NEIGHBORW
{
    PWSTR    pszNamingContext;
    PWSTR    pszSourceDsaDN;
    PWSTR    pszSourceDsaAddress;
    PWSTR    pszAsyncIntersiteTransportDN;
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_neighborw_blob
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_neighborsw
struct DS_REPL_NEIGHBORSW
{
    uint                 cNumNeighbors;
    uint                 dwReserved;
    DS_REPL_NEIGHBORW[1] rgNeighbor; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursor
struct DS_REPL_CURSOR
{
    GUID uuidSourceDsaInvocationID;
    long usnAttributeFilter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursor_2
struct DS_REPL_CURSOR_2
{
    GUID     uuidSourceDsaInvocationID;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursor_3w
struct DS_REPL_CURSOR_3W
{
    GUID     uuidSourceDsaInvocationID;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    PWSTR    pszSourceDsaDN;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursor_blob
struct DS_REPL_CURSOR_BLOB
{
    GUID     uuidSourceDsaInvocationID;
    long     usnAttributeFilter;
    FILETIME ftimeLastSyncSuccess;
    uint     oszSourceDsaDN;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursors
struct DS_REPL_CURSORS
{
    uint              cNumCursors;
    uint              dwReserved;
    DS_REPL_CURSOR[1] rgCursor; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursors_2
struct DS_REPL_CURSORS_2
{
    uint                cNumCursors;
    uint                dwEnumerationContext;
    DS_REPL_CURSOR_2[1] rgCursor; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_cursors_3w
struct DS_REPL_CURSORS_3W
{
    uint                 cNumCursors;
    uint                 dwEnumerationContext;
    DS_REPL_CURSOR_3W[1] rgCursor; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_meta_data
struct DS_REPL_ATTR_META_DATA
{
    PWSTR    pszAttributeName;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_meta_data_2
struct DS_REPL_ATTR_META_DATA_2
{
    PWSTR    pszAttributeName;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    PWSTR    pszLastOriginatingDsaDN;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_meta_data_blob
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_obj_meta_data
struct DS_REPL_OBJ_META_DATA
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA[1] rgMetaData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_obj_meta_data_2
struct DS_REPL_OBJ_META_DATA_2
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_ATTR_META_DATA_2[1] rgMetaData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_kcc_dsa_failurew
struct DS_REPL_KCC_DSA_FAILUREW
{
    PWSTR    pszDsaDN;
    GUID     uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    uint     cNumFailures;
    uint     dwLastResult;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_kcc_dsa_failurew_blob
struct DS_REPL_KCC_DSA_FAILUREW_BLOB
{
    uint     oszDsaDN;
    GUID     uuidDsaObjGuid;
    FILETIME ftimeFirstFailure;
    uint     cNumFailures;
    uint     dwLastResult;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_kcc_dsa_failuresw
struct DS_REPL_KCC_DSA_FAILURESW
{
    uint cNumEntries;
    uint dwReserved;
    DS_REPL_KCC_DSA_FAILUREW[1] rgDsaFailure; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_opw
struct DS_REPL_OPW
{
    FILETIME        ftimeEnqueued;
    uint            ulSerialNumber;
    uint            ulPriority;
    DS_REPL_OP_TYPE OpType;
    uint            ulOptions;
    PWSTR           pszNamingContext;
    PWSTR           pszDsaDN;
    PWSTR           pszDsaAddress;
    GUID            uuidNamingContextObjGuid;
    GUID            uuidDsaObjGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_opw_blob
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_pending_opsw
struct DS_REPL_PENDING_OPSW
{
    FILETIME       ftimeCurrentOpStarted;
    uint           cNumPendingOps;
    DS_REPL_OPW[1] rgPendingOp; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_value_meta_data
struct DS_REPL_VALUE_META_DATA
{
    PWSTR    pszAttributeName;
    PWSTR    pszObjectDn;
    uint     cbData;
    ubyte*   pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_value_meta_data_2
struct DS_REPL_VALUE_META_DATA_2
{
    PWSTR    pszAttributeName;
    PWSTR    pszObjectDn;
    uint     cbData;
    ubyte*   pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    PWSTR    pszLastOriginatingDsaDN;
}

struct DS_REPL_VALUE_META_DATA_EXT
{
    PWSTR    pszAttributeName;
    PWSTR    pszObjectDn;
    uint     cbData;
    ubyte*   pbData;
    FILETIME ftimeDeleted;
    FILETIME ftimeCreated;
    uint     dwVersion;
    FILETIME ftimeLastOriginatingChange;
    GUID     uuidLastOriginatingDsaInvocationID;
    long     usnOriginatingChange;
    long     usnLocalChange;
    PWSTR    pszLastOriginatingDsaDN;
    uint     dwUserIdentifier;
    uint     dwPriorLinkState;
    uint     dwCurrentLinkState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_value_meta_data_blob
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_value_meta_data
struct DS_REPL_ATTR_VALUE_META_DATA
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA[1] rgMetaData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_value_meta_data_2
struct DS_REPL_ATTR_VALUE_META_DATA_2
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_2[1] rgMetaData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_attr_value_meta_data_ext
struct DS_REPL_ATTR_VALUE_META_DATA_EXT
{
    uint cNumEntries;
    uint dwEnumerationContext;
    DS_REPL_VALUE_META_DATA_EXT[1] rgMetaData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntdsapi/ns-ntdsapi-ds_repl_queue_statisticsw
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ns-dsrole-dsrole_primary_domain_info_basic
struct DSROLE_PRIMARY_DOMAIN_INFO_BASIC
{
    DSROLE_MACHINE_ROLE MachineRole;
    uint                Flags;
    PWSTR               DomainNameFlat;
    PWSTR               DomainNameDns;
    PWSTR               DomainForestName;
    GUID                DomainGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ns-dsrole-dsrole_upgrade_status_info
struct DSROLE_UPGRADE_STATUS_INFO
{
    uint                OperationState;
    DSROLE_SERVER_STATE PreviousServerState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsrole/ns-dsrole-dsrole_operation_state_info
struct DSROLE_OPERATION_STATE_INFO
{
    DSROLE_OPERATION_STATE OperationState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsgetdc/ns-dsgetdc-domain_controller_infoa
struct DOMAIN_CONTROLLER_INFOA
{
    PSTR DomainControllerName;
    PSTR DomainControllerAddress;
    uint DomainControllerAddressType;
    GUID DomainGuid;
    PSTR DomainName;
    PSTR DnsForestName;
    uint Flags;
    PSTR DcSiteName;
    PSTR ClientSiteName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsgetdc/ns-dsgetdc-domain_controller_infow
struct DOMAIN_CONTROLLER_INFOW
{
    PWSTR DomainControllerName;
    PWSTR DomainControllerAddress;
    uint  DomainControllerAddressType;
    GUID  DomainGuid;
    PWSTR DomainName;
    PWSTR DnsForestName;
    uint  Flags;
    PWSTR DcSiteName;
    PWSTR ClientSiteName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsgetdc/ns-dsgetdc-ds_domain_trustsw
struct DS_DOMAIN_TRUSTSW
{
    PWSTR NetbiosDomainName;
    PWSTR DnsDomainName;
    uint  Flags;
    uint  ParentIndex;
    uint  TrustType;
    uint  TrustAttributes;
    PSID  DomainSid;
    GUID  DomainGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsgetdc/ns-dsgetdc-ds_domain_trustsa
struct DS_DOMAIN_TRUSTSA
{
    PSTR NetbiosDomainName;
    PSTR DnsDomainName;
    uint Flags;
    uint ParentIndex;
    uint TrustType;
    uint TrustAttributes;
    PSID DomainSid;
    GUID DomainGuid;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct ADS_SEARCH_HANDLE
{
    ptrdiff_t Value;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsGetObject(const(PWSTR) lpszPathName, const(GUID)* riid, void** ppObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildEnumerator(IADsContainer pADsContainer, IEnumVARIANT* ppEnumVariant);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsFreeEnumerator(IEnumVARIANT pEnumVariant);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsEnumerateNext(IEnumVARIANT pEnumVariant, uint cElements, VARIANT* pvar, uint* pcElementsFetched);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildVarArrayStr(PWSTR* lppPathNames, uint dwPathNames, VARIANT* pVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsBuildVarArrayInt(uint* lpdwObjectTypes, uint dwObjectTypes, VARIANT* pVar);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsOpenObject(const(PWSTR) lpszPathName, const(PWSTR) lpszUserName, const(PWSTR) lpszPassword, 
                      ADS_AUTHENTICATION_ENUM dwReserved, const(GUID)* riid, void** ppObject);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsGetLastError(uint* lpError, PWSTR lpErrorBuf, uint dwErrorBufLen, PWSTR lpNameBuf, uint dwNameBufLen);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
void ADsSetLastError(uint dwErr, const(PWSTR) pszError, const(PWSTR) pszProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
void* AllocADsMem(uint cb);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
BOOL FreeADsMem(void* pMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
void* ReallocADsMem(void* pOldMem, uint cbOld, uint cbNew);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
PWSTR AllocADsStr(const(PWSTR) pStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
BOOL FreeADsStr(PWSTR pStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
BOOL ReallocADsStr(PWSTR* ppStr, PWSTR pStr);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT ADsEncodeBinaryData(ubyte* pbSrcData, uint dwSrcLen, PWSTR* ppszDestData);

@DllImport("ACTIVEDS.dll")
HRESULT ADsDecodeBinaryData(const(PWSTR) szSrcData, ubyte** ppbDestData, uint* pdwDestLen);

@DllImport("ACTIVEDS.dll")
HRESULT PropVariantToAdsType(VARIANT* pVariant, uint dwNumVariant, ADSVALUE** ppAdsValues, uint* pdwNumValues);

@DllImport("ACTIVEDS.dll")
HRESULT AdsTypeToPropVariant(ADSVALUE* pAdsValues, uint dwNumValues, VARIANT* pVariant);

@DllImport("ACTIVEDS.dll")
void AdsFreeAdsValues(ADSVALUE* pAdsValues, uint dwNumValues);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT BinarySDToSecurityDescriptor(PSECURITY_DESCRIPTOR pSecurityDescriptor, VARIANT* pVarsec, 
                                     const(PWSTR) pszServerName, const(PWSTR) userName, const(PWSTR) passWord, 
                                     uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ACTIVEDS.dll")
HRESULT SecurityDescriptorToBinarySD(VARIANT vVarSecDes, PSECURITY_DESCRIPTOR* ppSecurityDescriptor, 
                                     uint* pdwSDLength, const(PWSTR) pszServerName, const(PWSTR) userName, 
                                     const(PWSTR) passWord, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsuiext.dll")
int DsBrowseForContainerW(DSBROWSEINFOW* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsuiext.dll")
int DsBrowseForContainerA(DSBROWSEINFOA* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsuiext.dll")
HICON DsGetIcon(uint dwFlags, const(PWSTR) pszObjectClass, int cxImage, int cyImage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsuiext.dll")
HRESULT DsGetFriendlyClassName(const(PWSTR) pszObjectClass, PWSTR pszBuffer, uint cchBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
HRESULT ADsPropCreateNotifyObj(IDataObject pAppThdDataObj, PWSTR pwzADsObjName, HWND* phNotifyObj);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropGetInitInfo(HWND hNotifyObj, ADSPROPINITPARAMS* pInitParams);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropSetHwndWithTitle(HWND hNotifyObj, HWND hPage, byte* ptzTitle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropSetHwnd(HWND hNotifyObj, HWND hPage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropCheckIfWritable(const(PWSTR) pwzAttr, const(ADS_ATTR_INFO)* pWritableAttrs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropSendErrorMessage(HWND hNotifyObj, ADSPROPERROR* pError);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("dsprop.dll")
BOOL ADsPropShowErrorDialog(HWND hNotifyObj, HWND hPage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsMakeSpnW(const(PWSTR) ServiceClass, const(PWSTR) ServiceName, const(PWSTR) InstanceName, 
                ushort InstancePort, const(PWSTR) Referrer, uint* pcSpnLength, PWSTR pszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsMakeSpnA(const(PSTR) ServiceClass, const(PSTR) ServiceName, const(PSTR) InstanceName, ushort InstancePort, 
                const(PSTR) Referrer, uint* pcSpnLength, PSTR pszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsCrackSpnA(const(PSTR) pszSpn, uint* pcServiceClass, PSTR ServiceClass, uint* pcServiceName, 
                 PSTR ServiceName, uint* pcInstanceName, PSTR InstanceName, ushort* pInstancePort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsCrackSpnW(const(PWSTR) pszSpn, uint* pcServiceClass, PWSTR ServiceClass, uint* pcServiceName, 
                 PWSTR ServiceName, uint* pcInstanceName, PWSTR InstanceName, ushort* pInstancePort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsQuoteRdnValueW(uint cUnquotedRdnValueLength, const(PWSTR) psUnquotedRdnValue, uint* pcQuotedRdnValueLength, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR psQuotedRdnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsQuoteRdnValueA(uint cUnquotedRdnValueLength, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PSTR) psUnquotedRdnValue, 
                      uint* pcQuotedRdnValueLength, 
                      /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR psQuotedRdnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsUnquoteRdnValueW(uint cQuotedRdnValueLength, const(PWSTR) psQuotedRdnValue, uint* pcUnquotedRdnValueLength, 
                        /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR psUnquotedRdnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsUnquoteRdnValueA(uint cQuotedRdnValueLength, 
                        /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/const(PSTR) psQuotedRdnValue, 
                        uint* pcUnquotedRdnValueLength, 
                        /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR psUnquotedRdnValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
uint DsGetRdnW(PWSTR* ppDN, uint* pcDN, PWSTR* ppKey, uint* pcKey, PWSTR* ppVal, uint* pcVal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsCrackUnquotedMangledRdnW(const(PWSTR) pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsCrackUnquotedMangledRdnA(const(PSTR) pszRDN, uint cchRDN, GUID* pGuid, DS_MANGLE_FOR* peDsMangleFor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsIsMangledRdnValueW(const(PWSTR) pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsIsMangledRdnValueA(const(PSTR) pszRdn, uint cRdn, DS_MANGLE_FOR eDsMangleForDesired);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsIsMangledDnA(const(PSTR) pszDn, DS_MANGLE_FOR eDsMangleFor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("DSPARSE.dll")
BOOL DsIsMangledDnW(const(PWSTR) pszDn, DS_MANGLE_FOR eDsMangleFor);

@DllImport("DSPARSE.dll")
uint DsCrackSpn2A(const(PSTR) pszSpn, uint cSpn, uint* pcServiceClass, PSTR ServiceClass, uint* pcServiceName, 
                  PSTR ServiceName, uint* pcInstanceName, PSTR InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsCrackSpn2W(const(PWSTR) pszSpn, uint cSpn, uint* pcServiceClass, PWSTR ServiceClass, uint* pcServiceName, 
                  PWSTR ServiceName, uint* pcInstanceName, PWSTR InstanceName, ushort* pInstancePort);

@DllImport("DSPARSE.dll")
uint DsCrackSpn3W(const(PWSTR) pszSpn, uint cSpn, uint* pcHostName, PWSTR HostName, uint* pcInstanceName, 
                  PWSTR InstanceName, ushort* pPortNumber, uint* pcDomainName, PWSTR DomainName, uint* pcRealmName, 
                  PWSTR RealmName);

@DllImport("DSPARSE.dll")
uint DsCrackSpn4W(const(PWSTR) pszSpn, uint cSpn, uint* pcHostName, PWSTR HostName, uint* pcInstanceName, 
                  PWSTR InstanceName, uint* pcPortName, PWSTR PortName, uint* pcDomainName, PWSTR DomainName, 
                  uint* pcRealmName, PWSTR RealmName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithCredW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                     HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithCredA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithSpnW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                    const(PWSTR) ServicePrincipalName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithSpnA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, 
                    const(PSTR) ServicePrincipalName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithSpnExW(const(PWSTR) DomainControllerName, const(PWSTR) DnsDomainName, void* AuthIdentity, 
                      const(PWSTR) ServicePrincipalName, uint BindFlags, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindWithSpnExA(const(PSTR) DomainControllerName, const(PSTR) DnsDomainName, void* AuthIdentity, 
                      const(PSTR) ServicePrincipalName, uint BindFlags, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindByInstanceW(const(PWSTR) ServerName, const(PWSTR) Annotation, GUID* InstanceGuid, 
                       const(PWSTR) DnsDomainName, void* AuthIdentity, const(PWSTR) ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindByInstanceA(const(PSTR) ServerName, const(PSTR) Annotation, GUID* InstanceGuid, 
                       const(PSTR) DnsDomainName, void* AuthIdentity, const(PSTR) ServicePrincipalName, 
                       uint BindFlags, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindToISTGW(const(PWSTR) SiteName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindToISTGA(const(PSTR) SiteName, HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsBindingSetTimeout(HANDLE hDS, uint cTimeoutSecs);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsUnBindW(HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsUnBindA(HANDLE* phDS);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsMakePasswordCredentialsW(const(PWSTR) User, const(PWSTR) Domain, const(PWSTR) Password, 
                                void** pAuthIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsMakePasswordCredentialsA(const(PSTR) User, const(PSTR) Domain, const(PSTR) Password, void** pAuthIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreePasswordCredentials(void* AuthIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsCrackNamesW(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, const(PWSTR)* rpNames, DS_NAME_RESULTW** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsCrackNamesA(HANDLE hDS, DS_NAME_FLAGS flags, DS_NAME_FORMAT formatOffered, DS_NAME_FORMAT formatDesired, 
                   uint cNames, const(PSTR)* rpNames, DS_NAME_RESULTA** ppResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeNameResultW(DS_NAME_RESULTW* pResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeNameResultA(DS_NAME_RESULTA* pResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsGetSpnA(DS_SPN_NAME_TYPE ServiceType, const(PSTR) ServiceClass, const(PSTR) ServiceName, 
               ushort InstancePort, ushort cInstanceNames, const(PSTR)* pInstanceNames, 
               const(ushort)* pInstancePorts, uint* pcSpn, PSTR** prpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsGetSpnW(DS_SPN_NAME_TYPE ServiceType, const(PWSTR) ServiceClass, const(PWSTR) ServiceName, 
               ushort InstancePort, ushort cInstanceNames, const(PWSTR)* pInstanceNames, 
               const(ushort)* pInstancePorts, uint* pcSpn, PWSTR** prpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeSpnArrayA(uint cSpn, PSTR* rpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeSpnArrayW(uint cSpn, PWSTR* rpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsWriteAccountSpnA(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(PSTR) pszAccount, uint cSpn, 
                        const(PSTR)* rpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsWriteAccountSpnW(HANDLE hDS, DS_SPN_WRITE_OP Operation, const(PWSTR) pszAccount, uint cSpn, 
                        const(PWSTR)* rpszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsClientMakeSpnForTargetServerW(const(PWSTR) ServiceClass, const(PWSTR) ServiceName, uint* pcSpnLength, 
                                     PWSTR pszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsClientMakeSpnForTargetServerA(const(PSTR) ServiceClass, const(PSTR) ServiceName, uint* pcSpnLength, 
                                     PSTR pszSpn);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsServerRegisterSpnA(DS_SPN_WRITE_OP Operation, const(PSTR) ServiceClass, const(PSTR) UserObjectDN);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsServerRegisterSpnW(DS_SPN_WRITE_OP Operation, const(PWSTR) ServiceClass, const(PWSTR) UserObjectDN);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaSyncA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidDsaSrc, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaSyncW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidDsaSrc, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaAddA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) SourceDsaDn, const(PSTR) TransportDn, 
                   const(PSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaAddW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) SourceDsaDn, const(PWSTR) TransportDn, 
                   const(PWSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaDelA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) DsaSrc, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaDelW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) DsaSrc, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaModifyA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidSourceDsa, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PSTR) TransportDn, 
                      const(PSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ReplicaFlags, 
                      uint ModifyFields, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaModifyW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidSourceDsa, 
                      /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/const(PWSTR) TransportDn, 
                      const(PWSTR) SourceDsaAddress, const(SCHEDULE)* pSchedule, uint ReplicaFlags, 
                      uint ModifyFields, uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaUpdateRefsA(HANDLE hDS, const(PSTR) NameContext, const(PSTR) DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaUpdateRefsW(HANDLE hDS, const(PWSTR) NameContext, const(PWSTR) DsaDest, const(GUID)* pUuidDsaDest, 
                          uint Options);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaSyncAllA(HANDLE hDS, const(PSTR) pszNameContext, uint ulFlags, ptrdiff_t pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOA*** pErrors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaSyncAllW(HANDLE hDS, const(PWSTR) pszNameContext, uint ulFlags, ptrdiff_t pFnCallBack, 
                       void* pCallbackData, DS_REPSYNCALL_ERRINFOW*** pErrors);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsRemoveDsServerW(HANDLE hDs, PWSTR ServerDN, PWSTR DomainDN, BOOL* fLastDcInDomain, BOOL fCommit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsRemoveDsServerA(HANDLE hDs, PSTR ServerDN, PSTR DomainDN, BOOL* fLastDcInDomain, BOOL fCommit);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsRemoveDsDomainW(HANDLE hDs, PWSTR DomainDN);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsRemoveDsDomainA(HANDLE hDs, PSTR DomainDN);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListSitesA(HANDLE hDs, DS_NAME_RESULTA** ppSites);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListSitesW(HANDLE hDs, DS_NAME_RESULTW** ppSites);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListServersInSiteA(HANDLE hDs, const(PSTR) site, DS_NAME_RESULTA** ppServers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListServersInSiteW(HANDLE hDs, const(PWSTR) site, DS_NAME_RESULTW** ppServers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListDomainsInSiteA(HANDLE hDs, const(PSTR) site, DS_NAME_RESULTA** ppDomains);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListDomainsInSiteW(HANDLE hDs, const(PWSTR) site, DS_NAME_RESULTW** ppDomains);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListServersForDomainInSiteA(HANDLE hDs, const(PSTR) domain, const(PSTR) site, DS_NAME_RESULTA** ppServers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListServersForDomainInSiteW(HANDLE hDs, const(PWSTR) domain, const(PWSTR) site, DS_NAME_RESULTW** ppServers);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListInfoForServerA(HANDLE hDs, const(PSTR) server, DS_NAME_RESULTA** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListInfoForServerW(HANDLE hDs, const(PWSTR) server, DS_NAME_RESULTW** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListRolesA(HANDLE hDs, DS_NAME_RESULTA** ppRoles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsListRolesW(HANDLE hDs, DS_NAME_RESULTW** ppRoles);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsQuerySitesByCostW(HANDLE hDS, PWSTR pwszFromSite, PWSTR* rgwszToSites, uint cToSites, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsQuerySitesByCostA(HANDLE hDS, PSTR pszFromSite, PSTR* rgszToSites, uint cToSites, 
                         /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint dwFlags, 
                         DS_SITE_COST_INFO** prgSiteInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsQuerySitesFree(DS_SITE_COST_INFO* rgSiteInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsMapSchemaGuidsA(HANDLE hDs, uint cGuids, GUID* rGuids, DS_SCHEMA_GUID_MAPA** ppGuidMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeSchemaGuidMapA(DS_SCHEMA_GUID_MAPA* pGuidMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsMapSchemaGuidsW(HANDLE hDs, uint cGuids, GUID* rGuids, DS_SCHEMA_GUID_MAPW** ppGuidMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeSchemaGuidMapW(DS_SCHEMA_GUID_MAPW* pGuidMap);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsGetDomainControllerInfoA(HANDLE hDs, const(PSTR) DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsGetDomainControllerInfoW(HANDLE hDs, const(PWSTR) DomainName, uint InfoLevel, uint* pcOut, void** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeDomainControllerInfoA(uint InfoLevel, uint cInfo, void* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsFreeDomainControllerInfoW(uint InfoLevel, uint cInfo, void* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaConsistencyCheck(HANDLE hDS, DS_KCC_TASKID TaskID, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaVerifyObjectsW(HANDLE hDS, const(PWSTR) NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaVerifyObjectsA(HANDLE hDS, const(PSTR) NameContext, const(GUID)* pUuidDsaSrc, uint ulOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaGetInfoW(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(PWSTR) pszObject, 
                       GUID* puuidForSourceDsaObjGuid, void** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsReplicaGetInfo2W(HANDLE hDS, DS_REPL_INFO_TYPE InfoType, const(PWSTR) pszObject, 
                        GUID* puuidForSourceDsaObjGuid, const(PWSTR) pszAttributeName, const(PWSTR) pszValue, 
                        uint dwFlags, uint dwEnumerationContext, void** ppInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
void DsReplicaFreeInfo(DS_REPL_INFO_TYPE InfoType, void* pInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsAddSidHistoryW(HANDLE hDS, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, 
                      const(PWSTR) SrcDomain, const(PWSTR) SrcPrincipal, const(PWSTR) SrcDomainController, 
                      void* SrcDomainCreds, const(PWSTR) DstDomain, const(PWSTR) DstPrincipal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsAddSidHistoryA(HANDLE hDS, /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, 
                      const(PSTR) SrcDomain, const(PSTR) SrcPrincipal, const(PSTR) SrcDomainController, 
                      void* SrcDomainCreds, const(PSTR) DstDomain, const(PSTR) DstPrincipal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsInheritSecurityIdentityW(HANDLE hDS, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, 
                                const(PWSTR) SrcPrincipal, const(PWSTR) DstPrincipal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NTDSAPI.dll")
uint DsInheritSecurityIdentityA(HANDLE hDS, 
                                /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint Flags, 
                                const(PSTR) SrcPrincipal, const(PSTR) DstPrincipal);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsRoleGetPrimaryDomainInformation(const(PWSTR) lpServer, DSROLE_PRIMARY_DOMAIN_INFO_LEVEL InfoLevel, 
                                       ubyte** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
void DsRoleFreeMemory(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcNameA(const(PSTR) ComputerName, const(PSTR) DomainName, GUID* DomainGuid, const(PSTR) SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOA** DomainControllerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcNameW(const(PWSTR) ComputerName, const(PWSTR) DomainName, GUID* DomainGuid, const(PWSTR) SiteName, 
                  uint Flags, DOMAIN_CONTROLLER_INFOW** DomainControllerInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetSiteNameA(const(PSTR) ComputerName, PSTR* SiteName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetSiteNameW(const(PWSTR) ComputerName, PWSTR* SiteName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsValidateSubnetNameW(const(PWSTR) SubnetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsValidateSubnetNameA(const(PSTR) SubnetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsAddressToSiteNamesW(const(PWSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                           PWSTR** SiteNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsAddressToSiteNamesA(const(PSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                           PSTR** SiteNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsAddressToSiteNamesExW(const(PWSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                             PWSTR** SiteNames, PWSTR** SubnetNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsAddressToSiteNamesExA(const(PSTR) ComputerName, uint EntryCount, SOCKET_ADDRESS* SocketAddresses, 
                             PSTR** SiteNames, PSTR** SubnetNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsEnumerateDomainTrustsW(PWSTR ServerName, uint Flags, DS_DOMAIN_TRUSTSW** Domains, uint* DomainCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsEnumerateDomainTrustsA(PSTR ServerName, uint Flags, DS_DOMAIN_TRUSTSA** Domains, uint* DomainCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetForestTrustInformationW(const(PWSTR) ServerName, const(PWSTR) TrustedDomainName, uint Flags, 
                                  LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsMergeForestTrustInformationW(const(PWSTR) DomainName, LSA_FOREST_TRUST_INFORMATION* NewForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION* OldForestTrustInfo, 
                                    LSA_FOREST_TRUST_INFORMATION** MergedForestTrustInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcSiteCoverageW(const(PWSTR) ServerName, uint* EntryCount, PWSTR** SiteNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcSiteCoverageA(const(PSTR) ServerName, uint* EntryCount, PSTR** SiteNames);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsDeregisterDnsHostRecordsW(PWSTR ServerName, PWSTR DnsDomainName, GUID* DomainGuid, GUID* DsaGuid, 
                                 PWSTR DnsHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsDeregisterDnsHostRecordsA(PSTR ServerName, PSTR DnsDomainName, GUID* DomainGuid, GUID* DsaGuid, 
                                 PSTR DnsHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcOpenW(const(PWSTR) DnsName, uint OptionFlags, const(PWSTR) SiteName, GUID* DomainGuid, 
                  const(PWSTR) DnsForestName, uint DcFlags, 
                  /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DsGetDcCloseW))], [])*/HANDLE* RetGetDcContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcOpenA(const(PSTR) DnsName, uint OptionFlags, const(PSTR) SiteName, GUID* DomainGuid, 
                  const(PSTR) DnsForestName, uint DcFlags, 
                  /*PARAM ATTR: RAIIFreeAttribute : CustomAttributeSig([FixedArgSig(ElementSig(DsGetDcCloseW))], [])*/HANDLE* RetGetDcContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcNextW(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  PWSTR* DnsHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
uint DsGetDcNextA(HANDLE GetDcContextHandle, uint* SockAddressCount, SOCKET_ADDRESS** SockAddresses, 
                  PSTR* DnsHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("NETAPI32.dll")
void DsGetDcCloseW(HANDLE GetDcContextHandle);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertyentry
@GUID("72d3edc2-a4c4-11d0-8533-00c04fd8d503")
struct PropertyEntry;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertyvalue
@GUID("7b9e38b0-a97c-11d0-8534-00c04fd8d503")
struct PropertyValue;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsaccesscontrolentry
@GUID("b75ac000-9bdd-11d0-852c-00c04fd8d503")
struct AccessControlEntry;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsaccesscontrollist
@GUID("b85ea052-9bdd-11d0-852c-00c04fd8d503")
struct AccessControlList;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/TaskSchd/taskschedulerschema-securitydescriptor-registrationinfotype-element
@GUID("b958f73c-9bdd-11d0-852c-00c04fd8d503")
struct SecurityDescriptor;

@GUID("927971f5-0939-11d1-8be1-00c04fd8d503")
struct LargeInteger;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsnametranslate
@GUID("274fae1f-3626-11d1-a3a4-00c04fb950dc")
struct NameTranslate;

@GUID("15f88a55-4680-11d1-a3b4-00c04fb950dc")
struct CaseIgnoreList;

@GUID("a5062215-4681-11d1-a3b4-00c04fb950dc")
struct FaxNumber;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsnetaddress
@GUID("b0b71247-4080-11d1-a3ac-00c04fb950dc")
struct NetAddress;

@GUID("1241400f-4680-11d1-a3b4-00c04fb950dc")
struct OctetList;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsemail
@GUID("8f92a857-478e-11d1-a3b4-00c04fb950dc")
struct Email;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/tablet/path-element
@GUID("b2538919-4080-11d1-a3ac-00c04fb950dc")
struct Path;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsreplicapointer
@GUID("f5d1badf-4080-11d1-a3ac-00c04fb950dc")
struct ReplicaPointer;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadstimestamp
@GUID("b2bed2eb-4080-11d1-a3ac-00c04fb950dc")
struct Timestamp;

@GUID("0a75afcd-4680-11d1-a3b4-00c04fb950dc")
struct PostalAddress;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsbacklink
@GUID("fcbf906f-4080-11d1-a3ac-00c04fb950dc")
struct BackLink;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadstypedname
@GUID("b33143cb-4080-11d1-a3ac-00c04fb950dc")
struct TypedName;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadshold
@GUID("b3ad3e13-4080-11d1-a3ac-00c04fb950dc")
struct Hold;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspathname
@GUID("080d0d78-f421-11d0-a36e-00c04fb950dc")
struct Pathname;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsadsysteminfo
@GUID("50b6327f-afd1-11d2-9cb9-0000f87a369e")
struct ADSystemInfo;

@GUID("66182ec4-afd1-11d2-9cb9-0000f87a369e")
struct WinNTSystemInfo;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdnwithbinary
@GUID("7e99c0a3-f935-11d2-ba96-00c04fb6d0d1")
struct DNWithBinary;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdnwithstring
@GUID("334857cc-f934-11d2-ba96-00c04fb6d0d1")
struct DNWithString;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadssecuritydescriptor
@GUID("f270c64a-ffb8-4ae4-85fe-3a75e5347966")
struct ADsSecurityUtility;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nn-cmnquery-iqueryform
@GUID("8cfcee30-39bd-11d0-b8d1-00a024ab2dbb")
interface IQueryForm : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-iqueryform-initialize
    HRESULT Initialize(HKEY hkForm);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-iqueryform-addforms
    HRESULT AddForms(LPCQADDFORMSPROC pAddFormsProc, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-iqueryform-addpages
    HRESULT AddPages(LPCQADDPAGESPROC pAddPagesProc, LPARAM lParam);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nn-cmnquery-ipersistquery
@GUID("1a3114b8-a62e-11d0-a6c5-00a0c906af45")
interface IPersistQuery : IPersist
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-writestring
    HRESULT WriteString(const(PWSTR) pSection, const(PWSTR) pValueName, const(PWSTR) pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-readstring
    HRESULT ReadString(const(PWSTR) pSection, const(PWSTR) pValueName, PWSTR pBuffer, int cchBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-writeint
    HRESULT WriteInt(const(PWSTR) pSection, const(PWSTR) pValueName, int value);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-readint
    HRESULT ReadInt(const(PWSTR) pSection, const(PWSTR) pValueName, int* pValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-writestruct
    HRESULT WriteStruct(const(PWSTR) pSection, const(PWSTR) pValueName, void* pStruct, uint cbStruct);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-readstruct
    HRESULT ReadStruct(const(PWSTR) pSection, const(PWSTR) pValueName, void* pStruct, uint cbStruct);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-ipersistquery-clear
    HRESULT Clear();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nn-cmnquery-icommonquery
@GUID("ab50dec0-6f1d-11d0-a1c4-00aa00c16e65")
interface ICommonQuery : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/cmnquery/nf-cmnquery-icommonquery-openquerywindow
    HRESULT OpenQueryWindow(HWND hwndParent, OPENQUERYWINDOW* pQueryWnd, IDataObject* ppDataObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iads
@GUID("fd8256d0-fd15-11ce-abc4-02608c9e7553")
interface IADs : IDispatch
{
    HRESULT get_Name(BSTR* retval);
    HRESULT get_Class(BSTR* retval);
    HRESULT get_GUID(BSTR* retval);
    HRESULT get_ADsPath(BSTR* retval);
    HRESULT get_Parent(BSTR* retval);
    HRESULT get_Schema(BSTR* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-getinfo
    HRESULT GetInfo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-setinfo
    HRESULT SetInfo();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-get
    HRESULT Get(BSTR bstrName, VARIANT* pvProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-put
    HRESULT Put(BSTR bstrName, VARIANT vProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-getex
    HRESULT GetEx(BSTR bstrName, VARIANT* pvProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-putex
    HRESULT PutEx(int lnControlCode, BSTR bstrName, VARIANT vProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iads-getinfoex
    HRESULT GetInfoEx(VARIANT vProperties, int lnReserved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadscontainer
@GUID("001677d0-fd16-11ce-abc4-02608c9e7553")
interface IADsContainer : IDispatch
{
    HRESULT get_Count(int* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
    HRESULT get_Filter(VARIANT* pVar);
    HRESULT put_Filter(VARIANT Var);
    HRESULT get_Hints(VARIANT* pvFilter);
    HRESULT put_Hints(VARIANT vHints);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-getobject
    HRESULT GetObject(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-create
    HRESULT Create(BSTR ClassName, BSTR RelativeName, IDispatch* ppObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-delete
    HRESULT Delete(BSTR bstrClassName, BSTR bstrRelativeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-copyhere
    HRESULT CopyHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscontainer-movehere
    HRESULT MoveHere(BSTR SourceName, BSTR NewName, IDispatch* ppObject);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadscollection
@GUID("72b945e0-253b-11cf-a988-00aa006bc149")
interface IADsCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscollection-add
    HRESULT Add(BSTR bstrName, VARIANT vItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscollection-remove
    HRESULT Remove(BSTR bstrItemToBeRemoved);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscollection-getobject
    HRESULT GetObject(BSTR bstrName, VARIANT* pvItem);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsmembers
@GUID("451a0030-72ec-11cf-b03b-00aa006e0975")
interface IADsMembers : IDispatch
{
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsmembers-get__newenum
    HRESULT get__NewEnum(IUnknown* ppEnumerator);
    HRESULT get_Filter(VARIANT* pvFilter);
    HRESULT put_Filter(VARIANT pvFilter);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertylist
@GUID("c6f602b6-8f69-11d0-8528-00c04fd8d503")
interface IADsPropertyList : IDispatch
{
    HRESULT get_PropertyCount(int* plCount);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Next(VARIANT* pVariant);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT Skip(int cElements);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-item
    HRESULT Item(VARIANT varIndex, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-getpropertyitem
    HRESULT GetPropertyItem(BSTR bstrName, int lnADsType, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-putpropertyitem
    HRESULT PutPropertyItem(VARIANT varData);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-resetpropertyitem
    HRESULT ResetPropertyItem(VARIANT varEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertylist-purgepropertylist
    HRESULT PurgePropertyList();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertyentry
@GUID("05792c8e-941f-11d0-8529-00c04fd8d503")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertyvalue
@GUID("79fa9ad0-a97c-11d0-8534-00c04fd8d503")
interface IADsPropertyValue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertyvalue-clear
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspropertyvalue2
@GUID("306e831c-5bc7-11d1-a3b8-00c04fb950dc")
interface IADsPropertyValue2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertyvalue2-getobjectproperty
    HRESULT GetObjectProperty(int* lnADsType, VARIANT* pvProp);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspropertyvalue2-putobjectproperty
    HRESULT PutObjectProperty(int lnADsType, VARIANT vProp);
}

@GUID("86ab4bbe-65f6-11d1-8c13-00c04fd8d503")
interface IPrivateDispatch : IUnknown
{
    HRESULT ADSIInitializeDispatchManager(int dwExtensionId);
    HRESULT ADSIGetTypeInfoCount(uint* pctinfo);
    HRESULT ADSIGetTypeInfo(uint itinfo, uint lcid, ITypeInfo* pptinfo);
    HRESULT ADSIGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgdispid);
    HRESULT ADSIInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                       VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

@GUID("89126bab-6ead-11d1-8c18-00c04fd8d503")
interface IPrivateUnknown : IUnknown
{
    HRESULT ADSIInitializeObject(BSTR lpszUserName, BSTR lpszPassword, int lnReserved);
    HRESULT ADSIReleaseObject();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsextension
@GUID("3d35553c-d2b0-11d1-b17b-0000f87593a0")
interface IADsExtension : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsextension-operate
    HRESULT Operate(uint dwCode, VARIANT varData1, VARIANT varData2, VARIANT varData3);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsextension-privategetidsofnames
    HRESULT PrivateGetIDsOfNames(const(GUID)* riid, ushort** rgszNames, uint cNames, uint lcid, int* rgDispid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsextension-privateinvoke
    HRESULT PrivateInvoke(int dispidMember, const(GUID)* riid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, 
                          VARIANT* pvarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdeleteops
@GUID("b2bd0902-8878-11d1-8c21-00c04fd8d503")
interface IADsDeleteOps : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsdeleteops-deleteobject
    HRESULT DeleteObject(int lnFlags);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsnamespaces
@GUID("28b96ba0-b330-11cf-a9ad-00aa006bc149")
interface IADsNamespaces : IADs
{
    HRESULT get_DefaultContainer(BSTR* retval);
    HRESULT put_DefaultContainer(BSTR bstrDefaultContainer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsclass
@GUID("c8f93dd0-4ae0-11cf-9e73-00aa004a5691")
interface IADsClass : IADs
{
    HRESULT get_PrimaryInterface(BSTR* retval);
    HRESULT get_CLSID(BSTR* retval);
    HRESULT put_CLSID(BSTR bstrCLSID);
    HRESULT get_OID(BSTR* retval);
    HRESULT put_OID(BSTR bstrOID);
    HRESULT get_Abstract(VARIANT_BOOL* retval);
    HRESULT put_Abstract(VARIANT_BOOL fAbstract);
    HRESULT get_Auxiliary(VARIANT_BOOL* retval);
    HRESULT put_Auxiliary(VARIANT_BOOL fAuxiliary);
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
    HRESULT get_Container(VARIANT_BOOL* retval);
    HRESULT put_Container(VARIANT_BOOL fContainer);
    HRESULT get_HelpFileName(BSTR* retval);
    HRESULT put_HelpFileName(BSTR bstrHelpFileName);
    HRESULT get_HelpFileContext(int* retval);
    HRESULT put_HelpFileContext(int lnHelpFileContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsclass-qualifiers
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsproperty
@GUID("c8f93dd3-4ae0-11cf-9e73-00aa004a5691")
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
    HRESULT get_MultiValued(VARIANT_BOOL* retval);
    HRESULT put_MultiValued(VARIANT_BOOL fMultiValued);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsproperty-qualifiers
    HRESULT Qualifiers(IADsCollection* ppQualifiers);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadssyntax
@GUID("c8f93dd2-4ae0-11cf-9e73-00aa004a5691")
interface IADsSyntax : IADs
{
    HRESULT get_OleAutoDataType(int* retval);
    HRESULT put_OleAutoDataType(int lnOleAutoDataType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadslocality
@GUID("a05e03a2-effe-11cf-8abc-00c04fd8d503")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadso
@GUID("a1cd2dc6-effe-11cf-8abc-00c04fd8d503")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsou
@GUID("a2f733b8-effe-11cf-8abc-00c04fd8d503")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdomain
@GUID("00e4c220-fd16-11ce-abc4-02608c9e7553")
interface IADsDomain : IADs
{
    HRESULT get_IsWorkgroup(VARIANT_BOOL* retval);
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadscomputer
@GUID("efe3cc70-1d9f-11cf-b1f3-02608c9e7553")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadscomputeroperations
@GUID("ef497680-1d9f-11cf-b1f3-02608c9e7553")
interface IADsComputerOperations : IADs
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscomputeroperations-status
    HRESULT Status(IDispatch* ppObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadscomputeroperations-shutdown
    HRESULT Shutdown(VARIANT_BOOL bReboot);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsgroup
@GUID("27636b00-410f-11cf-b1ff-02608c9e7553")
interface IADsGroup : IADs
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsgroup-members
    HRESULT Members(IADsMembers* ppMembers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsgroup-ismember
    HRESULT IsMember(BSTR bstrMember, VARIANT_BOOL* bMember);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsgroup-add
    HRESULT Add(BSTR bstrNewItem);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsgroup-remove
    HRESULT Remove(BSTR bstrItemToBeRemoved);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsuser
@GUID("3e37e320-17e2-11cf-abc4-02608c9e7553")
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
    HRESULT get_AccountDisabled(VARIANT_BOOL* retval);
    HRESULT put_AccountDisabled(VARIANT_BOOL fAccountDisabled);
    HRESULT get_AccountExpirationDate(double* retval);
    HRESULT put_AccountExpirationDate(double daAccountExpirationDate);
    HRESULT get_GraceLoginsAllowed(int* retval);
    HRESULT put_GraceLoginsAllowed(int lnGraceLoginsAllowed);
    HRESULT get_GraceLoginsRemaining(int* retval);
    HRESULT put_GraceLoginsRemaining(int lnGraceLoginsRemaining);
    HRESULT get_IsAccountLocked(VARIANT_BOOL* retval);
    HRESULT put_IsAccountLocked(VARIANT_BOOL fIsAccountLocked);
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
    HRESULT get_PasswordRequired(VARIANT_BOOL* retval);
    HRESULT put_PasswordRequired(VARIANT_BOOL fPasswordRequired);
    HRESULT get_RequireUniquePassword(VARIANT_BOOL* retval);
    HRESULT put_RequireUniquePassword(VARIANT_BOOL fRequireUniquePassword);
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
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsuser-groups
    HRESULT Groups(IADsMembers* ppGroups);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsuser-setpassword
    HRESULT SetPassword(BSTR NewPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsuser-changepassword
    HRESULT ChangePassword(BSTR bstrOldPassword, BSTR bstrNewPassword);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsprintqueue
@GUID("b15160d0-1226-11cf-a985-00aa006bc149")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsprintqueueoperations
@GUID("124be5c0-156e-11cf-a986-00aa006bc149")
interface IADsPrintQueueOperations : IADs
{
    HRESULT get_Status(int* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintqueueoperations-printjobs
    HRESULT PrintJobs(IADsCollection* pObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintqueueoperations-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintqueueoperations-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintqueueoperations-purge
    HRESULT Purge();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsprintjob
@GUID("32fb6780-1ed0-11cf-a988-00aa006bc149")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsprintjoboperations
@GUID("9a52db30-1ecf-11cf-a988-00aa006bc149")
interface IADsPrintJobOperations : IADs
{
    HRESULT get_Status(int* retval);
    HRESULT get_TimeElapsed(int* retval);
    HRESULT get_PagesPrinted(int* retval);
    HRESULT get_Position(int* retval);
    HRESULT put_Position(int lnPosition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintjoboperations-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsprintjoboperations-resume
    HRESULT Resume();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsservice
@GUID("68af66e0-31ca-11cf-a98a-00aa006bc149")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsserviceoperations
@GUID("5d7b33f0-31ca-11cf-a98a-00aa006bc149")
interface IADsServiceOperations : IADs
{
    HRESULT get_Status(int* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsserviceoperations-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsserviceoperations-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsserviceoperations-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsserviceoperations-continue
    HRESULT Continue();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsserviceoperations-setpassword
    HRESULT SetPassword(BSTR bstrNewPassword);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsfileservice
@GUID("a89d1900-31ca-11cf-a98a-00aa006bc149")
interface IADsFileService : IADsService
{
    HRESULT get_Description(BSTR* retval);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MaxUserCount(int* retval);
    HRESULT put_MaxUserCount(int lnMaxUserCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsfileserviceoperations
@GUID("a02ded10-31ca-11cf-a98a-00aa006bc149")
interface IADsFileServiceOperations : IADsServiceOperations
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsfileserviceoperations-sessions
    HRESULT Sessions(IADsCollection* ppSessions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsfileserviceoperations-resources
    HRESULT Resources(IADsCollection* ppResources);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsfileshare
@GUID("eb6dcaf0-4b83-11cf-a995-00aa006bc149")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadssession
@GUID("398b7da0-4aab-11cf-ae2c-00aa006ebfb9")
interface IADsSession : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Computer(BSTR* retval);
    HRESULT get_ComputerPath(BSTR* retval);
    HRESULT get_ConnectTime(int* retval);
    HRESULT get_IdleTime(int* retval);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsresource
@GUID("34a05b20-4aab-11cf-ae2c-00aa006ebfb9")
interface IADsResource : IADs
{
    HRESULT get_User(BSTR* retval);
    HRESULT get_UserPath(BSTR* retval);
    HRESULT get_Path(BSTR* retval);
    HRESULT get_LockCount(int* retval);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsopendsobject
@GUID("ddf2891e-0f9c-11d0-8ad4-00c04fd8d503")
interface IADsOpenDSObject : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsopendsobject-opendsobject
    HRESULT OpenDSObject(BSTR lpszDNName, BSTR lpszUserName, BSTR lpszPassword, int lnReserved, 
                         IDispatch* ppOleDsObj);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryobject
@GUID("e798de2c-22e4-11d0-84fe-00c04fd8d503")
interface IDirectoryObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectoryobject-getobjectinformation
    HRESULT GetObjectInformation(ADS_OBJECT_INFO** ppObjInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectoryobject-getobjectattributes
    HRESULT GetObjectAttributes(PWSTR* pAttributeNames, uint dwNumberAttributes, 
                                ADS_ATTR_INFO** ppAttributeEntries, uint* pdwNumAttributesReturned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectoryobject-setobjectattributes
    HRESULT SetObjectAttributes(ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                                uint* pdwNumAttributesModified);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectoryobject-createdsobject
    HRESULT CreateDSObject(PWSTR pszRDNName, ADS_ATTR_INFO* pAttributeEntries, uint dwNumAttributes, 
                           IDispatch* ppObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectoryobject-deletedsobject
    HRESULT DeleteDSObject(PWSTR pszRDNName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectorysearch
@GUID("109ba8ec-92f0-11d0-a790-00c04fd8d5a8")
interface IDirectorySearch : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-setsearchpreference
    HRESULT SetSearchPreference(ADS_SEARCHPREF_INFO* pSearchPrefs, uint dwNumPrefs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-executesearch
    HRESULT ExecuteSearch(PWSTR pszSearchFilter, PWSTR* pAttributeNames, uint dwNumberAttributes, 
                          ADS_SEARCH_HANDLE* phSearchResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-abandonsearch
    HRESULT AbandonSearch(ADS_SEARCH_HANDLE phSearchResult);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT GetFirstRow(ADS_SEARCH_HANDLE hSearchResult);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT GetNextRow(ADS_SEARCH_HANDLE hSearchResult);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT GetPreviousRow(ADS_SEARCH_HANDLE hSearchResult);
//METH ATTR: CanReturnMultipleSuccessValuesAttribute : CustomAttributeSig([], [])
    HRESULT GetNextColumnName(ADS_SEARCH_HANDLE hSearchHandle, PWSTR* ppszColumnName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-getcolumn
    HRESULT GetColumn(ADS_SEARCH_HANDLE hSearchResult, PWSTR szColumnName, ADS_SEARCH_COLUMN* pSearchColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-freecolumn
    HRESULT FreeColumn(ADS_SEARCH_COLUMN* pSearchColumn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-idirectorysearch-closesearchhandle
    HRESULT CloseSearchHandle(ADS_SEARCH_HANDLE hSearchResult);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
@GUID("75db3b9c-a4d8-11d0-a79c-00c04fd8d5a8")
interface IDirectorySchemaMgmt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT EnumAttributes(PWSTR* ppszAttrNames, uint dwNumAttributes, ADS_ATTR_DEF** ppAttrDefinition, 
                           uint* pdwNumAttributes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT CreateAttributeDefinition(PWSTR pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT WriteAttributeDefinition(PWSTR pszAttributeName, ADS_ATTR_DEF* pAttributeDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT DeleteAttributeDefinition(PWSTR pszAttributeName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT EnumClasses(PWSTR* ppszClassNames, uint dwNumClasses, ADS_CLASS_DEF** ppClassDefinition, 
                        uint* pdwNumClasses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT WriteClassDefinition(PWSTR pszClassName, ADS_CLASS_DEF* pClassDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT CreateClassDefinition(PWSTR pszClassName, ADS_CLASS_DEF* pClassDefinition);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-idirectoryschemamgmt
    HRESULT DeleteClassDefinition(PWSTR pszClassName);
}

@GUID("1346ce8c-9039-11d0-8528-00c04fd8d503")
interface IADsAggregatee : IUnknown
{
    HRESULT ConnectAsAggregatee(IUnknown pOuterUnknown);
    HRESULT DisconnectAsAggregatee();
    HRESULT RelinquishInterface(const(GUID)* riid);
    HRESULT RestoreInterface(const(GUID)* riid);
}

@GUID("52db5fb0-941f-11d0-8529-00c04fd8d503")
interface IADsAggregator : IUnknown
{
    HRESULT ConnectAsAggregator(IUnknown pAggregatee);
    HRESULT DisconnectAsAggregator();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsaccesscontrolentry
@GUID("b4f3a14c-9bdd-11d0-852c-00c04fd8d503")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsaccesscontrollist
@GUID("b7ee91cc-9bdd-11d0-852c-00c04fd8d503")
interface IADsAccessControlList : IDispatch
{
    HRESULT get_AclRevision(int* retval);
    HRESULT put_AclRevision(int lnAclRevision);
    HRESULT get_AceCount(int* retval);
    HRESULT put_AceCount(int lnAceCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsaccesscontrollist-addace
    HRESULT AddAce(IDispatch pAccessControlEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsaccesscontrollist-removeace
    HRESULT RemoveAce(IDispatch pAccessControlEntry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsaccesscontrollist-copyaccesslist
    HRESULT CopyAccessList(IDispatch* ppAccessControlList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsaccesscontrollist-get__newenum
    HRESULT get__NewEnum(IUnknown* retval);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadssecuritydescriptor
@GUID("b8c787ca-9bdd-11d0-852c-00c04fd8d503")
interface IADsSecurityDescriptor : IDispatch
{
    HRESULT get_Revision(int* retval);
    HRESULT put_Revision(int lnRevision);
    HRESULT get_Control(int* retval);
    HRESULT put_Control(int lnControl);
    HRESULT get_Owner(BSTR* retval);
    HRESULT put_Owner(BSTR bstrOwner);
    HRESULT get_OwnerDefaulted(VARIANT_BOOL* retval);
    HRESULT put_OwnerDefaulted(VARIANT_BOOL fOwnerDefaulted);
    HRESULT get_Group(BSTR* retval);
    HRESULT put_Group(BSTR bstrGroup);
    HRESULT get_GroupDefaulted(VARIANT_BOOL* retval);
    HRESULT put_GroupDefaulted(VARIANT_BOOL fGroupDefaulted);
    HRESULT get_DiscretionaryAcl(IDispatch* retval);
    HRESULT put_DiscretionaryAcl(IDispatch pDiscretionaryAcl);
    HRESULT get_DaclDefaulted(VARIANT_BOOL* retval);
    HRESULT put_DaclDefaulted(VARIANT_BOOL fDaclDefaulted);
    HRESULT get_SystemAcl(IDispatch* retval);
    HRESULT put_SystemAcl(IDispatch pSystemAcl);
    HRESULT get_SaclDefaulted(VARIANT_BOOL* retval);
    HRESULT put_SaclDefaulted(VARIANT_BOOL fSaclDefaulted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecuritydescriptor-copysecuritydescriptor
    HRESULT CopySecurityDescriptor(IDispatch* ppSecurityDescriptor);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadslargeinteger
@GUID("9068270b-0939-11d1-8be1-00c04fd8d503")
interface IADsLargeInteger : IDispatch
{
    HRESULT get_HighPart(int* retval);
    HRESULT put_HighPart(int lnHighPart);
    HRESULT get_LowPart(int* retval);
    HRESULT put_LowPart(int lnLowPart);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsnametranslate
@GUID("b1b272a3-3625-11d1-a3a4-00c04fb950dc")
interface IADsNameTranslate : IDispatch
{
    HRESULT put_ChaseReferral(int lnChaseReferral);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-init
    HRESULT Init(int lnSetType, BSTR bstrADsPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-initex
    HRESULT InitEx(int lnSetType, BSTR bstrADsPath, BSTR bstrUserID, BSTR bstrDomain, BSTR bstrPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-set
    HRESULT Set(int lnSetType, BSTR bstrADsPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-get
    HRESULT Get(int lnFormatType, BSTR* pbstrADsPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-setex
    HRESULT SetEx(int lnFormatType, VARIANT pvar);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsnametranslate-getex
    HRESULT GetEx(int lnFormatType, VARIANT* pvar);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadscaseignorelist
@GUID("7b66b533-4680-11d1-a3b4-00c04fb950dc")
interface IADsCaseIgnoreList : IDispatch
{
    HRESULT get_CaseIgnoreList(VARIANT* retval);
    HRESULT put_CaseIgnoreList(VARIANT vCaseIgnoreList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsfaxnumber
@GUID("a910dea9-4680-11d1-a3b4-00c04fb950dc")
interface IADsFaxNumber : IDispatch
{
    HRESULT get_TelephoneNumber(BSTR* retval);
    HRESULT put_TelephoneNumber(BSTR bstrTelephoneNumber);
    HRESULT get_Parameters(VARIANT* retval);
    HRESULT put_Parameters(VARIANT vParameters);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsnetaddress
@GUID("b21a50a9-4080-11d1-a3ac-00c04fb950dc")
interface IADsNetAddress : IDispatch
{
    HRESULT get_AddressType(int* retval);
    HRESULT put_AddressType(int lnAddressType);
    HRESULT get_Address(VARIANT* retval);
    HRESULT put_Address(VARIANT vAddress);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsoctetlist
@GUID("7b28b80f-4680-11d1-a3b4-00c04fb950dc")
interface IADsOctetList : IDispatch
{
    HRESULT get_OctetList(VARIANT* retval);
    HRESULT put_OctetList(VARIANT vOctetList);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsemail
@GUID("97af011a-478e-11d1-a3b4-00c04fb950dc")
interface IADsEmail : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_Address(BSTR* retval);
    HRESULT put_Address(BSTR bstrAddress);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspath
@GUID("b287fcd5-4080-11d1-a3ac-00c04fb950dc")
interface IADsPath : IDispatch
{
    HRESULT get_Type(int* retval);
    HRESULT put_Type(int lnType);
    HRESULT get_VolumeName(BSTR* retval);
    HRESULT put_VolumeName(BSTR bstrVolumeName);
    HRESULT get_Path(BSTR* retval);
    HRESULT put_Path(BSTR bstrPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsreplicapointer
@GUID("f60fb803-4080-11d1-a3ac-00c04fb950dc")
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

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsacl
@GUID("8452d3ab-0869-11d1-a377-00c04fb950dc")
interface IADsAcl : IDispatch
{
    HRESULT get_ProtectedAttrName(BSTR* retval);
    HRESULT put_ProtectedAttrName(BSTR bstrProtectedAttrName);
    HRESULT get_SubjectName(BSTR* retval);
    HRESULT put_SubjectName(BSTR bstrSubjectName);
    HRESULT get_Privileges(int* retval);
    HRESULT put_Privileges(int lnPrivileges);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsacl-copyacl
    HRESULT CopyAcl(IDispatch* ppAcl);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadstimestamp
@GUID("b2f5a901-4080-11d1-a3ac-00c04fb950dc")
interface IADsTimestamp : IDispatch
{
    HRESULT get_WholeSeconds(int* retval);
    HRESULT put_WholeSeconds(int lnWholeSeconds);
    HRESULT get_EventID(int* retval);
    HRESULT put_EventID(int lnEventID);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspostaladdress
@GUID("7adecf29-4680-11d1-a3b4-00c04fb950dc")
interface IADsPostalAddress : IDispatch
{
    HRESULT get_PostalAddress(VARIANT* retval);
    HRESULT put_PostalAddress(VARIANT vPostalAddress);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsbacklink
@GUID("fd1302bd-4080-11d1-a3ac-00c04fb950dc")
interface IADsBackLink : IDispatch
{
    HRESULT get_RemoteID(int* retval);
    HRESULT put_RemoteID(int lnRemoteID);
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadstypedname
@GUID("b371a349-4080-11d1-a3ac-00c04fb950dc")
interface IADsTypedName : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Level(int* retval);
    HRESULT put_Level(int lnLevel);
    HRESULT get_Interval(int* retval);
    HRESULT put_Interval(int lnInterval);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadshold
@GUID("b3eb3b37-4080-11d1-a3ac-00c04fb950dc")
interface IADsHold : IDispatch
{
    HRESULT get_ObjectName(BSTR* retval);
    HRESULT put_ObjectName(BSTR bstrObjectName);
    HRESULT get_Amount(int* retval);
    HRESULT put_Amount(int lnAmount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsobjectoptions
@GUID("46f14fda-232b-11d1-a808-00c04fd8d5a8")
interface IADsObjectOptions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsobjectoptions-getoption
    HRESULT GetOption(int lnOption, VARIANT* pvValue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsobjectoptions-setoption
    HRESULT SetOption(int lnOption, VARIANT vValue);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadspathname
@GUID("d592aed4-f420-11d0-a36e-00c04fb950dc")
interface IADsPathname : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-set
    HRESULT Set(BSTR bstrADsPath, int lnSetType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-setdisplaytype
    HRESULT SetDisplayType(int lnDisplayType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-retrieve
    HRESULT Retrieve(int lnFormatType, BSTR* pbstrADsPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-getnumelements
    HRESULT GetNumElements(int* plnNumPathElements);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-getelement
    HRESULT GetElement(int lnElementIndex, BSTR* pbstrElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-addleafelement
    HRESULT AddLeafElement(BSTR bstrLeafElement);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-removeleafelement
    HRESULT RemoveLeafElement();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-copypath
    HRESULT CopyPath(IDispatch* ppAdsPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadspathname-getescapedelement
    HRESULT GetEscapedElement(int lnReserved, BSTR bstrInStr, BSTR* pbstrOutStr);
    HRESULT get_EscapedMode(int* retval);
    HRESULT put_EscapedMode(int lnEscapedMode);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsadsysteminfo
@GUID("5bb11929-afd1-11d2-9cb9-0000f87a369e")
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
    HRESULT get_IsNativeMode(VARIANT_BOOL* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsadsysteminfo-getanydcname
    HRESULT GetAnyDCName(BSTR* pszDCName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsadsysteminfo-getdcsitename
    HRESULT GetDCSiteName(BSTR szServer, BSTR* pszSiteName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsadsysteminfo-refreshschemacache
    HRESULT RefreshSchemaCache();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadsadsysteminfo-gettrees
    HRESULT GetTrees(VARIANT* pvTrees);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadswinntsysteminfo
@GUID("6c6d65dc-afd1-11d2-9cb9-0000f87a369e")
interface IADsWinNTSystemInfo : IDispatch
{
    HRESULT get_UserName(BSTR* retval);
    HRESULT get_ComputerName(BSTR* retval);
    HRESULT get_DomainName(BSTR* retval);
    HRESULT get_PDC(BSTR* retval);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdnwithbinary
@GUID("7e99c0a2-f935-11d2-ba96-00c04fb6d0d1")
interface IADsDNWithBinary : IDispatch
{
    HRESULT get_BinaryValue(VARIANT* retval);
    HRESULT put_BinaryValue(VARIANT vBinaryValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadsdnwithstring
@GUID("370df02e-f934-11d2-ba96-00c04fb6d0d1")
interface IADsDNWithString : IDispatch
{
    HRESULT get_StringValue(BSTR* retval);
    HRESULT put_StringValue(BSTR bstrStringValue);
    HRESULT get_DNString(BSTR* retval);
    HRESULT put_DNString(BSTR bstrDNString);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nn-iads-iadssecurityutility
@GUID("a63251b2-5f21-474b-ab52-4a8efad10895")
interface IADsSecurityUtility : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecurityutility-getsecuritydescriptor
    HRESULT GetSecurityDescriptor(VARIANT varPath, int lPathFormat, int lFormat, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecurityutility-setsecuritydescriptor
    HRESULT SetSecurityDescriptor(VARIANT varPath, int lPathFormat, VARIANT varData, int lDataFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecurityutility-convertsecuritydescriptor
    HRESULT ConvertSecurityDescriptor(VARIANT varSD, int lDataFormat, int lOutFormat, VARIANT* pResult);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecurityutility-get_securitymask
    HRESULT get_SecurityMask(int* retval);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/iads/nf-iads-iadssecurityutility-put_securitymask
    HRESULT put_SecurityMask(int lnSecurityMask);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nn-dsclient-idsbrowsedomaintree
@GUID("7cabcf1e-78f5-11d2-960c-00c04fa31a86")
interface IDsBrowseDomainTree : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsbrowsedomaintree-browseto
    HRESULT BrowseTo(HWND hwndParent, PWSTR* ppszTargetPath, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsbrowsedomaintree-getdomains
    HRESULT GetDomains(DOMAIN_TREE** ppDomainTree, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsbrowsedomaintree-freedomains
    HRESULT FreeDomains(DOMAIN_TREE** ppDomainTree);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsbrowsedomaintree-flushcacheddomains
    HRESULT FlushCachedDomains();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsbrowsedomaintree-setcomputer
    HRESULT SetComputer(const(PWSTR) pszComputerName, const(PWSTR) pszUserName, const(PWSTR) pszPassword);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nn-dsclient-idsdisplayspecifier
@GUID("1ab4a8c0-6a0b-11d2-ad49-00c04fa31a86")
interface IDsDisplaySpecifier : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-setserver
    HRESULT SetServer(const(PWSTR) pszServer, const(PWSTR) pszUserName, const(PWSTR) pszPassword, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-setlanguageid
    HRESULT SetLanguageID(ushort langid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-getdisplayspecifier
    HRESULT GetDisplaySpecifier(const(PWSTR) pszObjectClass, const(GUID)* riid, void** ppv);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-geticonlocation
    HRESULT GetIconLocation(const(PWSTR) pszObjectClass, uint dwFlags, PWSTR pszBuffer, int cchBuffer, int* presid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-geticon
    HICON   GetIcon(const(PWSTR) pszObjectClass, uint dwFlags, int cxIcon, int cyIcon);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-getfriendlyclassname
    HRESULT GetFriendlyClassName(const(PWSTR) pszObjectClass, PWSTR pszBuffer, int cchBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-getfriendlyattributename
    HRESULT GetFriendlyAttributeName(const(PWSTR) pszObjectClass, const(PWSTR) pszAttributeName, PWSTR pszBuffer, 
                                     uint cchBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-isclasscontainer
    BOOL    IsClassContainer(const(PWSTR) pszObjectClass, const(PWSTR) pszADsPath, uint dwFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-getclasscreationinfo
    HRESULT GetClassCreationInfo(const(PWSTR) pszObjectClass, DSCLASSCREATIONINFO** ppdscci);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-enumclassattributes
    HRESULT EnumClassAttributes(const(PWSTR) pszObjectClass, LPDSENUMATTRIBUTES pcbEnum, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsclient/nf-dsclient-idsdisplayspecifier-getattributeadstype
    ADSTYPE GetAttributeADsType(const(PWSTR) pszAttributeName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/nn-objsel-idsobjectpicker
@GUID("0c87e64e-3b7a-11d2-b9e0-00c04fd8dbf7")
interface IDsObjectPicker : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/nf-objsel-idsobjectpicker-initialize
    HRESULT Initialize(DSOP_INIT_INFO* pInitInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/nf-objsel-idsobjectpicker-invokedialog
    HRESULT InvokeDialog(HWND hwndParent, IDataObject* ppdoSelections);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2008))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/nn-objsel-idsobjectpickercredentials
@GUID("e2d3ec9b-d041-445a-8f16-4748de8fb1cf")
interface IDsObjectPickerCredentials : IDsObjectPicker
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/objsel/nf-objsel-idsobjectpickercredentials-setcredentials
    HRESULT SetCredentials(const(PWSTR) szUserName, const(PWSTR) szPassword);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nn-dsadmin-idsadmincreateobj
@GUID("53554a38-f902-11d2-82b9-00c04f68928b")
interface IDsAdminCreateObj : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadmincreateobj-initialize
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(PWSTR) lpszClassName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadmincreateobj-createmodal
    HRESULT CreateModal(HWND hwndParent, IADs* ppADsObj);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nn-dsadmin-idsadminnewobj
@GUID("f2573587-e6fc-11d2-82af-00c04f68928b")
interface IDsAdminNewObj : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobj-setbuttons
    HRESULT SetButtons(uint nCurrIndex, BOOL bValid);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobj-getpagecounts
    HRESULT GetPageCounts(int* pnTotal, int* pnStartIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nn-dsadmin-idsadminnewobjprimarysite
@GUID("be2b487e-f904-11d2-82b9-00c04f68928b")
interface IDsAdminNewObjPrimarySite : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjprimarysite-createnew
    HRESULT CreateNew(const(PWSTR) pszName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjprimarysite-commit
    HRESULT Commit();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nn-dsadmin-idsadminnewobjext
@GUID("6088eae2-e7bf-11d2-82af-00c04f68928b")
interface IDsAdminNewObjExt : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-initialize
    HRESULT Initialize(IADsContainer pADsContainerObj, IADs pADsCopySource, const(PWSTR) lpszClassName, 
                       IDsAdminNewObj pDsAdminNewObj, DSA_NEWOBJ_DISPINFO* pDispInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-addpages
    HRESULT AddPages(LPFNSVADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-setobject
    HRESULT SetObject(IADs pADsObj);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-writedata
    HRESULT WriteData(HWND hWnd, uint uContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-onerror
    HRESULT OnError(HWND hWnd, HRESULT hr, uint uContext);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnewobjext-getsummaryinfo
    HRESULT GetSummaryInfo(BSTR* pBstrText);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nn-dsadmin-idsadminnotifyhandler
@GUID("e4a2b8b3-5a18-11d2-97c1-00a0c9a06d2d")
interface IDsAdminNotifyHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnotifyhandler-initialize
    HRESULT Initialize(IDataObject pExtraInfo, uint* puEventFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnotifyhandler-begin
    HRESULT Begin(uint uEvent, IDataObject pArg1, IDataObject pArg2, uint* puFlags, BSTR* pBstr);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnotifyhandler-notify
    HRESULT Notify(uint nItem, uint uFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dsadmin/nf-dsadmin-idsadminnotifyhandler-end
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

const GUID IID_IADs                       = GUIDOF!IADs;
const GUID IID_IADsADSystemInfo           = GUIDOF!IADsADSystemInfo;
const GUID IID_IADsAccessControlEntry     = GUIDOF!IADsAccessControlEntry;
const GUID IID_IADsAccessControlList      = GUIDOF!IADsAccessControlList;
const GUID IID_IADsAcl                    = GUIDOF!IADsAcl;
const GUID IID_IADsAggregatee             = GUIDOF!IADsAggregatee;
const GUID IID_IADsAggregator             = GUIDOF!IADsAggregator;
const GUID IID_IADsBackLink               = GUIDOF!IADsBackLink;
const GUID IID_IADsCaseIgnoreList         = GUIDOF!IADsCaseIgnoreList;
const GUID IID_IADsClass                  = GUIDOF!IADsClass;
const GUID IID_IADsCollection             = GUIDOF!IADsCollection;
const GUID IID_IADsComputer               = GUIDOF!IADsComputer;
const GUID IID_IADsComputerOperations     = GUIDOF!IADsComputerOperations;
const GUID IID_IADsContainer              = GUIDOF!IADsContainer;
const GUID IID_IADsDNWithBinary           = GUIDOF!IADsDNWithBinary;
const GUID IID_IADsDNWithString           = GUIDOF!IADsDNWithString;
const GUID IID_IADsDeleteOps              = GUIDOF!IADsDeleteOps;
const GUID IID_IADsDomain                 = GUIDOF!IADsDomain;
const GUID IID_IADsEmail                  = GUIDOF!IADsEmail;
const GUID IID_IADsExtension              = GUIDOF!IADsExtension;
const GUID IID_IADsFaxNumber              = GUIDOF!IADsFaxNumber;
const GUID IID_IADsFileService            = GUIDOF!IADsFileService;
const GUID IID_IADsFileServiceOperations  = GUIDOF!IADsFileServiceOperations;
const GUID IID_IADsFileShare              = GUIDOF!IADsFileShare;
const GUID IID_IADsGroup                  = GUIDOF!IADsGroup;
const GUID IID_IADsHold                   = GUIDOF!IADsHold;
const GUID IID_IADsLargeInteger           = GUIDOF!IADsLargeInteger;
const GUID IID_IADsLocality               = GUIDOF!IADsLocality;
const GUID IID_IADsMembers                = GUIDOF!IADsMembers;
const GUID IID_IADsNameTranslate          = GUIDOF!IADsNameTranslate;
const GUID IID_IADsNamespaces             = GUIDOF!IADsNamespaces;
const GUID IID_IADsNetAddress             = GUIDOF!IADsNetAddress;
const GUID IID_IADsO                      = GUIDOF!IADsO;
const GUID IID_IADsOU                     = GUIDOF!IADsOU;
const GUID IID_IADsObjectOptions          = GUIDOF!IADsObjectOptions;
const GUID IID_IADsOctetList              = GUIDOF!IADsOctetList;
const GUID IID_IADsOpenDSObject           = GUIDOF!IADsOpenDSObject;
const GUID IID_IADsPath                   = GUIDOF!IADsPath;
const GUID IID_IADsPathname               = GUIDOF!IADsPathname;
const GUID IID_IADsPostalAddress          = GUIDOF!IADsPostalAddress;
const GUID IID_IADsPrintJob               = GUIDOF!IADsPrintJob;
const GUID IID_IADsPrintJobOperations     = GUIDOF!IADsPrintJobOperations;
const GUID IID_IADsPrintQueue             = GUIDOF!IADsPrintQueue;
const GUID IID_IADsPrintQueueOperations   = GUIDOF!IADsPrintQueueOperations;
const GUID IID_IADsProperty               = GUIDOF!IADsProperty;
const GUID IID_IADsPropertyEntry          = GUIDOF!IADsPropertyEntry;
const GUID IID_IADsPropertyList           = GUIDOF!IADsPropertyList;
const GUID IID_IADsPropertyValue          = GUIDOF!IADsPropertyValue;
const GUID IID_IADsPropertyValue2         = GUIDOF!IADsPropertyValue2;
const GUID IID_IADsReplicaPointer         = GUIDOF!IADsReplicaPointer;
const GUID IID_IADsResource               = GUIDOF!IADsResource;
const GUID IID_IADsSecurityDescriptor     = GUIDOF!IADsSecurityDescriptor;
const GUID IID_IADsSecurityUtility        = GUIDOF!IADsSecurityUtility;
const GUID IID_IADsService                = GUIDOF!IADsService;
const GUID IID_IADsServiceOperations      = GUIDOF!IADsServiceOperations;
const GUID IID_IADsSession                = GUIDOF!IADsSession;
const GUID IID_IADsSyntax                 = GUIDOF!IADsSyntax;
const GUID IID_IADsTimestamp              = GUIDOF!IADsTimestamp;
const GUID IID_IADsTypedName              = GUIDOF!IADsTypedName;
const GUID IID_IADsUser                   = GUIDOF!IADsUser;
const GUID IID_IADsWinNTSystemInfo        = GUIDOF!IADsWinNTSystemInfo;
const GUID IID_ICommonQuery               = GUIDOF!ICommonQuery;
const GUID IID_IDirectoryObject           = GUIDOF!IDirectoryObject;
const GUID IID_IDirectorySchemaMgmt       = GUIDOF!IDirectorySchemaMgmt;
const GUID IID_IDirectorySearch           = GUIDOF!IDirectorySearch;
const GUID IID_IDsAdminCreateObj          = GUIDOF!IDsAdminCreateObj;
const GUID IID_IDsAdminNewObj             = GUIDOF!IDsAdminNewObj;
const GUID IID_IDsAdminNewObjExt          = GUIDOF!IDsAdminNewObjExt;
const GUID IID_IDsAdminNewObjPrimarySite  = GUIDOF!IDsAdminNewObjPrimarySite;
const GUID IID_IDsAdminNotifyHandler      = GUIDOF!IDsAdminNotifyHandler;
const GUID IID_IDsBrowseDomainTree        = GUIDOF!IDsBrowseDomainTree;
const GUID IID_IDsDisplaySpecifier        = GUIDOF!IDsDisplaySpecifier;
const GUID IID_IDsObjectPicker            = GUIDOF!IDsObjectPicker;
const GUID IID_IDsObjectPickerCredentials = GUIDOF!IDsObjectPickerCredentials;
const GUID IID_IPersistQuery              = GUIDOF!IPersistQuery;
const GUID IID_IPrivateDispatch           = GUIDOF!IPrivateDispatch;
const GUID IID_IPrivateUnknown            = GUIDOF!IPrivateUnknown;
const GUID IID_IQueryForm                 = GUIDOF!IQueryForm;
