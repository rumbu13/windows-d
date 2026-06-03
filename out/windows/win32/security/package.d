// Written in the D programming language.

module windows.win32.security;

public import windows.core;
public import windows.win32.foundation : BOOL, BOOLEAN, CHAR, FILETIME, HANDLE, LUID,
                                         NTSTATUS, PSTR, PWSTR, UNICODE_STRING;

extern(Windows) @nogc nothrow:


// Enums


alias TOKEN_PRIVILEGES_ATTRIBUTES = uint;
enum : uint
{
    SE_PRIVILEGE_ENABLED            = 0x00000002U,
    SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001U,
    SE_PRIVILEGE_REMOVED            = 0x00000004U,
    SE_PRIVILEGE_USED_FOR_ACCESS    = 0x80000000U,
}

alias LOGON32_PROVIDER = uint;
enum : uint
{
    LOGON32_PROVIDER_DEFAULT = 0x00000000U,
    LOGON32_PROVIDER_WINNT50 = 0x00000003U,
    LOGON32_PROVIDER_WINNT40 = 0x00000002U,
}

alias CREATE_RESTRICTED_TOKEN_FLAGS = uint;
enum : uint
{
    DISABLE_MAX_PRIVILEGE = 0x00000001U,
    SANDBOX_INERT         = 0x00000002U,
    LUA_TOKEN             = 0x00000004U,
    WRITE_RESTRICTED      = 0x00000008U,
}

alias LOGON32_LOGON = uint;
enum : uint
{
    LOGON32_LOGON_BATCH             = 0x00000004U,
    LOGON32_LOGON_INTERACTIVE       = 0x00000002U,
    LOGON32_LOGON_NETWORK           = 0x00000003U,
    LOGON32_LOGON_NETWORK_CLEARTEXT = 0x00000008U,
    LOGON32_LOGON_NEW_CREDENTIALS   = 0x00000009U,
    LOGON32_LOGON_SERVICE           = 0x00000005U,
    LOGON32_LOGON_UNLOCK            = 0x00000007U,
}

alias ACE_FLAGS = uint;
enum : uint
{
    CONTAINER_INHERIT_ACE              = 0x00000002U,
    FAILED_ACCESS_ACE_FLAG             = 0x00000080U,
    INHERIT_ONLY_ACE                   = 0x00000008U,
    INHERITED_ACE                      = 0x00000010U,
    NO_PROPAGATE_INHERIT_ACE           = 0x00000004U,
    OBJECT_INHERIT_ACE                 = 0x00000001U,
    SUCCESSFUL_ACCESS_ACE_FLAG         = 0x00000040U,
    SUB_CONTAINERS_AND_OBJECTS_INHERIT = 0x00000003U,
    SUB_CONTAINERS_ONLY_INHERIT        = 0x00000002U,
    SUB_OBJECTS_ONLY_INHERIT           = 0x00000001U,
    INHERIT_NO_PROPAGATE               = 0x00000004U,
    INHERIT_ONLY                       = 0x00000008U,
    NO_INHERITANCE                     = 0x00000000U,
}

alias OBJECT_SECURITY_INFORMATION = uint;
enum : uint
{
    ATTRIBUTE_SECURITY_INFORMATION        = 0x00000020U,
    BACKUP_SECURITY_INFORMATION           = 0x00010000U,
    DACL_SECURITY_INFORMATION             = 0x00000004U,
    GROUP_SECURITY_INFORMATION            = 0x00000002U,
    LABEL_SECURITY_INFORMATION            = 0x00000010U,
    OWNER_SECURITY_INFORMATION            = 0x00000001U,
    PROTECTED_DACL_SECURITY_INFORMATION   = 0x80000000U,
    PROTECTED_SACL_SECURITY_INFORMATION   = 0x40000000U,
    SACL_SECURITY_INFORMATION             = 0x00000008U,
    SCOPE_SECURITY_INFORMATION            = 0x00000040U,
    UNPROTECTED_DACL_SECURITY_INFORMATION = 0x20000000U,
    UNPROTECTED_SACL_SECURITY_INFORMATION = 0x10000000U,
}

alias SECURITY_AUTO_INHERIT_FLAGS = uint;
enum : uint
{
    SEF_AVOID_OWNER_CHECK             = 0x00000010U,
    SEF_AVOID_OWNER_RESTRICTION       = 0x00001000U,
    SEF_AVOID_PRIVILEGE_CHECK         = 0x00000008U,
    SEF_DACL_AUTO_INHERIT             = 0x00000001U,
    SEF_DEFAULT_DESCRIPTOR_FOR_OBJECT = 0x00000004U,
    SEF_DEFAULT_GROUP_FROM_PARENT     = 0x00000040U,
    SEF_DEFAULT_OWNER_FROM_PARENT     = 0x00000020U,
    SEF_MACL_NO_EXECUTE_UP            = 0x00000400U,
    SEF_MACL_NO_READ_UP               = 0x00000200U,
    SEF_MACL_NO_WRITE_UP              = 0x00000100U,
    SEF_SACL_AUTO_INHERIT             = 0x00000002U,
}

alias ACE_REVISION = uint;
enum : uint
{
    ACL_REVISION    = 0x00000002U,
    ACL_REVISION_DS = 0x00000004U,
}

alias TOKEN_MANDATORY_POLICY_ID = uint;
enum : uint
{
    TOKEN_MANDATORY_POLICY_OFF             = 0x00000000U,
    TOKEN_MANDATORY_POLICY_NO_WRITE_UP     = 0x00000001U,
    TOKEN_MANDATORY_POLICY_NEW_PROCESS_MIN = 0x00000002U,
    TOKEN_MANDATORY_POLICY_VALID_MASK      = 0x00000003U,
}

alias SYSTEM_AUDIT_OBJECT_ACE_FLAGS = uint;
enum : uint
{
    ACE_OBJECT_TYPE_PRESENT           = 0x00000001U,
    ACE_INHERITED_OBJECT_TYPE_PRESENT = 0x00000002U,
}

alias CLAIM_SECURITY_ATTRIBUTE_FLAGS = uint;
enum : uint
{
    CLAIM_SECURITY_ATTRIBUTE_NON_INHERITABLE      = 0x00000001U,
    CLAIM_SECURITY_ATTRIBUTE_VALUE_CASE_SENSITIVE = 0x00000002U,
    CLAIM_SECURITY_ATTRIBUTE_USE_FOR_DENY_ONLY    = 0x00000004U,
    CLAIM_SECURITY_ATTRIBUTE_DISABLED_BY_DEFAULT  = 0x00000008U,
    CLAIM_SECURITY_ATTRIBUTE_DISABLED             = 0x00000010U,
    CLAIM_SECURITY_ATTRIBUTE_MANDATORY            = 0x00000020U,
}

alias CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE = ushort;
enum : ushort
{
    CLAIM_SECURITY_ATTRIBUTE_TYPE_INT64        = cast(ushort) 0x0001,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_UINT64       = cast(ushort) 0x0002,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_STRING       = cast(ushort) 0x0003,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_OCTET_STRING = cast(ushort) 0x0010,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_FQBN         = cast(ushort) 0x0004,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_SID          = cast(ushort) 0x0005,
    CLAIM_SECURITY_ATTRIBUTE_TYPE_BOOLEAN      = cast(ushort) 0x0006,
}

alias SECURITY_DESCRIPTOR_CONTROL = ushort;
enum : ushort
{
    SE_OWNER_DEFAULTED       = cast(ushort) 0x0001,
    SE_GROUP_DEFAULTED       = cast(ushort) 0x0002,
    SE_DACL_PRESENT          = cast(ushort) 0x0004,
    SE_DACL_DEFAULTED        = cast(ushort) 0x0008,
    SE_SACL_PRESENT          = cast(ushort) 0x0010,
    SE_SACL_DEFAULTED        = cast(ushort) 0x0020,
    SE_DACL_AUTO_INHERIT_REQ = cast(ushort) 0x0100,
    SE_SACL_AUTO_INHERIT_REQ = cast(ushort) 0x0200,
    SE_DACL_AUTO_INHERITED   = cast(ushort) 0x0400,
    SE_SACL_AUTO_INHERITED   = cast(ushort) 0x0800,
    SE_DACL_PROTECTED        = cast(ushort) 0x1000,
    SE_SACL_PROTECTED        = cast(ushort) 0x2000,
    SE_RM_CONTROL_VALID      = cast(ushort) 0x4000,
    SE_SELF_RELATIVE         = cast(ushort) 0x8000,
}

