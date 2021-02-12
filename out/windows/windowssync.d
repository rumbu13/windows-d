module windows.windowssync;

public import system;
public import windows.audio;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct ID_PARAMETER_PAIR
{
    BOOL fIsVariable;
    ushort cbIdSize;
}

struct ID_PARAMETERS
{
    uint dwSize;
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
    uint dwLastUpdatingReplicaKey;
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
    BOOL fMoveIn;
    SYNC_VERSION moveVersion;
}

enum SYNC_PROVIDER_ROLE
{
    SPR_SOURCE = 0,
    SPR_DESTINATION = 1,
}

enum CONFLICT_RESOLUTION_POLICY
{
    CRP_NONE = 0,
    CRP_DESTINATION_PROVIDER_WINS = 1,
    CRP_SOURCE_PROVIDER_WINS = 2,
    CRP_LAST = 3,
}

enum SYNC_PROGRESS_STAGE
{
    SPS_CHANGE_DETECTION = 0,
    SPS_CHANGE_ENUMERATION = 1,
    SPS_CHANGE_APPLICATION = 2,
}

enum SYNC_FULL_ENUMERATION_ACTION
{
    SFEA_FULL_ENUMERATION = 0,
    SFEA_PARTIAL_SYNC = 1,
    SFEA_ABORT = 2,
}

enum SYNC_RESOLVE_ACTION
{
    SRA_DEFER = 0,
    SRA_ACCEPT_DESTINATION_PROVIDER = 1,
    SRA_ACCEPT_SOURCE_PROVIDER = 2,
    SRA_MERGE = 3,
    SRA_TRANSFER_AND_DEFER = 4,
    SRA_LAST = 5,
}

enum SYNC_STATISTICS
{
    SYNC_STATISTICS_RANGE_COUNT = 0,
}

enum SYNC_SERIALIZATION_VERSION
{
    SYNC_SERIALIZATION_VERSION_V1 = 1,
    SYNC_SERIALIZATION_VERSION_V2 = 4,
    SYNC_SERIALIZATION_VERSION_V3 = 5,
}

enum FILTERING_TYPE
{
    FT_CURRENT_ITEMS_ONLY = 0,
    FT_CURRENT_ITEMS_AND_VERSIONS_FOR_MOVED_OUT_ITEMS = 1,
}

enum __MIDL___MIDL_itf_winsync_0000_0000_0009
{
    SCRA_DEFER = 0,
    SCRA_ACCEPT_DESTINATION_PROVIDER = 1,
    SCRA_ACCEPT_SOURCE_PROVIDER = 2,
    SCRA_TRANSFER_AND_DEFER = 3,
    SCRA_MERGE = 4,
    SCRA_RENAME_SOURCE = 5,
    SCRA_RENAME_DESTINATION = 6,
}

enum __MIDL___MIDL_itf_winsync_0000_0000_0010
{
    CCR_OTHER = 0,
    CCR_COLLISION = 1,
    CCR_NOPARENT = 2,
    CCR_IDENTITY = 3,
}

enum KNOWLEDGE_COOKIE_COMPARISON_RESULT
{
    KCCR_COOKIE_KNOWLEDGE_EQUAL = 0,
    KCCR_COOKIE_KNOWLEDGE_CONTAINED = 1,
    KCCR_COOKIE_KNOWLEDGE_CONTAINS = 2,
    KCCR_COOKIE_KNOWLEDGE_NOT_COMPARABLE = 3,
}

const GUID IID_IClockVectorElement = {0xE71C4250, 0xADF8, 0x4A07, [0x8F, 0xAE, 0x56, 0x69, 0x59, 0x69, 0x09, 0xC1]};
@GUID(0xE71C4250, 0xADF8, 0x4A07, [0x8F, 0xAE, 0x56, 0x69, 0x59, 0x69, 0x09, 0xC1]);
interface IClockVectorElement : IUnknown
{
    HRESULT GetReplicaKey(uint* pdwReplicaKey);
    HRESULT GetTickCount(ulong* pullTickCount);
}

const GUID IID_IFeedClockVectorElement = {0xA40B46D2, 0xE97B, 0x4156, [0xB6, 0xDA, 0x99, 0x1F, 0x50, 0x1B, 0x0F, 0x05]};
@GUID(0xA40B46D2, 0xE97B, 0x4156, [0xB6, 0xDA, 0x99, 0x1F, 0x50, 0x1B, 0x0F, 0x05]);
interface IFeedClockVectorElement : IClockVectorElement
{
    HRESULT GetSyncTime(SYNC_TIME* pSyncTime);
    HRESULT GetFlags(ubyte* pbFlags);
}

const GUID IID_IClockVector = {0x14B2274A, 0x8698, 0x4CC6, [0x93, 0x33, 0xF8, 0x9B, 0xD1, 0xD4, 0x7B, 0xC4]};
@GUID(0x14B2274A, 0x8698, 0x4CC6, [0x93, 0x33, 0xF8, 0x9B, 0xD1, 0xD4, 0x7B, 0xC4]);
interface IClockVector : IUnknown
{
    HRESULT GetClockVectorElements(const(Guid)* riid, void** ppiEnumClockVector);
    HRESULT GetClockVectorElementCount(uint* pdwCount);
}

const GUID IID_IFeedClockVector = {0x8D1D98D1, 0x9FB8, 0x4EC9, [0xA5, 0x53, 0x54, 0xDD, 0x92, 0x4E, 0x0F, 0x67]};
@GUID(0x8D1D98D1, 0x9FB8, 0x4EC9, [0xA5, 0x53, 0x54, 0xDD, 0x92, 0x4E, 0x0F, 0x67]);
interface IFeedClockVector : IClockVector
{
    HRESULT GetUpdateCount(uint* pdwUpdateCount);
    HRESULT IsNoConflictsSpecified(int* pfIsNoConflictsSpecified);
}

const GUID IID_IEnumClockVector = {0x525844DB, 0x2837, 0x4799, [0x9E, 0x80, 0x81, 0xA6, 0x6E, 0x02, 0x22, 0x0C]};
@GUID(0x525844DB, 0x2837, 0x4799, [0x9E, 0x80, 0x81, 0xA6, 0x6E, 0x02, 0x22, 0x0C]);
interface IEnumClockVector : IUnknown
{
    HRESULT Next(uint cClockVectorElements, IClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    HRESULT Skip(uint cSyncVersions);
    HRESULT Reset();
    HRESULT Clone(IEnumClockVector* ppiEnum);
}

const GUID IID_IEnumFeedClockVector = {0x550F763D, 0x146A, 0x48F6, [0xAB, 0xEB, 0x6C, 0x88, 0xC7, 0xF7, 0x05, 0x14]};
@GUID(0x550F763D, 0x146A, 0x48F6, [0xAB, 0xEB, 0x6C, 0x88, 0xC7, 0xF7, 0x05, 0x14]);
interface IEnumFeedClockVector : IUnknown
{
    HRESULT Next(uint cClockVectorElements, IFeedClockVectorElement* ppiClockVectorElements, uint* pcFetched);
    HRESULT Skip(uint cSyncVersions);
    HRESULT Reset();
    HRESULT Clone(IEnumFeedClockVector* ppiEnum);
}

const GUID IID_ICoreFragment = {0x613B2AB5, 0xB304, 0x47D9, [0x9C, 0x31, 0xCE, 0x6C, 0x54, 0x40, 0x1A, 0x15]};
@GUID(0x613B2AB5, 0xB304, 0x47D9, [0x9C, 0x31, 0xCE, 0x6C, 0x54, 0x40, 0x1A, 0x15]);
interface ICoreFragment : IUnknown
{
    HRESULT NextColumn(ubyte* pChangeUnitId, uint* pChangeUnitIdSize);
    HRESULT NextRange(ubyte* pItemId, uint* pItemIdSize, IClockVector* piClockVector);
    HRESULT Reset();
    HRESULT GetColumnCount(uint* pColumnCount);
    HRESULT GetRangeCount(uint* pRangeCount);
}

const GUID IID_ICoreFragmentInspector = {0xF7FCC5FD, 0xAE26, 0x4679, [0xBA, 0x16, 0x96, 0xAA, 0xC5, 0x83, 0xC1, 0x34]};
@GUID(0xF7FCC5FD, 0xAE26, 0x4679, [0xBA, 0x16, 0x96, 0xAA, 0xC5, 0x83, 0xC1, 0x34]);
interface ICoreFragmentInspector : IUnknown
{
    HRESULT NextCoreFragments(uint requestedCount, ICoreFragment* ppiCoreFragments, uint* pFetchedCount);
    HRESULT Reset();
}

const GUID IID_IRangeException = {0x75AE8777, 0x6848, 0x49F7, [0x95, 0x6C, 0xA3, 0xA9, 0x2F, 0x50, 0x96, 0xE8]};
@GUID(0x75AE8777, 0x6848, 0x49F7, [0x95, 0x6C, 0xA3, 0xA9, 0x2F, 0x50, 0x96, 0xE8]);
interface IRangeException : IUnknown
{
    HRESULT GetClosedRangeStart(ubyte* pbClosedRangeStart, uint* pcbIdSize);
    HRESULT GetClosedRangeEnd(ubyte* pbClosedRangeEnd, uint* pcbIdSize);
    HRESULT GetClockVector(const(Guid)* riid, void** ppUnk);
}

const GUID IID_IEnumRangeExceptions = {0x0944439F, 0xDDB1, 0x4176, [0xB7, 0x03, 0x04, 0x6F, 0xF2, 0x2A, 0x23, 0x86]};
@GUID(0x0944439F, 0xDDB1, 0x4176, [0xB7, 0x03, 0x04, 0x6F, 0xF2, 0x2A, 0x23, 0x86]);
interface IEnumRangeExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, IRangeException* ppRangeException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumRangeExceptions* ppEnum);
}

