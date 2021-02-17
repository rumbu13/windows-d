// Written in the D programming language.

module windows.cloudfilters;

public import windows.core;
public import windows.com : HRESULT;
public import windows.filesystem : FILE_BASIC_INFO, FILE_INFO_BY_HANDLE_CLASS,
                                   WIN32_FIND_DATAA;
public import windows.systemservices : CORRELATION_VECTOR, HANDLE, LARGE_INTEGER, NTSTATUS,
                                       OVERLAPPED;

extern(Windows):


// Enums


///Flags for creating a placeholder on a per-placeholder basis.
alias CF_PLACEHOLDER_CREATE_FLAGS = int;
enum : int
{
    ///No placeholder create flags.
    CF_PLACEHOLDER_CREATE_FLAG_NONE                         = 0x00000000,
    ///The newly created child placeholder directory is considered to have all of its children present locally.
    ///Applicable to a child placeholder directory only.
    CF_PLACEHOLDER_CREATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000001,
    ///The newly created placeholder is marked as in-sync. Applicable to both placeholder files and directories.
    CF_PLACEHOLDER_CREATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    CF_PLACEHOLDER_CREATE_FLAG_SUPERSEDE                    = 0x00000004,
    CF_PLACEHOLDER_CREATE_FLAG_ALWAYS_FULL                  = 0x00000008,
}

///Current status of a sync provider.
alias CF_SYNC_PROVIDER_STATUS = int;
enum : int
{
    ///The sync provider is disconnected.
    CF_PROVIDER_STATUS_DISCONNECTED       = 0x00000000,
    ///The sync provider is idle.
    CF_PROVIDER_STATUS_IDLE               = 0x00000001,
    ///The sync provider is populating a namespace.
    CF_PROVIDER_STATUS_POPULATE_NAMESPACE = 0x00000002,
    ///The sync provider is populating placeholder metadata.
    CF_PROVIDER_STATUS_POPULATE_METADATA  = 0x00000004,
    ///The sync provider is populating placeholder content.
    CF_PROVIDER_STATUS_POPULATE_CONTENT   = 0x00000008,
    ///The sync provider is incrementally syncing placeholder content.
    CF_PROVIDER_STATUS_SYNC_INCREMENTAL   = 0x00000010,
    ///The sync provider has fully synced placeholder file data.
    CF_PROVIDER_STATUS_SYNC_FULL          = 0x00000020,
    ///The sync provider has lost connectivity.
    CF_PROVIDER_STATUS_CONNECTIVITY_LOST  = 0x00000040,
    ///Clears the flags of the sync provider.
    CF_PROVIDER_STATUS_CLEAR_FLAGS        = 0x80000000,
    CF_PROVIDER_STATUS_TERMINATED         = 0xc0000001,
    CF_PROVIDER_STATUS_ERROR              = 0xc0000002,
}

///Flags for registering and updating a sync root.
alias CF_REGISTER_FLAGS = int;
enum : int
{
    ///No registration flags.
    CF_REGISTER_FLAG_NONE                                 = 0x00000000,
    ///Use this flag for modifying previously registered sync root identities and policies.
    CF_REGISTER_FLAG_UPDATE                               = 0x00000001,
    ///The on-demand directory/folder population behavior is globally controlled by the population policy. This flag
    ///allows a sync provider to opt out of the on-demand population behavior just for the sync root itself while
    ///keeping on-demand population on for all other directories under the sync root. This is useful when the sync
    ///provider would like to pre-populate the immediate child files/directories of the sync root.
    CF_REGISTER_FLAG_DISABLE_ON_DEMAND_POPULATION_ON_ROOT = 0x00000002,
    CF_REGISTER_FLAG_MARK_IN_SYNC_ON_ROOT                 = 0x00000004,
}

///Allows a sync provider to control how placeholder files should be hydrated by the platform. This is the primary
///policy.
alias CF_HYDRATION_POLICY_PRIMARY = int;
enum : int
{
    ///The same behavior as <b>CF_HYDRATION_POLICY_PROGRESSIVE</b>, except that <b>CF_HYDRATION_POLICY_PARTIAL</b> does
    ///not have continuous hydration in the background.
    CF_HYDRATION_POLICY_PARTIAL     = 0x00000000,
    ///When <b>CF_HYDRATION_POLICY_PROGRESSIVE</b> is selected, the platform will allow a placeholder to be dehydrated.
    ///When the platform detects access to a dehydrated placeholder, it will complete the user IO request as soon as it
    ///determines that sufficient data is received from the sync provider. However, the platform will continue
    ///requesting the remaining content in the placeholder from the sync provider in the background until either the
    ///full content of the placeholder is available locally, or the last user handle on the placeholder is closed. <div
    ///class="alert"><b>Note</b> <p class="note">Sync providers who opt in for <b>CF_HYDRATION_POLICY_PROGRESSIVE</b>
    ///may not assume that hydration callbacks arrive sequentially from offset 0. In other words, sync providers with
    ///<b>CF_HYDRATION_POLICY_PROGRESSIVE</b> policy are expected to handle random seeks on the placeholder. </div>
    ///<div> </div>
    CF_HYDRATION_POLICY_PROGRESSIVE = 0x00000001,
    ///When <b>CF_HYDRATION_POLICY_FULL</b> is selected, the platform will allow a placeholder to be dehydrated. When
    ///the platform detects access to a dehydrated placeholder, it will ensure that the full content of the placeholder
    ///is available locally before completing the user IO request, even if the request is only asking for 1 byte.
    CF_HYDRATION_POLICY_FULL        = 0x00000002,
    CF_HYDRATION_POLICY_ALWAYS_FULL = 0x00000003,
}

///Allows a sync provider to control how placeholder files should be hydrated by the platform. This is a modifier that
///can be used with the primary policy: CF_HYDRATION_POLICY_PRIMARY.
alias CF_HYDRATION_POLICY_MODIFIER = int;
enum : int
{
    ///No policy modifier.
    CF_HYDRATION_POLICY_MODIFIER_NONE                     = 0x00000000,
    ///This policy modifier offers two guarantees to a sync provider. First, it guarantees that the data returned by the
    ///sync provider is always persisted to the disk prior to it being returned to the user application. Second, it
    ///allows the sync provider to retrieve the same data it has returned previously to the platform and validate its
    ///integrity. Only upon a successful confirmation of the integrity by the sync provider will the platform complete
    ///the user I/O request. This modifier helps support end-to-end data integrity at the cost of extra disk I/Os.
    CF_HYDRATION_POLICY_MODIFIER_VALIDATION_REQUIRED      = 0x00000001,
    ///This policy modifier grants the platform the permission to not store any data returned by a sync provider on
    ///local disks. This policy modifier is ineffective when being combined with
    ///<b>CF_HYDRATION_POLICY_MODIFIER_VALIDATION_REQUIRED</b>.
    CF_HYDRATION_POLICY_MODIFIER_STREAMING_ALLOWED        = 0x00000002,
    ///<b>Note</b> This value is new for Windows 10, version 1803. This policy modifier grants the platform the
    ///permission to dehydrate in-sync cloud file placeholders without the help of sync providers. Without this flag,
    ///the platform is not allowed to call CfDehydratePlaceholder directly. Instead, the only supported way to dehydrate
    ///a cloud file placeholder is to clear the file’s pinned attribute and set the file’s unpinned attribute. At
    ///that point, the actual dehydration will be performed asynchronously by the sync engine after it receives the
    ///directory change notification on the two attributes. When this flag is specified, the platform will be allowed to
    ///invoke <b>CfDehydratePlaceholder</b> directly on any in-sync cloud file placeholder. It is recommended for sync
    ///providers to support auto-dehydration.
    CF_HYDRATION_POLICY_MODIFIER_AUTO_DEHYDRATION_ALLOWED = 0x00000004,
}

///Allows a sync provider to control how placeholder directories and files should be created by the platform. This is
///the primary policy.
alias CF_POPULATION_POLICY_PRIMARY = int;
enum : int
{
    ///With <b>CF_POPULATION_POLICY_PARTIAL</b> population policy, when the platform detects access on a not fully
    ///populated directory, it will request only the entries required by the user application from the sync provider.
    ///This policy is not currently supported by the platform.
    CF_POPULATION_POLICY_PARTIAL     = 0x00000000,
    ///With <b>CF_POPULATION_POLICY_FULL</b> population policy, when the platform detects access on a not fully
    ///populated directory, it will request the sync provider return all entries under the directory before completing
    ///the user request.
    CF_POPULATION_POLICY_FULL        = 0x00000002,
    CF_POPULATION_POLICY_ALWAYS_FULL = 0x00000003,
}

