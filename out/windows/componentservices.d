// Written in the D programming language.

module windows.componentservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : APTTYPE, EOC_ChangeType, HRESULT, IClassFactory,
                            IMoniker, IUnknown;
public import windows.systemservices : BOOL, HANDLE, PSTR, PWSTR;
public import windows.winsock : BLOB;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


enum COMAdminInUse : int
{
    COMAdminNotInUse                 = 0x00000000,
    COMAdminInUseByCatalog           = 0x00000001,
    COMAdminInUseByRegistryUnknown   = 0x00000002,
    COMAdminInUseByRegistryProxyStub = 0x00000003,
    COMAdminInUseByRegistryTypeLib   = 0x00000004,
    COMAdminInUseByRegistryClsid     = 0x00000005,
}

enum COMAdminComponentType : int
{
    COMAdmin32BitComponent = 0x00000001,
    COMAdmin64BitComponent = 0x00000002,
}

enum COMAdminApplicationInstallOptions : int
{
    COMAdminInstallNoUsers               = 0x00000000,
    COMAdminInstallUsers                 = 0x00000001,
    COMAdminInstallForceOverwriteOfFiles = 0x00000002,
}

enum COMAdminApplicationExportOptions : int
{
    COMAdminExportNoUsers               = 0x00000000,
    COMAdminExportUsers                 = 0x00000001,
    COMAdminExportApplicationProxy      = 0x00000002,
    COMAdminExportForceOverwriteOfFiles = 0x00000004,
    COMAdminExportIn10Format            = 0x00000010,
}

enum COMAdminThreadingModels : int
{
    COMAdminThreadingModelApartment    = 0x00000000,
    COMAdminThreadingModelFree         = 0x00000001,
    COMAdminThreadingModelMain         = 0x00000002,
    COMAdminThreadingModelBoth         = 0x00000003,
    COMAdminThreadingModelNeutral      = 0x00000004,
    COMAdminThreadingModelNotSpecified = 0x00000005,
}

enum COMAdminTransactionOptions : int
{
    COMAdminTransactionIgnored     = 0x00000000,
    COMAdminTransactionNone        = 0x00000001,
    COMAdminTransactionSupported   = 0x00000002,
    COMAdminTransactionRequired    = 0x00000003,
    COMAdminTransactionRequiresNew = 0x00000004,
}

///Indicates the isolation level that is to be used for transactions.
enum COMAdminTxIsolationLevelOptions : int
{
    ///Any isolation level is supported. A downstream component that has this isolation level always uses the same
    ///isolation level that its immediate upstream component uses. If the root object in a transaction has its isolation
    ///level configured to COMAdminTxIsolationLevelAny, its isolation level becomes
    ///COMAdminTxIsolationLevelSerializable.
    COMAdminTxIsolationLevelAny             = 0x00000000,
    ///A transaction can read any data, even if it is being modified by another transaction. Any type of new data can be
    ///inserted during a transaction. This is the least safe isolation level but allows the highest concurrency.
    COMAdminTxIsolationLevelReadUnCommitted = 0x00000001,
    ///A transaction cannot read data that is being modified by another transaction that has not committed. Any type of
    ///new data can be inserted during a transaction. This is the default isolation level in Microsoft SQL Server.
    COMAdminTxIsolationLevelReadCommitted   = 0x00000002,
    ///Data read by a current transaction cannot be changed by another transaction until the current transaction
    ///finishes. Any type of new data can be inserted during a transaction.
    COMAdminTxIsolationLevelRepeatableRead  = 0x00000003,
    ///Data read by a current transaction cannot be changed by another transaction until the current transaction
    ///finishes. No new data can be inserted that would affect the current transaction. This is the safest isolation
    ///level and is the default, but allows the lowest level of concurrency.
    COMAdminTxIsolationLevelSerializable    = 0x00000004,
}

enum COMAdminSynchronizationOptions : int
{
    COMAdminSynchronizationIgnored     = 0x00000000,
    COMAdminSynchronizationNone        = 0x00000001,
    COMAdminSynchronizationSupported   = 0x00000002,
    COMAdminSynchronizationRequired    = 0x00000003,
    COMAdminSynchronizationRequiresNew = 0x00000004,
}

enum COMAdminActivationOptions : int
{
    COMAdminActivationInproc = 0x00000000,
    COMAdminActivationLocal  = 0x00000001,
}

enum COMAdminAccessChecksLevelOptions : int
{
    COMAdminAccessChecksApplicationLevel          = 0x00000000,
    COMAdminAccessChecksApplicationComponentLevel = 0x00000001,
}

enum COMAdminAuthenticationLevelOptions : int
{
    COMAdminAuthenticationDefault   = 0x00000000,
    COMAdminAuthenticationNone      = 0x00000001,
    COMAdminAuthenticationConnect   = 0x00000002,
    COMAdminAuthenticationCall      = 0x00000003,
    COMAdminAuthenticationPacket    = 0x00000004,
    COMAdminAuthenticationIntegrity = 0x00000005,
    COMAdminAuthenticationPrivacy   = 0x00000006,
}

enum COMAdminImpersonationLevelOptions : int
{
    COMAdminImpersonationAnonymous   = 0x00000001,
    COMAdminImpersonationIdentify    = 0x00000002,
    COMAdminImpersonationImpersonate = 0x00000003,
    COMAdminImpersonationDelegate    = 0x00000004,
}

enum COMAdminAuthenticationCapabilitiesOptions : int
{
    COMAdminAuthenticationCapabilitiesNone            = 0x00000000,
    COMAdminAuthenticationCapabilitiesSecureReference = 0x00000002,
    COMAdminAuthenticationCapabilitiesStaticCloaking  = 0x00000020,
    COMAdminAuthenticationCapabilitiesDynamicCloaking = 0x00000040,
}

alias COMAdminOS = int;
enum : int
{
    COMAdminOSNotInitialized                  = 0x00000000,
    COMAdminOSWindows3_1                      = 0x00000001,
    COMAdminOSWindows9x                       = 0x00000002,
    COMAdminOSWindows2000                     = 0x00000003,
    COMAdminOSWindows2000AdvancedServer       = 0x00000004,
    COMAdminOSWindows2000Unknown              = 0x00000005,
    COMAdminOSUnknown                         = 0x00000006,
    COMAdminOSWindowsXPPersonal               = 0x0000000b,
    COMAdminOSWindowsXPProfessional           = 0x0000000c,
    COMAdminOSWindowsNETStandardServer        = 0x0000000d,
    COMAdminOSWindowsNETEnterpriseServer      = 0x0000000e,
    COMAdminOSWindowsNETDatacenterServer      = 0x0000000f,
    COMAdminOSWindowsNETWebServer             = 0x00000010,
    COMAdminOSWindowsLonghornPersonal         = 0x00000011,
    COMAdminOSWindowsLonghornProfessional     = 0x00000012,
    COMAdminOSWindowsLonghornStandardServer   = 0x00000013,
    COMAdminOSWindowsLonghornEnterpriseServer = 0x00000014,
    COMAdminOSWindowsLonghornDatacenterServer = 0x00000015,
    COMAdminOSWindowsLonghornWebServer        = 0x00000016,
    COMAdminOSWindows7Personal                = 0x00000017,
    COMAdminOSWindows7Professional            = 0x00000018,
    COMAdminOSWindows7StandardServer          = 0x00000019,
    COMAdminOSWindows7EnterpriseServer        = 0x0000001a,
    COMAdminOSWindows7DatacenterServer        = 0x0000001b,
    COMAdminOSWindows7WebServer               = 0x0000001c,
    COMAdminOSWindows8Personal                = 0x0000001d,
    COMAdminOSWindows8Professional            = 0x0000001e,
    COMAdminOSWindows8StandardServer          = 0x0000001f,
    COMAdminOSWindows8EnterpriseServer        = 0x00000020,
    COMAdminOSWindows8DatacenterServer        = 0x00000021,
    COMAdminOSWindows8WebServer               = 0x00000022,
    COMAdminOSWindowsBluePersonal             = 0x00000023,
    COMAdminOSWindowsBlueProfessional         = 0x00000024,
    COMAdminOSWindowsBlueStandardServer       = 0x00000025,
    COMAdminOSWindowsBlueEnterpriseServer     = 0x00000026,
    COMAdminOSWindowsBlueDatacenterServer     = 0x00000027,
    COMAdminOSWindowsBlueWebServer            = 0x00000028,
}

enum COMAdminServiceOptions : int
{
    COMAdminServiceLoadBalanceRouter = 0x00000001,
}

enum COMAdminServiceStatusOptions : int
{
    COMAdminServiceStopped         = 0x00000000,
    COMAdminServiceStartPending    = 0x00000001,
    COMAdminServiceStopPending     = 0x00000002,
    COMAdminServiceRunning         = 0x00000003,
    COMAdminServiceContinuePending = 0x00000004,
    COMAdminServicePausePending    = 0x00000005,
    COMAdminServicePaused          = 0x00000006,
    COMAdminServiceUnknownState    = 0x00000007,
}

enum COMAdminQCMessageAuthenticateOptions : int
{
    COMAdminQCMessageAuthenticateSecureApps = 0x00000000,
    COMAdminQCMessageAuthenticateOff        = 0x00000001,
    COMAdminQCMessageAuthenticateOn         = 0x00000002,
}

enum COMAdminFileFlags : int
{
    COMAdminFileFlagLoadable          = 0x00000001,
    COMAdminFileFlagCOM               = 0x00000002,
    COMAdminFileFlagContainsPS        = 0x00000004,
    COMAdminFileFlagContainsComp      = 0x00000008,
    COMAdminFileFlagContainsTLB       = 0x00000010,
    COMAdminFileFlagSelfReg           = 0x00000020,
    COMAdminFileFlagSelfUnReg         = 0x00000040,
    COMAdminFileFlagUnloadableDLL     = 0x00000080,
    COMAdminFileFlagDoesNotExist      = 0x00000100,
    COMAdminFileFlagAlreadyInstalled  = 0x00000200,
    COMAdminFileFlagBadTLB            = 0x00000400,
    COMAdminFileFlagGetClassObjFailed = 0x00000800,
    COMAdminFileFlagClassNotAvailable = 0x00001000,
    COMAdminFileFlagRegistrar         = 0x00002000,
    COMAdminFileFlagNoRegistrar       = 0x00004000,
    COMAdminFileFlagDLLRegsvrFailed   = 0x00008000,
    COMAdminFileFlagRegTLBFailed      = 0x00010000,
    COMAdminFileFlagRegistrarFailed   = 0x00020000,
    COMAdminFileFlagError             = 0x00040000,
}

enum COMAdminComponentFlags : int
{
    COMAdminCompFlagTypeInfoFound          = 0x00000001,
    COMAdminCompFlagCOMPlusPropertiesFound = 0x00000002,
    COMAdminCompFlagProxyFound             = 0x00000004,
    COMAdminCompFlagInterfacesFound        = 0x00000008,
    COMAdminCompFlagAlreadyInstalled       = 0x00000010,
    COMAdminCompFlagNotInApplication       = 0x00000020,
}

enum COMAdminErrorCodes : int
{
    COMAdminErrObjectErrors                  = 0x80110401,
    COMAdminErrObjectInvalid                 = 0x80110402,
    COMAdminErrKeyMissing                    = 0x80110403,
    COMAdminErrAlreadyInstalled              = 0x80110404,
    COMAdminErrAppFileWriteFail              = 0x80110407,
    COMAdminErrAppFileReadFail               = 0x80110408,
    COMAdminErrAppFileVersion                = 0x80110409,
    COMAdminErrBadPath                       = 0x8011040a,
    COMAdminErrApplicationExists             = 0x8011040b,
    COMAdminErrRoleExists                    = 0x8011040c,
    COMAdminErrCantCopyFile                  = 0x8011040d,
    COMAdminErrNoUser                        = 0x8011040f,
    COMAdminErrInvalidUserids                = 0x80110410,
    COMAdminErrNoRegistryCLSID               = 0x80110411,
    COMAdminErrBadRegistryProgID             = 0x80110412,
    COMAdminErrAuthenticationLevel           = 0x80110413,
    COMAdminErrUserPasswdNotValid            = 0x80110414,
    COMAdminErrCLSIDOrIIDMismatch            = 0x80110418,
    COMAdminErrRemoteInterface               = 0x80110419,
    COMAdminErrDllRegisterServer             = 0x8011041a,
    COMAdminErrNoServerShare                 = 0x8011041b,
    COMAdminErrDllLoadFailed                 = 0x8011041d,
    COMAdminErrBadRegistryLibID              = 0x8011041e,
    COMAdminErrAppDirNotFound                = 0x8011041f,
    COMAdminErrRegistrarFailed               = 0x80110423,
    COMAdminErrCompFileDoesNotExist          = 0x80110424,
    COMAdminErrCompFileLoadDLLFail           = 0x80110425,
    COMAdminErrCompFileGetClassObj           = 0x80110426,
    COMAdminErrCompFileClassNotAvail         = 0x80110427,
    COMAdminErrCompFileBadTLB                = 0x80110428,
    COMAdminErrCompFileNotInstallable        = 0x80110429,
    COMAdminErrNotChangeable                 = 0x8011042a,
    COMAdminErrNotDeletable                  = 0x8011042b,
    COMAdminErrSession                       = 0x8011042c,
    COMAdminErrCompMoveLocked                = 0x8011042d,
    COMAdminErrCompMoveBadDest               = 0x8011042e,
    COMAdminErrRegisterTLB                   = 0x80110430,
    COMAdminErrSystemApp                     = 0x80110433,
    COMAdminErrCompFileNoRegistrar           = 0x80110434,
    COMAdminErrCoReqCompInstalled            = 0x80110435,
    COMAdminErrServiceNotInstalled           = 0x80110436,
    COMAdminErrPropertySaveFailed            = 0x80110437,
    COMAdminErrObjectExists                  = 0x80110438,
    COMAdminErrComponentExists               = 0x80110439,
    COMAdminErrRegFileCorrupt                = 0x8011043b,
    COMAdminErrPropertyOverflow              = 0x8011043c,
    COMAdminErrNotInRegistry                 = 0x8011043e,
    COMAdminErrObjectNotPoolable             = 0x8011043f,
    COMAdminErrApplidMatchesClsid            = 0x80110446,
    COMAdminErrRoleDoesNotExist              = 0x80110447,
    COMAdminErrStartAppNeedsComponents       = 0x80110448,
    COMAdminErrRequiresDifferentPlatform     = 0x80110449,
    COMAdminErrQueuingServiceNotAvailable    = 0x80110602,
    COMAdminErrObjectParentMissing           = 0x80110808,
    COMAdminErrObjectDoesNotExist            = 0x80110809,
    COMAdminErrCanNotExportAppProxy          = 0x8011044a,
    COMAdminErrCanNotStartApp                = 0x8011044b,
    COMAdminErrCanNotExportSystemApp         = 0x8011044c,
    COMAdminErrCanNotSubscribeToComponent    = 0x8011044d,
    COMAdminErrAppNotRunning                 = 0x8011080a,
    COMAdminErrEventClassCannotBeSubscriber  = 0x8011044e,
    COMAdminErrLibAppProxyIncompatible       = 0x8011044f,
    COMAdminErrBasePartitionOnly             = 0x80110450,
    COMAdminErrDuplicatePartitionName        = 0x80110457,
    COMAdminErrPartitionInUse                = 0x80110459,
    COMAdminErrImportedComponentsNotAllowed  = 0x8011045b,
    COMAdminErrRegdbNotInitialized           = 0x80110472,
    COMAdminErrRegdbNotOpen                  = 0x80110473,
    COMAdminErrRegdbSystemErr                = 0x80110474,
    COMAdminErrRegdbAlreadyRunning           = 0x80110475,
    COMAdminErrMigVersionNotSupported        = 0x80110480,
    COMAdminErrMigSchemaNotFound             = 0x80110481,
    COMAdminErrCatBitnessMismatch            = 0x80110482,
    COMAdminErrCatUnacceptableBitness        = 0x80110483,
    COMAdminErrCatWrongAppBitnessBitness     = 0x80110484,
    COMAdminErrCatPauseResumeNotSupported    = 0x80110485,
    COMAdminErrCatServerFault                = 0x80110486,
    COMAdminErrCantRecycleLibraryApps        = 0x8011080f,
    COMAdminErrCantRecycleServiceApps        = 0x80110811,
    COMAdminErrProcessAlreadyRecycled        = 0x80110812,
    COMAdminErrPausedProcessMayNotBeRecycled = 0x80110813,
    COMAdminErrInvalidPartition              = 0x8011080b,
    COMAdminErrPartitionMsiOnly              = 0x80110819,
    COMAdminErrStartAppDisabled              = 0x80110451,
    COMAdminErrCompMoveSource                = 0x8011081c,
    COMAdminErrCompMoveDest                  = 0x8011081d,
    COMAdminErrCompMovePrivate               = 0x8011081e,
    COMAdminErrCannotCopyEventClass          = 0x80110820,
}

alias TX_MISC_CONSTANTS = int;
enum : int
{
    MAX_TRAN_DESC = 0x00000028,
}

alias ISOLATIONLEVEL = int;
enum : int
{
    ISOLATIONLEVEL_UNSPECIFIED     = 0xffffffff,
    ISOLATIONLEVEL_CHAOS           = 0x00000010,
    ISOLATIONLEVEL_READUNCOMMITTED = 0x00000100,
    ISOLATIONLEVEL_BROWSE          = 0x00000100,
    ISOLATIONLEVEL_CURSORSTABILITY = 0x00001000,
    ISOLATIONLEVEL_READCOMMITTED   = 0x00001000,
    ISOLATIONLEVEL_REPEATABLEREAD  = 0x00010000,
    ISOLATIONLEVEL_SERIALIZABLE    = 0x00100000,
    ISOLATIONLEVEL_ISOLATED        = 0x00100000,
}

alias ISOFLAG = int;
enum : int
{
    ISOFLAG_RETAIN_COMMIT_DC = 0x00000001,
    ISOFLAG_RETAIN_COMMIT    = 0x00000002,
    ISOFLAG_RETAIN_COMMIT_NO = 0x00000003,
    ISOFLAG_RETAIN_ABORT_DC  = 0x00000004,
    ISOFLAG_RETAIN_ABORT     = 0x00000008,
    ISOFLAG_RETAIN_ABORT_NO  = 0x0000000c,
    ISOFLAG_RETAIN_DONTCARE  = 0x00000005,
    ISOFLAG_RETAIN_BOTH      = 0x0000000a,
    ISOFLAG_RETAIN_NONE      = 0x0000000f,
    ISOFLAG_OPTIMISTIC       = 0x00000010,
    ISOFLAG_READONLY         = 0x00000020,
}

alias XACTTC = int;
enum : int
{
    XACTTC_NONE           = 0x00000000,
    XACTTC_SYNC_PHASEONE  = 0x00000001,
    XACTTC_SYNC_PHASETWO  = 0x00000002,
    XACTTC_SYNC           = 0x00000002,
    XACTTC_ASYNC_PHASEONE = 0x00000004,
    XACTTC_ASYNC          = 0x00000004,
}

alias XACTRM = int;
enum : int
{
    XACTRM_OPTIMISTICLASTWINS = 0x00000001,
    XACTRM_NOREADONLYPREPARES = 0x00000002,
}

alias XACTCONST = int;
enum : int
{
    XACTCONST_TIMEOUTINFINITE = 0x00000000,
}

alias XACTHEURISTIC = int;
enum : int
{
    XACTHEURISTIC_ABORT  = 0x00000001,
    XACTHEURISTIC_COMMIT = 0x00000002,
    XACTHEURISTIC_DAMAGE = 0x00000003,
    XACTHEURISTIC_DANGER = 0x00000004,
}

alias XACTSTAT = int;
enum : int
{
    XACTSTAT_NONE             = 0x00000000,
    XACTSTAT_OPENNORMAL       = 0x00000001,
    XACTSTAT_OPENREFUSED      = 0x00000002,
    XACTSTAT_PREPARING        = 0x00000004,
    XACTSTAT_PREPARED         = 0x00000008,
    XACTSTAT_PREPARERETAINING = 0x00000010,
    XACTSTAT_PREPARERETAINED  = 0x00000020,
    XACTSTAT_COMMITTING       = 0x00000040,
    XACTSTAT_COMMITRETAINING  = 0x00000080,
    XACTSTAT_ABORTING         = 0x00000100,
    XACTSTAT_ABORTED          = 0x00000200,
    XACTSTAT_COMMITTED        = 0x00000400,
    XACTSTAT_HEURISTIC_ABORT  = 0x00000800,
    XACTSTAT_HEURISTIC_COMMIT = 0x00001000,
    XACTSTAT_HEURISTIC_DAMAGE = 0x00002000,
    XACTSTAT_HEURISTIC_DANGER = 0x00004000,
    XACTSTAT_FORCED_ABORT     = 0x00008000,
    XACTSTAT_FORCED_COMMIT    = 0x00010000,
    XACTSTAT_INDOUBT          = 0x00020000,
    XACTSTAT_CLOSED           = 0x00040000,
    XACTSTAT_OPEN             = 0x00000003,
    XACTSTAT_NOTPREPARED      = 0x0007ffc3,
    XACTSTAT_ALL              = 0x0007ffff,
}

alias AUTHENTICATION_LEVEL = int;
enum : int
{
    NO_AUTHENTICATION_REQUIRED       = 0x00000000,
    INCOMING_AUTHENTICATION_REQUIRED = 0x00000001,
    MUTUAL_AUTHENTICATION_REQUIRED   = 0x00000002,
}

alias XACT_DTC_CONSTANTS = int;
enum : int
{
    XACT_E_CONNECTION_REQUEST_DENIED = 0x8004d100,
    XACT_E_TOOMANY_ENLISTMENTS       = 0x8004d101,
    XACT_E_DUPLICATE_GUID            = 0x8004d102,
    XACT_E_NOTSINGLEPHASE            = 0x8004d103,
    XACT_E_RECOVERYALREADYDONE       = 0x8004d104,
    XACT_E_PROTOCOL                  = 0x8004d105,
    XACT_E_RM_FAILURE                = 0x8004d106,
    XACT_E_RECOVERY_FAILED           = 0x8004d107,
    XACT_E_LU_NOT_FOUND              = 0x8004d108,
    XACT_E_DUPLICATE_LU              = 0x8004d109,
    XACT_E_LU_NOT_CONNECTED          = 0x8004d10a,
    XACT_E_DUPLICATE_TRANSID         = 0x8004d10b,
    XACT_E_LU_BUSY                   = 0x8004d10c,
    XACT_E_LU_NO_RECOVERY_PROCESS    = 0x8004d10d,
    XACT_E_LU_DOWN                   = 0x8004d10e,
    XACT_E_LU_RECOVERING             = 0x8004d10f,
    XACT_E_LU_RECOVERY_MISMATCH      = 0x8004d110,
    XACT_E_RM_UNAVAILABLE            = 0x8004d111,
    XACT_E_LRMRECOVERYALREADYDONE    = 0x8004d112,
    XACT_E_NOLASTRESOURCEINTERFACE   = 0x8004d113,
    XACT_S_NONOTIFY                  = 0x0004d100,
    XACT_OK_NONOTIFY                 = 0x0004d101,
    dwUSER_MS_SQLSERVER              = 0x0000ffff,
}

alias _DtcLu_LocalRecovery_Work = int;
enum : int
{
    DTCINITIATEDRECOVERYWORK_CHECKLUSTATUS = 0x00000001,
    DTCINITIATEDRECOVERYWORK_TRANS         = 0x00000002,
    DTCINITIATEDRECOVERYWORK_TMDOWN        = 0x00000003,
}

alias _DtcLu_Xln = int;
enum : int
{
    DTCLUXLN_COLD = 0x00000001,
    DTCLUXLN_WARM = 0x00000002,
}

alias _DtcLu_Xln_Confirmation = int;
enum : int
{
    DTCLUXLNCONFIRMATION_CONFIRM          = 0x00000001,
    DTCLUXLNCONFIRMATION_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNCONFIRMATION_COLDWARMMISMATCH = 0x00000003,
    DTCLUXLNCONFIRMATION_OBSOLETE         = 0x00000004,
}

alias _DtcLu_Xln_Response = int;
enum : int
{
    DTCLUXLNRESPONSE_OK_SENDOURXLNBACK   = 0x00000001,
    DTCLUXLNRESPONSE_OK_SENDCONFIRMATION = 0x00000002,
    DTCLUXLNRESPONSE_LOGNAMEMISMATCH     = 0x00000003,
    DTCLUXLNRESPONSE_COLDWARMMISMATCH    = 0x00000004,
}

alias _DtcLu_Xln_Error = int;
enum : int
{
    DTCLUXLNERROR_PROTOCOL         = 0x00000001,
    DTCLUXLNERROR_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNERROR_COLDWARMMISMATCH = 0x00000003,
}

alias _DtcLu_CompareState = int;
enum : int
{
    DTCLUCOMPARESTATE_COMMITTED          = 0x00000001,
    DTCLUCOMPARESTATE_HEURISTICCOMMITTED = 0x00000002,
    DTCLUCOMPARESTATE_HEURISTICMIXED     = 0x00000003,
    DTCLUCOMPARESTATE_HEURISTICRESET     = 0x00000004,
    DTCLUCOMPARESTATE_INDOUBT            = 0x00000005,
    DTCLUCOMPARESTATE_RESET              = 0x00000006,
}

alias _DtcLu_CompareStates_Confirmation = int;
enum : int
{
    DTCLUCOMPARESTATESCONFIRMATION_CONFIRM  = 0x00000001,
    DTCLUCOMPARESTATESCONFIRMATION_PROTOCOL = 0x00000002,
}

alias _DtcLu_CompareStates_Error = int;
enum : int
{
    DTCLUCOMPARESTATESERROR_PROTOCOL = 0x00000001,
}

alias _DtcLu_CompareStates_Response = int;
enum : int
{
    DTCLUCOMPARESTATESRESPONSE_OK       = 0x00000001,
    DTCLUCOMPARESTATESRESPONSE_PROTOCOL = 0x00000002,
}

///Indicates the type of objects in a tracking information collection.
alias TRACKING_COLL_TYPE = int;
enum : int
{
    ///The objects in the referenced tracking information collections are processes.
    TRKCOLL_PROCESSES    = 0x00000000,
    ///The objects in the referenced tracking information collections are applications.
    TRKCOLL_APPLICATIONS = 0x00000001,
    ///The objects in the referenced tracking information collections are components.
    TRKCOLL_COMPONENTS   = 0x00000002,
}

alias DUMPTYPE = int;
enum : int
{
    DUMPTYPE_FULL = 0x00000000,
    DUMPTYPE_MINI = 0x00000001,
    DUMPTYPE_NONE = 0x00000002,
}

///Represents types of applications tracked by the tracker server.
alias COMPLUS_APPTYPE = int;
enum : int
{
    ///This value is not used.
    APPTYPE_UNKNOWN = 0xffffffff,
    ///COM+ server application.
    APPTYPE_SERVER  = 0x00000001,
    ///COM+ library application.
    APPTYPE_LIBRARY = 0x00000000,
    ///COM+ services without components.
    APPTYPE_SWC     = 0x00000002,
}

///Controls what data is returned from calls to the IGetAppTrackerData interface.
enum GetAppTrackerDataFlags : int
{
    ///Include the name of the process's executable image in the ApplicationProcessSummary structure. If set, it is the
    ///caller's responsibility to free the memory allocated for this string.
    GATD_INCLUDE_PROCESS_EXE_NAME = 0x00000001,
    ///Include COM+ library applications in the tracking data. By default, these are excluded.
    GATD_INCLUDE_LIBRARY_APPS     = 0x00000002,
    ///Include Services Without Components contexts in the tracking data. By default, these are excluded.
    GATD_INCLUDE_SWC              = 0x00000004,
    ///Include the class name in the ComponentSummary structure. If set, it is the caller's responsibility to free the
    ///memory allocated for this string.
    GATD_INCLUDE_CLASS_NAME       = 0x00000008,
    ///Include the application name in the ApplicationSummary and ComponentSummary structures. If set, it is the
    ///caller's responsibility to free the memory allocated for this string.
    GATD_INCLUDE_APPLICATION_NAME = 0x00000010,
}

///Indicates the readiness of an object to commit or abort the current transaction.
enum TransactionVote : int
{
    ///An existing object votes to commit the current transaction.
    TxCommit = 0x00000000,
    ///An existing object votes to abort the current transaction.
    TxAbort  = 0x00000001,
}

///Represents the current transaction state of the transaction.
enum CrmTransactionState : int
{
    ///The transaction is active.
    TxState_Active    = 0x00000000,
    ///The transaction is committed.
    TxState_Committed = 0x00000001,
    ///The transaction was aborted.
    TxState_Aborted   = 0x00000002,
    ///The transaction is in doubt.
    TxState_Indoubt   = 0x00000003,
}

///Indicates whether to create a new context based on the current context or to create a new context based solely upon
///the information in CServiceConfig.
alias CSC_InheritanceConfig = int;
enum : int
{
    ///The new context is created from the existing context.
    CSC_Inherit = 0x00000000,
    ///The new context is created from the default context.
    CSC_Ignore  = 0x00000001,
}

///Indicates the thread pool in which the work runs that is submitted through the activity returned from
///CoCreateActivity.
alias CSC_ThreadPool = int;
enum : int
{
    ///No thread pool is used. If this value is used to configure a CServiceConfig object that is passed to
    ///CoCreateActivity, an error (CO_E_THREADPOOL_CONFIG) is returned. This is the default thread pool setting for
    ///<b>CServiceConfig</b> when CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_ThreadPoolNone    = 0x00000000,
    ///The same type of thread pool apartment as the caller's thread apartment is used. If the caller's thread apartment
    ///is the neutral apartment, a single-threaded apartment is used. This is the default thread pool setting for
    ///CServiceConfig when CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_ThreadPoolInherit = 0x00000001,
    ///A single-threaded apartment (STA) is used.
    CSC_STAThreadPool     = 0x00000002,
    ///A multithreaded apartment (MTA) is used.
    CSC_MTAThreadPool     = 0x00000003,
}

///Indicates whether all of the work that is submitted via the activity returned from CoCreateActivity should be bound
///to only one single-threaded apartment (STA). This enumeration has no impact on the multithreaded apartment (MTA).
alias CSC_Binding = int;
enum : int
{
    ///The work submitted through the activity is not bound to a single STA.
    CSC_NoBinding        = 0x00000000,
    ///The work submitted through the activity is bound to a single STA.
    CSC_BindToPoolThread = 0x00000001,
}

///Indicates how transactions are configured for CServiceConfig.
alias CSC_TransactionConfig = int;
enum : int
{
    ///Transactions are never used within the enclosed context. This is the default transaction setting for
    ///CServiceConfig when CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoTransaction                = 0x00000000,
    ///Transactions are used only if the enclosed context is using a transaction; a new transaction is never created.
    ///This is the default transaction setting for CServiceConfig when CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_IfContainerIsTransactional   = 0x00000001,
    ///Transactions are always used. The existing transaction is used, or if the enclosed context does not already use
    ///transactions, a new transaction is created.
    CSC_CreateTransactionIfNecessary = 0x00000002,
    ///A new transaction is always created.
    CSC_NewTransaction               = 0x00000003,
}

///Indicates how synchronization is configured for CServiceConfig.
alias CSC_SynchronizationConfig = int;
enum : int
{
    ///The code is forced to run unsynchronized. This is the default synchronization setting for CServiceConfig when
    ///CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoSynchronization             = 0x00000000,
    ///The code runs in the containing synchronization domain if one exists. This is the default synchronization setting
    ///for CServiceConfig when CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_IfContainerIsSynchronized     = 0x00000001,
    ///Synchronization is always used. The existing synchronization domain is used, or if the enclosed context does not
    ///already use synchronization, a new synchronization domain is created.
    CSC_NewSynchronizationIfNecessary = 0x00000002,
    ///A new synchronization domain is always created.
    CSC_NewSynchronization            = 0x00000003,
}

///Indicates whether the tracker property is added to the context in which the enclosed code runs.
alias CSC_TrackerConfig = int;
enum : int
{
    ///The tracker property is not added to the context in which the enclosed code runs.
    CSC_DontUseTracker = 0x00000000,
    ///The tracker property is added to the context in which the enclosed code runs.
    CSC_UseTracker     = 0x00000001,
}

///Indicates the COM+ partition on which the enclosed context runs.
alias CSC_PartitionConfig = int;
enum : int
{
    ///The enclosed context runs on the Base Application Partition. This is the default setting for CServiceConfig when
    ///CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoPartition      = 0x00000000,
    ///The enclosed context runs in the current containing COM+ partition. This is the default setting for
    ///CServiceConfig when CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_InheritPartition = 0x00000001,
    ///The enclosed context runs in a COM+ partition that is different from the current containing partition.
    CSC_NewPartition     = 0x00000002,
}

///Indicates whether the current IIS intrinsics are propagated into the new context.
alias CSC_IISIntrinsicsConfig = int;
enum : int
{
    ///The current IIS intrinsics do not propagate to the new context. This is the default setting for CServiceConfig
    ///when CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoIISIntrinsics      = 0x00000000,
    ///The current IIS intrinsics propagate to the new context. This is the default setting for CServiceConfig when
    ///CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_InheritIISIntrinsics = 0x00000001,
}

///Indicates whether the current COM Transaction Integrator (COMTI) intrinsics are propagated into the new context.
///Values from this enumeration are passed to IServiceComTIIntrinsicsConfig::ComTIIntrinsicsConfig. The COMTI eases the
///task of wrapping mainframe transactions and business logic as COM components.
alias CSC_COMTIIntrinsicsConfig = int;
enum : int
{
    ///The current COMTI intrinsics do not propagate to the new context. This is the default setting for CServiceConfig
    ///when CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoCOMTIIntrinsics      = 0x00000000,
    ///The current COMTI intrinsics propagate to the new context. This is the default setting for CServiceConfig when
    ///CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_InheritCOMTIIntrinsics = 0x00000001,
}

///Indicates how side-by-side assemblies are configured for CServiceConfig.
alias CSC_SxsConfig = int;
enum : int
{
    ///Side-by-side assemblies are not used within the enclosed context. This is the default setting for CServiceConfig
    ///when CSC_InheritanceConfig is set to CSC_Ignore.
    CSC_NoSxs      = 0x00000000,
    ///The current side-by-side assembly of the enclosed context is used. This is the default setting for CServiceConfig
    ///when CSC_InheritanceConfig is set to CSC_Inherit.
    CSC_InheritSxs = 0x00000001,
    ///A new side-by-side assembly is created for the enclosed context.
    CSC_NewSxs     = 0x00000002,
}

alias __MIDL___MIDL_itf_autosvcs_0001_0150_0001 = int;
enum : int
{
    mtsErrCtxAborted                   = 0x8004e002,
    mtsErrCtxAborting                  = 0x8004e003,
    mtsErrCtxNoContext                 = 0x8004e004,
    mtsErrCtxNotRegistered             = 0x8004e005,
    mtsErrCtxSynchTimeout              = 0x8004e006,
    mtsErrCtxOldReference              = 0x8004e007,
    mtsErrCtxRoleNotFound              = 0x8004e00c,
    mtsErrCtxNoSecurity                = 0x8004e00d,
    mtsErrCtxWrongThread               = 0x8004e00e,
    mtsErrCtxTMNotAvailable            = 0x8004e00f,
    comQCErrApplicationNotQueued       = 0x80110600,
    comQCErrNoQueueableInterfaces      = 0x80110601,
    comQCErrQueuingServiceNotAvailable = 0x80110602,
    comQCErrQueueTransactMismatch      = 0x80110603,
    comqcErrRecorderMarshalled         = 0x80110604,
    comqcErrOutParam                   = 0x80110605,
    comqcErrRecorderNotTrusted         = 0x80110606,
    comqcErrPSLoad                     = 0x80110607,
    comqcErrMarshaledObjSameTxn        = 0x80110608,
    comqcErrInvalidMessage             = 0x80110650,
    comqcErrMsmqSidUnavailable         = 0x80110651,
    comqcErrWrongMsgExtension          = 0x80110652,
    comqcErrMsmqServiceUnavailable     = 0x80110653,
    comqcErrMsgNotAuthenticated        = 0x80110654,
    comqcErrMsmqConnectorUsed          = 0x80110655,
    comqcErrBadMarshaledObject         = 0x80110656,
}

alias __MIDL___MIDL_itf_autosvcs_0001_0159_0001 = int;
enum : int
{
    LockSetGet = 0x00000000,
    LockMethod = 0x00000001,
}

alias __MIDL___MIDL_itf_autosvcs_0001_0159_0002 = int;
enum : int
{
    Standard = 0x00000000,
    Process  = 0x00000001,
}

///Provides information about when a particular log record to the CRM compensator was written.
alias CRMFLAGS = int;
enum : int
{
    CRMFLAG_FORGETTARGET          = 0x00000001,
    ///The record was written during prepare.
    CRMFLAG_WRITTENDURINGPREPARE  = 0x00000002,
    ///The record was written during commit.
    CRMFLAG_WRITTENDURINGCOMMIT   = 0x00000004,
    ///The record was written during abort.
    CRMFLAG_WRITTENDURINGABORT    = 0x00000008,
    ///The record was written during recovery.
    CRMFLAG_WRITTENDURINGRECOVERY = 0x00000010,
    ///The record was written during replay.
    CRMFLAG_WRITTENDURINGREPLAY   = 0x00000020,
    CRMFLAG_REPLAYINPROGRESS      = 0x00000040,
}

///Controls which phases of transaction completion should be received by the CRM compensator and whether recovery should
///fail if in-doubt transactions remain after recovery has been attempted.
alias CRMREGFLAGS = int;
enum : int
{
    ///Receive the prepare phase.
    CRMREGFLAG_PREPAREPHASE         = 0x00000001,
    ///Receive the commit phase.
    CRMREGFLAG_COMMITPHASE          = 0x00000002,
    ///Receive the abort phase.
    CRMREGFLAG_ABORTPHASE           = 0x00000004,
    ///Receive all phases.
    CRMREGFLAG_ALLPHASES            = 0x00000007,
    ///Fail if in-doubt transactions remain after recovery.
    CRMREGFLAG_FAILIFINDOUBTSREMAIN = 0x00000010,
}

// Structs


struct BOID
{
    ubyte[16] rgb;
}

struct XACTTRANSINFO
{
    BOID uow;
    int  isoLevel;
    uint isoFlags;
    uint grfTCSupported;
    uint grfRMSupported;
    uint grfTCSupportedRetaining;
    uint grfRMSupportedRetaining;
}

struct XACTSTATS
{
    uint     cOpen;
    uint     cCommitting;
    uint     cCommitted;
    uint     cAborting;
    uint     cAborted;
    uint     cInDoubt;
    uint     cHeuristicDecision;
    FILETIME timeTransactionsUp;
}

struct XACTOPT
{
    uint      ulTimeout;
    ubyte[40] szDescription;
}

struct xid_t
{
    int       formatID;
    int       gtrid_length;
    int       bqual_length;
    byte[128] data;
}

struct xa_switch_t
{
    byte[32]  name;
    int       flags;
    int       version_;
    ptrdiff_t xa_open_entry;
    ptrdiff_t xa_close_entry;
    ptrdiff_t xa_start_entry;
    ptrdiff_t xa_end_entry;
    ptrdiff_t xa_rollback_entry;
    ptrdiff_t xa_prepare_entry;
    ptrdiff_t xa_commit_entry;
    ptrdiff_t xa_recover_entry;
    ptrdiff_t xa_forget_entry;
    ptrdiff_t xa_complete_entry;
}

struct _ProxyConfigParams
{
    ushort wcThreadsMax;
}

///Represents contextual information about an event, such as the time it was generated and which process server and COM+
///application generated it.
struct COMSVCSEVENTINFO
{
    ///The size of this structure, in bytes.
    uint  cbSize;
    ///The process ID of the server application from which the event originated.
    uint  dwPid;
    ///The coordinated universal time of the event, as seconds elapsed since midnight, January 1, 1970.
    long  lTime;
    ///The microseconds added to <b>lTime</b> for time to microsecond resolution.
    int   lMicroTime;
    ///The value of the high-resolution performance counter when the event originated.
    long  perfCount;
    ///The applications globally unique identifier (GUID) for the first component instantiated in <b>dwPid</b>. If you
    ///are subscribing to an administration interface or event and the event is not generated from a COM+ application,
    ///this member is set to zero.
    GUID  guidApp;
    ///The fully qualified name of the computer where the event originated.
    PWSTR sMachineName;
}

struct RECYCLE_INFO
{
    GUID guidCombaseProcessIdentifier;
    long ProcessStartTime;
    uint dwRecycleLifetimeLimit;
    uint dwRecycleMemoryLimit;
    uint dwRecycleExpirationTimeout;
}

struct HANG_INFO
{
    BOOL     fAppHangMonitorEnabled;
    BOOL     fTerminateOnHang;
    DUMPTYPE DumpType;
    uint     dwHangTimeout;
    uint     dwDumpCount;
    uint     dwInfoMsgCount;
}

struct CAppStatistics
{
    uint m_cTotalCalls;
    uint m_cTotalInstances;
    uint m_cTotalClasses;
    uint m_cCallsPerSecond;
}

struct CAppData
{
    uint           m_idApp;
    ushort[40]     m_szAppGuid;
    uint           m_dwAppProcessId;
    CAppStatistics m_AppStatistics;
}

struct CCLSIDData
{
    GUID m_clsid;
    uint m_cReferences;
    uint m_cBound;
    uint m_cPooled;
    uint m_cInCall;
    uint m_dwRespTime;
    uint m_cCallsCompleted;
    uint m_cCallsFailed;
}

struct CCLSIDData2
{
    GUID            m_clsid;
    GUID            m_appid;
    GUID            m_partid;
    PWSTR           m_pwszAppName;
    PWSTR           m_pwszCtxName;
    COMPLUS_APPTYPE m_eAppType;
    uint            m_cReferences;
    uint            m_cBound;
    uint            m_cPooled;
    uint            m_cInCall;
    uint            m_dwRespTime;
    uint            m_cCallsCompleted;
    uint            m_cCallsFailed;
}

///Represents summary information about a process hosting COM+ applications.
struct ApplicationProcessSummary
{
    ///The partition ID of the COM+ server application, for server application processes. For processes that are not
    ///hosting a COM+ server application, this is set to the partition ID of the first tracked component instantiated in
    ///the process.
    GUID            PartitionIdPrimaryApplication;
    ///The application ID of the COM+ server application, for server application processes. For processes that are not
    ///hosting a COM+ server application, this is set to the application ID of the first tracked component instantiated
    ///in the process.
    GUID            ApplicationIdPrimaryApplication;
    ///The application instance GUID uniquely identifying the tracked process.
    GUID            ApplicationInstanceId;
    ///The process ID of the tracked process.
    uint            ProcessId;
    ///The type of application this process is hosting. For COM+ server application processes, this is set to
    ///APPTYPE_SERVER. For processes that are not hosting a COM+ server applications, this is set to either
    ///APPTYPE_LIBRARY or APPTYPE_SWC, based on the first tracked component instantiated in the process.
    COMPLUS_APPTYPE Type;
    ///The name of the process's executable image. Space for this string is allocated by the method called and freed by
    ///the caller (for more information, see CoTaskMemFree). This member is not returned by default. To return this
    ///member, specify the GATD_INCLUDE_PROCESS_EXE_NAME flag when you call a method that returns an
    ///<b>ApplicationProcessSummary</b> structure.
    PWSTR           ProcessExeName;
    ///Indicates whether the process is a COM+ server application running as a Windows service.
    BOOL            IsService;
    ///Indicates whether the process is a COM+ server application instance that is paused.
    BOOL            IsPaused;
    ///Indicates whether the process is a COM+ server application instance that has been recycled.
    BOOL            IsRecycled;
}

///Represents statistical information about a process hosting COM+ applications.
struct ApplicationProcessStatistics
{
    ///The number of calls currently outstanding in tracked components in the process.
    uint NumCallsOutstanding;
    ///The number of distinct tracked components instantiated in the process.
    uint NumTrackedComponents;
    ///The number of component instances in the process.
    uint NumComponentInstances;
    ///A rolling average of the number of calls this process is servicing per second.
    uint AvgCallsPerSecond;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved1;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved2;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved3;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved4;
}

///Represents details about the recycling of a process hosting COM+ applications.
struct ApplicationProcessRecycleInfo
{
    ///Indicates whether the process is one that can be recycled. For example, only COM+ server applications can be
    ///recycled, and applications running as Windows services cannot be recycled.
    BOOL     IsRecyclable;
    ///Indicates whether the process is a COM+ server application instance that has been recycled.
    BOOL     IsRecycled;
    ///The time at which the process was recycled. This member is meaningful only if <b>IsRecycled</b> is <b>TRUE</b>.
    FILETIME TimeRecycled;
    ///The time at which a recycled process will be forcibly terminated if it does not shut down on its own before this
    ///time. This member is meaningful only if <b>IsRecycled</b> is <b>TRUE</b>.
    FILETIME TimeToTerminate;
    ///A code that indicates the reason a process was recycled. This is usually one of the recycle reason code constants
    ///defined in Comsvcs.h (for example, CRR_RECYCLED_FROM_UI), but may be any code supplied by an administrative
    ///application in a call to ICOMAdminCatalog2::RecycleApplicationInstances. This member is meaningful only if
    ///<b>IsRecycled</b> is <b>TRUE</b>.
    int      RecycleReasonCode;
    ///Indicates whether a paused COM+ server application instance has met the conditions for automatic recycling. If
    ///so, the application instance will be recycled when it is resumed.
    BOOL     IsPendingRecycle;
    ///Indicates whether the process is an instance of a COM+ server application that has been configured for automatic
    ///recycling based on lifetime.
    BOOL     HasAutomaticLifetimeRecycling;
    ///The time at which the process will be automatically recycled. This member is meaningful only if
    ///<b>HasAutomaticLifetimeRecycling</b> is <b>TRUE</b>.
    FILETIME TimeForAutomaticRecycling;
    ///The recycling memory limit configured for a COM+ server application in kilobytes, or 0 if the application is not
    ///configured for automatic recycling based on memory usage.
    uint     MemoryLimitInKB;
    ///The memory usage of the process in kilobytes the last time this metric was calculated by the Tracker Server. This
    ///is set to DATA_NOT_AVAILABLE (0xFFFFFFFF) if the application is not configured for automatic recycling based on
    ///memory usage, or if memory usage has not yet been checked.
    uint     MemoryUsageInKBLastCheck;
    ///The activation limit configured for a COM+ server application, or 0 if the application is not configured for
    ///automatic recycling based on activation count. This data is not currently available, and is always set to
    ///DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint     ActivationLimit;
    ///The total number of activations performed in a COM+ server application instance, or 0 if the process is not
    ///hosting a COM+ server application. This data is not currently available, and is always set to DATA_NOT_AVAILABLE
    ///(0xFFFFFFFF).
    uint     NumActivationsLastReported;
    ///The call limit configured for a COM+ server application, or zero if the application is not configured for
    ///automatic recycling based on number of calls. This data is not currently available, and is always set to
    ///DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint     CallLimit;
    ///The total number of calls serviced by a COM+ server application instance, or 0 if the process is not hosting a
    ///COM+ server application. This data is not currently available, and is always set to DATA_NOT_AVAILABLE
    ///(0xFFFFFFFF).
    uint     NumCallsLastReported;
}

///Represents a COM+ application hosted in a particular process. It can also represent a pseudo-application entry for
///all Services Without Components (SWC) contexts in the process.
struct ApplicationSummary
{
    ///The application instance GUID that uniquely identifies the process hosting the COM+ application.
    GUID            ApplicationInstanceId;
    ///The partition ID of the COM+ application.
    GUID            PartitionId;
    ///The application ID of the COM+ application. The special value {84ac4168-6fe5-4308-a2ed-03688a023c7a} is used for
    ///the SWC pseudo-application.
    GUID            ApplicationId;
    ///The type of COM+ application. For a list of values, see COMPLUS_APPTYPE.
    COMPLUS_APPTYPE Type;
    ///The name of the COM+ application, or an empty string for the SWC pseudo-application. Space for this string is
    ///allocated by the method called and freed by the caller (for more information, see CoTaskMemFree). This member is
    ///not returned by default. To return this member, specify the GATD_INCLUDE_APPLICATION_NAME flag when you call a
    ///method that returns an ApplicationProcessSummary structure.
    PWSTR           ApplicationName;
    ///The number of distinct components from this COM+ application instantiated in the hosting process.
    uint            NumTrackedComponents;
    ///The number of component instances from this COM+ application in the hosting process.
    uint            NumComponentInstances;
}

///Represents summary information about a COM+ component hosted in a particular process. It can also represent a
///Services Without Components (SWC) context.
struct ComponentSummary
{
    ///The application instance GUID that uniquely identifies the process that hosts the component.
    GUID  ApplicationInstanceId;
    ///The partition ID of the component.
    GUID  PartitionId;
    ///The application ID of the component. The special value {84ac4168-6fe5-4308-a2ed-03688a023c7a} indicates that this
    ///is an SWC context.
    GUID  ApplicationId;
    ///The CLSID of the component.
    GUID  Clsid;
    ///The name of the component. Usually, this is the component's ProgID (or the string representation of the
    ///component's CLSID if the component does not have a ProgID). For SWC contexts, this is the context name property
    ///configured for the context. Space for this string is allocated by the method called and freed by the caller (for
    ///more information, see CoTaskMemFree). This member is not returned by default. To return this member, specify the
    ///GATD_INCLUDE_CLASS_NAME flag when you call a method that returns a <b>ComponentSummary</b> structure.
    PWSTR ClassName;
    ///The name of the COM+ application, or the application name property configured for an SWC context. Space for this
    ///string is allocated by the method called and freed by the caller (for more information, see CoTaskMemFree). This
    ///member is not returned by default. To return this member, specify the GATD_INCLUDE_APPLICATION_NAME flag when you
    ///call a method that returns a <b>ComponentSummary</b> structure.
    PWSTR ApplicationName;
}

///Represents statistical information about a COM+ component hosted in a particular process.
struct ComponentStatistics
{
    ///The number of instances of the component in the hosting process.
    uint NumInstances;
    ///The number of client references bound to an instance of this component.
    uint NumBoundReferences;
    ///The number of instances of the component in the hosting process's object pool.
    uint NumPooledObjects;
    ///The number of instances of the component that are currently servicing a call.
    uint NumObjectsInCall;
    ///A rolling average of the time it takes an instance of this component to service a call.
    uint AvgResponseTimeInMs;
    ///The number of calls to instances of this component that have completed (successfully or not) in a recent time
    ///period (for comparison with <b>NumCallsFailedRecent</b>).
    uint NumCallsCompletedRecent;
    ///The number of calls to instances of this component that have failed in a recent time period (for comparison with
    ///<b>NumCallsCompletedRecent</b>).
    uint NumCallsFailedRecent;
    ///The total number of calls to instances of this component that have completed (successfully or not) throughout the
    ///lifetime of the hosting process. This data is not currently available, and this member is always set to
    ///DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint NumCallsCompletedTotal;
    ///The total number of calls to instances of this component that have failed throughout the lifetime of the hosting
    ///process. This data is not currently available, and this member is always set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint NumCallsFailedTotal;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved1;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved2;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved3;
    ///This member is reserved and set to DATA_NOT_AVAILABLE (0xFFFFFFFF).
    uint Reserved4;
}

///Represents the hang monitoring configuration for a COM+ component.
struct ComponentHangMonitorInfo
{
    ///Indicates whether the component is configured for hang monitoring.
    BOOL IsMonitored;
    ///Indicates whether the hang monitoring configuration for the component specifies the process will be terminated on
    ///a hang. This member is meaningful only if <b>IsMonitored</b> is <b>TRUE</b>.
    BOOL TerminateOnHang;
    ///The average call response time threshold configured for the component. This member is meaningful only if
    ///<b>IsMonitored</b> is <b>TRUE</b>.
    uint AvgCallThresholdInMs;
}

///Contains unstructured log records for the Compensating Resource Manager (CRM).
struct CrmLogRecordRead
{
    ///Information about when this record was written. For a list of values, see CRMFLAGS.
    uint dwCrmFlags;
    ///The sequence number of the log record. Sequence numbers are not necessarily contiguous because not all internal
    ///log records or forgotten log records are delivered to the CRM Compensator.
    uint dwSequenceNumber;
    ///The user data.
    BLOB blobUserData;
}

///Represents a system event structure, which contains the partition and application ID from which an event originated.
struct COMEVENTSYSCHANGEINFO
{
    ///The size of this structure.
    uint           cbSize;
    ///The type of change that has been made to the subscription. For a list of values, see EOC_ChangeType.
    EOC_ChangeType changeType;
    ///The EventClass ID or subscription ID from which the change impacts.
    BSTR           objectId;
    ///The EventClass partition ID or the subscriber partition ID affected.
    BSTR           partitionId;
    ///The EventClass application ID or subscriber application ID affected.
    BSTR           applicationId;
    ///This member is reserved.
    GUID[10]       reserved;
}

// Functions

///Retrieves a reference to the default context of the specified apartment.
///Params:
///    aptType = The apartment type of the default context that is being requested. This parameter can be one of the following
///              values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="APTTYPE_CURRENT"></a><a
///              id="apttype_current"></a><dl> <dt><b>APTTYPE_CURRENT</b></dt> <dt>-1</dt> </dl> </td> <td width="60%"> The
///              caller's apartment. </td> </tr> <tr> <td width="40%"><a id="APTTYPE_MTA"></a><a id="apttype_mta"></a><dl>
///              <dt><b>APTTYPE_MTA</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> The multithreaded apartment for the current
///              process. </td> </tr> <tr> <td width="40%"><a id="APTTYPE_NA"></a><a id="apttype_na"></a><dl>
///              <dt><b>APTTYPE_NA</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> The neutral apartment for the current process.
///              </td> </tr> <tr> <td width="40%"><a id="APTTYPE_MAINSTA"></a><a id="apttype_mainsta"></a><dl>
///              <dt><b>APTTYPE_MAINSTA</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The main single-threaded apartment for
///              the current process. </td> </tr> </table> The APTTYPE value APTTYPE_STA (0) is not supported. A process can
///              contain multiple single-threaded apartments, each with its own context, so <b>CoGetDefaultContext</b> could not
///              determine which STA is of interest. Therefore, this function returns E_INVALIDARG if APTTYPE_STA is specified.
///    riid = The interface identifier (IID) of the interface that is being requested on the default context. Typically, the
///           caller requests IID_IObjectContext. The default context does not support all of the normal object context
///           interfaces.
///    ppv = A reference to the interface specified by riid on the default context. If the object's component is
///          non-configured, (that is, the object's component has not been imported into a COM+ application), or if the
///          <b>CoGetDefaultContext</b> function is called from a constructor or an IUnknown method, this parameter is set to
///          a <b>NULL</b> pointer.
///Returns:
///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the parameters
///    is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_NOTINITIALIZED</b></dt> </dl> </td> <td
///    width="60%"> The caller is not in an initialized apartment. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td width="60%"> The object context does not support the interface
///    specified by <i>riid</i>. </td> </tr> </table>
///    
@DllImport("OLE32")
HRESULT CoGetDefaultContext(APTTYPE aptType, const(GUID)* riid, void** ppv);

///Creates an activity to do synchronous or asynchronous batch work that can use COM+ services without needing to create
///a COM+ component.
///Params:
///    pIUnknown = A pointer to the IUnknown interface of the object, created from the CServiceConfig class, that contains the
///                configuration information for the services to be used within the activity created by <b>CoCreateActivity</b>.
///    riid = The ID of the interface to be returned through the <i>ppObj</i> parameter. This parameter should always be
///           IID_IServiceActivity so that a pointer to IServiceActivity is returned.
///    ppObj = A pointer to the interface of an activity object. The activity object is automatically created by the call to
///            <b>CoCreateActivity</b>.
///Returns:
///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CO_E_SXS_CONFIG</b></dt> </dl> </td> <td width="60%"> The side-by-side assembly
///    configuration of the CServiceConfig object is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CO_E_THREADPOOL_CONFIG</b></dt> </dl> </td> <td width="60%"> The thread pool configuration of the
///    CServiceConfig object is invalid. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_TRACKER_CONFIG</b></dt>
///    </dl> </td> <td width="60%"> The tracker configuration of the CServiceConfig object is invalid. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>COMADMIN_E_PARTITION_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller
///    does not have access permissions for the COM+ partition. </td> </tr> </table>
///    
@DllImport("comsvcs")
HRESULT CoCreateActivity(IUnknown pIUnknown, const(GUID)* riid, void** ppObj);

///Used to enter code that can then use COM+ services.
///Params:
///    pConfigObject = A pointer to the IUnknown interface of the object, created from the CServiceConfig class, that contains the
///                    configuration information for the services to be used within the enclosed code.
///Returns:
///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>CO_E_SXS_CONFIG</b></dt> </dl> </td> <td width="60%"> The side-by-side assembly
///    configuration of the CServiceConfig object is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>CO_E_THREADPOOL_CONFIG</b></dt> </dl> </td> <td width="60%"> The thread pool configuration of the
///    CServiceConfig object is invalid. The thread apartment model cannot be reconfigured by calling
///    CoEnterServiceDomain. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_TRACKER_CONFIG</b></dt> </dl> </td> <td
///    width="60%"> The tracker configuration of the CServiceConfig object is invalid. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>COMADMIN_E_PARTITION_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The caller does not have
///    access permissions for the COM+ partition. </td> </tr> </table>
///    
@DllImport("comsvcs")
HRESULT CoEnterServiceDomain(IUnknown pConfigObject);

///Used to leave code that uses COM+ services.
///Params:
///    pUnkStatus = If you want to know the status of the transaction that is completed by the call, this must be a pointer to the
///                 IUnknown interface of an object that implements the ITransactionStatus interface. If the enclosed code did not
///                 use transactions or if you do not need to know the transaction status, this parameter should be <b>NULL</b>. This
///                 parameter is ignored if it is non-<b>NULL</b> and if no transactions were used in the service domain.
@DllImport("comsvcs")
void CoLeaveServiceDomain(IUnknown pUnkStatus);

///Determines whether the installed version of COM+ supports special features provided to manage serviced components
///(managed objects).
///Params:
///    dwExts = Indicates whether the installed version of COM+ supports managed extensions. A value of 1 indicates that it does,
///             while a value of 0 indicates that it does not.
///Returns:
///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and S_OK.
///    
@DllImport("comsvcs")
HRESULT GetManagedExtensions(uint* dwExts);

///<p class="CCE_Message">[Do not use SafeRef in COM+. This function was used by objects in MTS to obtain a reference to
///itself. With COM+, this is no longer necessary.]
///Params:
///    rid = A reference to the IID of the interface that the current object wants to pass to another object or client.
///    pUnk = A reference to the IUnknown interface on the current object.
///Returns:
///    If the function succeds, the return value is a pointer to the specified interface that can be passed outside the
///    current object's context. Otherwise, the return value is <b>NULL</b>.
///    
@DllImport("comsvcs")
void* SafeRef(const(GUID)* rid, IUnknown pUnk);

///Recycles the calling process. For similar functionality, see IMTxAS::RecycleSurrogate.
///Params:
///    lReasonCode = The reason code that explains why a process was recycled. The following codes are defined. <table> <tr>
///                  <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CRR_NO_REASON_SUPPLIED"></a><a
///                  id="crr_no_reason_supplied"></a><dl> <dt><b>CRR_NO_REASON_SUPPLIED</b></dt> <dt>0x00000000</dt> </dl> </td> <td
///                  width="60%"> The reason is not specified. </td> </tr> <tr> <td width="40%"><a id="CRR_LIFETIME_LIMIT"></a><a
///                  id="crr_lifetime_limit"></a><dl> <dt><b>CRR_LIFETIME_LIMIT</b></dt> <dt>xFFFFFFFF</dt> </dl> </td> <td
///                  width="60%"> The specified number of minutes that an application runs before recycling was reached. </td> </tr>
///                  <tr> <td width="40%"><a id="CRR_ACTIVATION_LIMIT"></a><a id="crr_activation_limit"></a><dl>
///                  <dt><b>CRR_ACTIVATION_LIMIT</b></dt> <dt>0xFFFFFFFE</dt> </dl> </td> <td width="60%"> The specified number of
///                  activations was reached. </td> </tr> <tr> <td width="40%"><a id="CRR_CALL_LIMIT"></a><a
///                  id="crr_call_limit"></a><dl> <dt><b>CRR_CALL_LIMIT</b></dt> <dt>0xFFFFFFFD</dt> </dl> </td> <td width="60%"> The
///                  specified number of calls to configured objects in the application was reached. </td> </tr> <tr> <td
///                  width="40%"><a id="CRR_MEMORY_LIMIT"></a><a id="crr_memory_limit"></a><dl> <dt><b>CRR_MEMORY_LIMIT</b></dt>
///                  <dt>0xFFFFFFFC</dt> </dl> </td> <td width="60%"> The specified memory usage that a process cannot exceed was
///                  reached. </td> </tr> <tr> <td width="40%"><a id="CRR_RECYCLED_FROM_UI"></a><a id="crr_recycled_from_ui"></a><dl>
///                  <dt><b>CRR_RECYCLED_FROM_UI</b></dt> <dt>xFFFFFFFB</dt> </dl> </td> <td width="60%"> An administrator decided to
///                  recycle the process through the Component Services administration tool. </td> </tr> </table>
///Returns:
///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and S_OK.
///    
@DllImport("comsvcs")
HRESULT RecycleSurrogate(int lReasonCode);

///<p class="CCE_Message">[<b>MTSCreateActivity</b> is available for in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the CoCreateActivity
///function.] Creates an activity in a single-threaded apartment to do synchronous or asynchronous batch work.
///Params:
///    riid = The ID of the interface to be returned by the <i>ppObj</i> parameter. This parameter should always be
///           IID_IMTSActivity so that a pointer to IMTSActivity is returned.
///    ppobj = A pointer to the interface of an activity object. The activity object is automatically created by the call to
///            <b>MTSCreateActivity</b>.
///Returns:
///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
///    
@DllImport("comsvcs")
HRESULT MTSCreateActivity(const(GUID)* riid, void** ppobj);

///Retrieves the dispenser manager's IDispenserManager interface.
///Params:
///    Arg1 = A pointer to the location that receives the IDispenserManager interface pointer.
///Returns:
///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
///    
@DllImport("MTxDM")
HRESULT GetDispenserManager(IDispenserManager* param0);


// Interfaces

@GUID("ECABB0A5-7F19-11D2-978E-0000F8757E2A")
struct SecurityIdentity;

@GUID("ECABB0A6-7F19-11D2-978E-0000F8757E2A")
struct SecurityCallers;

@GUID("ECABB0A7-7F19-11D2-978E-0000F8757E2A")
struct SecurityCallContext;

@GUID("ECABB0A8-7F19-11D2-978E-0000F8757E2A")
struct GetSecurityCallContextAppObject;

@GUID("ECABB0A9-7F19-11D2-978E-0000F8757E2A")
struct Dummy30040732;

@GUID("7999FC25-D3C6-11CF-ACAB-00A024A55AEF")
struct TransactionContext;

@GUID("5CB66670-D3D4-11CF-ACAB-00A024A55AEF")
struct TransactionContextEx;

@GUID("ECABB0AA-7F19-11D2-978E-0000F8757E2A")
struct ByotServerEx;

@GUID("ECABB0C8-7F19-11D2-978E-0000F8757E2A")
struct CServiceConfig;

@GUID("ECABB0C9-7F19-11D2-978E-0000F8757E2A")
struct ServicePool;

@GUID("ECABB0CA-7F19-11D2-978E-0000F8757E2A")
struct ServicePoolConfig;

@GUID("2A005C05-A5DE-11CF-9E66-00AA00A3F464")
struct SharedProperty;

@GUID("2A005C0B-A5DE-11CF-9E66-00AA00A3F464")
struct SharedPropertyGroup;

@GUID("2A005C11-A5DE-11CF-9E66-00AA00A3F464")
struct SharedPropertyGroupManager;

@GUID("ECABB0AB-7F19-11D2-978E-0000F8757E2A")
struct COMEvents;

@GUID("ECABB0AC-7F19-11D2-978E-0000F8757E2A")
struct CoMTSLocator;

@GUID("4B2E958D-0393-11D1-B1AB-00AA00BA3258")
struct MtsGrp;

@GUID("ECABB0C3-7F19-11D2-978E-0000F8757E2A")
struct ComServiceEvents;

@GUID("ECABB0C6-7F19-11D2-978E-0000F8757E2A")
struct ComSystemAppEventData;

@GUID("ECABB0BD-7F19-11D2-978E-0000F8757E2A")
struct CRMClerk;

@GUID("ECABB0BE-7F19-11D2-978E-0000F8757E2A")
struct CRMRecoveryClerk;

@GUID("ECABB0C1-7F19-11D2-978E-0000F8757E2A")
struct LBEvents;

@GUID("ECABB0BF-7F19-11D2-978E-0000F8757E2A")
struct MessageMover;

@GUID("ECABB0C0-7F19-11D2-978E-0000F8757E2A")
struct DispenserManager;

@GUID("ECABAFB5-7F19-11D2-978E-0000F8757E2A")
struct PoolMgr;

@GUID("ECABAFBC-7F19-11D2-978E-0000F8757E2A")
struct EventServer;

@GUID("ECABAFB9-7F19-11D2-978E-0000F8757E2A")
struct TrackerServer;

@GUID("EF24F689-14F8-4D92-B4AF-D7B1F0E70FD4")
struct AppDomainHelper;

@GUID("458AA3B5-265A-4B75-BC05-9BEA4630CF18")
struct ClrAssemblyLocator;

@GUID("F618C514-DFB8-11D1-A2CF-00805FC79235")
struct COMAdminCatalog;

@GUID("F618C515-DFB8-11D1-A2CF-00805FC79235")
struct COMAdminCatalogObject;

@GUID("F618C516-DFB8-11D1-A2CF-00805FC79235")
struct COMAdminCatalogCollection;

@GUID("4E14FBA2-2E22-11D1-9964-00C04FBBB345")
struct CEventSystem;

@GUID("AB944620-79C6-11D1-88F9-0080C7D771BF")
struct CEventPublisher;

@GUID("CDBEC9C0-7A68-11D1-88F9-0080C7D771BF")
struct CEventClass;

@GUID("7542E960-79C7-11D1-88F9-0080C7D771BF")
struct CEventSubscription;

@GUID("D0565000-9DF4-11D1-A281-00C04FCA0AA7")
struct EventObjectChange;

@GUID("BB07BACD-CD56-4E63-A8FF-CBF0355FB9F4")
struct EventObjectChange2;

///Initiates a session to do programmatic COM+ administration, access collections in the catalog, install COM+
///applications and components, start and stop services, and connect to remote servers. <b>ICOMAdminCatalog</b> provides
///access to the COM+ catalog data store.
@GUID("DD662187-DFC2-11D1-A2CF-00805FC79235")
interface ICOMAdminCatalog : IDispatch
{
    ///Retrieves a top-level collection on the COM+ catalog.
    ///Params:
    ///    bstrCollName = The name of the collection to be retrieved.
    ///    ppCatalogCollection = The ICatalogCollection interface for the collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCollection(BSTR bstrCollName, IDispatch* ppCatalogCollection);
    ///Connects to the COM+ catalog on a specified remote computer.
    ///Params:
    ///    bstrCatalogServerName = The name of the remote computer. To connect to the local computer, use an empty string.
    ///    ppCatalogCollection = The ICatalogCollection interface for the root collection on the remote computer.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Connect(BSTR bstrCatalogServerName, IDispatch* ppCatalogCollection);
    ///Retrieves the major version number of the COMAdmin library. This property is read-only.
    HRESULT get_MajorVersion(int* plMajorVersion);
    ///Retrieves the minor version number of the COMAdmin library. This property is read-only.
    HRESULT get_MinorVersion(int* plMinorVersion);
    ///Retrieves a collection on the COM+ catalog given the key property values for all of its parent items.
    ///Params:
    ///    bstrCollName = The name of the collection to be retrieved.
    ///    ppsaVarQuery = A reference to an array consisting of key property values for all parent items of the collection to be
    ///                   retrieved.
    ///    ppCatalogCollection = The ICatalogCollection interface for the collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCollectionByQuery(BSTR bstrCollName, SAFEARRAY** ppsaVarQuery, IDispatch* ppCatalogCollection);
    ///Imports a component already registered as an in-process server into a COM+ application.
    ///Params:
    ///    bstrApplIDOrName = The GUID or name of the application.
    ///    bstrCLSIDOrProgID = The CLSID or ProgID for the component to import.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ImportComponent(BSTR bstrApplIDOrName, BSTR bstrCLSIDOrProgID);
    ///Installs all components (COM classes) from a DLL file into a COM+ application and registers the components in the
    ///COM+ class registration database.
    ///Params:
    ///    bstrApplIDOrName = The GUID or name of the application.
    ///    bstrDLL = The name of the DLL file containing the component to be installed.
    ///    bstrTLB = The name of the external type library file. If the type library file is embedded in the DLL, pass in an empty
    ///              string for this parameter.
    ///    bstrPSDLL = The name of the proxy-stub DLL file. If there is no proxy-stub DLL associated with the component, pass in an
    ///                empty string for this parameter.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT InstallComponent(BSTR bstrApplIDOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    ///Initiates shutdown of a COM+ server application process.
    ///Params:
    ///    bstrApplIDOrName = The GUID or name of the application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td
    ///    width="60%"> The application does not exist. </td> </tr> </table>
    ///    
    HRESULT ShutdownApplication(BSTR bstrApplIDOrName);
    ///Exports a COM+ application or application proxy to a file, ready for installation on different computers.
    ///Params:
    ///    bstrApplIDOrName = The GUID or application name of the application to be exported.
    ///    bstrApplicationFile = The name of the file to export the application to, including the file path. If this parameter is <b>NULL</b>
    ///                          or an empty string, the <b>ExportApplication</b> method returns E_INVALIDARG. If the path is not specified,
    ///                          the current directory is used. If a relative path is entered, the path is relative to the current directory.
    ///    lOptions = Specifies the application export options. This parameter can be one of more of the following values from the
    ///               <b>COMAdminApplicationExportOptions</b> enumeration type. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///               <tr> <td width="40%"><a id="COMAdminExportNoUsers"></a><a id="comadminexportnousers"></a><a
    ///               id="COMADMINEXPORTNOUSERS"></a><dl> <dt><b>COMAdminExportNoUsers</b></dt> <dt>0</dt> </dl> </td> <td
    ///               width="60%"> Export without the users assigned to application roles. </td> </tr> <tr> <td width="40%"><a
    ///               id="COMAdminExportUsers"></a><a id="comadminexportusers"></a><a id="COMADMINEXPORTUSERS"></a><dl>
    ///               <dt><b>COMAdminExportUsers</b></dt> <dt>1</dt> </dl> </td> <td width="60%"> Export with the users assigned to
    ///               application roles. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportApplicationProxy"></a><a
    ///               id="comadminexportapplicationproxy"></a><a id="COMADMINEXPORTAPPLICATIONPROXY"></a><dl>
    ///               <dt><b>COMAdminExportApplicationProxy</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Export applications as
    ///               proxies. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportForceOverwriteOfFile"></a><a
    ///               id="comadminexportforceoverwriteoffile"></a><a id="COMADMINEXPORTFORCEOVERWRITEOFFILE"></a><dl>
    ///               <dt><b>COMAdminExportForceOverwriteOfFile</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Overwrite existing
    ///               files. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportIn10Format"></a><a
    ///               id="comadminexportin10format"></a><a id="COMADMINEXPORTIN10FORMAT"></a><dl>
    ///               <dt><b>COMAdminExportIn10Format</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> Export in COM+ 1.0 (Windows
    ///               2000) format. </td> </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td
    ///    width="60%"> The application does not exist. </td> </tr> </table>
    ///    
    HRESULT ExportApplication(BSTR bstrApplIDOrName, BSTR bstrApplicationFile, int lOptions);
    ///Installs a COM+ application or application proxy from the specified file.
    ///Params:
    ///    bstrApplicationFile = The name of the file containing the application to be installed.
    ///    bstrDestinationDirectory = Where to install the components. If this parameter is blank, the default directory is used.
    ///    lOptions = The option flags. This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="COMAdminInstallNoUsers"></a><a
    ///               id="comadmininstallnousers"></a><a id="COMADMININSTALLNOUSERS"></a><dl>
    ///               <dt><b>COMAdminInstallNoUsers</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Do not install users saved in
    ///               application file (default). </td> </tr> <tr> <td width="40%"><a id="COMAdminInstallUsers"></a><a
    ///               id="comadmininstallusers"></a><a id="COMADMININSTALLUSERS"></a><dl> <dt><b>COMAdminInstallUsers</b></dt>
    ///               <dt>1</dt> </dl> </td> <td width="60%"> Install users saved in an application file. </td> </tr> <tr> <td
    ///               width="40%"><a id="COMAdminInstallForceOverwriteOfFiles"></a><a
    ///               id="comadmininstallforceoverwriteoffiles"></a><a id="COMADMININSTALLFORCEOVERWRITEOFFILES"></a><dl>
    ///               <dt><b>COMAdminInstallForceOverwriteOfFiles</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Overwrite files.
    ///               </td> </tr> </table>
    ///    bstrUserId = The user ID under which to run the application.
    ///    bstrPassword = The password under which to run the application.
    ///    bstrRSN = A remote server name to use for an application proxy.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INSTALL_FAILURE</b></dt> </dl> </td> <td width="60%"> A fatal
    ///    error occurred during installation. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>COMADMIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The application does not exist.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td width="60%">
    ///    An error occurred accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT InstallApplication(BSTR bstrApplicationFile, BSTR bstrDestinationDirectory, int lOptions, 
                               BSTR bstrUserId, BSTR bstrPassword, BSTR bstrRSN);
    ///Stops the component load balancing service if the service is currently installed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_SERVICENOTINSTALLED</b></dt> </dl> </td> <td width="60%">
    ///    The component load balancing service is not currently installed on the computer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td width="60%"> Errors occurred while
    ///    accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT StopRouter();
    ///This method is obsolete.
    HRESULT RefreshRouter();
    ///Starts the component load balancing service if the service is currently installed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_SERVICENOTINSTALLED</b></dt> </dl> </td> <td width="60%">
    ///    The component load balancing service is not currently installed on the computer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td width="60%"> Errors occurred while
    ///    accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT StartRouter();
    HRESULT Reserved1();
    HRESULT Reserved2();
    ///Installs components from multiple files into a COM+ application.
    ///Params:
    ///    bstrApplIDOrName = The GUID or name of the application.
    ///    ppsaVarFileNames = An array of the names of the DLL files that contains the components to be installed.
    ///    ppsaVarCLSIDs = An array of CLSIDs for the components to be installed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT InstallMultipleComponents(BSTR bstrApplIDOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs);
    ///Retrieves information about the components found in the specified files.
    ///Params:
    ///    bstrApplIdOrName = The GUID or application name representing the application.
    ///    ppsaVarFileNames = An array of names of files containing the components.
    ///    ppsaVarCLSIDs = An array of component CLSIDs.
    ///    ppsaVarClassNames = An array of component class names.
    ///    ppsaVarFileFlags = An array for file flags containing information about the files.
    ///    ppsaVarComponentFlags = An array for the component flags used to represent information about components in files.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT GetMultipleComponentsInfo(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarClassNames, 
                                      SAFEARRAY** ppsaVarFileFlags, SAFEARRAY** ppsaVarComponentFlags);
    ///Updates component registration information from the registry. You generally should not use
    ///<b>RefreshComponents</b>. The recommended way to update components in COM+ applications is to remove and
    ///reinstall the components using ICOMAdminCatalog::InstallComponent so that complete registration information is
    ///updated in the registry database.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT RefreshComponents();
    ///Backs up the COM+ class registration database to a specified file.
    ///Params:
    ///    bstrBackupFilePath = The path for the file in which the registration database is to be backed up.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT BackupREGDB(BSTR bstrBackupFilePath);
    ///Restores the COM+ class registration database (RegDB) from the specified file. For this to take effect, a system
    ///reboot is required.
    ///Params:
    ///    bstrBackupFilePath = The name of the file to which the database was backed up.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The method is not
    ///    implemented. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS</b></dt> </dl> </td> <td
    ///    width="60%"> Errors occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT RestoreREGDB(BSTR bstrBackupFilePath);
    ///Retrieves information about a COM+ application from an application file.
    ///Params:
    ///    bstrApplicationFile = The application file from which information is to be retrieved.
    ///    pbstrApplicationName = The application name in the specified file.
    ///    pbstrApplicationDescription = The application description.
    ///    pbHasUsers = Indicates whether the application has user information associated with its roles.
    ///    pbIsProxy = Indicates whether the file contains an application proxy.
    ///    ppsaVarFileNames = An array of names of the DLL files for the components installed in the application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT QueryApplicationFile(BSTR bstrApplicationFile, BSTR* pbstrApplicationName, 
                                 BSTR* pbstrApplicationDescription, short* pbHasUsers, short* pbIsProxy, 
                                 SAFEARRAY** ppsaVarFileNames);
    ///Starts the specified COM+ server application. The application components are launched in a dedicated server
    ///process.
    ///Params:
    ///    bstrApplIdOrName = The GUID or name of the application. If a GUID is used, it must be surrounded by braces.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT StartApplication(BSTR bstrApplIdOrName);
    ///Retrieves the current status of the specified COM+ service.
    ///Params:
    ///    lService = The service for which status is to be checked. This parameter can be COMAdminServiceLoadBalanceRouter (1) to
    ///               check the component load balancing service.
    ///    plStatus = The status for the specified service. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///               width="40%"><a id="COMAdminServiceStopped"></a><a id="comadminservicestopped"></a><a
    ///               id="COMADMINSERVICESTOPPED"></a><dl> <dt><b>COMAdminServiceStopped</b></dt> <dt>0</dt> </dl> </td> <td
    ///               width="60%"> The service is stopped. </td> </tr> <tr> <td width="40%"><a
    ///               id="COMAdminServiceStartPending"></a><a id="comadminservicestartpending"></a><a
    ///               id="COMADMINSERVICESTARTPENDING"></a><dl> <dt><b>COMAdminServiceStartPending</b></dt> <dt>1</dt> </dl> </td>
    ///               <td width="60%"> The service is due to start. </td> </tr> <tr> <td width="40%"><a
    ///               id="COMAdminServiceStopPending"></a><a id="comadminservicestoppending"></a><a
    ///               id="COMADMINSERVICESTOPPENDING"></a><dl> <dt><b>COMAdminServiceStopPending</b></dt> <dt>2</dt> </dl> </td>
    ///               <td width="60%"> The service is due to stop. </td> </tr> <tr> <td width="40%"><a
    ///               id="COMAdminServiceRunning"></a><a id="comadminservicerunning"></a><a id="COMADMINSERVICERUNNING"></a><dl>
    ///               <dt><b>COMAdminServiceRunning</b></dt> <dt>3</dt> </dl> </td> <td width="60%"> The service is running. </td>
    ///               </tr> <tr> <td width="40%"><a id="COMAdminServiceContinuePending"></a><a
    ///               id="comadminservicecontinuepending"></a><a id="COMADMINSERVICECONTINUEPENDING"></a><dl>
    ///               <dt><b>COMAdminServiceContinuePending</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> The service is due to
    ///               continue. </td> </tr> <tr> <td width="40%"><a id="COMAdminServicePausePending"></a><a
    ///               id="comadminservicepausepending"></a><a id="COMADMINSERVICEPAUSEPENDING"></a><dl>
    ///               <dt><b>COMAdminServicePausePending</b></dt> <dt>5</dt> </dl> </td> <td width="60%"> The service is due to
    ///               pause. </td> </tr> <tr> <td width="40%"><a id="COMAdminServicePaused"></a><a
    ///               id="comadminservicepaused"></a><a id="COMADMINSERVICEPAUSED"></a><dl> <dt><b>COMAdminServicePaused</b></dt>
    ///               <dt>6</dt> </dl> </td> <td width="60%"> The service is paused. </td> </tr> <tr> <td width="40%"><a
    ///               id="COMAdminServiceUnknownState"></a><a id="comadminserviceunknownstate"></a><a
    ///               id="COMADMINSERVICEUNKNOWNSTATE"></a><dl> <dt><b>COMAdminServiceUnknownState</b></dt> <dt>7</dt> </dl> </td>
    ///               <td width="60%"> The service status is unknown. </td> </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ServiceCheck(int lService, int* plStatus);
    ///Installs event classes from multiple files into a COM+ application.
    ///Params:
    ///    bstrApplIdOrName = The GUID or name of the application.
    ///    ppsaVarFileNames = An array of the names of the DLL files that contains the event classes to be installed.
    ///    ppsaVarCLSIDS = An array of CLSIDs for the event classes to be installed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT InstallMultipleEventClasses(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                        SAFEARRAY** ppsaVarCLSIDS);
    ///Installs event classes from a file into a COM+ application.
    ///Params:
    ///    bstrApplIdOrName = The GUID or name of the application.
    ///    bstrDLL = The file name of the DLL containing the event classes to be installed.
    ///    bstrTLB = The name of an external type library file. If the type library file is embedded in the DLL, pass in an empty
    ///              string for this parameter.
    ///    bstrPSDLL = The name of the proxy-stub DLL file. If there is no proxy-stub DLL associated with the event class, pass in
    ///                an empty string for this parameter.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT InstallEventClass(BSTR bstrApplIdOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    ///Retrieves a list of the event classes registered on the computer that implement a specified interface.
    ///Params:
    ///    bstrIID = A GUID representing the interface for which event classes should be found. If this parameter is <b>NULL</b>,
    ///              the method retrieves all event classes registered on the computer.
    ///    ppsaVarCLSIDs = An array of CLSIDs for the event classes implementing the interface specified in <i>bstrIID</i>.
    ///    ppsaVarProgIDs = An array of ProgIDs for the event classes implementing the interface specified in <i>bstrIID</i>.
    ///    ppsaVarDescriptions = An array of descriptions for the event classes implementing the interface specified in <i>bstrIID</i>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetEventClassesForIID(BSTR bstrIID, SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarProgIDs, 
                                  SAFEARRAY** ppsaVarDescriptions);
}

///An extension of the ICOMAdminCatalog interface. The <b>ICOMAdminCatalog2</b> methods are used to control the
///interactions of applications, components, and partitions. These methods enable developers to control application
///execution, to dump applications or partitions to disk, to move components between applications, and to move
///applications between partitions.
@GUID("790C6E0B-9194-4CC9-9426-A48A63185696")
interface ICOMAdminCatalog2 : ICOMAdminCatalog
{
    ///Retrieves a collection of items in the COM+ catalog that satisfy the specified set of query keys.
    ///Params:
    ///    bstrCollectionName = The name of the collection to be retrieved from the catalog. Possible collection names can be found in the
    ///                         table of collections at COM+ Administration Collections.
    ///    pVarQueryStrings = The query keys.
    ///    ppCatalogCollection = A pointer to an ICatalogCollection interface pointer containing the result of the query.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCollectionByQuery2(BSTR bstrCollectionName, VARIANT* pVarQueryStrings, 
                                  IDispatch* ppCatalogCollection);
    ///Retrieives the application instance identifier for the specified process identifier.
    ///Params:
    ///    lProcessID = The process ID.
    ///    pbstrApplicationInstanceID = The corresponding application instance ID.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetApplicationInstanceIDFromProcessID(int lProcessID, BSTR* pbstrApplicationInstanceID);
    ///Initiates shutdown of the specified application server processes.
    ///Params:
    ///    pVarApplicationInstanceID = The application instances to be shut down. Each element of the <b>Variant</b> may be a <b>String</b>
    ///                                containing an application instance GUID (for example, as returned by the
    ///                                GetApplicationInstanceIDFromProcessID method), a single catalog object, or a catalog collection (for example,
    ///                                as returned by the GetCollectionByQuery2 method).
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
    ///    A specified application instance does not exist. </td> </tr> </table>
    ///    
    HRESULT ShutdownApplicationInstances(VARIANT* pVarApplicationInstanceID);
    ///Pauses the specified application server processes.
    ///Params:
    ///    pVarApplicationInstanceID = The application instances to be paused. Each element of the <b>Variant</b> may be a <b>String</b> containing
    ///                                an application instance GUID (for example, as returned by the GetApplicationInstanceIDFromProcessID method),
    ///                                a single catalog object, or a catalog collection (for example, as returned by the GetCollectionByQuery2
    ///                                method).
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
    ///    A specified application instance does not exist. </td> </tr> </table>
    ///    
    HRESULT PauseApplicationInstances(VARIANT* pVarApplicationInstanceID);
    ///Resumes the specified application server processes.
    ///Params:
    ///    pVarApplicationInstanceID = The application instances to be resumed. Each element of the <b>Variant</b> may be a <b>String</b> containing
    ///                                an application instance GUID (for example, as returned by the GetApplicationInstanceIDFromProcessID method),
    ///                                a single catalog object, or a catalog collection (for example, as returned by the GetCollectionByQuery2
    ///                                method).
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
    ///    A specified application instance does not exist. </td> </tr> </table>
    ///    
    HRESULT ResumeApplicationInstances(VARIANT* pVarApplicationInstanceID);
    ///Recycles (shuts down and restarts) the specified application server processes.
    ///Params:
    ///    pVarApplicationInstanceID = The application instances to be recycled. Each element of the <b>Variant</b> may be a <b>String</b>
    ///                                containing an application instance GUID (for example, as returned by the
    ///                                GetApplicationInstanceIDFromProcessID method), a single catalog object, or a catalog collection (for example,
    ///                                as returned by the GetCollectionByQuery2 method).
    ///    lReasonCode = The reason for recycling the specified application instances. This code is written to an event log entry.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
    ///    A specified application instance does not exist. </td> </tr> </table>
    ///    
    HRESULT RecycleApplicationInstances(VARIANT* pVarApplicationInstanceID, int lReasonCode);
    ///Determines whether any of the specified application instances (processes) are paused.
    ///Params:
    ///    pVarApplicationInstanceID = The application instances to be checked. Each element of the <b>Variant</b> may be a <b>String</b> containing
    ///                                an application instance ID (for example, as returned by the GetApplicationInstanceIDFromProcessID method), a
    ///                                single catalog object, or a catalog collection (for example, as returned by the GetCollectionByQuery2
    ///                                method).
    ///    pVarBoolPaused = Indicates whether the specified applications are paused.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%">
    ///    A specified application instance does not exist. </td> </tr> </table>
    ///    
    HRESULT AreApplicationInstancesPaused(VARIANT* pVarApplicationInstanceID, short* pVarBoolPaused);
    ///Creates a dump file containing an image of the state of the specified application instance (process). <div
    ///class="alert"><b>Note</b> As of Windows Server 2003, only administrators have read access privileges to the COM+
    ///dump files.</div><div> </div>
    ///Params:
    ///    bstrApplicationInstanceID = The GUID of the application instance.
    ///    bstrDirectory = The complete path to the directory into which the dump file is placed. Do not include the file name. If this
    ///                    parameter is <b>NULL</b>, the default directory is %SystemRoot%\system32\com\dmp.
    ///    lMaxImages = The maximum number of dump files that may exist in the dump directory. Specifying this variable prevents dump
    ///                 files from consuming too much storage space.
    ///    pbstrDumpFile = The name of the dump file containing the resulting application instance image.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_APP_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The
    ///    specified process is not running. </td> </tr> </table>
    ///    
    HRESULT DumpApplicationInstance(BSTR bstrApplicationInstanceID, BSTR bstrDirectory, int lMaxImages, 
                                    BSTR* pbstrDumpFile);
    ///Indicates whether the software required for application instance dumps is installed. This property is read-only.
    HRESULT get_IsApplicationInstanceDumpSupported(short* pVarBoolDumpSupported);
    ///Configures a COM+ application to run as a Windows service.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of the application.
    ///    bstrServiceName = The service name of the application. This name is the internal name used by the service control manager
    ///                      (SCM), not the display name.
    ///    bstrStartType = When to start the service. The valid arguments are the options of the <i>dwStartType</i> parameter of the
    ///                    CreateService function. The arguments must be in quotes. The following are the valid arguments:
    ///                    SERVICE_BOOT_START, SERVICE_SYSTEM_START, SERVICE_AUTO_START, SERVICE_DEMAND_START, and SERVICE_DISABLED.
    ///    bstrErrorControl = The severity of the error if this service fails to start during startup. The error determines the action
    ///                       taken by the startup program if failure occurs. The valid arguments are the options of the
    ///                       <i>dwErrorControl</i> parameter of the CreateService function. The arguments must be in quotes. The following
    ///                       are the valid arguments: SERVICE_ERROR_IGNORE, SERVICE_ERROR_NORMAL, SERVICE_ERROR_SEVERE, and
    ///                       SERVICE_ERROR_CRITICAL.
    ///    bstrDependencies = A list of dependencies for the service. There are two possible formats for the string: a standard
    ///                       null-delimited, double-null-terminated string (exactly as documented for CreateService); or a script-friendly
    ///                       list of service names separated by "\" (an invalid character to have in a service name). The rpcss service is
    ///                       implicit in this parameter and does not need to be specified.
    ///    bstrRunAs = The user name to run this service as. If this parameter is <b>NULL</b>, the service will run as Local
    ///                Service.
    ///    bstrPassword = The password for the system user account. This parameter must be <b>NULL</b> if the service is configured to
    ///                   run as Local Service.
    ///    bDesktopOk = Indicates whether the service should be allowed to interact with the desktop. This parameter is valid only
    ///                 when the service is marked as Local Service and must be <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CreateServiceForApplication(BSTR bstrApplicationIDOrName, BSTR bstrServiceName, BSTR bstrStartType, 
                                        BSTR bstrErrorControl, BSTR bstrDependencies, BSTR bstrRunAs, 
                                        BSTR bstrPassword, short bDesktopOk);
    ///Deletes the Windows service associated with the specified COM+ application.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of the COM+ application to be deleted.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT DeleteServiceForApplication(BSTR bstrApplicationIDOrName);
    ///Retrieves the partition identifier for the specified COM+ application.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of a COM+ application.
    ///    pbstrPartitionID = The partition GUID associated with the specified application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_AMBIGUOUS_APPLICATION_NAME</b></dt> </dl> </td> <td
    ///    width="60%"> The named application exists in multiple partitions. To avoid this error, use an application ID
    ///    instead of a name. </td> </tr> </table>
    ///    
    HRESULT GetPartitionID(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionID);
    ///Retrieves the name of the specified COM+ application.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of a COM+ application.
    ///    pbstrPartitionName = The partition name associated with the specified application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_AMBIGUOUS_APPLICATION_NAME</b></dt> </dl> </td> <td
    ///    width="60%"> The named application exists in multiple partitions. To avoid this error, use an application ID
    ///    instead of a name. </td> </tr> </table>
    ///    
    HRESULT GetPartitionName(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionName);
    ///Sets the current destination partition. This property is write-only.
    HRESULT put_CurrentPartition(BSTR bstrPartitionIDOrName);
    ///Retrieves the identifier for the current partition. This property is read-only.
    HRESULT get_CurrentPartitionID(BSTR* pbstrPartitionID);
    ///Retrieves the name of the current partition. This property is read-only.
    HRESULT get_CurrentPartitionName(BSTR* pbstrPartitionName);
    ///Retrieves the identifier for the global partition. This property is read-only.
    HRESULT get_GlobalPartitionID(BSTR* pbstrGlobalPartitionID);
    ///Empties the cache that maps users to their default partitions. COM+ caches users' default partitions to avoid
    ///repetitive Active Directory requests. You might want to call this method after changing a user's default
    ///partition in Active Directory.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT FlushPartitionCache();
    ///Copies the specified COM+ applications from one partition to another.
    ///Params:
    ///    bstrSourcePartitionIDOrName = The partition GUID or the name of the source partition.
    ///    pVarApplicationID = The applications to be copied. Each element of the <b>Variant</b> may be a <b>String</b> containing an
    ///                        application name or ID, a single catalog object, or a catalog collection (as returned, for example, by the
    ///                        GetCollectionByQuery2 method).
    ///    bstrDestinationPartitionIDOrName = The partition GUID or the name of the destination partition.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CopyApplications(BSTR bstrSourcePartitionIDOrName, VARIANT* pVarApplicationID, 
                             BSTR bstrDestinationPartitionIDOrName);
    ///Copies the specified components from one partition to another.
    ///Params:
    ///    bstrSourceApplicationIDOrName = The application ID or name of the source application.
    ///    pVarCLSIDOrProgID = The components to be copied. Each element of the <b>Variant</b> may be a <b>String</b> containing a class ID
    ///                        or program ID, a single catalog object, or a catalog collection (for example, as returned by the
    ///                        GetCollectionByQuery2 method).
    ///    bstrDestinationApplicationIDOrName = The application ID or name of the destination application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_AMBIGUOUS_APPLICATION_NAME</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the named applications exists in multiple partitions. To avoid this error, use
    ///    application IDs instead of names. </td> </tr> </table>
    ///    
    HRESULT CopyComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    ///Moves the specified components from one application to another.
    ///Params:
    ///    bstrSourceApplicationIDOrName = The application ID or name of the source application.
    ///    pVarCLSIDOrProgID = The components to be moved. Each element of the <b>Variant</b> may be a <b>String</b> containing a class ID
    ///                        or program ID, a single catalog object, or a catalog collection (for example, as returned by the
    ///                        GetCollectionByQuery2 method).
    ///    bstrDestinationApplicationIDOrName = The application ID or name of the destination application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADIN_E_AMBIGUOUS_APPLICATION_NAME</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the named applications exists in multiple partitions. To avoid this error, use
    ///    application IDs instead of names. </td> </tr> </table>
    ///    
    HRESULT MoveComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    ///Creates an alias for an existing COM+ component.
    ///Params:
    ///    bstrSrcApplicationIDOrName = The application ID or name of the source application containing the component.
    ///    bstrCLSIDOrProgID = The class ID or program ID of the component for which an alias is created.
    ///    bstrDestApplicationIDOrName = The application ID or the name of the destination application that contains the alias. If this argument is
    ///                                  <b>NULL</b> or an empty string, the alias is created within the source application.
    ///    bstrNewProgId = The program ID of the alias.
    ///    bstrNewClsid = The class ID of the alias. If this argument is <b>NULL</b> or an empty string, a new, unique class ID is
    ///                   assigned.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_AMBIGUOUS_APPLICATION_NAME</b></dt> </dl> </td> <td
    ///    width="60%"> At least one of the named applications exists in multiple partitions. To avoid this error, use
    ///    application IDs instead of names. </td> </tr> </table>
    ///    
    HRESULT AliasComponent(BSTR bstrSrcApplicationIDOrName, BSTR bstrCLSIDOrProgID, 
                           BSTR bstrDestApplicationIDOrName, BSTR bstrNewProgId, BSTR bstrNewClsid);
    ///Determines whether the specified DLL is in use by the COM+ catalog or the registry.
    ///Params:
    ///    bstrDllName = The full path to the DLL to be tested.
    ///    pCOMAdminInUse = Indicates the DLL usage. This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///                     <th>Meaning</th> </tr> <tr> <td width="40%"><a id="COMAdminNotInUse"></a><a id="comadminnotinuse"></a><a
    ///                     id="COMADMINNOTINUSE"></a><dl> <dt><b>COMAdminNotInUse</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> The
    ///                     DLL is not in use and may safely be deleted. </td> </tr> <tr> <td width="40%"><a
    ///                     id="COMAdminInUseByCatalog"></a><a id="comadmininusebycatalog"></a><a id="COMADMININUSEBYCATALOG"></a><dl>
    ///                     <dt><b>COMAdminInUseByCatalog</b></dt> <dt>0x1</dt> </dl> </td> <td width="60%"> The DLL is in use by the
    ///                     COM+ catalog. </td> </tr> <tr> <td width="40%"><a id="COMAdminInUseByRegistryUnknown"></a><a
    ///                     id="comadmininusebyregistryunknown"></a><a id="COMADMININUSEBYREGISTRYUNKNOWN"></a><dl>
    ///                     <dt><b>COMAdminInUseByRegistryUnknown</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> The DLL is in use by
    ///                     an unknown registry component. </td> </tr> <tr> <td width="40%"><a
    ///                     id="COMAdminInUseByRegistryProxyStub"></a><a id="comadmininusebyregistryproxystub"></a><a
    ///                     id="COMADMININUSEBYREGISTRYPROXYSTUB"></a><dl> <dt><b>COMAdminInUseByRegistryProxyStub</b></dt> <dt>0x3</dt>
    ///                     </dl> </td> <td width="60%"> The DLL is in use by the proxy registry component. </td> </tr> <tr> <td
    ///                     width="40%"><a id="COMAdminInUseByRegistryTypeLib"></a><a id="comadmininusebyregistrytypelib"></a><a
    ///                     id="COMADMININUSEBYREGISTRYTYPELIB"></a><dl> <dt><b>COMAdminInUseByRegistryTypeLib</b></dt> <dt>0x4</dt>
    ///                     </dl> </td> <td width="60%"> The DLL is in use by the TypeLib registry component. </td> </tr> <tr> <td
    ///                     width="40%"><a id="COMAdminInUseByRegistryClsid"></a><a id="comadmininusebyregistryclsid"></a><a
    ///                     id="COMADMININUSEBYREGISTRYCLSID"></a><dl> <dt><b>COMAdminInUseByRegistryClsid</b></dt> <dt>0x5</dt> </dl>
    ///                     </td> <td width="60%"> The DLL is in use by the CLSID registry component. </td> </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT IsSafeToDelete(BSTR bstrDllName, COMAdminInUse* pCOMAdminInUse);
    ///Imports the specified classes into a COM+ application as unconfigured components.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of the application into which the components are to be imported.
    ///    pVarCLSIDOrProgID = The unconfigured components to be imported. Each element of the <b>Variant</b> may be a <b>String</b>
    ///                        containing a class ID or program ID, a single catalog object, or a catalog collection (for example, as
    ///                        returned by the GetCollectionByQuery2 method).
    ///    pVarComponentType = The bitnes of each component. This parameter can be one of the following values. If this parameter is
    ///                        omitted, the native bitness of the computer is assumed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                        <tr> <td width="40%"><a id="COMAdmin32BitComponent"></a><a id="comadmin32bitcomponent"></a><a
    ///                        id="COMADMIN32BITCOMPONENT"></a><dl> <dt><b>COMAdmin32BitComponent</b></dt> <dt>0x1</dt> </dl> </td> <td
    ///                        width="60%"> Uses a 32-bit format. </td> </tr> <tr> <td width="40%"><a id="COMAdmin64BitComponent"></a><a
    ///                        id="comadmin64bitcomponent"></a><a id="COMADMIN64BITCOMPONENT"></a><dl>
    ///                        <dt><b>COMAdmin64BitComponent</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Uses a 64-bit format. </td>
    ///                        </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ImportUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                         VARIANT* pVarComponentType);
    ///Promotes the specified classes from unconfigured components to configured components. <div
    ///class="alert"><b>Note</b> Before calling this method, its necessary to first import the unconfigured components
    ///by using the ImportUnconfiguredComponents method. Otherwise, this method returns an E_INVALIDARG
    ///error.</div><div> </div>
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of the application containing the components to be promoted.
    ///    pVarCLSIDOrProgID = The unconfigured components to be promoted. Each element of the <b>Variant</b> may be a <b>String</b>
    ///                        containing a class ID or program ID, a single catalog object, or a catalog collection (for example, as
    ///                        returned by the GetCollectionByQuery2 method).
    ///    pVarComponentType = The bitnes of each component. This parameter can be one of the following values. If this parameter is
    ///                        omitted, the native bitness of the computer is assumed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                        <tr> <td width="40%"><a id="COMAdmin32BitComponent"></a><a id="comadmin32bitcomponent"></a><a
    ///                        id="COMADMIN32BITCOMPONENT"></a><dl> <dt><b>COMAdmin32BitComponent</b></dt> <dt>0x1</dt> </dl> </td> <td
    ///                        width="60%"> Uses a 32-bit format. </td> </tr> <tr> <td width="40%"><a id="COMAdmin64BitComponent"></a><a
    ///                        id="comadmin64bitcomponent"></a><a id="COMADMIN64BITCOMPONENT"></a><dl>
    ///                        <dt><b>COMAdmin64BitComponent</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Uses a 64-bit format. </td>
    ///                        </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT PromoteUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                          VARIANT* pVarComponentType);
    ///Imports the specified components that are already registered into an application. To import unconfigured
    ///components, you can use the ImportUnconfiguredComponents and PromoteUnconfiguredComponents methods.
    ///Params:
    ///    bstrApplicationIDOrName = The application ID or name of the application into which the components are to be imported.
    ///    pVarCLSIDOrProgID = The components to be imported. Each element of the <b>Variant</b> may be a <b>String</b> containing a class
    ///                        ID or program ID, a single catalog object, or a catalog collection (for example, as returned by the
    ///                        GetCollectionByQuery2 method).
    ///    pVarComponentType = The bitnes of each component. This parameter can be one of the following values. If this parameter is
    ///                        omitted, the native bitness of the computer is assumed. <table> <tr> <th>Value</th> <th>Meaning</th> </tr>
    ///                        <tr> <td width="40%"><a id="COMAdmin32BitComponent"></a><a id="comadmin32bitcomponent"></a><a
    ///                        id="COMADMIN32BITCOMPONENT"></a><dl> <dt><b>COMAdmin32BitComponent</b></dt> <dt>0x1</dt> </dl> </td> <td
    ///                        width="60%"> Uses a 32-bit format. </td> </tr> <tr> <td width="40%"><a id="COMAdmin64BitComponent"></a><a
    ///                        id="comadmin64bitcomponent"></a><a id="COMADMIN64BITCOMPONENT"></a><dl>
    ///                        <dt><b>COMAdmin64BitComponent</b></dt> <dt>0x2</dt> </dl> </td> <td width="60%"> Uses a 64-bit format. </td>
    ///                        </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ImportComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    ///Indicates whether the currently connected catalog server is a 64-bit computer. This property is read-only.
    HRESULT get_Is64BitCatalogServer(short* pbIs64Bit);
    ///Exports a partition to a file. An exported partition can be imported using the InstallPartition method.
    ///Params:
    ///    bstrPartitionIDOrName = The partition GUID or name of the partition.
    ///    bstrPartitionFileName = The file to which the specified partition is exported. If no path is specified, the current directory is
    ///                            used. If no file name is specified, the application name is used.
    ///    lOptions = The option flags. This parameter can be one or more of the following values. <table> <tr> <th>Value</th>
    ///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="COMAdminExportNoUsers"></a><a
    ///               id="comadminexportnousers"></a><a id="COMADMINEXPORTNOUSERS"></a><dl> <dt><b>COMAdminExportNoUsers</b></dt>
    ///               <dt>0</dt> </dl> </td> <td width="60%"> Do not export users with roles (default). </td> </tr> <tr> <td
    ///               width="40%"><a id="COMAdminExportUsers"></a><a id="comadminexportusers"></a><a
    ///               id="COMADMINEXPORTUSERS"></a><dl> <dt><b>COMAdminExportUsers</b></dt> <dt>1</dt> </dl> </td> <td width="60%">
    ///               Export users with roles. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportApplicationProxy"></a><a
    ///               id="comadminexportapplicationproxy"></a><a id="COMADMINEXPORTAPPLICATIONPROXY"></a><dl>
    ///               <dt><b>COMAdminExportApplicationProxy</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Export applications as
    ///               proxies. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportForceOverwriteOfFile"></a><a
    ///               id="comadminexportforceoverwriteoffile"></a><a id="COMADMINEXPORTFORCEOVERWRITEOFFILE"></a><dl>
    ///               <dt><b>COMAdminExportForceOverwriteOfFile</b></dt> <dt>4</dt> </dl> </td> <td width="60%"> Overwrite existing
    ///               files. </td> </tr> <tr> <td width="40%"><a id="COMAdminExportIn10Format"></a><a
    ///               id="comadminexportin10format"></a><a id="COMADMINEXPORTIN10FORMAT"></a><dl>
    ///               <dt><b>COMAdminExportIn10Format</b></dt> <dt>16</dt> </dl> </td> <td width="60%"> Export in COM+ 1.0 format.
    ///               </td> </tr> </table>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td
    ///    width="60%"> The specified partition does not exist. </td> </tr> </table>
    ///    
    HRESULT ExportPartition(BSTR bstrPartitionIDOrName, BSTR bstrPartitionFileName, int lOptions);
    ///Imports a partition from a file.
    ///Params:
    ///    bstrFileName = The file from which the partition is to be imported.
    ///    bstrDestDirectory = The path to the directory in which to install the partition components.
    ///    lOptions = The install options. This parameter can be one of the following values. <table> <tr> <th>Value</th>
    ///               <th>Meaning</th> </tr> <tr> <td width="40%"><a id="COMAdminInstallNoUsers"></a><a
    ///               id="comadmininstallnousers"></a><a id="COMADMININSTALLNOUSERS"></a><dl>
    ///               <dt><b>COMAdminInstallNoUsers</b></dt> <dt>0</dt> </dl> </td> <td width="60%"> Do not install users saved in
    ///               the partition (default). </td> </tr> <tr> <td width="40%"><a id="COMAdminInstallUsers"></a><a
    ///               id="comadmininstallusers"></a><a id="COMADMININSTALLUSERS"></a><dl> <dt><b>COMAdminInstallUsers</b></dt>
    ///               <dt>1</dt> </dl> </td> <td width="60%"> Install users saved in the partition. </td> </tr> <tr> <td
    ///               width="40%"><a id="COMAdminInstallForceOverwriteOfFile"></a><a
    ///               id="comadmininstallforceoverwriteoffile"></a><a id="COMADMININSTALLFORCEOVERWRITEOFFILE"></a><dl>
    ///               <dt><b>COMAdminInstallForceOverwriteOfFile</b></dt> <dt>2</dt> </dl> </td> <td width="60%"> Overwrite
    ///               existing files. </td> </tr> </table>
    ///    bstrUserID = The user ID under which to install the partition.
    ///    bstrPassword = The password for the specified user.
    ///    bstrRSN = The name of a remote server to use as a proxy.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT InstallPartition(BSTR bstrFileName, BSTR bstrDestDirectory, int lOptions, BSTR bstrUserID, 
                             BSTR bstrPassword, BSTR bstrRSN);
    ///Retrieves information about an application that is about to be installed.
    ///Params:
    ///    bstrApplicationFile = The full path to the application file.
    ///    ppFilesForImport = A pointer to an ICatalogCollection interface pointer that specifies the FilesForImport collection for the
    ///                       application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT QueryApplicationFile2(BSTR bstrApplicationFile, IDispatch* ppFilesForImport);
    ///Retrieves the number of partitions in which a specified component is installed.
    ///Params:
    ///    bstrCLSIDOrProgID = The class ID or program ID of the component.
    ///    plVersionCount = The number of different partitions in which the component is installed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetComponentVersionCount(BSTR bstrCLSIDOrProgID, int* plVersionCount);
}

///Represents items in collections on the COM+ catalog. <b>ICatalogObject</b> enables you to get and put properties
///exposed by objects in the catalog. The ICatalogCollection::Item method returns a pointer to <b>ICatalogObject</b>
///when it retrieves an item in the collection.
@GUID("6EB22871-8A19-11D0-81B6-00A0C9231C29")
interface ICatalogObject : IDispatch
{
    ///Accesses the value of the specified property exposed by this catalog object. This property is read/write.
    HRESULT get_Value(BSTR bstrPropName, VARIANT* pvarRetVal);
    ///Accesses the value of the specified property exposed by this catalog object. This property is read/write.
    HRESULT put_Value(BSTR bstrPropName, VARIANT val);
    ///Retrieves the key property of the object. This property is read-only.
    HRESULT get_Key(VARIANT* pvarRetVal);
    ///Retrieves the name property of the object. This property is read-only.
    HRESULT get_Name(VARIANT* pvarRetVal);
    ///Indicates whether the specified property can be modified using Value.
    ///Params:
    ///    bstrPropName = The name of the property to be modified.
    ///    pbRetVal = If this value is True, you cannot modify the property. Otherwise, you can modify the property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT IsPropertyReadOnly(BSTR bstrPropName, short* pbRetVal);
    ///Indicates whether all properties were successfully read from the catalog data store. This property is read-only.
    HRESULT get_Valid(short* pbRetVal);
    ///Indicates whether the specified property can be read using Value.
    ///Params:
    ///    bstrPropName = The name of the property to be read.
    ///    pbRetVal = If this value is True, you cannot read the property. Otherwise, you can read the property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT IsPropertyWriteOnly(BSTR bstrPropName, short* pbRetVal);
}

///Represents any collection in the COM+ catalog. <b>ICatalogCollection</b> enables you to enumerate, add, remove, and
///retrieve items in a collection and to access related collections.
@GUID("6EB22872-8A19-11D0-81B6-00A0C9231C29")
interface ICatalogCollection : IDispatch
{
    ///Retrieves an enumerator that can be used to iterate through the collection objects. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppEnumVariant);
    ///Retrieves the item that correspond to the specified index. This property is read-only.
    HRESULT get_Item(int lIndex, IDispatch* ppCatalogObject);
    ///Retrieves the number of items in the collection. This property is read-only.
    HRESULT get_Count(int* plObjectCount);
    ///Removes an item from the collection, given its index, and re-indexes the items with higher index values.
    ///Params:
    ///    lIndex = The zero-based index of the item to be removed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Remove(int lIndex);
    ///Adds an item to the collection, giving it the high index value.
    ///Params:
    ///    ppCatalogObject = A pointer to the ICatalogObject interface pointer for the new object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Add(IDispatch* ppCatalogObject);
    ///Populates the collection with data for all items contained in the collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS </b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT Populate();
    ///Saves all pending changes made to the collection and the items it contains to the COM+ catalog data store.
    ///Params:
    ///    pcChanges = The number of changes to the collection that are being attempted; if no changes are pending, the value is
    ///                zero. If some changes fail, this returned value does not reflect the failure; it is still the number of
    ///                changes attempted.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS </b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT SaveChanges(int* pcChanges);
    ///Retrieves a collection from the COM+ catalog that is related to the current collection.
    ///Params:
    ///    bstrCollName = The name of the collection to be retrieved.
    ///    varObjectKey = The Key property value of the parent item of the collection to be retrieved.
    ///    ppCatalogCollection = The ICatalogCollection interface for the retrieved collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCollection(BSTR bstrCollName, VARIANT varObjectKey, IDispatch* ppCatalogCollection);
    ///Retrieves the name of the collection. This property is read-only.
    HRESULT get_Name(VARIANT* pVarNamel);
    ///Indicates whether the Add method is enabled for the collection. This property is read-only.
    HRESULT get_AddEnabled(short* pVarBool);
    ///Indicates whether the Remove method is enabled for the collection. This property is read-only.
    HRESULT get_RemoveEnabled(short* pVarBool);
    ///<p class="CCE_Message">[This method is for use with MTS 2.0 administration interfaces and objects and should not
    ///be used with COM+ administration interfaces and objects. It works as before with MTS 2.0 administration
    ///interfaces and objects, with the exception of IRemoteComponentUtil, which is no longer supported.] Retrieves the
    ///utility interface for the collection.
    ///Params:
    ///    ppIDispatch = The utility interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS </b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT GetUtilInterface(IDispatch* ppIDispatch);
    ///Retrieves the major version number of the catalog data store. This property is read-only.
    HRESULT get_DataStoreMajorVersion(int* plMajorVersion);
    ///Retrieves the minor version number of the catalog data store. This property is read-only.
    HRESULT get_DataStoreMinorVersion(int* plMinorVersionl);
    ///Populates a selected list of items in the collection from the COM+ catalog, based on the specified keys.
    ///Params:
    ///    psaKeys = The Key property value of the objects for which data is to be read.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS </b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT PopulateByKey(SAFEARRAY* psaKeys);
    ///Reserved for future use.
    ///Params:
    ///    bstrQueryString = 
    ///    lQueryType = 
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_OBJECTERRORS </b></dt> </dl> </td> <td width="60%"> Errors
    ///    occurred while accessing one or more objects. </td> </tr> </table>
    ///    
    HRESULT PopulateByQuery(BSTR bstrQueryString, int lQueryType);
}

@GUID("0FB15084-AF41-11CE-BD2B-204C4F4F5020")
interface ITransaction : IUnknown
{
    HRESULT Commit(BOOL fRetaining, uint grfTC, uint grfRM);
    HRESULT Abort(BOID* pboidReason, BOOL fRetaining, BOOL fAsync);
    HRESULT GetTransactionInfo(XACTTRANSINFO* pinfo);
}

@GUID("02656950-2152-11D0-944C-00A0C905416E")
interface ITransactionCloner : ITransaction
{
    HRESULT CloneWithCommitDisabled(ITransaction* ppITransaction);
}

@GUID("34021548-0065-11D3-BAC1-00C04F797BE2")
interface ITransaction2 : ITransactionCloner
{
    HRESULT GetTransactionInfo2(XACTTRANSINFO* pinfo);
}

@GUID("3A6AD9E1-23B9-11CF-AD60-00AA00A74CCD")
interface ITransactionDispenser : IUnknown
{
    HRESULT GetOptionsObject(ITransactionOptions* ppOptions);
    HRESULT BeginTransaction(IUnknown punkOuter, int isoLevel, uint isoFlags, ITransactionOptions pOptions, 
                             ITransaction* ppTransaction);
}

@GUID("3A6AD9E0-23B9-11CF-AD60-00AA00A74CCD")
interface ITransactionOptions : IUnknown
{
    HRESULT SetOptions(XACTOPT* pOptions);
    HRESULT GetOptions(XACTOPT* pOptions);
}

@GUID("3A6AD9E2-23B9-11CF-AD60-00AA00A74CCD")
interface ITransactionOutcomeEvents : IUnknown
{
    HRESULT Committed(BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT Aborted(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW, HRESULT hr);
    HRESULT HeuristicDecision(uint dwDecision, BOID* pboidReason, HRESULT hr);
    HRESULT Indoubt();
}

@GUID("30274F88-6EE4-474E-9B95-7807BC9EF8CF")
interface ITmNodeName : IUnknown
{
    HRESULT GetNodeNameSize(uint* pcbNodeNameSize);
    HRESULT GetNodeName(uint cbNodeNameBufferSize, PWSTR pNodeNameBuffer);
}

@GUID("79427A2B-F895-40E0-BE79-B57DC82ED231")
interface IKernelTransaction : IUnknown
{
    HRESULT GetHandle(HANDLE* pHandle);
}

@GUID("69E971F0-23CE-11CF-AD60-00AA00A74CCD")
interface ITransactionResourceAsync : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

@GUID("C82BD532-5B30-11D3-8A91-00C04F79EB6D")
interface ITransactionLastResourceAsync : IUnknown
{
    HRESULT DelegateCommit(uint grfRM);
    HRESULT ForgetRequest(BOID* pNewUOW);
}

@GUID("EE5FF7B3-4572-11D0-9452-00A0C905416E")
interface ITransactionResource : IUnknown
{
    HRESULT PrepareRequest(BOOL fRetaining, uint grfRM, BOOL fWantMoniker, BOOL fSinglePhase);
    HRESULT CommitRequest(uint grfRM, BOID* pNewUOW);
    HRESULT AbortRequest(BOID* pboidReason, BOOL fRetaining, BOID* pNewUOW);
    HRESULT TMDown();
}

@GUID("0FB15081-AF41-11CE-BD2B-204C4F4F5020")
interface ITransactionEnlistmentAsync : IUnknown
{
    HRESULT PrepareRequestDone(HRESULT hr, IMoniker pmk, BOID* pboidReason);
    HRESULT CommitRequestDone(HRESULT hr);
    HRESULT AbortRequestDone(HRESULT hr);
}

@GUID("C82BD533-5B30-11D3-8A91-00C04F79EB6D")
interface ITransactionLastEnlistmentAsync : IUnknown
{
    HRESULT TransactionOutcome(XACTSTAT XactStat, BOID* pboidReason);
}

@GUID("E1CF9B53-8745-11CE-A9BA-00AA006C3706")
interface ITransactionExportFactory : IUnknown
{
    HRESULT GetRemoteClassId(GUID* pclsid);
    HRESULT Create(uint cbWhereabouts, ubyte* rgbWhereabouts, ITransactionExport* ppExport);
}

@GUID("0141FDA4-8FC0-11CE-BD18-204C4F4F5020")
interface ITransactionImportWhereabouts : IUnknown
{
    HRESULT GetWhereaboutsSize(uint* pcbWhereabouts);
    HRESULT GetWhereabouts(uint cbWhereabouts, ubyte* rgbWhereabouts, uint* pcbUsed);
}

@GUID("0141FDA5-8FC0-11CE-BD18-204C4F4F5020")
interface ITransactionExport : IUnknown
{
    HRESULT Export(IUnknown punkTransaction, uint* pcbTransactionCookie);
    HRESULT GetTransactionCookie(IUnknown punkTransaction, uint cbTransactionCookie, ubyte* rgbTransactionCookie, 
                                 uint* pcbUsed);
}

@GUID("E1CF9B5A-8745-11CE-A9BA-00AA006C3706")
interface ITransactionImport : IUnknown
{
    HRESULT Import(uint cbTransactionCookie, ubyte* rgbTransactionCookie, GUID* piid, void** ppvTransaction);
}

@GUID("17CF72D0-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipTransaction : IUnknown
{
    HRESULT Push(ubyte* i_pszRemoteTmUrl, PSTR* o_ppszRemoteTxUrl);
    HRESULT GetTransactionUrl(PSTR* o_ppszLocalTxUrl);
}

@GUID("17CF72D1-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipHelper : IUnknown
{
    HRESULT Pull(ubyte* i_pszTxUrl, ITransaction* o_ppITransaction);
    HRESULT PullAsync(ubyte* i_pszTxUrl, ITipPullSink i_pTipPullSink, ITransaction* o_ppITransaction);
    HRESULT GetLocalTmUrl(ubyte** o_ppszLocalTmUrl);
}

@GUID("17CF72D2-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipPullSink : IUnknown
{
    HRESULT PullComplete(HRESULT i_hrPull);
}

@GUID("9797C15D-A428-4291-87B6-0995031A678D")
interface IDtcNetworkAccessConfig : IUnknown
{
    HRESULT GetAnyNetworkAccess(BOOL* pbAnyNetworkAccess);
    HRESULT SetAnyNetworkAccess(BOOL bAnyNetworkAccess);
    HRESULT GetNetworkAdministrationAccess(BOOL* pbNetworkAdministrationAccess);
    HRESULT SetNetworkAdministrationAccess(BOOL bNetworkAdministrationAccess);
    HRESULT GetNetworkTransactionAccess(BOOL* pbNetworkTransactionAccess);
    HRESULT SetNetworkTransactionAccess(BOOL bNetworkTransactionAccess);
    HRESULT GetNetworkClientAccess(BOOL* pbNetworkClientAccess);
    HRESULT SetNetworkClientAccess(BOOL bNetworkClientAccess);
    HRESULT GetNetworkTIPAccess(BOOL* pbNetworkTIPAccess);
    HRESULT SetNetworkTIPAccess(BOOL bNetworkTIPAccess);
    HRESULT GetXAAccess(BOOL* pbXAAccess);
    HRESULT SetXAAccess(BOOL bXAAccess);
    HRESULT RestartDtcService();
}

@GUID("A7AA013B-EB7D-4F42-B41C-B2DEC09AE034")
interface IDtcNetworkAccessConfig2 : IDtcNetworkAccessConfig
{
    HRESULT GetNetworkInboundAccess(BOOL* pbInbound);
    HRESULT GetNetworkOutboundAccess(BOOL* pbOutbound);
    HRESULT SetNetworkInboundAccess(BOOL bInbound);
    HRESULT SetNetworkOutboundAccess(BOOL bOutbound);
    HRESULT GetAuthenticationLevel(AUTHENTICATION_LEVEL* pAuthLevel);
    HRESULT SetAuthenticationLevel(AUTHENTICATION_LEVEL AuthLevel);
}

@GUID("76E4B4F3-2CA5-466B-89D5-FD218EE75B49")
interface IDtcNetworkAccessConfig3 : IDtcNetworkAccessConfig2
{
    HRESULT GetLUAccess(BOOL* pbLUAccess);
    HRESULT SetLUAccess(BOOL bLUAccess);
}

@GUID("F3B1F131-EEDA-11CE-AED4-00AA0051E2C4")
interface IXATransLookup : IUnknown
{
    HRESULT Lookup(ITransaction* ppTransaction);
}

@GUID("BF193C85-0D1A-4290-B88F-D2CB8873D1E7")
interface IXATransLookup2 : IUnknown
{
    HRESULT Lookup(xid_t* pXID, ITransaction* ppTransaction);
}

@GUID("0D563181-DEFB-11CE-AED1-00AA0051E2C4")
interface IResourceManagerSink : IUnknown
{
    HRESULT TMDown();
}

///The <code>IResourceManager</code> interface resolves contentions for system resources. The filter graph manager
///exposes this interface. Filters can use this interface to request resources that other objects are likely to use. For
///example, audio renderers use this interface to resolve contentions for the wave-output device, to enable sound to
///follow focus. Applications will typically not use this interface. An object can use this interface to resolve
///possible contentions between existing resources. The object registers the resource with the interface and then
///requests it whenever needed. The object should notify the filter graph manager whenever the user focus changes. The
///filter graph manager can then switch contended resources to the objects that have the focus of the user. An object
///that uses this interface must implement the IResourceConsumer interface. <b>IResourceConsumer</b> provides a callback
///mechanism for the filter graph manager to notify the object when a resource becomes available, or when the object
///should release a resource that it acquired.
@GUID("13741D21-87EB-11CE-8081-0080C758527E")
interface IResourceManager : IUnknown
{
    HRESULT Enlist(ITransaction pTransaction, ITransactionResourceAsync pRes, BOID* pUOW, int* pisoLevel, 
                   ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist(ubyte* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
    HRESULT ReenlistmentComplete();
    HRESULT GetDistributedTransactionManager(const(GUID)* iid, void** ppvObject);
}

@GUID("4D964AD4-5B33-11D3-8A91-00C04F79EB6D")
interface ILastResourceManager : IUnknown
{
    HRESULT TransactionCommitted(ubyte* pPrepInfo, uint cbPrepInfo);
    HRESULT RecoveryDone();
}

@GUID("D136C69A-F749-11D1-8F47-00C04F8EE57D")
interface IResourceManager2 : IResourceManager
{
    HRESULT Enlist2(ITransaction pTransaction, ITransactionResourceAsync pResAsync, BOID* pUOW, int* pisoLevel, 
                    xid_t* pXid, ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist2(xid_t* pXid, uint dwTimeout, XACTSTAT* pXactStat);
}

@GUID("6F6DE620-B5DF-4F3E-9CFA-C8AEBD05172B")
interface IResourceManagerRejoinable : IResourceManager2
{
    HRESULT Rejoin(ubyte* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
}

@GUID("C8A6E3A1-9A8C-11CF-A308-00A0C905416E")
interface IXAConfig : IUnknown
{
    HRESULT Initialize(GUID clsidHelperDll);
    HRESULT Terminate();
}

@GUID("E793F6D1-F53D-11CF-A60D-00A0C905416E")
interface IRMHelper : IUnknown
{
    HRESULT RMCount(uint dwcTotalNumberOfRMs);
    HRESULT RMInfo(xa_switch_t* pXa_Switch, BOOL fCDeclCallingConv, byte* pszOpenString, byte* pszCloseString, 
                   GUID guidRMRecovery);
}

@GUID("E793F6D2-F53D-11CF-A60D-00A0C905416E")
interface IXAObtainRMInfo : IUnknown
{
    HRESULT ObtainRMInfo(IRMHelper pIRMHelper);
}

@GUID("13741D20-87EB-11CE-8081-0080C758527E")
interface IResourceManagerFactory : IUnknown
{
    HRESULT Create(GUID* pguidRM, byte* pszRMName, IResourceManagerSink pIResMgrSink, IResourceManager* ppResMgr);
}

@GUID("6B369C21-FBD2-11D1-8F47-00C04F8EE57D")
interface IResourceManagerFactory2 : IResourceManagerFactory
{
    HRESULT CreateEx(GUID* pguidRM, byte* pszRMName, IResourceManagerSink pIResMgrSink, const(GUID)* riidRequested, 
                     void** ppvResMgr);
}

@GUID("80C7BFD0-87EE-11CE-8081-0080C758527E")
interface IPrepareInfo : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(ubyte* pPrepInfo);
}

@GUID("5FAB2547-9779-11D1-B886-00C04FB9618A")
interface IPrepareInfo2 : IUnknown
{
    HRESULT GetPrepareInfoSize(uint* pcbPrepInfo);
    HRESULT GetPrepareInfo(uint cbPrepareInfo, ubyte* pPrepInfo);
}

@GUID("C23CC370-87EF-11CE-8081-0080C758527E")
interface IGetDispenser : IUnknown
{
    HRESULT GetDispenser(const(GUID)* iid, void** ppvObject);
}

@GUID("5433376C-414D-11D3-B206-00C04FC2F3EF")
interface ITransactionVoterBallotAsync2 : IUnknown
{
    HRESULT VoteRequestDone(HRESULT hr, BOID* pboidReason);
}

@GUID("5433376B-414D-11D3-B206-00C04FC2F3EF")
interface ITransactionVoterNotifyAsync2 : ITransactionOutcomeEvents
{
    HRESULT VoteRequest();
}

@GUID("5433376A-414D-11D3-B206-00C04FC2F3EF")
interface ITransactionVoterFactory2 : IUnknown
{
    HRESULT Create(ITransaction pTransaction, ITransactionVoterNotifyAsync2 pVoterNotify, 
                   ITransactionVoterBallotAsync2* ppVoterBallot);
}

@GUID("82DC88E1-A954-11D1-8F88-00600895E7D5")
interface ITransactionPhase0EnlistmentAsync : IUnknown
{
    HRESULT Enable();
    HRESULT WaitForEnlistment();
    HRESULT Phase0Done();
    HRESULT Unenlist();
    HRESULT GetTransaction(ITransaction* ppITransaction);
}

@GUID("EF081809-0C76-11D2-87A6-00C04F990F34")
interface ITransactionPhase0NotifyAsync : IUnknown
{
    HRESULT Phase0Request(BOOL fAbortingHint);
    HRESULT EnlistCompleted(HRESULT status);
}

@GUID("82DC88E0-A954-11D1-8F88-00600895E7D5")
interface ITransactionPhase0Factory : IUnknown
{
    HRESULT Create(ITransactionPhase0NotifyAsync pPhase0Notify, 
                   ITransactionPhase0EnlistmentAsync* ppPhase0Enlistment);
}

@GUID("59313E01-B36C-11CF-A539-00AA006887C3")
interface ITransactionTransmitter : IUnknown
{
    HRESULT Set(ITransaction pTransaction);
    HRESULT GetPropagationTokenSize(uint* pcbToken);
    HRESULT MarshalPropagationToken(uint cbToken, ubyte* rgbToken, uint* pcbUsed);
    HRESULT UnmarshalReturnToken(uint cbReturnToken, ubyte* rgbReturnToken);
    HRESULT Reset();
}

@GUID("59313E00-B36C-11CF-A539-00AA006887C3")
interface ITransactionTransmitterFactory : IUnknown
{
    HRESULT Create(ITransactionTransmitter* ppTransmitter);
}

@GUID("59313E03-B36C-11CF-A539-00AA006887C3")
interface ITransactionReceiver : IUnknown
{
    HRESULT UnmarshalPropagationToken(uint cbToken, ubyte* rgbToken, ITransaction* ppTransaction);
    HRESULT GetReturnTokenSize(uint* pcbReturnToken);
    HRESULT MarshalReturnToken(uint cbReturnToken, ubyte* rgbReturnToken, uint* pcbUsed);
    HRESULT Reset();
}

@GUID("59313E02-B36C-11CF-A539-00AA006887C3")
interface ITransactionReceiverFactory : IUnknown
{
    HRESULT Create(ITransactionReceiver* ppReceiver);
}

@GUID("4131E760-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuConfigure : IUnknown
{
    HRESULT Add(ubyte* pucLuPair, uint cbLuPair);
    HRESULT Delete(ubyte* pucLuPair, uint cbLuPair);
}

@GUID("AC2B8AD2-D6F0-11D0-B386-00A0C9083365")
interface IDtcLuRecovery : IUnknown
{
}

@GUID("4131E762-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, IDtcLuRecovery* ppRecovery);
}

@GUID("4131E765-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryInitiatedByDtcTransWork : IUnknown
{
    HRESULT GetLogNameSizes(uint* pcbOurLogName, uint* pcbRemoteLogName);
    HRESULT GetOurXln(_DtcLu_Xln* pXln, ubyte* pOurLogName, ubyte* pRemoteLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationFromOurXln(_DtcLu_Xln_Confirmation Confirmation);
    HRESULT HandleTheirXlnResponse(_DtcLu_Xln Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, uint dwProtocol, 
                                   _DtcLu_Xln_Confirmation* pConfirmation);
    HRESULT HandleErrorFromOurXln(_DtcLu_Xln_Error Error);
    HRESULT CheckForCompareStates(BOOL* fCompareStates);
    HRESULT GetOurTransIdSize(uint* pcbOurTransId);
    HRESULT GetOurCompareStates(ubyte* pOurTransId, _DtcLu_CompareState* pCompareState);
    HRESULT HandleTheirCompareStatesResponse(_DtcLu_CompareState CompareState, 
                                             _DtcLu_CompareStates_Confirmation* pConfirmation);
    HRESULT HandleErrorFromOurCompareStates(_DtcLu_CompareStates_Error Error);
    HRESULT ConversationLost();
    HRESULT GetRecoverySeqNum(int* plRecoverySeqNum);
    HRESULT ObsoleteRecoverySeqNum(int lNewRecoverySeqNum);
}

@GUID("4131E766-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryInitiatedByDtcStatusWork : IUnknown
{
    HRESULT HandleCheckLuStatus(int lRecoverySeqNum);
}

@GUID("4131E764-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryInitiatedByDtc : IUnknown
{
    HRESULT GetWork(_DtcLu_LocalRecovery_Work* pWork, void** ppv);
}

@GUID("AC2B8AD1-D6F0-11D0-B386-00A0C9083365")
interface IDtcLuRecoveryInitiatedByLuWork : IUnknown
{
    HRESULT HandleTheirXln(int lRecoverySeqNum, _DtcLu_Xln Xln, ubyte* pRemoteLogName, uint cbRemoteLogName, 
                           ubyte* pOurLogName, uint cbOurLogName, uint dwProtocol, _DtcLu_Xln_Response* pResponse);
    HRESULT GetOurLogNameSize(uint* pcbOurLogName);
    HRESULT GetOurXln(_DtcLu_Xln* pXln, ubyte* pOurLogName, uint* pdwProtocol);
    HRESULT HandleConfirmationOfOurXln(_DtcLu_Xln_Confirmation Confirmation);
    HRESULT HandleTheirCompareStates(ubyte* pRemoteTransId, uint cbRemoteTransId, _DtcLu_CompareState CompareState, 
                                     _DtcLu_CompareStates_Response* pResponse, _DtcLu_CompareState* pCompareState);
    HRESULT HandleConfirmationOfOurCompareStates(_DtcLu_CompareStates_Confirmation Confirmation);
    HRESULT HandleErrorFromOurCompareStates(_DtcLu_CompareStates_Error Error);
    HRESULT ConversationLost();
}

@GUID("4131E768-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryInitiatedByLu : IUnknown
{
    HRESULT GetObjectToHandleWorkFromLu(IDtcLuRecoveryInitiatedByLuWork* ppWork);
}

@GUID("4131E769-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRmEnlistment : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

@GUID("4131E770-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRmEnlistmentSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

@GUID("4131E771-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRmEnlistmentFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, ITransaction pITransaction, ubyte* pTransId, uint cbTransId, 
                   IDtcLuRmEnlistmentSink pRmEnlistmentSink, IDtcLuRmEnlistment* ppRmEnlistment);
}

@GUID("4131E773-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuSubordinateDtc : IUnknown
{
    HRESULT Unplug(BOOL fConversationLost);
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT Prepare();
    HRESULT RequestCommit();
}

@GUID("4131E774-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuSubordinateDtcSink : IUnknown
{
    HRESULT AckUnplug();
    HRESULT TmDown();
    HRESULT SessionLost();
    HRESULT BackedOut();
    HRESULT BackOut();
    HRESULT Committed();
    HRESULT Forget();
    HRESULT RequestCommit();
}

@GUID("4131E775-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuSubordinateDtcFactory : IUnknown
{
    HRESULT Create(ubyte* pucLuPair, uint cbLuPair, IUnknown punkTransactionOuter, int isoLevel, uint isoFlags, 
                   ITransactionOptions pOptions, ITransaction* ppTransaction, ubyte* pTransId, uint cbTransId, 
                   IDtcLuSubordinateDtcSink pSubordinateDtcSink, IDtcLuSubordinateDtc* ppSubordinateDtc);
}

///Provides access to a collection of security information representing a caller's identity. The items available in this
///collection are the SID, the account name, the authentication service, the authentication level, and the impersonation
///level. This interface is used to find out about a particular caller in a chain of callers that is part of the
///security call context. For more information about how security call context information is accessed, see Programmatic
///Component Security. COM+ applications that do not use role-based security and base COM applications cannot call
///methods of <b>ISecurityIdentityColl</b> because they cannot obtain the necessary pointer to ISecurityCallContext. For
///more information, see CoGetCallContext.
@GUID("CAFC823C-B441-11D1-B82B-0000F8757E2A")
interface ISecurityIdentityColl : IDispatch
{
    ///Retrieves the number of properties in the security identity collection.
    ///Params:
    ///    plCount = The number of properties in the security identity collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Count(int* plCount);
    ///Retrieves a specified property in the security identity collection.
    ///Params:
    ///    name = The name of the property to be retrieved. See Remarks for information about the available properties.
    ///    pItem = A reference to the retrieved property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    ///Retrieves an enumerator for the security identity collection.
    ///Params:
    ///    ppEnum = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

///Provides access to information about individual callers in a collection of callers. The collection represents the
///chain of calls ending with the current call, and each caller in the collection represents the identity of one caller.
///Only callers who cross a boundary where security is checked are included in the chain of callers. (In the COM+
///environment, security is checked at application boundaries.) Access to information about a particular caller's
///identity is provided through ISecurityIdentityColl, an identity collection.
@GUID("CAFC823D-B441-11D1-B82B-0000F8757E2A")
interface ISecurityCallersColl : IDispatch
{
    ///Retrieves the number of callers in the security callers collection.
    ///Params:
    ///    plCount = The number of callers in the security callers collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Count(int* plCount);
    ///Retrieves a specified caller in the security callers collection.
    ///Params:
    ///    lIndex = The name of the caller to retrieve. See Remarks for information about the available callers.
    ///    pObj = A reference to the retrieved caller.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Item(int lIndex, ISecurityIdentityColl* pObj);
    ///Retrieves an enumerator for the security callers collection.
    ///Params:
    ///    ppEnum = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

///Provides access to security methods and information about the security call context of the current call. COM+
///applications that use role-based security have access to the security call context property collection through this
///interface. You can obtain information about any caller in the chain of callers, as well as methods specific to COM+
///role-based security. For more information, see Programmatic Component Security.
@GUID("CAFC823E-B441-11D1-B82B-0000F8757E2A")
interface ISecurityCallContext : IDispatch
{
    ///Retrieves the number of properties in the security context collection.
    ///Params:
    ///    plCount = The number of named security call context properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Count(int* plCount);
    ///Retrieves a specified property in the security call context collection.
    ///Params:
    ///    name = The name of the property item to be retrieved. See Remarks for information about the available items.
    ///    pItem = A reference to the retrieved property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    ///Retrieves an enumerator for the security call context collection.
    ///Params:
    ///    ppEnum = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnum);
    ///Determines whether the direct caller is in the specified role.
    ///Params:
    ///    bstrRole = The name of the role.
    ///    pfInRole = <b>TRUE</b> if the caller is in the specified role; <b>FALSE</b> if not. If the specified role is not defined
    ///               for the application, <b>FALSE</b> is returned. This parameter is set to <b>TRUE</b> if role-based security is
    ///               not enabled.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i>
    ///    parameter is a recognized role, and the Boolean result returned in the <i>pfIsInRole</i> parameter indicates
    ///    whether the caller is in that role. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_ROLENOTFOUND</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i>
    ///    parameter does not exist. </td> </tr> </table>
    ///    
    HRESULT IsCallerInRole(BSTR bstrRole, short* pfInRole);
    ///Determines whether security is enabled for the object.
    ///Params:
    ///    pfIsEnabled = <b>TRUE</b> if the application uses role-based security and role checking is currently enabled for the
    ///                  object; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT IsSecurityEnabled(short* pfIsEnabled);
    ///Determines whether the specified user is in the specified role.
    ///Params:
    ///    pUser = A pointer to value holding the User ID of the user whose role membership is to be checked. If you intend to
    ///            pass the security identifier (SID) to <b>IsUserInRole</b>, this parameter should meet the following
    ///            requirements: <code>V_VT(pUser) == (VT_ARRAY|VT_UI1) &amp;&amp; V_ARRAY(pUser)-&gt;cDims == 1</code>.
    ///    bstrRole = The name of the role.
    ///    pfInRole = <b>TRUE</b> if the user is in the specified role; <b>FALSE</b> if not. If the specified role is not defined
    ///               for the application, <b>FALSE</b> is returned. This parameter is set to <b>TRUE</b> if role-based security is
    ///               not enabled.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i>
    ///    parameter is a recognized role, and the Boolean result returned in the <i>pfIsInRole</i> parameter indicates
    ///    whether the user is in that role. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_ROLENOTFOUND</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i>
    ///    parameter does not exist. </td> </tr> </table>
    ///    
    HRESULT IsUserInRole(VARIANT* pUser, BSTR bstrRole, short* pfInRole);
}

///Retrieves a reference to an object created from the SecurityCallContext class that is associated with the current
///call.
@GUID("CAFC823F-B441-11D1-B82B-0000F8757E2A")
interface IGetSecurityCallContext : IDispatch
{
    ///Retrieves a reference to an object created from the SecurityCallContext class that is associated with the current
    ///call. Instead of using this method, C++ developers should use the CoGetCallContext function, supplying
    ///IID_ISecurityCallContext for the <i>riid</i> parameter.
    ///Params:
    ///    ppObject = A reference to ISecurityCallContext on the object's context.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The current
    ///    object does not have a context associated with it because either the component wasn't imported into an
    ///    application or the object was not created with one of the COM+ CreateInstance methods. This error is also
    ///    returned if the GetObjectContext method was called from a constructor or from an IUnknown method. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetSecurityCallContext(ISecurityCallContext* ppObject);
}

///Retrieves information about the current object's original caller and direct caller. The preferred way to obtain
///information about an object's callers is to use the SecurityCallContext class instead of the <b>SecurityProperty</b>
///interface. <b>SecurityProperty</b> and ISecurityProperty provide the same functionality, but unlike
///<b>ISecurityProperty</b>, <b>SecurityProperty</b> is compatible with Automation.
@GUID("E74A7215-014D-11D1-A63C-00A0C911B4E0")
interface SecurityProperty : IDispatch
{
    ///Retrieves the user name associated with the external process that called the currently executing method.
    ///Params:
    ///    bstrUserName = A reference to the user name associated with the external process that called the currently executing method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetDirectCallerName(BSTR* bstrUserName);
    ///<p class="CCE_Message">[Do not use this method in COM+ applications because it was designed to be used only in
    ///MTS 2.0 applications.] Retrieves the user name associated with the current object's immediate (out-of-process)
    ///creator.
    ///Params:
    ///    bstrUserName = A reference to the user name associated with the current object's immediate (out-of-process) creator.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetDirectCreatorName(BSTR* bstrUserName);
    ///Retrieves the user name associated with the base process that initiated the sequence of calls from which the call
    ///into the current object originated.
    ///Params:
    ///    bstrUserName = A reference to the user name associated with the base process that initiated the sequence of calls from which
    ///                   the call into the current object originated.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetOriginalCallerName(BSTR* bstrUserName);
    ///<p class="CCE_Message">[Do not use this method in COM+ applications because it was designed to be used only in
    ///MTS 2.0 applications.] Retrieves the user name associated with the original base process that initiated the
    ///activity in which the current object is executing.
    ///Params:
    ///    bstrUserName = A reference to the user name associated with the original base process that initiated the activity in which
    ///                   the current object is executing.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetOriginalCreatorName(BSTR* bstrUserName);
}

///Retrieves transaction, activity, and context information on the current context object. Using the methods of this
///interface, you can retrieve relevant information contained within an object context. <b>ContextInfo</b> and
///IObjectContextInfo provide the same functionality, but unlike <b>IObjectContextInfo</b>, <b>ContextInfo</b> is
///compatible with Automation. In COM+ 1.5, released with Windows XP, the <b>ContextInfo</b> interface is superseded by
///the ContextInfo2 interface.
@GUID("19A5A02C-0AC8-11D2-B286-00C04F8EF934")
interface ContextInfo : IDispatch
{
    ///Indicates whether the current object is executing in a transaction.
    ///Params:
    ///    pbIsInTx = <b>TRUE</b> if the current object is executing within a transaction and <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT IsInTransaction(short* pbIsInTx);
    ///Retrieves the object context's transaction object.
    ///Params:
    ///    ppTx = A reference to the IUnknown interface of the transaction object for the currently executing transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The object is not
    ///    executing in a transaction. The <i>ppTx</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransaction(IUnknown* ppTx);
    ///Retrieves the transaction identifier associated with the object context. Objects in the same transaction share
    ///the same transaction identifier.
    ///Params:
    ///    pbstrTxId = A reference to the transaction identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOTRANSACTION</b></dt> </dl> </td> <td width="60%"> The
    ///    object is not executing within a transaction. </td> </tr> </table>
    ///    
    HRESULT GetTransactionId(BSTR* pbstrTxId);
    ///Retrieves the activity identifier associated with the object context.
    ///Params:
    ///    pbstrActivityId = A reference to the activity identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetActivityId(BSTR* pbstrActivityId);
    ///Retrieves the unique identifier of this object context.
    ///Params:
    ///    pbstrCtxId = A reference to the unique identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetContextId(BSTR* pbstrCtxId);
}

///Provides additional information about an object's context, supplementing the information that is available through
///the ContextInfo interface. <b>ContextInfo2</b> and IObjectContextInfo2 provide the same functionality, but unlike
///<b>IObjectContextInfo2</b>, <b>ContextInfo2</b> is compatible with Automation.
@GUID("C99D6E75-2375-11D4-8331-00C04F605588")
interface ContextInfo2 : ContextInfo
{
    ///Retrieves the GUID of the COM+ partition of the current object context.
    ///Params:
    ///    __MIDL__ContextInfo20000 = A reference to the partition identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_PARTITIONS_DISABLED</b></dt> </dl> </td> <td width="60%">
    ///    COM+ partitions are not enabled. </td> </tr> </table>
    ///    
    HRESULT GetPartitionId(BSTR* __MIDL__ContextInfo20000);
    ///Retrieves the GUID of the application of the current object context.
    ///Params:
    ///    __MIDL__ContextInfo20001 = A reference to the application identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetApplicationId(BSTR* __MIDL__ContextInfo20001);
    ///Retrieves the GUID of the application instance of the current object context. This information is useful when
    ///using COM+ Application Recycling, for example.
    ///Params:
    ///    __MIDL__ContextInfo20002 = A reference to the application instance identifier.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetApplicationInstanceId(BSTR* __MIDL__ContextInfo20002);
}

///Provides access to the current object's context. An object's context is primarily used when working with transactions
///or dealing with the security of an object. <b>ObjectContext</b> and IObjectContext provide the same functionality,
///but unlike <b>IObjectContext</b>, <b>ObjectContext</b> is compatible with Automation.
@GUID("74C08646-CEDB-11CF-8B49-00AA00B8A790")
interface ObjectContext : IDispatch
{
    ///Creates an object using current object's context. The object will have context only if its component is
    ///registered with COM+.
    ///Params:
    ///    bstrProgID = The ProgID of the type of object to be instantiated.
    ///    pObject = A reference to the new object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    CreateInstance using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT CreateInstance(BSTR bstrProgID, VARIANT* pObject);
    ///Declares that the transaction in which the object is executing can be committed and that the object should be
    ///deactivated on return.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    SetComplete using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT SetComplete();
    ///Declares that the transaction in which the object is executing must be aborted and that the object should be
    ///deactivated on return.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    SetAbort using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the object
    ///    that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT SetAbort();
    ///Declares that the current object's work is not necessarily finished but that its transactional updates are
    ///consistent and could be committed in their present form.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed succesfully and the object's
    ///    transactional updates can now be committed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred. This can happen
    ///    if one object passes its ObjectContext pointer to another object and the other object calls EnableCommit
    ///    using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the object that
    ///    originally obtained it. </td> </tr> </table>
    ///    
    HRESULT EnableCommit();
    ///Declares that the object's transactional updates are inconsistent and cannot be committed in their present state.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed succesfully. The object's
    ///    transactional updates cannot be committed until the object calls either EnableCommit or SetComplete. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected
    ///    error has occurred. This can happen if one object passes its ObjectContext pointer to another object and the
    ///    other object calls DisableCommit using this pointer. An <b>ObjectContext</b> pointer is not valid outside the
    ///    context of the object that originally obtained it. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The current object doesn't have a context
    ///    associated with it. This is probably because it was not created with one of the COM+ <b>CreateInstance</b>
    ///    methods. </td> </tr> </table>
    ///    
    HRESULT DisableCommit();
    ///Indicates whether the current object is executing in a transaction.
    ///Params:
    ///    pbIsInTx = <b>TRUE</b> if the current object is executing within a transaction; <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    IsInTransaction using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT IsInTransaction(short* pbIsInTx);
    ///Indicates whether security is enabled for the current object.
    ///Params:
    ///    pbIsEnabled = <b>TRUE</b> if security is enabled for this object; <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    IsSecurityEnabled using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT IsSecurityEnabled(short* pbIsEnabled);
    ///Indicates whether the object's direct caller is in a specified role (either directly or as part of a group).
    ///Params:
    ///    bstrRole = The name of the role.
    ///    pbInRole = <b>TRUE</b> if the caller is in the specified role; <b>FALSE</b> otherwise. This parameter is also set to
    ///               <b>TRUE</b> if security is not enabled.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i> parameter is a
    ///    recognized role, and the Boolean result returned in the <i>pbIsInRole</i> parameter indicates whether the
    ///    caller is in that role. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_ROLENOTFOUND</b></dt> </dl>
    ///    </td> <td width="60%"> The role specified in the bstrRole parameter does not exist. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred.
    ///    This can happen if one object passes its ObjectContext pointer to another object and the other object calls
    ///    IsCallerInRole using this pointer. An <b>ObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT IsCallerInRole(BSTR bstrRole, short* pbInRole);
    ///Retrieves the number of named context object properties.
    ///Params:
    ///    plCount = The number of named context object properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Count(int* plCount);
    ///Retrieves a named property.
    ///Params:
    ///    name = The name of the property to be retrieved.
    ///    pItem = A reference to the retrieved property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    ///Retrieves an enumerator for the named context object properties. This property is restricted in Microsoft Visual
    ///Basic and cannot be used.
    ///Params:
    ///    ppEnum = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* ppEnum);
    ///Retrieves the security object of the current object's context.
    ///Params:
    ///    ppSecurityProperty = A reference to a SecurityProperty interface that contains the security property of the current object's
    ///                         context.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Security(SecurityProperty* ppSecurityProperty);
    ///Retrieves the context information object of the current object's context.
    ///Params:
    ///    ppContextInfo = A reference to a ContextInfo interface that contains the context information.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_ContextInfo(ContextInfo* ppContextInfo);
}

///Provides basic methods for a generic transactional object that begins a transaction. By calling the methods of this
///interface, you can compose the work of multiple COM+ objects in a single transaction and explicitly commit or abort
///the transaction. ITransactionContext and <b>ITransactionContextEx</b> provide the same functionality, but unlike
///<b>ITransactionContextEx</b>, <b>ITransactionContext</b> is compatible with Automation.
@GUID("7999FC22-D3C6-11CF-ACAB-00A024A55AEF")
interface ITransactionContextEx : IUnknown
{
    ///Creates a COM object that can execute within the scope of the transaction that was initiated by the transaction
    ///context object.
    ///Params:
    ///    rclsid = A reference to the CLSID of the type of object to be instantiated.
    ///    riid = A reference to the interface ID of the interface through which you will communicate with the new object.
    ///    pObject = A reference to a new object of the type specified by the <i>rclsid</i> parameter, through the interface
    ///              specified by the <i>riid</i> parameter.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td width="60%"> The
    ///    component specified by <i>rclsid</i> is not registered as a COM component. </td> </tr> </table>
    ///    
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** pObject);
    ///Attempts to commit the work of all COM objects participating in the current transaction. The transaction ends on
    ///return from this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The transaction was committed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The TransactionContextEx object is not
    ///    running under a COM+ process, possibly indicating a corrupted registry entry for the
    ///    <b>TransactionContextEx</b> component. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_ABORTED</b></dt> </dl> </td> <td width="60%"> The transaction was aborted. </td> </tr>
    ///    </table>
    ///    
    HRESULT Commit();
    ///Aborts the work of all COM objects participating in the current transaction. The transaction ends on return from
    ///this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The transaction was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The TransactionContextEx object is not
    ///    running under a COM+ process, possibly indicating a corrupted registry entry for the
    ///    <b>TransactionContextEx</b> component. </td> </tr> </table>
    ///    
    HRESULT Abort();
}

///Enables you to compose the work of multiple COM+ objects in a single transaction and explicitly commit or abort the
///transaction. <b>ITransactionContext</b> and ITransactionContextEx provide the same functionality, but unlike
///<b>ITransactionContextEx</b>, <b>ITransactionContext</b> is compatible with Automation.
@GUID("7999FC21-D3C6-11CF-ACAB-00A024A55AEF")
interface ITransactionContext : IDispatch
{
    ///Creates a COM object that can execute within the scope of the transaction that was initiated by the transaction
    ///context object.
    ///Params:
    ///    pszProgId = A reference to the ProgID of the type of object to be instantiated.
    ///    pObject = A reference to the new object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CreateInstance(BSTR pszProgId, VARIANT* pObject);
    ///Attempts to commit the work of all COM objects participating in the current transaction. The transaction ends on
    ///return from this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The transaction was committed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The TransactionContext object is not
    ///    running under a COM+ process, possibly indicating a corrupted registry entry for the
    ///    <b>TransactionContext</b> component. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_ABORTED</b></dt>
    ///    </dl> </td> <td width="60%"> The transaction was aborted. </td> </tr> </table>
    ///    
    HRESULT Commit();
    ///Aborts the work of all COM objects participating in the current transaction. The transaction ends on return from
    ///this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The transaction was aborted. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The TransactionContext object is not
    ///    running under a COM+ process, possibly indicating a corrupted registry entry for the
    ///    <b>TransactionContext</b> component. </td> </tr> </table>
    ///    
    HRESULT Abort();
}

///Creates an object that is enlisted within a manual transaction.
@GUID("455ACF57-5345-11D2-99CF-00C04F797BC9")
interface ICreateWithTransactionEx : IUnknown
{
    ///Creates a COM+ object that executes within the scope of a manual transaction specified with a reference to an
    ///<b>ITransaction</b> interface.
    ///Params:
    ///    pTransaction = An <b>ITransaction</b> interface pointer indicating the transaction in which you want to create the COM+
    ///                   object.
    ///    rclsid = The CLSID of the type of object to instantiate.
    ///    riid = The ID of the interface to be returned by the <i>ppvObj</i> parameter.
    ///    pObject = A new object of the type specified by the <i>rclsid</i> argument through the interface specified by the
    ///              <i>riid</i> argument.
    ///Returns:
    ///    This method can return the following values:
    ///    
    HRESULT CreateInstance(ITransaction pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

///Creates a COM+ object that executes within the scope of the specified local transaction.
@GUID("227AC7A8-8423-42CE-B7CF-03061EC9AAA3")
interface ICreateWithLocalTransaction : IUnknown
{
    ///Creates a COM+ object that executes within the scope of the specified local transaction.
    ///Params:
    ///    pTransaction = The transaction in which the requested object participates.
    ///    rclsid = The CLSID of the class from which to create the requested object.
    ///    riid = A reference to the interface identifier (IID) of the interface that is used to communicate with the request
    ///           object.
    ///    pObject = The address of the pointer variable that receives the interface pointer specified with <i>riid</i>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT CreateInstanceWithSysTx(IUnknown pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

///<p class="CCE_Message">[The TIP service feature are deprecated and might not be available in future versions of the
///operating system. Consider using the WS-AtomicTransaction (WS-AT) protocol as a replacement transaction coordination
///and propagation technology. For more information about WS-AT support in the .Net Framework, see Transactions.]
///Creates an object that is enlisted within a manual transaction using the Transaction Internet Protocol (TIP).
@GUID("455ACF59-5345-11D2-99CF-00C04F797BC9")
interface ICreateWithTipTransactionEx : IUnknown
{
    ///<p class="CCE_Message">[The TIP service feature are deprecated and might not be available in future versions of
    ///the operating system. Consider using the WS-AtomicTransaction (WS-AT) protocol as a replacement transaction
    ///coordination and propagation technology. For more information about WS-AT support in the .Net Framework, see
    ///Transactions.] Creates a COM+ object that executes within the scope of the manual transaction specified by a TIP
    ///transaction URL.
    ///Params:
    ///    bstrTipUrl = The Transaction Internet Protocol (TIP) URL of the existing transaction in which you want to create the COM+
    ///                 object.
    ///    rclsid = The CLSID of the type of object to be instantiated.
    ///    riid = The ID of the interface to be returned by the <i>ppvObj</i> parameter.
    ///    pObject = A reference to a new object of the type specified by the <i>rclsid</i> argument, through the interface
    ///              specified by the <i>riid</i> argument.
    ///Returns:
    ///    This method can return the following values:
    ///    
    HRESULT CreateInstance(BSTR bstrTipUrl, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

///Notifies the subscriber of events that relate to COM+ transactions. The events are published to the subscriber using
///the COM+ Events service, a loosely coupled events system that stores event information from different publishers in
///an event store in the COM+ catalog.
@GUID("605CF82C-578E-4298-975D-82BABCD9E053")
interface IComLTxEvents : IUnknown
{
    ///Generated when a transaction is started. The event ID for this event is EID_LTXSTART.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidLtx = A GUID that identifies the transaction.
    ///    tsid = A GUID that identifies the COM+ transaction context.
    ///    fRoot = Indicates whether the COM+ transaction context is a root transaction context.
    ///    nIsolationLevel = The transaction isolation level of the root COM+ transactional context.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnLtxTransactionStart(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID tsid, BOOL fRoot, 
                                  int nIsolationLevel);
    ///Generated when COM+ receives a prepare notification for a transaction. The event ID for this event is
    ///EID_LTXPREPARE.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidLtx = A GUID that identifies the transaction.
    ///    fVote = The COM+ vote for the prepare request.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnLtxTransactionPrepare(COMSVCSEVENTINFO* pInfo, GUID guidLtx, BOOL fVote);
    ///Generated when a transaction is aborted. The event ID for this event is EID_LTXABORT.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidLtx = A GUID that identifies the transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnLtxTransactionAbort(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    ///Generated when a transaction is committed. The event ID for this event is EID_LTXCOMMIT.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidLtx = A GUID that identifies the transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnLtxTransactionCommit(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    ///Generated when a transaction is promoted. The event ID for this event is EID_LTXPROMOTE.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidLtx = A GUID that identifies the original transaction.
    ///    txnId = A GUID that identifies the promoted transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnLtxTransactionPromote(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID txnId);
}

///Notifies the subscriber of the specified user-defined metrics. The events are published to the subscriber using the
///COM+ Events service, a loosely coupled events system that stores event information from different publishers in an
///event store in the COM+ catalog.
@GUID("683130A4-2E50-11D2-98A5-00C04F8EE1C4")
interface IComUserEvent : IUnknown
{
    ///Provided for user components to generate user-defined events.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    pvarEvent = The user-defined information.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnUserEvent(COMSVCSEVENTINFO* pInfo, VARIANT* pvarEvent);
}

///Notifies the subscriber if a single-threaded apartment (STA) is created or terminated, and when an apartment thread
///is allocated. The subscriber is also notified if an activity is assigned or unassigned to an apartment thread. The
///events are published to the subscriber using the COM+ Events service, a loosely coupled events system that stores
///event information from different publishers in an event store in the COM+ catalog.
@GUID("683130A5-2E50-11D2-98A5-00C04F8EE1C4")
interface IComThreadEvents : IUnknown
{
    ///Generated when a single-threaded apartment (STA) thread is started.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ThreadID = The unique thread identifier.
    ///    dwThread = The Windows thread identifier.
    ///    dwTheadCnt = The number of threads in the STA thread pool.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadStart(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    ///Generated when a single-threaded apartment (STA) thread is terminated.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ThreadID = The unique thread identifier.
    ///    dwThread = The Windows thread identifier.
    ///    dwTheadCnt = The number of threads in the STA thread pool.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadTerminate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    ///Generated when an apartment thread is allocated for a single-thread apartment (STA) thread that does not have an
    ///apartment thread to run in. An apartment thread is created or allocated from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ThreadID = The unique thread identifier.
    ///    AptID = The apartment identifier.
    ///    dwActCnt = The number of activities bound to this apartment.
    ///    dwLowCnt = This parameter is reserved.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadBindToApartment(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt, 
                                    uint dwLowCnt);
    ///Generated when the lifetime of the configured component is over and the activity count on the apartment thread
    ///can be decremented.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ThreadID = The unique thread identifier.
    ///    AptID = The apartment identifier.
    ///    dwActCnt = The number of current activities on the apartment thread.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadUnBind(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt);
    HRESULT OnThreadWorkEnque(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkPrivate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID);
    HRESULT OnThreadWorkPublic(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkRedirect(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen, 
                                 ulong ThreadNum);
    HRESULT OnThreadWorkReject(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    ///Generated when an activity is assigned to an apartment thread.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity identifier for which the object is created.
    ///    AptID = The apartment identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadAssignApartment(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong AptID);
    ///Generated when an activity is unassigned from an apartment thread.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    AptID = The apartment identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnThreadUnassignApartment(COMSVCSEVENTINFO* pInfo, ulong AptID);
}

///Notifies the subscriber if a COM+ server application is started, shut down, or forced to shut down. The latter is
///initiated by the user calling a catalog method, such as ICOMAdminCatalog::ShutdownApplication, to shut down the
///server. The events are published to the subscriber using the COM+ Events service, a loosely coupled events (LCE)
///system that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("683130A6-2E50-11D2-98A5-00C04F8EE1C4")
interface IComAppEvents : IUnknown
{
    ///Generated when an application server starts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppActivation(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when an application server shuts down.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when an application server is forced to shut down. This is usually initiated by the user calling a
    ///catalog method, such as ICOMAdminCatalog::ShutdownApplication, to shut down the server.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppForceShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
}

///Notifies the subscriber of an object's creation or release. The events are published to the subscriber using the COM+
///Events service, a loosely coupled events system that stores event information from different publishers in an event
///store in the COM+ catalog.
@GUID("683130A7-2E50-11D2-98A5-00C04F8EE1C4")
interface IComInstanceEvents : IUnknown
{
    ///Generated when an object is created by a client.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The identifier of the activity in which the object is created.
    ///    clsid = The CLSID of the object being created.
    ///    tsid = The transaction stream identifier, which is unique for correlation to objects.
    ///    CtxtID = The context identifier for this object.
    ///    ObjectID = The initial just-in-time (JIT) activated object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                           const(GUID)* tsid, ulong CtxtID, ulong ObjectID);
    ///Generated when an object is released by a client.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The context identifier of the object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectDestroy(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

///Notifies the subscriber if the Microsoft Distributed Transaction Coordinator (DTC) transaction starts, commits, or
///aborts. The subscriber is also notified when the resource manager retrieves prepare information from the transaction
///manager. The events are published to the subscriber using the COM+ Events service, a loosely coupled events system
///that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("683130A8-2E50-11D2-98A5-00C04F8EE1C4")
interface IComTransactionEvents : IUnknown
{
    ///Generated when a Microsoft Distributed Transaction Coordinator (DTC) transaction starts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///    tsid = The transaction stream identifier; a unique identifier for correlation to objects.
    ///    fRoot = Indicates whether this is a root transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionStart(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot);
    ///Generated when the prepare phase of the two-phase commit protocol of the transaction is completed.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///    fVoteYes = The resource managers result concerning the outcome of the prepare phase.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionPrepare(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    ///Generated when a transaction aborts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionAbort(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    ///Generated when a transaction commits.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionCommit(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

///Notifies the subscriber if an object's method has been called, returned, or generated an exception. The events are
///published to the subscriber using the COM+ Events service, a loosely coupled events system that stores event
///information from different publishers in an event store in the COM+ catalog.
@GUID("683130A9-2E50-11D2-98A5-00C04F8EE1C4")
interface IComMethodEvents : IUnknown
{
    ///Generated when an object's method is called.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method being called.
    ///    iMeth = The v-table index of the method.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodCall(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                         uint iMeth);
    ///Generated when an object's method returns.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method.
    ///    iMeth = The v-table index of the method.
    ///    hresult = The result of the method call.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodReturn(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                           uint iMeth, HRESULT hresult);
    ///Generated when an object's method generates an exception.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method.
    ///    iMeth = The v-table index of the method.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodException(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                              uint iMeth);
}

///Notifies the subscriber if an instance of a just-in-time (JIT) activated object has been created or freed. The
///subscriber is notified if IObjectContext::DisableCommit, IObjectContext::EnableCommit, IObjectContext::SetComplete or
///IObjectContext::SetAbort is called. The events are published to the subscriber using the COM+ Events service, a
///loosely coupled events system that stores event information from different publishers in an event store in the COM+
///catalog.
@GUID("683130AA-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectEvents : IUnknown
{
    ///Generated when an object gets an instance of a new JIT-activated object.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The GUID of the current context.
    ///    ObjectID = The JIT-activated object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectActivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    ///Generated when the JIT-activated object is freed by SetComplete or SetAbort.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The GUID of the current context.
    ///    ObjectID = The JIT-activated object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectDeactivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    ///Generated when the client calls DisableCommit on a context.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The GUID of the current context.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnDisableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    ///Generated when the client calls EnableCommit on a context.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The GUID of the current context.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnEnableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    ///Generated when the client calls SetComplete on a context.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The GUID of the current context.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnSetComplete(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetAbort(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

///Notifies the subscriber if a resource is created, allocated, tracked, or destroyed. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("683130AB-2E50-11D2-98A5-00C04F8EE1C4")
interface IComResourceEvents : IUnknown
{
    ///Generated when a new resource is created and allocated.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjectID = The just-in-time activated object.
    ///    pszType = A description of the resource.
    ///    resId = The unique identifier of the resource.
    ///    enlisted = Indicates whether the resource is enlisted in a transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnResourceCreate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                             BOOL enlisted);
    ///Generated when an existing resource is allocated.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjectID = The just-in-time activated object.
    ///    pszType = A description of the resource.
    ///    resId = The unique identifier for the resource.
    ///    enlisted = Indicates whether the resource is enlisted in a transaction.
    ///    NumRated = The number of possible resources evaluated for a match.
    ///    Rating = The rating of the resource actually selected.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnResourceAllocate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                               BOOL enlisted, uint NumRated, uint Rating);
    ///Generated when an object is finished with a resource.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjectID = The just-in-time activated object.
    ///    pszType = A description of the resource.
    ///    resId = The unique identifier of the resource.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnResourceRecycle(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId);
    ///Generated when a resource is destroyed.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjectID = The just-in-time activated object.
    ///    hr = The result from resource dispensers destroy call.
    ///    pszType = A description of the resource.
    ///    resId = The unique identifier of the resource.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnResourceDestroy(COMSVCSEVENTINFO* pInfo, ulong ObjectID, HRESULT hr, const(PWSTR) pszType, 
                              ulong resId);
    ///Generated when a resource is tracked.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjectID = The just-in-time activated object.
    ///    pszType = A description of the resource.
    ///    resId = The unique identifier of the resource.
    ///    enlisted = Indicates whether the resource is enlisted in a transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnResourceTrack(COMSVCSEVENTINFO* pInfo, ulong ObjectID, const(PWSTR) pszType, ulong resId, 
                            BOOL enlisted);
}

///Notifies the subscriber if the authentication of a method call succeeded or failed. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("683130AC-2E50-11D2-98A5-00C04F8EE1C4")
interface IComSecurityEvents : IUnknown
{
    ///Generated when a method call level authentication succeeds. When you set an authentication level for an
    ///application, you determine what degree of authentication is performed when clients call into the application.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The identifier of the activity in which the object is created.
    ///    ObjectID = The just-in-time activated object.
    ///    guidIID = The IID of the method.
    ///    iMeth = The v-table index of the method.
    ///    cbByteOrig = The number of bytes in the security identifier for the original caller.
    ///    pSidOriginalUser = The security identifier for the original caller.
    ///    cbByteCur = The number of bytes in the security identifier for the current caller.
    ///    pSidCurrentUser = The security identifier for the current caller.
    ///    bCurrentUserInpersonatingInProc = Indicates whether the current user is impersonating.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAuthenticate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                           const(GUID)* guidIID, uint iMeth, uint cbByteOrig, ubyte* pSidOriginalUser, 
                           uint cbByteCur, ubyte* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
    ///Generated when a method call level authentication fails.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The identifier of the activity in which the object is created.
    ///    ObjectID = The just-in-time activated object.
    ///    guidIID = The IID of the method.
    ///    iMeth = The v-table index of the method.
    ///    cbByteOrig = The number of bytes in the security identifier for the original caller.
    ///    pSidOriginalUser = The security identifier for the original caller.
    ///    cbByteCur = The number of bytes in the security identifier for the current caller.
    ///    pSidCurrentUser = The security identifier for the current caller.
    ///    bCurrentUserInpersonatingInProc = Indicates whether the current user is impersonating.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAuthenticateFail(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                               const(GUID)* guidIID, uint iMeth, uint cbByteOrig, ubyte* pSidOriginalUser, 
                               uint cbByteCur, ubyte* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
}

///Notifies the subscriber when a new object is added to the pool. The subscriber is also notified when a transactional
///or non-transactional object is obtained or returned to the pool. The events are published to the subscriber using the
///COM+ Events service, a loosely coupled events system that stores event information from different publishers in an
///event store in the COM+ catalog.
@GUID("683130AD-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectPoolEvents : IUnknown
{
    ///Generated when a new object is added to the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    nReason = This parameter is always 0.
    ///    dwAvailable = The number of objects in the pool.
    ///    oid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolPutObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                               ulong oid);
    ///Generated when a non-transactional object is obtained from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    dwAvailable = The number of objects in the pool.
    ///    oid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolGetObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               uint dwAvailable, ulong oid);
    ///Generated when a transactional object is returned to the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    guidTx = The GUID representing the transaction identifier.
    ///    objid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolRecycleToTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                 const(GUID)* guidTx, ulong objid);
    ///Generated when a transactional object is obtained from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    guidTx = The transaction identifier.
    ///    objid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolGetFromTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               const(GUID)* guidTx, ulong objid);
}

///Notifies the subscriber when a new object is created for or removed from the pool. The subscriber is also notified
///when a new object pool is created or when the request for a pooled object times out. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("683130AE-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectPoolEvents2 : IUnknown
{
    ///Generated when an object is created for the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    dwObjsCreated = The number of objects in the pool.
    ///    oid = The unique pooled object identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolCreateObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    ///Generated when an object is permanently removed from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    dwObjsCreated = The number of objects in the pool.
    ///    oid = The unique pooled object identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolDestroyObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    ///Generated when a pool provides a requesting client with an existing object or creates a new one.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    dwThreadsWaiting = The number of threads waiting for an object.
    ///    dwAvail = The number of free objects in the pool.
    ///    dwCreated = The number of total objects in the pool.
    ///    dwMin = The pool's minimum object value.
    ///    dwMax = The pool's maximum object value.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolCreateDecision(COMSVCSEVENTINFO* pInfo, uint dwThreadsWaiting, uint dwAvail, uint dwCreated, 
                                    uint dwMin, uint dwMax);
    ///Generated when the request for a pooled object times out.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    guidActivity = The identifier of the activity in which the object is created.
    ///    dwTimeout = The pool's time-out value.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(GUID)* guidActivity, 
                             uint dwTimeout);
    ///Generated when a new pool is created.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    dwMin = The pool's minimum object value.
    ///    dwMax = The pool's maximum object value.
    ///    dwTimeout = The pool's time-out value.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolCreatePool(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwMin, uint dwMax, 
                                uint dwTimeout);
}

///Notifies the subscriber if a constructed object is created in an object pool. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog. A constructed object is derived from the IObjectConstruct
///interface. Constructed objects can inherit parameter names from within other objects or libraries.
@GUID("683130AF-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectConstructionEvents : IUnknown
{
    ///Generated when a constructed object is created.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    sConstructString = The object construction string.
    ///    oid = The unique constructed object identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectConstruct(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(PWSTR) sConstructString, 
                              ulong oid);
}

///Notifies the subscriber if an activity is created, destroyed, or timed out. The activity event is published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("683130B0-2E50-11D2-98A5-00C04F8EE1C4")
interface IComActivityEvents : IUnknown
{
    ///Generated when an activity starts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The GUID associated with the current activity.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    ///Generated when an activity is finished.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The GUID associated with the current activity.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityDestroy(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    ///Generated when an activity thread is entered.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidCurrent = The GUID associated with the caller.
    ///    guidEntered = The GUID associated with the activity thread entered.
    ///    dwThread = The identifier of the activity thread.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityEnter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                            uint dwThread);
    ///Generated when a call into an activity times out.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidCurrent = The GUID associated with the current activity.
    ///    guidEntered = The causality identifier for the caller.
    ///    dwThread = The identifier of the thread executing the call.
    ///    dwTimeout = The time-out period.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                              uint dwThread, uint dwTimeout);
    ///Generated when an activity thread is reentered recursively.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidCurrent = The GUID associated with the caller.
    ///    dwThread = The identifier of the activity thread.
    ///    dwCallDepth = The recursion depth.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityReenter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwThread, uint dwCallDepth);
    ///Generated when an activity thread is left.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidCurrent = The GUID associated with the caller.
    ///    guidLeft = The GUID associated with the activity thread left.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityLeave(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidLeft);
    ///Generated when an activity thread is left after being entered recursively.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidCurrent = The GUID associated with the caller.
    ///    dwCallDepth = The recursion depth.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnActivityLeaveSame(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwCallDepth);
}

///Notifies the subscriber about an activity that is part of an Internet Information Services (IIS) Active Server Pages
///(ASP) page. For example, if a COM+ object is invoked in an ASP page, the user would be notified of this activity. The
///events are published to the subscriber using the COM+ Events service, a loosely coupled events system that stores
///event information from different publishers in an event store in the COM+ catalog.
@GUID("683130B1-2E50-11D2-98A5-00C04F8EE1C4")
interface IComIdentityEvents : IUnknown
{
    ///Generated when an activity is part of an ASP page.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    ObjId = The unique identifier for this object.
    ///    pszClientIP = The Internet Protocol (IP) address of the IIS client.
    ///    pszServerIP = The IP address of the IIS server.
    ///    pszURL = The URL on IIS server generating object reference.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnIISRequestInfo(COMSVCSEVENTINFO* pInfo, ulong ObjId, const(PWSTR) pszClientIP, 
                             const(PWSTR) pszServerIP, const(PWSTR) pszURL);
}

///Notifies the subscriber if a queued message is created, de-queued, or moved to a retry or dead letter queue. The
///events are published to the subscriber using the COM+ Events service, a loosely coupled events system that stores
///event information from different publishers in an event store in the COM+ catalog.
@GUID("683130B2-2E50-11D2-98A5-00C04F8EE1C4")
interface IComQCEvents : IUnknown
{
    ///Generated when the queued components recorder creates the queued message.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    objid = The just-in-time activated object.
    ///    szQueue = The name of the queue.
    ///    guidMsgId = The unique identifier for the queued message.
    ///    guidWorkFlowId = This parameter is reserved.
    ///    msmqhr = The Message Queuing return status for the queued message.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCRecord(COMSVCSEVENTINFO* pInfo, ulong objid, ushort* szQueue, const(GUID)* guidMsgId, 
                       const(GUID)* guidWorkFlowId, HRESULT msmqhr);
    ///Generated when a queued components queue is opened. This method is used to generate the <i>QueueID</i> parameter.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    szQueue = The name of the queue.
    ///    QueueID = The unique identifier for the queue.
    ///    hr = The status from Message Queuing queue open.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCQueueOpen(COMSVCSEVENTINFO* pInfo, ushort* szQueue, ulong QueueID, HRESULT hr);
    ///Generated when a message is successfully de-queued even though the queued components service might find something
    ///wrong with the contents.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    QueueID = The unique identifier for the queue.
    ///    guidMsgId = The unique identifier for the queued message.
    ///    guidWorkFlowId = This parameter is reserved.
    ///    hr = The status from Queued Components processing of the received message.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCReceive(COMSVCSEVENTINFO* pInfo, ulong QueueID, const(GUID)* guidMsgId, 
                        const(GUID)* guidWorkFlowId, HRESULT hr);
    ///Generated when the receive message fails.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    QueueID = The unique identifier for the queue.
    ///    msmqhr = The status from Queued Components processing of the received message.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCReceiveFail(COMSVCSEVENTINFO* pInfo, ulong QueueID, HRESULT msmqhr);
    ///Generated when a message is moved to a queued components retry queue.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidMsgId = The unique identifier for the message.
    ///    guidWorkFlowId = This parameter is reserved.
    ///    RetryIndex = The index number of the retry queue where the message moved.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCMoveToReTryQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                                 uint RetryIndex);
    ///Generated when a message is moved to the dead letter queue and cannot be delivered.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidMsgId = The unique identifier for the message.
    ///    guidWorkFlowId = This parameter is reserved.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCMoveToDeadQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId);
    ///Generated when a messages contents are replayed.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    objid = The just-in-time activated object.
    ///    guidMsgId = The unique identifier for the queue.
    ///    guidWorkFlowId = This parameter is reserved.
    ///    hr = The status from Message Queuing receive message.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnQCPlayback(COMSVCSEVENTINFO* pInfo, ulong objid, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                         HRESULT hr);
}

///Notifies the subscriber when an unhandled exception occurs in the user's code. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("683130B3-2E50-11D2-98A5-00C04F8EE1C4")
interface IComExceptionEvents : IUnknown
{
    ///Generated for transactional components when an unhandled exception occurs in the user's code.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    code = The exception code.
    ///    address = The address of the exception.
    ///    pszStackTrace = The stack trace.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnExceptionUser(COMSVCSEVENTINFO* pInfo, uint code, ulong address, const(PWSTR) pszStackTrace);
}

@GUID("683130B4-2E50-11D2-98A5-00C04F8EE1C4")
interface ILBEvents : IUnknown
{
    HRESULT TargetUp(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT TargetDown(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT EngineDefined(BSTR bstrPropName, VARIANT* varPropValue, BSTR bstrClsidEng);
}

///Notifies the subscriber about activities of the Compensating Resource Manager (CRM) feature of Component Services.
///The events are published to the subscriber using the COM+ Events service, a loosely coupled events system that stores
///event information from different publishers in an event store in the COM+ catalog.
@GUID("683130B5-2E50-11D2-98A5-00C04F8EE1C4")
interface IComCRMEvents : IUnknown
{
    ///Generated when CRM recovery has started.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMRecoveryStart(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when CRM recovery is done.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMRecoveryDone(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when a CRM checkpoint occurs.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The globally unique identifier (GUID) of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMCheckpoint(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when a CRM clerk is starting, either due to a client registering a compensator or during recovery.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///    guidActivity = The activity identifier (NULL if recovery).
    ///    guidTx = The identifier of the Transaction Unit Of Work (UOW).
    ///    szProgIdCompensator = The ProgID of the CRM compensator.
    ///    szDescription = The description (blank if recovery).
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMBegin(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, GUID guidActivity, GUID guidTx, 
                       ushort* szProgIdCompensator, ushort* szDescription);
    ///Generated when CRM clerk receives a prepare notification to pass on to the CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMPrepare(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when CRM clerk receives a commit notification to pass on to the CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMCommit(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when CRM clerk receives an abort notification to pass on to the CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMAbort(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when CRM clerk receives an in-doubt notification to pass on to the CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMIndoubt(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when CRM clerk is done processing transaction outcome notifications.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMDone(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when the CRM clerk is finished and releases its resource locks.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMRelease(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when a CRM clerk receives a record during the analysis phase of recovery.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///    dwCrmRecordType = The CRM log record type (internal).
    ///    dwRecordSize = The log record size (approximate).
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMAnalyze(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, uint dwCrmRecordType, uint dwRecordSize);
    ///Generated when a CRM clerk receives a request to write a log record, either from the CRM worker or CRM
    ///compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///    fVariants = Indicates whether the log record is being written as a <b>Variant</b> array.
    ///    dwRecordSize = The log record size (approximate).
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMWrite(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
    ///Generated when a CRM clerk receives a request to forget a log record, either from the CRM worker or from the CRM
    ///compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMForget(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when a CRM clerk receives a request to force log records to disk, either from the CRM worker or from
    ///the CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMForce(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    ///Generated when a CRM clerk delivers a record to a CRM compensator.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidClerkCLSID = The identifier of the CRM clerk.
    ///    fVariants = Indicates whether the log record is being written as a <b>Variant</b> array.
    ///    dwRecordSize = The log record size (approximate).
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnCRMDeliver(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
}

///Notifies the subscriber if an object's method has been called, returned, or generated an exception. This interface
///extends the IComMethodEvents interface to provide thread information. The events are published to the subscriber
///using the COM+ Events service, a loosely coupled events system that stores event information from different
///publishers in an event store in the COM+ catalog.
@GUID("FB388AAA-567D-4024-AF8E-6E93EE748573")
interface IComMethod2Events : IUnknown
{
    ///Generated when an object's method is called.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method being called.
    ///    dwThread = The identifier of the thread executing the call.
    ///    iMeth = The v-table index of the method.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodCall2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                          uint dwThread, uint iMeth);
    ///Generated when an object's method returns.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method being called.
    ///    dwThread = The identifier of the thread executing the call.
    ///    iMeth = The v-table index of the method.
    ///    hresult = The result of the method call.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodReturn2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                            uint dwThread, uint iMeth, HRESULT hresult);
    ///Generated when an object's method generates an exception.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    oid = The just-in-time (JIT) activated object.
    ///    guidCid = The CLSID for the object being called.
    ///    guidRid = The identifier of the method being called.
    ///    dwThread = The identifier of the thread executing the call.
    ///    iMeth = The v-table index of the method.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnMethodException2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                               uint dwThread, uint iMeth);
}

///Notifies the subscriber when the tracking information for a collection changes. The events are published to the
///subscriber using the COM+ Events service, a loosely coupled events system that stores event information from
///different publishers in an event store in the COM+ catalog.
@GUID("4E6CDCC9-FB25-4FD5-9CC5-C9F4B6559CEC")
interface IComTrackingInfoEvents : IUnknown
{
    ///Generated when the tracking information for a collection changes.
    ///Params:
    ///    pToplevelCollection = A pointer to the IUnknown interface of the collection for which the tracking information has changed.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnNewTrackingInfo(IUnknown pToplevelCollection);
}

///Retrieves information about a tracking information collection.
@GUID("C266C677-C9AD-49AB-9FD9-D9661078588A")
interface IComTrackingInfoCollection : IUnknown
{
    ///Retrieves the type of a tracking information collection.
    ///Params:
    ///    pType = The type of tracking information. For a list of values, see the TRACKING_COLL_TYPE enumeration.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Type(TRACKING_COLL_TYPE* pType);
    ///Retrieves the number of objects in a tracking information collection.
    ///Params:
    ///    pCount = The number of objects in the tracking information collection.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Count(uint* pCount);
    ///Retrieves the specified interface from a specified member of a tracking information collection.
    ///Params:
    ///    ulIndex = The index of the object in the collection.
    ///    riid = The identifier of the interface to be requested.
    ///    ppv = A pointer to the requested interface.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Item(uint ulIndex, const(GUID)* riid, void** ppv);
}

///Retrieves the properties of a tracking information object.
@GUID("116E42C5-D8B1-47BF-AB1E-C895ED3E2372")
interface IComTrackingInfoObject : IUnknown
{
    ///Retrieves the value of the specified property.
    ///Params:
    ///    szPropertyName = The name of the property.
    ///    pvarOut = The value of the property.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetValue(PWSTR szPropertyName, VARIANT* pvarOut);
}

///Retrieves the total number of properties associated with a tracking information object and their names.
@GUID("789B42BE-6F6B-443A-898E-67ABF390AA14")
interface IComTrackingInfoProperties : IUnknown
{
    ///Retrieves the number of properties defined for a tracking information object.
    ///Params:
    ///    pCount = The number of properties defined for the object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PropCount(uint* pCount);
    ///Retrieves the name of the property corresponding to the specified index number.
    ///Params:
    ///    ulIndex = The index of the property.
    ///    ppszPropName = The name of the property.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPropName(uint ulIndex, PWSTR* ppszPropName);
}

///Notifies the subscriber if a COM+ server application is loaded, shut down, or paused. The subscriber is also notified
///if the application is marked for recycling. The events are published to the subscriber using the COM+ Events service,
///a loosely coupled events system that stores event information from different publishers in an event store in the COM+
///catalog.
@GUID("1290BC1A-B219-418D-B078-5934DED08242")
interface IComApp2Events : IUnknown
{
    ///Generated when the server application process is loaded.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The GUID of the application.
    ///    guidProcess = The process ID.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppActivation2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess);
    ///Generated when the server application shuts down.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The GUID of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when the server application is forced to shut down.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The GUID of the application.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppForceShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    ///Generated when the server application is paused or resumed to its initial state.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The GUID of the application.
    ///    bPaused = <b>TRUE</b> if the server application is paused. <b>FALSE</b> if the application has resumed to its original
    ///              state.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppPaused2(COMSVCSEVENTINFO* pInfo, GUID guidApp, BOOL bPaused);
    ///Generated when the server application process is marked for recycling termination.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidApp = The application ID.
    ///    guidProcess = The process ID.
    ///    lReason = The reason code that explains why a process was recycled. The following codes are defined. <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CRR_NO_REASON_SUPPLIED"></a><a
    ///              id="crr_no_reason_supplied"></a><dl> <dt><b>CRR_NO_REASON_SUPPLIED</b></dt> <dt>0x00000000</dt> </dl> </td>
    ///              <td width="60%"> The reason is not specified. </td> </tr> <tr> <td width="40%"><a
    ///              id="CRR_LIFETIME_LIMIT"></a><a id="crr_lifetime_limit"></a><dl> <dt><b>CRR_LIFETIME_LIMIT</b></dt>
    ///              <dt>xFFFFFFFF</dt> </dl> </td> <td width="60%"> The specified number of minutes that an application runs
    ///              before recycling was reached. </td> </tr> <tr> <td width="40%"><a id="CRR_ACTIVATION_LIMIT"></a><a
    ///              id="crr_activation_limit"></a><dl> <dt><b>CRR_ACTIVATION_LIMIT</b></dt> <dt>0xFFFFFFFE</dt> </dl> </td> <td
    ///              width="60%"> The specified number of activations was reached. </td> </tr> <tr> <td width="40%"><a
    ///              id="CRR_CALL_LIMIT"></a><a id="crr_call_limit"></a><dl> <dt><b>CRR_CALL_LIMIT</b></dt> <dt>0xFFFFFFFD</dt>
    ///              </dl> </td> <td width="60%"> The specified number of calls to configured objects in the application was
    ///              reached. </td> </tr> <tr> <td width="40%"><a id="CRR_MEMORY_LIMIT"></a><a id="crr_memory_limit"></a><dl>
    ///              <dt><b>CRR_MEMORY_LIMIT</b></dt> <dt>0xFFFFFFFC</dt> </dl> </td> <td width="60%"> The specified memory usage
    ///              that a process cannot exceed was reached. </td> </tr> <tr> <td width="40%"><a
    ///              id="CRR_RECYCLED_FROM_UI"></a><a id="crr_recycled_from_ui"></a><dl> <dt><b>CRR_RECYCLED_FROM_UI</b></dt>
    ///              <dt>xFFFFFFFB</dt> </dl> </td> <td width="60%"> An administrator decided to recycle the process through the
    ///              Component Services administration tool. </td> </tr> </table>
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnAppRecycle2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess, int lReason);
}

///Notifies the subscriber if a Microsoft Distributed Transaction Coordinator (DTC) transaction starts, commits, or
///aborts. The subscriber is also notified when the transaction is in the prepare phase of the two-phase commit
///protocol. The events are published to the subscriber using the COM+ Events service, a loosely coupled events system
///that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("A136F62A-2F94-4288-86E0-D8A1FA4C0299")
interface IComTransaction2Events : IUnknown
{
    ///Generated when a Microsoft Distributed Transaction Coordinator (DTC) transaction starts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///    tsid = The transaction stream identifier for the correlation to objects.
    ///    fRoot = Indicates whether the transaction is a root transaction.
    ///    nIsolationLevel = The isolation level of the transaction.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionStart2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot, 
                                int nIsolationLevel);
    ///Generated when the transaction is in the prepare phase of the commit protocol.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///    fVoteYes = The resource manager's result concerning the outcome of the prepare phase.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionPrepare2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    ///Generated when a transaction aborts.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionAbort2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    ///Generated when a transaction commits.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidTx = The transaction identifier.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnTransactionCommit2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

///Notifies the subscriber if an object is created or released by a client. The events are published to the subscriber
///using the COM+ Events service, a loosely coupled events system that stores event information from different
///publishers in an event store in the COM+ catalog.
@GUID("20E3BF07-B506-4AD5-A50C-D2CA5B9C158E")
interface IComInstance2Events : IUnknown
{
    ///Generated when a client creates an object.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The identifier of the activity in which the object is created.
    ///    clsid = The CLSID of the object being created.
    ///    tsid = The transaction stream identifier, which is unique for correlation to objects.
    ///    CtxtID = The context identifier for this object.
    ///    ObjectID = The initial JIT-activated object.
    ///    guidPartition = The partition identifier for which this instance is created.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectCreate2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                            const(GUID)* tsid, ulong CtxtID, ulong ObjectID, const(GUID)* guidPartition);
    ///Generated when a client releases an object.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    CtxtID = The context identifier of the object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectDestroy2(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

///Notifies the subscriber if a transactional or non-transactional object is added to or obtained from the object pool.
///The events are published to the subscriber using the COM+ Events service, a loosely coupled events system that stores
///event information from different publishers in an event store in the COM+ catalog.
@GUID("65BF6534-85EA-4F64-8CF4-3D974B2AB1CF")
interface IComObjectPool2Events : IUnknown
{
    ///Generated when an object is added to the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    nReason = This parameter is reserved.
    ///    dwAvailable = The number of objects in the pool.
    ///    oid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolPutObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                                ulong oid);
    ///Generated when a non-transactional object is obtained from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    dwAvailable = The number of objects in the pool.
    ///    oid = The unique identifier for this object.
    ///    guidPartition = The partition identifier for this instance.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolGetObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                uint dwAvailable, ulong oid, const(GUID)* guidPartition);
    ///Generated when a transactional object is returned to the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    guidTx = The transaction identifier.
    ///    objid = The unique identifier for this object.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolRecycleToTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                  const(GUID)* guidTx, ulong objid);
    ///Generated when a transactional object is obtained from the pool.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidActivity = The activity ID for which the object is created.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    guidTx = The GUID representing the transaction identifier.
    ///    objid = The unique identifier for this object.
    ///    guidPartition = The partition identifier for this instance.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjPoolGetFromTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                const(GUID)* guidTx, ulong objid, const(GUID)* guidPartition);
}

///Notifies the subscriber if a constructed object is created. The events are published to the subscriber using the COM+
///Events service, a loosely coupled events system that stores event information from different publishers in an event
///store in the COM+ catalog. A constructed object is derived from the IObjectConstruct interface. Constructed objects
///can inherit parameter names from within other objects or libraries.
@GUID("4B5A7827-8DF2-45C0-8F6F-57EA1F856A9F")
interface IComObjectConstruction2Events : IUnknown
{
    ///Generated when a constructed object is created.
    ///Params:
    ///    pInfo = A pointer to a COMSVCSEVENTINFO structure.
    ///    guidObject = The CLSID for the objects in the pool.
    ///    sConstructString = The object construction string.
    ///    oid = The unique constructed object identifier.
    ///    guidPartition = The partition identifier for which this instance is created.
    ///Returns:
    ///    The user verifies the return values from this method.
    ///    
    HRESULT OnObjectConstruct2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(PWSTR) sConstructString, 
                               ulong oid, const(GUID)* guidPartition);
}

///Notifies the subscriber when a COM+ application instance is created or reconfigured. The application event is
///published to the subscriber by using the COM+ Events service, a loosely coupled events system that stores event
///information from different publishers in an event store in the COM+ catalog.
@GUID("D6D48A3C-D5C5-49E7-8C74-99E4889ED52F")
interface ISystemAppEventData : IUnknown
{
    ///Invoked when a COM+ application instance is created.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Startup();
    ///Generated when the configuration of a COM+ application instance is changed.
    ///Params:
    ///    dwPID = The process identifier of the application instance for which the configuration was changed.
    ///    dwMask = The event mask used to determine which tracing event fires.
    ///    dwNumberSinks = Always set equal to SinkType::NUMBER_SINKS.
    ///    bstrDwMethodMask = The event mask used to determine to which events the user has subscribed.
    ///    dwReason = Always set equal to INFO_MASKCHANGED.
    ///    u64TraceHandle = A handle to the relevant tracing session.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT OnDataChanged(uint dwPID, uint dwMask, uint dwNumberSinks, BSTR bstrDwMethodMask, uint dwReason, 
                          ulong u64TraceHandle);
}

///Provides methods for obtaining information about the running package and establishing event sinks. The events are
///published to the subscriber using the COM+ Events service, a loosely coupled events system that stores event
///information from different publishers in an event store in the COM+ catalog.
@GUID("BACEDF4D-74AB-11D0-B162-00AA00BA3258")
interface IMtsEvents : IDispatch
{
    ///Retrieves the name of the package in which the instance of the object that implements the IMtsEvents interface is
    ///running.
    ///Params:
    ///    pVal = A pointer to the package name string.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_PackageName(BSTR* pVal);
    ///Retrieves the globally unique identifier (GUID) for the package in which the event occurred.
    ///Params:
    ///    pVal = A pointer to the package GUID.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_PackageGuid(BSTR* pVal);
    ///Posts a user-defined event to an event sink.
    ///Params:
    ///    vEvent = A pointer to the name of the event.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT PostEvent(VARIANT* vEvent);
    ///Retrieves whether events are enabled or disabled for an event sink.
    ///Params:
    ///    pVal = Indicates whether events are enabled or disabled for an event sink.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_FireEvents(short* pVal);
    ///Retrieves the identifier of the process in which the event occurred.
    ///Params:
    ///    id = A pointer to the process identification for the event.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT GetProcessID(int* id);
}

///Describes user-defined events. The events are published to the subscriber using the COM+ Events service, a loosely
///coupled events system that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("D56C3DC1-8482-11D0-B170-00AA00BA3258")
interface IMtsEventInfo : IDispatch
{
    ///Retrieves an enumerator for the names of the data values.
    ///Params:
    ///    pUnk = An interface pointer to the enumerator.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_Names(IUnknown* pUnk);
    ///Retrieves the display name of the object.
    ///Params:
    ///    sDisplayName = The display name of the object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_DisplayName(BSTR* sDisplayName);
    ///Retrieves the event identifier of the object.
    ///Params:
    ///    sGuidEventID = The event identifier of the object. This is a GUID converted to a string.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_EventID(BSTR* sGuidEventID);
    ///Retrieves the number of data values from the object.
    ///Params:
    ///    lCount = The number of data values from the object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_Count(int* lCount);
    ///Retrieves the value of the specified user-defined event.
    ///Params:
    ///    sKey = The name or ordinal of the value.
    ///    pVal = The value of the user-defined event.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_Value(BSTR sKey, VARIANT* pVal);
}

///Describes a single event that provides access to the IMtsEvents interface of the event dispatcher for the current
///process. The events are published to the subscriber using the COM+ Events service, a loosely coupled events system
///that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("D19B8BFD-7F88-11D0-B16E-00AA00BA3258")
interface IMTSLocator : IDispatch
{
    ///Retrieves a pointer to the event dispatcher for the current process.
    ///Params:
    ///    pUnk = A pointer to the IUnknown interface of the event dispatcher for the current process.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT GetEventDispatcher(IUnknown* pUnk);
}

///Provides methods for enumerating through running packages. The events are published to the subscriber using the COM+
///Events service, a loosely coupled events system that stores event information from different publishers in an event
///store in the COM+ catalog.
@GUID("4B2E958C-0393-11D1-B1AB-00AA00BA3258")
interface IMtsGrp : IDispatch
{
    ///Retrieves the number of running packages in the catalog.
    ///Params:
    ///    pVal = The number of running packages.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT get_Count(int* pVal);
    ///Retrieves the IUnknown pointer for the specified package.
    ///Params:
    ///    lIndex = The index containing running packages.
    ///    ppUnkDispatcher = A pointer to an IUnknown interface pointer, which can be used to access IMtsEvents.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT Item(int lIndex, IUnknown* ppUnkDispatcher);
    ///Updates the list of IUnknown pointers that was populated upon the creation of the object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT Refresh();
}

///Moves messages from one queue to another queue.
@GUID("588A085A-B795-11D1-8054-00C04FC340EE")
interface IMessageMover : IDispatch
{
    ///Retrieves the current path of the source (input) queue.
    ///Params:
    ///    pVal = The path.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_SourcePath(BSTR* pVal);
    ///Sets the path of the source (input) queue.
    ///Params:
    ///    newVal = The path.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_SourcePath(BSTR newVal);
    ///Retrieves the path of the destination (output) queue.
    ///Params:
    ///    pVal = The path.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_DestPath(BSTR* pVal);
    ///Sets the path of the destination (output) queue.
    ///Params:
    ///    newVal = The path.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_DestPath(BSTR newVal);
    ///Retrieves the commit batch size.
    ///Params:
    ///    pVal = The commit batch size.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_CommitBatchSize(int* pVal);
    ///Sets the commit batch size. This is the number of messages that should be moved from source to destination queue
    ///between commit operations.
    ///Params:
    ///    newVal = The commit batch size.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_CommitBatchSize(int newVal);
    ///Moves all messages from the source queue to the destination queue.
    ///Params:
    ///    plMessagesMoved = The number of messages that were moved from the source to the destination queue.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveMessages(int* plMessagesMoved);
}

@GUID("9A9F12B8-80AF-47AB-A579-35EA57725370")
interface IEventServerTrace : IDispatch
{
    HRESULT StartTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT StopTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT EnumTraceGuid(int* plCntGuids, BSTR* pbstrGuidList);
}

///Enables administrative applications to retrieve statistical information about running COM+ applications.
@GUID("507C3AC8-3E12-4CB0-9366-653D3E050638")
interface IGetAppTrackerData : IUnknown
{
    ///Retrieves summary information for all processes that are hosting COM+ applications, or for a specified subset of
    ///these processes.
    ///Params:
    ///    PartitionId = A partition ID to filter results, or GUID_NULL for all partitions.
    ///    ApplicationId = An application ID to filter results, or GUID_NULL for all applications.
    ///    Flags = A combination of flags from the GetAppTrackerDataFlags enumeration to filter results and to select which data
    ///            is returned. The following flags are supported: GATD_INCLUDE_PROCESS_EXE_NAME, GATD_INCLUDE_LIBRARY_APPS,
    ///            GATD_INCLUDE_SWC. See remarks below for more information.
    ///    NumApplicationProcesses = On return, the number of processes that match the filter criteria specified by <i>PartitionId</i>,
    ///                              <i>ApplicationId</i>, and <i>Flags</i>.
    ///    ApplicationProcesses = On return, an array of ApplicationProcessSummary structures for the matching processes.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully and the results are in
    ///    the <i>ApplicationProcesses</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt>
    ///    </dl> </td> <td width="60%"> The method completed successfully, but there were no processes the matched the
    ///    filter criteria. </td> </tr> </table>
    ///    
    HRESULT GetApplicationProcesses(const(GUID)* PartitionId, const(GUID)* ApplicationId, uint Flags, 
                                    uint* NumApplicationProcesses, ApplicationProcessSummary** ApplicationProcesses);
    ///Retrieves detailed information about a single process hosting COM+ applications.
    ///Params:
    ///    ApplicationInstanceId = The application instance GUID that uniquely identifies the tracked process to select, or GUID_NULL if the
    ///                            <i>ProcessId</i> parameter will be used for selection instead.
    ///    ProcessId = The process ID that identifies the process to select, or 0 if the <i>ApplicationInstanceId</i> parameter will
    ///                be used for selection instead.
    ///    Flags = A combination of flags from the GetAppTrackerDataFlags enumeration that specify which data is to be returned.
    ///            The following flags are supported: GATD_INCLUDE_PROCESS_EXE_NAME (if retrieving a summary).
    ///    Summary = On return, a ApplicationProcessSummary structure with summary information for the process. This parameter can
    ///              be <b>NULL</b>.
    ///    Statistics = On return, a ApplicationProcessStatistics structure with statistics for the process. This parameter can be
    ///                 <b>NULL</b>.
    ///    RecycleInfo = On return, a ApplicationProcessRecycleInfo structure with recycling details for the process. This parameter
    ///                  can be <b>NULL</b>.
    ///    AnyComponentsHangMonitored = On return, indicates whether any components in the process are configured for hang monitoring. This parameter
    ///                                 can be <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>COMADMIN_E_APP_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The specified
    ///    process does not exist, or is not hosting any tracked COM+ applications. </td> </tr> </table>
    ///    
    HRESULT GetApplicationProcessDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, uint Flags, 
                                         ApplicationProcessSummary* Summary, 
                                         ApplicationProcessStatistics* Statistics, 
                                         ApplicationProcessRecycleInfo* RecycleInfo, 
                                         BOOL* AnyComponentsHangMonitored);
    ///Retrieves summary information for all COM+ applications hosted in a single process, or for a specified subset of
    ///these applications.
    ///Params:
    ///    ApplicationInstanceId = The application instance GUID that uniquely identifies the tracked process to select, or GUID_NULL if the
    ///                            <i>ProcessId</i> parameter will be used for selection instead.
    ///    ProcessId = The process ID that identifies the process to select, or 0 if <i>ApplicationInstanceId</i> will be used for
    ///                selection instead.
    ///    PartitionId = A partition ID to filter results, or GUID_NULL for all partitions.
    ///    Flags = A combination of flags from the GetAppTrackerDataFlags enumeration to filter results and to select which data
    ///            is returned. The following flags are supported: GATD_INCLUDE_LIBRARY_APPS, GATD_INCLUDE_SWC,
    ///            GATD_INCLUDE_APPLICATION_NAME. See Remarks below for more information.
    ///    NumApplicationsInProcess = On return, the number of applications in the process that match the filter criteria specified by
    ///                               <i>PartitionId</i> and <i>Flags</i>.
    ///    Applications = On return, an array of ApplicationSummary structures for the matching applications.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully and the results are in
    ///    the <i>Applications</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> The method completed successfully, but there were no processes the matched the filter
    ///    criteria. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_APP_NOT_RUNNING</b></dt> </dl> </td> <td
    ///    width="60%"> The specified process does not exist, or is not hosting any tracked COM+ applications. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetApplicationsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                     uint Flags, uint* NumApplicationsInProcess, ApplicationSummary** Applications);
    ///Retrieves summary information for all COM+ components hosted in a single process, or for a specified subset of
    ///these components.
    ///Params:
    ///    ApplicationInstanceId = The application instance GUID that uniquely identifies the tracked process to select, or GUID_NULL if the
    ///                            <i>ProcessId</i> parameter will be used for selection instead.
    ///    ProcessId = The process ID that identifies the process to select, or 0 if the <i>ApplicationInstanceId</i> parameter will
    ///                be used for selection instead.
    ///    PartitionId = A partition ID to filter results, or GUID_NULL for all partitions.
    ///    ApplicationId = An application ID to filter results, or GUID_NULL for all applications.
    ///    Flags = A combination of flags from the GetAppTrackerDataFlags enumeration to filter results and to select which data
    ///            is returned. The following flags are supported: GATD_INCLUDE_LIBRARY_APPS, GATD_INCLUDE_SWC,
    ///            GATD_INCLUDE_CLASS_NAME, GATD_INCLUDE_APPLICATION_NAME. See Remarks below for more information.
    ///    NumComponentsInProcess = On return, the number of components in the process that match the filter criteria specified by
    ///                             <i>PartitionId</i>, <i>ApplicationId</i>, and <i>Flags</i>.
    ///    Components = On return, an array of ComponentSummary structures for the matching components.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully and the results are in
    ///    the <i>Components</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td>
    ///    <td width="60%"> The method completed successfully, but there were no components the matched the filter
    ///    criteria. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_APP_NOT_RUNNING</b></dt> </dl> </td> <td
    ///    width="60%"> The specified process does not exist, or is not hosting any tracked COM+ applications. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetComponentsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                   const(GUID)* ApplicationId, uint Flags, uint* NumComponentsInProcess, 
                                   ComponentSummary** Components);
    ///Retrieves detailed information about a single COM+ component hosted in a process.
    ///Params:
    ///    ApplicationInstanceId = The application instance GUID that uniquely identifies the tracked process to select, or GUID_NULL if the
    ///                            <i>ProcessId</i> parameter will be used for selection instead.
    ///    ProcessId = The process ID that identifies the process to select, or 0 if <i>ApplicationInstanceId</i> will be used for
    ///                selection instead.
    ///    Clsid = The CLSID of the component.
    ///    Flags = A combination of flags from the GetAppTrackerDataFlags enumeration to select which data is returned. The
    ///            following flags are supported: GATD_INCLUDE_CLASS_NAME (if retrieving a summary),
    ///            GATD_INCLUDE_APPLICATION_NAME (if retrieving a summary).
    ///    Summary = On return, a ComponentSummary structure with summary information for the component. This parameter can be
    ///              <b>NULL</b>.
    ///    Statistics = On return, a ComponentStatistics structure with statistics for the component. This parameter can be
    ///                 <b>NULL</b>.
    ///    HangMonitorInfo = On return, a ComponentHangMonitorInfo structure with hang monitoring configuration for the component. This
    ///                      parameter can be <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>COMADMIN_E_APP_NOT_RUNNING</b></dt> </dl> </td> <td width="60%"> The specified
    ///    process does not exist, or is not hosting any tracked COM+ applications. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>COMADMIN_E_OBJECT_DOES_NOT_EXIST</b></dt> </dl> </td> <td width="60%"> The specified component
    ///    does not exist in the specified process. </td> </tr> </table>
    ///    
    HRESULT GetComponentDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* Clsid, uint Flags, 
                                ComponentSummary* Summary, ComponentStatistics* Statistics, 
                                ComponentHangMonitorInfo* HangMonitorInfo);
    ///Retrieves tracking data for all COM+ applications in the form of a collection object.
    ///Params:
    ///    TopLevelCollection = On return, the IUnknown interface for a collection of tracker data.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and S_OK.
    ///    
    HRESULT GetTrackerDataAsCollectionObject(IUnknown* TopLevelCollection);
    ///Retrieves the minimum interval for polling suggested by the Tracker Server.
    ///Params:
    ///    PollingIntervalInSeconds = The Tracker Server's suggested polling interval, in seconds.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and S_OK.
    ///    
    HRESULT GetSuggestedPollingInterval(uint* PollingIntervalInSeconds);
}

///Connects to the dispenser manager.
@GUID("5CB31E10-2B5F-11CF-BE10-00AA00A2FA25")
interface IDispenserManager : IUnknown
{
    ///Registers the resource dispenser with the dispenser manager.
    ///Params:
    ///    __MIDL__IDispenserManager0000 = The IDispenserDriver interface the Resource Dispenser offers to the Dispenser Manager to use later to notify
    ///                                    the Resource Dispenser.
    ///    szDispenserName = A friendly name of the Resource Dispenser for administrator display.
    ///    __MIDL__IDispenserManager0001 = The IHolder interface that has been instantiated for the resource dispenser.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT RegisterDispenser(IDispenserDriver __MIDL__IDispenserManager0000, const(PWSTR) szDispenserName, 
                              IHolder* __MIDL__IDispenserManager0001);
    ///Determines the current context.
    ///Params:
    ///    __MIDL__IDispenserManager0002 = An internal unique identifier of the current object, or 0 if no current object. This may not be interpreted
    ///                                    as an IUnknown pointer to the current object.
    ///    __MIDL__IDispenserManager0003 = The transaction that the current object is running in, or 0 if none. This value may be cast to
    ///                                    <b>ITransaction *</b>.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT GetContext(size_t* __MIDL__IDispenserManager0002, size_t* __MIDL__IDispenserManager0003);
}

///Allocates or frees resources for an installed Resource Dispenser. The Dispenser Manager exposes a different
///<b>IHolder</b> interface to each installed Resource Dispenser.
@GUID("BF6A1850-2B45-11CF-BE10-00AA00A2FA25")
interface IHolder : IUnknown
{
    ///Allocates a resource from the inventory.
    ///Params:
    ///    __MIDL__IHolder0000 = The type of resource to be allocated.
    ///    __MIDL__IHolder0001 = A pointer to the location where the handle of the allocated resource is returned.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResTypId</i> is <b>NULL</b> or an empty string, or the Resource Dispenser's
    ///    IDispenserDriver::CreateResource method generated an empty or duplicate RESID. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. The <i>pResId</i>
    ///    parameter has not been set. The likely cause is that the caller's transaction is aborting. </td> </tr>
    ///    </table>
    ///    
    HRESULT AllocResource(const(size_t) __MIDL__IHolder0000, size_t* __MIDL__IHolder0001);
    ///Returns a resource to the inventory.
    ///Params:
    ///    __MIDL__IHolder0002 = The handle of the resource to be freed.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResTypId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. The resource has not been freed.
    ///    </td> </tr> </table>
    ///    
    HRESULT FreeResource(const(size_t) __MIDL__IHolder0002);
    ///Tracks the resource.
    ///Params:
    ///    __MIDL__IHolder0003 = The handle of the resource to be tracked. The Resource Dispenser has already created this resource before
    ///                          calling <b>TrackResource</b>.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. The resource has not been tracked.
    ///    The likely cause is that the caller's transaction is aborting. </td> </tr> </table>
    ///    
    HRESULT TrackResource(const(size_t) __MIDL__IHolder0003);
    ///Tracks the resource (string version).
    ///Params:
    ///    __MIDL__IHolder0004 = The handle of the resource to be tracked. The Resource Dispenser has already created this resource before
    ///                          calling <b>TrackResourceS</b>.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>SResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. The resource has not been tracked.
    ///    The likely cause is that the caller's transaction is aborting. </td> </tr> </table>
    ///    
    HRESULT TrackResourceS(ushort* __MIDL__IHolder0004);
    ///Stops tracking a resource.
    ///Params:
    ///    __MIDL__IHolder0005 = The handle of the resource to stop tracking.
    ///    __MIDL__IHolder0006 = If <b>TRUE</b>, caller is requesting that the resource be destroyed, by calling
    ///                          IDispenserDriver::DestroyResource. If <b>FALSE</b>, caller destroys the resource.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT UntrackResource(const(size_t) __MIDL__IHolder0005, const(BOOL) __MIDL__IHolder0006);
    ///Stops tracking a resource (string version).
    ///Params:
    ///    __MIDL__IHolder0007 = The handle of the resource to stop tracking.
    ///    __MIDL__IHolder0008 = If <b>TRUE</b>, caller is requesting that the resource be destroyed, by calling
    ///                          IDispenserDriver::DestroyResource. If <b>FALSE</b>, caller destroys the resource.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>SResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT UntrackResourceS(ushort* __MIDL__IHolder0007, const(BOOL) __MIDL__IHolder0008);
    ///Closes the Holder.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Close();
    ///Deletes a resource, calling its destructor to free memory and other associated system resources.
    ///Params:
    ///    __MIDL__IHolder0009 = The resource to be destroyed.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL </b></dt> </dl> </td> <td width="60%"> The method failed. The resource has not been destroyed.
    ///    </td> </tr> </table>
    ///    
    HRESULT RequestDestroyResource(const(size_t) __MIDL__IHolder0009);
}

///Is called by the holder of the COM+ Resource Dispenser to create, enlist, evaluate, prepare, and destroy a resource.
@GUID("208B3651-2B48-11CF-BE10-00AA00A2FA25")
interface IDispenserDriver : IUnknown
{
    ///Creates a resource.
    ///Params:
    ///    ResTypId = The type of resource to be created.
    ///    pResId = A handle to the newly created resource.
    ///    pSecsFreeBeforeDestroy = The time-out of the new resource. This is the number of seconds that this resource is allowed to remain idle
    ///                             in the pool before it is destroyed.
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT CreateResource(const(size_t) ResTypId, size_t* pResId, int* pSecsFreeBeforeDestroy);
    ///Evaluates how well a candidate resource matches.
    ///Params:
    ///    ResTypId = The type of resource that the Dispenser Manager is looking to match.
    ///    ResId = The candidate resource that the Dispenser Manager is considering.
    ///    fRequiresTransactionEnlistment = If <b>TRUE</b>, the candidate resource (<i>ResId</i>), if chosen, requires transaction enlistment. If
    ///                                     enlistment is expensive, <b>RateResource</b> might rate such a resource lower than a resource that is already
    ///                                     enlisted in the correct transaction.
    ///    pRating = The Dispenser's rating of this candidate. This parameter can be one of the following values. <table> <tr>
    ///              <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"> <dl> <dt>0</dt> </dl> </td> <td width="60%"> The
    ///              candidate resource is unusable for this request. The resource is not or cannot be changed to be of type
    ///              <i>ResTypId</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt>1</dt> </dl> </td> <td width="60%"> The candidate
    ///              is a bad fit, but usable. The Dispenser Manager will continue to suggest candidates. </td> </tr> <tr> <td
    ///              width="40%"> <dl> <dt>2</dt> </dl> </td> <td width="60%"> The candidate is better than candidates rated as 1.
    ///              The Dispenser Manager will continue to suggest candidates. </td> </tr> <tr> <td width="40%"> <dl>
    ///              <dt>100</dt> </dl> </td> <td width="60%"> The candidate is a perfect fit. The Dispenser Manager will stop
    ///              suggesting candidates. </td> </tr> </table>
    ///Returns:
    ///    If the method succeeds, the return value is S_OK. Otherwise, it is E_FAIL.
    ///    
    HRESULT RateResource(const(size_t) ResTypId, const(size_t) ResId, const(BOOL) fRequiresTransactionEnlistment, 
                         uint* pRating);
    ///Enlists a resource in a transaction.
    ///Params:
    ///    ResId = The resource that the Dispenser Manager is asking to be enlisted in transaction <i>TransId</i>.
    ///    TransId = The transaction that the Dispenser Manager wants the Resource Dispenser to enlist resource <i>ResId</i> in.
    ///              The Dispenser Manager passes 0 to indicate that the Resource Dispenser should ensure that the resource is not
    ///              enlisted in any transaction.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    resource is not enlistable (not transaction capable). </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is not valid. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr>
    ///    </table>
    ///    
    HRESULT EnlistResource(const(size_t) ResId, const(size_t) TransId);
    ///Prepares the resource to be put back into general or enlisted inventory.
    ///Params:
    ///    ResId = The resource to be reset.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> <i>ResId</i> is not a valid resource handle. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT ResetResource(const(size_t) ResId);
    ///Destroys a resource.
    ///Params:
    ///    ResId = The resource that the Dispenser Manager is asking the Resource Dispenser to destroy.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The Resource Dispenser does not support numeric RESIDs. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT DestroyResource(const(size_t) ResId);
    ///Destroys a resource (string resource version).
    ///Params:
    ///    ResId = The resource that the Dispenser Manager is asking the Resource Dispenser to destroy.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    The Resource Dispenser does not support numeric SRESIDs. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The method failed. </td> </tr> </table>
    ///    
    HRESULT DestroyResourceS(ushort* ResId);
}

///Provides a way for a COM+ transaction context to work with a non-DTC transaction.
@GUID("02558374-DF2E-4DAE-BD6B-1D5C994F9BDC")
interface ITransactionProxy : IUnknown
{
    ///Commits the transaction.
    ///Params:
    ///    guid = A GUID that identifies the transaction to commit.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The transaction was committed. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>CONTEXT_E_ABORTED</b></dt> </dl> </td> <td width="60%"> The transaction was aborted.
    ///    </td> </tr> </table>
    ///    
    HRESULT Commit(GUID guid);
    ///Aborts the transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT Abort();
    ///Promotes a non-DTC transaction to a DTC transaction.
    ///Params:
    ///    pTransaction = An implementation of <b>ITransaction</b> that represents the DTC transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT Promote(ITransaction* pTransaction);
    ///Provides a ballot so that a COM+ transaction context can vote on the transaction.
    ///Params:
    ///    pTxAsync = An implementation of <b>ITransactionVoterNotifyAsync2</b> that notifies the voter of a vote request.
    ///    ppBallot = An implementation of <b>ITransactionVoterBallotAsync2</b> that allows the voter to approve or veto the
    ///               non-DTC transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT CreateVoter(ITransactionVoterNotifyAsync2 pTxAsync, ITransactionVoterBallotAsync2* ppBallot);
    ///Retrieves the isolation level of the non-DTC transaction.
    ///Params:
    ///    __MIDL__ITransactionProxy0000 = A pointer to an ISOLATIONLEVEL value that specifies the isolation level of the non-DTC transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT GetIsolationLevel(int* __MIDL__ITransactionProxy0000);
    ///Retrieves the identifier of the non-DTC transaction.
    ///Params:
    ///    pbstrIdentifier = The GUID that identifies the non-DTC transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT GetIdentifier(GUID* pbstrIdentifier);
    ///Indicates whether the non-DTC transaction context can be reused for multiple transactions.
    ///Params:
    ///    pfIsReusable = <b>TRUE</b> if the non-DTC transaction context can be reused for multiple transactions; otherwise,
    ///                   <b>FALSE</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and S_OK.
    ///    
    HRESULT IsReusable(BOOL* pfIsReusable);
}

@GUID("A7549A29-A7C4-42E1-8DC1-7E3D748DC24A")
interface IContextSecurityPerimeter : IUnknown
{
    HRESULT GetPerimeterFlag(BOOL* pFlag);
    HRESULT SetPerimeterFlag(BOOL fFlag);
}

@GUID("13D86F31-0139-41AF-BCAD-C7D50435FE9F")
interface ITxProxyHolder : IUnknown
{
    void GetIdentifier(GUID* pGuidLtx);
}

///Provides access to the current object's context. An object's context is primarily used when working with transactions
///or dealing with the security of an object.
@GUID("51372AE0-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectContext : IUnknown
{
    ///Creates an object using current object's context.
    ///Params:
    ///    rclsid = The CLSID of the type of object to instantiate.
    ///    riid = Any interface that's implemented by the object you want to instantiate.
    ///    ppv = A reference to the requested interface on the new object. If instantiation fails, this parameter is set to
    ///          <b>NULL</b>.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>REGDB_E_CLASSNOTREG</b></dt> </dl> </td> <td
    ///    width="60%"> The component specified by clsid is not registered as a COM component. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> There's not enough memory
    ///    available to instantiate the object. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The argument passed in the <i>ppvObj</i> parameter is invalid. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred.
    ///    This can happen if one object passes its IObjectContext pointer to another object and the other object calls
    ///    CreateInstance using this pointer. An <b>IObjectContext</b> pointer is not valid outside the context of the
    ///    object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** ppv);
    ///Declares that the transaction in which the object is executing can be committed and that the object should be
    ///deactivated when it returns from the currently executing method call.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> An unexpected error occurred. This can happen if one object passes its IObjectContext pointer to
    ///    another object and the other object calls SetComplete using this pointer. An <b>IObjectContext</b> pointer is
    ///    not valid outside the context of the object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT SetComplete();
    ///Declares that the transaction in which the object is executing must be aborted and that the object should be
    ///deactivated when it returns from the currently executing method call.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td
    ///    width="60%"> An unexpected error occurred. This can happen if one object passes its IObjectContext pointer to
    ///    another object and the other object calls SetAbort using this pointer. An <b>IObjectContext</b> pointer is
    ///    not valid outside the context of the object that originally obtained it. </td> </tr> </table>
    ///    
    HRESULT SetAbort();
    ///Declares that the object's work is not necessarily finished but that its transactional updates are in a
    ///consistent state and could be committed in their present form.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully and the object's transactional updates can now be committed. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. This can happen
    ///    if one object passes its IObjectContext pointer to another object and the other object calls EnableCommit
    ///    using this pointer. An <b>IObjectContext</b> pointer is not valid outside the context of the object that
    ///    originally obtained it. </td> </tr> </table>
    ///    
    HRESULT EnableCommit();
    ///Declares that the object's transactional updates are in an inconsistent state and cannot be committed in their
    ///present state.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. The object's transactional updates cannot be committed until the object calls either
    ///    EnableCommit or SetComplete. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_UNEXPECTED</b></dt> </dl> </td>
    ///    <td width="60%"> An unexpected error occurred. This can happen if one object passes its IObjectContext
    ///    pointer to another object and the other object calls DisableCommit using this pointer. An
    ///    <b>IObjectContext</b> pointer is not valid outside the context of the object that originally obtained it.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The
    ///    current object does not have a context associated with it. This is probably because it was not created with
    ///    one of the COM+ CreateInstance methods. </td> </tr> </table>
    ///    
    HRESULT DisableCommit();
    ///Indicates whether the object is executing within a transaction.
    ///Returns:
    ///    If the current object is executing within a transaction, the return value is <b>TRUE</b>. Otherwise, it is
    ///    <b>FALSE</b>.
    ///    
    BOOL    IsInTransaction();
    ///Indicates whether security is enabled for the current object. COM+ security is enabled unless the object is
    ///running in the client's process.
    ///Returns:
    ///    If security is enabled for this object, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>.
    ///    
    BOOL    IsSecurityEnabled();
    ///Indicates whether the object's direct caller is in a specified role (either directly or as part of a group).
    ///Params:
    ///    bstrRole = The name of the role.
    ///    pfIsInRole = <b>TRUE</b> if the caller is in the specified role; <b>FALSE</b> if not. This parameter is also set to
    ///                 <b>TRUE</b> if security is not enabled.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The role specified in the
    ///    <i>bstrRole</i> parameter is a recognized role, and the Boolean result returned in the <i>pbIsInRole</i>
    ///    parameter indicates whether the caller is in that role. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_ROLENOTFOUND</b></dt> </dl> </td> <td width="60%"> The role specified in the <i>bstrRole</i>
    ///    parameter does not exist. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One or more of the arguments passed in is not valid. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error occurred. This can happen if
    ///    one object passes its IObjectContext pointer to another object and the other object calls IsCallerInRole
    ///    using this pointer. An <b>IObjectContext</b> pointer is not valid outside the context of the object that
    ///    originally obtained it. </td> </tr> </table>
    ///    
    HRESULT IsCallerInRole(BSTR bstrRole, BOOL* pfIsInRole);
}

///Defines context-specific initialization and cleanup procedures for your COM+ objects, and specifies whether the
///objects can be recycled.
@GUID("51372AEC-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectControl : IUnknown
{
    ///Enables a COM+ object to perform context-specific initialization whenever it is activated. This method is called
    ///by the COM+ run-time environment before any other methods are called on the object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Activate();
    ///Enables a COM+ object to perform required cleanup before it is recycled or destroyed. This method is called by
    ///the COM+ run-time environment whenever an object is deactivated. Do not make any method calls on objects in the
    ///same activity from this method.
    void    Deactivate();
    ///Notifies the COM+ run-time environment whether the object can be pooled for reuse when it is deactivated.
    ///Returns:
    ///    If the object can be pooled for reuse, the return value is <b>TRUE</b>. Otherwise, it is <b>FALSE</b>.
    ///    
    BOOL    CanBePooled();
}

///Enumerates names.
@GUID("51372AF2-CAE7-11CF-BE81-00AA00A2FA25")
interface IEnumNames : IUnknown
{
    ///Retrieves the specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = The number of name values being requested.
    ///    rgname = An array in which the name values are to be returned and which must be of at least the size defined in the
    ///             <i>celt</i> parameter.
    ///    pceltFetched = The number of elements returned in <i>rgname</i>, or <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED, and
    ///    E_FAIL, as well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All elements requested were obtained
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    number of elements returned is less than the number specified in the <i>celt</i> parameter. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint celt, BSTR* rgname, uint* pceltFetched);
    ///Skips over the specified number of items in the enumeration sequence.
    ///Params:
    ///    celt = The number of elements to be skipped.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The requested number of elements was
    ///    skipped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    number of elements skipped was not the same as the number requested. </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The enumeration sequence was reset. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The enumeration
    ///    sequence was reset, but there are no items in the enumerator. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Creates an enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppenum = Address of a pointer to the IEnumNames interface on the enumeration object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Clone(IEnumNames* ppenum);
}

///Determines the security identifier of the current object's original caller or direct caller. However, the preferred
///way to get information about an object's callers is to use the ISecurityCallContext interface.
@GUID("51372AEA-CAE7-11CF-BE81-00AA00A2FA25")
interface ISecurityProperty : IUnknown
{
    ///In MTS 2.0, this method retrieves the security identifier of the external process that directly created the
    ///current object. Do not use this method in COM+.
    ///Params:
    ///    pSID = A reference to the security ID of the process that directly created the current object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The security ID of the process that
    ///    directly created the current object is returned in the parameter <i>pSid</i>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The current object does
    ///    not have a context associated with it because either the component was not imported into an application or
    ///    the object was not created with one of the COM+ CreateInstance methods. </td> </tr> </table>
    ///    
    HRESULT GetDirectCreatorSID(void** pSID);
    ///In MTS 2.0, this method retrieves the security identifier of the base process that initiated the activity in
    ///which the current object is executing. Do not use this method in COM+.
    ///Params:
    ///    pSID = A reference to the security ID of the base process that initiated the activity in which the current object is
    ///           executing.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The security ID of the original created
    ///    is returned in the parameter <i>pSid</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The current object does not have a context
    ///    associated with it because either the component was not imported into an application or the object was not
    ///    created with one of the COM+ CreateInstance methods. </td> </tr> </table>
    ///    
    HRESULT GetOriginalCreatorSID(void** pSID);
    ///Retrieves the security identifier of the external process that called the currently executing method. You can
    ///also obtain this information using ISecurityCallContext.
    ///Params:
    ///    pSID = A reference to the security ID of the process from which the current method was invoked.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The security ID of the process that
    ///    called the current method is returned in the parameter <i>pSid</i>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td width="60%"> The current object does not have a context
    ///    associated with it because either the component was not imported into an application or the object was not
    ///    created with one of the COM+ CreateInstance methods. </td> </tr> </table>
    ///    
    HRESULT GetDirectCallerSID(void** pSID);
    ///Retrieves the security identifier of the base process that initiated the call sequence from which the current
    ///method was called. The preferred way to obtain information about the original caller is to use the
    ///ISecurityCallContext interface.
    ///Params:
    ///    pSID = A reference to the security ID of the base process that initiated the call sequence from which the current
    ///           method was called.
    ///Returns:
    ///    This method can return the standard return values <b>E_INVALIDARG</b>, <b>E_OUTOFMEMORY</b>,
    ///    <b>E_UNEXPECTED</b>, and <b>E_FAIL</b>, as well as the following values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The
    ///    security ID of the base process that originated the call into the current object is returned in the parameter
    ///    <i>pSid</i>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOCONTEXT</b></dt> </dl> </td> <td
    ///    width="60%"> The current object does not have a context associated with it because either the component was
    ///    not imported into an application or the object was not created with one of the COM+ <b>CreateInstance</b>
    ///    methods. </td> </tr> </table>
    ///    
    HRESULT GetOriginalCallerSID(void** pSID);
    ///Releases the security identifier returned by one of the other ISecurityProperty methods.
    ///Params:
    ///    pSID = A reference to a security ID.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The argument passed in the pSid parameter is not a reference to a security ID. </td> </tr>
    ///    </table>
    ///    
    HRESULT ReleaseSID(void* pSID);
}

///If you implement this interface in your component, the COM+ run-time environment automatically calls its methods on
///your objects at the appropriate times. Only the COM+ run-time environment can invoke the <b>ObjectControl</b>
///methods; they are not accessible to an object's clients or to the object itself. If a client queries for the
///<b>ObjectControl</b> interface, QueryInterface returns E_NOINTERFACE. <b>ObjectControl</b> and IObjectControl provide
///the same functionality, but unlike <b>IObjectControl</b>, <b>ObjectControl</b> is compatible with Automation.
@GUID("7DC41850-0C31-11D0-8B79-00AA00B8A790")
interface ObjectControl : IUnknown
{
    ///Enables a COM+ object to perform context-specific initialization whenever it is activated. This method is called
    ///by the COM+ run-time environment before any other methods are called on the object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Activate();
    ///Enables a COM+ object to perform cleanup required before it is recycled or destroyed. This method is called by
    ///the COM+ run-time environment whenever an object is deactivated. Do not make any method calls on objects in the
    ///same activity from this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Deactivate();
    ///Indicates whether the object can be pooled for reuse when it is deactivated.
    ///Params:
    ///    pbPoolable = Indicates whether the COM+ run-time environment can pool this object on deactivation for later reuse.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CanBePooled(short* pbPoolable);
}

///Exposes property methods that you can use to set or retrieve the value of a shared property. A shared property can
///contain any data type that can be represented by a <b>Variant</b>.
@GUID("2A005C01-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedProperty : IDispatch
{
    ///Retrieves the value of a shared property.
    ///Params:
    ///    pVal = The value of this shared property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_Value(VARIANT* pVal);
    ///Sets the value of a shared property.
    ///Params:
    ///    val = The new value that is to be set for this shared property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>DISP_E_ARRAYISLOCKED</b></dt> </dl> </td> <td width="60%"> The
    ///    argument passed in the parameter contains an array that is locked. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>DISP_E_BADVARTYPE</b></dt> </dl> </td> <td width="60%"> The argument passed in the parameter is not a
    ///    valid Variant type. </td> </tr> </table>
    ///    
    HRESULT put_Value(VARIANT val);
}

///Used to create and access the shared properties in a shared property group.
@GUID("2A005C07-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedPropertyGroup : IDispatch
{
    ///Creates a new shared property with the specified index. If a shared property with the specified index already
    ///exists, <b>CreatePropertyByPosition</b> returns a reference to the existing one.
    ///Params:
    ///    Index = The numeric index within the SharedPropertyGroup object by which the new property is referenced. You can use
    ///            this index later to retrieve the shared property with the get_PropertyByPosition method.
    ///    fExists = A reference to a Boolean value. If <i>fExists</i> is set to VARIANT_TRUE on return from this method, the
    ///              shared property specified by <i>Index</i> existed prior to this call. If it is set to VARIANT_FALSE, the
    ///              property was created by this call.
    ///    ppProp = A reference to a shared property object identified by the numeric index passed in the <i>Index</i> parameter,
    ///             or <b>NULL</b> if an error is encountered.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CreatePropertyByPosition(int Index, short* fExists, ISharedProperty* ppProp);
    ///Retrieves a reference to an existing shared property with the specified index.
    ///Params:
    ///    Index = The numeric index that was used to create the shared property that is retrieved.
    ///    ppProperty = A reference to the shared property specified in the <i>Index</i> parameter, or <b>NULL</b> if the property
    ///                 does not exist.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The shared property exists, and a reference to it is
    ///    returned in the <i>ppProperty</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The shared property with the index specified in the
    ///    <i>Index</i> parameter does not exist. </td> </tr> </table>
    ///    
    HRESULT get_PropertyByPosition(int Index, ISharedProperty* ppProperty);
    ///Creates a new shared property with the specified name. If a shared property by that name already exists,
    ///<b>CreateProperty</b> returns a reference to the existing property.
    ///Params:
    ///    Name = The name of the property to create. You can use this name later to obtain a reference to this property by
    ///           using the get_Property method.
    ///    fExists = A reference to a Boolean value that is set to VARIANT_TRUE on return from this method if the shared property
    ///              specified in the <i>Name</i> parameter existed prior to this call, and VARIANT_FALSE if the property was
    ///              created by this call.
    ///    ppProp = A reference to a SharedProperty object with the name specified in the <i>Name</i> parameter, or <b>NULL</b>
    ///             if an error is encountered.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CreateProperty(BSTR Name, short* fExists, ISharedProperty* ppProp);
    ///Retrieves a reference to an existing shared property with the specified name.
    ///Params:
    ///    Name = The name that was used to create the shared property that is retrieved.
    ///    ppProperty = A reference to the shared property specified in the <i>Name</i> parameter, or <b>NULL</b> if the property
    ///                 does not exist.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The shared property exists, and a reference to it is
    ///    returned in the <i>ppProperty</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The shared property with the name specified in the
    ///    <i>Name</i> parameter does not exist. </td> </tr> </table>
    ///    
    HRESULT get_Property(BSTR Name, ISharedProperty* ppProperty);
}

///Used to create shared property groups and to obtain access to existing shared property groups.
@GUID("2A005C0D-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedPropertyGroupManager : IDispatch
{
    ///Creates a new shared property group. If a property group with the specified name already exists,
    ///<b>CreatePropertyGroup</b> returns a reference to the existing group.
    ///Params:
    ///    Name = The name of the shared property group to be created.
    ///    dwIsoMode = The isolation mode for the properties in the new shared property group. See the table of constants in Remarks
    ///                below. If the value of the <i>fExists</i> parameter is set to VARIANT_TRUE on return from this method, the
    ///                input value is ignored and the value returned in this parameter is the isolation mode that was assigned when
    ///                the property group was created.
    ///    dwRelMode = The release mode for the properties in the new shared property group. See the table of constants in Remarks
    ///                below. If the value of the <i>fExists</i> parameter is set to VARIANT_TRUE on return from this method, the
    ///                input value is ignored and the value returned in this parameter is the release mode that was assigned when
    ///                the property group was created.
    ///    fExists = VARIANT_TRUE on return from this method if the shared property group specified in the name parameter existed
    ///              prior to this call, and VARIANT_FALSE if the property group was created by this call.
    ///    ppGroup = A reference to ISharedPropertyGroup, which is a shared property group identified by the <i>Name</i>
    ///              parameter, or <b>NULL</b> if an error is encountered.
    ///Returns:
    ///    This method can return the standard return values E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> A reference to the shared property group specified in the
    ///    <i>Name</i> parameter is returned in the <i>ppGroup</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CONTEXT_E_NOCONTEXT </b></dt> </dl> </td> <td width="60%"> The caller is not executing under COM+. A
    ///    caller must be executing under COM+ to use the Shared Property Manager. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG </b></dt> </dl> </td> <td width="60%"> At least one of the parameters is not valid,
    ///    or the same object is attempting to create the same property group more than once. </td> </tr> </table>
    ///    
    HRESULT CreatePropertyGroup(BSTR Name, int* dwIsoMode, int* dwRelMode, short* fExists, 
                                ISharedPropertyGroup* ppGroup);
    ///Retrieves a reference to an existing shared property group.
    ///Params:
    ///    Name = The name of the shared property group to be retrieved.
    ///    ppGroup = A reference to the shared property group specified in the <i>Name</i> parameter, or <b>NULL</b> if the
    ///              property group does not exist.
    ///Returns:
    ///    This method can return the standard return values E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The shared property group exists, and a reference to it is
    ///    returned in the <i>ppGroup</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
    ///    </dl> </td> <td width="60%"> The shared property group with the name specified in the <i>Name</i> parameter
    ///    does not exist. </td> </tr> </table>
    ///    
    HRESULT get_Group(BSTR Name, ISharedPropertyGroup* ppGroup);
    ///Retrieves an enumerator for the named security call context properties. This property is restricted in Microsoft
    ///Visual Basic and cannot be used.
    ///Params:
    ///    retval = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* retval);
}

///Controls the object construction process by passing in parameters from other methods or objects.
@GUID("41C4F8B3-7439-11D2-98CB-00C04F8EE1C4")
interface IObjectConstruct : IUnknown
{
    ///Constructs an object using the specified parameters.
    ///Params:
    ///    pCtorObj = A reference to an implementation of the IObjectConstructString interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Construct(IDispatch pCtorObj);
}

///Provides access to a constructor string. Use it when you want to specify the parameters during the construction of
///your object. Object constructor strings should not be used to store security-sensitive information.
@GUID("41C4F8B2-7439-11D2-98CB-00C04F8EE1C4")
interface IObjectConstructString : IDispatch
{
    ///Retrieves the constructor string for the object. Object constructor strings should not be used to store
    ///security-sensitive information.
    ///Params:
    ///    pVal = A reference to an administratively supplied object constructor string.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_ConstructString(BSTR* pVal);
}

///Retrieves the activity identifier associated with the current object context.
@GUID("51372AFC-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectContextActivity : IUnknown
{
    ///Retrieves the GUID associated with the current activity.
    ///Params:
    ///    pGUID = A reference to the GUID associated with the current activity.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetActivityId(GUID* pGUID);
}

///Retrieves transaction, activity, and context information on the current context object. Using the methods of this
///interface, you can retrieve relevant information contained within an object context. This interface has been
///superseded by the IObjectContextInfo2 interface.
@GUID("75B52DDB-E8ED-11D1-93AD-00AA00BA3258")
interface IObjectContextInfo : IUnknown
{
    ///Indicates whether the current object is executing in a transaction.
    ///Returns:
    ///    If the current object is executing within a transaction, the return value is <b>TRUE</b>. Otherwise, it is
    ///    <b>FALSE</b>.
    ///    
    BOOL    IsInTransaction();
    ///Retrieves a reference to the current transaction. You can use this reference to manually enlist a resource
    ///manager that does not support automatic transactions.
    ///Params:
    ///    pptrans = A reference to the IUnknown interface of the transaction that is currently executing. You can then
    ///              QueryInterface to get the <b>ITransaction</b> interface for the current transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The object is executing in a transaction.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The object is not
    ///    executing in a transaction. The <i>pptrans</i> parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetTransaction(IUnknown* pptrans);
    ///Retrieves the identifier of the current transaction.
    ///Params:
    ///    pGuid = A GUID that identifies the current transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed succesfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The object is not
    ///    executing in a transaction. </td> </tr> </table>
    ///    
    HRESULT GetTransactionId(GUID* pGuid);
    ///Retrieves the identifier of the current activity.
    ///Params:
    ///    pGUID = A GUID that identifies the current activity.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetActivityId(GUID* pGUID);
    ///Retrieves the identifier of the current context.
    ///Params:
    ///    pGuid = A GUID that identifies the current context.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetContextId(GUID* pGuid);
}

///Provides additional information about an object's context. This interface extends the IObjectContextInfo interface.
@GUID("594BE71A-4BC4-438B-9197-CFD176248B09")
interface IObjectContextInfo2 : IObjectContextInfo
{
    ///Retrieves the identifier of the partition of the current object context.
    ///Params:
    ///    pGuid = A GUID that identifies the COM+ partition.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>COMADMIN_E_PARTITIONS_DISABLED </b></dt> </dl> </td> <td width="60%">
    ///    COM+ partitions are not enabled. </td> </tr> </table>
    ///    
    HRESULT GetPartitionId(GUID* pGuid);
    ///Retrieves the identifier of the application of the current object context.
    ///Params:
    ///    pGuid = A GUID that identifies the application.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetApplicationId(GUID* pGuid);
    ///Retrieves the identifier of the application instance of the current object context. This information is useful
    ///when using COM+ Application Recycling, for example.
    ///Params:
    ///    pGuid = A GUID that identifies the application instance.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetApplicationInstanceId(GUID* pGuid);
}

///Used to discover the status of the transaction that is completed by the call to CoLeaveServiceDomain when
///CServiceConfig is configured to use transactions in the call to CoEnterServiceDomain.
@GUID("61F589E8-3724-4898-A0A4-664AE9E1D1B4")
interface ITransactionStatus : IUnknown
{
    ///Sets the transaction status to either committed or aborted. Do not use this method. It is used only internally by
    ///COM+.
    ///Params:
    ///    hrStatus = The status of the transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SetTransactionStatus(HRESULT hrStatus);
    ///Retrieves the transaction status.
    ///Params:
    ///    pHrStatus = he status of the transaction. See Remarks section for more information.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT GetTransactionStatus(HRESULT* pHrStatus);
}

///Retrieves properties describing the Transaction Internet Protocol (TIP) transaction context.
@GUID("92FD41CA-BAD9-11D2-9A2D-00C04F797BC9")
interface IObjectContextTip : IUnknown
{
    ///Retrieves the URL of the TIP context.
    ///Params:
    ///    pTipUrl = The URL of the TIP transaction context, or <b>NULL</b> if the transaction context does not exist.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetTipUrl(BSTR* pTipUrl);
}

///Enables participation in the abnormal handling of server-side playback errors and client-side failures of the Message
///Queuing delivery mechanism.
@GUID("51372AFD-CAE7-11CF-BE81-00AA00A2FA25")
interface IPlaybackControl : IUnknown
{
    ///Informs the client-side exception handling component that all Message Queuing attempts to deliver the message to
    ///the server were rejected. The message ended up on the client-side Xact dead letter queue.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FinalClientRetry();
    ///Informs the server-side Exception_CLSID implementation that all attempts to play back the deferred activation
    ///have failed. The message is about to be moved to the final resting queue.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT FinalServerRetry();
}

///Enables the caller to obtain the properties associated with the current object's context.
@GUID("51372AF4-CAE7-11CF-BE81-00AA00A2FA25")
interface IGetContextProperties : IUnknown
{
    ///Counts the number of context properties.
    ///Params:
    ///    plCount = The number of current context properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Count(int* plCount);
    ///Retrieves the value of the specified context property.
    ///Params:
    ///    name = The name of a current context property.
    ///    pProperty = The value(s) of the property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    ///Retrieves a list of the names of the current context properties.
    ///Params:
    ///    ppenum = An IEnumNames interface providing access to a list of the names of the current context properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT EnumNames(IEnumNames* ppenum);
}

///Controls object deactivation and transaction voting by manipulating context state flags. By calling the methods of
///this interface, you can set consistent and done flags independently of each other and get the current status of each
///flag. Also, the methods of this interface return errors that indicate the absence of just-in-time (JIT) activation or
///the absence of a transaction.
@GUID("3C05E54B-A42A-11D2-AFC4-00C04F8EE1C4")
interface IContextState : IUnknown
{
    ///Sets the done flag, which controls whether the object deactivates on method return.
    ///Params:
    ///    bDeactivate = The done flag.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOJIT</b></dt> </dl> </td> <td width="60%"> Just-in-Time
    ///    Activation is not available to this context. </td> </tr> </table>
    ///    
    HRESULT SetDeactivateOnReturn(short bDeactivate);
    ///Retrieves the value of the done flag.
    ///Params:
    ///    pbDeactivate = The done flag.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOJIT</b></dt> </dl> </td> <td width="60%"> Just-in-Time
    ///    Activation is not available to this context. </td> </tr> </table>
    ///    
    HRESULT GetDeactivateOnReturn(short* pbDeactivate);
    ///Sets the consistent flag.
    ///Params:
    ///    txVote = The consistent flag. For a list of values, see the TransactionVote enumeration. Set this parameter to
    ///             TxCommit if the consistent flag is true;set it to TxAbort if the consistent flag is false.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOJIT</b></dt> </dl> </td> <td width="60%"> Just-in-Time
    ///    Activation is not available to this context. </td> </tr> </table>
    ///    
    HRESULT SetMyTransactionVote(TransactionVote txVote);
    ///Retrieves the value of the consistent flag. Retrieving this value before deactivating the object allows the
    ///object to confirm its vote.
    ///Params:
    ///    ptxVote = The consistent flag. For a list of values, see the TransactionVote enumeration. This parameter is set to
    ///              TxCommit if the consistent flag is true; it is set to TxAbort if the consistent flag is false.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CONTEXT_E_NOTRANSACTION</b></dt> </dl> </td> <td width="60%"> The
    ///    object is not running in a transaction. </td> </tr> </table>
    ///    
    HRESULT GetMyTransactionVote(TransactionVote* ptxVote);
}

///Enables the caller to control an object pool.
@GUID("0A469861-5A91-43A0-99B6-D5E179BB0631")
interface IPoolManager : IDispatch
{
    ///Shuts down the object pool.
    ///Params:
    ///    CLSIDOrProgID = A string containing the CLSID or ProgID of the pool to be shut down.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ShutdownPool(BSTR CLSIDOrProgID);
}

///Activates the COM+ component load balancing service.
@GUID("DCF443F4-3F8A-4872-B9F0-369A796D12D6")
interface ISelectCOMLBServer : IUnknown
{
    ///Initializes the load balancing server object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Init();
    ///Retrieves the name of the load balancing server.
    ///Params:
    ///    pUnk = A pointer to the load balancing server's name.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetLBServer(IUnknown pUnk);
}

///Used to activate the COM+ component load balancing service.
@GUID("3A0F150F-8EE5-4B94-B40E-AEF2F9E42ED2")
interface ICOMLBArguments : IUnknown
{
    ///Retrieves the object's CLSID.
    ///Params:
    ///    pCLSID = A pointer to the object's CLSID.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCLSID(GUID* pCLSID);
    ///Sets the object's CLSID.
    ///Params:
    ///    pCLSID = The object's CLSID.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetCLSID(GUID* pCLSID);
    ///Retrieves the computer name for the load balancing server.
    ///Params:
    ///    cchSvr = The object's machine name.
    ///    szServerName = The object's server name.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetMachineName(uint cchSvr, ushort* szServerName);
    ///Sets the computer name for the load balancing server.
    ///Params:
    ///    cchSvr = The object's machine name.
    ///    szServerName = The object's server name.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetMachineName(uint cchSvr, ushort* szServerName);
}

///Is the means by which the CRM Worker and CRM Compensator write records to the log and make them durable.
@GUID("A0E174B3-D26E-11D2-8F84-00805FC7BCD9")
interface ICrmLogControl : IUnknown
{
    ///Retrieves the transaction unit of work (UOW) without having to log the transaction UOW in the log record.
    ///Params:
    ///    pVal = The UOW of the transaction.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> This method was called in the wrong state;
    ///    either before RegisterCompensator or when the transaction is completing (CRM Worker). </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> An out of memory error has
    ///    occurred. </td> </tr> </table>
    ///    
    HRESULT get_TransactionUOW(BSTR* pVal);
    ///The CRM Worker uses this method to register the CRM Compensator with the CRM infrastructure. It must be the first
    ///method called by the CRM Worker, and it can be called successfully only once. If the CRM Worker receives a
    ///"recovery in progress" error code on calling this method, it should call this method again until it receives
    ///success.
    ///Params:
    ///    lpcwstrProgIdCompensator = The ProgId of the CRM Compensator. The CLSID of the CRM Compensator in string form is also accepted.
    ///    lpcwstrDescription = The description string to be used by the monitoring interfaces.
    ///    lCrmRegFlags = Flags from the CRMREGFLAGS enumeration that control which phases of transaction completion should be received
    ///                   by the CRM Compensator and whether recovery should fail if in-doubt transactions remain after recovery has
    ///                   been attempted.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_UNEXPECTED</b></dt> </dl> </td> <td width="60%"> An unexpected error has occurred. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>XACT_E_NOTRANSACTION</b></dt> </dl> </td> <td width="60%"> The component
    ///    creating the CRM clerk does not have a transaction. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_RECOVERYINPROGRESS</b></dt> </dl> </td> <td width="60%"> Recovery of the CRM log file is still
    ///    in progress. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_RECOVERY_FAILED</b></dt> </dl> </td> <td
    ///    width="60%"> Recovery of the CRM log file failed because in-doubt transactions remain. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> This method was called in
    ///    the wrong state; either before RegisterCompensator or when the transaction is completing (CRM Worker). </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> An out of memory
    ///    error has occurred. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOINTERFACE</b></dt> </dl> </td> <td
    ///    width="60%"> The CRM Compensator does not support at least one of the required interfaces (ICrmCompensator or
    ///    ICrmCompensatorVariants). </td> </tr> </table>
    ///    
    HRESULT RegisterCompensator(const(PWSTR) lpcwstrProgIdCompensator, const(PWSTR) lpcwstrDescription, 
                                int lCrmRegFlags);
    ///The CRM Worker and CRM Compensator use this method to write structured log records to the log.
    ///Params:
    ///    pLogRecord = A pointer to a <b>Variant</b> array of <b>Variants</b>. This must be a single-dimension array whose lower
    ///                 bound is zero.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One of the arguments is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was provided as an argument.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> This
    ///    method was called in the wrong state; either before RegisterCompensator or when the transaction is completing
    ///    (CRM Worker). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_ABORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The transaction has aborted, most likely because of a transaction time-out. </td> </tr> </table>
    ///    
    HRESULT WriteLogRecordVariants(VARIANT* pLogRecord);
    ///Forces all log records to be durable on disk.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> This method was called in the wrong state; either before RegisterCompensator or when the
    ///    transaction is completing (CRM Worker). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_ABORTED</b></dt>
    ///    </dl> </td> <td width="60%"> The transaction has aborted, most likely because of a transaction time-out.
    ///    </td> </tr> </table>
    ///    
    HRESULT ForceLog();
    ///Forgets the last log record written by this instance of the interface.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%">
    ///    There is no valid log record to forget. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> This method was called in the wrong state;
    ///    either before RegisterCompensator or when the transaction is completing (CRM Worker). </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XACT_E_ABORTED</b></dt> </dl> </td> <td width="60%"> The transaction has aborted,
    ///    most likely because of a transaction time-out. </td> </tr> </table>
    ///    
    HRESULT ForgetLogRecord();
    ///Performs an immediate abort call on the transaction.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td
    ///    width="60%"> This method was called in the wrong state; either before RegisterCompensator or when the
    ///    transaction is completing (CRM Worker). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_ABORTED</b></dt>
    ///    </dl> </td> <td width="60%"> The transaction has aborted, most likely because of a transaction time-out.
    ///    </td> </tr> </table>
    ///    
    HRESULT ForceTransactionToAbort();
    ///The CRM Worker and CRM Compensator use this method to write unstructured log records to the log. This method
    ///would typically be used by CRM components written in C++. Records are written lazily to the log and must be
    ///forced before they become durable. (See ICrmLogControl::ForceLog.)
    ///Params:
    ///    rgBlob = An array of BLOBs that form the log record. A BLOB is a Windows data type that is used to store an arbitrary
    ///             amount of binary data.
    ///    cBlob = The number of BLOBs in the array.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The count of the number of BLOBs is zero. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A <b>NULL</b> pointer was provided as an argument.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> This
    ///    method was called in the wrong state; either before RegisterCompensator or when the transaction is completing
    ///    (CRM Worker). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>XACT_E_ABORTED</b></dt> </dl> </td> <td
    ///    width="60%"> The transaction has aborted, most likely because of a transaction time-out. </td> </tr> </table>
    ///    
    HRESULT WriteLogRecord(BLOB* rgBlob, uint cBlob);
}

///Delivers structured log records to the CRM Compensator when using Microsoft Visual Basic.
@GUID("F0BAF8E4-7804-11D1-82E9-00A0C91EEDE9")
interface ICrmCompensatorVariants : IUnknown
{
    ///Delivers an ICrmLogControl interface to the CRM Compensator. This method is the first method called on the CRM
    ///Compensator after it has been created.
    ///Params:
    ///    pLogControl = A pointer to the ICrmLogControl interface of the CRM clerk.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLogControlVariants(ICrmLogControl pLogControl);
    ///Notifies the CRM Compensator of the prepare phase of the transaction completion and that records are about to be
    ///delivered. Prepare notifications are never received during recovery, only during normal processing.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginPrepareVariants();
    ///Delivers a log record to the CRM Compensator during the prepare phase. Log records are delivered in the order in
    ///which they were written.
    ///Params:
    ///    pLogRecord = The log record (as a <b>Variant</b> array of <b>Variants</b>).
    ///    pbForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PrepareRecordVariants(VARIANT* pLogRecord, short* pbForget);
    ///Notifies the CRM Compensator that it has had all the log records available during the prepare phase.
    ///Params:
    ///    pbOkToPrepare = Indicates whether the prepare phase succeeded, in which case it is OK to commit this transaction.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndPrepareVariants(short* pbOkToPrepare);
    ///Notifies the CRM Compensator of the commit phase (phase two) of the transaction completion and that records are
    ///about to be delivered.
    ///Params:
    ///    bRecovery = Indicates whether this method is being called during recovery.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginCommitVariants(short bRecovery);
    ///Delivers a log record to the CRM Compensator during the commit phase. Log records are delivered in the order in
    ///which they were written.
    ///Params:
    ///    pLogRecord = The log record (as a Variant array of Variants).
    ///    pbForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CommitRecordVariants(VARIANT* pLogRecord, short* pbForget);
    ///Notifies the CRM Compensator that it has delivered all the log records available during the commit phase. All log
    ///records for this transaction can be discarded from the log after this method has completed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndCommitVariants();
    ///Notifies the CRM Compensator of the abort phase of the transaction completion and that records are about to be
    ///delivered. The abort phase can be received during normal processing without a prepare phase if the client decides
    ///to initiate abort.
    ///Params:
    ///    bRecovery = Indicates whether this method is being called during recovery.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginAbortVariants(short bRecovery);
    ///Delivers a log record to the CRM Compensator during the abort phase.
    ///Params:
    ///    pLogRecord = The log record (as a <b>Variant</b> array of <b>Variants</b>).
    ///    pbForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AbortRecordVariants(VARIANT* pLogRecord, short* pbForget);
    ///Notifies the CRM Compensator that it has received all the log records available during the abort phase. All log
    ///records for this transaction can be discarded from the log after this method has completed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndAbortVariants();
}

///Delivers unstructured log records to the CRM Compensator when using Microsoft Visual C++.
@GUID("BBC01830-8D3B-11D1-82EC-00A0C91EEDE9")
interface ICrmCompensator : IUnknown
{
    ///Delivers an ICrmLogControl interface to the CRM Compensator so that it can write further log records during
    ///transaction completion. This method is the first method called on the CRM Compensator after it has been created.
    ///Params:
    ///    pLogControl = A pointer to the ICrmLogControl interface of the CRM clerk.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetLogControl(ICrmLogControl pLogControl);
    ///Notifies the CRM Compensator of the prepare phase of the transaction completion and that records are about to be
    ///delivered. Prepare notifications are never received during recovery, only during normal processing.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginPrepare();
    ///Delivers a log record in forward order during the prepare phase. This method can be received by the CRM
    ///Compensator multiple times, once for each log record that is written.
    ///Params:
    ///    crmLogRec = The log record, as a CrmLogRecordRead structure.
    ///    pfForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT PrepareRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    ///Notifies the CRM Compensator that it has had all the log records available during the prepare phase. The CRM
    ///Compensator votes on the transaction outcome by using the return parameter of this method.
    ///Params:
    ///    pfOkToPrepare = Indicates whether the prepare phase succeeded, in which case it is OK to commit this transaction.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndPrepare(BOOL* pfOkToPrepare);
    ///Notifies the CRM Compensator of the commit phase of the transaction completion and that records are about to be
    ///delivered.
    ///Params:
    ///    fRecovery = Indicates whether this method is being called during recovery (TRUE) or normal processing (FALSE).
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginCommit(BOOL fRecovery);
    ///Delivers a log record in forward order during the commit phase.
    ///Params:
    ///    crmLogRec = The log record, as a CrmLogRecordRead structure.
    ///    pfForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CommitRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    ///Notifies the CRM Compensator that it has delivered all the log records available during the commit phase. All log
    ///records for this transaction can be discarded from the log after this method has completed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndCommit();
    ///Notifies the CRM Compensator of the abort phase of the transaction completion and that records are about to be
    ///delivered.
    ///Params:
    ///    fRecovery = Indicates whether this method is being called during recovery.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT BeginAbort(BOOL fRecovery);
    ///Delivers a log record to the CRM Compensator during the abort phase.
    ///Params:
    ///    crmLogRec = The log record, as a CrmLogRecordRead structure.
    ///    pfForget = Indicates whether the delivered record should be forgotten.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AbortRecord(CrmLogRecordRead crmLogRec, BOOL* pfForget);
    ///Notifies the CRM Compensator that it has received all the log records available during the abort phase. All log
    ///records for this transaction can be discarded from the log after this method has completed.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EndAbort();
}

///Monitors the individual log records maintained by a specific CRM clerk for a given transaction.
@GUID("70C8E441-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitorLogRecords : IUnknown
{
    ///Retrieves the number of log records written by this CRM clerk.
    ///Params:
    ///    pVal = The number of log records written by this CRM clerk.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT get_Count(int* pVal);
    ///Retrieves the current state of the transaction.
    ///Params:
    ///    pVal = The current transaction state, represented by an CrmTransactionState enumeration value.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT get_TransactionState(CrmTransactionState* pVal);
    ///Retrieves a flag indicating whether the log records written by this CRM clerk were structured.
    ///Params:
    ///    pVal = Indicates whether the log records are structured. If this method is called before any log records have been
    ///           written, this parameter is <b>TRUE</b>.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT get_StructuredRecords(short* pVal);
    ///Retrieves an unstructured log record given its numeric index.
    ///Params:
    ///    dwIndex = The index of the required log record.
    ///    pCrmLogRec = The log record, as a CrmLogRecordRead structure.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The index is out of range. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> Attempting to read
    ///    unstructured records but written records are structured. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_TRANSACTIONCLOSED</b></dt> </dl> </td> <td width="60%"> The transaction has completed, and the
    ///    log records have been discarded from the log file. They are no longer available. </td> </tr> </table>
    ///    
    HRESULT GetLogRecord(uint dwIndex, CrmLogRecordRead* pCrmLogRec);
    ///Retrieves a structured log record given its numeric index.
    ///Params:
    ///    IndexNumber = The index of the required log record.
    ///    pLogRecord = The log record. See ICrmCompensatorVariants::PrepareRecordVariants for the format.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The index is out of range. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>XACT_E_WRONGSTATE</b></dt> </dl> </td> <td width="60%"> Attempting to read
    ///    unstructured records but written records are structured. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_TRANSACTIONCLOSED</b></dt> </dl> </td> <td width="60%"> The transaction has completed, and the
    ///    log records have been discarded from the log file. They are no longer available. </td> </tr> </table>
    ///    
    HRESULT GetLogRecordVariants(VARIANT IndexNumber, VARIANT* pLogRecord);
}

///Retrieves information about the state of clerks.
@GUID("70C8E442-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitorClerks : IDispatch
{
    ///Retrieves the instance CLSID of the CRM clerk for the specified index.
    ///Params:
    ///    Index = The index of the required CRM clerk as a numeric <b>Variant</b>.
    ///    pItem = A pointer to <b>Variant</b> string returning the instance CLSID corresponding to this numeric index.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is incorrect. </td> </tr>
    ///    </table>
    ///    
    HRESULT Item(VARIANT Index, VARIANT* pItem);
    ///Retrieves an enumerator for the instance CLSIDs of the CRM clerks.
    ///Params:
    ///    pVal = A reference to the returned IEnumVARIANT interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get__NewEnum(IUnknown* pVal);
    ///Retrieves the count of CRM clerks in the collection.
    ///Params:
    ///    pVal = The number of CRM clerks.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT get_Count(int* pVal);
    ///Retrieves the ProgId of the CRM Compensator for the specified index.
    ///Params:
    ///    Index = The index of the required CRM clerk as a numeric <b>Variant</b>, or the instance CLSID as a <b>Variant</b>
    ///            string.
    ///    pItem = The ProgId of the CRM Compensator.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is incorrect. </td> </tr>
    ///    </table>
    ///    
    HRESULT ProgIdCompensator(VARIANT Index, VARIANT* pItem);
    ///Retrieves the description of the CRM Compensator for the specified index.
    ///Params:
    ///    Index = The index of the required CRM clerk as a numeric <b>Variant</b>, or the instance CLSID as a <b>Variant</b>
    ///            string.
    ///    pItem = The description string originally provided by ICrmLogControl::RegisterCompensator.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is incorrect. </td> </tr>
    ///    </table>
    ///    
    HRESULT Description(VARIANT Index, VARIANT* pItem);
    ///Retrieves the unit of work (UOW) of the transaction for the specified index.
    ///Params:
    ///    Index = The index of the required CRM clerk as a numeric <b>Variant</b>, or the instance CLSID as a <b>Variant</b>
    ///            string.
    ///    pItem = The transaction UOW.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is incorrect. </td> </tr>
    ///    </table>
    ///    
    HRESULT TransactionUOW(VARIANT Index, VARIANT* pItem);
    ///Retrieves the activity ID of the CRM Worker for the specified index.
    ///Params:
    ///    Index = The index of the required CRM clerk as a numeric <b>Variant</b>, or the instance CLSID as a <b>Variant</b>
    ///            string.
    ///    pItem = The activity ID of the CRM Worker.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One of the arguments is incorrect. </td> </tr>
    ///    </table>
    ///    
    HRESULT ActivityId(VARIANT Index, VARIANT* pItem);
}

///Captures a snapshot of the current state of the CRM and holds a specific CRM clerk.
@GUID("70C8E443-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitor : IUnknown
{
    ///Retrieves a clerk collection object, which is a snapshot of the current state of the clerks.
    ///Params:
    ///    pClerks = An ICrmMonitorClerks pointer to a clerks collection object.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_RECOVERYINPROGRESS</b></dt> </dl> </td> <td width="60%"> Recovery of the CRM log file is still
    ///    in progress. </td> </tr> </table>
    ///    
    HRESULT GetClerks(ICrmMonitorClerks* pClerks);
    ///Retrieves a pointer on the specified clerk.
    ///Params:
    ///    Index = A <b>VARIANT</b> string containing the instance CLSID of the required CRM clerk.
    ///    pItem = A <b>VARIANT</b> IUnknown pointer returning the interface to the specified CRM clerk.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> One of the arguments is incorrect. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>XACT_E_CLERKNOTFOUND</b></dt> </dl> </td> <td width="60%"> The specified CRM clerk was not found. It
    ///    may have completed before it could be held. </td> </tr> </table>
    ///    
    HRESULT HoldClerk(VARIANT Index, VARIANT* pItem);
}

///Converts the log records to viewable format so that they can be presented using a generic monitoring tool.
@GUID("9C51D821-C98B-11D1-82FB-00A0C91EEDE9")
interface ICrmFormatLogRecords : IUnknown
{
    ///Retrieves the number of fields (columns) in a log record of the type used by this CRM Compensator.
    ///Params:
    ///    plColumnCount = The number of fields (columns) in the log record.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT GetColumnCount(int* plColumnCount);
    ///Retrieves the names of the fields (columns) so that they can be used as column headings when the information is
    ///presented.
    ///Params:
    ///    pHeaders = A <b>Variant</b> array containing the field names as <b>Variant</b> strings.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> </table>
    ///    
    HRESULT GetColumnHeaders(VARIANT* pHeaders);
    ///Formats one unstructured log record into an array of viewable fields.
    ///Params:
    ///    CrmLogRec = The unstructured log record to be formatted, as a CrmLogRecordRead structure.
    ///    pFormattedLogRecord = The formatted log record, as a <b>Variant</b> array of the fields in this log record as <b>Variant</b>
    ///                          strings.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The log record could not be formatted. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetColumn(CrmLogRecordRead CrmLogRec, VARIANT* pFormattedLogRecord);
    ///Formats one structured log record into an array of viewable fields.
    ///Params:
    ///    LogRecord = The structured log record to be formatted.
    ///    pFormattedLogRecord = A <b>Variant</b> array of the fields in this log record as <b>Variant</b> strings.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_POINTER</b></dt> </dl> </td> <td width="60%"> A
    ///    <b>NULL</b> pointer was provided as an argument. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The log record could not be formatted. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetColumnVariants(VARIANT LogRecord, VARIANT* pFormattedLogRecord);
}

///Configures the IIS intrinsics for the work that is done when calling the CoCreateActivity or CoEnterServiceDomain
///function.
@GUID("1A0CF920-D452-46F4-BC36-48118D54EA52")
interface IServiceIISIntrinsicsConfig : IUnknown
{
    ///Configures the IIS intrinsics for the enclosed work.
    ///Params:
    ///    iisIntrinsicsConfig = A value from the CSC_IISIntrinsicsConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT IISIntrinsicsConfig(CSC_IISIntrinsicsConfig iisIntrinsicsConfig);
}

///Configures the COM Transaction Integrator (COMTI) intrinsics for the work that is done when calling the
///CoCreateActivity or CoEnterServiceDomain function. The COMTI eases the task of wrapping mainframe transactions and
///business logic as COM components.
@GUID("09E6831E-04E1-4ED4-9D0F-E8B168BAFEAF")
interface IServiceComTIIntrinsicsConfig : IUnknown
{
    ///Configures the COMTI intrinsics for the enclosed work.
    ///Params:
    ///    comtiIntrinsicsConfig = A value from the CSC_COMTIIntrinsicsConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ComTIIntrinsicsConfig(CSC_COMTIIntrinsicsConfig comtiIntrinsicsConfig);
}

///Configures side-by-side assemblies for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("C7CD7379-F3F2-4634-811B-703281D73E08")
interface IServiceSxsConfig : IUnknown
{
    ///Configures the side-by-side assembly for the enclosed work.
    ///Params:
    ///    scsConfig = A value from the CSC_SxsConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SxsConfig(CSC_SxsConfig scsConfig);
    ///Sets the file name of the side-by-side assembly for the enclosed work.
    ///Params:
    ///    szSxsName = The file name for the side-by-side assembly.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SxsName(const(PWSTR) szSxsName);
    ///Sets the directory for the side-by-side assembly for the enclosed work.
    ///Params:
    ///    szSxsDirectory = The name of the directory for the side-by-side assembly that is to be used for the enclosed work.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SxsDirectory(const(PWSTR) szSxsDirectory);
}

///Used to check the configuration of the current side-by-side assembly.
@GUID("0FF5A96F-11FC-47D1-BAA6-25DD347E7242")
interface ICheckSxsConfig : IUnknown
{
    ///Determines whether the side-by-side assembly has the specified configuration.
    ///Params:
    ///    wszSxsName = A text string that contains the file name of the side-by-side assembly. The proper extension is added
    ///                 automatically.
    ///    wszSxsDirectory = A text string that contains the directory of the side-by-side assembly.
    ///    wszSxsAppName = A text string that contains the name of the application domain.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG and E_OUTOFMEMORY, as well as the following
    ///    values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The current side-by-side assembly has the specified
    ///    configuration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_FAIL</b></dt> </dl> </td> <td width="60%"> The
    ///    current side-by-side assembly does not have the specified configuration. </td> </tr> </table>
    ///    
    HRESULT IsSameSxsConfig(const(PWSTR) wszSxsName, const(PWSTR) wszSxsDirectory, const(PWSTR) wszSxsAppName);
}

///Determines whether to construct a new context based on the current context or to create a new context based solely on
///the information in CServiceConfig. A new context that is based on the current context can be modified by calls to the
///other interfaces of CServiceConfig.
@GUID("92186771-D3B4-4D77-A8EA-EE842D586F35")
interface IServiceInheritanceConfig : IUnknown
{
    ///Determines whether the containing context is based on the current context.
    ///Params:
    ///    inheritanceConfig = A value from the CSC_InheritanceConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ContainingContextTreatment(CSC_InheritanceConfig inheritanceConfig);
}

///Configures the thread pool of the activity object that is returned by calling CoCreateActivity.
@GUID("186D89BC-F277-4BCC-80D5-4DF7B836EF4A")
interface IServiceThreadPoolConfig : IUnknown
{
    ///Selects the thread pool in which the work submitted through the activity is to run.
    ///Params:
    ///    threadPool = A value from the CSC_ThreadPool enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SelectThreadPool(CSC_ThreadPool threadPool);
    ///Binds all work submitted by the activity to a single single-threaded apartment.
    ///Params:
    ///    binding = A value from the CSC_Binding enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT SetBindingInfo(CSC_Binding binding);
}

///Configures the transaction services for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("772B3FBE-6FFD-42FB-B5F8-8F9B260F3810")
interface IServiceTransactionConfigBase : IUnknown
{
    ///Configures how transactions are used in the enclosed work.
    ///Params:
    ///    transactionConfig = A value from the CSC_TransactionConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ConfigureTransaction(CSC_TransactionConfig transactionConfig);
    ///Sets the isolation level of the transactions.
    ///Params:
    ///    option = A value from the COMAdminTxIsolationLevelOptions enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT IsolationLevel(COMAdminTxIsolationLevelOptions option);
    ///Sets the transaction time-out for a new transaction.
    ///Params:
    ///    ulTimeoutSec = The transaction time-out, in seconds.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT TransactionTimeout(uint ulTimeoutSec);
    ///Enables you to run the enclosed code in an existing transaction that you provide.
    ///Params:
    ///    szTipURL = The Transaction Internet Protocol (TIP) URL of the existing transaction in which you want to run the enclosed
    ///               code.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT BringYourOwnTransaction(const(PWSTR) szTipURL);
    ///Sets the name that is used when transaction statistics are displayed.
    ///Params:
    ///    szTxDesc = The description of the transaction.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT NewTransactionDescription(const(PWSTR) szTxDesc);
}

///Configures the transaction services for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("59F4C2A3-D3D7-4A31-B6E4-6AB3177C50B9")
interface IServiceTransactionConfig : IServiceTransactionConfigBase
{
    ///Enables you to configure the transaction that you use when you bring your own transaction.
    ///Params:
    ///    pITxByot = A pointer to the <b>ITransaction</b> interface of the existing transaction in which you want to run the
    ///               enclosed code.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ConfigureBYOT(ITransaction pITxByot);
}

///Enables you to run a set of code in the scope of an existing transaction that you specify with a transaction proxy.
@GUID("33CAF1A1-FCB8-472B-B45E-967448DED6D8")
interface IServiceSysTxnConfig : IServiceTransactionConfig
{
    ///Enables you to run the enclosed code in the scope of an existing transaction that you specify with a transaction
    ///proxy.
    ///Params:
    ///    pTxProxy = The ITransactionProxy interface of the existing transaction in which you will run the enclosed code.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ConfigureBYOTSysTxn(ITransactionProxy pTxProxy);
}

///Configures the synchronization for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("FD880E81-6DCE-4C58-AF83-A208846C0030")
interface IServiceSynchronizationConfig : IUnknown
{
    ///Configures the synchronization for the enclosed work.
    ///Params:
    ///    synchConfig = A value from the CSC_SynchronizationConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT ConfigureSynchronization(CSC_SynchronizationConfig synchConfig);
}

///Configures the tracker property for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("6C3A3E1D-0BA6-4036-B76F-D0404DB816C9")
interface IServiceTrackerConfig : IUnknown
{
    ///Configures the tracker property for the enclosed work.
    ///Params:
    ///    trackerConfig = A value from the CSC_TrackerConfig enumeration.
    ///    szTrackerAppName = The application identifier under which tracker information is reported.
    ///    szTrackerCtxName = The context name under which tracker information is reported.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT TrackerConfig(CSC_TrackerConfig trackerConfig, const(PWSTR) szTrackerAppName, 
                          const(PWSTR) szTrackerCtxName);
}

///Configures how partitions are used for the work that is done when calling either CoCreateActivity or
///CoEnterServiceDomain.
@GUID("80182D03-5EA4-4831-AE97-55BEFFC2E590")
interface IServicePartitionConfig : IUnknown
{
    ///Configures how partitions are used for the enclosed work.
    ///Params:
    ///    partitionConfig = A value from the CSC_PartitionConfig enumeration.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT PartitionConfig(CSC_PartitionConfig partitionConfig);
    ///Sets the GUID for the partition that is used for the enclosed work.
    ///Params:
    ///    guidPartitionID = A GUID that is used to specify the partition that is to be used to run the enclosed work.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT PartitionID(const(GUID)* guidPartitionID);
}

///Used to implement the batch work that is submitted through the activity created by CoCreateActivity.
@GUID("BD3E2E12-42DD-40F4-A09A-95A50C58304B")
interface IServiceCall : IUnknown
{
    ///Triggers the execution of the batch work implemented in this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT OnCall();
}

///Used to implement error trapping on the asynchronous batch work that is submitted through the activity created by
///CoCreateActivity.
@GUID("FE6777FB-A674-4177-8F32-6D707E113484")
interface IAsyncErrorNotify : IUnknown
{
    ///Called by COM+ when an error occurs in your asynchronous batch work.
    ///Params:
    ///    hr = The <b>HRESULT</b> value of the error that occurred while your batch work was running asynchronously.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT OnError(HRESULT hr);
}

///Used to call the batch work that is submitted through the activity created by CoCreateActivity.
@GUID("67532E0C-9E2F-4450-A354-035633944E17")
interface IServiceActivity : IUnknown
{
    ///Performs the user-defined work synchronously.
    ///Params:
    ///    pIServiceCall = A pointer to the IServiceCall interface that is used to implement the batch work.
    ///Returns:
    ///    This method always returns the <b>HRESULT</b> value returned by the OnCall method of the IServiceCall
    ///    interface.
    ///    
    HRESULT SynchronousCall(IServiceCall pIServiceCall);
    ///Performs the user-defined work asynchronously.
    ///Params:
    ///    pIServiceCall = A pointer to the IServiceCall interface that is used to implement the batch work.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_FAIL, as well as the
    ///    following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The batch work was accepted by the activity to run
    ///    asynchronously. This return value does not necessarily mean that the batch work successfully completed. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_ASYNC_WORK_REJECTED</b></dt> </dl> </td> <td width="60%"> The
    ///    batch work cannot be added to the asynchronous work queue of the activity. </td> </tr> </table>
    ///    
    HRESULT AsynchronousCall(IServiceCall pIServiceCall);
    ///Binds the user-defined batch work to the current thread.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT BindToCurrentThread();
    ///Unbinds the user-defined batch work from the thread on which it is running.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_FAIL, and S_OK.
    ///    
    HRESULT UnbindFromThread();
}

///Used to control the behavior of thread pools.
@GUID("51372AF7-CAE7-11CF-BE81-00AA00A2FA25")
interface IThreadPoolKnobs : IUnknown
{
    ///Retrieves the maximum number of threads that are allowed in the pool.
    ///Params:
    ///    plcMaxThreads = The maximum number of threads allowed in the pool. A zero value indicates that the pool can grow without
    ///                    limit.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetMaxThreads(int* plcMaxThreads);
    ///Retrieves the number of threads currently in the pool.
    ///Params:
    ///    plcCurrentThreads = The number of threads currently in the pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCurrentThreads(int* plcCurrentThreads);
    ///Sets the maximum number of threads to be allowed in the pool.
    ///Params:
    ///    lcMaxThreads = The maximum number of threads allowed in the pool. A zero value indicates that the pool can grow without
    ///                   limit.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetMaxThreads(int lcMaxThreads);
    ///Retrieves the number of milliseconds a pooled thread can idle before being destroyed.
    ///Params:
    ///    pmsecDeleteDelay = The number of milliseconds a pooled thread can idle before being destroyed. A zero value indicates that
    ///                       threads are never automatically deleted.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetDeleteDelay(int* pmsecDeleteDelay);
    ///Sets the number of milliseconds a pooled thread can idle before being destroyed.
    ///Params:
    ///    msecDeleteDelay = The number of milliseconds a pooled thread can idle before being destroyed. A zero value indicates that
    ///                      threads are never automatically deleted.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetDeleteDelay(int msecDeleteDelay);
    ///Retrieves the maximum number of asynchronous execution requests that can be simultaneously queued.
    ///Params:
    ///    plcMaxQueuedRequests = The maximum number of asynchronous execution requests that can be simultaneously queued. A zero value
    ///                           indicates that the queue can grow without limit.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetMaxQueuedRequests(int* plcMaxQueuedRequests);
    ///Retrieves the number of asynchronous execution requests that are currently queued.
    ///Params:
    ///    plcCurrentQueuedRequests = The number of asynchronous execution requests currently queued.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetCurrentQueuedRequests(int* plcCurrentQueuedRequests);
    ///Sets the maximum number of asynchronous execution requests that can be simultaneously queued.
    ///Params:
    ///    lcMaxQueuedRequests = The maximum number of asynchronous execution requests that can be simultaneously queued. A zero value
    ///                          indicates that the queue can grow without limit.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetMaxQueuedRequests(int lcMaxQueuedRequests);
    ///Sets the minimum number of threads to be maintained in the pool.
    ///Params:
    ///    lcMinThreads = The minimum number of threads to be maintained in the pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetMinThreads(int lcMinThreads);
    ///Sets the threshold number of execution requests above which a new thread is added to the pool.
    ///Params:
    ///    lcQueueDepth = The threshold number of execution requests above which a new thread is added to the pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetQueueDepth(int lcQueueDepth);
}

@GUID("324B64FA-33B6-11D2-98B7-00C04F8EE1C4")
interface IComStaThreadPoolKnobs : IUnknown
{
    HRESULT SetMinThreadCount(uint minThreads);
    HRESULT GetMinThreadCount(uint* minThreads);
    HRESULT SetMaxThreadCount(uint maxThreads);
    HRESULT GetMaxThreadCount(uint* maxThreads);
    HRESULT SetActivityPerThread(uint activitiesPerThread);
    HRESULT GetActivityPerThread(uint* activitiesPerThread);
    HRESULT SetActivityRatio(double activityRatio);
    HRESULT GetActivityRatio(double* activityRatio);
    HRESULT GetThreadCount(uint* pdwThreads);
    HRESULT GetQueueDepth(uint* pdwQDepth);
    HRESULT SetQueueDepth(int dwQDepth);
}

@GUID("F9A76D2E-76A5-43EB-A0C4-49BEC8E48480")
interface IComMtaThreadPoolKnobs : IUnknown
{
    HRESULT MTASetMaxThreadCount(uint dwMaxThreads);
    HRESULT MTAGetMaxThreadCount(uint* pdwMaxThreads);
    HRESULT MTASetThrottleValue(uint dwThrottle);
    HRESULT MTAGetThrottleValue(uint* pdwThrottle);
}

@GUID("73707523-FF9A-4974-BF84-2108DC213740")
interface IComStaThreadPoolKnobs2 : IComStaThreadPoolKnobs
{
    HRESULT GetMaxCPULoad(uint* pdwLoad);
    HRESULT SetMaxCPULoad(int pdwLoad);
    HRESULT GetCPUMetricEnabled(BOOL* pbMetricEnabled);
    HRESULT SetCPUMetricEnabled(BOOL bMetricEnabled);
    HRESULT GetCreateThreadsAggressively(BOOL* pbMetricEnabled);
    HRESULT SetCreateThreadsAggressively(BOOL bMetricEnabled);
    HRESULT GetMaxCSR(uint* pdwCSR);
    HRESULT SetMaxCSR(int dwCSR);
    HRESULT GetWaitTimeForThreadCleanup(uint* pdwThreadCleanupWaitTime);
    HRESULT SetWaitTimeForThreadCleanup(int dwThreadCleanupWaitTime);
}

///Provides methods that can be called whenever Dllhost.exe starts up or shuts down.
@GUID("1113F52D-DC7F-4943-AED6-88D04027E32A")
interface IProcessInitializer : IUnknown
{
    ///Called when Dllhost.exe starts.
    ///Params:
    ///    punkProcessControl = A pointer to the IUnknown interface of the COM component starting up. <b>Windows XP/2000: </b>This parameter
    ///                         is always <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Startup(IUnknown punkProcessControl);
    ///Called when Dllhost.exe shuts down.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Shutdown();
}

///Used to configure an object pool.
@GUID("A9690656-5BCA-470C-8451-250C1F43A33E")
interface IServicePoolConfig : IUnknown
{
    ///Sets the maximum number of objects in the pool.
    ///Params:
    ///    dwMaxPool = The maximum number of objects.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_MaxPoolSize(uint dwMaxPool);
    ///Retrieves the maximum number of objects in the pool.
    ///Params:
    ///    pdwMaxPool = The maximum number of objects.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_MaxPoolSize(uint* pdwMaxPool);
    ///Sets the minimum number of objects in the pool.
    ///Params:
    ///    dwMinPool = The minimum number of objects.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_MinPoolSize(uint dwMinPool);
    ///Retrieves the minimum number of objects in the pool.
    ///Params:
    ///    pdwMinPool = The minimum number of objects.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_MinPoolSize(uint* pdwMinPool);
    ///Sets the time-out interval for activating a pooled object.
    ///Params:
    ///    dwCreationTimeout = The time-out interval.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_CreationTimeout(uint dwCreationTimeout);
    ///Retrieves the time-out interval for activating a pooled object.
    ///Params:
    ///    pdwCreationTimeout = The time-out interval.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_CreationTimeout(uint* pdwCreationTimeout);
    ///Sets whether objects involved in transactions are held until the transaction completes.
    ///Params:
    ///    fTxAffinity = <b>TRUE</b> if the objects are to be held and <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_TransactionAffinity(BOOL fTxAffinity);
    ///Determines whether objects involved in transactions are held until the transaction completes.
    ///Params:
    ///    pfTxAffinity = <b>TRUE</b> if the objects are held and <b>FALSE</b> otherwise.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_TransactionAffinity(BOOL* pfTxAffinity);
    ///Sets a class factory for the pooled objects.
    ///Params:
    ///    pFactory = An IClassFactory interface pointer.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT put_ClassFactory(IClassFactory pFactory);
    ///Retrieves a class factory for the pooled objects.
    ///Params:
    ///    pFactory = A pointer to the IClassFactory interface pointer.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT get_ClassFactory(IClassFactory* pFactory);
}

///Used to manage a COM+ object pool.
@GUID("B302DF81-EA45-451E-99A2-09F9FD1B1E13")
interface IServicePool : IUnknown
{
    ///Initializes an object pool.
    ///Params:
    ///    pPoolConfig = An object supporting the IServicePoolConfig interface that describes the configuration of the object pool.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>CO_E_ALREADYINITIALIZED</b></dt> </dl> </td> <td
    ///    width="60%"> Initialize has already been called. </td> </tr> </table>
    ///    
    HRESULT Initialize(IUnknown pPoolConfig);
    HRESULT GetObjectA(const(GUID)* riid, void** ppv);
    ///Shuts down an object pool.
    ///Returns:
    ///    This method returns S_OK.
    ///    
    HRESULT Shutdown();
}

///Describes how a managed object is used in the COM+ object pool.
@GUID("C5DA4BEA-1B42-4437-8926-B6A38860A770")
interface IManagedPooledObj : IUnknown
{
    ///Sets whether the managed object should go back into the COM+ object pool.
    ///Params:
    ///    m_bHeld = Indicates whether the managed object should go back into the COM+ object pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetHeld(BOOL m_bHeld);
}

///Enables an object to be notified before it is released from a COM+ object pool.
@GUID("DA91B74E-5388-4783-949D-C1CD5FB00506")
interface IManagedPoolAction : IUnknown
{
    ///Called when a COM+ object pool drops the last reference to the object that implements it.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT LastRelease();
}

///Describes the stub for a managed object.
@GUID("1427C51A-4584-49D8-90A0-C50D8086CBE9")
interface IManagedObjectInfo : IUnknown
{
    ///Retrieves the IUnknown interface that is associated with the managed object.
    ///Params:
    ///    pUnk = A reference to the IUnknown interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetIUnknown(IUnknown* pUnk);
    ///Retrieves the IObjectControl interface that is associated with the managed object.
    ///Params:
    ///    pCtrl = A reference to the IObjectControl interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetIObjectControl(IObjectControl* pCtrl);
    ///Sets whether the managed object belongs to the COM+ object pool.
    ///Params:
    ///    bInPool = Indicates whether the managed object belongs to the COM+ object pool.
    ///    pPooledObj = A reference to IManagedPooledObj that describes how this managed object is used in the COM+ object pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetInPool(BOOL bInPool, IManagedPooledObj pPooledObj);
    ///Sets whether the managed object holds a strong or a weak reference to the COM+ context.
    ///Params:
    ///    bStrong = Indicates whether the managed object holds a strong or a weak reference to the COM+ context. A strong
    ///              reference keeps the object alive and prevents it from being destroyed during garbage collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetWrapperStrength(BOOL bStrong);
}

///Binds a managed object to an application domain, which is an isolated environment where applications execute. It
///provides callbacks to enter an application domain and for shutdown of the application domain.
@GUID("C7B67079-8255-42C6-9EC0-6994A3548780")
interface IAppDomainHelper : IDispatch
{
    ///Binds the calling object to the current application domain and provides a callback function for shutdown that is
    ///executed when the application domain is unloaded.
    ///Params:
    ///    pUnkAD = Pointer to the IUnknown of the current application domain.
    ///    __MIDL__IAppDomainHelper0000 = Reference to the shutdown function that is executed when the application domain is unloaded. The parameter of
    ///                                   this function, <i>pv</i>, comes from the <i>pPool</i> parameter, which is defined next.
    ///    pPool = This parameter is used to provide any data that the shutdown function might need.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Initialize(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0000, void* pPool);
    ///Switches into a given application domain (which the calling object must be bound to), executes the supplied
    ///callback function in that application domain, and then returns to the original application domain.
    ///Params:
    ///    pUnkAD = Reference to the IUnknown of the application domain that you want to switch to. The object calling
    ///             <b>DoCallback</b> must be bound to that application domain.
    ///    __MIDL__IAppDomainHelper0001 = Reference to the callback function. This function is executed in the application domain that you switched to.
    ///                                   The parameter of this function, <i>pv</i>, comes from the <i>pPool</i> parameter, which is defined next.
    ///    pPool = This parameter is used to provide any data that the callback function might need.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT DoCallback(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0001, void* pPool);
}

///Retrieves information about an assembly when using managed code in the .NET Framework common language runtime.
@GUID("391FFBB9-A8EE-432A-ABC8-BAA238DAB90F")
interface IAssemblyLocator : IDispatch
{
    ///Used to get the names of the modules that are contained in an assembly.
    ///Params:
    ///    applicationDir = The directory containing the application.
    ///    applicationName = The name of the application domain.
    ///    assemblyName = The name of the assembly.
    ///    pModules = An array listing the names of the modules in the assembly.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetModules(BSTR applicationDir, BSTR applicationName, BSTR assemblyName, SAFEARRAY** pModules);
}

///Used to create and destroy stubs for managed objects within the current COM+ context.
@GUID("A5F325AF-572F-46DA-B8AB-827C3D95D99E")
interface IManagedActivationEvents : IUnknown
{
    ///Creates a stub for a managed object within the current COM+ context.
    ///Params:
    ///    pInfo = A pointer to IManagedObjectInfo that describes the stub for a managed object.
    ///    fDist = Indicates whether the created stub is the distinguished stub. A distinguished stub is the stub that controls
    ///            the lifetime of the current COM+ context.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT CreateManagedStub(IManagedObjectInfo pInfo, BOOL fDist);
    ///Destroys a stub that was created by CreateManagedStub.
    ///Params:
    ///    pInfo = A pointer to IManagedObjectInfo that describes the stub for a managed object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT DestroyManagedStub(IManagedObjectInfo pInfo);
}

///Describes an event class that notifies subscribers whenever a method on the object that implements it either is
///called or returns from a call. The events are published to the subscriber using the COM+ Events service, a loosely
///coupled events system that stores event information from different publishers in an event store in the COM+ catalog.
@GUID("2732FD59-B2B4-4D44-878C-8B8F09626008")
interface ISendMethodEvents : IUnknown
{
    ///Generated when a method is called through a component interface.
    ///Params:
    ///    pIdentity = A pointer to the interface used to call the method.
    ///    riid = The ID of the interface used to call the method.
    ///    dwMeth = The method called.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SendMethodCall(const(void)* pIdentity, const(GUID)* riid, uint dwMeth);
    ///Generated when a method called through a component interface returns control to the caller.
    ///Params:
    ///    pIdentity = A pointer to the interface used to call the method.
    ///    riid = The ID of the interface used to call the method.
    ///    dwMeth = The method called.
    ///    hrCall = The result returned by the method call.
    ///    hrServer = The result returned by the DCOM call to the server on which the component lives.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SendMethodReturn(const(void)* pIdentity, const(GUID)* riid, uint dwMeth, HRESULT hrCall, 
                             HRESULT hrServer);
}

///Maintains a list of pooled objects, keyed by IObjPool, that are used until the transaction completes.
@GUID("C5FEB7C1-346A-11D1-B1CC-00AA00BA3258")
interface ITransactionResourcePool : IUnknown
{
    ///Adds an object to the list of pooled objects.
    ///Params:
    ///    pPool = The key to each object in the transaction resource pool. It determines the type of pooled object to add to
    ///            the list.
    ///    pUnk = A reference to the IUnknown of the pooled object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT PutResource(IObjPool pPool, IUnknown pUnk);
    ///Retrieves an object from the list of pooled objects.
    ///Params:
    ///    pPool = The key to each object in the transaction resource pool. It determines the type of pooled object to retrieve
    ///            from the list.
    ///    ppUnk = A reference to the IUnknown of the pooled object. The object that is retrieved must have the same IObjPool
    ///            pointer as an object that was put on the list by using PutResource.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, and E_UNEXPECTED, as well as
    ///    the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_FAILED </b></dt> </dl> </td> <td width="60%"> The <i>pPool</i> parameter did not
    ///    match any object on the list of pooled objects. </td> </tr> </table>
    ///    
    HRESULT GetResource(IObjPool pPool, IUnknown* ppUnk);
}

///<p class="CCE_Message">[<b>IMTSCall</b> is available for use in the operating systems specified in the Requirements
///section. It may be altered of unavailable in subsequent versions. Instead, use IServiceCall.] Implements the batch
///work that is submitted through the activity created by the MTSCreateActivity function.
@GUID("51372AEF-CAE7-11CF-BE81-00AA00A2FA25")
interface IMTSCall : IUnknown
{
    ///<p class="CCE_Message">[IMTSCall is available for use in the operating systems specified in the Requirements
    ///section. It may be altered of unavailable in subsequent versions. Instead, use IServiceCall.] Triggers the
    ///execution of the batch work implemented in this method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT OnCall();
}

///Provides access to context object properties. Each object context can have a user context property, which implements
///<b>IContextProperties</b>.
@GUID("D396DA85-BF8F-11D1-BBAE-00C04FC2FA5F")
interface IContextProperties : IUnknown
{
    ///Retrieves the number of context object properties.
    ///Params:
    ///    plCount = The number of context object properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Count(int* plCount);
    ///Retrieves a context object property.
    ///Params:
    ///    name = The name of the context object property to be retrieved. The following are IIS intrinsic properties. <ul>
    ///           <li>Application</li> <li>Request</li> <li>Response</li> <li>Server</li> <li>Session</li> </ul> The following
    ///           is the COMTI instrinsic property: <ul> <li>host-security-callback.cedar.microsoft.com</li> </ul>
    ///    pProperty = A pointer to the property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    ///Retrieves a reference to an enumerator for the context object properties.
    ///Params:
    ///    ppenum = A reference to the IEnumNames interface on a new enumerator object that you can use to iterate through all
    ///             the context object properties.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT EnumNames(IEnumNames* ppenum);
    ///Sets a context object property.
    ///Params:
    ///    name = The name of the context object property to be set. See GetProperty for a list of valid property names.
    ///    property = The context object property value.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT SetProperty(BSTR name, VARIANT property);
    ///Removes a context object property.
    ///Params:
    ///    name = The name of the context object property to be removed. See GetProperty for a list of valid property names.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT RemoveProperty(BSTR name);
}

///Represents the key to each object in the transaction resource pool.
@GUID("7D8805A0-2EA7-11D1-B1CC-00AA00BA3258")
interface IObjPool : IUnknown
{
    void Reserved1();
    void Reserved2();
    void Reserved3();
    void Reserved4();
    ///Destroys the pooled object when the transaction ends.
    ///Params:
    ///    pObj = A reference to the IUnknown of the pooled object.
    void PutEndTx(IUnknown pObj);
    void Reserved5();
    void Reserved6();
}

///Used to get the transaction resource pool.
@GUID("788EA814-87B1-11D1-BBA6-00C04FC2FA5F")
interface ITransactionProperty : IUnknown
{
    void    Reserved1();
    void    Reserved2();
    void    Reserved3();
    void    Reserved4();
    void    Reserved5();
    void    Reserved6();
    void    Reserved7();
    void    Reserved8();
    void    Reserved9();
    ///Retrieves the resource pool that is associated with this context's transaction.
    ///Params:
    ///    ppTxPool = A reference to the transaction resource pool.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetTransactionResourcePool(ITransactionResourcePool* ppTxPool);
    void    Reserved10();
    void    Reserved11();
    void    Reserved12();
    void    Reserved13();
    void    Reserved14();
    void    Reserved15();
    void    Reserved16();
    void    Reserved17();
}

///<p class="CCE_Message">[<b>IMTSActivity</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered of unavailable in subsequent versions. Instead, use IServiceActivity.]
///Submits batch work through the activity created by the MTSCreateActivity function.
@GUID("51372AF0-CAE7-11CF-BE81-00AA00A2FA25")
interface IMTSActivity : IUnknown
{
    ///Performs the user-defined work synchronously.
    ///Params:
    ///    pCall = A pointer to the IMTSCall interface that is used to implement the batch work.
    ///Returns:
    ///    This method always returns the <b>HRESULT</b> returned by the OnCall method of the IMTSCall interface.
    ///    
    HRESULT SynchronousCall(IMTSCall pCall);
    ///Performs the user-defined work asynchronously.
    ///Params:
    ///    pCall = A pointer to the IMTSCall interface that is used to implement the batch work.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT AsyncCall(IMTSCall pCall);
    void    Reserved1();
    ///Binds the batch work that is submitted using IMTSActivity::AsyncCall or IMTSActivity::SynchronousCall to the
    ///current single-threaded apartment (STA). This method is designed to be called from the implementation of the
    ///IMTSCall::OnCall method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT BindToCurrentThread();
    ///Unbinds the batch work that is submitted using IMTSActivity::AsyncCall or IMTSActivity::SynchronousCall from the
    ///thread on which it is running. It has no effect if the batch work was not previously bound to a thread. This
    ///method is designed to be called from the implementation of the IMTSCall::OnCall method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT UnbindFromThread();
}

///Provides access to the event data store.
@GUID("4E14FB9F-2E22-11D1-9964-00C04FBBB345")
interface IEventSystem : IDispatch
{
    ///Retrieves a collection of subscription or event objects from the event data store.
    ///Params:
    ///    progID = The ProgID of the object class to be queried. This must be a valid event object class identifier. This
    ///             parameter can be one of the following values: <ul> <li>PROGID_EventClass</li>
    ///             <li>PROGID_EventClassCollection</li> <li>PROGID_EventSubscription</li>
    ///             <li>PROGID_EventSubscriptionCollection</li> </ul>
    ///    queryCriteria = The query criteria. For details on forming a valid expression for this parameter, see the Remarks section
    ///                    below.
    ///    errorIndex = The location, expressed as an offset, of an error in the <i>queryCriteria</i> parameter.
    ///    ppInterface = Address of a pointer to the object obtained as a result of the query. This parameter cannot be <b>NULL</b>.
    ///                  Depending on the object specified by the <i>progID</i> parameter, this is a pointer to one of the following
    ///                  interfaces: <ul> <li> IEventClass </li> <li> IEventObjectCollection </li> <li> IEventSubscription </li> </ul>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED, and
    ///    E_FAIL, as well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A
    ///    syntax error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> </table>
    ///    
    HRESULT Query(BSTR progID, BSTR queryCriteria, int* errorIndex, IUnknown* ppInterface);
    ///Creates or modifies an event or subscription object within the event system.
    ///Params:
    ///    ProgID = The ProgID of the event object to be added. This must be a valid event object class identifier. The possible
    ///             values are PROGID_EventSubscription and PROGID_EventClass.
    ///    pInterface = A pointer to the object to be added. Depending on the object specified by the <i>ProgID</i> parameter, this
    ///                 is a pointer to the IEventSubscription or IEventClass interface.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INVALID_PER_USER_SID</b></dt> </dl> </td> <td width="60%">
    ///    The owner SID on a per-user subscription does not exist. </td> </tr> </table>
    ///    
    HRESULT Store(BSTR ProgID, IUnknown pInterface);
    ///Removes one or more subscription or event objects from the event data store.
    ///Params:
    ///    progID = The ProgID of the object class to be removed. This must be a valid event object class identifier. This
    ///             parameter can be one of the following values: <ul> <li>PROGID_EventClass</li>
    ///             <li>PROGID_EventClassCollection</li> <li>PROGID_EventSubscription</li>
    ///             <li>PROGID_EventSubscriptionCollection</li> </ul>
    ///    queryCriteria = The query criteria. For details on forming a valid expression for this parameter, see the Remarks section
    ///                    below.
    ///    errorIndex = The location, expressed as an offset, of an error in the <i>queryCriteria</i> parameter.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A syntax
    ///    error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_NOT_ALL_REMOVED</b></dt> </dl> </td> <td
    ///    width="60%"> Not all of the requested objects could be removed. </td> </tr> </table>
    ///    
    HRESULT Remove(BSTR progID, BSTR queryCriteria, int* errorIndex);
    ///Retrieves the CLSID of an event class object that notifies the caller of changes to the event store. This
    ///property is read-only.
    HRESULT get_EventObjectChangeEventClassID(BSTR* pbstrEventClassID);
    ///Retrieves a collection of subscription or event objects from the event data store.
    ///Params:
    ///    progID = The ProgID of the object class to be queried. This must be a valid event object class identifier. This
    ///             parameter can be one of the following values: <ul> <li>PROGID_EventClass</li>
    ///             <li>PROGID_EventClassCollection</li> <li>PROGID_EventSubscription</li>
    ///             <li>PROGID_EventSubscriptionCollection</li> </ul>
    ///    queryCriteria = The query criteria. For details on forming a valid expression for this parameter, see the Remarks section
    ///                    below.
    ///    ppInterface = Address of a pointer to the object obtained as a result of the query. This parameter cannot be <b>NULL</b>.
    ///                  Depending on the object specified by the <i>progID</i> parameter, this is a pointer to one of the following
    ///                  interfaces: <ul> <li> IEventClass </li> <li> IEventObjectCollection </li> <li> IEventSubscription </li> </ul>
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED, and
    ///    E_FAIL, as well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A
    ///    syntax error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> </table>
    ///    
    HRESULT QueryS(BSTR progID, BSTR queryCriteria, IUnknown* ppInterface);
    ///Removes one or more subscription or event objects from the event data store.
    ///Params:
    ///    progID = The ProgID of the object class to be removed. This must be a valid event object class identifier. This
    ///             parameter can be one of the following values: <ul> <li>PROGID_EventClass</li>
    ///             <li>PROGID_EventClassCollection</li> <li>PROGID_EventSubscription</li>
    ///             <li>PROGID_EventSubscriptionCollection</li> </ul>
    ///    queryCriteria = The query criteria. For details on forming a valid expression for this parameter, see the Remarks section
    ///                    below.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A syntax
    ///    error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_NOT_ALL_REMOVED</b></dt> </dl> </td> <td
    ///    width="60%"> Not all of the requested objects could be removed. </td> </tr> </table>
    ///    
    HRESULT RemoveS(BSTR progID, BSTR queryCriteria);
}

///Associates a class of event objects with the event interface those objects implement. <b>IEventClass</b> is the
///interface that is implemented by the CLSID_CEventClass objects, which are different than event class objects that are
///co-created by a publisher for the purpose of firing events. An event object implements the
///IMultiInterfaceEventControl event interface. While this object can be used to configure event classes in the event
///store, the preferred method is to use the COM+ Administration interfaces. However, not all of the properties exposed
///by the <b>IEventClass</b> interface are available through the COM+ Administration interfaces.
@GUID("FB2B72A0-7A68-11D1-88F9-0080C7D771BF")
interface IEventClass : IDispatch
{
    ///The CLSID for the event class object. This property is read/write.
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    ///The CLSID for the event class object. This property is read/write.
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    ///The ProgID for the event class object. This property is read/write.
    HRESULT get_EventClassName(BSTR* pbstrEventClassName);
    ///The ProgID for the event class object. This property is read/write.
    HRESULT put_EventClassName(BSTR bstrEventClassName);
    ///The security ID of the event class object's creator. This property is supported only for backward compatibility.
    ///This property is read/write.
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    ///The security ID of the event class object's creator. This property is supported only for backward compatibility.
    ///This property is read/write.
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    ///The ID of the event interface on the event class object. This property is supported only for backward
    ///compatibility. This property is read/write.
    HRESULT get_FiringInterfaceID(BSTR* pbstrFiringInterfaceID);
    ///The ID of the event interface on the event class object. This property is supported only for backward
    ///compatibility. This property is read/write.
    HRESULT put_FiringInterfaceID(BSTR bstrFiringInterfaceID);
    ///A displayable text description of the event class object. This property is read/write.
    HRESULT get_Description(BSTR* pbstrDescription);
    ///A displayable text description of the event class object. This property is read/write.
    HRESULT put_Description(BSTR bstrDescription);
    ///The CLSID of a component that can assist in adding properties into the property bag of a subscription object.
    ///This property is supported only for backward compatibility. This property is read/write.
    HRESULT get_CustomConfigCLSID(BSTR* pbstrCustomConfigCLSID);
    ///The CLSID of a component that can assist in adding properties into the property bag of a subscription object.
    ///This property is supported only for backward compatibility. This property is read/write.
    HRESULT put_CustomConfigCLSID(BSTR bstrCustomConfigCLSID);
    ///The path of the type library that contains the description of the event interface. This property is read/write.
    HRESULT get_TypeLib(BSTR* pbstrTypeLib);
    ///The path of the type library that contains the description of the event interface. This property is read/write.
    HRESULT put_TypeLib(BSTR bstrTypeLib);
}

///Used to set and obtain data on event class objects. This interface extends the IEventClass interface.
@GUID("FB2B72A1-7A68-11D1-88F9-0080C7D771BF")
interface IEventClass2 : IEventClass
{
    ///The CLSID for the event publisher. This property is read/write.
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    ///The CLSID for the event publisher. This property is read/write.
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    ///The CLSID of the object implementing IMultiInterfacePublisherFilter. This property is read/write.
    HRESULT get_MultiInterfacePublisherFilterCLSID(BSTR* pbstrPubFilCLSID);
    ///The CLSID of the object implementing IMultiInterfacePublisherFilter. This property is read/write.
    HRESULT put_MultiInterfacePublisherFilterCLSID(BSTR bstrPubFilCLSID);
    ///Indicates whether the event class can be activated in-process. This property is read/write.
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    ///Indicates whether the event class can be activated in-process. This property is read/write.
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    ///Indicates whether events of this class can be fired in parallel. This property is read/write.
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
    ///Indicates whether events of this class can be fired in parallel. This property is read/write.
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

///Specifies information about the relationship between an event subscriber and an event to which it is subscribing. It
///is used by publisher filters.
@GUID("4A6B0E15-2E38-11D1-9965-00C04FBBB345")
interface IEventSubscription : IDispatch
{
    ///The unique ID for the subscription object. This property is read/write.
    HRESULT get_SubscriptionID(BSTR* pbstrSubscriptionID);
    ///The unique ID for the subscription object. This property is read/write.
    HRESULT put_SubscriptionID(BSTR bstrSubscriptionID);
    ///A displayable name for the subscription object. This property is read/write.
    HRESULT get_SubscriptionName(BSTR* pbstrSubscriptionName);
    ///A displayable name for the subscription object. This property is read/write.
    HRESULT put_SubscriptionName(BSTR bstrSubscriptionName);
    ///The unique ID of the event publisher. This property is read/write.
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    ///The unique ID of the event publisher. This property is read/write.
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    ///The unique ID of the event class associated with the subscription. This property is read/write.
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    ///The unique ID of the event class associated with the subscription. This property is read/write.
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    ///The name of the event method. This property is read/write.
    HRESULT get_MethodName(BSTR* pbstrMethodName);
    ///The name of the event method. This property is read/write.
    HRESULT put_MethodName(BSTR bstrMethodName);
    ///The CLSID of the subscriber component (for a persistent subscription). This property is read/write.
    HRESULT get_SubscriberCLSID(BSTR* pbstrSubscriberCLSID);
    ///The CLSID of the subscriber component (for a persistent subscription). This property is read/write.
    HRESULT put_SubscriberCLSID(BSTR bstrSubscriberCLSID);
    ///A marshaled pointer to the event interface on the subscriber (for a transient subscription). This property is
    ///read/write.
    HRESULT get_SubscriberInterface(IUnknown* ppSubscriberInterface);
    ///A marshaled pointer to the event interface on the subscriber (for a transient subscription). This property is
    ///read/write.
    HRESULT put_SubscriberInterface(IUnknown pSubscriberInterface);
    ///Indicates whether the subscription receives the event only if the owner of the subscription is logged on to the
    ///same computer as the publisher. This property is read/write.
    HRESULT get_PerUser(BOOL* pfPerUser);
    ///Indicates whether the subscription receives the event only if the owner of the subscription is logged on to the
    ///same computer as the publisher. This property is read/write.
    HRESULT put_PerUser(BOOL fPerUser);
    ///The security ID of the subscription's creator. This property is read/write.
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    ///The security ID of the subscription's creator. This property is read/write.
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    ///Indicates whether the subscription is enabled. This property is read/write.
    HRESULT get_Enabled(BOOL* pfEnabled);
    ///Indicates whether the subscription is enabled. This property is read/write.
    HRESULT put_Enabled(BOOL fEnabled);
    ///A displayable text description of the subscription. This property is read/write.
    HRESULT get_Description(BSTR* pbstrDescription);
    ///A displayable text description of the subscription. This property is read/write.
    HRESULT put_Description(BSTR bstrDescription);
    ///The name of the computer on which the subscriber should be activated (for a persistent subscription). This
    ///property is read/write.
    HRESULT get_MachineName(BSTR* pbstrMachineName);
    ///The name of the computer on which the subscriber should be activated (for a persistent subscription). This
    ///property is read/write.
    HRESULT put_MachineName(BSTR bstrMachineName);
    ///Retrieves the value of a property stored in the property bag to define publisher context.
    ///Params:
    ///    bstrPropertyName = The name of the requested property.
    ///    propertyValue = The value of the requested property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    ///Writes a property and its value to the property bag to define publisher context.
    ///Params:
    ///    bstrPropertyName = The name of the property whose value is to be written to the property bag. If the property is not in the
    ///                       property bag, this method adds it.
    ///    propertyValue = The value of the property to be written to the property bag. If the property is already in the property bag,
    ///                    this method overwrites the current value.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT PutPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    ///Removes a property and its value from the property bag that defines publisher context.
    ///Params:
    ///    bstrPropertyName = The name of the property whose value is to be removed from the property bag.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT RemovePublisherProperty(BSTR bstrPropertyName);
    ///Retrieves a collection of properties and values stored in the publisher property bag.
    ///Params:
    ///    collection = Address of a pointer to the IEventObjectCollection interface on an event object collection. This parameter
    ///                 cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED,
    ///    E_FAIL, and S_OK.
    ///    
    HRESULT GetPublisherPropertyCollection(IEventObjectCollection* collection);
    ///Retrieves the value of a property stored in the property bag to define subscriber context.
    ///Params:
    ///    bstrPropertyName = The name of the requested property.
    ///    propertyValue = The value of the requested property.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT GetSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    ///Writes a property and its value to the property bag to define subscriber context.
    ///Params:
    ///    bstrPropertyName = The name of the property whose value is to be written to the property bag. If the property is not in the
    ///                       property bag, this method adds it.
    ///    propertyValue = The value of the property to be written to the property bag. If the property is already in the property bag,
    ///                    this method overwrites the current value.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT PutSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    ///Removes a property and its value from the property bag that defines subscriber context.
    ///Params:
    ///    bstrPropertyName = The name of the property whose value is to be removed from the property bag.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT RemoveSubscriberProperty(BSTR bstrPropertyName);
    ///Retrieves a collection of properties and values stored in the subscriber property bag.
    ///Params:
    ///    collection = Address of a pointer to the IEventObjectCollection interface on an event object collection. This parameter
    ///                 cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED,
    ///    E_FAIL, and S_OK.
    ///    
    HRESULT GetSubscriberPropertyCollection(IEventObjectCollection* collection);
    ///The identifier for a particular interface for which the subscriber wants to receive events. This property is
    ///read/write.
    HRESULT get_InterfaceID(BSTR* pbstrInterfaceID);
    ///The identifier for a particular interface for which the subscriber wants to receive events. This property is
    ///read/write.
    HRESULT put_InterfaceID(BSTR bstrInterfaceID);
}

///Fires an event to a single subscription.
@GUID("E0498C93-4EFE-11D1-9971-00C04FBBB345")
interface IFiringControl : IDispatch
{
    ///Fires an event to a single subscriber.
    ///Params:
    ///    subscription = A pointer to the IEventSubscription interface on a subscription object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT FireSubscription(IEventSubscription subscription);
}

///Acts as a callback interface so that event publishers can control which subscribers receive event notifications or
///the order in which subscribers are notified. <b>IPublisherFilter</b> is supported only for backward compatibility.
///Instead, use the IMultiInterfacePublisherFilter interface.
@GUID("465E5CC0-7B26-11D1-88FB-0080C7D771BF")
interface IPublisherFilter : IUnknown
{
    ///Associates an event method with a collection of subscription objects. This method is supported only for backward
    ///compatibility. Otherwise, you should use the methods of the IMultiInterfacePublisherFilter interface.
    ///Params:
    ///    methodName = The name of the event method associated with the publisher filter.
    ///    dispUserDefined = A pointer to the IEventSystem interface on an event system object or to the IEventControl interface on an
    ///                      event class object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The publisher filter was successfully
    ///    initialized. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_S_SOME_SUBSCRIBERS_FAILED</b></dt> </dl>
    ///    </td> <td width="60%"> An event was able to invoke some, but not all, of the subscribers. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>EVENT_E_ALL_SUBSCRIBERS_FAILED</b></dt> </dl> </td> <td width="60%"> An event
    ///    was unable to invoke any of the subscribers. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_S_NOSUBSCRIBERS</b></dt> </dl> </td> <td width="60%"> An event was published but there were no
    ///    subscribers. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td
    ///    width="60%"> A syntax error occurred while trying to evaluate a query string. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was
    ///    used in a query string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALEXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An unexpected exception was raised. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_INTERNALERROR</b></dt> </dl> </td> <td width="60%"> An unexpected internal error was detected.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INVALID_PER_USER_SID</b></dt> </dl> </td> <td
    ///    width="60%"> The owner SID on a per-user subscription does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_USER_EXCEPTION</b></dt> </dl> </td> <td width="60%"> A user-supplied component or subscriber
    ///    raised an exception. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_TOO_MANY_METHODS</b></dt> </dl>
    ///    </td> <td width="60%"> An interface has too many methods from which to fire events. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_MISSING_EVENTCLASS</b></dt> </dl> </td> <td width="60%"> A subscription
    ///    cannot be stored unless the event class for the subscription already exists. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_NOT_ALL_REMOVED</b></dt> </dl> </td> <td width="60%"> Not all of the
    ///    requested objects could be removed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_COMPLUS_NOT_INSTALLED</b></dt> </dl> </td> <td width="60%"> COM+ is required for this
    ///    operation, but it is not installed. </td> </tr> </table>
    ///    
    HRESULT Initialize(BSTR methodName, IDispatch dispUserDefined);
    ///Prepares a publisher filter to begin firing a filtered list of subscriptions using a provided firing control. The
    ///firing control is contained in the event class object. This method is supported only for backward compatibility.
    ///Otherwise, you should use the methods of the IMultiInterfacePublisherFilter interface.
    ///Params:
    ///    methodName = The name of the event method to be fired.
    ///    firingControl = A pointer to the IFiringControl interface on the firing control object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The event class object is ready to fire
    ///    the event. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_S_SOME_SUBSCRIBERS_FAILED</b></dt> </dl> </td>
    ///    <td width="60%"> An event was able to invoke some, but not all, of the subscribers. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_ALL_SUBSCRIBERS_FAILED</b></dt> </dl> </td> <td width="60%"> An event was
    ///    unable to invoke any of the subscribers. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_S_NOSUBSCRIBERS</b></dt> </dl> </td> <td width="60%"> An event was published but there were no
    ///    subscribers. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td
    ///    width="60%"> A syntax error occurred while trying to evaluate a query string. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was
    ///    used in a query string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALEXCEPTION</b></dt>
    ///    </dl> </td> <td width="60%"> An unexpected exception was raised. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_INTERNALERROR</b></dt> </dl> </td> <td width="60%"> An unexpected internal error was detected.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INVALID_PER_USER_SID</b></dt> </dl> </td> <td
    ///    width="60%"> The owner SID on a per-user subscription does not exist. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_USER_EXCEPTION</b></dt> </dl> </td> <td width="60%"> A user-supplied component or subscriber
    ///    raised an exception. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_TOO_MANY_METHODS</b></dt> </dl>
    ///    </td> <td width="60%"> An interface has too many methods from which to fire events. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_MISSING_EVENTCLASS</b></dt> </dl> </td> <td width="60%"> A subscription
    ///    cannot be stored unless the event class for the subscription already exists. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>EVENT_E_NOT_ALL_REMOVED</b></dt> </dl> </td> <td width="60%"> Not all of the
    ///    requested objects could be removed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_COMPLUS_NOT_INSTALLED</b></dt> </dl> </td> <td width="60%"> COM+ is required for this
    ///    operation, but it is not installed. </td> </tr> </table>
    ///    
    HRESULT PrepareToFire(BSTR methodName, IFiringControl firingControl);
}

///Manages a filtered subscription cache for an event method. Only subscribers who meet the criteria specified by the
///filter are notified when the associated event is fired. The <b>IMultiInterfacePublisherFilter</b> interface differs
///from the IPublisherFilter interface in that it supports multiple event interfaces for the event object.
@GUID("465E5CC1-7B26-11D1-88FB-0080C7D771BF")
interface IMultiInterfacePublisherFilter : IUnknown
{
    ///Associates an event class with a publisher filter.
    ///Params:
    ///    pEIC = A pointer to the IMultiInterfaceEventControl interface on an event class object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Initialize(IMultiInterfaceEventControl pEIC);
    ///Prepares the publisher filter to begin firing a filtered list of subscriptions using a provided firing control.
    ///The firing control is contained in the event class object.
    ///Params:
    ///    iid = The interface ID of the interface being fired.
    ///    methodName = The name of the event method to be fired.
    ///    firingControl = A pointer to the IFiringControl interface on the firing control object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT PrepareToFire(const(GUID)* iid, BSTR methodName, IFiringControl firingControl);
}

///Notifies subscribers of changes to the event store.
@GUID("F4A07D70-2E25-11D1-9964-00C04FBBB345")
interface IEventObjectChange : IUnknown
{
    ///Indicates that a subscription object has been added, modified, or deleted.
    ///Params:
    ///    changeType = The type of change to the subscription object. Values are taken from the EOC_ChangeType enumeration.
    ///    bstrSubscriptionID = The SubscriptionID property of the subscription object that changed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ChangedSubscription(EOC_ChangeType changeType, BSTR bstrSubscriptionID);
    ///Indicates that an event class object has been added, modified, or deleted.
    ///Params:
    ///    changeType = The type of change to the event class object. Values are taken from the EOC_ChangeType enumeration.
    ///    bstrEventClassID = The EventClassID property of the event class object that changed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ChangedEventClass(EOC_ChangeType changeType, BSTR bstrEventClassID);
    ///Indicates a publisher object has been added, modified, or deleted.
    ///Params:
    ///    changeType = The type of change to the publisher object. Values are taken from the EOC_ChangeType enumeration.
    ///    bstrPublisherID = The PublisherID property of the publisher object that changed.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ChangedPublisher(EOC_ChangeType changeType, BSTR bstrPublisherID);
}

///Notifies subscribers of changes to the event store while including partition and application ID information. The
///<b>IEventObjectChange2</b> interface has the same firing characteristics as IEventObjectChange.
@GUID("7701A9C3-BD68-438F-83E0-67BF4F53A422")
interface IEventObjectChange2 : IUnknown
{
    ///Indicates that a subscription object has been added, modified, or deleted.
    ///Params:
    ///    pInfo = A pointer to a COMEVENTSYSCHANGEINFO structure.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ChangedSubscription(COMEVENTSYSCHANGEINFO* pInfo);
    ///Indicates that an event class object has been added, modified, or deleted.
    ///Params:
    ///    pInfo = A pointer to a COMEVENTSYSCHANGEINFO structure.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT ChangedEventClass(COMEVENTSYSCHANGEINFO* pInfo);
}

///Enumerates the event objects that are registered in the COM+ events store. Similar functionality is available through
///IEventObjectCollection.
@GUID("F4A07D63-2E25-11D1-9964-00C04FBBB345")
interface IEnumEventObject : IUnknown
{
    ///Creates an enumerator that contains the same enumeration state as the current one.
    ///Params:
    ///    ppInterface = Address of a pointer to the IEnumEventObject interface on the enumeration object. This parameter cannot be
    ///                  <b>NULL</b>. If the method is unsuccessful, the value of this output variable is undefined.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Clone(IEnumEventObject* ppInterface);
    ///Retrieves the specified number of items in the enumeration sequence.
    ///Params:
    ///    cReqElem = The number of elements being requested. If there are fewer than the requested number of elements left in the
    ///               sequence, this method obtains the remaining elements.
    ///    ppInterface = The address to a pointer to the IUnknown interface on the first object obtained. This parameter cannot be
    ///                  <b>NULL</b>.
    ///    cRetElem = The number of elements actually obtained. This parameter cannot be <b>NULL</b>.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_POINTER, E_OUTOFMEMORY, E_UNEXPECTED, and
    ///    E_FAIL, as well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> All elements requested were obtained.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Not all elements
    ///    requested were obtained. The number of elements obtained was written to <i>pcRetElem</i>. </td> </tr>
    ///    </table>
    ///    
    HRESULT Next(uint cReqElem, IUnknown* ppInterface, uint* cRetElem);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The enumeration sequence was
    ///    reset. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    enumeration sequence was reset, but there are no items in the enumerator. </td> </tr> </table>
    ///    
    HRESULT Reset();
    ///Skips over the specified number of items in the enumeration sequence.
    ///Params:
    ///    cSkipElem = The number of elements to be skipped.
    ///Returns:
    ///    This method can return the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The requested number of elements
    ///    was skipped. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The
    ///    number of elements skipped was not the same as the number requested. </td> </tr> </table>
    ///    
    HRESULT Skip(uint cSkipElem);
}

///Manages objects in an event objects collection.
@GUID("F89AC270-D4EB-11D1-B682-00805FC79216")
interface IEventObjectCollection : IDispatch
{
    ///An enumerator for the objects in the collection. This property is read-only.
    HRESULT get__NewEnum(IUnknown* ppUnkEnum);
    ///An item in the collection. This property is read-only.
    HRESULT get_Item(BSTR objectID, VARIANT* pItem);
    ///An enumeration object that implements IEnumEventObject. This property is read-only.
    HRESULT get_NewEnum(IEnumEventObject* ppEnum);
    ///The number of objects in the collection. This property is read-only.
    HRESULT get_Count(int* pCount);
    ///Adds an event object to the collection.
    ///Params:
    ///    item = A pointer to the event object to be added to the collection. This parameter cannot be <b>NULL</b>.
    ///    objectID = The ID property of the event object to be added. For example, if the collection consists of subscription
    ///               objects, this parameter would contain the SubscriptionID property of the event subscription object to be
    ///               added to the collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Add(VARIANT* item, BSTR objectID);
    ///Removes an event object from the collection.
    ///Params:
    ///    objectID = The ID property of the event object to be removed. For example, if the collection consists of subscription
    ///               objects, this parameter would contain the SubscriptionID property of the event subscription object to be
    ///               removed from the collection.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, E_FAIL, and
    ///    S_OK.
    ///    
    HRESULT Remove(BSTR objectID);
}

///Controls the behavior of an event object, the object that fires an event to its subscribers. The <b>IEventControl</b>
///interface differs from the IMultiInterfaceEventControl interface in that it supports only one interface for the event
///object.
@GUID("0343E2F4-86F6-11D1-B760-00C04FB926AF")
interface IEventControl : IDispatch
{
    ///Assigns a publisher filter to an event method.
    ///Params:
    ///    methodName = The name of the event method associated with the publisher filter to be assigned.
    ///    pPublisherFilter = A pointer to the IPublisherFilter interface on the publisher filter associated with the specified method.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetPublisherFilter(BSTR methodName, IPublisherFilter pPublisherFilter);
    ///Indicates whether subscribers can be activated in the publisher's process. This property is read/write.
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    ///Indicates whether subscribers can be activated in the publisher's process. This property is read/write.
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    ///Retrieves the collection of subscriptions associated with an event method.
    ///Params:
    ///    methodName = The event method associated with the subscription collection.
    ///    optionalCriteria = The query criteria. If this parameter is <b>NULL</b>, the default query specified by the SetDefaultQuery
    ///                       method is used. For details on forming a valid expression for this parameter, see the Remarks section below.
    ///    optionalErrorIndex = The location, expressed as an offset, of an error in the <i>OptionalCriteria</i> parameter. This parameter
    ///                         cannot be <b>NULL</b>.
    ///    ppCollection = Address of a pointer to IEventObjectCollection interface on a collection object that enumerates the
    ///                   subscriptions associated with the event object.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetSubscriptions(BSTR methodName, BSTR optionalCriteria, int* optionalErrorIndex, 
                             IEventObjectCollection* ppCollection);
    ///Sets the default query to determine subscribers.
    ///Params:
    ///    methodName = The name of the method to which the default query is assigned.
    ///    criteria = The query criteria. This parameter cannot be <b>NULL</b>. For details on forming a valid expression for this
    ///               parameter, see the Remarks section below.
    ///    errorIndex = The location, expressed as an offset, of an error in the <i>criteria</i> parameter.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetDefaultQuery(BSTR methodName, BSTR criteria, int* errorIndex);
}

///Controls the behavior of an event object, the object that fires an event to its subscribers. The
///<b>IMultiInterfaceEventControl</b> interface differs from the IEventControl interface in that it supports multiple
///event interfaces for the event object.
@GUID("0343E2F5-86F6-11D1-B760-00C04FB926AF")
interface IMultiInterfaceEventControl : IUnknown
{
    ///Assigns a publisher filter to an event method at run time. This method sets the specified publisher filter for
    ///all methods of all event interfaces for the event object.
    ///Params:
    ///    classFilter = A pointer to the IMultiInterfacePublisherFilter interface on the publisher filter associated with the
    ///                  specified method.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALEXCEPTION</b></dt> </dl> </td> <td width="60%"> An
    ///    unexpected exception was raised. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALERROR</b></dt>
    ///    </dl> </td> <td width="60%"> An unexpected internal error was detected. </td> </tr> </table>
    ///    
    HRESULT SetMultiInterfacePublisherFilter(IMultiInterfacePublisherFilter classFilter);
    ///Retrieves the collection of subscription objects associated with an event method.
    ///Params:
    ///    eventIID = The interface identifier of the firing interface.
    ///    bstrMethodName = The event method associated with the subscription collection.
    ///    optionalCriteria = A string specifying the query criteria. If this parameter is <b>NULL</b>, the default query specified by the
    ///                       SetDefaultQuery method is used. For details on forming a valid expression for this parameter, see the Remarks
    ///                       section below.
    ///    optionalErrorIndex = The location, expressed as an offset, of an error in the <i>optionalCriteria</i> parameter. This parameter
    ///                         cannot be <b>NULL</b>.
    ///    ppCollection = The address of a pointer to an IEventObjectCollection interface on a collection object that enumerates the
    ///                   subscriptions associated with the event object.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A syntax
    ///    error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALEXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An unexpected exception was raised. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_INTERNALERROR</b></dt> </dl> </td> <td width="60%"> An unexpected internal error was detected.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetSubscriptions(const(GUID)* eventIID, BSTR bstrMethodName, BSTR optionalCriteria, 
                             int* optionalErrorIndex, IEventObjectCollection* ppCollection);
    ///Establishes a default query to be used when a publisher filter is not associated with an event method.
    ///Params:
    ///    eventIID = The interface identifier of the firing interface.
    ///    bstrMethodName = The name of the method to which the default query is assigned.
    ///    bstrCriteria = A string specifying the query criteria. This parameter cannot be <b>NULL</b>. For details on forming a valid
    ///                   expression for this parameter, see the Remarks section below.
    ///    errorIndex = The location, expressed as an offset, of an error in the <i>bstrCriteria</i> parameter.
    ///Returns:
    ///    This method can return the standard return values E_INVALIDARG, E_OUTOFMEMORY, E_UNEXPECTED, and E_FAIL, as
    ///    well as the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The method completed successfully. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_QUERYSYNTAX</b></dt> </dl> </td> <td width="60%"> A syntax
    ///    error occurred while trying to evaluate a query string. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_QUERYFIELD</b></dt> </dl> </td> <td width="60%"> An invalid field name was used in a query
    ///    string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>EVENT_E_INTERNALEXCEPTION</b></dt> </dl> </td> <td
    ///    width="60%"> An unexpected exception was raised. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>EVENT_E_INTERNALERROR</b></dt> </dl> </td> <td width="60%"> An unexpected internal error was detected.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetDefaultQuery(const(GUID)* eventIID, BSTR bstrMethodName, BSTR bstrCriteria, int* errorIndex);
    ///Indicates whether subscribers can be activated in the publisher's process. This property is read/write.
    HRESULT get_AllowInprocActivation(BOOL* pfAllowInprocActivation);
    ///Indicates whether subscribers can be activated in the publisher's process. This property is read/write.
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    ///Indicates whether events can be delivered to two or more subscribers in parallel. This property is read/write.
    HRESULT get_FireInParallel(BOOL* pfFireInParallel);
    ///Indicates whether events can be delivered to two or more subscribers in parallel. This property is read/write.
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

@GUID("784121F1-62A6-4B89-855F-D65F296DE83A")
interface IDontSupportEventSubscription : IUnknown
{
}


// GUIDs

const GUID CLSID_AppDomainHelper                 = GUIDOF!AppDomainHelper;
const GUID CLSID_ByotServerEx                    = GUIDOF!ByotServerEx;
const GUID CLSID_CEventClass                     = GUIDOF!CEventClass;
const GUID CLSID_CEventPublisher                 = GUIDOF!CEventPublisher;
const GUID CLSID_CEventSubscription              = GUIDOF!CEventSubscription;
const GUID CLSID_CEventSystem                    = GUIDOF!CEventSystem;
const GUID CLSID_COMAdminCatalog                 = GUIDOF!COMAdminCatalog;
const GUID CLSID_COMAdminCatalogCollection       = GUIDOF!COMAdminCatalogCollection;
const GUID CLSID_COMAdminCatalogObject           = GUIDOF!COMAdminCatalogObject;
const GUID CLSID_COMEvents                       = GUIDOF!COMEvents;
const GUID CLSID_CRMClerk                        = GUIDOF!CRMClerk;
const GUID CLSID_CRMRecoveryClerk                = GUIDOF!CRMRecoveryClerk;
const GUID CLSID_CServiceConfig                  = GUIDOF!CServiceConfig;
const GUID CLSID_ClrAssemblyLocator              = GUIDOF!ClrAssemblyLocator;
const GUID CLSID_CoMTSLocator                    = GUIDOF!CoMTSLocator;
const GUID CLSID_ComServiceEvents                = GUIDOF!ComServiceEvents;
const GUID CLSID_ComSystemAppEventData           = GUIDOF!ComSystemAppEventData;
const GUID CLSID_DispenserManager                = GUIDOF!DispenserManager;
const GUID CLSID_Dummy30040732                   = GUIDOF!Dummy30040732;
const GUID CLSID_EventObjectChange               = GUIDOF!EventObjectChange;
const GUID CLSID_EventObjectChange2              = GUIDOF!EventObjectChange2;
const GUID CLSID_EventServer                     = GUIDOF!EventServer;
const GUID CLSID_GetSecurityCallContextAppObject = GUIDOF!GetSecurityCallContextAppObject;
const GUID CLSID_LBEvents                        = GUIDOF!LBEvents;
const GUID CLSID_MessageMover                    = GUIDOF!MessageMover;
const GUID CLSID_MtsGrp                          = GUIDOF!MtsGrp;
const GUID CLSID_PoolMgr                         = GUIDOF!PoolMgr;
const GUID CLSID_SecurityCallContext             = GUIDOF!SecurityCallContext;
const GUID CLSID_SecurityCallers                 = GUIDOF!SecurityCallers;
const GUID CLSID_SecurityIdentity                = GUIDOF!SecurityIdentity;
const GUID CLSID_ServicePool                     = GUIDOF!ServicePool;
const GUID CLSID_ServicePoolConfig               = GUIDOF!ServicePoolConfig;
const GUID CLSID_SharedProperty                  = GUIDOF!SharedProperty;
const GUID CLSID_SharedPropertyGroup             = GUIDOF!SharedPropertyGroup;
const GUID CLSID_SharedPropertyGroupManager      = GUIDOF!SharedPropertyGroupManager;
const GUID CLSID_TrackerServer                   = GUIDOF!TrackerServer;
const GUID CLSID_TransactionContext              = GUIDOF!TransactionContext;
const GUID CLSID_TransactionContextEx            = GUIDOF!TransactionContextEx;

const GUID IID_ContextInfo                            = GUIDOF!ContextInfo;
const GUID IID_ContextInfo2                           = GUIDOF!ContextInfo2;
const GUID IID_IAppDomainHelper                       = GUIDOF!IAppDomainHelper;
const GUID IID_IAssemblyLocator                       = GUIDOF!IAssemblyLocator;
const GUID IID_IAsyncErrorNotify                      = GUIDOF!IAsyncErrorNotify;
const GUID IID_ICOMAdminCatalog                       = GUIDOF!ICOMAdminCatalog;
const GUID IID_ICOMAdminCatalog2                      = GUIDOF!ICOMAdminCatalog2;
const GUID IID_ICOMLBArguments                        = GUIDOF!ICOMLBArguments;
const GUID IID_ICatalogCollection                     = GUIDOF!ICatalogCollection;
const GUID IID_ICatalogObject                         = GUIDOF!ICatalogObject;
const GUID IID_ICheckSxsConfig                        = GUIDOF!ICheckSxsConfig;
const GUID IID_IComActivityEvents                     = GUIDOF!IComActivityEvents;
const GUID IID_IComApp2Events                         = GUIDOF!IComApp2Events;
const GUID IID_IComAppEvents                          = GUIDOF!IComAppEvents;
const GUID IID_IComCRMEvents                          = GUIDOF!IComCRMEvents;
const GUID IID_IComExceptionEvents                    = GUIDOF!IComExceptionEvents;
const GUID IID_IComIdentityEvents                     = GUIDOF!IComIdentityEvents;
const GUID IID_IComInstance2Events                    = GUIDOF!IComInstance2Events;
const GUID IID_IComInstanceEvents                     = GUIDOF!IComInstanceEvents;
const GUID IID_IComLTxEvents                          = GUIDOF!IComLTxEvents;
const GUID IID_IComMethod2Events                      = GUIDOF!IComMethod2Events;
const GUID IID_IComMethodEvents                       = GUIDOF!IComMethodEvents;
const GUID IID_IComMtaThreadPoolKnobs                 = GUIDOF!IComMtaThreadPoolKnobs;
const GUID IID_IComObjectConstruction2Events          = GUIDOF!IComObjectConstruction2Events;
const GUID IID_IComObjectConstructionEvents           = GUIDOF!IComObjectConstructionEvents;
const GUID IID_IComObjectEvents                       = GUIDOF!IComObjectEvents;
const GUID IID_IComObjectPool2Events                  = GUIDOF!IComObjectPool2Events;
const GUID IID_IComObjectPoolEvents                   = GUIDOF!IComObjectPoolEvents;
const GUID IID_IComObjectPoolEvents2                  = GUIDOF!IComObjectPoolEvents2;
const GUID IID_IComQCEvents                           = GUIDOF!IComQCEvents;
const GUID IID_IComResourceEvents                     = GUIDOF!IComResourceEvents;
const GUID IID_IComSecurityEvents                     = GUIDOF!IComSecurityEvents;
const GUID IID_IComStaThreadPoolKnobs                 = GUIDOF!IComStaThreadPoolKnobs;
const GUID IID_IComStaThreadPoolKnobs2                = GUIDOF!IComStaThreadPoolKnobs2;
const GUID IID_IComThreadEvents                       = GUIDOF!IComThreadEvents;
const GUID IID_IComTrackingInfoCollection             = GUIDOF!IComTrackingInfoCollection;
const GUID IID_IComTrackingInfoEvents                 = GUIDOF!IComTrackingInfoEvents;
const GUID IID_IComTrackingInfoObject                 = GUIDOF!IComTrackingInfoObject;
const GUID IID_IComTrackingInfoProperties             = GUIDOF!IComTrackingInfoProperties;
const GUID IID_IComTransaction2Events                 = GUIDOF!IComTransaction2Events;
const GUID IID_IComTransactionEvents                  = GUIDOF!IComTransactionEvents;
const GUID IID_IComUserEvent                          = GUIDOF!IComUserEvent;
const GUID IID_IContextProperties                     = GUIDOF!IContextProperties;
const GUID IID_IContextSecurityPerimeter              = GUIDOF!IContextSecurityPerimeter;
const GUID IID_IContextState                          = GUIDOF!IContextState;
const GUID IID_ICreateWithLocalTransaction            = GUIDOF!ICreateWithLocalTransaction;
const GUID IID_ICreateWithTipTransactionEx            = GUIDOF!ICreateWithTipTransactionEx;
const GUID IID_ICreateWithTransactionEx               = GUIDOF!ICreateWithTransactionEx;
const GUID IID_ICrmCompensator                        = GUIDOF!ICrmCompensator;
const GUID IID_ICrmCompensatorVariants                = GUIDOF!ICrmCompensatorVariants;
const GUID IID_ICrmFormatLogRecords                   = GUIDOF!ICrmFormatLogRecords;
const GUID IID_ICrmLogControl                         = GUIDOF!ICrmLogControl;
const GUID IID_ICrmMonitor                            = GUIDOF!ICrmMonitor;
const GUID IID_ICrmMonitorClerks                      = GUIDOF!ICrmMonitorClerks;
const GUID IID_ICrmMonitorLogRecords                  = GUIDOF!ICrmMonitorLogRecords;
const GUID IID_IDispenserDriver                       = GUIDOF!IDispenserDriver;
const GUID IID_IDispenserManager                      = GUIDOF!IDispenserManager;
const GUID IID_IDontSupportEventSubscription          = GUIDOF!IDontSupportEventSubscription;
const GUID IID_IDtcLuConfigure                        = GUIDOF!IDtcLuConfigure;
const GUID IID_IDtcLuRecovery                         = GUIDOF!IDtcLuRecovery;
const GUID IID_IDtcLuRecoveryFactory                  = GUIDOF!IDtcLuRecoveryFactory;
const GUID IID_IDtcLuRecoveryInitiatedByDtc           = GUIDOF!IDtcLuRecoveryInitiatedByDtc;
const GUID IID_IDtcLuRecoveryInitiatedByDtcStatusWork = GUIDOF!IDtcLuRecoveryInitiatedByDtcStatusWork;
const GUID IID_IDtcLuRecoveryInitiatedByDtcTransWork  = GUIDOF!IDtcLuRecoveryInitiatedByDtcTransWork;
const GUID IID_IDtcLuRecoveryInitiatedByLu            = GUIDOF!IDtcLuRecoveryInitiatedByLu;
const GUID IID_IDtcLuRecoveryInitiatedByLuWork        = GUIDOF!IDtcLuRecoveryInitiatedByLuWork;
const GUID IID_IDtcLuRmEnlistment                     = GUIDOF!IDtcLuRmEnlistment;
const GUID IID_IDtcLuRmEnlistmentFactory              = GUIDOF!IDtcLuRmEnlistmentFactory;
const GUID IID_IDtcLuRmEnlistmentSink                 = GUIDOF!IDtcLuRmEnlistmentSink;
const GUID IID_IDtcLuSubordinateDtc                   = GUIDOF!IDtcLuSubordinateDtc;
const GUID IID_IDtcLuSubordinateDtcFactory            = GUIDOF!IDtcLuSubordinateDtcFactory;
const GUID IID_IDtcLuSubordinateDtcSink               = GUIDOF!IDtcLuSubordinateDtcSink;
const GUID IID_IDtcNetworkAccessConfig                = GUIDOF!IDtcNetworkAccessConfig;
const GUID IID_IDtcNetworkAccessConfig2               = GUIDOF!IDtcNetworkAccessConfig2;
const GUID IID_IDtcNetworkAccessConfig3               = GUIDOF!IDtcNetworkAccessConfig3;
const GUID IID_IEnumEventObject                       = GUIDOF!IEnumEventObject;
const GUID IID_IEnumNames                             = GUIDOF!IEnumNames;
const GUID IID_IEventClass                            = GUIDOF!IEventClass;
const GUID IID_IEventClass2                           = GUIDOF!IEventClass2;
const GUID IID_IEventControl                          = GUIDOF!IEventControl;
const GUID IID_IEventObjectChange                     = GUIDOF!IEventObjectChange;
const GUID IID_IEventObjectChange2                    = GUIDOF!IEventObjectChange2;
const GUID IID_IEventObjectCollection                 = GUIDOF!IEventObjectCollection;
const GUID IID_IEventServerTrace                      = GUIDOF!IEventServerTrace;
const GUID IID_IEventSubscription                     = GUIDOF!IEventSubscription;
const GUID IID_IEventSystem                           = GUIDOF!IEventSystem;
const GUID IID_IFiringControl                         = GUIDOF!IFiringControl;
const GUID IID_IGetAppTrackerData                     = GUIDOF!IGetAppTrackerData;
const GUID IID_IGetContextProperties                  = GUIDOF!IGetContextProperties;
const GUID IID_IGetDispenser                          = GUIDOF!IGetDispenser;
const GUID IID_IGetSecurityCallContext                = GUIDOF!IGetSecurityCallContext;
const GUID IID_IHolder                                = GUIDOF!IHolder;
const GUID IID_IKernelTransaction                     = GUIDOF!IKernelTransaction;
const GUID IID_ILBEvents                              = GUIDOF!ILBEvents;
const GUID IID_ILastResourceManager                   = GUIDOF!ILastResourceManager;
const GUID IID_IMTSActivity                           = GUIDOF!IMTSActivity;
const GUID IID_IMTSCall                               = GUIDOF!IMTSCall;
const GUID IID_IMTSLocator                            = GUIDOF!IMTSLocator;
const GUID IID_IManagedActivationEvents               = GUIDOF!IManagedActivationEvents;
const GUID IID_IManagedObjectInfo                     = GUIDOF!IManagedObjectInfo;
const GUID IID_IManagedPoolAction                     = GUIDOF!IManagedPoolAction;
const GUID IID_IManagedPooledObj                      = GUIDOF!IManagedPooledObj;
const GUID IID_IMessageMover                          = GUIDOF!IMessageMover;
const GUID IID_IMtsEventInfo                          = GUIDOF!IMtsEventInfo;
const GUID IID_IMtsEvents                             = GUIDOF!IMtsEvents;
const GUID IID_IMtsGrp                                = GUIDOF!IMtsGrp;
const GUID IID_IMultiInterfaceEventControl            = GUIDOF!IMultiInterfaceEventControl;
const GUID IID_IMultiInterfacePublisherFilter         = GUIDOF!IMultiInterfacePublisherFilter;
const GUID IID_IObjPool                               = GUIDOF!IObjPool;
const GUID IID_IObjectConstruct                       = GUIDOF!IObjectConstruct;
const GUID IID_IObjectConstructString                 = GUIDOF!IObjectConstructString;
const GUID IID_IObjectContext                         = GUIDOF!IObjectContext;
const GUID IID_IObjectContextActivity                 = GUIDOF!IObjectContextActivity;
const GUID IID_IObjectContextInfo                     = GUIDOF!IObjectContextInfo;
const GUID IID_IObjectContextInfo2                    = GUIDOF!IObjectContextInfo2;
const GUID IID_IObjectContextTip                      = GUIDOF!IObjectContextTip;
const GUID IID_IObjectControl                         = GUIDOF!IObjectControl;
const GUID IID_IPlaybackControl                       = GUIDOF!IPlaybackControl;
const GUID IID_IPoolManager                           = GUIDOF!IPoolManager;
const GUID IID_IPrepareInfo                           = GUIDOF!IPrepareInfo;
const GUID IID_IPrepareInfo2                          = GUIDOF!IPrepareInfo2;
const GUID IID_IProcessInitializer                    = GUIDOF!IProcessInitializer;
const GUID IID_IPublisherFilter                       = GUIDOF!IPublisherFilter;
const GUID IID_IRMHelper                              = GUIDOF!IRMHelper;
const GUID IID_IResourceManager                       = GUIDOF!IResourceManager;
const GUID IID_IResourceManager2                      = GUIDOF!IResourceManager2;
const GUID IID_IResourceManagerFactory                = GUIDOF!IResourceManagerFactory;
const GUID IID_IResourceManagerFactory2               = GUIDOF!IResourceManagerFactory2;
const GUID IID_IResourceManagerRejoinable             = GUIDOF!IResourceManagerRejoinable;
const GUID IID_IResourceManagerSink                   = GUIDOF!IResourceManagerSink;
const GUID IID_ISecurityCallContext                   = GUIDOF!ISecurityCallContext;
const GUID IID_ISecurityCallersColl                   = GUIDOF!ISecurityCallersColl;
const GUID IID_ISecurityIdentityColl                  = GUIDOF!ISecurityIdentityColl;
const GUID IID_ISecurityProperty                      = GUIDOF!ISecurityProperty;
const GUID IID_ISelectCOMLBServer                     = GUIDOF!ISelectCOMLBServer;
const GUID IID_ISendMethodEvents                      = GUIDOF!ISendMethodEvents;
const GUID IID_IServiceActivity                       = GUIDOF!IServiceActivity;
const GUID IID_IServiceCall                           = GUIDOF!IServiceCall;
const GUID IID_IServiceComTIIntrinsicsConfig          = GUIDOF!IServiceComTIIntrinsicsConfig;
const GUID IID_IServiceIISIntrinsicsConfig            = GUIDOF!IServiceIISIntrinsicsConfig;
const GUID IID_IServiceInheritanceConfig              = GUIDOF!IServiceInheritanceConfig;
const GUID IID_IServicePartitionConfig                = GUIDOF!IServicePartitionConfig;
const GUID IID_IServicePool                           = GUIDOF!IServicePool;
const GUID IID_IServicePoolConfig                     = GUIDOF!IServicePoolConfig;
const GUID IID_IServiceSxsConfig                      = GUIDOF!IServiceSxsConfig;
const GUID IID_IServiceSynchronizationConfig          = GUIDOF!IServiceSynchronizationConfig;
const GUID IID_IServiceSysTxnConfig                   = GUIDOF!IServiceSysTxnConfig;
const GUID IID_IServiceThreadPoolConfig               = GUIDOF!IServiceThreadPoolConfig;
const GUID IID_IServiceTrackerConfig                  = GUIDOF!IServiceTrackerConfig;
const GUID IID_IServiceTransactionConfig              = GUIDOF!IServiceTransactionConfig;
const GUID IID_IServiceTransactionConfigBase          = GUIDOF!IServiceTransactionConfigBase;
const GUID IID_ISharedProperty                        = GUIDOF!ISharedProperty;
const GUID IID_ISharedPropertyGroup                   = GUIDOF!ISharedPropertyGroup;
const GUID IID_ISharedPropertyGroupManager            = GUIDOF!ISharedPropertyGroupManager;
const GUID IID_ISystemAppEventData                    = GUIDOF!ISystemAppEventData;
const GUID IID_IThreadPoolKnobs                       = GUIDOF!IThreadPoolKnobs;
const GUID IID_ITipHelper                             = GUIDOF!ITipHelper;
const GUID IID_ITipPullSink                           = GUIDOF!ITipPullSink;
const GUID IID_ITipTransaction                        = GUIDOF!ITipTransaction;
const GUID IID_ITmNodeName                            = GUIDOF!ITmNodeName;
const GUID IID_ITransaction                           = GUIDOF!ITransaction;
const GUID IID_ITransaction2                          = GUIDOF!ITransaction2;
const GUID IID_ITransactionCloner                     = GUIDOF!ITransactionCloner;
const GUID IID_ITransactionContext                    = GUIDOF!ITransactionContext;
const GUID IID_ITransactionContextEx                  = GUIDOF!ITransactionContextEx;
const GUID IID_ITransactionDispenser                  = GUIDOF!ITransactionDispenser;
const GUID IID_ITransactionEnlistmentAsync            = GUIDOF!ITransactionEnlistmentAsync;
const GUID IID_ITransactionExport                     = GUIDOF!ITransactionExport;
const GUID IID_ITransactionExportFactory              = GUIDOF!ITransactionExportFactory;
const GUID IID_ITransactionImport                     = GUIDOF!ITransactionImport;
const GUID IID_ITransactionImportWhereabouts          = GUIDOF!ITransactionImportWhereabouts;
const GUID IID_ITransactionLastEnlistmentAsync        = GUIDOF!ITransactionLastEnlistmentAsync;
const GUID IID_ITransactionLastResourceAsync          = GUIDOF!ITransactionLastResourceAsync;
const GUID IID_ITransactionOptions                    = GUIDOF!ITransactionOptions;
const GUID IID_ITransactionOutcomeEvents              = GUIDOF!ITransactionOutcomeEvents;
const GUID IID_ITransactionPhase0EnlistmentAsync      = GUIDOF!ITransactionPhase0EnlistmentAsync;
const GUID IID_ITransactionPhase0Factory              = GUIDOF!ITransactionPhase0Factory;
const GUID IID_ITransactionPhase0NotifyAsync          = GUIDOF!ITransactionPhase0NotifyAsync;
const GUID IID_ITransactionProperty                   = GUIDOF!ITransactionProperty;
const GUID IID_ITransactionProxy                      = GUIDOF!ITransactionProxy;
const GUID IID_ITransactionReceiver                   = GUIDOF!ITransactionReceiver;
const GUID IID_ITransactionReceiverFactory            = GUIDOF!ITransactionReceiverFactory;
const GUID IID_ITransactionResource                   = GUIDOF!ITransactionResource;
const GUID IID_ITransactionResourceAsync              = GUIDOF!ITransactionResourceAsync;
const GUID IID_ITransactionResourcePool               = GUIDOF!ITransactionResourcePool;
const GUID IID_ITransactionStatus                     = GUIDOF!ITransactionStatus;
const GUID IID_ITransactionTransmitter                = GUIDOF!ITransactionTransmitter;
const GUID IID_ITransactionTransmitterFactory         = GUIDOF!ITransactionTransmitterFactory;
const GUID IID_ITransactionVoterBallotAsync2          = GUIDOF!ITransactionVoterBallotAsync2;
const GUID IID_ITransactionVoterFactory2              = GUIDOF!ITransactionVoterFactory2;
const GUID IID_ITransactionVoterNotifyAsync2          = GUIDOF!ITransactionVoterNotifyAsync2;
const GUID IID_ITxProxyHolder                         = GUIDOF!ITxProxyHolder;
const GUID IID_IXAConfig                              = GUIDOF!IXAConfig;
const GUID IID_IXAObtainRMInfo                        = GUIDOF!IXAObtainRMInfo;
const GUID IID_IXATransLookup                         = GUIDOF!IXATransLookup;
const GUID IID_IXATransLookup2                        = GUIDOF!IXATransLookup2;
const GUID IID_ObjectContext                          = GUIDOF!ObjectContext;
const GUID IID_ObjectControl                          = GUIDOF!ObjectControl;
const GUID IID_SecurityProperty                       = GUIDOF!SecurityProperty;
