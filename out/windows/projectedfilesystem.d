// Written in the D programming language.

module windows.projectedfilesystem;

public import windows.core;
public import windows.com : HRESULT;
public import windows.systemservices : LARGE_INTEGER, PWSTR;

extern(Windows) @nogc nothrow:


// Enums


///Types of notifications describing a change to the file or folder.
alias PRJ_NOTIFY_TYPES = int;
enum : int
{
    ///No notification.
    PRJ_NOTIFY_NONE                               = 0x00000000,
    ///If specified on virtualization instance start: - This indicates that notifications should not be sent for the
    ///virtualization instance, or a specified subtree of the instance. If specified in response to a notification: -
    ///This indicates that notifications should not be sent for the specified file or folder until all handles to it are
    ///closed. <div class="alert"><b>Note</b> If this bit appears in a notification mask, it overrides all other bits in
    ///the mask. For example, a valid mask with this bit is treated as containing only
    ///PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS.</div> <div> </div>
    PRJ_NOTIFY_SUPPRESS_NOTIFICATIONS             = 0x00000001,
    ///If specified on virtualization instance start: - This indicates that the provider should be notified when a
    ///handle is created to an existing file or folder. If specified in response to a notification: - This indicates
    ///that the provider should be notified if any further handles are created to the file or folder.
    PRJ_NOTIFY_FILE_OPENED                        = 0x00000002,
    ///If specified on virtualization instance start: - The provider should be notified when a new file or folder is
    ///created. If specified in response to a notification: - No effect.
    PRJ_NOTIFY_NEW_FILE_CREATED                   = 0x00000004,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified when an existing
    ///when an existing file is overwritten or superceded. If specified in response to a notification: - Indicates that
    ///the provider should be notified when the file or folder is overwritten or superceded.
    PRJ_NOTIFY_FILE_OVERWRITTEN                   = 0x00000008,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified when a file or
    ///folder is about to be deleted. If specified in response to a notification: - Indicates that the provider should
    ///be notified when a file or folder is about to be deleted.
    PRJ_NOTIFY_PRE_DELETE                         = 0x00000010,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified when a file or
    ///folder is about to be renamed. If specified in response to a notification: - Indicates that the provider should
    ///be notified when a file or folder is about to be renamed.
    PRJ_NOTIFY_PRE_RENAME                         = 0x00000020,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified when a hard link
    ///is about to be created for a file. If specified in response to a notification: - Indicates that the provider
    ///should be notified when a hard link is about to be created for a file.
    PRJ_NOTIFY_PRE_SET_HARDLINK                   = 0x00000040,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified that a file or
    ///folder has been renamed. If specified in response to a notification: - Indicates that the provider should be
    ///notified when a file or folder has been renamed.
    PRJ_NOTIFY_FILE_RENAMED                       = 0x00000080,
    ///If specified on virtualization instance start: - Indicates that the provider should be notified that a hard link
    ///has been created for a file. If specified in response to a notification: - Indicates that the provider should be
    ///notified that a hard link has been created for the file.
    PRJ_NOTIFY_HARDLINK_CREATED                   = 0x00000100,
    ///If specified on virtualization instance start: - The provider should be notified when a handle is closed on a
    ///file/folder and the closing handle neither modified nor deleted it. If specified in response to a notification: -
    ///The provider should be notified when handles are closed for the file/folder and there were no modifications or
    ///deletions associated with the closing handle.
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    ///If specified on virtualization instance start: - The provider should be notified when a handle is closed on a
    ///file/folder and the closing handle was used to modify it. If specified in response to a notification: - The
    ///provider should be notified when a handle is closed on the file/folder and the closing handle was used to modify
    ///it.
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    ///If specified on virtualization instance start: - The provider should be notified when a handle is closed on a
    ///file/folder and it is deleted as part of closing the handle. If specified in response to a notification: - The
    ///provider should be notified when a handle is closed on the file/folder and it is deleted as part of closing the
    ///handle.
    PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    ///If specified on virtualization instance start: - The provider should be notified when it is about to convert a
    ///placeholder to a full file. If specified in response to a notification: - The provider should be notified when it
    ///is about to convert the placeholder to a full file, assuming it is a placeholder and not already a full file.
    PRJ_NOTIFY_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
    ///If specified on virtualization instance start: - This value is not valid on virtualization instance start. If
    ///specified in response to a notification: - Continue to use the existing set of notifications for this
    ///file/folder.
    PRJ_NOTIFY_USE_EXISTING_MASK                  = 0xffffffff,
}

