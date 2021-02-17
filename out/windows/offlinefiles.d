// Written in the D programming language.

module windows.offlinefiles;

public import windows.core;
public import windows.automation : VARIANT;
public import windows.com : BYTE_BLOB, HRESULT, IUnknown;
public import windows.systemservices : BOOL, LARGE_INTEGER;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME;

extern(Windows):


// Enums


///Identifies the type of an item in the Offline Files cache.
alias OFFLINEFILES_ITEM_TYPE = int;
enum : int
{
    ///The item is a file.
    OFFLINEFILES_ITEM_TYPE_FILE      = 0x00000000,
    ///The item is a directory.
    OFFLINEFILES_ITEM_TYPE_DIRECTORY = 0x00000001,
    ///The item is a share.
    OFFLINEFILES_ITEM_TYPE_SHARE     = 0x00000002,
    ///The item is a server.
    OFFLINEFILES_ITEM_TYPE_SERVER    = 0x00000003,
}

///Specifies whether the local, remote, or original copy of an item is being queried.
alias OFFLINEFILES_ITEM_COPY = int;
enum : int
{
    ///Retrieve the attributes, time values, or size of the local copy of the item. If the item is currently offline,
    ///this may be different than the attributes associated with the original copy.
    OFFLINEFILES_ITEM_COPY_LOCAL    = 0x00000000,
    ///This enumeration value is reserved for future use.
    OFFLINEFILES_ITEM_COPY_REMOTE   = 0x00000001,
    ///Retrieve the attributes, time values, or size of the original copy of the item. The original copy represents the
    ///state of the item following the last successful sync of that item, which is the most recent time when the server
    ///copy and local copy were identical.
    OFFLINEFILES_ITEM_COPY_ORIGINAL = 0x00000002,
}

///Describes the connection state of an item in the Offline Files cache.
alias OFFLINEFILES_CONNECT_STATE = int;
enum : int
{
    ///Returned by IOfflineFilesConnectionInfo::GetConnectState if the method fails.
    OFFLINEFILES_CONNECT_STATE_UNKNOWN                     = 0x00000000,
    ///Returned by IOfflineFilesConnectionInfo::GetConnectState if the item is offline. Pass this value to
    ///IOfflineFilesConnectionInfo::SetConnectState to transition the item to offline.
    OFFLINEFILES_CONNECT_STATE_OFFLINE                     = 0x00000001,
    ///Returned by IOfflineFilesConnectionInfo::GetConnectState if the item is online. Pass this value to
    ///IOfflineFilesConnectionInfo::SetConnectState to transition the item to online.
    OFFLINEFILES_CONNECT_STATE_ONLINE                      = 0x00000002,
    ///Returned by IOfflineFilesConnectionInfo::GetConnectState if the item is transparently cached. <b>Windows Server
    ///2008 and Windows Vista: </b>This value is not supported before Windows Server 2008 R2 and Windows 7.
    OFFLINEFILES_CONNECT_STATE_TRANSPARENTLY_CACHED        = 0x00000003,
    ///Returned by IOfflineFilesConnectionInfo::GetConnectState if the item contains both transparently cached data and
    ///data that can be made available offline. <b>Windows Server 2008 and Windows Vista: </b>This value is not
    ///supported before Windows Server 2008 R2 and Windows 7.
    OFFLINEFILES_CONNECT_STATE_PARTLY_TRANSPARENTLY_CACHED = 0x00000004,
}

///Indicates the reason why an item is offline.
alias OFFLINEFILES_OFFLINE_REASON = int;
enum : int
{
    ///The reason is unknown because the method failed.
    OFFLINEFILES_OFFLINE_REASON_UNKNOWN               = 0x00000000,
    ///The item is online.
    OFFLINEFILES_OFFLINE_REASON_NOT_APPLICABLE        = 0x00000001,
    ///IOfflineFilesConnectionInfo::GetConnectState returns this value if the item is offline because the item's scope
    ///was forced offline using the IOfflineFilesConnectionInfo::TransitionOffline method. When an item has been
    ///transitioned offline by the Work Offline button in Windows Explorer, the offline reason is forced. When an item
    ///is forced offline, its entire scope is also forced offline. Assuming the remote share is reachable, a scope that
    ///is forced offline may be transitioned online using the IOfflineFilesConnectionInfo::TransitionOnline method.
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_FORCED     = 0x00000002,
    ///IOfflineFilesConnectionInfo::GetConnectState returns this value if the item is offline because the item's
    ///connection is considered slow. The parameters that define a slow connection are defined by Group Policy. When an
    ///item is offline because of a slow connection, its entire scope is also offline for the same reason. Assuming the
    ///remote share is reachable, a scope that is offline because of a slow connection may be transitioned online using
    ///the IOfflineFilesConnectionInfo::TransitionOnline method.
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_SLOW       = 0x00000003,
    ///IOfflineFilesConnectionInfo::GetConnectState returns this value if the item is offline because of an error in
    ///network communications. This normally means that the client computer is disconnected from the network, the server
    ///computer is unavailable, or the network shared folder is no longer available. After the source of the error is
    ///corrected and the remote share is again reachable, the scope is automatically transitioned online by Offline
    ///Files.
    OFFLINEFILES_OFFLINE_REASON_CONNECTION_ERROR      = 0x00000004,
    ///IOfflineFilesConnectionInfo::GetConnectState returns this value if the item is offline because of an unresolved
    ///sync conflict. While working offline, an item was changed both on the client and the server. A subsequent sync
    ///operation detected the sync conflict and placed a record of that conflict in the sync conflict store. Sync
    ///conflicts may be reviewed in Sync Center's Sync Conflicts folder. To resolve a conflict programmatically, call
    ///IOfflineFilesCache::Synchronize with the appropriate conflict resolution mechanism. For more information, see
    ///<b>IOfflineFilesCache::Synchronize</b>.
    OFFLINEFILES_OFFLINE_REASON_ITEM_VERSION_CONFLICT = 0x00000005,
    ///IOfflineFilesConnectionInfo::GetConnectState returns this value if the item is offline because it was suspended.
    ///Suspending an item is a way to force it to be always available offline. It is primarily used by Windows features
    ///that want to use the offline availability and synchronization capabilities of Offline Files but that also want to
    ///control the synchronization. Suspended items are never synchronized automatically by Offline Files.
    OFFLINEFILES_OFFLINE_REASON_ITEM_SUSPENDED        = 0x00000006,
}

///Describes the caching mode used in methods such as IOfflineFilesCache::IsPathCacheable and
///IOfflineFilesShareInfo::GetShareCachingMode.
alias OFFLINEFILES_CACHING_MODE = int;
enum : int
{
    ///No caching mode value was found.
    OFFLINEFILES_CACHING_MODE_NONE            = 0x00000000,
    ///The share or shared folder is configured to disallow caching.
    OFFLINEFILES_CACHING_MODE_NOCACHING       = 0x00000001,
    ///The share or shared folder is configured to allow manual caching.
    OFFLINEFILES_CACHING_MODE_MANUAL          = 0x00000002,
    ///The share or shared folder is configured to allow automatic caching of documents.
    OFFLINEFILES_CACHING_MODE_AUTO_DOC        = 0x00000003,
    ///The share or shared folder is configured to allow automatic caching of programs and documents.
    OFFLINEFILES_CACHING_MODE_AUTO_PROGANDDOC = 0x00000004,
}

///Specifies whether to continue, retry, or stop processing items.
alias OFFLINEFILES_OP_RESPONSE = int;
enum : int
{
    ///Continue processing items.
    OFFLINEFILES_OP_CONTINUE = 0x00000000,
    ///Repeat processing of this item.
    OFFLINEFILES_OP_RETRY    = 0x00000001,
    ///Stop processing now.
    OFFLINEFILES_OP_ABORT    = 0x00000002,
}

///Event identifier codes describing events to be received or excluded by an event sink. Used with the
///IOfflineFilesEventsFilter::GetIncludedEvents and IOfflineFilesEventsFilter::GetExcludedEvents methods.
alias OFFLINEFILES_EVENTS = int;
enum : int
{
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_CACHEMOVED                 = 0x00000000,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_CACHEISFULL                = 0x00000001,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_CACHEISCORRUPTED           = 0x00000002,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_ENABLED                    = 0x00000003,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_ENCRYPTIONCHANGED          = 0x00000004,
    ///Represents the IOfflineFilesEvents::SyncBegin event method.
    OFFLINEFILES_EVENT_SYNCBEGIN                  = 0x00000005,
    ///Represents the IOfflineFilesEvents::SyncFileResult event method.
    OFFLINEFILES_EVENT_SYNCFILERESULT             = 0x00000006,
    ///Represents the IOfflineFilesEvents::SyncConflictRecAdded event method.
    OFFLINEFILES_EVENT_SYNCCONFLICTRECADDED       = 0x00000007,
    ///Represents the IOfflineFilesEvents::SyncConflictRecUpdated event method.
    OFFLINEFILES_EVENT_SYNCCONFLICTRECUPDATED     = 0x00000008,
    ///Represents the IOfflineFilesEvents::SyncConflictRecRemoved event method.
    OFFLINEFILES_EVENT_SYNCCONFLICTRECREMOVED     = 0x00000009,
    ///Represents the IOfflineFilesEvents::SyncEnd event method.
    OFFLINEFILES_EVENT_SYNCEND                    = 0x0000000a,
    ///Represents the IOfflineFilesEvents2::BackgroundSyncBegin event method.
    OFFLINEFILES_EVENT_BACKGROUNDSYNCBEGIN        = 0x0000000b,
    ///Represents the IOfflineFilesEvents2::BackgroundSyncEnd event method.
    OFFLINEFILES_EVENT_BACKGROUNDSYNCEND          = 0x0000000c,
    ///Represents the IOfflineFilesEvents::NetTransportArrived event method.
    OFFLINEFILES_EVENT_NETTRANSPORTARRIVED        = 0x0000000d,
    ///Represents the IOfflineFilesEvents::NoNetTransports event method.
    OFFLINEFILES_EVENT_NONETTRANSPORTS            = 0x0000000e,
    ///Represents the IOfflineFilesEvents::ItemDisconnected event method.
    OFFLINEFILES_EVENT_ITEMDISCONNECTED           = 0x0000000f,
    ///Represents the IOfflineFilesEvents::ItemReconnected event method.
    OFFLINEFILES_EVENT_ITEMRECONNECTED            = 0x00000010,
    ///Represents the IOfflineFilesEvents::ItemAvailableOffline event method.
    OFFLINEFILES_EVENT_ITEMAVAILABLEOFFLINE       = 0x00000011,
    ///Represents the IOfflineFilesEvents::ItemNotAvailableOffline event method.
    OFFLINEFILES_EVENT_ITEMNOTAVAILABLEOFFLINE    = 0x00000012,
    ///Represents the IOfflineFilesEvents::ItemPinned event method.
    OFFLINEFILES_EVENT_ITEMPINNED                 = 0x00000013,
    ///Represents the IOfflineFilesEvents::ItemNotPinned event method.
    OFFLINEFILES_EVENT_ITEMNOTPINNED              = 0x00000014,
    ///Represents the IOfflineFilesEvents::ItemModified event method.
    OFFLINEFILES_EVENT_ITEMMODIFIED               = 0x00000015,
    ///Represents the IOfflineFilesEvents::ItemAddedToCache event method.
    OFFLINEFILES_EVENT_ITEMADDEDTOCACHE           = 0x00000016,
    ///Represents the IOfflineFilesEvents::ItemDeletedFromCache event method.
    OFFLINEFILES_EVENT_ITEMDELETEDFROMCACHE       = 0x00000017,
    ///Represents the IOfflineFilesEvents::ItemRenamed event method.
    OFFLINEFILES_EVENT_ITEMRENAMED                = 0x00000018,
    ///Represents the IOfflineFilesEvents::DataLost event method.
    OFFLINEFILES_EVENT_DATALOST                   = 0x00000019,
    ///Represents the IOfflineFilesEvents::Ping event method.
    OFFLINEFILES_EVENT_PING                       = 0x0000001a,
    ///Represents the IOfflineFilesEvents2::ItemReconnectBegin event method.
    OFFLINEFILES_EVENT_ITEMRECONNECTBEGIN         = 0x0000001b,
    ///Represents the IOfflineFilesEvents2::ItemReconnectEnd event method.
    OFFLINEFILES_EVENT_ITEMRECONNECTEND           = 0x0000001c,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_CACHEEVICTBEGIN            = 0x0000001d,
    ///This value is reserved for future use.
    OFFLINEFILES_EVENT_CACHEEVICTEND              = 0x0000001e,
    ///Represents the IOfflineFilesEvents2::PolicyChangeDetected event method.
    OFFLINEFILES_EVENT_POLICYCHANGEDETECTED       = 0x0000001f,
    ///Represents the IOfflineFilesEvents2::PreferenceChangeDetected event method.
    OFFLINEFILES_EVENT_PREFERENCECHANGEDETECTED   = 0x00000020,
    ///Represents the IOfflineFilesEvents2::SettingsChangesApplied event method.
    OFFLINEFILES_EVENT_SETTINGSCHANGESAPPLIED     = 0x00000021,
    ///Represents the IOfflineFilesEvents3::TransparentCacheItemNotify event method. <b>Windows Server 2008 and Windows
    ///Vista: </b>This value is not supported before Windows Server 2008 R2 and Windows 7.
    OFFLINEFILES_EVENT_TRANSPARENTCACHEITEMNOTIFY = 0x00000022,
    ///Represents the IOfflineFilesEvents3::PrefetchFileBegin event method. <b>Windows Server 2008 and Windows Vista:
    ///</b>This value is not supported before Windows Server 2008 R2 and Windows 7.
    OFFLINEFILES_EVENT_PREFETCHFILEBEGIN          = 0x00000023,
    ///Represents the IOfflineFilesEvents3::PrefetchFileEnd event method. <b>Windows Server 2008 and Windows Vista:
    ///</b>This value is not supported before Windows Server 2008 R2 and Windows 7.
    OFFLINEFILES_EVENT_PREFETCHFILEEND            = 0x00000024,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEBEGIN   = 0x00000025,
    OFFLINEFILES_EVENT_PREFETCHCLOSEHANDLEEND     = 0x00000026,
    OFFLINEFILES_NUM_EVENTS                       = 0x00000027,
}

