module windows.windowseventlog;

public import windows.systemservices;

extern(Windows):

enum EVT_VARIANT_TYPE
{
    EvtVarTypeNull = 0,
    EvtVarTypeString = 1,
    EvtVarTypeAnsiString = 2,
    EvtVarTypeSByte = 3,
    EvtVarTypeByte = 4,
    EvtVarTypeInt16 = 5,
    EvtVarTypeUInt16 = 6,
    EvtVarTypeInt32 = 7,
    EvtVarTypeUInt32 = 8,
    EvtVarTypeInt64 = 9,
    EvtVarTypeUInt64 = 10,
    EvtVarTypeSingle = 11,
    EvtVarTypeDouble = 12,
    EvtVarTypeBoolean = 13,
    EvtVarTypeBinary = 14,
    EvtVarTypeGuid = 15,
    EvtVarTypeSizeT = 16,
    EvtVarTypeFileTime = 17,
    EvtVarTypeSysTime = 18,
    EvtVarTypeSid = 19,
    EvtVarTypeHexInt32 = 20,
    EvtVarTypeHexInt64 = 21,
    EvtVarTypeEvtHandle = 32,
    EvtVarTypeEvtXml = 35,
}

struct EVT_VARIANT
{
    _Anonymous_e__Union Anonymous;
    uint Count;
    uint Type;
}

enum EVT_LOGIN_CLASS
{
    EvtRpcLogin = 1,
}

enum EVT_RPC_LOGIN_FLAGS
{
    EvtRpcLoginAuthDefault = 0,
    EvtRpcLoginAuthNegotiate = 1,
    EvtRpcLoginAuthKerberos = 2,
    EvtRpcLoginAuthNTLM = 3,
}

struct EVT_RPC_LOGIN
{
    const(wchar)* Server;
    const(wchar)* User;
    const(wchar)* Domain;
    const(wchar)* Password;
    uint Flags;
}

enum EVT_QUERY_FLAGS
{
    EvtQueryChannelPath = 1,
    EvtQueryFilePath = 2,
    EvtQueryForwardDirection = 256,
    EvtQueryReverseDirection = 512,
    EvtQueryTolerateQueryErrors = 4096,
}

enum EVT_SEEK_FLAGS
{
    EvtSeekRelativeToFirst = 1,
    EvtSeekRelativeToLast = 2,
    EvtSeekRelativeToCurrent = 3,
    EvtSeekRelativeToBookmark = 4,
    EvtSeekOriginMask = 7,
    EvtSeekStrict = 65536,
}

enum EVT_SUBSCRIBE_FLAGS
{
    EvtSubscribeToFutureEvents = 1,
    EvtSubscribeStartAtOldestRecord = 2,
    EvtSubscribeStartAfterBookmark = 3,
    EvtSubscribeOriginMask = 3,
    EvtSubscribeTolerateQueryErrors = 4096,
    EvtSubscribeStrict = 65536,
}

enum EVT_SUBSCRIBE_NOTIFY_ACTION
{
    EvtSubscribeActionError = 0,
    EvtSubscribeActionDeliver = 1,
}

alias EVT_SUBSCRIBE_CALLBACK = extern(Windows) uint function(EVT_SUBSCRIBE_NOTIFY_ACTION Action, void* UserContext, int Event);
enum EVT_SYSTEM_PROPERTY_ID
{
    EvtSystemProviderName = 0,
    EvtSystemProviderGuid = 1,
    EvtSystemEventID = 2,
    EvtSystemQualifiers = 3,
    EvtSystemLevel = 4,
    EvtSystemTask = 5,
    EvtSystemOpcode = 6,
    EvtSystemKeywords = 7,
    EvtSystemTimeCreated = 8,
    EvtSystemEventRecordId = 9,
    EvtSystemActivityID = 10,
    EvtSystemRelatedActivityID = 11,
    EvtSystemProcessID = 12,
    EvtSystemThreadID = 13,
    EvtSystemChannel = 14,
    EvtSystemComputer = 15,
    EvtSystemUserID = 16,
    EvtSystemVersion = 17,
    EvtSystemPropertyIdEND = 18,
}

