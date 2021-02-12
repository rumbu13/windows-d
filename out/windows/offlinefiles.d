module windows.offlinefiles;

public import system;
public import windows.automation;
public import windows.com;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

const GUID CLSID_OfflineFilesSetting = {0xFD3659E9, 0xA920, 0x4123, [0xAD, 0x64, 0x7F, 0xC7, 0x6C, 0x7A, 0xAC, 0xDF]};
@GUID(0xFD3659E9, 0xA920, 0x4123, [0xAD, 0x64, 0x7F, 0xC7, 0x6C, 0x7A, 0xAC, 0xDF]);
struct OfflineFilesSetting;

const GUID CLSID_OfflineFilesCache = {0x48C6BE7C, 0x3871, 0x43CC, [0xB4, 0x6F, 0x14, 0x49, 0xA1, 0xBB, 0x2F, 0xF3]};
@GUID(0x48C6BE7C, 0x3871, 0x43CC, [0xB4, 0x6F, 0x14, 0x49, 0xA1, 0xBB, 0x2F, 0xF3]);
struct OfflineFilesCache;

enum OFFLINEFILES_ITEM_TYPE
{
    OFFLINEFILES_ITEM_TYPE_FILE = 0,
    OFFLINEFILES_ITEM_TYPE_DIRECTORY = 1,
    OFFLINEFILES_ITEM_TYPE_SHARE = 2,
    OFFLINEFILES_ITEM_TYPE_SERVER = 3,
}

enum OFFLINEFILES_ITEM_COPY
{
    OFFLINEFILES_ITEM_COPY_LOCAL = 0,
    OFFLINEFILES_ITEM_COPY_REMOTE = 1,
    OFFLINEFILES_ITEM_COPY_ORIGINAL = 2,
}

enum OFFLINEFILES_CONNECT_STATE
{
    OFFLINEFILES_CONNECT_STATE_UNKNOWN = 0,
    OFFLINEFILES_CONNECT_STATE_OFFLINE = 1,
    OFFLINEFILES_CONNECT_STATE_ONLINE = 2,
    OFFLINEFILES_CONNECT_STATE_TRANSPARENTLY_CACHED = 3,
    OFFLINEFILES_CONNECT_STATE_PARTLY_TRANSPARENTLY_CACHED = 4,
}

enum OFFLINEFILES_OFFLINE_REASON
{
    OFFLINEFILES_OFFLINE_REASON_UNKNOWN = 0,
    OFFLINEFILES_OFFLINE_REASON_NOT_APPLICABLE = 1,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_FORCED = 2,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_SLOW = 3,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_ERROR = 4,
    OFFLINEFILES_OFFLINE_REASON_ITEM_VERSION_CONFLICT = 5,
    OFFLINEFILES_OFFLINE_REASON_ITEM_SUSPENDED = 6,
}

enum OFFLINEFILES_CACHING_MODE
{
    OFFLINEFILES_CACHING_MODE_NONE = 0,
    OFFLINEFILES_CACHING_MODE_NOCACHING = 1,
    OFFLINEFILES_CACHING_MODE_MANUAL = 2,
    OFFLINEFILES_CACHING_MODE_AUTO_DOC = 3,
    OFFLINEFILES_CACHING_MODE_AUTO_PROGANDDOC = 4,
}

enum OFFLINEFILES_OP_RESPONSE
{
    OFFLINEFILES_OP_CONTINUE = 0,
    OFFLINEFILES_OP_RETRY = 1,
    OFFLINEFILES_OP_ABORT = 2,
}

enum OFFLINEFILES_EVENTS
{
    OFFLINEFILES_EVENT_CACHEMOVED = 0,
    OFFLINEFILES_EVENT_CACHEISFULL = 1,
    OFFLINEFILES_EVENT_CACHEISCORRUPTED = 2,
    OFFLINEFILES_EVENT_ENABLED = 3,
    OFFLINEFILES_EVENT_ENCRYPTIONCHANGED = 4,
    OFFLINEFILES_EVENT_SYNCBEGIN = 5,
    OFFLINEFILES_EVENT_SYNCFILERESULT = 6,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECADDED = 7,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECUPDATED = 8,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECREMOVED = 9,
    OFFLINEFILES_EVENT_SYNCEND = 10,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCBEGIN = 11,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCEND = 12,
    OFFLINEFILES_EVENT_NETTRANSPORTARRIVED = 13,
    OFFLINEFILES_EVENT_NONETTRANSPORTS = 14,
    OFFLINEFILES_EVENT_ITEMDISCONNECTED = 15,
    OFFLINEFILES_EVENT_ITEMRECONNECTED = 16,
    OFFLINEFILES_EVENT_ITEMAVAILABLEOFFLINE = 17,
    OFFLINEFILES_EVENT_ITEMNOTAVAILABLEOFFLINE = 18,
    OFFLINEFILES_EVENT_ITEMPINNED = 19,
    OFFLINEFILES_EVENT_ITEMNOTPINNED = 20,
    OFFLINEFILES_EVENT_ITEMMODIFIED = 21,
    OFFLINEFILES_EVENT_ITEMADDEDTOCACHE = 22,
    OFFLINEFILES_EVENT_ITEMDELETEDFROMCACHE = 23,
    OFFLINEFILES_EVENT_ITEMRENAMED = 24,
    OFFLINEFILES_EVENT_DATALOST = 25,
    OFFLINEFILES_EVENT_PING = 26,
    OFFLINEFILES_EVENT_ITEMRECONNECTBEGIN = 27,
    OFFLINEFILES_EVENT_ITEMRECONNECTEND = 28,
    OFFLINEFILES_EVENT_CACHEEVICTBEGIN = 29,
    OFFLINEFILES_EVENT_CACHEEVICTEND = 30,
    OFFLINEFILES_EVENT_POLICYCHANGEDETECTED = 31,
    OFFLINEFILES_EVENT_PREFERENCECHANGEDETECTED = 32,
    OFFLINEFILES_EVENT_SETTINGSCHANGESAPPLIED = 33,
    OFFLINEFILES_EVENT_TRANSPARENTCACHEITEMNOTIFY = 34,
    OFFLINEFILES_EVENT_PREFETCHFILEBEGIN = 35,
    OFFLINEFILES_EVENT_PREFETCHFILEEND = 36,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEBEGIN = 37,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEEND = 38,
    OFFLINEFILES_NUM_EVENTS = 39,
}

