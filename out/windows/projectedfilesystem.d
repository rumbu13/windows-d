module windows.projectedfilesystem;

public import system;
public import windows.com;
public import windows.systemservices;

extern(Windows):

enum PRJ_NOTIFY_TYPES
{
    PRJ_NOTIFY_NONE = 0,
    PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS = 1,
    PRJ_NOTIFY_FILE_OPENED = 2,
    PRJ_NOTIFY_NEW_FILE_CREATED = 4,
    PRJ_NOTIFY_FILE_OVERWRITTEN = 8,
    PRJ_NOTIFY_PRE_DELETE = 16,
    PRJ_NOTIFY_PRE_RENAME = 32,
    PRJ_NOTIFY_PRE_SET_HARDLINK = 64,
    PRJ_NOTIFY_FILE_RENAMED = 128,
    PRJ_NOTIFY_HARDLINK_CREATED = 256,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_NO_MODIFICATION = 512,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED = 1024,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED = 2048,
    PRJ_NOTIFY_FILE_PRE_CONVERT_TO_FULL = 4096,
    PRJ_NOTIFY_USE_EXISTING_MASK = -1,
}

enum PRJ_NOTIFICATION
{
    PRJ_NOTIFICATION_FILE_OPENED = 2,
    PRJ_NOTIFICATION_NEW_FILE_CREATED = 4,
    PRJ_NOTIFICATION_FILE_OVERWRITTEN = 8,
    PRJ_NOTIFICATION_PRE_DELETE = 16,
    PRJ_NOTIFICATION_PRE_RENAME = 32,
    PRJ_NOTIFICATION_PRE_SET_HARDLINK = 64,
    PRJ_NOTIFICATION_FILE_RENAMED = 128,
    PRJ_NOTIFICATION_HARDLINK_CREATED = 256,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_NO_MODIFICATION = 512,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED = 1024,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED = 2048,
    PRJ_NOTIFICATION_FILE_PRE_CONVERT_TO_FULL = 4096,
}

struct PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__
{
    int unused;
}

struct PRJ_DIR_ENTRY_BUFFER_HANDLE__
{
    int unused;
}

enum PRJ_EXT_INFO_TYPE
{
    PRJ_EXT_INFO_TYPE_SYMLINK = 1,
}

struct PRJ_EXTENDED_INFO
{
    PRJ_EXT_INFO_TYPE InfoType;
    uint NextInfoOffset;
    _Anonymous_e__Union Anonymous;
}

struct PRJ_NOTIFICATION_MAPPING
{
    PRJ_NOTIFY_TYPES NotificationBitMask;
    const(wchar)* NotificationRoot;
}

enum PRJ_STARTVIRTUALIZING_FLAGS
{
    PRJ_FLAG_NONE = 0,
    PRJ_FLAG_USE_NEGATIVE_PATH_CACHE = 1,
}

struct PRJ_STARTVIRTUALIZING_OPTIONS
{
    PRJ_STARTVIRTUALIZING_FLAGS Flags;
    uint PoolThreadCount;
    uint ConcurrentThreadCount;
    PRJ_NOTIFICATION_MAPPING* NotificationMappings;
    uint NotificationMappingsCount;
}

struct PRJ_VIRTUALIZATION_INSTANCE_INFO
{
    Guid InstanceID;
    uint WriteAlignment;
}

enum PRJ_PLACEHOLDER_ID
{
    PRJ_PLACEHOLDER_ID_LENGTH = 128,
}

struct PRJ_PLACEHOLDER_VERSION_INFO
{
    ubyte ProviderID;
    ubyte ContentID;
}

struct PRJ_FILE_BASIC_INFO
{
    ubyte IsDirectory;
    long FileSize;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    uint FileAttributes;
}

struct PRJ_PLACEHOLDER_INFO
{
    PRJ_FILE_BASIC_INFO FileBasicInfo;
    _EaInformation_e__Struct EaInformation;
    _SecurityInformation_e__Struct SecurityInformation;
    _StreamsInformation_e__Struct StreamsInformation;
    PRJ_PLACEHOLDER_VERSION_INFO VersionInfo;
    ubyte VariableData;
}

enum PRJ_UPDATE_TYPES
{
    PRJ_UPDATE_NONE = 0,
    PRJ_UPDATE_ALLOW_DIRTY_METADATA = 1,
    PRJ_UPDATE_ALLOW_DIRTY_DATA = 2,
    PRJ_UPDATE_ALLOW_TOMBSTONE = 4,
    PRJ_UPDATE_RESERVED1 = 8,
    PRJ_UPDATE_RESERVED2 = 16,
    PRJ_UPDATE_ALLOW_READ_ONLY = 32,
    PRJ_UPDATE_MAX_VAL = 64,
}

enum PRJ_UPDATE_FAILURE_CAUSES
{
    PRJ_UPDATE_FAILURE_CAUSE_NONE = 0,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_METADATA = 1,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_DATA = 2,
    PRJ_UPDATE_FAILURE_CAUSE_TOMBSTONE = 4,
    PRJ_UPDATE_FAILURE_CAUSE_READ_ONLY = 8,
}

enum PRJ_FILE_STATE
{
    PRJ_FILE_STATE_PLACEHOLDER = 1,
    PRJ_FILE_STATE_HYDRATED_PLACEHOLDER = 2,
    PRJ_FILE_STATE_DIRTY_PLACEHOLDER = 4,
    PRJ_FILE_STATE_FULL = 8,
    PRJ_FILE_STATE_TOMBSTONE = 16,
}

enum PRJ_CALLBACK_DATA_FLAGS
{
    PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN = 1,
    PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY = 2,
}