///Specifies how closely an event must match a filter.
alias OFFLINEFILES_PATHFILTER_MATCH = int;
enum : int
{
    ///Event must be an exact match for the fully qualified UNC path associated with the filter.
    OFFLINEFILES_PATHFILTER_SELF             = 0x00000000,
    ///Event must be for an immediate child of the fully qualified UNC path associated with the filter.
    OFFLINEFILES_PATHFILTER_CHILD            = 0x00000001,
    ///Event can be any descendant of the fully qualified UNC path associated with the filter.
    OFFLINEFILES_PATHFILTER_DESCENDENT       = 0x00000002,
    ///Event must be an exact match or an immediate child of the fully qualified UNC path associated with the filter.
    OFFLINEFILES_PATHFILTER_SELFORCHILD      = 0x00000003,
    ///Event must be an exact match or any descendant of the fully qualified UNC path associated with the filter.
    OFFLINEFILES_PATHFILTER_SELFORDESCENDENT = 0x00000004,
}

///Identifies the conflict resolution code returned by the IOfflineFilesSyncConflictHandler::ResolveConflict method.
alias OFFLINEFILES_SYNC_CONFLICT_RESOLVE = int;
enum : int
{
    ///No resolution. The conflict is unresolved. This allows the conflict to be processed by other handlers in the
    ///system.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NONE           = 0x00000000,
    ///Keep the local state. This overwrites the remote copy with the local copy's contents. If the local copy was
    ///deleted, this deletes the remote copy on the server.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLOCAL      = 0x00000001,
    ///Keep the remote state. This overwrites the local copy with the remote copy's contents. If the remote copy was
    ///deleted, this deletes the local copy in the Offline Files cache.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPREMOTE     = 0x00000002,
    ///Keeps both copies. Note that this resolution is valid only for sync conflict states where both the server and
    ///client copies exist and where at least one of the items is a file. The
    ///<b>OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES</b> resolution is not available when one of the items has
    ///been deleted or both items are directories. The list of applicable OFFLINEFILES_SYNC_STATE values is as follows:
    ///<b>OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer</b>
    ///<b>OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer</b>
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES = 0x00000003,
    ///Retains the state of the latest operation as determined by last-change times of the items in conflict. If the
    ///local item was deleted, the time of deletion is used for comparison. The case where the remote copy was deleted
    ///after the client copy was changed is a special case that produces an unexpected result. The logical expectation
    ///is that the later operation (the remote deletion) propagates to the client and deletes the client copy from the
    ///cache. However, the result is that the client copy is restored to the server, reversing the deletion. This is
    ///because Offline Files is a client feature and therefore is unable to know when a remote copy of a cached item was
    ///deleted. If the local copy is modified offline, the last-change time of that local copy will be later than the
    ///last-change time for the remote copy recorded when the item was last in sync. Therefore, an
    ///<b>OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST</b> resolution finds the last-change time on the client copy to
    ///be later than the last-change time last known for the server copy. This causes the local copy to be restored to
    ///the server.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPLATEST     = 0x00000004,
    ///Write an entry to the sync conflict log and perform no further attempts at resolving the conflict. The
    ///interactive user will resolve the conflict through Sync Center at a later time.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_LOG            = 0x00000005,
    ///Do not resolve the conflict. Do not record an entry in the sync conflict log.
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_SKIP           = 0x00000006,
    ///Cancel the synchronization operation.
    OFFLINEFILES_SYNC_CONFLICT_ABORT                  = 0x00000007,
    OFFLINEFILES_SYNC_CONFLICT_RESOLVE_NUMCODES       = 0x00000008,
}

///Specifies which time value associated with the cache item is to be used.
alias OFFLINEFILES_ITEM_TIME = int;
enum : int
{
    ///Use the item's creation time.
    OFFLINEFILES_ITEM_TIME_CREATION   = 0x00000000,
    ///Use the item's last-access time.
    OFFLINEFILES_ITEM_TIME_LASTACCESS = 0x00000001,
    ///Use the item's last-write time.
    OFFLINEFILES_ITEM_TIME_LASTWRITE  = 0x00000002,
}

///Specifies the type of comparison to perform in the IOfflineFilesItemFilter::GetTimeFilter method.
alias OFFLINEFILES_COMPARE = int;
enum : int
{
    ///Check whether the item value is equal to the filter value.
    OFFLINEFILES_COMPARE_EQ  = 0x00000000,
    ///Check whether the item value is not equal to the filter value.
    OFFLINEFILES_COMPARE_NEQ = 0x00000001,
    ///Check whether the item value is less than the filter value.
    OFFLINEFILES_COMPARE_LT  = 0x00000002,
    ///Check whether the item value is greater than the filter value.
    OFFLINEFILES_COMPARE_GT  = 0x00000003,
    ///Check whether the item value is less than or equal to the filter value.
    OFFLINEFILES_COMPARE_LTE = 0x00000004,
    ///Check whether the item value is greater than or equal to the filter value.
    OFFLINEFILES_COMPARE_GTE = 0x00000005,
}

///Identifies the data type returned by the IOfflineFilesSetting::GetValueType method.
alias OFFLINEFILES_SETTING_VALUE_TYPE = int;
enum : int
{
    ///A single VT_UI4 value. Used to represent single REG_DWORD values. REG_DWORD is by far the most common type of
    ///setting value.
    OFFLINEFILES_SETTING_VALUE_UI4                  = 0x00000000,
    ///A single VT_BSTR value. Used to represent single REG_SZ and REG_EXPAND_SZ values.
    OFFLINEFILES_SETTING_VALUE_BSTR                 = 0x00000001,
    ///A single VT_BSTR value. The string is a double-null-terminated string containing multiple null-terminated
    ///substrings. Used to represent single REG_MULTI_SZ values.
    OFFLINEFILES_SETTING_VALUE_BSTR_DBLNULTERM      = 0x00000002,
    ///A 2-dimensional array. Each row is a <i>name,value</i> pair. Used to represent a set of REG_DWORD values under a
    ///registry key of the same name as the setting. Typically, the value names contain UNC paths and the values contain
    ///a parameter associated with each UNC path. Column 0 is the value name expressed as VT_BSTR. Column 1 is the
    ///VT_UI4 value.
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_UI4  = 0x00000003,
    ///A 2-dimensional array. Each row is a <i>name,value</i> pair. Used to represent a set of BSTR values under a
    ///registry key of the same name as the setting. Typically, the value names contain UNC paths and the values contain
    ///a parameter associated with each UNC path. Column 0 is the value name expressed as VT_BSTR. Column 1 is the
    ///VT_BSTR value.
    OFFLINEFILES_SETTING_VALUE_2DIM_ARRAY_BSTR_BSTR = 0x00000004,
}

///Indicates the type of sync operation that was being performed when a sync error was encountered.
alias OFFLINEFILES_SYNC_OPERATION = int;
enum : int
{
    ///Operation was creating a new file or directory copy on the server.
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_SERVER = 0x00000000,
    ///Operation was creating a new file or directory copy on the client.
    OFFLINEFILES_SYNC_OPERATION_CREATE_COPY_ON_CLIENT = 0x00000001,
    ///Operation was synchronizing a file or directory from the client to the server.
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_SERVER        = 0x00000002,
    ///Operation was synchronizing a file or directory from the server to the client.
    OFFLINEFILES_SYNC_OPERATION_SYNC_TO_CLIENT        = 0x00000003,
    ///Operation was deleting a copy from the server.
    OFFLINEFILES_SYNC_OPERATION_DELETE_SERVER_COPY    = 0x00000004,
    ///Operation was deleting a copy from the local cache on the client.
    OFFLINEFILES_SYNC_OPERATION_DELETE_CLIENT_COPY    = 0x00000005,
    ///Operation was pinning a file or directory into the local cache.
    OFFLINEFILES_SYNC_OPERATION_PIN                   = 0x00000006,
    ///Operation was preparing for the synchronization. Preparation involves obtaining directory listings from the
    ///client and server, comparing the two, and building a list of items to be synchronized.
    OFFLINEFILES_SYNC_OPERATION_PREPARE               = 0x00000007,
}

///Describes the sync state of an Offline Files item.
alias OFFLINEFILES_SYNC_STATE = int;
enum : int
{
    ///The client and server copies of the file are in sync.
    OFFLINEFILES_SYNC_STATE_Stable                                             = 0x00000000,
    ///The file exists on the client. The directory exists on the server.
    OFFLINEFILES_SYNC_STATE_FileOnClient_DirOnServer                           = 0x00000001,
    ///The file exists only on the client.
    OFFLINEFILES_SYNC_STATE_FileOnClient_NoServerCopy                          = 0x00000002,
    ///The directory exists on the client. The file exists on the server.
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileOnServer                           = 0x00000003,
    ///The directory exists on the client. The server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_DirOnClient_FileChangedOnServer                    = 0x00000004,
    ///The directory exists only on the client.
    OFFLINEFILES_SYNC_STATE_DirOnClient_NoServerCopy                           = 0x00000005,
    ///The file was created on the client. There is no server copy of the file.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_NoServerCopy                   = 0x00000006,
    ///The file was created on the client. The server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileChangedOnServer            = 0x00000007,
    ///The file was created on the client. The directory on the server has changed.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirChangedOnServer             = 0x00000008,
    ///The file was created on the client. The server has a file with the same name.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_FileOnServer                   = 0x00000009,
    ///The file was created on the client. A directory with the same name exists on the server.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DirOnServer                    = 0x0000000a,
    ///The file was created on the client. The server copy of the file was deleted.
    OFFLINEFILES_SYNC_STATE_FileCreatedOnClient_DeletedOnServer                = 0x0000000b,
    ///The client copy of the file has changed. The server copy of the file has changed. This value represents the
    ///classic change/change sync conflict.
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer                = 0x0000000c,
    ///The client copy of the file has changed. The directory exists on the server.
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirOnServer                    = 0x0000000d,
    ///The client copy of the file has changed. The directory on the server has changed.
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DirChangedOnServer             = 0x0000000e,
    ///The client copy of the file has changed. The server copy of the file has been deleted.
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient_DeletedOnServer                = 0x0000000f,
    ///The file is sparsely cached on the client. The server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_ChangedOnServer                 = 0x00000010,
    ///The file is sparsely cached on the client. The server copy of the file has been deleted.
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DeletedOnServer                 = 0x00000011,
    ///The file is sparsely cached on the client. The directory exists on the server.
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirOnServer                     = 0x00000012,
    ///The file is sparsely cached on the client. The directory on the server has changed.
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient_DirChangedOnServer              = 0x00000013,
    ///The directory has been created on the client. There is no server copy of the directory.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_NoServerCopy                    = 0x00000014,
    ///The directory has been created on the client. A directory with the same name exists on the server.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirOnServer                     = 0x00000015,
    ///The directory has been created on the client. A file with the same name exists on the server.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileOnServer                    = 0x00000016,
    ///The directory has been created on the client. The server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_FileChangedOnServer             = 0x00000017,
    ///The directory has been created on the client. The directory on the server has changed.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DirChangedOnServer              = 0x00000018,
    ///The directory has been created on the client. The directory on the server has been deleted.
    OFFLINEFILES_SYNC_STATE_DirCreatedOnClient_DeletedOnServer                 = 0x00000019,
    ///The client directory has changed. The server has a copy of the file.
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileOnServer                    = 0x0000001a,
    ///The client directory has changed. The server copy of the file has been changed.
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_FileChangedOnServer             = 0x0000001b,
    ///The client directory has changed. The server directory has also changed.
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_ChangedOnServer                 = 0x0000001c,
    ///The client directory has changed. The directory on the server has been deleted.
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient_DeletedOnServer                 = 0x0000001d,
    ///The file exists only on the server.
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileOnServer                          = 0x0000001e,
    ///The directory exists only on the server.
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirOnServer                           = 0x0000001f,
    ///The file exists only on the server, and the server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_NoClientCopy_FileChangedOnServer                   = 0x00000020,
    ///The directory exists only on the server, and the server directory has changed.
    OFFLINEFILES_SYNC_STATE_NoClientCopy_DirChangedOnServer                    = 0x00000021,
    ///The file exists only on the server, because the client copy of the file has been deleted.
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileOnServer                       = 0x00000022,
    ///The directory exists only on the server, because the client directory has been deleted.
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirOnServer                        = 0x00000023,
    ///The client copy of the file has been deleted, and the server copy of the file has changed. This value represents
    ///the classic delete/change conflict.
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_FileChangedOnServer                = 0x00000024,
    ///The client copy of the directory has been deleted, and the server copy of the directory has changed.
    OFFLINEFILES_SYNC_STATE_DeletedOnClient_DirChangedOnServer                 = 0x00000025,
    ///The file is sparsely cached on the client.
    OFFLINEFILES_SYNC_STATE_FileSparseOnClient                                 = 0x00000026,
    ///The file has been changed on the client.
    OFFLINEFILES_SYNC_STATE_FileChangedOnClient                                = 0x00000027,
    ///This value is reserved for future use.
    OFFLINEFILES_SYNC_STATE_FileRenamedOnClient                                = 0x00000028,
    ///The directory is sparsely cached on the client.
    OFFLINEFILES_SYNC_STATE_DirSparseOnClient                                  = 0x00000029,
    ///The directory has been changed on the client.
    OFFLINEFILES_SYNC_STATE_DirChangedOnClient                                 = 0x0000002a,
    ///This value is reserved for future use.
    OFFLINEFILES_SYNC_STATE_DirRenamedOnClient                                 = 0x0000002b,
    ///The server copy of the file has been changed.
    OFFLINEFILES_SYNC_STATE_FileChangedOnServer                                = 0x0000002c,
    ///This value is reserved for future use.
    OFFLINEFILES_SYNC_STATE_FileRenamedOnServer                                = 0x0000002d,
    ///The server copy of the file has been deleted.
    OFFLINEFILES_SYNC_STATE_FileDeletedOnServer                                = 0x0000002e,
    ///The server directory has been changed.
    OFFLINEFILES_SYNC_STATE_DirChangedOnServer                                 = 0x0000002f,
    ///This value is reserved for future use.
    OFFLINEFILES_SYNC_STATE_DirRenamedOnServer                                 = 0x00000030,
    ///The server directory has been deleted.
    OFFLINEFILES_SYNC_STATE_DirDeletedOnServer                                 = 0x00000031,
    ///The file has been replaced and deleted on the client. The server has a copy of the file.
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileOnServer        = 0x00000032,
    ///The file has been replaced and deleted on the client. The server copy of the file has changed.
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_FileChangedOnServer = 0x00000033,
    ///The file has been replaced and deleted on the client. The directory exists on the server.
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirOnServer         = 0x00000034,
    ///The file has been replaced and deleted on the client. The directory has changed on the server.
    OFFLINEFILES_SYNC_STATE_FileReplacedAndDeletedOnClient_DirChangedOnServer  = 0x00000035,
    OFFLINEFILES_SYNC_STATE_NUMSTATES                                          = 0x00000036,
}

