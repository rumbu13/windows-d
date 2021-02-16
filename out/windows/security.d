module windows.security;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IBindCtx, IDataObject, IEnumUnknown, IUnknown;
public import windows.controls : HPROPSHEETPAGE, PROPSHEETPAGEA, PROPSHEETPAGEW;
public import windows.gdi : HBITMAP, HICON;
public import windows.kernel : LIST_ENTRY, LUID;
public import windows.passwordmanagement : CYPHER_BLOCK, LM_OWF_PASSWORD;
public import windows.structuredstorage : PROPVARIANT;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LARGE_INTEGER, LPTHREAD_START_ROUTINE, LSTATUS,
                                       NTSTATUS, SCARD_IO_REQUEST, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : DLGPROC, DLGTEMPLATE, HWND, LPARAM, WPARAM;
public import windows.windowsprogramming : FILETIME, HKEY, OBJECT_ATTRIBUTES, STRING, SYSTEMTIME;
public import windows.windowspropertiessystem : PROPERTYKEY;
public import windows.windowsstationsanddesktops : HDESK;

extern(Windows):


// Enums


enum : int
{
    MsaInfoLevel0   = 0x00000000,
    MsaInfoLevelMax = 0x00000001,
}
alias MSA_INFO_LEVEL = int;

enum : int
{
    MsaInfoNotExist      = 0x00000001,
    MsaInfoNotService    = 0x00000002,
    MsaInfoCannotInstall = 0x00000003,
    MsaInfoCanInstall    = 0x00000004,
    MsaInfoInstalled     = 0x00000005,
}
alias MSA_INFO_STATE = int;

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
alias SID_NAME_USE = int;

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
}
alias WELL_KNOWN_SID_TYPE = int;

enum : int
{
    AclRevisionInformation = 0x00000001,
    AclSizeInformation     = 0x00000002,
}
alias ACL_INFORMATION_CLASS = int;

enum : int
{
    AuditEventObjectAccess           = 0x00000000,
    AuditEventDirectoryServiceAccess = 0x00000001,
}
alias AUDIT_EVENT_TYPE = int;

enum : int
{
    SecurityAnonymous      = 0x00000000,
    SecurityIdentification = 0x00000001,
    SecurityImpersonation  = 0x00000002,
    SecurityDelegation     = 0x00000003,
}
alias SECURITY_IMPERSONATION_LEVEL = int;

enum : int
{
    TokenPrimary       = 0x00000001,
    TokenImpersonation = 0x00000002,
}
alias TOKEN_TYPE = int;

enum : int
{
    TokenElevationTypeDefault = 0x00000001,
    TokenElevationTypeFull    = 0x00000002,
    TokenElevationTypeLimited = 0x00000003,
}
alias TOKEN_ELEVATION_TYPE = int;

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
    TokenOriginatingProcessTrustLevel    = 0x00000030,
    MaxTokenInfoClass                    = 0x00000031,
}
alias TOKEN_INFORMATION_CLASS = int;

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
alias MANDATORY_LEVEL = int;

enum : int
{
    BCRYPT_ECC_PRIME_SHORT_WEIERSTRASS_CURVE = 0x00000001,
    BCRYPT_ECC_PRIME_TWISTED_EDWARDS_CURVE   = 0x00000002,
    BCRYPT_ECC_PRIME_MONTGOMERY_CURVE        = 0x00000003,
}
alias ECC_CURVE_TYPE_ENUM = int;

enum : int
{
    BCRYPT_NO_CURVE_GENERATION_ALG_ID = 0x00000000,
}
alias ECC_CURVE_ALG_ID_ENUM = int;

enum : int
{
    DSA_HASH_ALGORITHM_SHA1   = 0x00000000,
    DSA_HASH_ALGORITHM_SHA256 = 0x00000001,
    DSA_HASH_ALGORITHM_SHA512 = 0x00000002,
}
alias HASHALGORITHM_ENUM = int;

enum : int
{
    DSA_FIPS186_2 = 0x00000000,
    DSA_FIPS186_3 = 0x00000001,
}
alias DSAFIPSVERSION_ENUM = int;

enum : int
{
    BCRYPT_HASH_OPERATION_HASH_DATA   = 0x00000001,
    BCRYPT_HASH_OPERATION_FINISH_HASH = 0x00000002,
}
alias BCRYPT_HASH_OPERATION_TYPE = int;

enum : int
{
    BCRYPT_OPERATION_TYPE_HASH = 0x00000001,
}
alias BCRYPT_MULTI_OPERATION_TYPE = int;

enum CertKeyType : uint
{
    KeyTypeOther             = 0x00000000,
    KeyTypeVirtualSmartCard  = 0x00000001,
    KeyTypePhysicalSmartCard = 0x00000002,
    KeyTypePassport          = 0x00000003,
    KeyTypePassportRemote    = 0x00000004,
    KeyTypePassportSmartCard = 0x00000005,
    KeyTypeHardware          = 0x00000006,
    KeyTypeSoftware          = 0x00000007,
    KeyTypeSelfSigned        = 0x00000008,
}

enum : int
{
    RSR_MATCH_TYPE_READER_AND_CONTAINER = 0x00000001,
    RSR_MATCH_TYPE_SERIAL_NUMBER        = 0x00000002,
    RSR_MATCH_TYPE_ALL_CARDS            = 0x00000003,
}
alias READER_SEL_REQUEST_MATCH_TYPE = int;

enum : int
{
    SC_ACTION_NONE        = 0x00000000,
    SC_ACTION_RESTART     = 0x00000001,
    SC_ACTION_REBOOT      = 0x00000002,
    SC_ACTION_RUN_COMMAND = 0x00000003,
    SC_ACTION_OWN_RESTART = 0x00000004,
}
alias SC_ACTION_TYPE = int;

enum : int
{
    SC_STATUS_PROCESS_INFO = 0x00000000,
}
alias SC_STATUS_TYPE = int;

enum : int
{
    SC_ENUM_PROCESS_INFO = 0x00000000,
}
alias SC_ENUM_TYPE = int;

enum : int
{
    SC_EVENT_DATABASE_CHANGE = 0x00000000,
    SC_EVENT_PROPERTY_CHANGE = 0x00000001,
    SC_EVENT_STATUS_CHANGE   = 0x00000002,
}
alias SC_EVENT_TYPE = int;

enum : int
{
    ServiceRegistryStateParameters = 0x00000000,
    ServiceRegistryStatePersistent = 0x00000001,
    MaxServiceRegistryStateType    = 0x00000002,
}
alias SERVICE_REGISTRY_STATE_TYPE = int;

enum : int
{
    ServiceDirectoryPersistentState = 0x00000000,
    ServiceDirectoryTypeMax         = 0x00000001,
}
alias SERVICE_DIRECTORY_TYPE = int;

enum : int
{
    AccountDomainInformation = 0x00000005,
    DnsDomainInformation     = 0x0000000c,
}
alias LSA_LOOKUP_DOMAIN_INFO_CLASS = int;

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
alias SECURITY_LOGON_TYPE = int;

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
alias SE_ADT_PARAMETER_TYPE = int;

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
alias POLICY_AUDIT_EVENT_TYPE = int;

enum : int
{
    PolicyServerRoleBackup  = 0x00000002,
    PolicyServerRolePrimary = 0x00000003,
}
alias POLICY_LSA_SERVER_ROLE = int;

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
    PolicyLastEntry                     = 0x00000010,
}
alias POLICY_INFORMATION_CLASS = int;

enum : int
{
    PolicyDomainEfsInformation            = 0x00000002,
    PolicyDomainKerberosTicketInformation = 0x00000003,
}
alias POLICY_DOMAIN_INFORMATION_CLASS = int;

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
alias POLICY_NOTIFICATION_INFORMATION_CLASS = int;

enum : int
{
    TrustedDomainNameInformation          = 0x00000001,
    TrustedControllersInformation         = 0x00000002,
    TrustedPosixOffsetInformation         = 0x00000003,
    TrustedPasswordInformation            = 0x00000004,
    TrustedDomainInformationBasic         = 0x00000005,
    TrustedDomainInformationEx            = 0x00000006,
    TrustedDomainAuthInformation          = 0x00000007,
    TrustedDomainFullInformation          = 0x00000008,
    TrustedDomainAuthInformationInternal  = 0x00000009,
    TrustedDomainFullInformationInternal  = 0x0000000a,
    TrustedDomainInformationEx2Internal   = 0x0000000b,
    TrustedDomainFullInformation2Internal = 0x0000000c,
    TrustedDomainSupportedEncryptionTypes = 0x0000000d,
}
alias TRUSTED_INFORMATION_CLASS = int;

enum : int
{
    ForestTrustTopLevelName   = 0x00000000,
    ForestTrustTopLevelNameEx = 0x00000001,
    ForestTrustDomainInfo     = 0x00000002,
    ForestTrustRecordTypeLast = 0x00000002,
}
alias LSA_FOREST_TRUST_RECORD_TYPE = int;

enum : int
{
    CollisionTdo   = 0x00000000,
    CollisionXref  = 0x00000001,
    CollisionOther = 0x00000002,
}
alias LSA_FOREST_TRUST_COLLISION_RECORD_TYPE = int;

enum : int
{
    NegEnumPackagePrefixes = 0x00000000,
    NegGetCallerName       = 0x00000001,
    NegTransferCredentials = 0x00000002,
    NegMsgReserved1        = 0x00000003,
    NegCallPackageMax      = 0x00000004,
}
alias NEGOTIATE_MESSAGES = int;

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
alias MSV1_0_LOGON_SUBMIT_TYPE = int;

enum : int
{
    MsV1_0InteractiveProfile = 0x00000002,
    MsV1_0Lm20LogonProfile   = 0x00000003,
    MsV1_0SmartCardProfile   = 0x00000004,
}
alias MSV1_0_PROFILE_BUFFER_TYPE = int;

enum : int
{
    InvalidCredKey            = 0x00000000,
    DeprecatedIUMCredKey      = 0x00000001,
    DomainUserCredKey         = 0x00000002,
    LocalUserCredKey          = 0x00000003,
    ExternallySuppliedCredKey = 0x00000004,
}
alias MSV1_0_CREDENTIAL_KEY_TYPE = int;

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
alias MSV1_0_AVID = int;

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
alias MSV1_0_PROTOCOL_MESSAGE_TYPE = int;

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
alias KERB_LOGON_SUBMIT_TYPE = int;

enum : int
{
    KerbInteractiveProfile = 0x00000002,
    KerbSmartCardProfile   = 0x00000004,
    KerbTicketProfile      = 0x00000006,
}
alias KERB_PROFILE_BUFFER_TYPE = int;

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
}
alias KERB_PROTOCOL_MESSAGE_TYPE = int;

enum : int
{
    CertHashInfo = 0x00000001,
}
alias KERB_CERTIFICATE_INFO_TYPE = int;

enum : int
{
    Pku2uCertificateS4ULogon = 0x0000000e,
}
alias PKU2U_LOGON_SUBMIT_TYPE = int;

enum : int
{
    SecApplicationProtocolNegotiationExt_None = 0x00000000,
    SecApplicationProtocolNegotiationExt_NPN  = 0x00000001,
    SecApplicationProtocolNegotiationExt_ALPN = 0x00000002,
}
alias SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT = int;

enum : int
{
    SecTrafficSecret_None   = 0x00000000,
    SecTrafficSecret_Client = 0x00000001,
    SecTrafficSecret_Server = 0x00000002,
}
alias SEC_TRAFFIC_SECRET_TYPE = int;

enum : int
{
    SecPkgCredClass_None              = 0x00000000,
    SecPkgCredClass_Ephemeral         = 0x0000000a,
    SecPkgCredClass_PersistedGeneric  = 0x00000014,
    SecPkgCredClass_PersistedSpecific = 0x0000001e,
    SecPkgCredClass_Explicit          = 0x00000028,
}
alias SECPKG_CRED_CLASS = int;

enum : int
{
    SecPkgAttrLastClientTokenYes   = 0x00000000,
    SecPkgAttrLastClientTokenNo    = 0x00000001,
    SecPkgAttrLastClientTokenMaybe = 0x00000002,
}
alias SECPKG_ATTR_LCT_STATUS = int;

enum : int
{
    SecApplicationProtocolNegotiationStatus_None               = 0x00000000,
    SecApplicationProtocolNegotiationStatus_Success            = 0x00000001,
    SecApplicationProtocolNegotiationStatus_SelectedClientOnly = 0x00000002,
}
alias SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS = int;

enum SecDelegationType : int
{
    SecFull      = 0x00000000,
    SecService   = 0x00000001,
    SecTree      = 0x00000002,
    SecDirectory = 0x00000003,
    SecObject    = 0x00000004,
}

enum : int
{
    Sasl_AuthZIDForbidden = 0x00000000,
    Sasl_AuthZIDProcessed = 0x00000001,
}
alias SASL_AUTHZID_STATE = int;

enum : int
{
    CertCredential               = 0x00000001,
    UsernameTargetCredential     = 0x00000002,
    BinaryBlobCredential         = 0x00000003,
    UsernameForPackedCredentials = 0x00000004,
    BinaryBlobForSystem          = 0x00000005,
}
alias CRED_MARSHAL_TYPE = int;

enum : int
{
    CredUnprotected         = 0x00000000,
    CredUserProtection      = 0x00000001,
    CredTrustedProtection   = 0x00000002,
    CredForSystemProtection = 0x00000003,
}
alias CRED_PROTECTION_TYPE = int;

enum : int
{
    LsaTokenInformationNull = 0x00000000,
    LsaTokenInformationV1   = 0x00000001,
    LsaTokenInformationV2   = 0x00000002,
    LsaTokenInformationV3   = 0x00000003,
}
alias LSA_TOKEN_INFORMATION_TYPE = int;

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
alias SECPKG_EXTENDED_INFORMATION_CLASS = int;

enum : int
{
    SecPkgCallPackageMinMessage          = 0x00000400,
    SecPkgCallPackagePinDcMessage        = 0x00000400,
    SecPkgCallPackageUnpinAllDcsMessage  = 0x00000401,
    SecPkgCallPackageTransferCredMessage = 0x00000402,
    SecPkgCallPackageMaxMessage          = 0x00000402,
}
alias SECPKG_CALL_PACKAGE_MESSAGE_TYPE = int;

enum : int
{
    SecSessionPrimaryCred = 0x00000000,
}
alias SECPKG_SESSIONINFO_TYPE = int;

enum : int
{
    SecNameSamCompatible = 0x00000000,
    SecNameAlternateId   = 0x00000001,
    SecNameFlat          = 0x00000002,
    SecNameDN            = 0x00000003,
    SecNameSPN           = 0x00000004,
}
alias SECPKG_NAME_TYPE = int;

enum : int
{
    CredFetchDefault = 0x00000000,
    CredFetchDPAPI   = 0x00000001,
    CredFetchForced  = 0x00000002,
}
alias CRED_FETCH = int;

enum : int
{
    KSecPaged    = 0x00000000,
    KSecNonPaged = 0x00000001,
}
alias KSEC_CONTEXT_TYPE = int;

enum : int
{
    TlsSignatureAlgorithm_Anonymous = 0x00000000,
    TlsSignatureAlgorithm_Rsa       = 0x00000001,
    TlsSignatureAlgorithm_Dsa       = 0x00000002,
    TlsSignatureAlgorithm_Ecdsa     = 0x00000003,
}
alias eTlsSignatureAlgorithm = int;

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
alias eTlsHashAlgorithm = int;

enum SchGetExtensionsOptions : int
{
    SCH_EXTENSIONS_OPTIONS_NONE = 0x00000000,
    SCH_NO_RECORD_HEADER        = 0x00000001,
}

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
alias SE_OBJECT_TYPE = int;

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
alias TRUSTEE_TYPE = int;

enum : int
{
    TRUSTEE_IS_SID              = 0x00000000,
    TRUSTEE_IS_NAME             = 0x00000001,
    TRUSTEE_BAD_FORM            = 0x00000002,
    TRUSTEE_IS_OBJECTS_AND_SID  = 0x00000003,
    TRUSTEE_IS_OBJECTS_AND_NAME = 0x00000004,
}
alias TRUSTEE_FORM = int;

enum : int
{
    NO_MULTIPLE_TRUSTEE    = 0x00000000,
    TRUSTEE_IS_IMPERSONATE = 0x00000001,
}
alias MULTIPLE_TRUSTEE_OPERATION = int;

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
alias ACCESS_MODE = int;

enum : int
{
    ProgressInvokeNever        = 0x00000001,
    ProgressInvokeEveryObject  = 0x00000002,
    ProgressInvokeOnError      = 0x00000003,
    ProgressCancelOperation    = 0x00000004,
    ProgressRetryOperation     = 0x00000005,
    ProgressInvokePrePostError = 0x00000006,
}
alias PROG_INVOKE_SETTING = int;

enum : int
{
    TPMVSC_ATTESTATION_NONE                = 0x00000000,
    TPMVSC_ATTESTATION_AIK_ONLY            = 0x00000001,
    TPMVSC_ATTESTATION_AIK_AND_CERTIFICATE = 0x00000002,
}
alias TPMVSC_ATTESTATION_TYPE = int;

enum : int
{
    TPMVSCMGR_STATUS_VTPMSMARTCARD_INITIALIZING  = 0x00000000,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_CREATING      = 0x00000001,
    TPMVSCMGR_STATUS_VTPMSMARTCARD_DESTROYING    = 0x00000002,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_INITIALIZING = 0x00000003,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_CREATING     = 0x00000004,
    TPMVSCMGR_STATUS_VGIDSSIMULATOR_DESTROYING   = 0x00000005,
    TPMVSCMGR_STATUS_VREADER_INITIALIZING        = 0x00000006,
    TPMVSCMGR_STATUS_VREADER_CREATING            = 0x00000007,
    TPMVSCMGR_STATUS_VREADER_DESTROYING          = 0x00000008,
    TPMVSCMGR_STATUS_GENERATE_WAITING            = 0x00000009,
    TPMVSCMGR_STATUS_GENERATE_AUTHENTICATING     = 0x0000000a,
    TPMVSCMGR_STATUS_GENERATE_RUNNING            = 0x0000000b,
    TPMVSCMGR_STATUS_CARD_CREATED                = 0x0000000c,
    TPMVSCMGR_STATUS_CARD_DESTROYED              = 0x0000000d,
}
alias TPMVSCMGR_STATUS = int;

enum : int
{
    TPMVSCMGR_ERROR_IMPERSONATION                 = 0x00000000,
    TPMVSCMGR_ERROR_PIN_COMPLEXITY                = 0x00000001,
    TPMVSCMGR_ERROR_READER_COUNT_LIMIT            = 0x00000002,
    TPMVSCMGR_ERROR_TERMINAL_SERVICES_SESSION     = 0x00000003,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_INITIALIZE      = 0x00000004,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_CREATE          = 0x00000005,
    TPMVSCMGR_ERROR_VTPMSMARTCARD_DESTROY         = 0x00000006,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_INITIALIZE     = 0x00000007,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_CREATE         = 0x00000008,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_DESTROY        = 0x00000009,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_WRITE_PROPERTY = 0x0000000a,
    TPMVSCMGR_ERROR_VGIDSSIMULATOR_READ_PROPERTY  = 0x0000000b,
    TPMVSCMGR_ERROR_VREADER_INITIALIZE            = 0x0000000c,
    TPMVSCMGR_ERROR_VREADER_CREATE                = 0x0000000d,
    TPMVSCMGR_ERROR_VREADER_DESTROY               = 0x0000000e,
    TPMVSCMGR_ERROR_GENERATE_LOCATE_READER        = 0x0000000f,
    TPMVSCMGR_ERROR_GENERATE_FILESYSTEM           = 0x00000010,
    TPMVSCMGR_ERROR_CARD_CREATE                   = 0x00000011,
    TPMVSCMGR_ERROR_CARD_DESTROY                  = 0x00000012,
}
alias TPMVSCMGR_ERROR = int;

enum KeyCredentialManagerOperationErrorStates : int
{
    KeyCredentialManagerOperationErrorStateNone                 = 0x00000000,
    KeyCredentialManagerOperationErrorStateDeviceJoinFailure    = 0x00000001,
    KeyCredentialManagerOperationErrorStateTokenFailure         = 0x00000002,
    KeyCredentialManagerOperationErrorStateCertificateFailure   = 0x00000004,
    KeyCredentialManagerOperationErrorStateRemoteSessionFailure = 0x00000008,
    KeyCredentialManagerOperationErrorStatePolicyFailure        = 0x00000010,
    KeyCredentialManagerOperationErrorStateHardwareFailure      = 0x00000020,
    KeyCredentialManagerOperationErrorStatePinExistsFailure     = 0x00000040,
}

enum KeyCredentialManagerOperationType : int
{
    KeyCredentialManagerProvisioning = 0x00000000,
    KeyCredentialManagerPinChange    = 0x00000001,
    KeyCredentialManagerPinReset     = 0x00000002,
}

enum : int
{
    IDENTITIES_ALL     = 0x00000000,
    IDENTITIES_ME_ONLY = 0x00000001,
}
alias IDENTITY_TYPE = int;

enum : int
{
    NetlogonInteractiveInformation           = 0x00000001,
    NetlogonNetworkInformation               = 0x00000002,
    NetlogonServiceInformation               = 0x00000003,
    NetlogonGenericInformation               = 0x00000004,
    NetlogonInteractiveTransitiveInformation = 0x00000005,
    NetlogonNetworkTransitiveInformation     = 0x00000006,
    NetlogonServiceTransitiveInformation     = 0x00000007,
}
alias NETLOGON_LOGON_INFO_CLASS = int;

enum : int
{
    IDENTITY_ASSOCIATED    = 0x00000001,
    IDENTITY_DISASSOCIATED = 0x00000002,
    IDENTITY_CREATED       = 0x00000004,
    IDENTITY_IMPORTED      = 0x00000008,
    IDENTITY_DELETED       = 0x00000010,
    IDENTITY_PROPCHANGED   = 0x00000020,
    IDENTITY_CONNECTED     = 0x00000040,
    IDENTITY_DISCONNECTED  = 0x00000080,
}
alias tag_IdentityUpdateEvent = int;

enum : int
{
    IDENTITY_URL_CREATE_ACCOUNT_WIZARD  = 0x00000000,
    IDENTITY_URL_SIGN_IN_WIZARD         = 0x00000001,
    IDENTITY_URL_CHANGE_PASSWORD_WIZARD = 0x00000002,
    IDENTITY_URL_IFEXISTS_WIZARD        = 0x00000003,
    IDENTITY_URL_ACCOUNT_SETTINGS       = 0x00000004,
    IDENTITY_URL_RESTORE_WIZARD         = 0x00000005,
    IDENTITY_URL_CONNECT_WIZARD         = 0x00000006,
}
alias __MIDL___MIDL_itf_identityprovider_0000_0003_0001 = int;

enum : int
{
    NOT_CONNECTED     = 0x00000000,
    CONNECTING        = 0x00000001,
    CONNECT_COMPLETED = 0x00000002,
}
alias __MIDL___MIDL_itf_identityprovider_0000_0003_0002 = int;

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
alias AUDIT_PARAM_TYPE = int;

enum : int
{
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_NONE        = 0x00000000,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE_ALL = 0x00000001,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_ADD         = 0x00000002,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_DELETE      = 0x00000003,
    AUTHZ_SECURITY_ATTRIBUTE_OPERATION_REPLACE     = 0x00000004,
}
alias AUTHZ_SECURITY_ATTRIBUTE_OPERATION = int;

enum : int
{
    AUTHZ_SID_OPERATION_NONE        = 0x00000000,
    AUTHZ_SID_OPERATION_REPLACE_ALL = 0x00000001,
    AUTHZ_SID_OPERATION_ADD         = 0x00000002,
    AUTHZ_SID_OPERATION_DELETE      = 0x00000003,
    AUTHZ_SID_OPERATION_REPLACE     = 0x00000004,
}
alias AUTHZ_SID_OPERATION = int;

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
alias AUTHZ_CONTEXT_INFORMATION_CLASS = int;

enum : int
{
    AuthzAuditEventInfoFlags          = 0x00000001,
    AuthzAuditEventInfoOperationType  = 0x00000002,
    AuthzAuditEventInfoObjectType     = 0x00000003,
    AuthzAuditEventInfoObjectName     = 0x00000004,
    AuthzAuditEventInfoAdditionalInfo = 0x00000005,
}
alias AUTHZ_AUDIT_EVENT_INFORMATION_CLASS = int;

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
alias AZ_PROP_CONSTANTS = int;

enum : int
{
    SI_PAGE_PERM          = 0x00000000,
    SI_PAGE_ADVPERM       = 0x00000001,
    SI_PAGE_AUDIT         = 0x00000002,
    SI_PAGE_OWNER         = 0x00000003,
    SI_PAGE_EFFECTIVE     = 0x00000004,
    SI_PAGE_TAKEOWNERSHIP = 0x00000005,
    SI_PAGE_SHARE         = 0x00000006,
}
alias SI_PAGE_TYPE = int;

enum : int
{
    SI_SHOW_DEFAULT                  = 0x00000000,
    SI_SHOW_PERM_ACTIVATED           = 0x00000001,
    SI_SHOW_AUDIT_ACTIVATED          = 0x00000002,
    SI_SHOW_OWNER_ACTIVATED          = 0x00000003,
    SI_SHOW_EFFECTIVE_ACTIVATED      = 0x00000004,
    SI_SHOW_SHARE_ACTIVATED          = 0x00000005,
    SI_SHOW_CENTRAL_POLICY_ACTIVATED = 0x00000006,
}
alias SI_PAGE_ACTIVATED = int;

enum X509EnrollmentAuthFlags : int
{
    X509AuthNone        = 0x00000000,
    X509AuthAnonymous   = 0x00000001,
    X509AuthKerberos    = 0x00000002,
    X509AuthUsername    = 0x00000004,
    X509AuthCertificate = 0x00000008,
}

enum X509SCEPMessageType : int
{
    SCEPMessageUnknown              = 0xffffffff,
    SCEPMessageCertResponse         = 0x00000003,
    SCEPMessagePKCSRequest          = 0x00000013,
    SCEPMessageGetCertInitial       = 0x00000014,
    SCEPMessageGetCert              = 0x00000015,
    SCEPMessageGetCRL               = 0x00000016,
    SCEPMessageClaimChallengeAnswer = 0x00000029,
}

enum X509SCEPDisposition : int
{
    SCEPDispositionUnknown          = 0xffffffff,
    SCEPDispositionSuccess          = 0x00000000,
    SCEPDispositionFailure          = 0x00000002,
    SCEPDispositionPending          = 0x00000003,
    SCEPDispositionPendingChallenge = 0x0000000b,
}

enum : int
{
    SCEPFailUnknown         = 0xffffffff,
    SCEPFailBadAlgorithm    = 0x00000000,
    SCEPFailBadMessageCheck = 0x00000001,
    SCEPFailBadRequest      = 0x00000002,
    SCEPFailBadTime         = 0x00000003,
    SCEPFailBadCertId       = 0x00000004,
}
alias X509SCEPFailInfo = int;

enum : int
{
    XCN_OID_NONE                                          = 0x00000000,
    XCN_OID_RSA                                           = 0x00000001,
    XCN_OID_PKCS                                          = 0x00000002,
    XCN_OID_RSA_HASH                                      = 0x00000003,
    XCN_OID_RSA_ENCRYPT                                   = 0x00000004,
    XCN_OID_PKCS_1                                        = 0x00000005,
    XCN_OID_PKCS_2                                        = 0x00000006,
    XCN_OID_PKCS_3                                        = 0x00000007,
    XCN_OID_PKCS_4                                        = 0x00000008,
    XCN_OID_PKCS_5                                        = 0x00000009,
    XCN_OID_PKCS_6                                        = 0x0000000a,
    XCN_OID_PKCS_7                                        = 0x0000000b,
    XCN_OID_PKCS_8                                        = 0x0000000c,
    XCN_OID_PKCS_9                                        = 0x0000000d,
    XCN_OID_PKCS_10                                       = 0x0000000e,
    XCN_OID_PKCS_12                                       = 0x0000000f,
    XCN_OID_RSA_RSA                                       = 0x00000010,
    XCN_OID_RSA_MD2RSA                                    = 0x00000011,
    XCN_OID_RSA_MD4RSA                                    = 0x00000012,
    XCN_OID_RSA_MD5RSA                                    = 0x00000013,
    XCN_OID_RSA_SHA1RSA                                   = 0x00000014,
    XCN_OID_RSA_SETOAEP_RSA                               = 0x00000015,
    XCN_OID_RSA_DH                                        = 0x00000016,
    XCN_OID_RSA_data                                      = 0x00000017,
    XCN_OID_RSA_signedData                                = 0x00000018,
    XCN_OID_RSA_envelopedData                             = 0x00000019,
    XCN_OID_RSA_signEnvData                               = 0x0000001a,
    XCN_OID_RSA_digestedData                              = 0x0000001b,
    XCN_OID_RSA_hashedData                                = 0x0000001c,
    XCN_OID_RSA_encryptedData                             = 0x0000001d,
    XCN_OID_RSA_emailAddr                                 = 0x0000001e,
    XCN_OID_RSA_unstructName                              = 0x0000001f,
    XCN_OID_RSA_contentType                               = 0x00000020,
    XCN_OID_RSA_messageDigest                             = 0x00000021,
    XCN_OID_RSA_signingTime                               = 0x00000022,
    XCN_OID_RSA_counterSign                               = 0x00000023,
    XCN_OID_RSA_challengePwd                              = 0x00000024,
    XCN_OID_RSA_unstructAddr                              = 0x00000025,
    XCN_OID_RSA_extCertAttrs                              = 0x00000026,
    XCN_OID_RSA_certExtensions                            = 0x00000027,
    XCN_OID_RSA_SMIMECapabilities                         = 0x00000028,
    XCN_OID_RSA_preferSignedData                          = 0x00000029,
    XCN_OID_RSA_SMIMEalg                                  = 0x0000002a,
    XCN_OID_RSA_SMIMEalgESDH                              = 0x0000002b,
    XCN_OID_RSA_SMIMEalgCMS3DESwrap                       = 0x0000002c,
    XCN_OID_RSA_SMIMEalgCMSRC2wrap                        = 0x0000002d,
    XCN_OID_RSA_MD2                                       = 0x0000002e,
    XCN_OID_RSA_MD4                                       = 0x0000002f,
    XCN_OID_RSA_MD5                                       = 0x00000030,
    XCN_OID_RSA_RC2CBC                                    = 0x00000031,
    XCN_OID_RSA_RC4                                       = 0x00000032,
    XCN_OID_RSA_DES_EDE3_CBC                              = 0x00000033,
    XCN_OID_RSA_RC5_CBCPad                                = 0x00000034,
    XCN_OID_ANSI_X942                                     = 0x00000035,
    XCN_OID_ANSI_X942_DH                                  = 0x00000036,
    XCN_OID_X957                                          = 0x00000037,
    XCN_OID_X957_DSA                                      = 0x00000038,
    XCN_OID_X957_SHA1DSA                                  = 0x00000039,
    XCN_OID_DS                                            = 0x0000003a,
    XCN_OID_DSALG                                         = 0x0000003b,
    XCN_OID_DSALG_CRPT                                    = 0x0000003c,
    XCN_OID_DSALG_HASH                                    = 0x0000003d,
    XCN_OID_DSALG_SIGN                                    = 0x0000003e,
    XCN_OID_DSALG_RSA                                     = 0x0000003f,
    XCN_OID_OIW                                           = 0x00000040,
    XCN_OID_OIWSEC                                        = 0x00000041,
    XCN_OID_OIWSEC_md4RSA                                 = 0x00000042,
    XCN_OID_OIWSEC_md5RSA                                 = 0x00000043,
    XCN_OID_OIWSEC_md4RSA2                                = 0x00000044,
    XCN_OID_OIWSEC_desECB                                 = 0x00000045,
    XCN_OID_OIWSEC_desCBC                                 = 0x00000046,
    XCN_OID_OIWSEC_desOFB                                 = 0x00000047,
    XCN_OID_OIWSEC_desCFB                                 = 0x00000048,
    XCN_OID_OIWSEC_desMAC                                 = 0x00000049,
    XCN_OID_OIWSEC_rsaSign                                = 0x0000004a,
    XCN_OID_OIWSEC_dsa                                    = 0x0000004b,
    XCN_OID_OIWSEC_shaDSA                                 = 0x0000004c,
    XCN_OID_OIWSEC_mdc2RSA                                = 0x0000004d,
    XCN_OID_OIWSEC_shaRSA                                 = 0x0000004e,
    XCN_OID_OIWSEC_dhCommMod                              = 0x0000004f,
    XCN_OID_OIWSEC_desEDE                                 = 0x00000050,
    XCN_OID_OIWSEC_sha                                    = 0x00000051,
    XCN_OID_OIWSEC_mdc2                                   = 0x00000052,
    XCN_OID_OIWSEC_dsaComm                                = 0x00000053,
    XCN_OID_OIWSEC_dsaCommSHA                             = 0x00000054,
    XCN_OID_OIWSEC_rsaXchg                                = 0x00000055,
    XCN_OID_OIWSEC_keyHashSeal                            = 0x00000056,
    XCN_OID_OIWSEC_md2RSASign                             = 0x00000057,
    XCN_OID_OIWSEC_md5RSASign                             = 0x00000058,
    XCN_OID_OIWSEC_sha1                                   = 0x00000059,
    XCN_OID_OIWSEC_dsaSHA1                                = 0x0000005a,
    XCN_OID_OIWSEC_dsaCommSHA1                            = 0x0000005b,
    XCN_OID_OIWSEC_sha1RSASign                            = 0x0000005c,
    XCN_OID_OIWDIR                                        = 0x0000005d,
    XCN_OID_OIWDIR_CRPT                                   = 0x0000005e,
    XCN_OID_OIWDIR_HASH                                   = 0x0000005f,
    XCN_OID_OIWDIR_SIGN                                   = 0x00000060,
    XCN_OID_OIWDIR_md2                                    = 0x00000061,
    XCN_OID_OIWDIR_md2RSA                                 = 0x00000062,
    XCN_OID_INFOSEC                                       = 0x00000063,
    XCN_OID_INFOSEC_sdnsSignature                         = 0x00000064,
    XCN_OID_INFOSEC_mosaicSignature                       = 0x00000065,
    XCN_OID_INFOSEC_sdnsConfidentiality                   = 0x00000066,
    XCN_OID_INFOSEC_mosaicConfidentiality                 = 0x00000067,
    XCN_OID_INFOSEC_sdnsIntegrity                         = 0x00000068,
    XCN_OID_INFOSEC_mosaicIntegrity                       = 0x00000069,
    XCN_OID_INFOSEC_sdnsTokenProtection                   = 0x0000006a,
    XCN_OID_INFOSEC_mosaicTokenProtection                 = 0x0000006b,
    XCN_OID_INFOSEC_sdnsKeyManagement                     = 0x0000006c,
    XCN_OID_INFOSEC_mosaicKeyManagement                   = 0x0000006d,
    XCN_OID_INFOSEC_sdnsKMandSig                          = 0x0000006e,
    XCN_OID_INFOSEC_mosaicKMandSig                        = 0x0000006f,
    XCN_OID_INFOSEC_SuiteASignature                       = 0x00000070,
    XCN_OID_INFOSEC_SuiteAConfidentiality                 = 0x00000071,
    XCN_OID_INFOSEC_SuiteAIntegrity                       = 0x00000072,
    XCN_OID_INFOSEC_SuiteATokenProtection                 = 0x00000073,
    XCN_OID_INFOSEC_SuiteAKeyManagement                   = 0x00000074,
    XCN_OID_INFOSEC_SuiteAKMandSig                        = 0x00000075,
    XCN_OID_INFOSEC_mosaicUpdatedSig                      = 0x00000076,
    XCN_OID_INFOSEC_mosaicKMandUpdSig                     = 0x00000077,
    XCN_OID_INFOSEC_mosaicUpdatedInteg                    = 0x00000078,
    XCN_OID_COMMON_NAME                                   = 0x00000079,
    XCN_OID_SUR_NAME                                      = 0x0000007a,
    XCN_OID_DEVICE_SERIAL_NUMBER                          = 0x0000007b,
    XCN_OID_COUNTRY_NAME                                  = 0x0000007c,
    XCN_OID_LOCALITY_NAME                                 = 0x0000007d,
    XCN_OID_STATE_OR_PROVINCE_NAME                        = 0x0000007e,
    XCN_OID_STREET_ADDRESS                                = 0x0000007f,
    XCN_OID_ORGANIZATION_NAME                             = 0x00000080,
    XCN_OID_ORGANIZATIONAL_UNIT_NAME                      = 0x00000081,
    XCN_OID_TITLE                                         = 0x00000082,
    XCN_OID_DESCRIPTION                                   = 0x00000083,
    XCN_OID_SEARCH_GUIDE                                  = 0x00000084,
    XCN_OID_BUSINESS_CATEGORY                             = 0x00000085,
    XCN_OID_POSTAL_ADDRESS                                = 0x00000086,
    XCN_OID_POSTAL_CODE                                   = 0x00000087,
    XCN_OID_POST_OFFICE_BOX                               = 0x00000088,
    XCN_OID_PHYSICAL_DELIVERY_OFFICE_NAME                 = 0x00000089,
    XCN_OID_TELEPHONE_NUMBER                              = 0x0000008a,
    XCN_OID_TELEX_NUMBER                                  = 0x0000008b,
    XCN_OID_TELETEXT_TERMINAL_IDENTIFIER                  = 0x0000008c,
    XCN_OID_FACSIMILE_TELEPHONE_NUMBER                    = 0x0000008d,
    XCN_OID_X21_ADDRESS                                   = 0x0000008e,
    XCN_OID_INTERNATIONAL_ISDN_NUMBER                     = 0x0000008f,
    XCN_OID_REGISTERED_ADDRESS                            = 0x00000090,
    XCN_OID_DESTINATION_INDICATOR                         = 0x00000091,
    XCN_OID_PREFERRED_DELIVERY_METHOD                     = 0x00000092,
    XCN_OID_PRESENTATION_ADDRESS                          = 0x00000093,
    XCN_OID_SUPPORTED_APPLICATION_CONTEXT                 = 0x00000094,
    XCN_OID_MEMBER                                        = 0x00000095,
    XCN_OID_OWNER                                         = 0x00000096,
    XCN_OID_ROLE_OCCUPANT                                 = 0x00000097,
    XCN_OID_SEE_ALSO                                      = 0x00000098,
    XCN_OID_USER_PASSWORD                                 = 0x00000099,
    XCN_OID_USER_CERTIFICATE                              = 0x0000009a,
    XCN_OID_CA_CERTIFICATE                                = 0x0000009b,
    XCN_OID_AUTHORITY_REVOCATION_LIST                     = 0x0000009c,
    XCN_OID_CERTIFICATE_REVOCATION_LIST                   = 0x0000009d,
    XCN_OID_CROSS_CERTIFICATE_PAIR                        = 0x0000009e,
    XCN_OID_GIVEN_NAME                                    = 0x0000009f,
    XCN_OID_INITIALS                                      = 0x000000a0,
    XCN_OID_DN_QUALIFIER                                  = 0x000000a1,
    XCN_OID_DOMAIN_COMPONENT                              = 0x000000a2,
    XCN_OID_PKCS_12_FRIENDLY_NAME_ATTR                    = 0x000000a3,
    XCN_OID_PKCS_12_LOCAL_KEY_ID                          = 0x000000a4,
    XCN_OID_PKCS_12_KEY_PROVIDER_NAME_ATTR                = 0x000000a5,
    XCN_OID_LOCAL_MACHINE_KEYSET                          = 0x000000a6,
    XCN_OID_PKCS_12_EXTENDED_ATTRIBUTES                   = 0x000000a7,
    XCN_OID_KEYID_RDN                                     = 0x000000a8,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER                      = 0x000000a9,
    XCN_OID_KEY_ATTRIBUTES                                = 0x000000aa,
    XCN_OID_CERT_POLICIES_95                              = 0x000000ab,
    XCN_OID_KEY_USAGE_RESTRICTION                         = 0x000000ac,
    XCN_OID_SUBJECT_ALT_NAME                              = 0x000000ad,
    XCN_OID_ISSUER_ALT_NAME                               = 0x000000ae,
    XCN_OID_BASIC_CONSTRAINTS                             = 0x000000af,
    XCN_OID_KEY_USAGE                                     = 0x000000b0,
    XCN_OID_PRIVATEKEY_USAGE_PERIOD                       = 0x000000b1,
    XCN_OID_BASIC_CONSTRAINTS2                            = 0x000000b2,
    XCN_OID_CERT_POLICIES                                 = 0x000000b3,
    XCN_OID_ANY_CERT_POLICY                               = 0x000000b4,
    XCN_OID_AUTHORITY_KEY_IDENTIFIER2                     = 0x000000b5,
    XCN_OID_SUBJECT_KEY_IDENTIFIER                        = 0x000000b6,
    XCN_OID_SUBJECT_ALT_NAME2                             = 0x000000b7,
    XCN_OID_ISSUER_ALT_NAME2                              = 0x000000b8,
    XCN_OID_CRL_REASON_CODE                               = 0x000000b9,
    XCN_OID_REASON_CODE_HOLD                              = 0x000000ba,
    XCN_OID_CRL_DIST_POINTS                               = 0x000000bb,
    XCN_OID_ENHANCED_KEY_USAGE                            = 0x000000bc,
    XCN_OID_CRL_NUMBER                                    = 0x000000bd,
    XCN_OID_DELTA_CRL_INDICATOR                           = 0x000000be,
    XCN_OID_ISSUING_DIST_POINT                            = 0x000000bf,
    XCN_OID_FRESHEST_CRL                                  = 0x000000c0,
    XCN_OID_NAME_CONSTRAINTS                              = 0x000000c1,
    XCN_OID_POLICY_MAPPINGS                               = 0x000000c2,
    XCN_OID_LEGACY_POLICY_MAPPINGS                        = 0x000000c3,
    XCN_OID_POLICY_CONSTRAINTS                            = 0x000000c4,
    XCN_OID_RENEWAL_CERTIFICATE                           = 0x000000c5,
    XCN_OID_ENROLLMENT_NAME_VALUE_PAIR                    = 0x000000c6,
    XCN_OID_ENROLLMENT_CSP_PROVIDER                       = 0x000000c7,
    XCN_OID_OS_VERSION                                    = 0x000000c8,
    XCN_OID_ENROLLMENT_AGENT                              = 0x000000c9,
    XCN_OID_PKIX                                          = 0x000000ca,
    XCN_OID_PKIX_PE                                       = 0x000000cb,
    XCN_OID_AUTHORITY_INFO_ACCESS                         = 0x000000cc,
    XCN_OID_BIOMETRIC_EXT                                 = 0x000000cd,
    XCN_OID_LOGOTYPE_EXT                                  = 0x000000ce,
    XCN_OID_CERT_EXTENSIONS                               = 0x000000cf,
    XCN_OID_NEXT_UPDATE_LOCATION                          = 0x000000d0,
    XCN_OID_REMOVE_CERTIFICATE                            = 0x000000d1,
    XCN_OID_CROSS_CERT_DIST_POINTS                        = 0x000000d2,
    XCN_OID_CTL                                           = 0x000000d3,
    XCN_OID_SORTED_CTL                                    = 0x000000d4,
    XCN_OID_SERIALIZED                                    = 0x000000d5,
    XCN_OID_NT_PRINCIPAL_NAME                             = 0x000000d6,
    XCN_OID_PRODUCT_UPDATE                                = 0x000000d7,
    XCN_OID_ANY_APPLICATION_POLICY                        = 0x000000d8,
    XCN_OID_AUTO_ENROLL_CTL_USAGE                         = 0x000000d9,
    XCN_OID_ENROLL_CERTTYPE_EXTENSION                     = 0x000000da,
    XCN_OID_CERT_MANIFOLD                                 = 0x000000db,
    XCN_OID_CERTSRV_CA_VERSION                            = 0x000000dc,
    XCN_OID_CERTSRV_PREVIOUS_CERT_HASH                    = 0x000000dd,
    XCN_OID_CRL_VIRTUAL_BASE                              = 0x000000de,
    XCN_OID_CRL_NEXT_PUBLISH                              = 0x000000df,
    XCN_OID_KP_CA_EXCHANGE                                = 0x000000e0,
    XCN_OID_KP_KEY_RECOVERY_AGENT                         = 0x000000e1,
    XCN_OID_CERTIFICATE_TEMPLATE                          = 0x000000e2,
    XCN_OID_ENTERPRISE_OID_ROOT                           = 0x000000e3,
    XCN_OID_RDN_DUMMY_SIGNER                              = 0x000000e4,
    XCN_OID_APPLICATION_CERT_POLICIES                     = 0x000000e5,
    XCN_OID_APPLICATION_POLICY_MAPPINGS                   = 0x000000e6,
    XCN_OID_APPLICATION_POLICY_CONSTRAINTS                = 0x000000e7,
    XCN_OID_ARCHIVED_KEY_ATTR                             = 0x000000e8,
    XCN_OID_CRL_SELF_CDP                                  = 0x000000e9,
    XCN_OID_REQUIRE_CERT_CHAIN_POLICY                     = 0x000000ea,
    XCN_OID_ARCHIVED_KEY_CERT_HASH                        = 0x000000eb,
    XCN_OID_ISSUED_CERT_HASH                              = 0x000000ec,
    XCN_OID_DS_EMAIL_REPLICATION                          = 0x000000ed,
    XCN_OID_REQUEST_CLIENT_INFO                           = 0x000000ee,
    XCN_OID_ENCRYPTED_KEY_HASH                            = 0x000000ef,
    XCN_OID_CERTSRV_CROSSCA_VERSION                       = 0x000000f0,
    XCN_OID_NTDS_REPLICATION                              = 0x000000f1,
    XCN_OID_SUBJECT_DIR_ATTRS                             = 0x000000f2,
    XCN_OID_PKIX_KP                                       = 0x000000f3,
    XCN_OID_PKIX_KP_SERVER_AUTH                           = 0x000000f4,
    XCN_OID_PKIX_KP_CLIENT_AUTH                           = 0x000000f5,
    XCN_OID_PKIX_KP_CODE_SIGNING                          = 0x000000f6,
    XCN_OID_PKIX_KP_EMAIL_PROTECTION                      = 0x000000f7,
    XCN_OID_PKIX_KP_IPSEC_END_SYSTEM                      = 0x000000f8,
    XCN_OID_PKIX_KP_IPSEC_TUNNEL                          = 0x000000f9,
    XCN_OID_PKIX_KP_IPSEC_USER                            = 0x000000fa,
    XCN_OID_PKIX_KP_TIMESTAMP_SIGNING                     = 0x000000fb,
    XCN_OID_PKIX_KP_OCSP_SIGNING                          = 0x000000fc,
    XCN_OID_PKIX_OCSP_NOCHECK                             = 0x000000fd,
    XCN_OID_IPSEC_KP_IKE_INTERMEDIATE                     = 0x000000fe,
    XCN_OID_KP_CTL_USAGE_SIGNING                          = 0x000000ff,
    XCN_OID_KP_TIME_STAMP_SIGNING                         = 0x00000100,
    XCN_OID_SERVER_GATED_CRYPTO                           = 0x00000101,
    XCN_OID_SGC_NETSCAPE                                  = 0x00000102,
    XCN_OID_KP_EFS                                        = 0x00000103,
    XCN_OID_EFS_RECOVERY                                  = 0x00000104,
    XCN_OID_WHQL_CRYPTO                                   = 0x00000105,
    XCN_OID_NT5_CRYPTO                                    = 0x00000106,
    XCN_OID_OEM_WHQL_CRYPTO                               = 0x00000107,
    XCN_OID_EMBEDDED_NT_CRYPTO                            = 0x00000108,
    XCN_OID_ROOT_LIST_SIGNER                              = 0x00000109,
    XCN_OID_KP_QUALIFIED_SUBORDINATION                    = 0x0000010a,
    XCN_OID_KP_KEY_RECOVERY                               = 0x0000010b,
    XCN_OID_KP_DOCUMENT_SIGNING                           = 0x0000010c,
    XCN_OID_KP_LIFETIME_SIGNING                           = 0x0000010d,
    XCN_OID_KP_MOBILE_DEVICE_SOFTWARE                     = 0x0000010e,
    XCN_OID_KP_SMART_DISPLAY                              = 0x0000010f,
    XCN_OID_KP_CSP_SIGNATURE                              = 0x00000110,
    XCN_OID_DRM                                           = 0x00000111,
    XCN_OID_DRM_INDIVIDUALIZATION                         = 0x00000112,
    XCN_OID_LICENSES                                      = 0x00000113,
    XCN_OID_LICENSE_SERVER                                = 0x00000114,
    XCN_OID_KP_SMARTCARD_LOGON                            = 0x00000115,
    XCN_OID_YESNO_TRUST_ATTR                              = 0x00000116,
    XCN_OID_PKIX_POLICY_QUALIFIER_CPS                     = 0x00000117,
    XCN_OID_PKIX_POLICY_QUALIFIER_USERNOTICE              = 0x00000118,
    XCN_OID_CERT_POLICIES_95_QUALIFIER1                   = 0x00000119,
    XCN_OID_PKIX_ACC_DESCR                                = 0x0000011a,
    XCN_OID_PKIX_OCSP                                     = 0x0000011b,
    XCN_OID_PKIX_CA_ISSUERS                               = 0x0000011c,
    XCN_OID_VERISIGN_PRIVATE_6_9                          = 0x0000011d,
    XCN_OID_VERISIGN_ONSITE_JURISDICTION_HASH             = 0x0000011e,
    XCN_OID_VERISIGN_BITSTRING_6_13                       = 0x0000011f,
    XCN_OID_VERISIGN_ISS_STRONG_CRYPTO                    = 0x00000120,
    XCN_OID_NETSCAPE                                      = 0x00000121,
    XCN_OID_NETSCAPE_CERT_EXTENSION                       = 0x00000122,
    XCN_OID_NETSCAPE_CERT_TYPE                            = 0x00000123,
    XCN_OID_NETSCAPE_BASE_URL                             = 0x00000124,
    XCN_OID_NETSCAPE_REVOCATION_URL                       = 0x00000125,
    XCN_OID_NETSCAPE_CA_REVOCATION_URL                    = 0x00000126,
    XCN_OID_NETSCAPE_CERT_RENEWAL_URL                     = 0x00000127,
    XCN_OID_NETSCAPE_CA_POLICY_URL                        = 0x00000128,
    XCN_OID_NETSCAPE_SSL_SERVER_NAME                      = 0x00000129,
    XCN_OID_NETSCAPE_COMMENT                              = 0x0000012a,
    XCN_OID_NETSCAPE_DATA_TYPE                            = 0x0000012b,
    XCN_OID_NETSCAPE_CERT_SEQUENCE                        = 0x0000012c,
    XCN_OID_CT_PKI_DATA                                   = 0x0000012d,
    XCN_OID_CT_PKI_RESPONSE                               = 0x0000012e,
    XCN_OID_PKIX_NO_SIGNATURE                             = 0x0000012f,
    XCN_OID_CMC                                           = 0x00000130,
    XCN_OID_CMC_STATUS_INFO                               = 0x00000131,
    XCN_OID_CMC_IDENTIFICATION                            = 0x00000132,
    XCN_OID_CMC_IDENTITY_PROOF                            = 0x00000133,
    XCN_OID_CMC_DATA_RETURN                               = 0x00000134,
    XCN_OID_CMC_TRANSACTION_ID                            = 0x00000135,
    XCN_OID_CMC_SENDER_NONCE                              = 0x00000136,
    XCN_OID_CMC_RECIPIENT_NONCE                           = 0x00000137,
    XCN_OID_CMC_ADD_EXTENSIONS                            = 0x00000138,
    XCN_OID_CMC_ENCRYPTED_POP                             = 0x00000139,
    XCN_OID_CMC_DECRYPTED_POP                             = 0x0000013a,
    XCN_OID_CMC_LRA_POP_WITNESS                           = 0x0000013b,
    XCN_OID_CMC_GET_CERT                                  = 0x0000013c,
    XCN_OID_CMC_GET_CRL                                   = 0x0000013d,
    XCN_OID_CMC_REVOKE_REQUEST                            = 0x0000013e,
    XCN_OID_CMC_REG_INFO                                  = 0x0000013f,
    XCN_OID_CMC_RESPONSE_INFO                             = 0x00000140,
    XCN_OID_CMC_QUERY_PENDING                             = 0x00000141,
    XCN_OID_CMC_ID_POP_LINK_RANDOM                        = 0x00000142,
    XCN_OID_CMC_ID_POP_LINK_WITNESS                       = 0x00000143,
    XCN_OID_CMC_ID_CONFIRM_CERT_ACCEPTANCE                = 0x00000144,
    XCN_OID_CMC_ADD_ATTRIBUTES                            = 0x00000145,
    XCN_OID_LOYALTY_OTHER_LOGOTYPE                        = 0x00000146,
    XCN_OID_BACKGROUND_OTHER_LOGOTYPE                     = 0x00000147,
    XCN_OID_PKIX_OCSP_BASIC_SIGNED_RESPONSE               = 0x00000148,
    XCN_OID_PKCS_7_DATA                                   = 0x00000149,
    XCN_OID_PKCS_7_SIGNED                                 = 0x0000014a,
    XCN_OID_PKCS_7_ENVELOPED                              = 0x0000014b,
    XCN_OID_PKCS_7_SIGNEDANDENVELOPED                     = 0x0000014c,
    XCN_OID_PKCS_7_DIGESTED                               = 0x0000014d,
    XCN_OID_PKCS_7_ENCRYPTED                              = 0x0000014e,
    XCN_OID_PKCS_9_CONTENT_TYPE                           = 0x0000014f,
    XCN_OID_PKCS_9_MESSAGE_DIGEST                         = 0x00000150,
    XCN_OID_CERT_PROP_ID_PREFIX                           = 0x00000151,
    XCN_OID_CERT_KEY_IDENTIFIER_PROP_ID                   = 0x00000152,
    XCN_OID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID    = 0x00000153,
    XCN_OID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID            = 0x00000154,
    XCN_OID_CERT_MD5_HASH_PROP_ID                         = 0x00000155,
    XCN_OID_RSA_SHA256RSA                                 = 0x00000156,
    XCN_OID_RSA_SHA384RSA                                 = 0x00000157,
    XCN_OID_RSA_SHA512RSA                                 = 0x00000158,
    XCN_OID_NIST_sha256                                   = 0x00000159,
    XCN_OID_NIST_sha384                                   = 0x0000015a,
    XCN_OID_NIST_sha512                                   = 0x0000015b,
    XCN_OID_RSA_MGF1                                      = 0x0000015c,
    XCN_OID_ECC_PUBLIC_KEY                                = 0x0000015d,
    XCN_OID_ECDSA_SHA1                                    = 0x0000015e,
    XCN_OID_ECDSA_SPECIFIED                               = 0x0000015f,
    XCN_OID_ANY_ENHANCED_KEY_USAGE                        = 0x00000160,
    XCN_OID_RSA_SSA_PSS                                   = 0x00000161,
    XCN_OID_ATTR_SUPPORTED_ALGORITHMS                     = 0x00000163,
    XCN_OID_ATTR_TPM_SECURITY_ASSERTIONS                  = 0x00000164,
    XCN_OID_ATTR_TPM_SPECIFICATION                        = 0x00000165,
    XCN_OID_CERT_DISALLOWED_FILETIME_PROP_ID              = 0x00000166,
    XCN_OID_CERT_SIGNATURE_HASH_PROP_ID                   = 0x00000167,
    XCN_OID_CERT_STRONG_KEY_OS_1                          = 0x00000168,
    XCN_OID_CERT_STRONG_KEY_OS_CURRENT                    = 0x00000169,
    XCN_OID_CERT_STRONG_KEY_OS_PREFIX                     = 0x0000016a,
    XCN_OID_CERT_STRONG_SIGN_OS_1                         = 0x0000016b,
    XCN_OID_CERT_STRONG_SIGN_OS_CURRENT                   = 0x0000016c,
    XCN_OID_CERT_STRONG_SIGN_OS_PREFIX                    = 0x0000016d,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA1_KDF                 = 0x0000016e,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA256_KDF               = 0x0000016f,
    XCN_OID_DH_SINGLE_PASS_STDDH_SHA384_KDF               = 0x00000170,
    XCN_OID_DISALLOWED_HASH                               = 0x00000171,
    XCN_OID_DISALLOWED_LIST                               = 0x00000172,
    XCN_OID_ECC_CURVE_P256                                = 0x00000173,
    XCN_OID_ECC_CURVE_P384                                = 0x00000174,
    XCN_OID_ECC_CURVE_P521                                = 0x00000175,
    XCN_OID_ECDSA_SHA256                                  = 0x00000176,
    XCN_OID_ECDSA_SHA384                                  = 0x00000177,
    XCN_OID_ECDSA_SHA512                                  = 0x00000178,
    XCN_OID_ENROLL_CAXCHGCERT_HASH                        = 0x00000179,
    XCN_OID_ENROLL_EK_INFO                                = 0x0000017a,
    XCN_OID_ENROLL_EKPUB_CHALLENGE                        = 0x0000017b,
    XCN_OID_ENROLL_EKVERIFYCERT                           = 0x0000017c,
    XCN_OID_ENROLL_EKVERIFYCREDS                          = 0x0000017d,
    XCN_OID_ENROLL_EKVERIFYKEY                            = 0x0000017e,
    XCN_OID_EV_RDN_COUNTRY                                = 0x0000017f,
    XCN_OID_EV_RDN_LOCALE                                 = 0x00000180,
    XCN_OID_EV_RDN_STATE_OR_PROVINCE                      = 0x00000181,
    XCN_OID_INHIBIT_ANY_POLICY                            = 0x00000182,
    XCN_OID_INTERNATIONALIZED_EMAIL_ADDRESS               = 0x00000183,
    XCN_OID_KP_KERNEL_MODE_CODE_SIGNING                   = 0x00000184,
    XCN_OID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING          = 0x00000185,
    XCN_OID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING           = 0x00000186,
    XCN_OID_KP_TPM_AIK_CERTIFICATE                        = 0x00000187,
    XCN_OID_KP_TPM_EK_CERTIFICATE                         = 0x00000188,
    XCN_OID_KP_TPM_PLATFORM_CERTIFICATE                   = 0x00000189,
    XCN_OID_NIST_AES128_CBC                               = 0x0000018a,
    XCN_OID_NIST_AES128_WRAP                              = 0x0000018b,
    XCN_OID_NIST_AES192_CBC                               = 0x0000018c,
    XCN_OID_NIST_AES192_WRAP                              = 0x0000018d,
    XCN_OID_NIST_AES256_CBC                               = 0x0000018e,
    XCN_OID_NIST_AES256_WRAP                              = 0x0000018f,
    XCN_OID_PKCS_12_PbeIds                                = 0x00000190,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC2               = 0x00000191,
    XCN_OID_PKCS_12_pbeWithSHA1And128BitRC4               = 0x00000192,
    XCN_OID_PKCS_12_pbeWithSHA1And2KeyTripleDES           = 0x00000193,
    XCN_OID_PKCS_12_pbeWithSHA1And3KeyTripleDES           = 0x00000194,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC2                = 0x00000195,
    XCN_OID_PKCS_12_pbeWithSHA1And40BitRC4                = 0x00000196,
    XCN_OID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID = 0x00000197,
    XCN_OID_PKINIT_KP_KDC                                 = 0x00000198,
    XCN_OID_PKIX_CA_REPOSITORY                            = 0x00000199,
    XCN_OID_PKIX_OCSP_NONCE                               = 0x0000019a,
    XCN_OID_PKIX_TIME_STAMPING                            = 0x0000019b,
    XCN_OID_QC_EU_COMPLIANCE                              = 0x0000019c,
    XCN_OID_QC_SSCD                                       = 0x0000019d,
    XCN_OID_QC_STATEMENTS_EXT                             = 0x0000019e,
    XCN_OID_RDN_TPM_MANUFACTURER                          = 0x0000019f,
    XCN_OID_RDN_TPM_MODEL                                 = 0x000001a0,
    XCN_OID_RDN_TPM_VERSION                               = 0x000001a1,
    XCN_OID_REVOKED_LIST_SIGNER                           = 0x000001a2,
    XCN_OID_RFC3161_counterSign                           = 0x000001a3,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION        = 0x000001a4,
    XCN_OID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION       = 0x000001a5,
    XCN_OID_ROOT_PROGRAM_FLAGS                            = 0x000001a6,
    XCN_OID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL          = 0x000001a7,
    XCN_OID_RSA_PSPECIFIED                                = 0x000001a8,
    XCN_OID_RSAES_OAEP                                    = 0x000001a9,
    XCN_OID_SUBJECT_INFO_ACCESS                           = 0x000001aa,
    XCN_OID_TIMESTAMP_TOKEN                               = 0x000001ab,
    XCN_OID_ENROLL_SCEP_ERROR                             = 0x000001ac,
    XCN_OIDVerisign_MessageType                           = 0x000001ad,
    XCN_OIDVerisign_PkiStatus                             = 0x000001ae,
    XCN_OIDVerisign_FailInfo                              = 0x000001af,
    XCN_OIDVerisign_SenderNonce                           = 0x000001b0,
    XCN_OIDVerisign_RecipientNonce                        = 0x000001b1,
    XCN_OIDVerisign_TransactionID                         = 0x000001b2,
    XCN_OID_ENROLL_ATTESTATION_CHALLENGE                  = 0x000001b3,
    XCN_OID_ENROLL_ATTESTATION_STATEMENT                  = 0x000001b4,
    XCN_OID_ENROLL_ENCRYPTION_ALGORITHM                   = 0x000001b5,
    XCN_OID_ENROLL_KSP_NAME                               = 0x000001b6,
}
alias CERTENROLL_OBJECTID = int;

enum WebSecurityLevel : int
{
    LevelUnsafe = 0x00000000,
    LevelSafe   = 0x00000001,
}

enum EncodingType : int
{
    XCN_CRYPT_STRING_BASE64HEADER        = 0x00000000,
    XCN_CRYPT_STRING_BASE64              = 0x00000001,
    XCN_CRYPT_STRING_BINARY              = 0x00000002,
    XCN_CRYPT_STRING_BASE64REQUESTHEADER = 0x00000003,
    XCN_CRYPT_STRING_HEX                 = 0x00000004,
    XCN_CRYPT_STRING_HEXASCII            = 0x00000005,
    XCN_CRYPT_STRING_BASE64_ANY          = 0x00000006,
    XCN_CRYPT_STRING_ANY                 = 0x00000007,
    XCN_CRYPT_STRING_HEX_ANY             = 0x00000008,
    XCN_CRYPT_STRING_BASE64X509CRLHEADER = 0x00000009,
    XCN_CRYPT_STRING_HEXADDR             = 0x0000000a,
    XCN_CRYPT_STRING_HEXASCIIADDR        = 0x0000000b,
    XCN_CRYPT_STRING_HEXRAW              = 0x0000000c,
    XCN_CRYPT_STRING_BASE64URI           = 0x0000000d,
    XCN_CRYPT_STRING_ENCODEMASK          = 0x000000ff,
    XCN_CRYPT_STRING_CHAIN               = 0x00000100,
    XCN_CRYPT_STRING_TEXT                = 0x00000200,
    XCN_CRYPT_STRING_PERCENTESCAPE       = 0x08000000,
    XCN_CRYPT_STRING_HASHDATA            = 0x10000000,
    XCN_CRYPT_STRING_STRICT              = 0x20000000,
    XCN_CRYPT_STRING_NOCRLF              = 0x40000000,
    XCN_CRYPT_STRING_NOCR                = 0x80000000,
}

enum PFXExportOptions : int
{
    PFXExportEEOnly        = 0x00000000,
    PFXExportChainNoRoot   = 0x00000001,
    PFXExportChainWithRoot = 0x00000002,
}

enum ObjectIdGroupId : int
{
    XCN_CRYPT_ANY_GROUP_ID                     = 0x00000000,
    XCN_CRYPT_HASH_ALG_OID_GROUP_ID            = 0x00000001,
    XCN_CRYPT_ENCRYPT_ALG_OID_GROUP_ID         = 0x00000002,
    XCN_CRYPT_PUBKEY_ALG_OID_GROUP_ID          = 0x00000003,
    XCN_CRYPT_SIGN_ALG_OID_GROUP_ID            = 0x00000004,
    XCN_CRYPT_RDN_ATTR_OID_GROUP_ID            = 0x00000005,
    XCN_CRYPT_EXT_OR_ATTR_OID_GROUP_ID         = 0x00000006,
    XCN_CRYPT_ENHKEY_USAGE_OID_GROUP_ID        = 0x00000007,
    XCN_CRYPT_POLICY_OID_GROUP_ID              = 0x00000008,
    XCN_CRYPT_TEMPLATE_OID_GROUP_ID            = 0x00000009,
    XCN_CRYPT_KDF_OID_GROUP_ID                 = 0x0000000a,
    XCN_CRYPT_LAST_OID_GROUP_ID                = 0x0000000a,
    XCN_CRYPT_FIRST_ALG_OID_GROUP_ID           = 0x00000001,
    XCN_CRYPT_LAST_ALG_OID_GROUP_ID            = 0x00000004,
    XCN_CRYPT_GROUP_ID_MASK                    = 0x0000ffff,
    XCN_CRYPT_OID_PREFER_CNG_ALGID_FLAG        = 0x40000000,
    XCN_CRYPT_OID_DISABLE_SEARCH_DS_FLAG       = 0x80000000,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK  = 0x0fff0000,
    XCN_CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT = 0x00000010,
    XCN_CRYPT_KEY_LENGTH_MASK                  = 0x0fff0000,
}

enum ObjectIdPublicKeyFlags : int
{
    XCN_CRYPT_OID_INFO_PUBKEY_ANY              = 0x00000000,
    XCN_CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG    = 0x80000000,
    XCN_CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG = 0x40000000,
}

enum AlgorithmFlags : int
{
    AlgorithmFlagsNone = 0x00000000,
    AlgorithmFlagsWrap = 0x00000001,
}

enum X500NameFlags : int
{
    XCN_CERT_NAME_STR_NONE                      = 0x00000000,
    XCN_CERT_SIMPLE_NAME_STR                    = 0x00000001,
    XCN_CERT_OID_NAME_STR                       = 0x00000002,
    XCN_CERT_X500_NAME_STR                      = 0x00000003,
    XCN_CERT_XML_NAME_STR                       = 0x00000004,
    XCN_CERT_NAME_STR_SEMICOLON_FLAG            = 0x40000000,
    XCN_CERT_NAME_STR_NO_PLUS_FLAG              = 0x20000000,
    XCN_CERT_NAME_STR_NO_QUOTING_FLAG           = 0x10000000,
    XCN_CERT_NAME_STR_CRLF_FLAG                 = 0x08000000,
    XCN_CERT_NAME_STR_COMMA_FLAG                = 0x04000000,
    XCN_CERT_NAME_STR_REVERSE_FLAG              = 0x02000000,
    XCN_CERT_NAME_STR_FORWARD_FLAG              = 0x01000000,
    XCN_CERT_NAME_STR_AMBIGUOUS_SEPARATOR_FLAGS = 0x4c000000,
    XCN_CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG     = 0x00010000,
    XCN_CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG   = 0x00020000,
    XCN_CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG  = 0x00040000,
    XCN_CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG   = 0x00080000,
    XCN_CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG = 0x00100000,
    XCN_CERT_NAME_STR_ENABLE_PUNYCODE_FLAG      = 0x00200000,
    XCN_CERT_NAME_STR_DS_ESCAPED                = 0x00800000,
}

enum X509CertificateEnrollmentContext : int
{
    ContextNone                      = 0x00000000,
    ContextUser                      = 0x00000001,
    ContextMachine                   = 0x00000002,
    ContextAdministratorForceMachine = 0x00000003,
}

enum EnrollmentEnrollStatus : int
{
    Enrolled                           = 0x00000001,
    EnrollPended                       = 0x00000002,
    EnrollUIDeferredEnrollmentRequired = 0x00000004,
    EnrollError                        = 0x00000010,
    EnrollUnknown                      = 0x00000020,
    EnrollSkipped                      = 0x00000040,
    EnrollDenied                       = 0x00000100,
}

enum EnrollmentSelectionStatus : int
{
    SelectedNo  = 0x00000000,
    SelectedYes = 0x00000001,
}

enum EnrollmentDisplayStatus : int
{
    DisplayNo  = 0x00000000,
    DisplayYes = 0x00000001,
}

enum X509ProviderType : int
{
    XCN_PROV_NONE          = 0x00000000,
    XCN_PROV_RSA_FULL      = 0x00000001,
    XCN_PROV_RSA_SIG       = 0x00000002,
    XCN_PROV_DSS           = 0x00000003,
    XCN_PROV_FORTEZZA      = 0x00000004,
    XCN_PROV_MS_EXCHANGE   = 0x00000005,
    XCN_PROV_SSL           = 0x00000006,
    XCN_PROV_RSA_SCHANNEL  = 0x0000000c,
    XCN_PROV_DSS_DH        = 0x0000000d,
    XCN_PROV_EC_ECDSA_SIG  = 0x0000000e,
    XCN_PROV_EC_ECNRA_SIG  = 0x0000000f,
    XCN_PROV_EC_ECDSA_FULL = 0x00000010,
    XCN_PROV_EC_ECNRA_FULL = 0x00000011,
    XCN_PROV_DH_SCHANNEL   = 0x00000012,
    XCN_PROV_SPYRUS_LYNKS  = 0x00000014,
    XCN_PROV_RNG           = 0x00000015,
    XCN_PROV_INTEL_SEC     = 0x00000016,
    XCN_PROV_REPLACE_OWF   = 0x00000017,
    XCN_PROV_RSA_AES       = 0x00000018,
}

enum AlgorithmType : int
{
    XCN_BCRYPT_UNKNOWN_INTERFACE               = 0x00000000,
    XCN_BCRYPT_CIPHER_INTERFACE                = 0x00000001,
    XCN_BCRYPT_HASH_INTERFACE                  = 0x00000002,
    XCN_BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE = 0x00000003,
    XCN_BCRYPT_SIGNATURE_INTERFACE             = 0x00000005,
    XCN_BCRYPT_SECRET_AGREEMENT_INTERFACE      = 0x00000004,
    XCN_BCRYPT_RNG_INTERFACE                   = 0x00000006,
    XCN_BCRYPT_KEY_DERIVATION_INTERFACE        = 0x00000007,
}

enum AlgorithmOperationFlags : int
{
    XCN_NCRYPT_NO_OPERATION                    = 0x00000000,
    XCN_NCRYPT_CIPHER_OPERATION                = 0x00000001,
    XCN_NCRYPT_HASH_OPERATION                  = 0x00000002,
    XCN_NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION = 0x00000004,
    XCN_NCRYPT_SECRET_AGREEMENT_OPERATION      = 0x00000008,
    XCN_NCRYPT_SIGNATURE_OPERATION             = 0x00000010,
    XCN_NCRYPT_RNG_OPERATION                   = 0x00000020,
    XCN_NCRYPT_KEY_DERIVATION_OPERATION        = 0x00000040,
    XCN_NCRYPT_ANY_ASYMMETRIC_OPERATION        = 0x0000001c,
    XCN_NCRYPT_PREFER_SIGNATURE_ONLY_OPERATION = 0x00200000,
    XCN_NCRYPT_PREFER_NON_SIGNATURE_OPERATION  = 0x00400000,
    XCN_NCRYPT_EXACT_MATCH_OPERATION           = 0x00800000,
    XCN_NCRYPT_PREFERENCE_MASK_OPERATION       = 0x00e00000,
}

enum X509KeySpec : int
{
    XCN_AT_NONE        = 0x00000000,
    XCN_AT_KEYEXCHANGE = 0x00000001,
    XCN_AT_SIGNATURE   = 0x00000002,
}

enum KeyIdentifierHashAlgorithm : int
{
    SKIHashDefault  = 0x00000000,
    SKIHashSha1     = 0x00000001,
    SKIHashCapiSha1 = 0x00000002,
    SKIHashSha256   = 0x00000003,
    SKIHashHPKP     = 0x00000005,
}

enum X509PrivateKeyExportFlags : int
{
    XCN_NCRYPT_ALLOW_EXPORT_NONE              = 0x00000000,
    XCN_NCRYPT_ALLOW_EXPORT_FLAG              = 0x00000001,
    XCN_NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG    = 0x00000002,
    XCN_NCRYPT_ALLOW_ARCHIVING_FLAG           = 0x00000004,
    XCN_NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG = 0x00000008,
}

enum X509PrivateKeyUsageFlags : int
{
    XCN_NCRYPT_ALLOW_USAGES_NONE        = 0x00000000,
    XCN_NCRYPT_ALLOW_DECRYPT_FLAG       = 0x00000001,
    XCN_NCRYPT_ALLOW_SIGNING_FLAG       = 0x00000002,
    XCN_NCRYPT_ALLOW_KEY_AGREEMENT_FLAG = 0x00000004,
    XCN_NCRYPT_ALLOW_KEY_IMPORT_FLAG    = 0x00000008,
    XCN_NCRYPT_ALLOW_ALL_USAGES         = 0x00ffffff,
}

enum X509PrivateKeyProtection : int
{
    XCN_NCRYPT_UI_NO_PROTECTION_FLAG              = 0x00000000,
    XCN_NCRYPT_UI_PROTECT_KEY_FLAG                = 0x00000001,
    XCN_NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG      = 0x00000002,
    XCN_NCRYPT_UI_FINGERPRINT_PROTECTION_FLAG     = 0x00000004,
    XCN_NCRYPT_UI_APPCONTAINER_ACCESS_MEDIUM_FLAG = 0x00000008,
}

enum X509PrivateKeyVerify : int
{
    VerifyNone            = 0x00000000,
    VerifySilent          = 0x00000001,
    VerifySmartCardNone   = 0x00000002,
    VerifySmartCardSilent = 0x00000003,
    VerifyAllowUI         = 0x00000004,
}

enum X509HardwareKeyUsageFlags : int
{
    XCN_NCRYPT_PCP_NONE           = 0x00000000,
    XCN_NCRYPT_TPM12_PROVIDER     = 0x00010000,
    XCN_NCRYPT_PCP_SIGNATURE_KEY  = 0x00000001,
    XCN_NCRYPT_PCP_ENCRYPTION_KEY = 0x00000002,
    XCN_NCRYPT_PCP_GENERIC_KEY    = 0x00000003,
    XCN_NCRYPT_PCP_STORAGE_KEY    = 0x00000004,
    XCN_NCRYPT_PCP_IDENTITY_KEY   = 0x00000008,
}

enum X509KeyParametersExportType : int
{
    XCN_CRYPT_OID_USE_CURVE_NONE                       = 0x00000000,
    XCN_CRYPT_OID_USE_CURVE_NAME_FOR_ENCODE_FLAG       = 0x20000000,
    XCN_CRYPT_OID_USE_CURVE_PARAMETERS_FOR_ENCODE_FLAG = 0x10000000,
}

enum X509KeyUsageFlags : int
{
    XCN_CERT_NO_KEY_USAGE                = 0x00000000,
    XCN_CERT_DIGITAL_SIGNATURE_KEY_USAGE = 0x00000080,
    XCN_CERT_NON_REPUDIATION_KEY_USAGE   = 0x00000040,
    XCN_CERT_KEY_ENCIPHERMENT_KEY_USAGE  = 0x00000020,
    XCN_CERT_DATA_ENCIPHERMENT_KEY_USAGE = 0x00000010,
    XCN_CERT_KEY_AGREEMENT_KEY_USAGE     = 0x00000008,
    XCN_CERT_KEY_CERT_SIGN_KEY_USAGE     = 0x00000004,
    XCN_CERT_OFFLINE_CRL_SIGN_KEY_USAGE  = 0x00000002,
    XCN_CERT_CRL_SIGN_KEY_USAGE          = 0x00000002,
    XCN_CERT_ENCIPHER_ONLY_KEY_USAGE     = 0x00000001,
    XCN_CERT_DECIPHER_ONLY_KEY_USAGE     = 0x00008000,
}

enum AlternativeNameType : int
{
    XCN_CERT_ALT_NAME_UNKNOWN             = 0x00000000,
    XCN_CERT_ALT_NAME_OTHER_NAME          = 0x00000001,
    XCN_CERT_ALT_NAME_RFC822_NAME         = 0x00000002,
    XCN_CERT_ALT_NAME_DNS_NAME            = 0x00000003,
    XCN_CERT_ALT_NAME_X400_ADDRESS        = 0x00000004,
    XCN_CERT_ALT_NAME_DIRECTORY_NAME      = 0x00000005,
    XCN_CERT_ALT_NAME_EDI_PARTY_NAME      = 0x00000006,
    XCN_CERT_ALT_NAME_URL                 = 0x00000007,
    XCN_CERT_ALT_NAME_IP_ADDRESS          = 0x00000008,
    XCN_CERT_ALT_NAME_REGISTERED_ID       = 0x00000009,
    XCN_CERT_ALT_NAME_GUID                = 0x0000000a,
    XCN_CERT_ALT_NAME_USER_PRINCIPLE_NAME = 0x0000000b,
}

enum PolicyQualifierType : int
{
    PolicyQualifierTypeUnknown    = 0x00000000,
    PolicyQualifierTypeUrl        = 0x00000001,
    PolicyQualifierTypeUserNotice = 0x00000002,
    PolicyQualifierTypeFlags      = 0x00000003,
}

enum RequestClientInfoClientId : int
{
    ClientIdNone           = 0x00000000,
    ClientIdXEnroll2003    = 0x00000001,
    ClientIdAutoEnroll2003 = 0x00000002,
    ClientIdWizard2003     = 0x00000003,
    ClientIdCertReq2003    = 0x00000004,
    ClientIdDefaultRequest = 0x00000005,
    ClientIdAutoEnroll     = 0x00000006,
    ClientIdRequestWizard  = 0x00000007,
    ClientIdEOBO           = 0x00000008,
    ClientIdCertReq        = 0x00000009,
    ClientIdTest           = 0x0000000a,
    ClientIdWinRT          = 0x0000000b,
    ClientIdUserStart      = 0x000003e8,
}

enum : int
{
    XCN_PROPERTYID_NONE                                      = 0x00000000,
    XCN_CERT_KEY_PROV_HANDLE_PROP_ID                         = 0x00000001,
    XCN_CERT_KEY_PROV_INFO_PROP_ID                           = 0x00000002,
    XCN_CERT_SHA1_HASH_PROP_ID                               = 0x00000003,
    XCN_CERT_MD5_HASH_PROP_ID                                = 0x00000004,
    XCN_CERT_HASH_PROP_ID                                    = 0x00000003,
    XCN_CERT_KEY_CONTEXT_PROP_ID                             = 0x00000005,
    XCN_CERT_KEY_SPEC_PROP_ID                                = 0x00000006,
    XCN_CERT_IE30_RESERVED_PROP_ID                           = 0x00000007,
    XCN_CERT_PUBKEY_HASH_RESERVED_PROP_ID                    = 0x00000008,
    XCN_CERT_ENHKEY_USAGE_PROP_ID                            = 0x00000009,
    XCN_CERT_CTL_USAGE_PROP_ID                               = 0x00000009,
    XCN_CERT_NEXT_UPDATE_LOCATION_PROP_ID                    = 0x0000000a,
    XCN_CERT_FRIENDLY_NAME_PROP_ID                           = 0x0000000b,
    XCN_CERT_PVK_FILE_PROP_ID                                = 0x0000000c,
    XCN_CERT_DESCRIPTION_PROP_ID                             = 0x0000000d,
    XCN_CERT_ACCESS_STATE_PROP_ID                            = 0x0000000e,
    XCN_CERT_SIGNATURE_HASH_PROP_ID                          = 0x0000000f,
    XCN_CERT_SMART_CARD_DATA_PROP_ID                         = 0x00000010,
    XCN_CERT_EFS_PROP_ID                                     = 0x00000011,
    XCN_CERT_FORTEZZA_DATA_PROP_ID                           = 0x00000012,
    XCN_CERT_ARCHIVED_PROP_ID                                = 0x00000013,
    XCN_CERT_KEY_IDENTIFIER_PROP_ID                          = 0x00000014,
    XCN_CERT_AUTO_ENROLL_PROP_ID                             = 0x00000015,
    XCN_CERT_PUBKEY_ALG_PARA_PROP_ID                         = 0x00000016,
    XCN_CERT_CROSS_CERT_DIST_POINTS_PROP_ID                  = 0x00000017,
    XCN_CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID              = 0x00000018,
    XCN_CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID             = 0x00000019,
    XCN_CERT_ENROLLMENT_PROP_ID                              = 0x0000001a,
    XCN_CERT_DATE_STAMP_PROP_ID                              = 0x0000001b,
    XCN_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID           = 0x0000001c,
    XCN_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID                   = 0x0000001d,
    XCN_CERT_EXTENDED_ERROR_INFO_PROP_ID                     = 0x0000001e,
    XCN_CERT_RENEWAL_PROP_ID                                 = 0x00000040,
    XCN_CERT_ARCHIVED_KEY_HASH_PROP_ID                       = 0x00000041,
    XCN_CERT_AUTO_ENROLL_RETRY_PROP_ID                       = 0x00000042,
    XCN_CERT_AIA_URL_RETRIEVED_PROP_ID                       = 0x00000043,
    XCN_CERT_AUTHORITY_INFO_ACCESS_PROP_ID                   = 0x00000044,
    XCN_CERT_BACKED_UP_PROP_ID                               = 0x00000045,
    XCN_CERT_OCSP_RESPONSE_PROP_ID                           = 0x00000046,
    XCN_CERT_REQUEST_ORIGINATOR_PROP_ID                      = 0x00000047,
    XCN_CERT_SOURCE_LOCATION_PROP_ID                         = 0x00000048,
    XCN_CERT_SOURCE_URL_PROP_ID                              = 0x00000049,
    XCN_CERT_NEW_KEY_PROP_ID                                 = 0x0000004a,
    XCN_CERT_OCSP_CACHE_PREFIX_PROP_ID                       = 0x0000004b,
    XCN_CERT_SMART_CARD_ROOT_INFO_PROP_ID                    = 0x0000004c,
    XCN_CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID                    = 0x0000004d,
    XCN_CERT_NCRYPT_KEY_HANDLE_PROP_ID                       = 0x0000004e,
    XCN_CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID         = 0x0000004f,
    XCN_CERT_SUBJECT_INFO_ACCESS_PROP_ID                     = 0x00000050,
    XCN_CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID           = 0x00000051,
    XCN_CERT_CA_DISABLE_CRL_PROP_ID                          = 0x00000052,
    XCN_CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID              = 0x00000053,
    XCN_CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID           = 0x00000054,
    XCN_CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID      = 0x00000055,
    XCN_CERT_SUBJECT_DISABLE_CRL_PROP_ID                     = 0x00000056,
    XCN_CERT_CEP_PROP_ID                                     = 0x00000057,
    XCN_CERT_SIGN_HASH_CNG_ALG_PROP_ID                       = 0x00000059,
    XCN_CERT_SCARD_PIN_ID_PROP_ID                            = 0x0000005a,
    XCN_CERT_SCARD_PIN_INFO_PROP_ID                          = 0x0000005b,
    XCN_CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID              = 0x0000005c,
    XCN_CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID              = 0x0000005d,
    XCN_CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID               = 0x0000005e,
    XCN_CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID          = 0x0000005f,
    XCN_CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 0x00000060,
    XCN_CERT_NO_EXPIRE_NOTIFICATION_PROP_ID                  = 0x00000061,
    XCN_CERT_AUTH_ROOT_SHA256_HASH_PROP_ID                   = 0x00000062,
    XCN_CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID              = 0x00000063,
    XCN_CERT_HCRYPTPROV_TRANSFER_PROP_ID                     = 0x00000064,
    XCN_CERT_SMART_CARD_READER_PROP_ID                       = 0x00000065,
    XCN_CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID                  = 0x00000066,
    XCN_CERT_KEY_REPAIR_ATTEMPTED_PROP_ID                    = 0x00000067,
    XCN_CERT_DISALLOWED_FILETIME_PROP_ID                     = 0x00000068,
    XCN_CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID             = 0x00000069,
    XCN_CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID         = 0x0000006a,
    XCN_CERT_SHA256_HASH_PROP_ID                             = 0x0000006b,
    XCN_CERT_SCEP_SERVER_CERTS_PROP_ID                       = 0x0000006c,
    XCN_CERT_SCEP_RA_SIGNATURE_CERT_PROP_ID                  = 0x0000006d,
    XCN_CERT_SCEP_RA_ENCRYPTION_CERT_PROP_ID                 = 0x0000006e,
    XCN_CERT_SCEP_CA_CERT_PROP_ID                            = 0x0000006f,
    XCN_CERT_SCEP_SIGNER_CERT_PROP_ID                        = 0x00000070,
    XCN_CERT_SCEP_NONCE_PROP_ID                              = 0x00000071,
    XCN_CERT_SCEP_ENCRYPT_HASH_CNG_ALG_PROP_ID               = 0x00000072,
    XCN_CERT_SCEP_FLAGS_PROP_ID                              = 0x00000073,
    XCN_CERT_SCEP_GUID_PROP_ID                               = 0x00000074,
    XCN_CERT_SERIALIZABLE_KEY_CONTEXT_PROP_ID                = 0x00000075,
    XCN_CERT_ISOLATED_KEY_PROP_ID                            = 0x00000076,
    XCN_CERT_SERIAL_CHAIN_PROP_ID                            = 0x00000077,
    XCN_CERT_KEY_CLASSIFICATION_PROP_ID                      = 0x00000078,
    XCN_CERT_DISALLOWED_ENHKEY_USAGE_PROP_ID                 = 0x0000007a,
    XCN_CERT_NONCOMPLIANT_ROOT_URL_PROP_ID                   = 0x0000007b,
    XCN_CERT_PIN_SHA256_HASH_PROP_ID                         = 0x0000007c,
    XCN_CERT_CLR_DELETE_KEY_PROP_ID                          = 0x0000007d,
    XCN_CERT_NOT_BEFORE_FILETIME_PROP_ID                     = 0x0000007e,
    XCN_CERT_CERT_NOT_BEFORE_ENHKEY_USAGE_PROP_ID            = 0x0000007f,
    XCN_CERT_FIRST_RESERVED_PROP_ID                          = 0x00000080,
    XCN_CERT_LAST_RESERVED_PROP_ID                           = 0x00007fff,
    XCN_CERT_FIRST_USER_PROP_ID                              = 0x00008000,
    XCN_CERT_LAST_USER_PROP_ID                               = 0x0000ffff,
    XCN_CERT_STORE_LOCALIZED_NAME_PROP_ID                    = 0x00001000,
}
alias CERTENROLL_PROPERTYID = int;

enum EnrollmentPolicyServerPropertyFlags : int
{
    DefaultNone         = 0x00000000,
    DefaultPolicyServer = 0x00000001,
}

enum PolicyServerUrlFlags : int
{
    PsfNone                  = 0x00000000,
    PsfLocationGroupPolicy   = 0x00000001,
    PsfLocationRegistry      = 0x00000002,
    PsfUseClientId           = 0x00000004,
    PsfAutoEnrollmentEnabled = 0x00000010,
    PsfAllowUnTrustedCA      = 0x00000020,
}

enum EnrollmentTemplateProperty : int
{
    TemplatePropCommonName            = 0x00000001,
    TemplatePropFriendlyName          = 0x00000002,
    TemplatePropEKUs                  = 0x00000003,
    TemplatePropCryptoProviders       = 0x00000004,
    TemplatePropMajorRevision         = 0x00000005,
    TemplatePropDescription           = 0x00000006,
    TemplatePropKeySpec               = 0x00000007,
    TemplatePropSchemaVersion         = 0x00000008,
    TemplatePropMinorRevision         = 0x00000009,
    TemplatePropRASignatureCount      = 0x0000000a,
    TemplatePropMinimumKeySize        = 0x0000000b,
    TemplatePropOID                   = 0x0000000c,
    TemplatePropSupersede             = 0x0000000d,
    TemplatePropRACertificatePolicies = 0x0000000e,
    TemplatePropRAEKUs                = 0x0000000f,
    TemplatePropCertificatePolicies   = 0x00000010,
    TemplatePropV1ApplicationPolicy   = 0x00000011,
    TemplatePropAsymmetricAlgorithm   = 0x00000012,
    TemplatePropKeySecurityDescriptor = 0x00000013,
    TemplatePropSymmetricAlgorithm    = 0x00000014,
    TemplatePropSymmetricKeyLength    = 0x00000015,
    TemplatePropHashAlgorithm         = 0x00000016,
    TemplatePropKeyUsage              = 0x00000017,
    TemplatePropEnrollmentFlags       = 0x00000018,
    TemplatePropSubjectNameFlags      = 0x00000019,
    TemplatePropPrivateKeyFlags       = 0x0000001a,
    TemplatePropGeneralFlags          = 0x0000001b,
    TemplatePropSecurityDescriptor    = 0x0000001c,
    TemplatePropExtensions            = 0x0000001d,
    TemplatePropValidityPeriod        = 0x0000001e,
    TemplatePropRenewalPeriod         = 0x0000001f,
}

enum CommitTemplateFlags : int
{
    CommitFlagSaveTemplateGenerateOID   = 0x00000001,
    CommitFlagSaveTemplateUseCurrentOID = 0x00000002,
    CommitFlagSaveTemplateOverwrite     = 0x00000003,
    CommitFlagDeleteTemplate            = 0x00000004,
}

enum EnrollmentCAProperty : int
{
    CAPropCommonName         = 0x00000001,
    CAPropDistinguishedName  = 0x00000002,
    CAPropSanitizedName      = 0x00000003,
    CAPropSanitizedShortName = 0x00000004,
    CAPropDNSName            = 0x00000005,
    CAPropCertificateTypes   = 0x00000006,
    CAPropCertificate        = 0x00000007,
    CAPropDescription        = 0x00000008,
    CAPropWebServers         = 0x00000009,
    CAPropSiteName           = 0x0000000a,
    CAPropSecurity           = 0x0000000b,
    CAPropRenewalOnly        = 0x0000000c,
}

enum X509EnrollmentPolicyLoadOption : int
{
    LoadOptionDefault              = 0x00000000,
    LoadOptionCacheOnly            = 0x00000001,
    LoadOptionReload               = 0x00000002,
    LoadOptionRegisterForADChanges = 0x00000004,
}

enum EnrollmentPolicyFlags : int
{
    DisableGroupPolicyList = 0x00000002,
    DisableUserServerList  = 0x00000004,
}

enum : int
{
    PsPolicyID     = 0x00000000,
    PsFriendlyName = 0x00000001,
}
alias PolicyServerUrlPropertyID = int;

enum X509EnrollmentPolicyExportFlags : int
{
    ExportTemplates = 0x00000001,
    ExportOIDs      = 0x00000002,
    ExportCAs       = 0x00000004,
}

enum X509RequestType : int
{
    TypeAny         = 0x00000000,
    TypePkcs10      = 0x00000001,
    TypePkcs7       = 0x00000002,
    TypeCmc         = 0x00000003,
    TypeCertificate = 0x00000004,
}

enum X509RequestInheritOptions : int
{
    InheritDefault                = 0x00000000,
    InheritNewDefaultKey          = 0x00000001,
    InheritNewSimilarKey          = 0x00000002,
    InheritPrivateKey             = 0x00000003,
    InheritPublicKey              = 0x00000004,
    InheritKeyMask                = 0x0000000f,
    InheritNone                   = 0x00000010,
    InheritRenewalCertificateFlag = 0x00000020,
    InheritTemplateFlag           = 0x00000040,
    InheritSubjectFlag            = 0x00000080,
    InheritExtensionsFlag         = 0x00000100,
    InheritSubjectAltNameFlag     = 0x00000200,
    InheritValidityPeriodFlag     = 0x00000400,
    InheritReserved80000000       = 0x80000000,
}

enum InnerRequestLevel : int
{
    LevelInnermost = 0x00000000,
    LevelNext      = 0x00000001,
}

enum Pkcs10AllowedSignatureTypes : int
{
    AllowedKeySignature  = 0x00000001,
    AllowedNullSignature = 0x00000002,
}

enum KeyAttestationClaimType : int
{
    XCN_NCRYPT_CLAIM_NONE                  = 0x00000000,
    XCN_NCRYPT_CLAIM_AUTHORITY_AND_SUBJECT = 0x00000003,
    XCN_NCRYPT_CLAIM_AUTHORITY_ONLY        = 0x00000001,
    XCN_NCRYPT_CLAIM_SUBJECT_ONLY          = 0x00000002,
    XCN_NCRYPT_CLAIM_UNKNOWN               = 0x00001000,
}

enum InstallResponseRestrictionFlags : int
{
    AllowNone                 = 0x00000000,
    AllowNoOutstandingRequest = 0x00000001,
    AllowUntrustedCertificate = 0x00000002,
    AllowUntrustedRoot        = 0x00000004,
}

enum WebEnrollmentFlags : int
{
    EnrollPrompt = 0x00000001,
}

enum CRLRevocationReason : int
{
    XCN_CRL_REASON_UNSPECIFIED            = 0x00000000,
    XCN_CRL_REASON_KEY_COMPROMISE         = 0x00000001,
    XCN_CRL_REASON_CA_COMPROMISE          = 0x00000002,
    XCN_CRL_REASON_AFFILIATION_CHANGED    = 0x00000003,
    XCN_CRL_REASON_SUPERSEDED             = 0x00000004,
    XCN_CRL_REASON_CESSATION_OF_OPERATION = 0x00000005,
    XCN_CRL_REASON_CERTIFICATE_HOLD       = 0x00000006,
    XCN_CRL_REASON_REMOVE_FROM_CRL        = 0x00000008,
    XCN_CRL_REASON_PRIVILEGE_WITHDRAWN    = 0x00000009,
    XCN_CRL_REASON_AA_COMPROMISE          = 0x0000000a,
}

enum X509SCEPProcessMessageFlags : int
{
    SCEPProcessDefault         = 0x00000000,
    SCEPProcessSkipCertInstall = 0x00000001,
}

enum DelayRetryAction : int
{
    DelayRetryUnknown     = 0x00000000,
    DelayRetryNone        = 0x00000001,
    DelayRetryShort       = 0x00000002,
    DelayRetryLong        = 0x00000003,
    DelayRetrySuccess     = 0x00000004,
    DelayRetryPastSuccess = 0x00000005,
}

enum X509CertificateTemplateGeneralFlag : int
{
    GeneralMachineType  = 0x00000040,
    GeneralCA           = 0x00000080,
    GeneralCrossCA      = 0x00000800,
    GeneralDefault      = 0x00010000,
    GeneralModified     = 0x00020000,
    GeneralDonotPersist = 0x00001000,
}

enum X509CertificateTemplateEnrollmentFlag : int
{
    EnrollmentIncludeSymmetricAlgorithms                   = 0x00000001,
    EnrollmentPendAllRequests                              = 0x00000002,
    EnrollmentPublishToKRAContainer                        = 0x00000004,
    EnrollmentPublishToDS                                  = 0x00000008,
    EnrollmentAutoEnrollmentCheckUserDSCertificate         = 0x00000010,
    EnrollmentAutoEnrollment                               = 0x00000020,
    EnrollmentDomainAuthenticationNotRequired              = 0x00000080,
    EnrollmentPreviousApprovalValidateReenrollment         = 0x00000040,
    EnrollmentUserInteractionRequired                      = 0x00000100,
    EnrollmentAddTemplateName                              = 0x00000200,
    EnrollmentRemoveInvalidCertificateFromPersonalStore    = 0x00000400,
    EnrollmentAllowEnrollOnBehalfOf                        = 0x00000800,
    EnrollmentAddOCSPNoCheck                               = 0x00001000,
    EnrollmentReuseKeyOnFullSmartCard                      = 0x00002000,
    EnrollmentNoRevocationInfoInCerts                      = 0x00004000,
    EnrollmentIncludeBasicConstraintsForEECerts            = 0x00008000,
    EnrollmentPreviousApprovalKeyBasedValidateReenrollment = 0x00010000,
    EnrollmentCertificateIssuancePoliciesFromRequest       = 0x00020000,
    EnrollmentSkipAutoRenewal                              = 0x00040000,
}

enum X509CertificateTemplateSubjectNameFlag : int
{
    SubjectNameEnrolleeSupplies                  = 0x00000001,
    SubjectNameRequireDirectoryPath              = 0x80000000,
    SubjectNameRequireCommonName                 = 0x40000000,
    SubjectNameRequireEmail                      = 0x20000000,
    SubjectNameRequireDNS                        = 0x10000000,
    SubjectNameAndAlternativeNameOldCertSupplies = 0x00000008,
    SubjectAlternativeNameEnrolleeSupplies       = 0x00010000,
    SubjectAlternativeNameRequireDirectoryGUID   = 0x01000000,
    SubjectAlternativeNameRequireUPN             = 0x02000000,
    SubjectAlternativeNameRequireEmail           = 0x04000000,
    SubjectAlternativeNameRequireSPN             = 0x00800000,
    SubjectAlternativeNameRequireDNS             = 0x08000000,
    SubjectAlternativeNameRequireDomainDNS       = 0x00400000,
}

enum X509CertificateTemplatePrivateKeyFlag : int
{
    PrivateKeyRequireArchival                    = 0x00000001,
    PrivateKeyExportable                         = 0x00000010,
    PrivateKeyRequireStrongKeyProtection         = 0x00000020,
    PrivateKeyRequireAlternateSignatureAlgorithm = 0x00000040,
    PrivateKeyRequireSameKeyRenewal              = 0x00000080,
    PrivateKeyUseLegacyProvider                  = 0x00000100,
    PrivateKeyEKTrustOnUse                       = 0x00000200,
    PrivateKeyEKValidateCert                     = 0x00000400,
    PrivateKeyEKValidateKey                      = 0x00000800,
    PrivateKeyAttestNone                         = 0x00000000,
    PrivateKeyAttestPreferred                    = 0x00001000,
    PrivateKeyAttestRequired                     = 0x00002000,
    PrivateKeyAttestMask                         = 0x00003000,
    PrivateKeyAttestWithoutPolicy                = 0x00004000,
    PrivateKeyServerVersionMask                  = 0x000f0000,
    PrivateKeyServerVersionShift                 = 0x00000010,
    PrivateKeyHelloKspKey                        = 0x00100000,
    PrivateKeyHelloLogonKey                      = 0x00200000,
    PrivateKeyClientVersionMask                  = 0x0f000000,
    PrivateKeyClientVersionShift                 = 0x00000018,
}

enum ImportPFXFlags : int
{
    ImportNone                = 0x00000000,
    ImportMachineContext      = 0x00000001,
    ImportForceOverwrite      = 0x00000002,
    ImportSilent              = 0x00000004,
    ImportSaveProperties      = 0x00000008,
    ImportExportable          = 0x00000010,
    ImportExportableEncrypted = 0x00000020,
    ImportNoUserProtected     = 0x00000040,
    ImportUserProtected       = 0x00000080,
    ImportUserProtectedHigh   = 0x00000100,
    ImportInstallCertificate  = 0x00000200,
    ImportInstallChain        = 0x00000400,
    ImportInstallChainAndRoot = 0x00000800,
}

enum : int
{
    TOKENBINDING_TYPE_PROVIDED = 0x00000000,
    TOKENBINDING_TYPE_REFERRED = 0x00000001,
}
alias TOKENBINDING_TYPE = int;

enum : int
{
    TOKENBINDING_EXTENSION_FORMAT_UNDEFINED = 0x00000000,
}
alias TOKENBINDING_EXTENSION_FORMAT = int;

enum : int
{
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PKCS = 0x00000000,
    TOKENBINDING_KEY_PARAMETERS_TYPE_RSA2048_PSS  = 0x00000001,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ECDSAP256    = 0x00000002,
    TOKENBINDING_KEY_PARAMETERS_TYPE_ANYEXISTING  = 0x000000ff,
}
alias TOKENBINDING_KEY_PARAMETERS_TYPE = int;

enum : int
{
    CRYPT_XML_CHARSET_AUTO    = 0x00000000,
    CRYPT_XML_CHARSET_UTF8    = 0x00000001,
    CRYPT_XML_CHARSET_UTF16LE = 0x00000002,
    CRYPT_XML_CHARSET_UTF16BE = 0x00000003,
}
alias CRYPT_XML_CHARSET = int;

enum : int
{
    CRYPT_XML_PROPERTY_MAX_HEAP_SIZE      = 0x00000001,
    CRYPT_XML_PROPERTY_SIGNATURE_LOCATION = 0x00000002,
    CRYPT_XML_PROPERTY_MAX_SIGNATURES     = 0x00000003,
    CRYPT_XML_PROPERTY_DOC_DECLARATION    = 0x00000004,
    CRYPT_XML_PROPERTY_XML_OUTPUT_CHARSET = 0x00000005,
}
alias CRYPT_XML_PROPERTY_ID = int;

enum : int
{
    CRYPT_XML_KEYINFO_SPEC_NONE    = 0x00000000,
    CRYPT_XML_KEYINFO_SPEC_ENCODED = 0x00000001,
    CRYPT_XML_KEYINFO_SPEC_PARAM   = 0x00000002,
}
alias CRYPT_XML_KEYINFO_SPEC = int;

enum CASetupProperty : int
{
    ENUM_SETUPPROP_INVALID            = 0xffffffff,
    ENUM_SETUPPROP_CATYPE             = 0x00000000,
    ENUM_SETUPPROP_CAKEYINFORMATION   = 0x00000001,
    ENUM_SETUPPROP_INTERACTIVE        = 0x00000002,
    ENUM_SETUPPROP_CANAME             = 0x00000003,
    ENUM_SETUPPROP_CADSSUFFIX         = 0x00000004,
    ENUM_SETUPPROP_VALIDITYPERIOD     = 0x00000005,
    ENUM_SETUPPROP_VALIDITYPERIODUNIT = 0x00000006,
    ENUM_SETUPPROP_EXPIRATIONDATE     = 0x00000007,
    ENUM_SETUPPROP_PRESERVEDATABASE   = 0x00000008,
    ENUM_SETUPPROP_DATABASEDIRECTORY  = 0x00000009,
    ENUM_SETUPPROP_LOGDIRECTORY       = 0x0000000a,
    ENUM_SETUPPROP_SHAREDFOLDER       = 0x0000000b,
    ENUM_SETUPPROP_PARENTCAMACHINE    = 0x0000000c,
    ENUM_SETUPPROP_PARENTCANAME       = 0x0000000d,
    ENUM_SETUPPROP_REQUESTFILE        = 0x0000000e,
    ENUM_SETUPPROP_WEBCAMACHINE       = 0x0000000f,
    ENUM_SETUPPROP_WEBCANAME          = 0x00000010,
}

enum MSCEPSetupProperty : int
{
    ENUM_CEPSETUPPROP_USELOCALSYSTEM         = 0x00000000,
    ENUM_CEPSETUPPROP_USECHALLENGE           = 0x00000001,
    ENUM_CEPSETUPPROP_RANAME_CN              = 0x00000002,
    ENUM_CEPSETUPPROP_RANAME_EMAIL           = 0x00000003,
    ENUM_CEPSETUPPROP_RANAME_COMPANY         = 0x00000004,
    ENUM_CEPSETUPPROP_RANAME_DEPT            = 0x00000005,
    ENUM_CEPSETUPPROP_RANAME_CITY            = 0x00000006,
    ENUM_CEPSETUPPROP_RANAME_STATE           = 0x00000007,
    ENUM_CEPSETUPPROP_RANAME_COUNTRY         = 0x00000008,
    ENUM_CEPSETUPPROP_SIGNINGKEYINFORMATION  = 0x00000009,
    ENUM_CEPSETUPPROP_EXCHANGEKEYINFORMATION = 0x0000000a,
    ENUM_CEPSETUPPROP_CAINFORMATION          = 0x0000000b,
    ENUM_CEPSETUPPROP_MSCEPURL               = 0x0000000c,
    ENUM_CEPSETUPPROP_CHALLENGEURL           = 0x0000000d,
}

enum CESSetupProperty : int
{
    ENUM_CESSETUPPROP_USE_IISAPPPOOLIDENTITY = 0x00000000,
    ENUM_CESSETUPPROP_CACONFIG               = 0x00000001,
    ENUM_CESSETUPPROP_AUTHENTICATION         = 0x00000002,
    ENUM_CESSETUPPROP_SSLCERTHASH            = 0x00000003,
    ENUM_CESSETUPPROP_URL                    = 0x00000004,
    ENUM_CESSETUPPROP_RENEWALONLY            = 0x00000005,
    ENUM_CESSETUPPROP_ALLOW_KEYBASED_RENEWAL = 0x00000006,
}

enum CEPSetupProperty : int
{
    ENUM_CEPSETUPPROP_AUTHENTICATION   = 0x00000000,
    ENUM_CEPSETUPPROP_SSLCERTHASH      = 0x00000001,
    ENUM_CEPSETUPPROP_URL              = 0x00000002,
    ENUM_CEPSETUPPROP_KEYBASED_RENEWAL = 0x00000003,
}

enum OCSPSigningFlag : int
{
    OCSP_SF_SILENT                           = 0x00000001,
    OCSP_SF_USE_CACERT                       = 0x00000002,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTORENEWAL    = 0x00000004,
    OCSP_SF_FORCE_SIGNINGCERT_ISSUER_ISCA    = 0x00000008,
    OCSP_SF_AUTODISCOVER_SIGNINGCERT         = 0x00000010,
    OCSP_SF_MANUAL_ASSIGN_SIGNINGCERT        = 0x00000020,
    OCSP_SF_RESPONDER_ID_KEYHASH             = 0x00000040,
    OCSP_SF_RESPONDER_ID_NAME                = 0x00000080,
    OCSP_SF_ALLOW_NONCE_EXTENSION            = 0x00000100,
    OCSP_SF_ALLOW_SIGNINGCERT_AUTOENROLLMENT = 0x00000200,
}

enum OCSPRequestFlag : int
{
    OCSP_RF_REJECT_SIGNED_REQUESTS = 0x00000001,
}

enum : int
{
    ENUM_ENTERPRISE_ROOTCA = 0x00000000,
    ENUM_ENTERPRISE_SUBCA  = 0x00000001,
    ENUM_STANDALONE_ROOTCA = 0x00000003,
    ENUM_STANDALONE_SUBCA  = 0x00000004,
    ENUM_UNKNOWN_CA        = 0x00000005,
}
alias ENUM_CATYPES = int;

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
alias ENUM_PERIOD = int;

enum : int
{
    SceSvcConfigurationInfo = 0x00000000,
    SceSvcMergedPolicyInfo  = 0x00000001,
    SceSvcAnalysisInfo      = 0x00000002,
    SceSvcInternalUse       = 0x00000003,
}
alias SCESVC_INFO_TYPE = int;

enum : int
{
    SaferPolicyLevelList                    = 0x00000001,
    SaferPolicyEnableTransparentEnforcement = 0x00000002,
    SaferPolicyDefaultLevel                 = 0x00000003,
    SaferPolicyEvaluateUserScope            = 0x00000004,
    SaferPolicyScopeFlags                   = 0x00000005,
    SaferPolicyDefaultLevelFlags            = 0x00000006,
    SaferPolicyAuthenticodeEnabled          = 0x00000007,
}
alias SAFER_POLICY_INFO_CLASS = int;

enum : int
{
    SaferObjectLevelId                 = 0x00000001,
    SaferObjectScopeId                 = 0x00000002,
    SaferObjectFriendlyName            = 0x00000003,
    SaferObjectDescription             = 0x00000004,
    SaferObjectBuiltin                 = 0x00000005,
    SaferObjectDisallowed              = 0x00000006,
    SaferObjectDisableMaxPrivilege     = 0x00000007,
    SaferObjectInvertDeletedPrivileges = 0x00000008,
    SaferObjectDeletedPrivileges       = 0x00000009,
    SaferObjectDefaultOwner            = 0x0000000a,
    SaferObjectSidsToDisable           = 0x0000000b,
    SaferObjectRestrictedSidsInverted  = 0x0000000c,
    SaferObjectRestrictedSidsAdded     = 0x0000000d,
    SaferObjectAllIdentificationGuids  = 0x0000000e,
    SaferObjectSingleIdentification    = 0x0000000f,
    SaferObjectExtendedError           = 0x00000010,
}
alias SAFER_OBJECT_INFO_CLASS = int;

enum : int
{
    SaferIdentityDefault         = 0x00000000,
    SaferIdentityTypeImageName   = 0x00000001,
    SaferIdentityTypeImageHash   = 0x00000002,
    SaferIdentityTypeUrlZone     = 0x00000003,
    SaferIdentityTypeCertificate = 0x00000004,
}
alias SAFER_IDENTIFICATION_TYPES = int;

enum : uint
{
    SL_DATA_NONE     = 0x00000000,
    SL_DATA_SZ       = 0x00000001,
    SL_DATA_DWORD    = 0x00000004,
    SL_DATA_BINARY   = 0x00000003,
    SL_DATA_MULTI_SZ = 0x00000007,
    SL_DATA_SUM      = 0x00000064,
}
alias SLDATATYPE = uint;

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
alias SLIDTYPE = int;

enum : int
{
    SL_LICENSING_STATUS_UNLICENSED      = 0x00000000,
    SL_LICENSING_STATUS_LICENSED        = 0x00000001,
    SL_LICENSING_STATUS_IN_GRACE_PERIOD = 0x00000002,
    SL_LICENSING_STATUS_NOTIFICATION    = 0x00000003,
    SL_LICENSING_STATUS_LAST            = 0x00000004,
}
alias SLLICENSINGSTATUS = int;

enum : int
{
    SL_ACTIVATION_TYPE_DEFAULT          = 0x00000000,
    SL_ACTIVATION_TYPE_ACTIVE_DIRECTORY = 0x00000001,
}
alias SL_ACTIVATION_TYPE = int;

enum : int
{
    SL_REFERRALTYPE_SKUID          = 0x00000000,
    SL_REFERRALTYPE_APPID          = 0x00000001,
    SL_REFERRALTYPE_OVERRIDE_SKUID = 0x00000002,
    SL_REFERRALTYPE_OVERRIDE_APPID = 0x00000003,
    SL_REFERRALTYPE_BEST_MATCH     = 0x00000004,
}
alias SLREFERRALTYPE = int;

enum : int
{
    SL_GEN_STATE_IS_GENUINE      = 0x00000000,
    SL_GEN_STATE_INVALID_LICENSE = 0x00000001,
    SL_GEN_STATE_TAMPERED        = 0x00000002,
    SL_GEN_STATE_OFFLINE         = 0x00000003,
    SL_GEN_STATE_LAST            = 0x00000004,
}
alias SL_GENUINE_STATE = int;

enum DdqAccessLevel : int
{
    NoData          = 0x00000000,
    CurrentUserData = 0x00000001,
    AllUserData     = 0x00000002,
}

enum : int
{
    ProcessMemoryPriority        = 0x00000000,
    ProcessMemoryExhaustionInfo  = 0x00000001,
    ProcessAppMemoryInfo         = 0x00000002,
    ProcessInPrivateInfo         = 0x00000003,
    ProcessPowerThrottling       = 0x00000004,
    ProcessReservedValue1        = 0x00000005,
    ProcessTelemetryCoverageInfo = 0x00000006,
    ProcessProtectionLevelInfo   = 0x00000007,
    ProcessLeapSecondInfo        = 0x00000008,
    ProcessInformationClassMax   = 0x00000009,
}
alias PROCESS_INFORMATION_CLASS = int;

// Constants


enum : const(wchar)*
{
    wszCMM_PROP_NAME            = "Name",
    wszCMM_PROP_DESCRIPTION     = "Description",
    wszCMM_PROP_COPYRIGHT       = "Copyright",
    wszCMM_PROP_FILEVER         = "File Version",
    wszCMM_PROP_PRODUCTVER      = "Product Version",
    wszCMM_PROP_DISPLAY_HWND    = "HWND",
    wszCMM_PROP_ISMULTITHREADED = "IsMultiThreaded",
}

// Callbacks

alias PFN_NCRYPT_ALLOC = void* function(size_t cbSize);
alias PFN_NCRYPT_FREE = void function(void* pv);
alias PCRYPT_DECRYPT_PRIVATE_KEY_FUNC = BOOL function(CRYPT_ALGORITHM_IDENTIFIER Algorithm, 
                                                      CRYPTOAPI_BLOB EncryptedPrivateKey, char* pbClearTextKey, 
                                                      uint* pcbClearTextKey, void* pVoidDecryptFunc);
alias PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC = BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pAlgorithm, 
                                                      CRYPTOAPI_BLOB* pClearTextPrivateKey, char* pbEncryptedKey, 
                                                      uint* pcbEncryptedKey, void* pVoidEncryptFunc);
alias PCRYPT_RESOLVE_HCRYPTPROV_FUNC = BOOL function(CRYPT_PRIVATE_KEY_INFO* pPrivateKeyInfo, size_t* phCryptProv, 
                                                     void* pVoidResolveFunc);
alias PFN_CRYPT_ALLOC = void* function(size_t cbSize);
alias PFN_CRYPT_FREE = void function(void* pv);
alias PFN_CRYPT_ENUM_OID_FUNC = BOOL function(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, 
                                              uint cValue, char* rgdwValueType, char* rgpwszValueName, 
                                              char* rgpbValueData, char* rgcbValueData, void* pvArg);
alias PFN_CRYPT_ENUM_OID_INFO = BOOL function(CRYPT_OID_INFO* pInfo, void* pvArg);
alias PFN_CMSG_STREAM_OUTPUT = BOOL function(const(void)* pvArg, char* pbData, uint cbData, BOOL fFinal);
alias PFN_CMSG_ALLOC = void* function(size_t cb);
alias PFN_CMSG_FREE = void function(void* pv);
alias PFN_CMSG_GEN_ENCRYPT_KEY = BOOL function(size_t* phCryptProv, CRYPT_ALGORITHM_IDENTIFIER* paiEncrypt, 
                                               void* pvEncryptAuxInfo, CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, 
                                               PFN_CMSG_ALLOC pfnAlloc, size_t* phEncryptKey, 
                                               ubyte** ppbEncryptParameters, uint* pcbEncryptParameters);
alias PFN_CMSG_EXPORT_ENCRYPT_KEY = BOOL function(size_t hCryptProv, size_t hEncryptKey, 
                                                  CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, char* pbData, uint* pcbData);
alias PFN_CMSG_IMPORT_ENCRYPT_KEY = BOOL function(size_t hCryptProv, uint dwKeySpec, 
                                                  CRYPT_ALGORITHM_IDENTIFIER* paiEncrypt, 
                                                  CRYPT_ALGORITHM_IDENTIFIER* paiPubKey, char* pbEncodedKey, 
                                                  uint cbEncodedKey, size_t* phEncryptKey);
alias PFN_CMSG_GEN_CONTENT_ENCRYPT_KEY = BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, 
                                                       uint dwFlags, void* pvReserved);
alias PFN_CMSG_EXPORT_KEY_TRANS = BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, 
                                                CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO* pKeyTransEncodeInfo, 
                                                CMSG_KEY_TRANS_ENCRYPT_INFO* pKeyTransEncryptInfo, uint dwFlags, 
                                                void* pvReserved);
alias PFN_CMSG_EXPORT_KEY_AGREE = BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, 
                                                CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO* pKeyAgreeEncodeInfo, 
                                                CMSG_KEY_AGREE_ENCRYPT_INFO* pKeyAgreeEncryptInfo, uint dwFlags, 
                                                void* pvReserved);
alias PFN_CMSG_EXPORT_MAIL_LIST = BOOL function(CMSG_CONTENT_ENCRYPT_INFO* pContentEncryptInfo, 
                                                CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO* pMailListEncodeInfo, 
                                                CMSG_MAIL_LIST_ENCRYPT_INFO* pMailListEncryptInfo, uint dwFlags, 
                                                void* pvReserved);
alias PFN_CMSG_IMPORT_KEY_TRANS = BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, 
                                                CMSG_CTRL_KEY_TRANS_DECRYPT_PARA* pKeyTransDecryptPara, uint dwFlags, 
                                                void* pvReserved, size_t* phContentEncryptKey);
alias PFN_CMSG_IMPORT_KEY_AGREE = BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, 
                                                CMSG_CTRL_KEY_AGREE_DECRYPT_PARA* pKeyAgreeDecryptPara, uint dwFlags, 
                                                void* pvReserved, size_t* phContentEncryptKey);
alias PFN_CMSG_IMPORT_MAIL_LIST = BOOL function(CRYPT_ALGORITHM_IDENTIFIER* pContentEncryptionAlgorithm, 
                                                CMSG_CTRL_MAIL_LIST_DECRYPT_PARA* pMailListDecryptPara, uint dwFlags, 
                                                void* pvReserved, size_t* phContentEncryptKey);
alias PFN_CMSG_CNG_IMPORT_KEY_TRANS = BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, 
                                                    CMSG_CTRL_KEY_TRANS_DECRYPT_PARA* pKeyTransDecryptPara, 
                                                    uint dwFlags, void* pvReserved);
alias PFN_CMSG_CNG_IMPORT_KEY_AGREE = BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, 
                                                    CMSG_CTRL_KEY_AGREE_DECRYPT_PARA* pKeyAgreeDecryptPara, 
                                                    uint dwFlags, void* pvReserved);
alias PFN_CMSG_CNG_IMPORT_CONTENT_ENCRYPT_KEY = BOOL function(CMSG_CNG_CONTENT_DECRYPT_INFO* pCNGContentDecryptInfo, 
                                                              uint dwFlags, void* pvReserved);
alias PFN_CERT_DLL_OPEN_STORE_PROV_FUNC = BOOL function(const(char)* lpszStoreProvider, uint dwEncodingType, 
                                                        size_t hCryptProv, uint dwFlags, const(void)* pvPara, 
                                                        void* hCertStore, CERT_STORE_PROV_INFO* pStoreProvInfo);
alias PFN_CERT_STORE_PROV_CLOSE = void function(void* hStoreProv, uint dwFlags);
alias PFN_CERT_STORE_PROV_READ_CERT = BOOL function(void* hStoreProv, CERT_CONTEXT* pStoreCertContext, 
                                                    uint dwFlags, CERT_CONTEXT** ppProvCertContext);
alias PFN_CERT_STORE_PROV_WRITE_CERT = BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CERT = BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CERT_PROPERTY = BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, 
                                                            uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_READ_CRL = BOOL function(void* hStoreProv, CRL_CONTEXT* pStoreCrlContext, uint dwFlags, 
                                                   CRL_CONTEXT** ppProvCrlContext);
alias PFN_CERT_STORE_PROV_WRITE_CRL = BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CRL = BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CRL_PROPERTY = BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, 
                                                           uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_READ_CTL = BOOL function(void* hStoreProv, CTL_CONTEXT* pStoreCtlContext, uint dwFlags, 
                                                   CTL_CONTEXT** ppProvCtlContext);
alias PFN_CERT_STORE_PROV_WRITE_CTL = BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_DELETE_CTL = BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, uint dwFlags);
alias PFN_CERT_STORE_PROV_SET_CTL_PROPERTY = BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, 
                                                           uint dwPropId, uint dwFlags, const(void)* pvData);
alias PFN_CERT_STORE_PROV_CONTROL = BOOL function(void* hStoreProv, uint dwFlags, uint dwCtrlType, 
                                                  const(void)* pvCtrlPara);
alias PFN_CERT_STORE_PROV_FIND_CERT = BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, 
                                                    CERT_CONTEXT* pPrevCertContext, uint dwFlags, 
                                                    void** ppvStoreProvFindInfo, CERT_CONTEXT** ppProvCertContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CERT = BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, 
                                                         void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CERT_PROPERTY = BOOL function(void* hStoreProv, CERT_CONTEXT* pCertContext, 
                                                            uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
alias PFN_CERT_STORE_PROV_FIND_CRL = BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, 
                                                   CRL_CONTEXT* pPrevCrlContext, uint dwFlags, 
                                                   void** ppvStoreProvFindInfo, CRL_CONTEXT** ppProvCrlContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CRL = BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, 
                                                        void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CRL_PROPERTY = BOOL function(void* hStoreProv, CRL_CONTEXT* pCrlContext, 
                                                           uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
alias PFN_CERT_STORE_PROV_FIND_CTL = BOOL function(void* hStoreProv, CERT_STORE_PROV_FIND_INFO* pFindInfo, 
                                                   CTL_CONTEXT* pPrevCtlContext, uint dwFlags, 
                                                   void** ppvStoreProvFindInfo, CTL_CONTEXT** ppProvCtlContext);
alias PFN_CERT_STORE_PROV_FREE_FIND_CTL = BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, 
                                                        void* pvStoreProvFindInfo, uint dwFlags);
alias PFN_CERT_STORE_PROV_GET_CTL_PROPERTY = BOOL function(void* hStoreProv, CTL_CONTEXT* pCtlContext, 
                                                           uint dwPropId, uint dwFlags, char* pvData, uint* pcbData);
alias PFN_CERT_CREATE_CONTEXT_SORT_FUNC = BOOL function(uint cbTotalEncoded, uint cbRemainEncoded, uint cEntry, 
                                                        void* pvSort);
alias PFN_CERT_ENUM_SYSTEM_STORE_LOCATION = BOOL function(const(wchar)* pwszStoreLocation, uint dwFlags, 
                                                          void* pvReserved, void* pvArg);
alias PFN_CERT_ENUM_SYSTEM_STORE = BOOL function(const(void)* pvSystemStore, uint dwFlags, 
                                                 CERT_SYSTEM_STORE_INFO* pStoreInfo, void* pvReserved, void* pvArg);
alias PFN_CERT_ENUM_PHYSICAL_STORE = BOOL function(const(void)* pvSystemStore, uint dwFlags, 
                                                   const(wchar)* pwszStoreName, CERT_PHYSICAL_STORE_INFO* pStoreInfo, 
                                                   void* pvReserved, void* pvArg);
alias PFN_CRYPT_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC = BOOL function(uint dwCertEncodingType, 
                                                                          CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, 
                                                                          void** ppvDecodedSignPara, 
                                                                          ushort** ppwszCNGHashAlgid);
alias PFN_CRYPT_SIGN_AND_ENCODE_HASH_FUNC = BOOL function(size_t hKey, uint dwCertEncodingType, 
                                                          CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, 
                                                          void* pvDecodedSignPara, const(wchar)* pwszCNGPubKeyAlgid, 
                                                          const(wchar)* pwszCNGHashAlgid, char* pbComputedHash, 
                                                          uint cbComputedHash, char* pbSignature, uint* pcbSignature);
alias PFN_CRYPT_VERIFY_ENCODED_SIGNATURE_FUNC = BOOL function(uint dwCertEncodingType, 
                                                              CERT_PUBLIC_KEY_INFO* pPubKeyInfo, 
                                                              CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, 
                                                              void* pvDecodedSignPara, 
                                                              const(wchar)* pwszCNGPubKeyAlgid, 
                                                              const(wchar)* pwszCNGHashAlgid, char* pbComputedHash, 
                                                              uint cbComputedHash, char* pbSignature, 
                                                              uint cbSignature);
alias PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC = BOOL function(size_t hNCryptKey, uint dwCertEncodingType, 
                                                                const(char)* pszPublicKeyObjId, uint dwFlags, 
                                                                void* pvAuxInfo, char* pInfo, uint* pcbInfo);
alias PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC = BOOL function(void* hBCryptKey, 
                                                                               uint dwCertEncodingType, 
                                                                               const(char)* pszPublicKeyObjId, 
                                                                               uint dwFlags, void* pvAuxInfo, 
                                                                               char* pInfo, uint* pcbInfo);
alias PFN_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC = BOOL function(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, 
                                                          uint dwFlags, void* pvAuxInfo, void** phKey);
alias PFN_IMPORT_PRIV_KEY_FUNC = BOOL function(size_t hCryptProv, CRYPT_PRIVATE_KEY_INFO* pPrivateKeyInfo, 
                                               uint dwFlags, void* pvAuxInfo);
alias PFN_EXPORT_PRIV_KEY_FUNC = BOOL function(size_t hCryptProv, uint dwKeySpec, const(char)* pszPrivateKeyObjId, 
                                               uint dwFlags, void* pvAuxInfo, char* pPrivateKeyInfo, 
                                               uint* pcbPrivateKeyInfo);
alias PFN_CRYPT_GET_SIGNER_CERTIFICATE = CERT_CONTEXT* function(void* pvGetArg, uint dwCertEncodingType, 
                                                                CERT_INFO* pSignerId, void* hMsgCertStore);
alias PFN_CRYPT_ASYNC_PARAM_FREE_FUNC = void function(const(char)* pszParamOid, void* pvParam);
alias PFN_FREE_ENCODED_OBJECT_FUNC = void function(const(char)* pszObjectOid, CRYPT_BLOB_ARRAY* pObject, 
                                                   void* pvFreeContext);
alias PFN_CRYPT_CANCEL_RETRIEVAL = BOOL function(uint dwFlags, void* pvArg);
alias PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC = void function(void* pvCompletion, uint dwCompletionCode, 
                                                                const(char)* pszUrl, const(char)* pszObjectOid, 
                                                                void* pvObject);
alias PFN_CANCEL_ASYNC_RETRIEVAL_FUNC = BOOL function(HCRYPTASYNC hAsyncRetrieve);
alias PFN_CRYPT_ENUM_KEYID_PROP = BOOL function(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwFlags, 
                                                void* pvReserved, void* pvArg, uint cProp, char* rgdwPropId, 
                                                char* rgpvData, char* rgcbData);
alias PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK = BOOL function(CERT_CONTEXT* pCert, void* pvFindArg);
alias PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK = void function(CERT_CHAIN_CONTEXT* pChainContext, 
                                                                    CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext, 
                                                                    CRL_CONTEXT* pNewCrlContext, 
                                                                    CRL_CONTEXT* pPrevCrlContext, void* pvArg, 
                                                                    uint dwWriteOcspFileError);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH = BOOL function(void* pContext, char* rgIdentifierOrNameList, 
                                                              uint dwIdentifierOrNameListCount);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET = BOOL function(void* pPluginContext, CRYPTOAPI_BLOB* pIdentifier, 
                                                            uint dwNameType, CRYPTOAPI_BLOB* pNameBlob, 
                                                            ubyte** ppbContent, uint* pcbContent, 
                                                            ushort** ppwszPassword, CRYPTOAPI_BLOB** ppIdentifier);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE = void function(uint dwReason, void* pPluginContext);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD = void function(void* pPluginContext, 
                                                                      const(wchar)* pwszPassword);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE = void function(void* pPluginContext, ubyte* pbData);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER = void function(void* pPluginContext, 
                                                                        CRYPTOAPI_BLOB* pIdentifier);
alias PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_INITIALIZE = BOOL function(PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH pfnFlush, 
                                                                   void* pContext, uint* pdwExpectedObjectCount, 
                                                                   CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE** ppFuncTable, 
                                                                   void** ppPluginContext);
alias PFN_CERT_IS_WEAK_HASH = BOOL function(uint dwHashUseType, const(wchar)* pwszCNGHashAlgid, uint dwChainFlags, 
                                            CERT_CHAIN_CONTEXT* pSignerChainContext, FILETIME* pTimeStamp, 
                                            const(wchar)* pwszFileName);
alias LPOCNCONNPROCA = size_t function(size_t param0, const(char)* param1, const(char)* param2, void* param3);
alias LPOCNCONNPROCW = size_t function(size_t param0, const(wchar)* param1, const(wchar)* param2, void* param3);
alias LPOCNCHKPROC = BOOL function(size_t param0, size_t param1, void* param2);
alias LPOCNDSCPROC = void function(size_t param0, size_t param1, void* param2);
alias SERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, ushort** lpServiceArgVectors);
alias SERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONW = void function(uint dwNumServicesArgs, ushort** lpServiceArgVectors);
alias LPSERVICE_MAIN_FUNCTIONA = void function(uint dwNumServicesArgs, byte** lpServiceArgVectors);
alias HANDLER_FUNCTION = void function(uint dwControl);
alias HANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias LPHANDLER_FUNCTION = void function(uint dwControl);
alias LPHANDLER_FUNCTION_EX = uint function(uint dwControl, uint dwEventType, void* lpEventData, void* lpContext);
alias PFN_SC_NOTIFY_CALLBACK = void function(void* pParameter);
alias SC_NOTIFICATION_CALLBACK = void function(uint dwNotify, void* pCallbackContext);
alias PSC_NOTIFICATION_CALLBACK = void function();
alias PSAM_PASSWORD_NOTIFICATION_ROUTINE = NTSTATUS function(UNICODE_STRING* UserName, uint RelativeId, 
                                                             UNICODE_STRING* NewPassword);
alias PSAM_INIT_NOTIFICATION_ROUTINE = ubyte function();
alias PSAM_PASSWORD_FILTER_ROUTINE = ubyte function(UNICODE_STRING* AccountName, UNICODE_STRING* FullName, 
                                                    UNICODE_STRING* Password, ubyte SetOperation);
alias SEC_GET_KEY_FN = void function(void* Arg, void* Principal, uint KeyVer, void** Key, int* Status);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_W = int function(ushort* param0, ushort* param1, uint param2, void* param3, 
                                                     void* param4, SEC_GET_KEY_FN param5, void* param6, 
                                                     SecHandle* param7, LARGE_INTEGER* param8);
alias ACQUIRE_CREDENTIALS_HANDLE_FN_A = int function(byte* param0, byte* param1, uint param2, void* param3, 
                                                     void* param4, SEC_GET_KEY_FN param5, void* param6, 
                                                     SecHandle* param7, LARGE_INTEGER* param8);
alias FREE_CREDENTIALS_HANDLE_FN = int function(SecHandle* param0);
alias ADD_CREDENTIALS_FN_W = int function(SecHandle* param0, ushort* param1, ushort* param2, uint param3, 
                                          void* param4, SEC_GET_KEY_FN param5, void* param6, LARGE_INTEGER* param7);
alias ADD_CREDENTIALS_FN_A = int function(SecHandle* param0, byte* param1, byte* param2, uint param3, void* param4, 
                                          SEC_GET_KEY_FN param5, void* param6, LARGE_INTEGER* param7);
alias CHANGE_PASSWORD_FN_W = int function(ushort* param0, ushort* param1, ushort* param2, ushort* param3, 
                                          ushort* param4, ubyte param5, uint param6, SecBufferDesc* param7);
alias CHANGE_PASSWORD_FN_A = int function(byte* param0, byte* param1, byte* param2, byte* param3, byte* param4, 
                                          ubyte param5, uint param6, SecBufferDesc* param7);
alias INITIALIZE_SECURITY_CONTEXT_FN_W = int function(SecHandle* param0, SecHandle* param1, ushort* param2, 
                                                      uint param3, uint param4, uint param5, SecBufferDesc* param6, 
                                                      uint param7, SecHandle* param8, SecBufferDesc* param9, 
                                                      uint* param10, LARGE_INTEGER* param11);
alias INITIALIZE_SECURITY_CONTEXT_FN_A = int function(SecHandle* param0, SecHandle* param1, byte* param2, 
                                                      uint param3, uint param4, uint param5, SecBufferDesc* param6, 
                                                      uint param7, SecHandle* param8, SecBufferDesc* param9, 
                                                      uint* param10, LARGE_INTEGER* param11);
alias ACCEPT_SECURITY_CONTEXT_FN = int function(SecHandle* param0, SecHandle* param1, SecBufferDesc* param2, 
                                                uint param3, uint param4, SecHandle* param5, SecBufferDesc* param6, 
                                                uint* param7, LARGE_INTEGER* param8);
alias COMPLETE_AUTH_TOKEN_FN = int function(SecHandle* param0, SecBufferDesc* param1);
alias IMPERSONATE_SECURITY_CONTEXT_FN = int function(SecHandle* param0);
alias REVERT_SECURITY_CONTEXT_FN = int function(SecHandle* param0);
alias QUERY_SECURITY_CONTEXT_TOKEN_FN = int function(SecHandle* param0, void** param1);
alias DELETE_SECURITY_CONTEXT_FN = int function(SecHandle* param0);
alias APPLY_CONTROL_TOKEN_FN = int function(SecHandle* param0, SecBufferDesc* param1);
alias QUERY_CONTEXT_ATTRIBUTES_FN_W = int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_W = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CONTEXT_ATTRIBUTES_FN_A = int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CONTEXT_ATTRIBUTES_EX_FN_A = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_W = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CONTEXT_ATTRIBUTES_FN_A = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_W = int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_W = int function(SecHandle* param0, uint param1, void* param2, 
                                                          uint param3);
alias QUERY_CREDENTIALS_ATTRIBUTES_FN_A = int function(SecHandle* param0, uint param1, void* param2);
alias QUERY_CREDENTIALS_ATTRIBUTES_EX_FN_A = int function(SecHandle* param0, uint param1, void* param2, 
                                                          uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_W = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias SET_CREDENTIALS_ATTRIBUTES_FN_A = int function(SecHandle* param0, uint param1, void* param2, uint param3);
alias FREE_CONTEXT_BUFFER_FN = int function(void* param0);
alias MAKE_SIGNATURE_FN = int function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias VERIFY_SIGNATURE_FN = int function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENCRYPT_MESSAGE_FN = int function(SecHandle* param0, uint param1, SecBufferDesc* param2, uint param3);
alias DECRYPT_MESSAGE_FN = int function(SecHandle* param0, SecBufferDesc* param1, uint param2, uint* param3);
alias ENUMERATE_SECURITY_PACKAGES_FN_W = int function(uint* param0, SecPkgInfoW** param1);
alias ENUMERATE_SECURITY_PACKAGES_FN_A = int function(uint* param0, SecPkgInfoA** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_W = int function(ushort* param0, SecPkgInfoW** param1);
alias QUERY_SECURITY_PACKAGE_INFO_FN_A = int function(byte* param0, SecPkgInfoA** param1);
alias EXPORT_SECURITY_CONTEXT_FN = int function(SecHandle* param0, uint param1, SecBuffer* param2, void** param3);
alias IMPORT_SECURITY_CONTEXT_FN_W = int function(ushort* param0, SecBuffer* param1, void* param2, 
                                                  SecHandle* param3);
alias IMPORT_SECURITY_CONTEXT_FN_A = int function(byte* param0, SecBuffer* param1, void* param2, SecHandle* param3);
alias INIT_SECURITY_INTERFACE_A = SecurityFunctionTableA* function();
alias INIT_SECURITY_INTERFACE_W = SecurityFunctionTableW* function();
alias LSA_CREATE_LOGON_SESSION = NTSTATUS function(LUID* LogonId);
alias LSA_DELETE_LOGON_SESSION = NTSTATUS function(LUID* LogonId);
alias LSA_ADD_CREDENTIAL = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, STRING* PrimaryKeyValue, 
                                             STRING* Credentials);
alias LSA_GET_CREDENTIALS = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, uint* QueryContext, 
                                              ubyte RetrieveAllCredentials, STRING* PrimaryKeyValue, 
                                              uint* PrimaryKeyLength, STRING* Credentials);
alias LSA_DELETE_CREDENTIAL = NTSTATUS function(LUID* LogonId, uint AuthenticationPackage, STRING* PrimaryKeyValue);
alias LSA_ALLOCATE_LSA_HEAP = void* function(uint Length);
alias LSA_FREE_LSA_HEAP = void function(void* Base);
alias LSA_ALLOCATE_PRIVATE_HEAP = void* function(size_t Length);
alias LSA_FREE_PRIVATE_HEAP = void function(void* Base);
alias LSA_ALLOCATE_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint LengthRequired, 
                                                     void** ClientBaseAddress);
alias LSA_FREE_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, void* ClientBaseAddress);
alias LSA_COPY_TO_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint Length, char* ClientBaseAddress, 
                                                    char* BufferToCopy);
alias LSA_COPY_FROM_CLIENT_BUFFER = NTSTATUS function(void** ClientRequest, uint Length, char* BufferToCopy, 
                                                      char* ClientBaseAddress);
alias PLSA_CREATE_LOGON_SESSION = NTSTATUS function();
alias PLSA_DELETE_LOGON_SESSION = NTSTATUS function();
alias PLSA_ADD_CREDENTIAL = NTSTATUS function();
alias PLSA_GET_CREDENTIALS = NTSTATUS function();
alias PLSA_DELETE_CREDENTIAL = NTSTATUS function();
alias PLSA_ALLOCATE_LSA_HEAP = void* function();
alias PLSA_FREE_LSA_HEAP = void function();
alias PLSA_ALLOCATE_PRIVATE_HEAP = void* function();
alias PLSA_FREE_PRIVATE_HEAP = void function();
alias PLSA_ALLOCATE_CLIENT_BUFFER = NTSTATUS function();
alias PLSA_FREE_CLIENT_BUFFER = NTSTATUS function();
alias PLSA_COPY_TO_CLIENT_BUFFER = NTSTATUS function();
alias PLSA_COPY_FROM_CLIENT_BUFFER = NTSTATUS function();
alias LSA_AP_INITIALIZE_PACKAGE = NTSTATUS function(uint AuthenticationPackageId, 
                                                    LSA_DISPATCH_TABLE* LsaDispatchTable, STRING* Database, 
                                                    STRING* Confidentiality, STRING** AuthenticationPackageName);
alias LSA_AP_LOGON_USER = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                            char* AuthenticationInformation, void* ClientAuthenticationBase, 
                                            uint AuthenticationInformationLength, void** ProfileBuffer, 
                                            uint* ProfileBufferLength, LUID* LogonId, int* SubStatus, 
                                            LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                            void** TokenInformation, UNICODE_STRING** AccountName, 
                                            UNICODE_STRING** AuthenticatingAuthority);
alias LSA_AP_LOGON_USER_EX = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                               char* AuthenticationInformation, void* ClientAuthenticationBase, 
                                               uint AuthenticationInformationLength, void** ProfileBuffer, 
                                               uint* ProfileBufferLength, LUID* LogonId, int* SubStatus, 
                                               LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                               void** TokenInformation, UNICODE_STRING** AccountName, 
                                               UNICODE_STRING** AuthenticatingAuthority, 
                                               UNICODE_STRING** MachineName);
alias LSA_AP_CALL_PACKAGE = NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, 
                                              void* ClientBufferBase, uint SubmitBufferLength, 
                                              void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                              int* ProtocolStatus);
alias LSA_AP_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, 
                                                          void* ClientBufferBase, uint SubmitBufferLength, 
                                                          void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                                          int* ProtocolStatus);
alias LSA_AP_LOGON_TERMINATED = void function(LUID* LogonId);
alias LSA_AP_CALL_PACKAGE_UNTRUSTED = NTSTATUS function();
alias PLSA_AP_INITIALIZE_PACKAGE = NTSTATUS function();
alias PLSA_AP_LOGON_USER = NTSTATUS function();
alias PLSA_AP_LOGON_USER_EX = NTSTATUS function();
alias PLSA_AP_CALL_PACKAGE = NTSTATUS function();
alias PLSA_AP_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function();
alias PLSA_AP_LOGON_TERMINATED = void function();
alias PLSA_AP_CALL_PACKAGE_UNTRUSTED = NTSTATUS function();
alias PSAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE = NTSTATUS function(UNICODE_STRING* ClearPassword, 
                                                                char* OldCredentials, uint OldCredentialSize, 
                                                                uint UserAccountControl, UNICODE_STRING* UPN, 
                                                                UNICODE_STRING* UserName, 
                                                                UNICODE_STRING* NetbiosDomainName, 
                                                                UNICODE_STRING* DnsDomainName, void** NewCredentials, 
                                                                uint* NewCredentialSize);
alias PSAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE = ubyte function(UNICODE_STRING* CredentialName);
alias PSAM_CREDENTIAL_UPDATE_FREE_ROUTINE = void function(void* p);
alias PSAM_CREDENTIAL_UPDATE_REGISTER_MAPPED_ENTRYPOINTS_ROUTINE = NTSTATUS function(SAM_REGISTER_MAPPING_TABLE* Table);
alias SEC_THREAD_START = uint function();
alias LSA_CALLBACK_FUNCTION = NTSTATUS function(size_t Argument1, size_t Argument2, SecBuffer* InputBuffer, 
                                                SecBuffer* OutputBuffer);
alias PLSA_CALLBACK_FUNCTION = NTSTATUS function();
alias LSA_REDIRECTED_LOGON_INIT = NTSTATUS function(HANDLE RedirectedLogonHandle, 
                                                    const(UNICODE_STRING)* PackageName, uint SessionId, 
                                                    const(LUID)* LogonId);
alias LSA_REDIRECTED_LOGON_CALLBACK = NTSTATUS function(HANDLE RedirectedLogonHandle, void* Buffer, 
                                                        uint BufferLength, void** ReturnBuffer, 
                                                        uint* ReturnBufferLength);
alias LSA_REDIRECTED_LOGON_CLEANUP_CALLBACK = void function(HANDLE RedirectedLogonHandle);
alias LSA_REDIRECTED_LOGON_GET_LOGON_CREDS = NTSTATUS function(HANDLE RedirectedLogonHandle, ubyte** LogonBuffer, 
                                                               uint* LogonBufferLength);
alias LSA_REDIRECTED_LOGON_GET_SUPP_CREDS = NTSTATUS function(HANDLE RedirectedLogonHandle, 
                                                              SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_REDIRECTED_LOGON_INIT = NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_CALLBACK = NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_GET_LOGON_CREDS = NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_GET_SUPP_CREDS = NTSTATUS function();
alias PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK = void function();
alias LSA_IMPERSONATE_CLIENT = NTSTATUS function();
alias LSA_UNLOAD_PACKAGE = NTSTATUS function();
alias LSA_DUPLICATE_HANDLE = NTSTATUS function(HANDLE SourceHandle, ptrdiff_t* DestionationHandle);
alias LSA_SAVE_SUPPLEMENTAL_CREDENTIALS = NTSTATUS function(LUID* LogonId, uint SupplementalCredSize, 
                                                            char* SupplementalCreds, ubyte Synchronous);
alias LSA_CREATE_THREAD = HANDLE function(SECURITY_ATTRIBUTES* SecurityAttributes, uint StackSize, 
                                          SEC_THREAD_START StartFunction, void* ThreadParameter, uint CreationFlags, 
                                          uint* ThreadId);
alias LSA_GET_CLIENT_INFO = NTSTATUS function(SECPKG_CLIENT_INFO* ClientInfo);
alias LSA_REGISTER_NOTIFICATION = HANDLE function(SEC_THREAD_START StartFunction, void* Parameter, 
                                                  uint NotificationType, uint NotificationClass, 
                                                  uint NotificationFlags, uint IntervalMinutes, HANDLE WaitEvent);
alias LSA_CANCEL_NOTIFICATION = NTSTATUS function(HANDLE NotifyHandle);
alias LSA_MAP_BUFFER = NTSTATUS function(SecBuffer* InputBuffer, SecBuffer* OutputBuffer);
alias LSA_CREATE_TOKEN = NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, 
                                           SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                           LSA_TOKEN_INFORMATION_TYPE TokenInformationType, void* TokenInformation, 
                                           TOKEN_GROUPS* TokenGroups, UNICODE_STRING* AccountName, 
                                           UNICODE_STRING* AuthorityName, UNICODE_STRING* Workstation, 
                                           UNICODE_STRING* ProfilePath, ptrdiff_t* Token, int* SubStatus);
alias LSA_CREATE_TOKEN_EX = NTSTATUS function(LUID* LogonId, TOKEN_SOURCE* TokenSource, 
                                              SECURITY_LOGON_TYPE LogonType, 
                                              SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                              LSA_TOKEN_INFORMATION_TYPE TokenInformationType, 
                                              void* TokenInformation, TOKEN_GROUPS* TokenGroups, 
                                              UNICODE_STRING* Workstation, UNICODE_STRING* ProfilePath, 
                                              void* SessionInformation, 
                                              SECPKG_SESSIONINFO_TYPE SessionInformationType, ptrdiff_t* Token, 
                                              int* SubStatus);
alias LSA_AUDIT_LOGON = void function(NTSTATUS Status, NTSTATUS SubStatus, UNICODE_STRING* AccountName, 
                                      UNICODE_STRING* AuthenticatingAuthority, UNICODE_STRING* WorkstationName, 
                                      void* UserSid, SECURITY_LOGON_TYPE LogonType, TOKEN_SOURCE* TokenSource, 
                                      LUID* LogonId);
alias LSA_CALL_PACKAGE = NTSTATUS function(UNICODE_STRING* AuthenticationPackage, char* ProtocolSubmitBuffer, 
                                           uint SubmitBufferLength, void** ProtocolReturnBuffer, 
                                           uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_CALL_PACKAGEEX = NTSTATUS function(UNICODE_STRING* AuthenticationPackage, void* ClientBufferBase, 
                                             char* ProtocolSubmitBuffer, uint SubmitBufferLength, 
                                             void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                             int* ProtocolStatus);
alias LSA_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function(UNICODE_STRING* AuthenticationPackage, 
                                                       void* ClientBufferBase, char* ProtocolSubmitBuffer, 
                                                       uint SubmitBufferLength, void** ProtocolReturnBuffer, 
                                                       uint* ReturnBufferLength, int* ProtocolStatus);
alias LSA_GET_CALL_INFO = ubyte function(SECPKG_CALL_INFO* Info);
alias LSA_CREATE_SHARED_MEMORY = void* function(uint MaxSize, uint InitialSize);
alias LSA_ALLOCATE_SHARED_MEMORY = void* function(void* SharedMem, uint Size);
alias LSA_FREE_SHARED_MEMORY = void function(void* SharedMem, void* Memory);
alias LSA_DELETE_SHARED_MEMORY = ubyte function(void* SharedMem);
alias LSA_GET_APP_MODE_INFO = NTSTATUS function(uint* UserFunction, uint* Argument1, uint* Argument2, 
                                                SecBuffer* UserData, ubyte* ReturnToLsa);
alias LSA_SET_APP_MODE_INFO = NTSTATUS function(uint UserFunction, size_t Argument1, size_t Argument2, 
                                                SecBuffer* UserData, ubyte ReturnToLsa);
alias LSA_OPEN_SAM_USER = NTSTATUS function(UNICODE_STRING* Name, SECPKG_NAME_TYPE NameType, 
                                            UNICODE_STRING* Prefix, ubyte AllowGuest, uint Reserved, 
                                            void** UserHandle);
alias LSA_GET_USER_CREDENTIALS = NTSTATUS function(void* UserHandle, void** PrimaryCreds, uint* PrimaryCredsSize, 
                                                   void** SupplementalCreds, uint* SupplementalCredsSize);
alias LSA_GET_USER_AUTH_DATA = NTSTATUS function(void* UserHandle, ubyte** UserAuthData, uint* UserAuthDataSize);
alias LSA_CLOSE_SAM_USER = NTSTATUS function(void* UserHandle);
alias LSA_GET_AUTH_DATA_FOR_USER = NTSTATUS function(UNICODE_STRING* Name, SECPKG_NAME_TYPE NameType, 
                                                     UNICODE_STRING* Prefix, ubyte** UserAuthData, 
                                                     uint* UserAuthDataSize, UNICODE_STRING* UserFlatName);
alias LSA_CONVERT_AUTH_DATA_TO_TOKEN = NTSTATUS function(void* UserAuthData, uint UserAuthDataSize, 
                                                         SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                                                         TOKEN_SOURCE* TokenSource, SECURITY_LOGON_TYPE LogonType, 
                                                         UNICODE_STRING* AuthorityName, ptrdiff_t* Token, 
                                                         LUID* LogonId, UNICODE_STRING* AccountName, int* SubStatus);
alias LSA_CRACK_SINGLE_NAME = NTSTATUS function(uint FormatOffered, ubyte PerformAtGC, UNICODE_STRING* NameInput, 
                                                UNICODE_STRING* Prefix, uint RequestedFormat, 
                                                UNICODE_STRING* CrackedName, UNICODE_STRING* DnsDomainName, 
                                                uint* SubStatus);
alias LSA_AUDIT_ACCOUNT_LOGON = NTSTATUS function(uint AuditId, ubyte Success, UNICODE_STRING* Source, 
                                                  UNICODE_STRING* ClientName, UNICODE_STRING* MappedName, 
                                                  NTSTATUS Status);
alias LSA_CLIENT_CALLBACK = NTSTATUS function(const(char)* Callback, size_t Argument1, size_t Argument2, 
                                              SecBuffer* Input, SecBuffer* Output);
alias LSA_REGISTER_CALLBACK = NTSTATUS function(uint CallbackId, PLSA_CALLBACK_FUNCTION Callback);
alias LSA_GET_EXTENDED_CALL_FLAGS = NTSTATUS function(uint* Flags);
alias LSA_UPDATE_PRIMARY_CREDENTIALS = NTSTATUS function(SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                         SECPKG_SUPPLEMENTAL_CRED_ARRAY* Credentials);
alias LSA_PROTECT_MEMORY = void function(char* Buffer, uint BufferSize);
alias LSA_OPEN_TOKEN_BY_LOGON_ID = NTSTATUS function(LUID* LogonId, HANDLE* RetTokenHandle);
alias LSA_EXPAND_AUTH_DATA_FOR_DOMAIN = NTSTATUS function(char* UserAuthData, uint UserAuthDataSize, 
                                                          void* Reserved, ubyte** ExpandedAuthData, 
                                                          uint* ExpandedAuthDataSize);
alias LSA_GET_SERVICE_ACCOUNT_PASSWORD = NTSTATUS function(UNICODE_STRING* AccountName, UNICODE_STRING* DomainName, 
                                                           CRED_FETCH CredFetch, FILETIME* FileTimeExpiry, 
                                                           UNICODE_STRING* CurrentPassword, 
                                                           UNICODE_STRING* PreviousPassword, 
                                                           FILETIME* FileTimeCurrPwdValidForOutbound);
alias LSA_AUDIT_LOGON_EX = void function(NTSTATUS Status, NTSTATUS SubStatus, UNICODE_STRING* AccountName, 
                                         UNICODE_STRING* AuthenticatingAuthority, UNICODE_STRING* WorkstationName, 
                                         void* UserSid, SECURITY_LOGON_TYPE LogonType, 
                                         SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_SOURCE* TokenSource, 
                                         LUID* LogonId);
alias LSA_CHECK_PROTECTED_USER_BY_TOKEN = NTSTATUS function(HANDLE UserToken, ubyte* ProtectedUser);
alias LSA_QUERY_CLIENT_REQUEST = NTSTATUS function(void** ClientRequest, uint QueryType, void** ReplyBuffer);
alias PLSA_IMPERSONATE_CLIENT = NTSTATUS function();
alias PLSA_UNLOAD_PACKAGE = NTSTATUS function();
alias PLSA_DUPLICATE_HANDLE = NTSTATUS function();
alias PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS = NTSTATUS function();
alias PLSA_CREATE_THREAD = HANDLE function();
alias PLSA_GET_CLIENT_INFO = NTSTATUS function();
alias PLSA_REGISTER_NOTIFICATION = HANDLE function();
alias PLSA_CANCEL_NOTIFICATION = NTSTATUS function();
alias PLSA_MAP_BUFFER = NTSTATUS function();
alias PLSA_CREATE_TOKEN = NTSTATUS function();
alias PLSA_AUDIT_LOGON = void function();
alias PLSA_CALL_PACKAGE = NTSTATUS function();
alias PLSA_CALL_PACKAGEEX = NTSTATUS function();
alias PLSA_GET_CALL_INFO = ubyte function();
alias PLSA_CREATE_SHARED_MEMORY = void* function();
alias PLSA_ALLOCATE_SHARED_MEMORY = void* function();
alias PLSA_FREE_SHARED_MEMORY = void function();
alias PLSA_DELETE_SHARED_MEMORY = ubyte function();
alias PLSA_OPEN_SAM_USER = NTSTATUS function();
alias PLSA_GET_USER_CREDENTIALS = NTSTATUS function();
alias PLSA_GET_USER_AUTH_DATA = NTSTATUS function();
alias PLSA_CLOSE_SAM_USER = NTSTATUS function();
alias PLSA_CONVERT_AUTH_DATA_TO_TOKEN = NTSTATUS function();
alias PLSA_CLIENT_CALLBACK = NTSTATUS function();
alias PLSA_REGISTER_CALLBACK = NTSTATUS function();
alias PLSA_UPDATE_PRIMARY_CREDENTIALS = NTSTATUS function();
alias PLSA_GET_AUTH_DATA_FOR_USER = NTSTATUS function();
alias PLSA_CRACK_SINGLE_NAME = NTSTATUS function();
alias PLSA_AUDIT_ACCOUNT_LOGON = NTSTATUS function();
alias PLSA_CALL_PACKAGE_PASSTHROUGH = NTSTATUS function();
alias PLSA_PROTECT_MEMORY = void function();
alias PLSA_OPEN_TOKEN_BY_LOGON_ID = NTSTATUS function();
alias PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN = NTSTATUS function();
alias PLSA_CREATE_TOKEN_EX = NTSTATUS function();
alias PLSA_GET_EXTENDED_CALL_FLAGS = NTSTATUS function();
alias PLSA_GET_SERVICE_ACCOUNT_PASSWORD = NTSTATUS function();
alias PLSA_AUDIT_LOGON_EX = void function();
alias PLSA_CHECK_PROTECTED_USER_BY_TOKEN = NTSTATUS function();
alias PLSA_QUERY_CLIENT_REQUEST = NTSTATUS function();
alias PLSA_GET_APP_MODE_INFO = NTSTATUS function();
alias PLSA_SET_APP_MODE_INFO = NTSTATUS function();
alias CredReadFn = NTSTATUS function(LUID* LogonId, uint CredFlags, const(wchar)* TargetName, uint Type, 
                                     uint Flags, ENCRYPTED_CREDENTIALW** Credential);
alias CredReadDomainCredentialsFn = NTSTATUS function(LUID* LogonId, uint CredFlags, 
                                                      CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, 
                                                      uint* Count, ENCRYPTED_CREDENTIALW*** Credential);
alias CredFreeCredentialsFn = void function(uint Count, char* Credentials);
alias CredWriteFn = NTSTATUS function(LUID* LogonId, uint CredFlags, ENCRYPTED_CREDENTIALW* Credential, uint Flags);
alias CrediUnmarshalandDecodeStringFn = NTSTATUS function(const(wchar)* MarshaledString, ubyte** Blob, 
                                                          uint* BlobSize, ubyte* IsFailureFatal);
alias LSA_LOCATE_PKG_BY_ID = void* function(uint PackgeId);
alias PLSA_LOCATE_PKG_BY_ID = void* function();
alias SpInitializeFn = NTSTATUS function(size_t PackageId, SECPKG_PARAMETERS* Parameters, 
                                         LSA_SECPKG_FUNCTION_TABLE* FunctionTable);
alias SpShutdownFn = NTSTATUS function();
alias SpGetInfoFn = NTSTATUS function(SecPkgInfoA* PackageInfo);
alias SpGetExtendedInformationFn = NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, 
                                                     SECPKG_EXTENDED_INFORMATION** ppInformation);
alias SpSetExtendedInformationFn = NTSTATUS function(SECPKG_EXTENDED_INFORMATION_CLASS Class, 
                                                     SECPKG_EXTENDED_INFORMATION* Info);
alias LSA_AP_LOGON_USER_EX2 = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                char* ProtocolSubmitBuffer, void* ClientBufferBase, 
                                                uint SubmitBufferSize, void** ProfileBuffer, uint* ProfileBufferSize, 
                                                LUID* LogonId, int* SubStatus, 
                                                LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                                void** TokenInformation, UNICODE_STRING** AccountName, 
                                                UNICODE_STRING** AuthenticatingAuthority, 
                                                UNICODE_STRING** MachineName, 
                                                SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_LOGON_USER_EX2 = NTSTATUS function();
alias LSA_AP_LOGON_USER_EX3 = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                char* ProtocolSubmitBuffer, void* ClientBufferBase, 
                                                uint SubmitBufferSize, SECPKG_SURROGATE_LOGON* SurrogateLogon, 
                                                void** ProfileBuffer, uint* ProfileBufferSize, LUID* LogonId, 
                                                int* SubStatus, LSA_TOKEN_INFORMATION_TYPE* TokenInformationType, 
                                                void** TokenInformation, UNICODE_STRING** AccountName, 
                                                UNICODE_STRING** AuthenticatingAuthority, 
                                                UNICODE_STRING** MachineName, 
                                                SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                SECPKG_SUPPLEMENTAL_CRED_ARRAY** SupplementalCredentials);
alias PLSA_AP_LOGON_USER_EX3 = NTSTATUS function();
alias LSA_AP_PRE_LOGON_USER_SURROGATE = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                          char* ProtocolSubmitBuffer, void* ClientBufferBase, 
                                                          uint SubmitBufferSize, 
                                                          SECPKG_SURROGATE_LOGON* SurrogateLogon, int* SubStatus);
alias PLSA_AP_PRE_LOGON_USER_SURROGATE = NTSTATUS function();
alias LSA_AP_POST_LOGON_USER_SURROGATE = NTSTATUS function(void** ClientRequest, SECURITY_LOGON_TYPE LogonType, 
                                                           char* ProtocolSubmitBuffer, void* ClientBufferBase, 
                                                           uint SubmitBufferSize, 
                                                           SECPKG_SURROGATE_LOGON* SurrogateLogon, 
                                                           char* ProfileBuffer, uint ProfileBufferSize, 
                                                           LUID* LogonId, NTSTATUS Status, NTSTATUS SubStatus, 
                                                           LSA_TOKEN_INFORMATION_TYPE TokenInformationType, 
                                                           void* TokenInformation, UNICODE_STRING* AccountName, 
                                                           UNICODE_STRING* AuthenticatingAuthority, 
                                                           UNICODE_STRING* MachineName, 
                                                           SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                           SECPKG_SUPPLEMENTAL_CRED_ARRAY* SupplementalCredentials);
alias PLSA_AP_POST_LOGON_USER_SURROGATE = NTSTATUS function();
alias SpAcceptCredentialsFn = NTSTATUS function(SECURITY_LOGON_TYPE LogonType, UNICODE_STRING* AccountName, 
                                                SECPKG_PRIMARY_CRED* PrimaryCredentials, 
                                                SECPKG_SUPPLEMENTAL_CRED* SupplementalCredentials);
alias SpAcquireCredentialsHandleFn = NTSTATUS function(UNICODE_STRING* PrincipalName, uint CredentialUseFlags, 
                                                       LUID* LogonId, void* AuthorizationData, void* GetKeyFunciton, 
                                                       void* GetKeyArgument, size_t* CredentialHandle, 
                                                       LARGE_INTEGER* ExpirationTime);
alias SpFreeCredentialsHandleFn = NTSTATUS function(size_t CredentialHandle);
alias SpQueryCredentialsAttributesFn = NTSTATUS function(size_t CredentialHandle, uint CredentialAttribute, 
                                                         void* Buffer);
alias SpSetCredentialsAttributesFn = NTSTATUS function(size_t CredentialHandle, uint CredentialAttribute, 
                                                       char* Buffer, uint BufferSize);
alias SpAddCredentialsFn = NTSTATUS function(size_t CredentialHandle, UNICODE_STRING* PrincipalName, 
                                             UNICODE_STRING* Package, uint CredentialUseFlags, 
                                             void* AuthorizationData, void* GetKeyFunciton, void* GetKeyArgument, 
                                             LARGE_INTEGER* ExpirationTime);
alias SpSaveCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Credentials);
alias SpGetCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Credentials);
alias SpDeleteCredentialsFn = NTSTATUS function(size_t CredentialHandle, SecBuffer* Key);
alias SpInitLsaModeContextFn = NTSTATUS function(size_t CredentialHandle, size_t ContextHandle, 
                                                 UNICODE_STRING* TargetName, uint ContextRequirements, 
                                                 uint TargetDataRep, SecBufferDesc* InputBuffers, 
                                                 size_t* NewContextHandle, SecBufferDesc* OutputBuffers, 
                                                 uint* ContextAttributes, LARGE_INTEGER* ExpirationTime, 
                                                 ubyte* MappedContext, SecBuffer* ContextData);
alias SpDeleteContextFn = NTSTATUS function(size_t ContextHandle);
alias SpApplyControlTokenFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* ControlToken);
alias SpAcceptLsaModeContextFn = NTSTATUS function(size_t CredentialHandle, size_t ContextHandle, 
                                                   SecBufferDesc* InputBuffer, uint ContextRequirements, 
                                                   uint TargetDataRep, size_t* NewContextHandle, 
                                                   SecBufferDesc* OutputBuffer, uint* ContextAttributes, 
                                                   LARGE_INTEGER* ExpirationTime, ubyte* MappedContext, 
                                                   SecBuffer* ContextData);
alias SpGetUserInfoFn = NTSTATUS function(LUID* LogonId, uint Flags, SECURITY_USER_DATA** UserData);
alias SpQueryContextAttributesFn = NTSTATUS function(size_t ContextHandle, uint ContextAttribute, void* Buffer);
alias SpSetContextAttributesFn = NTSTATUS function(size_t ContextHandle, uint ContextAttribute, char* Buffer, 
                                                   uint BufferSize);
alias SpChangeAccountPasswordFn = NTSTATUS function(UNICODE_STRING* pDomainName, UNICODE_STRING* pAccountName, 
                                                    UNICODE_STRING* pOldPassword, UNICODE_STRING* pNewPassword, 
                                                    ubyte Impersonating, SecBufferDesc* pOutput);
alias SpQueryMetaDataFn = NTSTATUS function(size_t CredentialHandle, UNICODE_STRING* TargetName, 
                                            uint ContextRequirements, uint* MetaDataLength, ubyte** MetaData, 
                                            size_t* ContextHandle);
alias SpExchangeMetaDataFn = NTSTATUS function(size_t CredentialHandle, UNICODE_STRING* TargetName, 
                                               uint ContextRequirements, uint MetaDataLength, char* MetaData, 
                                               size_t* ContextHandle);
alias SpGetCredUIContextFn = NTSTATUS function(size_t ContextHandle, GUID* CredType, uint* FlatCredUIContextLength, 
                                               ubyte** FlatCredUIContext);
alias SpUpdateCredentialsFn = NTSTATUS function(size_t ContextHandle, GUID* CredType, uint FlatCredUIContextLength, 
                                                char* FlatCredUIContext);
alias SpValidateTargetInfoFn = NTSTATUS function(void** ClientRequest, char* ProtocolSubmitBuffer, 
                                                 void* ClientBufferBase, uint SubmitBufferLength, 
                                                 SECPKG_TARGETINFO* TargetInfo);
alias LSA_AP_POST_LOGON_USER = NTSTATUS function(SECPKG_POST_LOGON_USER_INFO* PostLogonUserInfo);
alias SpGetRemoteCredGuardLogonBufferFn = NTSTATUS function(size_t CredHandle, size_t ContextHandle, 
                                                            const(UNICODE_STRING)* TargetName, 
                                                            ptrdiff_t* RedirectedLogonHandle, 
                                                            PLSA_REDIRECTED_LOGON_CALLBACK* Callback, 
                                                            PLSA_REDIRECTED_LOGON_CLEANUP_CALLBACK* CleanupCallback, 
                                                            uint* LogonBufferSize, void** LogonBuffer);
alias SpGetRemoteCredGuardSupplementalCredsFn = NTSTATUS function(size_t CredHandle, 
                                                                  const(UNICODE_STRING)* TargetName, 
                                                                  ptrdiff_t* RedirectedLogonHandle, 
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
alias SpGetContextTokenFn = NTSTATUS function(size_t ContextHandle, ptrdiff_t* ImpersonationToken);
alias SpExportSecurityContextFn = NTSTATUS function(size_t phContext, uint fFlags, SecBuffer* pPackedContext, 
                                                    ptrdiff_t* pToken);
alias SpImportSecurityContextFn = NTSTATUS function(SecBuffer* pPackedContext, HANDLE Token, size_t* phContext);
alias SpCompleteAuthTokenFn = NTSTATUS function(size_t ContextHandle, SecBufferDesc* InputBuffer);
alias SpFormatCredentialsFn = NTSTATUS function(SecBuffer* Credentials, SecBuffer* FormattedCredentials);
alias SpMarshallSupplementalCredsFn = NTSTATUS function(uint CredentialSize, char* Credentials, 
                                                        uint* MarshalledCredSize, void** MarshalledCreds);
alias SpLsaModeInitializeFn = NTSTATUS function(uint LsaVersion, uint* PackageVersion, 
                                                SECPKG_FUNCTION_TABLE** ppTables, uint* pcTables);
alias SpUserModeInitializeFn = NTSTATUS function(uint LsaVersion, uint* PackageVersion, 
                                                 SECPKG_USER_FUNCTION_TABLE** ppTables, uint* pcTables);
alias KSEC_CREATE_CONTEXT_LIST = void* function(KSEC_CONTEXT_TYPE Type);
alias KSEC_INSERT_LIST_ENTRY = void function(void* List, KSEC_LIST_ENTRY* Entry);
alias KSEC_REFERENCE_LIST_ENTRY = NTSTATUS function(KSEC_LIST_ENTRY* Entry, uint Signature, ubyte RemoveNoRef);
alias KSEC_DEREFERENCE_LIST_ENTRY = void function(KSEC_LIST_ENTRY* Entry, ubyte* Delete);
alias KSEC_SERIALIZE_WINNT_AUTH_DATA = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias KSEC_SERIALIZE_SCHANNEL_AUTH_DATA = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias PKSEC_CREATE_CONTEXT_LIST = void* function();
alias PKSEC_INSERT_LIST_ENTRY = void function();
alias PKSEC_REFERENCE_LIST_ENTRY = NTSTATUS function();
alias PKSEC_DEREFERENCE_LIST_ENTRY = void function();
alias PKSEC_SERIALIZE_WINNT_AUTH_DATA = NTSTATUS function();
alias PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA = NTSTATUS function();
alias KSEC_LOCATE_PKG_BY_ID = void* function(uint PackageId);
alias PKSEC_LOCATE_PKG_BY_ID = void* function();
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
alias KspGetTokenFn = NTSTATUS function(size_t ContextId, ptrdiff_t* ImpersonationToken, void** RawToken);
alias KspQueryAttributesFn = NTSTATUS function(size_t ContextId, uint Attribute, void* Buffer);
alias KspCompleteTokenFn = NTSTATUS function(size_t ContextId, SecBufferDesc* Token);
alias KspMapHandleFn = NTSTATUS function(size_t ContextId, size_t* LsaContextId);
alias KspSetPagingModeFn = NTSTATUS function(ubyte PagingMode);
alias KspSerializeAuthDataFn = NTSTATUS function(void* pvAuthData, uint* Size, void** SerializedData);
alias SSL_EMPTY_CACHE_FN_A = BOOL function(const(char)* pszTargetName, uint dwFlags);
alias SSL_EMPTY_CACHE_FN_W = BOOL function(const(wchar)* pszTargetName, uint dwFlags);
alias SSL_CRACK_CERTIFICATE_FN = BOOL function(ubyte* pbCertificate, uint cbCertificate, BOOL VerifySignature, 
                                               X509Certificate** ppCertificate);
alias SSL_FREE_CERTIFICATE_FN = void function(X509Certificate* pCertificate);
alias SslGetServerIdentityFn = int function(char* ClientHello, uint ClientHelloSize, ubyte** ServerIdentity, 
                                            uint* ServerIdentitySize, uint Flags);
alias SslGetExtensionsFn = int function(char* clientHello, uint clientHelloByteSize, char* genericExtensions, 
                                        ubyte genericExtensionsCount, uint* bytesToRead, 
                                        SchGetExtensionsOptions flags);
alias PWLX_USE_CTRL_ALT_DEL = void function(HANDLE hWlx);
alias PWLX_SET_CONTEXT_POINTER = void function(HANDLE hWlx, void* pWlxContext);
alias PWLX_SAS_NOTIFY = void function(HANDLE hWlx, uint dwSasType);
alias PWLX_SET_TIMEOUT = BOOL function(HANDLE hWlx, uint Timeout);
alias PWLX_ASSIGN_SHELL_PROTECTION = int function(HANDLE hWlx, HANDLE hToken, HANDLE hProcess, HANDLE hThread);
alias PWLX_MESSAGE_BOX = int function(HANDLE hWlx, HWND hwndOwner, const(wchar)* lpszText, const(wchar)* lpszTitle, 
                                      uint fuStyle);
alias PWLX_DIALOG_BOX = int function(HANDLE hWlx, HANDLE hInst, const(wchar)* lpszTemplate, HWND hwndOwner, 
                                     DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_INDIRECT = int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, 
                                              HWND hwndOwner, DLGPROC dlgprc);
alias PWLX_DIALOG_BOX_PARAM = int function(HANDLE hWlx, HANDLE hInst, const(wchar)* lpszTemplate, HWND hwndOwner, 
                                           DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_DIALOG_BOX_INDIRECT_PARAM = int function(HANDLE hWlx, HANDLE hInst, DLGTEMPLATE* hDialogTemplate, 
                                                    HWND hwndOwner, DLGPROC dlgprc, LPARAM dwInitParam);
alias PWLX_SWITCH_DESKTOP_TO_USER = int function(HANDLE hWlx);
alias PWLX_SWITCH_DESKTOP_TO_WINLOGON = int function(HANDLE hWlx);
alias PWLX_CHANGE_PASSWORD_NOTIFY = int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo);
alias PWLX_GET_SOURCE_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP** ppDesktop);
alias PWLX_SET_RETURN_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop);
alias PWLX_CREATE_USER_DESKTOP = BOOL function(HANDLE hWlx, HANDLE hToken, uint Flags, 
                                               const(wchar)* pszDesktopName, WLX_DESKTOP** ppDesktop);
alias PWLX_CHANGE_PASSWORD_NOTIFY_EX = int function(HANDLE hWlx, WLX_MPR_NOTIFY_INFO* pMprInfo, uint dwChangeInfo, 
                                                    const(wchar)* ProviderName, void* Reserved);
alias PWLX_CLOSE_USER_DESKTOP = BOOL function(HANDLE hWlx, WLX_DESKTOP* pDesktop, HANDLE hToken);
alias PWLX_SET_OPTION = BOOL function(HANDLE hWlx, uint Option, size_t Value, size_t* OldValue);
alias PWLX_GET_OPTION = BOOL function(HANDLE hWlx, uint Option, size_t* Value);
alias PWLX_WIN31_MIGRATE = void function(HANDLE hWlx);
alias PWLX_QUERY_CLIENT_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_IC_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V1_0* pCred);
alias PWLX_QUERY_TS_LOGON_CREDENTIALS = BOOL function(WLX_CLIENT_CREDENTIALS_INFO_V2_0* pCred);
alias PWLX_DISCONNECT = BOOL function();
alias PWLX_QUERY_TERMINAL_SERVICES_DATA = uint function(HANDLE hWlx, WLX_TERMINAL_SERVICES_DATA* pTSData, 
                                                        ushort* UserName, ushort* Domain);
alias PWLX_QUERY_CONSOLESWITCH_CREDENTIALS = uint function(WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0* pCred);
alias PFNMSGECALLBACK = uint function(BOOL bVerbose, const(wchar)* lpMessage);
alias PF_NPAddConnection = uint function(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                                         const(wchar)* lpUserName);
alias PF_NPAddConnection3 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                                          const(wchar)* lpUserName, uint dwFlags);
alias PF_NPAddConnection4 = uint function(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* lpAuthBuffer, 
                                          uint cbAuthBuffer, uint dwFlags, char* lpUseOptions, uint cbUseOptions);
alias PF_NPCancelConnection = uint function(const(wchar)* lpName, BOOL fForce);
alias PF_NPGetConnection = uint function(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnBufferLen);
alias PF_NPGetConnection3 = uint function(const(wchar)* lpLocalName, uint dwLevel, char* lpBuffer, 
                                          uint* lpBufferSize);
alias PF_NPGetUniversalName = uint function(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, 
                                            uint* lpnBufferSize);
alias PF_NPGetConnectionPerformance = uint function(const(wchar)* lpRemoteName, 
                                                    NETCONNECTINFOSTRUCT* lpNetConnectInfo);
alias PF_NPOpenEnum = uint function(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, 
                                    ptrdiff_t* lphEnum);
alias PF_NPEnumResource = uint function(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);
alias PF_NPCloseEnum = uint function(HANDLE hEnum);
alias PF_NPGetCaps = uint function(uint ndex);
alias PF_NPGetUser = uint function(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnBufferLen);
alias PF_NPGetPersistentUseOptionsForConnection = uint function(const(wchar)* lpRemotePath, char* lpReadUseOptions, 
                                                                uint cbReadUseOptions, char* lpWriteUseOptions, 
                                                                uint* lpSizeWriteUseOptions);
alias PF_NPDeviceMode = uint function(HWND hParent);
alias PF_NPSearchDialog = uint function(HWND hwndParent, NETRESOURCEW* lpNetResource, char* lpBuffer, 
                                        uint cbBuffer, uint* lpnFlags);
alias PF_NPGetResourceParent = uint function(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize);
alias PF_NPGetResourceInformation = uint function(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize, 
                                                  ushort** lplpSystem);
alias PF_NPFormatNetworkName = uint function(const(wchar)* lpRemoteName, const(wchar)* lpFormattedName, 
                                             uint* lpnLength, uint dwFlags, uint dwAveCharPerLine);
alias PF_NPGetPropertyText = uint function(uint iButton, uint nPropSel, const(wchar)* lpName, 
                                           const(wchar)* lpButtonName, uint nButtonNameLen, uint nType);
alias PF_NPPropertyDialog = uint function(HWND hwndParent, uint iButtonDlg, uint nPropSel, 
                                          const(wchar)* lpFileName, uint nType);
alias PF_NPGetDirectoryType = uint function(const(wchar)* lpName, int* lpType, BOOL bFlushCache);
alias PF_NPDirectoryNotify = uint function(HWND hwnd, const(wchar)* lpDir, uint dwOper);
alias PF_NPLogonNotify = uint function(LUID* lpLogonId, const(wchar)* lpAuthentInfoType, void* lpAuthentInfo, 
                                       const(wchar)* lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                       const(wchar)* lpStationName, void* StationHandle, ushort** lpLogonScript);
alias PF_NPPasswordChangeNotify = uint function(const(wchar)* lpAuthentInfoType, void* lpAuthentInfo, 
                                                const(wchar)* lpPreviousAuthentInfoType, void* lpPreviousAuthentInfo, 
                                                const(wchar)* lpStationName, void* StationHandle, uint dwChangeInfo);
alias PF_AddConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYADD* lpAddInfo);
alias PF_CancelConnectNotify = uint function(NOTIFYINFO* lpNotifyInfo, NOTIFYCANCEL* lpCancelInfo);
alias PF_NPFMXGetPermCaps = uint function(const(wchar)* lpDriveName);
alias PF_NPFMXEditPerm = uint function(const(wchar)* lpDriveName, HWND hwndFMX, uint nDialogType);
alias PF_NPFMXGetPermHelp = uint function(const(wchar)* lpDriveName, uint nDialogType, BOOL fDirectory, 
                                          char* lpFileNameBuffer, uint* lpBufferSize, uint* lpnHelpContext);
alias PFN_AUTHZ_DYNAMIC_ACCESS_CHECK = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                                                     ACE_HEADER* pAce, void* pArgs, int* pbAceApplicable);
alias PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                                                       void* Args, SID_AND_ATTRIBUTES** pSidAttrArray, 
                                                       uint* pSidCount, SID_AND_ATTRIBUTES** pRestrictedSidAttrArray, 
                                                       uint* pRestrictedSidCount);
alias PFN_AUTHZ_FREE_DYNAMIC_GROUPS = void function(SID_AND_ATTRIBUTES* pSidAttrArray);
alias PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY = BOOL function(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                                                          void* capid, void* pArgs, 
                                                          int* pCentralAccessPolicyApplicable, 
                                                          void** ppCentralAccessPolicy);
alias PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY = void function(void* pCentralAccessPolicy);
alias FN_PROGRESS = void function(const(wchar)* pObjectName, uint Status, PROG_INVOKE_SETTING* pInvokeSetting, 
                                  void* Args, BOOL SecuritySet);
alias PFNREADOBJECTSECURITY = HRESULT function(const(wchar)* param0, uint param1, void** param2, LPARAM param3);
alias PFNWRITEOBJECTSECURITY = HRESULT function(const(wchar)* param0, uint param1, void* param2, LPARAM param3);
alias PFNDSCREATEISECINFO = HRESULT function(const(wchar)* param0, const(wchar)* param1, uint param2, 
                                             ISecurityInformation* param3, PFNREADOBJECTSECURITY param4, 
                                             PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSCREATEISECINFOEX = HRESULT function(const(wchar)* param0, const(wchar)* param1, const(wchar)* param2, 
                                               const(wchar)* param3, const(wchar)* param4, uint param5, 
                                               ISecurityInformation* param6, PFNREADOBJECTSECURITY param7, 
                                               PFNWRITEOBJECTSECURITY param8, LPARAM param9);
alias PFNDSCREATESECPAGE = HRESULT function(const(wchar)* param0, const(wchar)* param1, uint param2, 
                                            HPROPSHEETPAGE* param3, PFNREADOBJECTSECURITY param4, 
                                            PFNWRITEOBJECTSECURITY param5, LPARAM param6);
alias PFNDSEDITSECURITY = HRESULT function(HWND param0, const(wchar)* param1, const(wchar)* param2, uint param3, 
                                           const(wchar)* param4, PFNREADOBJECTSECURITY param5, 
                                           PFNWRITEOBJECTSECURITY param6, LPARAM param7);
alias FNCERTSRVISSERVERONLINEW = HRESULT function(const(wchar)* pwszServerName, int* pfServerOnline);
alias FNCERTSRVBACKUPGETDYNAMICFILELISTW = HRESULT function(void* hbc, ushort** ppwszzFileList, uint* pcbSize);
alias FNCERTSRVBACKUPPREPAREW = HRESULT function(const(wchar)* pwszServerName, uint grbitJet, uint dwBackupFlags, 
                                                 void** phbc);
alias FNCERTSRVBACKUPGETDATABASENAMESW = HRESULT function(void* hbc, ushort** ppwszzAttachmentInformation, 
                                                          uint* pcbSize);
alias FNCERTSRVBACKUPOPENFILEW = HRESULT function(void* hbc, const(wchar)* pwszAttachmentName, uint cbReadHintSize, 
                                                  LARGE_INTEGER* pliFileSize);
alias FNCERTSRVBACKUPREAD = HRESULT function(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);
alias FNCERTSRVBACKUPCLOSE = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPGETBACKUPLOGSW = HRESULT function(void* hbc, ushort** ppwszzBackupLogFiles, uint* pcbSize);
alias FNCERTSRVBACKUPTRUNCATELOGS = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPEND = HRESULT function(void* hbc);
alias FNCERTSRVBACKUPFREE = void function(void* pv);
alias FNCERTSRVRESTOREGETDATABASELOCATIONSW = HRESULT function(void* hbc, ushort** ppwszzDatabaseLocationList, 
                                                               uint* pcbSize);
alias FNCERTSRVRESTOREPREPAREW = HRESULT function(const(wchar)* pwszServerName, uint dwRestoreFlags, void** phbc);
alias FNCERTSRVRESTOREREGISTERW = HRESULT function(void* hbc, const(wchar)* pwszCheckPointFilePath, 
                                                   const(wchar)* pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, 
                                                   const(wchar)* pwszBackupLogPath, uint genLow, uint genHigh);
alias FNCERTSRVRESTOREREGISTERCOMPLETE = HRESULT function(void* hbc, HRESULT hrRestoreState);
alias FNCERTSRVRESTOREEND = HRESULT function(void* hbc);
alias FNCERTSRVSERVERCONTROLW = HRESULT function(const(wchar)* pwszServerName, uint dwControlFlags, uint* pcbOut, 
                                                 ubyte** ppbOut);
alias FNIMPORTPFXTOPROVIDER = HRESULT function(HWND hWndParent, char* pbPFX, uint cbPFX, 
                                               ImportPFXFlags ImportFlags, const(wchar)* pwszPassword, 
                                               const(wchar)* pwszProviderName, const(wchar)* pwszReaderName, 
                                               const(wchar)* pwszContainerNamePrefix, const(wchar)* pwszPin, 
                                               const(wchar)* pwszFriendlyName, uint* pcCertOut, 
                                               CERT_CONTEXT*** prgpCertOut);
alias FNIMPORTPFXTOPROVIDERFREEDATA = void function(uint cCert, char* rgpCert);
alias PFNCryptStreamOutputCallback = int function(void* pvCallbackCtxt, char* pbData, size_t cbData, BOOL fFinal);
alias PFNCryptStreamOutputCallbackEx = int function(void* pvCallbackCtxt, char* pbData, size_t cbData, 
                                                    NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, BOOL fFinal);
alias PFN_CRYPT_XML_WRITE_CALLBACK = HRESULT function(void* pvCallbackState, char* pbData, uint cbData);
alias PFN_CRYPT_XML_DATA_PROVIDER_READ = HRESULT function(void* pvCallbackState, char* pbData, uint cbData, 
                                                          uint* pcbRead);
alias PFN_CRYPT_XML_DATA_PROVIDER_CLOSE = HRESULT function(void* pvCallbackState);
alias PFN_CRYPT_XML_CREATE_TRANSFORM = HRESULT function(const(CRYPT_XML_ALGORITHM)* pTransform, 
                                                        CRYPT_XML_DATA_PROVIDER* pProviderIn, 
                                                        CRYPT_XML_DATA_PROVIDER* pProviderOut);
alias PFN_CRYPT_XML_ENUM_ALG_INFO = BOOL function(const(CRYPT_XML_ALGORITHM_INFO)* pInfo, void* pvArg);
alias CryptXmlDllGetInterface = HRESULT function(uint dwFlags, const(CRYPT_XML_ALGORITHM_INFO)* pMethod, 
                                                 CRYPT_XML_CRYPTOGRAPHIC_INTERFACE* pInterface);
alias CryptXmlDllEncodeAlgorithm = HRESULT function(const(CRYPT_XML_ALGORITHM_INFO)* pAlgInfo, 
                                                    CRYPT_XML_CHARSET dwCharset, void* pvCallbackState, 
                                                    PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);
alias CryptXmlDllCreateDigest = HRESULT function(const(CRYPT_XML_ALGORITHM)* pDigestMethod, uint* pcbSize, 
                                                 void** phDigest);
alias CryptXmlDllDigestData = HRESULT function(void* hDigest, char* pbData, uint cbData);
alias CryptXmlDllFinalizeDigest = HRESULT function(void* hDigest, char* pbDigest, uint cbDigest);
alias CryptXmlDllCloseDigest = HRESULT function(void* hDigest);
alias CryptXmlDllSignData = HRESULT function(const(CRYPT_XML_ALGORITHM)* pSignatureMethod, 
                                             size_t hCryptProvOrNCryptKey, uint dwKeySpec, char* pbInput, 
                                             uint cbInput, char* pbOutput, uint cbOutput, uint* pcbResult);
alias CryptXmlDllVerifySignature = HRESULT function(const(CRYPT_XML_ALGORITHM)* pSignatureMethod, void* hKey, 
                                                    char* pbInput, uint cbInput, char* pbSignature, uint cbSignature);
alias CryptXmlDllGetAlgorithmInfo = HRESULT function(const(CRYPT_XML_ALGORITHM)* pXmlAlgorithm, 
                                                     CRYPT_XML_ALGORITHM_INFO** ppAlgInfo);
alias CryptXmlDllEncodeKeyValue = HRESULT function(size_t hKey, CRYPT_XML_CHARSET dwCharset, void* pvCallbackState, 
                                                   PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);
alias CryptXmlDllCreateKey = HRESULT function(const(CRYPT_XML_BLOB)* pEncoded, void** phKey);
alias PFNCMFILTERPROC = BOOL function(CERT_CONTEXT* pCertContext, LPARAM param1, uint param2, uint param3);
alias PFNCMHOOKPROC = uint function(HWND hwndDialog, uint message, WPARAM wParam, LPARAM lParam);
alias PFNTRUSTHELPER = HRESULT function(CERT_CONTEXT* pCertContext, LPARAM lCustData, BOOL fLeafCertificate, 
                                        ubyte* pbTrustBlob);
alias PFN_CPD_MEM_ALLOC = void* function(uint cbSize);
alias PFN_CPD_MEM_FREE = void function(void* pvMem2Free);
alias PFN_CPD_ADD_STORE = BOOL function(CRYPT_PROVIDER_DATA* pProvData, void* hStore2Add);
alias PFN_CPD_ADD_SGNR = BOOL function(CRYPT_PROVIDER_DATA* pProvData, BOOL fCounterSigner, uint idxSigner, 
                                       CRYPT_PROVIDER_SGNR* pSgnr2Add);
alias PFN_CPD_ADD_CERT = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, BOOL fCounterSigner, 
                                       uint idxCounterSigner, CERT_CONTEXT* pCert2Add);
alias PFN_CPD_ADD_PRIVDATA = BOOL function(CRYPT_PROVIDER_DATA* pProvData, CRYPT_PROVIDER_PRIVDATA* pPrivData2Add);
alias PFN_PROVIDER_INIT_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_OBJTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_SIGTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTTRUST_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_FINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_TESTFINALPOLICY_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CLEANUP_CALL = HRESULT function(CRYPT_PROVIDER_DATA* pProvData);
alias PFN_PROVIDER_CERTCHKPOLICY_CALL = BOOL function(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                      BOOL fCounterSignerChain, uint idxCounterSigner);
alias PFN_PROVUI_CALL = BOOL function(HWND hWndSecurityDialog, CRYPT_PROVIDER_DATA* pProvData);
alias PFN_ALLOCANDFILLDEFUSAGE = BOOL function(const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFN_FREEDEFUSAGE = BOOL function(const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psDefUsage);
alias PFNCFILTERPROC = BOOL function(CERT_CONTEXT* pCertContext, int* pfInitialSelectedCert, void* pvCallbackData);
alias pCryptSIPGetSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pdwEncodingType, uint dwIndex, 
                                                uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPPutSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwEncodingType, uint* pdwIndex, 
                                                uint cbSignedDataMsg, ubyte* pbSignedDataMsg);
alias pCryptSIPCreateIndirectData = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, 
                                                  SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPVerifyIndirectData = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);
alias pCryptSIPRemoveSignedDataMsg = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);
alias pfnIsFileSupported = BOOL function(HANDLE hFile, GUID* pgSubject);
alias pfnIsFileSupportedName = BOOL function(ushort* pwszFileName, GUID* pgSubject);
alias pCryptSIPGetCaps = BOOL function(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);
alias pCryptSIPGetSealedDigest = BOOL function(SIP_SUBJECTINFO* pSubjectInfo, char* pSig, uint dwSig, 
                                               char* pbDigest, uint* pcbDigest);
alias PFN_CDF_PARSE_ERROR_CALLBACK = void function(uint dwErrorArea, uint dwLocalError, ushort* pwszLine);
alias PFSCE_QUERY_INFO = uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, 
                                       void** ppvInfo, uint* psceEnumHandle);
alias PFSCE_SET_INFO = uint function(void* sceHandle, SCESVC_INFO_TYPE sceType, byte* lpPrefix, BOOL bExact, 
                                     void* pvInfo);
alias PFSCE_FREE_INFO = uint function(void* pvServiceInfo);
alias PFSCE_LOG_INFO = uint function(int ErrLevel, uint Win32rc, byte* pErrFmt);
alias PF_ConfigAnalyzeService = uint function(SCESVC_CALLBACK_INFO* pSceCbInfo);
alias PF_UpdateService = uint function(SCESVC_CALLBACK_INFO* pSceCbInfo, SCESVC_CONFIGURATION_INFO* ServiceInfo);

// Structs


struct MSA_INFO_0
{
    MSA_INFO_STATE State;
}

alias HCERTCHAINENGINE = ptrdiff_t;

alias HCRYPTASYNC = ptrdiff_t;

alias LsaHandle = ptrdiff_t;

struct GENERIC_MAPPING
{
    uint GenericRead;
    uint GenericWrite;
    uint GenericExecute;
    uint GenericAll;
}

struct LUID_AND_ATTRIBUTES
{
    LUID Luid;
    uint Attributes;
}

struct SID_IDENTIFIER_AUTHORITY
{
    ubyte[6] Value;
}

struct SID
{
    ubyte   Revision;
    ubyte   SubAuthorityCount;
    SID_IDENTIFIER_AUTHORITY IdentifierAuthority;
    uint[1] SubAuthority;
}

struct SID_AND_ATTRIBUTES
{
    void* Sid;
    uint  Attributes;
}

struct SID_AND_ATTRIBUTES_HASH
{
    uint                SidCount;
    SID_AND_ATTRIBUTES* SidAttr;
    size_t[32]          Hash;
}

struct ACL
{
    ubyte  AclRevision;
    ubyte  Sbz1;
    ushort AclSize;
    ushort AceCount;
    ushort Sbz2;
}

struct ACE_HEADER
{
    ubyte  AceType;
    ubyte  AceFlags;
    ushort AceSize;
}

struct ACCESS_ALLOWED_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct ACCESS_DENIED_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_AUDIT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_ALARM_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_RESOURCE_ATTRIBUTE_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_SCOPED_POLICY_ID_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_MANDATORY_LABEL_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct ACCESS_ALLOWED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct ACCESS_DENIED_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct SYSTEM_AUDIT_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct SYSTEM_ALARM_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct ACCESS_ALLOWED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct ACCESS_DENIED_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_AUDIT_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct SYSTEM_ALARM_CALLBACK_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       SidStart;
}

struct ACCESS_ALLOWED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct ACCESS_DENIED_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct SYSTEM_AUDIT_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct SYSTEM_ALARM_CALLBACK_OBJECT_ACE
{
    ACE_HEADER Header;
    uint       Mask;
    uint       Flags;
    GUID       ObjectType;
    GUID       InheritedObjectType;
    uint       SidStart;
}

struct ACL_REVISION_INFORMATION
{
    uint AclRevision;
}

struct ACL_SIZE_INFORMATION
{
    uint AceCount;
    uint AclBytesInUse;
    uint AclBytesFree;
}

struct SECURITY_DESCRIPTOR
{
    ubyte  Revision;
    ubyte  Sbz1;
    ushort Control;
    void*  Owner;
    void*  Group;
    ACL*   Sacl;
    ACL*   Dacl;
}

struct OBJECT_TYPE_LIST
{
    ushort Level;
    ushort Sbz;
    GUID*  ObjectType;
}

struct PRIVILEGE_SET
{
    uint PrivilegeCount;
    uint Control;
    LUID_AND_ATTRIBUTES[1] Privilege;
}

struct TOKEN_USER
{
    SID_AND_ATTRIBUTES User;
}

struct TOKEN_GROUPS
{
    uint GroupCount;
    SID_AND_ATTRIBUTES[1] Groups;
}

struct TOKEN_PRIVILEGES
{
    uint PrivilegeCount;
    LUID_AND_ATTRIBUTES[1] Privileges;
}

struct TOKEN_OWNER
{
    void* Owner;
}

struct TOKEN_PRIMARY_GROUP
{
    void* PrimaryGroup;
}

struct TOKEN_DEFAULT_DACL
{
    ACL* DefaultDacl;
}

struct TOKEN_USER_CLAIMS
{
    void* UserClaims;
}

struct TOKEN_DEVICE_CLAIMS
{
    void* DeviceClaims;
}

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

struct TOKEN_LINKED_TOKEN
{
    HANDLE LinkedToken;
}

struct TOKEN_ELEVATION
{
    uint TokenIsElevated;
}

struct TOKEN_MANDATORY_LABEL
{
    SID_AND_ATTRIBUTES Label;
}

struct TOKEN_MANDATORY_POLICY
{
    uint Policy;
}

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
    void*             PackageSid;
    SID_AND_ATTRIBUTES_HASH* CapabilitiesHash;
    void*             TrustLevelSid;
    void*             SecurityAttributes;
}

struct TOKEN_AUDIT_POLICY
{
    ubyte[30] PerUserPolicy;
}

struct TOKEN_SOURCE
{
    byte[8] SourceName;
    LUID    SourceIdentifier;
}

struct TOKEN_STATISTICS
{
    LUID          TokenId;
    LUID          AuthenticationId;
    LARGE_INTEGER ExpirationTime;
    TOKEN_TYPE    TokenType;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    uint          DynamicCharged;
    uint          DynamicAvailable;
    uint          GroupCount;
    uint          PrivilegeCount;
    LUID          ModifiedId;
}

struct TOKEN_CONTROL
{
    LUID         TokenId;
    LUID         AuthenticationId;
    LUID         ModifiedId;
    TOKEN_SOURCE TokenSource;
}

struct TOKEN_ORIGIN
{
    LUID OriginatingLogonSession;
}

struct TOKEN_APPCONTAINER_INFORMATION
{
    void* TokenAppContainer;
}

struct CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong         Version;
    const(wchar)* Name;
}

struct CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint  ValueLength;
}

struct CLAIM_SECURITY_ATTRIBUTE_V1
{
    const(wchar)* Name;
    ushort        ValueType;
    ushort        Reserved;
    uint          Flags;
    uint          ValueCount;
    union Values
    {
        long*    pInt64;
        ulong*   pUint64;
        ushort** ppString;
        CLAIM_SECURITY_ATTRIBUTE_FQBN_VALUE* pFqbn;
        CLAIM_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* pOctetString;
    }
}

struct CLAIM_SECURITY_ATTRIBUTE_RELATIVE_V1
{
    uint   Name;
    ushort ValueType;
    ushort Reserved;
    uint   Flags;
    uint   ValueCount;
    union Values
    {
        uint[1] pInt64;
        uint[1] pUint64;
        uint[1] ppString;
        uint[1] pFqbn;
        uint[1] pOctetString;
    }
}

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

struct SECURITY_QUALITY_OF_SERVICE
{
    uint  Length;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    ubyte ContextTrackingMode;
    ubyte EffectiveOnly;
}

struct SECURITY_CAPABILITIES
{
    void*               AppContainerSid;
    SID_AND_ATTRIBUTES* Capabilities;
    uint                CapabilityCount;
    uint                Reserved;
}

struct QUOTA_LIMITS
{
    size_t        PagedPoolLimit;
    size_t        NonPagedPoolLimit;
    size_t        MinimumWorkingSetSize;
    size_t        MaximumWorkingSetSize;
    size_t        PagefileLimit;
    LARGE_INTEGER TimeLimit;
}

struct UNICODE_STRING
{
    ushort        Length;
    ushort        MaximumLength;
    const(wchar)* Buffer;
}

struct SEC_WINNT_AUTH_IDENTITY_W
{
    ushort* User;
    uint    UserLength;
    ushort* Domain;
    uint    DomainLength;
    ushort* Password;
    uint    PasswordLength;
    uint    Flags;
}

struct SEC_WINNT_AUTH_IDENTITY_A
{
    ubyte* User;
    uint   UserLength;
    ubyte* Domain;
    uint   DomainLength;
    ubyte* Password;
    uint   PasswordLength;
    uint   Flags;
}

struct CMS_KEY_INFO
{
    uint   dwVersion;
    uint   Algid;
    ubyte* pbOID;
    uint   cbOID;
}

struct HMAC_Info
{
    uint   HashAlgid;
    ubyte* pbInnerString;
    uint   cbInnerString;
    ubyte* pbOuterString;
    uint   cbOuterString;
}

struct SCHANNEL_ALG
{
    uint dwUse;
    uint Algid;
    uint cBits;
    uint dwFlags;
    uint dwReserved;
}

struct PROV_ENUMALGS
{
    uint     aiAlgid;
    uint     dwBitLen;
    uint     dwNameLen;
    byte[20] szName;
}

struct PROV_ENUMALGS_EX
{
    uint     aiAlgid;
    uint     dwDefaultLen;
    uint     dwMinLen;
    uint     dwMaxLen;
    uint     dwProtocols;
    uint     dwNameLen;
    byte[20] szName;
    uint     dwLongNameLen;
    byte[40] szLongName;
}

struct PUBLICKEYSTRUC
{
    ubyte  bType;
    ubyte  bVersion;
    ushort reserved;
    uint   aiKeyAlg;
}

struct RSAPUBKEY
{
    uint magic;
    uint bitlen;
    uint pubexp;
}

struct PUBKEY
{
    uint magic;
    uint bitlen;
}

struct DSSSEED
{
    uint      counter;
    ubyte[20] seed;
}

struct PUBKEYVER3
{
    uint    magic;
    uint    bitlenP;
    uint    bitlenQ;
    uint    bitlenJ;
    DSSSEED DSSSeed;
}

struct PRIVKEYVER3
{
    uint    magic;
    uint    bitlenP;
    uint    bitlenQ;
    uint    bitlenJ;
    uint    bitlenX;
    DSSSEED DSSSeed;
}

struct KEY_TYPE_SUBTYPE
{
    uint dwKeySpec;
    GUID Type;
    GUID Subtype;
}

struct CERT_FORTEZZA_DATA_PROP
{
    ubyte[8]  SerialNumber;
    int       CertIndex;
    ubyte[36] CertLabel;
}

struct CRYPT_RC4_KEY_STATE
{
    ubyte[16]  Key;
    ubyte[256] SBox;
    ubyte      i;
    ubyte      j;
}

struct CRYPT_DES_KEY_STATE
{
    ubyte[8] Key;
    ubyte[8] IV;
    ubyte[8] Feedback;
}

struct CRYPT_3DES_KEY_STATE
{
    ubyte[24] Key;
    ubyte[8]  IV;
    ubyte[8]  Feedback;
}

struct CRYPT_AES_128_KEY_STATE
{
    ubyte[16]  Key;
    ubyte[16]  IV;
    ubyte[176] EncryptionState;
    ubyte[176] DecryptionState;
    ubyte[16]  Feedback;
}

struct CRYPT_AES_256_KEY_STATE
{
    ubyte[32]  Key;
    ubyte[16]  IV;
    ubyte[240] EncryptionState;
    ubyte[240] DecryptionState;
    ubyte[16]  Feedback;
}

struct CRYPTOAPI_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct CMS_DH_KEY_INFO
{
    uint           dwVersion;
    uint           Algid;
    const(char)*   pszContentEncObjId;
    CRYPTOAPI_BLOB PubInfo;
    void*          pReserved;
}

struct BCRYPT_KEY_LENGTHS_STRUCT
{
    uint dwMinLength;
    uint dwMaxLength;
    uint dwIncrement;
}

struct BCRYPT_OID
{
    uint   cbOID;
    ubyte* pbOID;
}

struct BCRYPT_OID_LIST
{
    uint        dwOIDCount;
    BCRYPT_OID* pOIDs;
}

struct BCRYPT_PKCS1_PADDING_INFO
{
    const(wchar)* pszAlgId;
}

struct BCRYPT_PSS_PADDING_INFO
{
    const(wchar)* pszAlgId;
    uint          cbSalt;
}

struct BCRYPT_OAEP_PADDING_INFO
{
    const(wchar)* pszAlgId;
    ubyte*        pbLabel;
    uint          cbLabel;
}

struct BCRYPT_AUTHENTICATED_CIPHER_MODE_INFO
{
    uint   cbSize;
    uint   dwInfoVersion;
    ubyte* pbNonce;
    uint   cbNonce;
    ubyte* pbAuthData;
    uint   cbAuthData;
    ubyte* pbTag;
    uint   cbTag;
    ubyte* pbMacContext;
    uint   cbMacContext;
    uint   cbAAD;
    ulong  cbData;
    uint   dwFlags;
}

struct BCryptBuffer
{
    uint  cbBuffer;
    uint  BufferType;
    void* pvBuffer;
}

struct BCryptBufferDesc
{
    uint          ulVersion;
    uint          cBuffers;
    BCryptBuffer* pBuffers;
}

struct BCRYPT_KEY_BLOB
{
    uint Magic;
}

struct BCRYPT_RSAKEY_BLOB
{
    uint Magic;
    uint BitLength;
    uint cbPublicExp;
    uint cbModulus;
    uint cbPrime1;
    uint cbPrime2;
}

struct BCRYPT_ECCKEY_BLOB
{
    uint dwMagic;
    uint cbKey;
}

struct SSL_ECCKEY_BLOB
{
    uint dwCurveType;
    uint cbKey;
}

struct BCRYPT_ECCFULLKEY_BLOB
{
    uint                dwMagic;
    uint                dwVersion;
    ECC_CURVE_TYPE_ENUM dwCurveType;
    ECC_CURVE_ALG_ID_ENUM dwCurveGenerationAlgId;
    uint                cbFieldLength;
    uint                cbSubgroupOrder;
    uint                cbCofactor;
    uint                cbSeed;
}

struct BCRYPT_DH_KEY_BLOB
{
    uint dwMagic;
    uint cbKey;
}

struct BCRYPT_DH_PARAMETER_HEADER
{
    uint cbLength;
    uint dwMagic;
    uint cbKeyLength;
}

struct BCRYPT_DSA_KEY_BLOB
{
    uint      dwMagic;
    uint      cbKey;
    ubyte[4]  Count;
    ubyte[20] Seed;
    ubyte[20] q;
}

struct BCRYPT_DSA_KEY_BLOB_V2
{
    uint                dwMagic;
    uint                cbKey;
    HASHALGORITHM_ENUM  hashAlgorithm;
    DSAFIPSVERSION_ENUM standardVersion;
    uint                cbSeedLength;
    uint                cbGroupSize;
    ubyte[4]            Count;
}

struct BCRYPT_KEY_DATA_BLOB_HEADER
{
    uint dwMagic;
    uint dwVersion;
    uint cbKeyData;
}

struct BCRYPT_DSA_PARAMETER_HEADER
{
    uint      cbLength;
    uint      dwMagic;
    uint      cbKeyLength;
    ubyte[4]  Count;
    ubyte[20] Seed;
    ubyte[20] q;
}

struct BCRYPT_DSA_PARAMETER_HEADER_V2
{
    uint                cbLength;
    uint                dwMagic;
    uint                cbKeyLength;
    HASHALGORITHM_ENUM  hashAlgorithm;
    DSAFIPSVERSION_ENUM standardVersion;
    uint                cbSeedLength;
    uint                cbGroupSize;
    ubyte[4]            Count;
}

struct BCRYPT_ECC_CURVE_NAMES
{
    uint     dwEccCurveNames;
    ushort** pEccCurveNames;
}

struct BCRYPT_MULTI_HASH_OPERATION
{
    uint   iHash;
    BCRYPT_HASH_OPERATION_TYPE hashOperation;
    ubyte* pbBuffer;
    uint   cbBuffer;
}

struct BCRYPT_MULTI_OBJECT_LENGTH_STRUCT
{
    uint cbPerObject;
    uint cbPerElement;
}

struct BCRYPT_ALGORITHM_IDENTIFIER
{
    const(wchar)* pszName;
    uint          dwClass;
    uint          dwFlags;
}

struct BCRYPT_PROVIDER_NAME
{
    const(wchar)* pszProviderName;
}

struct BCRYPT_INTERFACE_VERSION
{
    ushort MajorVersion;
    ushort MinorVersion;
}

struct CRYPT_INTERFACE_REG
{
    uint     dwInterface;
    uint     dwFlags;
    uint     cFunctions;
    ushort** rgpszFunctions;
}

struct CRYPT_IMAGE_REG
{
    const(wchar)* pszImage;
    uint          cInterfaces;
    CRYPT_INTERFACE_REG** rgpInterfaces;
}

struct CRYPT_PROVIDER_REG
{
    uint             cAliases;
    ushort**         rgpszAliases;
    CRYPT_IMAGE_REG* pUM;
    CRYPT_IMAGE_REG* pKM;
}

struct CRYPT_PROVIDERS
{
    uint     cProviders;
    ushort** rgpszProviders;
}

struct CRYPT_CONTEXT_CONFIG
{
    uint dwFlags;
    uint dwReserved;
}

struct CRYPT_CONTEXT_FUNCTION_CONFIG
{
    uint dwFlags;
    uint dwReserved;
}

struct CRYPT_CONTEXTS
{
    uint     cContexts;
    ushort** rgpszContexts;
}

struct CRYPT_CONTEXT_FUNCTIONS
{
    uint     cFunctions;
    ushort** rgpszFunctions;
}

struct CRYPT_CONTEXT_FUNCTION_PROVIDERS
{
    uint     cProviders;
    ushort** rgpszProviders;
}

struct CRYPT_PROPERTY_REF
{
    const(wchar)* pszProperty;
    uint          cbValue;
    ubyte*        pbValue;
}

struct CRYPT_IMAGE_REF
{
    const(wchar)* pszImage;
    uint          dwFlags;
}

struct CRYPT_PROVIDER_REF
{
    uint                 dwInterface;
    const(wchar)*        pszFunction;
    const(wchar)*        pszProvider;
    uint                 cProperties;
    CRYPT_PROPERTY_REF** rgpProperties;
    CRYPT_IMAGE_REF*     pUM;
    CRYPT_IMAGE_REF*     pKM;
}

struct CRYPT_PROVIDER_REFS
{
    uint                 cProviders;
    CRYPT_PROVIDER_REF** rgpProviders;
}

struct NCRYPT_ALLOC_PARA
{
    uint             cbSize;
    PFN_NCRYPT_ALLOC pfnAlloc;
    PFN_NCRYPT_FREE  pfnFree;
}

struct NCRYPT_CIPHER_PADDING_INFO
{
    uint   cbSize;
    uint   dwFlags;
    ubyte* pbIV;
    uint   cbIV;
    ubyte* pbOtherInfo;
    uint   cbOtherInfo;
}

struct NCRYPT_PLATFORM_ATTEST_PADDING_INFO
{
    uint magic;
    uint pcrMask;
}

struct NCRYPT_KEY_ATTEST_PADDING_INFO
{
    uint   magic;
    ubyte* pbKeyBlob;
    uint   cbKeyBlob;
    ubyte* pbKeyAuth;
    uint   cbKeyAuth;
}

struct NCRYPT_ISOLATED_KEY_ATTESTED_ATTRIBUTES
{
    uint Version;
    uint Flags;
    uint cbPublicKeyBlob;
}

struct NCRYPT_VSM_KEY_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint cbSignature;
    uint cbReport;
    uint cbAttributes;
}

struct NCRYPT_VSM_KEY_ATTESTATION_CLAIM_RESTRICTIONS
{
    uint  Version;
    ulong TrustletId;
    uint  MinSvn;
    uint  FlagsMask;
    uint  FlagsExpected;
    uint  _bitfield99;
}

struct NCRYPT_EXPORTED_ISOLATED_KEY_HEADER
{
    uint Version;
    uint KeyUsage;
    uint _bitfield100;
    uint cbAlgName;
    uint cbNonce;
    uint cbAuthTag;
    uint cbWrappingKey;
    uint cbIsolatedKey;
}

struct NCRYPT_EXPORTED_ISOLATED_KEY_ENVELOPE
{
    NCRYPT_EXPORTED_ISOLATED_KEY_HEADER Header;
}

struct __NCRYPT_PCP_TPM_WEB_AUTHN_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint HeaderSize;
    uint cbCertifyInfo;
    uint cbSignature;
    uint cbTpmPublic;
}

struct NCRYPT_TPM_PLATFORM_ATTESTATION_STATEMENT
{
    uint Magic;
    uint Version;
    uint pcrAlg;
    uint cbSignature;
    uint cbQuote;
    uint cbPcrs;
}

struct NCryptAlgorithmName
{
    const(wchar)* pszName;
    uint          dwClass;
    uint          dwAlgOperations;
    uint          dwFlags;
}

struct NCryptKeyName
{
    const(wchar)* pszName;
    const(wchar)* pszAlgid;
    uint          dwLegacyKeySpec;
    uint          dwFlags;
}

struct NCryptProviderName
{
    const(wchar)* pszName;
    const(wchar)* pszComment;
}

struct NCRYPT_UI_POLICY
{
    uint          dwVersion;
    uint          dwFlags;
    const(wchar)* pszCreationTitle;
    const(wchar)* pszFriendlyName;
    const(wchar)* pszDescription;
}

struct __NCRYPT_KEY_ACCESS_POLICY_BLOB
{
    uint dwVersion;
    uint dwPolicyFlags;
    uint cbUserSid;
    uint cbApplicationSid;
}

struct NCRYPT_SUPPORTED_LENGTHS
{
    uint dwMinLength;
    uint dwMaxLength;
    uint dwIncrement;
    uint dwDefaultLength;
}

struct __NCRYPT_PCP_HMAC_AUTH_SIGNATURE_INFO
{
    uint      dwVersion;
    int       iExpiration;
    ubyte[32] pabNonce;
    ubyte[32] pabPolicyRef;
    ubyte[32] pabHMAC;
}

struct __NCRYPT_PCP_TPM_FW_VERSION_INFO
{
    ushort major1;
    ushort major2;
    ushort minor1;
    ushort minor2;
}

struct __NCRYPT_PCP_RAW_POLICYDIGEST
{
    uint dwVersion;
    uint cbDigest;
}

struct NCRYPT_KEY_BLOB_HEADER
{
    uint cbSize;
    uint dwMagic;
    uint cbAlgName;
    uint cbKeyData;
}

struct NCRYPT_TPM_LOADABLE_KEY_BLOB_HEADER
{
    uint magic;
    uint cbHeader;
    uint cbPublic;
    uint cbPrivate;
    uint cbName;
}

struct CRYPT_BIT_BLOB
{
    uint   cbData;
    ubyte* pbData;
    uint   cUnusedBits;
}

struct CRYPT_ALGORITHM_IDENTIFIER
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Parameters;
}

struct CRYPT_OBJID_TABLE
{
    uint         dwAlgId;
    const(char)* pszObjId;
}

struct CRYPT_HASH_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB Hash;
}

struct CERT_EXTENSION
{
    const(char)*   pszObjId;
    BOOL           fCritical;
    CRYPTOAPI_BLOB Value;
}

struct CRYPT_ATTRIBUTE_TYPE_VALUE
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CRYPT_ATTRIBUTE
{
    const(char)*    pszObjId;
    uint            cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CRYPT_ATTRIBUTES
{
    uint             cAttr;
    CRYPT_ATTRIBUTE* rgAttr;
}

struct CERT_RDN_ATTR
{
    const(char)*   pszObjId;
    uint           dwValueType;
    CRYPTOAPI_BLOB Value;
}

struct CERT_RDN
{
    uint           cRDNAttr;
    CERT_RDN_ATTR* rgRDNAttr;
}

struct CERT_NAME_INFO
{
    uint      cRDN;
    CERT_RDN* rgRDN;
}

struct CERT_NAME_VALUE
{
    uint           dwValueType;
    CRYPTOAPI_BLOB Value;
}

struct CERT_PUBLIC_KEY_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPT_BIT_BLOB PublicKey;
}

struct CRYPT_ECC_PRIVATE_KEY_INFO
{
    uint           dwVersion;
    CRYPTOAPI_BLOB PrivateKey;
    const(char)*   szCurveOid;
    CRYPT_BIT_BLOB PublicKey;
}

struct CRYPT_PRIVATE_KEY_INFO
{
    uint              Version;
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPTOAPI_BLOB    PrivateKey;
    CRYPT_ATTRIBUTES* pAttributes;
}

struct CRYPT_ENCRYPTED_PRIVATE_KEY_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER EncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedPrivateKey;
}

struct CRYPT_PKCS8_IMPORT_PARAMS
{
    CRYPTOAPI_BLOB PrivateKey;
    PCRYPT_RESOLVE_HCRYPTPROV_FUNC pResolvehCryptProvFunc;
    void*          pVoidResolveFunc;
    PCRYPT_DECRYPT_PRIVATE_KEY_FUNC pDecryptPrivateKeyFunc;
    void*          pVoidDecryptFunc;
}

struct CRYPT_PKCS8_EXPORT_PARAMS
{
    size_t       hCryptProv;
    uint         dwKeySpec;
    const(char)* pszPrivateKeyObjId;
    PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC pEncryptPrivateKeyFunc;
    void*        pVoidEncryptFunc;
}

struct CERT_INFO
{
    uint                 dwVersion;
    CRYPTOAPI_BLOB       SerialNumber;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPTOAPI_BLOB       Issuer;
    FILETIME             NotBefore;
    FILETIME             NotAfter;
    CRYPTOAPI_BLOB       Subject;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    CRYPT_BIT_BLOB       IssuerUniqueId;
    CRYPT_BIT_BLOB       SubjectUniqueId;
    uint                 cExtension;
    CERT_EXTENSION*      rgExtension;
}

struct CRL_ENTRY
{
    CRYPTOAPI_BLOB  SerialNumber;
    FILETIME        RevocationDate;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRL_INFO
{
    uint            dwVersion;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPTOAPI_BLOB  Issuer;
    FILETIME        ThisUpdate;
    FILETIME        NextUpdate;
    uint            cCRLEntry;
    CRL_ENTRY*      rgCRLEntry;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_OR_CRL_BLOB
{
    uint   dwChoice;
    uint   cbEncoded;
    ubyte* pbEncoded;
}

struct CERT_OR_CRL_BUNDLE
{
    uint              cItem;
    CERT_OR_CRL_BLOB* rgItem;
}

struct CERT_REQUEST_INFO
{
    uint                 dwVersion;
    CRYPTOAPI_BLOB       Subject;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    uint                 cAttribute;
    CRYPT_ATTRIBUTE*     rgAttribute;
}

struct CERT_KEYGEN_REQUEST_INFO
{
    uint                 dwVersion;
    CERT_PUBLIC_KEY_INFO SubjectPublicKeyInfo;
    const(wchar)*        pwszChallengeString;
}

struct CERT_SIGNED_CONTENT_INFO
{
    CRYPTOAPI_BLOB ToBeSigned;
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPT_BIT_BLOB Signature;
}

struct CTL_USAGE
{
    uint   cUsageIdentifier;
    byte** rgpszUsageIdentifier;
}

struct CTL_ENTRY
{
    CRYPTOAPI_BLOB   SubjectIdentifier;
    uint             cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CTL_INFO
{
    uint            dwVersion;
    CTL_USAGE       SubjectUsage;
    CRYPTOAPI_BLOB  ListIdentifier;
    CRYPTOAPI_BLOB  SequenceNumber;
    FILETIME        ThisUpdate;
    FILETIME        NextUpdate;
    CRYPT_ALGORITHM_IDENTIFIER SubjectAlgorithm;
    uint            cCTLEntry;
    CTL_ENTRY*      rgCTLEntry;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIME_STAMP_REQUEST_INFO
{
    const(char)*     pszTimeStampAlgorithm;
    const(char)*     pszContentType;
    CRYPTOAPI_BLOB   Content;
    uint             cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CRYPT_ENROLLMENT_NAME_VALUE_PAIR
{
    const(wchar)* pwszName;
    const(wchar)* pwszValue;
}

struct CRYPT_CSP_PROVIDER
{
    uint           dwKeySpec;
    const(wchar)*  pwszProviderName;
    CRYPT_BIT_BLOB Signature;
}

struct CRYPT_ENCODE_PARA
{
    uint            cbSize;
    PFN_CRYPT_ALLOC pfnAlloc;
    PFN_CRYPT_FREE  pfnFree;
}

struct CRYPT_DECODE_PARA
{
    uint            cbSize;
    PFN_CRYPT_ALLOC pfnAlloc;
    PFN_CRYPT_FREE  pfnFree;
}

struct CERT_EXTENSIONS
{
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_AUTHORITY_KEY_ID_INFO
{
    CRYPTOAPI_BLOB KeyId;
    CRYPTOAPI_BLOB CertIssuer;
    CRYPTOAPI_BLOB CertSerialNumber;
}

struct CERT_PRIVATE_KEY_VALIDITY
{
    FILETIME NotBefore;
    FILETIME NotAfter;
}

struct CERT_KEY_ATTRIBUTES_INFO
{
    CRYPTOAPI_BLOB KeyId;
    CRYPT_BIT_BLOB IntendedKeyUsage;
    CERT_PRIVATE_KEY_VALIDITY* pPrivateKeyUsagePeriod;
}

struct CERT_POLICY_ID
{
    uint   cCertPolicyElementId;
    byte** rgpszCertPolicyElementId;
}

struct CERT_KEY_USAGE_RESTRICTION_INFO
{
    uint            cCertPolicyId;
    CERT_POLICY_ID* rgCertPolicyId;
    CRYPT_BIT_BLOB  RestrictedKeyUsage;
}

struct CERT_OTHER_NAME
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CERT_ALT_NAME_ENTRY
{
    uint dwAltNameChoice;
    union
    {
        CERT_OTHER_NAME* pOtherName;
        const(wchar)*    pwszRfc822Name;
        const(wchar)*    pwszDNSName;
        CRYPTOAPI_BLOB   DirectoryName;
        const(wchar)*    pwszURL;
        CRYPTOAPI_BLOB   IPAddress;
        const(char)*     pszRegisteredID;
    }
}

struct CERT_ALT_NAME_INFO
{
    uint                 cAltEntry;
    CERT_ALT_NAME_ENTRY* rgAltEntry;
}

struct CERT_BASIC_CONSTRAINTS_INFO
{
    CRYPT_BIT_BLOB  SubjectType;
    BOOL            fPathLenConstraint;
    uint            dwPathLenConstraint;
    uint            cSubtreesConstraint;
    CRYPTOAPI_BLOB* rgSubtreesConstraint;
}

struct CERT_BASIC_CONSTRAINTS2_INFO
{
    BOOL fCA;
    BOOL fPathLenConstraint;
    uint dwPathLenConstraint;
}

struct CERT_POLICY_QUALIFIER_INFO
{
    const(char)*   pszPolicyQualifierId;
    CRYPTOAPI_BLOB Qualifier;
}

struct CERT_POLICY_INFO
{
    const(char)* pszPolicyIdentifier;
    uint         cPolicyQualifier;
    CERT_POLICY_QUALIFIER_INFO* rgPolicyQualifier;
}

struct CERT_POLICIES_INFO
{
    uint              cPolicyInfo;
    CERT_POLICY_INFO* rgPolicyInfo;
}

struct CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
{
    const(char)* pszOrganization;
    uint         cNoticeNumbers;
    int*         rgNoticeNumbers;
}

struct CERT_POLICY_QUALIFIER_USER_NOTICE
{
    CERT_POLICY_QUALIFIER_NOTICE_REFERENCE* pNoticeReference;
    const(wchar)* pszDisplayText;
}

struct CPS_URLS
{
    const(wchar)*   pszURL;
    CRYPT_ALGORITHM_IDENTIFIER* pAlgorithm;
    CRYPTOAPI_BLOB* pDigest;
}

struct CERT_POLICY95_QUALIFIER1
{
    const(wchar)* pszPracticesReference;
    const(char)*  pszNoticeIdentifier;
    const(char)*  pszNSINoticeIdentifier;
    uint          cCPSURLs;
    CPS_URLS*     rgCPSURLs;
}

struct CERT_POLICY_MAPPING
{
    const(char)* pszIssuerDomainPolicy;
    const(char)* pszSubjectDomainPolicy;
}

struct CERT_POLICY_MAPPINGS_INFO
{
    uint                 cPolicyMapping;
    CERT_POLICY_MAPPING* rgPolicyMapping;
}

struct CERT_POLICY_CONSTRAINTS_INFO
{
    BOOL fRequireExplicitPolicy;
    uint dwRequireExplicitPolicySkipCerts;
    BOOL fInhibitPolicyMapping;
    uint dwInhibitPolicyMappingSkipCerts;
}

struct CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY
{
    const(char)*    pszObjId;
    uint            cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CRYPT_CONTENT_INFO
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Content;
}

struct CRYPT_SEQUENCE_OF_ANY
{
    uint            cValue;
    CRYPTOAPI_BLOB* rgValue;
}

struct CERT_AUTHORITY_KEY_ID2_INFO
{
    CRYPTOAPI_BLOB     KeyId;
    CERT_ALT_NAME_INFO AuthorityCertIssuer;
    CRYPTOAPI_BLOB     AuthorityCertSerialNumber;
}

struct CERT_ACCESS_DESCRIPTION
{
    const(char)*        pszAccessMethod;
    CERT_ALT_NAME_ENTRY AccessLocation;
}

struct CERT_AUTHORITY_INFO_ACCESS
{
    uint cAccDescr;
    CERT_ACCESS_DESCRIPTION* rgAccDescr;
}

struct CRL_DIST_POINT_NAME
{
    uint dwDistPointNameChoice;
    union
    {
        CERT_ALT_NAME_INFO FullName;
    }
}

struct CRL_DIST_POINT
{
    CRL_DIST_POINT_NAME DistPointName;
    CRYPT_BIT_BLOB      ReasonFlags;
    CERT_ALT_NAME_INFO  CRLIssuer;
}

struct CRL_DIST_POINTS_INFO
{
    uint            cDistPoint;
    CRL_DIST_POINT* rgDistPoint;
}

struct CROSS_CERT_DIST_POINTS_INFO
{
    uint                dwSyncDeltaTime;
    uint                cDistPoint;
    CERT_ALT_NAME_INFO* rgDistPoint;
}

struct CERT_PAIR
{
    CRYPTOAPI_BLOB Forward;
    CRYPTOAPI_BLOB Reverse;
}

struct CRL_ISSUING_DIST_POINT
{
    CRL_DIST_POINT_NAME DistPointName;
    BOOL                fOnlyContainsUserCerts;
    BOOL                fOnlyContainsCACerts;
    CRYPT_BIT_BLOB      OnlySomeReasonFlags;
    BOOL                fIndirectCRL;
}

struct CERT_GENERAL_SUBTREE
{
    CERT_ALT_NAME_ENTRY Base;
    uint                dwMinimum;
    BOOL                fMaximum;
    uint                dwMaximum;
}

struct CERT_NAME_CONSTRAINTS_INFO
{
    uint cPermittedSubtree;
    CERT_GENERAL_SUBTREE* rgPermittedSubtree;
    uint cExcludedSubtree;
    CERT_GENERAL_SUBTREE* rgExcludedSubtree;
}

struct CERT_DSS_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB q;
    CRYPTOAPI_BLOB g;
}

struct CERT_DH_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB g;
}

struct CERT_ECC_SIGNATURE
{
    CRYPTOAPI_BLOB r;
    CRYPTOAPI_BLOB s;
}

struct CERT_X942_DH_VALIDATION_PARAMS
{
    CRYPT_BIT_BLOB seed;
    uint           pgenCounter;
}

struct CERT_X942_DH_PARAMETERS
{
    CRYPTOAPI_BLOB p;
    CRYPTOAPI_BLOB g;
    CRYPTOAPI_BLOB q;
    CRYPTOAPI_BLOB j;
    CERT_X942_DH_VALIDATION_PARAMS* pValidationParams;
}

struct CRYPT_X942_OTHER_INFO
{
    const(char)*   pszContentEncryptionObjId;
    ubyte[4]       rgbCounter;
    ubyte[4]       rgbKeyLength;
    CRYPTOAPI_BLOB PubInfo;
}

struct CRYPT_ECC_CMS_SHARED_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPTOAPI_BLOB EntityUInfo;
    ubyte[4]       rgbSuppPubInfo;
}

struct CRYPT_RC2_CBC_PARAMETERS
{
    uint     dwVersion;
    BOOL     fIV;
    ubyte[8] rgbIV;
}

struct CRYPT_SMIME_CAPABILITY
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Parameters;
}

struct CRYPT_SMIME_CAPABILITIES
{
    uint cCapability;
    CRYPT_SMIME_CAPABILITY* rgCapability;
}

struct CERT_QC_STATEMENT
{
    const(char)*   pszStatementId;
    CRYPTOAPI_BLOB StatementInfo;
}

struct CERT_QC_STATEMENTS_EXT_INFO
{
    uint               cStatement;
    CERT_QC_STATEMENT* rgStatement;
}

struct CRYPT_MASK_GEN_ALGORITHM
{
    const(char)* pszObjId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
}

struct CRYPT_RSA_SSA_PSS_PARAMETERS
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_MASK_GEN_ALGORITHM MaskGenAlgorithm;
    uint dwSaltLength;
    uint dwTrailerField;
}

struct CRYPT_PSOURCE_ALGORITHM
{
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB EncodingParameters;
}

struct CRYPT_RSAES_OAEP_PARAMETERS
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_MASK_GEN_ALGORITHM MaskGenAlgorithm;
    CRYPT_PSOURCE_ALGORITHM PSourceAlgorithm;
}

struct CMC_TAGGED_ATTRIBUTE
{
    uint            dwBodyPartID;
    CRYPT_ATTRIBUTE Attribute;
}

struct CMC_TAGGED_CERT_REQUEST
{
    uint           dwBodyPartID;
    CRYPTOAPI_BLOB SignedCertRequest;
}

struct CMC_TAGGED_REQUEST
{
    uint dwTaggedRequestChoice;
    union
    {
        CMC_TAGGED_CERT_REQUEST* pTaggedCertRequest;
    }
}

struct CMC_TAGGED_CONTENT_INFO
{
    uint           dwBodyPartID;
    CRYPTOAPI_BLOB EncodedContentInfo;
}

struct CMC_TAGGED_OTHER_MSG
{
    uint           dwBodyPartID;
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct CMC_DATA_INFO
{
    uint                cTaggedAttribute;
    CMC_TAGGED_ATTRIBUTE* rgTaggedAttribute;
    uint                cTaggedRequest;
    CMC_TAGGED_REQUEST* rgTaggedRequest;
    uint                cTaggedContentInfo;
    CMC_TAGGED_CONTENT_INFO* rgTaggedContentInfo;
    uint                cTaggedOtherMsg;
    CMC_TAGGED_OTHER_MSG* rgTaggedOtherMsg;
}

struct CMC_RESPONSE_INFO
{
    uint cTaggedAttribute;
    CMC_TAGGED_ATTRIBUTE* rgTaggedAttribute;
    uint cTaggedContentInfo;
    CMC_TAGGED_CONTENT_INFO* rgTaggedContentInfo;
    uint cTaggedOtherMsg;
    CMC_TAGGED_OTHER_MSG* rgTaggedOtherMsg;
}

struct CMC_PEND_INFO
{
    CRYPTOAPI_BLOB PendToken;
    FILETIME       PendTime;
}

struct CMC_STATUS_INFO
{
    uint          dwStatus;
    uint          cBodyList;
    uint*         rgdwBodyList;
    const(wchar)* pwszStatusString;
    uint          dwOtherInfoChoice;
    union
    {
        uint           dwFailInfo;
        CMC_PEND_INFO* pPendInfo;
    }
}

struct CMC_ADD_EXTENSIONS_INFO
{
    uint            dwCmcDataReference;
    uint            cCertReference;
    uint*           rgdwCertReference;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CMC_ADD_ATTRIBUTES_INFO
{
    uint             dwCmcDataReference;
    uint             cCertReference;
    uint*            rgdwCertReference;
    uint             cAttribute;
    CRYPT_ATTRIBUTE* rgAttribute;
}

struct CERT_TEMPLATE_EXT
{
    const(char)* pszObjId;
    uint         dwMajorVersion;
    BOOL         fMinorVersion;
    uint         dwMinorVersion;
}

struct CERT_HASHED_URL
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB Hash;
    const(wchar)*  pwszUrl;
}

struct CERT_LOGOTYPE_DETAILS
{
    const(wchar)*    pwszMimeType;
    uint             cHashedUrl;
    CERT_HASHED_URL* rgHashedUrl;
}

struct CERT_LOGOTYPE_REFERENCE
{
    uint             cHashedUrl;
    CERT_HASHED_URL* rgHashedUrl;
}

struct CERT_LOGOTYPE_IMAGE_INFO
{
    uint          dwLogotypeImageInfoChoice;
    uint          dwFileSize;
    uint          dwXSize;
    uint          dwYSize;
    uint          dwLogotypeImageResolutionChoice;
    union
    {
        uint dwNumBits;
        uint dwTableSize;
    }
    const(wchar)* pwszLanguage;
}

struct CERT_LOGOTYPE_IMAGE
{
    CERT_LOGOTYPE_DETAILS LogotypeDetails;
    CERT_LOGOTYPE_IMAGE_INFO* pLogotypeImageInfo;
}

struct CERT_LOGOTYPE_AUDIO_INFO
{
    uint          dwFileSize;
    uint          dwPlayTime;
    uint          dwChannels;
    uint          dwSampleRate;
    const(wchar)* pwszLanguage;
}

struct CERT_LOGOTYPE_AUDIO
{
    CERT_LOGOTYPE_DETAILS LogotypeDetails;
    CERT_LOGOTYPE_AUDIO_INFO* pLogotypeAudioInfo;
}

struct CERT_LOGOTYPE_DATA
{
    uint                 cLogotypeImage;
    CERT_LOGOTYPE_IMAGE* rgLogotypeImage;
    uint                 cLogotypeAudio;
    CERT_LOGOTYPE_AUDIO* rgLogotypeAudio;
}

struct CERT_LOGOTYPE_INFO
{
    uint dwLogotypeInfoChoice;
    union
    {
        CERT_LOGOTYPE_DATA* pLogotypeDirectInfo;
        CERT_LOGOTYPE_REFERENCE* pLogotypeIndirectInfo;
    }
}

struct CERT_OTHER_LOGOTYPE_INFO
{
    const(char)*       pszObjId;
    CERT_LOGOTYPE_INFO LogotypeInfo;
}

struct CERT_LOGOTYPE_EXT_INFO
{
    uint                cCommunityLogo;
    CERT_LOGOTYPE_INFO* rgCommunityLogo;
    CERT_LOGOTYPE_INFO* pIssuerLogo;
    CERT_LOGOTYPE_INFO* pSubjectLogo;
    uint                cOtherLogo;
    CERT_OTHER_LOGOTYPE_INFO* rgOtherLogo;
}

struct CERT_BIOMETRIC_DATA
{
    uint            dwTypeOfBiometricDataChoice;
    union
    {
        uint         dwPredefined;
        const(char)* pszObjId;
    }
    CERT_HASHED_URL HashedUrl;
}

struct CERT_BIOMETRIC_EXT_INFO
{
    uint                 cBiometricData;
    CERT_BIOMETRIC_DATA* rgBiometricData;
}

struct OCSP_SIGNATURE_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER SignatureAlgorithm;
    CRYPT_BIT_BLOB  Signature;
    uint            cCertEncoded;
    CRYPTOAPI_BLOB* rgCertEncoded;
}

struct OCSP_SIGNED_REQUEST_INFO
{
    CRYPTOAPI_BLOB       ToBeSigned;
    OCSP_SIGNATURE_INFO* pOptionalSignatureInfo;
}

struct OCSP_CERT_ID
{
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB IssuerNameHash;
    CRYPTOAPI_BLOB IssuerKeyHash;
    CRYPTOAPI_BLOB SerialNumber;
}

struct OCSP_REQUEST_ENTRY
{
    OCSP_CERT_ID    CertId;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct OCSP_REQUEST_INFO
{
    uint                 dwVersion;
    CERT_ALT_NAME_ENTRY* pRequestorName;
    uint                 cRequestEntry;
    OCSP_REQUEST_ENTRY*  rgRequestEntry;
    uint                 cExtension;
    CERT_EXTENSION*      rgExtension;
}

struct OCSP_RESPONSE_INFO
{
    uint           dwStatus;
    const(char)*   pszObjId;
    CRYPTOAPI_BLOB Value;
}

struct OCSP_BASIC_SIGNED_RESPONSE_INFO
{
    CRYPTOAPI_BLOB      ToBeSigned;
    OCSP_SIGNATURE_INFO SignatureInfo;
}

struct OCSP_BASIC_REVOKED_INFO
{
    FILETIME RevocationDate;
    uint     dwCrlReasonCode;
}

struct OCSP_BASIC_RESPONSE_ENTRY
{
    OCSP_CERT_ID    CertId;
    uint            dwCertStatus;
    union
    {
        OCSP_BASIC_REVOKED_INFO* pRevokedInfo;
    }
    FILETIME        ThisUpdate;
    FILETIME        NextUpdate;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct OCSP_BASIC_RESPONSE_INFO
{
    uint            dwVersion;
    uint            dwResponderIdChoice;
    union
    {
        CRYPTOAPI_BLOB ByNameResponderId;
        CRYPTOAPI_BLOB ByKeyResponderId;
    }
    FILETIME        ProducedAt;
    uint            cResponseEntry;
    OCSP_BASIC_RESPONSE_ENTRY* rgResponseEntry;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CERT_SUPPORTED_ALGORITHM_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER Algorithm;
    CRYPT_BIT_BLOB     IntendedKeyUsage;
    CERT_POLICIES_INFO IntendedCertPolicies;
}

struct CERT_TPM_SPECIFICATION_INFO
{
    const(wchar)* pwszFamily;
    uint          dwLevel;
    uint          dwRevision;
}

struct CRYPT_OID_FUNC_ENTRY
{
    const(char)* pszOID;
    void*        pvFuncAddr;
}

struct CRYPT_OID_INFO
{
    uint           cbSize;
    const(char)*   pszOID;
    const(wchar)*  pwszName;
    uint           dwGroupId;
    union
    {
        uint dwValue;
        uint Algid;
        uint dwLength;
    }
    CRYPTOAPI_BLOB ExtraInfo;
}

struct CERT_STRONG_SIGN_SERIALIZED_INFO
{
    uint          dwFlags;
    const(wchar)* pwszCNGSignHashAlgids;
    const(wchar)* pwszCNGPubKeyMinBitLengths;
}

struct CERT_STRONG_SIGN_PARA
{
    uint cbSize;
    uint dwInfoChoice;
    union
    {
        void*        pvInfo;
        CERT_STRONG_SIGN_SERIALIZED_INFO* pSerializedInfo;
        const(char)* pszOID;
    }
}

struct CERT_ISSUER_SERIAL_NUMBER
{
    CRYPTOAPI_BLOB Issuer;
    CRYPTOAPI_BLOB SerialNumber;
}

struct CERT_ID
{
    uint dwIdChoice;
    union
    {
        CERT_ISSUER_SERIAL_NUMBER IssuerSerialNumber;
        CRYPTOAPI_BLOB KeyId;
        CRYPTOAPI_BLOB HashId;
    }
}

struct CMSG_SIGNER_ENCODE_INFO
{
    uint             cbSize;
    CERT_INFO*       pCertInfo;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint             dwKeySpec;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void*            pvHashAuxInfo;
    uint             cAuthAttr;
    CRYPT_ATTRIBUTE* rgAuthAttr;
    uint             cUnauthAttr;
    CRYPT_ATTRIBUTE* rgUnauthAttr;
}

struct CMSG_SIGNED_ENCODE_INFO
{
    uint            cbSize;
    uint            cSigners;
    CMSG_SIGNER_ENCODE_INFO* rgSigners;
    uint            cCertEncoded;
    CRYPTOAPI_BLOB* rgCertEncoded;
    uint            cCrlEncoded;
    CRYPTOAPI_BLOB* rgCrlEncoded;
}

struct CMSG_ENVELOPED_ENCODE_INFO
{
    uint        cbSize;
    size_t      hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void*       pvEncryptionAuxInfo;
    uint        cRecipients;
    CERT_INFO** rgpRecipients;
}

struct CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
{
    uint           cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void*          pvKeyEncryptionAuxInfo;
    size_t         hCryptProv;
    CRYPT_BIT_BLOB RecipientPublicKey;
    CERT_ID        RecipientId;
}

struct CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
{
    uint           cbSize;
    CRYPT_BIT_BLOB RecipientPublicKey;
    CERT_ID        RecipientId;
    FILETIME       Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
{
    uint           cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void*          pvKeyEncryptionAuxInfo;
    CRYPT_ALGORITHM_IDENTIFIER KeyWrapAlgorithm;
    void*          pvKeyWrapAuxInfo;
    size_t         hCryptProv;
    uint           dwKeySpec;
    uint           dwKeyChoice;
    union
    {
        CRYPT_ALGORITHM_IDENTIFIER* pEphemeralAlgorithm;
        CERT_ID* pSenderId;
    }
    CRYPTOAPI_BLOB UserKeyingMaterial;
    uint           cRecipientEncryptedKeys;
    CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO** rgpRecipientEncryptedKeys;
}

struct CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
{
    uint           cbSize;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    void*          pvKeyEncryptionAuxInfo;
    size_t         hCryptProv;
    uint           dwKeyChoice;
    union
    {
        size_t hKeyEncryptionKey;
        void*  pvKeyEncryptionKey;
    }
    CRYPTOAPI_BLOB KeyId;
    FILETIME       Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_RECIPIENT_ENCODE_INFO
{
    uint dwRecipientChoice;
    union
    {
        CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO* pKeyTrans;
        CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO* pKeyAgree;
        CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO* pMailList;
    }
}

struct CMSG_RC2_AUX_INFO
{
    uint cbSize;
    uint dwBitLen;
}

struct CMSG_SP3_COMPATIBLE_AUX_INFO
{
    uint cbSize;
    uint dwFlags;
}

struct CMSG_RC4_AUX_INFO
{
    uint cbSize;
    uint dwBitLen;
}

struct CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO
{
    uint cbSize;
    CMSG_SIGNED_ENCODE_INFO SignedInfo;
    CMSG_ENVELOPED_ENCODE_INFO EnvelopedInfo;
}

struct CMSG_HASHED_ENCODE_INFO
{
    uint   cbSize;
    size_t hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void*  pvHashAuxInfo;
}

struct CMSG_ENCRYPTED_ENCODE_INFO
{
    uint  cbSize;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void* pvEncryptionAuxInfo;
}

struct CMSG_STREAM_INFO
{
    uint  cbContent;
    PFN_CMSG_STREAM_OUTPUT pfnStreamOutput;
    void* pvArg;
}

struct CMSG_SIGNER_INFO
{
    uint             dwVersion;
    CRYPTOAPI_BLOB   Issuer;
    CRYPTOAPI_BLOB   SerialNumber;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_ALGORITHM_IDENTIFIER HashEncryptionAlgorithm;
    CRYPTOAPI_BLOB   EncryptedHash;
    CRYPT_ATTRIBUTES AuthAttrs;
    CRYPT_ATTRIBUTES UnauthAttrs;
}

struct CMSG_CMS_SIGNER_INFO
{
    uint             dwVersion;
    CERT_ID          SignerId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPT_ALGORITHM_IDENTIFIER HashEncryptionAlgorithm;
    CRYPTOAPI_BLOB   EncryptedHash;
    CRYPT_ATTRIBUTES AuthAttrs;
    CRYPT_ATTRIBUTES UnauthAttrs;
}

struct CMSG_KEY_TRANS_RECIPIENT_INFO
{
    uint           dwVersion;
    CERT_ID        RecipientId;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
}

struct CMSG_RECIPIENT_ENCRYPTED_KEY_INFO
{
    CERT_ID        RecipientId;
    CRYPTOAPI_BLOB EncryptedKey;
    FILETIME       Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_KEY_AGREE_RECIPIENT_INFO
{
    uint           dwVersion;
    uint           dwOriginatorChoice;
    union
    {
        CERT_ID              OriginatorCertId;
        CERT_PUBLIC_KEY_INFO OriginatorPublicKeyInfo;
    }
    CRYPTOAPI_BLOB UserKeyingMaterial;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    uint           cRecipientEncryptedKeys;
    CMSG_RECIPIENT_ENCRYPTED_KEY_INFO** rgpRecipientEncryptedKeys;
}

struct CMSG_MAIL_LIST_RECIPIENT_INFO
{
    uint           dwVersion;
    CRYPTOAPI_BLOB KeyId;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    FILETIME       Date;
    CRYPT_ATTRIBUTE_TYPE_VALUE* pOtherAttr;
}

struct CMSG_CMS_RECIPIENT_INFO
{
    uint dwRecipientChoice;
    union
    {
        CMSG_KEY_TRANS_RECIPIENT_INFO* pKeyTrans;
        CMSG_KEY_AGREE_RECIPIENT_INFO* pKeyAgree;
        CMSG_MAIL_LIST_RECIPIENT_INFO* pMailList;
    }
}

struct CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA
{
    uint   cbSize;
    size_t hCryptProv;
    uint   dwSignerIndex;
    uint   dwSignerType;
    void*  pvSigner;
}

struct CMSG_CTRL_DECRYPT_PARA
{
    uint cbSize;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint dwKeySpec;
    uint dwRecipientIndex;
}

struct CMSG_CTRL_KEY_TRANS_DECRYPT_PARA
{
    uint cbSize;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint dwKeySpec;
    CMSG_KEY_TRANS_RECIPIENT_INFO* pKeyTrans;
    uint dwRecipientIndex;
}

struct CMSG_CTRL_KEY_AGREE_DECRYPT_PARA
{
    uint           cbSize;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint           dwKeySpec;
    CMSG_KEY_AGREE_RECIPIENT_INFO* pKeyAgree;
    uint           dwRecipientIndex;
    uint           dwRecipientEncryptedKeyIndex;
    CRYPT_BIT_BLOB OriginatorPublicKey;
}

struct CMSG_CTRL_MAIL_LIST_DECRYPT_PARA
{
    uint   cbSize;
    size_t hCryptProv;
    CMSG_MAIL_LIST_RECIPIENT_INFO* pMailList;
    uint   dwRecipientIndex;
    uint   dwKeyChoice;
    union
    {
        size_t hKeyEncryptionKey;
        void*  pvKeyEncryptionKey;
    }
}

struct CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA
{
    uint           cbSize;
    uint           dwSignerIndex;
    CRYPTOAPI_BLOB blob;
}

struct CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA
{
    uint cbSize;
    uint dwSignerIndex;
    uint dwUnauthAttrIndex;
}

struct CMSG_CONTENT_ENCRYPT_INFO
{
    uint           cbSize;
    size_t         hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void*          pvEncryptionAuxInfo;
    uint           cRecipients;
    CMSG_RECIPIENT_ENCODE_INFO* rgCmsRecipients;
    PFN_CMSG_ALLOC pfnAlloc;
    PFN_CMSG_FREE  pfnFree;
    uint           dwEncryptFlags;
    union
    {
        size_t hContentEncryptKey;
        void*  hCNGContentEncryptKey;
    }
    uint           dwFlags;
    BOOL           fCNG;
    ubyte*         pbCNGContentEncryptKeyObject;
    ubyte*         pbContentEncryptKey;
    uint           cbContentEncryptKey;
}

struct CMSG_KEY_TRANS_ENCRYPT_INFO
{
    uint           cbSize;
    uint           dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    uint           dwFlags;
}

struct CMSG_KEY_AGREE_KEY_ENCRYPT_INFO
{
    uint           cbSize;
    CRYPTOAPI_BLOB EncryptedKey;
}

struct CMSG_KEY_AGREE_ENCRYPT_INFO
{
    uint           cbSize;
    uint           dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB UserKeyingMaterial;
    uint           dwOriginatorChoice;
    union
    {
        CERT_ID              OriginatorCertId;
        CERT_PUBLIC_KEY_INFO OriginatorPublicKeyInfo;
    }
    uint           cKeyAgreeKeyEncryptInfo;
    CMSG_KEY_AGREE_KEY_ENCRYPT_INFO** rgpKeyAgreeKeyEncryptInfo;
    uint           dwFlags;
}

struct CMSG_MAIL_LIST_ENCRYPT_INFO
{
    uint           cbSize;
    uint           dwRecipientIndex;
    CRYPT_ALGORITHM_IDENTIFIER KeyEncryptionAlgorithm;
    CRYPTOAPI_BLOB EncryptedKey;
    uint           dwFlags;
}

struct CMSG_CNG_CONTENT_DECRYPT_INFO
{
    uint           cbSize;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    PFN_CMSG_ALLOC pfnAlloc;
    PFN_CMSG_FREE  pfnFree;
    size_t         hNCryptKey;
    ubyte*         pbContentEncryptKey;
    uint           cbContentEncryptKey;
    void*          hCNGContentEncryptKey;
    ubyte*         pbCNGContentEncryptKeyObject;
}

struct CERT_CONTEXT
{
    uint       dwCertEncodingType;
    ubyte*     pbCertEncoded;
    uint       cbCertEncoded;
    CERT_INFO* pCertInfo;
    void*      hCertStore;
}

struct CRL_CONTEXT
{
    uint      dwCertEncodingType;
    ubyte*    pbCrlEncoded;
    uint      cbCrlEncoded;
    CRL_INFO* pCrlInfo;
    void*     hCertStore;
}

struct CTL_CONTEXT
{
    uint      dwMsgAndCertEncodingType;
    ubyte*    pbCtlEncoded;
    uint      cbCtlEncoded;
    CTL_INFO* pCtlInfo;
    void*     hCertStore;
    void*     hCryptMsg;
    ubyte*    pbCtlContent;
    uint      cbCtlContent;
}

struct CRYPT_KEY_PROV_PARAM
{
    uint   dwParam;
    ubyte* pbData;
    uint   cbData;
    uint   dwFlags;
}

struct CRYPT_KEY_PROV_INFO
{
    const(wchar)* pwszContainerName;
    const(wchar)* pwszProvName;
    uint          dwProvType;
    uint          dwFlags;
    uint          cProvParam;
    CRYPT_KEY_PROV_PARAM* rgProvParam;
    uint          dwKeySpec;
}

struct CERT_KEY_CONTEXT
{
    uint cbSize;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint dwKeySpec;
}

struct ROOT_INFO_LUID
{
    uint LowPart;
    int  HighPart;
}

struct CRYPT_SMART_CARD_ROOT_INFO
{
    ubyte[16]      rgbCardID;
    ROOT_INFO_LUID luid;
}

struct CERT_SYSTEM_STORE_RELOCATE_PARA
{
    union
    {
        HKEY  hKeyBase;
        void* pvBase;
    }
    union
    {
        void*         pvSystemStore;
        const(char)*  pszSystemStore;
        const(wchar)* pwszSystemStore;
    }
}

struct CERT_REGISTRY_STORE_CLIENT_GPT_PARA
{
    HKEY          hKeyBase;
    const(wchar)* pwszRegPath;
}

struct CERT_REGISTRY_STORE_ROAMING_PARA
{
    HKEY          hKey;
    const(wchar)* pwszStoreDirectory;
}

struct CERT_LDAP_STORE_OPENED_PARA
{
    void*         pvLdapSessionHandle;
    const(wchar)* pwszLdapUrl;
}

struct CERT_STORE_PROV_INFO
{
    uint   cbSize;
    uint   cStoreProvFunc;
    void** rgpvStoreProvFunc;
    void*  hStoreProv;
    uint   dwStoreProvFlags;
    void*  hStoreProvFuncAddr2;
}

struct CERT_STORE_PROV_FIND_INFO
{
    uint         cbSize;
    uint         dwMsgAndCertEncodingType;
    uint         dwFindFlags;
    uint         dwFindType;
    const(void)* pvFindPara;
}

struct CRL_FIND_ISSUED_FOR_PARA
{
    CERT_CONTEXT* pSubjectCert;
    CERT_CONTEXT* pIssuerCert;
}

struct CTL_ANY_SUBJECT_INFO
{
    CRYPT_ALGORITHM_IDENTIFIER SubjectAlgorithm;
    CRYPTOAPI_BLOB SubjectIdentifier;
}

struct CTL_FIND_USAGE_PARA
{
    uint           cbSize;
    CTL_USAGE      SubjectUsage;
    CRYPTOAPI_BLOB ListIdentifier;
    CERT_INFO*     pSigner;
}

struct CTL_FIND_SUBJECT_PARA
{
    uint                 cbSize;
    CTL_FIND_USAGE_PARA* pUsagePara;
    uint                 dwSubjectType;
    void*                pvSubject;
}

struct CERT_CREATE_CONTEXT_PARA
{
    uint           cbSize;
    PFN_CRYPT_FREE pfnFree;
    void*          pvFree;
    PFN_CERT_CREATE_CONTEXT_SORT_FUNC pfnSort;
    void*          pvSort;
}

struct CERT_SYSTEM_STORE_INFO
{
    uint cbSize;
}

struct CERT_PHYSICAL_STORE_INFO
{
    uint           cbSize;
    const(char)*   pszOpenStoreProvider;
    uint           dwOpenEncodingType;
    uint           dwOpenFlags;
    CRYPTOAPI_BLOB OpenParameters;
    uint           dwFlags;
    uint           dwPriority;
}

struct CTL_VERIFY_USAGE_PARA
{
    uint           cbSize;
    CRYPTOAPI_BLOB ListIdentifier;
    uint           cCtlStore;
    void**         rghCtlStore;
    uint           cSignerStore;
    void**         rghSignerStore;
}

struct CTL_VERIFY_USAGE_STATUS
{
    uint           cbSize;
    uint           dwError;
    uint           dwFlags;
    CTL_CONTEXT**  ppCtl;
    uint           dwCtlEntryIndex;
    CERT_CONTEXT** ppSigner;
    uint           dwSignerIndex;
}

struct CERT_REVOCATION_CRL_INFO
{
    uint         cbSize;
    CRL_CONTEXT* pBaseCrlContext;
    CRL_CONTEXT* pDeltaCrlContext;
    CRL_ENTRY*   pCrlEntry;
    BOOL         fDeltaCrlEntry;
}

struct CERT_REVOCATION_PARA
{
    uint          cbSize;
    CERT_CONTEXT* pIssuerCert;
    uint          cCertStore;
    void**        rgCertStore;
    void*         hCrlStore;
    FILETIME*     pftTimeToUse;
}

struct CERT_REVOCATION_STATUS
{
    uint cbSize;
    uint dwIndex;
    uint dwError;
    uint dwReason;
    BOOL fHasFreshnessTime;
    uint dwFreshnessTime;
}

struct CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO
{
    CRYPTOAPI_BLOB CertSignHashCNGAlgPropData;
    CRYPTOAPI_BLOB CertIssuerPubKeyBitLengthPropData;
}

struct CRYPT_VERIFY_CERT_SIGN_WEAK_HASH_INFO
{
    uint     cCNGHashAlgid;
    ushort** rgpwszCNGHashAlgid;
    uint     dwWeakIndex;
}

struct CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA
{
    uint   cOID;
    byte** rgpszOID;
}

struct CRYPT_SIGN_MESSAGE_PARA
{
    uint             cbSize;
    uint             dwMsgEncodingType;
    CERT_CONTEXT*    pSigningCert;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void*            pvHashAuxInfo;
    uint             cMsgCert;
    CERT_CONTEXT**   rgpMsgCert;
    uint             cMsgCrl;
    CRL_CONTEXT**    rgpMsgCrl;
    uint             cAuthAttr;
    CRYPT_ATTRIBUTE* rgAuthAttr;
    uint             cUnauthAttr;
    CRYPT_ATTRIBUTE* rgUnauthAttr;
    uint             dwFlags;
    uint             dwInnerContentType;
}

struct CRYPT_VERIFY_MESSAGE_PARA
{
    uint   cbSize;
    uint   dwMsgAndCertEncodingType;
    size_t hCryptProv;
    PFN_CRYPT_GET_SIGNER_CERTIFICATE pfnGetSignerCertificate;
    void*  pvGetArg;
}

struct CRYPT_ENCRYPT_MESSAGE_PARA
{
    uint   cbSize;
    uint   dwMsgEncodingType;
    size_t hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER ContentEncryptionAlgorithm;
    void*  pvEncryptionAuxInfo;
    uint   dwFlags;
    uint   dwInnerContentType;
}

struct CRYPT_DECRYPT_MESSAGE_PARA
{
    uint   cbSize;
    uint   dwMsgAndCertEncodingType;
    uint   cCertStore;
    void** rghCertStore;
}

struct CRYPT_HASH_MESSAGE_PARA
{
    uint   cbSize;
    uint   dwMsgEncodingType;
    size_t hCryptProv;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void*  pvHashAuxInfo;
}

struct CRYPT_KEY_SIGN_MESSAGE_PARA
{
    uint  cbSize;
    uint  dwMsgAndCertEncodingType;
    union
    {
        size_t hCryptProv;
        size_t hNCryptKey;
    }
    uint  dwKeySpec;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    void* pvHashAuxInfo;
    CRYPT_ALGORITHM_IDENTIFIER PubKeyAlgorithm;
}

struct CRYPT_KEY_VERIFY_MESSAGE_PARA
{
    uint   cbSize;
    uint   dwMsgEncodingType;
    size_t hCryptProv;
}

struct CERT_CHAIN
{
    uint                cCerts;
    CRYPTOAPI_BLOB*     certs;
    CRYPT_KEY_PROV_INFO keyLocatorInfo;
}

struct CRYPT_BLOB_ARRAY
{
    uint            cBlob;
    CRYPTOAPI_BLOB* rgBlob;
}

struct CRYPT_CREDENTIALS
{
    uint         cbSize;
    const(char)* pszCredentialsOid;
    void*        pvCredentials;
}

struct CRYPT_PASSWORD_CREDENTIALSA
{
    uint         cbSize;
    const(char)* pszUsername;
    const(char)* pszPassword;
}

struct CRYPT_PASSWORD_CREDENTIALSW
{
    uint          cbSize;
    const(wchar)* pszUsername;
    const(wchar)* pszPassword;
}

struct CRYPTNET_URL_CACHE_PRE_FETCH_INFO
{
    uint     cbSize;
    uint     dwObjectType;
    uint     dwError;
    uint     dwReserved;
    FILETIME ThisUpdateTime;
    FILETIME NextUpdateTime;
    FILETIME PublishTime;
}

struct CRYPTNET_URL_CACHE_FLUSH_INFO
{
    uint     cbSize;
    uint     dwExemptSeconds;
    FILETIME ExpireTime;
}

struct CRYPTNET_URL_CACHE_RESPONSE_INFO
{
    uint          cbSize;
    ushort        wResponseType;
    ushort        wResponseFlags;
    FILETIME      LastModifiedTime;
    uint          dwMaxAge;
    const(wchar)* pwszETag;
    uint          dwProxyId;
}

struct CRYPT_RETRIEVE_AUX_INFO
{
    uint             cbSize;
    FILETIME*        pLastSyncTime;
    uint             dwMaxUrlRetrievalByteCount;
    CRYPTNET_URL_CACHE_PRE_FETCH_INFO* pPreFetchInfo;
    CRYPTNET_URL_CACHE_FLUSH_INFO* pFlushInfo;
    CRYPTNET_URL_CACHE_RESPONSE_INFO** ppResponseInfo;
    const(wchar)*    pwszCacheFileNamePrefix;
    FILETIME*        pftCacheResync;
    BOOL             fProxyCacheRetrieval;
    uint             dwHttpStatusCode;
    ushort**         ppwszErrorResponseHeaders;
    CRYPTOAPI_BLOB** ppErrorContentBlob;
}

struct CRYPT_ASYNC_RETRIEVAL_COMPLETION
{
    PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC pfnCompletion;
    void* pvCompletion;
}

struct CRYPT_URL_ARRAY
{
    uint     cUrl;
    ushort** rgwszUrl;
}

struct CRYPT_URL_INFO
{
    uint  cbSize;
    uint  dwSyncDeltaTime;
    uint  cGroup;
    uint* rgcGroupEntry;
}

struct CERT_CRL_CONTEXT_PAIR
{
    CERT_CONTEXT* pCertContext;
    CRL_CONTEXT*  pCrlContext;
}

struct CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO
{
    uint            cbSize;
    int             iDeltaCrlIndicator;
    FILETIME*       pftCacheResync;
    FILETIME*       pLastSyncTime;
    FILETIME*       pMaxAgeTime;
    CERT_REVOCATION_CHAIN_PARA* pChainPara;
    CRYPTOAPI_BLOB* pDeltaCrlIndicator;
}

struct CERT_CHAIN_ENGINE_CONFIG
{
    uint   cbSize;
    void*  hRestrictedRoot;
    void*  hRestrictedTrust;
    void*  hRestrictedOther;
    uint   cAdditionalStore;
    void** rghAdditionalStore;
    uint   dwFlags;
    uint   dwUrlRetrievalTimeout;
    uint   MaximumCachedCertificates;
    uint   CycleDetectionModulus;
    void*  hExclusiveRoot;
    void*  hExclusiveTrustedPeople;
    uint   dwExclusiveFlags;
}

struct CERT_TRUST_STATUS
{
    uint dwErrorStatus;
    uint dwInfoStatus;
}

struct CERT_REVOCATION_INFO
{
    uint         cbSize;
    uint         dwRevocationResult;
    const(char)* pszRevocationOid;
    void*        pvOidSpecificInfo;
    BOOL         fHasFreshnessTime;
    uint         dwFreshnessTime;
    CERT_REVOCATION_CRL_INFO* pCrlInfo;
}

struct CERT_TRUST_LIST_INFO
{
    uint         cbSize;
    CTL_ENTRY*   pCtlEntry;
    CTL_CONTEXT* pCtlContext;
}

struct CERT_CHAIN_ELEMENT
{
    uint              cbSize;
    CERT_CONTEXT*     pCertContext;
    CERT_TRUST_STATUS TrustStatus;
    CERT_REVOCATION_INFO* pRevocationInfo;
    CTL_USAGE*        pIssuanceUsage;
    CTL_USAGE*        pApplicationUsage;
    const(wchar)*     pwszExtendedErrorInfo;
}

struct CERT_SIMPLE_CHAIN
{
    uint                 cbSize;
    CERT_TRUST_STATUS    TrustStatus;
    uint                 cElement;
    CERT_CHAIN_ELEMENT** rgpElement;
    CERT_TRUST_LIST_INFO* pTrustListInfo;
    BOOL                 fHasRevocationFreshnessTime;
    uint                 dwRevocationFreshnessTime;
}

struct CERT_CHAIN_CONTEXT
{
    uint                 cbSize;
    CERT_TRUST_STATUS    TrustStatus;
    uint                 cChain;
    CERT_SIMPLE_CHAIN**  rgpChain;
    uint                 cLowerQualityChainContext;
    CERT_CHAIN_CONTEXT** rgpLowerQualityChainContext;
    BOOL                 fHasRevocationFreshnessTime;
    uint                 dwRevocationFreshnessTime;
    uint                 dwCreateFlags;
    GUID                 ChainId;
}

struct CERT_USAGE_MATCH
{
    uint      dwType;
    CTL_USAGE Usage;
}

struct CTL_USAGE_MATCH
{
    uint      dwType;
    CTL_USAGE Usage;
}

struct CERT_CHAIN_PARA
{
    uint             cbSize;
    CERT_USAGE_MATCH RequestedUsage;
}

struct CERT_REVOCATION_CHAIN_PARA
{
    uint             cbSize;
    HCERTCHAINENGINE hChainEngine;
    void*            hAdditionalStore;
    uint             dwChainFlags;
    uint             dwUrlRetrievalTimeout;
    FILETIME*        pftCurrentTime;
    FILETIME*        pftCacheResync;
    uint             cbMaxUrlRetrievalByteCount;
}

struct CRL_REVOCATION_INFO
{
    CRL_ENTRY*          pCrlEntry;
    CRL_CONTEXT*        pCrlContext;
    CERT_CHAIN_CONTEXT* pCrlIssuerChain;
}

struct CERT_CHAIN_FIND_BY_ISSUER_PARA
{
    uint            cbSize;
    const(char)*    pszUsageIdentifier;
    uint            dwKeySpec;
    uint            dwAcquirePrivateKeyFlags;
    uint            cIssuer;
    CRYPTOAPI_BLOB* rgIssuer;
    PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK pfnFindCallback;
    void*           pvFindArg;
}

struct CERT_CHAIN_POLICY_PARA
{
    uint  cbSize;
    uint  dwFlags;
    void* pvExtraPolicyPara;
}

struct CERT_CHAIN_POLICY_STATUS
{
    uint  cbSize;
    uint  dwError;
    int   lChainIndex;
    int   lElementIndex;
    void* pvExtraPolicyStatus;
}

struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint              cbSize;
    uint              dwRegPolicySettings;
    CMSG_SIGNER_INFO* pSignerInfo;
}

struct AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    BOOL fCommercial;
}

struct AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwRegPolicySettings;
    BOOL fCommercial;
}

struct HTTPSPolicyCallbackData
{
    union
    {
        uint cbStruct;
        uint cbSize;
    }
    uint    dwAuthType;
    uint    fdwChecks;
    ushort* pwszServerName;
}

struct EV_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint cbSize;
    uint dwRootProgramQualifierFlags;
}

struct EV_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint cbSize;
    uint dwQualifiers;
    uint dwIssuanceUsageIndex;
}

struct SSL_F12_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint        cbSize;
    uint        dwErrorLevel;
    uint        dwErrorCategory;
    uint        dwReserved;
    ushort[256] wszErrorText;
}

struct SSL_HPKP_HEADER_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint          cbSize;
    uint          dwReserved;
    const(wchar)* pwszServerName;
    byte[2]*      rgpszHpkpValue;
}

struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_PARA
{
    uint          cbSize;
    uint          dwReserved;
    const(wchar)* pwszServerName;
}

struct SSL_KEY_PIN_EXTRA_CERT_CHAIN_POLICY_STATUS
{
    uint        cbSize;
    int         lError;
    ushort[512] wszErrorText;
}

struct CRYPT_PKCS12_PBE_PARAMS
{
    int  iIterations;
    uint cbSalt;
}

struct PKCS12_PBES2_EXPORT_PARAMS
{
    uint          dwSize;
    void*         hNcryptDescriptor;
    const(wchar)* pwszPbes2Alg;
}

struct CERT_SERVER_OCSP_RESPONSE_CONTEXT
{
    uint   cbSize;
    ubyte* pbEncodedOcspResponse;
    uint   cbEncodedOcspResponse;
}

struct CERT_SERVER_OCSP_RESPONSE_OPEN_PARA
{
    uint          cbSize;
    uint          dwFlags;
    uint*         pcbUsedSize;
    const(wchar)* pwszOcspDirectory;
    PFN_CERT_SERVER_OCSP_RESPONSE_UPDATE_CALLBACK pfnUpdateCallback;
    void*         pvUpdateCallbackArg;
}

struct CERT_SELECT_CHAIN_PARA
{
    HCERTCHAINENGINE hChainEngine;
    FILETIME*        pTime;
    void*            hAdditionalStore;
    CERT_CHAIN_PARA* pChainPara;
    uint             dwFlags;
}

struct CERT_SELECT_CRITERIA
{
    uint   dwType;
    uint   cPara;
    void** ppPara;
}

struct CRYPT_TIMESTAMP_REQUEST
{
    uint            dwVersion;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB  HashedMessage;
    const(char)*    pszTSAPolicyId;
    CRYPTOAPI_BLOB  Nonce;
    BOOL            fCertReq;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIMESTAMP_RESPONSE
{
    uint           dwStatus;
    uint           cFreeText;
    ushort**       rgFreeText;
    CRYPT_BIT_BLOB FailureInfo;
    CRYPTOAPI_BLOB ContentInfo;
}

struct CRYPT_TIMESTAMP_ACCURACY
{
    uint dwSeconds;
    uint dwMillis;
    uint dwMicros;
}

struct CRYPT_TIMESTAMP_INFO
{
    uint            dwVersion;
    const(char)*    pszTSAPolicyId;
    CRYPT_ALGORITHM_IDENTIFIER HashAlgorithm;
    CRYPTOAPI_BLOB  HashedMessage;
    CRYPTOAPI_BLOB  SerialNumber;
    FILETIME        ftTime;
    CRYPT_TIMESTAMP_ACCURACY* pvAccuracy;
    BOOL            fOrdering;
    CRYPTOAPI_BLOB  Nonce;
    CRYPTOAPI_BLOB  Tsa;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_TIMESTAMP_CONTEXT
{
    uint   cbEncoded;
    ubyte* pbEncoded;
    CRYPT_TIMESTAMP_INFO* pTimeStamp;
}

struct CRYPT_TIMESTAMP_PARA
{
    const(char)*    pszTSAPolicyId;
    BOOL            fRequestCerts;
    CRYPTOAPI_BLOB  Nonce;
    uint            cExtension;
    CERT_EXTENSION* rgExtension;
}

struct CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE
{
    uint cbSize;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET pfnGet;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE pfnRelease;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD pfnFreePassword;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE pfnFree;
    PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER pfnFreeIdentifier;
}

struct CRYPTPROTECT_PROMPTSTRUCT
{
    uint          cbSize;
    uint          dwPromptFlags;
    HWND          hwndApp;
    const(wchar)* szPrompt;
}

struct SCARD_READERSTATEA
{
    const(char)* szReader;
    void*        pvUserData;
    uint         dwCurrentState;
    uint         dwEventState;
    uint         cbAtr;
    ubyte[36]    rgbAtr;
}

struct SCARD_READERSTATEW
{
    const(wchar)* szReader;
    void*         pvUserData;
    uint          dwCurrentState;
    uint          dwEventState;
    uint          cbAtr;
    ubyte[36]     rgbAtr;
}

struct SCARD_ATRMASK
{
    uint      cbAtr;
    ubyte[36] rgbAtr;
    ubyte[36] rgbMask;
}

struct OPENCARD_SEARCH_CRITERIAA
{
    uint           dwStructSize;
    const(char)*   lpstrGroupNames;
    uint           nMaxGroupNames;
    GUID*          rgguidInterfaces;
    uint           cguidInterfaces;
    const(char)*   lpstrCardNames;
    uint           nMaxCardNames;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNDSCPROC   lpfnDisconnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
}

struct OPENCARD_SEARCH_CRITERIAW
{
    uint           dwStructSize;
    const(wchar)*  lpstrGroupNames;
    uint           nMaxGroupNames;
    GUID*          rgguidInterfaces;
    uint           cguidInterfaces;
    const(wchar)*  lpstrCardNames;
    uint           nMaxCardNames;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNDSCPROC   lpfnDisconnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
}

struct OPENCARDNAME_EXA
{
    uint           dwStructSize;
    size_t         hSCardContext;
    HWND           hwndOwner;
    uint           dwFlags;
    const(char)*   lpstrTitle;
    const(char)*   lpstrSearchDesc;
    HICON          hIcon;
    OPENCARD_SEARCH_CRITERIAA* pOpenCardSearchCriteria;
    LPOCNCONNPROCA lpfnConnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    const(char)*   lpstrRdr;
    uint           nMaxRdr;
    const(char)*   lpstrCard;
    uint           nMaxCard;
    uint           dwActiveProtocol;
    size_t         hCardHandle;
}

struct OPENCARDNAME_EXW
{
    uint           dwStructSize;
    size_t         hSCardContext;
    HWND           hwndOwner;
    uint           dwFlags;
    const(wchar)*  lpstrTitle;
    const(wchar)*  lpstrSearchDesc;
    HICON          hIcon;
    OPENCARD_SEARCH_CRITERIAW* pOpenCardSearchCriteria;
    LPOCNCONNPROCW lpfnConnect;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    const(wchar)*  lpstrRdr;
    uint           nMaxRdr;
    const(wchar)*  lpstrCard;
    uint           nMaxCard;
    uint           dwActiveProtocol;
    size_t         hCardHandle;
}

struct READER_SEL_REQUEST
{
    uint dwShareMode;
    uint dwPreferredProtocols;
    READER_SEL_REQUEST_MATCH_TYPE MatchType;
    union
    {
        struct ReaderAndContainerParameter
        {
            uint cbReaderNameOffset;
            uint cchReaderNameLength;
            uint cbContainerNameOffset;
            uint cchContainerNameLength;
            uint dwDesiredCardModuleVersion;
            uint dwCspFlags;
        }
        struct SerialNumberParameter
        {
            uint cbSerialNumberOffset;
            uint cbSerialNumberLength;
            uint dwDesiredCardModuleVersion;
        }
    }
}

struct READER_SEL_RESPONSE
{
    uint cbReaderNameOffset;
    uint cchReaderNameLength;
    uint cbCardNameOffset;
    uint cchCardNameLength;
}

struct OPENCARDNAMEA
{
    uint           dwStructSize;
    HWND           hwndOwner;
    size_t         hSCardContext;
    const(char)*   lpstrGroupNames;
    uint           nMaxGroupNames;
    const(char)*   lpstrCardNames;
    uint           nMaxCardNames;
    GUID*          rgguidInterfaces;
    uint           cguidInterfaces;
    const(char)*   lpstrRdr;
    uint           nMaxRdr;
    const(char)*   lpstrCard;
    uint           nMaxCard;
    const(char)*   lpstrTitle;
    uint           dwFlags;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    uint           dwActiveProtocol;
    LPOCNCONNPROCA lpfnConnect;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNDSCPROC   lpfnDisconnect;
    size_t         hCardHandle;
}

struct OPENCARDNAMEW
{
    uint           dwStructSize;
    HWND           hwndOwner;
    size_t         hSCardContext;
    const(wchar)*  lpstrGroupNames;
    uint           nMaxGroupNames;
    const(wchar)*  lpstrCardNames;
    uint           nMaxCardNames;
    GUID*          rgguidInterfaces;
    uint           cguidInterfaces;
    const(wchar)*  lpstrRdr;
    uint           nMaxRdr;
    const(wchar)*  lpstrCard;
    uint           nMaxCard;
    const(wchar)*  lpstrTitle;
    uint           dwFlags;
    void*          pvUserData;
    uint           dwShareMode;
    uint           dwPreferredProtocols;
    uint           dwActiveProtocol;
    LPOCNCONNPROCW lpfnConnect;
    LPOCNCHKPROC   lpfnCheck;
    LPOCNDSCPROC   lpfnDisconnect;
    size_t         hCardHandle;
}

struct SERVICE_TRIGGER_CUSTOM_STATE_ID
{
    uint[2] Data;
}

struct SERVICE_CUSTOM_SYSTEM_STATE_CHANGE_DATA_ITEM
{
    union u
    {
        SERVICE_TRIGGER_CUSTOM_STATE_ID CustomStateId;
        struct s
        {
            uint     DataOffset;
            ubyte[1] Data;
        }
    }
}

struct SERVICE_DESCRIPTIONA
{
    const(char)* lpDescription;
}

struct SERVICE_DESCRIPTIONW
{
    const(wchar)* lpDescription;
}

struct SC_ACTION
{
    SC_ACTION_TYPE Type;
    uint           Delay;
}

struct SERVICE_FAILURE_ACTIONSA
{
    uint         dwResetPeriod;
    const(char)* lpRebootMsg;
    const(char)* lpCommand;
    uint         cActions;
    SC_ACTION*   lpsaActions;
}

struct SERVICE_FAILURE_ACTIONSW
{
    uint          dwResetPeriod;
    const(wchar)* lpRebootMsg;
    const(wchar)* lpCommand;
    uint          cActions;
    SC_ACTION*    lpsaActions;
}

struct SERVICE_DELAYED_AUTO_START_INFO
{
    BOOL fDelayedAutostart;
}

struct SERVICE_FAILURE_ACTIONS_FLAG
{
    BOOL fFailureActionsOnNonCrashFailures;
}

struct SERVICE_SID_INFO
{
    uint dwServiceSidType;
}

struct SERVICE_REQUIRED_PRIVILEGES_INFOA
{
    const(char)* pmszRequiredPrivileges;
}

struct SERVICE_REQUIRED_PRIVILEGES_INFOW
{
    const(wchar)* pmszRequiredPrivileges;
}

struct SERVICE_PRESHUTDOWN_INFO
{
    uint dwPreshutdownTimeout;
}

struct SERVICE_TRIGGER_SPECIFIC_DATA_ITEM
{
    uint   dwDataType;
    uint   cbData;
    ubyte* pData;
}

struct SERVICE_TRIGGER
{
    uint  dwTriggerType;
    uint  dwAction;
    GUID* pTriggerSubtype;
    uint  cDataItems;
    SERVICE_TRIGGER_SPECIFIC_DATA_ITEM* pDataItems;
}

struct SERVICE_TRIGGER_INFO
{
    uint             cTriggers;
    SERVICE_TRIGGER* pTriggers;
    ubyte*           pReserved;
}

struct SERVICE_PREFERRED_NODE_INFO
{
    ushort usPreferredNode;
    ubyte  fDelete;
}

struct SERVICE_TIMECHANGE_INFO
{
    LARGE_INTEGER liNewTime;
    LARGE_INTEGER liOldTime;
}

struct SERVICE_LAUNCH_PROTECTED_INFO
{
    uint dwLaunchProtected;
}

struct SC_HANDLE__
{
    int unused;
}

struct SERVICE_STATUS_HANDLE__
{
    int unused;
}

struct SERVICE_STATUS
{
    uint dwServiceType;
    uint dwCurrentState;
    uint dwControlsAccepted;
    uint dwWin32ExitCode;
    uint dwServiceSpecificExitCode;
    uint dwCheckPoint;
    uint dwWaitHint;
}

struct SERVICE_STATUS_PROCESS
{
    uint dwServiceType;
    uint dwCurrentState;
    uint dwControlsAccepted;
    uint dwWin32ExitCode;
    uint dwServiceSpecificExitCode;
    uint dwCheckPoint;
    uint dwWaitHint;
    uint dwProcessId;
    uint dwServiceFlags;
}

struct ENUM_SERVICE_STATUSA
{
    const(char)*   lpServiceName;
    const(char)*   lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

struct ENUM_SERVICE_STATUSW
{
    const(wchar)*  lpServiceName;
    const(wchar)*  lpDisplayName;
    SERVICE_STATUS ServiceStatus;
}

struct ENUM_SERVICE_STATUS_PROCESSA
{
    const(char)* lpServiceName;
    const(char)* lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

struct ENUM_SERVICE_STATUS_PROCESSW
{
    const(wchar)* lpServiceName;
    const(wchar)* lpDisplayName;
    SERVICE_STATUS_PROCESS ServiceStatusProcess;
}

struct QUERY_SERVICE_LOCK_STATUSA
{
    uint         fIsLocked;
    const(char)* lpLockOwner;
    uint         dwLockDuration;
}

struct QUERY_SERVICE_LOCK_STATUSW
{
    uint          fIsLocked;
    const(wchar)* lpLockOwner;
    uint          dwLockDuration;
}

struct QUERY_SERVICE_CONFIGA
{
    uint         dwServiceType;
    uint         dwStartType;
    uint         dwErrorControl;
    const(char)* lpBinaryPathName;
    const(char)* lpLoadOrderGroup;
    uint         dwTagId;
    const(char)* lpDependencies;
    const(char)* lpServiceStartName;
    const(char)* lpDisplayName;
}

struct QUERY_SERVICE_CONFIGW
{
    uint          dwServiceType;
    uint          dwStartType;
    uint          dwErrorControl;
    const(wchar)* lpBinaryPathName;
    const(wchar)* lpLoadOrderGroup;
    uint          dwTagId;
    const(wchar)* lpDependencies;
    const(wchar)* lpServiceStartName;
    const(wchar)* lpDisplayName;
}

struct SERVICE_TABLE_ENTRYA
{
    const(char)* lpServiceName;
    LPSERVICE_MAIN_FUNCTIONA lpServiceProc;
}

struct SERVICE_TABLE_ENTRYW
{
    const(wchar)* lpServiceName;
    LPSERVICE_MAIN_FUNCTIONW lpServiceProc;
}

struct SERVICE_NOTIFY_1
{
    uint  dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void* pContext;
    uint  dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_NOTIFY_2A
{
    uint         dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void*        pContext;
    uint         dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint         dwNotificationTriggered;
    const(char)* pszServiceNames;
}

struct SERVICE_NOTIFY_2W
{
    uint          dwVersion;
    PFN_SC_NOTIFY_CALLBACK pfnNotifyCallback;
    void*         pContext;
    uint          dwNotificationStatus;
    SERVICE_STATUS_PROCESS ServiceStatus;
    uint          dwNotificationTriggered;
    const(wchar)* pszServiceNames;
}

struct SERVICE_CONTROL_STATUS_REASON_PARAMSA
{
    uint         dwReason;
    const(char)* pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_CONTROL_STATUS_REASON_PARAMSW
{
    uint          dwReason;
    const(wchar)* pszComment;
    SERVICE_STATUS_PROCESS ServiceStatus;
}

struct SERVICE_START_REASON
{
    uint dwReason;
}

struct _SC_NOTIFICATION_REGISTRATION
{
}

struct LSA_TRUST_INFORMATION
{
    UNICODE_STRING Name;
    void*          Sid;
}

struct LSA_REFERENCED_DOMAIN_LIST
{
    uint Entries;
    LSA_TRUST_INFORMATION* Domains;
}

struct LSA_TRANSLATED_SID2
{
    SID_NAME_USE Use;
    void*        Sid;
    int          DomainIndex;
    uint         Flags;
}

struct LSA_TRANSLATED_NAME
{
    SID_NAME_USE   Use;
    UNICODE_STRING Name;
    int            DomainIndex;
}

struct POLICY_ACCOUNT_DOMAIN_INFO
{
    UNICODE_STRING DomainName;
    void*          DomainSid;
}

struct POLICY_DNS_DOMAIN_INFO
{
    UNICODE_STRING Name;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING DnsForestName;
    GUID           DomainGuid;
    void*          Sid;
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
    uint     AccessMask;
    uint[32] AccessReasons;
    uint     ObjectTypeIndex;
    uint     AccessGranted;
    void*    SecurityDescriptor;
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

struct LSA_TRANSLATED_SID
{
    SID_NAME_USE Use;
    uint         RelativeId;
    int          DomainIndex;
}

struct POLICY_AUDIT_LOG_INFO
{
    uint          AuditLogPercentFull;
    uint          MaximumLogSize;
    LARGE_INTEGER AuditRetentionPeriod;
    ubyte         AuditLogFullShutdownInProgress;
    LARGE_INTEGER TimeToShutdown;
    uint          NextAuditRecordId;
}

struct POLICY_AUDIT_EVENTS_INFO
{
    ubyte AuditingMode;
    uint* EventAuditingOptions;
    uint  MaximumAuditEventCount;
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

struct POLICY_PRIMARY_DOMAIN_INFO
{
    UNICODE_STRING Name;
    void*          Sid;
}

struct POLICY_PD_ACCOUNT_INFO
{
    UNICODE_STRING Name;
}

struct POLICY_LSA_SERVER_ROLE_INFO
{
    POLICY_LSA_SERVER_ROLE LsaServerRole;
}

struct POLICY_REPLICA_SOURCE_INFO
{
    UNICODE_STRING ReplicaSource;
    UNICODE_STRING ReplicaAccountName;
}

struct POLICY_DEFAULT_QUOTA_INFO
{
    QUOTA_LIMITS QuotaLimits;
}

struct POLICY_MODIFICATION_INFO
{
    LARGE_INTEGER ModifiedId;
    LARGE_INTEGER DatabaseCreationTime;
}

struct POLICY_AUDIT_FULL_SET_INFO
{
    ubyte ShutDownOnFull;
}

struct POLICY_AUDIT_FULL_QUERY_INFO
{
    ubyte ShutDownOnFull;
    ubyte LogIsFull;
}

struct POLICY_DOMAIN_EFS_INFO
{
    uint   InfoLength;
    ubyte* EfsBlob;
}

struct POLICY_DOMAIN_KERBEROS_TICKET_INFO
{
    uint          AuthenticationOptions;
    LARGE_INTEGER MaxServiceTicketAge;
    LARGE_INTEGER MaxTicketAge;
    LARGE_INTEGER MaxRenewAge;
    LARGE_INTEGER MaxClockSkew;
    LARGE_INTEGER Reserved;
}

struct POLICY_MACHINE_ACCT_INFO
{
    uint  Rid;
    void* Sid;
}

struct TRUSTED_DOMAIN_NAME_INFO
{
    UNICODE_STRING Name;
}

struct TRUSTED_CONTROLLERS_INFO
{
    uint            Entries;
    UNICODE_STRING* Names;
}

struct TRUSTED_POSIX_OFFSET_INFO
{
    uint Offset;
}

struct TRUSTED_PASSWORD_INFO
{
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
}

struct TRUSTED_DOMAIN_INFORMATION_EX
{
    UNICODE_STRING Name;
    UNICODE_STRING FlatName;
    void*          Sid;
    uint           TrustDirection;
    uint           TrustType;
    uint           TrustAttributes;
}

struct TRUSTED_DOMAIN_INFORMATION_EX2
{
    UNICODE_STRING Name;
    UNICODE_STRING FlatName;
    void*          Sid;
    uint           TrustDirection;
    uint           TrustType;
    uint           TrustAttributes;
    uint           ForestTrustLength;
    ubyte*         ForestTrustInfo;
}

struct LSA_AUTH_INFORMATION
{
    LARGE_INTEGER LastUpdateTime;
    uint          AuthType;
    uint          AuthInfoLength;
    ubyte*        AuthInfo;
}

struct TRUSTED_DOMAIN_AUTH_INFORMATION
{
    uint IncomingAuthInfos;
    LSA_AUTH_INFORMATION* IncomingAuthenticationInformation;
    LSA_AUTH_INFORMATION* IncomingPreviousAuthenticationInformation;
    uint OutgoingAuthInfos;
    LSA_AUTH_INFORMATION* OutgoingAuthenticationInformation;
    LSA_AUTH_INFORMATION* OutgoingPreviousAuthenticationInformation;
}

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

struct LSA_FOREST_TRUST_DOMAIN_INFO
{
    void*          Sid;
    UNICODE_STRING DnsName;
    UNICODE_STRING NetbiosName;
}

struct LSA_FOREST_TRUST_BINARY_DATA
{
    uint   Length;
    ubyte* Buffer;
}

struct LSA_FOREST_TRUST_RECORD
{
    uint          Flags;
    LSA_FOREST_TRUST_RECORD_TYPE ForestTrustType;
    LARGE_INTEGER Time;
    union ForestTrustData
    {
        UNICODE_STRING TopLevelName;
        LSA_FOREST_TRUST_DOMAIN_INFO DomainInfo;
        LSA_FOREST_TRUST_BINARY_DATA Data;
    }
}

struct LSA_FOREST_TRUST_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_RECORD** Entries;
}

struct LSA_FOREST_TRUST_COLLISION_RECORD
{
    uint           Index;
    LSA_FOREST_TRUST_COLLISION_RECORD_TYPE Type;
    uint           Flags;
    UNICODE_STRING Name;
}

struct LSA_FOREST_TRUST_COLLISION_INFORMATION
{
    uint RecordCount;
    LSA_FOREST_TRUST_COLLISION_RECORD** Entries;
}

struct LSA_ENUMERATION_INFORMATION
{
    void* Sid;
}

struct LSA_LAST_INTER_LOGON_INFO
{
    LARGE_INTEGER LastSuccessfulLogon;
    LARGE_INTEGER LastFailedLogon;
    uint          FailedAttemptCountSinceLastSuccessfulLogon;
}

struct SECURITY_LOGON_SESSION_DATA
{
    uint           Size;
    LUID           LogonId;
    UNICODE_STRING UserName;
    UNICODE_STRING LogonDomain;
    UNICODE_STRING AuthenticationPackage;
    uint           LogonType;
    uint           Session;
    void*          Sid;
    LARGE_INTEGER  LogonTime;
    UNICODE_STRING LogonServer;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    uint           UserFlags;
    LSA_LAST_INTER_LOGON_INFO LastLogonInfo;
    UNICODE_STRING LogonScript;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING HomeDirectoryDrive;
    LARGE_INTEGER  LogoffTime;
    LARGE_INTEGER  KickOffTime;
    LARGE_INTEGER  PasswordLastSet;
    LARGE_INTEGER  PasswordCanChange;
    LARGE_INTEGER  PasswordMustChange;
}

struct CENTRAL_ACCESS_POLICY_ENTRY
{
    UNICODE_STRING Name;
    UNICODE_STRING Description;
    UNICODE_STRING ChangeId;
    uint           LengthAppliesTo;
    ubyte*         AppliesTo;
    uint           LengthSD;
    void*          SD;
    uint           LengthStagedSD;
    void*          StagedSD;
    uint           Flags;
}

struct CENTRAL_ACCESS_POLICY
{
    void*          CAPID;
    UNICODE_STRING Name;
    UNICODE_STRING Description;
    UNICODE_STRING ChangeId;
    uint           Flags;
    uint           CAPECount;
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
    uint          MessageType;
    const(wchar)* CallerName;
}

struct DOMAIN_PASSWORD_INFORMATION
{
    ushort        MinPasswordLength;
    ushort        PasswordHistoryLength;
    uint          PasswordProperties;
    LARGE_INTEGER MaxPasswordAge;
    LARGE_INTEGER MinPasswordAge;
}

struct MSV1_0_INTERACTIVE_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Password;
}

struct MSV1_0_INTERACTIVE_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    ushort         LogonCount;
    ushort         BadPasswordCount;
    LARGE_INTEGER  LogonTime;
    LARGE_INTEGER  LogoffTime;
    LARGE_INTEGER  KickOffTime;
    LARGE_INTEGER  PasswordLastSet;
    LARGE_INTEGER  PasswordCanChange;
    LARGE_INTEGER  PasswordMustChange;
    UNICODE_STRING LogonScript;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING FullName;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING LogonServer;
    uint           UserFlags;
}

struct MSV1_0_LM20_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Workstation;
    ubyte[8]       ChallengeToClient;
    STRING         CaseSensitiveChallengeResponse;
    STRING         CaseInsensitiveChallengeResponse;
    uint           ParameterControl;
}

struct MSV1_0_SUBAUTH_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Workstation;
    ubyte[8]       ChallengeToClient;
    STRING         AuthenticationInfo1;
    STRING         AuthenticationInfo2;
    uint           ParameterControl;
    uint           SubAuthPackageId;
}

struct MSV1_0_S4U_LOGON
{
    MSV1_0_LOGON_SUBMIT_TYPE MessageType;
    uint           Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
}

struct MSV1_0_LM20_LOGON_PROFILE
{
    MSV1_0_PROFILE_BUFFER_TYPE MessageType;
    LARGE_INTEGER  KickOffTime;
    LARGE_INTEGER  LogoffTime;
    uint           UserFlags;
    ubyte[16]      UserSessionKey;
    UNICODE_STRING LogonDomainName;
    ubyte[8]       LanmanSessionKey;
    UNICODE_STRING LogonServer;
    UNICODE_STRING UserParameters;
}

struct MSV1_0_CREDENTIAL_KEY
{
    ubyte[20] Data;
}

struct MSV1_0_SUPPLEMENTAL_CREDENTIAL
{
    uint      Version;
    uint      Flags;
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
    ubyte[1] EncryptedCreds;
}

struct MSV1_0_REMOTE_SUPPLEMENTAL_CREDENTIAL
{
align (1):
    uint     Version;
    uint     Flags;
    MSV1_0_CREDENTIAL_KEY CredentialKey;
    MSV1_0_CREDENTIAL_KEY_TYPE CredentialKeyType;
    uint     EncryptedCredsSize;
    ubyte[1] EncryptedCreds;
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
    ubyte[1]  Buffer;
}

struct MSV1_0_AV_PAIR
{
    ushort AvId;
    ushort AvLen;
}

struct MSV1_0_CHANGEPASSWORD_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING OldPassword;
    UNICODE_STRING NewPassword;
    ubyte          Impersonating;
}

struct MSV1_0_CHANGEPASSWORD_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    ubyte PasswordInfoValid;
    DOMAIN_PASSWORD_INFORMATION DomainPasswordInfo;
}

struct MSV1_0_PASSTHROUGH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING PackageName;
    uint           DataLength;
    ubyte*         LogonData;
    uint           Pad;
}

struct MSV1_0_PASSTHROUGH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   Pad;
    uint   DataLength;
    ubyte* ValidationData;
}

struct MSV1_0_SUBAUTH_REQUEST
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   SubAuthPackageId;
    uint   SubAuthInfoLength;
    ubyte* SubAuthSubmitBuffer;
}

struct MSV1_0_SUBAUTH_RESPONSE
{
    MSV1_0_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   SubAuthInfoLength;
    ubyte* SubAuthReturnBuffer;
}

struct KERB_INTERACTIVE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Password;
}

struct KERB_INTERACTIVE_UNLOCK_LOGON
{
    KERB_INTERACTIVE_LOGON Logon;
    LUID LogonId;
}

struct KERB_SMART_CARD_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING Pin;
    uint           CspDataLength;
    ubyte*         CspData;
}

struct KERB_SMART_CARD_UNLOCK_LOGON
{
    KERB_SMART_CARD_LOGON Logon;
    LUID LogonId;
}

struct KERB_CERTIFICATE_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING UserName;
    UNICODE_STRING Pin;
    uint           Flags;
    uint           CspDataLength;
    ubyte*         CspData;
}

struct KERB_CERTIFICATE_UNLOCK_LOGON
{
    KERB_CERTIFICATE_LOGON Logon;
    LUID LogonId;
}

struct KERB_CERTIFICATE_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint           Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
    uint           CertificateLength;
    ubyte*         Certificate;
}

struct KERB_TICKET_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint   Flags;
    uint   ServiceTicketLength;
    uint   TicketGrantingTicketLength;
    ubyte* ServiceTicket;
    ubyte* TicketGrantingTicket;
}

struct KERB_TICKET_UNLOCK_LOGON
{
    KERB_TICKET_LOGON Logon;
    LUID              LogonId;
}

struct KERB_S4U_LOGON
{
    KERB_LOGON_SUBMIT_TYPE MessageType;
    uint           Flags;
    UNICODE_STRING ClientUpn;
    UNICODE_STRING ClientRealm;
}

struct KERB_INTERACTIVE_PROFILE
{
    KERB_PROFILE_BUFFER_TYPE MessageType;
    ushort         LogonCount;
    ushort         BadPasswordCount;
    LARGE_INTEGER  LogonTime;
    LARGE_INTEGER  LogoffTime;
    LARGE_INTEGER  KickOffTime;
    LARGE_INTEGER  PasswordLastSet;
    LARGE_INTEGER  PasswordCanChange;
    LARGE_INTEGER  PasswordMustChange;
    UNICODE_STRING LogonScript;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING FullName;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING LogonServer;
    uint           UserFlags;
}

struct KERB_SMART_CARD_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    uint   CertificateSize;
    ubyte* CertificateData;
}

struct KERB_CRYPTO_KEY
{
    int    KeyType;
    uint   Length;
    ubyte* Value;
}

struct KERB_CRYPTO_KEY32
{
    int  KeyType;
    uint Length;
    uint Offset;
}

struct KERB_TICKET_PROFILE
{
    KERB_INTERACTIVE_PROFILE Profile;
    KERB_CRYPTO_KEY SessionKey;
}

struct KERB_QUERY_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

struct KERB_TICKET_CACHE_INFO
{
    UNICODE_STRING ServerName;
    UNICODE_STRING RealmName;
    LARGE_INTEGER  StartTime;
    LARGE_INTEGER  EndTime;
    LARGE_INTEGER  RenewTime;
    int            EncryptionType;
    uint           TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER  StartTime;
    LARGE_INTEGER  EndTime;
    LARGE_INTEGER  RenewTime;
    int            EncryptionType;
    uint           TicketFlags;
}

struct KERB_TICKET_CACHE_INFO_EX2
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER  StartTime;
    LARGE_INTEGER  EndTime;
    LARGE_INTEGER  RenewTime;
    int            EncryptionType;
    uint           TicketFlags;
    uint           SessionKeyType;
    uint           BranchId;
}

struct KERB_TICKET_CACHE_INFO_EX3
{
    UNICODE_STRING ClientName;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ServerName;
    UNICODE_STRING ServerRealm;
    LARGE_INTEGER  StartTime;
    LARGE_INTEGER  EndTime;
    LARGE_INTEGER  RenewTime;
    int            EncryptionType;
    uint           TicketFlags;
    uint           SessionKeyType;
    uint           BranchId;
    uint           CacheFlags;
    UNICODE_STRING KdcCalled;
}

struct KERB_QUERY_TKT_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO[1] Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX[1] Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX2_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX2[1] Tickets;
}

struct KERB_QUERY_TKT_CACHE_EX3_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfTickets;
    KERB_TICKET_CACHE_INFO_EX3[1] Tickets;
}

struct SecHandle
{
    size_t dwLower;
    size_t dwUpper;
}

struct KERB_AUTH_DATA
{
    uint   Type;
    uint   Length;
    ubyte* Data;
}

struct KERB_NET_ADDRESS
{
    uint         Family;
    uint         Length;
    const(char)* Address;
}

struct KERB_NET_ADDRESSES
{
    uint                Number;
    KERB_NET_ADDRESS[1] Addresses;
}

struct KERB_EXTERNAL_NAME
{
    short             NameType;
    ushort            NameCount;
    UNICODE_STRING[1] Names;
}

struct KERB_EXTERNAL_TICKET
{
    KERB_EXTERNAL_NAME* ServiceName;
    KERB_EXTERNAL_NAME* TargetName;
    KERB_EXTERNAL_NAME* ClientName;
    UNICODE_STRING      DomainName;
    UNICODE_STRING      TargetDomainName;
    UNICODE_STRING      AltTargetDomainName;
    KERB_CRYPTO_KEY     SessionKey;
    uint                TicketFlags;
    uint                Flags;
    LARGE_INTEGER       KeyExpirationTime;
    LARGE_INTEGER       StartTime;
    LARGE_INTEGER       EndTime;
    LARGE_INTEGER       RenewUntil;
    LARGE_INTEGER       TimeSkew;
    uint                EncodedTicketSize;
    ubyte*              EncodedTicket;
}

struct KERB_RETRIEVE_TKT_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID           LogonId;
    UNICODE_STRING TargetName;
    uint           TicketFlags;
    uint           CacheOptions;
    int            EncryptionType;
    SecHandle      CredentialsHandle;
}

struct KERB_RETRIEVE_TKT_RESPONSE
{
    KERB_EXTERNAL_TICKET Ticket;
}

struct KERB_PURGE_TKT_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID           LogonId;
    UNICODE_STRING ServerName;
    UNICODE_STRING RealmName;
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
    ulong          SinceLastUsed;
    UNICODE_STRING DomainName;
    UNICODE_STRING ProxyServerName;
    UNICODE_STRING ProxyServerVdir;
    ushort         ProxyServerPort;
    LUID           LogonId;
    UNICODE_STRING CredUserName;
    UNICODE_STRING CredDomainName;
    ubyte          GlobalCache;
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
    UNICODE_STRING ServerName;
    uint           Flags;
    NTSTATUS       LastStatus;
    LARGE_INTEGER  Expiry;
}

struct KERB_S4U2PROXY_CRED
{
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    uint           Flags;
    NTSTATUS       LastStatus;
    LARGE_INTEGER  Expiry;
    uint           CountOfEntries;
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
    uint           Flags;
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
}

struct KERB_RETRIEVE_KEY_TAB_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint   KeyTabLength;
    ubyte* KeyTab;
}

struct KERB_CHANGEPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING OldPassword;
    UNICODE_STRING NewPassword;
    ubyte          Impersonating;
}

struct KERB_SETPASSWORD_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID           LogonId;
    SecHandle      CredentialsHandle;
    uint           Flags;
    UNICODE_STRING DomainName;
    UNICODE_STRING AccountName;
    UNICODE_STRING Password;
}

struct KERB_SETPASSWORD_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID           LogonId;
    SecHandle      CredentialsHandle;
    uint           Flags;
    UNICODE_STRING AccountRealm;
    UNICODE_STRING AccountName;
    UNICODE_STRING Password;
    UNICODE_STRING ClientRealm;
    UNICODE_STRING ClientName;
    ubyte          Impersonating;
    UNICODE_STRING KdcAddress;
    uint           KdcAddressType;
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
    ubyte[1] DecryptedData;
}

struct KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint           AddressType;
}

struct KERB_REFRESH_SCCRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING CredentialBlob;
    LUID           LogonId;
    uint           Flags;
}

struct KERB_ADD_CREDENTIALS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING UserName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    LUID           LogonId;
    uint           Flags;
}

struct KERB_ADD_CREDENTIALS_REQUEST_EX
{
    KERB_ADD_CREDENTIALS_REQUEST Credentials;
    uint              PrincipalNameCount;
    UNICODE_STRING[1] PrincipalNames;
}

struct KERB_TRANSFER_CRED_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID OriginLogonId;
    LUID DestinationLogonId;
    uint Flags;
}

struct KERB_CLEANUP_MACHINE_PKINIT_CREDS_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    LUID LogonId;
}

struct KERB_BINDING_CACHE_ENTRY_DATA
{
    ulong          DiscoveryTime;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint           AddressType;
    uint           Flags;
    uint           DcFlags;
    uint           CacheFlags;
    UNICODE_STRING KdcName;
}

struct KERB_QUERY_BINDING_CACHE_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint CountOfEntries;
    KERB_BINDING_CACHE_ENTRY_DATA* Entries;
}

struct KERB_ADD_BINDING_CACHE_ENTRY_EX_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    UNICODE_STRING RealmName;
    UNICODE_STRING KdcAddress;
    uint           AddressType;
    uint           DcFlags;
}

struct KERB_QUERY_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

struct KERB_PURGE_BINDING_CACHE_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
}

struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_REQUEST
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint           Flags;
    UNICODE_STRING DomainName;
}

struct KERB_QUERY_DOMAIN_EXTENDED_POLICIES_RESPONSE
{
    KERB_PROTOCOL_MESSAGE_TYPE MessageType;
    uint Flags;
    uint ExtendedPolicies;
    uint DsFlags;
}

struct KERB_CERTIFICATE_HASHINFO
{
    ushort StoreNameLength;
    ushort HashLength;
}

struct KERB_CERTIFICATE_INFO
{
    uint CertInfoSize;
    uint InfoType;
}

struct POLICY_AUDIT_SID_ARRAY
{
    uint   UsersCount;
    void** UserSidArray;
}

struct AUDIT_POLICY_INFORMATION
{
    GUID AuditSubCategoryGuid;
    uint AuditingInformation;
    GUID AuditCategoryGuid;
}

struct PKU2U_CERT_BLOB
{
    uint   CertOffset;
    ushort CertLength;
}

struct PKU2U_CREDUI_CONTEXT
{
    ulong  Version;
    ushort cbHeaderLength;
    uint   cbStructureLength;
    ushort CertArrayCount;
    uint   CertArrayOffset;
}

struct PKU2U_CERTIFICATE_S4U_LOGON
{
    PKU2U_LOGON_SUBMIT_TYPE MessageType;
    uint           Flags;
    UNICODE_STRING UserPrincipalName;
    UNICODE_STRING DomainName;
    uint           CertificateLength;
    ubyte*         Certificate;
}

struct SecPkgInfoW
{
    uint    fCapabilities;
    ushort  wVersion;
    ushort  wRPCID;
    uint    cbMaxToken;
    ushort* Name;
    ushort* Comment;
}

struct SecPkgInfoA
{
    uint   fCapabilities;
    ushort wVersion;
    ushort wRPCID;
    uint   cbMaxToken;
    byte*  Name;
    byte*  Comment;
}

struct SecBuffer
{
    uint  cbBuffer;
    uint  BufferType;
    void* pvBuffer;
}

struct SecBufferDesc
{
    uint       ulVersion;
    uint       cBuffers;
    SecBuffer* pBuffers;
}

struct SEC_NEGOTIATION_INFO
{
    uint    Size;
    uint    NameLength;
    ushort* Name;
    void*   Reserved;
}

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

struct SEC_APPLICATION_PROTOCOL_LIST
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ushort   ProtocolListSize;
    ubyte[1] ProtocolList;
}

struct SEC_APPLICATION_PROTOCOLS
{
    uint ProtocolListsSize;
    SEC_APPLICATION_PROTOCOL_LIST[1] ProtocolLists;
}

struct SEC_SRTP_PROTECTION_PROFILES
{
    ushort    ProfilesSize;
    ushort[1] ProfilesList;
}

struct SEC_SRTP_MASTER_KEY_IDENTIFIER
{
    ubyte    MasterKeyIdentifierSize;
    ubyte[1] MasterKeyIdentifier;
}

struct SEC_TOKEN_BINDING
{
    ubyte    MajorVersion;
    ubyte    MinorVersion;
    ushort   KeyParametersSize;
    ubyte[1] KeyParameters;
}

struct SEC_PRESHAREDKEY
{
    ushort   KeySize;
    ubyte[1] Key;
}

struct SEC_PRESHAREDKEY_IDENTITY
{
    ushort   KeyIdentitySize;
    ubyte[1] KeyIdentity;
}

struct SEC_DTLS_MTU
{
    ushort PathMTU;
}

struct SEC_FLAGS
{
    ulong Flags;
}

struct SEC_TRAFFIC_SECRETS
{
    ushort[64] SymmetricAlgId;
    ushort[64] ChainingMode;
    ushort[64] HashAlgId;
    ushort     KeySize;
    ushort     IvSize;
    ushort     MsgSequenceStart;
    ushort     MsgSequenceEnd;
    SEC_TRAFFIC_SECRET_TYPE TrafficSecretType;
    ushort     TrafficSecretSize;
    ubyte[1]   TrafficSecret;
}

struct SecPkgCredentials_NamesW
{
    ushort* sUserName;
}

struct SecPkgCredentials_NamesA
{
    byte* sUserName;
}

struct SecPkgCredentials_SSIProviderW
{
    ushort* sProviderName;
    uint    ProviderInfoLength;
    byte*   ProviderInfo;
}

struct SecPkgCredentials_SSIProviderA
{
    byte* sProviderName;
    uint  ProviderInfoLength;
    byte* ProviderInfo;
}

struct SecPkgCredentials_KdcProxySettingsW
{
    uint   Version;
    uint   Flags;
    ushort ProxyServerOffset;
    ushort ProxyServerLength;
    ushort ClientTlsCredOffset;
    ushort ClientTlsCredLength;
}

struct SecPkgCredentials_Cert
{
    uint   EncodedCertSize;
    ubyte* EncodedCert;
}

struct SecPkgContext_SubjectAttributes
{
    void* AttributeInfo;
}

struct SecPkgContext_CredInfo
{
    SECPKG_CRED_CLASS CredClass;
    uint              IsPromptingNeeded;
}

struct SecPkgContext_NegoPackageInfo
{
    uint PackageMask;
}

struct SecPkgContext_NegoStatus
{
    uint LastStatus;
}

struct SecPkgContext_Sizes
{
    uint cbMaxToken;
    uint cbMaxSignature;
    uint cbBlockSize;
    uint cbSecurityTrailer;
}

struct SecPkgContext_StreamSizes
{
    uint cbHeader;
    uint cbTrailer;
    uint cbMaximumMessage;
    uint cBuffers;
    uint cbBlockSize;
}

struct SecPkgContext_NamesW
{
    ushort* sUserName;
}

struct SecPkgContext_LastClientTokenStatus
{
    SECPKG_ATTR_LCT_STATUS LastClientTokenStatus;
}

struct SecPkgContext_NamesA
{
    byte* sUserName;
}

struct SecPkgContext_Lifespan
{
    LARGE_INTEGER tsStart;
    LARGE_INTEGER tsExpiry;
}

struct SecPkgContext_DceInfo
{
    uint  AuthzSvc;
    void* pPac;
}

struct SecPkgContext_KeyInfoA
{
    byte* sSignatureAlgorithmName;
    byte* sEncryptAlgorithmName;
    uint  KeySize;
    uint  SignatureAlgorithm;
    uint  EncryptAlgorithm;
}

struct SecPkgContext_KeyInfoW
{
    ushort* sSignatureAlgorithmName;
    ushort* sEncryptAlgorithmName;
    uint    KeySize;
    uint    SignatureAlgorithm;
    uint    EncryptAlgorithm;
}

struct SecPkgContext_AuthorityA
{
    byte* sAuthorityName;
}

struct SecPkgContext_AuthorityW
{
    ushort* sAuthorityName;
}

struct SecPkgContext_ProtoInfoA
{
    byte* sProtocolName;
    uint  majorVersion;
    uint  minorVersion;
}

struct SecPkgContext_ProtoInfoW
{
    ushort* sProtocolName;
    uint    majorVersion;
    uint    minorVersion;
}

struct SecPkgContext_PasswordExpiry
{
    LARGE_INTEGER tsPasswordExpires;
}

struct SecPkgContext_LogoffTime
{
    LARGE_INTEGER tsLogoffTime;
}

struct SecPkgContext_SessionKey
{
    uint   SessionKeyLength;
    ubyte* SessionKey;
}

struct SecPkgContext_NegoKeys
{
    uint   KeyType;
    ushort KeyLength;
    ubyte* KeyValue;
    uint   VerifyKeyType;
    ushort VerifyKeyLength;
    ubyte* VerifyKeyValue;
}

struct SecPkgContext_PackageInfoW
{
    SecPkgInfoW* PackageInfo;
}

struct SecPkgContext_PackageInfoA
{
    SecPkgInfoA* PackageInfo;
}

struct SecPkgContext_UserFlags
{
    uint UserFlags;
}

struct SecPkgContext_Flags
{
    uint Flags;
}

struct SecPkgContext_NegotiationInfoA
{
    SecPkgInfoA* PackageInfo;
    uint         NegotiationState;
}

struct SecPkgContext_NegotiationInfoW
{
    SecPkgInfoW* PackageInfo;
    uint         NegotiationState;
}

struct SecPkgContext_NativeNamesW
{
    ushort* sClientName;
    ushort* sServerName;
}

struct SecPkgContext_NativeNamesA
{
    byte* sClientName;
    byte* sServerName;
}

struct SecPkgContext_CredentialNameW
{
    uint    CredentialType;
    ushort* sCredentialName;
}

struct SecPkgContext_CredentialNameA
{
    uint  CredentialType;
    byte* sCredentialName;
}

struct SecPkgContext_AccessToken
{
    void* AccessToken;
}

struct SecPkgContext_TargetInformation
{
    uint   MarshalledTargetInfoLength;
    ubyte* MarshalledTargetInfo;
}

struct SecPkgContext_AuthzID
{
    uint  AuthzIDLength;
    byte* AuthzID;
}

struct SecPkgContext_Target
{
    uint  TargetLength;
    byte* Target;
}

struct SecPkgContext_ClientSpecifiedTarget
{
    ushort* sTargetName;
}

struct SecPkgContext_Bindings
{
    uint BindingsLength;
    SEC_CHANNEL_BINDINGS* Bindings;
}

struct SecPkgContext_ApplicationProtocol
{
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_STATUS ProtoNegoStatus;
    SEC_APPLICATION_PROTOCOL_NEGOTIATION_EXT ProtoNegoExt;
    ubyte      ProtocolIdSize;
    ubyte[255] ProtocolId;
}

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
    ubyte     ReturnToLsa;
}

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

union SEC_WINNT_AUTH_IDENTITY_INFO
{
    SEC_WINNT_AUTH_IDENTITY_EXW AuthIdExw;
    SEC_WINNT_AUTH_IDENTITY_EXA AuthIdExa;
    SEC_WINNT_AUTH_IDENTITY_A AuthId_a;
    SEC_WINNT_AUTH_IDENTITY_W AuthId_w;
    SEC_WINNT_AUTH_IDENTITY_EX2 AuthIdEx2;
}

struct SECURITY_PACKAGE_OPTIONS
{
    uint  Size;
    uint  Type;
    uint  Flags;
    uint  SignatureSize;
    void* Signature;
}

struct CREDENTIAL_ATTRIBUTEA
{
    const(char)* Keyword;
    uint         Flags;
    uint         ValueSize;
    ubyte*       Value;
}

struct CREDENTIAL_ATTRIBUTEW
{
    const(wchar)* Keyword;
    uint          Flags;
    uint          ValueSize;
    ubyte*        Value;
}

struct CREDENTIALA
{
    uint         Flags;
    uint         Type;
    const(char)* TargetName;
    const(char)* Comment;
    FILETIME     LastWritten;
    uint         CredentialBlobSize;
    ubyte*       CredentialBlob;
    uint         Persist;
    uint         AttributeCount;
    CREDENTIAL_ATTRIBUTEA* Attributes;
    const(char)* TargetAlias;
    const(char)* UserName;
}

struct CREDENTIALW
{
    uint          Flags;
    uint          Type;
    const(wchar)* TargetName;
    const(wchar)* Comment;
    FILETIME      LastWritten;
    uint          CredentialBlobSize;
    ubyte*        CredentialBlob;
    uint          Persist;
    uint          AttributeCount;
    CREDENTIAL_ATTRIBUTEW* Attributes;
    const(wchar)* TargetAlias;
    const(wchar)* UserName;
}

struct CREDENTIAL_TARGET_INFORMATIONA
{
    const(char)* TargetName;
    const(char)* NetbiosServerName;
    const(char)* DnsServerName;
    const(char)* NetbiosDomainName;
    const(char)* DnsDomainName;
    const(char)* DnsTreeName;
    const(char)* PackageName;
    uint         Flags;
    uint         CredTypeCount;
    uint*        CredTypes;
}

struct CREDENTIAL_TARGET_INFORMATIONW
{
    const(wchar)* TargetName;
    const(wchar)* NetbiosServerName;
    const(wchar)* DnsServerName;
    const(wchar)* NetbiosDomainName;
    const(wchar)* DnsDomainName;
    const(wchar)* DnsTreeName;
    const(wchar)* PackageName;
    uint          Flags;
    uint          CredTypeCount;
    uint*         CredTypes;
}

struct CERT_CREDENTIAL_INFO
{
    uint      cbSize;
    ubyte[20] rgbHashOfCert;
}

struct USERNAME_TARGET_CREDENTIAL_INFO
{
    const(wchar)* UserName;
}

struct BINARY_BLOB_CREDENTIAL_INFO
{
    uint   cbBlob;
    ubyte* pbBlob;
}

struct CREDUI_INFOA
{
    uint         cbSize;
    HWND         hwndParent;
    const(char)* pszMessageText;
    const(char)* pszCaptionText;
    HBITMAP      hbmBanner;
}

struct CREDUI_INFOW
{
    uint          cbSize;
    HWND          hwndParent;
    const(wchar)* pszMessageText;
    const(wchar)* pszCaptionText;
    HBITMAP       hbmBanner;
}

struct LSA_TOKEN_INFORMATION_NULL
{
    LARGE_INTEGER ExpirationTime;
    TOKEN_GROUPS* Groups;
}

struct LSA_TOKEN_INFORMATION_V1
{
    LARGE_INTEGER       ExpirationTime;
    TOKEN_USER          User;
    TOKEN_GROUPS*       Groups;
    TOKEN_PRIMARY_GROUP PrimaryGroup;
    TOKEN_PRIVILEGES*   Privileges;
    TOKEN_OWNER         Owner;
    TOKEN_DEFAULT_DACL  DefaultDacl;
}

struct LSA_TOKEN_INFORMATION_V3
{
    LARGE_INTEGER       ExpirationTime;
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
    const(char)* Original;
    const(char)* Mapped;
    ubyte        Continuable;
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

struct SECPKG_CLIENT_INFO
{
    LUID   LogonId;
    uint   ProcessID;
    uint   ThreadID;
    ubyte  HasTcbPrivilege;
    ubyte  Impersonating;
    ubyte  Restricted;
    ubyte  ClientFlags;
    SECURITY_IMPERSONATION_LEVEL ImpersonationLevel;
    HANDLE ClientToken;
}

struct SECPKG_CALL_INFO
{
    uint  ProcessId;
    uint  ThreadId;
    uint  Attributes;
    uint  CallCount;
    void* MechOid;
}

struct SECPKG_SUPPLEMENTAL_CRED
{
    UNICODE_STRING PackageName;
    uint           CredentialSize;
    ubyte*         Credentials;
}

struct SECPKG_BYTE_VECTOR
{
    uint   ByteArrayOffset;
    ushort ByteArrayLength;
}

struct SECPKG_SHORT_VECTOR
{
    uint   ShortArrayOffset;
    ushort ShortArrayCount;
}

struct SECPKG_SUPPLIED_CREDENTIAL
{
    ushort              cbHeaderLength;
    ushort              cbStructureLength;
    SECPKG_SHORT_VECTOR UserName;
    SECPKG_SHORT_VECTOR DomainName;
    SECPKG_BYTE_VECTOR  PackedCredentials;
    uint                CredFlags;
}

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

struct SECPKG_SUPPLEMENTAL_CRED_ARRAY
{
    uint CredentialCount;
    SECPKG_SUPPLEMENTAL_CRED[1] Credentials;
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

struct SECPKG_PRIMARY_CRED
{
    LUID           LogonId;
    UNICODE_STRING DownlevelName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
    void*          UserSid;
    uint           Flags;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    UNICODE_STRING LogonServer;
    UNICODE_STRING Spare1;
    UNICODE_STRING Spare2;
    UNICODE_STRING Spare3;
    UNICODE_STRING Spare4;
}

struct SECPKG_PRIMARY_CRED_EX
{
    LUID           LogonId;
    UNICODE_STRING DownlevelName;
    UNICODE_STRING DomainName;
    UNICODE_STRING Password;
    UNICODE_STRING OldPassword;
    void*          UserSid;
    uint           Flags;
    UNICODE_STRING DnsDomainName;
    UNICODE_STRING Upn;
    UNICODE_STRING LogonServer;
    UNICODE_STRING Spare1;
    UNICODE_STRING Spare2;
    UNICODE_STRING Spare3;
    UNICODE_STRING Spare4;
    size_t         PackageId;
    LUID           PrevLogonId;
}

struct SECPKG_PARAMETERS
{
    uint           Version;
    uint           MachineState;
    uint           SetupMode;
    void*          DomainSid;
    UNICODE_STRING DomainName;
    UNICODE_STRING DnsDomainName;
    GUID           DomainGuid;
}

struct SECPKG_GSS_INFO
{
    uint     EncodedIdLength;
    ubyte[4] EncodedId;
}

struct SECPKG_CONTEXT_THUNKS
{
    uint    InfoLevelCount;
    uint[1] Levels;
}

struct SECPKG_MUTUAL_AUTH_LEVEL
{
    uint MutualAuthLevel;
}

struct SECPKG_WOW_CLIENT_DLL
{
    UNICODE_STRING WowClientDllPath;
}

struct SECPKG_SERIALIZED_OID
{
    uint      OidLength;
    uint      OidAttributes;
    ubyte[32] OidValue;
}

struct SECPKG_EXTRA_OIDS
{
    uint OidCount;
    SECPKG_SERIALIZED_OID[1] Oids;
}

struct SECPKG_NEGO2_INFO
{
    ubyte[16] AuthScheme;
    uint      PackageFlags;
}

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

struct SECPKG_TARGETINFO
{
    void*         DomainSid;
    const(wchar)* ComputerName;
}

struct SecPkgContext_SaslContext
{
    void* SaslContext;
}

struct SECURITY_USER_DATA
{
    UNICODE_STRING UserName;
    UNICODE_STRING LogonDomainName;
    UNICODE_STRING LogonServer;
    void*          pSid;
}

struct SECPKG_CALL_PACKAGE_PIN_DC_REQUEST
{
    uint           MessageType;
    uint           Flags;
    UNICODE_STRING DomainName;
    UNICODE_STRING DcName;
    uint           DcFlags;
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
}

struct SECPKG_POST_LOGON_USER_INFO
{
    uint Flags;
    LUID LogonId;
    LUID LinkedLogonId;
}

struct SECPKG_EVENT_PACKAGE_CHANGE
{
    uint           ChangeType;
    size_t         PackageId;
    UNICODE_STRING PackageName;
}

struct SECPKG_EVENT_ROLE_CHANGE
{
    uint PreviousRole;
    uint NewRole;
}

struct SECPKG_EVENT_NOTIFY
{
    uint  EventClass;
    uint  Reserved;
    uint  EventDataSize;
    void* EventData;
    void* PackageParameter;
}

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
    CredReadFn*          CrediRead;
    CredReadDomainCredentialsFn* CrediReadDomainCredentials;
    CredFreeCredentialsFn* CrediFreeCredentials;
    PLSA_PROTECT_MEMORY  LsaProtectMemory;
    PLSA_PROTECT_MEMORY  LsaUnprotectMemory;
    PLSA_OPEN_TOKEN_BY_LOGON_ID OpenTokenByLogonId;
    PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN ExpandAuthDataForDomain;
    PLSA_ALLOCATE_PRIVATE_HEAP AllocatePrivateHeap;
    PLSA_FREE_PRIVATE_HEAP FreePrivateHeap;
    PLSA_CREATE_TOKEN_EX CreateTokenEx;
    CredWriteFn*         CrediWrite;
    CrediUnmarshalandDecodeStringFn* CrediUnmarshalandDecodeString;
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
}

struct SECPKG_DLL_FUNCTIONS
{
    PLSA_ALLOCATE_LSA_HEAP AllocateHeap;
    PLSA_FREE_LSA_HEAP FreeHeap;
    PLSA_REGISTER_CALLBACK RegisterCallback;
    PLSA_LOCATE_PKG_BY_ID LocatePackageById;
}

struct SECPKG_FUNCTION_TABLE
{
    PLSA_AP_INITIALIZE_PACKAGE InitializePackage;
    PLSA_AP_LOGON_USER   LogonUserA;
    PLSA_AP_CALL_PACKAGE CallPackage;
    PLSA_AP_LOGON_TERMINATED LogonTerminated;
    PLSA_AP_CALL_PACKAGE_UNTRUSTED CallPackageUntrusted;
    PLSA_AP_CALL_PACKAGE_PASSTHROUGH CallPackagePassthrough;
    PLSA_AP_LOGON_USER_EX LogonUserExA;
    PLSA_AP_LOGON_USER_EX2 LogonUserEx2;
    SpInitializeFn*      Initialize;
    SpShutdownFn*        Shutdown;
    SpGetInfoFn*         GetInfo;
    SpAcceptCredentialsFn* AcceptCredentials;
    SpAcquireCredentialsHandleFn* AcquireCredentialsHandleA;
    SpQueryCredentialsAttributesFn* QueryCredentialsAttributesA;
    SpFreeCredentialsHandleFn* FreeCredentialsHandle;
    SpSaveCredentialsFn* SaveCredentials;
    SpGetCredentialsFn*  GetCredentials;
    SpDeleteCredentialsFn* DeleteCredentials;
    SpInitLsaModeContextFn* InitLsaModeContext;
    SpAcceptLsaModeContextFn* AcceptLsaModeContext;
    SpDeleteContextFn*   DeleteContext;
    SpApplyControlTokenFn* ApplyControlToken;
    SpGetUserInfoFn*     GetUserInfo;
    SpGetExtendedInformationFn* GetExtendedInformation;
    SpQueryContextAttributesFn* QueryContextAttributesA;
    SpAddCredentialsFn*  AddCredentialsA;
    SpSetExtendedInformationFn* SetExtendedInformation;
    SpSetContextAttributesFn* SetContextAttributesA;
    SpSetCredentialsAttributesFn* SetCredentialsAttributesA;
    SpChangeAccountPasswordFn* ChangeAccountPasswordA;
    SpQueryMetaDataFn*   QueryMetaData;
    SpExchangeMetaDataFn* ExchangeMetaData;
    SpGetCredUIContextFn* GetCredUIContext;
    SpUpdateCredentialsFn* UpdateCredentials;
    SpValidateTargetInfoFn* ValidateTargetInfo;
    LSA_AP_POST_LOGON_USER* PostLogonUser;
    SpGetRemoteCredGuardLogonBufferFn* GetRemoteCredGuardLogonBuffer;
    SpGetRemoteCredGuardSupplementalCredsFn* GetRemoteCredGuardSupplementalCreds;
    SpGetTbalSupplementalCredsFn* GetTbalSupplementalCreds;
    PLSA_AP_LOGON_USER_EX3 LogonUserEx3;
    PLSA_AP_PRE_LOGON_USER_SURROGATE PreLogonUserSurrogate;
    PLSA_AP_POST_LOGON_USER_SURROGATE PostLogonUserSurrogate;
}

struct SECPKG_USER_FUNCTION_TABLE
{
    SpInstanceInitFn*    InstanceInit;
    SpInitUserModeContextFn* InitUserModeContext;
    SpMakeSignatureFn*   MakeSignature;
    SpVerifySignatureFn* VerifySignature;
    SpSealMessageFn*     SealMessage;
    SpUnsealMessageFn*   UnsealMessage;
    SpGetContextTokenFn* GetContextToken;
    SpQueryContextAttributesFn* QueryContextAttributesA;
    SpCompleteAuthTokenFn* CompleteAuthToken;
    SpDeleteContextFn*   DeleteUserModeContext;
    SpFormatCredentialsFn* FormatCredentials;
    SpMarshallSupplementalCredsFn* MarshallSupplementalCreds;
    SpExportSecurityContextFn* ExportContext;
    SpImportSecurityContextFn* ImportContext;
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
    KspInitPackageFn*   Initialize;
    KspDeleteContextFn* DeleteContext;
    KspInitContextFn*   InitContext;
    KspMapHandleFn*     MapHandle;
    KspMakeSignatureFn* Sign;
    KspVerifySignatureFn* Verify;
    KspSealMessageFn*   Seal;
    KspUnsealMessageFn* Unseal;
    KspGetTokenFn*      GetToken;
    KspQueryAttributesFn* QueryAttributes;
    KspCompleteTokenFn* CompleteToken;
    SpExportSecurityContextFn* ExportContext;
    SpImportSecurityContextFn* ImportContext;
    KspSetPagingModeFn* SetPackagePagingMode;
    KspSerializeAuthDataFn* SerializeAuthData;
}

struct SecPkgCred_SupportedAlgs
{
    uint  cSupportedAlgs;
    uint* palgSupportedAlgs;
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
    uint          dwFlags;
    GUID          guidPolicyId;
    uint          dwCertFlags;
    uint          dwUrlRetrievalTimeout;
    BOOL          fCheckRevocationFreshnessTime;
    uint          dwRevocationFreshnessTime;
    BOOL          fOmitUsageCheck;
    const(wchar)* pwszSslCtlStoreName;
    const(wchar)* pwszSslCtlIdentifier;
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

struct SecPkgContext_IssuerListInfoEx
{
    CRYPTOAPI_BLOB* aIssuers;
    uint            cIssuers;
}

struct SecPkgContext_ConnectionInfo
{
    uint dwProtocol;
    uint aiCipher;
    uint dwCipherStrength;
    uint aiHash;
    uint dwHashStrength;
    uint aiExch;
    uint dwExchStrength;
}

struct SecPkgContext_ConnectionInfoEx
{
    uint       dwVersion;
    uint       dwProtocol;
    ushort[64] szCipher;
    uint       dwCipherStrength;
    ushort[64] szHash;
    uint       dwHashStrength;
    ushort[64] szExchange;
    uint       dwExchStrength;
}

struct SecPkgContext_CipherInfo
{
    uint       dwVersion;
    uint       dwProtocol;
    uint       dwCipherSuite;
    uint       dwBaseCipherSuite;
    ushort[64] szCipherSuite;
    ushort[64] szCipher;
    uint       dwCipherLen;
    uint       dwCipherBlockLen;
    ushort[64] szHash;
    uint       dwHashLen;
    ushort[64] szExchange;
    uint       dwMinExchangeLen;
    uint       dwMaxExchangeLen;
    ushort[64] szCertificate;
    uint       dwKeyType;
}

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

struct SecPkgContext_SessionInfo
{
    uint      dwFlags;
    uint      cbSessionId;
    ubyte[32] rgbSessionId;
}

struct SecPkgContext_SessionAppData
{
    uint   dwFlags;
    uint   cbAppData;
    ubyte* pbAppData;
}

struct SecPkgContext_EapPrfInfo
{
    uint   dwVersion;
    uint   cbPrfData;
    ubyte* pbPrfData;
}

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
    uint          dwVersion;
    uint          cbSubjectName;
    const(wchar)* pwszSubjectName;
    uint          cbIssuerName;
    const(wchar)* pwszIssuerName;
    uint          dwKeySize;
}

struct SecPkgContext_UiInfo
{
    HWND hParentWindow;
}

struct SecPkgContext_EarlyStart
{
    uint dwEarlyStartFlags;
}

struct SecPkgContext_KeyingMaterialInfo
{
    ushort       cbLabel;
    const(char)* pszLabel;
    ushort       cbContextValue;
    ubyte*       pbContextValue;
    uint         cbKeyingMaterial;
}

struct SecPkgContext_KeyingMaterial
{
    uint   cbKeyingMaterial;
    ubyte* pbKeyingMaterial;
}

struct SecPkgContext_KeyingMaterial_Inproc
{
    ushort       cbLabel;
    const(char)* pszLabel;
    ushort       cbContextValue;
    ubyte*       pbContextValue;
    uint         cbKeyingMaterial;
    ubyte*       pbKeyingMaterial;
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

struct _HMAPPER
{
}

struct SCHANNEL_CRED
{
    uint           dwVersion;
    uint           cCreds;
    CERT_CONTEXT** paCred;
    void*          hRootStore;
    uint           cMappers;
    _HMAPPER**     aphMappers;
    uint           cSupportedAlgs;
    uint*          palgSupportedAlgs;
    uint           grbitEnabledProtocols;
    uint           dwMinimumCipherStrength;
    uint           dwMaximumCipherStrength;
    uint           dwSessionLifespan;
    uint           dwFlags;
    uint           dwCredFormat;
}

struct SEND_GENERIC_TLS_EXTENSION
{
    ushort   ExtensionType;
    ushort   HandshakeType;
    uint     Flags;
    ushort   BufferSize;
    ubyte[1] Buffer;
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
    TLS_EXTENSION_SUBSCRIPTION[1] Subscriptions;
}

struct SCHANNEL_CERT_HASH
{
    uint      dwLength;
    uint      dwFlags;
    size_t    hProv;
    ubyte[20] ShaHash;
}

struct SCHANNEL_CERT_HASH_STORE
{
    uint        dwLength;
    uint        dwFlags;
    size_t      hProv;
    ubyte[20]   ShaHash;
    ushort[128] pwszStoreName;
}

struct SCHANNEL_ALERT_TOKEN
{
    uint dwTokenType;
    uint dwAlertType;
    uint dwAlertNumber;
}

struct SCHANNEL_SESSION_TOKEN
{
    uint dwTokenType;
    uint dwFlags;
}

struct SCHANNEL_CLIENT_SIGNATURE
{
    uint      cbLength;
    uint      aiHash;
    uint      cbHash;
    ubyte[36] HashValue;
    ubyte[20] CertThumbprint;
}

struct SSL_CREDENTIAL_CERTIFICATE
{
    uint         cbPrivateKey;
    ubyte*       pPrivateKey;
    uint         cbCertificate;
    ubyte*       pCertificate;
    const(char)* pszPassword;
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

struct SCH_CRED_SECRET_PRIVKEY
{
    uint         dwType;
    ubyte*       pPrivateKey;
    uint         cbPrivateKey;
    const(char)* pszPassword;
}

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
    ubyte[1] pKey;
}

struct X509Certificate
{
    uint          Version;
    uint[4]       SerialNumber;
    uint          SignatureAlgorithm;
    FILETIME      ValidFrom;
    FILETIME      ValidUntil;
    const(char)*  pszIssuer;
    const(char)*  pszSubject;
    PctPublicKey* pPublicKey;
}

struct SCH_EXTENSION_DATA
{
    ushort        ExtensionType;
    const(ubyte)* pExtData;
    uint          cbExtData;
}

struct OLD_LARGE_INTEGER
{
    uint LowPart;
    int  HighPart;
}

struct OBJECTS_AND_SID
{
    uint ObjectsPresent;
    GUID ObjectTypeGuid;
    GUID InheritedObjectTypeGuid;
    SID* pSid;
}

struct OBJECTS_AND_NAME_A
{
    uint           ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    const(char)*   ObjectTypeName;
    const(char)*   InheritedObjectTypeName;
    const(char)*   ptstrName;
}

struct OBJECTS_AND_NAME_W
{
    uint           ObjectsPresent;
    SE_OBJECT_TYPE ObjectType;
    const(wchar)*  ObjectTypeName;
    const(wchar)*  InheritedObjectTypeName;
    const(wchar)*  ptstrName;
}

struct TRUSTEE_A
{
    TRUSTEE_A*   pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM TrusteeForm;
    TRUSTEE_TYPE TrusteeType;
    const(char)* ptstrName;
}

struct TRUSTEE_W
{
    TRUSTEE_W*    pMultipleTrustee;
    MULTIPLE_TRUSTEE_OPERATION MultipleTrusteeOperation;
    TRUSTEE_FORM  TrusteeForm;
    TRUSTEE_TYPE  TrusteeType;
    const(wchar)* ptstrName;
}

struct EXPLICIT_ACCESS_A
{
    uint        grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    uint        grfInheritance;
    TRUSTEE_A   Trustee;
}

struct EXPLICIT_ACCESS_W
{
    uint        grfAccessPermissions;
    ACCESS_MODE grfAccessMode;
    uint        grfInheritance;
    TRUSTEE_W   Trustee;
}

struct TRUSTEE_ACCESSA
{
    const(char)* lpProperty;
    uint         Access;
    uint         fAccessFlags;
    uint         fReturnedAccess;
}

struct TRUSTEE_ACCESSW
{
    const(wchar)* lpProperty;
    uint          Access;
    uint          fAccessFlags;
    uint          fReturnedAccess;
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
    uint         fAccessPermission;
    const(char)* lpAccessPermissionName;
}

struct ACTRL_ACCESS_INFOW
{
    uint          fAccessPermission;
    const(wchar)* lpAccessPermissionName;
}

struct ACTRL_CONTROL_INFOA
{
    const(char)* lpControlId;
    const(char)* lpControlName;
}

struct ACTRL_CONTROL_INFOW
{
    const(wchar)* lpControlId;
    const(wchar)* lpControlName;
}

struct _FN_OBJECT_MGR_FUNCTIONS
{
    uint Placeholder;
}

struct INHERITED_FROMA
{
    int          GenerationGap;
    const(char)* AncestorName;
}

struct INHERITED_FROMW
{
    int           GenerationGap;
    const(wchar)* AncestorName;
}

struct WLX_SC_NOTIFICATION_INFO
{
    const(wchar)* pszCard;
    const(wchar)* pszReader;
    const(wchar)* pszContainer;
    const(wchar)* pszCryptoProvider;
}

struct WLX_PROFILE_V1_0
{
    uint          dwType;
    const(wchar)* pszProfile;
}

struct WLX_PROFILE_V2_0
{
    uint          dwType;
    const(wchar)* pszProfile;
    const(wchar)* pszPolicy;
    const(wchar)* pszNetworkDefaultUserProfile;
    const(wchar)* pszServerName;
    const(wchar)* pszEnvironment;
}

struct WLX_MPR_NOTIFY_INFO
{
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    const(wchar)* pszOldPassword;
}

struct WLX_TERMINAL_SERVICES_DATA
{
    ushort[257] ProfilePath;
    ushort[257] HomeDir;
    ushort[4]   HomeDirDrive;
}

struct WLX_CLIENT_CREDENTIALS_INFO_V1_0
{
    uint          dwType;
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    BOOL          fPromptForPassword;
}

struct WLX_CLIENT_CREDENTIALS_INFO_V2_0
{
    uint          dwType;
    const(wchar)* pszUserName;
    const(wchar)* pszDomain;
    const(wchar)* pszPassword;
    BOOL          fPromptForPassword;
    BOOL          fDisconnectOnLogonFailure;
}

struct WLX_CONSOLESWITCH_CREDENTIALS_INFO_V1_0
{
    uint          dwType;
    HANDLE        UserToken;
    LUID          LogonId;
    QUOTA_LIMITS  Quotas;
    const(wchar)* UserName;
    const(wchar)* Domain;
    LARGE_INTEGER LogonTime;
    BOOL          SmartCardLogon;
    uint          ProfileLength;
    uint          MessageType;
    ushort        LogonCount;
    ushort        BadPasswordCount;
    LARGE_INTEGER ProfileLogonTime;
    LARGE_INTEGER LogoffTime;
    LARGE_INTEGER KickOffTime;
    LARGE_INTEGER PasswordLastSet;
    LARGE_INTEGER PasswordCanChange;
    LARGE_INTEGER PasswordMustChange;
    const(wchar)* LogonScript;
    const(wchar)* HomeDirectory;
    const(wchar)* FullName;
    const(wchar)* ProfilePath;
    const(wchar)* HomeDirectoryDrive;
    const(wchar)* LogonServer;
    uint          UserFlags;
    uint          PrivateDataLen;
    ubyte*        PrivateData;
}

struct WLX_DESKTOP
{
    uint          Size;
    uint          Flags;
    HDESK         hDesktop;
    const(wchar)* pszDesktopName;
}

struct WLX_DISPATCH_VERSION_1_0
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
}

struct WLX_DISPATCH_VERSION_1_1
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
}

struct WLX_DISPATCH_VERSION_1_2
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY  WlxSasNotify;
    PWLX_SET_TIMEOUT WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX WlxMessageBox;
    PWLX_DIALOG_BOX  WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
}

struct WLX_DISPATCH_VERSION_1_3
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY    WlxSasNotify;
    PWLX_SET_TIMEOUT   WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX   WlxMessageBox;
    PWLX_DIALOG_BOX    WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION    WlxSetOption;
    PWLX_GET_OPTION    WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT    WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
}

struct WLX_DISPATCH_VERSION_1_4
{
    PWLX_USE_CTRL_ALT_DEL WlxUseCtrlAltDel;
    PWLX_SET_CONTEXT_POINTER WlxSetContextPointer;
    PWLX_SAS_NOTIFY    WlxSasNotify;
    PWLX_SET_TIMEOUT   WlxSetTimeout;
    PWLX_ASSIGN_SHELL_PROTECTION WlxAssignShellProtection;
    PWLX_MESSAGE_BOX   WlxMessageBox;
    PWLX_DIALOG_BOX    WlxDialogBox;
    PWLX_DIALOG_BOX_PARAM WlxDialogBoxParam;
    PWLX_DIALOG_BOX_INDIRECT WlxDialogBoxIndirect;
    PWLX_DIALOG_BOX_INDIRECT_PARAM WlxDialogBoxIndirectParam;
    PWLX_SWITCH_DESKTOP_TO_USER WlxSwitchDesktopToUser;
    PWLX_SWITCH_DESKTOP_TO_WINLOGON WlxSwitchDesktopToWinlogon;
    PWLX_CHANGE_PASSWORD_NOTIFY WlxChangePasswordNotify;
    PWLX_GET_SOURCE_DESKTOP WlxGetSourceDesktop;
    PWLX_SET_RETURN_DESKTOP WlxSetReturnDesktop;
    PWLX_CREATE_USER_DESKTOP WlxCreateUserDesktop;
    PWLX_CHANGE_PASSWORD_NOTIFY_EX WlxChangePasswordNotifyEx;
    PWLX_CLOSE_USER_DESKTOP WlxCloseUserDesktop;
    PWLX_SET_OPTION    WlxSetOption;
    PWLX_GET_OPTION    WlxGetOption;
    PWLX_WIN31_MIGRATE WlxWin31Migrate;
    PWLX_QUERY_CLIENT_CREDENTIALS WlxQueryClientCredentials;
    PWLX_QUERY_IC_CREDENTIALS WlxQueryInetConnectorCredentials;
    PWLX_DISCONNECT    WlxDisconnect;
    PWLX_QUERY_TERMINAL_SERVICES_DATA WlxQueryTerminalServicesData;
    PWLX_QUERY_CONSOLESWITCH_CREDENTIALS WlxQueryConsoleSwitchCredentials;
    PWLX_QUERY_TS_LOGON_CREDENTIALS WlxQueryTsLogonCredentials;
}

struct WLX_NOTIFICATION_INFO
{
    uint            Size;
    uint            Flags;
    const(wchar)*   UserName;
    const(wchar)*   Domain;
    const(wchar)*   WindowStation;
    HANDLE          hToken;
    HDESK           hDesktop;
    PFNMSGECALLBACK pStatusCallback;
}

struct KeyCredentialManagerInfo
{
    GUID containerId;
}

struct NOTIFYINFO
{
    uint  dwNotifyStatus;
    uint  dwOperationStatus;
    void* lpContext;
}

struct NOTIFYADD
{
    HWND         hwndOwner;
    NETRESOURCEA NetResource;
    uint         dwAddFlags;
}

struct NOTIFYCANCEL
{
    const(wchar)* lpName;
    const(wchar)* lpProvider;
    uint          dwFlags;
    BOOL          fForce;
}

struct LOGON_HOURS
{
    ushort UnitsPerWeek;
    ubyte* LogonHours;
}

struct SR_SECURITY_DESCRIPTOR
{
    uint   Length;
    ubyte* SecurityDescriptor;
}

struct USER_ALL_INFORMATION
{
align (4):
    LARGE_INTEGER  LastLogon;
    LARGE_INTEGER  LastLogoff;
    LARGE_INTEGER  PasswordLastSet;
    LARGE_INTEGER  AccountExpires;
    LARGE_INTEGER  PasswordCanChange;
    LARGE_INTEGER  PasswordMustChange;
    UNICODE_STRING UserName;
    UNICODE_STRING FullName;
    UNICODE_STRING HomeDirectory;
    UNICODE_STRING HomeDirectoryDrive;
    UNICODE_STRING ScriptPath;
    UNICODE_STRING ProfilePath;
    UNICODE_STRING AdminComment;
    UNICODE_STRING WorkStations;
    UNICODE_STRING UserComment;
    UNICODE_STRING Parameters;
    UNICODE_STRING LmPassword;
    UNICODE_STRING NtPassword;
    UNICODE_STRING PrivateData;
    SR_SECURITY_DESCRIPTOR SecurityDescriptor;
    uint           UserId;
    uint           PrimaryGroupId;
    uint           UserAccountControl;
    uint           WhichFields;
    LOGON_HOURS    LogonHours;
    ushort         BadPasswordCount;
    ushort         LogonCount;
    ushort         CountryCode;
    ushort         CodePage;
    ubyte          LmPasswordPresent;
    ubyte          NtPasswordPresent;
    ubyte          PasswordExpired;
    ubyte          PrivateDataSensitive;
}

struct CLEAR_BLOCK
{
    byte[8] data;
}

struct USER_SESSION_KEY
{
    CYPHER_BLOCK[2] data;
}

struct NETLOGON_LOGON_IDENTITY_INFO
{
    UNICODE_STRING    LogonDomainName;
    uint              ParameterControl;
    OLD_LARGE_INTEGER LogonId;
    UNICODE_STRING    UserName;
    UNICODE_STRING    Workstation;
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
    STRING      NtChallengeResponse;
    STRING      LmChallengeResponse;
}

struct NETLOGON_GENERIC_INFO
{
    NETLOGON_LOGON_IDENTITY_INFO Identity;
    UNICODE_STRING PackageName;
    uint           DataLength;
    ubyte*         LogonData;
}

struct MSV1_0_VALIDATION_INFO
{
    LARGE_INTEGER    LogoffTime;
    LARGE_INTEGER    KickoffTime;
    UNICODE_STRING   LogonServer;
    UNICODE_STRING   LogonDomainName;
    USER_SESSION_KEY SessionKey;
    ubyte            Authoritative;
    uint             UserFlags;
    uint             WhichFields;
    uint             UserId;
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
        const(wchar)*       String;
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

struct AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__
{
    int unused;
}

struct AUTHZ_CLIENT_CONTEXT_HANDLE__
{
    int unused;
}

struct AUTHZ_RESOURCE_MANAGER_HANDLE__
{
    int unused;
}

struct AUTHZ_AUDIT_EVENT_HANDLE__
{
    int unused;
}

struct AUTHZ_AUDIT_EVENT_TYPE_HANDLE__
{
    int unused;
}

struct AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__
{
    int unused;
}

struct AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__
{
    int unused;
}

struct AUTHZ_ACCESS_REQUEST
{
    uint              DesiredAccess;
    void*             PrincipalSelfSid;
    OBJECT_TYPE_LIST* ObjectTypeList;
    uint              ObjectTypeListLength;
    void*             OptionalArguments;
}

struct AUTHZ_ACCESS_REPLY
{
    uint  ResultListLength;
    uint* GrantedAccessMask;
    uint* SaclEvaluationResults;
    uint* Error;
}

struct AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE
{
    ulong         Version;
    const(wchar)* pName;
}

struct AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE
{
    void* pValue;
    uint  ValueLength;
}

struct AUTHZ_SECURITY_ATTRIBUTE_V1
{
    const(wchar)* pName;
    ushort        ValueType;
    ushort        Reserved;
    uint          Flags;
    uint          ValueCount;
    union Values
    {
        long*    pInt64;
        ulong*   pUint64;
        ushort** ppString;
        AUTHZ_SECURITY_ATTRIBUTE_FQBN_VALUE* pFqbn;
        AUTHZ_SECURITY_ATTRIBUTE_OCTET_STRING_VALUE* pOctetString;
    }
}

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

struct AUTHZ_RPC_INIT_INFO_CLIENT
{
    ushort        version_;
    const(wchar)* ObjectUuid;
    const(wchar)* ProtSeq;
    const(wchar)* NetworkAddr;
    const(wchar)* Endpoint;
    const(wchar)* Options;
    const(wchar)* ServerSpn;
}

struct AUTHZ_INIT_INFO
{
    ushort        version_;
    const(wchar)* szResourceManagerName;
    PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck;
    PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups;
    PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups;
    PFN_AUTHZ_GET_CENTRAL_ACCESS_POLICY pfnGetCentralAccessPolicy;
    PFN_AUTHZ_FREE_CENTRAL_ACCESS_POLICY pfnFreeCentralAccessPolicy;
}

struct AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET
{
    const(wchar)* szObjectTypeName;
    uint          dwOffset;
}

struct AUTHZ_SOURCE_SCHEMA_REGISTRATION
{
    uint          dwFlags;
    const(wchar)* szEventSourceName;
    const(wchar)* szEventMessageFile;
    const(wchar)* szEventSourceXmlSchemaFile;
    const(wchar)* szEventAccessStringsFile;
    const(wchar)* szExecutableImagePath;
    union
    {
        void* pReserved;
        GUID* pProviderGuid;
    }
    uint          dwObjectTypeNameCount;
    AUTHZ_REGISTRATION_OBJECT_TYPE_NAME_OFFSET[1] ObjectTypeNames;
}

struct SI_OBJECT_INFO
{
    uint          dwFlags;
    HINSTANCE     hInstance;
    const(wchar)* pszServerName;
    const(wchar)* pszObjectName;
    const(wchar)* pszPageTitle;
    GUID          guidObjectType;
}

struct SI_ACCESS
{
    const(GUID)*  pguid;
    uint          mask;
    const(wchar)* pszName;
    uint          dwFlags;
}

struct SI_INHERIT_TYPE
{
    const(GUID)*  pguid;
    uint          dwFlags;
    const(wchar)* pszName;
}

struct SID_INFO
{
    void*         pSid;
    const(wchar)* pwzCommonName;
    const(wchar)* pwzClass;
    const(wchar)* pwzUPN;
}

struct SID_INFO_LIST
{
    uint        cItems;
    SID_INFO[1] aSidInfo;
}

struct SECURITY_OBJECT
{
    const(wchar)* pwszName;
    void*         pData;
    uint          cbData;
    void*         pData2;
    uint          cbData2;
    uint          Id;
    ubyte         fWellKnown;
}

struct EFFPERM_RESULT_LIST
{
    ubyte             fEvaluated;
    uint              cObjectTypeListLength;
    OBJECT_TYPE_LIST* pObjectTypeList;
    uint*             pGrantedAccessList;
}

struct CERTTRANSBLOB
{
    uint   cb;
    ubyte* pb;
}

struct CERTVIEWRESTRICTION
{
    uint   ColumnIndex;
    int    SeekOperator;
    int    SortOrder;
    ubyte* pbValue;
    uint   cbValue;
}

struct CSEDB_RSTMAPW
{
    ushort* pwszDatabaseName;
    ushort* pwszNewDatabaseName;
}

struct NCRYPT_DESCRIPTOR_HANDLE__
{
    int unused;
}

struct NCRYPT_STREAM_HANDLE__
{
    int unused;
}

struct NCRYPT_PROTECT_STREAM_INFO
{
    PFNCryptStreamOutputCallback pfnStreamOutput;
    void* pvCallbackCtxt;
}

struct NCRYPT_PROTECT_STREAM_INFO_EX
{
    PFNCryptStreamOutputCallbackEx pfnStreamOutput;
    void* pvCallbackCtxt;
}

struct TOKENBINDING_IDENTIFIER
{
    ubyte keyType;
}

struct TOKENBINDING_RESULT_DATA
{
    TOKENBINDING_TYPE bindingType;
    uint              identifierSize;
    TOKENBINDING_IDENTIFIER* identifierData;
    TOKENBINDING_EXTENSION_FORMAT extensionFormat;
    uint              extensionSize;
    void*             extensionData;
}

struct TOKENBINDING_RESULT_LIST
{
    uint resultCount;
    TOKENBINDING_RESULT_DATA* resultData;
}

struct TOKENBINDING_KEY_TYPES
{
    uint keyCount;
    TOKENBINDING_KEY_PARAMETERS_TYPE* keyType;
}

struct CRYPT_XML_BLOB
{
    CRYPT_XML_CHARSET dwCharset;
    uint              cbData;
    ubyte*            pbData;
}

struct CRYPT_XML_DATA_BLOB
{
    uint   cbData;
    ubyte* pbData;
}

struct CRYPT_XML_PROPERTY
{
    CRYPT_XML_PROPERTY_ID dwPropId;
    const(void)* pvValue;
    uint         cbValue;
}

struct CRYPT_XML_DATA_PROVIDER
{
    void* pvCallbackState;
    uint  cbBufferSize;
    PFN_CRYPT_XML_DATA_PROVIDER_READ pfnRead;
    PFN_CRYPT_XML_DATA_PROVIDER_CLOSE pfnClose;
}

struct CRYPT_XML_STATUS
{
    uint cbSize;
    uint dwErrorStatus;
    uint dwInfoStatus;
}

struct CRYPT_XML_ALGORITHM
{
    uint           cbSize;
    const(wchar)*  wszAlgorithm;
    CRYPT_XML_BLOB Encoded;
}

struct CRYPT_XML_TRANSFORM_INFO
{
    uint          cbSize;
    const(wchar)* wszAlgorithm;
    uint          cbBufferSize;
    uint          dwFlags;
    PFN_CRYPT_XML_CREATE_TRANSFORM pfnCreateTransform;
}

struct CRYPT_XML_TRANSFORM_CHAIN_CONFIG
{
    uint cbSize;
    uint cTransformInfo;
    CRYPT_XML_TRANSFORM_INFO** rgpTransformInfo;
}

struct CRYPT_XML_KEY_DSA_KEY_VALUE
{
    CRYPT_XML_DATA_BLOB P;
    CRYPT_XML_DATA_BLOB Q;
    CRYPT_XML_DATA_BLOB G;
    CRYPT_XML_DATA_BLOB Y;
    CRYPT_XML_DATA_BLOB J;
    CRYPT_XML_DATA_BLOB Seed;
    CRYPT_XML_DATA_BLOB Counter;
}

struct CRYPT_XML_KEY_ECDSA_KEY_VALUE
{
    const(wchar)*       wszNamedCurve;
    CRYPT_XML_DATA_BLOB X;
    CRYPT_XML_DATA_BLOB Y;
    CRYPT_XML_BLOB      ExplicitPara;
}

struct CRYPT_XML_KEY_RSA_KEY_VALUE
{
    CRYPT_XML_DATA_BLOB Modulus;
    CRYPT_XML_DATA_BLOB Exponent;
}

struct CRYPT_XML_KEY_VALUE
{
    uint dwType;
    union
    {
        CRYPT_XML_KEY_DSA_KEY_VALUE DSAKeyValue;
        CRYPT_XML_KEY_RSA_KEY_VALUE RSAKeyValue;
        CRYPT_XML_KEY_ECDSA_KEY_VALUE ECDSAKeyValue;
        CRYPT_XML_BLOB Custom;
    }
}

struct CRYPT_XML_ISSUER_SERIAL
{
    const(wchar)* wszIssuer;
    const(wchar)* wszSerial;
}

struct CRYPT_XML_X509DATA_ITEM
{
    uint dwType;
    union
    {
        CRYPT_XML_ISSUER_SERIAL IssuerSerial;
        CRYPT_XML_DATA_BLOB SKI;
        const(wchar)*       wszSubjectName;
        CRYPT_XML_DATA_BLOB Certificate;
        CRYPT_XML_DATA_BLOB CRL;
        CRYPT_XML_BLOB      Custom;
    }
}

struct CRYPT_XML_X509DATA
{
    uint cX509Data;
    CRYPT_XML_X509DATA_ITEM* rgX509Data;
}

struct CRYPT_XML_KEY_INFO_ITEM
{
    uint dwType;
    union
    {
        const(wchar)*       wszKeyName;
        CRYPT_XML_KEY_VALUE KeyValue;
        CRYPT_XML_BLOB      RetrievalMethod;
        CRYPT_XML_X509DATA  X509Data;
        CRYPT_XML_BLOB      Custom;
    }
}

struct CRYPT_XML_KEY_INFO
{
    uint          cbSize;
    const(wchar)* wszId;
    uint          cKeyInfo;
    CRYPT_XML_KEY_INFO_ITEM* rgKeyInfo;
    void*         hVerifyKey;
}

struct CRYPT_XML_REFERENCE
{
    uint                 cbSize;
    void*                hReference;
    const(wchar)*        wszId;
    const(wchar)*        wszUri;
    const(wchar)*        wszType;
    CRYPT_XML_ALGORITHM  DigestMethod;
    CRYPTOAPI_BLOB       DigestValue;
    uint                 cTransform;
    CRYPT_XML_ALGORITHM* rgTransform;
}

struct CRYPT_XML_REFERENCES
{
    uint cReference;
    CRYPT_XML_REFERENCE** rgpReference;
}

struct CRYPT_XML_SIGNED_INFO
{
    uint                cbSize;
    const(wchar)*       wszId;
    CRYPT_XML_ALGORITHM Canonicalization;
    CRYPT_XML_ALGORITHM SignatureMethod;
    uint                cReference;
    CRYPT_XML_REFERENCE** rgpReference;
    CRYPT_XML_BLOB      Encoded;
}

struct CRYPT_XML_OBJECT
{
    uint                 cbSize;
    void*                hObject;
    const(wchar)*        wszId;
    const(wchar)*        wszMimeType;
    const(wchar)*        wszEncoding;
    CRYPT_XML_REFERENCES Manifest;
    CRYPT_XML_BLOB       Encoded;
}

struct CRYPT_XML_SIGNATURE
{
    uint                cbSize;
    void*               hSignature;
    const(wchar)*       wszId;
    CRYPT_XML_SIGNED_INFO SignedInfo;
    CRYPTOAPI_BLOB      SignatureValue;
    CRYPT_XML_KEY_INFO* pKeyInfo;
    uint                cObject;
    CRYPT_XML_OBJECT**  rgpObject;
}

struct CRYPT_XML_DOC_CTXT
{
    uint  cbSize;
    void* hDocCtxt;
    CRYPT_XML_TRANSFORM_CHAIN_CONFIG* pTransformsConfig;
    uint  cSignature;
    CRYPT_XML_SIGNATURE** rgpSignature;
}

struct CRYPT_XML_KEYINFO_PARAM
{
    const(wchar)*   wszId;
    const(wchar)*   wszKeyName;
    CRYPTOAPI_BLOB  SKI;
    const(wchar)*   wszSubjectName;
    uint            cCertificate;
    CRYPTOAPI_BLOB* rgCertificate;
    uint            cCRL;
    CRYPTOAPI_BLOB* rgCRL;
}

struct CRYPT_XML_ALGORITHM_INFO
{
    uint    cbSize;
    ushort* wszAlgorithmURI;
    ushort* wszName;
    uint    dwGroupId;
    ushort* wszCNGAlgid;
    ushort* wszCNGExtraAlgid;
    uint    dwSignFlags;
    uint    dwVerifyFlags;
    void*   pvPaddingInfo;
    void*   pvExtraInfo;
}

struct CRYPT_XML_CRYPTOGRAPHIC_INTERFACE
{
    uint                cbSize;
    CryptXmlDllEncodeAlgorithm fpCryptXmlEncodeAlgorithm;
    CryptXmlDllCreateDigest fpCryptXmlCreateDigest;
    CryptXmlDllDigestData fpCryptXmlDigestData;
    CryptXmlDllFinalizeDigest fpCryptXmlFinalizeDigest;
    CryptXmlDllCloseDigest fpCryptXmlCloseDigest;
    CryptXmlDllSignData fpCryptXmlSignData;
    CryptXmlDllVerifySignature fpCryptXmlVerifySignature;
    CryptXmlDllGetAlgorithmInfo fpCryptXmlGetAlgorithmInfo;
}

struct CAINFO
{
    uint         cbSize;
    ENUM_CATYPES CAType;
    uint         cCASignatureCerts;
    uint         cCAExchangeCerts;
    uint         cExitModules;
    int          lPropIdMax;
    int          lRoleSeparationEnabled;
    uint         cKRACertUsedCount;
    uint         cKRACertCount;
    uint         fAdvancedServer;
}

struct LLFILETIME
{
    union
    {
        long     ll;
        FILETIME ft;
    }
}

struct CERT_SELECT_STRUCT_A
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    const(char)*    pTemplateName;
    uint            dwFlags;
    const(char)*    szTitle;
    uint            cCertStore;
    void**          arrayCertStore;
    const(char)*    szPurposeOid;
    uint            cCertContext;
    CERT_CONTEXT**  arrayCertContext;
    LPARAM          lCustData;
    PFNCMHOOKPROC   pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(char)*    szHelpFileName;
    uint            dwHelpId;
    size_t          hprov;
}

struct CERT_SELECT_STRUCT_W
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    const(wchar)*   pTemplateName;
    uint            dwFlags;
    const(wchar)*   szTitle;
    uint            cCertStore;
    void**          arrayCertStore;
    const(char)*    szPurposeOid;
    uint            cCertContext;
    CERT_CONTEXT**  arrayCertContext;
    LPARAM          lCustData;
    PFNCMHOOKPROC   pfnHook;
    PFNCMFILTERPROC pfnFilter;
    const(wchar)*   szHelpFileName;
    uint            dwHelpId;
    size_t          hprov;
}

struct CERT_VIEWPROPERTIES_STRUCT_A
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    uint            dwFlags;
    const(char)*    szTitle;
    CERT_CONTEXT*   pCertContext;
    byte**          arrayPurposes;
    uint            cArrayPurposes;
    uint            cRootStores;
    void**          rghstoreRoots;
    uint            cStores;
    void**          rghstoreCAs;
    uint            cTrustStores;
    void**          rghstoreTrust;
    size_t          hprov;
    LPARAM          lCustData;
    uint            dwPad;
    const(char)*    szHelpFileName;
    uint            dwHelpId;
    uint            nStartPage;
    uint            cArrayPropSheetPages;
    PROPSHEETPAGEA* arrayPropSheetPages;
}

struct CERT_VIEWPROPERTIES_STRUCT_W
{
    uint            dwSize;
    HWND            hwndParent;
    HINSTANCE       hInstance;
    uint            dwFlags;
    const(wchar)*   szTitle;
    CERT_CONTEXT*   pCertContext;
    byte**          arrayPurposes;
    uint            cArrayPurposes;
    uint            cRootStores;
    void**          rghstoreRoots;
    uint            cStores;
    void**          rghstoreCAs;
    uint            cTrustStores;
    void**          rghstoreTrust;
    size_t          hprov;
    LPARAM          lCustData;
    uint            dwPad;
    const(wchar)*   szHelpFileName;
    uint            dwHelpId;
    uint            nStartPage;
    uint            cArrayPropSheetPages;
    PROPSHEETPAGEA* arrayPropSheetPages;
}

struct tagCMOID
{
    const(char)* szExtensionOID;
    uint         dwTestOperation;
    ubyte*       pbTestData;
    uint         cbTestData;
}

struct tagCMFLTR
{
    uint      dwSize;
    uint      cExtensionChecks;
    tagCMOID* arrayExtensionChecks;
    uint      dwCheckingFlags;
}

struct CERT_VERIFY_CERTIFICATE_TRUST
{
    uint             cbSize;
    CERT_CONTEXT*    pccert;
    uint             dwFlags;
    uint             dwIgnoreErr;
    uint*            pdwErrors;
    const(char)*     pszUsageOid;
    size_t           hprov;
    uint             cRootStores;
    void**           rghstoreRoots;
    uint             cStores;
    void**           rghstoreCAs;
    uint             cTrustStores;
    void**           rghstoreTrust;
    LPARAM           lCustData;
    PFNTRUSTHELPER   pfnTrustHelper;
    uint*            pcChain;
    CERT_CONTEXT***  prgChain;
    uint**           prgdwErrors;
    CRYPTOAPI_BLOB** prgpbTrustInfo;
}

struct CTL_MODIFY_REQUEST
{
    CERT_CONTEXT* pccert;
    uint          dwOperation;
    uint          dwError;
}

struct WINTRUST_DATA
{
    uint    cbStruct;
    void*   pPolicyCallbackData;
    void*   pSIPClientData;
    uint    dwUIChoice;
    uint    fdwRevocationChecks;
    uint    dwUnionChoice;
    union
    {
        WINTRUST_FILE_INFO* pFile;
        WINTRUST_CATALOG_INFO* pCatalog;
        WINTRUST_BLOB_INFO* pBlob;
        WINTRUST_SGNR_INFO* pSgnr;
        WINTRUST_CERT_INFO* pCert;
    }
    uint    dwStateAction;
    HANDLE  hWVTStateData;
    ushort* pwszURLReference;
    uint    dwProvFlags;
    uint    dwUIContext;
    WINTRUST_SIGNATURE_SETTINGS* pSignatureSettings;
}

struct WINTRUST_SIGNATURE_SETTINGS
{
    uint cbStruct;
    uint dwIndex;
    uint dwFlags;
    uint cSecondarySigs;
    uint dwVerifiedSigIndex;
    CERT_STRONG_SIGN_PARA* pCryptoPolicy;
}

struct WINTRUST_FILE_INFO
{
    uint          cbStruct;
    const(wchar)* pcwszFilePath;
    HANDLE        hFile;
    GUID*         pgKnownSubject;
}

struct WINTRUST_CATALOG_INFO
{
    uint          cbStruct;
    uint          dwCatalogVersion;
    const(wchar)* pcwszCatalogFilePath;
    const(wchar)* pcwszMemberTag;
    const(wchar)* pcwszMemberFilePath;
    HANDLE        hMemberFile;
    ubyte*        pbCalculatedFileHash;
    uint          cbCalculatedFileHash;
    CTL_CONTEXT*  pcCatalogContext;
    ptrdiff_t     hCatAdmin;
}

struct WINTRUST_BLOB_INFO
{
    uint          cbStruct;
    GUID          gSubject;
    const(wchar)* pcwszDisplayName;
    uint          cbMemObject;
    ubyte*        pbMemObject;
    uint          cbMemSignedMsg;
    ubyte*        pbMemSignedMsg;
}

struct WINTRUST_SGNR_INFO
{
    uint              cbStruct;
    const(wchar)*     pcwszDisplayName;
    CMSG_SIGNER_INFO* psSignerInfo;
    uint              chStores;
    void**            pahStores;
}

struct WINTRUST_CERT_INFO
{
    uint          cbStruct;
    const(wchar)* pcwszDisplayName;
    CERT_CONTEXT* psCertContext;
    uint          chStores;
    void**        pahStores;
    uint          dwFlags;
    FILETIME*     psftVerifyAsOf;
}

struct CRYPT_PROVIDER_DATA
{
    uint                 cbStruct;
    WINTRUST_DATA*       pWintrustData;
    BOOL                 fOpenedFile;
    HWND                 hWndParent;
    GUID*                pgActionID;
    size_t               hProv;
    uint                 dwError;
    uint                 dwRegSecuritySettings;
    uint                 dwRegPolicySettings;
    CRYPT_PROVIDER_FUNCTIONS* psPfns;
    uint                 cdwTrustStepErrors;
    uint*                padwTrustStepErrors;
    uint                 chStores;
    void**               pahStores;
    uint                 dwEncoding;
    void*                hMsg;
    uint                 csSigners;
    CRYPT_PROVIDER_SGNR* pasSigners;
    uint                 csProvPrivData;
    CRYPT_PROVIDER_PRIVDATA* pasProvPrivData;
    uint                 dwSubjectChoice;
    union
    {
        PROVDATA_SIP* pPDSip;
    }
    byte*                pszUsageOID;
    BOOL                 fRecallWithState;
    FILETIME             sftSystemTime;
    byte*                pszCTLSignerUsageOID;
    uint                 dwProvFlags;
    uint                 dwFinalError;
    CERT_USAGE_MATCH*    pRequestUsage;
    uint                 dwTrustPubSettings;
    uint                 dwUIStateFlags;
    CRYPT_PROVIDER_SIGSTATE* pSigState;
    WINTRUST_SIGNATURE_SETTINGS* pSigSettings;
}

struct CRYPT_PROVIDER_SIGSTATE
{
    uint   cbStruct;
    void** rhSecondarySigs;
    void*  hPrimarySig;
    BOOL   fFirstAttemptMade;
    BOOL   fNoMoreSigs;
    uint   cSecondarySigs;
    uint   dwCurrentIndex;
    BOOL   fSupportMultiSig;
    uint   dwCryptoPolicySupport;
    uint   iAttemptCount;
    BOOL   fCheckedSealing;
    SEALING_SIGNATURE_ATTRIBUTE* pSealingSignature;
}

struct CRYPT_PROVIDER_FUNCTIONS
{
    uint                 cbStruct;
    PFN_CPD_MEM_ALLOC    pfnAlloc;
    PFN_CPD_MEM_FREE     pfnFree;
    PFN_CPD_ADD_STORE    pfnAddStore2Chain;
    PFN_CPD_ADD_SGNR     pfnAddSgnr2Chain;
    PFN_CPD_ADD_CERT     pfnAddCert2Chain;
    PFN_CPD_ADD_PRIVDATA pfnAddPrivData2Chain;
    PFN_PROVIDER_INIT_CALL pfnInitialize;
    PFN_PROVIDER_OBJTRUST_CALL pfnObjectTrust;
    PFN_PROVIDER_SIGTRUST_CALL pfnSignatureTrust;
    PFN_PROVIDER_CERTTRUST_CALL pfnCertificateTrust;
    PFN_PROVIDER_FINALPOLICY_CALL pfnFinalPolicy;
    PFN_PROVIDER_CERTCHKPOLICY_CALL pfnCertCheckPolicy;
    PFN_PROVIDER_TESTFINALPOLICY_CALL pfnTestFinalPolicy;
    CRYPT_PROVUI_FUNCS*  psUIpfns;
    PFN_PROVIDER_CLEANUP_CALL pfnCleanupPolicy;
}

struct CRYPT_PROVUI_FUNCS
{
    uint               cbStruct;
    CRYPT_PROVUI_DATA* psUIData;
    PFN_PROVUI_CALL    pfnOnMoreInfoClick;
    PFN_PROVUI_CALL    pfnOnMoreInfoClickDefault;
    PFN_PROVUI_CALL    pfnOnAdvancedClick;
    PFN_PROVUI_CALL    pfnOnAdvancedClickDefault;
}

struct CRYPT_PROVUI_DATA
{
    uint    cbStruct;
    uint    dwFinalError;
    ushort* pYesButtonText;
    ushort* pNoButtonText;
    ushort* pMoreInfoButtonText;
    ushort* pAdvancedLinkText;
    ushort* pCopyActionText;
    ushort* pCopyActionTextNoTS;
    ushort* pCopyActionTextNotSigned;
}

struct CRYPT_PROVIDER_SGNR
{
    uint                 cbStruct;
    FILETIME             sftVerifyAsOf;
    uint                 csCertChain;
    CRYPT_PROVIDER_CERT* pasCertChain;
    uint                 dwSignerType;
    CMSG_SIGNER_INFO*    psSigner;
    uint                 dwError;
    uint                 csCounterSigners;
    CRYPT_PROVIDER_SGNR* pasCounterSigners;
    CERT_CHAIN_CONTEXT*  pChainContext;
}

struct CRYPT_PROVIDER_CERT
{
    uint                cbStruct;
    CERT_CONTEXT*       pCert;
    BOOL                fCommercial;
    BOOL                fTrustedRoot;
    BOOL                fSelfSigned;
    BOOL                fTestCert;
    uint                dwRevokedReason;
    uint                dwConfidence;
    uint                dwError;
    CTL_CONTEXT*        pTrustListContext;
    BOOL                fTrustListSignerCert;
    CTL_CONTEXT*        pCtlContext;
    uint                dwCtlError;
    BOOL                fIsCyclic;
    CERT_CHAIN_ELEMENT* pChainElement;
}

struct CRYPT_PROVIDER_PRIVDATA
{
    uint  cbStruct;
    GUID  gProviderID;
    uint  cbProvData;
    void* pvProvData;
}

struct PROVDATA_SIP
{
    uint               cbStruct;
    GUID               gSubject;
    SIP_DISPATCH_INFO* pSip;
    SIP_DISPATCH_INFO* pCATSip;
    SIP_SUBJECTINFO*   psSipSubjectInfo;
    SIP_SUBJECTINFO*   psSipCATSubjectInfo;
    SIP_INDIRECT_DATA* psIndirectData;
}

struct CRYPT_TRUST_REG_ENTRY
{
    uint    cbStruct;
    ushort* pwszDLLName;
    ushort* pwszFunctionName;
}

struct CRYPT_REGISTER_ACTIONID
{
    uint cbStruct;
    CRYPT_TRUST_REG_ENTRY sInitProvider;
    CRYPT_TRUST_REG_ENTRY sObjectProvider;
    CRYPT_TRUST_REG_ENTRY sSignatureProvider;
    CRYPT_TRUST_REG_ENTRY sCertificateProvider;
    CRYPT_TRUST_REG_ENTRY sCertificatePolicyProvider;
    CRYPT_TRUST_REG_ENTRY sFinalPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sTestPolicyProvider;
    CRYPT_TRUST_REG_ENTRY sCleanupProvider;
}

struct CRYPT_PROVIDER_REGDEFUSAGE
{
    uint    cbStruct;
    GUID*   pgActionID;
    ushort* pwszDllName;
    byte*   pwszLoadCallbackDataFunctionName;
    byte*   pwszFreeCallbackDataFunctionName;
}

struct CRYPT_PROVIDER_DEFUSAGE
{
    uint  cbStruct;
    GUID  gActionID;
    void* pDefPolicyCallbackData;
    void* pDefSIPClientData;
}

struct SPC_SERIALIZED_OBJECT
{
    ubyte[16]      ClassId;
    CRYPTOAPI_BLOB SerializedData;
}

struct SPC_SIGINFO
{
    uint dwSipVersion;
    GUID gSIPGuid;
    uint dwReserved1;
    uint dwReserved2;
    uint dwReserved3;
    uint dwReserved4;
    uint dwReserved5;
}

struct SPC_LINK
{
    uint dwLinkChoice;
    union
    {
        const(wchar)* pwszUrl;
        SPC_SERIALIZED_OBJECT Moniker;
        const(wchar)* pwszFile;
    }
}

struct SPC_PE_IMAGE_DATA
{
    CRYPT_BIT_BLOB Flags;
    SPC_LINK*      pFile;
}

struct SPC_INDIRECT_DATA_CONTENT
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPTOAPI_BLOB Digest;
}

struct SPC_FINANCIAL_CRITERIA
{
    BOOL fFinancialInfoAvailable;
    BOOL fMeetsCriteria;
}

struct SPC_IMAGE
{
    SPC_LINK*      pImageLink;
    CRYPTOAPI_BLOB Bitmap;
    CRYPTOAPI_BLOB Metafile;
    CRYPTOAPI_BLOB EnhancedMetafile;
    CRYPTOAPI_BLOB GifFile;
}

struct SPC_SP_AGENCY_INFO
{
    SPC_LINK*     pPolicyInformation;
    const(wchar)* pwszPolicyDisplayText;
    SPC_IMAGE*    pLogoImage;
    SPC_LINK*     pLogoLink;
}

struct SPC_STATEMENT_TYPE
{
    uint   cKeyPurposeId;
    byte** rgpszKeyPurposeId;
}

struct SPC_SP_OPUS_INFO
{
    const(wchar)* pwszProgramName;
    SPC_LINK*     pMoreInfo;
    SPC_LINK*     pPublisherInfo;
}

struct CAT_NAMEVALUE
{
    const(wchar)*  pwszTag;
    uint           fdwFlags;
    CRYPTOAPI_BLOB Value;
}

struct CAT_MEMBERINFO
{
    const(wchar)* pwszSubjGuid;
    uint          dwCertVersion;
}

struct CAT_MEMBERINFO2
{
    GUID SubjectGuid;
    uint dwCertVersion;
}

struct INTENT_TO_SEAL_ATTRIBUTE
{
    uint  version_;
    ubyte seal;
}

struct SEALING_SIGNATURE_ATTRIBUTE
{
    uint           version_;
    uint           signerIndex;
    CRYPT_ALGORITHM_IDENTIFIER signatureAlgorithm;
    CRYPTOAPI_BLOB encryptedDigest;
}

struct SEALING_TIMESTAMP_ATTRIBUTE
{
    uint           version_;
    uint           signerIndex;
    CRYPTOAPI_BLOB sealTimeStampToken;
}

struct WIN_CERTIFICATE
{
    uint     dwLength;
    ushort   wRevision;
    ushort   wCertificateType;
    ubyte[1] bCertificate;
}

struct WIN_TRUST_ACTDATA_CONTEXT_WITH_SUBJECT
{
    HANDLE hClientToken;
    GUID*  SubjectType;
    void*  Subject;
}

struct WIN_TRUST_ACTDATA_SUBJECT_ONLY
{
    GUID* SubjectType;
    void* Subject;
}

struct WIN_TRUST_SUBJECT_FILE
{
    HANDLE        hFile;
    const(wchar)* lpPath;
}

struct WIN_TRUST_SUBJECT_FILE_AND_DISPLAY
{
    HANDLE        hFile;
    const(wchar)* lpPath;
    const(wchar)* lpDisplayName;
}

struct WIN_SPUB_TRUSTED_PUBLISHER_DATA
{
    HANDLE           hClientToken;
    WIN_CERTIFICATE* lpCertificate;
}

struct CERT_SELECTUI_INPUT
{
    void*                hStore;
    CERT_CHAIN_CONTEXT** prgpChain;
    uint                 cChain;
}

struct CRYPTUI_CERT_MGR_STRUCT
{
    uint          dwSize;
    HWND          hwndParent;
    uint          dwFlags;
    const(wchar)* pwszTitle;
    const(char)*  pszInitUsageOID;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO
{
    uint          dwSize;
    GUID*         pGuidSubject;
    uint          cbBlob;
    ubyte*        pbBlob;
    const(wchar)* pwszDisplayName;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO
{
    uint           dwSize;
    uint           cCertStore;
    void**         rghCertStore;
    PFNCFILTERPROC pFilterCallback;
    void*          pvCallbackData;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO
{
    uint          dwSize;
    const(wchar)* pwszPvkFileName;
    const(wchar)* pwszProvName;
    uint          dwProvType;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO
{
    uint          dwSize;
    const(wchar)* pwszSigningCertFileName;
    uint          dwPvkChoice;
    union
    {
        CRYPTUI_WIZ_DIGITAL_SIGN_PVK_FILE_INFO* pPvkFileInfo;
        CRYPT_KEY_PROV_INFO* pPvkProvInfo;
    }
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO
{
    uint              dwSize;
    uint              dwAttrFlags;
    const(wchar)*     pwszDescription;
    const(wchar)*     pwszMoreInfoLocation;
    const(char)*      pszHashAlg;
    const(wchar)*     pwszSigningCertDisplayString;
    void*             hAdditionalCertStore;
    CRYPT_ATTRIBUTES* psAuthenticated;
    CRYPT_ATTRIBUTES* psUnauthenticated;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_INFO
{
    uint          dwSize;
    uint          dwSubjectChoice;
    union
    {
        const(wchar)* pwszFileName;
        CRYPTUI_WIZ_DIGITAL_SIGN_BLOB_INFO* pSignBlobInfo;
    }
    uint          dwSigningCertChoice;
    union
    {
        CERT_CONTEXT* pSigningCertContext;
        CRYPTUI_WIZ_DIGITAL_SIGN_STORE_INFO* pSigningCertStore;
        CRYPTUI_WIZ_DIGITAL_SIGN_CERT_PVK_INFO* pSigningCertPvkInfo;
    }
    const(wchar)* pwszTimestampURL;
    uint          dwAdditionalCertChoice;
    CRYPTUI_WIZ_DIGITAL_SIGN_EXTENDED_INFO* pSignExtInfo;
}

struct CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT
{
    uint   dwSize;
    uint   cbBlob;
    ubyte* pbBlob;
}

struct CRYPTUI_INITDIALOG_STRUCT
{
    LPARAM        lParam;
    CERT_CONTEXT* pCertContext;
}

struct CRYPTUI_VIEWCERTIFICATE_STRUCTW
{
    uint            dwSize;
    HWND            hwndParent;
    uint            dwFlags;
    const(wchar)*   szTitle;
    CERT_CONTEXT*   pCertContext;
    byte**          rgszPurposes;
    uint            cPurposes;
    union
    {
        const(CRYPT_PROVIDER_DATA)* pCryptProviderData;
        HANDLE hWVTStateData;
    }
    BOOL            fpCryptProviderDataTrustedUsage;
    uint            idxSigner;
    uint            idxCert;
    BOOL            fCounterSigner;
    uint            idxCounterSigner;
    uint            cStores;
    void**          rghStores;
    uint            cPropSheetPages;
    PROPSHEETPAGEW* rgPropSheetPages;
    uint            nStartPage;
}

struct CRYPTUI_VIEWCERTIFICATE_STRUCTA
{
    uint            dwSize;
    HWND            hwndParent;
    uint            dwFlags;
    const(char)*    szTitle;
    CERT_CONTEXT*   pCertContext;
    byte**          rgszPurposes;
    uint            cPurposes;
    union
    {
        const(CRYPT_PROVIDER_DATA)* pCryptProviderData;
        HANDLE hWVTStateData;
    }
    BOOL            fpCryptProviderDataTrustedUsage;
    uint            idxSigner;
    uint            idxCert;
    BOOL            fCounterSigner;
    uint            idxCounterSigner;
    uint            cStores;
    void**          rghStores;
    uint            cPropSheetPages;
    PROPSHEETPAGEA* rgPropSheetPages;
    uint            nStartPage;
}

struct CRYPTUI_WIZ_EXPORT_INFO
{
    uint          dwSize;
    const(wchar)* pwszExportFileName;
    uint          dwSubjectChoice;
    union
    {
        CERT_CONTEXT* pCertContext;
        CTL_CONTEXT*  pCTLContext;
        CRL_CONTEXT*  pCRLContext;
        void*         hCertStore;
    }
    uint          cStores;
    void**        rghStores;
}

struct CRYPTUI_WIZ_EXPORT_CERTCONTEXT_INFO
{
    uint          dwSize;
    uint          dwExportFormat;
    BOOL          fExportChain;
    BOOL          fExportPrivateKeys;
    const(wchar)* pwszPassword;
    BOOL          fStrongEncryption;
}

struct CRYPTUI_WIZ_IMPORT_SRC_INFO
{
    uint          dwSize;
    uint          dwSubjectChoice;
    union
    {
        const(wchar)* pwszFileName;
        CERT_CONTEXT* pCertContext;
        CTL_CONTEXT*  pCTLContext;
        CRL_CONTEXT*  pCRLContext;
        void*         hCertStore;
    }
    uint          dwFlags;
    const(wchar)* pwszPassword;
}

struct SIP_SUBJECTINFO
{
    uint          cbSize;
    GUID*         pgSubjectType;
    HANDLE        hFile;
    const(wchar)* pwsFileName;
    const(wchar)* pwsDisplayName;
    uint          dwReserved1;
    uint          dwIntVersion;
    size_t        hProv;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    uint          dwFlags;
    uint          dwEncodingType;
    uint          dwReserved2;
    uint          fdwCAPISettings;
    uint          fdwSecuritySettings;
    uint          dwIndex;
    uint          dwUnionChoice;
    union
    {
        MS_ADDINFO_FLAT* psFlat;
        MS_ADDINFO_CATALOGMEMBER* psCatMember;
        MS_ADDINFO_BLOB* psBlob;
    }
    void*         pClientData;
}

struct MS_ADDINFO_FLAT
{
    uint               cbStruct;
    SIP_INDIRECT_DATA* pIndirectData;
}

struct MS_ADDINFO_CATALOGMEMBER
{
    uint            cbStruct;
    CRYPTCATSTORE*  pStore;
    CRYPTCATMEMBER* pMember;
}

struct MS_ADDINFO_BLOB
{
    uint   cbStruct;
    uint   cbMemObject;
    ubyte* pbMemObject;
    uint   cbMemSignedMsg;
    ubyte* pbMemSignedMsg;
}

struct SIP_CAP_SET_V2
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
    uint dwReserved;
}

struct SIP_CAP_SET_V3
{
    uint cbSize;
    uint dwVersion;
    BOOL isMultiSign;
    union
    {
        uint dwFlags;
        uint dwReserved;
    }
}

struct SIP_INDIRECT_DATA
{
    CRYPT_ATTRIBUTE_TYPE_VALUE Data;
    CRYPT_ALGORITHM_IDENTIFIER DigestAlgorithm;
    CRYPTOAPI_BLOB Digest;
}

struct SIP_DISPATCH_INFO
{
    uint   cbSize;
    HANDLE hSIP;
    pCryptSIPGetSignedDataMsg pfGet;
    pCryptSIPPutSignedDataMsg pfPut;
    pCryptSIPCreateIndirectData pfCreate;
    pCryptSIPVerifyIndirectData pfVerify;
    pCryptSIPRemoveSignedDataMsg pfRemove;
}

struct SIP_ADD_NEWPROVIDER
{
    uint          cbStruct;
    GUID*         pgSubject;
    ushort*       pwszDLLFileName;
    ushort*       pwszMagicNumber;
    ushort*       pwszIsFunctionName;
    ushort*       pwszGetFuncName;
    ushort*       pwszPutFuncName;
    ushort*       pwszCreateFuncName;
    ushort*       pwszVerifyFuncName;
    ushort*       pwszRemoveFuncName;
    ushort*       pwszIsFunctionNameFmt2;
    const(wchar)* pwszGetCapFuncName;
}

struct CRYPTCATSTORE
{
    uint          cbStruct;
    uint          dwPublicVersion;
    const(wchar)* pwszP7File;
    size_t        hProv;
    uint          dwEncodingType;
    uint          fdwStoreFlags;
    HANDLE        hReserved;
    HANDLE        hAttrs;
    void*         hCryptMsg;
    HANDLE        hSorted;
}

struct CRYPTCATMEMBER
{
    uint               cbStruct;
    const(wchar)*      pwszReferenceTag;
    const(wchar)*      pwszFileName;
    GUID               gSubjectType;
    uint               fdwMemberFlags;
    SIP_INDIRECT_DATA* pIndirectData;
    uint               dwCertVersion;
    uint               dwReserved;
    HANDLE             hReserved;
    CRYPTOAPI_BLOB     sEncodedIndirectData;
    CRYPTOAPI_BLOB     sEncodedMemberInfo;
}

struct CRYPTCATATTRIBUTE
{
    uint          cbStruct;
    const(wchar)* pwszReferenceTag;
    uint          dwAttrTypeAndAction;
    uint          cbValue;
    ubyte*        pbValue;
    uint          dwReserved;
}

struct CRYPTCATCDF
{
    uint          cbStruct;
    HANDLE        hFile;
    uint          dwCurFilePos;
    uint          dwLastMemberOffset;
    BOOL          fEOF;
    const(wchar)* pwszResultDir;
    HANDLE        hCATStore;
}

struct CATALOG_INFO
{
    uint        cbStruct;
    ushort[260] wszCatalogFile;
}

struct SCESVC_CONFIGURATION_LINE
{
    byte* Key;
    byte* Value;
    uint  ValueLen;
}

struct SCESVC_CONFIGURATION_INFO
{
    uint Count;
    SCESVC_CONFIGURATION_LINE* Lines;
}

struct SCESVC_ANALYSIS_LINE
{
    byte*  Key;
    ubyte* Value;
    uint   ValueLen;
}

struct SCESVC_ANALYSIS_INFO
{
    uint Count;
    SCESVC_ANALYSIS_LINE* Lines;
}

struct SCESVC_CALLBACK_INFO
{
    void*            sceHandle;
    PFSCE_QUERY_INFO pfQueryInfo;
    PFSCE_SET_INFO   pfSetInfo;
    PFSCE_FREE_INFO  pfFreeInfo;
    PFSCE_LOG_INFO   pfLogInfo;
}

struct SAFER_LEVEL_HANDLE__
{
    int unused;
}

struct SAFER_CODE_PROPERTIES_V1
{
    uint          cbSize;
    uint          dwCheckFlags;
    const(wchar)* ImagePath;
    HANDLE        hImageFileHandle;
    uint          UrlZoneId;
    ubyte[64]     ImageHash;
    uint          dwImageHashSize;
    LARGE_INTEGER ImageSize;
    uint          HashAlgorithm;
    ubyte*        pByteBlock;
    HWND          hWndParent;
    uint          dwWVTUIChoice;
}

struct SAFER_CODE_PROPERTIES_V2
{
    uint          cbSize;
    uint          dwCheckFlags;
    const(wchar)* ImagePath;
    HANDLE        hImageFileHandle;
    uint          UrlZoneId;
    ubyte[64]     ImageHash;
    uint          dwImageHashSize;
    LARGE_INTEGER ImageSize;
    uint          HashAlgorithm;
    ubyte*        pByteBlock;
    HWND          hWndParent;
    uint          dwWVTUIChoice;
    const(wchar)* PackageMoniker;
    const(wchar)* PackagePublisher;
    const(wchar)* PackageName;
    ulong         PackageVersion;
    BOOL          PackageIsFramework;
}

struct SAFER_IDENTIFICATION_HEADER
{
    SAFER_IDENTIFICATION_TYPES dwIdentificationType;
    uint     cbStructSize;
    GUID     IdentificationGuid;
    FILETIME lastModified;
}

struct SAFER_PATHNAME_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    ushort[256]   Description;
    const(wchar)* ImageName;
    uint          dwSaferFlags;
}

struct SAFER_HASH_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    ushort[256]   Description;
    ushort[256]   FriendlyName;
    uint          HashSize;
    ubyte[64]     ImageHash;
    uint          HashAlgorithm;
    LARGE_INTEGER ImageSize;
    uint          dwSaferFlags;
}

struct SAFER_HASH_IDENTIFICATION2
{
    SAFER_HASH_IDENTIFICATION hashIdentification;
    uint      HashSize;
    ubyte[64] ImageHash;
    uint      HashAlgorithm;
}

struct SAFER_URLZONE_IDENTIFICATION
{
    SAFER_IDENTIFICATION_HEADER header;
    uint UrlZoneId;
    uint dwSaferFlags;
}

struct SL_LICENSING_STATUS
{
    GUID              SkuId;
    SLLICENSINGSTATUS eStatus;
    uint              dwGraceTime;
    uint              dwTotalGraceDays;
    HRESULT           hrReason;
    ulong             qwValidityExpiration;
}

struct SL_ACTIVATION_INFO_HEADER
{
    uint               cbSize;
    SL_ACTIVATION_TYPE type;
}

struct SL_AD_ACTIVATION_INFO
{
    SL_ACTIVATION_INFO_HEADER header;
    const(wchar)* pwszProductKey;
    const(wchar)* pwszActivationObjectName;
}

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

struct DIAGNOSTIC_DATA_RECORD
{
    long          rowId;
    ulong         timestamp;
    ulong         eventKeywords;
    const(wchar)* fullEventName;
    const(wchar)* providerGroupGuid;
    const(wchar)* producerName;
    int*          privacyTags;
    uint          privacyTagCount;
    int*          categoryIds;
    uint          categoryIdCount;
    BOOL          isCoreData;
    const(wchar)* extra1;
    const(wchar)* extra2;
    const(wchar)* extra3;
}

struct DIAGNOSTIC_DATA_SEARCH_CRITERIA
{
    ushort**      producerNames;
    uint          producerNameCount;
    const(wchar)* textToMatch;
    const(int)*   categoryIds;
    uint          categoryIdCount;
    const(int)*   privacyTags;
    uint          privacyTagCount;
    BOOL          coreDataOnly;
}

struct DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION
{
    int           privacyTag;
    const(wchar)* name;
    const(wchar)* description;
}

struct DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION
{
    const(wchar)* name;
}

struct DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION
{
    int           id;
    const(wchar)* name;
}

struct DIAGNOSTIC_DATA_EVENT_TAG_STATS
{
    int  privacyTag;
    uint eventCount;
}

struct DIAGNOSTIC_DATA_EVENT_BINARY_STATS
{
    const(wchar)* moduleName;
    const(wchar)* friendlyModuleName;
    uint          eventCount;
    ulong         uploadSizeBytes;
}

struct DIAGNOSTIC_DATA_GENERAL_STATS
{
    uint  optInLevel;
    ulong transcriptSizeBytes;
    ulong oldestEventTimestamp;
    uint  totalEventCountLast24Hours;
    float averageDailyEvents;
}

struct DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION
{
    uint hoursOfHistoryToKeep;
    uint maxStoreMegabytes;
    uint requestedMaxStoreMegabytes;
}

struct DIAGNOSTIC_REPORT_PARAMETER
{
    ushort[129] name;
    ushort[260] value;
}

struct DIAGNOSTIC_REPORT_SIGNATURE
{
    ushort[65] eventName;
    DIAGNOSTIC_REPORT_PARAMETER[10] parameters;
}

struct DIAGNOSTIC_REPORT_DATA
{
    DIAGNOSTIC_REPORT_SIGNATURE signature;
    GUID          bucketId;
    GUID          reportId;
    FILETIME      creationTime;
    ulong         sizeInBytes;
    const(wchar)* cabId;
    uint          reportStatus;
    GUID          reportIntegratorId;
    ushort**      fileNames;
    uint          fileCount;
    const(wchar)* friendlyEventName;
    const(wchar)* applicationName;
    const(wchar)* applicationPath;
    const(wchar)* description;
    const(wchar)* bucketIdString;
    ulong         legacyBucketId;
    const(wchar)* reportKey;
}

struct HDIAGNOSTIC_DATA_QUERY_SESSION__
{
    int unused;
}

struct HDIAGNOSTIC_REPORT__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__
{
    int unused;
}

struct HDIAGNOSTIC_RECORD__
{
    int unused;
}

struct NETRESOURCEA
{
    uint         dwScope;
    uint         dwType;
    uint         dwDisplayType;
    uint         dwUsage;
    const(char)* lpLocalName;
    const(char)* lpRemoteName;
    const(char)* lpComment;
    const(char)* lpProvider;
}

struct NETRESOURCEW
{
    uint          dwScope;
    uint          dwType;
    uint          dwDisplayType;
    uint          dwUsage;
    const(wchar)* lpLocalName;
    const(wchar)* lpRemoteName;
    const(wchar)* lpComment;
    const(wchar)* lpProvider;
}

struct UNIVERSAL_NAME_INFOA
{
    const(char)* lpUniversalName;
}

struct UNIVERSAL_NAME_INFOW
{
    const(wchar)* lpUniversalName;
}

struct REMOTE_NAME_INFOA
{
    const(char)* lpUniversalName;
    const(char)* lpConnectionName;
    const(char)* lpRemainingPath;
}

struct REMOTE_NAME_INFOW
{
    const(wchar)* lpUniversalName;
    const(wchar)* lpConnectionName;
    const(wchar)* lpRemainingPath;
}

struct NETCONNECTINFOSTRUCT
{
    uint cbStructure;
    uint dwFlags;
    uint dwSpeed;
    uint dwDelay;
    uint dwOptDataSize;
}

// Functions

@DllImport("logoncli")
NTSTATUS NetAddServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, const(wchar)* Password, 
                              uint Flags);

@DllImport("logoncli")
NTSTATUS NetRemoveServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, uint Flags);

@DllImport("logoncli")
NTSTATUS NetEnumerateServiceAccounts(const(wchar)* ServerName, uint Flags, uint* AccountsCount, ushort*** Accounts);

@DllImport("logoncli")
NTSTATUS NetIsServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, int* IsService);

@DllImport("logoncli")
NTSTATUS NetQueryServiceAccount(const(wchar)* ServerName, const(wchar)* AccountName, uint InfoLevel, 
                                ubyte** Buffer);

@DllImport("ADVAPI32")
BOOL SetServiceBits(SERVICE_STATUS_HANDLE__* hServiceStatus, uint dwServiceBits, BOOL bSetBitsOn, 
                    BOOL bUpdateImmediately);

@DllImport("ADVAPI32")
BOOL ImpersonateNamedPipeClient(HANDLE hNamedPipe);

@DllImport("USER32")
BOOL SetUserObjectSecurity(HANDLE hObj, uint* pSIRequested, void* pSID);

@DllImport("USER32")
BOOL GetUserObjectSecurity(HANDLE hObj, uint* pSIRequested, char* pSID, uint nLength, uint* lpnLengthNeeded);

@DllImport("ADVAPI32")
BOOL AccessCheck(void* pSecurityDescriptor, HANDLE ClientToken, uint DesiredAccess, 
                 GENERIC_MAPPING* GenericMapping, char* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, 
                 int* AccessStatus);

@DllImport("ADVAPI32")
BOOL AccessCheckAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, 
                               const(wchar)* ObjectName, void* SecurityDescriptor, uint DesiredAccess, 
                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                               int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByType(void* pSecurityDescriptor, void* PrincipalSelfSid, HANDLE ClientToken, uint DesiredAccess, 
                       char* ObjectTypeList, uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                       char* PrivilegeSet, uint* PrivilegeSetLength, uint* GrantedAccess, int* AccessStatus);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeResultList(void* pSecurityDescriptor, void* PrincipalSelfSid, HANDLE ClientToken, 
                                 uint DesiredAccess, char* ObjectTypeList, uint ObjectTypeListLength, 
                                 GENERIC_MAPPING* GenericMapping, char* PrivilegeSet, uint* PrivilegeSetLength, 
                                 char* GrantedAccessList, char* AccessStatusList);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, 
                                     const(wchar)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, 
                                     uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                     char* ObjectTypeList, uint ObjectTypeListLength, 
                                     GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                                     int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeResultListAndAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, 
                                               const(wchar)* ObjectTypeName, const(wchar)* ObjectName, 
                                               void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, 
                                               AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, 
                                               uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                                               BOOL ObjectCreation, char* GrantedAccessList, char* AccessStatusList, 
                                               int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleW(const(wchar)* SubsystemName, void* HandleId, 
                                                       HANDLE ClientToken, const(wchar)* ObjectTypeName, 
                                                       const(wchar)* ObjectName, void* SecurityDescriptor, 
                                                       void* PrincipalSelfSid, uint DesiredAccess, 
                                                       AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, 
                                                       uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                                                       BOOL ObjectCreation, char* GrantedAccessList, 
                                                       char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AddAccessAllowedAce(ACL* pAcl, uint dwAceRevision, uint AccessMask, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAccessAllowedAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAccessAllowedObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, GUID* ObjectTypeGuid, 
                               GUID* InheritedObjectTypeGuid, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAccessDeniedAce(ACL* pAcl, uint dwAceRevision, uint AccessMask, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAccessDeniedAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAccessDeniedObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, GUID* ObjectTypeGuid, 
                              GUID* InheritedObjectTypeGuid, void* pSid);

@DllImport("ADVAPI32")
BOOL AddAce(ACL* pAcl, uint dwAceRevision, uint dwStartingAceIndex, char* pAceList, uint nAceListLength);

@DllImport("ADVAPI32")
BOOL AddAuditAccessAce(ACL* pAcl, uint dwAceRevision, uint dwAccessMask, void* pSid, BOOL bAuditSuccess, 
                       BOOL bAuditFailure);

@DllImport("ADVAPI32")
BOOL AddAuditAccessAceEx(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint dwAccessMask, void* pSid, 
                         BOOL bAuditSuccess, BOOL bAuditFailure);

@DllImport("ADVAPI32")
BOOL AddAuditAccessObjectAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, GUID* ObjectTypeGuid, 
                             GUID* InheritedObjectTypeGuid, void* pSid, BOOL bAuditSuccess, BOOL bAuditFailure);

@DllImport("ADVAPI32")
BOOL AddMandatoryAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint MandatoryPolicy, void* pLabelSid);

@DllImport("KERNEL32")
BOOL AddResourceAttributeAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid, 
                             CLAIM_SECURITY_ATTRIBUTES_INFORMATION* pAttributeInfo, uint* pReturnLength);

@DllImport("KERNEL32")
BOOL AddScopedPolicyIDAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, uint AccessMask, void* pSid);

@DllImport("ADVAPI32")
BOOL AdjustTokenGroups(HANDLE TokenHandle, BOOL ResetToDefault, TOKEN_GROUPS* NewState, uint BufferLength, 
                       char* PreviousState, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL AdjustTokenPrivileges(HANDLE TokenHandle, BOOL DisableAllPrivileges, TOKEN_PRIVILEGES* NewState, 
                           uint BufferLength, char* PreviousState, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL AllocateAndInitializeSid(SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount, 
                              uint nSubAuthority0, uint nSubAuthority1, uint nSubAuthority2, uint nSubAuthority3, 
                              uint nSubAuthority4, uint nSubAuthority5, uint nSubAuthority6, uint nSubAuthority7, 
                              void** pSid);

@DllImport("ADVAPI32")
BOOL AllocateLocallyUniqueId(LUID* Luid);

@DllImport("ADVAPI32")
BOOL AreAllAccessesGranted(uint GrantedAccess, uint DesiredAccess);

@DllImport("ADVAPI32")
BOOL AreAnyAccessesGranted(uint GrantedAccess, uint DesiredAccess);

@DllImport("ADVAPI32")
BOOL CheckTokenMembership(HANDLE TokenHandle, void* SidToCheck, int* IsMember);

@DllImport("KERNEL32")
BOOL CheckTokenCapability(HANDLE TokenHandle, void* CapabilitySidToCheck, int* HasCapability);

@DllImport("KERNEL32")
BOOL GetAppContainerAce(ACL* Acl, uint StartingAceIndex, void** AppContainerAce, uint* AppContainerAceIndex);

@DllImport("KERNEL32")
BOOL CheckTokenMembershipEx(HANDLE TokenHandle, void* SidToCheck, uint Flags, int* IsMember);

@DllImport("ADVAPI32")
BOOL ConvertToAutoInheritPrivateObjectSecurity(void* ParentDescriptor, void* CurrentSecurityDescriptor, 
                                               void** NewSecurityDescriptor, GUID* ObjectType, 
                                               ubyte IsDirectoryObject, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32")
BOOL CopySid(uint nDestinationSidLength, char* pDestinationSid, void* pSourceSid);

@DllImport("ADVAPI32")
BOOL CreatePrivateObjectSecurity(void* ParentDescriptor, void* CreatorDescriptor, void** NewDescriptor, 
                                 BOOL IsDirectoryObject, HANDLE Token, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32")
BOOL CreatePrivateObjectSecurityEx(void* ParentDescriptor, void* CreatorDescriptor, void** NewDescriptor, 
                                   GUID* ObjectType, BOOL IsContainerObject, uint AutoInheritFlags, HANDLE Token, 
                                   GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32")
BOOL CreatePrivateObjectSecurityWithMultipleInheritance(void* ParentDescriptor, void* CreatorDescriptor, 
                                                        void** NewDescriptor, char* ObjectTypes, uint GuidCount, 
                                                        BOOL IsContainerObject, uint AutoInheritFlags, HANDLE Token, 
                                                        GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32")
BOOL CreateRestrictedToken(HANDLE ExistingTokenHandle, uint Flags, uint DisableSidCount, char* SidsToDisable, 
                           uint DeletePrivilegeCount, char* PrivilegesToDelete, uint RestrictedSidCount, 
                           char* SidsToRestrict, ptrdiff_t* NewTokenHandle);

@DllImport("ADVAPI32")
BOOL CreateWellKnownSid(WELL_KNOWN_SID_TYPE WellKnownSidType, void* DomainSid, char* pSid, uint* cbSid);

@DllImport("ADVAPI32")
BOOL EqualDomainSid(void* pSid1, void* pSid2, int* pfEqual);

@DllImport("ADVAPI32")
BOOL DeleteAce(ACL* pAcl, uint dwAceIndex);

@DllImport("ADVAPI32")
BOOL DestroyPrivateObjectSecurity(void** ObjectDescriptor);

@DllImport("ADVAPI32")
BOOL DuplicateToken(HANDLE ExistingTokenHandle, SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, 
                    ptrdiff_t* DuplicateTokenHandle);

@DllImport("ADVAPI32")
BOOL DuplicateTokenEx(HANDLE hExistingToken, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpTokenAttributes, 
                      SECURITY_IMPERSONATION_LEVEL ImpersonationLevel, TOKEN_TYPE TokenType, ptrdiff_t* phNewToken);

@DllImport("ADVAPI32")
BOOL EqualPrefixSid(void* pSid1, void* pSid2);

@DllImport("ADVAPI32")
BOOL EqualSid(void* pSid1, void* pSid2);

@DllImport("ADVAPI32")
BOOL FindFirstFreeAce(ACL* pAcl, void** pAce);

@DllImport("ADVAPI32")
void* FreeSid(void* pSid);

@DllImport("ADVAPI32")
BOOL GetAce(ACL* pAcl, uint dwAceIndex, void** pAce);

@DllImport("ADVAPI32")
BOOL GetAclInformation(ACL* pAcl, char* pAclInformation, uint nAclInformationLength, 
                       ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32")
BOOL GetFileSecurityW(const(wchar)* lpFileName, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, 
                      uint* lpnLengthNeeded);

@DllImport("ADVAPI32")
BOOL GetKernelObjectSecurity(HANDLE Handle, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, 
                             uint* lpnLengthNeeded);

@DllImport("ADVAPI32")
uint GetLengthSid(char* pSid);

@DllImport("ADVAPI32")
BOOL GetPrivateObjectSecurity(void* ObjectDescriptor, uint SecurityInformation, char* ResultantDescriptor, 
                              uint DescriptorLength, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL GetSecurityDescriptorControl(void* pSecurityDescriptor, ushort* pControl, uint* lpdwRevision);

@DllImport("ADVAPI32")
BOOL GetSecurityDescriptorDacl(void* pSecurityDescriptor, int* lpbDaclPresent, ACL** pDacl, int* lpbDaclDefaulted);

@DllImport("ADVAPI32")
BOOL GetSecurityDescriptorGroup(void* pSecurityDescriptor, void** pGroup, int* lpbGroupDefaulted);

@DllImport("ADVAPI32")
uint GetSecurityDescriptorLength(void* pSecurityDescriptor);

@DllImport("ADVAPI32")
BOOL GetSecurityDescriptorOwner(void* pSecurityDescriptor, void** pOwner, int* lpbOwnerDefaulted);

@DllImport("ADVAPI32")
uint GetSecurityDescriptorRMControl(void* SecurityDescriptor, ubyte* RMControl);

@DllImport("ADVAPI32")
BOOL GetSecurityDescriptorSacl(void* pSecurityDescriptor, int* lpbSaclPresent, ACL** pSacl, int* lpbSaclDefaulted);

@DllImport("ADVAPI32")
SID_IDENTIFIER_AUTHORITY* GetSidIdentifierAuthority(void* pSid);

@DllImport("ADVAPI32")
uint GetSidLengthRequired(ubyte nSubAuthorityCount);

@DllImport("ADVAPI32")
uint* GetSidSubAuthority(void* pSid, uint nSubAuthority);

@DllImport("ADVAPI32")
ubyte* GetSidSubAuthorityCount(void* pSid);

@DllImport("ADVAPI32")
BOOL GetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, char* TokenInformation, 
                         uint TokenInformationLength, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL GetWindowsAccountDomainSid(void* pSid, char* pDomainSid, uint* cbDomainSid);

@DllImport("ADVAPI32")
BOOL ImpersonateAnonymousToken(HANDLE ThreadHandle);

@DllImport("ADVAPI32")
BOOL ImpersonateLoggedOnUser(HANDLE hToken);

@DllImport("ADVAPI32")
BOOL ImpersonateSelf(SECURITY_IMPERSONATION_LEVEL ImpersonationLevel);

@DllImport("ADVAPI32")
BOOL InitializeAcl(char* pAcl, uint nAclLength, uint dwAclRevision);

@DllImport("ADVAPI32")
BOOL InitializeSecurityDescriptor(void* pSecurityDescriptor, uint dwRevision);

@DllImport("ADVAPI32")
BOOL InitializeSid(char* Sid, SID_IDENTIFIER_AUTHORITY* pIdentifierAuthority, ubyte nSubAuthorityCount);

@DllImport("ADVAPI32")
BOOL IsTokenRestricted(HANDLE TokenHandle);

@DllImport("ADVAPI32")
BOOL IsValidAcl(ACL* pAcl);

@DllImport("ADVAPI32")
BOOL IsValidSecurityDescriptor(void* pSecurityDescriptor);

@DllImport("ADVAPI32")
BOOL IsValidSid(void* pSid);

@DllImport("ADVAPI32")
BOOL IsWellKnownSid(void* pSid, WELL_KNOWN_SID_TYPE WellKnownSidType);

@DllImport("ADVAPI32")
BOOL MakeAbsoluteSD(void* pSelfRelativeSecurityDescriptor, char* pAbsoluteSecurityDescriptor, 
                    uint* lpdwAbsoluteSecurityDescriptorSize, char* pDacl, uint* lpdwDaclSize, char* pSacl, 
                    uint* lpdwSaclSize, char* pOwner, uint* lpdwOwnerSize, char* pPrimaryGroup, 
                    uint* lpdwPrimaryGroupSize);

@DllImport("ADVAPI32")
BOOL MakeSelfRelativeSD(void* pAbsoluteSecurityDescriptor, char* pSelfRelativeSecurityDescriptor, 
                        uint* lpdwBufferLength);

@DllImport("ADVAPI32")
void MapGenericMask(uint* AccessMask, GENERIC_MAPPING* GenericMapping);

@DllImport("ADVAPI32")
BOOL ObjectCloseAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectDeleteAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectOpenAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, const(wchar)* ObjectTypeName, 
                           const(wchar)* ObjectName, void* pSecurityDescriptor, HANDLE ClientToken, 
                           uint DesiredAccess, uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, 
                           BOOL AccessGranted, int* GenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectPrivilegeAuditAlarmW(const(wchar)* SubsystemName, void* HandleId, HANDLE ClientToken, 
                                uint DesiredAccess, PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32")
BOOL PrivilegeCheck(HANDLE ClientToken, PRIVILEGE_SET* RequiredPrivileges, int* pfResult);

@DllImport("ADVAPI32")
BOOL PrivilegedServiceAuditAlarmW(const(wchar)* SubsystemName, const(wchar)* ServiceName, HANDLE ClientToken, 
                                  PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32")
void QuerySecurityAccessMask(uint SecurityInformation, uint* DesiredAccess);

@DllImport("ADVAPI32")
BOOL RevertToSelf();

@DllImport("ADVAPI32")
BOOL SetAclInformation(ACL* pAcl, char* pAclInformation, uint nAclInformationLength, 
                       ACL_INFORMATION_CLASS dwAclInformationClass);

@DllImport("ADVAPI32")
BOOL SetFileSecurityW(const(wchar)* lpFileName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32")
BOOL SetKernelObjectSecurity(HANDLE Handle, uint SecurityInformation, void* SecurityDescriptor);

@DllImport("ADVAPI32")
BOOL SetPrivateObjectSecurity(uint SecurityInformation, void* ModificationDescriptor, 
                              void** ObjectsSecurityDescriptor, GENERIC_MAPPING* GenericMapping, HANDLE Token);

@DllImport("ADVAPI32")
BOOL SetPrivateObjectSecurityEx(uint SecurityInformation, void* ModificationDescriptor, 
                                void** ObjectsSecurityDescriptor, uint AutoInheritFlags, 
                                GENERIC_MAPPING* GenericMapping, HANDLE Token);

@DllImport("ADVAPI32")
void SetSecurityAccessMask(uint SecurityInformation, uint* DesiredAccess);

@DllImport("ADVAPI32")
BOOL SetSecurityDescriptorControl(void* pSecurityDescriptor, ushort ControlBitsOfInterest, ushort ControlBitsToSet);

@DllImport("ADVAPI32")
BOOL SetSecurityDescriptorDacl(void* pSecurityDescriptor, BOOL bDaclPresent, ACL* pDacl, BOOL bDaclDefaulted);

@DllImport("ADVAPI32")
BOOL SetSecurityDescriptorGroup(void* pSecurityDescriptor, void* pGroup, BOOL bGroupDefaulted);

@DllImport("ADVAPI32")
BOOL SetSecurityDescriptorOwner(void* pSecurityDescriptor, void* pOwner, BOOL bOwnerDefaulted);

@DllImport("ADVAPI32")
uint SetSecurityDescriptorRMControl(void* SecurityDescriptor, ubyte* RMControl);

@DllImport("ADVAPI32")
BOOL SetSecurityDescriptorSacl(void* pSecurityDescriptor, BOOL bSaclPresent, ACL* pSacl, BOOL bSaclDefaulted);

@DllImport("ADVAPI32")
BOOL SetTokenInformation(HANDLE TokenHandle, TOKEN_INFORMATION_CLASS TokenInformationClass, char* TokenInformation, 
                         uint TokenInformationLength);

@DllImport("KERNEL32")
BOOL SetCachedSigningLevel(char* SourceFiles, uint SourceFileCount, uint Flags, HANDLE TargetFile);

@DllImport("KERNEL32")
BOOL GetCachedSigningLevel(HANDLE File, uint* Flags, uint* SigningLevel, char* Thumbprint, uint* ThumbprintSize, 
                           uint* ThumbprintAlgorithm);

@DllImport("api-ms-win-security-base-l1-2-2")
BOOL DeriveCapabilitySidsFromName(const(wchar)* CapName, void*** CapabilityGroupSids, 
                                  uint* CapabilityGroupSidCount, void*** CapabilitySids, uint* CapabilitySidCount);

@DllImport("KERNEL32")
BOOL GetAppContainerNamedObjectPath(HANDLE Token, void* AppContainerSid, uint ObjectPathLength, 
                                    const(wchar)* ObjectPath, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL CryptAcquireContextA(size_t* phProv, const(char)* szContainer, const(char)* szProvider, uint dwProvType, 
                          uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptAcquireContextW(size_t* phProv, const(wchar)* szContainer, const(wchar)* szProvider, uint dwProvType, 
                          uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptReleaseContext(size_t hProv, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGenKey(size_t hProv, uint Algid, uint dwFlags, size_t* phKey);

@DllImport("ADVAPI32")
BOOL CryptDeriveKey(size_t hProv, uint Algid, size_t hBaseData, uint dwFlags, size_t* phKey);

@DllImport("ADVAPI32")
BOOL CryptDestroyKey(size_t hKey);

@DllImport("ADVAPI32")
BOOL CryptSetKeyParam(size_t hKey, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGetKeyParam(size_t hKey, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptSetHashParam(size_t hHash, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGetHashParam(size_t hHash, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptSetProvParam(size_t hProv, uint dwParam, const(ubyte)* pbData, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGetProvParam(size_t hProv, uint dwParam, char* pbData, uint* pdwDataLen, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGenRandom(size_t hProv, uint dwLen, char* pbBuffer);

@DllImport("ADVAPI32")
BOOL CryptGetUserKey(size_t hProv, uint dwKeySpec, size_t* phUserKey);

@DllImport("ADVAPI32")
BOOL CryptExportKey(size_t hKey, size_t hExpKey, uint dwBlobType, uint dwFlags, char* pbData, uint* pdwDataLen);

@DllImport("ADVAPI32")
BOOL CryptImportKey(size_t hProv, char* pbData, uint dwDataLen, size_t hPubKey, uint dwFlags, size_t* phKey);

@DllImport("ADVAPI32")
BOOL CryptEncrypt(size_t hKey, size_t hHash, BOOL Final, uint dwFlags, char* pbData, uint* pdwDataLen, 
                  uint dwBufLen);

@DllImport("ADVAPI32")
BOOL CryptDecrypt(size_t hKey, size_t hHash, BOOL Final, uint dwFlags, char* pbData, uint* pdwDataLen);

@DllImport("ADVAPI32")
BOOL CryptCreateHash(size_t hProv, uint Algid, size_t hKey, uint dwFlags, size_t* phHash);

@DllImport("ADVAPI32")
BOOL CryptHashData(size_t hHash, char* pbData, uint dwDataLen, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptHashSessionKey(size_t hHash, size_t hKey, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptDestroyHash(size_t hHash);

@DllImport("ADVAPI32")
BOOL CryptSignHashA(size_t hHash, uint dwKeySpec, const(char)* szDescription, uint dwFlags, char* pbSignature, 
                    uint* pdwSigLen);

@DllImport("ADVAPI32")
BOOL CryptSignHashW(size_t hHash, uint dwKeySpec, const(wchar)* szDescription, uint dwFlags, char* pbSignature, 
                    uint* pdwSigLen);

@DllImport("ADVAPI32")
BOOL CryptVerifySignatureA(size_t hHash, char* pbSignature, uint dwSigLen, size_t hPubKey, 
                           const(char)* szDescription, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptVerifySignatureW(size_t hHash, char* pbSignature, uint dwSigLen, size_t hPubKey, 
                           const(wchar)* szDescription, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptSetProviderA(const(char)* pszProvName, uint dwProvType);

@DllImport("ADVAPI32")
BOOL CryptSetProviderW(const(wchar)* pszProvName, uint dwProvType);

@DllImport("ADVAPI32")
BOOL CryptSetProviderExA(const(char)* pszProvName, uint dwProvType, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptSetProviderExW(const(wchar)* pszProvName, uint dwProvType, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptGetDefaultProviderA(uint dwProvType, uint* pdwReserved, uint dwFlags, const(char)* pszProvName, 
                              uint* pcbProvName);

@DllImport("ADVAPI32")
BOOL CryptGetDefaultProviderW(uint dwProvType, uint* pdwReserved, uint dwFlags, const(wchar)* pszProvName, 
                              uint* pcbProvName);

@DllImport("ADVAPI32")
BOOL CryptEnumProviderTypesA(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, 
                             const(char)* szTypeName, uint* pcbTypeName);

@DllImport("ADVAPI32")
BOOL CryptEnumProviderTypesW(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, 
                             const(wchar)* szTypeName, uint* pcbTypeName);

@DllImport("ADVAPI32")
BOOL CryptEnumProvidersA(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, const(char)* szProvName, 
                         uint* pcbProvName);

@DllImport("ADVAPI32")
BOOL CryptEnumProvidersW(uint dwIndex, uint* pdwReserved, uint dwFlags, uint* pdwProvType, 
                         const(wchar)* szProvName, uint* pcbProvName);

@DllImport("ADVAPI32")
BOOL CryptContextAddRef(size_t hProv, uint* pdwReserved, uint dwFlags);

@DllImport("ADVAPI32")
BOOL CryptDuplicateKey(size_t hKey, uint* pdwReserved, uint dwFlags, size_t* phKey);

@DllImport("ADVAPI32")
BOOL CryptDuplicateHash(size_t hHash, uint* pdwReserved, uint dwFlags, size_t* phHash);

@DllImport("bcrypt")
NTSTATUS BCryptOpenAlgorithmProvider(void** phAlgorithm, const(wchar)* pszAlgId, const(wchar)* pszImplementation, 
                                     uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptEnumAlgorithms(uint dwAlgOperations, uint* pAlgCount, BCRYPT_ALGORITHM_IDENTIFIER** ppAlgList, 
                              uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptEnumProviders(const(wchar)* pszAlgId, uint* pImplCount, BCRYPT_PROVIDER_NAME** ppImplList, 
                             uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptGetProperty(void* hObject, const(wchar)* pszProperty, char* pbOutput, uint cbOutput, 
                           uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptSetProperty(void* hObject, const(wchar)* pszProperty, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptCloseAlgorithmProvider(void* hAlgorithm, uint dwFlags);

@DllImport("bcrypt")
void BCryptFreeBuffer(void* pvBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptGenerateSymmetricKey(void* hAlgorithm, void** phKey, char* pbKeyObject, uint cbKeyObject, 
                                    char* pbSecret, uint cbSecret, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptGenerateKeyPair(void* hAlgorithm, void** phKey, uint dwLength, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptEncrypt(void* hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbIV, uint cbIV, 
                       char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDecrypt(void* hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbIV, uint cbIV, 
                       char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptExportKey(void* hKey, void* hExportKey, const(wchar)* pszBlobType, char* pbOutput, uint cbOutput, 
                         uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptImportKey(void* hAlgorithm, void* hImportKey, const(wchar)* pszBlobType, void** phKey, 
                         char* pbKeyObject, uint cbKeyObject, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptImportKeyPair(void* hAlgorithm, void* hImportKey, const(wchar)* pszBlobType, void** phKey, 
                             char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDuplicateKey(void* hKey, void** phNewKey, char* pbKeyObject, uint cbKeyObject, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptFinalizeKeyPair(void* hKey, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDestroyKey(void* hKey);

@DllImport("bcrypt")
NTSTATUS BCryptDestroySecret(void* hSecret);

@DllImport("bcrypt")
NTSTATUS BCryptSignHash(void* hKey, void* pPaddingInfo, char* pbInput, uint cbInput, char* pbOutput, uint cbOutput, 
                        uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptVerifySignature(void* hKey, void* pPaddingInfo, char* pbHash, uint cbHash, char* pbSignature, 
                               uint cbSignature, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptSecretAgreement(void* hPrivKey, void* hPubKey, void** phAgreedSecret, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDeriveKey(void* hSharedSecret, const(wchar)* pwszKDF, BCryptBufferDesc* pParameterList, 
                         char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptKeyDerivation(void* hKey, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, 
                             uint* pcbResult, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptCreateHash(void* hAlgorithm, void** phHash, char* pbHashObject, uint cbHashObject, char* pbSecret, 
                          uint cbSecret, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptHashData(void* hHash, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptFinishHash(void* hHash, char* pbOutput, uint cbOutput, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptCreateMultiHash(void* hAlgorithm, void** phHash, uint nHashes, char* pbHashObject, 
                               uint cbHashObject, char* pbSecret, uint cbSecret, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptProcessMultiOperations(void* hObject, BCRYPT_MULTI_OPERATION_TYPE operationType, char* pOperations, 
                                      uint cbOperations, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDuplicateHash(void* hHash, void** phNewHash, char* pbHashObject, uint cbHashObject, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDestroyHash(void* hHash);

@DllImport("bcrypt")
NTSTATUS BCryptHash(void* hAlgorithm, char* pbSecret, uint cbSecret, char* pbInput, uint cbInput, char* pbOutput, 
                    uint cbOutput);

@DllImport("bcrypt")
NTSTATUS BCryptGenRandom(void* hAlgorithm, char* pbBuffer, uint cbBuffer, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDeriveKeyCapi(void* hHash, void* hTargetAlg, char* pbDerivedKey, uint cbDerivedKey, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptDeriveKeyPBKDF2(void* hPrf, char* pbPassword, uint cbPassword, char* pbSalt, uint cbSalt, 
                               ulong cIterations, char* pbDerivedKey, uint cbDerivedKey, uint dwFlags);

@DllImport("bcrypt")
NTSTATUS BCryptQueryProviderRegistration(const(wchar)* pszProvider, uint dwMode, uint dwInterface, uint* pcbBuffer, 
                                         char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptEnumRegisteredProviders(uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptCreateContext(uint dwTable, const(wchar)* pszContext, CRYPT_CONTEXT_CONFIG* pConfig);

@DllImport("bcrypt")
NTSTATUS BCryptDeleteContext(uint dwTable, const(wchar)* pszContext);

@DllImport("bcrypt")
NTSTATUS BCryptEnumContexts(uint dwTable, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptConfigureContext(uint dwTable, const(wchar)* pszContext, CRYPT_CONTEXT_CONFIG* pConfig);

@DllImport("bcrypt")
NTSTATUS BCryptQueryContextConfiguration(uint dwTable, const(wchar)* pszContext, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptAddContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                  const(wchar)* pszFunction, uint dwPosition);

@DllImport("bcrypt")
NTSTATUS BCryptRemoveContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                     const(wchar)* pszFunction);

@DllImport("bcrypt")
NTSTATUS BCryptEnumContextFunctions(uint dwTable, const(wchar)* pszContext, uint dwInterface, uint* pcbBuffer, 
                                    char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptConfigureContextFunction(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                        const(wchar)* pszFunction, CRYPT_CONTEXT_FUNCTION_CONFIG* pConfig);

@DllImport("bcrypt")
NTSTATUS BCryptQueryContextFunctionConfiguration(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                                 const(wchar)* pszFunction, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptEnumContextFunctionProviders(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                            const(wchar)* pszFunction, uint* pcbBuffer, char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptSetContextFunctionProperty(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                          const(wchar)* pszFunction, const(wchar)* pszProperty, uint cbValue, 
                                          char* pbValue);

@DllImport("bcrypt")
NTSTATUS BCryptQueryContextFunctionProperty(uint dwTable, const(wchar)* pszContext, uint dwInterface, 
                                            const(wchar)* pszFunction, const(wchar)* pszProperty, uint* pcbValue, 
                                            char* ppbValue);

@DllImport("bcrypt")
NTSTATUS BCryptRegisterConfigChangeNotify(HANDLE* phEvent);

@DllImport("bcrypt")
NTSTATUS BCryptUnregisterConfigChangeNotify(HANDLE hEvent);

@DllImport("bcrypt")
NTSTATUS BCryptResolveProviders(const(wchar)* pszContext, uint dwInterface, const(wchar)* pszFunction, 
                                const(wchar)* pszProvider, uint dwMode, uint dwFlags, uint* pcbBuffer, 
                                char* ppBuffer);

@DllImport("bcrypt")
NTSTATUS BCryptGetFipsAlgorithmMode(ubyte* pfEnabled);

@DllImport("ncrypt")
int NCryptOpenStorageProvider(size_t* phProvider, const(wchar)* pszProviderName, uint dwFlags);

@DllImport("ncrypt")
int NCryptEnumAlgorithms(size_t hProvider, uint dwAlgOperations, uint* pdwAlgCount, 
                         NCryptAlgorithmName** ppAlgList, uint dwFlags);

@DllImport("ncrypt")
int NCryptIsAlgSupported(size_t hProvider, const(wchar)* pszAlgId, uint dwFlags);

@DllImport("ncrypt")
int NCryptEnumKeys(size_t hProvider, const(wchar)* pszScope, NCryptKeyName** ppKeyName, void** ppEnumState, 
                   uint dwFlags);

@DllImport("ncrypt")
int NCryptEnumStorageProviders(uint* pdwProviderCount, NCryptProviderName** ppProviderList, uint dwFlags);

@DllImport("ncrypt")
int NCryptFreeBuffer(void* pvInput);

@DllImport("ncrypt")
int NCryptOpenKey(size_t hProvider, size_t* phKey, const(wchar)* pszKeyName, uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt")
int NCryptCreatePersistedKey(size_t hProvider, size_t* phKey, const(wchar)* pszAlgId, const(wchar)* pszKeyName, 
                             uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt")
int NCryptGetProperty(size_t hObject, const(wchar)* pszProperty, char* pbOutput, uint cbOutput, uint* pcbResult, 
                      uint dwFlags);

@DllImport("ncrypt")
int NCryptSetProperty(size_t hObject, const(wchar)* pszProperty, char* pbInput, uint cbInput, uint dwFlags);

@DllImport("ncrypt")
int NCryptFinalizeKey(size_t hKey, uint dwFlags);

@DllImport("ncrypt")
int NCryptEncrypt(size_t hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbOutput, uint cbOutput, 
                  uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptDecrypt(size_t hKey, char* pbInput, uint cbInput, void* pPaddingInfo, char* pbOutput, uint cbOutput, 
                  uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptImportKey(size_t hProvider, size_t hImportKey, const(wchar)* pszBlobType, 
                    BCryptBufferDesc* pParameterList, size_t* phKey, char* pbData, uint cbData, uint dwFlags);

@DllImport("ncrypt")
int NCryptExportKey(size_t hKey, size_t hExportKey, const(wchar)* pszBlobType, BCryptBufferDesc* pParameterList, 
                    char* pbOutput, uint cbOutput, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptSignHash(size_t hKey, void* pPaddingInfo, char* pbHashValue, uint cbHashValue, char* pbSignature, 
                   uint cbSignature, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptVerifySignature(size_t hKey, void* pPaddingInfo, char* pbHashValue, uint cbHashValue, char* pbSignature, 
                          uint cbSignature, uint dwFlags);

@DllImport("ncrypt")
int NCryptDeleteKey(size_t hKey, uint dwFlags);

@DllImport("ncrypt")
int NCryptFreeObject(size_t hObject);

@DllImport("ncrypt")
BOOL NCryptIsKeyHandle(size_t hKey);

@DllImport("ncrypt")
int NCryptTranslateHandle(size_t* phProvider, size_t* phKey, size_t hLegacyProv, size_t hLegacyKey, 
                          uint dwLegacyKeySpec, uint dwFlags);

@DllImport("ncrypt")
int NCryptNotifyChangeKey(size_t hProvider, HANDLE* phEvent, uint dwFlags);

@DllImport("ncrypt")
int NCryptSecretAgreement(size_t hPrivKey, size_t hPubKey, size_t* phAgreedSecret, uint dwFlags);

@DllImport("ncrypt")
int NCryptDeriveKey(size_t hSharedSecret, const(wchar)* pwszKDF, BCryptBufferDesc* pParameterList, 
                    char* pbDerivedKey, uint cbDerivedKey, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptKeyDerivation(size_t hKey, BCryptBufferDesc* pParameterList, char* pbDerivedKey, uint cbDerivedKey, 
                        uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptCreateClaim(size_t hSubjectKey, size_t hAuthorityKey, uint dwClaimType, BCryptBufferDesc* pParameterList, 
                      char* pbClaimBlob, uint cbClaimBlob, uint* pcbResult, uint dwFlags);

@DllImport("ncrypt")
int NCryptVerifyClaim(size_t hSubjectKey, size_t hAuthorityKey, uint dwClaimType, BCryptBufferDesc* pParameterList, 
                      char* pbClaimBlob, uint cbClaimBlob, BCryptBufferDesc* pOutput, uint dwFlags);

@DllImport("CRYPT32")
BOOL CryptFormatObject(uint dwCertEncodingType, uint dwFormatType, uint dwFormatStrType, void* pFormatStruct, 
                       const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, char* pbFormat, uint* pcbFormat);

@DllImport("CRYPT32")
BOOL CryptEncodeObjectEx(uint dwCertEncodingType, const(char)* lpszStructType, const(void)* pvStructInfo, 
                         uint dwFlags, CRYPT_ENCODE_PARA* pEncodePara, void* pvEncoded, uint* pcbEncoded);

@DllImport("CRYPT32")
BOOL CryptEncodeObject(uint dwCertEncodingType, const(char)* lpszStructType, const(void)* pvStructInfo, 
                       char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32")
BOOL CryptDecodeObjectEx(uint dwCertEncodingType, const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, 
                         uint dwFlags, CRYPT_DECODE_PARA* pDecodePara, void* pvStructInfo, uint* pcbStructInfo);

@DllImport("CRYPT32")
BOOL CryptDecodeObject(uint dwCertEncodingType, const(char)* lpszStructType, char* pbEncoded, uint cbEncoded, 
                       uint dwFlags, char* pvStructInfo, uint* pcbStructInfo);

@DllImport("CRYPT32")
BOOL CryptInstallOIDFunctionAddress(ptrdiff_t hModule, uint dwEncodingType, const(char)* pszFuncName, 
                                    uint cFuncEntry, char* rgFuncEntry, uint dwFlags);

@DllImport("CRYPT32")
void* CryptInitOIDFunctionSet(const(char)* pszFuncName, uint dwFlags);

@DllImport("CRYPT32")
BOOL CryptGetOIDFunctionAddress(void* hFuncSet, uint dwEncodingType, const(char)* pszOID, uint dwFlags, 
                                void** ppvFuncAddr, void** phFuncAddr);

@DllImport("CRYPT32")
BOOL CryptGetDefaultOIDDllList(void* hFuncSet, uint dwEncodingType, char* pwszDllList, uint* pcchDllList);

@DllImport("CRYPT32")
BOOL CryptGetDefaultOIDFunctionAddress(void* hFuncSet, uint dwEncodingType, const(wchar)* pwszDll, uint dwFlags, 
                                       void** ppvFuncAddr, void** phFuncAddr);

@DllImport("CRYPT32")
BOOL CryptFreeOIDFunctionAddress(void* hFuncAddr, uint dwFlags);

@DllImport("CRYPT32")
BOOL CryptRegisterOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, 
                              const(wchar)* pwszDll, const(char)* pszOverrideFuncName);

@DllImport("CRYPT32")
BOOL CryptUnregisterOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID);

@DllImport("CRYPT32")
BOOL CryptRegisterDefaultOIDFunction(uint dwEncodingType, const(char)* pszFuncName, uint dwIndex, 
                                     const(wchar)* pwszDll);

@DllImport("CRYPT32")
BOOL CryptUnregisterDefaultOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(wchar)* pwszDll);

@DllImport("CRYPT32")
BOOL CryptSetOIDFunctionValue(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, 
                              const(wchar)* pwszValueName, uint dwValueType, char* pbValueData, uint cbValueData);

@DllImport("CRYPT32")
BOOL CryptGetOIDFunctionValue(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, 
                              const(wchar)* pwszValueName, uint* pdwValueType, char* pbValueData, uint* pcbValueData);

@DllImport("CRYPT32")
BOOL CryptEnumOIDFunction(uint dwEncodingType, const(char)* pszFuncName, const(char)* pszOID, uint dwFlags, 
                          void* pvArg, PFN_CRYPT_ENUM_OID_FUNC pfnEnumOIDFunc);

@DllImport("CRYPT32")
CRYPT_OID_INFO* CryptFindOIDInfo(uint dwKeyType, void* pvKey, uint dwGroupId);

@DllImport("CRYPT32")
BOOL CryptRegisterOIDInfo(CRYPT_OID_INFO* pInfo, uint dwFlags);

@DllImport("CRYPT32")
BOOL CryptUnregisterOIDInfo(CRYPT_OID_INFO* pInfo);

@DllImport("CRYPT32")
BOOL CryptEnumOIDInfo(uint dwGroupId, uint dwFlags, void* pvArg, PFN_CRYPT_ENUM_OID_INFO pfnEnumOIDInfo);

@DllImport("CRYPT32")
ushort* CryptFindLocalizedName(const(wchar)* pwszCryptName);

@DllImport("CRYPT32")
void* CryptMsgOpenToEncode(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, const(void)* pvMsgEncodeInfo, 
                           const(char)* pszInnerContentObjID, CMSG_STREAM_INFO* pStreamInfo);

@DllImport("CRYPT32")
uint CryptMsgCalculateEncodedLength(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, 
                                    const(void)* pvMsgEncodeInfo, const(char)* pszInnerContentObjID, uint cbData);

@DllImport("CRYPT32")
void* CryptMsgOpenToDecode(uint dwMsgEncodingType, uint dwFlags, uint dwMsgType, size_t hCryptProv, 
                           CERT_INFO* pRecipientInfo, CMSG_STREAM_INFO* pStreamInfo);

@DllImport("CRYPT32")
void* CryptMsgDuplicate(void* hCryptMsg);

@DllImport("CRYPT32")
BOOL CryptMsgClose(void* hCryptMsg);

@DllImport("CRYPT32")
BOOL CryptMsgUpdate(void* hCryptMsg, char* pbData, uint cbData, BOOL fFinal);

@DllImport("CRYPT32")
BOOL CryptMsgGetParam(void* hCryptMsg, uint dwParamType, uint dwIndex, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
BOOL CryptMsgControl(void* hCryptMsg, uint dwFlags, uint dwCtrlType, const(void)* pvCtrlPara);

@DllImport("CRYPT32")
BOOL CryptMsgVerifyCountersignatureEncoded(size_t hCryptProv, uint dwEncodingType, char* pbSignerInfo, 
                                           uint cbSignerInfo, char* pbSignerInfoCountersignature, 
                                           uint cbSignerInfoCountersignature, CERT_INFO* pciCountersigner);

@DllImport("CRYPT32")
BOOL CryptMsgVerifyCountersignatureEncodedEx(size_t hCryptProv, uint dwEncodingType, char* pbSignerInfo, 
                                             uint cbSignerInfo, char* pbSignerInfoCountersignature, 
                                             uint cbSignerInfoCountersignature, uint dwSignerType, void* pvSigner, 
                                             uint dwFlags, void* pvExtra);

@DllImport("CRYPT32")
BOOL CryptMsgCountersign(void* hCryptMsg, uint dwIndex, uint cCountersigners, char* rgCountersigners);

@DllImport("CRYPT32")
BOOL CryptMsgCountersignEncoded(uint dwEncodingType, char* pbSignerInfo, uint cbSignerInfo, uint cCountersigners, 
                                char* rgCountersigners, char* pbCountersignature, uint* pcbCountersignature);

@DllImport("CRYPT32")
void* CertOpenStore(const(char)* lpszStoreProvider, uint dwEncodingType, size_t hCryptProv, uint dwFlags, 
                    const(void)* pvPara);

@DllImport("CRYPT32")
void* CertDuplicateStore(void* hCertStore);

@DllImport("CRYPT32")
BOOL CertSaveStore(void* hCertStore, uint dwEncodingType, uint dwSaveAs, uint dwSaveTo, void* pvSaveToPara, 
                   uint dwFlags);

@DllImport("CRYPT32")
BOOL CertCloseStore(void* hCertStore, uint dwFlags);

@DllImport("CRYPT32")
CERT_CONTEXT* CertGetSubjectCertificateFromStore(void* hCertStore, uint dwCertEncodingType, CERT_INFO* pCertId);

@DllImport("CRYPT32")
CERT_CONTEXT* CertEnumCertificatesInStore(void* hCertStore, CERT_CONTEXT* pPrevCertContext);

@DllImport("CRYPT32")
CERT_CONTEXT* CertFindCertificateInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, 
                                         uint dwFindType, const(void)* pvFindPara, CERT_CONTEXT* pPrevCertContext);

@DllImport("CRYPT32")
CERT_CONTEXT* CertGetIssuerCertificateFromStore(void* hCertStore, CERT_CONTEXT* pSubjectContext, 
                                                CERT_CONTEXT* pPrevIssuerContext, uint* pdwFlags);

@DllImport("CRYPT32")
BOOL CertVerifySubjectCertificateContext(CERT_CONTEXT* pSubject, CERT_CONTEXT* pIssuer, uint* pdwFlags);

@DllImport("CRYPT32")
CERT_CONTEXT* CertDuplicateCertificateContext(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32")
CERT_CONTEXT* CertCreateCertificateContext(uint dwCertEncodingType, char* pbCertEncoded, uint cbCertEncoded);

@DllImport("CRYPT32")
BOOL CertFreeCertificateContext(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32")
BOOL CertSetCertificateContextProperty(CERT_CONTEXT* pCertContext, uint dwPropId, uint dwFlags, 
                                       const(void)* pvData);

@DllImport("CRYPT32")
BOOL CertGetCertificateContextProperty(CERT_CONTEXT* pCertContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
uint CertEnumCertificateContextProperties(CERT_CONTEXT* pCertContext, uint dwPropId);

@DllImport("CRYPT32")
BOOL CertCreateCTLEntryFromCertificateContextProperties(CERT_CONTEXT* pCertContext, uint cOptAttr, char* rgOptAttr, 
                                                        uint dwFlags, void* pvReserved, char* pCtlEntry, 
                                                        uint* pcbCtlEntry);

@DllImport("CRYPT32")
BOOL CertSetCertificateContextPropertiesFromCTLEntry(CERT_CONTEXT* pCertContext, CTL_ENTRY* pCtlEntry, 
                                                     uint dwFlags);

@DllImport("CRYPT32")
CRL_CONTEXT* CertGetCRLFromStore(void* hCertStore, CERT_CONTEXT* pIssuerContext, CRL_CONTEXT* pPrevCrlContext, 
                                 uint* pdwFlags);

@DllImport("CRYPT32")
CRL_CONTEXT* CertEnumCRLsInStore(void* hCertStore, CRL_CONTEXT* pPrevCrlContext);

@DllImport("CRYPT32")
CRL_CONTEXT* CertFindCRLInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, uint dwFindType, 
                                const(void)* pvFindPara, CRL_CONTEXT* pPrevCrlContext);

@DllImport("CRYPT32")
CRL_CONTEXT* CertDuplicateCRLContext(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32")
CRL_CONTEXT* CertCreateCRLContext(uint dwCertEncodingType, char* pbCrlEncoded, uint cbCrlEncoded);

@DllImport("CRYPT32")
BOOL CertFreeCRLContext(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32")
BOOL CertSetCRLContextProperty(CRL_CONTEXT* pCrlContext, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32")
BOOL CertGetCRLContextProperty(CRL_CONTEXT* pCrlContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
uint CertEnumCRLContextProperties(CRL_CONTEXT* pCrlContext, uint dwPropId);

@DllImport("CRYPT32")
BOOL CertFindCertificateInCRL(CERT_CONTEXT* pCert, CRL_CONTEXT* pCrlContext, uint dwFlags, void* pvReserved, 
                              CRL_ENTRY** ppCrlEntry);

@DllImport("CRYPT32")
BOOL CertIsValidCRLForCertificate(CERT_CONTEXT* pCert, CRL_CONTEXT* pCrl, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32")
BOOL CertAddEncodedCertificateToStore(void* hCertStore, uint dwCertEncodingType, char* pbCertEncoded, 
                                      uint cbCertEncoded, uint dwAddDisposition, CERT_CONTEXT** ppCertContext);

@DllImport("CRYPT32")
BOOL CertAddCertificateContextToStore(void* hCertStore, CERT_CONTEXT* pCertContext, uint dwAddDisposition, 
                                      CERT_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertAddSerializedElementToStore(void* hCertStore, char* pbElement, uint cbElement, uint dwAddDisposition, 
                                     uint dwFlags, uint dwContextTypeFlags, uint* pdwContextType, 
                                     const(void)** ppvContext);

@DllImport("CRYPT32")
BOOL CertDeleteCertificateFromStore(CERT_CONTEXT* pCertContext);

@DllImport("CRYPT32")
BOOL CertAddEncodedCRLToStore(void* hCertStore, uint dwCertEncodingType, char* pbCrlEncoded, uint cbCrlEncoded, 
                              uint dwAddDisposition, CRL_CONTEXT** ppCrlContext);

@DllImport("CRYPT32")
BOOL CertAddCRLContextToStore(void* hCertStore, CRL_CONTEXT* pCrlContext, uint dwAddDisposition, 
                              CRL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertDeleteCRLFromStore(CRL_CONTEXT* pCrlContext);

@DllImport("CRYPT32")
BOOL CertSerializeCertificateStoreElement(CERT_CONTEXT* pCertContext, uint dwFlags, char* pbElement, 
                                          uint* pcbElement);

@DllImport("CRYPT32")
BOOL CertSerializeCRLStoreElement(CRL_CONTEXT* pCrlContext, uint dwFlags, char* pbElement, uint* pcbElement);

@DllImport("CRYPT32")
CTL_CONTEXT* CertDuplicateCTLContext(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32")
CTL_CONTEXT* CertCreateCTLContext(uint dwMsgAndCertEncodingType, char* pbCtlEncoded, uint cbCtlEncoded);

@DllImport("CRYPT32")
BOOL CertFreeCTLContext(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32")
BOOL CertSetCTLContextProperty(CTL_CONTEXT* pCtlContext, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32")
BOOL CertGetCTLContextProperty(CTL_CONTEXT* pCtlContext, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
uint CertEnumCTLContextProperties(CTL_CONTEXT* pCtlContext, uint dwPropId);

@DllImport("CRYPT32")
CTL_CONTEXT* CertEnumCTLsInStore(void* hCertStore, CTL_CONTEXT* pPrevCtlContext);

@DllImport("CRYPT32")
CTL_ENTRY* CertFindSubjectInCTL(uint dwEncodingType, uint dwSubjectType, void* pvSubject, CTL_CONTEXT* pCtlContext, 
                                uint dwFlags);

@DllImport("CRYPT32")
CTL_CONTEXT* CertFindCTLInStore(void* hCertStore, uint dwMsgAndCertEncodingType, uint dwFindFlags, uint dwFindType, 
                                const(void)* pvFindPara, CTL_CONTEXT* pPrevCtlContext);

@DllImport("CRYPT32")
BOOL CertAddEncodedCTLToStore(void* hCertStore, uint dwMsgAndCertEncodingType, char* pbCtlEncoded, 
                              uint cbCtlEncoded, uint dwAddDisposition, CTL_CONTEXT** ppCtlContext);

@DllImport("CRYPT32")
BOOL CertAddCTLContextToStore(void* hCertStore, CTL_CONTEXT* pCtlContext, uint dwAddDisposition, 
                              CTL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertSerializeCTLStoreElement(CTL_CONTEXT* pCtlContext, uint dwFlags, char* pbElement, uint* pcbElement);

@DllImport("CRYPT32")
BOOL CertDeleteCTLFromStore(CTL_CONTEXT* pCtlContext);

@DllImport("CRYPT32")
BOOL CertAddCertificateLinkToStore(void* hCertStore, CERT_CONTEXT* pCertContext, uint dwAddDisposition, 
                                   CERT_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertAddCRLLinkToStore(void* hCertStore, CRL_CONTEXT* pCrlContext, uint dwAddDisposition, 
                           CRL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertAddCTLLinkToStore(void* hCertStore, CTL_CONTEXT* pCtlContext, uint dwAddDisposition, 
                           CTL_CONTEXT** ppStoreContext);

@DllImport("CRYPT32")
BOOL CertAddStoreToCollection(void* hCollectionStore, void* hSiblingStore, uint dwUpdateFlags, uint dwPriority);

@DllImport("CRYPT32")
void CertRemoveStoreFromCollection(void* hCollectionStore, void* hSiblingStore);

@DllImport("CRYPT32")
BOOL CertControlStore(void* hCertStore, uint dwFlags, uint dwCtrlType, const(void)* pvCtrlPara);

@DllImport("CRYPT32")
BOOL CertSetStoreProperty(void* hCertStore, uint dwPropId, uint dwFlags, const(void)* pvData);

@DllImport("CRYPT32")
BOOL CertGetStoreProperty(void* hCertStore, uint dwPropId, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
void* CertCreateContext(uint dwContextType, uint dwEncodingType, char* pbEncoded, uint cbEncoded, uint dwFlags, 
                        CERT_CREATE_CONTEXT_PARA* pCreatePara);

@DllImport("CRYPT32")
BOOL CertRegisterSystemStore(const(void)* pvSystemStore, uint dwFlags, CERT_SYSTEM_STORE_INFO* pStoreInfo, 
                             void* pvReserved);

@DllImport("CRYPT32")
BOOL CertRegisterPhysicalStore(const(void)* pvSystemStore, uint dwFlags, const(wchar)* pwszStoreName, 
                               CERT_PHYSICAL_STORE_INFO* pStoreInfo, void* pvReserved);

@DllImport("CRYPT32")
BOOL CertUnregisterSystemStore(const(void)* pvSystemStore, uint dwFlags);

@DllImport("CRYPT32")
BOOL CertUnregisterPhysicalStore(const(void)* pvSystemStore, uint dwFlags, const(wchar)* pwszStoreName);

@DllImport("CRYPT32")
BOOL CertEnumSystemStoreLocation(uint dwFlags, void* pvArg, PFN_CERT_ENUM_SYSTEM_STORE_LOCATION pfnEnum);

@DllImport("CRYPT32")
BOOL CertEnumSystemStore(uint dwFlags, void* pvSystemStoreLocationPara, void* pvArg, 
                         PFN_CERT_ENUM_SYSTEM_STORE pfnEnum);

@DllImport("CRYPT32")
BOOL CertEnumPhysicalStore(const(void)* pvSystemStore, uint dwFlags, void* pvArg, 
                           PFN_CERT_ENUM_PHYSICAL_STORE pfnEnum);

@DllImport("CRYPT32")
BOOL CertGetEnhancedKeyUsage(CERT_CONTEXT* pCertContext, uint dwFlags, char* pUsage, uint* pcbUsage);

@DllImport("CRYPT32")
BOOL CertSetEnhancedKeyUsage(CERT_CONTEXT* pCertContext, CTL_USAGE* pUsage);

@DllImport("CRYPT32")
BOOL CertAddEnhancedKeyUsageIdentifier(CERT_CONTEXT* pCertContext, const(char)* pszUsageIdentifier);

@DllImport("CRYPT32")
BOOL CertRemoveEnhancedKeyUsageIdentifier(CERT_CONTEXT* pCertContext, const(char)* pszUsageIdentifier);

@DllImport("CRYPT32")
BOOL CertGetValidUsages(uint cCerts, char* rghCerts, int* cNumOIDs, char* rghOIDs, uint* pcbOIDs);

@DllImport("CRYPT32")
BOOL CryptMsgGetAndVerifySigner(void* hCryptMsg, uint cSignerStore, char* rghSignerStore, uint dwFlags, 
                                CERT_CONTEXT** ppSigner, uint* pdwSignerIndex);

@DllImport("CRYPT32")
BOOL CryptMsgSignCTL(uint dwMsgEncodingType, char* pbCtlContent, uint cbCtlContent, 
                     CMSG_SIGNED_ENCODE_INFO* pSignInfo, uint dwFlags, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32")
BOOL CryptMsgEncodeAndSignCTL(uint dwMsgEncodingType, CTL_INFO* pCtlInfo, CMSG_SIGNED_ENCODE_INFO* pSignInfo, 
                              uint dwFlags, char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32")
BOOL CertFindSubjectInSortedCTL(CRYPTOAPI_BLOB* pSubjectIdentifier, CTL_CONTEXT* pCtlContext, uint dwFlags, 
                                void* pvReserved, CRYPTOAPI_BLOB* pEncodedAttributes);

@DllImport("CRYPT32")
BOOL CertEnumSubjectInSortedCTL(CTL_CONTEXT* pCtlContext, void** ppvNextSubject, 
                                CRYPTOAPI_BLOB* pSubjectIdentifier, CRYPTOAPI_BLOB* pEncodedAttributes);

@DllImport("CRYPT32")
BOOL CertVerifyCTLUsage(uint dwEncodingType, uint dwSubjectType, void* pvSubject, CTL_USAGE* pSubjectUsage, 
                        uint dwFlags, CTL_VERIFY_USAGE_PARA* pVerifyUsagePara, 
                        CTL_VERIFY_USAGE_STATUS* pVerifyUsageStatus);

@DllImport("CRYPT32")
BOOL CertVerifyRevocation(uint dwEncodingType, uint dwRevType, uint cContext, char* rgpvContext, uint dwFlags, 
                          CERT_REVOCATION_PARA* pRevPara, CERT_REVOCATION_STATUS* pRevStatus);

@DllImport("CRYPT32")
BOOL CertCompareIntegerBlob(CRYPTOAPI_BLOB* pInt1, CRYPTOAPI_BLOB* pInt2);

@DllImport("CRYPT32")
BOOL CertCompareCertificate(uint dwCertEncodingType, CERT_INFO* pCertId1, CERT_INFO* pCertId2);

@DllImport("CRYPT32")
BOOL CertCompareCertificateName(uint dwCertEncodingType, CRYPTOAPI_BLOB* pCertName1, CRYPTOAPI_BLOB* pCertName2);

@DllImport("CRYPT32")
BOOL CertIsRDNAttrsInCertificateName(uint dwCertEncodingType, uint dwFlags, CRYPTOAPI_BLOB* pCertName, 
                                     CERT_RDN* pRDN);

@DllImport("CRYPT32")
BOOL CertComparePublicKeyInfo(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pPublicKey1, 
                              CERT_PUBLIC_KEY_INFO* pPublicKey2);

@DllImport("CRYPT32")
uint CertGetPublicKeyLength(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pPublicKey);

@DllImport("CRYPT32")
BOOL CryptVerifyCertificateSignature(size_t hCryptProv, uint dwCertEncodingType, char* pbEncoded, uint cbEncoded, 
                                     CERT_PUBLIC_KEY_INFO* pPublicKey);

@DllImport("CRYPT32")
BOOL CryptVerifyCertificateSignatureEx(size_t hCryptProv, uint dwCertEncodingType, uint dwSubjectType, 
                                       void* pvSubject, uint dwIssuerType, void* pvIssuer, uint dwFlags, 
                                       void* pvExtra);

@DllImport("CRYPT32")
BOOL CertIsStrongHashToSign(CERT_STRONG_SIGN_PARA* pStrongSignPara, const(wchar)* pwszCNGHashAlgid, 
                            CERT_CONTEXT* pSigningCert);

@DllImport("CRYPT32")
BOOL CryptHashToBeSigned(size_t hCryptProv, uint dwCertEncodingType, char* pbEncoded, uint cbEncoded, 
                         char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptHashCertificate(size_t hCryptProv, uint Algid, uint dwFlags, char* pbEncoded, uint cbEncoded, 
                          char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptHashCertificate2(const(wchar)* pwszCNGHashAlgid, uint dwFlags, void* pvReserved, char* pbEncoded, 
                           uint cbEncoded, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptSignCertificate(size_t hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, 
                          char* pbEncodedToBeSigned, uint cbEncodedToBeSigned, 
                          CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, const(void)* pvHashAuxInfo, 
                          char* pbSignature, uint* pcbSignature);

@DllImport("CRYPT32")
BOOL CryptSignAndEncodeCertificate(size_t hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, 
                                   const(char)* lpszStructType, const(void)* pvStructInfo, 
                                   CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, const(void)* pvHashAuxInfo, 
                                   char* pbEncoded, uint* pcbEncoded);

@DllImport("CRYPT32")
int CertVerifyTimeValidity(FILETIME* pTimeToVerify, CERT_INFO* pCertInfo);

@DllImport("CRYPT32")
int CertVerifyCRLTimeValidity(FILETIME* pTimeToVerify, CRL_INFO* pCrlInfo);

@DllImport("CRYPT32")
BOOL CertVerifyValidityNesting(CERT_INFO* pSubjectInfo, CERT_INFO* pIssuerInfo);

@DllImport("CRYPT32")
BOOL CertVerifyCRLRevocation(uint dwCertEncodingType, CERT_INFO* pCertId, uint cCrlInfo, char* rgpCrlInfo);

@DllImport("CRYPT32")
byte* CertAlgIdToOID(uint dwAlgId);

@DllImport("CRYPT32")
uint CertOIDToAlgId(const(char)* pszObjId);

@DllImport("CRYPT32")
CERT_EXTENSION* CertFindExtension(const(char)* pszObjId, uint cExtensions, char* rgExtensions);

@DllImport("CRYPT32")
CRYPT_ATTRIBUTE* CertFindAttribute(const(char)* pszObjId, uint cAttr, char* rgAttr);

@DllImport("CRYPT32")
CERT_RDN_ATTR* CertFindRDNAttr(const(char)* pszObjId, CERT_NAME_INFO* pName);

@DllImport("CRYPT32")
BOOL CertGetIntendedKeyUsage(uint dwCertEncodingType, CERT_INFO* pCertInfo, char* pbKeyUsage, uint cbKeyUsage);

@DllImport("CRYPT32")
BOOL CryptInstallDefaultContext(size_t hCryptProv, uint dwDefaultType, const(void)* pvDefaultPara, uint dwFlags, 
                                void* pvReserved, void** phDefaultContext);

@DllImport("CRYPT32")
BOOL CryptUninstallDefaultContext(void* hDefaultContext, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32")
BOOL CryptExportPublicKeyInfo(size_t hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, char* pInfo, 
                              uint* pcbInfo);

@DllImport("CRYPT32")
BOOL CryptExportPublicKeyInfoEx(size_t hCryptProvOrNCryptKey, uint dwKeySpec, uint dwCertEncodingType, 
                                const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, char* pInfo, 
                                uint* pcbInfo);

@DllImport("CRYPT32")
BOOL CryptExportPublicKeyInfoFromBCryptKeyHandle(void* hBCryptKey, uint dwCertEncodingType, 
                                                 const(char)* pszPublicKeyObjId, uint dwFlags, void* pvAuxInfo, 
                                                 char* pInfo, uint* pcbInfo);

@DllImport("CRYPT32")
BOOL CryptImportPublicKeyInfo(size_t hCryptProv, uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, 
                              size_t* phKey);

@DllImport("CRYPT32")
BOOL CryptImportPublicKeyInfoEx(size_t hCryptProv, uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, 
                                uint aiKeyAlg, uint dwFlags, void* pvAuxInfo, size_t* phKey);

@DllImport("CRYPT32")
BOOL CryptImportPublicKeyInfoEx2(uint dwCertEncodingType, CERT_PUBLIC_KEY_INFO* pInfo, uint dwFlags, 
                                 void* pvAuxInfo, void** phKey);

@DllImport("CRYPT32")
BOOL CryptAcquireCertificatePrivateKey(CERT_CONTEXT* pCert, uint dwFlags, void* pvParameters, 
                                       size_t* phCryptProvOrNCryptKey, uint* pdwKeySpec, 
                                       int* pfCallerFreeProvOrNCryptKey);

@DllImport("CRYPT32")
BOOL CryptFindCertificateKeyProvInfo(CERT_CONTEXT* pCert, uint dwFlags, void* pvReserved);

@DllImport("CRYPT32")
BOOL CryptImportPKCS8(CRYPT_PKCS8_IMPORT_PARAMS sPrivateKeyAndParams, uint dwFlags, size_t* phCryptProv, 
                      void* pvAuxInfo);

@DllImport("CRYPT32")
BOOL CryptExportPKCS8(size_t hCryptProv, uint dwKeySpec, const(char)* pszPrivateKeyObjId, uint dwFlags, 
                      void* pvAuxInfo, char* pbPrivateKeyBlob, uint* pcbPrivateKeyBlob);

@DllImport("CRYPT32")
BOOL CryptHashPublicKeyInfo(size_t hCryptProv, uint Algid, uint dwFlags, uint dwCertEncodingType, 
                            CERT_PUBLIC_KEY_INFO* pInfo, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
uint CertRDNValueToStrA(uint dwValueType, CRYPTOAPI_BLOB* pValue, const(char)* psz, uint csz);

@DllImport("CRYPT32")
uint CertRDNValueToStrW(uint dwValueType, CRYPTOAPI_BLOB* pValue, const(wchar)* psz, uint csz);

@DllImport("CRYPT32")
uint CertNameToStrA(uint dwCertEncodingType, CRYPTOAPI_BLOB* pName, uint dwStrType, const(char)* psz, uint csz);

@DllImport("CRYPT32")
uint CertNameToStrW(uint dwCertEncodingType, CRYPTOAPI_BLOB* pName, uint dwStrType, const(wchar)* psz, uint csz);

@DllImport("CRYPT32")
BOOL CertStrToNameA(uint dwCertEncodingType, const(char)* pszX500, uint dwStrType, void* pvReserved, 
                    char* pbEncoded, uint* pcbEncoded, byte** ppszError);

@DllImport("CRYPT32")
BOOL CertStrToNameW(uint dwCertEncodingType, const(wchar)* pszX500, uint dwStrType, void* pvReserved, 
                    char* pbEncoded, uint* pcbEncoded, ushort** ppszError);

@DllImport("CRYPT32")
uint CertGetNameStringA(CERT_CONTEXT* pCertContext, uint dwType, uint dwFlags, void* pvTypePara, 
                        const(char)* pszNameString, uint cchNameString);

@DllImport("CRYPT32")
uint CertGetNameStringW(CERT_CONTEXT* pCertContext, uint dwType, uint dwFlags, void* pvTypePara, 
                        const(wchar)* pszNameString, uint cchNameString);

@DllImport("CRYPT32")
BOOL CryptSignMessage(CRYPT_SIGN_MESSAGE_PARA* pSignPara, BOOL fDetachedSignature, uint cToBeSigned, 
                      char* rgpbToBeSigned, char* rgcbToBeSigned, char* pbSignedBlob, uint* pcbSignedBlob);

@DllImport("CRYPT32")
BOOL CryptVerifyMessageSignature(CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbSignedBlob, 
                                 uint cbSignedBlob, char* pbDecoded, uint* pcbDecoded, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32")
int CryptGetMessageSignerCount(uint dwMsgEncodingType, char* pbSignedBlob, uint cbSignedBlob);

@DllImport("CRYPT32")
void* CryptGetMessageCertificates(uint dwMsgAndCertEncodingType, size_t hCryptProv, uint dwFlags, 
                                  char* pbSignedBlob, uint cbSignedBlob);

@DllImport("CRYPT32")
BOOL CryptVerifyDetachedMessageSignature(CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, 
                                         char* pbDetachedSignBlob, uint cbDetachedSignBlob, uint cToBeSigned, 
                                         char* rgpbToBeSigned, char* rgcbToBeSigned, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32")
BOOL CryptEncryptMessage(CRYPT_ENCRYPT_MESSAGE_PARA* pEncryptPara, uint cRecipientCert, char* rgpRecipientCert, 
                         char* pbToBeEncrypted, uint cbToBeEncrypted, char* pbEncryptedBlob, uint* pcbEncryptedBlob);

@DllImport("CRYPT32")
BOOL CryptDecryptMessage(CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, char* pbEncryptedBlob, uint cbEncryptedBlob, 
                         char* pbDecrypted, uint* pcbDecrypted, CERT_CONTEXT** ppXchgCert);

@DllImport("CRYPT32")
BOOL CryptSignAndEncryptMessage(CRYPT_SIGN_MESSAGE_PARA* pSignPara, CRYPT_ENCRYPT_MESSAGE_PARA* pEncryptPara, 
                                uint cRecipientCert, char* rgpRecipientCert, char* pbToBeSignedAndEncrypted, 
                                uint cbToBeSignedAndEncrypted, char* pbSignedAndEncryptedBlob, 
                                uint* pcbSignedAndEncryptedBlob);

@DllImport("CRYPT32")
BOOL CryptDecryptAndVerifyMessageSignature(CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, 
                                           CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, 
                                           char* pbEncryptedBlob, uint cbEncryptedBlob, char* pbDecrypted, 
                                           uint* pcbDecrypted, CERT_CONTEXT** ppXchgCert, 
                                           CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32")
BOOL CryptDecodeMessage(uint dwMsgTypeFlags, CRYPT_DECRYPT_MESSAGE_PARA* pDecryptPara, 
                        CRYPT_VERIFY_MESSAGE_PARA* pVerifyPara, uint dwSignerIndex, char* pbEncodedBlob, 
                        uint cbEncodedBlob, uint dwPrevInnerContentType, uint* pdwMsgType, uint* pdwInnerContentType, 
                        char* pbDecoded, uint* pcbDecoded, CERT_CONTEXT** ppXchgCert, CERT_CONTEXT** ppSignerCert);

@DllImport("CRYPT32")
BOOL CryptHashMessage(CRYPT_HASH_MESSAGE_PARA* pHashPara, BOOL fDetachedHash, uint cToBeHashed, 
                      char* rgpbToBeHashed, char* rgcbToBeHashed, char* pbHashedBlob, uint* pcbHashedBlob, 
                      char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptVerifyMessageHash(CRYPT_HASH_MESSAGE_PARA* pHashPara, char* pbHashedBlob, uint cbHashedBlob, 
                            char* pbToBeHashed, uint* pcbToBeHashed, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptVerifyDetachedMessageHash(CRYPT_HASH_MESSAGE_PARA* pHashPara, char* pbDetachedHashBlob, 
                                    uint cbDetachedHashBlob, uint cToBeHashed, char* rgpbToBeHashed, 
                                    char* rgcbToBeHashed, char* pbComputedHash, uint* pcbComputedHash);

@DllImport("CRYPT32")
BOOL CryptSignMessageWithKey(CRYPT_KEY_SIGN_MESSAGE_PARA* pSignPara, char* pbToBeSigned, uint cbToBeSigned, 
                             char* pbSignedBlob, uint* pcbSignedBlob);

@DllImport("CRYPT32")
BOOL CryptVerifyMessageSignatureWithKey(CRYPT_KEY_VERIFY_MESSAGE_PARA* pVerifyPara, 
                                        CERT_PUBLIC_KEY_INFO* pPublicKeyInfo, char* pbSignedBlob, uint cbSignedBlob, 
                                        char* pbDecoded, uint* pcbDecoded);

@DllImport("CRYPT32")
void* CertOpenSystemStoreA(size_t hProv, const(char)* szSubsystemProtocol);

@DllImport("CRYPT32")
void* CertOpenSystemStoreW(size_t hProv, const(wchar)* szSubsystemProtocol);

@DllImport("CRYPT32")
BOOL CertAddEncodedCertificateToSystemStoreA(const(char)* szCertStoreName, char* pbCertEncoded, uint cbCertEncoded);

@DllImport("CRYPT32")
BOOL CertAddEncodedCertificateToSystemStoreW(const(wchar)* szCertStoreName, char* pbCertEncoded, 
                                             uint cbCertEncoded);

@DllImport("WINTRUST")
HRESULT FindCertsByIssuer(char* pCertChains, uint* pcbCertChains, uint* pcCertChains, char* pbEncodedIssuerName, 
                          uint cbEncodedIssuerName, const(wchar)* pwszPurpose, uint dwKeySpec);

@DllImport("CRYPT32")
BOOL CryptQueryObject(uint dwObjectType, const(void)* pvObject, uint dwExpectedContentTypeFlags, 
                      uint dwExpectedFormatTypeFlags, uint dwFlags, uint* pdwMsgAndCertEncodingType, 
                      uint* pdwContentType, uint* pdwFormatType, void** phCertStore, void** phMsg, 
                      const(void)** ppvContext);

@DllImport("CRYPT32")
void* CryptMemAlloc(uint cbSize);

@DllImport("CRYPT32")
void* CryptMemRealloc(void* pv, uint cbSize);

@DllImport("CRYPT32")
void CryptMemFree(void* pv);

@DllImport("CRYPT32")
BOOL CryptCreateAsyncHandle(uint dwFlags, HCRYPTASYNC* phAsync);

@DllImport("CRYPT32")
BOOL CryptSetAsyncParam(HCRYPTASYNC hAsync, const(char)* pszParamOid, void* pvParam, 
                        PFN_CRYPT_ASYNC_PARAM_FREE_FUNC pfnFree);

@DllImport("CRYPT32")
BOOL CryptGetAsyncParam(HCRYPTASYNC hAsync, const(char)* pszParamOid, void** ppvParam, 
                        PFN_CRYPT_ASYNC_PARAM_FREE_FUNC* ppfnFree);

@DllImport("CRYPT32")
BOOL CryptCloseAsyncHandle(HCRYPTASYNC hAsync);

@DllImport("CRYPTNET")
BOOL CryptRetrieveObjectByUrlA(const(char)* pszUrl, const(char)* pszObjectOid, uint dwRetrievalFlags, 
                               uint dwTimeout, void** ppvObject, HCRYPTASYNC hAsyncRetrieve, 
                               CRYPT_CREDENTIALS* pCredentials, void* pvVerify, CRYPT_RETRIEVE_AUX_INFO* pAuxInfo);

@DllImport("CRYPTNET")
BOOL CryptRetrieveObjectByUrlW(const(wchar)* pszUrl, const(char)* pszObjectOid, uint dwRetrievalFlags, 
                               uint dwTimeout, void** ppvObject, HCRYPTASYNC hAsyncRetrieve, 
                               CRYPT_CREDENTIALS* pCredentials, void* pvVerify, CRYPT_RETRIEVE_AUX_INFO* pAuxInfo);

@DllImport("CRYPTNET")
BOOL CryptInstallCancelRetrieval(PFN_CRYPT_CANCEL_RETRIEVAL pfnCancel, const(void)* pvArg, uint dwFlags, 
                                 void* pvReserved);

@DllImport("CRYPTNET")
BOOL CryptUninstallCancelRetrieval(uint dwFlags, void* pvReserved);

@DllImport("CRYPTNET")
BOOL CryptGetObjectUrl(const(char)* pszUrlOid, void* pvPara, uint dwFlags, char* pUrlArray, uint* pcbUrlArray, 
                       char* pUrlInfo, uint* pcbUrlInfo, void* pvReserved);

@DllImport("CRYPT32")
CERT_CONTEXT* CertCreateSelfSignCertificate(size_t hCryptProvOrNCryptKey, CRYPTOAPI_BLOB* pSubjectIssuerBlob, 
                                            uint dwFlags, CRYPT_KEY_PROV_INFO* pKeyProvInfo, 
                                            CRYPT_ALGORITHM_IDENTIFIER* pSignatureAlgorithm, SYSTEMTIME* pStartTime, 
                                            SYSTEMTIME* pEndTime, CERT_EXTENSIONS* pExtensions);

@DllImport("CRYPT32")
BOOL CryptGetKeyIdentifierProperty(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, 
                                   const(wchar)* pwszComputerName, void* pvReserved, char* pvData, uint* pcbData);

@DllImport("CRYPT32")
BOOL CryptSetKeyIdentifierProperty(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, 
                                   const(wchar)* pwszComputerName, void* pvReserved, const(void)* pvData);

@DllImport("CRYPT32")
BOOL CryptEnumKeyIdentifierProperties(const(CRYPTOAPI_BLOB)* pKeyIdentifier, uint dwPropId, uint dwFlags, 
                                      const(wchar)* pwszComputerName, void* pvReserved, void* pvArg, 
                                      PFN_CRYPT_ENUM_KEYID_PROP pfnEnum);

@DllImport("CRYPT32")
BOOL CryptCreateKeyIdentifierFromCSP(uint dwCertEncodingType, const(char)* pszPubKeyOID, char* pPubKeyStruc, 
                                     uint cbPubKeyStruc, uint dwFlags, void* pvReserved, char* pbHash, uint* pcbHash);

@DllImport("CRYPT32")
BOOL CertCreateCertificateChainEngine(CERT_CHAIN_ENGINE_CONFIG* pConfig, HCERTCHAINENGINE* phChainEngine);

@DllImport("CRYPT32")
void CertFreeCertificateChainEngine(HCERTCHAINENGINE hChainEngine);

@DllImport("CRYPT32")
BOOL CertResyncCertificateChainEngine(HCERTCHAINENGINE hChainEngine);

@DllImport("CRYPT32")
BOOL CertGetCertificateChain(HCERTCHAINENGINE hChainEngine, CERT_CONTEXT* pCertContext, FILETIME* pTime, 
                             void* hAdditionalStore, CERT_CHAIN_PARA* pChainPara, uint dwFlags, void* pvReserved, 
                             CERT_CHAIN_CONTEXT** ppChainContext);

@DllImport("CRYPT32")
void CertFreeCertificateChain(CERT_CHAIN_CONTEXT* pChainContext);

@DllImport("CRYPT32")
CERT_CHAIN_CONTEXT* CertDuplicateCertificateChain(CERT_CHAIN_CONTEXT* pChainContext);

@DllImport("CRYPT32")
CERT_CHAIN_CONTEXT* CertFindChainInStore(void* hCertStore, uint dwCertEncodingType, uint dwFindFlags, 
                                         uint dwFindType, const(void)* pvFindPara, 
                                         CERT_CHAIN_CONTEXT* pPrevChainContext);

@DllImport("CRYPT32")
BOOL CertVerifyCertificateChainPolicy(const(char)* pszPolicyOID, CERT_CHAIN_CONTEXT* pChainContext, 
                                      CERT_CHAIN_POLICY_PARA* pPolicyPara, CERT_CHAIN_POLICY_STATUS* pPolicyStatus);

@DllImport("CRYPT32")
BOOL CryptStringToBinaryA(const(char)* pszString, uint cchString, uint dwFlags, char* pbBinary, uint* pcbBinary, 
                          uint* pdwSkip, uint* pdwFlags);

@DllImport("CRYPT32")
BOOL CryptStringToBinaryW(const(wchar)* pszString, uint cchString, uint dwFlags, char* pbBinary, uint* pcbBinary, 
                          uint* pdwSkip, uint* pdwFlags);

@DllImport("CRYPT32")
BOOL CryptBinaryToStringA(char* pbBinary, uint cbBinary, uint dwFlags, const(char)* pszString, uint* pcchString);

@DllImport("CRYPT32")
BOOL CryptBinaryToStringW(char* pbBinary, uint cbBinary, uint dwFlags, const(wchar)* pszString, uint* pcchString);

@DllImport("CRYPT32")
void* PFXImportCertStore(CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32")
BOOL PFXIsPFXBlob(CRYPTOAPI_BLOB* pPFX);

@DllImport("CRYPT32")
BOOL PFXVerifyPassword(CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32")
BOOL PFXExportCertStoreEx(void* hStore, CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, void* pvPara, uint dwFlags);

@DllImport("CRYPT32")
BOOL PFXExportCertStore(void* hStore, CRYPTOAPI_BLOB* pPFX, const(wchar)* szPassword, uint dwFlags);

@DllImport("CRYPT32")
void* CertOpenServerOcspResponse(CERT_CHAIN_CONTEXT* pChainContext, uint dwFlags, 
                                 CERT_SERVER_OCSP_RESPONSE_OPEN_PARA* pOpenPara);

@DllImport("CRYPT32")
void CertAddRefServerOcspResponse(void* hServerOcspResponse);

@DllImport("CRYPT32")
void CertCloseServerOcspResponse(void* hServerOcspResponse, uint dwFlags);

@DllImport("CRYPT32")
CERT_SERVER_OCSP_RESPONSE_CONTEXT* CertGetServerOcspResponseContext(void* hServerOcspResponse, uint dwFlags, 
                                                                    void* pvReserved);

@DllImport("CRYPT32")
void CertAddRefServerOcspResponseContext(CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext);

@DllImport("CRYPT32")
void CertFreeServerOcspResponseContext(CERT_SERVER_OCSP_RESPONSE_CONTEXT* pServerOcspResponseContext);

@DllImport("CRYPT32")
BOOL CertRetrieveLogoOrBiometricInfo(CERT_CONTEXT* pCertContext, const(char)* lpszLogoOrBiometricType, 
                                     uint dwRetrievalFlags, uint dwTimeout, uint dwFlags, void* pvReserved, 
                                     ubyte** ppbData, uint* pcbData, ushort** ppwszMimeType);

@DllImport("CRYPT32")
BOOL CertSelectCertificateChains(GUID* pSelectionContext, uint dwFlags, CERT_SELECT_CHAIN_PARA* pChainParameters, 
                                 uint cCriteria, char* rgpCriteria, void* hStore, uint* pcSelection, 
                                 CERT_CHAIN_CONTEXT*** pprgpSelection);

@DllImport("CRYPT32")
void CertFreeCertificateChainList(CERT_CHAIN_CONTEXT** prgpSelection);

@DllImport("CRYPT32")
BOOL CryptRetrieveTimeStamp(const(wchar)* wszUrl, uint dwRetrievalFlags, uint dwTimeout, const(char)* pszHashId, 
                            const(CRYPT_TIMESTAMP_PARA)* pPara, char* pbData, uint cbData, 
                            CRYPT_TIMESTAMP_CONTEXT** ppTsContext, CERT_CONTEXT** ppTsSigner, void** phStore);

@DllImport("CRYPT32")
BOOL CryptVerifyTimeStampSignature(char* pbTSContentInfo, uint cbTSContentInfo, char* pbData, uint cbData, 
                                   void* hAdditionalStore, CRYPT_TIMESTAMP_CONTEXT** ppTsContext, 
                                   CERT_CONTEXT** ppTsSigner, void** phStore);

@DllImport("CRYPT32")
BOOL CertIsWeakHash(uint dwHashUseType, const(wchar)* pwszCNGHashAlgid, uint dwChainFlags, 
                    CERT_CHAIN_CONTEXT* pSignerChainContext, FILETIME* pTimeStamp, const(wchar)* pwszFileName);

@DllImport("CRYPT32")
BOOL CryptProtectData(CRYPTOAPI_BLOB* pDataIn, const(wchar)* szDataDescr, CRYPTOAPI_BLOB* pOptionalEntropy, 
                      void* pvReserved, CRYPTPROTECT_PROMPTSTRUCT* pPromptStruct, uint dwFlags, 
                      CRYPTOAPI_BLOB* pDataOut);

@DllImport("CRYPT32")
BOOL CryptUnprotectData(CRYPTOAPI_BLOB* pDataIn, ushort** ppszDataDescr, CRYPTOAPI_BLOB* pOptionalEntropy, 
                        void* pvReserved, CRYPTPROTECT_PROMPTSTRUCT* pPromptStruct, uint dwFlags, 
                        CRYPTOAPI_BLOB* pDataOut);

@DllImport("CRYPT32")
BOOL CryptUpdateProtectedState(void* pOldSid, const(wchar)* pwszOldPassword, uint dwFlags, uint* pdwSuccessCount, 
                               uint* pdwFailureCount);

@DllImport("CRYPT32")
BOOL CryptProtectMemory(void* pDataIn, uint cbDataIn, uint dwFlags);

@DllImport("CRYPT32")
BOOL CryptUnprotectMemory(void* pDataIn, uint cbDataIn, uint dwFlags);

@DllImport("WinSCard")
int SCardEstablishContext(uint dwScope, void* pvReserved1, void* pvReserved2, size_t* phContext);

@DllImport("WinSCard")
int SCardReleaseContext(size_t hContext);

@DllImport("WinSCard")
int SCardIsValidContext(size_t hContext);

@DllImport("WinSCard")
int SCardListReaderGroupsA(size_t hContext, const(char)* mszGroups, uint* pcchGroups);

@DllImport("WinSCard")
int SCardListReaderGroupsW(size_t hContext, const(wchar)* mszGroups, uint* pcchGroups);

@DllImport("WinSCard")
int SCardListReadersA(size_t hContext, const(char)* mszGroups, const(char)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard")
int SCardListReadersW(size_t hContext, const(wchar)* mszGroups, const(wchar)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard")
int SCardListCardsA(size_t hContext, ubyte* pbAtr, char* rgquidInterfaces, uint cguidInterfaceCount, 
                    char* mszCards, uint* pcchCards);

@DllImport("WinSCard")
int SCardListCardsW(size_t hContext, ubyte* pbAtr, char* rgquidInterfaces, uint cguidInterfaceCount, 
                    char* mszCards, uint* pcchCards);

@DllImport("WinSCard")
int SCardListInterfacesA(size_t hContext, const(char)* szCard, GUID* pguidInterfaces, uint* pcguidInterfaces);

@DllImport("WinSCard")
int SCardListInterfacesW(size_t hContext, const(wchar)* szCard, GUID* pguidInterfaces, uint* pcguidInterfaces);

@DllImport("WinSCard")
int SCardGetProviderIdA(size_t hContext, const(char)* szCard, GUID* pguidProviderId);

@DllImport("WinSCard")
int SCardGetProviderIdW(size_t hContext, const(wchar)* szCard, GUID* pguidProviderId);

@DllImport("WinSCard")
int SCardGetCardTypeProviderNameA(size_t hContext, const(char)* szCardName, uint dwProviderId, char* szProvider, 
                                  uint* pcchProvider);

@DllImport("WinSCard")
int SCardGetCardTypeProviderNameW(size_t hContext, const(wchar)* szCardName, uint dwProviderId, char* szProvider, 
                                  uint* pcchProvider);

@DllImport("WinSCard")
int SCardIntroduceReaderGroupA(size_t hContext, const(char)* szGroupName);

@DllImport("WinSCard")
int SCardIntroduceReaderGroupW(size_t hContext, const(wchar)* szGroupName);

@DllImport("WinSCard")
int SCardForgetReaderGroupA(size_t hContext, const(char)* szGroupName);

@DllImport("WinSCard")
int SCardForgetReaderGroupW(size_t hContext, const(wchar)* szGroupName);

@DllImport("WinSCard")
int SCardIntroduceReaderA(size_t hContext, const(char)* szReaderName, const(char)* szDeviceName);

@DllImport("WinSCard")
int SCardIntroduceReaderW(size_t hContext, const(wchar)* szReaderName, const(wchar)* szDeviceName);

@DllImport("WinSCard")
int SCardForgetReaderA(size_t hContext, const(char)* szReaderName);

@DllImport("WinSCard")
int SCardForgetReaderW(size_t hContext, const(wchar)* szReaderName);

@DllImport("WinSCard")
int SCardAddReaderToGroupA(size_t hContext, const(char)* szReaderName, const(char)* szGroupName);

@DllImport("WinSCard")
int SCardAddReaderToGroupW(size_t hContext, const(wchar)* szReaderName, const(wchar)* szGroupName);

@DllImport("WinSCard")
int SCardRemoveReaderFromGroupA(size_t hContext, const(char)* szReaderName, const(char)* szGroupName);

@DllImport("WinSCard")
int SCardRemoveReaderFromGroupW(size_t hContext, const(wchar)* szReaderName, const(wchar)* szGroupName);

@DllImport("WinSCard")
int SCardIntroduceCardTypeA(size_t hContext, const(char)* szCardName, GUID* pguidPrimaryProvider, 
                            GUID* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, 
                            uint cbAtrLen);

@DllImport("WinSCard")
int SCardIntroduceCardTypeW(size_t hContext, const(wchar)* szCardName, GUID* pguidPrimaryProvider, 
                            GUID* rgguidInterfaces, uint dwInterfaceCount, ubyte* pbAtr, ubyte* pbAtrMask, 
                            uint cbAtrLen);

@DllImport("WinSCard")
int SCardSetCardTypeProviderNameA(size_t hContext, const(char)* szCardName, uint dwProviderId, 
                                  const(char)* szProvider);

@DllImport("WinSCard")
int SCardSetCardTypeProviderNameW(size_t hContext, const(wchar)* szCardName, uint dwProviderId, 
                                  const(wchar)* szProvider);

@DllImport("WinSCard")
int SCardForgetCardTypeA(size_t hContext, const(char)* szCardName);

@DllImport("WinSCard")
int SCardForgetCardTypeW(size_t hContext, const(wchar)* szCardName);

@DllImport("WinSCard")
int SCardFreeMemory(size_t hContext, void* pvMem);

@DllImport("WinSCard")
HANDLE SCardAccessStartedEvent();

@DllImport("WinSCard")
void SCardReleaseStartedEvent();

@DllImport("WinSCard")
int SCardLocateCardsA(size_t hContext, const(char)* mszCards, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardLocateCardsW(size_t hContext, const(wchar)* mszCards, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardLocateCardsByATRA(size_t hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, 
                           SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardLocateCardsByATRW(size_t hContext, SCARD_ATRMASK* rgAtrMasks, uint cAtrs, 
                           SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardGetStatusChangeA(size_t hContext, uint dwTimeout, SCARD_READERSTATEA* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardGetStatusChangeW(size_t hContext, uint dwTimeout, SCARD_READERSTATEW* rgReaderStates, uint cReaders);

@DllImport("WinSCard")
int SCardCancel(size_t hContext);

@DllImport("WinSCard")
int SCardConnectA(size_t hContext, const(char)* szReader, uint dwShareMode, uint dwPreferredProtocols, 
                  size_t* phCard, uint* pdwActiveProtocol);

@DllImport("WinSCard")
int SCardConnectW(size_t hContext, const(wchar)* szReader, uint dwShareMode, uint dwPreferredProtocols, 
                  size_t* phCard, uint* pdwActiveProtocol);

@DllImport("WinSCard")
int SCardReconnect(size_t hCard, uint dwShareMode, uint dwPreferredProtocols, uint dwInitialization, 
                   uint* pdwActiveProtocol);

@DllImport("WinSCard")
int SCardDisconnect(size_t hCard, uint dwDisposition);

@DllImport("WinSCard")
int SCardBeginTransaction(size_t hCard);

@DllImport("WinSCard")
int SCardEndTransaction(size_t hCard, uint dwDisposition);

@DllImport("WinSCard")
int SCardState(size_t hCard, uint* pdwState, uint* pdwProtocol, char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard")
int SCardStatusA(size_t hCard, const(char)* mszReaderNames, uint* pcchReaderLen, uint* pdwState, uint* pdwProtocol, 
                 char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard")
int SCardStatusW(size_t hCard, const(wchar)* mszReaderNames, uint* pcchReaderLen, uint* pdwState, 
                 uint* pdwProtocol, char* pbAtr, uint* pcbAtrLen);

@DllImport("WinSCard")
int SCardTransmit(size_t hCard, SCARD_IO_REQUEST* pioSendPci, char* pbSendBuffer, uint cbSendLength, 
                  SCARD_IO_REQUEST* pioRecvPci, char* pbRecvBuffer, uint* pcbRecvLength);

@DllImport("WinSCard")
int SCardGetTransmitCount(size_t hCard, uint* pcTransmitCount);

@DllImport("WinSCard")
int SCardControl(size_t hCard, uint dwControlCode, char* lpInBuffer, uint cbInBufferSize, char* lpOutBuffer, 
                 uint cbOutBufferSize, uint* lpBytesReturned);

@DllImport("WinSCard")
int SCardGetAttrib(size_t hCard, uint dwAttrId, char* pbAttr, uint* pcbAttrLen);

@DllImport("WinSCard")
int SCardSetAttrib(size_t hCard, uint dwAttrId, char* pbAttr, uint cbAttrLen);

@DllImport("SCARDDLG")
int SCardUIDlgSelectCardA(OPENCARDNAME_EXA* param0);

@DllImport("SCARDDLG")
int SCardUIDlgSelectCardW(OPENCARDNAME_EXW* param0);

@DllImport("SCARDDLG")
int GetOpenCardNameA(OPENCARDNAMEA* param0);

@DllImport("SCARDDLG")
int GetOpenCardNameW(OPENCARDNAMEW* param0);

@DllImport("SCARDDLG")
int SCardDlgExtendedError();

@DllImport("WinSCard")
int SCardReadCacheA(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, const(char)* LookupName, 
                    char* Data, uint* DataLen);

@DllImport("WinSCard")
int SCardReadCacheW(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, const(wchar)* LookupName, 
                    char* Data, uint* DataLen);

@DllImport("WinSCard")
int SCardWriteCacheA(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, const(char)* LookupName, 
                     char* Data, uint DataLen);

@DllImport("WinSCard")
int SCardWriteCacheW(size_t hContext, GUID* CardIdentifier, uint FreshnessCounter, const(wchar)* LookupName, 
                     char* Data, uint DataLen);

@DllImport("WinSCard")
int SCardGetReaderIconA(size_t hContext, const(char)* szReaderName, char* pbIcon, uint* pcbIcon);

@DllImport("WinSCard")
int SCardGetReaderIconW(size_t hContext, const(wchar)* szReaderName, char* pbIcon, uint* pcbIcon);

@DllImport("WinSCard")
int SCardGetDeviceTypeIdA(size_t hContext, const(char)* szReaderName, uint* pdwDeviceTypeId);

@DllImport("WinSCard")
int SCardGetDeviceTypeIdW(size_t hContext, const(wchar)* szReaderName, uint* pdwDeviceTypeId);

@DllImport("WinSCard")
int SCardGetReaderDeviceInstanceIdA(size_t hContext, const(char)* szReaderName, const(char)* szDeviceInstanceId, 
                                    uint* pcchDeviceInstanceId);

@DllImport("WinSCard")
int SCardGetReaderDeviceInstanceIdW(size_t hContext, const(wchar)* szReaderName, const(wchar)* szDeviceInstanceId, 
                                    uint* pcchDeviceInstanceId);

@DllImport("WinSCard")
int SCardListReadersWithDeviceInstanceIdA(size_t hContext, const(char)* szDeviceInstanceId, 
                                          const(char)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard")
int SCardListReadersWithDeviceInstanceIdW(size_t hContext, const(wchar)* szDeviceInstanceId, 
                                          const(wchar)* mszReaders, uint* pcchReaders);

@DllImport("WinSCard")
int SCardAudit(size_t hContext, uint dwEvent);

@DllImport("ADVAPI32")
BOOL ChangeServiceConfig2A(SC_HANDLE__* hService, uint dwInfoLevel, void* lpInfo);

@DllImport("ADVAPI32")
BOOL ChangeServiceConfig2W(SC_HANDLE__* hService, uint dwInfoLevel, void* lpInfo);

@DllImport("ADVAPI32")
BOOL CloseServiceHandle(SC_HANDLE__* hSCObject);

@DllImport("ADVAPI32")
BOOL ControlService(SC_HANDLE__* hService, uint dwControl, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32")
BOOL DeleteService(SC_HANDLE__* hService);

@DllImport("ADVAPI32")
BOOL EnumDependentServicesA(SC_HANDLE__* hService, uint dwServiceState, char* lpServices, uint cbBufSize, 
                            uint* pcbBytesNeeded, uint* lpServicesReturned);

@DllImport("ADVAPI32")
BOOL EnumDependentServicesW(SC_HANDLE__* hService, uint dwServiceState, char* lpServices, uint cbBufSize, 
                            uint* pcbBytesNeeded, uint* lpServicesReturned);

@DllImport("ADVAPI32")
BOOL EnumServicesStatusA(SC_HANDLE__* hSCManager, uint dwServiceType, uint dwServiceState, char* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

@DllImport("ADVAPI32")
BOOL EnumServicesStatusW(SC_HANDLE__* hSCManager, uint dwServiceType, uint dwServiceState, char* lpServices, 
                         uint cbBufSize, uint* pcbBytesNeeded, uint* lpServicesReturned, uint* lpResumeHandle);

@DllImport("ADVAPI32")
BOOL EnumServicesStatusExA(SC_HANDLE__* hSCManager, SC_ENUM_TYPE InfoLevel, uint dwServiceType, 
                           uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, 
                           uint* lpServicesReturned, uint* lpResumeHandle, const(char)* pszGroupName);

@DllImport("ADVAPI32")
BOOL EnumServicesStatusExW(SC_HANDLE__* hSCManager, SC_ENUM_TYPE InfoLevel, uint dwServiceType, 
                           uint dwServiceState, char* lpServices, uint cbBufSize, uint* pcbBytesNeeded, 
                           uint* lpServicesReturned, uint* lpResumeHandle, const(wchar)* pszGroupName);

@DllImport("ADVAPI32")
BOOL GetServiceKeyNameA(SC_HANDLE__* hSCManager, const(char)* lpDisplayName, const(char)* lpServiceName, 
                        uint* lpcchBuffer);

@DllImport("ADVAPI32")
BOOL GetServiceKeyNameW(SC_HANDLE__* hSCManager, const(wchar)* lpDisplayName, const(wchar)* lpServiceName, 
                        uint* lpcchBuffer);

@DllImport("ADVAPI32")
BOOL GetServiceDisplayNameA(SC_HANDLE__* hSCManager, const(char)* lpServiceName, const(char)* lpDisplayName, 
                            uint* lpcchBuffer);

@DllImport("ADVAPI32")
BOOL GetServiceDisplayNameW(SC_HANDLE__* hSCManager, const(wchar)* lpServiceName, const(wchar)* lpDisplayName, 
                            uint* lpcchBuffer);

@DllImport("ADVAPI32")
void* LockServiceDatabase(SC_HANDLE__* hSCManager);

@DllImport("ADVAPI32")
BOOL NotifyBootConfigStatus(BOOL BootAcceptable);

@DllImport("ADVAPI32")
SC_HANDLE__* OpenSCManagerA(const(char)* lpMachineName, const(char)* lpDatabaseName, uint dwDesiredAccess);

@DllImport("ADVAPI32")
SC_HANDLE__* OpenSCManagerW(const(wchar)* lpMachineName, const(wchar)* lpDatabaseName, uint dwDesiredAccess);

@DllImport("ADVAPI32")
SC_HANDLE__* OpenServiceA(SC_HANDLE__* hSCManager, const(char)* lpServiceName, uint dwDesiredAccess);

@DllImport("ADVAPI32")
SC_HANDLE__* OpenServiceW(SC_HANDLE__* hSCManager, const(wchar)* lpServiceName, uint dwDesiredAccess);

@DllImport("ADVAPI32")
BOOL QueryServiceConfigA(SC_HANDLE__* hService, char* lpServiceConfig, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceConfigW(SC_HANDLE__* hService, char* lpServiceConfig, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceConfig2A(SC_HANDLE__* hService, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, 
                          uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceConfig2W(SC_HANDLE__* hService, uint dwInfoLevel, char* lpBuffer, uint cbBufSize, 
                          uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceLockStatusA(SC_HANDLE__* hSCManager, char* lpLockStatus, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceLockStatusW(SC_HANDLE__* hSCManager, char* lpLockStatus, uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceObjectSecurity(SC_HANDLE__* hService, uint dwSecurityInformation, char* lpSecurityDescriptor, 
                                uint cbBufSize, uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
BOOL QueryServiceStatus(SC_HANDLE__* hService, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32")
BOOL QueryServiceStatusEx(SC_HANDLE__* hService, SC_STATUS_TYPE InfoLevel, char* lpBuffer, uint cbBufSize, 
                          uint* pcbBytesNeeded);

@DllImport("ADVAPI32")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerA(const(char)* lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

@DllImport("ADVAPI32")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerW(const(wchar)* lpServiceName, LPHANDLER_FUNCTION lpHandlerProc);

@DllImport("ADVAPI32")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerExA(const(char)* lpServiceName, 
                                                       LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

@DllImport("ADVAPI32")
SERVICE_STATUS_HANDLE__* RegisterServiceCtrlHandlerExW(const(wchar)* lpServiceName, 
                                                       LPHANDLER_FUNCTION_EX lpHandlerProc, void* lpContext);

@DllImport("ADVAPI32")
BOOL SetServiceObjectSecurity(SC_HANDLE__* hService, uint dwSecurityInformation, void* lpSecurityDescriptor);

@DllImport("ADVAPI32")
BOOL SetServiceStatus(SERVICE_STATUS_HANDLE__* hServiceStatus, SERVICE_STATUS* lpServiceStatus);

@DllImport("ADVAPI32")
BOOL StartServiceCtrlDispatcherA(const(SERVICE_TABLE_ENTRYA)* lpServiceStartTable);

@DllImport("ADVAPI32")
BOOL StartServiceCtrlDispatcherW(const(SERVICE_TABLE_ENTRYW)* lpServiceStartTable);

@DllImport("ADVAPI32")
BOOL StartServiceA(SC_HANDLE__* hService, uint dwNumServiceArgs, char* lpServiceArgVectors);

@DllImport("ADVAPI32")
BOOL StartServiceW(SC_HANDLE__* hService, uint dwNumServiceArgs, char* lpServiceArgVectors);

@DllImport("ADVAPI32")
BOOL UnlockServiceDatabase(void* ScLock);

@DllImport("ADVAPI32")
uint NotifyServiceStatusChangeA(SC_HANDLE__* hService, uint dwNotifyMask, SERVICE_NOTIFY_2A* pNotifyBuffer);

@DllImport("ADVAPI32")
uint NotifyServiceStatusChangeW(SC_HANDLE__* hService, uint dwNotifyMask, SERVICE_NOTIFY_2W* pNotifyBuffer);

@DllImport("ADVAPI32")
BOOL ControlServiceExA(SC_HANDLE__* hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

@DllImport("ADVAPI32")
BOOL ControlServiceExW(SC_HANDLE__* hService, uint dwControl, uint dwInfoLevel, void* pControlParams);

@DllImport("ADVAPI32")
BOOL QueryServiceDynamicInformation(SERVICE_STATUS_HANDLE__* hServiceStatus, uint dwInfoLevel, 
                                    void** ppDynamicInfo);

@DllImport("ADVAPI32")
uint WaitServiceState(SC_HANDLE__* hService, uint dwNotify, uint dwTimeout, HANDLE hCancelEvent);

@DllImport("api-ms-win-service-core-l1-1-3")
uint GetServiceRegistryStateKey(SERVICE_STATUS_HANDLE__* ServiceStatusHandle, 
                                SERVICE_REGISTRY_STATE_TYPE StateType, uint AccessMask, HKEY* ServiceStateKey);

@DllImport("api-ms-win-service-core-l1-1-4")
uint GetServiceDirectory(SERVICE_STATUS_HANDLE__* hServiceStatus, SERVICE_DIRECTORY_TYPE eDirectoryType, 
                         const(wchar)* lpPathBuffer, uint cchPathBufferLength, uint* lpcchRequiredBufferLength);

@DllImport("SspiCli")
NTSTATUS LsaRegisterLogonProcess(STRING* LogonProcessName, LsaHandle* LsaHandle, uint* SecurityMode);

@DllImport("SspiCli")
NTSTATUS LsaLogonUser(HANDLE LsaHandle, STRING* OriginName, SECURITY_LOGON_TYPE LogonType, 
                      uint AuthenticationPackage, char* AuthenticationInformation, 
                      uint AuthenticationInformationLength, TOKEN_GROUPS* LocalGroups, TOKEN_SOURCE* SourceContext, 
                      void** ProfileBuffer, uint* ProfileBufferLength, LUID* LogonId, ptrdiff_t* Token, 
                      QUOTA_LIMITS* Quotas, int* SubStatus);

@DllImport("SspiCli")
NTSTATUS LsaLookupAuthenticationPackage(HANDLE LsaHandle, STRING* PackageName, uint* AuthenticationPackage);

@DllImport("SspiCli")
NTSTATUS LsaFreeReturnBuffer(void* Buffer);

@DllImport("SspiCli")
NTSTATUS LsaCallAuthenticationPackage(HANDLE LsaHandle, uint AuthenticationPackage, char* ProtocolSubmitBuffer, 
                                      uint SubmitBufferLength, void** ProtocolReturnBuffer, uint* ReturnBufferLength, 
                                      int* ProtocolStatus);

@DllImport("SspiCli")
NTSTATUS LsaDeregisterLogonProcess(HANDLE LsaHandle);

@DllImport("SspiCli")
NTSTATUS LsaConnectUntrusted(ptrdiff_t* LsaHandle);

@DllImport("ADVAPI32")
NTSTATUS LsaFreeMemory(void* Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaClose(void* ObjectHandle);

@DllImport("SspiCli")
NTSTATUS LsaEnumerateLogonSessions(uint* LogonSessionCount, LUID** LogonSessionList);

@DllImport("SspiCli")
NTSTATUS LsaGetLogonSessionData(LUID* LogonId, SECURITY_LOGON_SESSION_DATA** ppLogonSessionData);

@DllImport("ADVAPI32")
NTSTATUS LsaOpenPolicy(UNICODE_STRING* SystemName, OBJECT_ATTRIBUTES* ObjectAttributes, uint DesiredAccess, 
                       void** PolicyHandle);

@DllImport("ADVAPI32")
NTSTATUS LsaSetCAPs(char* CAPDNs, uint CAPDNCount, uint Flags);

@DllImport("ADVAPI32")
NTSTATUS LsaGetAppliedCAPIDs(UNICODE_STRING* SystemName, void*** CAPIDs, uint* CAPIDCount);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryCAPs(char* CAPIDs, uint CAPIDCount, CENTRAL_ACCESS_POLICY** CAPs, uint* CAPCount);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryInformationPolicy(void* PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaSetInformationPolicy(void* PolicyHandle, POLICY_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryDomainInformationPolicy(void* PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, 
                                         void** Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaSetDomainInformationPolicy(void* PolicyHandle, POLICY_DOMAIN_INFORMATION_CLASS InformationClass, 
                                       void* Buffer);

@DllImport("SspiCli")
NTSTATUS LsaRegisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, 
                                             HANDLE NotificationEventHandle);

@DllImport("SspiCli")
NTSTATUS LsaUnregisterPolicyChangeNotification(POLICY_NOTIFICATION_INFORMATION_CLASS InformationClass, 
                                               HANDLE NotificationEventHandle);

@DllImport("ADVAPI32")
NTSTATUS LsaEnumerateTrustedDomains(void* PolicyHandle, uint* EnumerationContext, void** Buffer, 
                                    uint PreferedMaximumLength, uint* CountReturned);

@DllImport("ADVAPI32")
NTSTATUS LsaLookupNames(void* PolicyHandle, uint Count, UNICODE_STRING* Names, 
                        LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID** Sids);

@DllImport("ADVAPI32")
NTSTATUS LsaLookupNames2(void* PolicyHandle, uint Flags, uint Count, UNICODE_STRING* Names, 
                         LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_SID2** Sids);

@DllImport("ADVAPI32")
NTSTATUS LsaLookupSids(void* PolicyHandle, uint Count, void** Sids, LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, 
                       LSA_TRANSLATED_NAME** Names);

@DllImport("ADVAPI32")
NTSTATUS LsaLookupSids2(void* PolicyHandle, uint LookupOptions, uint Count, void** Sids, 
                        LSA_REFERENCED_DOMAIN_LIST** ReferencedDomains, LSA_TRANSLATED_NAME** Names);

@DllImport("ADVAPI32")
NTSTATUS LsaEnumerateAccountsWithUserRight(void* PolicyHandle, UNICODE_STRING* UserRight, void** Buffer, 
                                           uint* CountReturned);

@DllImport("ADVAPI32")
NTSTATUS LsaEnumerateAccountRights(void* PolicyHandle, void* AccountSid, UNICODE_STRING** UserRights, 
                                   uint* CountOfRights);

@DllImport("ADVAPI32")
NTSTATUS LsaAddAccountRights(void* PolicyHandle, void* AccountSid, char* UserRights, uint CountOfRights);

@DllImport("ADVAPI32")
NTSTATUS LsaRemoveAccountRights(void* PolicyHandle, void* AccountSid, ubyte AllRights, char* UserRights, 
                                uint CountOfRights);

@DllImport("ADVAPI32")
NTSTATUS LsaOpenTrustedDomainByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, uint DesiredAccess, 
                                    void** TrustedDomainHandle);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryTrustedDomainInfo(void* PolicyHandle, void* TrustedDomainSid, 
                                   TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaSetTrustedDomainInformation(void* PolicyHandle, void* TrustedDomainSid, 
                                        TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaDeleteTrustedDomain(void* PolicyHandle, void* TrustedDomainSid);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryTrustedDomainInfoByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, 
                                         TRUSTED_INFORMATION_CLASS InformationClass, void** Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaSetTrustedDomainInfoByName(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, 
                                       TRUSTED_INFORMATION_CLASS InformationClass, void* Buffer);

@DllImport("ADVAPI32")
NTSTATUS LsaEnumerateTrustedDomainsEx(void* PolicyHandle, uint* EnumerationContext, void** Buffer, 
                                      uint PreferedMaximumLength, uint* CountReturned);

@DllImport("ADVAPI32")
NTSTATUS LsaCreateTrustedDomainEx(void* PolicyHandle, TRUSTED_DOMAIN_INFORMATION_EX* TrustedDomainInformation, 
                                  TRUSTED_DOMAIN_AUTH_INFORMATION* AuthenticationInformation, uint DesiredAccess, 
                                  void** TrustedDomainHandle);

@DllImport("ADVAPI32")
NTSTATUS LsaQueryForestTrustInformation(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, 
                                        LSA_FOREST_TRUST_INFORMATION** ForestTrustInfo);

@DllImport("ADVAPI32")
NTSTATUS LsaSetForestTrustInformation(void* PolicyHandle, UNICODE_STRING* TrustedDomainName, 
                                      LSA_FOREST_TRUST_INFORMATION* ForestTrustInfo, ubyte CheckOnly, 
                                      LSA_FOREST_TRUST_COLLISION_INFORMATION** CollisionInfo);

@DllImport("ADVAPI32")
NTSTATUS LsaStorePrivateData(void* PolicyHandle, UNICODE_STRING* KeyName, UNICODE_STRING* PrivateData);

@DllImport("ADVAPI32")
NTSTATUS LsaRetrievePrivateData(void* PolicyHandle, UNICODE_STRING* KeyName, UNICODE_STRING** PrivateData);

@DllImport("ADVAPI32")
uint LsaNtStatusToWinError(NTSTATUS Status);

@DllImport("ADVAPI32")
ubyte SystemFunction036(char* RandomBuffer, uint RandomBufferLength);

@DllImport("ADVAPI32")
NTSTATUS SystemFunction040(char* Memory, uint MemorySize, uint OptionFlags);

@DllImport("ADVAPI32")
NTSTATUS SystemFunction041(char* Memory, uint MemorySize, uint OptionFlags);

@DllImport("ADVAPI32")
ubyte AuditSetSystemPolicy(char* pAuditPolicy, uint dwPolicyCount);

@DllImport("ADVAPI32")
ubyte AuditSetPerUserPolicy(const(void)* pSid, char* pAuditPolicy, uint dwPolicyCount);

@DllImport("ADVAPI32")
ubyte AuditQuerySystemPolicy(char* pSubCategoryGuids, uint dwPolicyCount, AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32")
ubyte AuditQueryPerUserPolicy(const(void)* pSid, char* pSubCategoryGuids, uint dwPolicyCount, 
                              AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32")
ubyte AuditEnumeratePerUserPolicy(POLICY_AUDIT_SID_ARRAY** ppAuditSidArray);

@DllImport("ADVAPI32")
ubyte AuditComputeEffectivePolicyBySid(const(void)* pSid, char* pSubCategoryGuids, uint dwPolicyCount, 
                                       AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32")
ubyte AuditComputeEffectivePolicyByToken(HANDLE hTokenHandle, char* pSubCategoryGuids, uint dwPolicyCount, 
                                         AUDIT_POLICY_INFORMATION** ppAuditPolicy);

@DllImport("ADVAPI32")
ubyte AuditEnumerateCategories(GUID** ppAuditCategoriesArray, uint* pdwCountReturned);

@DllImport("ADVAPI32")
ubyte AuditEnumerateSubCategories(const(GUID)* pAuditCategoryGuid, ubyte bRetrieveAllSubCategories, 
                                  GUID** ppAuditSubCategoriesArray, uint* pdwCountReturned);

@DllImport("ADVAPI32")
ubyte AuditLookupCategoryNameW(const(GUID)* pAuditCategoryGuid, ushort** ppszCategoryName);

@DllImport("ADVAPI32")
ubyte AuditLookupCategoryNameA(const(GUID)* pAuditCategoryGuid, byte** ppszCategoryName);

@DllImport("ADVAPI32")
ubyte AuditLookupSubCategoryNameW(const(GUID)* pAuditSubCategoryGuid, ushort** ppszSubCategoryName);

@DllImport("ADVAPI32")
ubyte AuditLookupSubCategoryNameA(const(GUID)* pAuditSubCategoryGuid, byte** ppszSubCategoryName);

@DllImport("ADVAPI32")
ubyte AuditLookupCategoryIdFromCategoryGuid(const(GUID)* pAuditCategoryGuid, 
                                            POLICY_AUDIT_EVENT_TYPE* pAuditCategoryId);

@DllImport("ADVAPI32")
ubyte AuditLookupCategoryGuidFromCategoryId(POLICY_AUDIT_EVENT_TYPE AuditCategoryId, GUID* pAuditCategoryGuid);

@DllImport("ADVAPI32")
ubyte AuditSetSecurity(uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32")
ubyte AuditQuerySecurity(uint SecurityInformation, void** ppSecurityDescriptor);

@DllImport("ADVAPI32")
ubyte AuditSetGlobalSaclW(const(wchar)* ObjectTypeName, ACL* Acl);

@DllImport("ADVAPI32")
ubyte AuditSetGlobalSaclA(const(char)* ObjectTypeName, ACL* Acl);

@DllImport("ADVAPI32")
ubyte AuditQueryGlobalSaclW(const(wchar)* ObjectTypeName, ACL** Acl);

@DllImport("ADVAPI32")
ubyte AuditQueryGlobalSaclA(const(char)* ObjectTypeName, ACL** Acl);

@DllImport("ADVAPI32")
void AuditFree(void* Buffer);

@DllImport("SspiCli")
int AcquireCredentialsHandleW(const(wchar)* pszPrincipal, const(wchar)* pszPackage, uint fCredentialUse, 
                              void* pvLogonId, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                              SecHandle* phCredential, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int AcquireCredentialsHandleA(const(char)* pszPrincipal, const(char)* pszPackage, uint fCredentialUse, 
                              void* pvLogonId, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                              SecHandle* phCredential, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int FreeCredentialsHandle(SecHandle* phCredential);

@DllImport("SspiCli")
int AddCredentialsW(SecHandle* hCredentials, const(wchar)* pszPrincipal, const(wchar)* pszPackage, 
                    uint fCredentialUse, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                    LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int AddCredentialsA(SecHandle* hCredentials, const(char)* pszPrincipal, const(char)* pszPackage, 
                    uint fCredentialUse, void* pAuthData, SEC_GET_KEY_FN pGetKeyFn, void* pvGetKeyArgument, 
                    LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int ChangeAccountPasswordW(ushort* pszPackageName, ushort* pszDomainName, ushort* pszAccountName, 
                           ushort* pszOldPassword, ushort* pszNewPassword, ubyte bImpersonating, uint dwReserved, 
                           SecBufferDesc* pOutput);

@DllImport("SspiCli")
int ChangeAccountPasswordA(byte* pszPackageName, byte* pszDomainName, byte* pszAccountName, byte* pszOldPassword, 
                           byte* pszNewPassword, ubyte bImpersonating, uint dwReserved, SecBufferDesc* pOutput);

@DllImport("SspiCli")
int InitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, ushort* pszTargetName, 
                               uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, 
                               uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, 
                               LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int InitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, byte* pszTargetName, 
                               uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, 
                               uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, 
                               LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int AcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, uint fContextReq, 
                          uint TargetDataRep, SecHandle* phNewContext, SecBufferDesc* pOutput, uint* pfContextAttr, 
                          LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int CompleteAuthToken(SecHandle* phContext, SecBufferDesc* pToken);

@DllImport("SspiCli")
int ImpersonateSecurityContext(SecHandle* phContext);

@DllImport("SspiCli")
int RevertSecurityContext(SecHandle* phContext);

@DllImport("SspiCli")
int QuerySecurityContextToken(SecHandle* phContext, void** Token);

@DllImport("SspiCli")
int DeleteSecurityContext(SecHandle* phContext);

@DllImport("SspiCli")
int ApplyControlToken(SecHandle* phContext, SecBufferDesc* pInput);

@DllImport("SspiCli")
int QueryContextAttributesW(SecHandle* phContext, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli")
int QueryContextAttributesExW(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int QueryContextAttributesA(SecHandle* phContext, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli")
int QueryContextAttributesExA(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int SetContextAttributesW(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int SetContextAttributesA(SecHandle* phContext, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int QueryCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli")
int QueryCredentialsAttributesExW(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int QueryCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, void* pBuffer);

@DllImport("SspiCli")
int QueryCredentialsAttributesExA(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int SetCredentialsAttributesW(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int SetCredentialsAttributesA(SecHandle* phCredential, uint ulAttribute, char* pBuffer, uint cbBuffer);

@DllImport("SspiCli")
int FreeContextBuffer(void* pvContextBuffer);

@DllImport("SspiCli")
int MakeSignature(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

@DllImport("SspiCli")
int VerifySignature(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

@DllImport("SspiCli")
int EncryptMessage(SecHandle* phContext, uint fQOP, SecBufferDesc* pMessage, uint MessageSeqNo);

@DllImport("SspiCli")
int DecryptMessage(SecHandle* phContext, SecBufferDesc* pMessage, uint MessageSeqNo, uint* pfQOP);

@DllImport("SspiCli")
int EnumerateSecurityPackagesW(uint* pcPackages, SecPkgInfoW** ppPackageInfo);

@DllImport("SspiCli")
int EnumerateSecurityPackagesA(uint* pcPackages, SecPkgInfoA** ppPackageInfo);

@DllImport("SspiCli")
int QuerySecurityPackageInfoW(const(wchar)* pszPackageName, SecPkgInfoW** ppPackageInfo);

@DllImport("SspiCli")
int QuerySecurityPackageInfoA(const(char)* pszPackageName, SecPkgInfoA** ppPackageInfo);

@DllImport("SspiCli")
int ExportSecurityContext(SecHandle* phContext, uint fFlags, SecBuffer* pPackedContext, void** pToken);

@DllImport("SspiCli")
int ImportSecurityContextW(const(wchar)* pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

@DllImport("SspiCli")
int ImportSecurityContextA(const(char)* pszPackage, SecBuffer* pPackedContext, void* Token, SecHandle* phContext);

@DllImport("SspiCli")
SecurityFunctionTableA* InitSecurityInterfaceA();

@DllImport("SspiCli")
SecurityFunctionTableW* InitSecurityInterfaceW();

@DllImport("SspiCli")
int SaslEnumerateProfilesA(byte** ProfileList, uint* ProfileCount);

@DllImport("SspiCli")
int SaslEnumerateProfilesW(ushort** ProfileList, uint* ProfileCount);

@DllImport("SspiCli")
int SaslGetProfilePackageA(const(char)* ProfileName, SecPkgInfoA** PackageInfo);

@DllImport("SspiCli")
int SaslGetProfilePackageW(const(wchar)* ProfileName, SecPkgInfoW** PackageInfo);

@DllImport("SspiCli")
int SaslIdentifyPackageA(SecBufferDesc* pInput, SecPkgInfoA** PackageInfo);

@DllImport("SspiCli")
int SaslIdentifyPackageW(SecBufferDesc* pInput, SecPkgInfoW** PackageInfo);

@DllImport("SspiCli")
int SaslInitializeSecurityContextW(SecHandle* phCredential, SecHandle* phContext, const(wchar)* pszTargetName, 
                                   uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, 
                                   uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, 
                                   uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int SaslInitializeSecurityContextA(SecHandle* phCredential, SecHandle* phContext, const(char)* pszTargetName, 
                                   uint fContextReq, uint Reserved1, uint TargetDataRep, SecBufferDesc* pInput, 
                                   uint Reserved2, SecHandle* phNewContext, SecBufferDesc* pOutput, 
                                   uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int SaslAcceptSecurityContext(SecHandle* phCredential, SecHandle* phContext, SecBufferDesc* pInput, 
                              uint fContextReq, uint TargetDataRep, SecHandle* phNewContext, SecBufferDesc* pOutput, 
                              uint* pfContextAttr, LARGE_INTEGER* ptsExpiry);

@DllImport("SspiCli")
int SaslSetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size);

@DllImport("SspiCli")
int SaslGetContextOption(SecHandle* ContextHandle, uint Option, void* Value, uint Size, uint* Needed);

@DllImport("credui")
uint SspiPromptForCredentialsW(const(wchar)* pszTargetName, void* pUiInfo, uint dwAuthError, 
                               const(wchar)* pszPackage, void* pInputAuthIdentity, void** ppAuthIdentity, 
                               int* pfSave, uint dwFlags);

@DllImport("credui")
uint SspiPromptForCredentialsA(const(char)* pszTargetName, void* pUiInfo, uint dwAuthError, 
                               const(char)* pszPackage, void* pInputAuthIdentity, void** ppAuthIdentity, int* pfSave, 
                               uint dwFlags);

@DllImport("SspiCli")
int SspiPrepareForCredRead(void* AuthIdentity, const(wchar)* pszTargetName, uint* pCredmanCredentialType, 
                           ushort** ppszCredmanTargetName);

@DllImport("SspiCli")
int SspiPrepareForCredWrite(void* AuthIdentity, const(wchar)* pszTargetName, uint* pCredmanCredentialType, 
                            ushort** ppszCredmanTargetName, ushort** ppszCredmanUserName, ubyte** ppCredentialBlob, 
                            uint* pCredentialBlobSize);

@DllImport("SspiCli")
int SspiEncryptAuthIdentity(void* AuthData);

@DllImport("SspiCli")
int SspiEncryptAuthIdentityEx(uint Options, void* AuthData);

@DllImport("SspiCli")
int SspiDecryptAuthIdentity(void* EncryptedAuthData);

@DllImport("SspiCli")
int SspiDecryptAuthIdentityEx(uint Options, void* EncryptedAuthData);

@DllImport("SspiCli")
ubyte SspiIsAuthIdentityEncrypted(void* EncryptedAuthData);

@DllImport("SspiCli")
int SspiEncodeAuthIdentityAsStrings(void* pAuthIdentity, ushort** ppszUserName, ushort** ppszDomainName, 
                                    ushort** ppszPackedCredentialsString);

@DllImport("SspiCli")
int SspiValidateAuthIdentity(void* AuthData);

@DllImport("SspiCli")
int SspiCopyAuthIdentity(void* AuthData, void** AuthDataCopy);

@DllImport("SspiCli")
void SspiFreeAuthIdentity(void* AuthData);

@DllImport("SspiCli")
void SspiZeroAuthIdentity(void* AuthData);

@DllImport("SspiCli")
void SspiLocalFree(void* DataBuffer);

@DllImport("SspiCli")
int SspiEncodeStringsAsAuthIdentity(const(wchar)* pszUserName, const(wchar)* pszDomainName, 
                                    const(wchar)* pszPackedCredentialsString, void** ppAuthIdentity);

@DllImport("SspiCli")
int SspiCompareAuthIdentities(void* AuthIdentity1, void* AuthIdentity2, ubyte* SameSuppliedUser, 
                              ubyte* SameSuppliedIdentity);

@DllImport("SspiCli")
int SspiMarshalAuthIdentity(void* AuthIdentity, uint* AuthIdentityLength, byte** AuthIdentityByteArray);

@DllImport("SspiCli")
int SspiUnmarshalAuthIdentity(uint AuthIdentityLength, char* AuthIdentityByteArray, void** ppAuthIdentity);

@DllImport("credui")
ubyte SspiIsPromptingNeeded(uint ErrorOrNtStatus);

@DllImport("SspiCli")
int SspiGetTargetHostName(const(wchar)* pszTargetName, ushort** pszHostName);

@DllImport("SspiCli")
int SspiExcludePackage(void* AuthIdentity, const(wchar)* pszPackageName, void** ppNewAuthIdentity);

@DllImport("SspiCli")
int AddSecurityPackageA(const(char)* pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

@DllImport("SspiCli")
int AddSecurityPackageW(const(wchar)* pszPackageName, SECURITY_PACKAGE_OPTIONS* pOptions);

@DllImport("SspiCli")
int DeleteSecurityPackageA(const(char)* pszPackageName);

@DllImport("SspiCli")
int DeleteSecurityPackageW(const(wchar)* pszPackageName);

@DllImport("ADVAPI32")
BOOL CredWriteW(CREDENTIALW* Credential, uint Flags);

@DllImport("ADVAPI32")
BOOL CredWriteA(CREDENTIALA* Credential, uint Flags);

@DllImport("ADVAPI32")
BOOL CredReadW(const(wchar)* TargetName, uint Type, uint Flags, CREDENTIALW** Credential);

@DllImport("ADVAPI32")
BOOL CredReadA(const(char)* TargetName, uint Type, uint Flags, CREDENTIALA** Credential);

@DllImport("ADVAPI32")
BOOL CredEnumerateW(const(wchar)* Filter, uint Flags, uint* Count, CREDENTIALW*** Credential);

@DllImport("ADVAPI32")
BOOL CredEnumerateA(const(char)* Filter, uint Flags, uint* Count, CREDENTIALA*** Credential);

@DllImport("ADVAPI32")
BOOL CredWriteDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, CREDENTIALW* Credential, uint Flags);

@DllImport("ADVAPI32")
BOOL CredWriteDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, CREDENTIALA* Credential, uint Flags);

@DllImport("ADVAPI32")
BOOL CredReadDomainCredentialsW(CREDENTIAL_TARGET_INFORMATIONW* TargetInfo, uint Flags, uint* Count, 
                                CREDENTIALW*** Credential);

@DllImport("ADVAPI32")
BOOL CredReadDomainCredentialsA(CREDENTIAL_TARGET_INFORMATIONA* TargetInfo, uint Flags, uint* Count, 
                                CREDENTIALA*** Credential);

@DllImport("ADVAPI32")
BOOL CredDeleteW(const(wchar)* TargetName, uint Type, uint Flags);

@DllImport("ADVAPI32")
BOOL CredDeleteA(const(char)* TargetName, uint Type, uint Flags);

@DllImport("ADVAPI32")
BOOL CredRenameW(const(wchar)* OldTargetName, const(wchar)* NewTargetName, uint Type, uint Flags);

@DllImport("ADVAPI32")
BOOL CredRenameA(const(char)* OldTargetName, const(char)* NewTargetName, uint Type, uint Flags);

@DllImport("ADVAPI32")
BOOL CredGetTargetInfoW(const(wchar)* TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONW** TargetInfo);

@DllImport("ADVAPI32")
BOOL CredGetTargetInfoA(const(char)* TargetName, uint Flags, CREDENTIAL_TARGET_INFORMATIONA** TargetInfo);

@DllImport("ADVAPI32")
BOOL CredMarshalCredentialW(CRED_MARSHAL_TYPE CredType, void* Credential, ushort** MarshaledCredential);

@DllImport("ADVAPI32")
BOOL CredMarshalCredentialA(CRED_MARSHAL_TYPE CredType, void* Credential, byte** MarshaledCredential);

@DllImport("ADVAPI32")
BOOL CredUnmarshalCredentialW(const(wchar)* MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

@DllImport("ADVAPI32")
BOOL CredUnmarshalCredentialA(const(char)* MarshaledCredential, CRED_MARSHAL_TYPE* CredType, void** Credential);

@DllImport("ADVAPI32")
BOOL CredIsMarshaledCredentialW(const(wchar)* MarshaledCredential);

@DllImport("ADVAPI32")
BOOL CredIsMarshaledCredentialA(const(char)* MarshaledCredential);

@DllImport("credui")
BOOL CredUnPackAuthenticationBufferW(uint dwFlags, char* pAuthBuffer, uint cbAuthBuffer, const(wchar)* pszUserName, 
                                     uint* pcchMaxUserName, const(wchar)* pszDomainName, uint* pcchMaxDomainName, 
                                     const(wchar)* pszPassword, uint* pcchMaxPassword);

@DllImport("credui")
BOOL CredUnPackAuthenticationBufferA(uint dwFlags, char* pAuthBuffer, uint cbAuthBuffer, const(char)* pszUserName, 
                                     uint* pcchlMaxUserName, const(char)* pszDomainName, uint* pcchMaxDomainName, 
                                     const(char)* pszPassword, uint* pcchMaxPassword);

@DllImport("credui")
BOOL CredPackAuthenticationBufferW(uint dwFlags, const(wchar)* pszUserName, const(wchar)* pszPassword, 
                                   char* pPackedCredentials, uint* pcbPackedCredentials);

@DllImport("credui")
BOOL CredPackAuthenticationBufferA(uint dwFlags, const(char)* pszUserName, const(char)* pszPassword, 
                                   char* pPackedCredentials, uint* pcbPackedCredentials);

@DllImport("ADVAPI32")
BOOL CredProtectW(BOOL fAsSelf, const(wchar)* pszCredentials, uint cchCredentials, 
                  const(wchar)* pszProtectedCredentials, uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

@DllImport("ADVAPI32")
BOOL CredProtectA(BOOL fAsSelf, const(char)* pszCredentials, uint cchCredentials, 
                  const(char)* pszProtectedCredentials, uint* pcchMaxChars, CRED_PROTECTION_TYPE* ProtectionType);

@DllImport("ADVAPI32")
BOOL CredUnprotectW(BOOL fAsSelf, const(wchar)* pszProtectedCredentials, uint cchProtectedCredentials, 
                    const(wchar)* pszCredentials, uint* pcchMaxChars);

@DllImport("ADVAPI32")
BOOL CredUnprotectA(BOOL fAsSelf, const(char)* pszProtectedCredentials, uint cchProtectedCredentials, 
                    const(char)* pszCredentials, uint* pcchMaxChars);

@DllImport("ADVAPI32")
BOOL CredIsProtectedW(const(wchar)* pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

@DllImport("ADVAPI32")
BOOL CredIsProtectedA(const(char)* pszProtectedCredentials, CRED_PROTECTION_TYPE* pProtectionType);

@DllImport("ADVAPI32")
BOOL CredFindBestCredentialW(const(wchar)* TargetName, uint Type, uint Flags, CREDENTIALW** Credential);

@DllImport("ADVAPI32")
BOOL CredFindBestCredentialA(const(char)* TargetName, uint Type, uint Flags, CREDENTIALA** Credential);

@DllImport("ADVAPI32")
BOOL CredGetSessionTypes(uint MaximumPersistCount, char* MaximumPersist);

@DllImport("ADVAPI32")
void CredFree(void* Buffer);

@DllImport("credui")
uint CredUIPromptForCredentialsW(CREDUI_INFOW* pUiInfo, const(wchar)* pszTargetName, SecHandle* pContext, 
                                 uint dwAuthError, const(wchar)* pszUserName, uint ulUserNameBufferSize, 
                                 const(wchar)* pszPassword, uint ulPasswordBufferSize, int* save, uint dwFlags);

@DllImport("credui")
uint CredUIPromptForCredentialsA(CREDUI_INFOA* pUiInfo, const(char)* pszTargetName, SecHandle* pContext, 
                                 uint dwAuthError, const(char)* pszUserName, uint ulUserNameBufferSize, 
                                 const(char)* pszPassword, uint ulPasswordBufferSize, int* save, uint dwFlags);

@DllImport("credui")
uint CredUIPromptForWindowsCredentialsW(CREDUI_INFOW* pUiInfo, uint dwAuthError, uint* pulAuthPackage, 
                                        char* pvInAuthBuffer, uint ulInAuthBufferSize, char* ppvOutAuthBuffer, 
                                        uint* pulOutAuthBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui")
uint CredUIPromptForWindowsCredentialsA(CREDUI_INFOA* pUiInfo, uint dwAuthError, uint* pulAuthPackage, 
                                        char* pvInAuthBuffer, uint ulInAuthBufferSize, char* ppvOutAuthBuffer, 
                                        uint* pulOutAuthBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui")
uint CredUIParseUserNameW(const(wchar)* UserName, char* user, uint userBufferSize, char* domain, 
                          uint domainBufferSize);

@DllImport("credui")
uint CredUIParseUserNameA(const(char)* userName, char* user, uint userBufferSize, char* domain, 
                          uint domainBufferSize);

@DllImport("credui")
uint CredUICmdLinePromptForCredentialsW(const(wchar)* pszTargetName, SecHandle* pContext, uint dwAuthError, 
                                        const(wchar)* UserName, uint ulUserBufferSize, const(wchar)* pszPassword, 
                                        uint ulPasswordBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui")
uint CredUICmdLinePromptForCredentialsA(const(char)* pszTargetName, SecHandle* pContext, uint dwAuthError, 
                                        const(char)* UserName, uint ulUserBufferSize, const(char)* pszPassword, 
                                        uint ulPasswordBufferSize, int* pfSave, uint dwFlags);

@DllImport("credui")
uint CredUIConfirmCredentialsW(const(wchar)* pszTargetName, BOOL bConfirm);

@DllImport("credui")
uint CredUIConfirmCredentialsA(const(char)* pszTargetName, BOOL bConfirm);

@DllImport("credui")
uint CredUIStoreSSOCredW(const(wchar)* pszRealm, const(wchar)* pszUsername, const(wchar)* pszPassword, 
                         BOOL bPersist);

@DllImport("credui")
uint CredUIReadSSOCredW(const(wchar)* pszRealm, ushort** ppszUsername);

@DllImport("SECUR32")
NTSTATUS CredMarshalTargetInfo(CREDENTIAL_TARGET_INFORMATIONW* InTargetInfo, ushort** Buffer, uint* BufferSize);

@DllImport("SECUR32")
NTSTATUS CredUnmarshalTargetInfo(char* Buffer, uint BufferSize, CREDENTIAL_TARGET_INFORMATIONW** RetTargetInfo, 
                                 uint* RetActualSize);

@DllImport("SCHANNEL")
BOOL SslEmptyCacheA(const(char)* pszTargetName, uint dwFlags);

@DllImport("SCHANNEL")
BOOL SslEmptyCacheW(const(wchar)* pszTargetName, uint dwFlags);

@DllImport("SCHANNEL")
void SslGenerateRandomBits(ubyte* pRandomData, int cRandomData);

@DllImport("SCHANNEL")
BOOL SslCrackCertificate(ubyte* pbCertificate, uint cbCertificate, uint dwFlags, X509Certificate** ppCertificate);

@DllImport("SCHANNEL")
void SslFreeCertificate(X509Certificate* pCertificate);

@DllImport("SCHANNEL")
uint SslGetMaximumKeySize(uint Reserved);

@DllImport("SCHANNEL")
int SslGetServerIdentity(char* ClientHello, uint ClientHelloSize, ubyte** ServerIdentity, uint* ServerIdentitySize, 
                         uint Flags);

@DllImport("SCHANNEL")
int SslGetExtensions(char* clientHello, uint clientHelloByteSize, char* genericExtensions, 
                     ubyte genericExtensionsCount, uint* bytesToRead, SchGetExtensionsOptions flags);

@DllImport("KeyCredMgr")
HRESULT KeyCredentialManagerGetOperationErrorStates(KeyCredentialManagerOperationType keyCredentialManagerOperationType, 
                                                    int* isReady, 
                                                    KeyCredentialManagerOperationErrorStates* keyCredentialManagerOperationErrorStates);

@DllImport("KeyCredMgr")
HRESULT KeyCredentialManagerShowUIOperation(HWND hWndOwner, 
                                            KeyCredentialManagerOperationType keyCredentialManagerOperationType);

@DllImport("KeyCredMgr")
HRESULT KeyCredentialManagerGetInformation(KeyCredentialManagerInfo** keyCredentialManagerInfo);

@DllImport("KeyCredMgr")
void KeyCredentialManagerFreeInformation(KeyCredentialManagerInfo* keyCredentialManagerInfo);

@DllImport("davclnt")
uint NPAddConnection(NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, const(wchar)* lpUserName);

@DllImport("davclnt")
uint NPAddConnection3(HWND hwndOwner, NETRESOURCEW* lpNetResource, const(wchar)* lpPassword, 
                      const(wchar)* lpUserName, uint dwFlags);

@DllImport("NTLANMAN")
uint NPAddConnection4(HWND hwndOwner, NETRESOURCEW* lpNetResource, char* lpAuthBuffer, uint cbAuthBuffer, 
                      uint dwFlags, char* lpUseOptions, uint cbUseOptions);

@DllImport("davclnt")
uint NPCancelConnection(const(wchar)* lpName, BOOL fForce);

@DllImport("davclnt")
uint NPGetConnection(const(wchar)* lpLocalName, const(wchar)* lpRemoteName, uint* lpnBufferLen);

@DllImport("NTLANMAN")
uint NPGetConnection3(const(wchar)* lpLocalName, uint dwLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt")
uint NPGetUniversalName(const(wchar)* lpLocalPath, uint dwInfoLevel, char* lpBuffer, uint* lpBufferSize);

@DllImport("NTLANMAN")
uint NPGetConnectionPerformance(const(wchar)* lpRemoteName, NETCONNECTINFOSTRUCT* lpNetConnectInfo);

@DllImport("davclnt")
uint NPOpenEnum(uint dwScope, uint dwType, uint dwUsage, NETRESOURCEW* lpNetResource, ptrdiff_t* lphEnum);

@DllImport("davclnt")
uint NPEnumResource(HANDLE hEnum, uint* lpcCount, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt")
uint NPCloseEnum(HANDLE hEnum);

@DllImport("davclnt")
uint NPGetCaps(uint ndex);

@DllImport("davclnt")
uint NPGetUser(const(wchar)* lpName, const(wchar)* lpUserName, uint* lpnBufferLen);

@DllImport("NTLANMAN")
uint NPGetPersistentUseOptionsForConnection(const(wchar)* lpRemotePath, char* lpReadUseOptions, 
                                            uint cbReadUseOptions, char* lpWriteUseOptions, 
                                            uint* lpSizeWriteUseOptions);

@DllImport("davclnt")
uint NPGetResourceParent(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize);

@DllImport("davclnt")
uint NPGetResourceInformation(NETRESOURCEW* lpNetResource, char* lpBuffer, uint* lpBufferSize, ushort** lplpSystem);

@DllImport("davclnt")
uint NPFormatNetworkName(const(wchar)* lpRemoteName, const(wchar)* lpFormattedName, uint* lpnLength, uint dwFlags, 
                         uint dwAveCharPerLine);

@DllImport("MPR")
void WNetSetLastErrorA(uint err, const(char)* lpError, const(char)* lpProviders);

@DllImport("MPR")
void WNetSetLastErrorW(uint err, const(wchar)* lpError, const(wchar)* lpProviders);

@DllImport("certpoleng")
NTSTATUS PstGetTrustAnchors(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, 
                            SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng")
NTSTATUS PstGetTrustAnchorsEx(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, 
                              CERT_CONTEXT* pCertContext, SecPkgContext_IssuerListInfoEx** ppTrustedIssuers);

@DllImport("certpoleng")
NTSTATUS PstGetCertificateChain(CERT_CONTEXT* pCert, SecPkgContext_IssuerListInfoEx* pTrustedIssuers, 
                                CERT_CHAIN_CONTEXT** ppCertChainContext);

@DllImport("certpoleng")
NTSTATUS PstGetCertificates(UNICODE_STRING* pTargetName, uint cCriteria, char* rgpCriteria, BOOL bIsClient, 
                            uint* pdwCertChainContextCount, CERT_CHAIN_CONTEXT*** ppCertChainContexts);

@DllImport("certpoleng")
NTSTATUS PstAcquirePrivateKey(CERT_CONTEXT* pCert);

@DllImport("certpoleng")
NTSTATUS PstValidate(UNICODE_STRING* pTargetName, BOOL bIsClient, CERT_USAGE_MATCH* pRequestedIssuancePolicy, 
                     void** phAdditionalCertStore, CERT_CONTEXT* pCert, GUID* pProvGUID);

@DllImport("certpoleng")
NTSTATUS PstMapCertificate(CERT_CONTEXT* pCert, LSA_TOKEN_INFORMATION_TYPE* pTokenInformationType, 
                           void** ppTokenInformation);

@DllImport("certpoleng")
NTSTATUS PstGetUserNameForCertificate(CERT_CONTEXT* pCertContext, UNICODE_STRING* UserName);

@DllImport("SAS")
void SendSAS(BOOL AsUser);

@DllImport("AUTHZ")
BOOL AuthzAccessCheck(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                      AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, 
                      void* pSecurityDescriptor, char* OptionalSecurityDescriptorArray, 
                      uint OptionalSecurityDescriptorCount, AUTHZ_ACCESS_REPLY* pReply, 
                      AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__** phAccessCheckResults);

@DllImport("AUTHZ")
BOOL AuthzCachedAccessCheck(uint Flags, AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__* hAccessCheckResults, 
                            AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, 
                            AUTHZ_ACCESS_REPLY* pReply);

@DllImport("AUTHZ")
BOOL AuthzOpenObjectAudit(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                          AUTHZ_ACCESS_REQUEST* pRequest, AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent, 
                          void* pSecurityDescriptor, char* OptionalSecurityDescriptorArray, 
                          uint OptionalSecurityDescriptorCount, AUTHZ_ACCESS_REPLY* pReply);

@DllImport("AUTHZ")
BOOL AuthzFreeHandle(AUTHZ_ACCESS_CHECK_RESULTS_HANDLE__* hAccessCheckResults);

@DllImport("AUTHZ")
BOOL AuthzInitializeResourceManager(uint Flags, PFN_AUTHZ_DYNAMIC_ACCESS_CHECK pfnDynamicAccessCheck, 
                                    PFN_AUTHZ_COMPUTE_DYNAMIC_GROUPS pfnComputeDynamicGroups, 
                                    PFN_AUTHZ_FREE_DYNAMIC_GROUPS pfnFreeDynamicGroups, 
                                    const(wchar)* szResourceManagerName, 
                                    AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ")
BOOL AuthzInitializeResourceManagerEx(uint Flags, AUTHZ_INIT_INFO* pAuthzInitInfo, 
                                      AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ")
BOOL AuthzInitializeRemoteResourceManager(AUTHZ_RPC_INIT_INFO_CLIENT* pRpcInitInfo, 
                                          AUTHZ_RESOURCE_MANAGER_HANDLE__** phAuthzResourceManager);

@DllImport("AUTHZ")
BOOL AuthzFreeResourceManager(AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager);

@DllImport("AUTHZ")
BOOL AuthzInitializeContextFromToken(uint Flags, HANDLE TokenHandle, 
                                     AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager, 
                                     LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, 
                                     AUTHZ_CLIENT_CONTEXT_HANDLE__** phAuthzClientContext);

@DllImport("AUTHZ")
BOOL AuthzInitializeContextFromSid(uint Flags, void* UserSid, 
                                   AUTHZ_RESOURCE_MANAGER_HANDLE__* hAuthzResourceManager, 
                                   LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, 
                                   AUTHZ_CLIENT_CONTEXT_HANDLE__** phAuthzClientContext);

@DllImport("AUTHZ")
BOOL AuthzInitializeContextFromAuthzContext(uint Flags, AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                                            LARGE_INTEGER* pExpirationTime, LUID Identifier, void* DynamicGroupArgs, 
                                            AUTHZ_CLIENT_CONTEXT_HANDLE__** phNewAuthzClientContext);

@DllImport("AUTHZ")
BOOL AuthzInitializeCompoundContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* UserContext, 
                                    AUTHZ_CLIENT_CONTEXT_HANDLE__* DeviceContext, 
                                    AUTHZ_CLIENT_CONTEXT_HANDLE__** phCompoundContext);

@DllImport("AUTHZ")
BOOL AuthzAddSidsToContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, SID_AND_ATTRIBUTES* Sids, 
                           uint SidCount, SID_AND_ATTRIBUTES* RestrictedSids, uint RestrictedSidCount, 
                           AUTHZ_CLIENT_CONTEXT_HANDLE__** phNewAuthzClientContext);

@DllImport("AUTHZ")
BOOL AuthzModifySecurityAttributes(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, char* pOperations, 
                                   AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAttributes);

@DllImport("AUTHZ")
BOOL AuthzModifyClaims(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                       AUTHZ_CONTEXT_INFORMATION_CLASS ClaimClass, char* pClaimOperations, 
                       AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pClaims);

@DllImport("AUTHZ")
BOOL AuthzModifySids(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, AUTHZ_CONTEXT_INFORMATION_CLASS SidClass, 
                     char* pSidOperations, TOKEN_GROUPS* pSids);

@DllImport("AUTHZ")
BOOL AuthzSetAppContainerInformation(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, void* pAppContainerSid, 
                                     uint CapabilityCount, char* pCapabilitySids);

@DllImport("AUTHZ")
BOOL AuthzGetInformationFromContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext, 
                                    AUTHZ_CONTEXT_INFORMATION_CLASS InfoClass, uint BufferSize, uint* pSizeRequired, 
                                    void* Buffer);

@DllImport("AUTHZ")
BOOL AuthzFreeContext(AUTHZ_CLIENT_CONTEXT_HANDLE__* hAuthzClientContext);

@DllImport("AUTHZ")
BOOL AuthzInitializeObjectAccessAuditEvent(uint Flags, AUTHZ_AUDIT_EVENT_TYPE_HANDLE__* hAuditEventType, 
                                           const(wchar)* szOperationType, const(wchar)* szObjectType, 
                                           const(wchar)* szObjectName, const(wchar)* szAdditionalInfo, 
                                           AUTHZ_AUDIT_EVENT_HANDLE__** phAuditEvent, 
                                           uint dwAdditionalParameterCount);

@DllImport("AUTHZ")
BOOL AuthzInitializeObjectAccessAuditEvent2(uint Flags, AUTHZ_AUDIT_EVENT_TYPE_HANDLE__* hAuditEventType, 
                                            const(wchar)* szOperationType, const(wchar)* szObjectType, 
                                            const(wchar)* szObjectName, const(wchar)* szAdditionalInfo, 
                                            const(wchar)* szAdditionalInfo2, 
                                            AUTHZ_AUDIT_EVENT_HANDLE__** phAuditEvent, 
                                            uint dwAdditionalParameterCount);

@DllImport("AUTHZ")
BOOL AuthzFreeAuditEvent(AUTHZ_AUDIT_EVENT_HANDLE__* hAuditEvent);

@DllImport("AUTHZ")
BOOL AuthzEvaluateSacl(AUTHZ_CLIENT_CONTEXT_HANDLE__* AuthzClientContext, AUTHZ_ACCESS_REQUEST* pRequest, 
                       ACL* Sacl, uint GrantedAccess, BOOL AccessGranted, int* pbGenerateAudit);

@DllImport("AUTHZ")
BOOL AuthzInstallSecurityEventSource(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* pRegistration);

@DllImport("AUTHZ")
BOOL AuthzUninstallSecurityEventSource(uint dwFlags, const(wchar)* szEventSourceName);

@DllImport("AUTHZ")
BOOL AuthzEnumerateSecurityEventSources(uint dwFlags, AUTHZ_SOURCE_SCHEMA_REGISTRATION* Buffer, uint* pdwCount, 
                                        uint* pdwLength);

@DllImport("AUTHZ")
BOOL AuthzRegisterSecurityEventSource(uint dwFlags, const(wchar)* szEventSourceName, 
                                      AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__** phEventProvider);

@DllImport("AUTHZ")
BOOL AuthzUnregisterSecurityEventSource(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__** phEventProvider);

@DllImport("AUTHZ")
BOOL AuthzReportSecurityEvent(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__* hEventProvider, uint dwAuditId, 
                              void* pUserSid, uint dwCount);

@DllImport("AUTHZ")
BOOL AuthzReportSecurityEventFromParams(uint dwFlags, AUTHZ_SECURITY_EVENT_PROVIDER_HANDLE__* hEventProvider, 
                                        uint dwAuditId, void* pUserSid, AUDIT_PARAMS* pParams);

@DllImport("AUTHZ")
BOOL AuthzRegisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__** phCapChangeSubscription, 
                                        LPTHREAD_START_ROUTINE pfnCapChangeCallback, void* pCallbackContext);

@DllImport("AUTHZ")
BOOL AuthzUnregisterCapChangeNotification(AUTHZ_CAP_CHANGE_SUBSCRIPTION_HANDLE__* hCapChangeSubscription);

@DllImport("AUTHZ")
BOOL AuthzFreeCentralAccessPolicyCache();

@DllImport("ACLUI")
HPROPSHEETPAGE CreateSecurityPage(ISecurityInformation psi);

@DllImport("ACLUI")
BOOL EditSecurity(HWND hwndOwner, ISecurityInformation psi);

@DllImport("ACLUI")
HRESULT EditSecurityAdvanced(HWND hwndOwner, ISecurityInformation psi, SI_PAGE_TYPE uSIPage);

@DllImport("ADVAPI32")
uint SetEntriesInAclA(uint cCountOfExplicitEntries, char* pListOfExplicitEntries, ACL* OldAcl, ACL** NewAcl);

@DllImport("ADVAPI32")
uint SetEntriesInAclW(uint cCountOfExplicitEntries, char* pListOfExplicitEntries, ACL* OldAcl, ACL** NewAcl);

@DllImport("ADVAPI32")
uint GetExplicitEntriesFromAclA(ACL* pacl, uint* pcCountOfExplicitEntries, 
                                EXPLICIT_ACCESS_A** pListOfExplicitEntries);

@DllImport("ADVAPI32")
uint GetExplicitEntriesFromAclW(ACL* pacl, uint* pcCountOfExplicitEntries, 
                                EXPLICIT_ACCESS_W** pListOfExplicitEntries);

@DllImport("ADVAPI32")
uint GetEffectiveRightsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pAccessRights);

@DllImport("ADVAPI32")
uint GetEffectiveRightsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pAccessRights);

@DllImport("ADVAPI32")
uint GetAuditedPermissionsFromAclA(ACL* pacl, TRUSTEE_A* pTrustee, uint* pSuccessfulAuditedRights, 
                                   uint* pFailedAuditRights);

@DllImport("ADVAPI32")
uint GetAuditedPermissionsFromAclW(ACL* pacl, TRUSTEE_W* pTrustee, uint* pSuccessfulAuditedRights, 
                                   uint* pFailedAuditRights);

@DllImport("ADVAPI32")
uint GetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                           void** ppsidOwner, void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, 
                           void** ppSecurityDescriptor);

@DllImport("ADVAPI32")
uint GetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                           void** ppsidOwner, void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, 
                           void** ppSecurityDescriptor);

@DllImport("ADVAPI32")
uint GetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void** ppsidOwner, 
                     void** ppsidGroup, ACL** ppDacl, ACL** ppSacl, void** ppSecurityDescriptor);

@DllImport("ADVAPI32")
uint SetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* psidOwner, 
                           void* psidGroup, ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32")
uint SetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                           void* psidOwner, void* psidGroup, ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32")
uint SetSecurityInfo(HANDLE handle, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, void* psidOwner, void* psidGroup, 
                     ACL* pDacl, ACL* pSacl);

@DllImport("ADVAPI32")
uint GetInheritanceSourceA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, BOOL Container, 
                           char* pObjectClassGuids, uint GuidCount, ACL* pAcl, _FN_OBJECT_MGR_FUNCTIONS* pfnArray, 
                           GENERIC_MAPPING* pGenericMapping, INHERITED_FROMA* pInheritArray);

@DllImport("ADVAPI32")
uint GetInheritanceSourceW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, BOOL Container, 
                           char* pObjectClassGuids, uint GuidCount, ACL* pAcl, _FN_OBJECT_MGR_FUNCTIONS* pfnArray, 
                           GENERIC_MAPPING* pGenericMapping, INHERITED_FROMW* pInheritArray);

@DllImport("ADVAPI32")
uint FreeInheritedFromArray(char* pInheritArray, ushort AceCnt, _FN_OBJECT_MGR_FUNCTIONS* pfnArray);

@DllImport("ADVAPI32")
uint TreeResetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                                 void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, 
                                 FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32")
uint TreeResetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                                 void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, BOOL KeepExplicit, 
                                 FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32")
uint TreeSetNamedSecurityInfoA(const(char)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                               void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, uint dwAction, 
                               FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32")
uint TreeSetNamedSecurityInfoW(const(wchar)* pObjectName, SE_OBJECT_TYPE ObjectType, uint SecurityInfo, 
                               void* pOwner, void* pGroup, ACL* pDacl, ACL* pSacl, uint dwAction, 
                               FN_PROGRESS fnProgress, PROG_INVOKE_SETTING ProgressInvokeSetting, void* Args);

@DllImport("ADVAPI32")
uint BuildSecurityDescriptorA(TRUSTEE_A* pOwner, TRUSTEE_A* pGroup, uint cCountOfAccessEntries, 
                              char* pListOfAccessEntries, uint cCountOfAuditEntries, char* pListOfAuditEntries, 
                              void* pOldSD, uint* pSizeNewSD, void** pNewSD);

@DllImport("ADVAPI32")
uint BuildSecurityDescriptorW(TRUSTEE_W* pOwner, TRUSTEE_W* pGroup, uint cCountOfAccessEntries, 
                              char* pListOfAccessEntries, uint cCountOfAuditEntries, char* pListOfAuditEntries, 
                              void* pOldSD, uint* pSizeNewSD, void** pNewSD);

@DllImport("ADVAPI32")
uint LookupSecurityDescriptorPartsA(TRUSTEE_A** ppOwner, TRUSTEE_A** ppGroup, uint* pcCountOfAccessEntries, 
                                    EXPLICIT_ACCESS_A** ppListOfAccessEntries, uint* pcCountOfAuditEntries, 
                                    EXPLICIT_ACCESS_A** ppListOfAuditEntries, void* pSD);

@DllImport("ADVAPI32")
uint LookupSecurityDescriptorPartsW(TRUSTEE_W** ppOwner, TRUSTEE_W** ppGroup, uint* pcCountOfAccessEntries, 
                                    EXPLICIT_ACCESS_W** ppListOfAccessEntries, uint* pcCountOfAuditEntries, 
                                    EXPLICIT_ACCESS_W** ppListOfAuditEntries, void* pSD);

@DllImport("ADVAPI32")
void BuildExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, const(char)* pTrusteeName, 
                                  uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32")
void BuildExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, const(wchar)* pTrusteeName, 
                                  uint AccessPermissions, ACCESS_MODE AccessMode, uint Inheritance);

@DllImport("ADVAPI32")
void BuildImpersonateExplicitAccessWithNameA(EXPLICIT_ACCESS_A* pExplicitAccess, const(char)* pTrusteeName, 
                                             TRUSTEE_A* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, 
                                             uint Inheritance);

@DllImport("ADVAPI32")
void BuildImpersonateExplicitAccessWithNameW(EXPLICIT_ACCESS_W* pExplicitAccess, const(wchar)* pTrusteeName, 
                                             TRUSTEE_W* pTrustee, uint AccessPermissions, ACCESS_MODE AccessMode, 
                                             uint Inheritance);

@DllImport("ADVAPI32")
void BuildTrusteeWithNameA(TRUSTEE_A* pTrustee, const(char)* pName);

@DllImport("ADVAPI32")
void BuildTrusteeWithNameW(TRUSTEE_W* pTrustee, const(wchar)* pName);

@DllImport("ADVAPI32")
void BuildImpersonateTrusteeA(TRUSTEE_A* pTrustee, TRUSTEE_A* pImpersonateTrustee);

@DllImport("ADVAPI32")
void BuildImpersonateTrusteeW(TRUSTEE_W* pTrustee, TRUSTEE_W* pImpersonateTrustee);

@DllImport("ADVAPI32")
void BuildTrusteeWithSidA(TRUSTEE_A* pTrustee, void* pSid);

@DllImport("ADVAPI32")
void BuildTrusteeWithSidW(TRUSTEE_W* pTrustee, void* pSid);

@DllImport("ADVAPI32")
void BuildTrusteeWithObjectsAndSidA(TRUSTEE_A* pTrustee, OBJECTS_AND_SID* pObjSid, GUID* pObjectGuid, 
                                    GUID* pInheritedObjectGuid, void* pSid);

@DllImport("ADVAPI32")
void BuildTrusteeWithObjectsAndSidW(TRUSTEE_W* pTrustee, OBJECTS_AND_SID* pObjSid, GUID* pObjectGuid, 
                                    GUID* pInheritedObjectGuid, void* pSid);

@DllImport("ADVAPI32")
void BuildTrusteeWithObjectsAndNameA(TRUSTEE_A* pTrustee, OBJECTS_AND_NAME_A* pObjName, SE_OBJECT_TYPE ObjectType, 
                                     const(char)* ObjectTypeName, const(char)* InheritedObjectTypeName, 
                                     const(char)* Name);

@DllImport("ADVAPI32")
void BuildTrusteeWithObjectsAndNameW(TRUSTEE_W* pTrustee, OBJECTS_AND_NAME_W* pObjName, SE_OBJECT_TYPE ObjectType, 
                                     const(wchar)* ObjectTypeName, const(wchar)* InheritedObjectTypeName, 
                                     const(wchar)* Name);

@DllImport("ADVAPI32")
byte* GetTrusteeNameA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32")
ushort* GetTrusteeNameW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_TYPE GetTrusteeTypeA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_TYPE GetTrusteeTypeW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_FORM GetTrusteeFormA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_FORM GetTrusteeFormW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32")
MULTIPLE_TRUSTEE_OPERATION GetMultipleTrusteeOperationW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_A* GetMultipleTrusteeA(TRUSTEE_A* pTrustee);

@DllImport("ADVAPI32")
TRUSTEE_W* GetMultipleTrusteeW(TRUSTEE_W* pTrustee);

@DllImport("ADVAPI32")
BOOL ConvertSidToStringSidA(void* Sid, byte** StringSid);

@DllImport("ADVAPI32")
BOOL ConvertSidToStringSidW(void* Sid, ushort** StringSid);

@DllImport("ADVAPI32")
BOOL ConvertStringSidToSidA(const(char)* StringSid, void** Sid);

@DllImport("ADVAPI32")
BOOL ConvertStringSidToSidW(const(wchar)* StringSid, void** Sid);

@DllImport("ADVAPI32")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorA(const(char)* StringSecurityDescriptor, 
                                                          uint StringSDRevision, void** SecurityDescriptor, 
                                                          uint* SecurityDescriptorSize);

@DllImport("ADVAPI32")
BOOL ConvertStringSecurityDescriptorToSecurityDescriptorW(const(wchar)* StringSecurityDescriptor, 
                                                          uint StringSDRevision, void** SecurityDescriptor, 
                                                          uint* SecurityDescriptorSize);

@DllImport("ADVAPI32")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorA(void* SecurityDescriptor, uint RequestedStringSDRevision, 
                                                          uint SecurityInformation, byte** StringSecurityDescriptor, 
                                                          uint* StringSecurityDescriptorLen);

@DllImport("ADVAPI32")
BOOL ConvertSecurityDescriptorToStringSecurityDescriptorW(void* SecurityDescriptor, uint RequestedStringSDRevision, 
                                                          uint SecurityInformation, 
                                                          ushort** StringSecurityDescriptor, 
                                                          uint* StringSecurityDescriptorLen);

@DllImport("DSSEC")
HRESULT DSCreateISecurityInfoObject(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, 
                                    ISecurityInformation* ppSI, PFNREADOBJECTSECURITY pfnReadSD, 
                                    PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("DSSEC")
HRESULT DSCreateISecurityInfoObjectEx(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, 
                                      const(wchar)* pwszServer, const(wchar)* pwszUserName, 
                                      const(wchar)* pwszPassword, uint dwFlags, ISecurityInformation* ppSI, 
                                      PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, 
                                      LPARAM lpContext);

@DllImport("DSSEC")
HRESULT DSCreateSecurityPage(const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, 
                             HPROPSHEETPAGE* phPage, PFNREADOBJECTSECURITY pfnReadSD, 
                             PFNWRITEOBJECTSECURITY pfnWriteSD, LPARAM lpContext);

@DllImport("DSSEC")
HRESULT DSEditSecurity(HWND hwndOwner, const(wchar)* pwszObjectPath, const(wchar)* pwszObjectClass, uint dwFlags, 
                       const(wchar)* pwszCaption, PFNREADOBJECTSECURITY pfnReadSD, PFNWRITEOBJECTSECURITY pfnWriteSD, 
                       LPARAM lpContext);

@DllImport("certadm")
HRESULT CertSrvIsServerOnlineW(const(wchar)* pwszServerName, int* pfServerOnline);

@DllImport("certadm")
HRESULT CertSrvBackupGetDynamicFileListW(void* hbc, ushort** ppwszzFileList, uint* pcbSize);

@DllImport("certadm")
HRESULT CertSrvBackupPrepareW(const(wchar)* pwszServerName, uint grbitJet, uint dwBackupFlags, void** phbc);

@DllImport("certadm")
HRESULT CertSrvBackupGetDatabaseNamesW(void* hbc, ushort** ppwszzAttachmentInformation, uint* pcbSize);

@DllImport("certadm")
HRESULT CertSrvBackupOpenFileW(void* hbc, const(wchar)* pwszAttachmentName, uint cbReadHintSize, 
                               LARGE_INTEGER* pliFileSize);

@DllImport("certadm")
HRESULT CertSrvBackupRead(void* hbc, void* pvBuffer, uint cbBuffer, uint* pcbRead);

@DllImport("certadm")
HRESULT CertSrvBackupClose(void* hbc);

@DllImport("certadm")
HRESULT CertSrvBackupGetBackupLogsW(void* hbc, ushort** ppwszzBackupLogFiles, uint* pcbSize);

@DllImport("certadm")
HRESULT CertSrvBackupTruncateLogs(void* hbc);

@DllImport("certadm")
HRESULT CertSrvBackupEnd(void* hbc);

@DllImport("certadm")
void CertSrvBackupFree(void* pv);

@DllImport("certadm")
HRESULT CertSrvRestoreGetDatabaseLocationsW(void* hbc, ushort** ppwszzDatabaseLocationList, uint* pcbSize);

@DllImport("certadm")
HRESULT CertSrvRestorePrepareW(const(wchar)* pwszServerName, uint dwRestoreFlags, void** phbc);

@DllImport("certadm")
HRESULT CertSrvRestoreRegisterW(void* hbc, const(wchar)* pwszCheckPointFilePath, const(wchar)* pwszLogPath, 
                                CSEDB_RSTMAPW* rgrstmap, int crstmap, const(wchar)* pwszBackupLogPath, uint genLow, 
                                uint genHigh);

@DllImport("certadm")
HRESULT CertSrvRestoreRegisterThroughFile(void* hbc, const(wchar)* pwszCheckPointFilePath, 
                                          const(wchar)* pwszLogPath, CSEDB_RSTMAPW* rgrstmap, int crstmap, 
                                          const(wchar)* pwszBackupLogPath, uint genLow, uint genHigh);

@DllImport("certadm")
HRESULT CertSrvRestoreRegisterComplete(void* hbc, HRESULT hrRestoreState);

@DllImport("certadm")
HRESULT CertSrvRestoreEnd(void* hbc);

@DllImport("certadm")
HRESULT CertSrvServerControlW(const(wchar)* pwszServerName, uint dwControlFlags, uint* pcbOut, ubyte** ppbOut);

@DllImport("ncrypt")
int NCryptRegisterProtectionDescriptorName(const(wchar)* pwszName, const(wchar)* pwszDescriptorString, 
                                           uint dwFlags);

@DllImport("ncrypt")
int NCryptQueryProtectionDescriptorName(const(wchar)* pwszName, const(wchar)* pwszDescriptorString, 
                                        size_t* pcDescriptorString, uint dwFlags);

@DllImport("ncrypt")
int NCryptCreateProtectionDescriptor(const(wchar)* pwszDescriptorString, uint dwFlags, 
                                     NCRYPT_DESCRIPTOR_HANDLE__** phDescriptor);

@DllImport("ncrypt")
int NCryptCloseProtectionDescriptor(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor);

@DllImport("ncrypt")
int NCryptGetProtectionDescriptorInfo(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, const(NCRYPT_ALLOC_PARA)* pMemPara, 
                                      uint dwInfoType, void** ppvInfo);

@DllImport("ncrypt")
int NCryptProtectSecret(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, uint dwFlags, char* pbData, uint cbData, 
                        const(NCRYPT_ALLOC_PARA)* pMemPara, HWND hWnd, ubyte** ppbProtectedBlob, 
                        uint* pcbProtectedBlob);

@DllImport("ncrypt")
int NCryptUnprotectSecret(NCRYPT_DESCRIPTOR_HANDLE__** phDescriptor, uint dwFlags, char* pbProtectedBlob, 
                          uint cbProtectedBlob, const(NCRYPT_ALLOC_PARA)* pMemPara, HWND hWnd, ubyte** ppbData, 
                          uint* pcbData);

@DllImport("ncrypt")
int NCryptStreamOpenToProtect(NCRYPT_DESCRIPTOR_HANDLE__* hDescriptor, uint dwFlags, HWND hWnd, 
                              NCRYPT_PROTECT_STREAM_INFO* pStreamInfo, NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt")
int NCryptStreamOpenToUnprotect(NCRYPT_PROTECT_STREAM_INFO* pStreamInfo, uint dwFlags, HWND hWnd, 
                                NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt")
int NCryptStreamOpenToUnprotectEx(NCRYPT_PROTECT_STREAM_INFO_EX* pStreamInfo, uint dwFlags, HWND hWnd, 
                                  NCRYPT_STREAM_HANDLE__** phStream);

@DllImport("ncrypt")
int NCryptStreamUpdate(NCRYPT_STREAM_HANDLE__* hStream, char* pbData, size_t cbData, BOOL fFinal);

@DllImport("ncrypt")
int NCryptStreamClose(NCRYPT_STREAM_HANDLE__* hStream);

@DllImport("TOKENBINDING")
int TokenBindingGenerateBinding(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(wchar)* targetURL, 
                                TOKENBINDING_TYPE bindingType, char* tlsEKM, uint tlsEKMSize, 
                                TOKENBINDING_EXTENSION_FORMAT extensionFormat, const(void)* extensionData, 
                                void** tokenBinding, uint* tokenBindingSize, TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING")
int TokenBindingGenerateMessage(char* tokenBindings, char* tokenBindingsSize, uint tokenBindingsCount, 
                                void** tokenBindingMessage, uint* tokenBindingMessageSize);

@DllImport("TOKENBINDING")
int TokenBindingVerifyMessage(char* tokenBindingMessage, uint tokenBindingMessageSize, 
                              TOKENBINDING_KEY_PARAMETERS_TYPE keyType, char* tlsEKM, uint tlsEKMSize, 
                              TOKENBINDING_RESULT_LIST** resultList);

@DllImport("TOKENBINDING")
int TokenBindingGetKeyTypesClient(TOKENBINDING_KEY_TYPES** keyTypes);

@DllImport("TOKENBINDING")
int TokenBindingGetKeyTypesServer(TOKENBINDING_KEY_TYPES** keyTypes);

@DllImport("TOKENBINDING")
int TokenBindingDeleteBinding(const(wchar)* targetURL);

@DllImport("TOKENBINDING")
int TokenBindingDeleteAllBindings();

@DllImport("TOKENBINDING")
int TokenBindingGenerateID(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, char* publicKey, uint publicKeySize, 
                           TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING")
int TokenBindingGenerateIDForUri(TOKENBINDING_KEY_PARAMETERS_TYPE keyType, const(wchar)* targetUri, 
                                 TOKENBINDING_RESULT_DATA** resultData);

@DllImport("TOKENBINDING")
int TokenBindingGetHighestSupportedVersion(ubyte* majorVersion, ubyte* minorVersion);

@DllImport("CRYPTXML")
HRESULT CryptXmlClose(void* hCryptXml);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetTransforms(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)** ppConfig);

@DllImport("CRYPTXML")
HRESULT CryptXmlOpenToEncode(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)* pConfig, uint dwFlags, const(wchar)* wszId, 
                             char* rgProperty, uint cProperty, const(CRYPT_XML_BLOB)* pEncoded, void** phSignature);

@DllImport("CRYPTXML")
HRESULT CryptXmlOpenToDecode(const(CRYPT_XML_TRANSFORM_CHAIN_CONFIG)* pConfig, uint dwFlags, char* rgProperty, 
                             uint cProperty, const(CRYPT_XML_BLOB)* pEncoded, void** phCryptXml);

@DllImport("CRYPTXML")
HRESULT CryptXmlAddObject(void* hSignatureOrObject, uint dwFlags, char* rgProperty, uint cProperty, 
                          const(CRYPT_XML_BLOB)* pEncoded, const(CRYPT_XML_OBJECT)** ppObject);

@DllImport("CRYPTXML")
HRESULT CryptXmlCreateReference(void* hCryptXml, uint dwFlags, const(wchar)* wszId, const(wchar)* wszURI, 
                                const(wchar)* wszType, const(CRYPT_XML_ALGORITHM)* pDigestMethod, uint cTransform, 
                                char* rgTransform, void** phReference);

@DllImport("CRYPTXML")
HRESULT CryptXmlDigestReference(void* hReference, uint dwFlags, CRYPT_XML_DATA_PROVIDER* pDataProviderIn);

@DllImport("CRYPTXML")
HRESULT CryptXmlSetHMACSecret(void* hSignature, char* pbSecret, uint cbSecret);

@DllImport("CRYPTXML")
HRESULT CryptXmlSign(void* hSignature, size_t hKey, uint dwKeySpec, uint dwFlags, 
                     CRYPT_XML_KEYINFO_SPEC dwKeyInfoSpec, const(void)* pvKeyInfoSpec, 
                     const(CRYPT_XML_ALGORITHM)* pSignatureMethod, const(CRYPT_XML_ALGORITHM)* pCanonicalization);

@DllImport("CRYPTXML")
HRESULT CryptXmlImportPublicKey(uint dwFlags, const(CRYPT_XML_KEY_VALUE)* pKeyValue, void** phKey);

@DllImport("CRYPTXML")
HRESULT CryptXmlVerifySignature(void* hSignature, void* hKey, uint dwFlags);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetDocContext(void* hCryptXml, const(CRYPT_XML_DOC_CTXT)** ppStruct);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetSignature(void* hCryptXml, const(CRYPT_XML_SIGNATURE)** ppStruct);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetReference(void* hCryptXml, const(CRYPT_XML_REFERENCE)** ppStruct);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetStatus(void* hCryptXml, CRYPT_XML_STATUS* pStatus);

@DllImport("CRYPTXML")
HRESULT CryptXmlEncode(void* hCryptXml, CRYPT_XML_CHARSET dwCharset, char* rgProperty, uint cProperty, 
                       void* pvCallbackState, PFN_CRYPT_XML_WRITE_CALLBACK pfnWrite);

@DllImport("CRYPTXML")
HRESULT CryptXmlGetAlgorithmInfo(const(CRYPT_XML_ALGORITHM)* pXmlAlgorithm, uint dwFlags, 
                                 CRYPT_XML_ALGORITHM_INFO** ppAlgInfo);

@DllImport("CRYPTXML")
CRYPT_XML_ALGORITHM_INFO* CryptXmlFindAlgorithmInfo(uint dwFindByType, const(void)* pvFindBy, uint dwGroupId, 
                                                    uint dwFlags);

@DllImport("CRYPTXML")
HRESULT CryptXmlEnumAlgorithmInfo(uint dwGroupId, uint dwFlags, void* pvArg, 
                                  PFN_CRYPT_XML_ENUM_ALG_INFO pfnEnumAlgInfo);

@DllImport("WINTRUST")
int WinVerifyTrust(HWND hwnd, GUID* pgActionID, void* pWVTData);

@DllImport("WINTRUST")
HRESULT WinVerifyTrustEx(HWND hwnd, GUID* pgActionID, WINTRUST_DATA* pWinTrustData);

@DllImport("WINTRUST")
void WintrustGetRegPolicyFlags(uint* pdwPolicyFlags);

@DllImport("WINTRUST")
BOOL WintrustSetRegPolicyFlags(uint dwPolicyFlags);

@DllImport("WINTRUST")
BOOL WintrustAddActionID(GUID* pgActionID, uint fdwFlags, CRYPT_REGISTER_ACTIONID* psProvInfo);

@DllImport("WINTRUST")
BOOL WintrustRemoveActionID(GUID* pgActionID);

@DllImport("WINTRUST")
BOOL WintrustLoadFunctionPointers(GUID* pgActionID, CRYPT_PROVIDER_FUNCTIONS* pPfns);

@DllImport("WINTRUST")
BOOL WintrustAddDefaultForUsage(const(byte)* pszUsageOID, CRYPT_PROVIDER_REGDEFUSAGE* psDefUsage);

@DllImport("WINTRUST")
BOOL WintrustGetDefaultForUsage(uint dwAction, const(byte)* pszUsageOID, CRYPT_PROVIDER_DEFUSAGE* psUsage);

@DllImport("WINTRUST")
CRYPT_PROVIDER_SGNR* WTHelperGetProvSignerFromChain(CRYPT_PROVIDER_DATA* pProvData, uint idxSigner, 
                                                    BOOL fCounterSigner, uint idxCounterSigner);

@DllImport("WINTRUST")
CRYPT_PROVIDER_CERT* WTHelperGetProvCertFromChain(CRYPT_PROVIDER_SGNR* pSgnr, uint idxCert);

@DllImport("WINTRUST")
CRYPT_PROVIDER_DATA* WTHelperProvDataFromStateData(HANDLE hStateData);

@DllImport("WINTRUST")
CRYPT_PROVIDER_PRIVDATA* WTHelperGetProvPrivateDataFromChain(CRYPT_PROVIDER_DATA* pProvData, GUID* pgProviderID);

@DllImport("WINTRUST")
BOOL WTHelperCertIsSelfSigned(uint dwEncoding, CERT_INFO* pCert);

@DllImport("WINTRUST")
HRESULT WTHelperCertCheckValidSignature(CRYPT_PROVIDER_DATA* pProvData);

@DllImport("WINTRUST")
BOOL OpenPersonalTrustDBDialogEx(HWND hwndParent, uint dwFlags, void** pvReserved);

@DllImport("WINTRUST")
BOOL OpenPersonalTrustDBDialog(HWND hwndParent);

@DllImport("WINTRUST")
void WintrustSetDefaultIncludePEPageHashes(BOOL fIncludePEPageHashes);

@DllImport("CRYPTUI")
BOOL CryptUIDlgViewContext(uint dwContextType, const(void)* pvContext, HWND hwnd, const(wchar)* pwszTitle, 
                           uint dwFlags, void* pvReserved);

@DllImport("CRYPTUI")
CERT_CONTEXT* CryptUIDlgSelectCertificateFromStore(void* hCertStore, HWND hwnd, const(wchar)* pwszTitle, 
                                                   const(wchar)* pwszDisplayString, uint dwDontUseColumn, 
                                                   uint dwFlags, void* pvReserved);

@DllImport("CRYPTUI")
HRESULT CertSelectionGetSerializedBlob(CERT_SELECTUI_INPUT* pcsi, void** ppOutBuffer, uint* pulOutBufferSize);

@DllImport("CRYPTUI")
BOOL CryptUIDlgCertMgr(CRYPTUI_CERT_MGR_STRUCT* pCryptUICertMgr);

@DllImport("CRYPTUI")
BOOL CryptUIWizDigitalSign(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, 
                           CRYPTUI_WIZ_DIGITAL_SIGN_INFO* pDigitalSignInfo, 
                           CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT** ppSignContext);

@DllImport("CRYPTUI")
BOOL CryptUIWizFreeDigitalSignContext(CRYPTUI_WIZ_DIGITAL_SIGN_CONTEXT* pSignContext);

@DllImport("CRYPTUI")
BOOL CryptUIDlgViewCertificateW(CRYPTUI_VIEWCERTIFICATE_STRUCTW* pCertViewInfo, int* pfPropertiesChanged);

@DllImport("CRYPTUI")
BOOL CryptUIDlgViewCertificateA(CRYPTUI_VIEWCERTIFICATE_STRUCTA* pCertViewInfo, int* pfPropertiesChanged);

@DllImport("CRYPTUI")
BOOL CryptUIWizExport(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, 
                      CRYPTUI_WIZ_EXPORT_INFO* pExportInfo, void* pvoid);

@DllImport("CRYPTUI")
BOOL CryptUIWizImport(uint dwFlags, HWND hwndParent, const(wchar)* pwszWizardTitle, 
                      CRYPTUI_WIZ_IMPORT_SRC_INFO* pImportSrc, void* hDestCertStore);

@DllImport("CRYPT32")
BOOL CryptSIPGetSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint* pdwEncodingType, uint dwIndex, 
                              uint* pcbSignedDataMsg, ubyte* pbSignedDataMsg);

@DllImport("CRYPT32")
BOOL CryptSIPPutSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint dwEncodingType, uint* pdwIndex, 
                              uint cbSignedDataMsg, ubyte* pbSignedDataMsg);

@DllImport("CRYPT32")
BOOL CryptSIPCreateIndirectData(SIP_SUBJECTINFO* pSubjectInfo, uint* pcbIndirectData, 
                                SIP_INDIRECT_DATA* pIndirectData);

@DllImport("CRYPT32")
BOOL CryptSIPVerifyIndirectData(SIP_SUBJECTINFO* pSubjectInfo, SIP_INDIRECT_DATA* pIndirectData);

@DllImport("CRYPT32")
BOOL CryptSIPRemoveSignedDataMsg(SIP_SUBJECTINFO* pSubjectInfo, uint dwIndex);

@DllImport("CRYPT32")
BOOL CryptSIPLoad(const(GUID)* pgSubject, uint dwFlags, SIP_DISPATCH_INFO* pSipDispatch);

@DllImport("CRYPT32")
BOOL CryptSIPRetrieveSubjectGuid(const(wchar)* FileName, HANDLE hFileIn, GUID* pgSubject);

@DllImport("CRYPT32")
BOOL CryptSIPRetrieveSubjectGuidForCatalogFile(const(wchar)* FileName, HANDLE hFileIn, GUID* pgSubject);

@DllImport("CRYPT32")
BOOL CryptSIPAddProvider(SIP_ADD_NEWPROVIDER* psNewProv);

@DllImport("CRYPT32")
BOOL CryptSIPRemoveProvider(GUID* pgProv);

@DllImport("CRYPT32")
BOOL CryptSIPGetCaps(SIP_SUBJECTINFO* pSubjInfo, SIP_CAP_SET_V3* pCaps);

@DllImport("CRYPT32")
BOOL CryptSIPGetSealedDigest(SIP_SUBJECTINFO* pSubjectInfo, char* pSig, uint dwSig, char* pbDigest, 
                             uint* pcbDigest);

@DllImport("WINTRUST")
HANDLE CryptCATOpen(const(wchar)* pwszFileName, uint fdwOpenFlags, size_t hProv, uint dwPublicVersion, 
                    uint dwEncodingType);

@DllImport("WINTRUST")
BOOL CryptCATClose(HANDLE hCatalog);

@DllImport("WINTRUST")
CRYPTCATSTORE* CryptCATStoreFromHandle(HANDLE hCatalog);

@DllImport("WINTRUST")
HANDLE CryptCATHandleFromStore(CRYPTCATSTORE* pCatStore);

@DllImport("WINTRUST")
BOOL CryptCATPersistStore(HANDLE hCatalog);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATGetCatAttrInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATPutCatAttrInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag, 
                                          uint dwAttrTypeAndAction, uint cbData, ubyte* pbData);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATEnumerateCatAttr(HANDLE hCatalog, CRYPTCATATTRIBUTE* pPrevAttr);

@DllImport("WINTRUST")
CRYPTCATMEMBER* CryptCATGetMemberInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST")
CRYPTCATMEMBER* CryptCATAllocSortedMemberInfo(HANDLE hCatalog, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST")
void CryptCATFreeSortedMemberInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATGetAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, const(wchar)* pwszReferenceTag);

@DllImport("WINTRUST")
CRYPTCATMEMBER* CryptCATPutMemberInfo(HANDLE hCatalog, const(wchar)* pwszFileName, const(wchar)* pwszReferenceTag, 
                                      GUID* pgSubjectType, uint dwCertVersion, uint cbSIPIndirectData, 
                                      ubyte* pbSIPIndirectData);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATPutAttrInfo(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, const(wchar)* pwszReferenceTag, 
                                       uint dwAttrTypeAndAction, uint cbData, ubyte* pbData);

@DllImport("WINTRUST")
CRYPTCATMEMBER* CryptCATEnumerateMember(HANDLE hCatalog, CRYPTCATMEMBER* pPrevMember);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATEnumerateAttr(HANDLE hCatalog, CRYPTCATMEMBER* pCatMember, CRYPTCATATTRIBUTE* pPrevAttr);

@DllImport("WINTRUST")
CRYPTCATCDF* CryptCATCDFOpen(const(wchar)* pwszFilePath, PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST")
BOOL CryptCATCDFClose(CRYPTCATCDF* pCDF);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATCDFEnumCatAttributes(CRYPTCATCDF* pCDF, CRYPTCATATTRIBUTE* pPrevAttr, 
                                                PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST")
CRYPTCATMEMBER* CryptCATCDFEnumMembers(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pPrevMember, 
                                       PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST")
CRYPTCATATTRIBUTE* CryptCATCDFEnumAttributes(CRYPTCATCDF* pCDF, CRYPTCATMEMBER* pMember, 
                                             CRYPTCATATTRIBUTE* pPrevAttr, 
                                             PFN_CDF_PARSE_ERROR_CALLBACK pfnParseError);

@DllImport("WINTRUST")
BOOL IsCatalogFile(HANDLE hFile, ushort* pwszFileName);

@DllImport("WINTRUST")
BOOL CryptCATAdminAcquireContext(ptrdiff_t* phCatAdmin, const(GUID)* pgSubsystem, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminAcquireContext2(ptrdiff_t* phCatAdmin, const(GUID)* pgSubsystem, const(wchar)* pwszHashAlgorithm, 
                                  CERT_STRONG_SIGN_PARA* pStrongHashPolicy, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminReleaseContext(ptrdiff_t hCatAdmin, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminReleaseCatalogContext(ptrdiff_t hCatAdmin, ptrdiff_t hCatInfo, uint dwFlags);

@DllImport("WINTRUST")
ptrdiff_t CryptCATAdminEnumCatalogFromHash(ptrdiff_t hCatAdmin, char* pbHash, uint cbHash, uint dwFlags, 
                                           ptrdiff_t* phPrevCatInfo);

@DllImport("WINTRUST")
BOOL CryptCATAdminCalcHashFromFileHandle(HANDLE hFile, uint* pcbHash, char* pbHash, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminCalcHashFromFileHandle2(ptrdiff_t hCatAdmin, HANDLE hFile, uint* pcbHash, char* pbHash, 
                                          uint dwFlags);

@DllImport("WINTRUST")
ptrdiff_t CryptCATAdminAddCatalog(ptrdiff_t hCatAdmin, const(wchar)* pwszCatalogFile, 
                                  const(wchar)* pwszSelectBaseName, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminRemoveCatalog(ptrdiff_t hCatAdmin, const(wchar)* pwszCatalogFile, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATCatalogInfoFromContext(ptrdiff_t hCatInfo, CATALOG_INFO* psCatInfo, uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminResolveCatalogPath(ptrdiff_t hCatAdmin, ushort* pwszCatalogFile, CATALOG_INFO* psCatInfo, 
                                     uint dwFlags);

@DllImport("WINTRUST")
BOOL CryptCATAdminPauseServiceForBackup(uint dwFlags, BOOL fResume);

@DllImport("ADVAPI32")
BOOL SaferGetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, 
                               char* InfoBuffer, uint* InfoBufferRetSize, void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferSetPolicyInformation(uint dwScopeId, SAFER_POLICY_INFO_CLASS SaferPolicyInfoClass, uint InfoBufferSize, 
                               char* InfoBuffer, void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferCreateLevel(uint dwScopeId, uint dwLevelId, uint OpenFlags, SAFER_LEVEL_HANDLE__** pLevelHandle, 
                      void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferCloseLevel(SAFER_LEVEL_HANDLE__* hLevelHandle);

@DllImport("ADVAPI32")
BOOL SaferIdentifyLevel(uint dwNumProperties, char* pCodeProperties, SAFER_LEVEL_HANDLE__** pLevelHandle, 
                        void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferComputeTokenFromLevel(SAFER_LEVEL_HANDLE__* LevelHandle, HANDLE InAccessToken, ptrdiff_t* OutAccessToken, 
                                uint dwFlags, void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferGetLevelInformation(SAFER_LEVEL_HANDLE__* LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, 
                              char* lpQueryBuffer, uint dwInBufferSize, uint* lpdwOutBufferSize);

@DllImport("ADVAPI32")
BOOL SaferSetLevelInformation(SAFER_LEVEL_HANDLE__* LevelHandle, SAFER_OBJECT_INFO_CLASS dwInfoType, 
                              char* lpQueryBuffer, uint dwInBufferSize);

@DllImport("ADVAPI32")
BOOL SaferRecordEventLogEntry(SAFER_LEVEL_HANDLE__* hLevel, const(wchar)* szTargetPath, void* lpReserved);

@DllImport("ADVAPI32")
BOOL SaferiIsExecutableFileType(const(wchar)* szFullPathname, ubyte bFromShellExecute);

@DllImport("SLC")
HRESULT SLOpen(void** phSLC);

@DllImport("SLC")
HRESULT SLClose(void* hSLC);

@DllImport("SLC")
HRESULT SLInstallProofOfPurchase(void* hSLC, const(wchar)* pwszPKeyAlgorithm, const(wchar)* pwszPKeyString, 
                                 uint cbPKeySpecificData, char* pbPKeySpecificData, GUID* pPkeyId);

@DllImport("SLC")
HRESULT SLUninstallProofOfPurchase(void* hSLC, const(GUID)* pPKeyId);

@DllImport("SLC")
HRESULT SLInstallLicense(void* hSLC, uint cbLicenseBlob, char* pbLicenseBlob, GUID* pLicenseFileId);

@DllImport("SLC")
HRESULT SLUninstallLicense(void* hSLC, const(GUID)* pLicenseFileId);

@DllImport("SLC")
HRESULT SLConsumeRight(void* hSLC, const(GUID)* pAppId, const(GUID)* pProductSkuId, const(wchar)* pwszRightName, 
                       void* pvReserved);

@DllImport("SLC")
HRESULT SLGetProductSkuInformation(void* hSLC, const(GUID)* pProductSkuId, const(wchar)* pwszValueName, 
                                   SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetPKeyInformation(void* hSLC, const(GUID)* pPKeyId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, 
                             uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetLicenseInformation(void* hSLC, const(GUID)* pSLLicenseId, const(wchar)* pwszValueName, 
                                SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetLicensingStatusInformation(void* hSLC, const(GUID)* pAppID, const(GUID)* pProductSkuId, 
                                        const(wchar)* pwszRightName, uint* pnStatusCount, 
                                        SL_LICENSING_STATUS** ppLicensingStatus);

@DllImport("SLC")
HRESULT SLGetPolicyInformation(void* hSLC, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                               ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetPolicyInformationDWORD(void* hSLC, const(wchar)* pwszValueName, uint* pdwValue);

@DllImport("SLC")
HRESULT SLGetServiceInformation(void* hSLC, const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                                ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetApplicationInformation(void* hSLC, const(GUID)* pApplicationId, const(wchar)* pwszValueName, 
                                    SLDATATYPE* peDataType, uint* pcbValue, ubyte** ppbValue);

@DllImport("slcext")
HRESULT SLActivateProduct(void* hSLC, const(GUID)* pProductSkuId, uint cbAppSpecificData, 
                          const(void)* pvAppSpecificData, const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                          const(wchar)* pwszProxyServer, ushort wProxyPort);

@DllImport("slcext")
HRESULT SLGetServerStatus(const(wchar)* pwszServerURL, const(wchar)* pwszAcquisitionType, 
                          const(wchar)* pwszProxyServer, ushort wProxyPort, int* phrStatus);

@DllImport("SLC")
HRESULT SLGenerateOfflineInstallationId(void* hSLC, const(GUID)* pProductSkuId, ushort** ppwszInstallationId);

@DllImport("SLC")
HRESULT SLGenerateOfflineInstallationIdEx(void* hSLC, const(GUID)* pProductSkuId, 
                                          const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                                          ushort** ppwszInstallationId);

@DllImport("SLC")
HRESULT SLDepositOfflineConfirmationId(void* hSLC, const(GUID)* pProductSkuId, const(wchar)* pwszInstallationId, 
                                       const(wchar)* pwszConfirmationId);

@DllImport("SLC")
HRESULT SLDepositOfflineConfirmationIdEx(void* hSLC, const(GUID)* pProductSkuId, 
                                         const(SL_ACTIVATION_INFO_HEADER)* pActivationInfo, 
                                         const(wchar)* pwszInstallationId, const(wchar)* pwszConfirmationId);

@DllImport("SLC")
HRESULT SLGetPKeyId(void* hSLC, const(wchar)* pwszPKeyAlgorithm, const(wchar)* pwszPKeyString, 
                    uint cbPKeySpecificData, char* pbPKeySpecificData, GUID* pPKeyId);

@DllImport("SLC")
HRESULT SLGetInstalledProductKeyIds(void* hSLC, const(GUID)* pProductSkuId, uint* pnProductKeyIds, 
                                    GUID** ppProductKeyIds);

@DllImport("SLC")
HRESULT SLSetCurrentProductKey(void* hSLC, const(GUID)* pProductSkuId, const(GUID)* pProductKeyId);

@DllImport("SLC")
HRESULT SLGetSLIDList(void* hSLC, SLIDTYPE eQueryIdType, const(GUID)* pQueryId, SLIDTYPE eReturnIdType, 
                      uint* pnReturnIds, GUID** ppReturnIds);

@DllImport("SLC")
HRESULT SLGetLicenseFileId(void* hSLC, uint cbLicenseBlob, char* pbLicenseBlob, GUID* pLicenseFileId);

@DllImport("SLC")
HRESULT SLGetLicense(void* hSLC, const(GUID)* pLicenseFileId, uint* pcbLicenseFile, ubyte** ppbLicenseFile);

@DllImport("SLC")
HRESULT SLFireEvent(void* hSLC, const(wchar)* pwszEventId, const(GUID)* pApplicationId);

@DllImport("SLC")
HRESULT SLRegisterEvent(void* hSLC, const(wchar)* pwszEventId, const(GUID)* pApplicationId, HANDLE hEvent);

@DllImport("SLC")
HRESULT SLUnregisterEvent(void* hSLC, const(wchar)* pwszEventId, const(GUID)* pApplicationId, HANDLE hEvent);

@DllImport("SLC")
HRESULT SLGetWindowsInformation(const(wchar)* pwszValueName, SLDATATYPE* peDataType, uint* pcbValue, 
                                ubyte** ppbValue);

@DllImport("SLC")
HRESULT SLGetWindowsInformationDWORD(const(wchar)* pwszValueName, uint* pdwValue);

@DllImport("SLWGA")
HRESULT SLIsGenuineLocal(const(GUID)* pAppId, SL_GENUINE_STATE* pGenuineState, 
                         SL_NONGENUINE_UI_OPTIONS* pUIOptions);

@DllImport("slcext")
HRESULT SLAcquireGenuineTicket(void** ppTicketBlob, uint* pcbTicketBlob, const(wchar)* pwszTemplateId, 
                               const(wchar)* pwszServerUrl, const(wchar)* pwszClientToken);

@DllImport("SLC")
HRESULT SLSetGenuineInformation(const(GUID)* pQueryId, const(wchar)* pwszValueName, SLDATATYPE eDataType, 
                                uint cbValue, char* pbValue);

@DllImport("slcext")
HRESULT SLGetReferralInformation(void* hSLC, SLREFERRALTYPE eReferralType, const(GUID)* pSkuOrAppId, 
                                 const(wchar)* pwszValueName, ushort** ppwszValue);

@DllImport("SLC")
HRESULT SLGetGenuineInformation(const(GUID)* pQueryId, const(wchar)* pwszValueName, SLDATATYPE* peDataType, 
                                uint* pcbValue, ubyte** ppbValue);

@DllImport("api-ms-win-core-slapi-l1-1-0")
HRESULT SLQueryLicenseValueFromApp(const(wchar)* valueName, uint* valueType, char* dataBuffer, uint dataSize, 
                                   uint* resultDataSize);

@DllImport("DiagnosticDataQuery")
HRESULT DdqCreateSession(DdqAccessLevel accessLevel, HDIAGNOSTIC_DATA_QUERY_SESSION__** hSession);

@DllImport("DiagnosticDataQuery")
HRESULT DdqCloseSession(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetSessionAccessLevel(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, DdqAccessLevel* accessLevel);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticDataAccessLevelAllowed(DdqAccessLevel* accessLevel);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordStats(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                    const(DIAGNOSTIC_DATA_SEARCH_CRITERIA)* searchCriteria, uint* recordCount, 
                                    long* minRowId, long* maxRowId);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordPayload(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, long rowId, ushort** payload);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordLocaleTags(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(wchar)* locale, 
                                         HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__** hTagDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqFreeDiagnosticRecordLocaleTags(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordLocaleTagAtIndex(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription, uint index, 
                                               DIAGNOSTIC_DATA_EVENT_TAG_DESCRIPTION* tagDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordLocaleTagCount(HDIAGNOSTIC_EVENT_TAG_DESCRIPTION__* hTagDescription, 
                                             uint* tagDescriptionCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordProducers(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                        HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__** hProducerDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqFreeDiagnosticRecordProducers(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordProducerAtIndex(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription, 
                                              uint index, 
                                              DIAGNOSTIC_DATA_EVENT_PRODUCER_DESCRIPTION* producerDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordProducerCount(HDIAGNOSTIC_EVENT_PRODUCER_DESCRIPTION__* hProducerDescription, 
                                            uint* producerDescriptionCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordProducerCategories(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                                 const(wchar)* producerName, 
                                                 HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__** hCategoryDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqFreeDiagnosticRecordProducerCategories(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordCategoryAtIndex(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription, 
                                              uint index, 
                                              DIAGNOSTIC_DATA_EVENT_CATEGORY_DESCRIPTION* categoryDescription);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordCategoryCount(HDIAGNOSTIC_EVENT_CATEGORY_DESCRIPTION__* hCategoryDescription, 
                                            uint* categoryDescriptionCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqIsDiagnosticRecordSampledIn(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, const(GUID)* providerGroup, 
                                       const(GUID)* providerId, const(wchar)* providerName, const(uint)* eventId, 
                                       const(wchar)* eventName, const(uint)* eventVersion, 
                                       const(ulong)* eventKeywords, int* isSampledIn);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordPage(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                   DIAGNOSTIC_DATA_SEARCH_CRITERIA* searchCriteria, uint offset, 
                                   uint pageRecordCount, long baseRowId, HDIAGNOSTIC_RECORD__** hRecord);

@DllImport("DiagnosticDataQuery")
HRESULT DdqFreeDiagnosticRecordPage(HDIAGNOSTIC_RECORD__* hRecord);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordAtIndex(HDIAGNOSTIC_RECORD__* hRecord, uint index, DIAGNOSTIC_DATA_RECORD* record);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordCount(HDIAGNOSTIC_RECORD__* hRecord, uint* recordCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticReportStoreReportCount(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, 
                                               uint* reportCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqCancelDiagnosticRecordOperation(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, 
                               HDIAGNOSTIC_REPORT__** hReport);

@DllImport("DiagnosticDataQuery")
HRESULT DdqFreeDiagnosticReport(HDIAGNOSTIC_REPORT__* hReport);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticReportAtIndex(HDIAGNOSTIC_REPORT__* hReport, uint index, DIAGNOSTIC_REPORT_DATA* report);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticReportCount(HDIAGNOSTIC_REPORT__* hReport, uint* reportCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqExtractDiagnosticReport(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, uint reportStoreType, 
                                   const(wchar)* reportKey, const(wchar)* destinationPath);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordTagDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, 
                                              uint producerNameCount, char* tagStats, uint* statCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordBinaryDistribution(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, 
                                                 uint producerNameCount, uint topNBinaries, char* binaryStats, 
                                                 uint* statCount);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetDiagnosticRecordSummary(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, char* producerNames, 
                                      uint producerNameCount, DIAGNOSTIC_DATA_GENERAL_STATS* generalStats);

@DllImport("DiagnosticDataQuery")
HRESULT DdqSetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                      const(DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION)* desiredConfig);

@DllImport("DiagnosticDataQuery")
HRESULT DdqGetTranscriptConfiguration(HDIAGNOSTIC_DATA_QUERY_SESSION__* hSession, 
                                      DIAGNOSTIC_DATA_EVENT_TRANSCRIPT_CONFIGURATION* currentConfig);

@DllImport("ADVAPI32")
BOOL SetThreadToken(ptrdiff_t* Thread, HANDLE Token);

@DllImport("ADVAPI32")
BOOL OpenProcessToken(HANDLE ProcessHandle, uint DesiredAccess, ptrdiff_t* TokenHandle);

@DllImport("ADVAPI32")
BOOL OpenThreadToken(HANDLE ThreadHandle, uint DesiredAccess, BOOL OpenAsSelf, ptrdiff_t* TokenHandle);

@DllImport("KERNEL32")
BOOL InstallELAMCertificateInfo(HANDLE ELAMFile);

@DllImport("ADVAPI32")
BOOL AccessCheckAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, 
                               const(char)* ObjectName, void* SecurityDescriptor, uint DesiredAccess, 
                               GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                               int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, 
                                     const(char)* ObjectName, void* SecurityDescriptor, void* PrincipalSelfSid, 
                                     uint DesiredAccess, AUDIT_EVENT_TYPE AuditType, uint Flags, 
                                     char* ObjectTypeList, uint ObjectTypeListLength, 
                                     GENERIC_MAPPING* GenericMapping, BOOL ObjectCreation, uint* GrantedAccess, 
                                     int* AccessStatus, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeResultListAndAuditAlarmA(const(char)* SubsystemName, void* HandleId, 
                                               const(char)* ObjectTypeName, const(char)* ObjectName, 
                                               void* SecurityDescriptor, void* PrincipalSelfSid, uint DesiredAccess, 
                                               AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, 
                                               uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                                               BOOL ObjectCreation, char* GrantedAccess, char* AccessStatusList, 
                                               int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL AccessCheckByTypeResultListAndAuditAlarmByHandleA(const(char)* SubsystemName, void* HandleId, 
                                                       HANDLE ClientToken, const(char)* ObjectTypeName, 
                                                       const(char)* ObjectName, void* SecurityDescriptor, 
                                                       void* PrincipalSelfSid, uint DesiredAccess, 
                                                       AUDIT_EVENT_TYPE AuditType, uint Flags, char* ObjectTypeList, 
                                                       uint ObjectTypeListLength, GENERIC_MAPPING* GenericMapping, 
                                                       BOOL ObjectCreation, char* GrantedAccess, 
                                                       char* AccessStatusList, int* pfGenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectOpenAuditAlarmA(const(char)* SubsystemName, void* HandleId, const(char)* ObjectTypeName, 
                           const(char)* ObjectName, void* pSecurityDescriptor, HANDLE ClientToken, 
                           uint DesiredAccess, uint GrantedAccess, PRIVILEGE_SET* Privileges, BOOL ObjectCreation, 
                           BOOL AccessGranted, int* GenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectPrivilegeAuditAlarmA(const(char)* SubsystemName, void* HandleId, HANDLE ClientToken, uint DesiredAccess, 
                                PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32")
BOOL ObjectCloseAuditAlarmA(const(char)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32")
BOOL ObjectDeleteAuditAlarmA(const(char)* SubsystemName, void* HandleId, BOOL GenerateOnClose);

@DllImport("ADVAPI32")
BOOL PrivilegedServiceAuditAlarmA(const(char)* SubsystemName, const(char)* ServiceName, HANDLE ClientToken, 
                                  PRIVILEGE_SET* Privileges, BOOL AccessGranted);

@DllImport("ADVAPI32")
BOOL AddConditionalAce(ACL* pAcl, uint dwAceRevision, uint AceFlags, ubyte AceType, uint AccessMask, void* pSid, 
                       const(wchar)* ConditionStr, uint* ReturnLength);

@DllImport("ADVAPI32")
BOOL SetFileSecurityA(const(char)* lpFileName, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ADVAPI32")
BOOL GetFileSecurityA(const(char)* lpFileName, uint RequestedInformation, char* pSecurityDescriptor, uint nLength, 
                      uint* lpnLengthNeeded);

@DllImport("ADVAPI32")
BOOL LookupAccountSidA(const(char)* lpSystemName, void* Sid, const(char)* Name, uint* cchName, 
                       const(char)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32")
BOOL LookupAccountSidW(const(wchar)* lpSystemName, void* Sid, const(wchar)* Name, uint* cchName, 
                       const(wchar)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32")
BOOL LookupAccountNameA(const(char)* lpSystemName, const(char)* lpAccountName, char* Sid, uint* cbSid, 
                        const(char)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32")
BOOL LookupAccountNameW(const(wchar)* lpSystemName, const(wchar)* lpAccountName, char* Sid, uint* cbSid, 
                        const(wchar)* ReferencedDomainName, uint* cchReferencedDomainName, SID_NAME_USE* peUse);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeValueA(const(char)* lpSystemName, const(char)* lpName, LUID* lpLuid);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeValueW(const(wchar)* lpSystemName, const(wchar)* lpName, LUID* lpLuid);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeNameA(const(char)* lpSystemName, LUID* lpLuid, const(char)* lpName, uint* cchName);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeNameW(const(wchar)* lpSystemName, LUID* lpLuid, const(wchar)* lpName, uint* cchName);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeDisplayNameA(const(char)* lpSystemName, const(char)* lpName, const(char)* lpDisplayName, 
                                 uint* cchDisplayName, uint* lpLanguageId);

@DllImport("ADVAPI32")
BOOL LookupPrivilegeDisplayNameW(const(wchar)* lpSystemName, const(wchar)* lpName, const(wchar)* lpDisplayName, 
                                 uint* cchDisplayName, uint* lpLanguageId);

@DllImport("ADVAPI32")
BOOL LogonUserA(const(char)* lpszUsername, const(char)* lpszDomain, const(char)* lpszPassword, uint dwLogonType, 
                uint dwLogonProvider, ptrdiff_t* phToken);

@DllImport("ADVAPI32")
BOOL LogonUserW(const(wchar)* lpszUsername, const(wchar)* lpszDomain, const(wchar)* lpszPassword, uint dwLogonType, 
                uint dwLogonProvider, ptrdiff_t* phToken);

@DllImport("ADVAPI32")
BOOL LogonUserExA(const(char)* lpszUsername, const(char)* lpszDomain, const(char)* lpszPassword, uint dwLogonType, 
                  uint dwLogonProvider, ptrdiff_t* phToken, void** ppLogonSid, char* ppProfileBuffer, 
                  uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

@DllImport("ADVAPI32")
BOOL LogonUserExW(const(wchar)* lpszUsername, const(wchar)* lpszDomain, const(wchar)* lpszPassword, 
                  uint dwLogonType, uint dwLogonProvider, ptrdiff_t* phToken, void** ppLogonSid, 
                  char* ppProfileBuffer, uint* pdwProfileLength, QUOTA_LIMITS* pQuotaLimits);

@DllImport("ADVAPI32")
LSTATUS RegGetKeySecurity(HKEY hKey, uint SecurityInformation, char* pSecurityDescriptor, 
                          uint* lpcbSecurityDescriptor);

@DllImport("ADVAPI32")
LSTATUS RegSetKeySecurity(HKEY hKey, uint SecurityInformation, void* pSecurityDescriptor);

@DllImport("ntdll")
NTSTATUS RtlConvertSidToUnicodeString(UNICODE_STRING* UnicodeString, void* Sid, ubyte AllocateDestinationString);


// Interfaces

@GUID("16A18E86-7F6E-4C20-AD89-4FFC0DB7A96A")
struct TpmVirtualSmartCardManager;

@GUID("152EA2A8-70DC-4C59-8B2A-32AA3CA0DCAC")
struct RemoteTpmVirtualSmartCardManager;

@GUID("30D49246-D217-465F-B00B-AC9DDD652EB7")
struct CoClassIdentityStore;

@GUID("ECF5BF46-E3B6-449A-B56B-43F58F867814")
struct CIdentityProfileHandler;

@GUID("B2BCFF59-A757-4B0B-A1BC-EA69981DA69E")
struct AzAuthorizationStore;

@GUID("5C2DC96F-8D51-434B-B33C-379BCCAE77C3")
struct AzBizRuleContext;

@GUID("483AFB5D-70DF-4E16-ABDC-A1DE4D015A3E")
struct AzPrincipalLocator;

@GUID("884E2000-217D-11DA-B2A4-000E7BBB2B09")
struct CObjectId;

@GUID("884E2001-217D-11DA-B2A4-000E7BBB2B09")
struct CObjectIds;

@GUID("884E2002-217D-11DA-B2A4-000E7BBB2B09")
struct CBinaryConverter;

@GUID("884E2003-217D-11DA-B2A4-000E7BBB2B09")
struct CX500DistinguishedName;

@GUID("884E2007-217D-11DA-B2A4-000E7BBB2B09")
struct CCspInformation;

@GUID("884E2008-217D-11DA-B2A4-000E7BBB2B09")
struct CCspInformations;

@GUID("884E2009-217D-11DA-B2A4-000E7BBB2B09")
struct CCspStatus;

@GUID("884E200B-217D-11DA-B2A4-000E7BBB2B09")
struct CX509PublicKey;

@GUID("884E200C-217D-11DA-B2A4-000E7BBB2B09")
struct CX509PrivateKey;

@GUID("11A25A1D-B9A3-4EDD-AF83-3B59ADBED361")
struct CX509EndorsementKey;

@GUID("884E200D-217D-11DA-B2A4-000E7BBB2B09")
struct CX509Extension;

@GUID("884E200E-217D-11DA-B2A4-000E7BBB2B09")
struct CX509Extensions;

@GUID("884E200F-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionKeyUsage;

@GUID("884E2010-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionEnhancedKeyUsage;

@GUID("884E2011-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionTemplateName;

@GUID("884E2012-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionTemplate;

@GUID("884E2013-217D-11DA-B2A4-000E7BBB2B09")
struct CAlternativeName;

@GUID("884E2014-217D-11DA-B2A4-000E7BBB2B09")
struct CAlternativeNames;

@GUID("884E2015-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionAlternativeNames;

@GUID("884E2016-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionBasicConstraints;

@GUID("884E2017-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionSubjectKeyIdentifier;

@GUID("884E2018-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionAuthorityKeyIdentifier;

@GUID("884E2019-217D-11DA-B2A4-000E7BBB2B09")
struct CSmimeCapability;

@GUID("884E201A-217D-11DA-B2A4-000E7BBB2B09")
struct CSmimeCapabilities;

@GUID("884E201B-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionSmimeCapabilities;

@GUID("884E201C-217D-11DA-B2A4-000E7BBB2B09")
struct CPolicyQualifier;

@GUID("884E201D-217D-11DA-B2A4-000E7BBB2B09")
struct CPolicyQualifiers;

@GUID("884E201E-217D-11DA-B2A4-000E7BBB2B09")
struct CCertificatePolicy;

@GUID("884E201F-217D-11DA-B2A4-000E7BBB2B09")
struct CCertificatePolicies;

@GUID("884E2020-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionCertificatePolicies;

@GUID("884E2021-217D-11DA-B2A4-000E7BBB2B09")
struct CX509ExtensionMSApplicationPolicies;

@GUID("884E2022-217D-11DA-B2A4-000E7BBB2B09")
struct CX509Attribute;

@GUID("884E2023-217D-11DA-B2A4-000E7BBB2B09")
struct CX509Attributes;

@GUID("884E2024-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeExtensions;

@GUID("884E2025-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeClientId;

@GUID("884E2026-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeRenewalCertificate;

@GUID("884E2027-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeArchiveKey;

@GUID("884E2028-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeArchiveKeyHash;

@GUID("884E202A-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeOSVersion;

@GUID("884E202B-217D-11DA-B2A4-000E7BBB2B09")
struct CX509AttributeCspProvider;

@GUID("884E202C-217D-11DA-B2A4-000E7BBB2B09")
struct CCryptAttribute;

@GUID("884E202D-217D-11DA-B2A4-000E7BBB2B09")
struct CCryptAttributes;

@GUID("884E202E-217D-11DA-B2A4-000E7BBB2B09")
struct CCertProperty;

@GUID("884E202F-217D-11DA-B2A4-000E7BBB2B09")
struct CCertProperties;

@GUID("884E2030-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyFriendlyName;

@GUID("884E2031-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyDescription;

@GUID("884E2032-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyAutoEnroll;

@GUID("884E2033-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyRequestOriginator;

@GUID("884E2034-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertySHA1Hash;

@GUID("884E2036-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyKeyProvInfo;

@GUID("884E2037-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyArchived;

@GUID("884E2038-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyBackedUp;

@GUID("884E2039-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyEnrollment;

@GUID("884E203A-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyRenewal;

@GUID("884E203B-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyArchivedKeyHash;

@GUID("884E204C-217D-11DA-B2A4-000E7BBB2B09")
struct CCertPropertyEnrollmentPolicyServer;

@GUID("884E203D-217D-11DA-B2A4-000E7BBB2B09")
struct CSignerCertificate;

@GUID("884E203F-217D-11DA-B2A4-000E7BBB2B09")
struct CX509NameValuePair;

@GUID("1362ADA1-EB60-456A-B6E1-118050DB741B")
struct CCertificateAttestationChallenge;

@GUID("884E2042-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRequestPkcs10;

@GUID("884E2043-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRequestCertificate;

@GUID("884E2044-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRequestPkcs7;

@GUID("884E2045-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRequestCmc;

@GUID("884E2046-217D-11DA-B2A4-000E7BBB2B09")
struct CX509Enrollment;

@GUID("884E2049-217D-11DA-B2A4-000E7BBB2B09")
struct CX509EnrollmentWebClassFactory;

@GUID("884E2050-217D-11DA-B2A4-000E7BBB2B09")
struct CX509EnrollmentHelper;

@GUID("884E2051-217D-11DA-B2A4-000E7BBB2B09")
struct CX509MachineEnrollmentFactory;

@GUID("91F39027-217F-11DA-B2A4-000E7BBB2B09")
struct CX509EnrollmentPolicyActiveDirectory;

@GUID("91F39028-217F-11DA-B2A4-000E7BBB2B09")
struct CX509EnrollmentPolicyWebService;

@GUID("91F39029-217F-11DA-B2A4-000E7BBB2B09")
struct CX509PolicyServerListManager;

@GUID("91F3902A-217F-11DA-B2A4-000E7BBB2B09")
struct CX509PolicyServerUrl;

@GUID("8336E323-2E6A-4A04-937C-548F681839B3")
struct CX509CertificateTemplateADWritable;

@GUID("884E205E-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRevocationListEntry;

@GUID("884E205F-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRevocationListEntries;

@GUID("884E2060-217D-11DA-B2A4-000E7BBB2B09")
struct CX509CertificateRevocationList;

@GUID("884E2061-217D-11DA-B2A4-000E7BBB2B09")
struct CX509SCEPEnrollment;

@GUID("884E2062-217D-11DA-B2A4-000E7BBB2B09")
struct CX509SCEPEnrollmentHelper;

@GUID("C6CC49B0-CE17-11D0-8833-00A0C903B83C")
struct CCertGetConfig;

@GUID("372FCE38-4324-11D0-8810-00A0C903B83C")
struct CCertConfig;

@GUID("98AFF3F0-5524-11D0-8812-00A0C903B83C")
struct CCertRequest;

@GUID("AA000926-FFBE-11CF-8800-00A0C903B83C")
struct CCertServerPolicy;

@GUID("4C4A5E40-732C-11D0-8816-00A0C903B83C")
struct CCertServerExit;

@GUID("38373906-5433-4633-B0FB-29B7E78262E1")
struct CCertSrvSetupKeyInformation;

@GUID("961F180F-F55C-413D-A9B3-7D2AF4D8E42F")
struct CCertSrvSetup;

@GUID("AA4F5C02-8E7C-49C4-94FA-67A5CC5EADB4")
struct CMSCEPSetup;

@GUID("9902F3BC-88AF-4CF8-AE62-7140531552B6")
struct CCertificateEnrollmentServerSetup;

@GUID("AFE2FA32-41B1-459D-A5DE-49ADD8A72182")
struct CCertificateEnrollmentPolicyServerSetup;

@GUID("37EABAF0-7FB6-11D0-8817-00A0C903B83C")
struct CCertAdmin;

@GUID("A12D0F7A-1E84-11D1-9BD6-00C04FB683FA")
struct CCertView;

@GUID("F935A528-BA8A-4DD9-BA79-F283275CB2DE")
struct OCSPPropertyCollection;

@GUID("D3F73511-92C9-47CB-8FF2-8D891A7C4DE4")
struct OCSPAdmin;

@GUID("19A76FE0-7494-11D0-8816-00A0C903B83C")
struct CCertEncodeStringArray;

@GUID("4E0680A0-A0A2-11D0-8821-00A0C903B83C")
struct CCertEncodeLongArray;

@GUID("301F77B0-A470-11D0-8821-00A0C903B83C")
struct CCertEncodeDateArray;

@GUID("01FA60A0-BBFF-11D0-8825-00A0C903B83C")
struct CCertEncodeCRLDistInfo;

@GUID("1CFC4CDA-1271-11D1-9BD4-00C04FB683FA")
struct CCertEncodeAltName;

@GUID("6D6B3CD8-1278-11D1-9BD4-00C04FB683FA")
struct CCertEncodeBitString;

@GUID("127698E4-E730-4E5C-A2B1-21490A70C8A1")
struct CEnroll2;

@GUID("43F8F289-7A20-11D0-8F06-00C04FC295E1")
struct CEnroll;

@GUID("1A1BB35F-ABB8-451C-A1AE-33D98F1BEF4A")
interface ITpmVirtualSmartCardManagerStatusCallback : IUnknown
{
    HRESULT ReportProgress(TPMVSCMGR_STATUS Status);
    HRESULT ReportError(TPMVSCMGR_ERROR Error);
}

@GUID("112B1DFF-D9DC-41F7-869F-D67FEE7CB591")
interface ITpmVirtualSmartCardManager : IUnknown
{
    HRESULT CreateVirtualSmartCard(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, char* pbAdminKey, 
                                   uint cbAdminKey, char* pbAdminKcv, uint cbAdminKcv, char* pbPuk, uint cbPuk, 
                                   char* pbPin, uint cbPin, BOOL fGenerate, 
                                   ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, 
                                   ushort** ppszInstanceId, int* pfNeedReboot);
    HRESULT DestroyVirtualSmartCard(const(wchar)* pszInstanceId, 
                                    ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, int* pfNeedReboot);
}

@GUID("FDF8A2B9-02DE-47F4-BC26-AA85AB5E5267")
interface ITpmVirtualSmartCardManager2 : ITpmVirtualSmartCardManager
{
    HRESULT CreateVirtualSmartCardWithPinPolicy(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, char* pbAdminKey, 
                                                uint cbAdminKey, char* pbAdminKcv, uint cbAdminKcv, char* pbPuk, 
                                                uint cbPuk, char* pbPin, uint cbPin, char* pbPinPolicy, 
                                                uint cbPinPolicy, BOOL fGenerate, 
                                                ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, 
                                                ushort** ppszInstanceId, int* pfNeedReboot);
}

@GUID("3C745A97-F375-4150-BE17-5950F694C699")
interface ITpmVirtualSmartCardManager3 : ITpmVirtualSmartCardManager2
{
    HRESULT CreateVirtualSmartCardWithAttestation(const(wchar)* pszFriendlyName, ubyte bAdminAlgId, 
                                                  char* pbAdminKey, uint cbAdminKey, char* pbAdminKcv, 
                                                  uint cbAdminKcv, char* pbPuk, uint cbPuk, char* pbPin, uint cbPin, 
                                                  char* pbPinPolicy, uint cbPinPolicy, 
                                                  TPMVSC_ATTESTATION_TYPE attestationType, BOOL fGenerate, 
                                                  ITpmVirtualSmartCardManagerStatusCallback pStatusCallback, 
                                                  ushort** ppszInstanceId);
}

@GUID("4E982FED-D14B-440C-B8D6-BB386453D386")
interface IIdentityAdvise : IUnknown
{
    HRESULT IdentityUpdated(uint dwIdentityUpdateEvents, const(wchar)* lpszUniqueID);
}

@GUID("3AB4C8DA-D038-4830-8DD9-3253C55A127F")
interface AsyncIIdentityAdvise : IUnknown
{
    HRESULT Begin_IdentityUpdated(uint dwIdentityUpdateEvents, const(wchar)* lpszUniqueID);
    HRESULT Finish_IdentityUpdated();
}

@GUID("0D1B9E0C-E8BA-4F55-A81B-BCE934B948F5")
interface IIdentityProvider : IUnknown
{
    HRESULT GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                            const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    HRESULT Create(const(wchar)* lpszUserName, IPropertyStore* ppPropertyStore, const(PROPVARIANT)* pKeywordsToAdd);
    HRESULT Import(IPropertyStore pPropertyStore);
    HRESULT Delete(const(wchar)* lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    HRESULT FindByUniqueID(const(wchar)* lpszUniqueID, IPropertyStore* ppPropertyStore);
    HRESULT GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    HRESULT Advise(IIdentityAdvise pIdentityAdvise, uint dwIdentityUpdateEvents, uint* pdwCookie);
    HRESULT UnAdvise(const(uint) dwCookie);
}

@GUID("C6FC9901-C433-4646-8F48-4E4687AAE2A0")
interface AsyncIIdentityProvider : IUnknown
{
    HRESULT Begin_GetIdentityEnum(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                  const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_GetIdentityEnum(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Create(const(wchar)* lpszUserName, const(PROPVARIANT)* pKeywordsToAdd);
    HRESULT Finish_Create(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Import(IPropertyStore pPropertyStore);
    HRESULT Finish_Import();
    HRESULT Begin_Delete(const(wchar)* lpszUniqueID, const(PROPVARIANT)* pKeywordsToDelete);
    HRESULT Finish_Delete();
    HRESULT Begin_FindByUniqueID(const(wchar)* lpszUniqueID);
    HRESULT Finish_FindByUniqueID(IPropertyStore* ppPropertyStore);
    HRESULT Begin_GetProviderPropertyStore();
    HRESULT Finish_GetProviderPropertyStore(IPropertyStore* ppPropertyStore);
    HRESULT Begin_Advise(IIdentityAdvise pIdentityAdvise, uint dwIdentityUpdateEvents);
    HRESULT Finish_Advise(uint* pdwCookie);
    HRESULT Begin_UnAdvise(const(uint) dwCookie);
    HRESULT Finish_UnAdvise();
}

@GUID("2AF066B3-4CBB-4CBA-A798-204B6AF68CC0")
interface IAssociatedIdentityProvider : IUnknown
{
    HRESULT AssociateIdentity(HWND hwndParent, IPropertyStore* ppPropertyStore);
    HRESULT DisassociateIdentity(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT ChangeCredential(HWND hwndParent, const(wchar)* lpszUniqueID);
}

@GUID("2834D6ED-297E-4E72-8A51-961E86F05152")
interface AsyncIAssociatedIdentityProvider : IUnknown
{
    HRESULT Begin_AssociateIdentity(HWND hwndParent);
    HRESULT Finish_AssociateIdentity(IPropertyStore* ppPropertyStore);
    HRESULT Begin_DisassociateIdentity(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT Finish_DisassociateIdentity();
    HRESULT Begin_ChangeCredential(HWND hwndParent, const(wchar)* lpszUniqueID);
    HRESULT Finish_ChangeCredential();
}

@GUID("B7417B54-E08C-429B-96C8-678D1369ECB1")
interface IConnectedIdentityProvider : IUnknown
{
    HRESULT ConnectIdentity(char* AuthBuffer, uint AuthBufferSize);
    HRESULT DisconnectIdentity();
    HRESULT IsConnected(int* Connected);
    HRESULT GetUrl(__MIDL___MIDL_itf_identityprovider_0000_0003_0001 Identifier, IBindCtx Context, 
                   VARIANT* PostData, ushort** Url);
    HRESULT GetAccountState(__MIDL___MIDL_itf_identityprovider_0000_0003_0002* pState);
}

@GUID("9CE55141-BCE9-4E15-824D-43D79F512F93")
interface AsyncIConnectedIdentityProvider : IUnknown
{
    HRESULT Begin_ConnectIdentity(char* AuthBuffer, uint AuthBufferSize);
    HRESULT Finish_ConnectIdentity();
    HRESULT Begin_DisconnectIdentity();
    HRESULT Finish_DisconnectIdentity();
    HRESULT Begin_IsConnected();
    HRESULT Finish_IsConnected(int* Connected);
    HRESULT Begin_GetUrl(__MIDL___MIDL_itf_identityprovider_0000_0003_0001 Identifier, IBindCtx Context);
    HRESULT Finish_GetUrl(VARIANT* PostData, ushort** Url);
    HRESULT Begin_GetAccountState();
    HRESULT Finish_GetAccountState(__MIDL___MIDL_itf_identityprovider_0000_0003_0002* pState);
}

@GUID("5E7EF254-979F-43B5-B74E-06E4EB7DF0F9")
interface IIdentityAuthentication : IUnknown
{
    HRESULT SetIdentityCredential(char* CredBuffer, uint CredBufferLength);
    HRESULT ValidateIdentityCredential(char* CredBuffer, uint CredBufferLength, 
                                       IPropertyStore* ppIdentityProperties);
}

@GUID("F9A2F918-FECA-4E9C-9633-61CBF13ED34D")
interface AsyncIIdentityAuthentication : IUnknown
{
    HRESULT Begin_SetIdentityCredential(char* CredBuffer, uint CredBufferLength);
    HRESULT Finish_SetIdentityCredential();
    HRESULT Begin_ValidateIdentityCredential(char* CredBuffer, uint CredBufferLength, 
                                             IPropertyStore* ppIdentityProperties);
    HRESULT Finish_ValidateIdentityCredential(IPropertyStore* ppIdentityProperties);
}

@GUID("DF586FA5-6F35-44F1-B209-B38E169772EB")
interface IIdentityStore : IUnknown
{
    HRESULT GetCount(uint* pdwProviders);
    HRESULT GetAt(const(uint) dwProvider, GUID* pProvGuid, IUnknown* ppIdentityProvider);
    HRESULT AddToCache(const(wchar)* lpszUniqueID, const(GUID)* ProviderGUID);
    HRESULT ConvertToSid(const(wchar)* lpszUniqueID, const(GUID)* ProviderGUID, ushort cbSid, char* pSid, 
                         ushort* pcbRequiredSid);
    HRESULT EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                const(PROPVARIANT)* pFilterPropVarValue, IEnumUnknown* ppIdentityEnum);
    HRESULT Reset();
}

@GUID("EEFA1616-48DE-4872-AA64-6E6206535A51")
interface AsyncIIdentityStore : IUnknown
{
    HRESULT Begin_GetCount();
    HRESULT Finish_GetCount(uint* pdwProviders);
    HRESULT Begin_GetAt(const(uint) dwProvider, GUID* pProvGuid);
    HRESULT Finish_GetAt(GUID* pProvGuid, IUnknown* ppIdentityProvider);
    HRESULT Begin_AddToCache(const(wchar)* lpszUniqueID, const(GUID)* ProviderGUID);
    HRESULT Finish_AddToCache();
    HRESULT Begin_ConvertToSid(const(wchar)* lpszUniqueID, const(GUID)* ProviderGUID, ushort cbSid, ubyte* pSid);
    HRESULT Finish_ConvertToSid(ubyte* pSid, ushort* pcbRequiredSid);
    HRESULT Begin_EnumerateIdentities(const(IDENTITY_TYPE) eIdentityType, const(PROPERTYKEY)* pFilterkey, 
                                      const(PROPVARIANT)* pFilterPropVarValue);
    HRESULT Finish_EnumerateIdentities(IEnumUnknown* ppIdentityEnum);
    HRESULT Begin_Reset();
    HRESULT Finish_Reset();
}

@GUID("F9F9EB98-8F7F-4E38-9577-6980114CE32B")
interface IIdentityStoreEx : IUnknown
{
    HRESULT CreateConnectedIdentity(const(wchar)* LocalName, const(wchar)* ConnectedName, 
                                    const(GUID)* ProviderGUID);
    HRESULT DeleteConnectedIdentity(const(wchar)* ConnectedName, const(GUID)* ProviderGUID);
}

@GUID("FCA3AF9A-8A07-4EAE-8632-EC3DE658A36A")
interface AsyncIIdentityStoreEx : IUnknown
{
    HRESULT Begin_CreateConnectedIdentity(const(wchar)* LocalName, const(wchar)* ConnectedName, 
                                          const(GUID)* ProviderGUID);
    HRESULT Finish_CreateConnectedIdentity();
    HRESULT Begin_DeleteConnectedIdentity(const(wchar)* ConnectedName, const(GUID)* ProviderGUID);
    HRESULT Finish_DeleteConnectedIdentity();
}

@GUID("EDBD9CA9-9B82-4F6A-9E8B-98301E450F14")
interface IAzAuthorizationStore : IDispatch
{
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_DomainTimeout(int* plProp);
    HRESULT put_DomainTimeout(int lProp);
    HRESULT get_ScriptEngineTimeout(int* plProp);
    HRESULT put_ScriptEngineTimeout(int lProp);
    HRESULT get_MaxScriptEngines(int* plProp);
    HRESULT put_MaxScriptEngines(int lProp);
    HRESULT get_GenerateAudits(int* pbProp);
    HRESULT put_GenerateAudits(BOOL bProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT Initialize(int lFlags, BSTR bstrPolicyURL, VARIANT varReserved);
    HRESULT UpdateCache(VARIANT varReserved);
    HRESULT Delete(VARIANT varReserved);
    HRESULT get_Applications(IAzApplications* ppAppCollection);
    HRESULT OpenApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    HRESULT CreateApplication(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication* ppApplication);
    HRESULT DeleteApplication(BSTR bstrApplicationName, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT get_TargetMachine(BSTR* pbstrTargetMachine);
    HRESULT get_ApplyStoreSacl(int* pbApplyStoreSacl);
    HRESULT put_ApplyStoreSacl(BOOL bApplyStoreSacl);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT CloseApplication(BSTR bstrApplicationName, int lFlag);
}

@GUID("B11E5584-D577-4273-B6C5-0973E0F8E80D")
interface IAzAuthorizationStore2 : IAzAuthorizationStore
{
    HRESULT OpenApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
    HRESULT CreateApplication2(BSTR bstrApplicationName, VARIANT varReserved, IAzApplication2* ppApplication);
}

@GUID("ABC08425-0C86-4FA0-9BE3-7189956C926E")
interface IAzAuthorizationStore3 : IAzAuthorizationStore2
{
    HRESULT IsUpdateNeeded(short* pbIsUpdateNeeded);
    HRESULT BizruleGroupSupported(short* pbSupported);
    HRESULT UpgradeStoresFunctionalLevel(int lFunctionalLevel);
    HRESULT IsFunctionalLevelUpgradeSupported(int lFunctionalLevel, short* pbSupported);
    HRESULT GetSchemaVersion(int* plMajorVersion, int* plMinorVersion);
}

@GUID("987BC7C7-B813-4D27-BEDE-6BA5AE867E95")
interface IAzApplication : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_AuthzInterfaceClsid(BSTR* pbstrProp);
    HRESULT put_AuthzInterfaceClsid(BSTR bstrProp);
    HRESULT get_Version(BSTR* pbstrProp);
    HRESULT put_Version(BSTR bstrProp);
    HRESULT get_GenerateAudits(int* pbProp);
    HRESULT put_GenerateAudits(BOOL bProp);
    HRESULT get_ApplyStoreSacl(int* pbProp);
    HRESULT put_ApplyStoreSacl(BOOL bProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_Scopes(IAzScopes* ppScopeCollection);
    HRESULT OpenScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    HRESULT CreateScope(BSTR bstrScopeName, VARIANT varReserved, IAzScope* ppScope);
    HRESULT DeleteScope(BSTR bstrScopeName, VARIANT varReserved);
    HRESULT get_Operations(IAzOperations* ppOperationCollection);
    HRESULT OpenOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    HRESULT CreateOperation(BSTR bstrOperationName, VARIANT varReserved, IAzOperation* ppOperation);
    HRESULT DeleteOperation(BSTR bstrOperationName, VARIANT varReserved);
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    HRESULT InitializeClientContextFromToken(ulong ullTokenHandle, VARIANT varReserved, 
                                             IAzClientContext* ppClientContext);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT InitializeClientContextFromName(BSTR ClientName, BSTR DomainName, VARIANT varReserved, 
                                            IAzClientContext* ppClientContext);
    HRESULT get_DelegatedPolicyUsers(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUser(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT InitializeClientContextFromStringSid(BSTR SidString, int lOptions, VARIANT varReserved, 
                                                 IAzClientContext* ppClientContext);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_DelegatedPolicyUsersName(VARIANT* pvarDelegatedPolicyUsers);
    HRESULT AddDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
    HRESULT DeleteDelegatedPolicyUserName(BSTR bstrDelegatedPolicyUser, VARIANT varReserved);
}

@GUID("086A68AF-A249-437C-B18D-D4D86D6A9660")
interface IAzApplication2 : IAzApplication
{
    HRESULT InitializeClientContextFromToken2(uint ulTokenHandleLowPart, uint ulTokenHandleHighPart, 
                                              VARIANT varReserved, IAzClientContext2* ppClientContext);
    HRESULT InitializeClientContext2(BSTR IdentifyingString, VARIANT varReserved, 
                                     IAzClientContext2* ppClientContext);
}

@GUID("929B11A9-95C5-4A84-A29A-20AD42C2F16C")
interface IAzApplications : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("5E56B24F-EA01-4D61-BE44-C49B5E4EAF74")
interface IAzOperation : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_OperationID(int* plProp);
    HRESULT put_OperationID(int lProp);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

@GUID("90EF9C07-9706-49D9-AF80-0438A5F3EC35")
interface IAzOperations : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("CB94E592-2E0E-4A6C-A336-B89A6DC1E388")
interface IAzTask : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_BizRule(BSTR* pbstrProp);
    HRESULT put_BizRule(BSTR bstrProp);
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    HRESULT get_IsRoleDefinition(int* pfProp);
    HRESULT put_IsRoleDefinition(BOOL fProp);
    HRESULT get_Operations(VARIANT* pvarProp);
    HRESULT get_Tasks(VARIANT* pvarProp);
    HRESULT AddOperation(BSTR bstrOp, VARIANT varReserved);
    HRESULT DeleteOperation(BSTR bstrOp, VARIANT varReserved);
    HRESULT AddTask(BSTR bstrTask, VARIANT varReserved);
    HRESULT DeleteTask(BSTR bstrTask, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
}

@GUID("B338CCAB-4C85-4388-8C0A-C58592BAD398")
interface IAzTasks : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("00E52487-E08D-4514-B62E-877D5645F5AB")
interface IAzScope : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_PolicyAdministrators(VARIANT* pvarAdmins);
    HRESULT get_PolicyReaders(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministrator(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReader(BSTR bstrReader, VARIANT varReserved);
    HRESULT get_ApplicationGroups(IAzApplicationGroups* ppGroupCollection);
    HRESULT OpenApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT CreateApplicationGroup(BSTR bstrGroupName, VARIANT varReserved, IAzApplicationGroup* ppGroup);
    HRESULT DeleteApplicationGroup(BSTR bstrGroupName, VARIANT varReserved);
    HRESULT get_Roles(IAzRoles* ppRoleCollection);
    HRESULT OpenRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT CreateRole(BSTR bstrRoleName, VARIANT varReserved, IAzRole* ppRole);
    HRESULT DeleteRole(BSTR bstrRoleName, VARIANT varReserved);
    HRESULT get_Tasks(IAzTasks* ppTaskCollection);
    HRESULT OpenTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT CreateTask(BSTR bstrTaskName, VARIANT varReserved, IAzTask* ppTask);
    HRESULT DeleteTask(BSTR bstrTaskName, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT get_CanBeDelegated(int* pfProp);
    HRESULT get_BizrulesWritable(int* pfProp);
    HRESULT get_PolicyAdministratorsName(VARIANT* pvarAdmins);
    HRESULT get_PolicyReadersName(VARIANT* pvarReaders);
    HRESULT AddPolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT DeletePolicyAdministratorName(BSTR bstrAdmin, VARIANT varReserved);
    HRESULT AddPolicyReaderName(BSTR bstrReader, VARIANT varReserved);
    HRESULT DeletePolicyReaderName(BSTR bstrReader, VARIANT varReserved);
}

@GUID("78E14853-9F5E-406D-9B91-6BDBA6973510")
interface IAzScopes : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("F1B744CD-58A6-4E06-9FBF-36F6D779E21E")
interface IAzApplicationGroup : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Type(int* plProp);
    HRESULT put_Type(int lProp);
    HRESULT get_LdapQuery(BSTR* pbstrProp);
    HRESULT put_LdapQuery(BSTR bstrProp);
    HRESULT get_AppMembers(VARIANT* pvarProp);
    HRESULT get_AppNonMembers(VARIANT* pvarProp);
    HRESULT get_Members(VARIANT* pvarProp);
    HRESULT get_NonMembers(VARIANT* pvarProp);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddAppNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteNonMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddNonMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteNonMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_MembersName(VARIANT* pvarProp);
    HRESULT get_NonMembersName(VARIANT* pvarProp);
}

@GUID("4CE66AD5-9F3C-469D-A911-B99887A7E685")
interface IAzApplicationGroups : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("859E0D8D-62D7-41D8-A034-C0CD5D43FDFA")
interface IAzRole : IDispatch
{
    HRESULT get_Name(BSTR* pbstrName);
    HRESULT put_Name(BSTR bstrName);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_ApplicationData(BSTR* pbstrApplicationData);
    HRESULT put_ApplicationData(BSTR bstrApplicationData);
    HRESULT AddAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteAppMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddTask(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteTask(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddOperation(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteOperation(BSTR bstrProp, VARIANT varReserved);
    HRESULT AddMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMember(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_Writable(int* pfProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT SetProperty(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT get_AppMembers(VARIANT* pvarProp);
    HRESULT get_Members(VARIANT* pvarProp);
    HRESULT get_Operations(VARIANT* pvarProp);
    HRESULT get_Tasks(VARIANT* pvarProp);
    HRESULT AddPropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT DeletePropertyItem(int lPropId, VARIANT varProp, VARIANT varReserved);
    HRESULT Submit(int lFlags, VARIANT varReserved);
    HRESULT AddMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT DeleteMemberName(BSTR bstrProp, VARIANT varReserved);
    HRESULT get_MembersName(VARIANT* pvarProp);
}

@GUID("95E0F119-13B4-4DAE-B65F-2F7D60D822E4")
interface IAzRoles : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("EFF1F00B-488A-466D-AFD9-A401C5F9EEF5")
interface IAzClientContext : IDispatch
{
    HRESULT AccessCheck(BSTR bstrObjectName, VARIANT varScopeNames, VARIANT varOperations, 
                        VARIANT varParameterNames, VARIANT varParameterValues, VARIANT varInterfaceNames, 
                        VARIANT varInterfaceFlags, VARIANT varInterfaces, VARIANT* pvarResults);
    HRESULT GetBusinessRuleString(BSTR* pbstrBusinessRuleString);
    HRESULT get_UserDn(BSTR* pbstrProp);
    HRESULT get_UserSamCompat(BSTR* pbstrProp);
    HRESULT get_UserDisplay(BSTR* pbstrProp);
    HRESULT get_UserGuid(BSTR* pbstrProp);
    HRESULT get_UserCanonical(BSTR* pbstrProp);
    HRESULT get_UserUpn(BSTR* pbstrProp);
    HRESULT get_UserDnsSamCompat(BSTR* pbstrProp);
    HRESULT GetProperty(int lPropId, VARIANT varReserved, VARIANT* pvarProp);
    HRESULT GetRoles(BSTR bstrScopeName, VARIANT* pvarRoleNames);
    HRESULT get_RoleForAccessCheck(BSTR* pbstrProp);
    HRESULT put_RoleForAccessCheck(BSTR bstrProp);
}

@GUID("2B0C92B8-208A-488A-8F81-E4EDB22111CD")
interface IAzClientContext2 : IAzClientContext
{
    HRESULT GetAssignedScopesPage(int lOptions, int PageSize, VARIANT* pvarCursor, VARIANT* pvarScopeNames);
    HRESULT AddRoles(VARIANT varRoles, BSTR bstrScopeName);
    HRESULT AddApplicationGroups(VARIANT varApplicationGroups);
    HRESULT AddStringSids(VARIANT varStringSids);
    HRESULT put_LDAPQueryDN(BSTR bstrLDAPQueryDN);
    HRESULT get_LDAPQueryDN(BSTR* pbstrLDAPQueryDN);
}

@GUID("E192F17D-D59F-455E-A152-940316CD77B2")
interface IAzBizRuleContext : IDispatch
{
    HRESULT put_BusinessRuleResult(BOOL bResult);
    HRESULT put_BusinessRuleString(BSTR bstrBusinessRuleString);
    HRESULT get_BusinessRuleString(BSTR* pbstrBusinessRuleString);
    HRESULT GetParameter(BSTR bstrParameterName, VARIANT* pvarParameterValue);
}

@GUID("FC17685F-E25D-4DCD-BAE1-276EC9533CB5")
interface IAzBizRuleParameters : IDispatch
{
    HRESULT AddParameter(BSTR bstrParameterName, VARIANT varParameterValue);
    HRESULT AddParameters(VARIANT varParameterNames, VARIANT varParameterValues);
    HRESULT GetParameterValue(BSTR bstrParameterName, VARIANT* pvarParameterValue);
    HRESULT Remove(BSTR varParameterName);
    HRESULT RemoveAll();
    HRESULT get_Count(uint* plCount);
}

@GUID("E94128C7-E9DA-44CC-B0BD-53036F3AAB3D")
interface IAzBizRuleInterfaces : IDispatch
{
    HRESULT AddInterface(BSTR bstrInterfaceName, int lInterfaceFlag, VARIANT varInterface);
    HRESULT AddInterfaces(VARIANT varInterfaceNames, VARIANT varInterfaceFlags, VARIANT varInterfaces);
    HRESULT GetInterfaceValue(BSTR bstrInterfaceName, int* lInterfaceFlag, VARIANT* varInterface);
    HRESULT Remove(BSTR bstrInterfaceName);
    HRESULT RemoveAll();
    HRESULT get_Count(uint* plCount);
}

@GUID("11894FDE-1DEB-4B4B-8907-6D1CDA1F5D4F")
interface IAzClientContext3 : IAzClientContext2
{
    HRESULT AccessCheck2(BSTR bstrObjectName, BSTR bstrScopeName, int lOperation, uint* plResult);
    HRESULT IsInRoleAssignment(BSTR bstrScopeName, BSTR bstrRoleName, short* pbIsInRole);
    HRESULT GetOperations(BSTR bstrScopeName, IAzOperations* ppOperationCollection);
    HRESULT GetTasks(BSTR bstrScopeName, IAzTasks* ppTaskCollection);
    HRESULT get_BizRuleParameters(IAzBizRuleParameters* ppBizRuleParam);
    HRESULT get_BizRuleInterfaces(IAzBizRuleInterfaces* ppBizRuleInterfaces);
    HRESULT GetGroups(BSTR bstrScopeName, uint ulOptions, VARIANT* pGroupArray);
    HRESULT get_Sids(VARIANT* pStringSidArray);
}

@GUID("EE9FE8C9-C9F3-40E2-AA12-D1D8599727FD")
interface IAzScope2 : IAzScope
{
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
}

@GUID("181C845E-7196-4A7D-AC2E-020C0BB7A303")
interface IAzApplication3 : IAzApplication2
{
    HRESULT ScopeExists(BSTR bstrScopeName, short* pbExist);
    HRESULT OpenScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    HRESULT CreateScope2(BSTR bstrScopeName, IAzScope2* ppScope2);
    HRESULT DeleteScope2(BSTR bstrScopeName);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT CreateRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT OpenRoleDefinition(BSTR bstrRoleDefinitionName, IAzRoleDefinition* ppRoleDefinitions);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinitionName);
    HRESULT get_RoleAssignments(IAzRoleAssignments* ppRoleAssignments);
    HRESULT CreateRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT OpenRoleAssignment(BSTR bstrRoleAssignmentName, IAzRoleAssignment* ppRoleAssignment);
    HRESULT DeleteRoleAssignment(BSTR bstrRoleAssignmentName);
    HRESULT get_BizRulesEnabled(short* pbEnabled);
    HRESULT put_BizRulesEnabled(short bEnabled);
}

@GUID("1F5EA01F-44A2-4184-9C48-A75B4DCC8CCC")
interface IAzOperation2 : IAzOperation
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

@GUID("881F25A5-D755-4550-957A-D503A3B34001")
interface IAzRoleDefinitions : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("D97FCEA1-2599-44F1-9FC3-58E9FBE09466")
interface IAzRoleDefinition : IAzTask
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
}

@GUID("55647D31-0D5A-4FA3-B4AC-2B5F9AD5AB76")
interface IAzRoleAssignment : IAzRole
{
    HRESULT AddRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT DeleteRoleDefinition(BSTR bstrRoleDefinition);
    HRESULT get_RoleDefinitions(IAzRoleDefinitions* ppRoleDefinitions);
    HRESULT get_Scope(IAzScope* ppScope);
}

@GUID("9C80B900-FCEB-4D73-A0F4-C83B0BBF2481")
interface IAzRoleAssignments : IDispatch
{
    HRESULT get_Item(int Index, VARIANT* pvarObtPtr);
    HRESULT get_Count(int* plCount);
    HRESULT get__NewEnum(IUnknown* ppEnumPtr);
}

@GUID("E5C3507D-AD6A-4992-9C7F-74AB480B44CC")
interface IAzPrincipalLocator : IDispatch
{
    HRESULT get_NameResolver(IAzNameResolver* ppNameResolver);
    HRESULT get_ObjectPicker(IAzObjectPicker* ppObjectPicker);
}

@GUID("504D0F15-73E2-43DF-A870-A64F40714F53")
interface IAzNameResolver : IDispatch
{
    HRESULT NameFromSid(BSTR bstrSid, int* pSidType, BSTR* pbstrName);
    HRESULT NamesFromSids(VARIANT vSids, VARIANT* pvSidTypes, VARIANT* pvNames);
}

@GUID("63130A48-699A-42D8-BF01-C62AC3FB79F9")
interface IAzObjectPicker : IDispatch
{
    HRESULT GetPrincipals(HWND hParentWnd, BSTR bstrTitle, VARIANT* pvSidTypes, VARIANT* pvNames, VARIANT* pvSids);
    HRESULT get_Name(BSTR* pbstrName);
}

@GUID("3F0613FC-B71A-464E-A11D-5B881A56CEFA")
interface IAzApplicationGroup2 : IAzApplicationGroup
{
    HRESULT get_BizRule(BSTR* pbstrProp);
    HRESULT put_BizRule(BSTR bstrProp);
    HRESULT get_BizRuleLanguage(BSTR* pbstrProp);
    HRESULT put_BizRuleLanguage(BSTR bstrProp);
    HRESULT get_BizRuleImportedPath(BSTR* pbstrProp);
    HRESULT put_BizRuleImportedPath(BSTR bstrProp);
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

@GUID("03A9A5EE-48C8-4832-9025-AAD503C46526")
interface IAzTask2 : IAzTask
{
    HRESULT RoleAssignments(BSTR bstrScopeName, short bRecursive, IAzRoleAssignments* ppRoleAssignments);
}

@GUID("965FC360-16FF-11D0-91CB-00AA00BBB723")
interface ISecurityInformation : IUnknown
{
    HRESULT GetObjectInformation(SI_OBJECT_INFO* pObjectInfo);
    HRESULT GetSecurity(uint RequestedInformation, void** ppSecurityDescriptor, BOOL fDefault);
    HRESULT SetSecurity(uint SecurityInformation, void* pSecurityDescriptor);
    HRESULT GetAccessRights(const(GUID)* pguidObjectType, uint dwFlags, SI_ACCESS** ppAccess, uint* pcAccesses, 
                            uint* piDefaultAccess);
    HRESULT MapGeneric(const(GUID)* pguidObjectType, ubyte* pAceFlags, uint* pMask);
    HRESULT GetInheritTypes(SI_INHERIT_TYPE** ppInheritTypes, uint* pcInheritTypes);
    HRESULT PropertySheetPageCallback(HWND hwnd, uint uMsg, SI_PAGE_TYPE uPage);
}

@GUID("C3CCFDB4-6F88-11D2-A3CE-00C04FB1782A")
interface ISecurityInformation2 : IUnknown
{
    BOOL    IsDaclCanonical(ACL* pDacl);
    HRESULT LookupSids(uint cSids, void** rgpSids, IDataObject* ppdo);
}

@GUID("3853DC76-9F35-407C-88A1-D19344365FBC")
interface IEffectivePermission : IUnknown
{
    HRESULT GetEffectivePermission(const(GUID)* pguidObjectType, void* pUserSid, const(wchar)* pszServerName, 
                                   void* pSD, OBJECT_TYPE_LIST** ppObjectTypeList, uint* pcObjectTypeListLength, 
                                   uint** ppGrantedAccessList, uint* pcGrantedAccessListLength);
}

@GUID("FC3066EB-79EF-444B-9111-D18A75EBF2FA")
interface ISecurityObjectTypeInfo : IUnknown
{
    HRESULT GetInheritSource(uint si, ACL* pACL, INHERITED_FROMA** ppInheritArray);
}

@GUID("E2CDC9CC-31BD-4F8F-8C8B-B641AF516A1A")
interface ISecurityInformation3 : IUnknown
{
    HRESULT GetFullResourceName(ushort** ppszResourceName);
    HRESULT OpenElevatedEditor(HWND hWnd, SI_PAGE_TYPE uPage);
}

@GUID("EA961070-CD14-4621-ACE4-F63C03E583E4")
interface ISecurityInformation4 : IUnknown
{
    HRESULT GetSecondarySecurity(SECURITY_OBJECT** pSecurityObjects, uint* pSecurityObjectCount);
}

@GUID("941FABCA-DD47-4FCA-90BB-B0E10255F20D")
interface IEffectivePermission2 : IUnknown
{
    HRESULT ComputeEffectivePermissionWithSecondarySecurity(void* pSid, void* pDeviceSid, 
                                                            const(wchar)* pszServerName, char* pSecurityObjects, 
                                                            uint dwSecurityObjectCount, TOKEN_GROUPS* pUserGroups, 
                                                            char* pAuthzUserGroupsOperations, 
                                                            TOKEN_GROUPS* pDeviceGroups, 
                                                            char* pAuthzDeviceGroupsOperations, 
                                                            AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzUserClaims, 
                                                            char* pAuthzUserClaimsOperations, 
                                                            AUTHZ_SECURITY_ATTRIBUTES_INFORMATION* pAuthzDeviceClaims, 
                                                            char* pAuthzDeviceClaimsOperations, 
                                                            char* pEffpermResultLists);
}

@GUID("AA000922-FFBE-11CF-8800-00A0C903B83C")
interface ICertServerPolicy : IDispatch
{
    HRESULT SetContext(int Context);
    HRESULT GetRequestProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetRequestAttribute(const(ushort)* strAttributeName, BSTR* pstrAttributeValue);
    HRESULT GetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT SetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, 
                                   const(VARIANT)* pvarPropertyValue);
    HRESULT GetCertificateExtension(const(ushort)* strExtensionName, int Type, VARIANT* pvarValue);
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    HRESULT SetCertificateExtension(const(ushort)* strExtensionName, int Type, int ExtFlags, 
                                    const(VARIANT)* pvarValue);
    HRESULT EnumerateExtensionsSetup(int Flags);
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    HRESULT EnumerateExtensionsClose();
    HRESULT EnumerateAttributesSetup(int Flags);
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    HRESULT EnumerateAttributesClose();
}

@GUID("4BA9EB90-732C-11D0-8816-00A0C903B83C")
interface ICertServerExit : IDispatch
{
    HRESULT SetContext(int Context);
    HRESULT GetRequestProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetRequestAttribute(const(ushort)* strAttributeName, BSTR* pstrAttributeValue);
    HRESULT GetCertificateProperty(const(ushort)* strPropertyName, int PropertyType, VARIANT* pvarPropertyValue);
    HRESULT GetCertificateExtension(const(ushort)* strExtensionName, int Type, VARIANT* pvarValue);
    HRESULT GetCertificateExtensionFlags(int* pExtFlags);
    HRESULT EnumerateExtensionsSetup(int Flags);
    HRESULT EnumerateExtensions(BSTR* pstrExtensionName);
    HRESULT EnumerateExtensionsClose();
    HRESULT EnumerateAttributesSetup(int Flags);
    HRESULT EnumerateAttributes(BSTR* pstrAttributeName);
    HRESULT EnumerateAttributesClose();
}

@GUID("C7EA09C0-CE17-11D0-8833-00A0C903B83C")
interface ICertGetConfig : IDispatch
{
    HRESULT GetConfig(int Flags, BSTR* pstrOut);
}

@GUID("372FCE34-4324-11D0-8810-00A0C903B83C")
interface ICertConfig : IDispatch
{
    HRESULT Reset(int Index, int* pCount);
    HRESULT Next(int* pIndex);
    HRESULT GetField(const(ushort)* strFieldName, BSTR* pstrOut);
    HRESULT GetConfig(int Flags, BSTR* pstrOut);
}

@GUID("7A18EDDE-7E78-4163-8DED-78E2C9CEE924")
interface ICertConfig2 : ICertConfig
{
    HRESULT SetSharedFolder(const(ushort)* strSharedFolder);
}

@GUID("014E4840-5523-11D0-8812-00A0C903B83C")
interface ICertRequest : IDispatch
{
    HRESULT Submit(int Flags, const(ushort)* strRequest, const(ushort)* strAttributes, const(ushort)* strConfig, 
                   int* pDisposition);
    HRESULT RetrievePending(int RequestId, const(ushort)* strConfig, int* pDisposition);
    HRESULT GetLastStatus(int* pStatus);
    HRESULT GetRequestId(int* pRequestId);
    HRESULT GetDispositionMessage(BSTR* pstrDispositionMessage);
    HRESULT GetCACertificate(int fExchangeCertificate, const(ushort)* strConfig, int Flags, BSTR* pstrCertificate);
    HRESULT GetCertificate(int Flags, BSTR* pstrCertificate);
}

@GUID("A4772988-4A85-4FA9-824E-B5CF5C16405A")
interface ICertRequest2 : ICertRequest
{
    HRESULT GetIssuedCertificate(const(ushort)* strConfig, int RequestId, const(ushort)* strSerialNumber, 
                                 int* pDisposition);
    HRESULT GetErrorMessageText(int hrMessage, int Flags, BSTR* pstrErrorMessageText);
    HRESULT GetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, int Flags, 
                          VARIANT* pvarPropertyValue);
    HRESULT GetCAPropertyFlags(const(ushort)* strConfig, int PropId, int* pPropFlags);
    HRESULT GetCAPropertyDisplayName(const(ushort)* strConfig, int PropId, BSTR* pstrDisplayName);
    HRESULT GetFullResponseProperty(int PropId, int PropIndex, int PropType, int Flags, VARIANT* pvarPropertyValue);
}

@GUID("AFC8F92B-33A2-4861-BF36-2933B7CD67B3")
interface ICertRequest3 : ICertRequest2
{
    HRESULT SetCredential(int hWnd, X509EnrollmentAuthFlags AuthType, BSTR strCredential, BSTR strPassword);
    HRESULT GetRequestIdString(BSTR* pstrRequestId);
    HRESULT GetIssuedCertificate2(BSTR strConfig, BSTR strRequestId, BSTR strSerialNumber, int* pDisposition);
    HRESULT GetRefreshPolicy(short* pValue);
}

@GUID("E7D7AD42-BD3D-11D1-9A4D-00C04FC297EB")
interface ICertManageModule : IDispatch
{
    HRESULT GetProperty(const(ushort)* strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, 
                        VARIANT* pvarProperty);
    HRESULT SetProperty(const(ushort)* strConfig, BSTR strStorageLocation, BSTR strPropertyName, int Flags, 
                        const(VARIANT)* pvarProperty);
    HRESULT Configure(const(ushort)* strConfig, BSTR strStorageLocation, int Flags);
}

@GUID("38BB5A00-7636-11D0-B413-00A0C91BBF8C")
interface ICertPolicy : IDispatch
{
    HRESULT Initialize(const(ushort)* strConfig);
    HRESULT VerifyRequest(const(ushort)* strConfig, int Context, int bNewRequest, int Flags, int* pDisposition);
    HRESULT GetDescription(BSTR* pstrDescription);
    HRESULT ShutDown();
}

@GUID("3DB4910E-8001-4BF1-AA1B-F43A808317A0")
interface ICertPolicy2 : ICertPolicy
{
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

@GUID("13CA515D-431D-46CC-8C2E-1DA269BBD625")
interface INDESPolicy : IUnknown
{
    HRESULT Initialize();
    HRESULT Uninitialize();
    HRESULT GenerateChallenge(const(wchar)* pwszTemplate, const(wchar)* pwszParams, ushort** ppwszResponse);
    HRESULT VerifyRequest(CERTTRANSBLOB* pctbRequest, CERTTRANSBLOB* pctbSigningCertEncoded, 
                          const(wchar)* pwszTemplate, const(wchar)* pwszTransactionId, int* pfVerified);
    HRESULT Notify(const(wchar)* pwszChallenge, const(wchar)* pwszTransactionId, X509SCEPDisposition disposition, 
                   int lastHResult, CERTTRANSBLOB* pctbIssuedCertEncoded);
}

@GUID("728AB300-217D-11DA-B2A4-000E7BBB2B09")
interface IObjectId : IDispatch
{
    HRESULT InitializeFromName(CERTENROLL_OBJECTID Name);
    HRESULT InitializeFromValue(BSTR strValue);
    HRESULT InitializeFromAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, 
                                        AlgorithmFlags AlgFlags, BSTR strAlgorithmName);
    HRESULT get_Name(CERTENROLL_OBJECTID* pValue);
    HRESULT get_FriendlyName(BSTR* pValue);
    HRESULT put_FriendlyName(BSTR Value);
    HRESULT get_Value(BSTR* pValue);
    HRESULT GetAlgorithmName(ObjectIdGroupId GroupId, ObjectIdPublicKeyFlags KeyFlags, BSTR* pstrAlgorithmName);
}

@GUID("728AB301-217D-11DA-B2A4-000E7BBB2B09")
interface IObjectIds : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IObjectId* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IObjectId pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddRange(IObjectIds pValue);
}

@GUID("728AB302-217D-11DA-B2A4-000E7BBB2B09")
interface IBinaryConverter : IDispatch
{
    HRESULT StringToString(BSTR strEncodedIn, EncodingType EncodingIn, EncodingType Encoding, BSTR* pstrEncoded);
    HRESULT VariantByteArrayToString(VARIANT* pvarByteArray, EncodingType Encoding, BSTR* pstrEncoded);
    HRESULT StringToVariantByteArray(BSTR strEncoded, EncodingType Encoding, VARIANT* pvarByteArray);
}

@GUID("8D7928B4-4E17-428D-9A17-728DF00D1B2B")
interface IBinaryConverter2 : IBinaryConverter
{
    HRESULT StringArrayToVariantArray(VARIANT* pvarStringArray, VARIANT* pvarVariantArray);
    HRESULT VariantArrayToStringArray(VARIANT* pvarVariantArray, VARIANT* pvarStringArray);
}

@GUID("728AB303-217D-11DA-B2A4-000E7BBB2B09")
interface IX500DistinguishedName : IDispatch
{
    HRESULT Decode(BSTR strEncodedName, EncodingType Encoding, X500NameFlags NameFlags);
    HRESULT Encode(BSTR strName, X500NameFlags NameFlags);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_EncodedName(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB304-217D-11DA-B2A4-000E7BBB2B09")
interface IX509EnrollmentStatus : IDispatch
{
    HRESULT AppendText(BSTR strText);
    HRESULT get_Text(BSTR* pValue);
    HRESULT put_Text(BSTR Value);
    HRESULT get_Selected(EnrollmentSelectionStatus* pValue);
    HRESULT put_Selected(EnrollmentSelectionStatus Value);
    HRESULT get_Display(EnrollmentDisplayStatus* pValue);
    HRESULT put_Display(EnrollmentDisplayStatus Value);
    HRESULT get_Status(EnrollmentEnrollStatus* pValue);
    HRESULT put_Status(EnrollmentEnrollStatus Value);
    HRESULT get_Error(int* pValue);
    HRESULT put_Error(HRESULT Value);
    HRESULT get_ErrorText(BSTR* pValue);
}

@GUID("728AB305-217D-11DA-B2A4-000E7BBB2B09")
interface ICspAlgorithm : IDispatch
{
    HRESULT GetAlgorithmOid(int Length, AlgorithmFlags AlgFlags, IObjectId* ppValue);
    HRESULT get_DefaultLength(int* pValue);
    HRESULT get_IncrementLength(int* pValue);
    HRESULT get_LongName(BSTR* pValue);
    HRESULT get_Valid(short* pValue);
    HRESULT get_MaxLength(int* pValue);
    HRESULT get_MinLength(int* pValue);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_Type(AlgorithmType* pValue);
    HRESULT get_Operations(AlgorithmOperationFlags* pValue);
}

@GUID("728AB306-217D-11DA-B2A4-000E7BBB2B09")
interface ICspAlgorithms : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspAlgorithm* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspAlgorithm pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR strName, ICspAlgorithm* ppValue);
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
}

@GUID("728AB307-217D-11DA-B2A4-000E7BBB2B09")
interface ICspInformation : IDispatch
{
    HRESULT InitializeFromName(BSTR strName);
    HRESULT InitializeFromType(X509ProviderType Type, IObjectId pAlgorithm, short MachineContext);
    HRESULT get_CspAlgorithms(ICspAlgorithms* ppValue);
    HRESULT get_HasHardwareRandomNumberGenerator(short* pValue);
    HRESULT get_IsHardwareDevice(short* pValue);
    HRESULT get_IsRemovable(short* pValue);
    HRESULT get_IsSoftwareDevice(short* pValue);
    HRESULT get_Valid(short* pValue);
    HRESULT get_MaxKeyContainerNameLength(int* pValue);
    HRESULT get_Name(BSTR* pValue);
    HRESULT get_Type(X509ProviderType* pValue);
    HRESULT get_Version(int* pValue);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT get_IsSmartCard(short* pValue);
    HRESULT GetDefaultSecurityDescriptor(short MachineContext, BSTR* pValue);
    HRESULT get_LegacyCsp(short* pValue);
    HRESULT GetCspStatusFromOperations(IObjectId pAlgorithm, AlgorithmOperationFlags Operations, 
                                       ICspStatus* ppValue);
}

@GUID("728AB308-217D-11DA-B2A4-000E7BBB2B09")
interface ICspInformations : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspInformation* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspInformation pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddAvailableCsps();
    HRESULT get_ItemByName(BSTR strName, ICspInformation* ppCspInformation);
    HRESULT GetCspStatusFromProviderName(BSTR strProviderName, X509KeySpec LegacyKeySpec, ICspStatus* ppValue);
    HRESULT GetCspStatusesFromOperations(AlgorithmOperationFlags Operations, ICspInformation pCspInformation, 
                                         ICspStatuses* ppValue);
    HRESULT GetEncryptionCspAlgorithms(ICspInformation pCspInformation, ICspAlgorithms* ppValue);
    HRESULT GetHashAlgorithms(ICspInformation pCspInformation, IObjectIds* ppValue);
}

@GUID("728AB309-217D-11DA-B2A4-000E7BBB2B09")
interface ICspStatus : IDispatch
{
    HRESULT Initialize(ICspInformation pCsp, ICspAlgorithm pAlgorithm);
    HRESULT get_Ordinal(int* pValue);
    HRESULT put_Ordinal(int Value);
    HRESULT get_CspAlgorithm(ICspAlgorithm* ppValue);
    HRESULT get_CspInformation(ICspInformation* ppValue);
    HRESULT get_EnrollmentStatus(IX509EnrollmentStatus* ppValue);
    HRESULT get_DisplayName(BSTR* pValue);
}

@GUID("728AB30A-217D-11DA-B2A4-000E7BBB2B09")
interface ICspStatuses : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICspStatus* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICspStatus pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR strCspName, BSTR strAlgorithmName, ICspStatus* ppValue);
    HRESULT get_ItemByOrdinal(int Ordinal, ICspStatus* ppValue);
    HRESULT get_ItemByOperations(BSTR strCspName, BSTR strAlgorithmName, AlgorithmOperationFlags Operations, 
                                 ICspStatus* ppValue);
    HRESULT get_ItemByProvider(ICspStatus pCspStatus, ICspStatus* ppValue);
}

@GUID("728AB30B-217D-11DA-B2A4-000E7BBB2B09")
interface IX509PublicKey : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, BSTR strEncodedKey, BSTR strEncodedParameters, EncodingType Encoding);
    HRESULT InitializeFromEncodedPublicKeyInfo(BSTR strEncodedPublicKeyInfo, EncodingType Encoding);
    HRESULT get_Algorithm(IObjectId* ppValue);
    HRESULT get_Length(int* pValue);
    HRESULT get_EncodedKey(EncodingType Encoding, BSTR* pValue);
    HRESULT get_EncodedParameters(EncodingType Encoding, BSTR* pValue);
    HRESULT ComputeKeyIdentifier(KeyIdentifierHashAlgorithm Algorithm, EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB30C-217D-11DA-B2A4-000E7BBB2B09")
interface IX509PrivateKey : IDispatch
{
    HRESULT Open();
    HRESULT Create();
    HRESULT Close();
    HRESULT Delete();
    HRESULT Verify(X509PrivateKeyVerify VerifyType);
    HRESULT Import(BSTR strExportType, BSTR strEncodedKey, EncodingType Encoding);
    HRESULT Export(BSTR strExportType, EncodingType Encoding, BSTR* pstrEncodedKey);
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    HRESULT get_ContainerName(BSTR* pValue);
    HRESULT put_ContainerName(BSTR Value);
    HRESULT get_ContainerNamePrefix(BSTR* pValue);
    HRESULT put_ContainerNamePrefix(BSTR Value);
    HRESULT get_ReaderName(BSTR* pValue);
    HRESULT put_ReaderName(BSTR Value);
    HRESULT get_CspInformations(ICspInformations* ppValue);
    HRESULT put_CspInformations(ICspInformations pValue);
    HRESULT get_CspStatus(ICspStatus* ppValue);
    HRESULT put_CspStatus(ICspStatus pValue);
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT put_ProviderName(BSTR Value);
    HRESULT get_ProviderType(X509ProviderType* pValue);
    HRESULT put_ProviderType(X509ProviderType Value);
    HRESULT get_LegacyCsp(short* pValue);
    HRESULT put_LegacyCsp(short Value);
    HRESULT get_Algorithm(IObjectId* ppValue);
    HRESULT put_Algorithm(IObjectId pValue);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT put_KeySpec(X509KeySpec Value);
    HRESULT get_Length(int* pValue);
    HRESULT put_Length(int Value);
    HRESULT get_ExportPolicy(X509PrivateKeyExportFlags* pValue);
    HRESULT put_ExportPolicy(X509PrivateKeyExportFlags Value);
    HRESULT get_KeyUsage(X509PrivateKeyUsageFlags* pValue);
    HRESULT put_KeyUsage(X509PrivateKeyUsageFlags Value);
    HRESULT get_KeyProtection(X509PrivateKeyProtection* pValue);
    HRESULT put_KeyProtection(X509PrivateKeyProtection Value);
    HRESULT get_MachineContext(short* pValue);
    HRESULT put_MachineContext(short Value);
    HRESULT get_SecurityDescriptor(BSTR* pValue);
    HRESULT put_SecurityDescriptor(BSTR Value);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_Certificate(EncodingType Encoding, BSTR Value);
    HRESULT get_UniqueContainerName(BSTR* pValue);
    HRESULT get_Opened(short* pValue);
    HRESULT get_DefaultContainer(short* pValue);
    HRESULT get_Existing(short* pValue);
    HRESULT put_Existing(short Value);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT put_Pin(BSTR Value);
    HRESULT get_FriendlyName(BSTR* pValue);
    HRESULT put_FriendlyName(BSTR Value);
    HRESULT get_Description(BSTR* pValue);
    HRESULT put_Description(BSTR Value);
}

@GUID("728AB362-217D-11DA-B2A4-000E7BBB2B09")
interface IX509PrivateKey2 : IX509PrivateKey
{
    HRESULT get_HardwareKeyUsage(X509HardwareKeyUsageFlags* pValue);
    HRESULT put_HardwareKeyUsage(X509HardwareKeyUsageFlags Value);
    HRESULT get_AlternateStorageLocation(BSTR* pValue);
    HRESULT put_AlternateStorageLocation(BSTR Value);
    HRESULT get_AlgorithmName(BSTR* pValue);
    HRESULT put_AlgorithmName(BSTR Value);
    HRESULT get_AlgorithmParameters(EncodingType Encoding, BSTR* pValue);
    HRESULT put_AlgorithmParameters(EncodingType Encoding, BSTR Value);
    HRESULT get_ParametersExportType(X509KeyParametersExportType* pValue);
    HRESULT put_ParametersExportType(X509KeyParametersExportType Value);
}

@GUID("B11CD855-F4C4-4FC6-B710-4422237F09E9")
interface IX509EndorsementKey : IDispatch
{
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT put_ProviderName(BSTR Value);
    HRESULT get_Length(int* pValue);
    HRESULT get_Opened(short* pValue);
    HRESULT AddCertificate(EncodingType Encoding, BSTR strCertificate);
    HRESULT RemoveCertificate(EncodingType Encoding, BSTR strCertificate);
    HRESULT GetCertificateByIndex(short ManufacturerOnly, int dwIndex, EncodingType Encoding, BSTR* pValue);
    HRESULT GetCertificateCount(short ManufacturerOnly, int* pCount);
    HRESULT ExportPublicKey(IX509PublicKey* ppPublicKey);
    HRESULT Open();
    HRESULT Close();
}

@GUID("728AB30D-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Extension : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Critical(short* pValue);
    HRESULT put_Critical(short Value);
}

@GUID("728AB30E-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Extensions : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509Extension* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509Extension pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    HRESULT AddRange(IX509Extensions pValue);
}

@GUID("728AB30F-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionKeyUsage : IX509Extension
{
    HRESULT InitializeEncode(X509KeyUsageFlags UsageFlags);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_KeyUsage(X509KeyUsageFlags* pValue);
}

@GUID("728AB310-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionEnhancedKeyUsage : IX509Extension
{
    HRESULT InitializeEncode(IObjectIds pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EnhancedKeyUsage(IObjectIds* ppValue);
}

@GUID("728AB311-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionTemplateName : IX509Extension
{
    HRESULT InitializeEncode(BSTR strTemplateName);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_TemplateName(BSTR* pValue);
}

@GUID("728AB312-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionTemplate : IX509Extension
{
    HRESULT InitializeEncode(IObjectId pTemplateOid, int MajorVersion, int MinorVersion);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_TemplateOid(IObjectId* ppValue);
    HRESULT get_MajorVersion(int* pValue);
    HRESULT get_MinorVersion(int* pValue);
}

@GUID("728AB313-217D-11DA-B2A4-000E7BBB2B09")
interface IAlternativeName : IDispatch
{
    HRESULT InitializeFromString(AlternativeNameType Type, BSTR strValue);
    HRESULT InitializeFromRawData(AlternativeNameType Type, EncodingType Encoding, BSTR strRawData);
    HRESULT InitializeFromOtherName(IObjectId pObjectId, EncodingType Encoding, BSTR strRawData, short ToBeWrapped);
    HRESULT get_Type(AlternativeNameType* pValue);
    HRESULT get_StrValue(BSTR* pValue);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB314-217D-11DA-B2A4-000E7BBB2B09")
interface IAlternativeNames : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IAlternativeName* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IAlternativeName pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

@GUID("728AB315-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionAlternativeNames : IX509Extension
{
    HRESULT InitializeEncode(IAlternativeNames pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_AlternativeNames(IAlternativeNames* ppValue);
}

@GUID("728AB316-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionBasicConstraints : IX509Extension
{
    HRESULT InitializeEncode(short IsCA, int PathLenConstraint);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_IsCA(short* pValue);
    HRESULT get_PathLenConstraint(int* pValue);
}

@GUID("728AB317-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionSubjectKeyIdentifier : IX509Extension
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_SubjectKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB318-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionAuthorityKeyIdentifier : IX509Extension
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strKeyIdentifier);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_AuthorityKeyIdentifier(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB319-217D-11DA-B2A4-000E7BBB2B09")
interface ISmimeCapability : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, int BitCount);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_BitCount(int* pValue);
}

@GUID("728AB31A-217D-11DA-B2A4-000E7BBB2B09")
interface ISmimeCapabilities : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ISmimeCapability* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ISmimeCapability pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT AddFromCsp(ICspInformation pValue);
    HRESULT AddAvailableSmimeCapabilities(short MachineContext);
}

@GUID("728AB31B-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionSmimeCapabilities : IX509Extension
{
    HRESULT InitializeEncode(ISmimeCapabilities pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_SmimeCapabilities(ISmimeCapabilities* ppValue);
}

@GUID("728AB31C-217D-11DA-B2A4-000E7BBB2B09")
interface IPolicyQualifier : IDispatch
{
    HRESULT InitializeEncode(BSTR strQualifier, PolicyQualifierType Type);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_Qualifier(BSTR* pValue);
    HRESULT get_Type(PolicyQualifierType* pValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB31D-217D-11DA-B2A4-000E7BBB2B09")
interface IPolicyQualifiers : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IPolicyQualifier* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IPolicyQualifier pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

@GUID("728AB31E-217D-11DA-B2A4-000E7BBB2B09")
interface ICertificatePolicy : IDispatch
{
    HRESULT Initialize(IObjectId pValue);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_PolicyQualifiers(IPolicyQualifiers* ppValue);
}

@GUID("728AB31F-217D-11DA-B2A4-000E7BBB2B09")
interface ICertificatePolicies : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertificatePolicy* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertificatePolicy pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

@GUID("728AB320-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionCertificatePolicies : IX509Extension
{
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

@GUID("728AB321-217D-11DA-B2A4-000E7BBB2B09")
interface IX509ExtensionMSApplicationPolicies : IX509Extension
{
    HRESULT InitializeEncode(ICertificatePolicies pValue);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_Policies(ICertificatePolicies* ppValue);
}

@GUID("728AB322-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Attribute : IDispatch
{
    HRESULT Initialize(IObjectId pObjectId, EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB323-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Attributes : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509Attribute* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509Attribute pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

@GUID("728AB324-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeExtensions : IX509Attribute
{
    HRESULT InitializeEncode(IX509Extensions pExtensions);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
}

@GUID("728AB325-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeClientId : IX509Attribute
{
    HRESULT InitializeEncode(RequestClientInfoClientId ClientId, BSTR strMachineDnsName, BSTR strUserSamName, 
                             BSTR strProcessName);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    HRESULT get_MachineDnsName(BSTR* pValue);
    HRESULT get_UserSamName(BSTR* pValue);
    HRESULT get_ProcessName(BSTR* pValue);
}

@GUID("728AB326-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeRenewalCertificate : IX509Attribute
{
    HRESULT InitializeEncode(EncodingType Encoding, BSTR strCert);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB327-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeArchiveKey : IX509Attribute
{
    HRESULT InitializeEncode(IX509PrivateKey pKey, EncodingType Encoding, BSTR strCAXCert, IObjectId pAlgorithm, 
                             int EncryptionStrength);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EncryptedKeyBlob(EncodingType Encoding, BSTR* pValue);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT get_EncryptionStrength(int* pValue);
}

@GUID("728AB328-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeArchiveKeyHash : IX509Attribute
{
    HRESULT InitializeEncodeFromEncryptedKeyBlob(EncodingType Encoding, BSTR strEncryptedKeyBlob);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_EncryptedKeyHashBlob(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB32A-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeOSVersion : IX509Attribute
{
    HRESULT InitializeEncode(BSTR strOSVersion);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_OSVersion(BSTR* pValue);
}

@GUID("728AB32B-217D-11DA-B2A4-000E7BBB2B09")
interface IX509AttributeCspProvider : IX509Attribute
{
    HRESULT InitializeEncode(X509KeySpec KeySpec, BSTR strProviderName, EncodingType Encoding, BSTR strSignature);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_KeySpec(X509KeySpec* pValue);
    HRESULT get_ProviderName(BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB32C-217D-11DA-B2A4-000E7BBB2B09")
interface ICryptAttribute : IDispatch
{
    HRESULT InitializeFromObjectId(IObjectId pObjectId);
    HRESULT InitializeFromValues(IX509Attributes pAttributes);
    HRESULT get_ObjectId(IObjectId* ppValue);
    HRESULT get_Values(IX509Attributes* ppValue);
}

@GUID("728AB32D-217D-11DA-B2A4-000E7BBB2B09")
interface ICryptAttributes : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICryptAttribute* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICryptAttribute pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexByObjectId(IObjectId pObjectId, int* pIndex);
    HRESULT AddRange(ICryptAttributes pValue);
}

@GUID("728AB32E-217D-11DA-B2A4-000E7BBB2B09")
interface ICertProperty : IDispatch
{
    HRESULT InitializeFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT InitializeDecode(EncodingType Encoding, BSTR strEncodedData);
    HRESULT get_PropertyId(CERTENROLL_PROPERTYID* pValue);
    HRESULT put_PropertyId(CERTENROLL_PROPERTYID Value);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT RemoveFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT SetValueOnCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
}

@GUID("728AB32F-217D-11DA-B2A4-000E7BBB2B09")
interface ICertProperties : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertProperty* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertProperty pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT InitializeFromCertificate(short MachineContext, EncodingType Encoding, BSTR strCertificate);
}

@GUID("728AB330-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyFriendlyName : ICertProperty
{
    HRESULT Initialize(BSTR strFriendlyName);
    HRESULT get_FriendlyName(BSTR* pValue);
}

@GUID("728AB331-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyDescription : ICertProperty
{
    HRESULT Initialize(BSTR strDescription);
    HRESULT get_Description(BSTR* pValue);
}

@GUID("728AB332-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyAutoEnroll : ICertProperty
{
    HRESULT Initialize(BSTR strTemplateName);
    HRESULT get_TemplateName(BSTR* pValue);
}

@GUID("728AB333-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyRequestOriginator : ICertProperty
{
    HRESULT Initialize(BSTR strRequestOriginator);
    HRESULT InitializeFromLocalRequestOriginator();
    HRESULT get_RequestOriginator(BSTR* pValue);
}

@GUID("728AB334-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertySHA1Hash : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    HRESULT get_SHA1Hash(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB336-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyKeyProvInfo : ICertProperty
{
    HRESULT Initialize(IX509PrivateKey pValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
}

@GUID("728AB337-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyArchived : ICertProperty
{
    HRESULT Initialize(short ArchivedValue);
    HRESULT get_Archived(short* pValue);
}

@GUID("728AB338-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyBackedUp : ICertProperty
{
    HRESULT InitializeFromCurrentTime(short BackedUpValue);
    HRESULT Initialize(short BackedUpValue, double Date);
    HRESULT get_BackedUpValue(short* pValue);
    HRESULT get_BackedUpTime(double* pDate);
}

@GUID("728AB339-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyEnrollment : ICertProperty
{
    HRESULT Initialize(int RequestId, BSTR strCADnsName, BSTR strCAName, BSTR strFriendlyName);
    HRESULT get_RequestId(int* pValue);
    HRESULT get_CADnsName(BSTR* pValue);
    HRESULT get_CAName(BSTR* pValue);
    HRESULT get_FriendlyName(BSTR* pValue);
}

@GUID("728AB33A-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyRenewal : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strRenewalValue);
    HRESULT InitializeFromCertificateHash(short MachineContext, EncodingType Encoding, BSTR strCertificate);
    HRESULT get_Renewal(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB33B-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyArchivedKeyHash : ICertProperty
{
    HRESULT Initialize(EncodingType Encoding, BSTR strArchivedKeyHashValue);
    HRESULT get_ArchivedKeyHash(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB34A-217D-11DA-B2A4-000E7BBB2B09")
interface ICertPropertyEnrollmentPolicyServer : ICertProperty
{
    HRESULT Initialize(EnrollmentPolicyServerPropertyFlags PropertyFlags, X509EnrollmentAuthFlags AuthFlags, 
                       X509EnrollmentAuthFlags EnrollmentServerAuthFlags, PolicyServerUrlFlags UrlFlags, 
                       BSTR strRequestId, BSTR strUrl, BSTR strId, BSTR strEnrollmentServerUrl);
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    HRESULT GetPolicyServerId(BSTR* pValue);
    HRESULT GetEnrollmentServerUrl(BSTR* pValue);
    HRESULT GetRequestIdString(BSTR* pValue);
    HRESULT GetPropertyFlags(EnrollmentPolicyServerPropertyFlags* pValue);
    HRESULT GetUrlFlags(PolicyServerUrlFlags* pValue);
    HRESULT GetAuthentication(X509EnrollmentAuthFlags* pValue);
    HRESULT GetEnrollmentServerAuthentication(X509EnrollmentAuthFlags* pValue);
}

@GUID("728AB33C-217D-11DA-B2A4-000E7BBB2B09")
interface IX509SignatureInformation : IDispatch
{
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_PublicKeyAlgorithm(IObjectId* ppValue);
    HRESULT put_PublicKeyAlgorithm(IObjectId pValue);
    HRESULT get_Parameters(EncodingType Encoding, BSTR* pValue);
    HRESULT put_Parameters(EncodingType Encoding, BSTR Value);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_AlternateSignatureAlgorithmSet(short* pValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT put_NullSigned(short Value);
    HRESULT GetSignatureAlgorithm(short Pkcs7Signature, short SignatureKey, IObjectId* ppValue);
    HRESULT SetDefaultValues();
}

@GUID("728AB33D-217D-11DA-B2A4-000E7BBB2B09")
interface ISignerCertificate : IDispatch
{
    HRESULT Initialize(short MachineContext, X509PrivateKeyVerify VerifyType, EncodingType Encoding, 
                       BSTR strCertificate);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT put_Pin(BSTR Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
}

@GUID("728AB33E-217D-11DA-B2A4-000E7BBB2B09")
interface ISignerCertificates : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ISignerCertificate* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ISignerCertificate pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT Find(ISignerCertificate pSignerCert, int* piSignerCert);
}

@GUID("728AB33F-217D-11DA-B2A4-000E7BBB2B09")
interface IX509NameValuePair : IDispatch
{
    HRESULT Initialize(BSTR strName, BSTR strValue);
    HRESULT get_Value(BSTR* pValue);
    HRESULT get_Name(BSTR* pValue);
}

@GUID("728AB340-217D-11DA-B2A4-000E7BBB2B09")
interface IX509NameValuePairs : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509NameValuePair* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509NameValuePair pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
}

@GUID("54244A13-555A-4E22-896D-1B0E52F76406")
interface IX509CertificateTemplate : IDispatch
{
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
}

@GUID("13B79003-2181-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateTemplates : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509CertificateTemplate* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509CertificateTemplate pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_ItemByName(BSTR bstrName, IX509CertificateTemplate* ppValue);
    HRESULT get_ItemByOid(IObjectId pOid, IX509CertificateTemplate* ppValue);
}

@GUID("F49466A7-395A-4E9E-B6E7-32B331600DC0")
interface IX509CertificateTemplateWritable : IDispatch
{
    HRESULT Initialize(IX509CertificateTemplate pValue);
    HRESULT Commit(CommitTemplateFlags commitFlags, BSTR strServerContext);
    HRESULT get_Property(EnrollmentTemplateProperty property, VARIANT* pValue);
    HRESULT put_Property(EnrollmentTemplateProperty property, VARIANT value);
    HRESULT get_Template(IX509CertificateTemplate* ppValue);
}

@GUID("835D1F61-1E95-4BC8-B4D3-976C42B968F7")
interface ICertificationAuthority : IDispatch
{
    HRESULT get_Property(EnrollmentCAProperty property, VARIANT* pValue);
}

@GUID("13B79005-2181-11DA-B2A4-000E7BBB2B09")
interface ICertificationAuthorities : IDispatch
{
    HRESULT get_ItemByIndex(int Index, ICertificationAuthority* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(ICertificationAuthority pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT ComputeSiteCosts();
    HRESULT get_ItemByName(BSTR strName, ICertificationAuthority* ppValue);
}

@GUID("13B79026-2181-11DA-B2A4-000E7BBB2B09")
interface IX509EnrollmentPolicyServer : IDispatch
{
    HRESULT Initialize(BSTR bstrPolicyServerUrl, BSTR bstrPolicyServerId, X509EnrollmentAuthFlags authFlags, 
                       short fIsUnTrusted, X509CertificateEnrollmentContext context);
    HRESULT LoadPolicy(X509EnrollmentPolicyLoadOption option);
    HRESULT GetTemplates(IX509CertificateTemplates* pTemplates);
    HRESULT GetCAsForTemplate(IX509CertificateTemplate pTemplate, ICertificationAuthorities* ppCAs);
    HRESULT GetCAs(ICertificationAuthorities* ppCAs);
    HRESULT Validate();
    HRESULT GetCustomOids(IObjectIds* ppObjectIds);
    HRESULT GetNextUpdateTime(double* pDate);
    HRESULT GetLastUpdateTime(double* pDate);
    HRESULT GetPolicyServerUrl(BSTR* pValue);
    HRESULT GetPolicyServerId(BSTR* pValue);
    HRESULT GetFriendlyName(BSTR* pValue);
    HRESULT GetIsDefaultCEP(short* pValue);
    HRESULT GetUseClientId(short* pValue);
    HRESULT GetAllowUnTrustedCA(short* pValue);
    HRESULT GetCachePath(BSTR* pValue);
    HRESULT GetCacheDir(BSTR* pValue);
    HRESULT GetAuthFlags(X509EnrollmentAuthFlags* pValue);
    HRESULT SetCredential(int hWndParent, X509EnrollmentAuthFlags flag, BSTR strCredential, BSTR strPassword);
    HRESULT QueryChanges(short* pValue);
    HRESULT InitializeImport(VARIANT val);
    HRESULT Export(X509EnrollmentPolicyExportFlags exportFlags, VARIANT* pVal);
    HRESULT get_Cost(uint* pValue);
    HRESULT put_Cost(uint value);
}

@GUID("884E204A-217D-11DA-B2A4-000E7BBB2B09")
interface IX509PolicyServerUrl : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext context);
    HRESULT get_Url(BSTR* ppValue);
    HRESULT put_Url(BSTR pValue);
    HRESULT get_Default(short* pValue);
    HRESULT put_Default(short value);
    HRESULT get_Flags(PolicyServerUrlFlags* pValue);
    HRESULT put_Flags(PolicyServerUrlFlags Flags);
    HRESULT get_AuthFlags(X509EnrollmentAuthFlags* pValue);
    HRESULT put_AuthFlags(X509EnrollmentAuthFlags Flags);
    HRESULT get_Cost(uint* pValue);
    HRESULT put_Cost(uint value);
    HRESULT GetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR* ppValue);
    HRESULT SetStringProperty(PolicyServerUrlPropertyID propertyId, BSTR pValue);
    HRESULT UpdateRegistry(X509CertificateEnrollmentContext context);
    HRESULT RemoveFromRegistry(X509CertificateEnrollmentContext context);
}

@GUID("884E204B-217D-11DA-B2A4-000E7BBB2B09")
interface IX509PolicyServerListManager : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509PolicyServerUrl* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509PolicyServerUrl pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT Initialize(X509CertificateEnrollmentContext context, PolicyServerUrlFlags Flags);
}

@GUID("728AB341-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequest : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    HRESULT Encode();
    HRESULT ResetForEncode();
    HRESULT GetInnerRequest(InnerRequestLevel Level, IX509CertificateRequest* ppValue);
    HRESULT get_Type(X509RequestType* pValue);
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_UIContextMessage(BSTR* pValue);
    HRESULT put_UIContextMessage(BSTR Value);
    HRESULT get_SuppressDefaults(short* pValue);
    HRESULT put_SuppressDefaults(short Value);
    HRESULT get_RenewalCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_RenewalCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_ClientId(RequestClientInfoClientId* pValue);
    HRESULT put_ClientId(RequestClientInfoClientId Value);
    HRESULT get_CspInformations(ICspInformations* ppValue);
    HRESULT put_CspInformations(ICspInformations pValue);
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
}

@GUID("728AB342-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestPkcs10 : IX509CertificateRequest
{
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromPrivateKey(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                     BSTR strTemplateName);
    HRESULT InitializeFromPublicKey(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, 
                                    BSTR strTemplateName);
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, BSTR strCertificate, 
                                      EncodingType Encoding, X509RequestInheritOptions InheritOptions);
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    HRESULT IsSmartCard(short* pValue);
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    HRESULT get_PublicKey(IX509PublicKey* ppValue);
    HRESULT get_PrivateKey(IX509PrivateKey* ppValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_ReuseKey(short* pValue);
    HRESULT get_OldCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Subject(IX500DistinguishedName* ppValue);
    HRESULT put_Subject(IX500DistinguishedName pValue);
    HRESULT get_CspStatuses(ICspStatuses* ppValue);
    HRESULT get_SmimeCapabilities(short* pValue);
    HRESULT put_SmimeCapabilities(short Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_KeyContainerNamePrefix(BSTR* pValue);
    HRESULT put_KeyContainerNamePrefix(BSTR Value);
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
    HRESULT GetCspStatuses(X509KeySpec KeySpec, ICspStatuses* ppCspStatuses);
}

@GUID("728AB35B-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestPkcs10V2 : IX509CertificateRequestPkcs10
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                             IX509EnrollmentPolicyServer pPolicyServer, 
                                             IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPublicKeyTemplate(X509CertificateEnrollmentContext Context, IX509PublicKey pPublicKey, 
                                            IX509EnrollmentPolicyServer pPolicyServer, 
                                            IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

@GUID("54EA9942-3D66-4530-B76E-7C9170D3EC52")
interface IX509CertificateRequestPkcs10V3 : IX509CertificateRequestPkcs10V2
{
    HRESULT get_AttestPrivateKey(short* pValue);
    HRESULT put_AttestPrivateKey(short Value);
    HRESULT get_AttestationEncryptionCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_AttestationEncryptionCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    HRESULT get_EncryptionStrength(int* pValue);
    HRESULT put_EncryptionStrength(int Value);
    HRESULT get_ChallengePassword(BSTR* pValue);
    HRESULT put_ChallengePassword(BSTR Value);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
}

@GUID("728AB363-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestPkcs10V4 : IX509CertificateRequestPkcs10V3
{
    HRESULT get_ClaimType(KeyAttestationClaimType* pValue);
    HRESULT put_ClaimType(KeyAttestationClaimType Value);
    HRESULT get_AttestPrivateKeyPreferred(short* pValue);
    HRESULT put_AttestPrivateKeyPreferred(short Value);
}

@GUID("728AB343-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestCertificate : IX509CertificateRequestPkcs10
{
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    HRESULT get_NotBefore(double* pValue);
    HRESULT put_NotBefore(double Value);
    HRESULT get_NotAfter(double* pValue);
    HRESULT put_NotAfter(double Value);
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT put_SerialNumber(EncodingType Encoding, BSTR Value);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

@GUID("728AB35A-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestCertificate2 : IX509CertificateRequestCertificate
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromPrivateKeyTemplate(X509CertificateEnrollmentContext Context, IX509PrivateKey pPrivateKey, 
                                             IX509EnrollmentPolicyServer pPolicyServer, 
                                             IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
}

@GUID("728AB344-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestPkcs7 : IX509CertificateRequest
{
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromCertificate(X509CertificateEnrollmentContext Context, short RenewalRequest, 
                                      BSTR strCertificate, EncodingType Encoding, 
                                      X509RequestInheritOptions InheritOptions);
    HRESULT InitializeFromInnerRequest(IX509CertificateRequest pInnerRequest);
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT get_RequesterName(BSTR* pValue);
    HRESULT put_RequesterName(BSTR Value);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
}

@GUID("728AB35C-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestPkcs7V2 : IX509CertificateRequestPkcs7
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT CheckCertificateSignature(short ValidateCertificateChain);
}

@GUID("728AB345-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestCmc : IX509CertificateRequestPkcs7
{
    HRESULT InitializeFromInnerRequestTemplateName(IX509CertificateRequest pInnerRequest, BSTR strTemplateName);
    HRESULT get_TemplateObjectId(IObjectId* ppValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_CryptAttributes(ICryptAttributes* ppValue);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SuppressOids(IObjectIds* ppValue);
    HRESULT get_TransactionId(int* pValue);
    HRESULT put_TransactionId(int Value);
    HRESULT get_SenderNonce(EncodingType Encoding, BSTR* pValue);
    HRESULT put_SenderNonce(EncodingType Encoding, BSTR Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_ArchivePrivateKey(short* pValue);
    HRESULT put_ArchivePrivateKey(short Value);
    HRESULT get_KeyArchivalCertificate(EncodingType Encoding, BSTR* pValue);
    HRESULT put_KeyArchivalCertificate(EncodingType Encoding, BSTR Value);
    HRESULT get_EncryptionAlgorithm(IObjectId* ppValue);
    HRESULT put_EncryptionAlgorithm(IObjectId pValue);
    HRESULT get_EncryptionStrength(int* pValue);
    HRESULT put_EncryptionStrength(int Value);
    HRESULT get_EncryptedKeyHash(EncodingType Encoding, BSTR* pValue);
    HRESULT get_SignerCertificates(ISignerCertificates* ppValue);
}

@GUID("728AB35D-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRequestCmc2 : IX509CertificateRequestCmc
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InitializeFromInnerRequestTemplate(IX509CertificateRequest pInnerRequest, 
                                               IX509EnrollmentPolicyServer pPolicyServer, 
                                               IX509CertificateTemplate pTemplate);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT CheckSignature(Pkcs10AllowedSignatureTypes AllowedSignatureTypes);
    HRESULT CheckCertificateSignature(ISignerCertificate pSignerCertificate, short ValidateCertificateChain);
}

@GUID("728AB346-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Enrollment : IDispatch
{
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
    HRESULT InitializeFromTemplateName(X509CertificateEnrollmentContext Context, BSTR strTemplateName);
    HRESULT InitializeFromRequest(IX509CertificateRequest pRequest);
    HRESULT CreateRequest(EncodingType Encoding, BSTR* pValue);
    HRESULT Enroll();
    HRESULT InstallResponse(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, 
                            BSTR strPassword);
    HRESULT CreatePFX(BSTR strPassword, PFXExportOptions ExportOptions, EncodingType Encoding, BSTR* pValue);
    HRESULT get_Request(IX509CertificateRequest* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT get_ParentWindow(int* pValue);
    HRESULT put_ParentWindow(int Value);
    HRESULT get_NameValuePairs(IX509NameValuePairs* ppValue);
    HRESULT get_EnrollmentContext(X509CertificateEnrollmentContext* pValue);
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Response(EncodingType Encoding, BSTR* pValue);
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    HRESULT put_CertificateFriendlyName(BSTR strValue);
    HRESULT get_CertificateDescription(BSTR* pValue);
    HRESULT put_CertificateDescription(BSTR strValue);
    HRESULT get_RequestId(int* pValue);
    HRESULT get_CAConfigString(BSTR* pValue);
}

@GUID("728AB350-217D-11DA-B2A4-000E7BBB2B09")
interface IX509Enrollment2 : IX509Enrollment
{
    HRESULT InitializeFromTemplate(X509CertificateEnrollmentContext context, 
                                   IX509EnrollmentPolicyServer pPolicyServer, IX509CertificateTemplate pTemplate);
    HRESULT InstallResponse2(InstallResponseRestrictionFlags Restrictions, BSTR strResponse, EncodingType Encoding, 
                             BSTR strPassword, BSTR strEnrollmentPolicyServerUrl, BSTR strEnrollmentPolicyServerID, 
                             PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags);
    HRESULT get_PolicyServer(IX509EnrollmentPolicyServer* ppPolicyServer);
    HRESULT get_Template(IX509CertificateTemplate* ppTemplate);
    HRESULT get_RequestIdString(BSTR* pValue);
}

@GUID("728AB351-217D-11DA-B2A4-000E7BBB2B09")
interface IX509EnrollmentHelper : IDispatch
{
    HRESULT AddPolicyServer(BSTR strEnrollmentPolicyServerURI, BSTR strEnrollmentPolicyID, 
                            PolicyServerUrlFlags EnrollmentPolicyServerFlags, X509EnrollmentAuthFlags authFlags, 
                            BSTR strCredential, BSTR strPassword);
    HRESULT AddEnrollmentServer(BSTR strEnrollmentServerURI, X509EnrollmentAuthFlags authFlags, BSTR strCredential, 
                                BSTR strPassword);
    HRESULT Enroll(BSTR strEnrollmentPolicyServerURI, BSTR strTemplateName, EncodingType Encoding, 
                   WebEnrollmentFlags enrollFlags, BSTR* pstrCertificate);
    HRESULT Initialize(X509CertificateEnrollmentContext Context);
}

@GUID("728AB349-217D-11DA-B2A4-000E7BBB2B09")
interface IX509EnrollmentWebClassFactory : IDispatch
{
    HRESULT CreateObject(BSTR strProgID, IUnknown* ppIUnknown);
}

@GUID("728AB352-217D-11DA-B2A4-000E7BBB2B09")
interface IX509MachineEnrollmentFactory : IDispatch
{
    HRESULT CreateObject(BSTR strProgID, IX509EnrollmentHelper* ppIHelper);
}

@GUID("728AB35E-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRevocationListEntry : IDispatch
{
    HRESULT Initialize(EncodingType Encoding, BSTR SerialNumber, double RevocationDate);
    HRESULT get_SerialNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RevocationDate(double* pValue);
    HRESULT get_RevocationReason(CRLRevocationReason* pValue);
    HRESULT put_RevocationReason(CRLRevocationReason Value);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
}

@GUID("728AB35F-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRevocationListEntries : IDispatch
{
    HRESULT get_ItemByIndex(int Index, IX509CertificateRevocationListEntry* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT Add(IX509CertificateRevocationListEntry pVal);
    HRESULT Remove(int Index);
    HRESULT Clear();
    HRESULT get_IndexBySerialNumber(EncodingType Encoding, BSTR SerialNumber, int* pIndex);
    HRESULT AddRange(IX509CertificateRevocationListEntries pValue);
}

@GUID("728AB360-217D-11DA-B2A4-000E7BBB2B09")
interface IX509CertificateRevocationList : IDispatch
{
    HRESULT Initialize();
    HRESULT InitializeDecode(BSTR strEncodedData, EncodingType Encoding);
    HRESULT Encode();
    HRESULT ResetForEncode();
    HRESULT CheckPublicKeySignature(IX509PublicKey pPublicKey);
    HRESULT CheckSignature();
    HRESULT get_Issuer(IX500DistinguishedName* ppValue);
    HRESULT put_Issuer(IX500DistinguishedName pValue);
    HRESULT get_ThisUpdate(double* pValue);
    HRESULT put_ThisUpdate(double Value);
    HRESULT get_NextUpdate(double* pValue);
    HRESULT put_NextUpdate(double Value);
    HRESULT get_X509CRLEntries(IX509CertificateRevocationListEntries* ppValue);
    HRESULT get_X509Extensions(IX509Extensions* ppValue);
    HRESULT get_CriticalExtensions(IObjectIds* ppValue);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    HRESULT get_CRLNumber(EncodingType Encoding, BSTR* pValue);
    HRESULT put_CRLNumber(EncodingType Encoding, BSTR Value);
    HRESULT get_CAVersion(int* pValue);
    HRESULT put_CAVersion(int pValue);
    HRESULT get_BaseCRL(short* pValue);
    HRESULT get_NullSigned(short* pValue);
    HRESULT get_HashAlgorithm(IObjectId* ppValue);
    HRESULT put_HashAlgorithm(IObjectId pValue);
    HRESULT get_AlternateSignatureAlgorithm(short* pValue);
    HRESULT put_AlternateSignatureAlgorithm(short Value);
    HRESULT get_SignatureInformation(IX509SignatureInformation* ppValue);
    HRESULT get_RawData(EncodingType Encoding, BSTR* pValue);
    HRESULT get_RawDataToBeSigned(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Signature(EncodingType Encoding, BSTR* pValue);
}

@GUID("6F175A7C-4A3A-40AE-9DBA-592FD6BBF9B8")
interface ICertificateAttestationChallenge : IDispatch
{
    HRESULT Initialize(EncodingType Encoding, BSTR strPendingFullCmcResponseWithChallenge);
    HRESULT DecryptChallenge(EncodingType Encoding, BSTR* pstrEnvelopedPkcs7ReencryptedToCA);
    HRESULT get_RequestID(BSTR* pstrRequestID);
}

@GUID("4631334D-E266-47D6-BD79-BE53CB2E2753")
interface ICertificateAttestationChallenge2 : ICertificateAttestationChallenge
{
    HRESULT put_KeyContainerName(BSTR Value);
    HRESULT put_KeyBlob(EncodingType Encoding, BSTR Value);
}

@GUID("728AB361-217D-11DA-B2A4-000E7BBB2B09")
interface IX509SCEPEnrollment : IDispatch
{
    HRESULT Initialize(IX509CertificateRequestPkcs10 pRequest, BSTR strThumbprint, EncodingType ThumprintEncoding, 
                       BSTR strServerCertificates, EncodingType Encoding);
    HRESULT InitializeForPending(X509CertificateEnrollmentContext Context);
    HRESULT CreateRequestMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT CreateRetrievePendingMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT CreateRetrieveCertificateMessage(X509CertificateEnrollmentContext Context, BSTR strIssuer, 
                                             EncodingType IssuerEncoding, BSTR strSerialNumber, 
                                             EncodingType SerialNumberEncoding, EncodingType Encoding, BSTR* pValue);
    HRESULT ProcessResponseMessage(BSTR strResponse, EncodingType Encoding, X509SCEPDisposition* pDisposition);
    HRESULT put_ServerCapabilities(BSTR Value);
    HRESULT get_FailInfo(X509SCEPFailInfo* pValue);
    HRESULT get_SignerCertificate(ISignerCertificate* ppValue);
    HRESULT put_SignerCertificate(ISignerCertificate pValue);
    HRESULT get_OldCertificate(ISignerCertificate* ppValue);
    HRESULT put_OldCertificate(ISignerCertificate pValue);
    HRESULT get_TransactionId(EncodingType Encoding, BSTR* pValue);
    HRESULT put_TransactionId(EncodingType Encoding, BSTR Value);
    HRESULT get_Request(IX509CertificateRequestPkcs10* ppValue);
    HRESULT get_CertificateFriendlyName(BSTR* pValue);
    HRESULT put_CertificateFriendlyName(BSTR Value);
    HRESULT get_Status(IX509EnrollmentStatus* ppValue);
    HRESULT get_Certificate(EncodingType Encoding, BSTR* pValue);
    HRESULT get_Silent(short* pValue);
    HRESULT put_Silent(short Value);
    HRESULT DeleteRequest();
}

@GUID("728AB364-217D-11DA-B2A4-000E7BBB2B09")
interface IX509SCEPEnrollment2 : IX509SCEPEnrollment
{
    HRESULT CreateChallengeAnswerMessage(EncodingType Encoding, BSTR* pValue);
    HRESULT ProcessResponseMessage2(X509SCEPProcessMessageFlags Flags, BSTR strResponse, EncodingType Encoding, 
                                    X509SCEPDisposition* pDisposition);
    HRESULT get_ResultMessageText(BSTR* pValue);
    HRESULT get_DelayRetry(DelayRetryAction* pValue);
    HRESULT get_ActivityId(BSTR* pValue);
    HRESULT put_ActivityId(BSTR Value);
}

@GUID("728AB365-217D-11DA-B2A4-000E7BBB2B09")
interface IX509SCEPEnrollmentHelper : IDispatch
{
    HRESULT Initialize(BSTR strServerUrl, BSTR strRequestHeaders, IX509CertificateRequestPkcs10 pRequest, 
                       BSTR strCACertificateThumbprint);
    HRESULT InitializeForPending(BSTR strServerUrl, BSTR strRequestHeaders, 
                                 X509CertificateEnrollmentContext Context, BSTR strTransactionId);
    HRESULT Enroll(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT FetchPending(X509SCEPProcessMessageFlags ProcessFlags, X509SCEPDisposition* pDisposition);
    HRESULT get_X509SCEPEnrollment(IX509SCEPEnrollment* ppValue);
    HRESULT get_ResultMessageText(BSTR* pValue);
}

@GUID("6BA73778-36DA-4C39-8A85-BCFA7D000793")
interface ICertSrvSetupKeyInformation : IDispatch
{
    HRESULT get_ProviderName(BSTR* pVal);
    HRESULT put_ProviderName(const(ushort)* bstrVal);
    HRESULT get_Length(int* pVal);
    HRESULT put_Length(int lVal);
    HRESULT get_Existing(short* pVal);
    HRESULT put_Existing(short bVal);
    HRESULT get_ContainerName(BSTR* pVal);
    HRESULT put_ContainerName(const(ushort)* bstrVal);
    HRESULT get_HashAlgorithm(BSTR* pVal);
    HRESULT put_HashAlgorithm(const(ushort)* bstrVal);
    HRESULT get_ExistingCACertificate(VARIANT* pVal);
    HRESULT put_ExistingCACertificate(VARIANT varVal);
}

@GUID("E65C8B00-E58F-41F9-A9EC-A28D7427C844")
interface ICertSrvSetupKeyInformationCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT Add(ICertSrvSetupKeyInformation pIKeyInformation);
}

@GUID("B760A1BB-4784-44C0-8F12-555F0780FF25")
interface ICertSrvSetup : IDispatch
{
    HRESULT get_CAErrorId(int* pVal);
    HRESULT get_CAErrorString(BSTR* pVal);
    HRESULT InitializeDefaults(short bServer, short bClient);
    HRESULT GetCASetupProperty(CASetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetCASetupProperty(CASetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT IsPropertyEditable(CASetupProperty propertyId, short* pbEditable);
    HRESULT GetSupportedCATypes(VARIANT* pCATypes);
    HRESULT GetProviderNameList(VARIANT* pVal);
    HRESULT GetKeyLengthList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetHashAlgorithmList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetPrivateKeyContainerList(const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT GetExistingCACertificates(ICertSrvSetupKeyInformationCollection* ppVal);
    HRESULT CAImportPFX(const(ushort)* bstrFileName, const(ushort)* bstrPasswd, short bOverwriteExistingKey, 
                        ICertSrvSetupKeyInformation* ppVal);
    HRESULT SetCADistinguishedName(const(ushort)* bstrCADN, short bIgnoreUnicode, short bOverwriteExistingKey, 
                                   short bOverwriteExistingCAInDS);
    HRESULT SetDatabaseInformation(const(ushort)* bstrDBDirectory, const(ushort)* bstrLogDirectory, 
                                   const(ushort)* bstrSharedFolder, short bForceOverwrite);
    HRESULT SetParentCAInformation(const(ushort)* bstrCAConfiguration);
    HRESULT SetWebCAInformation(const(ushort)* bstrCAConfiguration);
    HRESULT Install();
    HRESULT PreUnInstall(short bClientOnly);
    HRESULT PostUnInstall();
}

@GUID("4F7761BB-9F3B-4592-9EE0-9A73259C313E")
interface IMSCEPSetup : IDispatch
{
    HRESULT get_MSCEPErrorId(int* pVal);
    HRESULT get_MSCEPErrorString(BSTR* pVal);
    HRESULT InitializeDefaults();
    HRESULT GetMSCEPSetupProperty(MSCEPSetupProperty propertyId, VARIANT* pVal);
    HRESULT SetMSCEPSetupProperty(MSCEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetAccountInformation(const(ushort)* bstrUserName, const(ushort)* bstrPassword);
    HRESULT IsMSCEPStoreEmpty(short* pbEmpty);
    HRESULT GetProviderNameList(short bExchange, VARIANT* pVal);
    HRESULT GetKeyLengthList(short bExchange, const(ushort)* bstrProviderName, VARIANT* pVal);
    HRESULT Install();
    HRESULT PreUnInstall();
    HRESULT PostUnInstall();
}

@GUID("70027FDB-9DD9-4921-8944-B35CB31BD2EC")
interface ICertificateEnrollmentServerSetup : IDispatch
{
    HRESULT get_ErrorString(BSTR* pVal);
    HRESULT InitializeInstallDefaults();
    HRESULT GetProperty(CESSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetProperty(CESSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetApplicationPoolCredentials(const(ushort)* bstrUsername, const(ushort)* bstrPassword);
    HRESULT Install();
    HRESULT UnInstall(VARIANT* pCAConfig, VARIANT* pAuthentication);
}

@GUID("859252CC-238C-4A88-B8FD-A37E7D04E68B")
interface ICertificateEnrollmentPolicyServerSetup : IDispatch
{
    HRESULT get_ErrorString(BSTR* pVal);
    HRESULT InitializeInstallDefaults();
    HRESULT GetProperty(CEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT SetProperty(CEPSetupProperty propertyId, VARIANT* pPropertyValue);
    HRESULT Install();
    HRESULT UnInstall(VARIANT* pAuthKeyBasedRenewal);
}

@GUID("9C735BE2-57A5-11D1-9BDB-00C04FB683FA")
interface IEnumCERTVIEWCOLUMN : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetDisplayName(BSTR* pstrOut);
    HRESULT GetType(int* pType);
    HRESULT IsIndexed(int* pIndexed);
    HRESULT GetMaxLength(int* pMaxLength);
    HRESULT GetValue(int Flags, VARIANT* pvarValue);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWCOLUMN* ppenum);
}

@GUID("E77DB656-7653-11D1-9BDE-00C04FB683FA")
interface IEnumCERTVIEWATTRIBUTE : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetValue(BSTR* pstrOut);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWATTRIBUTE* ppenum);
}

@GUID("E7DD1466-7653-11D1-9BDE-00C04FB683FA")
interface IEnumCERTVIEWEXTENSION : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT GetName(BSTR* pstrOut);
    HRESULT GetFlags(int* pFlags);
    HRESULT GetValue(int Type, int Flags, VARIANT* pvarValue);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWEXTENSION* ppenum);
}

@GUID("D1157F4C-5AF2-11D1-9BDC-00C04FB683FA")
interface IEnumCERTVIEWROW : IDispatch
{
    HRESULT Next(int* pIndex);
    HRESULT EnumCertViewColumn(IEnumCERTVIEWCOLUMN* ppenum);
    HRESULT EnumCertViewAttribute(int Flags, IEnumCERTVIEWATTRIBUTE* ppenum);
    HRESULT EnumCertViewExtension(int Flags, IEnumCERTVIEWEXTENSION* ppenum);
    HRESULT Skip(int celt);
    HRESULT Reset();
    HRESULT Clone(IEnumCERTVIEWROW* ppenum);
    HRESULT GetMaxIndex(int* pIndex);
}

@GUID("C3FAC344-1E84-11D1-9BD6-00C04FB683FA")
interface ICertView : IDispatch
{
    HRESULT OpenConnection(const(ushort)* strConfig);
    HRESULT EnumCertViewColumn(int fResultColumn, IEnumCERTVIEWCOLUMN* ppenum);
    HRESULT GetColumnCount(int fResultColumn, int* pcColumn);
    HRESULT GetColumnIndex(int fResultColumn, const(ushort)* strColumnName, int* pColumnIndex);
    HRESULT SetResultColumnCount(int cResultColumn);
    HRESULT SetResultColumn(int ColumnIndex);
    HRESULT SetRestriction(int ColumnIndex, int SeekOperator, int SortOrder, const(VARIANT)* pvarValue);
    HRESULT OpenView(IEnumCERTVIEWROW* ppenum);
}

@GUID("D594B282-8851-4B61-9C66-3EDADF848863")
interface ICertView2 : ICertView
{
    HRESULT SetTable(int Table);
}

@GUID("34DF6950-7FB6-11D0-8817-00A0C903B83C")
interface ICertAdmin : IDispatch
{
    HRESULT IsValidCertificate(const(ushort)* strConfig, const(ushort)* strSerialNumber, int* pDisposition);
    HRESULT GetRevocationReason(int* pReason);
    HRESULT RevokeCertificate(const(ushort)* strConfig, const(ushort)* strSerialNumber, int Reason, double Date);
    HRESULT SetRequestAttributes(const(ushort)* strConfig, int RequestId, const(ushort)* strAttributes);
    HRESULT SetCertificateExtension(const(ushort)* strConfig, int RequestId, const(ushort)* strExtensionName, 
                                    int Type, int Flags, const(VARIANT)* pvarValue);
    HRESULT DenyRequest(const(ushort)* strConfig, int RequestId);
    HRESULT ResubmitRequest(const(ushort)* strConfig, int RequestId, int* pDisposition);
    HRESULT PublishCRL(const(ushort)* strConfig, double Date);
    HRESULT GetCRL(const(ushort)* strConfig, int Flags, BSTR* pstrCRL);
    HRESULT ImportCertificate(const(ushort)* strConfig, const(ushort)* strCertificate, int Flags, int* pRequestId);
}

@GUID("F7C3AC41-B8CE-4FB4-AA58-3D1DC0E36B39")
interface ICertAdmin2 : ICertAdmin
{
    HRESULT PublishCRLs(const(ushort)* strConfig, double Date, int CRLFlags);
    HRESULT GetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, int Flags, 
                          VARIANT* pvarPropertyValue);
    HRESULT SetCAProperty(const(ushort)* strConfig, int PropId, int PropIndex, int PropType, 
                          VARIANT* pvarPropertyValue);
    HRESULT GetCAPropertyFlags(const(ushort)* strConfig, int PropId, int* pPropFlags);
    HRESULT GetCAPropertyDisplayName(const(ushort)* strConfig, int PropId, BSTR* pstrDisplayName);
    HRESULT GetArchivedKey(const(ushort)* strConfig, int RequestId, int Flags, BSTR* pstrArchivedKey);
    HRESULT GetConfigEntry(const(ushort)* strConfig, const(ushort)* strNodePath, const(ushort)* strEntryName, 
                           VARIANT* pvarEntry);
    HRESULT SetConfigEntry(const(ushort)* strConfig, const(ushort)* strNodePath, const(ushort)* strEntryName, 
                           VARIANT* pvarEntry);
    HRESULT ImportKey(const(ushort)* strConfig, int RequestId, const(ushort)* strCertHash, int Flags, 
                      const(ushort)* strKey);
    HRESULT GetMyRoles(const(ushort)* strConfig, int* pRoles);
    HRESULT DeleteRow(const(ushort)* strConfig, int Flags, double Date, int Table, int RowId, int* pcDeleted);
}

@GUID("66FB7839-5F04-4C25-AD18-9FF1A8376EE0")
interface IOCSPProperty : IDispatch
{
    HRESULT get_Name(BSTR* pVal);
    HRESULT get_Value(VARIANT* pVal);
    HRESULT put_Value(VARIANT newVal);
    HRESULT get_Modified(short* pVal);
}

@GUID("2597C18D-54E6-4B74-9FA9-A6BFDA99CBBE")
interface IOCSPPropertyCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get_ItemByName(const(ushort)* bstrPropName, VARIANT* pVal);
    HRESULT CreateProperty(const(ushort)* bstrPropName, const(VARIANT)* pVarPropValue, IOCSPProperty* ppVal);
    HRESULT DeleteProperty(const(ushort)* bstrPropName);
    HRESULT InitializeFromProperties(const(VARIANT)* pVarProperties);
    HRESULT GetAllProperties(VARIANT* pVarProperties);
}

@GUID("AEC92B40-3D46-433F-87D1-B84D5C1E790D")
interface IOCSPCAConfiguration : IDispatch
{
    HRESULT get_Identifier(BSTR* pVal);
    HRESULT get_CACertificate(VARIANT* pVal);
    HRESULT get_HashAlgorithm(BSTR* pVal);
    HRESULT put_HashAlgorithm(const(ushort)* newVal);
    HRESULT get_SigningFlags(uint* pVal);
    HRESULT put_SigningFlags(uint newVal);
    HRESULT get_SigningCertificate(VARIANT* pVal);
    HRESULT put_SigningCertificate(VARIANT newVal);
    HRESULT get_ReminderDuration(uint* pVal);
    HRESULT put_ReminderDuration(uint newVal);
    HRESULT get_ErrorCode(uint* pVal);
    HRESULT get_CSPName(BSTR* pVal);
    HRESULT get_KeySpec(uint* pVal);
    HRESULT get_ProviderCLSID(BSTR* pVal);
    HRESULT put_ProviderCLSID(const(ushort)* newVal);
    HRESULT get_ProviderProperties(VARIANT* pVal);
    HRESULT put_ProviderProperties(VARIANT newVal);
    HRESULT get_Modified(short* pVal);
    HRESULT get_LocalRevocationInformation(VARIANT* pVal);
    HRESULT put_LocalRevocationInformation(VARIANT newVal);
    HRESULT get_SigningCertificateTemplate(BSTR* pVal);
    HRESULT put_SigningCertificateTemplate(const(ushort)* newVal);
    HRESULT get_CAConfig(BSTR* pVal);
    HRESULT put_CAConfig(const(ushort)* newVal);
}

@GUID("2BEBEA0B-5ECE-4F28-A91C-86B4BB20F0D3")
interface IOCSPCAConfigurationCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Item(int Index, VARIANT* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT get_ItemByName(const(ushort)* bstrIdentifier, VARIANT* pVal);
    HRESULT CreateCAConfiguration(const(ushort)* bstrIdentifier, VARIANT varCACert, IOCSPCAConfiguration* ppVal);
    HRESULT DeleteCAConfiguration(const(ushort)* bstrIdentifier);
}

@GUID("322E830D-67DB-4FE9-9577-4596D9F09294")
interface IOCSPAdmin : IDispatch
{
    HRESULT get_OCSPServiceProperties(IOCSPPropertyCollection* ppVal);
    HRESULT get_OCSPCAConfigurationCollection(IOCSPCAConfigurationCollection* pVal);
    HRESULT GetConfiguration(const(ushort)* bstrServerName, short bForce);
    HRESULT SetConfiguration(const(ushort)* bstrServerName, short bForce);
    HRESULT GetMyRoles(const(ushort)* bstrServerName, int* pRoles);
    HRESULT Ping(const(ushort)* bstrServerName);
    HRESULT SetSecurity(const(ushort)* bstrServerName, const(ushort)* bstrVal);
    HRESULT GetSecurity(const(ushort)* bstrServerName, BSTR* pVal);
    HRESULT GetSigningCertificates(const(ushort)* bstrServerName, const(VARIANT)* pCACertVar, VARIANT* pVal);
    HRESULT GetHashAlgorithms(const(ushort)* bstrServerName, const(ushort)* bstrCAId, VARIANT* pVal);
}

@GUID("12A88820-7494-11D0-8816-00A0C903B83C")
interface ICertEncodeStringArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetStringType(int* pStringType);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, BSTR* pstr);
    HRESULT Reset(int Count, int StringType);
    HRESULT SetValue(int Index, const(ushort)* str);
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("9C680D93-9B7D-4E95-9018-4FFE10BA5ADA")
interface ICertEncodeStringArray2 : ICertEncodeStringArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

@GUID("15E2F230-A0A2-11D0-8821-00A0C903B83C")
interface ICertEncodeLongArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, int* pValue);
    HRESULT Reset(int Count);
    HRESULT SetValue(int Index, int Value);
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("4EFDE84A-BD9B-4FC2-A108-C347D478840F")
interface ICertEncodeLongArray2 : ICertEncodeLongArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

@GUID("2F9469A0-A470-11D0-8821-00A0C903B83C")
interface ICertEncodeDateArray : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetCount(int* pCount);
    HRESULT GetValue(int Index, double* pValue);
    HRESULT Reset(int Count);
    HRESULT SetValue(int Index, double Value);
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("99A4EDB5-2B8E-448D-BF95-BBA8D7789DC8")
interface ICertEncodeDateArray2 : ICertEncodeDateArray
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

@GUID("01958640-BBFF-11D0-8825-00A0C903B83C")
interface ICertEncodeCRLDistInfo : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetDistPointCount(int* pDistPointCount);
    HRESULT GetNameCount(int DistPointIndex, int* pNameCount);
    HRESULT GetNameChoice(int DistPointIndex, int NameIndex, int* pNameChoice);
    HRESULT GetName(int DistPointIndex, int NameIndex, BSTR* pstrName);
    HRESULT Reset(int DistPointCount);
    HRESULT SetNameCount(int DistPointIndex, int NameCount);
    HRESULT SetNameEntry(int DistPointIndex, int NameIndex, int NameChoice, const(ushort)* strName);
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("B4275D4B-3E30-446F-AD36-09D03120B078")
interface ICertEncodeCRLDistInfo2 : ICertEncodeCRLDistInfo
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
}

@GUID("1C9A8C70-1271-11D1-9BD4-00C04FB683FA")
interface ICertEncodeAltName : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetNameCount(int* pNameCount);
    HRESULT GetNameChoice(int NameIndex, int* pNameChoice);
    HRESULT GetName(int NameIndex, BSTR* pstrName);
    HRESULT Reset(int NameCount);
    HRESULT SetNameEntry(int NameIndex, int NameChoice, const(ushort)* strName);
    HRESULT Encode(BSTR* pstrBinary);
}

@GUID("F67FE177-5EF1-4535-B4CE-29DF15E2E0C3")
interface ICertEncodeAltName2 : ICertEncodeAltName
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(EncodingType Encoding, BSTR* pstrEncodedData);
    HRESULT GetNameBlob(int NameIndex, EncodingType Encoding, BSTR* pstrName);
    HRESULT SetNameEntryBlob(int NameIndex, int NameChoice, const(ushort)* strName, EncodingType Encoding);
}

@GUID("6DB525BE-1278-11D1-9BD4-00C04FB683FA")
interface ICertEncodeBitString : IDispatch
{
    HRESULT Decode(const(ushort)* strBinary);
    HRESULT GetBitCount(int* pBitCount);
    HRESULT GetBitString(BSTR* pstrBitString);
    HRESULT Encode(int BitCount, BSTR strBitString, BSTR* pstrBinary);
}

@GUID("E070D6E7-23EF-4DD2-8242-EBD9C928CB30")
interface ICertEncodeBitString2 : ICertEncodeBitString
{
    HRESULT DecodeBlob(const(ushort)* strEncodedData, EncodingType Encoding);
    HRESULT EncodeBlob(int BitCount, const(ushort)* strBitString, EncodingType EncodingIn, EncodingType Encoding, 
                       BSTR* pstrEncodedData);
    HRESULT GetBitStringBlob(EncodingType Encoding, BSTR* pstrBitString);
}

@GUID("E19AE1A0-7364-11D0-8816-00A0C903B83C")
interface ICertExit : IDispatch
{
    HRESULT Initialize(const(ushort)* strConfig, int* pEventMask);
    HRESULT Notify(int ExitEvent, int Context);
    HRESULT GetDescription(BSTR* pstrDescription);
}

@GUID("0ABF484B-D049-464D-A7ED-552E7529B0FF")
interface ICertExit2 : ICertExit
{
    HRESULT GetManageModule(ICertManageModule* ppManageModule);
}

@GUID("43F8F288-7A20-11D0-8F06-00C04FC295E1")
interface ICEnroll : IDispatch
{
    HRESULT createFilePKCS10(BSTR DNName, BSTR Usage, BSTR wszPKCS10FileName);
    HRESULT acceptFilePKCS7(BSTR wszPKCS7FileName);
    HRESULT createPKCS10(BSTR DNName, BSTR Usage, BSTR* pPKCS10);
    HRESULT acceptPKCS7(BSTR PKCS7);
    HRESULT getCertFromPKCS7(BSTR wszPKCS7, BSTR* pbstrCert);
    HRESULT enumProviders(int dwIndex, int dwFlags, BSTR* pbstrProvName);
    HRESULT enumContainers(int dwIndex, BSTR* pbstr);
    HRESULT freeRequestInfo(BSTR PKCS7OrPKCS10);
    HRESULT get_MyStoreName(BSTR* pbstrName);
    HRESULT put_MyStoreName(BSTR bstrName);
    HRESULT get_MyStoreType(BSTR* pbstrType);
    HRESULT put_MyStoreType(BSTR bstrType);
    HRESULT get_MyStoreFlags(int* pdwFlags);
    HRESULT put_MyStoreFlags(int dwFlags);
    HRESULT get_CAStoreName(BSTR* pbstrName);
    HRESULT put_CAStoreName(BSTR bstrName);
    HRESULT get_CAStoreType(BSTR* pbstrType);
    HRESULT put_CAStoreType(BSTR bstrType);
    HRESULT get_CAStoreFlags(int* pdwFlags);
    HRESULT put_CAStoreFlags(int dwFlags);
    HRESULT get_RootStoreName(BSTR* pbstrName);
    HRESULT put_RootStoreName(BSTR bstrName);
    HRESULT get_RootStoreType(BSTR* pbstrType);
    HRESULT put_RootStoreType(BSTR bstrType);
    HRESULT get_RootStoreFlags(int* pdwFlags);
    HRESULT put_RootStoreFlags(int dwFlags);
    HRESULT get_RequestStoreName(BSTR* pbstrName);
    HRESULT put_RequestStoreName(BSTR bstrName);
    HRESULT get_RequestStoreType(BSTR* pbstrType);
    HRESULT put_RequestStoreType(BSTR bstrType);
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    HRESULT put_RequestStoreFlags(int dwFlags);
    HRESULT get_ContainerName(BSTR* pbstrContainer);
    HRESULT put_ContainerName(BSTR bstrContainer);
    HRESULT get_ProviderName(BSTR* pbstrProvider);
    HRESULT put_ProviderName(BSTR bstrProvider);
    HRESULT get_ProviderType(int* pdwType);
    HRESULT put_ProviderType(int dwType);
    HRESULT get_KeySpec(int* pdw);
    HRESULT put_KeySpec(int dw);
    HRESULT get_ProviderFlags(int* pdwFlags);
    HRESULT put_ProviderFlags(int dwFlags);
    HRESULT get_UseExistingKeySet(int* fUseExistingKeys);
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    HRESULT get_GenKeyFlags(int* pdwFlags);
    HRESULT put_GenKeyFlags(int dwFlags);
    HRESULT get_DeleteRequestCert(int* fDelete);
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    HRESULT get_WriteCertToCSP(int* fBool);
    HRESULT put_WriteCertToCSP(BOOL fBool);
    HRESULT get_SPCFileName(BSTR* pbstr);
    HRESULT put_SPCFileName(BSTR bstr);
    HRESULT get_PVKFileName(BSTR* pbstr);
    HRESULT put_PVKFileName(BSTR bstr);
    HRESULT get_HashAlgorithm(BSTR* pbstr);
    HRESULT put_HashAlgorithm(BSTR bstr);
}

@GUID("704CA730-C90B-11D1-9BEC-00C04FC295E1")
interface ICEnroll2 : ICEnroll
{
    HRESULT addCertTypeToRequest(BSTR CertType);
    HRESULT addNameValuePairToSignature(BSTR Name, BSTR Value);
    HRESULT get_WriteCertToUserDS(int* fBool);
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    HRESULT get_EnableT61DNEncoding(int* fBool);
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
}

@GUID("C28C2D95-B7DE-11D2-A421-00C04F79FE8E")
interface ICEnroll3 : ICEnroll2
{
    HRESULT InstallPKCS7(BSTR PKCS7);
    HRESULT Reset();
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    HRESULT GetAlgName(int algID, BSTR* pbstr);
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(int* fReuseHardwareKeyIfUnableToGenNew);
    HRESULT put_HashAlgID(int hashAlgID);
    HRESULT get_HashAlgID(int* hashAlgID);
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    HRESULT get_LimitExchangeKeyToEncipherment(int* fLimitExchangeKeyToEncipherment);
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    HRESULT get_EnableSMIMECapabilities(int* fEnableSMIMECapabilities);
}

@GUID("C1F1188A-2EB5-4A80-841B-7E729A356D90")
interface ICEnroll4 : ICEnroll3
{
    HRESULT put_PrivateKeyArchiveCertificate(BSTR bstrCert);
    HRESULT get_PrivateKeyArchiveCertificate(BSTR* pbstrCert);
    HRESULT put_ThumbPrint(BSTR bstrThumbPrint);
    HRESULT get_ThumbPrint(BSTR* pbstrThumbPrint);
    HRESULT binaryToString(int Flags, BSTR strBinary, BSTR* pstrEncoded);
    HRESULT stringToBinary(int Flags, BSTR strEncoded, BSTR* pstrBinary);
    HRESULT addExtensionToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT addAttributeToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT addNameValuePairToRequest(int Flags, BSTR strName, BSTR strValue);
    HRESULT resetExtensions();
    HRESULT resetAttributes();
    HRESULT createRequest(int Flags, BSTR strDNName, BSTR Usage, BSTR* pstrRequest);
    HRESULT createFileRequest(int Flags, BSTR strDNName, BSTR strUsage, BSTR strRequestFileName);
    HRESULT acceptResponse(BSTR strResponse);
    HRESULT acceptFileResponse(BSTR strResponseFileName);
    HRESULT getCertFromResponse(BSTR strResponse, BSTR* pstrCert);
    HRESULT getCertFromFileResponse(BSTR strResponseFileName, BSTR* pstrCert);
    HRESULT createPFX(BSTR strPassword, BSTR* pstrPFX);
    HRESULT createFilePFX(BSTR strPassword, BSTR strPFXFileName);
    HRESULT setPendingRequestInfo(int lRequestID, BSTR strCADNS, BSTR strCAName, BSTR strFriendlyName);
    HRESULT enumPendingRequest(int lIndex, int lDesiredProperty, VARIANT* pvarProperty);
    HRESULT removePendingRequest(BSTR strThumbprint);
    HRESULT GetKeyLenEx(int lSizeSpec, int lKeySpec, int* pdwKeySize);
    HRESULT InstallPKCS7Ex(BSTR PKCS7, int* plCertInstalled);
    HRESULT addCertTypeToRequestEx(int lType, BSTR bstrOIDOrName, int lMajorVersion, BOOL fMinorVersion, 
                                   int lMinorVersion);
    HRESULT getProviderType(BSTR strProvName, int* plProvType);
    HRESULT put_SignerCertificate(BSTR bstrCert);
    HRESULT put_ClientId(int lClientId);
    HRESULT get_ClientId(int* plClientId);
    HRESULT addBlobPropertyToCertificate(int lPropertyId, int lReserved, BSTR bstrProperty);
    HRESULT resetBlobProperties();
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    HRESULT get_IncludeSubjectKeyID(int* pfInclude);
}

@GUID("ACAA7838-4585-11D1-AB57-00C04FC295E1")
interface IEnroll : IUnknown
{
    HRESULT createFilePKCS10WStr(const(wchar)* DNName, const(wchar)* Usage, const(wchar)* wszPKCS10FileName);
    HRESULT acceptFilePKCS7WStr(const(wchar)* wszPKCS7FileName);
    HRESULT createPKCS10WStr(const(wchar)* DNName, const(wchar)* Usage, CRYPTOAPI_BLOB* pPkcs10Blob);
    HRESULT acceptPKCS7Blob(CRYPTOAPI_BLOB* pBlobPKCS7);
    CERT_CONTEXT* getCertContextFromPKCS7(CRYPTOAPI_BLOB* pBlobPKCS7);
    void*   getMyStore();
    void*   getCAStore();
    void*   getROOTHStore();
    HRESULT enumProvidersWStr(int dwIndex, int dwFlags, ushort** pbstrProvName);
    HRESULT enumContainersWStr(int dwIndex, ushort** pbstr);
    HRESULT freeRequestInfoBlob(CRYPTOAPI_BLOB pkcs7OrPkcs10);
    HRESULT get_MyStoreNameWStr(ushort** szwName);
    HRESULT put_MyStoreNameWStr(const(wchar)* szwName);
    HRESULT get_MyStoreTypeWStr(ushort** szwType);
    HRESULT put_MyStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_MyStoreFlags(int* pdwFlags);
    HRESULT put_MyStoreFlags(int dwFlags);
    HRESULT get_CAStoreNameWStr(ushort** szwName);
    HRESULT put_CAStoreNameWStr(const(wchar)* szwName);
    HRESULT get_CAStoreTypeWStr(ushort** szwType);
    HRESULT put_CAStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_CAStoreFlags(int* pdwFlags);
    HRESULT put_CAStoreFlags(int dwFlags);
    HRESULT get_RootStoreNameWStr(ushort** szwName);
    HRESULT put_RootStoreNameWStr(const(wchar)* szwName);
    HRESULT get_RootStoreTypeWStr(ushort** szwType);
    HRESULT put_RootStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_RootStoreFlags(int* pdwFlags);
    HRESULT put_RootStoreFlags(int dwFlags);
    HRESULT get_RequestStoreNameWStr(ushort** szwName);
    HRESULT put_RequestStoreNameWStr(const(wchar)* szwName);
    HRESULT get_RequestStoreTypeWStr(ushort** szwType);
    HRESULT put_RequestStoreTypeWStr(const(wchar)* szwType);
    HRESULT get_RequestStoreFlags(int* pdwFlags);
    HRESULT put_RequestStoreFlags(int dwFlags);
    HRESULT get_ContainerNameWStr(ushort** szwContainer);
    HRESULT put_ContainerNameWStr(const(wchar)* szwContainer);
    HRESULT get_ProviderNameWStr(ushort** szwProvider);
    HRESULT put_ProviderNameWStr(const(wchar)* szwProvider);
    HRESULT get_ProviderType(int* pdwType);
    HRESULT put_ProviderType(int dwType);
    HRESULT get_KeySpec(int* pdw);
    HRESULT put_KeySpec(int dw);
    HRESULT get_ProviderFlags(int* pdwFlags);
    HRESULT put_ProviderFlags(int dwFlags);
    HRESULT get_UseExistingKeySet(int* fUseExistingKeys);
    HRESULT put_UseExistingKeySet(BOOL fUseExistingKeys);
    HRESULT get_GenKeyFlags(int* pdwFlags);
    HRESULT put_GenKeyFlags(int dwFlags);
    HRESULT get_DeleteRequestCert(int* fDelete);
    HRESULT put_DeleteRequestCert(BOOL fDelete);
    HRESULT get_WriteCertToUserDS(int* fBool);
    HRESULT put_WriteCertToUserDS(BOOL fBool);
    HRESULT get_EnableT61DNEncoding(int* fBool);
    HRESULT put_EnableT61DNEncoding(BOOL fBool);
    HRESULT get_WriteCertToCSP(int* fBool);
    HRESULT put_WriteCertToCSP(BOOL fBool);
    HRESULT get_SPCFileNameWStr(ushort** szw);
    HRESULT put_SPCFileNameWStr(const(wchar)* szw);
    HRESULT get_PVKFileNameWStr(ushort** szw);
    HRESULT put_PVKFileNameWStr(const(wchar)* szw);
    HRESULT get_HashAlgorithmWStr(ushort** szw);
    HRESULT put_HashAlgorithmWStr(const(wchar)* szw);
    HRESULT get_RenewalCertificate(CERT_CONTEXT** ppCertContext);
    HRESULT put_RenewalCertificate(CERT_CONTEXT* pCertContext);
    HRESULT AddCertTypeToRequestWStr(const(wchar)* szw);
    HRESULT AddNameValuePairToSignatureWStr(const(wchar)* Name, const(wchar)* Value);
    HRESULT AddExtensionsToRequest(CERT_EXTENSIONS* pCertExtensions);
    HRESULT AddAuthenticatedAttributesToPKCS7Request(CRYPT_ATTRIBUTES* pAttributes);
    HRESULT CreatePKCS7RequestFromRequest(CRYPTOAPI_BLOB* pRequest, CERT_CONTEXT* pSigningCertContext, 
                                          CRYPTOAPI_BLOB* pPkcs7Blob);
}

@GUID("C080E199-B7DF-11D2-A421-00C04F79FE8E")
interface IEnroll2 : IEnroll
{
    HRESULT InstallPKCS7Blob(CRYPTOAPI_BLOB* pBlobPKCS7);
    HRESULT Reset();
    HRESULT GetSupportedKeySpec(int* pdwKeySpec);
    HRESULT GetKeyLen(BOOL fMin, BOOL fExchange, int* pdwKeySize);
    HRESULT EnumAlgs(int dwIndex, int algClass, int* pdwAlgID);
    HRESULT GetAlgNameWStr(int algID, ushort** ppwsz);
    HRESULT put_ReuseHardwareKeyIfUnableToGenNew(BOOL fReuseHardwareKeyIfUnableToGenNew);
    HRESULT get_ReuseHardwareKeyIfUnableToGenNew(int* fReuseHardwareKeyIfUnableToGenNew);
    HRESULT put_HashAlgID(int hashAlgID);
    HRESULT get_HashAlgID(int* hashAlgID);
    HRESULT SetHStoreMy(void* hStore);
    HRESULT SetHStoreCA(void* hStore);
    HRESULT SetHStoreROOT(void* hStore);
    HRESULT SetHStoreRequest(void* hStore);
    HRESULT put_LimitExchangeKeyToEncipherment(BOOL fLimitExchangeKeyToEncipherment);
    HRESULT get_LimitExchangeKeyToEncipherment(int* fLimitExchangeKeyToEncipherment);
    HRESULT put_EnableSMIMECapabilities(BOOL fEnableSMIMECapabilities);
    HRESULT get_EnableSMIMECapabilities(int* fEnableSMIMECapabilities);
}

@GUID("F8053FE5-78F4-448F-A0DB-41D61B73446B")
interface IEnroll4 : IEnroll2
{
    HRESULT put_ThumbPrintWStr(CRYPTOAPI_BLOB thumbPrintBlob);
    HRESULT get_ThumbPrintWStr(CRYPTOAPI_BLOB* thumbPrintBlob);
    HRESULT SetPrivateKeyArchiveCertificate(CERT_CONTEXT* pPrivateKeyArchiveCert);
    CERT_CONTEXT* GetPrivateKeyArchiveCertificate();
    HRESULT binaryBlobToString(int Flags, CRYPTOAPI_BLOB* pblobBinary, ushort** ppwszString);
    HRESULT stringToBinaryBlob(int Flags, const(wchar)* pwszString, CRYPTOAPI_BLOB* pblobBinary, int* pdwSkip, 
                               int* pdwFlags);
    HRESULT addExtensionToRequestWStr(int Flags, const(wchar)* pwszName, CRYPTOAPI_BLOB* pblobValue);
    HRESULT addAttributeToRequestWStr(int Flags, const(wchar)* pwszName, CRYPTOAPI_BLOB* pblobValue);
    HRESULT addNameValuePairToRequestWStr(int Flags, const(wchar)* pwszName, const(wchar)* pwszValue);
    HRESULT resetExtensions();
    HRESULT resetAttributes();
    HRESULT createRequestWStr(int Flags, const(wchar)* pwszDNName, const(wchar)* pwszUsage, 
                              CRYPTOAPI_BLOB* pblobRequest);
    HRESULT createFileRequestWStr(int Flags, const(wchar)* pwszDNName, const(wchar)* pwszUsage, 
                                  const(wchar)* pwszRequestFileName);
    HRESULT acceptResponseBlob(CRYPTOAPI_BLOB* pblobResponse);
    HRESULT acceptFileResponseWStr(const(wchar)* pwszResponseFileName);
    HRESULT getCertContextFromResponseBlob(CRYPTOAPI_BLOB* pblobResponse, CERT_CONTEXT** ppCertContext);
    HRESULT getCertContextFromFileResponseWStr(const(wchar)* pwszResponseFileName, CERT_CONTEXT** ppCertContext);
    HRESULT createPFXWStr(const(wchar)* pwszPassword, CRYPTOAPI_BLOB* pblobPFX);
    HRESULT createFilePFXWStr(const(wchar)* pwszPassword, const(wchar)* pwszPFXFileName);
    HRESULT setPendingRequestInfoWStr(int lRequestID, const(wchar)* pwszCADNS, const(wchar)* pwszCAName, 
                                      const(wchar)* pwszFriendlyName);
    HRESULT enumPendingRequestWStr(int lIndex, int lDesiredProperty, void* ppProperty);
    HRESULT removePendingRequestWStr(CRYPTOAPI_BLOB thumbPrintBlob);
    HRESULT GetKeyLenEx(int lSizeSpec, int lKeySpec, int* pdwKeySize);
    HRESULT InstallPKCS7BlobEx(CRYPTOAPI_BLOB* pBlobPKCS7, int* plCertInstalled);
    HRESULT AddCertTypeToRequestWStrEx(int lType, const(wchar)* pwszOIDOrName, int lMajorVersion, 
                                       BOOL fMinorVersion, int lMinorVersion);
    HRESULT getProviderTypeWStr(const(wchar)* pwszProvName, int* plProvType);
    HRESULT addBlobPropertyToCertificateWStr(int lPropertyId, int lReserved, CRYPTOAPI_BLOB* pBlobProperty);
    HRESULT SetSignerCertificate(CERT_CONTEXT* pSignerCert);
    HRESULT put_ClientId(int lClientId);
    HRESULT get_ClientId(int* plClientId);
    HRESULT put_IncludeSubjectKeyID(BOOL fInclude);
    HRESULT get_IncludeSubjectKeyID(int* pfInclude);
}

@GUID("6D90E0D0-200D-11D1-AFFB-00C04FB984F9")
interface ISceSvcAttachmentPersistInfo : IUnknown
{
    HRESULT Save(byte* lpTemplateName, void** scesvcHandle, void** ppvData, int* pbOverwriteAll);
    HRESULT IsDirty(byte* lpTemplateName);
    HRESULT FreeBuffer(void* pvData);
}

@GUID("17C35FDE-200D-11D1-AFFB-00C04FB984F9")
interface ISceSvcAttachmentData : IUnknown
{
    HRESULT GetData(void* scesvcHandle, SCESVC_INFO_TYPE sceType, void** ppvData, uint* psceEnumHandle);
    HRESULT Initialize(byte* lpServiceName, byte* lpTemplateName, ISceSvcAttachmentPersistInfo lpSceSvcPersistInfo, 
                       void** pscesvcHandle);
    HRESULT FreeBuffer(void* pvData);
    HRESULT CloseHandle(void* scesvcHandle);
}


// GUIDs

const GUID CLSID_AzAuthorizationStore                    = GUIDOF!AzAuthorizationStore;
const GUID CLSID_AzBizRuleContext                        = GUIDOF!AzBizRuleContext;
const GUID CLSID_AzPrincipalLocator                      = GUIDOF!AzPrincipalLocator;
const GUID CLSID_CAlternativeName                        = GUIDOF!CAlternativeName;
const GUID CLSID_CAlternativeNames                       = GUIDOF!CAlternativeNames;
const GUID CLSID_CBinaryConverter                        = GUIDOF!CBinaryConverter;
const GUID CLSID_CCertAdmin                              = GUIDOF!CCertAdmin;
const GUID CLSID_CCertConfig                             = GUIDOF!CCertConfig;
const GUID CLSID_CCertEncodeAltName                      = GUIDOF!CCertEncodeAltName;
const GUID CLSID_CCertEncodeBitString                    = GUIDOF!CCertEncodeBitString;
const GUID CLSID_CCertEncodeCRLDistInfo                  = GUIDOF!CCertEncodeCRLDistInfo;
const GUID CLSID_CCertEncodeDateArray                    = GUIDOF!CCertEncodeDateArray;
const GUID CLSID_CCertEncodeLongArray                    = GUIDOF!CCertEncodeLongArray;
const GUID CLSID_CCertEncodeStringArray                  = GUIDOF!CCertEncodeStringArray;
const GUID CLSID_CCertGetConfig                          = GUIDOF!CCertGetConfig;
const GUID CLSID_CCertProperties                         = GUIDOF!CCertProperties;
const GUID CLSID_CCertProperty                           = GUIDOF!CCertProperty;
const GUID CLSID_CCertPropertyArchived                   = GUIDOF!CCertPropertyArchived;
const GUID CLSID_CCertPropertyArchivedKeyHash            = GUIDOF!CCertPropertyArchivedKeyHash;
const GUID CLSID_CCertPropertyAutoEnroll                 = GUIDOF!CCertPropertyAutoEnroll;
const GUID CLSID_CCertPropertyBackedUp                   = GUIDOF!CCertPropertyBackedUp;
const GUID CLSID_CCertPropertyDescription                = GUIDOF!CCertPropertyDescription;
const GUID CLSID_CCertPropertyEnrollment                 = GUIDOF!CCertPropertyEnrollment;
const GUID CLSID_CCertPropertyEnrollmentPolicyServer     = GUIDOF!CCertPropertyEnrollmentPolicyServer;
const GUID CLSID_CCertPropertyFriendlyName               = GUIDOF!CCertPropertyFriendlyName;
const GUID CLSID_CCertPropertyKeyProvInfo                = GUIDOF!CCertPropertyKeyProvInfo;
const GUID CLSID_CCertPropertyRenewal                    = GUIDOF!CCertPropertyRenewal;
const GUID CLSID_CCertPropertyRequestOriginator          = GUIDOF!CCertPropertyRequestOriginator;
const GUID CLSID_CCertPropertySHA1Hash                   = GUIDOF!CCertPropertySHA1Hash;
const GUID CLSID_CCertRequest                            = GUIDOF!CCertRequest;
const GUID CLSID_CCertServerExit                         = GUIDOF!CCertServerExit;
const GUID CLSID_CCertServerPolicy                       = GUIDOF!CCertServerPolicy;
const GUID CLSID_CCertSrvSetup                           = GUIDOF!CCertSrvSetup;
const GUID CLSID_CCertSrvSetupKeyInformation             = GUIDOF!CCertSrvSetupKeyInformation;
const GUID CLSID_CCertView                               = GUIDOF!CCertView;
const GUID CLSID_CCertificateAttestationChallenge        = GUIDOF!CCertificateAttestationChallenge;
const GUID CLSID_CCertificateEnrollmentPolicyServerSetup = GUIDOF!CCertificateEnrollmentPolicyServerSetup;
const GUID CLSID_CCertificateEnrollmentServerSetup       = GUIDOF!CCertificateEnrollmentServerSetup;
const GUID CLSID_CCertificatePolicies                    = GUIDOF!CCertificatePolicies;
const GUID CLSID_CCertificatePolicy                      = GUIDOF!CCertificatePolicy;
const GUID CLSID_CCryptAttribute                         = GUIDOF!CCryptAttribute;
const GUID CLSID_CCryptAttributes                        = GUIDOF!CCryptAttributes;
const GUID CLSID_CCspInformation                         = GUIDOF!CCspInformation;
const GUID CLSID_CCspInformations                        = GUIDOF!CCspInformations;
const GUID CLSID_CCspStatus                              = GUIDOF!CCspStatus;
const GUID CLSID_CEnroll                                 = GUIDOF!CEnroll;
const GUID CLSID_CEnroll2                                = GUIDOF!CEnroll2;
const GUID CLSID_CIdentityProfileHandler                 = GUIDOF!CIdentityProfileHandler;
const GUID CLSID_CMSCEPSetup                             = GUIDOF!CMSCEPSetup;
const GUID CLSID_CObjectId                               = GUIDOF!CObjectId;
const GUID CLSID_CObjectIds                              = GUIDOF!CObjectIds;
const GUID CLSID_CPolicyQualifier                        = GUIDOF!CPolicyQualifier;
const GUID CLSID_CPolicyQualifiers                       = GUIDOF!CPolicyQualifiers;
const GUID CLSID_CSignerCertificate                      = GUIDOF!CSignerCertificate;
const GUID CLSID_CSmimeCapabilities                      = GUIDOF!CSmimeCapabilities;
const GUID CLSID_CSmimeCapability                        = GUIDOF!CSmimeCapability;
const GUID CLSID_CX500DistinguishedName                  = GUIDOF!CX500DistinguishedName;
const GUID CLSID_CX509Attribute                          = GUIDOF!CX509Attribute;
const GUID CLSID_CX509AttributeArchiveKey                = GUIDOF!CX509AttributeArchiveKey;
const GUID CLSID_CX509AttributeArchiveKeyHash            = GUIDOF!CX509AttributeArchiveKeyHash;
const GUID CLSID_CX509AttributeClientId                  = GUIDOF!CX509AttributeClientId;
const GUID CLSID_CX509AttributeCspProvider               = GUIDOF!CX509AttributeCspProvider;
const GUID CLSID_CX509AttributeExtensions                = GUIDOF!CX509AttributeExtensions;
const GUID CLSID_CX509AttributeOSVersion                 = GUIDOF!CX509AttributeOSVersion;
const GUID CLSID_CX509AttributeRenewalCertificate        = GUIDOF!CX509AttributeRenewalCertificate;
const GUID CLSID_CX509Attributes                         = GUIDOF!CX509Attributes;
const GUID CLSID_CX509CertificateRequestCertificate      = GUIDOF!CX509CertificateRequestCertificate;
const GUID CLSID_CX509CertificateRequestCmc              = GUIDOF!CX509CertificateRequestCmc;
const GUID CLSID_CX509CertificateRequestPkcs10           = GUIDOF!CX509CertificateRequestPkcs10;
const GUID CLSID_CX509CertificateRequestPkcs7            = GUIDOF!CX509CertificateRequestPkcs7;
const GUID CLSID_CX509CertificateRevocationList          = GUIDOF!CX509CertificateRevocationList;
const GUID CLSID_CX509CertificateRevocationListEntries   = GUIDOF!CX509CertificateRevocationListEntries;
const GUID CLSID_CX509CertificateRevocationListEntry     = GUIDOF!CX509CertificateRevocationListEntry;
const GUID CLSID_CX509CertificateTemplateADWritable      = GUIDOF!CX509CertificateTemplateADWritable;
const GUID CLSID_CX509EndorsementKey                     = GUIDOF!CX509EndorsementKey;
const GUID CLSID_CX509Enrollment                         = GUIDOF!CX509Enrollment;
const GUID CLSID_CX509EnrollmentHelper                   = GUIDOF!CX509EnrollmentHelper;
const GUID CLSID_CX509EnrollmentPolicyActiveDirectory    = GUIDOF!CX509EnrollmentPolicyActiveDirectory;
const GUID CLSID_CX509EnrollmentPolicyWebService         = GUIDOF!CX509EnrollmentPolicyWebService;
const GUID CLSID_CX509EnrollmentWebClassFactory          = GUIDOF!CX509EnrollmentWebClassFactory;
const GUID CLSID_CX509Extension                          = GUIDOF!CX509Extension;
const GUID CLSID_CX509ExtensionAlternativeNames          = GUIDOF!CX509ExtensionAlternativeNames;
const GUID CLSID_CX509ExtensionAuthorityKeyIdentifier    = GUIDOF!CX509ExtensionAuthorityKeyIdentifier;
const GUID CLSID_CX509ExtensionBasicConstraints          = GUIDOF!CX509ExtensionBasicConstraints;
const GUID CLSID_CX509ExtensionCertificatePolicies       = GUIDOF!CX509ExtensionCertificatePolicies;
const GUID CLSID_CX509ExtensionEnhancedKeyUsage          = GUIDOF!CX509ExtensionEnhancedKeyUsage;
const GUID CLSID_CX509ExtensionKeyUsage                  = GUIDOF!CX509ExtensionKeyUsage;
const GUID CLSID_CX509ExtensionMSApplicationPolicies     = GUIDOF!CX509ExtensionMSApplicationPolicies;
const GUID CLSID_CX509ExtensionSmimeCapabilities         = GUIDOF!CX509ExtensionSmimeCapabilities;
const GUID CLSID_CX509ExtensionSubjectKeyIdentifier      = GUIDOF!CX509ExtensionSubjectKeyIdentifier;
const GUID CLSID_CX509ExtensionTemplate                  = GUIDOF!CX509ExtensionTemplate;
const GUID CLSID_CX509ExtensionTemplateName              = GUIDOF!CX509ExtensionTemplateName;
const GUID CLSID_CX509Extensions                         = GUIDOF!CX509Extensions;
const GUID CLSID_CX509MachineEnrollmentFactory           = GUIDOF!CX509MachineEnrollmentFactory;
const GUID CLSID_CX509NameValuePair                      = GUIDOF!CX509NameValuePair;
const GUID CLSID_CX509PolicyServerListManager            = GUIDOF!CX509PolicyServerListManager;
const GUID CLSID_CX509PolicyServerUrl                    = GUIDOF!CX509PolicyServerUrl;
const GUID CLSID_CX509PrivateKey                         = GUIDOF!CX509PrivateKey;
const GUID CLSID_CX509PublicKey                          = GUIDOF!CX509PublicKey;
const GUID CLSID_CX509SCEPEnrollment                     = GUIDOF!CX509SCEPEnrollment;
const GUID CLSID_CX509SCEPEnrollmentHelper               = GUIDOF!CX509SCEPEnrollmentHelper;
const GUID CLSID_CoClassIdentityStore                    = GUIDOF!CoClassIdentityStore;
const GUID CLSID_OCSPAdmin                               = GUIDOF!OCSPAdmin;
const GUID CLSID_OCSPPropertyCollection                  = GUIDOF!OCSPPropertyCollection;
const GUID CLSID_RemoteTpmVirtualSmartCardManager        = GUIDOF!RemoteTpmVirtualSmartCardManager;
const GUID CLSID_TpmVirtualSmartCardManager              = GUIDOF!TpmVirtualSmartCardManager;

const GUID IID_AsyncIAssociatedIdentityProvider          = GUIDOF!AsyncIAssociatedIdentityProvider;
const GUID IID_AsyncIConnectedIdentityProvider           = GUIDOF!AsyncIConnectedIdentityProvider;
const GUID IID_AsyncIIdentityAdvise                      = GUIDOF!AsyncIIdentityAdvise;
const GUID IID_AsyncIIdentityAuthentication              = GUIDOF!AsyncIIdentityAuthentication;
const GUID IID_AsyncIIdentityProvider                    = GUIDOF!AsyncIIdentityProvider;
const GUID IID_AsyncIIdentityStore                       = GUIDOF!AsyncIIdentityStore;
const GUID IID_AsyncIIdentityStoreEx                     = GUIDOF!AsyncIIdentityStoreEx;
const GUID IID_IAlternativeName                          = GUIDOF!IAlternativeName;
const GUID IID_IAlternativeNames                         = GUIDOF!IAlternativeNames;
const GUID IID_IAssociatedIdentityProvider               = GUIDOF!IAssociatedIdentityProvider;
const GUID IID_IAzApplication                            = GUIDOF!IAzApplication;
const GUID IID_IAzApplication2                           = GUIDOF!IAzApplication2;
const GUID IID_IAzApplication3                           = GUIDOF!IAzApplication3;
const GUID IID_IAzApplicationGroup                       = GUIDOF!IAzApplicationGroup;
const GUID IID_IAzApplicationGroup2                      = GUIDOF!IAzApplicationGroup2;
const GUID IID_IAzApplicationGroups                      = GUIDOF!IAzApplicationGroups;
const GUID IID_IAzApplications                           = GUIDOF!IAzApplications;
const GUID IID_IAzAuthorizationStore                     = GUIDOF!IAzAuthorizationStore;
const GUID IID_IAzAuthorizationStore2                    = GUIDOF!IAzAuthorizationStore2;
const GUID IID_IAzAuthorizationStore3                    = GUIDOF!IAzAuthorizationStore3;
const GUID IID_IAzBizRuleContext                         = GUIDOF!IAzBizRuleContext;
const GUID IID_IAzBizRuleInterfaces                      = GUIDOF!IAzBizRuleInterfaces;
const GUID IID_IAzBizRuleParameters                      = GUIDOF!IAzBizRuleParameters;
const GUID IID_IAzClientContext                          = GUIDOF!IAzClientContext;
const GUID IID_IAzClientContext2                         = GUIDOF!IAzClientContext2;
const GUID IID_IAzClientContext3                         = GUIDOF!IAzClientContext3;
const GUID IID_IAzNameResolver                           = GUIDOF!IAzNameResolver;
const GUID IID_IAzObjectPicker                           = GUIDOF!IAzObjectPicker;
const GUID IID_IAzOperation                              = GUIDOF!IAzOperation;
const GUID IID_IAzOperation2                             = GUIDOF!IAzOperation2;
const GUID IID_IAzOperations                             = GUIDOF!IAzOperations;
const GUID IID_IAzPrincipalLocator                       = GUIDOF!IAzPrincipalLocator;
const GUID IID_IAzRole                                   = GUIDOF!IAzRole;
const GUID IID_IAzRoleAssignment                         = GUIDOF!IAzRoleAssignment;
const GUID IID_IAzRoleAssignments                        = GUIDOF!IAzRoleAssignments;
const GUID IID_IAzRoleDefinition                         = GUIDOF!IAzRoleDefinition;
const GUID IID_IAzRoleDefinitions                        = GUIDOF!IAzRoleDefinitions;
const GUID IID_IAzRoles                                  = GUIDOF!IAzRoles;
const GUID IID_IAzScope                                  = GUIDOF!IAzScope;
const GUID IID_IAzScope2                                 = GUIDOF!IAzScope2;
const GUID IID_IAzScopes                                 = GUIDOF!IAzScopes;
const GUID IID_IAzTask                                   = GUIDOF!IAzTask;
const GUID IID_IAzTask2                                  = GUIDOF!IAzTask2;
const GUID IID_IAzTasks                                  = GUIDOF!IAzTasks;
const GUID IID_IBinaryConverter                          = GUIDOF!IBinaryConverter;
const GUID IID_IBinaryConverter2                         = GUIDOF!IBinaryConverter2;
const GUID IID_ICEnroll                                  = GUIDOF!ICEnroll;
const GUID IID_ICEnroll2                                 = GUIDOF!ICEnroll2;
const GUID IID_ICEnroll3                                 = GUIDOF!ICEnroll3;
const GUID IID_ICEnroll4                                 = GUIDOF!ICEnroll4;
const GUID IID_ICertAdmin                                = GUIDOF!ICertAdmin;
const GUID IID_ICertAdmin2                               = GUIDOF!ICertAdmin2;
const GUID IID_ICertConfig                               = GUIDOF!ICertConfig;
const GUID IID_ICertConfig2                              = GUIDOF!ICertConfig2;
const GUID IID_ICertEncodeAltName                        = GUIDOF!ICertEncodeAltName;
const GUID IID_ICertEncodeAltName2                       = GUIDOF!ICertEncodeAltName2;
const GUID IID_ICertEncodeBitString                      = GUIDOF!ICertEncodeBitString;
const GUID IID_ICertEncodeBitString2                     = GUIDOF!ICertEncodeBitString2;
const GUID IID_ICertEncodeCRLDistInfo                    = GUIDOF!ICertEncodeCRLDistInfo;
const GUID IID_ICertEncodeCRLDistInfo2                   = GUIDOF!ICertEncodeCRLDistInfo2;
const GUID IID_ICertEncodeDateArray                      = GUIDOF!ICertEncodeDateArray;
const GUID IID_ICertEncodeDateArray2                     = GUIDOF!ICertEncodeDateArray2;
const GUID IID_ICertEncodeLongArray                      = GUIDOF!ICertEncodeLongArray;
const GUID IID_ICertEncodeLongArray2                     = GUIDOF!ICertEncodeLongArray2;
const GUID IID_ICertEncodeStringArray                    = GUIDOF!ICertEncodeStringArray;
const GUID IID_ICertEncodeStringArray2                   = GUIDOF!ICertEncodeStringArray2;
const GUID IID_ICertExit                                 = GUIDOF!ICertExit;
const GUID IID_ICertExit2                                = GUIDOF!ICertExit2;
const GUID IID_ICertGetConfig                            = GUIDOF!ICertGetConfig;
const GUID IID_ICertManageModule                         = GUIDOF!ICertManageModule;
const GUID IID_ICertPolicy                               = GUIDOF!ICertPolicy;
const GUID IID_ICertPolicy2                              = GUIDOF!ICertPolicy2;
const GUID IID_ICertProperties                           = GUIDOF!ICertProperties;
const GUID IID_ICertProperty                             = GUIDOF!ICertProperty;
const GUID IID_ICertPropertyArchived                     = GUIDOF!ICertPropertyArchived;
const GUID IID_ICertPropertyArchivedKeyHash              = GUIDOF!ICertPropertyArchivedKeyHash;
const GUID IID_ICertPropertyAutoEnroll                   = GUIDOF!ICertPropertyAutoEnroll;
const GUID IID_ICertPropertyBackedUp                     = GUIDOF!ICertPropertyBackedUp;
const GUID IID_ICertPropertyDescription                  = GUIDOF!ICertPropertyDescription;
const GUID IID_ICertPropertyEnrollment                   = GUIDOF!ICertPropertyEnrollment;
const GUID IID_ICertPropertyEnrollmentPolicyServer       = GUIDOF!ICertPropertyEnrollmentPolicyServer;
const GUID IID_ICertPropertyFriendlyName                 = GUIDOF!ICertPropertyFriendlyName;
const GUID IID_ICertPropertyKeyProvInfo                  = GUIDOF!ICertPropertyKeyProvInfo;
const GUID IID_ICertPropertyRenewal                      = GUIDOF!ICertPropertyRenewal;
const GUID IID_ICertPropertyRequestOriginator            = GUIDOF!ICertPropertyRequestOriginator;
const GUID IID_ICertPropertySHA1Hash                     = GUIDOF!ICertPropertySHA1Hash;
const GUID IID_ICertRequest                              = GUIDOF!ICertRequest;
const GUID IID_ICertRequest2                             = GUIDOF!ICertRequest2;
const GUID IID_ICertRequest3                             = GUIDOF!ICertRequest3;
const GUID IID_ICertServerExit                           = GUIDOF!ICertServerExit;
const GUID IID_ICertServerPolicy                         = GUIDOF!ICertServerPolicy;
const GUID IID_ICertSrvSetup                             = GUIDOF!ICertSrvSetup;
const GUID IID_ICertSrvSetupKeyInformation               = GUIDOF!ICertSrvSetupKeyInformation;
const GUID IID_ICertSrvSetupKeyInformationCollection     = GUIDOF!ICertSrvSetupKeyInformationCollection;
const GUID IID_ICertView                                 = GUIDOF!ICertView;
const GUID IID_ICertView2                                = GUIDOF!ICertView2;
const GUID IID_ICertificateAttestationChallenge          = GUIDOF!ICertificateAttestationChallenge;
const GUID IID_ICertificateAttestationChallenge2         = GUIDOF!ICertificateAttestationChallenge2;
const GUID IID_ICertificateEnrollmentPolicyServerSetup   = GUIDOF!ICertificateEnrollmentPolicyServerSetup;
const GUID IID_ICertificateEnrollmentServerSetup         = GUIDOF!ICertificateEnrollmentServerSetup;
const GUID IID_ICertificatePolicies                      = GUIDOF!ICertificatePolicies;
const GUID IID_ICertificatePolicy                        = GUIDOF!ICertificatePolicy;
const GUID IID_ICertificationAuthorities                 = GUIDOF!ICertificationAuthorities;
const GUID IID_ICertificationAuthority                   = GUIDOF!ICertificationAuthority;
const GUID IID_IConnectedIdentityProvider                = GUIDOF!IConnectedIdentityProvider;
const GUID IID_ICryptAttribute                           = GUIDOF!ICryptAttribute;
const GUID IID_ICryptAttributes                          = GUIDOF!ICryptAttributes;
const GUID IID_ICspAlgorithm                             = GUIDOF!ICspAlgorithm;
const GUID IID_ICspAlgorithms                            = GUIDOF!ICspAlgorithms;
const GUID IID_ICspInformation                           = GUIDOF!ICspInformation;
const GUID IID_ICspInformations                          = GUIDOF!ICspInformations;
const GUID IID_ICspStatus                                = GUIDOF!ICspStatus;
const GUID IID_ICspStatuses                              = GUIDOF!ICspStatuses;
const GUID IID_IEffectivePermission                      = GUIDOF!IEffectivePermission;
const GUID IID_IEffectivePermission2                     = GUIDOF!IEffectivePermission2;
const GUID IID_IEnroll                                   = GUIDOF!IEnroll;
const GUID IID_IEnroll2                                  = GUIDOF!IEnroll2;
const GUID IID_IEnroll4                                  = GUIDOF!IEnroll4;
const GUID IID_IEnumCERTVIEWATTRIBUTE                    = GUIDOF!IEnumCERTVIEWATTRIBUTE;
const GUID IID_IEnumCERTVIEWCOLUMN                       = GUIDOF!IEnumCERTVIEWCOLUMN;
const GUID IID_IEnumCERTVIEWEXTENSION                    = GUIDOF!IEnumCERTVIEWEXTENSION;
const GUID IID_IEnumCERTVIEWROW                          = GUIDOF!IEnumCERTVIEWROW;
const GUID IID_IIdentityAdvise                           = GUIDOF!IIdentityAdvise;
const GUID IID_IIdentityAuthentication                   = GUIDOF!IIdentityAuthentication;
const GUID IID_IIdentityProvider                         = GUIDOF!IIdentityProvider;
const GUID IID_IIdentityStore                            = GUIDOF!IIdentityStore;
const GUID IID_IIdentityStoreEx                          = GUIDOF!IIdentityStoreEx;
const GUID IID_IMSCEPSetup                               = GUIDOF!IMSCEPSetup;
const GUID IID_INDESPolicy                               = GUIDOF!INDESPolicy;
const GUID IID_IOCSPAdmin                                = GUIDOF!IOCSPAdmin;
const GUID IID_IOCSPCAConfiguration                      = GUIDOF!IOCSPCAConfiguration;
const GUID IID_IOCSPCAConfigurationCollection            = GUIDOF!IOCSPCAConfigurationCollection;
const GUID IID_IOCSPProperty                             = GUIDOF!IOCSPProperty;
const GUID IID_IOCSPPropertyCollection                   = GUIDOF!IOCSPPropertyCollection;
const GUID IID_IObjectId                                 = GUIDOF!IObjectId;
const GUID IID_IObjectIds                                = GUIDOF!IObjectIds;
const GUID IID_IPolicyQualifier                          = GUIDOF!IPolicyQualifier;
const GUID IID_IPolicyQualifiers                         = GUIDOF!IPolicyQualifiers;
const GUID IID_ISceSvcAttachmentData                     = GUIDOF!ISceSvcAttachmentData;
const GUID IID_ISceSvcAttachmentPersistInfo              = GUIDOF!ISceSvcAttachmentPersistInfo;
const GUID IID_ISecurityInformation                      = GUIDOF!ISecurityInformation;
const GUID IID_ISecurityInformation2                     = GUIDOF!ISecurityInformation2;
const GUID IID_ISecurityInformation3                     = GUIDOF!ISecurityInformation3;
const GUID IID_ISecurityInformation4                     = GUIDOF!ISecurityInformation4;
const GUID IID_ISecurityObjectTypeInfo                   = GUIDOF!ISecurityObjectTypeInfo;
const GUID IID_ISignerCertificate                        = GUIDOF!ISignerCertificate;
const GUID IID_ISignerCertificates                       = GUIDOF!ISignerCertificates;
const GUID IID_ISmimeCapabilities                        = GUIDOF!ISmimeCapabilities;
const GUID IID_ISmimeCapability                          = GUIDOF!ISmimeCapability;
const GUID IID_ITpmVirtualSmartCardManager               = GUIDOF!ITpmVirtualSmartCardManager;
const GUID IID_ITpmVirtualSmartCardManager2              = GUIDOF!ITpmVirtualSmartCardManager2;
const GUID IID_ITpmVirtualSmartCardManager3              = GUIDOF!ITpmVirtualSmartCardManager3;
const GUID IID_ITpmVirtualSmartCardManagerStatusCallback = GUIDOF!ITpmVirtualSmartCardManagerStatusCallback;
const GUID IID_IX500DistinguishedName                    = GUIDOF!IX500DistinguishedName;
const GUID IID_IX509Attribute                            = GUIDOF!IX509Attribute;
const GUID IID_IX509AttributeArchiveKey                  = GUIDOF!IX509AttributeArchiveKey;
const GUID IID_IX509AttributeArchiveKeyHash              = GUIDOF!IX509AttributeArchiveKeyHash;
const GUID IID_IX509AttributeClientId                    = GUIDOF!IX509AttributeClientId;
const GUID IID_IX509AttributeCspProvider                 = GUIDOF!IX509AttributeCspProvider;
const GUID IID_IX509AttributeExtensions                  = GUIDOF!IX509AttributeExtensions;
const GUID IID_IX509AttributeOSVersion                   = GUIDOF!IX509AttributeOSVersion;
const GUID IID_IX509AttributeRenewalCertificate          = GUIDOF!IX509AttributeRenewalCertificate;
const GUID IID_IX509Attributes                           = GUIDOF!IX509Attributes;
const GUID IID_IX509CertificateRequest                   = GUIDOF!IX509CertificateRequest;
const GUID IID_IX509CertificateRequestCertificate        = GUIDOF!IX509CertificateRequestCertificate;
const GUID IID_IX509CertificateRequestCertificate2       = GUIDOF!IX509CertificateRequestCertificate2;
const GUID IID_IX509CertificateRequestCmc                = GUIDOF!IX509CertificateRequestCmc;
const GUID IID_IX509CertificateRequestCmc2               = GUIDOF!IX509CertificateRequestCmc2;
const GUID IID_IX509CertificateRequestPkcs10             = GUIDOF!IX509CertificateRequestPkcs10;
const GUID IID_IX509CertificateRequestPkcs10V2           = GUIDOF!IX509CertificateRequestPkcs10V2;
const GUID IID_IX509CertificateRequestPkcs10V3           = GUIDOF!IX509CertificateRequestPkcs10V3;
const GUID IID_IX509CertificateRequestPkcs10V4           = GUIDOF!IX509CertificateRequestPkcs10V4;
const GUID IID_IX509CertificateRequestPkcs7              = GUIDOF!IX509CertificateRequestPkcs7;
const GUID IID_IX509CertificateRequestPkcs7V2            = GUIDOF!IX509CertificateRequestPkcs7V2;
const GUID IID_IX509CertificateRevocationList            = GUIDOF!IX509CertificateRevocationList;
const GUID IID_IX509CertificateRevocationListEntries     = GUIDOF!IX509CertificateRevocationListEntries;
const GUID IID_IX509CertificateRevocationListEntry       = GUIDOF!IX509CertificateRevocationListEntry;
const GUID IID_IX509CertificateTemplate                  = GUIDOF!IX509CertificateTemplate;
const GUID IID_IX509CertificateTemplateWritable          = GUIDOF!IX509CertificateTemplateWritable;
const GUID IID_IX509CertificateTemplates                 = GUIDOF!IX509CertificateTemplates;
const GUID IID_IX509EndorsementKey                       = GUIDOF!IX509EndorsementKey;
const GUID IID_IX509Enrollment                           = GUIDOF!IX509Enrollment;
const GUID IID_IX509Enrollment2                          = GUIDOF!IX509Enrollment2;
const GUID IID_IX509EnrollmentHelper                     = GUIDOF!IX509EnrollmentHelper;
const GUID IID_IX509EnrollmentPolicyServer               = GUIDOF!IX509EnrollmentPolicyServer;
const GUID IID_IX509EnrollmentStatus                     = GUIDOF!IX509EnrollmentStatus;
const GUID IID_IX509EnrollmentWebClassFactory            = GUIDOF!IX509EnrollmentWebClassFactory;
const GUID IID_IX509Extension                            = GUIDOF!IX509Extension;
const GUID IID_IX509ExtensionAlternativeNames            = GUIDOF!IX509ExtensionAlternativeNames;
const GUID IID_IX509ExtensionAuthorityKeyIdentifier      = GUIDOF!IX509ExtensionAuthorityKeyIdentifier;
const GUID IID_IX509ExtensionBasicConstraints            = GUIDOF!IX509ExtensionBasicConstraints;
const GUID IID_IX509ExtensionCertificatePolicies         = GUIDOF!IX509ExtensionCertificatePolicies;
const GUID IID_IX509ExtensionEnhancedKeyUsage            = GUIDOF!IX509ExtensionEnhancedKeyUsage;
const GUID IID_IX509ExtensionKeyUsage                    = GUIDOF!IX509ExtensionKeyUsage;
const GUID IID_IX509ExtensionMSApplicationPolicies       = GUIDOF!IX509ExtensionMSApplicationPolicies;
const GUID IID_IX509ExtensionSmimeCapabilities           = GUIDOF!IX509ExtensionSmimeCapabilities;
const GUID IID_IX509ExtensionSubjectKeyIdentifier        = GUIDOF!IX509ExtensionSubjectKeyIdentifier;
const GUID IID_IX509ExtensionTemplate                    = GUIDOF!IX509ExtensionTemplate;
const GUID IID_IX509ExtensionTemplateName                = GUIDOF!IX509ExtensionTemplateName;
const GUID IID_IX509Extensions                           = GUIDOF!IX509Extensions;
const GUID IID_IX509MachineEnrollmentFactory             = GUIDOF!IX509MachineEnrollmentFactory;
const GUID IID_IX509NameValuePair                        = GUIDOF!IX509NameValuePair;
const GUID IID_IX509NameValuePairs                       = GUIDOF!IX509NameValuePairs;
const GUID IID_IX509PolicyServerListManager              = GUIDOF!IX509PolicyServerListManager;
const GUID IID_IX509PolicyServerUrl                      = GUIDOF!IX509PolicyServerUrl;
const GUID IID_IX509PrivateKey                           = GUIDOF!IX509PrivateKey;
const GUID IID_IX509PrivateKey2                          = GUIDOF!IX509PrivateKey2;
const GUID IID_IX509PublicKey                            = GUIDOF!IX509PublicKey;
const GUID IID_IX509SCEPEnrollment                       = GUIDOF!IX509SCEPEnrollment;
const GUID IID_IX509SCEPEnrollment2                      = GUIDOF!IX509SCEPEnrollment2;
const GUID IID_IX509SCEPEnrollmentHelper                 = GUIDOF!IX509SCEPEnrollmentHelper;
const GUID IID_IX509SignatureInformation                 = GUIDOF!IX509SignatureInformation;
