// Written in the D programming language.

module windows.backgroundintelligenttransferservice;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.systemservices : BOOL, PWSTR;
public import windows.windowsprogramming : FILETIME;

extern(Windows) @nogc nothrow:


// Enums


///Defines constants that specify the context in which the error occurred.
alias BG_ERROR_CONTEXT = int;
enum : int
{
    ///An error has not occurred.
    BG_ERROR_CONTEXT_NONE                        = 0x00000000,
    ///The error context is unknown.
    BG_ERROR_CONTEXT_UNKNOWN                     = 0x00000001,
    ///The transfer queue manager generated the error.
    BG_ERROR_CONTEXT_GENERAL_QUEUE_MANAGER       = 0x00000002,
    ///The error was generated while the queue manager was notifying the client of an event.
    BG_ERROR_CONTEXT_QUEUE_MANAGER_NOTIFICATION  = 0x00000003,
    ///The error was related to the specified local file. For example, permission was denied, or the volume was
    ///unavailable.
    BG_ERROR_CONTEXT_LOCAL_FILE                  = 0x00000004,
    ///The error was related to the specified remote file. For example, the URL was not accessible.
    BG_ERROR_CONTEXT_REMOTE_FILE                 = 0x00000005,
    ///The transport layer generated the error. These errors are general transport failures (these errors are not
    ///specific to the remote file).
    BG_ERROR_CONTEXT_GENERAL_TRANSPORT           = 0x00000006,
    ///The server application to which BITS passed the upload file generated an error while processing the upload file.
    ///**BITS 1.2 and earlier:** Not supported.
    BG_ERROR_CONTEXT_REMOTE_APPLICATION          = 0x00000007,
    BG_ERROR_CONTEXT_SERVER_CERTIFICATE_CALLBACK = 0x00000008,
}

///Defines constants that specify the priority level of a job.
alias BG_JOB_PRIORITY = int;
enum : int
{
    ///Transfers the job in the foreground. Foreground transfers compete for network bandwidth with other applications,
    ///which can impede the user's network experience. This is the highest priority level.
    BG_JOB_PRIORITY_FOREGROUND = 0x00000000,
    ///Transfers the job in the background with a high priority. Background transfers use idle network bandwidth of the
    ///client to transfer files. This is the highest background priority level.
    BG_JOB_PRIORITY_HIGH       = 0x00000001,
    ///Transfers the job in the background with a normal priority. Background transfers use idle network bandwidth of
    ///the client to transfer files. This is the default priority level.
    BG_JOB_PRIORITY_NORMAL     = 0x00000002,
    ///Transfers the job in the background with a low priority. Background transfers use idle network bandwidth of the
    ///client to transfer files. This is the lowest background priority level.
    BG_JOB_PRIORITY_LOW        = 0x00000003,
}

///Defines constants that specify the different states of a job.
alias BG_JOB_STATE = int;
enum : int
{
    ///Specifies that the job is in the queue, and waiting to run. If a user logs off while their job is transferring,
    ///the job transitions to the queued state.
    BG_JOB_STATE_QUEUED          = 0x00000000,
    ///Specifies that BITS is trying to connect to the server. If the connection succeeds, the state of the job becomes
    ///<strong>BG_JOB_STATE_TRANSFERRING</strong>; otherwise, the state becomes
    ///<strong>BG_JOB_STATE_TRANSIENT_ERROR</strong>.
    BG_JOB_STATE_CONNECTING      = 0x00000001,
    ///Specifies that BITS is transferring data for the job.
    BG_JOB_STATE_TRANSFERRING    = 0x00000002,
    ///Specifies that the job is suspended (paused). To suspend a job, call the IBackgroundCopyJob::Suspend method. BITS
    ///automatically suspends a job when it is created. The job remains suspended until you call the
    ///IBackgroundCopyJob::Resume method, IBackgroundCopyJob::Complete method, or IBackgroundCopyJob::Cancel method.
    BG_JOB_STATE_SUSPENDED       = 0x00000003,
    ///Specifies that a nonrecoverable error occurred (the service is unable to transfer the file). If the
    ///error&mdash;such as an access-denied error&mdash;can be corrected, then call the [IBackgroundCopyJob::Resume
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-resume) after the error is fixed. However, if the
    ///error cannot be corrected, then call the [IBackgroundCopyJob::Cancel
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-cancel) to cancel the job, or call the
    ///[IBackgroundCopyJob::Complete method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-complete) to accept
    ///the portion of a download job that transferred successfully.
    BG_JOB_STATE_ERROR           = 0x00000004,
    ///Specifies that a recoverable error occurred. BITS will retry jobs in the transient error state based on the retry
    ///interval you specify (see [IBackgroundCopyJob::SetMinimumRetryDelay
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-setminimumretrydelay)). The state of the job changes
    ///to <strong>BG_JOB_STATE_ERROR</strong> if the job fails to make progress (see
    ///[IBackgroundCopyJob::SetNoProgressTimeout
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-setnoprogresstimeout)). BITS does not retry the job
    ///if a network disconnect or a disk lock error occurred (for example, `chkdsk` is running), or the
    ///[MaxInternetBandwidth](/windows/desktop/Bits/group-policies) Group Policy is zero.
    BG_JOB_STATE_TRANSIENT_ERROR = 0x00000005,
    ///Specifies that your job was successfully processed. You must call the [IBackgroundCopyJob::Complete
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-complete) to acknowledge completion of the job, and
    ///to make the files available to the client.
    BG_JOB_STATE_TRANSFERRED     = 0x00000006,
    ///Specifies that you called the [IBackgroundCopyJob::Complete
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-complete) to acknowledge that your job completed
    ///successfully.
    BG_JOB_STATE_ACKNOWLEDGED    = 0x00000007,
    ///Specifies that you called the [IBackgroundCopyJob::Cancel
    ///method](/windows/desktop/api/bits/nf-bits-ibackgroundcopyjob-cancel) to cancel the job (that is, to remove the
    ///job from the transfer queue).
    BG_JOB_STATE_CANCELLED       = 0x00000008,
}

///Defines constants that specify the type of transfer job, such as download.
alias BG_JOB_TYPE = int;
enum : int
{
    ///Specifies that the job downloads files to the client.
    BG_JOB_TYPE_DOWNLOAD     = 0x00000000,
    ///Specifies that the job uploads a file to the server. **BITS 1.2 and earlier:** not supported.
    BG_JOB_TYPE_UPLOAD       = 0x00000001,
    ///Specifies that the job uploads a file to the server, and receives a reply file from the server application.
    ///**BITS 1.2 and earlier:** not supported.
    BG_JOB_TYPE_UPLOAD_REPLY = 0x00000002,
}

///Defines constants that specify which proxy to use for file transfers. You can define different proxy settings for
///each job.
alias BG_JOB_PROXY_USAGE = int;
enum : int
{
    ///Use the proxy and proxy bypass list settings defined by each user to transfer files. Settings are user-defined
    ///from Control Panel, Internet Options, Connections, Local Area Network (LAN) settings (or Dial-up settings,
    ///depending on the network connection).
    BG_JOB_PROXY_USAGE_PRECONFIG  = 0x00000000,
    ///Do not use a proxy to transfer files. Use this option when you transfer files within a LAN.
    BG_JOB_PROXY_USAGE_NO_PROXY   = 0x00000001,
    ///Use the application's proxy and proxy bypass list to transfer files. Use this option when you can't trust that
    ///the system settings are correct. Also use this option when you want to transfer files using a special account,
    ///such as LocalSystem, to which the system settings do not apply.
    BG_JOB_PROXY_USAGE_OVERRIDE   = 0x00000002,
    ///Automatically detect proxy settings. BITS detects proxy settings for each file in the job. **BITS 1.5 and
    ///earlier:** **BG_JOB_PROXY_USAGE_AUTODETECT** is not available.
    BG_JOB_PROXY_USAGE_AUTODETECT = 0x00000003,
}

///Defines constants that specify whether the credentials are used for proxy or server user authentication requests.
alias BG_AUTH_TARGET = int;
enum : int
{
    ///Use credentials for server requests.
    BG_AUTH_TARGET_SERVER = 0x00000001,
    ///Use credentials for proxy requests.
    BG_AUTH_TARGET_PROXY  = 0x00000002,
}

///Defines constants that specify the authentication scheme to use when a proxy or server requests user authentication.
alias BG_AUTH_SCHEME = int;
enum : int
{
    ///<em>Basic</em> is a scheme in which the user name and password are sent in clear-text to the server or proxy.
    BG_AUTH_SCHEME_BASIC     = 0x00000001,
    ///<em>Digest</em> is a challenge-response scheme that uses a server-specified data string for the challenge.
    BG_AUTH_SCHEME_DIGEST    = 0x00000002,
    ///<em>NTLM</em> is a challenge-response scheme that uses the credentials of the user for authentication in a
    ///Windows network environment.
    BG_AUTH_SCHEME_NTLM      = 0x00000003,
    ///<em>Simple and Protected Negotiation</em> (Snego) is a challenge-response scheme that negotiates with the server
    ///or proxy to determine which scheme to use for authentication. Examples are the Kerberos protocol, and NTLM.
    BG_AUTH_SCHEME_NEGOTIATE = 0x00000004,
    ///<em>Passport</em> is a centralized authentication service provided by Microsoft that offers a single logon for
    ///member sites.
    BG_AUTH_SCHEME_PASSPORT  = 0x00000005,
}

///Defines constants that specify the location of the certificate store.
alias BG_CERT_STORE_LOCATION = int;
enum : int
{
    ///Use the current user's certificate store.
    BG_CERT_STORE_LOCATION_CURRENT_USER               = 0x00000000,
    ///Use the local computer's certificate store.
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE              = 0x00000001,
    ///Use the current service's certificate store.
    BG_CERT_STORE_LOCATION_CURRENT_SERVICE            = 0x00000002,
    ///Use a specific service's certificate store.
    BG_CERT_STORE_LOCATION_SERVICES                   = 0x00000003,
    ///Use a specific user's certificate store.
    BG_CERT_STORE_LOCATION_USERS                      = 0x00000004,
    ///Use the current user's group policy certificate store. In a network setting, stores in this location are
    ///downloaded to the client computer from the Group Policy Template (GPT) during computer startup, or user logon.
    BG_CERT_STORE_LOCATION_CURRENT_USER_GROUP_POLICY  = 0x00000005,
    ///Use the local computer's certificate store. In a network setting, stores in this location are downloaded to the
    ///client computer from the Group Policy Template (GPT) during computer startup, or user logon.
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_GROUP_POLICY = 0x00000006,
    ///Use the enterprise certificate store. The enterprise store is shared across domains in the enterprise, and
    ///downloaded from the global enterprise directory.
    BG_CERT_STORE_LOCATION_LOCAL_MACHINE_ENTERPRISE   = 0x00000007,
}

///Defines constants that specify ID values corresponding to BITS properties.
alias BITS_JOB_TRANSFER_POLICY = int;
enum : int
{
    ///Specifies that the job will be transferred when connectivity is available, regardless of the cost.
    BITS_JOB_TRANSFER_POLICY_ALWAYS       = 0x800000ff,
    ///Specifies that the job will be transferred when connectivity is available, unless that connectivity is subject to
    ///roaming surcharges.
    BITS_JOB_TRANSFER_POLICY_NOT_ROAMING  = 0x8000007f,
    ///Specifies that the job will be transferred only when connectivity is available which is not subject to a
    ///surcharge.
    BITS_JOB_TRANSFER_POLICY_NO_SURCHARGE = 0x8000006f,
    ///Specifies that the job will be transferred only when connectivity is available which is neither subject to a
    ///surcharge nor near exhaustion.
    BITS_JOB_TRANSFER_POLICY_STANDARD     = 0x80000067,
    BITS_JOB_TRANSFER_POLICY_UNRESTRICTED = 0x80000021,
}

///Defines constants that specify the ID of the property for the BITS job. This enumeration is used in the
///BITS_JOB_PROPERTY_VALUE union to determine the type of value contained in the union.
alias BITS_JOB_PROPERTY_ID = int;
enum : int
{
    ///The ID that is used to control transfer behavior over cellular and/or similar networks. This property may be
    ///changed while a transfer is ongoing – the new cost flags will take effect immediately. This property uses the
    ///<b>BITS_JOB_PROPERTY_VALUE</b>'s <b>DWORD</b> field.
    BITS_JOB_PROPERTY_ID_COST_FLAGS                    = 0x00000001,
    ///The ID that is used to register a COM callback by CLSID to receive notifications about the progress and
    ///completion of a BITS job. The CLSID must refer to a class associated with a registered out-of-process COM server.
    ///It may also be set to <b>GUID_NULL</b> to clear a previously set notification CLSID. This property uses the
    ///<b>BITS_JOB_PROPERTY_VALUE</b>’s <b>CLsID</b> field.
    BITS_JOB_PROPERTY_NOTIFICATION_CLSID               = 0x00000002,
    ///The ID for marking a BITS job as being willing to download content which does not support the normal HTTP
    ///requirements for BITS downloads: HEAD requests, the Content-Length header, and the Content-Range header.
    ///Downloading this type of content is opt-in, because BITS cannot pause and resume downloads jobs without that
    ///support. If a job with this property enabled is interrupted for any reason, such as a temporary loss of network
    ///connectivity or the system rebooting, BITS will restart the download from the beginning instead of resuming where
    ///it left off. BITS also cannot throttle bandwidth usage for dynamic downloads; BITS will not perform unthrottled
    ///transfers for any job that does not have <b>BG_JOB_PRIORITY_FOREGROUND</b> assigned, so you should typically set
    ///that priority every time you use set a job as allowing dynamic content. This property uses the
    ///<b>BITS_JOB_PROPERTY_VALUE</b>’s <b>Enable</b> field. This property is only supported for
    ///<b>BG_JOB_TYPE_DOWNLOAD</b> jobs. It is not supported for downloads that use <b>FILE_RANGES</b>. This property
    ///may only be set prior to the first time <b>Resume</b> is called on a job.
    BITS_JOB_PROPERTY_DYNAMIC_CONTENT                  = 0x00000003,
    ///The ID for marking a BITS job as not requiring strong reliability guarantees. Enabling this property will cause
    ///BITS to avoid persisting information about normal job progress, which BITS normally does periodically. In the
    ///event of an unexpected shutdown, such as a power loss, during a transfer, this will cause BITS to lose progress
    ///and restart the job from the beginning instead of resuming from where it left off as usual. However, it will also
    ///reduce the number of disk writes BITS makes over the course of a job’s lifetime, which can improve performance
    ///for smaller jobs. This property also causes BITS to download directly into the destination file, instead of
    ///downloading to a temporary file and moving the temporary file to the final destination once the transfer is
    ///complete. This means that BITS will not clean up any partially downloaded content if a job is cancelled or
    ///encounters a fatal error condition; the BITS caller is responsible for cleaning up the destination file, if it
    ///gets created. However, it will also slightly reduce disk overhead. This property is only recommended for
    ///scenarios which involve high numbers of small jobs (under 1MB) and which do not require reliability to power loss
    ///or other unexpected shutdown events. The performance savings are not generally significant for small numbers of
    ///jobs or for larger jobs. This property uses the <b>BITS_JOB_PROPERTY_VALUE</b>’s <b>Enable</b> field. This
    ///property is only supported for <b>BG_JOB_TYPE_DOWNLOAD</b> jobs. This property may only be set prior to adding
    ///any files to a job.
    BITS_JOB_PROPERTY_HIGH_PERFORMANCE                 = 0x00000004,
    ///The ID for marking the maximum number of bytes a BITS job will be allowed to download in total. This property is
    ///intended for use with <b>BITS_JOB_PROPERTY_DYNAMIC_CONTENT</b>, where you may not be able to determine the size
    ///of the file to be downloaded ahead of time but would like to cap the total possible download size. This property
    ///uses the <b>BITS_JOB_PROPERTY_VALUE</b>’s <b>Enable</b> field. This property is only supported for
    ///<b>BG_JOB_TYPE_DOWNLOAD</b> jobs. This property may only be set prior to the first time <b>Resume</b> is called
    ///on a job.
    BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE                = 0x00000005,
    ///The ID for marking a BITS job as being willing to include default credentials in requests to proxy servers.
    ///Enabling this property is equivalent to setting a WinHTTP security level of
    ///<b>WINHTTP_AUTOLOGON_SECURITY_LEVEL_MEDIUM</b> on the requests that BITS makes on the user’s behalf. The user
    ///BITS retrieves stored credentials from the is the same as the one it makes network requests on behalf of: BITS
    ///will normally use the job owner’s credentials, unless you have explicitly provided a network helper token, in
    ///which case BITS will use the network helper token’s credentials. This property uses the
    ///<b>BITS_JOB_PROPERTY_VALUE</b>’s <b>Target</b> field. However, only the <b>BG_AUTH_TARGET_PROXY</b> target is
    ///supported.
    BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS           = 0x00000007,
    ///The ID that is used to control the timing of BITS JobNotification and FileRangesTransferred notifications.
    ///Enabling this property lets a user be notified at a different rate. This property may be changed while a transfer
    ///is ongoing; however, the new rate may not be applied immediately. The default value is 500 milliseconds. This
    ///property uses the <b>BITS_JOB_PROPERTY_VALUE</b>’s <b>DWORD</b> field.
    BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS = 0x00000009,
    ///The ID that is used to control whether a job is in On Demand mode. On Demand jobs allow the app to request
    ///particular ranges for a file download instead of downloading from the start to the end. The default value is
    ///<b>FALSE</b>; the job is not on-demand. Ranges are requested using the IBackgroundCopyFile6::RequestFileRanges
    ///method. This property uses the <b>BITS_JOB_PROPERTY_VALUE</b>'s <b>Enable</b> field. The requirements for a
    ///<b>BITS_JOB_PROPERTY_ON_DEMAND_MODE</b> job is that the transfer must be a <b>BG_JOB_TYPE_DOWNLOAD</b> job. The
    ///job must not be <b>DYNAMIC</b> and the server must be an HTTP or HTTPS server and the server requirements for
    ///range support must all be met.
    BITS_JOB_PROPERTY_ON_DEMAND_MODE                   = 0x0000000a,
}

///Defines constants that specify ID values corresponding to background copy file properties. See
///[IBackgroundCopyFile5::GetProperty method](/windows/desktop/delivery_optimization/ibackgroundcopyfile5-getproperty)
///and [SetProperty method](/windows/desktop/delivery_optimization/ibackgroundcopyfile5-setproperty).
alias BITS_FILE_PROPERTY_ID = int;
enum : int
{
    ///The full set of HTTP response headers from the server's last HTTP response packet.
    BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS = 0x00000001,
}

///<p class="CCE_Message">[Queue Manager (QMGR) is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the Background
///Intelligent Transfer Service (BITS).] The <b>GROUPPROP</b> enumeration defines the constant values for retrieving and
///setting group property values.
alias GROUPPROP = int;
enum : int
{
    ///Determines when the QMGR processes the group relative to other groups in the queue. There is only one priority.
    ///You must specify a value of 1 when setting this property. The property always returns a value of 1. Variant data
    ///type can be VT_I4, VT_I2, VT_UI4, VT_UI2, VT_INT, or VT_UINT.
    GROUPPROP_PRIORITY        = 0x00000000,
    ///Not supported.
    GROUPPROP_REMOTEUSERID    = 0x00000001,
    ///Not supported.
    GROUPPROP_REMOTEUSERPWD   = 0x00000002,
    ///Not supported.
    GROUPPROP_LOCALUSERID     = 0x00000003,
    ///Not supported.
    GROUPPROP_LOCALUSERPWD    = 0x00000004,
    ///Specifies the protocol to use for the download. You must specify QM_PROTOCOL_HTTP when setting this property.
    ///Variant data type can be VT_I4, VT_I2, VT_UI4, VT_UI2, VT_INT, or VT_UINT.
    GROUPPROP_PROTOCOLFLAGS   = 0x00000005,
    ///Specifies the type of event notification to receive for the group. See Remarks. Variant data type can be VT_I4,
    ///VT_I2, VT_UI4, VT_UI2, VT_INT, or VT_UINT.
    GROUPPROP_NOTIFYFLAGS     = 0x00000006,
    ///The CLSID to activate when an event specified by <b>GROUPPROP_NOTIFYFLAGS</b> occurs. For more details on CLSID
    ///activation, see IBackgroundCopyCallback1. Variant data type is VT_BSTR.
    GROUPPROP_NOTIFYCLSID     = 0x00000007,
    ///Not supported.
    GROUPPROP_PROGRESSSIZE    = 0x00000008,
    ///Not supported.
    GROUPPROP_PROGRESSPERCENT = 0x00000009,
    ///Not supported.
    GROUPPROP_PROGRESSTIME    = 0x0000000a,
    ///Specifies a display name that can be used to identify the group in a user interface. The length of the string is
    ///limited to 256 characters, not including the null terminator. Variant data type is VT_BSTR.
    GROUPPROP_DISPLAYNAME     = 0x0000000b,
    ///Specifies a description to associate with the group. The length of the string is limited to 1,024 characters, not
    ///including the null terminator. Variant data type is VT_BSTR.
    GROUPPROP_DESCRIPTION     = 0x0000000c,
}

// Structs


///Provides file-related progress information, such as the number of bytes transferred.
struct BG_FILE_PROGRESS
{
    ///Size of the file in bytes. If BITS cannot determine the size of the file (for example, if the file or server does
    ///not exist), the value is BG_SIZE_UNKNOWN. If you are downloading ranges from a file, <b>BytesTotal</b> reflects
    ///the total number of bytes you want to download from the file.
    ulong BytesTotal;
    ///Number of bytes transferred.
    ulong BytesTransferred;
    ///For downloads, the value is <b>TRUE</b> if the file is available to the user; otherwise, the value is
    ///<b>FALSE</b>. Files are available to the user after calling the IBackgroundCopyJob::Complete method. If the
    ///<b>Complete</b> method generates a transient error, those files processed before the error occurred are available
    ///to the user; the others are not. Use the <b>Completed</b> member to determine if the file is available to the
    ///user when <b>Complete</b> fails. For uploads, the value is <b>TRUE</b> when the file upload is complete;
    ///otherwise, the value is <b>FALSE</b>.
    BOOL  Completed;
}

///Provides the local and remote names of the file to transfer.
struct BG_FILE_INFO
{
    ///Null-terminated string that contains the name of the file on the server (for example,
    ///http://&lt;server&gt;/&lt;path&gt;/file.ext). The format of the name must conform to the transfer protocol you
    ///use. You cannot use wildcards in the path or file name. The URL must contain only legal URL characters; no escape
    ///processing is performed. The URL is limited to 2,200 characters, not including the null terminator. Each segment
    ///of the URL is limited to MAX_PATH characters. You can use SMB to express the remote name of the file to download
    ///or upload; there is no SMB support for upload-reply jobs. You can specify the remote name as a UNC path, full
    ///path with a network drive, or use the "file://" prefix. <b>BITS 1.5 and earlier: </b>The SMB protocol for
    ///<b>RemoteName</b> is not supported.
    PWSTR RemoteName;
    ///Null-terminated string that contains the name of the file on the client. The file name must include the full path
    ///(for example, d:\myapp\updates\file.ext). You cannot use wildcards in the path or file name, and directories in
    ///the path must exist. The path is limited to MAX_PATH, not including the null terminator. The user must have
    ///permission to write to the local directory for downloads and the reply portion of an upload-reply job. BITS does
    ///not support NTFS streams. Instead of using network drives, which are session specific, use UNC paths (for
    ///example, \\server\share\path\file). Do not include the \\? prefix in the path.
    PWSTR LocalName;
}