///Defines the population policy modifiers. This is a modifier that can be used with the primary policy:
///CF_POPULATION_POLICY_PRIMARY.
alias CF_POPULATION_POLICY_MODIFIER = int;
enum : int
{
    CF_POPULATION_POLICY_MODIFIER_NONE = 0x00000000,
}

alias CF_PLACEHOLDER_MANAGEMENT_POLICY = int;
enum : int
{
    CF_PLACEHOLDER_MANAGEMENT_POLICY_DEFAULT                 = 0x00000000,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CREATE_UNRESTRICTED     = 0x00000001,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_CONVERT_TO_UNRESTRICTED = 0x00000002,
    CF_PLACEHOLDER_MANAGEMENT_POLICY_UPDATE_UNRESTRICTED     = 0x00000004,
}

///A policy allowing a sync provider to control when the platform should clear the in-sync state on a placeholder file
///or directory.
alias CF_INSYNC_POLICY = int;
enum : int
{
    ///The default in-sync policy.
    CF_INSYNC_POLICY_NONE                               = 0x00000000,
    ///Clears in-sync state when a file is created.
    CF_INSYNC_POLICY_TRACK_FILE_CREATION_TIME           = 0x00000001,
    ///Clears in-sync state when a file is read-only.
    CF_INSYNC_POLICY_TRACK_FILE_READONLY_ATTRIBUTE      = 0x00000002,
    ///Clears in-sync state when a file is hidden.
    CF_INSYNC_POLICY_TRACK_FILE_HIDDEN_ATTRIBUTE        = 0x00000004,
    ///Clears in-sync state when a file is a system file.
    CF_INSYNC_POLICY_TRACK_FILE_SYSTEM_ATTRIBUTE        = 0x00000008,
    ///Clears in-sync state when a directory is created.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_CREATION_TIME      = 0x00000010,
    ///Clears in-sync state when a directory is read-only.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_READONLY_ATTRIBUTE = 0x00000020,
    ///Clears in-sync state when a directory is hidden.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_HIDDEN_ATTRIBUTE   = 0x00000040,
    ///Clears in-sync state when a directory is a system directory.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_SYSTEM_ATTRIBUTE   = 0x00000080,
    ///Clears in-sync state based on the last write time to a file.
    CF_INSYNC_POLICY_TRACK_FILE_LAST_WRITE_TIME         = 0x00000100,
    ///Clears in-sync state based on the last write time to a directory.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_LAST_WRITE_TIME    = 0x00000200,
    ///Clears in-sync state for any changes to a file.
    CF_INSYNC_POLICY_TRACK_FILE_ALL                     = 0x0055550f,
    ///Clears in-sync state for any changes to a directory.
    CF_INSYNC_POLICY_TRACK_DIRECTORY_ALL                = 0x00aaaaf0,
    ///Clears in-sync state for any changes to a file or directory.
    CF_INSYNC_POLICY_TRACK_ALL                          = 0x00ffffff,
    CF_INSYNC_POLICY_PRESERVE_INSYNC_FOR_SYNC_ENGINE    = 0x80000000,
}

///Specifies whether or not hard links are allowed on placeholder files.
alias CF_HARDLINK_POLICY = int;
enum : int
{
    ///Default; No hard links can be created on any placeholder.
    CF_HARDLINK_POLICY_NONE    = 0x00000000,
    ///Hard links can be created on a placeholder under the same sync root or no sync root.
    CF_HARDLINK_POLICY_ALLOWED = 0x00000001,
}

///Callback flags for canceling data fetching for a placeholder file or folder.
alias CF_CALLBACK_CANCEL_FLAGS = int;
enum : int
{
    ///No cancel flag.
    CF_CALLBACK_CANCEL_FLAG_NONE       = 0x00000000,
    ///Flag to be set if the user request is cancelled as a result of the expiration of the 60 second timer.
    CF_CALLBACK_CANCEL_FLAG_IO_TIMEOUT = 0x00000001,
    CF_CALLBACK_CANCEL_FLAG_IO_ABORTED = 0x00000002,
}

///Callback flags for fetching data for a placeholder file or folder.
alias CF_CALLBACK_FETCH_DATA_FLAGS = int;
enum : int
{
    ///No data fetch flag.
    CF_CALLBACK_FETCH_DATA_FLAG_NONE               = 0x00000000,
    ///Flag to be used if the callback is invoked as a result of previously interrupted hydration process.
    CF_CALLBACK_FETCH_DATA_FLAG_RECOVERY           = 0x00000001,
    CF_CALLBACK_FETCH_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}

///Flags to validate the data of a placeholder file or directory.
alias CF_CALLBACK_VALIDATE_DATA_FLAGS = int;
enum : int
{
    ///No data validation flag.
    CF_CALLBACK_VALIDATE_DATA_FLAG_NONE               = 0x00000000,
    CF_CALLBACK_VALIDATE_DATA_FLAG_EXPLICIT_HYDRATION = 0x00000002,
}

///Flags for fetching information about the content of a placeholder file or directory.
alias CF_CALLBACK_FETCH_PLACEHOLDERS_FLAGS = int;
enum : int
{
    CF_CALLBACK_FETCH_PLACEHOLDERS_FLAG_NONE = 0x00000000,
}

///Callback flags for notifying a sync provider that a placeholder was successfully opened for read/write/delete access.
alias CF_CALLBACK_OPEN_COMPLETION_FLAGS = int;
enum : int
{
    ///No open completion flag.
    CF_CALLBACK_OPEN_COMPLETION_FLAG_NONE                    = 0x00000000,
    ///A flag set if the placeholder metadata is corrupted.
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNKNOWN     = 0x00000001,
    CF_CALLBACK_OPEN_COMPLETION_FLAG_PLACEHOLDER_UNSUPPORTED = 0x00000002,
}

///Callback flags for notifying a sync provider that a placeholder under one of its sync roots that has been previously
///opened for read/write/delete access is now closed.
alias CF_CALLBACK_CLOSE_COMPLETION_FLAGS = int;
enum : int
{
    ///No close completion flags.
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_NONE    = 0x00000000,
    CF_CALLBACK_CLOSE_COMPLETION_FLAG_DELETED = 0x00000001,
}

///Callback flags for notifying a sync provider that a placeholder under one of its sync root is going to be dehydrated.
alias CF_CALLBACK_DEHYDRATE_FLAGS = int;
enum : int
{
    ///No dehydrate flag.
    CF_CALLBACK_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_CALLBACK_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}

///A callback flag to inform the sync provider that a placeholder under one of its sync roots has been successfully
///dehydrated.
alias CF_CALLBACK_DEHYDRATE_COMPLETION_FLAGS = int;
enum : int
{
    ///No dehydration completion flag.
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_NONE       = 0x00000000,
    ///A flag set if the dehydration request is initiated by a system background service.
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_BACKGROUND = 0x00000001,
    CF_CALLBACK_DEHYDRATE_COMPLETION_FLAG_DEHYDRATED = 0x00000002,
}

///This callback is used to inform the sync provider that a placeholder file or directory under one of its sync roots is
///about to be deleted.
alias CF_CALLBACK_DELETE_FLAGS = int;
enum : int
{
    ///No delete flag.
    CF_CALLBACK_DELETE_FLAG_NONE         = 0x00000000,
    CF_CALLBACK_DELETE_FLAG_IS_DIRECTORY = 0x00000001,
    CF_CALLBACK_DELETE_FLAG_IS_UNDELETE  = 0x00000002,
}

///Callback flags for notifying a sync provider that a placeholder was successfully deleted.
alias CF_CALLBACK_DELETE_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_DELETE_COMPLETION_FLAG_NONE = 0x00000000,
}

///Call back flags to inform the sync provider that a placeholder under one of its sync roots is about to be renamed or
///moved.
alias CF_CALLBACK_RENAME_FLAGS = int;
enum : int
{
    ///No rename flag.
    CF_CALLBACK_RENAME_FLAG_NONE            = 0x00000000,
    ///Flag set if the placeholder is a directory.
    CF_CALLBACK_RENAME_FLAG_IS_DIRECTORY    = 0x00000001,
    ///Flag set if the link to be renamed or moved is within a sync root managed by the sync process.
    CF_CALLBACK_RENAME_FLAG_SOURCE_IN_SCOPE = 0x00000002,
    CF_CALLBACK_RENAME_FLAG_TARGET_IN_SCOPE = 0x00000004,
}

///A callback flag to inform the sync provider that a placeholder under one of its sync roots has been successfully
///renamed.
alias CF_CALLBACK_RENAME_COMPLETION_FLAGS = int;
enum : int
{
    CF_CALLBACK_RENAME_COMPLETION_FLAG_NONE = 0x00000000,
}

