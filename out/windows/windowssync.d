module windows.windowssync;

public import windows.core;
public import windows.audio : IPropertyStore;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    SPR_SOURCE      = 0x00000000,
    SPR_DESTINATION = 0x00000001,
}
alias SYNC_PROVIDER_ROLE = int;

enum : int
{
    CRP_NONE                      = 0x00000000,
    CRP_DESTINATION_PROVIDER_WINS = 0x00000001,
    CRP_SOURCE_PROVIDER_WINS      = 0x00000002,
    CRP_LAST                      = 0x00000003,
}
alias CONFLICT_RESOLUTION_POLICY = int;

enum : int
{
    SPS_CHANGE_DETECTION   = 0x00000000,
    SPS_CHANGE_ENUMERATION = 0x00000001,
    SPS_CHANGE_APPLICATION = 0x00000002,
}
alias SYNC_PROGRESS_STAGE = int;

enum : int
{
    SFEA_FULL_ENUMERATION = 0x00000000,
    SFEA_PARTIAL_SYNC     = 0x00000001,
    SFEA_ABORT            = 0x00000002,
}
alias SYNC_FULL_ENUMERATION_ACTION = int;

enum : int
{
    SRA_DEFER                       = 0x00000000,
    SRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    SRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    SRA_MERGE                       = 0x00000003,
    SRA_TRANSFER_AND_DEFER          = 0x00000004,
    SRA_LAST                        = 0x00000005,
}
alias SYNC_RESOLVE_ACTION = int;

enum : int
{
    SYNC_STATISTICS_RANGE_COUNT = 0x00000000,
}
alias SYNC_STATISTICS = int;

enum : int
{
    SYNC_SERIALIZATION_VERSION_V1 = 0x00000001,
    SYNC_SERIALIZATION_VERSION_V2 = 0x00000004,
    SYNC_SERIALIZATION_VERSION_V3 = 0x00000005,
}
alias SYNC_SERIALIZATION_VERSION = int;

enum : int
{
    FT_CURRENT_ITEMS_ONLY                             = 0x00000000,
    FT_CURRENT_ITEMS_AND_VERSIONS_FOR_MOVED_OUT_ITEMS = 0x00000001,
}
alias FILTERING_TYPE = int;

enum : int
{
    SCRA_DEFER                       = 0x00000000,
    SCRA_ACCEPT_DESTINATION_PROVIDER = 0x00000001,
    SCRA_ACCEPT_SOURCE_PROVIDER      = 0x00000002,
    SCRA_TRANSFER_AND_DEFER          = 0x00000003,
    SCRA_MERGE                       = 0x00000004,
    SCRA_RENAME_SOURCE               = 0x00000005,
    SCRA_RENAME_DESTINATION          = 0x00000006,
}
alias __MIDL___MIDL_itf_winsync_0000_0000_0009 = int;

enum : int
{
    CCR_OTHER     = 0x00000000,
    CCR_COLLISION = 0x00000001,
    CCR_NOPARENT  = 0x00000002,
    CCR_IDENTITY  = 0x00000003,
}
alias __MIDL___MIDL_itf_winsync_0000_0000_0010 = int;

enum : int
{
    KCCR_COOKIE_KNOWLEDGE_EQUAL          = 0x00000000,
    KCCR_COOKIE_KNOWLEDGE_CONTAINED      = 0x00000001,
    KCCR_COOKIE_KNOWLEDGE_CONTAINS       = 0x00000002,
    KCCR_COOKIE_KNOWLEDGE_NOT_COMPARABLE = 0x00000003,
}
alias KNOWLEDGE_COOKIE_COMPARISON_RESULT = int;

enum : int
{
    FCT_INTERSECTION = 0x00000000,
}
alias __MIDL___MIDL_itf_winsync_0000_0036_0001 = int;

enum : int
{
    SRE_PROVIDER_ADDED         = 0x00000000,
    SRE_PROVIDER_REMOVED       = 0x00000001,
    SRE_PROVIDER_UPDATED       = 0x00000002,
    SRE_PROVIDER_STATE_CHANGED = 0x00000003,
    SRE_CONFIGUI_ADDED         = 0x00000004,
    SRE_CONFIGUI_REMOVED       = 0x00000005,
    SRE_CONFIGUI_UPDATED       = 0x00000006,
}
alias SYNC_REGISTRATION_EVENT = int;

// Structs


struct ID_PARAMETER_PAIR
{
    BOOL   fIsVariable;
    ushort cbIdSize;
}

struct ID_PARAMETERS
{
    uint              dwSize;
    ID_PARAMETER_PAIR replicaId;
    ID_PARAMETER_PAIR itemId;
    ID_PARAMETER_PAIR changeUnitId;
}

struct SYNC_SESSION_STATISTICS
{
    uint dwChangesApplied;
    uint dwChangesFailed;
}

struct SYNC_VERSION
{
    uint  dwLastUpdatingReplicaKey;
    ulong ullTickCount;
}

struct SYNC_RANGE
{
    ubyte* pbClosedLowerBound;
    ubyte* pbClosedUpperBound;
}

struct SYNC_TIME
{
    uint dwDate;
    uint dwTime;
}

struct SYNC_FILTER_CHANGE
{
    BOOL         fMoveIn;
    SYNC_VERSION moveVersion;
}

struct SyncProviderConfiguration
{
    uint dwVersion;
    GUID guidInstanceId;
    GUID clsidProvider;
    GUID guidConfigUIInstanceId;
    GUID guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
}

struct SyncProviderConfigUIConfiguration
{
    uint dwVersion;
    GUID guidInstanceId;
    GUID clsidConfigUI;
    GUID guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
    BOOL fIsGlobal;
}

// Interfaces

@GUID("F82B4EF1-93A9-4DDE-8015-F7950A1A6E31")
struct SyncProviderRegistration;

@GUID("E71C4250-ADF8-4A07-8FAE-5669596909C1")
interface IClockVectorElement : IUnknown
{
    HRESULT GetReplicaKey(uint* pdwReplicaKey);
    HRESULT GetTickCount(ulong* pullTickCount);
}

