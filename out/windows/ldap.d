module windows.ldap;

public import windows.security;
public import windows.systemservices;

extern(Windows):

enum LDAP_RETCODE
{
    LDAP_SUCCESS = 0,
    LDAP_OPERATIONS_ERROR = 1,
    LDAP_PROTOCOL_ERROR = 2,
    LDAP_TIMELIMIT_EXCEEDED = 3,
    LDAP_SIZELIMIT_EXCEEDED = 4,
    LDAP_COMPARE_FALSE = 5,
    LDAP_COMPARE_TRUE = 6,
    LDAP_AUTH_METHOD_NOT_SUPPORTED = 7,
    LDAP_STRONG_AUTH_REQUIRED = 8,
    LDAP_REFERRAL_V2 = 9,
    LDAP_PARTIAL_RESULTS = 9,
    LDAP_REFERRAL = 10,
    LDAP_ADMIN_LIMIT_EXCEEDED = 11,
    LDAP_UNAVAILABLE_CRIT_EXTENSION = 12,
    LDAP_CONFIDENTIALITY_REQUIRED = 13,
    LDAP_SASL_BIND_IN_PROGRESS = 14,
    LDAP_NO_SUCH_ATTRIBUTE = 16,
    LDAP_UNDEFINED_TYPE = 17,
    LDAP_INAPPROPRIATE_MATCHING = 18,
    LDAP_CONSTRAINT_VIOLATION = 19,
    LDAP_ATTRIBUTE_OR_VALUE_EXISTS = 20,
    LDAP_INVALID_SYNTAX = 21,
    LDAP_NO_SUCH_OBJECT = 32,
    LDAP_ALIAS_PROBLEM = 33,
    LDAP_INVALID_DN_SYNTAX = 34,
    LDAP_IS_LEAF = 35,
    LDAP_ALIAS_DEREF_PROBLEM = 36,
    LDAP_INAPPROPRIATE_AUTH = 48,
    LDAP_INVALID_CREDENTIALS = 49,
    LDAP_INSUFFICIENT_RIGHTS = 50,
    LDAP_BUSY = 51,
    LDAP_UNAVAILABLE = 52,
    LDAP_UNWILLING_TO_PERFORM = 53,
    LDAP_LOOP_DETECT = 54,
    LDAP_SORT_CONTROL_MISSING = 60,
    LDAP_OFFSET_RANGE_ERROR = 61,
    LDAP_NAMING_VIOLATION = 64,
    LDAP_OBJECT_CLASS_VIOLATION = 65,
    LDAP_NOT_ALLOWED_ON_NONLEAF = 66,
    LDAP_NOT_ALLOWED_ON_RDN = 67,
    LDAP_ALREADY_EXISTS = 68,
    LDAP_NO_OBJECT_CLASS_MODS = 69,
    LDAP_RESULTS_TOO_LARGE = 70,
    LDAP_AFFECTS_MULTIPLE_DSAS = 71,
    LDAP_VIRTUAL_LIST_VIEW_ERROR = 76,
    LDAP_OTHER = 80,
    LDAP_SERVER_DOWN = 81,
    LDAP_LOCAL_ERROR = 82,
    LDAP_ENCODING_ERROR = 83,
    LDAP_DECODING_ERROR = 84,
    LDAP_TIMEOUT = 85,
    LDAP_AUTH_UNKNOWN = 86,
    LDAP_FILTER_ERROR = 87,
    LDAP_USER_CANCELLED = 88,
    LDAP_PARAM_ERROR = 89,
    LDAP_NO_MEMORY = 90,
    LDAP_CONNECT_ERROR = 91,
    LDAP_NOT_SUPPORTED = 92,
    LDAP_NO_RESULTS_RETURNED = 94,
    LDAP_CONTROL_NOT_FOUND = 93,
    LDAP_MORE_RESULTS_TO_RETURN = 95,
    LDAP_CLIENT_LOOP = 96,
    LDAP_REFERRAL_LIMIT_EXCEEDED = 97,
}

struct ldap
{
    _ld_sb_e__Struct ld_sb;
    const(char)* ld_host;
    uint ld_version;
    ubyte ld_lberoptions;
    uint ld_deref;
    uint ld_timelimit;
    uint ld_sizelimit;
    uint ld_errno;
    const(char)* ld_matched;
    const(char)* ld_error;
    uint ld_msgid;
    ubyte Reserved3;
    uint ld_cldaptries;
    uint ld_cldaptimeout;
    uint ld_refhoplimit;
    uint ld_options;
}

struct LDAP_TIMEVAL
{
    int tv_sec;
    int tv_usec;
}

struct LDAP_BERVAL
{
    uint bv_len;
    const(char)* bv_val;
}

struct LDAPMessage
{
    uint lm_msgid;
    uint lm_msgtype;
    void* lm_ber;
    LDAPMessage* lm_chain;
    LDAPMessage* lm_next;
    uint lm_time;
    ldap* Connection;
    void* Request;
    uint lm_returncode;
    ushort lm_referral;
    ubyte lm_chased;
    ubyte lm_eom;
    ubyte ConnectionReferenced;
}