///A notification value specified when sending the [PRJ_NOTIFICATION_CB
///callback](nc-projectedfslib-prj_notification_cb.md).
alias PRJ_NOTIFICATION = int;
enum : int
{
    ///- Indicates that a handle has been created to an existing file or folder. - The provider can specify a new
    ///notification mask for this file or folder when responding to the notification.
    PRJ_NOTIFICATION_FILE_OPENED                        = 0x00000002,
    ///- A new file or folder has been created. - The provider can specify a new notification mask for this file or
    ///folder when responding to the notification.
    PRJ_NOTIFICATION_NEW_FILE_CREATED                   = 0x00000004,
    ///- An existing file has been overwritten or superceded. - The provider can specify a new notification mask for
    ///this file or folder when responding to the notification.
    PRJ_NOTIFICATION_FILE_OVERWRITTEN                   = 0x00000008,
    ///- A file or folder is about to be deleted. - If the provider returns an error HRESULT code from the callback, the
    ///delete will not take effect.
    PRJ_NOTIFICATION_PRE_DELETE                         = 0x00000010,
    ///- A file or folder is about to be renamed. - If the provider returns an error HRESULT code from the callback, the
    ///rename will not take effect. - If the callbackData-&gt;FilePathName parameter of PRJ_NOTIFICATION_CB is an empty
    ///string, this indicates that the rename is moving the file/directory from outside the virtualization instance. In
    ///that case, this notification will always be sent if the provider has registered a PRJ_NOTIFICATION_CB callback,
    ///even if the provider did not specify this bit when registering the subtree containing the destination path.
    ///However if the provider specified PRJ_NOTIFICATION_SUPPRESS_NOTIFICATIONS when registering the subtree containing
    ///the destination path, the notification will be suppressed. - If the destinationFileName parameter of
    ///PRJ_NOTIFICATION_CB is an empty string, this indicates that the rename is moving the file/folder out of the
    ///virtualization instance. - If both the callbackData-&gt;FilePathName and destinationFileName parameters of
    ///PRJ_NOTIFICATION_CB are non-empty strings, this indicates that the rename is within the virtualization instance.
    ///If the provider specified different notification masks for the source and destination paths in the
    ///NotificationMappings member of the options parameter of PrjStartVirtualizing, then this notification will be sent
    ///if the provider specified this bit when registering either the source or destination paths.
    PRJ_NOTIFICATION_PRE_RENAME                         = 0x00000020,
    ///- A hard link is about to be created for the file. - If the provider returns an error HRESULT code from the
    ///callback, the hard link operation will not take effect. - If the callbackData-&gt;FilePathName parameter of
    ///PRJ_NOTIFICATION_CB is an empty string, this indicates that the hard link name will be created inside the
    ///virtualization instance, i.e. a new hard link is being created inside the virtualization instance to a file that
    ///exists outside the virtualization instance. In that case, this notification will always be sent if the provider
    ///has registered a PRJ_NOTIFICATION_CB callback, even if the provider did not specify this bit when registering the
    ///subtree where the new hard link name will be. However if the provider specified
    ///PRJ_NOTIFICATION_SUPPRESS_NOTIFICATIONS when registering the subtree containing the destination path, the
    ///notification will be suppressed. - If the destinationFileName parameter of PRJ_NOTIFICATION_CB is an empty
    ///string, this indicates that the hard link name will be created outside the virtualization instance, i.e. a new
    ///hard link is being created outside the virtualization instance for a file that exists inside the virtualization
    ///instance. - If both the callbackData-&gt;FilePathName and destinationFileName parameters of PRJ_NOTIFICATION_CB
    ///are non-empty strings, this indicates that the new hard link will be created within the virtualization instance
    ///for a file that exists within the virtualization instance. If the provider specified different notification masks
    ///for the source and destination paths in the NotificationMappings member of the options parameter of
    ///PrjStartVirtualizing, then this notification will be sent if the provider specified this bit when registering
    ///either the source or destination paths.
    PRJ_NOTIFICATION_PRE_SET_HARDLINK                   = 0x00000040,
    ///- Indicates that a file/folder has been renamed. The file/folder may have been moved into the virtualization
    ///instance. - If the callbackData-&gt;FilePathName parameter of PRJ_NOTIFICATION_CB is an empty string, this
    ///indicates that the rename moved the file/directory from outside the virtualization instance. In that case ProjFS
    ///will always send this notification if the provider has registered a PRJ_NOTIFICATION_CB callback, even if the
    ///provider did not specify this bit when registering the subtree containing the destination path. - If the
    ///destinationFileName parameter of PRJ_NOTIFICATION_CB is an empty string, this indicates that the rename moved the
    ///file/directory out of the virtualization instance. - If both the callbackData-&gt;FilePathName and
    ///destinationFileName parameters of PRJ_NOTIFICATION_CB are non-empty strings, this indicates that the rename was
    ///within the virtualization instance. If the provider specified different notification masks for the source and
    ///destination paths in the NotificationMappings member of the options parameter of PrjStartVirtualizing, then
    ///ProjFS will send this notification if the provider specified this bit when registering either the source or
    ///destination paths. - The provider can specify a new notification mask for this file/directory when responding to
    ///the notification.
    PRJ_NOTIFICATION_FILE_RENAMED                       = 0x00000080,
    ///- Indicates that a hard link has been created for the file. - If the callbackData-&gt;FilePathName parameter of
    ///PRJ_NOTIFICATION_CB is an empty string, this indicates that the hard link name was created inside the
    ///virtualization instance, i.e. a new hard link was created inside the virtualization instance to a file that
    ///exists outside the virtualization instance. In that case ProjFS will always send this notification if the
    ///provider has registered a PRJ_NOTIFICATION_CB callback, even if the provider did not specify this bit when
    ///registering the subtree where the new hard link name will be. - If the destinationFileName parameter of
    ///PRJ_NOTIFICATION_CB is an empty string, this indicates that the hard link name was created outside the
    ///virtualization instance, i.e. a new hard link was created outside the virtualization instance for a file that
    ///exists inside the virtualization instance. - If both the callbackData-&gt;FilePathName and destinationFileName
    ///parameters of PRJ_NOTIFICATION_CB are non-empty strings, this indicates that the a new hard link was created
    ///within the virtualization instance for a file that exists within the virtualization instance. If the provider
    ///specified different notification masks for the source and destination paths in the NotificationMappings member of
    ///the options parameter of PrjStartVirtualizing, then ProjFS will send this notification if the provider specified
    ///this bit when registering either the source or destination paths.
    PRJ_NOTIFICATION_HARDLINK_CREATED                   = 0x00000100,
    ///- A handle has been closed on the file/folder, and the file's content was not modified while the handle was open,
    ///and the file/folder was not deleted
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_NO_MODIFICATION = 0x00000200,
    ///- A handle has been closed on the file, and that the file's content was modified while the handle was open.
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED   = 0x00000400,
    ///- A handle has been closed on the file/folder, and that it was deleted as part of closing the handle. - If the
    ///provider also registered to receive PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_MODIFIED notifications, and the file
    ///was modified using the handle whose close resulted in deleting the file, then the
    ///operationParameters-&gt;FileDeletedOnHandleClose.IsFileModified parameter of PRJ_NOTIFICATION_CB will be TRUE.
    ///This applies only to files, not directories
    PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED    = 0x00000800,
    PRJ_NOTIFICATION_FILE_PRE_CONVERT_TO_FULL           = 0x00001000,
}

///Specifies extended information types for PRJ_EXTENDED_INFO.
alias PRJ_EXT_INFO_TYPE = int;
enum : int
{
    ///This PRJ_EXTENDED_INFO specifies the target of a symbolic link.
    PRJ_EXT_INFO_TYPE_SYMLINK = 0x00000001,
}

///Flags to provide when starting a virtualization instance.
alias PRJ_STARTVIRTUALIZING_FLAGS = int;
enum : int
{
    ///No flags.
    PRJ_FLAG_NONE                    = 0x00000000,
    PRJ_FLAG_USE_NEGATIVE_PATH_CACHE = 0x00000001,
}