const GUID IID_ISingleItemException = {0x892FB9B0, 0x7C55, 0x4A18, [0x93, 0x16, 0xFD, 0xF4, 0x49, 0x56, 0x9B, 0x64]};
@GUID(0x892FB9B0, 0x7C55, 0x4A18, [0x93, 0x16, 0xFD, 0xF4, 0x49, 0x56, 0x9B, 0x64]);
interface ISingleItemException : IUnknown
{
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetClockVector(const(Guid)* riid, void** ppUnk);
}

const GUID IID_IEnumSingleItemExceptions = {0xE563381C, 0x1B4D, 0x4C66, [0x97, 0x96, 0xC8, 0x6F, 0xAC, 0xCD, 0xCD, 0x40]};
@GUID(0xE563381C, 0x1B4D, 0x4C66, [0x97, 0x96, 0xC8, 0x6F, 0xAC, 0xCD, 0xCD, 0x40]);
interface IEnumSingleItemExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, ISingleItemException* ppSingleItemException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumSingleItemExceptions* ppEnum);
}

const GUID IID_IChangeUnitException = {0x0CD7EE7C, 0xFEC0, 0x4021, [0x99, 0xEE, 0xF0, 0xE5, 0x34, 0x8F, 0x2A, 0x5F]};
@GUID(0x0CD7EE7C, 0xFEC0, 0x4021, [0x99, 0xEE, 0xF0, 0xE5, 0x34, 0x8F, 0x2A, 0x5F]);
interface IChangeUnitException : IUnknown
{
    HRESULT GetItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    HRESULT GetClockVector(const(Guid)* riid, void** ppUnk);
}

const GUID IID_IEnumChangeUnitExceptions = {0x3074E802, 0x9319, 0x4420, [0xBE, 0x21, 0x10, 0x22, 0xE2, 0xE2, 0x1D, 0xA8]};
@GUID(0x3074E802, 0x9319, 0x4420, [0xBE, 0x21, 0x10, 0x22, 0xE2, 0xE2, 0x1D, 0xA8]);
interface IEnumChangeUnitExceptions : IUnknown
{
    HRESULT Next(uint cExceptions, IChangeUnitException* ppChangeUnitException, uint* pcFetched);
    HRESULT Skip(uint cExceptions);
    HRESULT Reset();
    HRESULT Clone(IEnumChangeUnitExceptions* ppEnum);
}

const GUID IID_IReplicaKeyMap = {0x2209F4FC, 0xFD10, 0x4FF0, [0x84, 0xA8, 0xF0, 0xA1, 0x98, 0x2E, 0x44, 0x0E]};
@GUID(0x2209F4FC, 0xFD10, 0x4FF0, [0x84, 0xA8, 0xF0, 0xA1, 0x98, 0x2E, 0x44, 0x0E]);
interface IReplicaKeyMap : IUnknown
{
    HRESULT LookupReplicaKey(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
    HRESULT LookupReplicaId(uint dwReplicaKey, ubyte* pbReplicaId, uint* pcbIdSize);
    HRESULT Serialize(ubyte* pbReplicaKeyMap, uint* pcbReplicaKeyMap);
}

const GUID IID_IConstructReplicaKeyMap = {0xDED10970, 0xEC85, 0x4115, [0xB5, 0x2C, 0x44, 0x05, 0x84, 0x56, 0x42, 0xA5]};
@GUID(0xDED10970, 0xEC85, 0x4115, [0xB5, 0x2C, 0x44, 0x05, 0x84, 0x56, 0x42, 0xA5]);
interface IConstructReplicaKeyMap : IUnknown
{
    HRESULT FindOrAddReplica(const(ubyte)* pbReplicaId, uint* pdwReplicaKey);
}

const GUID IID_ISyncKnowledge = {0x615BBB53, 0xC945, 0x4203, [0xBF, 0x4B, 0x2C, 0xB6, 0x59, 0x19, 0xA0, 0xAA]};
@GUID(0x615BBB53, 0xC945, 0x4203, [0xBF, 0x4B, 0x2C, 0xB6, 0x59, 0x19, 0xA0, 0xAA]);
interface ISyncKnowledge : IUnknown
{
    HRESULT GetOwnerReplicaId(ubyte* pbReplicaId, uint* pcbIdSize);
    HRESULT Serialize(BOOL fSerializeReplicaKeyMap, ubyte* pbKnowledge, uint* pcbKnowledge);
    HRESULT SetLocalTickCount(ulong ullTickCount);
    HRESULT ContainsChange(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pgidItemId, const(SYNC_VERSION)* pSyncVersion);
    HRESULT ContainsChangeUnit(const(ubyte)* pbVersionOwnerReplicaId, const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pSyncVersion);
    HRESULT GetScopeVector(const(Guid)* riid, void** ppUnk);
    HRESULT GetReplicaKeyMap(IReplicaKeyMap* ppReplicaKeyMap);
    HRESULT Clone(ISyncKnowledge* ppClonedKnowledge);
    HRESULT ConvertVersion(ISyncKnowledge pKnowledgeIn, const(ubyte)* pbCurrentOwnerId, const(SYNC_VERSION)* pVersionIn, ubyte* pbNewOwnerId, uint* pcbIdSize, SYNC_VERSION* pVersionOut);
    HRESULT MapRemoteToLocal(ISyncKnowledge pRemoteKnowledge, ISyncKnowledge* ppMappedKnowledge);
    HRESULT Union(ISyncKnowledge pKnowledge);
    HRESULT ProjectOntoItem(const(ubyte)* pbItemId, ISyncKnowledge* ppKnowledgeOut);
    HRESULT ProjectOntoChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, ISyncKnowledge* ppKnowledgeOut);
    HRESULT ProjectOntoRange(const(SYNC_RANGE)* psrngSyncRange, ISyncKnowledge* ppKnowledgeOut);
    HRESULT ExcludeItem(const(ubyte)* pbItemId);
    HRESULT ExcludeChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId);
    HRESULT ContainsKnowledge(ISyncKnowledge pKnowledge);
    HRESULT FindMinTickCountForReplica(const(ubyte)* pbReplicaId, ulong* pullReplicaTickCount);
    HRESULT GetRangeExceptions(const(Guid)* riid, void** ppUnk);
    HRESULT GetSingleItemExceptions(const(Guid)* riid, void** ppUnk);
    HRESULT GetChangeUnitExceptions(const(Guid)* riid, void** ppUnk);
    HRESULT FindClockVectorForItem(const(ubyte)* pbItemId, const(Guid)* riid, void** ppUnk);
    HRESULT FindClockVectorForChangeUnit(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, const(Guid)* riid, void** ppUnk);
    HRESULT GetVersion(uint* pdwVersion);
}