struct ldapcontrolA
{
    const(char)* ldctl_oid;
    LDAP_BERVAL ldctl_value;
    ubyte ldctl_iscritical;
}

struct ldapcontrolW
{
    const(wchar)* ldctl_oid;
    LDAP_BERVAL ldctl_value;
    ubyte ldctl_iscritical;
}

struct ldapmodW
{
    uint mod_op;
    const(wchar)* mod_type;
    _mod_vals_e__Union mod_vals;
}

struct ldapmodA
{
    uint mod_op;
    const(char)* mod_type;
    _mod_vals_e__Union mod_vals;
}

struct berelement
{
    const(char)* opaque;
}

struct ldap_version_info
{
    uint lv_size;
    uint lv_major;
    uint lv_minor;
}

struct ldapapiinfoA
{
    int ldapai_info_version;
    int ldapai_api_version;
    int ldapai_protocol_version;
    byte** ldapai_extensions;
    byte* ldapai_vendor_name;
    int ldapai_vendor_version;
}

struct ldapapiinfoW
{
    int ldapai_info_version;
    int ldapai_api_version;
    int ldapai_protocol_version;
    ushort** ldapai_extensions;
    const(wchar)* ldapai_vendor_name;
    int ldapai_vendor_version;
}

struct LDAPAPIFeatureInfoA
{
    int ldapaif_info_version;
    byte* ldapaif_name;
    int ldapaif_version;
}

struct LDAPAPIFeatureInfoW
{
    int ldapaif_info_version;
    const(wchar)* ldapaif_name;
    int ldapaif_version;
}

alias DBGPRINT = extern(Windows) uint function(const(char)* Format);
struct ldapsearch
{
}

struct ldapsortkeyW
{
    const(wchar)* sk_attrtype;
    const(wchar)* sk_matchruleoid;
    ubyte sk_reverseorder;
}

struct ldapsortkeyA
{
    const(char)* sk_attrtype;
    const(char)* sk_matchruleoid;
    ubyte sk_reverseorder;
}

struct ldapvlvinfo
{
    int ldvlv_version;
    uint ldvlv_before_count;
    uint ldvlv_after_count;
    uint ldvlv_offset;
    uint ldvlv_count;
    LDAP_BERVAL* ldvlv_attrvalue;
    LDAP_BERVAL* ldvlv_context;
    void* ldvlv_extradata;
}

alias QUERYFORCONNECTION = extern(Windows) uint function(ldap* PrimaryConnection, ldap* ReferralFromConnection, const(wchar)* NewDN, const(char)* HostName, uint PortNumber, void* SecAuthIdentity, void* CurrentUserToken, ldap** ConnectionToUse);
alias NOTIFYOFNEWCONNECTION = extern(Windows) ubyte function(ldap* PrimaryConnection, ldap* ReferralFromConnection, const(wchar)* NewDN, const(char)* HostName, ldap* NewConnection, uint PortNumber, void* SecAuthIdentity, void* CurrentUser, uint ErrorCodeFromBind);
alias DEREFERENCECONNECTION = extern(Windows) uint function(ldap* PrimaryConnection, ldap* ConnectionToDereference);
struct LDAP_REFERRAL_CALLBACK
{
    uint SizeOfCallbacks;
    QUERYFORCONNECTION* QueryForConnection;
    NOTIFYOFNEWCONNECTION* NotifyRoutine;
    DEREFERENCECONNECTION* DereferenceRoutine;
}