///Defines the length of a placeholder identifier.
alias PRJ_PLACEHOLDER_ID = int;
enum : int
{
    PRJ_PLACEHOLDER_ID_LENGTH = 0x00000080,
}

///Flags to specify whether updates will be allowed given the state of a file or directory on disk.
alias PRJ_UPDATE_TYPES = int;
enum : int
{
    ///Allow update only if the item is a placeholder (whether hydrated or not).
    PRJ_UPDATE_NONE                 = 0x00000000,
    ///Allow update if the item is a placeholder or a dirty placeholder.
    PRJ_UPDATE_ALLOW_DIRTY_METADATA = 0x00000001,
    ///Allow update if the item is a placeholder or if it is a full file.
    PRJ_UPDATE_ALLOW_DIRTY_DATA     = 0x00000002,
    ///Allow update if the item is a placeholder or if it is a tombstone.
    PRJ_UPDATE_ALLOW_TOMBSTONE      = 0x00000004,
    ///Reserved for future use.
    PRJ_UPDATE_RESERVED1            = 0x00000008,
    ///Reserved for future use.
    PRJ_UPDATE_RESERVED2            = 0x00000010,
    ///Allow update regardless of whether the DOS read-only bit is set on the item.
    PRJ_UPDATE_ALLOW_READ_ONLY      = 0x00000020,
    PRJ_UPDATE_MAX_VAL              = 0x00000040,
}

///Descriptions for the reason an update failed.
alias PRJ_UPDATE_FAILURE_CAUSES = int;
enum : int
{
    ///The update did not fail.
    PRJ_UPDATE_FAILURE_CAUSE_NONE           = 0x00000000,
    ///The item was a dirty placeholder (hydrated or not), and the provider did not specify
    ///PRJ_UPDATE_ALLOW_DIRTY_METADATA in PRJ_UPDATE_TYPES.
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_METADATA = 0x00000001,
    ///The item was a full file and the provider did not specify PRJ_UPDATE_ALLOW_DIRTY_DATA in PRJ_UPDATE_TYPES.
    PRJ_UPDATE_FAILURE_CAUSE_DIRTY_DATA     = 0x00000002,
    ///The item was a tombstone and the provider did not specify PRJ_UPDATE_ALLOW_TOMBSTONE in PRJ_UPDATE_TYPES.
    PRJ_UPDATE_FAILURE_CAUSE_TOMBSTONE      = 0x00000004,
    PRJ_UPDATE_FAILURE_CAUSE_READ_ONLY      = 0x00000008,
}

///The state of an item.
alias PRJ_FILE_STATE = int;
enum : int
{
    ///The item is a placeholder.
    PRJ_FILE_STATE_PLACEHOLDER          = 0x00000001,
    ///The item is a hydrated placeholder, i.e., the item's content has been written to disk.
    PRJ_FILE_STATE_HYDRATED_PLACEHOLDER = 0x00000002,
    ///The placeholder item's metadata has been modified.
    PRJ_FILE_STATE_DIRTY_PLACEHOLDER    = 0x00000004,
    ///The item is full.
    PRJ_FILE_STATE_FULL                 = 0x00000008,
    ///The item is a tombstone.
    PRJ_FILE_STATE_TOMBSTONE            = 0x00000010,
}

///Flags controlling what is returned in the enumeration.
alias PRJ_CALLBACK_DATA_FLAGS = int;
enum : int
{
    ///Start the scan at the first entry in the directory.
    PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN        = 0x00000001,
    PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY = 0x00000002,
}

///Specifies command types.
alias PRJ_COMPLETE_COMMAND_TYPE = int;
enum : int
{
    ///The provider is completing a call to its PRJ_NOTIFICATION_CB callback.
    PRJ_COMPLETE_COMMAND_TYPE_NOTIFICATION = 0x00000001,
    PRJ_COMPLETE_COMMAND_TYPE_ENUMERATION  = 0x00000002,
}

// Callbacks

///Informs the provider that a directory enumeration is starting.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>FilePathName</b>Identifies the directory to be enumerated. </dd>
///                   <dd><b>VersionInfo</b>Provides version information for the directory to be enumerated. </dd> </dl> The provider
///                   can access this buffer only while the callback is running. If it wishes to pend the operation and it requires
///                   data from this buffer, it must make its own copy of it.
///    enumerationId = An identifier for this enumeration session.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The provider successfully completed the operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The directory to be
///    enumerated does not exist in the provider’s backing store. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider wishes to complete
///    the operation at a later time. </td> </tr> </table> An appropriate HRESULT error code if the provider fails the
///    operation.
///    
alias PRJ_START_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                            const(GUID)* enumerationId);
///Requests directory enumeration information from the provider.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>FilePathName</b>Identifies the directory to be enumerated. </dd>
///                   <dd><b>VersionInfo</b>Provides version information for the directory to be enumerated. </dd>
///                   <dd><b>Flags</b>Flags to control what is returned in the enumeration. Valid values are: <table> <tr>
///                   <td>PRJ_CB_DATA_FLAG_ENUM_RETURN_SINGLE_ENTRY</td> <td>This bit is set if the user is requesting only one entry
///                   from the enumeration. The provider may treat this as a hint, and may opt to return more than one entry to make an
///                   enumeration that returns one item at a time more efficient. In such a case ProjFS will return single entry to the
///                   user, invoking the provider only when it needs more entries.</td> </tr> <tr>
///                   <td>PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN</td> <td>This bit is set if the enumeration is to start at the first entry
///                   in the directory. On the first invocation of this callback for an enumeration session the provider must treat
///                   this flag as set, regardless of its value. All enumerations must start at the first entry. On subsequent
///                   invocations of this callback the provider must honor this value.</td> </tr> </table> </dd> </dl> The provider can
///                   access this buffer only while the callback is running. If it wishes to pend the operation and it requires data
///                   from this buffer, it must make its own copy of it.
///    enumerationId = An identifier for this enumeration session.
///    searchExpression = A pointer to a null-terminated Unicode string specifying a search expression. The search expression may include
///                       wildcard characters. The provider should use the PrjDoesNameContainWildCards function to determine whether
///                       wildcards are present in <b>searchExpression</b>, and it should use the PrjFileNameMatch function to determine
///                       whether an entry in its backing store matches a search expression containing wildcards. This parameter is
///                       optional and may be NULL.<ul> <li>If this parameter is not NULL, the provider must return only those directory
///                       entries whose names match the search expression.</li> <li>If this parameter is NULL, the provider must return all
///                       directory entries.</li> </ul> The provider should capture the value of this parameter on the first invocation of
///                       this callback for an enumeration session and use it on subsequent invocations, ignoring this parameter on those
///                       invocations unless <b>PRJ_CB_DATA_FLAG_ENUM_RESTART_SCAN</b> is specified in the <b>Flags</b> member of
///                       <b>callbackData</b>. In that case the provider must re-capture the value of <b>searchExpression.</b>
///    dirEntryBufferHandle = An opaque handle to a structure that receives the results of the enumeration from the provider. The provider uses
///                           the PrjFillDirEntryBuffer routine to fill the structure.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The provider successfully added at least one entry to dirEntryBufferHandle, or no
///    entries in the provider’s store match searchExpression. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER)</b></dt> </dl> </td> <td width="60%"> The provider received
///    this error from PrjFillDirEntryBuffer for the first file or directory it tried to add to dirEntryBufferHandle.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td
///    width="60%"> The provider wishes to complete the operation at a later time. </td> </tr> </table> An appropriate
///    HRESULT error code if the provider fails the operation.
///    
alias PRJ_GET_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId, const(PWSTR) searchExpression, 
                                                          PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);