const GUID IID_IForgottenKnowledge = {0x456E0F96, 0x6036, 0x452B, [0x9F, 0x9D, 0xBC, 0xC4, 0xB4, 0xA8, 0x5D, 0xB2]};
@GUID(0x456E0F96, 0x6036, 0x452B, [0x9F, 0x9D, 0xBC, 0xC4, 0xB4, 0xA8, 0x5D, 0xB2]);
interface IForgottenKnowledge : ISyncKnowledge
{
    HRESULT ForgetToVersion(ISyncKnowledge pKnowledge, const(SYNC_VERSION)* pVersion);
}

const GUID IID_ISyncKnowledge2 = {0xED0ADDC0, 0x3B4B, 0x46A1, [0x9A, 0x45, 0x45, 0x66, 0x1D, 0x21, 0x14, 0xC8]};
@GUID(0xED0ADDC0, 0x3B4B, 0x46A1, [0x9A, 0x45, 0x45, 0x66, 0x1D, 0x21, 0x14, 0xC8]);
interface ISyncKnowledge2 : ISyncKnowledge
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT ProjectOntoColumnSet(const(ubyte)** ppColumns, uint count, ISyncKnowledge2* ppiKnowledgeOut);
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, uint* pdwSerializedSize);
    HRESULT GetLowestUncontainedId(ISyncKnowledge2 piSyncKnowledge, ubyte* pbItemId, uint* pcbItemIdSize);
    HRESULT GetInspector(const(Guid)* riid, void** ppiInspector);
    HRESULT GetMinimumSupportedVersion(SYNC_SERIALIZATION_VERSION* pVersion);
    HRESULT GetStatistics(SYNC_STATISTICS which, uint* pValue);
    HRESULT ContainsKnowledgeForItem(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId);
    HRESULT ContainsKnowledgeForChangeUnit(ISyncKnowledge pKnowledge, const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId);
    HRESULT ProjectOntoKnowledgeWithPrerequisite(ISyncKnowledge pPrerequisiteKnowledge, ISyncKnowledge pTemplateKnowledge, ISyncKnowledge* ppProjectedKnowledge);
    HRESULT Complement(ISyncKnowledge pSyncKnowledge, ISyncKnowledge* ppComplementedKnowledge);
    HRESULT IntersectsWithKnowledge(ISyncKnowledge pSyncKnowledge);
    HRESULT GetKnowledgeCookie(IUnknown* ppKnowledgeCookie);
    HRESULT CompareToKnowledgeCookie(IUnknown pKnowledgeCookie, KNOWLEDGE_COOKIE_COMPARISON_RESULT* pResult);
}

const GUID IID_IRecoverableErrorData = {0xB37C4A0A, 0x4B7D, 0x4C2D, [0x97, 0x11, 0x3B, 0x00, 0xD1, 0x19, 0xB1, 0xC8]};
@GUID(0xB37C4A0A, 0x4B7D, 0x4C2D, [0x97, 0x11, 0x3B, 0x00, 0xD1, 0x19, 0xB1, 0xC8]);
interface IRecoverableErrorData : IUnknown
{
    HRESULT Initialize(const(wchar)* pcszItemDisplayName, const(wchar)* pcszErrorDescription);
    HRESULT GetItemDisplayName(const(wchar)* pszItemDisplayName, uint* pcchItemDisplayName);
    HRESULT GetErrorDescription(const(wchar)* pszErrorDescription, uint* pcchErrorDescription);
}

const GUID IID_IRecoverableError = {0x0F5625E8, 0x0A7B, 0x45EE, [0x96, 0x37, 0x1C, 0xE1, 0x36, 0x45, 0x90, 0x9E]};
@GUID(0x0F5625E8, 0x0A7B, 0x45EE, [0x96, 0x37, 0x1C, 0xE1, 0x36, 0x45, 0x90, 0x9E]);
interface IRecoverableError : IUnknown
{
    HRESULT GetStage(SYNC_PROGRESS_STAGE* pStage);
    HRESULT GetProvider(SYNC_PROVIDER_ROLE* pProviderRole);
    HRESULT GetChangeWithRecoverableError(ISyncChange* ppChangeWithRecoverableError);
    HRESULT GetRecoverableErrorDataForChange(int* phrError, IRecoverableErrorData* ppErrorData);
    HRESULT GetRecoverableErrorDataForChangeUnit(ISyncChangeUnit pChangeUnit, int* phrError, IRecoverableErrorData* ppErrorData);
}

const GUID IID_IChangeConflict = {0x014EBF97, 0x9F20, 0x4F7A, [0xBD, 0xD4, 0x25, 0x97, 0x9C, 0x77, 0xC0, 0x02]};
@GUID(0x014EBF97, 0x9F20, 0x4F7A, [0xBD, 0xD4, 0x25, 0x97, 0x9C, 0x77, 0xC0, 0x02]);
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

const GUID IID_IConstraintConflict = {0x00D2302E, 0x1CF8, 0x4835, [0xB8, 0x5F, 0xB7, 0xCA, 0x4F, 0x79, 0x9E, 0x0A]};
@GUID(0x00D2302E, 0x1CF8, 0x4835, [0xB8, 0x5F, 0xB7, 0xCA, 0x4F, 0x79, 0x9E, 0x0A]);
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
    HRESULT GetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, __MIDL___MIDL_itf_winsync_0000_0000_0009* pConstraintResolveAction);
    HRESULT SetConstraintResolveActionForChangeUnit(ISyncChangeUnit pChangeUnit, __MIDL___MIDL_itf_winsync_0000_0000_0009 constraintResolveAction);
    HRESULT GetConstraintConflictReason(__MIDL___MIDL_itf_winsync_0000_0000_0010* pConstraintConflictReason);
    HRESULT IsTemporary();
}

const GUID IID_ISyncCallback = {0x0599797F, 0x5ED9, 0x485C, [0xAE, 0x36, 0x0C, 0x5D, 0x1B, 0xF2, 0xE7, 0xA5]};
@GUID(0x0599797F, 0x5ED9, 0x485C, [0xAE, 0x36, 0x0C, 0x5D, 0x1B, 0xF2, 0xE7, 0xA5]);
interface ISyncCallback : IUnknown
{
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, uint dwTotalWork);
    HRESULT OnChange(ISyncChange pSyncChange);
    HRESULT OnConflict(IChangeConflict pConflict);
    HRESULT OnFullEnumerationNeeded(SYNC_FULL_ENUMERATION_ACTION* pFullEnumerationAction);
    HRESULT OnRecoverableError(IRecoverableError pRecoverableError);
}

const GUID IID_ISyncCallback2 = {0x47CE84AF, 0x7442, 0x4EAD, [0x86, 0x30, 0x12, 0x01, 0x5E, 0x03, 0x0A, 0xD7]};
@GUID(0x47CE84AF, 0x7442, 0x4EAD, [0x86, 0x30, 0x12, 0x01, 0x5E, 0x03, 0x0A, 0xD7]);
interface ISyncCallback2 : ISyncCallback
{
    HRESULT OnChangeApplied(uint dwChangesApplied, uint dwChangesFailed);
    HRESULT OnChangeFailed(uint dwChangesApplied, uint dwChangesFailed);
}

const GUID IID_ISyncConstraintCallback = {0x8AF3843E, 0x75B3, 0x438C, [0xBB, 0x51, 0x6F, 0x02, 0x0D, 0x70, 0xD3, 0xCB]};
@GUID(0x8AF3843E, 0x75B3, 0x438C, [0xBB, 0x51, 0x6F, 0x02, 0x0D, 0x70, 0xD3, 0xCB]);
interface ISyncConstraintCallback : IUnknown
{
    HRESULT OnConstraintConflict(IConstraintConflict pConflict);
}

const GUID IID_ISyncProvider = {0x8F657056, 0x2BCE, 0x4A17, [0x8C, 0x68, 0xC7, 0xBB, 0x78, 0x98, 0xB5, 0x6F]};
@GUID(0x8F657056, 0x2BCE, 0x4A17, [0x8C, 0x68, 0xC7, 0xBB, 0x78, 0x98, 0xB5, 0x6F]);
interface ISyncProvider : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
}

