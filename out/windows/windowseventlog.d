module windows.windowseventlog;

public import windows.core;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    EvtVarTypeNull       = 0x00000000,
    EvtVarTypeString     = 0x00000001,
    EvtVarTypeAnsiString = 0x00000002,
    EvtVarTypeSByte      = 0x00000003,
    EvtVarTypeByte       = 0x00000004,
    EvtVarTypeInt16      = 0x00000005,
    EvtVarTypeUInt16     = 0x00000006,
    EvtVarTypeInt32      = 0x00000007,
    EvtVarTypeUInt32     = 0x00000008,
    EvtVarTypeInt64      = 0x00000009,
    EvtVarTypeUInt64     = 0x0000000a,
    EvtVarTypeSingle     = 0x0000000b,
    EvtVarTypeDouble     = 0x0000000c,
    EvtVarTypeBoolean    = 0x0000000d,
    EvtVarTypeBinary     = 0x0000000e,
    EvtVarTypeGuid       = 0x0000000f,
    EvtVarTypeSizeT      = 0x00000010,
    EvtVarTypeFileTime   = 0x00000011,
    EvtVarTypeSysTime    = 0x00000012,
    EvtVarTypeSid        = 0x00000013,
    EvtVarTypeHexInt32   = 0x00000014,
    EvtVarTypeHexInt64   = 0x00000015,
    EvtVarTypeEvtHandle  = 0x00000020,
    EvtVarTypeEvtXml     = 0x00000023,
}
alias EVT_VARIANT_TYPE = int;

enum : int
{
    EvtRpcLogin = 0x00000001,
}
alias EVT_LOGIN_CLASS = int;

enum : int
{
    EvtRpcLoginAuthDefault   = 0x00000000,
    EvtRpcLoginAuthNegotiate = 0x00000001,
    EvtRpcLoginAuthKerberos  = 0x00000002,
    EvtRpcLoginAuthNTLM      = 0x00000003,
}
alias EVT_RPC_LOGIN_FLAGS = int;

enum : int
{
    EvtQueryChannelPath         = 0x00000001,
    EvtQueryFilePath            = 0x00000002,
    EvtQueryForwardDirection    = 0x00000100,
    EvtQueryReverseDirection    = 0x00000200,
    EvtQueryTolerateQueryErrors = 0x00001000,
}
alias EVT_QUERY_FLAGS = int;

enum : int
{
    EvtSeekRelativeToFirst    = 0x00000001,
    EvtSeekRelativeToLast     = 0x00000002,
    EvtSeekRelativeToCurrent  = 0x00000003,
    EvtSeekRelativeToBookmark = 0x00000004,
    EvtSeekOriginMask         = 0x00000007,
    EvtSeekStrict             = 0x00010000,
}
alias EVT_SEEK_FLAGS = int;

enum : int
{
    EvtSubscribeToFutureEvents      = 0x00000001,
    EvtSubscribeStartAtOldestRecord = 0x00000002,
    EvtSubscribeStartAfterBookmark  = 0x00000003,
    EvtSubscribeOriginMask          = 0x00000003,
    EvtSubscribeTolerateQueryErrors = 0x00001000,
    EvtSubscribeStrict              = 0x00010000,
}
alias EVT_SUBSCRIBE_FLAGS = int;

enum : int
{
    EvtSubscribeActionError   = 0x00000000,
    EvtSubscribeActionDeliver = 0x00000001,
}
alias EVT_SUBSCRIBE_NOTIFY_ACTION = int;

enum : int
{
    EvtSystemProviderName      = 0x00000000,
    EvtSystemProviderGuid      = 0x00000001,
    EvtSystemEventID           = 0x00000002,
    EvtSystemQualifiers        = 0x00000003,
    EvtSystemLevel             = 0x00000004,
    EvtSystemTask              = 0x00000005,
    EvtSystemOpcode            = 0x00000006,
    EvtSystemKeywords          = 0x00000007,
    EvtSystemTimeCreated       = 0x00000008,
    EvtSystemEventRecordId     = 0x00000009,
    EvtSystemActivityID        = 0x0000000a,
    EvtSystemRelatedActivityID = 0x0000000b,
    EvtSystemProcessID         = 0x0000000c,
    EvtSystemThreadID          = 0x0000000d,
    EvtSystemChannel           = 0x0000000e,
    EvtSystemComputer          = 0x0000000f,
    EvtSystemUserID            = 0x00000010,
    EvtSystemVersion           = 0x00000011,
    EvtSystemPropertyIdEND     = 0x00000012,
}
alias EVT_SYSTEM_PROPERTY_ID = int;