///Informs the provider that a directory enumeration is over.
///Params:
///    callbackData = Information about the operation. The provider can access this buffer only while the callback is running. If it
///                   wishes to pend the operation and it requires data from this buffer, it must make its own copy of it.
///    enumerationId = An identifier for this enumeration session. See the Remarks section of PRJ_START_DIRECTORY_ENUMERATION_CB for
///                    more information.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The provider successfully completed the operation. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider wishes to
///    complete the operation at a later time. </td> </tr> </table> The provider should not return any other value from
///    this callback.
///    
alias PRJ_END_DIRECTORY_ENUMERATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, 
                                                          const(GUID)* enumerationId);
///Requests information for a file or directory from the provider.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>FilePathName</b>Identifies the path to the file or directory in the provider's store for
///                   which ProjFS is requesting information. The provider uses this to determine whether the name exists in its
///                   backing store. It should use the PrjFileNameMatch function to compare this name to the names in its store. If it
///                   finds a matching name, it uses that name as the <i>destinationFileName</i> parameter of the
///                   PrjWritePlaceholderInfo function. </dd> <dd><b>VersionInfo</b>Provides version information for the parent
///                   directory of the requested item. </dd> </dl> The provider can access this buffer only while the callback is
///                   running. If it wishes to pend the operation and it requires data from this buffer, it must make its own copy of
///                   it.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The file exists in the provider's store and it successfully gave the file's
///    information to ProjFS. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider wishes to complete
///    the operation at a later time. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The file does not exist in
///    the provider's store. </td> </tr> </table> Another appropriate HRESULT error code if the provider fails the
///    operation.
///    
alias PRJ_GET_PLACEHOLDER_INFO_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
///Requests the contents of a file's primary data stream.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>FilePathName</b>Identifies the path to the file in the provider’s backing store for which
///                   data should be returned. Note that this reflects the name the file had when its placeholder was first created. If
///                   it has been renamed since then, <b>FilePathName</b> identifies the original (pre-rename) name, not the current
///                   (post-rename) name. </dd> <dd><b>DataStreamId</b>The unique value to associate with this file stream. The
///                   provider must pass this value in the <i>dataStreamId</i> parameter of PrjWriteFileData when providing file data
///                   as part of handling this callback. </dd> <dd><b>VersionInfo</b>Provides the PRJ_PLACEHOLDER_VERSION_INFO
///                   information that the provider supplied when it created the placeholder for this file. This may help the provider
///                   determine which version of the file contents to return. If the file has been renamed and the provider tracks
///                   renames, this may also help the provider determine which file’s contents are being requested. </dd> </dl> The
///                   provider can access this buffer only while the callback is running. If it wishes to pend the operation and it
///                   requires data from this buffer, it must make its own copy of it.
///    byteOffset = Offset of the requested data, in bytes, from the beginning of the file. The provider must return file data
///                 starting at or before this offset
///    length = Number of bytes of file data requested. The provider must return at least this many bytes of file data beginning
///             with byteOffset.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The provider successfully returned all the requested data. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider
///    wishes to complete the operation at a later time. </td> </tr> </table> An appropriate HRESULT error code if the
///    provider fails the operation.
///    
alias PRJ_GET_FILE_DATA_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ulong byteOffset, 
                                              uint length);
