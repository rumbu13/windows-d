module windows.offlinefiles;

public import windows.core;
public import windows.automation : VARIANT;
public import windows.com : BYTE_BLOB, HRESULT, IUnknown;
public import windows.systemservices : BOOL, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


enum : int
{
    OFFLINEFILES_ITEM_TYPE_FILE      = 0x00000000,
    OFFLINEFILES_ITEM_TYPE_DIRECTORY = 0x00000001,
    OFFLINEFILES_ITEM_TYPE_SHARE     = 0x00000002,
    OFFLINEFILES_ITEM_TYPE_SERVER    = 0x00000003,
}
alias OFFLINEFILES_ITEM_TYPE = int;

enum : int
{
    OFFLINEFILES_ITEM_COPY_LOCAL    = 0x00000000,
    OFFLINEFILES_ITEM_COPY_REMOTE   = 0x00000001,
    OFFLINEFILES_ITEM_COPY_ORIGINAL = 0x00000002,
}
alias OFFLINEFILES_ITEM_COPY = int;

enum : int
{
    OFFLINEFILES_CONNECT_STATE_UNKNOWN                     = 0x00000000,
    OFFLINEFILES_CONNECT_STATE_OFFLINE                     = 0x00000001,
    OFFLINEFILES_CONNECT_STATE_ONLINE                      = 0x00000002,
    OFFLINEFILES_CONNECT_STATE_TRANSPARENTLY_CACHED        = 0x00000003,
    OFFLINEFILES_CONNECT_STATE_PARTLY_TRANSPARENTLY_CACHED = 0x00000004,
}
alias OFFLINEFILES_CONNECT_STATE = int;

enum : int
{
    OFFLINEFILES_OFFLINE_REASON_UNKNOWN               = 0x00000000,
    OFFLINEFILES_OFFLINE_REASON_NOT_APPLICABLE        = 0x00000001,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_FORCED     = 0x00000002,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_SLOW       = 0x00000003,
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_ERROR      = 0x00000004,
    OFFLINEFILES_OFFLINE_REASON_ITEM_VERSION_CONFLICT = 0x00000005,
    OFFLINEFILES_OFFLINE_REASON_ITEM_SUSPENDED        = 0x00000006,
}
alias OFFLINEFILES_OFFLINE_REASON = int;

enum : int
{
    OFFLINEFILES_CACHING_MODE_NONE            = 0x00000000,
    OFFLINEFILES_CACHING_MODE_NOCACHING       = 0x00000001,
    OFFLINEFILES_CACHING_MODE_MANUAL          = 0x00000002,
    OFFLINEFILES_CACHING_MODE_AUTO_DOC        = 0x00000003,
    OFFLINEFILES_CACHING_MODE_AUTO_PROGANDDOC = 0x00000004,
}
alias OFFLINEFILES_CACHING_MODE = int;

enum : int
{
    OFFLINEFILES_OP_CONTINUE = 0x00000000,
    OFFLINEFILES_OP_RETRY    = 0x00000001,
    OFFLINEFILES_OP_ABORT    = 0x00000002,
}
alias OFFLINEFILES_OP_RESPONSE = int;