enum : int
{
    EvtRenderContextValues = 0x00000000,
    EvtRenderContextSystem = 0x00000001,
    EvtRenderContextUser   = 0x00000002,
}
alias EVT_RENDER_CONTEXT_FLAGS = int;

enum : int
{
    EvtRenderEventValues = 0x00000000,
    EvtRenderEventXml    = 0x00000001,
    EvtRenderBookmark    = 0x00000002,
}
alias EVT_RENDER_FLAGS = int;

enum : int
{
    EvtFormatMessageEvent    = 0x00000001,
    EvtFormatMessageLevel    = 0x00000002,
    EvtFormatMessageTask     = 0x00000003,
    EvtFormatMessageOpcode   = 0x00000004,
    EvtFormatMessageKeyword  = 0x00000005,
    EvtFormatMessageChannel  = 0x00000006,
    EvtFormatMessageProvider = 0x00000007,
    EvtFormatMessageId       = 0x00000008,
    EvtFormatMessageXml      = 0x00000009,
}
alias EVT_FORMAT_MESSAGE_FLAGS = int;

enum : int
{
    EvtOpenChannelPath = 0x00000001,
    EvtOpenFilePath    = 0x00000002,
}
alias EVT_OPEN_LOG_FLAGS = int;

enum : int
{
    EvtLogCreationTime       = 0x00000000,
    EvtLogLastAccessTime     = 0x00000001,
    EvtLogLastWriteTime      = 0x00000002,
    EvtLogFileSize           = 0x00000003,
    EvtLogAttributes         = 0x00000004,
    EvtLogNumberOfLogRecords = 0x00000005,
    EvtLogOldestRecordNumber = 0x00000006,
    EvtLogFull               = 0x00000007,
}
alias EVT_LOG_PROPERTY_ID = int;

enum : int
{
    EvtExportLogChannelPath         = 0x00000001,
    EvtExportLogFilePath            = 0x00000002,
    EvtExportLogTolerateQueryErrors = 0x00001000,
    EvtExportLogOverwrite           = 0x00002000,
}
alias EVT_EXPORTLOG_FLAGS = int;

enum : int
{
    EvtChannelConfigEnabled               = 0x00000000,
    EvtChannelConfigIsolation             = 0x00000001,
    EvtChannelConfigType                  = 0x00000002,
    EvtChannelConfigOwningPublisher       = 0x00000003,
    EvtChannelConfigClassicEventlog       = 0x00000004,
    EvtChannelConfigAccess                = 0x00000005,
    EvtChannelLoggingConfigRetention      = 0x00000006,
    EvtChannelLoggingConfigAutoBackup     = 0x00000007,
    EvtChannelLoggingConfigMaxSize        = 0x00000008,
    EvtChannelLoggingConfigLogFilePath    = 0x00000009,
    EvtChannelPublishingConfigLevel       = 0x0000000a,
    EvtChannelPublishingConfigKeywords    = 0x0000000b,
    EvtChannelPublishingConfigControlGuid = 0x0000000c,
    EvtChannelPublishingConfigBufferSize  = 0x0000000d,
    EvtChannelPublishingConfigMinBuffers  = 0x0000000e,
    EvtChannelPublishingConfigMaxBuffers  = 0x0000000f,
    EvtChannelPublishingConfigLatency     = 0x00000010,
    EvtChannelPublishingConfigClockType   = 0x00000011,
    EvtChannelPublishingConfigSidType     = 0x00000012,
    EvtChannelPublisherList               = 0x00000013,
    EvtChannelPublishingConfigFileMax     = 0x00000014,
    EvtChannelConfigPropertyIdEND         = 0x00000015,
}
alias EVT_CHANNEL_CONFIG_PROPERTY_ID = int;

enum : int
{
    EvtChannelTypeAdmin       = 0x00000000,
    EvtChannelTypeOperational = 0x00000001,
    EvtChannelTypeAnalytic    = 0x00000002,
    EvtChannelTypeDebug       = 0x00000003,
}
alias EVT_CHANNEL_TYPE = int;