const GUID IID_ISyncSessionState = {0xB8A940FE, 0x9F01, 0x483B, [0x94, 0x34, 0xC3, 0x7D, 0x36, 0x12, 0x25, 0xD9]};
@GUID(0xB8A940FE, 0x9F01, 0x483B, [0x94, 0x34, 0xC3, 0x7D, 0x36, 0x12, 0x25, 0xD9]);
interface ISyncSessionState : IUnknown
{
    HRESULT IsCanceled(int* pfIsCanceled);
    HRESULT GetInfoForChangeApplication(ubyte* pbChangeApplierInfo, uint* pcbChangeApplierInfo);
    HRESULT LoadInfoFromChangeApplication(const(ubyte)* pbChangeApplierInfo, uint cbChangeApplierInfo);
    HRESULT GetForgottenKnowledgeRecoveryRangeStart(ubyte* pbRangeStart, uint* pcbRangeStart);
    HRESULT GetForgottenKnowledgeRecoveryRangeEnd(ubyte* pbRangeEnd, uint* pcbRangeEnd);
    HRESULT SetForgottenKnowledgeRecoveryRange(const(SYNC_RANGE)* pRange);
    HRESULT OnProgress(SYNC_PROVIDER_ROLE provider, SYNC_PROGRESS_STAGE syncStage, uint dwCompletedWork, uint dwTotalWork);
}

const GUID IID_ISyncSessionExtendedErrorInfo = {0x326C6810, 0x790A, 0x409B, [0xB7, 0x41, 0x69, 0x99, 0x38, 0x87, 0x61, 0xEB]};
@GUID(0x326C6810, 0x790A, 0x409B, [0xB7, 0x41, 0x69, 0x99, 0x38, 0x87, 0x61, 0xEB]);
interface ISyncSessionExtendedErrorInfo : IUnknown
{
    HRESULT GetSyncProviderWithError(ISyncProvider* ppProviderWithError);
}

const GUID IID_ISyncSessionState2 = {0x9E37CFA3, 0x9E38, 0x4C61, [0x9C, 0xA3, 0xFF, 0xE8, 0x10, 0xB4, 0x5C, 0xA2]};
@GUID(0x9E37CFA3, 0x9E38, 0x4C61, [0x9C, 0xA3, 0xFF, 0xE8, 0x10, 0xB4, 0x5C, 0xA2]);
interface ISyncSessionState2 : ISyncSessionState
{
    HRESULT SetProviderWithError(BOOL fSelf);
    HRESULT GetSessionErrorStatus(int* phrSessionError);
}

const GUID IID_ISyncFilterInfo = {0x794EAAF8, 0x3F2E, 0x47E6, [0x97, 0x28, 0x17, 0xE6, 0xFC, 0xF9, 0x4C, 0xB7]};
@GUID(0x794EAAF8, 0x3F2E, 0x47E6, [0x97, 0x28, 0x17, 0xE6, 0xFC, 0xF9, 0x4C, 0xB7]);
interface ISyncFilterInfo : IUnknown
{
    HRESULT Serialize(ubyte* pbBuffer, uint* pcbBuffer);
}

const GUID IID_ISyncFilterInfo2 = {0x19B394BA, 0xE3D0, 0x468C, [0x93, 0x4D, 0x32, 0x19, 0x68, 0xB2, 0xAB, 0x34]};
@GUID(0x19B394BA, 0xE3D0, 0x468C, [0x93, 0x4D, 0x32, 0x19, 0x68, 0xB2, 0xAB, 0x34]);
interface ISyncFilterInfo2 : ISyncFilterInfo
{
    HRESULT GetFlags(uint* pdwFlags);
}

const GUID IID_IChangeUnitListFilterInfo = {0xF2837671, 0x0BDF, 0x43FA, [0xB5, 0x02, 0x23, 0x23, 0x75, 0xFB, 0x50, 0xC2]};
@GUID(0xF2837671, 0x0BDF, 0x43FA, [0xB5, 0x02, 0x23, 0x23, 0x75, 0xFB, 0x50, 0xC2]);
interface IChangeUnitListFilterInfo : ISyncFilterInfo
{
    HRESULT Initialize(const(ubyte)** ppbChangeUnitIds, uint dwChangeUnitCount);
    HRESULT GetChangeUnitIdCount(uint* pdwChangeUnitIdCount);
    HRESULT GetChangeUnitId(uint dwChangeUnitIdIndex, ubyte* pbChangeUnitId, uint* pcbIdSize);
}

const GUID IID_ISyncFilter = {0x087A3F15, 0x0FCB, 0x44C1, [0x96, 0x39, 0x53, 0xC1, 0x4E, 0x2B, 0x55, 0x06]};
@GUID(0x087A3F15, 0x0FCB, 0x44C1, [0x96, 0x39, 0x53, 0xC1, 0x4E, 0x2B, 0x55, 0x06]);
interface ISyncFilter : IUnknown
{
    HRESULT IsIdentical(ISyncFilter pSyncFilter);
    HRESULT Serialize(ubyte* pbSyncFilter, uint* pcbSyncFilter);
}

const GUID IID_ISyncFilterDeserializer = {0xB45B7A72, 0xE5C7, 0x46BE, [0x9C, 0x82, 0x77, 0xB8, 0xB1, 0x5D, 0xAB, 0x8A]};
@GUID(0xB45B7A72, 0xE5C7, 0x46BE, [0x9C, 0x82, 0x77, 0xB8, 0xB1, 0x5D, 0xAB, 0x8A]);
interface ISyncFilterDeserializer : IUnknown
{
    HRESULT DeserializeSyncFilter(const(ubyte)* pbSyncFilter, uint dwCbSyncFilter, ISyncFilter* ppISyncFilter);
}

const GUID IID_ICustomFilterInfo = {0x1D335DFF, 0x6F88, 0x4E4D, [0x91, 0xA8, 0xA3, 0xF3, 0x51, 0xCF, 0xD4, 0x73]};
@GUID(0x1D335DFF, 0x6F88, 0x4E4D, [0x91, 0xA8, 0xA3, 0xF3, 0x51, 0xCF, 0xD4, 0x73]);
interface ICustomFilterInfo : ISyncFilterInfo
{
    HRESULT GetSyncFilter(ISyncFilter* pISyncFilter);
}

enum __MIDL___MIDL_itf_winsync_0000_0036_0001
{
    FCT_INTERSECTION = 0,
}

const GUID IID_ICombinedFilterInfo = {0x11F9DE71, 0x2818, 0x4779, [0xB2, 0xAC, 0x42, 0xD4, 0x50, 0x56, 0x5F, 0x45]};
@GUID(0x11F9DE71, 0x2818, 0x4779, [0xB2, 0xAC, 0x42, 0xD4, 0x50, 0x56, 0x5F, 0x45]);
interface ICombinedFilterInfo : ISyncFilterInfo
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterInfo(uint dwFilterIndex, ISyncFilterInfo* ppIFilterInfo);
    HRESULT GetFilterCombinationType(__MIDL___MIDL_itf_winsync_0000_0036_0001* pFilterCombinationType);
}

const GUID IID_IEnumSyncChanges = {0x5F86BE4A, 0x5E78, 0x4E32, [0xAC, 0x1C, 0xC2, 0x4F, 0xD2, 0x23, 0xEF, 0x85]};
@GUID(0x5F86BE4A, 0x5E78, 0x4E32, [0xAC, 0x1C, 0xC2, 0x4F, 0xD2, 0x23, 0xEF, 0x85]);
interface IEnumSyncChanges : IUnknown
{
    HRESULT Next(uint cChanges, ISyncChange* ppChange, uint* pcFetched);
    HRESULT Skip(uint cChanges);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncChanges* ppEnum);
}

const GUID IID_ISyncChangeBuilder = {0x56F14771, 0x8677, 0x484F, [0xA1, 0x70, 0xE3, 0x86, 0xE4, 0x18, 0xA6, 0x76]};
@GUID(0x56F14771, 0x8677, 0x484F, [0xA1, 0x70, 0xE3, 0x86, 0xE4, 0x18, 0xA6, 0x76]);
interface ISyncChangeBuilder : IUnknown
{
    HRESULT AddChangeUnitMetadata(const(ubyte)* pbChangeUnitId, const(SYNC_VERSION)* pChangeUnitVersion);
}

const GUID IID_IFilterTrackingSyncChangeBuilder = {0x295024A0, 0x70DA, 0x4C58, [0x88, 0x3C, 0xCE, 0x2A, 0xFB, 0x30, 0x8D, 0x0B]};
@GUID(0x295024A0, 0x70DA, 0x4C58, [0x88, 0x3C, 0xCE, 0x2A, 0xFB, 0x30, 0x8D, 0x0B]);
interface IFilterTrackingSyncChangeBuilder : IUnknown
{
    HRESULT AddFilterChange(uint dwFilterKey, const(SYNC_FILTER_CHANGE)* pFilterChange);
    HRESULT SetAllChangeUnitsPresentFlag();
}