alias CF_CALLBACK_DEHYDRATION_REASON = int;
enum : int
{
    CF_CALLBACK_DEHYDRATION_REASON_NONE              = 0x00000000,
    CF_CALLBACK_DEHYDRATION_REASON_USER_MANUAL       = 0x00000001,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_LOW_SPACE  = 0x00000002,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_INACTIVITY = 0x00000003,
    CF_CALLBACK_DEHYDRATION_REASON_SYSTEM_OS_UPGRADE = 0x00000004,
}

///Contains the various types of callbacks used on placeholder files or folders.
alias CF_CALLBACK_TYPE = int;
enum : int
{
    ///Callback to satisfy an I/O request, or a placeholder hydration request.
    CF_CALLBACK_TYPE_FETCH_DATA                   = 0x00000000,
    ///Callback to validate placeholder data.
    CF_CALLBACK_TYPE_VALIDATE_DATA                = 0x00000001,
    ///Callback to cancel an ongoing placeholder hydration.
    CF_CALLBACK_TYPE_CANCEL_FETCH_DATA            = 0x00000002,
    ///Callback to request information about the contents of placeholder files.
    CF_CALLBACK_TYPE_FETCH_PLACEHOLDERS           = 0x00000003,
    ///Callback to cancel a request for the contents of placeholder files.
    CF_CALLBACK_TYPE_CANCEL_FETCH_PLACEHOLDERS    = 0x00000004,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots has been successfully opened
    ///for read/write/delete access.
    CF_CALLBACK_TYPE_NOTIFY_FILE_OPEN_COMPLETION  = 0x00000005,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots that has been previously
    ///opened for read/write/delete access is now closed.
    CF_CALLBACK_TYPE_NOTIFY_FILE_CLOSE_COMPLETION = 0x00000006,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots is about to be dehydrated.
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE             = 0x00000007,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots has been successfully
    ///dehydrated.
    CF_CALLBACK_TYPE_NOTIFY_DEHYDRATE_COMPLETION  = 0x00000008,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots is about to be deleted.
    CF_CALLBACK_TYPE_NOTIFY_DELETE                = 0x00000009,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots has been successfully
    ///deleted.
    CF_CALLBACK_TYPE_NOTIFY_DELETE_COMPLETION     = 0x0000000a,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots is about to be renamed or
    ///moved.
    CF_CALLBACK_TYPE_NOTIFY_RENAME                = 0x0000000b,
    ///Callback to inform the sync provider that a placeholder under one of its sync roots has been successfully renamed
    ///or moved.
    CF_CALLBACK_TYPE_NOTIFY_RENAME_COMPLETION     = 0x0000000c,
    ///No callback type.
    CF_CALLBACK_TYPE_NONE                         = 0xffffffff,
}

///Additional information that can be requested by a sync provider when its callbacks are invoked.
alias CF_CONNECT_FLAGS = int;
enum : int
{
    ///No connection flags.
    CF_CONNECT_FLAG_NONE                          = 0x00000000,
    ///When this flag is specified, the platform returns the full image path of the hydrating process in the callback
    ///parameters.
    CF_CONNECT_FLAG_REQUIRE_PROCESS_INFO          = 0x00000002,
    ///When this flag is specified, the platform returns the full path of the placeholder being requested in the
    ///callback parameters.
    CF_CONNECT_FLAG_REQUIRE_FULL_FILE_PATH        = 0x00000004,
    CF_CONNECT_FLAG_BLOCK_SELF_IMPLICIT_HYDRATION = 0x00000008,
}

///The types of operations that can be performed on placeholder files and directories.
alias CF_OPERATION_TYPE = int;
enum : int
{
    ///Transfers data to hydrate a placeholder.
    CF_OPERATION_TYPE_TRANSFER_DATA         = 0x00000000,
    ///Validates the integrity of data previously transferred to a placeholder.
    CF_OPERATION_TYPE_RETRIEVE_DATA         = 0x00000001,
    ///Data is acknowledged by the sync provider.
    CF_OPERATION_TYPE_ACK_DATA              = 0x00000002,
    ///Restarts ongoing data hydration.
    CF_OPERATION_TYPE_RESTART_HYDRATION     = 0x00000003,
    ///Transfers placeholders.
    CF_OPERATION_TYPE_TRANSFER_PLACEHOLDERS = 0x00000004,
    ///Acknowledge and dehydrate a placeholder.
    CF_OPERATION_TYPE_ACK_DEHYDRATE         = 0x00000005,
    ///Acknowledge and delete a placeholder.
    CF_OPERATION_TYPE_ACK_DELETE            = 0x00000006,
    CF_OPERATION_TYPE_ACK_RENAME            = 0x00000007,
}

///Flags to transfer data to hydrate a placeholder file or folder.
alias CF_OPERATION_TRANSFER_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_TRANSFER_DATA_FLAG_NONE = 0x00000000,
}

///Flags to retrieve data for a placeholder file or folder.
alias CF_OPERATION_RETRIEVE_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_RETRIEVE_DATA_FLAG_NONE = 0x00000000,
}

///Flags to verify and acknowledge data for a placeholder file or folder.
alias CF_OPERATION_ACK_DATA_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DATA_FLAG_NONE = 0x00000000,
}

///Flags to restart data hydration on a placeholder file or folder.
alias CF_OPERATION_RESTART_HYDRATION_FLAGS = int;
enum : int
{
    ///No restart data hydration flag.
    CF_OPERATION_RESTART_HYDRATION_FLAG_NONE         = 0x00000000,
    CF_OPERATION_RESTART_HYDRATION_FLAG_MARK_IN_SYNC = 0x00000001,
}

///Flags to specify the behavior when transferring a placeholder file or directory.
alias CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAGS = int;
enum : int
{
    ///No transfer placeholder flags.
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_NONE                         = 0x00000000,
    ///Causes the API to return immediately if a placeholder transfer fails. If a transfer fails, the error code will be
    ///returned.
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_STOP_ON_ERROR                = 0x00000001,
    CF_OPERATION_TRANSFER_PLACEHOLDERS_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000002,
}

///Flags to acknowledge the dehydration of a placeholder file or directory.
alias CF_OPERATION_ACK_DEHYDRATE_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DEHYDRATE_FLAG_NONE = 0x00000000,
}

///Flags for acknowledging placeholder file or directory renaming.
alias CF_OPERATION_ACK_RENAME_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_RENAME_FLAG_NONE = 0x00000000,
}

///Flags to acknowledge the deletion of a placeholder file or directory.
alias CF_OPERATION_ACK_DELETE_FLAGS = int;
enum : int
{
    CF_OPERATION_ACK_DELETE_FLAG_NONE = 0x00000000,
}

///Flags for creating a placeholder file or directory.
alias CF_CREATE_FLAGS = int;
enum : int
{
    ///Default mode. All entries are processed.
    CF_CREATE_FLAG_NONE          = 0x00000000,
    CF_CREATE_FLAG_STOP_ON_ERROR = 0x00000001,
}

///Flags to request various permissions on opening a file.
alias CF_OPEN_FILE_FLAGS = int;
enum : int
{
    ///No open file flags.
    CF_OPEN_FILE_FLAG_NONE          = 0x00000000,
    ///When specified, CfOpenFileWithOplock returns a share-none handle and requests an RH
    ///(OPLOCK_LEVEL_CACHE_READ|OPLOCK_LEVEL_CACHE_HANDLE) oplock on the file.
    CF_OPEN_FILE_FLAG_EXCLUSIVE     = 0x00000001,
    ///When specified, CfOpenFileWithOplock attempts to open the file or directory with
    ///FILE_READ_DATA/FILE_LIST_DIRECTORY and FILE_WRITE_DATA/FILE_ADD_FILE access; otherwise it attempts to open the
    ///file or directory with FILE_READ_DATA/ FILE_LIST_DIRECTORY.
    CF_OPEN_FILE_FLAG_WRITE_ACCESS  = 0x00000002,
    ///When specified, CfOpenFileWithOplock attempts to open the file or directory with DELETE access; otherwise it
    ///opens the file normally.
    CF_OPEN_FILE_FLAG_DELETE_ACCESS = 0x00000004,
    CF_OPEN_FILE_FLAG_FOREGROUND    = 0x00000008,
}