enum : int
{
    EvtChannelIsolationTypeApplication = 0x00000000,
    EvtChannelIsolationTypeSystem      = 0x00000001,
    EvtChannelIsolationTypeCustom      = 0x00000002,
}
alias EVT_CHANNEL_ISOLATION_TYPE = int;

enum : int
{
    EvtChannelClockTypeSystemTime = 0x00000000,
    EvtChannelClockTypeQPC        = 0x00000001,
}
alias EVT_CHANNEL_CLOCK_TYPE = int;

enum : int
{
    EvtChannelSidTypeNone       = 0x00000000,
    EvtChannelSidTypePublishing = 0x00000001,
}
alias EVT_CHANNEL_SID_TYPE = int;

enum : int
{
    EvtChannelReferenceImported = 0x00000001,
}
alias EVT_CHANNEL_REFERENCE_FLAGS = int;

enum : int
{
    EvtPublisherMetadataPublisherGuid             = 0x00000000,
    EvtPublisherMetadataResourceFilePath          = 0x00000001,
    EvtPublisherMetadataParameterFilePath         = 0x00000002,
    EvtPublisherMetadataMessageFilePath           = 0x00000003,
    EvtPublisherMetadataHelpLink                  = 0x00000004,
    EvtPublisherMetadataPublisherMessageID        = 0x00000005,
    EvtPublisherMetadataChannelReferences         = 0x00000006,
    EvtPublisherMetadataChannelReferencePath      = 0x00000007,
    EvtPublisherMetadataChannelReferenceIndex     = 0x00000008,
    EvtPublisherMetadataChannelReferenceID        = 0x00000009,
    EvtPublisherMetadataChannelReferenceFlags     = 0x0000000a,
    EvtPublisherMetadataChannelReferenceMessageID = 0x0000000b,
    EvtPublisherMetadataLevels                    = 0x0000000c,
    EvtPublisherMetadataLevelName                 = 0x0000000d,
    EvtPublisherMetadataLevelValue                = 0x0000000e,
    EvtPublisherMetadataLevelMessageID            = 0x0000000f,
    EvtPublisherMetadataTasks                     = 0x00000010,
    EvtPublisherMetadataTaskName                  = 0x00000011,
    EvtPublisherMetadataTaskEventGuid             = 0x00000012,
    EvtPublisherMetadataTaskValue                 = 0x00000013,
    EvtPublisherMetadataTaskMessageID             = 0x00000014,
    EvtPublisherMetadataOpcodes                   = 0x00000015,
    EvtPublisherMetadataOpcodeName                = 0x00000016,
    EvtPublisherMetadataOpcodeValue               = 0x00000017,
    EvtPublisherMetadataOpcodeMessageID           = 0x00000018,
    EvtPublisherMetadataKeywords                  = 0x00000019,
    EvtPublisherMetadataKeywordName               = 0x0000001a,
    EvtPublisherMetadataKeywordValue              = 0x0000001b,
    EvtPublisherMetadataKeywordMessageID          = 0x0000001c,
    EvtPublisherMetadataPropertyIdEND             = 0x0000001d,
}
alias EVT_PUBLISHER_METADATA_PROPERTY_ID = int;

enum : int
{
    EventMetadataEventID          = 0x00000000,
    EventMetadataEventVersion     = 0x00000001,
    EventMetadataEventChannel     = 0x00000002,
    EventMetadataEventLevel       = 0x00000003,
    EventMetadataEventOpcode      = 0x00000004,
    EventMetadataEventTask        = 0x00000005,
    EventMetadataEventKeyword     = 0x00000006,
    EventMetadataEventMessageID   = 0x00000007,
    EventMetadataEventTemplate    = 0x00000008,
    EvtEventMetadataPropertyIdEND = 0x00000009,
}
alias EVT_EVENT_METADATA_PROPERTY_ID = int;

enum : int
{
    EvtQueryNames         = 0x00000000,
    EvtQueryStatuses      = 0x00000001,
    EvtQueryPropertyIdEND = 0x00000002,
}
alias EVT_QUERY_PROPERTY_ID = int;