///Determines whether a given file path exists in the provider's backing store.
///Params:
///    callbackData = Information about the operation.
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The queried file path exists in the provider's store. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> The
///    queried file path does not exist in the provider's store. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider wishes to complete
///    the operation at a later time. </td> </tr> </table> An appropriate HRESULT error code if the provider fails the
///    operation.
///    
alias PRJ_QUERY_FILE_NAME_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData);
///Delivers notifications to the provider about file system operations.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>FilePathName</b>Identifies the path for the file or directory to which the notification
///                   pertains. </dd> </dl> The provider can access this buffer only while the callback is running. If it wishes to
///                   pend the operation and it requires data from this buffer, it must make its own copy of it.
///    isDirectory = TRUE if the <b>FilePathName</b> field in <i>callbackData</i> refers to a directory, FALSE otherwise.
///    notification = A PRJ_NOTIFICATIONvalue specifying the notification.
///    destinationFileName = If <b>notification</b> is <b>PRJ_NOTIFICATION_PRE_RENAME </b>or <b>PRJ_NOTIFICATION_PRE_SET_HARDLINK</b>, this
///                          points to a null-terminated Unicode string specifying the path, relative to the virtualization root, of the
///                          target of the rename or set-hardlink operation.
///    operationParameters = A pointer to a PRJ_NOTIFICATION_PARAMETERS union specifying extra parameters for certain values of
///                          <i>notification</i>: <b>PRJ_NOTIFICATION_FILE_OPENED</b>, <b>PRJ_NOTIFICATION_NEW_FILE_CREATED</b>, or
///                          <b>PRJ_NOTIFICATION_FILE_OVERWRITTEN</b><dl> <dd> The fields of the <b>PostCreate</b> member are specified. These
///                          fields are: <b>NotificationMask</b><dl> <dd> Upon return from the PRJ_NOTIFICATION_CB callback, the provider may
///                          specify a new set of notifications that it wishes to receive for the file here. If the provider sets this value
///                          to 0, it is equivalent to specifying <b>PRJ_NOTIFY_USE_EXISTING_MASK</b>. </dd> </dl> </dd> </dl>
///                          <b>PRJ_NOTIFICATION_FILE_RENAMED</b><dl> <dd> The fields of the <b>FileRenamed</b> member are specified. These
///                          fields are: <b>NotificationMask</b><dl> <dd> Upon return from the PRJ_NOTIFICATION_CB callback, the provider may
///                          specify a new set of notifications that it wishes to receive for the file here. If the provider sets this value
///                          to 0, it is equivalent to specifying <b>PRJ_NOTIFY_USE_EXISTING_MASK</b>. </dd> </dl> </dd> </dl>
///                          <b>PRJ_NOTIFICATION_FILE_HANDLE_CLOSED_FILE_DELETED</b><ul> <li> The fields of the
///                          <b>FileDeletedOnHandleClose</b> member are specified. These fields are: <b>NotificationMask</b><dl> <dd> If the
///                          provider registered for <b>PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_MODIFIED</b> as well as
///                          <b>PRJ_NOTIFY_FILE_HANDLE_CLOSED_FILE_DELETED</b>, this field is set to TRUE if the file was modified before it
///                          was deleted. </dd> </dl> </li> </ul>
///Returns:
///    <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt>
///    </dl> </td> <td width="60%"> The provider successfully processed the notification. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b> HRESULT_FROM_WIN32(ERROR_IO_PENDING)</b></dt> </dl> </td> <td width="60%"> The provider
///    wishes to complete the operation at a later time. </td> </tr> </table> An appropriate HRESULT error code if the
///    provider fails the operation. For pre-operation notifications (operations with "PRE" in their name), if the
///    provider returns a failure code ProjFS will fail the corresponding operation with the provided error code.
///    
alias PRJ_NOTIFICATION_CB = HRESULT function(const(PRJ_CALLBACK_DATA)* callbackData, ubyte isDirectory, 
                                             PRJ_NOTIFICATION notification, const(PWSTR) destinationFileName, 
                                             PRJ_NOTIFICATION_PARAMETERS* operationParameters);
///Notifies the provider that an operation by an earlier invocation of a callback should be canceled.
///Params:
///    callbackData = Information about the operation. The following <i>callbackData</i> members are necessary to implement this
///                   callback:<dl> <dd><b>CommandId</b>Identifies the operation to be cancelled. </dd> </dl>
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

///A provider uses PRJ_EXTENDED_INFO to provide extended information about a file when calling PrjFillDirEntryBuffer2 or
///PrjWritePlaceholderInfo2.
struct PRJ_EXTENDED_INFO
{
    ///A PRJ_EXT_INFO value describing what kind of extended information this structure contains.
    PRJ_EXT_INFO_TYPE InfoType;
    ///Offset in bytes from the beginning of this structure to the next PRJ_EXTENDED_INFO structure. If this is the last
    ///structure in the buffer this value must be 0.
    uint              NextInfoOffset;
union
    {
struct Symlink
        {
            const(PWSTR) TargetName;
        }
    }
}

///Describes a notification mapping, which is a pairing between a directory (referred to as a "notification root") and a
///set of notifications, expressed as a bit mask.
struct PRJ_NOTIFICATION_MAPPING
{
    ///A bit mask representing a set of notifications.
    PRJ_NOTIFY_TYPES NotificationBitMask;
    ///The directory that the notification mapping is paired to.
    const(PWSTR)     NotificationRoot;
}

///Options to provide when starting a virtualization instance.
struct PRJ_STARTVIRTUALIZING_OPTIONS
{
    ///A flag for starting virtualization.
    PRJ_STARTVIRTUALIZING_FLAGS Flags;
    ///The number of threads the provider wants to create to service callbacks.
    uint PoolThreadCount;
    ///The maximum number of threads the provider wants to run concurrently to process callbacks.
    uint ConcurrentThreadCount;
    ///An array of zero or more notification mappings. See the Remarks section of PRJ_NOTIFICATION MAPPING for more
    ///details.
    PRJ_NOTIFICATION_MAPPING* NotificationMappings;
    uint NotificationMappingsCount;
}

///Information about a virtualization instance.
struct PRJ_VIRTUALIZATION_INSTANCE_INFO
{
    ///An ID corresponding to a specific virtualization instance.
    GUID InstanceID;
    uint WriteAlignment;
}

///Information that uniquely identifies the contents of a placeholder file.
struct PRJ_PLACEHOLDER_VERSION_INFO
{
    ///A provider specific identifier.
    ubyte[128] ProviderID;
    ///A content identifier, generated by the provider.
    ubyte[128] ContentID;
}

///Basic information about an item.
struct PRJ_FILE_BASIC_INFO
{
    ///Specifies whether the item is a directory.
    ubyte         IsDirectory;
    ///Size of the item, in bytes.
    long          FileSize;
    ///Creation time of the item.
    LARGE_INTEGER CreationTime;
    ///Last time the item was accessed.
    LARGE_INTEGER LastAccessTime;
    ///Last time the item was written to.
    LARGE_INTEGER LastWriteTime;
    ///The last time the item was changed.
    LARGE_INTEGER ChangeTime;
    uint          FileAttributes;
}

///A buffer of metadata for the placeholder file or directory.
struct PRJ_PLACEHOLDER_INFO
{
    ///A structure that supplies basic information about the item: the size of the file in bytes (should be zero if the
    ///IsDirectory field is set to TRUE), the item’s timestamps, and its attributes.
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
    ///Start of the variable-length buffer to hold EAs, a custom security descriptor, and alternate data stream
    ///information.
    ubyte[1]            VariableData;
}