///Normal file/directory to placeholder file/directory conversion flags.
alias CF_CONVERT_FLAGS = int;
enum : int
{
    ///No conversion flags.
    CF_CONVERT_FLAG_NONE                        = 0x00000000,
    ///The platform marks the converted placeholder as in sync with cloud upon a successful conversion of the file.
    CF_CONVERT_FLAG_MARK_IN_SYNC                = 0x00000001,
    ///Applicable to files only. When specified, the platform dehydrates the file after converting it to a placeholder
    ///successfully. The caller must acquire an exclusive handle when specifying this flag or data corruptions can
    ///occur. Note that the platform does not validate the exclusiveness of the handle.
    CF_CONVERT_FLAG_DEHYDRATE                   = 0x00000002,
    CF_CONVERT_FLAG_ENABLE_ON_DEMAND_POPULATION = 0x00000004,
    CF_CONVERT_FLAG_ALWAYS_FULL                 = 0x00000008,
}

///Flags for updating a placeholder file or directory.
alias CF_UPDATE_FLAGS = int;
enum : int
{
    ///No update flags.
    CF_UPDATE_FLAG_NONE                         = 0x00000000,
    ///The update will fail if the <b>CF_UPDATE_FLAG_MARK_IN_SYNC</b> attribute is not currently set on the placeholder.
    ///This is to prevent a race between syncing changes from the cloud down to a local placeholder and the
    ///placeholder’s data stream getting locally modified.
    CF_UPDATE_FLAG_VERIFY_IN_SYNC               = 0x00000001,
    ///The platform marks the placeholder as in-sync upon a successful update placeholder operation.
    CF_UPDATE_FLAG_MARK_IN_SYNC                 = 0x00000002,
    ///Applicable to files only. When specified, the platform dehydrates the file after updating the placeholder
    ///successfully. The caller must acquire an exclusive handle when specifying this flag or data corruptions can
    ///occur. Note that the platform does not validate the exclusiveness of the handle.
    CF_UPDATE_FLAG_DEHYDRATE                    = 0x00000004,
    ///Applicable to directories only. When specified, it marks the updated placeholder directory partially populated
    ///such that any future access to it will result in a FETCH_PLACEHOLDERS callback sent to the sync provider.
    CF_UPDATE_FLAG_ENABLE_ON_DEMAND_POPULATION  = 0x00000008,
    ///Applicable to directories only. When specified, it marks the updated placeholder directory fully populated such
    ///that any future access to it will be handled by the platform without any callbacks to the sync provider.
    CF_UPDATE_FLAG_DISABLE_ON_DEMAND_POPULATION = 0x00000010,
    ///When specified, <i>FileIdentity</i> and <i>FileIdentityLength</i> in CfUpdatePlaceholder are ignored and the
    ///platform will remove the existing file identity blob on the placeholder upon a successful update call.
    CF_UPDATE_FLAG_REMOVE_FILE_IDENTITY         = 0x00000020,
    ///The platform marks the placeholder as not in-sync upon a successful update placeholder operation.
    CF_UPDATE_FLAG_CLEAR_IN_SYNC                = 0x00000040,
    ///<b>Note</b> This value is new for Windows 10, version 1803. The platform removes all existing extrinsic
    ///properties on the placeholder.
    CF_UPDATE_FLAG_REMOVE_PROPERTY              = 0x00000080,
    CF_UPDATE_FLAG_PASSTHROUGH_FS_METADATA      = 0x00000100,
    CF_UPDATE_FLAG_ALWAYS_FULL                  = 0x00000200,
    CF_UPDATE_FLAG_ALLOW_PARTIAL                = 0x00000400,
}

///Flags for reverting a placeholder file to a regular file.
alias CF_REVERT_FLAGS = int;
enum : int
{
    CF_REVERT_FLAG_NONE = 0x00000000,
}

///Placeholder data hydration flags.
alias CF_HYDRATE_FLAGS = int;
enum : int
{
    CF_HYDRATE_FLAG_NONE = 0x00000000,
}

///Placeholder dehydration flags.
alias CF_DEHYDRATE_FLAGS = int;
enum : int
{
    ///No dehydration flags.
    CF_DEHYDRATE_FLAG_NONE       = 0x00000000,
    CF_DEHYDRATE_FLAG_BACKGROUND = 0x00000001,
}

///Pin states of a placeholder file or directory.
alias CF_PIN_STATE = int;
enum : int
{
    ///The platform can decide freely when the placeholder’s content needs to present or absent locally on the disk.
    CF_PIN_STATE_UNSPECIFIED = 0x00000000,
    ///The sync provider will be notified to fetch the placeholder’s content asynchronously after the pin request is
    ///received by the platform. There is no guarantee that the placeholders to be pinned will be fully available
    ///locally after a CfSetPinState call completes successfully. However, the platform will fail any dehydration
    ///request on pinned placeholders.
    CF_PIN_STATE_PINNED      = 0x00000001,
    ///The sync provider will be notified to dehydrate/invalidate the placeholder’s content on-disk asynchronously
    ///after the unpin request is received by the platform. There is no guarantee that the placeholders to be unpinned
    ///will be fully dehydrated after the API call completes successfully.
    CF_PIN_STATE_UNPINNED    = 0x00000002,
    ///the placeholder will never be synced to the cloud by the sync provider. This state can only be set by the sync
    ///provider.
    CF_PIN_STATE_EXCLUDED    = 0x00000003,
    ///The platform treats it as if the caller performs a move operation on the placeholder and hence re-evaluates the
    ///placeholder’s pin state based on its parent’s pin state. See the Remarks section for an inheritance table.
    CF_PIN_STATE_INHERIT     = 0x00000004,
}

///The placeholder pin flags.
alias CF_SET_PIN_FLAGS = int;
enum : int
{
    ///No pin flag.
    CF_SET_PIN_FLAG_NONE                  = 0x00000000,
    ///The platform applies the pin state to the placeholder <i>FileHandle</i> and every file recursively beneath it
    ///(relevant only if <i>FileHandle</i> is a handle to a directory).
    CF_SET_PIN_FLAG_RECURSE               = 0x00000001,
    ///The platform applies the pin state to every file recursively beneath the placeholder <i>FileHandle</i>, but not
    ///to <i>FileHandle</i> itself.
    CF_SET_PIN_FLAG_RECURSE_ONLY          = 0x00000002,
    CF_SET_PIN_FLAG_RECURSE_STOP_ON_ERROR = 0x00000004,
}

///Specifies the in-sync state for placeholder files and folders.
alias CF_IN_SYNC_STATE = int;
enum : int
{
    ///The platform clears the placeholder’s in-sync state upon a successful return from the CfSetInSyncState call.
    CF_IN_SYNC_STATE_NOT_IN_SYNC = 0x00000000,
    CF_IN_SYNC_STATE_IN_SYNC     = 0x00000001,
}

///The in-sync state flags for placeholder files and folders.
alias CF_SET_IN_SYNC_FLAGS = int;
enum : int
{
    CF_SET_IN_SYNC_FLAG_NONE = 0x00000000,
}

///The state of a placeholder file or folder.
alias CF_PLACEHOLDER_STATE = int;
enum : int
{
    ///When returned, the file or directory whose <i>FileAttributes</i> and <i>ReparseTag</i> examined by the API is not
    ///a placeholder.
    CF_PLACEHOLDER_STATE_NO_STATES              = 0x00000000,
    ///The file or directory whose <i>FileAttributes</i> and <i>ReparseTag</i> examined by the API is a placeholder.
    CF_PLACEHOLDER_STATE_PLACEHOLDER            = 0x00000001,
    ///The directory is both a placeholder directory as well as the sync root.
    CF_PLACEHOLDER_STATE_SYNC_ROOT              = 0x00000002,
    ///The file or directory must be a placeholder and there exists an essential property in the property store of the
    ///file or directory.
    CF_PLACEHOLDER_STATE_ESSENTIAL_PROP_PRESENT = 0x00000004,
    ///The file or directory must be a placeholder and its content in sync with the cloud.
    CF_PLACEHOLDER_STATE_IN_SYNC                = 0x00000008,
    ///The file or directory must be a placeholder and its content is not ready to be consumed by the user application,
    ///though it may or may not be fully present locally. An example is a placeholder file whose content has been fully
    ///downloaded to the local disk, but is yet to be validated by a sync provider that has registered the sync root
    ///with the hydration modifier VERIFICATION_REQUIRED.
    CF_PLACEHOLDER_STATE_PARTIAL                = 0x00000010,
    ///The file or directory must be a placeholder and its content is not fully present locally. When this is set,
    ///<b>CF_PLACEHOLDER_STATE_PARTIAL</b> must also be set.
    CF_PLACEHOLDER_STATE_PARTIALLY_ON_DISK      = 0x00000020,
    ///This is an invalid state when the API fails to parse the information of the file or directory.
    CF_PLACEHOLDER_STATE_INVALID                = 0xffffffff,
}

