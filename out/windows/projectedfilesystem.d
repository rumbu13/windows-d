module windows.projectedfilesystem;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : LARGE_INTEGER;

extern(Windows):


// Enums


enum : int
{
    PRJ_NOTIFY_NONE                               = 0x00000000,
    PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS             = 0x00000001,
    PRJ_NOTIFY_FILE_OPENED                        = 0x00000002,
    PRJ_NOTIFY_NEW_FILE_CREATED                   = 0x00000004,
    PRJ_NOTIFY_FILE_OVERWRITTEN                   = 0x00000008,
    PRJ_NOTIFY_PRE_DELETE                         = 0x00000010,
    PRJ_NOTIFY_PRE_RENAME                         = 0x00000020,
    PRJ_NOTIFY_PRE_SET_HARDLINK                   = 0x00000040,
    PRJ_NOTIFY_FILE_RENAMED                       = 0x00000080,
    PRJ_NOTIFY_HARDLINK_CREATED                   = 0x00000100,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    PRJ_NOTIFY_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
    PRJ_NOTIFY_USE_EXISTING_MASK                  = 0xffffffff,
}
alias PRJ_NOTIFY_TYPES = int;

enum : int
{
    PRJ_NOTIFICATION_FILE_OPENED                        = 0x00000002,
    PRJ_NOTIFICATION_NEW_FILE_CREATED                   = 0x00000004,
    PRJ_NOTIFICATION_FILE_OVERWRITTEN                   = 0x00000008,
    PRJ_NOTIFICATION_PRE_DELETE                         = 0x00000010,
    PRJ_NOTIFICATION_PRE_RENAME                         = 0x00000020,
    PRJ_NOTIFICATION_PRE_SET_HARDLINK                   = 0x00000040,
    PRJ_NOTIFICATION_FILE_RENAMED                       = 0x00000080,
    PRJ_NOTIFICATION_HARDLINK_CREATED                   = 0x00000100,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    PRJ_NOTIFICATION_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
}
alias PRJ_NOTIFICATION = int;

enum : int
{
    PRJ_EXT_INFO_TYPE_SYMLINK = 0x00000001,
}
alias PRJ_EXT_INFO_TYPE = int;

enum : int
{
    PRJ_FLAG_NONE                    = 0x00000000,
    PRJ_FLAG_USE_NEGATIVE_PATH_CACHE = 0x00000001,
}
alias PRJ_STARTVIRTUALIZING_FLAGS = int;

enum : int
{
    PRJ_PLACEHOLDER_ID_LENGTH = 0x00000080,
}
alias PRJ_PLACEHOLDER_ID = int;

enum : int
{
    PRJ_UPDATE_NONE                 = 0x00000000,
    PRJ_UPDATE_ALLOW_DIRTY_METADATA = 0x00000001,
    PRJ_UPDATE_ALLOW_DIRTY_DATA     = 0x00000002,
    PRJ_UPDATE_ALLOW_TOMBSTONE      = 0x00000004,
    PRJ_UPDATE_RESERVED1            = 0x00000008,
    PRJ_UPDATE_RESERVED2            = 0x00000010,
    PRJ_UPDATE_ALLOW_READ_ONLY      = 0x00000020,
    PRJ_UPDATE_MAX_VAL              = 0x00000040,
}
alias PRJ_UPDATE_TYPES = int;

enum : int
{
    PRJ_UPDATE_FAILURE_CAUSE_NONE           = 0x00000000,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_METADATA = 0x00000001,
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_DATA     = 0x00000002,
    PRJ_UPDATE_FAILURE_CAUSE_TOMBSTONE      = 0x00000004,
    PRJ_UPDATE_FAILURE_CAUSE_READ_ONLY      = 0x00000008,
}
alias PRJ_UPDATE_FAILURE_CAUSES = int;

enum : int
{
    PRJ_FILE_STATE_PLACEHOLDER          = 0x00000001,
    PRJ_FILE_STATE_HYDRATED_PLACEHOLDER = 0x00000002,
    PRJ_FILE_STATE_DIRTY_PLACEHOLDER    = 0x00000004,
    PRJ_FILE_STATE_FULL                 = 0x00000008,
    PRJ_FILE_STATE_TOMBSTONE            = 0x00000010,
}
alias PRJ_FILE_STATE = int;

enum : int
{
    PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN        = 0x00000001,
    PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY = 0x00000002,
}
alias PRJ_CALLBACK_DATA_FLAGS = int;

enum : int
{
    PRJ_COMPLETE_COMMAND_TYPE_NOTIFICATION = 0x00000001,
    PRJ_COMPLETE_COMMAND_TYPE_ENUMERATION  = 0x00000002,
}
alias PRJ_COMPLETE_COMMAND_TYPE = int;

// Callbacks

alias PRJ_START_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                            const(GUID)* enumerationId);
alias PRJ_GET_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId, const(wchar)* searchExpression, 
                                                          PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);
alias PRJ_END_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId);
alias PRJ_GET_PLACEHOLDER_INFO_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
alias PRJ_GET_FILE_DATA_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ulong byteOffset, 
                                              uint length);
alias PRJ_QUERY_FILE_NAME_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
alias PRJ_NOTIFICATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ubyte isDirectory, 
                                             PRJ_NOTIFICATION notification, const(wchar)* destinationFileName, 
                                             PRJ_NOTIFICATION_PARAMETERS* operationParameters);
alias PRJ_CANCEL_COMMAND_CB = void function(const(PRJ_CALLBACK_DATA)* callbackData);

// Structs


struct PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__
{
    int unused;
}

struct PRJ_DIR_ENTRY_BUFFER_HANDLE__
{
    int unused;
}