enum EVT_RENDER_CONTEXT_FLAGS
{
    EvtRenderContextValues = 0,
    EvtRenderContextSystem = 1,
    EvtRenderContextUser = 2,
}

enum EVT_RENDER_FLAGS
{
    EvtRenderEventValues = 0,
    EvtRenderEventXml = 1,
    EvtRenderBookmark = 2,
}

enum EVT_FORMAT_MESSAGE_FLAGS
{
    EvtFormatMessageEvent = 1,
    EvtFormatMessageLevel = 2,
    EvtFormatMessageTask = 3,
    EvtFormatMessageOpcode = 4,
    EvtFormatMessageKeyword = 5,
    EvtFormatMessageChannel = 6,
    EvtFormatMessageProvider = 7,
    EvtFormatMessageId = 8,
    EvtFormatMessageXml = 9,
}

enum EVT_OPEN_LOG_FLAGS
{
    EvtOpenChannelPath = 1,
    EvtOpenFilePath = 2,
}

enum EVT_LOG_PROPERTY_ID
{
    EvtLogCreationTime = 0,
    EvtLogLastAccessTime = 1,
    EvtLogLastWriteTime = 2,
    EvtLogFileSize = 3,
    EvtLogAttributes = 4,
    EvtLogNumberOfLogRecords = 5,
    EvtLogOldestRecordNumber = 6,
    EvtLogFull = 7,
}

enum EVT_EXPORTLOG_FLAGS
{
    EvtExportLogChannelPath = 1,
    EvtExportLogFilePath = 2,
    EvtExportLogTolerateQueryErrors = 4096,
    EvtExportLogOverwrite = 8192,
}

enum EVT_CHANNEL_CONFIG_PROPERTY_ID
{
    EvtChannelConfigEnabled = 0,
    EvtChannelConfigIsolation = 1,
    EvtChannelConfigType = 2,
    EvtChannelConfigOwningPublisher = 3,
    EvtChannelConfigClassicEventlog = 4,
    EvtChannelConfigAccess = 5,
    EvtChannelLoggingConfigRetention = 6,
    EvtChannelLoggingConfigAutoBackup = 7,
    EvtChannelLoggingConfigMaxSize = 8,
    EvtChannelLoggingConfigLogFilePath = 9,
    EvtChannelPublishingConfigLevel = 10,
    EvtChannelPublishingConfigKeywords = 11,
    EvtChannelPublishingConfigControlGuid = 12,
    EvtChannelPublishingConfigBufferSize = 13,
    EvtChannelPublishingConfigMinBuffers = 14,
    EvtChannelPublishingConfigMaxBuffers = 15,
    EvtChannelPublishingConfigLatency = 16,
    EvtChannelPublishingConfigClockType = 17,
    EvtChannelPublishingConfigSidType = 18,
    EvtChannelPublisherList = 19,
    EvtChannelPublishingConfigFileMax = 20,
    EvtChannelConfigPropertyIdEND = 21,
}

enum EVT_CHANNEL_TYPE
{
    EvtChannelTypeAdmin = 0,
    EvtChannelTypeOperational = 1,
    EvtChannelTypeAnalytic = 2,
    EvtChannelTypeDebug = 3,
}

enum EVT_CHANNEL_ISOLATION_TYPE
{
    EvtChannelIsolationTypeApplication = 0,
    EvtChannelIsolationTypeSystem = 1,
    EvtChannelIsolationTypeCustom = 2,
}

enum EVT_CHANNEL_CLOCK_TYPE
{
    EvtChannelClockTypeSystemTime = 0,
    EvtChannelClockTypeQPC = 1,
}