const GUID IID_ISyncChangeBatchBase = {0x52F6E694, 0x6A71, 0x4494, [0xA1, 0x84, 0xA8, 0x31, 0x1B, 0xF5, 0xD2, 0x27]};
@GUID(0x52F6E694, 0x6A71, 0x4494, [0xA1, 0x84, 0xA8, 0x31, 0x1B, 0xF5, 0xD2, 0x27]);
interface ISyncChangeBatchBase : IUnknown
{
    HRESULT GetChangeEnumerator(IEnumSyncChanges* ppEnum);
    HRESULT GetIsLastBatch(int* pfLastBatch);
    HRESULT GetWorkEstimateForBatch(uint* pdwWorkForBatch);
    HRESULT GetRemainingWorkEstimateForSession(uint* pdwRemainingWorkForSession);
    HRESULT BeginOrderedGroup(const(ubyte)* pbLowerBound);
    HRESULT EndOrderedGroup(const(ubyte)* pbUpperBound, ISyncKnowledge pMadeWithKnowledge);
    HRESULT AddItemMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, uint dwFlags, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
    HRESULT GetLearnedKnowledge(ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisteKnowledge);
    HRESULT GetSourceForgottenKnowledge(IForgottenKnowledge* ppSourceForgottenKnowledge);
    HRESULT SetLastBatch();
    HRESULT SetWorkEstimateForBatch(uint dwWorkForBatch);
    HRESULT SetRemainingWorkEstimateForSession(uint dwRemainingWorkForSession);
    HRESULT Serialize(ubyte* pbChangeBatch, uint* pcbChangeBatch);
}

const GUID IID_ISyncChangeBatch = {0x70C64DEE, 0x380F, 0x4C2E, [0x8F, 0x70, 0x31, 0xC5, 0x5B, 0xD5, 0xF9, 0xB3]};
@GUID(0x70C64DEE, 0x380F, 0x4C2E, [0x8F, 0x70, 0x31, 0xC5, 0x5B, 0xD5, 0xF9, 0xB3]);
interface ISyncChangeBatch : ISyncChangeBatchBase
{
    HRESULT BeginUnorderedGroup();
    HRESULT EndUnorderedGroup(ISyncKnowledge pMadeWithKnowledge, BOOL fAllChangesForKnowledge);
    HRESULT AddLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, uint dwFlags, uint dwWorkForChange, ISyncKnowledge pConflictKnowledge, ISyncChangeBuilder* ppChangeBuilder);
}

const GUID IID_ISyncFullEnumerationChangeBatch = {0xEF64197D, 0x4F44, 0x4EA2, [0xB3, 0x55, 0x45, 0x24, 0x71, 0x3E, 0x3B, 0xED]};
@GUID(0xEF64197D, 0x4F44, 0x4EA2, [0xB3, 0x55, 0x45, 0x24, 0x71, 0x3E, 0x3B, 0xED]);
interface ISyncFullEnumerationChangeBatch : ISyncChangeBatchBase
{
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledgeAfterRecoveryComplete);
    HRESULT GetClosedLowerBoundItemId(ubyte* pbClosedLowerBoundItemId, uint* pcbIdSize);
    HRESULT GetClosedUpperBoundItemId(ubyte* pbClosedUpperBoundItemId, uint* pcbIdSize);
}

const GUID IID_ISyncChangeBatchWithPrerequisite = {0x097F13BE, 0x5B92, 0x4048, [0xB3, 0xF2, 0x7B, 0x42, 0xA2, 0x51, 0x5E, 0x07]};
@GUID(0x097F13BE, 0x5B92, 0x4048, [0xB3, 0xF2, 0x7B, 0x42, 0xA2, 0x51, 0x5E, 0x07]);
interface ISyncChangeBatchWithPrerequisite : ISyncChangeBatchBase
{
    HRESULT SetPrerequisiteKnowledge(ISyncKnowledge pPrerequisiteKnowledge);
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, ISyncKnowledge* ppLearnedWithPrerequisiteKnowledge);
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

const GUID IID_ISyncChangeBatchBase2 = {0x6FDB596A, 0xD755, 0x4584, [0xBD, 0x0C, 0xC0, 0xC2, 0x3A, 0x54, 0x8F, 0xBF]};
@GUID(0x6FDB596A, 0xD755, 0x4584, [0xBD, 0x0C, 0xC0, 0xC2, 0x3A, 0x54, 0x8F, 0xBF]);
interface ISyncChangeBatchBase2 : ISyncChangeBatchBase
{
    HRESULT SerializeWithOptions(SYNC_SERIALIZATION_VERSION targetFormatVersion, uint dwFlags, ubyte* pbBuffer, uint* pdwSerializedSize);
}

const GUID IID_ISyncChangeBatchAdvanced = {0x0F1A4995, 0xCBC8, 0x421D, [0xB5, 0x50, 0x5D, 0x0B, 0xEB, 0xF3, 0xE9, 0xA5]};
@GUID(0x0F1A4995, 0xCBC8, 0x421D, [0xB5, 0x50, 0x5D, 0x0B, 0xEB, 0xF3, 0xE9, 0xA5]);
interface ISyncChangeBatchAdvanced : IUnknown
{
    HRESULT GetFilterInfo(ISyncFilterInfo* ppFilterInfo);
    HRESULT ConvertFullEnumerationChangeBatchToRegularChangeBatch(ISyncChangeBatch* ppChangeBatch);
    HRESULT GetUpperBoundItemId(ubyte* pbItemId, uint* pcbIdSize);
    HRESULT GetBatchLevelKnowledgeShouldBeApplied(int* pfBatchKnowledgeShouldBeApplied);
}

const GUID IID_ISyncChangeBatch2 = {0x225F4A33, 0xF5EE, 0x4CC7, [0xB0, 0x39, 0x67, 0xA2, 0x62, 0xB4, 0xB2, 0xAC]};
@GUID(0x225F4A33, 0xF5EE, 0x4CC7, [0xB0, 0x39, 0x67, 0xA2, 0x62, 0xB4, 0xB2, 0xAC]);
interface ISyncChangeBatch2 : ISyncChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
    HRESULT AddMergeTombstoneLoggedConflict(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, ISyncKnowledge pConflictKnowledge, ISyncChangeBuilder* ppChangeBuilder);
}

const GUID IID_ISyncFullEnumerationChangeBatch2 = {0xE06449F4, 0xA205, 0x4B65, [0x97, 0x24, 0x01, 0xB2, 0x21, 0x01, 0xEE, 0xC1]};
@GUID(0xE06449F4, 0xA205, 0x4B65, [0x97, 0x24, 0x01, 0xB2, 0x21, 0x01, 0xEE, 0xC1]);
interface ISyncFullEnumerationChangeBatch2 : ISyncFullEnumerationChangeBatch
{
    HRESULT AddMergeTombstoneMetadataToGroup(const(ubyte)* pbOwnerReplicaId, const(ubyte)* pbWinnerItemId, const(ubyte)* pbItemId, const(SYNC_VERSION)* pChangeVersion, const(SYNC_VERSION)* pCreationVersion, uint dwWorkForChange, ISyncChangeBuilder* ppChangeBuilder);
}