struct PRJ_EXTENDED_INFO
{
    PRJ_EXT_INFO_TYPE InfoType;
    uint              NextInfoOffset;
    union
    {
        struct Symlink
        {
            const(wchar)* TargetName;
        }
    }
}

struct PRJ_NOTIFICATION_MAPPING
{
    PRJ_NOTIFY_TYPES NotificationBitMask;
    const(wchar)*    NotificationRoot;
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
    GUID InstanceID;
    uint WriteAlignment;
}

struct PRJ_PLACEHOLDER_VERSION_INFO
{
    ubyte[128] ProviderID;
    ubyte[128] ContentID;
}

struct PRJ_FILE_BASIC_INFO
{
    ubyte         IsDirectory;
    long          FileSize;
    LARGE_INTEGER CreationTime;
    LARGE_INTEGER LastAccessTime;
    LARGE_INTEGER LastWriteTime;
    LARGE_INTEGER ChangeTime;
    uint          FileAttributes;
}

struct PRJ_PLACEHOLDER_INFO
{
    PRJ_FILE_BASIC_INFO FileBasicInfo;
    struct EaInformation
    {
        uint EaBufferSize;
        uint OffsetToFirstEa;
    }
    struct SecurityInformation
    {
        uint SecurityBufferSize;
        uint OffsetToSecurityDescriptor;
    }
    struct StreamsInformation
    {
        uint StreamsInfoBufferSize;
        uint OffsetToFirstStreamInfo;
    }
    PRJ_PLACEHOLDER_VERSION_INFO VersionInfo;
    ubyte[1]            VariableData;
}

struct PRJ_CALLBACK_DATA
{
    uint          Size;
    PRJ_CALLBACK_DATA_FLAGS Flags;
    PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* NamespaceVirtualizationContext;
    int           CommandId;
    GUID          FileId;
    GUID          DataStreamId;
    const(wchar)* FilePathName;
    PRJ_PLACEHOLDER_VERSION_INFO* VersionInfo;
    uint          TriggeringProcessId;
    const(wchar)* TriggeringProcessImageFileName;
    void*         InstanceContext;
}

union PRJ_NOTIFICATION_PARAMETERS
{
    struct PostCreate
    {
        PRJ_NOTIFY_TYPES NotificationMask;
    }
    struct FileRenamed
    {
        PRJ_NOTIFY_TYPES NotificationMask;
    }
    struct FileDeletedOnHandleClose
    {
        ubyte IsFileModified;
    }
}

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

struct PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS
{
    PRJ_COMPLETE_COMMAND_TYPE CommandType;
    union
    {
        struct Notification
        {
            PRJ_NOTIFY_TYPES NotificationMask;
        }
        struct Enumeration
        {
            PRJ_DIR_ENTRY_BUFFER_HANDLE__* DirEntryBufferHandle;
        }
    }
}

// Functions

@DllImport("PROJECTEDFSLIB")
HRESULT PrjStartVirtualizing(const(wchar)* virtualizationRootPath, const(PRJ_CALLBACKS)* callbacks, 
                             const(void)* instanceContext, const(PRJ_STARTVIRTUALIZING_OPTIONS)* options, 
                             PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__** namespaceVirtualizationContext);

@DllImport("PROJECTEDFSLIB")
void PrjStopVirtualizing(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjClearNegativePathCache(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                  uint* totalEntryNumber);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjGetVirtualizationInstanceInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                         PRJ_VIRTUALIZATION_INSTANCE_INFO* virtualizationInstanceInfo);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjMarkDirectoryAsPlaceholder(const(wchar)* rootPathName, const(wchar)* targetPathName, 
                                      const(PRJ_PLACEHOLDER_VERSION_INFO)* versionInfo, 
                                      const(GUID)* virtualizationInstanceID);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjWritePlaceholderInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjWritePlaceholderInfo2(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                 const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize, 
                                 const(PRJ_EXTENDED_INFO)* ExtendedInfo);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjUpdateFileIfNeeded(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                              const(wchar)* destinationFileName, char* placeholderInfo, uint placeholderInfoSize, 
                              PRJ_UPDATE_TYPES updateFlags, PRJ_UPDATE_FAILURE_CAUSES* failureReason);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjDeleteFile(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                      const(wchar)* destinationFileName, PRJ_UPDATE_TYPES updateFlags, 
                      PRJ_UPDATE_FAILURE_CAUSES* failureReason);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjWriteFileData(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                         const(GUID)* dataStreamId, char* buffer, ulong byteOffset, uint length);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjGetOnDiskFileState(const(wchar)* destinationFileName, PRJ_FILE_STATE* fileState);

@DllImport("PROJECTEDFSLIB")
void* PrjAllocateAlignedBuffer(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, size_t size);

@DllImport("PROJECTEDFSLIB")
void PrjFreeAlignedBuffer(void* buffer);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjCompleteCommand(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, int commandId, 
                           HRESULT completionResult, PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS* extendedParameters);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjFillDirEntryBuffer(const(wchar)* fileName, PRJ_FILE_BASIC_INFO* fileBasicInfo, 
                              PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);

@DllImport("PROJECTEDFSLIB")
HRESULT PrjFillDirEntryBuffer2(PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle, const(wchar)* fileName, 
                               PRJ_FILE_BASIC_INFO* fileBasicInfo, PRJ_EXTENDED_INFO* extendedInfo);

@DllImport("PROJECTEDFSLIB")
ubyte PrjFileNameMatch(const(wchar)* fileNameToCheck, const(wchar)* pattern);

@DllImport("PROJECTEDFSLIB")
int PrjFileNameCompare(const(wchar)* fileName1, const(wchar)* fileName2);

@DllImport("PROJECTEDFSLIB")
ubyte PrjDoesNameContainWildCards(const(wchar)* fileName);