enum EVT_CHANNEL_SID_TYPE
{
    EvtChannelSidTypeNone = 0,
    EvtChannelSidTypePublishing = 1,
}

enum EVT_CHANNEL_REFERENCE_FLAGS
{
    EvtChannelReferenceImported = 1,
}

enum EVT_PUBLISHER_METADATA_PROPERTY_ID
{
    EvtPublisherMetadataPublisherGuid = 0,
    EvtPublisherMetadataResourceFilePath = 1,
    EvtPublisherMetadataParameterFilePath = 2,
    EvtPublisherMetadataMessageFilePath = 3,
    EvtPublisherMetadataHelpLink = 4,
    EvtPublisherMetadataPublisherMessageID = 5,
    EvtPublisherMetadataChannelReferences = 6,
    EvtPublisherMetadataChannelReferencePath = 7,
    EvtPublisherMetadataChannelReferenceIndex = 8,
    EvtPublisherMetadataChannelReferenceID = 9,
    EvtPublisherMetadataChannelReferenceFlags = 10,
    EvtPublisherMetadataChannelReferenceMessageID = 11,
    EvtPublisherMetadataLevels = 12,
    EvtPublisherMetadataLevelName = 13,
    EvtPublisherMetadataLevelValue = 14,
    EvtPublisherMetadataLevelMessageID = 15,
    EvtPublisherMetadataTasks = 16,
    EvtPublisherMetadataTaskName = 17,
    EvtPublisherMetadataTaskEventGuid = 18,
    EvtPublisherMetadataTaskValue = 19,
    EvtPublisherMetadataTaskMessageID = 20,
    EvtPublisherMetadataOpcodes = 21,
    EvtPublisherMetadataOpcodeName = 22,
    EvtPublisherMetadataOpcodeValue = 23,
    EvtPublisherMetadataOpcodeMessageID = 24,
    EvtPublisherMetadataKeywords = 25,
    EvtPublisherMetadataKeywordName = 26,
    EvtPublisherMetadataKeywordValue = 27,
    EvtPublisherMetadataKeywordMessageID = 28,
    EvtPublisherMetadataPropertyIdEND = 29,
}

enum EVT_EVENT_METADATA_PROPERTY_ID
{
    EventMetadataEventID = 0,
    EventMetadataEventVersion = 1,
    EventMetadataEventChannel = 2,
    EventMetadataEventLevel = 3,
    EventMetadataEventOpcode = 4,
    EventMetadataEventTask = 5,
    EventMetadataEventKeyword = 6,
    EventMetadataEventMessageID = 7,
    EventMetadataEventTemplate = 8,
    EvtEventMetadataPropertyIdEND = 9,
}

enum EVT_QUERY_PROPERTY_ID
{
    EvtQueryNames = 0,
    EvtQueryStatuses = 1,
    EvtQueryPropertyIdEND = 2,
}

enum EVT_EVENT_PROPERTY_ID
{
    EvtEventQueryIDs = 0,
    EvtEventPath = 1,
    EvtEventPropertyIdEND = 2,
}