const GUID IID_IKnowledgeSyncProvider = {0x43434A49, 0x8DA4, 0x47F2, [0x81, 0x72, 0xAD, 0x7B, 0x8B, 0x02, 0x49, 0x78]};
@GUID(0x43434A49, 0x8DA4, 0x47F2, [0x81, 0x72, 0xAD, 0x7B, 0x8B, 0x02, 0x49, 0x78]);
interface IKnowledgeSyncProvider : ISyncProvider
{
    HRESULT BeginSession(SYNC_PROVIDER_ROLE role, ISyncSessionState pSessionState);
    HRESULT GetSyncBatchParameters(ISyncKnowledge* ppSyncKnowledge, uint* pdwRequestedBatchSize);
    HRESULT GetChangeBatch(uint dwBatchSize, ISyncKnowledge pSyncKnowledge, ISyncChangeBatch* ppSyncChangeBatch, IUnknown* ppUnkDataRetriever);
    HRESULT GetFullEnumerationChangeBatch(uint dwBatchSize, const(ubyte)* pbLowerEnumerationBound, ISyncKnowledge pSyncKnowledge, ISyncFullEnumerationChangeBatch* ppSyncChangeBatch, IUnknown* ppUnkDataRetriever);
    HRESULT ProcessChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, ISyncChangeBatch pSourceChangeBatch, IUnknown pUnkDataRetriever, ISyncCallback pCallback, SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    HRESULT ProcessFullEnumerationChangeBatch(CONFLICT_RESOLUTION_POLICY resolutionPolicy, ISyncFullEnumerationChangeBatch pSourceChangeBatch, IUnknown pUnkDataRetriever, ISyncCallback pCallback, SYNC_SESSION_STATISTICS* pSyncSessionStatistics);
    HRESULT EndSession(ISyncSessionState pSessionState);
}

const GUID IID_ISyncChangeUnit = {0x60EDD8CA, 0x7341, 0x4BB7, [0x95, 0xCE, 0xFA, 0xB6, 0x39, 0x4B, 0x51, 0xCB]};
@GUID(0x60EDD8CA, 0x7341, 0x4BB7, [0x95, 0xCE, 0xFA, 0xB6, 0x39, 0x4B, 0x51, 0xCB]);
interface ISyncChangeUnit : IUnknown
{
    HRESULT GetItemChange(ISyncChange* ppSyncChange);
    HRESULT GetChangeUnitId(ubyte* pbChangeUnitId, uint* pcbIdSize);
    HRESULT GetChangeUnitVersion(const(ubyte)* pbCurrentReplicaId, SYNC_VERSION* pVersion);
}

const GUID IID_IEnumSyncChangeUnits = {0x346B35F1, 0x8703, 0x4C6D, [0xAB, 0x1A, 0x4D, 0xBC, 0xA2, 0xCF, 0xF9, 0x7F]};
@GUID(0x346B35F1, 0x8703, 0x4C6D, [0xAB, 0x1A, 0x4D, 0xBC, 0xA2, 0xCF, 0xF9, 0x7F]);
interface IEnumSyncChangeUnits : IUnknown
{
    HRESULT Next(uint cChanges, ISyncChangeUnit* ppChangeUnit, uint* pcFetched);
    HRESULT Skip(uint cChanges);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncChangeUnits* ppEnum);
}

const GUID IID_ISyncChange = {0xA1952BEB, 0x0F6B, 0x4711, [0xB1, 0x36, 0x01, 0xDA, 0x85, 0xB9, 0x68, 0xA6]};
@GUID(0xA1952BEB, 0x0F6B, 0x4711, [0xB1, 0x36, 0x01, 0xDA, 0x85, 0xB9, 0x68, 0xA6]);
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

const GUID IID_ISyncChangeWithPrerequisite = {0x9E38382F, 0x1589, 0x48C3, [0x92, 0xE4, 0x05, 0xEC, 0xDC, 0xB4, 0xF3, 0xF7]};
@GUID(0x9E38382F, 0x1589, 0x48C3, [0x92, 0xE4, 0x05, 0xEC, 0xDC, 0xB4, 0xF3, 0xF7]);
interface ISyncChangeWithPrerequisite : IUnknown
{
    HRESULT GetPrerequisiteKnowledge(ISyncKnowledge* ppPrerequisiteKnowledge);
    HRESULT GetLearnedKnowledgeWithPrerequisite(ISyncKnowledge pDestinationKnowledge, ISyncKnowledge* ppLearnedKnowledgeWithPrerequisite);
}

const GUID IID_ISyncFullEnumerationChange = {0x9785E0BD, 0xBDFF, 0x40C4, [0x98, 0xC5, 0xB3, 0x4B, 0x2F, 0x19, 0x91, 0xB3]};
@GUID(0x9785E0BD, 0xBDFF, 0x40C4, [0x98, 0xC5, 0xB3, 0x4B, 0x2F, 0x19, 0x91, 0xB3]);
interface ISyncFullEnumerationChange : IUnknown
{
    HRESULT GetLearnedKnowledgeAfterRecoveryComplete(ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedForgottenKnowledge(IForgottenKnowledge* ppLearnedForgottenKnowledge);
}

const GUID IID_ISyncMergeTombstoneChange = {0x6EC62597, 0x0903, 0x484C, [0xAD, 0x61, 0x36, 0xD6, 0xE9, 0x38, 0xF4, 0x7B]};
@GUID(0x6EC62597, 0x0903, 0x484C, [0xAD, 0x61, 0x36, 0xD6, 0xE9, 0x38, 0xF4, 0x7B]);
interface ISyncMergeTombstoneChange : IUnknown
{
    HRESULT GetWinnerItemId(ubyte* pbWinnerItemId, uint* pcbIdSize);
}

const GUID IID_IEnumItemIds = {0x43AA3F61, 0x4B2E, 0x4B60, [0x83, 0xDF, 0xB1, 0x10, 0xD3, 0xE1, 0x48, 0xF1]};
@GUID(0x43AA3F61, 0x4B2E, 0x4B60, [0x83, 0xDF, 0xB1, 0x10, 0xD3, 0xE1, 0x48, 0xF1]);
interface IEnumItemIds : IUnknown
{
    HRESULT Next(ubyte* pbItemId, uint* pcbItemIdSize);
}

const GUID IID_IFilterKeyMap = {0xCA169652, 0x07C6, 0x4708, [0xA3, 0xDA, 0x6E, 0x4E, 0xBA, 0x8D, 0x22, 0x97]};
@GUID(0xCA169652, 0x07C6, 0x4708, [0xA3, 0xDA, 0x6E, 0x4E, 0xBA, 0x8D, 0x22, 0x97]);
interface IFilterKeyMap : IUnknown
{
    HRESULT GetCount(uint* pdwCount);
    HRESULT AddFilter(ISyncFilter pISyncFilter, uint* pdwFilterKey);
    HRESULT GetFilter(uint dwFilterKey, ISyncFilter* ppISyncFilter);
    HRESULT Serialize(ubyte* pbFilterKeyMap, uint* pcbFilterKeyMap);
}

const GUID IID_ISyncChangeWithFilterKeyMap = {0xBFE1EF00, 0xE87D, 0x42FD, [0xA4, 0xE9, 0x24, 0x2D, 0x70, 0x41, 0x4A, 0xEF]};
@GUID(0xBFE1EF00, 0xE87D, 0x42FD, [0xA4, 0xE9, 0x24, 0x2D, 0x70, 0x41, 0x4A, 0xEF]);
interface ISyncChangeWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterCount(uint* pdwFilterCount);
    HRESULT GetFilterChange(uint dwFilterKey, SYNC_FILTER_CHANGE* pFilterChange);
    HRESULT GetAllChangeUnitsPresentFlag(int* pfAllChangeUnitsPresent);
    HRESULT GetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge* ppIFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

const GUID IID_ISyncChangeBatchWithFilterKeyMap = {0xDE247002, 0x566D, 0x459A, [0xA6, 0xED, 0xA5, 0xAA, 0xB3, 0x45, 0x9F, 0xB7]};
@GUID(0xDE247002, 0x566D, 0x459A, [0xA6, 0xED, 0xA5, 0xAA, 0xB3, 0x45, 0x9F, 0xB7]);
interface ISyncChangeBatchWithFilterKeyMap : IUnknown
{
    HRESULT GetFilterKeyMap(IFilterKeyMap* ppIFilterKeyMap);
    HRESULT SetFilterKeyMap(IFilterKeyMap pIFilterKeyMap);
    HRESULT SetFilterForgottenKnowledge(uint dwFilterKey, ISyncKnowledge pFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledge(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetFilteredReplicaLearnedForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, ISyncKnowledge* ppLearnedForgottenKnowledge);
    HRESULT GetLearnedFilterForgottenKnowledgeAfterRecoveryComplete(ISyncKnowledge pDestinationKnowledge, IEnumItemIds pNewMoveins, uint dwFilterKey, ISyncKnowledge* ppLearnedFilterForgottenKnowledge);
}

const GUID IID_IDataRetrieverCallback = {0x71B4863B, 0xF969, 0x4676, [0xBB, 0xC3, 0x3D, 0x9F, 0xDC, 0x3F, 0xB2, 0xC7]};
@GUID(0x71B4863B, 0xF969, 0x4676, [0xBB, 0xC3, 0x3D, 0x9F, 0xDC, 0x3F, 0xB2, 0xC7]);
interface IDataRetrieverCallback : IUnknown
{
    HRESULT LoadChangeDataComplete(IUnknown pUnkData);
    HRESULT LoadChangeDataError(HRESULT hrError);
}

const GUID IID_ILoadChangeContext = {0x44A4AACA, 0xEC39, 0x46D5, [0xB5, 0xC9, 0xD6, 0x33, 0xC0, 0xEE, 0x67, 0xE2]};
@GUID(0x44A4AACA, 0xEC39, 0x46D5, [0xB5, 0xC9, 0xD6, 0x33, 0xC0, 0xEE, 0x67, 0xE2]);
interface ILoadChangeContext : IUnknown
{
    HRESULT GetSyncChange(ISyncChange* ppSyncChange);
    HRESULT SetRecoverableErrorOnChange(HRESULT hrError, IRecoverableErrorData pErrorData);
    HRESULT SetRecoverableErrorOnChangeUnit(HRESULT hrError, ISyncChangeUnit pChangeUnit, IRecoverableErrorData pErrorData);
}

const GUID IID_ISynchronousDataRetriever = {0x9B22F2A9, 0xA4CD, 0x4648, [0x9D, 0x8E, 0x3A, 0x51, 0x0D, 0x4D, 0xA0, 0x4B]};
@GUID(0x9B22F2A9, 0xA4CD, 0x4648, [0x9D, 0x8E, 0x3A, 0x51, 0x0D, 0x4D, 0xA0, 0x4B]);
interface ISynchronousDataRetriever : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext, IUnknown* ppUnkData);
}