///Information classes for placeholder info.
alias CF_PLACEHOLDER_INFO_CLASS = int;
enum : int
{
    ///Basic placeholder information. See CF_PLACEHOLDER_BASIC_INFO.
    CF_PLACEHOLDER_INFO_BASIC    = 0x00000000,
    CF_PLACEHOLDER_INFO_STANDARD = 0x00000001,
}

///Types of sync root information.
alias CF_SYNC_ROOT_INFO_CLASS = int;
enum : int
{
    ///Basic sync root information. See CF_SYNC_ROOT_BASIC_INFO.
    CF_SYNC_ROOT_INFO_BASIC    = 0x00000000,
    ///Standard sync root information. See CF_SYNC_ROOT_STANDARD_INFO.
    CF_SYNC_ROOT_INFO_STANDARD = 0x00000001,
    CF_SYNC_ROOT_INFO_PROVIDER = 0x00000002,
}

///Types of the range of placeholder file data.
alias CF_PLACEHOLDER_RANGE_INFO_CLASS = int;
enum : int
{
    ///On-disk data is data that is physical present in the file, which is a super set of other types of ranges.
    CF_PLACEHOLDER_RANGE_INFO_ONDISK    = 0x00000001,
    ///Validated data is a subset of the on-disk data that is currently in sync with the cloud.
    CF_PLACEHOLDER_RANGE_INFO_VALIDATED = 0x00000002,
    CF_PLACEHOLDER_RANGE_INFO_MODIFIED  = 0x00000003,
}

// Callbacks

alias CF_CALLBACK = void function(const(CF_CALLBACK_INFO)* CallbackInfo, 
                                  const(CF_CALLBACK_PARAMETERS)* CallbackParameters);

// Structs


struct CF_CONNECTION_KEY__
{
    long Internal;
}

///Placeholder file or directory metadata.
struct CF_FS_METADATA
{
    ///Basic file information.
    FILE_BASIC_INFO BasicInfo;
    LARGE_INTEGER   FileSize;
}

///Contains placeholder information for creating new placeholder files or directories.
struct CF_PLACEHOLDER_CREATE_INFO
{
    ///The name of the child placeholder file or directory to be created. This parameter must not contain a relative
    ///path or else CfCreatePlaceholders will fail with ERROR_CLOUD_FILE_INVALID_REQUEST. For example if the sync root
    ///of the provider is c:\SyncRoot and a placeholder named "pl.txt" is being created in a child directory of the sync
    ///root such as c:\SyncRoot\ChildDir, then BaseDirectoryPath = c:\SyncRoot\ChildDir and RelativeFileName = pl.txt is
    ///expected. It is an error to specify BaseDirectoryPath = c:\SyncRoot and RelativeFileName = ChildDir\pl.txt.
    const(wchar)*  RelativeFileName;
    ///File system metadata to be created with the placeholder.
    CF_FS_METADATA FsMetadata;
    ///A user mode buffer containing file information supplied by the sync provider. This is required for files (not for
    ///directories).
    void*          FileIdentity;
    ///Length, in bytes, of the <b>FileIdentity</b>.
    uint           FileIdentityLength;
    ///Flags for specifying placeholder creation behavior.
    CF_PLACEHOLDER_CREATE_FLAGS Flags;
    ///The result of placeholder creation. On successful creation, the value is: STATUS_OK.
    HRESULT        Result;
    long           CreateUsn;
}

///Contains information about a user process.
struct CF_PROCESS_INFO
{
    ///The size of the structure.
    uint          StructSize;
    ///The 32 bit ID of the user process.
    uint          ProcessId;
    ///The absolute path of the main executable file including the volume name in the format of NT file path. If the
    ///platform failed to retrieve the image path, “UNKNOWN” will be returned.
    const(wchar)* ImagePath;
    ///Used for modern applications. The app package name.
    const(wchar)* PackageName;
    ///Used for modern applications. The application ID.
    const(wchar)* ApplicationId;
    ///<b>Note</b> This member was added in Windows 10, version 1803. Used to start the process. If the platform failed
    ///to retrieve the command line, “UNKNOWN” will be returned.
    const(wchar)* CommandLine;
    uint          SessionId;
}