enum : int
{
    OFFLINEFILES_EVENT_CACHEMOVED                 = 0x00000000,
    OFFLINEFILES_EVENT_CACHEISFULL                = 0x00000001,
    OFFLINEFILES_EVENT_CACHEISCORRUPTED           = 0x00000002,
    OFFLINEFILES_EVENT_ENABLED                    = 0x00000003,
    OFFLINEFILES_EVENT_ENCRYPTIONCHANGED          = 0x00000004,
    OFFLINEFILES_EVENT_SYNCBEGIN                  = 0x00000005,
    OFFLINEFILES_EVENT_SYNCFILERESULT             = 0x00000006,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECADDED       = 0x00000007,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECUPDATED     = 0x00000008,
    OFFLINEFILES_EVENT_SYNCCONFLICTRECREMOVED     = 0x00000009,
    OFFLINEFILES_EVENT_SYNCEND                    = 0x0000000a,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCBEGIN        = 0x0000000b,
    OFFLINEFILES_EVENT_BACKGROUNDSYNCEND          = 0x0000000c,
    OFFLINEFILES_EVENT_NETTRANSPORTARRIVED        = 0x0000000d,
    OFFLINEFILES_EVENT_NONETTRANSPORTS            = 0x0000000e,
    OFFLINEFILES_EVENT_ITEMDISCONNECTED           = 0x0000000f,
    OFFLINEFILES_EVENT_ITEMRECONNECTED            = 0x00000010,
    OFFLINEFILES_EVENT_ITEMAVAILABLEOFFLINE       = 0x00000011,
    OFFLINEFILES_EVENT_ITEMNOTAVAILABLEOFFLINE    = 0x00000012,
    OFFLINEFILES_EVENT_ITEMPINNED                 = 0x00000013,
    OFFLINEFILES_EVENT_ITEMNOTPINNED              = 0x00000014,
    OFFLINEFILES_EVENT_ITEMMODIFIED               = 0x00000015,
    OFFLINEFILES_EVENT_ITEMADDEDTOCACHE           = 0x00000016,
    OFFLINEFILES_EVENT_ITEMDELETEDFROMCACHE       = 0x00000017,
    OFFLINEFILES_EVENT_ITEMRENAMED                = 0x00000018,
    OFFLINEFILES_EVENT_DATALOST                   = 0x00000019,
    OFFLINEFILES_EVENT_PING                       = 0x0000001a,
    OFFLINEFILES_EVENT_ITEMRECONNECTBEGIN         = 0x0000001b,
    OFFLINEFILES_EVENT_ITEMRECONNECTEND           = 0x0000001c,
    OFFLINEFILES_EVENT_CACHEEVICTBEGIN            = 0x0000001d,
    OFFLINEFILES_EVENT_CACHEEVICTEND              = 0x0000001e,
    OFFLINEFILES_EVENT_POLICYCHANGEDETECTED       = 0x0000001f,
    OFFLINEFILES_EVENT_PREFERENCECHANGEDETECTED   = 0x00000020,
    OFFLINEFILES_EVENT_SETTINGSCHANGESAPPLIED     = 0x00000021,
    OFFLINEFILES_EVENT_TRANSPARENTCACHEITEMNOTIFY = 0x00000022,
    OFFLINEFILES_EVENT_PREFETCHFILEBEGIN          = 0x00000023,
    OFFLINEFILES_EVENT_PREFETCHFILEEND            = 0x00000024,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEBEGIN   = 0x00000025,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEEND     = 0x00000026,
    OFFLINEFILES_NUM_EVENTS                       = 0x00000027,
}
alias OFFLINEFILES_EVENTS = int;

enum : int
{
    OFFLINEFILES_PATHFILTER_SELF             = 0x00000000,
    OFFLINEFILES_PATHFILTER_CHILD            = 0x00000001,
    OFFLINEFILES_PATHFILTER_DESCENDENT       = 0x00000002,
    OFFLINEFILES_PATHFILTER_SELFORCHILD      = 0x00000003,
    OFFLINEFILES_PATHFILTER_SELFORDESCENDENT = 0x00000004,
}
alias OFFLINEFILES_PATHFILTER_MATCH = int;

enum : int
{
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NONE           = 0x00000000,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLOCAL      = 0x00000001,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPREMOTE     = 0x00000002,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES = 0x00000003,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST     = 0x00000004,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_LOG            = 0x00000005,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_SKIP           = 0x00000006,
    OFFLINEFILES_SYNC_CONFLICT_ABORT                  = 0x00000007,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NUMCODES       = 0x00000008,
}
alias OFFLINEFILES_SYNC_CONFLICT_RESOLVE = int;

enum : int
{
    OFFLINEFILES_ITEM_TIME_CREATION   = 0x00000000,
    OFFLINEFILES_ITEM_TIME_LASTACCESS = 0x00000001,
    OFFLINEFILES_ITEM_TIME_LASTWRITE  = 0x00000002,
}
alias OFFLINEFILES_ITEM_TIME = int;