// Functions

///Enables or disables the Offline Files feature.
///Params:
///    bEnable = Specify <b>TRUE</b> to enable Offline Files, or <b>FALSE</b> to disable.
///    pbRebootRequired = Receives <b>TRUE</b> if a system restart is necessary to apply the desired configuration, or <b>FALSE</b>
///                       otherwise.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error value otherwise.
///    
@DllImport("CSCAPI")
uint OfflineFilesEnable(BOOL bEnable, int* pbRebootRequired);

///Starts the Offline Files service.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error value otherwise.
///    
@DllImport("CSCAPI")
uint OfflineFilesStart();

///Determines whether the Offline Files feature is enabled and, if so, whether it is active.
///Params:
///    pbActive = Receives <b>TRUE</b> if both the CSC driver and Offline Files Service are in the running state, or <b>FALSE</b>
///               otherwise. This parameter is optional and can be <b>NULL</b>.
///    pbEnabled = Receives <b>TRUE</b> if the CSC driver's start type is set to <b>SERVICE_SYSTEM_START</b> and the Offline Files
///                service's start type is set to <b>SERVICE_AUTO_START</b>, or <b>FALSE</b> otherwise. This parameter is optional
///                and can be <b>NULL</b>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error value otherwise.
///    
@DllImport("CSCAPI")
uint OfflineFilesQueryStatus(int* pbActive, int* pbEnabled);

///Determines whether the Offline Files feature is enabled and, if so, whether it is active and available. This function
///is identical to the OfflineFilesQueryStatus function, except that it has an additional output parameter.
///Params:
///    pbActive = Receives <b>TRUE</b> if both the CSC driver and Offline Files Service are in the running state, or <b>FALSE</b>
///               otherwise. This parameter is optional and can be <b>NULL</b>.
///    pbEnabled = Receives <b>TRUE</b> if the CSC driver's start type is set to <b>SERVICE_SYSTEM_START</b> and the Offline Files
///                service's start type is set to <b>SERVICE_AUTO_START</b>, or <b>FALSE</b> otherwise. This parameter is optional
///                and can be <b>NULL</b>.
///    pbAvailable = Receives <b>TRUE</b> if the Offline Files Service is ready to be started without requiring the computer to be
///                  restarted, or <b>FALSE</b> otherwise. This parameter is optional and can be <b>NULL</b>.
///Returns:
///    Returns <b>ERROR_SUCCESS</b> if successful or a Win32 error value otherwise.
///    
@DllImport("CSCAPI")
uint OfflineFilesQueryStatusEx(int* pbActive, int* pbEnabled, int* pbAvailable);


// Interfaces

@GUID("FD3659E9-A920-4123-AD64-7FC76C7AACDF")
struct OfflineFilesSetting;

@GUID("48C6BE7C-3871-43CC-B46F-1449A1BB2FF3")
struct OfflineFilesCache;

///Used to report significant events associated with Offline Files.
@GUID("E25585C1-0CAA-4EB1-873B-1CAE5B77C314")
interface IOfflineFilesEvents : IUnknown
{
    ///This method is reserved for future use.
    ///Params:
    ///    pszOldPath = 
    ///    pszNewPath = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CacheMoved(const(wchar)* pszOldPath, const(wchar)* pszNewPath);
    ///This method is reserved for future use.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CacheIsFull();
    ///This method is reserved for future use.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CacheIsCorrupted();
    ///This method is reserved for future use.
    ///Params:
    ///    bEnabled = 
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT Enabled(BOOL bEnabled);
    ///This method is reserved for future use.
    ///Params:
    ///    bWasEncrypted = 
    ///    bWasPartial = 
    ///    bIsEncrypted = 
    ///    bIsPartial = 
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT EncryptionChanged(BOOL bWasEncrypted, BOOL bWasPartial, BOOL bIsEncrypted, BOOL bIsPartial);
    ///Reports that the Offline Files cache has begun a synchronization operation.
    ///Params:
    ///    rSyncId = Unique identifier for the synchronization operation that generated this event. Provided by the caller of the
    ///              IOfflineFilesCache::Synchronize, IOfflineFilesCache::Pin, or IOfflineFilesCache::Unpin method. This is
    ///              GUID_NULL if no ID was provided.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncBegin(const(GUID)* rSyncId);
    ///Reports the result of synchronizing a particular file.
    ///Params:
    ///    rSyncId = Unique identifier for the synchronization operation that generated this event. Provided by the caller of the
    ///              IOfflineFilesCache::Synchronize, IOfflineFilesCache::Pin, or IOfflineFilesCache::Unpin method. This is
    ///              GUID_NULL if no ID was provided.
    ///    pszFile = Fully qualified UNC path of the processed file.
    ///    hrResult = Result of the sync operation on this file. The parameter will contain S_OK if the operation completed
    ///               successfully or an value otherwise.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncFileResult(const(GUID)* rSyncId, const(wchar)* pszFile, HRESULT hrResult);
    ///Reports that a sync conflict has been detected and recorded in the sync conflict log.
    ///Params:
    ///    pszConflictPath = The UNC path of the item in conflict.
    ///    pftConflictDateTime = Pointer to a FILETIME structure containing the date and time when the conflict was detected. The value is in
    ///                          UTC.
    ///    ConflictSyncState = Describes the state of the local and remote items in conflict. One of the OFFLINEFILES_SYNC_STATE sync state
    ///                        values, such as OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer .
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncConflictRecAdded(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                 OFFLINEFILES_SYNC_STATE ConflictSyncState);
    ///Reports that a sync conflict has been detected and that a record of the conflict was already present in the sync
    ///conflict log. The log's record has been updated with the latest information.
    ///Params:
    ///    pszConflictPath = The UNC path of the item in conflict.
    ///    pftConflictDateTime = Pointer to a FILETIME structure containing the date and time when the conflict was detected. The value is in
    ///                          UTC.
    ///    ConflictSyncState = Describes the state of the local and remote items in conflict. One of the OFFLINEFILES_SYNC_STATE sync state
    ///                        values, such as OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer .
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncConflictRecUpdated(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    ///Reports that a sync conflict no longer exists and that its record has been removed from the sync conflict log.
    ///Params:
    ///    pszConflictPath = The UNC path of the item that was in conflict.
    ///    pftConflictDateTime = Pointer to a FILETIME structure containing the date and time when the deleted conflict was detected. The
    ///                          value is in UTC.
    ///    ConflictSyncState = Describes the state of the local and remote items in conflict. One of the OFFLINEFILES_SYNC_STATE sync state
    ///                        values, such as OFFLINEFILES_SYNC_STATE_FileChangedOnClient_ChangedOnServer .
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncConflictRecRemoved(const(wchar)* pszConflictPath, const(FILETIME)* pftConflictDateTime, 
                                   OFFLINEFILES_SYNC_STATE ConflictSyncState);
    ///Reports that the Offline Files cache has ended a synchronize operation.
    ///Params:
    ///    rSyncId = Unique identifier for the synchronization operation that generated this event. Provided by the caller of the
    ///              IOfflineFilesCache::Synchronize, IOfflineFilesCache::Pin, or IOfflineFilesCache::Unpin method. This is
    ///              GUID_NULL if no ID was provided.
    ///    hrResult = Result value indicating the reason for the end of the sync operation. This parameter will be S_OK if the
    ///               operation completed successfully, HRESULT_FROM_WIN32(ERROR_CANCELLED) if the operation was aborted and an
    ///               error value if some other failure caused the operation to complete prematurely.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncEnd(const(GUID)* rSyncId, HRESULT hrResult);
    ///Reports that the Offline Files feature has detected the arrival of a network transport. This is most often sent
    ///when a client computer connects to a network.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT NetTransportArrived();
    ///Reports that the Offline Files feature has detected that no network transports are available. This is most often
    ///sent when a client computer disconnects from a network.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT NoNetTransports();
    ///Reports that an item in the Offline Files cache has transitioned from online to offline.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemDisconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache has transitioned from offline to online.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemReconnected(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache is now available for offline use should the remote copy become
    ///unavailable.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache is no longer available for offline use should the remote copy
    ///become unavailable.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemNotAvailableOffline(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache is now pinned and guaranteed to be available offline should the
    ///remote copy become unavailable.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache is no longer pinned. The item may still be available offline but
    ///it is now considered automatically cached.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemNotPinned(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item in the Offline Files cache has been modified.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///    bModifiedData = <b>TRUE</b> if the item's data was modified, <b>FALSE</b> otherwise.
    ///    bModifiedAttributes = <b>TRUE</b> if one or more of the item's attributes were modified, <b>FALSE</b> otherwise.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemModified(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, 
                         BOOL bModifiedAttributes);
    ///Reports that an item has been added to the Offline Files cache.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemAddedToCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that an item has been removed from the Offline Files cache.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemDeletedFromCache(const(wchar)* pszPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that the path for an item in the Offline Files cache has been renamed.
    ///Params:
    ///    pszOldPath = Original UNC path string for the item.
    ///    pszNewPath = New UNC path string for the item.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemRenamed(const(wchar)* pszOldPath, const(wchar)* pszNewPath, OFFLINEFILES_ITEM_TYPE ItemType);
    ///Reports that one or more events destined for this event sink have been lost and will not be delivered. The
    ///receipt of this event indicates that the service is attempting to deliver events to this event sink faster than
    ///the sink is consuming them.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT DataLost();
    ///This event is delivered to all registered event subscribers on a periodic basis.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT Ping();
}

///Used to report additional events associated with Offline Files.
@GUID("1EAD8F56-FF76-4FAA-A795-6F6EF792498B")
interface IOfflineFilesEvents2 : IOfflineFilesEvents
{
    ///Reports that the Offline Files service is beginning to attempt to reconnect all offline scopes.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemReconnectBegin();
    ///Reports that the Offline Files service has completed its attempt to reconnect all offline scopes.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemReconnectEnd();
    ///This method is reserved for future use.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CacheEvictBegin();
    ///This method is reserved for future use.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CacheEvictEnd();
    ///Reports that the Offline Files service is beginning to perform a background synchronization pass.
    ///Params:
    ///    dwSyncControlFlags = One or more OFFLINEFILES_SYNC_CONTROL_FLAG_XXXXXX flags describing the purpose of the sync operation. These
    ///                         may be used to determine if the sync is a one-way or two-way sync. These flags are described in the
    ///                         <i>dwSyncControl</i> parameter of the IOfflineFilesCache::Synchronize method.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT BackgroundSyncBegin(uint dwSyncControlFlags);
    ///Reports that the Offline Files service completed a background synchronization pass.
    ///Params:
    ///    dwSyncControlFlags = One or more OFFLINEFILES_SYNC_CONTROL_FLAG_XXXXXX flags describing the purpose of the sync operation. These
    ///                         may be used to determine if the sync is a one-way or two-way sync. These flags are described in the
    ///                         <i>dwSyncControl</i> parameter of the IOfflineFilesCache::Synchronize method.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT BackgroundSyncEnd(uint dwSyncControlFlags);
    ///Reports that the Offline Files service detected a change in one or more of its setting values that are controlled
    ///by Group Policy.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT PolicyChangeDetected();
    ///Reports that the Offline Files service detected a change in one or more of its setting values that are not
    ///controlled by Group Policy.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT PreferenceChangeDetected();
    ///Reports that the Offline Files service has applied the changes that were detected in Group Policy or preference
    ///values.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SettingsChangesApplied();
}