@GUID("A40B46D2-E97B-4156-B6DA-991F501B0F05")
interface IFeedClockVectorElement : IClockVectorElement
{
    HRESULT GetSyncTime(SYNC_TIME* pSyncTime);
    HRESULT GetFlags(ubyte* pbFlags);
}

@GUID("14B2274A-8698-4CC6-9333-F89BD1D47BC4")
interface IClockVector : IUnknown
{
    HRESULT GetClockVectorElements(const(GUID)* riid, void** ppiEnumClockVector);
    HRESULT GetClockVectorElementCount(uint* pdwCount);
}

@GUID("8D1D98D1-9FB8-4EC9-A553-54DD924E0F67")
interface IFeedClockVector : IClockVector
{
    HRESULT GetUpdateCount(uint* pdwUpdateCount);
    HRESULT IsNoConflictsSpecified(int* pfIsNoConflictsSpecified);
}

@GUID("525844DB-2837-4799-9E80-81A66E02220C")
interface IEnumClockVector : IUnknown
{
    HRESULT Next(uint cClockVectorElements, IClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    HRESULT Skip(uint cSyncVersions);
    HRESULT Reset();
    HRESULT Clone(IEnumClockVector* ppiEnum);
}

@GUID("550F763D-146A-48F6-ABEB-6C88C7F70514")
interface IEnumFeedClockVector : IUnknown
{
    HRESULT Next(uint cClockVectorElements, IFeedClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    HRESULT Skip(uint cSyncVersions);
    HRESULT Reset();
    HRESULT Clone(IEnumFeedClockVector* ppiEnum);
}

@GUID("613B2AB5-B304-47D9-9C31-CE6C54401A15")
interface ICoreFragment : IUnknown
{
    HRESULT NextColumn(ubyte* pChangeUnitId, uint* pChangeUnitIdSize);
    HRESULT NextRange(ubyte* pItemId, uint* pItemIdSize, IClockVector* piClockVector);
    HRESULT Reset();
    HRESULT GetColumnCount(uint* pColumnCount);
    HRESULT GetRangeCount(uint* pRangeCount);
}

@GUID("F7FCC5FD-AE26-4679-BA16-96AAC583C134")
interface ICoreFragmentInspector : IUnknown
{
    HRESULT NextCoreFragments(uint requestedCount, ICoreFragment* ppiCoreFragments, uint* pFetchedCount);
    HRESULT Reset();
}

@GUID("75AE8777-6848-49F7-956C-A3A92F5096E8")
interface IRangeException : IUnknown
{
    HRESULT GetClosedRangeStart(ubyte* pbClosedRangeStart, uint* pcbIdSize);
    HRESULT GetClosedRangeEnd(ubyte* pbClosedRangeEnd, uint* pcbIdSize);
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("0944439F-DDB1-4176-B703-046FF22A2386")
interface IEnumRangeExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, IRangeException* ppRangeException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumRangeExceptions* ppEnum);
}

@GUID("892FB9B0-7C55-4A18-9316-FDF449569B64")
interface ISingleItemException : IUnknown
{
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("E563381C-1B4D-4C66-9796-C86FACCDCD40")
interface IEnumSingleItemExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, ISingleItemException* ppSingleItemException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumSingleItemExceptions* ppEnum);
}

@GUID("0CD7EE7C-FEC0-4021-99EE-F0E5348F2A5F")
interface IChangeUnitException : IUnknown
{
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    HRESULT GetClockVector(const(GUID)* riid, void** ppUnk);
}

@GUID("3074E802-9319-4420-BE21-1022E2E21DA8")
interface IEnumChangeUnitExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, IChangeUnitException* ppChangeUnitException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumChangeUnitExceptions* ppEnum);
}

@GUID("2209F4FC-FD10-4FF0-84A8-F0A1982E440E")
interface IReplicaKeyMap : IUnknown
{
    HRESULT LookupReplicaKey(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
    HRESULT LookupReplicaId(uint dwReplicaKey, ubyte* pbReplicaId, uint* pcbIdSize);
    HRESULT Serialize(ubyte* pbReplicaKeyMap, uint* pcbReplicaKeyMap);
}

@GUID("DED10970-EC85-4115-B52C-4405845642A5")
interface IConstructReplicaKeyMap : IUnknown
{
    HRESULT FindOrAddReplica(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
}

@GUID("615BBB53-C945-4203-BF4B-2CB65919A0AA")
interface ISyncKnowledge : IUnknown
{
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    HRESULT Serialize(BOOL fSerializeReplicaKeyMap, ubyte* pbKnowledge, uint* pcbKnowledge);
    HRESULT SetLocalTickCount(ulong ullTickCount);
    HRESULT ContainsChange(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pgidItemId, 
                           const(SYNC_VERSION)* pSyncVersion);
    HRESULT ContainsChangeUnit(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pbItemId, 
                               const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pSyncVersion);
    HRESULT GetScopeVector(const(GUID)* riid, void** ppUnk);
    HRESULT GetReplicaKeyMap(IReplicaKeyMap* ppReplicaKeyMap);
    HRESULT Clone(ISyncKnowledge* ppClonedKnowledge);
    HRESULT ConvertVersion(ISyncKnowledge pKnowledgeIn, const(ubyte)* pbCurrentOwnerId, 
                           const(SYNC_VERSION)* pVersionIn, ubyte* pbNewOwnerId, uint* pcbIdSize, 
                           SYNC_VERSION* pVersionOut);
    HRESULT MapRemoteToLocal(ISyncKnowledge pRemoteKnowledge, ISyncKnowledge* ppMappedKnowledge);
    HRESULT Union(ISyncKnowledge pKnowledge);
    HRESULT ProjectOntoItem(const(ubyte)* pbItemId, ISyncKnowledge* ppKnowledgeOut);
    HRESULT ProjectOntoChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, 
                                  ISyncKnowledge* ppKnowledgeOut);
    HRESULT ProjectOntoRange(const(SYNC_RANGE)* psrngSyncRange, ISyncKnowledge* ppKnowledgeOut);
    HRESULT ExcludeItem(const(ubyte)* pbItemId);
    HRESULT ExcludeChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId);
    HRESULT ContainsKnowledge(ISyncKnowledge pKnowledge);
    HRESULT FindMinTickCountForReplica(const(ubyte)* pbReplicaId, ulong* pullReplicaTickCount);
    HRESULT GetRangeExceptions(const(GUID)* riid, void** ppUnk);
    HRESULT GetSingleItemExceptions(const(GUID)* riid, void** ppUnk);
    HRESULT GetChangeUnitExceptions(const(GUID)* riid, void** ppUnk);
    HRESULT FindClockVectorForItem(const(ubyte)* pbItemId, const(GUID)* riid, void** ppUnk);
    HRESULT FindClockVectorForChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, const(GUID)* riid, 
                                         void** ppUnk);
    HRESULT GetVersion(uint* pdwVersion);
}