enum : int
{
    OFFLINEFILES_COMPARE_EQ  = 0x00000000,
    OFFLINEFILES_COMPARE_NEQ = 0x00000001,
    OFFLINEFILES_COMPARE_LT  = 0x00000002,
    OFFLINEFILES_COMPARE_GT  = 0x00000003,
    OFFLINEFILES_COMPARE_LTE = 0x00000004,
    OFFLINEFILES_COMPARE_GTE = 0x00000005,
}
alias OFFLINEFILES_COMPARE = int;

enum : int
{
    OFFLINEFILES_SETTING_VALUE_UI4                  = 0x00000000,
    OFFLINEFILES_SETTING_VALUE_BSTR                 = 0x00000001,
    OFFLINEFILES_SETTING_VALUE_BSTR_DBLNULTERM      = 0x00000002,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_UI4  = 0x00000003,
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_BSTR = 0x00000004,
}
alias OFFLINEFILES_SETTING_VALUE_TYPE = int;

enum : int
{
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_SERVER = 0x00000000,
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_CLIENT = 0x00000001,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_SERVER        = 0x00000002,
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_CLIENT        = 0x00000003,
    OFFLINEFILES_SYNC_OPERATION_DELETE_SERVER_COPY    = 0x00000004,
    OFFLINEFILES_SYNC_OPERATION_DELETE_CLIENT_COPY    = 0x00000005,
    OFFLINEFILES_SYNC_OPERATION_PIN                   = 0x00000006,
    OFFLINEFILES_SYNC_OPERATION_PREPARE               = 0x00000007,
}
alias OFFLINEFILES_SYNC_OPERATION = int;

enum : int
{
    OFFLINEFILES_SYNC_STATE_Stable                                             = 0x00000000,
    OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer                           = 0x00000001,
    OFFLINEFILES_SYNC_STATE_FileOnClient_NoServerCopy                          = 0x00000002,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer                           = 0x00000003,
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer                    = 0x00000004,
    OFFLINEFILES_SYNC_STATE_DirOnClient_NoServerCopy                           = 0x00000005,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_NoServerCopy                   = 0x00000006,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer            = 0x00000007,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer             = 0x00000008,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer                   = 0x00000009,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer                    = 0x0000000a,
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DeletedOnServer                = 0x0000000b,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer                = 0x0000000c,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer                    = 0x0000000d,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer             = 0x0000000e,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DeletedOnServer                = 0x0000000f,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_ChangedOnServer                 = 0x00000010,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DeletedOnServer                 = 0x00000011,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirOnServer                     = 0x00000012,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirChangedOnServer              = 0x00000013,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_NoServerCopy                    = 0x00000014,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirOnServer                     = 0x00000015,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer                    = 0x00000016,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer             = 0x00000017,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirChangedOnServer              = 0x00000018,
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DeletedOnServer                 = 0x00000019,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer                    = 0x0000001a,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer             = 0x0000001b,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_ChangedOnServer                 = 0x0000001c,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_DeletedOnServer                 = 0x0000001d,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileOnServer                          = 0x0000001e,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirOnServer                           = 0x0000001f,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileChangedOnServer                   = 0x00000020,
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirChangedOnServer                    = 0x00000021,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileOnServer                       = 0x00000022,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirOnServer                        = 0x00000023,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileChangedOnServer                = 0x00000024,
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirChangedOnServer                 = 0x00000025,
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient                                 = 0x00000026,
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient                                = 0x00000027,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnClient                                = 0x00000028,
    OFFLINEFILES_SYNC_STATE_DirSparseOnClient                                  = 0x00000029,
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient                                 = 0x0000002a,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnClient                                 = 0x0000002b,
    OFFLINEFILES_SYNC_STATE_FileChangedOnServer                                = 0x0000002c,
    OFFLINEFILES_SYNC_STATE_FileRenamedOnServer                                = 0x0000002d,
    OFFLINEFILES_SYNC_STATE_FileDeletedOnServer                                = 0x0000002e,
    OFFLINEFILES_SYNC_STATE_DirChangedOnServer                                 = 0x0000002f,
    OFFLINEFILES_SYNC_STATE_DirRenamedOnServer                                 = 0x00000030,
    OFFLINEFILES_SYNC_STATE_DirDeletedOnServer                                 = 0x00000031,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileOnServer        = 0x00000032,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileChangedOnServer = 0x00000033,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirOnServer         = 0x00000034,
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirChangedOnServer  = 0x00000035,
    OFFLINEFILES_SYNC_STATE_NUMSTATES                                          = 0x00000036,
}
alias OFFLINEFILES_SYNC_STATE = int;