alias TOKEN_ACCESS_MASK = uint;
enum : uint
{
    TOKEN_DELETE                    = 0x00010000U,
    TOKEN_READ_CONTROL              = 0x00020000U,
    TOKEN_WRITE_DAC                 = 0x00040000U,
    TOKEN_WRITE_OWNER               = 0x00080000U,
    TOKEN_ACCESS_SYSTEM_SECURITY    = 0x01000000U,
    TOKEN_ASSIGN_PRIMARY            = 0x00000001U,
    TOKEN_DUPLICATE                 = 0x00000002U,
    TOKEN_IMPERSONATE               = 0x00000004U,
    TOKEN_QUERY                     = 0x00000008U,
    TOKEN_QUERY_SOURCE              = 0x00000010U,
    TOKEN_ADJUST_PRIVILEGES         = 0x00000020U,
    TOKEN_ADJUST_GROUPS             = 0x00000040U,
    TOKEN_ADJUST_DEFAULT            = 0x00000080U,
    TOKEN_ADJUST_SESSIONID          = 0x00000100U,
    TOKEN_READ                      = 0x00020008U,
    TOKEN_WRITE                     = 0x000200e0U,
    TOKEN_EXECUTE                   = 0x00020000U,
    TOKEN_TRUST_CONSTRAINT_MASK     = 0x00020018U,
    TOKEN_ACCESS_PSEUDO_HANDLE_WIN8 = 0x00000018U,
    TOKEN_ACCESS_PSEUDO_HANDLE      = 0x00000018U,
    TOKEN_ALL_ACCESS                = 0x000f01ffU,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/celib/ne-celib-enum_period
alias ENUM_PERIOD = int;
enum : int
{
    ENUM_PERIOD_INVALID = 0xffffffff,
    ENUM_PERIOD_SECONDS = 0x00000000,
    ENUM_PERIOD_MINUTES = 0x00000001,
    ENUM_PERIOD_HOURS   = 0x00000002,
    ENUM_PERIOD_DAYS    = 0x00000003,
    ENUM_PERIOD_WEEKS   = 0x00000004,
    ENUM_PERIOD_MONTHS  = 0x00000005,
    ENUM_PERIOD_YEARS   = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-sid_name_use
alias SID_NAME_USE = int;
enum : int
{
    SidTypeUser           = 0x00000001,
    SidTypeGroup          = 0x00000002,
    SidTypeDomain         = 0x00000003,
    SidTypeAlias          = 0x00000004,
    SidTypeWellKnownGroup = 0x00000005,
    SidTypeDeletedAccount = 0x00000006,
    SidTypeInvalid        = 0x00000007,
    SidTypeUnknown        = 0x00000008,
    SidTypeComputer       = 0x00000009,
    SidTypeLabel          = 0x0000000a,
    SidTypeLogonSession   = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-well_known_sid_type
alias WELL_KNOWN_SID_TYPE = int;
enum : int
{
    WinNullSid                                    = 0x00000000,
    WinWorldSid                                   = 0x00000001,
    WinLocalSid                                   = 0x00000002,
    WinCreatorOwnerSid                            = 0x00000003,
    WinCreatorGroupSid                            = 0x00000004,
    WinCreatorOwnerServerSid                      = 0x00000005,
    WinCreatorGroupServerSid                      = 0x00000006,
    WinNtAuthoritySid                             = 0x00000007,
    WinDialupSid                                  = 0x00000008,
    WinNetworkSid                                 = 0x00000009,
    WinBatchSid                                   = 0x0000000a,
    WinInteractiveSid                             = 0x0000000b,
    WinServiceSid                                 = 0x0000000c,
    WinAnonymousSid                               = 0x0000000d,
    WinProxySid                                   = 0x0000000e,
    WinEnterpriseControllersSid                   = 0x0000000f,
    WinSelfSid                                    = 0x00000010,
    WinAuthenticatedUserSid                       = 0x00000011,
    WinRestrictedCodeSid                          = 0x00000012,
    WinTerminalServerSid                          = 0x00000013,
    WinRemoteLogonIdSid                           = 0x00000014,
    WinLogonIdsSid                                = 0x00000015,
    WinLocalSystemSid                             = 0x00000016,
    WinLocalServiceSid                            = 0x00000017,
    WinNetworkServiceSid                          = 0x00000018,
    WinBuiltinDomainSid                           = 0x00000019,
    WinBuiltinAdministratorsSid                   = 0x0000001a,
    WinBuiltinUsersSid                            = 0x0000001b,
    WinBuiltinGuestsSid                           = 0x0000001c,
    WinBuiltinPowerUsersSid                       = 0x0000001d,
    WinBuiltinAccountOperatorsSid                 = 0x0000001e,
    WinBuiltinSystemOperatorsSid                  = 0x0000001f,
    WinBuiltinPrintOperatorsSid                   = 0x00000020,
    WinBuiltinBackupOperatorsSid                  = 0x00000021,
    WinBuiltinReplicatorSid                       = 0x00000022,
    WinBuiltinPreWindows2000CompatibleAccessSid   = 0x00000023,
    WinBuiltinRemoteDesktopUsersSid               = 0x00000024,
    WinBuiltinNetworkConfigurationOperatorsSid    = 0x00000025,
    WinAccountAdministratorSid                    = 0x00000026,
    WinAccountGuestSid                            = 0x00000027,
    WinAccountKrbtgtSid                           = 0x00000028,
    WinAccountDomainAdminsSid                     = 0x00000029,
    WinAccountDomainUsersSid                      = 0x0000002a,
    WinAccountDomainGuestsSid                     = 0x0000002b,
    WinAccountComputersSid                        = 0x0000002c,
    WinAccountControllersSid                      = 0x0000002d,
    WinAccountCertAdminsSid                       = 0x0000002e,
    WinAccountSchemaAdminsSid                     = 0x0000002f,
    WinAccountEnterpriseAdminsSid                 = 0x00000030,
    WinAccountPolicyAdminsSid                     = 0x00000031,
    WinAccountRasAndIasServersSid                 = 0x00000032,
    WinNTLMAuthenticationSid                      = 0x00000033,
    WinDigestAuthenticationSid                    = 0x00000034,
    WinSChannelAuthenticationSid                  = 0x00000035,
    WinThisOrganizationSid                        = 0x00000036,
    WinOtherOrganizationSid                       = 0x00000037,
    WinBuiltinIncomingForestTrustBuildersSid      = 0x00000038,
    WinBuiltinPerfMonitoringUsersSid              = 0x00000039,
    WinBuiltinPerfLoggingUsersSid                 = 0x0000003a,
    WinBuiltinAuthorizationAccessSid              = 0x0000003b,
    WinBuiltinTerminalServerLicenseServersSid     = 0x0000003c,
    WinBuiltinDCOMUsersSid                        = 0x0000003d,
    WinBuiltinIUsersSid                           = 0x0000003e,
    WinIUserSid                                   = 0x0000003f,
    WinBuiltinCryptoOperatorsSid                  = 0x00000040,
    WinUntrustedLabelSid                          = 0x00000041,
    WinLowLabelSid                                = 0x00000042,
    WinMediumLabelSid                             = 0x00000043,
    WinHighLabelSid                               = 0x00000044,
    WinSystemLabelSid                             = 0x00000045,
    WinWriteRestrictedCodeSid                     = 0x00000046,
    WinCreatorOwnerRightsSid                      = 0x00000047,
    WinCacheablePrincipalsGroupSid                = 0x00000048,
    WinNonCacheablePrincipalsGroupSid             = 0x00000049,
    WinEnterpriseReadonlyControllersSid           = 0x0000004a,
    WinAccountReadonlyControllersSid              = 0x0000004b,
    WinBuiltinEventLogReadersGroup                = 0x0000004c,
    WinNewEnterpriseReadonlyControllersSid        = 0x0000004d,
    WinBuiltinCertSvcDComAccessGroup              = 0x0000004e,
    WinMediumPlusLabelSid                         = 0x0000004f,
    WinLocalLogonSid                              = 0x00000050,
    WinConsoleLogonSid                            = 0x00000051,
    WinThisOrganizationCertificateSid             = 0x00000052,
    WinApplicationPackageAuthoritySid             = 0x00000053,
    WinBuiltinAnyPackageSid                       = 0x00000054,
    WinCapabilityInternetClientSid                = 0x00000055,
    WinCapabilityInternetClientServerSid          = 0x00000056,
    WinCapabilityPrivateNetworkClientServerSid    = 0x00000057,
    WinCapabilityPicturesLibrarySid               = 0x00000058,
    WinCapabilityVideosLibrarySid                 = 0x00000059,
    WinCapabilityMusicLibrarySid                  = 0x0000005a,
    WinCapabilityDocumentsLibrarySid              = 0x0000005b,
    WinCapabilitySharedUserCertificatesSid        = 0x0000005c,
    WinCapabilityEnterpriseAuthenticationSid      = 0x0000005d,
    WinCapabilityRemovableStorageSid              = 0x0000005e,
    WinBuiltinRDSRemoteAccessServersSid           = 0x0000005f,
    WinBuiltinRDSEndpointServersSid               = 0x00000060,
    WinBuiltinRDSManagementServersSid             = 0x00000061,
    WinUserModeDriversSid                         = 0x00000062,
    WinBuiltinHyperVAdminsSid                     = 0x00000063,
    WinAccountCloneableControllersSid             = 0x00000064,
    WinBuiltinAccessControlAssistanceOperatorsSid = 0x00000065,
    WinBuiltinRemoteManagementUsersSid            = 0x00000066,
    WinAuthenticationAuthorityAssertedSid         = 0x00000067,
    WinAuthenticationServiceAssertedSid           = 0x00000068,
    WinLocalAccountSid                            = 0x00000069,
    WinLocalAccountAndAdministratorSid            = 0x0000006a,
    WinAccountProtectedUsersSid                   = 0x0000006b,
    WinCapabilityAppointmentsSid                  = 0x0000006c,
    WinCapabilityContactsSid                      = 0x0000006d,
    WinAccountDefaultSystemManagedSid             = 0x0000006e,
    WinBuiltinDefaultSystemManagedGroupSid        = 0x0000006f,
    WinBuiltinStorageReplicaAdminsSid             = 0x00000070,
    WinAccountKeyAdminsSid                        = 0x00000071,
    WinAccountEnterpriseKeyAdminsSid              = 0x00000072,
    WinAuthenticationKeyTrustSid                  = 0x00000073,
    WinAuthenticationKeyPropertyMFASid            = 0x00000074,
    WinAuthenticationKeyPropertyAttestationSid    = 0x00000075,
    WinAuthenticationFreshKeyAuthSid              = 0x00000076,
    WinBuiltinDeviceOwnersSid                     = 0x00000077,
    WinBuiltinUserModeHardwareOperatorsSid        = 0x00000078,
    WinBuiltinOpenSSHUsersSid                     = 0x00000079,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-acl_information_class
alias ACL_INFORMATION_CLASS = int;
enum : int
{
    AclRevisionInformation = 0x00000001,
    AclSizeInformation     = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-audit_event_type
alias AUDIT_EVENT_TYPE = int;
enum : int
{
    AuditEventObjectAccess           = 0x00000000,
    AuditEventDirectoryServiceAccess = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-security_impersonation_level
alias SECURITY_IMPERSONATION_LEVEL = int;
enum : int
{
    SecurityAnonymous      = 0x00000000,
    SecurityIdentification = 0x00000001,
    SecurityImpersonation  = 0x00000002,
    SecurityDelegation     = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-token_type
alias TOKEN_TYPE = int;
enum : int
{
    TokenPrimary       = 0x00000001,
    TokenImpersonation = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-token_elevation_type
alias TOKEN_ELEVATION_TYPE = int;
enum : int
{
    TokenElevationTypeDefault = 0x00000001,
    TokenElevationTypeFull    = 0x00000002,
    TokenElevationTypeLimited = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-token_information_class
alias TOKEN_INFORMATION_CLASS = int;
enum : int
{
    TokenUser                            = 0x00000001,
    TokenGroups                          = 0x00000002,
    TokenPrivileges                      = 0x00000003,
    TokenOwner                           = 0x00000004,
    TokenPrimaryGroup                    = 0x00000005,
    TokenDefaultDacl                     = 0x00000006,
    TokenSource                          = 0x00000007,
    TokenType                            = 0x00000008,
    TokenImpersonationLevel              = 0x00000009,
    TokenStatistics                      = 0x0000000a,
    TokenRestrictedSids                  = 0x0000000b,
    TokenSessionId                       = 0x0000000c,
    TokenGroupsAndPrivileges             = 0x0000000d,
    TokenSessionReference                = 0x0000000e,
    TokenSandBoxInert                    = 0x0000000f,
    TokenAuditPolicy                     = 0x00000010,
    TokenOrigin                          = 0x00000011,
    TokenElevationType                   = 0x00000012,
    TokenLinkedToken                     = 0x00000013,
    TokenElevation                       = 0x00000014,
    TokenHasRestrictions                 = 0x00000015,
    TokenAccessInformation               = 0x00000016,
    TokenVirtualizationAllowed           = 0x00000017,
    TokenVirtualizationEnabled           = 0x00000018,
    TokenIntegrityLevel                  = 0x00000019,
    TokenUIAccess                        = 0x0000001a,
    TokenMandatoryPolicy                 = 0x0000001b,
    TokenLogonSid                        = 0x0000001c,
    TokenIsAppContainer                  = 0x0000001d,
    TokenCapabilities                    = 0x0000001e,
    TokenAppContainerSid                 = 0x0000001f,
    TokenAppContainerNumber              = 0x00000020,
    TokenUserClaimAttributes             = 0x00000021,
    TokenDeviceClaimAttributes           = 0x00000022,
    TokenRestrictedUserClaimAttributes   = 0x00000023,
    TokenRestrictedDeviceClaimAttributes = 0x00000024,
    TokenDeviceGroups                    = 0x00000025,
    TokenRestrictedDeviceGroups          = 0x00000026,
    TokenSecurityAttributes              = 0x00000027,
    TokenIsRestricted                    = 0x00000028,
    TokenProcessTrustLevel               = 0x00000029,
    TokenPrivateNameSpace                = 0x0000002a,
    TokenSingletonAttributes             = 0x0000002b,
    TokenBnoIsolation                    = 0x0000002c,
    TokenChildProcessFlags               = 0x0000002d,
    TokenIsLessPrivilegedAppContainer    = 0x0000002e,
    TokenIsSandboxed                     = 0x0000002f,
    TokenIsAppSilo                       = 0x00000030,
    TokenLoggingInformation              = 0x00000031,
    TokenLearningMode                    = 0x00000032,
    MaxTokenInfoClass                    = 0x00000033,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ne-winnt-mandatory_level
alias MANDATORY_LEVEL = int;
enum : int
{
    MandatoryLevelUntrusted     = 0x00000000,
    MandatoryLevelLow           = 0x00000001,
    MandatoryLevelMedium        = 0x00000002,
    MandatoryLevelHigh          = 0x00000003,
    MandatoryLevelSystem        = 0x00000004,
    MandatoryLevelSecureProcess = 0x00000005,
    MandatoryLevelCount         = 0x00000006,
}

// Constants


enum BOOLEAN SECURITY_DYNAMIC_TRACKING = BOOLEAN(0x01);
enum BOOLEAN SECURITY_STATIC_TRACKING = BOOLEAN(0x00);
enum uint SECURITY_MAX_SID_SIZE = 0x00000044U;
enum SID_IDENTIFIER_AUTHORITY SECURITY_NULL_SID_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 0]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_WORLD_SID_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 1]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_LOCAL_SID_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 2]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_CREATOR_SID_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 3]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_NON_UNIQUE_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 4]);

enum : SID_IDENTIFIER_AUTHORITY
{
    SECURITY_NT_AUTHORITY               = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 5]),
    SECURITY_RESOURCE_MANAGER_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 9]),
}