@GUID("456E0F96-6036-452B-9F9D-BCC4B4A85DB2")
interface IForgottenKnowledge : ISyncKnowledge
{
    HRESULT ForgetToVersion(ISyncKnowledge pKnowledge, const(SYNC_VERSION)* pVersion);
}

@GUID("ED0ADDC0-3B4B-46A1-9A45-45661D2114C8")
interface ISyncKnowledge2 : ISyncKnowledge
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT ProjectOntoColumnSet(const(ubyte)** ppColumns, uint count, ISyncKnowledge2* ppiKnowledgeOut);
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
    HRESULT GetLowestUncontainedId(ISyncKnowledge2 piSyncKnowledge, ubyte* pbItemId, uint* pcbItemIdSize);
    HRESULT GetInspector(const(GUID)* riid, void** ppiInspector);
    HRESULT GetMinimumSupportedVersion(SYNC_SERIALIZATION_VERSION* pVersion);
    HRESULT GetStatistics(SYNC_STATISTICS which, uint* pValue);
    HRESULT ContainsKnowledgeForItem(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId);
    HRESULT ContainsKnowledgeForChangeUnit(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId, 
                                           const(ubyte)* pbChangeUnitId);
    HRESULT ProjectOntoKnowledgeWithPrerequisite(ISyncKnowledge pPrerequisiteKnowledge, 
                                                 ISyncKnowledge pTemplateKnowledge, 
                                                 ISyncKnowledge* ppProjectedKnowledge);
    HRESULT Complement(ISyncKnowledge pSyncKnowledge, ISyncKnowledge* ppComplementedKnowledge);
    HRESULT IntersectsWithKnowledge(ISyncKnowledge pSyncKnowledge);
    HRESULT GetKnowledgeCookie(IUnknown* ppKnowledgeCookie);
    HRESULT CompareToKnowledgeCookie(IUnknown pKnowledgeCookie, KNOWLEDGE_COOKIE_COMPARISON_RESULT* pResult);
}

@GUID("B37C4A0A-4B7D-4C2D-9711-3B00D119B1C8")
interface IRecoverableErrorData : IUnknown
{
    HRESULT Initialize(const(wchar)* pcszItemDisplayName, const(wchar)* pcszErrorDescription);
    HRESULT GetItemDisplayName(const(wchar)* pszItemDisplayName, uint* pcchItemDisplayName);
    HRESULT GetErrorDescription(const(wchar)* pszErrorDescription, uint* pcchErrorDescription);
}

@GUID("0F5625E8-0A7B-45EE-9637-1CE13645909E")
interface IRecoverableError : IUnknown
{
    HRESULT GetStage(SYNC_PROGRESS_STAGE* pStage);
    HRESULT GetProvider(SYNC_PROVIDER_ROLE* pProviderRole);
    HRESULT GetChangeWithRecoverableError(ISyncChange* ppChangeWithRecoverableError);
    HRESULT GetRecoverableErrorDataForChange(int* phrError, IRecoverableErrorData* ppErrorData);
    HRESULT GetRecoverableErrorDataForChangeUnit(ISyncChangeUnit pChangeUnit, int* phrError, 
                                                 IRecoverableErrorData* ppErrorData);
}

@GUID("014EBF97-9F20-4F7A-BDD4-25979C77C002")
interface IChangeConflict : IUnknown
{
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetResolveActionForChange(SYNC_RESOLVE_ACTION* pResolveAction);
    HRESULT SetResolveActionForChange(SYNC_RESOLVE_ACTION resolveAction);
    HRESULT GetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION* pResolveAction);
    HRESULT SetResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, SYNC_RESOLVE_ACTION resolveAction);
}

@GUID("00D2302E-1CF8-4835-B85F-B7CA4F799E0A")
interface IConstraintConflict : IUnknown
{
    HRESULT GetDestinationProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetSourceProviderConflictingChange(ISyncChange* ppConflictingChange);
    HRESULT GetDestinationProviderOriginalChange(ISyncChange* ppOriginalChange);
    HRESULT GetDestinationProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetSourceProviderConflictingData(IUnknown* ppConflictingData);
    HRESULT GetDestinationProviderOriginalData(IUnknown* ppOriginalData);
    HRESULT GetConstraintResolveActionForChange(__MIDL___MIDL_itf_winsync_0000_0000_0009* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChange(__MIDL___MIDL_itf_winsync_0000_0000_0009 constraintResolveAction);
    HRESULT GetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    __MIDL___MIDL_itf_winsync_0000_0000_0009* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, 
                                                    __MIDL___MIDL_itf_winsync_0000_0000_0009 constraintResolveAction);
    HRESULT GetConstraintConflictReason(__MIDL___MIDL_itf_winsync_0000_0000_0010* pConstraintConflictReason);
    HRESULT IsTemporary();
}

@GUID("0599797F-5ED9-485C-AE36-0C5D1BF2E7A5")
interface ISyncCallback : IUnknown
{
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
    HRESULT OnChange(ISyncChange pSyncChange);
    HRESULT OnConflict(IChangeConflict pConflict);
    HRESULT OnFullEnumerationNeeded(SYNC_FULL_ENUMERATION_ACTION* pFullEnumerationAction);
    HRESULT OnRecoverableError(IRecoverableError pRecoverableError);
}