///Provides job-related progress information, such as the number of bytes and files transferred. For upload jobs, the
///progress applies to the upload file, not the reply file. To view reply file progress, see the BG_JOB_REPLY_PROGRESS
///structure.
struct BG_JOB_PROGRESS
{
    ///Total number of bytes to transfer for all files in the job. If the value is BG_SIZE_UNKNOWN, the total size of
    ///all files in the job has not been determined. BITS does not set this value if it cannot determine the size of one
    ///of the files. For example, if the specified file or server does not exist, BITS cannot determine the size of the
    ///file. If you are downloading ranges from the file, <b>BytesTotal</b> includes the total number of bytes you want
    ///to download from the file.
    ulong BytesTotal;
    ///Number of bytes transferred.
    ulong BytesTransferred;
    ///Total number of files to transfer for this job.
    uint  FilesTotal;
    ///Number of files transferred.
    uint  FilesTransferred;
}

///Provides job-related time stamps.
struct BG_JOB_TIMES
{
    ///Time the job was created. The time is specified as FILETIME.
    FILETIME CreationTime;
    ///Time the job was last modified or bytes were transferred. Adding files or calling any of the set methods in the
    ///IBackgroundCopyJob* interfaces changes this value. In addition, changes to the state of the job and calling the
    ///Suspend, Resume, Cancel, and Complete methods change this value. The time is specified as FILETIME.
    FILETIME ModificationTime;
    ///Time the job entered the BG_JOB_STATE_TRANSFERRED state. The time is specified as FILETIME.
    FILETIME TransferCompletionTime;
}

///Provides progress information related to the reply portion of an upload-reply job.
struct BG_JOB_REPLY_PROGRESS
{
    ///Size of the file in bytes. The value is <b>BG_SIZE_UNKNOWN</b> if the reply has not begun.
    ulong BytesTotal;
    ///Number of bytes transferred.
    ulong BytesTransferred;
}

///Identifies the user name and password to authenticate.
struct BG_BASIC_CREDENTIALS
{
    ///A null-terminated string that contains the user name to authenticate. The user name is limited to 300 characters,
    ///not including the null terminator. The format of the user name depends on the authentication scheme requested.
    ///For example, for Basic, NTLM, and Negotiate authentication, the user name is of the form
    ///<em>DomainName</em><strong>\\</strong><em>UserName</em>. For Passport authentication, the user name is an email
    ///address. For more information, see Remarks. If <strong>NULL</strong>, default credentials for this session
    ///context are used.
    PWSTR UserName;
    ///A null-terminated string that contains the password in plaintext. The password is limited to 65536 characters,
    ///not including the null terminator. The password can be blank. Set it to <strong>NULL</strong> if
    ///<strong>UserName</strong> is <strong>NULL</strong>. BITS encrypts the password before persisting the job if a
    ///network disconnect occurs or the user logs off. Live ID encoded passwords are supported through Negotiate 2. For
    ///more information about Live IDs, see the Windows Live ID SDK.
    PWSTR Password;
}

///Identifies the credentials to use for the authentication scheme specified in the BG_AUTH_CREDENTIALS structure.
union BG_AUTH_CREDENTIALS_UNION
{
    ///Identifies the user name and password of the user to authenticate. For details, see the BG_BASIC_CREDENTIALS
    ///structure.
    BG_BASIC_CREDENTIALS Basic;
}

///Identifies the target (proxy or server), authentication scheme, and the user's credentials to use for user
///authentication requests. The structure is passed to the IBackgroundCopyJob2::SetCredentials method.
struct BG_AUTH_CREDENTIALS
{
    ///Identifies whether to use the credentials for a proxy or server authentication request. For a list of values, see
    ///the BG_AUTH_TARGET enumeration. You can specify only one value.
    BG_AUTH_TARGET Target;
    ///Identifies the scheme to use for authentication (for example, Basic or NTLM). For a list of values, see the
    ///BG_AUTH_SCHEME enumeration. You can specify only one value.
    BG_AUTH_SCHEME Scheme;
    ///Identifies the credentials to use for the specified authentication scheme. For details, see the
    ///BG_AUTH_CREDENTIALS_UNION union.
    BG_AUTH_CREDENTIALS_UNION Credentials;
}

///Identifies a range of bytes to download from a file.
struct BG_FILE_RANGE
{
    ///Zero-based offset to the beginning of the range of bytes to download from a file.
    ulong InitialOffset;
    ///The length of the range, in bytes. Do not specify a zero byte length. To indicate that the range extends to the
    ///end of the file, specify <b>BG_LENGTH_TO_EOF</b>.
    ulong Length;
}

///Provides the property value of the BITS job based on the value of the BITS_JOB_PROPERTY_ID enumeration.
union BITS_JOB_PROPERTY_VALUE
{
    ///This value is returned when using the enum property ID <b>BITS_JOB_PROPERTY_ID_COST_FLAGS</b> and is applied as
    ///the transfer policy on the BITS job. This value is also used when using the
    ///<b>BITS_JOB_PROPERTY_MINIMUM_NOTIFICATION_INTERVAL_MS</b> to specify the minimum notification interval.
    uint           Dword;
    ///This value is returned when using the enum property ID <b>BITS_JOB_PROPERTY_NOTIFICATION_CLSID</b> and represents
    ///the CLSID of the callback object to register with the BITS job.
    GUID           ClsID;
    ///This value is returned when using the enum property ID <b>BITS_JOB_PROPERTY_DYNAMIC_CONTENT</b> to specify
    ///whether the BITS job has dynamic content. This value is also returned when using the enum property ID
    ///<b>BITS_JOB_PROPERTY_HIGH_PERFORMANCE</b> to specify whether to mark the BITS job as an optimized download. This
    ///value is also used when using the <b>BITS_JOB_PROPERTY_ON_DEMAND_MODE</b> to specify whether the BITS job is in
    ///on demand or not.
    BOOL           Enable;
    ///This value is returned when using the enum property ID <b>BITS_JOB_PROPERTY_MAX_DOWNLOAD_SIZE</b> to represent
    ///the maximum allowed download size of an optimized download.
    ulong          Uint64;
    ///This value is returned when using the enum property ID <b>BITS_JOB_PROPERTY_USE_STORED_CREDENTIALS</b> to
    ///represent the intranet authentication target which is permitted to use stored credentials.
    BG_AUTH_TARGET Target;
}

///Provides the property value of the BITS file based on a value from the BITS_FILE_PROPERTY_ID enumeration.
union BITS_FILE_PROPERTY_VALUE
{
    ///This value is used when using the property ID enum value <b>BITS_FILE_PROPERTY_ID_HTTP_RESPONSE_HEADERS</b>.
    PWSTR String;
}

///<p class="CCE_Message">[Queue Manager (QMGR) is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the Background
///Intelligent Transfer Service (BITS).] The <b>FILESETINFO</b> structure identifies the remote and local names of the
///file to download.
struct FILESETINFO
{
    ///Null-terminated string that contains the name of the file on the server (for example,
    ///<b>http://</b><i>ServerName</i><b>/</b><i>Path</i><b>/</b><i>FileName</i><b>.</b><i>ext</i>). The format of the
    ///name must conform to the transfer protocol you use. You cannot use wildcards in the path or file name. The URL
    ///must only contain legal URL characters; no escape processing is performed. The URL is limited to 2,200
    ///characters, not including the terminating null character.
    BSTR bstrRemoteFile;
    ///Null-terminated string that contains the name of the file on the client. The file name must include the full
    ///path, for example, <b>D:\\</b><i>MyApp</i><b>\\</b><i>UpdatesPath</i><b>\\</b><i>FileName</i><b>.</b><i>ext</i>.
    ///You cannot use wildcards in the path or file name, and directories in the path must exist. The path is limited to
    ///MAX_PATH, not including the terminating null character. The user must have permission to write to the local
    ///directory for downloads and uploads that request a reply. BITS does not support NTFS streams. Instead of using
    ///network drives, which are session specific, use UNC paths (for example,
    ///<b>\\</b><i>ServerName</i><b>\\</b><i>ShareName</i><b>\\</b><i>Path</i><b>\\</b><i>FileName</i><b>.</b><i>ext</i>).
    BSTR bstrLocalFile;
    uint dwSizeHint;
}

// Interfaces

@GUID("4991D34B-80A1-4291-83B6-3328366B9097")
struct BackgroundCopyManager;

@GUID("F087771F-D74F-4C1A-BB8A-E16ACA9124EA")
struct BackgroundCopyManager1_5;

@GUID("6D18AD12-BDE3-4393-B311-099C346E6DF9")
struct BackgroundCopyManager2_0;

@GUID("03CA98D6-FF5D-49B8-ABC6-03DD84127020")
struct BackgroundCopyManager2_5;

@GUID("659CDEA7-489E-11D9-A9CD-000D56965251")
struct BackgroundCopyManager3_0;

@GUID("BB6DF56B-CACE-11DC-9992-0019B93A3A84")
struct BackgroundCopyManager4_0;

@GUID("1ECCA34C-E88A-44E3-8D6A-8921BDE9E452")
struct BackgroundCopyManager5_0;

@GUID("4BD3E4E1-7BD4-4A2B-9964-496400DE5193")
struct BackgroundCopyManager10_1;

@GUID("4575438F-A6C8-4976-B0FE-2F26B80D959E")
struct BackgroundCopyManager10_2;

@GUID("5FD42AD5-C04E-4D36-ADC7-E08FF15737AD")
struct BackgroundCopyManager10_3;

@GUID("EFBBAB68-7286-4783-94BF-9461D8B7E7E9")
struct BITSExtensionSetupFactory;

@GUID("69AD4AEE-51BE-439B-A92C-86AE490E8B30")
struct BackgroundCopyQMgr;

///<b>IBackgroundCopyFile</b> contains information about a file that is part of a job. For example, you can use
///<b>IBackgroundCopyFile</b> methods to retrieve the local and remote names of the file and transfer progress
///information. To get an <b>IBackgroundCopyFile</b> interface pointer, call the IBackgroundCopyError::GetFile method or
///the IEnumBackgroundCopyFiles::Next method.
@GUID("01B7BD23-FB88-4A77-8490-5891D3E4653A")
interface IBackgroundCopyFile : IUnknown
{
    ///Retrieves the remote name of the file.
    ///Params:
    ///    pVal = Null-terminated string that contains the remote name of the file to transfer. The name is fully qualified.
    ///           Call the CoTaskMemFree function to free <i>ppName</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetRemoteName(PWSTR* pVal);
    ///Retrieves the local name of the file.
    ///Params:
    ///    pVal = Null-terminated string that contains the name of the file on the client. The name is fully qualified. Call
    ///           the CoTaskMemFree function to free <i>ppName</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetLocalName(PWSTR* pVal);
    ///Retrieves information on the progress of the file transfer.
    ///Params:
    ///    pVal = Structure whose members indicate the progress of the file transfer. For details on the type of progress
    ///           information available, see the BG_FILE_PROGRESS structure.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetProgress(BG_FILE_PROGRESS* pVal);
}

///Use the <b>IEnumBackgroundCopyFiles</b> interface to enumerate the files that a job contains. To get an
///<b>IEnumBackgroundCopyFiles</b> interface pointer, call the IBackgroundCopyJob::EnumFiles method.
@GUID("CA51E165-C365-424C-8D41-24AAA4FF3C40")
interface IEnumBackgroundCopyFiles : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence. If there are fewer than the requested number
    ///of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of IBackgroundCopyFile objects. You must release each object in <i>rgelt</i> when done.
    ///    pceltFetched = Number of elements returned in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is
    ///                   one. Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IBackgroundCopyFile* rgelt, uint* pceltFetched);
    ///Skips the next specified number of elements in the enumeration sequence. If there are fewer elements left in the
    ///sequence than the requested number of elements to skip, it skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Reset();
    ///Creates another IEnumBackgroundCopyFiles enumerator that contains the same enumeration state as the current one.
    ///Using this method, a client can record a particular point in the enumeration sequence, and then return to that
    ///point at a later time. The new enumerator supports the same interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnumFiles</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Clone(IEnumBackgroundCopyFiles* ppenum);
    ///Retrieves a count of the number of files in the enumeration.
    ///Params:
    ///    puCount = Number of files in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetCount(uint* puCount);
}

///Use the <b>IBackgroundCopyError</b> interface to determine the cause of an error and if the transfer process can
///proceed. BITS creates an error object only when the state of the job is BG_JOB_STATE_ERROR or
///BG_JOB_STATE_TRANSIENT_ERROR. BITS does not create an error object when an <b>IBackgroundCopyXXXX</b> interface
///method fails. The error object is available until BITS begins transferring data (the state of the job changes to
///BG_JOB_STATE_TRANSFERRING) for the job or until your application exits. To get an <b>IBackgroundCopyError</b> object,
///call the IBackgroundCopyJob::GetError method.
@GUID("19C613A0-FCB8-4F28-81AE-897C3D078F81")
interface IBackgroundCopyError : IUnknown
{
    ///Retrieves the error code and identify the context in which the error occurred.
    ///Params:
    ///    pContext = Context in which the error occurred. For a list of context values, see the
    ///               [BG_ERROR_CONTEXT](./ne-bits-bg_error_context.md) enumeration.
    ///    pCode = Error code of the error that occurred.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM HRESULT values on error.
    ///    
    HRESULT GetError(BG_ERROR_CONTEXT* pContext, HRESULT* pCode);
    ///Retrieves an interface pointer to the file object associated with the error.
    ///Params:
    ///    pVal = An IBackgroundCopyFile interface pointer whose methods you use to determine the local and remote file names
    ///           associated with the error. The <i>ppFile</i> parameter is set to <b>NULL</b> if the error is not associated
    ///           with the local or remote file. When done, release <i>ppFile</i>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved an interface pointer to the file object. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_FILE_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The error is not
    ///    associated with a local or remote file. The <i>ppFile</i> parameter is set to <b>NULL</b>. </td> </tr>
    ///    </table>
    ///    
    HRESULT GetFile(IBackgroundCopyFile* pVal);
    ///Retrieves the error text associated with the error.
    ///Params:
    ///    LanguageId = Identifies the locale to use to generate the description. To create the language identifier, use the
    ///                 MAKELANGID macro. For example, to specify U.S. English, use the following code sample.
    ///                 <code>MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US)</code> To retrieve the system's default user language
    ///                 identifier, use the following calls. <code>LANGIDFROMLCID(GetThreadLocale())</code>
    ///    pErrorDescription = Null-terminated string that contains the error text associated with the error. Call the CoTaskMemFree
    ///                        function to free <i>ppErrorDescription</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Description of the error was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The <i>LanguageId</i> parameter cannot be 0. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_RESOURCE_LANG_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> No string is
    ///    available for the locale. </td> </tr> </table>
    ///    
    HRESULT GetErrorDescription(uint LanguageId, PWSTR* pErrorDescription);
    ///Retrieves the description of the context in which the error occurred.
    ///Params:
    ///    LanguageId = Identifies the locale to use to generate the description. To create the language identifier, use the
    ///                 MAKELANGID macro. For example, to specify U.S. English, use the following code sample.
    ///                 <code>MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US)</code> To retrieve the system's default user language
    ///                 identifier, use the following calls. <code>LANGIDFROMLCID(GetThreadLocale())</code>
    ///    pContextDescription = Null-terminated string that contains the description of the context in which the error occurred. Call the
    ///                          CoTaskMemFree function to free <i>ppContextDescription</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Description of the context was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_OUTOFMEMORY</b></dt> </dl> </td> <td width="60%"> Not enough memory is available to complete the
    ///    operation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%">
    ///    The <i>LanguageId</i> parameter cannot be 0. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_RESOURCE_LANG_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> No string is
    ///    available for the locale. </td> </tr> </table>
    ///    
    HRESULT GetErrorContextDescription(uint LanguageId, PWSTR* pContextDescription);
    ///Retrieves the protocol used to transfer the file. The remote file name identifies the protocol to use to transfer
    ///the file.
    ///Params:
    ///    pProtocol = Null-terminated string that contains the protocol used to transfer the file. The string contains "http" for
    ///                the HTTP protocol and "file" for the SMB protocol. The <i>ppProtocol</i> parameter is set to <b>NULL</b> if
    ///                the error is not related to the transfer protocol. Call the CoTaskMemFree function to free <i>ppProtocol</i>
    ///                when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the remote file protocol. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_PROTOCOL_NOT_AVAILABLE</b></dt> </dl> </td> <td width="60%"> The error is not associated with the
    ///    remote file transfer protocol. The <i>ppProtocol</i> parameter is set to <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetProtocol(PWSTR* pProtocol);
}