///Returns information for the cloud files platform. This is intended for sync providers running on multiple versions of
///Windows.
struct CF_PLATFORM_INFO
{
    ///The build number of the Windows platform version. Changes when the platform is serviced by a Windows update.
    uint BuildNumber;
    ///The revision number of the Windows platform version. Changes when the platform is serviced by a Windows update.
    uint RevisionNumber;
    ///The integration number of the Windows platform version. This is indicative of the platform capabilities, both in
    ///terms of API contracts and availability of bug fixes.
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

///Specifies the primary hydration policy and its modifier.
struct CF_HYDRATION_POLICY
{
    ///The primary hydration policy.
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

///Specifies the primary population policy and its modifier.
struct CF_POPULATION_POLICY
{
    ///The primary population policy.
    CF_POPULATION_POLICY_PRIMARY_USHORT Primary;
    CF_POPULATION_POLICY_MODIFIER_USHORT Modifier;
}

///Defines the sync policies used by a sync root.
struct CF_SYNC_POLICIES
{
    ///The size of the CF_SYNC_POLICIES structure.
    uint                 StructSize;
    ///The hydration policy.
    CF_HYDRATION_POLICY  Hydration;
    ///The population policy.
    CF_POPULATION_POLICY Population;
    ///The in-sync policy.
    CF_INSYNC_POLICY     InSync;
    CF_HARDLINK_POLICY   HardLink;
    CF_PLACEHOLDER_MANAGEMENT_POLICY PlaceholderManagement;
}

///The details of the sync provider and sync root to be registered.
struct CF_SYNC_REGISTRATION
{
    ///The size of the structure.
    uint          StructSize;
    ///The name of the sync provider. This is a user friendly string with a maximum length of 255 characters.
    const(wchar)* ProviderName;
    ///The version of the sync provider. This is a user friendly string with a maximum length of 255 characters.
    const(wchar)* ProviderVersion;
    ///The sync root identity used by the provider. This member is optional with a maximum size of 64 KB.
    void*         SyncRootIdentity;
    ///The length of the <b>SyncRootIdentity</b>. This member is optional and is only used if a <b>SyncRootIdentity</b>
    ///is provided.
    uint          SyncRootIdentityLength;
    ///An optional file identity. This member has a maximum size of 4 KB.
    void*         FileIdentity;
    ///The length of the file identity.
    uint          FileIdentityLength;
    GUID          ProviderId;
}

///Contains common callback information.
struct CF_CALLBACK_INFO
{
    ///The size of the structure.
    uint                StructSize;
    ///An opaque handle created by CfConnectSyncRoot for a sync root managed by the sync provider.
    CF_CONNECTION_KEY__ ConnectionKey;
    ///points to an opaque blob that the sync provider provides at the sync root connect time.
    void*               CallbackContext;
    ///GUID name of the volume on which the placeholder file/directory to be serviced resides. It is in the form:
    ///“\\?\Volume{GUID}”.
    const(wchar)*       VolumeGuidName;
    ///DOS drive letter of the volume in the form of “X:” where X is the drive letter.
    const(wchar)*       VolumeDosName;
    ///The serial number of the volume.
    uint                VolumeSerialNumber;
    ///A 64 bit file system maintained volume-wide unique ID of the sync root under which the placeholder file/directory
    ///to be serviced resides.
    LARGE_INTEGER       SyncRootFileId;
    ///Points to the opaque blob provided by the sync provider at the sync root registration time.
    void*               SyncRootIdentity;
    ///The length, in bytes, of the <b>SyncRootIdentity</b>.
    uint                SyncRootIdentityLength;
    ///A 64 bit file system maintained, volume-wide unique ID of the placeholder file/directory to be serviced.
    LARGE_INTEGER       FileId;
    ///The logical size of the placeholder file to be serviced. It is always 0 if the subject of the callback is a
    ///directory.
    LARGE_INTEGER       FileSize;
    ///Points to the opaque blob that the sync provider provides at the placeholder creation/conversion/update time.
    void*               FileIdentity;
    ///The length, in bytes, of <b>FileIdentity</b>.
    uint                FileIdentityLength;
    ///The absolute path of the placeholder file/directory to be serviced on the volume identified by
    ///VolumeGuidName/VolumeDosName. It starts from the root directory of the volume. See the Remarks section for more
    ///details.
    const(wchar)*       NormalizedPath;
    ///An opaque handle to the placeholder file/directory to be serviced. The sync provider must pass it back to the
    ///CfExecute call in order to perform the desired operation on the file/directory.
    LARGE_INTEGER       TransferKey;
    ///A numeric scale given to the sync provider to describe the relative priority of one fetch compared to another
    ///fetch, in order to provide the most responsive experience to the user. The values range from 0 (lowest possible
    ///priority) to 15 (highest possible priority).
    ubyte               PriorityHint;
    ///An optional correlation vector.
    CORRELATION_VECTOR* CorrelationVector;
    ///Points to a structure that contains the information about the user process that triggers this callback.
    CF_PROCESS_INFO*    ProcessInfo;
    LARGE_INTEGER       RequestKey;
}

///Contains callback specific parameters such as file offset, length, flags, etc.
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

///The callbacks to be registered by the sync provider.
struct CF_CALLBACK_REGISTRATION
{
    ///The type of callback to be registered.
    CF_CALLBACK_TYPE Type;
    ///A pointer to the callback function.
    CF_CALLBACK      Callback;
}

///Used in a CF_OPERATION_INFO structure to describe the status of a specified sync root.
struct CF_SYNC_STATUS
{
    ///The size, in bytes, of the sync status structure, including the actual description string.
    uint StructSize;
    ///The use of this parameter is completely up to the sync provider that supports this rich sync status construct.
    ///For a particular sync provider, it is expected that there is a 1:1 mapping between the code and the description
    ///string. It is recommended that you use the highest bit order to describe the type of error code: 1 for an
    ///error-level code, and 0 for an information-level code. <div class="alert"><b>Note</b> <b>Code</b> is opaque to
    ///the platform, and is used only for tracking purposes.</div> <div> </div>
    uint Code;
    ///The offset of the description string relative to the start of <b>CF_SYNC_STATUS</b>. It points to a localized
    ///null-terminated wide string that is expected to contain more meaningful and actionable information about the file
    ///in question. Sync providers are expected to balance the requirement of providing more actionable information and
    ///maintaining an as small as possible memory footprint.
    uint DescriptionOffset;
    ///The size of the description string, in bytes, that includes the null terminator.
    uint DescriptionLength;
    uint DeviceIdOffset;
    uint DeviceIdLength;
}

///Information about an operation on a placeholder file or folder.
struct CF_OPERATION_INFO
{
    ///The size of the structure.
    uint                StructSize;
    ///The type of operation performed.
    CF_OPERATION_TYPE   Type;
    ///A connection key obtained for the communication channel.
    CF_CONNECTION_KEY__ ConnectionKey;
    ///An opaque handle to the placeholder.
    LARGE_INTEGER       TransferKey;
    ///A correlation vector on a placeholder used for telemetry purposes.
    const(CORRELATION_VECTOR)* CorrelationVector;
    ///<b>Note</b> This member is new for Windows 10, version 1803. The current sync status of the platform. The
    ///platform queries this information upon any failed operations on a cloud file placeholder. If a structure is
    ///available, the platform will use the information provided to construct a more meaningful and actionable message
    ///to the user. The platform will keep this information on the file until the last handle on it goes away. If
    ///<b>null</b>, the platform will clear the previously set sync status, if there is one.
    const(CF_SYNC_STATUS)* SyncStatus;
    LARGE_INTEGER       RequestKey;
}

///Parameters of an operation on a placeholder file or folder.
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

///Specifies a range of data in a placeholder file.
struct CF_FILE_RANGE
{
    ///The offset of the starting point of the data.
    LARGE_INTEGER StartingOffset;
    LARGE_INTEGER Length;
}

///Basic placeholder information.
struct CF_PLACEHOLDER_BASIC_INFO
{
    ///The pin state of the placeholder. See CfSetPinState for more details.
    CF_PIN_STATE     PinState;
    ///The in-sync state of the placeholder. see CfSetInSyncState for more details.
    CF_IN_SYNC_STATE InSyncState;
    ///A 64-bit volume wide non-volatile number that uniquely identifies a file or directory.
    LARGE_INTEGER    FileId;
    ///The file ID of the sync root directory that contains the file whose placeholder information is to be queried.
    LARGE_INTEGER    SyncRootFileId;
    ///Length, in bytes, of the FileIdentity.
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity;
}

///Standard placeholder information.
struct CF_PLACEHOLDER_STANDARD_INFO
{
    ///Total number of bytes on disk.
    LARGE_INTEGER    OnDiskDataSize;
    ///Total number of bytes in sync with the cloud.
    LARGE_INTEGER    ValidatedDataSize;
    ///Total number of bytes that have been overwritten/appended locally that are not in sync with the cloud.
    LARGE_INTEGER    ModifiedDataSize;
    ///Total number of bytes on disk that are used by all the property blobs.
    LARGE_INTEGER    PropertiesSize;
    ///The pin state of the placeholder. See CfSetPinState for more details.
    CF_PIN_STATE     PinState;
    ///The in-sync state of the placeholder. see CfSetInSyncState for more details.
    CF_IN_SYNC_STATE InSyncState;
    ///A 64-bit volume wide non-volatile number that uniquely identifies a file or directory.
    LARGE_INTEGER    FileId;
    ///The file ID of the sync root directory that contains the file whose placeholder information is to be queried.
    LARGE_INTEGER    SyncRootFileId;
    ///Length, in bytes, of the FileIdentity.
    uint             FileIdentityLength;
    ubyte[1]         FileIdentity;
}

///Basic sync root information.
struct CF_SYNC_ROOT_BASIC_INFO
{
    LARGE_INTEGER SyncRootFileId;
}

///Sync root provider information.
struct CF_SYNC_ROOT_PROVIDER_INFO
{
    ///Status of the sync root provider.
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    ///Name of the sync root provider.
    ushort[256] ProviderName;
    ///Version of the sync root provider.
    ushort[256] ProviderVersion;
}

///Standard sync root information.
struct CF_SYNC_ROOT_STANDARD_INFO
{
    ///File ID of the sync root.
    LARGE_INTEGER        SyncRootFileId;
    ///Hydration policy of the sync root.
    CF_HYDRATION_POLICY  HydrationPolicy;
    ///Population policy of the sync root.
    CF_POPULATION_POLICY PopulationPolicy;
    ///In-sync policy of the sync root.
    CF_INSYNC_POLICY     InSyncPolicy;
    ///Sync root hard linking policy.
    CF_HARDLINK_POLICY   HardLinkPolicy;
    ///Status of the sync root provider.
    CF_SYNC_PROVIDER_STATUS ProviderStatus;
    ///Name of the sync root.
    ushort[256]          ProviderName;
    ///Version of the sync root.
    ushort[256]          ProviderVersion;
    ///Length, in bytes, of the <i>SyncRootIdentity</i>.
    uint                 SyncRootIdentityLength;
    ///The identity of the sync root directory.
    ubyte[1]             SyncRootIdentity;
}

// Functions

///Gets the platform version information.
///Params:
///    PlatformVersion = The platform version information. See CF_PLATFORM_INFO for more details.
@DllImport("cldapi")
HRESULT CfGetPlatformInfo(CF_PLATFORM_INFO* PlatformVersion);

///Performs a one time sync root registration.
///Params:
///    SyncRootPath = The path to the sync root to be registered.
///    Registration = Contains information about the sync provider and sync root to be registered.
///    Policies = The policies of the sync root to be registered.
///    RegisterFlags = Flags for registering previous and new sync roots.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfRegisterSyncRoot(const(wchar)* SyncRootPath, const(CF_SYNC_REGISTRATION)* Registration, 
                           const(CF_SYNC_POLICIES)* Policies, CF_REGISTER_FLAGS RegisterFlags);

///Unregisters a previously registered sync root.
///Params:
///    SyncRootPath = The path to the sync root to be unregistered.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfUnregisterSyncRoot(const(wchar)* SyncRootPath);

///Initiates bi-directional communication between a sync provider and the sync filter API.
///Params:
///    SyncRootPath = The path to the sync root.
///    CallbackTable = The callback table to be registered.
///    CallbackContext = A callback context used by the platform anytime a specified callback function is invoked.
///    ConnectFlags = Provides additional information when a callback is invoked.
///    ConnectionKey = A connection key representing the communication channel with the sync filter.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfConnectSyncRoot(const(wchar)* SyncRootPath, const(CF_CALLBACK_REGISTRATION)* CallbackTable, 
                          void* CallbackContext, CF_CONNECT_FLAGS ConnectFlags, CF_CONNECTION_KEY__* ConnectionKey);

///Disconnects a communication channel created by CfConnectSyncRoot.
///Params:
///    ConnectionKey = The connection key returned from CfConnectSyncRoot that is now used to disconnect the sync root.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfDisconnectSyncRoot(CF_CONNECTION_KEY__ ConnectionKey);