///Used to report events associated with transparently cached items.
@GUID("9BA04A45-EE69-42F0-9AB1-7DB5C8805808")
interface IOfflineFilesEvents3 : IOfflineFilesEvents2
{
    ///Reports that an action has been performed on a transparently cached item.
    ///Params:
    ///    pszPath = The item's UNC path string.
    ///    EventType = An OFFLINEFILES_EVENTS enumeration value that indicates the type of the item.
    ///    ItemType = An OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///    bModifiedData = <b>TRUE</b> if the item's data was modified, <b>FALSE</b> otherwise.
    ///    bModifiedAttributes = <b>TRUE</b> if one or more of the item's attributes were modified, <b>FALSE</b> otherwise.
    ///    pzsOldPath = The original UNC path string for the item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT TransparentCacheItemNotify(const(wchar)* pszPath, OFFLINEFILES_EVENTS EventType, 
                                       OFFLINEFILES_ITEM_TYPE ItemType, BOOL bModifiedData, BOOL bModifiedAttributes, 
                                       const(wchar)* pzsOldPath);
    ///Reports that a file prefetch operation has begun.
    ///Params:
    ///    pszPath = The UNC path of the file.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT PrefetchFileBegin(const(wchar)* pszPath);
    ///Reports that a file prefetch operation has ended.
    ///Params:
    ///    pszPath = The UNC path of the file.
    ///    hrResult = Receives the result of the operation. Contains <b>S_OK</b> if the operation completed successfully or an
    ///               error value otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT PrefetchFileEnd(const(wchar)* pszPath, HRESULT hrResult);
}

@GUID("DBD69B1E-C7D2-473E-B35F-9D8C24C0C484")
interface IOfflineFilesEvents4 : IOfflineFilesEvents3
{
    HRESULT PrefetchCloseHandleBegin();
    HRESULT PrefetchCloseHandleEnd(uint dwClosedHandleCount, uint dwOpenHandleCount, HRESULT hrResult);
}

///Provides a mechanism for recipients of published events to restrict the number of event instances they receive.
@GUID("33FC4E1B-0716-40FA-BA65-6E62A84A846F")
interface IOfflineFilesEventsFilter : IUnknown
{
    ///Retrieves a UNC path string and a scope indicator describing which path-based events should be delivered to this
    ///event sink.
    ///Params:
    ///    ppszFilter = Receives a fully qualified UNC path string identifying the path associated with the filter. The memory for
    ///                 this string must be allocated using the CoTaskMemAlloc function.
    ///    pMatch = Receives an OFFLINEFILES_PATHFILTER_MATCH enumeration value indicating which descendants of the filter path
    ///             are to be included in the set of events delivered to the event sink.
    ///Returns:
    ///    Return <b>S_OK</b> if implemented, <b>E_NOTIMPL</b> if not implemented.
    ///    
    HRESULT GetPathFilter(ushort** ppszFilter, OFFLINEFILES_PATHFILTER_MATCH* pMatch);
    ///Retrieves an array of OFFLINEFILES_EVENTS enumeration values describing which events should be received by the
    ///event sink. If a particular event is specified both in <b>IOfflineFilesEventsFilter::GetIncludedEvents</b> and
    ///IOfflineFilesEventsFilter::GetExcludedEvents, the event is excluded from this event sink.
    ///Params:
    ///    cElements = Specifies the maximum number of elements that can be stored in the array referenced by the <i>prgEvents</i>
    ///                parameter.
    ///    prgEvents = Contains the address of an array of OFFLINEFILES_EVENTS enumeration values. Place the
    ///                <b>OFFLINEFILES_EVENT_XXXXXX</b> identifier in an array entry to specify that the corresponding event is
    ///                desired by this event sink.
    ///    pcEvents = Receives the actual number of elements written to the array referenced by the <i>prgEvents</i> parameter.
    ///Returns:
    ///    Return <b>S_OK</b> if implemented, <b>E_NOTIMPL</b> if not implemented.
    ///    
    HRESULT GetIncludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
    ///Retrieves an array of OFFLINEFILES_EVENTS enumeration values describing which events should not be received by
    ///the event sink. If a particular event is specified both in IOfflineFilesEventsFilter::GetIncludedEvents and
    ///<b>IOfflineFilesEventsFilter::GetExcludedEvents</b>, the event is excluded from this event sink.
    ///Params:
    ///    cElements = Specifies the maximum number of elements that can be stored in the array referenced by the <i>prgEvents</i>
    ///                parameter.
    ///    prgEvents = Contains the address of an array of OFFLINEFILES_EVENTS enumeration values. Place the
    ///                <b>OFFLINEFILES_EVENT_XXXXXX</b> identifier in an array entry to specify that the corresponding event is not
    ///                desired by this event sink.
    ///    pcEvents = Receives the actual number of elements written to the array referenced by the <i>prgEvents</i> parameter.
    ///Returns:
    ///    Return <b>S_OK</b> if implemented, <b>E_NOTIMPL</b> if not implemented.
    ///    
    HRESULT GetExcludedEvents(uint cElements, char* prgEvents, uint* pcEvents);
}

///Provides a text description and raw data block associated with an error.
@GUID("7112FA5F-7571-435A-8EB7-195C7C1429BC")
interface IOfflineFilesErrorInfo : IUnknown
{
    ///Retrieves a block of bytes containing internal data associated with the error. The content of this block is
    ///intended for use by the Windows development and support teams and is subject to change in any version of Windows.
    ///No definition of the data block is provided.
    ///Params:
    ///    ppBlob = Receives the address of a BYTE_BLOB structure describing the raw data. The caller must free this memory block
    ///             by using the CoTaskMemFree function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetRawData(BYTE_BLOB** ppBlob);
    ///Retrieves a text string describing the error. In most cases, this is the system error string reported for the
    ///sync result using the Win32 function FormatMessage.
    ///Params:
    ///    ppszDescription = Receives the address of a text string describing the error. The caller must free this memory block by using
    ///                      the CoTaskMemFree function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetDescription(ushort** ppszDescription);
}

///Provides file attributes, time information, and file size for an item associated with a sync error.
@GUID("ECDBAF0D-6A18-4D55-8017-108F7660BA44")
interface IOfflineFilesSyncErrorItemInfo : IUnknown
{
    HRESULT GetFileAttributesA(uint* pdwAttributes);
    ///Retrieves the last-write and change times for the item.
    ///Params:
    ///    pftLastWrite = Receives a pointer to a FILETIME structure containing the item's last-write time value.
    ///    pftChange = Receives a pointer to a FILETIME structure containing the item's change time value.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetFileTimes(FILETIME* pftLastWrite, FILETIME* pftChange);
    ///Retrieves the size of the item in bytes.
    ///Params:
    ///    pSize = Receives the item's size in bytes.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetFileSize(LARGE_INTEGER* pSize);
}

///Supplied with the IOfflineFilesSyncProgress::SyncItemResult method to communicate details about the item that
///experienced a sync error.
@GUID("59F95E46-EB54-49D1-BE76-DE95458D01B0")
interface IOfflineFilesSyncErrorInfo : IOfflineFilesErrorInfo
{
    ///Retrieves a value indicating the type of sync operation that was being performed when the error was encountered.
    ///Params:
    ///    pSyncOp = Receives a value from the OFFLINEFILES_SYNC_OPERATION enumeration that indicates the operation type.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetSyncOperation(OFFLINEFILES_SYNC_OPERATION* pSyncOp);
    ///Retrieves a value containing a set of flags that describe what changes were encountered during the sync operation
    ///associated with the sync error.
    ///Params:
    ///    pdwItemChangeFlags = Receives a set of flags describing what changes were encountered during the sync operation. This parameter
    ///                         can be one or more of the following flag values:
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetItemChangeFlags(uint* pdwItemChangeFlags);
    ///Indicates whether information was queried for the local, remote, or original copy of the item during
    ///synchronization.
    ///Params:
    ///    pbLocalEnumerated = Receives <b>TRUE</b> if information was queried for the local copy of the item during synchronization, or
    ///                        <b>FALSE</b> otherwise.
    ///    pbRemoteEnumerated = Receives <b>TRUE</b> if information was queried for the remote copy of the item during synchronization, or
    ///                         <b>FALSE</b> otherwise.
    ///    pbOriginalEnumerated = Receives <b>TRUE</b> if information was queried for the original copy of the item during synchronization, or
    ///                           <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT InfoEnumerated(int* pbLocalEnumerated, int* pbRemoteEnumerated, int* pbOriginalEnumerated);
    ///Indicates whether information was obtained for the local, remote, or original copy of the item during
    ///synchronization.
    ///Params:
    ///    pbLocalInfo = Receives <b>TRUE</b> if information was obtained for the local copy of the item during synchronization, or
    ///                  <b>FALSE</b> otherwise. If <b>TRUE</b>, GetLocalInfo can be called to retrieve the information.
    ///    pbRemoteInfo = Receives <b>TRUE</b> if information was obtained for the remote copy of the item during synchronization, or
    ///                   <b>FALSE</b> otherwise. If <b>TRUE</b>, GetRemoteInfo can be called to retrieve the information.
    ///    pbOriginalInfo = Receives <b>TRUE</b> if information was obtained for the original copy of the item during synchronization, or
    ///                     <b>FALSE</b> otherwise. If <b>TRUE</b>, GetOriginalInfo can be called to retrieve the information.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT InfoAvailable(int* pbLocalInfo, int* pbRemoteInfo, int* pbOriginalInfo);
    ///Retrieves an instance of the IOfflineFilesSyncErrorItemInfo interface containing the file times, size, and
    ///attributes of the local copy of the item involved in the synchronization.
    ///Params:
    ///    ppInfo = Receives the address of an instance of IOfflineFilesSyncErrorItemInfo containing information about the local
    ///             item copy involved in the synchronization.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetLocalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    ///Retrieves an instance of the IOfflineFilesSyncErrorItemInfo interface containing the file times, size, and
    ///attributes of the remote copy of the item involved in the synchronization.
    ///Params:
    ///    ppInfo = Receives the address of an instance of IOfflineFilesSyncErrorItemInfo containing information about the remote
    ///             item copy involved in the synchronization.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetRemoteInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
    ///Retrieves an instance of the IOfflineFilesSyncErrorItemInfo interface containing the file times, size, and
    ///attributes of the original copy of the item involved in the synchronization. "Original" refers to the state
    ///information recorded the last time the cached item was in sync with the server.
    ///Params:
    ///    ppInfo = Receives the address of an instance of IOfflineFilesSyncErrorItemInfo containing information about the
    ///             original item copy involved in the synchronization.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetOriginalInfo(IOfflineFilesSyncErrorItemInfo* ppInfo);
}

///Used to report progress back to callers of lengthy Offline Files operations. This interface provides the most basic
///"begin" and "end" notifications. It is used as a base interface for all other progress interfaces.
@GUID("FAD63237-C55B-4911-9850-BCF96D4C979E")
interface IOfflineFilesProgress : IUnknown
{
    ///Reports that an operation has begun.
    ///Params:
    ///    pbAbort = Set this value to <b>TRUE</b> to cancel the operation. Set to <b>FALSE</b> to continue.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT Begin(int* pbAbort);
    ///May be called during lengthy operations to determine if the operation should be canceled.
    ///Params:
    ///    pbAbort = Set this value to <b>TRUE</b> to cancel the operation. Set to <b>FALSE</b> to continue.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT QueryAbort(int* pbAbort);
    ///Reports that an operation has ended.
    ///Params:
    ///    hrResult = Indicates the result of the operation as a whole. Contains S_OK if the operation completed successfully,
    ///               HRESULT_FROM_WIN32(ERROR_CANCELLED) if the operation was canceled or an error value otherwise.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT End(HRESULT hrResult);
}

///Used to report progress back to callers of lengthy Offline Files operations.
@GUID("C34F7F9B-C43D-4F9D-A776-C0EB6DE5D401")
interface IOfflineFilesSimpleProgress : IOfflineFilesProgress
{
    ///Reports that an operation on an item is beginning.
    ///Params:
    ///    pszFile = Receives the fully qualified UNC path of the file or directory that is being processed.
    ///    pResponse = Set this parameter to a value from the OFFLINEFILES_OP_RESPONSE enumeration that indicates how the operation
    ///                is to proceed
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    ///Reports that an item has been processed during the operation. This method is called even if the operation was
    ///unsuccessful. Check the value received in the <i>hrResult</i> parameter to determine whether the operation was
    ///successful.
    ///Params:
    ///    pszFile = Receives the fully qualified UNC path of the item that was processed.
    ///    hrResult = Receives the result of the operation for the item. Contains S_OK if the operation completed successfully or
    ///               an error value otherwise.
    ///    pResponse = Set this parameter to a value from the OFFLINEFILES_OP_RESPONSE enumeration that indicates how the operation
    ///                is to proceed.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ItemResult(const(wchar)* pszFile, HRESULT hrResult, OFFLINEFILES_OP_RESPONSE* pResponse);
}

