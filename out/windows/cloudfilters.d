module windows.cloudfilters;

public import windows.core;
public import windows.com : HRESULT;
public import windows.filesystem : FILE_BASIC_INFO, FILE_INFO_BY_HANDLE_CLASS, WIN32_FIND_DATAA;
public import windows.systemservices : CORRELATION_VECTOR, HANDLE, LARGE_INTEGER, NTSTATUS, OVERLAPPED;

extern(Windows):


// Enums


enum : int
{
    CF_PLACEHOLDER_CREATE_FLAG_NONE                         = 0x00000000,
    CF_PLACEHOLDER_CREATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000001,
    CF_PLACEHOLDER_CREATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    CF_PLACEHOLDER_CREATE_FLAG_SUPERSEDE                    = 0x00000004,
    CF_PLACEHOLDER_CREATE_FLAG_ALWAYS_FULL                  = 0x00000008,
}
alias CF_PLACEHOLDER_CREATE_FLAGS = int;

enum : int
{
    CF_PROVIDER_STATUS_DISCONNECTED       = 0x00000000,
    CF_PROVIDER_STATUS_IDLE               = 0x00000001,
    CF_PROVIDER_STATUS_POPULATE_NAMESPACE = 0x00000002,
    CF_PROVIDER_STATUS_POPULATE_METADATA  = 0x00000004,
    CF_PROVIDER_STATUS_POPULATE_CONTENT   = 0x00000008,
    CF_PROVIDER_STATUS_SYNC_INCREMENTAL   = 0x00000010,
    CF_PROVIDER_STATUS_SYNC_FULL          = 0x00000020,
    CF_PROVIDER_STATUS_CONNECTIVITY_LOST  = 0x00000040,
    CF_PROVIDER_STATUS_CLEAR_FLAGS        = 0x80000000,
    CF_PROVIDER_STATUS_TERMINATED         = 0xc0000001,
    CF_PROVIDER_STATUS_ERROR              = 0xc0000002,
}
alias CF_SYNC_PROVIDER_STATUS = int;

enum : int
{
    CF_REGISTER_FLAG_NONE                                 = 0x00000000,
    CF_REGISTER_FLAG_UPDATE                               = 0x00000001,
    CF_REGISTER_FLAG_DISABLE_ON_DEMAND_POPULATION_ON_ROOT = 0x00000002,
    CF_REGISTER_FLAG_MARK_IN_SYNC_ON_ROOT                 = 0x00000004,
}
alias CF_REGISTER_FLAGS = int;

enum : int
{
    CF_HYDRATION_POLICY_PARTIAL     = 0x00000000,
    CF_HYDRATION_POLICY_PROGRESSIVE = 0x00000001,
    CF_HYDRATION_POLICY_FULL        = 0x00000002,
    CF_HYDRATION_POLICY_ALWAYS_FULL = 0x00000003,
}
alias CF_HYDRATION_POLICY_PRIMARY = int;

enum : int
{
    CF_HYDRATION_POLICY_MODIFIER_NONE                     = 0x00000000,
    CF_HYDRATION_POLICY_MODIFIER_VALIDATION_REQUIRED      = 0x00000001,
    CF_HYDRATION_POLICY_MODIFIER_STREAMING_ALLOWED        = 0x00000002,
    CF_HYDRATION_POLICY_MODIFIER_AUTO_DEHYDRATION_ALLOWED = 0x00000004,
}
alias CF_HYDRATION_POLICY_MODIFIER = int;

enum : int
{
    CF_POPULATION_POLICY_PARTIAL     = 0x00000000,
    CF_POPULATION_POLICY_FULL        = 0x00000002,
    CF_POPULATION_POLICY_ALWAYS_FULL = 0x00000003,
}
alias CF_POPULATION_POLICY_PRIMARY = int;

enum : int
{
    CF_POPULATION_POLICY_MODIFIER_NONE = 0x00000000,
}
alias CF_POPULATION_POLICY_MODIFIER = int;

enum : int
{
    CF_PLACEHOLDER_MANAGEMENT_POLICY_DEFAULT                 = 0x00000000,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CREATE_UNRESTRICTED     = 0x00000001,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CONVERT_TO_UNRESTRICTED = 0x00000002,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_UPDATE_UNRESTRICTED     = 0x00000004,
}
alias CF_PLACEHOLDER_MANAGEMENT_POLICY = int;