///Defines the standard information passed to a provider for every operation callback.
struct PRJ_CALLBACK_DATA
{
    ///Size in bytes of this structure. The provider must not attempt to access any field of this structure that is
    ///located beyond this value.
    uint         Size;
    ///Callback-specific flags.
    PRJ_CALLBACK_DATA_FLAGS Flags;
    ///Opaque handle to the virtualization instance that is sending the callback.
    PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* NamespaceVirtualizationContext;
    ///A value that uniquely identifies a particular invocation of a callback. The provider uses this value: <ul> <li>In
    ///calls to PrjCompleteCommand to signal completion of a callback from which it earlier returned
    ///HRESULT_FROM_WIN32(ERROR_IO_PENDING).</li> <li>When ProjFS sends a PRJ_CANCEL_COMMAND_CB callback. The commandId
    ///in the <i>PRJ_CANCEL_COMMAND_CB</i> call identifies an earlier invocation of a callback that the provider should
    ///cancel.</li> </ul>
    int          CommandId;
    ///A value that uniquely identifies the file handle for the callback.
    GUID         FileId;
    ///A value that uniquely identifies an open data stream for the callback.
    GUID         DataStreamId;
    ///The path to the target file. This is a null-terminated string of Unicode characters. This path is always
    ///specified relative to the virtualization root.
    const(PWSTR) FilePathName;
    ///Version information if the target of the callback is a placeholder or partial file.
    PRJ_PLACEHOLDER_VERSION_INFO* VersionInfo;
    ///The process identifier for the process that triggered this callback. If this information is not available, this
    ///will be 0. Callbacks that supply this information include: PRJ_GET_PLACEHOLDER_INFO_CB, PRJ_GET_FILE_DATA_CB, and
    ///PRJ_NOTIFICATION_CB.
    uint         TriggeringProcessId;
    ///A null-terminated Unicode string specifying the image file name corresponding to TriggeringProcessId. If
    ///TriggeringProcessId is 0 this will be NULL.
    const(PWSTR) TriggeringProcessImageFileName;
    void*        InstanceContext;
}

///Extra parameters for notifications.
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

///A set of callback routines to where the provider stores its implementation of the callback.
struct PRJ_CALLBACKS
{
    ///A pointer to the StartDirectoryEnumerationCallback.
    PRJ_START_DIRECTORY_ENUMERATION_CB* StartDirectoryEnumerationCallback;
    ///A pointer to the EndDirectoryEnumerationCallback.
    PRJ_END_DIRECTORY_ENUMERATION_CB* EndDirectoryEnumerationCallback;
    ///A pointer to the GetDirectoryEnumerationCallback.
    PRJ_GET_DIRECTORY_ENUMERATION_CB* GetDirectoryEnumerationCallback;
    ///A pointer to the GetPlaceholderInformationCallback.
    PRJ_GET_PLACEHOLDER_INFO_CB* GetPlaceholderInfoCallback;
    ///A pointer to the GetFileDataCallback.
    PRJ_GET_FILE_DATA_CB* GetFileDataCallback;
    ///A pointer to the QueryFileNameCallback.
    PRJ_QUERY_FILE_NAME_CB* QueryFileNameCallback;
    ///A pointer to the NotifyOperationCallback.
    PRJ_NOTIFICATION_CB* NotificationCallback;
    ///A pointer to the CancelCommandCallback.
    PRJ_CANCEL_COMMAND_CB* CancelCommandCallback;
}

///Specifies parameters required for completing certain callbacks.
struct PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS
{
    ///The type of command.
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

///Configures a ProjFS virtualization instance and starts it, making it available to service I/O and invoke callbacks on
///the provider.
///Params:
///    virtualizationRootPath = Pointer to a null-terminated unicode string specifying the full path to the virtualization root directory. The
///                             provider must have called PrjMarkDirectoryAsPlaceholder passing the specified path as the rootPathName parameter
///                             and NULL as the targetPathName parameter before calling this routine. This only needs to be done once to
///                             designate the path as the virtualization root directory
///    callbacks = Pointer to a PRJ_CALLBACKS structure that has been initialized with PrjCommandCallbacksInit and filled in with
///                pointers to the provider's callback functions.
///    instanceContext = Pointer to context information defined by the provider for each instance. This parameter is optional and can be
///                      NULL. If it is specified, ProjFS will return it in the InstanceContext member of PRJ_CALLBACK_DATA when invoking
///                      provider callback routines.
///    options = An optional pointer to a PRJ_STARTVIRTUALIZING_OPTIONS.
///    namespaceVirtualizationContext = On success returns an opaque handle to the ProjFS virtualization instance. The provider passes this value when
///                                     calling functions that require a PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT as input.
@DllImport("PROJECTEDFSLIB")
HRESULT PrjStartVirtualizing(const(PWSTR) virtualizationRootPath, const(PRJ_CALLBACKS)* callbacks, 
                             const(void)* instanceContext, const(PRJ_STARTVIRTUALIZING_OPTIONS)* options, 
                             PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__** namespaceVirtualizationContext);

///Stops a running ProjFS virtualization instance, making it unavailable to service I/O or involve callbacks on the
///provider.
///Params:
///    namespaceVirtualizationContext = An opaque handle for the virtualization instance.
@DllImport("PROJECTEDFSLIB")
void PrjStopVirtualizing(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext);

///Purges the virtualization instance's negative path cache, if it is active.
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance.
///    totalEntryNumber = Optional pointer to a variable that receives the number of paths that were in the cache before it was purged.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjClearNegativePathCache(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                  uint* totalEntryNumber);

///Retrieves information about the virtualization instance.
///Params:
///    namespaceVirtualizationContext = An opaque handle for the virtualization instance.
///    virtualizationInstanceInfo = On input points to a buffer to fill with information about the virtualization instance. On successful return the
///                                 buffer is filled in.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjGetVirtualizationInstanceInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                         PRJ_VIRTUALIZATION_INSTANCE_INFO* virtualizationInstanceInfo);

///Converts an existing directory to a directory placeholder.
///Params:
///    rootPathName = A null-terminated Unicode string specifying the full path to the virtualization root.
///    targetPathName = A null-terminated Unicode string specifying the full path to the directory to convert to a placeholder. If this
///                     parameter is not specified or is an empty string, then this means the caller wants to designate rootPathName as
///                     the virtualization root. The provider only needs to do this one time, upon establishing a new virtualization
///                     instance.
///    versionInfo = Optional version information for the target placeholder. The provider chooses what information to put in the
///                  PRJ_PLACEHOLDER_VERSION_INFO structure. If not specified, the placeholder gets zeros for its version information.
///    virtualizationInstanceID = A value that identifies the virtualization instance.
///Returns:
///    HRESULT_FROM_WIN32(ERROR_REPARSE_POINT_ENCOUNTERED) typically means the directory at targetPathName has a reparse
///    point on it. HRESULT_FROM_WIN32(ERROR_DIRECTORY) typically means the targetPathName does not specify a directory.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjMarkDirectoryAsPlaceholder(const(PWSTR) rootPathName, const(PWSTR) targetPathName, 
                                      const(PRJ_PLACEHOLDER_VERSION_INFO)* versionInfo, 
                                      const(GUID)* virtualizationInstanceID);