enum : int
{
    EvtEventQueryIDs      = 0x00000000,
    EvtEventPath          = 0x00000001,
    EvtEventPropertyIdEND = 0x00000002,
}
alias EVT_EVENT_PROPERTY_ID = int;

// Callbacks

alias EVT_SUBSCRIBE_CALLBACK = uint function(EVT_SUBSCRIBE_NOTIFY_ACTION Action, void* UserContext, 
                                             ptrdiff_t Event);

// Structs


struct EVT_VARIANT
{
    union
    {
        BOOL          BooleanVal;
        byte          SByteVal;
        short         Int16Val;
        int           Int32Val;
        long          Int64Val;
        ubyte         ByteVal;
        ushort        UInt16Val;
        uint          UInt32Val;
        ulong         UInt64Val;
        float         SingleVal;
        double        DoubleVal;
        ulong         FileTimeVal;
        SYSTEMTIME*   SysTimeVal;
        GUID*         GuidVal;
        const(wchar)* StringVal;
        const(char)*  AnsiStringVal;
        ubyte*        BinaryVal;
        void*         SidVal;
        size_t        SizeTVal;
        int*          BooleanArr;
        byte*         SByteArr;
        short*        Int16Arr;
        int*          Int32Arr;
        long*         Int64Arr;
        ubyte*        ByteArr;
        ushort*       UInt16Arr;
        uint*         UInt32Arr;
        ulong*        UInt64Arr;
        float*        SingleArr;
        double*       DoubleArr;
        FILETIME*     FileTimeArr;
        SYSTEMTIME*   SysTimeArr;
        GUID*         GuidArr;
        ushort**      StringArr;
        byte**        AnsiStringArr;
        void**        SidArr;
        size_t*       SizeTArr;
        ptrdiff_t     EvtHandleVal;
        const(wchar)* XmlVal;
        ushort**      XmlValArr;
    }
    uint Count;
    uint Type;
}

struct EVT_RPC_LOGIN
{
    const(wchar)* Server;
    const(wchar)* User;
    const(wchar)* Domain;
    const(wchar)* Password;
    uint          Flags;
}

// Functions

@DllImport("wevtapi")
ptrdiff_t EvtOpenSession(EVT_LOGIN_CLASS LoginClass, char* Login, uint Timeout, uint Flags);

@DllImport("wevtapi")
BOOL EvtClose(ptrdiff_t Object);

@DllImport("wevtapi")
BOOL EvtCancel(ptrdiff_t Object);