enum : int
{
    CF_INSYNC_POLICY_NONE                               = 0x00000000,
    CF_INSYNC_POLICY_TRACK_FILE_CREATION_TIME           = 0x00000001,
    CF_INSYNC_POLICY_TRACK_FILE_READONLY_ATTRIBUTE      = 0x00000002,
    CF_INSYNC_POLICY_TRACK_FILE_HIDDEN_ATTRIBUTE        = 0x00000004,
    CF_INSYNC_POLICY_TRACK_FILE_SYSTEM_ATTRIBUTE        = 0x00000008,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_CREATION_TIME      = 0x00000010,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_READONLY_ATTRIBUTE = 0x00000020,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_HIDDEN_ATTRIBUTE   = 0x00000040,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_SYSTEM_ATTRIBUTE   = 0x00000080,
    CF_INSYNC_POLICY_TRACK_FILE_LAST_WRITE_TIME         = 0x00000100,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_LAST_WRITE_TIME    = 0x00000200,
    CF_INSYNC_POLICY_TRACK_FILE_ALL                     = 0x0055550f,
    CF_INSYNC_POLICY_TRACK_DIRECTORY_ALL                = 0x00aaaaf0,
    CF_INSYNC_POLICY_TRACK_ALL                          = 0x00ffffff,
    CF_INSYNC_POLICY_PRESERVE_INSYNC_FOR_SYNC_ENGINE    = 0x80000000,
}
alias CF_INSYNC_POLICY = int;

enum : int
{
    CF_HARDLINK_POLICY_NONE    = 0x00000000,
    CF_HARDLINK_POLICY_ALLOWED = 0x00000001,
}
alias CF_HARDLINK_POLICY = int;

enum : int
{
    CF_CALLBACK_CANCEL_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_CANCEL_FLAG_IO_TIMEOUT = 0x00000001,
    CF_CALLBACK_CANCEL_FLAG_IO_ABORTED = 0x00000002,
}
alias CF_CALLBACK_CANCEL_FLAGS = int;

enum : int
{
    CF_CALLBACK_FETCH_DATA_FLAG_NONE               = 0x00000000,
    CF_CALLBACK_FETCH_DATA_FLAG_RECOVERY           = 0x00000001,
    CF_CALLBACK_FETCH_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}
alias CF_CALLBACK_FETCH_DATA_FLAGS = int;

enum : int
{
    CF_CALLBACK_VALIDATE_DATA_FLAG_NONE               = 0x00000000,
    CF_CALLBACK_VALIDATE_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}
alias CF_CALLBACK_VALIDATE_DATA_FLAGS = int;

enum : int
{
    CF_CALLBACK_FETCH_PLACEHOLDERS_FLAG_NONE = 0x00000000,
}
alias CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS = int;

enum : int
{
    CF_CALLBACK_OPEN_COMPLETION_FLAG_NONE                    = 0x00000000,
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNKNOWN     = 0x00000001,
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNSUPPORTED = 0x00000002,
}
alias CF_CALLBACK_OPEN_COMPLETION_FLAGS = int;

enum : int
{
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_NONE    = 0x00000000,
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_DELETED = 0x00000001,
}
alias CF_CALLBACK_CLOSE_COMPLETION_FLAGS = int;

enum : int
{
    CF_CALLBACK_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}
alias CF_CALLBACK_DEHYDRATE_FLAGS = int;

enum : int
{
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_BACKGROUND = 0x00000001,
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_DEHYDRATED = 0x00000002,
}
alias CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS = int;

enum : int
{
    CF_CALLBACK_DELETE_FLAG_NONE         = 0x00000000,
    CF_CALLBACK_DELETE_FLAG_IS_DIRECTORY = 0x00000001,
    CF_CALLBACK_DELETE_FLAG_IS_UNDELETE  = 0x00000002,
}
alias CF_CALLBACK_DELETE_FLAGS = int;

enum : int
{
    CF_CALLBACK_DELETE_COMPLETION_FLAG_NONE = 0x00000000,
}
alias CF_CALLBACK_DELETE_COMPLETION_FLAGS = int;

enum : int
{
    CF_CALLBACK_RENAME_FLAG_NONE            = 0x00000000,
    CF_CALLBACK_RENAME_FLAG_IS_DIRECTORY    = 0x00000001,
    CF_CALLBACK_RENAME_FLAG_SOURCE_IN_SCOPE = 0x00000002,
    CF_CALLBACK_RENAME_FLAG_TARGET_IN_SCOPE = 0x00000004,
}
alias CF_CALLBACK_RENAME_FLAGS = int;

