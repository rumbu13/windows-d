module windows.componentservices;

public import windows.core;
public import windows.automation : BSTR, IDispatch, SAFEARRAY, VARIANT;
public import windows.com : APTTYPE, EOC_ChangeType, HRESULT, IClassFactory, IMoniker, IUnknown;
public import windows.systemservices : BOOL, HANDLE;
public import windows.winsock : BLOB;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


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

enum COMAdminTxIsolationLevelOptions : int
{
    COMAdminTxIsolationLevelAny             = 0x00000000,
    COMAdminTxIsolationLevelReadUnCommitted = 0x00000001,
    COMAdminTxIsolationLevelReadCommitted   = 0x00000002,
    COMAdminTxIsolationLevelRepeatableRead  = 0x00000003,
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
alias COMAdminOS = int;

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

enum : int
{
    MAX_TRAN_DESC = 0x00000028,
}
alias TX_MISC_CONSTANTS = int;

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
alias ISOLATIONLEVEL = int;

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
alias ISOFLAG = int;

enum : int
{
    XACTTC_NONE           = 0x00000000,
    XACTTC_SYNC_PHASEONE  = 0x00000001,
    XACTTC_SYNC_PHASETWO  = 0x00000002,
    XACTTC_SYNC           = 0x00000002,
    XACTTC_ASYNC_PHASEONE = 0x00000004,
    XACTTC_ASYNC          = 0x00000004,
}
alias XACTTC = int;

enum : int
{
    XACTRM_OPTIMISTICLASTWINS = 0x00000001,
    XACTRM_NOREADONLYPREPARES = 0x00000002,
}
alias XACTRM = int;

enum : int
{
    XACTCONST_TIMEOUTINFINITE = 0x00000000,
}
alias XACTCONST = int;

enum : int
{
    XACTHEURISTIC_ABORT  = 0x00000001,
    XACTHEURISTIC_COMMIT = 0x00000002,
    XACTHEURISTIC_DAMAGE = 0x00000003,
    XACTHEURISTIC_DANGER = 0x00000004,
}
alias XACTHEURISTIC = int;

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
alias XACTSTAT = int;

enum : int
{
    NO_AUTHENTICATION_REQUIRED       = 0x00000000,
    INCOMING_AUTHENTICATION_REQUIRED = 0x00000001,
    MUTUAL_AUTHENTICATION_REQUIRED   = 0x00000002,
}
alias AUTHENTICATION_LEVEL = int;

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
alias XACT_DTC_CONSTANTS = int;

enum : int
{
    DTCINITIATEDRECOVERYWORK_CHECKLUSTATUS = 0x00000001,
    DTCINITIATEDRECOVERYWORK_TRANS         = 0x00000002,
    DTCINITIATEDRECOVERYWORK_TMDOWN        = 0x00000003,
}
alias _DtcLu_LocalRecovery_Work = int;

enum : int
{
    DTCLUXLN_COLD = 0x00000001,
    DTCLUXLN_WARM = 0x00000002,
}
alias _DtcLu_Xln = int;

enum : int
{
    DTCLUXLNCONFIRMATION_CONFIRM          = 0x00000001,
    DTCLUXLNCONFIRMATION_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNCONFIRMATION_COLDWARMMISMATCH = 0x00000003,
    DTCLUXLNCONFIRMATION_OBSOLETE         = 0x00000004,
}
alias _DtcLu_Xln_Confirmation = int;

enum : int
{
    DTCLUXLNRESPONSE_OK_SENDOURXLNBACK   = 0x00000001,
    DTCLUXLNRESPONSE_OK_SENDCONFIRMATION = 0x00000002,
    DTCLUXLNRESPONSE_LOGNAMEMISMATCH     = 0x00000003,
    DTCLUXLNRESPONSE_COLDWARMMISMATCH    = 0x00000004,
}
alias _DtcLu_Xln_Response = int;

enum : int
{
    DTCLUXLNERROR_PROTOCOL         = 0x00000001,
    DTCLUXLNERROR_LOGNAMEMISMATCH  = 0x00000002,
    DTCLUXLNERROR_COLDWARMMISMATCH = 0x00000003,
}
alias _DtcLu_Xln_Error = int;

enum : int
{
    DTCLUCOMPARESTATE_COMMITTED          = 0x00000001,
    DTCLUCOMPARESTATE_HEURISTICCOMMITTED = 0x00000002,
    DTCLUCOMPARESTATE_HEURISTICMIXED     = 0x00000003,
    DTCLUCOMPARESTATE_HEURISTICRESET     = 0x00000004,
    DTCLUCOMPARESTATE_INDOUBT            = 0x00000005,
    DTCLUCOMPARESTATE_RESET              = 0x00000006,
}
alias _DtcLu_CompareState = int;

enum : int
{
    DTCLUCOMPARESTATESCONFIRMATION_CONFIRM  = 0x00000001,
    DTCLUCOMPARESTATESCONFIRMATION_PROTOCOL = 0x00000002,
}
alias _DtcLu_CompareStates_Confirmation = int;

enum : int
{
    DTCLUCOMPARESTATESERROR_PROTOCOL = 0x00000001,
}
alias _DtcLu_CompareStates_Error = int;

enum : int
{
    DTCLUCOMPARESTATESRESPONSE_OK       = 0x00000001,
    DTCLUCOMPARESTATESRESPONSE_PROTOCOL = 0x00000002,
}
alias _DtcLu_CompareStates_Response = int;

enum : int
{
    TRKCOLL_PROCESSES    = 0x00000000,
    TRKCOLL_APPLICATIONS = 0x00000001,
    TRKCOLL_COMPONENTS   = 0x00000002,
}
alias TRACKING_COLL_TYPE = int;

enum : int
{
    DUMPTYPE_FULL = 0x00000000,
    DUMPTYPE_MINI = 0x00000001,
    DUMPTYPE_NONE = 0x00000002,
}
alias DUMPTYPE = int;

enum : int
{
    APPTYPE_UNKNOWN = 0xffffffff,
    APPTYPE_SERVER  = 0x00000001,
    APPTYPE_LIBRARY = 0x00000000,
    APPTYPE_SWC     = 0x00000002,
}
alias COMPLUS_APPTYPE = int;

enum GetAppTrackerDataFlags : int
{
    GATD_INCLUDE_PROCESS_EXE_NAME = 0x00000001,
    GATD_INCLUDE_LIBRARY_APPS     = 0x00000002,
    GATD_INCLUDE_SWC              = 0x00000004,
    GATD_INCLUDE_CLASS_NAME       = 0x00000008,
    GATD_INCLUDE_APPLICATION_NAME = 0x00000010,
}

enum TransactionVote : int
{
    TxCommit = 0x00000000,
    TxAbort  = 0x00000001,
}

enum CrmTransactionState : int
{
    TxState_Active    = 0x00000000,
    TxState_Committed = 0x00000001,
    TxState_Aborted   = 0x00000002,
    TxState_Indoubt   = 0x00000003,
}

enum : int
{
    CSC_Inherit = 0x00000000,
    CSC_Ignore  = 0x00000001,
}
alias CSC_InheritanceConfig = int;

enum : int
{
    CSC_ThreadPoolNone    = 0x00000000,
    CSC_ThreadPoolInherit = 0x00000001,
    CSC_STAThreadPool     = 0x00000002,
    CSC_MTAThreadPool     = 0x00000003,
}
alias CSC_ThreadPool = int;

enum : int
{
    CSC_NoBinding        = 0x00000000,
    CSC_BindToPoolThread = 0x00000001,
}
alias CSC_Binding = int;

enum : int
{
    CSC_NoTransaction                = 0x00000000,
    CSC_IfContainerIsTransactional   = 0x00000001,
    CSC_CreateTransactionIfNecessary = 0x00000002,
    CSC_NewTransaction               = 0x00000003,
}
alias CSC_TransactionConfig = int;

enum : int
{
    CSC_NoSynchronization             = 0x00000000,
    CSC_IfContainerIsSynchronized     = 0x00000001,
    CSC_NewSynchronizationIfNecessary = 0x00000002,
    CSC_NewSynchronization            = 0x00000003,
}
alias CSC_SynchronizationConfig = int;

enum : int
{
    CSC_DontUseTracker = 0x00000000,
    CSC_UseTracker     = 0x00000001,
}
alias CSC_TrackerConfig = int;

enum : int
{
    CSC_NoPartition      = 0x00000000,
    CSC_InheritPartition = 0x00000001,
    CSC_NewPartition     = 0x00000002,
}
alias CSC_PartitionConfig = int;

enum : int
{
    CSC_NoIISIntrinsics      = 0x00000000,
    CSC_InheritIISIntrinsics = 0x00000001,
}
alias CSC_IISIntrinsicsConfig = int;

enum : int
{
    CSC_NoCOMTIIntrinsics      = 0x00000000,
    CSC_InheritCOMTIIntrinsics = 0x00000001,
}
alias CSC_COMTIIntrinsicsConfig = int;

enum : int
{
    CSC_NoSxs      = 0x00000000,
    CSC_InheritSxs = 0x00000001,
    CSC_NewSxs     = 0x00000002,
}
alias CSC_SxsConfig = int;

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
alias __MIDL___MIDL_itf_autosvcs_0001_0150_0001 = int;

enum : int
{
    LockSetGet = 0x00000000,
    LockMethod = 0x00000001,
}
alias __MIDL___MIDL_itf_autosvcs_0001_0159_0001 = int;

enum : int
{
    Standard = 0x00000000,
    Process  = 0x00000001,
}
alias __MIDL___MIDL_itf_autosvcs_0001_0159_0002 = int;

enum : int
{
    CRMFLAG_FORGETTARGET          = 0x00000001,
    CRMFLAG_WRITTENDURINGPREPARE  = 0x00000002,
    CRMFLAG_WRITTENDURINGCOMMIT   = 0x00000004,
    CRMFLAG_WRITTENDURINGABORT    = 0x00000008,
    CRMFLAG_WRITTENDURINGRECOVERY = 0x00000010,
    CRMFLAG_WRITTENDURINGREPLAY   = 0x00000020,
    CRMFLAG_REPLAYINPROGRESS      = 0x00000040,
}
alias CRMFLAGS = int;

enum : int
{
    CRMREGFLAG_PREPAREPHASE         = 0x00000001,
    CRMREGFLAG_COMMITPHASE          = 0x00000002,
    CRMREGFLAG_ABORTPHASE           = 0x00000004,
    CRMREGFLAG_ALLPHASES            = 0x00000007,
    CRMREGFLAG_FAILIFINDOUBTSREMAIN = 0x00000010,
}
alias CRMREGFLAGS = int;

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
    uint     ulTimeout;
    byte[40] szDescription;
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

struct COMSVCSEVENTINFO
{
    uint    cbSize;
    uint    dwPid;
    long    lTime;
    int     lMicroTime;
    long    perfCount;
    GUID    guidApp;
    ushort* sMachineName;
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
    ushort*         m_pwszAppName;
    ushort*         m_pwszCtxName;
    COMPLUS_APPTYPE m_eAppType;
    uint            m_cReferences;
    uint            m_cBound;
    uint            m_cPooled;
    uint            m_cInCall;
    uint            m_dwRespTime;
    uint            m_cCallsCompleted;
    uint            m_cCallsFailed;
}

struct ApplicationProcessSummary
{
    GUID            PartitionIdPrimaryApplication;
    GUID            ApplicationIdPrimaryApplication;
    GUID            ApplicationInstanceId;
    uint            ProcessId;
    COMPLUS_APPTYPE Type;
    const(wchar)*   ProcessExeName;
    BOOL            IsService;
    BOOL            IsPaused;
    BOOL            IsRecycled;
}

struct ApplicationProcessStatistics
{
    uint NumCallsOutstanding;
    uint NumTrackedComponents;
    uint NumComponentInstances;
    uint AvgCallsPerSecond;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

struct ApplicationProcessRecycleInfo
{
    BOOL     IsRecyclable;
    BOOL     IsRecycled;
    FILETIME TimeRecycled;
    FILETIME TimeToTerminate;
    int      RecycleReasonCode;
    BOOL     IsPendingRecycle;
    BOOL     HasAutomaticLifetimeRecycling;
    FILETIME TimeForAutomaticRecycling;
    uint     MemoryLimitInKB;
    uint     MemoryUsageInKBLastCheck;
    uint     ActivationLimit;
    uint     NumActivationsLastReported;
    uint     CallLimit;
    uint     NumCallsLastReported;
}

struct ApplicationSummary
{
    GUID            ApplicationInstanceId;
    GUID            PartitionId;
    GUID            ApplicationId;
    COMPLUS_APPTYPE Type;
    const(wchar)*   ApplicationName;
    uint            NumTrackedComponents;
    uint            NumComponentInstances;
}

struct ComponentSummary
{
    GUID          ApplicationInstanceId;
    GUID          PartitionId;
    GUID          ApplicationId;
    GUID          Clsid;
    const(wchar)* ClassName;
    const(wchar)* ApplicationName;
}

struct ComponentStatistics
{
    uint NumInstances;
    uint NumBoundReferences;
    uint NumPooledObjects;
    uint NumObjectsInCall;
    uint AvgResponseTimeInMs;
    uint NumCallsCompletedRecent;
    uint NumCallsFailedRecent;
    uint NumCallsCompletedTotal;
    uint NumCallsFailedTotal;
    uint Reserved1;
    uint Reserved2;
    uint Reserved3;
    uint Reserved4;
}

struct ComponentHangMonitorInfo
{
    BOOL IsMonitored;
    BOOL TerminateOnHang;
    uint AvgCallThresholdInMs;
}

struct CrmLogRecordRead
{
    uint dwCrmFlags;
    uint dwSequenceNumber;
    BLOB blobUserData;
}

struct COMEVENTSYSCHANGEINFO
{
    uint           cbSize;
    EOC_ChangeType changeType;
    BSTR           objectId;
    BSTR           partitionId;
    BSTR           applicationId;
    GUID[10]       reserved;
}

// Functions

@DllImport("OLE32")
HRESULT CoGetDefaultContext(APTTYPE aptType, const(GUID)* riid, void** ppv);

@DllImport("comsvcs")
HRESULT CoCreateActivity(IUnknown pIUnknown, const(GUID)* riid, void** ppObj);

@DllImport("comsvcs")
HRESULT CoEnterServiceDomain(IUnknown pConfigObject);

@DllImport("comsvcs")
void CoLeaveServiceDomain(IUnknown pUnkStatus);

@DllImport("comsvcs")
HRESULT GetManagedExtensions(uint* dwExts);

@DllImport("comsvcs")
void* SafeRef(const(GUID)* rid, IUnknown pUnk);

@DllImport("comsvcs")
HRESULT RecycleSurrogate(int lReasonCode);

@DllImport("comsvcs")
HRESULT MTSCreateActivity(const(GUID)* riid, void** ppobj);

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

@GUID("DD662187-DFC2-11D1-A2CF-00805FC79235")
interface ICOMAdminCatalog : IDispatch
{
    HRESULT GetCollection(BSTR bstrCollName, IDispatch* ppCatalogCollection);
    HRESULT Connect(BSTR bstrCatalogServerName, IDispatch* ppCatalogCollection);
    HRESULT get_MajorVersion(int* plMajorVersion);
    HRESULT get_MinorVersion(int* plMinorVersion);
    HRESULT GetCollectionByQuery(BSTR bstrCollName, SAFEARRAY** ppsaVarQuery, IDispatch* ppCatalogCollection);
    HRESULT ImportComponent(BSTR bstrApplIDOrName, BSTR bstrCLSIDOrProgID);
    HRESULT InstallComponent(BSTR bstrApplIDOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    HRESULT ShutdownApplication(BSTR bstrApplIDOrName);
    HRESULT ExportApplication(BSTR bstrApplIDOrName, BSTR bstrApplicationFile, int lOptions);
    HRESULT InstallApplication(BSTR bstrApplicationFile, BSTR bstrDestinationDirectory, int lOptions, 
                               BSTR bstrUserId, BSTR bstrPassword, BSTR bstrRSN);
    HRESULT StopRouter();
    HRESULT RefreshRouter();
    HRESULT StartRouter();
    HRESULT Reserved1();
    HRESULT Reserved2();
    HRESULT InstallMultipleComponents(BSTR bstrApplIDOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs);
    HRESULT GetMultipleComponentsInfo(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                      SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarClassNames, 
                                      SAFEARRAY** ppsaVarFileFlags, SAFEARRAY** ppsaVarComponentFlags);
    HRESULT RefreshComponents();
    HRESULT BackupREGDB(BSTR bstrBackupFilePath);
    HRESULT RestoreREGDB(BSTR bstrBackupFilePath);
    HRESULT QueryApplicationFile(BSTR bstrApplicationFile, BSTR* pbstrApplicationName, 
                                 BSTR* pbstrApplicationDescription, short* pbHasUsers, short* pbIsProxy, 
                                 SAFEARRAY** ppsaVarFileNames);
    HRESULT StartApplication(BSTR bstrApplIdOrName);
    HRESULT ServiceCheck(int lService, int* plStatus);
    HRESULT InstallMultipleEventClasses(BSTR bstrApplIdOrName, SAFEARRAY** ppsaVarFileNames, 
                                        SAFEARRAY** ppsaVarCLSIDS);
    HRESULT InstallEventClass(BSTR bstrApplIdOrName, BSTR bstrDLL, BSTR bstrTLB, BSTR bstrPSDLL);
    HRESULT GetEventClassesForIID(BSTR bstrIID, SAFEARRAY** ppsaVarCLSIDs, SAFEARRAY** ppsaVarProgIDs, 
                                  SAFEARRAY** ppsaVarDescriptions);
}

@GUID("790C6E0B-9194-4CC9-9426-A48A63185696")
interface ICOMAdminCatalog2 : ICOMAdminCatalog
{
    HRESULT GetCollectionByQuery2(BSTR bstrCollectionName, VARIANT* pVarQueryStrings, 
                                  IDispatch* ppCatalogCollection);
    HRESULT GetApplicationInstanceIDFromProcessID(int lProcessID, BSTR* pbstrApplicationInstanceID);
    HRESULT ShutdownApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT PauseApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT ResumeApplicationInstances(VARIANT* pVarApplicationInstanceID);
    HRESULT RecycleApplicationInstances(VARIANT* pVarApplicationInstanceID, int lReasonCode);
    HRESULT AreApplicationInstancesPaused(VARIANT* pVarApplicationInstanceID, short* pVarBoolPaused);
    HRESULT DumpApplicationInstance(BSTR bstrApplicationInstanceID, BSTR bstrDirectory, int lMaxImages, 
                                    BSTR* pbstrDumpFile);
    HRESULT get_IsApplicationInstanceDumpSupported(short* pVarBoolDumpSupported);
    HRESULT CreateServiceForApplication(BSTR bstrApplicationIDOrName, BSTR bstrServiceName, BSTR bstrStartType, 
                                        BSTR bstrErrorControl, BSTR bstrDependencies, BSTR bstrRunAs, 
                                        BSTR bstrPassword, short bDesktopOk);
    HRESULT DeleteServiceForApplication(BSTR bstrApplicationIDOrName);
    HRESULT GetPartitionID(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionID);
    HRESULT GetPartitionName(BSTR bstrApplicationIDOrName, BSTR* pbstrPartitionName);
    HRESULT put_CurrentPartition(BSTR bstrPartitionIDOrName);
    HRESULT get_CurrentPartitionID(BSTR* pbstrPartitionID);
    HRESULT get_CurrentPartitionName(BSTR* pbstrPartitionName);
    HRESULT get_GlobalPartitionID(BSTR* pbstrGlobalPartitionID);
    HRESULT FlushPartitionCache();
    HRESULT CopyApplications(BSTR bstrSourcePartitionIDOrName, VARIANT* pVarApplicationID, 
                             BSTR bstrDestinationPartitionIDOrName);
    HRESULT CopyComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    HRESULT MoveComponents(BSTR bstrSourceApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                           BSTR bstrDestinationApplicationIDOrName);
    HRESULT AliasComponent(BSTR bstrSrcApplicationIDOrName, BSTR bstrCLSIDOrProgID, 
                           BSTR bstrDestApplicationIDOrName, BSTR bstrNewProgId, BSTR bstrNewClsid);
    HRESULT IsSafeToDelete(BSTR bstrDllName, COMAdminInUse* pCOMAdminInUse);
    HRESULT ImportUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                         VARIANT* pVarComponentType);
    HRESULT PromoteUnconfiguredComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, 
                                          VARIANT* pVarComponentType);
    HRESULT ImportComponents(BSTR bstrApplicationIDOrName, VARIANT* pVarCLSIDOrProgID, VARIANT* pVarComponentType);
    HRESULT get_Is64BitCatalogServer(short* pbIs64Bit);
    HRESULT ExportPartition(BSTR bstrPartitionIDOrName, BSTR bstrPartitionFileName, int lOptions);
    HRESULT InstallPartition(BSTR bstrFileName, BSTR bstrDestDirectory, int lOptions, BSTR bstrUserID, 
                             BSTR bstrPassword, BSTR bstrRSN);
    HRESULT QueryApplicationFile2(BSTR bstrApplicationFile, IDispatch* ppFilesForImport);
    HRESULT GetComponentVersionCount(BSTR bstrCLSIDOrProgID, int* plVersionCount);
}

@GUID("6EB22871-8A19-11D0-81B6-00A0C9231C29")
interface ICatalogObject : IDispatch
{
    HRESULT get_Value(BSTR bstrPropName, VARIANT* pvarRetVal);
    HRESULT put_Value(BSTR bstrPropName, VARIANT val);
    HRESULT get_Key(VARIANT* pvarRetVal);
    HRESULT get_Name(VARIANT* pvarRetVal);
    HRESULT IsPropertyReadOnly(BSTR bstrPropName, short* pbRetVal);
    HRESULT get_Valid(short* pbRetVal);
    HRESULT IsPropertyWriteOnly(BSTR bstrPropName, short* pbRetVal);
}

@GUID("6EB22872-8A19-11D0-81B6-00A0C9231C29")
interface ICatalogCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppEnumVariant);
    HRESULT get_Item(int lIndex, IDispatch* ppCatalogObject);
    HRESULT get_Count(int* plObjectCount);
    HRESULT Remove(int lIndex);
    HRESULT Add(IDispatch* ppCatalogObject);
    HRESULT Populate();
    HRESULT SaveChanges(int* pcChanges);
    HRESULT GetCollection(BSTR bstrCollName, VARIANT varObjectKey, IDispatch* ppCatalogCollection);
    HRESULT get_Name(VARIANT* pVarNamel);
    HRESULT get_AddEnabled(short* pVarBool);
    HRESULT get_RemoveEnabled(short* pVarBool);
    HRESULT GetUtilInterface(IDispatch* ppIDispatch);
    HRESULT get_DataStoreMajorVersion(int* plMajorVersion);
    HRESULT get_DataStoreMinorVersion(int* plMinorVersionl);
    HRESULT PopulateByKey(SAFEARRAY* psaKeys);
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
    HRESULT GetNodeName(uint cbNodeNameBufferSize, const(wchar)* pNodeNameBuffer);
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
    HRESULT Create(uint cbWhereabouts, char* rgbWhereabouts, ITransactionExport* ppExport);
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
    HRESULT Import(uint cbTransactionCookie, char* rgbTransactionCookie, GUID* piid, void** ppvTransaction);
}