///Initiates a transfer of data into a placeholder file or folder.
///Params:
///    FileHandle = The file handle of the placeholder.
///    TransferKey = An opaque handle to the placeholder to be serviced.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfGetTransferKey(HANDLE FileHandle, LARGE_INTEGER* TransferKey);

///Releases a transfer key obtained by CfGetTransferKey.
///Params:
///    FileHandle = The file handle of the placeholder.
///    TransferKey = An opaque handle to the placeholder.
@DllImport("cldapi")
void CfReleaseTransferKey(HANDLE FileHandle, LARGE_INTEGER* TransferKey);

///The main entry point for all connection key based placeholder operations. It is intended to be used by a sync
///provider to respond to various callbacks from the platform.
///Params:
///    OpInfo = Information about an operation on a placeholder.
///    OpParams = Parameters of an operation on a placeholder.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfExecute(const(CF_OPERATION_INFO)* OpInfo, CF_OPERATION_PARAMETERS* OpParams);

///Updates the current status of the sync provider.
///Params:
///    ConnectionKey = A connection key representing a communication channel with the sync filter.
///    ProviderStatus = The current status of the sync provider.
@DllImport("cldapi")
HRESULT CfUpdateSyncProviderStatus(CF_CONNECTION_KEY__ ConnectionKey, CF_SYNC_PROVIDER_STATUS ProviderStatus);

///Queries a sync provider to get the status of the provider.
///Params:
///    ConnectionKey = A connection key representing a communication channel with the sync filter.
///    ProviderStatus = The current status of the sync provider.
@DllImport("cldapi")
HRESULT CfQuerySyncProviderStatus(CF_CONNECTION_KEY__ ConnectionKey, CF_SYNC_PROVIDER_STATUS* ProviderStatus);

///Allows a sync provider to notify the platform of its status on a specified sync root without having to connect with a
///call to CfConnectSyncRoot first.
///Params:
///    SyncRootPath = Path to the sync root.
///    SyncStatus = The sync status to report; if <b>null</b>, clears the previously-saved sync status. For more information, see the
///                 Remarks section, below.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfReportSyncStatus(const(wchar)* SyncRootPath, CF_SYNC_STATUS* SyncStatus);

///Creates one or more new placeholder files or directories under a sync root tree.
///Params:
///    BaseDirectoryPath = Local directory path under which placeholders are created. Note that this directory must be the immediate parent
///                        directory of the placeholders being created. For example, if the sync root of the provider is c:\SyncRoot and a
///                        placeholder is being created in a child directory of the sync root such as c:\SyncRoot\ChildDir, then
///                        BaseDirectoryPath = c:\SyncRoot\ChildDir.
///    PlaceholderArray = On successful creation, the <i>PlaceholderArray</i> contains the final USN value and a STATUS_OK message. On
///                       return, this array contains an HRESULT value describing whether the placeholder was created or not.
///    PlaceholderCount = The count of placeholders in the <i>PlaceholderArray</i>.
///    CreateFlags = Flags for configuring the creation of a placeholder.
///    EntriesProcessed = The number of entries processed, including failed entries.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfCreatePlaceholders(const(wchar)* BaseDirectoryPath, char* PlaceholderArray, uint PlaceholderCount, 
                             CF_CREATE_FLAGS CreateFlags, uint* EntriesProcessed);

///Opens an asynchronous opaque handle to a file or directory (for both normal and placeholder files) and sets up a
///proper oplock on it based on the open flags.
///Params:
///    FilePath = Fully qualified path to the file or directory to be opened.
///    Flags = Flags to specify permissions on opening the file.
///    ProtectedHandle = An opaque handle to the file or directory that is just opened. Note that this is not a normal Win32 handle and
///                      hence cannot be used with non-CfApi Win32 APIs directly.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfOpenFileWithOplock(const(wchar)* FilePath, CF_OPEN_FILE_FLAGS Flags, ptrdiff_t* ProtectedHandle);

///Allows the caller to reference a protected handle to a Win32 handle which can be used with non-CfApi Win32 APIs.
///Params:
///    ProtectedHandle = The protected handle of a placeholder file.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
ubyte CfReferenceProtectedHandle(HANDLE ProtectedHandle);

///Converts a protected handle to a Win32 handle so that it can be used with all handle-based Win32 APIs.
///Params:
///    ProtectedHandle = The protected handle to be converted.
///Returns:
///    The corresponding Win32 handle.
///    
@DllImport("cldapi")
HANDLE CfGetWin32HandleFromProtectedHandle(HANDLE ProtectedHandle);

///Releases a protected handle referenced by CfReferenceProtectedHandle.
///Params:
///    ProtectedHandle = The protected handle to be released.
@DllImport("cldapi")
void CfReleaseProtectedHandle(HANDLE ProtectedHandle);

///Closes the file or directory handle returned by CfOpenFileWithOplock. This should not be used with standard Win32
///file handles, only on handles used within CfApi.h.
///Params:
///    FileHandle = The file or directory handle to be closed.
@DllImport("cldapi")
void CfCloseHandle(HANDLE FileHandle);

///Converts a normal file/directory to a placeholder file/directory.
///Params:
///    FileHandle = Handle to the file or directory to be converted.
///    FileIdentity = A user mode buffer that contains the opaque file or directory information supplied by the caller. Optional if the
///                   caller is not dehydrating the file at the same time, or if the caller is converting a directory. Cannot exceed
///                   4KB in size.
///    FileIdentityLength = Length, in bytes, of the <i>FileIdentity</i>.
///    ConvertFlags = Placeholder conversion flags.
///    ConvertUsn = The final USN value after convert actions are performed.
///    Overlapped = When specified and combined with an asynchronous <i>FileHandle</i>, <i>Overlapped</i> allows the platform to
///                 perform the <b>CfConvertToPlaceholder</b> call asynchronously. See the Remarks for more details. If not
///                 specified, the platform will perform the API call synchronously, regardless of how the handle was created.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfConvertToPlaceholder(HANDLE FileHandle, char* FileIdentity, uint FileIdentityLength, 
                               CF_CONVERT_FLAGS ConvertFlags, long* ConvertUsn, OVERLAPPED* Overlapped);

///Updates characteristics of the placeholder file or directory.
///Params:
///    FileHandle = A handle to the file or directory whose metadata is to be updated.
///    FsMetadata = File system metadata to be updated for the placeholder. Values of 0 for the metadata indicate there are no
///                 updates.
///    FileIdentity = A user mode buffer that contains file or directory information supplied by the caller. Should not exceed 4KB in
///                   size.
///    FileIdentityLength = Length, in bytes, of the <i>FileIdentity</i>.
///    DehydrateRangeArray = A range of an existing placeholder that will no longer be considered valid after the call to
///                          <b>CfUpdatePlaceholder</b>.
///    DehydrateRangeCount = The count of a series of discrete <i>DehydrateRangeArray</i> partitions of placeholder data.
///    UpdateFlags = Update flags for placeholders.
///    UpdateUsn = On input, <i>UpdateUsn</i> instructs the platform to only perform the update if the file still has the same USN
///                value as the one passed in. This serves a similar purpose to <b>CF_UPDATE_FLAG_VERIFY_IN_SYNC</b> but also
///                encompasses local metadata changes. On return, <i>UpdateUsn</i> receives the final USN value after update actions
///                were performed.
///    Overlapped = When specified and combined with an asynchronous <i>FileHandle</i>, <i>Overlapped</i> allows the platform to
///                 perform the <b>CfUpdatePlaceholder</b> call asynchronously. See the Remarks for more details. If not specified,
///                 the platform will perform the API call synchronously, regardless of how the handle was created.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfUpdatePlaceholder(HANDLE FileHandle, const(CF_FS_METADATA)* FsMetadata, char* FileIdentity, 
                            uint FileIdentityLength, char* DehydrateRangeArray, uint DehydrateRangeCount, 
                            CF_UPDATE_FLAGS UpdateFlags, long* UpdateUsn, OVERLAPPED* Overlapped);

///Reverts a placeholder back to a regular file, stripping away all special characteristics such as the reparse tag, the
///file identity, etc.
///Params:
///    FileHandle = A handle to the file or directory placeholder that is about to be reverted to normal file or directory. An
///                 attribute or no-access handle is sufficient.
///    RevertFlags = Placeholder revert flags.
///    Overlapped = When specified and combined with an asynchronous <i>FileHandle</i>, <i>Overlapped</i> allows the platform to
///                 perform the <b>CfRevertPlaceholder</b> call asynchronously. See the Remarks for more details. If not specified,
///                 the platform will perform the API call synchronously, regardless of how the handle was created.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfRevertPlaceholder(HANDLE FileHandle, CF_REVERT_FLAGS RevertFlags, OVERLAPPED* Overlapped);