const GUID IID_IAsynchronousDataRetriever = {0x9FC7E470, 0x61EA, 0x4A88, [0x9B, 0xE4, 0xDF, 0x56, 0xA2, 0x7C, 0xFE, 0xF2]};
@GUID(0x9FC7E470, 0x61EA, 0x4A88, [0x9B, 0xE4, 0xDF, 0x56, 0xA2, 0x7C, 0xFE, 0xF2]);
interface IAsynchronousDataRetriever : IUnknown
{
    HRESULT GetIdParameters(ID_PARAMETERS* pIdParameters);
    HRESULT RegisterCallback(IDataRetrieverCallback pDataRetrieverCallback);
    HRESULT RevokeCallback(IDataRetrieverCallback pDataRetrieverCallback);
    HRESULT LoadChangeData(ILoadChangeContext pLoadChangeContext);
}

const GUID IID_IFilterRequestCallback = {0x82DF8873, 0x6360, 0x463A, [0xA8, 0xA1, 0xED, 0xE5, 0xE1, 0xA1, 0x59, 0x4D]};
@GUID(0x82DF8873, 0x6360, 0x463A, [0xA8, 0xA1, 0xED, 0xE5, 0xE1, 0xA1, 0x59, 0x4D]);
interface IFilterRequestCallback : IUnknown
{
    HRESULT RequestFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

const GUID IID_IRequestFilteredSync = {0x2E020184, 0x6D18, 0x46A7, [0xA3, 0x2A, 0xDA, 0x4A, 0xEB, 0x06, 0x69, 0x6C]};
@GUID(0x2E020184, 0x6D18, 0x46A7, [0xA3, 0x2A, 0xDA, 0x4A, 0xEB, 0x06, 0x69, 0x6C]);
interface IRequestFilteredSync : IUnknown
{
    HRESULT SpecifyFilter(IFilterRequestCallback pCallback);
}

const GUID IID_ISupportFilteredSync = {0x3D128DED, 0xD555, 0x4E0D, [0xBF, 0x4B, 0xFB, 0x21, 0x3A, 0x8A, 0x93, 0x02]};
@GUID(0x3D128DED, 0xD555, 0x4E0D, [0xBF, 0x4B, 0xFB, 0x21, 0x3A, 0x8A, 0x93, 0x02]);
interface ISupportFilteredSync : IUnknown
{
    HRESULT AddFilter(IUnknown pFilter, FILTERING_TYPE filteringType);
}

const GUID IID_IFilterTrackingRequestCallback = {0x713CA7BB, 0xC858, 0x4674, [0xB4, 0xB6, 0x11, 0x22, 0x43, 0x65, 0x87, 0xA9]};
@GUID(0x713CA7BB, 0xC858, 0x4674, [0xB4, 0xB6, 0x11, 0x22, 0x43, 0x65, 0x87, 0xA9]);
interface IFilterTrackingRequestCallback : IUnknown
{
    HRESULT RequestTrackedFilter(ISyncFilter pFilter);
}

const GUID IID_IFilterTrackingProvider = {0x743383C0, 0xFC4E, 0x45BA, [0xAD, 0x81, 0xD9, 0xD8, 0x4C, 0x7A, 0x24, 0xF8]};
@GUID(0x743383C0, 0xFC4E, 0x45BA, [0xAD, 0x81, 0xD9, 0xD8, 0x4C, 0x7A, 0x24, 0xF8]);
interface IFilterTrackingProvider : IUnknown
{
    HRESULT SpecifyTrackedFilters(IFilterTrackingRequestCallback pCallback);
    HRESULT AddTrackedFilter(ISyncFilter pFilter);
}

const GUID IID_ISupportLastWriteTime = {0xEADF816F, 0xD0BD, 0x43CA, [0x8F, 0x40, 0x5A, 0xCD, 0xC6, 0xC0, 0x6F, 0x7A]};
@GUID(0xEADF816F, 0xD0BD, 0x43CA, [0x8F, 0x40, 0x5A, 0xCD, 0xC6, 0xC0, 0x6F, 0x7A]);
interface ISupportLastWriteTime : IUnknown
{
    HRESULT GetItemChangeTime(const(ubyte)* pbItemId, ulong* pullTimestamp);
    HRESULT GetChangeUnitChangeTime(const(ubyte)* pbItemId, const(ubyte)* pbChangeUnitId, ulong* pullTimestamp);
}

const GUID IID_IProviderConverter = {0x809B7276, 0x98CF, 0x4957, [0x93, 0xA5, 0x0E, 0xBD, 0xD3, 0xDD, 0xDF, 0xFD]};
@GUID(0x809B7276, 0x98CF, 0x4957, [0x93, 0xA5, 0x0E, 0xBD, 0xD3, 0xDD, 0xDF, 0xFD]);
interface IProviderConverter : IUnknown
{
    HRESULT Initialize(ISyncProvider pISyncProvider);
}

const GUID IID_ISyncDataConverter = {0x435D4861, 0x68D5, 0x44AA, [0xA0, 0xF9, 0x72, 0xA0, 0xB0, 0x0E, 0xF9, 0xCF]};
@GUID(0x435D4861, 0x68D5, 0x44AA, [0xA0, 0xF9, 0x72, 0xA0, 0xB0, 0x0E, 0xF9, 0xCF]);
interface ISyncDataConverter : IUnknown
{
    HRESULT ConvertDataRetrieverFromProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, IUnknown* ppUnkDataOut);
    HRESULT ConvertDataRetrieverToProviderFormat(IUnknown pUnkDataRetrieverIn, IEnumSyncChanges pEnumSyncChanges, IUnknown* ppUnkDataOut);
    HRESULT ConvertDataFromProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataIn, IUnknown* ppUnkDataOut);
    HRESULT ConvertDataToProviderFormat(ILoadChangeContext pDataContext, IUnknown pUnkDataOut, IUnknown* ppUnkDataout);
}

const GUID CLSID_SyncProviderRegistration = {0xF82B4EF1, 0x93A9, 0x4DDE, [0x80, 0x15, 0xF7, 0x95, 0x0A, 0x1A, 0x6E, 0x31]};
@GUID(0xF82B4EF1, 0x93A9, 0x4DDE, [0x80, 0x15, 0xF7, 0x95, 0x0A, 0x1A, 0x6E, 0x31]);
struct SyncProviderRegistration;

struct SyncProviderConfiguration
{
    uint dwVersion;
    Guid guidInstanceId;
    Guid clsidProvider;
    Guid guidConfigUIInstanceId;
    Guid guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
}