///Use the <b>IBackgroundCopyJob</b> interface to add files to the job, set the priority level of the job, determine the
///state of the job, and to start and stop the job. To create a job, call the IBackgroundCopyManager::CreateJob method.
///To get an <b>IBackgroundCopyJob</b> interface pointer to an existing job, call the IBackgroundCopyManager::GetJob
///method.
@GUID("37668D37-507E-4160-9316-26306D150B12")
interface IBackgroundCopyJob : IUnknown
{
    ///Adds multiple files to a job.
    ///Params:
    ///    cFileCount = Number of elements in <i>paFileSet</i>.
    ///    pFileSet = Array of BG_FILE_INFO structures that identify the local and remote file names of the files to transfer.
    ///               Upload jobs are restricted to a single file. If the array contains more than one element, or the job already
    ///               contains a file, the method returns BG_E_TOO_MANY_FILES.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Files were successfully added to the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_MANY_FILES</b></dt> </dl> </td> <td width="60%"> Upload jobs can only contain one file; you
    ///    cannot add more than one file to the job. None of the files in the array were added to the job. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>BG_E_TOO_MANY_FILES_IN_JOB</b></dt> </dl> </td> <td width="60%"> The
    ///    MaxFilesPerJob Group Policy setting determines how many files a job can contain. Adding the file to the job
    ///    exceeds the MaxFilesPerJob limit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> You can receive this error for one of the following reasons: <ul> <li>The local or
    ///    remote file name is not valid.</li> <li>The remote file name uses an unsupported protocol.</li> <li>The local
    ///    file name was specified using a relative path.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> User does not have permission to write to the
    ///    specified directory on the client. </td> </tr> </table>
    ///    
    HRESULT AddFileSet(uint cFileCount, BG_FILE_INFO* pFileSet);
    ///Adds a single file to the job.
    ///Params:
    ///    RemoteUrl = Null-terminated string that contains the name of the file on the server. For information on specifying the
    ///                remote name, see the <b>RemoteName</b> member and Remarks section of the BG_FILE_INFO structure.
    ///    LocalName = Null-terminated string that contains the name of the file on the client. For information on specifying the
    ///                local name, see the <b>LocalName</b> member and Remarks section of the BG_FILE_INFO structure.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> File was successfully added to the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_MANY_FILES</b></dt> </dl> </td> <td width="60%"> Upload jobs can only contain one file; you
    ///    cannot add another file to the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_MANY_FILES_IN_JOB</b></dt> </dl> </td> <td width="60%"> The MaxFilesPerJob Group Policy
    ///    setting determines how many files a job can contain. Adding the file to the job exceeds the MaxFilesPerJob
    ///    limit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> You
    ///    can receive this error for one of the following reasons: <ul> <li>The local or remote file name is not
    ///    valid.</li> <li>The remote file name uses an unsupported protocol.</li> <li>The local file name was specified
    ///    using a relative path.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl>
    ///    </td> <td width="60%"> User does not have permission to write to the specified directory on the client. </td>
    ///    </tr> </table>
    ///    
    HRESULT AddFile(const(PWSTR) RemoteUrl, const(PWSTR) LocalName);
    ///Retrieves an IEnumBackgroundCopyFiles interface pointer that you use to enumerate the files in a job.
    ///Params:
    ///    pEnum = IEnumBackgroundCopyFiles interface pointer that you use to enumerate the files in the job. Release
    ///            <i>ppEnumFiles</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT EnumFiles(IEnumBackgroundCopyFiles* pEnum);
    ///Suspends a job. New jobs, jobs that are in error, and jobs that have finished transferring files are
    ///automatically suspended.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully suspended the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT Suspend();
    ///Activates a new job or restarts a job that has been suspended.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Job was successfully restarted. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_EMPTY</b></dt> </dl> </td> <td width="60%"> There are no files to transfer. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot
    ///    be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT Resume();
    ///Deletes the job from the transfer queue and removes related temporary files from the client (downloads) and
    ///server (uploads).
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Job was successfully canceled. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_S_UNABLE_TO_DELETE_FILES</b></dt> </dl> </td> <td width="60%"> Job was successfully canceled;
    ///    however, the service was unable to delete the temporary files associated with the job. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> Cannot cancel a job whose
    ///    state is BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT Cancel();
    ///Ends the job and saves the transferred files on the client.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values. The method can also return errors related to
    ///    renaming the temporary copies of the transferred files to their given names. <table> <tr> <th>Return
    ///    code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> All files transferred successfully. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_S_PARTIAL_COMPLETE</b></dt> </dl> </td> <td width="60%"> A subset of the files transferred
    ///    successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_S_UNABLE_TO_DELETE_FILES</b></dt> </dl> </td>
    ///    <td width="60%"> Job was successfully completed; however, the service was unable to delete the temporary
    ///    files associated with the job. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt>
    ///    </dl> </td> <td width="60%"> For downloads, the state of the job cannot be BG_JOB_STATE_CANCELLED or
    ///    BG_JOB_STATE_ACKNOWLEDGED. For uploads, the state of the job must be BG_JOB_STATE_TRANSFERRED. </td> </tr>
    ///    </table>
    ///    
    HRESULT Complete();
    ///Retrieves the identifier used to identify the job in the queue.
    ///Params:
    ///    pVal = GUID that identifies the job within the BITS queue.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetId(GUID* pVal);
    ///Retrieves the type of transfer being performed, such as a file download or upload.
    ///Params:
    ///    pVal = Type of transfer being performed. For a list of transfer types, see the BG_JOB_TYPE enumeration.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Transfer type was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pJobType</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetType(BG_JOB_TYPE* pVal);
    ///Retrieves job-related progress information, such as the number of bytes and files transferred.
    ///Params:
    ///    pVal = Contains data that you can use to calculate the percentage of the job that is complete. For more information,
    ///           see BG_JOB_PROGRESS.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Progress information was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pProgress</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetProgress(BG_JOB_PROGRESS* pVal);
    ///Retrieves job-related time stamps, such as the time that the job was created or last modified.
    ///Params:
    ///    pVal = Contains job-related time stamps. For available time stamps, see the BG_JOB_TIMES structure.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Time stamps were successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pTimes</i> parameter cannot be <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetTimes(BG_JOB_TIMES* pVal);
    ///Retrieves the state of the job.
    ///Params:
    ///    pVal = The state of the job. For example, the state reflects whether the job is in error, transferring data, or
    ///           suspended. For a list of job states, see the BG_JOB_STATE enumeration.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> The state of the job was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter, <i>pJobState</i>, cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetState(BG_JOB_STATE* pVal);
    ///Retrieves the error interface after an error occurs. BITS generates an error object when the state of the job is
    ///BG_JOB_STATE_ERROR or BG_JOB_STATE_TRANSIENT_ERROR. The service does not create an error object when a call to an
    ///<b>IBackgroundCopyXXXX</b> interface method fails. The error object is available until BITS begins transferring
    ///data (the state of the job changes to BG_JOB_STATE_TRANSFERRING) for the job or until your application exits.
    ///Params:
    ///    ppError = Error interface that provides the error code, a description of the error, and the context in which the error
    ///              occurred. This parameter also identifies the file being transferred at the time the error occurred. Release
    ///              <i>ppError</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully generated the error object. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_ERROR_INFORMATION_UNAVAILABLE</b></dt> </dl> </td> <td width="60%"> The error interface is
    ///    available only after an error occurs (BG_JOB_STATE_ERROR or BG_JOB_STATE_TRANSIENT_ERROR) and before BITS
    ///    begins transferring data (BG_JOB_STATE_TRANSFERRING). </td> </tr> </table>
    ///    
    HRESULT GetError(IBackgroundCopyError* ppError);
    ///Retrieves the identity of the job's owner.
    ///Params:
    ///    pVal = Null-terminated string that contains the string version of the SID that identifies the job's owner. Call the
    ///           CoTaskMemFree function to free <i>ppOwner</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Job owner's identity was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppOwner</i> parameter cannot be <b>NULL</b>.
    ///    </td> </tr> </table>
    ///    
    HRESULT GetOwner(PWSTR* pVal);
    ///Specifies a display name for the job. Typically, you use the display name to identify the job in a user
    ///interface.
    ///Params:
    ///    Val = Null-terminated string that identifies the job. Must not be <b>NULL</b>. The length of the string is limited
    ///          to 256 characters, not including the null terminator.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Display name was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pDisplayName</i> parameter cannot be
    ///    <b>NULL</b> or the name exceeds 256 characters. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_STRING_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The display name exceeds 256 characters.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The
    ///    state of the job cannot be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetDisplayName(const(PWSTR) Val);
    ///Retrieves the display name for the job. Typically, you use the display name to identify the job in a user
    ///interface.
    ///Params:
    ///    pVal = Null-terminated string that contains the display name that identifies the job. More than one job can have the
    ///           same display name. Call the CoTaskMemFree function to free <i>ppDisplayName</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Display name was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>ppDisplayName</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDisplayName(PWSTR* pVal);
    ///Provides a description of the job.
    ///Params:
    ///    Val = Null-terminated string that provides additional information about the job. The length of the string is
    ///          limited to 1,024 characters, not including the null terminator.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Description of the job was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pDescription</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_STRING_TOO_LONG</b></dt> </dl> </td> <td
    ///    width="60%"> The description exceeds 1,024 characters. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetDescription(const(PWSTR) Val);
    ///Retrieves the description of the job.
    ///Params:
    ///    pVal = Null-terminated string that contains a short description of the job. Call the CoTaskMemFree function to free
    ///           <i>ppDescription</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Description of the job was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The parameter, <i>ppDescription</i>, cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetDescription(PWSTR* pVal);
    ///Specifies the priority level of your job. The priority level determines when your job is processed relative to
    ///other jobs in the transfer queue.
    ///Params:
    ///    Val = Specifies the priority level of your job relative to other jobs in the transfer queue. The default is
    ///          BG_JOB_PRIORITY_NORMAL. For a list of priority levels, see the BG_JOB_PRIORITY enumeration.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Job priority was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The value for <i>Priority</i> is not defined in the
    ///    BG_JOB_PRIORITY enumeration. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl>
    ///    </td> <td width="60%"> The state of the job cannot be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED.
    ///    </td> </tr> </table>
    ///    
    HRESULT SetPriority(BG_JOB_PRIORITY Val);
    ///Retrieves the priority level for the job. The priority level determines when the job is processed relative to
    ///other jobs in the transfer queue.
    ///Params:
    ///    pVal = Priority of the job relative to other jobs in the transfer queue.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Priority level was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pPriority</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetPriority(BG_JOB_PRIORITY* pVal);
    ///Specifies the type of event notification you want to receive, such as job transferred events.
    ///Params:
    ///    Val = Set one or more of the following flags to identify the events that you want to receive. <table> <tr>
    ///          <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BG_NOTIFY_JOB_TRANSFERRED"></a><a
    ///          id="bg_notify_job_transferred"></a><dl> <dt><b>BG_NOTIFY_JOB_TRANSFERRED</b></dt> <dt>0x0001</dt> </dl> </td>
    ///          <td width="60%"> All of the files in the job have been transferred. </td> </tr> <tr> <td width="40%"><a
    ///          id="BG_NOTIFY_JOB_ERROR"></a><a id="bg_notify_job_error"></a><dl> <dt><b>BG_NOTIFY_JOB_ERROR</b></dt>
    ///          <dt>0x0002</dt> </dl> </td> <td width="60%"> An error has occurred. </td> </tr> <tr> <td width="40%"><a
    ///          id="BG_NOTIFY_DISABLE"></a><a id="bg_notify_disable"></a><dl> <dt><b>BG_NOTIFY_DISABLE</b></dt>
    ///          <dt>0x0004</dt> </dl> </td> <td width="60%"> Event notification is disabled. BITS ignores the other flags.
    ///          </td> </tr> <tr> <td width="40%"><a id="BG_NOTIFY_JOB_MODIFICATION"></a><a
    ///          id="bg_notify_job_modification"></a><dl> <dt><b>BG_NOTIFY_JOB_MODIFICATION</b></dt> <dt>0x0008</dt> </dl>
    ///          </td> <td width="60%"> The job has been modified. For example, a property value changed, the state of the job
    ///          changed, or progress is made transferring the files. This flag is ignored in command-line callbacks if
    ///          command line notification is specified. </td> </tr> <tr> <td width="40%"><a
    ///          id="BG_NOTIFY_FILE_TRANSFERRED"></a><a id="bg_notify_file_transferred"></a><dl>
    ///          <dt><b>BG_NOTIFY_FILE_TRANSFERRED</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> A file in the job has
    ///          been transferred. This flag is ignored in command-line callbacks if command line notification is specified.
    ///          </td> </tr> <tr> <td width="40%"><a id="BG_NOTIFY_FILE_RANGES_TRANSFERRED"></a><a
    ///          id="bg_notify_file_ranges_transferred"></a><dl> <dt><b>BG_NOTIFY_FILE_RANGES_TRANSFERRED</b></dt>
    ///          <dt>0x0020</dt> </dl> </td> <td width="60%"> A range of bytes in the file has been transferred. This flag is
    ///          ignored in command-line callbacks if command line notification is specified. The flag can be specified for
    ///          any job, but you will only get notifications for jobs that meet the requirements for a
    ///          <b>BITS_JOB_PROPERTY_ON_DEMAND_MODE</b> job. </td> </tr> </table>
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Type of event notification was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The <i>NotifyFlags</i> value is not valid. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the
    ///    job cannot be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetNotifyFlags(uint Val);
    ///Retrieves the event notification flags for the job.
    ///Params:
    ///    pVal = Identifies the events that your application receives. The following table lists the event notification flag
    ///           values. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///           id="BG_NOTIFY_JOB_TRANSFERRED"></a><a id="bg_notify_job_transferred"></a><dl>
    ///           <dt><b>BG_NOTIFY_JOB_TRANSFERRED</b></dt> </dl> </td> <td width="60%"> All of the files in the job have been
    ///           transferred. </td> </tr> <tr> <td width="40%"><a id="BG_NOTIFY_JOB_ERROR"></a><a
    ///           id="bg_notify_job_error"></a><dl> <dt><b>BG_NOTIFY_JOB_ERROR</b></dt> </dl> </td> <td width="60%"> An error
    ///           has occurred. </td> </tr> <tr> <td width="40%"><a id="BG_NOTIFY_DISABLE"></a><a
    ///           id="bg_notify_disable"></a><dl> <dt><b>BG_NOTIFY_DISABLE</b></dt> </dl> </td> <td width="60%"> Event
    ///           notification is disabled. If set, BITS ignores the other flags. </td> </tr> <tr> <td width="40%"><a
    ///           id="BG_NOTIFY_JOB_MODIFICATION"></a><a id="bg_notify_job_modification"></a><dl>
    ///           <dt><b>BG_NOTIFY_JOB_MODIFICATION</b></dt> </dl> </td> <td width="60%"> The job has been modified. </td>
    ///           </tr> </table>
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Event notify flags were successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Must pass the address of <i>pNotifyFlags</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetNotifyFlags(uint* pVal);
    ///Identifies your implementation of the IBackgroundCopyCallback interface to BITS. Use the
    ///<b>IBackgroundCopyCallback</b> interface to receive notification of job-related events.
    ///Params:
    ///    Val = An IBackgroundCopyCallback interface pointer. To remove the current callback interface pointer, set this
    ///          parameter to <b>NULL</b>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Notification interface pointer was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetNotifyInterface(IUnknown Val);
    ///Retrieves the interface pointer to your implementation of the IBackgroundCopyCallback interface.
    ///Params:
    ///    pVal = Interface pointer to your implementation of the IBackgroundCopyCallback interface. When done, release
    ///           <i>ppNotifyInterface</i>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Notification interface pointer was successfully retrieved. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Must pass the address of the
    ///    <i>ppNotifyInterface</i> interface pointer. </td> </tr> </table>
    ///    
    HRESULT GetNotifyInterface(IUnknown* pVal);
    ///Sets the minimum length of time that BITS waits after encountering a transient error condition before trying to
    ///transfer the file.
    ///Params:
    ///    Seconds = Minimum length of time, in seconds, that BITS waits after encountering a transient error before trying to
    ///              transfer the file. The default retry delay is 600 seconds (10 minutes). The minimum retry delay that you can
    ///              specify is 5 seconds. If you specify a value less than 5 seconds, BITS changes the value to 5 seconds. If the
    ///              value exceeds the no-progress-timeout value retrieved from the GetNoProgressTimeout method, BITS will not
    ///              retry the transfer and moves the job to the BG_JOB_STATE_ERROR state.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Retry delay was successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetMinimumRetryDelay(uint Seconds);
    ///Retrieves the minimum length of time that the service waits after encountering a transient error condition before
    ///trying to transfer the file.
    ///Params:
    ///    Seconds = Length of time, in seconds, that the service waits after encountering a transient error before trying to
    ///              transfer the file.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetMinimumRetryDelay(uint* Seconds);
    ///Sets the length of time that BITS tries to transfer the file after a transient error condition occurs. If there
    ///is progress, the timer is reset.
    ///Params:
    ///    Seconds = Length of time, in seconds, that BITS tries to transfer the file after the first transient error occurs. The
    ///              default retry period is 1,209,600 seconds (14 days). Set the retry period to 0 to prevent retries and to
    ///              force the job into the BG_JOB_STATE_ERROR state for all errors. If the retry period value exceeds the
    ///              JobInactivityTimeout Group Policy value (90-day default), BITS cancels the job after the policy value is
    ///              exceeded.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Retry period successfully set. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetNoProgressTimeout(uint Seconds);
    ///Retrieves the length of time that the service tries to transfer the file after a transient error condition
    ///occurs. If there is progress, the timer is reset.
    ///Params:
    ///    Seconds = Length of time, in seconds, that the service tries to transfer the file after a transient error occurs.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Time-out was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Must pass the address of <i>pRetryPeriod</i>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetNoProgressTimeout(uint* Seconds);
    ///Retrieves the number of times BITS tried to transfer the job and an error occurred.
    ///Params:
    ///    Errors = Number of errors that occurred while BITS tried to transfer the job. The count increases when the job moves
    ///             from the BG_JOB_STATE_TRANSFERRING state to the BG_JOB_STATE_TRANSIENT_ERROR or BG_JOB_STATE_ERROR state.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetErrorCount(uint* Errors);
    ///Specifies which proxy to use to transfer files.
    ///Params:
    ///    ProxyUsage = Specifies whether to use the user's proxy settings, not to use a proxy, or to use application-specified proxy
    ///                 settings. The default is to use the user's proxy settings, <b>BG_JOB_PROXY_USAGE_PRECONFIG</b>. For a list of
    ///                 proxy options, see the BG_JOB_PROXY_USAGE enumeration.
    ///    ProxyList = Null-terminated string that contains the proxies to use to transfer files. The list is space-delimited. For
    ///                details on specifying a proxy, see Remarks. This parameter must be <b>NULL</b> if the value of
    ///                <i>ProxyUsage</i> is <b>BG_JOB_PROXY_USAGE_PRECONFIG</b>, <b>BG_JOB_PROXY_USAGE_NO_PROXY</b>, or
    ///                <b>BG_JOB_PROXY_USAGE_AUTODETECT</b>. The length of the proxy list is limited to 4,000 characters, not
    ///                including the null terminator.
    ///    ProxyBypassList = Null-terminated string that contains an optional list of host names, IP addresses, or both, that can bypass
    ///                      the proxy. The list is space-delimited. For details on specifying a bypass proxy, see Remarks. This parameter
    ///                      must be <b>NULL</b> if the value of <i>ProxyUsage</i> is <b>BG_JOB_PROXY_USAGE_PRECONFIG</b>,
    ///                      <b>BG_JOB_PROXY_USAGE_NO_PROXY</b>, or <b>BG_JOB_PROXY_USAGE_AUTODETECT</b>. The length of the proxy bypass
    ///                      list is limited to 4,000 characters, not including the null terminator.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Proxy was successfully specified. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The value for <i>ProxyUsage</i> is not defined in the
    ///    BG_JOB_PROXY_USAGE enumeration. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_PROXY_LIST_TOO_LARGE</b></dt> </dl> </td> <td width="60%"> The <i>pProxyList</i> buffer cannot
    ///    exceed 32 KB. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_PROXY_BYPASS_LIST_TOO_LARGE</b></dt> </dl>
    ///    </td> <td width="60%"> The <i>pProxyBypassList</i> cannot exceed 32 KB. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    <b>BG_JOB_STATE_CANCELLED</b> or <b>BG_JOB_STATE_ACKNOWLEDGED</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pProxyList</i> parameter cannot be
    ///    <b>NULL</b> if <i>ProxyUsage</i> is <b>BG_JOB_PROXY_USAGE_OVERRIDE</b>. </td> </tr> </table>
    ///    
    HRESULT SetProxySettings(BG_JOB_PROXY_USAGE ProxyUsage, const(PWSTR) ProxyList, const(PWSTR) ProxyBypassList);
    ///Retrieves the proxy information that the job uses to transfer the files.
    ///Params:
    ///    pProxyUsage = Specifies the proxy settings the job uses to transfer the files. For a list of proxy options, see the
    ///                  BG_JOB_PROXY_USAGE enumeration.
    ///    pProxyList = Null-terminated string that contains one or more proxies to use to transfer files. The list is
    ///                 space-delimited. For details on the format of the string, see the Listing Proxy Servers section of Enabling
    ///                 Internet Functionality. Call the CoTaskMemFree function to free <i>ppProxyList</i> when done.
    ///    pProxyBypassList = Null-terminated string that contains an optional list of host names or IP addresses, or both, that were not
    ///                       routed through the proxy. The list is space-delimited. For details on the format of the string, see the
    ///                       Listing the Proxy Bypass section of Enabling Internet Functionality. Call the CoTaskMemFree function to free
    ///                       <i>ppProxyBypassList</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Proxy information was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> One or more of the parameters is <b>NULL</b>. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetProxySettings(BG_JOB_PROXY_USAGE* pProxyUsage, PWSTR* pProxyList, PWSTR* pProxyBypassList);
    ///Changes ownership of the job to the current user.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Job ownership was successfully changed. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_NEW_OWNER_NO_FILE_ACCESS</b></dt> </dl> </td> <td width="60%"> The new owner has insufficient
    ///    access to the temporary files on the client computer. BITS creates the temporary files using the owner's
    ///    security permissions. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_NEW_OWNER_DIFF_MAPPING</b></dt>
    ///    </dl> </td> <td width="60%"> The current owner's network drive mapping for the local file is different from
    ///    the previous owner's. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> User does not have administrator privileges. </td> </tr> </table>
    ///    
    HRESULT TakeOwnership();
}

///Use the <b>IEnumBackgroundCopyJobs</b> interface to enumerate the list of jobs in the transfer queue. To get an
///<b>IEnumBackgroundCopyJobs</b> interface pointer, call the IBackgroundCopyManager::EnumJobs method.
@GUID("1AF4F612-3B71-466F-8F58-7B6F73AC57AD")
interface IEnumBackgroundCopyJobs : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence. If there are fewer than the requested number
    ///of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of IBackgroundCopyJob objects. You must release each object in <i>rgelt</i> when done.
    ///    pceltFetched = Number of elements returned in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is
    ///                   one. Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IBackgroundCopyJob* rgelt, uint* pceltFetched);
    ///Skips the next specified number of elements in the enumeration sequence. If there are fewer elements left in the
    ///sequence than the requested number of elements to skip, it skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Reset();
    ///Creates another IEnumBackgroundCopyJobs enumerator that contains the same enumeration state as the current one.
    ///Using this method, a client can record a particular point in the enumeration sequence, and then return to that
    ///point at a later time. The new enumerator supports the same interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnumJobs</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Clone(IEnumBackgroundCopyJobs* ppenum);
    ///Retrieves a count of the number of jobs in the enumeration.
    ///Params:
    ///    puCount = Number of jobs in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetCount(uint* puCount);
}

///Implement the <b>IBackgroundCopyCallback</b> interface to receive notification that a job is complete, has been
///modified, or is in error. Clients use this interface instead of polling for the status of the job.
@GUID("97EA99C7-0186-4AD4-8DF9-C5B4E0ED6B22")
interface IBackgroundCopyCallback : IUnknown
{
    ///BITS calls your implementation of the <b>JobTransferred</b> method when all of the files in the job have been
    ///successfully transferred. For BG_JOB_TYPE_UPLOAD_REPLY jobs, BITS calls the <b>JobTransferred</b> method after
    ///the upload file has been transferred to the server and the reply has been transferred to the client.
    ///Params:
    ///    pJob = Contains job-related information, such as the time the job completed, the number of bytes transferred, and
    ///           the number of files transferred. Do not release <i>pJob</i>; BITS releases the interface when the method
    ///           returns.
    ///Returns:
    ///    This method should return <b>S_OK</b>; otherwise, BITS continues to call this method until <b>S_OK</b> is
    ///    returned. For performance reasons, you should limit the number of times you return a value other than
    ///    <b>S_OK</b> to a few times. As an alternative to returning an error code, consider always returning
    ///    <b>S_OK</b> and handling the error internally. The interval at which this method is called is arbitrary. Note
    ///    that if this method fails and you called the IBackgroundCopyJob2::SetNotifyCmdLine method, the command line
    ///    is executed and this method is not called again.
    ///    
    HRESULT JobTransferred(IBackgroundCopyJob pJob);
    ///BITS calls your implementation of the <b>JobError</b> method when the state of the job changes to
    ///BG_JOB_STATE_ERROR.
    ///Params:
    ///    pJob = Contains job-related information, such as the number of bytes and files transferred before the error
    ///           occurred. It also contains the methods to resume and cancel the job. Do not release <i>pJob</i>; BITS
    ///           releases the interface when the <b>JobError</b> method returns.
    ///    pError = Contains error information, such as the file being processed at the time the fatal error occurred and a
    ///             description of the error. Do not release <i>pError</i>; BITS releases the interface when the <b>JobError</b>
    ///             method returns.
    ///Returns:
    ///    This method should return <b>S_OK</b>; otherwise, BITS continues to call this method until <b>S_OK</b> is
    ///    returned. For performance reasons, you should limit the number of times you return a value other than
    ///    <b>S_OK</b> to a few times. As an alternative to returning an error code, consider always returning
    ///    <b>S_OK</b> and handling the error internally. The interval at which this method is called is arbitrary. Note
    ///    that if this method fails and you called the IBackgroundCopyJob2::SetNotifyCmdLine method, the command line
    ///    is executed and this method is not called again.
    ///    
    HRESULT JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    ///BITS calls your implementation of the <b>JobModification</b> method when the job has been modified. The service
    ///generates this event when bytes are transferred, files have been added to the job, properties have been modified,
    ///or the state of the job has changed.
    ///Params:
    ///    pJob = Contains the methods for accessing property, progress, and state information of the job. Do not release
    ///           <i>pJob</i>; BITS releases the interface when the <b>JobModification</b> method returns.
    ///    dwReserved = Reserved for future use.
    ///Returns:
    ///    This method should return <b>S_OK</b>.
    ///    
    HRESULT JobModification(IBackgroundCopyJob pJob, uint dwReserved);
}

@GUID("CA29D251-B4BB-4679-A3D9-AE8006119D54")
interface AsyncIBackgroundCopyCallback : IUnknown
{
    HRESULT Begin_JobTransferred(IBackgroundCopyJob pJob);
    HRESULT Finish_JobTransferred();
    HRESULT Begin_JobError(IBackgroundCopyJob pJob, IBackgroundCopyError pError);
    HRESULT Finish_JobError();
    HRESULT Begin_JobModification(IBackgroundCopyJob pJob, uint dwReserved);
    HRESULT Finish_JobModification();
}