@GUID("47CE84AF-7442-4EAD-8630-12015E030AD7")
interface ISyncCallback2 : ISyncCallback
{
    HRESULT OnChangeApplied(uint dwChangesApplied, uint dwChangesFailed);
    HRESULT OnChangeFailed(uint dwChangesApplied, uint dwChangesFailed);
}

@GUID("8AF3843E-75B3-438C-BB51-6F020D70D3CB")
interface ISyncConstraintCallback : IUnknown
{
    HRESULT OnConstraintConflict(IConstraintConflict pConflict);
}

@GUID("8F657056-2BCE-4A17-8C68-C7BB7898B56F")
interface ISyncProvider : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
}

@GUID("B8A940FE-9F01-483B-9434-C37D361225D9")
interface ISyncSessionState : IUnknown
{
    HRESULT IsCanceled(int* pfIsCanceled);
    HRESULT GetInfoForChangeApplication(ubyte* pbChangeApplierInfo, uint* pcbChangeApplierInfo);
    HRESULT LoadInfoFromChangeApplication(const(ubyte)* pbChangeApplierInfo, uint cbChangeApplierInfo);
    HRESULT GetForgottenKnowledgeRecoveryRangeStart(ubyte* pbRangeStart, uint* pcbRangeStart);
    HRESULT GetForgottenKnowledgeRecoveryRangeEnd(ubyte* pbRangeEnd, uint* pcbRangeEnd);
    HRESULT SetForgottenKnowledgeRecoveryRange(const(SYNC_RANGE)* pRange);
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, 
                       uint dwTotalWork);
}

@GUID("326C6810-790A-409B-B741-6999388761EB")
interface ISyncSessionExtendedErrorInfo : IUnknown
{
    HRESULT GetSyncProviderWithError(ISyncProvider* ppProviderWithError);
}

@GUID("9E37CFA3-9E38-4C61-9CA3-FFE810B45CA2")
interface ISyncSessionState2 : ISyncSessionState
{
    HRESULT SetProviderWithError(BOOL fSelf);
    HRESULT GetSessionErrorStatus(int* phrSessionError);
}

@GUID("794EAAF8-3F2E-47E6-9728-17E6FCF94CB7")
interface ISyncFilterInfo : IUnknown
{
    HRESULT Serialize(ubyte* pbBuffer, uint* pcbBuffer);
}

@GUID("19B394BA-E3D0-468C-934D-321968B2AB34")
interface ISyncFilterInfo2 : ISyncFilterInfo
{
    HRESULT GetFlags(uint* pdwFlags);
}

@GUID("F2837671-0BDF-43FA-B502-232375FB50C2")
interface IChangeUnitListFilterInfo : ISyncFilterInfo
{
    HRESULT Initialize(const(ubyte)** ppbChangeUnitIds, uint dwChangeUnitCount);
    HRESULT GetChangeUnitIdCount(uint* pdwChangeUnitIdCount);
    HRESULT GetChangeUnitId(uint dwChangeUnitIdIndex, ubyte* pbChangeUnitId, uint* pcbIdSize);
}

@GUID("087A3F15-0FCB-44C1-9639-53C14E2B5506")
interface ISyncFilter : IUnknown
{
    HRESULT IsIdentical(ISyncFilter pSyncFilter);
    HRESULT Serialize(ubyte* pbSyncFilter, uint* pcbSyncFilter);
}

@GUID("B45B7A72-E5C7-46BE-9C82-77B8B15DAB8A")
interface ISyncFilterDeserializer : IUnknown
{
    HRESULT DeserializeSyncFilter(const(ubyte)* pbSyncFilter, uint dwCbSyncFilter, ISyncFilter* ppISyncFilter);
}

@GUID("1D335DFF-6F88-4E4D-91A8-A3F351CFD473")
interface ICustomFilterInfo : ISyncFilterInfo
{
    HRESULT GetSyncFilter(ISyncFilter* pISyncFilter);
}

@GUID("11F9DE71-2818-4779-B2AC-42D450565F45")
interface ICombinedFilterInfo : ISyncFilterInfo
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterInfo(uint dwFilterIndex, ISyncFilterInfo* ppIFilterInfo);
    HRESULT GetFilterCombinationType(__MIDL___MIDL_itf_winsync_0000_0036_0001* pFilterCombinationType);
}

@GUID("5F86BE4A-5E78-4E32-AC1C-C24FD223EF85")
interface IEnumSyncChanges : IUnknown
{
    HRESULT Next(uint cChanges, ISyncChange* ppChange, uint* pcFetched);
    HRESULT Skip(uint cChanges);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncChanges* ppEnum);
}

@GUID("56F14771-8677-484F-A170-E386E418A676")
interface ISyncChangeBuilder : IUnknown
{
    HRESULT AddChangeUnitMetadata(const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pChangeUnitVersion);
}

@GUID("295024A0-70DA-4C58-883C-CE2AFB308D0B")
interface IFilterTrackingSyncChangeBuilder : IUnknown
{
    HRESULT AddFilterChange(uint dwFilterKey, const(SYNC_FILTER_CHANGE)* pFilterChange);
    HRESULT SetAllChangeUnitsPresentFlag();
}

@GUID("52F6E694-6A71-4494-A184-A8311BF5D227")
interface ISyncChangeBatchBase : IUnknown
{
    HRESULT GetChangeEnumerator(IEnumSyncChanges* ppEnum);
    HRESULT GetIsLastBatch(int* pfLastBatch);
    HRESULT GetWorkEstimateForBatch(uint* pdwWorkForBatch);
    HRESULT GetRemainingWorkEstimateForSession(uint* pdwRemainingWorkForSession);
    HRESULT BeginOrderedGroup(const(ubyte)* pbLowerBound);
    HRESULT EndOrderedGroup(const(ubyte)* pbUpperBound, ISyncKnowledge pMadeWithKnowledge);
    HRESULT AddItemMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                                   const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                                   uint dwFlags, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisteKnowledge);
    HRESULT GetSourceForgottenKnowledge(IForgottenKnowledge* ppSourceForgottenKnowledge);
    HRESULT SetLastBatch();
    HRESULT SetWorkEstimateForBatch(uint dwWorkForBatch);
    HRESULT SetRemainingWorkEstimateForSession(uint dwRemainingWorkForSession);
    HRESULT Serialize(ubyte* pbChangeBatch, uint* pcbChangeBatch);
}