struct SyncProviderConfigUIConfiguration
{
    uint dwVersion;
    Guid guidInstanceId;
    Guid clsidConfigUI;
    Guid guidContentType;
    uint dwCapabilities;
    uint dwSupportedArchitecture;
    BOOL fIsGlobal;
}

const GUID IID_ISyncProviderRegistration = {0xCB45953B, 0x7624, 0x47BC, [0xA4, 0x72, 0xEB, 0x8C, 0xAC, 0x6B, 0x22, 0x2E]};
@GUID(0xCB45953B, 0x7624, 0x47BC, [0xA4, 0x72, 0xEB, 0x8C, 0xAC, 0x6B, 0x22, 0x2E]);
interface ISyncProviderRegistration : IUnknown
{
    HRESULT CreateSyncProviderConfigUIRegistrationInstance(const(SyncProviderConfigUIConfiguration)* pConfigUIConfig, ISyncProviderConfigUIInfo* ppConfigUIInfo);
    HRESULT UnregisterSyncProviderConfigUI(Guid* pguidInstanceId);
    HRESULT EnumerateSyncProviderConfigUIs(Guid* pguidContentType, uint dwSupportedArchitecture, IEnumSyncProviderConfigUIInfos* ppEnumSyncProviderConfigUIInfos);
    HRESULT CreateSyncProviderRegistrationInstance(const(SyncProviderConfiguration)* pProviderConfiguration, ISyncProviderInfo* ppProviderInfo);
    HRESULT UnregisterSyncProvider(Guid* pguidInstanceId);
    HRESULT GetSyncProviderConfigUIInfoforProvider(Guid* pguidProviderInstanceId, ISyncProviderConfigUIInfo* ppProviderConfigUIInfo);
    HRESULT EnumerateSyncProviders(Guid* pguidContentType, uint dwStateFlagsToFilterMask, uint dwStateFlagsToFilter, const(Guid)* refProviderClsId, uint dwSupportedArchitecture, IEnumSyncProviderInfos* ppEnumSyncProviderInfos);
    HRESULT GetSyncProviderInfo(Guid* pguidInstanceId, ISyncProviderInfo* ppProviderInfo);
    HRESULT GetSyncProviderFromInstanceId(Guid* pguidInstanceId, uint dwClsContext, IRegisteredSyncProvider* ppSyncProvider);
    HRESULT GetSyncProviderConfigUIInfo(Guid* pguidInstanceId, ISyncProviderConfigUIInfo* ppConfigUIInfo);
    HRESULT GetSyncProviderConfigUIFromInstanceId(Guid* pguidInstanceId, uint dwClsContext, ISyncProviderConfigUI* ppConfigUI);
    HRESULT GetSyncProviderState(Guid* pguidInstanceId, uint* pdwStateFlags);
    HRESULT SetSyncProviderState(Guid* pguidInstanceId, uint dwStateFlagsMask, uint dwStateFlags);
    HRESULT RegisterForEvent(HANDLE* phEvent);
    HRESULT RevokeEvent(HANDLE hEvent);
    HRESULT GetChange(HANDLE hEvent, ISyncRegistrationChange* ppChange);
}

const GUID IID_IEnumSyncProviderConfigUIInfos = {0xF6BE2602, 0x17C6, 0x4658, [0xA2, 0xD7, 0x68, 0xED, 0x33, 0x30, 0xF6, 0x41]};
@GUID(0xF6BE2602, 0x17C6, 0x4658, [0xA2, 0xD7, 0x68, 0xED, 0x33, 0x30, 0xF6, 0x41]);
interface IEnumSyncProviderConfigUIInfos : IUnknown
{
    HRESULT Next(uint cFactories, char* ppSyncProviderConfigUIInfo, uint* pcFetched);
    HRESULT Skip(uint cFactories);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncProviderConfigUIInfos* ppEnum);
}

const GUID IID_IEnumSyncProviderInfos = {0xA04BA850, 0x5EB1, 0x460D, [0xA9, 0x73, 0x39, 0x3F, 0xCB, 0x60, 0x8A, 0x11]};
@GUID(0xA04BA850, 0x5EB1, 0x460D, [0xA9, 0x73, 0x39, 0x3F, 0xCB, 0x60, 0x8A, 0x11]);
interface IEnumSyncProviderInfos : IUnknown
{
    HRESULT Next(uint cInstances, char* ppSyncProviderInfo, uint* pcFetched);
    HRESULT Skip(uint cInstances);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncProviderInfos* ppEnum);
}

const GUID IID_ISyncProviderInfo = {0x1EE135DE, 0x88A4, 0x4504, [0xB0, 0xD0, 0xF7, 0x92, 0x0D, 0x7E, 0x5B, 0xA6]};
@GUID(0x1EE135DE, 0x88A4, 0x4504, [0xB0, 0xD0, 0xF7, 0x92, 0x0D, 0x7E, 0x5B, 0xA6]);
interface ISyncProviderInfo : IPropertyStore
{
    HRESULT GetSyncProvider(uint dwClsContext, IRegisteredSyncProvider* ppSyncProvider);
}

const GUID IID_ISyncProviderConfigUIInfo = {0x214141AE, 0x33D7, 0x4D8D, [0x8E, 0x37, 0xF2, 0x27, 0xE8, 0x80, 0xCE, 0x50]};
@GUID(0x214141AE, 0x33D7, 0x4D8D, [0x8E, 0x37, 0xF2, 0x27, 0xE8, 0x80, 0xCE, 0x50]);
interface ISyncProviderConfigUIInfo : IPropertyStore
{
    HRESULT GetSyncProviderConfigUI(uint dwClsContext, ISyncProviderConfigUI* ppSyncProviderConfigUI);
}

const GUID IID_ISyncProviderConfigUI = {0x7B0705F6, 0xCBCD, 0x4071, [0xAB, 0x05, 0x3B, 0xDC, 0x36, 0x4D, 0x4A, 0x0C]};
@GUID(0x7B0705F6, 0xCBCD, 0x4071, [0xAB, 0x05, 0x3B, 0xDC, 0x36, 0x4D, 0x4A, 0x0C]);
interface ISyncProviderConfigUI : IUnknown
{
    HRESULT Init(Guid* pguidInstanceId, Guid* pguidContentType, IPropertyStore pConfigurationProperties);
    HRESULT GetRegisteredProperties(IPropertyStore* ppConfigUIProperties);
    HRESULT CreateAndRegisterNewSyncProvider(HWND hwndParent, IUnknown pUnkContext, ISyncProviderInfo* ppProviderInfo);
    HRESULT ModifySyncProvider(HWND hwndParent, IUnknown pUnkContext, ISyncProviderInfo pProviderInfo);
}

const GUID IID_IRegisteredSyncProvider = {0x913BCF76, 0x47C1, 0x40B5, [0xA8, 0x96, 0x5E, 0x8A, 0x9C, 0x41, 0x4C, 0x14]};
@GUID(0x913BCF76, 0x47C1, 0x40B5, [0xA8, 0x96, 0x5E, 0x8A, 0x9C, 0x41, 0x4C, 0x14]);
interface IRegisteredSyncProvider : IUnknown
{
    HRESULT Init(Guid* pguidInstanceId, Guid* pguidContentType, IPropertyStore pContextPropertyStore);
    HRESULT GetInstanceId(Guid* pguidInstanceId);
    HRESULT Reset();
}

enum SYNC_REGISTRATION_EVENT
{
    SRE_PROVIDER_ADDED = 0,
    SRE_PROVIDER_REMOVED = 1,
    SRE_PROVIDER_UPDATED = 2,
    SRE_PROVIDER_STATE_CHANGED = 3,
    SRE_CONFIGUI_ADDED = 4,
    SRE_CONFIGUI_REMOVED = 5,
    SRE_CONFIGUI_UPDATED = 6,
}

const GUID IID_ISyncRegistrationChange = {0xEEA0D9AE, 0x6B29, 0x43B4, [0x9E, 0x70, 0xE3, 0xAE, 0x33, 0xBB, 0x2C, 0x3B]};
@GUID(0xEEA0D9AE, 0x6B29, 0x43B4, [0x9E, 0x70, 0xE3, 0xAE, 0x33, 0xBB, 0x2C, 0x3B]);
interface ISyncRegistrationChange : IUnknown
{
    HRESULT GetEvent(SYNC_REGISTRATION_EVENT* psreEvent);
    HRESULT GetInstanceId(Guid* pguidInstanceId);
}