///Creates transfer jobs, retrieves an enumerator object that contains the jobs in the queue, and retrieves individual
///jobs from the queue. For information on how to create an instance of this interface, see Connecting to the BITS
///Service.
@GUID("5CE34C0D-0DC9-4C1F-897C-DAA1B78CEE7C")
interface IBackgroundCopyManager : IUnknown
{
    ///Creates a job.
    ///Params:
    ///    DisplayName = Null-terminated string that contains a display name for the job. Typically, the display name is used to
    ///                  identify the job in a user interface. Note that more than one job may have the same display name. Must not be
    ///                  <b>NULL</b>. The name is limited to 256 characters, not including the null terminator.
    ///    Type = Type of transfer job, such as BG_JOB_TYPE_DOWNLOAD. For a list of transfer types, see the BG_JOB_TYPE
    ///           enumeration.
    ///    pJobId = Uniquely identifies your job in the queue. Use this identifier when you call the
    ///             IBackgroundCopyManager::GetJob method to get a job from the queue.
    ///    ppJob = An IBackgroundCopyJob interface pointer that you use to modify the job's properties and specify the files to
    ///            be transferred. To activate the job in the queue, call the IBackgroundCopyJob::Resume method. Release
    ///            <i>ppJob</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully generated the new job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The display name is too long. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_TOO_MANY_JOBS_PER_MACHINE</b></dt> </dl> </td> <td width="60%"> The
    ///    MaxJobsPerMachine Group Policy setting determines how many jobs can be created on the computer. Adding this
    ///    job exceeds the MaxJobsPerMachine limit. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_MANY_JOBS_PER_USER</b></dt> </dl> </td> <td width="60%"> The MaxJobsPerUser Group Policy
    ///    setting determines how many jobs a user can create. Adding this job exceeds the MaxJobsPerUser limit. </td>
    ///    </tr> </table>
    ///    
    HRESULT CreateJob(const(PWSTR) DisplayName, BG_JOB_TYPE Type, GUID* pJobId, IBackgroundCopyJob* ppJob);
    HRESULT GetJobA(const(GUID)* jobID, IBackgroundCopyJob* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs* ppEnum);
    ///Retrieves a description for the specified error code.
    ///Params:
    ///    hResult = Error code from a previous call to a BITS method.
    ///    LanguageId = Identifies the language identifier to use to generate the description. To create the language identifier, use
    ///                 the MAKELANGID macro. For example, to specify U.S. English, use the following code sample.
    ///                 <code>MAKELANGID(LANG_ENGLISH, SUBLANG_ENGLISH_US)</code> To retrieve the system's default user language
    ///                 identifier, use the following calls. <code>LANGIDFROMLCID(GetThreadLocale())</code>
    ///    pErrorDescription = Null-terminated string that contains a description of the error. Call the CoTaskMemFree function to free
    ///                        <i>ppErrorDescription</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Error code description was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_RESOURCE_LANG_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> No string is
    ///    available for the locale. </td> </tr> </table>
    ///    
    HRESULT GetErrorDescription(HRESULT hResult, uint LanguageId, PWSTR* pErrorDescription);
}

///Use the <b>IBackgroundCopyJob2</b> interface to retrieve reply data from an upload-reply job, determine the progress
///of the reply data transfer to the client, request command line execution, and provide credentials for proxy and
///remote server authentication requests. The <b>IBackgroundCopyJob2</b> interface inherits from the IBackgroundCopyJob
///interface. To get an <b>IBackgroundCopyJob2</b> interface pointer, call the <b>IBackgroundCopyJob::QueryInterface</b>
///method using <code>__uuidof(IBackgroundCopyJob2)</code> for the interface identifier. Use the
///<b>IBackgroundCopyJob2</b> interface pointer to call both the IBackgroundCopyJob and <b>IBackgroundCopyJob2</b>
///methods.
@GUID("54B50739-686F-45EB-9DFF-D6A9A0FAA9AF")
interface IBackgroundCopyJob2 : IBackgroundCopyJob
{
    ///Specifies a program to execute if the job enters the <b>BG_JOB_STATE_ERROR</b> or <b>BG_JOB_STATE_TRANSFERRED</b>
    ///state. BITS executes the program in the context of the user who called this method.
    ///Params:
    ///    Program = Null-terminated string that contains the program to execute. The <i>pProgram</i> parameter is limited to
    ///              MAX_PATH characters, not including the null terminator. You should specify a full path to the program; the
    ///              method will not use the search path to locate the program. To remove command line notification, set
    ///              <i>pProgram</i> and <i>pParameters</i> to <b>NULL</b>. The method fails if <i>pProgram</i> is <b>NULL</b> and
    ///              <i>pParameters</i> is non-<b>NULL</b>.
    ///    Parameters = Null-terminated string that contains the parameters of the program in <i>pProgram</i>. The first parameter
    ///                 must be the program in <i>pProgram</i> (use quotes if the path uses long file names). The <i>pParameters</i>
    ///                 parameter is limited to 4,000 characters, not including the null terminator. This parameter can be
    ///                 <b>NULL</b>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td>
    ///    <td width="60%"> The state of the job cannot be <b>BG_JOB_STATE_CANCELLED</b> or
    ///    <b>BG_JOB_STATE_ACKNOWLEDGED</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_STRING_TOO_LONG</b></dt>
    ///    </dl> </td> <td width="60%"> The <i>pProgram</i> or <i>pParameters</i> string is too long. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetNotifyCmdLine(const(PWSTR) Program, const(PWSTR) Parameters);
    ///Retrieves the program to execute when the job enters the error or transferred state.
    ///Params:
    ///    pProgram = Null-terminated string that contains the program to execute when the job enters the error or transferred
    ///               state. Call the CoTaskMemFree function to free <i>pProgram</i> when done.
    ///    pParameters = Null-terminated string that contains the arguments of the program in <i>pProgram</i>. Call the CoTaskMemFree
    ///                  function to free <i>pParameters</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetNotifyCmdLine(PWSTR* pProgram, PWSTR* pParameters);
    ///Retrieves progress information related to the transfer of the reply data from an upload-reply job.
    ///Params:
    ///    pProgress = Contains information that you use to calculate the percentage of the reply file transfer that is complete.
    ///                For more information, see BG_JOB_REPLY_PROGRESS.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Progress information was successfully retrieved. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for jobs of type
    ///    <b>BG_JOB_TYPE_DOWNLOAD</b> or <b>BG_JOB_TYPE_UPLOAD</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>pProgress</i> parameter cannot be
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetReplyProgress(BG_JOB_REPLY_PROGRESS* pProgress);
    ///Retrieves an in-memory copy of the reply data from the server application. Call this method only if the job's
    ///type is BG_JOB_TYPE_UPLOAD_REPLY and its state is BG_JOB_STATE_TRANSFERRED.
    ///Params:
    ///    ppBuffer = Buffer to contain the reply data. The method sets <i>ppBuffer</i> to <b>NULL</b> if the server application
    ///               did not return a reply. Call the CoTaskMemFree function to free <i>ppBuffer</i> when done.
    ///    pLength = Size, in bytes, of the reply data in <i>ppBuffer</i>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the reply data. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_LARGE</b></dt> </dl> </td> <td width="60%"> The reply data exceeds the maximum 1 MB buffer
    ///    size. The <i>ppBuffer</i> parameter is set to <b>NULL</b>, and <i>pSize</i> contains the size of the reply
    ///    data. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%">
    ///    To retrieve the reply data, the state of the job must be <b>BG_JOB_STATE_TRANSFERRED</b>. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented
    ///    for jobs of type <b>BG_JOB_TYPE_DOWNLOAD</b> or <b>BG_JOB_TYPE_UPLOAD</b>. </td> </tr> </table>
    ///    
    HRESULT GetReplyData(ubyte** ppBuffer, ulong* pLength);
    ///Specifies the name of the file to contain the reply data from the server application. Call this method only if
    ///the job's type is <b>BG_JOB_TYPE_UPLOAD_REPLY</b>.
    ///Params:
    ///    ReplyFileName = Null-terminated string that contains the full path to the reply file. BITS generates the file name if
    ///                    <i>ReplyFileNamePathSpec</i> is <b>NULL</b> or an empty string. You cannot use wildcards in the path or file
    ///                    name, and directories in the path must exist. The path is limited to MAX_PATH, not including the null
    ///                    terminator. The user must have permissions to write to the directory. BITS does not support NTFS streams.
    ///                    Instead of using network drives, which are session specific, use UNC paths (for example,
    ///                    \\server\share\path\file). Do not include the \\? prefix in the path.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully specified the name of the file to contain the reply data. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> You cannot change the reply
    ///    file name after BITS begins transferring the reply to the client. BITS is transferring the reply to the
    ///    client if the state is <b>BG_JOB_STATE_TRANSFERRING</b> and the <b>BytesTotal</b> member of the
    ///    BG_JOB_REPLY_PROGRESS structure is not <b>BG_SIZE_UNKNOWN</b>. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> User does not have permission to write to the
    ///    specified directory on the client. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> The reply file name is invalid or exceeds <b>MAX_PATH</b>. </td> </tr> </table>
    ///    
    HRESULT SetReplyFileName(const(PWSTR) ReplyFileName);
    ///Retrieves the name of the file that contains the reply data from the server application. Call this method only if
    ///the job type is BG_JOB_TYPE_UPLOAD_REPLY.
    ///Params:
    ///    pReplyFileName = Null-terminated string that contains the full path to the reply file. Call the CoTaskMemFree function to free
    ///                     <i>pReplyFileName</i> when done.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the name of the file that contains the reply data. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> This method is not implemented for
    ///    jobs of type <b>BG_JOB_TYPE_DOWNLOAD</b> or <b>BG_JOB_TYPE_UPLOAD</b>. </td> </tr> </table>
    ///    
    HRESULT GetReplyFileName(PWSTR* pReplyFileName);
    ///Specifies the credentials to use for a proxy or remote server user authentication request.
    ///Params:
    ///    credentials = Identifies the target (proxy or server), authentication scheme, and the user's credentials to use for user
    ///                  authentication. For details, see the BG_AUTH_CREDENTIALS structure.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_AUTH_TARGET</b></dt> </dl>
    ///    </td> <td width="60%"> Unrecognized target enumeration value. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_AUTH_SCHEME</b></dt> </dl> </td> <td width="60%"> Unrecognized scheme enumeration value.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_USERNAME_TOO_LARGE</b></dt> </dl> </td> <td width="60%">
    ///    The user name is too long. For the limit, see the BG_BASIC_CREDENTIALS structure. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_PASSWORD_TOO_LARGE</b></dt> </dl> </td> <td width="60%"> The password is too
    ///    long. For the limit, see the BG_BASIC_CREDENTIALS structure. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The UserName and Password members of the
    ///    BG_BASIC_CREDENTIALS structure cannot be <b>NULL</b> if you specify the Basic or Digest scheme. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetCredentials(BG_AUTH_CREDENTIALS* credentials);
    ///Removes credentials from use. The credentials must match an existing target and scheme pair that you specified
    ///using the IBackgroundCopyJob2::SetCredentials method. There is no method to retrieve the credentials you have
    ///set.
    ///Params:
    ///    Target = Identifies whether to use the credentials for proxy or server authentication.
    ///    Scheme = Identifies the authentication scheme to use (basic or one of several challenge-response schemes). For
    ///             details, see the BG_AUTH_SCHEME enumeration.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> No credentials have been set using the given <i>Target</i> and <i>Scheme</i> pair. </td> </tr>
    ///    </table>
    ///    
    HRESULT RemoveCredentials(BG_AUTH_TARGET Target, BG_AUTH_SCHEME Scheme);
}

///Use the <b>IBackgroundCopyJob3</b> interface to download ranges of a file and change the prefix of a remote file
///name. The <b>IBackgroundCopyJob3</b> interface inherits from the IBackgroundCopyJob2 interface. To get an
///<b>IBackgroundCopyJob3</b> interface pointer, call the <b>IBackgroundCopyJob::QueryInterface</b> method using
///<code>__uuidof(IBackgroundCopyJob3)</code> for the interface identifier. Use the <b>IBackgroundCopyJob3</b> interface
///pointer to call the methods of the IBackgroundCopyJob, IBackgroundCopyJob2, and <b>IBackgroundCopyJob3</b>
///interfaces.
@GUID("443C8934-90FF-48ED-BCDE-26F5C7450042")
interface IBackgroundCopyJob3 : IBackgroundCopyJob2
{
    ///Replaces the beginning text of all remote names in the download job with the specified string.
    ///Params:
    ///    OldPrefix = Null-terminated string that identifies the text to replace in the remote name. The text must start at the
    ///                beginning of the remote name.
    ///    NewPrefix = Null-terminated string that contains the replacement text.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> No matches found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl>
    ///    </td> <td width="60%"> Applying <i>NewPrefix</i> creates an invalid URL or the new URL is too long (the URL
    ///    cannot exceed 2,200 characters). You can also receive this return code if the <i>OldPrefix</i> or
    ///    <i>NewPrefix</i> is an empty string. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> You cannot call this method for upload or upload-reply jobs; call this method only for
    ///    download jobs. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td
    ///    width="60%"> The state of the job cannot be <b>BG_JOB_STATE_CANCELLED</b> or
    ///    <b>BG_JOB_STATE_ACKNOWLEDGED</b>. </td> </tr> </table>
    ///    
    HRESULT ReplaceRemotePrefix(const(PWSTR) OldPrefix, const(PWSTR) NewPrefix);
    ///Adds a file to a download job and specifies the ranges of the file you want to download.
    ///Params:
    ///    RemoteUrl = Null-terminated string that contains the name of the file on the server. For information on specifying the
    ///                remote name, see the <b>RemoteName</b> member and Remarks section of the BG_FILE_INFO structure. Starting
    ///                with BITS 3.0, the SMB protocol is not supported for ranges. <b>BITS 2.5 and 2.0: </b>BITS supports the SMB
    ///                protocol for ranges.
    ///    LocalName = Null-terminated string that contains the name of the file on the client. For information on specifying the
    ///                local name, see the <b>LocalName</b> member and Remarks section of the BG_FILE_INFO structure.
    ///    RangeCount = Number of elements in <i>Ranges</i>.
    ///    Ranges = Array of one or more BG_FILE_RANGE structures that specify the ranges to download. Do not specify duplicate
    ///             or overlapping ranges.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> You can receive this error for one of the following reasons: <ul> <li>The <i>RangeCount</i>
    ///    parameter is zero; you must specify one or more ranges.</li> <li>The local or remote file name is not
    ///    valid.</li> <li>The remote file name uses an unsupported protocol.</li> <li>The local file name was specified
    ///    using a relative path.</li> </ul> </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl>
    ///    </td> <td width="60%"> You cannot call this method for upload or upload-reply jobs; only call this method for
    ///    download jobs. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> User does not have permission to write to the specified directory on the client. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_RANGE</b></dt> </dl> </td> <td width="60%"> One of the ranges
    ///    is invalid. For example, InitialOffset is set to <b>BG_LENGTH_TO_EOF</b>. </td> </tr> <tr> <td width="40%">
    ///    <dl> <dt><b>BG_E_OVERLAPPING_RANGES</b></dt> </dl> </td> <td width="60%"> You cannot specify duplicate or
    ///    overlapping ranges. <div class="alert"><b>Note</b> The ranges are sorted by the offset of the value, not the
    ///    length. If ranges are entered that have the same offset, but are in reverse order, then this error will be
    ///    returned. For example, if 100.5 and 100.0 are entered in that order, then you will not be able to add the
    ///    file to the job. </div> <div> </div> </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_TOO_MANY_RANGES_IN_FILE</b></dt> </dl> </td> <td width="60%"> The MaxRangesPerFile Group Policy
    ///    setting determines how many ranges you can specify for a file. Adding these ranges exceeds the
    ///    MaxRangesPerFile limit. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td>
    ///    <td width="60%"> The state of the job cannot be <b>BG_JOB_STATE_CANCELLED</b> or
    ///    <b>BG_JOB_STATE_ACKNOWLEDGED</b>. </td> </tr> </table>
    ///    
    HRESULT AddFileWithRanges(const(PWSTR) RemoteUrl, const(PWSTR) LocalName, uint RangeCount, 
                              BG_FILE_RANGE* Ranges);
    ///Specifies the owner and ACL information to maintain when using SMB to download or upload a file.
    ///Params:
    ///    Flags = Flags that identify the owner and ACL information to maintain when transferring a file using SMB. Subsequent
    ///            calls to this method overwrite the previous flags. Specify 0 to remove the flags from the job. You can
    ///            specify any combination of the following flags. <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td
    ///            width="40%"><a id="BG_COPY_FILE_OWNER"></a><a id="bg_copy_file_owner"></a><dl>
    ///            <dt><b>BG_COPY_FILE_OWNER</b></dt> </dl> </td> <td width="60%"> If set, the file's owner information is
    ///            maintained. Otherwise, the user who calls the Complete method owns the file. You must have SeRestorePrivilege
    ///            to set this flag. The administrators group contains the SeRestorePrivilege privilege. </td> </tr> <tr> <td
    ///            width="40%"><a id="BG_COPY_FILE_GROUP"></a><a id="bg_copy_file_group"></a><dl>
    ///            <dt><b>BG_COPY_FILE_GROUP</b></dt> </dl> </td> <td width="60%"> If set, the file's group information is
    ///            maintained. Otherwise, BITS uses the job owner's primary group to assign the group information to the file.
    ///            You must have SeRestorePrivilege to set this flag. The administrators group contains the SeRestorePrivilege
    ///            privilege. </td> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_DACL"></a><a id="bg_copy_file_dacl"></a><dl>
    ///            <dt><b>BG_COPY_FILE_DACL</b></dt> </dl> </td> <td width="60%"> If set, BITS copies the explicit ACEs from the
    ///            source file and inheritable ACEs from the destination folder. Otherwise, BITS copies the inheritable ACEs
    ///            from the destination folder. If the destination folder does not contain inheritable ACEs, BITS uses the
    ///            default DACL from the owner's account. </td> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_SACL"></a><a
    ///            id="bg_copy_file_sacl"></a><dl> <dt><b>BG_COPY_FILE_SACL</b></dt> </dl> </td> <td width="60%"> If set, BITS
    ///            copies the explicit ACEs from the source file and inheritable ACEs from the destination folder. Otherwise,
    ///            BITS copies the inheritable ACEs from the destination folder. You must have SeSecurityPrivilege on both the
    ///            local and remote computers to set this flag. The administrators group contains the SeSecurityPrivilege
    ///            privilege. </td> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_ALL"></a><a id="bg_copy_file_all"></a><dl>
    ///            <dt><b>BG_COPY_FILE_ALL</b></dt> </dl> </td> <td width="60%"> If set, BITS copies the owner and ACL
    ///            information. This is the same as setting all the flags individually. </td> </tr> </table>
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully set the flags. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> You must call this method before the job
    ///    transitions to the BG_JOB_STATE_TRANSFERRED state. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The <i>Flags</i> parameter contains a flag that is
    ///    not in the list. </td> </tr> </table>
    ///    
    HRESULT SetFileACLFlags(uint Flags);
    ///Retrieves the flags that identify the owner and ACL information to maintain when transferring a file using SMB.
    ///Params:
    ///    Flags = Flags that identify the owner and ACL information to maintain when transferring a file using SMB.
    ///            <i>Flags</i> can contain any combination of the following flags. If no flags are set, <i>Flags</i> is zero.
    ///            <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_OWNER"></a><a
    ///            id="bg_copy_file_owner"></a><dl> <dt><b>BG_COPY_FILE_OWNER</b></dt> </dl> </td> <td width="60%"> If set, the
    ///            file's owner information is maintained. Otherwise, the job's owner becomes the owner of the file. </td> </tr>
    ///            <tr> <td width="40%"><a id="BG_COPY_FILE_GROUP"></a><a id="bg_copy_file_group"></a><dl>
    ///            <dt><b>BG_COPY_FILE_GROUP</b></dt> </dl> </td> <td width="60%"> If set, the file's group information is
    ///            maintained. Otherwise, BITS uses the job owner's primary group to assign the group information to the file.
    ///            </td> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_DACL"></a><a id="bg_copy_file_dacl"></a><dl>
    ///            <dt><b>BG_COPY_FILE_DACL</b></dt> </dl> </td> <td width="60%"> If set, BITS copies the explicit ACEs from the
    ///            source file and inheritable ACEs from the destination parent folder. Otherwise, BITS copies the inheritable
    ///            ACEs from the destination parent folder. If the parent folder does not contain inheritable ACEs, BITS uses
    ///            the default DACL from the account. </td> </tr> <tr> <td width="40%"><a id="BG_COPY_FILE_SACL"></a><a
    ///            id="bg_copy_file_sacl"></a><dl> <dt><b>BG_COPY_FILE_SACL</b></dt> </dl> </td> <td width="60%"> If set, BITS
    ///            copies the explicit ACEs from the source file and inheritable ACEs from the destination parent folder.
    ///            Otherwise, BITS copies the inheritable ACEs from the destination parent folder. </td> </tr> <tr> <td
    ///            width="40%"><a id="BG_COPY_FILE_ALL"></a><a id="bg_copy_file_all"></a><dl> <dt><b>BG_COPY_FILE_ALL</b></dt>
    ///            </dl> </td> <td width="60%"> If set, BITS copies the owner and ACL information. This is the same as setting
    ///            all the flags individually. </td> </tr> </table>
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the flags. </td> </tr> </table>
    ///    
    HRESULT GetFileACLFlags(uint* Flags);
}

///Use the <b>IBackgroundCopyFile2</b> interface to specify a new remote name for the file and retrieve the list of
///ranges to download. The <b>IBackgroundCopyFile2</b> interface inherits from the IBackgroundCopyFile interface. To get
///an <b>IBackgroundCopyFile2</b> interface pointer, call the <b>IBackgroundCopyFile::QueryInterface</b> method using
///__uuidof(IBackgroundCopyFile2) for the interface identifier. Use the <b>IBackgroundCopyFile2</b> interface pointer to
///call both the IBackgroundCopyFile and <b>IBackgroundCopyFile2</b> methods.
@GUID("83E81B93-0873-474D-8A8C-F2018B1A939C")
interface IBackgroundCopyFile2 : IBackgroundCopyFile
{
    ///Retrieves the ranges that you want to download from the remote file.
    ///Params:
    ///    RangeCount = Number of elements in <i>Ranges</i>.
    ///    Ranges = Array of BG_FILE_RANGE structures that specify the ranges to download. When done, call the CoTaskMemFree
    ///             function to free <i>Ranges</i>.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td
    ///    width="60%"> No ranges were specified or the job is an upload or upload-reply job. <i>RangeCount</i> is set
    ///    to zero and <i>Ranges</i> is set to <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetFileRanges(uint* RangeCount, BG_FILE_RANGE** Ranges);
    ///Changes the remote name to a new URL in a download job.
    ///Params:
    ///    Val = Null-terminated string that contains the name of the file on the server. For information on specifying the
    ///          remote name, see the <b>RemoteName</b> member and Remarks section of the BG_FILE_INFO structure.
    ///Returns:
    ///    This method returns the following return values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
    ///    width="60%"> The new remote name is an invalid URL or the new URL is too long (the URL cannot exceed 2,200
    ///    characters). </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%">
    ///    You cannot call this method for upload or upload-reply jobs; only call this method for download jobs. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of
    ///    the job cannot be <b>BG_JOB_STATE_CANCELLED</b> or <b>BG_JOB_STATE_ACKNOWLEDGED</b>. </td> </tr> </table>
    ///    
    HRESULT SetRemoteName(const(PWSTR) Val);
}