///Hydrates a placeholder file by ensuring that the specified byte range is present on-disk in the placeholder. This is
///valid for files only.
///Params:
///    FileHandle = Handle of the placeholder file to be hydrated. An attribute or no-access handle is sufficient.
///    StartingOffset = The starting point offset of the placeholder file data.
///    Length = The length, in bytes, of the placeholder file whose data must be available locally on the disk after the API
///             completes successfully. A length of -1 signifies end of file.
///    HydrateFlags = Placeholder hydration flags.
///    Overlapped = When specified and combined with an asynchronous <i>FileHandle</i>, <i>Overlapped</i> allows the platform to
///                 perform the <b>CfHydratePlaceholder</b> call asynchronously. See the Remarks for more details. If not specified,
///                 the platform will perform the API call synchronously, regardless of how the handle was created.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfHydratePlaceholder(HANDLE FileHandle, LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, 
                             CF_HYDRATE_FLAGS HydrateFlags, OVERLAPPED* Overlapped);

@DllImport("cldapi")
HRESULT CfDehydratePlaceholder(HANDLE FileHandle, LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, 
                               CF_DEHYDRATE_FLAGS DehydrateFlags, OVERLAPPED* Overlapped);

///This sets the pin state of a placeholder, used to represent a user’s intent. Any application (not just the sync
///provider) can call this function.
///Params:
///    FileHandle = The handle of the placeholder file. The caller must have READ_DATA or WRITE_DAC access to the placeholder.
///    PinState = The pin state of the placeholder file.
///    PinFlags = The pin state flags.
///    Overlapped = Allows the call to be performed asynchronously. See the Remarks section for more details.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfSetPinState(HANDLE FileHandle, CF_PIN_STATE PinState, CF_SET_PIN_FLAGS PinFlags, OVERLAPPED* Overlapped);

///Sets the in-sync state for a placeholder file or folder.
///Params:
///    FileHandle = A handle to the placeholder. The caller must have WRITE_DATA or WRITE_DAC access to the placeholder.
///    InSyncState = The in-sync state. See CF_IN_SYNC_STATE for more details.
///    InSyncFlags = The in-sync state flags. See CF_SET_IN_SYNC_FLAGS for more details.
///    InSyncUsn = When specified, this instructs the platform to only perform in-sync setting if the file still has the same USN
///                value as the one passed in. Passing a pointer to a USN value of 0 on input is the same as passing a NULL pointer.
///                On return, this is the final USN value after setting the in-sync state.
@DllImport("cldapi")
HRESULT CfSetInSyncState(HANDLE FileHandle, CF_IN_SYNC_STATE InSyncState, CF_SET_IN_SYNC_FLAGS InSyncFlags, 
                         long* InSyncUsn);

///Allows a sync provider to instruct the platform to use a specific correlation vector for telemetry purposes on a
///placeholder file. This is optional.
///Params:
///    FileHandle = The handle to the placeholder file.
///    CorrelationVector = A specific correlation vector to be associated with the <i>FileHandle</i>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfSetCorrelationVector(HANDLE FileHandle, const(CORRELATION_VECTOR)* CorrelationVector);

///Allows the sync provider to query the current correlation vector for a given placeholder file.
///Params:
///    FileHandle = The handle to the placeholder file.
///    CorrelationVector = The correlation vector for the <i>FileHandle</i>.
@DllImport("cldapi")
HRESULT CfGetCorrelationVector(HANDLE FileHandle, CORRELATION_VECTOR* CorrelationVector);

///Gets a set of placeholder states based on the <i>FileAttributes</i> and <i>ReparseTag</i> values of the file.
///Params:
///    FileAttributes = The file attribute information.
///    ReparseTag = The reparse tag information from a file.
///Returns:
///    Can include CF_PLACEHOLDER_STATE; The placeholder state.
///    
@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromAttributeTag(uint FileAttributes, uint ReparseTag);

///Gets a set of placeholder states based on the various information of the file.
///Params:
///    InfoBuffer = An info buffer about the file.
///    InfoClass = An info class so the function knows how to interpret the <i>InfoBuffer</i>.
///Returns:
///    Can include CF_PLACEHOLDER_STATE; The placeholder state.
///    
@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFileInfo(void* InfoBuffer, FILE_INFO_BY_HANDLE_CLASS InfoClass);

///Gets a set of placeholder states based on the WIN32_FIND_DATA structure.
///Params:
///    FindData = The find data information on the file.
///Returns:
///    Can include CF_PLACEHOLDER_STATE; The placeholder state.
///    
@DllImport("cldapi")
CF_PLACEHOLDER_STATE CfGetPlaceholderStateFromFindData(const(WIN32_FIND_DATAA)* FindData);

///Gets various characteristics of a placeholder file or folder.
///Params:
///    FileHandle = A handle to the placeholder whose information will be queried.
///    InfoClass = Placeholder information. This can be set to either CF_PLACEHOLDER_STANDARD_INFO or CF_PLACEHOLDER_BASIC_INFO.
///    InfoBuffer = A pointer to a buffer that will receive information.
///    InfoBufferLength = The length of the <i>InfoBuffer</i>, in bytes.
///    ReturnedLength = The number of bytes returned in the <i>InfoBuffer</i>.
@DllImport("cldapi")
HRESULT CfGetPlaceholderInfo(HANDLE FileHandle, CF_PLACEHOLDER_INFO_CLASS InfoClass, char* InfoBuffer, 
                             uint InfoBufferLength, uint* ReturnedLength);

///Gets various sync root information given a file under the sync root.
///Params:
///    FilePath = A fully qualified path to a file whose sync root information is to be queried
///    InfoClass = Types of sync root information.
///    InfoBuffer = A pointer to a buffer that will receive the sync root information.
///    InfoBufferLength = Length, in bytes, of the <i>InfoBuffer</i>.
///    ReturnedLength = Length, in bytes, of the returned sync root information. Refer to CfRegisterSyncRoot for details about the sync
///                     root information.
@DllImport("cldapi")
HRESULT CfGetSyncRootInfoByPath(const(wchar)* FilePath, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                uint InfoBufferLength, uint* ReturnedLength);

///Gets various characteristics of the sync root containing a given file specified by a file handle.
///Params:
///    FileHandle = Handle of the file under the sync root whose information is to be queried.
///    InfoClass = Types of sync root information.
///    InfoBuffer = A pointer to a buffer that will receive the sync root information.
///    InfoBufferLength = Length, in bytes, of the <i>InfoBuffer</i>.
///    ReturnedLength = The number of bytes returned in the <i>InfoBuffer</i>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfGetSyncRootInfoByHandle(HANDLE FileHandle, CF_SYNC_ROOT_INFO_CLASS InfoClass, void* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

///Gets range information about a placeholder file or folder.
///Params:
///    FileHandle = The handle of the placeholder file to be queried.
///    InfoClass = Types of the range of placeholder data.
///    StartingOffset = Offset of the starting point of the range of data.
///    Length = Length of the range of data.
///    InfoBuffer = Pointer to a buffer to receive the data.
///    InfoBufferLength = Length, in bytes, of <i>InfoBuffer</i>.
///    ReturnedLength = The length of the returned range of placeholder data in the <i>InfoBuffer</i>.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("cldapi")
HRESULT CfGetPlaceholderRangeInfo(HANDLE FileHandle, CF_PLACEHOLDER_RANGE_INFO_CLASS InfoClass, 
                                  LARGE_INTEGER StartingOffset, LARGE_INTEGER Length, char* InfoBuffer, 
                                  uint InfoBufferLength, uint* ReturnedLength);

///Allows a sync provider to report progress out-of-band.
///Params:
///    ConnectionKey = A connection key representing a communication channel with the sync filter.
///    TransferKey = An opaque handle to the placeholder.
///    ProviderProgressTotal = The total progress of the sync provider in response to a fetch data callback.
///    ProviderProgressCompleted = The completed progress of the sync provider in response to a fetch data callback.
@DllImport("cldapi")
HRESULT CfReportProviderProgress(CF_CONNECTION_KEY__ ConnectionKey, LARGE_INTEGER TransferKey, 
                                 LARGE_INTEGER ProviderProgressTotal, LARGE_INTEGER ProviderProgressCompleted);

@DllImport("cldapi")
HRESULT CfReportProviderProgress2(CF_CONNECTION_KEY__ ConnectionKey, LARGE_INTEGER TransferKey, 
                                  LARGE_INTEGER RequestKey, LARGE_INTEGER ProviderProgressTotal, 
                                  LARGE_INTEGER ProviderProgressCompleted, uint TargetSessionId);