@DllImport("wevtapi.dll")
int EvtOpenSession(EVT_LOGIN_CLASS LoginClass, char* Login, uint Timeout, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtClose(int Object);

@DllImport("wevtapi.dll")
BOOL EvtCancel(int Object);

@DllImport("wevtapi.dll")
uint EvtGetExtendedStatus(uint BufferSize, const(wchar)* Buffer, uint* BufferUsed);

@DllImport("wevtapi.dll")
int EvtQuery(int Session, const(wchar)* Path, const(wchar)* Query, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtNext(int ResultSet, uint EventsSize, char* Events, uint Timeout, uint Flags, uint* Returned);

@DllImport("wevtapi.dll")
BOOL EvtSeek(int ResultSet, long Position, int Bookmark, uint Timeout, uint Flags);

@DllImport("wevtapi.dll")
int EvtSubscribe(int Session, HANDLE SignalEvent, const(wchar)* ChannelPath, const(wchar)* Query, int Bookmark, void* Context, EVT_SUBSCRIBE_CALLBACK Callback, uint Flags);

@DllImport("wevtapi.dll")
int EvtCreateRenderContext(uint ValuePathsCount, char* ValuePaths, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtRender(int Context, int Fragment, uint Flags, uint BufferSize, char* Buffer, uint* BufferUsed, uint* PropertyCount);

@DllImport("wevtapi.dll")
BOOL EvtFormatMessage(int PublisherMetadata, int Event, uint MessageId, uint ValueCount, char* Values, uint Flags, uint BufferSize, const(wchar)* Buffer, uint* BufferUsed);

@DllImport("wevtapi.dll")
int EvtOpenLog(int Session, const(wchar)* Path, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtGetLogInfo(int Log, EVT_LOG_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi.dll")
BOOL EvtClearLog(int Session, const(wchar)* ChannelPath, const(wchar)* TargetFilePath, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtExportLog(int Session, const(wchar)* Path, const(wchar)* Query, const(wchar)* TargetFilePath, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtArchiveExportedLog(int Session, const(wchar)* LogFilePath, uint Locale, uint Flags);

@DllImport("wevtapi.dll")
int EvtOpenChannelEnum(int Session, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtNextChannelPath(int ChannelEnum, uint ChannelPathBufferSize, const(wchar)* ChannelPathBuffer, uint* ChannelPathBufferUsed);

@DllImport("wevtapi.dll")
int EvtOpenChannelConfig(int Session, const(wchar)* ChannelPath, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtSaveChannelConfig(int ChannelConfig, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtSetChannelConfigProperty(int ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, EVT_VARIANT* PropertyValue);

@DllImport("wevtapi.dll")
BOOL EvtGetChannelConfigProperty(int ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, uint PropertyValueBufferSize, char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi.dll")
int EvtOpenPublisherEnum(int Session, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtNextPublisherId(int PublisherEnum, uint PublisherIdBufferSize, const(wchar)* PublisherIdBuffer, uint* PublisherIdBufferUsed);

@DllImport("wevtapi.dll")
int EvtOpenPublisherMetadata(int Session, const(wchar)* PublisherId, const(wchar)* LogFilePath, uint Locale, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtGetPublisherMetadataProperty(int PublisherMetadata, EVT_PUBLISHER_METADATA_PROPERTY_ID PropertyId, uint Flags, uint PublisherMetadataPropertyBufferSize, char* PublisherMetadataPropertyBuffer, uint* PublisherMetadataPropertyBufferUsed);

@DllImport("wevtapi.dll")
int EvtOpenEventMetadataEnum(int PublisherMetadata, uint Flags);

@DllImport("wevtapi.dll")
int EvtNextEventMetadata(int EventMetadataEnum, uint Flags);

@DllImport("wevtapi.dll")
BOOL EvtGetEventMetadataProperty(int EventMetadata, EVT_EVENT_METADATA_PROPERTY_ID PropertyId, uint Flags, uint EventMetadataPropertyBufferSize, char* EventMetadataPropertyBuffer, uint* EventMetadataPropertyBufferUsed);

@DllImport("wevtapi.dll")
BOOL EvtGetObjectArraySize(int ObjectArray, uint* ObjectArraySize);

@DllImport("wevtapi.dll")
BOOL EvtGetObjectArrayProperty(int ObjectArray, uint PropertyId, uint ArrayIndex, uint Flags, uint PropertyValueBufferSize, char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi.dll")
BOOL EvtGetQueryInfo(int QueryOrSubscription, EVT_QUERY_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi.dll")
int EvtCreateBookmark(const(wchar)* BookmarkXml);

@DllImport("wevtapi.dll")
BOOL EvtUpdateBookmark(int Bookmark, int Event);

@DllImport("wevtapi.dll")
BOOL EvtGetEventInfo(int Event, EVT_EVENT_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