@GUID("70C64DEE-380F-4C2E-8F70-31C55BD5F9B3")
interface ISyncChangeBatch : ISyncChangeBatchBase
{
    HRESULT BeginUnorderedGroup();
    HRESULT EndUnorderedGroup(ISyncKnowledge pMadeWithKnowledge, BOOL fAllChangesForKnowledge);
    HRESULT AddLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, 
                              const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, 
                              uint dwFlags, uint dwWorkForChange, ISyncKnowledge pConflictKnowledge, 
                              ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("EF64197D-4F44-4EA2-B355-4524713E3BED")
interface ISyncFullEnumerationChangeBatch : ISyncChangeBatchBase
{
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledgeAfterRecoveryComplete);
    HRESULT GetClosedLowerBoundItemId(ubyte* pbClosedLowerBoundItemId, uint* pcbIdSize);
    HRESULT GetClosedUpperBoundItemId(ubyte* pbClosedUpperBoundItemId, uint* pcbIdSize);
}

@GUID("097F13BE-5B92-4048-B3F2-7B42A2515E07")
interface ISyncChangeBatchWithPrerequisite : ISyncChangeBatchBase
{
    HRESULT SetPrerequisiteKnowledge(ISyncKnowledge pPrerequisiteKnowledge);
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedWithPrerequisiteKnowledge);
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

@GUID("6FDB596A-D755-4584-BD0C-C0C23A548FBF")
interface ISyncChangeBatchBase2 : ISyncChangeBatchBase
{
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, 
                                 uint* pdwSerializedSize);
}

@GUID("0F1A4995-CBC8-421D-B550-5D0BEBF3E9A5")
interface ISyncChangeBatchAdvanced : IUnknown
{
    HRESULT GetFilterInfo(ISyncFilterInfo* ppFilterInfo);
    HRESULT ConvertFullEnumerationChangeBatchToRegularChangeBatch(ISyncChangeBatch* ppChangeBatch);
    HRESULT GetUpperBoundItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetBatchLevelKnowledgeShouldBeApplied(int* pfBatchKnowledgeShouldBeApplied);
}

@GUID("225F4A33-F5EE-4CC7-B039-67A262B4B2AC")
interface ISyncChangeBatch2 : ISyncChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
    HRESULT AddMergeTombstoneLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                            const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                            const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                            ISyncKnowledge pConflictKnowledge, ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("E06449F4-A205-4B65-9724-01B22101EEC1")
interface ISyncFullEnumerationChangeBatch2 : ISyncFullEnumerationChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, 
                                             const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, 
                                             const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, 
                                             ISyncChangeBuilder* ppChangeBuilder);
}

@GUID("43434A49-8DA4-47F2-8172-AD7B8B024978")
interface IKnowledgeSyncProvider : ISyncProvider
{
    HRESULT BeginSession(SYNC_PROVIDER_ROLE role, ISyncSessionState pSessionState);
    HRESULT GetSyncBatchParameters(ISyncKnowledge* ppSyncKnowledge, uint* pdwRequestedBatchSize);
    HRESULT GetChangeBatch(uint dwBatchSize, ISyncKnowledge pSyncKnowledge, ISyncChangeBatch* ppSyncChangeBatch, 
                           IUnknown* ppUnkDataRetriever);
    HRESULT GetFullEnumerationChangeBatch(uint dwBatchSize, const(ubyte)* pbLowerEnumerationBound, 
                                          ISyncKnowledge pSyncKnowledge, 
                                          ISyncFullEnumerationChangeBatch* ppSyncChangeBatch, 
                                          IUnknown* ppUnkDataRetriever);
    HRESULT ProcessChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, ISyncChangeBatch pSourceChangeBatch, 
                               IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                               SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    HRESULT ProcessFullEnumerationChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, 
                                              ISyncFullEnumerationChangeBatch pSourceChangeBatch, 
                                              IUnknown pUnkDataRetriever, ISyncCallback pCallback, 
                                              SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    HRESULT EndSession(ISyncSessionState pSessionState);
}

@GUID("60EDD8CA-7341-4BB7-95CE-FAB6394B51CB")
interface ISyncChangeUnit : IUnknown
{
    HRESULT GetItemChange(ISyncChange* ppSyncChange);
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    HRESULT GetChangeUnitVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
}

@GUID("346B35F1-8703-4C6D-AB1A-4DBCA2CFF97F")
interface IEnumSyncChangeUnits : IUnknown
{
    HRESULT Next(uint cChanges, ISyncChangeUnit* ppChangeUnit, uint* pcFetched);
    HRESULT Skip(uint cChanges);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncChangeUnits* ppEnum);
}

@GUID("A1952BEB-0F6B-4711-B136-01DA85B968A6")
interface ISyncChange : IUnknown
{
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    HRESULT GetRootItemId(ubyte* pbRootItemId, uint* pcbIdSize);
    HRESULT GetChangeVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    HRESULT GetCreationVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT GetWorkEstimate(uint* pdwWork);
    HRESULT GetChangeUnits(IEnumSyncChangeUnits* ppEnum);
    HRESULT GetMadeWithKnowledge(ISyncKnowledge* ppMadeWithKnowledge);
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    HRESULT SetWorkEstimate(uint dwWork);
}

@GUID("9E38382F-1589-48C3-92E4-05ECDCB4F3F7")
interface ISyncChangeWithPrerequisite : IUnknown
{
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisiteKnowledge);
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, 
                                                ISyncKnowledge* ppLearnedKnowledgeWithPrerequisite);
}