enum SID_IDENTIFIER_AUTHORITY SECURITY_APP_PACKAGE_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 15]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_MANDATORY_LABEL_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 16]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_SCOPED_POLICY_ID_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 17]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_AUTHENTICATION_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 18]);
enum SID_IDENTIFIER_AUTHORITY SECURITY_PROCESS_TRUST_AUTHORITY = SID_IDENTIFIER_AUTHORITY([0, 0, 0, 0, 0, 19]);
enum const(wchar)* SE_CREATE_TOKEN_NAME = "SeCreateTokenPrivilege";
enum const(wchar)* SE_ASSIGNPRIMARYTOKEN_NAME = "SeAssignPrimaryTokenPrivilege";
enum const(wchar)* SE_LOCK_MEMORY_NAME = "SeLockMemoryPrivilege";
enum const(wchar)* SE_INCREASE_QUOTA_NAME = "SeIncreaseQuotaPrivilege";
enum const(wchar)* SE_UNSOLICITED_INPUT_NAME = "SeUnsolicitedInputPrivilege";
enum const(wchar)* SE_MACHINE_ACCOUNT_NAME = "SeMachineAccountPrivilege";
enum const(wchar)* SE_TCB_NAME = "SeTcbPrivilege";
enum const(wchar)* SE_SECURITY_NAME = "SeSecurityPrivilege";
enum const(wchar)* SE_TAKE_OWNERSHIP_NAME = "SeTakeOwnershipPrivilege";
enum const(wchar)* SE_LOAD_DRIVER_NAME = "SeLoadDriverPrivilege";