///Used to report progress back to the caller during synchronization and synchronization-related operations. This
///interface inherits from IOfflineFilesProgress. For a description of inherited methods, see IOfflineFilesProgress.
@GUID("6931F49A-6FC7-4C1B-B265-56793FC451B7")
interface IOfflineFilesSyncProgress : IOfflineFilesProgress
{
    ///Reports that a synchronization operation on an item is beginning.
    ///Params:
    ///    pszFile = Receives the fully qualified UNC path of the file or directory to be processed.
    ///    pResponse = Your implementation of this method should set this parameter to a value from the OFFLINEFILES_OP_RESPONSE
    ///                enumeration that indicates how the operation is to proceed.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncItemBegin(const(wchar)* pszFile, OFFLINEFILES_OP_RESPONSE* pResponse);
    ///Reports that an item has been processed during the synchronization operation. This method is called even if the
    ///operation was unsuccessful. Check the value received in the <i>hrResult</i> parameter to determine whether the
    ///operation was successful.
    ///Params:
    ///    pszFile = Receives the fully qualified UNC path of the item that was processed.
    ///    hrResult = Receives the result of the operation for the item. Contains S_OK if the operation completed successfully or
    ///               an error value otherwise.
    ///    pErrorInfo = Receives a pointer to an instance of the IOfflineFilesSyncErrorInfo interface that provides detailed
    ///                 information about the result of the sync operation.
    ///    pResponse = Set this parameter to a value from the OFFLINEFILES_OP_RESPONSE enumeration that indicates how the operation
    ///                is to proceed.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT SyncItemResult(const(wchar)* pszFile, HRESULT hrResult, IOfflineFilesSyncErrorInfo pErrorInfo, 
                           OFFLINEFILES_OP_RESPONSE* pResponse);
}

///Used by a client calling the IOfflineFilesCache::Synchronize method to prescribe a conflict resolution strategy for
///sync conflicts as they are detected.
@GUID("B6DD5092-C65C-46B6-97B8-FADD08E7E1BE")
interface IOfflineFilesSyncConflictHandler : IUnknown
{
    ///Provides a resolution decision for a sync conflict.
    ///Params:
    ///    pszPath = The fully qualified UNC path of the item in conflict.
    ///    fStateKnown = Indicates if the sync state was based on the client state, server state, or both. This parameter can be one
    ///                  or both of the following flag values.
    ///    state = A value from the OFFLINEFILES_SYNC_STATE enumeration indicating the state of the item in conflict.
    ///    fChangeDetails = In cases where the <i>state</i> code indicates a change in item state, this value describes the change in
    ///                     further detail. The value can be either <b>OFFLINEFILES_CHANGES_NONE</b> (0x00000000) or one or more of the
    ///                     following flag values:
    ///    pConflictResolution = Receives the desired resolution code. Specify a value from the OFFLINEFILES_SYNC_CONFLICT_RESOLVE
    ///                          enumeration.
    ///    ppszNewName = If the value of the <i>pConflictResolution</i> parameter is
    ///                  <b>OFFLINEFILES_SYNC_CONFLICT_RESOLVE_KEEPALLCHANGES</b>, the conflict handler must provide a new name for
    ///                  the item. This new name is used for the new copies created remotely and locally. Note that this is a file
    ///                  name, not a fully qualified path. The name string must be allocated using CoTaskMemAlloc. This parameter may
    ///                  be <b>NULL</b> if a new name is not required by the resolution. The Offline Files conflict handler used by
    ///                  Sync Center creates a name of the following format: &lt;original name&gt; (&lt;user name&gt;
    ///                  v<i>N</i>).&lt;original ext&gt; where <i>N</i> is a version number. Therefore, if the original file name is
    ///                  "samples.doc" and the user's name is "Alice", the new file name will be: "samples (Alice v1).doc" If a file
    ///                  of that name exists the Offline Files conflict handler increments <i>N</i> until a unique name is found, for
    ///                  example: <ul> <li>samples (Alice v2).doc</li> <li>samples (Alice v3).doc</li> </ul> This description is
    ///                  provided only to illustrate how the Offline Files conflict handler in Sync Center creates new file names. An
    ///                  implementation of IOfflineFilesSyncConflictHandler is free to use any name format that it wishes to define.
    ///Returns:
    ///    The return value is ignored.
    ///    
    HRESULT ResolveConflict(const(wchar)* pszPath, uint fStateKnown, OFFLINEFILES_SYNC_STATE state, 
                            uint fChangeDetails, OFFLINEFILES_SYNC_CONFLICT_RESOLVE* pConflictResolution, 
                            ushort** ppszNewName);
}

///Represents an instance of a filter to be applied to an enumeration. For a complete description of filtering behavior,
///see the section titled "Item Filtering."
@GUID("F4B5A26C-DC05-4F20-ADA4-551F1077BE5C")
interface IOfflineFilesItemFilter : IUnknown
{
    ///Provides flags to control flag-based filtering of items.
    ///Params:
    ///    pullFlags = Receives the Offline Files Filter Flags bit values to be used in the filter evaluation. A bit value of 1
    ///                means that the corresponding data condition in the item must be <b>TRUE</b> for a filter match. A bit value
    ///                of 0 means the corresponding data condition in the item must be <b>FALSE</b> for a filter match.
    ///    pullMask = Receives the Offline Files Filter Flags bit values identifying which flags are to be evaluated. A bit value
    ///               of 1 means "evaluate the corresponding data" while a bit value of 0 means "do not evaluate the corresponding
    ///               data."
    ///Returns:
    ///    Returns <b>S_OK</b> if the filter supports flag filtering and the flag filtering information is provided.
    ///    Returns <b>E_NOTIMPL</b> if flag filtering is not supported. Any other error value causes the creation of the
    ///    enumerator to fail.
    ///    
    HRESULT GetFilterFlags(ulong* pullFlags, ulong* pullMask);
    ///Provides time-value-comparison semantics to control filtering of items based on time.
    ///Params:
    ///    pftTime = Receives a pointer to a FILETIME structure containing the UTC time value that the item is to be compared
    ///              with.
    ///    pbEvalTimeOfDay = Receives a Boolean value indicating whether the time-of-day part of the FILETIME value is to be considered in
    ///                      the item evaluation. If the flag value is <b>TRUE</b>, the time-of-day is considered. If the flag value is
    ///                      <b>FALSE</b>, the time-of-day information is stripped from all time values involved in the evaluation;
    ///                      leaving only the year, month, and day. This can be very helpful when the granularity of filtering is a day.
    ///    pTimeType = Receives an OFFLINEFILES_ITEM_TIME enumeration value that indicates which time value associated with the
    ///                cache item is to be used in the evaluation. Only one value is to be provided. This is not a mask.
    ///    pCompare = Receives an OFFLINEFILES_COMPARE enumeration value that indicates the type of logical comparison to perform
    ///               between the selected item time and the filter time pointed to by the <i>pftTime</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if the filter supports time filtering and the time filtering information is provided.
    ///    Returns <b>E_NOTIMPL</b> if time filtering is not supported. Any other error value causes the creation of the
    ///    enumerator to fail.
    ///    
    HRESULT GetTimeFilter(FILETIME* pftTime, int* pbEvalTimeOfDay, OFFLINEFILES_ITEM_TIME* pTimeType, 
                          OFFLINEFILES_COMPARE* pCompare);
    ///Provides a filter pattern string to limit enumerated items based on item name patterns. Note that pattern
    ///filtering is available only for inclusion filters. If you provide a pattern filter as an exclusion filter, it is
    ///ignored.
    ///Params:
    ///    pszPattern = Receives the filter pattern string. Pattern strings can contain the * and ? wildcard characters. Examples:
    ///                 <ul> <li>*.DOC</li> <li>ABC.*</li> <li>AB?.??2</li> </ul>
    ///    cchPattern = Specifies the maximum length in characters of the buffer receiving the pattern string. This value is
    ///                 currently <b>MAX_PATH</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if the filter supports pattern filtering and the filter string is successfully copied to
    ///    the pszPattern buffer. Returns <b>E_NOTIMPL</b> if pattern filtering is not supported. Any other error value
    ///    causes the creation of the enumerator to fail.
    ///    
    HRESULT GetPatternFilter(const(wchar)* pszPattern, uint cchPattern);
}

///Represents a single item in the Offline Files cache. The item may be a server, share, directory or file. While each
///item type has a type-specific interface (for example, IOfflineFilesServerItem), this interface provides the
///functionality that is common to all items.
@GUID("4A753DA6-E044-4F12-A718-5D14D079A906")
interface IOfflineFilesItem : IUnknown
{
    ///Returns a type code identifying the type of the item: server, share, directory, or file.
    ///Params:
    ///    pItemType = Receives an OFFLINEFILES_ITEM_TYPE enumeration value that indicates the type of the item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetItemType(OFFLINEFILES_ITEM_TYPE* pItemType);
    ///Retrieves the fully qualified UNC path string for an item in the Offline Files cache.
    ///Params:
    ///    ppszPath = Receives the fully qualified UNC path of the item. The caller is responsible for freeing the path buffer by
    ///               using the CoTaskMemFree function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetPath(ushort** ppszPath);
    ///Retrieves the IOfflineFilesItem interface for the parent of the item. This method can be called repeatedly to
    ///retrieve items at the top of the cache namespace.
    ///Params:
    ///    ppItem = Receives the address of the IOfflineFilesItem interface of the parent item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. If the item is a server item, this function
    ///    returns <code>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</code>. Server items are at the top of the Offline
    ///    Files cache namespace and do not have a parent item. The parent of a server item is the cache itself. This is
    ///    represented by the fact that an instance of IOfflineFilesItem is also a container of server items.
    ///    
    HRESULT GetParentItem(IOfflineFilesItem* ppItem);
    ///Refreshes any data cached in the object by rereading from the Offline Files cache.
    ///Params:
    ///    dwQueryFlags = TBD
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the file does not exist in the cache. This would
    ///    happen if a file has been deleted from the cache after the file object was first created.
    ///    
    HRESULT Refresh(uint dwQueryFlags);
    ///Determines whether an item has been deleted from the Offline Files cache.
    ///Params:
    ///    pbMarkedForDeletion = Receives <b>TRUE</b> if the item has been deleted, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsMarkedForDeletion(int* pbMarkedForDeletion);
}

///Represents a server item in the Offline Files cache.
@GUID("9B1C9576-A92B-4151-8E9E-7C7B3EC2E016")
interface IOfflineFilesServerItem : IOfflineFilesItem
{
}

///Represents a share item in the Offline Files cache.
@GUID("BAB7E48D-4804-41B5-A44D-0F199B06B145")
interface IOfflineFilesShareItem : IOfflineFilesItem
{
}

///Represents a directory item in the Offline Files cache.
@GUID("2273597A-A08C-4A00-A37A-C1AE4E9A1CFD")
interface IOfflineFilesDirectoryItem : IOfflineFilesItem
{
}

///Represents a file item in the Offline Files cache.
@GUID("8DFADEAD-26C2-4EFF-8A72-6B50723D9A00")
interface IOfflineFilesFileItem : IOfflineFilesItem
{
    ///Determines whether an item in the Offline Files cache is sparsely cached.
    ///Params:
    ///    pbIsSparse = Receives <b>TRUE</b> if the item is sparsely cached, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsSparse(int* pbIsSparse);
    ///Determines whether an item in the Offline Files cache is encrypted.
    ///Params:
    ///    pbIsEncrypted = Receives <b>TRUE</b> if the item is encrypted, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsEncrypted(int* pbIsEncrypted);
}

///Represents a collection of IOfflineFilesItem interface pointers.
@GUID("DA70E815-C361-4407-BC0B-0D7046E5F2CD")
interface IEnumOfflineFilesItems : IUnknown
{
    ///Retrieves the next item in the enumeration and advances the enumerator.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of elements returned.
    ///    pceltFetched = Pointer to number of elements actually supplied.
    ///Returns:
    ///    Returns <b>S_OK</b> if the number of elements returned is <i>celt</i>; S_FALSE if a number less than
    ///    <i>celt</i> is returned; or an error value otherwise.
    ///    
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    ///Skips over the next specified number of elements in the enumeration.
    ///Params:
    ///    celt = Number of elements to be skipped.
    ///Returns:
    ///    Returns <b>S_OK</b> if the number of elements skipped is <i>celt</i>; S_FALSE if a number less than
    ///    <i>celt</i> is skipped; or an error value otherwise.
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration to the beginning.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT Reset();
    ///Creates a new instance of the enumerator with the same enumeration state as the current one.
    ///Params:
    ///    ppenum = Address of an IEnumOfflineFilesItems pointer variable that receives the interface pointer of the new
    ///             enumeration object.
    ///Returns:
    ///    Returns <b>S_OK</b> if the enumerator is created successfully, or an error value otherwise.
    ///    
    HRESULT Clone(IEnumOfflineFilesItems* ppenum);
}

///Used to access item enumeration functionality in the Offline Files cache.
@GUID("3836F049-9413-45DD-BF46-B5AAA82DC310")
interface IOfflineFilesItemContainer : IUnknown
{
    ///Returns an enumerator of child items for the cache item implementing this method. Server, share, and directory
    ///entries in the Offline Files cache implement this method to expose the enumeration of their immediate children.
    ///<div class="alert"><b>Note</b> A call to QueryInterface to query a file item for
    ///<b>IID_IOfflineFilesItemContainer</b> fails with <b>E_NOINTERFACE</b>, because file items have no
    ///children.</div><div> </div>
    ///Params:
    ///    dwQueryFlags = Flags affecting the amount of query activity at the time of enumeration. The parameter may contain one or
    ///                   more of the following bit flags.
    ///    ppenum = Enumerator of IOfflineFilesItem interface pointers.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT EnumItems(uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
    ///Returns an enumerator of child items for the cache item implementing this method. Server, share, and directory
    ///entries in the Offline Files cache implement this method to expose the enumeration of their immediate children.
    ///However, a call to QueryInterface to query a file item for <b>IID_IOfflineFilesItemContainer</b> fails with
    ///<b>E_NOINTERFACE</b>, because file items have no children. This method is similar to
    ///IOfflineFilesItemContainer::EnumItems, except that it allows filtering and flat enumeration.
    ///Params:
    ///    pIncludeFileFilter = If provided, references the filter applied to the decision to include files. This parameter is optional and
    ///                         can be <b>NULL</b>.
    ///    pIncludeDirFilter = If provided, references the filter applied to the decision to include directories. This parameter is optional
    ///                        and can be <b>NULL</b>.
    ///    pExcludeFileFilter = If provided, references the filter applied to the decision to exclude files. This parameter is optional and
    ///                         can be <b>NULL</b>.
    ///    pExcludeDirFilter = If provided, references the filter applied to the decision to exclude directories. This parameter is optional
    ///                        and can be <b>NULL</b>.
    ///    dwEnumFlags = Flags affecting the type of enumeration performed. The parameter may contain one or more of the following
    ///                  flag bits.
    ///    dwQueryFlags = Flags affecting the amount of query activity at the time of enumeration. The parameter can contain one or
    ///                   more of the following bit flags.
    ///    ppenum = Enumerator of IOfflineFilesItem interface pointers.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT EnumItemsEx(IOfflineFilesItemFilter pIncludeFileFilter, IOfflineFilesItemFilter pIncludeDirFilter, 
                        IOfflineFilesItemFilter pExcludeFileFilter, IOfflineFilesItemFilter pExcludeDirFilter, 
                        uint dwEnumFlags, uint dwQueryFlags, IEnumOfflineFilesItems* ppenum);
}