@DllImport("wevtapi")
uint EvtGetExtendedStatus(uint BufferSize, const(wchar)* Buffer, uint* BufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtQuery(ptrdiff_t Session, const(wchar)* Path, const(wchar)* Query, uint Flags);

@DllImport("wevtapi")
BOOL EvtNext(ptrdiff_t ResultSet, uint EventsSize, char* Events, uint Timeout, uint Flags, uint* Returned);

@DllImport("wevtapi")
BOOL EvtSeek(ptrdiff_t ResultSet, long Position, ptrdiff_t Bookmark, uint Timeout, uint Flags);

@DllImport("wevtapi")
ptrdiff_t EvtSubscribe(ptrdiff_t Session, HANDLE SignalEvent, const(wchar)* ChannelPath, const(wchar)* Query, 
                       ptrdiff_t Bookmark, void* Context, EVT_SUBSCRIBE_CALLBACK Callback, uint Flags);

@DllImport("wevtapi")
ptrdiff_t EvtCreateRenderContext(uint ValuePathsCount, char* ValuePaths, uint Flags);

@DllImport("wevtapi")
BOOL EvtRender(ptrdiff_t Context, ptrdiff_t Fragment, uint Flags, uint BufferSize, char* Buffer, uint* BufferUsed, 
               uint* PropertyCount);

@DllImport("wevtapi")
BOOL EvtFormatMessage(ptrdiff_t PublisherMetadata, ptrdiff_t Event, uint MessageId, uint ValueCount, char* Values, 
                      uint Flags, uint BufferSize, const(wchar)* Buffer, uint* BufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtOpenLog(ptrdiff_t Session, const(wchar)* Path, uint Flags);

@DllImport("wevtapi")
BOOL EvtGetLogInfo(ptrdiff_t Log, EVT_LOG_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                   char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi")
BOOL EvtClearLog(ptrdiff_t Session, const(wchar)* ChannelPath, const(wchar)* TargetFilePath, uint Flags);

@DllImport("wevtapi")
BOOL EvtExportLog(ptrdiff_t Session, const(wchar)* Path, const(wchar)* Query, const(wchar)* TargetFilePath, 
                  uint Flags);

@DllImport("wevtapi")
BOOL EvtArchiveExportedLog(ptrdiff_t Session, const(wchar)* LogFilePath, uint Locale, uint Flags);

@DllImport("wevtapi")
ptrdiff_t EvtOpenChannelEnum(ptrdiff_t Session, uint Flags);

@DllImport("wevtapi")
BOOL EvtNextChannelPath(ptrdiff_t ChannelEnum, uint ChannelPathBufferSize, const(wchar)* ChannelPathBuffer, 
                        uint* ChannelPathBufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtOpenChannelConfig(ptrdiff_t Session, const(wchar)* ChannelPath, uint Flags);

@DllImport("wevtapi")
BOOL EvtSaveChannelConfig(ptrdiff_t ChannelConfig, uint Flags);

@DllImport("wevtapi")
BOOL EvtSetChannelConfigProperty(ptrdiff_t ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 EVT_VARIANT* PropertyValue);

@DllImport("wevtapi")
BOOL EvtGetChannelConfigProperty(ptrdiff_t ChannelConfig, EVT_CHANNEL_CONFIG_PROPERTY_ID PropertyId, uint Flags, 
                                 uint PropertyValueBufferSize, char* PropertyValueBuffer, 
                                 uint* PropertyValueBufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtOpenPublisherEnum(ptrdiff_t Session, uint Flags);

@DllImport("wevtapi")
BOOL EvtNextPublisherId(ptrdiff_t PublisherEnum, uint PublisherIdBufferSize, const(wchar)* PublisherIdBuffer, 
                        uint* PublisherIdBufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtOpenPublisherMetadata(ptrdiff_t Session, const(wchar)* PublisherId, const(wchar)* LogFilePath, 
                                   uint Locale, uint Flags);

@DllImport("wevtapi")
BOOL EvtGetPublisherMetadataProperty(ptrdiff_t PublisherMetadata, EVT_PUBLISHER_METADATA_PROPERTY_ID PropertyId, 
                                     uint Flags, uint PublisherMetadataPropertyBufferSize, 
                                     char* PublisherMetadataPropertyBuffer, 
                                     uint* PublisherMetadataPropertyBufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtOpenEventMetadataEnum(ptrdiff_t PublisherMetadata, uint Flags);

@DllImport("wevtapi")
ptrdiff_t EvtNextEventMetadata(ptrdiff_t EventMetadataEnum, uint Flags);

@DllImport("wevtapi")
BOOL EvtGetEventMetadataProperty(ptrdiff_t EventMetadata, EVT_EVENT_METADATA_PROPERTY_ID PropertyId, uint Flags, 
                                 uint EventMetadataPropertyBufferSize, char* EventMetadataPropertyBuffer, 
                                 uint* EventMetadataPropertyBufferUsed);

@DllImport("wevtapi")
BOOL EvtGetObjectArraySize(ptrdiff_t ObjectArray, uint* ObjectArraySize);

@DllImport("wevtapi")
BOOL EvtGetObjectArrayProperty(ptrdiff_t ObjectArray, uint PropertyId, uint ArrayIndex, uint Flags, 
                               uint PropertyValueBufferSize, char* PropertyValueBuffer, 
                               uint* PropertyValueBufferUsed);

@DllImport("wevtapi")
BOOL EvtGetQueryInfo(ptrdiff_t QueryOrSubscription, EVT_QUERY_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                     char* PropertyValueBuffer, uint* PropertyValueBufferUsed);

@DllImport("wevtapi")
ptrdiff_t EvtCreateBookmark(const(wchar)* BookmarkXml);

@DllImport("wevtapi")
BOOL EvtUpdateBookmark(ptrdiff_t Bookmark, ptrdiff_t Event);

@DllImport("wevtapi")
BOOL EvtGetEventInfo(ptrdiff_t Event, EVT_EVENT_PROPERTY_ID PropertyId, uint PropertyValueBufferSize, 
                     char* PropertyValueBuffer, uint* PropertyValueBufferUsed);