@GUID("17CF72D0-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipTransaction : IUnknown
{
    HRESULT Push(byte* i_pszRemoteTmUrl, byte** o_ppszRemoteTxUrl);
    HRESULT GetTransactionUrl(byte** o_ppszLocalTxUrl);
}

@GUID("17CF72D1-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipHelper : IUnknown
{
    HRESULT Pull(byte* i_pszTxUrl, ITransaction* o_ppITransaction);
    HRESULT PullAsync(byte* i_pszTxUrl, ITipPullSink i_pTipPullSink, ITransaction* o_ppITransaction);
    HRESULT GetLocalTmUrl(byte** o_ppszLocalTmUrl);
}

@GUID("17CF72D2-BAC5-11D1-B1BF-00C04FC2F3EF")
interface ITipPullSink : IUnknown
{
    HRESULT PullComplete(HRESULT i_hrPull);
}

@GUID("9797C15D-A428-4291-87B6-0995031A678D")
interface IDtcNetworkAccessConfig : IUnknown
{
    HRESULT GetAnyNetworkAccess(int* pbAnyNetworkAccess);
    HRESULT SetAnyNetworkAccess(BOOL bAnyNetworkAccess);
    HRESULT GetNetworkAdministrationAccess(int* pbNetworkAdministrationAccess);
    HRESULT SetNetworkAdministrationAccess(BOOL bNetworkAdministrationAccess);
    HRESULT GetNetworkTransactionAccess(int* pbNetworkTransactionAccess);
    HRESULT SetNetworkTransactionAccess(BOOL bNetworkTransactionAccess);
    HRESULT GetNetworkClientAccess(int* pbNetworkClientAccess);
    HRESULT SetNetworkClientAccess(BOOL bNetworkClientAccess);
    HRESULT GetNetworkTIPAccess(int* pbNetworkTIPAccess);
    HRESULT SetNetworkTIPAccess(BOOL bNetworkTIPAccess);
    HRESULT GetXAAccess(int* pbXAAccess);
    HRESULT SetXAAccess(BOOL bXAAccess);
    HRESULT RestartDtcService();
}

@GUID("A7AA013B-EB7D-4F42-B41C-B2DEC09AE034")
interface IDtcNetworkAccessConfig2 : IDtcNetworkAccessConfig
{
    HRESULT GetNetworkInboundAccess(int* pbInbound);
    HRESULT GetNetworkOutboundAccess(int* pbOutbound);
    HRESULT SetNetworkInboundAccess(BOOL bInbound);
    HRESULT SetNetworkOutboundAccess(BOOL bOutbound);
    HRESULT GetAuthenticationLevel(AUTHENTICATION_LEVEL* pAuthLevel);
    HRESULT SetAuthenticationLevel(AUTHENTICATION_LEVEL AuthLevel);
}

@GUID("76E4B4F3-2CA5-466B-89D5-FD218EE75B49")
interface IDtcNetworkAccessConfig3 : IDtcNetworkAccessConfig2
{
    HRESULT GetLUAccess(int* pbLUAccess);
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

@GUID("13741D21-87EB-11CE-8081-0080C758527E")
interface IResourceManager : IUnknown
{
    HRESULT Enlist(ITransaction pTransaction, ITransactionResourceAsync pRes, BOID* pUOW, int* pisoLevel, 
                   ITransactionEnlistmentAsync* ppEnlist);
    HRESULT Reenlist(char* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
    HRESULT ReenlistmentComplete();
    HRESULT GetDistributedTransactionManager(const(GUID)* iid, void** ppvObject);
}

@GUID("4D964AD4-5B33-11D3-8A91-00C04F79EB6D")
interface ILastResourceManager : IUnknown
{
    HRESULT TransactionCommitted(char* pPrepInfo, uint cbPrepInfo);
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
    HRESULT Rejoin(char* pPrepInfo, uint cbPrepInfo, uint lTimeout, XACTSTAT* pXactStat);
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
    HRESULT GetPrepareInfo(uint cbPrepareInfo, char* pPrepInfo);
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
    HRESULT MarshalPropagationToken(uint cbToken, char* rgbToken, uint* pcbUsed);
    HRESULT UnmarshalReturnToken(uint cbReturnToken, char* rgbReturnToken);
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
    HRESULT UnmarshalPropagationToken(uint cbToken, char* rgbToken, ITransaction* ppTransaction);
    HRESULT GetReturnTokenSize(uint* pcbReturnToken);
    HRESULT MarshalReturnToken(uint cbReturnToken, char* rgbReturnToken, uint* pcbUsed);
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
    HRESULT Add(char* pucLuPair, uint cbLuPair);
    HRESULT Delete(char* pucLuPair, uint cbLuPair);
}

@GUID("AC2B8AD2-D6F0-11D0-B386-00A0C9083365")
interface IDtcLuRecovery : IUnknown
{
}

@GUID("4131E762-1AEA-11D0-944B-00A0C905416E")
interface IDtcLuRecoveryFactory : IUnknown
{
    HRESULT Create(char* pucLuPair, uint cbLuPair, IDtcLuRecovery* ppRecovery);
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
    HRESULT CheckForCompareStates(int* fCompareStates);
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

@GUID("CAFC823C-B441-11D1-B82B-0000F8757E2A")
interface ISecurityIdentityColl : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("CAFC823D-B441-11D1-B82B-0000F8757E2A")
interface ISecurityCallersColl : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(int lIndex, ISecurityIdentityColl* pObj);
    HRESULT get__NewEnum(IUnknown* ppEnum);
}

@GUID("CAFC823E-B441-11D1-B82B-0000F8757E2A")
interface ISecurityCallContext : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT IsCallerInRole(BSTR bstrRole, short* pfInRole);
    HRESULT IsSecurityEnabled(short* pfIsEnabled);
    HRESULT IsUserInRole(VARIANT* pUser, BSTR bstrRole, short* pfInRole);
}

@GUID("CAFC823F-B441-11D1-B82B-0000F8757E2A")
interface IGetSecurityCallContext : IDispatch
{
    HRESULT GetSecurityCallContext(ISecurityCallContext* ppObject);
}

@GUID("E74A7215-014D-11D1-A63C-00A0C911B4E0")
interface SecurityProperty : IDispatch
{
    HRESULT GetDirectCallerName(BSTR* bstrUserName);
    HRESULT GetDirectCreatorName(BSTR* bstrUserName);
    HRESULT GetOriginalCallerName(BSTR* bstrUserName);
    HRESULT GetOriginalCreatorName(BSTR* bstrUserName);
}

@GUID("19A5A02C-0AC8-11D2-B286-00C04F8EF934")
interface ContextInfo : IDispatch
{
    HRESULT IsInTransaction(short* pbIsInTx);
    HRESULT GetTransaction(IUnknown* ppTx);
    HRESULT GetTransactionId(BSTR* pbstrTxId);
    HRESULT GetActivityId(BSTR* pbstrActivityId);
    HRESULT GetContextId(BSTR* pbstrCtxId);
}

@GUID("C99D6E75-2375-11D4-8331-00C04F605588")
interface ContextInfo2 : ContextInfo
{
    HRESULT GetPartitionId(BSTR* __MIDL__ContextInfo20000);
    HRESULT GetApplicationId(BSTR* __MIDL__ContextInfo20001);
    HRESULT GetApplicationInstanceId(BSTR* __MIDL__ContextInfo20002);
}

@GUID("74C08646-CEDB-11CF-8B49-00AA00B8A790")
interface ObjectContext : IDispatch
{
    HRESULT CreateInstance(BSTR bstrProgID, VARIANT* pObject);
    HRESULT SetComplete();
    HRESULT SetAbort();
    HRESULT EnableCommit();
    HRESULT DisableCommit();
    HRESULT IsInTransaction(short* pbIsInTx);
    HRESULT IsSecurityEnabled(short* pbIsEnabled);
    HRESULT IsCallerInRole(BSTR bstrRole, short* pbInRole);
    HRESULT get_Count(int* plCount);
    HRESULT get_Item(BSTR name, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* ppEnum);
    HRESULT get_Security(SecurityProperty* ppSecurityProperty);
    HRESULT get_ContextInfo(ContextInfo* ppContextInfo);
}

@GUID("7999FC22-D3C6-11CF-ACAB-00A024A55AEF")
interface ITransactionContextEx : IUnknown
{
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** pObject);
    HRESULT Commit();
    HRESULT Abort();
}

@GUID("7999FC21-D3C6-11CF-ACAB-00A024A55AEF")
interface ITransactionContext : IDispatch
{
    HRESULT CreateInstance(BSTR pszProgId, VARIANT* pObject);
    HRESULT Commit();
    HRESULT Abort();
}

@GUID("455ACF57-5345-11D2-99CF-00C04F797BC9")
interface ICreateWithTransactionEx : IUnknown
{
    HRESULT CreateInstance(ITransaction pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("227AC7A8-8423-42CE-B7CF-03061EC9AAA3")
interface ICreateWithLocalTransaction : IUnknown
{
    HRESULT CreateInstanceWithSysTx(IUnknown pTransaction, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("455ACF59-5345-11D2-99CF-00C04F797BC9")
interface ICreateWithTipTransactionEx : IUnknown
{
    HRESULT CreateInstance(BSTR bstrTipUrl, const(GUID)* rclsid, const(GUID)* riid, void** pObject);
}

@GUID("605CF82C-578E-4298-975D-82BABCD9E053")
interface IComLTxEvents : IUnknown
{
    HRESULT OnLtxTransactionStart(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID tsid, BOOL fRoot, 
                                  int nIsolationLevel);
    HRESULT OnLtxTransactionPrepare(COMSVCSEVENTINFO* pInfo, GUID guidLtx, BOOL fVote);
    HRESULT OnLtxTransactionAbort(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    HRESULT OnLtxTransactionCommit(COMSVCSEVENTINFO* pInfo, GUID guidLtx);
    HRESULT OnLtxTransactionPromote(COMSVCSEVENTINFO* pInfo, GUID guidLtx, GUID txnId);
}

@GUID("683130A4-2E50-11D2-98A5-00C04F8EE1C4")
interface IComUserEvent : IUnknown
{
    HRESULT OnUserEvent(COMSVCSEVENTINFO* pInfo, VARIANT* pvarEvent);
}

@GUID("683130A5-2E50-11D2-98A5-00C04F8EE1C4")
interface IComThreadEvents : IUnknown
{
    HRESULT OnThreadStart(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    HRESULT OnThreadTerminate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, uint dwThread, uint dwTheadCnt);
    HRESULT OnThreadBindToApartment(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt, 
                                    uint dwLowCnt);
    HRESULT OnThreadUnBind(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong AptID, uint dwActCnt);
    HRESULT OnThreadWorkEnque(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkPrivate(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID);
    HRESULT OnThreadWorkPublic(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadWorkRedirect(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen, 
                                 ulong ThreadNum);
    HRESULT OnThreadWorkReject(COMSVCSEVENTINFO* pInfo, ulong ThreadID, ulong MsgWorkID, uint QueueLen);
    HRESULT OnThreadAssignApartment(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong AptID);
    HRESULT OnThreadUnassignApartment(COMSVCSEVENTINFO* pInfo, ulong AptID);
}

@GUID("683130A6-2E50-11D2-98A5-00C04F8EE1C4")
interface IComAppEvents : IUnknown
{
    HRESULT OnAppActivation(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnAppShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnAppForceShutdown(COMSVCSEVENTINFO* pInfo, GUID guidApp);
}

@GUID("683130A7-2E50-11D2-98A5-00C04F8EE1C4")
interface IComInstanceEvents : IUnknown
{
    HRESULT OnObjectCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                           const(GUID)* tsid, ulong CtxtID, ulong ObjectID);
    HRESULT OnObjectDestroy(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("683130A8-2E50-11D2-98A5-00C04F8EE1C4")
interface IComTransactionEvents : IUnknown
{
    HRESULT OnTransactionStart(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot);
    HRESULT OnTransactionPrepare(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    HRESULT OnTransactionAbort(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    HRESULT OnTransactionCommit(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

@GUID("683130A9-2E50-11D2-98A5-00C04F8EE1C4")
interface IComMethodEvents : IUnknown
{
    HRESULT OnMethodCall(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                         uint iMeth);
    HRESULT OnMethodReturn(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                           uint iMeth, HRESULT hresult);
    HRESULT OnMethodException(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                              uint iMeth);
}

@GUID("683130AA-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectEvents : IUnknown
{
    HRESULT OnObjectActivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    HRESULT OnObjectDeactivate(COMSVCSEVENTINFO* pInfo, ulong CtxtID, ulong ObjectID);
    HRESULT OnDisableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnEnableCommit(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetComplete(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
    HRESULT OnSetAbort(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("683130AB-2E50-11D2-98A5-00C04F8EE1C4")
interface IComResourceEvents : IUnknown
{
    HRESULT OnResourceCreate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, BOOL enlisted);
    HRESULT OnResourceAllocate(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, 
                               BOOL enlisted, uint NumRated, uint Rating);
    HRESULT OnResourceRecycle(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId);
    HRESULT OnResourceDestroy(COMSVCSEVENTINFO* pInfo, ulong ObjectID, HRESULT hr, ushort* pszType, ulong resId);
    HRESULT OnResourceTrack(COMSVCSEVENTINFO* pInfo, ulong ObjectID, ushort* pszType, ulong resId, BOOL enlisted);
}

@GUID("683130AC-2E50-11D2-98A5-00C04F8EE1C4")
interface IComSecurityEvents : IUnknown
{
    HRESULT OnAuthenticate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                           const(GUID)* guidIID, uint iMeth, uint cbByteOrig, char* pSidOriginalUser, uint cbByteCur, 
                           char* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
    HRESULT OnAuthenticateFail(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, ulong ObjectID, 
                               const(GUID)* guidIID, uint iMeth, uint cbByteOrig, char* pSidOriginalUser, 
                               uint cbByteCur, char* pSidCurrentUser, BOOL bCurrentUserInpersonatingInProc);
}

@GUID("683130AD-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectPoolEvents : IUnknown
{
    HRESULT OnObjPoolPutObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                               ulong oid);
    HRESULT OnObjPoolGetObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               uint dwAvailable, ulong oid);
    HRESULT OnObjPoolRecycleToTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                 const(GUID)* guidTx, ulong objid);
    HRESULT OnObjPoolGetFromTx(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                               const(GUID)* guidTx, ulong objid);
}

@GUID("683130AE-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectPoolEvents2 : IUnknown
{
    HRESULT OnObjPoolCreateObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    HRESULT OnObjPoolDestroyObject(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwObjsCreated, ulong oid);
    HRESULT OnObjPoolCreateDecision(COMSVCSEVENTINFO* pInfo, uint dwThreadsWaiting, uint dwAvail, uint dwCreated, 
                                    uint dwMin, uint dwMax);
    HRESULT OnObjPoolTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, const(GUID)* guidActivity, 
                             uint dwTimeout);
    HRESULT OnObjPoolCreatePool(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, uint dwMin, uint dwMax, 
                                uint dwTimeout);
}

@GUID("683130AF-2E50-11D2-98A5-00C04F8EE1C4")
interface IComObjectConstructionEvents : IUnknown
{
    HRESULT OnObjectConstruct(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, ushort* sConstructString, 
                              ulong oid);
}

@GUID("683130B0-2E50-11D2-98A5-00C04F8EE1C4")
interface IComActivityEvents : IUnknown
{
    HRESULT OnActivityCreate(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    HRESULT OnActivityDestroy(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity);
    HRESULT OnActivityEnter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                            uint dwThread);
    HRESULT OnActivityTimeout(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidEntered, 
                              uint dwThread, uint dwTimeout);
    HRESULT OnActivityReenter(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwThread, uint dwCallDepth);
    HRESULT OnActivityLeave(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, const(GUID)* guidLeft);
    HRESULT OnActivityLeaveSame(COMSVCSEVENTINFO* pInfo, const(GUID)* guidCurrent, uint dwCallDepth);
}

@GUID("683130B1-2E50-11D2-98A5-00C04F8EE1C4")
interface IComIdentityEvents : IUnknown
{
    HRESULT OnIISRequestInfo(COMSVCSEVENTINFO* pInfo, ulong ObjId, ushort* pszClientIP, ushort* pszServerIP, 
                             ushort* pszURL);
}

@GUID("683130B2-2E50-11D2-98A5-00C04F8EE1C4")
interface IComQCEvents : IUnknown
{
    HRESULT OnQCRecord(COMSVCSEVENTINFO* pInfo, ulong objid, char* szQueue, const(GUID)* guidMsgId, 
                       const(GUID)* guidWorkFlowId, HRESULT msmqhr);
    HRESULT OnQCQueueOpen(COMSVCSEVENTINFO* pInfo, char* szQueue, ulong QueueID, HRESULT hr);
    HRESULT OnQCReceive(COMSVCSEVENTINFO* pInfo, ulong QueueID, const(GUID)* guidMsgId, 
                        const(GUID)* guidWorkFlowId, HRESULT hr);
    HRESULT OnQCReceiveFail(COMSVCSEVENTINFO* pInfo, ulong QueueID, HRESULT msmqhr);
    HRESULT OnQCMoveToReTryQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                                 uint RetryIndex);
    HRESULT OnQCMoveToDeadQueue(COMSVCSEVENTINFO* pInfo, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId);
    HRESULT OnQCPlayback(COMSVCSEVENTINFO* pInfo, ulong objid, const(GUID)* guidMsgId, const(GUID)* guidWorkFlowId, 
                         HRESULT hr);
}

@GUID("683130B3-2E50-11D2-98A5-00C04F8EE1C4")
interface IComExceptionEvents : IUnknown
{
    HRESULT OnExceptionUser(COMSVCSEVENTINFO* pInfo, uint code, ulong address, ushort* pszStackTrace);
}

@GUID("683130B4-2E50-11D2-98A5-00C04F8EE1C4")
interface ILBEvents : IUnknown
{
    HRESULT TargetUp(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT TargetDown(BSTR bstrServerName, BSTR bstrClsidEng);
    HRESULT EngineDefined(BSTR bstrPropName, VARIANT* varPropValue, BSTR bstrClsidEng);
}

@GUID("683130B5-2E50-11D2-98A5-00C04F8EE1C4")
interface IComCRMEvents : IUnknown
{
    HRESULT OnCRMRecoveryStart(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnCRMRecoveryDone(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnCRMCheckpoint(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnCRMBegin(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, GUID guidActivity, GUID guidTx, 
                       char* szProgIdCompensator, char* szDescription);
    HRESULT OnCRMPrepare(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMCommit(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMAbort(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMIndoubt(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMDone(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMRelease(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMAnalyze(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, uint dwCrmRecordType, uint dwRecordSize);
    HRESULT OnCRMWrite(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
    HRESULT OnCRMForget(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMForce(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID);
    HRESULT OnCRMDeliver(COMSVCSEVENTINFO* pInfo, GUID guidClerkCLSID, BOOL fVariants, uint dwRecordSize);
}

@GUID("FB388AAA-567D-4024-AF8E-6E93EE748573")
interface IComMethod2Events : IUnknown
{
    HRESULT OnMethodCall2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                          uint dwThread, uint iMeth);
    HRESULT OnMethodReturn2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                            uint dwThread, uint iMeth, HRESULT hresult);
    HRESULT OnMethodException2(COMSVCSEVENTINFO* pInfo, ulong oid, const(GUID)* guidCid, const(GUID)* guidRid, 
                               uint dwThread, uint iMeth);
}

@GUID("4E6CDCC9-FB25-4FD5-9CC5-C9F4B6559CEC")
interface IComTrackingInfoEvents : IUnknown
{
    HRESULT OnNewTrackingInfo(IUnknown pToplevelCollection);
}

@GUID("C266C677-C9AD-49AB-9FD9-D9661078588A")
interface IComTrackingInfoCollection : IUnknown
{
    HRESULT Type(TRACKING_COLL_TYPE* pType);
    HRESULT Count(uint* pCount);
    HRESULT Item(uint ulIndex, const(GUID)* riid, void** ppv);
}

@GUID("116E42C5-D8B1-47BF-AB1E-C895ED3E2372")
interface IComTrackingInfoObject : IUnknown
{
    HRESULT GetValue(ushort* szPropertyName, VARIANT* pvarOut);
}

@GUID("789B42BE-6F6B-443A-898E-67ABF390AA14")
interface IComTrackingInfoProperties : IUnknown
{
    HRESULT PropCount(uint* pCount);
    HRESULT GetPropName(uint ulIndex, ushort** ppszPropName);
}

@GUID("1290BC1A-B219-418D-B078-5934DED08242")
interface IComApp2Events : IUnknown
{
    HRESULT OnAppActivation2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess);
    HRESULT OnAppShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnAppForceShutdown2(COMSVCSEVENTINFO* pInfo, GUID guidApp);
    HRESULT OnAppPaused2(COMSVCSEVENTINFO* pInfo, GUID guidApp, BOOL bPaused);
    HRESULT OnAppRecycle2(COMSVCSEVENTINFO* pInfo, GUID guidApp, GUID guidProcess, int lReason);
}

@GUID("A136F62A-2F94-4288-86E0-D8A1FA4C0299")
interface IComTransaction2Events : IUnknown
{
    HRESULT OnTransactionStart2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, const(GUID)* tsid, BOOL fRoot, 
                                int nIsolationLevel);
    HRESULT OnTransactionPrepare2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx, BOOL fVoteYes);
    HRESULT OnTransactionAbort2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
    HRESULT OnTransactionCommit2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidTx);
}

@GUID("20E3BF07-B506-4AD5-A50C-D2CA5B9C158E")
interface IComInstance2Events : IUnknown
{
    HRESULT OnObjectCreate2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* clsid, 
                            const(GUID)* tsid, ulong CtxtID, ulong ObjectID, const(GUID)* guidPartition);
    HRESULT OnObjectDestroy2(COMSVCSEVENTINFO* pInfo, ulong CtxtID);
}

@GUID("65BF6534-85EA-4F64-8CF4-3D974B2AB1CF")
interface IComObjectPool2Events : IUnknown
{
    HRESULT OnObjPoolPutObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, int nReason, uint dwAvailable, 
                                ulong oid);
    HRESULT OnObjPoolGetObject2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                uint dwAvailable, ulong oid, const(GUID)* guidPartition);
    HRESULT OnObjPoolRecycleToTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                  const(GUID)* guidTx, ulong objid);
    HRESULT OnObjPoolGetFromTx2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidActivity, const(GUID)* guidObject, 
                                const(GUID)* guidTx, ulong objid, const(GUID)* guidPartition);
}

@GUID("4B5A7827-8DF2-45C0-8F6F-57EA1F856A9F")
interface IComObjectConstruction2Events : IUnknown
{
    HRESULT OnObjectConstruct2(COMSVCSEVENTINFO* pInfo, const(GUID)* guidObject, ushort* sConstructString, 
                               ulong oid, const(GUID)* guidPartition);
}

@GUID("D6D48A3C-D5C5-49E7-8C74-99E4889ED52F")
interface ISystemAppEventData : IUnknown
{
    HRESULT Startup();
    HRESULT OnDataChanged(uint dwPID, uint dwMask, uint dwNumberSinks, BSTR bstrDwMethodMask, uint dwReason, 
                          ulong u64TraceHandle);
}

@GUID("BACEDF4D-74AB-11D0-B162-00AA00BA3258")
interface IMtsEvents : IDispatch
{
    HRESULT get_PackageName(BSTR* pVal);
    HRESULT get_PackageGuid(BSTR* pVal);
    HRESULT PostEvent(VARIANT* vEvent);
    HRESULT get_FireEvents(short* pVal);
    HRESULT GetProcessID(int* id);
}

@GUID("D56C3DC1-8482-11D0-B170-00AA00BA3258")
interface IMtsEventInfo : IDispatch
{
    HRESULT get_Names(IUnknown* pUnk);
    HRESULT get_DisplayName(BSTR* sDisplayName);
    HRESULT get_EventID(BSTR* sGuidEventID);
    HRESULT get_Count(int* lCount);
    HRESULT get_Value(BSTR sKey, VARIANT* pVal);
}

@GUID("D19B8BFD-7F88-11D0-B16E-00AA00BA3258")
interface IMTSLocator : IDispatch
{
    HRESULT GetEventDispatcher(IUnknown* pUnk);
}

@GUID("4B2E958C-0393-11D1-B1AB-00AA00BA3258")
interface IMtsGrp : IDispatch
{
    HRESULT get_Count(int* pVal);
    HRESULT Item(int lIndex, IUnknown* ppUnkDispatcher);
    HRESULT Refresh();
}

@GUID("588A085A-B795-11D1-8054-00C04FC340EE")
interface IMessageMover : IDispatch
{
    HRESULT get_SourcePath(BSTR* pVal);
    HRESULT put_SourcePath(BSTR newVal);
    HRESULT get_DestPath(BSTR* pVal);
    HRESULT put_DestPath(BSTR newVal);
    HRESULT get_CommitBatchSize(int* pVal);
    HRESULT put_CommitBatchSize(int newVal);
    HRESULT MoveMessages(int* plMessagesMoved);
}

@GUID("9A9F12B8-80AF-47AB-A579-35EA57725370")
interface IEventServerTrace : IDispatch
{
    HRESULT StartTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT StopTraceGuid(BSTR bstrguidEvent, BSTR bstrguidFilter, int lPidFilter);
    HRESULT EnumTraceGuid(int* plCntGuids, BSTR* pbstrGuidList);
}

@GUID("507C3AC8-3E12-4CB0-9366-653D3E050638")
interface IGetAppTrackerData : IUnknown
{
    HRESULT GetApplicationProcesses(const(GUID)* PartitionId, const(GUID)* ApplicationId, uint Flags, 
                                    uint* NumApplicationProcesses, char* ApplicationProcesses);
    HRESULT GetApplicationProcessDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, uint Flags, 
                                         ApplicationProcessSummary* Summary, 
                                         ApplicationProcessStatistics* Statistics, 
                                         ApplicationProcessRecycleInfo* RecycleInfo, int* AnyComponentsHangMonitored);
    HRESULT GetApplicationsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                     uint Flags, uint* NumApplicationsInProcess, char* Applications);
    HRESULT GetComponentsInProcess(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* PartitionId, 
                                   const(GUID)* ApplicationId, uint Flags, uint* NumComponentsInProcess, 
                                   char* Components);
    HRESULT GetComponentDetails(const(GUID)* ApplicationInstanceId, uint ProcessId, const(GUID)* Clsid, uint Flags, 
                                ComponentSummary* Summary, ComponentStatistics* Statistics, 
                                ComponentHangMonitorInfo* HangMonitorInfo);
    HRESULT GetTrackerDataAsCollectionObject(IUnknown* TopLevelCollection);
    HRESULT GetSuggestedPollingInterval(uint* PollingIntervalInSeconds);
}

@GUID("5CB31E10-2B5F-11CF-BE10-00AA00A2FA25")
interface IDispenserManager : IUnknown
{
    HRESULT RegisterDispenser(IDispenserDriver __MIDL__IDispenserManager0000, ushort* szDispenserName, 
                              IHolder* __MIDL__IDispenserManager0001);
    HRESULT GetContext(size_t* __MIDL__IDispenserManager0002, size_t* __MIDL__IDispenserManager0003);
}

@GUID("BF6A1850-2B45-11CF-BE10-00AA00A2FA25")
interface IHolder : IUnknown
{
    HRESULT AllocResource(const(size_t) __MIDL__IHolder0000, size_t* __MIDL__IHolder0001);
    HRESULT FreeResource(const(size_t) __MIDL__IHolder0002);
    HRESULT TrackResource(const(size_t) __MIDL__IHolder0003);
    HRESULT TrackResourceS(ushort* __MIDL__IHolder0004);
    HRESULT UntrackResource(const(size_t) __MIDL__IHolder0005, const(int) __MIDL__IHolder0006);
    HRESULT UntrackResourceS(ushort* __MIDL__IHolder0007, const(int) __MIDL__IHolder0008);
    HRESULT Close();
    HRESULT RequestDestroyResource(const(size_t) __MIDL__IHolder0009);
}

@GUID("208B3651-2B48-11CF-BE10-00AA00A2FA25")
interface IDispenserDriver : IUnknown
{
    HRESULT CreateResource(const(size_t) ResTypId, size_t* pResId, int* pSecsFreeBeforeDestroy);
    HRESULT RateResource(const(size_t) ResTypId, const(size_t) ResId, const(int) fRequiresTransactionEnlistment, 
                         uint* pRating);
    HRESULT EnlistResource(const(size_t) ResId, const(size_t) TransId);
    HRESULT ResetResource(const(size_t) ResId);
    HRESULT DestroyResource(const(size_t) ResId);
    HRESULT DestroyResourceS(ushort* ResId);
}

@GUID("02558374-DF2E-4DAE-BD6B-1D5C994F9BDC")
interface ITransactionProxy : IUnknown
{
    HRESULT Commit(GUID guid);
    HRESULT Abort();
    HRESULT Promote(ITransaction* pTransaction);
    HRESULT CreateVoter(ITransactionVoterNotifyAsync2 pTxAsync, ITransactionVoterBallotAsync2* ppBallot);
    HRESULT GetIsolationLevel(int* __MIDL__ITransactionProxy0000);
    HRESULT GetIdentifier(GUID* pbstrIdentifier);
    HRESULT IsReusable(int* pfIsReusable);
}

@GUID("A7549A29-A7C4-42E1-8DC1-7E3D748DC24A")
interface IContextSecurityPerimeter : IUnknown
{
    HRESULT GetPerimeterFlag(int* pFlag);
    HRESULT SetPerimeterFlag(BOOL fFlag);
}

@GUID("13D86F31-0139-41AF-BCAD-C7D50435FE9F")
interface ITxProxyHolder : IUnknown
{
    void GetIdentifier(GUID* pGuidLtx);
}

@GUID("51372AE0-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectContext : IUnknown
{
    HRESULT CreateInstance(const(GUID)* rclsid, const(GUID)* riid, void** ppv);
    HRESULT SetComplete();
    HRESULT SetAbort();
    HRESULT EnableCommit();
    HRESULT DisableCommit();
    BOOL    IsInTransaction();
    BOOL    IsSecurityEnabled();
    HRESULT IsCallerInRole(BSTR bstrRole, int* pfIsInRole);
}

@GUID("51372AEC-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectControl : IUnknown
{
    HRESULT Activate();
    void    Deactivate();
    BOOL    CanBePooled();
}

@GUID("51372AF2-CAE7-11CF-BE81-00AA00A2FA25")
interface IEnumNames : IUnknown
{
    HRESULT Next(uint celt, BSTR* rgname, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumNames* ppenum);
}

@GUID("51372AEA-CAE7-11CF-BE81-00AA00A2FA25")
interface ISecurityProperty : IUnknown
{
    HRESULT GetDirectCreatorSID(void** pSID);
    HRESULT GetOriginalCreatorSID(void** pSID);
    HRESULT GetDirectCallerSID(void** pSID);
    HRESULT GetOriginalCallerSID(void** pSID);
    HRESULT ReleaseSID(void* pSID);
}

@GUID("7DC41850-0C31-11D0-8B79-00AA00B8A790")
interface ObjectControl : IUnknown
{
    HRESULT Activate();
    HRESULT Deactivate();
    HRESULT CanBePooled(short* pbPoolable);
}

@GUID("2A005C01-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedProperty : IDispatch
{
    HRESULT get_Value(VARIANT* pVal);
    HRESULT put_Value(VARIANT val);
}

@GUID("2A005C07-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedPropertyGroup : IDispatch
{
    HRESULT CreatePropertyByPosition(int Index, short* fExists, ISharedProperty* ppProp);
    HRESULT get_PropertyByPosition(int Index, ISharedProperty* ppProperty);
    HRESULT CreateProperty(BSTR Name, short* fExists, ISharedProperty* ppProp);
    HRESULT get_Property(BSTR Name, ISharedProperty* ppProperty);
}

@GUID("2A005C0D-A5DE-11CF-9E66-00AA00A3F464")
interface ISharedPropertyGroupManager : IDispatch
{
    HRESULT CreatePropertyGroup(BSTR Name, int* dwIsoMode, int* dwRelMode, short* fExists, 
                                ISharedPropertyGroup* ppGroup);
    HRESULT get_Group(BSTR Name, ISharedPropertyGroup* ppGroup);
    HRESULT get__NewEnum(IUnknown* retval);
}

@GUID("41C4F8B3-7439-11D2-98CB-00C04F8EE1C4")
interface IObjectConstruct : IUnknown
{
    HRESULT Construct(IDispatch pCtorObj);
}

@GUID("41C4F8B2-7439-11D2-98CB-00C04F8EE1C4")
interface IObjectConstructString : IDispatch
{
    HRESULT get_ConstructString(BSTR* pVal);
}

@GUID("51372AFC-CAE7-11CF-BE81-00AA00A2FA25")
interface IObjectContextActivity : IUnknown
{
    HRESULT GetActivityId(GUID* pGUID);
}

@GUID("75B52DDB-E8ED-11D1-93AD-00AA00BA3258")
interface IObjectContextInfo : IUnknown
{
    BOOL    IsInTransaction();
    HRESULT GetTransaction(IUnknown* pptrans);
    HRESULT GetTransactionId(GUID* pGuid);
    HRESULT GetActivityId(GUID* pGUID);
    HRESULT GetContextId(GUID* pGuid);
}

@GUID("594BE71A-4BC4-438B-9197-CFD176248B09")
interface IObjectContextInfo2 : IObjectContextInfo
{
    HRESULT GetPartitionId(GUID* pGuid);
    HRESULT GetApplicationId(GUID* pGuid);
    HRESULT GetApplicationInstanceId(GUID* pGuid);
}

@GUID("61F589E8-3724-4898-A0A4-664AE9E1D1B4")
interface ITransactionStatus : IUnknown
{
    HRESULT SetTransactionStatus(HRESULT hrStatus);
    HRESULT GetTransactionStatus(int* pHrStatus);
}

@GUID("92FD41CA-BAD9-11D2-9A2D-00C04F797BC9")
interface IObjectContextTip : IUnknown
{
    HRESULT GetTipUrl(BSTR* pTipUrl);
}

@GUID("51372AFD-CAE7-11CF-BE81-00AA00A2FA25")
interface IPlaybackControl : IUnknown
{
    HRESULT FinalClientRetry();
    HRESULT FinalServerRetry();
}

@GUID("51372AF4-CAE7-11CF-BE81-00AA00A2FA25")
interface IGetContextProperties : IUnknown
{
    HRESULT Count(int* plCount);
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    HRESULT EnumNames(IEnumNames* ppenum);
}

@GUID("3C05E54B-A42A-11D2-AFC4-00C04F8EE1C4")
interface IContextState : IUnknown
{
    HRESULT SetDeactivateOnReturn(short bDeactivate);
    HRESULT GetDeactivateOnReturn(short* pbDeactivate);
    HRESULT SetMyTransactionVote(TransactionVote txVote);
    HRESULT GetMyTransactionVote(TransactionVote* ptxVote);
}

@GUID("0A469861-5A91-43A0-99B6-D5E179BB0631")
interface IPoolManager : IDispatch
{
    HRESULT ShutdownPool(BSTR CLSIDOrProgID);
}

@GUID("DCF443F4-3F8A-4872-B9F0-369A796D12D6")
interface ISelectCOMLBServer : IUnknown
{
    HRESULT Init();
    HRESULT GetLBServer(IUnknown pUnk);
}

@GUID("3A0F150F-8EE5-4B94-B40E-AEF2F9E42ED2")
interface ICOMLBArguments : IUnknown
{
    HRESULT GetCLSID(GUID* pCLSID);
    HRESULT SetCLSID(GUID* pCLSID);
    HRESULT GetMachineName(uint cchSvr, char* szServerName);
    HRESULT SetMachineName(uint cchSvr, char* szServerName);
}

@GUID("A0E174B3-D26E-11D2-8F84-00805FC7BCD9")
interface ICrmLogControl : IUnknown
{
    HRESULT get_TransactionUOW(BSTR* pVal);
    HRESULT RegisterCompensator(const(wchar)* lpcwstrProgIdCompensator, const(wchar)* lpcwstrDescription, 
                                int lCrmRegFlags);
    HRESULT WriteLogRecordVariants(VARIANT* pLogRecord);
    HRESULT ForceLog();
    HRESULT ForgetLogRecord();
    HRESULT ForceTransactionToAbort();
    HRESULT WriteLogRecord(char* rgBlob, uint cBlob);
}

@GUID("F0BAF8E4-7804-11D1-82E9-00A0C91EEDE9")
interface ICrmCompensatorVariants : IUnknown
{
    HRESULT SetLogControlVariants(ICrmLogControl pLogControl);
    HRESULT BeginPrepareVariants();
    HRESULT PrepareRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndPrepareVariants(short* pbOkToPrepare);
    HRESULT BeginCommitVariants(short bRecovery);
    HRESULT CommitRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndCommitVariants();
    HRESULT BeginAbortVariants(short bRecovery);
    HRESULT AbortRecordVariants(VARIANT* pLogRecord, short* pbForget);
    HRESULT EndAbortVariants();
}

@GUID("BBC01830-8D3B-11D1-82EC-00A0C91EEDE9")
interface ICrmCompensator : IUnknown
{
    HRESULT SetLogControl(ICrmLogControl pLogControl);
    HRESULT BeginPrepare();
    HRESULT PrepareRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndPrepare(int* pfOkToPrepare);
    HRESULT BeginCommit(BOOL fRecovery);
    HRESULT CommitRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndCommit();
    HRESULT BeginAbort(BOOL fRecovery);
    HRESULT AbortRecord(CrmLogRecordRead crmLogRec, int* pfForget);
    HRESULT EndAbort();
}

@GUID("70C8E441-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitorLogRecords : IUnknown
{
    HRESULT get_Count(int* pVal);
    HRESULT get_TransactionState(CrmTransactionState* pVal);
    HRESULT get_StructuredRecords(short* pVal);
    HRESULT GetLogRecord(uint dwIndex, CrmLogRecordRead* pCrmLogRec);
    HRESULT GetLogRecordVariants(VARIANT IndexNumber, VARIANT* pLogRecord);
}

@GUID("70C8E442-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitorClerks : IDispatch
{
    HRESULT Item(VARIANT Index, VARIANT* pItem);
    HRESULT get__NewEnum(IUnknown* pVal);
    HRESULT get_Count(int* pVal);
    HRESULT ProgIdCompensator(VARIANT Index, VARIANT* pItem);
    HRESULT Description(VARIANT Index, VARIANT* pItem);
    HRESULT TransactionUOW(VARIANT Index, VARIANT* pItem);
    HRESULT ActivityId(VARIANT Index, VARIANT* pItem);
}

@GUID("70C8E443-C7ED-11D1-82FB-00A0C91EEDE9")
interface ICrmMonitor : IUnknown
{
    HRESULT GetClerks(ICrmMonitorClerks* pClerks);
    HRESULT HoldClerk(VARIANT Index, VARIANT* pItem);
}

@GUID("9C51D821-C98B-11D1-82FB-00A0C91EEDE9")
interface ICrmFormatLogRecords : IUnknown
{
    HRESULT GetColumnCount(int* plColumnCount);
    HRESULT GetColumnHeaders(VARIANT* pHeaders);
    HRESULT GetColumn(CrmLogRecordRead CrmLogRec, VARIANT* pFormattedLogRecord);
    HRESULT GetColumnVariants(VARIANT LogRecord, VARIANT* pFormattedLogRecord);
}

@GUID("1A0CF920-D452-46F4-BC36-48118D54EA52")
interface IServiceIISIntrinsicsConfig : IUnknown
{
    HRESULT IISIntrinsicsConfig(CSC_IISIntrinsicsConfig iisIntrinsicsConfig);
}

@GUID("09E6831E-04E1-4ED4-9D0F-E8B168BAFEAF")
interface IServiceComTIIntrinsicsConfig : IUnknown
{
    HRESULT ComTIIntrinsicsConfig(CSC_COMTIIntrinsicsConfig comtiIntrinsicsConfig);
}

@GUID("C7CD7379-F3F2-4634-811B-703281D73E08")
interface IServiceSxsConfig : IUnknown
{
    HRESULT SxsConfig(CSC_SxsConfig scsConfig);
    HRESULT SxsName(const(wchar)* szSxsName);
    HRESULT SxsDirectory(const(wchar)* szSxsDirectory);
}

@GUID("0FF5A96F-11FC-47D1-BAA6-25DD347E7242")
interface ICheckSxsConfig : IUnknown
{
    HRESULT IsSameSxsConfig(const(wchar)* wszSxsName, const(wchar)* wszSxsDirectory, const(wchar)* wszSxsAppName);
}

@GUID("92186771-D3B4-4D77-A8EA-EE842D586F35")
interface IServiceInheritanceConfig : IUnknown
{
    HRESULT ContainingContextTreatment(CSC_InheritanceConfig inheritanceConfig);
}

@GUID("186D89BC-F277-4BCC-80D5-4DF7B836EF4A")
interface IServiceThreadPoolConfig : IUnknown
{
    HRESULT SelectThreadPool(CSC_ThreadPool threadPool);
    HRESULT SetBindingInfo(CSC_Binding binding);
}

@GUID("772B3FBE-6FFD-42FB-B5F8-8F9B260F3810")
interface IServiceTransactionConfigBase : IUnknown
{
    HRESULT ConfigureTransaction(CSC_TransactionConfig transactionConfig);
    HRESULT IsolationLevel(COMAdminTxIsolationLevelOptions option);
    HRESULT TransactionTimeout(uint ulTimeoutSec);
    HRESULT BringYourOwnTransaction(const(wchar)* szTipURL);
    HRESULT NewTransactionDescription(const(wchar)* szTxDesc);
}

@GUID("59F4C2A3-D3D7-4A31-B6E4-6AB3177C50B9")
interface IServiceTransactionConfig : IServiceTransactionConfigBase
{
    HRESULT ConfigureBYOT(ITransaction pITxByot);
}

@GUID("33CAF1A1-FCB8-472B-B45E-967448DED6D8")
interface IServiceSysTxnConfig : IServiceTransactionConfig
{
    HRESULT ConfigureBYOTSysTxn(ITransactionProxy pTxProxy);
}

@GUID("FD880E81-6DCE-4C58-AF83-A208846C0030")
interface IServiceSynchronizationConfig : IUnknown
{
    HRESULT ConfigureSynchronization(CSC_SynchronizationConfig synchConfig);
}

@GUID("6C3A3E1D-0BA6-4036-B76F-D0404DB816C9")
interface IServiceTrackerConfig : IUnknown
{
    HRESULT TrackerConfig(CSC_TrackerConfig trackerConfig, const(wchar)* szTrackerAppName, 
                          const(wchar)* szTrackerCtxName);
}

@GUID("80182D03-5EA4-4831-AE97-55BEFFC2E590")
interface IServicePartitionConfig : IUnknown
{
    HRESULT PartitionConfig(CSC_PartitionConfig partitionConfig);
    HRESULT PartitionID(const(GUID)* guidPartitionID);
}

@GUID("BD3E2E12-42DD-40F4-A09A-95A50C58304B")
interface IServiceCall : IUnknown
{
    HRESULT OnCall();
}

@GUID("FE6777FB-A674-4177-8F32-6D707E113484")
interface IAsyncErrorNotify : IUnknown
{
    HRESULT OnError(HRESULT hr);
}

@GUID("67532E0C-9E2F-4450-A354-035633944E17")
interface IServiceActivity : IUnknown
{
    HRESULT SynchronousCall(IServiceCall pIServiceCall);
    HRESULT AsynchronousCall(IServiceCall pIServiceCall);
    HRESULT BindToCurrentThread();
    HRESULT UnbindFromThread();
}

@GUID("51372AF7-CAE7-11CF-BE81-00AA00A2FA25")
interface IThreadPoolKnobs : IUnknown
{
    HRESULT GetMaxThreads(int* plcMaxThreads);
    HRESULT GetCurrentThreads(int* plcCurrentThreads);
    HRESULT SetMaxThreads(int lcMaxThreads);
    HRESULT GetDeleteDelay(int* pmsecDeleteDelay);
    HRESULT SetDeleteDelay(int msecDeleteDelay);
    HRESULT GetMaxQueuedRequests(int* plcMaxQueuedRequests);
    HRESULT GetCurrentQueuedRequests(int* plcCurrentQueuedRequests);
    HRESULT SetMaxQueuedRequests(int lcMaxQueuedRequests);
    HRESULT SetMinThreads(int lcMinThreads);
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
    HRESULT GetCPUMetricEnabled(int* pbMetricEnabled);
    HRESULT SetCPUMetricEnabled(BOOL bMetricEnabled);
    HRESULT GetCreateThreadsAggressively(int* pbMetricEnabled);
    HRESULT SetCreateThreadsAggressively(BOOL bMetricEnabled);
    HRESULT GetMaxCSR(uint* pdwCSR);
    HRESULT SetMaxCSR(int dwCSR);
    HRESULT GetWaitTimeForThreadCleanup(uint* pdwThreadCleanupWaitTime);
    HRESULT SetWaitTimeForThreadCleanup(int dwThreadCleanupWaitTime);
}

@GUID("1113F52D-DC7F-4943-AED6-88D04027E32A")
interface IProcessInitializer : IUnknown
{
    HRESULT Startup(IUnknown punkProcessControl);
    HRESULT Shutdown();
}

@GUID("A9690656-5BCA-470C-8451-250C1F43A33E")
interface IServicePoolConfig : IUnknown
{
    HRESULT put_MaxPoolSize(uint dwMaxPool);
    HRESULT get_MaxPoolSize(uint* pdwMaxPool);
    HRESULT put_MinPoolSize(uint dwMinPool);
    HRESULT get_MinPoolSize(uint* pdwMinPool);
    HRESULT put_CreationTimeout(uint dwCreationTimeout);
    HRESULT get_CreationTimeout(uint* pdwCreationTimeout);
    HRESULT put_TransactionAffinity(BOOL fTxAffinity);
    HRESULT get_TransactionAffinity(int* pfTxAffinity);
    HRESULT put_ClassFactory(IClassFactory pFactory);
    HRESULT get_ClassFactory(IClassFactory* pFactory);
}

@GUID("B302DF81-EA45-451E-99A2-09F9FD1B1E13")
interface IServicePool : IUnknown
{
    HRESULT Initialize(IUnknown pPoolConfig);
    HRESULT GetObjectA(const(GUID)* riid, void** ppv);
    HRESULT Shutdown();
}

@GUID("C5DA4BEA-1B42-4437-8926-B6A38860A770")
interface IManagedPooledObj : IUnknown
{
    HRESULT SetHeld(BOOL m_bHeld);
}

@GUID("DA91B74E-5388-4783-949D-C1CD5FB00506")
interface IManagedPoolAction : IUnknown
{
    HRESULT LastRelease();
}

@GUID("1427C51A-4584-49D8-90A0-C50D8086CBE9")
interface IManagedObjectInfo : IUnknown
{
    HRESULT GetIUnknown(IUnknown* pUnk);
    HRESULT GetIObjectControl(IObjectControl* pCtrl);
    HRESULT SetInPool(BOOL bInPool, IManagedPooledObj pPooledObj);
    HRESULT SetWrapperStrength(BOOL bStrong);
}

@GUID("C7B67079-8255-42C6-9EC0-6994A3548780")
interface IAppDomainHelper : IDispatch
{
    HRESULT Initialize(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0000, void* pPool);
    HRESULT DoCallback(IUnknown pUnkAD, HRESULT***** __MIDL__IAppDomainHelper0001, void* pPool);
}

@GUID("391FFBB9-A8EE-432A-ABC8-BAA238DAB90F")
interface IAssemblyLocator : IDispatch
{
    HRESULT GetModules(BSTR applicationDir, BSTR applicationName, BSTR assemblyName, SAFEARRAY** pModules);
}

@GUID("A5F325AF-572F-46DA-B8AB-827C3D95D99E")
interface IManagedActivationEvents : IUnknown
{
    HRESULT CreateManagedStub(IManagedObjectInfo pInfo, BOOL fDist);
    HRESULT DestroyManagedStub(IManagedObjectInfo pInfo);
}

@GUID("2732FD59-B2B4-4D44-878C-8B8F09626008")
interface ISendMethodEvents : IUnknown
{
    HRESULT SendMethodCall(const(void)* pIdentity, const(GUID)* riid, uint dwMeth);
    HRESULT SendMethodReturn(const(void)* pIdentity, const(GUID)* riid, uint dwMeth, HRESULT hrCall, 
                             HRESULT hrServer);
}

@GUID("C5FEB7C1-346A-11D1-B1CC-00AA00BA3258")
interface ITransactionResourcePool : IUnknown
{
    HRESULT PutResource(IObjPool pPool, IUnknown pUnk);
    HRESULT GetResource(IObjPool pPool, IUnknown* ppUnk);
}

@GUID("51372AEF-CAE7-11CF-BE81-00AA00A2FA25")
interface IMTSCall : IUnknown
{
    HRESULT OnCall();
}

@GUID("D396DA85-BF8F-11D1-BBAE-00C04FC2FA5F")
interface IContextProperties : IUnknown
{
    HRESULT Count(int* plCount);
    HRESULT GetProperty(BSTR name, VARIANT* pProperty);
    HRESULT EnumNames(IEnumNames* ppenum);
    HRESULT SetProperty(BSTR name, VARIANT property);
    HRESULT RemoveProperty(BSTR name);
}

@GUID("7D8805A0-2EA7-11D1-B1CC-00AA00BA3258")
interface IObjPool : IUnknown
{
    void Reserved1();
    void Reserved2();
    void Reserved3();
    void Reserved4();
    void PutEndTx(IUnknown pObj);
    void Reserved5();
    void Reserved6();
}

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

@GUID("51372AF0-CAE7-11CF-BE81-00AA00A2FA25")
interface IMTSActivity : IUnknown
{
    HRESULT SynchronousCall(IMTSCall pCall);
    HRESULT AsyncCall(IMTSCall pCall);
    void    Reserved1();
    HRESULT BindToCurrentThread();
    HRESULT UnbindFromThread();
}

@GUID("4E14FB9F-2E22-11D1-9964-00C04FBBB345")
interface IEventSystem : IDispatch
{
    HRESULT Query(BSTR progID, BSTR queryCriteria, int* errorIndex, IUnknown* ppInterface);
    HRESULT Store(BSTR ProgID, IUnknown pInterface);
    HRESULT Remove(BSTR progID, BSTR queryCriteria, int* errorIndex);
    HRESULT get_EventObjectChangeEventClassID(BSTR* pbstrEventClassID);
    HRESULT QueryS(BSTR progID, BSTR queryCriteria, IUnknown* ppInterface);
    HRESULT RemoveS(BSTR progID, BSTR queryCriteria);
}

@GUID("FB2B72A0-7A68-11D1-88F9-0080C7D771BF")
interface IEventClass : IDispatch
{
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    HRESULT get_EventClassName(BSTR* pbstrEventClassName);
    HRESULT put_EventClassName(BSTR bstrEventClassName);
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    HRESULT get_FiringInterfaceID(BSTR* pbstrFiringInterfaceID);
    HRESULT put_FiringInterfaceID(BSTR bstrFiringInterfaceID);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_CustomConfigCLSID(BSTR* pbstrCustomConfigCLSID);
    HRESULT put_CustomConfigCLSID(BSTR bstrCustomConfigCLSID);
    HRESULT get_TypeLib(BSTR* pbstrTypeLib);
    HRESULT put_TypeLib(BSTR bstrTypeLib);
}

@GUID("FB2B72A1-7A68-11D1-88F9-0080C7D771BF")
interface IEventClass2 : IEventClass
{
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    HRESULT get_MultiInterfacePublisherFilterCLSID(BSTR* pbstrPubFilCLSID);
    HRESULT put_MultiInterfacePublisherFilterCLSID(BSTR bstrPubFilCLSID);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT get_FireInParallel(int* pfFireInParallel);
    HRESULT put_FireInParallel(BOOL fFireInParallel);
}

@GUID("4A6B0E15-2E38-11D1-9965-00C04FBBB345")
interface IEventSubscription : IDispatch
{
    HRESULT get_SubscriptionID(BSTR* pbstrSubscriptionID);
    HRESULT put_SubscriptionID(BSTR bstrSubscriptionID);
    HRESULT get_SubscriptionName(BSTR* pbstrSubscriptionName);
    HRESULT put_SubscriptionName(BSTR bstrSubscriptionName);
    HRESULT get_PublisherID(BSTR* pbstrPublisherID);
    HRESULT put_PublisherID(BSTR bstrPublisherID);
    HRESULT get_EventClassID(BSTR* pbstrEventClassID);
    HRESULT put_EventClassID(BSTR bstrEventClassID);
    HRESULT get_MethodName(BSTR* pbstrMethodName);
    HRESULT put_MethodName(BSTR bstrMethodName);
    HRESULT get_SubscriberCLSID(BSTR* pbstrSubscriberCLSID);
    HRESULT put_SubscriberCLSID(BSTR bstrSubscriberCLSID);
    HRESULT get_SubscriberInterface(IUnknown* ppSubscriberInterface);
    HRESULT put_SubscriberInterface(IUnknown pSubscriberInterface);
    HRESULT get_PerUser(int* pfPerUser);
    HRESULT put_PerUser(BOOL fPerUser);
    HRESULT get_OwnerSID(BSTR* pbstrOwnerSID);
    HRESULT put_OwnerSID(BSTR bstrOwnerSID);
    HRESULT get_Enabled(int* pfEnabled);
    HRESULT put_Enabled(BOOL fEnabled);
    HRESULT get_Description(BSTR* pbstrDescription);
    HRESULT put_Description(BSTR bstrDescription);
    HRESULT get_MachineName(BSTR* pbstrMachineName);
    HRESULT put_MachineName(BSTR bstrMachineName);
    HRESULT GetPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT PutPublisherProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT RemovePublisherProperty(BSTR bstrPropertyName);
    HRESULT GetPublisherPropertyCollection(IEventObjectCollection* collection);
    HRESULT GetSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT PutSubscriberProperty(BSTR bstrPropertyName, VARIANT* propertyValue);
    HRESULT RemoveSubscriberProperty(BSTR bstrPropertyName);
    HRESULT GetSubscriberPropertyCollection(IEventObjectCollection* collection);
    HRESULT get_InterfaceID(BSTR* pbstrInterfaceID);
    HRESULT put_InterfaceID(BSTR bstrInterfaceID);
}

@GUID("E0498C93-4EFE-11D1-9971-00C04FBBB345")
interface IFiringControl : IDispatch
{
    HRESULT FireSubscription(IEventSubscription subscription);
}

@GUID("465E5CC0-7B26-11D1-88FB-0080C7D771BF")
interface IPublisherFilter : IUnknown
{
    HRESULT Initialize(BSTR methodName, IDispatch dispUserDefined);
    HRESULT PrepareToFire(BSTR methodName, IFiringControl firingControl);
}

@GUID("465E5CC1-7B26-11D1-88FB-0080C7D771BF")
interface IMultiInterfacePublisherFilter : IUnknown
{
    HRESULT Initialize(IMultiInterfaceEventControl pEIC);
    HRESULT PrepareToFire(const(GUID)* iid, BSTR methodName, IFiringControl firingControl);
}

@GUID("F4A07D70-2E25-11D1-9964-00C04FBBB345")
interface IEventObjectChange : IUnknown
{
    HRESULT ChangedSubscription(EOC_ChangeType changeType, BSTR bstrSubscriptionID);
    HRESULT ChangedEventClass(EOC_ChangeType changeType, BSTR bstrEventClassID);
    HRESULT ChangedPublisher(EOC_ChangeType changeType, BSTR bstrPublisherID);
}

@GUID("7701A9C3-BD68-438F-83E0-67BF4F53A422")
interface IEventObjectChange2 : IUnknown
{
    HRESULT ChangedSubscription(COMEVENTSYSCHANGEINFO* pInfo);
    HRESULT ChangedEventClass(COMEVENTSYSCHANGEINFO* pInfo);
}

@GUID("F4A07D63-2E25-11D1-9964-00C04FBBB345")
interface IEnumEventObject : IUnknown
{
    HRESULT Clone(IEnumEventObject* ppInterface);
    HRESULT Next(uint cReqElem, char* ppInterface, uint* cRetElem);
    HRESULT Reset();
    HRESULT Skip(uint cSkipElem);
}

@GUID("F89AC270-D4EB-11D1-B682-00805FC79216")
interface IEventObjectCollection : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnkEnum);
    HRESULT get_Item(BSTR objectID, VARIANT* pItem);
    HRESULT get_NewEnum(IEnumEventObject* ppEnum);
    HRESULT get_Count(int* pCount);
    HRESULT Add(VARIANT* item, BSTR objectID);
    HRESULT Remove(BSTR objectID);
}

@GUID("0343E2F4-86F6-11D1-B760-00C04FB926AF")
interface IEventControl : IDispatch
{
    HRESULT SetPublisherFilter(BSTR methodName, IPublisherFilter pPublisherFilter);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT GetSubscriptions(BSTR methodName, BSTR optionalCriteria, int* optionalErrorIndex, 
                             IEventObjectCollection* ppCollection);
    HRESULT SetDefaultQuery(BSTR methodName, BSTR criteria, int* errorIndex);
}

@GUID("0343E2F5-86F6-11D1-B760-00C04FB926AF")
interface IMultiInterfaceEventControl : IUnknown
{
    HRESULT SetMultiInterfacePublisherFilter(IMultiInterfacePublisherFilter classFilter);
    HRESULT GetSubscriptions(const(GUID)* eventIID, BSTR bstrMethodName, BSTR optionalCriteria, 
                             int* optionalErrorIndex, IEventObjectCollection* ppCollection);
    HRESULT SetDefaultQuery(const(GUID)* eventIID, BSTR bstrMethodName, BSTR bstrCriteria, int* errorIndex);
    HRESULT get_AllowInprocActivation(int* pfAllowInprocActivation);
    HRESULT put_AllowInprocActivation(BOOL fAllowInprocActivation);
    HRESULT get_FireInParallel(int* pfFireInParallel);
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