@GUID("9785E0BD-BDFF-40C4-98C5-B34B2F1991B3")
interface ISyncFullEnumerationChange : IUnknown
{
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

@GUID("6EC62597-0903-484C-AD61-36D6E938F47B")
interface ISyncMergeTombstoneChange : IUnknown
{
    HRESULT GetWinnerItemId(ubyte* pbWinnerItemId, uint* pcbIdSize);
}

@GUID("43AA3F61-4B2E-4B60-83DF-B110D3E148F1")
interface IEnumItemIds : IUnknown
{
    HRESULT Next(ubyte* pbItemId, uint* pcbItemIdSize);
}

@GUID("CA169652-07C6-4708-A3DA-6E4EBA8D2297")
interface IFilterKeyMap : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT AddFilter(ISyncFilter pISyncFilter, uint* pdwFilterKey);
    HRESULT GetFilter(uint dwFilterKey, ISyncFilter* ppISyncFilter);
    HRESULT Serialize(ubyte* pbFilterKeyMap, uint* pcbFilterKeyMap);
}

@GUID("BFE1EF00-E87D-42FD-A4E9-242D70414AEF")
interface ISyncChangeWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterChange(uint dwFilterKey, SYNC_FILTER_CHANGE* pFilterChange);
    HRESULT GetAllChangeUnitsPresentFlag(int* pfAllChangeUnitsPresent);
    HRESULT GetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge* ppIFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

@GUID("DE247002-566D-459A-A6ED-A5AAB3459FB7")
interface ISyncChangeBatchWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterKeyMap(IFilterKeyMap* ppIFilterKeyMap);
    HRESULT SetFilterKeyMap(IFilterKeyMap pIFilterKeyMap);
    HRESULT SetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge pFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, 
                                               uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, 
                                                        IEnumItemIds pNewMoveins, 
                                                        ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                             IEnumItemIds pNewMoveins, 
                                                                             ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, 
                                                                    IEnumItemIds pNewMoveins, uint dwFilterKey, 
                                                                    ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

@GUID("71B4863B-F969-4676-BBC3-3D9FDC3FB2C7")
interface IDataRetrieverCallback : IUnknown
{
    HRESULT LoadChangeDataComplete(IUnknown pUnkData);
    HRESULT LoadChangeDataError(HRESULT hrError);
}

@GUID("44A4AACA-EC39-46D5-B5C9-D633C0EE67E2")
interface ILoadChangeContext : IUnknown
{
    HRESULT GetSyncChange(ISyncChange* ppSyncChange);
    HRESULT SetRecoverableErrorOnChange(HRESULT hrError, IRecoverableErrorData pErrorData);
    HRESULT SetRecoverableErrorOnChangeUnit(HRESULT hrError, ISyncChangeUnit pChangeUnit, 
                                            IRecoverableErrorData pErrorData);
}

@GUID("9B22F2A9-A4CD-4648-9D8E-3A510D4DA04B")
interface ISynchronousDataRetriever : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext, IUnknown* ppUnkData);
}

@GUID("9FC7E470-61EA-4A88-9BE4-DF56A27CFEF2")
interface IAsynchronousDataRetriever : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT RegisterCallback(IDataRetrieverCallback pDataRetrieverCallback);
    HRESULT RevokeCallback(IDataRetrieverCallback pDataRetrieverCallback);
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext);
}

@GUID("82DF8873-6360-463A-A8A1-EDE5E1A1594D")
interface IFilterRequestCallback : IUnknown
{
    HRESULT RequestFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

@GUID("2E020184-6D18-46A7-A32A-DA4AEB06696C")
interface IRequestFilteredSync : IUnknown
{
    HRESULT SpecifyFilter(IFilterRequestCallback pCallback);
}

@GUID("3D128DED-D555-4E0D-BF4B-FB213A8A9302")
interface ISupportFilteredSync : IUnknown
{
    HRESULT AddFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

@GUID("713CA7BB-C858-4674-B4B6-1122436587A9")
interface IFilterTrackingRequestCallback : IUnknown
{
    HRESULT RequestTrackedFilter(ISyncFilter pFilter);
}

@GUID("743383C0-FC4E-45BA-AD81-D9D84C7A24F8")
interface IFilterTrackingProvider : IUnknown
{
    HRESULT SpecifyTrackedFilters(IFilterTrackingRequestCallback pCallback);
    HRESULT AddTrackedFilter(ISyncFilter pFilter);
}

@GUID("EADF816F-D0BD-43CA-8F40-5ACDC6C06F7A")
interface ISupportLastWriteTime : IUnknown
{
    HRESULT GetItemChangeTime(const(ubyte)* pbItemId, ulong* pullTimestamp);
    HRESULT GetChangeUnitChangeTime(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, ulong* pullTimestamp);
}

@GUID("809B7276-98CF-4957-93A5-0EBDD3DDDFFD")
interface IProviderConverter : IUnknown
{
    HRESULT Initialize(ISyncProvider pISyncProvider);
}

@GUID("435D4861-68D5-44AA-A0F9-72A0B00EF9CF")
interface ISyncDataConverter : IUnknown
{
    HRESULT ConvertDataRetrieverFromProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                   IUnknown* ppUnkDataOut);
    HRESULT ConvertDataRetrieverToProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, 
                                                 IUnknown* ppUnkDataOut);
    HRESULT ConvertDataFromProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataIn, 
                                          IUnknown* ppUnkDataOut);
    HRESULT ConvertDataToProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataOut, 
                                        IUnknown* ppUnkDataout);
}