alias QUERYCLIENTCERT = extern(Windows) ubyte function(ldap* Connection, SecPkgContext_IssuerListInfoEx* trusted_CAs, CERT_CONTEXT** ppCertificate);
alias VERIFYSERVERCERT = extern(Windows) ubyte function(ldap* Connection, CERT_CONTEXT** pServerCert);
@DllImport("WLDAP32.dll")
ldap* ldap_openW(const(ushort)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_openA(const(byte)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_initW(const(ushort)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_initA(const(byte)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_sslinitW(const(wchar)* HostName, uint PortNumber, int secure);

@DllImport("WLDAP32.dll")
ldap* ldap_sslinitA(const(char)* HostName, uint PortNumber, int secure);

@DllImport("WLDAP32.dll")
uint ldap_connect(ldap* ld, LDAP_TIMEVAL* timeout);

@DllImport("WLDAP32.dll")
ldap* ldap_open(const(char)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_init(const(char)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* ldap_sslinit(const(char)* HostName, uint PortNumber, int secure);

@DllImport("WLDAP32.dll")
ldap* cldap_openW(const(wchar)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* cldap_openA(const(char)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
ldap* cldap_open(const(char)* HostName, uint PortNumber);

@DllImport("WLDAP32.dll")
uint ldap_unbind(ldap* ld);

@DllImport("WLDAP32.dll")
uint ldap_unbind_s(ldap* ld);

@DllImport("WLDAP32.dll")
uint ldap_get_option(ldap* ld, int option, void* outvalue);

@DllImport("WLDAP32.dll")
uint ldap_get_optionW(ldap* ld, int option, void* outvalue);

@DllImport("WLDAP32.dll")
uint ldap_set_option(ldap* ld, int option, const(void)* invalue);

@DllImport("WLDAP32.dll")
uint ldap_set_optionW(ldap* ld, int option, const(void)* invalue);

@DllImport("WLDAP32.dll")
uint ldap_simple_bindW(ldap* ld, const(wchar)* dn, const(wchar)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_simple_bindA(ldap* ld, const(char)* dn, const(char)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_simple_bind_sW(ldap* ld, const(wchar)* dn, const(wchar)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_simple_bind_sA(ldap* ld, const(char)* dn, const(char)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_bindW(ldap* ld, const(wchar)* dn, const(wchar)* cred, uint method);

@DllImport("WLDAP32.dll")
uint ldap_bindA(ldap* ld, const(char)* dn, const(char)* cred, uint method);

@DllImport("WLDAP32.dll")
uint ldap_bind_sW(ldap* ld, const(wchar)* dn, const(wchar)* cred, uint method);

@DllImport("WLDAP32.dll")
uint ldap_bind_sA(ldap* ld, const(char)* dn, const(char)* cred, uint method);

@DllImport("WLDAP32.dll")
int ldap_sasl_bindA(ldap* ExternalHandle, const(byte)* DistName, const(byte)* AuthMechanism, const(LDAP_BERVAL)* cred, ldapcontrolA** ServerCtrls, ldapcontrolA** ClientCtrls, int* MessageNumber);

@DllImport("WLDAP32.dll")
int ldap_sasl_bindW(ldap* ExternalHandle, const(ushort)* DistName, const(ushort)* AuthMechanism, const(LDAP_BERVAL)* cred, ldapcontrolW** ServerCtrls, ldapcontrolW** ClientCtrls, int* MessageNumber);

@DllImport("WLDAP32.dll")
int ldap_sasl_bind_sA(ldap* ExternalHandle, const(byte)* DistName, const(byte)* AuthMechanism, const(LDAP_BERVAL)* cred, ldapcontrolA** ServerCtrls, ldapcontrolA** ClientCtrls, LDAP_BERVAL** ServerData);

@DllImport("WLDAP32.dll")
int ldap_sasl_bind_sW(ldap* ExternalHandle, const(ushort)* DistName, const(ushort)* AuthMechanism, const(LDAP_BERVAL)* cred, ldapcontrolW** ServerCtrls, ldapcontrolW** ClientCtrls, LDAP_BERVAL** ServerData);

@DllImport("WLDAP32.dll")
uint ldap_simple_bind(ldap* ld, const(byte)* dn, const(byte)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_simple_bind_s(ldap* ld, const(byte)* dn, const(byte)* passwd);

@DllImport("WLDAP32.dll")
uint ldap_bind(ldap* ld, const(byte)* dn, const(byte)* cred, uint method);

@DllImport("WLDAP32.dll")
uint ldap_bind_s(ldap* ld, const(byte)* dn, const(byte)* cred, uint method);

@DllImport("WLDAP32.dll")
uint ldap_searchW(ldap* ld, const(ushort)* base, uint scope, const(ushort)* filter, ushort** attrs, uint attrsonly);

@DllImport("WLDAP32.dll")
uint ldap_searchA(ldap* ld, const(byte)* base, uint scope, const(byte)* filter, byte** attrs, uint attrsonly);

@DllImport("WLDAP32.dll")
uint ldap_search_sW(ldap* ld, const(ushort)* base, uint scope, const(ushort)* filter, ushort** attrs, uint attrsonly, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_sA(ldap* ld, const(byte)* base, uint scope, const(byte)* filter, byte** attrs, uint attrsonly, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_stW(ldap* ld, const(ushort)* base, uint scope, const(ushort)* filter, ushort** attrs, uint attrsonly, LDAP_TIMEVAL* timeout, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_stA(ldap* ld, const(byte)* base, uint scope, const(byte)* filter, byte** attrs, uint attrsonly, LDAP_TIMEVAL* timeout, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_extW(ldap* ld, const(ushort)* base, uint scope, const(ushort)* filter, ushort** attrs, uint attrsonly, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint TimeLimit, uint SizeLimit, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_search_extA(ldap* ld, const(byte)* base, uint scope, const(byte)* filter, byte** attrs, uint attrsonly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint TimeLimit, uint SizeLimit, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_search_ext_sW(ldap* ld, const(ushort)* base, uint scope, const(ushort)* filter, ushort** attrs, uint attrsonly, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, LDAP_TIMEVAL* timeout, uint SizeLimit, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_ext_sA(ldap* ld, const(byte)* base, uint scope, const(byte)* filter, byte** attrs, uint attrsonly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, LDAP_TIMEVAL* timeout, uint SizeLimit, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search(ldap* ld, const(char)* base, uint scope, const(char)* filter, byte** attrs, uint attrsonly);

@DllImport("WLDAP32.dll")
uint ldap_search_s(ldap* ld, const(char)* base, uint scope, const(char)* filter, byte** attrs, uint attrsonly, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_st(ldap* ld, const(char)* base, uint scope, const(char)* filter, byte** attrs, uint attrsonly, LDAP_TIMEVAL* timeout, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_search_ext(ldap* ld, const(char)* base, uint scope, const(char)* filter, byte** attrs, uint attrsonly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint TimeLimit, uint SizeLimit, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_search_ext_s(ldap* ld, const(char)* base, uint scope, const(char)* filter, byte** attrs, uint attrsonly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, LDAP_TIMEVAL* timeout, uint SizeLimit, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_check_filterW(ldap* ld, const(wchar)* SearchFilter);

@DllImport("WLDAP32.dll")
uint ldap_check_filterA(ldap* ld, const(char)* SearchFilter);

@DllImport("WLDAP32.dll")
uint ldap_modifyW(ldap* ld, const(wchar)* dn, ldapmodW** mods);

@DllImport("WLDAP32.dll")
uint ldap_modifyA(ldap* ld, const(char)* dn, ldapmodA** mods);

@DllImport("WLDAP32.dll")
uint ldap_modify_sW(ldap* ld, const(wchar)* dn, ldapmodW** mods);

@DllImport("WLDAP32.dll")
uint ldap_modify_sA(ldap* ld, const(char)* dn, ldapmodA** mods);

@DllImport("WLDAP32.dll")
uint ldap_modify_extW(ldap* ld, const(ushort)* dn, ldapmodW** mods, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_modify_extA(ldap* ld, const(byte)* dn, ldapmodA** mods, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_modify_ext_sW(ldap* ld, const(ushort)* dn, ldapmodW** mods, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_modify_ext_sA(ldap* ld, const(byte)* dn, ldapmodA** mods, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_modify(ldap* ld, const(char)* dn, ldapmodA** mods);

@DllImport("WLDAP32.dll")
uint ldap_modify_s(ldap* ld, const(char)* dn, ldapmodA** mods);

@DllImport("WLDAP32.dll")
uint ldap_modify_ext(ldap* ld, const(byte)* dn, ldapmodA** mods, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_modify_ext_s(ldap* ld, const(byte)* dn, ldapmodA** mods, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2W(ldap* ExternalHandle, const(ushort)* DistinguishedName, const(ushort)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2A(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdnW(ldap* ExternalHandle, const(ushort)* DistinguishedName, const(ushort)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_modrdnA(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2_sW(ldap* ExternalHandle, const(ushort)* DistinguishedName, const(ushort)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2_sA(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdn_sW(ldap* ExternalHandle, const(ushort)* DistinguishedName, const(ushort)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_modrdn_sA(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdn(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_modrdn2_s(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName, int DeleteOldRdn);

@DllImport("WLDAP32.dll")
uint ldap_modrdn_s(ldap* ExternalHandle, const(byte)* DistinguishedName, const(byte)* NewDistinguishedName);

@DllImport("WLDAP32.dll")
uint ldap_rename_extW(ldap* ld, const(ushort)* dn, const(ushort)* NewRDN, const(ushort)* NewParent, int DeleteOldRdn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_rename_extA(ldap* ld, const(byte)* dn, const(byte)* NewRDN, const(byte)* NewParent, int DeleteOldRdn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_rename_ext_sW(ldap* ld, const(ushort)* dn, const(ushort)* NewRDN, const(ushort)* NewParent, int DeleteOldRdn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_rename_ext_sA(ldap* ld, const(byte)* dn, const(byte)* NewRDN, const(byte)* NewParent, int DeleteOldRdn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_rename_ext(ldap* ld, const(byte)* dn, const(byte)* NewRDN, const(byte)* NewParent, int DeleteOldRdn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_rename_ext_s(ldap* ld, const(byte)* dn, const(byte)* NewRDN, const(byte)* NewParent, int DeleteOldRdn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_addW(ldap* ld, const(wchar)* dn, ldapmodW** attrs);

@DllImport("WLDAP32.dll")
uint ldap_addA(ldap* ld, const(char)* dn, ldapmodA** attrs);

@DllImport("WLDAP32.dll")
uint ldap_add_sW(ldap* ld, const(wchar)* dn, ldapmodW** attrs);

@DllImport("WLDAP32.dll")
uint ldap_add_sA(ldap* ld, const(char)* dn, ldapmodA** attrs);

@DllImport("WLDAP32.dll")
uint ldap_add_extW(ldap* ld, const(ushort)* dn, ldapmodW** attrs, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_add_extA(ldap* ld, const(byte)* dn, ldapmodA** attrs, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_add_ext_sW(ldap* ld, const(ushort)* dn, ldapmodW** attrs, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_add_ext_sA(ldap* ld, const(byte)* dn, ldapmodA** attrs, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_add(ldap* ld, const(char)* dn, ldapmodA** attrs);

@DllImport("WLDAP32.dll")
uint ldap_add_s(ldap* ld, const(char)* dn, ldapmodA** attrs);

@DllImport("WLDAP32.dll")
uint ldap_add_ext(ldap* ld, const(byte)* dn, ldapmodA** attrs, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_add_ext_s(ldap* ld, const(byte)* dn, ldapmodA** attrs, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_compareW(ldap* ld, const(ushort)* dn, const(ushort)* attr, const(wchar)* value);

@DllImport("WLDAP32.dll")
uint ldap_compareA(ldap* ld, const(byte)* dn, const(byte)* attr, const(char)* value);

@DllImport("WLDAP32.dll")
uint ldap_compare_sW(ldap* ld, const(ushort)* dn, const(ushort)* attr, const(wchar)* value);

@DllImport("WLDAP32.dll")
uint ldap_compare_sA(ldap* ld, const(byte)* dn, const(byte)* attr, const(char)* value);

@DllImport("WLDAP32.dll")
uint ldap_compare(ldap* ld, const(byte)* dn, const(byte)* attr, const(char)* value);

@DllImport("WLDAP32.dll")
uint ldap_compare_s(ldap* ld, const(byte)* dn, const(byte)* attr, const(char)* value);

@DllImport("WLDAP32.dll")
uint ldap_compare_extW(ldap* ld, const(ushort)* dn, const(ushort)* Attr, const(ushort)* Value, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_compare_extA(ldap* ld, const(byte)* dn, const(byte)* Attr, const(byte)* Value, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_compare_ext_sW(ldap* ld, const(ushort)* dn, const(ushort)* Attr, const(ushort)* Value, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_compare_ext_sA(ldap* ld, const(byte)* dn, const(byte)* Attr, const(byte)* Value, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_compare_ext(ldap* ld, const(byte)* dn, const(byte)* Attr, const(byte)* Value, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_compare_ext_s(ldap* ld, const(byte)* dn, const(byte)* Attr, const(byte)* Value, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_deleteW(ldap* ld, const(ushort)* dn);

@DllImport("WLDAP32.dll")
uint ldap_deleteA(ldap* ld, const(byte)* dn);

@DllImport("WLDAP32.dll")
uint ldap_delete_sW(ldap* ld, const(ushort)* dn);

@DllImport("WLDAP32.dll")
uint ldap_delete_sA(ldap* ld, const(byte)* dn);

@DllImport("WLDAP32.dll")
uint ldap_delete_extW(ldap* ld, const(ushort)* dn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_delete_extA(ldap* ld, const(byte)* dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_delete_ext_sW(ldap* ld, const(ushort)* dn, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_delete_ext_sA(ldap* ld, const(byte)* dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_delete(ldap* ld, const(char)* dn);

@DllImport("WLDAP32.dll")
uint ldap_delete_s(ldap* ld, const(char)* dn);

@DllImport("WLDAP32.dll")
uint ldap_delete_ext(ldap* ld, const(byte)* dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_delete_ext_s(ldap* ld, const(byte)* dn, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_abandon(ldap* ld, uint msgid);

@DllImport("WLDAP32.dll")
uint ldap_result(ldap* ld, uint msgid, uint all, LDAP_TIMEVAL* timeout, LDAPMessage** res);

@DllImport("WLDAP32.dll")
uint ldap_msgfree(LDAPMessage* res);

@DllImport("WLDAP32.dll")
uint ldap_result2error(ldap* ld, LDAPMessage* res, uint freeit);

@DllImport("WLDAP32.dll")
uint ldap_parse_resultW(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, ushort** MatchedDNs, ushort** ErrorMessage, ushort*** Referrals, ldapcontrolW*** ServerControls, ubyte Freeit);

@DllImport("WLDAP32.dll")
uint ldap_parse_resultA(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, byte** MatchedDNs, byte** ErrorMessage, byte*** Referrals, ldapcontrolA*** ServerControls, ubyte Freeit);

@DllImport("WLDAP32.dll")
uint ldap_parse_extended_resultA(ldap* Connection, LDAPMessage* ResultMessage, byte** ResultOID, LDAP_BERVAL** ResultData, ubyte Freeit);

@DllImport("WLDAP32.dll")
uint ldap_parse_extended_resultW(ldap* Connection, LDAPMessage* ResultMessage, ushort** ResultOID, LDAP_BERVAL** ResultData, ubyte Freeit);

@DllImport("WLDAP32.dll")
uint ldap_controls_freeA(ldapcontrolA** Controls);

@DllImport("WLDAP32.dll")
uint ldap_control_freeA(ldapcontrolA* Controls);

@DllImport("WLDAP32.dll")
uint ldap_controls_freeW(ldapcontrolW** Control);

@DllImport("WLDAP32.dll")
uint ldap_control_freeW(ldapcontrolW* Control);

@DllImport("WLDAP32.dll")
uint ldap_free_controlsW(ldapcontrolW** Controls);

@DllImport("WLDAP32.dll")
uint ldap_free_controlsA(ldapcontrolA** Controls);

@DllImport("WLDAP32.dll")
uint ldap_parse_result(ldap* Connection, LDAPMessage* ResultMessage, uint* ReturnCode, byte** MatchedDNs, byte** ErrorMessage, byte*** Referrals, ldapcontrolA*** ServerControls, ubyte Freeit);

@DllImport("WLDAP32.dll")
uint ldap_controls_free(ldapcontrolA** Controls);

@DllImport("WLDAP32.dll")
uint ldap_control_free(ldapcontrolA* Control);

@DllImport("WLDAP32.dll")
uint ldap_free_controls(ldapcontrolA** Controls);

@DllImport("WLDAP32.dll")
ushort* ldap_err2stringW(uint err);

@DllImport("WLDAP32.dll")
byte* ldap_err2stringA(uint err);

@DllImport("WLDAP32.dll")
byte* ldap_err2string(uint err);

@DllImport("WLDAP32.dll")
void ldap_perror(ldap* ld, const(byte)* msg);

@DllImport("WLDAP32.dll")
LDAPMessage* ldap_first_entry(ldap* ld, LDAPMessage* res);

@DllImport("WLDAP32.dll")
LDAPMessage* ldap_next_entry(ldap* ld, LDAPMessage* entry);

@DllImport("WLDAP32.dll")
uint ldap_count_entries(ldap* ld, LDAPMessage* res);

@DllImport("WLDAP32.dll")
ushort* ldap_first_attributeW(ldap* ld, LDAPMessage* entry, berelement** ptr);

@DllImport("WLDAP32.dll")
byte* ldap_first_attributeA(ldap* ld, LDAPMessage* entry, berelement** ptr);

@DllImport("WLDAP32.dll")
byte* ldap_first_attribute(ldap* ld, LDAPMessage* entry, berelement** ptr);

@DllImport("WLDAP32.dll")
ushort* ldap_next_attributeW(ldap* ld, LDAPMessage* entry, berelement* ptr);

@DllImport("WLDAP32.dll")
byte* ldap_next_attributeA(ldap* ld, LDAPMessage* entry, berelement* ptr);

@DllImport("WLDAP32.dll")
byte* ldap_next_attribute(ldap* ld, LDAPMessage* entry, berelement* ptr);

@DllImport("WLDAP32.dll")
ushort** ldap_get_valuesW(ldap* ld, LDAPMessage* entry, const(ushort)* attr);

@DllImport("WLDAP32.dll")
byte** ldap_get_valuesA(ldap* ld, LDAPMessage* entry, const(byte)* attr);

@DllImport("WLDAP32.dll")
byte** ldap_get_values(ldap* ld, LDAPMessage* entry, const(byte)* attr);

@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_lenW(ldap* ExternalHandle, LDAPMessage* Message, const(ushort)* attr);

@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_lenA(ldap* ExternalHandle, LDAPMessage* Message, const(byte)* attr);

@DllImport("WLDAP32.dll")
LDAP_BERVAL** ldap_get_values_len(ldap* ExternalHandle, LDAPMessage* Message, const(byte)* attr);

@DllImport("WLDAP32.dll")
uint ldap_count_valuesW(ushort** vals);

@DllImport("WLDAP32.dll")
uint ldap_count_valuesA(byte** vals);

@DllImport("WLDAP32.dll")
uint ldap_count_values(byte** vals);

@DllImport("WLDAP32.dll")
uint ldap_count_values_len(LDAP_BERVAL** vals);

@DllImport("WLDAP32.dll")
uint ldap_value_freeW(ushort** vals);

@DllImport("WLDAP32.dll")
uint ldap_value_freeA(byte** vals);

@DllImport("WLDAP32.dll")
uint ldap_value_free(byte** vals);

@DllImport("WLDAP32.dll")
uint ldap_value_free_len(LDAP_BERVAL** vals);

@DllImport("WLDAP32.dll")
ushort* ldap_get_dnW(ldap* ld, LDAPMessage* entry);

@DllImport("WLDAP32.dll")
byte* ldap_get_dnA(ldap* ld, LDAPMessage* entry);

@DllImport("WLDAP32.dll")
byte* ldap_get_dn(ldap* ld, LDAPMessage* entry);

@DllImport("WLDAP32.dll")
ushort** ldap_explode_dnW(const(ushort)* dn, uint notypes);

@DllImport("WLDAP32.dll")
byte** ldap_explode_dnA(const(byte)* dn, uint notypes);

@DllImport("WLDAP32.dll")
byte** ldap_explode_dn(const(byte)* dn, uint notypes);

@DllImport("WLDAP32.dll")
ushort* ldap_dn2ufnW(const(ushort)* dn);

@DllImport("WLDAP32.dll")
byte* ldap_dn2ufnA(const(byte)* dn);

@DllImport("WLDAP32.dll")
byte* ldap_dn2ufn(const(byte)* dn);

@DllImport("WLDAP32.dll")
void ldap_memfreeW(const(wchar)* Block);

@DllImport("WLDAP32.dll")
void ldap_memfreeA(const(char)* Block);

@DllImport("WLDAP32.dll")
void ber_bvfree(LDAP_BERVAL* bv);

@DllImport("WLDAP32.dll")
void ldap_memfree(const(char)* Block);

@DllImport("WLDAP32.dll")
uint ldap_ufn2dnW(const(ushort)* ufn, ushort** pDn);

@DllImport("WLDAP32.dll")
uint ldap_ufn2dnA(const(byte)* ufn, byte** pDn);

@DllImport("WLDAP32.dll")
uint ldap_ufn2dn(const(byte)* ufn, byte** pDn);

@DllImport("WLDAP32.dll")
uint ldap_startup(ldap_version_info* version, HANDLE* Instance);

@DllImport("WLDAP32.dll")
uint ldap_cleanup(HANDLE hInstance);

@DllImport("WLDAP32.dll")
uint ldap_escape_filter_elementW(const(char)* sourceFilterElement, uint sourceLength, const(wchar)* destFilterElement, uint destLength);

@DllImport("WLDAP32.dll")
uint ldap_escape_filter_elementA(const(char)* sourceFilterElement, uint sourceLength, const(char)* destFilterElement, uint destLength);

@DllImport("WLDAP32.dll")
uint ldap_escape_filter_element(const(char)* sourceFilterElement, uint sourceLength, const(char)* destFilterElement, uint destLength);

@DllImport("WLDAP32.dll")
uint ldap_set_dbg_flags(uint NewFlags);

@DllImport("WLDAP32.dll")
void ldap_set_dbg_routine(DBGPRINT DebugPrintRoutine);

@DllImport("WLDAP32.dll")
int LdapUTF8ToUnicode(const(char)* lpSrcStr, int cchSrc, const(wchar)* lpDestStr, int cchDest);

@DllImport("WLDAP32.dll")
int LdapUnicodeToUTF8(const(wchar)* lpSrcStr, int cchSrc, const(char)* lpDestStr, int cchDest);

@DllImport("WLDAP32.dll")
uint ldap_create_sort_controlA(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ubyte IsCritical, ldapcontrolA** Control);

@DllImport("WLDAP32.dll")
uint ldap_create_sort_controlW(ldap* ExternalHandle, ldapsortkeyW** SortKeys, ubyte IsCritical, ldapcontrolW** Control);

@DllImport("WLDAP32.dll")
uint ldap_parse_sort_controlA(ldap* ExternalHandle, ldapcontrolA** Control, uint* Result, byte** Attribute);

@DllImport("WLDAP32.dll")
uint ldap_parse_sort_controlW(ldap* ExternalHandle, ldapcontrolW** Control, uint* Result, ushort** Attribute);

@DllImport("WLDAP32.dll")
uint ldap_create_sort_control(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ubyte IsCritical, ldapcontrolA** Control);

@DllImport("WLDAP32.dll")
uint ldap_parse_sort_control(ldap* ExternalHandle, ldapcontrolA** Control, uint* Result, byte** Attribute);

@DllImport("WLDAP32.dll")
uint ldap_encode_sort_controlW(ldap* ExternalHandle, ldapsortkeyW** SortKeys, ldapcontrolW* Control, ubyte Criticality);

@DllImport("WLDAP32.dll")
uint ldap_encode_sort_controlA(ldap* ExternalHandle, ldapsortkeyA** SortKeys, ldapcontrolA* Control, ubyte Criticality);

@DllImport("WLDAP32.dll")
uint ldap_create_page_controlW(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, ldapcontrolW** Control);

@DllImport("WLDAP32.dll")
uint ldap_create_page_controlA(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, ldapcontrolA** Control);

@DllImport("WLDAP32.dll")
uint ldap_parse_page_controlW(ldap* ExternalHandle, ldapcontrolW** ServerControls, uint* TotalCount, LDAP_BERVAL** Cookie);

@DllImport("WLDAP32.dll")
uint ldap_parse_page_controlA(ldap* ExternalHandle, ldapcontrolA** ServerControls, uint* TotalCount, LDAP_BERVAL** Cookie);

@DllImport("WLDAP32.dll")
uint ldap_create_page_control(ldap* ExternalHandle, uint PageSize, LDAP_BERVAL* Cookie, ubyte IsCritical, ldapcontrolA** Control);

@DllImport("WLDAP32.dll")
uint ldap_parse_page_control(ldap* ExternalHandle, ldapcontrolA** ServerControls, uint* TotalCount, LDAP_BERVAL** Cookie);

@DllImport("WLDAP32.dll")
ldapsearch* ldap_search_init_pageW(ldap* ExternalHandle, const(ushort)* DistinguishedName, uint ScopeOfSearch, const(ushort)* SearchFilter, ushort** AttributeList, uint AttributesOnly, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint PageTimeLimit, uint TotalSizeLimit, ldapsortkeyW** SortKeys);

@DllImport("WLDAP32.dll")
ldapsearch* ldap_search_init_pageA(ldap* ExternalHandle, const(byte)* DistinguishedName, uint ScopeOfSearch, const(byte)* SearchFilter, byte** AttributeList, uint AttributesOnly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint PageTimeLimit, uint TotalSizeLimit, ldapsortkeyA** SortKeys);

@DllImport("WLDAP32.dll")
ldapsearch* ldap_search_init_page(ldap* ExternalHandle, const(byte)* DistinguishedName, uint ScopeOfSearch, const(byte)* SearchFilter, byte** AttributeList, uint AttributesOnly, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint PageTimeLimit, uint TotalSizeLimit, ldapsortkeyA** SortKeys);

@DllImport("WLDAP32.dll")
uint ldap_get_next_page(ldap* ExternalHandle, ldapsearch* SearchHandle, uint PageSize, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_get_next_page_s(ldap* ExternalHandle, ldapsearch* SearchHandle, LDAP_TIMEVAL* timeout, uint PageSize, uint* TotalCount, LDAPMessage** Results);

@DllImport("WLDAP32.dll")
uint ldap_get_paged_count(ldap* ExternalHandle, ldapsearch* SearchBlock, uint* TotalCount, LDAPMessage* Results);

@DllImport("WLDAP32.dll")
uint ldap_search_abandon_page(ldap* ExternalHandle, ldapsearch* SearchBlock);

@DllImport("WLDAP32.dll")
int ldap_create_vlv_controlW(ldap* ExternalHandle, ldapvlvinfo* VlvInfo, ubyte IsCritical, ldapcontrolW** Control);

@DllImport("WLDAP32.dll")
int ldap_create_vlv_controlA(ldap* ExternalHandle, ldapvlvinfo* VlvInfo, ubyte IsCritical, ldapcontrolA** Control);

@DllImport("WLDAP32.dll")
int ldap_parse_vlv_controlW(ldap* ExternalHandle, ldapcontrolW** Control, uint* TargetPos, uint* ListCount, LDAP_BERVAL** Context, int* ErrCode);

@DllImport("WLDAP32.dll")
int ldap_parse_vlv_controlA(ldap* ExternalHandle, ldapcontrolA** Control, uint* TargetPos, uint* ListCount, LDAP_BERVAL** Context, int* ErrCode);

@DllImport("WLDAP32.dll")
uint ldap_start_tls_sW(ldap* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls);

@DllImport("WLDAP32.dll")
uint ldap_start_tls_sA(ldap* ExternalHandle, uint* ServerReturnValue, LDAPMessage** result, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls);

@DllImport("WLDAP32.dll")
ubyte ldap_stop_tls_s(ldap* ExternalHandle);

@DllImport("WLDAP32.dll")
LDAPMessage* ldap_first_reference(ldap* ld, LDAPMessage* res);

@DllImport("WLDAP32.dll")
LDAPMessage* ldap_next_reference(ldap* ld, LDAPMessage* entry);

@DllImport("WLDAP32.dll")
uint ldap_count_references(ldap* ld, LDAPMessage* res);

@DllImport("WLDAP32.dll")
uint ldap_parse_referenceW(ldap* Connection, LDAPMessage* ResultMessage, ushort*** Referrals);

@DllImport("WLDAP32.dll")
uint ldap_parse_referenceA(ldap* Connection, LDAPMessage* ResultMessage, byte*** Referrals);

@DllImport("WLDAP32.dll")
uint ldap_parse_reference(ldap* Connection, LDAPMessage* ResultMessage, byte*** Referrals);

@DllImport("WLDAP32.dll")
uint ldap_extended_operationW(ldap* ld, const(ushort)* Oid, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_extended_operationA(ldap* ld, const(byte)* Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_extended_operation_sA(ldap* ExternalHandle, const(char)* Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, byte** ReturnedOid, LDAP_BERVAL** ReturnedData);

@DllImport("WLDAP32.dll")
uint ldap_extended_operation_sW(ldap* ExternalHandle, const(wchar)* Oid, LDAP_BERVAL* Data, ldapcontrolW** ServerControls, ldapcontrolW** ClientControls, ushort** ReturnedOid, LDAP_BERVAL** ReturnedData);

@DllImport("WLDAP32.dll")
uint ldap_extended_operation(ldap* ld, const(byte)* Oid, LDAP_BERVAL* Data, ldapcontrolA** ServerControls, ldapcontrolA** ClientControls, uint* MessageNumber);

@DllImport("WLDAP32.dll")
uint ldap_close_extended_op(ldap* ld, uint MessageNumber);

@DllImport("WLDAP32.dll")
uint LdapGetLastError();

@DllImport("WLDAP32.dll")
uint LdapMapErrorToWin32(uint LdapError);

@DllImport("WLDAP32.dll")
ldap* ldap_conn_from_msg(ldap* PrimaryConn, LDAPMessage* res);

@DllImport("WLDAP32.dll")
berelement* ber_init(LDAP_BERVAL* pBerVal);

@DllImport("WLDAP32.dll")
void ber_free(berelement* pBerElement, int fbuf);

@DllImport("WLDAP32.dll")
void ber_bvecfree(LDAP_BERVAL** pBerVal);

@DllImport("WLDAP32.dll")
LDAP_BERVAL* ber_bvdup(LDAP_BERVAL* pBerVal);

@DllImport("WLDAP32.dll")
berelement* ber_alloc_t(int options);

@DllImport("WLDAP32.dll")
uint ber_skip_tag(berelement* pBerElement, uint* pLen);

@DllImport("WLDAP32.dll")
uint ber_peek_tag(berelement* pBerElement, uint* pLen);

@DllImport("WLDAP32.dll")
uint ber_first_element(berelement* pBerElement, uint* pLen, byte** ppOpaque);

@DllImport("WLDAP32.dll")
uint ber_next_element(berelement* pBerElement, uint* pLen, byte* opaque);

@DllImport("WLDAP32.dll")
int ber_flatten(berelement* pBerElement, LDAP_BERVAL** pBerVal);

@DllImport("WLDAP32.dll")
int ber_printf(berelement* pBerElement, const(char)* fmt);

@DllImport("WLDAP32.dll")
uint ber_scanf(berelement* pBerElement, const(char)* fmt);

