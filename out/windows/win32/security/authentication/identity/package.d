// Written in the D programming language.

module windows.win32.security.authentication.identity;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FILETIME, HANDLE,
                                         HRESULT, HWND, LUID, NTSTATUS, PSTR,
                                         PWSTR;
public import windows.win32.security : ACL;
public import windows.win32.security.credentials : CREDENTIALW, CREDENTIAL_TARGET_INFORMATIONW,
                                                   SecHandle;
public import windows.win32.security.cryptography : ALG_ID, CERT_CONTEXT, CRYPT_INTEGER_BLOB,
                                                    HCERTSTORE;
public import windows.win32.security : OBJECT_SECURITY_INFORMATION, PSECURITY_DESCRIPTOR, PSID,
                                       QUOTA_LIMITS, SECURITY_ATTRIBUTES,
                                       SECURITY_IMPERSONATION_LEVEL, SID_NAME_USE,
                                       TOKEN_DEFAULT_DACL, TOKEN_DEVICE_CLAIMS,
                                       TOKEN_GROUPS, TOKEN_OWNER, TOKEN_PRIMARY_GROUP,
                                       TOKEN_PRIVILEGES, TOKEN_SOURCE, TOKEN_USER,
                                       TOKEN_USER_CLAIMS;
public import windows.win32.system.com : IUnknown;
public import windows.win32.system.kernel : LIST_ENTRY;
public import windows.win32.system.passwordmanagement : CYPHER_BLOCK, LM_OWF_PASSWORD;
public import windows.win32.system.rpc : SEC_WINNT_AUTH_IDENTITY_A, SEC_WINNT_AUTH_IDENTITY_W;
public import windows.win32.system.threading : LPTHREAD_START_ROUTINE;

extern(Windows) @nogc nothrow:


// Enums


alias SECPKG_ATTR = uint;
enum : uint
{
    SECPKG_ATTR_C_ACCESS_TOKEN              = 0x80000012U,
    SECPKG_ATTR_C_FULL_ACCESS_TOKEN         = 0x80000082U,
    SECPKG_ATTR_CERT_TRUST_STATUS           = 0x80000084U,
    SECPKG_ATTR_CREDS                       = 0x80000080U,
    SECPKG_ATTR_CREDS_2                     = 0x80000086U,
    SECPKG_ATTR_NEGOTIATION_PACKAGE         = 0x80000081U,
    SECPKG_ATTR_PACKAGE_INFO                = 0x0000000aU,
    SECPKG_ATTR_SERVER_AUTH_FLAGS           = 0x80000083U,
    SECPKG_ATTR_SIZES                       = 0x00000000U,
    SECPKG_ATTR_SUBJECT_SECURITY_ATTRIBUTES = 0x0000007cU,
    SECPKG_ATTR_APP_DATA                    = 0x0000005eU,
    SECPKG_ATTR_EAP_PRF_INFO                = 0x00000065U,
    SECPKG_ATTR_EARLY_START                 = 0x00000069U,
    SECPKG_ATTR_DTLS_MTU                    = 0x00000022U,
    SECPKG_ATTR_KEYING_MATERIAL_INFO        = 0x0000006aU,
    SECPKG_ATTR_ACCESS_TOKEN                = 0x00000012U,
    SECPKG_ATTR_AUTHORITY                   = 0x00000006U,
    SECPKG_ATTR_CLIENT_SPECIFIED_TARGET     = 0x0000001bU,
    SECPKG_ATTR_CONNECTION_INFO             = 0x0000005aU,
    SECPKG_ATTR_DCE_INFO                    = 0x00000003U,
    SECPKG_ATTR_ENDPOINT_BINDINGS           = 0x0000001aU,
    SECPKG_ATTR_EAP_KEY_BLOCK               = 0x0000005bU,
    SECPKG_ATTR_FLAGS                       = 0x0000000eU,
    SECPKG_ATTR_ISSUER_LIST_EX              = 0x00000059U,
    SECPKG_ATTR_KEY_INFO                    = 0x00000005U,
    SECPKG_ATTR_LAST_CLIENT_TOKEN_STATUS    = 0x0000001eU,
    SECPKG_ATTR_LIFESPAN                    = 0x00000002U,
    SECPKG_ATTR_LOCAL_CERT_CONTEXT          = 0x00000054U,
    SECPKG_ATTR_LOCAL_CRED                  = 0x00000052U,
    SECPKG_ATTR_NAMES                       = 0x00000001U,
    SECPKG_ATTR_NATIVE_NAMES                = 0x0000000dU,
    SECPKG_ATTR_NEGOTIATION_INFO            = 0x0000000cU,
    SECPKG_ATTR_PASSWORD_EXPIRY             = 0x00000008U,
    SECPKG_ATTR_REMOTE_CERT_CONTEXT         = 0x00000053U,
    SECPKG_ATTR_ROOT_STORE                  = 0x00000055U,
    SECPKG_ATTR_SESSION_KEY                 = 0x00000009U,
    SECPKG_ATTR_SESSION_INFO                = 0x0000005dU,
    SECPKG_ATTR_STREAM_SIZES                = 0x00000004U,
    SECPKG_ATTR_SUPPORTED_SIGNATURES        = 0x00000066U,
    SECPKG_ATTR_TARGET_INFORMATION          = 0x00000011U,
    SECPKG_ATTR_UNIQUE_BINDINGS             = 0x00000019U,
}

alias MSV1_0 = uint;
enum : uint
{
    MSV1_0_PASSTHRU    = 0x00000001U,
    MSV1_0_GUEST_LOGON = 0x00000002U,
}

alias SECPKG_CRED = uint;
enum : uint
{
    SECPKG_CRED_INBOUND  = 0x00000001U,
    SECPKG_CRED_OUTBOUND = 0x00000002U,
}

alias MSV_SUB_AUTHENTICATION_FILTER = uint;
enum : uint
{
    LOGON_GUEST                 = 0x00000001U,
    LOGON_NOENCRYPTION          = 0x00000002U,
    LOGON_CACHED_ACCOUNT        = 0x00000004U,
    LOGON_USED_LM_PASSWORD      = 0x00000008U,
    LOGON_EXTRA_SIDS            = 0x00000020U,
    LOGON_SUBAUTH_SESSION_KEY   = 0x00000040U,
    LOGON_SERVER_TRUST_ACCOUNT  = 0x00000080U,
    LOGON_PROFILE_PATH_RETURNED = 0x00000400U,
    LOGON_RESOURCE_GROUPS       = 0x00000200U,
}

alias EXPORT_SECURITY_CONTEXT_FLAGS = uint;
enum : uint
{
    SECPKG_CONTEXT_EXPORT_RESET_NEW  = 0x00000001U,
    SECPKG_CONTEXT_EXPORT_DELETE_OLD = 0x00000002U,
    SECPKG_CONTEXT_EXPORT_TO_KERNEL  = 0x00000004U,
}

alias KERB_TICKET_FLAGS = uint;
enum : uint
{
    KERB_TICKET_FLAGS_forwardable    = 0x40000000U,
    KERB_TICKET_FLAGS_forwarded      = 0x20000000U,
    KERB_TICKET_FLAGS_hw_authent     = 0x00100000U,
    KERB_TICKET_FLAGS_initial        = 0x00400000U,
    KERB_TICKET_FLAGS_invalid        = 0x01000000U,
    KERB_TICKET_FLAGS_may_postdate   = 0x04000000U,
    KERB_TICKET_FLAGS_ok_as_delegate = 0x00040000U,
    KERB_TICKET_FLAGS_postdated      = 0x02000000U,
    KERB_TICKET_FLAGS_pre_authent    = 0x00200000U,
    KERB_TICKET_FLAGS_proxiable      = 0x10000000U,
    KERB_TICKET_FLAGS_proxy          = 0x08000000U,
    KERB_TICKET_FLAGS_renewable      = 0x00800000U,
    KERB_TICKET_FLAGS_reserved       = 0x80000000U,
    KERB_TICKET_FLAGS_reserved1      = 0x00000001U,
}

alias KERB_ADDRESS_TYPE = uint;
enum : uint
{
    DS_INET_ADDRESS    = 0x00000001U,
    DS_NETBIOS_ADDRESS = 0x00000002U,
}

alias SCHANNEL_CRED_FLAGS = uint;
enum : uint
{
    SCH_CRED_AUTO_CRED_VALIDATION                = 0x00000020U,
    SCH_CRED_CACHE_ONLY_URL_RETRIEVAL_ON_CREATE  = 0x00020000U,
    SCH_DISABLE_RECONNECTS                       = 0x00000080U,
    SCH_CRED_IGNORE_NO_REVOCATION_CHECK          = 0x00000800U,
    SCH_CRED_IGNORE_REVOCATION_OFFLINE           = 0x00001000U,
    SCH_CRED_MANUAL_CRED_VALIDATION              = 0x00000008U,
    SCH_CRED_NO_DEFAULT_CREDS                    = 0x00000010U,
    SCH_CRED_NO_SERVERNAME_CHECK                 = 0x00000004U,
    SCH_CRED_NO_SYSTEM_MAPPER                    = 0x00000002U,
    SCH_CRED_REVOCATION_CHECK_CHAIN              = 0x00000200U,
    SCH_CRED_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = 0x00000400U,
    SCH_CRED_REVOCATION_CHECK_END_CERT           = 0x00000100U,
    SCH_CRED_USE_DEFAULT_CREDS                   = 0x00000040U,
    SCH_SEND_AUX_RECORD                          = 0x00200000U,
    SCH_SEND_ROOT_CERT                           = 0x00040000U,
    SCH_USE_STRONG_CRYPTO                        = 0x00400000U,
    SCH_USE_PRESHAREDKEY_ONLY                    = 0x00800000U,
}

alias DOMAIN_PASSWORD_PROPERTIES = uint;
enum : uint
{
    DOMAIN_PASSWORD_COMPLEX         = 0x00000001U,
    DOMAIN_PASSWORD_NO_ANON_CHANGE  = 0x00000002U,
    DOMAIN_PASSWORD_NO_CLEAR_CHANGE = 0x00000004U,
    DOMAIN_LOCKOUT_ADMINS           = 0x00000008U,
    DOMAIN_PASSWORD_STORE_CLEARTEXT = 0x00000010U,
    DOMAIN_REFUSE_PASSWORD_CHANGE   = 0x00000020U,
}

alias SCHANNEL_ALERT_TOKEN_ALERT_TYPE = uint;
enum : uint
{
    TLS1_ALERT_WARNING = 0x00000001U,
    TLS1_ALERT_FATAL   = 0x00000002U,
}

alias TRUSTED_DOMAIN_TRUST_TYPE = uint;
enum : uint
{
    TRUST_TYPE_DOWNLEVEL = 0x00000001U,
    TRUST_TYPE_UPLEVEL   = 0x00000002U,
    TRUST_TYPE_MIT       = 0x00000003U,
    TRUST_TYPE_DCE       = 0x00000004U,
}

alias MSV_SUBAUTH_LOGON_PARAMETER_CONTROL = uint;
enum : uint
{
    MSV1_0_CLEARTEXT_PASSWORD_ALLOWED      = 0x00000002U,
    MSV1_0_UPDATE_LOGON_STATISTICS         = 0x00000004U,
    MSV1_0_RETURN_USER_PARAMETERS          = 0x00000008U,
    MSV1_0_DONT_TRY_GUEST_ACCOUNT          = 0x00000010U,
    MSV1_0_ALLOW_SERVER_TRUST_ACCOUNT      = 0x00000020U,
    MSV1_0_RETURN_PASSWORD_EXPIRY          = 0x00000040U,
    MSV1_0_ALLOW_WORKSTATION_TRUST_ACCOUNT = 0x00000800U,
    MSV1_0_TRY_GUEST_ACCOUNT_ONLY          = 0x00000100U,
    MSV1_0_RETURN_PROFILE_PATH             = 0x00000200U,
    MSV1_0_TRY_SPECIFIED_DOMAIN_ONLY       = 0x00000400U,
}

alias KERB_REQUEST_FLAGS = uint;
enum : uint
{
    KERB_REQUEST_ADD_CREDENTIAL     = 0x00000001U,
    KERB_REQUEST_REPLACE_CREDENTIAL = 0x00000002U,
    KERB_REQUEST_REMOVE_CREDENTIAL  = 0x00000004U,
}

alias TRUSTED_DOMAIN_TRUST_DIRECTION = uint;
enum : uint
{
    TRUST_DIRECTION_DISABLED      = 0x00000000U,
    TRUST_DIRECTION_INBOUND       = 0x00000001U,
    TRUST_DIRECTION_OUTBOUND      = 0x00000002U,
    TRUST_DIRECTION_BIDIRECTIONAL = 0x00000003U,
}

alias MSV_SUPPLEMENTAL_CREDENTIAL_FLAGS = uint;
enum : uint
{
    MSV1_0_CRED_LM_PRESENT = 0x00000001U,
    MSV1_0_CRED_NT_PRESENT = 0x00000002U,
    MSV1_0_CRED_VERSION    = 0x00000000U,
}

alias SECURITY_PACKAGE_OPTIONS_TYPE = uint;
enum : uint
{
    SECPKG_OPTIONS_TYPE_UNKNOWN = 0x00000000U,
    SECPKG_OPTIONS_TYPE_LSA     = 0x00000001U,
    SECPKG_OPTIONS_TYPE_SSPI    = 0x00000002U,
}

alias SCHANNEL_SESSION_TOKEN_FLAGS = uint;
enum : uint
{
    SSL_SESSION_ENABLE_RECONNECTS  = 0x00000001U,
    SSL_SESSION_DISABLE_RECONNECTS = 0x00000002U,
}

alias KERB_CRYPTO_KEY_TYPE = int;
enum : int
{
    KERB_ETYPE_DES_CBC_CRC = 0x00000001,
    KERB_ETYPE_DES_CBC_MD4 = 0x00000002,
    KERB_ETYPE_DES_CBC_MD5 = 0x00000003,
    KERB_ETYPE_NULL        = 0x00000000,
    KERB_ETYPE_RC4_HMAC_NT = 0x00000017,
    KERB_ETYPE_RC4_MD4     = 0xffffff80,
}

alias LSA_AUTH_INFORMATION_AUTH_TYPE = uint;
enum : uint
{
    TRUST_AUTH_TYPE_NONE    = 0x00000000U,
    TRUST_AUTH_TYPE_NT4OWF  = 0x00000001U,
    TRUST_AUTH_TYPE_CLEAR   = 0x00000002U,
    TRUST_AUTH_TYPE_VERSION = 0x00000003U,
}

alias SECPKG_PACKAGE_CHANGE_TYPE = uint;
enum : uint
{
    SECPKG_PACKAGE_CHANGE_LOAD   = 0x00000000U,
    SECPKG_PACKAGE_CHANGE_UNLOAD = 0x00000001U,
    SECPKG_PACKAGE_CHANGE_SELECT = 0x00000002U,
}

alias TRUSTED_DOMAIN_TRUST_ATTRIBUTES = uint;
enum : uint
{
    TRUST_ATTRIBUTE_NON_TRANSITIVE     = 0x00000001U,
    TRUST_ATTRIBUTE_UPLEVEL_ONLY       = 0x00000002U,
    TRUST_ATTRIBUTE_FILTER_SIDS        = 0x00000004U,
    TRUST_ATTRIBUTE_FOREST_TRANSITIVE  = 0x00000008U,
    TRUST_ATTRIBUTE_CROSS_ORGANIZATION = 0x00000010U,
    TRUST_ATTRIBUTE_TREAT_AS_EXTERNAL  = 0x00000040U,
    TRUST_ATTRIBUTE_WITHIN_FOREST      = 0x00000020U,
}

alias ISC_REQ_HIGH_FLAGS = ulong;
enum : ulong
{
    ISC_REQ_MESSAGES                 = 0x0000000100000000UL,
    ISC_REQ_DEFERRED_CRED_VALIDATION = 0x0000000200000000UL,
    ISC_REQ_NO_POST_HANDSHAKE_AUTH   = 0x0000000400000000UL,
    ISC_REQ_REUSE_SESSION_TICKETS    = 0x0000000800000000UL,
    ISC_REQ_EXPLICIT_SESSION         = 0x0000001000000000UL,
}

alias ISC_REQ_FLAGS = uint;
enum : uint
{
    ISC_REQ_DELEGATE               = 0x00000001U,
    ISC_REQ_MUTUAL_AUTH            = 0x00000002U,
    ISC_REQ_REPLAY_DETECT          = 0x00000004U,
    ISC_REQ_SEQUENCE_DETECT        = 0x00000008U,
    ISC_REQ_CONFIDENTIALITY        = 0x00000010U,
    ISC_REQ_USE_SESSION_KEY        = 0x00000020U,
    ISC_REQ_PROMPT_FOR_CREDS       = 0x00000040U,
    ISC_REQ_USE_SUPPLIED_CREDS     = 0x00000080U,
    ISC_REQ_ALLOCATE_MEMORY        = 0x00000100U,
    ISC_REQ_USE_DCE_STYLE          = 0x00000200U,
    ISC_REQ_DATAGRAM               = 0x00000400U,
    ISC_REQ_CONNECTION             = 0x00000800U,
    ISC_REQ_CALL_LEVEL             = 0x00001000U,
    ISC_REQ_FRAGMENT_SUPPLIED      = 0x00002000U,
    ISC_REQ_EXTENDED_ERROR         = 0x00004000U,
    ISC_REQ_STREAM                 = 0x00008000U,
    ISC_REQ_INTEGRITY              = 0x00010000U,
    ISC_REQ_IDENTIFY               = 0x00020000U,
    ISC_REQ_NULL_SESSION           = 0x00040000U,
    ISC_REQ_MANUAL_CRED_VALIDATION = 0x00080000U,
    ISC_REQ_RESERVED1              = 0x00100000U,
    ISC_REQ_FRAGMENT_TO_FIT        = 0x00200000U,
    ISC_REQ_FORWARD_CREDENTIALS    = 0x00400000U,
    ISC_REQ_NO_INTEGRITY           = 0x00800000U,
    ISC_REQ_USE_HTTP_STYLE         = 0x01000000U,
    ISC_REQ_UNVERIFIED_TARGET_NAME = 0x20000000U,
    ISC_REQ_CONFIDENTIALITY_ONLY   = 0x40000000U,
}

alias ASC_REQ_HIGH_FLAGS = ulong;
enum : ulong
{
    ASC_REQ_MESSAGES         = 0x0000000100000000UL,
    ASC_REQ_EXPLICIT_SESSION = 0x0000001000000000UL,
}

alias ASC_REQ_FLAGS = uint;
enum : uint
{
    ASC_REQ_DELEGATE               = 0x00000001U,
    ASC_REQ_MUTUAL_AUTH            = 0x00000002U,
    ASC_REQ_REPLAY_DETECT          = 0x00000004U,
    ASC_REQ_SEQUENCE_DETECT        = 0x00000008U,
    ASC_REQ_CONFIDENTIALITY        = 0x00000010U,
    ASC_REQ_USE_SESSION_KEY        = 0x00000020U,
    ASC_REQ_SESSION_TICKET         = 0x00000040U,
    ASC_REQ_ALLOCATE_MEMORY        = 0x00000100U,
    ASC_REQ_USE_DCE_STYLE          = 0x00000200U,
    ASC_REQ_DATAGRAM               = 0x00000400U,
    ASC_REQ_CONNECTION             = 0x00000800U,
    ASC_REQ_CALL_LEVEL             = 0x00001000U,
    ASC_REQ_FRAGMENT_SUPPLIED      = 0x00002000U,
    ASC_REQ_EXTENDED_ERROR         = 0x00008000U,
    ASC_REQ_STREAM                 = 0x00010000U,
    ASC_REQ_INTEGRITY              = 0x00020000U,
    ASC_REQ_LICENSING              = 0x00040000U,
    ASC_REQ_IDENTIFY               = 0x00080000U,
    ASC_REQ_ALLOW_NULL_SESSION     = 0x00100000U,
    ASC_REQ_ALLOW_NON_USER_LOGONS  = 0x00200000U,
    ASC_REQ_ALLOW_CONTEXT_REPLAY   = 0x00400000U,
    ASC_REQ_FRAGMENT_TO_FIT        = 0x00800000U,
    ASC_REQ_NO_TOKEN               = 0x01000000U,
    ASC_REQ_PROXY_BINDINGS         = 0x04000000U,
    ASC_REQ_ALLOW_MISSING_BINDINGS = 0x10000000U,
}

alias LSA_LOOKUP_DOMAIN_INFO_CLASS = int;
enum : int
{
    AccountDomainInformation = 0x00000005,
    DnsDomainInformation     = 0x0000000c,
}

//ENUM ATTR: ScopedEnumAttribute : CustomAttributeSig([], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-security_logon_type
alias SECURITY_LOGON_TYPE = int;
enum : int
{
    UndefinedLogonType      = 0x00000000,
    Interactive             = 0x00000002,
    Network                 = 0x00000003,
    Batch                   = 0x00000004,
    Service                 = 0x00000005,
    Proxy                   = 0x00000006,
    Unlock                  = 0x00000007,
    NetworkCleartext        = 0x00000008,
    NewCredentials          = 0x00000009,
    RemoteInteractive       = 0x0000000a,
    CachedInteractive       = 0x0000000b,
    CachedRemoteInteractive = 0x0000000c,
    CachedUnlock            = 0x0000000d,
}

alias SE_ADT_PARAMETER_TYPE = int;
enum : int
{
    SeAdtParmTypeNone               = 0x00000000,
    SeAdtParmTypeString             = 0x00000001,
    SeAdtParmTypeFileSpec           = 0x00000002,
    SeAdtParmTypeUlong              = 0x00000003,
    SeAdtParmTypeSid                = 0x00000004,
    SeAdtParmTypeLogonId            = 0x00000005,
    SeAdtParmTypeNoLogonId          = 0x00000006,
    SeAdtParmTypeAccessMask         = 0x00000007,
    SeAdtParmTypePrivs              = 0x00000008,
    SeAdtParmTypeObjectTypes        = 0x00000009,
    SeAdtParmTypeHexUlong           = 0x0000000a,
    SeAdtParmTypePtr                = 0x0000000b,
    SeAdtParmTypeTime               = 0x0000000c,
    SeAdtParmTypeGuid               = 0x0000000d,
    SeAdtParmTypeLuid               = 0x0000000e,
    SeAdtParmTypeHexInt64           = 0x0000000f,
    SeAdtParmTypeStringList         = 0x00000010,
    SeAdtParmTypeSidList            = 0x00000011,
    SeAdtParmTypeDuration           = 0x00000012,
    SeAdtParmTypeUserAccountControl = 0x00000013,
    SeAdtParmTypeNoUac              = 0x00000014,
    SeAdtParmTypeMessage            = 0x00000015,
    SeAdtParmTypeDateTime           = 0x00000016,
    SeAdtParmTypeSockAddr           = 0x00000017,
    SeAdtParmTypeSD                 = 0x00000018,
    SeAdtParmTypeLogonHours         = 0x00000019,
    SeAdtParmTypeLogonIdNoSid       = 0x0000001a,
    SeAdtParmTypeUlongNoConv        = 0x0000001b,
    SeAdtParmTypeSockAddrNoPort     = 0x0000001c,
    SeAdtParmTypeAccessReason       = 0x0000001d,
    SeAdtParmTypeStagingReason      = 0x0000001e,
    SeAdtParmTypeResourceAttribute  = 0x0000001f,
    SeAdtParmTypeClaims             = 0x00000020,
    SeAdtParmTypeLogonIdAsSid       = 0x00000021,
    SeAdtParmTypeMultiSzString      = 0x00000022,
    SeAdtParmTypeLogonIdEx          = 0x00000023,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-policy_audit_event_type
alias POLICY_AUDIT_EVENT_TYPE = int;
enum : int
{
    AuditCategorySystem                 = 0x00000000,
    AuditCategoryLogon                  = 0x00000001,
    AuditCategoryObjectAccess           = 0x00000002,
    AuditCategoryPrivilegeUse           = 0x00000003,
    AuditCategoryDetailedTracking       = 0x00000004,
    AuditCategoryPolicyChange           = 0x00000005,
    AuditCategoryAccountManagement      = 0x00000006,
    AuditCategoryDirectoryServiceAccess = 0x00000007,
    AuditCategoryAccountLogon           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-policy_lsa_server_role
alias POLICY_LSA_SERVER_ROLE = int;
enum : int
{
    PolicyServerRoleBackup  = 0x00000002,
    PolicyServerRolePrimary = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-policy_information_class
alias POLICY_INFORMATION_CLASS = int;
enum : int
{
    PolicyAuditLogInformation           = 0x00000001,
    PolicyAuditEventsInformation        = 0x00000002,
    PolicyPrimaryDomainInformation      = 0x00000003,
    PolicyPdAccountInformation          = 0x00000004,
    PolicyAccountDomainInformation      = 0x00000005,
    PolicyLsaServerRoleInformation      = 0x00000006,
    PolicyReplicaSourceInformation      = 0x00000007,
    PolicyDefaultQuotaInformation       = 0x00000008,
    PolicyModificationInformation       = 0x00000009,
    PolicyAuditFullSetInformation       = 0x0000000a,
    PolicyAuditFullQueryInformation     = 0x0000000b,
    PolicyDnsDomainInformation          = 0x0000000c,
    PolicyDnsDomainInformationInt       = 0x0000000d,
    PolicyLocalAccountDomainInformation = 0x0000000e,
    PolicyMachineAccountInformation     = 0x0000000f,
    PolicyMachineAccountInformation2    = 0x00000010,
    PolicyLastEntry                     = 0x00000011,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-policy_domain_information_class
alias POLICY_DOMAIN_INFORMATION_CLASS = int;
enum : int
{
    PolicyDomainEfsInformation            = 0x00000002,
    PolicyDomainKerberosTicketInformation = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-policy_notification_information_class
alias POLICY_NOTIFICATION_INFORMATION_CLASS = int;
enum : int
{
    PolicyNotifyAuditEventsInformation            = 0x00000001,
    PolicyNotifyAccountDomainInformation          = 0x00000002,
    PolicyNotifyServerRoleInformation             = 0x00000003,
    PolicyNotifyDnsDomainInformation              = 0x00000004,
    PolicyNotifyDomainEfsInformation              = 0x00000005,
    PolicyNotifyDomainKerberosTicketInformation   = 0x00000006,
    PolicyNotifyMachineAccountPasswordInformation = 0x00000007,
    PolicyNotifyGlobalSaclInformation             = 0x00000008,
    PolicyNotifyMax                               = 0x00000009,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-trusted_information_class
alias TRUSTED_INFORMATION_CLASS = int;
enum : int
{
    TrustedDomainNameInformation            = 0x00000001,
    TrustedControllersInformation           = 0x00000002,
    TrustedPosixOffsetInformation           = 0x00000003,
    TrustedPasswordInformation              = 0x00000004,
    TrustedDomainInformationBasic           = 0x00000005,
    TrustedDomainInformationEx              = 0x00000006,
    TrustedDomainAuthInformation            = 0x00000007,
    TrustedDomainFullInformation            = 0x00000008,
    TrustedDomainAuthInformationInternal    = 0x00000009,
    TrustedDomainFullInformationInternal    = 0x0000000a,
    TrustedDomainInformationEx2Internal     = 0x0000000b,
    TrustedDomainFullInformation2Internal   = 0x0000000c,
    TrustedDomainSupportedEncryptionTypes   = 0x0000000d,
    TrustedDomainAuthInformationInternalAes = 0x0000000e,
    TrustedDomainFullInformationInternalAes = 0x0000000f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-lsa_forest_trust_record_type
alias LSA_FOREST_TRUST_RECORD_TYPE = int;
enum : int
{
    ForestTrustTopLevelName   = 0x00000000,
    ForestTrustTopLevelNameEx = 0x00000001,
    ForestTrustDomainInfo     = 0x00000002,
    ForestTrustBinaryInfo     = 0x00000003,
    ForestTrustScannerInfo    = 0x00000004,
    ForestTrustRecordTypeLast = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-lsa_forest_trust_collision_record_type
alias LSA_FOREST_TRUST_COLLISION_RECORD_TYPE = int;
enum : int
{
    CollisionTdo   = 0x00000000,
    CollisionXref  = 0x00000001,
    CollisionOther = 0x00000002,
}

alias NEGOTIATE_MESSAGES = int;
enum : int
{
    NegEnumPackagePrefixes = 0x00000000,
    NegGetCallerName       = 0x00000001,
    NegTransferCredentials = 0x00000002,
    NegMsgReserved1        = 0x00000003,
    NegCallPackageMax      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-msv1_0_logon_submit_type
alias MSV1_0_LOGON_SUBMIT_TYPE = int;
enum : int
{
    MsV1_0InteractiveLogon       = 0x00000002,
    MsV1_0Lm20Logon              = 0x00000003,
    MsV1_0NetworkLogon           = 0x00000004,
    MsV1_0SubAuthLogon           = 0x00000005,
    MsV1_0WorkstationUnlockLogon = 0x00000007,
    MsV1_0S4ULogon               = 0x0000000c,
    MsV1_0VirtualLogon           = 0x00000052,
    MsV1_0NoElevationLogon       = 0x00000053,
    MsV1_0LuidLogon              = 0x00000054,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-msv1_0_profile_buffer_type
alias MSV1_0_PROFILE_BUFFER_TYPE = int;
enum : int
{
    MsV1_0InteractiveProfile = 0x00000002,
    MsV1_0Lm20LogonProfile   = 0x00000003,
    MsV1_0SmartCardProfile   = 0x00000004,
}

alias MSV1_0_CREDENTIAL_KEY_TYPE = int;
enum : int
{
    InvalidCredKey            = 0x00000000,
    DeprecatedIUMCredKey      = 0x00000001,
    DomainUserCredKey         = 0x00000002,
    LocalUserCredKey          = 0x00000003,
    ExternallySuppliedCredKey = 0x00000004,
}

alias MSV1_0_AVID = int;
enum : int
{
    MsvAvEOL             = 0x00000000,
    MsvAvNbComputerName  = 0x00000001,
    MsvAvNbDomainName    = 0x00000002,
    MsvAvDnsComputerName = 0x00000003,
    MsvAvDnsDomainName   = 0x00000004,
    MsvAvDnsTreeName     = 0x00000005,
    MsvAvFlags           = 0x00000006,
    MsvAvTimestamp       = 0x00000007,
    MsvAvRestrictions    = 0x00000008,
    MsvAvTargetName      = 0x00000009,
    MsvAvChannelBindings = 0x0000000a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-msv1_0_protocol_message_type
alias MSV1_0_PROTOCOL_MESSAGE_TYPE = int;
enum : int
{
    MsV1_0Lm20ChallengeRequest     = 0x00000000,
    MsV1_0Lm20GetChallengeResponse = 0x00000001,
    MsV1_0EnumerateUsers           = 0x00000002,
    MsV1_0GetUserInfo              = 0x00000003,
    MsV1_0ReLogonUsers             = 0x00000004,
    MsV1_0ChangePassword           = 0x00000005,
    MsV1_0ChangeCachedPassword     = 0x00000006,
    MsV1_0GenericPassthrough       = 0x00000007,
    MsV1_0CacheLogon               = 0x00000008,
    MsV1_0SubAuth                  = 0x00000009,
    MsV1_0DeriveCredential         = 0x0000000a,
    MsV1_0CacheLookup              = 0x0000000b,
    MsV1_0SetProcessOption         = 0x0000000c,
    MsV1_0ConfigLocalAliases       = 0x0000000d,
    MsV1_0ClearCachedCredentials   = 0x0000000e,
    MsV1_0LookupToken              = 0x0000000f,
    MsV1_0ValidateAuth             = 0x00000010,
    MsV1_0CacheLookupEx            = 0x00000011,
    MsV1_0GetCredentialKey         = 0x00000012,
    MsV1_0SetThreadOption          = 0x00000013,
    MsV1_0DecryptDpapiMasterKey    = 0x00000014,
    MsV1_0GetStrongCredentialKey   = 0x00000015,
    MsV1_0TransferCred             = 0x00000016,
    MsV1_0ProvisionTbal            = 0x00000017,
    MsV1_0DeleteTbalSecrets        = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-kerb_logon_submit_type
alias KERB_LOGON_SUBMIT_TYPE = int;
enum : int
{
    KerbInteractiveLogon       = 0x00000002,
    KerbSmartCardLogon         = 0x00000006,
    KerbWorkstationUnlockLogon = 0x00000007,
    KerbSmartCardUnlockLogon   = 0x00000008,
    KerbProxyLogon             = 0x00000009,
    KerbTicketLogon            = 0x0000000a,
    KerbTicketUnlockLogon      = 0x0000000b,
    KerbS4ULogon               = 0x0000000c,
    KerbCertificateLogon       = 0x0000000d,
    KerbCertificateS4ULogon    = 0x0000000e,
    KerbCertificateUnlockLogon = 0x0000000f,
    KerbNoElevationLogon       = 0x00000053,
    KerbLuidLogon              = 0x00000054,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-kerb_profile_buffer_type
alias KERB_PROFILE_BUFFER_TYPE = int;
enum : int
{
    KerbInteractiveProfile = 0x00000002,
    KerbSmartCardProfile   = 0x00000004,
    KerbTicketProfile      = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-kerb_protocol_message_type
alias KERB_PROTOCOL_MESSAGE_TYPE = int;
enum : int
{
    KerbDebugRequestMessage                 = 0x00000000,
    KerbQueryTicketCacheMessage             = 0x00000001,
    KerbChangeMachinePasswordMessage        = 0x00000002,
    KerbVerifyPacMessage                    = 0x00000003,
    KerbRetrieveTicketMessage               = 0x00000004,
    KerbUpdateAddressesMessage              = 0x00000005,
    KerbPurgeTicketCacheMessage             = 0x00000006,
    KerbChangePasswordMessage               = 0x00000007,
    KerbRetrieveEncodedTicketMessage        = 0x00000008,
    KerbDecryptDataMessage                  = 0x00000009,
    KerbAddBindingCacheEntryMessage         = 0x0000000a,
    KerbSetPasswordMessage                  = 0x0000000b,
    KerbSetPasswordExMessage                = 0x0000000c,
    KerbVerifyCredentialsMessage            = 0x0000000d,
    KerbQueryTicketCacheExMessage           = 0x0000000e,
    KerbPurgeTicketCacheExMessage           = 0x0000000f,
    KerbRefreshSmartcardCredentialsMessage  = 0x00000010,
    KerbAddExtraCredentialsMessage          = 0x00000011,
    KerbQuerySupplementalCredentialsMessage = 0x00000012,
    KerbTransferCredentialsMessage          = 0x00000013,
    KerbQueryTicketCacheEx2Message          = 0x00000014,
    KerbSubmitTicketMessage                 = 0x00000015,
    KerbAddExtraCredentialsExMessage        = 0x00000016,
    KerbQueryKdcProxyCacheMessage           = 0x00000017,
    KerbPurgeKdcProxyCacheMessage           = 0x00000018,
    KerbQueryTicketCacheEx3Message          = 0x00000019,
    KerbCleanupMachinePkinitCredsMessage    = 0x0000001a,
    KerbAddBindingCacheEntryExMessage       = 0x0000001b,
    KerbQueryBindingCacheMessage            = 0x0000001c,
    KerbPurgeBindingCacheMessage            = 0x0000001d,
    KerbPinKdcMessage                       = 0x0000001e,
    KerbUnpinAllKdcsMessage                 = 0x0000001f,
    KerbQueryDomainExtendedPoliciesMessage  = 0x00000020,
    KerbQueryS4U2ProxyCacheMessage          = 0x00000021,
    KerbRetrieveKeyTabMessage               = 0x00000022,
    KerbRefreshPolicyMessage                = 0x00000023,
    KerbPrintCloudKerberosDebugMessage      = 0x00000024,
    KerbNetworkTicketLogonMessage           = 0x00000025,
    KerbNlChangeMachinePasswordMessage      = 0x00000026,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-kerb_certificate_info_type
alias KERB_CERTIFICATE_INFO_TYPE = int;
enum : int
{
    CertHashInfo = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ne-ntsecapi-pku2u_logon_submit_type
alias PKU2U_LOGON_SUBMIT_TYPE = int;
enum : int
{
    Pku2uCertificateS4ULogon = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-sec_application_protocol_negotiation_ext
alias SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT = int;
enum : int
{
    SecApplicationProtocolNegotiationExt_None = 0x00000000,
    SecApplicationProtocolNegotiationExt_NPN  = 0x00000001,
    SecApplicationProtocolNegotiationExt_ALPN = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-sec_traffic_secret_type
alias SEC_TRAFFIC_SECRET_TYPE = int;
enum : int
{
    SecTrafficSecret_None   = 0x00000000,
    SecTrafficSecret_Client = 0x00000001,
    SecTrafficSecret_Server = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-secpkg_cred_class
alias SECPKG_CRED_CLASS = int;
enum : int
{
    SecPkgCredClass_None              = 0x00000000,
    SecPkgCredClass_Ephemeral         = 0x0000000a,
    SecPkgCredClass_PersistedGeneric  = 0x00000014,
    SecPkgCredClass_PersistedSpecific = 0x0000001e,
    SecPkgCredClass_Explicit          = 0x00000028,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-secpkg_attr_lct_status
alias SECPKG_ATTR_LCT_STATUS = int;
enum : int
{
    SecPkgAttrLastClientTokenYes   = 0x00000000,
    SecPkgAttrLastClientTokenNo    = 0x00000001,
    SecPkgAttrLastClientTokenMaybe = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-sec_application_protocol_negotiation_status
alias SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS = int;
enum : int
{
    SecApplicationProtocolNegotiationStatus_None               = 0x00000000,
    SecApplicationProtocolNegotiationStatus_Success            = 0x00000001,
    SecApplicationProtocolNegotiationStatus_SelectedClientOnly = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ne-sspi-secdelegationtype
enum SecDelegationType : int
{
    SecFull      = 0x00000000,
    SecService   = 0x00000001,
    SecTree      = 0x00000002,
    SecDirectory = 0x00000003,
    SecObject    = 0x00000004,
}

alias SASL_AUTHZID_STATE = int;
enum : int
{
    Sasl_AuthZIDForbidden = 0x00000000,
    Sasl_AuthZIDProcessed = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ne-ntsecpkg-lsa_token_information_type
alias LSA_TOKEN_INFORMATION_TYPE = int;
enum : int
{
    LsaTokenInformationNull = 0x00000000,
    LsaTokenInformationV1   = 0x00000001,
    LsaTokenInformationV2   = 0x00000002,
    LsaTokenInformationV3   = 0x00000003,
}

alias SECPKG_FAILURE_SPECIAL_REASON = int;
enum : int
{
    SecpkgFailureReason_Unknown       = 0x00000000,
    SecpkgFailureReason_NoFailure     = 0x00000001,
    SecpkgFailureReason_LocalAccount  = 0x00000002,
    SecpkgFailureReason_DomainAccount = 0x00000003,
    SecpkgFailureReason_CloudAccount  = 0x00000004,
    SecpkgFailureReason_NullTarget    = 0x00000005,
    SecpkgFailureReason_UnknownTarget = 0x00000006,
    SecpkgFailureReason_IpAddress     = 0x00000007,
    SecpkgFailureReason_DupTarget     = 0x00000008,
    SecpkgFailureReason_NoLineOfSight = 0x00000009,
    SecpkgFailureReason_Loopback      = 0x0000000a,
    SecpkgFailureReason_NullSession   = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ne-ntsecpkg-secpkg_extended_information_class
alias SECPKG_EXTENDED_INFORMATION_CLASS = int;
enum : int
{
    SecpkgGssInfo         = 0x00000001,
    SecpkgContextThunks   = 0x00000002,
    SecpkgMutualAuthLevel = 0x00000003,
    SecpkgWowClientDll    = 0x00000004,
    SecpkgExtraOids       = 0x00000005,
    SecpkgMaxInfo         = 0x00000006,
    SecpkgNego2Info       = 0x00000007,
}

alias SECPKG_CALL_PACKAGE_MESSAGE_TYPE = int;
enum : int
{
    SecPkgCallPackageMinMessage          = 0x00000400,
    SecPkgCallPackagePinDcMessage        = 0x00000400,
    SecPkgCallPackageUnpinAllDcsMessage  = 0x00000401,
    SecPkgCallPackageTransferCredMessage = 0x00000402,
    SecPkgCallPackageMaxMessage          = 0x00000402,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ne-ntsecpkg-secpkg_sessioninfo_type
alias SECPKG_SESSIONINFO_TYPE = int;
enum : int
{
    SecSessionPrimaryCred = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ne-ntsecpkg-secpkg_name_type
alias SECPKG_NAME_TYPE = int;
enum : int
{
    SecNameSamCompatible = 0x00000000,
    SecNameAlternateId   = 0x00000001,
    SecNameFlat          = 0x00000002,
    SecNameDN            = 0x00000003,
    SecNameSPN           = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecMgmt/cred-fetch
alias CRED_FETCH = int;
enum : int
{
    CredFetchDefault = 0x00000000,
    CredFetchDPAPI   = 0x00000001,
    CredFetchForced  = 0x00000002,
}

alias KSEC_CONTEXT_TYPE = int;
enum : int
{
    KSecPaged    = 0x00000000,
    KSecNonPaged = 0x00000001,
}

alias eTlsSignatureAlgorithm = int;
enum : int
{
    TlsSignatureAlgorithm_Anonymous = 0x00000000,
    TlsSignatureAlgorithm_Rsa       = 0x00000001,
    TlsSignatureAlgorithm_Dsa       = 0x00000002,
    TlsSignatureAlgorithm_Ecdsa     = 0x00000003,
}

alias eTlsHashAlgorithm = int;
enum : int
{
    TlsHashAlgorithm_None   = 0x00000000,
    TlsHashAlgorithm_Md5    = 0x00000001,
    TlsHashAlgorithm_Sha1   = 0x00000002,
    TlsHashAlgorithm_Sha224 = 0x00000003,
    TlsHashAlgorithm_Sha256 = 0x00000004,
    TlsHashAlgorithm_Sha384 = 0x00000005,
    TlsHashAlgorithm_Sha512 = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ne-schannel-etlsalgorithmusage
alias eTlsAlgorithmUsage = int;
enum : int
{
    TlsParametersCngAlgUsageKeyExchange = 0x00000000,
    TlsParametersCngAlgUsageSignature   = 0x00000001,
    TlsParametersCngAlgUsageCipher      = 0x00000002,
    TlsParametersCngAlgUsageDigest      = 0x00000003,
    TlsParametersCngAlgUsageCertSig     = 0x00000004,
}

enum SchGetExtensionsOptions : int
{
    SCH_EXTENSIONS_OPTIONS_NONE = 0x00000000,
    SCH_NO_RECORD_HEADER        = 0x00000001,
}

alias NETLOGON_LOGON_INFO_CLASS = int;
enum : int
{
    NetlogonInteractiveInformation           = 0x00000001,
    NetlogonNetworkInformation               = 0x00000002,
    NetlogonServiceInformation               = 0x00000003,
    NetlogonGenericInformation               = 0x00000004,
    NetlogonInteractiveTransitiveInformation = 0x00000005,
    NetlogonNetworkTransitiveInformation     = 0x00000006,
    NetlogonServiceTransitiveInformation     = 0x00000007,
    NetlogonTicketLogonInformation           = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ne-tokenbinding-tokenbinding_type
alias TOKENBINDING_TYPE = int;
enum : int
{
    TOKENBINDING_TYPE_PROVIDED = 0x00000000,
    TOKENBINDING_TYPE_REFERRED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ne-tokenbinding-tokenbinding_extension_format
alias TOKENBINDING_EXTENSION_FORMAT = int;
enum : int
{
    TOKENBINDING_EXTENSION_FORMAT_UNDEFINED = 0x00000000,
}

alias TOKENBINDING_KEY_PARAMETERS_TYPE = int;
enum : int
{
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PKCS = 0x00000000,
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PSS  = 0x00000001,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ECDSAP256    = 0x00000002,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ANYEXISTING  = 0x000000ff,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/secext/ne-secext-extended_name_format
alias EXTENDED_NAME_FORMAT = int;
enum : int
{
    NameUnknown          = 0x00000000,
    NameFullyQualifiedDN = 0x00000001,
    NameSamCompatible    = 0x00000002,
    NameDisplay          = 0x00000003,
    NameUniqueId         = 0x00000006,
    NameCanonical        = 0x00000007,
    NameUserPrincipal    = 0x00000008,
    NameCanonicalEx      = 0x00000009,
    NameServicePrincipal = 0x0000000a,
    NameDnsDomain        = 0x0000000c,
    NameGivenName        = 0x0000000d,
    NameSurname          = 0x0000000e,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-sldatatype
alias SLDATATYPE = uint;
enum : uint
{
    SL_DATA_NONE     = 0x00000000U,
    SL_DATA_SZ       = 0x00000001U,
    SL_DATA_DWORD    = 0x00000004U,
    SL_DATA_BINARY   = 0x00000003U,
    SL_DATA_MULTI_SZ = 0x00000007U,
    SL_DATA_SUM      = 0x00000064U,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-slidtype
alias SLIDTYPE = int;
enum : int
{
    SL_ID_APPLICATION       = 0x00000000,
    SL_ID_PRODUCT_SKU       = 0x00000001,
    SL_ID_LICENSE_FILE      = 0x00000002,
    SL_ID_LICENSE           = 0x00000003,
    SL_ID_PKEY              = 0x00000004,
    SL_ID_ALL_LICENSES      = 0x00000005,
    SL_ID_ALL_LICENSE_FILES = 0x00000006,
    SL_ID_STORE_TOKEN       = 0x00000007,
    SL_ID_LAST              = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-sllicensingstatus
alias SLLICENSINGSTATUS = int;
enum : int
{
    SL_LICENSING_STATUS_UNLICENSED      = 0x00000000,
    SL_LICENSING_STATUS_LICENSED        = 0x00000001,
    SL_LICENSING_STATUS_IN_GRACE_PERIOD = 0x00000002,
    SL_LICENSING_STATUS_NOTIFICATION    = 0x00000003,
    SL_LICENSING_STATUS_LAST            = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-sl_activation_type
alias SL_ACTIVATION_TYPE = int;
enum : int
{
    SL_ACTIVATION_TYPE_DEFAULT          = 0x00000000,
    SL_ACTIVATION_TYPE_ACTIVE_DIRECTORY = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-slreferraltype
alias SLREFERRALTYPE = int;
enum : int
{
    SL_REFERRALTYPE_SKUID          = 0x00000000,
    SL_REFERRALTYPE_APPID          = 0x00000001,
    SL_REFERRALTYPE_OVERRIDE_SKUID = 0x00000002,
    SL_REFERRALTYPE_OVERRIDE_APPID = 0x00000003,
    SL_REFERRALTYPE_BEST_MATCH     = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ne-slpublic-sl_genuine_state
alias SL_GENUINE_STATE = int;
enum : int
{
    SL_GEN_STATE_IS_GENUINE      = 0x00000000,
    SL_GEN_STATE_INVALID_LICENSE = 0x00000001,
    SL_GEN_STATE_TAMPERED        = 0x00000002,
    SL_GEN_STATE_OFFLINE         = 0x00000003,
    SL_GEN_STATE_LAST            = 0x00000004,
}

// Constants


enum : const(wchar)*
{
    // Native encoding: ansi
    NTLMSP_NAME_A = "NTLM",
    NTLMSP_NAME   = "NTLM",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    MICROSOFT_KERBEROS_NAME_A = "Kerberos",
    MICROSOFT_KERBEROS_NAME_W = "Kerberos",
    MICROSOFT_KERBEROS_NAME   = "Kerberos",
}

enum : const(wchar)*
{
    NEGOSSP_NAME_W = "Negotiate",
    // Native encoding: ansi
    NEGOSSP_NAME_A = "Negotiate",
    NEGOSSP_NAME   = "Negotiate",
}

enum const(wchar)* CLOUDAP_NAME_W = "CloudAP";
// Native encoding: ansi
enum const(wchar)* ClOUDAP_NAME_A = "CloudAP";
enum const(wchar)* CLOUDAP_NAME = "CloudAP";

enum : uint
{
    ISSP_LEVEL = 0x00000020U,
    ISSP_MODE  = 0x00000001U,
}

enum : uint
{
    SECPKG_FLAG_INTEGRITY                = 0x00000001U,
    SECPKG_FLAG_PRIVACY                  = 0x00000002U,
    SECPKG_FLAG_TOKEN_ONLY               = 0x00000004U,
    SECPKG_FLAG_DATAGRAM                 = 0x00000008U,
    SECPKG_FLAG_CONNECTION               = 0x00000010U,
    SECPKG_FLAG_MULTI_REQUIRED           = 0x00000020U,
    SECPKG_FLAG_CLIENT_ONLY              = 0x00000040U,
    SECPKG_FLAG_EXTENDED_ERROR           = 0x00000080U,
    SECPKG_FLAG_IMPERSONATION            = 0x00000100U,
    SECPKG_FLAG_ACCEPT_WIN32_NAME        = 0x00000200U,
    SECPKG_FLAG_STREAM                   = 0x00000400U,
    SECPKG_FLAG_NEGOTIABLE               = 0x00000800U,
    SECPKG_FLAG_GSS_COMPATIBLE           = 0x00001000U,
    SECPKG_FLAG_LOGON                    = 0x00002000U,
    SECPKG_FLAG_ASCII_BUFFERS            = 0x00004000U,
    SECPKG_FLAG_FRAGMENT                 = 0x00008000U,
    SECPKG_FLAG_MUTUAL_AUTH              = 0x00010000U,
    SECPKG_FLAG_DELEGATION               = 0x00020000U,
    SECPKG_FLAG_READONLY_WITH_CHECKSUM   = 0x00040000U,
    SECPKG_FLAG_RESTRICTED_TOKENS        = 0x00080000U,
    SECPKG_FLAG_NEGO_EXTENDER            = 0x00100000U,
    SECPKG_FLAG_NEGOTIABLE2              = 0x00200000U,
    SECPKG_FLAG_APPCONTAINER_PASSTHROUGH = 0x00400000U,
    SECPKG_FLAG_APPCONTAINER_CHECKS      = 0x00800000U,
}

enum uint SECPKG_FLAG_CREDENTIAL_ISOLATION_ENABLED = 0x01000000U;
enum uint SECPKG_FLAG_APPLY_LOOPBACK = 0x02000000U;

enum : uint
{
    SECPKG_ID_NONE                            = 0x0000ffffU,
    SECPKG_CALLFLAGS_APPCONTAINER             = 0x00000001U,
    SECPKG_CALLFLAGS_APPCONTAINER_AUTHCAPABLE = 0x00000002U,
    SECPKG_CALLFLAGS_FORCE_SUPPLIED           = 0x00000004U,
    SECPKG_CALLFLAGS_APPCONTAINER_UPNCAPABLE  = 0x00000008U,
}

enum : uint
{
    SECBUFFER_VERSION          = 0x00000000U,
    SECBUFFER_EMPTY            = 0x00000000U,
    SECBUFFER_DATA             = 0x00000001U,
    SECBUFFER_TOKEN            = 0x00000002U,
    SECBUFFER_PKG_PARAMS       = 0x00000003U,
    SECBUFFER_MISSING          = 0x00000004U,
    SECBUFFER_EXTRA            = 0x00000005U,
    SECBUFFER_STREAM_TRAILER   = 0x00000006U,
    SECBUFFER_STREAM_HEADER    = 0x00000007U,
    SECBUFFER_NEGOTIATION_INFO = 0x00000008U,
}

enum : uint
{
    SECBUFFER_PADDING            = 0x00000009U,
    SECBUFFER_STREAM             = 0x0000000aU,
    SECBUFFER_MECHLIST           = 0x0000000bU,
    SECBUFFER_MECHLIST_SIGNATURE = 0x0000000cU,
}

enum : uint
{
    SECBUFFER_TARGET               = 0x0000000dU,
    SECBUFFER_CHANNEL_BINDINGS     = 0x0000000eU,
    SECBUFFER_CHANGE_PASS_RESPONSE = 0x0000000fU,
}

enum : uint
{
    SECBUFFER_TARGET_HOST           = 0x00000010U,
    SECBUFFER_ALERT                 = 0x00000011U,
    SECBUFFER_APPLICATION_PROTOCOLS = 0x00000012U,
}

enum : uint
{
    SECBUFFER_SRTP_PROTECTION_PROFILES   = 0x00000013U,
    SECBUFFER_SRTP_MASTER_KEY_IDENTIFIER = 0x00000014U,
}

enum : uint
{
    SECBUFFER_TOKEN_BINDING          = 0x00000015U,
    SECBUFFER_PRESHARED_KEY          = 0x00000016U,
    SECBUFFER_PRESHARED_KEY_IDENTITY = 0x00000017U,
}

enum : uint
{
    SECBUFFER_DTLS_MTU                   = 0x00000018U,
    SECBUFFER_SEND_GENERIC_TLS_EXTENSION = 0x00000019U,
}

enum uint SECBUFFER_SUBSCRIBE_GENERIC_TLS_EXTENSION = 0x0000001aU;

enum : uint
{
    SECBUFFER_FLAGS           = 0x0000001bU,
    SECBUFFER_TRAFFIC_SECRETS = 0x0000001cU,
}

enum uint SECBUFFER_CERTIFICATE_REQUEST_CONTEXT = 0x0000001dU;
enum uint SECBUFFER_CHANNEL_BINDINGS_RESULT = 0x0000001eU;
enum uint SECBUFFER_APP_SESSION_STATE = 0x0000001fU;

enum : uint
{
    SECBUFFER_SESSION_TICKET         = 0x00000020U,
    SECBUFFER_ATTRMASK               = 0xf0000000U,
    SECBUFFER_READONLY               = 0x80000000U,
    SECBUFFER_READONLY_WITH_CHECKSUM = 0x10000000U,
}

enum uint SECBUFFER_RESERVED = 0x60000000U;

enum : uint
{
    SEC_CHANNEL_BINDINGS_AUDIT_BINDINGS           = 0x00000001U,
    SEC_CHANNEL_BINDINGS_VALID_FLAGS              = 0x00000001U,
    SEC_CHANNEL_BINDINGS_RESULT_CLIENT_SUPPORT    = 0x00000001U,
    SEC_CHANNEL_BINDINGS_RESULT_ABSENT            = 0x00000002U,
    SEC_CHANNEL_BINDINGS_RESULT_NOTVALID_MISMATCH = 0x00000004U,
    SEC_CHANNEL_BINDINGS_RESULT_NOTVALID_MISSING  = 0x00000008U,
    SEC_CHANNEL_BINDINGS_RESULT_VALID_MATCHED     = 0x00000010U,
    SEC_CHANNEL_BINDINGS_RESULT_VALID_PROXY       = 0x00000020U,
    SEC_CHANNEL_BINDINGS_RESULT_VALID_MISSING     = 0x00000040U,
}

enum uint SZ_ALG_MAX_SIZE = 0x00000040U;

enum : uint
{
    SECURITY_NATIVE_DREP  = 0x00000010U,
    SECURITY_NETWORK_DREP = 0x00000000U,
}

enum : uint
{
    SECPKG_CRED_BOTH                 = 0x00000003U,
    SECPKG_CRED_DEFAULT              = 0x00000004U,
    SECPKG_CRED_RESERVED             = 0xf0000000U,
    SECPKG_CRED_AUTOLOGON_RESTRICTED = 0x00000010U,
}

enum uint SECPKG_CRED_PROCESS_POLICY_ONLY = 0x00000020U;
enum uint SECPKG_CRED_KERB_ANCHOR_DS_VERSION = 0x00000040U;

enum : uint
{
    ISC_RET_DELEGATE      = 0x00000001U,
    ISC_RET_MUTUAL_AUTH   = 0x00000002U,
    ISC_RET_REPLAY_DETECT = 0x00000004U,
}

enum uint ISC_RET_SEQUENCE_DETECT = 0x00000008U;
enum uint ISC_RET_CONFIDENTIALITY = 0x00000010U;

enum : uint
{
    ISC_RET_USE_SESSION_KEY      = 0x00000020U,
    ISC_RET_USED_COLLECTED_CREDS = 0x00000040U,
    ISC_RET_USED_SUPPLIED_CREDS  = 0x00000080U,
}

enum uint ISC_RET_ALLOCATED_MEMORY = 0x00000100U;
enum uint ISC_RET_USED_DCE_STYLE = 0x00000200U;

enum : uint
{
    ISC_RET_DATAGRAM            = 0x00000400U,
    ISC_RET_CONNECTION          = 0x00000800U,
    ISC_RET_INTERMEDIATE_RETURN = 0x00001000U,
}

enum : uint
{
    ISC_RET_CALL_LEVEL     = 0x00002000U,
    ISC_RET_EXTENDED_ERROR = 0x00004000U,
}

enum : uint
{
    ISC_RET_STREAM       = 0x00008000U,
    ISC_RET_INTEGRITY    = 0x00010000U,
    ISC_RET_IDENTIFY     = 0x00020000U,
    ISC_RET_NULL_SESSION = 0x00040000U,
}

enum uint ISC_RET_MANUAL_CRED_VALIDATION = 0x00080000U;

enum : uint
{
    ISC_RET_RESERVED1           = 0x00100000U,
    ISC_RET_FRAGMENT_ONLY       = 0x00200000U,
    ISC_RET_FORWARD_CREDENTIALS = 0x00400000U,
}

enum uint ISC_RET_USED_HTTP_STYLE = 0x01000000U;
enum uint ISC_RET_NO_ADDITIONAL_TOKEN = 0x02000000U;
enum uint ISC_RET_REAUTHENTICATION = 0x08000000U;
enum uint ISC_RET_CONFIDENTIALITY_ONLY = 0x40000000U;

enum : ulong
{
    ISC_RET_MESSAGES                 = 0x0000000100000000UL,
    ISC_RET_DEFERRED_CRED_VALIDATION = 0x0000000200000000UL,
}

enum ulong ISC_RET_NO_POST_HANDSHAKE_AUTH = 0x0000000400000000UL;
enum ulong ISC_RET_REUSE_SESSION_TICKETS = 0x0000000800000000UL;
enum ulong ISC_RET_EXPLICIT_SESSION = 0x0000001000000000UL;

enum : uint
{
    ASC_RET_DELEGATE      = 0x00000001U,
    ASC_RET_MUTUAL_AUTH   = 0x00000002U,
    ASC_RET_REPLAY_DETECT = 0x00000004U,
}

enum uint ASC_RET_SEQUENCE_DETECT = 0x00000008U;
enum uint ASC_RET_CONFIDENTIALITY = 0x00000010U;
enum uint ASC_RET_USE_SESSION_KEY = 0x00000020U;
enum uint ASC_RET_SESSION_TICKET = 0x00000040U;
enum uint ASC_RET_ALLOCATED_MEMORY = 0x00000100U;
enum uint ASC_RET_USED_DCE_STYLE = 0x00000200U;

enum : uint
{
    ASC_RET_DATAGRAM         = 0x00000400U,
    ASC_RET_CONNECTION       = 0x00000800U,
    ASC_RET_CALL_LEVEL       = 0x00002000U,
    ASC_RET_THIRD_LEG_FAILED = 0x00004000U,
}

enum uint ASC_RET_EXTENDED_ERROR = 0x00008000U;

enum : uint
{
    ASC_RET_STREAM       = 0x00010000U,
    ASC_RET_INTEGRITY    = 0x00020000U,
    ASC_RET_LICENSING    = 0x00040000U,
    ASC_RET_IDENTIFY     = 0x00080000U,
    ASC_RET_NULL_SESSION = 0x00100000U,
}

enum : uint
{
    ASC_RET_ALLOW_NON_USER_LOGONS = 0x00200000U,
    ASC_RET_ALLOW_CONTEXT_REPLAY  = 0x00400000U,
}

enum uint ASC_RET_FRAGMENT_ONLY = 0x00800000U;

enum : uint
{
    ASC_RET_NO_TOKEN            = 0x01000000U,
    ASC_RET_NO_ADDITIONAL_TOKEN = 0x02000000U,
}

enum : ulong
{
    ASC_RET_MESSAGES              = 0x0000000100000000UL,
    ASC_RET_REUSE_SESSION_TICKETS = 0x0000000800000000UL,
}

enum ulong ASC_RET_EXPLICIT_SESSION = 0x0000001000000000UL;

enum : uint
{
    SECPKG_CRED_ATTR_NAMES                = 0x00000001U,
    SECPKG_CRED_ATTR_SSI_PROVIDER         = 0x00000002U,
    SECPKG_CRED_ATTR_KDC_PROXY_SETTINGS   = 0x00000003U,
    SECPKG_CRED_ATTR_KDC_NETWORK_SETTINGS = 0x00000003U,
    SECPKG_CRED_ATTR_CERT                 = 0x00000004U,
    SECPKG_CRED_ATTR_PAC_BYPASS           = 0x00000005U,
}

enum uint KDC_PROXY_SETTINGS_V1 = 0x00000001U;
enum uint KDC_NETWORK_SETTINGS_V2 = 0x00000002U;
enum uint KDC_PROXY_SETTINGS_FLAGS_FORCEPROXY = 0x00000001U;

enum : uint
{
    KDC_NETWORK_SETTINGS_FLAGS_FORCEPROXY          = 0x00000001U,
    KDC_NETWORK_SETTINGS_FLAGS_CONFIGURE_PROXY     = 0x80000000U,
    KDC_NETWORK_SETTINGS_FLAGS_CONFIGURE_DISCOVERY = 0x40000000U,
}

enum uint KDC_NETWORK_DISCOVERY_FLAGS_DS13_REQUIRED = 0x80000000U;

enum : uint
{
    SECPKG_ATTR_PROTO_INFO           = 0x00000007U,
    SECPKG_ATTR_USER_FLAGS           = 0x0000000bU,
    SECPKG_ATTR_USE_VALIDATED        = 0x0000000fU,
    SECPKG_ATTR_CREDENTIAL_NAME      = 0x00000010U,
    SECPKG_ATTR_TARGET               = 0x00000013U,
    SECPKG_ATTR_AUTHENTICATION_ID    = 0x00000014U,
    SECPKG_ATTR_LOGOFF_TIME          = 0x00000015U,
    SECPKG_ATTR_NEGO_KEYS            = 0x00000016U,
    SECPKG_ATTR_PROMPTING_NEEDED     = 0x00000018U,
    SECPKG_ATTR_NEGO_PKG_INFO        = 0x0000001fU,
    SECPKG_ATTR_NEGO_STATUS          = 0x00000020U,
    SECPKG_ATTR_CONTEXT_DELETED      = 0x00000021U,
    SECPKG_ATTR_APPLICATION_PROTOCOL = 0x00000023U,
}

enum uint SECPKG_ATTR_NEGOTIATED_TLS_EXTENSIONS = 0x00000024U;

enum : uint
{
    SECPKG_ATTR_IS_LOOPBACK                = 0x00000025U,
    SECPKG_ATTR_NEGO_INFO_FLAG_NO_KERBEROS = 0x00000001U,
    SECPKG_ATTR_NEGO_INFO_FLAG_NO_NTLM     = 0x00000002U,
}

enum : uint
{
    SECPKG_NEGOTIATION_COMPLETE      = 0x00000000U,
    SECPKG_NEGOTIATION_OPTIMISTIC    = 0x00000001U,
    SECPKG_NEGOTIATION_IN_PROGRESS   = 0x00000002U,
    SECPKG_NEGOTIATION_DIRECT        = 0x00000003U,
    SECPKG_NEGOTIATION_TRY_MULTICRED = 0x00000004U,
}

enum uint MAX_PROTOCOL_ID_SIZE = 0x000000ffU;

enum : uint
{
    SECQOP_WRAP_NO_ENCRYPT = 0x80000001U,
    SECQOP_WRAP_OOB_DATA   = 0x40000000U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SECURITY_ENTRYPOINT_ANSIW = "InitSecurityInterfaceW",
    // Native encoding: ansi
    SECURITY_ENTRYPOINT_ANSIA = "InitSecurityInterfaceA",
    // Native encoding: ansi
    SECURITY_ENTRYPOINT16     = "INITSECURITYINTERFACEA",
    SECURITY_ENTRYPOINT_ANSI  = "InitSecurityInterfaceW",
    SECURITY_ENTRYPOINT       = "INITSECURITYINTERFACEA",
}

enum : uint
{
    SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION   = 0x00000001U,
    SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_2 = 0x00000002U,
    SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_3 = 0x00000003U,
    SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_4 = 0x00000004U,
    SECURITY_SUPPORT_PROVIDER_INTERFACE_VERSION_5 = 0x00000005U,
}

enum : uint
{
    SASL_OPTION_SEND_SIZE        = 0x00000001U,
    SASL_OPTION_RECV_SIZE        = 0x00000002U,
    SASL_OPTION_AUTHZ_STRING     = 0x00000003U,
    SASL_OPTION_AUTHZ_PROCESSING = 0x00000004U,
}

enum : uint
{
    SEC_WINNT_AUTH_IDENTITY_VERSION_2                          = 0x00000201U,
    SEC_WINNT_AUTH_IDENTITY_VERSION                            = 0x00000200U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_PROCESS_ENCRYPTED            = 0x00000010U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SYSTEM_PROTECTED             = 0x00000020U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_USER_PROTECTED               = 0x00000040U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SYSTEM_ENCRYPTED             = 0x00000080U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_RESERVED                     = 0x00010000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_NULL_USER                    = 0x00020000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_NULL_DOMAIN                  = 0x00040000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_ID_PROVIDER                  = 0x00080000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_USE_MASK             = 0xff000000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_CREDPROV_DO_NOT_SAVE = 0x80000000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_BY_CALLER  = 0x80000000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_SAVE_CRED_CHECKED    = 0x40000000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_NO_CHECKBOX          = 0x20000000U,
    SEC_WINNT_AUTH_IDENTITY_FLAGS_SSPIPFC_CREDPROV_DO_NOT_LOAD = 0x10000000U,
}

enum uint SSPIPFC_CREDPROV_DO_NOT_SAVE = 0x00000001U;
enum uint SSPIPFC_SAVE_CRED_BY_CALLER = 0x00000001U;

enum : uint
{
    SSPIPFC_NO_CHECKBOX          = 0x00000002U,
    SSPIPFC_CREDPROV_DO_NOT_LOAD = 0x00000004U,
}

enum uint SSPIPFC_USE_CREDUIBROKER = 0x00000008U;

enum : uint
{
    NGC_DATA_FLAG_KERB_CERTIFICATE_LOGON_FLAG_CHECK_DUPLICATES     = 0x00000001U,
    NGC_DATA_FLAG_KERB_CERTIFICATE_LOGON_FLAG_USE_CERTIFICATE_INFO = 0x00000002U,
}

enum : uint
{
    NGC_DATA_FLAG_IS_SMARTCARD_DATA   = 0x00000004U,
    NGC_DATA_FLAG_IS_CLOUD_TRUST_CRED = 0x00000008U,
}

enum : uint
{
    SEC_WINNT_AUTH_IDENTITY_ENCRYPT_SAME_LOGON   = 0x00000001U,
    SEC_WINNT_AUTH_IDENTITY_ENCRYPT_SAME_PROCESS = 0x00000002U,
    SEC_WINNT_AUTH_IDENTITY_ENCRYPT_FOR_SYSTEM   = 0x00000004U,
    SEC_WINNT_AUTH_IDENTITY_MARSHALLED           = 0x00000004U,
    SEC_WINNT_AUTH_IDENTITY_ONLY                 = 0x00000008U,
}

enum uint SECPKG_OPTIONS_PERMANENT = 0x00000001U;
enum uint LOOKUP_VIEW_LOCAL_INFORMATION = 0x00000001U;
enum uint LOOKUP_TRANSLATE_NAMES = 0x00000800U;

enum : uint
{
    SECPKG_ATTR_ISSUER_LIST         = 0x00000050U,
    SECPKG_ATTR_REMOTE_CRED         = 0x00000051U,
    SECPKG_ATTR_SUPPORTED_ALGS      = 0x00000056U,
    SECPKG_ATTR_CIPHER_STRENGTHS    = 0x00000057U,
    SECPKG_ATTR_SUPPORTED_PROTOCOLS = 0x00000058U,
}

enum : uint
{
    SECPKG_ATTR_MAPPED_CRED_ATTR    = 0x0000005cU,
    SECPKG_ATTR_REMOTE_CERTIFICATES = 0x0000005fU,
}

enum : uint
{
    SECPKG_ATTR_CLIENT_CERT_POLICY = 0x00000060U,
    SECPKG_ATTR_CC_POLICY_RESULT   = 0x00000061U,
    SECPKG_ATTR_USE_NCRYPT         = 0x00000062U,
    SECPKG_ATTR_LOCAL_CERT_INFO    = 0x00000063U,
    SECPKG_ATTR_CIPHER_INFO        = 0x00000064U,
    SECPKG_ATTR_REMOTE_CERT_CHAIN  = 0x00000067U,
    SECPKG_ATTR_UI_INFO            = 0x00000068U,
    SECPKG_ATTR_KEYING_MATERIAL    = 0x0000006bU,
    SECPKG_ATTR_SRTP_PARAMETERS    = 0x0000006cU,
    SECPKG_ATTR_TOKEN_BINDING      = 0x0000006dU,
    SECPKG_ATTR_CONNECTION_INFO_EX = 0x0000006eU,
}

enum : uint
{
    SECPKG_ATTR_KEYING_MATERIAL_TOKEN_BINDING = 0x0000006fU,
    SECPKG_ATTR_KEYING_MATERIAL_INPROC        = 0x00000070U,
}

enum : uint
{
    SECPKG_ATTR_CERT_CHECK_RESULT        = 0x00000071U,
    SECPKG_ATTR_CERT_CHECK_RESULT_INPROC = 0x00000072U,
}

enum : uint
{
    SECPKG_ATTR_SESSION_TICKET_KEYS                   = 0x00000073U,
    SECPKG_ATTR_SERIALIZED_REMOTE_CERT_CONTEXT_INPROC = 0x00000074U,
    SECPKG_ATTR_SERIALIZED_REMOTE_CERT_CONTEXT        = 0x00000075U,
}

enum : uint
{
    SESSION_TICKET_INFO_V0      = 0x00000000U,
    SESSION_TICKET_INFO_VERSION = 0x00000000U,
}

enum int LSA_MODE_PASSWORD_PROTECTED = 0x00000001;
enum int LSA_MODE_INDIVIDUAL_ACCOUNTS = 0x00000002;
enum int LSA_MODE_MANDATORY_ACCESS = 0x00000004;
enum int LSA_MODE_LOG_FULL = 0x00000008;
enum int LSA_MAXIMUM_SID_COUNT = 0x00000100;
enum uint LSA_MAXIMUM_ENUMERATION_LENGTH = 0x00007d00U;
enum uint LSA_CALL_LICENSE_SERVER = 0x80000000U;
enum uint SE_ADT_OBJECT_ONLY = 0x00000001U;
enum uint SE_MAX_AUDIT_PARAMETERS = 0x00000020U;
enum uint SE_MAX_GENERIC_AUDIT_PARAMETERS = 0x0000001cU;

enum : uint
{
    SE_ADT_PARAMETERS_SELF_RELATIVE    = 0x00000001U,
    SE_ADT_PARAMETERS_SEND_TO_LSA      = 0x00000002U,
    SE_ADT_PARAMETER_EXTENSIBLE_AUDIT  = 0x00000004U,
    SE_ADT_PARAMETER_GENERIC_AUDIT     = 0x00000008U,
    SE_ADT_PARAMETER_WRITE_SYNCHRONOUS = 0x00000010U,
}

enum const(wchar)* LSA_ADT_SECURITY_SOURCE_NAME = "Microsoft-Windows-Security-Auditing";
enum const(wchar)* LSA_ADT_LEGACY_SECURITY_SOURCE_NAME = "Security";
enum uint SE_ADT_POLICY_AUDIT_EVENT_TYPE_EX_BEGIN = 0x00000064U;

enum : int
{
    POLICY_AUDIT_EVENT_UNCHANGED = 0x00000000,
    POLICY_AUDIT_EVENT_SUCCESS   = 0x00000001,
    POLICY_AUDIT_EVENT_FAILURE   = 0x00000002,
    POLICY_AUDIT_EVENT_NONE      = 0x00000004,
}

// Native encoding: ansi
enum const(wchar)* LSA_AP_NAME_INITIALIZE_PACKAGE = "LsaApInitializePackage\0";

enum : const(wchar)*
{
    // Native encoding: ansi
    LSA_AP_NAME_LOGON_USER               = "LsaApLogonUser\0",
    // Native encoding: ansi
    LSA_AP_NAME_LOGON_USER_EX            = "LsaApLogonUserEx\0",
    // Native encoding: ansi
    LSA_AP_NAME_CALL_PACKAGE             = "LsaApCallPackage\0",
    // Native encoding: ansi
    LSA_AP_NAME_LOGON_TERMINATED         = "LsaApLogonTerminated\0",
    // Native encoding: ansi
    LSA_AP_NAME_CALL_PACKAGE_UNTRUSTED   = "LsaApCallPackageUntrusted\0",
    // Native encoding: ansi
    LSA_AP_NAME_CALL_PACKAGE_PASSTHROUGH = "LsaApCallPackagePassthrough\0",
}

enum : int
{
    POLICY_VIEW_LOCAL_INFORMATION = 0x00000001,
    POLICY_VIEW_AUDIT_INFORMATION = 0x00000002,
}

enum int POLICY_GET_PRIVATE_INFORMATION = 0x00000004;
enum int POLICY_TRUST_ADMIN = 0x00000008;

enum : int
{
    POLICY_CREATE_ACCOUNT   = 0x00000010,
    POLICY_CREATE_SECRET    = 0x00000020,
    POLICY_CREATE_PRIVILEGE = 0x00000040,
}

enum int POLICY_SET_DEFAULT_QUOTA_LIMITS = 0x00000080;
enum int POLICY_SET_AUDIT_REQUIREMENTS = 0x00000100;
enum int POLICY_AUDIT_LOG_ADMIN = 0x00000200;
enum int POLICY_SERVER_ADMIN = 0x00000400;
enum int POLICY_LOOKUP_NAMES = 0x00000800;
enum int POLICY_NOTIFICATION = 0x00001000;
enum uint POLICY_MODE_COUNT = 0x0000000bU;
enum uint LSA_LOOKUP_ISOLATED_AS_LOCAL = 0x80000000U;
enum uint LSA_LOOKUP_DISALLOW_CONNECTED_ACCOUNT_INTERNET_SID = 0x80000000U;
enum uint LSA_LOOKUP_PREFER_INTERNET_NAMES = 0x40000000U;
enum uint PER_USER_POLICY_UNCHANGED = 0x00000000U;

enum : uint
{
    PER_USER_AUDIT_SUCCESS_INCLUDE = 0x00000001U,
    PER_USER_AUDIT_SUCCESS_EXCLUDE = 0x00000002U,
    PER_USER_AUDIT_FAILURE_INCLUDE = 0x00000004U,
    PER_USER_AUDIT_FAILURE_EXCLUDE = 0x00000008U,
    PER_USER_AUDIT_NONE            = 0x00000010U,
}

enum uint POLICY_QOS_SCHANNEL_REQUIRED = 0x00000001U;

enum : uint
{
    POLICY_QOS_OUTBOUND_INTEGRITY       = 0x00000002U,
    POLICY_QOS_OUTBOUND_CONFIDENTIALITY = 0x00000004U,
}

enum : uint
{
    POLICY_QOS_INBOUND_INTEGRITY       = 0x00000008U,
    POLICY_QOS_INBOUND_CONFIDENTIALITY = 0x00000010U,
}

enum uint POLICY_QOS_ALLOW_LOCAL_ROOT_CERT_STORE = 0x00000020U;
enum uint POLICY_QOS_RAS_SERVER_ALLOWED = 0x00000040U;
enum uint POLICY_QOS_DHCP_SERVER_ALLOWED = 0x00000080U;
enum uint POLICY_KERBEROS_VALIDATE_CLIENT = 0x00000080U;

enum : int
{
    ACCOUNT_VIEW                 = 0x00000001,
    ACCOUNT_ADJUST_PRIVILEGES    = 0x00000002,
    ACCOUNT_ADJUST_QUOTAS        = 0x00000004,
    ACCOUNT_ADJUST_SYSTEM_ACCESS = 0x00000008,
}

enum : int
{
    TRUSTED_QUERY_DOMAIN_NAME = 0x00000001,
    TRUSTED_QUERY_CONTROLLERS = 0x00000002,
}

enum int TRUSTED_SET_CONTROLLERS = 0x00000004;

enum : int
{
    TRUSTED_QUERY_POSIX = 0x00000008,
    TRUSTED_SET_POSIX   = 0x00000010,
    TRUSTED_SET_AUTH    = 0x00000020,
    TRUSTED_QUERY_AUTH  = 0x00000040,
}

enum uint LSAD_AES_CRYPT_SHA512_HASH_SIZE = 0x00000040U;

enum : uint
{
    LSAD_AES_KEY_SIZE   = 0x00000010U,
    LSAD_AES_SALT_SIZE  = 0x00000010U,
    LSAD_AES_BLOCK_SIZE = 0x00000010U,
}

enum : uint
{
    TRUST_TYPE_AAD                                       = 0x00000005U,
    TRUST_ATTRIBUTE_TREE_PARENT                          = 0x00400000U,
    TRUST_ATTRIBUTE_TREE_ROOT                            = 0x00800000U,
    TRUST_ATTRIBUTES_VALID                               = 0xff02ffffU,
    TRUST_ATTRIBUTE_QUARANTINED_DOMAIN                   = 0x00000004U,
    TRUST_ATTRIBUTE_TRUST_USES_RC4_ENCRYPTION            = 0x00000080U,
    TRUST_ATTRIBUTE_TRUST_USES_AES_KEYS                  = 0x00000100U,
    TRUST_ATTRIBUTE_CROSS_ORGANIZATION_NO_TGT_DELEGATION = 0x00000200U,
}

enum : uint
{
    TRUST_ATTRIBUTE_PIM_TRUST                                = 0x00000400U,
    TRUST_ATTRIBUTE_CROSS_ORGANIZATION_ENABLE_TGT_DELEGATION = 0x00000800U,
}

enum uint TRUST_ATTRIBUTE_DISABLE_AUTH_TARGET_VALIDATION = 0x00001000U;
enum uint TRUST_ATTRIBUTES_USER = 0xff000000U;
enum uint LSA_FOREST_TRUST_RECORD_TYPE_UNRECOGNIZED = 0x80000000U;
enum int LSA_FTRECORD_DISABLED_REASONS = 0x0000ffff;

enum : int
{
    LSA_TLN_DISABLED_NEW      = 0x00000001,
    LSA_TLN_DISABLED_ADMIN    = 0x00000002,
    LSA_TLN_DISABLED_CONFLICT = 0x00000004,
}

enum : int
{
    LSA_SID_DISABLED_ADMIN    = 0x00000001,
    LSA_SID_DISABLED_CONFLICT = 0x00000002,
}

enum : int
{
    LSA_NB_DISABLED_ADMIN    = 0x00000004,
    LSA_NB_DISABLED_CONFLICT = 0x00000008,
}

enum int LSA_SCANNER_INFO_DISABLE_AUTH_TARGET_VALIDATION = 0x00000001;
enum int LSA_SCANNER_INFO_ADMIN_ALL_FLAGS = 0x00000001;
enum uint MAX_RECORDS_IN_FOREST_TRUST_INFO = 0x00000fa0U;

enum : int
{
    SECRET_SET_VALUE   = 0x00000001,
    SECRET_QUERY_VALUE = 0x00000002,
}

enum const(wchar)* LSA_GLOBAL_SECRET_PREFIX = "G$";
enum uint LSA_GLOBAL_SECRET_PREFIX_LENGTH = 0x00000002U;
enum const(wchar)* LSA_LOCAL_SECRET_PREFIX = "L$";
enum uint LSA_LOCAL_SECRET_PREFIX_LENGTH = 0x00000002U;
enum const(wchar)* LSA_MACHINE_SECRET_PREFIX = "M$";

enum : int
{
    LSA_SECRET_MAXIMUM_COUNT  = 0x00001000,
    LSA_SECRET_MAXIMUM_LENGTH = 0x00000200,
}

enum uint MAXIMUM_CAPES_PER_CAP = 0x0000007fU;

enum : uint
{
    CENTRAL_ACCESS_POLICY_OWNER_RIGHTS_PRESENT_FLAG        = 0x00000001U,
    CENTRAL_ACCESS_POLICY_STAGED_OWNER_RIGHTS_PRESENT_FLAG = 0x00000100U,
    CENTRAL_ACCESS_POLICY_STAGED_FLAG                      = 0x00010000U,
}

enum : uint
{
    LSASETCAPS_RELOAD_FLAG     = 0x00000001U,
    LSASETCAPS_VALID_FLAG_MASK = 0x00000001U,
}

enum const(wchar)* SE_INTERACTIVE_LOGON_NAME = "SeInteractiveLogonRight";
enum const(wchar)* SE_NETWORK_LOGON_NAME = "SeNetworkLogonRight";
enum const(wchar)* SE_BATCH_LOGON_NAME = "SeBatchLogonRight";
enum const(wchar)* SE_SERVICE_LOGON_NAME = "SeServiceLogonRight";
enum const(wchar)* SE_DENY_INTERACTIVE_LOGON_NAME = "SeDenyInteractiveLogonRight";
enum const(wchar)* SE_DENY_NETWORK_LOGON_NAME = "SeDenyNetworkLogonRight";
enum const(wchar)* SE_DENY_BATCH_LOGON_NAME = "SeDenyBatchLogonRight";
enum const(wchar)* SE_DENY_SERVICE_LOGON_NAME = "SeDenyServiceLogonRight";
enum const(wchar)* SE_REMOTE_INTERACTIVE_LOGON_NAME = "SeRemoteInteractiveLogonRight";
enum const(wchar)* SE_DENY_REMOTE_INTERACTIVE_LOGON_NAME = "SeDenyRemoteInteractiveLogonRight";

enum : uint
{
    NEGOTIATE_MAX_PREFIX = 0x00000020U,
    NEGOTIATE_ALLOW_NTLM = 0x10000000U,
    NEGOTIATE_NEG_NTLM   = 0x20000000U,
}

enum uint MAX_USER_RECORDS = 0x000003e8U;

enum : uint
{
    versionbyte        = 0x00000001U,
    versionbyte_length = 0x00000001U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    LSAD_AES_256_ALG           = "AEAD-AES-256-CBC-HMAC-SHA512",
    // Native encoding: ansi
    LSAD_AES256_ENC_KEY_STRING = "Microsoft LSAD encryption key AEAD-AES-256-CBC-HMAC-SHA512 16",
    // Native encoding: ansi
    LSAD_AES256_MAC_KEY_STRING = "Microsoft LSAD MAC key AEAD-AES-256-CBC-HMAC-SHA512 16",
}

enum : GUID
{
    Audit_System_SecurityStateChange        = GUID("0cce9210-69ae-11d9-bed3-505054503030"),
    Audit_System_SecuritySubsystemExtension = GUID("0cce9211-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_System_Integrity         = GUID("0cce9212-69ae-11d9-bed3-505054503030"),
    Audit_System_IPSecDriverEvents = GUID("0cce9213-69ae-11d9-bed3-505054503030"),
    Audit_System_Others            = GUID("0cce9214-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_Logon_Logon          = GUID("0cce9215-69ae-11d9-bed3-505054503030"),
    Audit_Logon_Logoff         = GUID("0cce9216-69ae-11d9-bed3-505054503030"),
    Audit_Logon_AccountLockout = GUID("0cce9217-69ae-11d9-bed3-505054503030"),
    Audit_Logon_IPSecMainMode  = GUID("0cce9218-69ae-11d9-bed3-505054503030"),
    Audit_Logon_IPSecQuickMode = GUID("0cce9219-69ae-11d9-bed3-505054503030"),
    Audit_Logon_IPSecUserMode  = GUID("0cce921a-69ae-11d9-bed3-505054503030"),
    Audit_Logon_SpecialLogon   = GUID("0cce921b-69ae-11d9-bed3-505054503030"),
    Audit_Logon_Others         = GUID("0cce921c-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_ObjectAccess_FileSystem            = GUID("0cce921d-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Registry              = GUID("0cce921e-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Kernel                = GUID("0cce921f-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Sam                   = GUID("0cce9220-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_CertificationServices = GUID("0cce9221-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_ApplicationGenerated  = GUID("0cce9222-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Handle                = GUID("0cce9223-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Share                 = GUID("0cce9224-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_FirewallPacketDrops   = GUID("0cce9225-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_FirewallConnection    = GUID("0cce9226-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_Other                 = GUID("0cce9227-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_PrivilegeUse_Sensitive    = GUID("0cce9228-69ae-11d9-bed3-505054503030"),
    Audit_PrivilegeUse_NonSensitive = GUID("0cce9229-69ae-11d9-bed3-505054503030"),
    Audit_PrivilegeUse_Others       = GUID("0cce922a-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_DetailedTracking_ProcessCreation    = GUID("0cce922b-69ae-11d9-bed3-505054503030"),
    Audit_DetailedTracking_ProcessTermination = GUID("0cce922c-69ae-11d9-bed3-505054503030"),
    Audit_DetailedTracking_DpapiActivity      = GUID("0cce922d-69ae-11d9-bed3-505054503030"),
    Audit_DetailedTracking_RpcCall            = GUID("0cce922e-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_PolicyChange_AuditPolicy          = GUID("0cce922f-69ae-11d9-bed3-505054503030"),
    Audit_PolicyChange_AuthenticationPolicy = GUID("0cce9230-69ae-11d9-bed3-505054503030"),
    Audit_PolicyChange_AuthorizationPolicy  = GUID("0cce9231-69ae-11d9-bed3-505054503030"),
    Audit_PolicyChange_MpsscvRulePolicy     = GUID("0cce9232-69ae-11d9-bed3-505054503030"),
    Audit_PolicyChange_WfpIPSecPolicy       = GUID("0cce9233-69ae-11d9-bed3-505054503030"),
    Audit_PolicyChange_Others               = GUID("0cce9234-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_AccountManagement_UserAccount       = GUID("0cce9235-69ae-11d9-bed3-505054503030"),
    Audit_AccountManagement_ComputerAccount   = GUID("0cce9236-69ae-11d9-bed3-505054503030"),
    Audit_AccountManagement_SecurityGroup     = GUID("0cce9237-69ae-11d9-bed3-505054503030"),
    Audit_AccountManagement_DistributionGroup = GUID("0cce9238-69ae-11d9-bed3-505054503030"),
    Audit_AccountManagement_ApplicationGroup  = GUID("0cce9239-69ae-11d9-bed3-505054503030"),
    Audit_AccountManagement_Others            = GUID("0cce923a-69ae-11d9-bed3-505054503030"),
}

enum GUID Audit_DSAccess_DSAccess = GUID("0cce923b-69ae-11d9-bed3-505054503030");
enum GUID Audit_DsAccess_AdAuditChanges = GUID("0cce923c-69ae-11d9-bed3-505054503030");

enum : GUID
{
    Audit_Ds_Replication         = GUID("0cce923d-69ae-11d9-bed3-505054503030"),
    Audit_Ds_DetailedReplication = GUID("0cce923e-69ae-11d9-bed3-505054503030"),
}

enum : GUID
{
    Audit_AccountLogon_CredentialValidation     = GUID("0cce923f-69ae-11d9-bed3-505054503030"),
    Audit_AccountLogon_Kerberos                 = GUID("0cce9240-69ae-11d9-bed3-505054503030"),
    Audit_AccountLogon_Others                   = GUID("0cce9241-69ae-11d9-bed3-505054503030"),
    Audit_AccountLogon_KerbCredentialValidation = GUID("0cce9242-69ae-11d9-bed3-505054503030"),
}

enum GUID Audit_Logon_NPS = GUID("0cce9243-69ae-11d9-bed3-505054503030");

enum : GUID
{
    Audit_ObjectAccess_DetailedFileShare = GUID("0cce9244-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_RemovableStorage  = GUID("0cce9245-69ae-11d9-bed3-505054503030"),
    Audit_ObjectAccess_CbacStaging       = GUID("0cce9246-69ae-11d9-bed3-505054503030"),
}

enum GUID Audit_Logon_Claims = GUID("0cce9247-69ae-11d9-bed3-505054503030");
enum GUID Audit_DetailedTracking_PnpActivity = GUID("0cce9248-69ae-11d9-bed3-505054503030");
enum GUID Audit_Logon_Groups = GUID("0cce9249-69ae-11d9-bed3-505054503030");
enum GUID Audit_DetailedTracking_TokenRightAdjusted = GUID("0cce924a-69ae-11d9-bed3-505054503030");
enum GUID Audit_Logon_AccessRights = GUID("0cce924b-69ae-11d9-bed3-505054503030");

enum : GUID
{
    Audit_System       = GUID("69979848-797a-11d9-bed3-505054503030"),
    Audit_Logon        = GUID("69979849-797a-11d9-bed3-505054503030"),
    Audit_ObjectAccess = GUID("6997984a-797a-11d9-bed3-505054503030"),
}

enum GUID Audit_PrivilegeUse = GUID("6997984b-797a-11d9-bed3-505054503030");
enum GUID Audit_DetailedTracking = GUID("6997984c-797a-11d9-bed3-505054503030");
enum GUID Audit_PolicyChange = GUID("6997984d-797a-11d9-bed3-505054503030");
enum GUID Audit_AccountManagement = GUID("6997984e-797a-11d9-bed3-505054503030");
enum GUID Audit_DirectoryServiceAccess = GUID("6997984f-797a-11d9-bed3-505054503030");
enum GUID Audit_AccountLogon = GUID("69979850-797a-11d9-bed3-505054503030");
enum int DOMAIN_NO_LM_OWF_CHANGE = 0x00000040;
// Native encoding: ansi
enum const(wchar)* SAM_PASSWORD_CHANGE_NOTIFY_ROUTINE = "PasswordChangeNotify";
// Native encoding: ansi
enum const(wchar)* SAM_INIT_NOTIFICATION_ROUTINE = "InitializeChangeNotify";
// Native encoding: ansi
enum const(wchar)* SAM_PASSWORD_FILTER_ROUTINE = "PasswordFilter";

enum : const(wchar)*
{
    // Native encoding: ansi
    MSV1_0_PACKAGE_NAME  = "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0",
    MSV1_0_PACKAGE_NAMEW = "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    MSV1_0_SUBAUTHENTICATION_KEY   = "SYSTEM\\CurrentControlSet\\Control\\Lsa\\MSV1_0",
    // Native encoding: ansi
    MSV1_0_SUBAUTHENTICATION_VALUE = "Auth",
}

enum uint MSV1_0_CHALLENGE_LENGTH = 0x00000008U;
enum uint MSV1_0_USER_SESSION_KEY_LENGTH = 0x00000010U;
enum uint MSV1_0_LANMAN_SESSION_KEY_LENGTH = 0x00000008U;
enum uint MSV1_0_USE_CLIENT_CHALLENGE = 0x00000080U;
enum uint MSV1_0_DISABLE_PERSONAL_FALLBACK = 0x00001000U;
enum uint MSV1_0_ALLOW_FORCE_GUEST = 0x00002000U;
enum uint MSV1_0_CLEARTEXT_PASSWORD_SUPPLIED = 0x00004000U;
enum uint MSV1_0_USE_DOMAIN_FOR_ROUTING_ONLY = 0x00008000U;
enum uint MSV1_0_SUBAUTHENTICATION_DLL_EX = 0x00100000U;
enum uint MSV1_0_ALLOW_MSVCHAPV2 = 0x00010000U;

enum : uint
{
    MSV1_0_S4U2SELF                 = 0x00020000U,
    MSV1_0_CHECK_LOGONHOURS_FOR_S4U = 0x00040000U,
}

enum uint MSV1_0_INTERNET_DOMAIN = 0x00080000U;

enum : uint
{
    MSV1_0_SUBAUTHENTICATION_DLL       = 0xff000000U,
    MSV1_0_SUBAUTHENTICATION_DLL_SHIFT = 0x00000018U,
}

enum : uint
{
    MSV1_0_MNS_LOGON                 = 0x01000000U,
    MSV1_0_SUBAUTHENTICATION_DLL_RAS = 0x00000002U,
    MSV1_0_SUBAUTHENTICATION_DLL_IIS = 0x00000084U,
}

enum uint MSV1_0_S4U_LOGON_FLAG_CHECK_LOGONHOURS = 0x00000002U;
enum uint LOGON_NTLMV2_ENABLED = 0x00000100U;

enum : uint
{
    LOGON_NT_V2     = 0x00000800U,
    LOGON_LM_V2     = 0x00001000U,
    LOGON_NTLM_V2   = 0x00002000U,
    LOGON_OPTIMIZED = 0x00004000U,
}

enum : uint
{
    LOGON_WINLOGON     = 0x00008000U,
    LOGON_PKINIT       = 0x00010000U,
    LOGON_NO_OPTIMIZED = 0x00020000U,
    LOGON_NO_ELEVATION = 0x00040000U,
}

enum uint LOGON_MANAGED_SERVICE = 0x00080000U;
enum uint MSV1_0_SUBAUTHENTICATION_FLAGS = 0xff000000U;
enum uint LOGON_GRACE_LOGON = 0x01000000U;
enum uint MSV1_0_OWF_PASSWORD_LENGTH = 0x00000010U;
enum uint MSV1_0_SHA_PASSWORD_LENGTH = 0x00000014U;
enum uint MSV1_0_CREDENTIAL_KEY_LENGTH = 0x00000014U;

enum : uint
{
    MSV1_0_CRED_REMOVED            = 0x00000004U,
    MSV1_0_CRED_CREDKEY_PRESENT    = 0x00000008U,
    MSV1_0_CRED_SHA_PRESENT        = 0x00000010U,
    MSV1_0_CRED_VERSION_V2         = 0x00000002U,
    MSV1_0_CRED_VERSION_V3         = 0x00000004U,
    MSV1_0_CRED_VERSION_IUM        = 0xffff0001U,
    MSV1_0_CRED_VERSION_REMOTE     = 0xffff0002U,
    MSV1_0_CRED_VERSION_ARSO       = 0xffff0003U,
    MSV1_0_CRED_VERSION_RESERVED_1 = 0xfffffffeU,
    MSV1_0_CRED_VERSION_INVALID    = 0xffffffffU,
}

enum : uint
{
    MSV1_0_NTLM3_RESPONSE_LENGTH = 0x00000010U,
    MSV1_0_NTLM3_OWF_LENGTH      = 0x00000010U,
}

enum : uint
{
    MSV1_0_MAX_NTLM3_LIFE = 0x00000708U,
    MSV1_0_MAX_AVL_SIZE   = 0x0000fa00U,
}

enum : uint
{
    MSV1_0_AV_FLAG_FORCE_GUEST            = 0x00000001U,
    MSV1_0_AV_FLAG_MIC_HANDSHAKE_MESSAGES = 0x00000002U,
    MSV1_0_AV_FLAG_UNVERIFIED_TARGET      = 0x00000004U,
}

enum : uint
{
    RTL_ENCRYPT_MEMORY_SIZE          = 0x00000008U,
    RTL_ENCRYPT_OPTION_CROSS_PROCESS = 0x00000001U,
    RTL_ENCRYPT_OPTION_SAME_LOGON    = 0x00000002U,
    RTL_ENCRYPT_OPTION_FOR_SYSTEM    = 0x00000004U,
}

enum : uint
{
    KERBEROS_VERSION  = 0x00000005U,
    KERBEROS_REVISION = 0x00000006U,
}

enum : uint
{
    KERB_ETYPE_AES128_CTS_HMAC_SHA1_96 = 0x00000011U,
    KERB_ETYPE_AES256_CTS_HMAC_SHA1_96 = 0x00000012U,
    KERB_ETYPE_AES128_CTS_HMAC_SHA256  = 0x00000013U,
    KERB_ETYPE_AES256_CTS_HMAC_SHA384  = 0x00000014U,
}

enum : int
{
    KERB_ETYPE_RC4_PLAIN2                    = 0xffffff7f,
    KERB_ETYPE_RC4_LM                        = 0xffffff7e,
    KERB_ETYPE_RC4_SHA                       = 0xffffff7d,
    KERB_ETYPE_DES_PLAIN                     = 0xffffff7c,
    KERB_ETYPE_RC4_HMAC_OLD                  = 0xffffff7b,
    KERB_ETYPE_RC4_PLAIN_OLD                 = 0xffffff7a,
    KERB_ETYPE_RC4_HMAC_OLD_EXP              = 0xffffff79,
    KERB_ETYPE_RC4_PLAIN_OLD_EXP             = 0xffffff78,
    KERB_ETYPE_RC4_PLAIN                     = 0xffffff74,
    KERB_ETYPE_RC4_PLAIN_EXP                 = 0xffffff73,
    KERB_ETYPE_AES128_CTS_HMAC_SHA1_96_PLAIN = 0xffffff6c,
}

enum int KERB_ETYPE_AES256_CTS_HMAC_SHA1_96_PLAIN = 0xffffff6b;

enum : uint
{
    KERB_ETYPE_DSA_SHA1_CMS     = 0x00000009U,
    KERB_ETYPE_RSA_MD5_CMS      = 0x0000000aU,
    KERB_ETYPE_RSA_SHA1_CMS     = 0x0000000bU,
    KERB_ETYPE_RC2_CBC_ENV      = 0x0000000cU,
    KERB_ETYPE_RSA_ENV          = 0x0000000dU,
    KERB_ETYPE_RSA_ES_OEAP_ENV  = 0x0000000eU,
    KERB_ETYPE_DES_EDE3_CBC_ENV = 0x0000000fU,
    KERB_ETYPE_DSA_SIGN         = 0x00000008U,
    KERB_ETYPE_RSA_PRIV         = 0x00000009U,
    KERB_ETYPE_RSA_PUB          = 0x0000000aU,
    KERB_ETYPE_RSA_PUB_MD5      = 0x0000000bU,
    KERB_ETYPE_RSA_PUB_SHA1     = 0x0000000cU,
    KERB_ETYPE_PKCS7_PUB        = 0x0000000dU,
    KERB_ETYPE_DES3_CBC_MD5     = 0x00000005U,
    KERB_ETYPE_DES3_CBC_SHA1    = 0x00000007U,
    KERB_ETYPE_DES3_CBC_SHA1_KD = 0x00000010U,
    KERB_ETYPE_DES_CBC_MD5_NT   = 0x00000014U,
    KERB_ETYPE_RC4_HMAC_NT_EXP  = 0x00000018U,
}

enum : uint
{
    KERB_CHECKSUM_NONE                = 0x00000000U,
    KERB_CHECKSUM_CRC32               = 0x00000001U,
    KERB_CHECKSUM_MD4                 = 0x00000002U,
    KERB_CHECKSUM_KRB_DES_MAC         = 0x00000004U,
    KERB_CHECKSUM_KRB_DES_MAC_K       = 0x00000005U,
    KERB_CHECKSUM_MD5                 = 0x00000007U,
    KERB_CHECKSUM_MD5_DES             = 0x00000008U,
    KERB_CHECKSUM_SHA1_NEW            = 0x0000000eU,
    KERB_CHECKSUM_HMAC_SHA1_96_AES128 = 0x0000000fU,
    KERB_CHECKSUM_HMAC_SHA1_96_AES256 = 0x00000010U,
}

enum : int
{
    KERB_CHECKSUM_LM                     = 0xffffff7e,
    KERB_CHECKSUM_SHA1                   = 0xffffff7d,
    KERB_CHECKSUM_REAL_CRC32             = 0xffffff7c,
    KERB_CHECKSUM_DES_MAC                = 0xffffff7b,
    KERB_CHECKSUM_DES_MAC_MD5            = 0xffffff7a,
    KERB_CHECKSUM_MD25                   = 0xffffff79,
    KERB_CHECKSUM_RC4_MD5                = 0xffffff78,
    KERB_CHECKSUM_MD5_HMAC               = 0xffffff77,
    KERB_CHECKSUM_HMAC_MD5               = 0xffffff76,
    KERB_CHECKSUM_SHA256                 = 0xffffff75,
    KERB_CHECKSUM_SHA384                 = 0xffffff74,
    KERB_CHECKSUM_SHA512                 = 0xffffff73,
    KERB_CHECKSUM_HMAC_SHA1_96_AES128_Ki = 0xffffff6a,
    KERB_CHECKSUM_HMAC_SHA1_96_AES256_Ki = 0xffffff69,
}

enum : uint
{
    AUTH_REQ_ALLOW_FORWARDABLE     = 0x00000001U,
    AUTH_REQ_ALLOW_PROXIABLE       = 0x00000002U,
    AUTH_REQ_ALLOW_POSTDATE        = 0x00000004U,
    AUTH_REQ_ALLOW_RENEWABLE       = 0x00000008U,
    AUTH_REQ_ALLOW_NOADDRESS       = 0x00000010U,
    AUTH_REQ_ALLOW_ENC_TKT_IN_SKEY = 0x00000020U,
    AUTH_REQ_ALLOW_VALIDATE        = 0x00000040U,
}

enum uint AUTH_REQ_VALIDATE_CLIENT = 0x00000080U;
enum uint AUTH_REQ_OK_AS_DELEGATE = 0x00000100U;
enum uint AUTH_REQ_PREAUTH_REQUIRED = 0x00000200U;
enum uint AUTH_REQ_TRANSITIVE_TRUST = 0x00000400U;
enum uint AUTH_REQ_ALLOW_S4U_DELEGATE = 0x00000800U;

enum : uint
{
    KERB_TICKET_FLAGS_name_canonicalize = 0x00010000U,
    KERB_TICKET_FLAGS_cname_in_pa_data  = 0x00040000U,
    KERB_TICKET_FLAGS_enc_pa_rep        = 0x00010000U,
}

enum : uint
{
    KRB_NT_UNKNOWN   = 0x00000000U,
    KRB_NT_PRINCIPAL = 0x00000001U,
}

enum int KRB_NT_PRINCIPAL_AND_ID = 0xffffff7d;
enum uint KRB_NT_SRV_INST = 0x00000002U;
enum int KRB_NT_SRV_INST_AND_ID = 0xffffff7c;

enum : uint
{
    KRB_NT_SRV_HST              = 0x00000003U,
    KRB_NT_SRV_XHST             = 0x00000004U,
    KRB_NT_UID                  = 0x00000005U,
    KRB_NT_ENTERPRISE_PRINCIPAL = 0x0000000aU,
}

enum uint KRB_NT_WELLKNOWN = 0x0000000bU;
enum int KRB_NT_ENT_PRINCIPAL_AND_ID = 0xffffff7e;

enum : int
{
    KRB_NT_MS_PRINCIPAL        = 0xffffff80,
    KRB_NT_MS_PRINCIPAL_AND_ID = 0xffffff7f,
}

enum int KRB_NT_MS_BRANCH_ID = 0xffffff7b;
enum uint KRB_NT_X500_PRINCIPAL = 0x00000006U;
enum const(wchar)* KRB_WELLKNOWN_STRING = "WELLKNOWN";
enum const(wchar)* KRB_ANONYMOUS_STRING = "ANONYMOUS";
enum uint KERB_WRAP_NO_ENCRYPT = 0x80000001U;

enum : uint
{
    KERB_CERTIFICATE_LOGON_FLAG_CHECK_DUPLICATES     = 0x00000001U,
    KERB_CERTIFICATE_LOGON_FLAG_USE_CERTIFICATE_INFO = 0x00000002U,
}

enum : uint
{
    KERB_CERTIFICATE_S4U_LOGON_FLAG_CHECK_DUPLICATES                = 0x00000001U,
    KERB_CERTIFICATE_S4U_LOGON_FLAG_CHECK_LOGONHOURS                = 0x00000002U,
    KERB_CERTIFICATE_S4U_LOGON_FLAG_FAIL_IF_NT_AUTH_POLICY_REQUIRED = 0x00000004U,
    KERB_CERTIFICATE_S4U_LOGON_FLAG_IDENTIFY                        = 0x00000008U,
}

enum : uint
{
    KERB_LOGON_FLAG_ALLOW_EXPIRED_TICKET = 0x00000001U,
    KERB_LOGON_FLAG_REDIRECTED           = 0x00000002U,
}

enum : uint
{
    KERB_S4U_LOGON_FLAG_CHECK_LOGONHOURS = 0x00000002U,
    KERB_S4U_LOGON_FLAG_IDENTIFY         = 0x00000008U,
}

enum uint KERB_USE_DEFAULT_TICKET_FLAGS = 0x00000000U;

enum : uint
{
    KERB_RETRIEVE_TICKET_DEFAULT        = 0x00000000U,
    KERB_RETRIEVE_TICKET_DONT_USE_CACHE = 0x00000001U,
    KERB_RETRIEVE_TICKET_USE_CACHE_ONLY = 0x00000002U,
    KERB_RETRIEVE_TICKET_USE_CREDHANDLE = 0x00000004U,
    KERB_RETRIEVE_TICKET_AS_KERB_CRED   = 0x00000008U,
    KERB_RETRIEVE_TICKET_WITH_SEC_CRED  = 0x00000010U,
    KERB_RETRIEVE_TICKET_CACHE_TICKET   = 0x00000020U,
    KERB_RETRIEVE_TICKET_MAX_LIFETIME   = 0x00000040U,
}

enum uint KERB_ETYPE_DEFAULT = 0x00000000U;
enum uint KERB_PURGE_ALL_TICKETS = 0x00000001U;
enum uint KERB_S4U2PROXY_CACHE_ENTRY_INFO_FLAG_NEGATIVE = 0x00000001U;
enum uint KERB_S4U2PROXY_CRED_FLAG_NEGATIVE = 0x00000001U;

enum : uint
{
    KERB_REFRESH_POLICY_KERBEROS = 0x00000001U,
    KERB_REFRESH_POLICY_KDC      = 0x00000002U,
}

enum uint KERB_CLOUD_KERBEROS_DEBUG_DATA_VERSION = 0x00000001U;
enum uint DS_UNKNOWN_ADDRESS_TYPE = 0x00000000U;

enum : uint
{
    KERB_SETPASS_USE_LOGONID    = 0x00000001U,
    KERB_SETPASS_USE_CREDHANDLE = 0x00000002U,
}

enum uint KERB_DECRYPT_FLAG_DEFAULT_KEY = 0x00000001U;

enum : uint
{
    KERB_REFRESH_SCCRED_RELEASE = 0x00000000U,
    KERB_REFRESH_SCCRED_GETTGT  = 0x00000001U,
}

enum uint KERB_REQUEST_CRED_LOCAL_ACCOUNT = 0x00000008U;

enum : uint
{
    KERB_TRANSFER_CRED_WITH_TICKETS        = 0x00000001U,
    KERB_TRANSFER_CRED_CLEANUP_CREDENTIALS = 0x00000002U,
}

enum uint KERB_QUERY_DOMAIN_EXTENDED_POLICIES_RESPONSE_FLAG_DAC_DISABLED = 0x00000001U;
enum uint AUDIT_SET_SYSTEM_POLICY = 0x00000001U;
enum uint AUDIT_QUERY_SYSTEM_POLICY = 0x00000002U;
enum uint AUDIT_SET_USER_POLICY = 0x00000004U;
enum uint AUDIT_QUERY_USER_POLICY = 0x00000008U;
enum uint AUDIT_ENUMERATE_USERS = 0x00000010U;
enum uint AUDIT_SET_MISC_POLICY = 0x00000020U;
enum uint AUDIT_QUERY_MISC_POLICY = 0x00000040U;

enum : const(wchar)*
{
    // Native encoding: ansi
    PKU2U_PACKAGE_NAME_A = "pku2u",
    PKU2U_PACKAGE_NAME   = "pku2u",
    PKU2U_PACKAGE_NAME_W = "pku2u",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE                      = "CredentialUpdateNotify",
    // Native encoding: ansi
    SAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE                    = "CredentialUpdateRegister",
    // Native encoding: ansi
    SAM_CREDENTIAL_UPDATE_FREE_ROUTINE                        = "CredentialUpdateFree",
    // Native encoding: ansi
    SAM_CREDENTIAL_UPDATE_REGISTER_MAPPED_ENTRYPOINTS_ROUTINE = "RegisterMappedEntrypoints",
}

enum : uint
{
    SECPKG_CLIENT_PROCESS_TERMINATED = 0x00000001U,
    SECPKG_CLIENT_THREAD_TERMINATED  = 0x00000002U,
}

enum : uint
{
    SECPKG_CALL_KERNEL_MODE                = 0x00000001U,
    SECPKG_CALL_ANSI                       = 0x00000002U,
    SECPKG_CALL_URGENT                     = 0x00000004U,
    SECPKG_CALL_RECURSIVE                  = 0x00000008U,
    SECPKG_CALL_IN_PROC                    = 0x00000010U,
    SECPKG_CALL_CLEANUP                    = 0x00000020U,
    SECPKG_CALL_WOWCLIENT                  = 0x00000040U,
    SECPKG_CALL_THREAD_TERM                = 0x00000080U,
    SECPKG_CALL_PROCESS_TERM               = 0x00000100U,
    SECPKG_CALL_IS_TCB                     = 0x00000200U,
    SECPKG_CALL_NETWORK_ONLY               = 0x00000400U,
    SECPKG_CALL_WINLOGON                   = 0x00000800U,
    SECPKG_CALL_ASYNC_UPDATE               = 0x00001000U,
    SECPKG_CALL_SYSTEM_PROC                = 0x00002000U,
    SECPKG_CALL_NEGO                       = 0x00004000U,
    SECPKG_CALL_NEGO_EXTENDER              = 0x00008000U,
    SECPKG_CALL_BUFFER_MARSHAL             = 0x00010000U,
    SECPKG_CALL_UNLOCK                     = 0x00020000U,
    SECPKG_CALL_CLOUDAP_CONNECT            = 0x00040000U,
    SECPKG_CALL_WOWX86                     = 0x00000040U,
    SECPKG_CALL_WOWA32                     = 0x00040000U,
    SECPKG_CREDENTIAL_VERSION              = 0x000000c9U,
    SECPKG_CREDENTIAL_FLAGS_CALLER_HAS_TCB = 0x00000001U,
    SECPKG_CREDENTIAL_FLAGS_CREDMAN_CRED   = 0x00000002U,
}

enum uint SECPKG_SURROGATE_LOGON_VERSION_1 = 0x00000001U;

enum : uint
{
    SECBUFFER_UNMAPPED   = 0x40000000U,
    SECBUFFER_KERNEL_MAP = 0x20000000U,
}

enum : uint
{
    PRIMARY_CRED_CLEAR_PASSWORD              = 0x00000001U,
    PRIMARY_CRED_OWF_PASSWORD                = 0x00000002U,
    PRIMARY_CRED_UPDATE                      = 0x00000004U,
    PRIMARY_CRED_CACHED_LOGON                = 0x00000008U,
    PRIMARY_CRED_LOGON_NO_TCB                = 0x00000010U,
    PRIMARY_CRED_LOGON_LUA                   = 0x00000020U,
    PRIMARY_CRED_INTERACTIVE_SMARTCARD_LOGON = 0x00000040U,
}

enum : uint
{
    PRIMARY_CRED_REFRESH_NEEDED               = 0x00000080U,
    PRIMARY_CRED_INTERNET_USER                = 0x00000100U,
    PRIMARY_CRED_AUTH_ID                      = 0x00000200U,
    PRIMARY_CRED_DO_NOT_SPLIT                 = 0x00000400U,
    PRIMARY_CRED_PROTECTED_USER               = 0x00000800U,
    PRIMARY_CRED_EX                           = 0x00001000U,
    PRIMARY_CRED_TRANSFER                     = 0x00002000U,
    PRIMARY_CRED_RESTRICTED_TS                = 0x00004000U,
    PRIMARY_CRED_PACKED_CREDS                 = 0x00008000U,
    PRIMARY_CRED_ENTERPRISE_INTERNET_USER     = 0x00010000U,
    PRIMARY_CRED_ENCRYPTED_CREDGUARD_PASSWORD = 0x00020000U,
}

enum uint PRIMARY_CRED_CACHED_INTERACTIVE_LOGON = 0x00040000U;

enum : uint
{
    PRIMARY_CRED_INTERACTIVE_NGC_LOGON  = 0x00080000U,
    PRIMARY_CRED_INTERACTIVE_FIDO_LOGON = 0x00100000U,
}

enum : uint
{
    PRIMARY_CRED_ARSO_LOGON          = 0x00200000U,
    PRIMARY_CRED_SUPPLEMENTAL        = 0x00400000U,
    PRIMARY_CRED_FOR_PASSWORD_CHANGE = 0x00800000U,
    PRIMARY_CRED_LOCAL_USER          = 0x01000000U,
    PRIMARY_CRED_LOGON_PACKAGE_SHIFT = 0x00000018U,
    PRIMARY_CRED_PACKAGE_MASK        = 0xff000000U,
}

enum uint SECPKG_PRIMARY_CRED_EX_FLAGS_EX_DELEGATION_TOKEN = 0x00000001U;
enum uint MAX_CRED_SIZE = 0x00000400U;
enum uint SECPKG_STATE_ENCRYPTION_PERMITTED = 0x00000001U;
enum uint SECPKG_STATE_STRONG_ENCRYPTION_PERMITTED = 0x00000002U;

enum : uint
{
    SECPKG_STATE_DOMAIN_CONTROLLER      = 0x00000004U,
    SECPKG_STATE_WORKSTATION            = 0x00000008U,
    SECPKG_STATE_STANDALONE             = 0x00000010U,
    SECPKG_STATE_CRED_ISOLATION_ENABLED = 0x00000020U,
}

enum uint SECPKG_STATE_RESERVED_1 = 0x80000000U;
enum uint SECPKG_MAX_OID_LENGTH = 0x00000020U;

enum : uint
{
    SECPKG_MSVAV_FLAGS_VALID     = 0x00000001U,
    SECPKG_MSVAV_TIMESTAMP_VALID = 0x00000002U,
}

enum : uint
{
    SECPKG_ATTR_SASL_CONTEXT = 0x00010000U,
    SECPKG_ATTR_THUNK_ALL    = 0x00010000U,
}

enum uint UNDERSTANDS_LONG_NAMES = 0x00000001U;
enum uint NO_LONG_NAMES = 0x00000002U;

enum : uint
{
    SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST_FLAG_OPTIMISTIC_LOGON    = 0x00000001U,
    SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST_FLAG_CLEANUP_CREDENTIALS = 0x00000002U,
    SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST_FLAG_TO_SSO_SESSION      = 0x00000004U,
}

enum GUID SECPKG_REDIRECTED_LOGON_GUID_INITIALIZER = GUID("c2be5457-82eb-483e-ae4e-7468ef14d509");

enum : uint
{
    NOTIFIER_FLAG_NEW_THREAD   = 0x00000001U,
    NOTIFIER_FLAG_ONE_SHOT     = 0x00000002U,
    NOTIFIER_FLAG_SECONDS      = 0x80000000U,
    NOTIFIER_TYPE_INTERVAL     = 0x00000001U,
    NOTIFIER_TYPE_HANDLE_WAIT  = 0x00000002U,
    NOTIFIER_TYPE_STATE_CHANGE = 0x00000003U,
    NOTIFIER_TYPE_NOTIFY_EVENT = 0x00000004U,
    NOTIFIER_TYPE_IMMEDIATE    = 0x00000010U,
}

enum : uint
{
    NOTIFY_CLASS_PACKAGE_CHANGE  = 0x00000001U,
    NOTIFY_CLASS_ROLE_CHANGE     = 0x00000002U,
    NOTIFY_CLASS_DOMAIN_CHANGE   = 0x00000003U,
    NOTIFY_CLASS_REGISTRY_CHANGE = 0x00000004U,
}

enum uint LSA_QUERY_CLIENT_PRELOGON_SESSION_ID = 0x00000001U;

enum : uint
{
    CREDP_FLAGS_IN_PROCESS              = 0x00000001U,
    CREDP_FLAGS_USE_MIDL_HEAP           = 0x00000002U,
    CREDP_FLAGS_DONT_CACHE_TI           = 0x00000004U,
    CREDP_FLAGS_CLEAR_PASSWORD          = 0x00000008U,
    CREDP_FLAGS_USER_ENCRYPTED_PASSWORD = 0x00000010U,
}

enum : uint
{
    CREDP_FLAGS_TRUSTED_CALLER        = 0x00000020U,
    CREDP_FLAGS_VALIDATE_PROXY_TARGET = 0x00000040U,
}

enum uint CRED_MARSHALED_TI_SIZE_SIZE = 0x0000000cU;
// Native encoding: ansi
enum const(wchar)* LSA_AP_NAME_LOGON_USER_EX2 = "LsaApLogonUserEx2\0";
// Native encoding: ansi
enum const(wchar)* SP_ACCEPT_CREDENTIALS_NAME = "SpAcceptCredentials\0";
enum uint SECPKG_UNICODE_ATTRIBUTE = 0x80000000U;
enum uint SECPKG_ANSI_ATTRIBUTE = 0x00000000U;
enum uint SECPKG_CREDENTIAL_ATTRIBUTE = 0x00000000U;
// Native encoding: ansi
enum const(wchar)* SECPKG_LSAMODEINIT_NAME = "SpLsaModeInitialize";
// Native encoding: ansi
enum const(wchar)* SECPKG_USERMODEINIT_NAME = "SpUserModeInitialize";

enum : uint
{
    SECPKG_INTERFACE_VERSION    = 0x00010000U,
    SECPKG_INTERFACE_VERSION_2  = 0x00020000U,
    SECPKG_INTERFACE_VERSION_3  = 0x00040000U,
    SECPKG_INTERFACE_VERSION_4  = 0x00080000U,
    SECPKG_INTERFACE_VERSION_5  = 0x00100000U,
    SECPKG_INTERFACE_VERSION_6  = 0x00200000U,
    SECPKG_INTERFACE_VERSION_7  = 0x00400000U,
    SECPKG_INTERFACE_VERSION_8  = 0x00800000U,
    SECPKG_INTERFACE_VERSION_9  = 0x01000000U,
    SECPKG_INTERFACE_VERSION_10 = 0x02000000U,
    SECPKG_INTERFACE_VERSION_11 = 0x04000000U,
}

enum : const(wchar)*
{
    // Native encoding: ansi
    UNISP_NAME_A = "Microsoft Unified Security Protocol Provider",
    UNISP_NAME_W = "Microsoft Unified Security Protocol Provider",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SSL2SP_NAME_A = "Microsoft SSL 2.0",
    SSL2SP_NAME_W = "Microsoft SSL 2.0",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SSL3SP_NAME_A = "Microsoft SSL 3.0",
    SSL3SP_NAME_W = "Microsoft SSL 3.0",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    TLS1SP_NAME_A = "Microsoft TLS 1.0",
    TLS1SP_NAME_W = "Microsoft TLS 1.0",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    PCT1SP_NAME_A = "Microsoft PCT 1.0",
    PCT1SP_NAME_W = "Microsoft PCT 1.0",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    SCHANNEL_NAME_A = "Schannel",
    SCHANNEL_NAME_W = "Schannel",
}

enum : const(wchar)*
{
    // Native encoding: ansi
    DEFAULT_TLS_SSP_NAME_A = "Default TLS SSP",
    DEFAULT_TLS_SSP_NAME_W = "Default TLS SSP",
}

enum const(wchar)* UNISP_NAME = "Microsoft Unified Security Protocol Provider";
enum const(wchar)* PCT1SP_NAME = "Microsoft PCT 1.0";
enum const(wchar)* SSL2SP_NAME = "Microsoft SSL 2.0";
enum const(wchar)* SSL3SP_NAME = "Microsoft SSL 3.0";
enum const(wchar)* TLS1SP_NAME = "Microsoft TLS 1.0";
enum const(wchar)* SCHANNEL_NAME = "Schannel";
enum const(wchar)* DEFAULT_TLS_SSP_NAME = "Default TLS SSP";
enum uint UNISP_RPC_ID = 0x0000000eU;
enum uint RCRED_STATUS_NOCRED = 0x00000000U;
enum uint RCRED_CRED_EXISTS = 0x00000001U;
enum uint RCRED_STATUS_UNKNOWN_ISSUER = 0x00000002U;
enum uint LCRED_STATUS_NOCRED = 0x00000000U;
enum uint LCRED_CRED_EXISTS = 0x00000001U;
enum uint LCRED_STATUS_UNKNOWN_ISSUER = 0x00000002U;

enum : uint
{
    SECPKGCONTEXT_CONNECTION_INFO_EX_V1 = 0x00000001U,
    SECPKGCONTEXT_CIPHERINFO_V1         = 0x00000001U,
}

enum uint SSL_SESSION_RECONNECT = 0x00000001U;
enum uint KERN_CONTEXT_CERT_INFO_V1 = 0x00000000U;
enum uint ENABLE_TLS_CLIENT_EARLY_START = 0x00000001U;

enum : uint
{
    SCH_CRED_V1      = 0x00000001U,
    SCH_CRED_V2      = 0x00000002U,
    SCH_CRED_VERSION = 0x00000002U,
    SCH_CRED_V3      = 0x00000003U,
}

enum uint SCHANNEL_CRED_VERSION = 0x00000004U;
enum uint SCH_CREDENTIALS_VERSION = 0x00000005U;

enum : const(wchar)*
{
    SCHANNEL_RSA_PSS_PADDING_ALGORITHM  = "SCH_RSA_PSS_PAD",
    SCHANNEL_RSA_PKCS_PADDING_ALGORITHM = "SCH_RSA_PKCS_PAD",
}

enum uint TLS_PARAMS_OPTIONAL = 0x00000001U;

enum : uint
{
    SCH_CRED_MAX_SUPPORTED_PARAMETERS      = 0x00000010U,
    SCH_CRED_MAX_SUPPORTED_ALPN_IDS        = 0x00000010U,
    SCH_CRED_MAX_SUPPORTED_CRYPTO_SETTINGS = 0x00000010U,
    SCH_CRED_MAX_SUPPORTED_CHAINING_MODES  = 0x00000010U,
}

enum uint SCH_MAX_EXT_SUBSCRIPTIONS = 0x00000002U;

enum : uint
{
    SCH_CRED_FORMAT_CERT_CONTEXT    = 0x00000000U,
    SCH_CRED_FORMAT_CERT_HASH       = 0x00000001U,
    SCH_CRED_FORMAT_CERT_HASH_STORE = 0x00000002U,
}

enum : uint
{
    SCH_CRED_MAX_STORE_NAME_SIZE = 0x00000080U,
    SCH_CRED_MAX_SUPPORTED_ALGS  = 0x00000100U,
    SCH_CRED_MAX_SUPPORTED_CERTS = 0x00000064U,
}

enum uint SCH_MACHINE_CERT_HASH = 0x00000001U;
enum uint SCH_CRED_DISABLE_RECONNECTS = 0x00000080U;

enum : uint
{
    SCH_CRED_RESTRICTED_ROOTS            = 0x00002000U,
    SCH_CRED_REVOCATION_CHECK_CACHE_ONLY = 0x00004000U,
}

enum uint SCH_CRED_CACHE_ONLY_URL_RETRIEVAL = 0x00008000U;
enum uint SCH_CRED_MEMORY_STORE_CERT = 0x00010000U;

enum : uint
{
    SCH_CRED_SNI_CREDENTIAL  = 0x00080000U,
    SCH_CRED_SNI_ENABLE_OCSP = 0x00100000U,
}

enum uint SCH_USE_DTLS_ONLY = 0x01000000U;
enum uint SCH_ALLOW_NULL_ENCRYPTION = 0x02000000U;
enum uint SCH_CRED_DEFERRED_CRED_VALIDATION = 0x04000000U;

enum : uint
{
    SCHANNEL_RENEGOTIATE = 0x00000000U,
    SCHANNEL_SHUTDOWN    = 0x00000001U,
    SCHANNEL_ALERT       = 0x00000002U,
    SCHANNEL_SESSION     = 0x00000003U,
}

enum : uint
{
    TLS1_ALERT_CLOSE_NOTIFY       = 0x00000000U,
    TLS1_ALERT_UNEXPECTED_MESSAGE = 0x0000000aU,
}

enum : uint
{
    TLS1_ALERT_BAD_RECORD_MAC    = 0x00000014U,
    TLS1_ALERT_DECRYPTION_FAILED = 0x00000015U,
}

enum : uint
{
    TLS1_ALERT_RECORD_OVERFLOW    = 0x00000016U,
    TLS1_ALERT_DECOMPRESSION_FAIL = 0x0000001eU,
}

enum uint TLS1_ALERT_HANDSHAKE_FAILURE = 0x00000028U;

enum : uint
{
    TLS1_ALERT_BAD_CERTIFICATE     = 0x0000002aU,
    TLS1_ALERT_UNSUPPORTED_CERT    = 0x0000002bU,
    TLS1_ALERT_CERTIFICATE_REVOKED = 0x0000002cU,
    TLS1_ALERT_CERTIFICATE_EXPIRED = 0x0000002dU,
    TLS1_ALERT_CERTIFICATE_UNKNOWN = 0x0000002eU,
}

enum uint TLS1_ALERT_ILLEGAL_PARAMETER = 0x0000002fU;

enum : uint
{
    TLS1_ALERT_UNKNOWN_CA         = 0x00000030U,
    TLS1_ALERT_ACCESS_DENIED      = 0x00000031U,
    TLS1_ALERT_DECODE_ERROR       = 0x00000032U,
    TLS1_ALERT_DECRYPT_ERROR      = 0x00000033U,
    TLS1_ALERT_EXPORT_RESTRICTION = 0x0000003cU,
}

enum : uint
{
    TLS1_ALERT_PROTOCOL_VERSION     = 0x00000046U,
    TLS1_ALERT_INSUFFIENT_SECURITY  = 0x00000047U,
    TLS1_ALERT_INTERNAL_ERROR       = 0x00000050U,
    TLS1_ALERT_USER_CANCELED        = 0x0000005aU,
    TLS1_ALERT_NO_RENEGOTIATION     = 0x00000064U,
    TLS1_ALERT_UNSUPPORTED_EXT      = 0x0000006eU,
    TLS1_ALERT_UNKNOWN_PSK_IDENTITY = 0x00000073U,
}

enum uint TLS1_ALERT_NO_APP_PROTOCOL = 0x00000078U;

enum : uint
{
    SP_PROT_PCT1_SERVER   = 0x00000001U,
    SP_PROT_PCT1_CLIENT   = 0x00000002U,
    SP_PROT_SSL2_SERVER   = 0x00000004U,
    SP_PROT_SSL2_CLIENT   = 0x00000008U,
    SP_PROT_SSL3_SERVER   = 0x00000010U,
    SP_PROT_SSL3_CLIENT   = 0x00000020U,
    SP_PROT_TLS1_SERVER   = 0x00000040U,
    SP_PROT_TLS1_CLIENT   = 0x00000080U,
    SP_PROT_UNI_SERVER    = 0x40000000U,
    SP_PROT_UNI_CLIENT    = 0x80000000U,
    SP_PROT_ALL           = 0xffffffffU,
    SP_PROT_NONE          = 0x00000000U,
    SP_PROT_TLS1_0_SERVER = 0x00000040U,
    SP_PROT_TLS1_0_CLIENT = 0x00000080U,
    SP_PROT_TLS1_1_SERVER = 0x00000100U,
    SP_PROT_TLS1_1_CLIENT = 0x00000200U,
    SP_PROT_TLS1_2_SERVER = 0x00000400U,
    SP_PROT_TLS1_2_CLIENT = 0x00000800U,
    SP_PROT_TLS1_3_SERVER = 0x00001000U,
    SP_PROT_TLS1_3_CLIENT = 0x00002000U,
}

enum : uint
{
    SP_PROT_DTLS_SERVER    = 0x00010000U,
    SP_PROT_DTLS_CLIENT    = 0x00020000U,
    SP_PROT_DTLS1_0_SERVER = 0x00010000U,
    SP_PROT_DTLS1_0_CLIENT = 0x00020000U,
    SP_PROT_DTLS1_2_SERVER = 0x00040000U,
    SP_PROT_DTLS1_2_CLIENT = 0x00080000U,
}

enum : uint
{
    SP_PROT_TLS1_3PLUS_SERVER = 0x00001000U,
    SP_PROT_TLS1_3PLUS_CLIENT = 0x00002000U,
}

enum : uint
{
    SCHANNEL_SECRET_TYPE_CAPI = 0x00000001U,
    SCHANNEL_SECRET_PRIVKEY   = 0x00000002U,
}

enum : uint
{
    SCH_CRED_X509_CERTCHAIN = 0x00000001U,
    SCH_CRED_X509_CAPI      = 0x00000002U,
    SCH_CRED_CERT_CONTEXT   = 0x00000003U,
}

enum const(wchar)* SSL_CRACK_CERTIFICATE_NAME = "SslCrackCertificate";
enum const(wchar)* SSL_FREE_CERTIFICATE_NAME = "SslFreeCertificate";

enum : const(wchar)*
{
    SL_INFO_KEY_CHANNEL                         = "Channel",
    SL_INFO_KEY_NAME                            = "Name",
    SL_INFO_KEY_AUTHOR                          = "Author",
    SL_INFO_KEY_DESCRIPTION                     = "Description",
    SL_INFO_KEY_LICENSOR_URL                    = "LicensorUrl",
    SL_INFO_KEY_DIGITAL_PID                     = "DigitalPID",
    SL_INFO_KEY_DIGITAL_PID2                    = "DigitalPID2",
    SL_INFO_KEY_PARTIAL_PRODUCT_KEY             = "PartialProductKey",
    SL_INFO_KEY_PRODUCT_SKU_ID                  = "ProductSkuId",
    SL_INFO_KEY_LICENSE_TYPE                    = "LicenseType",
    SL_INFO_KEY_VERSION                         = "Version",
    SL_INFO_KEY_SYSTEM_STATE                    = "SystemState",
    SL_INFO_KEY_ACTIVE_PLUGINS                  = "ActivePlugins",
    SL_INFO_KEY_SECURE_STORE_ID                 = "SecureStoreId",
    SL_INFO_KEY_BIOS_PKEY                       = "BiosProductKey",
    SL_INFO_KEY_BIOS_SLIC_STATE                 = "BiosSlicState",
    SL_INFO_KEY_BIOS_OA2_MINOR_VERSION          = "BiosOA2MinorVersion",
    SL_INFO_KEY_BIOS_PKEY_DESCRIPTION           = "BiosProductKeyDescription",
    SL_INFO_KEY_BIOS_PKEY_PKPN                  = "BiosProductKeyPkPn",
    SL_INFO_KEY_SECURE_PROCESSOR_ACTIVATION_URL = "SPCURL",
}

enum const(wchar)* SL_INFO_KEY_RIGHT_ACCOUNT_ACTIVATION_URL = "RACURL";
enum const(wchar)* SL_INFO_KEY_PRODUCT_KEY_ACTIVATION_URL = "PKCURL";
enum const(wchar)* SL_INFO_KEY_USE_LICENSE_ACTIVATION_URL = "EULURL";

enum : const(wchar)*
{
    SL_INFO_KEY_IS_KMS                         = "IsKeyManagementService",
    SL_INFO_KEY_KMS_CURRENT_COUNT              = "KeyManagementServiceCurrentCount",
    SL_INFO_KEY_KMS_REQUIRED_CLIENT_COUNT      = "KeyManagementServiceRequiredClientCount",
    SL_INFO_KEY_KMS_UNLICENSED_REQUESTS        = "KeyManagementServiceUnlicensedRequests",
    SL_INFO_KEY_KMS_LICENSED_REQUESTS          = "KeyManagementServiceLicensedRequests",
    SL_INFO_KEY_KMS_OOB_GRACE_REQUESTS         = "KeyManagementServiceOOBGraceRequests",
    SL_INFO_KEY_KMS_OOT_GRACE_REQUESTS         = "KeyManagementServiceOOTGraceRequests",
    SL_INFO_KEY_KMS_NON_GENUINE_GRACE_REQUESTS = "KeyManagementServiceNonGenuineGraceRequests",
    SL_INFO_KEY_KMS_NOTIFICATION_REQUESTS      = "KeyManagementServiceNotificationRequests",
    SL_INFO_KEY_KMS_TOTAL_REQUESTS             = "KeyManagementServiceTotalRequests",
    SL_INFO_KEY_KMS_FAILED_REQUESTS            = "KeyManagementServiceFailedRequests",
}

enum const(wchar)* SL_INFO_KEY_IS_PRS = "IsPRS";

enum : const(wchar)*
{
    SL_PKEY_MS2005 = "msft:rm/algorithm/pkey/2005",
    SL_PKEY_MS2009 = "msft:rm/algorithm/pkey/2009",
    SL_PKEY_DETECT = "msft:rm/algorithm/pkey/detect",
}

enum const(wchar)* SL_EVENT_LICENSING_STATE_CHANGED = "msft:rm/event/licensingstatechanged";
enum const(wchar)* SL_EVENT_POLICY_CHANGED = "msft:rm/event/policychanged";
enum const(wchar)* SL_EVENT_USER_NOTIFICATION = "msft:rm/event/usernotification";

enum : uint
{
    SL_SYSTEM_STATE_REBOOT_POLICY_FOUND = 0x00000001U,
    SL_SYSTEM_STATE_TAMPERED            = 0x00000002U,
}

enum uint SL_REARM_REBOOT_REQUIRED = 0x00000001U;

enum : uint
{
    SPP_MIGRATION_GATHER_MIGRATABLE_APPS         = 0x00000001U,
    SPP_MIGRATION_GATHER_ACTIVATED_WINDOWS_STATE = 0x00000002U,
    SPP_MIGRATION_GATHER_ALL                     = 0xffffffffU,
}

enum : const(wchar)*
{
    SL_PROP_BRT_DATA       = "SL_BRT_DATA",
    SL_PROP_BRT_COMMIT     = "SL_BRT_COMMIT",
    SL_PROP_GENUINE_RESULT = "SL_GENUINE_RESULT",
}

enum const(wchar)* SL_PROP_NONGENUINE_GRACE_FLAG = "SL_NONGENUINE_GRACE_FLAG";

enum : const(wchar)*
{
    SL_PROP_GET_GENUINE_AUTHZ        = "SL_GET_GENUINE_AUTHZ",
    SL_PROP_GET_GENUINE_SERVER_AUTHZ = "SL_GET_GENUINE_SERVER_AUTHZ",
}

enum : const(wchar)*
{
    SL_PROP_LAST_ACT_ATTEMPT_HRESULT      = "SL_LAST_ACT_ATTEMPT_HRESULT",
    SL_PROP_LAST_ACT_ATTEMPT_TIME         = "SL_LAST_ACT_ATTEMPT_TIME",
    SL_PROP_LAST_ACT_ATTEMPT_SERVER_FLAGS = "SL_LAST_ACT_ATTEMPT_SERVER_FLAGS",
}

enum const(wchar)* SL_PROP_ACTIVATION_VALIDATION_IN_PROGRESS = "SL_ACTIVATION_VALIDATION_IN_PROGRESS";
enum const(wchar)* SL_POLICY_EVALUATION_MODE_ENABLED = "Security-SPP-EvaluationModeEnabled";
enum const(wchar)* SL_DEFAULT_MIGRATION_ENCRYPTOR_URI = "msft:spp/migrationencryptor/tokenact/1.0";
enum const(wchar)* ID_CAP_SLAPI = "slapiQueryLicenseValue";
enum uint USER_ACCOUNT_DISABLED = 0x00000001U;
enum uint USER_HOME_DIRECTORY_REQUIRED = 0x00000002U;
enum uint USER_PASSWORD_NOT_REQUIRED = 0x00000004U;
enum uint USER_TEMP_DUPLICATE_ACCOUNT = 0x00000008U;
enum uint USER_NORMAL_ACCOUNT = 0x00000010U;
enum uint USER_MNS_LOGON_ACCOUNT = 0x00000020U;
enum uint USER_INTERDOMAIN_TRUST_ACCOUNT = 0x00000040U;
enum uint USER_WORKSTATION_TRUST_ACCOUNT = 0x00000080U;
enum uint USER_SERVER_TRUST_ACCOUNT = 0x00000100U;
enum uint USER_DONT_EXPIRE_PASSWORD = 0x00000200U;
enum uint USER_ACCOUNT_AUTO_LOCKED = 0x00000400U;
enum uint USER_ENCRYPTED_TEXT_PASSWORD_ALLOWED = 0x00000800U;
enum uint USER_SMARTCARD_REQUIRED = 0x00001000U;
enum uint USER_TRUSTED_FOR_DELEGATION = 0x00002000U;
enum uint USER_NOT_DELEGATED = 0x00004000U;
enum uint USER_USE_DES_KEY_ONLY = 0x00008000U;
enum uint USER_DONT_REQUIRE_PREAUTH = 0x00010000U;
enum uint USER_PASSWORD_EXPIRED = 0x00020000U;
enum uint USER_TRUSTED_TO_AUTHENTICATE_FOR_DELEGATION = 0x00040000U;
enum uint USER_NO_AUTH_DATA_REQUIRED = 0x00080000U;
enum uint USER_PARTIAL_SECRETS_ACCOUNT = 0x00100000U;
enum uint USER_USE_AES_KEYS = 0x00200000U;
enum uint USER_SHADOW_ACCOUNT = 0x00400000U;
enum uint SAM_DAYS_PER_WEEK = 0x00000007U;
enum uint USER_ALL_PARAMETERS = 0x00200000U;
enum uint CLEAR_BLOCK_LENGTH = 0x00000008U;
enum uint CYPHER_BLOCK_LENGTH = 0x00000008U;

enum : uint
{
    NETLOGON_TARGET_INFO_TYPE_NTLM     = 0x00000001U,
    NETLOGON_TARGET_INFO_TYPE_KERBEROS = 0x00000002U,
}

enum uint MSV1_0_KERBEROS_LOGON = 0x00000004U;

enum : uint
{
    MSV1_0_VALIDATION_LOGOFF_TIME  = 0x00000001U,
    MSV1_0_VALIDATION_KICKOFF_TIME = 0x00000002U,
    MSV1_0_VALIDATION_LOGON_SERVER = 0x00000004U,
    MSV1_0_VALIDATION_LOGON_DOMAIN = 0x00000008U,
    MSV1_0_VALIDATION_SESSION_KEY  = 0x00000010U,
    MSV1_0_VALIDATION_USER_FLAGS   = 0x00000020U,
    MSV1_0_VALIDATION_USER_ID      = 0x00000040U,
}

enum : uint
{
    MSV1_0_SUBAUTH_ACCOUNT_DISABLED = 0x00000001U,
    MSV1_0_SUBAUTH_PASSWORD         = 0x00000002U,
    MSV1_0_SUBAUTH_WORKSTATIONS     = 0x00000004U,
    MSV1_0_SUBAUTH_LOGON_HOURS      = 0x00000008U,
    MSV1_0_SUBAUTH_ACCOUNT_EXPIRY   = 0x00000010U,
    MSV1_0_SUBAUTH_PASSWORD_EXPIRY  = 0x00000020U,
    MSV1_0_SUBAUTH_ACCOUNT_TYPE     = 0x00000040U,
    MSV1_0_SUBAUTH_LOCKOUT          = 0x00000080U,
}

enum uint SL_MDOLLAR_ZONE = 0x0000a000U;
enum uint SL_SERVER_ZONE = 0x0000b000U;
enum uint SL_MSCH_ZONE = 0x0000c000U;
enum uint SL_INTERNAL_ZONE = 0x0000e000U;
enum uint SL_CLIENTAPI_ZONE = 0x0000f000U;
enum uint FACILITY_SL_ITF = 0x00000004U;
enum uint _FACILITY_WINDOWS_STORE = 0x0000003fU;

enum : HRESULT
{
    SL_E_SRV_INVALID_PUBLISH_LICENSE        = HRESULT(0xc004b001),
    SL_E_SRV_INVALID_PRODUCT_KEY_LICENSE    = HRESULT(0xc004b002),
    SL_E_SRV_INVALID_RIGHTS_ACCOUNT_LICENSE = HRESULT(0xc004b003),
    SL_E_SRV_INVALID_LICENSE_STRUCTURE      = HRESULT(0xc004b004),
}

enum HRESULT SL_E_SRV_AUTHORIZATION_FAILED = HRESULT(0xc004b005);
enum HRESULT SL_E_SRV_INVALID_BINDING = HRESULT(0xc004b006);

enum : HRESULT
{
    SL_E_SRV_SERVER_PONG                        = HRESULT(0xc004b007),
    SL_E_SRV_INVALID_PAYLOAD                    = HRESULT(0xc004b008),
    SL_E_SRV_INVALID_SECURITY_PROCESSOR_LICENSE = HRESULT(0xc004b009),
}

enum HRESULT SL_E_SRV_BUSINESS_TOKEN_ENTRY_NOT_FOUND = HRESULT(0xc004b010);
enum HRESULT SL_E_SRV_CLIENT_CLOCK_OUT_OF_SYNC = HRESULT(0xc004b011);
enum HRESULT SL_E_SRV_GENERAL_ERROR = HRESULT(0xc004b100);
enum HRESULT SL_E_CHPA_PRODUCT_KEY_OUT_OF_RANGE = HRESULT(0xc004c001);
enum HRESULT SL_E_CHPA_INVALID_BINDING = HRESULT(0xc004c002);
enum HRESULT SL_E_CHPA_PRODUCT_KEY_BLOCKED = HRESULT(0xc004c003);
enum HRESULT SL_E_CHPA_INVALID_PRODUCT_KEY = HRESULT(0xc004c004);

enum : HRESULT
{
    SL_E_CHPA_BINDING_NOT_FOUND         = HRESULT(0xc004c005),
    SL_E_CHPA_BINDING_MAPPING_NOT_FOUND = HRESULT(0xc004c006),
}

enum HRESULT SL_E_CHPA_UNSUPPORTED_PRODUCT_KEY = HRESULT(0xc004c007);
enum HRESULT SL_E_CHPA_MAXIMUM_UNLOCK_EXCEEDED = HRESULT(0xc004c008);
enum HRESULT SL_E_CHPA_ACTCONFIG_ID_NOT_FOUND = HRESULT(0xc004c009);

enum : HRESULT
{
    SL_E_CHPA_INVALID_PRODUCT_DATA_ID = HRESULT(0xc004c00a),
    SL_E_CHPA_INVALID_PRODUCT_DATA    = HRESULT(0xc004c00b),
}

enum : HRESULT
{
    SL_E_CHPA_SYSTEM_ERROR               = HRESULT(0xc004c00c),
    SL_E_CHPA_INVALID_ACTCONFIG_ID       = HRESULT(0xc004c00d),
    SL_E_CHPA_INVALID_PRODUCT_KEY_LENGTH = HRESULT(0xc004c00e),
    SL_E_CHPA_INVALID_PRODUCT_KEY_FORMAT = HRESULT(0xc004c00f),
    SL_E_CHPA_INVALID_PRODUCT_KEY_CHAR   = HRESULT(0xc004c010),
    SL_E_CHPA_INVALID_BINDING_URI        = HRESULT(0xc004c011),
}

enum : HRESULT
{
    SL_E_CHPA_NETWORK_ERROR    = HRESULT(0xc004c012),
    SL_E_CHPA_DATABASE_ERROR   = HRESULT(0xc004c013),
    SL_E_CHPA_INVALID_ARGUMENT = HRESULT(0xc004c014),
}

enum : HRESULT
{
    SL_E_CHPA_DMAK_LIMIT_EXCEEDED           = HRESULT(0xc004c020),
    SL_E_CHPA_DMAK_EXTENSION_LIMIT_EXCEEDED = HRESULT(0xc004c021),
}

enum HRESULT SL_E_CHPA_REISSUANCE_LIMIT_NOT_FOUND = HRESULT(0xc004c022);
enum HRESULT SL_E_CHPA_OVERRIDE_REQUEST_NOT_FOUND = HRESULT(0xc004c023);

enum : HRESULT
{
    SL_E_CHPA_OEM_SLP_COA0                   = HRESULT(0xc004c016),
    SL_E_CHPA_PRODUCT_KEY_BLOCKED_IPLOCATION = HRESULT(0xc004c017),
}

enum HRESULT SL_E_CHPA_RESPONSE_NOT_AVAILABLE = HRESULT(0xc004c015);

enum : HRESULT
{
    SL_E_CHPA_GENERAL_ERROR                          = HRESULT(0xc004c050),
    SL_E_CHPA_TIMEBASED_ACTIVATION_BEFORE_START_DATE = HRESULT(0xc004c030),
    SL_E_CHPA_TIMEBASED_ACTIVATION_AFTER_END_DATE    = HRESULT(0xc004c031),
    SL_E_CHPA_TIMEBASED_ACTIVATION_NOT_AVAILABLE     = HRESULT(0xc004c032),
    SL_E_CHPA_TIMEBASED_PRODUCT_KEY_NOT_CONFIGURED   = HRESULT(0xc004c033),
}

enum HRESULT SL_E_CHPA_NO_RULES_TO_ACTIVATE = HRESULT(0xc004c04f);

enum : HRESULT
{
    SL_E_CHPA_DIGITALMARKER_INVALID_BINDING        = HRESULT(0xc004c051),
    SL_E_CHPA_DIGITALMARKER_BINDING_NOT_CONFIGURED = HRESULT(0xc004c052),
}

enum HRESULT SL_E_CHPA_DYNAMICALLY_BLOCKED_PRODUCT_KEY = HRESULT(0xc004c060);
enum HRESULT SL_E_CHPA_MSCH_RESPONSE_NOT_AVAILABLE_VGA = HRESULT(0xc004c3ff);
enum HRESULT SL_E_CHPA_BUSINESS_RULE_INPUT_NOT_FOUND = HRESULT(0xc004c700);
enum HRESULT SL_E_CHPA_NULL_VALUE_FOR_PROPERTY_NAME_OR_ID = HRESULT(0xc004c750);

enum : HRESULT
{
    SL_E_CHPA_UNKNOWN_PROPERTY_NAME = HRESULT(0xc004c751),
    SL_E_CHPA_UNKNOWN_PROPERTY_ID   = HRESULT(0xc004c752),
}

enum : HRESULT
{
    SL_E_CHPA_FAILED_TO_UPDATE_PRODUCTKEY_BINDING        = HRESULT(0xc004c755),
    SL_E_CHPA_FAILED_TO_INSERT_PRODUCTKEY_BINDING        = HRESULT(0xc004c756),
    SL_E_CHPA_FAILED_TO_DELETE_PRODUCTKEY_BINDING        = HRESULT(0xc004c757),
    SL_E_CHPA_FAILED_TO_PROCESS_PRODUCT_KEY_BINDINGS_XML = HRESULT(0xc004c758),
}

enum : HRESULT
{
    SL_E_CHPA_FAILED_TO_INSERT_PRODUCT_KEY_PROPERTY = HRESULT(0xc004c75a),
    SL_E_CHPA_FAILED_TO_UPDATE_PRODUCT_KEY_PROPERTY = HRESULT(0xc004c75b),
    SL_E_CHPA_FAILED_TO_DELETE_PRODUCT_KEY_PROPERTY = HRESULT(0xc004c75c),
}

enum HRESULT SL_E_CHPA_UNKNOWN_PRODUCT_KEY_TYPE = HRESULT(0xc004c764);
enum HRESULT SL_E_CHPA_PRODUCT_KEY_BEING_USED = HRESULT(0xc004c770);

enum : HRESULT
{
    SL_E_CHPA_FAILED_TO_INSERT_PRODUCT_KEY_RECORD = HRESULT(0xc004c780),
    SL_E_CHPA_FAILED_TO_UPDATE_PRODUCT_KEY_RECORD = HRESULT(0xc004c781),
}

enum : HRESULT
{
    SL_E_INVALID_LICENSE_STATE_BREACH_GRACE         = HRESULT(0xc004c291),
    SL_E_INVALID_LICENSE_STATE_BREACH_GRACE_EXPIRED = HRESULT(0xc004c292),
}

enum : HRESULT
{
    SL_E_INVALID_TEMPLATE_ID = HRESULT(0xc004c2f6),
    SL_E_INVALID_XML_BLOB    = HRESULT(0xc004c2fa),
}

enum HRESULT SL_E_VALIDATION_BLOB_PARAM_NOT_FOUND = HRESULT(0xc004c327);

enum : HRESULT
{
    SL_E_INVALID_CLIENT_TOKEN = HRESULT(0xc004c328),
    SL_E_INVALID_OFFLINE_BLOB = HRESULT(0xc004c329),
}

enum HRESULT SL_E_OFFLINE_VALIDATION_BLOB_PARAM_NOT_FOUND = HRESULT(0xc004c32a);
enum HRESULT SL_E_INVALID_OSVERSION_TEMPLATEID = HRESULT(0xc004c32b);

enum : HRESULT
{
    SL_E_OFFLINE_GENUINE_BLOB_REVOKED   = HRESULT(0xc004c32c),
    SL_E_OFFLINE_GENUINE_BLOB_NOT_FOUND = HRESULT(0xc004c32d),
}

enum : HRESULT
{
    SL_E_INVALID_OS_FOR_PRODUCT_KEY = HRESULT(0xc004c401),
    SL_E_INVALID_FILE_HASH          = HRESULT(0xc004c4a1),
}

enum HRESULT SL_E_VALIDATION_BLOCKED_PRODUCT_KEY = HRESULT(0xc004c4a2);
enum HRESULT SL_E_MISMATCHED_KEY_TYPES = HRESULT(0xc004c4a4);
enum HRESULT SL_E_VALIDATION_INVALID_PRODUCT_KEY = HRESULT(0xc004c4a5);
enum HRESULT SL_E_INVALID_OEM_OR_VOLUME_BINDING_DATA = HRESULT(0xc004c4a7);
enum HRESULT SL_E_INVALID_LICENSE_STATE = HRESULT(0xc004c4a8);
enum HRESULT SL_E_IP_LOCATION_FALIED = HRESULT(0xc004c4a9);
enum HRESULT SL_E_SOFTMOD_EXPLOIT_DETECTED = HRESULT(0xc004c4ab);
enum HRESULT SL_E_INVALID_TOKEN_DATA = HRESULT(0xc004c4ac);

enum : HRESULT
{
    SL_E_HEALTH_CHECK_FAILED_NEUTRAL_FILES = HRESULT(0xc004c4ad),
    SL_E_HEALTH_CHECK_FAILED_MUI_FILES     = HRESULT(0xc004c4ae),
}

enum : HRESULT
{
    SL_E_INVALID_AD_DATA    = HRESULT(0xc004c4af),
    SL_E_INVALID_RSDP_COUNT = HRESULT(0xc004c4b0),
}

enum HRESULT SL_E_ENGINE_DETECTED_EXPLOIT = HRESULT(0xc004c4b1);
enum HRESULT SL_E_NON_GENUINE_STATUS_LAST = HRESULT(0xc004c600);

enum : HRESULT
{
    SL_E_NOTIFICATION_BREACH_DETECTED = HRESULT(0xc004c531),
    SL_E_NOTIFICATION_GRACE_EXPIRED   = HRESULT(0xc004c532),
    SL_E_NOTIFICATION_OTHER_REASONS   = HRESULT(0xc004c533),
}

enum HRESULT SL_E_INVALID_CONTEXT = HRESULT(0xc004e001);
enum HRESULT SL_E_TOKEN_STORE_INVALID_STATE = HRESULT(0xc004e002);
enum HRESULT SL_E_EVALUATION_FAILED = HRESULT(0xc004e003);

enum : HRESULT
{
    SL_E_NOT_EVALUATED = HRESULT(0xc004e004),
    SL_E_NOT_ACTIVATED = HRESULT(0xc004e005),
}

enum HRESULT SL_E_INVALID_GUID = HRESULT(0xc004e006);

enum : HRESULT
{
    SL_E_TOKSTO_TOKEN_NOT_FOUND     = HRESULT(0xc004e007),
    SL_E_TOKSTO_NO_PROPERTIES       = HRESULT(0xc004e008),
    SL_E_TOKSTO_NOT_INITIALIZED     = HRESULT(0xc004e009),
    SL_E_TOKSTO_ALREADY_INITIALIZED = HRESULT(0xc004e00a),
}

enum : HRESULT
{
    SL_E_TOKSTO_NO_ID_SET             = HRESULT(0xc004e00b),
    SL_E_TOKSTO_CANT_CREATE_FILE      = HRESULT(0xc004e00c),
    SL_E_TOKSTO_CANT_WRITE_TO_FILE    = HRESULT(0xc004e00d),
    SL_E_TOKSTO_CANT_READ_FILE        = HRESULT(0xc004e00e),
    SL_E_TOKSTO_CANT_PARSE_PROPERTIES = HRESULT(0xc004e00f),
}

enum HRESULT SL_E_TOKSTO_PROPERTY_NOT_FOUND = HRESULT(0xc004e010);

enum : HRESULT
{
    SL_E_TOKSTO_INVALID_FILE       = HRESULT(0xc004e011),
    SL_E_TOKSTO_CANT_CREATE_MUTEX  = HRESULT(0xc004e012),
    SL_E_TOKSTO_CANT_ACQUIRE_MUTEX = HRESULT(0xc004e013),
}

enum HRESULT SL_E_TOKSTO_NO_TOKEN_DATA = HRESULT(0xc004e014);
enum HRESULT SL_E_EUL_CONSUMPTION_FAILED = HRESULT(0xc004e015);

enum : HRESULT
{
    SL_E_PKEY_INVALID_CONFIG    = HRESULT(0xc004e016),
    SL_E_PKEY_INVALID_UNIQUEID  = HRESULT(0xc004e017),
    SL_E_PKEY_INVALID_ALGORITHM = HRESULT(0xc004e018),
    SL_E_PKEY_INTERNAL_ERROR    = HRESULT(0xc004e019),
}

enum HRESULT SL_E_LICENSE_INVALID_ADDON_INFO = HRESULT(0xc004e01a);
enum HRESULT SL_E_HWID_ERROR = HRESULT(0xc004e01b);

enum : HRESULT
{
    SL_E_PKEY_INVALID_KEYCHANGE1 = HRESULT(0xc004e01c),
    SL_E_PKEY_INVALID_KEYCHANGE2 = HRESULT(0xc004e01d),
    SL_E_PKEY_INVALID_KEYCHANGE3 = HRESULT(0xc004e01e),
}

enum HRESULT SL_E_POLICY_OTHERINFO_MISMATCH = HRESULT(0xc004e020);
enum HRESULT SL_E_PRODUCT_UNIQUENESS_GROUP_ID_INVALID = HRESULT(0xc004e021);
enum HRESULT SL_E_SECURE_STORE_ID_MISMATCH = HRESULT(0xc004e022);

enum : HRESULT
{
    SL_E_INVALID_RULESET_RULE       = HRESULT(0xc004e023),
    SL_E_INVALID_CONTEXT_DATA       = HRESULT(0xc004e024),
    SL_E_INVALID_HASH               = HRESULT(0xc004e025),
    SL_E_INVALID_USE_OF_ADD_ON_PKEY = HRESULT(0x8004e026),
}

enum HRESULT SL_E_WINDOWS_VERSION_MISMATCH = HRESULT(0xc004e027);
enum HRESULT SL_E_ACTIVATION_IN_PROGRESS = HRESULT(0xc004e028);

enum : HRESULT
{
    SL_E_STORE_UPGRADE_TOKEN_REQUIRED       = HRESULT(0xc004e029),
    SL_E_STORE_UPGRADE_TOKEN_WRONG_EDITION  = HRESULT(0xc004e02a),
    SL_E_STORE_UPGRADE_TOKEN_WRONG_PID      = HRESULT(0xc004e02b),
    SL_E_STORE_UPGRADE_TOKEN_NOT_PRS_SIGNED = HRESULT(0xc004e02c),
    SL_E_STORE_UPGRADE_TOKEN_WRONG_VERSION  = HRESULT(0xc004e02d),
    SL_E_STORE_UPGRADE_TOKEN_NOT_AUTHORIZED = HRESULT(0xc004e02e),
}

enum : HRESULT
{
    SL_E_SFS_INVALID_FS_VERSION   = HRESULT(0x8004e101),
    SL_E_SFS_INVALID_FD_TABLE     = HRESULT(0x8004e102),
    SL_E_SFS_INVALID_SYNC         = HRESULT(0x8004e103),
    SL_E_SFS_BAD_TOKEN_NAME       = HRESULT(0x8004e104),
    SL_E_SFS_BAD_TOKEN_EXT        = HRESULT(0x8004e105),
    SL_E_SFS_DUPLICATE_TOKEN_NAME = HRESULT(0x8004e106),
}

enum HRESULT SL_E_SFS_TOKEN_SIZE_MISMATCH = HRESULT(0x8004e107);
enum HRESULT SL_E_SFS_INVALID_TOKEN_DATA_HASH = HRESULT(0x8004e108);

enum : HRESULT
{
    SL_E_SFS_FILE_READ_ERROR  = HRESULT(0x8004e109),
    SL_E_SFS_FILE_WRITE_ERROR = HRESULT(0x8004e10a),
}

enum HRESULT SL_E_SFS_INVALID_FILE_POSITION = HRESULT(0x8004e10b);
enum HRESULT SL_E_SFS_NO_ACTIVE_TRANSACTION = HRESULT(0x8004e10c);

enum : HRESULT
{
    SL_E_SFS_INVALID_FS_HEADER        = HRESULT(0x8004e10d),
    SL_E_SFS_INVALID_TOKEN_DESCRIPTOR = HRESULT(0x8004e10e),
}

enum HRESULT SL_E_INTERNAL_ERROR = HRESULT(0xc004f001);
enum HRESULT SL_E_RIGHT_NOT_CONSUMED = HRESULT(0xc004f002);
enum HRESULT SL_E_USE_LICENSE_NOT_INSTALLED = HRESULT(0xc004f003);

enum : HRESULT
{
    SL_E_MISMATCHED_PKEY_RANGE = HRESULT(0xc004f004),
    SL_E_MISMATCHED_PID        = HRESULT(0xc004f005),
}

enum HRESULT SL_E_EXTERNAL_SIGNATURE_NOT_FOUND = HRESULT(0xc004f006);
enum HRESULT SL_E_RAC_NOT_AVAILABLE = HRESULT(0xc004f007);
enum HRESULT SL_E_SPC_NOT_AVAILABLE = HRESULT(0xc004f008);
enum HRESULT SL_E_GRACE_TIME_EXPIRED = HRESULT(0xc004f009);
enum HRESULT SL_E_MISMATCHED_APPID = HRESULT(0xc004f00a);
enum HRESULT SL_E_NO_PID_CONFIG_DATA = HRESULT(0xc004f00b);
enum HRESULT SL_I_OOB_GRACE_PERIOD = HRESULT(0x4004f00c);
enum HRESULT SL_I_OOT_GRACE_PERIOD = HRESULT(0x4004f00d);
enum HRESULT SL_E_MISMATCHED_SECURITY_PROCESSOR = HRESULT(0xc004f00e);
enum HRESULT SL_E_OUT_OF_TOLERANCE = HRESULT(0xc004f00f);
enum HRESULT SL_E_INVALID_PKEY = HRESULT(0xc004f010);
enum HRESULT SL_E_LICENSE_FILE_NOT_INSTALLED = HRESULT(0xc004f011);
enum HRESULT SL_E_VALUE_NOT_FOUND = HRESULT(0xc004f012);
enum HRESULT SL_E_RIGHT_NOT_GRANTED = HRESULT(0xc004f013);
enum HRESULT SL_E_PKEY_NOT_INSTALLED = HRESULT(0xc004f014);
enum HRESULT SL_E_PRODUCT_SKU_NOT_INSTALLED = HRESULT(0xc004f015);
enum HRESULT SL_E_NOT_SUPPORTED = HRESULT(0xc004f016);
enum HRESULT SL_E_PUBLISHING_LICENSE_NOT_INSTALLED = HRESULT(0xc004f017);
enum HRESULT SL_E_LICENSE_SERVER_URL_NOT_FOUND = HRESULT(0xc004f018);
enum HRESULT SL_E_INVALID_EVENT_ID = HRESULT(0xc004f019);

enum : HRESULT
{
    SL_E_EVENT_NOT_REGISTERED     = HRESULT(0xc004f01a),
    SL_E_EVENT_ALREADY_REGISTERED = HRESULT(0xc004f01b),
}

enum HRESULT SL_E_DECRYPTION_LICENSES_NOT_AVAILABLE = HRESULT(0xc004f01c);
enum HRESULT SL_E_LICENSE_SIGNATURE_VERIFICATION_FAILED = HRESULT(0xc004f01d);
enum HRESULT SL_E_DATATYPE_MISMATCHED = HRESULT(0xc004f01e);

enum : HRESULT
{
    SL_E_INVALID_LICENSE = HRESULT(0xc004f01f),
    SL_E_INVALID_PACKAGE = HRESULT(0xc004f020),
}

enum HRESULT SL_E_VALIDITY_TIME_EXPIRED = HRESULT(0xc004f021);
enum HRESULT SL_E_LICENSE_AUTHORIZATION_FAILED = HRESULT(0xc004f022);
enum HRESULT SL_E_LICENSE_DECRYPTION_FAILED = HRESULT(0xc004f023);
enum HRESULT SL_E_WINDOWS_INVALID_LICENSE_STATE = HRESULT(0xc004f024);
enum HRESULT SL_E_LUA_ACCESSDENIED = HRESULT(0xc004f025);
enum HRESULT SL_E_PROXY_KEY_NOT_FOUND = HRESULT(0xc004f026);
enum HRESULT SL_E_TAMPER_DETECTED = HRESULT(0xc004f027);
enum HRESULT SL_E_POLICY_CACHE_INVALID = HRESULT(0xc004f028);
enum HRESULT SL_E_INVALID_RUNNING_MODE = HRESULT(0xc004f029);
enum HRESULT SL_E_SLP_NOT_SIGNED = HRESULT(0xc004f02a);

enum : HRESULT
{
    SL_E_CIDIID_INVALID_DATA          = HRESULT(0xc004f02c),
    SL_E_CIDIID_INVALID_VERSION       = HRESULT(0xc004f02d),
    SL_E_CIDIID_VERSION_NOT_SUPPORTED = HRESULT(0xc004f02e),
}

enum HRESULT SL_E_CIDIID_INVALID_DATA_LENGTH = HRESULT(0xc004f02f);

enum : HRESULT
{
    SL_E_CIDIID_NOT_DEPOSITED = HRESULT(0xc004f030),
    SL_E_CIDIID_MISMATCHED    = HRESULT(0xc004f031),
}

enum HRESULT SL_E_INVALID_BINDING_BLOB = HRESULT(0xc004f032);
enum HRESULT SL_E_PRODUCT_KEY_INSTALLATION_NOT_ALLOWED = HRESULT(0xc004f033);
enum HRESULT SL_E_EUL_NOT_AVAILABLE = HRESULT(0xc004f034);

enum : HRESULT
{
    SL_E_VL_NOT_WINDOWS_SLP  = HRESULT(0xc004f035),
    SL_E_VL_NOT_ENOUGH_COUNT = HRESULT(0xc004f038),
}

enum HRESULT SL_E_VL_BINDING_SERVICE_NOT_ENABLED = HRESULT(0xc004f039);
enum HRESULT SL_E_VL_INFO_PRODUCT_USER_RIGHT = HRESULT(0x4004f040);

enum : HRESULT
{
    SL_E_VL_KEY_MANAGEMENT_SERVICE_NOT_ACTIVATED = HRESULT(0xc004f041),
    SL_E_VL_KEY_MANAGEMENT_SERVICE_ID_MISMATCH   = HRESULT(0xc004f042),
}

enum HRESULT SL_E_PROXY_POLICY_NOT_UPDATED = HRESULT(0xc004f047);
enum HRESULT SL_E_CIDIID_INVALID_CHECK_DIGITS = HRESULT(0xc004f04d);
enum HRESULT SL_E_LICENSE_MANAGEMENT_DATA_NOT_FOUND = HRESULT(0xc004f04f);
enum HRESULT SL_E_INVALID_PRODUCT_KEY = HRESULT(0xc004f050);
enum HRESULT SL_E_BLOCKED_PRODUCT_KEY = HRESULT(0xc004f051);
enum HRESULT SL_E_DUPLICATE_POLICY = HRESULT(0xc004f052);
enum HRESULT SL_E_MISSING_OVERRIDE_ONLY_ATTRIBUTE = HRESULT(0xc004f053);
enum HRESULT SL_E_LICENSE_MANAGEMENT_DATA_DUPLICATED = HRESULT(0xc004f054);
enum HRESULT SL_E_BASE_SKU_NOT_AVAILABLE = HRESULT(0xc004f055);
enum HRESULT SL_E_VL_MACHINE_NOT_BOUND = HRESULT(0xc004f056);

enum : HRESULT
{
    SL_E_SLP_MISSING_ACPI_SLIC  = HRESULT(0xc004f057),
    SL_E_SLP_MISSING_SLP_MARKER = HRESULT(0xc004f058),
}

enum HRESULT SL_E_SLP_BAD_FORMAT = HRESULT(0xc004f059);
enum HRESULT SL_E_INVALID_PACKAGE_VERSION = HRESULT(0xc004f060);
enum HRESULT SL_E_PKEY_INVALID_UPGRADE = HRESULT(0xc004f061);
enum HRESULT SL_E_ISSUANCE_LICENSE_NOT_INSTALLED = HRESULT(0xc004f062);
enum HRESULT SL_E_SLP_OEM_CERT_MISSING = HRESULT(0xc004f063);
enum HRESULT SL_E_NONGENUINE_GRACE_TIME_EXPIRED = HRESULT(0xc004f064);
enum HRESULT SL_I_NONGENUINE_GRACE_PERIOD = HRESULT(0x4004f065);
enum HRESULT SL_E_DEPENDENT_PROPERTY_NOT_SET = HRESULT(0xc004f066);
enum HRESULT SL_E_NONGENUINE_GRACE_TIME_EXPIRED_2 = HRESULT(0xc004f067);
enum HRESULT SL_I_NONGENUINE_GRACE_PERIOD_2 = HRESULT(0x4004f068);
enum HRESULT SL_E_MISMATCHED_PRODUCT_SKU = HRESULT(0xc004f069);
enum HRESULT SL_E_OPERATION_NOT_ALLOWED = HRESULT(0xc004f06a);
enum HRESULT SL_E_VL_KEY_MANAGEMENT_SERVICE_VM_NOT_SUPPORTED = HRESULT(0xc004f06b);
enum HRESULT SL_E_VL_INVALID_TIMESTAMP = HRESULT(0xc004f06c);
enum HRESULT SL_E_PLUGIN_INVALID_MANIFEST = HRESULT(0xc004f071);

enum : HRESULT
{
    SL_E_APPLICATION_POLICIES_MISSING    = HRESULT(0xc004f072),
    SL_E_APPLICATION_POLICIES_NOT_LOADED = HRESULT(0xc004f073),
}

enum HRESULT SL_E_VL_BINDING_SERVICE_UNAVAILABLE = HRESULT(0xc004f074);
enum HRESULT SL_E_SERVICE_STOPPING = HRESULT(0xc004f075);
enum HRESULT SL_E_PLUGIN_NOT_REGISTERED = HRESULT(0xc004f076);

enum : HRESULT
{
    SL_E_AUTHN_WRONG_VERSION     = HRESULT(0xc004f077),
    SL_E_AUTHN_MISMATCHED_KEY    = HRESULT(0xc004f078),
    SL_E_AUTHN_CHALLENGE_NOT_SET = HRESULT(0xc004f079),
    SL_E_AUTHN_CANT_VERIFY       = HRESULT(0xc004f07a),
}

enum HRESULT SL_E_SERVICE_RUNNING = HRESULT(0xc004f07b);
enum HRESULT SL_E_SLP_INVALID_MARKER_VERSION = HRESULT(0xc004f07c);
enum HRESULT SL_E_INVALID_PRODUCT_KEY_TYPE = HRESULT(0xc004f07d);

enum : HRESULT
{
    SL_E_CIDIID_MISMATCHED_PKEY = HRESULT(0xc004f07e),
    SL_E_CIDIID_NOT_BOUND       = HRESULT(0xc004f07f),
}

enum HRESULT SL_E_LICENSE_NOT_BOUND = HRESULT(0xc004f080);

enum : HRESULT
{
    SL_E_VL_AD_AO_NOT_FOUND                 = HRESULT(0xc004f081),
    SL_E_VL_AD_AO_NAME_TOO_LONG             = HRESULT(0xc004f082),
    SL_E_VL_AD_SCHEMA_VERSION_NOT_SUPPORTED = HRESULT(0xc004f083),
}

enum : HRESULT
{
    SL_E_SLP_MSOA_BAD_FORMAT          = HRESULT(0xc004f090),
    SL_E_SLP_MSOA_BAD_DATA_HEADER     = HRESULT(0xc004f091),
    SL_E_SLP_MSOA_INVALID_DATA_LENGTH = HRESULT(0xc004f092),
    SL_E_SLP_MSOA_INVALID_PRODUCT_KEY = HRESULT(0xc004f093),
}

enum HRESULT SL_E_INCOMPLETE_OR_OLD_DISM_BINARIES = HRESULT(0xc004f094);
enum HRESULT SL_E_SLP_MSOA_PRODUCT_KEY_MISMATCH = HRESULT(0xc004f095);
enum HRESULT SL_E_NOT_GENUINE = HRESULT(0xc004f200);
enum HRESULT SL_E_EDITION_MISMATCHED = HRESULT(0xc004f210);
enum HRESULT SL_E_HWID_CHANGED = HRESULT(0xc004f211);
enum HRESULT SL_E_OEM_KEY_EDITION_MISMATCH = HRESULT(0xc004f212);
enum HRESULT SL_E_NO_PRODUCT_KEY_FOUND = HRESULT(0xc004f213);
enum HRESULT SL_E_DOWNLEVEL_SETUP_KEY = HRESULT(0xc004f214);
enum HRESULT SL_E_BIOS_KEY = HRESULT(0xc004f215);
enum HRESULT SL_E_TKA_CHALLENGE_EXPIRED = HRESULT(0xc004f301);
enum HRESULT SL_E_TKA_SILENT_ACTIVATION_FAILURE = HRESULT(0xc004f302);
enum HRESULT SL_E_TKA_INVALID_CERT_CHAIN = HRESULT(0xc004f303);
enum HRESULT SL_E_TKA_GRANT_NOT_FOUND = HRESULT(0xc004f304);
enum HRESULT SL_E_TKA_CERT_NOT_FOUND = HRESULT(0xc004f305);

enum : HRESULT
{
    SL_E_TKA_INVALID_SKU_ID      = HRESULT(0xc004f306),
    SL_E_TKA_INVALID_BLOB        = HRESULT(0xc004f307),
    SL_E_TKA_TAMPERED_CERT_CHAIN = HRESULT(0xc004f308),
}

enum HRESULT SL_E_TKA_CHALLENGE_MISMATCH = HRESULT(0xc004f309);

enum : HRESULT
{
    SL_E_TKA_INVALID_CERTIFICATE = HRESULT(0xc004f30a),
    SL_E_TKA_INVALID_SMARTCARD   = HRESULT(0xc004f30b),
}

enum HRESULT SL_E_TKA_FAILED_GRANT_PARSING = HRESULT(0xc004f30c);
enum HRESULT SL_E_TKA_INVALID_THUMBPRINT = HRESULT(0xc004f30d);
enum HRESULT SL_E_TKA_THUMBPRINT_CERT_NOT_FOUND = HRESULT(0xc004f30e);
enum HRESULT SL_E_TKA_CRITERIA_MISMATCH = HRESULT(0xc004f30f);

enum : HRESULT
{
    SL_E_TKA_TPID_MISMATCH        = HRESULT(0xc004f310),
    SL_E_TKA_SOFT_CERT_DISALLOWED = HRESULT(0xc004f311),
    SL_E_TKA_SOFT_CERT_INVALID    = HRESULT(0xc004f312),
}

enum HRESULT SL_E_TKA_CERT_CNG_NOT_AVAILABLE = HRESULT(0xc004f313);
enum HRESULT SL_I_STORE_BASED_ACTIVATION = HRESULT(0x4004f401);
enum HRESULT E_RM_UNKNOWN_ERROR = HRESULT(0xc004fc03);
enum HRESULT SL_I_TIMEBASED_VALIDITY_PERIOD = HRESULT(0x4004fc04);
enum HRESULT SL_I_PERPETUAL_OOB_GRACE_PERIOD = HRESULT(0x4004fc05);
enum HRESULT SL_I_TIMEBASED_EXTENDED_GRACE_PERIOD = HRESULT(0x4004fc06);
enum HRESULT SL_E_VALIDITY_PERIOD_EXPIRED = HRESULT(0xc004fc07);
enum HRESULT SL_E_IA_THROTTLE_LIMIT_EXCEEDED = HRESULT(0xc004fd00);
enum HRESULT SL_E_IA_INVALID_VIRTUALIZATION_PLATFORM = HRESULT(0xc004fd01);
enum HRESULT SL_E_IA_PARENT_PARTITION_NOT_ACTIVATED = HRESULT(0xc004fd02);

enum : HRESULT
{
    SL_E_IA_ID_MISMATCH       = HRESULT(0xc004fd03),
    SL_E_IA_MACHINE_NOT_BOUND = HRESULT(0xc004fd04),
}

enum HRESULT SL_E_TAMPER_RECOVERY_REQUIRES_ACTIVATION = HRESULT(0xc004fe00);
enum HRESULT SL_REMAPPING_SP_PUB_GENERAL_NOT_INITIALIZED = HRESULT(0xc004d101);

enum : HRESULT
{
    SL_REMAPPING_SP_STATUS_SYSTEM_TIME_SKEWED                = HRESULT(0x8004d102),
    SL_REMAPPING_SP_STATUS_GENERIC_FAILURE                   = HRESULT(0xc004d103),
    SL_REMAPPING_SP_STATUS_INVALIDARG                        = HRESULT(0xc004d104),
    SL_REMAPPING_SP_STATUS_ALREADY_EXISTS                    = HRESULT(0xc004d105),
    SL_REMAPPING_SP_STATUS_INSUFFICIENT_BUFFER               = HRESULT(0xc004d107),
    SL_REMAPPING_SP_STATUS_INVALIDDATA                       = HRESULT(0xc004d108),
    SL_REMAPPING_SP_STATUS_INVALID_SPAPI_CALL                = HRESULT(0xc004d109),
    SL_REMAPPING_SP_STATUS_INVALID_SPAPI_VERSION             = HRESULT(0xc004d10a),
    SL_REMAPPING_SP_STATUS_DEBUGGER_DETECTED                 = HRESULT(0x8004d10b),
    SL_REMAPPING_SP_STATUS_NO_MORE_DATA                      = HRESULT(0xc004d10c),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_KEYLENGTH             = HRESULT(0xc004d201),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_BLOCKLENGTH           = HRESULT(0xc004d202),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_CIPHER                = HRESULT(0xc004d203),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_CIPHERMODE            = HRESULT(0xc004d204),
    SL_REMAPPING_SP_PUB_CRYPTO_UNKNOWN_PROVIDERID            = HRESULT(0xc004d205),
    SL_REMAPPING_SP_PUB_CRYPTO_UNKNOWN_KEYID                 = HRESULT(0xc004d206),
    SL_REMAPPING_SP_PUB_CRYPTO_UNKNOWN_HASHID                = HRESULT(0xc004d207),
    SL_REMAPPING_SP_PUB_CRYPTO_UNKNOWN_ATTRIBUTEID           = HRESULT(0xc004d208),
    SL_REMAPPING_SP_PUB_CRYPTO_HASH_FINALIZED                = HRESULT(0xc004d209),
    SL_REMAPPING_SP_PUB_CRYPTO_KEY_NOT_AVAILABLE             = HRESULT(0xc004d20a),
    SL_REMAPPING_SP_PUB_CRYPTO_KEY_NOT_FOUND                 = HRESULT(0xc004d20b),
    SL_REMAPPING_SP_PUB_CRYPTO_NOT_BLOCK_ALIGNED             = HRESULT(0xc004d20c),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_SIGNATURELENGTH       = HRESULT(0xc004d20d),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_SIGNATURE             = HRESULT(0xc004d20e),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_BLOCK                 = HRESULT(0xc004d20f),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_FORMAT                = HRESULT(0xc004d210),
    SL_REMAPPING_SP_PUB_CRYPTO_INVALID_PADDING               = HRESULT(0xc004d211),
    SL_REMAPPING_SP_PUB_TS_TAMPERED                          = HRESULT(0xc004d301),
    SL_REMAPPING_SP_PUB_TS_REARMED                           = HRESULT(0xc004d302),
    SL_REMAPPING_SP_PUB_TS_RECREATED                         = HRESULT(0xc004d303),
    SL_REMAPPING_SP_PUB_TS_ENTRY_KEY_NOT_FOUND               = HRESULT(0xc004d304),
    SL_REMAPPING_SP_PUB_TS_ENTRY_KEY_ALREADY_EXISTS          = HRESULT(0xc004d305),
    SL_REMAPPING_SP_PUB_TS_ENTRY_KEY_SIZE_TOO_BIG            = HRESULT(0xc004d306),
    SL_REMAPPING_SP_PUB_TS_MAX_REARM_REACHED                 = HRESULT(0xc004d307),
    SL_REMAPPING_SP_PUB_TS_DATA_SIZE_TOO_BIG                 = HRESULT(0xc004d308),
    SL_REMAPPING_SP_PUB_TS_INVALID_HW_BINDING                = HRESULT(0xc004d309),
    SL_REMAPPING_SP_PUB_TIMER_ALREADY_EXISTS                 = HRESULT(0xc004d30a),
    SL_REMAPPING_SP_PUB_TIMER_NOT_FOUND                      = HRESULT(0xc004d30b),
    SL_REMAPPING_SP_PUB_TIMER_EXPIRED                        = HRESULT(0xc004d30c),
    SL_REMAPPING_SP_PUB_TIMER_NAME_SIZE_TOO_BIG              = HRESULT(0xc004d30d),
    SL_REMAPPING_SP_PUB_TS_FULL                              = HRESULT(0xc004d30e),
    SL_REMAPPING_SP_PUB_TRUSTED_TIME_OK                      = HRESULT(0x4004d30f),
    SL_REMAPPING_SP_PUB_TS_ENTRY_READ_ONLY                   = HRESULT(0xc004d310),
    SL_REMAPPING_SP_PUB_TIMER_READ_ONLY                      = HRESULT(0xc004d311),
    SL_REMAPPING_SP_PUB_TS_ATTRIBUTE_READ_ONLY               = HRESULT(0xc004d312),
    SL_REMAPPING_SP_PUB_TS_ATTRIBUTE_NOT_FOUND               = HRESULT(0xc004d313),
    SL_REMAPPING_SP_PUB_TS_ACCESS_DENIED                     = HRESULT(0xc004d314),
    SL_REMAPPING_SP_PUB_TS_NAMESPACE_NOT_FOUND               = HRESULT(0xc004d315),
    SL_REMAPPING_SP_PUB_TS_NAMESPACE_IN_USE                  = HRESULT(0xc004d316),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_BREADCRUMB_LOAD_INVALID  = HRESULT(0xc004d317),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_BREADCRUMB_GENERATION    = HRESULT(0xc004d318),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_INVALID_DATA             = HRESULT(0xc004d319),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_NO_DATA                  = HRESULT(0xc004d31a),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_DATA_BREADCRUMB_MISMATCH = HRESULT(0xc004d31b),
    SL_REMAPPING_SP_PUB_TS_TAMPERED_DATA_VERSION_MISMATCH    = HRESULT(0xc004d31c),
}

enum : HRESULT
{
    SL_REMAPPING_SP_PUB_TAMPER_MODULE_AUTHENTICATION      = HRESULT(0xc004d401),
    SL_REMAPPING_SP_PUB_TAMPER_SECURITY_PROCESSOR_PATCHED = HRESULT(0xc004d402),
}

enum : HRESULT
{
    SL_REMAPPING_SP_PUB_KM_CACHE_TAMPER                = HRESULT(0xc004d501),
    SL_REMAPPING_SP_PUB_KM_CACHE_TAMPER_RESTORE_FAILED = HRESULT(0xc004d502),
    SL_REMAPPING_SP_PUB_KM_CACHE_IDENTICAL             = HRESULT(0x4004d601),
    SL_REMAPPING_SP_PUB_KM_CACHE_POLICY_CHANGED        = HRESULT(0x4004d602),
}

enum : HRESULT
{
    SL_REMAPPING_SP_STATUS_PUSHKEY_CONFLICT              = HRESULT(0xc004d701),
    SL_REMAPPING_SP_PUB_PROXY_SOFT_TAMPER                = HRESULT(0xc004d702),
    SL_REMAPPING_SP_PUB_API_INVALID_LICENSE              = HRESULT(0xc004d000),
    SL_REMAPPING_SP_PUB_API_INVALID_ALGORITHM_TYPE       = HRESULT(0xc004d009),
    SL_REMAPPING_SP_PUB_API_TOO_MANY_LOADED_ENVIRONMENTS = HRESULT(0xc004d00c),
    SL_REMAPPING_SP_PUB_API_BAD_GET_INFO_QUERY           = HRESULT(0xc004d012),
    SL_REMAPPING_SP_PUB_API_INVALID_HANDLE               = HRESULT(0xc004d02c),
    SL_REMAPPING_SP_PUB_API_INVALID_KEY_LENGTH           = HRESULT(0xc004d055),
    SL_REMAPPING_SP_PUB_API_NO_AES_PROVIDER              = HRESULT(0xc004d073),
    SL_REMAPPING_SP_PUB_API_HANDLE_NOT_COMMITED          = HRESULT(0xc004d081),
}

enum : HRESULT
{
    SL_REMAPPING_MDOLLAR_PRODUCT_KEY_OUT_OF_RANGE               = HRESULT(0x803fa065),
    SL_REMAPPING_MDOLLAR_INVALID_BINDING                        = HRESULT(0x803fa066),
    SL_REMAPPING_MDOLLAR_PRODUCT_KEY_BLOCKED                    = HRESULT(0x803fa067),
    SL_REMAPPING_MDOLLAR_INVALID_PRODUCT_KEY                    = HRESULT(0x803fa068),
    SL_REMAPPING_MDOLLAR_UNSUPPORTED_PRODUCT_KEY                = HRESULT(0x803fa06c),
    SL_REMAPPING_MDOLLAR_MAXIMUM_UNLOCK_EXCEEDED                = HRESULT(0x803fa071),
    SL_REMAPPING_MDOLLAR_INVALID_PRODUCT_DATA_ID                = HRESULT(0x803fa073),
    SL_REMAPPING_MDOLLAR_INVALID_PRODUCT_DATA                   = HRESULT(0x803fa074),
    SL_REMAPPING_MDOLLAR_INVALID_ACTCONFIG_ID                   = HRESULT(0x803fa076),
    SL_REMAPPING_MDOLLAR_INVALID_PRODUCT_KEY_LENGTH             = HRESULT(0x803fa077),
    SL_REMAPPING_MDOLLAR_INVALID_PRODUCT_KEY_FORMAT             = HRESULT(0x803fa078),
    SL_REMAPPING_MDOLLAR_INVALID_BINDING_URI                    = HRESULT(0x803fa07a),
    SL_REMAPPING_MDOLLAR_INVALID_ARGUMENT                       = HRESULT(0x803fa07d),
    SL_REMAPPING_MDOLLAR_DMAK_LIMIT_EXCEEDED                    = HRESULT(0x803fa07f),
    SL_REMAPPING_MDOLLAR_DMAK_EXTENSION_LIMIT_EXCEEDED          = HRESULT(0x803fa080),
    SL_REMAPPING_MDOLLAR_OEM_SLP_COA0                           = HRESULT(0x803fa083),
    SL_REMAPPING_MDOLLAR_CIDIID_INVALID_VERSION                 = HRESULT(0x803fa08d),
    SL_REMAPPING_MDOLLAR_CIDIID_INVALID_DATA                    = HRESULT(0x803fa08e),
    SL_REMAPPING_MDOLLAR_CIDIID_INVALID_DATA_LENGTH             = HRESULT(0x803fa08f),
    SL_REMAPPING_MDOLLAR_CIDIID_INVALID_CHECK_DIGITS            = HRESULT(0x803fa090),
    SL_REMAPPING_MDOLLAR_TIMEBASED_ACTIVATION_BEFORE_START_DATE = HRESULT(0x803fa097),
    SL_REMAPPING_MDOLLAR_TIMEBASED_ACTIVATION_AFTER_END_DATE    = HRESULT(0x803fa098),
    SL_REMAPPING_MDOLLAR_TIMEBASED_ACTIVATION_NOT_AVAILABLE     = HRESULT(0x803fa099),
    SL_REMAPPING_MDOLLAR_TIMEBASED_PRODUCT_KEY_NOT_CONFIGURED   = HRESULT(0x803fa09a),
}

enum : HRESULT
{
    SL_REMAPPING_MDOLLAR_NO_RULES_TO_ACTIVATE                 = HRESULT(0x803fa0c8),
    SL_REMAPPING_MDOLLAR_PRODUCT_KEY_BLOCKED_IPLOCATION       = HRESULT(0x803fa0cb),
    SL_REMAPPING_MDOLLAR_DIGITALMARKER_INVALID_BINDING        = HRESULT(0x803fa0d3),
    SL_REMAPPING_MDOLLAR_DIGITALMARKER_BINDING_NOT_CONFIGURED = HRESULT(0x803fa0d4),
}

enum : HRESULT
{
    SL_REMAPPING_MDOLLAR_ROT_OVERRIDE_LIMIT_REACHED    = HRESULT(0x803fa0d5),
    SL_REMAPPING_MDOLLAR_DMAK_OVERRIDE_LIMIT_REACHED   = HRESULT(0x803fa0d6),
    SL_REMAPPING_MDOLLAR_FREE_OFFER_EXPIRED            = HRESULT(0x803fa400),
    SL_REMAPPING_MDOLLAR_OSR_DONOR_HWID_NO_ENTITLEMENT = HRESULT(0x803fabb8),
    SL_REMAPPING_MDOLLAR_OSR_GENERIC_ERROR             = HRESULT(0x803fabb9),
    SL_REMAPPING_MDOLLAR_OSR_NO_ASSOCIATION            = HRESULT(0x803fabba),
    SL_REMAPPING_MDOLLAR_OSR_NOT_ADMIN                 = HRESULT(0x803fabbb),
    SL_REMAPPING_MDOLLAR_OSR_USER_THROTTLED            = HRESULT(0x803fabbc),
    SL_REMAPPING_MDOLLAR_OSR_LICENSE_THROTTLED         = HRESULT(0x803fabbd),
    SL_REMAPPING_MDOLLAR_OSR_DEVICE_THROTTLED          = HRESULT(0x803fabbe),
    SL_REMAPPING_MDOLLAR_OSR_GP_DISABLED               = HRESULT(0x803fabbf),
    SL_REMAPPING_MDOLLAR_OSR_HARDWARE_BLOCKED          = HRESULT(0x803fabc0),
    SL_REMAPPING_MDOLLAR_OSR_USER_BLOCKED              = HRESULT(0x803fabc1),
    SL_REMAPPING_MDOLLAR_OSR_LICENSE_BLOCKED           = HRESULT(0x803fabc2),
    SL_REMAPPING_MDOLLAR_OSR_DEVICE_BLOCKED            = HRESULT(0x803fabc3),
}

enum GUID WINDOWS_SLID = GUID("55c92734-d682-4d71-983e-d6ec3f16059f");

enum : const(wchar)*
{
    // Native encoding: ansi
    WDIGEST_SP_NAME_A = "WDigest",
    WDIGEST_SP_NAME_W = "WDigest",
    WDIGEST_SP_NAME   = "WDigest",
}

// Callbacks

alias PSAM_PASSWORD_NOTIFICATION_ROUTINE = NTSTATUS function(LSA_UNICODE_STRING* UserName, uint RelativeId, 
                                                             LSA_UNICODE_STRING* NewPassword);
alias PSAM_INIT_NOTIFICATION_ROUTINE = BOOLEAN function();
alias PSAM_PASSWORD_FILTER_ROUTINE = BOOLEAN function(LSA_UNICODE_STRING* AccountName, 
                                                      LSA_UNICODE_STRING* FullName, LSA_UNICODE_STRING* Password, 
                                                      BOOLEAN SetOperation);
alias SEC_GET_KEY_FN = void function(void* Arg, void* Principal, uint KeyVer, void** Key, HRESULT* Status);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_W = HRESULT function(ushort* param0, ushort* param1, uint param2, void* param3, 
                                                         void* param4, SEC_GET_KEY_FN param5, void* param6, 
                                                         SecHandle* param7, long* param8);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_A = HRESULT function(byte* param0, byte* param1, uint param2, void* param3, 
                                                         void* param4, SEC_GET_KEY_FN param5, void* param6, 
                                                         SecHandle* param7, long* param8);
alias FREE_CREDENTIALS_HANDLE_FN = HRESULT function(SecHandle* param0);
alias ADD_CREDENTIALS_FN_W = HRESULT function(SecHandle* param0, ushort* param1, ushort* param2, uint param3, 
                                              void* param4, SEC_GET_KEY_FN param5, void* param6, long* param7);
alias ADD_CREDENTIALS_FN_A = HRESULT function(SecHandle* param0, byte* param1, byte* param2, uint param3, 
                                              void* param4, SEC_GET_KEY_FN param5, void* param6, long* param7);
alias CHANGE_PASSWORD_FN_W = HRESULT function(ushort* param0, ushort* param1, ushort* param2, ushort* param3, 
                                              ushort* param4, BOOLEAN param5, uint param6, SecBufferDesc* param7);
alias CHANGE_PASSWORD_FN_A = HRESULT function(byte* param0, byte* param1, byte* param2, byte* param3, byte* param4, 
                                              BOOLEAN param5, uint param6, SecBufferDesc* param7);
alias INITIALIZE_SECURITY_CONTEXT_FN_W = HRESULT function(SecHandle* param0, SecHandle* param1, ushort* param2, 
                                                          uint param3, uint param4, uint param5, 
                                                          SecBufferDesc* param6, uint param7, SecHandle* param8, 
                                                          SecBufferDesc* param9, uint* param10, long* param11);
alias INITIALIZE_SECURITY_CONTEXT_FN_A = HRESULT function(SecHandle* param0, SecHandle* param1, byte* param2, 
                                                          uint param3, uint param4, uint param5, 
                                                          SecBufferDesc* param6, uint param7, SecHandle* param8, 
                                                          SecBufferDesc* param9, uint* param10, long* param11);
alias ACCEPT_SECURITY_CONTEXT_FN = HRESULT function(SecHandle* param0, SecHandle* param1, SecBufferDesc* param2, 
                                                    uint param3, uint param4, SecHandle* param5, 
                                                    SecBufferDesc* param6, uint* param7, long* param8);
alias COMPLETE_AUTH_TOKEN_FN = HRESULT function(SecHandle* param0, SecBufferDesc* param1);
alias IMPERSONATE_SECURITY_CONTEXT_FN = HRESULT function(SecHandle* param0);
alias REVERT_SECURITY_CONTEXT_FN = HRESULT function(SecHandle* param0);
alias QUERY_SECURITY_CONTEXT_TOKEN_FN = HRESULT function(SecHandle* param0, void** param1);
alias DELETE_SECURITY_CONTEXT_FN = HRESULT function(SecHandle* param0);
alias APPLY_CONTROL_TOKEN_FN = HRESULT function(SecHandle* param0, SecBufferDesc* param1);
alias QUERY_CONTEXT_ATTRIBUTES_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2, 
                                                          uint param3);
alias QUERY_CONTEXT_ATTRIBUTES_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2, 
                                                          uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2, 
                                                              uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2, 
                                                              uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_W = HRESULT function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_A = HRESULT function(SecHandle* param0, uint param1, void* param2, uint param3);
alias FREE_CONTEXT_BUFFER_FN = HRESULT function(void* param0);
alias MAKE_SIGNATURE_FN = HRESULT function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias VERIFY_SIGNATURE_FN = HRESULT function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENCRYPT_MESSAGE_FN = HRESULT function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias DECRYPT_MESSAGE_FN = HRESULT function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENUMERATE_SECURITY_PACKAGES_FN_W = HRESULT function(uint* param0, SecPkgInfoW** param1);
alias ENUMERATE_SECURITY_PACKAGES_FN_A = HRESULT function(uint* param0, SecPkgInfoA** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_W = HRESULT function(ushort* param0, SecPkgInfoW** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_A = HRESULT function(byte* param0, SecPkgInfoA** param1);
alias EXPORT_SECURITY_CONTEXT_FN = HRESULT function(SecHandle* param0, uint param1, SecBuffer* param2, 
                                                    void** param3);
alias IMPORT_SECURITY_CONTEXT_FN_W = HRESULT function(ushort* param0, SecBuffer* param1, void* param2, 
                                                      SecHandle* param3);
alias IMPORT_SECURITY_CONTEXT_FN_A = HRESULT function(byte* param0, SecBuffer* param1, void* param2, 
                                                      SecHandle* param3);
alias INIT_SECURITY_INTERFACE_A = SecurityFunctionTableA* function();
alias INIT_SECURITY_INTERFACE_W = SecurityFunctionTableW* function();
alias PLSA_CREATE_LOGON_SESSION = NTSTATUS function(LUID* LogonId);
alias PLSA_DELETE_LOGON_SESSION = NTSTATUS function(LUID* LogonId);
alias PLSA_ADD_CREDENTIAL = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, 
                                              LSA_STRING* PrimaryKeyValue, LSA_STRING* Credentials);
alias PLSA_GET_CREDENTIALS = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, uint* QueryContext, 
                                               BOOLEAN RetrieveAllCredentials, LSA_STRING* PrimaryKeyValue, 
                                               uint* PrimaryKeyLength, LSA_STRING* Credentials);
alias PLSA_DELETE_CREDENTIAL = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, 
                                                 LSA_STRING* PrimaryKeyValue);
alias PLSA_ALLOCATE_LSA_HEAP = void* function(uint Length);
alias PLSA_FREE_LSA_HEAP = void function(void* Base);
alias PLSA_ALLOCATE_PRIVATE_HEAP = void* function(size_t Length);
alias PLSA_FREE_PRIVATE_HEAP = void function(void* Base);
alias PLSA_ALLOCATE_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint LengthRequired, 
                                                      void** ClientBaseAddress);
alias PLSA_FREE_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, void* ClientBaseAddress);
alias PLSA_COPY_TO_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint Length, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* ClientBaseAddress, 
                                                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* BufferToCopy);
alias PLSA_COPY_FROM_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint Length, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* BufferToCopy, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* ClientBaseAddress);
alias PLSA_AP_INITIALIZE_PACKAGE = NTSTATUS function(uint AuthenticationPackageId, 
                                                     LSA_DISPATCH_TABLE* LsaDispatchTable, LSA_STRING* Database, 
                                                     LSA_STRING* Confidentiality, 
                                                     LSA_STRING** AuthenticationPackageName);
alias PLSA_AP_LOGON_USER = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* AuthenticationInformation, 
                                             void* ClientAuthenticationBase, uint AuthenticationInformationLength, 
                                             void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, 
                                             int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                             void** TokenInformation, LSA_UNICODE_STRING** AccountName, 
                                             LSA_UNICODE_STRING** AuthenticatingAuthority);
alias PLSA_AP_LOGON_USER_EX = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* AuthenticationInformation, 
                                                void* ClientAuthenticationBase, uint AuthenticationInformationLength, 
                                                void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, 
                                                int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                                void** TokenInformation, LSA_UNICODE_STRING** AccountName, 
                                                LSA_UNICODE_STRING** AuthenticatingAuthority, 
                                                LSA_UNICODE_STRING** MachineName);
alias PLSA_AP_CALL_PACKAGE = NTSTATUS function(void** ClientRequest, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                               void* ClientBufferBase, uint SubmitBufferLength, 
                                               void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                               int* ProtocolStatus);
alias PLSA_AP_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function(void** ClientRequest, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                                           void* ClientBufferBase, uint SubmitBufferLength, 
                                                           void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                                           int* ProtocolStatus);
alias PLSA_AP_LOGON_TERMINATED = void function(LUID* LogonId);
alias PSAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE = NTSTATUS function(LSA_UNICODE_STRING* ClearPassword, 
                                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* OldCredentials, 
                                                                uint OldCredentialSize, uint UserAccountControl, 
                                                                LSA_UNICODE_STRING* UPN, 
                                                                LSA_UNICODE_STRING* UserName, 
                                                                LSA_UNICODE_STRING* NetbiosDomainName, 
                                                                LSA_UNICODE_STRING* DnsDomainName, 
                                                                void** NewCredentials, uint* NewCredentialSize);
alias PSAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE = BOOLEAN function(LSA_UNICODE_STRING* CredentialName);
alias PSAM_CREDENTIAL_UPDATE_FREE_ROUTINE = void function(void* p);
alias PSAM_CREDENTIAL_UPDATE_REGISTER_MAPPED_ENTRYPOINTS_ROUTINE = NTSTATUS function(SAM_REGISTER_MAPPING_TABLE* Table);
alias PLSA_CALLBACK_FUNCTION = NTSTATUS function(size_t Argument1, size_t Argument2, SecBuffer* InputBuffer, 
                                                 SecBuffer* OutputBuffer);
alias PLSA_REDIRECTED_LOGON_INIT = NTSTATUS function(HANDLE RedirectedLogonHandle, 
                                                     const(LSA_UNICODE_STRING)* PackageName, uint SessionId, 
                                                     const(LUID)* LogonId);
alias PLSA_REDIRECTED_LOGON_CALLBACK = NTSTATUS function(HANDLE RedirectedLogonHandle, void* Buffer, 
                                                         uint BufferLength, void** ReturnBuffer, 
                                                         uint* ReturnBufferLength);
alias PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK = void function(HANDLE RedirectedLogonHandle);
alias PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS = NTSTATUS function(HANDLE RedirectedLogonHandle, ubyte** LogonBuffer, 
                                                                uint* LogonBufferLength);
alias PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS = NTSTATUS function(HANDLE RedirectedLogonHandle, 
                                                               SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_REDIRECTED_LOGON_GET_SID = NTSTATUS function(HANDLE RedirectedLogonHandle, PSID* Sid);
alias PLSA_IMPERSONATE_CLIENT = NTSTATUS function();
alias PLSA_UNLOAD_PACKAGE = NTSTATUS function();
alias PLSA_DUPLICATE_HANDLE = NTSTATUS function(HANDLE SourceHandle, HANDLE* DestionationHandle);
alias PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS = NTSTATUS function(LUID* LogonId, uint SupplementalCredSize, 
                                                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* SupplementalCreds, 
                                                             BOOLEAN Synchronous);
alias PLSA_CREATE_THREAD = HANDLE function(SECURITY_ATTRIBUTES* SecurityAttributes, uint StackSize, 
                                           LPTHREAD_START_ROUTINE StartFunction, void* ThreadParameter, 
                                           uint CreationFlags, uint* ThreadId);
alias PLSA_GET_CLIENT_INFO = NTSTATUS function(SECPKG_CLIENT_INFO* ClientInfo);
alias PLSA_GET_CLIENT_INFO_EX = NTSTATUS function(SECPKG_CLIENT_INFO_EX* ClientInfo, uint StructSize);
alias PLSA_REGISTER_NOTIFICATION = HANDLE function(LPTHREAD_START_ROUTINE StartFunction, void* Parameter, 
                                                   uint NotificationType, uint NotificationClass, 
                                                   uint NotificationFlags, uint IntervalMinutes, HANDLE WaitEvent);
alias PLSA_CANCEL_NOTIFICATION = NTSTATUS function(HANDLE NotifyHandle);
alias PLSA_MAP_BUFFER = NTSTATUS function(SecBuffer* InputBuffer, SecBuffer* OutputBuffer);
alias PLSA_CREATE_TOKEN = NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, 
                                            SECURITY_LOGON_TYPE LogonType, 
                                            SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                            LSA_TOKEN_INFORMATION_TYPE TokenInformationType, void* TokenInformation, 
                                            TOKEN_GROUPS* TokenGroups, LSA_UNICODE_STRING* AccountName, 
                                            LSA_UNICODE_STRING* AuthorityName, LSA_UNICODE_STRING* Workstation, 
                                            LSA_UNICODE_STRING* ProfilePath, HANDLE* Token, int* SubStatus);
alias PLSA_CREATE_TOKEN_EX = NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, 
                                               SECURITY_LOGON_TYPE LogonType, 
                                               SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                               LSA_TOKEN_INFORMATION_TYPE TokenInformationType, 
                                               void* TokenInformation, TOKEN_GROUPS* TokenGroups, 
                                               LSA_UNICODE_STRING* Workstation, LSA_UNICODE_STRING* ProfilePath, 
                                               void* SessionInformation, 
                                               SECPKG_SESSIONINFO_TYPE SessionInformationType, HANDLE* Token, 
                                               int* SubStatus);
alias PLSA_AUDIT_LOGON = void function(NTSTATUS Status, NTSTATUS SubStatus, LSA_UNICODE_STRING* AccountName, 
                                       LSA_UNICODE_STRING* AuthenticatingAuthority, 
                                       LSA_UNICODE_STRING* WorkstationName, PSID UserSid, 
                                       SECURITY_LOGON_TYPE LogonType, TOKEN_SOURCE* TokenSource, LUID* LogonId);
alias PLSA_CALL_PACKAGE = NTSTATUS function(LSA_UNICODE_STRING* AuthenticationPackage, 
                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* ProtocolSubmitBuffer, 
                                            uint SubmitBufferLength, void** ProtocolReturnBuffer, 
                                            uint* ReturnBufferLength, int* ProtocolStatus);
alias PLSA_CALL_PACKAGEEX = NTSTATUS function(LSA_UNICODE_STRING* AuthenticationPackage, void* ClientBufferBase, 
                                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                              uint SubmitBufferLength, void** ProtocolReturnBuffer, 
                                              uint* ReturnBufferLength, int* ProtocolStatus);
alias PLSA_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function(LSA_UNICODE_STRING* AuthenticationPackage, 
                                                        void* ClientBufferBase, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                                        uint SubmitBufferLength, void** ProtocolReturnBuffer, 
                                                        uint* ReturnBufferLength, int* ProtocolStatus);
alias PLSA_GET_CALL_INFO = BOOLEAN function(SECPKG_CALL_INFO* Info);
alias PLSA_CREATE_SHARED_MEMORY = void* function(uint MaxSize, uint InitialSize);
alias PLSA_ALLOCATE_SHARED_MEMORY = void* function(void* SharedMem, uint Size);
alias PLSA_FREE_SHARED_MEMORY = void function(void* SharedMem, void* Memory);
alias PLSA_DELETE_SHARED_MEMORY = BOOLEAN function(void* SharedMem);
alias PLSA_GET_APP_MODE_INFO = NTSTATUS function(uint* UserFunction, size_t* Argument1, size_t* Argument2, 
                                                 SecBuffer* UserData, BOOLEAN* ReturnToLsa);
alias PLSA_SET_APP_MODE_INFO = NTSTATUS function(uint UserFunction, size_t Argument1, size_t Argument2, 
                                                 SecBuffer* UserData, BOOLEAN ReturnToLsa);
alias PLSA_GET_SECPKG_FAILURE_REASON = NTSTATUS function(const(size_t) PackageID, SECPKG_FAILURE_REASON* Reason);
alias PLSA_SET_SECPKG_FAILURE_REASON = NTSTATUS function(const(SECPKG_FAILURE_REASON) Reason);
alias PLSA_OPEN_SAM_USER = NTSTATUS function(SECURITY_STRING* Name, SECPKG_NAME_TYPE NameType, 
                                             SECURITY_STRING* Prefix, BOOLEAN AllowGuest, uint Reserved, 
                                             void** UserHandle);
alias PLSA_GET_USER_CREDENTIALS = NTSTATUS function(void* UserHandle, void** PrimaryCreds, uint* PrimaryCredsSize, 
                                                    void** SupplementalCreds, uint* SupplementalCredsSize);
alias PLSA_GET_USER_AUTH_DATA = NTSTATUS function(void* UserHandle, ubyte** UserAuthData, uint* UserAuthDataSize);
alias PLSA_CLOSE_SAM_USER = NTSTATUS function(void* UserHandle);
alias PLSA_GET_AUTH_DATA_FOR_USER = NTSTATUS function(SECURITY_STRING* Name, SECPKG_NAME_TYPE NameType, 
                                                      SECURITY_STRING* Prefix, ubyte** UserAuthData, 
                                                      uint* UserAuthDataSize, LSA_UNICODE_STRING* UserFlatName);
alias PLSA_CONVERT_AUTH_DATA_TO_TOKEN = NTSTATUS function(void* UserAuthData, uint UserAuthDataSize, 
                                                          SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                                          TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, 
                                                          LSA_UNICODE_STRING* AuthorityName, HANDLE* Token, 
                                                          LUID* LogonId, LSA_UNICODE_STRING* AccountName, 
                                                          int* SubStatus);
alias PLSA_CRACK_SINGLE_NAME = NTSTATUS function(uint FormatOffered, BOOLEAN PerformAtGC, 
                                                 LSA_UNICODE_STRING* NameInput, LSA_UNICODE_STRING* Prefix, 
                                                 uint RequestedFormat, LSA_UNICODE_STRING* CrackedName, 
                                                 LSA_UNICODE_STRING* DnsDomainName, uint* SubStatus);
alias PLSA_AUDIT_ACCOUNT_LOGON = NTSTATUS function(uint AuditId, BOOLEAN Success, LSA_UNICODE_STRING* Source, 
                                                   LSA_UNICODE_STRING* ClientName, LSA_UNICODE_STRING* MappedName, 
                                                   NTSTATUS Status);
alias PLSA_CLIENT_CALLBACK = NTSTATUS function(/*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PSTR Callback, 
                                               size_t Argument1, size_t Argument2, SecBuffer* Input, 
                                               SecBuffer* Output);
alias PLSA_REGISTER_CALLBACK = NTSTATUS function(uint CallbackId, PLSA_CALLBACK_FUNCTION Callback);
alias PLSA_GET_EXTENDED_CALL_FLAGS = NTSTATUS function(uint* Flags);
alias PLSA_UPDATE_PRIMARY_CREDENTIALS = NTSTATUS function(SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                          SECPKG_SUPPLEMENTAL_CRED_ARRAY* Credentials);
alias PLSA_PROTECT_MEMORY = void function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Buffer, 
                                          uint BufferSize);
alias PLSA_OPEN_TOKEN_BY_LOGON_ID = NTSTATUS function(LUID* LogonId, HANDLE* RetTokenHandle);
alias PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN = NTSTATUS function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* UserAuthData, 
                                                           uint UserAuthDataSize, void* Reserved, 
                                                           ubyte** ExpandedAuthData, uint* ExpandedAuthDataSize);
alias PLSA_GET_SERVICE_ACCOUNT_PASSWORD = NTSTATUS function(LSA_UNICODE_STRING* AccountName, 
                                                            LSA_UNICODE_STRING* DomainName, CRED_FETCH CredFetch, 
                                                            FILETIME* FileTimeExpiry, 
                                                            LSA_UNICODE_STRING* CurrentPassword, 
                                                            LSA_UNICODE_STRING* PreviousPassword, 
                                                            FILETIME* FileTimeCurrPwdValidForOutbound);
alias PLSA_AUDIT_LOGON_EX = void function(NTSTATUS Status, NTSTATUS SubStatus, LSA_UNICODE_STRING* AccountName, 
                                          LSA_UNICODE_STRING* AuthenticatingAuthority, 
                                          LSA_UNICODE_STRING* WorkstationName, PSID UserSid, 
                                          SECURITY_LOGON_TYPE LogonType, 
                                          SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_SOURCE* TokenSource, 
                                          LUID* LogonId);
alias PLSA_CHECK_PROTECTED_USER_BY_TOKEN = NTSTATUS function(HANDLE UserToken, BOOLEAN* ProtectedUser);
alias PLSA_QUERY_CLIENT_REQUEST = NTSTATUS function(void** ClientRequest, uint QueryType, void** ReplyBuffer);
alias CredReadFn = NTSTATUS function(LUID* LogonId, uint CredFlags, PWSTR TargetName, uint Type, uint Flags, 
                                     ENCRYPTED_CREDENTIALW** Credential);
alias CredReadDomainCredentialsFn = NTSTATUS function(LUID* LogonId, uint CredFlags, 
                                                      CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, 
                                                      uint* Count, ENCRYPTED_CREDENTIALW*** Credential);
alias CredFreeCredentialsFn = void function(uint Count, ENCRYPTED_CREDENTIALW** Credentials);
alias CredWriteFn = NTSTATUS function(LUID* LogonId, uint CredFlags, ENCRYPTED_CREDENTIALW* Credential, uint Flags);
alias CrediUnmarshalandDecodeStringFn = NTSTATUS function(PWSTR MarshaledString, ubyte** Blob, uint* BlobSize, 
                                                          ubyte* IsFailureFatal);
alias PLSA_LOCATE_PKG_BY_ID = void* function(uint PackgeId);
alias SpInitializeFn = NTSTATUS function(size_t PackageId, SECPKG_PARAMETERS* Parameters, 
                                         LSA_SECPKG_FUNCTION_TABLE* FunctionTable);
alias SpShutdownFn = NTSTATUS function();
alias SpGetInfoFn = NTSTATUS function(SecPkgInfoA* PackageInfo);
alias SpGetExtendedInformationFn = NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, 
                                                     SECPKG_EXTENDED_INFORMATION** ppInformation);
alias SpSetExtendedInformationFn = NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, 
                                                     SECPKG_EXTENDED_INFORMATION* Info);
alias PLSA_AP_LOGON_USER_EX2 = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ProtocolSubmitBuffer, 
                                                 void* ClientBufferBase, uint SubmitBufferSize, void** ProfileBuffer, 
                                                 uint* ProfileBufferSize, LUID* LogonId, int* SubStatus, 
                                                 LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                                 void** TokenInformation, LSA_UNICODE_STRING** AccountName, 
                                                 LSA_UNICODE_STRING** AuthenticatingAuthority, 
                                                 LSA_UNICODE_STRING** MachineName, 
                                                 SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                 SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_LOGON_USER_EX3 = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ProtocolSubmitBuffer, 
                                                 void* ClientBufferBase, uint SubmitBufferSize, 
                                                 SECPKG_SURROGATE_LOGON* SurrogateLogon, void** ProfileBuffer, 
                                                 uint* ProfileBufferSize, LUID* LogonId, int* SubStatus, 
                                                 LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                                 void** TokenInformation, LSA_UNICODE_STRING** AccountName, 
                                                 LSA_UNICODE_STRING** AuthenticatingAuthority, 
                                                 LSA_UNICODE_STRING** MachineName, 
                                                 SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                 SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_PRE_LOGON_USER_SURROGATE = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ProtocolSubmitBuffer, 
                                                           void* ClientBufferBase, uint SubmitBufferSize, 
                                                           SECPKG_SURROGATE_LOGON* SurrogateLogon, int* SubStatus);
alias PLSA_AP_POST_LOGON_USER_SURROGATE = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* ProtocolSubmitBuffer, 
                                                            void* ClientBufferBase, uint SubmitBufferSize, 
                                                            SECPKG_SURROGATE_LOGON* SurrogateLogon, 
                                                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(7)))])*/void* ProfileBuffer, 
                                                            uint ProfileBufferSize, LUID* LogonId, NTSTATUS Status, 
                                                            NTSTATUS SubStatus, 
                                                            LSA_TOKEN_INFORMATION_TYPE TokenInformationType, 
                                                            void* TokenInformation, LSA_UNICODE_STRING* AccountName, 
                                                            LSA_UNICODE_STRING* AuthenticatingAuthority, 
                                                            LSA_UNICODE_STRING* MachineName, 
                                                            SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                            SECPKG_SUPPLEMENTAL_CRED_ARRAY* SupplementalCredentials);
alias SpAcceptCredentialsFn = NTSTATUS function(SECURITY_LOGON_TYPE LogonType, LSA_UNICODE_STRING* AccountName, 
                                                SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                SECPKG_SUPPLEMENTAL_CRED* SupplementalCredentials);
alias SpAcquireCredentialsHandleFn = NTSTATUS function(LSA_UNICODE_STRING* PrincipalName, uint CredentialUseFlags, 
                                                       LUID* LogonId, void* AuthorizationData, void* GetKeyFunciton, 
                                                       void* GetKeyArgument, size_t* CredentialHandle, 
                                                       long* ExpirationTime);
alias SpFreeCredentialsHandleFn = NTSTATUS function(size_t CredentialHandle);
alias SpQueryCredentialsAttributesFn = NTSTATUS function(size_t CredentialHandle, uint CredentialAttribute, 
                                                         void* Buffer);
alias SpSetCredentialsAttributesFn = NTSTATUS function(size_t CredentialHandle, uint CredentialAttribute, 
                                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                                       uint BufferSize);
alias SpAddCredentialsFn = NTSTATUS function(size_t CredentialHandle, LSA_UNICODE_STRING* PrincipalName, 
                                             LSA_UNICODE_STRING* Package, uint CredentialUseFlags, 
                                             void* AuthorizationData, void* GetKeyFunciton, void* GetKeyArgument, 
                                             long* ExpirationTime);
alias SpSaveCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Credentials);
alias SpGetCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Credentials);
alias SpDeleteCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Key);
alias SpInitLsaModeContextFn = NTSTATUS function(size_t CredentialHandle, size_t ContextHandle, 
                                                 LSA_UNICODE_STRING* TargetName, uint ContextRequirements, 
                                                 uint TargetDataRep, SecBufferDesc* InputBuffers, 
                                                 size_t* NewContextHandle, SecBufferDesc* OutputBuffers, 
                                                 uint* ContextAttributes, long* ExpirationTime, 
                                                 BOOLEAN* MappedContext, SecBuffer* ContextData);
alias SpDeleteContextFn = NTSTATUS function(size_t ContextHandle);
alias SpApplyControlTokenFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* ControlToken);
alias SpAcceptLsaModeContextFn = NTSTATUS function(size_t CredentialHandle, size_t ContextHandle, 
                                                   SecBufferDesc* InputBuffer, uint ContextRequirements, 
                                                   uint TargetDataRep, size_t* NewContextHandle, 
                                                   SecBufferDesc* OutputBuffer, uint* ContextAttributes, 
                                                   long* ExpirationTime, BOOLEAN* MappedContext, 
                                                   SecBuffer* ContextData);
alias SpGetUserInfoFn = NTSTATUS function(LUID* LogonId, uint Flags, SECURITY_USER_DATA** UserData);
alias SpQueryContextAttributesFn = NTSTATUS function(size_t ContextHandle, uint ContextAttribute, void* Buffer);
alias SpSetContextAttributesFn = NTSTATUS function(size_t ContextHandle, uint ContextAttribute, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* Buffer, 
                                                   uint BufferSize);
alias SpChangeAccountPasswordFn = NTSTATUS function(LSA_UNICODE_STRING* pDomainName, 
                                                    LSA_UNICODE_STRING* pAccountName, 
                                                    LSA_UNICODE_STRING* pOldPassword, 
                                                    LSA_UNICODE_STRING* pNewPassword, BOOLEAN Impersonating, 
                                                    SecBufferDesc* pOutput);
alias SpQueryMetaDataFn = NTSTATUS function(size_t CredentialHandle, LSA_UNICODE_STRING* TargetName, 
                                            uint ContextRequirements, uint* MetaDataLength, ubyte** MetaData, 
                                            size_t* ContextHandle);
alias SpExchangeMetaDataFn = NTSTATUS function(size_t CredentialHandle, LSA_UNICODE_STRING* TargetName, 
                                               uint ContextRequirements, uint MetaDataLength, 
                                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* MetaData, 
                                               size_t* ContextHandle);
alias SpGetCredUIContextFn = NTSTATUS function(size_t ContextHandle, GUID* CredType, uint* FlatCredUIContextLength, 
                                               ubyte** FlatCredUIContext);
alias SpUpdateCredentialsFn = NTSTATUS function(size_t ContextHandle, GUID* CredType, uint FlatCredUIContextLength, 
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* FlatCredUIContext);
alias SpValidateTargetInfoFn = NTSTATUS function(void** ClientRequest, 
                                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                                 void* ClientBufferBase, uint SubmitBufferLength, 
                                                 SECPKG_TARGETINFO* TargetInfo);
alias SpExtractTargetInfoFn = NTSTATUS function(void** ClientRequest, 
                                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                                void* ClientBufferBase, uint SubmitBufferLength, 
                                                void** ppvTargetInfo, uint* pcbTargetInfo);
alias LSA_AP_POST_LOGON_USER = NTSTATUS function(SECPKG_POST_LOGON_USER_INFO* PostLogonUserInfo);
alias SpGetRemoteCredGuardLogonBufferFn = NTSTATUS function(size_t CredHandle, size_t ContextHandle, 
                                                            const(LSA_UNICODE_STRING)* TargetName, 
                                                            HANDLE* RedirectedLogonHandle, 
                                                            PLSA_REDIRECTED_LOGON_CALLBACK* Callback, 
                                                            PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK* CleanupCallback, 
                                                            uint* LogonBufferSize, void** LogonBuffer);
alias SpGetRemoteCredGuardSupplementalCredsFn = NTSTATUS function(size_t CredHandle, 
                                                                  const(LSA_UNICODE_STRING)* TargetName, 
                                                                  HANDLE* RedirectedLogonHandle, 
                                                                  PLSA_REDIRECTED_LOGON_CALLBACK* Callback, 
                                                                  PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK* CleanupCallback, 
                                                                  uint* SupplementalCredsSize, 
                                                                  void** SupplementalCreds);
alias SpGetTbalSupplementalCredsFn = NTSTATUS function(LUID LogonId, uint* SupplementalCredsSize, 
                                                       void** SupplementalCreds);
alias SpInstanceInitFn = NTSTATUS function(uint Version, SECPKG_DLL_FUNCTIONS* FunctionTable, void** UserFunctions);
alias SpInitUserModeContextFn = NTSTATUS function(size_t ContextHandle, SecBuffer* PackedContext);
alias SpMakeSignatureFn = NTSTATUS function(size_t ContextHandle, uint QualityOfProtection, 
                                            SecBufferDesc* MessageBuffers, uint MessageSequenceNumber);
alias SpVerifySignatureFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* MessageBuffers, 
                                              uint MessageSequenceNumber, uint* QualityOfProtection);
alias SpSealMessageFn = NTSTATUS function(size_t ContextHandle, uint QualityOfProtection, 
                                          SecBufferDesc* MessageBuffers, uint MessageSequenceNumber);
alias SpUnsealMessageFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* MessageBuffers, 
                                            uint MessageSequenceNumber, uint* QualityOfProtection);
alias SpGetContextTokenFn = NTSTATUS function(size_t ContextHandle, HANDLE* ImpersonationToken);
alias SpExportSecurityContextFn = NTSTATUS function(size_t phContext, uint fFlags, SecBuffer* pPackedContext, 
                                                    HANDLE* pToken);
alias SpImportSecurityContextFn = NTSTATUS function(SecBuffer* pPackedContext, HANDLE Token, size_t* phContext);
alias SpCompleteAuthTokenFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* InputBuffer);
alias SpFormatCredentialsFn = NTSTATUS function(SecBuffer* Credentials, SecBuffer* FormattedCredentials);
alias SpMarshallSupplementalCredsFn = NTSTATUS function(uint CredentialSize, 
                                                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/ubyte* Credentials, 
                                                        uint* MarshalledCredSize, void** MarshalledCreds);
alias SpMarshalAttributeDataFn = NTSTATUS function(uint AttributeInfo, uint Attribute, uint AttributeDataSize, 
                                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* AttributeData, 
                                                   uint* MarshaledAttributeDataSize, ubyte** MarshaledAttributeData);
alias SpLsaModeInitializeFn = NTSTATUS function(uint LsaVersion, uint* PackageVersion, 
                                                SECPKG_FUNCTION_TABLE** ppTables, uint* pcTables);
alias SpUserModeInitializeFn = NTSTATUS function(uint LsaVersion, uint* PackageVersion, 
                                                 SECPKG_USER_FUNCTION_TABLE** ppTables, uint* pcTables);
alias PKSEC_CREATE_CONTEXT_LIST = void* function(KSEC_CONTEXT_TYPE Type);
alias PKSEC_INSERT_LIST_ENTRY = void function(void* List, KSEC_LIST_ENTRY* Entry);
alias PKSEC_REFERENCE_LIST_ENTRY = NTSTATUS function(KSEC_LIST_ENTRY* Entry, uint Signature, BOOLEAN RemoveNoRef);
alias PKSEC_DEREFERENCE_LIST_ENTRY = void function(KSEC_LIST_ENTRY* Entry, ubyte* Delete);
alias PKSEC_SERIALIZE_WINNT_AUTH_DATA = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias PKSEC_LOCATE_PKG_BY_ID = void* function(uint PackageId);
alias KspInitPackageFn = NTSTATUS function(SECPKG_KERNEL_FUNCTIONS* FunctionTable);
alias KspDeleteContextFn = NTSTATUS function(size_t ContextId, size_t* LsaContextId);
alias KspInitContextFn = NTSTATUS function(size_t ContextId, SecBuffer* ContextData, size_t* NewContextId);
alias KspMakeSignatureFn = NTSTATUS function(size_t ContextId, uint fQOP, SecBufferDesc* Message, 
                                             uint MessageSeqNo);
alias KspVerifySignatureFn = NTSTATUS function(size_t ContextId, SecBufferDesc* Message, uint MessageSeqNo, 
                                               uint* pfQOP);
alias KspSealMessageFn = NTSTATUS function(size_t ContextId, uint fQOP, SecBufferDesc* Message, uint MessageSeqNo);
alias KspUnsealMessageFn = NTSTATUS function(size_t ContextId, SecBufferDesc* Message, uint MessageSeqNo, 
                                             uint* pfQOP);
alias KspGetTokenFn = NTSTATUS function(size_t ContextId, HANDLE* ImpersonationToken, void** RawToken);
alias KspQueryAttributesFn = NTSTATUS function(size_t ContextId, uint Attribute, void* Buffer);
alias KspCompleteTokenFn = NTSTATUS function(size_t ContextId, SecBufferDesc* Token);
alias KspMapHandleFn = NTSTATUS function(size_t ContextId, size_t* LsaContextId);
alias KspSetPagingModeFn = NTSTATUS function(BOOLEAN PagingMode);
alias KspSerializeAuthDataFn = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias SSL_EMPTY_CACHE_FN_A = BOOL function(PSTR pszTargetName, uint dwFlags);
alias SSL_EMPTY_CACHE_FN_W = BOOL function(PWSTR pszTargetName, uint dwFlags);
alias SSL_CRACK_CERTIFICATE_FN = BOOL function(ubyte* pbCertificate, uint cbCertificate, BOOL VerifySignature, 
                                               X509Certificate** ppCertificate);
alias SSL_FREE_CERTIFICATE_FN = void function(X509Certificate* pCertificate);
alias SslGetServerIdentityFn = HRESULT function(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* ClientHello, 
                                                uint ClientHelloSize, ubyte** ServerIdentity, 
                                                uint* ServerIdentitySize, uint Flags);
alias SslGetExtensionsFn = HRESULT function(const(ubyte)* clientHello, uint clientHelloByteSize, 
                                            SCH_EXTENSION_DATA* genericExtensions, ubyte genericExtensionsCount, 
                                            uint* bytesToRead, SchGetExtensionsOptions flags);
alias SslDeserializeCertificateStoreFn = HRESULT function(CRYPT_INTEGER_BLOB SerializedCertificateStore, 
                                                          CERT_CONTEXT** ppCertContext);

// Structs


@RAIIFree!LsaClose
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/SecMgmt/lsa-handle
struct LSA_HANDLE
{
    ptrdiff_t Value;
}

struct _HMAPPER
{
    ptrdiff_t Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_unicode_string
struct LSA_UNICODE_STRING
{
    ushort Length;
    ushort MaximumLength;
    PWSTR  Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_string
struct LSA_STRING
{
    ushort Length;
    ushort MaximumLength;
    PSTR   Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_object_attributes
struct LSA_OBJECT_ATTRIBUTES
{
    uint                Length;
    HANDLE              RootDirectory;
    LSA_UNICODE_STRING* ObjectName;
    uint                Attributes;
    void*               SecurityDescriptor;
    void*               SecurityQualityOfService;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_trust_information
struct LSA_TRUST_INFORMATION
{
    LSA_UNICODE_STRING Name;
    PSID               Sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_referenced_domain_list
struct LSA_REFERENCED_DOMAIN_LIST
{
    uint Entries;
    LSA_TRUST_INFORMATION* Domains;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_translated_sid2
struct LSA_TRANSLATED_SID2
{
    SID_NAME_USE Use;
    PSID         Sid;
    int          DomainIndex;
    uint         Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-lsa_translated_name
struct LSA_TRANSLATED_NAME
{
    SID_NAME_USE       Use;
    LSA_UNICODE_STRING Name;
    int                DomainIndex;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-policy_account_domain_info
struct POLICY_ACCOUNT_DOMAIN_INFO
{
    LSA_UNICODE_STRING DomainName;
    PSID               DomainSid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/lsalookup/ns-lsalookup-policy_dns_domain_info
struct POLICY_DNS_DOMAIN_INFO
{
    LSA_UNICODE_STRING Name;
    LSA_UNICODE_STRING DnsDomainName;
    LSA_UNICODE_STRING DnsForestName;
    GUID               DomainGuid;
    PSID               Sid;
}

struct SE_ADT_OBJECT_TYPE
{
    GUID   ObjectType;
    ushort Flags;
    ushort Level;
    uint   AccessMask;
}

struct SE_ADT_PARAMETER_ARRAY_ENTRY
{
    SE_ADT_PARAMETER_TYPE Type;
    uint      Length;
    size_t[2] Data;
    void*     Address;
}

struct SE_ADT_ACCESS_REASON
{
    uint                 AccessMask;
    uint[32]             AccessReasons;
    uint                 ObjectTypeIndex;
    uint                 AccessGranted;
    PSECURITY_DESCRIPTOR SecurityDescriptor;
}

struct SE_ADT_CLAIMS
{
    uint  Length;
    void* Claims;
}

struct SE_ADT_PARAMETER_ARRAY
{
    uint   CategoryId;
    uint   AuditId;
    uint   ParameterCount;
    uint   Length;
    ushort FlatSubCategoryId;
    ushort Type;
    uint   Flags;
    SE_ADT_PARAMETER_ARRAY_ENTRY[32] Parameters;
}

struct SE_ADT_PARAMETER_ARRAY_EX
{
    uint   CategoryId;
    uint   AuditId;
    uint   Version;
    uint   ParameterCount;
    uint   Length;
    ushort FlatSubCategoryId;
    ushort Type;
    uint   Flags;
    SE_ADT_PARAMETER_ARRAY_ENTRY[32] Parameters;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_translated_sid
struct LSA_TRANSLATED_SID
{
    SID_NAME_USE Use;
    uint         RelativeId;
    int          DomainIndex;
}

struct POLICY_AUDIT_LOG_INFO
{
    uint    AuditLogPercentFull;
    uint    MaximumLogSize;
    long    AuditRetentionPeriod;
    BOOLEAN AuditLogFullShutdownInProgress;
    long    TimeToShutdown;
    uint    NextAuditRecordId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-policy_audit_events_info
struct POLICY_AUDIT_EVENTS_INFO
{
    BOOLEAN AuditingMode;
    uint*   EventAuditingOptions;
    uint    MaximumAuditEventCount;
}

struct POLICY_AUDIT_SUBCATEGORIES_INFO
{
    uint  MaximumSubCategoryCount;
    uint* EventAuditingOptions;
}

struct POLICY_AUDIT_CATEGORIES_INFO
{
    uint MaximumCategoryCount;
    POLICY_AUDIT_SUBCATEGORIES_INFO* SubCategoriesInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-policy_primary_domain_info
struct POLICY_PRIMARY_DOMAIN_INFO
{
    LSA_UNICODE_STRING Name;
    PSID               Sid;
}

struct POLICY_PD_ACCOUNT_INFO
{
    LSA_UNICODE_STRING Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-policy_lsa_server_role_info
struct POLICY_LSA_SERVER_ROLE_INFO
{
    POLICY_LSA_SERVER_ROLE LsaServerRole;
}

struct POLICY_REPLICA_SOURCE_INFO
{
    LSA_UNICODE_STRING ReplicaSource;
    LSA_UNICODE_STRING ReplicaAccountName;
}

struct POLICY_DEFAULT_QUOTA_INFO
{
    QUOTA_LIMITS QuotaLimits;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-policy_modification_info
struct POLICY_MODIFICATION_INFO
{
    long ModifiedId;
    long DatabaseCreationTime;
}

struct POLICY_AUDIT_FULL_SET_INFO
{
    BOOLEAN ShutDownOnFull;
}

struct POLICY_AUDIT_FULL_QUERY_INFO
{
    BOOLEAN ShutDownOnFull;
    BOOLEAN LogIsFull;
}

struct POLICY_DOMAIN_EFS_INFO
{
    uint   InfoLength;
    ubyte* EfsBlob;
}

struct POLICY_DOMAIN_KERBEROS_TICKET_INFO
{
    uint AuthenticationOptions;
    long MaxServiceTicketAge;
    long MaxTicketAge;
    long MaxRenewAge;
    long MaxClockSkew;
    long Reserved;
}

struct POLICY_MACHINE_ACCT_INFO
{
    uint Rid;
    PSID Sid;
}

struct POLICY_MACHINE_ACCT_INFO2
{
    uint Rid;
    PSID Sid;
    GUID ObjectGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_domain_name_info
struct TRUSTED_DOMAIN_NAME_INFO
{
    LSA_UNICODE_STRING Name;
}

struct TRUSTED_CONTROLLERS_INFO
{
    uint                Entries;
    LSA_UNICODE_STRING* Names;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_posix_offset_info
struct TRUSTED_POSIX_OFFSET_INFO
{
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_password_info
struct TRUSTED_PASSWORD_INFO
{
    LSA_UNICODE_STRING Password;
    LSA_UNICODE_STRING OldPassword;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_domain_information_ex
struct TRUSTED_DOMAIN_INFORMATION_EX
{
    LSA_UNICODE_STRING Name;
    LSA_UNICODE_STRING FlatName;
    PSID               Sid;
    TRUSTED_DOMAIN_TRUST_DIRECTION TrustDirection;
    TRUSTED_DOMAIN_TRUST_TYPE TrustType;
    TRUSTED_DOMAIN_TRUST_ATTRIBUTES TrustAttributes;
}

struct TRUSTED_DOMAIN_INFORMATION_EX2
{
    LSA_UNICODE_STRING Name;
    LSA_UNICODE_STRING FlatName;
    PSID               Sid;
    uint               TrustDirection;
    uint               TrustType;
    uint               TrustAttributes;
    uint               ForestTrustLength;
    ubyte*             ForestTrustInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_auth_information
struct LSA_AUTH_INFORMATION
{
    long   LastUpdateTime;
    LSA_AUTH_INFORMATION_AUTH_TYPE AuthType;
    uint   AuthInfoLength;
    ubyte* AuthInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_domain_auth_information
struct TRUSTED_DOMAIN_AUTH_INFORMATION
{
    uint IncomingAuthInfos;
    LSA_AUTH_INFORMATION* IncomingAuthenticationInformation;
    LSA_AUTH_INFORMATION* IncomingPreviousAuthenticationInformation;
    uint OutgoingAuthInfos;
    LSA_AUTH_INFORMATION* OutgoingAuthenticationInformation;
    LSA_AUTH_INFORMATION* OutgoingPreviousAuthenticationInformation;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-trusted_domain_full_information
struct TRUSTED_DOMAIN_FULL_INFORMATION
{
    TRUSTED_DOMAIN_INFORMATION_EX Information;
    TRUSTED_POSIX_OFFSET_INFO PosixOffset;
    TRUSTED_DOMAIN_AUTH_INFORMATION AuthInformation;
}

struct TRUSTED_DOMAIN_FULL_INFORMATION2
{
    TRUSTED_DOMAIN_INFORMATION_EX2 Information;
    TRUSTED_POSIX_OFFSET_INFO PosixOffset;
    TRUSTED_DOMAIN_AUTH_INFORMATION AuthInformation;
}

struct TRUSTED_DOMAIN_SUPPORTED_ENCRYPTION_TYPES
{
    uint SupportedEncryptionTypes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_domain_info
struct LSA_FOREST_TRUST_DOMAIN_INFO
{
    PSID               Sid;
    LSA_UNICODE_STRING DnsName;
    LSA_UNICODE_STRING NetbiosName;
}

struct LSA_FOREST_TRUST_SCANNER_INFO
{
    PSID               DomainSid;
    LSA_UNICODE_STRING DnsName;
    LSA_UNICODE_STRING NetbiosName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_binary_data
struct LSA_FOREST_TRUST_BINARY_DATA
{
    uint   Length;
    ubyte* Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_record
struct LSA_FOREST_TRUST_RECORD
{
    uint Flags;
    LSA_FOREST_TRUST_RECORD_TYPE ForestTrustType;
    long Time;
    union ForestTrustData
    {
        LSA_UNICODE_STRING TopLevelName;
        LSA_FOREST_TRUST_DOMAIN_INFO DomainInfo;
        LSA_FOREST_TRUST_BINARY_DATA Data;
    }
}

struct LSA_FOREST_TRUST_RECORD2
{
    uint Flags;
    LSA_FOREST_TRUST_RECORD_TYPE ForestTrustType;
    long Time;
    union ForestTrustData
    {
        LSA_UNICODE_STRING TopLevelName;
        LSA_FOREST_TRUST_DOMAIN_INFO DomainInfo;
        LSA_FOREST_TRUST_BINARY_DATA BinaryData;
        LSA_FOREST_TRUST_SCANNER_INFO ScannerInfo;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_information
struct LSA_FOREST_TRUST_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_RECORD** Entries;
}

struct LSA_FOREST_TRUST_INFORMATION2
{
    uint RecordCount;
    LSA_FOREST_TRUST_RECORD2** Entries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_collision_record
struct LSA_FOREST_TRUST_COLLISION_RECORD
{
    uint               Index;
    LSA_FOREST_TRUST_COLLISION_RECORD_TYPE Type;
    uint               Flags;
    LSA_UNICODE_STRING Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_forest_trust_collision_information
struct LSA_FOREST_TRUST_COLLISION_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_COLLISION_RECORD** Entries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_enumeration_information
struct LSA_ENUMERATION_INFORMATION
{
    PSID Sid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-lsa_last_inter_logon_info
struct LSA_LAST_INTER_LOGON_INFO
{
    long LastSuccessfulLogon;
    long LastFailedLogon;
    uint FailedAttemptCountSinceLastSuccessfulLogon;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-security_logon_session_data
struct SECURITY_LOGON_SESSION_DATA
{
    uint               Size;
    LUID               LogonId;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING LogonDomain;
    LSA_UNICODE_STRING AuthenticationPackage;
    uint               LogonType;
    uint               Session;
    PSID               Sid;
    long               LogonTime;
    LSA_UNICODE_STRING LogonServer;
    LSA_UNICODE_STRING DnsDomainName;
    LSA_UNICODE_STRING Upn;
    uint               UserFlags;
    LSA_LAST_INTER_LOGON_INFO LastLogonInfo;
    LSA_UNICODE_STRING LogonScript;
    LSA_UNICODE_STRING ProfilePath;
    LSA_UNICODE_STRING HomeDirectory;
    LSA_UNICODE_STRING HomeDirectoryDrive;
    long               LogoffTime;
    long               KickOffTime;
    long               PasswordLastSet;
    long               PasswordCanChange;
    long               PasswordMustChange;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntlsa/ns-ntlsa-central_access_policy_entry
struct CENTRAL_ACCESS_POLICY_ENTRY
{
    LSA_UNICODE_STRING   Name;
    LSA_UNICODE_STRING   Description;
    LSA_UNICODE_STRING   ChangeId;
    uint                 LengthAppliesTo;
    ubyte*               AppliesTo;
    uint                 LengthSD;
    PSECURITY_DESCRIPTOR SD;
    uint                 LengthStagedSD;
    PSECURITY_DESCRIPTOR StagedSD;
    uint                 Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntlsa/ns-ntlsa-central_access_policy
struct CENTRAL_ACCESS_POLICY
{
    PSID               CAPID;
    LSA_UNICODE_STRING Name;
    LSA_UNICODE_STRING Description;
    LSA_UNICODE_STRING ChangeId;
    uint               Flags;
    uint               CAPECount;
    CENTRAL_ACCESS_POLICY_ENTRY** CAPEs;
}

struct NEGOTIATE_PACKAGE_PREFIX
{
    size_t    PackageId;
    void*     PackageDataA;
    void*     PackageDataW;
    size_t    PrefixLen;
    ubyte[32] Prefix;
}

struct NEGOTIATE_PACKAGE_PREFIXES
{
    uint MessageType;
    uint PrefixCount;
    uint Offset;
    uint Pad;
}

struct NEGOTIATE_CALLER_NAME_REQUEST
{
    uint MessageType;
    LUID LogonId;
}

struct NEGOTIATE_CALLER_NAME_RESPONSE
{
    uint  MessageType;
    PWSTR CallerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-domain_password_information
struct DOMAIN_PASSWORD_INFORMATION
{
    ushort MinPasswordLength;
    ushort PasswordHistoryLength;
    DOMAIN_PASSWORD_PROPERTIES PasswordProperties;
    long   MaxPasswordAge;
    long   MinPasswordAge;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_interactive_logon
struct MSV1_0_INTERACTIVE_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING LogonDomainName;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_interactive_profile
struct MSV1_0_INTERACTIVE_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    ushort             LogonCount;
    ushort             BadPasswordCount;
    long               LogonTime;
    long               LogoffTime;
    long               KickOffTime;
    long               PasswordLastSet;
    long               PasswordCanChange;
    long               PasswordMustChange;
    LSA_UNICODE_STRING LogonScript;
    LSA_UNICODE_STRING HomeDirectory;
    LSA_UNICODE_STRING FullName;
    LSA_UNICODE_STRING ProfilePath;
    LSA_UNICODE_STRING HomeDirectoryDrive;
    LSA_UNICODE_STRING LogonServer;
    uint               UserFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_lm20_logon
struct MSV1_0_LM20_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING LogonDomainName;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Workstation;
    ubyte[8]           ChallengeToClient;
    LSA_STRING         CaseSensitiveChallengeResponse;
    LSA_STRING         CaseInsensitiveChallengeResponse;
    uint               ParameterControl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_subauth_logon
struct MSV1_0_SUBAUTH_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING LogonDomainName;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Workstation;
    ubyte[8]           ChallengeToClient;
    LSA_STRING         AuthenticationInfo1;
    LSA_STRING         AuthenticationInfo2;
    MSV_SUBAUTH_LOGON_PARAMETER_CONTROL ParameterControl;
    uint               SubAuthPackageId;
}

struct MSV1_0_S4U_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING UserPrincipalName;
    LSA_UNICODE_STRING DomainName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_lm20_logon_profile
struct MSV1_0_LM20_LOGON_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    long               KickOffTime;
    long               LogoffTime;
    MSV_SUB_AUTHENTICATION_FILTER UserFlags;
    ubyte[16]          UserSessionKey;
    LSA_UNICODE_STRING LogonDomainName;
    ubyte[8]           LanmanSessionKey;
    LSA_UNICODE_STRING LogonServer;
    LSA_UNICODE_STRING UserParameters;
}

struct MSV1_0_CREDENTIAL_KEY
{
    ubyte[20] Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_supplemental_credential
struct MSV1_0_SUPPLEMENTAL_CREDENTIAL
{
    uint      Version;
    MSV_SUPPLEMENTAL_CREDENTIAL_FLAGS Flags;
    ubyte[16] LmPassword;
    ubyte[16] NtPassword;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V2
{
    uint      Version;
    uint      Flags;
    ubyte[16] NtPassword;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL_V3
{
    uint      Version;
    uint      Flags;
    MSV1_0_CREDENTIAL_KEY_TYPE CredentialKeyType;
    ubyte[16] NtPassword;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
    ubyte[20] ShaPassword;
}

struct MSV1_0_IUM_SUPPLEMENTAL_CREDENTIAL
{
    uint     Version;
    uint     EncryptedCredsSize;
    ubyte[1] EncryptedCreds; // Flexible array
}

struct MSV1_0_REMOTE_SUPPLEMENTAL_CREDENTIAL
{
align (1):
    uint     Version;
    uint     Flags;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
    MSV1_0_CREDENTIAL_KEY_TYPE CredentialKeyType;
    uint     EncryptedCredsSize;
    ubyte[1] EncryptedCreds; // Flexible array
}

struct MSV1_0_NTLM3_RESPONSE
{
    ubyte[16] Response;
    ubyte     RespType;
    ubyte     HiRespType;
    ushort    Flags;
    uint      MsgWord;
    ulong     TimeStamp;
    ubyte[8]  ChallengeFromClient;
    uint      AvPairsOff;
    ubyte[1]  Buffer; // Flexible array
}

struct MSV1_0_AV_PAIR
{
    ushort AvId;
    ushort AvLen;
}

struct MSV1_0_CHANGEPASSWORD_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING AccountName;
    LSA_UNICODE_STRING OldPassword;
    LSA_UNICODE_STRING NewPassword;
    BOOLEAN            Impersonating;
}

struct MSV1_0_CHANGEPASSWORD_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    BOOLEAN PasswordInfoValid;
    DOMAIN_PASSWORD_INFORMATION DomainPasswordInfo;
}

struct MSV1_0_PASSTHROUGH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING PackageName;
    uint               DataLength;
    ubyte*             LogonData;
    uint               Pad;
}

struct MSV1_0_PASSTHROUGH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   Pad;
    uint   DataLength;
    ubyte* ValidationData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_subauth_request
struct MSV1_0_SUBAUTH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   SubAuthPackageId;
    uint   SubAuthInfoLength;
    ubyte* SubAuthSubmitBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-msv1_0_subauth_response
struct MSV1_0_SUBAUTH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   SubAuthInfoLength;
    ubyte* SubAuthReturnBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_interactive_logon
struct KERB_INTERACTIVE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING LogonDomainName;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Password;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_interactive_unlock_logon
struct KERB_INTERACTIVE_UNLOCK_LOGON
{
    KERB_INTERACTIVE_LOGON Logon;
    LUID LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_smart_card_logon
struct KERB_SMART_CARD_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING Pin;
    uint               CspDataLength;
    ubyte*             CspData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_smart_card_unlock_logon
struct KERB_SMART_CARD_UNLOCK_LOGON
{
    KERB_SMART_CARD_LOGON Logon;
    LUID LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_certificate_logon
struct KERB_CERTIFICATE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Pin;
    uint               Flags;
    uint               CspDataLength;
    ubyte*             CspData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_certificate_unlock_logon
struct KERB_CERTIFICATE_UNLOCK_LOGON
{
    KERB_CERTIFICATE_LOGON Logon;
    LUID LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_certificate_s4u_logon
struct KERB_CERTIFICATE_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING UserPrincipalName;
    LSA_UNICODE_STRING DomainName;
    uint               CertificateLength;
    ubyte*             Certificate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_ticket_logon
struct KERB_TICKET_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint   Flags;
    uint   ServiceTicketLength;
    uint   TicketGrantingTicketLength;
    ubyte* ServiceTicket;
    ubyte* TicketGrantingTicket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_ticket_unlock_logon
struct KERB_TICKET_UNLOCK_LOGON
{
    KERB_TICKET_LOGON Logon;
    LUID              LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_s4u_logon
struct KERB_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING ClientUpn;
    LSA_UNICODE_STRING ClientRealm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_interactive_profile
struct KERB_INTERACTIVE_PROFILE
{
    KERB_PROFILE_BUFFER_TYPE MessageType;
    ushort             LogonCount;
    ushort             BadPasswordCount;
    long               LogonTime;
    long               LogoffTime;
    long               KickOffTime;
    long               PasswordLastSet;
    long               PasswordCanChange;
    long               PasswordMustChange;
    LSA_UNICODE_STRING LogonScript;
    LSA_UNICODE_STRING HomeDirectory;
    LSA_UNICODE_STRING FullName;
    LSA_UNICODE_STRING ProfilePath;
    LSA_UNICODE_STRING HomeDirectoryDrive;
    LSA_UNICODE_STRING LogonServer;
    uint               UserFlags;
}

struct KERB_SMART_CARD_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    uint   CertificateSize;
    ubyte* CertificateData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_crypto_key
struct KERB_CRYPTO_KEY
{
    KERB_CRYPTO_KEY_TYPE KeyType;
    uint                 Length;
    ubyte*               Value;
}

struct KERB_CRYPTO_KEY32
{
    int  KeyType;
    uint Length;
    uint Offset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_ticket_profile
struct KERB_TICKET_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    KERB_CRYPTO_KEY SessionKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_tkt_cache_request
struct KERB_QUERY_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_ticket_cache_info
struct KERB_TICKET_CACHE_INFO
{
    LSA_UNICODE_STRING ServerName;
    LSA_UNICODE_STRING RealmName;
    long               StartTime;
    long               EndTime;
    long               RenewTime;
    int                EncryptionType;
    KERB_TICKET_FLAGS  TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX
{
    LSA_UNICODE_STRING ClientName;
    LSA_UNICODE_STRING ClientRealm;
    LSA_UNICODE_STRING ServerName;
    LSA_UNICODE_STRING ServerRealm;
    long               StartTime;
    long               EndTime;
    long               RenewTime;
    int                EncryptionType;
    uint               TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX2
{
    LSA_UNICODE_STRING ClientName;
    LSA_UNICODE_STRING ClientRealm;
    LSA_UNICODE_STRING ServerName;
    LSA_UNICODE_STRING ServerRealm;
    long               StartTime;
    long               EndTime;
    long               RenewTime;
    int                EncryptionType;
    uint               TicketFlags;
    uint               SessionKeyType;
    uint               BranchId;
}

struct KERB_TICKET_CACHE_INFO_EX3
{
    LSA_UNICODE_STRING ClientName;
    LSA_UNICODE_STRING ClientRealm;
    LSA_UNICODE_STRING ServerName;
    LSA_UNICODE_STRING ServerRealm;
    long               StartTime;
    long               EndTime;
    long               RenewTime;
    int                EncryptionType;
    uint               TicketFlags;
    uint               SessionKeyType;
    uint               BranchId;
    uint               CacheFlags;
    LSA_UNICODE_STRING KdcCalled;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_tkt_cache_response
struct KERB_QUERY_TKT_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO[1] Tickets; // Flexible array
}

struct KERB_QUERY_TKT_CACHE_EX_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX[1] Tickets; // Flexible array
}

struct KERB_QUERY_TKT_CACHE_EX2_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX2[1] Tickets; // Flexible array
}

struct KERB_QUERY_TKT_CACHE_EX3_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX3[1] Tickets; // Flexible array
}

struct KERB_AUTH_DATA
{
    uint   Type;
    uint   Length;
    ubyte* Data;
}

struct KERB_NET_ADDRESS
{
    uint Family;
    uint Length;
    PSTR Address;
}

struct KERB_NET_ADDRESSES
{
    uint                Number;
    KERB_NET_ADDRESS[1] Addresses; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_external_name
struct KERB_EXTERNAL_NAME
{
    short  NameType;
    ushort NameCount;
    LSA_UNICODE_STRING[1] Names; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_external_ticket
struct KERB_EXTERNAL_TICKET
{
    KERB_EXTERNAL_NAME* ServiceName;
    KERB_EXTERNAL_NAME* TargetName;
    KERB_EXTERNAL_NAME* ClientName;
    LSA_UNICODE_STRING  DomainName;
    LSA_UNICODE_STRING  TargetDomainName;
    LSA_UNICODE_STRING  AltTargetDomainName;
    KERB_CRYPTO_KEY     SessionKey;
    KERB_TICKET_FLAGS   TicketFlags;
    uint                Flags;
    long                KeyExpirationTime;
    long                StartTime;
    long                EndTime;
    long                RenewUntil;
    long                TimeSkew;
    uint                EncodedTicketSize;
    ubyte*              EncodedTicket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_retrieve_tkt_request
struct KERB_RETRIEVE_TKT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID                 LogonId;
    LSA_UNICODE_STRING   TargetName;
    uint                 TicketFlags;
    uint                 CacheOptions;
    KERB_CRYPTO_KEY_TYPE EncryptionType;
    SecHandle            CredentialsHandle;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_retrieve_tkt_response
struct KERB_RETRIEVE_TKT_RESPONSE
{
    KERB_EXTERNAL_TICKET Ticket;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_purge_tkt_cache_request
struct KERB_PURGE_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID               LogonId;
    LSA_UNICODE_STRING ServerName;
    LSA_UNICODE_STRING RealmName;
}

struct KERB_PURGE_TKT_CACHE_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
    uint Flags;
    KERB_TICKET_CACHE_INFO_EX TicketTemplate;
}

struct KERB_SUBMIT_TKT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID              LogonId;
    uint              Flags;
    KERB_CRYPTO_KEY32 Key;
    uint              KerbCredSize;
    uint              KerbCredOffset;
}

struct KERB_QUERY_KDC_PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KDC_PROXY_CACHE_ENTRY_DATA
{
    ulong              SinceLastUsed;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING ProxyServerName;
    LSA_UNICODE_STRING ProxyServerVdir;
    ushort             ProxyServerPort;
    LUID               LogonId;
    LSA_UNICODE_STRING CredUserName;
    LSA_UNICODE_STRING CredDomainName;
    BOOLEAN            GlobalCache;
}

struct KERB_QUERY_KDC_PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfEntries;
    KDC_PROXY_CACHE_ENTRY_DATA* Entries;
}

struct KERB_PURGE_KDC_PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KERB_PURGE_KDC_PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfPurged;
}

struct KERB_S4U2PROXY_CACHE_ENTRY_INFO
{
    LSA_UNICODE_STRING ServerName;
    uint               Flags;
    NTSTATUS           LastStatus;
    long               Expiry;
}

struct KERB_S4U2PROXY_CRED
{
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING DomainName;
    uint               Flags;
    NTSTATUS           LastStatus;
    long               Expiry;
    uint               CountOfEntries;
    KERB_S4U2PROXY_CACHE_ENTRY_INFO* Entries;
}

struct KERB_QUERY_S4U2PROXY_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    LUID LogonId;
}

struct KERB_QUERY_S4U2PROXY_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint                 CountOfCreds;
    KERB_S4U2PROXY_CRED* Creds;
}

struct KERB_RETRIEVE_KEY_TAB_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING Password;
}

struct KERB_RETRIEVE_KEY_TAB_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   KeyTabLength;
    ubyte* KeyTab;
}

struct KERB_REFRESH_POLICY_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
}

struct KERB_REFRESH_POLICY_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
}

struct KERB_CLOUD_KERBEROS_DEBUG_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

struct KERB_CLOUD_KERBEROS_DEBUG_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint    Version;
    uint    Length;
    uint[1] Data; // Flexible array
}

struct KERB_CLOUD_KERBEROS_DEBUG_DATA_V0
{
    // Native bit field: EnabledByPolicy: [0], AsRepCallbackPresent: [1], AsRepCallbackUsed: [2], CloudReferralTgtAvailable: [3], SpnOracleConfigured: [4], KdcProxyPresent: [5]
    uint _bitfield0;
}

struct KERB_CLOUD_KERBEROS_DEBUG_DATA
{
    // Native bit field: EnabledByPolicy: [0], AsRepCallbackPresent: [1], AsRepCallbackUsed: [2], CloudReferralTgtAvailable: [3], SpnOracleConfigured: [4], KdcProxyPresent: [5], PublicKeyCredsPresent: [6], PasswordKeysPresent: [7], PasswordPresent: [8], AsRepSourceCred: [9-16]
    uint _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_changepassword_request
struct KERB_CHANGEPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING AccountName;
    LSA_UNICODE_STRING OldPassword;
    LSA_UNICODE_STRING NewPassword;
    BOOLEAN            Impersonating;
}

struct KERB_SETPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID               LogonId;
    SecHandle          CredentialsHandle;
    uint               Flags;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING AccountName;
    LSA_UNICODE_STRING Password;
}

struct KERB_SETPASSWORD_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID               LogonId;
    SecHandle          CredentialsHandle;
    uint               Flags;
    LSA_UNICODE_STRING AccountRealm;
    LSA_UNICODE_STRING AccountName;
    LSA_UNICODE_STRING Password;
    LSA_UNICODE_STRING ClientRealm;
    LSA_UNICODE_STRING ClientName;
    BOOLEAN            Impersonating;
    LSA_UNICODE_STRING KdcAddress;
    uint               KdcAddressType;
}

struct KERB_CHANGEMACHINEPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    BOOLEAN ForcePasswordChange;
}

struct KERB_DECRYPT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID            LogonId;
    uint            Flags;
    int             CryptoType;
    int             KeyUsage;
    KERB_CRYPTO_KEY Key;
    uint            EncryptedDataSize;
    uint            InitialVectorSize;
    ubyte*          InitialVector;
    ubyte*          EncryptedData;
}

struct KERB_DECRYPT_RESPONSE
{
    ubyte[1] DecryptedData; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_add_binding_cache_entry_request
struct KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING RealmName;
    LSA_UNICODE_STRING KdcAddress;
    KERB_ADDRESS_TYPE  AddressType;
}

struct KERB_REFRESH_SCCRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING CredentialBlob;
    LUID               LogonId;
    uint               Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_add_credentials_request
struct KERB_ADD_CREDENTIALS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING Password;
    LUID               LogonId;
    KERB_REQUEST_FLAGS Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_add_credentials_request_ex
struct KERB_ADD_CREDENTIALS_REQUEST_EX
{
    KERB_ADD_CREDENTIALS_REQUEST Credentials;
    uint PrincipalNameCount;
    LSA_UNICODE_STRING[1] PrincipalNames; // Flexible array
}

struct KERB_TRANSFER_CRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID OriginLogonId;
    LUID DestinationLogonId;
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_cleanup_machine_pkinit_creds_request
struct KERB_CLEANUP_MACHINE_PKINIT_CREDS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_binding_cache_entry_data
struct KERB_BINDING_CACHE_ENTRY_DATA
{
    ulong              DiscoveryTime;
    LSA_UNICODE_STRING RealmName;
    LSA_UNICODE_STRING KdcAddress;
    KERB_ADDRESS_TYPE  AddressType;
    uint               Flags;
    uint               DcFlags;
    uint               CacheFlags;
    LSA_UNICODE_STRING KdcName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_binding_cache_response
struct KERB_QUERY_BINDING_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfEntries;
    KERB_BINDING_CACHE_ENTRY_DATA* Entries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_add_binding_cache_entry_ex_request
struct KERB_ADD_BINDING_CACHE_ENTRY_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LSA_UNICODE_STRING RealmName;
    LSA_UNICODE_STRING KdcAddress;
    KERB_ADDRESS_TYPE  AddressType;
    uint               DcFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_binding_cache_request
struct KERB_QUERY_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_purge_binding_cache_request
struct KERB_PURGE_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_domain_extended_policies_request
struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING DomainName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_query_domain_extended_policies_response
struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    uint ExtendedPolicies;
    uint DsFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_certificate_hashinfo
struct KERB_CERTIFICATE_HASHINFO
{
    ushort StoreNameLength;
    ushort HashLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-kerb_certificate_info
struct KERB_CERTIFICATE_INFO
{
    uint CertInfoSize;
    uint InfoType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-policy_audit_sid_array
struct POLICY_AUDIT_SID_ARRAY
{
    uint  UsersCount;
    PSID* UserSidArray;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-audit_policy_information
struct AUDIT_POLICY_INFORMATION
{
    GUID AuditSubCategoryGuid;
    uint AuditingInformation;
    GUID AuditCategoryGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-pku2u_cert_blob
struct PKU2U_CERT_BLOB
{
    uint   CertOffset;
    ushort CertLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-pku2u_credui_context
struct PKU2U_CREDUI_CONTEXT
{
    ulong  Version;
    ushort cbHeaderLength;
    uint   cbStructureLength;
    ushort CertArrayCount;
    uint   CertArrayOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/ns-ntsecapi-pku2u_certificate_s4u_logon
struct PKU2U_CERTIFICATE_S4U_LOGON
{
    PKU2U_LOGON_SUBMIT_TYPE MessageType;
    uint               Flags;
    LSA_UNICODE_STRING UserPrincipalName;
    LSA_UNICODE_STRING DomainName;
    uint               CertificateLength;
    ubyte*             Certificate;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-security_string
struct SECURITY_STRING
{
    ushort  Length;
    ushort  MaximumLength;
    ushort* Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkginfow
struct SecPkgInfoW
{
    uint    fCapabilities;
    ushort  wVersion;
    ushort  wRPCID;
    uint    cbMaxToken;
    ushort* Name;
    ushort* Comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkginfoa
struct SecPkgInfoA
{
    uint   fCapabilities;
    ushort wVersion;
    ushort wRPCID;
    uint   cbMaxToken;
    byte*  Name;
    byte*  Comment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secbuffer
struct SecBuffer
{
    uint  cbBuffer;
    uint  BufferType;
    void* pvBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secbufferdesc
struct SecBufferDesc
{
    uint       ulVersion;
    uint       cBuffers;
    SecBuffer* pBuffers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_negotiation_info
struct SEC_NEGOTIATION_INFO
{
    uint    Size;
    uint    NameLength;
    ushort* Name;
    void*   Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_channel_bindings
struct SEC_CHANNEL_BINDINGS
{
    uint dwInitiatorAddrType;
    uint cbInitiatorLength;
    uint dwInitiatorOffset;
    uint dwAcceptorAddrType;
    uint cbAcceptorLength;
    uint dwAcceptorOffset;
    uint cbApplicationDataLength;
    uint dwApplicationDataOffset;
}

struct SEC_CHANNEL_BINDINGS_EX
{
    uint magicNumber;
    uint flags;
    uint cbHeaderLength;
    uint cbStructureLength;
    uint dwInitiatorAddrType;
    uint cbInitiatorLength;
    uint dwInitiatorOffset;
    uint dwAcceptorAddrType;
    uint cbAcceptorLength;
    uint dwAcceptorOffset;
    uint cbApplicationDataLength;
    uint dwApplicationDataOffset;
}

struct SEC_CHANNEL_BINDINGS_RESULT
{
    uint flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_application_protocol_list
struct SEC_APPLICATION_PROTOCOL_LIST
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ushort   ProtocolListSize;
    ubyte[1] ProtocolList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_application_protocols
struct SEC_APPLICATION_PROTOCOLS
{
    uint ProtocolListsSize;
    SEC_APPLICATION_PROTOCOL_LIST[1] ProtocolLists; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_srtp_protection_profiles
struct SEC_SRTP_PROTECTION_PROFILES
{
    ushort    ProfilesSize;
    ushort[1] ProfilesList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_srtp_master_key_identifier
struct SEC_SRTP_MASTER_KEY_IDENTIFIER
{
    ubyte    MasterKeyIdentifierSize;
    ubyte[1] MasterKeyIdentifier; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_token_binding
struct SEC_TOKEN_BINDING
{
    ubyte    MajorVersion;
    ubyte    MinorVersion;
    ushort   KeyParametersSize;
    ubyte[1] KeyParameters; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_presharedkey
struct SEC_PRESHAREDKEY
{
    ushort   KeySize;
    ubyte[1] Key; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_presharedkey_identity
struct SEC_PRESHAREDKEY_IDENTITY
{
    ushort   KeyIdentitySize;
    ubyte[1] KeyIdentity; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_dtls_mtu
struct SEC_DTLS_MTU
{
    ushort PathMTU;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_flags
struct SEC_FLAGS
{
    ulong Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_certificate_request_context
struct SEC_CERTIFICATE_REQUEST_CONTEXT
{
    ubyte    cbCertificateRequestContext;
    ubyte[1] rgCertificateRequestContext; // Flexible array
}

struct SEC_APP_SESSION_STATE
{
    ushort   AppSessionStateSize;
    ubyte[1] AppSessionState; // Flexible array
}

struct SEC_SESSION_TICKET
{
    ushort   SessionTicketSize;
    ubyte[1] SessionTicket; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_traffic_secrets
struct SEC_TRAFFIC_SECRETS
{
    wchar[64] SymmetricAlgId;
    wchar[64] ChainingMode;
    wchar[64] HashAlgId;
    ushort    KeySize;
    ushort    IvSize;
    ushort    MsgSequenceStart;
    ushort    MsgSequenceEnd;
    SEC_TRAFFIC_SECRET_TYPE TrafficSecretType;
    ushort    TrafficSecretSize;
    ubyte[1]  TrafficSecret; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_namesw
struct SecPkgCredentials_NamesW
{
    ushort* sUserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_namesa
struct SecPkgCredentials_NamesA
{
    byte* sUserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_ssiproviderw
struct SecPkgCredentials_SSIProviderW
{
    ushort* sProviderName;
    uint    ProviderInfoLength;
    PSTR    ProviderInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_ssiprovidera
struct SecPkgCredentials_SSIProviderA
{
    byte* sProviderName;
    uint  ProviderInfoLength;
    PSTR  ProviderInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_kdcproxysettingsw
struct SecPkgCredentials_KdcProxySettingsW
{
    uint   Version;
    uint   Flags;
    ushort ProxyServerOffset;
    ushort ProxyServerLength;
    ushort ClientTlsCredOffset;
    ushort ClientTlsCredLength;
}

struct SecPkgCredentials_KdcNetworkSettingsW
{
    uint   Version;
    uint   Flags;
    ushort ProxyServerOffset;
    ushort ProxyServerLength;
    ushort ClientTlsCredOffset;
    ushort ClientTlsCredLength;
    uint   DcDiscoveryFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcredentials_cert
struct SecPkgCredentials_Cert
{
    uint   EncodedCertSize;
    ubyte* EncodedCert;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_subjectattributes
struct SecPkgContext_SubjectAttributes
{
    void* AttributeInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_credinfo
struct SecPkgContext_CredInfo
{
    SECPKG_CRED_CLASS CredClass;
    uint              IsPromptingNeeded;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negopackageinfo
struct SecPkgContext_NegoPackageInfo
{
    uint PackageMask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negostatus
struct SecPkgContext_NegoStatus
{
    uint LastStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_sizes
struct SecPkgContext_Sizes
{
    uint cbMaxToken;
    uint cbMaxSignature;
    uint cbBlockSize;
    uint cbSecurityTrailer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_streamsizes
struct SecPkgContext_StreamSizes
{
    uint cbHeader;
    uint cbTrailer;
    uint cbMaximumMessage;
    uint cBuffers;
    uint cbBlockSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_namesw
struct SecPkgContext_NamesW
{
    ushort* sUserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_lastclienttokenstatus
struct SecPkgContext_LastClientTokenStatus
{
    SECPKG_ATTR_LCT_STATUS LastClientTokenStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_namesa
struct SecPkgContext_NamesA
{
    byte* sUserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_lifespan
struct SecPkgContext_Lifespan
{
    long tsStart;
    long tsExpiry;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_dceinfo
struct SecPkgContext_DceInfo
{
    uint  AuthzSvc;
    void* pPac;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_keyinfoa
struct SecPkgContext_KeyInfoA
{
    byte* sSignatureAlgorithmName;
    byte* sEncryptAlgorithmName;
    uint  KeySize;
    uint  SignatureAlgorithm;
    uint  EncryptAlgorithm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_keyinfow
struct SecPkgContext_KeyInfoW
{
    ushort* sSignatureAlgorithmName;
    ushort* sEncryptAlgorithmName;
    uint    KeySize;
    uint    SignatureAlgorithm;
    uint    EncryptAlgorithm;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_authoritya
struct SecPkgContext_AuthorityA
{
    byte* sAuthorityName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_authorityw
struct SecPkgContext_AuthorityW
{
    ushort* sAuthorityName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_protoinfoa
struct SecPkgContext_ProtoInfoA
{
    byte* sProtocolName;
    uint  majorVersion;
    uint  minorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_protoinfow
struct SecPkgContext_ProtoInfoW
{
    ushort* sProtocolName;
    uint    majorVersion;
    uint    minorVersion;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_passwordexpiry
struct SecPkgContext_PasswordExpiry
{
    long tsPasswordExpires;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_logofftime
struct SecPkgContext_LogoffTime
{
    long tsLogoffTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_sessionkey
struct SecPkgContext_SessionKey
{
    uint   SessionKeyLength;
    ubyte* SessionKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negokeys
struct SecPkgContext_NegoKeys
{
    uint   KeyType;
    ushort KeyLength;
    ubyte* KeyValue;
    uint   VerifyKeyType;
    ushort VerifyKeyLength;
    ubyte* VerifyKeyValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_packageinfow
struct SecPkgContext_PackageInfoW
{
    SecPkgInfoW* PackageInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_packageinfoa
struct SecPkgContext_PackageInfoA
{
    SecPkgInfoA* PackageInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_userflags
struct SecPkgContext_UserFlags
{
    uint UserFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_flags
struct SecPkgContext_Flags
{
    uint Flags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negotiationinfoa
struct SecPkgContext_NegotiationInfoA
{
    SecPkgInfoA* PackageInfo;
    uint         NegotiationState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negotiationinfow
struct SecPkgContext_NegotiationInfoW
{
    SecPkgInfoW* PackageInfo;
    uint         NegotiationState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_nativenamesw
struct SecPkgContext_NativeNamesW
{
    ushort* sClientName;
    ushort* sServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-_secpkgcontext_nativenamesa
struct SecPkgContext_NativeNamesA
{
    byte* sClientName;
    byte* sServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_credentialnamew
struct SecPkgContext_CredentialNameW
{
    uint    CredentialType;
    ushort* sCredentialName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-_secpkgcontext_credentialnamea
struct SecPkgContext_CredentialNameA
{
    uint  CredentialType;
    byte* sCredentialName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_accesstoken
struct SecPkgContext_AccessToken
{
    void* AccessToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_targetinformation
struct SecPkgContext_TargetInformation
{
    uint   MarshalledTargetInfoLength;
    ubyte* MarshalledTargetInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_authzid
struct SecPkgContext_AuthzID
{
    uint AuthzIDLength;
    PSTR AuthzID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_target
struct SecPkgContext_Target
{
    uint TargetLength;
    PSTR Target;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_clientspecifiedtarget
struct SecPkgContext_ClientSpecifiedTarget
{
    ushort* sTargetName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_bindings
struct SecPkgContext_Bindings
{
    uint BindingsLength;
    SEC_CHANNEL_BINDINGS* Bindings;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_applicationprotocol
struct SecPkgContext_ApplicationProtocol
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS ProtoNegoStatus;
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ubyte      ProtocolIdSize;
    ubyte[255] ProtocolId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-secpkgcontext_negotiatedtlsextensions
struct SecPkgContext_NegotiatedTlsExtensions
{
    uint    ExtensionsCount;
    ushort* Extensions;
}

struct SECPKG_APP_MODE_INFO
{
    uint      UserFunction;
    size_t    Argument1;
    size_t    Argument2;
    SecBuffer UserData;
    BOOLEAN   ReturnToLsa;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-securityfunctiontablew
struct SecurityFunctionTableW
{
    uint                 dwVersion;
    ENUMERATE_SECURITY_PACKAGES_FN_W EnumerateSecurityPackagesW;
    QUERY_CREDENTIALS_ATTRIBUTES_FN_W QueryCredentialsAttributesW;
    ACQUIRE_CREDENTIALS_HANDLE_FN_W AcquireCredentialsHandleW;
    FREE_CREDENTIALS_HANDLE_FN FreeCredentialsHandle;
    void*                Reserved2;
    INITIALIZE_SECURITY_CONTEXT_FN_W InitializeSecurityContextW;
    ACCEPT_SECURITY_CONTEXT_FN AcceptSecurityContext;
    COMPLETE_AUTH_TOKEN_FN CompleteAuthToken;
    DELETE_SECURITY_CONTEXT_FN DeleteSecurityContext;
    APPLY_CONTROL_TOKEN_FN ApplyControlToken;
    QUERY_CONTEXT_ATTRIBUTES_FN_W QueryContextAttributesW;
    IMPERSONATE_SECURITY_CONTEXT_FN ImpersonateSecurityContext;
    REVERT_SECURITY_CONTEXT_FN RevertSecurityContext;
    MAKE_SIGNATURE_FN    MakeSignature;
    VERIFY_SIGNATURE_FN  VerifySignature;
    FREE_CONTEXT_BUFFER_FN FreeContextBuffer;
    QUERY_SECURITY_PACKAGE_INFO_FN_W QuerySecurityPackageInfoW;
    void*                Reserved3;
    void*                Reserved4;
    EXPORT_SECURITY_CONTEXT_FN ExportSecurityContext;
    IMPORT_SECURITY_CONTEXT_FN_W ImportSecurityContextW;
    ADD_CREDENTIALS_FN_W AddCredentialsW;
    void*                Reserved8;
    QUERY_SECURITY_CONTEXT_TOKEN_FN QuerySecurityContextToken;
    ENCRYPT_MESSAGE_FN   EncryptMessage;
    DECRYPT_MESSAGE_FN   DecryptMessage;
    SET_CONTEXT_ATTRIBUTES_FN_W SetContextAttributesW;
    SET_CREDENTIALS_ATTRIBUTES_FN_W SetCredentialsAttributesW;
    CHANGE_PASSWORD_FN_W ChangeAccountPasswordW;
    QUERY_CONTEXT_ATTRIBUTES_EX_FN_W QueryContextAttributesExW;
    QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W QueryCredentialsAttributesExW;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-securityfunctiontablea
struct SecurityFunctionTableA
{
    uint                 dwVersion;
    ENUMERATE_SECURITY_PACKAGES_FN_A EnumerateSecurityPackagesA;
    QUERY_CREDENTIALS_ATTRIBUTES_FN_A QueryCredentialsAttributesA;
    ACQUIRE_CREDENTIALS_HANDLE_FN_A AcquireCredentialsHandleA;
    FREE_CREDENTIALS_HANDLE_FN FreeCredentialsHandle;
    void*                Reserved2;
    INITIALIZE_SECURITY_CONTEXT_FN_A InitializeSecurityContextA;
    ACCEPT_SECURITY_CONTEXT_FN AcceptSecurityContext;
    COMPLETE_AUTH_TOKEN_FN CompleteAuthToken;
    DELETE_SECURITY_CONTEXT_FN DeleteSecurityContext;
    APPLY_CONTROL_TOKEN_FN ApplyControlToken;
    QUERY_CONTEXT_ATTRIBUTES_FN_A QueryContextAttributesA;
    IMPERSONATE_SECURITY_CONTEXT_FN ImpersonateSecurityContext;
    REVERT_SECURITY_CONTEXT_FN RevertSecurityContext;
    MAKE_SIGNATURE_FN    MakeSignature;
    VERIFY_SIGNATURE_FN  VerifySignature;
    FREE_CONTEXT_BUFFER_FN FreeContextBuffer;
    QUERY_SECURITY_PACKAGE_INFO_FN_A QuerySecurityPackageInfoA;
    void*                Reserved3;
    void*                Reserved4;
    EXPORT_SECURITY_CONTEXT_FN ExportSecurityContext;
    IMPORT_SECURITY_CONTEXT_FN_A ImportSecurityContextA;
    ADD_CREDENTIALS_FN_A AddCredentialsA;
    void*                Reserved8;
    QUERY_SECURITY_CONTEXT_TOKEN_FN QuerySecurityContextToken;
    ENCRYPT_MESSAGE_FN   EncryptMessage;
    DECRYPT_MESSAGE_FN   DecryptMessage;
    SET_CONTEXT_ATTRIBUTES_FN_A SetContextAttributesA;
    SET_CREDENTIALS_ATTRIBUTES_FN_A SetCredentialsAttributesA;
    CHANGE_PASSWORD_FN_A ChangeAccountPasswordA;
    QUERY_CONTEXT_ATTRIBUTES_EX_FN_A QueryContextAttributesExA;
    QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A QueryCredentialsAttributesExA;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_winnt_auth_identity_ex2
struct SEC_WINNT_AUTH_IDENTITY_EX2
{
    uint   Version;
    ushort cbHeaderLength;
    uint   cbStructureLength;
    uint   UserOffset;
    ushort UserLength;
    uint   DomainOffset;
    ushort DomainLength;
    uint   PackedCredentialsOffset;
    ushort PackedCredentialsLength;
    uint   Flags;
    uint   PackageListOffset;
    ushort PackageListLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_winnt_auth_identity_exw
struct SEC_WINNT_AUTH_IDENTITY_EXW
{
    uint    Version;
    uint    Length;
    ushort* User;
    uint    UserLength;
    ushort* Domain;
    uint    DomainLength;
    ushort* Password;
    uint    PasswordLength;
    uint    Flags;
    ushort* PackageList;
    uint    PackageListLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_winnt_auth_identity_exa
struct SEC_WINNT_AUTH_IDENTITY_EXA
{
    uint   Version;
    uint   Length;
    ubyte* User;
    uint   UserLength;
    ubyte* Domain;
    uint   DomainLength;
    ubyte* Password;
    uint   PasswordLength;
    uint   Flags;
    ubyte* PackageList;
    uint   PackageListLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-sec_winnt_auth_identity_info
union SEC_WINNT_AUTH_IDENTITY_INFO
{
    SEC_WINNT_AUTH_IDENTITY_EXW AuthIdExw;
    SEC_WINNT_AUTH_IDENTITY_EXA AuthIdExa;
    SEC_WINNT_AUTH_IDENTITY_A AuthId_a;
    SEC_WINNT_AUTH_IDENTITY_W AuthId_w;
    SEC_WINNT_AUTH_IDENTITY_EX2 AuthIdEx2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/sspi/ns-sspi-security_package_options
struct SECURITY_PACKAGE_OPTIONS
{
    uint  Size;
    SECURITY_PACKAGE_OPTIONS_TYPE Type;
    uint  Flags;
    uint  SignatureSize;
    void* Signature;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-lsa_token_information_null
struct LSA_TOKEN_INFORMATION_NULL
{
    long          ExpirationTime;
    TOKEN_GROUPS* Groups;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-lsa_token_information_v1
struct LSA_TOKEN_INFORMATION_V1
{
    long                ExpirationTime;
    TOKEN_USER          User;
    TOKEN_GROUPS*       Groups;
    TOKEN_PRIMARY_GROUP PrimaryGroup;
    TOKEN_PRIVILEGES*   Privileges;
    TOKEN_OWNER         Owner;
    TOKEN_DEFAULT_DACL  DefaultDacl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-lsa_token_information_v3
struct LSA_TOKEN_INFORMATION_V3
{
    long                ExpirationTime;
    TOKEN_USER          User;
    TOKEN_GROUPS*       Groups;
    TOKEN_PRIMARY_GROUP PrimaryGroup;
    TOKEN_PRIVILEGES*   Privileges;
    TOKEN_OWNER         Owner;
    TOKEN_DEFAULT_DACL  DefaultDacl;
    TOKEN_USER_CLAIMS   UserClaims;
    TOKEN_DEVICE_CLAIMS DeviceClaims;
    TOKEN_GROUPS*       DeviceGroups;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-lsa_dispatch_table
struct LSA_DISPATCH_TABLE
{
    PLSA_CREATE_LOGON_SESSION CreateLogonSession;
    PLSA_DELETE_LOGON_SESSION DeleteLogonSession;
    PLSA_ADD_CREDENTIAL  AddCredential;
    PLSA_GET_CREDENTIALS GetCredentials;
    PLSA_DELETE_CREDENTIAL DeleteCredential;
    PLSA_ALLOCATE_LSA_HEAP AllocateLsaHeap;
    PLSA_FREE_LSA_HEAP   FreeLsaHeap;
    PLSA_ALLOCATE_CLIENT_BUFFER AllocateClientBuffer;
    PLSA_FREE_CLIENT_BUFFER FreeClientBuffer;
    PLSA_COPY_TO_CLIENT_BUFFER CopyToClientBuffer;
    PLSA_COPY_FROM_CLIENT_BUFFER CopyFromClientBuffer;
}

struct SAM_REGISTER_MAPPING_ELEMENT
{
    PSTR    Original;
    PSTR    Mapped;
    BOOLEAN Continuable;
}

struct SAM_REGISTER_MAPPING_LIST
{
    uint Count;
    SAM_REGISTER_MAPPING_ELEMENT* Elements;
}

struct SAM_REGISTER_MAPPING_TABLE
{
    uint Count;
    SAM_REGISTER_MAPPING_LIST* Lists;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_client_info
struct SECPKG_CLIENT_INFO
{
    LUID    LogonId;
    uint    ProcessID;
    uint    ThreadID;
    BOOLEAN HasTcbPrivilege;
    BOOLEAN Impersonating;
    BOOLEAN Restricted;
    ubyte   ClientFlags;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    HANDLE  ClientToken;
}

struct SECPKG_CLIENT_INFO_EX
{
    LUID    LogonId;
    uint    ProcessID;
    uint    ThreadID;
    BOOLEAN HasTcbPrivilege;
    BOOLEAN Impersonating;
    BOOLEAN Restricted;
    ubyte   ClientFlags;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    HANDLE  ClientToken;
    LUID    IdentificationLogonId;
    HANDLE  IdentificationToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_call_info
struct SECPKG_CALL_INFO
{
    uint  ProcessId;
    uint  ThreadId;
    uint  Attributes;
    uint  CallCount;
    void* MechOid;
}

struct SECPKG_FAILURE_REASON
{
    NTSTATUS Status;
    SECPKG_FAILURE_SPECIAL_REASON Reason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_supplemental_cred
struct SECPKG_SUPPLEMENTAL_CRED
{
    LSA_UNICODE_STRING PackageName;
    uint               CredentialSize;
    ubyte*             Credentials;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_byte_vector
struct SECPKG_BYTE_VECTOR
{
    uint   ByteArrayOffset;
    ushort ByteArrayLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_short_vector
struct SECPKG_SHORT_VECTOR
{
    uint   ShortArrayOffset;
    ushort ShortArrayCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_supplied_credential
struct SECPKG_SUPPLIED_CREDENTIAL
{
    ushort              cbHeaderLength;
    ushort              cbStructureLength;
    SECPKG_SHORT_VECTOR UserName;
    SECPKG_SHORT_VECTOR DomainName;
    SECPKG_BYTE_VECTOR  PackedCredentials;
    uint                CredFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_credential
struct SECPKG_CREDENTIAL
{
    ulong              Version;
    ushort             cbHeaderLength;
    uint               cbStructureLength;
    uint               ClientProcess;
    uint               ClientThread;
    LUID               LogonId;
    HANDLE             ClientToken;
    uint               SessionId;
    LUID               ModifiedId;
    uint               fCredentials;
    uint               Flags;
    SECPKG_BYTE_VECTOR PrincipalName;
    SECPKG_BYTE_VECTOR PackageList;
    SECPKG_BYTE_VECTOR MarshaledSuppliedCreds;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_supplemental_cred_array
struct SECPKG_SUPPLEMENTAL_CRED_ARRAY
{
    uint CredentialCount;
    SECPKG_SUPPLEMENTAL_CRED[1] Credentials; // Flexible array
}

struct SECPKG_SURROGATE_LOGON_ENTRY
{
    GUID  Type;
    void* Data;
}

struct SECPKG_SURROGATE_LOGON
{
    uint Version;
    LUID SurrogateLogonID;
    uint EntryCount;
    SECPKG_SURROGATE_LOGON_ENTRY* Entries;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_primary_cred
struct SECPKG_PRIMARY_CRED
{
    LUID               LogonId;
    LSA_UNICODE_STRING DownlevelName;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING Password;
    LSA_UNICODE_STRING OldPassword;
    PSID               UserSid;
    uint               Flags;
    LSA_UNICODE_STRING DnsDomainName;
    LSA_UNICODE_STRING Upn;
    LSA_UNICODE_STRING LogonServer;
    LSA_UNICODE_STRING Spare1;
    LSA_UNICODE_STRING Spare2;
    LSA_UNICODE_STRING Spare3;
    LSA_UNICODE_STRING Spare4;
}

struct SECPKG_PRIMARY_CRED_EX
{
    LUID               LogonId;
    LSA_UNICODE_STRING DownlevelName;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING Password;
    LSA_UNICODE_STRING OldPassword;
    PSID               UserSid;
    uint               Flags;
    LSA_UNICODE_STRING DnsDomainName;
    LSA_UNICODE_STRING Upn;
    LSA_UNICODE_STRING LogonServer;
    LSA_UNICODE_STRING Spare1;
    LSA_UNICODE_STRING Spare2;
    LSA_UNICODE_STRING Spare3;
    LSA_UNICODE_STRING Spare4;
    size_t             PackageId;
    LUID               PrevLogonId;
    uint               FlagsEx;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_parameters
struct SECPKG_PARAMETERS
{
    uint               Version;
    uint               MachineState;
    uint               SetupMode;
    PSID               DomainSid;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING DnsDomainName;
    GUID               DomainGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_gss_info
struct SECPKG_GSS_INFO
{
    uint     EncodedIdLength;
    ubyte[4] EncodedId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_context_thunks
struct SECPKG_CONTEXT_THUNKS
{
    uint    InfoLevelCount;
    uint[1] Levels; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_mutual_auth_level
struct SECPKG_MUTUAL_AUTH_LEVEL
{
    uint MutualAuthLevel;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_wow_client_dll
struct SECPKG_WOW_CLIENT_DLL
{
    SECURITY_STRING WowClientDllPath;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_serialized_oid
struct SECPKG_SERIALIZED_OID
{
    uint      OidLength;
    uint      OidAttributes;
    ubyte[32] OidValue;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_extra_oids
struct SECPKG_EXTRA_OIDS
{
    uint OidCount;
    SECPKG_SERIALIZED_OID[1] Oids; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_nego2_info
struct SECPKG_NEGO2_INFO
{
    ubyte[16] AuthScheme;
    uint      PackageFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_extended_information
struct SECPKG_EXTENDED_INFORMATION
{
    SECPKG_EXTENDED_INFORMATION_CLASS Class;
    union Info
    {
        SECPKG_GSS_INFO   GssInfo;
        SECPKG_CONTEXT_THUNKS ContextThunks;
        SECPKG_MUTUAL_AUTH_LEVEL MutualAuthLevel;
        SECPKG_WOW_CLIENT_DLL WowClientDll;
        SECPKG_EXTRA_OIDS ExtraOids;
        SECPKG_NEGO2_INFO Nego2Info;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_targetinfo
struct SECPKG_TARGETINFO
{
    PSID         DomainSid;
    const(PWSTR) ComputerName;
}

struct SECPKG_NTLM_TARGETINFO
{
    uint     Flags;
    PWSTR    MsvAvNbComputerName;
    PWSTR    MsvAvNbDomainName;
    PWSTR    MsvAvDnsComputerName;
    PWSTR    MsvAvDnsDomainName;
    PWSTR    MsvAvDnsTreeName;
    uint     MsvAvFlags;
    FILETIME MsvAvTimestamp;
    PWSTR    MsvAvTargetName;
}

struct SecPkgContext_SaslContext
{
    void* SaslContext;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-security_user_data
struct SECURITY_USER_DATA
{
    SECURITY_STRING UserName;
    SECURITY_STRING LogonDomainName;
    SECURITY_STRING LogonServer;
    PSID            pSid;
}

struct SECPKG_CALL_PACKAGE_PIN_DC_REQUEST
{
    uint               MessageType;
    uint               Flags;
    LSA_UNICODE_STRING DomainName;
    LSA_UNICODE_STRING DcName;
    uint               DcFlags;
}

struct SECPKG_CALL_PACKAGE_UNPIN_ALL_DCS_REQUEST
{
    uint MessageType;
    uint Flags;
}

struct SECPKG_CALL_PACKAGE_TRANSFER_CRED_REQUEST
{
    uint MessageType;
    LUID OriginLogonId;
    LUID DestinationLogonId;
    uint Flags;
}

struct SECPKG_REDIRECTED_LOGON_BUFFER
{
    GUID   RedirectedLogonGuid;
    HANDLE RedirectedLogonHandle;
    PLSA_REDIRECTED_LOGON_INIT Init;
    PLSA_REDIRECTED_LOGON_CALLBACK Callback;
    PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK CleanupCallback;
    PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS GetLogonCreds;
    PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS GetSupplementalCreds;
    PLSA_REDIRECTED_LOGON_GET_SID GetRedirectedLogonSid;
}

struct SECPKG_POST_LOGON_USER_INFO
{
    uint Flags;
    LUID LogonId;
    LUID LinkedLogonId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_event_package_change
struct SECPKG_EVENT_PACKAGE_CHANGE
{
    SECPKG_PACKAGE_CHANGE_TYPE ChangeType;
    size_t          PackageId;
    SECURITY_STRING PackageName;
}

struct SECPKG_EVENT_ROLE_CHANGE
{
    uint PreviousRole;
    uint NewRole;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_event_notify
struct SECPKG_EVENT_NOTIFY
{
    uint  EventClass;
    uint  Reserved;
    uint  EventDataSize;
    void* EventData;
    void* PackageParameter;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-encrypted_credentialw
struct ENCRYPTED_CREDENTIALW
{
    CREDENTIALW Cred;
    uint        ClearCredentialBlobSize;
}

struct SEC_WINNT_AUTH_IDENTITY32
{
    uint User;
    uint UserLength;
    uint Domain;
    uint DomainLength;
    uint Password;
    uint PasswordLength;
    uint Flags;
}

struct SEC_WINNT_AUTH_IDENTITY_EX32
{
    uint Version;
    uint Length;
    uint User;
    uint UserLength;
    uint Domain;
    uint DomainLength;
    uint Password;
    uint PasswordLength;
    uint Flags;
    uint PackageList;
    uint PackageListLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-lsa_secpkg_function_table
struct LSA_SECPKG_FUNCTION_TABLE
{
    PLSA_CREATE_LOGON_SESSION CreateLogonSession;
    PLSA_DELETE_LOGON_SESSION DeleteLogonSession;
    PLSA_ADD_CREDENTIAL  AddCredential;
    PLSA_GET_CREDENTIALS GetCredentials;
    PLSA_DELETE_CREDENTIAL DeleteCredential;
    PLSA_ALLOCATE_LSA_HEAP AllocateLsaHeap;
    PLSA_FREE_LSA_HEAP   FreeLsaHeap;
    PLSA_ALLOCATE_CLIENT_BUFFER AllocateClientBuffer;
    PLSA_FREE_CLIENT_BUFFER FreeClientBuffer;
    PLSA_COPY_TO_CLIENT_BUFFER CopyToClientBuffer;
    PLSA_COPY_FROM_CLIENT_BUFFER CopyFromClientBuffer;
    PLSA_IMPERSONATE_CLIENT ImpersonateClient;
    PLSA_UNLOAD_PACKAGE  UnloadPackage;
    PLSA_DUPLICATE_HANDLE DuplicateHandle;
    PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS SaveSupplementalCredentials;
    PLSA_CREATE_THREAD   CreateThread;
    PLSA_GET_CLIENT_INFO GetClientInfo;
    PLSA_REGISTER_NOTIFICATION RegisterNotification;
    PLSA_CANCEL_NOTIFICATION CancelNotification;
    PLSA_MAP_BUFFER      MapBuffer;
    PLSA_CREATE_TOKEN    CreateToken;
    PLSA_AUDIT_LOGON     AuditLogon;
    PLSA_CALL_PACKAGE    CallPackage;
    PLSA_FREE_LSA_HEAP   FreeReturnBuffer;
    PLSA_GET_CALL_INFO   GetCallInfo;
    PLSA_CALL_PACKAGEEX  CallPackageEx;
    PLSA_CREATE_SHARED_MEMORY CreateSharedMemory;
    PLSA_ALLOCATE_SHARED_MEMORY AllocateSharedMemory;
    PLSA_FREE_SHARED_MEMORY FreeSharedMemory;
    PLSA_DELETE_SHARED_MEMORY DeleteSharedMemory;
    PLSA_OPEN_SAM_USER   OpenSamUser;
    PLSA_GET_USER_CREDENTIALS GetUserCredentials;
    PLSA_GET_USER_AUTH_DATA GetUserAuthData;
    PLSA_CLOSE_SAM_USER  CloseSamUser;
    PLSA_CONVERT_AUTH_DATA_TO_TOKEN ConvertAuthDataToToken;
    PLSA_CLIENT_CALLBACK ClientCallback;
    PLSA_UPDATE_PRIMARY_CREDENTIALS UpdateCredentials;
    PLSA_GET_AUTH_DATA_FOR_USER GetAuthDataForUser;
    PLSA_CRACK_SINGLE_NAME CrackSingleName;
    PLSA_AUDIT_ACCOUNT_LOGON AuditAccountLogon;
    PLSA_CALL_PACKAGE_PASSTHROUGH CallPackagePassthrough;
    CredReadFn           CrediRead;
    CredReadDomainCredentialsFn CrediReadDomainCredentials;
    CredFreeCredentialsFn CrediFreeCredentials;
    PLSA_PROTECT_MEMORY  LsaProtectMemory;
    PLSA_PROTECT_MEMORY  LsaUnprotectMemory;
    PLSA_OPEN_TOKEN_BY_LOGON_ID OpenTokenByLogonId;
    PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN ExpandAuthDataForDomain;
    PLSA_ALLOCATE_PRIVATE_HEAP AllocatePrivateHeap;
    PLSA_FREE_PRIVATE_HEAP FreePrivateHeap;
    PLSA_CREATE_TOKEN_EX CreateTokenEx;
    CredWriteFn          CrediWrite;
    CrediUnmarshalandDecodeStringFn CrediUnmarshalandDecodeString;
    PLSA_PROTECT_MEMORY  DummyFunction6;
    PLSA_GET_EXTENDED_CALL_FLAGS GetExtendedCallFlags;
    PLSA_DUPLICATE_HANDLE DuplicateTokenHandle;
    PLSA_GET_SERVICE_ACCOUNT_PASSWORD GetServiceAccountPassword;
    PLSA_PROTECT_MEMORY  DummyFunction7;
    PLSA_AUDIT_LOGON_EX  AuditLogonEx;
    PLSA_CHECK_PROTECTED_USER_BY_TOKEN CheckProtectedUserByToken;
    PLSA_QUERY_CLIENT_REQUEST QueryClientRequest;
    PLSA_GET_APP_MODE_INFO GetAppModeInfo;
    PLSA_SET_APP_MODE_INFO SetAppModeInfo;
    PLSA_GET_CLIENT_INFO_EX GetClientInfoEx;
    PLSA_GET_SECPKG_FAILURE_REASON GetSecpkgFailureReason;
    PLSA_SET_SECPKG_FAILURE_REASON SetSecpkgFailureReason;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_dll_functions
struct SECPKG_DLL_FUNCTIONS
{
    PLSA_ALLOCATE_LSA_HEAP AllocateHeap;
    PLSA_FREE_LSA_HEAP FreeHeap;
    PLSA_REGISTER_CALLBACK RegisterCallback;
    PLSA_LOCATE_PKG_BY_ID LocatePackageById;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_function_table
struct SECPKG_FUNCTION_TABLE
{
    PLSA_AP_INITIALIZE_PACKAGE InitializePackage;
    PLSA_AP_LOGON_USER   LogonUserA;
    PLSA_AP_CALL_PACKAGE CallPackage;
    PLSA_AP_LOGON_TERMINATED LogonTerminated;
    PLSA_AP_CALL_PACKAGE CallPackageUntrusted;
    PLSA_AP_CALL_PACKAGE_PASSTHROUGH CallPackagePassthrough;
    PLSA_AP_LOGON_USER_EX LogonUserExA;
    PLSA_AP_LOGON_USER_EX2 LogonUserEx2;
    SpInitializeFn       Initialize;
    SpShutdownFn         Shutdown;
    SpGetInfoFn          GetInfo;
    SpAcceptCredentialsFn AcceptCredentials;
    SpAcquireCredentialsHandleFn AcquireCredentialsHandleA;
    SpQueryCredentialsAttributesFn QueryCredentialsAttributesA;
    SpFreeCredentialsHandleFn FreeCredentialsHandle;
    SpSaveCredentialsFn  SaveCredentials;
    SpGetCredentialsFn   GetCredentials;
    SpDeleteCredentialsFn DeleteCredentials;
    SpInitLsaModeContextFn InitLsaModeContext;
    SpAcceptLsaModeContextFn AcceptLsaModeContext;
    SpDeleteContextFn    DeleteContext;
    SpApplyControlTokenFn ApplyControlToken;
    SpGetUserInfoFn      GetUserInfo;
    SpGetExtendedInformationFn GetExtendedInformation;
    SpQueryContextAttributesFn QueryContextAttributesA;
    SpAddCredentialsFn   AddCredentialsA;
    SpSetExtendedInformationFn SetExtendedInformation;
    SpSetContextAttributesFn SetContextAttributesA;
    SpSetCredentialsAttributesFn SetCredentialsAttributesA;
    SpChangeAccountPasswordFn ChangeAccountPasswordA;
    SpQueryMetaDataFn    QueryMetaData;
    SpExchangeMetaDataFn ExchangeMetaData;
    SpGetCredUIContextFn GetCredUIContext;
    SpUpdateCredentialsFn UpdateCredentials;
    SpValidateTargetInfoFn ValidateTargetInfo;
    LSA_AP_POST_LOGON_USER PostLogonUser;
    SpGetRemoteCredGuardLogonBufferFn GetRemoteCredGuardLogonBuffer;
    SpGetRemoteCredGuardSupplementalCredsFn GetRemoteCredGuardSupplementalCreds;
    SpGetTbalSupplementalCredsFn GetTbalSupplementalCreds;
    PLSA_AP_LOGON_USER_EX3 LogonUserEx3;
    PLSA_AP_PRE_LOGON_USER_SURROGATE PreLogonUserSurrogate;
    PLSA_AP_POST_LOGON_USER_SURROGATE PostLogonUserSurrogate;
    SpExtractTargetInfoFn ExtractTargetInfo;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecpkg/ns-ntsecpkg-secpkg_user_function_table
struct SECPKG_USER_FUNCTION_TABLE
{
    SpInstanceInitFn    InstanceInit;
    SpInitUserModeContextFn InitUserModeContext;
    SpMakeSignatureFn   MakeSignature;
    SpVerifySignatureFn VerifySignature;
    SpSealMessageFn     SealMessage;
    SpUnsealMessageFn   UnsealMessage;
    SpGetContextTokenFn GetContextToken;
    SpQueryContextAttributesFn QueryContextAttributesA;
    SpCompleteAuthTokenFn CompleteAuthToken;
    SpDeleteContextFn   DeleteUserModeContext;
    SpFormatCredentialsFn FormatCredentials;
    SpMarshallSupplementalCredsFn MarshallSupplementalCreds;
    SpExportSecurityContextFn ExportContext;
    SpImportSecurityContextFn ImportContext;
    SpMarshalAttributeDataFn MarshalAttributeData;
}

struct KSEC_LIST_ENTRY
{
    LIST_ENTRY List;
    int        RefCount;
    uint       Signature;
    void*      OwningList;
    void*      Reserved;
}

struct SECPKG_KERNEL_FUNCTIONS
{
    PLSA_ALLOCATE_LSA_HEAP AllocateHeap;
    PLSA_FREE_LSA_HEAP FreeHeap;
    PKSEC_CREATE_CONTEXT_LIST CreateContextList;
    PKSEC_INSERT_LIST_ENTRY InsertListEntry;
    PKSEC_REFERENCE_LIST_ENTRY ReferenceListEntry;
    PKSEC_DEREFERENCE_LIST_ENTRY DereferenceListEntry;
    PKSEC_SERIALIZE_WINNT_AUTH_DATA SerializeWinntAuthData;
    PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA SerializeSchannelAuthData;
    PKSEC_LOCATE_PKG_BY_ID LocatePackageById;
}

struct SECPKG_KERNEL_FUNCTION_TABLE
{
    KspInitPackageFn     Initialize;
    KspDeleteContextFn   DeleteContext;
    KspInitContextFn     InitContext;
    KspMapHandleFn       MapHandle;
    KspMakeSignatureFn   Sign;
    KspVerifySignatureFn Verify;
    KspSealMessageFn     Seal;
    KspUnsealMessageFn   Unseal;
    KspGetTokenFn        GetToken;
    KspQueryAttributesFn QueryAttributes;
    KspCompleteTokenFn   CompleteToken;
    SpExportSecurityContextFn ExportContext;
    SpImportSecurityContextFn ImportContext;
    KspSetPagingModeFn   SetPackagePagingMode;
    KspSerializeAuthDataFn SerializeAuthData;
}

struct SecPkgCred_SupportedAlgs
{
    uint    cSupportedAlgs;
    ALG_ID* palgSupportedAlgs;
}

struct SecPkgCred_CipherStrengths
{
    uint dwMinimumCipherStrength;
    uint dwMaximumCipherStrength;
}

struct SecPkgCred_SupportedProtocols
{
    uint grbitProtocol;
}

struct SecPkgCred_ClientCertPolicy
{
    uint  dwFlags;
    GUID  guidPolicyId;
    uint  dwCertFlags;
    uint  dwUrlRetrievalTimeout;
    BOOL  fCheckRevocationFreshnessTime;
    uint  dwRevocationFreshnessTime;
    BOOL  fOmitUsageCheck;
    PWSTR pwszSslCtlStoreName;
    PWSTR pwszSslCtlIdentifier;
}

struct SecPkgCred_SessionTicketKey
{
    uint      TicketInfoVersion;
    ubyte[16] KeyId;
    ubyte[64] KeyingMaterial;
    ubyte     KeyingMaterialSize;
}

struct SecPkgCred_SessionTicketKeys
{
    uint cSessionTicketKeys;
    SecPkgCred_SessionTicketKey* pSessionTicketKeys;
}

struct SecPkgContext_RemoteCredentialInfo
{
    uint   cbCertificateChain;
    ubyte* pbCertificateChain;
    uint   cCertificates;
    uint   fFlags;
    uint   dwBits;
}

struct SecPkgContext_LocalCredentialInfo
{
    uint   cbCertificateChain;
    ubyte* pbCertificateChain;
    uint   cCertificates;
    uint   fFlags;
    uint   dwBits;
}

struct SecPkgContext_ClientCertPolicyResult
{
    HRESULT dwPolicyResult;
    GUID    guidPolicyId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_issuerlistinfoex
struct SecPkgContext_IssuerListInfoEx
{
    CRYPT_INTEGER_BLOB* aIssuers;
    uint                cIssuers;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_connectioninfo
struct SecPkgContext_ConnectionInfo
{
    uint   dwProtocol;
    ALG_ID aiCipher;
    uint   dwCipherStrength;
    ALG_ID aiHash;
    uint   dwHashStrength;
    ALG_ID aiExch;
    uint   dwExchStrength;
}

struct SecPkgContext_ConnectionInfoEx
{
    uint      dwVersion;
    uint      dwProtocol;
    wchar[64] szCipher;
    uint      dwCipherStrength;
    wchar[64] szHash;
    uint      dwHashStrength;
    wchar[64] szExchange;
    uint      dwExchStrength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_cipherinfo
struct SecPkgContext_CipherInfo
{
    uint      dwVersion;
    uint      dwProtocol;
    uint      dwCipherSuite;
    uint      dwBaseCipherSuite;
    wchar[64] szCipherSuite;
    wchar[64] szCipher;
    uint      dwCipherLen;
    uint      dwCipherBlockLen;
    wchar[64] szHash;
    uint      dwHashLen;
    wchar[64] szExchange;
    uint      dwMinExchangeLen;
    uint      dwMaxExchangeLen;
    wchar[64] szCertificate;
    uint      dwKeyType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_eapkeyblock
struct SecPkgContext_EapKeyBlock
{
    ubyte[128] rgbKeys;
    ubyte[64]  rgbIVs;
}

struct SecPkgContext_MappedCredAttr
{
    uint  dwAttribute;
    void* pvBuffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_sessioninfo
struct SecPkgContext_SessionInfo
{
    uint      dwFlags;
    uint      cbSessionId;
    ubyte[32] rgbSessionId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_sessionappdata
struct SecPkgContext_SessionAppData
{
    uint   dwFlags;
    uint   cbAppData;
    ubyte* pbAppData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_eapprfinfo
struct SecPkgContext_EapPrfInfo
{
    uint   dwVersion;
    uint   cbPrfData;
    ubyte* pbPrfData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_supportedsignatures
struct SecPkgContext_SupportedSignatures
{
    ushort  cSignatureAndHashAlgorithms;
    ushort* pSignatureAndHashAlgorithms;
}

struct SecPkgContext_Certificates
{
    uint   cCertificates;
    uint   cbCertificateChain;
    ubyte* pbCertificateChain;
}

struct SecPkgContext_CertInfo
{
    uint  dwVersion;
    uint  cbSubjectName;
    PWSTR pwszSubjectName;
    uint  cbIssuerName;
    PWSTR pwszIssuerName;
    uint  dwKeySize;
}

struct SecPkgContext_UiInfo
{
    HWND hParentWindow;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_earlystart
struct SecPkgContext_EarlyStart
{
    uint dwEarlyStartFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_keyingmaterialinfo
struct SecPkgContext_KeyingMaterialInfo
{
    ushort cbLabel;
    PSTR   pszLabel;
    ushort cbContextValue;
    ubyte* pbContextValue;
    uint   cbKeyingMaterial;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-secpkgcontext_keyingmaterial
struct SecPkgContext_KeyingMaterial
{
    uint   cbKeyingMaterial;
    ubyte* pbKeyingMaterial;
}

struct SecPkgContext_KeyingMaterial_Inproc
{
    ushort cbLabel;
    PSTR   pszLabel;
    ushort cbContextValue;
    ubyte* pbContextValue;
    uint   cbKeyingMaterial;
    ubyte* pbKeyingMaterial;
}

struct SecPkgContext_SrtpParameters
{
    ushort ProtectionProfile;
    ubyte  MasterKeyIdentifierSize;
    ubyte* MasterKeyIdentifier;
}

struct SecPkgContext_TokenBinding
{
    ubyte  MajorVersion;
    ubyte  MinorVersion;
    ushort KeyParametersSize;
    ubyte* KeyParameters;
}

struct SecPkgContext_CertificateValidationResult
{
    uint    dwChainErrorStatus;
    HRESULT hrVerifyChainStatus;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_cred
struct SCHANNEL_CRED
{
    uint                dwVersion;
    uint                cCreds;
    CERT_CONTEXT**      paCred;
    HCERTSTORE          hRootStore;
    uint                cMappers;
    _HMAPPER**          aphMappers;
    uint                cSupportedAlgs;
    ALG_ID*             palgSupportedAlgs;
    uint                grbitEnabledProtocols;
    uint                dwMinimumCipherStrength;
    uint                dwMaximumCipherStrength;
    uint                dwSessionLifespan;
    SCHANNEL_CRED_FLAGS dwFlags;
    uint                dwCredFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-crypto_settings
struct CRYPTO_SETTINGS
{
    eTlsAlgorithmUsage  eAlgorithmUsage;
    LSA_UNICODE_STRING  strCngAlgId;
    uint                cChainingModes;
    LSA_UNICODE_STRING* rgstrChainingModes;
    uint                dwMinBitLength;
    uint                dwMaxBitLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-tls_parameters
struct TLS_PARAMETERS
{
    uint                cAlpnIds;
    LSA_UNICODE_STRING* rgstrAlpnIds;
    uint                grbitDisabledProtocols;
    uint                cDisabledCrypto;
    CRYPTO_SETTINGS*    pDisabledCrypto;
    uint                dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-sch_credentials
struct SCH_CREDENTIALS
{
    uint            dwVersion;
    uint            dwCredFormat;
    uint            cCreds;
    CERT_CONTEXT**  paCred;
    HCERTSTORE      hRootStore;
    uint            cMappers;
    _HMAPPER**      aphMappers;
    uint            dwSessionLifespan;
    uint            dwFlags;
    uint            cTlsParameters;
    TLS_PARAMETERS* pTlsParameters;
}

struct SEND_GENERIC_TLS_EXTENSION
{
    ushort   ExtensionType;
    ushort   HandshakeType;
    uint     Flags;
    ushort   BufferSize;
    ubyte[1] Buffer; // Flexible array
}

struct TLS_EXTENSION_SUBSCRIPTION
{
    ushort ExtensionType;
    ushort HandshakeType;
}

struct SUBSCRIBE_GENERIC_TLS_EXTENSION
{
    uint Flags;
    uint SubscriptionsCount;
    TLS_EXTENSION_SUBSCRIPTION[1] Subscriptions; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_cert_hash
struct SCHANNEL_CERT_HASH
{
    uint      dwLength;
    uint      dwFlags;
    size_t    hProv;
    ubyte[20] ShaHash;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_cert_hash_store
struct SCHANNEL_CERT_HASH_STORE
{
    uint       dwLength;
    uint       dwFlags;
    size_t     hProv;
    ubyte[20]  ShaHash;
    wchar[128] pwszStoreName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_alert_token
struct SCHANNEL_ALERT_TOKEN
{
    uint dwTokenType;
    SCHANNEL_ALERT_TOKEN_ALERT_TYPE dwAlertType;
    uint dwAlertNumber;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_session_token
struct SCHANNEL_SESSION_TOKEN
{
    uint dwTokenType;
    SCHANNEL_SESSION_TOKEN_FLAGS dwFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-schannel_client_signature
struct SCHANNEL_CLIENT_SIGNATURE
{
    uint      cbLength;
    ALG_ID    aiHash;
    uint      cbHash;
    ubyte[36] HashValue;
    ubyte[20] CertThumbprint;
}

struct SSL_CREDENTIAL_CERTIFICATE
{
    uint   cbPrivateKey;
    ubyte* pPrivateKey;
    uint   cbCertificate;
    ubyte* pCertificate;
    PSTR   pszPassword;
}

struct SCH_CRED
{
    uint       dwVersion;
    uint       cCreds;
    void**     paSecret;
    void**     paPublic;
    uint       cMappers;
    _HMAPPER** aphMappers;
}

struct SCH_CRED_SECRET_CAPI
{
    uint   dwType;
    size_t hProv;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-sch_cred_secret_privkey
struct SCH_CRED_SECRET_PRIVKEY
{
    uint   dwType;
    ubyte* pPrivateKey;
    uint   cbPrivateKey;
    PSTR   pszPassword;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-sch_cred_public_certchain
struct SCH_CRED_PUBLIC_CERTCHAIN
{
    uint   dwType;
    uint   cbCertChain;
    ubyte* pCertChain;
}

struct PctPublicKey
{
    uint     Type;
    uint     cbKey;
    ubyte[1] pKey; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/schannel/ns-schannel-x509certificate
struct X509Certificate
{
    uint          Version;
    uint[4]       SerialNumber;
    ALG_ID        SignatureAlgorithm;
    FILETIME      ValidFrom;
    FILETIME      ValidUntil;
    PSTR          pszIssuer;
    PSTR          pszSubject;
    PctPublicKey* pPublicKey;
}

struct SCH_EXTENSION_DATA
{
    ushort        ExtensionType;
    const(ubyte)* pExtData;
    uint          cbExtData;
}

struct LOGON_HOURS
{
    ushort UnitsPerWeek;
    ubyte* LogonHours;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subauth/ns-subauth-sr_security_descriptor
struct SR_SECURITY_DESCRIPTOR
{
    uint   Length;
    ubyte* SecurityDescriptor;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subauth/ns-subauth-user_all_information
struct USER_ALL_INFORMATION
{
align (4):
    long               LastLogon;
    long               LastLogoff;
    long               PasswordLastSet;
    long               AccountExpires;
    long               PasswordCanChange;
    long               PasswordMustChange;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING FullName;
    LSA_UNICODE_STRING HomeDirectory;
    LSA_UNICODE_STRING HomeDirectoryDrive;
    LSA_UNICODE_STRING ScriptPath;
    LSA_UNICODE_STRING ProfilePath;
    LSA_UNICODE_STRING AdminComment;
    LSA_UNICODE_STRING WorkStations;
    LSA_UNICODE_STRING UserComment;
    LSA_UNICODE_STRING Parameters;
    LSA_UNICODE_STRING LmPassword;
    LSA_UNICODE_STRING NtPassword;
    LSA_UNICODE_STRING PrivateData;
    SR_SECURITY_DESCRIPTOR SecurityDescriptor;
    uint               UserId;
    uint               PrimaryGroupId;
    uint               UserAccountControl;
    uint               WhichFields;
    LOGON_HOURS        LogonHours;
    ushort             BadPasswordCount;
    ushort             LogonCount;
    ushort             CountryCode;
    ushort             CodePage;
    BOOLEAN            LmPasswordPresent;
    BOOLEAN            NtPasswordPresent;
    BOOLEAN            PasswordExpired;
    BOOLEAN            PrivateDataSensitive;
}

struct CLEAR_BLOCK
{
    CHAR[8] data;
}

struct USER_SESSION_KEY
{
    CYPHER_BLOCK[2] data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/subauth/ns-subauth-netlogon_logon_identity_info
struct NETLOGON_LOGON_IDENTITY_INFO
{
    LSA_UNICODE_STRING LogonDomainName;
    uint               ParameterControl;
    long               LogonId;
    LSA_UNICODE_STRING UserName;
    LSA_UNICODE_STRING Workstation;
}

struct NETLOGON_INTERACTIVE_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    LM_OWF_PASSWORD LmOwfPassword;
    LM_OWF_PASSWORD NtOwfPassword;
}

struct NETLOGON_SERVICE_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    LM_OWF_PASSWORD LmOwfPassword;
    LM_OWF_PASSWORD NtOwfPassword;
}

struct NETLOGON_NETWORK_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    CLEAR_BLOCK LmChallenge;
    LSA_STRING  NtChallengeResponse;
    LSA_STRING  LmChallengeResponse;
}

struct NETLOGON_GENERIC_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    LSA_UNICODE_STRING PackageName;
    uint               DataLength;
    ubyte*             LogonData;
}

struct NETLOGON_TARGET_INFO
{
    uint               Type;
    LSA_UNICODE_STRING NbComputerName;
    LSA_UNICODE_STRING NbDomainName;
    LSA_UNICODE_STRING DnsComputerName;
    LSA_UNICODE_STRING DnsDomainName;
    LSA_UNICODE_STRING DnsTreeName;
    LSA_UNICODE_STRING TargetName;
}

struct MSV1_0_VALIDATION_INFO
{
    long               LogoffTime;
    long               KickoffTime;
    LSA_UNICODE_STRING LogonServer;
    LSA_UNICODE_STRING LogonDomainName;
    USER_SESSION_KEY   SessionKey;
    BOOLEAN            Authoritative;
    uint               UserFlags;
    uint               WhichFields;
    uint               UserId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ns-tokenbinding-tokenbinding_identifier
struct TOKENBINDING_IDENTIFIER
{
    ubyte keyType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ns-tokenbinding-tokenbinding_result_data
struct TOKENBINDING_RESULT_DATA
{
    TOKENBINDING_TYPE bindingType;
    uint              identifierSize;
    TOKENBINDING_IDENTIFIER* identifierData;
    TOKENBINDING_EXTENSION_FORMAT extensionFormat;
    uint              extensionSize;
    void*             extensionData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ns-tokenbinding-tokenbinding_result_list
struct TOKENBINDING_RESULT_LIST
{
    uint resultCount;
    TOKENBINDING_RESULT_DATA* resultData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tokenbinding/ns-tokenbinding-tokenbinding_key_types
struct TOKENBINDING_KEY_TYPES
{
    uint keyCount;
    TOKENBINDING_KEY_PARAMETERS_TYPE* keyType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ns-slpublic-sl_licensing_status
struct SL_LICENSING_STATUS
{
    GUID              SkuId;
    SLLICENSINGSTATUS eStatus;
    uint              dwGraceTime;
    uint              dwTotalGraceDays;
    HRESULT           hrReason;
    ulong             qwValidityExpiration;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ns-slpublic-sl_activation_info_header
struct SL_ACTIVATION_INFO_HEADER
{
    uint               cbSize;
    SL_ACTIVATION_TYPE type;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ns-slpublic-sl_ad_activation_info
struct SL_AD_ACTIVATION_INFO
{
    SL_ACTIVATION_INFO_HEADER header;
    const(PWSTR) pwszProductKey;
    const(PWSTR) pwszActivationObjectName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/slpublic/ns-slpublic-sl_nongenuine_ui_options
struct SL_NONGENUINE_UI_OPTIONS
{
    uint         cbSize;
    const(GUID)* pComponentId;
    HRESULT      hResultUI;
}

struct SL_SYSTEM_POLICY_INFORMATION
{
    void[2]* Reserved1;
    uint[3]  Reserved2;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/nf-ntsecapi-rtlgenrandom
@DllImport("ADVAPI32.dll")
BOOLEAN RtlGenRandom(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* RandomBuffer, 
                     uint RandomBufferLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/nf-ntsecapi-rtlencryptmemory
@DllImport("ADVAPI32.dll")
NTSTATUS RtlEncryptMemory(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Memory, 
                          uint MemorySize, uint OptionFlags);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ntsecapi/nf-ntsecapi-rtldecryptmemory
@DllImport("ADVAPI32.dll")
NTSTATUS RtlDecryptMemory(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* Memory, 
                          uint MemorySize, uint OptionFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaRegisterLogonProcess(LSA_STRING* LogonProcessName, HANDLE* LsaHandle, uint* SecurityMode);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaLogonUser(HANDLE LsaHandle, LSA_STRING* OriginName, SECURITY_LOGON_TYPE LogonType, 
                      uint AuthenticationPackage, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* AuthenticationInformation, 
                      uint AuthenticationInformationLength, TOKEN_GROUPS* LocalGroups, TOKEN_SOURCE* SourceContext, 
                      void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, HANDLE* Token, 
                      QUOTA_LIMITS* Quotas, int* SubStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaLookupAuthenticationPackage(HANDLE LsaHandle, LSA_STRING* PackageName, uint* AuthenticationPackage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaFreeReturnBuffer(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaCallAuthenticationPackage(HANDLE LsaHandle, uint AuthenticationPackage, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                      uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                      int* ProtocolStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaDeregisterLogonProcess(HANDLE LsaHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaConnectUntrusted(HANDLE* LsaHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaFreeMemory(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaClose(LSA_HANDLE ObjectHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaEnumerateLogonSessions(uint* LogonSessionCount, LUID** LogonSessionList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaGetLogonSessionData(LUID* LogonId, SECURITY_LOGON_SESSION_DATA** ppLogonSessionData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaOpenPolicy(LSA_UNICODE_STRING* SystemName, LSA_OBJECT_ATTRIBUTES* ObjectAttributes, uint DesiredAccess, 
                       LSA_HANDLE* PolicyHandle);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetCAPs(LSA_UNICODE_STRING* CAPDNs, uint CAPDNCount, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaGetAppliedCAPIDs(LSA_UNICODE_STRING* SystemName, PSID** CAPIDs, uint* CAPIDCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryCAPs(PSID* CAPIDs, uint CAPIDCount, CENTRAL_ACCESS_POLICY** CAPs, uint* CAPCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryInformationPolicy(LSA_HANDLE PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, 
                                   void** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetInformationPolicy(LSA_HANDLE PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryDomainInformationPolicy(LSA_HANDLE PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, 
                                         void** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetDomainInformationPolicy(LSA_HANDLE PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, 
                                       void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaRegisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, 
                                             HANDLE NotificationEventHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
NTSTATUS LsaUnregisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, 
                                               HANDLE NotificationEventHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateTrustedDomains(LSA_HANDLE PolicyHandle, uint* EnumerationContext, void** Buffer, 
                                    uint PreferedMaximumLength, uint* CountReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupNames(LSA_HANDLE PolicyHandle, uint Count, LSA_UNICODE_STRING* Names, 
                        LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID** Sids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupNames2(LSA_HANDLE PolicyHandle, uint Flags, uint Count, LSA_UNICODE_STRING* Names, 
                         LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID2** Sids);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupSids(LSA_HANDLE PolicyHandle, uint Count, PSID* Sids, 
                       LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_NAME** Names);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaLookupSids2(LSA_HANDLE PolicyHandle, uint LookupOptions, uint Count, PSID* Sids, 
                        LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_NAME** Names);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateAccountsWithUserRight(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* UserRight, void** Buffer, 
                                           uint* CountReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateAccountRights(LSA_HANDLE PolicyHandle, PSID AccountSid, LSA_UNICODE_STRING** UserRights, 
                                   uint* CountOfRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaAddAccountRights(LSA_HANDLE PolicyHandle, PSID AccountSid, LSA_UNICODE_STRING* UserRights, 
                             uint CountOfRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaRemoveAccountRights(LSA_HANDLE PolicyHandle, PSID AccountSid, BOOLEAN AllRights, 
                                LSA_UNICODE_STRING* UserRights, uint CountOfRights);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaOpenTrustedDomainByName(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                    uint DesiredAccess, LSA_HANDLE* TrustedDomainHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryTrustedDomainInfo(LSA_HANDLE PolicyHandle, PSID TrustedDomainSid, 
                                   TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetTrustedDomainInformation(LSA_HANDLE PolicyHandle, PSID TrustedDomainSid, 
                                        TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaDeleteTrustedDomain(LSA_HANDLE PolicyHandle, PSID TrustedDomainSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryTrustedDomainInfoByName(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                         TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetTrustedDomainInfoByName(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                       TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaEnumerateTrustedDomainsEx(LSA_HANDLE PolicyHandle, uint* EnumerationContext, void** Buffer, 
                                      uint PreferedMaximumLength, uint* CountReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaCreateTrustedDomainEx(LSA_HANDLE PolicyHandle, TRUSTED_DOMAIN_INFORMATION_EX* TrustedDomainInformation, 
                                  TRUSTED_DOMAIN_AUTH_INFORMATION* AuthenticationInformation, uint DesiredAccess, 
                                  LSA_HANDLE* TrustedDomainHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryForestTrustInformation(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                        LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetForestTrustInformation(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                      LSA_FOREST_TRUST_INFORMATION* ForestTrustInfo, BOOLEAN CheckOnly, 
                                      LSA_FOREST_TRUST_COLLISION_INFORMATION** CollisionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaStorePrivateData(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* KeyName, LSA_UNICODE_STRING* PrivateData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
NTSTATUS LsaRetrievePrivateData(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* KeyName, 
                                LSA_UNICODE_STRING** PrivateData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint LsaNtStatusToWinError(NTSTATUS Status);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaQueryForestTrustInformation2(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                         LSA_FOREST_TRUST_RECORD_TYPE HighestRecordType, 
                                         LSA_FOREST_TRUST_INFORMATION2** ForestTrustInfo);

@DllImport("ADVAPI32.dll")
NTSTATUS LsaSetForestTrustInformation2(LSA_HANDLE PolicyHandle, LSA_UNICODE_STRING* TrustedDomainName, 
                                       LSA_FOREST_TRUST_RECORD_TYPE HighestRecordType, 
                                       LSA_FOREST_TRUST_INFORMATION2* ForestTrustInfo, BOOLEAN CheckOnly, 
                                       LSA_FOREST_TRUST_COLLISION_INFORMATION** CollisionInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditSetSystemPolicy(AUDIT_POLICY_INFORMATION* pAuditPolicy, uint dwPolicyCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditSetPerUserPolicy(const(PSID) pSid, AUDIT_POLICY_INFORMATION* pAuditPolicy, uint dwPolicyCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditQuerySystemPolicy(const(GUID)* pSubCategoryGuids, uint dwPolicyCount, 
                               AUDIT_POLICY_INFORMATION** ppAuditPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditQueryPerUserPolicy(const(PSID) pSid, const(GUID)* pSubCategoryGuids, uint dwPolicyCount, 
                                AUDIT_POLICY_INFORMATION** ppAuditPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditEnumeratePerUserPolicy(POLICY_AUDIT_SID_ARRAY** ppAuditSidArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditComputeEffectivePolicyBySid(const(PSID) pSid, const(GUID)* pSubCategoryGuids, uint dwPolicyCount, 
                                         AUDIT_POLICY_INFORMATION** ppAuditPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditComputeEffectivePolicyByToken(HANDLE hTokenHandle, const(GUID)* pSubCategoryGuids, uint dwPolicyCount, 
                                           AUDIT_POLICY_INFORMATION** ppAuditPolicy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditEnumerateCategories(GUID** ppAuditCategoriesArray, uint* pdwCountReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditEnumerateSubCategories(const(GUID)* pAuditCategoryGuid, BOOLEAN bRetrieveAllSubCategories, 
                                    GUID** ppAuditSubCategoriesArray, uint* pdwCountReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupCategoryNameW(const(GUID)* pAuditCategoryGuid, PWSTR* ppszCategoryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupCategoryNameA(const(GUID)* pAuditCategoryGuid, PSTR* ppszCategoryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupSubCategoryNameW(const(GUID)* pAuditSubCategoryGuid, PWSTR* ppszSubCategoryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupSubCategoryNameA(const(GUID)* pAuditSubCategoryGuid, PSTR* ppszSubCategoryName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupCategoryIdFromCategoryGuid(const(GUID)* pAuditCategoryGuid, 
                                              POLICY_AUDIT_EVENT_TYPE* pAuditCategoryId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditLookupCategoryGuidFromCategoryId(POLICY_AUDIT_EVENT_TYPE AuditCategoryId, GUID* pAuditCategoryGuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditSetSecurity(OBJECT_SECURITY_INFORMATION SecurityInformation, PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditQuerySecurity(OBJECT_SECURITY_INFORMATION SecurityInformation, 
                           PSECURITY_DESCRIPTOR* ppSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditSetGlobalSaclW(const(PWSTR) ObjectTypeName, ACL* Acl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditSetGlobalSaclA(const(PSTR) ObjectTypeName, ACL* Acl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditQueryGlobalSaclW(const(PWSTR) ObjectTypeName, ACL** Acl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ADVAPI32.dll")
BOOLEAN AuditQueryGlobalSaclA(const(PSTR) ObjectTypeName, ACL** Acl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void AuditFree(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT AcquireCredentialsHandleW(PWSTR pszPrincipal, PWSTR pszPackage, SECPKG_CRED fCredentialUse, 
                                  void* pvLogonId, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                                  SecHandle* phCredential, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT AcquireCredentialsHandleA(PSTR pszPrincipal, PSTR pszPackage, SECPKG_CRED fCredentialUse, void* pvLogonId, 
                                  void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                                  SecHandle* phCredential, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT FreeCredentialsHandle(SecHandle* phCredential);

@DllImport("SECUR32.dll")
HRESULT AddCredentialsW(SecHandle* hCredentials, PWSTR pszPrincipal, PWSTR pszPackage, uint fCredentialUse, 
                        void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, long* ptsExpiry);

@DllImport("SECUR32.dll")
HRESULT AddCredentialsA(SecHandle* hCredentials, PSTR pszPrincipal, PSTR pszPackage, uint fCredentialUse, 
                        void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT ChangeAccountPasswordW(ushort* pszPackageName, ushort* pszDomainName, ushort* pszAccountName, 
                               ushort* pszOldPassword, ushort* pszNewPassword, BOOLEAN bImpersonating, 
                               uint dwReserved, SecBufferDesc* pOutput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT ChangeAccountPasswordA(byte* pszPackageName, byte* pszDomainName, byte* pszAccountName, 
                               byte* pszOldPassword, byte* pszNewPassword, BOOLEAN bImpersonating, uint dwReserved, 
                               SecBufferDesc* pOutput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT InitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, ushort* pszTargetName, 
                                   ISC_REQ_FLAGS fContextReq, uint Reserved1, uint TargetDataRep, 
                                   SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, 
                                   SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT InitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, byte* pszTargetName, 
                                   ISC_REQ_FLAGS fContextReq, uint Reserved1, uint TargetDataRep, 
                                   SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, 
                                   SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT AcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, 
                              ASC_REQ_FLAGS fContextReq, uint TargetDataRep, SecHandle* phNewContext, 
                              SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT CompleteAuthToken(SecHandle* phContext, SecBufferDesc* pToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT ImpersonateSecurityContext(SecHandle* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT RevertSecurityContext(SecHandle* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT QuerySecurityContextToken(SecHandle* phContext, void** Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT DeleteSecurityContext(SecHandle* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT ApplyControlToken(SecHandle* phContext, SecBufferDesc* pInput);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT QueryContextAttributesW(SecHandle* phContext, SECPKG_ATTR ulAttribute, void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SspiCli.dll")
HRESULT QueryContextAttributesExW(SecHandle* phContext, SECPKG_ATTR ulAttribute, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                  uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
HRESULT QueryContextAttributesA(SecHandle* phContext, SECPKG_ATTR ulAttribute, void* pBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SspiCli.dll")
HRESULT QueryContextAttributesExA(SecHandle* phContext, SECPKG_ATTR ulAttribute, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                  uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT SetContextAttributesW(SecHandle* phContext, SECPKG_ATTR ulAttribute, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                              uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT SetContextAttributesA(SecHandle* phContext, SECPKG_ATTR ulAttribute, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                              uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT QueryCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
HRESULT QueryCredentialsAttributesExW(SecHandle* phCredential, uint ulAttribute, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                      uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT QueryCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli.dll")
HRESULT QueryCredentialsAttributesExA(SecHandle* phCredential, uint ulAttribute, 
                                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                      uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT SetCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                  uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT SetCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pBuffer, 
                                  uint cbBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT FreeContextBuffer(void* pvContextBuffer);

@DllImport("SspiCli.dll")
HRESULT SecAllocateAndSetIPAddress(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* lpIpAddress, 
                                   uint cchIpAddress, int* FreeCallContext);

@DllImport("SspiCli.dll")
HRESULT SecAllocateAndSetCallTarget(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* lpIpAddress, 
                                    uint cchIpAddress, PWSTR TargetName, int* FreeCallContext);

@DllImport("SspiCli.dll")
void SecFreeCallContext();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT MakeSignature(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT VerifySignature(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT EncryptMessage(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT DecryptMessage(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT EnumerateSecurityPackagesW(uint* pcPackages, SecPkgInfoW** ppPackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT EnumerateSecurityPackagesA(uint* pcPackages, SecPkgInfoA** ppPackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT QuerySecurityPackageInfoW(PWSTR pszPackageName, SecPkgInfoW** ppPackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT QuerySecurityPackageInfoA(PSTR pszPackageName, SecPkgInfoA** ppPackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT ExportSecurityContext(SecHandle* phContext, EXPORT_SECURITY_CONTEXT_FLAGS fFlags, 
                              SecBuffer* pPackedContext, void** pToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT ImportSecurityContextW(PWSTR pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
HRESULT ImportSecurityContextA(PSTR pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
SecurityFunctionTableA* InitSecurityInterfaceA();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SECUR32.dll")
SecurityFunctionTableW* InitSecurityInterfaceW();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslEnumerateProfilesA(PSTR* ProfileList, uint* ProfileCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslEnumerateProfilesW(PWSTR* ProfileList, uint* ProfileCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslGetProfilePackageA(PSTR ProfileName, SecPkgInfoA** PackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslGetProfilePackageW(PWSTR ProfileName, SecPkgInfoW** PackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslIdentifyPackageA(SecBufferDesc* pInput, SecPkgInfoA** PackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslIdentifyPackageW(SecBufferDesc* pInput, SecPkgInfoW** PackageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslInitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, PWSTR pszTargetName, 
                                       ISC_REQ_FLAGS fContextReq, uint Reserved1, uint TargetDataRep, 
                                       SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, 
                                       SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslInitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, PSTR pszTargetName, 
                                       ISC_REQ_FLAGS fContextReq, uint Reserved1, uint TargetDataRep, 
                                       SecBufferDesc* pInput, uint Reserved2, SecHandle* phNewContext, 
                                       SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslAcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, 
                                  ASC_REQ_FLAGS fContextReq, uint TargetDataRep, SecHandle* phNewContext, 
                                  SecBufferDesc* pOutput, uint* pfContextAttr, long* ptsExpiry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslSetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windowsserver2003))], [])
@DllImport("SECUR32.dll")
HRESULT SaslGetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size, uint* Needed);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("credui.dll")
uint SspiPromptForCredentialsW(const(PWSTR) pszTargetName, void* pUiInfo, uint dwAuthError, 
                               const(PWSTR) pszPackage, void* pInputAuthIdentity, void** ppAuthIdentity, int* pfSave, 
                               uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("credui.dll")
uint SspiPromptForCredentialsA(const(PSTR) pszTargetName, void* pUiInfo, uint dwAuthError, const(PSTR) pszPackage, 
                               void* pInputAuthIdentity, void** ppAuthIdentity, int* pfSave, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiPrepareForCredRead(void* AuthIdentity, const(PWSTR) pszTargetName, uint* pCredmanCredentialType, 
                               const(PWSTR)* ppszCredmanTargetName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiPrepareForCredWrite(void* AuthIdentity, const(PWSTR) pszTargetName, uint* pCredmanCredentialType, 
                                const(PWSTR)* ppszCredmanTargetName, const(PWSTR)* ppszCredmanUserName, 
                                ubyte** ppCredentialBlob, uint* pCredentialBlobSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiEncryptAuthIdentity(void* AuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SspiCli.dll")
HRESULT SspiEncryptAuthIdentityEx(uint Options, void* AuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiDecryptAuthIdentity(void* EncryptedAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SspiCli.dll")
HRESULT SspiDecryptAuthIdentityEx(uint Options, void* EncryptedAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
BOOLEAN SspiIsAuthIdentityEncrypted(void* EncryptedAuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiEncodeAuthIdentityAsStrings(void* pAuthIdentity, const(PWSTR)* ppszUserName, 
                                        const(PWSTR)* ppszDomainName, const(PWSTR)* ppszPackedCredentialsString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiValidateAuthIdentity(void* AuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiCopyAuthIdentity(void* AuthData, void** AuthDataCopy);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
void SspiFreeAuthIdentity(void* AuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
void SspiZeroAuthIdentity(void* AuthData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
void SspiLocalFree(void* DataBuffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiEncodeStringsAsAuthIdentity(const(PWSTR) pszUserName, const(PWSTR) pszDomainName, 
                                        const(PWSTR) pszPackedCredentialsString, void** ppAuthIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiCompareAuthIdentities(void* AuthIdentity1, void* AuthIdentity2, BOOLEAN* SameSuppliedUser, 
                                  BOOLEAN* SameSuppliedIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiMarshalAuthIdentity(void* AuthIdentity, uint* AuthIdentityLength, byte** AuthIdentityByteArray);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiUnmarshalAuthIdentity(uint AuthIdentityLength, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PSTR AuthIdentityByteArray, 
                                  void** ppAuthIdentity);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("credui.dll")
BOOLEAN SspiIsPromptingNeeded(uint ErrorOrNtStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiGetTargetHostName(const(PWSTR) pszTargetName, PWSTR* pszHostName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT SspiExcludePackage(void* AuthIdentity, const(PWSTR) pszPackageName, void** ppNewAuthIdentity);

@DllImport("SspiCli.dll")
HRESULT SspiSetChannelBindingFlags(SecPkgContext_Bindings* pBindings, uint flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT AddSecurityPackageA(PSTR pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT AddSecurityPackageW(PWSTR pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT DeleteSecurityPackageA(PSTR pszPackageName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SECUR32.dll")
HRESULT DeleteSecurityPackageW(PWSTR pszPackageName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SECUR32.dll")
NTSTATUS CredMarshalTargetInfo(CREDENTIAL_TARGET_INFORMATIONW* InTargetInfo, ushort** Buffer, uint* BufferSize);

@DllImport("SECUR32.dll")
NTSTATUS CredUnmarshalTargetInfo(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ushort* Buffer, 
                                 uint BufferSize, CREDENTIAL_TARGET_INFORMATIONW** RetTargetInfo, 
                                 uint* RetActualSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCHANNEL.dll")
BOOL SslEmptyCacheA(PSTR pszTargetName, uint dwFlags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCHANNEL.dll")
BOOL SslEmptyCacheW(PWSTR pszTargetName, uint dwFlags);

@DllImport("SCHANNEL.dll")
void SslGenerateRandomBits(ubyte* pRandomData, int cRandomData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCHANNEL.dll")
BOOL SslCrackCertificate(ubyte* pbCertificate, uint cbCertificate, uint dwFlags, X509Certificate** ppCertificate);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("SCHANNEL.dll")
void SslFreeCertificate(X509Certificate* pCertificate);

@DllImport("SCHANNEL.dll")
uint SslGetMaximumKeySize(uint Reserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SCHANNEL.dll")
HRESULT SslGetServerIdentity(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ubyte* ClientHello, 
                             uint ClientHelloSize, ubyte** ServerIdentity, uint* ServerIdentitySize, uint Flags);

@DllImport("SCHANNEL.dll")
HRESULT SslGetExtensions(const(ubyte)* clientHello, uint clientHelloByteSize, 
                         SCH_EXTENSION_DATA* genericExtensions, ubyte genericExtensionsCount, uint* bytesToRead, 
                         SchGetExtensionsOptions flags);

@DllImport("SCHANNEL.dll")
HRESULT SslDeserializeCertificateStore(CRYPT_INTEGER_BLOB SerializedCertificateStore, CERT_CONTEXT** ppCertContext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGenerateBinding(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(PWSTR) targetURL, 
                                    TOKENBINDING_TYPE bindingType, 
                                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* tlsEKM, 
                                    uint tlsEKMSize, TOKENBINDING_EXTENSION_FORMAT extensionFormat, 
                                    const(void)* extensionData, void** tokenBinding, uint* tokenBindingSize, 
                                    TOKENBINDING_RESULT_DATA** resultData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGenerateMessage(const(void)** tokenBindings, const(uint)* tokenBindingsSize, 
                                    uint tokenBindingsCount, void** tokenBindingMessage, 
                                    uint* tokenBindingMessageSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingVerifyMessage(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(void)* tokenBindingMessage, 
                                  uint tokenBindingMessageSize, TOKENBINDING_KEY_PARAMETERS_TYPE keyType, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/const(void)* tlsEKM, 
                                  uint tlsEKMSize, TOKENBINDING_RESULT_LIST** resultList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGetKeyTypesClient(TOKENBINDING_KEY_TYPES** keyTypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGetKeyTypesServer(TOKENBINDING_KEY_TYPES** keyTypes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingDeleteBinding(const(PWSTR) targetURL);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingDeleteAllBindings();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGenerateID(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, 
                               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/const(void)* publicKey, 
                               uint publicKeySize, TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGenerateIDForUri(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(PWSTR) targetUri, 
                                     TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING.dll")
HRESULT TokenBindingGetHighestSupportedVersion(ubyte* majorVersion, ubyte* minorVersion);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN GetUserNameExA(EXTENDED_NAME_FORMAT NameFormat, PSTR lpNameBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN GetUserNameExW(EXTENDED_NAME_FORMAT NameFormat, PWSTR lpNameBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN GetComputerObjectNameA(EXTENDED_NAME_FORMAT NameFormat, PSTR lpNameBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN GetComputerObjectNameW(EXTENDED_NAME_FORMAT NameFormat, PWSTR lpNameBuffer, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN TranslateNameA(const(PSTR) lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                       EXTENDED_NAME_FORMAT DesiredNameFormat, PSTR lpTranslatedName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("SECUR32.dll")
BOOLEAN TranslateNameW(const(PWSTR) lpAccountName, EXTENDED_NAME_FORMAT AccountNameFormat, 
                       EXTENDED_NAME_FORMAT DesiredNameFormat, PWSTR lpTranslatedName, uint* nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLOpen(void** phSLC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLClose(void* hSLC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLInstallProofOfPurchase(void* hSLC, const(PWSTR) pwszPKeyAlgorithm, const(PWSTR) pwszPKeyString, 
                                 uint cbPKeySpecificData, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ubyte* pbPKeySpecificData, 
                                 GUID* pPkeyId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLUninstallProofOfPurchase(void* hSLC, const(GUID)* pPKeyId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLInstallLicense(void* hSLC, uint cbLicenseBlob, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(ubyte)* pbLicenseBlob, 
                         GUID* pLicenseFileId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLUninstallLicense(void* hSLC, const(GUID)* pLicenseFileId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLConsumeRight(void* hSLC, const(GUID)* pAppId, const(GUID)* pProductSkuId, const(PWSTR) pwszRightName, 
                       /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/void* pvReserved);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetProductSkuInformation(void* hSLC, const(GUID)* pProductSkuId, const(PWSTR) pwszValueName, 
                                   SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetPKeyInformation(void* hSLC, const(GUID)* pPKeyId, const(PWSTR) pwszValueName, SLDATATYPE* peDataType, 
                             uint* pcbValue, ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetLicenseInformation(void* hSLC, const(GUID)* pSLLicenseId, const(PWSTR) pwszValueName, 
                                SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetLicensingStatusInformation(void* hSLC, const(GUID)* pAppID, const(GUID)* pProductSkuId, 
                                        const(PWSTR) pwszRightName, uint* pnStatusCount, 
                                        SL_LICENSING_STATUS** ppLicensingStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetPolicyInformation(void* hSLC, const(PWSTR) pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                               ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetPolicyInformationDWORD(void* hSLC, const(PWSTR) pwszValueName, uint* pdwValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetServiceInformation(void* hSLC, const(PWSTR) pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                                ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetApplicationInformation(void* hSLC, const(GUID)* pApplicationId, const(PWSTR) pwszValueName, 
                                    SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("slcext.dll")
HRESULT SLActivateProduct(void* hSLC, const(GUID)* pProductSkuId, uint cbAppSpecificData, 
                          const(void)* pvAppSpecificData, const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                          const(PWSTR) pwszProxyServer, ushort wProxyPort);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("slcext.dll")
HRESULT SLGetServerStatus(const(PWSTR) pwszServerURL, const(PWSTR) pwszAcquisitionType, 
                          const(PWSTR) pwszProxyServer, ushort wProxyPort, HRESULT* phrStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGenerateOfflineInstallationId(void* hSLC, const(GUID)* pProductSkuId, PWSTR* ppwszInstallationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGenerateOfflineInstallationIdEx(void* hSLC, const(GUID)* pProductSkuId, 
                                          const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                                          PWSTR* ppwszInstallationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLDepositOfflineConfirmationId(void* hSLC, const(GUID)* pProductSkuId, const(PWSTR) pwszInstallationId, 
                                       const(PWSTR) pwszConfirmationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLDepositOfflineConfirmationIdEx(void* hSLC, const(GUID)* pProductSkuId, 
                                         const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                                         const(PWSTR) pwszInstallationId, const(PWSTR) pwszConfirmationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetPKeyId(void* hSLC, const(PWSTR) pwszPKeyAlgorithm, const(PWSTR) pwszPKeyString, 
                    uint cbPKeySpecificData, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* pbPKeySpecificData, 
                    GUID* pPKeyId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetInstalledProductKeyIds(void* hSLC, const(GUID)* pProductSkuId, uint* pnProductKeyIds, 
                                    GUID** ppProductKeyIds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLSetCurrentProductKey(void* hSLC, const(GUID)* pProductSkuId, const(GUID)* pProductKeyId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetSLIDList(void* hSLC, SLIDTYPE eQueryIdType, const(GUID)* pQueryId, SLIDTYPE eReturnIdType, 
                      uint* pnReturnIds, GUID** ppReturnIds);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetLicenseFileId(void* hSLC, uint cbLicenseBlob, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/const(ubyte)* pbLicenseBlob, 
                           GUID* pLicenseFileId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLGetLicense(void* hSLC, const(GUID)* pLicenseFileId, uint* pcbLicenseFile, ubyte** ppbLicenseFile);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLFireEvent(void* hSLC, const(PWSTR) pwszEventId, const(GUID)* pApplicationId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLRegisterEvent(void* hSLC, const(PWSTR) pwszEventId, const(GUID)* pApplicationId, HANDLE hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("SLC.dll")
HRESULT SLUnregisterEvent(void* hSLC, const(PWSTR) pwszEventId, const(GUID)* pApplicationId, HANDLE hEvent);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SLC.dll")
HRESULT SLGetWindowsInformation(const(PWSTR) pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                                ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SLC.dll")
HRESULT SLGetWindowsInformationDWORD(const(PWSTR) pwszValueName, uint* pdwValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SLWGA.dll")
HRESULT SLIsGenuineLocal(const(GUID)* pAppId, SL_GENUINE_STATE* pGenuineState, 
                         SL_NONGENUINE_UI_OPTIONS* pUIOptions);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("slcext.dll")
HRESULT SLAcquireGenuineTicket(void** ppTicketBlob, uint* pcbTicketBlob, const(PWSTR) pwszTemplateId, 
                               const(PWSTR) pwszServerUrl, const(PWSTR) pwszClientToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SLC.dll")
HRESULT SLSetGenuineInformation(const(GUID)* pQueryId, const(PWSTR) pwszValueName, SLDATATYPE eDataType, 
                                uint cbValue, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/const(ubyte)* pbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("slcext.dll")
HRESULT SLGetReferralInformation(void* hSLC, SLREFERRALTYPE eReferralType, const(GUID)* pSkuOrAppId, 
                                 const(PWSTR) pwszValueName, PWSTR* ppwszValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("SLC.dll")
HRESULT SLGetGenuineInformation(const(GUID)* pQueryId, const(PWSTR) pwszValueName, SLDATATYPE* peDataType, 
                                uint* pcbValue, ubyte** ppbValue);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows10.0.10240))], [])
@DllImport("api-ms-win-core-slapi-l1-1-0.dll")
HRESULT SLQueryLicenseValueFromApp(const(PWSTR) valueName, uint* valueType, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* dataBuffer, 
                                   uint dataSize, uint* resultDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("SAS.dll")
void SendSAS(BOOL AsUser);


// Interfaces

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ccgplugins/nn-ccgplugins-iccgdomainauthcredentials
@GUID("6ecda518-2010-4437-8bc3-46e752b7b172")
interface ICcgDomainAuthCredentials : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ccgplugins/nf-ccgplugins-iccgdomainauthcredentials-getpasswordcredentials
    HRESULT GetPasswordCredentials(const(PWSTR) pluginInput, PWSTR* domainName, PWSTR* username, PWSTR* password);
}


// GUIDs


const GUID IID_ICcgDomainAuthCredentials = GUIDOF!ICcgDomainAuthCredentials;