enum : const(wchar)*
{
    SE_SYSTEM_PROFILE_NAME = "SeSystemProfilePrivilege",
    SE_SYSTEMTIME_NAME     = "SeSystemtimePrivilege",
}

enum const(wchar)* SE_PROF_SINGLE_PROCESS_NAME = "SeProfileSingleProcessPrivilege";
enum const(wchar)* SE_INC_BASE_PRIORITY_NAME = "SeIncreaseBasePriorityPrivilege";

enum : const(wchar)*
{
    SE_CREATE_PAGEFILE_NAME  = "SeCreatePagefilePrivilege",
    SE_CREATE_PERMANENT_NAME = "SeCreatePermanentPrivilege",
}

enum const(wchar)* SE_BACKUP_NAME = "SeBackupPrivilege";
enum const(wchar)* SE_RESTORE_NAME = "SeRestorePrivilege";
enum const(wchar)* SE_SHUTDOWN_NAME = "SeShutdownPrivilege";
enum const(wchar)* SE_DEBUG_NAME = "SeDebugPrivilege";
enum const(wchar)* SE_AUDIT_NAME = "SeAuditPrivilege";
enum const(wchar)* SE_SYSTEM_ENVIRONMENT_NAME = "SeSystemEnvironmentPrivilege";
enum const(wchar)* SE_CHANGE_NOTIFY_NAME = "SeChangeNotifyPrivilege";
enum const(wchar)* SE_REMOTE_SHUTDOWN_NAME = "SeRemoteShutdownPrivilege";
enum const(wchar)* SE_UNDOCK_NAME = "SeUndockPrivilege";
enum const(wchar)* SE_SYNC_AGENT_NAME = "SeSyncAgentPrivilege";
enum const(wchar)* SE_ENABLE_DELEGATION_NAME = "SeEnableDelegationPrivilege";
enum const(wchar)* SE_MANAGE_VOLUME_NAME = "SeManageVolumePrivilege";
enum const(wchar)* SE_IMPERSONATE_NAME = "SeImpersonatePrivilege";
enum const(wchar)* SE_CREATE_GLOBAL_NAME = "SeCreateGlobalPrivilege";
enum const(wchar)* SE_TRUSTED_CREDMAN_ACCESS_NAME = "SeTrustedCredManAccessPrivilege";
enum const(wchar)* SE_RELABEL_NAME = "SeRelabelPrivilege";
enum const(wchar)* SE_INC_WORKING_SET_NAME = "SeIncreaseWorkingSetPrivilege";
enum const(wchar)* SE_TIME_ZONE_NAME = "SeTimeZonePrivilege";
enum const(wchar)* SE_CREATE_SYMBOLIC_LINK_NAME = "SeCreateSymbolicLinkPrivilege";
enum const(wchar)* SE_DELEGATE_SESSION_USER_IMPERSONATE_NAME = "SeDelegateSessionUserImpersonatePrivilege";
enum const(wchar)* wszCERTENROLLSHAREPATH = "CertSrv\\CertEnroll";
enum uint cwcHRESULTSTRING = 0x00000028U;
// Native encoding: ansi
enum const(wchar)* szLBRACE = "{";
// Native encoding: ansi
enum const(wchar)* szRBRACE = "}";
enum const(wchar)* wszLBRACE = "{";
enum const(wchar)* wszRBRACE = "}";
// Native encoding: ansi
enum const(wchar)* szLPAREN = "(";
// Native encoding: ansi
enum const(wchar)* szRPAREN = ")";
enum const(wchar)* wszLPAREN = "(";
enum const(wchar)* wszRPAREN = ")";
enum uint CVT_SECONDS = 0x00000001U;
enum uint cwcFILENAMESUFFIXMAX = 0x00000014U;

enum : const(wchar)*
{
    wszFCSAPARM_SERVERDNSNAME      = "%1",
    wszFCSAPARM_SERVERSHORTNAME    = "%2",
    wszFCSAPARM_SANITIZEDCANAME    = "%3",
    wszFCSAPARM_CERTFILENAMESUFFIX = "%4",
}

enum : const(wchar)*
{
    wszFCSAPARM_DOMAINDN            = "%5",
    wszFCSAPARM_CONFIGDN            = "%6",
    wszFCSAPARM_SANITIZEDCANAMEHASH = "%7",
}

enum : const(wchar)*
{
    wszFCSAPARM_CRLFILENAMESUFFIX      = "%8",
    wszFCSAPARM_CRLDELTAFILENAMESUFFIX = "%9",
}

enum : const(wchar)*
{
    wszFCSAPARM_DSCRLATTRIBUTE           = "%10",
    wszFCSAPARM_DSCACERTATTRIBUTE        = "%11",
    wszFCSAPARM_DSUSERCERTATTRIBUTE      = "%12",
    wszFCSAPARM_DSKRACERTATTRIBUTE       = "%13",
    wszFCSAPARM_DSCROSSCERTPAIRATTRIBUTE = "%14",
}

enum : uint
{
    SIGNING_LEVEL_FILE_CACHE_FLAG_NOT_VALIDATED = 0x00000001U,
    SIGNING_LEVEL_FILE_CACHE_FLAG_VALIDATE_ONLY = 0x00000004U,
}

enum uint SIGNING_LEVEL_MICROSOFT = 0x00000008U;

// Callbacks

alias PLSA_AP_CALL_PACKAGE_UNTRUSTED = NTSTATUS function(void** ClientRequest, 
                                                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* ProtocolSubmitBuffer, 
                                                         void* ClientBufferBase, uint SubmitBufferLength, 
                                                         void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                                         int* ProtocolStatus);
alias SEC_THREAD_START = uint function(void* lpThreadParameter);

// Structs