///Use this interface to specify client certificates for certificate-based client authentication and custom headers for
///HTTP requests. To get this interface, call the <b>IBackgroundCopyJob::QueryInterface</b> method using
///__uuidof(IBackgroundCopyJobHttpOptions) for the interface identifier.
@GUID("F1BD1079-9F01-4BDC-8036-F09B70095066")
interface IBackgroundCopyJobHttpOptions : IUnknown
{
    ///Specifies the identifier of the client certificate to use for client authentication in an HTTPS (SSL) request.
    ///Params:
    ///    StoreLocation = Identifies the location of a system store to use for looking up the certificate. For possible values, see the
    ///                    BG_CERT_STORE_LOCATION enumeration.
    ///    StoreName = Null-terminated string that contains the name of the certificate store. The string is limited to 256
    ///                characters, including the null terminator. You can specify one of the following system stores or an
    ///                application-defined store. The store can be a local or remote store. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CA"></a><a id="ca"></a><dl> <dt><b>CA</b></dt> </dl> </td>
    ///                <td width="60%"> Certification authority certificates </td> </tr> <tr> <td width="40%"><a id="MY"></a><a
    ///                id="my"></a><dl> <dt><b>MY</b></dt> </dl> </td> <td width="60%"> Personal certificates </td> </tr> <tr> <td
    ///                width="40%"><a id="ROOT"></a><a id="root"></a><dl> <dt><b>ROOT</b></dt> </dl> </td> <td width="60%"> Root
    ///                certificates </td> </tr> <tr> <td width="40%"><a id="SPC"></a><a id="spc"></a><dl> <dt><b>SPC</b></dt> </dl>
    ///                </td> <td width="60%"> Software Publisher Certificate </td> </tr> </table>
    ///    pCertHashBlob = SHA1 hash that identifies the certificate. Use a 20 byte buffer for the hash. For more information, see
    ///                    Remarks.
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The user does not have permission to access the store location. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The value for the
    ///    <i>StoreLocation</i> parameter is not defined in the BG_CERT_STORE_LOCATION enumeration. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Could
    ///    not find a store matching the <i>StoreName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CRYPT_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A certificate matching the hash was not found.
    ///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_X_NULL_REF_POINTER</b></dt> </dl> </td> <td width="60%">
    ///    The <i>StoreName</i> or <i>pCertHashBlob</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>RPC_X_BAD_STUB_DATA</b></dt> </dl> </td> <td width="60%"> The <i>pCertHashBlob</i>
    ///    buffer size is not 20 bytes. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_STRING_TOO_LONG</b></dt>
    ///    </dl> </td> <td width="60%"> The <i>StoreName</i> parameter is more than 256 characters. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot
    ///    be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetClientCertificateByID(BG_CERT_STORE_LOCATION StoreLocation, const(PWSTR) StoreName, 
                                     ubyte* pCertHashBlob);
    ///Specifies the subject name of the client certificate to use for client authentication in an HTTPS (SSL) request.
    ///Params:
    ///    StoreLocation = Identifies the location of a system store to use for looking up the certificate. For possible values, see the
    ///                    BG_CERT_STORE_LOCATION enumeration.
    ///    StoreName = Null-terminated string that contains the name of the certificate store. The string is limited to 256
    ///                characters, including the null terminator. You can specify one of the following system stores or an
    ///                application-defined store. The store can be a local or remote store. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="CA"></a><a id="ca"></a><dl> <dt><b>CA</b></dt> </dl> </td>
    ///                <td width="60%"> Certification authority certificates </td> </tr> <tr> <td width="40%"><a id="MY"></a><a
    ///                id="my"></a><dl> <dt><b>MY</b></dt> </dl> </td> <td width="60%"> Personal certificates </td> </tr> <tr> <td
    ///                width="40%"><a id="ROOT"></a><a id="root"></a><dl> <dt><b>ROOT</b></dt> </dl> </td> <td width="60%"> Root
    ///                certificates </td> </tr> <tr> <td width="40%"><a id="SPC"></a><a id="spc"></a><dl> <dt><b>SPC</b></dt> </dl>
    ///                </td> <td width="60%"> Software Publisher Certificate </td> </tr> </table>
    ///    SubjectName = Null-terminated string that contains the simple subject name of the certificate. If the subject name contains
    ///                  multiple relative distinguished names (RDNs), you can specify one or more adjacent RDNs. If you specify more
    ///                  than one RDN, the list is comma-delimited. The string is limited to 256 characters, including the null
    ///                  terminator. You cannot specify an empty subject name. Do not include the object identifier in the name. You
    ///                  must specify the RDNs in the reverse order from what the certificate displays. For example, if the subject
    ///                  name in the certificate is "CN=name1, OU=name2, O=name3", specify the subject name as "name3, name2, name1".
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td
    ///    width="60%"> The user does not have permission to access the store location. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The value for <i>StoreLocation</i>
    ///    is not defined in the BG_CERT_STORE_LOCATION enumeration. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>HRESULT_FROM_WIN32(ERROR_FILE_NOT_FOUND)</b></dt> </dl> </td> <td width="60%"> Could not find a store
    ///    matching the value of the <i>StoreName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>CRYPT_E_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> A certificate matching the subject name was
    ///    not found. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>RPC_X_NULL_REF_POINTER</b></dt> </dl> </td> <td
    ///    width="60%"> The <i>StoreName</i> or <i>SubjectName</i> parameter cannot be <b>NULL</b>. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_STRING_TOO_LONG</b></dt> </dl> </td> <td width="60%"> The <i>StoreName</i> or
    ///    <i>SubjectName</i> parameter is more than 256 characters. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetClientCertificateByName(BG_CERT_STORE_LOCATION StoreLocation, const(PWSTR) StoreName, 
                                       const(PWSTR) SubjectName);
    ///Removes the client certificate from the job.
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully removed the certificate. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>S_FALSE</b></b></dt> </dl> </td> <td width="60%"> The job does not specify a certificate. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of
    ///    the job cannot be BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT RemoveClientCertificate();
    ///Retrieves the client certificate from the job.
    ///Params:
    ///    pStoreLocation = Identifies the location of a system store to use for looking up the certificate. For possible values, see the
    ///                     BG_CERT_STORE_LOCATION enumeration.
    ///    pStoreName = Null-terminated string that contains the name of the certificate store. To free the string when done, call
    ///                 the CoTaskMemFree function.
    ///    ppCertHashBlob = SHA1 hash that identifies the certificate. To free the blob when done, call the CoTaskMemFree function.
    ///    pSubjectName = Null-terminated string that contains the simple subject name of the certificate. The RDNs in the subject name
    ///                   are in the reverse order from what the certificate displays. Subject name can be empty if the certificate
    ///                   does not contain a subject name. To free the string when done, call the CoTaskMemFree function.
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the certificate. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>RPC_X_BAD_STUB_DATA</b></b></dt> </dl> </td> <td width="60%"> The job does not specify a
    ///    certificate or the user does not have permissions to the certificate. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>RPC_X_NULL_REF_POINTER</b></b></dt> </dl> </td> <td width="60%"> One of the parameters is
    ///    <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetClientCertificate(BG_CERT_STORE_LOCATION* pStoreLocation, PWSTR* pStoreName, ubyte** ppCertHashBlob, 
                                 PWSTR* pSubjectName);
    ///Specifies one or more custom HTTP headers to include in HTTP requests.
    ///Params:
    ///    RequestHeaders = Null-terminated string that contains the custom headers to append to the HTTP request. Each header must be
    ///                     terminated by a carriage return and line feed (CR/LF) character. The string is limited to 16,384 characters,
    ///                     including the null terminator. To remove the custom headers from the job, set the <i>RequestHeaders</i>
    ///                     parameter to <b>NULL</b>.
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Success. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_STRING_TOO_LONG</b></dt> </dl> </td>
    ///    <td width="60%"> The length of the custom headers is more than 16 KB. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>BG_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The state of the job cannot be
    ///    BG_JOB_STATE_CANCELLED or BG_JOB_STATE_ACKNOWLEDGED. </td> </tr> </table>
    ///    
    HRESULT SetCustomHeaders(const(PWSTR) RequestHeaders);
    ///Retrieves the custom headers set by an earlier call to IBackgroundCopyJobHttpOptions::SetCustomHeaders (that is,
    ///headers which BITS will be sending to the remote, not headers which BITS receives from the remote).
    ///Params:
    ///    pRequestHeaders = Null-terminated string that contains the custom headers. Each header is terminated by a carriage return and
    ///                      line feed (CR/LF) character. To free the string when finished, call the CoTaskMemFree function.
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the headers. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>S_FALSE</b></b></dt> </dl> </td> <td width="60%"> The job does not specify custom headers. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b><b>E_ACCESSDENIED</b></b></dt> </dl> </td> <td width="60%"> Either
    ///    you don't have permission to retrieve the custom headers, or
    ///    [IBackgroundCopyJobHttpOptions3::MakeCustomHeadersWriteOnly](/windows/desktop/api/bits10_3/nf-bits10_3-ibackgroundcopyjobhttpoptions3-makecustomheaderswriteonly)
    ///    has been called on the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>RPC_X_NULL_REF_POINTER</b></b></dt> </dl> </td> <td width="60%"> The <i>pRequestHeaders</i>
    ///    parameter is <b>NULL</b>. </td> </tr> </table>
    ///    
    HRESULT GetCustomHeaders(PWSTR* pRequestHeaders);
    ///Sets flags for HTTP that determine whether the certificate revocation list is checked and certain certificate
    ///errors are ignored, and the policy to use when a server redirects the HTTP request.
    ///Params:
    ///    Flags = HTTP security flags that indicate which errors to ignore when connecting to the server. You can set one or
    ///            more of the following flags: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///            id="BG_SSL_ENABLE_CRL_CHECK"></a><a id="bg_ssl_enable_crl_check"></a><dl>
    ///            <dt><b>BG_SSL_ENABLE_CRL_CHECK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Check the certificate
    ///            revocation list (CRL) to verify that the server certificate has not been revoked. </td> </tr> <tr> <td
    ///            width="40%"><a id="BG_SSL_IGNORE_CERT_CN_INVALID"></a><a id="bg_ssl_ignore_cert_cn_invalid"></a><dl>
    ///            <dt><b>BG_SSL_IGNORE_CERT_CN_INVALID</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Ignores errors
    ///            caused when the certificate host name of the server does not match the host name in the request. </td> </tr>
    ///            <tr> <td width="40%"><a id="BG_SSL_IGNORE_CERT_DATE_INVALID"></a><a
    ///            id="bg_ssl_ignore_cert_date_invalid"></a><dl> <dt><b>BG_SSL_IGNORE_CERT_DATE_INVALID</b></dt> <dt>0x0004</dt>
    ///            </dl> </td> <td width="60%"> Ignores errors caused by an expired certificate. </td> </tr> <tr> <td
    ///            width="40%"><a id="BG_SSL_IGNORE_UNKNOWN_CA"></a><a id="bg_ssl_ignore_unknown_ca"></a><dl>
    ///            <dt><b>BG_SSL_IGNORE_UNKNOWN_CA</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Ignore errors
    ///            associated with an unknown certification authority (CA). </td> </tr> <tr> <td width="40%"><a
    ///            id="BG_SSL_IGNORE_CERT_WRONG_USAGE"></a><a id="bg_ssl_ignore_cert_wrong_usage"></a><dl>
    ///            <dt><b>BG_SSL_IGNORE_CERT_WRONG_USAGE</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> Ignore errors
    ///            associated with the use of a certificate. </td> </tr> <tr> <td width="40%"><a
    ///            id="BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT"></a><a id="bg_http_redirect_policy_allow_silent"></a><dl>
    ///            <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Allows the
    ///            server to redirect your request to another server. This is the default. </td> </tr> <tr> <td width="40%"><a
    ///            id="BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT"></a><a id="bg_http_redirect_policy_allow_report"></a><dl>
    ///            <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Allows the
    ///            server to redirect your request to another server. BITS updates the remote name with the final URL. </td>
    ///            </tr> <tr> <td width="40%"><a id="BG_HTTP_REDIRECT_POLICY_DISALLOW"></a><a
    ///            id="bg_http_redirect_policy_disallow"></a><dl> <dt><b>BG_HTTP_REDIRECT_POLICY_DISALLOW</b></dt>
    ///            <dt>0x0200</dt> </dl> </td> <td width="60%"> Places the job in the fatal error state when the server
    ///            redirects your request to another server. BITS updates the remote name with the redirected URL. </td> </tr>
    ///            <tr> <td width="40%"><a id="BG_HTTP_REDIRECT_POLICY_MASK"></a><a id="bg_http_redirect_policy_mask"></a><dl>
    ///            <dt><b>BG_HTTP_REDIRECT_POLICY_MASK</b></dt> <dt>0x0700</dt> </dl> </td> <td width="60%"> Bitmask that you
    ///            can use with the security flag value to determine which redirect policy is in effect. It does not include the
    ///            flag ALLOW_HTTPS_TO_HTTP. </td> </tr> <tr> <td width="40%"><a
    ///            id="BG_HTTP_REDIRECT_POLICY_ALLOW_HTTPS_TO_HTTP"></a><a
    ///            id="bg_http_redirect_policy_allow_https_to_http"></a><dl>
    ///            <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_HTTPS_TO_HTTP</b></dt> <dt>0x0800</dt> </dl> </td> <td width="60%">
    ///            Allows the server to redirect an HTTPS request to an HTTP URL. You can combine this flag with
    ///            BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT and BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT. </td> </tr> </table>
    ///Returns:
    ///    The following table lists some of the possible return values. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the headers. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b><b>E_NOTIMPL</b></b></dt> </dl> </td> <td width="60%"> The flag value is not supported. </td> </tr>
    ///    </table>
    ///    
    HRESULT SetSecurityFlags(uint Flags);
    ///Retrieves the flags for HTTP that determine whether the certificate revocation list is checked and certain
    ///certificate errors are ignored, and the policy to use when a server redirects the HTTP request.
    ///Params:
    ///    pFlags = HTTP security flags that indicate which errors to ignore when connecting to the server. One or more of the
    ///             following flags can be set: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///             id="BG_SSL_ENABLE_CRL_CHECK"></a><a id="bg_ssl_enable_crl_check"></a><dl>
    ///             <dt><b>BG_SSL_ENABLE_CRL_CHECK</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> Check the certificate
    ///             revocation list (CRL) to verify that the server certificate has not been revoked. </td> </tr> <tr> <td
    ///             width="40%"><a id="BG_SSL_IGNORE_CERT_CN_INVALID"></a><a id="bg_ssl_ignore_cert_cn_invalid"></a><dl>
    ///             <dt><b>BG_SSL_IGNORE_CERT_CN_INVALID</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> Ignores errors
    ///             caused when the certificate host name of the server does not match the host name in the request. </td> </tr>
    ///             <tr> <td width="40%"><a id="BG_SSL_IGNORE_CERT_DATE_INVALID"></a><a
    ///             id="bg_ssl_ignore_cert_date_invalid"></a><dl> <dt><b>BG_SSL_IGNORE_CERT_DATE_INVALID</b></dt> <dt>0x0004</dt>
    ///             </dl> </td> <td width="60%"> Ignores errors caused by an expired certificate. </td> </tr> <tr> <td
    ///             width="40%"><a id="BG_SSL_IGNORE_UNKNOWN_CA"></a><a id="bg_ssl_ignore_unknown_ca"></a><dl>
    ///             <dt><b>BG_SSL_IGNORE_UNKNOWN_CA</b></dt> <dt>0x0008</dt> </dl> </td> <td width="60%"> Ignore errors
    ///             associated with an unknown certification authority (CA). </td> </tr> <tr> <td width="40%"><a
    ///             id="BG_SSL_IGNORE_CERT_WRONG_USAGE"></a><a id="bg_ssl_ignore_cert_wrong_usage"></a><dl>
    ///             <dt><b>BG_SSL_IGNORE_CERT_WRONG_USAGE</b></dt> <dt>0x0010</dt> </dl> </td> <td width="60%"> Ignore errors
    ///             associated with the use of a certificate. </td> </tr> <tr> <td width="40%"><a
    ///             id="BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT"></a><a id="bg_http_redirect_policy_allow_silent"></a><dl>
    ///             <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT</b></dt> <dt>0x0000</dt> </dl> </td> <td width="60%"> Allows the
    ///             server to redirect your request to another server. This is the default. </td> </tr> <tr> <td width="40%"><a
    ///             id="BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT"></a><a id="bg_http_redirect_policy_allow_report"></a><dl>
    ///             <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT</b></dt> <dt>0x0100</dt> </dl> </td> <td width="60%"> Allows the
    ///             server to redirect your request to another server. BITS updates the remote name with the final URL. </td>
    ///             </tr> <tr> <td width="40%"><a id="BG_HTTP_REDIRECT_POLICY_DISALLOW"></a><a
    ///             id="bg_http_redirect_policy_disallow"></a><dl> <dt><b>BG_HTTP_REDIRECT_POLICY_DISALLOW</b></dt>
    ///             <dt>0x0200</dt> </dl> </td> <td width="60%"> Places the job in the fatal error state when the server
    ///             redirects your request to another server. BITS updates the remote name with the redirected URL. </td> </tr>
    ///             <tr> <td width="40%"><a id="BG_HTTP_REDIRECT_POLICY_MASK"></a><a id="bg_http_redirect_policy_mask"></a><dl>
    ///             <dt><b>BG_HTTP_REDIRECT_POLICY_MASK</b></dt> <dt>0x0700</dt> </dl> </td> <td width="60%"> Bitmask that you
    ///             can use with the security flag value to determine which redirect policy is in effect. It does not include the
    ///             flag ALLOW_HTTPS_TO_HTTP. The following example shows how to use this mask to test for the
    ///             BG_HTTP_REDIRECT_POLICY_DISALLOW redirection policy. <code>if (BG_HTTP_REDIRECT_POLICY_DISALLOW == (flags
    ///             &amp; BG_HTTP_REDIRECT_POLICY_MASK))</code> </td> </tr> <tr> <td width="40%"><a
    ///             id="BG_HTTP_REDIRECT_POLICY_ALLOW_HTTPS_TO_HTTP"></a><a
    ///             id="bg_http_redirect_policy_allow_https_to_http"></a><dl>
    ///             <dt><b>BG_HTTP_REDIRECT_POLICY_ALLOW_HTTPS_TO_HTTP</b></dt> <dt>0x0800</dt> </dl> </td> <td width="60%">
    ///             Allows the server to redirect an HTTPS request to an HTTP URL. You can combine this flag with
    ///             BG_HTTP_REDIRECT_POLICY_ALLOW_SILENT and BG_HTTP_REDIRECT_POLICY_ALLOW_REPORT. </td> </tr> </table>
    ///Returns:
    ///    Returns S_OK when successful.
    ///    
    HRESULT GetSecurityFlags(uint* pFlags);
}

///Use <b>IBitsPeerCacheRecord</b> to get information about a file in the cache. To get this interface, call one of the
///following methods:<ul> <li> IBitsPeerCacheAdministration::GetRecord </li> <li> IEnumBitsPeerCacheRecords::Next </li>
///</ul> <div class="alert"><b>Note</b> This interface is deprecated in BITS 4.0, and all of the API methods will return
///<b>S_FALSE</b>.</div><div> </div>
@GUID("659CDEAF-489E-11D9-A9CD-000D56965251")
interface IBitsPeerCacheRecord : IUnknown
{
    ///Gets the identifier that uniquely identifies the record in the cache.
    ///Params:
    ///    pVal = Identifier that uniquely identifies the record in the cache.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetId(GUID* pVal);
    ///Gets the origin URL of the cached file.
    ///Params:
    ///    pVal = Null-terminated string that contains the origin URL of the cached file. Call the CoTaskMemFree function to
    ///           free <i>ppOriginUrl</i> when done.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetOriginUrl(PWSTR* pVal);
    ///Gets the size of the file.
    ///Params:
    ///    pVal = Size of the file, in bytes.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetFileSize(ulong* pVal);
    ///Gets the date and time that the file was last modified on the server.
    ///Params:
    ///    pVal = Date and time that the file was last modified on the server. The time is specified as FILETIME.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetFileModificationTime(FILETIME* pVal);
    ///Gets the date and time that the file was last accessed.
    ///Params:
    ///    pVal = Date and time that the file was last accessed. The time is specified as FILETIME.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetLastAccessTime(FILETIME* pVal);
    ///Determines whether the file has been validated.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> File has been validated. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> File has not been
    ///    validated. </td> </tr> </table>
    ///    
    HRESULT IsFileValidated();
    ///Gets the ranges of the file that are in the cache.
    ///Params:
    ///    pRangeCount = Number of elements in <i>ppRanges</i>.
    ///    ppRanges = Array of BG_FILE_RANGE structures that specify the ranges of the file that are in the cache. When done, call
    ///               the CoTaskMemFree function to free <i>ppRanges</i>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetFileRanges(uint* pRangeCount, BG_FILE_RANGE** ppRanges);
}

///Use <b>IEnumBitsPeerCacheRecords</b> to enumerate the records of the cache. To get this interface, call the
///IBitsPeerCacheAdministration::EnumRecords method. <div class="alert"><b>Note</b> This interface is deprecated in BITS
///4.0, and all of the API methods will return <b>S_FALSE</b>.</div><div> </div>
@GUID("659CDEA4-489E-11D9-A9CD-000D56965251")
interface IEnumBitsPeerCacheRecords : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence. If there are fewer than the requested number
    ///of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of IBitsPeerCacheRecord objects. You must release each object in <i>rgelt</i> when done.
    ///    pceltFetched = Number of elements returned in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is
    ///                   one. Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IBitsPeerCacheRecord* rgelt, uint* pceltFetched);
    ///Skips the next specified number of elements in the enumeration sequence. If there are fewer elements left in the
    ///sequence than the requested number of elements to skip, it skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Reset();
    ///Creates another IEnumBitsPeerCacheRecords enumerator that contains the same enumeration state as the current one.
    ///Using this method, a client can record a particular point in the enumeration sequence, and then return to that
    ///point at a later time. The new enumerator supports the same interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnum</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Clone(IEnumBitsPeerCacheRecords* ppenum);
    ///Retrieves a count of the number of cache records in the enumeration.
    ///Params:
    ///    puCount = Number of cache records in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetCount(uint* puCount);
}

///Use <b>IBitsPeer</b> to get information about a peer in the neighborhood. To get this interface, call the
///IEnumBitsPeers::Next method. <div class="alert"><b>Note</b> This interface is deprecated in BITS 4.0, and all of the
///API methods will return <b>S_FALSE</b>.</div><div> </div>
@GUID("659CDEA2-489E-11D9-A9CD-000D56965251")
interface IBitsPeer : IUnknown
{
    ///Gets the server principal name that uniquely identifies the peer.
    ///Params:
    ///    pName = Null-terminated string that contains the server principal name of the peer. The principal name is of the
    ///            form, server$.domain.suffix. Call the CoTaskMemFree function to free <i>pName</i> when done.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetPeerName(PWSTR* pName);
    ///Determines whether the peer is authenticated.
    ///Params:
    ///    pAuth = <b>TRUE</b> if the peer is authenticated, otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT IsAuthenticated(BOOL* pAuth);
    ///Determines whether the peer is available (online) to serve content.
    ///Params:
    ///    pOnline = <b>TRUE</b> if the peer is available to serve content, otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT IsAvailable(BOOL* pOnline);
}