///Sends file or directory metadata to ProjFS.
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance. This must be the value from the VirtualizationInstanceHandle
///                                     member of the callbackData passed to the provider in the PRJ_GET_PLACEHOLDER_INFO_CB callback.
///    destinationFileName = A null-terminated Unicode string specifying the path, relative to the virtualization root, to the file or
///                          directory for which to create a placeholder. This must be a match to the FilePathName member of the callbackData
///                          parameter passed to the provider in the PRJ_GET_PLACEHOLDER_INFO_CB callback. The provider should use the
///                          PrjFileNameCompare function to determine whether the two names match. For example, if the
///                          PRJ_GET_PLACEHOLDER_INFO_CB callback specifies “dir1\dir1\FILE.TXT” in callbackData-&gt;FilePathName, and the
///                          provider’s backing store contains a file called “File.txt” in the dir1\dir2 directory, and
///                          PrjFileNameCompare returns 0 when comparing the names “FILE.TXT” and “File.txt”, then the provider
///                          specifies “dir1\dir2\File.txt” as the value of this parameter.
///    placeholderInfo = A pointer to the metadata for the file or directory.
///    placeholderInfoSize = Size in bytes of the buffer pointed to by placeholderInfo.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjWritePlaceholderInfo(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                const(PWSTR) destinationFileName, const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                                uint placeholderInfoSize);

///Sends file or directory metadata to ProjFS and allows the caller to specify extended information.
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance. This must be the value from the VirtualizationInstanceHandle
///                                     member of the callbackData passed to the provider in the PRJ_GET_PLACEHOLDER_INFO_CB callback.
///    destinationFileName = A null-terminated Unicode string specifying the path, relative to the virtualization root, to the file or
///                          directory for which to create a placeholder. This must be a match to the FilePathName member of the callbackData
///                          parameter passed to the provider in the PRJ_GET_PLACEHOLDER_INFO_CB callback. The provider should use the
///                          PrjFileNameCompare function to determine whether the two names match. For example, if the
///                          PRJ_GET_PLACEHOLDER_INFO_CB callback specifies “dir1\dir1\FILE.TXT” in callbackData-&gt;FilePathName, and the
///                          provider’s backing store contains a file called “File.txt” in the dir1\dir2 directory, and
///                          PrjFileNameCompare returns 0 when comparing the names “FILE.TXT” and “File.txt”, then the provider
///                          specifies “dir1\dir2\File.txt” as the value of this parameter.
///    placeholderInfo = A pointer to the metadata for the file or directory.
///    placeholderInfoSize = Size in bytes of the buffer pointed to by placeholderInfo.
///    extendedInfo = A pointer to a PRJ_EXTENDED_INFO struct specifying extended information about the placeholder to be created.
///Returns:
///    If this function succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjWritePlaceholderInfo2(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                                 const(PWSTR) destinationFileName, const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                                 uint placeholderInfoSize, const(PRJ_EXTENDED_INFO)* ExtendedInfo);

///Enables a provider to update an item that has been cached on the local file system.
///Params:
///    namespaceVirtualizationContext = Opague handle for the virtualization instance.
///    destinationFileName = A null-terminated Unicode string specifying the path, relative to the virtualization root, to the file or
///                          directory to be updated.
///    placeholderInfo = A pointer to a PRJ_PLACEHOLDER_INFO buffer containing the updated metadata for the file or directory. If
///                      placeholderInfo-&gt;VersionInfo.ContentID contains a content identifier that is the same as the content
///                      identifier already on the file/directory, the call succeeds and no update takes place. Otherwise, if the call
///                      succeeds then placeholderInfo-&gt;VersionInfo.ContentID replaces the existing content identifier on the file.
///    placeholderInfoSize = The size in bytes of the buffer pointed to by placeholderInfo.
///    updateFlags = Flags to control updates. If the item is a dirty placeholder, full file, or tombstone, and the provider does not
///                  specify the appropriate flag(s), this routine will fail to update the placeholder
///    failureReason = Optional pointer to receive a code describing the reason an update failed.
///Returns:
///    If an HRESULT_FROM_WIN32(ERROR_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION) error is returned, the update failed
///    due to the item's state and the value of updateFlags. failureReason, if specified, will describe the reason for
///    the failure.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjUpdateFileIfNeeded(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                              const(PWSTR) destinationFileName, const(PRJ_PLACEHOLDER_INFO)* placeholderInfo, 
                              uint placeholderInfoSize, PRJ_UPDATE_TYPES updateFlags, 
                              PRJ_UPDATE_FAILURE_CAUSES* failureReason);

///Enables a provider to delete an item that has been cached on the local file system.
///Params:
///    namespaceVirtualizationContext = An opaque handle for the virtualization instance.
///    destinationFileName = A null-terminated Unicode string specifying the path, relative to the virtualization root, to the file or
///                          directory to be deleted.
///    updateFlags = Flags to control the delete operation should be allowed given the state of the file.
///    failureReason = Optional pointer to receive a code describing the reason a delete failed.
///Returns:
///    If an HRESULT_FROM_WIN32(ERROR_FILE_SYSTEM_VIRTUALIZATION_INVALID_OPERATION) error is returned, the update failed
///    due to the item's state and the value of updateFlags. failureReason, if specified, will describe the reason for
///    the failure.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjDeleteFile(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                      const(PWSTR) destinationFileName, PRJ_UPDATE_TYPES updateFlags, 
                      PRJ_UPDATE_FAILURE_CAUSES* failureReason);