enum : int
{
    CF_CALLBACK_RENAME_COMPLETION_FLAG_NONE = 0x00000000,
}
alias CF_CALLBACK_RENAME_COMPLETION_FLAGS = int;

enum : int
{
    CF_CALLBACK_DEHYDRATION_REASON_NONE              = 0x00000000,
    CF_CALLBACK_DEHYDRATION_REASON_USER_MANUAL       = 0x00000001,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_LOW_SPACE  = 0x00000002,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_INACTIVITY = 0x00000003,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_OS_UPGRADE = 0x00000004,
}
alias CF_CALLBACK_DEHYDRATION_REASON = int;

enum : int
{
    CF_CALLBACK_TYPE_FETCH_DATA                   = 0x00000000,
    CF_CALLBACK_TYPE_VALIDATE_DATA                = 0x00000001,
    CF_CALLBACK_TYPE_CANCEL_FETCH_DATA            = 0x00000002,
    CF_CALLBACK_TYPE_FETCH_PLACEHOLDERS           = 0x00000003,
    CF_CALLBACK_TYPE_CANCEL_FETCH_PLACEHOLDERS    = 0x00000004,
    CF_CALLBACK_TYPE_NOTIFY_FILE_OPEN_COMPLETION  = 0x00000005,
    CF_CALLBACK_TYPE_NOTIFY_FILE_CLOSE_COMPLETION = 0x00000006,
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE             = 0x00000007,
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE_COMPLETION  = 0x00000008,
    CF_CALLBACK_TYPE_NOTIFY_DELETE                = 0x00000009,
    CF_CALLBACK_TYPE_NOTIFY_DELETE_COMPLETION     = 0x0000000a,
    CF_CALLBACK_TYPE_NOTIFY_RENAME                = 0x0000000b,
    CF_CALLBACK_TYPE_NOTIFY_RENAME_COMPLETION     = 0x0000000c,
    CF_CALLBACK_TYPE_NONE                         = 0xffffffff,
}
alias CF_CALLBACK_TYPE = int;

enum : int
{
    CF_CONNECT_FLAG_NONE                          = 0x00000000,
    CF_CONNECT_FLAG_REQUIRE_PROCESS_INFO          = 0x00000002,
    CF_CONNECT_FLAG_REQUIRE_FULL_FILE_PATH        = 0x00000004,
    CF_CONNECT_FLAG_BLOCK_SELF_IMPLICIT_HYDRATION = 0x00000008,
}
alias CF_CONNECT_FLAGS = int;

enum : int
{
    CF_OPERATION_TYPE_TRANSFER_DATA         = 0x00000000,
    CF_OPERATION_TYPE_RETRIEVE_DATA         = 0x00000001,
    CF_OPERATION_TYPE_ACK_DATA              = 0x00000002,
    CF_OPERATION_TYPE_RESTART_HYDRATION     = 0x00000003,
    CF_OPERATION_TYPE_TRANSFER_PLACEHOLDERS = 0x00000004,
    CF_OPERATION_TYPE_ACK_DEHYDRATE         = 0x00000005,
    CF_OPERATION_TYPE_ACK_DELETE            = 0x00000006,
    CF_OPERATION_TYPE_ACK_RENAME            = 0x00000007,
}
alias CF_OPERATION_TYPE = int;

