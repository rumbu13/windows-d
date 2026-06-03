// Written in the D programming language.

module windows.win32.storage.jet;

public import windows.core;
public import windows.win32.storage.structuredstorage : JET_API_PTR, JET_HANDLE, JET_TABLEID;

extern(Windows) @nogc nothrow:


// Enums


alias JET_RELOP = int;
enum : int
{
    JET_relopEquals               = 0x00000000,
    JET_relopPrefixEquals         = 0x00000001,
    JET_relopNotEquals            = 0x00000002,
    JET_relopLessThanOrEqual      = 0x00000003,
    JET_relopLessThan             = 0x00000004,
    JET_relopGreaterThanOrEqual   = 0x00000005,
    JET_relopGreaterThan          = 0x00000006,
    JET_relopBitmaskEqualsZero    = 0x00000007,
    JET_relopBitmaskNotEqualsZero = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-errcat-enumeration
alias JET_ERRCAT = int;
enum : int
{
    JET_errcatUnknown       = 0x00000000,
    JET_errcatError         = 0x00000001,
    JET_errcatOperation     = 0x00000002,
    JET_errcatFatal         = 0x00000003,
    JET_errcatIO            = 0x00000004,
    JET_errcatResource      = 0x00000005,
    JET_errcatMemory        = 0x00000006,
    JET_errcatQuota         = 0x00000007,
    JET_errcatDisk          = 0x00000008,
    JET_errcatData          = 0x00000009,
    JET_errcatCorruption    = 0x0000000a,
    JET_errcatInconsistent  = 0x0000000b,
    JET_errcatFragmentation = 0x0000000c,
    JET_errcatApi           = 0x0000000d,
    JET_errcatUsage         = 0x0000000e,
    JET_errcatState         = 0x0000000f,
    JET_errcatObsolete      = 0x00000010,
    JET_errcatMax           = 0x00000011,
}

alias JET_INDEXCHECKING = int;
enum : int
{
    JET_IndexCheckingOff              = 0x00000000,
    JET_IndexCheckingOn               = 0x00000001,
    JET_IndexCheckingDeferToOpenTable = 0x00000002,
    JET_IndexCheckingMax              = 0x00000003,
}

// Constants


enum uint JET_VERSION = 0x00000500U;
enum const(wchar)* JET_wszConfigStoreReadControl = "CsReadControl";

enum : uint
{
    JET_bitConfigStoreReadControlInhibitRead = 0x00000001U,
    JET_bitConfigStoreReadControlDisableAll  = 0x00000002U,
    JET_bitConfigStoreReadControlDefault     = 0x00000000U,
}

enum : const(wchar)*
{
    JET_wszConfigStoreRelPathSysParamDefault  = "SysParamDefault",
    JET_wszConfigStoreRelPathSysParamOverride = "SysParamOverride",
}

enum : uint
{
    JET_efvUseEngineDefault   = 0x40000001U,
    JET_efvUsePersistedFormat = 0x40000002U,
}

enum uint JET_efvAllowHigherPersistedFormat = 0x41000000U;

enum : uint
{
    JET_efvWindows19H1Rtm    = 0x000022d8U,
    JET_efvWindows10v2004    = 0x000023dcU,
    JET_efvWindowsServer2022 = 0x00002490U,
    JET_efvWindows11v21H2    = 0x000024b8U,
    JET_efvWindows11v22H2    = 0x00002508U,
    JET_efvWindows11v23H2    = 0x00002580U,
}

enum : uint
{
    JET_bitDefragmentBatchStart          = 0x00000001U,
    JET_bitDefragmentBatchStop           = 0x00000002U,
    JET_bitDefragmentAvailSpaceTreesOnly = 0x00000040U,
    JET_bitDefragmentNoPartialMerges     = 0x00000080U,
    JET_bitDefragmentBTree               = 0x00000100U,
}

enum : uint
{
    JET_cbtypNull                    = 0x00000000U,
    JET_cbtypFinalize                = 0x00000001U,
    JET_cbtypBeforeInsert            = 0x00000002U,
    JET_cbtypAfterInsert             = 0x00000004U,
    JET_cbtypBeforeReplace           = 0x00000008U,
    JET_cbtypAfterReplace            = 0x00000010U,
    JET_cbtypBeforeDelete            = 0x00000020U,
    JET_cbtypAfterDelete             = 0x00000040U,
    JET_cbtypUserDefinedDefaultValue = 0x00000080U,
}

enum uint JET_cbtypOnlineDefragCompleted = 0x00000100U;

enum : uint
{
    JET_cbtypFreeCursorLS = 0x00000200U,
    JET_cbtypFreeTableLS  = 0x00000400U,
}

enum : uint
{
    JET_bitTableInfoUpdatable = 0x00000001U,
    JET_bitTableInfoBookmark  = 0x00000002U,
    JET_bitTableInfoRollback  = 0x00000004U,
}

enum : uint
{
    JET_bitObjectSystem                                = 0x80000000U,
    JET_bitObjectTableFixedDDL                         = 0x40000000U,
    JET_bitObjectTableTemplate                         = 0x20000000U,
    JET_bitObjectTableDerived                          = 0x10000000U,
    JET_bitObjectTableNoFixedVarColumnsInDerivedTables = 0x04000000U,
}

enum uint cObjectInfoCols = 0x00000009U;
enum uint cColumnInfoCols = 0x0000000eU;
enum uint cIndexInfoCols = 0x0000000fU;
enum uint JET_MAX_COMPUTERNAME_LENGTH = 0x0000000fU;
enum uint JET_bitDurableCommitCallbackLogUnavailable = 0x00000001U;
enum uint JET_cbBookmarkMost = 0x00000100U;

enum : uint
{
    JET_cbNameMost     = 0x00000040U,
    JET_cbFullNameMost = 0x000000ffU,
}

enum uint JET_cbColumnLVPageOverhead = 0x00000052U;
enum uint JET_cbLVDefaultValueMost = 0x000000ffU;
enum uint JET_cbColumnMost = 0x000000ffU;
enum uint JET_cbLVColumnMost = 0x7fffffffU;

enum : uint
{
    JET_cbKeyMost8KBytePage = 0x000007d0U,
    JET_cbKeyMost4KBytePage = 0x000003e8U,
    JET_cbKeyMost2KBytePage = 0x000001f4U,
    JET_cbKeyMostMin        = 0x000000ffU,
    JET_cbKeyMost           = 0x000000ffU,
    JET_cbLimitKeyMost      = 0x00000100U,
}

enum uint JET_cbPrimaryKeyMost = 0x000000ffU;
enum uint JET_cbSecondaryKeyMost = 0x000000ffU;

enum : uint
{
    JET_ccolKeyMost    = 0x00000010U,
    JET_ccolMost       = 0x0000fee0U,
    JET_ccolFixedMost  = 0x0000007fU,
    JET_ccolVarMost    = 0x00000080U,
    JET_ccolTaggedMost = 0x0000fde1U,
}

enum : uint
{
    JET_EventLoggingDisable     = 0x00000000U,
    JET_EventLoggingLevelMin    = 0x00000001U,
    JET_EventLoggingLevelLow    = 0x00000019U,
    JET_EventLoggingLevelMedium = 0x00000032U,
    JET_EventLoggingLevelHigh   = 0x0000004bU,
    JET_EventLoggingLevelMax    = 0x00000064U,
}

enum : uint
{
    JET_IOPriorityNormal = 0x00000000U,
    JET_IOPriorityLow    = 0x00000001U,
}

enum : uint
{
    JET_configDefault          = 0x00000001U,
    JET_configRemoveQuotas     = 0x00000002U,
    JET_configLowDiskFootprint = 0x00000004U,
}

enum uint JET_configMediumDiskFootprint = 0x00000008U;

enum : uint
{
    JET_configLowMemory           = 0x00000010U,
    JET_configDynamicMediumMemory = 0x00000020U,
}

enum : uint
{
    JET_configLowPower          = 0x00000040U,
    JET_configSSDProfileIO      = 0x00000080U,
    JET_configRunSilent         = 0x00000100U,
    JET_configUnthrottledMemory = 0x00000200U,
}

enum uint JET_configHighConcurrencyScaling = 0x00000400U;

enum : uint
{
    JET_paramSystemPath             = 0x00000000U,
    JET_paramTempPath               = 0x00000001U,
    JET_paramLogFilePath            = 0x00000002U,
    JET_paramBaseName               = 0x00000003U,
    JET_paramEventSource            = 0x00000004U,
    JET_paramMaxSessions            = 0x00000005U,
    JET_paramMaxOpenTables          = 0x00000006U,
    JET_paramPreferredMaxOpenTables = 0x00000007U,
}

enum uint JET_paramCachedClosedTables = 0x0000007dU;

enum : uint
{
    JET_paramMaxCursors        = 0x00000008U,
    JET_paramMaxVerPages       = 0x00000009U,
    JET_paramPreferredVerPages = 0x0000003fU,
}

enum uint JET_paramGlobalMinVerPages = 0x00000051U;
enum uint JET_paramVersionStoreTaskQueueMax = 0x00000069U;
enum uint JET_paramMaxTemporaryTables = 0x0000000aU;

enum : uint
{
    JET_paramLogFileSize         = 0x0000000bU,
    JET_paramLogBuffers          = 0x0000000cU,
    JET_paramWaitLogFlush        = 0x0000000dU,
    JET_paramLogCheckpointPeriod = 0x0000000eU,
    JET_paramLogWaitingUserMax   = 0x0000000fU,
}

enum : uint
{
    JET_paramCommitDefault   = 0x00000010U,
    JET_paramCircularLog     = 0x00000011U,
    JET_paramDbExtensionSize = 0x00000012U,
}

enum : uint
{
    JET_paramPageTempDBMin   = 0x00000013U,
    JET_paramPageFragment    = 0x00000014U,
    JET_paramEnableFileCache = 0x0000007eU,
}

enum : uint
{
    JET_paramVerPageSize    = 0x00000080U,
    JET_paramConfiguration  = 0x00000081U,
    JET_paramEnableAdvanced = 0x00000082U,
}

enum : uint
{
    JET_paramMaxColtyp        = 0x00000083U,
    JET_paramBatchIOBufferMax = 0x00000016U,
}

enum : uint
{
    JET_paramCacheSize          = 0x00000029U,
    JET_paramCacheSizeMin       = 0x0000003cU,
    JET_paramCacheSizeMax       = 0x00000017U,
    JET_paramCheckpointDepthMax = 0x00000018U,
}

enum : uint
{
    JET_paramLRUKCorrInterval    = 0x00000019U,
    JET_paramLRUKHistoryMax      = 0x0000001aU,
    JET_paramLRUKPolicy          = 0x0000001bU,
    JET_paramLRUKTimeout         = 0x0000001cU,
    JET_paramLRUKTrxCorrInterval = 0x0000001dU,
}

enum uint JET_paramOutstandingIOMax = 0x0000001eU;
enum uint JET_paramStartFlushThreshold = 0x0000001fU;
enum uint JET_paramStopFlushThreshold = 0x00000020U;
enum uint JET_paramEnableViewCache = 0x0000007fU;
enum uint JET_paramCheckpointIOMax = 0x00000087U;

enum : uint
{
    JET_paramTableClass1Name  = 0x00000089U,
    JET_paramTableClass2Name  = 0x0000008aU,
    JET_paramTableClass3Name  = 0x0000008bU,
    JET_paramTableClass4Name  = 0x0000008cU,
    JET_paramTableClass5Name  = 0x0000008dU,
    JET_paramTableClass6Name  = 0x0000008eU,
    JET_paramTableClass7Name  = 0x0000008fU,
    JET_paramTableClass8Name  = 0x00000090U,
    JET_paramTableClass9Name  = 0x00000091U,
    JET_paramTableClass10Name = 0x00000092U,
    JET_paramTableClass11Name = 0x00000093U,
    JET_paramTableClass12Name = 0x00000094U,
    JET_paramTableClass13Name = 0x00000095U,
    JET_paramTableClass14Name = 0x00000096U,
    JET_paramTableClass15Name = 0x00000097U,
}

enum : uint
{
    JET_paramIOPriority         = 0x00000098U,
    JET_paramRecovery           = 0x00000022U,
    JET_paramEnableOnlineDefrag = 0x00000023U,
}

enum uint JET_paramCheckFormatWhenOpenFail = 0x0000002cU;
enum uint JET_paramEnableTempTableVersioning = 0x0000002eU;
enum uint JET_paramIgnoreLogVersion = 0x0000002fU;

enum : uint
{
    JET_paramDeleteOldLogs  = 0x00000030U,
    JET_paramEventSourceKey = 0x00000031U,
}

enum uint JET_paramNoInformationEvent = 0x00000032U;
enum uint JET_paramEventLoggingLevel = 0x00000033U;
enum uint JET_paramDeleteOutOfRangeLogs = 0x00000034U;
enum uint JET_paramAccessDeniedRetryPeriod = 0x00000035U;

enum : uint
{
    JET_paramEnableIndexChecking = 0x0000002dU,
    JET_paramEnableIndexCleanup  = 0x00000036U,
}

enum uint JET_paramDatabasePageSize = 0x00000040U;
enum uint JET_paramDisableCallbacks = 0x00000041U;
enum uint JET_paramLogFileCreateAsynch = 0x00000045U;

enum : uint
{
    JET_paramErrorToString            = 0x00000046U,
    JET_paramZeroDatabaseDuringBackup = 0x00000047U,
}

enum uint JET_paramUnicodeIndexDefault = 0x00000048U;
enum uint JET_paramRuntimeCallback = 0x00000049U;
enum uint JET_paramCleanupMismatchedLogFiles = 0x0000004dU;
enum uint JET_paramRecordUpgradeDirtyLevel = 0x0000004eU;
enum uint JET_paramOSSnapshotTimeout = 0x00000052U;

enum : uint
{
    JET_paramExceptionAction      = 0x00000062U,
    JET_paramEventLogCache        = 0x00000063U,
    JET_paramCreatePathIfNotExist = 0x00000064U,
}

enum uint JET_paramPageHintCacheSize = 0x00000065U;
enum uint JET_paramOneDatabasePerSession = 0x00000066U;

enum : uint
{
    JET_paramMaxInstances   = 0x00000068U,
    JET_paramDisablePerfmon = 0x0000006bU,
}

enum : uint
{
    JET_paramIndexTuplesLengthMin  = 0x0000006eU,
    JET_paramIndexTuplesLengthMax  = 0x0000006fU,
    JET_paramIndexTuplesToIndexMax = 0x00000070U,
}

enum uint JET_paramAlternateDatabaseRecoveryPath = 0x00000071U;

enum : uint
{
    JET_paramIndexTupleIncrement = 0x00000084U,
    JET_paramIndexTupleStart     = 0x00000085U,
}

enum : uint
{
    JET_paramKeyMost         = 0x00000086U,
    JET_paramLegacyFileNames = 0x00000088U,
}

enum uint JET_paramEnablePersistedCallbacks = 0x0000009cU;
enum uint JET_paramWaypointLatency = 0x00000099U;

enum : uint
{
    JET_paramDefragmentSequentialBTrees                      = 0x000000a0U,
    JET_paramDefragmentSequentialBTreesDensityCheckFrequency = 0x000000a1U,
}

enum uint JET_paramIOThrottlingTimeQuanta = 0x000000a2U;
enum uint JET_paramLVChunkSizeMost = 0x000000a3U;

enum : uint
{
    JET_paramMaxCoalesceReadSize     = 0x000000a4U,
    JET_paramMaxCoalesceWriteSize    = 0x000000a5U,
    JET_paramMaxCoalesceReadGapSize  = 0x000000a6U,
    JET_paramMaxCoalesceWriteGapSize = 0x000000a7U,
}

enum uint JET_paramEnableDBScanInRecovery = 0x000000a9U;

enum : uint
{
    JET_paramDbScanThrottle       = 0x000000aaU,
    JET_paramDbScanIntervalMinSec = 0x000000abU,
    JET_paramDbScanIntervalMaxSec = 0x000000acU,
}

enum : uint
{
    JET_paramCachePriority      = 0x000000b1U,
    JET_paramMaxTransactionSize = 0x000000b2U,
}

enum : uint
{
    JET_paramPrereadIOMax              = 0x000000b3U,
    JET_paramEnableDBScanSerialization = 0x000000b4U,
}

enum : uint
{
    JET_paramHungIOThreshold  = 0x000000b5U,
    JET_paramHungIOActions    = 0x000000b6U,
    JET_paramMinDataForXpress = 0x000000b7U,
}

enum uint JET_paramEnableShrinkDatabase = 0x000000b8U;
enum uint JET_paramProcessFriendlyName = 0x000000baU;
enum uint JET_paramDurableCommitCallback = 0x000000bbU;

enum : uint
{
    JET_paramEnableSqm       = 0x000000bcU,
    JET_paramConfigStoreSpec = 0x000000bdU,
}

enum uint JET_paramEngineFormatVersion = 0x000000c2U;
enum uint JET_paramUseFlushForWriteDurability = 0x000000d6U;

enum : uint
{
    JET_paramEnableRBS              = 0x000000d7U,
    JET_paramRBSFilePath            = 0x000000d8U,
    JET_paramPerfmonRefreshInterval = 0x000000d9U,
}

enum uint JET_paramEnableBlockCache = 0x000000daU;

enum : uint
{
    JET_paramTraceFlags      = 0x000000dfU,
    JET_paramMaxValueInvalid = 0x000000e8U,
}

enum : uint
{
    JET_sesparamCommitDefault    = 0x00001001U,
    JET_sesparamTransactionLevel = 0x00001003U,
    JET_sesparamOperationContext = 0x00001004U,
    JET_sesparamCorrelationID    = 0x00001005U,
    JET_sesparamMaxValueInvalid  = 0x0000100fU,
}

enum uint JET_bitESE98FileNames = 0x00000001U;
enum uint JET_bitEightDotThreeSoftCompat = 0x00000002U;
enum uint JET_bitHungIOEvent = 0x00000001U;

enum : uint
{
    JET_bitShrinkDatabaseOff      = 0x00000000U,
    JET_bitShrinkDatabaseOn       = 0x00000001U,
    JET_bitShrinkDatabaseRealtime = 0x00000002U,
    JET_bitShrinkDatabaseTrim     = 0x00000001U,
}

enum uint JET_bitReplayIgnoreMissingDB = 0x00000004U;
enum uint JET_bitRecoveryWithoutUndo = 0x00000008U;
enum uint JET_bitTruncateLogsAfterRecovery = 0x00000010U;
enum uint JET_bitReplayMissingMapEntryDB = 0x00000020U;
enum uint JET_bitLogStreamMustExist = 0x00000040U;
enum uint JET_bitReplayIgnoreLostLogs = 0x00000080U;
enum uint JET_bitKeepDbAttachedAtEndOfRecovery = 0x00001000U;

enum : uint
{
    JET_bitTermComplete           = 0x00000001U,
    JET_bitTermAbrupt             = 0x00000002U,
    JET_bitTermStopBackup         = 0x00000004U,
    JET_bitTermDirty              = 0x00000008U,
    JET_bitIdleFlushBuffers       = 0x00000001U,
    JET_bitIdleCompact            = 0x00000002U,
    JET_bitIdleStatus             = 0x00000004U,
    JET_bitDbReadOnly             = 0x00000001U,
    JET_bitDbExclusive            = 0x00000002U,
    JET_bitDbDeleteCorruptIndexes = 0x00000010U,
    JET_bitDbDeleteUnicodeIndexes = 0x00000400U,
}

enum : uint
{
    JET_bitDbUpgrade                     = 0x00000200U,
    JET_bitDbEnableBackgroundMaintenance = 0x00000800U,
}

enum uint JET_bitDbPurgeCacheOnAttach = 0x00001000U;
enum uint JET_bitForceDetach = 0x00000001U;

enum : uint
{
    JET_bitDbRecoveryOff       = 0x00000008U,
    JET_bitDbShadowingOff      = 0x00000080U,
    JET_bitDbOverwriteExisting = 0x00000200U,
}

enum : uint
{
    JET_bitBackupIncremental  = 0x00000001U,
    JET_bitBackupAtomic       = 0x00000004U,
    JET_bitBackupSnapshot     = 0x00000010U,
    JET_bitBackupEndNormal    = 0x00000001U,
    JET_bitBackupEndAbort     = 0x00000002U,
    JET_bitBackupTruncateDone = 0x00000100U,
}

enum : uint
{
    JET_bitTableCreateFixedDDL                         = 0x00000001U,
    JET_bitTableCreateTemplateTable                    = 0x00000002U,
    JET_bitTableCreateNoFixedVarColumnsInDerivedTables = 0x00000004U,
}

enum uint JET_bitTableCreateImmutableStructure = 0x00000008U;

enum : uint
{
    JET_bitColumnFixed              = 0x00000001U,
    JET_bitColumnTagged             = 0x00000002U,
    JET_bitColumnNotNULL            = 0x00000004U,
    JET_bitColumnVersion            = 0x00000008U,
    JET_bitColumnAutoincrement      = 0x00000010U,
    JET_bitColumnUpdatable          = 0x00000020U,
    JET_bitColumnTTKey              = 0x00000040U,
    JET_bitColumnTTDescending       = 0x00000080U,
    JET_bitColumnMultiValued        = 0x00000400U,
    JET_bitColumnEscrowUpdate       = 0x00000800U,
    JET_bitColumnUnversioned        = 0x00001000U,
    JET_bitColumnMaybeNull          = 0x00002000U,
    JET_bitColumnFinalize           = 0x00004000U,
    JET_bitColumnUserDefinedDefault = 0x00008000U,
    JET_bitColumnDeleteOnZero       = 0x00020000U,
    JET_bitColumnCompressed         = 0x00080000U,
}

enum uint JET_bitDeleteColumnIgnoreTemplateColumns = 0x00000001U;

enum : uint
{
    JET_bitMoveFirst   = 0x00000000U,
    JET_bitNoMove      = 0x00000002U,
    JET_bitNewKey      = 0x00000001U,
    JET_bitStrLimit    = 0x00000002U,
    JET_bitSubStrLimit = 0x00000004U,
}

enum uint JET_bitNormalizedKey = 0x00000008U;
enum uint JET_bitKeyDataZeroLength = 0x00000010U;

enum : uint
{
    JET_bitFullColumnStartLimit = 0x00000100U,
    JET_bitFullColumnEndLimit   = 0x00000200U,
}

enum : uint
{
    JET_bitPartialColumnStartLimit = 0x00000400U,
    JET_bitPartialColumnEndLimit   = 0x00000800U,
}

enum : uint
{
    JET_bitRangeInclusive       = 0x00000001U,
    JET_bitRangeUpperLimit      = 0x00000002U,
    JET_bitRangeInstantDuration = 0x00000004U,
    JET_bitRangeRemove          = 0x00000008U,
    JET_bitReadLock             = 0x00000001U,
    JET_bitWriteLock            = 0x00000002U,
}

enum uint JET_MoveFirst = 0x80000000U;
enum int JET_MovePrevious = 0xffffffff;
enum uint JET_MoveLast = 0x7fffffffU;

enum : uint
{
    JET_bitMoveKeyNE     = 0x00000001U,
    JET_bitSeekEQ        = 0x00000001U,
    JET_bitSeekLT        = 0x00000002U,
    JET_bitSeekLE        = 0x00000004U,
    JET_bitSeekGE        = 0x00000008U,
    JET_bitSeekGT        = 0x00000010U,
    JET_bitSetIndexRange = 0x00000020U,
}

enum uint JET_bitCheckUniqueness = 0x00000040U;
enum uint JET_bitBookmarkPermitVirtualCurrency = 0x00000001U;

enum : uint
{
    JET_bitIndexColumnMustBeNull    = 0x00000001U,
    JET_bitIndexColumnMustBeNonNull = 0x00000002U,
}

enum : uint
{
    JET_bitRecordInIndex    = 0x00000001U,
    JET_bitRecordNotInIndex = 0x00000002U,
}

enum : uint
{
    JET_bitIndexUnique             = 0x00000001U,
    JET_bitIndexPrimary            = 0x00000002U,
    JET_bitIndexDisallowNull       = 0x00000004U,
    JET_bitIndexIgnoreNull         = 0x00000008U,
    JET_bitIndexIgnoreAnyNull      = 0x00000020U,
    JET_bitIndexIgnoreFirstNull    = 0x00000040U,
    JET_bitIndexLazyFlush          = 0x00000080U,
    JET_bitIndexEmpty              = 0x00000100U,
    JET_bitIndexUnversioned        = 0x00000200U,
    JET_bitIndexSortNullsHigh      = 0x00000400U,
    JET_bitIndexUnicode            = 0x00000800U,
    JET_bitIndexTuples             = 0x00001000U,
    JET_bitIndexTupleLimits        = 0x00002000U,
    JET_bitIndexCrossProduct       = 0x00004000U,
    JET_bitIndexKeyMost            = 0x00008000U,
    JET_bitIndexDisallowTruncation = 0x00010000U,
}

enum : uint
{
    JET_bitIndexNestedTable        = 0x00020000U,
    JET_bitIndexDotNetGuid         = 0x00040000U,
    JET_bitIndexImmutableStructure = 0x00080000U,
}

enum : uint
{
    JET_bitKeyAscending  = 0x00000000U,
    JET_bitKeyDescending = 0x00000001U,
}

enum : uint
{
    JET_bitTableDenyWrite     = 0x00000001U,
    JET_bitTableDenyRead      = 0x00000002U,
    JET_bitTableReadOnly      = 0x00000004U,
    JET_bitTableUpdatable     = 0x00000008U,
    JET_bitTablePermitDDL     = 0x00000010U,
    JET_bitTableNoCache       = 0x00000020U,
    JET_bitTablePreread       = 0x00000040U,
    JET_bitTableOpportuneRead = 0x00000080U,
    JET_bitTableSequential    = 0x00008000U,
    JET_bitTableClassMask     = 0x001f0000U,
    JET_bitTableClassNone     = 0x00000000U,
    JET_bitTableClass1        = 0x00010000U,
    JET_bitTableClass2        = 0x00020000U,
    JET_bitTableClass3        = 0x00030000U,
    JET_bitTableClass4        = 0x00040000U,
    JET_bitTableClass5        = 0x00050000U,
    JET_bitTableClass6        = 0x00060000U,
    JET_bitTableClass7        = 0x00070000U,
    JET_bitTableClass8        = 0x00080000U,
    JET_bitTableClass9        = 0x00090000U,
    JET_bitTableClass10       = 0x000a0000U,
    JET_bitTableClass11       = 0x000b0000U,
    JET_bitTableClass12       = 0x000c0000U,
    JET_bitTableClass13       = 0x000d0000U,
    JET_bitTableClass14       = 0x000e0000U,
    JET_bitTableClass15       = 0x000f0000U,
}

enum : uint
{
    JET_bitLSReset              = 0x00000001U,
    JET_bitLSCursor             = 0x00000002U,
    JET_bitLSTable              = 0x00000004U,
    JET_bitPrereadForward       = 0x00000001U,
    JET_bitPrereadBackward      = 0x00000002U,
    JET_bitPrereadFirstPage     = 0x00000004U,
    JET_bitPrereadNormalizedKey = 0x00000008U,
}

enum : uint
{
    JET_bitTTIndexed              = 0x00000001U,
    JET_bitTTUnique               = 0x00000002U,
    JET_bitTTUpdatable            = 0x00000004U,
    JET_bitTTScrollable           = 0x00000008U,
    JET_bitTTSortNullsHigh        = 0x00000010U,
    JET_bitTTForceMaterialization = 0x00000020U,
}

enum uint JET_bitTTErrorOnDuplicateInsertion = 0x00000020U;

enum : uint
{
    JET_bitTTForwardOnly      = 0x00000040U,
    JET_bitTTIntrinsicLVsOnly = 0x00000080U,
}

enum : uint
{
    JET_bitTTDotNetGuid     = 0x00000100U,
    JET_bitTTMaterializeBBT = 0x00000200U,
}

enum : uint
{
    JET_bitSetAppendLV                    = 0x00000001U,
    JET_bitSetOverwriteLV                 = 0x00000004U,
    JET_bitSetSizeLV                      = 0x00000008U,
    JET_bitSetZeroLength                  = 0x00000020U,
    JET_bitSetSeparateLV                  = 0x00000040U,
    JET_bitSetUniqueMultiValues           = 0x00000080U,
    JET_bitSetUniqueNormalizedMultiValues = 0x00000100U,
}

enum uint JET_bitSetRevertToDefaultValue = 0x00000200U;

enum : uint
{
    JET_bitSetIntrinsicLV  = 0x00000400U,
    JET_bitSetUncompressed = 0x00010000U,
    JET_bitSetCompressed   = 0x00020000U,
    JET_bitSetContiguousLV = 0x00040000U,
}

enum uint JET_bitSpaceHintsUtilizeParentSpace = 0x00000001U;

enum : uint
{
    JET_bitCreateHintAppendSequential   = 0x00000002U,
    JET_bitCreateHintHotpointSequential = 0x00000004U,
}

enum : uint
{
    JET_bitRetrieveHintReserve1          = 0x00000008U,
    JET_bitRetrieveHintTableScanForward  = 0x00000010U,
    JET_bitRetrieveHintTableScanBackward = 0x00000020U,
    JET_bitRetrieveHintReserve2          = 0x00000040U,
    JET_bitRetrieveHintReserve3          = 0x00000080U,
}

enum uint JET_bitDeleteHintTableSequential = 0x00000100U;

enum : uint
{
    JET_prepInsert        = 0x00000000U,
    JET_prepReplace       = 0x00000002U,
    JET_prepCancel        = 0x00000003U,
    JET_prepReplaceNoLock = 0x00000004U,
}

enum : uint
{
    JET_prepInsertCopy                = 0x00000005U,
    JET_prepInsertCopyDeleteOriginal  = 0x00000007U,
    JET_prepInsertCopyReplaceOriginal = 0x00000009U,
}

enum : uint
{
    JET_sqmDisable  = 0x00000000U,
    JET_sqmEnable   = 0x00000001U,
    JET_sqmFromCEIP = 0x00000002U,
}

enum uint JET_bitUpdateCheckESE97Compatibility = 0x00000001U;
enum uint JET_bitEscrowNoRollback = 0x00000001U;

enum : uint
{
    JET_bitRetrieveCopy                = 0x00000001U,
    JET_bitRetrieveFromIndex           = 0x00000002U,
    JET_bitRetrieveFromPrimaryBookmark = 0x00000004U,
    JET_bitRetrieveTag                 = 0x00000008U,
    JET_bitRetrieveNull                = 0x00000010U,
    JET_bitRetrieveIgnoreDefault       = 0x00000020U,
    JET_bitRetrieveTuple               = 0x00000800U,
}

enum : uint
{
    JET_bitZeroLength                        = 0x00000001U,
    JET_bitEnumerateCopy                     = 0x00000001U,
    JET_bitEnumerateIgnoreDefault            = 0x00000020U,
    JET_bitEnumeratePresenceOnly             = 0x00020000U,
    JET_bitEnumerateTaggedOnly               = 0x00040000U,
    JET_bitEnumerateCompressOutput           = 0x00080000U,
    JET_bitEnumerateIgnoreUserDefinedDefault = 0x00100000U,
    JET_bitEnumerateInRecordOnly             = 0x00200000U,
}

enum : uint
{
    JET_bitRecordSizeInCopyBuffer = 0x00000001U,
    JET_bitRecordSizeRunningTotal = 0x00000002U,
    JET_bitRecordSizeLocal        = 0x00000004U,
}

enum uint JET_bitTransactionReadOnly = 0x00000001U;
enum uint JET_bitCommitLazyFlush = 0x00000001U;

enum : uint
{
    JET_bitWaitLastLevel0Commit = 0x00000002U,
    JET_bitWaitAllLevel0Commit  = 0x00000008U,
}

enum uint JET_bitForceNewLog = 0x00000010U;
enum uint JET_bitRollbackAll = 0x00000001U;
enum uint JET_bitIncrementalSnapshot = 0x00000001U;

enum : uint
{
    JET_bitCopySnapshot      = 0x00000002U,
    JET_bitContinueAfterThaw = 0x00000004U,
}

enum uint JET_bitExplicitPrepare = 0x00000008U;
enum uint JET_bitAllDatabasesSnapshot = 0x00000001U;
enum uint JET_bitAbortSnapshot = 0x00000001U;

enum : uint
{
    JET_DbInfoFilename       = 0x00000000U,
    JET_DbInfoConnect        = 0x00000001U,
    JET_DbInfoCountry        = 0x00000002U,
    JET_DbInfoLCID           = 0x00000003U,
    JET_DbInfoLangid         = 0x00000003U,
    JET_DbInfoCp             = 0x00000004U,
    JET_DbInfoCollate        = 0x00000005U,
    JET_DbInfoOptions        = 0x00000006U,
    JET_DbInfoTransactions   = 0x00000007U,
    JET_DbInfoVersion        = 0x00000008U,
    JET_DbInfoIsam           = 0x00000009U,
    JET_DbInfoFilesize       = 0x0000000aU,
    JET_DbInfoSpaceOwned     = 0x0000000bU,
    JET_DbInfoSpaceAvailable = 0x0000000cU,
    JET_DbInfoUpgrade        = 0x0000000dU,
    JET_DbInfoMisc           = 0x0000000eU,
    JET_DbInfoDBInUse        = 0x0000000fU,
    JET_DbInfoPageSize       = 0x00000011U,
    JET_DbInfoFileType       = 0x00000013U,
    JET_DbInfoFilesizeOnDisk = 0x00000015U,
}

enum : uint
{
    JET_dbstateJustCreated    = 0x00000001U,
    JET_dbstateDirtyShutdown  = 0x00000002U,
    JET_dbstateCleanShutdown  = 0x00000003U,
    JET_dbstateBeingConverted = 0x00000004U,
    JET_dbstateForceDetach    = 0x00000005U,
}

enum : uint
{
    JET_filetypeUnknown      = 0x00000000U,
    JET_filetypeDatabase     = 0x00000001U,
    JET_filetypeLog          = 0x00000003U,
    JET_filetypeCheckpoint   = 0x00000004U,
    JET_filetypeTempDatabase = 0x00000005U,
    JET_filetypeFlushMap     = 0x00000007U,
}

enum : uint
{
    JET_coltypNil              = 0x00000000U,
    JET_coltypBit              = 0x00000001U,
    JET_coltypUnsignedByte     = 0x00000002U,
    JET_coltypShort            = 0x00000003U,
    JET_coltypLong             = 0x00000004U,
    JET_coltypCurrency         = 0x00000005U,
    JET_coltypIEEESingle       = 0x00000006U,
    JET_coltypIEEEDouble       = 0x00000007U,
    JET_coltypDateTime         = 0x00000008U,
    JET_coltypBinary           = 0x00000009U,
    JET_coltypText             = 0x0000000aU,
    JET_coltypLongBinary       = 0x0000000bU,
    JET_coltypLongText         = 0x0000000cU,
    JET_coltypMax              = 0x0000000dU,
    JET_coltypSLV              = 0x0000000dU,
    JET_coltypUnsignedLong     = 0x0000000eU,
    JET_coltypLongLong         = 0x0000000fU,
    JET_coltypGUID             = 0x00000010U,
    JET_coltypUnsignedShort    = 0x00000011U,
    JET_coltypUnsignedLongLong = 0x00000012U,
}

enum : uint
{
    JET_ColInfoGrbitNonDerivedColumnsOnly = 0x80000000U,
    JET_ColInfoGrbitMinimalInfo           = 0x40000000U,
    JET_ColInfoGrbitSortByColumnid        = 0x20000000U,
}

enum : uint
{
    JET_objtypNil   = 0x00000000U,
    JET_objtypTable = 0x00000001U,
}

enum : uint
{
    JET_bitCompactStats  = 0x00000020U,
    JET_bitCompactRepair = 0x00000040U,
}

enum : uint
{
    JET_snpRepair              = 0x00000002U,
    JET_snpCompact             = 0x00000004U,
    JET_snpRestore             = 0x00000008U,
    JET_snpBackup              = 0x00000009U,
    JET_snpUpgrade             = 0x0000000aU,
    JET_snpScrub               = 0x0000000bU,
    JET_snpUpgradeRecordFormat = 0x0000000cU,
}

enum : uint
{
    JET_sntBegin        = 0x00000005U,
    JET_sntRequirements = 0x00000007U,
}

enum : uint
{
    JET_sntProgress = 0x00000000U,
    JET_sntComplete = 0x00000006U,
    JET_sntFail     = 0x00000003U,
}

enum : uint
{
    JET_ExceptionMsgBox   = 0x00000001U,
    JET_ExceptionNone     = 0x00000002U,
    JET_ExceptionFailFast = 0x00000004U,
}

enum : uint
{
    JET_OnlineDefragDisable     = 0x00000000U,
    JET_OnlineDefragAllOBSOLETE = 0x00000001U,
    JET_OnlineDefragDatabases   = 0x00000002U,
    JET_OnlineDefragSpaceTrees  = 0x00000004U,
    JET_OnlineDefragAll         = 0x0000ffffU,
}

enum : uint
{
    JET_bitResizeDatabaseOnlyGrow   = 0x00000001U,
    JET_bitResizeDatabaseOnlyShrink = 0x00000002U,
}

enum : uint
{
    JET_bitStopServiceAll                 = 0x00000000U,
    JET_bitStopServiceBackgroundUserTasks = 0x00000002U,
    JET_bitStopServiceQuiesceCaches       = 0x00000004U,
    JET_bitStopServiceResume              = 0x80000000U,
}

enum int JET_errSuccess = 0x00000000;
enum int JET_wrnNyi = 0xffffffff;

enum : int
{
    JET_errRfsFailure  = 0xffffff9c,
    JET_errRfsNotArmed = 0xffffff9b,
}

enum : int
{
    JET_errFileClose    = 0xffffff9a,
    JET_errOutOfThreads = 0xffffff99,
}

enum : int
{
    JET_errTooManyIO   = 0xffffff97,
    JET_errTaskDropped = 0xffffff96,
}

enum int JET_errInternalError = 0xffffff95;
enum int JET_errDisabledFunctionality = 0xffffff90;
enum int JET_errUnloadableOSFunctionality = 0xffffff8f;
enum int JET_errDatabaseBufferDependenciesCorrupted = 0xffffff01;
enum uint JET_wrnRemainingVersions = 0x00000141U;
enum int JET_errPreviousVersion = 0xfffffebe;
enum int JET_errPageBoundary = 0xfffffebd;
enum int JET_errKeyBoundary = 0xfffffebc;

enum : int
{
    JET_errBadPageLink = 0xfffffeb9,
    JET_errBadBookmark = 0xfffffeb8,
}

enum int JET_errNTSystemCallFailed = 0xfffffeb2;
enum int JET_errBadParentPageLink = 0xfffffeae;

enum : int
{
    JET_errSPAvailExtCacheOutOfSync   = 0xfffffeac,
    JET_errSPAvailExtCorrupted        = 0xfffffeab,
    JET_errSPAvailExtCacheOutOfMemory = 0xfffffeaa,
}

enum int JET_errSPOwnExtCorrupted = 0xfffffea9;
enum int JET_errDbTimeCorrupted = 0xfffffea8;
enum uint JET_wrnUniqueKey = 0x00000159U;
enum int JET_errKeyTruncated = 0xfffffea6;
enum int JET_errDatabaseLeakInSpace = 0xfffffea4;
enum int JET_errBadEmptyPage = 0xfffffea1;

enum : uint
{
    wrnBTNotVisibleRejected    = 0x00000160U,
    wrnBTNotVisibleAccumulated = 0x00000161U,
}

enum int JET_errBadLineCount = 0xfffffe9e;
enum int JET_errPageTagCorrupted = 0xfffffe9b;
enum int JET_errNodeCorrupted = 0xfffffe9a;

enum : int
{
    JET_errBBTNodeCorrupted = 0xfffffe94,
    JET_errBBTBuffCorrupted = 0xfffffe93,
}

enum uint JET_wrnSeparateLongValue = 0x00000196U;

enum : int
{
    JET_errKeyTooBig                 = 0xfffffe68,
    JET_errCannotSeparateIntrinsicLV = 0xfffffe60,
}

enum int JET_errSeparatedLongValue = 0xfffffe5b;
enum int JET_errMustBeSeparateLongValue = 0xfffffe59;

enum : int
{
    JET_errInvalidPreread         = 0xfffffe58,
    JET_errInvalidLoggedOperation = 0xfffffe0c,
}

enum int JET_errLogFileCorrupt = 0xfffffe0b;
enum int JET_errNoBackupDirectory = 0xfffffe09;

enum : int
{
    JET_errBackupDirectoryNotEmpty = 0xfffffe08,
    JET_errBackupInProgress        = 0xfffffe07,
}

enum int JET_errRestoreInProgress = 0xfffffe06;
enum int JET_errMissingPreviousLogFile = 0xfffffe03;

enum : int
{
    JET_errLogWriteFail                    = 0xfffffe02,
    JET_errLogDisabledDueToRecoveryFailure = 0xfffffe01,
}

enum int JET_errCannotLogDuringRecoveryRedo = 0xfffffe00;
enum int JET_errLogGenerationMismatch = 0xfffffdff;
enum int JET_errBadLogVersion = 0xfffffdfe;
enum int JET_errInvalidLogSequence = 0xfffffdfd;

enum : int
{
    JET_errLoggingDisabled   = 0xfffffdfc,
    JET_errLogBufferTooSmall = 0xfffffdfb,
    JET_errLogSequenceEnd    = 0xfffffdf9,
}

enum : int
{
    JET_errNoBackup              = 0xfffffdf8,
    JET_errInvalidBackupSequence = 0xfffffdf7,
}

enum int JET_errBackupNotAllowedYet = 0xfffffdf5;
enum int JET_errDeleteBackupFileFail = 0xfffffdf4;
enum int JET_errMakeBackupDirectoryFail = 0xfffffdf3;
enum int JET_errInvalidBackup = 0xfffffdf2;
enum int JET_errRecoveredWithErrors = 0xfffffdf1;
enum int JET_errMissingLogFile = 0xfffffdf0;
enum int JET_errLogDiskFull = 0xfffffdef;

enum : int
{
    JET_errBadLogSignature        = 0xfffffdee,
    JET_errBadDbSignature         = 0xfffffded,
    JET_errBadCheckpointSignature = 0xfffffdec,
}

enum int JET_errCheckpointCorrupt = 0xfffffdeb;
enum int JET_errMissingPatchPage = 0xfffffdea;
enum int JET_errBadPatchPage = 0xfffffde9;
enum int JET_errRedoAbruptEnded = 0xfffffde8;
enum int JET_errPatchFileMissing = 0xfffffde6;

enum : int
{
    JET_errDatabaseLogSetMismatch        = 0xfffffde5,
    JET_errDatabaseStreamingFileMismatch = 0xfffffde4,
}

enum int JET_errLogFileSizeMismatch = 0xfffffde3;
enum int JET_errCheckpointFileNotFound = 0xfffffde2;
enum int JET_errRequiredLogFilesMissing = 0xfffffde1;
enum int JET_errSoftRecoveryOnBackupDatabase = 0xfffffde0;
enum int JET_errLogFileSizeMismatchDatabasesConsistent = 0xfffffddf;

enum : int
{
    JET_errLogSectorSizeMismatch                    = 0xfffffdde,
    JET_errLogSectorSizeMismatchDatabasesConsistent = 0xfffffddd,
}

enum int JET_errLogSequenceEndDatabasesConsistent = 0xfffffddc;
enum int JET_errStreamingDataNotLogged = 0xfffffddb;

enum : int
{
    JET_errDatabaseDirtyShutdown = 0xfffffdda,
    JET_errDatabaseInconsistent  = 0xfffffdda,
}

enum int JET_errConsistentTimeMismatch = 0xfffffdd9;
enum int JET_errDatabasePatchFileMismatch = 0xfffffdd8;
enum int JET_errEndingRestoreLogTooLow = 0xfffffdd7;
enum int JET_errStartingRestoreLogTooHigh = 0xfffffdd6;

enum : int
{
    JET_errGivenLogFileHasBadSignature = 0xfffffdd5,
    JET_errGivenLogFileIsNotContiguous = 0xfffffdd4,
}

enum int JET_errMissingRestoreLogFiles = 0xfffffdd3;

enum : uint
{
    JET_wrnExistingLogFileHasBadSignature = 0x0000022eU,
    JET_wrnExistingLogFileIsNotContiguous = 0x0000022fU,
}

enum int JET_errMissingFullBackup = 0xfffffdd0;
enum int JET_errBadBackupDatabaseSize = 0xfffffdcf;

enum : int
{
    JET_errDatabaseAlreadyUpgraded   = 0xfffffdce,
    JET_errDatabaseIncompleteUpgrade = 0xfffffdcd,
}

enum uint JET_wrnSkipThisRecord = 0x00000234U;
enum int JET_errMissingCurrentLogFiles = 0xfffffdcb;

enum : int
{
    JET_errDbTimeTooOld = 0xfffffdca,
    JET_errDbTimeTooNew = 0xfffffdc9,
}

enum int JET_errMissingFileToBackup = 0xfffffdc7;

enum : int
{
    JET_errLogTornWriteDuringHardRestore  = 0xfffffdc6,
    JET_errLogTornWriteDuringHardRecovery = 0xfffffdc5,
}

enum : int
{
    JET_errLogCorruptDuringHardRestore  = 0xfffffdc3,
    JET_errLogCorruptDuringHardRecovery = 0xfffffdc2,
}

enum int JET_errMustDisableLoggingForDbUpgrade = 0xfffffdc1;
enum int JET_errBadRestoreTargetInstance = 0xfffffdbf;
enum uint JET_wrnTargetInstanceRunning = 0x00000242U;
enum int JET_errRecoveredWithoutUndo = 0xfffffdbd;
enum int JET_errDatabasesNotFromSameSnapshot = 0xfffffdbc;
enum int JET_errSoftRecoveryOnSnapshot = 0xfffffdbb;
enum int JET_errCommittedLogFilesMissing = 0xfffffdba;
enum int JET_errSectorSizeNotSupported = 0xfffffdb9;
enum int JET_errRecoveredWithoutUndoDatabasesConsistent = 0xfffffdb8;
enum uint JET_wrnCommittedLogFilesLost = 0x00000249U;
enum int JET_errCommittedLogFileCorrupt = 0xfffffdb6;
enum uint JET_wrnCommittedLogFilesRemoved = 0x0000024bU;
enum uint JET_wrnFinishWithUndo = 0x0000024cU;
enum int JET_errLogSequenceChecksumMismatch = 0xfffffdb2;
enum uint JET_wrnDatabaseRepaired = 0x00000253U;
enum int JET_errPageInitializedMismatch = 0xfffffdac;

enum : int
{
    JET_errUnicodeTranslationBufferTooSmall = 0xfffffda7,
    JET_errUnicodeTranslationFail           = 0xfffffda6,
    JET_errUnicodeNormalizationNotSupported = 0xfffffda5,
}

enum int JET_errUnicodeLanguageValidationFailure = 0xfffffda4;

enum : int
{
    JET_errExistingLogFileHasBadSignature = 0xfffffd9e,
    JET_errExistingLogFileIsNotContiguous = 0xfffffd9d,
}

enum int JET_errLogReadVerifyFailure = 0xfffffd9c;
enum int JET_errCheckpointDepthTooDeep = 0xfffffd9a;
enum int JET_errRestoreOfNonBackupDatabase = 0xfffffd99;
enum int JET_errLogFileNotCopied = 0xfffffd98;
enum int JET_errTransactionTooLong = 0xfffffd96;

enum : int
{
    JET_errEngineFormatVersionNoLongerSupportedTooLow           = 0xfffffd95,
    JET_errEngineFormatVersionNotYetImplementedTooHigh          = 0xfffffd94,
    JET_errEngineFormatVersionParamTooLowForRequestedFeature    = 0xfffffd93,
    JET_errEngineFormatVersionSpecifiedTooLowForLogVersion      = 0xfffffd92,
    JET_errEngineFormatVersionSpecifiedTooLowForDatabaseVersion = 0xfffffd91,
}

enum int JET_errDbTimeBeyondMaxRequired = 0xfffffd8f;
enum int JET_errLogOperationInconsistentWithDatabase = 0xfffffd8e;
enum int JET_errInsertKeyOutOfOrder = 0xfffffd8d;
enum int JET_errBackupAbortByServer = 0xfffffcdf;
enum int JET_errInvalidGrbit = 0xfffffc7c;
enum int JET_errTermInProgress = 0xfffffc18;
enum int JET_errFeatureNotAvailable = 0xfffffc17;

enum : int
{
    JET_errInvalidName      = 0xfffffc16,
    JET_errInvalidParameter = 0xfffffc15,
}

enum : uint
{
    JET_wrnColumnNull      = 0x000003ecU,
    JET_wrnBufferTruncated = 0x000003eeU,
}

enum uint JET_wrnDatabaseAttached = 0x000003efU;
enum int JET_errDatabaseFileReadOnly = 0xfffffc10;
enum uint JET_wrnSortOverflow = 0x000003f1U;
enum int JET_errInvalidDatabaseId = 0xfffffc0e;

enum : int
{
    JET_errOutOfMemory        = 0xfffffc0d,
    JET_errOutOfDatabaseSpace = 0xfffffc0c,
    JET_errOutOfCursors       = 0xfffffc0b,
    JET_errOutOfBuffers       = 0xfffffc0a,
}

enum : int
{
    JET_errTooManyIndexes = 0xfffffc09,
    JET_errTooManyKeys    = 0xfffffc08,
}

enum : int
{
    JET_errRecordDeleted     = 0xfffffc07,
    JET_errReadVerifyFailure = 0xfffffc06,
}

enum int JET_errPageNotInitialized = 0xfffffc05;
enum int JET_errOutOfFileHandles = 0xfffffc04;
enum int JET_errDiskReadVerificationFailure = 0xfffffc03;

enum : int
{
    JET_errDiskIO              = 0xfffffc02,
    JET_errInvalidPath         = 0xfffffc01,
    JET_errInvalidSystemPath   = 0xfffffc00,
    JET_errInvalidLogDirectory = 0xfffffbff,
}

enum int JET_errRecordTooBig = 0xfffffbfe;
enum int JET_errTooManyOpenDatabases = 0xfffffbfd;
enum int JET_errInvalidDatabase = 0xfffffbfc;
enum int JET_errNotInitialized = 0xfffffbfb;
enum int JET_errAlreadyInitialized = 0xfffffbfa;
enum int JET_errInitInProgress = 0xfffffbf9;
enum int JET_errFileAccessDenied = 0xfffffbf8;
enum int JET_errBufferTooSmall = 0xfffffbf2;
enum uint JET_wrnSeekNotEqual = 0x0000040fU;
enum int JET_errTooManyColumns = 0xfffffbf0;
enum int JET_errContainerNotEmpty = 0xfffffbed;

enum : int
{
    JET_errInvalidFilename = 0xfffffbec,
    JET_errInvalidBookmark = 0xfffffbeb,
}

enum int JET_errColumnInUse = 0xfffffbea;
enum int JET_errInvalidBufferSize = 0xfffffbe9;
enum int JET_errColumnNotUpdatable = 0xfffffbe8;

enum : int
{
    JET_errIndexInUse       = 0xfffffbe5,
    JET_errLinkNotSupported = 0xfffffbe4,
}

enum int JET_errNullKeyDisallowed = 0xfffffbe3;
enum int JET_errNotInTransaction = 0xfffffbe2;
enum uint JET_wrnNoErrorInfo = 0x0000041fU;
enum int JET_errMustRollback = 0xfffffbdf;
enum uint JET_wrnNoIdleActivity = 0x00000422U;
enum int JET_errTooManyActiveUsers = 0xfffffbdd;

enum : int
{
    JET_errInvalidCountry          = 0xfffffbdb,
    JET_errInvalidLanguageId       = 0xfffffbda,
    JET_errInvalidCodePage         = 0xfffffbd9,
    JET_errInvalidLCMapStringFlags = 0xfffffbd8,
}

enum : int
{
    JET_errVersionStoreEntryTooBig                   = 0xfffffbd7,
    JET_errVersionStoreOutOfMemoryAndCleanupTimedOut = 0xfffffbd6,
}

enum uint JET_wrnNoWriteLock = 0x0000042bU;
enum uint JET_wrnColumnSetNull = 0x0000042cU;
enum int JET_errVersionStoreOutOfMemory = 0xfffffbd3;
enum int JET_errCannotIndex = 0xfffffbd1;
enum int JET_errRecordNotDeleted = 0xfffffbd0;
enum int JET_errTooManyMempoolEntries = 0xfffffbcf;

enum : int
{
    JET_errOutOfObjectIDs           = 0xfffffbce,
    JET_errOutOfLongValueIDs        = 0xfffffbcd,
    JET_errOutOfAutoincrementValues = 0xfffffbcc,
}

enum : int
{
    JET_errOutOfDbtimeValues          = 0xfffffbcb,
    JET_errOutOfSequentialIndexValues = 0xfffffbca,
}

enum : int
{
    JET_errRunningInOneInstanceMode   = 0xfffffbc8,
    JET_errRunningInMultiInstanceMode = 0xfffffbc7,
}

enum : int
{
    JET_errSystemParamsAlreadySet = 0xfffffbc6,
    JET_errSystemPathInUse        = 0xfffffbc5,
}

enum int JET_errLogFilePathInUse = 0xfffffbc4;
enum int JET_errTempPathInUse = 0xfffffbc3;
enum int JET_errInstanceNameInUse = 0xfffffbc2;
enum int JET_errSystemParameterConflict = 0xfffffbc1;
enum int JET_errInstanceUnavailable = 0xfffffbbe;
enum int JET_errDatabaseUnavailable = 0xfffffbbd;
enum int JET_errInstanceUnavailableDueToFatalLogDiskFull = 0xfffffbbc;
enum int JET_errInvalidSesparamId = 0xfffffbbb;
enum int JET_errTooManyRecords = 0xfffffbba;
enum int JET_errInvalidDbparamId = 0xfffffbb9;
enum int JET_errOutOfSessions = 0xfffffbb3;
enum int JET_errWriteConflict = 0xfffffbb2;
enum int JET_errTransTooDeep = 0xfffffbb1;
enum int JET_errInvalidSesid = 0xfffffbb0;
enum int JET_errWriteConflictPrimaryIndex = 0xfffffbaf;
enum int JET_errInTransaction = 0xfffffbac;
enum int JET_errRollbackRequired = 0xfffffbab;
enum int JET_errTransReadOnly = 0xfffffbaa;
enum int JET_errSessionWriteConflict = 0xfffffba9;
enum int JET_errRecordTooBigForBackwardCompatibility = 0xfffffba8;
enum int JET_errCannotMaterializeForwardOnlySort = 0xfffffba7;
enum int JET_errSesidTableIdMismatch = 0xfffffba6;
enum int JET_errInvalidInstance = 0xfffffba5;
enum int JET_errDirtyShutdown = 0xfffffba4;
enum int JET_errReadPgnoVerifyFailure = 0xfffffba2;
enum int JET_errReadLostFlushVerifyFailure = 0xfffffba1;
enum int JET_errFileSystemCorruption = 0xfffffb9f;
enum uint JET_wrnShrinkNotPossible = 0x00000462U;
enum int JET_errRecoveryVerifyFailure = 0xfffffb9d;
enum int JET_errFilteredMoveNotSupported = 0xfffffb9c;

enum : int
{
    JET_errDatabaseDuplicate    = 0xfffffb4f,
    JET_errDatabaseInUse        = 0xfffffb4e,
    JET_errDatabaseNotFound     = 0xfffffb4d,
    JET_errDatabaseInvalidName  = 0xfffffb4c,
    JET_errDatabaseInvalidPages = 0xfffffb4b,
    JET_errDatabaseCorrupted    = 0xfffffb4a,
    JET_errDatabaseLocked       = 0xfffffb49,
}

enum int JET_errCannotDisableVersioning = 0xfffffb48;
enum int JET_errInvalidDatabaseVersion = 0xfffffb47;

enum : int
{
    JET_errDatabase200Format = 0xfffffb46,
    JET_errDatabase400Format = 0xfffffb45,
    JET_errDatabase500Format = 0xfffffb44,
}

enum int JET_errPageSizeMismatch = 0xfffffb43;
enum int JET_errTooManyInstances = 0xfffffb42;
enum int JET_errDatabaseSharingViolation = 0xfffffb41;
enum int JET_errAttachedDatabaseMismatch = 0xfffffb40;

enum : int
{
    JET_errDatabaseInvalidPath = 0xfffffb3f,
    JET_errDatabaseIdInUse     = 0xfffffb3e,
}

enum int JET_errForceDetachNotAllowed = 0xfffffb3d;
enum int JET_errCatalogCorrupted = 0xfffffb3c;
enum int JET_errPartiallyAttachedDB = 0xfffffb3b;

enum : int
{
    JET_errDatabaseSignInUse         = 0xfffffb3a,
    JET_errDatabaseCorruptedNoRepair = 0xfffffb38,
}

enum int JET_errInvalidCreateDbVersion = 0xfffffb37;

enum : int
{
    JET_errDatabaseNotReady            = 0xfffffb32,
    JET_errDatabaseAttachedForRecovery = 0xfffffb31,
}

enum int JET_errTransactionsNotReadyDuringRecovery = 0xfffffb30;
enum uint JET_wrnTableEmpty = 0x00000515U;

enum : int
{
    JET_errTableLocked    = 0xfffffaea,
    JET_errTableDuplicate = 0xfffffae9,
    JET_errTableInUse     = 0xfffffae8,
    JET_errObjectNotFound = 0xfffffae7,
}

enum int JET_errDensityInvalid = 0xfffffae5;
enum int JET_errTableNotEmpty = 0xfffffae4;
enum int JET_errInvalidTableId = 0xfffffae2;
enum int JET_errTooManyOpenTables = 0xfffffae1;
enum int JET_errIllegalOperation = 0xfffffae0;
enum int JET_errTooManyOpenTablesAndCleanupTimedOut = 0xfffffadf;
enum int JET_errObjectDuplicate = 0xfffffade;
enum int JET_errInvalidObject = 0xfffffadc;

enum : int
{
    JET_errCannotDeleteTempTable     = 0xfffffadb,
    JET_errCannotDeleteSystemTable   = 0xfffffada,
    JET_errCannotDeleteTemplateTable = 0xfffffad9,
}

enum int JET_errExclusiveTableLockRequired = 0xfffffad6;

enum : int
{
    JET_errFixedDDL          = 0xfffffad5,
    JET_errFixedInheritedDDL = 0xfffffad4,
}

enum int JET_errCannotNestDDL = 0xfffffad3;
enum int JET_errDDLNotInheritable = 0xfffffad2;
enum uint JET_wrnTableInUseBySystem = 0x0000052fU;
enum int JET_errInvalidSettings = 0xfffffad0;
enum int JET_errClientRequestToStopJetService = 0xfffffacf;
enum int JET_errCannotAddFixedVarColumnToDerivedTable = 0xffffface;

enum : int
{
    JET_errIndexCantBuild     = 0xfffffa87,
    JET_errIndexHasPrimary    = 0xfffffa86,
    JET_errIndexDuplicate     = 0xfffffa85,
    JET_errIndexNotFound      = 0xfffffa84,
    JET_errIndexMustStay      = 0xfffffa83,
    JET_errIndexInvalidDef    = 0xfffffa82,
    JET_errInvalidCreateIndex = 0xfffffa7f,
}

enum int JET_errTooManyOpenIndexes = 0xfffffa7e;
enum int JET_errMultiValuedIndexViolation = 0xfffffa7d;
enum int JET_errIndexBuildCorrupted = 0xfffffa7c;
enum int JET_errPrimaryIndexCorrupted = 0xfffffa7b;
enum int JET_errSecondaryIndexCorrupted = 0xfffffa7a;
enum uint JET_wrnCorruptIndexDeleted = 0x00000587U;
enum int JET_errInvalidIndexId = 0xfffffa78;
enum uint JET_wrnPrimaryIndexOutOfDate = 0x00000589U;
enum uint JET_wrnSecondaryIndexOutOfDate = 0x0000058aU;

enum : int
{
    JET_errIndexTuplesSecondaryIndexOnly      = 0xfffffa6a,
    JET_errIndexTuplesTooManyColumns          = 0xfffffa69,
    JET_errIndexTuplesOneColumnOnly           = 0xfffffa69,
    JET_errIndexTuplesNonUniqueOnly           = 0xfffffa68,
    JET_errIndexTuplesTextBinaryColumnsOnly   = 0xfffffa67,
    JET_errIndexTuplesTextColumnsOnly         = 0xfffffa67,
    JET_errIndexTuplesVarSegMacNotAllowed     = 0xfffffa66,
    JET_errIndexTuplesInvalidLimits           = 0xfffffa65,
    JET_errIndexTuplesCannotRetrieveFromIndex = 0xfffffa64,
    JET_errIndexTuplesKeyTooSmall             = 0xfffffa63,
}

enum int JET_errInvalidLVChunkSize = 0xfffffa62;
enum int JET_errColumnCannotBeEncrypted = 0xfffffa61;
enum int JET_errCannotIndexOnEncryptedColumn = 0xfffffa60;

enum : int
{
    JET_errColumnLong       = 0xfffffa23,
    JET_errColumnNoChunk    = 0xfffffa22,
    JET_errColumnDoesNotFit = 0xfffffa21,
}

enum int JET_errNullInvalid = 0xfffffa20;

enum : int
{
    JET_errColumnIndexed   = 0xfffffa1f,
    JET_errColumnTooBig    = 0xfffffa1e,
    JET_errColumnNotFound  = 0xfffffa1d,
    JET_errColumnDuplicate = 0xfffffa1c,
}

enum int JET_errMultiValuedColumnMustBeTagged = 0xfffffa1b;
enum int JET_errColumnRedundant = 0xfffffa1a;
enum int JET_errInvalidColumnType = 0xfffffa19;
enum uint JET_wrnColumnMaxTruncated = 0x000005e8U;
enum int JET_errTaggedNotNULL = 0xfffffa16;
enum int JET_errNoCurrentIndex = 0xfffffa15;

enum : int
{
    JET_errKeyIsMade       = 0xfffffa14,
    JET_errBadColumnId     = 0xfffffa13,
    JET_errBadItagSequence = 0xfffffa12,
}

enum int JET_errColumnInRelationship = 0xfffffa11;
enum uint JET_wrnCopyLongValue = 0x000005f0U;
enum int JET_errCannotBeTagged = 0xfffffa0f;
enum int JET_errDefaultValueTooBig = 0xfffffa0c;
enum int JET_errMultiValuedDuplicate = 0xfffffa0b;
enum int JET_errLVCorrupted = 0xfffffa0a;
enum int JET_errMultiValuedDuplicateAfterTruncation = 0xfffffa08;
enum int JET_errDerivedColumnCorruption = 0xfffffa07;
enum int JET_errInvalidPlaceholderColumn = 0xfffffa06;

enum : uint
{
    JET_wrnColumnSkipped     = 0x000005fbU,
    JET_wrnColumnNotLocal    = 0x000005fcU,
    JET_wrnColumnMoreTags    = 0x000005fdU,
    JET_wrnColumnTruncated   = 0x000005feU,
    JET_wrnColumnPresent     = 0x000005ffU,
    JET_wrnColumnSingleValue = 0x00000600U,
    JET_wrnColumnDefault     = 0x00000601U,
}

enum int JET_errColumnCannotBeCompressed = 0xfffff9fe;
enum uint JET_wrnColumnNotInRecord = 0x00000603U;
enum int JET_errColumnNoEncryptionKey = 0xfffff9fc;
enum uint JET_wrnColumnReference = 0x00000605U;

enum : int
{
    JET_errRecordNotFound = 0xfffff9bf,
    JET_errRecordNoCopy   = 0xfffff9be,
}

enum int JET_errNoCurrentRecord = 0xfffff9bd;
enum int JET_errRecordPrimaryChanged = 0xfffff9bc;
enum int JET_errKeyDuplicate = 0xfffff9bb;
enum int JET_errAlreadyPrepared = 0xfffff9b9;

enum : int
{
    JET_errKeyNotMade        = 0xfffff9b8,
    JET_errUpdateNotPrepared = 0xfffff9b7,
}

enum uint JET_wrnDataHasChanged = 0x0000064aU;
enum int JET_errDataHasChanged = 0xfffff9b5;
enum uint JET_wrnKeyChanged = 0x00000652U;
enum int JET_errLanguageNotSupported = 0xfffff9ad;
enum int JET_errDecompressionFailed = 0xfffff9ac;
enum int JET_errUpdateMustVersion = 0xfffff9ab;
enum int JET_errDecryptionFailed = 0xfffff9aa;
enum int JET_errEncryptionBadItag = 0xfffff9a9;
enum int JET_errSetAutoIncrementTooHigh = 0xfffff9a8;
enum int JET_errAutoIncrementNotSet = 0xfffff9a7;
enum int JET_errTooManySorts = 0xfffff95b;
enum int JET_errInvalidOnSort = 0xfffff95a;
enum int JET_errTempFileOpenError = 0xfffff8f5;
enum int JET_errTooManyAttachedDatabases = 0xfffff8f3;

enum : int
{
    JET_errDiskFull         = 0xfffff8f0,
    JET_errPermissionDenied = 0xfffff8ef,
}

enum : int
{
    JET_errFileNotFound    = 0xfffff8ed,
    JET_errFileInvalidType = 0xfffff8ec,
}

enum uint JET_wrnFileOpenReadOnly = 0x00000715U;
enum int JET_errFileAlreadyExists = 0xfffff8ea;
enum int JET_errAfterInitialization = 0xfffff8c6;
enum int JET_errLogCorrupted = 0xfffff8c4;
enum int JET_errInvalidOperation = 0xfffff88e;
enum int JET_errAccessDenied = 0xfffff88d;
enum uint JET_wrnIdleFull = 0x00000774U;
enum int JET_errTooManySplits = 0xfffff88b;
enum int JET_errSessionSharingViolation = 0xfffff88a;
enum int JET_errEntryPointNotFound = 0xfffff889;

enum : int
{
    JET_errSessionContextAlreadySet         = 0xfffff888,
    JET_errSessionContextNotSetByThisThread = 0xfffff887,
}

enum int JET_errSessionInUse = 0xfffff886;
enum int JET_errRecordFormatConversionFailed = 0xfffff885;
enum int JET_errOneDatabasePerSession = 0xfffff884;
enum int JET_errRollbackError = 0xfffff883;

enum : int
{
    JET_errFlushMapVersionUnsupported = 0xfffff882,
    JET_errFlushMapDatabaseMismatch   = 0xfffff881,
    JET_errFlushMapUnrecoverable      = 0xfffff880,
}

enum : uint
{
    JET_wrnDefragAlreadyRunning = 0x000007d0U,
    JET_wrnDefragNotRunning     = 0x000007d1U,
}

enum int JET_errDatabaseAlreadyRunningMaintenance = 0xfffff82c;
enum uint JET_wrnCallbackNotRegistered = 0x00000834U;

enum : int
{
    JET_errCallbackFailed      = 0xfffff7cb,
    JET_errCallbackNotResolved = 0xfffff7ca,
}

enum int JET_errSpaceHintsInvalid = 0xfffff7c9;

enum : int
{
    JET_errOSSnapshotInvalidSequence = 0xfffff69f,
    JET_errOSSnapshotTimeOut         = 0xfffff69e,
    JET_errOSSnapshotNotAllowed      = 0xfffff69d,
    JET_errOSSnapshotInvalidSnapId   = 0xfffff69c,
}

enum int JET_errLSCallbackNotSpecified = 0xfffff448;

enum : int
{
    JET_errLSAlreadySet    = 0xfffff447,
    JET_errLSNotSet        = 0xfffff446,
    JET_errFileIOSparse    = 0xfffff060,
    JET_errFileIOBeyondEOF = 0xfffff05f,
    JET_errFileIOAbort     = 0xfffff05e,
    JET_errFileIORetry     = 0xfffff05d,
    JET_errFileIOFail      = 0xfffff05c,
    JET_errFileCompressed  = 0xfffff05b,
}

enum : int
{
    JET_errClientSpaceBegin = 0xffffd8f0,
    JET_errClientSpaceEnd   = 0xffffd121,
}

enum uint JET_BASE_NAME_LENGTH = 0x00000003U;

enum : uint
{
    JET_bitDumpMinimum                    = 0x00000001U,
    JET_bitDumpMaximum                    = 0x00000002U,
    JET_bitDumpCacheMinimum               = 0x00000004U,
    JET_bitDumpCacheMaximum               = 0x00000008U,
    JET_bitDumpCacheIncludeDirtyPages     = 0x00000010U,
    JET_bitDumpCacheIncludeCachedPages    = 0x00000020U,
    JET_bitDumpCacheIncludeCorruptedPages = 0x00000040U,
    JET_bitDumpCacheNoDecommit            = 0x00000080U,
}

// Callbacks

alias JET_PFNSTATUS = int function(JET_SESID sesid, uint snp, uint snt, void* pv);
alias JET_CALLBACK = int function(JET_SESID sesid, uint dbid, JET_TABLEID tableid, uint cbtyp, void* pvArg1, 
                                  void* pvArg2, void* pvContext, JET_API_PTR ulUnused);
alias JET_PFNDURABLECOMMITCALLBACK = int function(JET_INSTANCE instance, JET_COMMIT_ID* pCommitIdSeen, uint grbit);
alias JET_PFNREALLOC = void* function(void* pvContext, void* pv, uint cb);

// Structs


@RAIIFree!JetTerm
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-instance
struct JET_INSTANCE
{
    size_t Value;
}

@RAIIFree!JetEndSession
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-sesid-structure
struct JET_SESID
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ossnapid
struct JET_OSSNAPID
{
    size_t Value;
}

//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ls
struct JET_LS
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-ls.value-property
    size_t Value;
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexid-structure
    struct JET_INDEXID
    {
        uint      cbStruct;
        ubyte[16] rgbIndexId;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexid-structure
    struct JET_INDEXID
    {
        uint      cbStruct;
        ubyte[16] rgbIndexId;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo-constructor
    struct JET_OBJECTINFO
    {
        uint   cbStruct;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.objtyp-property
        uint   objtyp;
        double dtCreate;
        double dtUpdate;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.grbit-property
        uint   grbit;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.flags-property
        uint   flags;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.crecord-property
        uint   cRecord;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.cpage-property
        uint   cPage;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo-constructor
    struct JET_OBJECTINFO
    {
        uint   cbStruct;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.objtyp-property
        uint   objtyp;
        double dtCreate;
        double dtUpdate;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.grbit-property
        uint   grbit;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.flags-property
        uint   flags;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.crecord-property
        uint   cRecord;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.cpage-property
        uint   cPage;
    }
}

version(X86_64)
{
    struct JET_RECPOS2
    {
        uint  cbStruct;
        uint  centriesLTDeprecated;
        uint  centriesInRangeDeprecated;
        uint  centriesTotalDeprecated;
        ulong centriesLT;
        ulong centriesTotal;
    }
}

version(AArch64)
{
    struct JET_RECPOS2
    {
        uint  cbStruct;
        uint  centriesLTDeprecated;
        uint  centriesInRangeDeprecated;
        uint  centriesTotalDeprecated;
        ulong centriesLT;
        ulong centriesTotal;
    }
}

version(X86_64)
{
    struct JET_THREADSTATS2
    {
        uint  cbStruct;
        uint  cPageReferenced;
        uint  cPageRead;
        uint  cPagePreread;
        uint  cPageDirtied;
        uint  cPageRedirtied;
        uint  cLogRecord;
        uint  cbLogRecord;
        ulong cusecPageCacheMiss;
        uint  cPageCacheMiss;
    }
}

version(AArch64)
{
    struct JET_THREADSTATS2
    {
        uint  cbStruct;
        uint  cPageReferenced;
        uint  cPageRead;
        uint  cPagePreread;
        uint  cPageDirtied;
        uint  cPageRedirtied;
        uint  cLogRecord;
        uint  cbLogRecord;
        ulong cusecPageCacheMiss;
        uint  cPageCacheMiss;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-commit-id-class
    struct JET_COMMIT_ID
    {
        JET_SIGNATURE signLog;
        int           reserved;
        long          commitId;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-commit-id-class
    struct JET_COMMIT_ID
    {
        JET_SIGNATURE signLog;
        int           reserved;
        long          commitId;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize-structure2
    struct JET_RECSIZE
    {
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cbdata-property
        ulong cbData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvaluedata-property
        ulong cbLongValueData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cboverhead-property
        ulong cbOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvalueoverhead-property
        ulong cbLongValueOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cnontaggedcolumns-property
        ulong cNonTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.ctaggedcolumns-property
        ulong cTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.clongvalues-property
        ulong cLongValues;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cmultivalues-property
        ulong cMultiValues;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize-structure2
    struct JET_RECSIZE
    {
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cbdata-property
        ulong cbData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvaluedata-property
        ulong cbLongValueData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cboverhead-property
        ulong cbOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvalueoverhead-property
        ulong cbLongValueOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cnontaggedcolumns-property
        ulong cNonTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.ctaggedcolumns-property
        ulong cTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.clongvalues-property
        ulong cLongValues;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cmultivalues-property
        ulong cMultiValues;
    }
}

version(X86_64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize2-structure
    struct JET_RECSIZE2
    {
        ulong cbData;
        ulong cbLongValueData;
        ulong cbOverhead;
        ulong cbLongValueOverhead;
        ulong cNonTaggedColumns;
        ulong cTaggedColumns;
        ulong cLongValues;
        ulong cMultiValues;
        ulong cCompressedColumns;
        ulong cbDataCompressed;
        ulong cbLongValueDataCompressed;
    }
}

version(AArch64)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize2-structure
    struct JET_RECSIZE2
    {
        ulong cbData;
        ulong cbLongValueData;
        ulong cbOverhead;
        ulong cbLongValueOverhead;
        ulong cNonTaggedColumns;
        ulong cTaggedColumns;
        ulong cLongValues;
        ulong cMultiValues;
        ulong cCompressedColumns;
        ulong cbDataCompressed;
        ulong cbLongValueDataCompressed;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexid-structure
    struct JET_INDEXID
    {
        uint      cbStruct;
        ubyte[12] rgbIndexId;
    }
}

struct JET_RSTMAP_A
{
    byte* szDatabaseName;
    byte* szNewDatabaseName;
}

struct JET_RSTMAP_W
{
    ushort* szDatabaseName;
    ushort* szNewDatabaseName;
}

struct JET_CONVERT_A
{
    byte* szOldDll;
    union
    {
        uint fFlags;
        struct
        {
            // Native bit field: fSchemaChangesOnly: [0]
            uint _bitfield0;
        }
    }
}

struct JET_CONVERT_W
{
    ushort* szOldDll;
    union
    {
        uint fFlags;
        struct
        {
            // Native bit field: fSchemaChangesOnly: [0]
            uint _bitfield0;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog-class
struct JET_SNPROG
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog.cunitdone-property
    uint cunitDone;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-snprog.cunittotal-property
    uint cunitTotal;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfoupgrade-structure
struct JET_DBINFOUPGRADE
{
    uint cbStruct;
    uint cbFilesizeLow;
    uint cbFilesizeHigh;
    uint cbFreeSpaceRequiredLow;
    uint cbFreeSpaceRequiredHigh;
    uint csecToUpgrade;
    union
    {
        uint ulFlags;
        struct
        {
            // Native bit field: fUpgradable: [0], fAlreadyUpgraded: [1]
            uint _bitfield0;
        }
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo-constructor
    struct JET_OBJECTINFO
    {
    align (4):
        uint   cbStruct;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.objtyp-property
        uint   objtyp;
        double dtCreate;
        double dtUpdate;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.grbit-property
        uint   grbit;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.flags-property
        uint   flags;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.crecord-property
        uint   cRecord;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectinfo.cpage-property
        uint   cPage;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist-class
struct JET_OBJECTLIST
{
    uint        cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.tableid-property
    JET_TABLEID tableid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.crecord-property
    uint        cRecord;
    uint        columnidcontainername;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidobjectname-property
    uint        columnidobjectname;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidobjtyp-property
    uint        columnidobjtyp;
    uint        columniddtCreate;
    uint        columniddtUpdate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidgrbit-property
    uint        columnidgrbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidflags-property
    uint        columnidflags;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidcrecord-property
    uint        columnidcRecord;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-objectlist.columnidcpage-property
    uint        columnidcPage;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist-structure
struct JET_COLUMNLIST
{
    uint        cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.tableid-property
    JET_TABLEID tableid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.crecord-property
    uint        cRecord;
    uint        columnidPresentationOrder;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcolumnname-property
    uint        columnidcolumnname;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcolumnid-property
    uint        columnidcolumnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcoltyp-property
    uint        columnidcoltyp;
    uint        columnidCountry;
    uint        columnidLangid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcp-property
    uint        columnidCp;
    uint        columnidCollate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidcbmax-property
    uint        columnidcbMax;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columnidgrbit-property
    uint        columnidgrbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columnlist.columniddefault-property
    uint        columnidDefault;
    uint        columnidBaseTableName;
    uint        columnidBaseColumnName;
    uint        columnidDefinitionName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef-constructor
struct JET_COLUMNDEF
{
    uint   cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.columnid-property
    uint   columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.coltyp-property
    uint   coltyp;
    ushort wCountry;
    ushort langid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.cp-property
    ushort cp;
    ushort wCollate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.cbmax-property
    uint   cbMax;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-columndef.grbit-property
    uint   grbit;
}

struct JET_COLUMNBASE_A
{
    uint      cbStruct;
    uint      columnid;
    uint      coltyp;
    ushort    wCountry;
    ushort    langid;
    ushort    cp;
    ushort    wFiller;
    uint      cbMax;
    uint      grbit;
    byte[256] szBaseTableName;
    byte[256] szBaseColumnName;
}

struct JET_COLUMNBASE_W
{
    uint        cbStruct;
    uint        columnid;
    uint        coltyp;
    ushort      wCountry;
    ushort      langid;
    ushort      cp;
    ushort      wFiller;
    uint        cbMax;
    uint        grbit;
    ushort[256] szBaseTableName;
    ushort[256] szBaseColumnName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist-structure
struct JET_INDEXLIST
{
    uint        cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.tableid-property
    JET_TABLEID tableid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.crecord-property
    uint        cRecord;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidindexname-property
    uint        columnidindexname;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidgrbitindex-property
    uint        columnidgrbitIndex;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidckey-property
    uint        columnidcKey;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcentry-property
    uint        columnidcEntry;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcpage-property
    uint        columnidcPage;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidccolumn-property
    uint        columnidcColumn;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidicolumn-property
    uint        columnidiColumn;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcolumnid-property
    uint        columnidcolumnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcoltyp-property
    uint        columnidcoltyp;
    uint        columnidCountry;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidlangid-property
    uint        columnidLangid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcp-property
    uint        columnidCp;
    uint        columnidCollate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidgrbitcolumn-property
    uint        columnidgrbitColumn;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidcolumnname-property
    uint        columnidcolumnname;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexlist.columnidlcmapflags-property
    uint        columnidLCMapFlags;
}

struct JET_COLUMNCREATE_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  coltyp;
    uint  cbMax;
    uint  grbit;
    void* pvDefault;
    uint  cbDefault;
    uint  cp;
    uint  columnid;
    int   err;
}

struct JET_COLUMNCREATE_W
{
    uint    cbStruct;
    ushort* szColumnName;
    uint    coltyp;
    uint    cbMax;
    uint    grbit;
    void*   pvDefault;
    uint    cbDefault;
    uint    cp;
    uint    columnid;
    int     err;
}

struct JET_USERDEFINEDDEFAULT_A
{
    byte*  szCallback;
    ubyte* pbUserData;
    uint   cbUserData;
    byte*  szDependantColumns;
}

struct JET_USERDEFINEDDEFAULT_W
{
    ushort* szCallback;
    ubyte*  pbUserData;
    uint    cbUserData;
    ushort* szDependantColumns;
}

struct JET_CONDITIONALCOLUMN_A
{
    uint  cbStruct;
    byte* szColumnName;
    uint  grbit;
}

struct JET_CONDITIONALCOLUMN_W
{
    uint    cbStruct;
    ushort* szColumnName;
    uint    grbit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex-structure
struct JET_UNICODEINDEX
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex.lcid-property
    uint lcid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-unicodeindex.dwmapflags-property
    uint dwMapFlags;
}

struct JET_UNICODEINDEX2
{
    ushort* szLocaleName;
    uint    dwMapFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-tuplelimits-structure
struct JET_TUPLELIMITS
{
    uint chLengthMin;
    uint chLengthMax;
    uint chToIndexMax;
    uint cchIncrement;
    uint ichStart;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints-class
struct JET_SPACEHINTS
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulinitialdensity-property
    uint ulInitialDensity;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbinitial-property
    uint cbInitial;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.grbit-property
    uint grbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulmaintdensity-property
    uint ulMaintDensity;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.ulgrowth-property
    uint ulGrowth;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbminextent-property
    uint cbMinExtent;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-spacehints.cbmaxextent-property
    uint cbMaxExtent;
}

struct JET_INDEXCREATE_A
{
    uint  cbStruct;
    byte* szIndexName;
    byte* szKey;
    uint  cbKey;
    uint  grbit;
    uint  ulDensity;
    union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint  cConditionalColumn;
    int   err;
    uint  cbKeyMost;
}

struct JET_INDEXCREATE_W
{
    uint    cbStruct;
    ushort* szIndexName;
    ushort* szKey;
    uint    cbKey;
    uint    grbit;
    uint    ulDensity;
    union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint    cConditionalColumn;
    int     err;
    uint    cbKeyMost;
}

struct JET_INDEXCREATE2_A
{
    uint            cbStruct;
    byte*           szIndexName;
    byte*           szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
    union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE2_W
{
    uint            cbStruct;
    ushort*         szIndexName;
    ushort*         szKey;
    uint            cbKey;
    uint            grbit;
    uint            ulDensity;
    union
    {
        uint              lcid;
        JET_UNICODEINDEX* pidxunicode;
    }
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint            cConditionalColumn;
    int             err;
    uint            cbKeyMost;
    JET_SPACEHINTS* pSpacehints;
}

struct JET_INDEXCREATE3_A
{
    uint               cbStruct;
    byte*              szIndexName;
    byte*              szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_A* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

struct JET_INDEXCREATE3_W
{
    uint               cbStruct;
    ushort*            szIndexName;
    ushort*            szKey;
    uint               cbKey;
    uint               grbit;
    uint               ulDensity;
    JET_UNICODEINDEX2* pidxunicode;
    union
    {
        uint             cbVarSegMac;
        JET_TUPLELIMITS* ptuplelimits;
    }
    JET_CONDITIONALCOLUMN_W* rgconditionalcolumn;
    uint               cConditionalColumn;
    int                err;
    uint               cbKeyMost;
    JET_SPACEHINTS*    pSpacehints;
}

struct JET_TABLECREATE_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_A*  rgindexcreate;
    uint                cIndexes;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_W*  rgindexcreate;
    uint                cIndexes;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE2_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_A*  rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE2_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE_W*  rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE3_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE3_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE2_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE4_A
{
    uint                cbStruct;
    byte*               szTableName;
    byte*               szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_A* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_A* rgindexcreate;
    uint                cIndexes;
    byte*               szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

struct JET_TABLECREATE4_W
{
    uint                cbStruct;
    ushort*             szTableName;
    ushort*             szTemplateTableName;
    uint                ulPages;
    uint                ulDensity;
    JET_COLUMNCREATE_W* rgcolumncreate;
    uint                cColumns;
    JET_INDEXCREATE3_W* rgindexcreate;
    uint                cIndexes;
    ushort*             szCallback;
    uint                cbtyp;
    uint                grbit;
    JET_SPACEHINTS*     pSeqSpacehints;
    JET_SPACEHINTS*     pLVSpacehints;
    uint                cbSeparateLV;
    JET_TABLEID         tableid;
    uint                cCreated;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable-structure
struct JET_OPENTEMPORARYTABLE
{
    uint              cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.prgcolumndef-property
    const(JET_COLUMNDEF)* prgcolumndef;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.ccolumn-property
    uint              ccolumn;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.pidxunicode-property
    JET_UNICODEINDEX* pidxunicode;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.grbit-property
    uint              grbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.prgcolumnid-property
    uint*             prgcolumnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.cbkeymost-property
    uint              cbKeyMost;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.cbvarsegmac-property
    uint              cbVarSegMac;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-opentemporarytable.tableid-property
    JET_TABLEID       tableid;
}

struct JET_OPENTEMPORARYTABLE2
{
    uint               cbStruct;
    const(JET_COLUMNDEF)* prgcolumndef;
    uint               ccolumn;
    JET_UNICODEINDEX2* pidxunicode;
    uint               grbit;
    uint*              prgcolumnid;
    uint               cbKeyMost;
    uint               cbVarSegMac;
    JET_TABLEID        tableid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo-structure
struct JET_RETINFO
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.iblongvalue-property
    uint ibLongValue;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.itagsequence-property
    uint itagSequence;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retinfo.columnidnexttagged-property
    uint columnidNextTagged;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo-class
struct JET_SETINFO
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo.iblongvalue-property
    uint ibLongValue;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setinfo.itagsequence-property
    uint itagSequence;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos-constructor
struct JET_RECPOS
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos.centrieslt-property
    uint centriesLT;
    uint centriesInRange;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recpos.centriestotal-property
    uint centriesTotal;
}

version(X86)
{
    struct JET_RECPOS2
    {
    align (4):
        uint  cbStruct;
        uint  centriesLTDeprecated;
        uint  centriesInRangeDeprecated;
        uint  centriesTotalDeprecated;
        ulong centriesLT;
        ulong centriesTotal;
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist-constructor
struct JET_RECORDLIST
{
    uint        cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist.tableid-property
    JET_TABLEID tableid;
    uint        cRecord;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recordlist.columnidbookmark-property
    uint        columnidBookmark;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange-structure
struct JET_INDEXRANGE
{
    uint        cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange.tableid-property
    JET_TABLEID tableid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-indexrange.grbit-property
    uint        grbit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column-constructor
struct JET_INDEX_COLUMN
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.columnid-property
    uint      columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.relop-property
    JET_RELOP relop;
    void*     pv;
    uint      cb;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-column.grbit-property
    uint      grbit;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-index-range-constructor
struct JET_INDEX_RANGE
{
    JET_INDEX_COLUMN* rgStartColumns;
    uint              cStartColumns;
    JET_INDEX_COLUMN* rgEndColumns;
    uint              cEndColumns;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-logtime-structure
struct JET_LOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
    union
    {
        ubyte bFiller1;
        struct
        {
            // Native bit field: fTimeIsUTC: [0], bMillisecondsLow: [1-7]
            ubyte _bitfield0;
        }
    }
    union
    {
        ubyte bFiller2;
        struct
        {
            // Native bit field: fReserved: [0], bMillisecondsHigh: [1-3], fUnused: [4-7]
            ubyte _bitfield1;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bklogtime-structure
struct JET_BKLOGTIME
{
    byte bSeconds;
    byte bMinutes;
    byte bHours;
    byte bDay;
    byte bMonth;
    byte bYear;
    union
    {
        ubyte bFiller1;
        struct
        {
            // Native bit field: fTimeIsUTC: [0], bMillisecondsLow: [1-7]
            ubyte _bitfield0;
        }
    }
    union
    {
        ubyte bFiller2;
        struct
        {
            // Native bit field: fOSSnapshot: [0], bMillisecondsHigh: [1-3], fReserved: [4-7]
            ubyte _bitfield1;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos-structure2
struct JET_LGPOS
{
align (1):
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.ib-property
    ushort ib;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.isec-property
    ushort isec;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-lgpos.lgeneration-property
    int    lGeneration;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-signature-structure
struct JET_SIGNATURE
{
align (1):
    uint        ulRandom;
    JET_LOGTIME logtimeCreate;
    byte[16]    szComputerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo-structure2
struct JET_BKINFO
{
align (1):
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.lgposmark-property
    JET_LGPOS lgposMark;
    union
    {
        JET_LOGTIME   logtimeMark;
        JET_BKLOGTIME bklogtimeMark;
    }
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.genlow-property
    uint      genLow;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-bkinfo.genhigh-property
    uint      genHigh;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc-constructor
struct JET_DBINFOMISC
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.ulversion-property
    uint          ulVersion;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.ulupdate-property
    uint          ulUpdate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.signdb-property
    JET_SIGNATURE signDb;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dbstate-property
    uint          dbstate;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposconsistent-property
    JET_LGPOS     lgposConsistent;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimeconsistent-property
    JET_LOGTIME   logtimeConsistent;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimeattach-property
    JET_LOGTIME   logtimeAttach;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposattach-property
    JET_LGPOS     lgposAttach;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.logtimedetach-property
    JET_LOGTIME   logtimeDetach;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lgposdetach-property
    JET_LGPOS     lgposDetach;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.signlog-property
    JET_SIGNATURE signLog;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfofullprev-property
    JET_BKINFO    bkinfoFullPrev;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfoincprev-property
    JET_BKINFO    bkinfoIncPrev;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.bkinfofullcur-property
    JET_BKINFO    bkinfoFullCur;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.fshadowingdisabled-property
    uint          fShadowingDisabled;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.fupgradedb-property
    uint          fUpgradeDb;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwmajorversion-property
    uint          dwMajorVersion;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwminorversion-property
    uint          dwMinorVersion;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.dwbuildnumber-property
    uint          dwBuildNumber;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.lspnumber-property
    int           lSPNumber;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc.cbpagesize-property
    uint          cbPageSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc2-structure
struct JET_DBINFOMISC2
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc3-structure
struct JET_DBINFOMISC3
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-dbinfomisc4-structure
struct JET_DBINFOMISC4
{
    uint          ulVersion;
    uint          ulUpdate;
    JET_SIGNATURE signDb;
    uint          dbstate;
    JET_LGPOS     lgposConsistent;
    JET_LOGTIME   logtimeConsistent;
    JET_LOGTIME   logtimeAttach;
    JET_LGPOS     lgposAttach;
    JET_LOGTIME   logtimeDetach;
    JET_LGPOS     lgposDetach;
    JET_SIGNATURE signLog;
    JET_BKINFO    bkinfoFullPrev;
    JET_BKINFO    bkinfoIncPrev;
    JET_BKINFO    bkinfoFullCur;
    uint          fShadowingDisabled;
    uint          fUpgradeDb;
    uint          dwMajorVersion;
    uint          dwMinorVersion;
    uint          dwBuildNumber;
    int           lSPNumber;
    uint          cbPageSize;
    uint          genMinRequired;
    uint          genMaxRequired;
    JET_LOGTIME   logtimeGenMaxCreate;
    uint          ulRepairCount;
    JET_LOGTIME   logtimeRepair;
    uint          ulRepairCountOld;
    uint          ulECCFixSuccess;
    JET_LOGTIME   logtimeECCFixSuccess;
    uint          ulECCFixSuccessOld;
    uint          ulECCFixFail;
    JET_LOGTIME   logtimeECCFixFail;
    uint          ulECCFixFailOld;
    uint          ulBadChecksum;
    JET_LOGTIME   logtimeBadChecksum;
    uint          ulBadChecksumOld;
    uint          genCommitted;
    JET_BKINFO    bkinfoCopyPrev;
    JET_BKINFO    bkinfoDiffPrev;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats-structure2
struct JET_THREADSTATS
{
    uint cbStruct;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagereferenced-property
    uint cPageReferenced;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpageread-property
    uint cPageRead;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagepreread-property
    uint cPagePreread;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpagedirtied-property
    uint cPageDirtied;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cpageredirtied-property
    uint cPageRedirtied;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.clogrecord-property
    uint cLogRecord;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-threadstats.cblogrecord-property
    uint cbLogRecord;
}

version(X86)
{
    struct JET_THREADSTATS2
    {
    align (4):
        uint  cbStruct;
        uint  cPageReferenced;
        uint  cPageRead;
        uint  cPagePreread;
        uint  cPageDirtied;
        uint  cPageRedirtied;
        uint  cLogRecord;
        uint  cbLogRecord;
        ulong cusecPageCacheMiss;
        uint  cPageCacheMiss;
    }
}

struct JET_RSTINFO_A
{
    uint          cbStruct;
    JET_RSTMAP_A* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_RSTINFO_W
{
    uint          cbStruct;
    JET_RSTMAP_W* rgrstmap;
    int           crstmap;
    JET_LGPOS     lgposStop;
    JET_LOGTIME   logtimeStop;
    JET_PFNSTATUS pfnStatus;
}

struct JET_ERRINFOBASIC_W
{
    uint       cbStruct;
    int        errValue;
    JET_ERRCAT errcatMostSpecific;
    ubyte[8]   rgCategoricalHierarchy;
    uint       lSourceLine;
    ushort[64] rgszSourceFile;
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-commit-id-class
    struct JET_COMMIT_ID
    {
    align (4):
        JET_SIGNATURE signLog;
        int           reserved;
        long          commitId;
    }
}

struct JET_OPERATIONCONTEXT
{
    uint  ulUserID;
    ubyte nOperationID;
    ubyte nOperationType;
    ubyte nClientType;
    ubyte fFlags;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn-constructor
struct JET_SETCOLUMN
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.columnid-property
    uint  columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.pvdata-property
    void* pvData;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.cbdata-property
    uint  cbData;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.grbit-property
    uint  grbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.iblongvalue-property
    uint  ibLongValue;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.itagsequence-property
    uint  itagSequence;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-setcolumn.err-property
    int   err;
}

struct JET_SETSYSPARAM_A
{
    uint        paramid;
    JET_API_PTR lParam;
    byte*       sz;
    int         err;
}

struct JET_SETSYSPARAM_W
{
    uint        paramid;
    JET_API_PTR lParam;
    ushort*     sz;
    int         err;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn-structure
struct JET_RETRIEVECOLUMN
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.columnid-property
    uint  columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.pvdata-property
    void* pvData;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.cbdata-property
    uint  cbData;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.cbactual-property
    uint  cbActual;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.grbit-property
    uint  grbit;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.iblongvalue-property
    uint  ibLongValue;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.itagsequence-property
    uint  itagSequence;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.columnidnexttagged-property
    uint  columnidNextTagged;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-retrievecolumn.err-property
    int   err;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid-structure
struct JET_ENUMCOLUMNID
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.columnid-property
    uint  columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.ctagsequence-property
    uint  ctagSequence;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnid.rgtagsequence-property
    uint* rgtagSequence;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue-constructor
struct JET_ENUMCOLUMNVALUE
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.itagsequence-property
    uint  itagSequence;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.err-property
    int   err;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.cbdata-property
    uint  cbData;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumnvalue.pvdata-property
    void* pvData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn-class
struct JET_ENUMCOLUMN
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn.columnid-property
    uint columnid;
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-enumcolumn.err-property
    int  err;
    union
    {
        struct
        {
            uint                 cEnumColumnValue;
            JET_ENUMCOLUMNVALUE* rgEnumColumnValue;
        }
        struct
        {
            uint  cbData;
            void* pvData;
        }
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize-structure2
    struct JET_RECSIZE
    {
    align (4):
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cbdata-property
        ulong cbData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvaluedata-property
        ulong cbLongValueData;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cboverhead-property
        ulong cbOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cblongvalueoverhead-property
        ulong cbLongValueOverhead;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cnontaggedcolumns-property
        ulong cNonTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.ctaggedcolumns-property
        ulong cTaggedColumns;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.clongvalues-property
        ulong cLongValues;
        // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize.cmultivalues-property
        ulong cMultiValues;
    }
}

version(X86)
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jet-recsize2-structure
    struct JET_RECSIZE2
    {
    align (4):
        ulong cbData;
        ulong cbLongValueData;
        ulong cbOverhead;
        ulong cbLongValueOverhead;
        ulong cNonTaggedColumns;
        ulong cTaggedColumns;
        ulong cLongValues;
        ulong cMultiValues;
        ulong cCompressedColumns;
        ulong cbDataCompressed;
        ulong cbLongValueDataCompressed;
    }
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct JET_LOGINFO_A
{
    uint    cbSize;
    uint    ulGenLow;
    uint    ulGenHigh;
    byte[4] szBaseName;
}

//STRUCT ATTR: StructSizeFieldAttribute : CustomAttributeSig([FixedArgSig(ElementSig(cbSize))], [])
struct JET_LOGINFO_W
{
    uint      cbSize;
    uint      ulGenLow;
    uint      ulGenHigh;
    ushort[4] szBaseName;
}

struct JET_INSTANCE_INFO_A
{
    JET_INSTANCE hInstanceId;
    byte*        szInstanceName;
    JET_API_PTR  cDatabases;
    byte**       szDatabaseFileName;
    byte**       szDatabaseDisplayName;
    byte**       szDatabaseSLVFileName_Obsolete;
}

struct JET_INSTANCE_INFO_W
{
    JET_INSTANCE hInstanceId;
    ushort*      szInstanceName;
    JET_API_PTR  cDatabases;
    ushort**     szDatabaseFileName;
    ushort**     szDatabaseDisplayName;
    ushort**     szDatabaseSLVFileName_Obsolete;
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit-function
@DllImport("ESENT.dll")
int JetInit(JET_INSTANCE* pinstance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetinit2-function
@DllImport("ESENT.dll")
int JetInit2(JET_INSTANCE* pinstance, uint grbit);

@DllImport("ESENT.dll")
int JetInit3A(JET_INSTANCE* pinstance, JET_RSTINFO_A* prstInfo, uint grbit);

@DllImport("ESENT.dll")
int JetInit3W(JET_INSTANCE* pinstance, JET_RSTINFO_W* prstInfo, uint grbit);

@DllImport("ESENT.dll")
int JetCreateInstanceA(JET_INSTANCE* pinstance, byte* szInstanceName);

@DllImport("ESENT.dll")
int JetCreateInstanceW(JET_INSTANCE* pinstance, ushort* szInstanceName);

@DllImport("ESENT.dll")
int JetCreateInstance2A(JET_INSTANCE* pinstance, byte* szInstanceName, byte* szDisplayName, uint grbit);

@DllImport("ESENT.dll")
int JetCreateInstance2W(JET_INSTANCE* pinstance, ushort* szInstanceName, ushort* szDisplayName, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetinstancemiscinfo-function
@DllImport("ESENT.dll")
int JetGetInstanceMiscInfo(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetterm-function
@DllImport("ESENT.dll")
int JetTerm(JET_INSTANCE instance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetterm2-function
@DllImport("ESENT.dll")
int JetTerm2(JET_INSTANCE instance, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopservice-function
@DllImport("ESENT.dll")
int JetStopService();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopserviceinstance-function
@DllImport("ESENT.dll")
int JetStopServiceInstance(JET_INSTANCE instance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopserviceinstance2-function
@DllImport("ESENT.dll")
int JetStopServiceInstance2(JET_INSTANCE instance, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopbackup-function
@DllImport("ESENT.dll")
int JetStopBackup();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetstopbackupinstance-function
@DllImport("ESENT.dll")
int JetStopBackupInstance(JET_INSTANCE instance);

@DllImport("ESENT.dll")
int JetSetSystemParameterA(JET_INSTANCE* pinstance, JET_SESID sesid, uint paramid, JET_API_PTR lParam, 
                           byte* szParam);

@DllImport("ESENT.dll")
int JetSetSystemParameterW(JET_INSTANCE* pinstance, JET_SESID sesid, uint paramid, JET_API_PTR lParam, 
                           ushort* szParam);

@DllImport("ESENT.dll")
int JetGetSystemParameterA(JET_INSTANCE instance, JET_SESID sesid, uint paramid, JET_API_PTR* plParam, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/byte* szParam, 
                           uint cbMax);

@DllImport("ESENT.dll")
int JetGetSystemParameterW(JET_INSTANCE instance, JET_SESID sesid, uint paramid, JET_API_PTR* plParam, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ushort* szParam, 
                           uint cbMax);

@DllImport("ESENT.dll")
int JetEnableMultiInstanceA(JET_SETSYSPARAM_A* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

@DllImport("ESENT.dll")
int JetEnableMultiInstanceW(JET_SETSYSPARAM_W* psetsysparam, uint csetsysparam, uint* pcsetsucceed);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetthreadstats-function
@DllImport("ESENT.dll")
int JetGetThreadStats(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* pvResult, 
                      uint cbMax);

@DllImport("ESENT.dll")
int JetBeginSessionA(JET_INSTANCE instance, JET_SESID* psesid, byte* szUserName, byte* szPassword);

@DllImport("ESENT.dll")
int JetBeginSessionW(JET_INSTANCE instance, JET_SESID* psesid, ushort* szUserName, ushort* szPassword);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdupsession-function
@DllImport("ESENT.dll")
int JetDupSession(JET_SESID sesid, JET_SESID* psesid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendsession-function
@DllImport("ESENT.dll")
int JetEndSession(JET_SESID sesid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetversion-function
@DllImport("ESENT.dll")
int JetGetVersion(JET_SESID sesid, uint* pwVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetidle-function
@DllImport("ESENT.dll")
int JetIdle(JET_SESID sesid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabaseA(JET_SESID sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabaseW(JET_SESID sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabase2A(JET_SESID sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetCreateDatabase2W(JET_SESID sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint* pdbid, 
                        uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabaseA(JET_SESID sesid, byte* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabaseW(JET_SESID sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabase2A(JET_SESID sesid, byte* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT.dll")
int JetAttachDatabase2W(JET_SESID sesid, ushort* szFilename, const(uint) cpgDatabaseSizeMax, uint grbit);

@DllImport("ESENT.dll")
int JetDetachDatabaseA(JET_SESID sesid, byte* szFilename);

@DllImport("ESENT.dll")
int JetDetachDatabaseW(JET_SESID sesid, ushort* szFilename);

@DllImport("ESENT.dll")
int JetDetachDatabase2A(JET_SESID sesid, byte* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetDetachDatabase2W(JET_SESID sesid, ushort* szFilename, uint grbit);

@DllImport("ESENT.dll")
int JetGetObjectInfoA(JET_SESID sesid, uint dbid, uint objtyp, byte* szContainerName, byte* szObjectName, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetObjectInfoW(JET_SESID sesid, uint dbid, uint objtyp, ushort* szContainerName, ushort* szObjectName, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableInfoA(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableInfoW(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetCreateTableA(JET_SESID sesid, uint dbid, byte* szTableName, uint lPages, uint lDensity, 
                    JET_TABLEID* ptableid);

@DllImport("ESENT.dll")
int JetCreateTableW(JET_SESID sesid, uint dbid, ushort* szTableName, uint lPages, uint lDensity, 
                    JET_TABLEID* ptableid);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndexA(JET_SESID sesid, uint dbid, JET_TABLECREATE_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndexW(JET_SESID sesid, uint dbid, JET_TABLECREATE_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2A(JET_SESID sesid, uint dbid, JET_TABLECREATE2_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex2W(JET_SESID sesid, uint dbid, JET_TABLECREATE2_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3A(JET_SESID sesid, uint dbid, JET_TABLECREATE3_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex3W(JET_SESID sesid, uint dbid, JET_TABLECREATE3_W* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4A(JET_SESID sesid, uint dbid, JET_TABLECREATE4_A* ptablecreate);

@DllImport("ESENT.dll")
int JetCreateTableColumnIndex4W(JET_SESID sesid, uint dbid, JET_TABLECREATE4_W* ptablecreate);

@DllImport("ESENT.dll")
int JetDeleteTableA(JET_SESID sesid, uint dbid, byte* szTableName);

@DllImport("ESENT.dll")
int JetDeleteTableW(JET_SESID sesid, uint dbid, ushort* szTableName);

@DllImport("ESENT.dll")
int JetRenameTableA(JET_SESID sesid, uint dbid, byte* szName, byte* szNameNew);

@DllImport("ESENT.dll")
int JetRenameTableW(JET_SESID sesid, uint dbid, ushort* szName, ushort* szNameNew);

@DllImport("ESENT.dll")
int JetGetTableColumnInfoA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableColumnInfoW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                           uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetColumnInfoA(JET_SESID sesid, uint dbid, byte* szTableName, byte* pColumnNameOrId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetColumnInfoW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* pwColumnNameOrId, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                      uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetAddColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvDefault, 
                  uint cbDefault, uint* pcolumnid);

@DllImport("ESENT.dll")
int JetAddColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, const(JET_COLUMNDEF)* pcolumndef, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvDefault, 
                  uint cbDefault, uint* pcolumnid);

@DllImport("ESENT.dll")
int JetDeleteColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName);

@DllImport("ESENT.dll")
int JetDeleteColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName);

@DllImport("ESENT.dll")
int JetDeleteColumn2A(JET_SESID sesid, JET_TABLEID tableid, byte* szColumnName, const(uint) grbit);

@DllImport("ESENT.dll")
int JetDeleteColumn2W(JET_SESID sesid, JET_TABLEID tableid, ushort* szColumnName, const(uint) grbit);

@DllImport("ESENT.dll")
int JetRenameColumnA(JET_SESID sesid, JET_TABLEID tableid, byte* szName, byte* szNameNew, uint grbit);

@DllImport("ESENT.dll")
int JetRenameColumnW(JET_SESID sesid, JET_TABLEID tableid, ushort* szName, ushort* szNameNew, uint grbit);

@DllImport("ESENT.dll")
int JetSetColumnDefaultValueA(JET_SESID sesid, uint dbid, byte* szTableName, byte* szColumnName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                              const(uint) cbData, const(uint) grbit);

@DllImport("ESENT.dll")
int JetSetColumnDefaultValueW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* szColumnName, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvData, 
                              const(uint) cbData, const(uint) grbit);

@DllImport("ESENT.dll")
int JetGetTableIndexInfoA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                          uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetTableIndexInfoW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, 
                          /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvResult, 
                          uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetIndexInfoA(JET_SESID sesid, uint dbid, byte* szTableName, byte* szIndexName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                     uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetIndexInfoW(JET_SESID sesid, uint dbid, ushort* szTableName, ushort* szIndexName, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvResult, 
                     uint cbResult, uint InfoLevel);

@DllImport("ESENT.dll")
int JetCreateIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/byte* szKey, 
                    uint cbKey, uint lDensity);

@DllImport("ESENT.dll")
int JetCreateIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/ushort* szKey, 
                    uint cbKey, uint lDensity);

@DllImport("ESENT.dll")
int JetCreateIndex2A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex2W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex3A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE2_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex3W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE2_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex4A(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE3_A* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetCreateIndex4W(JET_SESID sesid, JET_TABLEID tableid, JET_INDEXCREATE3_W* pindexcreate, uint cIndexCreate);

@DllImport("ESENT.dll")
int JetDeleteIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName);

@DllImport("ESENT.dll")
int JetDeleteIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction-function
@DllImport("ESENT.dll")
int JetBeginTransaction(JET_SESID sesid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction2-function
@DllImport("ESENT.dll")
int JetBeginTransaction2(JET_SESID sesid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbegintransaction3-function
@DllImport("ESENT.dll")
int JetBeginTransaction3(JET_SESID sesid, long trxid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcommittransaction-function
@DllImport("ESENT.dll")
int JetCommitTransaction(JET_SESID sesid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcommittransaction2-function
@DllImport("ESENT.dll")
int JetCommitTransaction2(JET_SESID sesid, uint grbit, uint cmsecDurableCommit, JET_COMMIT_ID* pCommitId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetrollback-function
@DllImport("ESENT.dll")
int JetRollback(JET_SESID sesid, uint grbit);

@DllImport("ESENT.dll")
int JetGetDatabaseInfoA(JET_SESID sesid, uint dbid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                        uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseInfoW(JET_SESID sesid, uint dbid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                        uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoA(byte* szDatabaseName, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                            uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetGetDatabaseFileInfoW(ushort* szDatabaseName, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                            uint cbMax, uint InfoLevel);

@DllImport("ESENT.dll")
int JetOpenDatabaseA(JET_SESID sesid, byte* szFilename, byte* szConnect, uint* pdbid, uint grbit);

@DllImport("ESENT.dll")
int JetOpenDatabaseW(JET_SESID sesid, ushort* szFilename, ushort* szConnect, uint* pdbid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosedatabase-function
@DllImport("ESENT.dll")
int JetCloseDatabase(JET_SESID sesid, uint dbid, uint grbit);

@DllImport("ESENT.dll")
int JetOpenTableA(JET_SESID sesid, uint dbid, byte* szTableName, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvParameters, 
                  uint cbParameters, uint grbit, JET_TABLEID* ptableid);

@DllImport("ESENT.dll")
int JetOpenTableW(JET_SESID sesid, uint dbid, ushort* szTableName, 
                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvParameters, 
                  uint cbParameters, uint grbit, JET_TABLEID* ptableid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsettablesequential-function
@DllImport("ESENT.dll")
int JetSetTableSequential(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresettablesequential-function
@DllImport("ESENT.dll")
int JetResetTableSequential(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosetable-function
@DllImport("ESENT.dll")
int JetCloseTable(JET_SESID sesid, JET_TABLEID tableid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdelete-function
@DllImport("ESENT.dll")
int JetDelete(JET_SESID sesid, JET_TABLEID tableid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetupdate-function
@DllImport("ESENT.dll")
int JetUpdate(JET_SESID sesid, JET_TABLEID tableid, 
              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
              uint cbBookmark, uint* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetupdate2-function
@DllImport("ESENT.dll")
int JetUpdate2(JET_SESID sesid, JET_TABLEID tableid, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
               uint cbBookmark, uint* pcbActual, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetescrowupdate-function
@DllImport("ESENT.dll")
int JetEscrowUpdate(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pv, 
                    uint cbMax, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvOld, 
                    uint cbOldMax, uint* pcbOldActual, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievecolumn-function
@DllImport("ESENT.dll")
int JetRetrieveColumn(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                      /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                      uint cbData, uint* pcbActual, uint grbit, JET_RETINFO* pretinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievecolumns-function
@DllImport("ESENT.dll")
int JetRetrieveColumns(JET_SESID sesid, JET_TABLEID tableid, JET_RETRIEVECOLUMN* pretrievecolumn, 
                       uint cretrievecolumn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetenumeratecolumns-function
@DllImport("ESENT.dll")
int JetEnumerateColumns(JET_SESID sesid, JET_TABLEID tableid, uint cEnumColumnId, JET_ENUMCOLUMNID* rgEnumColumnId, 
                        uint* pcEnumColumn, JET_ENUMCOLUMN** prgEnumColumn, JET_PFNREALLOC pfnRealloc, 
                        void* pvReallocContext, uint cbDataMost, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordsize-function
@DllImport("ESENT.dll")
int JetGetRecordSize(JET_SESID sesid, JET_TABLEID tableid, JET_RECSIZE* precsize, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordsize2-function
@DllImport("ESENT.dll")
int JetGetRecordSize2(JET_SESID sesid, JET_TABLEID tableid, JET_RECSIZE2* precsize, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcolumn-function
@DllImport("ESENT.dll")
int JetSetColumn(JET_SESID sesid, JET_TABLEID tableid, uint columnid, 
                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pvData, 
                 uint cbData, uint grbit, JET_SETINFO* psetinfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcolumns-function
@DllImport("ESENT.dll")
int JetSetColumns(JET_SESID sesid, JET_TABLEID tableid, JET_SETCOLUMN* psetcolumn, uint csetcolumn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprepareupdate-function
@DllImport("ESENT.dll")
int JetPrepareUpdate(JET_SESID sesid, JET_TABLEID tableid, uint prep);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetrecordposition-function
@DllImport("ESENT.dll")
int JetGetRecordPosition(JET_SESID sesid, JET_TABLEID tableid, 
                         /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/JET_RECPOS* precpos, 
                         uint cbRecpos);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotoposition-function
@DllImport("ESENT.dll")
int JetGotoPosition(JET_SESID sesid, JET_TABLEID tableid, JET_RECPOS* precpos);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetcursorinfo-function
@DllImport("ESENT.dll")
int JetGetCursorInfo(JET_SESID sesid, JET_TABLEID tableid, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetdupcursor-function
@DllImport("ESENT.dll")
int JetDupCursor(JET_SESID sesid, JET_TABLEID tableid, JET_TABLEID* ptableid, uint grbit);

@DllImport("ESENT.dll")
int JetGetCurrentIndexA(JET_SESID sesid, JET_TABLEID tableid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/byte* szIndexName, 
                        uint cbIndexName);

@DllImport("ESENT.dll")
int JetGetCurrentIndexW(JET_SESID sesid, JET_TABLEID tableid, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/ushort* szIndexName, 
                        uint cbIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndexA(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndexW(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName);

@DllImport("ESENT.dll")
int JetSetCurrentIndex2A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit);

@DllImport("ESENT.dll")
int JetSetCurrentIndex2W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit);

@DllImport("ESENT.dll")
int JetSetCurrentIndex3A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex3W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex4A(JET_SESID sesid, JET_TABLEID tableid, byte* szIndexName, JET_INDEXID* pindexid, 
                         uint grbit, uint itagSequence);

@DllImport("ESENT.dll")
int JetSetCurrentIndex4W(JET_SESID sesid, JET_TABLEID tableid, ushort* szIndexName, JET_INDEXID* pindexid, 
                         uint grbit, uint itagSequence);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetmove-function
@DllImport("ESENT.dll")
int JetMove(JET_SESID sesid, JET_TABLEID tableid, int cRow, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetcursorfilter-function
@DllImport("ESENT.dll")
int JetSetCursorFilter(JET_SESID sesid, JET_TABLEID tableid, JET_INDEX_COLUMN* rgColumnFilters, 
                       uint cColumnFilters, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetlock-function
@DllImport("ESENT.dll")
int JetGetLock(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetmakekey-function
@DllImport("ESENT.dll")
int JetMakeKey(JET_SESID sesid, JET_TABLEID tableid, 
               /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvData, 
               uint cbData, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetseek-function
@DllImport("ESENT.dll")
int JetSeek(JET_SESID sesid, JET_TABLEID tableid, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprereadkeys-function
@DllImport("ESENT.dll")
int JetPrereadKeys(JET_SESID sesid, JET_TABLEID tableid, void** rgpvKeys, const(uint)* rgcbKeys, int ckeys, 
                   int* pckeysPreread, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetprereadindexranges-function
@DllImport("ESENT.dll")
int JetPrereadIndexRanges(JET_SESID sesid, JET_TABLEID tableid, const(JET_INDEX_RANGE)* rgIndexRanges, 
                          const(uint) cIndexRanges, uint* pcRangesPreread, const(uint)* rgcolumnidPreread, 
                          const(uint) ccolumnidPreread, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetbookmark-function
@DllImport("ESENT.dll")
int JetGetBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
                   uint cbMax, uint* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsecondaryindexbookmark-function
@DllImport("ESENT.dll")
int JetGetSecondaryIndexBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvSecondaryKey, 
                                 uint cbSecondaryKeyMax, uint* pcbSecondaryKeyActual, 
                                 /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(6)))])*/void* pvPrimaryBookmark, 
                                 uint cbPrimaryBookmarkMax, uint* pcbPrimaryBookmarkActual, const(uint) grbit);

@DllImport("ESENT.dll")
int JetCompactA(JET_SESID sesid, byte* szDatabaseSrc, byte* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                JET_CONVERT_A* pconvert, uint grbit);

@DllImport("ESENT.dll")
int JetCompactW(JET_SESID sesid, ushort* szDatabaseSrc, ushort* szDatabaseDest, JET_PFNSTATUS pfnStatus, 
                JET_CONVERT_W* pconvert, uint grbit);

@DllImport("ESENT.dll")
int JetDefragmentA(JET_SESID sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT.dll")
int JetDefragmentW(JET_SESID sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment2A(JET_SESID sesid, uint dbid, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment2W(JET_SESID sesid, uint dbid, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment3A(JET_SESID sesid, byte* szDatabaseName, byte* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT.dll")
int JetDefragment3W(JET_SESID sesid, ushort* szDatabaseName, ushort* szTableName, uint* pcPasses, uint* pcSeconds, 
                    JET_CALLBACK callback, void* pvContext, uint grbit);

@DllImport("ESENT.dll")
int JetSetDatabaseSizeA(JET_SESID sesid, byte* szDatabaseName, uint cpg, uint* pcpgReal);

@DllImport("ESENT.dll")
int JetSetDatabaseSizeW(JET_SESID sesid, ushort* szDatabaseName, uint cpg, uint* pcpgReal);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgrowdatabase-function
@DllImport("ESENT.dll")
int JetGrowDatabase(JET_SESID sesid, uint dbid, uint cpg, uint* pcpgReal);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresizedatabase-function
@DllImport("ESENT.dll")
int JetResizeDatabase(JET_SESID sesid, uint dbid, uint cpgTarget, uint* pcpgActual, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsessioncontext-function
@DllImport("ESENT.dll")
int JetSetSessionContext(JET_SESID sesid, JET_API_PTR ulContext);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetresetsessioncontext-function
@DllImport("ESENT.dll")
int JetResetSessionContext(JET_SESID sesid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotobookmark-function
@DllImport("ESENT.dll")
int JetGotoBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvBookmark, 
                    uint cbBookmark);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgotosecondaryindexbookmark-function
@DllImport("ESENT.dll")
int JetGotoSecondaryIndexBookmark(JET_SESID sesid, JET_TABLEID tableid, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvSecondaryKey, 
                                  uint cbSecondaryKey, 
                                  /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(5)))])*/void* pvPrimaryBookmark, 
                                  uint cbPrimaryBookmark, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetintersectindexes-function
@DllImport("ESENT.dll")
int JetIntersectIndexes(JET_SESID sesid, JET_INDEXRANGE* rgindexrange, uint cindexrange, 
                        JET_RECORDLIST* precordlist, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetcomputestats-function
@DllImport("ESENT.dll")
int JetComputeStats(JET_SESID sesid, JET_TABLEID tableid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable-function
@DllImport("ESENT.dll")
int JetOpenTempTable(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint grbit, 
                     JET_TABLEID* ptableid, uint* prgcolumnid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable2-function
@DllImport("ESENT.dll")
int JetOpenTempTable2(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, uint lcid, uint grbit, 
                      JET_TABLEID* ptableid, uint* prgcolumnid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemptable3-function
@DllImport("ESENT.dll")
int JetOpenTempTable3(JET_SESID sesid, const(JET_COLUMNDEF)* prgcolumndef, uint ccolumn, 
                      JET_UNICODEINDEX* pidxunicode, uint grbit, JET_TABLEID* ptableid, uint* prgcolumnid);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemporarytable-function
@DllImport("ESENT.dll")
int JetOpenTemporaryTable(JET_SESID sesid, JET_OPENTEMPORARYTABLE* popentemporarytable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetopentemporarytable2-function
@DllImport("ESENT.dll")
int JetOpenTemporaryTable2(JET_SESID sesid, JET_OPENTEMPORARYTABLE2* popentemporarytable);

@DllImport("ESENT.dll")
int JetBackupA(byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupW(ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupInstanceA(JET_INSTANCE instance, byte* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetBackupInstanceW(JET_INSTANCE instance, ushort* szBackupPath, uint grbit, JET_PFNSTATUS pfnStatus);

@DllImport("ESENT.dll")
int JetRestoreA(byte* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreW(ushort* szSource, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestore2A(byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestore2W(ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreInstanceA(JET_INSTANCE instance, byte* sz, byte* szDest, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetRestoreInstanceW(JET_INSTANCE instance, ushort* sz, ushort* szDest, JET_PFNSTATUS pfn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetindexrange-function
@DllImport("ESENT.dll")
int JetSetIndexRange(JET_SESID sesid, JET_TABLEID tableidSrc, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetindexrecordcount-function
@DllImport("ESENT.dll")
int JetIndexRecordCount(JET_SESID sesid, JET_TABLEID tableid, uint* pcrec, uint crecMax);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetretrievekey-function
@DllImport("ESENT.dll")
int JetRetrieveKey(JET_SESID sesid, JET_TABLEID tableid, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvKey, 
                   uint cbMax, uint* pcbActual, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginexternalbackup-function
@DllImport("ESENT.dll")
int JetBeginExternalBackup(uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetbeginexternalbackupinstance-function
@DllImport("ESENT.dll")
int JetBeginExternalBackupInstance(JET_INSTANCE instance, uint grbit);

@DllImport("ESENT.dll")
int JetGetAttachInfoA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* szzDatabases, 
                      uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ushort* wszzDatabases, 
                      uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceA(JET_INSTANCE instance, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzDatabases, 
                              uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetAttachInfoInstanceW(JET_INSTANCE instance, 
                              /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* szzDatabases, 
                              uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetOpenFileA(byte* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileW(ushort* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileInstanceA(JET_INSTANCE instance, byte* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

@DllImport("ESENT.dll")
int JetOpenFileInstanceW(JET_INSTANCE instance, ushort* szFileName, JET_HANDLE* phfFile, uint* pulFileSizeLow, 
                         uint* pulFileSizeHigh);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetreadfile-function
@DllImport("ESENT.dll")
int JetReadFile(JET_HANDLE hfFile, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pv, 
                uint cb, uint* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetreadfileinstance-function
@DllImport("ESENT.dll")
int JetReadFileInstance(JET_INSTANCE instance, JET_HANDLE hfFile, 
                        /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pv, 
                        uint cb, uint* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosefile-function
@DllImport("ESENT.dll")
int JetCloseFile(JET_HANDLE hfFile);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetclosefileinstance-function
@DllImport("ESENT.dll")
int JetCloseFileInstance(JET_INSTANCE instance, JET_HANDLE hfFile);

@DllImport("ESENT.dll")
int JetGetLogInfoA(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/byte* szzLogs, 
                   uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoW(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/ushort* szzLogs, 
                   uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstanceA(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                           uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstanceW(JET_INSTANCE instance, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                           uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetLogInfoInstance2A(JET_INSTANCE instance, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                            uint cbMax, uint* pcbActual, JET_LOGINFO_A* pLogInfo);

@DllImport("ESENT.dll")
int JetGetLogInfoInstance2W(JET_INSTANCE instance, 
                            /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                            uint cbMax, uint* pcbActual, JET_LOGINFO_W* pLogInfo);

@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceA(JET_INSTANCE instance, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/byte* szzLogs, 
                                   uint cbMax, uint* pcbActual);

@DllImport("ESENT.dll")
int JetGetTruncateLogInfoInstanceW(JET_INSTANCE instance, 
                                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ushort* wszzLogs, 
                                   uint cbMax, uint* pcbActual);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jettruncatelog-function
@DllImport("ESENT.dll")
int JetTruncateLog();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jettruncateloginstance-function
@DllImport("ESENT.dll")
int JetTruncateLogInstance(JET_INSTANCE instance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackup-function
@DllImport("ESENT.dll")
int JetEndExternalBackup();

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackupinstance-function
@DllImport("ESENT.dll")
int JetEndExternalBackupInstance(JET_INSTANCE instance);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetendexternalbackupinstance2-function
@DllImport("ESENT.dll")
int JetEndExternalBackupInstance2(JET_INSTANCE instance, uint grbit);

@DllImport("ESENT.dll")
int JetExternalRestoreA(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                        byte* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestoreW(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                        ushort* szBackupLogPath, int genLow, int genHigh, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestore2A(byte* szCheckpointFilePath, byte* szLogPath, JET_RSTMAP_A* rgrstmap, int crstfilemap, 
                         byte* szBackupLogPath, JET_LOGINFO_A* pLogInfo, byte* szTargetInstanceName, 
                         byte* szTargetInstanceLogPath, byte* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

@DllImport("ESENT.dll")
int JetExternalRestore2W(ushort* szCheckpointFilePath, ushort* szLogPath, JET_RSTMAP_W* rgrstmap, int crstfilemap, 
                         ushort* szBackupLogPath, JET_LOGINFO_W* pLogInfo, ushort* szTargetInstanceName, 
                         ushort* szTargetInstanceLogPath, ushort* szTargetInstanceCheckpointPath, JET_PFNSTATUS pfn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetregistercallback-function
@DllImport("ESENT.dll")
int JetRegisterCallback(JET_SESID sesid, JET_TABLEID tableid, uint cbtyp, JET_CALLBACK pCallback, void* pvContext, 
                        JET_HANDLE* phCallbackId);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetunregistercallback-function
@DllImport("ESENT.dll")
int JetUnregisterCallback(JET_SESID sesid, JET_TABLEID tableid, uint cbtyp, JET_HANDLE hCallbackId);

@DllImport("ESENT.dll")
int JetGetInstanceInfoA(uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo);

@DllImport("ESENT.dll")
int JetGetInstanceInfoW(uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetfreebuffer-function
@DllImport("ESENT.dll")
int JetFreeBuffer(byte* pbBuf);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetls-function
@DllImport("ESENT.dll")
int JetSetLS(JET_SESID sesid, JET_TABLEID tableid, JET_LS ls, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetls-function
@DllImport("ESENT.dll")
int JetGetLS(JET_SESID sesid, JET_TABLEID tableid, JET_LS* pls, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotprepare-function
@DllImport("ESENT.dll")
int JetOSSnapshotPrepare(JET_OSSNAPID* psnapId, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotprepareinstance-function
@DllImport("ESENT.dll")
int JetOSSnapshotPrepareInstance(JET_OSSNAPID snapId, JET_INSTANCE instance, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotFreezeA(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_A** paInstanceInfo, 
                         const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotFreezeW(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, JET_INSTANCE_INFO_W** paInstanceInfo, 
                         const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotthaw-function
@DllImport("ESENT.dll")
int JetOSSnapshotThaw(const(JET_OSSNAPID) snapId, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotabort-function
@DllImport("ESENT.dll")
int JetOSSnapshotAbort(const(JET_OSSNAPID) snapId, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshottruncatelog-function
@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLog(const(JET_OSSNAPID) snapId, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshottruncateloginstance-function
@DllImport("ESENT.dll")
int JetOSSnapshotTruncateLogInstance(const(JET_OSSNAPID) snapId, JET_INSTANCE instance, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoA(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, 
                                JET_INSTANCE_INFO_A** paInstanceInfo, const(uint) grbit);

@DllImport("ESENT.dll")
int JetOSSnapshotGetFreezeInfoW(const(JET_OSSNAPID) snapId, uint* pcInstanceInfo, 
                                JET_INSTANCE_INFO_W** paInstanceInfo, const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetossnapshotend-function
@DllImport("ESENT.dll")
int JetOSSnapshotEnd(const(JET_OSSNAPID) snapId, const(uint) grbit);

@DllImport("ESENT.dll")
int JetConfigureProcessForCrashDump(const(uint) grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgeterrorinfow-function
@DllImport("ESENT.dll")
int JetGetErrorInfoW(void* pvContext, 
                     /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* pvResult, 
                     uint cbMax, uint InfoLevel, uint grbit);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetsetsessionparameter-function
@DllImport("ESENT.dll")
int JetSetSessionParameter(JET_SESID sesid, uint sesparamid, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/void* pvParam, 
                           uint cbParam);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/extensible-storage-engine/jetgetsessionparameter-function
@DllImport("ESENT.dll")
int JetGetSessionParameter(JET_SESID sesid, uint sesparamid, void* pvParam, uint cbParamMax, uint* pcbParamActual);