struct PRJ_CALLBACK_DATA
{
    uint Size;
    PRJ_CALLBACK_DATA_FLAGS Flags;
    PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* NamespaceVirtualizationContext;
    int CommandId;
    Guid FileId;
    Guid DataStreamId;
    const(wchar)* FilePathName;
    PRJ_PLACEHOLDER_VERSION_INFO* VersionInfo;
    uint TriggeringProcessId;
    const(wchar)* TriggeringProcessImageFileName;
    void* InstanceContext;
}

alias PRJ_START_DIRECTORY_ENUMERATION_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, const(Guid)* enumerationId);
alias PRJ_GET_DIRECTORY_ENUMERATION_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, const(Guid)* enumerationId, const(wchar)* searchExpression, PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);
alias PRJ_END_DIRECTORY_ENUMERATION_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, const(Guid)* enumerationId);
alias PRJ_GET_PLACEHOLDER_INFO_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
alias PRJ_GET_FILE_DATA_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ulong byteOffset, uint length);
alias PRJ_QUERY_FILE_NAME_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
struct PRJ_NOTIFICATION_PARAMETERS
{
    _PostCreate_e__Struct PostCreate;
    _FileRenamed_e__Struct FileRenamed;
    _FileDeletedOnHandleClose_e__Struct FileDeletedOnHandleClose;
}

alias PRJ_NOTIFICATION_CB = extern(Windows) HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ubyte isDirectory, PRJ_NOTIFICATION notification, const(wchar)* destinationFileName, PRJ_NOTIFICATION_PARAMETERS* operationParameters);
alias PRJ_CANCEL_COMMAND_CB = extern(Windows) void function(const(PRJ_CALLBACK_DATA)* callbackData);
struct PRJ_CALLBACKS
{
    PRJ_START_DIRECTORY_ENUMERATION_CB* StartDirectoryEnumerationCallback;
    PRJ_END_DIRECTORY_ENUMERATION_CB* EndDirectoryEnumerationCallback;
    PRJ_GET_DIRECTORY_ENUMERATION_CB* GetDirectoryEnumerationCallback;
    PRJ_GET_PLACEHOLDER_INFO_CB* GetPlaceholderInfoCallback;
    PRJ_GET_FILE_DATA_CB* GetFileDataCallback;
    PRJ_QUERY_FILE_NAME_CB* QueryFileNameCallback;
    PRJ_NOTIFICATION_CB* NotificationCallback;
    PRJ_CANCEL_COMMAND_CB* CancelCommandCallback;
}

enum PRJ_COMPLETE_COMMAND_TYPE
{
    PRJ_COMPLETE_COMMAND_TYPE_NOTIFICATION = 1,
    PRJ_COMPLETE_COMMAND_TYPE_ENUMERATION = 2,
}

struct PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS
{
    PRJ_COMPLETE_COMMAND_TYPE CommandType;
    _Anonymous_e__Union Anonymous;
}

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjStartVirtualizing(const(wchar)* virtualizationRootPath, const(PRJ_CALLBACKS)* callbacks, const(void)* instanceContext, const(PRJ_STARTVIRTUALIZING_OPTIONS)* options, PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__** namespaceVirtualizationContext);

@DllImport("PROJECTEDFSLIB.dll")
void PrjStopVirtualizing(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjClearNegativePathCache(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, uint* totalEntryNumber);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjGetVirtualizationInstanceInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, PRJ_VIRTUALIZATION_INSTANCE_INFO* virtualizationInstanceInfo);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjMarkDirectoryAsPlaceholder(const(wchar)* rootPathName, const(wchar)* targetPathName, const(PRJ_PLACEHOLDER_VERSION_INFO)* versionInfo, const(Guid)* virtualizationInstanceID);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWritePlaceholderInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWritePlaceholderInfo2(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize, const(PRJ_EXTENDED_INFO)* ExtendedInfo);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjUpdateFileIfNeeded(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize, PRJ_UPDATE_TYPES updateFlags, PRJ_UPDATE_FAILURE_CAUSES* failureReason);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjDeleteFile(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, const(wchar)* destinationFileName, PRJ_UPDATE_TYPES updateFlags, PRJ_UPDATE_FAILURE_CAUSES* failureReason);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjWriteFileData(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, const(Guid)* dataStreamId, char* buffer, ulong byteOffset, uint length);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjGetOnDiskFileState(const(wchar)* destinationFileName, PRJ_FILE_STATE* fileState);

@DllImport("PROJECTEDFSLIB.dll")
void* PrjAllocateAlignedBuffer(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, uint size);

@DllImport("PROJECTEDFSLIB.dll")
void PrjFreeAlignedBuffer(void* buffer);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjCompleteCommand(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, int commandId, HRESULT completionResult, PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS* extendedParameters);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjFillDirEntryBuffer(const(wchar)* fileName, PRJ_FILE_BASIC_INFO* fileBasicInfo, PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);

@DllImport("PROJECTEDFSLIB.dll")
HRESULT PrjFillDirEntryBuffer2(PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle, const(wchar)* fileName, PRJ_FILE_BASIC_INFO* fileBasicInfo, PRJ_EXTENDED_INFO* extendedInfo);

@DllImport("PROJECTEDFSLIB.dll")
ubyte PrjFileNameMatch(const(wchar)* fileNameToCheck, const(wchar)* pattern);

@DllImport("PROJECTEDFSLIB.dll")
int PrjFileNameCompare(const(wchar)* fileName1, const(wchar)* fileName2);

@DllImport("PROJECTEDFSLIB.dll")
ubyte PrjDoesNameContainWildCards(const(wchar)* fileName);