@GUID("CB45953B-7624-47BC-A472-EB8CAC6B222E")
interface ISyncProviderRegistration : IUnknown
{
    HRESULT CreateSyncProviderConfigUIRegistrationInstance(const(SyncProviderConfigUIConfiguration)* pConfigUIConfig, 
                                                           ISyncProviderConfigUIInfo* ppConfigUIInfo);
    HRESULT UnregisterSyncProviderConfigUI(GUID* pguidInstanceId);
    HRESULT EnumerateSyncProviderConfigUIs(GUID* pguidContentType, uint dwSupportedArchitecture, 
                                           IEnumSyncProviderConfigUIInfos* ppEnumSyncProviderConfigUIInfos);
    HRESULT CreateSyncProviderRegistrationInstance(const(SyncProviderConfiguration)* pProviderConfiguration, 
                                                   ISyncProviderInfo* ppProviderInfo);
    HRESULT UnregisterSyncProvider(GUID* pguidInstanceId);
    HRESULT GetSyncProviderConfigUIInfoforProvider(GUID* pguidProviderInstanceId, 
                                                   ISyncProviderConfigUIInfo* ppProviderConfigUIInfo);
    HRESULT EnumerateSyncProviders(GUID* pguidContentType, uint dwStateFlagsToFilterMask, 
                                   uint dwStateFlagsToFilter, const(GUID)* refProviderClsId, 
                                   uint dwSupportedArchitecture, IEnumSyncProviderInfos* ppEnumSyncProviderInfos);
    HRESULT GetSyncProviderInfo(GUID* pguidInstanceId, ISyncProviderInfo* ppProviderInfo);
    HRESULT GetSyncProviderFromInstanceId(GUID* pguidInstanceId, uint dwClsContext, 
                                          IRegisteredSyncProvider* ppSyncProvider);
    HRESULT GetSyncProviderConfigUIInfo(GUID* pguidInstanceId, ISyncProviderConfigUIInfo* ppConfigUIInfo);
    HRESULT GetSyncProviderConfigUIFromInstanceId(GUID* pguidInstanceId, uint dwClsContext, 
                                                  ISyncProviderConfigUI* ppConfigUI);
    HRESULT GetSyncProviderState(GUID* pguidInstanceId, uint* pdwStateFlags);
    HRESULT SetSyncProviderState(GUID* pguidInstanceId, uint dwStateFlagsMask, uint dwStateFlags);
    HRESULT RegisterForEvent(HANDLE* phEvent);
    HRESULT RevokeEvent(HANDLE hEvent);
    HRESULT GetChange(HANDLE hEvent, ISyncRegistrationChange* ppChange);
}

@GUID("F6BE2602-17C6-4658-A2D7-68ED3330F641")
interface IEnumSyncProviderConfigUIInfos : IUnknown
{
    HRESULT Next(uint cFactories, char* ppSyncProviderConfigUIInfo, uint* pcFetched);
    HRESULT Skip(uint cFactories);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncProviderConfigUIInfos* ppEnum);
}

@GUID("A04BA850-5EB1-460D-A973-393FCB608A11")
interface IEnumSyncProviderInfos : IUnknown
{
    HRESULT Next(uint cInstances, char* ppSyncProviderInfo, uint* pcFetched);
    HRESULT Skip(uint cInstances);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncProviderInfos* ppEnum);
}

@GUID("1EE135DE-88A4-4504-B0D0-F7920D7E5BA6")
interface ISyncProviderInfo : IPropertyStore
{
    HRESULT GetSyncProvider(uint dwClsContext, IRegisteredSyncProvider* ppSyncProvider);
}

@GUID("214141AE-33D7-4D8D-8E37-F227E880CE50")
interface ISyncProviderConfigUIInfo : IPropertyStore
{
    HRESULT GetSyncProviderConfigUI(uint dwClsContext, ISyncProviderConfigUI* ppSyncProviderConfigUI);
}

@GUID("7B0705F6-CBCD-4071-AB05-3BDC364D4A0C")
interface ISyncProviderConfigUI : IUnknown
{
    HRESULT Init(GUID* pguidInstanceId, GUID* pguidContentType, IPropertyStore pConfigurationProperties);
    HRESULT GetRegisteredProperties(IPropertyStore* ppConfigUIProperties);
    HRESULT CreateAndRegisterNewSyncProvider(HWND hwndParent, IUnknown pUnkContext, 
                                             ISyncProviderInfo* ppProviderInfo);
    HRESULT ModifySyncProvider(HWND hwndParent, IUnknown pUnkContext, ISyncProviderInfo pProviderInfo);
}

@GUID("913BCF76-47C1-40B5-A896-5E8A9C414C14")
interface IRegisteredSyncProvider : IUnknown
{
    HRESULT Init(GUID* pguidInstanceId, GUID* pguidContentType, IPropertyStore pContextPropertyStore);
    HRESULT GetInstanceId(GUID* pguidInstanceId);
    HRESULT Reset();
}

@GUID("EEA0D9AE-6B29-43B4-9E70-E3AE33BB2C3B")
interface ISyncRegistrationChange : IUnknown
{
    HRESULT GetEvent(SYNC_REGISTRATION_EVENT* psreEvent);
    HRESULT GetInstanceId(GUID* pguidInstanceId);
}


// GUIDs

const GUID CLSID_SyncProviderRegistration = GUIDOF!SyncProviderRegistration;