///Use <b>IEnumBitsPeers</b> to enumerate the list of peers that BITS has discovered. To get this interface, call the
///IBitsPeerCacheAdministration::EnumPeers method. <div class="alert"><b>Note</b> This interface is deprecated in BITS
///4.0, and all of the API methods will return <b>S_FALSE</b>.</div><div> </div>
@GUID("659CDEA5-489E-11D9-A9CD-000D56965251")
interface IEnumBitsPeers : IUnknown
{
    ///Retrieves a specified number of items in the enumeration sequence. If there are fewer than the requested number
    ///of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of IBitsPeer objects. You must release each object in <i>rgelt</i> when done.
    ///    pceltFetched = Number of elements returned in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is
    ///                   one. Otherwise, initialize the value of <i>pceltFetched</i> to 0 before calling this method.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, IBitsPeer* rgelt, uint* pceltFetched);
    ///Skips the next specified number of elements in the enumeration sequence. If there are fewer elements left in the
    ///sequence than the requested number of elements to skip, it skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///Resets the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Reset();
    ///Creates another IEnumBitsPeers enumerator that contains the same enumeration state as the current one. Using this
    ///method, a client can record a particular point in the enumeration sequence, and then return to that point at a
    ///later time. The new enumerator supports the same interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppEnum</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT Clone(IEnumBitsPeers* ppenum);
    ///Retrieves a count of the number of peers in the enumeration.
    ///Params:
    ///    puCount = Number of peers in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT GetCount(uint* puCount);
}

///Use <b>IBitsPeerCacheAdministration</b> to manage the pool of peers from which you can download content. To get this
///interface, call the IBackgroundCopyManager::QueryInterface method, using __uuidof(IBitsPeerCacheAdministration) as
///the interface identifier. <div class="alert"><b>Note</b> This interface is deprecated in BITS 4.0, and all of the API
///methods will return <b>S_FALSE</b>.</div><div> </div>
@GUID("659CDEAD-489E-11D9-A9CD-000D56965251")
interface IBitsPeerCacheAdministration : IUnknown
{
    ///Gets the maximum size of the cache.
    ///Params:
    ///    pBytes = Maximum size of the cache, as a percentage of available hard disk drive space.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetMaximumCacheSize(uint* pBytes);
    ///Specifies the maximum size of the cache.
    ///Params:
    ///    Bytes = Maximum size of the cache, as a percentage of available hard disk drive space.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The configuration preference has been
    ///    saved successfully, but the preference will not be used because a configured Group Policy setting overrides
    ///    the preference. </td> </tr> </table>
    ///    
    HRESULT SetMaximumCacheSize(uint Bytes);
    ///Gets the age by when files are removed from the cache.
    ///Params:
    ///    pSeconds = Age, in seconds. If the last time that the file was accessed is older than this age, BITS removes the file
    ///               from the cache.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetMaximumContentAge(uint* pSeconds);
    ///Specifies when files are removed from the cache based on age.
    ///Params:
    ///    Seconds = Age, in seconds. If the last time that the file was accessed is older than this age, BITS removes the file
    ///              from the cache. The age is reset each time the file is accessed. The maximum value is 10,368,000 seconds (120
    ///              days) and the minimum value is 86,400 seconds (1 day). The default is 7,776,000 seconds (90 days).
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The configuration preference has been
    ///    saved successfully, but the preference will not be used because a configured Group Policy setting overrides
    ///    the preference. </td> </tr> </table>
    ///    
    HRESULT SetMaximumContentAge(uint Seconds);
    ///Gets the configuration flags that determine if the computer serves content to peers and can download content from
    ///peers.
    ///Params:
    ///    pFlags = Flags that determine if the computer serves content to peers and can download content from peers. The
    ///             following flags can be set: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///             id="BG_ENABLE_PEERCACHING_CLIENT"></a><a id="bg_enable_peercaching_client"></a><dl>
    ///             <dt><b>BG_ENABLE_PEERCACHING_CLIENT</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> The computer can
    ///             download content from peers. </td> </tr> <tr> <td width="40%"><a id="BG_ENABLE_PEERCACHING_SERVER"></a><a
    ///             id="bg_enable_peercaching_server"></a><dl> <dt><b>BG_ENABLE_PEERCACHING_SERVER</b></dt> <dt>0x0002</dt> </dl>
    ///             </td> <td width="60%"> The computer can serve content to peers. </td> </tr> </table>
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetConfigurationFlags(uint* pFlags);
    ///Sets the configuration flags that determine if the computer can serve content to peers and can download content
    ///from peers.
    ///Params:
    ///    Flags = Flags that determine if the computer can serve content to peers and can download content from peers. The
    ///            following flags can be set: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a
    ///            id="BG_ENABLE_PEERCACHING_CLIENT"></a><a id="bg_enable_peercaching_client"></a><dl>
    ///            <dt><b>BG_ENABLE_PEERCACHING_CLIENT</b></dt> <dt>0x0001</dt> </dl> </td> <td width="60%"> The computer can
    ///            download content from peers. BITS will not download files from a peer unless both the client computer and the
    ///            job permit BITS to download files from a peer. To permits the job to download files from a peer, call the
    ///            IBackgroundCopyJob4::SetPeerCachingFlags method and set the BG_JOB_ENABLE_PEERCACHING_CLIENT flag. Note that
    ///            changing this value can affect all jobs on the computer. If one of the following conditions exists, BITS will
    ///            stop the download and reschedule the job to begin transferring from either a peer or the origin server,
    ///            depending on the value for the job and the cache:<ul> <li>This value for the cache is <b>TRUE</b> and the
    ///            value for the job toggles between <b>TRUE</b> and <b>FALSE</b>.</li> <li>This value for the job property is
    ///            <b>TRUE</b> and the value for the cache toggles between <b>TRUE</b> and <b>FALSE</b>.</li> </ul>The download
    ///            will then resume from where it left off before BITS stopped the job. </td> </tr> <tr> <td width="40%"><a
    ///            id="BG_ENABLE_PEERCACHING_SERVER"></a><a id="bg_enable_peercaching_server"></a><dl>
    ///            <dt><b>BG_ENABLE_PEERCACHING_SERVER</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The computer can
    ///            serve content to peers. BITS will not cache the files and serve them to peers unless both the client computer
    ///            and job permit BITS to cache and serve files. To permit the job to cache files for a job, call the
    ///            IBackgroundCopyJob4::SetPeerCachingFlags method and set the BG_JOB_ENABLE_PEERCACHING_SERVER flag. </td>
    ///            </tr> </table>
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_S_OVERRIDDEN_BY_POLICY</b></dt> </dl> </td> <td width="60%"> The configuration
    ///    preference has been saved successfully, but the preference will not be used because a configured Group Policy
    ///    setting overrides the preference. The method returns this value if the value set is different from the group
    ///    policy value. If the values are the same, the method returns S_OK. </td> </tr> </table>
    ///    
    HRESULT SetConfigurationFlags(uint Flags);
    ///Gets an IEnumBitsPeerCacheRecords interface pointer that you use to enumerate the records in the cache. The
    ///enumeration is a snapshot of the records in the cache.
    ///Params:
    ///    ppEnum = An IEnumBitsPeerCacheRecords interface pointer that you use to enumerate the records in the cache. Release
    ///             <i>ppEnum</i> when done.
    ///Returns:
    ///    This method returns S_OK on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT EnumRecords(IEnumBitsPeerCacheRecords* ppEnum);
    ///Gets a record from the cache.
    ///Params:
    ///    id = Identifier of the record to get from the cache. The IBitsPeerCacheRecord::GetId method returns the
    ///         identifier.
    ///    ppRecord = An IBitsPeerCacheRecord interface of the cache record. Release <i>ppRecord</i> when done.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetRecord(const(GUID)* id, IBitsPeerCacheRecord* ppRecord);
    ///Removes all the records and files from the cache.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT ClearRecords();
    ///Deletes a record and file from the cache. This method uses the record's identifier to identify the record to
    ///delete.
    ///Params:
    ///    id = Identifier of the record to delete from the cache. The IBitsPeerCacheRecord::GetId method returns the
    ///         identifier.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>BG_E_BUSYCACHERECORD</b></dt> </dl> </td> <td width="60%"> The cache record is in
    ///    use and cannot be changed or deleted. Try again after a few seconds. </td> </tr> </table>
    ///    
    HRESULT DeleteRecord(const(GUID)* id);
    ///Deletes all cache records and the file from the cache for the given URL.
    ///Params:
    ///    url = Null-terminated string that contains the URL of the file whose cache records and file you want to delete from
    ///          the cache.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> The URL does not exist. </td> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>BG_E_BUSYCACHERECORD</b></dt> </dl> </td> <td width="60%"> The cache record
    ///    is in use and cannot be changed or deleted. Try again after a few seconds. </td> </tr> </table>
    ///    
    HRESULT DeleteUrl(const(PWSTR) url);
    ///Gets an IEnumBitsPeers interface pointer that you use to enumerate the peers that can serve content. The
    ///enumeration is a snapshot of the records in the cache.
    ///Params:
    ///    ppEnum = An IEnumBitsPeers interface pointer that you use to enumerate the peers that can serve content. Release
    ///             <i>ppEnum</i> when done.
    ///Returns:
    ///    This method returns S_OK on success or one of the standard COM <b>HRESULT</b> values on error.
    ///    
    HRESULT EnumPeers(IEnumBitsPeers* ppEnum);
    ///Removes all peers from the list of peers that can serve content.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT ClearPeers();
    ///Generates a list of peers that can serve content.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT DiscoverPeers();
}