enum OFFLINEFILES_PATHFILTER_MATCH
{
    OFFLINEFILES_PATHFILTER_SELF = 0,
    OFFLINEFILES_PATHFILTER_CHILD = 1,
    OFFLINEFILES_PATHFILTER_DESCENDENT = 2,
    OFFLINEFILES_PATHFILTER_SELFORCHILD = 3,
    OFFLINEFILES_PATHFILTER_SELFORDESCENDENT = 4,
}

enum OFFLINEFILES_SYNC_CONFLICT_RESOLVE
{
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NONE = 0,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLOCAL = 1,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPREMOTE = 2,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES = 3,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST = 4,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_LOG = 5,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_SKIP = 6,
    OFFLINEFILES_SYNC_CONFLICT_ABORT = 7,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NUMCODES = 8,
}

enum OFFLINEFILES_ITEM_TIME
{
    OFFLINEFILES_ITEM_TIME_CREATION = 0,
    OFFLINEFILES_ITEM_TIME_LASTACCESS = 1,
    OFFLINEFILES_ITEM_TIME_LASTWRITE = 2,
}

enum OFFLINEFILES_COMPARE
{
    OFFLINEFILES_COMPARE_EQ = 0,
    OFFLINEFILES_COMPARE_NEQ = 1,
    OFFLINEFILES_COMPARE_LT = 2,
    OFFLINEFILES_COMPARE_GT = 3,
    OFFLINEFILES_COMPARE_LTE = 4,
    OFFLINEFILES_COMPARE_GTE = 5,
}

enum OFFLINEFILES_SETTING_VALUE_TYPE
{
    OFFLINEFILES_SETTING_VALUE_UI4 = 0,
    OFFLINEFILES_SETTING_VALUE_BSTR = 1,
    OFFLINEFILES_SETTING_VALUE_BSTR_DBLNULTERM = 2,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_UI4 = 3,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_BSTR = 4,
}

enum OFFLINEFILES_SYNC_OPERATION
{
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_SERVER = 0,
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_CLIENT = 1,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_SERVER = 2,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_CLIENT = 3,
    OFFLINEFILES_SYNC_OPERATION_DELETE_SERVER_COPY = 4,
    OFFLINEFILES_SYNC_OPERATION_DELETE_CLIENT_COPY = 5,
    OFFLINEFILES_SYNC_OPERATION_PIN = 6,
    OFFLINEFILES_SYNC_OPERATION_PREPARE = 7,
}

enum OFFLINEFILES_SYNC_STATE
{
    OFFLINEFILES_SYNC_STATE_Stable = 0,
    OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer = 1,
    OFFLINEFILES_SYNC_STATE_FileOnClient_NoServerCopy = 2,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer = 3,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer = 4,
    OFFLINEFILES_SYNC_STATE_DirOnClient_NoServerCopy = 5,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_NoServerCopy = 6,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer = 7,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer = 8,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer = 9,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer = 10,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DeletedOnServer = 11,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer = 12,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer = 13,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer = 14,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DeletedOnServer = 15,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_ChangedOnServer = 16,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DeletedOnServer = 17,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirOnServer = 18,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirChangedOnServer = 19,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_NoServerCopy = 20,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirOnServer = 21,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer = 22,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer = 23,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirChangedOnServer = 24,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DeletedOnServer = 25,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer = 26,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer = 27,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_ChangedOnServer = 28,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_DeletedOnServer = 29,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileOnServer = 30,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirOnServer = 31,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileChangedOnServer = 32,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirChangedOnServer = 33,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileOnServer = 34,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirOnServer = 35,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileChangedOnServer = 36,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirChangedOnServer = 37,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient = 38,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient = 39,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnClient = 40,
    OFFLINEFILES_SYNC_STATE_DirSparseOnClient = 41,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient = 42,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnClient = 43,
    OFFLINEFILES_SYNC_STATE_FileChangedOnServer = 44,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnServer = 45,
    OFFLINEFILES_SYNC_STATE_FileDeletedOnServer = 46,
    OFFLINEFILES_SYNC_STATE_DirChangedOnServer = 47,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnServer = 48,
    OFFLINEFILES_SYNC_STATE_DirDeletedOnServer = 49,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileOnServer = 50,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileChangedOnServer = 51,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirOnServer = 52,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirChangedOnServer = 53,
    OFFLINEFILES_SYNC_STATE_NUMSTATES = 54,
}