const GUID IID_IAsynchronousDataRetriever       = GUIDOF!IAsynchronousDataRetriever;
const GUID IID_IChangeConflict                  = GUIDOF!IChangeConflict;
const GUID IID_IChangeUnitException             = GUIDOF!IChangeUnitException;
const GUID IID_IChangeUnitListFilterInfo        = GUIDOF!IChangeUnitListFilterInfo;
const GUID IID_IClockVector                     = GUIDOF!IClockVector;
const GUID IID_IClockVectorElement              = GUIDOF!IClockVectorElement;
const GUID IID_ICombinedFilterInfo              = GUIDOF!ICombinedFilterInfo;
const GUID IID_IConstraintConflict              = GUIDOF!IConstraintConflict;
const GUID IID_IConstructReplicaKeyMap          = GUIDOF!IConstructReplicaKeyMap;
const GUID IID_ICoreFragment                    = GUIDOF!ICoreFragment;
const GUID IID_ICoreFragmentInspector           = GUIDOF!ICoreFragmentInspector;
const GUID IID_ICustomFilterInfo                = GUIDOF!ICustomFilterInfo;
const GUID IID_IDataRetrieverCallback           = GUIDOF!IDataRetrieverCallback;
const GUID IID_IEnumChangeUnitExceptions        = GUIDOF!IEnumChangeUnitExceptions;
const GUID IID_IEnumClockVector                 = GUIDOF!IEnumClockVector;
const GUID IID_IEnumFeedClockVector             = GUIDOF!IEnumFeedClockVector;
const GUID IID_IEnumItemIds                     = GUIDOF!IEnumItemIds;
const GUID IID_IEnumRangeExceptions             = GUIDOF!IEnumRangeExceptions;
const GUID IID_IEnumSingleItemExceptions        = GUIDOF!IEnumSingleItemExceptions;
const GUID IID_IEnumSyncChangeUnits             = GUIDOF!IEnumSyncChangeUnits;
const GUID IID_IEnumSyncChanges                 = GUIDOF!IEnumSyncChanges;
const GUID IID_IEnumSyncProviderConfigUIInfos   = GUIDOF!IEnumSyncProviderConfigUIInfos;
const GUID IID_IEnumSyncProviderInfos           = GUIDOF!IEnumSyncProviderInfos;
const GUID IID_IFeedClockVector                 = GUIDOF!IFeedClockVector;
const GUID IID_IFeedClockVectorElement          = GUIDOF!IFeedClockVectorElement;
const GUID IID_IFilterKeyMap                    = GUIDOF!IFilterKeyMap;
const GUID IID_IFilterRequestCallback           = GUIDOF!IFilterRequestCallback;
const GUID IID_IFilterTrackingProvider          = GUIDOF!IFilterTrackingProvider;
const GUID IID_IFilterTrackingRequestCallback   = GUIDOF!IFilterTrackingRequestCallback;
const GUID IID_IFilterTrackingSyncChangeBuilder = GUIDOF!IFilterTrackingSyncChangeBuilder;
const GUID IID_IForgottenKnowledge              = GUIDOF!IForgottenKnowledge;
const GUID IID_IKnowledgeSyncProvider           = GUIDOF!IKnowledgeSyncProvider;
const GUID IID_ILoadChangeContext               = GUIDOF!ILoadChangeContext;
const GUID IID_IProviderConverter               = GUIDOF!IProviderConverter;
const GUID IID_IRangeException                  = GUIDOF!IRangeException;
const GUID IID_IRecoverableError                = GUIDOF!IRecoverableError;
const GUID IID_IRecoverableErrorData            = GUIDOF!IRecoverableErrorData;
const GUID IID_IRegisteredSyncProvider          = GUIDOF!IRegisteredSyncProvider;
const GUID IID_IReplicaKeyMap                   = GUIDOF!IReplicaKeyMap;
const GUID IID_IRequestFilteredSync             = GUIDOF!IRequestFilteredSync;
const GUID IID_ISingleItemException             = GUIDOF!ISingleItemException;
const GUID IID_ISupportFilteredSync             = GUIDOF!ISupportFilteredSync;
const GUID IID_ISupportLastWriteTime            = GUIDOF!ISupportLastWriteTime;
const GUID IID_ISyncCallback                    = GUIDOF!ISyncCallback;
const GUID IID_ISyncCallback2                   = GUIDOF!ISyncCallback2;
const GUID IID_ISyncChange                      = GUIDOF!ISyncChange;
const GUID IID_ISyncChangeBatch                 = GUIDOF!ISyncChangeBatch;
const GUID IID_ISyncChangeBatch2                = GUIDOF!ISyncChangeBatch2;
const GUID IID_ISyncChangeBatchAdvanced         = GUIDOF!ISyncChangeBatchAdvanced;
const GUID IID_ISyncChangeBatchBase             = GUIDOF!ISyncChangeBatchBase;
const GUID IID_ISyncChangeBatchBase2            = GUIDOF!ISyncChangeBatchBase2;
const GUID IID_ISyncChangeBatchWithFilterKeyMap = GUIDOF!ISyncChangeBatchWithFilterKeyMap;
const GUID IID_ISyncChangeBatchWithPrerequisite = GUIDOF!ISyncChangeBatchWithPrerequisite;
const GUID IID_ISyncChangeBuilder               = GUIDOF!ISyncChangeBuilder;
const GUID IID_ISyncChangeUnit                  = GUIDOF!ISyncChangeUnit;
const GUID IID_ISyncChangeWithFilterKeyMap      = GUIDOF!ISyncChangeWithFilterKeyMap;
const GUID IID_ISyncChangeWithPrerequisite      = GUIDOF!ISyncChangeWithPrerequisite;
const GUID IID_ISyncConstraintCallback          = GUIDOF!ISyncConstraintCallback;
const GUID IID_ISyncDataConverter               = GUIDOF!ISyncDataConverter;
const GUID IID_ISyncFilter                      = GUIDOF!ISyncFilter;
const GUID IID_ISyncFilterDeserializer          = GUIDOF!ISyncFilterDeserializer;
const GUID IID_ISyncFilterInfo                  = GUIDOF!ISyncFilterInfo;
const GUID IID_ISyncFilterInfo2                 = GUIDOF!ISyncFilterInfo2;
const GUID IID_ISyncFullEnumerationChange       = GUIDOF!ISyncFullEnumerationChange;
const GUID IID_ISyncFullEnumerationChangeBatch  = GUIDOF!ISyncFullEnumerationChangeBatch;
const GUID IID_ISyncFullEnumerationChangeBatch2 = GUIDOF!ISyncFullEnumerationChangeBatch2;
const GUID IID_ISyncKnowledge                   = GUIDOF!ISyncKnowledge;
const GUID IID_ISyncKnowledge2                  = GUIDOF!ISyncKnowledge2;
const GUID IID_ISyncMergeTombstoneChange        = GUIDOF!ISyncMergeTombstoneChange;
const GUID IID_ISyncProvider                    = GUIDOF!ISyncProvider;
const GUID IID_ISyncProviderConfigUI            = GUIDOF!ISyncProviderConfigUI;
const GUID IID_ISyncProviderConfigUIInfo        = GUIDOF!ISyncProviderConfigUIInfo;
const GUID IID_ISyncProviderInfo                = GUIDOF!ISyncProviderInfo;
const GUID IID_ISyncProviderRegistration        = GUIDOF!ISyncProviderRegistration;
const GUID IID_ISyncRegistrationChange          = GUIDOF!ISyncRegistrationChange;
const GUID IID_ISyncSessionExtendedErrorInfo    = GUIDOF!ISyncSessionExtendedErrorInfo;
const GUID IID_ISyncSessionState                = GUIDOF!ISyncSessionState;
const GUID IID_ISyncSessionState2               = GUIDOF!ISyncSessionState2;
const GUID IID_ISynchronousDataRetriever        = GUIDOF!ISynchronousDataRetriever;