// Functions

@DllImport("CSCAPI")
uint OfflineFilesEnable(BOOL bEnable, int* pbRebootRequired);

@DllImport("CSCAPI")
uint OfflineFilesStart();

@DllImport("CSCAPI")
uint OfflineFilesQueryStatus(int* pbActive, int* pbEnabled);

@DllImport("CSCAPI")
uint OfflineFilesQueryStatusEx(int* pbActive, int* pbEnabled, int* pbAvailable);


// Interfaces

@GUID("FD3659E9-A920-4123-AD64-7FC76C7AACDF")
struct OfflineFilesSetting;

@GUID("48C6BE7C-3871-43CC-B46F-1449A1BB2FF3")
struct OfflineFilesCache;

@GUID("E25585C1-0CAA-4EB1-873B-1CAE5B77C314")
interface IOfflineFilesEvents : IUnknown
{
    HRESULT CacheMoved(const(wchar)* pszOldPath, const(wchar)* pszNewPath);
    HRESULT CacheIsFull();
    HRESULT CacheIsCorrupted();
    HRESULT Enabled(BOOL bEnabled);
    HRESULT EncryptionChanged(BOOL bWasEncrypted, BOOL bWasPartial, BOOL bIsEncrypted, BOOL bIsPartial);
    HRESULT SyncBegin(const(GUID)* rSyncId);
    HRESULT SyncFileResult(const(GUID)* rSyncId, const(wchar)* pszFile, HRESULT hrResult);
    HRESULT SyncConflictRecAdded(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                 OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncConflictRecUpdated(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncConflictRecRemoved(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    HRESULT SyncEnd(const(GUID)* rSyncId, HRESULT hrResult);
    HRESULT NetTransportArrived();
    HRESULT NoNetTransports();
    HRESULT ItemDisconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemReconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemNotAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemNotPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemModified(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, 
                         BOOL bModifiedAttributes);
    HRESULT ItemAddedToCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemDeletedFromCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT ItemRenamed(const(wchar)* pszOldPath, const(wchar)* pszNewPath, OFFLINEFILES_ITEM_TYPE ItemType);
    HRESULT DataLost();
    HRESULT Ping();
}

@GUID("1EAD8F56-FF76-4FAA-A795-6F6EF792498B")
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

@GUID("9BA04A45-EE69-42F0-9AB1-7DB5C8805808")
interface IOfflineFilesEvents3 : IOfflineFilesEvents2
{
    HRESULT TransparentCacheItemNotify(const(wchar)* pszPath, OFFLINEFILES_EVENTS EventType, 
                                       OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, BOOL bModifiedAttributes, 
                                       const(wchar)* pzsOldPath);
    HRESULT PrefetchFileBegin(const(wchar)* pszPath);
    HRESULT PrefetchFileEnd(const(wchar)* pszPath, HRESULT hrResult);
}

@GUID("DBD69B1E-C7D2-473E-B35F-9D8C24C0C484")
interface IOfflineFilesEvents4 : IOfflineFilesEvents3
{
    HRESULT PrefetchCloseHandleBegin();
    HRESULT PrefetchCloseHandleEnd(uint dwClosedHandleCount, uint dwOpenHandleCount, HRESULT hrResult);
}

@GUID("33FC4E1B-0716-40FA-BA65-6E62A84A846F")
interface IOfflineFilesEventsFilter : IUnknown
{
    HRESULT GetPathFilter(ushort** ppszFilter, OFFLINEFILES_PATHFILTER_MATCH* pMatch);
    HRESULT GetIncludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
    HRESULT GetExcludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
}

@GUID("7112FA5F-7571-435A-8EB7-195C7C1429BC")
interface IOfflineFilesErrorInfo : IUnknown
{
    HRESULT GetRawData(BYTE_BLOB** ppBlob);
    HRESULT GetDescription(ushort** ppszDescription);
}

@GUID("ECDBAF0D-6A18-4D55-8017-108F7660BA44")
interface IOfflineFilesSyncErrorItemInfo : IUnknown
{
    HRESULT GetFileAttributesA(uint* pdwAttributes);
    HRESULT GetFileTimes(FILETIME* pftLastWrite, FILETIME* pftChange);
    HRESULT GetFileSize(LARGE_INTEGER* pSize);
}

@GUID("59F95E46-EB54-49D1-BE76-DE95458D01B0")
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

@GUID("FAD63237-C55B-4911-9850-BCF96D4C979E")
interface IOfflineFilesProgress : IUnknown
{
    HRESULT Begin(int* pbAbort);
    HRESULT QueryAbort(int* pbAbort);
    HRESULT End(HRESULT hrResult);
}

@GUID("C34F7F9B-C43D-4F9D-A776-C0EB6DE5D401")
interface IOfflineFilesSimpleProgress : IOfflineFilesProgress
{
    HRESULT ItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    HRESULT ItemResult(const(wchar)* pszFile, HRESULT hrResult, OFFLINEFILES_OP_RESPONSE* pResponse);
}

@GUID("6931F49A-6FC7-4C1B-B265-56793FC451B7")
interface IOfflineFilesSyncProgress : IOfflineFilesProgress
{
    HRESULT SyncItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    HRESULT SyncItemResult(const(wchar)* pszFile, HRESULT hrResult, IOfflineFilesSyncErrorInfo pErrorInfo, 
                           OFFLINEFILES_OP_RESPONSE* pResponse);
}

@GUID("B6DD5092-C65C-46B6-97B8-FADD08E7E1BE")
interface IOfflineFilesSyncConflictHandler : IUnknown
{
    HRESULT ResolveConflict(const(wchar)* pszPath, uint fStateKnown, OFFLINEFILES_SYNC_STATE state, 
                            uint fChangeDetails, OFFLINEFILES_SYNC_CONFLICT_RESOLVE* pConflictResolution, 
                            ushort** ppszNewName);
}

@GUID("F4B5A26C-DC05-4F20-ADA4-551F1077BE5C")
interface IOfflineFilesItemFilter : IUnknown
{
    HRESULT GetFilterFlags(ulong* pullFlags, ulong* pullMask);
    HRESULT GetTimeFilter(FILETIME* pftTime, int* pbEvalTimeOfDay, OFFLINEFILES_ITEM_TIME* pTimeType, 
                          OFFLINEFILES_COMPARE* pCompare);
    HRESULT GetPatternFilter(const(wchar)* pszPattern, uint cchPattern);
}

@GUID("4A753DA6-E044-4F12-A718-5D14D079A906")
interface IOfflineFilesItem : IUnknown
{
    HRESULT GetItemType(OFFLINEFILES_ITEM_TYPE* pItemType);
    HRESULT GetPath(ushort** ppszPath);
    HRESULT GetParentItem(IOfflineFilesItem* ppItem);
    HRESULT Refresh(uint dwQueryFlags);
    HRESULT IsMarkedForDeletion(int* pbMarkedForDeletion);
}

@GUID("9B1C9576-A92B-4151-8E9E-7C7B3EC2E016")
interface IOfflineFilesServerItem : IOfflineFilesItem
{
}

@GUID("BAB7E48D-4804-41B5-A44D-0F199B06B145")
interface IOfflineFilesShareItem : IOfflineFilesItem
{
}

@GUID("2273597A-A08C-4A00-A37A-C1AE4E9A1CFD")
interface IOfflineFilesDirectoryItem : IOfflineFilesItem
{
}

@GUID("8DFADEAD-26C2-4EFF-8A72-6B50723D9A00")
interface IOfflineFilesFileItem : IOfflineFilesItem
{
    HRESULT IsSparse(int* pbIsSparse);
    HRESULT IsEncrypted(int* pbIsEncrypted);
}

@GUID("DA70E815-C361-4407-BC0B-0D7046E5F2CD")
interface IEnumOfflineFilesItems : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOfflineFilesItems* ppenum);
}

@GUID("3836F049-9413-45DD-BF46-B5AAA82DC310")
interface IOfflineFilesItemContainer : IUnknown
{
    HRESULT EnumItems(uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
    HRESULT EnumItemsEx(IOfflineFilesItemFilter pIncludeFileFilter, IOfflineFilesItemFilter pIncludeDirFilter, 
                        IOfflineFilesItemFilter pExcludeFileFilter, IOfflineFilesItemFilter pExcludeDirFilter, 
                        uint dwEnumFlags, uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
}

@GUID("A96E6FA4-E0D1-4C29-960B-EE508FE68C72")
interface IOfflineFilesChangeInfo : IUnknown
{
    HRESULT IsDirty(int* pbDirty);
    HRESULT IsDeletedOffline(int* pbDeletedOffline);
    HRESULT IsCreatedOffline(int* pbCreatedOffline);
    HRESULT IsLocallyModifiedData(int* pbLocallyModifiedData);
    HRESULT IsLocallyModifiedAttributes(int* pbLocallyModifiedAttributes);
    HRESULT IsLocallyModifiedTime(int* pbLocallyModifiedTime);
}

@GUID("0F50CE33-BAC9-4EAA-A11D-DA0E527D047D")
interface IOfflineFilesDirtyInfo : IUnknown
{
    HRESULT LocalDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
    HRESULT RemoteDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
}

@GUID("BC1A163F-7BFD-4D88-9C66-96EA9A6A3D6B")
interface IOfflineFilesFileSysInfo : IUnknown
{
    HRESULT GetAttributes(OFFLINEFILES_ITEM_COPY copy, uint* pdwAttributes);
    HRESULT GetTimes(OFFLINEFILES_ITEM_COPY copy, FILETIME* pftCreationTime, FILETIME* pftLastWriteTime, 
                     FILETIME* pftChangeTime, FILETIME* pftLastAccessTime);
    HRESULT GetFileSize(OFFLINEFILES_ITEM_COPY copy, LARGE_INTEGER* pSize);
}

@GUID("5B2B0655-B3FD-497D-ADEB-BD156BC8355B")
interface IOfflineFilesPinInfo : IUnknown
{
    HRESULT IsPinned(int* pbPinned);
    HRESULT IsPinnedForUser(int* pbPinnedForUser, int* pbInherit);
    HRESULT IsPinnedForUserByPolicy(int* pbPinnedForUser, int* pbInherit);
    HRESULT IsPinnedForComputer(int* pbPinnedForComputer, int* pbInherit);
    HRESULT IsPinnedForFolderRedirection(int* pbPinnedForFolderRedirection, int* pbInherit);
}

@GUID("623C58A2-42ED-4AD7-B69A-0F1B30A72D0D")
interface IOfflineFilesPinInfo2 : IOfflineFilesPinInfo
{
    HRESULT IsPartlyPinned(int* pbPartlyPinned);
}

@GUID("BCAF4A01-5B68-4B56-A6A1-8D2786EDE8E3")
interface IOfflineFilesTransparentCacheInfo : IUnknown
{
    HRESULT IsTransparentlyCached(int* pbTransparentlyCached);
}

@GUID("2B09D48C-8AB5-464F-A755-A59D92F99429")
interface IOfflineFilesGhostInfo : IUnknown
{
    HRESULT IsGhosted(int* pbGhosted);
}

@GUID("EFB23A09-A867-4BE8-83A6-86969A7D0856")
interface IOfflineFilesConnectionInfo : IUnknown
{
    HRESULT GetConnectState(OFFLINEFILES_CONNECT_STATE* pConnectState, OFFLINEFILES_OFFLINE_REASON* pOfflineReason);
    HRESULT SetConnectState(HWND hwndParent, uint dwFlags, OFFLINEFILES_CONNECT_STATE ConnectState);
    HRESULT TransitionOnline(HWND hwndParent, uint dwFlags);
    HRESULT TransitionOffline(HWND hwndParent, uint dwFlags, BOOL bForceOpenFilesClosed, 
                              int* pbOpenFilesPreventedTransition);
}

@GUID("7BCC43E7-31CE-4CA4-8CCD-1CFF2DC494DA")
interface IOfflineFilesShareInfo : IUnknown
{
    HRESULT GetShareItem(IOfflineFilesShareItem* ppShareItem);
    HRESULT GetShareCachingMode(OFFLINEFILES_CACHING_MODE* pCachingMode);
    HRESULT IsShareDfsJunction(int* pbIsDfsJunction);
}

@GUID("62C4560F-BC0B-48CA-AD9D-34CB528D99A9")
interface IOfflineFilesSuspend : IUnknown
{
    HRESULT SuspendRoot(BOOL bSuspend);
}

@GUID("A457C25B-4E9C-4B04-85AF-8932CCD97889")
interface IOfflineFilesSuspendInfo : IUnknown
{
    HRESULT IsSuspended(int* pbSuspended, int* pbSuspendedRoot);
}

@GUID("D871D3F7-F613-48A1-827E-7A34E560FFF6")
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

@GUID("729680C4-1A38-47BC-9E5C-02C51562AC30")
interface IEnumOfflineFilesSettings : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumOfflineFilesSettings* ppenum);
}

@GUID("855D6203-7914-48B9-8D40-4C56F5ACFFC5")
interface IOfflineFilesCache : IUnknown
{
    HRESULT Synchronize(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bAsync, uint dwSyncControl, 
                        IOfflineFilesSyncConflictHandler pISyncConflictHandler, IOfflineFilesSyncProgress pIProgress, 
                        GUID* pSyncId);
    HRESULT DeleteItems(char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, 
                        IOfflineFilesSimpleProgress pIProgress);
    HRESULT DeleteItemsForUser(const(wchar)* pszUser, char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, 
                               IOfflineFilesSimpleProgress pIProgress);
    HRESULT Pin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, 
                IOfflineFilesSyncProgress pIProgress);
    HRESULT Unpin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, 
                  IOfflineFilesSyncProgress pIProgress);
    HRESULT GetEncryptionStatus(int* pbEncrypted, int* pbPartial);
    HRESULT Encrypt(HWND hwndParent, BOOL bEncrypt, uint dwEncryptionControlFlags, BOOL bAsync, 
                    IOfflineFilesSyncProgress pIProgress);
    HRESULT FindItem(const(wchar)* pszPath, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    HRESULT FindItemEx(const(wchar)* pszPath, IOfflineFilesItemFilter pIncludeFileFilter, 
                       IOfflineFilesItemFilter pIncludeDirFilter, IOfflineFilesItemFilter pExcludeFileFilter, 
                       IOfflineFilesItemFilter pExcludeDirFilter, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    HRESULT RenameItem(const(wchar)* pszPathOriginal, const(wchar)* pszPathNew, BOOL bReplaceIfExists);
    HRESULT GetLocation(ushort** ppszPath);
    HRESULT GetDiskSpaceInformationA(ulong* pcbVolumeTotal, ulong* pcbLimit, ulong* pcbUsed, 
                                     ulong* pcbUnpinnedLimit, ulong* pcbUnpinnedUsed);
    HRESULT SetDiskSpaceLimits(ulong cbLimit, ulong cbUnpinnedLimit);
    HRESULT ProcessAdminPinPolicy(IOfflineFilesSyncProgress pPinProgress, IOfflineFilesSyncProgress pUnpinProgress);
    HRESULT GetSettingObject(const(wchar)* pszSettingName, IOfflineFilesSetting* ppSetting);
    HRESULT EnumSettingObjects(IEnumOfflineFilesSettings* ppEnum);
    HRESULT IsPathCacheable(const(wchar)* pszPath, int* pbCacheable, OFFLINEFILES_CACHING_MODE* pShareCachingMode);
}

@GUID("8C075039-1551-4ED9-8781-56705C04D3C0")
interface IOfflineFilesCache2 : IOfflineFilesCache
{
    HRESULT RenameItemEx(const(wchar)* pszPathOriginal, const(wchar)* pszPathNew, BOOL bReplaceIfExists);
}


// GUIDs

const GUID CLSID_OfflineFilesCache   = GUIDOF!OfflineFilesCache;
const GUID CLSID_OfflineFilesSetting = GUIDOF!OfflineFilesSetting;

const GUID IID_IEnumOfflineFilesItems            = GUIDOF!IEnumOfflineFilesItems;
const GUID IID_IEnumOfflineFilesSettings         = GUIDOF!IEnumOfflineFilesSettings;
const GUID IID_IOfflineFilesCache                = GUIDOF!IOfflineFilesCache;
const GUID IID_IOfflineFilesCache2               = GUIDOF!IOfflineFilesCache2;
const GUID IID_IOfflineFilesChangeInfo           = GUIDOF!IOfflineFilesChangeInfo;
const GUID IID_IOfflineFilesConnectionInfo       = GUIDOF!IOfflineFilesConnectionInfo;
const GUID IID_IOfflineFilesDirectoryItem        = GUIDOF!IOfflineFilesDirectoryItem;
const GUID IID_IOfflineFilesDirtyInfo            = GUIDOF!IOfflineFilesDirtyInfo;
const GUID IID_IOfflineFilesErrorInfo            = GUIDOF!IOfflineFilesErrorInfo;
const GUID IID_IOfflineFilesEvents               = GUIDOF!IOfflineFilesEvents;
const GUID IID_IOfflineFilesEvents2              = GUIDOF!IOfflineFilesEvents2;
const GUID IID_IOfflineFilesEvents3              = GUIDOF!IOfflineFilesEvents3;
const GUID IID_IOfflineFilesEvents4              = GUIDOF!IOfflineFilesEvents4;
const GUID IID_IOfflineFilesEventsFilter         = GUIDOF!IOfflineFilesEventsFilter;
const GUID IID_IOfflineFilesFileItem             = GUIDOF!IOfflineFilesFileItem;
const GUID IID_IOfflineFilesFileSysInfo          = GUIDOF!IOfflineFilesFileSysInfo;
const GUID IID_IOfflineFilesGhostInfo            = GUIDOF!IOfflineFilesGhostInfo;
const GUID IID_IOfflineFilesItem                 = GUIDOF!IOfflineFilesItem;
const GUID IID_IOfflineFilesItemContainer        = GUIDOF!IOfflineFilesItemContainer;
const GUID IID_IOfflineFilesItemFilter           = GUIDOF!IOfflineFilesItemFilter;
const GUID IID_IOfflineFilesPinInfo              = GUIDOF!IOfflineFilesPinInfo;
const GUID IID_IOfflineFilesPinInfo2             = GUIDOF!IOfflineFilesPinInfo2;
const GUID IID_IOfflineFilesProgress             = GUIDOF!IOfflineFilesProgress;
const GUID IID_IOfflineFilesServerItem           = GUIDOF!IOfflineFilesServerItem;
const GUID IID_IOfflineFilesSetting              = GUIDOF!IOfflineFilesSetting;
const GUID IID_IOfflineFilesShareInfo            = GUIDOF!IOfflineFilesShareInfo;
const GUID IID_IOfflineFilesShareItem            = GUIDOF!IOfflineFilesShareItem;
const GUID IID_IOfflineFilesSimpleProgress       = GUIDOF!IOfflineFilesSimpleProgress;
const GUID IID_IOfflineFilesSuspend              = GUIDOF!IOfflineFilesSuspend;
const GUID IID_IOfflineFilesSuspendInfo          = GUIDOF!IOfflineFilesSuspendInfo;
const GUID IID_IOfflineFilesSyncConflictHandler  = GUIDOF!IOfflineFilesSyncConflictHandler;
const GUID IID_IOfflineFilesSyncErrorInfo        = GUIDOF!IOfflineFilesSyncErrorInfo;
const GUID IID_IOfflineFilesSyncErrorItemInfo    = GUIDOF!IOfflineFilesSyncErrorItemInfo;
const GUID IID_IOfflineFilesSyncProgress         = GUIDOF!IOfflineFilesSyncProgress;
const GUID IID_IOfflineFilesTransparentCacheInfo = GUIDOF!IOfflineFilesTransparentCacheInfo;