const GUID IID_IOfflineFilesEvents = {0xE25585C1, 0x0CAA, 0x4EB1, [0x87, 0x3B, 0x1C, 0xAE, 0x5B, 0x77, 0xC3, 0x14]};
@GUID(0xE25585C1, 0x0CAA, 0x4EB1, [0x87, 0x3B, 0x1C, 0xAE, 0x5B, 0x77, 0xC3, 0x14]);
interface IOfflineFilesEvents : IUnknown
{
    HRESULT CacheMoved(const(wchar)* pszOldPath, const(wchar)* pszNewPath);
    HRESULT CacheIsFull();
    HRESULT CacheIsCorrupted();
    HRESULT Enabled(BOOL bEnabled);
    HRESULT EncryptionChanged(BOOL bWasEncrypted, BOOL bWasPartial, BOOL bIsEncrypted, BOOL bIsPartial);
    HRESULT SyncBegin(const(Guid)* rSyncId);
    HRESULT SyncFileResult(const(Guid)* rSyncId, const(wchar)* pszFile, HRESULT hrResult);
    HRESULT SyncConflictRecAdded(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncConflictRecUpdated(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncConflictRecRemoved(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncEnd(const(Guid)* rSyncId, HRESULT hrResult);
    HRESULT NetTransportArrived();
    HRESULT NoNetTransports();
    HRESULT ItemDisconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemReconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemNotAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemNotPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemModified(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, BOOL bModifiedAttributes);
    HRESULT ItemAddedToCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemDeletedFromCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemRenamed(const(wchar)* pszOldPath, const(wchar)* pszNewPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT DataLost();
    HRESULT Ping();
}

const GUID IID_IOfflineFilesEvents2 = {0x1EAD8F56, 0xFF76, 0x4FAA, [0xA7, 0x95, 0x6F, 0x6E, 0xF7, 0x92, 0x49, 0x8B]};
@GUID(0x1EAD8F56, 0xFF76, 0x4FAA, [0xA7, 0x95, 0x6F, 0x6E, 0xF7, 0x92, 0x49, 0x8B]);
interface IOfflineFilesEvents2 : IOfflineFilesEvents
{
    HRESULT ItemReconnectBegin();
    HRESULT ItemReconnectEnd();
    HRESULT CacheEvictBegin();
    HRESULT CacheEvictEnd();
    HRESULT BackgroundSyncBegin(uint dwSyncControlFlags);
    HRESULT BackgroundSyncEnd(uint dwSyncControlFlags);
    HRESULT PolicyChangeDetected();
    HRESULT PreferenceChangeDetected();
    HRESULT SettingsChangesApplied();
}

const GUID IID_IOfflineFilesEvents3 = {0x9BA04A45, 0xEE69, 0x42F0, [0x9A, 0xB1, 0x7D, 0xB5, 0xC8, 0x80, 0x58, 0x08]};
@GUID(0x9BA04A45, 0xEE69, 0x42F0, [0x9A, 0xB1, 0x7D, 0xB5, 0xC8, 0x80, 0x58, 0x08]);
interface IOfflineFilesEvents3 : IOfflineFilesEvents2
{
    HRESULT TransparentCacheItemNotify(const(wchar)* pszPath, OFFLINEFILES_EVENTS EventType, OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, BOOL bModifiedAttributes, const(wchar)* pzsOldPath);
    HRESULT PrefetchFileBegin(const(wchar)* pszPath);
    HRESULT PrefetchFileEnd(const(wchar)* pszPath, HRESULT hrResult);
}

const GUID IID_IOfflineFilesEvents4 = {0xDBD69B1E, 0xC7D2, 0x473E, [0xB3, 0x5F, 0x9D, 0x8C, 0x24, 0xC0, 0xC4, 0x84]};
@GUID(0xDBD69B1E, 0xC7D2, 0x473E, [0xB3, 0x5F, 0x9D, 0x8C, 0x24, 0xC0, 0xC4, 0x84]);
interface IOfflineFilesEvents4 : IOfflineFilesEvents3
{
    HRESULT PrefetchCloseHandleBegin();
    HRESULT PrefetchCloseHandleEnd(uint dwClosedHandleCount, uint dwOpenHandleCount, HRESULT hrResult);
}

const GUID IID_IOfflineFilesEventsFilter = {0x33FC4E1B, 0x0716, 0x40FA, [0xBA, 0x65, 0x6E, 0x62, 0xA8, 0x4A, 0x84, 0x6F]};
@GUID(0x33FC4E1B, 0x0716, 0x40FA, [0xBA, 0x65, 0x6E, 0x62, 0xA8, 0x4A, 0x84, 0x6F]);
interface IOfflineFilesEventsFilter : IUnknown
{
    HRESULT GetPathFilter(ushort** ppszFilter, OFFLINEFILES_PATHFILTER_MATCH* pMatch);
    HRESULT GetIncludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
    HRESULT GetExcludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
}

const GUID IID_IOfflineFilesErrorInfo = {0x7112FA5F, 0x7571, 0x435A, [0x8E, 0xB7, 0x19, 0x5C, 0x7C, 0x14, 0x29, 0xBC]};
@GUID(0x7112FA5F, 0x7571, 0x435A, [0x8E, 0xB7, 0x19, 0x5C, 0x7C, 0x14, 0x29, 0xBC]);
interface IOfflineFilesErrorInfo : IUnknown
{
    HRESULT GetRawData(BYTE_BLOB** ppBlob);
    HRESULT GetDescription(ushort** ppszDescription);
}

const GUID IID_IOfflineFilesSyncErrorItemInfo = {0xECDBAF0D, 0x6A18, 0x4D55, [0x80, 0x17, 0x10, 0x8F, 0x76, 0x60, 0xBA, 0x44]};
@GUID(0xECDBAF0D, 0x6A18, 0x4D55, [0x80, 0x17, 0x10, 0x8F, 0x76, 0x60, 0xBA, 0x44]);
interface IOfflineFilesSyncErrorItemInfo : IUnknown
{
    HRESULT GetFileAttributesA(uint* pdwAttributes);
    HRESULT GetFileTimes(FILETIME* pftLastWrite, FILETIME* pftChange);
    HRESULT GetFileSize(LARGE_INTEGER* pSize);
}

const GUID IID_IOfflineFilesSyncErrorInfo = {0x59F95E46, 0xEB54, 0x49D1, [0xBE, 0x76, 0xDE, 0x95, 0x45, 0x8D, 0x01, 0xB0]};
@GUID(0x59F95E46, 0xEB54, 0x49D1, [0xBE, 0x76, 0xDE, 0x95, 0x45, 0x8D, 0x01, 0xB0]);
interface IOfflineFilesSyncErrorInfo : IOfflineFilesErrorInfo
{
    HRESULT GetSyncOperation(OFFLINEFILES_SYNC_OPERATION* pSyncOp);
    HRESULT GetItemChangeFlags(uint* pdwItemChangeFlags);
    HRESULT InfoEnumerated(int* pbLocalEnumerated, int* pbRemoteEnumerated, int* pbOriginalEnumerated);
    HRESULT InfoAvailable(int* pbLocalInfo, int* pbRemoteInfo, int* pbOriginalInfo);
    HRESULT GetLocalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    HRESULT GetRemoteInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    HRESULT GetOriginalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
}

const GUID IID_IOfflineFilesProgress = {0xFAD63237, 0xC55B, 0x4911, [0x98, 0x50, 0xBC, 0xF9, 0x6D, 0x4C, 0x97, 0x9E]};
@GUID(0xFAD63237, 0xC55B, 0x4911, [0x98, 0x50, 0xBC, 0xF9, 0x6D, 0x4C, 0x97, 0x9E]);
interface IOfflineFilesProgress : IUnknown
{
    HRESULT Begin(int* pbAbort);
    HRESULT QueryAbort(int* pbAbort);
    HRESULT End(HRESULT hrResult);
}

const GUID IID_IOfflineFilesSimpleProgress = {0xC34F7F9B, 0xC43D, 0x4F9D, [0xA7, 0x76, 0xC0, 0xEB, 0x6D, 0xE5, 0xD4, 0x01]};
@GUID(0xC34F7F9B, 0xC43D, 0x4F9D, [0xA7, 0x76, 0xC0, 0xEB, 0x6D, 0xE5, 0xD4, 0x01]);
interface IOfflineFilesSimpleProgress : IOfflineFilesProgress
{
    HRESULT ItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    HRESULT ItemResult(const(wchar)* pszFile, HRESULT hrResult, OFFLINEFILES_OP_RESPONSE* pResponse);
}

const GUID IID_IOfflineFilesSyncProgress = {0x6931F49A, 0x6FC7, 0x4C1B, [0xB2, 0x65, 0x56, 0x79, 0x3F, 0xC4, 0x51, 0xB7]};
@GUID(0x6931F49A, 0x6FC7, 0x4C1B, [0xB2, 0x65, 0x56, 0x79, 0x3F, 0xC4, 0x51, 0xB7]);
interface IOfflineFilesSyncProgress : IOfflineFilesProgress
{
    HRESULT SyncItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    HRESULT SyncItemResult(const(wchar)* pszFile, HRESULT hrResult, IOfflineFilesSyncErrorInfo pErrorInfo, OFFLINEFILES_OP_RESPONSE* pResponse);
}

const GUID IID_IOfflineFilesSyncConflictHandler = {0xB6DD5092, 0xC65C, 0x46B6, [0x97, 0xB8, 0xFA, 0xDD, 0x08, 0xE7, 0xE1, 0xBE]};
@GUID(0xB6DD5092, 0xC65C, 0x46B6, [0x97, 0xB8, 0xFA, 0xDD, 0x08, 0xE7, 0xE1, 0xBE]);
interface IOfflineFilesSyncConflictHandler : IUnknown
{
    HRESULT ResolveConflict(const(wchar)* pszPath, uint fStateKnown, OFFLINEFILES_SYNC_STATE state, uint fChangeDetails, OFFLINEFILES_SYNC_CONFLICT_RESOLVE* pConflictResolution, ushort** ppszNewName);
}

const GUID IID_IOfflineFilesItemFilter = {0xF4B5A26C, 0xDC05, 0x4F20, [0xAD, 0xA4, 0x55, 0x1F, 0x10, 0x77, 0xBE, 0x5C]};
@GUID(0xF4B5A26C, 0xDC05, 0x4F20, [0xAD, 0xA4, 0x55, 0x1F, 0x10, 0x77, 0xBE, 0x5C]);
interface IOfflineFilesItemFilter : IUnknown
{
    HRESULT GetFilterFlags(ulong* pullFlags, ulong* pullMask);
    HRESULT GetTimeFilter(FILETIME* pftTime, int* pbEvalTimeOfDay, OFFLINEFILES_ITEM_TIME* pTimeType, OFFLINEFILES_COMPARE* pCompare);
    HRESULT GetPatternFilter(const(wchar)* pszPattern, uint cchPattern);
}

const GUID IID_IOfflineFilesItem = {0x4A753DA6, 0xE044, 0x4F12, [0xA7, 0x18, 0x5D, 0x14, 0xD0, 0x79, 0xA9, 0x06]};
@GUID(0x4A753DA6, 0xE044, 0x4F12, [0xA7, 0x18, 0x5D, 0x14, 0xD0, 0x79, 0xA9, 0x06]);
interface IOfflineFilesItem : IUnknown
{
    HRESULT GetItemType(OFFLINEFILES_ITEM_TYPE* pItemType);
    HRESULT GetPath(ushort** ppszPath);
    HRESULT GetParentItem(IOfflineFilesItem* ppItem);
    HRESULT Refresh(uint dwQueryFlags);
    HRESULT IsMarkedForDeletion(int* pbMarkedForDeletion);
}

const GUID IID_IOfflineFilesServerItem = {0x9B1C9576, 0xA92B, 0x4151, [0x8E, 0x9E, 0x7C, 0x7B, 0x3E, 0xC2, 0xE0, 0x16]};
@GUID(0x9B1C9576, 0xA92B, 0x4151, [0x8E, 0x9E, 0x7C, 0x7B, 0x3E, 0xC2, 0xE0, 0x16]);
interface IOfflineFilesServerItem : IOfflineFilesItem
{
}

const GUID IID_IOfflineFilesShareItem = {0xBAB7E48D, 0x4804, 0x41B5, [0xA4, 0x4D, 0x0F, 0x19, 0x9B, 0x06, 0xB1, 0x45]};
@GUID(0xBAB7E48D, 0x4804, 0x41B5, [0xA4, 0x4D, 0x0F, 0x19, 0x9B, 0x06, 0xB1, 0x45]);
interface IOfflineFilesShareItem : IOfflineFilesItem
{
}

const GUID IID_IOfflineFilesDirectoryItem = {0x2273597A, 0xA08C, 0x4A00, [0xA3, 0x7A, 0xC1, 0xAE, 0x4E, 0x9A, 0x1C, 0xFD]};
@GUID(0x2273597A, 0xA08C, 0x4A00, [0xA3, 0x7A, 0xC1, 0xAE, 0x4E, 0x9A, 0x1C, 0xFD]);
interface IOfflineFilesDirectoryItem : IOfflineFilesItem
{
}

const GUID IID_IOfflineFilesFileItem = {0x8DFADEAD, 0x26C2, 0x4EFF, [0x8A, 0x72, 0x6B, 0x50, 0x72, 0x3D, 0x9A, 0x00]};
@GUID(0x8DFADEAD, 0x26C2, 0x4EFF, [0x8A, 0x72, 0x6B, 0x50, 0x72, 0x3D, 0x9A, 0x00]);
interface IOfflineFilesFileItem : IOfflineFilesItem
{
    HRESULT IsSparse(int* pbIsSparse);
    HRESULT IsEncrypted(int* pbIsEncrypted);
}

const GUID IID_IEnumOfflineFilesItems = {0xDA70E815, 0xC361, 0x4407, [0xBC, 0x0B, 0x0D, 0x70, 0x46, 0xE5, 0xF2, 0xCD]};
@GUID(0xDA70E815, 0xC361, 0x4407, [0xBC, 0x0B, 0x0D, 0x70, 0x46, 0xE5, 0xF2, 0xCD]);
interface IEnumOfflineFilesItems : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOfflineFilesItems* ppenum);
}

const GUID IID_IOfflineFilesItemContainer = {0x3836F049, 0x9413, 0x45DD, [0xBF, 0x46, 0xB5, 0xAA, 0xA8, 0x2D, 0xC3, 0x10]};
@GUID(0x3836F049, 0x9413, 0x45DD, [0xBF, 0x46, 0xB5, 0xAA, 0xA8, 0x2D, 0xC3, 0x10]);
interface IOfflineFilesItemContainer : IUnknown
{
    HRESULT EnumItems(uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
    HRESULT EnumItemsEx(IOfflineFilesItemFilter pIncludeFileFilter, IOfflineFilesItemFilter pIncludeDirFilter, IOfflineFilesItemFilter pExcludeFileFilter, IOfflineFilesItemFilter pExcludeDirFilter, uint dwEnumFlags, uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
}

const GUID IID_IOfflineFilesChangeInfo = {0xA96E6FA4, 0xE0D1, 0x4C29, [0x96, 0x0B, 0xEE, 0x50, 0x8F, 0xE6, 0x8C, 0x72]};
@GUID(0xA96E6FA4, 0xE0D1, 0x4C29, [0x96, 0x0B, 0xEE, 0x50, 0x8F, 0xE6, 0x8C, 0x72]);
interface IOfflineFilesChangeInfo : IUnknown
{
    HRESULT IsDirty(int* pbDirty);
    HRESULT IsDeletedOffline(int* pbDeletedOffline);
    HRESULT IsCreatedOffline(int* pbCreatedOffline);
    HRESULT IsLocallyModifiedData(int* pbLocallyModifiedData);
    HRESULT IsLocallyModifiedAttributes(int* pbLocallyModifiedAttributes);
    HRESULT IsLocallyModifiedTime(int* pbLocallyModifiedTime);
}

const GUID IID_IOfflineFilesDirtyInfo = {0x0F50CE33, 0xBAC9, 0x4EAA, [0xA1, 0x1D, 0xDA, 0x0E, 0x52, 0x7D, 0x04, 0x7D]};
@GUID(0x0F50CE33, 0xBAC9, 0x4EAA, [0xA1, 0x1D, 0xDA, 0x0E, 0x52, 0x7D, 0x04, 0x7D]);
interface IOfflineFilesDirtyInfo : IUnknown
{
    HRESULT LocalDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
    HRESULT RemoteDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
}

const GUID IID_IOfflineFilesFileSysInfo = {0xBC1A163F, 0x7BFD, 0x4D88, [0x9C, 0x66, 0x96, 0xEA, 0x9A, 0x6A, 0x3D, 0x6B]};
@GUID(0xBC1A163F, 0x7BFD, 0x4D88, [0x9C, 0x66, 0x96, 0xEA, 0x9A, 0x6A, 0x3D, 0x6B]);
interface IOfflineFilesFileSysInfo : IUnknown
{
    HRESULT GetAttributes(OFFLINEFILES_ITEM_COPY copy, uint* pdwAttributes);
    HRESULT GetTimes(OFFLINEFILES_ITEM_COPY copy, FILETIME* pftCreationTime, FILETIME* pftLastWriteTime, FILETIME* pftChangeTime, FILETIME* pftLastAccessTime);
    HRESULT GetFileSize(OFFLINEFILES_ITEM_COPY copy, LARGE_INTEGER* pSize);
}

const GUID IID_IOfflineFilesPinInfo = {0x5B2B0655, 0xB3FD, 0x497D, [0xAD, 0xEB, 0xBD, 0x15, 0x6B, 0xC8, 0x35, 0x5B]};
@GUID(0x5B2B0655, 0xB3FD, 0x497D, [0xAD, 0xEB, 0xBD, 0x15, 0x6B, 0xC8, 0x35, 0x5B]);
interface IOfflineFilesPinInfo : IUnknown
{
    HRESULT IsPinned(int* pbPinned);
    HRESULT IsPinnedForUser(int* pbPinnedForUser, int* pbInherit);
    HRESULT IsPinnedForUserByPolicy(int* pbPinnedForUser, int* pbInherit);
    HRESULT IsPinnedForComputer(int* pbPinnedForComputer, int* pbInherit);
    HRESULT IsPinnedForFolderRedirection(int* pbPinnedForFolderRedirection, int* pbInherit);
}

const GUID IID_IOfflineFilesPinInfo2 = {0x623C58A2, 0x42ED, 0x4AD7, [0xB6, 0x9A, 0x0F, 0x1B, 0x30, 0xA7, 0x2D, 0x0D]};
@GUID(0x623C58A2, 0x42ED, 0x4AD7, [0xB6, 0x9A, 0x0F, 0x1B, 0x30, 0xA7, 0x2D, 0x0D]);
interface IOfflineFilesPinInfo2 : IOfflineFilesPinInfo
{
    HRESULT IsPartlyPinned(int* pbPartlyPinned);
}

const GUID IID_IOfflineFilesTransparentCacheInfo = {0xBCAF4A01, 0x5B68, 0x4B56, [0xA6, 0xA1, 0x8D, 0x27, 0x86, 0xED, 0xE8, 0xE3]};
@GUID(0xBCAF4A01, 0x5B68, 0x4B56, [0xA6, 0xA1, 0x8D, 0x27, 0x86, 0xED, 0xE8, 0xE3]);
interface IOfflineFilesTransparentCacheInfo : IUnknown
{
    HRESULT IsTransparentlyCached(int* pbTransparentlyCached);
}

const GUID IID_IOfflineFilesGhostInfo = {0x2B09D48C, 0x8AB5, 0x464F, [0xA7, 0x55, 0xA5, 0x9D, 0x92, 0xF9, 0x94, 0x29]};
@GUID(0x2B09D48C, 0x8AB5, 0x464F, [0xA7, 0x55, 0xA5, 0x9D, 0x92, 0xF9, 0x94, 0x29]);
interface IOfflineFilesGhostInfo : IUnknown
{
    HRESULT IsGhosted(int* pbGhosted);
}

const GUID IID_IOfflineFilesConnectionInfo = {0xEFB23A09, 0xA867, 0x4BE8, [0x83, 0xA6, 0x86, 0x96, 0x9A, 0x7D, 0x08, 0x56]};
@GUID(0xEFB23A09, 0xA867, 0x4BE8, [0x83, 0xA6, 0x86, 0x96, 0x9A, 0x7D, 0x08, 0x56]);
interface IOfflineFilesConnectionInfo : IUnknown
{
    HRESULT GetConnectState(OFFLINEFILES_CONNECT_STATE* pConnectState, OFFLINEFILES_OFFLINE_REASON* pOfflineReason);
    HRESULT SetConnectState(HWND hwndParent, uint dwFlags, OFFLINEFILES_CONNECT_STATE ConnectState);
    HRESULT TransitionOnline(HWND hwndParent, uint dwFlags);
    HRESULT TransitionOffline(HWND hwndParent, uint dwFlags, BOOL bForceOpenFilesClosed, int* pbOpenFilesPreventedTransition);
}

const GUID IID_IOfflineFilesShareInfo = {0x7BCC43E7, 0x31CE, 0x4CA4, [0x8C, 0xCD, 0x1C, 0xFF, 0x2D, 0xC4, 0x94, 0xDA]};
@GUID(0x7BCC43E7, 0x31CE, 0x4CA4, [0x8C, 0xCD, 0x1C, 0xFF, 0x2D, 0xC4, 0x94, 0xDA]);
interface IOfflineFilesShareInfo : IUnknown
{
    HRESULT GetShareItem(IOfflineFilesShareItem* ppShareItem);
    HRESULT GetShareCachingMode(OFFLINEFILES_CACHING_MODE* pCachingMode);
    HRESULT IsShareDfsJunction(int* pbIsDfsJunction);
}

const GUID IID_IOfflineFilesSuspend = {0x62C4560F, 0xBC0B, 0x48CA, [0xAD, 0x9D, 0x34, 0xCB, 0x52, 0x8D, 0x99, 0xA9]};
@GUID(0x62C4560F, 0xBC0B, 0x48CA, [0xAD, 0x9D, 0x34, 0xCB, 0x52, 0x8D, 0x99, 0xA9]);
interface IOfflineFilesSuspend : IUnknown
{
    HRESULT SuspendRoot(BOOL bSuspend);
}

const GUID IID_IOfflineFilesSuspendInfo = {0xA457C25B, 0x4E9C, 0x4B04, [0x85, 0xAF, 0x89, 0x32, 0xCC, 0xD9, 0x78, 0x89]};
@GUID(0xA457C25B, 0x4E9C, 0x4B04, [0x85, 0xAF, 0x89, 0x32, 0xCC, 0xD9, 0x78, 0x89]);
interface IOfflineFilesSuspendInfo : IUnknown
{
    HRESULT IsSuspended(int* pbSuspended, int* pbSuspendedRoot);
}

const GUID IID_IOfflineFilesSetting = {0xD871D3F7, 0xF613, 0x48A1, [0x82, 0x7E, 0x7A, 0x34, 0xE5, 0x60, 0xFF, 0xF6]};
@GUID(0xD871D3F7, 0xF613, 0x48A1, [0x82, 0x7E, 0x7A, 0x34, 0xE5, 0x60, 0xFF, 0xF6]);
interface IOfflineFilesSetting : IUnknown
{
    HRESULT GetName(ushort** ppszName);
    HRESULT GetValueType(OFFLINEFILES_SETTING_VALUE_TYPE* pType);
    HRESULT GetPreference(VARIANT* pvarValue, uint dwScope);
    HRESULT GetPreferenceScope(uint* pdwScope);
    HRESULT SetPreference(const(VARIANT)* pvarValue, uint dwScope);
    HRESULT DeletePreference(uint dwScope);
    HRESULT GetPolicy(VARIANT* pvarValue, uint dwScope);
    HRESULT GetPolicyScope(uint* pdwScope);
    HRESULT GetValue(VARIANT* pvarValue, int* pbSetByPolicy);
}

const GUID IID_IEnumOfflineFilesSettings = {0x729680C4, 0x1A38, 0x47BC, [0x9E, 0x5C, 0x02, 0xC5, 0x15, 0x62, 0xAC, 0x30]};
@GUID(0x729680C4, 0x1A38, 0x47BC, [0x9E, 0x5C, 0x02, 0xC5, 0x15, 0x62, 0xAC, 0x30]);
interface IEnumOfflineFilesSettings : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOfflineFilesSettings* ppenum);
}

const GUID IID_IOfflineFilesCache = {0x855D6203, 0x7914, 0x48B9, [0x8D, 0x40, 0x4C, 0x56, 0xF5, 0xAC, 0xFF, 0xC5]};
@GUID(0x855D6203, 0x7914, 0x48B9, [0x8D, 0x40, 0x4C, 0x56, 0xF5, 0xAC, 0xFF, 0xC5]);
interface IOfflineFilesCache : IUnknown
{
    HRESULT Synchronize(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bAsync, uint dwSyncControl, IOfflineFilesSyncConflictHandler pISyncConflictHandler, IOfflineFilesSyncProgress pIProgress, Guid* pSyncId);
    HRESULT DeleteItems(char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, IOfflineFilesSimpleProgress pIProgress);
    HRESULT DeleteItemsForUser(const(wchar)* pszUser, char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, IOfflineFilesSimpleProgress pIProgress);
    HRESULT Pin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, IOfflineFilesSyncProgress pIProgress);
    HRESULT Unpin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, IOfflineFilesSyncProgress pIProgress);
    HRESULT GetEncryptionStatus(int* pbEncrypted, int* pbPartial);
    HRESULT Encrypt(HWND hwndParent, BOOL bEncrypt, uint dwEncryptionControlFlags, BOOL bAsync, IOfflineFilesSyncProgress pIProgress);
    HRESULT FindItem(const(wchar)* pszPath, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    HRESULT FindItemEx(const(wchar)* pszPath, IOfflineFilesItemFilter pIncludeFileFilter, IOfflineFilesItemFilter pIncludeDirFilter, IOfflineFilesItemFilter pExcludeFileFilter, IOfflineFilesItemFilter pExcludeDirFilter, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    HRESULT RenameItem(const(wchar)* pszPathOriginal, const(wchar)* pszPathNew, BOOL bReplaceIfExists);
    HRESULT GetLocation(ushort** ppszPath);
    HRESULT GetDiskSpaceInformationA(ulong* pcbVolumeTotal, ulong* pcbLimit, ulong* pcbUsed, ulong* pcbUnpinnedLimit, ulong* pcbUnpinnedUsed);
    HRESULT SetDiskSpaceLimits(ulong cbLimit, ulong cbUnpinnedLimit);
    HRESULT ProcessAdminPinPolicy(IOfflineFilesSyncProgress pPinProgress, IOfflineFilesSyncProgress pUnpinProgress);
    HRESULT GetSettingObject(const(wchar)* pszSettingName, IOfflineFilesSetting* ppSetting);
    HRESULT EnumSettingObjects(IEnumOfflineFilesSettings* ppEnum);
    HRESULT IsPathCacheable(const(wchar)* pszPath, int* pbCacheable, OFFLINEFILES_CACHING_MODE* pShareCachingMode);
}

const GUID IID_IOfflineFilesCache2 = {0x8C075039, 0x1551, 0x4ED9, [0x87, 0x81, 0x56, 0x70, 0x5C, 0x04, 0xD3, 0xC0]};
@GUID(0x8C075039, 0x1551, 0x4ED9, [0x87, 0x81, 0x56, 0x70, 0x5C, 0x04, 0xD3, 0xC0]);
interface IOfflineFilesCache2 : IOfflineFilesCache
{
    HRESULT RenameItemEx(const(wchar)* pszPathOriginal, const(wchar)* pszPathNew, BOOL bReplaceIfExists);
}

@DllImport("CSCAPI.dll")
uint OfflineFilesEnable(BOOL bEnable, int* pbRebootRequired);

@DllImport("CSCAPI.dll")
uint OfflineFilesStart();

@DllImport("CSCAPI.dll")
uint OfflineFilesQueryStatus(int* pbActive, int* pbEnabled);

@DllImport("CSCAPI.dll")
uint OfflineFilesQueryStatusEx(int* pbActive, int* pbEnabled, int* pbAvailable);