///Use this interface to enable peer caching, restrict download time, and inspect user token characteristics. To get
///this interface, call the <b>IBackgroundCopyJob::QueryInterface</b> method using
///<code>__uuidof(IBackgroundCopyJob4)</code> as the interface identifier.
@GUID("659CDEAE-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyJob4 : IBackgroundCopyJob3
{
    ///Sets flags that determine if the files of the job can be cached and served to peers and if the job can download
    ///content from peers.
    ///Params:
    ///    Flags = Flags that determine if the files of the job can be cached and served to peers and if the job can download
    ///            content from peers. The following flags can be set: <table> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///            <td width="40%"><a id="BG_JOB_ENABLE_PEERCACHING_CLIENT"></a><a
    ///            id="bg_job_enable_peercaching_client"></a><dl> <dt><b>BG_JOB_ENABLE_PEERCACHING_CLIENT</b></dt>
    ///            <dt>0x0001</dt> </dl> </td> <td width="60%"> The job can download content from peers. The job will not
    ///            download from a peer unless both the client computer and the job allow Background Intelligent Transfer
    ///            Service (BITS) to download files from a peer. To enable the client computer to download files from a peer,
    ///            set the EnablePeerCaching group policy or call the IBitsPeerCacheAdministration::SetConfigurationFlags method
    ///            and set the BG_ENABLE_PEERCACHING_CLIENT flag. If one of the following conditions exists, BITS will stop the
    ///            download and reschedule the job to begin transferring from either a peer or the origin server, depending on
    ///            the value for the job and the cache:<ul> <li>This value for the cache is <b>TRUE</b> and the value for the
    ///            job toggles between <b>TRUE</b> and <b>FALSE</b>.</li> <li>This value for the job property is <b>TRUE</b> and
    ///            the value for the cache toggles between <b>TRUE</b> and <b>FALSE</b>.</li> </ul>The download will then resume
    ///            from where it left off before BITS stopped the job.<b>BITS 4.0: </b>This flag is deprecated. </td> </tr> <tr>
    ///            <td width="40%"><a id="BG_JOB_ENABLE_PEERCACHING_SERVER"></a><a
    ///            id="bg_job_enable_peercaching_server"></a><dl> <dt><b>BG_JOB_ENABLE_PEERCACHING_SERVER</b></dt>
    ///            <dt>0x0002</dt> </dl> </td> <td width="60%"> The files of the job can be cached and served to peers. BITS
    ///            will not cache the files and serve them to peers unless both the client computer and job allow BITS to cache
    ///            and serve the files. To allow BITS to cache and serve the files on the client computer, set the
    ///            EnablePeerCaching group policy or call the IBitsPeerCacheAdministration::SetConfigurationFlags method and set
    ///            the BG_ENABLE_PEERCACHING_SERVER flag.<b>BITS 4.0: </b>This flag is deprecated. </td> </tr> <tr> <td
    ///            width="40%"><a id="BG_JOB_DISABLE_BRANCH_CACHE"></a><a id="bg_job_disable_branch_cache"></a><dl>
    ///            <dt><b>BG_JOB_DISABLE_BRANCH_CACHE</b></dt> <dt>0x0004</dt> </dl> </td> <td width="60%"> BITS will not use
    ///            Windows BranchCache for transfer jobs. This setting does not affect the use of Windows BranchCache by
    ///            applications other than BITS. </td> </tr> </table>
    ///Returns:
    ///    The method returns the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT SetPeerCachingFlags(uint Flags);
    ///Retrieves flags that determine if the files of the job can be cached and served to peers and if BITS can download
    ///content for the job from peers.
    ///Params:
    ///    pFlags = Flags that determine if the files of the job can be cached and served to peers and if BITS can download
    ///             content for the job from peers. The following flags can be set: <table> <tr> <th>Value</th> <th>Meaning</th>
    ///             </tr> <tr> <td width="40%"><a id="BG_JOB_ENABLE_PEERCACHING_CLIENT"></a><a
    ///             id="bg_job_enable_peercaching_client"></a><dl> <dt><b>BG_JOB_ENABLE_PEERCACHING_CLIENT</b></dt>
    ///             <dt>0x0001</dt> </dl> </td> <td width="60%"> The job can download content from peers. </td> </tr> <tr> <td
    ///             width="40%"><a id="BG_JOB_ENABLE_PEERCACHING_SERVER"></a><a id="bg_job_enable_peercaching_server"></a><dl>
    ///             <dt><b>BG_JOB_ENABLE_PEERCACHING_SERVER</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%"> The files of
    ///             the job can be cached and served to peers. </td> </tr> </table>
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> If other flag values are set. </td>
    ///    </tr> </table>
    ///    
    HRESULT GetPeerCachingFlags(uint* pFlags);
    ///Gets the integrity level of the token of the owner that created or took ownership of the job.
    ///Params:
    ///    pLevel = Integrity level of the token of the owner that created or took ownership of the job.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetOwnerIntegrityLevel(uint* pLevel);
    ///Gets a value that determines if the token of the owner was elevated at the time they created or took ownership of
    ///the job.
    ///Params:
    ///    pElevated = Is <b>TRUE</b> if the token of the owner was elevated at the time they created or took ownership of the job;
    ///                otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetOwnerElevationState(BOOL* pElevated);
    ///Sets the maximum time that BITS will spend transferring the files in the job.
    ///Params:
    ///    Timeout = Maximum time, in seconds, that BITS will spend transferring the files in the job. The default is 7,776,000
    ///              seconds (90 days).
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT SetMaximumDownloadTime(uint Timeout);
    ///Retrieves the maximum time that BITS will spend transferring the files in the job.
    ///Params:
    ///    pTimeout = Maximum time, in seconds, that BITS will spend transferring the files in the job.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetMaximumDownloadTime(uint* pTimeout);
}

///Use this interface to retrieve the name of the temporary file that contains the downloaded content and to validate
///the file so that peers can request its content. To get an <b>IBackgroundCopyFile3</b> interface pointer, call the
///<b>IBackgroundCopyFile::QueryInterface</b> method using __uuidof(IBackgroundCopyFile3) for the interface identifier.
@GUID("659CDEAA-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyFile3 : IBackgroundCopyFile2
{
    ///Gets the full path of the temporary file that contains the content of the download.
    ///Params:
    ///    pFilename = Null-terminated string that contains the full path of the temporary file. Call the CoTaskMemFree function to
    ///                free <i>ppFileName</i> when done.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetTemporaryName(PWSTR* pFilename);
    ///Sets the validation state of this file.
    ///Params:
    ///    state = Set to <b>TRUE</b> if the file content is valid, otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_PENDING</b></dt> </dl> </td> <td width="60%"> You cannot validate the file until
    ///    the download is complete. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>BG_E_RECORD_DELETED</b></dt> </dl>
    ///    </td> <td width="60%"> The cached record associated with this file has been deleted. </td> </tr> </table>
    ///    
    HRESULT SetValidationState(BOOL state);
    ///Gets the current validation state of this file.
    ///Params:
    ///    pState = <b>TRUE</b> if the contents of the file is valid, otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetValidationState(BOOL* pState);
    ///Gets a value that determines if any part of the file was downloaded from a peer.
    ///Params:
    ///    pVal = Is <b>TRUE</b> if any part of the file was downloaded from a peer; otherwise, <b>FALSE</b>.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT IsDownloadedFromPeer(BOOL* pVal);
}

///Implement this interface to receive notification that a file has completed downloading. Instead of polling for the
///download status of a file, clients use this interface. To receive notifications, call the
///IBackgroundCopyJob::SetNotifyInterface method to specify the interface pointer to your IBackgroundCopyCallback
///implementation. To specify which notifications you want to receive, call the IBackgroundCopyJob::SetNotifyFlags
///method. You must implement all methods of this interface and the IBackgroundCopyCallback interface. For example, if
///you do not register for the file transferred callback, your FileTransferred method must still return <b>S_OK</b>. If
///you do not want to receive the file transferred callback, you can simply implement the <b>IBackgroundCopyCallback</b>
///instead.
@GUID("659CDEAC-489E-11D9-A9CD-000D56965251")
interface IBackgroundCopyCallback2 : IBackgroundCopyCallback
{
    ///BITS calls your implementation of the <b>FileTransferred</b> method when BITS successfully finishes transferring
    ///a file.
    ///Params:
    ///    pJob = Contains job-related information. Do not release <i>pJob</i>; BITS releases the interface when this method
    ///           returns.
    ///    pFile = Contains file-related information. Do not release <i>pFile</i>; BITS releases the interface when this method
    ///            returns.
    ///Returns:
    ///    This method should return <b>S_OK</b>; otherwise, if negative, BITS continues to call this method until
    ///    <b>S_OK</b> is returned. For performance reasons, you should limit the number of times you return a value
    ///    other than <b>S_OK</b> to a few times. As an alternative to returning an error code, consider always
    ///    returning <b>S_OK</b> and handling the error internally. The interval at which this method is called is
    ///    arbitrary.
    ///    
    HRESULT FileTransferred(IBackgroundCopyJob pJob, IBackgroundCopyFile pFile);
}

///Use <b>IBitsTokenOptions</b> to associate and manage a pair of security tokens for a Background Intelligent Transfer
///Service (BITS) transfer job. To get this interface, call the IBackgroundCopyJob::QueryInterface method, using
///__uuidof(IBitsTokenOptions) as the interface identifier.
@GUID("9A2584C3-F7D2-457A-9A5E-22B67BFFC7D2")
interface IBitsTokenOptions : IUnknown
{
    ///Sets the usage flags for a token that is associated with a BITS transfer job.
    ///Params:
    ///    UsageFlags = Specifies the usage flag. This parameter must be set to one of the following values: <table> <tr>
    ///                 <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BG_TOKEN_LOCAL_FILE"></a><a
    ///                 id="bg_token_local_file"></a><dl> <dt><b>BG_TOKEN_LOCAL_FILE</b></dt> <dt>0x0001</dt> </dl> </td> <td
    ///                 width="60%"> If this flag is specified, the helper token is used <ul> <li>To open the local file of an upload
    ///                 job</li> <li>To create or rename the temporary file of a download job</li> <li>To create or rename the reply
    ///                 file of an upload-reply job</li> </ul> </td> </tr> <tr> <td width="40%"><a id="BG_TOKEN_NETWORK"></a><a
    ///                 id="bg_token_network"></a><dl> <dt><b>BG_TOKEN_NETWORK</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
    ///                 If this flag is specified, the helper token is used <ul> <li>To open the remote file of a Server Message
    ///                 Block (SMB) upload or download job</li> <li>In response to an HTTP server or proxy challenge for implicit
    ///                 NTLM or Kerberos credentials</li> </ul> An application is required to call
    ///                 IBackgroundCopyJob2::SetCredentials (..., NULL, NULL) to allow the credentials to be sent over HTTP. </td>
    ///                 </tr> </table>
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetHelperTokenFlags(uint UsageFlags);
    ///Returns the usage flags for a token that is associated with a BITS transfer job.
    ///Params:
    ///    pFlags = Specifies the usage flag to return. This parameter must be set to one of the following values: <table> <tr>
    ///             <th>Value</th> <th>Meaning</th> </tr> <tr> <td width="40%"><a id="BG_TOKEN_LOCAL_FILE"></a><a
    ///             id="bg_token_local_file"></a><dl> <dt><b>BG_TOKEN_LOCAL_FILE</b></dt> <dt>0x0001</dt> </dl> </td> <td
    ///             width="60%"> If this flag is specified, the helper token is used <ul> <li>To open the local file of an upload
    ///             job</li> <li>To create or rename the temporary file of a download job</li> <li>To create or rename the reply
    ///             file of an upload-reply job</li> </ul> </td> </tr> <tr> <td width="40%"><a id="BG_TOKEN_NETWORK"></a><a
    ///             id="bg_token_network"></a><dl> <dt><b>BG_TOKEN_NETWORK</b></dt> <dt>0x0002</dt> </dl> </td> <td width="60%">
    ///             If this flag is specified, the helper token is used <ul> <li>To open the remote file of a Server Message
    ///             Block (SMB) upload or download job</li> <li>In response to an HTTP server or proxy challenge for implicit
    ///             NTLM or Kerberos credentials</li> </ul> An application is required to call the
    ///             IBackgroundCopyJob2::SetCredentials method to allow the credentials to be sent over HTTP. </td> </tr>
    ///             </table>
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHelperTokenFlags(uint* pFlags);
    ///Sets the helper token to impersonate the token of the COM client. Because an application sets the token through
    ///COM impersonation, the token is not persistent and is valid only for the lifetime of a session. When the BITS
    ///service receives a log-off notification, the BITS service discards any helper tokens that are associated with the
    ///transfer job.
    ///Returns:
    ///    The following value might be returned: <table> <tr> <th>Return code/value</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>CO_E_FAILEDTOIMPERSONATE</b></dt> <dt>0x80010123</dt> </dl> </td> <td
    ///    width="60%"> COM settings on the client do not allow impersonate-level access to the client token. </td>
    ///    </tr> <tr> <td width="40%"> <dl> <dt><b>E_ACCESSDENIED</b></dt> <dt>0x80070005</dt> </dl> </td> <td
    ///    width="60%"> <ul> <li>In versions prior to Windows 10, version 1607, the job is not owned by an
    ///    administrator. In those versions of Windows, only administrator-owned jobs may set helper tokens. </li>
    ///    <li>In Windows 10, version 1607 and newer versions, this error indicates that the helper token has
    ///    administrator privileges, but the caller does not have administrator privileges.</li> </ul> </td> </tr>
    ///    </table>
    ///    
    HRESULT SetHelperToken();
    ///Discards the helper token, and does not change the usage flags.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ClearHelperToken();
    ///Returns the SID of the helper token if one is set.<div class="alert"><b>Note</b> This method does not return the
    ///token.</div> <div> </div>
    ///Params:
    ///    pSid = Returns the SID that is retrieved from the <i>TokenInformation</i> parameter of the GetTokenInformation
    ///           function. If no SID is retrieved, this parameter is set to <b>NULL</b>.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHelperTokenSid(PWSTR* pSid);
}

///Use this interface to retrieve download statistics for peers and origin servers. To get an
///<b>IBackgroundCopyFile4</b> interface pointer, call the <b>IBackgroundCopyFile::QueryInterface</b> method using
///__uuidof(IBackgroundCopyFile4) for the interface identifier.
@GUID("EF7E0655-7888-4960-B0E5-730846E03492")
interface IBackgroundCopyFile4 : IBackgroundCopyFile3
{
    ///Specifies statistics about the amount of data downloaded from peers and origin servers.
    ///Params:
    ///    pFromOrigin = Specifies the amount of file data downloaded from the originating server.
    ///    pFromPeers = Specifies the amount of file data downloaded from a peer-to-peer source.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetPeerDownloadStats(ulong* pFromOrigin, ulong* pFromPeers);
}

///Use this interface to query or set several optional behaviors of a job. To get this interface, call the
///<b>IBackgroundCopyJob::QueryInterface</b> method using <code>__uuidof(IBackgroundCopyJob5)</code> as the interface
///identifier.
@GUID("E847030C-BBBA-4657-AF6D-484AA42BF1FE")
interface IBackgroundCopyJob5 : IBackgroundCopyJob4
{
    ///A generic method for setting BITS job properties.
    ///Params:
    ///    PropertyId = The ID of the property that is being set specified as a BITS_JOB_PROPERTY_ID enum value.
    ///    PropertyValue = The value of the property that is being set. In order to hold a value whose type is appropriate to the
    ///                    property, this value is specified via the BITS_JOB_PROPERTY_VALUE union that is composed of all the known
    ///                    property types.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT SetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE PropertyValue);
    ///A generic method for getting BITS job properties.
    ///Params:
    ///    PropertyId = The ID of the property that is being obtained specified as a BITS_JOB_PROPERTY_ID enum value.
    ///    PropertyValue = The property value returned as a BITS_JOB_PROPERTY_VALUE union.
    ///Returns:
    ///    The method returns the following return values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
    ///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> Success </td> </tr> </table>
    ///    
    HRESULT GetProperty(BITS_JOB_PROPERTY_ID PropertyId, BITS_JOB_PROPERTY_VALUE* PropertyValue);
}

///Use this interface to get or set generic properties of BITS file transfers. To get an <b>IBackgroundCopyFile5</b>
///interface pointer, call the <b>IBackgroundCopyFile::QueryInterface</b> method using __uuidof(IBackgroundCopyFile5)
///for the interface identifier.
@GUID("85C1657F-DAFC-40E8-8834-DF18EA25717E")
interface IBackgroundCopyFile5 : IBackgroundCopyFile4
{
    ///Sets a generic property of a BITS file transfer.
    ///Params:
    ///    PropertyId = Specifies the property to be set.
    ///    PropertyValue = A pointer to a union that specifies the value to be set. The union member appropriate for the property ID is
    ///                    used.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE PropertyValue);
    ///Gets a generic property of a BITS file transfer.
    ///Params:
    ///    PropertyId = Specifies the file property whose value is to be retrieved.
    ///    PropertyValue = The property value, returned as a pointer to a BITS_FILE_PROPERTY_VALUE union. Use the union field
    ///                    appropriate for the property ID value passed in.
    ///Returns:
    ///    If this method succeeds, it returns <b xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it
    ///    returns an <b xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetProperty(BITS_FILE_PROPERTY_ID PropertyId, BITS_FILE_PROPERTY_VALUE* PropertyValue);
}

///Clients implement the <b>IBackgroundCopyCallback3</b> interface to receive notification that ranges of a file have
///completed downloading. Instead of polling for the download status of a file, clients use this interface. To receive
///notifications, call the IBackgroundCopyJob::SetNotifyInterface method to specify the interface pointer to your
///IBackgroundCopyCallback implementation. To specify which notifications you want to receive, call the
///IBackgroundCopyJob::SetNotifyFlags method. You must implement all methods of this interface and the
///IBackgroundCopyCallback2 and <b>IBackgroundCopyCallback</b> interface. For example, if you do not register for the
///file transferred callback, your FileTransferred method must still return <b>S_OK</b>. If you do not want to receive
///the file ranges transferred callback, you can simply implement the <b>IBackgroundCopyCallback</b> or
///<b>IBackgroundCopyCallback2</b> instead.
@GUID("98C97BD2-E32B-4AD8-A528-95FD8B16BD42")
interface IBackgroundCopyCallback3 : IBackgroundCopyCallback2
{
    ///BITS calls your implementation of the <b>FileRangesTransferred</b> method when one or more file ranges have been
    ///downloaded. File ranges are added to the job using the IBackgroundCopyFile6::RequestFileRanges method.
    ///Params:
    ///    job = An IBackgroundCopyJob object that contains the methods for accessing property, progress, and state
    ///          information of the job. Do not release <i>pJob</i>; BITS releases the interface when the method returns.
    ///    file = An IBackgroundCopyFile object that contains information about the file whose ranges have changed. Do not
    ///           release <i>pFile</i>; BITS releases the interface when the method returns.
    ///    rangeCount = The count of entries in the ranges array.
    ///    ranges = An array of the files ranges that have transferred since the last call to <b>FileRangesTransferred</b> or the
    ///             last call to the IBackgroundCopyFile6::RequestFileRanges method. Do not free <i>ranges</i>; BITS frees the
    ///             ranges memory when the <b>FileRangesTransferred</b> method returns.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success; otherwise, returns an error code.
    ///    
    HRESULT FileRangesTransferred(IBackgroundCopyJob job, IBackgroundCopyFile file, uint rangeCount, 
                                  const(BG_FILE_RANGE)* ranges);
}

///Use this interface to request file ranges for On Demand download jobs.
@GUID("CF6784F7-D677-49FD-9368-CB47AEE9D1AD")
interface IBackgroundCopyFile6 : IBackgroundCopyFile5
{
    ///Specifies a position to prioritize downloading missing data from.
    ///Params:
    ///    offset = Specifies the new position to prioritize downloading missing data from.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. It will
    ///    return <b>BG_E_RANDOM_ACCESS_NOT_SUPPORTED</b> if the job does not meet the requirements of a
    ///    <b>BITS_JOB_PROPERTY_ON_DEMAND_MODE</b> job.
    ///    
    HRESULT UpdateDownloadPosition(ulong offset);
    ///Adds a new set of file ranges to be prioritized for download.
    ///Params:
    ///    rangeCount = Specifies the size of the <i>Ranges</i> array.
    ///    ranges = An array of file ranges to be downloaded. Requested ranges are allowed to overlap previously downloaded (or
    ///             pending) ranges. Ranges are automatically split into non-overlapping ranges.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code.
    ///    <b>BG_E_INVALID_RANGE</b> is returned if any part of the requested range is outside the actual file size;
    ///    <b>BG_E_RANDOM_ACCESS_NOT_SUPPORTED</b> is returned if the job is not a download job or if the server loses
    ///    its ability to support download ranges.
    ///    
    HRESULT RequestFileRanges(uint rangeCount, const(BG_FILE_RANGE)* ranges);
    ///Returns the set of file ranges that have been downloaded.
    ///Params:
    ///    rangeCount = The number of elements in <i>Ranges</i>.
    ///    ranges = Array of <b>BG_FILE_RANGE</b> structures that describes the ranges that have been downloaded. Ranges will be
    ///             merged together as much as possible. The ranges are ordered by offset. When done, call the CoTaskMemFree
    ///             function to free <i>Ranges</i>.
    ///Returns:
    ///    If this method succeeds, it returns <b>S_OK</b>. Otherwise, it returns an <b>HRESULT</b> error code. The
    ///    error will be <b>E_OUTOFMEMORY</b> if the <i>Ranges</i> array could not be allocated and
    ///    <b>BG_E_RANDOM_ACCESS_NOT_SUPPORTED</b> if the job is not a download job or if the server loses its ability
    ///    to support download ranges.
    ///    
    HRESULT GetFilledFileRanges(uint* rangeCount, BG_FILE_RANGE** ranges);
}

///Use this interface to retrieve and/or to override the HTTP method used for a BITS transfer. To get this interface,
///call the <b>IBackgroundCopyJob::QueryInterface</b> method using __uuidof(IBackgroundCopyJobHttpOptions2) for the
///interface identifier.
@GUID("B591A192-A405-4FC3-8323-4C5C542578FC")
interface IBackgroundCopyJobHttpOptions2 : IBackgroundCopyJobHttpOptions
{
    ///Overrides the default HTTP method used for a BITS transfer.
    ///Params:
    ///    method = Type: <b>LPCWSTR</b> A pointer to a constant null-terminated string of wide characters containing the HTTP
    ///             method name.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetHttpMethod(const(PWSTR) method);
    ///Retrieves a wide string containing the HTTP method name for the BITS transfer. By default, download jobs will be
    ///"GET", and upload and upload-reply jobs will be "BITS_POST".
    ///Params:
    ///    method = Type: <b>LPWSTR*</b> The address of a pointer to a null-terminated string of wide characters. If successful,
    ///             the method updates the pointer to point to a string containing the HTTP method name. When you're done with
    ///             this string, free it with a call to CoTaskMemFree.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetHttpMethod(PWSTR* method);
}

///Server certificates are sent when an HTTPS connection is opened. Use this method to implement a callback to be called
///to validate those server certificates. This interface extends
///[IUnknown](/windows/desktop/api/unknwn/nn-unknwn-iunknown).
@GUID("4CEC0D02-DEF7-4158-813A-C32A46945FF7")
interface IBackgroundCopyServerCertificateValidationCallback : IUnknown
{
    ///A callback method that you implement that will be called so that you can validate the server certificates sent
    ///when an HTTPS connection is opened.
    ///Params:
    ///    job = Type: **[IBackgroundCopyJob](/windows/desktop/api/bits/nn-bits-ibackgroundcopyjob)\*** The job.
    ///    file = Type: **[IBackgroundCopyFile](/windows/desktop/api/bits/nn-bits-ibackgroundcopyfile)\*** The file being
    ///           transferred.
    ///    certLength = Type: **[DWORD](/windows/desktop/winprog/windows-data-types)** The length in bytes of the certificate data.
    ///    certData = Type: **const [BYTE](/windows/desktop/winprog/windows-data-types) \[\]** An array of bytes containing the
    ///               certificate data. The number of bytes must match `certLength`.
    ///    certEncodingType = Type: **[DWORD](/windows/desktop/winprog/windows-data-types)** The certificate encoding type.
    ///    certStoreLength = Type: **[DWORD](/windows/desktop/winprog/windows-data-types)** The length in bytes of the certificate store
    ///                      data.
    ///    certStoreData = Type: **const [BYTE](/windows/desktop/winprog/windows-data-types) \[\]** An array of bytes containing the
    ///                    certificate store data. The number of bytes must match `certStoreLength`.
    ///Returns:
    ///    Return **S_OK** to indicate that the certificate is acceptable. Otherwise, return any
    ///    [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10) to indicate that the certificate is not acceptable.
    ///    
    HRESULT ValidateServerCertificate(IBackgroundCopyJob job, IBackgroundCopyFile file, uint certLength, 
                                      const(ubyte)* certData, uint certEncodingType, uint certStoreLength, 
                                      const(ubyte)* certStoreData);
}

///Use this interface to set HTTP customer headers to write-only, or to set a server certificate validation callback
///method that you've implemented. This interface extends
///[IBackgroundCopyJobHttpOptions2](/windows/desktop/api/bits10_2/nn-bits10_2-ibackgroundcopyjobhttpoptions2).
@GUID("8A9263D3-FD4C-4EDA-9B28-30132A4D4E3C")
interface IBackgroundCopyJobHttpOptions3 : IBackgroundCopyJobHttpOptions2
{
    ///Server certificates are sent when an HTTPS connection is opened. Use this method to set a callback to be called
    ///to validate those server certificates.
    ///Params:
    ///    certValidationCallback = Type: **[IUnknown](/windows/desktop/api/unknwn/nn-unknwn-iunknown)\*** A pointer to an object that implements
    ///                             [IBackgroundCopyServerCertificateValidationCallback](/windows/desktop/api/bits10_3/nn-bits10_3-ibackgroundcopyservercertificatevalidationcallback).
    ///                             To remove the current callback interface pointer, set this parameter to `nullptr`.
    ///Returns:
    ///    Type: **[HRESULT](/windows/desktop/com/structure-of-com-error-codes)** If the function succeeds, it returns
    ///    **S_OK**. Otherwise, it returns an [**HRESULT**](/windows/desktop/com/structure-of-com-error-codes) [error
    ///    code](/windows/desktop/com/com-error-codes-10). |Return value|Description| |-|-| |E_NOINTERFACE|You pass an
    ///    interface pointer that cannot be queried for
    ///    [IBackgroundCopyServerCertificateValidationCallback](/windows/desktop/api/bits10_3/nn-bits10_3-ibackgroundcopyservercertificatevalidationcallback).|
    ///    |BG_E_READ_ONLY_WHEN_JOB_ACTIVE|The state of a job must be PAUSED to set the callback.|
    ///    
    HRESULT SetServerCertificateValidationInterface(IUnknown certValidationCallback);
    ///Sets the HTTP custom headers for this job to be write-only. Write-only headers cannot be read by BITS methods
    ///such as the [IBackgroundCopyJobHttpOptions::GetCustomHeaders
    ///method](/windows/desktop/api/bits2_5/nf-bits2_5-ibackgroundcopyjobhttpoptions-getcustomheaders).
    ///Returns:
    ///    The return value is always **S_OK**.
    ///    
    HRESULT MakeCustomHeadersWriteOnly();
}

///Use the <b>IBITSExtensionSetup</b> interface to enable or disable BITS uploads to a virtual directory. This interface
///is an ADSI extension. To get a pointer to this interface, call the ADsGetObject ADSI function as shown in Example
///Code. If you use this interface from a setup program that also installs the BITS server, you must call the
///IBITSExtensionSetupFactory::GetObject method to get a pointer to this interface instead of calling the ADsGetObject
///function.
@GUID("29CFBBF7-09E4-4B97-B0BC-F2287E3D8EB3")
interface IBITSExtensionSetup : IDispatch
{
    ///Use the <b>EnableBITSUploads</b> method to enable BITS upload on the virtual directory to which the ADSI object
    ///points. This method sets the BITSUploadEnabled IIS extension property.
    ///Returns:
    ///    This method returns <b>S_OK</b> for success. Otherwise, the method failed.
    ///    
    HRESULT EnableBITSUploads();
    ///Use the <b>DisableBITSUploads</b> method to disable BITS upload on the virtual directory to which the ADSI object
    ///points. This method sets the BITSUploadEnabled IIS extension property.
    ///Returns:
    ///    This method returns <b>S_OK</b> for success. Otherwise, the method failed.
    ///    
    HRESULT DisableBITSUploads();
    ///Use the <b>GetCleanupTaskName</b> method to retrieve the name of the cleanup task associated with the virtual
    ///directory.
    ///Params:
    ///    pTaskName = Null-terminated string containing the name of the cleanup task associated with the virtual directory. If
    ///                <b>NULL</b>, BITS has not created a cleanup task for the virtual directory. When done, call the
    ///                <b>SysFreeString</b> function to free <i>pTaskName</i>.
    ///Returns:
    ///    This method returns <b>S_OK</b> for success. Otherwise, the method returns <b>S_FALSE</b> if a task name has
    ///    not been specified for the virtual directory.
    ///    
    HRESULT GetCleanupTaskName(BSTR* pTaskName);
    ///Use the <b>GetCleanupTask</b> method to retrieve an interface pointer to the cleanup task associated with the
    ///virtual directory.
    ///Params:
    ///    riid = Identifies the task scheduler interface to return in <i>ppTask</i>. For a list of identifiers, see the
    ///           ITaskScheduler::Activate method.
    ///    ppUnk = A pointer to the interface specified by <i>riid</i>. Use the interface to modify the properties of the task.
    ///            Release <i>ppTask</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> for success. Otherwise, the method returns <b>S_FALSE</b> if a task has not
    ///    been created for the virtual directory.
    ///    
    HRESULT GetCleanupTask(const(GUID)* riid, IUnknown* ppUnk);
}

///Use the <b>IBITSExtensionSetupFactory</b> interface to get a pointer to the IBITSExtensionSetup interface. Only use
///this interface if you use the <b>IBITSExtensionSetup</b> interface in a setup program that also installs the BITS
///server. Because the IIS cache does not contain the BITS extensions added during setup, the extensions are not
///available using the ADsGetObject ADSI function. The <b>IBITSExtensionSetupFactory</b> interface provides a GetObject
///method, which accesses the BITS extensions and performs the same binding as the <b>ADsGetObject</b> function. To get
///a pointer to the <b>IBITSExtensionSetupFactory</b> interface, call the CoCreateInstance function as shown in Example
///Code.
@GUID("D5D2D542-5503-4E64-8B48-72EF91A32EE1")
interface IBITSExtensionSetupFactory : IDispatch
{
    HRESULT GetObjectA(BSTR Path, IBITSExtensionSetup* ppExtensionSetup);
}

///<p class="CCE_Message">[<b>IBackgroundCopyJob1</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.] Use
///the <b>IBackgroundCopyJob1</b> interface to add files to the job and retrieve the job's status.
@GUID("59F5553C-2031-4629-BB18-2645A6970947")
interface IBackgroundCopyJob1 : IUnknown
{
    HRESULT CancelJob();
    ///<p class="CCE_Message">[<b>IBackgroundCopyJob1</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>GetProgress</b> method to retrieve the job's progress.
    ///Params:
    ///    dwFlags = Type of progress to retrieve. Specify one of the following flags. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="QM_PROGRESS_PERCENT_DONE"></a><a
    ///              id="qm_progress_percent_done"></a><dl> <dt><b>QM_PROGRESS_PERCENT_DONE</b></dt> </dl> </td> <td width="60%">
    ///              Returns the percent of the download that is complete. </td> </tr> <tr> <td width="40%"><a
    ///              id="QM_PROGRESS_SIZE_DONE"></a><a id="qm_progress_size_done"></a><dl> <dt><b>QM_PROGRESS_SIZE_DONE</b></dt>
    ///              </dl> </td> <td width="60%"> Returns the number of bytes downloaded. </td> </tr> <tr> <td width="40%"><a
    ///              id="QM_PROGRESS_TIME_DONE"></a><a id="qm_progress_time_done"></a><dl> <dt><b>QM_PROGRESS_TIME_DONE</b></dt>
    ///              </dl> </td> <td width="60%"> Not supported. </td> </tr> </table>
    ///    pdwProgress = Progress of the download. The progress represents the number of bytes downloaded or the percent of the
    ///                  download that is complete, depending on <i>dwFlags</i>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the job's progress. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> You cannot specify QM_PROGRESS_TIME_DONE for the
    ///    <i>dwFlags</i> parameter. </td> </tr> </table>
    ///    
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    ///<p class="CCE_Message">[IBackgroundCopyJob1 is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>GetStatus</b> method to retrieve the state of the job.
    ///Params:
    ///    pdwStatus = State of the job. The state can be set to one or more of the following flags. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="QM_STATUS_JOB_FOREGROUND"></a><a
    ///                id="qm_status_job_foreground"></a><dl> <dt><b>QM_STATUS_JOB_FOREGROUND</b></dt> </dl> </td> <td width="60%">
    ///                Not supported. </td> </tr> <tr> <td width="40%"><a id="QM_STATUS_JOB_INCOMPLETE"></a><a
    ///                id="qm_status_job_incomplete"></a><dl> <dt><b>QM_STATUS_JOB_INCOMPLETE</b></dt> </dl> </td> <td width="60%">
    ///                QMGR is still downloading the job. </td> </tr> <tr> <td width="40%"><a id="QM_STATUS_JOB_COMPLETE"></a><a
    ///                id="qm_status_job_complete"></a><dl> <dt><b>QM_STATUS_JOB_COMPLETE</b></dt> </dl> </td> <td width="60%"> The
    ///                job is complete. </td> </tr> <tr> <td width="40%"><a id="QM_STATUS_JOB_ERROR"></a><a
    ///                id="qm_status_job_error"></a><dl> <dt><b>QM_STATUS_JOB_ERROR</b></dt> </dl> </td> <td width="60%"> An error
    ///                occurred while processing the job. </td> </tr> </table>
    ///    pdwWin32Result = Win32 error code. Valid only if the QM_STATUS_JOB_ERROR <i>dwStatus</i> flag is set.
    ///    pdwTransportResult = HTTP error code. Valid only if the QM_STATUS_JOB_ERROR <i>dwStatus</i> flag is set.
    ///    pdwNumOfRetries = Number of times QMGR tried to download the job after an error occurs. Valid only if the QM_STATUS_GROUP_ERROR
    ///                      <i>dwStatus</i> flag is set.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the state of the job. </td> </tr> </table>
    ///    
    HRESULT GetStatus(uint* pdwStatus, uint* pdwWin32Result, uint* pdwTransportResult, uint* pdwNumOfRetries);
    ///<p class="CCE_Message">[<b>IBackgroundCopyJob1</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>AddFiles</b> method to add one or more files to download to the job.
    ///Params:
    ///    cFileCount = Number of files in <i>pFileInfo</i> to add to the job.
    ///    ppFileSet = Array of FILESETINFO structures that contain the remote and local names of the files to download.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Files were successfully added to the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> Local or remote file name is invalid. For example,
    ///    the remote file name specifies an unsupported protocol. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> User does not have permission to write to the
    ///    specified directory on the client. </td> </tr> </table>
    ///    
    HRESULT AddFiles(uint cFileCount, FILESETINFO** ppFileSet);
    ///<p class="CCE_Message">[<b>IBackgroundCopyJob1</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>GetFile</b> method to retrieve the remote and local file names for the given file in the job.
    ///Params:
    ///    cFileIndex = Zero-based index that identifies the file in the job.
    ///    pFileInfo = A FILESETINFO structure that contains the remote and local names of the file.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the file from the job. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>QM_E_ITEM_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The specified index is greater than the
    ///    number of files in the job. </td> </tr> </table>
    ///    
    HRESULT GetFile(uint cFileIndex, FILESETINFO* pFileInfo);
    ///<p class="CCE_Message">[<b>IBackgroundCopyJob1</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>GetFileCount</b> method to retrieve the number of files in the job.
    ///Params:
    ///    pdwFileCount = Number of files in the job.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the number of files in the job. </td> </tr> </table>
    ///    
    HRESULT GetFileCount(uint* pdwFileCount);
    HRESULT SwitchToForeground();
    ///<p class="CCE_Message">[IBackgroundCopyJob1 is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>get_JobID</b> method to retrieve the job's identifier.
    ///Params:
    ///    pguidJobID = GUID that uniquely identifies the job.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the GUID that identifies the job. </td> </tr> </table>
    ///    
    HRESULT get_JobID(GUID* pguidJobID);
}

///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
///Use the <b>IEnumBackgroundCopyJobs1</b> interface to enumerate the list of jobs in a group. To get an
///<b>IEnumBackgroundCopyJobs1</b> interface pointer, call the IBackgroundCopyGroup::EnumJobs method.
@GUID("8BAEBA9D-8F1C-42C4-B82C-09AE79980D25")
interface IEnumBackgroundCopyJobs1 : IUnknown
{
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Next</b> method to retrieve the specified number of items in the enumeration sequence. If
    ///there are fewer than the requested number of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of GUIDs that identify the jobs. To retrieve a job, call the IBackgroundCopyGroup::GetJob method with
    ///            the GUID.
    ///    pceltFetched = Number of elements in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is one.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Skip</b> method to skip the next specified number of elements in the enumeration
    ///sequence. If there are fewer elements left in the sequence than the requested number of elements to skip, it
    ///skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Reset</b> method to reset the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success.
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Clone</b> method to create another IEnumBackgroundCopyJobs1 enumerator that contains the
    ///same enumeration state as the current one. Using this method, a client can record a particular point in the
    ///enumeration sequence, and then return to that point at a later time. The new enumerator supports the same
    ///interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppenum</i> when done.
    ///Returns:
    ///    This method returns S_OK on success.
    ///    
    HRESULT Clone(IEnumBackgroundCopyJobs1* ppenum);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyJobs1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>GetCount</b> method to retrieve a count of the number of jobs in the enumeration.
    ///Params:
    ///    puCount = Number of jobs in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success.
    ///    
    HRESULT GetCount(uint* puCount);
}

///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.] Use
///the <b>IBackgroundCopyGroup</b> interface to manage a group. A group contains download jobs. For example, add a job
///to the group, set the properties of the group, and start and stop the group in the download queue.
@GUID("1DED80A7-53EA-424F-8A04-17FEA9ADC4F5")
interface IBackgroundCopyGroup : IUnknown
{
    HRESULT GetPropA(GROUPPROP propID, VARIANT* pvarVal);
    HRESULT SetPropA(GROUPPROP propID, VARIANT* pvarVal);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>GetProgress</b> method to retrieve the progress of the download.
    ///Params:
    ///    dwFlags = Type of progress to retrieve. Specify one of the following flags. <table> <tr> <th>Value</th>
    ///              <th>Meaning</th> </tr> <tr> <td width="40%"><a id="QM_PROGRESS_PERCENT_DONE"></a><a
    ///              id="qm_progress_percent_done"></a><dl> <dt><b>QM_PROGRESS_PERCENT_DONE</b></dt> </dl> </td> <td width="60%">
    ///              Returns the percent of the download that is complete. </td> </tr> <tr> <td width="40%"><a
    ///              id="QM_PROGRESS_SIZE_DONE"></a><a id="qm_progress_size_done"></a><dl> <dt><b>QM_PROGRESS_SIZE_DONE</b></dt>
    ///              </dl> </td> <td width="60%"> Returns the number of bytes downloaded. </td> </tr> <tr> <td width="40%"><a
    ///              id="QM_PROGRESS_TIME_DONE"></a><a id="qm_progress_time_done"></a><dl> <dt><b>QM_PROGRESS_TIME_DONE</b></dt>
    ///              </dl> </td> <td width="60%"> Not supported. </td> </tr> </table>
    ///    pdwProgress = Progress of the download. The progress represents the number of bytes downloaded or the percent of the
    ///                  download that is complete, depending on <i>dwFlags</i>.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the group's progress. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> You cannot specify QM_PROGRESS_TIME_DONE for the
    ///    <i>dwFlags</i> parameter. </td> </tr> </table>
    ///    
    HRESULT GetProgress(uint dwFlags, uint* pdwProgress);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>GetStatus</b> method to retrieve the state of the group.
    ///Params:
    ///    pdwStatus = State of the group. The state can be set to one or more of the following flags. <table> <tr> <th>Value</th>
    ///                <th>Meaning</th> </tr> <tr> <td width="40%"><a id="QM_STATUS_GROUP_FOREGROUND"></a><a
    ///                id="qm_status_group_foreground"></a><dl> <dt><b>QM_STATUS_GROUP_FOREGROUND</b></dt> </dl> </td> <td
    ///                width="60%"> QMGR is downloading the group in the foreground. </td> </tr> <tr> <td width="40%"><a
    ///                id="QM_STATUS_GROUP_INCOMPLETE"></a><a id="qm_status_group_incomplete"></a><dl>
    ///                <dt><b>QM_STATUS_GROUP_INCOMPLETE</b></dt> </dl> </td> <td width="60%"> QMGR is still downloading the group.
    ///                </td> </tr> <tr> <td width="40%"><a id="QM_STATUS_GROUP_SUSPENDED"></a><a
    ///                id="qm_status_group_suspended"></a><dl> <dt><b>QM_STATUS_GROUP_SUSPENDED</b></dt> </dl> </td> <td
    ///                width="60%"> The group is suspended. </td> </tr> <tr> <td width="40%"><a id="QM_STATUS_GROUP_ERROR"></a><a
    ///                id="qm_status_group_error"></a><dl> <dt><b>QM_STATUS_GROUP_ERROR</b></dt> </dl> </td> <td width="60%"> An
    ///                error occurred while processing the group. </td> </tr> </table>
    ///    pdwJobIndex = Current job in progress. The index is always 0 (groups can only contain one job).
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the state of the group. </td> </tr> </table>
    ///    
    HRESULT GetStatus(uint* pdwStatus, uint* pdwJobIndex);
    HRESULT GetJobA(GUID jobID, IBackgroundCopyJob1* ppJob);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>SuspendGroup</b> method to pause a group in the download queue. New groups, groups that
    ///are in error, or groups that have finished downloading are automatically suspended.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully suspended the group in the download queue. </td> </tr> </table>
    ///    
    HRESULT SuspendGroup();
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>ResumeGroup</b> method to start a group that has been suspended in the download queue.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully resumed the group in the download queue. </td> </tr> </table>
    ///    
    HRESULT ResumeGroup();
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>CancelGroup</b> method to remove the group from the queue. Files completely downloaded
    ///before calling this method are available to the client. You can cancel a group at anytime; however, the group
    ///cannot be recovered once it is canceled.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> The group was successfully canceled. </td> </tr> </table>
    ///    
    HRESULT CancelGroup();
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>get_Size</b> method to retrieve the size of all files in the group to download.
    ///Params:
    ///    pdwSize = Total size, in bytes, of all files in the group to download, or 0 if QMGR cannot determine the size.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the size of the group. </td> </tr> </table>
    ///    
    HRESULT get_Size(uint* pdwSize);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>get_GroupID</b> method to retrieve the group's identifier.
    ///Params:
    ///    pguidGroupID = GUID that uniquely identifies the group within the download queue.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the GUID that identifies the group. </td> </tr> </table>
    ///    
    HRESULT get_GroupID(GUID* pguidGroupID);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>CreateJob</b> method to add a new job to the group. A group can contain only one job.
    ///Params:
    ///    guidJobID = Uniquely identifies the job in the group and queue.
    ///    ppJob = Pointer to an IBackgroundCopyJob1 interface pointer. Use the interface to add files and check the state of
    ///            the job.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> The job was successfully created. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>QM_E_INVALID_STATE</b></dt> </dl> </td> <td width="60%"> The job is already running. </td> </tr> <tr>
    ///    <td width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> Only one job allowed per group.
    ///    </td> </tr> </table>
    ///    
    HRESULT CreateJob(GUID guidJobID, IBackgroundCopyJob1* ppJob);
    HRESULT EnumJobsA(uint dwFlags, IEnumBackgroundCopyJobs1* ppEnumJobs);
    ///<p class="CCE_Message">[<b>IBackgroundCopyGroup</b> is available for use in the operating systems specified in
    ///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>SwitchToForeground</b> method to download the group in the foreground instead of the
    ///background.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully switched the group to foreground processing. </td> </tr> </table>
    ///    
    HRESULT SwitchToForeground();
    HRESULT QueryNewJobInterface(const(GUID)* iid, IUnknown* pUnk);
    HRESULT SetNotificationPointer(const(GUID)* iid, IUnknown pUnk);
}

///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
///Use the <b>IEnumBackgroundCopyGroups</b> interface to enumerate the list of groups in the download queue. To get an
///<b>IEnumBackgroundCopyGroups</b> interface pointer, call the IBackgroundCopyQMgr::EnumGroups method.
@GUID("D993E603-4AA4-47C5-8665-C20D39C2BA4F")
interface IEnumBackgroundCopyGroups : IUnknown
{
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Next</b> method to retrieve the specified number of items in the enumeration sequence. If
    ///there are fewer than the requested number of elements left in the sequence, it retrieves the remaining elements.
    ///Params:
    ///    celt = Number of elements requested.
    ///    rgelt = Array of GUIDs that identify the groups. To retrieve a group, call the IBackgroundCopyQMgr::GetGroup method
    ///            with the GUID.
    ///    pceltFetched = Number of elements in <i>rgelt</i>. You can set <i>pceltFetched</i> to <b>NULL</b> if <i>celt</i> is one.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully returned the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Returned less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Next(uint celt, GUID* rgelt, uint* pceltFetched);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Skip</b> method to skip the next specified number of elements in the enumeration
    ///sequence. If there are fewer elements left in the sequence than the requested number of elements to skip, it
    ///skips past the last element in the sequence.
    ///Params:
    ///    celt = Number of elements to skip.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully skipped the number of requested elements. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>S_FALSE</b></dt> </dl> </td> <td width="60%"> Skipped less than the number of requested elements.
    ///    </td> </tr> </table>
    ///    
    HRESULT Skip(uint celt);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Reset</b> method to reset the enumeration sequence to the beginning.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success.
    ///    
    HRESULT Reset();
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>Clone</b> method to create another IEnumBackgroundCopyGroups enumerator that contains the
    ///same enumeration state as the current one. Using this method, a client can record a particular point in the
    ///enumeration sequence, and then return to that point at a later time. The new enumerator supports the same
    ///interface as the original one.
    ///Params:
    ///    ppenum = Receives the interface pointer to the enumeration object. If the method is unsuccessful, the value of this
    ///             output variable is undefined. You must release <i>ppenum</i> when done.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success.
    ///    
    HRESULT Clone(IEnumBackgroundCopyGroups* ppenum);
    ///<p class="CCE_Message">[<b>IEnumBackgroundCopyGroups</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Use the <b>GetCount</b> method to retrieve a count of the number of groups in the enumeration.
    ///Params:
    ///    puCount = Number of groups in the enumeration.
    ///Returns:
    ///    This method returns <b>S_OK</b> on success.
    ///    
    HRESULT GetCount(uint* puCount);
}

///<p class="CCE_Message">[<b>IBackgroundCopyCallback1</b> is available for use in the operating systems specified in
///the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
///Implement the <b>IBackgroundCopyCallback1</b> interface to receive notification when events occur. Applications use
///this interface as an option to polling for the state of the group. To receive notifications, call the
///IBackgroundCopyGroup::SetProp method to set the <b>GROUPPROP_NOTIFYCLSID</b> and <b>GROUPPROP_NOTIFYFLAGS</b>
///properties. QMGR uses the interface pointer while it is valid (the interface pointer becomes invalid when your
///application exits). When your application restarts, you must reset the <b>GROUPPROP_NOTIFYCLSID</b> property on those
///groups that QMGR is still processing. <div class="alert"><b>Note</b> QMGR activates the new object inside the scope
///of the client process; notifications are not run in their own process. QMGR creates a new object of that CLSID and
///passes an interface pointer to BITS. </div><div> </div>You must implement all methods of the
///<b>IBackgroundCopyCallback1</b> interface. At a minimum, the method must return <b>S_OK</b>. To reduce the chance
///that your callback blocks BITS, keep your implementation short. If an administrator takes ownership of the group, the
///notification callbacks are made in the context of the user who requested notification.
@GUID("084F6593-3800-4E08-9B59-99FA59ADDF82")
interface IBackgroundCopyCallback1 : IUnknown
{
    ///<p class="CCE_Message">[<b>IBackgroundCopyCallback1</b> is available for use in the operating systems specified
    ///in the Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS
    ///interfaces.] Implement the <b>OnStatus</b> method to receive notification when the group is complete or an error
    ///occurs.
    ///Params:
    ///    pGroup = Interface pointer to the group that generated the event.
    ///    pJob = Interface pointer to the job associated with the event or <b>NULL</b> if the event is not associated with a
    ///           job.
    ///    dwFileIndex = Index to the file associated with the error or -1. To retrieve the file, call the
    ///                  IBackgroundCopyJob1::GetFile method.
    ///    dwStatus = The state of the group. The state of the group is either complete (all jobs in the group have been
    ///               downloaded) or in error. An error occurred if the QM_STATUS_GROUP_ERROR flag is set. Otherwise, the group is
    ///               complete.
    ///    dwNumOfRetries = Number of times QMGR tried to download the group after an error occurs. Valid only if the
    ///                     QM_STATUS_GROUP_ERROR <i>dwStatus</i> flag is set.
    ///    dwWin32Result = Win32 error code. Valid only if the QM_STATUS_GROUP_ERROR <i>dwStatus</i> flag is set.
    ///    dwTransportResult = HTTP error code. Valid only if the QM_STATUS_GROUP_ERROR <i>dwStatus</i> flag is set.
    ///Returns:
    ///    This method should return <b>S_OK</b>; otherwise, the service continues to call this method until S_OK is
    ///    returned. The interval at which the implementation is called is arbitrary.
    ///    
    HRESULT OnStatus(IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, uint dwStatus, 
                     uint dwNumOfRetries, uint dwWin32Result, uint dwTransportResult);
    HRESULT OnProgress(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, uint dwFileIndex, 
                       uint dwProgressValue);
    HRESULT OnProgressEx(uint ProgressType, IBackgroundCopyGroup pGroup, IBackgroundCopyJob1 pJob, 
                         uint dwFileIndex, uint dwProgressValue, uint dwByteArraySize, ubyte* pByte);
}

///<p class="CCE_Message">[<b>IBackgroundCopyQMgr</b> is available for use in the operating systems specified in the
///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.] Use
///the <b>IBackgroundCopyQMgr</b> interface to create a new group, retrieve an existing group, or enumerate all groups
///in the queue. A group contains a download job.
@GUID("16F41C69-09F5-41D2-8CD8-3C08C47BC8A8")
interface IBackgroundCopyQMgr : IUnknown
{
    ///<p class="CCE_Message">[<b>IBackgroundCopyQMgr</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>CreateGroup</b> method to create a new group and add it to the download queue.
    ///Params:
    ///    guidGroupID = GUID that uniquely identifies the group in the download queue.
    ///    ppGroup = Pointer to an IBackgroundCopyGroup interface pointer. Use this interface to manage the group. For example,
    ///              add a job to the group and set the properties of the group.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully created the group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> A group already exists with that GUID. </td> </tr>
    ///    </table>
    ///    
    HRESULT CreateGroup(GUID guidGroupID, IBackgroundCopyGroup* ppGroup);
    ///<p class="CCE_Message">[IBackgroundCopyQMgr is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>GetGroup</b> method to retrieve a group from the download queue. The current user can retrieve only
    ///groups that they own. If the user has Administrator privileges, the user can retrieve any group from the download
    ///queue. Retrieving a group from the queue transfers ownership of the group to the current user.
    ///Params:
    ///    groupID = GUID that uniquely identifies the group in the download queue.
    ///    ppGroup = Pointer to an IBackgroundCopyGroup interface pointer. Use this interface to manage the group. For example,
    ///              add a job to the group and set the properties of the group.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved the group. </td> </tr> <tr> <td width="40%"> <dl>
    ///    <dt><b>QM_E_ITEM_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> Could not find the group in the download
    ///    queue. </td> </tr> </table>
    ///    
    HRESULT GetGroup(GUID groupID, IBackgroundCopyGroup* ppGroup);
    ///<p class="CCE_Message">[<b>IBackgroundCopyQMgr</b> is available for use in the operating systems specified in the
    ///Requirements section. It may be altered or unavailable in subsequent versions. Instead, use the BITS interfaces.]
    ///Use the <b>EnumGroups</b> method to retrieve a list of groups that the current user owns. If the current user has
    ///Administrator privileges, the method returns all groups in the queue.
    ///Params:
    ///    dwFlags = Must be 0.
    ///    ppEnumGroups = Pointer to an IEnumBackgroundCopyGroups interface pointer. Use this interface to retrieve a group from the
    ///                   list.
    ///Returns:
    ///    This method returns the following <b>HRESULT</b> values, as well as others. <table> <tr> <th>Return code</th>
    ///    <th>Description</th> </tr> <tr> <td width="40%"> <dl> <dt><b><b>S_OK</b></b></dt> </dl> </td> <td
    ///    width="60%"> Successfully retrieved a list of the groups in the download queue. </td> </tr> <tr> <td
    ///    width="40%"> <dl> <dt><b>E_NOTIMPL</b></dt> </dl> </td> <td width="60%"> The <i>dwFlags</i> parameter must be
    ///    0. </td> </tr> </table>
    ///    
    HRESULT EnumGroups(uint dwFlags, IEnumBackgroundCopyGroups* ppEnumGroups);
}


// GUIDs

const GUID CLSID_BITSExtensionSetupFactory = GUIDOF!BITSExtensionSetupFactory;
const GUID CLSID_BackgroundCopyManager     = GUIDOF!BackgroundCopyManager;
const GUID CLSID_BackgroundCopyManager10_1 = GUIDOF!BackgroundCopyManager10_1;
const GUID CLSID_BackgroundCopyManager10_2 = GUIDOF!BackgroundCopyManager10_2;
const GUID CLSID_BackgroundCopyManager10_3 = GUIDOF!BackgroundCopyManager10_3;
const GUID CLSID_BackgroundCopyManager1_5  = GUIDOF!BackgroundCopyManager1_5;
const GUID CLSID_BackgroundCopyManager2_0  = GUIDOF!BackgroundCopyManager2_0;
const GUID CLSID_BackgroundCopyManager2_5  = GUIDOF!BackgroundCopyManager2_5;
const GUID CLSID_BackgroundCopyManager3_0  = GUIDOF!BackgroundCopyManager3_0;
const GUID CLSID_BackgroundCopyManager4_0  = GUIDOF!BackgroundCopyManager4_0;
const GUID CLSID_BackgroundCopyManager5_0  = GUIDOF!BackgroundCopyManager5_0;
const GUID CLSID_BackgroundCopyQMgr        = GUIDOF!BackgroundCopyQMgr;

const GUID IID_AsyncIBackgroundCopyCallback                       = GUIDOF!AsyncIBackgroundCopyCallback;
const GUID IID_IBITSExtensionSetup                                = GUIDOF!IBITSExtensionSetup;
const GUID IID_IBITSExtensionSetupFactory                         = GUIDOF!IBITSExtensionSetupFactory;
const GUID IID_IBackgroundCopyCallback                            = GUIDOF!IBackgroundCopyCallback;
const GUID IID_IBackgroundCopyCallback1                           = GUIDOF!IBackgroundCopyCallback1;
const GUID IID_IBackgroundCopyCallback2                           = GUIDOF!IBackgroundCopyCallback2;
const GUID IID_IBackgroundCopyCallback3                           = GUIDOF!IBackgroundCopyCallback3;
const GUID IID_IBackgroundCopyError                               = GUIDOF!IBackgroundCopyError;
const GUID IID_IBackgroundCopyFile                                = GUIDOF!IBackgroundCopyFile;
const GUID IID_IBackgroundCopyFile2                               = GUIDOF!IBackgroundCopyFile2;
const GUID IID_IBackgroundCopyFile3                               = GUIDOF!IBackgroundCopyFile3;
const GUID IID_IBackgroundCopyFile4                               = GUIDOF!IBackgroundCopyFile4;
const GUID IID_IBackgroundCopyFile5                               = GUIDOF!IBackgroundCopyFile5;
const GUID IID_IBackgroundCopyFile6                               = GUIDOF!IBackgroundCopyFile6;
const GUID IID_IBackgroundCopyGroup                               = GUIDOF!IBackgroundCopyGroup;
const GUID IID_IBackgroundCopyJob                                 = GUIDOF!IBackgroundCopyJob;
const GUID IID_IBackgroundCopyJob1                                = GUIDOF!IBackgroundCopyJob1;
const GUID IID_IBackgroundCopyJob2                                = GUIDOF!IBackgroundCopyJob2;
const GUID IID_IBackgroundCopyJob3                                = GUIDOF!IBackgroundCopyJob3;
const GUID IID_IBackgroundCopyJob4                                = GUIDOF!IBackgroundCopyJob4;
const GUID IID_IBackgroundCopyJob5                                = GUIDOF!IBackgroundCopyJob5;
const GUID IID_IBackgroundCopyJobHttpOptions                      = GUIDOF!IBackgroundCopyJobHttpOptions;
const GUID IID_IBackgroundCopyJobHttpOptions2                     = GUIDOF!IBackgroundCopyJobHttpOptions2;
const GUID IID_IBackgroundCopyJobHttpOptions3                     = GUIDOF!IBackgroundCopyJobHttpOptions3;
const GUID IID_IBackgroundCopyManager                             = GUIDOF!IBackgroundCopyManager;
const GUID IID_IBackgroundCopyQMgr                                = GUIDOF!IBackgroundCopyQMgr;
const GUID IID_IBackgroundCopyServerCertificateValidationCallback = GUIDOF!IBackgroundCopyServerCertificateValidationCallback;
const GUID IID_IBitsPeer                                          = GUIDOF!IBitsPeer;
const GUID IID_IBitsPeerCacheAdministration                       = GUIDOF!IBitsPeerCacheAdministration;
const GUID IID_IBitsPeerCacheRecord                               = GUIDOF!IBitsPeerCacheRecord;
const GUID IID_IBitsTokenOptions                                  = GUIDOF!IBitsTokenOptions;
const GUID IID_IEnumBackgroundCopyFiles                           = GUIDOF!IEnumBackgroundCopyFiles;
const GUID IID_IEnumBackgroundCopyGroups                          = GUIDOF!IEnumBackgroundCopyGroups;
const GUID IID_IEnumBackgroundCopyJobs                            = GUIDOF!IEnumBackgroundCopyJobs;
const GUID IID_IEnumBackgroundCopyJobs1                           = GUIDOF!IEnumBackgroundCopyJobs1;
const GUID IID_IEnumBitsPeerCacheRecords                          = GUIDOF!IEnumBitsPeerCacheRecords;
const GUID IID_IEnumBitsPeers                                     = GUIDOF!IEnumBitsPeers;