enum : int
{
    CF_OPERATION_TRANSFER_DATA_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_TRANSFER_DATA_FLAGS = int;

enum : int
{
    CF_OPERATION_RETRIEVE_DATA_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_RETRIEVE_DATA_FLAGS = int;

enum : int
{
    CF_OPERATION_ACK_DATA_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_ACK_DATA_FLAGS = int;

enum : int
{
    CF_OPERATION_RESTART_HYDRATION_FLAG_NONE         = 0x00000000,
    CF_OPERATION_RESTART_HYDRATION_FLAG_MARK_IN_SYNC = 0x00000001,
}
alias CF_OPERATION_RESTART_HYDRATION_FLAGS = int;

enum : int
{
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_NONE                         = 0x00000000,
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_STOP_ON_ERROR                = 0x00000001,
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000002,
}
alias CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS = int;

enum : int
{
    CF_OPERATION_ACK_DEHYDRATE_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_ACK_DEHYDRATE_FLAGS = int;

enum : int
{
    CF_OPERATION_ACK_RENAME_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_ACK_RENAME_FLAGS = int;

enum : int
{
    CF_OPERATION_ACK_DELETE_FLAG_NONE = 0x00000000,
}
alias CF_OPERATION_ACK_DELETE_FLAGS = int;

enum : int
{
    CF_CREATE_FLAG_NONE          = 0x00000000,
    CF_CREATE_FLAG_STOP_ON_ERROR = 0x00000001,
}
alias CF_CREATE_FLAGS = int;

enum : int
{
    CF_OPEN_FILE_FLAG_NONE          = 0x00000000,
    CF_OPEN_FILE_FLAG_EXCLUSIVE     = 0x00000001,
    CF_OPEN_FILE_FLAG_WRITE_ACCESS  = 0x00000002,
    CF_OPEN_FILE_FLAG_DELETE_ACCESS = 0x00000004,
    CF_OPEN_FILE_FLAG_FOREGROUND    = 0x00000008,
}
alias CF_OPEN_FILE_FLAGS = int;

enum : int
{
    CF_CONVERT_FLAG_NONE                        = 0x00000000,
    CF_CONVERT_FLAG_MARK_IN_SYNC                = 0x00000001,
    CF_CONVERT_FLAG_DEHYDRATE                   = 0x00000002,
    CF_CONVERT_FLAG_ENABLE_ON_DEMAND_POPULATION = 0x00000004,
    CF_CONVERT_FLAG_ALWAYS_FULL                 = 0x00000008,
}
alias CF_CONVERT_FLAGS = int;

enum : int
{
    CF_UPDATE_FLAG_NONE                         = 0x00000000,
    CF_UPDATE_FLAG_VERIFY_IN_SYNC               = 0x00000001,
    CF_UPDATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    CF_UPDATE_FLAG_DEHYDRATE                    = 0x00000004,
    CF_UPDATE_FLAG_ENABLE_ON_DEMAND_POPULATION  = 0x00000008,
    CF_UPDATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000010,
    CF_UPDATE_FLAG_REMOVE_FILE_IDENTITY         = 0x00000020,
    CF_UPDATE_FLAG_CLEAR_IN_SYNC                = 0x00000040,
    CF_UPDATE_FLAG_REMOVE_PROPERTY              = 0x00000080,
    CF_UPDATE_FLAG_PASSTHROUGH_FS_METADATA      = 0x00000100,
    CF_UPDATE_FLAG_ALWAYS_FULL                  = 0x00000200,
    CF_UPDATE_FLAG_ALLOW_PARTIAL                = 0x00000400,
}
alias CF_UPDATE_FLAGS = int;

enum : int
{
    CF_REVERT_FLAG_NONE = 0x00000000,
}
alias CF_REVERT_FLAGS = int;

enum : int
{
    CF_HYDRATE_FLAG_NONE = 0x00000000,
}
alias CF_HYDRATE_FLAGS = int;

enum : int
{
    CF_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}
alias CF_DEHYDRATE_FLAGS = int;

enum : int
{
    CF_PIN_STATE_UNSPECIFIED = 0x00000000,
    CF_PIN_STATE_PINNED      = 0x00000001,
    CF_PIN_STATE_UNPINNED    = 0x00000002,
    CF_PIN_STATE_EXCLUDED    = 0x00000003,
    CF_PIN_STATE_INHERIT     = 0x00000004,
}
alias CF_PIN_STATE = int;

enum : int
{
    CF_SET_PIN_FLAG_NONE                  = 0x00000000,
    CF_SET_PIN_FLAG_RECURSE               = 0x00000001,
    CF_SET_PIN_FLAG_RECURSE_ONLY          = 0x00000002,
    CF_SET_PIN_FLAG_RECURSE_STOP_ON_ERROR = 0x00000004,
}
alias CF_SET_PIN_FLAGS = int;

enum : int
{
    CF_IN_SYNC_STATE_NOT_IN_SYNC = 0x00000000,
    CF_IN_SYNC_STATE_IN_SYNC     = 0x00000001,
}
alias CF_IN_SYNC_STATE = int;

enum : int
{
    CF_SET_IN_SYNC_FLAG_NONE = 0x00000000,
}
alias CF_SET_IN_SYNC_FLAGS = int;

enum : int
{
    CF_PLACEHOLDER_STATE_NO_STATES              = 0x00000000,
    CF_PLACEHOLDER_STATE_PLACEHOLDER            = 0x00000001,
    CF_PLACEHOLDER_STATE_SYNC_ROOT              = 0x00000002,
    CF_PLACEHOLDER_STATE_ESSENTIAL_PROP_PRESENT = 0x00000004,
    CF_PLACEHOLDER_STATE_IN_SYNC                = 0x00000008,
    CF_PLACEHOLDER_STATE_PARTIAL                = 0x00000010,
    CF_PLACEHOLDER_STATE_PARTIALLY_ON_DISK      = 0x00000020,
    CF_PLACEHOLDER_STATE_INVALID                = 0xffffffff,
}
alias CF_PLACEHOLDER_STATE = int;

enum : int
{
    CF_PLACEHOLDER_INFO_BASIC    = 0x00000000,
    CF_PLACEHOLDER_INFO_STANDARD = 0x00000001,
}
alias CF_PLACEHOLDER_INFO_CLASS = int;

enum : int
{
    CF_SYNC_ROOT_INFO_BASIC    = 0x00000000,
    CF_SYNC_ROOT_INFO_STANDARD = 0x00000001,
    CF_SYNC_ROOT_INFO_PROVIDER = 0x00000002,
}
alias CF_SYNC_ROOT_INFO_CLASS = int;

enum : int
{
    CF_PLACEHOLDER_RANGE_INFO_ONDISK    = 0x00000001,
    CF_PLACEHOLDER_RANGE_INFO_VALIDATED = 0x00000002,
    CF_PLACEHOLDER_RANGE_INFO_MODIFIED  = 0x00000003,
}
alias CF_PLACEHOLDER_RANGE_INFO_CLASS = int;

// Callbacks

alias CF_CALLBACK = void function(const(CF_CALLBACK_INFO)* CallbackInfo, 
                                  const(CF_CALLBACK_PARAMETERS)* CallbackParameters);

// Structs


struct CF_CONNECTION_KEY__
{
    long Internal;
}

struct CF_FS_METADATA
{
    FILE_BASIC_INFO BasicInfo;
    LARGE_INTEGER   FileSize;
}

struct CF_PLACEHOLDER_CREATE_INFO
{
    const(wchar)*  RelativeFileName;
    CF_FS_METADATA FsMetadata;
    void*          FileIdentity;
    uint           FileIdentityLength;
    CF_PLACEHOLDER_CREATE_FLAGS Flags;
    HRESULT        Result;
    long           CreateUsn;
}

struct CF_PROCESS_INFO
{
    uint          StructSize;
    uint          ProcessId;
    const(wchar)* ImagePath;
    const(wchar)* PackageName;
    const(wchar)* ApplicationId;
    const(wchar)* CommandLine;
    uint          SessionId;
}

struct CF_PLATFORM_INFO
{
    uint BuildNumber;
    uint RevisionNumber;
    uint IntegrationNumber;
}

struct CF_HYDRATION_POLICY_PRIMARY_USHORT
{
    ushort us;
}

struct CF_HYDRATION_POLICY_MODIFIER_USHORT
{
    ushort us;
}

struct CF_HYDRATION_POLICY
{
    CF_HYDRATION_POLICY_PRIMARY_USHORT Primary;
    CF_HYDRATION_POLICY_MODIFIER_USHORT Modifier;
}

struct CF_POPULATION_POLICY_PRIMARY_USHORT
{
    ushort us;
}

struct CF_POPULATION_POLICY_MODIFIER_USHORT
{
    ushort us;
}

struct CF_POPULATION_POLICY
{
    CF_POPULATION_POLICY_PRIMARY_USHORT Primary;
    CF_POPULATION_POLICY_MODIFIER_USHORT Modifier;
}

struct CF_SYNC_POLICIES
{
    uint                 StructSize;
    CF_HYDRATION_POLICY  Hydration;
    CF_POPULATION_POLICY Population;
    CF_INSYNC_POLICY     InSync;
    CF_HARDLINK_POLICY   HardLink;
    CF_PLACEHOLDER_MANAGEMENT_POLICY PlaceholderManagement;
}

struct CF_SYNC_REGISTRATION
{
    uint          StructSize;
    const(wchar)* ProviderName;
    const(wchar)* ProviderVersion;
    void*         SyncRootIdentity;
    uint          SyncRootIdentityLength;
    void*         FileIdentity;
    uint          FileIdentityLength;
    GUID          ProviderId;
}

struct CF_CALLBACK_INFO
{
    uint                StructSize;
    CF_CONNECTION_KEY__ ConnectionKey;
    void*               CallbackContext;
    const(wchar)*       VolumeGuidName;
    const(wchar)*       VolumeDosName;
    uint                VolumeSerialNumber;
    LARGE_INTEGER       SyncRootFileId;
    void*               SyncRootIdentity;
    uint                SyncRootIdentityLength;
    LARGE_INTEGER       FileId;
    LARGE_INTEGER       FileSize;
    void*               FileIdentity;
    uint                FileIdentityLength;
    const(wchar)*       NormalizedPath;
    LARGE_INTEGER       TransferKey;
    ubyte               PriorityHint;
    CORRELATION_VECTOR* CorrelationVector;
    CF_PROCESS_INFO*    ProcessInfo;
    LARGE_INTEGER       RequestKey;
}

struct CF_CALLBACK_PARAMETERS
{
    uint ParamSize;
    union
    {
        struct Cancel
        {
            CF_CALLBACK_CANCEL_FLAGS Flags;
            union
            {
                struct FetchData
                {
                    LARGE_INTEGER FileOffset;
                    LARGE_INTEGER Length;
                }
            }
        }
        struct FetchData
        {
            CF_CALLBACK_FETCH_DATA_FLAGS Flags;
            LARGE_INTEGER RequiredFileOffset;
            LARGE_INTEGER RequiredLength;
            LARGE_INTEGER OptionalFileOffset;
            LARGE_INTEGER OptionalLength;
            LARGE_INTEGER LastDehydrationTime;
            CF_CALLBACK_DEHYDRATION_REASON LastDehydrationReason;
        }
        struct ValidateData
        {
            CF_CALLBACK_VALIDATE_DATA_FLAGS Flags;
            LARGE_INTEGER RequiredFileOffset;
            LARGE_INTEGER RequiredLength;
        }
        struct FetchPlaceholders
        {
            CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS Flags;
            const(wchar)* Pattern;
        }
        struct OpenCompletion
        {
            CF_CALLBACK_OPEN_COMPLETION_FLAGS Flags;
        }
        struct CloseCompletion
        {
            CF_CALLBACK_CLOSE_COMPLETION_FLAGS Flags;
        }
        struct Dehydrate
        {
            CF_CALLBACK_DEHYDRATE_FLAGS Flags;
            CF_CALLBACK_DEHYDRATION_REASON Reason;
        }
        struct DehydrateCompletion
        {
            CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS Flags;
            CF_CALLBACK_DEHYDRATION_REASON Reason;
        }
        struct Delete
        {
            CF_CALLBACK_DELETE_FLAGS Flags;
        }
        struct DeleteCompletion
        {
            CF_CALLBACK_DELETE_COMPLETION_FLAGS Flags;
        }
        struct Rename
        {
            CF_CALLBACK_RENAME_FLAGS Flags;
            const(wchar)* TargetPath;
        }
        struct RenameCompletion
        {
            CF_CALLBACK_RENAME_COMPLETION_FLAGS Flags;
            const(wchar)* SourcePath;
        }
    }
}

struct CF_CALLBACK_REGISTRATION
{
    CF_CALLBACK_TYPE Type;
    CF_CALLBACK      Callback;
}

struct CF_SYNC_STATUS
{
    uint StructSize;
    uint Code;
    uint DescriptionOffset;
    uint DescriptionLength;
    uint DeviceIdOffset;
    uint DeviceIdLength;
}

struct CF_OPERATION_INFO
{
    uint                StructSize;
    CF_OPERATION_TYPE   Type;
    CF_CONNECTION_KEY__ ConnectionKey;
    LARGE_INTEGER       TransferKey;
    const(CORRELATION_VECTOR)* CorrelationVector;
    const(CF_SYNC_STATUS)* SyncStatus;
    LARGE_INTEGER       RequestKey;
}

struct CF_OPERATION_PARAMETERS
{
    uint ParamSize;
    union
    {
        struct TransferData
        {
            CF_OPERATION_TRANSFER_DATA_FLAGS Flags;
            NTSTATUS      CompletionStatus;
            void*         Buffer;
            LARGE_INTEGER Offset;
            LARGE_INTEGER Length;
        }
        struct RetrieveData
        {
            CF_OPERATION_RETRIEVE_DATA_FLAGS Flags;
            void*         Buffer;
            LARGE_INTEGER Offset;
            LARGE_INTEGER Length;
            LARGE_INTEGER ReturnedLength;
        }
        struct AckData
        {
            CF_OPERATION_ACK_DATA_FLAGS Flags;
            NTSTATUS      CompletionStatus;
            LARGE_INTEGER Offset;
            LARGE_INTEGER Length;
        }
        struct RestartHydration
        {
            CF_OPERATION_RESTART_HYDRATION_FLAGS Flags;
            const(CF_FS_METADATA)* FsMetadata;
            void* FileIdentity;
            uint  FileIdentityLength;
        }
        struct TransferPlaceholders
        {
            CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS Flags;
            NTSTATUS      CompletionStatus;
            LARGE_INTEGER PlaceholderTotalCount;
            CF_PLACEHOLDER_CREATE_INFO* PlaceholderArray;
            uint          PlaceholderCount;
            uint          EntriesProcessed;
        }
        struct AckDehydrate
        {
            CF_OPERATION_ACK_DEHYDRATE_FLAGS Flags;
            NTSTATUS CompletionStatus;
            void*    FileIdentity;
            uint     FileIdentityLength;
        }
        struct AckRename
        {
            CF_OPERATION_ACK_RENAME_FLAGS Flags;
            NTSTATUS CompletionStatus;
        }
        struct AckDelete
        {
            CF_OPERATION_ACK_DELETE_FLAGS Flags;
            NTSTATUS CompletionStatus;
        }
    }
}

struct CF_FILE_RANGE
{
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER Length;
}

struct CF_PLACEHOLDER_BASIC_INFO
{
    CF_PIN_STATE     PinState;
    CF_IN_SYNC_STATE InSyncState;
    LARGE_INTEGER    FileId;
    LARGE_INTEGER    SyncRootFileId;
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity;
}

struct CF_PLACEHOLDER_STANDARD_INFO
{
    LARGE_INTEGER    OnDiskDataSize;
    LARGE_INTEGER    ValidatedDataSize;
    LARGE_INTEGER    ModifiedDataSize;
    LARGE_INTEGER    PropertiesSize;
    CF_PIN_STATE     PinState;
    CF_IN_SYNC_STATE InSyncState;
    LARGE_INTEGER    FileId;
    LARGE_INTEGER    SyncRootFileId;
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity;
}

struct CF_SYNC_ROOT_BASIC_INFO
{
    LARGE_INTEGER SyncRootFileId;
}

struct CF_SYNC_ROOT_PROVIDER_INFO
{
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    ushort[256] ProviderName;
    ushort[256] ProviderVersion;
}

struct CF_SYNC_ROOT_STANDARD_INFO
{
    LARGE_INTEGER        SyncRootFileId;
    CF_HYDRATION_POLICY  HydrationPolicy;
    CF_POPULATION_POLICY PopulationPolicy;
    CF_INSYNC_POLICY     InSyncPolicy;
    CF_HARDLINK_POLICY   HardLinkPolicy;
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    ushort[256]          ProviderName;
    ushort[256]          ProviderVersion;
    uint                 SyncRootIdentityLength;
    ubyte[1]             SyncRootIdentity;
}

// Functions

@DllImport("cldapi")
HRESULT CfGetPlatformInfo(CF_PLATFORM_INFO* PlatformVersion);

@DllImport("cldapi")
HRESULT CfRegisterSyncRoot(const(wchar)* SyncRootPath, const(CF_SYNC_REGISTRATION)* Registration, 
                           const(CF_SYNC_POLICIES)* Policies, CF_REGISTER_FLAGS RegisterFlags);

@DllImport("cldapi")
HRESULT CfUnregisterSyncRoot(const(wchar)* SyncRootPath);

@DllImport("cldapi")
HRESULT CfConnectSyncRoot(const(wchar)* SyncRootPath, const(CF_CALLBACK_REGISTRATION)* CallbackTable, 
                          void* CallbackContext, CF_CONNECT_FLAGS ConnectFlags, CF_CONNECTION_KEY__* ConnectionKey);

@DllImport("cldapi")
HRESULT CfDisconnectSyncRoot(CF_CONNECTION_KEY__ ConnectionKey);

@DllImport("cldapi")
HRESULT CfGetTransferKey(HANDLE FileHandle, LARGE_INTEGER* TransferKey);

@DllImport("cldapi")
void CfReleaseTransferKey(HANDLE FileHandle, LARGE_INTEGER* TransferKey);

@DllImport("cldapi")
HRESULT CfExecute(const(CF_OPERATION_INFO)* OpInfo, CF_OPERATION_PARAMETERS* OpParams);

@DllImport("cldapi")
HRESULT CfUpdateSyncProviderStatus(CF_CONNECTION_KEY__ ConnectionKey, CF_SYNC_PROVIDER_STATUS ProviderStatus);

@DllImport("cldapi")
HRESULT CfQuerySyncProviderStatus(CF_CONNECTION_KEY__ ConnectionKey, CF_SYNC_PROVIDER_STATUS* ProviderStatus);

@DllImport("cldapi")
HRESULT CfReportSyncStatus(const(wchar)* SyncRootPath, CF_SYNC_STATUS* SyncStatus);

@DllImport("cldapi")
HRESULT CfCreatePlaceholders(const(wchar)* BaseDirectoryPath, char* PlaceholderArray, uint PlaceholderCount, 
                             CF_CREATE_FLAGS CreateFlags, uint* EntriesProcessed);

@DllImport("cldapi")
HRESULT CfOpenFileWithOplock(const(wchar)* FilePath, CF_OPEN_FILE_FLAGS Flags, ptrdiff_t* ProtectedHandle);

@DllImport("cldapi")
ubyte CfReferenceProtectedHandle(HANDLE ProtectedHandle);

@DllImport("cldapi")
HANDLE CfGetWin32HandleFromProtectedHandle(HANDLE ProtectedHandle);

@DllImport("cldapi")
void CfReleaseProtectedHandle(HANDLE ProtectedHandle);

@DllImport("cldapi")
void CfCloseHandle(HANDLE FileHandle);

@DllImport("cldapi")
HRESULT CfConvertToPlaceholder(HANDLE FileHandle, char* FileIdentity, uint FileIdentityLength, 
                               CF_CONVERT_FLAGS ConvertFlags, long* ConvertUsn, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfUpdatePlaceholder(HANDLE FileHandle, const(CF_FS_METADATA)* FsMetadata, char* FileIdentity, 
                            uint FileIdentityLength, char* DehydrateRangeArray, uint DehydrateRangeCount, 
                            CF_UPDATE_FLAGS UpdateFlags, long* UpdateUsn, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfRevertPlaceholder(HANDLE FileHandle, CF_REVERT_FLAGS RevertFlags, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfHydratePlaceholder(HANDLE FileHandle, LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, 
                             CF_HYDRATE_FLAGS HydrateFlags, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfDehydratePlaceholder(HANDLE FileHandle, LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, 
                               CF_DEHYDRATE_FLAGS DehydrateFlags, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfSetPinState(HANDLE FileHandle, CF_PIN_STATE PinState, CF_SET_PIN_FLAGS PinFlags, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfSetInSyncState(HANDLE FileHandle, CF_IN_SYNC_STATE InSyncState, CF_SET_IN_SYNC_FLAGS InSyncFlags, 
                         long* InSyncUsn);

@DllImport("cldapi")
HRESULT CfSetCorrelationVector(HANDLE FileHandle, const(CORRELATION_VECTOR)* CorrelationVector);

@DllImport("cldapi")
HRESULT CfGetCorrelationVector(HANDLE FileHandle, CORRELATION_VECTOR* CorrelationVector);

@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromAttributeTag(uint FileAttributes, uint ReparseTag);

@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFileInfo(void* InfoBuffer, FILE_INFO_BY_HANDLE_CLASS InfoClass);

@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFindData(const(WIN32_FIND_DATAA)* FindData);

@DllImport("cldapi")
HRESULT CfGetPlaceholderInfo(HANDLE FileHandle, CF_PLACEHOLDER_INFO_CLASS InfoClass, char* InfoBuffer, 
                             uint InfoBufferLength, uint* ReturnedLength);

@DllImport("cldapi")
HRESULT CfGetSyncRootInfoByPath(const(wchar)* FilePath, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                uint InfoBufferLength, uint* ReturnedLength);

@DllImport("cldapi")
HRESULT CfGetSyncRootInfoByHandle(HANDLE FileHandle, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

@DllImport("cldapi")
HRESULT CfGetPlaceholderRangeInfo(HANDLE FileHandle, CF_PLACEHOLDER_RANGE_INFO_CLASS InfoClass, 
                                  LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, char* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

@DllImport("cldapi")
HRESULT CfReportProviderProgress(CF_CONNECTION_KEY__ ConnectionKey, LARGE_INTEGER TransferKey, 
                                 LARGE_INTEGER ProviderProgressTotal, LARGE_INTEGER ProviderProgressCompleted);

@DllImport("cldapi")
HRESULT CfReportProviderProgress2(CF_CONNECTION_KEY__ ConnectionKey, LARGE_INTEGER TransferKey, 
                                  LARGE_INTEGER RequestKey, LARGE_INTEGER ProviderProgressTotal, 
                                  LARGE_INTEGER ProviderProgressCompleted, uint TargetSessionId);