///Represents the information associated with local changes made to an item while working offline.
@GUID("A96E6FA4-E0D1-4C29-960B-EE508FE68C72")
interface IOfflineFilesChangeInfo : IUnknown
{
    ///Determines whether an item in the Offline Files cache has been modified.
    ///Params:
    ///    pbDirty = Receives <b>TRUE</b> if the item has been modified in some way while working offline, or <b>FALSE</b>
    ///              otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsDirty(int* pbDirty);
    ///Determines whether an item has been deleted from the Offline Files cache while working offline.
    ///Params:
    ///    pbDeletedOffline = Receives <b>TRUE</b> if the item has been deleted from the Offline Files cache while working offline, or
    ///                       <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsDeletedOffline(int* pbDeletedOffline);
    ///Determines whether an item was created in the Offline Files cache while working offline.
    ///Params:
    ///    pbCreatedOffline = Receives <b>TRUE</b> if the item was created in the Offline Files cache while working offline, or
    ///                       <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsCreatedOffline(int* pbCreatedOffline);
    ///Determines whether an item's data was modified while working offline.
    ///Params:
    ///    pbLocallyModifiedData = Receives <b>TRUE</b> if the item's data was modified in the Offline Files cache while working offline, or
    ///                            <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsLocallyModifiedData(int* pbLocallyModifiedData);
    ///Determines whether one or more of an item's attributes were modified while working offline.
    ///Params:
    ///    pbLocallyModifiedAttributes = Receives <b>TRUE</b> if one or more of the item's attributes were modified in the Offline Files cache while
    ///                                  working offline, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsLocallyModifiedAttributes(int* pbLocallyModifiedAttributes);
    ///Determines whether one or more of an item's time values were modified while working offline.
    ///Params:
    ///    pbLocallyModifiedTime = Receives <b>TRUE</b> if one or more of the item's time values were modified in the Offline Files cache while
    ///                            working offline, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsLocallyModifiedTime(int* pbLocallyModifiedTime);
}

///Represents information about an unsynchronized ("dirty") file in the Offline Files cache.
@GUID("0F50CE33-BAC9-4EAA-A11D-DA0E527D047D")
interface IOfflineFilesDirtyInfo : IUnknown
{
    ///Retrieves the amount of unsynchronized ("dirty") data for the associated file in the local Offline Files cache.
    ///Params:
    ///    pDirtyByteCount = The number of bytes of unsynchronized data.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT LocalDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
    ///This method is reserved for future use.
    ///Params:
    ///    pDirtyByteCount = The number of bytes of unsynchronized data.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT RemoteDirtyByteCount(LARGE_INTEGER* pDirtyByteCount);
}

///Represents the standard information associated with a file system item in the Offline Files cache.
@GUID("BC1A163F-7BFD-4D88-9C66-96EA9A6A3D6B")
interface IOfflineFilesFileSysInfo : IUnknown
{
    ///Retrieves the Win32 attributes for an item.
    ///Params:
    ///    copy = An OFFLINEFILES_ITEM_COPY enumeration value identifying which copy (local or remote) to retrieve the
    ///           attributes for. <b>Windows Vista: </b>This value must be <b>OFFLINEFILES_ITEM_COPY_LOCAL</b>.
    ///    pdwAttributes = Receives the file attribute mask for the item. One or more of <b>FILE_ATTRIBUTE_<i>XXXXXX</i></b> as defined
    ///                    in the Windows SDK. For more information, see the GetFileAttributes function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetAttributes(OFFLINEFILES_ITEM_COPY copy, uint* pdwAttributes);
    ///Retrieves the time values associated with an item.
    ///Params:
    ///    copy = An OFFLINEFILES_ITEM_COPY enumeration value identifying which copy (local or remote) to retrieve the time
    ///           values for. <b>Windows Vista: </b>This value must be <b>OFFLINEFILES_ITEM_COPY_LOCAL</b>.
    ///    pftCreationTime = Receives a pointer to a FILETIME structure containing the item's creation time.
    ///    pftLastWriteTime = Receives a pointer to a FILETIME structure containing the item's last-write time. This is the time the item's
    ///                       data was last written to.
    ///    pftChangeTime = Receives a pointer to a FILETIME structure containing the item's last-change time. This is the time the
    ///                    item's data or attributes were last changed.
    ///    pftLastAccessTime = Receives a pointer to a FILETIME structure containing the item's last-access time. This is the time the item
    ///                        was last read from or written to.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetTimes(OFFLINEFILES_ITEM_COPY copy, FILETIME* pftCreationTime, FILETIME* pftLastWriteTime, 
                     FILETIME* pftChangeTime, FILETIME* pftLastAccessTime);
    ///Retrieves the size of an item.
    ///Params:
    ///    copy = An OFFLINEFILES_ITEM_COPY enumeration value identifying which copy (local or remote) to retrieve the size of.
    ///           <b>Windows Vista: </b>This value must be <b>OFFLINEFILES_ITEM_COPY_LOCAL</b>.
    ///    pSize = Receive the size, in bytes, of the item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetFileSize(OFFLINEFILES_ITEM_COPY copy, LARGE_INTEGER* pSize);
}

///Represents the pinned status of an item in the Offline Files cache. When an item is pinned into the Offline Files
///cache by using the IOfflineFilesCache::Pin method, it may be pinned for one of the following reasons: <table> <tr>
///<th>Flag Value</th> <th>Meaning</th> </tr> <tr> <td><b>OFFLINEFILES_PIN_CONTROL_FLAG_FORUSER</b></td> <td>This flag
///is set when a file is pinned using the "Always available offline" option in Windows explorer.</td> </tr> <tr>
///<td><b>OFFLINEFILES_PIN_CONTROL_FLAG_FORUSER_POLICY</b></td> <td>This flag is set when a file is pinned by the
///per-user "Administratively assigned offline files" Group Policy.</td> </tr> <tr>
///<td><b>OFFLINEFILES_PIN_CONTROL_FLAG_FORALL</b></td> <td>This flag is set when a file is pinned by the per-computer
///"Administratively assigned offline files" Group Policy.</td> </tr> <tr>
///<td><b>OFFLINEFILES_PIN_CONTROL_FLAG_FORREDIR</b></td> <td>This flag is set when a redirected folder is pinned by
///Folder Redirection.</td> </tr> </table> Each of the various <i>IsPinnedForUserXxxxxx</i> methods expresses one of
///these reasons.
@GUID("5B2B0655-B3FD-497D-ADEB-BD156BC8355B")
interface IOfflineFilesPinInfo : IUnknown
{
    ///Determines whether the item is pinned.
    ///Params:
    ///    pbPinned = Receives <b>TRUE</b> if the item is pinned for any reason, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPinned(int* pbPinned);
    ///Determines whether the item was pinned by a user.
    ///Params:
    ///    pbPinnedForUser = Receives <b>TRUE</b> if the item was pinned by a user, or <b>FALSE</b> otherwise.
    ///    pbInherit = Receives <b>TRUE</b> if the pinned state is inherited by new child items, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPinnedForUser(int* pbPinnedForUser, int* pbInherit);
    ///Determines whether the item was pinned for users by Group Policy.
    ///Params:
    ///    pbPinnedForUser = Receives <b>TRUE</b> if the item was pinned for users by Group Policy, or <b>FALSE</b> otherwise.
    ///    pbInherit = Receives <b>TRUE</b> if the pinned state is inherited by new child items, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPinnedForUserByPolicy(int* pbPinnedForUser, int* pbInherit);
    ///Determines whether the item was pinned for all users on the computer by Group Policy.
    ///Params:
    ///    pbPinnedForComputer = Receives <b>TRUE</b> if the item was pinned for users by Group Policy, or <b>FALSE</b> otherwise.
    ///    pbInherit = Receives <b>TRUE</b> if the pinned state is inherited by new child items, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPinnedForComputer(int* pbPinnedForComputer, int* pbInherit);
    ///Determines whether the item was pinned by Folder Redirection.
    ///Params:
    ///    pbPinnedForFolderRedirection = Receives <b>TRUE</b> if the item was pinned for users by Folder Redirection, or <b>FALSE</b> otherwise.
    ///    pbInherit = Receives <b>TRUE</b> if the pinned state is inherited by new child items, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPinnedForFolderRedirection(int* pbPinnedForFolderRedirection, int* pbInherit);
}

///Defines a method to determine whether an item in the Offline Files cache is partly pinned.
@GUID("623C58A2-42ED-4AD7-B69A-0F1B30A72D0D")
interface IOfflineFilesPinInfo2 : IOfflineFilesPinInfo
{
    ///Determines whether the item is partly pinned.
    ///Params:
    ///    pbPartlyPinned = Receives <b>TRUE</b> if the item has some child content that is pinned in the Offline Files cache, or
    ///                     <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPartlyPinned(int* pbPartlyPinned);
}

///Represents information associated with transparently cached items.
@GUID("BCAF4A01-5B68-4B56-A6A1-8D2786EDE8E3")
interface IOfflineFilesTransparentCacheInfo : IUnknown
{
    ///Determines whether the item is transparently cached.
    ///Params:
    ///    pbTransparentlyCached = A pointer to a variable that receives <b>TRUE</b> if the item is transparently cached, or <b>FALSE</b>
    ///                            otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsTransparentlyCached(int* pbTransparentlyCached);
}

///Represents the ghosting status of an item in the Offline Files cache.
@GUID("2B09D48C-8AB5-464F-A755-A59D92F99429")
interface IOfflineFilesGhostInfo : IUnknown
{
    ///Determines whether the item is ghosted.
    ///Params:
    ///    pbGhosted = Receives <b>TRUE</b> if the item is ghosted, or <b>FALSE</b> otherwise.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsGhosted(int* pbGhosted);
}

///Presents query and action capabilities associated with the online-offline transition behavior of Offline Files.
@GUID("EFB23A09-A867-4BE8-83A6-86969A7D0856")
interface IOfflineFilesConnectionInfo : IUnknown
{
    ///Determines whether an item is online or offline and, if offline, why.
    ///Params:
    ///    pConnectState = Receives an OFFLINEFILES_CONNECT_STATE enumeration value that indicates whether the item is online or
    ///                    offline. <div class="alert"><b>Note</b> This value sets the Offline Status property value in Windows
    ///                    Explorer.</div> <div> </div>
    ///    pOfflineReason = If the item is offline, this parameter receives an OFFLINEFILES_OFFLINE_REASON enumeration value that
    ///                     indicates why the item is offline. <div class="alert"><b>Note</b> This value generates the parenthesized
    ///                     suffix in the Offline Status property value in Windows Explorer when the status is offline.</div> <div>
    ///                     </div>
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetConnectState(OFFLINEFILES_CONNECT_STATE* pConnectState, OFFLINEFILES_OFFLINE_REASON* pOfflineReason);
    ///Sets the connection state for an item. Note that the entire scope of the item is transitioned, not just the item.
    ///An item's scope is defined as the closest ancestor shared folder of the item.
    ///Params:
    ///    hwndParent = Provides a parent window handle used for any interactive user interface elements such as credential request
    ///                 dialogs. This parameter may be <b>NULL</b>. This parameter is ignored if the
    ///                 OFFLINEFILES_TRANSITION_FLAG_INTERACTIVE flag is not specified in the <i>dwFlags</i> parameter.
    ///    dwFlags = One or more of the following flag values:
    ///    ConnectState = Specify one of the following OFFLINEFILES_CONNECT_STATE enumeration values.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT SetConnectState(HWND hwndParent, uint dwFlags, OFFLINEFILES_CONNECT_STATE ConnectState);
    ///Transitions an item online if possible.
    ///Params:
    ///    hwndParent = Provides a parent window handle used for any interactive user interface elements such as credential request
    ///                 dialogs. This parameter may be <b>NULL</b>. This parameter is ignored if the
    ///                 OFFLINEFILES_TRANSITION_FLAG_INTERACTIVE flag is not specified in the <i>dwFlags</i> parameter.
    ///    dwFlags = One or more of the following flag values:
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT TransitionOnline(HWND hwndParent, uint dwFlags);
    ///Transitions an item offline if possible.
    ///Params:
    ///    hwndParent = Provides a parent window handle used for any interactive user interface elements such as credential request
    ///                 dialogs. This parameter may be <b>NULL</b>. This parameter is ignored if the
    ///                 <b>OFFLINEFILES_TRANSITION_FLAG_INTERACTIVE</b> flag is not set.
    ///    dwFlags = One or more of the following flag values:
    ///    bForceOpenFilesClosed = By default, any open handles to files that are not cached by Offline Files prevent the transition to offline.
    ///                            If this parameter is <b>TRUE</b>, the operation will forcibly close these files handles, allowing the scope
    ///                            to transition offline. <div class="alert"><b>Note</b> If file handles are forcibly closed, this can cause
    ///                            unexpected consequences, depending on the applications that are using those files.</div> <div> </div>
    ///    pbOpenFilesPreventedTransition = Receives <b>TRUE</b> if open files prevented the transition, or <b>FALSE</b> otherwise. This value is useful
    ///                                     only if <b>FALSE</b> was specified for the <i>bForceOpenFilesClosed</i> parameter.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT TransitionOffline(HWND hwndParent, uint dwFlags, BOOL bForceOpenFilesClosed, 
                              int* pbOpenFilesPreventedTransition);
}