///Provides the data requested in an invocation of the PRJ_GET_FILE_DATA_CB callback.
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance. If the provider is servicing a PRJ_GET_FILE_DATA_CB callback, this
///                                     must be the value from the VirtualizationInstanceHandle member of the callbackData passed to the provider in the
///                                     callback.
///    dataStreamId = Identifier for the data stream to write to. If the provider is servicing a PRJ_GET_FILE_DATA_CB callback, this
///                   must be the value from the DataStreamId member of the callbackData passed to the provider in the callback.
///    buffer = Pointer to a buffer containing the data to write. The buffer must be at least as large as the value of the length
///             parameter in bytes. The provider should use PrjAllocateAlignedBuffer to ensure that the buffer meets the storage
///             device's alignment requirements.
///    byteOffset = Byte offset from the beginning of the file at which to write the data.
///    length = The number of bytes to write to the file.
///Returns:
///    HRESULT_FROM_WIN32(ERROR_OFFSET_ALIGNMENT_VIOLATION) indicates that the user's handle was opened for unbuffered
///    I/O and byteOffset is not aligned to the sector size of the storage device.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjWriteFileData(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, 
                         const(GUID)* dataStreamId, void* buffer, ulong byteOffset, uint length);

///Gets the on-disk file state for a file or directory.
///Params:
///    destinationFileName = A null-terminated Unicode string specifying the full path to the file whose state is to be queried.
///    fileState = This is a combination of one or more PRJ_FILE_STATE values describing the file state.
///Returns:
///    HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND) indicates destinationFileName does not exist.
///    HRESULT_FROM_WIN32(ERROR_PATH_NOT_FOUND) indicates that an intermediate component of the path to
///    destinationFileName does not exist.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjGetOnDiskFileState(const(PWSTR) destinationFileName, PRJ_FILE_STATE* fileState);

///Allocates a buffer that meets the memory alignment requirements of the virtualization instance's storage device.
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance.
///    size = The size of the buffer required, in bytes.
@DllImport("PROJECTEDFSLIB")
void* PrjAllocateAlignedBuffer(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, size_t size);

///Frees an allocated buffer.
///Params:
///    buffer = The buffer to free.
@DllImport("PROJECTEDFSLIB")
void PrjFreeAlignedBuffer(void* buffer);

///Indicates that the provider has completed processing a callback from which it had previously returned
///HRESULT_FROM_WIN32(ERROR_IO_PENDING).
///Params:
///    namespaceVirtualizationContext = Opaque handle for the virtualization instance. This must be the value from the VirtualizationInstanceHandle
///                                     member of the callbackData passed to the provider in the callback that is being complete.
///    commandId = A value identifying the callback invocation that the provider is completing. This must be the value from the
///                CommandId member of the callbackData passed to the provider in the callback that is being completed.
///    completionResult = The final HRESULT of the operation.
///    extendedParameters = Optional pointer to extended parameters required for completing certain callbacks.
@DllImport("PROJECTEDFSLIB")
HRESULT PrjCompleteCommand(PRJ_NAMESPACE_VIRTUALIZATION_CONTEXT__* namespaceVirtualizationContext, int commandId, 
                           HRESULT completionResult, PRJ_COMPLETE_COMMAND_EXTENDED_PARAMETERS* extendedParameters);

///Provides information for one file or directory to an enumeration.
///Params:
///    fileName = A pointer to a null-terminated string that contains the name of the entry
///    fileBasicInfo = Basic information about the entry to be filled.
///    dirEntryBufferHandle = An opaque handle to a structure that receives information about the filled entries.
///Returns:
///    HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) indicates that dirEntryBufferHandle doesn't have enough space for
///    the new entry.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjFillDirEntryBuffer(const(PWSTR) fileName, PRJ_FILE_BASIC_INFO* fileBasicInfo, 
                              PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle);

///Provides information for one file or directory to an enumeration and allows the caller to specify extended
///information.
///Params:
///    dirEntryBufferHandle = An opaque handle to a structure that receives information about the filled entries.
///    fileName = A pointer to a null-terminated string that contains the name of the entry
///    fileBasicInfo = Basic information about the entry to be filled.
///    extendedInfo = A pointer to a PRJ_EXTENDED_INFO struct specifying extended information about the entry to be filled.
///Returns:
///    HRESULT_FROM_WIN32(ERROR_INSUFFICIENT_BUFFER) indicates that dirEntryBufferHandle doesn't have enough space for
///    the new entry. E_INVALIDARG indicates that extendedInfo.InfoType is unrecognized.
///    
@DllImport("PROJECTEDFSLIB")
HRESULT PrjFillDirEntryBuffer2(PRJ_DIR_ENTRY_BUFFER_HANDLE__* dirEntryBufferHandle, const(PWSTR) fileName, 
                               PRJ_FILE_BASIC_INFO* fileBasicInfo, PRJ_EXTENDED_INFO* extendedInfo);

///Determines whether a file name matches a search pattern.
///Params:
///    fileNameToCheck = A null-terminated Unicode string of at most MAX_PATH characters specifying the file name to check against
///                      pattern.
///    pattern = A null-terminated Unicode string of at most MAX_PATH characters specifying the pattern to compare against
///              fileNameToCheck.
///Returns:
///    True if fileNameToCheck matches pattern, False otherwise.
///    
@DllImport("PROJECTEDFSLIB")
ubyte PrjFileNameMatch(const(PWSTR) fileNameToCheck, const(PWSTR) pattern);

///Compares two file names and returns a value that indicates their relative collation order.
///Params:
///    fileName1 = A null-terminated Unicode string specifying the first name to compare.
///    fileName2 = A null-terminated Unicode string specifying the second name to compare.
///Returns:
///    <ul> <li>&lt;0 indicates fileName1 is before fileName2 in collation order</li> <li>0 indicates fileName1 is equal
///    to fileName2</li> <li>&gt;0 indicates fileName1 is after fileName2 in collation order</li> </ul>
///    
@DllImport("PROJECTEDFSLIB")
int PrjFileNameCompare(const(PWSTR) fileName1, const(PWSTR) fileName2);

///Determines whether a name contains wildcard characters.
///Params:
///    fileName = A null-terminated Unicode string to check for wildcard characters.
@DllImport("PROJECTEDFSLIB")
ubyte PrjDoesNameContainWildCards(const(PWSTR) fileName);