struct PSID
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct NCRYPT_DESCRIPTOR_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct NCRYPT_STREAM_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct SAFER_LEVEL_HANDLE
{
    void* Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct PSECURITY_DESCRIPTOR
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wtypesbase/ns-wtypesbase-security_attributes
struct SECURITY_ATTRIBUTES
{
    uint  nLength;
    void* lpSecurityDescriptor;
    BOOL  bInheritHandle;
}

struct LLFILETIME
{
    union
    {
        long     ll;
        FILETIME ft;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-generic_mapping
struct GENERIC_MAPPING
{
    uint GenericRead;
    uint GenericWrite;
    uint GenericExecute;
    uint GenericAll;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-luid_and_attributes
struct LUID_AND_ATTRIBUTES
{
    LUID Luid;
    TOKEN_PRIVILEGES_ATTRIBUTES Attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/NetMgmt/odj-sid_identifier_authority
struct SID_IDENTIFIER_AUTHORITY
{
    ubyte[6] Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-sid
struct SID
{
    ubyte   Revision;
    ubyte   SubAuthorityCount;
    SID_IDENTIFIER_AUTHORITY IdentifierAuthority;
    uint[1] SubAuthority; // Flexible array
}

union SE_SID
{
    SID       Sid;
    ubyte[68] Buffer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-sid_and_attributes
struct SID_AND_ATTRIBUTES
{
    PSID Sid;
    uint Attributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-sid_and_attributes_hash
struct SID_AND_ATTRIBUTES_HASH
{
    uint                SidCount;
    SID_AND_ATTRIBUTES* SidAttr;
    size_t[32]          Hash;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-acl
struct ACL
{
    ubyte  AclRevision;
    ubyte  Sbz1;
    ushort AclSize;
    ushort AceCount;
    ushort Sbz2;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-ace_header
struct ACE_HEADER
{
    ubyte  AceType;
    ubyte  AceFlags;
    ushort AceSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_allowed_ace
struct ACCESS_ALLOWED_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_denied_ace
struct ACCESS_DENIED_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_audit_ace
struct SYSTEM_AUDIT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_alarm_ace
struct SYSTEM_ALARM_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_resource_attribute_ace
struct SYSTEM_RESOURCE_ATTRIBUTE_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_scoped_policy_id_ace
struct SYSTEM_SCOPED_POLICY_ID_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_mandatory_label_ace
struct SYSTEM_MANDATORY_LABEL_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_PROCESS_TRUST_LABEL_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_ACCESS_FILTER_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_allowed_object_ace
struct ACCESS_ALLOWED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_denied_object_ace
struct ACCESS_DENIED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_audit_object_ace
struct SYSTEM_AUDIT_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_alarm_object_ace
struct SYSTEM_ALARM_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_allowed_callback_ace
struct ACCESS_ALLOWED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_denied_callback_ace
struct ACCESS_DENIED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_audit_callback_ace
struct SYSTEM_AUDIT_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_alarm_callback_ace
struct SYSTEM_ALARM_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_allowed_callback_object_ace
struct ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-access_denied_callback_object_ace
struct ACCESS_DENIED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_audit_callback_object_ace
struct SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-system_alarm_callback_object_ace
struct SYSTEM_ALARM_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    SYSTEM_AUDIT_OBJECT_ACE_FLAGS Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-acl_revision_information
struct ACL_REVISION_INFORMATION
{
    uint AclRevision;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-acl_size_information
struct ACL_SIZE_INFORMATION
{
    uint AceCount;
    uint AclBytesInUse;
    uint AclBytesFree;
}

struct SECURITY_DESCRIPTOR_RELATIVE
{
    ubyte Revision;
    ubyte Sbz1;
    SECURITY_DESCRIPTOR_CONTROL Control;
    uint  Owner;
    uint  Group;
    uint  Sacl;
    uint  Dacl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-security_descriptor
struct SECURITY_DESCRIPTOR
{
    ubyte Revision;
    ubyte Sbz1;
    SECURITY_DESCRIPTOR_CONTROL Control;
    PSID  Owner;
    PSID  Group;
    ACL*  Sacl;
    ACL*  Dacl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-object_type_list
struct OBJECT_TYPE_LIST
{
    ushort Level;
    ushort Sbz;
    GUID*  ObjectType;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-privilege_set
struct PRIVILEGE_SET
{
    uint PrivilegeCount;
    uint Control;
    LUID_AND_ATTRIBUTES[1] Privilege; // Flexible array
}

struct ACCESS_REASONS
{
    uint[32] Data;
}

struct SE_SECURITY_DESCRIPTOR
{
    uint                 Size;
    uint                 Flags;
    PSECURITY_DESCRIPTOR SecurityDescriptor;
}

struct SE_ACCESS_REQUEST
{
    uint              Size;
    SE_SECURITY_DESCRIPTOR* SeSecurityDescriptor;
    uint              DesiredAccess;
    uint              PreviouslyGrantedAccess;
    PSID              PrincipalSelfSid;
    GENERIC_MAPPING*  GenericMapping;
    uint              ObjectTypeListCount;
    OBJECT_TYPE_LIST* ObjectTypeList;
}

struct SE_ACCESS_REPLY
{
    uint            Size;
    uint            ResultListCount;
    uint*           GrantedAccess;
    uint*           AccessStatus;
    ACCESS_REASONS* AccessReason;
    PRIVILEGE_SET** Privileges;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_user
struct TOKEN_USER
{
    SID_AND_ATTRIBUTES User;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_groups
struct TOKEN_GROUPS
{
    uint GroupCount;
    SID_AND_ATTRIBUTES[1] Groups; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_privileges
struct TOKEN_PRIVILEGES
{
    uint PrivilegeCount;
    LUID_AND_ATTRIBUTES[1] Privileges; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_owner
struct TOKEN_OWNER
{
    PSID Owner;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_primary_group
struct TOKEN_PRIMARY_GROUP
{
    PSID PrimaryGroup;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_default_dacl
struct TOKEN_DEFAULT_DACL
{
    ACL* DefaultDacl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_user_claims
struct TOKEN_USER_CLAIMS
{
    void* UserClaims;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_device_claims
struct TOKEN_DEVICE_CLAIMS
{
    void* DeviceClaims;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_groups_and_privileges
struct TOKEN_GROUPS_AND_PRIVILEGES
{
    uint                 SidCount;
    uint                 SidLength;
    SID_AND_ATTRIBUTES*  Sids;
    uint                 RestrictedSidCount;
    uint                 RestrictedSidLength;
    SID_AND_ATTRIBUTES*  RestrictedSids;
    uint                 PrivilegeCount;
    uint                 PrivilegeLength;
    LUID_AND_ATTRIBUTES* Privileges;
    LUID                 AuthenticationId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_linked_token
struct TOKEN_LINKED_TOKEN
{
    HANDLE LinkedToken;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_elevation
struct TOKEN_ELEVATION
{
    uint TokenIsElevated;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_mandatory_label
struct TOKEN_MANDATORY_LABEL
{
    SID_AND_ATTRIBUTES Label;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_mandatory_policy
struct TOKEN_MANDATORY_POLICY
{
    TOKEN_MANDATORY_POLICY_ID Policy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_access_information
struct TOKEN_ACCESS_INFORMATION
{
    SID_AND_ATTRIBUTES_HASH* SidHash;
    SID_AND_ATTRIBUTES_HASH* RestrictedSidHash;
    TOKEN_PRIVILEGES* Privileges;
    LUID              AuthenticationId;
    TOKEN_TYPE        TokenType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    TOKEN_MANDATORY_POLICY MandatoryPolicy;
    uint              Flags;
    uint              AppContainerNumber;
    PSID              PackageSid;
    SID_AND_ATTRIBUTES_HASH* CapabilitiesHash;
    PSID              TrustLevelSid;
    void*             SecurityAttributes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_audit_policy
struct TOKEN_AUDIT_POLICY
{
    ubyte[31] PerUserPolicy;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_source
struct TOKEN_SOURCE
{
    CHAR[8] SourceName;
    LUID    SourceIdentifier;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_statistics
struct TOKEN_STATISTICS
{
    LUID       TokenId;
    LUID       AuthenticationId;
    long       ExpirationTime;
    TOKEN_TYPE TokenType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    uint       DynamicCharged;
    uint       DynamicAvailable;
    uint       GroupCount;
    uint       PrivilegeCount;
    LUID       ModifiedId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_control
struct TOKEN_CONTROL
{
    LUID         TokenId;
    LUID         AuthenticationId;
    LUID         ModifiedId;
    TOKEN_SOURCE TokenSource;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_origin
struct TOKEN_ORIGIN
{
    LUID OriginatingLogonSession;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-token_appcontainer_information
struct TOKEN_APPCONTAINER_INFORMATION
{
    PSID TokenAppContainer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-claim_security_attribute_fqbn_value
struct CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong Version;
    PWSTR Name;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-claim_security_attribute_octet_string_value
struct CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint  ValueLength;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-claim_security_attribute_v1
struct CLAIM_SECURITY_ATTRIBUTE_V1
{
    PWSTR  Name;
    CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE ValueType;
    ushort Reserved;
    uint   Flags;
    uint   ValueCount;
    union Values
    {
        long*  pInt64;
        ulong* pUint64;
        PWSTR* ppString;
        CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE* pFqbn;
        CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* pOctetString;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-claim_security_attribute_relative_v1
struct CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
{
    uint   Name;
    CLAIM_SECURITY_ATTRIBUTE_VALUE_TYPE ValueType;
    ushort Reserved;
    CLAIM_SECURITY_ATTRIBUTE_FLAGS Flags;
    uint   ValueCount;
    union Values
    {
        uint[1] pInt64;
        uint[1] pUint64;
        uint[1] ppString;
        uint[1] pFqbn;
        uint[1] pOctetString; // Flexible array
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-claim_security_attributes_information
struct CLAIM_SECURITY_ATTRIBUTES_INFORMATION
{
    ushort Version;
    ushort Reserved;
    uint   AttributeCount;
    union Attribute
    {
        CLAIM_SECURITY_ATTRIBUTE_V1* pAttributeV1;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-security_quality_of_service
struct SECURITY_QUALITY_OF_SERVICE
{
    uint    Length;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    ubyte   ContextTrackingMode;
    BOOLEAN EffectiveOnly;
}

struct SE_IMPERSONATION_STATE
{
    void*   Token;
    BOOLEAN CopyOnOpen;
    BOOLEAN EffectiveOnly;
    SECURITY_IMPERSONATION_LEVEL Level;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-security_capabilities
struct SECURITY_CAPABILITIES
{
    PSID                AppContainerSid;
    SID_AND_ATTRIBUTES* Capabilities;
    uint                CapabilityCount;
    uint                Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winnt/ns-winnt-quota_limits
struct QUOTA_LIMITS
{
    size_t PagedPoolLimit;
    size_t NonPagedPoolLimit;
    size_t MinimumWorkingSetSize;
    size_t MaximumWorkingSetSize;
    size_t PagefileLimit;
    long   TimeLimit;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheck(PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, 
                 GENERIC_MAPPING* GenericMapping, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/PRIVILEGE_SET* PrivilegeSet, 
                 uint* PrivilegeSetLength, uint* GrantedAccess, BOOL* AccessStatus);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckAndAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, PWSTR ObjectTypeName, PWSTR ObjectName, 
                               PSECURITY_DESCRIPTOR SecurityDescriptor, uint DesiredAccess, 
                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                               BOOL* AccessStatus, BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckByType(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, HANDLE ClientToken, 
                       uint DesiredAccess, OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                       GENERIC_MAPPING* GenericMapping, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PRIVILEGE_SET* PrivilegeSet, 
                       uint* PrivilegeSetLength, uint* GrantedAccess, BOOL* AccessStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultList(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID PrincipalSelfSid, 
                                 HANDLE ClientToken, uint DesiredAccess, OBJECT_TYPE_LIST* ObjectTypeList, 
                                 uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PRIVILEGE_SET* PrivilegeSet, 
                                 uint* PrivilegeSetLength, uint* GrantedAccessList, uint* AccessStatusList);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeAndAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, const(PWSTR) ObjectTypeName, 
                                     const(PWSTR) ObjectName, PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                     PSID PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, 
                                     uint Flags, OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                     GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                                     BOOL* AccessStatus, BOOL* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, 
                                               const(PWSTR) ObjectTypeName, const(PWSTR) ObjectName, 
                                               PSECURITY_DESCRIPTOR SecurityDescriptor, PSID PrincipalSelfSid, 
                                               uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                               OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, 
                                               uint* GrantedAccessList, uint* AccessStatusList, 
                                               BOOL* pfGenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleW(const(PWSTR) SubsystemName, void* HandleId, 
                                                       HANDLE ClientToken, const(PWSTR) ObjectTypeName, 
                                                       const(PWSTR) ObjectName, 
                                                       PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                                       PSID PrincipalSelfSid, uint DesiredAccess, 
                                                       AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                                       OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                                       GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, 
                                                       uint* GrantedAccessList, uint* AccessStatusList, 
                                                       BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedAce(ACL* pAcl, ACE_REVISION dwAceRevision, uint AccessMask, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedAceEx(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessAllowedObjectAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, 
                               GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedAce(ACL* pAcl, ACE_REVISION dwAceRevision, uint AccessMask, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedAceEx(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAccessDeniedObjectAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, 
                              GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAce(ACL* pAcl, ACE_REVISION dwAceRevision, uint dwStartingAceIndex, 
            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pAceList, 
            uint nAceListLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessAce(ACL* pAcl, ACE_REVISION dwAceRevision, uint dwAccessMask, PSID pSid, BOOL bAuditSuccess, 
                       BOOL bAuditFailure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessAceEx(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint dwAccessMask, PSID pSid, 
                         BOOL bAuditSuccess, BOOL bAuditFailure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AddAuditAccessObjectAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, 
                             GUID* ObjectTypeGuid, GUID* InheritedObjectTypeGuid, PSID pSid, BOOL bAuditSuccess, 
                             BOOL bAuditFailure);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
BOOL AddMandatoryAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint MandatoryPolicy, 
                     PSID pLabelSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL AddResourceAttributeAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, PSID pSid, 
                             CLAIM_SECURITY_ATTRIBUTES_INFORMATION* pAttributeInfo, uint* pReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL AddScopedPolicyIDAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, uint AccessMask, PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AdjustTokenGroups(HANDLE TokenHandle, BOOL ResetToDefault, TOKEN_GROUPS* NewState, uint BufferLength, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/TOKEN_GROUPS* PreviousState, 
                       uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AdjustTokenPrivileges(HANDLE TokenHandle, BOOL DisableAllPrivileges, TOKEN_PRIVILEGES* NewState, 
                           uint BufferLength, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/TOKEN_PRIVILEGES* PreviousState, 
                           uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AllocateAndInitializeSid(SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount, 
                              uint nSubAuthority0, uint nSubAuthority1, uint nSubAuthority2, uint nSubAuthority3, 
                              uint nSubAuthority4, uint nSubAuthority5, uint nSubAuthority6, uint nSubAuthority7, 
                              PSID* pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AllocateLocallyUniqueId(LUID* Luid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AreAllAccessesGranted(uint GrantedAccess, uint DesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AreAnyAccessesGranted(uint GrantedAccess, uint DesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CheckTokenMembership(HANDLE TokenHandle, PSID SidToCheck, BOOL* IsMember);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL CheckTokenCapability(HANDLE TokenHandle, PSID CapabilitySidToCheck, BOOL* HasCapability);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/securitybaseapi/nf-securitybaseapi-getappcontainerace
@DllImport("KERNEL32.dll")
BOOL GetAppContainerAce(ACL* Acl, uint StartingAceIndex, void** AppContainerAce, uint* AppContainerAceIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows8.0))], [])
@DllImport("KERNEL32.dll")
BOOL CheckTokenMembershipEx(HANDLE TokenHandle, PSID SidToCheck, uint Flags, BOOL* IsMember);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ConvertToAutoInheritPrivateObjectSecurity(PSECURITY_DESCRIPTOR ParentDescriptor, 
                                               PSECURITY_DESCRIPTOR CurrentSecurityDescriptor, 
                                               PSECURITY_DESCRIPTOR* NewSecurityDescriptor, GUID* ObjectType, 
                                               BOOLEAN IsDirectoryObject, GENERIC_MAPPING* GenericMapping);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CopySid(uint nDestinationSidLength, 
             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/PSID pDestinationSid, 
             PSID pSourceSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurity(PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CreatorDescriptor, 
                                 PSECURITY_DESCRIPTOR* NewDescriptor, BOOL IsDirectoryObject, HANDLE Token, 
                                 GENERIC_MAPPING* GenericMapping);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurityEx(PSECURITY_DESCRIPTOR ParentDescriptor, PSECURITY_DESCRIPTOR CreatorDescriptor, 
                                   PSECURITY_DESCRIPTOR* NewDescriptor, GUID* ObjectType, BOOL IsContainerObject, 
                                   SECURITY_AUTO_INHERIT_FLAGS AutoInheritFlags, HANDLE Token, 
                                   GENERIC_MAPPING* GenericMapping);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CreatePrivateObjectSecurityWithMultipleInheritance(PSECURITY_DESCRIPTOR ParentDescriptor, 
                                                        PSECURITY_DESCRIPTOR CreatorDescriptor, 
                                                        PSECURITY_DESCRIPTOR* NewDescriptor, GUID** ObjectTypes, 
                                                        uint GuidCount, BOOL IsContainerObject, 
                                                        SECURITY_AUTO_INHERIT_FLAGS AutoInheritFlags, HANDLE Token, 
                                                        GENERIC_MAPPING* GenericMapping);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CreateRestrictedToken(HANDLE ExistingTokenHandle, CREATE_RESTRICTED_TOKEN_FLAGS Flags, uint DisableSidCount, 
                           SID_AND_ATTRIBUTES* SidsToDisable, uint DeletePrivilegeCount, 
                           LUID_AND_ATTRIBUTES* PrivilegesToDelete, uint RestrictedSidCount, 
                           SID_AND_ATTRIBUTES* SidsToRestrict, HANDLE* NewTokenHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL CreateWellKnownSid(WELL_KNOWN_SID_TYPE WellKnownSidType, PSID DomainSid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSID pSid, 
                        uint* cbSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EqualDomainSid(PSID pSid1, PSID pSid2, BOOL* pfEqual);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DeleteAce(ACL* pAcl, uint dwAceIndex);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DestroyPrivateObjectSecurity(PSECURITY_DESCRIPTOR* ObjectDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DuplicateToken(HANDLE ExistingTokenHandle, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                    HANDLE* DuplicateTokenHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL DuplicateTokenEx(HANDLE hExistingToken, TOKEN_ACCESS_MASK dwDesiredAccess, 
                      SECURITY_ATTRIBUTES* lpTokenAttributes, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                      TOKEN_TYPE TokenType, HANDLE* phNewToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EqualPrefixSid(PSID pSid1, PSID pSid2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL EqualSid(PSID pSid1, PSID pSid2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL FindFirstFreeAce(ACL* pAcl, void** pAce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void* FreeSid(PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetAce(ACL* pAcl, uint dwAceIndex, void** pAce);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetAclInformation(ACL* pAcl, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pAclInformation, 
                       uint nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32.dll")
BOOL GetFileSecurityW(const(PWSTR) lpFileName, uint RequestedInformation, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                      uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetKernelObjectSecurity(HANDLE Handle, uint RequestedInformation, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                             uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint GetLengthSid(PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetPrivateObjectSecurity(PSECURITY_DESCRIPTOR ObjectDescriptor, 
                              OBJECT_SECURITY_INFORMATION SecurityInformation, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR ResultantDescriptor, 
                              uint DescriptorLength, uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorControl(PSECURITY_DESCRIPTOR pSecurityDescriptor, ushort* pControl, uint* lpdwRevision);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorDacl(PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL* lpbDaclPresent, ACL** pDacl, 
                               BOOL* lpbDaclDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorGroup(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID* pGroup, BOOL* lpbGroupDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint GetSecurityDescriptorLength(PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorOwner(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID* pOwner, BOOL* lpbOwnerDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint GetSecurityDescriptorRMControl(PSECURITY_DESCRIPTOR SecurityDescriptor, ubyte* RMControl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetSecurityDescriptorSacl(PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL* lpbSaclPresent, ACL** pSacl, 
                               BOOL* lpbSaclDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
SID_IDENTIFIER_AUTHORITY* GetSidIdentifierAuthority(PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint GetSidLengthRequired(ubyte nSubAuthorityCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint* GetSidSubAuthority(PSID pSid, uint nSubAuthority);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
ubyte* GetSidSubAuthorityCount(PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* TokenInformation, 
                         uint TokenInformationLength, uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetWindowsAccountDomainSid(PSID pSid, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSID pDomainSid, 
                                uint* cbDomainSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ImpersonateAnonymousToken(HANDLE ThreadHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ImpersonateLoggedOnUser(HANDLE hToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ImpersonateSelf(SECURITY_IMPERSONATION_LEVEL ImpersonationLevel);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitializeAcl(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ACL* pAcl, 
                   uint nAclLength, ACE_REVISION dwAclRevision);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitializeSecurityDescriptor(PSECURITY_DESCRIPTOR pSecurityDescriptor, uint dwRevision);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL InitializeSid(PSID Sid, SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL IsTokenRestricted(HANDLE TokenHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL IsValidAcl(ACL* pAcl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL IsValidSecurityDescriptor(PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL IsValidSid(PSID pSid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL IsWellKnownSid(PSID pSid, WELL_KNOWN_SID_TYPE WellKnownSidType);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL MakeAbsoluteSD(PSECURITY_DESCRIPTOR pSelfRelativeSecurityDescriptor, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSECURITY_DESCRIPTOR pAbsoluteSecurityDescriptor, 
                    uint* lpdwAbsoluteSecurityDescriptorSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ACL* pDacl, 
                    uint* lpdwDaclSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/ACL* pSacl, 
                    uint* lpdwSaclSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(8)))])*/PSID pOwner, 
                    uint* lpdwOwnerSize, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(10)))])*/PSID pPrimaryGroup, 
                    uint* lpdwPrimaryGroupSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL MakeSelfRelativeSD(PSECURITY_DESCRIPTOR pAbsoluteSecurityDescriptor, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/PSECURITY_DESCRIPTOR pSelfRelativeSecurityDescriptor, 
                        uint* lpdwBufferLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
void MapGenericMask(uint* AccessMask, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32.dll")
BOOL ObjectCloseAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectDeleteAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectOpenAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, PWSTR ObjectTypeName, PWSTR ObjectName, 
                           PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, 
                           uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, BOOL AccessGranted, 
                           BOOL* GenerateOnClose);

@DllImport("ADVAPI32.dll")
BOOL ObjectPrivilegeAuditAlarmW(const(PWSTR) SubsystemName, void* HandleId, HANDLE ClientToken, uint DesiredAccess, 
                                PRIVILEGE_SET* Privileges, BOOL AccessGranted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL PrivilegeCheck(HANDLE ClientToken, PRIVILEGE_SET* RequiredPrivileges, BOOL* pfResult);

@DllImport("ADVAPI32.dll")
BOOL PrivilegedServiceAuditAlarmW(const(PWSTR) SubsystemName, const(PWSTR) ServiceName, HANDLE ClientToken, 
                                  PRIVILEGE_SET* Privileges, BOOL AccessGranted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void QuerySecurityAccessMask(OBJECT_SECURITY_INFORMATION SecurityInformation, uint* DesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL RevertToSelf();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetAclInformation(ACL* pAcl, 
                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pAclInformation, 
                       uint nAclInformationLength, ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32.dll")
BOOL SetFileSecurityW(const(PWSTR) lpFileName, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                      PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetKernelObjectSecurity(HANDLE Handle, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                             PSECURITY_DESCRIPTOR SecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetPrivateObjectSecurity(OBJECT_SECURITY_INFORMATION SecurityInformation, 
                              PSECURITY_DESCRIPTOR ModificationDescriptor, 
                              PSECURITY_DESCRIPTOR* ObjectsSecurityDescriptor, GENERIC_MAPPING* GenericMapping, 
                              HANDLE Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetPrivateObjectSecurityEx(OBJECT_SECURITY_INFORMATION SecurityInformation, 
                                PSECURITY_DESCRIPTOR ModificationDescriptor, 
                                PSECURITY_DESCRIPTOR* ObjectsSecurityDescriptor, 
                                SECURITY_AUTO_INHERIT_FLAGS AutoInheritFlags, GENERIC_MAPPING* GenericMapping, 
                                HANDLE Token);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("ADVAPI32.dll")
void SetSecurityAccessMask(OBJECT_SECURITY_INFORMATION SecurityInformation, uint* DesiredAccess);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorControl(PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                                  SECURITY_DESCRIPTOR_CONTROL ControlBitsOfInterest, 
                                  SECURITY_DESCRIPTOR_CONTROL ControlBitsToSet);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorDacl(PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL bDaclPresent, ACL* pDacl, 
                               BOOL bDaclDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorGroup(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pGroup, BOOL bGroupDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorOwner(PSECURITY_DESCRIPTOR pSecurityDescriptor, PSID pOwner, BOOL bOwnerDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
uint SetSecurityDescriptorRMControl(PSECURITY_DESCRIPTOR SecurityDescriptor, ubyte* RMControl);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetSecurityDescriptorSacl(PSECURITY_DESCRIPTOR pSecurityDescriptor, BOOL bSaclPresent, ACL* pSacl, 
                               BOOL bSaclDefaulted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* TokenInformation, 
                         uint TokenInformationLength);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/securitybaseapi/nf-securitybaseapi-setcachedsigninglevel
@DllImport("KERNEL32.dll")
BOOL SetCachedSigningLevel(HANDLE* SourceFiles, uint SourceFileCount, uint Flags, HANDLE TargetFile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/securitybaseapi/nf-securitybaseapi-getcachedsigninglevel
@DllImport("KERNEL32.dll")
BOOL GetCachedSigningLevel(HANDLE File, uint* Flags, uint* SigningLevel, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* Thumbprint, 
                           uint* ThumbprintSize, uint* ThumbprintAlgorithm);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/securitybaseapi/nf-securitybaseapi-derivecapabilitysidsfromname
@DllImport("api-ms-win-security-base-l1-2-2.dll")
BOOL DeriveCapabilitySidsFromName(const(PWSTR) CapName, PSID** CapabilityGroupSids, uint* CapabilityGroupSidCount, 
                                  PSID** CapabilitySids, uint* CapabilitySidCount);

@DllImport("ntdll.dll")
BOOLEAN RtlNormalizeSecurityDescriptor(PSECURITY_DESCRIPTOR* SecurityDescriptor, uint SecurityDescriptorLength, 
                                       PSECURITY_DESCRIPTOR* NewSecurityDescriptor, 
                                       uint* NewSecurityDescriptorLength, BOOLEAN CheckOnly);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL SetUserObjectSecurity(HANDLE hObj, OBJECT_SECURITY_INFORMATION* pSIRequested, PSECURITY_DESCRIPTOR pSID);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("USER32.dll")
BOOL GetUserObjectSecurity(HANDLE hObj, uint* pSIRequested, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSID, 
                           uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckAndAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, PSTR ObjectTypeName, PSTR ObjectName, 
                               PSECURITY_DESCRIPTOR SecurityDescriptor, uint DesiredAccess, 
                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                               BOOL* AccessStatus, BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeAndAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, const(PSTR) ObjectTypeName, 
                                     const(PSTR) ObjectName, PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                     PSID PrincipalSelfSid, uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, 
                                     uint Flags, OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                     GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                                     BOOL* AccessStatus, BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, 
                                               const(PSTR) ObjectTypeName, const(PSTR) ObjectName, 
                                               PSECURITY_DESCRIPTOR SecurityDescriptor, PSID PrincipalSelfSid, 
                                               uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                               OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, 
                                               uint* GrantedAccess, uint* AccessStatusList, BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleA(const(PSTR) SubsystemName, void* HandleId, 
                                                       HANDLE ClientToken, const(PSTR) ObjectTypeName, 
                                                       const(PSTR) ObjectName, 
                                                       PSECURITY_DESCRIPTOR SecurityDescriptor, 
                                                       PSID PrincipalSelfSid, uint DesiredAccess, 
                                                       AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                                       OBJECT_TYPE_LIST* ObjectTypeList, uint ObjectTypeListLength, 
                                                       GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, 
                                                       uint* GrantedAccess, uint* AccessStatusList, 
                                                       BOOL* pfGenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ObjectOpenAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, PSTR ObjectTypeName, PSTR ObjectName, 
                           PSECURITY_DESCRIPTOR pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, 
                           uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, BOOL AccessGranted, 
                           BOOL* GenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ObjectPrivilegeAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, HANDLE ClientToken, uint DesiredAccess, 
                                PRIVILEGE_SET* Privileges, BOOL AccessGranted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ObjectCloseAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, BOOL GenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL ObjectDeleteAuditAlarmA(const(PSTR) SubsystemName, void* HandleId, BOOL GenerateOnClose);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL PrivilegedServiceAuditAlarmA(const(PSTR) SubsystemName, const(PSTR) ServiceName, HANDLE ClientToken, 
                                  PRIVILEGE_SET* Privileges, BOOL AccessGranted);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.1))], [])
@DllImport("ADVAPI32.dll")
BOOL AddConditionalAce(ACL* pAcl, ACE_REVISION dwAceRevision, ACE_FLAGS AceFlags, ubyte AceType, uint AccessMask, 
                       PSID pSid, 
                       /*PARAM ATTR: NotNullTerminatedAttribute : CustomAttributeSig([], [])*/PWSTR ConditionStr, 
                       uint* ReturnLength);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL SetFileSecurityA(const(PSTR) lpFileName, OBJECT_SECURITY_INFORMATION SecurityInformation, 
                      PSECURITY_DESCRIPTOR pSecurityDescriptor);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL GetFileSecurityA(const(PSTR) lpFileName, uint RequestedInformation, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSECURITY_DESCRIPTOR pSecurityDescriptor, 
                      uint nLength, uint* lpnLengthNeeded);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupAccountSidA(const(PSTR) lpSystemName, PSID Sid, PSTR Name, uint* cchName, PSTR ReferencedDomainName, 
                       uint* cchReferencedDomainName, SID_NAME_USE* peUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupAccountSidW(const(PWSTR) lpSystemName, PSID Sid, PWSTR Name, uint* cchName, PWSTR ReferencedDomainName, 
                       uint* cchReferencedDomainName, SID_NAME_USE* peUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupAccountNameA(const(PSTR) lpSystemName, const(PSTR) lpAccountName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSID Sid, 
                        uint* cbSid, PSTR ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupAccountNameW(const(PWSTR) lpSystemName, const(PWSTR) lpAccountName, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PSID Sid, 
                        uint* cbSid, PWSTR ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeValueA(const(PSTR) lpSystemName, const(PSTR) lpName, LUID* lpLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeValueW(const(PWSTR) lpSystemName, const(PWSTR) lpName, LUID* lpLuid);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeNameA(const(PSTR) lpSystemName, LUID* lpLuid, PSTR lpName, uint* cchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeNameW(const(PWSTR) lpSystemName, LUID* lpLuid, PWSTR lpName, uint* cchName);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeDisplayNameA(const(PSTR) lpSystemName, const(PSTR) lpName, PSTR lpDisplayName, 
                                 uint* cchDisplayName, uint* lpLanguageId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LookupPrivilegeDisplayNameW(const(PWSTR) lpSystemName, const(PWSTR) lpName, PWSTR lpDisplayName, 
                                 uint* cchDisplayName, uint* lpLanguageId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LogonUserA(const(PSTR) lpszUsername, const(PSTR) lpszDomain, const(PSTR) lpszPassword, 
                LOGON32_LOGON dwLogonType, LOGON32_PROVIDER dwLogonProvider, HANDLE* phToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LogonUserW(const(PWSTR) lpszUsername, const(PWSTR) lpszDomain, const(PWSTR) lpszPassword, 
                LOGON32_LOGON dwLogonType, LOGON32_PROVIDER dwLogonProvider, HANDLE* phToken);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LogonUserExA(const(PSTR) lpszUsername, const(PSTR) lpszDomain, const(PSTR) lpszPassword, 
                  LOGON32_LOGON dwLogonType, LOGON32_PROVIDER dwLogonProvider, HANDLE* phToken, PSID* ppLogonSid, 
                  void** ppProfileBuffer, uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ADVAPI32.dll")
BOOL LogonUserExW(const(PWSTR) lpszUsername, const(PWSTR) lpszDomain, const(PWSTR) lpszPassword, 
                  LOGON32_LOGON dwLogonType, LOGON32_PROVIDER dwLogonProvider, HANDLE* phToken, PSID* ppLogonSid, 
                  void** ppProfileBuffer, uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
@DllImport("ntdll.dll")
NTSTATUS RtlConvertSidToUnicodeString(UNICODE_STRING* UnicodeString, PSID Sid, BOOLEAN AllocateDestinationString);