///Presents share-specific information about cached items.
@GUID("7BCC43E7-31CE-4CA4-8CCD-1CFF2DC494DA")
interface IOfflineFilesShareInfo : IUnknown
{
    ///Finds the cache item representing the closest ancestor share to the item. In non-DFS scenarios this can be the
    ///\\server\share at the top of the namespace. In DFS scenarios this might be a cache directory entry that
    ///corresponds to a share in the DFS namespace.
    ///Params:
    ///    ppShareItem = Receives the address of the IOfflineFilesShareItem interface on the share item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetShareItem(IOfflineFilesShareItem* ppShareItem);
    ///Retrieves the caching mode configuration of the closest ancestor share to the item.
    ///Params:
    ///    pCachingMode = Receives a value from the OFFLINEFILES_CACHING_MODE enumeration that indicates the caching mode. The
    ///                   following values can be returned:
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetShareCachingMode(OFFLINEFILES_CACHING_MODE* pCachingMode);
    ///Determines whether the share item is a DFS junction or a shared folder on a server.
    ///Params:
    ///    pbIsDfsJunction = Receives <b>TRUE</b> if the item is a DFS junction, or <b>FALSE</b> if the share is a shared folder
    ///                      (\\server\share) on a server.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsShareDfsJunction(int* pbIsDfsJunction);
}

///Suspends or releases a share root or directory tree in the Offline Files cache. A suspended tree is always offline
///and is never synchronized automatically by the Offline Files service. It may, however, be synchronized by the user
///through Windows Explorer, through Sync Center, or by code calling the Offline Files API.
@GUID("62C4560F-BC0B-48CA-AD9D-34CB528D99A9")
interface IOfflineFilesSuspend : IUnknown
{
    ///Suspend or release a share root or directory tree. A suspended item is always in the offline state and is
    ///excluded from automatic synchronization by Offline Files.
    ///Params:
    ///    bSuspend = Specify <b>TRUE</b> to suspend, or <b>FALSE</b> to release.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT SuspendRoot(BOOL bSuspend);
}

///Determines whether an item is suspended or not and, if so, if it is a suspended root or not.
@GUID("A457C25B-4E9C-4B04-85AF-8932CCD97889")
interface IOfflineFilesSuspendInfo : IUnknown
{
    ///Determines whether an item is suspended. If an item is suspended and is a suspended root, it was suspended by
    ///using the IOfflineFilesSuspend::SuspendRoot method. If an item is suspended but is not a suspended root, its
    ///suspension was inherited from a suspended root.
    ///Params:
    ///    pbSuspended = Receives <b>TRUE</b> if the item is suspended, or <b>FALSE</b> otherwise.
    ///    pbSuspendedRoot = Receives <b>TRUE</b> if the item is a suspended root, or <b>FALSE</b> otherwise. If the item is not
    ///                      suspended, this value is always <b>FALSE</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsSuspended(int* pbSuspended, int* pbSuspendedRoot);
}

///Represents a setting that controls the behavior the Offline Files service.
@GUID("D871D3F7-F613-48A1-827E-7A34E560FFF6")
interface IOfflineFilesSetting : IUnknown
{
    ///Retrieves a name associated with a particular Offline Files setting.
    ///Params:
    ///    ppszName = Address of pointer variable that receives the address of a string containing the name of the Offline Files
    ///               setting. Upon successful return, the caller must free this memory block by using the CoTaskMemFree function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetName(ushort** ppszName);
    ///Retrieves the data type of a particular Offline Files setting.
    ///Params:
    ///    pType = Receives a value from the OFFLINEFILES_SETTING_VALUE_TYPE enumeration that describes the data type of the
    ///            setting value.
    ///Returns:
    ///    S_OK if the scope is returned successfully or an error value otherwise.
    ///    
    HRESULT GetValueType(OFFLINEFILES_SETTING_VALUE_TYPE* pType);
    ///Retrieves a per-machine or per-user preference associated with a particular Offline Files setting.
    ///Params:
    ///    pvarValue = If the preference supports one or more values, the returned VARIANT object contains those values. If the
    ///                preference does not support values, the type of the returned <b>VARIANT</b> is <b>VT_EMPTY</b>. The method
    ///                initializes the VARIANT prior to storing the preference value in it.
    ///    dwScope = Indicates which preference is to be retrieved. Must be one of the following.
    ///Returns:
    ///    <b>S_OK</b> if the preference query is successful or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the preference is currently not applied.
    ///    
    HRESULT GetPreference(VARIANT* pvarValue, uint dwScope);
    ///Indicates the scope of the preference associated with this setting.
    ///Params:
    ///    pdwScope = Receives the supported scope of the policy for this setting. This scope can be one or both of the following
    ///               values.
    ///Returns:
    ///    S_OK if the scope is returned successfully or an error value otherwise.
    ///    
    HRESULT GetPreferenceScope(uint* pdwScope);
    ///Sets a per-computer or per-user preference associated with an Offline Files setting.
    ///Params:
    ///    pvarValue = Specifies the value associated with the preference. If multiple values are associated with the preference,
    ///                the VARIANT type includes <b>VT_ARRAY</b> and the values are stored in a <b>SAFEARRAY</b>.
    ///    dwScope = Indicates if the preference to be set is per-user or per-machine. Must be one of the following.
    ///Returns:
    ///    <b>S_OK</b> if the preference is set successfully or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_INVALID_PARAMETER)</code> if one or more data values specified via
    ///    <i>pvtValue</i> are not valid. Returns <code>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED)</code> if the caller is
    ///    trying to set a per-machine preference and is not a local administrator. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</code> if a scope is specified that is not supported by the
    ///    preference.
    ///    
    HRESULT SetPreference(const(VARIANT)* pvarValue, uint dwScope);
    ///Removes a preference setting.
    ///Params:
    ///    dwScope = Indicates which preference setting is to be deleted. Must be one of the following.
    ///Returns:
    ///    <b>S_OK</b> if the preference is removed successfully or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the requested preference setting is not currently
    ///    configured. Returns <code>HRESULT_FROM_WIN32(ERROR_ACCESS_DENIED)</code> if the caller is trying to remove a
    ///    per-machine preference and is not a local administrator.
    ///    
    HRESULT DeletePreference(uint dwScope);
    ///Retrieves a policy associated with a particular Offline Files setting.
    ///Params:
    ///    pvarValue = If the policy supports one or more values, the returned VARIANT object contains those values. If the policy
    ///                does not support values, the type of the returned <b>VARIANT</b> is <b>VT_EMPTY</b>. The method initializes
    ///                the VARIANT prior to storing the policy value in it.
    ///    dwScope = Indicates which policy is to be retrieved. Must be one of the following. <div class="alert"><b>Note</b> Note
    ///              that not all settings have an associated policy and those that do might not support both per-machine and
    ///              per-user policy.</div> <div> </div>
    ///Returns:
    ///    <b>S_OK</b> if the policy is read successfully or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_NOT_SUPPORTED)</code> if the setting does not support the requested policy.
    ///    Returns <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the requested policy is not currently
    ///    applied.
    ///    
    HRESULT GetPolicy(VARIANT* pvarValue, uint dwScope);
    ///Retrieves the scope of the policy associated with this setting.
    ///Params:
    ///    pdwScope = Receives the supported scope of the policy for this setting. This scope can be one or both of the following
    ///               values.
    ///Returns:
    ///    S_OK if the scope is returned successfully or an error value otherwise.
    ///    
    HRESULT GetPolicyScope(uint* pdwScope);
    ///Retrieves the value of a particular Offline Files setting.
    ///Params:
    ///    pvarValue = Receives the value associated with the setting. This value is determined based on system policy, preferences
    ///                and system defaults. The method initializes the VARIANT prior to storing the setting value in it.
    ///    pbSetByPolicy = Receives <b>TRUE</b> if the value was set by policy, <b>FALSE</b> if the value was determined by preference
    ///                    or default.
    ///Returns:
    ///    <b>S_OK</b> if the value query is successful or an error value otherwise.
    ///    
    HRESULT GetValue(VARIANT* pvarValue, int* pbSetByPolicy);
}

///Enumerates setting objects associated with the Offline Files service.
@GUID("729680C4-1A38-47BC-9E5C-02C51562AC30")
interface IEnumOfflineFilesSettings : IUnknown
{
    ///Retrieves the next item in the enumeration and advances the enumerator.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of elements returned.
    ///    pceltFetched = Number of elements returned.
    ///Returns:
    ///    Returns <b>S_OK</b> if the number of elements returned is <i>celt</i>; S_FALSE if a number less than
    ///    <i>celt</i> is returned; or an error value otherwise.
    ///    
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    ///Skips over the next specified number of elements in the enumeration.
    ///Params:
    ///    celt = Number of elements to be skipped.
    ///Returns:
    ///    Returns <b>S_OK</b> if the number of elements skipped is <i>celt</i>; S_FALSE if a number less than
    ///    <i>celt</i> is skipped; or an error value otherwise.
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration to the beginning.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT Reset();
    ///Creates a new instance of the enumerator with the same enumeration state as the current one.
    ///Params:
    ///    ppenum = Address of an IEnumOfflineFilesSettings pointer variable that receives the interface pointer of the new
    ///             enumeration object.
    ///Returns:
    ///    Returns <b>S_OK</b> if the enumerator is created successfully, or an error value otherwise.
    ///    
    HRESULT Clone(IEnumOfflineFilesSettings* ppenum);
}

///Used to manage the Offline Files cache.
@GUID("855D6203-7914-48B9-8D40-4C56F5ACFFC5")
interface IOfflineFilesCache : IUnknown
{
    ///Synchronizes files and directories in the Offline Files cache with their corresponding copies in the applicable
    ///network shared folders.
    ///Params:
    ///    hwndParent = Identifies the parent window for any user interface elements displayed. This parameter is ignored if the
    ///                 <b>OFFLINEFILES_SYNC_CONTROL_FLAG_INTERACTIVE</b> flag is not set in the <i>dwSyncControl</i> parameter.
    ///    rgpszPaths = Array of pointers, each to a fully qualified UNC path of a file or directory to be synchronized.
    ///    cPaths = Number of paths in the <i>rgpszPaths</i> array.
    ///    bAsync = Indicates if the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the operation
    ///             is placed on a separate thread in the system thread pool and the function returns immediately. If this
    ///             parameter is <b>FALSE</b>, the function returns when the operation is complete.
    ///    dwSyncControl = Flags to control the behavior of the entire sync operation. Behaviors such as sync direction (in, out), the
    ///                    pinning of LNK targets, as well as the pinning of new files are controlled through these flags. The following
    ///                    list describes the meaning of each flag.
    ///    pISyncConflictHandler = An IOfflineFilesSyncConflictHandler interface pointer to a conflict handler implementation. If provided, the
    ///                            sync operation calls the conflict handler to resolve sync conflicts as they are encountered during the
    ///                            operation. The handler receives a code describing the type of conflict then returns a code indicating if the
    ///                            conflict has been resolved or some other action to be taken by the sync operation. This parameter is optional
    ///                            and can be <b>NULL</b>. If this parameter is <b>NULL</b>, the default action is taken in the Offline Files
    ///                            service. Normally this results in the conflict being recorded in the user's sync conflict store for later
    ///                            presentation in Sync Center.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. This parameter is optional
    ///                 and can be <b>NULL</b>.
    ///    pSyncId = A unique ID applied to this sync operation. This ID will be included with all published events
    ///              (IOfflineFilesEvents) related to this operation. This parameter is optional and can be <b>NULL</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled. Monitor
    ///    IOfflineFilesSyncProgress events to detect failures associated with individual files.
    ///    
    HRESULT Synchronize(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bAsync, uint dwSyncControl, 
                        IOfflineFilesSyncConflictHandler pISyncConflictHandler, IOfflineFilesSyncProgress pIProgress, 
                        GUID* pSyncId);
    ///Deletes files and directories from the local cache. Deleting a container item implies deletion of all its
    ///contained items, recursively.
    ///Params:
    ///    rgpszPaths = Array of pointers, each to a fully qualified UNC path of a file or directory to be deleted.
    ///    cPaths = Number of paths in the <i>rgpszPaths</i> array.
    ///    dwFlags = Flags controlling the behavior of the delete operation. This parameter can be one or more of the following
    ///              values.
    ///    bAsync = Indicates if the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the operation
    ///             is scheduled for asynchronous operation and the function returns immediately. If this parameter is
    ///             <b>FALSE</b>, the function returns when the operation is complete.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. If events are not desired,
    ///                 this parameter may be <b>NULL</b>. Providing an event sink is highly recommended for asynchronous operation.
    ///                 A progress implementation is the only way to be notified when the asynchronous operation completes.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled. Returns
    ///    HRESULT_FROM_WIN32(ERROR_MORE_DATA) if errors occurred during the operation. Use the
    ///    IOfflineFilesSimpleProgress::ItemResult callback method to detect errors as they occur.
    ///    
    HRESULT DeleteItems(char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, 
                        IOfflineFilesSimpleProgress pIProgress);
    ///Deletes a user's files and directories from the local cache. Deleting a container item implies deletion of all
    ///its contained items, recursively.
    ///Params:
    ///    pszUser = Text string identifying the user for which the files are to be deleted for. This option is available only to
    ///              administrators on the local computer. The text string may be the user's SID in string format or the user's
    ///              <i>domain\user</i> logon name string.
    ///    rgpszPaths = Array of pointers, each to a fully qualified UNC path of a file or directory to be deleted.
    ///    cPaths = Number of paths in <i>rgpszPaths</i>.
    ///    dwFlags = Flags controlling the behavior of the delete operation. This parameter can be one or more of the following
    ///              values.
    ///    bAsync = Indicates whether the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the
    ///             operation is scheduled for asynchronous operation and the function returns immediately. If this parameter is
    ///             <b>FALSE</b>, the function returns when the operation is complete.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. If events are not desired,
    ///                 this parameter can be <b>NULL</b>. Providing an event sink is highly recommended for asynchronous operation.
    ///                 A progress implementation is the only way to be notified when the asynchronous operation completes.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_MORE_DATA)</code> if errors occurred during the operation. Use the
    ///    IOfflineFilesSimpleProgress::ItemResult callback method to detect errors as they occur.
    ///    
    HRESULT DeleteItemsForUser(const(wchar)* pszUser, char* rgpszPaths, uint cPaths, uint dwFlags, BOOL bAsync, 
                               IOfflineFilesSimpleProgress pIProgress);
    ///Pins files, directories, and network shared folders. Pinning is called "Always Available Offline" in the Windows
    ///user interface. When a file is pinned, it is cached in the local Offline Files store. Unlike files that are
    ///automatically cached, pinned files are protected from automatic eviction when additional cache space is needed.
    ///Params:
    ///    hwndParent = Identifies the parent window for any user interface elements displayed. This parameter is ignored if the
    ///                 <b>OFFLINEFILES_PIN_CONTROL_FLAG_INTERACTIVE</b> flag is not set in the <i>dwPinControlFlags</i> parameter.
    ///    rgpszPaths = Array of pointers, each to a fully qualified UNC path of a file or directory to be pinned.
    ///    cPaths = Number of paths in <i>rgpszPaths</i>.
    ///    bDeep = If one or more of the paths provided refers to a directory or shared folder, this argument indicates whether
    ///            all children (files and subdirectories) are to be pinned as well. If this parameter is <b>TRUE</b>, all
    ///            children are pinned recursively. If this parameter is <b>FALSE</b>, only the directory itself is pinned, not
    ///            its children. When the next synchronization operation occurs, all children are pinned recursively.
    ///    bAsync = Indicates if the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the operation
    ///             is scheduled for asynchronous operation and the function returns immediately. If this parameter is
    ///             <b>FALSE</b>, the function returns when the operation is complete.
    ///    dwPinControlFlags = Controls behavior of the pin operation. May be one or more of the following flags.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. If events are not desired,
    ///                 this parameter may be <b>NULL</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled.
    ///    
    HRESULT Pin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, 
                IOfflineFilesSyncProgress pIProgress);
    ///Unpins files, directories, and network shared folders from the Offline Files cache. Pinning is called "Always
    ///Available Offline" in the Windows user interface. When a file is unpinned, it is no longer guaranteed to be
    ///available offline. If the unpin operation removes all instances of pin information in that it is not pinned by
    ///Folder Redirection, Group Policy, or by the user and that item has no unsynchronized offline changes, it may be
    ///automatically removed from the cache at any time.
    ///Params:
    ///    hwndParent = Identifies the parent window for any user interface elements displayed. This parameter is ignored if the
    ///                 <b>OFFLINEFILES_PIN_CONTROL_FLAG_INTERACTIVE</b> flag is not set in the <i>dwPinControlFlags</i> parameter.
    ///    rgpszPaths = Array of pointers, each to a fully qualified UNC path of a file or directory to be unpinned.
    ///    cPaths = Number of paths in the <i>rgpszPaths</i> array.
    ///    bDeep = If one or more of the paths provided refers to a directory or shared folder, this argument indicates whether
    ///            all subdirectories are to be unpinned as well. If this parameter is <b>TRUE</b>, all subdirectories are
    ///            unpinned recursively. If this parameter is <b>FALSE</b>, only files that are immediate children of the
    ///            directory are unpinned.
    ///    bAsync = Indicates if the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the operation
    ///             is scheduled for asynchronous operation and the function returns immediately. If this parameter is
    ///             <b>FALSE</b>, the function returns when the operation is complete.
    ///    dwPinControlFlags = Controls the behavior of the unpin operation. May be one or more of the following flags.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. If events are not desired,
    ///                 this parameter may be <b>NULL</b>.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled.
    ///    
    HRESULT Unpin(HWND hwndParent, char* rgpszPaths, uint cPaths, BOOL bDeep, BOOL bAsync, uint dwPinControlFlags, 
                  IOfflineFilesSyncProgress pIProgress);
    ///Retrieves the current encryption state (encrypted or unencrypted) of the Offline Files cache.
    ///Params:
    ///    pbEncrypted = Receives <b>TRUE</b> if the Offline Files cache is configured to be encrypted; <b>FALSE</b> if configured to
    ///                  be unencrypted.
    ///    pbPartial = Receives <b>TRUE</b> if the Offline Files cache is partially encrypted or partially unencrypted based on the
    ///                value returned in <i>pbEncrypted</i>; <b>FALSE</b> if it is fully encrypted or unencrypted.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetEncryptionStatus(int* pbEncrypted, int* pbPartial);
    ///Encrypts or unencrypts the contents of the Offline Files cache cached for the calling user. When the cache is
    ///encrypted, all files subsequently cached are automatically encrypted. When the cache is unencrypted, all files
    ///subsequently cached are cached unencrypted. Existing files in the cache are either encrypted or unencrypted to
    ///match the new state of the cache.
    ///Params:
    ///    hwndParent = Identifies the parent window for any user interface elements displayed. This parameter is ignored if the
    ///                 <b>OFFLINEFILES_ENCRYPTION_CONTROL_FLAG_INTERACTIVE</b> flag is not set in the
    ///                 <i>dwEncryptionControlFlags</i> parameter.
    ///    bEncrypt = <b>TRUE</b> to encrypt, <b>FALSE</b> to unencrypt.
    ///    dwEncryptionControlFlags = This parameter can be one or more of the following values.
    ///    bAsync = Indicates whether the operation is to be performed asynchronously. If this parameter is <b>TRUE</b>, the
    ///             operation is scheduled for asynchronous operation and the function returns immediately. If this parameter is
    ///             <b>FALSE</b>, the function returns when the operation is complete.
    ///    pIProgress = Interface to an event sink that will receive progress events during the operation. If events are not desired,
    ///                 this parameter may be <b>NULL</b>. Note that this parameter is highly recommended for asynchronous operation.
    ///                 A progress implementation is the only way to be notified when the asynchronous operation completes.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_CANCELLED)</code> if the operation is canceled.
    ///    
    HRESULT Encrypt(HWND hwndParent, BOOL bEncrypt, uint dwEncryptionControlFlags, BOOL bAsync, 
                    IOfflineFilesSyncProgress pIProgress);
    ///Locates a particular file or directory item in the cache.
    ///Params:
    ///    pszPath = UNC path of the file or directory to be located.
    ///    dwQueryFlags = Flags affecting the amount of query activity at the time the item is located in the cache. The parameter may
    ///                   contain one or more of the following bit flags.
    ///    ppItem = Pointer to the IOfflineFilesItem interface of the cache item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the cache entry is not found.
    ///    
    HRESULT FindItem(const(wchar)* pszPath, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    ///Locates a particular file or directory item in the cache.
    ///Params:
    ///    pszPath = UNC path of the file or directory to be located.
    ///    pIncludeFileFilter = If provided, references the filter applied to the decision to include files. This parameter is optional and
    ///                         can be <b>NULL</b>.
    ///    pIncludeDirFilter = If provided, references the filter applied to the decision to include directories. This parameter is optional
    ///                        and can be <b>NULL</b>.
    ///    pExcludeFileFilter = If provided, references the filter applied to the decision to exclude files. This parameter is optional and
    ///                         can be <b>NULL</b>.
    ///    pExcludeDirFilter = If provided, references the "filter" applied to the decision to exclude directories. This parameter is
    ///                        optional and may be <b>NULL</b>.
    ///    dwQueryFlags = Flags affecting the amount of query activity at the time the item is located in the cache. The parameter can
    ///                   contain one or more of the following bit flags.
    ///    ppItem = Pointer to the IOfflineFilesItem interface of the cache item.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</code> if the cache entry is not found.
    ///    
    HRESULT FindItemEx(const(wchar)* pszPath, IOfflineFilesItemFilter pIncludeFileFilter, 
                       IOfflineFilesItemFilter pIncludeDirFilter, IOfflineFilesItemFilter pExcludeFileFilter, 
                       IOfflineFilesItemFilter pExcludeDirFilter, uint dwQueryFlags, IOfflineFilesItem* ppItem);
    ///Renames an item in the cache. This method logs a request with the Offline Files service for a path to be renamed
    ///on the next system restart.
    ///Params:
    ///    pszPathOriginal = Fully qualified UNC path of the item (server, share, file or directory) to be renamed.
    ///    pszPathNew = The new path to replace <i>pszPathOriginal</i> if the item that <i>pszPathOriginal</i> points to exists in
    ///                 the cache.
    ///    bReplaceIfExists = This parameter is reserved for future use.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT RenameItem(const(wchar)* pszPathOriginal, const(wchar)* pszPathNew, BOOL bReplaceIfExists);
    ///Retrieves the current fully qualified directory path of the Offline Files cache.
    ///Params:
    ///    ppszPath = Address of pointer variable to accept the address of a string containing the fully qualified path of the
    ///               Offline Files cache directory. Upon successful return, the caller is expected to free the returned buffer by
    ///               using the CoTaskMemFree function.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT GetLocation(ushort** ppszPath);
    HRESULT GetDiskSpaceInformationA(ulong* pcbVolumeTotal, ulong* pcbLimit, ulong* pcbUsed, 
                                     ulong* pcbUnpinnedLimit, ulong* pcbUnpinnedUsed);
    ///Sets disk space usage limits on the Offline Files cache.
    ///Params:
    ///    cbLimit = Specifies the limit on the maximum amount of bytes that can be stored in the Offline Files cache.
    ///    cbUnpinnedLimit = Specifies the limit on the maximum amount of bytes that can be stored in the Offline Files cache for
    ///                      automatically cached files.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT SetDiskSpaceLimits(ulong cbLimit, ulong cbUnpinnedLimit);
    ///Causes Offline Files to process the "administratively assigned offline files" group policy.
    ///Params:
    ///    pPinProgress = Pointer to the IOfflineFilesSyncProgress interface that receives progress notifications as items are being
    ///                   pinned in the Offline Files cache.
    ///    pUnpinProgress = Pointer to the IOfflineFilesSyncProgress interface that receives progress notifications as items are being
    ///                     unpinned from the Offline Files cache.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT ProcessAdminPinPolicy(IOfflineFilesSyncProgress pPinProgress, IOfflineFilesSyncProgress pUnpinProgress);
    ///Creates an object that represents a particular Offline Files setting.
    ///Params:
    ///    pszSettingName = Case-insensitive name of the setting. One of the following values:
    ///    ppSetting = If the setting exists, a pointer to the object's IOfflineFilesSetting interface is returned.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise. Returns
    ///    <code>HRESULT_FROM_WIN32(ERROR_INVALID_NAME)</code> if the setting name is invalid.
    ///    
    HRESULT GetSettingObject(const(wchar)* pszSettingName, IOfflineFilesSetting* ppSetting);
    ///Creates an enumerator of instances of IOfflineFilesSetting. This allows the caller to enumerate all of the
    ///available settings that affect the behavior of Offline Files.
    ///Params:
    ///    ppEnum = On success, receives the address of an instance of IEnumOfflineFilesSettings.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT EnumSettingObjects(IEnumOfflineFilesSettings* ppEnum);
    ///Determines whether a specified UNC path is in the Offline Files cache.
    ///Params:
    ///    pszPath = The UNC path of the item.
    ///    pbCacheable = Receives <b>TRUE</b> if the item is in the Offline Files cache, <b>FALSE</b> if not.
    ///    pShareCachingMode = Receives one of the following OFFLINEFILES_CACHING_MODE enumeration values indicating the caching
    ///                        configuration of the applicable network shared folder under which the specified item exists.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
    HRESULT IsPathCacheable(const(wchar)* pszPath, int* pbCacheable, OFFLINEFILES_CACHING_MODE* pShareCachingMode);
}

///Implements the RenameItemEx method.
@GUID("8C075039-1551-4ED9-8781-56705C04D3C0")
interface IOfflineFilesCache2 : IOfflineFilesCache
{
    ///Renames an item in the cache. This method is identical to the IOfflineFilesCache::RenameItem method, except that
    ///it will attempt to do the rename operation right away.
    ///Params:
    ///    pszPathOriginal = Fully qualified UNC path of the item (server, share, file or directory) to be renamed.
    ///    pszPathNew = The new path to replace <i>pszPathOriginal</i> if the item that <i>pszPathOriginal</i> points to exists in
    ///                 the cache.
    ///    bReplaceIfExists = This parameter is reserved for future use.
    ///Returns:
    ///    Returns <b>S_OK</b> if successful, or an error value otherwise.
    ///    
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
