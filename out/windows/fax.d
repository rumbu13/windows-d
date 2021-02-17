// Written in the D programming language.

module windows.fax;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE;
public import windows.gdi : HDC;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND;
public import windows.windowsprogramming : FILETIME, SYSTEMTIME;

extern(Windows):


// Enums


alias FAX_ENUM_LOG_LEVELS = int;
enum : int
{
    FAXLOG_LEVEL_NONE = 0x00000000,
    FAXLOG_LEVEL_MIN  = 0x00000001,
    FAXLOG_LEVEL_MED  = 0x00000002,
    FAXLOG_LEVEL_MAX  = 0x00000003,
}

alias FAX_ENUM_LOG_CATEGORIES = int;
enum : int
{
    FAXLOG_CATEGORY_INIT     = 0x00000001,
    FAXLOG_CATEGORY_OUTBOUND = 0x00000002,
    FAXLOG_CATEGORY_INBOUND  = 0x00000003,
    FAXLOG_CATEGORY_UNKNOWN  = 0x00000004,
}

alias FAX_ENUM_JOB_COMMANDS = int;
enum : int
{
    JC_UNKNOWN = 0x00000000,
    JC_DELETE  = 0x00000001,
    JC_PAUSE   = 0x00000002,
    JC_RESUME  = 0x00000003,
}

alias FAX_ENUM_JOB_SEND_ATTRIBUTES = int;
enum : int
{
    JSA_NOW             = 0x00000000,
    JSA_SPECIFIC_TIME   = 0x00000001,
    JSA_DISCOUNT_PERIOD = 0x00000002,
}

alias FAX_ENUM_DELIVERY_REPORT_TYPES = int;
enum : int
{
    DRT_NONE  = 0x00000000,
    DRT_EMAIL = 0x00000001,
    DRT_INBOX = 0x00000002,
}

alias FAX_ENUM_PORT_OPEN_TYPE = int;
enum : int
{
    PORT_OPEN_QUERY  = 0x00000001,
    PORT_OPEN_MODIFY = 0x00000002,
}

///The <b>FAX_JOB_STATUS_ENUM</b> enumeration defines the status values for a fax job. <div class="alert"><b>Note</b>
///The members <b><b>fjsPAUSED</b></b> and <b><b>fjsNOLINE</b></b> are modifiers; they can be used in combination with
///any other member of this enumeration. Other members cannot be used as modifiers.</div><div> </div>
alias FAX_JOB_STATUS_ENUM = int;
enum : int
{
    ///The fax job is in the queue and pending service.
    fjsPENDING          = 0x00000001,
    ///The fax job is in progress.
    fjsINPROGRESS       = 0x00000002,
    ///The fax job failed.
    fjsFAILED           = 0x00000008,
    ///The fax server paused the fax job. This value can arrive in a bitwise combination with another value.
    fjsPAUSED           = 0x00000010,
    ///There is no line available to send the fax. The fax server will send the transmission when a line is available.
    ///This value can arrive in a bitwise combination with another value.
    fjsNOLINE           = 0x00000020,
    ///The fax job failed. The fax server will attempt to retransmit the fax after a specified interval.
    fjsRETRYING         = 0x00000040,
    ///The fax server exceeded the maximum number of retransmission attempts allowed. The fax will not be sent.
    fjsRETRIES_EXCEEDED = 0x00000080,
    ///The fax job is completed.
    fjsCOMPLETED        = 0x00000100,
    ///The fax job was canceled.
    fjsCANCELED         = 0x00000200,
    ///The fax job is being canceled.
    fjsCANCELING        = 0x00000400,
    ///The fax job is being routed.
    fjsROUTING          = 0x00000800,
}

///The <b>FAX_JOB_EXTENDED_STATUS_ENUM</b> enumeration defines the extended status values for a fax job. These are basic
///values provided for developers of a fax service provider (FSP). However, with the exception of
///<b><b>fjesPARTIALLY_RECEIVED</b></b>, these values or other proprietary values that may be developed for a specific
///FSP, are not recognized or interpreted by the fax server.
alias FAX_JOB_EXTENDED_STATUS_ENUM = int;
enum : int
{
    ///No extended status value.
    fjesNONE               = 0x00000000,
    ///The sender or the caller disconnected the fax call.
    fjesDISCONNECTED       = 0x00000001,
    ///The device is initializing a call.
    fjesINITIALIZING       = 0x00000002,
    ///The device is dialing a fax number.
    fjesDIALING            = 0x00000003,
    ///The device is sending a fax.
    fjesTRANSMITTING       = 0x00000004,
    ///The device answered a new call.
    fjesANSWERED           = 0x00000005,
    ///The device is receiving a fax.
    fjesRECEIVING          = 0x00000006,
    ///The device is not available because it is in use by another application.
    fjesLINE_UNAVAILABLE   = 0x00000007,
    ///The device encountered a busy signal.
    fjesBUSY               = 0x00000008,
    ///The receiving device did not answer the call.
    fjesNO_ANSWER          = 0x00000009,
    ///The device dialed an invalid fax number.
    fjesBAD_ADDRESS        = 0x0000000a,
    ///The sending device cannot complete the call because it does not detect a dial tone.
    fjesNO_DIAL_TONE       = 0x0000000b,
    ///The device has encountered a fatal protocol error.
    fjesFATAL_ERROR        = 0x0000000c,
    ///The device delayed a fax call because the sending device received a busy signal multiple times. The device cannot
    ///retry the call because dialing restrictions exist. (Some countries/regions restrict the number of retry attempts
    ///when a number is busy.)
    fjesCALL_DELAYED       = 0x0000000d,
    ///The device could not complete a call because the telephone number was blocked or reserved; emergency numbers such
    ///as 911 are blocked.
    fjesCALL_BLACKLISTED   = 0x0000000e,
    ///The device received a call that was a data call or a voice call.
    fjesNOT_FAX_CALL       = 0x0000000f,
    ///The incoming fax was partially received. Some (but not all) of the pages are available.
    fjesPARTIALLY_RECEIVED = 0x00000010,
    ///The fax service processed the outbound fax; the fax service provider will transmit the fax.
    fjesHANDLED            = 0x00000011,
    ///The call was completed.
    fjesCALL_COMPLETED     = 0x00000012,
    ///The call was aborted.
    fjesCALL_ABORTED       = 0x00000013,
    ///Obsolete. For information about proprietary extended status codes, see IFaxOutgoingJob::get_ExtendedStatusCode.
    fjesPROPRIETARY        = 0x01000000,
}

///The <b>FAX_JOB_OPERATIONS_ENUM</b> enumeration defines the operations that can be performed on a fax job. The members
///of this enumeration are bit values and can be used in combination.
alias FAX_JOB_OPERATIONS_ENUM = int;
enum : int
{
    ///The job's TIFF image can be retrieved.
    fjoVIEW           = 0x00000001,
    ///The job can be paused.
    fjoPAUSE          = 0x00000002,
    ///The job can be resumed.
    fjoRESUME         = 0x00000004,
    ///The job can be restarted.
    fjoRESTART        = 0x00000008,
    ///The job can be deleted.
    fjoDELETE         = 0x00000010,
    ///The job's recipient information can be retrieved.
    fjoRECIPIENT_INFO = 0x00000020,
    ///The job's sender information can be retrieved.
    fjoSENDER_INFO    = 0x00000040,
}

///The <b>FAX_JOB_TYPE_ENUM</b> enumeration defines the fax job type.
alias FAX_JOB_TYPE_ENUM = int;
enum : int
{
    ///The job is an outbound job.
    fjtSEND    = 0x00000000,
    ///The job is an incoming job (being received through a modem).
    fjtRECEIVE = 0x00000001,
    ///The incoming job has been received, and is now in routing mode (modem is not used).
    fjtROUTING = 0x00000002,
}

///The <b>FAX_SERVER_EVENTS_TYPE_ENUM</b> enumeration defines the types of events the fax service sends to client
///applications that are listening for events. The members of this enumeration are bit values and can be used in
///combination.
alias FAX_SERVER_EVENTS_TYPE_ENUM = int;
enum : int
{
    ///No events are sent.
    fsetNONE          = 0x00000000,
    ///The client requests notifications about fax jobs in the incoming queue. When the status of an incoming fax job
    ///changes, the fax service issues a notification of this type.
    fsetIN_QUEUE      = 0x00000001,
    ///The client requests notification about fax jobs in the outgoing queue. When the status of an outgoing fax job
    ///changes, the fax service issues a notification of this type.
    fsetOUT_QUEUE     = 0x00000002,
    ///The client requests notifications about changes to the fax server configuration. When the configuration data
    ///changes, the fax service issues a notification of this type.
    fsetCONFIG        = 0x00000004,
    ///The client requests notifications about the fax server activity. When the activity status of the fax server
    ///changes, the fax service issues a notification of this type.
    fsetACTIVITY      = 0x00000008,
    ///The client requests notifications about changes in the status of the fax job queue. When the status of the queue
    ///changes, the fax service issues a notification.
    fsetQUEUE_STATE   = 0x00000010,
    ///The client requests notifications about the addition or removal of fax messages from the incoming archive. When a
    ///message is removed from the archive, the fax service issues a notification. The notification includes the archive
    ///type (inbound) and the unique ID of the fax message.
    fsetIN_ARCHIVE    = 0x00000020,
    ///The client requests notifications about the addition or removal of fax messages from the outgoing archive. When a
    ///message is removed from the archive, the fax service issues a notification. The notification includes the archive
    ///type (outbound) and the unique ID of the fax message.
    fsetOUT_ARCHIVE   = 0x00000040,
    ///The client requests notifications when the fax service stops executing.
    fsetFXSSVC_ENDED  = 0x00000080,
    ///The client requests notifications when a device status changes.
    fsetDEVICE_STATUS = 0x00000100,
    ///The client requests notifications when there is an incoming call.
    fsetINCOMING_CALL = 0x00000200,
}

///The <b>FAX_SERVER_APIVERSION_ENUM </b> enumeration defines the version of the fax API. No value below is supported on
///any version of the fax service earlier than the one it designates.
alias FAX_SERVER_APIVERSION_ENUM = int;
enum : int
{
    ///API Version 0, the fax service API used by the BackOffice Small Business Server 2000 (SBS) and BackOffice Server
    ///2000 (BOS). Not supported.
    fsAPI_VERSION_0 = 0x00000000,
    ///API Version 1, the fax service API used by the Windows XP fax service server.
    fsAPI_VERSION_1 = 0x00010000,
    ///API Version 2, the fax service API used by the Windows Server 2003 fax service server.
    fsAPI_VERSION_2 = 0x00020000,
    fsAPI_VERSION_3 = 0x00030000,
}

///The <b>FAX_SMTP_AUTHENTICATION_TYPE_ENUM</b> enumeration defines the configuration options for delivery receipts sent
///through email.
alias FAX_SMTP_AUTHENTICATION_TYPE_ENUM = int;
enum : int
{
    ///The server sends fax transmission receipts using a nonauthenticated SMTP protocol.
    fsatANONYMOUS = 0x00000000,
    ///The server sends fax transmission receipts using a basic (plain text) authenticated SMTP protocol.
    fsatBASIC     = 0x00000001,
    ///The server sends fax transmission receipts using an NTLM-authenticated SMTP protocol.
    fsatNTLM      = 0x00000002,
}

///The <b>FAX_RECEIPT_TYPE_ENUM</b> enumeration defines the types of delivery reports (delivery receipt formats) for
///outbound faxes. The members of this enumeration are bit values and can be used in combination.
alias FAX_RECEIPT_TYPE_ENUM = int;
enum : int
{
    ///Do not send a delivery report.
    frtNONE   = 0x00000000,
    ///Send a delivery report through SMTP mail.
    frtMAIL   = 0x00000001,
    ///Display a delivery report in a message box on the display of a specific computer. This is not supported in
    ///Windows Vista.
    frtMSGBOX = 0x00000004,
}

///The <b>FAX_ACCESS_RIGHTS_ENUM</b> enumeration defines access rights to the fax server.
alias FAX_ACCESS_RIGHTS_ENUM = int;
enum : int
{
    ///The user can submit low-priority fax jobs. Users can view and manage their jobs in the fax server's queue and
    ///their messages in the outgoing fax archive.
    farSUBMIT_LOW         = 0x00000001,
    ///The user can submit normal-priority and low-priority fax jobs. Users can view and manage their jobs in the fax
    ///server queue and their messages in the outgoing fax archive.
    farSUBMIT_NORMAL      = 0x00000002,
    ///The user can submit low-priority, normal-priority, and high-priority fax jobs. Users can view and manage their
    ///jobs in the fax server queue and their messages in the outgoing fax archive.
    farSUBMIT_HIGH        = 0x00000004,
    ///The user can view all incoming and outgoing jobs in the fax server queue.
    farQUERY_JOBS         = 0x00000008,
    ///The user can manage all incoming and outgoing jobs in the fax server queue.
    farMANAGE_JOBS        = 0x00000010,
    ///The user can view the fax server configuration data.
    farQUERY_CONFIG       = 0x00000020,
    ///The user can set the fax server configuration data.
    farMANAGE_CONFIG      = 0x00000040,
    ///The user can view all fax messages in the incoming archive.
    farQUERY_IN_ARCHIVE   = 0x00000080,
    ///The user can manage all fax messages in the incoming archive.
    farMANAGE_IN_ARCHIVE  = 0x00000100,
    ///The user can view all fax messages in the outgoing archive.
    farQUERY_OUT_ARCHIVE  = 0x00000200,
    ///The user can manage all fax messages in the outgoing archive.
    farMANAGE_OUT_ARCHIVE = 0x00000400,
}

///The <b>FAX_PRIORITY_TYPE_ENUM</b> enumeration defines the types of priorities for outbound faxes.
alias FAX_PRIORITY_TYPE_ENUM = int;
enum : int
{
    ///The fax will be sent with a low priority. All faxes that have a normal or a high priority will be sent before a
    ///fax that has a low priority.
    fptLOW    = 0x00000000,
    ///The fax will be sent with a normal priority. All faxes that have a high priority will be sent before a fax that
    ///has a normal priority.
    fptNORMAL = 0x00000001,
    ///The fax will be sent with a high priority.
    fptHIGH   = 0x00000002,
}

///The <b>FAX_COVERPAGE_TYPE_ENUM</b> enumeration defines whether a cover page template file is a local computer cover
///page or a server-based cover page. It can also specify that no file is used.
alias FAX_COVERPAGE_TYPE_ENUM = int;
enum : int
{
    ///No cover page.
    fcptNONE   = 0x00000000,
    ///Use a cover page from local computer.
    fcptLOCAL  = 0x00000001,
    ///Use a cover page from the fax server common coverpages folder.
    fcptSERVER = 0x00000002,
}

///The <b>FAX_SCHEDULE_TYPE_ENUM</b> enumeration defines the types of scheduling for outbound faxes.
alias FAX_SCHEDULE_TYPE_ENUM = int;
enum : int
{
    ///Send the fax as soon as a device is available.
    fstNOW             = 0x00000000,
    ///Send the fax no sooner than the specified time. The actual time that the fax will be sent depends on device
    ///availability and fax priority.
    fstSPECIFIC_TIME   = 0x00000001,
    ///Send the fax during the discount rate period.
    fstDISCOUNT_PERIOD = 0x00000002,
}

///The <b>FAX_PROVIDER_STATUS_ENUM</b> enumeration defines the status values for a fax extension (a fax service provider
///(FSP) or a fax inbound routing extension).
alias FAX_PROVIDER_STATUS_ENUM = int;
enum : int
{
    ///The extension loaded, linked, and initialized successfully.
    fpsSUCCESS      = 0x00000000,
    ///A server-related error occurred while the fax service was trying to load, link, and initialize the extension; for
    ///example, there may have been insufficient memory resources. Call the IFaxDeviceProvider::get_InitErrorCode method
    ///or the IFaxInboundRoutingExtension::get_InitErrorCode method to return the last error code.
    fpsSERVER_ERROR = 0x00000001,
    ///An error occurred while the fax service was parsing the extension's installation data; the extension's GUID is
    ///invalid. Refer to the <b>InitErrorCode</b> property to get the error code.
    fpsBAD_GUID     = 0x00000002,
    ///An error occurred while the fax service was parsing the extension's installation data; the extension reports an
    ///invalid version of the FSP or routing extension API; the routing extension is the non-default MS routing
    ///extension for a desktop computer installation. Call the IFaxDeviceProvider::get_InitErrorCode method or the
    ///IFaxInboundRoutingExtension::get_InitErrorCode method to return the last error code.
    fpsBAD_VERSION  = 0x00000003,
    ///An error occurred while the fax service was loading the FSP or routing extension's DLL. Call the
    ///IFaxDeviceProvider::get_InitErrorCode method or the IFaxInboundRoutingExtension::get_InitErrorCode method to
    ///return the last error code.
    fpsCANT_LOAD    = 0x00000004,
    ///An error occurred when the fax service attempted to dynamically link to one of the functions that the FSP or
    ///routing extension's DLL must export. Call the IFaxDeviceProvider::get_InitErrorCode method or the
    ///IFaxInboundRoutingExtension::get_InitErrorCode method to return the last error code.
    fpsCANT_LINK    = 0x00000005,
    ///An error occurred when the fax service called the extension's initialization function. For virtual devices, the
    ///<b>InitErrorCode</b> property is an <b>HRESULT</b> value; otherwise, it is a Win32 error code. Call the
    ///IFaxDeviceProvider::get_InitErrorCode method or the IFaxInboundRoutingExtension::get_InitErrorCode method to
    ///return the last error code.
    fpsCANT_INIT    = 0x00000006,
}

///The <b>FAX_DEVICE_RECEIVE_MODE_ENUM</b> enumeration defines the way a device answers an incoming call.
alias FAX_DEVICE_RECEIVE_MODE_ENUM = int;
enum : int
{
    ///The device will not answer the call.
    fdrmNO_ANSWER     = 0x00000000,
    ///The device will automatically answer the call.
    fdrmAUTO_ANSWER   = 0x00000001,
    ///The device will answer the call only if made to do so manually.
    fdrmMANUAL_ANSWER = 0x00000002,
}

///The <b>FAX_LOG_LEVEL_ENUM</b> enumeration defines the event logging levels for a logging category.
alias FAX_LOG_LEVEL_ENUM = int;
enum : int
{
    ///The fax server does not log events.
    fllNONE = 0x00000000,
    ///The fax server logs only severe failure events, such as errors.
    fllMIN  = 0x00000001,
    ///The fax server logs events of moderate severity, as well as severe failure events. This would include errors and
    ///warnings.
    fllMED  = 0x00000002,
    ///The fax server logs all events.
    fllMAX  = 0x00000003,
}

///The <b>FAX_GROUP_STATUS_ENUM</b> enumeration defines the status types for outbound routing groups.
alias FAX_GROUP_STATUS_ENUM = int;
enum : int
{
    ///All the devices in the routing group are valid and available for sending outgoing faxes.
    fgsALL_DEV_VALID      = 0x00000000,
    ///The routing group does not contain any devices.
    fgsEMPTY              = 0x00000001,
    ///The routing group does not contain any available devices for sending faxes. (Devices can be "unavailable" when
    ///they are offline and when they do not exist.)
    fgsALL_DEV_NOT_VALID  = 0x00000002,
    ///The routing group contains some devices that are unavailable for sending faxes. (Devices can be "unavailable"
    ///when they are offline and when they do not exist.)
    fgsSOME_DEV_NOT_VALID = 0x00000003,
}

///The <b>FAX_RULE_STATUS_ENUM</b> enumeration defines the status types for outbound routing rules.
alias FAX_RULE_STATUS_ENUM = int;
enum : int
{
    ///The routing rule is valid and can be applied to outbound faxes.
    frsVALID                    = 0x00000000,
    ///The routing rule cannot be applied because the rule uses an outbound routing group for its destination and the
    ///group is empty.
    frsEMPTY_GROUP              = 0x00000001,
    ///The routing rule cannot be applied because the rule uses an existing outbound routing group for its destination
    ///and the group does not contain devices that are valid for sending faxes.
    frsALL_GROUP_DEV_NOT_VALID  = 0x00000002,
    ///The routing rule uses an existing outbound routing group for its destination but the group contains devices that
    ///are not valid for sending faxes. This is a warning status. The rule can be applied to the valid devices in the
    ///routing group.
    frsSOME_GROUP_DEV_NOT_VALID = 0x00000003,
    ///The routing rule cannot be applied because the rule uses a single device for its destination and that device is
    ///not valid for sending faxes.
    frsBAD_DEVICE               = 0x00000004,
}

///Specifies the types of event notifications, on a particular account, that the server sends to listening clients.
alias FAX_ACCOUNT_EVENTS_TYPE_ENUM = int;
enum : int
{
    ///No notifications are sent.
    faetNONE         = 0x00000000,
    ///Notifications of changes to the state of any fax in the incoming queue are sent.
    faetIN_QUEUE     = 0x00000001,
    ///Notifications of changes to the state of any fax in the outgoing queue are sent.
    faetOUT_QUEUE    = 0x00000002,
    ///A notification is sent whenever a message is removed from the incoming fax archive.
    faetIN_ARCHIVE   = 0x00000004,
    ///A notification is sent whenever a message is removed from the outgoing fax archive.
    faetOUT_ARCHIVE  = 0x00000008,
    ///A notification is sent whenever the fax service stops executing.
    faetFXSSVC_ENDED = 0x00000010,
}

///Defines access rights on the fax server.
alias FAX_ACCESS_RIGHTS_ENUM_2 = int;
enum : int
{
    ///The user can submit low-priority fax jobs. Users can view and manage their jobs in the fax server's queue and
    ///their messages in the outgoing fax archive.
    far2SUBMIT_LOW            = 0x00000001,
    ///The user can submit normal-priority and low-priority fax jobs. Users can view and manage their jobs in the fax
    ///server queue and their messages in the outgoing fax archive.
    far2SUBMIT_NORMAL         = 0x00000002,
    ///The user can submit low-priority, normal-priority, and high-priority fax jobs. Users can view and manage their
    ///jobs in the fax server queue and their messages in the outgoing fax archive.
    far2SUBMIT_HIGH           = 0x00000004,
    ///The user can query outgoing jobs belonging to all accounts, including other user's accounts.
    far2QUERY_OUT_JOBS        = 0x00000008,
    ///The user can manage outgoing jobs belonging to all accounts, including other user's accounts.
    far2MANAGE_OUT_JOBS       = 0x00000010,
    ///The user can view and query the fax server's configuration data.
    far2QUERY_CONFIG          = 0x00000020,
    ///The user can view and set the fax server's configuration data.
    far2MANAGE_CONFIG         = 0x00000040,
    ///The user can query archived messages belonging to all accounts, including other user's accounts.
    far2QUERY_ARCHIVES        = 0x00000080,
    ///The user can manage archived messages belonging to all accounts, including other user's accounts.
    far2MANAGE_ARCHIVES       = 0x00000100,
    ///The user can manage all the messages in the server's receive folder. This includes the right to reassign and
    ///delete messages.
    far2MANAGE_RECEIVE_FOLDER = 0x00000200,
}

///The <b>FAX_ROUTING_RULE_CODE_ENUM</b> enumeration defines the rules for outbound routing.
alias FAX_ROUTING_RULE_CODE_ENUM = int;
enum : int
{
    frrcANY_CODE = 0x00000000,
}

alias FAXROUTE_ENABLE = int;
enum : int
{
    QUERY_STATUS   = 0xffffffff,
    STATUS_DISABLE = 0x00000000,
    STATUS_ENABLE  = 0x00000001,
}

alias FAX_ENUM_DEVICE_ID_SOURCE = int;
enum : int
{
    DEV_ID_SRC_FAX  = 0x00000000,
    DEV_ID_SRC_TAPI = 0x00000001,
}

///Defines the way a file will be faxed from within an application. With Windows Vista there is only one possible value.
enum SendToMode : int
{
    ///The file is faxed as it is. The user cannot add typed material preceding it or following it.
    SEND_TO_FAX_RECIPIENT_ATTACHMENT = 0x00000000,
}

// Constants


enum int lDEFAULT_PREFETCH_SIZE = 0x00000064;

// Callbacks

alias PFAXCONNECTFAXSERVERA = BOOL function(const(char)* MachineName, ptrdiff_t* FaxHandle);
alias PFAXCONNECTFAXSERVERW = BOOL function(const(wchar)* MachineName, ptrdiff_t* FaxHandle);
///The <b>FaxClose</b> function closes the following types of fax handles: <ul> <li>A fax server handle returned by a
///call to the FaxConnectFaxServer function</li> <li>A fax port handle returned by a call to the FaxOpenPort
///function</li> </ul>
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies the fax handle to close. This value can be a fax server handle returned by a call
///                to the FaxConnectFaxServer function, or a fax port handle returned by a call to the FaxOpenPort function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td
///    width="60%"> The <i>FaxHandle</i> parameter is invalid. </td> </tr> </table>
///    
alias PFAXCLOSE = BOOL function(HANDLE FaxHandle);
///The <b>FaxOpenPort</b> function returns a fax port handle to a fax client application. The port handle is required
///when the application calls other fax client functions that facilitate device management and fax document routing.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    DeviceId = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is the permanent line identifier for the receiving
///               device. Call the FaxEnumPorts function to retrieve a valid value for this parameter. For more information, see
///               the following Remarks section.
///    Flags = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains a set of bit flags that defines the access
///            level for the port. This parameter can be one or more of the following values.
///    FaxPortHandle = Type: <b>LPHANDLE</b> Pointer to a variable that receives a fax port handle that is required on subsequent calls
///                    to other fax client functions. If the fax server returns a <b>NULL</b> handle, it indicates an error.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td> <td width="60%"> The port has already been opened with
///    PORT_OPEN_MODIFY access. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_BAD_UNIT</b></dt> </dl> </td> <td
///    width="60%"> The <i>DeviceId</i> parameter is invalid. </td> </tr> </table>
///    
alias PFAXOPENPORT = BOOL function(HANDLE FaxHandle, uint DeviceId, uint Flags, ptrdiff_t* FaxPortHandle);
alias PFAXCOMPLETEJOBPARAMSA = BOOL function(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);
alias PFAXCOMPLETEJOBPARAMSW = BOOL function(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);
alias PFAXSENDDOCUMENTA = BOOL function(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, 
                                        const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);
alias PFAXSENDDOCUMENTW = BOOL function(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, 
                                        const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);
///The <b>FAX_RECIPIENT_CALLBACK</b> function is an application-defined or library-defined callback function that the
///FaxSendDocumentForBroadcast function calls to retrieve user-specific information for the transmission.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RecipientNumber = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times the
///                      FaxSendDocumentForBroadcast function has called the <b>FAX_RECIPIENT_CALLBACK</b> function. Each function call
///                      corresponds to one designated fax recipient, and the index is relative to 1.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. FaxSendDocumentForBroadcast passes this data to the <b>FAX_RECIPIENT_CALLBACK</b>
///              function.
///    JobParams = Type: <b>PFAX_JOB_PARAM</b> Pointer to a FAX_JOB_PARAM structure that contains the information necessary for the
///                fax server to send the fax transmission to the designated recipient. The structure includes, among other items,
///                the recipient's fax number, sender and recipient data, an optional billing code, and job scheduling information.
///                The fax server queues the fax transmission according to the details specified by the <b>FAX_JOB_PARAM</b>
///                structure.
///    CoverpageInfo = Type: <b>PFAX_COVERPAGE_INFO</b> Pointer to a FAX_COVERPAGE_INFO structure that contains cover page data to
///                    display on the cover page of the fax document for the designated recipient. This parameter must be <b>NULL</b> if
///                    a cover page is not required.
///Returns:
///    Type: <b>BOOL</b> The function returns a value of nonzero to indicate that the FaxSendDocumentForBroadcast
///    function should queue an outbound fax transmission, using the data pointed to by the <i>JobParams</i> and
///    <i>CoverpageInfo</i> parameters. The function returns a value of zero to indicate that there are no more fax
///    transmission jobs to queue, and calls to <b>FAX_RECIPIENT_CALLBACK</b> should be terminated. To get extended
///    error information, call GetLastError.
///    
alias PFAX_RECIPIENT_CALLBACKA = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMA* JobParams, FAX_COVERPAGE_INFOA* CoverpageInfo);
///The <b>FAX_RECIPIENT_CALLBACK</b> function is an application-defined or library-defined callback function that the
///FaxSendDocumentForBroadcast function calls to retrieve user-specific information for the transmission.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RecipientNumber = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times the
///                      FaxSendDocumentForBroadcast function has called the <b>FAX_RECIPIENT_CALLBACK</b> function. Each function call
///                      corresponds to one designated fax recipient, and the index is relative to 1.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. FaxSendDocumentForBroadcast passes this data to the <b>FAX_RECIPIENT_CALLBACK</b>
///              function.
///    JobParams = Type: <b>PFAX_JOB_PARAM</b> Pointer to a FAX_JOB_PARAM structure that contains the information necessary for the
///                fax server to send the fax transmission to the designated recipient. The structure includes, among other items,
///                the recipient's fax number, sender and recipient data, an optional billing code, and job scheduling information.
///                The fax server queues the fax transmission according to the details specified by the <b>FAX_JOB_PARAM</b>
///                structure.
///    CoverpageInfo = Type: <b>PFAX_COVERPAGE_INFO</b> Pointer to a FAX_COVERPAGE_INFO structure that contains cover page data to
///                    display on the cover page of the fax document for the designated recipient. This parameter must be <b>NULL</b> if
///                    a cover page is not required.
///Returns:
///    Type: <b>BOOL</b> The function returns a value of nonzero to indicate that the FaxSendDocumentForBroadcast
///    function should queue an outbound fax transmission, using the data pointed to by the <i>JobParams</i> and
///    <i>CoverpageInfo</i> parameters. The function returns a value of zero to indicate that there are no more fax
///    transmission jobs to queue, and calls to <b>FAX_RECIPIENT_CALLBACK</b> should be terminated. To get extended
///    error information, call GetLastError.
///    
alias PFAX_RECIPIENT_CALLBACKW = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMW* JobParams, FAX_COVERPAGE_INFOW* CoverpageInfo);
alias PFAXSENDDOCUMENTFORBROADCASTA = BOOL function(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);
alias PFAXSENDDOCUMENTFORBROADCASTW = BOOL function(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);
alias PFAXENUMJOBSA = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);
alias PFAXENUMJOBSW = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);
alias PFAXGETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);
alias PFAXGETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);
alias PFAXSETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);
alias PFAXSETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);
///The <b>FaxGetPageData</b> function returns to a fax client application the first page of data for a fax job. The fax
///job must be an outbound job, but it can be queued or active. The function returns data in the Tagged Image File
///Format Class F (TIFF Class F) format.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job associated with the page of data.
///    Buffer = Type: <b>LPBYTE*</b> Pointer to the address of a buffer to receive the first page of data in the fax document.
///             For information about memory allocation, see the following Remarks section.
///    BufferSize = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the size of the buffer, in bytes, pointed to
///                 by the <i>Buffer</i> parameter.
///    ImageWidth = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the width, in pixels, of the fax image.
///    ImageHeight = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the height, in pixels, of the fax image.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>Buffer</i>, <i>BufferSize</i>, <i>ImageWidth</i>, <i>ImageHeight</i>, or
///    <i>FaxHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> An
///    invalid-data error occurred. For example, the fax job identified by the <i>JobId</i> parameter is not an outgoing
///    fax transmission; the job must be specified with the JT_SEND job type. </td> </tr> </table>
///    
alias PFAXGETPAGEDATA = BOOL function(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, 
                                      uint* ImageWidth, uint* ImageHeight);
alias PFAXGETDEVICESTATUSA = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);
alias PFAXGETDEVICESTATUSW = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);
///A fax client application calls the <b>FaxAbort</b> function to terminate a fax job.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job to terminate.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. You must own the job, or have
///    FAX_JOB_MANAGE access. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_HANDLE</b></dt> </dl> </td>
///    <td width="60%"> The <i>FaxHandle</i> parameter is invalid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>JobId</i> parameter is invalid. </td>
///    </tr> </table>
///    
alias PFAXABORT = BOOL function(HANDLE FaxHandle, uint JobId);
alias PFAXGETCONFIGURATIONA = BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);
alias PFAXGETCONFIGURATIONW = BOOL function(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);
alias PFAXSETCONFIGURATIONA = BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);
alias PFAXSETCONFIGURATIONW = BOOL function(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);
alias PFAXGETLOGGINGCATEGORIESA = BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, 
                                                uint* NumberCategories);
alias PFAXGETLOGGINGCATEGORIESW = BOOL function(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, 
                                                uint* NumberCategories);
alias PFAXSETLOGGINGCATEGORIESA = BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, 
                                                uint NumberCategories);
alias PFAXSETLOGGINGCATEGORIESW = BOOL function(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, 
                                                uint NumberCategories);
alias PFAXENUMPORTSA = BOOL function(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);
alias PFAXENUMPORTSW = BOOL function(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);
alias PFAXGETPORTA = BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);
alias PFAXGETPORTW = BOOL function(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);
alias PFAXSETPORTA = BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);
alias PFAXSETPORTW = BOOL function(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);
alias PFAXENUMROUTINGMETHODSA = BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, 
                                              uint* MethodsReturned);
alias PFAXENUMROUTINGMETHODSW = BOOL function(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, 
                                              uint* MethodsReturned);
alias PFAXENABLEROUTINGMETHODA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);
alias PFAXENABLEROUTINGMETHODW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);
alias PFAXENUMGLOBALROUTINGINFOA = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXENUMGLOBALROUTINGINFOW = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXSETGLOBALROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);
alias PFAXSETGLOBALROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);
alias PFAXGETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, 
                                          ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXGETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, 
                                          ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(char)* RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
///The <b>FaxInitializeEventQueue</b> function creates a fax event queue for the calling fax client application. The
///queue enables the application to receive notifications of asynchronous events from the fax server.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    CompletionPort = Type: <b>HANDLE</b> Specifies a valid handle to an I/O completion port returned by a call to the
///                     CreateIoCompletionPort function. This parameter is required for notification using I/O completion packets. This
///                     parameter must be <b>NULL</b> if you specify notification messages. For information about I/O completion ports,
///                     see I/O Completion Ports.
///    CompletionKey = Type: <b>ULONG_PTR</b> Specifies a variable that contains a completion key value the fax server includes in each
///                    I/O completion packet. This parameter is required for notification using I/O completion packets. This parameter
///                    must be <b>NULL</b> if you specify notification messages. For more information, see the following Remarks
///                    section.
///    hWnd = Type: <b>HWND</b> Handle to a window of the fax client application to notify when an asynchronous event occurs.
///           This parameter is required for notification messages. This parameter must be <b>NULL</b> if you specify
///           notification using I/O completion packets.
///    MessageStart = Type: <b>UINT</b> Specifies an unsigned integer that identifies the application's base window message. The
///                   application can use this number to determine whether to process the message as a fax server event. For more
///                   information, see the FAX_EVENT topic. This parameter is required for notification messages. This parameter must
///                   be equal to zero if you specify notification using I/O completion packets.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> Both the <i>hWnd</i> and
///    <i>CompletionPort</i> parameters are <b>NULL</b>, or both parameters are specified. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i>
///    parameter is <b>NULL</b>; or the <i>hWnd</i> parameter is specified but the <i>FaxHandle</i> parameter does not
///    specify a connection with a local fax server; or the <i>MessageStart</i> parameter specifies a message in the
///    range below WM_USER. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td
///    width="60%"> The application called the FaxInitializeEventQueue function more than once during a fax service
///    session in Windows 2000. More than one call is supported in Windows XP and Windows Server 2003. </td> </tr> <tr>
///    <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred
///    during memory allocation. </td> </tr> </table>
///    
alias PFAXINITIALIZEEVENTQUEUE = BOOL function(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, 
                                               HWND hWnd, uint MessageStart);
///The <b>FaxFreeBuffer</b> function releases resources associated with a buffer allocated previously as the result of a
///function call by a fax client application. This includes calls to the FaxCompleteJobParams function and to functions
///that begin with <b>FaxEnum</b> or <b>FaxGet</b>.
///Params:
///    Buffer = Type: <b>LPVOID</b> Pointer to a buffer allocated on a previous call to one of the functions named in the
///             following See Also section.
alias PFAXFREEBUFFER = void function(void* Buffer);
alias PFAXSTARTPRINTJOBA = BOOL function(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOA* FaxContextInfo);
alias PFAXSTARTPRINTJOBW = BOOL function(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOW* FaxContextInfo);
alias PFAXPRINTCOVERPAGEA = BOOL function(const(FAX_CONTEXT_INFOA)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOA)* CoverPageInfo);
alias PFAXPRINTCOVERPAGEW = BOOL function(const(FAX_CONTEXT_INFOW)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOW)* CoverPageInfo);
alias PFAXREGISTERSERVICEPROVIDERW = BOOL function(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, 
                                                   const(wchar)* ImageName, const(wchar)* TspName);
alias PFAXUNREGISTERSERVICEPROVIDERW = BOOL function(const(wchar)* DeviceProvider);
///The <i>FaxRoutingInstallationCallback</i> function is a library-defined callback function that the
///FaxRegisterRoutingExtension function calls to install a fax routing extension DLL. <b>FaxRegisterRoutingExtension</b>
///calls the <i>FaxRoutingInstallationCallback</i> function multiple times, once for each fax routing method the fax
///routing extension exports.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. The FaxRegisterRoutingExtension function passes this data to the
///              <i>FaxRoutingInstallationCallback</i> function.
///    MethodName = Type: <b>LPWSTR</b> Pointer to a variable to receive a null-terminated Unicode character string that specifies
///                 the internal name of the fax routing method. The string must not exceed 100 characters. For information about fax
///                 routing methods, see About the Fax Routing Extension API.
///    FriendlyName = Type: <b>LPWSTR</b> Pointer to a variable to receive a null-terminated Unicode character string that specifies
///                   the user-friendly name to display for the fax routing method. The string must not exceed 100 characters.
///    FunctionName = Type: <b>LPWSTR</b> Pointer to a variable to receive a null-terminated Unicode character string. The string
///                   contains the name of the exported function that executes the specified fax routing procedure. The string must not
///                   exceed 100 characters.
///    Guid = Type: <b>LPWSTR</b> Pointer to a variable to receive a null-terminated Unicode character string. The string
///           specifies the GUID that uniquely identifies the fax routing method of interest.
///Returns:
///    Type: <b>BOOL</b> The <i>FaxRoutingInstallationCallback</i> function returns a value of nonzero to indicate that
///    the FaxRegisterRoutingExtension function should register the fax routing method for the fax routing extension,
///    using the data pointed to by the parameters. The function returns a value of zero to indicate that there are no
///    more fax routing methods to register, and calls to <i>FaxRoutingInstallationCallback</i> should be terminated.
///    
alias PFAX_ROUTING_INSTALLATION_CALLBACKW = BOOL function(HANDLE FaxHandle, void* Context, 
                                                          const(wchar)* MethodName, const(wchar)* FriendlyName, 
                                                          const(wchar)* FunctionName, const(wchar)* Guid);
alias PFAXREGISTERROUTINGEXTENSIONW = BOOL function(HANDLE FaxHandle, const(wchar)* ExtensionName, 
                                                    const(wchar)* FriendlyName, const(wchar)* ImageName, 
                                                    PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, void* Context);
///A fax client application calls the <b>FaxAccessCheck</b> function to query the fax access privileges of a user.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    AccessMask = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains a set of bit flags defining a user's fax
///                 access permissions. This parameter can be one or more of the following generic access permissions: FAX_READ,
///                 FAX_WRITE, and FAX_ALL_ACCESS. It can also be one or more of the following specific access permissions: <ul>
///                 <li>FAX_JOB_SUBMIT</li> <li>FAX_JOB_QUERY</li> <li>FAX_CONFIG_QUERY</li> <li>FAX_CONFIG_SET</li>
///                 <li>FAX_PORT_QUERY</li> <li>FAX_PORT_SET</li> <li>FAX_JOB_MANAGE</li> </ul> For a detailed description of these
///                 values, see Generic Fax Access Rights and Specific Fax Access Rights.
///Returns:
///    Type: <b>BOOL</b> If the user has the required permission, the return value is nonzero. If the user does not have
///    the required permission, the return value is zero, and GetLastError returns ERROR_SUCCESS. If the function fails,
///    the return value is also zero, but GetLastError returns an error code other than ERROR_SUCCESS.
///    
alias PFAXACCESSCHECK = BOOL function(HANDLE FaxHandle, uint AccessMask);
alias PFAX_SERVICE_CALLBACK = BOOL function(HANDLE FaxHandle, uint DeviceId, size_t Param1, size_t Param2, 
                                            size_t Param3);
///The <i>FaxLineCallback</i> function is an application-defined or library-defined callback function that the fax
///service calls to deliver Telephony Application Programming Interface (TAPI) events to the fax service provider (FSP).
///The <b>PFAX_LINECALLBACK</b> data type is a pointer to a <i>FaxLineCallback</i> function. <i>FaxLineCallback</i> is a
///placeholder for an application-defined or library-defined function name.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax handle returned by the FaxDevStartJob function.
///    hDevice = Type: <b>DWORD</b> Specifies a handle to either a line device or a call device. To determine whether this handle
///              is a line handle or a call handle, use the context that the <i>dwMessage</i> parameter provides.
///    dwMessage = Type: <b>DWORD</b> Specifies a line device or a call device message.
///    dwInstance = Type: <b>DWORD_PTR</b> Reserved; should not be used by the FSP.
///    dwParam1 = Type: <b>DWORD_PTR</b> Specifies a parameter for the message. For information about parameter values passed in
///               this structure, see Line Device Messages in the TAPI documentation.
///    dwParam2 = Type: <b>DWORD_PTR</b> Specifies a parameter for the message.
///    dwParam3 = Type: <b>DWORD_PTR</b> Specifies a parameter for the message.
alias PFAX_LINECALLBACK = void function(HANDLE FaxHandle, uint hDevice, uint dwMessage, size_t dwInstance, 
                                        size_t dwParam1, size_t dwParam2, size_t dwParam3);
///The <i>FaxSendCallback</i> function is an application-defined or library-defined callback function that a fax service
///provider (FSP) calls to notify the fax service that an outgoing fax call is in progress. The
///<b>PFAX_SEND_CALLBACK</b> data type is a pointer to a <i>FaxSendCallback</i> function. <i>FaxSendCallback</i> is a
///placeholder for an application-defined or library-defined function name.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax handle returned by the FaxDevStartJob function.
///    CallHandle = Type: <b>HCALL</b> Specifies a call handle returned by the TAPI 2.x LINE_CALLSTATE message.
///    Reserved1 = Type: <b>DWORD</b> This parameter is reserved for future use by Microsoft. It must be set to zero.
///    Reserved2 = Type: <b>DWORD</b> This parameter is reserved for future use by Microsoft. It must be set to zero.
///Returns:
///    Type: <b>BOOL</b> The fax service returns a value of <b>TRUE</b> to indicate that the active fax operation should
///    continue. The fax service returns a value of <b>FALSE</b> to indicate that the active fax operation should be
///    terminated. To get extended error information, call GetLastError.
///    
alias PFAX_SEND_CALLBACK = BOOL function(HANDLE FaxHandle, uint CallHandle, uint Reserved1, uint Reserved2);
alias PFAXDEVINITIALIZE = BOOL function(uint param0, HANDLE param1, PFAX_LINECALLBACK* param2, 
                                        PFAX_SERVICE_CALLBACK param3);
alias PFAXDEVVIRTUALDEVICECREATION = BOOL function(uint* DeviceCount, const(wchar)* DeviceNamePrefix, 
                                                   uint* DeviceIdPrefix, HANDLE CompletionPort, size_t CompletionKey);
alias PFAXDEVSTARTJOB = BOOL function(uint param0, uint param1, ptrdiff_t* param2, HANDLE param3, size_t param4);
alias PFAXDEVENDJOB = BOOL function(HANDLE param0);
alias PFAXDEVSEND = BOOL function(HANDLE param0, FAX_SEND* param1, PFAX_SEND_CALLBACK param2);
alias PFAXDEVRECEIVE = BOOL function(HANDLE param0, uint param1, FAX_RECEIVE* param2);
alias PFAXDEVREPORTSTATUS = BOOL function(HANDLE param0, FAX_DEV_STATUS* param1, uint param2, uint* param3);
alias PFAXDEVABORTOPERATION = BOOL function(HANDLE param0);
alias PFAXDEVCONFIGURE = BOOL function(HPROPSHEETPAGE* param0);
alias PFAXDEVSHUTDOWN = HRESULT function();
///A fax routing method calls the <i>FaxRouteAddFile</i> callback function to add a file to the fax file list associated
///with a received fax document.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    FileName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string. The string contains the
///               fully qualified path and name of the file to add to the fax file list associated with the received fax document.
///    Guid = Type: <b>GUID*</b> Pointer to a null-terminated Unicode character string that contains the GUID for the fax
///           routing method that is adding the file.
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the file number of the file added to the fax file
///    list associated with the received fax. If the function fails, the return value is 1. To get extended error
///    information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEADDFILE = int function(uint JobId, const(wchar)* FileName, GUID* Guid);
///A fax routing method calls the <i>FaxRouteDeleteFile</i> callback function to delete a file from the fax file list
///associated with a received fax document.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    FileName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string. The string contains the
///               fully qualified path and name of the file to delete from the fax file list associated with the received fax
///               document.
///Returns:
///    Type: <b>LONG</b> If the function succeeds, the return value is the file number of the file deleted from the fax
///    file list associated with the received fax. If the function fails, the return value is 1. To get extended error
///    information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEDELETEFILE = int function(uint JobId, const(wchar)* FileName);
///A fax routing method calls the <b>FaxRouteGetFile</b> callback function to retrieve the name of a specific file from
///the fax file list associated with a received fax document.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    Index = Type: <b>DWORD</b> Specifies a unique number that identifies the requested file.
///    FileNameBuffer = Type: <b>LPWSTR</b> Pointer to a buffer that receives a null-terminated Unicode character string that contains
///                     the requested file name. For more information, see the following Remarks section.
///    RequiredSize = Type: <b>LPDWORD</b> Pointer to an unsigned <b>DWORD</b> variable. If the <i>FileNameBuffer</i> parameter is
///                   <b>NULL</b>, receives the required size, in bytes, of the buffer pointed to by the <i>FileNameBuffer</i>
///                   parameter. If <i>FileNameBuffer</i> parameter is not <b>NULL</b>, this variable indicates the output buffer size.
///                   For more information, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEGETFILE = BOOL function(uint JobId, uint Index, const(wchar)* FileNameBuffer, uint* RequiredSize);
///The <i>FaxRouteEnumFile</i> callback function receives the file names in the fax file list associated with a received
///fax document. This function receives a file name in the fax file list associated with a received fax document, and
///executes a procedure defined by the routing extension. It can return a nonzero value to proceed to the next file name
///in the fax file list, or zero to stop FaxRouteEnumFiles. <i>FaxRouteEnumFile</i> is a placeholder for a function name
///defined by the fax routing extension DLL. The <b>PFAXROUTEENUMFILE</b> data type is a pointer to a
///<i>FaxRouteEnumFile</i> function.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    GuidOwner = Type: <b>GUID*</b> Pointer to the GUID associated with the fax routing method that added the file to the fax file
///                list. (This file is specified by the <i>FileName</i> parameter.)
///    GuidCaller = Type: <b>GUID*</b> Pointer to the GUID associated with the fax routing method that called the FaxRouteEnumFiles
///                 function. (<i>FaxRouteEnumFiles</i> passes a pointer to the <i>FaxRouteEnumFile</i> function.) Note that this
///                 parameter has the same value as the <i>Guid</i> parameter of <i>FaxRouteEnumFiles</i>. The <i>GuidCaller</i>
///                 parameter can be <b>NULL</b>.
///    FileName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string. The fax service sets this
///               variable to the fully qualified path and name of one file in the fax file list associated with the received fax
///               document.
///    Context = Type: <b>PVOID</b> Pointer to an extension-defined value supplied by the fax routing method identified by the
///              <i>GuidCaller</i> parameter. This is an opaque value that the FaxRouteEnumFiles function passes to
///              <i>FaxRouteEnumFile</i>.
///Returns:
///    Type: <b>BOOL</b> The function returns a nonzero value to continue enumeration, or zero to stop enumeration.
///    
alias PFAXROUTEENUMFILE = BOOL function(uint JobId, GUID* GuidOwner, GUID* GuidCaller, const(wchar)* FileName, 
                                        void* Context);
///A fax routing method calls the <i>FaxRouteEnumFiles</i> callback function to enumerate the files in the fax file list
///associated with a received fax document. FaxRoutingMethod passes a pointer to the FaxRouteEnumFile callback function
///if it calls <i>FaxRouteEnumFiles</i>.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    Guid = Type: <b>GUID*</b> Pointer to a null-terminated Unicode character string that contains the GUID for the fax
///           routing method.
///    FileEnumerator = Type: <b>PFAXROUTEENUMFILE</b> Pointer to a FaxRouteEnumFile callback function defined by the fax routing
///                     extension. <i>FaxRouteEnumFile</i> receives the file names in the fax file list associated with the received fax
///                     document.
///    Context = Type: <b>PVOID</b> Pointer to an extension-defined value that <i>FaxRouteEnumFiles</i> passes to the
///              FaxRouteEnumFile function. The fax routing method can define this value.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEENUMFILES = BOOL function(uint JobId, GUID* Guid, PFAXROUTEENUMFILE FileEnumerator, void* Context);
///A fax routing method calls the <i>FaxRouteModifyRoutingData</i> callback function to modify the routing data for a
///subsequent fax routing method.
///Params:
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
///    RoutingGuid = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the GUID of
///                  the fax routing method to modify.
///    RoutingData = Type: <b>LPBYTE</b> Pointer to a buffer that contains additional routing data defined by the routing extension.
///                  For more information, see the following Remarks section. The fax routing method that calls the
///                  <i>FaxRouteModifyRoutingData</i> function and the routing method specified by the <i>RoutingGuid</i> parameter
///                  must interpret the data in the <i>RoutingData</i> parameter.
///    RoutingDataSize = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is the size, in bytes, of the buffer pointed to by the
///                      <i>RoutingData</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEMODIFYROUTINGDATA = BOOL function(uint JobId, const(wchar)* RoutingGuid, ubyte* RoutingData, 
                                                 uint RoutingDataSize);
alias PFAXROUTEINITIALIZE = BOOL function(HANDLE param0, FAX_ROUTE_CALLBACKROUTINES* param1);
///The <b>FaxRouteMethod</b> function is a placeholder for a function name defined by the fax routing extension DLL.
///This function executes a defined fax routing procedure. The fax routing extension DLL can export multiple fax routing
///methods. The fax routing extension must export one uniquely named <b>FaxRouteMethod</b> function for each fax routing
///method it exports. It is recommended that each function name describe the functionality of the particular fax routing
///method. The fax service calls the <b>FaxRouteMethod</b> functions, in order of priority, after the service receives a
///fax document.
///Params:
///    Arg1 = Type: <b>const FAX_ROUTE*</b> Pointer to a FAX_ROUTE structure that contains information about the received fax
///           document.
///    Arg2 = Type: <b>PVOID*</b> Pointer to a variable that receives a pointer to a buffer that contains retry information for
///           the fax routing method. This parameter can be equal to <b>NULL</b>. For more information, see the following
///           Remarks section.
///    Arg3 = Type: <b>LPDWORD</b> Pointer to an unsigned <b>DWORD</b> variable that receives the size, in bytes, of the buffer
///           pointed to by the <i>FailureData</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is a nonzero value. If the function fails, the
///    return value is zero. To get extended error information, the fax service calls GetLastError, described in MSDN.
///    
alias PFAXROUTEMETHOD = BOOL function(const(FAX_ROUTE)* param0, void** param1, uint* param2);
alias PFAXROUTEDEVICEENABLE = BOOL function(const(wchar)* param0, uint param1, int param2);
alias PFAXROUTEDEVICECHANGENOTIFICATION = BOOL function(uint param0, BOOL param1);
alias PFAXROUTEGETROUTINGINFO = BOOL function(const(wchar)* param0, uint param1, ubyte* param2, uint* param3);
alias PFAXROUTESETROUTINGINFO = BOOL function(const(wchar)* param0, uint param1, const(ubyte)* param2, uint param3);
alias PFAX_EXT_GET_DATA = uint function(uint param0, FAX_ENUM_DEVICE_ID_SOURCE param1, const(wchar)* param2, 
                                        ubyte** param3, uint* param4);
alias PFAX_EXT_SET_DATA = uint function(HINSTANCE param0, uint param1, FAX_ENUM_DEVICE_ID_SOURCE param2, 
                                        const(wchar)* param3, ubyte* param4, uint param5);
alias PFAX_EXT_CONFIG_CHANGE = HRESULT function(uint param0, const(wchar)* param1, ubyte* param2, uint param3);
alias PFAX_EXT_REGISTER_FOR_EVENTS = HANDLE function(HINSTANCE param0, uint param1, 
                                                     FAX_ENUM_DEVICE_ID_SOURCE param2, const(wchar)* param3, 
                                                     PFAX_EXT_CONFIG_CHANGE param4);
alias PFAX_EXT_UNREGISTER_FOR_EVENTS = uint function(HANDLE param0);
alias PFAX_EXT_FREE_BUFFER = void function(void* param0);
alias PFAX_EXT_INITIALIZE_CONFIG = HRESULT function(PFAX_EXT_GET_DATA param0, PFAX_EXT_SET_DATA param1, 
                                                    PFAX_EXT_REGISTER_FOR_EVENTS param2, 
                                                    PFAX_EXT_UNREGISTER_FOR_EVENTS param3, 
                                                    PFAX_EXT_FREE_BUFFER param4);

// Structs


///The <b>FAX_LOG_CATEGORY</b> structure describes one logging category. The structure contains a logging category name
///and identifier. It also includes the current level at which the fax server logs events for the specified logging
///category in the application event log.
struct FAX_LOG_CATEGORYA
{
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is a descriptive name for the
    ///logging category.
    const(char)* Name;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a unique value that identifies a logging category.
    ///This member can be one of the following predefined values.
    uint         Category;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the current logging level for the logging
    ///category. This member can be one of the following predefined logging levels.
    uint         Level;
}

///The <b>FAX_LOG_CATEGORY</b> structure describes one logging category. The structure contains a logging category name
///and identifier. It also includes the current level at which the fax server logs events for the specified logging
///category in the application event log.
struct FAX_LOG_CATEGORYW
{
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is a descriptive name for the
    ///logging category.
    const(wchar)* Name;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a unique value that identifies a logging category.
    ///This member can be one of the following predefined values.
    uint          Category;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the current logging level for the logging
    ///category. This member can be one of the following predefined logging levels.
    uint          Level;
}

///The <b>FAX_TIME</b> structure represents a time, using individual members for the current hour and minute. The time
///is expressed in Coordinated Universal Time (UTC).
struct FAX_TIME
{
    ///Type: <b>WORD</b> Specifies a 16-bit unsigned integer that is the current hour. Valid values are 0 through 23.
    ushort Hour;
    ///Type: <b>WORD</b> Specifies a 16-bit unsigned integer that is the current minute. Valid values are 0 through 59.
    ushort Minute;
}

///The <b>FAX_CONFIGURATION</b> structure contains information about the global configuration settings of a fax server.
///The structure includes data on retransmission, branding, archive, and cover page settings; discount rate periods; and
///the status of the fax server queue.
struct FAX_CONFIGURATIONA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_CONFIGURATION</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_CONFIGURATION)</b> before it calls the FaxSetConfiguration
    ///function.
    uint         SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times the fax server will
    ///attempt to retransmit an outgoing fax if the initial transmission fails.
    uint         Retries;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of minutes that will elapse
    ///between retransmission attempts by the fax server.
    uint         RetryDelay;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of days the fax server will retain
    ///an unsent job in the fax job queue. A transmission might not be sent, for example, if an invalid fax number or
    ///date is specified, or if the sending device receives a busy signal multiple times.
    uint         DirtyDays;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server should generate a brand
    ///(banner) at the top of outgoing fax transmissions. If this member is <b>TRUE</b>, the fax server generates a
    ///brand that contains transmission-related information like the transmitting station identifier, date, time, and
    ///page count.
    BOOL         Branding;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server will use the device's
    ///transmitting station identifier instead of the value specified in the <b>Tsid</b> member of the FAX_JOB_PARAM
    ///structure. If this member is <b>TRUE</b>, the server uses the device's transmitting station identifier.
    BOOL         UseDeviceTsid;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether fax client applications can include a
    ///user-designed cover page with the fax transmission. If this member is <b>TRUE</b>, the client must use a common
    ///cover page stored on the fax server. If this member is <b>FALSE</b>, the client can use a personal cover page
    ///file.
    BOOL         ServerCp;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server has paused the fax job
    ///queue. If this member is <b>TRUE</b>, the queue has been paused.
    BOOL         PauseServerQueue;
    ///Type: <b>FAX_TIME</b> Specifies a FAX_TIME structure that indicates the hour and minute at which the discount
    ///period begins. The discount period applies only to outgoing transmissions.
    FAX_TIME     StartCheapTime;
    ///Type: <b>FAX_TIME</b> Specifies a FAX_TIME structure that indicates the hour and minute at which the discount
    ///period ends. The discount period applies only to outgoing transmissions.
    FAX_TIME     StopCheapTime;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server should archive outgoing fax
    ///transmissions. If this member is <b>TRUE</b>, the server archives outgoing transmissions in the directory
    ///specified by the <b>ArchiveDirectory</b> member.
    BOOL         ArchiveOutgoingFaxes;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
    ///path of the directory in which outgoing fax transmissions will be archived. The path can be a UNC path or a path
    ///beginning with a drive letter. The fax server ignores this member if the <b>ArchiveOutgoingFaxes</b> member is
    ///<b>FALSE</b>. This member can be <b>NULL</b> if the <b>ArchiveOutgoingFaxes</b> member is <b>FALSE</b>.
    const(char)* ArchiveDirectory;
    const(char)* Reserved;
}

///The <b>FAX_CONFIGURATION</b> structure contains information about the global configuration settings of a fax server.
///The structure includes data on retransmission, branding, archive, and cover page settings; discount rate periods; and
///the status of the fax server queue.
struct FAX_CONFIGURATIONW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_CONFIGURATION</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_CONFIGURATION)</b> before it calls the FaxSetConfiguration
    ///function.
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times the fax server will
    ///attempt to retransmit an outgoing fax if the initial transmission fails.
    uint          Retries;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of minutes that will elapse
    ///between retransmission attempts by the fax server.
    uint          RetryDelay;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of days the fax server will retain
    ///an unsent job in the fax job queue. A transmission might not be sent, for example, if an invalid fax number or
    ///date is specified, or if the sending device receives a busy signal multiple times.
    uint          DirtyDays;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server should generate a brand
    ///(banner) at the top of outgoing fax transmissions. If this member is <b>TRUE</b>, the fax server generates a
    ///brand that contains transmission-related information like the transmitting station identifier, date, time, and
    ///page count.
    BOOL          Branding;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server will use the device's
    ///transmitting station identifier instead of the value specified in the <b>Tsid</b> member of the FAX_JOB_PARAM
    ///structure. If this member is <b>TRUE</b>, the server uses the device's transmitting station identifier.
    BOOL          UseDeviceTsid;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether fax client applications can include a
    ///user-designed cover page with the fax transmission. If this member is <b>TRUE</b>, the client must use a common
    ///cover page stored on the fax server. If this member is <b>FALSE</b>, the client can use a personal cover page
    ///file.
    BOOL          ServerCp;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server has paused the fax job
    ///queue. If this member is <b>TRUE</b>, the queue has been paused.
    BOOL          PauseServerQueue;
    ///Type: <b>FAX_TIME</b> Specifies a FAX_TIME structure that indicates the hour and minute at which the discount
    ///period begins. The discount period applies only to outgoing transmissions.
    FAX_TIME      StartCheapTime;
    ///Type: <b>FAX_TIME</b> Specifies a FAX_TIME structure that indicates the hour and minute at which the discount
    ///period ends. The discount period applies only to outgoing transmissions.
    FAX_TIME      StopCheapTime;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax server should archive outgoing fax
    ///transmissions. If this member is <b>TRUE</b>, the server archives outgoing transmissions in the directory
    ///specified by the <b>ArchiveDirectory</b> member.
    BOOL          ArchiveOutgoingFaxes;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
    ///path of the directory in which outgoing fax transmissions will be archived. The path can be a UNC path or a path
    ///beginning with a drive letter. The fax server ignores this member if the <b>ArchiveOutgoingFaxes</b> member is
    ///<b>FALSE</b>. This member can be <b>NULL</b> if the <b>ArchiveOutgoingFaxes</b> member is <b>FALSE</b>.
    const(wchar)* ArchiveDirectory;
    const(wchar)* Reserved;
}

///The <b>FAX_DEVICE_STATUS</b> structure contains information about the current status of a fax device. In addition to
///the status, the structure also includes data on whether the device is currently sending or receiving a fax
///transmission, device and station identifiers, sender and recipient names, and routing information.
struct FAX_DEVICE_STATUSA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_DEVICE_STATUS</b> structure. The fax service sets
    ///this member to <b>sizeof(FAX_DEVICE_STATUS)</b>.
    uint         SizeOfStruct;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_RECEIVE</b> job type, <b>CallerId</b> is
    ///a pointer to a null-terminated character string that identifies the calling device that sent the active fax
    ///document. This string can include the telephone number of the calling device.
    const(char)* CallerId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the called station
    ///identifier of the device.
    const(char)* Csid;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of the page in the fax
    ///transmission that the fax device is currently sending or receiving. The page count is relative to one.
    uint         CurrentPage;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint         DeviceId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(char)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document
    ///that the device is currently sending or receiving. This is the user-friendly name that appears in the print
    ///spooler.
    const(char)* DocumentName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that identifies the type of fax job that is currently active
    ///on the device. This member can be one of the following job types.
    uint         JobType;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_SEND</b> job type, <b>PhoneNumber</b> is
    ///a pointer to a constant null-terminated character string that is the fax number dialed for the outgoing fax
    ///transmission.
    const(char)* PhoneNumber;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_RECEIVE</b> job type,
    ///<b>RoutingString</b> is a pointer to a constant null-terminated character string that specifies the routing
    ///string for an incoming fax. The string must be of the form:
    ///<code>Canonical-Phone-Number[|Additional-Routing-Info]</code> where <code>Canonical-Phone-Number</code> is
    ///defined in the Address topic of the TAPI documentation (see the Canonical Address subheading); and
    ///<code>Additional-Routing-Info</code> is the <i>subaddress</i> of a Canonical Address, and uses the subaddress
    ///format.
    const(char)* RoutingString;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(char)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(char)* RecipientName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the size, in bytes, of the active fax
    ///document.
    uint         Size;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the starting time of the current fax job
    ///expressed in UTC.
    FILETIME     StartTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This member can
    ///be one of the predefined device status codes shown following.
    uint         Status;
    ///Type: <b>LPCTSTR</b> This member must be <b>NULL</b>.
    const(char)* StatusString;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the time the client submitted the fax document
    ///for transmission to the fax job queue. The time is expressed in UTC.
    FILETIME     SubmittedTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint         TotalPages;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier (TSID). This identifier is usually a telephone number.
    const(char)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the user
    ///who submitted the active fax job.
    const(char)* UserName;
}

///The <b>FAX_DEVICE_STATUS</b> structure contains information about the current status of a fax device. In addition to
///the status, the structure also includes data on whether the device is currently sending or receiving a fax
///transmission, device and station identifiers, sender and recipient names, and routing information.
struct FAX_DEVICE_STATUSW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_DEVICE_STATUS</b> structure. The fax service sets
    ///this member to <b>sizeof(FAX_DEVICE_STATUS)</b>.
    uint          SizeOfStruct;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_RECEIVE</b> job type, <b>CallerId</b> is
    ///a pointer to a null-terminated character string that identifies the calling device that sent the active fax
    ///document. This string can include the telephone number of the calling device.
    const(wchar)* CallerId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the called station
    ///identifier of the device.
    const(wchar)* Csid;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of the page in the fax
    ///transmission that the fax device is currently sending or receiving. The page count is relative to one.
    uint          CurrentPage;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint          DeviceId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(wchar)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document
    ///that the device is currently sending or receiving. This is the user-friendly name that appears in the print
    ///spooler.
    const(wchar)* DocumentName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that identifies the type of fax job that is currently active
    ///on the device. This member can be one of the following job types.
    uint          JobType;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_SEND</b> job type, <b>PhoneNumber</b> is
    ///a pointer to a constant null-terminated character string that is the fax number dialed for the outgoing fax
    ///transmission.
    const(wchar)* PhoneNumber;
    ///Type: <b>LPCTSTR</b> If the <b>JobType</b> member is equal to the <b>JT_RECEIVE</b> job type,
    ///<b>RoutingString</b> is a pointer to a constant null-terminated character string that specifies the routing
    ///string for an incoming fax. The string must be of the form:
    ///<code>Canonical-Phone-Number[|Additional-Routing-Info]</code> where <code>Canonical-Phone-Number</code> is
    ///defined in the Address topic of the TAPI documentation (see the Canonical Address subheading); and
    ///<code>Additional-Routing-Info</code> is the <i>subaddress</i> of a Canonical Address, and uses the subaddress
    ///format.
    const(wchar)* RoutingString;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(wchar)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(wchar)* RecipientName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the size, in bytes, of the active fax
    ///document.
    uint          Size;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the starting time of the current fax job
    ///expressed in UTC.
    FILETIME      StartTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This member can
    ///be one of the predefined device status codes shown following.
    uint          Status;
    ///Type: <b>LPCTSTR</b> This member must be <b>NULL</b>.
    const(wchar)* StatusString;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the time the client submitted the fax document
    ///for transmission to the fax job queue. The time is expressed in UTC.
    FILETIME      SubmittedTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint          TotalPages;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier (TSID). This identifier is usually a telephone number.
    const(wchar)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the user
    ///who submitted the active fax job.
    const(wchar)* UserName;
}

///The <b>FAX_JOB_ENTRY</b> structure describes one fax job. The structure includes data on the job type and status,
///recipient and sender identification, scheduling and delivery settings, and the page count. The <b>SizeOfStruct</b>
///and <b>RecipientNumber</b> members are required.
struct FAX_JOB_ENTRYA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_JOB_ENTRY</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_JOB_ENTRY)</b> before it calls the FaxSetJob function.
    uint         SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a unique number that identifies the fax job of interest. This number must match the
    ///value the calling application passes in the JobId parameter to the FaxSetJob function.
    uint         JobId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the user
    ///who submitted the fax job.
    const(char)* UserName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that specifies the type of the fax job of interest. This
    ///member can be one of the following job types.
    uint         JobType;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a set of bit flags indicating the queue status of
    ///the fax job identified by the <b>JobId</b> member. This member can be one or more of the following values.
    uint         QueueStatus;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This value can be
    ///one of the following predefined device status codes.
    uint         Status;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains the size, in bytes, of the fax document to
    ///transmit. The size must not exceed 4 GB.
    uint         Size;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint         PageCount;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission.
    const(char)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(char)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier. This identifier is usually a telephone number.
    const(char)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(char)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(char)* BillingCode;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates when to send the fax. This member can be one
    ///of the following predefined job scheduling actions.
    uint         ScheduleAction;
    ///Type: <b>SYSTEMTIME</b> If the <b>ScheduleAction</b> member is equal to the value <b>JSA_SPECIFIC_TIME</b>,
    ///specifies a SYSTEMTIME structure that contains the date and time to send the fax. The time specified must be
    ///expressed in UTC.
    SYSTEMTIME   ScheduleTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the type of email delivery report (DR) or
    ///nondelivery report (NDR) that the fax server should generate. This member can be one of the following predefined
    ///delivery report types.
    uint         DeliveryReportType;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string. If the <b>DeliveryReportType</b>
    ///member is equal to <b>DRT_EMAIL</b>, the string is the address to which the DR or NDR should be sent. If the
    ///<b>DeliveryReportType</b> member is equal to <b>DRT_NONE</b>, this member must be <b>NULL</b>.
    const(char)* DeliveryReportAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document.
    ///This is the user-friendly name that appears in the print spooler.
    const(char)* DocumentName;
}

///The <b>FAX_JOB_ENTRY</b> structure describes one fax job. The structure includes data on the job type and status,
///recipient and sender identification, scheduling and delivery settings, and the page count. The <b>SizeOfStruct</b>
///and <b>RecipientNumber</b> members are required.
struct FAX_JOB_ENTRYW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_JOB_ENTRY</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_JOB_ENTRY)</b> before it calls the FaxSetJob function.
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a unique number that identifies the fax job of interest. This number must match the
    ///value the calling application passes in the JobId parameter to the FaxSetJob function.
    uint          JobId;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the user
    ///who submitted the fax job.
    const(wchar)* UserName;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that specifies the type of the fax job of interest. This
    ///member can be one of the following job types.
    uint          JobType;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a set of bit flags indicating the queue status of
    ///the fax job identified by the <b>JobId</b> member. This member can be one or more of the following values.
    uint          QueueStatus;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This value can be
    ///one of the following predefined device status codes.
    uint          Status;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains the size, in bytes, of the fax document to
    ///transmit. The size must not exceed 4 GB.
    uint          Size;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint          PageCount;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission.
    const(wchar)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(wchar)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier. This identifier is usually a telephone number.
    const(wchar)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(wchar)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(wchar)* BillingCode;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates when to send the fax. This member can be one
    ///of the following predefined job scheduling actions.
    uint          ScheduleAction;
    ///Type: <b>SYSTEMTIME</b> If the <b>ScheduleAction</b> member is equal to the value <b>JSA_SPECIFIC_TIME</b>,
    ///specifies a SYSTEMTIME structure that contains the date and time to send the fax. The time specified must be
    ///expressed in UTC.
    SYSTEMTIME    ScheduleTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the type of email delivery report (DR) or
    ///nondelivery report (NDR) that the fax server should generate. This member can be one of the following predefined
    ///delivery report types.
    uint          DeliveryReportType;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string. If the <b>DeliveryReportType</b>
    ///member is equal to <b>DRT_EMAIL</b>, the string is the address to which the DR or NDR should be sent. If the
    ///<b>DeliveryReportType</b> member is equal to <b>DRT_NONE</b>, this member must be <b>NULL</b>.
    const(wchar)* DeliveryReportAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document.
    ///This is the user-friendly name that appears in the print spooler.
    const(wchar)* DocumentName;
}

///The <b>FAX_PORT_INFO</b> structure describes one fax port. The data includes, among other items, a device identifier,
///the port's name and current status, and station identifiers.
struct FAX_PORT_INFOA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_PORT_INFO</b> structure. The calling application
    ///should ensure that this member is set to <b>sizeof(FAX_PORT_INFO)</b> before it calls the FaxSetPort function.
    uint         SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint         DeviceId;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This member can
    ///be one of the predefined device status codes shown following.
    uint         State;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a set of bit flags that specify the capability of
    ///the fax port. This member can be a combination of the following values.
    uint         Flags;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times an incoming fax call
    ///should ring before the specified device answers the call. Possible values are from 0 to 99 inclusive. This value
    ///is ignored unless the <b>FPF_RECEIVE</b> port capability bit flag is set.
    uint         Rings;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that determines the relative order in which available fax
    ///devices send outgoing transmissions. Valid values for this member are 1 through <i>n</i>, where <i>n</i> is the
    ///value of the <i>PortsReturned</i> parameter returned by a call to the FaxEnumPorts function. When the fax server
    ///initiates an outgoing fax transmission, it attempts to select the device with the highest priority and
    ///<b>FPF_SEND</b> port capability. If that device is not available, the server selects the next available device
    ///that follows in rank order, and so on. The value of the <b>Priority</b> member has no effect on incoming
    ///transmissions.
    uint         Priority;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(char)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the TSID. This
    ///identifier is usually a telephone number. Only printable characters such as English letters, numeric symbols, and
    ///punctuation marks (ASCII range 0x20 to 0x7F) can be used in a TSID.
    const(char)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the called station
    ///identifier (CSID). This identifier is usually a telephone number. Only printable characters such as English
    ///letters, numeric symbols, and punctuation marks (ASCII range 0x20 to 0x7F) can be used in a CSID.
    const(char)* Csid;
}

///The <b>FAX_PORT_INFO</b> structure describes one fax port. The data includes, among other items, a device identifier,
///the port's name and current status, and station identifiers.
struct FAX_PORT_INFOW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_PORT_INFO</b> structure. The calling application
    ///should ensure that this member is set to <b>sizeof(FAX_PORT_INFO)</b> before it calls the FaxSetPort function.
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint          DeviceId;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a fax device status code or value. This member can
    ///be one of the predefined device status codes shown following.
    uint          State;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a set of bit flags that specify the capability of
    ///the fax port. This member can be a combination of the following values.
    uint          Flags;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the number of times an incoming fax call
    ///should ring before the specified device answers the call. Possible values are from 0 to 99 inclusive. This value
    ///is ignored unless the <b>FPF_RECEIVE</b> port capability bit flag is set.
    uint          Rings;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that determines the relative order in which available fax
    ///devices send outgoing transmissions. Valid values for this member are 1 through <i>n</i>, where <i>n</i> is the
    ///value of the <i>PortsReturned</i> parameter returned by a call to the FaxEnumPorts function. When the fax server
    ///initiates an outgoing fax transmission, it attempts to select the device with the highest priority and
    ///<b>FPF_SEND</b> port capability. If that device is not available, the server selects the next available device
    ///that follows in rank order, and so on. The value of the <b>Priority</b> member has no effect on incoming
    ///transmissions.
    uint          Priority;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(wchar)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the TSID. This
    ///identifier is usually a telephone number. Only printable characters such as English letters, numeric symbols, and
    ///punctuation marks (ASCII range 0x20 to 0x7F) can be used in a TSID.
    const(wchar)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the called station
    ///identifier (CSID). This identifier is usually a telephone number. Only printable characters such as English
    ///letters, numeric symbols, and punctuation marks (ASCII range 0x20 to 0x7F) can be used in a CSID.
    const(wchar)* Csid;
}

///The <b>FAX_ROUTING_METHOD</b> structure contains information about one fax routing method, as it pertains to one fax
///device. The data includes, among other items, whether the fax routing method is enabled for the device, and the name
///of the DLL that exports the routing method. It also includes the GUID and function name that uniquely identify the
///routing method, and the method's user-friendly name.
struct FAX_ROUTING_METHODA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_ROUTING_METHOD</b> structure. The fax service sets
    ///this member to <b>sizeof(FAX_ROUTING_METHOD)</b>.
    uint         SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint         DeviceId;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax routing method is enabled or
    ///disabled for the fax device of interest. If this parameter is equal to <b>TRUE</b>, the fax routing method is
    ///enabled for the device.
    BOOL         Enabled;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(char)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
    ///identifies the fax routing method of interest. For more information about fax routing methods, see About the Fax
    ///Routing Extension API.
    const(char)* Guid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing method.
    const(char)* FriendlyName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the function that
    ///executes the specified fax routing procedure. The fax routing extension DLL identified by the
    ///<b>ExtensionImageName</b> member exports the function.
    const(char)* FunctionName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///routing extension DLL that implements the fax routing method.
    const(char)* ExtensionImageName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing extension DLL.
    const(char)* ExtensionFriendlyName;
}

///The <b>FAX_ROUTING_METHOD</b> structure contains information about one fax routing method, as it pertains to one fax
///device. The data includes, among other items, whether the fax routing method is enabled for the device, and the name
///of the DLL that exports the routing method. It also includes the GUID and function name that uniquely identify the
///routing method, and the method's user-friendly name.
struct FAX_ROUTING_METHODW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_ROUTING_METHOD</b> structure. The fax service sets
    ///this member to <b>sizeof(FAX_ROUTING_METHOD)</b>.
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint          DeviceId;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax routing method is enabled or
    ///disabled for the fax device of interest. If this parameter is equal to <b>TRUE</b>, the fax routing method is
    ///enabled for the device.
    BOOL          Enabled;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///device of interest.
    const(wchar)* DeviceName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
    ///identifies the fax routing method of interest. For more information about fax routing methods, see About the Fax
    ///Routing Extension API.
    const(wchar)* Guid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing method.
    const(wchar)* FriendlyName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the function that
    ///executes the specified fax routing procedure. The fax routing extension DLL identified by the
    ///<b>ExtensionImageName</b> member exports the function.
    const(wchar)* FunctionName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///routing extension DLL that implements the fax routing method.
    const(wchar)* ExtensionImageName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing extension DLL.
    const(wchar)* ExtensionFriendlyName;
}

///The <b>FAX_GLOBAL_ROUTING_INFO</b> structure contains information about one fax routing method, as it pertains
///globally to the fax service. The structure includes data on the priority level of the fax routing method, and the
///name of the DLL that exports the routing method. It also includes the GUID and function name that identify the fax
///routing method, and the method's user-friendly name. The <b>Guid</b> member is required to identify the fax routing
///method. Currently the <b>Priority</b> member is the only member that an application can modify.
struct FAX_GLOBAL_ROUTING_INFOA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_GLOBAL_ROUTING_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_GLOBAL_ROUTING_INFO)</b> before it calls the
    ///FaxSetGlobalRoutingInfo function.
    uint         SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the priority of the fax routing method. The
    ///priority determines the relative order in which the fax service calls the fax routing methods when the service
    ///receives a fax document. Valid values for this member are 1 through n, where 1 is the highest priority.
    uint         Priority;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
    ///identifies the fax routing method of interest. For more information about fax routing methods, see About the Fax
    ///Routing Extension API.
    const(char)* Guid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing method.
    const(char)* FriendlyName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the function that
    ///executes the specified fax routing method. The fax routing extension DLL identified by the
    ///<b>ExtensionImageName</b> member exports the function.
    const(char)* FunctionName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///routing extension DLL that implements the fax routing method.
    const(char)* ExtensionImageName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing extension DLL that implements the fax routing method.
    const(char)* ExtensionFriendlyName;
}

///The <b>FAX_GLOBAL_ROUTING_INFO</b> structure contains information about one fax routing method, as it pertains
///globally to the fax service. The structure includes data on the priority level of the fax routing method, and the
///name of the DLL that exports the routing method. It also includes the GUID and function name that identify the fax
///routing method, and the method's user-friendly name. The <b>Guid</b> member is required to identify the fax routing
///method. Currently the <b>Priority</b> member is the only member that an application can modify.
struct FAX_GLOBAL_ROUTING_INFOW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_GLOBAL_ROUTING_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_GLOBAL_ROUTING_INFO)</b> before it calls the
    ///FaxSetGlobalRoutingInfo function.
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the priority of the fax routing method. The
    ///priority determines the relative order in which the fax service calls the fax routing methods when the service
    ///receives a fax document. Valid values for this member are 1 through n, where 1 is the highest priority.
    uint          Priority;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
    ///identifies the fax routing method of interest. For more information about fax routing methods, see About the Fax
    ///Routing Extension API.
    const(wchar)* Guid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing method.
    const(wchar)* FriendlyName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the function that
    ///executes the specified fax routing method. The fax routing extension DLL identified by the
    ///<b>ExtensionImageName</b> member exports the function.
    const(wchar)* FunctionName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the fax
    ///routing extension DLL that implements the fax routing method.
    const(wchar)* ExtensionImageName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the user-friendly name
    ///to display for the fax routing extension DLL that implements the fax routing method.
    const(wchar)* ExtensionFriendlyName;
}

///The <b>FAX_COVERPAGE_INFO</b> structure contains data to display on the cover page of a fax transmission. The
///<b>SizeOfStruct</b> and <b>CoverPageName</b> members are required; other members are optional.
struct FAX_COVERPAGE_INFOA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_COVERPAGE_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_COVERPAGE_INFO)</b>.
    uint         SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the cover page
    ///file (.cov) to associate with the received fax document. The string can be the file name of the common cover page
    ///file, or it can be the UNC path to a local cover page file.
    const(char)* CoverPageName;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax cover page file is stored on the
    ///local computer or in the common cover page location. A value of <b>TRUE</b> indicates that the cover page file
    ///resides in the common cover page location on the fax server.
    BOOL         UseServerCoverPage;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(char)* RecName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission.
    const(char)* RecFaxNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the recipient of the fax transmission.
    const(char)* RecCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the street address of
    ///the recipient of the fax transmission.
    const(char)* RecStreetAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the city of the recipient of
    ///the fax transmission.
    const(char)* RecCity;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the state of the recipient of
    ///the fax transmission.
    const(char)* RecState;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the postal ZIP code of the
    ///recipient of the fax transmission.
    const(char)* RecZip;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the country/region of the
    ///recipient of the fax transmission.
    const(char)* RecCountry;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the title of the recipient of
    ///the fax transmission.
    const(char)* RecTitle;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the department of the
    ///recipient of the fax transmission.
    const(char)* RecDepartment;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office location of the
    ///recipient of the fax transmission.
    const(char)* RecOfficeLocation;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the home telephone number of
    ///the recipient of the fax transmission.
    const(char)* RecHomePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office telephone number
    ///of the recipient of the fax transmission.
    const(char)* RecOfficePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the sender who
    ///initiated the fax transmission.
    const(char)* SdrName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the fax number of the sender
    ///who initiated the fax transmission.
    const(char)* SdrFaxNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the company name of the
    ///sender who initiated the fax transmission.
    const(char)* SdrCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the address of the sender who
    ///initiated the fax transmission.
    const(char)* SdrAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the title of the sender who
    ///initiated the fax transmission.
    const(char)* SdrTitle;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the department name of the
    ///sender who initiated the fax transmission.
    const(char)* SdrDepartment;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office location of the
    ///sender who initiated the fax transmission.
    const(char)* SdrOfficeLocation;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the home telephone number of
    ///the sender who initiated the fax transmission.
    const(char)* SdrHomePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office telephone number
    ///of the sender who initiated the fax transmission.
    const(char)* SdrOfficePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the text of a message
    ///or note from the sender that pertains to the fax transmission. The text will appear on the cover page.
    const(char)* Note;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the subject line of the fax
    ///transmission.
    const(char)* Subject;
    ///Type: <b>SYSTEMTIME</b> Specifies a SYSTEMTIME structure. The fax server sets this member when it initiates the
    ///fax transmission. The time is expressed in local system time.
    SYSTEMTIME   TimeSent;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint         PageCount;
}

///The <b>FAX_COVERPAGE_INFO</b> structure contains data to display on the cover page of a fax transmission. The
///<b>SizeOfStruct</b> and <b>CoverPageName</b> members are required; other members are optional.
struct FAX_COVERPAGE_INFOW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_COVERPAGE_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_COVERPAGE_INFO)</b>.
    uint          SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the cover page
    ///file (.cov) to associate with the received fax document. The string can be the file name of the common cover page
    ///file, or it can be the UNC path to a local cover page file.
    const(wchar)* CoverPageName;
    ///Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the fax cover page file is stored on the
    ///local computer or in the common cover page location. A value of <b>TRUE</b> indicates that the cover page file
    ///resides in the common cover page location on the fax server.
    BOOL          UseServerCoverPage;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(wchar)* RecName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission.
    const(wchar)* RecFaxNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the recipient of the fax transmission.
    const(wchar)* RecCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the street address of
    ///the recipient of the fax transmission.
    const(wchar)* RecStreetAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the city of the recipient of
    ///the fax transmission.
    const(wchar)* RecCity;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the state of the recipient of
    ///the fax transmission.
    const(wchar)* RecState;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the postal ZIP code of the
    ///recipient of the fax transmission.
    const(wchar)* RecZip;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the country/region of the
    ///recipient of the fax transmission.
    const(wchar)* RecCountry;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the title of the recipient of
    ///the fax transmission.
    const(wchar)* RecTitle;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the department of the
    ///recipient of the fax transmission.
    const(wchar)* RecDepartment;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office location of the
    ///recipient of the fax transmission.
    const(wchar)* RecOfficeLocation;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the home telephone number of
    ///the recipient of the fax transmission.
    const(wchar)* RecHomePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office telephone number
    ///of the recipient of the fax transmission.
    const(wchar)* RecOfficePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the name of the sender who
    ///initiated the fax transmission.
    const(wchar)* SdrName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the fax number of the sender
    ///who initiated the fax transmission.
    const(wchar)* SdrFaxNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the company name of the
    ///sender who initiated the fax transmission.
    const(wchar)* SdrCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the address of the sender who
    ///initiated the fax transmission.
    const(wchar)* SdrAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the title of the sender who
    ///initiated the fax transmission.
    const(wchar)* SdrTitle;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the department name of the
    ///sender who initiated the fax transmission.
    const(wchar)* SdrDepartment;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office location of the
    ///sender who initiated the fax transmission.
    const(wchar)* SdrOfficeLocation;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the home telephone number of
    ///the sender who initiated the fax transmission.
    const(wchar)* SdrHomePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the office telephone number
    ///of the sender who initiated the fax transmission.
    const(wchar)* SdrOfficePhone;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the text of a message
    ///or note from the sender that pertains to the fax transmission. The text will appear on the cover page.
    const(wchar)* Note;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the subject line of the fax
    ///transmission.
    const(wchar)* Subject;
    ///Type: <b>SYSTEMTIME</b> Specifies a SYSTEMTIME structure. The fax server sets this member when it initiates the
    ///fax transmission. The time is expressed in local system time.
    SYSTEMTIME    TimeSent;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the total number of pages in the fax
    ///transmission.
    uint          PageCount;
}

///The <b>FAX_JOB_PARAM</b> structure contains the information necessary for the fax server to send an individual fax
///transmission. The structure includes the recipient's fax number, sender and recipient data, an optional billing code,
///and job scheduling information. The <b>SizeOfStruct</b>, <b>RecipientNumber</b>, and <b>ScheduleAction</b> members
///are required; other members are optional.
struct FAX_JOB_PARAMA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_JOB_PARAM</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_JOB_PARAM)</b>. This member is required.
    uint         SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission. This member is required.
    const(char)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(char)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier (TSID). This identifier is usually a telephone number. Only printable characters such as
    ///English letters, numeric symbols, and punctuation marks (ASCII range 0x20 to 0x7F) can be used in a TSID.
    const(char)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(char)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(char)* BillingCode;
    ///Type: <b>DWORD</b> Specifies a DWORD variable that indicates when to send the fax. This member is required, and
    ///can be one of the following predefined job scheduling actions.
    uint         ScheduleAction;
    ///Type: <b>SYSTEMTIME</b> If the <b>ScheduleAction</b> member is equal to the value <b>JSA_SPECIFIC_TIME</b>,
    ///specifies a SYSTEMTIME structure that contains the date and time to send the fax. The time specified must be
    ///expressed in UTC.
    SYSTEMTIME   ScheduleTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the type of email delivery report (DR) or
    ///nondelivery report (NDR) that the fax server should generate. This member can be one of the following predefined
    ///delivery report types.
    uint         DeliveryReportType;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string. If the <b>DeliveryReportType</b>
    ///member is equal to <b>DRT_EMAIL</b>, the string is the address to which the DR or NDR should be sent. If the
    ///<b>DeliveryReportType</b> member is equal to <b>DRT_NONE</b>, this member must be <b>NULL</b>.
    const(char)* DeliveryReportAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document.
    ///This is the user-friendly name that appears in the print spooler.
    const(char)* DocumentName;
    ///Type: <b>HCALL</b> Reserved, and should be <b>NULL</b>.
    uint         CallHandle;
    ///Type: <b>DWORD_PTR[3]</b> This member is reserved for future use by Microsoft. It must be set to zero.
    size_t[3]    Reserved;
}

///The <b>FAX_JOB_PARAM</b> structure contains the information necessary for the fax server to send an individual fax
///transmission. The structure includes the recipient's fax number, sender and recipient data, an optional billing code,
///and job scheduling information. The <b>SizeOfStruct</b>, <b>RecipientNumber</b>, and <b>ScheduleAction</b> members
///are required; other members are optional.
struct FAX_JOB_PARAMW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_JOB_PARAM</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_JOB_PARAM)</b>. This member is required.
    uint          SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission. This member is required.
    const(wchar)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(wchar)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the transmitting
    ///station identifier (TSID). This identifier is usually a telephone number. Only printable characters such as
    ///English letters, numeric symbols, and punctuation marks (ASCII range 0x20 to 0x7F) can be used in a TSID.
    const(wchar)* Tsid;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(wchar)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(wchar)* BillingCode;
    ///Type: <b>DWORD</b> Specifies a DWORD variable that indicates when to send the fax. This member is required, and
    ///can be one of the following predefined job scheduling actions.
    uint          ScheduleAction;
    ///Type: <b>SYSTEMTIME</b> If the <b>ScheduleAction</b> member is equal to the value <b>JSA_SPECIFIC_TIME</b>,
    ///specifies a SYSTEMTIME structure that contains the date and time to send the fax. The time specified must be
    ///expressed in UTC.
    SYSTEMTIME    ScheduleTime;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the type of email delivery report (DR) or
    ///nondelivery report (NDR) that the fax server should generate. This member can be one of the following predefined
    ///delivery report types.
    uint          DeliveryReportType;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string. If the <b>DeliveryReportType</b>
    ///member is equal to <b>DRT_EMAIL</b>, the string is the address to which the DR or NDR should be sent. If the
    ///<b>DeliveryReportType</b> member is equal to <b>DRT_NONE</b>, this member must be <b>NULL</b>.
    const(wchar)* DeliveryReportAddress;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string to associate with the fax document.
    ///This is the user-friendly name that appears in the print spooler.
    const(wchar)* DocumentName;
    ///Type: <b>HCALL</b> Reserved, and should be <b>NULL</b>.
    uint          CallHandle;
    ///Type: <b>DWORD_PTR[3]</b> This member is reserved for future use by Microsoft. It must be set to zero.
    size_t[3]     Reserved;
}

///The <b>FAX_EVENT</b> structure represents the contents of an I/O completion packet. The fax server sends the
///completion packet to notify a fax client application of an asynchronous fax server event. To create a fax event
///queue, the fax client application must call the FaxInitializeEventQueue function. The queue enables the application
///to receive notifications of asynchronous events from the fax server.
struct FAX_EVENTA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_EVENT</b> structure. The fax server sets this
    ///member to <b>sizeof(FAX_EVENT)</b>.
    uint     SizeOfStruct;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the time at which the fax server generated the
    ///event.
    FILETIME TimeStamp;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint     DeviceId;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that identifies the current asynchronous event that occurred
    ///within the fax server. The following table lists the possible events and their meanings.
    uint     EventId;
    ///Type: <b>DWORD</b> Specifies a unique number that identifies the fax job of interest. If this member is equal to
    ///the value 0xffffffff, it indicates an inactive fax job. Note that this number is not a print spooler
    ///identification number.
    uint     JobId;
}

///The <b>FAX_EVENT</b> structure represents the contents of an I/O completion packet. The fax server sends the
///completion packet to notify a fax client application of an asynchronous fax server event. To create a fax event
///queue, the fax client application must call the FaxInitializeEventQueue function. The queue enables the application
///to receive notifications of asynchronous events from the fax server.
struct FAX_EVENTW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_EVENT</b> structure. The fax server sets this
    ///member to <b>sizeof(FAX_EVENT)</b>.
    uint     SizeOfStruct;
    ///Type: <b>FILETIME</b> Specifies a FILETIME structure that contains the time at which the fax server generated the
    ///event.
    FILETIME TimeStamp;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the permanent line identifier for the fax
    ///device of interest.
    uint     DeviceId;
    ///Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that identifies the current asynchronous event that occurred
    ///within the fax server. The following table lists the possible events and their meanings.
    uint     EventId;
    ///Type: <b>DWORD</b> Specifies a unique number that identifies the fax job of interest. If this member is equal to
    ///the value 0xffffffff, it indicates an inactive fax job. Note that this number is not a print spooler
    ///identification number.
    uint     JobId;
}

///The <b>FAX_PRINT_INFO</b> structure contains the information necessary for the fax server to print a fax
///transmission. The structure includes sender and recipient data, an optional billing code, and delivery report
///information. The <b>SizeOfStruct</b> and <b>RecipientNumber</b> members are required; other members are optional.
struct FAX_PRINT_INFOA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_PRINT_INFO</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_PRINT_INFO)</b>. This member is required.
    uint         SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the user-friendly name that
    ///appears in the print spooler.
    const(char)* DocName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(char)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission. This member is required.
    const(char)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(char)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(char)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(char)* SenderBillingCode;
    ///Type: <b>LPCTSTR</b> Reserved. Must be set to <b>NULL</b>.
    const(char)* Reserved;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the email address to
    ///which the fax server should send the delivery report (DR) or nondelivery report (NDR).
    const(char)* DrEmailAddress;
    ///Type: <b>LPCTSTR</b> This member is reserved for future use by Microsoft. It must be set to <b>NULL</b>.
    const(char)* OutputFileName;
}

///The <b>FAX_PRINT_INFO</b> structure contains the information necessary for the fax server to print a fax
///transmission. The structure includes sender and recipient data, an optional billing code, and delivery report
///information. The <b>SizeOfStruct</b> and <b>RecipientNumber</b> members are required; other members are optional.
struct FAX_PRINT_INFOW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_PRINT_INFO</b> structure. The calling application
    ///must set this member to <b>sizeof(FAX_PRINT_INFO)</b>. This member is required.
    uint          SizeOfStruct;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that is the user-friendly name that
    ///appears in the print spooler.
    const(wchar)* DocName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the
    ///recipient of the fax transmission.
    const(wchar)* RecipientName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the fax number of the
    ///recipient of the fax transmission. This member is required.
    const(wchar)* RecipientNumber;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the name of the sender
    ///who initiated the fax transmission.
    const(wchar)* SenderName;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the company name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderCompany;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the department name of
    ///the sender who initiated the fax transmission.
    const(wchar)* SenderDept;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that indicates an application- or
    ///server-specific billing code that applies to the fax transmission. The fax server uses the string to generate an
    ///entry in the fax event log. Billing codes are optional.
    const(wchar)* SenderBillingCode;
    ///Type: <b>LPCTSTR</b> Reserved. Must be set to <b>NULL</b>.
    const(wchar)* Reserved;
    ///Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the email address to
    ///which the fax server should send the delivery report (DR) or nondelivery report (NDR).
    const(wchar)* DrEmailAddress;
    ///Type: <b>LPCTSTR</b> This member is reserved for future use by Microsoft. It must be set to <b>NULL</b>.
    const(wchar)* OutputFileName;
}

///The <b>FAX_CONTEXT_INFO</b> structure contains information about a fax printer device context. The
///<b>SizeOfStruct</b> member is required. Information for the other members is supplied by a call to the
///FaxStartPrintJob function.
struct FAX_CONTEXT_INFOA
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_CONTEXT_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_CONTEXT_INFO)</b> before it calls the FaxStartPrintJob
    ///function.
    uint     SizeOfStruct;
    ///Type: <b>HDC</b> Handle to a fax printer device context. A call to the FaxStartPrintJob function supplies the
    ///data for this member.
    HDC      hDC;
    ///Type: <b>TCHAR[MAX_COMPUTERNAME_LENGTH+1]</b> Specifies a variable that contains a null-terminated string that is
    ///the fax server name of interest. A call to the FaxStartPrintJob function supplies the data for this member. If
    ///the fax server is on the local computer, this member will be empty. The client application does not need to fill
    ///in this member.
    byte[16] ServerName;
}

///The <b>FAX_CONTEXT_INFO</b> structure contains information about a fax printer device context. The
///<b>SizeOfStruct</b> member is required. Information for the other members is supplied by a call to the
///FaxStartPrintJob function.
struct FAX_CONTEXT_INFOW
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_CONTEXT_INFO</b> structure. The calling
    ///application must set this member to <b>sizeof(FAX_CONTEXT_INFO)</b> before it calls the FaxStartPrintJob
    ///function.
    uint       SizeOfStruct;
    ///Type: <b>HDC</b> Handle to a fax printer device context. A call to the FaxStartPrintJob function supplies the
    ///data for this member.
    HDC        hDC;
    ///Type: <b>TCHAR[MAX_COMPUTERNAME_LENGTH+1]</b> Specifies a variable that contains a null-terminated string that is
    ///the fax server name of interest. A call to the FaxStartPrintJob function supplies the data for this member. If
    ///the fax server is on the local computer, this member will be empty. The client application does not need to fill
    ///in this member.
    ushort[16] ServerName;
}

///The <b>FAX_SEND</b> structure contains information about an outbound fax document. The structure contains the name of
///the file that holds the fax data stream, the name and telephone number of the calling device, and the name and
///telephone number of the receiving device.
struct FAX_SEND
{
    ///Type: <b>DWORD</b> Specifies, in bytes, the size of the <b>FAX_SEND</b> structure. Before calling the FaxDevSend
    ///function, the fax service sets this member to <b>sizeof</b>(<b>FAX_SEND</b>).
    uint          SizeOfStruct;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the full path to the
    ///file that contains the data stream for an outbound fax document. The data stream is a TIFF Class F file. For more
    ///information, see Fax Image Format.
    const(wchar)* FileName;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the name of the calling
    ///device. The FSP will send this name to the remote receiving device when the FSP sends the fax. For more
    ///information, see the following Remarks section.
    const(wchar)* CallerName;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the telephone number of
    ///the calling device. (This number is also the TSID.) The FSP will send this number to the remote receiving device
    ///when the FSP sends the fax. For more information, see the following Remarks section.
    const(wchar)* CallerNumber;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the name of the device
    ///that will receive the outbound fax document.
    const(wchar)* ReceiverName;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the telephone number of
    ///the device that will receive the outbound fax document. This is the telephone number that the FSP will dial. If
    ///you specify the <b>CallHandle</b> member, the <b>ReceiverNumber</b> member must be <b>NULL</b>.
    const(wchar)* ReceiverNumber;
    ///Type: <b>BOOL</b> Reserved.
    BOOL          Branding;
    ///Type: <b>HCALL</b> Reserved; must be set to <b>NULL</b>.
    uint          CallHandle;
    ///Type: <b>DWORD</b> This member is reserved by Microsoft. It must be set to zero.
    uint[3]       Reserved;
}

///The <b>FAX_RECEIVE</b> structure contains information about an inbound fax document. This information includes the
///name of the file that will receive the fax data stream, and the name and telephone number of the receiving device.
struct FAX_RECEIVE
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_RECEIVE</b> structure. Before calling the
    ///FaxDevReceive function, the fax service sets this member to <b>sizeof</b>(<b>FAX_RECEIVE</b>). For more
    ///information, see the following Remarks section.
    uint          SizeOfStruct;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the full path to the
    ///file in which the FSP must store the data stream of an inbound fax document. The data stream is a TIFF Class F
    ///file. For more information, see Fax Image Format. The fax service creates the file before it calls the
    ///FaxDevReceive function. The FSP must specify the OPEN_EXISTING flag when opening this file.
    const(wchar)* FileName;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the name of the
    ///receiving device. The FSP will send the name to the remote sending device after the receiving device receives an
    ///inbound fax. For more information, see the following Remarks section.
    const(wchar)* ReceiverName;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the telephone number of
    ///the receiving device. The FSP will send the number to the remote sending device after the receiving device
    ///receives an inbound fax. For more information, see the following Remarks section.
    const(wchar)* ReceiverNumber;
    ///Type: <b>DWORD</b> This member is reserved for future use by Microsoft. It must be set to zero.
    uint[4]       Reserved;
}

///The <b>FAX_DEV_STATUS</b> structure contains status and identification information about an individual active fax
///operation.
struct FAX_DEV_STATUS
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_DEV_STATUS</b> structure. Before responding to the
    ///FaxDevReportStatus function, the FSP must set this member to <b>sizeof</b>(<b>FAX_DEV_STATUS</b>).
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a fax status code or value. This can be a predefined fax status code (shown
    ///following), one of the TAPI LINEERR_ Constants error codes, or a value that the FSP defines. If the status
    ///identifier is provider-defined, the FSP must also supply a value for the <b>StringId</b> member. Following are
    ///the predefined fax status codes. <table class="clsStd"> <tr> <th>Value</th> <th>Meaning</th> </tr> <tr>
    ///<td>FS_INITIALIZING</td> <td>The call is initializing.</td> </tr> <tr> <td>FS_DIALING </td> <td>The FSP is
    ///dialing digits for the call. </td> </tr> <tr> <td>FS_TRANSMITTING </td> <td>The FSP is transmitting the fax
    ///document. </td> </tr> <tr> <td>FS_RECEIVING </td> <td>The FSP is receiving the fax document. </td> </tr> <tr>
    ///<td>FS_COMPLETED </td> <td>The fax transmission call is complete. </td> </tr> <tr> <td>FS_LINE_UNAVAILABLE </td>
    ///<td>The FSP cannot complete the call because the device is not available. </td> </tr> <tr> <td>FS_BUSY</td>
    ///<td>The FSP received a busy signal. </td> </tr> <tr> <td>FS_NO_ANSWER </td> <td>The FSP cannot complete the call
    ///because the receiving device does not answer. </td> </tr> <tr> <td>FS_BAD_ADDRESS </td> <td>The FSP cannot
    ///complete the call because the destination address is invalid. </td> </tr> <tr> <td>FS_NO_DIAL_TONE </td> <td>The
    ///FSP cannot complete the call because it does not detect a dial tone. </td> </tr> <tr> <td>FS_DISCONNECTED </td>
    ///<td>The call was disconnected by the receiving device.</td> </tr> <tr> <td>FS_FATAL_ERROR </td> <td>A fatal error
    ///has occurred. </td> </tr> <tr> <td>FS_NOT_FAX_CALL </td> <td>The call is a data call or a voice call. </td> </tr>
    ///<tr> <td>FS_CALL_DELAYED </td> <td>The FSP received a busy signal multiple times. The provider cannot retry
    ///because dialing restrictions exist. (Some countries/regions restrict the number of retries when a number is
    ///busy.)</td> </tr> <tr> <td>FS_USER_ABORT</td> <td>The FSP has canceled the transmission. Cancellation can result
    ///from a call to the FaxDevAbortOperation function. FSPs can also provide a UI for cancellation of fax
    ///transmissions.</td> </tr> <tr> <td>FS_ANSWERED</td> <td>The FSP answered the inbound call but is not yet
    ///receiving the call. This status indicates to the fax service that the call may not be a fax call.</td> </tr> <tr>
    ///<td>FS_CALL_BLACKLISTED </td> <td>The FSP cannot complete the call because the telephone number is blocked or
    ///reserved, for example, a call to 911 or another emergency number. </td> </tr> </table> The fax status codes
    ///FS_BAD_ADDRESS, FS_CALL_BLACKLISTED and FS_USER_ABORT will result in no retry attempts. The fax status code
    ///FS_LINE_UNAVAILABLE will result in an immediate retry attempt in the case when the line is unavailable because
    ///the service lost the connection to the device (TAPI sent LINE_CLOSE, and the FSP reported FS_LINE_UNAVAILABLE).
    ///The retry depends on whether the device is detected back online. All other fax status codes will result in
    ///allowing the fax service to manage retry attempts.
    uint          StatusId;
    ///Type: <b>DWORD</b> Specifies a string resource identifier for the <b>StatusId</b> member if the <b>StatusId</b>
    ///is provider-defined. The fax service loads the string from the FSP's image. If <b>StatusId</b> contains a
    ///provider-defined status code or value, this member is required. If <b>StatusId</b> contains a predefined status
    ///code or value, this member is ignored.
    uint          StringId;
    ///Type: <b>DWORD</b> Specifies the number of the page in the fax transmission that the FSP is receiving. The page
    ///count is relative to one.
    uint          PageCount;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies an identifier of the
    ///remote fax device that is connected with the current call to either the FaxDevReceive or FaxDevSend function. If
    ///the operation is sending a fax, the identifier specifies the CSID of the remote device; if the operation is
    ///receiving a fax, the identifier specifies the TSID of the remote device.
    const(wchar)* CSI;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that identifies the calling device that
    ///sent the received fax document. This string can include the telephone number of the calling device.
    const(wchar)* CallerId;
    ///Type: <b>LPWSTR</b> Pointer to a null-terminated Unicode character string that specifies the routing string for
    ///an inbound fax. The string must be of the form: <code>Canonical-Phone-Number[|Additional-Routing-Info]</code>
    ///where <code>Canonical-Phone-Number</code> is defined in the Address topic of the TAPI documentation (see the
    ///Canonical Address subheading); and <code>Additional-Routing-Info</code> is the <i>subaddress</i> of a Canonical
    ///Address, and uses the subaddress format. For DID routing, append the specific DID digits to the telephone number
    ///prefix. The DID address must be the canonical telephone number that corresponds to the fully qualified telephone
    ///number that the sender would have dialed. If there is additional routing information, for example, subaddressing
    ///or DTMF tones, separate it from the canonical telephone number by a vertical bar character as indicated in the
    ///TAPI specification. You can specify multiple recipients. For more information, see the Dialable Address and
    ///Canonical Address subheadings in the Address topic of the TAPI documentation.
    const(wchar)* RoutingInfo;
    ///Type: <b>DWORD</b> Specifies one of the Win32 System Error Codes [Base] that the FSP should use to report an
    ///error that occurs. The FSP should set this value to NO_ERROR when it is running and after a fax job completes
    ///normally.
    uint          ErrorCode;
    ///Type: <b>DWORD</b> This member is reserved by Microsoft. It must be set to zero.
    uint[3]       Reserved;
}

///The <b>FAX_ROUTE_CALLBACKROUTINES</b> structure contains pointers to callback functions the fax service provides. A
///fax routing extension's routing methods can call these callback functions to manage the files in the fax file list
///associated with a received fax document.
struct FAX_ROUTE_CALLBACKROUTINES
{
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the <b>FAX_ROUTE_CALLBACKROUTINES</b> structure. The fax
    ///service sets this member to sizeof(FAX_ROUTE_CALLBACKROUTINES). For information about backward compatibility, see
    ///the following Remarks section.
    uint                SizeOfStruct;
    ///Type: <b>PFAXROUTEADDFILE</b> Pointer to a FaxRouteAddFile callback function that a fax routing method uses to
    ///add a file to the fax file list associated with a received fax document.
    PFAXROUTEADDFILE    FaxRouteAddFile;
    ///Type: <b>PFAXROUTEDELETEFILE</b> Pointer to a FaxRouteDeleteFile callback function that a fax routing method uses
    ///to delete a file from the fax file list associated with a received fax document.
    PFAXROUTEDELETEFILE FaxRouteDeleteFile;
    ///Type: <b>PFAXROUTEGETFILE</b> Pointer to a FaxRouteGetFile callback function that a fax routing method uses to
    ///retrieve a specific file name from the fax file list associated with a received fax document.
    PFAXROUTEGETFILE    FaxRouteGetFile;
    ///Type: <b>PFAXROUTEENUMFILES</b> Pointer to a FaxRouteEnumFiles callback function that a fax routing method uses
    ///to enumerate the files in the fax file list associated with a received fax document.
    PFAXROUTEENUMFILES  FaxRouteEnumFiles;
    ///Type: <b>PFAXROUTEMODIFYROUTINGDATA</b> Pointer to a FaxRouteModifyRoutingData callback function that a fax
    ///routing method uses to modify the routing data associated with a subsequent fax routing method.
    PFAXROUTEMODIFYROUTINGDATA FaxRouteModifyRoutingData;
}

///The <b>FAX_ROUTE</b> structure contains information about a received fax document. The fax service passes the
///structure to a fax routing method in a call to the FaxRouteMethod function.
struct FAX_ROUTE
{
    ///Type: <b>DWORD</b> Specifies, in bytes, the size of the <b>FAX_ROUTE</b> structure. Before calling the
    ///FaxRouteMethod function, the fax service sets this member to sizeof(FAX_ROUTE).
    uint          SizeOfStruct;
    ///Type: <b>DWORD</b> Specifies a unique number that identifies the fax job that received the fax document.
    uint          JobId;
    ///Type: <b>DWORDLONG</b> Specifies a 64-bit unsigned integer that is the elapsed time, in UTC, for the fax job that
    ///received the fax document. This parameter represents the total time that elapses between the beginning of fax
    ///reception and the end of fax reception.
    ulong         ElapsedTime;
    ///Type: <b>DWORDLONG</b> Specifies a 64-bit unsigned integer that is the starting time, in UTC, for the fax job
    ///that received the fax document.
    ulong         ReceiveTime;
    ///Type: <b>DWORD</b> Specifies the number of pages in the received fax document.
    uint          PageCount;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the called
    ///station identifier of the local fax device that received the fax document. This identifier is usually a telephone
    ///number.
    const(wchar)* Csid;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the
    ///transmitting station identifier of the remote fax device that sent the fax document. This identifier is usually a
    ///telephone number.
    const(wchar)* Tsid;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that identifies the calling
    ///device that sent the fax document. This string may include the telephone number of the calling device.
    const(wchar)* CallerId;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the routing
    ///string for the received fax document. The string must be of the form:
    ///<code>Canonical-Phone-Number[|Additional-Routing-Info]</code> where <code>Canonical-Phone-Number</code> is
    ///defined in the Address topic of the TAPI documentation (see the Canonical Address subheading); and
    ///<code>Additional-Routing-Info</code> is the <i>subaddress</i> of a Canonical Address, and uses the subaddress
    ///format.
    const(wchar)* RoutingInfo;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the name of
    ///the person who received the fax document.
    const(wchar)* ReceiverName;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the telephone
    ///number of the fax device that received the fax document.
    const(wchar)* ReceiverNumber;
    ///Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the name of
    ///the device that received the fax document.
    const(wchar)* DeviceName;
    ///Type: <b>DWORD</b> Specifies the permanent line identifier for the receiving fax device.
    uint          DeviceId;
    ///Type: <b>LPBYTE</b> Pointer to a buffer that contains additional routing data defined by the routing extension.
    ///For more information, see the following Remarks section.
    ubyte*        RoutingInfoData;
    ///Type: <b>DWORD</b> Specifies the size, in bytes, of the array pointed to by the <b>RoutingInfoData</b> member.
    uint          RoutingInfoDataSize;
}

// Functions

///The <b>FaxConnectFaxServer</b> function connects a fax client application to the local fax server. The function
///returns a fax server handle that is required to call other fax client functions that facilitate job, device,
///configuration, and document management.
///Params:
///    MachineName = Type: <b>LPCTSTR</b> This pointer must be <b>NULL</b> (an empty string), so that the application connects to the
///                  fax server on the local computer.
///    FaxHandle = Type: <b>LPHANDLE</b> Pointer to a variable that receives a fax server handle that is required on subsequent
///                calls to other fax client functions. If the fax server returns a null handle, it indicates an error.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user under whose account the call was made
///    does not have sufficient rights to the fax server. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxConnectFaxServerA(const(char)* MachineName, ptrdiff_t* FaxHandle);

///The <b>FaxConnectFaxServer</b> function connects a fax client application to the local fax server. The function
///returns a fax server handle that is required to call other fax client functions that facilitate job, device,
///configuration, and document management.
///Params:
///    MachineName = Type: <b>LPCTSTR</b> This pointer must be <b>NULL</b> (an empty string), so that the application connects to the
///                  fax server on the local computer.
///    FaxHandle = Type: <b>LPHANDLE</b> Pointer to a variable that receives a fax server handle that is required on subsequent
///                calls to other fax client functions. If the fax server returns a null handle, it indicates an error.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i> parameter is
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> The user under whose account the call was made
///    does not have sufficient rights to the fax server. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxConnectFaxServerW(const(wchar)* MachineName, ptrdiff_t* FaxHandle);

@DllImport("WINFAX")
BOOL FaxClose(HANDLE FaxHandle);

@DllImport("WINFAX")
BOOL FaxOpenPort(HANDLE FaxHandle, uint DeviceId, uint Flags, ptrdiff_t* FaxPortHandle);

///The FaxCompleteJobParams function creates both a FAX_COVERPAGE_INFO structure and a FAX_JOB_PARAM structure for a fax
///client application. This utility function supplies multiple members of these structures with values for the size of
///the structure, the sender's name, and optional billing code information.
///Params:
///    JobParams = Type: <b>PFAX_JOB_PARAM*</b> Pointer to the address of a buffer to contain a FAX_JOB_PARAM structure. On output,
///                this structure contains members with values that are available from the fax server.
///    CoverpageInfo = Type: <b>PFAX_COVERPAGE_INFO*</b> Pointer to the address of a buffer to contain a FAX_COVERPAGE_INFO structure.
///                    On output, this structure contains members with values that are available from the fax server.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("WINFAX")
BOOL FaxCompleteJobParamsA(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);

///The FaxCompleteJobParams function creates both a FAX_COVERPAGE_INFO structure and a FAX_JOB_PARAM structure for a fax
///client application. This utility function supplies multiple members of these structures with values for the size of
///the structure, the sender's name, and optional billing code information.
///Params:
///    JobParams = Type: <b>PFAX_JOB_PARAM*</b> Pointer to the address of a buffer to contain a FAX_JOB_PARAM structure. On output,
///                this structure contains members with values that are available from the fax server.
///    CoverpageInfo = Type: <b>PFAX_COVERPAGE_INFO*</b> Pointer to the address of a buffer to contain a FAX_COVERPAGE_INFO structure.
///                    On output, this structure contains members with values that are available from the fax server.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero.
///    
@DllImport("WINFAX")
BOOL FaxCompleteJobParamsW(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);

///A fax client application calls the <b>FaxSendDocument</b> function to queue a fax job that will transmit an outgoing
///fax transmission.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FileName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
///               path and name of the file that contains the fax document to transmit. The path can be a UNC path or a path that
///               begins with a drive letter. This parameter can contain any valid local file name. The file must be a properly
///               registered file type, and the fax server must be able to access the file.
///    JobParams = Type: <b>PFAX_JOB_PARAM</b> Pointer to a FAX_JOB_PARAM structure that contains the information necessary for the
///                fax server to send the fax transmission. The structure includes, among other items, the recipient's fax number,
///                sender and recipient data, an optional billing code, and job scheduling information.
///    CoverpageInfo = Type: <b>const FAX_COVERPAGE_INFO*</b> Pointer to a FAX_COVERPAGE_INFO structure that contains personal data to
///                    display on the cover page of the fax document. This parameter must be <b>NULL</b> if a cover page is not
///                    required.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive a unique number that identifies the queued job
///               that will send the fax transmission.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>JobParams</i>, or <i>FileName</i> parameters are <b>NULL</b>; the call handle specified by the
///    <b>CallHandle</b> member of the FAX_JOB_PARAM structure is invalid (should be <b>NULL</b>), or the
///    <b>RecipientNumber</b> member in the <b>FAX_JOB_PARAM</b> structure is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i>
///    parameter specifies a remote connection, but the <b>CallHandle</b> member of the FAX_JOB_PARAM structure is not
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. FAX_JOB_SUBMIT access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The fax server cannot locate the file specified
///    by the <i>FileName</i> or the <i>CoverpageInfo</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The fax server cannot process the file specified
///    by the <i>FileName</i> or the <i>CoverpageInfo</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> An attempt was made to hand off a voice call to
///    send a fax, using the <b>CallHandle</b> member of the FAX_JOB_PARAM structure. This functionality is not
///    supported. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSendDocumentA(HANDLE FaxHandle, const(char)* FileName, FAX_JOB_PARAMA* JobParams, 
                      const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);

///A fax client application calls the <b>FaxSendDocument</b> function to queue a fax job that will transmit an outgoing
///fax transmission.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FileName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
///               path and name of the file that contains the fax document to transmit. The path can be a UNC path or a path that
///               begins with a drive letter. This parameter can contain any valid local file name. The file must be a properly
///               registered file type, and the fax server must be able to access the file.
///    JobParams = Type: <b>PFAX_JOB_PARAM</b> Pointer to a FAX_JOB_PARAM structure that contains the information necessary for the
///                fax server to send the fax transmission. The structure includes, among other items, the recipient's fax number,
///                sender and recipient data, an optional billing code, and job scheduling information.
///    CoverpageInfo = Type: <b>const FAX_COVERPAGE_INFO*</b> Pointer to a FAX_COVERPAGE_INFO structure that contains personal data to
///                    display on the cover page of the fax document. This parameter must be <b>NULL</b> if a cover page is not
///                    required.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive a unique number that identifies the queued job
///               that will send the fax transmission.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>JobParams</i>, or <i>FileName</i> parameters are <b>NULL</b>; the call handle specified by the
///    <b>CallHandle</b> member of the FAX_JOB_PARAM structure is invalid (should be <b>NULL</b>), or the
///    <b>RecipientNumber</b> member in the <b>FAX_JOB_PARAM</b> structure is <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i>
///    parameter specifies a remote connection, but the <b>CallHandle</b> member of the FAX_JOB_PARAM structure is not
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. FAX_JOB_SUBMIT access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The fax server cannot locate the file specified
///    by the <i>FileName</i> or the <i>CoverpageInfo</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The fax server cannot process the file specified
///    by the <i>FileName</i> or the <i>CoverpageInfo</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_SUPPORTED</b></dt> </dl> </td> <td width="60%"> An attempt was made to hand off a voice call to
///    send a fax, using the <b>CallHandle</b> member of the FAX_JOB_PARAM structure. This functionality is not
///    supported. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSendDocumentW(HANDLE FaxHandle, const(wchar)* FileName, FAX_JOB_PARAMW* JobParams, 
                      const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);

///A fax client application calls the <b>FaxSendDocumentForBroadcast</b> function to queue several fax jobs that will
///transmit the same outgoing fax transmission to several recipients.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FileName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
///               path and name of the file that contains the fax document to transmit to all recipients. The path can be a UNC
///               path or a path that begins with a drive letter. This parameter can contain any valid local file name. The file
///               must be a properly registered file type, and the fax server must be able to access the file.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the unique number that identifies the queued
///               job that will send the fax transmission.
///    FaxRecipientCallback = Type: <b>PFAX_RECIPIENT_CALLBACK</b> Pointer to a FAX_RECIPIENT_CALLBACK function that retrieves user-specific
///                           information for each designated recipient of the fax transmission. The <b>FaxSendDocumentForBroadcast</b>
///                           function calls the <b>FAX_RECIPIENT_CALLBACK</b> function once for each fax recipient until it returns a value of
///                           zero, indicating that all outbound transmissions have been queued.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. <b>FaxSendDocumentForBroadcast</b> passes this data to the FAX_RECIPIENT_CALLBACK
///              function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>FileName</i>, <i>FaxRecipientCallback</i>, or <i>FaxJobId</i> parameters are <b>NULL</b>, or the
///    <b>RecipientNumber</b> member in the FAX_JOB_PARAM structure is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The fax server cannot locate the file
///    specified by the <i>FileName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The fax server cannot render the file specified
///    by the <i>FileName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    </dl> </td> <td width="60%"> Access is denied. FAX_JOB_SUBMIT access is required. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSendDocumentForBroadcastA(HANDLE FaxHandle, const(char)* FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);

///A fax client application calls the <b>FaxSendDocumentForBroadcast</b> function to queue several fax jobs that will
///transmit the same outgoing fax transmission to several recipients.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FileName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the fully qualified
///               path and name of the file that contains the fax document to transmit to all recipients. The path can be a UNC
///               path or a path that begins with a drive letter. This parameter can contain any valid local file name. The file
///               must be a properly registered file type, and the fax server must be able to access the file.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the unique number that identifies the queued
///               job that will send the fax transmission.
///    FaxRecipientCallback = Type: <b>PFAX_RECIPIENT_CALLBACK</b> Pointer to a FAX_RECIPIENT_CALLBACK function that retrieves user-specific
///                           information for each designated recipient of the fax transmission. The <b>FaxSendDocumentForBroadcast</b>
///                           function calls the <b>FAX_RECIPIENT_CALLBACK</b> function once for each fax recipient until it returns a value of
///                           zero, indicating that all outbound transmissions have been queued.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. <b>FaxSendDocumentForBroadcast</b> passes this data to the FAX_RECIPIENT_CALLBACK
///              function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>FileName</i>, <i>FaxRecipientCallback</i>, or <i>FaxJobId</i> parameters are <b>NULL</b>, or the
///    <b>RecipientNumber</b> member in the FAX_JOB_PARAM structure is <b>NULL</b>. </td> </tr> <tr> <td width="40%">
///    <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt> </dl> </td> <td width="60%"> The fax server cannot locate the file
///    specified by the <i>FileName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The fax server cannot render the file specified
///    by the <i>FileName</i> parameter. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt>
///    </dl> </td> <td width="60%"> Access is denied. FAX_JOB_SUBMIT access is required. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSendDocumentForBroadcastW(HANDLE FaxHandle, const(wchar)* FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);

///The <b>FaxEnumJobs</b> function enumerates all queued and active fax jobs on the fax server to which the client has
///connected. The function returns detailed information for each fax job to the fax client application.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobEntry = Type: <b>PFAX_JOB_ENTRY*</b> Pointer to the address of a buffer to receive an array of FAX_JOB_ENTRY structures.
///               Each structure describes one fax job. The data includes, among other items, the job type and status; recipient
///               and sender identification; scheduling and delivery settings; and the page count. For information about memory
///               allocation, see the following Remarks section.
///    JobsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_JOB_ENTRY structures the
///                   function returns in the <i>JobEntry</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>JobsReturned</i>, <i>JobEntry</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumJobsA(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);

///The <b>FaxEnumJobs</b> function enumerates all queued and active fax jobs on the fax server to which the client has
///connected. The function returns detailed information for each fax job to the fax client application.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobEntry = Type: <b>PFAX_JOB_ENTRY*</b> Pointer to the address of a buffer to receive an array of FAX_JOB_ENTRY structures.
///               Each structure describes one fax job. The data includes, among other items, the job type and status; recipient
///               and sender identification; scheduling and delivery settings; and the page count. For information about memory
///               allocation, see the following Remarks section.
///    JobsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_JOB_ENTRY structures the
///                   function returns in the <i>JobEntry</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>JobsReturned</i>, <i>JobEntry</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumJobsW(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);

///A fax client application calls the <b>FaxGetJob</b> function to retrieve detailed information for the specified
///queued or active fax job. The function returns the information in a FAX_JOB_ENTRY structure.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies a queued or active fax job. The job can be an
///            inbound or an outbound transmission.
///    JobEntry = Type: <b>PFAX_JOB_ENTRY*</b> Pointer to the address of a buffer to receive a FAX_JOB_ENTRY structure. The data
///               includes the job type and status, recipient and sender identification, scheduling and delivery settings, and the
///               page count. For information about memory allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>JobId</i> parameter is invalid, or one or both of the <i>JobEntry</i> or <i>FaxHandle</i>
///    parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetJobA(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);

///A fax client application calls the <b>FaxGetJob</b> function to retrieve detailed information for the specified
///queued or active fax job. The function returns the information in a FAX_JOB_ENTRY structure.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a unique number that identifies a queued or active fax job. The job can be an
///            inbound or an outbound transmission.
///    JobEntry = Type: <b>PFAX_JOB_ENTRY*</b> Pointer to the address of a buffer to receive a FAX_JOB_ENTRY structure. The data
///               includes the job type and status, recipient and sender identification, scheduling and delivery settings, and the
///               page count. For information about memory allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>JobId</i> parameter is invalid, or one or both of the <i>JobEntry</i> or <i>FaxHandle</i>
///    parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl>
///    </td> <td width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetJobW(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);

///A fax client application calls the <b>FaxSetJob</b> function to pause, resume, cancel, or restart a specified fax
///job.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a unique number to identify the fax job to modify.
///            Call the FaxEnumJobs function to retrieve a valid fax job identifier to use in the <i>JobId</i> parameter.
///    Command = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the job command to perform. This parameter
///              can be one of the following values.
///    JobEntry = Type: <b>const FAX_JOB_ENTRY*</b> Not used, must be <b>NULL</b>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_MANAGE access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>FaxHandle</i> parameter is <b>NULL</b>, or one or all of the <i>Command</i>, <i>JobEntry</i>,
///    or <i>JobId</i> parameters are invalid. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetJobA(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);

///A fax client application calls the <b>FaxSetJob</b> function to pause, resume, cancel, or restart a specified fax
///job.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    JobId = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that is a unique number to identify the fax job to modify.
///            Call the FaxEnumJobs function to retrieve a valid fax job identifier to use in the <i>JobId</i> parameter.
///    Command = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that indicates the job command to perform. This parameter
///              can be one of the following values.
///    JobEntry = Type: <b>const FAX_JOB_ENTRY*</b> Not used, must be <b>NULL</b>.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_MANAGE access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> The <i>FaxHandle</i> parameter is <b>NULL</b>, or one or all of the <i>Command</i>, <i>JobEntry</i>,
///    or <i>JobId</i> parameters are invalid. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetJobW(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);

@DllImport("WINFAX")
BOOL FaxGetPageData(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, uint* ImageWidth, 
                    uint* ImageHeight);

///The <b>FaxGetDeviceStatus</b> function returns to a fax client application current status information for the fax
///device of interest. The returned data includes, among other items, device and station identifiers, sender and
///recipient names, and routing information.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    DeviceStatus = Type: <b>PFAX_DEVICE_STATUS*</b> Pointer to the address of a buffer to receive a FAX_DEVICE_STATUS structure. The
///                   structure describes the status of one fax device. For information about memory allocation, see the following
///                   Remarks section
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>DeviceStatus</i> or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetDeviceStatusA(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);

///The <b>FaxGetDeviceStatus</b> function returns to a fax client application current status information for the fax
///device of interest. The returned data includes, among other items, device and station identifiers, sender and
///recipient names, and routing information.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    DeviceStatus = Type: <b>PFAX_DEVICE_STATUS*</b> Pointer to the address of a buffer to receive a FAX_DEVICE_STATUS structure. The
///                   structure describes the status of one fax device. For information about memory allocation, see the following
///                   Remarks section
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>DeviceStatus</i> or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetDeviceStatusW(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);

@DllImport("WINFAX")
BOOL FaxAbort(HANDLE FaxHandle, uint JobId);

///The <b>FaxGetConfiguration</b> function returns to a fax client application the global configuration settings for the
///fax server to which the client has connected. The data includes, among other items, retransmission, branding, archive
///and cover page settings; discount rate periods; and the status of the fax server queue.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FaxConfig = Type: <b>PFAX_CONFIGURATION*</b> Pointer to the address of a buffer to receive a FAX_CONFIGURATION structure. The
///                structure contains the current configuration settings for the fax server. For information about memory
///                allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxConfig</i> or
///    <i>FaxHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetConfigurationA(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);

///The <b>FaxGetConfiguration</b> function returns to a fax client application the global configuration settings for the
///fax server to which the client has connected. The data includes, among other items, retransmission, branding, archive
///and cover page settings; discount rate periods; and the status of the fax server queue.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FaxConfig = Type: <b>PFAX_CONFIGURATION*</b> Pointer to the address of a buffer to receive a FAX_CONFIGURATION structure. The
///                structure contains the current configuration settings for the fax server. For information about memory
///                allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxConfig</i> or
///    <i>FaxHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetConfigurationW(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);

///A fax client application calls the <b>FaxSetConfiguration</b> function to change the global configuration settings
///for the fax server to which the client has connected. The configuration data can include, among other items,
///retransmission, branding, archive and cover page settings; discount rate periods; and the status of the fax server
///queue.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FaxConfig = Type: <b>const FAX_CONFIGURATION*</b> Pointer to a FAX_CONFIGURATION structure. The structure contains data to
///                modify the current fax server configuration settings.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%">
///    Access is denied. FAX_PORT_QUERY access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxConfig</i> parameter is
///    <b>NULL</b>, or the <b>SizeOfStruct</b> member of the specified FAX_CONFIGURATION structure is not equal to
///    <b>sizeof(FAX_CONFIGURATION)</b>. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetConfigurationA(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);

///A fax client application calls the <b>FaxSetConfiguration</b> function to change the global configuration settings
///for the fax server to which the client has connected. The configuration data can include, among other items,
///retransmission, branding, archive and cover page settings; discount rate periods; and the status of the fax server
///queue.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FaxConfig = Type: <b>const FAX_CONFIGURATION*</b> Pointer to a FAX_CONFIGURATION structure. The structure contains data to
///                modify the current fax server configuration settings.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%">
///    Access is denied. FAX_PORT_QUERY access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxConfig</i> parameter is
///    <b>NULL</b>, or the <b>SizeOfStruct</b> member of the specified FAX_CONFIGURATION structure is not equal to
///    <b>sizeof(FAX_CONFIGURATION)</b>. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetConfigurationW(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);

///The <b>FaxGetLoggingCategories</b> function returns to a fax client application the current logging categories for
///the fax server to which the client has connected. A logging category determines the errors or other events the fax
///server records in the application event log.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    Categories = Type: <b>PFAX_LOG_CATEGORY*</b> Pointer to the address of a buffer to receive an array of FAX_LOG_CATEGORY
///                 structures. Each structure describes one current logging category. The data includes the descriptive name of the
///                 logging category, the category number, and the current logging level. For a description of predefined logging
///                 categories and logging levels, see the FAX_LOG_CATEGORY topic. For information about memory allocation, see the
///                 following Remarks section.
///    NumberCategories = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_LOG_CATEGORY structures the
///                       function returns in the <i>Categories</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>Categories</i>, <i>NumberCategories</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetLoggingCategoriesA(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, uint* NumberCategories);

///The <b>FaxGetLoggingCategories</b> function returns to a fax client application the current logging categories for
///the fax server to which the client has connected. A logging category determines the errors or other events the fax
///server records in the application event log.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    Categories = Type: <b>PFAX_LOG_CATEGORY*</b> Pointer to the address of a buffer to receive an array of FAX_LOG_CATEGORY
///                 structures. Each structure describes one current logging category. The data includes the descriptive name of the
///                 logging category, the category number, and the current logging level. For a description of predefined logging
///                 categories and logging levels, see the FAX_LOG_CATEGORY topic. For information about memory allocation, see the
///                 following Remarks section.
///    NumberCategories = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_LOG_CATEGORY structures the
///                       function returns in the <i>Categories</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>Categories</i>, <i>NumberCategories</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetLoggingCategoriesW(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, uint* NumberCategories);

///A fax client application calls the <b>FaxSetLoggingCategories</b> function to modify the current logging categories
///for the fax server to which the client has connected. A logging category determines the errors or other events the
///fax server records in the application event log.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    Categories = Type: <b>const FAX_LOG_CATEGORY*</b> Pointer to an array of FAX_LOG_CATEGORY structures. Each structure contains
///                 the data to modify one logging category. The data includes the descriptive name of the logging category, the
///                 category number, and the current logging level for the category. For a description of predefined logging
///                 categories and logging levels, see the <b>FAX_LOG_CATEGORY</b> topic.
///    NumberCategories = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains the number of FAX_LOG_CATEGORY structures the
///                       function passes in the <i>Categories</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>Categories</i>, or <i>NumberCategories</i> parameters are invalid or <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i>
///    parameter is <b>NULL</b>; or the <i>hWnd</i> parameter is specified but the <i>FaxHandle</i> parameter does not
///    specify a connection with a local fax server; or the <i>MessageStart</i> parameter specifies a message in the
///    range below WM_USER. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. FAX_CONFIG_SET access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetLoggingCategoriesA(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, uint NumberCategories);

///A fax client application calls the <b>FaxSetLoggingCategories</b> function to modify the current logging categories
///for the fax server to which the client has connected. A logging category determines the errors or other events the
///fax server records in the application event log.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    Categories = Type: <b>const FAX_LOG_CATEGORY*</b> Pointer to an array of FAX_LOG_CATEGORY structures. Each structure contains
///                 the data to modify one logging category. The data includes the descriptive name of the logging category, the
///                 category number, and the current logging level for the category. For a description of predefined logging
///                 categories and logging levels, see the <b>FAX_LOG_CATEGORY</b> topic.
///    NumberCategories = Type: <b>DWORD</b> Specifies a <b>DWORD</b> variable that contains the number of FAX_LOG_CATEGORY structures the
///                       function passes in the <i>Categories</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or all of the <i>FaxHandle</i>,
///    <i>Categories</i>, or <i>NumberCategories</i> parameters are invalid or <b>NULL</b>. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i>
///    parameter is <b>NULL</b>; or the <i>hWnd</i> parameter is specified but the <i>FaxHandle</i> parameter does not
///    specify a connection with a local fax server; or the <i>MessageStart</i> parameter specifies a message in the
///    range below WM_USER. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td
///    width="60%"> Access is denied. FAX_CONFIG_SET access is required. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetLoggingCategoriesW(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, uint NumberCategories);

///The <b>FaxEnumPorts</b> function enumerates all fax devices currently attached to the fax server to which the client
///has connected. The function returns detailed information for each fax port to the fax client application.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    PortInfo = Type: <b>PFAX_PORT_INFO*</b> Pointer to the address of a buffer to receive an array of FAX_PORT_INFO structures.
///               Each structure describes one fax port. The data includes, among other items, the permanent line identifier, and
///               the current status and capability of the port. For information about memory allocation, see the following Remarks
///               section.
///    PortsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_PORT_INFO structures the
///                    function returns in the <i>PortInfo</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>PortsReturned</i>, <i>PortInfo</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumPortsA(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);

///The <b>FaxEnumPorts</b> function enumerates all fax devices currently attached to the fax server to which the client
///has connected. The function returns detailed information for each fax port to the fax client application.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    PortInfo = Type: <b>PFAX_PORT_INFO*</b> Pointer to the address of a buffer to receive an array of FAX_PORT_INFO structures.
///               Each structure describes one fax port. The data includes, among other items, the permanent line identifier, and
///               the current status and capability of the port. For information about memory allocation, see the following Remarks
///               section.
///    PortsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_PORT_INFO structures the
///                    function returns in the <i>PortInfo</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_JOB_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>PortsReturned</i>, <i>PortInfo</i>, or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumPortsW(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);

///The <b>FaxGetPort</b> function returns information for a specified fax port to a fax client application. The data
///includes, among other items, the permanent line identifier, the current status and capability of the port, and the
///transmitting and called station identifiers.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    PortInfo = Type: <b>PFAX_PORT_INFO*</b> Pointer to the address of a buffer to receive a FAX_PORT_INFO structure. The
///               structure describes one fax port. For information about memory allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>PortInfo</i> or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetPortA(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);

///The <b>FaxGetPort</b> function returns information for a specified fax port to a fax client application. The data
///includes, among other items, the permanent line identifier, the current status and capability of the port, and the
///transmitting and called station identifiers.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    PortInfo = Type: <b>PFAX_PORT_INFO*</b> Pointer to the address of a buffer to receive a FAX_PORT_INFO structure. The
///               structure describes one fax port. For information about memory allocation, see the following Remarks section.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>PortInfo</i> or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetPortW(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);

///A fax client application calls the <b>FaxSetPort</b> function to change the configuration of the fax port of
///interest. The configuration data can include, among other items, the capability of the port, its priority, rings
///before answer, and the transmitting and called station identifiers..
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    PortInfo = Type: <b>const FAX_PORT_INFO*</b> Pointer to a FAX_PORT_INFO structure. The structure contains data to modify the
///               configuration of the specified fax port.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%">
///    The port indicated by the <i>FaxPortHandle</i> parameter is busy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxPortHandle</i> or
///    <i>PortInfo</i> parameters are <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetPortA(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);

///A fax client application calls the <b>FaxSetPort</b> function to change the configuration of the fax port of
///interest. The configuration data can include, among other items, the capability of the port, its priority, rings
///before answer, and the transmitting and called station identifiers..
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    PortInfo = Type: <b>const FAX_PORT_INFO*</b> Pointer to a FAX_PORT_INFO structure. The structure contains data to modify the
///               configuration of the specified fax port.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_DEVICE_IN_USE</b></dt> </dl> </td> <td width="60%">
///    The port indicated by the <i>FaxPortHandle</i> parameter is busy. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxPortHandle</i> or
///    <i>PortInfo</i> parameters are <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetPortW(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);

///The <b>FaxEnumRoutingMethods</b> function enumerates all fax routing methods for a specific fax device. The function
///returns information about each routing method to a fax client application.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingMethod = Type: <b>PFAX_ROUTING_METHOD*</b> Pointer to the address of a buffer to receive an array of FAX_ROUTING_METHOD
///                    structures. Each structure contains information about one fax routing method. The data includes, among other
///                    items, the name of the DLL that exports the routing method, the GUID and function name that identify the routing
///                    method, and the method's user-friendly name. For information about memory allocation, see the following Remarks
///                    section. For information about fax routing methods, see About the Fax Routing Extension API.
///    MethodsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_ROUTING_METHOD structures
///                      the <b>FaxEnumRoutingMethods</b> function returns in the <i>RoutingMethod</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>MethodsReturned</i>, <i>RoutingMethod</i>, or <i>FaxPortHandle</i> parameters
///    are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumRoutingMethodsA(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, uint* MethodsReturned);

///The <b>FaxEnumRoutingMethods</b> function enumerates all fax routing methods for a specific fax device. The function
///returns information about each routing method to a fax client application.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingMethod = Type: <b>PFAX_ROUTING_METHOD*</b> Pointer to the address of a buffer to receive an array of FAX_ROUTING_METHOD
///                    structures. Each structure contains information about one fax routing method. The data includes, among other
///                    items, the name of the DLL that exports the routing method, the GUID and function name that identify the routing
///                    method, and the method's user-friendly name. For information about memory allocation, see the following Remarks
///                    section. For information about fax routing methods, see About the Fax Routing Extension API.
///    MethodsReturned = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the number of FAX_ROUTING_METHOD structures
///                      the <b>FaxEnumRoutingMethods</b> function returns in the <i>RoutingMethod</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>MethodsReturned</i>, <i>RoutingMethod</i>, or <i>FaxPortHandle</i> parameters
///    are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumRoutingMethodsW(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, uint* MethodsReturned);

///The <b>FaxEnableRoutingMethod</b> function enables or disables a fax routing method for a specific fax device. A fax
///administration application typically calls this function for device management.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    Enabled = Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the application is enabling or disabling
///              the fax routing method specified by the <i>RoutingGuid</i> parameter. If this parameter is <b>TRUE</b>, the
///              application is enabling the routing method; if this parameter is <b>FALSE</b>, the application is disabling the
///              routing method.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxPortHandle</i> or
///    <i>RoutingGuid</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The <i>RoutingGuid</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is
///    denied. FAX_PORT_SET access is required. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnableRoutingMethodA(HANDLE FaxPortHandle, const(char)* RoutingGuid, BOOL Enabled);

///The <b>FaxEnableRoutingMethod</b> function enables or disables a fax routing method for a specific fax device. A fax
///administration application typically calls this function for device management.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    Enabled = Type: <b>BOOL</b> Specifies a Boolean variable that indicates whether the application is enabling or disabling
///              the fax routing method specified by the <i>RoutingGuid</i> parameter. If this parameter is <b>TRUE</b>, the
///              application is enabling the routing method; if this parameter is <b>FALSE</b>, the application is disabling the
///              routing method.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>FaxPortHandle</i> or
///    <i>RoutingGuid</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The <i>RoutingGuid</i> parameter is invalid.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is
///    denied. FAX_PORT_SET access is required. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnableRoutingMethodW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, BOOL Enabled);

///The <b>FaxEnumGlobalRoutingInfo</b> function enumerates all fax routing methods associated with a specific fax
///server. The function returns to the fax client application fax routing method information that applies globally to
///the server, such as routing priority.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RoutingInfo = Type: <b>PFAX_GLOBAL_ROUTING_INFO*</b> Pointer to the address of a buffer to receive an array of
///                  FAX_GLOBAL_ROUTING_INFO structures. Each structure contains information about one fax routing method, as it
///                  pertains to the entire fax service. The data includes, among other items, the priority for the fax routing
///                  method, and the name of the DLL that exports the routing method. It also includes the GUID and function name that
///                  identify the routing method, and the method's user-friendly name. For information about memory allocation, see
///                  the following Remarks section.
///    MethodsReturned = Type: <b>LPDWORD</b> Pointer to a DWORD variable to receive the number of FAX_GLOBAL_ROUTING_INFO structures the
///                      function returns in the <i>RoutingInfo</i> parameter. This number equals the total number of fax routing methods
///                      installed on the target server.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>MethodsReturned</i>, <i>RoutingInfo</i> or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumGlobalRoutingInfoA(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, uint* MethodsReturned);

///The <b>FaxEnumGlobalRoutingInfo</b> function enumerates all fax routing methods associated with a specific fax
///server. The function returns to the fax client application fax routing method information that applies globally to
///the server, such as routing priority.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RoutingInfo = Type: <b>PFAX_GLOBAL_ROUTING_INFO*</b> Pointer to the address of a buffer to receive an array of
///                  FAX_GLOBAL_ROUTING_INFO structures. Each structure contains information about one fax routing method, as it
///                  pertains to the entire fax service. The data includes, among other items, the priority for the fax routing
///                  method, and the name of the DLL that exports the routing method. It also includes the GUID and function name that
///                  identify the routing method, and the method's user-friendly name. For information about memory allocation, see
///                  the following Remarks section.
///    MethodsReturned = Type: <b>LPDWORD</b> Pointer to a DWORD variable to receive the number of FAX_GLOBAL_ROUTING_INFO structures the
///                      function returns in the <i>RoutingInfo</i> parameter. This number equals the total number of fax routing methods
///                      installed on the target server.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>MethodsReturned</i>, <i>RoutingInfo</i> or <i>FaxHandle</i> parameters are
///    <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td
///    width="60%"> An error occurred during memory allocation. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxEnumGlobalRoutingInfoW(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, uint* MethodsReturned);

///A fax management application calls the <b>FaxSetGlobalRoutingInfo</b> function to modify fax routing method data,
///such as routing priority, that applies globally to the fax server.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RoutingInfo = Type: <b>const FAX_GLOBAL_ROUTING_INFO*</b> Pointer to a buffer that contains a FAX_GLOBAL_ROUTING_INFO
///                  structure.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%">
///    The <b>Guid</b> member of the specified FAX_GLOBAL_ROUTING_INFO structure does not correspond to an installed fax
///    routing method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or both of the <i>FaxHandle</i> or <i>RoutingInfo</i> parameters are invalid. </td> </tr>
///    </table>
///    
@DllImport("WINFAX")
BOOL FaxSetGlobalRoutingInfoA(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);

///A fax management application calls the <b>FaxSetGlobalRoutingInfo</b> function to modify fax routing method data,
///such as routing priority, that applies globally to the fax server.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    RoutingInfo = Type: <b>const FAX_GLOBAL_ROUTING_INFO*</b> Pointer to a buffer that contains a FAX_GLOBAL_ROUTING_INFO
///                  structure.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_CONFIG_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%">
///    The <b>Guid</b> member of the specified FAX_GLOBAL_ROUTING_INFO structure does not correspond to an installed fax
///    routing method. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or both of the <i>FaxHandle</i> or <i>RoutingInfo</i> parameters are invalid. </td> </tr>
///    </table>
///    
@DllImport("WINFAX")
BOOL FaxSetGlobalRoutingInfoW(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);

///The <b>FaxGetRoutingInfo</b> function returns to a fax client application routing information for a fax routing
///method that is associated with a specific fax device.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    RoutingInfoBuffer = Type: <b>LPBYTE*</b> Pointer to the address of a buffer to receive the fax routing information.
///    RoutingInfoBufferSize = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the size of the buffer, in bytes, pointed to
///                            by the <i>RoutingInfoBuffer</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>RoutingGuid</i>, <i>RoutingInfoBuffer</i>, <i>RoutingInfoBufferSize</i>, or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The
///    <i>RoutingGuid</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

///The <b>FaxGetRoutingInfo</b> function returns to a fax client application routing information for a fax routing
///method that is associated with a specific fax device.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    RoutingInfoBuffer = Type: <b>LPBYTE*</b> Pointer to the address of a buffer to receive the fax routing information.
///    RoutingInfoBufferSize = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the size of the buffer, in bytes, pointed to
///                            by the <i>RoutingInfoBuffer</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_QUERY access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or all of the <i>RoutingGuid</i>, <i>RoutingInfoBuffer</i>, <i>RoutingInfoBufferSize</i>, or
///    <i>FaxPortHandle</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during memory allocation.
///    </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The
///    <i>RoutingGuid</i> parameter is invalid. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxGetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

///A fax management application calls the <b>FaxSetRoutingInfo</b> function to modify the routing information for a fax
///routing method that is associated with a specific fax device.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    RoutingInfoBuffer = Type: <b>const BYTE*</b> Pointer to a buffer that contains the fax routing information. The routing data is
///                        typically provided by the fax service administration application, a MMC snap-in component.
///    RoutingInfoBufferSize = Type: <b>DWORD</b> Pointer to a <b>DWORD</b> variable that contains the size of the buffer, in bytes, pointed to
///                            by the <i>RoutingInfoBuffer</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The <i>RoutingGuid</i> parameter is invalid.
///    </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetRoutingInfoA(HANDLE FaxPortHandle, const(char)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

///A fax management application calls the <b>FaxSetRoutingInfo</b> function to modify the routing information for a fax
///routing method that is associated with a specific fax device.
///Params:
///    FaxPortHandle = Type: <b>HANDLE</b> Specifies a fax port handle returned by a call to the FaxOpenPort function.
///    RoutingGuid = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that specifies the GUID that uniquely
///                  identifies the fax routing method of interest. For information about fax routing methods, see About the Fax
///                  Routing Extension API. For information about the relationship between routing methods and GUIDs, see Fax Routing
///                  Methods.
///    RoutingInfoBuffer = Type: <b>const BYTE*</b> Pointer to a buffer that contains the fax routing information. The routing data is
///                        typically provided by the fax service administration application, a MMC snap-in component.
///    RoutingInfoBufferSize = Type: <b>DWORD</b> Pointer to a <b>DWORD</b> variable that contains the size of the buffer, in bytes, pointed to
///                            by the <i>RoutingInfoBuffer</i> parameter.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_ACCESS_DENIED</b></dt> </dl> </td> <td width="60%"> Access is denied. FAX_PORT_SET access is
///    required. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td
///    width="60%"> One or more of the parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_DATA</b></dt> </dl> </td> <td width="60%"> The <i>RoutingGuid</i> parameter is invalid.
///    </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxSetRoutingInfoW(HANDLE FaxPortHandle, const(wchar)* RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

@DllImport("WINFAX")
BOOL FaxInitializeEventQueue(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, HWND hWnd, 
                             uint MessageStart);

@DllImport("WINFAX")
void FaxFreeBuffer(void* Buffer);

///A fax client application calls the <b>FaxStartPrintJob</b> function to start printing an outbound fax transmission on
///the specified fax printer.
///Params:
///    PrinterName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the name of a fax
///                  printer. The string can specify one of the following: <ul> <li>A local printer, such as,
///                  "<i>printername</i>"</li> <li>A network printer, such as "&
///    PrintInfo = Type: <b>const FAX_PRINT_INFO*</b> Pointer to a FAX_PRINT_INFO structure that contains the information necessary
///                for the fax server to print the fax transmission. The structure includes, among other items, the recipient's fax
///                number, sender and recipient data, an optional billing code, and delivery report information. For more
///                information, see the following Remarks section.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the print spooler's unique ID for the fax
///               print job. (This is not the same as the fax queue's ID for the job and it cannot be used as a parameter in any
///               fax API that takes a fax ID parameter.) This parameter is required.
///    FaxContextInfo = Type: <b>PFAX_CONTEXT_INFO</b> Pointer to a FAX_CONTEXT_INFO structure to receive a handle to a printer device
///                     context. When the fax client application calls the FaxPrintCoverPage function, it must pass this value in that
///                     function's <i>FaxContextInfo</i> parameter. For more information, see Device Contexts and the Printing and Print
///                     Spooler Reference.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>PrintInfo</i> or
///    <i>FaxContextInfo</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>RecipientNumber</b> member of the
///    FAX_PRINT_INFO structure is <b>NULL</b>; or the <b>OutputFileName</b> member is <b>NULL</b> and the
///    <b>RecipientNumber</b> member is not specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PRINTER_NAME</b></dt> </dl> </td> <td width="60%"> The <i>PrinterName</i> parameter
///    specifies a printer that is not a fax printer, or there is no fax printer installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during
///    memory allocation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SPL_NO_STARTDOC</b></dt> </dl> </td> <td
///    width="60%"> FaxStartPrintJob was not called first, hence there was no StartDoc call. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxStartPrintJobA(const(char)* PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOA* FaxContextInfo);

///A fax client application calls the <b>FaxStartPrintJob</b> function to start printing an outbound fax transmission on
///the specified fax printer.
///Params:
///    PrinterName = Type: <b>LPCTSTR</b> Pointer to a constant null-terminated character string that contains the name of a fax
///                  printer. The string can specify one of the following: <ul> <li>A local printer, such as,
///                  "<i>printername</i>"</li> <li>A network printer, such as "&
///    PrintInfo = Type: <b>const FAX_PRINT_INFO*</b> Pointer to a FAX_PRINT_INFO structure that contains the information necessary
///                for the fax server to print the fax transmission. The structure includes, among other items, the recipient's fax
///                number, sender and recipient data, an optional billing code, and delivery report information. For more
///                information, see the following Remarks section.
///    FaxJobId = Type: <b>LPDWORD</b> Pointer to a <b>DWORD</b> variable to receive the print spooler's unique ID for the fax
///               print job. (This is not the same as the fax queue's ID for the job and it cannot be used as a parameter in any
///               fax API that takes a fax ID parameter.) This parameter is required.
///    FaxContextInfo = Type: <b>PFAX_CONTEXT_INFO</b> Pointer to a FAX_CONTEXT_INFO structure to receive a handle to a printer device
///                     context. When the fax client application calls the FaxPrintCoverPage function, it must pass this value in that
///                     function's <i>FaxContextInfo</i> parameter. For more information, see Device Contexts and the Printing and Print
///                     Spooler Reference.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>PrintInfo</i> or
///    <i>FaxContextInfo</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>RecipientNumber</b> member of the
///    FAX_PRINT_INFO structure is <b>NULL</b>; or the <b>OutputFileName</b> member is <b>NULL</b> and the
///    <b>RecipientNumber</b> member is not specified. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PRINTER_NAME</b></dt> </dl> </td> <td width="60%"> The <i>PrinterName</i> parameter
///    specifies a printer that is not a fax printer, or there is no fax printer installed. </td> </tr> <tr> <td
///    width="40%"> <dl> <dt><b>ERROR_NOT_ENOUGH_MEMORY</b></dt> </dl> </td> <td width="60%"> An error occurred during
///    memory allocation. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_SPL_NO_STARTDOC</b></dt> </dl> </td> <td
///    width="60%"> FaxStartPrintJob was not called first, hence there was no StartDoc call. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxStartPrintJobW(const(wchar)* PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOW* FaxContextInfo);

///The <b>FaxPrintCoverPage</b> function prints a fax transmission cover page to the specified device context for a fax
///client application.
///Params:
///    FaxContextInfo = Type: <b>const FAX_CONTEXT_INFO*</b> Pointer to a FAX_CONTEXT_INFO structure that contains a handle to a fax
///                     printer device context.
///    CoverPageInfo = Type: <b>const FAX_COVERPAGE_INFO*</b> Pointer to a FAX_COVERPAGE_INFO structure that contains personal data to
///                    display on the cover page of the fax document.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>CoverPageInfo</i> or
///    <i>FaxContextInfo</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>SizeOfStruct</b> member of the
///    specified FAX_COVERPAGE_INFO structure is not equal to <b>sizeof(FAX_COVERPAGE_INFO)</b>; or the
///    <b>SizeOfStruct</b> member of the specified FAX_CONTEXT_INFO structure is not equal to
///    <b>sizeof(FAX_CONTEXT_INFO)</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The fax server cannot locate the file specified by the <b>CoverPageName</b> member
///    of the FAX_COVERPAGE_INFO structure. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxPrintCoverPageA(const(FAX_CONTEXT_INFOA)* FaxContextInfo, const(FAX_COVERPAGE_INFOA)* CoverPageInfo);

///The <b>FaxPrintCoverPage</b> function prints a fax transmission cover page to the specified device context for a fax
///client application.
///Params:
///    FaxContextInfo = Type: <b>const FAX_CONTEXT_INFO*</b> Pointer to a FAX_CONTEXT_INFO structure that contains a handle to a fax
///                     printer device context.
///    CoverPageInfo = Type: <b>const FAX_COVERPAGE_INFO*</b> Pointer to a FAX_COVERPAGE_INFO structure that contains personal data to
///                    display on the cover page of the fax document.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> One or both of the <i>CoverPageInfo</i> or
///    <i>FaxContextInfo</i> parameters are <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> The <b>SizeOfStruct</b> member of the
///    specified FAX_COVERPAGE_INFO structure is not equal to <b>sizeof(FAX_COVERPAGE_INFO)</b>; or the
///    <b>SizeOfStruct</b> member of the specified FAX_CONTEXT_INFO structure is not equal to
///    <b>sizeof(FAX_CONTEXT_INFO)</b>. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>ERROR_FILE_NOT_FOUND</b></dt>
///    </dl> </td> <td width="60%"> The fax server cannot locate the file specified by the <b>CoverPageName</b> member
///    of the FAX_COVERPAGE_INFO structure. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxPrintCoverPageW(const(FAX_CONTEXT_INFOW)* FaxContextInfo, const(FAX_COVERPAGE_INFOW)* CoverPageInfo);

///The <b>FaxRegisterServiceProvider</b> function registers a fax service provider DLL with the fax service. The
///function configures the fax service registry to query and use the new fax service provider DLL when the fax service
///restarts.
///Params:
///    DeviceProvider = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the internal
///                     name of the fax service provider DLL to register. This should be a unique string, such as a GUID.
///    FriendlyName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string to associate with the fax
///                   service provider DLL. This is the fax service provider's user-friendly name, suitable for display.
///    ImageName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the full path
///                and file name for the fax service provider DLL. The path can include valid environment variables, for example,
///                %SYSTEMDRIVE% and %SYSTEMROOT%.
///    TspName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the name of
///              the telephony service provider associated with the devices for the fax service provider. For a virtual fax
///              device, use an empty string.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one parameter to the
///    FaxRegisterServiceProvider function is <b>NULL</b>. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxRegisterServiceProviderW(const(wchar)* DeviceProvider, const(wchar)* FriendlyName, const(wchar)* ImageName, 
                                 const(wchar)* TspName);

@DllImport("WINFAX")
BOOL FaxUnregisterServiceProviderW(const(wchar)* DeviceProvider);

///The <b>FaxRegisterRoutingExtension</b> function registers a fax routing extension DLL with the fax service. The
///function configures the fax service registry to use the new routing extension DLL.
///Params:
///    FaxHandle = Type: <b>HANDLE</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    ExtensionName = Type: <b>LPCWSTR</b> Specifies a fax server handle returned by a call to the FaxConnectFaxServer function.
///    FriendlyName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string to associate with the fax
///                   routing extension DLL. This is the routing extension's user-friendly name, suitable for display.
///    ImageName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated Unicode character string that specifies the full path
///                and file name for the fax routing extension DLL. The path can include valid environment variables, for example,
///                %SYSTEMDRIVE% and %SYSTEMROOT%.
///    CallBack = Type: <b>PFAX_ROUTING_INSTALLATION_CALLBACK</b> Pointer to a FaxRoutingInstallationCallback function that
///               installs a fax routing method for the specified fax routing extension DLL. The <b>FaxRegisterRoutingExtension</b>
///               function calls the <b>FaxRoutingInstallationCallback</b> function multiple times, until it returns a value of
///               zero, indicating that all routing methods in the fax routing extension DLL have been registered.
///    Context = Type: <b>LPVOID</b> Pointer to a variable that contains application-specific context information or an
///              application-defined value. <b>FaxRegisterRoutingExtension</b> passes this data to the
///              FaxRoutingInstallationCallback function.
///Returns:
///    Type: <b>BOOL</b> If the function succeeds, the return value is nonzero. If the function fails, the return value
///    is zero. To get extended error information, call GetLastError. GetLastError can return one of the following
///    errors. <table> <tr> <th>Return code</th> <th>Description</th> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_PARAMETER</b></dt> </dl> </td> <td width="60%"> At least one parameter to the
///    FaxRegisterRoutingExtension function is <b>NULL</b>. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>ERROR_INVALID_FUNCTION</b></dt> </dl> </td> <td width="60%"> The <i>FaxHandle</i> specifies a remote fax
///    server connection. </td> </tr> </table>
///    
@DllImport("WINFAX")
BOOL FaxRegisterRoutingExtensionW(HANDLE FaxHandle, const(wchar)* ExtensionName, const(wchar)* FriendlyName, 
                                  const(wchar)* ImageName, PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, 
                                  void* Context);

@DllImport("WINFAX")
BOOL FaxAccessCheck(HANDLE FaxHandle, uint AccessMask);

///Called by an application to determine whether to make a menu item or other UI available that calls the Windows Vista
///function SendToFaxRecipient.
///Returns:
///    Type: <b>BOOL</b> <b>TRUE</b>, if the following conditions are met; otherwise <b>FALSE</b>. <ul> <li>The
///    operating system is Windows Vista or later.</li> <li>The fax service is installed.</li> <li>The current user has
///    a fax account setup with the fax service.</li> </ul>
///    
@DllImport("fxsutility")
BOOL CanSendToFaxRecipient();

///Called by an application to fax a file.
///Params:
///    sndMode = Type: <b>SendToMode</b> A value specifying how to send the fax. For Windows Vista, this must be
///              SEND_TO_FAX_RECIPIENT_ATTACHMENT.
///    lpFileName = Type: <b>LPCWSTR</b> Pointer to a constant null-terminated string representing the name of the file to fax.
///Returns:
///    Type: <b>DWORD</b> Zero, if the operation is successful.
///    
@DllImport("fxsutility")
uint SendToFaxRecipient(SendToMode sndMode, const(wchar)* lpFileName);


// Interfaces

@GUID("CDA8ACB0-8CF5-4F6C-9BA2-5931D40C8CAE")
struct FaxServer;

@GUID("EB8FE768-875A-4F5F-82C5-03F23AAC1BD7")
struct FaxDeviceProviders;

@GUID("5589E28E-23CB-4919-8808-E6101846E80D")
struct FaxDevices;

@GUID("E80248ED-AD65-4218-8108-991924D4E7ED")
struct FaxInboundRouting;

@GUID("C35211D7-5776-48CB-AF44-C31BE3B2CFE5")
struct FaxFolders;

@GUID("1BF9EEA6-ECE0-4785-A18B-DE56E9EEF96A")
struct FaxLoggingOptions;

@GUID("CFEF5D0E-E84D-462E-AABB-87D31EB04FEF")
struct FaxActivity;

@GUID("C81B385E-B869-4AFD-86C0-616498ED9BE2")
struct FaxOutboundRouting;

@GUID("6982487B-227B-4C96-A61C-248348B05AB6")
struct FaxReceiptOptions;

@GUID("10C4DDDE-ABF0-43DF-964F-7F3AC21A4C7B")
struct FaxSecurity;

@GUID("0F3F9F91-C838-415E-A4F3-3E828CA445E0")
struct FaxDocument;

@GUID("265D84D0-1850-4360-B7C8-758BBB5F0B96")
struct FaxSender;

@GUID("EA9BDF53-10A9-4D4F-A067-63C8F84F01B0")
struct FaxRecipients;

@GUID("8426C56A-35A1-4C6F-AF93-FC952422E2C2")
struct FaxIncomingArchive;

@GUID("69131717-F3F1-40E3-809D-A6CBF7BD85E5")
struct FaxIncomingQueue;

@GUID("43C28403-E04F-474D-990C-B94669148F59")
struct FaxOutgoingArchive;

@GUID("7421169E-8C43-4B0D-BB16-645C8FA40357")
struct FaxOutgoingQueue;

@GUID("6088E1D8-3FC8-45C2-87B1-909A29607EA9")
struct FaxIncomingMessageIterator;

@GUID("1932FCF7-9D43-4D5A-89FF-03861B321736")
struct FaxIncomingMessage;

@GUID("92BF2A6C-37BE-43FA-A37D-CB0E5F753B35")
struct FaxOutgoingJobs;

@GUID("71BB429C-0EF9-4915-BEC5-A5D897A3E924")
struct FaxOutgoingJob;

@GUID("8A3224D0-D30B-49DE-9813-CB385790FBBB")
struct FaxOutgoingMessageIterator;

@GUID("91B4A378-4AD8-4AEF-A4DC-97D96E939A3A")
struct FaxOutgoingMessage;

@GUID("A1BB8A43-8866-4FB7-A15D-6266C875A5CC")
struct FaxIncomingJobs;

@GUID("C47311EC-AE32-41B8-AE4B-3EAE0629D0C9")
struct FaxIncomingJob;

@GUID("17CF1AA3-F5EB-484A-9C9A-4440A5BAABFC")
struct FaxDeviceProvider;

@GUID("59E3A5B2-D676-484B-A6DE-720BFA89B5AF")
struct FaxDevice;

@GUID("F0A0294E-3BBD-48B8-8F13-8C591A55BDBC")
struct FaxActivityLogging;

@GUID("A6850930-A0F6-4A6F-95B7-DB2EBF3D02E3")
struct FaxEventLogging;

@GUID("CCBEA1A5-E2B4-4B57-9421-B04B6289464B")
struct FaxOutboundRoutingGroups;

@GUID("0213F3E0-6791-4D77-A271-04D2357C50D6")
struct FaxOutboundRoutingGroup;

@GUID("CDC539EA-7277-460E-8DE0-48A0A5760D1F")
struct FaxDeviceIds;

@GUID("D385BECA-E624-4473-BFAA-9F4000831F54")
struct FaxOutboundRoutingRules;

@GUID("6549EEBF-08D1-475A-828B-3BF105952FA0")
struct FaxOutboundRoutingRule;

@GUID("189A48ED-623C-4C0D-80F2-D66C7B9EFEC2")
struct FaxInboundRoutingExtensions;

@GUID("1D7DFB51-7207-4436-A0D9-24E32EE56988")
struct FaxInboundRoutingExtension;

@GUID("25FCB76A-B750-4B82-9266-FBBBAE8922BA")
struct FaxInboundRoutingMethods;

@GUID("4B9FD75C-0194-4B72-9CE5-02A8205AC7D4")
struct FaxInboundRoutingMethod;

@GUID("7BF222F4-BE8D-442F-841D-6132742423BB")
struct FaxJobStatus;

@GUID("60BF3301-7DF8-4BD8-9148-7B5801F9EFDF")
struct FaxRecipient;

@GUID("5857326F-E7B3-41A7-9C19-A91B463E2D56")
struct FaxConfiguration;

@GUID("FBC23C4B-79E0-4291-BC56-C12E253BBF3A")
struct FaxAccountSet;

@GUID("DA1F94AA-EE2C-47C0-8F4F-2A217075B76E")
struct FaxAccounts;

@GUID("A7E0647F-4524-4464-A56D-B9FE666F715E")
struct FaxAccount;

@GUID("85398F49-C034-4A3F-821C-DB7D685E8129")
struct FaxAccountFolders;

@GUID("9BCF6094-B4DA-45F4-B8D6-DDEB2186652C")
struct FaxAccountIncomingQueue;

@GUID("FEECEEFB-C149-48BA-BAB8-B791E101F62F")
struct FaxAccountOutgoingQueue;

@GUID("14B33DB5-4C40-4ECF-9EF8-A360CBE809ED")
struct FaxAccountIncomingArchive;

@GUID("851E7AF5-433A-4739-A2DF-AD245C2CB98E")
struct FaxAccountOutgoingArchive;

@GUID("735C1248-EC89-4C30-A127-656E92E3C4EA")
struct FaxSecurity2;

///The <b>IFaxJobStatus</b> interface is used for notifications and to hold the dynamic information of the job. Dynamic
///information is data that changes as a job progresses. This may include the current job status, the page that is
///currently being transmitted, and the number of attempts the fax service has made to transmit the job (retries). The
///fax service uses this object to notify a fax client application of job updates. For more information, see Fax Job
///Status.
@GUID("8B86F485-FD7F-4824-886B-40C5CAA617CC")
interface IFaxJobStatus : IDispatch
{
    ///The <b>Status</b> property is a number that indicates the current status of fax job in the job queue. This
    ///property is read-only.
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    ///The <b>Pages</b> property is a number that indicates the total number of pages received so far in the fax
    ///transmission. This property is read-only.
    HRESULT get_Pages(int* plPages);
    ///The <b>Size</b> property is a value that indicates the number of bytes of the Tagged Image File Format Class F
    ///(TIFF Class F) file received so far for the fax job. This property is read-only.
    HRESULT get_Size(int* plSize);
    ///The <b>CurrentPage</b> property is a number that identifies the page that the fax service is actively processing.
    ///This property is read-only.
    HRESULT get_CurrentPage(int* plCurrentPage);
    ///The <b>DeviceId</b> property indicates the device ID of the device associated with the fax job. This property is
    ///read-only.
    HRESULT get_DeviceId(int* plDeviceId);
    ///The <b>CSID</b> property is a null-terminated string that contains the called station identifier (CSID) for the
    ///job. This property is read-only.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>TSID</b> property is a null-terminated string that contains the transmitting station identifier (TSID)
    ///associated with the fax job. This property is read-only.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>ExtendedStatusCode</b> property specifies a code describing the job's extended status. This property is
    ///read-only.
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    ///The <b>ExtendedStatus</b> property is a null-terminated string that describes the job's extended status. This
    ///property is read-only.
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    ///The <b>AvailableOperations</b> property indicates the combination of valid operations that you can perform on the
    ///fax job, given its current status. This property is read-only.
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    ///The <b>Retries</b> property is a value that indicates the number of times that the fax service attempted to
    ///transmit a fax job when the initial attempt failed. This property is read-only.
    HRESULT get_Retries(int* plRetries);
    ///The <b>JobType</b> property describes the type of fax job; for example, the job can be a receive job, a send job,
    ///or a routing job. This property is read-only.
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    ///The <b>ScheduledTime</b> property indicates the time that the fax job is scheduled for transmission. This
    ///property is read-only.
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    ///The <b>TransmissionStart</b> property indicates the time that the fax job began transmitting. This property is
    ///read-only.
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    ///The <b>TransmissionEnd</b> property indicates the time that the fax job completed transmission. This property is
    ///read-only.
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    ///The <b>CallerId</b> property is a null-terminated string that identifies the calling device associated with the
    ///fax job. This property is read-only.
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    ///The <b>RoutingInformation</b> property is a null-terminated string that specifies the routing information for the
    ///fax job. This property is read-only.
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
}

///The <b>IFaxServer</b> interface describes a messaging collection that is used by a fax client application to manage a
///connection to the fax service. The object includes methods to create and terminate connections with a fax server, and
///to retrieve information about a connected fax server. The object also includes methods to store extension
///configuration properties.
@GUID("475B6469-90A5-4878-A577-17A86E8E3462")
interface IFaxServer : IDispatch
{
    ///The <b>IFaxServer::Connect</b> method connects a fax client application to the specified fax server.
    ///Params:
    ///    bstrServerName = Type: <b>BSTR</b> A null-terminated string that specifies the name of the target fax server, such as
    ///                     "computername". If this parameter is <b>NULL</b> or an empty string, the method connects the application to
    ///                     the fax server on the local computer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Connect(BSTR bstrServerName);
    ///The <b>IFaxServer::get_ServerName</b> property retrieves the name of the active fax server to which the fax
    ///client is connected. This property is read-only.
    HRESULT get_ServerName(BSTR* pbstrServerName);
    ///The <b>IFaxServer::GetDeviceProviders</b> method creates a IFaxDeviceProviders interface, a collection of fax
    ///service providers (FSPs) that are currently registered with the fax service. You can use the
    ///<b>IFaxDeviceProviders</b> interface to enumerate the FSPs associated with a fax server and to create and access
    ///IFaxDeviceProvider interfaces for them.
    ///Params:
    ///    ppFaxDeviceProviders = Type: <b>IFaxDeviceProviders**</b> An address of a pointer that receives a IFaxDeviceProviders interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDeviceProviders(IFaxDeviceProviders* ppFaxDeviceProviders);
    ///The <b>IFaxServer::GetDevices</b> method creates a IFaxDevices interface, a collection of all the fax devices
    ///exposed by all the fax service providers (FSPs) currently registered with the fax service.
    ///Params:
    ///    ppFaxDevices = Type: <b>IFaxDevices**</b> An address of a pointer that receives a IFaxDevices interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetDevices(IFaxDevices* ppFaxDevices);
    ///The <b>IFaxServer::get_InboundRouting</b> property creates a IFaxInboundRouting configuration interface. The
    ///interface permits access to an inbound fax routing extension and its methods. This property is read-only.
    HRESULT get_InboundRouting(IFaxInboundRouting* ppFaxInboundRouting);
    ///The <b>IFaxServer::get_Folders</b> property accesses a IFaxFolders configuration interface. You can use the
    ///interface to access the folders, jobs, and messages on a connected fax server. This property is read-only.
    HRESULT get_Folders(IFaxFolders* pFaxFolders);
    ///The <b>IFaxServer::get_LoggingOptions</b> property creates a IFaxLoggingOptions configuration interface. The
    ///interface permits configuration of both the activity logging options and the event logging categories that the
    ///fax service uses. This property is read-only.
    HRESULT get_LoggingOptions(IFaxLoggingOptions* ppFaxLoggingOptions);
    ///The <b>IFaxServer::get_MajorVersion</b> property is a value that specifies the major part of the version number
    ///for the fax service. This property is read-only.
    HRESULT get_MajorVersion(int* plMajorVersion);
    ///The <b>IFaxServer::get_MinorVersion</b> property is a value that specifies the minor part of the version number
    ///for the fax service. This property is read-only.
    HRESULT get_MinorVersion(int* plMinorVersion);
    ///The <b>IFaxServer::get_MajorBuild</b> property is a value that specifies the major part of the build number for
    ///the fax service. This property is read-only.
    HRESULT get_MajorBuild(int* plMajorBuild);
    ///The <b>IFaxServer::get_MinorBuild</b> property is a value that specifies the minor part of the build number for
    ///the fax service. This property is read-only.
    HRESULT get_MinorBuild(int* plMinorBuild);
    ///The <b>IFaxServer::get_Debug</b> property is a Boolean value that indicates whether the fax server was created in
    ///a debug environment. This property is read-only.
    HRESULT get_Debug(short* pbDebug);
    ///The <b>IFaxServer::get_Activity</b> property creates a IFaxActivity interface object. The interface permits a fax
    ///client application to access information about the activity on a connected fax server, and the fax server status.
    ///This property is read-only.
    HRESULT get_Activity(IFaxActivity* ppFaxActivity);
    ///The <b>IFaxServer::get_OutboundRouting</b> property creates a IFaxOutboundRouting configuration interface. The
    ///interface permits users to configure outbound routing groups and rules. This property is read-only.
    HRESULT get_OutboundRouting(IFaxOutboundRouting* ppFaxOutboundRouting);
    ///The <b>IFaxServer::get_ReceiptOptions</b> property creates a IFaxReceiptOptions configuration interface. The
    ///object permits a fax client application to set and retrieve the receipt configuration that the fax service uses
    ///to send fax receipts. This property is read-only.
    HRESULT get_ReceiptOptions(IFaxReceiptOptions* ppFaxReceiptOptions);
    ///The <b>IFaxServer::get_Security</b> property creates a IFaxSecurity configuration interface. The interface
    ///permits the calling application to set and retrieve a security descriptor for the fax server. This property is
    ///read-only.
    HRESULT get_Security(IFaxSecurity* ppFaxSecurity);
    ///The <b>IFaxServer::Disconnect</b> method terminates a fax client application's connection to a fax server. The
    ///method fails if the client is not connected to an active fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Disconnect();
    ///The <b>IFaxServer::GetExtensionProperty</b> method retrieves an extension configuration property stored at the
    ///server level.
    ///Params:
    ///    bstrGUID = Type: [in] <b>BSTR</b> Specifies a string GUID that uniquely identifies the data to be retrieved.
    ///    pvProperty = Type: <b>VARIANT*</b> Pointer to a variable that receives a VARIANT that specifies the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    ///The <b>IFaxServer::SetExtensionProperty</b> method stores an extension configuration property at the server
    ///level.
    ///Params:
    ///    bstrGUID = Type: <b>BSTR</b> Specifies a string GUID that identifies the data to set.
    ///    vProperty = Type: <b>VARIANT</b> VARIANT that specifies the data to be set.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    ///The <b>IFaxServer::ListenToServerEvents</b> method registers the FaxServer object to receive notifications about
    ///one or more types of server events, or to stop these notifications.
    ///Params:
    ///    EventTypes = Type: <b>FAX_SERVER_EVENTS_TYPE_ENUM</b> A value that contains a set of bit flags representing the types of
    ///                 events for which the FaxServer object is registering to receive notifications. For more information, see
    ///                 FAX_SERVER_EVENTS_TYPE_ENUM.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ListenToServerEvents(FAX_SERVER_EVENTS_TYPE_ENUM EventTypes);
    ///The <b>IFaxServer::RegisterDeviceProvider</b> method registers a fax service provider (FSP) with the fax service.
    ///Registration takes place after the fax service restarts.
    ///Params:
    ///    bstrGUID = Type: <b>BSTR</b> Null-terminated string that contains the GUID that uniquely identifies the FSP that is
    ///               registering.
    ///    bstrFriendlyName = Type: <b>BSTR</b> Null-terminated string that contains the user-friendly name to display for the FSP that is
    ///                       registering.
    ///    bstrImageName = Type: <b>BSTR</b> Null-terminated string that contains the fully qualified path and file name of the FSPÂ
    ///                    DLL.
    ///    TspName = Type: <b>BSTR</b> Null-terminated string that contains the name of the telephony service provider associated
    ///              with the devices for the FSP.
    ///    lFSPIVersion = Type: <b>long</b> A <b>long</b> value that indicates the version of the FSP. Should be equal to 0x00010000.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterDeviceProvider(BSTR bstrGUID, BSTR bstrFriendlyName, BSTR bstrImageName, BSTR TspName, 
                                   int lFSPIVersion);
    ///The <b>IFaxServer::UnregisterDeviceProvider</b> method unregisters (removes the registration of) an existing
    ///device provider. Unregistration will take place only after the fax server is restarted.
    ///Params:
    ///    bstrUniqueName = Type: <b>BSTR</b> Required. Specifies the unique name that identifies the FSP that is unregistering.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UnregisterDeviceProvider(BSTR bstrUniqueName);
    ///The <b>IFaxServer::RegisterInboundRoutingExtension</b> method registers a fax inbound routing extension with the
    ///fax service. Registration takes place after the fax service restarts.
    ///Params:
    ///    bstrExtensionName = Type: <b>BSTR</b> String that specifies the internal name of the fax routing extension DLL.
    ///    bstrFriendlyName = Type: <b>BSTR</b> String to associate with the fax routing extension DLL. This is the routing extension's
    ///                       user-friendly name, suitable for display.
    ///    bstrImageName = Type: <b>BSTR</b> String that specifies the full path and file name for the fax routing extension DLL. The
    ///                    path can include valid environment variables, for example, %SYSTEMDRIVE% and %SYSTEMROOT%.
    ///    vMethods = Type: <b>VARIANT</b> VARIANT that specifies a safearray of <b>BSTR</b>s. The array must be unidimensional, it
    ///               cannot be empty, and it must have a lower limit of zero. Each item (string) in the array must identify a
    ///               routing method. The string must have the following format: Method name; Friendly name; Function Name; Method
    ///               GUID
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RegisterInboundRoutingExtension(BSTR bstrExtensionName, BSTR bstrFriendlyName, BSTR bstrImageName, 
                                            VARIANT vMethods);
    ///The <b>IFaxServer::UnregisterInboundRoutingExtension</b> method unregisters an existing inbound routing
    ///extension. Unregistration will take place only after the fax server is restarted.
    ///Params:
    ///    bstrExtensionUniqueName = Type: <b>BSTR</b> String value that specifies the internal name of the fax routing extension DLL.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UnregisterInboundRoutingExtension(BSTR bstrExtensionUniqueName);
    ///The <b>IFaxServer::get_RegisteredEvents</b> property is a value from an enumeration that indicates the types of
    ///fax service events a client application is listening for. This property is read-only.
    HRESULT get_RegisteredEvents(FAX_SERVER_EVENTS_TYPE_ENUM* pEventTypes);
    ///The <b>IFaxServer::get_APIVersion</b> property is a value that indicates the version of the fax server API. This
    ///property is read-only.
    HRESULT get_APIVersion(FAX_SERVER_APIVERSION_ENUM* pAPIVersion);
}

///The <b>IFaxDeviceProviders</b> interface defines a configuration collection which contains the fax device providers
///on a connected fax server. This collection is used by a fax client application to retrieve information about the fax
///service providers (FSPs) registered with the fax service, represented by FaxDeviceProvider objects.
@GUID("9FB76F62-4C7E-43A5-B6FD-502893F7E13E")
interface IFaxDeviceProviders : IDispatch
{
    ///The <b>IFaxDeviceProviders::get__NewEnum</b> method returns a reference to an enumerator object that you can use
    ///to iterate through the FaxDeviceProviders collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxDeviceProviders::get_Item</b> property returns a FaxDeviceProvider object from the FaxDeviceProviders
    ///collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies the item to retrieve from the collection. If this
    ///             parameter is type VT_I2 or VT_I4, the parameter specifies the index of the item to retrieve from the
    ///             collection. The index is 1-based. If this parameter is type VT_BSTR, the parameter is the unique name that
    ///             identifies the FSP to retrieve. Other types are not supported.
    ///    pFaxDeviceProvider = Type: <b>IFaxDeviceProvider**</b> Address of a pointer to a IFaxDeviceProvider interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxDeviceProvider* pFaxDeviceProvider);
    ///The Count property represents the number of objects in the FaxDeviceProviders collection. This is the total
    ///number of fax device providers associated with the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///The <b>IFaxDevices</b> interface defines a collection used by a fax client application to manage fax devices, where
///each device is represented by a FaxDevice object.
@GUID("9E46783E-F34F-482E-A360-0416BECBBD96")
interface IFaxDevices : IDispatch
{
    ///The <b>IFaxDevices::get__NewEnum</b> method returns a reference to an enumerator object that you can use to
    ///iterate through the FaxDevices collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxDevices::get_Item</b> method returns a FaxDevice object from the FaxDevices collection, using its
    ///index.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies the index of the item to retrieve from the fax device
    ///             collection. If this parameter is type VT_I2 or VT_I4, the parameter specifies the index of the item to
    ///             retrieve from the collection. Valid values for the index are in the range from 1 to n, where n is the number
    ///             of devices returned by a call to the IFaxDevices::get_Count method. If this parameter is type VT_BSTR, the
    ///             parameter is a string containing the unique name of the fax device to retrieve. Other types are not
    ///             supported.
    ///    pFaxDevice = Type: <b>IFaxDevice**</b> Receives the address of a pointer to a FaxDevice object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxDevice* pFaxDevice);
    ///The <b>IFaxDevices::get_Count</b> property represents the number of objects in the FaxDevices collection. This is
    ///the total number of devices used by the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
    ///The <b>IFaxDevices::get_ItemById</b> method returns a FaxDevice object from the FaxDevices collection, using its
    ///device ID.
    ///Params:
    ///    lId = Type: <b>long</b> The unique ID of the device to retrieve.
    ///    ppFaxDevice = Type: <b>ppFaxDevice**</b> A FaxDevice object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ItemById(int lId, IFaxDevice* ppFaxDevice);
}

///The <b>IFaxInboundRouting</b> interface defines a configuration object used by a fax client application to access the
///inbound routing extensions registered with the fax service, represented by FaxInboundRoutingExtensions objects, and
///the routing methods the extensions expose, represented by FaxInboundRoutingMethods objects.
@GUID("8148C20F-9D52-45B1-BF96-38FC12713527")
interface IFaxInboundRouting : IDispatch
{
    ///The GetExtensions method retrieves the collection of inbound routing extensions registered with the fax service.
    ///Params:
    ///    pFaxInboundRoutingExtensions = Type: <b>IFaxInboundRoutingExtensions**</b> Address of a pointer to an IFaxInboundRoutingExtensions
    ///                                   interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetExtensions(IFaxInboundRoutingExtensions* pFaxInboundRoutingExtensions);
    ///The <b>IFaxInboundRouting::GetMethods</b> method retrieves the ordered collection of all the inbound routing
    ///methods exposed by all the inbound routing extensions currently registered with the fax service.
    ///Params:
    ///    pFaxInboundRoutingMethods = Type: <b>IFaxInboundRoutingMethods**</b> Address of a pointer to an IFaxInboundRoutingMethods interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMethods(IFaxInboundRoutingMethods* pFaxInboundRoutingMethods);
}

///The <b>IFaxFolders</b> interface defines a configuration object used by a fax client application to access the
///folders, queued jobs, and archived messages on a fax server.
@GUID("DCE3B2A8-A7AB-42BC-9D0A-3149457261A0")
interface IFaxFolders : IDispatch
{
    ///The <b>IFaxFolders::get_OutgoingQueue</b> property represents the queue of outgoing faxes. This property is
    ///read-only.
    HRESULT get_OutgoingQueue(IFaxOutgoingQueue* pFaxOutgoingQueue);
    ///The <b>IFaxFolders::get_IncomingQueue</b> property represents the queue of incoming faxes. This property is
    ///read-only.
    HRESULT get_IncomingQueue(IFaxIncomingQueue* pFaxIncomingQueue);
    ///The <b>IFaxFolders::get_IncomingArchive</b> property represents the archive of incoming faxes. This property is
    ///read-only.
    HRESULT get_IncomingArchive(IFaxIncomingArchive* pFaxIncomingArchive);
    ///The <b>IFaxFolders::get_OutgoingArchive</b> property represents the archive of outgoing faxes. This property is
    ///read-only.
    HRESULT get_OutgoingArchive(IFaxOutgoingArchive* pFaxOutgoingArchive);
}

///The <b>IFaxLoggingOptions</b> interface is used by a fax client application to access and configure the event logging
///categories and the activity logging options that the fax service is using. The <b>IFaxLoggingOptions</b> interface is
///accessed through an IFaxServer interface. It provides access to the FaxActivityLogging and FaxEventLogging methods.
@GUID("34E64FB9-6B31-4D32-8B27-D286C0C33606")
interface IFaxLoggingOptions : IDispatch
{
    ///The <b>EventLogging</b> property retrieves the FaxEventLogging configuration object. This property is read-only.
    HRESULT get_EventLogging(IFaxEventLogging* pFaxEventLogging);
    ///The <b>ActivityLogging</b> property retrieves the FaxActivityLogging configuration object. This property is
    ///read-only.
    HRESULT get_ActivityLogging(IFaxActivityLogging* pFaxActivityLogging);
}

///The <b>IFaxActivity</b> interface defines a read-only configuration object. The object permits a fax client
///application to access information about the activity on a connected fax server. For example, you can retrieve
///information about the number of outbound routing jobs that are currently executing, those that are pending
///processing, and those that are waiting in the job queue.
@GUID("4B106F97-3DF5-40F2-BC3C-44CB8115EBDF")
interface IFaxActivity : IDispatch
{
    ///The <b>IFaxActivity::get_IncomingMessages</b> property is a number that represents the total number of incoming
    ///fax jobs that the fax service is currently in the process of receiving. This property is read-only.
    HRESULT get_IncomingMessages(int* plIncomingMessages);
    ///The <b>IFaxActivity::get_RoutingMessages</b> property is a number that represents the total number of incoming
    ///fax jobs that the fax service is currently routing. This property is read-only.
    HRESULT get_RoutingMessages(int* plRoutingMessages);
    ///The <b>IFaxActivity::get_OutgoingMessages</b> property is a number that represents the total number of outgoing
    ///fax jobs that the fax service is in the process of sending. This property is read-only.
    HRESULT get_OutgoingMessages(int* plOutgoingMessages);
    ///The <b>IFaxActivity::get_QueuedMessages</b> property is a number that represents the total number of fax jobs in
    ///the fax job queue that are pending processing. This does not include jobs for which the number of retries has
    ///been exceeded. This property is read-only.
    HRESULT get_QueuedMessages(int* plQueuedMessages);
    ///The <b>IFaxActivity::Refresh</b> method refreshes FaxActivity information from the fax server. The
    ///<b>IFaxActivity::Refresh</b> method refreshes IFaxActivity information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
}

///The <b>IFaxOutboundRouting</b> interface defines a configuration object that is used by a fax client application to
///configure the outbound routing groups (IFaxOutboundRoutingGroups interfaces) and outbound routing rules
///(IFaxOutboundRoutingRules interfaces).
@GUID("25DC05A4-9909-41BD-A95B-7E5D1DEC1D43")
interface IFaxOutboundRouting : IDispatch
{
    ///The <b>IFaxOutboundRouting::GetGroups</b> method retrieves an interface that represents a collection of outbound
    ///routing groups.
    ///Params:
    ///    pFaxOutboundRoutingGroups = Type: <b>IFaxOutboundRoutingGroups**</b> An address of a pointer that receives an IFaxOutboundRoutingGroups
    ///                                interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetGroups(IFaxOutboundRoutingGroups* pFaxOutboundRoutingGroups);
    ///The <b>IFaxOutboundRouting::GetRules</b> method retrieves an interface that represents a collection of outbound
    ///routing groups.
    ///Params:
    ///    pFaxOutboundRoutingRules = Type: <b>IFaxOutboundRoutingRules**</b> An address of a pointer that receives an IFaxOutboundRoutingRules
    ///                               interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetRules(IFaxOutboundRoutingRules* pFaxOutboundRoutingRules);
}

///The <b>IFaxReceiptOptions</b> interface defines a FaxReceiptOptions configuration object used by a fax client
///application to set and retrieve the receipt configuration that the fax service uses to send delivery receipts for fax
///transmissions.
@GUID("378EFAEB-5FCB-4AFB-B2EE-E16E80614487")
interface IFaxReceiptOptions : IDispatch
{
    ///The <b>IFaxReceiptOptions::get_AuthenticationType</b> property specifies the type of authentication the fax
    ///service uses when connecting to an Simple Mail Transport Protocol (SMTP) server. This property is read/write.
    HRESULT get_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM* pType);
    ///The <b>IFaxReceiptOptions::get_AuthenticationType</b> property specifies the type of authentication the fax
    ///service uses when connecting to an Simple Mail Transport Protocol (SMTP) server. This property is read/write.
    HRESULT put_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM Type);
    ///The <b>IFaxReceiptOptions::get_SMTPServer</b> property is a null-terminated string that contains the name of the
    ///Simple Mail Transport Protocol (SMTP) server. This property is read/write.
    HRESULT get_SMTPServer(BSTR* pbstrSMTPServer);
    ///The <b>IFaxReceiptOptions::get_SMTPServer</b> property is a null-terminated string that contains the name of the
    ///Simple Mail Transport Protocol (SMTP) server. This property is read/write.
    HRESULT put_SMTPServer(BSTR bstrSMTPServer);
    ///The <b>IFaxReceiptOptions::get_SMTPPort</b> property is a value that specifies the Simple Mail Transport Protocol
    ///(SMTP) port number. This property is read/write.
    HRESULT get_SMTPPort(int* plSMTPPort);
    ///The <b>IFaxReceiptOptions::get_SMTPPort</b> property is a value that specifies the Simple Mail Transport Protocol
    ///(SMTP) port number. This property is read/write.
    HRESULT put_SMTPPort(int lSMTPPort);
    ///The <b>IFaxReceiptOptions::get_SMTPSender</b> property is a null-terminated string that contains the Simple Mail
    ///Transport Protocol (SMTP) email address for the sender of the mail message receipt. This property is read/write.
    HRESULT get_SMTPSender(BSTR* pbstrSMTPSender);
    ///The <b>IFaxReceiptOptions::get_SMTPSender</b> property is a null-terminated string that contains the Simple Mail
    ///Transport Protocol (SMTP) email address for the sender of the mail message receipt. This property is read/write.
    HRESULT put_SMTPSender(BSTR bstrSMTPSender);
    ///The <b>IFaxReceiptOptions::get_SMTPUser</b> property is a null-terminated string that contains the Simple Mail
    ///Transport Protocol (SMTP) user name used for authenticated connections. This property is read/write.
    HRESULT get_SMTPUser(BSTR* pbstrSMTPUser);
    ///The <b>IFaxReceiptOptions::get_SMTPUser</b> property is a null-terminated string that contains the Simple Mail
    ///Transport Protocol (SMTP) user name used for authenticated connections. This property is read/write.
    HRESULT put_SMTPUser(BSTR bstrSMTPUser);
    ///The <b>IFaxReceiptOptions::get_AllowedReceipts</b> property is a value that specifies the permitted types of
    ///delivery receipts. This property is read/write.
    HRESULT get_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM* pAllowedReceipts);
    ///The <b>IFaxReceiptOptions::get_AllowedReceipts</b> property is a value that specifies the permitted types of
    ///delivery receipts. This property is read/write.
    HRESULT put_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM AllowedReceipts);
    ///The <b>IFaxReceiptOptions::get_SMTPPassword</b> property is a null-terminated string that contains the Simple
    ///Mail Transport Protocol (SMTP) password used for authenticated connections. This property is read/write.
    HRESULT get_SMTPPassword(BSTR* pbstrSMTPPassword);
    ///The <b>IFaxReceiptOptions::get_SMTPPassword</b> property is a null-terminated string that contains the Simple
    ///Mail Transport Protocol (SMTP) password used for authenticated connections. This property is read/write.
    HRESULT put_SMTPPassword(BSTR bstrSMTPPassword);
    ///The <b>IFaxReceiptOptions::Refresh</b> method refreshes FaxReceiptOptions object information from the fax server.
    ///When the <b>IFaxReceiptOptions::Refresh</b> method is called, any configuration changes made after the last
    ///IFaxReceiptOptions::Save method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxReceiptOptions::Save</b> method saves the FaxReceiptOptions object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>IFaxReceiptOptions::get_UseForInboundRouting </b> property sets or retrieves whether to use the
    ///FaxReceiptOptions settings for the Microsoft Routing Extension, which allows incoming faxes to be routed to email
    ///addresses. This property is read/write.
    HRESULT get_UseForInboundRouting(short* pbUseForInboundRouting);
    ///The <b>IFaxReceiptOptions::get_UseForInboundRouting </b> property sets or retrieves whether to use the
    ///FaxReceiptOptions settings for the Microsoft Routing Extension, which allows incoming faxes to be routed to email
    ///addresses. This property is read/write.
    HRESULT put_UseForInboundRouting(short bUseForInboundRouting);
}

///The <b>IFaxSecurity</b> configuration object is used by a fax client application to configure the security on a fax
///server, and permits the calling application to set and retrieve a security descriptor for the fax server.
@GUID("77B508C1-09C0-47A2-91EB-FCE7FDF2690E")
interface IFaxSecurity : IDispatch
{
    ///The <b>Descriptor</b> property represents the security descriptor for a IFaxServer object. This property is
    ///read/write.
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    ///The <b>Descriptor</b> property represents the security descriptor for a IFaxServer object. This property is
    ///read/write.
    HRESULT put_Descriptor(VARIANT vDescriptor);
    ///The <b>IFaxSecurity::get_GrantedRights</b> property is a combination of the fax server access rights granted to
    ///the user referencing this property. For example, some users have permission to submit fax jobs with high priority
    ///while others have permission to submit jobs with normal or low priority only. This property is read-only.
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM* pGrantedRights);
    ///The <b>IFaxSecurity::Refresh</b> method refreshes FaxSecurity object information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxSecurity::Save</b> method saves the FaxSecurity object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>IFaxSecurity::InformationType</b> property represents the security information type. This property is
    ///read/write.
    HRESULT get_InformationType(int* plInformationType);
    ///The <b>IFaxSecurity::InformationType</b> property represents the security information type. This property is
    ///read/write.
    HRESULT put_InformationType(int lInformationType);
}

///The <b>IFaxDocument</b> interface defines a messaging object used by a fax client application to compose a fax
///document and submit it to the fax service for processing.
@GUID("B207A246-09E3-4A4E-A7DC-FEA31D29458F")
interface IFaxDocument : IDispatch
{
    ///The <b>IFaxDocument::get_Body</b> property provides the path to the file that comprises the body of a fax. The
    ///body of a fax consists of the fax pages other than the cover page. This property is read/write.
    HRESULT get_Body(BSTR* pbstrBody);
    ///The <b>IFaxDocument::get_Body</b> property provides the path to the file that comprises the body of a fax. The
    ///body of a fax consists of the fax pages other than the cover page. This property is read/write.
    HRESULT put_Body(BSTR bstrBody);
    ///Retrieves an object containing information about the sender of the fax document. This property is read-only.
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    ///The <b>IFaxDocument::get_Recipients</b> property retrieves a collection of one or more recipients for the fax
    ///document. This property is read-only.
    HRESULT get_Recipients(IFaxRecipients* ppFaxRecipients);
    ///The <b>IFaxDocument::get_CoverPage</b> property is a null-terminated string that contains the name of the cover
    ///page template file (.cov) to associate with the fax document. This property is read/write.
    HRESULT get_CoverPage(BSTR* pbstrCoverPage);
    ///The <b>IFaxDocument::get_CoverPage</b> property is a null-terminated string that contains the name of the cover
    ///page template file (.cov) to associate with the fax document. This property is read/write.
    HRESULT put_CoverPage(BSTR bstrCoverPage);
    ///The <b>IFaxDocument::get_Subject</b> property is a null-terminated string that contains the contents of the
    ///subject field on the cover page of the fax. This property is read/write.
    HRESULT get_Subject(BSTR* pbstrSubject);
    ///The <b>IFaxDocument::get_Subject</b> property is a null-terminated string that contains the contents of the
    ///subject field on the cover page of the fax. This property is read/write.
    HRESULT put_Subject(BSTR bstrSubject);
    ///The <b>IFaxDocument::get_Note</b> property is a null-terminated string that contains the contents of the note
    ///field on the cover page of the fax. This property is read/write.
    HRESULT get_Note(BSTR* pbstrNote);
    ///The <b>IFaxDocument::get_Note</b> property is a null-terminated string that contains the contents of the note
    ///field on the cover page of the fax. This property is read/write.
    HRESULT put_Note(BSTR bstrNote);
    ///The <b>IFaxDocument::get_ScheduleTime</b> property indicates the time to submit the fax for processing to the fax
    ///service. This property is read/write.
    HRESULT get_ScheduleTime(double* pdateScheduleTime);
    ///The <b>IFaxDocument::get_ScheduleTime</b> property indicates the time to submit the fax for processing to the fax
    ///service. This property is read/write.
    HRESULT put_ScheduleTime(double dateScheduleTime);
    ///The <b>IFaxDocument::get_ReceiptAddress</b> property is a null-terminated string that indicates the email address
    ///to which the fax service should send a delivery receipt when the fax job reaches a final state. This property is
    ///read/write.
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    ///The <b>IFaxDocument::get_ReceiptAddress</b> property is a null-terminated string that indicates the email address
    ///to which the fax service should send a delivery receipt when the fax job reaches a final state. This property is
    ///read/write.
    HRESULT put_ReceiptAddress(BSTR bstrReceiptAddress);
    ///The <b>IFaxDocument::get_DocumentName</b> property is a null-terminated string that contains the user-friendly
    ///name to display for the fax document. The value is for display purposes only. This property is read/write.
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    ///The <b>IFaxDocument::get_DocumentName</b> property is a null-terminated string that contains the user-friendly
    ///name to display for the fax document. The value is for display purposes only. This property is read/write.
    HRESULT put_DocumentName(BSTR bstrDocumentName);
    HRESULT get_CallHandle(int* plCallHandle);
    HRESULT put_CallHandle(int lCallHandle);
    ///The <b>IFaxDocument::get_CoverPageType</b> property is a value from an enumeration that indicates whether a
    ///specified cover page template file (.cov) is a server-based cover page file or a local-computer-based cover page
    ///file. You can also specify that no file is used. This property is read/write.
    HRESULT get_CoverPageType(FAX_COVERPAGE_TYPE_ENUM* pCoverPageType);
    ///The <b>IFaxDocument::get_CoverPageType</b> property is a value from an enumeration that indicates whether a
    ///specified cover page template file (.cov) is a server-based cover page file or a local-computer-based cover page
    ///file. You can also specify that no file is used. This property is read/write.
    HRESULT put_CoverPageType(FAX_COVERPAGE_TYPE_ENUM CoverPageType);
    ///The <b>IFaxDocument::get_ScheduleType</b> property indicates when to schedule the fax job; for example, you can
    ///specify that the fax service send the fax immediately, at a specified time, or during a predefined discount
    ///period. This property is read/write.
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
    ///The <b>IFaxDocument::get_ScheduleType</b> property indicates when to schedule the fax job; for example, you can
    ///specify that the fax service send the fax immediately, at a specified time, or during a predefined discount
    ///period. This property is read/write.
    HRESULT put_ScheduleType(FAX_SCHEDULE_TYPE_ENUM ScheduleType);
    ///The <b>IFaxDocument::get_ReceiptType</b> property specifies the type of delivery receipt to deliver when the fax
    ///job reaches a final state. This property is read/write.
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    ///The <b>IFaxDocument::get_ReceiptType</b> property specifies the type of delivery receipt to deliver when the fax
    ///job reaches a final state. This property is read/write.
    HRESULT put_ReceiptType(FAX_RECEIPT_TYPE_ENUM ReceiptType);
    ///The <b>IFaxDocument::get_GroupBroadcastReceipts</b> property is a Boolean value that indicates whether to send an
    ///individual delivery receipt for each recipient of the broadcast, or to send a summary receipt for all the
    ///recipients. This property is read/write.
    HRESULT get_GroupBroadcastReceipts(short* pbUseGrouping);
    ///The <b>IFaxDocument::get_GroupBroadcastReceipts</b> property is a Boolean value that indicates whether to send an
    ///individual delivery receipt for each recipient of the broadcast, or to send a summary receipt for all the
    ///recipients. This property is read/write.
    HRESULT put_GroupBroadcastReceipts(short bUseGrouping);
    ///The <b>IFaxDocument::get_Priority</b> property specifies the priority to use when sending the fax; for example,
    ///normal, low, or high priority. This property is read/write.
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    ///The <b>IFaxDocument::get_Priority</b> property specifies the priority to use when sending the fax; for example,
    ///normal, low, or high priority. This property is read/write.
    HRESULT put_Priority(FAX_PRIORITY_TYPE_ENUM Priority);
    HRESULT get_TapiConnection(IDispatch* ppTapiConnection);
    HRESULT putref_TapiConnection(IDispatch pTapiConnection);
    ///The <b>IFaxDocument::Submit</b> method submits a single fax document to the fax service for processing.
    ///Params:
    ///    bstrFaxServerName = Type: <b>BSTR</b> <b>BSTR</b> that specifies a fax server. If this parameter is <b>NULL</b> or an empty
    ///                        string, the local fax server is specified.
    ///    pvFaxOutgoingJobIDs = Type: <b>VARIANT*</b> <b>VARIANT</b> that specifies a collection of outbound job IDs, one for each recipient
    ///                          of the fax.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Submit(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs);
    ///The <b>IFaxDocument::ConnectedSubmit</b> method submits a single fax document to the connected IFaxServer. The
    ///method returns an array of fax job ID strings, one for each recipient of the fax.
    ///Params:
    ///    pFaxServer = Type: <b>IFaxServer*</b> An IFaxServer interface that specifies a connected fax server.
    ///    pvFaxOutgoingJobIDs = Type: <b>VARIANT*</b> <b>VARIANT</b> that holds an array of outbound job ID strings, one for each recipient
    ///                          of the fax.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConnectedSubmit(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs);
    ///The <b>IFaxDocument::get_AttachFaxToReceipt</b> property indicates whether to attach a fax to the receipt. This
    ///property is read/write.
    HRESULT get_AttachFaxToReceipt(short* pbAttachFax);
    ///The <b>IFaxDocument::get_AttachFaxToReceipt</b> property indicates whether to attach a fax to the receipt. This
    ///property is read/write.
    HRESULT put_AttachFaxToReceipt(short bAttachFax);
}

///The <b>IFaxSender</b> interface defines a messaging object used by a fax client application to retrieve and set
///sender information about fax senders. The object also includes methods to store sender data in and retrieve sender
///data from the local registry.
@GUID("0D879D7D-F57A-4CC6-A6F9-3EE5D527B46A")
interface IFaxSender : IDispatch
{
    ///The <b>IFaxSender::get_BillingCode</b> property is a null-terminated string that contains the billing code
    ///associated with the sender. This property is read/write.
    HRESULT get_BillingCode(BSTR* pbstrBillingCode);
    ///The <b>IFaxSender::get_BillingCode</b> property is a null-terminated string that contains the billing code
    ///associated with the sender. This property is read/write.
    HRESULT put_BillingCode(BSTR bstrBillingCode);
    HRESULT get_City(BSTR* pbstrCity);
    HRESULT put_City(BSTR bstrCity);
    ///The <b>IFaxSender::get_Company</b> property is a null-terminated string that contains the company name associated
    ///with the sender. This property is read/write.
    HRESULT get_Company(BSTR* pbstrCompany);
    ///The <b>IFaxSender::get_Company</b> property is a null-terminated string that contains the company name associated
    ///with the sender. This property is read/write.
    HRESULT put_Company(BSTR bstrCompany);
    HRESULT get_Country(BSTR* pbstrCountry);
    HRESULT put_Country(BSTR bstrCountry);
    ///The <b>IFaxSender::get_Department</b> property is a null-terminated string that contains the department
    ///associated with the sender. This property is read/write.
    HRESULT get_Department(BSTR* pbstrDepartment);
    ///The <b>IFaxSender::get_Department</b> property is a null-terminated string that contains the department
    ///associated with the sender. This property is read/write.
    HRESULT put_Department(BSTR bstrDepartment);
    ///The <b>IFaxSender::get_Email</b> property is a null-terminated string that contains the email address associated
    ///with the sender. This property is read/write.
    HRESULT get_Email(BSTR* pbstrEmail);
    ///The <b>IFaxSender::get_Email</b> property is a null-terminated string that contains the email address associated
    ///with the sender. This property is read/write.
    HRESULT put_Email(BSTR bstrEmail);
    ///The <b>IFaxSender::get_FaxNumber</b> property is a null-terminated string that contains the fax number associated
    ///with the sender. This property is read/write.
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    ///The <b>IFaxSender::get_FaxNumber</b> property is a null-terminated string that contains the fax number associated
    ///with the sender. This property is read/write.
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    ///The <b>IFaxSender::get_HomePhone</b> property is a null-terminated string that contains the home telephone number
    ///associated with the sender. This property is read/write.
    HRESULT get_HomePhone(BSTR* pbstrHomePhone);
    ///The <b>IFaxSender::get_HomePhone</b> property is a null-terminated string that contains the home telephone number
    ///associated with the sender. This property is read/write.
    HRESULT put_HomePhone(BSTR bstrHomePhone);
    ///The <b>IFaxSender::get_Name</b> property is a null-terminated string that contains the name of the sender. This
    ///property is read/write.
    HRESULT get_Name(BSTR* pbstrName);
    ///The <b>IFaxSender::get_Name</b> property is a null-terminated string that contains the name of the sender. This
    ///property is read/write.
    HRESULT put_Name(BSTR bstrName);
    ///The <b>IFaxSender::get_TSID</b> property is a null-terminated string that contains the transmitting station
    ///identifier (TSID) for the sender's device. This property is read/write.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>IFaxSender::get_TSID</b> property is a null-terminated string that contains the transmitting station
    ///identifier (TSID) for the sender's device. This property is read/write.
    HRESULT put_TSID(BSTR bstrTSID);
    ///The <b>IFaxSender::get_OfficePhone</b> property is a null-terminated string that contains the office telephone
    ///number associated with the sender. This property is read/write.
    HRESULT get_OfficePhone(BSTR* pbstrOfficePhone);
    ///The <b>IFaxSender::get_OfficePhone</b> property is a null-terminated string that contains the office telephone
    ///number associated with the sender. This property is read/write.
    HRESULT put_OfficePhone(BSTR bstrOfficePhone);
    ///The <b>IFaxSender::get_OfficeLocation</b> property is a null-terminated string that contains the office location
    ///of the sender. This property is read/write.
    HRESULT get_OfficeLocation(BSTR* pbstrOfficeLocation);
    ///The <b>IFaxSender::get_OfficeLocation</b> property is a null-terminated string that contains the office location
    ///of the sender. This property is read/write.
    HRESULT put_OfficeLocation(BSTR bstrOfficeLocation);
    HRESULT get_State(BSTR* pbstrState);
    HRESULT put_State(BSTR bstrState);
    ///The <b>IFaxSender::get_StreetAddress</b> property is a null-terminated string that contains the street address
    ///associated with the sender. This property is read/write.
    HRESULT get_StreetAddress(BSTR* pbstrStreetAddress);
    ///The <b>IFaxSender::get_StreetAddress</b> property is a null-terminated string that contains the street address
    ///associated with the sender. This property is read/write.
    HRESULT put_StreetAddress(BSTR bstrStreetAddress);
    ///The <b>IFaxSender::get_Title</b> property is a null-terminated string that contains the title associated with the
    ///sender. This property is read/write.
    HRESULT get_Title(BSTR* pbstrTitle);
    ///The <b>IFaxSender::get_Title</b> property is a null-terminated string that contains the title associated with the
    ///sender. This property is read/write.
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_ZipCode(BSTR* pbstrZipCode);
    HRESULT put_ZipCode(BSTR bstrZipCode);
    ///The <b>IFaxSender::get_LoadDefaultSender</b> method fills the FaxSender object with the default sender
    ///information.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT LoadDefaultSender();
    ///The <b>IFaxSender::SaveDefaultSender</b> method stores information about the default sender from the FaxSender
    ///object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SaveDefaultSender();
}

///The <b>IFaxRecipient</b> interface defines a FaxRecipient messaging object is used by a fax client application to
///retrieve and set the personal information for fax recipients. The object also includes methods to store recipient
///data in and retrieve recipient data from the local registry.
@GUID("9A3DA3A0-538D-42B6-9444-AAA57D0CE2BC")
interface IFaxRecipient : IDispatch
{
    ///The <b>IFaxRecipient::get_FaxNumber</b> property is a null-terminated string that contains the fax number
    ///associated with the recipient. This property is read/write.
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    ///The <b>IFaxRecipient::get_FaxNumber</b> property is a null-terminated string that contains the fax number
    ///associated with the recipient. This property is read/write.
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    ///The <b>IFaxRecipient::get_Name</b> property is a null-terminated string that contains the name of the recipient.
    ///This property is read/write.
    HRESULT get_Name(BSTR* pbstrName);
    ///The <b>IFaxRecipient::get_Name</b> property is a null-terminated string that contains the name of the recipient.
    ///This property is read/write.
    HRESULT put_Name(BSTR bstrName);
}

///The <b>IFaxRecipients</b> interface defines a FaxRecipients messaging collection is used by a fax client application
///to manage the fax recipient objects (FaxRecipient) that represent the recipients of a single fax document. The
///collection also includes methods to add and remove recipients.
@GUID("B9C9DE5A-894E-4492-9FA3-08C627C11D5D")
interface IFaxRecipients : IDispatch
{
    ///The <b>IFaxRecipients::get__NewEnum</b> method returns a reference to an enumerator object that you can use to
    ///iterate through the FaxRecipients collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The Item method returns a FaxRecipient object from the FaxRecipients collection.
    ///Params:
    ///    lIndex = Type: <b>LONG</b> A <b>LONG</b> value that specifies the item to retrieve from the fax recipient collection.
    ///             Valid values for this parameter are in the range from 1 to <i>n</i>, where <i>n</i> is the number of
    ///             recipients returned by a call to the IFaxRecipients::get_Count method.
    ///    ppFaxRecipient = Type: <b>IFaxRecipient**</b> Address of a pointer to a IFaxRecipient interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(int lIndex, IFaxRecipient* ppFaxRecipient);
    ///The <b>IFaxRecipients::get_Count</b> property represents the number of objects in the FaxRecipients collection.
    ///This is the total number of recipients associated with the fax server or fax document. This property is
    ///read-only.
    HRESULT get_Count(int* plCount);
    ///The <b>IFaxRecipients::Add</b> method adds a new FaxRecipient object to the FaxRecipients collection.
    ///Params:
    ///    bstrFaxNumber = Type: <b>BSTR</b> Specifies the fax number of the fax recipient.
    ///    bstrRecipientName = Type: <b>BSTR</b> Specifies the name of the fax recipient.
    ///    ppFaxRecipient = Type: <b>IFaxRecipient**</b> A FaxRecipient object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(BSTR bstrFaxNumber, BSTR bstrRecipientName, IFaxRecipient* ppFaxRecipient);
    ///The <b>IFaxRecipients::Remove</b> method removes an item from the FaxRecipients collection.
    ///Params:
    ///    lIndex = Type: <b>LONG</b> A <b>LONG</b> that specifies the index of the item to remove from the collection. Valid
    ///             values for this parameter are in the range from 1 to <i>n</i>, where <i>n</i> is the number of recipients
    ///             returned by a call to the IFaxRecipients::get_Count method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(int lIndex);
}

///The <b>IFaxIncomingArchive</b> interface is used by a fax client application to access and configure the archive of
///inbound fax messages received successfully by the fax service. Use this interface to set and retrieve parameters
///related to configuring the archive of sent faxes. You can also use the <b>IFaxIncomingArchive</b> interface to
///retrieve a message from the archive by specifying its message ID. A default implementation of
///<b>IFaxIncomingArchive</b> is provided as the FaxIncomingArchive object.
@GUID("76062CC7-F714-4FBD-AA06-ED6E4A4B70F3")
interface IFaxIncomingArchive : IDispatch
{
    ///The <b>UseArchive</b> property is a Boolean value that indicates whether the fax service archives inbound fax
    ///messages. If this property is equal to <b>TRUE</b>, the fax service archives inbound fax messages. If this
    ///property is equal to <b>FALSE</b>, the fax service does not archive inbound faxes. This property is read/write.
    HRESULT get_UseArchive(short* pbUseArchive);
    ///The <b>UseArchive</b> property is a Boolean value that indicates whether the fax service archives inbound fax
    ///messages. If this property is equal to <b>TRUE</b>, the fax service archives inbound fax messages. If this
    ///property is equal to <b>FALSE</b>, the fax service does not archive inbound faxes. This property is read/write.
    HRESULT put_UseArchive(short bUseArchive);
    ///The <b>ArchiveFolder</b> property is a null-terminated string that specifies the folder location on the fax
    ///server for archived inbound faxes. This property is read/write.
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    ///The <b>ArchiveFolder</b> property is a null-terminated string that specifies the folder location on the fax
    ///server for archived inbound faxes. This property is read/write.
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    ///The <b>SizeQuotaWarning</b> property is a Boolean value that indicates whether the fax service issues a warning
    ///in the event log when the size of the inbound archive exceeds the limit defined by the HighQuotaWaterMark
    ///property. This property is read/write.
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    ///The <b>SizeQuotaWarning</b> property is a Boolean value that indicates whether the fax service issues a warning
    ///in the event log when the size of the inbound archive exceeds the limit defined by the HighQuotaWaterMark
    ///property. This property is read/write.
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    ///The <b>HighQuotaWaterMark</b> property is a value that specifies the upper warning threshold for the size of the
    ///archive of inbound fax messages, in megabytes. If the size of the archive exceeds this value, and the
    ///SizeQuotaWarning property is equal to <b>TRUE</b>, the fax service issues a warning in the event log. This
    ///property is read/write.
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    ///The <b>HighQuotaWaterMark</b> property is a value that specifies the upper warning threshold for the size of the
    ///archive of inbound fax messages, in megabytes. If the size of the archive exceeds this value, and the
    ///SizeQuotaWarning property is equal to <b>TRUE</b>, the fax service issues a warning in the event log. This
    ///property is read/write.
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    ///The <b>LowQuotaWaterMark</b> property is a value that specifies the lower warning threshold for the archive of
    ///inbound fax messages, in megabytes. If the fax service has issued a warning in the event log, the service does
    ///not issue additional warnings until the size of the inbound archive drops below this value. This property is
    ///read/write.
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    ///The <b>LowQuotaWaterMark</b> property is a value that specifies the lower warning threshold for the archive of
    ///inbound fax messages, in megabytes. If the fax service has issued a warning in the event log, the service does
    ///not issue additional warnings until the size of the inbound archive drops below this value. This property is
    ///read/write.
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    ///The <b>AgeLimit</b> property is a value that indicates the number of days that the fax service retains fax
    ///messages in the archive of inbound faxes. The fax service deletes messages from the inbound archive when they
    ///exceed the age limit. If the value of this property is zero, the fax service does not enforce an age limit. This
    ///property is read/write.
    HRESULT get_AgeLimit(int* plAgeLimit);
    ///The <b>AgeLimit</b> property is a value that indicates the number of days that the fax service retains fax
    ///messages in the archive of inbound faxes. The fax service deletes messages from the inbound archive when they
    ///exceed the age limit. If the value of this property is zero, the fax service does not enforce an age limit. This
    ///property is read/write.
    HRESULT put_AgeLimit(int lAgeLimit);
    ///The <b>SizeLow</b> property is a value that specifies the low 32-bit value (in bytes) for the size of the archive
    ///of inbound fax messages. This property is read-only.
    HRESULT get_SizeLow(int* plSizeLow);
    ///The <b>SizeHigh</b> property is a value that specifies the high 32-bit value (in bytes) for the size of the
    ///archive of inbound fax messages. This property is read-only.
    HRESULT get_SizeHigh(int* plSizeHigh);
    ///The <b>Refresh</b> method refreshes FaxIncomingArchive object information from the fax server. When the
    ///<b>Refresh</b> method is called, any configuration changes made after the last Save method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>Save</b> method saves the FaxIncomingArchive object's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>GetMessages</b> method returns a new iterator (archive cursor) for the archive of inbound fax messages.
    ///Params:
    ///    lPrefetchSize = Type: <b>long</b> <b>long</b> value that indicates the size of the prefetch buffer. This value determines how
    ///                    many fax messages the iterator object retrieves from the fax server when the object needs to refresh its
    ///                    contents. The default value is lDEFAULT_PREFETCH_SIZE.
    ///    pFaxIncomingMessageIterator = Type: <b>IFaxIncomingMessageIterator**</b> A FaxIncomingMessageIterator object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

///The <b>IFaxIncomingQueue</b> interface is used by a fax client application to manage the inbound fax jobs
///(FaxIncomingJobs object) in the job queue. The object also includes a method to block inbound faxes from the fax job
///queue. The <b>IFaxIncomingQueue</b> interface is accessed through the IFaxFolders interface. <div
///class="alert"><b>Note</b> Changes made to the <b>FaxIncomingQueue</b> object will not be saved until you call the
///Save method.</div><div> </div>
@GUID("902E64EF-8FD8-4B75-9725-6014DF161545")
interface IFaxIncomingQueue : IDispatch
{
    ///The <b>Blocked</b> property is a Boolean value that indicates whether the job queue for incoming faxes is
    ///blocked. This property is read/write.
    HRESULT get_Blocked(short* pbBlocked);
    ///The <b>Blocked</b> property is a Boolean value that indicates whether the job queue for incoming faxes is
    ///blocked. This property is read/write.
    HRESULT put_Blocked(short bBlocked);
    ///The <b>Refresh</b> method refreshes FaxIncomingQueue object information from the fax server. When the
    ///<b>Refresh</b> method is called, any configuration changes made after the last Save method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>Save</b> method saves the FaxIncomingQueue object's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>GetJobs</b> method returns the collection of inbound fax jobs in the queue.
    ///Params:
    ///    pFaxIncomingJobs = Type: <b>IFaxIncomingJobs**</b> A FaxIncomingJobs object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

///The <b>IFaxOutgoingArchive</b> interface describes a configuration object that is used by a fax client application to
///access and configure the archive of outbound fax messages transmitted successfully by the fax service. You can also
///use the <b>IFaxOutgoingArchive</b> interface to retrieve a message from the archive using its message ID.
@GUID("C9C28F40-8D80-4E53-810F-9A79919B49FD")
interface IFaxOutgoingArchive : IDispatch
{
    ///The <b>IFaxOutgoingArchive::get_UseArchive</b> property is a Boolean value that indicates whether the fax service
    ///archives outbound fax messages. If this parameter is equal to <b>TRUE</b>, the fax service archives outbound fax
    ///messages. If this parameter is equal to <b>FALSE</b>, the fax service does not archive outbound faxes. This
    ///property is read/write.
    HRESULT get_UseArchive(short* pbUseArchive);
    ///The <b>IFaxOutgoingArchive::get_UseArchive</b> property is a Boolean value that indicates whether the fax service
    ///archives outbound fax messages. If this parameter is equal to <b>TRUE</b>, the fax service archives outbound fax
    ///messages. If this parameter is equal to <b>FALSE</b>, the fax service does not archive outbound faxes. This
    ///property is read/write.
    HRESULT put_UseArchive(short bUseArchive);
    ///The <b>IFaxOutgoingArchive::get_ArchiveFolder</b> property is a null-terminated string that specifies the folder
    ///location on the fax server for archived outbound faxes. This property is read/write.
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    ///The <b>IFaxOutgoingArchive::get_ArchiveFolder</b> property is a null-terminated string that specifies the folder
    ///location on the fax server for archived outbound faxes. This property is read/write.
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    ///The <b>IFaxOutgoingArchive::get_SizeQuotaWarning</b> property is a Boolean value that indicates whether the fax
    ///service issues a warning in the event log when the size of the outbound archive exceeds the limit defined by the
    ///IFaxOutgoingArchive::get_HighQuotaWaterMark property. This property is read/write.
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    ///The <b>IFaxOutgoingArchive::get_SizeQuotaWarning</b> property is a Boolean value that indicates whether the fax
    ///service issues a warning in the event log when the size of the outbound archive exceeds the limit defined by the
    ///IFaxOutgoingArchive::get_HighQuotaWaterMark property. This property is read/write.
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    ///The <b>IFaxOutgoingArchive::get_HighQuotaWaterMark</b> property is a value that specifies the upper threshold for
    ///the size of the archive of inbound fax messages, in megabytes. If the archived fax messages in the archive exceed
    ///this value, and the IFaxOutgoingArchive::get_SizeQuotaWarning property is equal to <b>TRUE</b>, the fax service
    ///issues a warning in the event log. This property is read/write.
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    ///The <b>IFaxOutgoingArchive::get_HighQuotaWaterMark</b> property is a value that specifies the upper threshold for
    ///the size of the archive of inbound fax messages, in megabytes. If the archived fax messages in the archive exceed
    ///this value, and the IFaxOutgoingArchive::get_SizeQuotaWarning property is equal to <b>TRUE</b>, the fax service
    ///issues a warning in the event log. This property is read/write.
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    ///The <b>IFaxOutgoingArchive::get_LowQuotaWaterMark</b> property is a value that specifies the lower threshold for
    ///the archive of outbound fax messages, in megabytes. If the fax service has issued a warning in the event log, the
    ///service does not issue additional warnings until the size of the outbound archive drops below this value. This
    ///property is read/write.
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    ///The <b>IFaxOutgoingArchive::get_LowQuotaWaterMark</b> property is a value that specifies the lower threshold for
    ///the archive of outbound fax messages, in megabytes. If the fax service has issued a warning in the event log, the
    ///service does not issue additional warnings until the size of the outbound archive drops below this value. This
    ///property is read/write.
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    ///The <b>IFaxOutgoingArchive::get_AgeLimit</b> property is a value that indicates the number of days that the fax
    ///service retains fax messages in the archive of outbound faxes. The fax service deletes messages from the outbound
    ///archive when they exceed the age limit. If the value of this property is zero, the fax service does not enforce
    ///an age limit. This property is read/write.
    HRESULT get_AgeLimit(int* plAgeLimit);
    ///The <b>IFaxOutgoingArchive::get_AgeLimit</b> property is a value that indicates the number of days that the fax
    ///service retains fax messages in the archive of outbound faxes. The fax service deletes messages from the outbound
    ///archive when they exceed the age limit. If the value of this property is zero, the fax service does not enforce
    ///an age limit. This property is read/write.
    HRESULT put_AgeLimit(int lAgeLimit);
    ///The <b>IFaxOutgoingArchive::get_SizeLow</b> property is a value that specifies the low 32-bit value (in bytes)
    ///for the size of the archive of outgoing fax messages. This property is read-only.
    HRESULT get_SizeLow(int* plSizeLow);
    ///The <b>IFaxOutgoingArchive::get_SizeHigh</b> property is a value that specifies the high 32-bit value (in bytes)
    ///for the size of the archive of outgoing fax messages. This property is read-only.
    HRESULT get_SizeHigh(int* plSizeHigh);
    ///The <b>IFaxOutgoingArchive::Refresh</b> method refreshes FaxOutgoingArchive object information from the fax
    ///server. When the <b>IFaxOutgoingArchive::Refresh</b> method is called, any configuration changes made after the
    ///last IFaxOutgoingArchive::Save method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxOutgoingArchive::Save</b> method saves the FaxOutgoingArchive object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>IFaxOutgoingArchive::GetMessages</b> method returns a new iterator (archive cursor) for the archive of
    ///outbound fax messages. For more information, see IFaxOutgoingMessageIterator.
    ///Params:
    ///    lPrefetchSize = Type: <b>long</b> A <b>long</b> value that specifies the size of the prefetch buffer. This value determines
    ///                    how many fax messages the iterator object retrieves from the fax server when the object needs to refresh its
    ///                    contents. The default value is lDEFAULT_PREFETCH_SIZE.
    ///    pFaxOutgoingMessageIterator = Type: <b>IFaxOutgoingMessageIterator**</b> An address of a pointer that receives the
    ///                                  IFaxOutgoingMessageIterator interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

///The <b>IFaxOutgoingQueue</b> interface defines a FaxOutgoingQueue configuration object used by a fax client
///application to set and retrieve the configuration parameters on the outbound fax queue on a fax server.
@GUID("80B1DF24-D9AC-4333-B373-487CEDC80CE5")
interface IFaxOutgoingQueue : IDispatch
{
    ///The <b>IFaxOutgoingQueue::get_Blocked</b> property is a Boolean value that indicates whether the job queue for
    ///outgoing faxes is blocked. This property is read/write.
    HRESULT get_Blocked(short* pbBlocked);
    ///The <b>IFaxOutgoingQueue::get_Blocked</b> property is a Boolean value that indicates whether the job queue for
    ///outgoing faxes is blocked. This property is read/write.
    HRESULT put_Blocked(short bBlocked);
    ///The <b>IFaxOutgoingQueue::get_Paused</b> property is a Boolean value that indicates whether the job queue for
    ///outgoing faxes is paused. This property is read/write.
    HRESULT get_Paused(short* pbPaused);
    ///The <b>IFaxOutgoingQueue::get_Paused</b> property is a Boolean value that indicates whether the job queue for
    ///outgoing faxes is paused. This property is read/write.
    HRESULT put_Paused(short bPaused);
    ///The AllowPersonalCoverPages property is a Boolean value that indicates whether fax client applications can
    ///include a user-designed cover page with fax transmissions. This property is read/write.
    HRESULT get_AllowPersonalCoverPages(short* pbAllowPersonalCoverPages);
    ///The AllowPersonalCoverPages property is a Boolean value that indicates whether fax client applications can
    ///include a user-designed cover page with fax transmissions. This property is read/write.
    HRESULT put_AllowPersonalCoverPages(short bAllowPersonalCoverPages);
    ///The <b>IFaxOutgoingQueue::get_UseDeviceTSID</b> property is a Boolean value that indicates whether the fax
    ///service uses the device transmitting station identifier (TSID) instead of a sender TSID. This property is
    ///read/write.
    HRESULT get_UseDeviceTSID(short* pbUseDeviceTSID);
    ///The <b>IFaxOutgoingQueue::get_UseDeviceTSID</b> property is a Boolean value that indicates whether the fax
    ///service uses the device transmitting station identifier (TSID) instead of a sender TSID. This property is
    ///read/write.
    HRESULT put_UseDeviceTSID(short bUseDeviceTSID);
    ///The <b>IFaxOutgoingQueue::get_Retries</b> property is a value that indicates the number of times that the fax
    ///service attempts to retransmit an outgoing fax when the initial transmission fails. This property is read/write.
    HRESULT get_Retries(int* plRetries);
    ///The <b>IFaxOutgoingQueue::get_Retries</b> property is a value that indicates the number of times that the fax
    ///service attempts to retransmit an outgoing fax when the initial transmission fails. This property is read/write.
    HRESULT put_Retries(int lRetries);
    ///The <b>IFaxOutgoingQueue::get_RetryDelay</b> property is a value that indicates the time interval, in minutes,
    ///that the fax service waits before attempting to retransmit an outbound fax job. This property is read/write.
    HRESULT get_RetryDelay(int* plRetryDelay);
    ///The <b>IFaxOutgoingQueue::get_RetryDelay</b> property is a value that indicates the time interval, in minutes,
    ///that the fax service waits before attempting to retransmit an outbound fax job. This property is read/write.
    HRESULT put_RetryDelay(int lRetryDelay);
    ///The <b>IFaxOutgoingQueue::get_DiscountRateStart</b> property is a value that indicates the time at which the
    ///discount period for transmitting faxes begins. The discount period applies to outgoing faxes. This property is
    ///read/write.
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    ///The <b>IFaxOutgoingQueue::get_DiscountRateStart</b> property is a value that indicates the time at which the
    ///discount period for transmitting faxes begins. The discount period applies to outgoing faxes. This property is
    ///read/write.
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    ///The <b>IFaxOutgoingQueue::get_DiscountRateEnd</b> property is a value that indicates the time at which the
    ///discount period for transmitting faxes ends. The discount period applies to outgoing faxes. This property is
    ///read/write.
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    ///The <b>IFaxOutgoingQueue::get_DiscountRateEnd</b> property is a value that indicates the time at which the
    ///discount period for transmitting faxes ends. The discount period applies to outgoing faxes. This property is
    ///read/write.
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    ///The <b>IFaxOutgoingQueue::get_AgeLimit</b> property is a value that indicates the number of days that the fax
    ///service retains an unsent job in the fax job queue. This property is read/write.
    HRESULT get_AgeLimit(int* plAgeLimit);
    ///The <b>IFaxOutgoingQueue::get_AgeLimit</b> property is a value that indicates the number of days that the fax
    ///service retains an unsent job in the fax job queue. This property is read/write.
    HRESULT put_AgeLimit(int lAgeLimit);
    ///The <b>IFaxOutgoingQueue::get_Branding</b> property is a Boolean value that indicates whether the fax service
    ///generates a brand (banner) at the top of outgoing fax transmissions. A brand contains transmission-related
    ///information, such as the transmitting station identifier, date, time, and page count. This property is
    ///read/write.
    HRESULT get_Branding(short* pbBranding);
    ///The <b>IFaxOutgoingQueue::get_Branding</b> property is a Boolean value that indicates whether the fax service
    ///generates a brand (banner) at the top of outgoing fax transmissions. A brand contains transmission-related
    ///information, such as the transmitting station identifier, date, time, and page count. This property is
    ///read/write.
    HRESULT put_Branding(short bBranding);
    ///The <b>IFaxOutgoingQueue::Refresh</b> method refreshes FaxOutgoingQueue object information from the fax server.
    ///When the <b>IFaxOutgoingQueue::Refresh</b> method is called, any configuration changes made after the last
    ///IFaxOutgoingQueue::Save method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxOutgoingQueue::Save</b> method saves the FaxOutgoingQueue object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>IFaxOutgoingQueue::GetJobs</b> method returns a collection of the outbound fax jobs in the job queue.
    ///Params:
    ///    pFaxOutgoingJobs = Type: <b>FaxOutgoingJobs**</b> A FaxOutgoingJobs object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

///The <b>IFaxIncomingMessageIterator</b> interface is used by a fax client application to move through the archive of
///inbound fax messages that the fax service has successfully received. Because the <b>IFaxIncomingMessageIterator</b>
///interface is a forward iterator, you can only move forward through the archive from beginning to end, and you can
///access only one fax message (IFaxIncomingMessage object) at a time. The <b>IFaxIncomingMessageIterator</b> interface
///is accessed through the IFaxIncomingArchive interface.
@GUID("FD73ECC4-6F06-4F52-82A8-F7BA06AE3108")
interface IFaxIncomingMessageIterator : IDispatch
{
    ///The <b>Message</b> property retrieves the inbound fax message under the archive cursor. This property is
    ///read-only.
    HRESULT get_Message(IFaxIncomingMessage* pFaxIncomingMessage);
    ///The <b>PrefetchSize</b> property indicates the size of the prefetch (read-ahead) buffer. This property is
    ///read/write.
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    ///The <b>PrefetchSize</b> property indicates the size of the prefetch (read-ahead) buffer. This property is
    ///read/write.
    HRESULT put_PrefetchSize(int lPrefetchSize);
    ///The <b>AtEOF</b> property is the end of file marker for the archive of inbound fax messages. If this property is
    ///equal to <b>TRUE</b>, the archive cursor has moved beyond the last fax message in the inbound fax archive. If
    ///this property is equal to <b>FALSE</b>, the archive cursor has not yet reached the end of the archive. This
    ///property is read-only.
    HRESULT get_AtEOF(short* pbEOF);
    ///The <b>MoveFirst</b> method moves the archive cursor to the first fax message in the archive of inbound faxes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveFirst();
    ///The <b>MoveNext</b> method moves the archive cursor to the next message in the archive of inbound faxes.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveNext();
}

///Used by a fax client application to retrieve information about a received fax message in the archive of inbound
///faxes. The archive contains faxes received successfully by the fax service. The interface also includes methods to
///delete a message from the archive and to copy the Tagged Image File Format Class F (TIFF Class F) file associated
///with the fax message to a file on the local computer. The <b>IFaxIncomingMessage</b> interface is accessed through
///the IFaxIncomingArchive interface or IFaxIncomingMessageIterator interface.
@GUID("7CAB88FA-2EF9-4851-B2F3-1D148FED8447")
interface IFaxIncomingMessage : IDispatch
{
    ///The <b>Id</b> property is a null-terminated string that contains a unique ID for the inbound fax message. This
    ///property is read-only.
    HRESULT get_Id(BSTR* pbstrId);
    ///The <b>Pages</b> property is a value that indicates the total number of pages in the inbound fax message. This
    ///property is read-only.
    HRESULT get_Pages(int* plPages);
    ///The <b>Size</b> property is a value that indicates the size of the Tagged Image File Format Class F (TIFF Class
    ///F) file associated with the inbound fax message. This property is read-only.
    HRESULT get_Size(int* plSize);
    ///The <b>DeviceName</b> property is a null-terminated string that contains the name of the device on which the
    ///inbound fax message was received. This property is read-only.
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    ///The <b>Retries</b> property is a value that indicates the number of times that the fax service attempted to route
    ///an inbound fax message after the initial routing attempt failed. This property is read-only.
    HRESULT get_Retries(int* plRetries);
    ///The <b>TransmissionStart</b> property indicates the time that the inbound fax message began transmitting. This
    ///property is read-only.
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    ///The <b>TransmissionEnd</b> property indicates the time that the inbound fax message completed transmission. This
    ///property is read-only.
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    ///The <b>CSID</b> property is a null-terminated string that contains the called station identifier (CSID) for the
    ///inbound fax message. This property is read-only.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>TSID</b> property is a null-terminated string that contains the transmitting station identifier (TSID)
    ///associated with the inbound fax message. This property is read-only.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>CallerId</b> property is a null-terminated string that identifies the calling device associated with the
    ///inbound fax message. This property is read-only.
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    ///The <b>RoutingInformation</b> property is a null-terminated string that indicates inbound routing information for
    ///the fax message. This property is read-only.
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    ///The <b>CopyTiff</b> method copies the Tagged Image File Format Class F (TIFF Class F) file associated with the
    ///inbound fax message to a file on the local computer.
    ///Params:
    ///    bstrTiffPath = Type: <b>BSTR</b> Null-terminated <b>BSTR</b> that specifies a fully qualified path and file name on the
    ///                   local computer. The fax service will copy the TIFF Class F file associated with the inbound fax message to
    ///                   the specified file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyTiff(BSTR bstrTiffPath);
    ///The <b>Delete</b> method deletes the specified fax message from the inbound fax archive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Delete();
}

///The <b>IFaxOutgoingJobs</b> interface describes a messaging collection that is used by a fax client application to
///manage the outbound fax jobs in a fax server's job queue. Each outbound job is represented by a IFaxOutgoingJob
///interface.
@GUID("2C56D8E6-8C2F-4573-944C-E505F8F5AEED")
interface IFaxOutgoingJobs : IDispatch
{
    ///The <b>IFaxOutgoingJobs::get__NewEnum</b> method returns a reference to an enumerator object that you can use to
    ///iterate through the IFaxOutgoingJobs collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for this
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxOutgoingJobs::get_Item</b> method returns a IFaxOutgoingJob interface from the IFaxOutgoingJobs
    ///interface.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> Variant that specifies the item to retrieve from the collection. If this parameter is
    ///             type VT_I2 or VT_I4, the parameter specifies the index of the item to retrieve from the collection. The index
    ///             is 1-based. If this parameter is type VT_BSTR, the parameter is a job ID that specifies the outbound job to
    ///             retrieve. Other types are not supported.
    ///    pFaxOutgoingJob = Type: <b>IFaxOutgoingJob**</b> An address of a pointer that receives a IFaxOutgoingJob interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxOutgoingJob* pFaxOutgoingJob);
    ///The <b>IFaxOutgoingJobs::get_Count</b> property represents the number of objects in the FaxOutgoingJobs
    ///collection. This is the total number of outgoing jobs for the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///The <b>IFaxOutgoingJob</b> interface describes an object that is used by a fax client application to retrieve
///information about an outgoing fax job in a fax server's queue. The object also includes methods to cancel, pause,
///resume, or restart an outgoing fax job, and to copy the Tagged Image File Format Class F (TIFF Class F) file
///associated with an outbound fax job, to a file on the local computer.
@GUID("6356DAAD-6614-4583-BF7A-3AD67BBFC71C")
interface IFaxOutgoingJob : IDispatch
{
    ///The <b>IFaxOutgoingJob::get_Subject</b> property is a null-terminated string that contains the contents of the
    ///subject field on the cover page of the fax. This property is read-only.
    HRESULT get_Subject(BSTR* pbstrSubject);
    ///The <b>IFaxOutgoingJob::get_DocumentName</b> property is a null-terminated string that contains the user-friendly
    ///name to display for the fax document. This property is read-only.
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    ///The <b>IFaxOutgoingJob::get_Pages</b> property is a number that indicates the total number of pages in the
    ///outbound fax job. This property is read-only.
    HRESULT get_Pages(int* plPages);
    ///The <b>IFaxOutgoingJob::get_Size</b> property is a value that indicates the size of the Tagged Image File Format
    ///Class F (TIFF Class F) file associated with the outbound fax job. This property is read-only.
    HRESULT get_Size(int* plSize);
    ///The <b>IFaxOutgoingJob::get_SubmissionId</b> property is a null-terminated string that contains the unique
    ///identifier assigned to the fax job during the submission process. This property is read-only.
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    ///The <b>IFaxOutgoingJob::get_Id</b> property is a null-terminated string that contains a unique identifier for the
    ///outbound fax job. You can use the identifier to retrieve the archived fax message after the job completes
    ///successfully. This property is read-only.
    HRESULT get_Id(BSTR* pbstrId);
    ///The <b>IFaxOutgoingJob::get_OriginalScheduledTime</b> property specifies the time that the fax job was originally
    ///scheduled for transmission. This property is read-only.
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    ///The <b>IFaxOutgoingJob::get_SubmissionTime</b> property indicates the time that the outbound fax job was
    ///submitted for processing. This property is read-only.
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    ///The <b>IFaxOutgoingJob::get_ReceiptType</b> property is a value that specifies the type of delivery receipt to
    ///deliver when the fax message reaches a final state. The receipt type can be Simple Mail Transport Protocol (SMTP)
    ///mail, a message box, or no receipt. This property is read-only.
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    ///The <b>IFaxOutgoingJob::get_Priority</b> property specifies the priority to use when sending the fax; for
    ///example, normal, low, or high priority. This property is read-only.
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    ///The <b>IFaxOutgoingJob::get_Sender</b> property retrieves an object containing information about the sender of
    ///the fax. This property is read-only.
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    ///The <b>IFaxOutgoingJob::get_Recipient</b> property retrieves an interface to an object containing information
    ///about the recipient of the fax job. This property is read-only.
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    ///The <b>IFaxOutgoingJob::get_CurrentPage</b> property is a number that identifies the page that the fax service is
    ///actively transmitting on an outbound fax job. This property is read-only.
    HRESULT get_CurrentPage(int* plCurrentPage);
    ///The <b>IFaxOutgoingJob::get_DeviceId</b> property indicates the device ID of the device transmitting the outbound
    ///fax job. This property is read-only.
    HRESULT get_DeviceId(int* plDeviceId);
    ///The <b>IFaxOutgoingJob::get_Status</b> property is a number that indicates the current status of an outbound fax
    ///job in the job queue. This property is read-only.
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    ///The <b>IFaxOutgoingJob::get_ExtendedStatusCode</b> property specifies a code describing the job's extended
    ///status. This property is read-only.
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    ///The <b>IFaxOutgoingJob::get_ExtendedStatus</b> property is a null-terminated string that describes the job's
    ///extended status. This property is read-only.
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    ///The <b>IFaxOutgoingJob::get_AvailableOperations</b> property indicates the combination of valid operations that
    ///you can perform on the fax job, given its current status. This property is read-only.
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    ///The <b>IFaxOutgoingJob::get_Retries</b> property is a value that indicates the number of times that the fax
    ///service attempted to transmit an outgoing fax after the initial transmission attempt failed. This property is
    ///read-only.
    HRESULT get_Retries(int* plRetries);
    ///The <b>IFaxOutgoingJob::get_ScheduledTime</b> property indicates the time to submit the fax for processing to the
    ///fax service. This property is read-only.
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    ///The <b>IFaxOutgoingJob::get_TransmissionStart</b> property indicates the time that the fax outbound job began
    ///transmitting. This property will have a value only after the transmission has started. This property is
    ///read-only.
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    ///The <b>IFaxOutgoingJob::get_TransmissionEnd</b> property indicates the time that the outbound fax job completed
    ///transmission. This property is read-only.
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    ///The <b>IFaxOutgoingJob::get_CSID</b> property is a null-terminated string that contains the called station
    ///identifier (CSID) associated with the fax outbound job. This property is read-only.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>IFaxOutgoingJob::get_TSID</b> property is a null-terminated string that contains the transmitting station
    ///identifier (TSID) associated with the fax outbound job. This property is read-only.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>IFaxOutgoingJob::get_GroupBroadcastReceipts</b> property is a Boolean value that indicates whether to send
    ///an individual delivery receipt for each recipient of the broadcast or to send a summary receipt for all
    ///recipients. This property is read-only.
    HRESULT get_GroupBroadcastReceipts(short* pbGroupBroadcastReceipts);
    ///The <b>IFaxOutgoingJob::Pause</b> method pauses the outbound fax job.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Pause();
    ///The <b>IFaxOutgoingJob::Resume</b> method resumes the paused outbound fax job.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Resume();
    ///The <b>IFaxOutgoingJob::Restart</b> method restarts the failed outbound fax job. For example, if the fax job has
    ///exceeded the number of retries, <b>IFaxOutgoingJob::Restart</b> will restart the fax job.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Restart();
    ///The <b>IFaxOutgoingJob::CopyTiff</b> method copies the Tagged Image File Format Class F (TIFF Class F) file
    ///associated with the outbound fax job, to a file on the local computer.
    ///Params:
    ///    bstrTiffPath = Type: <b>BSTR</b> Null-terminated string that contains a fully qualified path and file name on the local
    ///                   computer. The fax service will copy the TIFF Class F file associated with the outbound fax to the specified
    ///                   file.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyTiff(BSTR bstrTiffPath);
    ///The Refresh method refreshes FaxOutgoingJob object information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxOutgoingJob::Cancel</b> method cancels the outbound fax job.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
}

///The <b>IFaxOutgoingMessageIterator</b> interface describes an object that is used by a fax client application to move
///through the archive of fax messages that the fax service has successfully transmitted, represented by
///FaxOutgoingMessage objects. Because the FaxOutgoingMessageIterator object is a forward iterator, you can only move
///forward through the archive, from beginning to end, and you can access only one message at a time.
@GUID("F5EC5D4F-B840-432F-9980-112FE42A9B7A")
interface IFaxOutgoingMessageIterator : IDispatch
{
    ///The <b>IFaxOutgoingMessageIterator::get_Message</b> property retrieves the outbound fax message under the archive
    ///cursor. This property is read-only.
    HRESULT get_Message(IFaxOutgoingMessage* pFaxOutgoingMessage);
    ///The AtEOF property is the end-of-file marker for the archive of outbound fax messages. This property is
    ///read-only.
    HRESULT get_AtEOF(short* pbEOF);
    ///The <b>IFaxOutgoingMessageIterator::get_PrefetchSize</b> property indicates the size of the prefetch (read-ahead)
    ///buffer. This determines how many fax messages the iterator object retrieves from the fax server when the object
    ///needs to refresh its contents. This property is read/write.
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    ///The <b>IFaxOutgoingMessageIterator::get_PrefetchSize</b> property indicates the size of the prefetch (read-ahead)
    ///buffer. This determines how many fax messages the iterator object retrieves from the fax server when the object
    ///needs to refresh its contents. This property is read/write.
    HRESULT put_PrefetchSize(int lPrefetchSize);
    ///The <b>IFaxOutgoingMessageIterator::MoveFirst</b> method moves the archive cursor to the first fax message in the
    ///outbound archive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveFirst();
    ///The <b>IFaxOutgoingMessageIterator::MoveNext</b> method moves the archive cursor to the next fax message in the
    ///outbound archive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT MoveNext();
}

///The <b>IFaxOutgoingMessage</b> interface describes an object that is used by a fax client application to retrieve
///information about a fax message in the archive of outbound faxes. The archive contains faxes transmitted successfully
///by the fax service. The object enables you to retrieve information about the fax recipient, contained in the
///FaxRecipient object, and information about the fax sender, contained in the FaxSender object. It also includes
///methods to delete a message from the archive and to copy the Tagged Image File Format Class F (TIFF Class F) file
///associated with the fax message, to a file on the local computer.
@GUID("F0EA35DE-CAA5-4A7C-82C7-2B60BA5F2BE2")
interface IFaxOutgoingMessage : IDispatch
{
    ///The <b>IFaxOutgoingMessage::get_SubmissionId</b> property is a null-terminated string that contains the unique
    ///identifier assigned to the fax message during the submission process. All fax jobs created by the same submission
    ///process share the same unique submission ID. This property is read-only.
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    ///The <b>IFaxOutgoingMessage::get_Id</b> property is a null-terminated string that contains a unique identifier for
    ///the outbound fax message. This property is read-only.
    HRESULT get_Id(BSTR* pbstrId);
    ///The <b>IFaxOutgoingMessage::get_Subject</b> property is a null-terminated string that contains the contents of
    ///the subject field on the cover page of the fax. This property is read-only.
    HRESULT get_Subject(BSTR* pbstrSubject);
    ///The <b>IFaxOutgoingMessage::get_DocumentName</b> property is a null-terminated string that contains the
    ///user-friendly name to display for the fax message. This property is read-only.
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    ///The <b>IFaxOutgoingMessage::get_Retries</b> property is a value that indicates the number of times that the fax
    ///service attempted to transmit an outgoing fax after the initial transmission attempt failed. This property is
    ///read-only.
    HRESULT get_Retries(int* plRetries);
    ///The <b>IFaxOutgoingMessage::get_Pages</b> property is a number that indicates the total number of pages in the
    ///outbound fax message. This property is read-only.
    HRESULT get_Pages(int* plPages);
    ///The Size property is a value that indicates the size of the Tagged Image File Format Class F (TIFF Class F) file
    ///associated with the outbound fax message. This property is read-only.
    HRESULT get_Size(int* plSize);
    ///The <b>IFaxOutgoingMessage::get_OriginalScheduledTime</b> property specifies the time that the fax message was
    ///originally scheduled for transmission. This property is read-only.
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    ///The <b>IFaxOutgoingMessage::get_SubmissionTime</b> property indicates the time that the outbound fax message was
    ///submitted for processing. This property is read-only.
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    ///The <b>IFaxOutgoingMessage::get_Priority</b> property specifies the priority used when sending the fax; for
    ///example, normal, low, or high priority. This property is read-only.
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    ///The <b>IFaxOutgoingMessage::get_Sender</b> property retrieves an interface containing information about the
    ///sender of the fax message. This property is read-only.
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    ///The <b>IFaxOutgoingMessage::get_Recipient</b> property retrieves an interface containing information about the
    ///recipient of the fax message. This property is read-only.
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    ///The <b>IFaxOutgoingMessage::get_DeviceName</b> property is a null-terminated string that contains the name of the
    ///device on which the fax message was transmitted. This property is read-only.
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    ///The <b>IFaxOutgoingMessage::get_TransmissionStart</b> property indicates the time that the fax outbound message
    ///began transmitting. This property is read-only.
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    ///The <b>IFaxOutgoingMessage::get_TransmissionEnd</b> property indicates the time that the fax outbound message
    ///completed transmission. This property is read-only.
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    ///The <b>IFaxOutgoingMessage::get_CSID</b> property is a null-terminated string that contains the called station
    ///identifier (CSID) for the fax message. This property is read-only.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>IFaxOutgoingMessage::get_TSID</b> property is a null-terminated string that contains the transmitting
    ///station identifier (TSID) associated with the fax outbound message. This property is read-only.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>IFaxOutgoingMessage::CopyTiff</b> method copies the Tagged Image File Format Class F (TIFF Class F) file
    ///associated with the outbound fax message, to a file on the local computer.
    ///Params:
    ///    bstrTiffPath = Type: <b>BSTR</b> Null-terminated string that contains a fully qualified path and file name on the local
    ///                   computer. This is the file on the local computer to which the fax service will copy the TIFF Class F file
    ///                   associated with the outbound fax message.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyTiff(BSTR bstrTiffPath);
    ///The <b>IFaxOutgoingMessage::Delete</b> method deletes the fax message from the outbound archive.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Delete();
}

///The <b>IFaxIncomingJobs</b> interface is used by a fax client application to manage the inbound fax jobs in a fax
///server's job queue. Each incoming job is represented by a FaxIncomingJob object. The <b>IFaxIncomingJobs</b>
///interface is accessed through the IFaxIncomingQueue interface.
@GUID("011F04E9-4FD6-4C23-9513-B6B66BB26BE9")
interface IFaxIncomingJobs : IDispatch
{
    ///The <b>get__NewEnum</b> method returns a reference to an enumerator object that you can use to iterate through
    ///the FaxIncomingJobs collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///Retrieves a FaxIncomingJob object from the FaxIncomingJobs collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies a value that indicates the item to retrieve from the
    ///             collection. If this parameter is type <b>VT_I2</b> or <b>VT_I4</b>, it specifies the index of the item to
    ///             retrieve. The index is 1-based. If this parameter is type <b>VT_BSTR</b>, it specifies a job ID to use to
    ///             search the collection. Other types are not supported.
    ///    pFaxIncomingJob = Type: <b>IFaxIncomingJob**</b> Receives an indirect pointer to a FaxIncomingJob object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxIncomingJob* pFaxIncomingJob);
    ///The <b>Count</b> property represents the number of objects in the FaxIncomingJobs collection. This is the total
    ///number of incoming jobs for the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///The <b>IFaxIncomingJob</b> interface is used by a fax client application to retrieve information about an incoming
///fax job in a fax server's queue. The interface also includes methods to cancel an incoming fax job and to copy the
///Tagged Image File Format Class F (TIFF Class F) file associated with an inbound fax job to a file on the local
///computer. The <b>IFaxIncomingJob</b> interface is accessed through the IFaxIncomingJobs interface.
@GUID("207529E6-654A-4916-9F88-4D232EE8A107")
interface IFaxIncomingJob : IDispatch
{
    ///The <b>Size</b> property is a value that indicates the size of the Tagged Image File Format Class F (TIFF Class
    ///F) file associated with the inbound fax job. This property is read-only.
    HRESULT get_Size(int* plSize);
    ///The <b>Id</b> property is a null-terminated string that contains a unique ID for the inbound fax job. This
    ///property is read-only.
    HRESULT get_Id(BSTR* pbstrId);
    ///The <b>CurrentPage</b> property is a number that identifies the page that the fax service is actively receiving
    ///on an inbound fax job. This property is read-only.
    HRESULT get_CurrentPage(int* plCurrentPage);
    ///The <b>DeviceId</b> property indicates the device ID of the device receiving the inbound fax job. This property
    ///is read-only.
    HRESULT get_DeviceId(int* plDeviceId);
    ///Retrieves the <b>Status</b> property of a FaxIncomingJob object. The <b>Status</b> property is a number that
    ///indicates the current status of an inbound fax job in the job queue.
    ///Params:
    ///    pStatus = Type: <b>FAX_JOB_STATUS_ENUM*</b> Pointer to a value from the FAX_JOB_STATUS_ENUM enumeration that specifies
    ///              the current status of an inbound fax job in the job queue.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    ///Retrieves the <b>ExtendedStatusCode</b> property of a FaxIncomingJob object. The <b>ExtendedStatusCode</b>
    ///property specifies a code describing the job's extended status.
    ///Params:
    ///    pExtendedStatusCode = Type: <b>FAX_JOB_EXTENDED_STATUS_ENUM*</b> Pointer to a value from the FAX_JOB_EXTENDED_STATUS_ENUM
    ///                          enumeration that specifies the extended job status.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    ///The <b>ExtendedStatus</b> property is a null-terminated string that describes the job's extended status. This
    ///property is read-only.
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    ///Retrieves the <b>AvailableOperations</b> property of a FaxIncomingJob object. The <b>AvailableOperations</b>
    ///property indicates the combination of valid operations that you can perform on the fax job given its current
    ///status.
    ///Params:
    ///    pAvailableOperations = Type: <b>FAX_JOB_OPERATIONS_ENUM*</b> Pointer to a <b>long</b> value from the FAX_JOB_OPERATIONS_ENUM
    ///                           enumeration that specifies a bitwise combination of the operations that you can currently perform on the fax
    ///                           job. Some operations are mutually exclusive. For example, you cannot pause a job that has already been
    ///                           paused.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    ///The <b>Retries</b> property is a value that indicates the number of times the fax service attempted to route an
    ///incoming fax when the initial routing attempt failed. This property is read-only.
    HRESULT get_Retries(int* plRetries);
    ///The <b>TransmissionStart</b> property indicates the time that the fax inbound job began transmitting. This
    ///property is read-only.
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    ///The <b>TransmissionEnd</b> property indicates the time at which the inbound fax job completed transmission. This
    ///property is read-only.
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    ///The <b>CSID</b> property is a null-terminated string that contains the called station identifier (CSID) for the
    ///job. This property is read-only.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>TSID</b> property is a null-terminated string that contains the transmitting station identifier (TSID)
    ///associated with the fax inbound job. This property is read-only.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>CallerId</b> property is a string that identifies the calling device that sent the inbound fax job. This
    ///property is read-only.
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    ///The <b>RoutingInformation</b> property is a null-terminated string that specifies routing information for the
    ///inbound fax job. This property is read-only.
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    ///Retrieves the <b>JobType</b> property of a FaxIncomingJob object. The JobType property describes the type of fax
    ///job; for example, the job can be a receive job, a send job, or a routing job.
    ///Params:
    ///    pJobType = Type: <b>FAX_JOB_TYPE_ENUM*</b> Pointer to a value from the FAX_JOB_TYPE_ENUM enumeration that specifies the
    ///               fax job type.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    ///The <b>Cancel</b> method cancels the incoming fax job.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Cancel();
    ///The <b>Refresh</b> method refreshes FaxIncomingJob object information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>CopyTiff</b> method copies the Tagged Image File Format Class F (TIFF Class F) file associated with the
    ///inbound fax job to a file on the local computer.
    ///Params:
    ///    bstrTiffPath = Type: <b>BSTR</b> Null-terminated string that specifies a fully qualified path and file name on the local
    ///                   computer.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT CopyTiff(BSTR bstrTiffPath);
}

///The <b>IFaxDeviceProvider</b> interface defines a configuration object used by a fax client application to retrieve
///information about a fax service provider (FSP) registered with the fax service.
@GUID("290EAC63-83EC-449C-8417-F148DF8C682A")
interface IFaxDeviceProvider : IDispatch
{
    ///The <b>IFaxDeviceProvider::get_FriendlyName</b> property is a null-terminated string that contains the
    ///user-friendly name for the fax service provider (FSP). This string is suitable for display to users. This
    ///property is read-only.
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    ///The <b>IFaxDeviceProvider::get_ImageName</b> property is a null-terminated string that contains the executable
    ///image name (DLL path and file name) of the fax service provider (FSP). This property is read-only.
    HRESULT get_ImageName(BSTR* pbstrImageName);
    ///The <b>IFaxDeviceProvider::get_UniqueName</b> property is a null-terminated string that contains the unique name
    ///that identifies the fax service provider (FSP). This property is read-only.
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    ///The <b>IFaxDeviceProvider::get_TapiProviderName</b> property is a null-terminated string that contains the name
    ///of the telephony service provider (TSP) associated with the fax service provider (FSP) fax devices. This property
    ///is read-only.
    HRESULT get_TapiProviderName(BSTR* pbstrTapiProviderName);
    ///The <b>IFaxDeviceProvider::get_MajorVersion</b> property is a value that specifies the major part of the version
    ///number for the fax service provider (FSP)Â DLL. This property is read-only.
    HRESULT get_MajorVersion(int* plMajorVersion);
    ///The <b>IFaxDeviceProvider::get_MinorVersion</b> property is a value that specifies the minor part of the version
    ///number for the fax service provider (FSP)Â DLL. This property is read-only.
    HRESULT get_MinorVersion(int* plMinorVersion);
    ///The <b>IFaxDeviceProvider::get_MajorBuild</b> property is a value that specifies the major part of the build
    ///number for the fax service provider (FSP)Â DLL. This property is read-only.
    HRESULT get_MajorBuild(int* plMajorBuild);
    ///The <b>IFaxDeviceProvider::get_MinorBuild</b> property is a value that specifies the minor part of the build
    ///number for the fax service provider (FSP)Â DLL. This property is read-only.
    HRESULT get_MinorBuild(int* plMinorBuild);
    ///The <b>IFaxDeviceProvider::get_Debug</b> property is a Boolean value that indicates whether the fax service
    ///provider (FSP)Â DLL was created in a debug environment. This property is read-only.
    HRESULT get_Debug(short* pbDebug);
    ///The <b>IFaxDeviceProvider::get_Status</b> property is a number that indicates whether the fax service provider
    ///(FSP) loaded and initialized successfully. This property is read-only.
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    ///The <b>IFaxDeviceProvider::get_InitErrorCode</b> property is a value that specifies the last error code that the
    ///fax service provider (FSP) returned while the fax service was loading and initializing the FSPÂ DLL. This may be
    ///an HRESULT value or a Win32 error code. This property is read-only.
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    ///The <b>IFaxDeviceProvider::get_DeviceIds</b> property returns a variant safe array of long (VT_I4 | VT_ARRAY).
    ///Each long value in the array is a device ID. This property is read-only.
    HRESULT get_DeviceIds(VARIANT* pvDeviceIds);
}

///The <b>IFaxDevice</b> interface defines a configuration object used by a fax client application to retrieve and set
///fax device information, and to add and remove fax routing methods associated with a fax device. The object also
///includes methods to retrieve and set extension configuration properties stored at the device level. The object
///defined by the <b>IFaxDevice</b> interface represents a single device associated with a fax server.
@GUID("49306C59-B52E-4867-9DF4-CA5841C956D0")
interface IFaxDevice : IDispatch
{
    ///The Id <b>IFaxDevice::get_Id</b> is a numeric value that uniquely identifies a fax device. This property is
    ///read-only.
    HRESULT get_Id(int* plId);
    ///The <b>IFaxDevice::get_DeviceName</b> property is a null-terminated string that contains the name of the fax
    ///device. This property is read-only.
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    ///The <b>IFaxDevice::get_ProviderUniqueName</b> property is a null-terminated string that contains the unique name
    ///for the fax service provider (FSP) associated with the device. This property is read-only.
    HRESULT get_ProviderUniqueName(BSTR* pbstrProviderUniqueName);
    ///The <b>IFaxDevice::get_PoweredOff</b> property is a Boolean value that indicates whether the fax device is
    ///currently available for sending and receiving faxes. This property is read-only.
    HRESULT get_PoweredOff(short* pbPoweredOff);
    ///The <b>IFaxDevice::get_ReceivingNow</b> property is a Boolean value that indicates whether the fax device is
    ///receiving a fax at the moment the property is retrieved (the status could change immediately thereafter). This
    ///property is read/write.
    HRESULT get_ReceivingNow(short* pbReceivingNow);
    ///The <b>IFaxDevice::get_SendingNow</b> property is a Boolean value that indicates whether the fax device is
    ///sending a fax at the moment the property is retrieved (the status could change immediately thereafter). <div
    ///class="alert"><b>Note</b> The value of this property is set at the time that the FaxDevice object is created and
    ///is refreshed when you call the IFaxDevice::Refresh method.</div><div> </div>This property is read-only.
    HRESULT get_SendingNow(short* pbSendingNow);
    ///The <b>IFaxDevice::get_UsedRoutingMethods</b> property is an array of strings that contains the GUIDs associated
    ///with the routing methods that the device uses, where each GUID represents an inbound routing method
    ///(FaxInboundRoutingMethod). This property is read-only.
    HRESULT get_UsedRoutingMethods(VARIANT* pvUsedRoutingMethods);
    ///The <b>IFaxDevice::get_Description</b> property is a null-terminated string that contains a user-friendly
    ///description for the fax device. This string is suitable for display to users. This property is read/write.
    HRESULT get_Description(BSTR* pbstrDescription);
    ///The <b>IFaxDevice::get_Description</b> property is a null-terminated string that contains a user-friendly
    ///description for the fax device. This string is suitable for display to users. This property is read/write.
    HRESULT put_Description(BSTR bstrDescription);
    ///The <b>IFaxDevice::get_SendEnabled</b> property is a Boolean value that indicates whether the fax device is
    ///enabled for sending faxes. This property is read/write.
    HRESULT get_SendEnabled(short* pbSendEnabled);
    ///The <b>IFaxDevice::get_SendEnabled</b> property is a Boolean value that indicates whether the fax device is
    ///enabled for sending faxes. This property is read/write.
    HRESULT put_SendEnabled(short bSendEnabled);
    ///The ReceiveMode property is a value from the FAX_DEVICE_RECEIVE_MODE_ENUM enumeration that defines the way a
    ///device answers an incoming call. The value assigned to this property indicates whether the device does not answer
    ///the call, the device can answer the call manually, or the device answers the call automatically. This property is
    ///read/write.
    HRESULT get_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM* pReceiveMode);
    ///The ReceiveMode property is a value from the FAX_DEVICE_RECEIVE_MODE_ENUM enumeration that defines the way a
    ///device answers an incoming call. The value assigned to this property indicates whether the device does not answer
    ///the call, the device can answer the call manually, or the device answers the call automatically. This property is
    ///read/write.
    HRESULT put_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM ReceiveMode);
    ///The <b>IFaxDevice::get_RingsBeforeAnswer</b> property is a number that specifies the number of rings that occur
    ///before the fax device answers an incoming fax call. This property is read/write.
    HRESULT get_RingsBeforeAnswer(int* plRingsBeforeAnswer);
    ///The <b>IFaxDevice::get_RingsBeforeAnswer</b> property is a number that specifies the number of rings that occur
    ///before the fax device answers an incoming fax call. This property is read/write.
    HRESULT put_RingsBeforeAnswer(int lRingsBeforeAnswer);
    ///The <b>IFaxDevice::get_CSID</b> property is a null-terminated string that contains the called station identifier
    ///(CSID) for the device. This property is read/write.
    HRESULT get_CSID(BSTR* pbstrCSID);
    ///The <b>IFaxDevice::get_CSID</b> property is a null-terminated string that contains the called station identifier
    ///(CSID) for the device. This property is read/write.
    HRESULT put_CSID(BSTR bstrCSID);
    ///The <b>IFaxDevice::get_TSID</b> property is a null-terminated string that contains the transmitting station
    ///identifier (TSID) for the device. This property is read/write.
    HRESULT get_TSID(BSTR* pbstrTSID);
    ///The <b>IFaxDevice::get_TSID</b> property is a null-terminated string that contains the transmitting station
    ///identifier (TSID) for the device. This property is read/write.
    HRESULT put_TSID(BSTR bstrTSID);
    ///The <b>IFaxDevice::Refresh</b> method refreshes FaxDevice object information from the fax server. When the
    ///<b>IFaxDevice::Refresh</b> method is called, any configuration changes made after the last IFaxDevice::Save
    ///method call are lost.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxDevice::Save</b> method saves the FaxDevice object's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///The <b>IFaxDevice::get_GetExtensionProperty</b> method retrieves an extension configuration property stored at
    ///the device level.
    ///Params:
    ///    bstrGUID = Type: <b>BSTR</b> Specifies a string GUID that uniquely identifies the data to be retrieved.
    ///    pvProperty = Type: <b>VARIANT*</b> <b>VARIANT</b> that specifies the data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    ///The <b>IFaxDevice::SetExtensionProperty</b> method stores an extension configuration property at the device
    ///level.
    ///Params:
    ///    bstrGUID = Type: <b>BSTR</b> Specifies a string GUID that identifies the data to set.
    ///    vProperty = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies the data to be stored.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    ///The <b>IFaxDevice::UseRoutingMethod</b> method adds an inbound fax routing method to or removes a fax routing
    ///method (FaxInboundRoutingMethod) from the list of routing methods associated with the fax device.
    ///Params:
    ///    bstrMethodGUID = Type: <b>BSTR</b> Specifies a null-terminated string that uniquely identifies the fax routing method to add
    ///                     or remove.
    ///    bUse = Type: <b>VARIANT_BOOL</b> Specifies a Boolean value. If this parameter is equal to <b>TRUE</b>, the method
    ///           adds the fax routing method to the list of inbound methods associated with the fax device. If you set this
    ///           parameter to <b>FALSE</b>, the method removes the routing method from the list.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT UseRoutingMethod(BSTR bstrMethodGUID, short bUse);
    ///The <b>IFaxDevice::get_RingingNow</b> property is a Boolean value that indicates whether the fax device is
    ///ringing at the moment the property is retrieved (the status could change immediately thereafter). This property
    ///is read-only.
    HRESULT get_RingingNow(short* pbRingingNow);
    ///The <b>IFaxDevice::AnswerCall</b> method causes the fax device to answer an incoming call.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AnswerCall();
}

///The <b>IFaxActivityLogging</b> interface defines a configuration object used by a fax client application to retrieve
///and set options for activity logging. This includes setting whether entries for incoming and outgoing faxes should be
///logged and the location of the log file.
@GUID("1E29078B-5A69-497B-9592-49B7E7FADDB5")
interface IFaxActivityLogging : IDispatch
{
    ///The <b>IFaxActivityLogging::get_LogIncoming</b> property is a Boolean value that indicates whether the fax
    ///service logs entries for incoming faxes in the activity log database. This property is read/write.
    HRESULT get_LogIncoming(short* pbLogIncoming);
    ///The <b>IFaxActivityLogging::get_LogIncoming</b> property is a Boolean value that indicates whether the fax
    ///service logs entries for incoming faxes in the activity log database. This property is read/write.
    HRESULT put_LogIncoming(short bLogIncoming);
    ///The <b>IFaxActivityLogging::get_LogOutgoing</b> property is a Boolean value that indicates whether the fax
    ///service logs entries for outgoing faxes in the activity log database. This property is read/write.
    HRESULT get_LogOutgoing(short* pbLogOutgoing);
    ///The <b>IFaxActivityLogging::get_LogOutgoing</b> property is a Boolean value that indicates whether the fax
    ///service logs entries for outgoing faxes in the activity log database. This property is read/write.
    HRESULT put_LogOutgoing(short bLogOutgoing);
    ///The <b>IFaxActivityLogging::get_DatabasePath</b> property is a null-terminated string that contains the path to
    ///the activity log database file. This property is read/write.
    HRESULT get_DatabasePath(BSTR* pbstrDatabasePath);
    ///The <b>IFaxActivityLogging::get_DatabasePath</b> property is a null-terminated string that contains the path to
    ///the activity log database file. This property is read/write.
    HRESULT put_DatabasePath(BSTR bstrDatabasePath);
    ///The <b>IFaxActivityLogging::Refresh</b> method refreshes FaxActivityLogging object information from the fax
    ///server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxActivityLogging::Save</b> method saves the FaxActivityLogging object's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
}

///The <b>IFaxEventLogging</b> interface defines a configuration object used by a fax client application to configure
///the event logging categories used by the fax service. You can specify the level of detail at which the fax service
///logs events in the application log.
@GUID("0880D965-20E8-42E4-8E17-944F192CAAD4")
interface IFaxEventLogging : IDispatch
{
    ///The <b>IFaxEventLogging::get_InitEventsLevel</b> property indicates the level of detail at which the fax service
    ///logs initialization (starting the server) and termination (shutting down the server) events in the application
    ///log. This property is read/write.
    HRESULT get_InitEventsLevel(FAX_LOG_LEVEL_ENUM* pInitEventLevel);
    ///The <b>IFaxEventLogging::get_InitEventsLevel</b> property indicates the level of detail at which the fax service
    ///logs initialization (starting the server) and termination (shutting down the server) events in the application
    ///log. This property is read/write.
    HRESULT put_InitEventsLevel(FAX_LOG_LEVEL_ENUM InitEventLevel);
    ///The <b>IFaxEventLogging::get_InboundEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs events about inbound fax transmissions in the application log. This property is read/write.
    HRESULT get_InboundEventsLevel(FAX_LOG_LEVEL_ENUM* pInboundEventLevel);
    ///The <b>IFaxEventLogging::get_InboundEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs events about inbound fax transmissions in the application log. This property is read/write.
    HRESULT put_InboundEventsLevel(FAX_LOG_LEVEL_ENUM InboundEventLevel);
    ///The <b>IFaxEventLogging::get_OutboundEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs events about outbound fax transmissions in the application log. This property is read/write.
    HRESULT get_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM* pOutboundEventLevel);
    ///The <b>IFaxEventLogging::get_OutboundEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs events about outbound fax transmissions in the application log. This property is read/write.
    HRESULT put_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM OutboundEventLevel);
    ///The <b>IFaxEventLogging::get_GeneralEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs general events in the application log. General events include those that are not related to
    ///initialization and termination or to inbound and outbound transmissions. This property is read/write.
    HRESULT get_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM* pGeneralEventLevel);
    ///The <b>IFaxEventLogging::get_GeneralEventsLevel</b> property indicates the level of detail at which the fax
    ///service logs general events in the application log. General events include those that are not related to
    ///initialization and termination or to inbound and outbound transmissions. This property is read/write.
    HRESULT put_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM GeneralEventLevel);
    ///The <b>IFaxEventLogging::Refresh</b> method refreshes IFaxEventLogging interface information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxEventLogging::Save</b> method saves the IFaxEventLogging interface's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
}

///The <b>IFaxOutboundRoutingGroups</b> interface describes a configuration collection used by a fax client application
///to manage the fax outbound routing groups, represented by IFaxOutboundRoutingGroup interfaces. The interface also
///includes methods to add and remove groups from the collection. <div class="alert"><b>Note</b> The outbound routing
///group <b>All Devices</b> is always the first object in this collection. You cannot remove the <b>All Devices</b>
///group from the collection. If you attempt to remove it, you will receive an error message. </div><div> </div>
@GUID("235CBEF7-C2DE-4BFD-B8DA-75097C82C87F")
interface IFaxOutboundRoutingGroups : IDispatch
{
    ///The <b>IFaxOutboundRoutingGroups::get__NewEnum</b> method returns a reference to an enumerator object that you
    ///can use to iterate through the FaxOutboundRoutingGroups collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for this
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxOutboundRoutingGroups::get_Item</b> method returns a IFaxOutboundRoutingGroup interface from the
    ///collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> Variant that specifies the item to retrieve from the collection. If this parameter is
    ///             type VT_I2 or VT_I4, the parameter specifies the index of the item to retrieve from the collection. The index
    ///             is 1-based. If this parameter is type VT_BSTR, the parameter is a unique name that identifies the outbound
    ///             routing group to retrieve. Other types are not supported.
    ///    pFaxOutboundRoutingGroup = Type: <b>IFaxOutboundRoutingGroup**</b> An address of a pointer that receives the IFaxOutboundRoutingGroup
    ///                               interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    ///The <b>Count</b> property represents the number of objects in the FaxOutboundRoutingGroups collection. This is
    ///the total number of outbound routing groups associated with the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
    ///The <b>IFaxOutboundRoutingGroups::Add</b> method adds an outbound routing group to the collection represented by
    ///the IFaxOutboundRoutingGroups interface.
    ///Params:
    ///    bstrName = Type: <b>BSTR</b> Null-terminated string that indicates the name of the group to add. Note that you cannot
    ///               add the special <b>All Devices</b> routing group.
    ///    pFaxOutboundRoutingGroup = Type: <b>IFaxOutboundRoutingGroup**</b> Address of a pointer that receives a IFaxOutboundRoutingGroup
    ///                               interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(BSTR bstrName, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    ///The <b>Remove</b> method removes an item from the FaxOutboundRoutingGroups collection. <div
    ///class="alert"><b>Note</b> You cannot remove the special <b>All Devices</b> routing group.</div><div> </div>
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> Variant that specifies the item to remove from the collection. If this parameter is type
    ///             VT_I2 or VT_I4, it specifies the index of the item to remove from the collection. Valid values for this
    ///             parameter are in the range from 1 to n, where n is the number of objects returned by a call to the
    ///             IFaxOutboundRoutingGroups::get_Count method. The index is 1-based. If this parameter is type VT_BSTR, the
    ///             parameter is a unique name that identifies the outbound routing group to remove. Other types are not
    ///             supported.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(VARIANT vIndex);
}

///The <b>IFaxOutboundRoutingGroup</b> interface describes a configuration object that is used by a fax client
///application to retrieve information about an individual fax outbound routing group. The object also includes a method
///to retrieve the ordered collection of device IDs (IFaxDeviceIds interfaces) that participate in the routing group.
///The order of the devices in the collection determines the relative order in which available devices send outgoing
///transmissions.
@GUID("CA6289A1-7E25-4F87-9A0B-93365734962C")
interface IFaxOutboundRoutingGroup : IDispatch
{
    ///The <b>Name</b> property is a null-terminated string that specifies the name of the outbound routing group. This
    ///property is read-only.
    HRESULT get_Name(BSTR* pbstrName);
    ///The <b>Status</b> property indicates the collective status of the fax devices in the outbound routing group. This
    ///property is read-only.
    HRESULT get_Status(FAX_GROUP_STATUS_ENUM* pStatus);
    ///The <b>DeviceIds</b> property retrieves an interface that represents the ordered collection of device IDs that
    ///participate in the outbound routing group. The order of the devices in the collection determines the relative
    ///order in which available devices send outgoing transmissions. This property is read-only.
    HRESULT get_DeviceIds(IFaxDeviceIds* pFaxDeviceIds);
}

///The <b>IFaxDeviceIds</b> interface defines a configuration collection used by a fax client application to enumerate
///the ordered fax device IDs associated with a FaxOutboundRoutingGroup object. The collection includes methods to add,
///remove, and change the order of devices. The order of the devices in the collection determines the relative order in
///which available fax devices send outgoing transmissions.
@GUID("2F0F813F-4CE9-443E-8CA1-738CFAEEE149")
interface IFaxDeviceIds : IDispatch
{
    ///The <b>IFaxDeviceIds::get__NewEnum</b> method returns a reference to an enumerator object that you can use to
    ///iterate through the FaxDeviceIds collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxDeviceIds::get_Item</b> method represents a device ID from the FaxDeviceIds collection.
    ///Params:
    ///    lIndex = Type: <b>long</b> A value specifying the item to retrieve from the collection. Valid values for this
    ///             parameter are in the range from 1 to n, where n is the number of devices returned by a call to the
    ///             IFaxDeviceIds::get_Count method.
    ///    plDeviceId = Type: <b>long*</b> Pointer to a value that receives the item requested.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(int lIndex, int* plDeviceId);
    ///The <b>IFaxDeviceIds::get_Count</b> property represents the number of objects in the FaxDeviceIds collection.
    ///This is the total number of device IDs associated with the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
    ///The <b>IFaxDeviceIds::Add</b> method adds a fax device to the FaxDeviceIds collection, using the device's ID.
    ///Params:
    ///    lDeviceId = Type: <b>long</b> A <b>long</b> value that specifies the ID of the fax device to add to the collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(int lDeviceId);
    ///The <b>IFaxDeviceIds::Remove</b> method removes an item from the FaxDeviceIds collection.
    ///Params:
    ///    lIndex = Type: <b>long</b> A <b>long</b> value that specifies the index of the item to remove from the collection.
    ///             Valid values for this parameter are in the range from 1 to n, where n is the number of devices returned by a
    ///             call to the IFaxDeviceIds::get_Count property.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(int lIndex);
    ///The <b>IFaxDeviceIds::SetOrder</b> method changes the order of a device in the ordered FaxDeviceIds collection.
    ///Params:
    ///    lDeviceId = Type: <b>long</b> Specifies the device ID of the device whose order you want to change.
    ///    lNewOrder = Type: <b>long</b> Specifies the new position of the device in the order.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT SetOrder(int lDeviceId, int lNewOrder);
}

///The <b>IFaxOutboundRoutingRules</b> interface describes a configuration collection that is used by a fax client
///application to manage the fax outbound routing rules. The collection also includes methods to add and remove rules
///from the collection. Each outbound routing rule is represented by a IFaxOutboundRoutingRule interface.
@GUID("DCEFA1E7-AE7D-4ED6-8521-369EDCCA5120")
interface IFaxOutboundRoutingRules : IDispatch
{
    ///The <b>IFaxOutboundRoutingRules::get__NewEnum</b> method returns a reference to an enumerator object that you can
    ///use to iterate through the FaxOutboundRoutingRules collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object IUnknown interface for this
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxOutboundRoutingRules::get_Item</b> method returns a IFaxOutboundRoutingRule interface from the
    ///IFaxOutboundRoutingRules interface using the routing rule's index.
    ///Params:
    ///    lIndex = Type: <b>long</b> A <b>long</b> value that specifies the outbound routing rule to retrieve from the
    ///             collection. Valid values for this parameter are in the range from 1 to n, where n is the number of items
    ///             returned by a call to the IFaxOutboundRoutingRules::get_Count method.
    ///    pFaxOutboundRoutingRule = Type: <b>IFaxOutboundRoutingRule**</b> An address of a pointer that receives the IFaxOutboundRoutingRule
    ///                              interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(int lIndex, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    ///The <b>IFaxOutboundRoutingRules::get_Count</b> property represents the number of objects in the
    ///FaxOutboundRoutingRules collection. This is the total number of outbound routing rules associated with the fax
    ///server. This property is read-only.
    HRESULT get_Count(int* plCount);
    ///The <b>IFaxOutboundRoutingRules::get_ItemByCountryAndArea</b> method returns an outbound routing rule
    ///(FaxOutboundRoutingRule object) from the collection using the routing rule's country/region code and area code.
    ///Params:
    ///    lCountryCode = Type: <b>long</b> A <b>long</b> value that specifies the country/region code of the outbound routing rule to
    ///                   retrieve. Specifying frrcANY_CODE will return a rule for any country/region code.
    ///    lAreaCode = Type: <b>long</b> A <b>long</b> value that specifies the area code of the outbound routing rule to retrieve.
    ///                Specifying frrcANY_CODE will return a rule for any area code within the specified country/region code.
    ///    pFaxOutboundRoutingRule = Type: <b>FaxOutboundRoutingRule**</b> A FaxOutboundRoutingRule object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ItemByCountryAndArea(int lCountryCode, int lAreaCode, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    ///The <b>IFaxOutboundRoutingRules::RemoveByCountryAndArea</b> method removes an outbound routing rule
    ///(FaxOutboundRoutingRule object) from the collection using the routing rule's country/region code and area code.
    ///Params:
    ///    lCountryCode = Type: <b>long</b> A <b>long</b> value that specifies the country/region code of the outbound routing rule to
    ///                   remove from the collection. Specifying frrcANY_CODE will remove a rule that applies to all country/region
    ///                   codes.
    ///    lAreaCode = Type: <b>long</b> A <b>long</b> value that specifies the area code of the outbound routing rule to remove
    ///                from the collection. Specifying frrcANY_CODE will remove a rule that applies to all area codes within the
    ///                specified country/region code.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveByCountryAndArea(int lCountryCode, int lAreaCode);
    ///The <b>IFaxOutboundRoutingRules::Remove</b> method removes an outbound routing rule (FaxOutboundRoutingRule
    ///object) from the FaxOutboundRoutingRules collection using the routing rule's index.
    ///Params:
    ///    lIndex = Type: <b>long</b> A <b>long</b> value that specifies the index of the outbound routing rule to remove from
    ///             the collection. Valid values for this parameter are in the range from 1 to n, where n is the number of rules
    ///             returned by a call to the IFaxOutboundRoutingRules::get_Count method.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Remove(int lIndex);
    ///The <b>IFaxOutboundRoutingRules::Add</b> method adds an outbound routing rule (IFaxOutboundRoutingRule interface)
    ///to the collection defined by the IFaxOutboundRoutingRules interface.
    ///Params:
    ///    lCountryCode = Type: <b>long</b> A <b>long</b> value that specifies the country/region code to associate with the outbound
    ///                   routing rule. Specifying frrcANY_CODE will add a rule that applies to any country/region code.
    ///    lAreaCode = Type: <b>long</b> Specifies a <b>long</b> value that indicates the area code to associate with the outbound
    ///                routing rule. Specifying frrcANY_CODE will add a rule that applies to any area code within the specified
    ///                country/region code.
    ///    bUseDevice = Type: <b>VARIANT_BOOL</b> Specifies a Boolean value that indicates whether the outbound routing rule points
    ///                 to a single fax device rather than to a group of devices.
    ///    bstrGroupName = Type: <b>BSTR</b> Specifies a null-terminated string that contains the name of the outbound routing group to
    ///                    which the new routing rule belongs. If <i>bUseDevice</i> is set to <b>TRUE</b>, this should be an empty
    ///                    string.
    ///    lDeviceId = Type: <b>long</b> Specifies the device to associate with the outbound routing rule. If <i>bUseDevice</i> is
    ///                set to <b>FALSE</b>, this parameter is ignored.
    ///    pFaxOutboundRoutingRule = Type: <b>IFaxOutboundRoutingRule**</b> An address of a pointer that receives a IFaxOutboundRoutingRule
    ///                              interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Add(int lCountryCode, int lAreaCode, short bUseDevice, BSTR bstrGroupName, int lDeviceId, 
                IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
}

///The <b>IFaxOutboundRoutingRule</b> interface describes a configuration object that is used by a fax client
///application to set and retrieve information about an individual fax outbound routing rule.
@GUID("E1F795D5-07C2-469F-B027-ACACC23219DA")
interface IFaxOutboundRoutingRule : IDispatch
{
    ///The <b>IFaxOutboundRoutingRule::get_CountryCode</b> property specifies the country/region code to which the
    ///outbound routing rule applies. This property is read-only.
    HRESULT get_CountryCode(int* plCountryCode);
    ///The <b>IFaxOutboundRoutingRule::get_AreaCode</b> property specifies the area code to which the outbound routing
    ///rule applies. This property is read-only.
    HRESULT get_AreaCode(int* plAreaCode);
    ///The <b>IFaxOutboundRoutingRule::get_Status</b> property indicates the current status of the outbound routing
    ///rule; for example, whether the rule is valid and whether it can apply to fax jobs. This property is read-only.
    HRESULT get_Status(FAX_RULE_STATUS_ENUM* pStatus);
    ///The <b>IFaxOutboundRoutingRule::get_UseDevice</b> property is a Boolean value that indicates whether the outbound
    ///routing rule points to a single fax device. This property is read/write.
    HRESULT get_UseDevice(short* pbUseDevice);
    ///The <b>IFaxOutboundRoutingRule::get_UseDevice</b> property is a Boolean value that indicates whether the outbound
    ///routing rule points to a single fax device. This property is read/write.
    HRESULT put_UseDevice(short bUseDevice);
    ///The <b>IFaxOutboundRoutingRule::get_DeviceId</b> property specifies the device ID if the outbound routing rule
    ///points to a single fax device. This property is read/write.
    HRESULT get_DeviceId(int* plDeviceId);
    ///The <b>IFaxOutboundRoutingRule::get_DeviceId</b> property specifies the device ID if the outbound routing rule
    ///points to a single fax device. This property is read/write.
    HRESULT put_DeviceId(int DeviceId);
    ///The <b>IFaxOutboundRoutingRule::get_GroupName</b> property specifies the group name if the outbound routing rule
    ///points to a group of fax devices. This property is read/write.
    HRESULT get_GroupName(BSTR* pbstrGroupName);
    ///The <b>IFaxOutboundRoutingRule::get_GroupName</b> property specifies the group name if the outbound routing rule
    ///points to a group of fax devices. This property is read/write.
    HRESULT put_GroupName(BSTR bstrGroupName);
    ///The <b>IFaxOutboundRoutingRule::Refresh</b> method refreshes FaxOutboundRoutingRule object information from the
    ///fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxOutboundRoutingRule::Save</b> method saves the FaxOutboundRoutingRule object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
}

///The <b>IFaxInboundRoutingExtensions</b> interface defines a configuration collection used by a fax client application
///to manage the inbound fax routing extensions registered with the fax service. Each extension is represented by a
///FaxInboundRoutingExtension object.
@GUID("2F6C9673-7B26-42DE-8EB0-915DCD2A4F4C")
interface IFaxInboundRoutingExtensions : IDispatch
{
    ///The <b>IFaxInboundRoutingExtensions::get__NewEnum</b> method returns a reference to an enumerator object that you
    ///can use to iterate through the IFaxInboundRoutingExtensions collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Receives an indirect pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxInboundRoutingExtensions::get_Item</b> method returns a IFaxInboundRoutingExtension interface from the
    ///IFaxInboundRoutingExtensions collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies the item to retrieve from the collection. If this
    ///             parameter is type VT_I2 or VT_I4, the parameter specifies the index of the item to retrieve from the
    ///             collection. The index is 1-based. If this parameter is type VT_BSTR, the parameter is a string containing the
    ///             unique name of the fax routing extension to retrieve. Other types are not supported.
    ///    pFaxInboundRoutingExtension = Type: <b>IFaxInboundRoutingExtension**</b> Address of a pointer to an IFaxInboundRoutingExtension interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingExtension* pFaxInboundRoutingExtension);
    ///The <b>IFaxInboundRoutingExtensions::get_Count</b> property represents the number of objects in the
    ///IFaxInboundRoutingExtensions collection. This is the total number of inbound routing extensions associated with
    ///the fax server. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///The <b>IFaxInboundRoutingExtension</b> interface defines a configuration object used by a fax client application to
///retrieve information about a fax routing extension registered with the fax service.
@GUID("885B5E08-C26C-4EF9-AF83-51580A750BE1")
interface IFaxInboundRoutingExtension : IDispatch
{
    ///The <b>IFaxInboundRoutingExtension::get_FriendlyName</b> property is a null-terminated string that contains the
    ///user-friendly name for the fax routing extension. The string is suitable for display to users. This property is
    ///read-only.
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    ///The <b>IFaxInboundRoutingExtension::get_ImageName</b> property is a null-terminated string that contains the
    ///executable image name (DLL path and file name) of the fax routing extension. This property is read-only.
    HRESULT get_ImageName(BSTR* pbstrImageName);
    ///The <b>IFaxInboundRoutingExtension::get_UniqueName</b> property is a null-terminated string that contains a
    ///unique name for the fax routing extension. The fax service uses this name internally to identify fax routing
    ///extensions. This property is read-only.
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    ///The <b>IFaxInboundRoutingExtension::get_MajorVersion</b> property is a value that specifies the major part of the
    ///version number for the fax routing extension's DLL. This property is read-only.
    HRESULT get_MajorVersion(int* plMajorVersion);
    ///The <b>IFaxInboundRoutingExtension::get_MinorVersion</b> property is a value that specifies the minor part of the
    ///version number for the fax routing extension's DLL. This property is read-only.
    HRESULT get_MinorVersion(int* plMinorVersion);
    ///The <b>IFaxInboundRoutingExtension::get_MajorBuild</b> property is a value that specifies the major part of the
    ///build number for the fax routing extension's DLL. This property is read-only.
    HRESULT get_MajorBuild(int* plMajorBuild);
    ///The <b>IFaxInboundRoutingExtension::get_MinorBuild</b> property is a value that specifies the minor part of the
    ///build number for the fax routing extension's DLL. This property is read-only.
    HRESULT get_MinorBuild(int* plMinorBuild);
    ///The <b>IFaxInboundRoutingExtension::get_Debug</b> property is a Boolean value that indicates whether the fax
    ///routing extension DLL was created in a debug environment. This property is read-only.
    HRESULT get_Debug(short* pbDebug);
    ///The <b>IFaxInboundRoutingExtension::get_Status</b> property is a value that indicates whether the fax routing
    ///extension loaded and initialized successfully. This property is read-only.
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    ///The <b>IFaxInboundRoutingExtension::get_InitErrorCode</b> property is a value that specifies the last error code
    ///that the fax routing extension returned while the fax service was loading and initializing the fax routing
    ///extension's DLL. This property is read-only.
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    ///The <b>IFaxInboundRoutingExtension::get_Methods</b> property is an array of GUIDs that uniquely identify the
    ///inbound routing methods exposed by the fax routing extension. This property is read-only.
    HRESULT get_Methods(VARIANT* pvMethods);
}

///The <b>IFaxInboundRoutingMethods</b> interface defines a configuration collection used by a fax client application to
///manage the ordered inbound fax routing methods.
@GUID("783FCA10-8908-4473-9D69-F67FBEA0C6B9")
interface IFaxInboundRoutingMethods : IDispatch
{
    ///The <b>IFaxInboundRoutingMethods::get__NewEnum</b> method returns a reference to an enumerator object that you
    ///can use to iterate through the IFaxInboundRoutingMethods collection.
    ///Params:
    ///    ppUnk = Type: <b>IUnknown**</b> Address of a pointer to the enumerator object's IUnknown interface for the
    ///            collection.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///The <b>IFaxInboundRoutingMethods::get_Item</b> method returns a IFaxInboundRoutingMethod object from the
    ///IFaxInboundRoutingMethods collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies the item to retrieve from the collection. If this
    ///             parameter is type VT_I2 or VT_I4, the parameter specifies the index of the item to retrieve from the
    ///             collection. The index is 1-based. If this parameter is type VT_BSTR, the parameter is a GUID that identifies
    ///             the fax routing method to retrieve. Other types are not supported.
    ///    pFaxInboundRoutingMethod = Type: <b>IFaxInboundRoutingMethod**</b> Address of a pointer to an IFaxInboundRoutingMethod interface.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingMethod* pFaxInboundRoutingMethod);
    ///The <b>IFaxInboundRoutingMethods::get_Count</b> property represents the number of objects in the
    ///IFaxInboundRoutingMethods collection. This is the total number of inbound routing methods associated with the fax
    ///server. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///The <b>IFaxInboundRoutingMethod</b> interface defines a configuration object used by a fax client application to
///retrieve information about an individual fax inbound routing method on a connected fax server.
@GUID("45700061-AD9D-4776-A8C4-64065492CF4B")
interface IFaxInboundRoutingMethod : IDispatch
{
    ///The <b>IFaxInboundRoutingMethod::get_Name</b> property is a null-terminated string that contains the
    ///user-friendly name associated with the inbound fax routing method. The string is suitable for display to users.
    ///This property is read-only.
    HRESULT get_Name(BSTR* pbstrName);
    ///The <b>IFaxInboundRoutingMethod::get_GUID</b> property is a null-terminated string that specifies the GUID that
    ///uniquely identifies the fax routing method. This property is read-only.
    HRESULT get_GUID(BSTR* pbstrGUID);
    ///The <b>IFaxInboundRoutingMethod::get_FunctionName</b> property is a null-terminated string that contains the name
    ///of the function that executes a specific fax routing procedure. This property is read-only.
    HRESULT get_FunctionName(BSTR* pbstrFunctionName);
    ///The <b>IFaxInboundRoutingMethod::get_ExtensionFriendlyName</b> property is the user-friendly name for the fax
    ///routing extension that exports the inbound fax routing method. This property is read-only.
    HRESULT get_ExtensionFriendlyName(BSTR* pbstrExtensionFriendlyName);
    ///The <b>IFaxInboundRoutingMethod::get_ExtensionImageName</b> property is a null-terminated string that contains
    ///the executable image name (DLL path and file name) of the fax routing extension that exports the fax routing
    ///method. This property is read-only.
    HRESULT get_ExtensionImageName(BSTR* pbstrExtensionImageName);
    ///The Priority property is a value associated with the order in which the fax service calls the routing method when
    ///the service receives a fax job. This property is read/write.
    HRESULT get_Priority(int* plPriority);
    ///The Priority property is a value associated with the order in which the fax service calls the routing method when
    ///the service receives a fax job. This property is read/write.
    HRESULT put_Priority(int lPriority);
    ///The <b>IFaxInboundRoutingMethod::Refresh</b> method refreshes IFaxInboundRoutingMethod interface information from
    ///the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///The <b>IFaxInboundRoutingMethod::Save</b> method saves the IFaxInboundRoutingMethod interface's data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
}

///Defines a messaging object used by a fax client application to compose a fax document and submit it to the fax
///service for processing.
@GUID("E1347661-F9EF-4D6D-B4A5-C0A068B65CFF")
interface IFaxDocument2 : IFaxDocument
{
    ///Retrieves the submission identifier for the fax document. Every job in a given broadcast receives the same
    ///submission identifier. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and
    ///later.</div><div> </div>This property is read-only.
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    ///Provides a collection of one or more documents to the fax document. <div class="alert"><b>Note</b> This property
    ///is supported only in Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT get_Bodies(VARIANT* pvBodies);
    ///Provides a collection of one or more documents to the fax document. <div class="alert"><b>Note</b> This property
    ///is supported only in Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT put_Bodies(VARIANT vBodies);
    ///Submits one or more documents to the fax service for processing. <div class="alert"><b>Note</b> This method is
    ///supported only in Windows Vista and later.</div><div> </div>
    ///Params:
    ///    bstrFaxServerName = Type: <b>BSTR</b> <b>BSTR</b> that specifies a fax server. If this parameter is <b>NULL</b> or an empty
    ///                        string, the local fax server is specified.
    ///    pvFaxOutgoingJobIDs = Type: <b>VARIANT*</b> <b>VARIANT</b> that specifies a collection of outbound job IDs, one for each recipient
    ///                          of the fax.
    ///    plErrorBodyFile = Type: <b>LONG*</b> A <b>LONG</b> representing the zero-based position of the submitted file that caused the
    ///                      fax send operation to fail. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Submit2(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
    ///Submits one or more fax documents to the connected FaxServer. This method returns an array of fax job ID strings,
    ///one for each recipient of the fax. <div class="alert"><b>Note</b> This method is supported only in Windows Vista
    ///and later.</div><div> </div>
    ///Params:
    ///    pFaxServer = Type: <b>IFaxServer*</b> A FaxServer object that specifies a connected fax server.
    ///    pvFaxOutgoingJobIDs = Type: <b>VARIANT*</b> A <b>VARIANT</b> that holds an array of outbound job ID strings, one for each recipient
    ///                          of the fax.
    ///    plErrorBodyFile = Type: <b>LONG*</b> A <b>LONG</b> representing the zero-based position of the submitted file that caused the
    ///                      fax send operation to fail. See Remarks.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ConnectedSubmit2(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
}

///Defines various methods that provide configuration options for the fax service.
@GUID("10F4D0F7-0994-4543-AB6E-506949128C40")
interface IFaxConfiguration : IDispatch
{
    ///Sets or retrieves a value that indicates whether faxes should be archived. This property is read/write.
    HRESULT get_UseArchive(short* pbUseArchive);
    ///Sets or retrieves a value that indicates whether faxes should be archived. This property is read/write.
    HRESULT put_UseArchive(short bUseArchive);
    ///Sets or retrieves a value that indicates the location of the archive on the server. This property is read/write.
    HRESULT get_ArchiveLocation(BSTR* pbstrArchiveLocation);
    ///Sets or retrieves a value that indicates the location of the archive on the server. This property is read/write.
    HRESULT put_ArchiveLocation(BSTR bstrArchiveLocation);
    ///Sets or retrieves a value that indicates whether the size quota warning is turned on. This property is
    ///read/write.
    HRESULT get_SizeQuotaWarning(short* pbSizeQuotaWarning);
    ///Sets or retrieves a value that indicates whether the size quota warning is turned on. This property is
    ///read/write.
    HRESULT put_SizeQuotaWarning(short bSizeQuotaWarning);
    ///Sets or retrieves a value that indicates the maximum allotted size of a watermark. This property is read/write.
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    ///Sets or retrieves a value that indicates the maximum allotted size of a watermark. This property is read/write.
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    ///Sets or retrieves a value that indicates the minimum size of a watermark. This property is read/write.
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    ///Sets or retrieves a value that indicates the minimum size of a watermark. This property is read/write.
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    ///Sets or retrieves a value that indicates how long a fax message is kept on the server. This property is
    ///read/write.
    HRESULT get_ArchiveAgeLimit(int* plArchiveAgeLimit);
    ///Sets or retrieves a value that indicates how long a fax message is kept on the server. This property is
    ///read/write.
    HRESULT put_ArchiveAgeLimit(int lArchiveAgeLimit);
    ///The value that specifies the low-order 32-bit value (in bytes) for the size of the fax message archive. This
    ///property is read-only.
    HRESULT get_ArchiveSizeLow(int* plSizeLow);
    ///The value that specifies the high-order 32-bit value (in bytes) for the size of the fax message archive. This
    ///property is read-only.
    HRESULT get_ArchiveSizeHigh(int* plSizeHigh);
    ///Sets or retrieves a value that indicates whether the fax server queue for outgoing faxes has been blocked. This
    ///property is read/write.
    HRESULT get_OutgoingQueueBlocked(short* pbOutgoingBlocked);
    ///Sets or retrieves a value that indicates whether the fax server queue for outgoing faxes has been blocked. This
    ///property is read/write.
    HRESULT put_OutgoingQueueBlocked(short bOutgoingBlocked);
    ///Sets or retrieves a value that indicates whether the outgoing queue has been paused. This property is read/write.
    HRESULT get_OutgoingQueuePaused(short* pbOutgoingPaused);
    ///Sets or retrieves a value that indicates whether the outgoing queue has been paused. This property is read/write.
    HRESULT put_OutgoingQueuePaused(short bOutgoingPaused);
    ///Sets or retrieves a value that indicates whether personal cover pages are allowed. This property is read/write.
    HRESULT get_AllowPersonalCoverPages(short* pbAllowPersonalCoverPages);
    ///Sets or retrieves a value that indicates whether personal cover pages are allowed. This property is read/write.
    HRESULT put_AllowPersonalCoverPages(short bAllowPersonalCoverPages);
    ///Sets or retrieves a value that indicates whether the transmitting station identifier (TSID) is used. This
    ///property is read/write.
    HRESULT get_UseDeviceTSID(short* pbUseDeviceTSID);
    ///Sets or retrieves a value that indicates whether the transmitting station identifier (TSID) is used. This
    ///property is read/write.
    HRESULT put_UseDeviceTSID(short bUseDeviceTSID);
    ///Sets or retrieves a value that indicates the number of redial attempts for a given fax job. This property is
    ///read/write.
    HRESULT get_Retries(int* plRetries);
    ///Sets or retrieves a value that indicates the number of redial attempts for a given fax job. This property is
    ///read/write.
    HRESULT put_Retries(int lRetries);
    ///Sets or retrieves a value that indicates the length of time the fax service should wait before retrying a failed
    ///fax transmission. This property is read/write.
    HRESULT get_RetryDelay(int* plRetryDelay);
    ///Sets or retrieves a value that indicates the length of time the fax service should wait before retrying a failed
    ///fax transmission. This property is read/write.
    HRESULT put_RetryDelay(int lRetryDelay);
    ///Sets or retrieves a value that indicates the time at which the discount rate period begins. This property is
    ///read/write.
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    ///Sets or retrieves a value that indicates the time at which the discount rate period begins. This property is
    ///read/write.
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    ///Sets or retrieves a value that indicates the time at which the discount rate period ends. This property is
    ///read/write.
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    ///Sets or retrieves a value that indicates the time at which the discount rate period ends. This property is
    ///read/write.
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    ///Sets or retrieves a value that indicates the length of time that an undeliverable fax message is kept on the fax
    ///server before it is deleted. This property is read/write.
    HRESULT get_OutgoingQueueAgeLimit(int* plOutgoingQueueAgeLimit);
    ///Sets or retrieves a value that indicates the length of time that an undeliverable fax message is kept on the fax
    ///server before it is deleted. This property is read/write.
    HRESULT put_OutgoingQueueAgeLimit(int lOutgoingQueueAgeLimit);
    ///Sets or retrieves a value that indicates whether the fax server generates a branding mark on outgoing faxes. This
    ///property is read/write.
    HRESULT get_Branding(short* pbBranding);
    ///Sets or retrieves a value that indicates whether the fax server generates a branding mark on outgoing faxes. This
    ///property is read/write.
    HRESULT put_Branding(short bBranding);
    ///Sets or retrieves a value that indicates whether the fax server queue for incoming faxes has been blocked. This
    ///property is read/write.
    HRESULT get_IncomingQueueBlocked(short* pbIncomingBlocked);
    ///Sets or retrieves a value that indicates whether the fax server queue for incoming faxes has been blocked. This
    ///property is read/write.
    HRESULT put_IncomingQueueBlocked(short bIncomingBlocked);
    ///Sets or retrieves a value that indicates whether the server automatically creates a fax account once a connection
    ///is initiated. This property is read/write.
    HRESULT get_AutoCreateAccountOnConnect(short* pbAutoCreateAccountOnConnect);
    ///Sets or retrieves a value that indicates whether the server automatically creates a fax account once a connection
    ///is initiated. This property is read/write.
    HRESULT put_AutoCreateAccountOnConnect(short bAutoCreateAccountOnConnect);
    ///Indicates whether incoming faxes are either viewable by everyone or private. This property is read/write.
    HRESULT get_IncomingFaxesArePublic(short* pbIncomingFaxesArePublic);
    ///Indicates whether incoming faxes are either viewable by everyone or private. This property is read/write.
    HRESULT put_IncomingFaxesArePublic(short bIncomingFaxesArePublic);
    ///Refreshes the object.
    ///Returns:
    ///    This method does not return a value.
    ///    
    HRESULT Refresh();
    ///Saves the object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
}

///Inherits all the functionality of the IFaxServer interface and adds read-only properties for the server's
///configuration, account management, security objects, and the current account.
@GUID("571CED0F-5609-4F40-9176-547E3A72CA7C")
interface IFaxServer2 : IFaxServer
{
    ///The <b>IFaxServer2::Configuration</b> property holds a IFaxConfiguration object. The object permits a fax client
    ///application to access information about the configuration of the connected fax server. This property is
    ///read-only.
    HRESULT get_Configuration(IFaxConfiguration* ppFaxConfiguration);
    ///The <b>IFaxServer2::CurrentAccount</b> property returns the fax account for the user account that has connected
    ///to the fax server. This property is read-only.
    HRESULT get_CurrentAccount(IFaxAccount* ppCurrentAccount);
    ///The <b>IFaxServer2::FaxAccountSet</b> property returns a IFaxAccountSet object used to manage the fax accounts on
    ///the fax server. This property is read-only.
    HRESULT get_FaxAccountSet(IFaxAccountSet* ppFaxAccountSet);
    ///The <b>IFaxServer2::Security2</b> property returns a IFaxSecurity2 object used to configure security on the fax
    ///server. This property is read-only.
    HRESULT get_Security2(IFaxSecurity2* ppFaxSecurity2);
}

///Provides methods for fax account management, including adding, removing, and retrieving fax accounts.
@GUID("7428FBAE-841E-47B8-86F4-2288946DCA1B")
interface IFaxAccountSet : IDispatch
{
    ///Returns an IFaxAccounts object that represents all the fax accounts on the fax server.
    ///Params:
    ///    ppFaxAccounts = Type: <b>IFaxAccounts**</b> The address of a pointer to an IFaxAccounts object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAccounts(IFaxAccounts* ppFaxAccounts);
    ///Returns an IFaxAccount object by using the account name.
    ///Params:
    ///    bstrAccountName = Type: <b>BSTR</b> Specifies a null-terminated string that contains the name of the account to return.
    ///    pFaxAccount = Type: <b>IFaxAccount**</b> The address of a pointer to an IFaxAccount object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    ///Adds a fax account to the fax server and returns the new IFaxAccount object.
    ///Params:
    ///    bstrAccountName = Type: <b>BSTR</b> Specifies a null-terminated string that contains a name for the new account.
    ///    pFaxAccount = Type: <b>IFaxAccount**</b> The address of a pointer to an IFaxAccount object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT AddAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    ///Removes a fax account from the fax server.
    ///Params:
    ///    bstrAccountName = Type: <b>BSTR</b> Specifies a null-terminated string that contains the name of the account to be removed.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT RemoveAccount(BSTR bstrAccountName);
}

///Represents the collection of fax accounts on the fax server. It provides methods and properties for enumerating the
///accounts, retrieving a particular account, and reporting the total number of accounts.
@GUID("93EA8162-8BE7-42D1-AE7B-EC74E2D989DA")
interface IFaxAccounts : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    ///Returns a FaxAccount object from a FaxAccounts collection.
    ///Params:
    ///    vIndex = Type: <b>VARIANT</b> <b>VARIANT</b> that specifies a value that indicates the item to retrieve from the
    ///             collection. If this parameter is type <b>VT_I2</b> or <b>VT_I4</b>, it specifies the index of the item to
    ///             retrieve. The index is 1-based. If this parameter is type <b>VT_BSTR</b>, it specifies the account name to
    ///             use to search the collection. Other types are not supported.
    ///    pFaxAccount = Type: <b>IFaxAccount**</b> The FaxAccount object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT get_Item(VARIANT vIndex, IFaxAccount* pFaxAccount);
    ///Holds the number of items in the IFaxAccounts collection. This property is read-only.
    HRESULT get_Count(int* plCount);
}

///Represents a fax account on the fax server.
@GUID("68535B33-5DC4-4086-BE26-B76F9B711006")
interface IFaxAccount : IDispatch
{
    ///Retrieves the name of a particular fax account on the server. This property is read-only.
    HRESULT get_AccountName(BSTR* pbstrAccountName);
    ///Represents the folders of the account, including the incoming and outgoing archives and the incoming and outgoing
    ///queues. This property is read-only.
    HRESULT get_Folders(IFaxAccountFolders* ppFolders);
    ///Sets the flags of a FAX_ACCOUNT_EVENTS_TYPE_ENUM variable that represents the events for which the account is
    ///listening.
    ///Params:
    ///    EventTypes = Type: <b>FAX_ACCOUNT_EVENTS_TYPE_ENUM</b> A variable that specifies the types of events for which the account
    ///                 is listening.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ListenToAccountEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM EventTypes);
    ///A set of flags indicating the type of events for which the account is listening. This property is read-only.
    HRESULT get_RegisteredEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM* pRegisteredEvents);
}

///Describes an object that is used by a fax client application to retrieve information about an outgoing fax job in a
///fax server's queue. It inherits all the functionality of the IFaxOutgoingJob interface. Additionally, it provides new
///read-only properties to indicate whether the outgoing fax has a cover page, the schedule type of the fax, and the
///address of its recipient. <div class="alert"><b>Note</b> This interface is supported only on Windows Vista and
///later.</div><div> </div>
@GUID("418A8D96-59A0-4789-B176-EDF3DC8FA8F7")
interface IFaxOutgoingJob2 : IFaxOutgoingJob
{
    ///Specifies if the fax has a cover page. This property is read-only.
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    ///A null-terminated string containing the address to which a delivery report will be sent, indicating success or
    ///failure. This property is read-only.
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    ///Specifies the schedule type that was used for the transmission. This property is read-only.
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
}

///Provides access to the incoming and outgoing fax queues and fax archives.
@GUID("6463F89D-23D8-46A9-8F86-C47B77CA7926")
interface IFaxAccountFolders : IDispatch
{
    ///Represents the queue of outgoing faxes for a particular fax account. These are the faxes that have not yet been
    ///sent. This property is read-only.
    HRESULT get_OutgoingQueue(IFaxAccountOutgoingQueue* pFaxOutgoingQueue);
    ///Represents the queue of incoming faxes for a particular fax account. These are the incoming faxes that have not
    ///yet been fully processed. This property is read-only.
    HRESULT get_IncomingQueue(IFaxAccountIncomingQueue* pFaxIncomingQueue);
    ///Represents the archive of incoming faxes for a particular fax account. These are the faxes that have been
    ///received. This property is read-only.
    HRESULT get_IncomingArchive(IFaxAccountIncomingArchive* pFaxIncomingArchive);
    ///Represents the archive of outgoing faxes for a particular fax account that have been sent. This property is
    ///read-only.
    HRESULT get_OutgoingArchive(IFaxAccountOutgoingArchive* pFaxOutgoingArchive);
}

///Used by a fax client application to retrieve the inbound fax jobs (FaxIncomingJobs object) in the job queue for a
///particular fax account. The <b>IFaxAccountIncomingQueue</b> interface is accessed through the IFaxAccountFolders
///interface.
@GUID("DD142D92-0186-4A95-A090-CBC3EADBA6B4")
interface IFaxAccountIncomingQueue : IDispatch
{
    ///Returns the collection of inbound fax jobs in the queue for the current fax account.
    ///Params:
    ///    pFaxIncomingJobs = Type: <b>IFaxIncomingJobs**</b> A FaxIncomingJobs object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

///Used by a fax client application to retrieve the outbound fax jobs (FaxOutgoingJobs object) in the job queue for a
///particular fax account. The <b>IFaxAccountOutgoingQueue</b> interface is accessed through the IFaxAccountFolders
///interface.
@GUID("0F1424E9-F22D-4553-B7A5-0D24BD0D7E46")
interface IFaxAccountOutgoingQueue : IDispatch
{
    ///Returns the collection of outbound fax jobs in the queue for the current fax account.
    ///Params:
    ///    pFaxOutgoingJobs = Type: <b>IFaxOutgoingJobs**</b> A FaxOutgoingJobs object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    HRESULT GetJobA(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

///Used by a fax client application to retrieve information about a sent fax message in the archive of outbound faxes.
///The archive contains faxes sent successfully by the fax service. The interface inherits all the functionality of the
///IFaxOutgoingMessage interface. It adds to that information such as whether the fax has a cover page, whether it has
///been read and what kind of receipt was sent. The <b>IFaxOutgoingMessage2</b> interface is accessed through the
///IFaxAccountOutgoingArchive interface or IFaxOutgoingMessageIterator interface. <div class="alert"><b>Note</b> This
///interface is supported only on Windows Vista or later.</div><div> </div>
@GUID("B37DF687-BC88-4B46-B3BE-B458B3EA9E7F")
interface IFaxOutgoingMessage2 : IFaxOutgoingMessage
{
    ///Indicates if the fax has a cover page. <div class="alert"><b>Note</b> This property is supported only on Windows
    ///Vista and later.</div><div> </div>This property is read-only.
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    ///Specifies the type of delivery report that is sent following an attempted transmission. <div
    ///class="alert"><b>Note</b> This property is supported only on Windows Vista and later.</div><div> </div>This
    ///property is read-only.
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    ///Specifies the address to which the delivery report is sent. <div class="alert"><b>Note</b> This property is
    ///supported only on Windows Vista and later.</div><div> </div>This property is read-only.
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    ///Indicates if the fax has been read. <div class="alert"><b>Note</b> This property is supported only on Windows
    ///Vista and later.</div><div> </div>This property is read/write.
    HRESULT get_Read(short* pbRead);
    ///Indicates if the fax has been read. <div class="alert"><b>Note</b> This property is supported only on Windows
    ///Vista and later.</div><div> </div>This property is read/write.
    HRESULT put_Read(short bRead);
    ///Saves the FaxOutgoingMessage object's data. <div class="alert"><b>Note</b> This method is supported only on
    ///Windows Vista and later.</div><div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///Refreshes FaxOutgoingMessage object information from the fax server. When the <b>Refresh</b> method is called,
    ///any configuration changes made after the last Save method call are lost. <div class="alert"><b>Note</b> This
    ///method is supported only on Windows Vista and later.</div><div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
}

///Used by a fax client application to access a particular fax account's archive of successfully received inbound fax
///messages. Use this interface to retrieve messages and get the size of the archive. A default implementation of
///<b>IFaxAccountIncomingArchive</b> is provided as the FaxAccountIncomingArchive object.
@GUID("A8A5B6EF-E0D6-4AEE-955C-91625BEC9DB4")
interface IFaxAccountIncomingArchive : IDispatch
{
    ///Specifies the low 32-bit value (in bytes) for the size of the archive of inbound fax messages for a particular
    ///fax account. This property is read-only.
    HRESULT get_SizeLow(int* plSizeLow);
    ///Specifies the high 32-bit value (in bytes) for the size of the archive of inbound fax messages for a particular
    ///fax account. This property is read-only.
    HRESULT get_SizeHigh(int* plSizeHigh);
    ///Refreshes FaxAccountIncomingArchive object information for a particular fax account from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///Returns a new iterator (archive cursor) for the archive of inbound fax messages for a particular fax account.
    ///Params:
    ///    lPrefetchSize = Type: <b>long</b> <b>long</b> value that indicates the size of the prefetch buffer. This value determines how
    ///                    many fax messages the iterator object retrieves from the fax server when the object needs to refresh its
    ///                    contents. The default value is lDEFAULT_PREFETCH_SIZE.
    ///    pFaxIncomingMessageIterator = Type: <b>IFaxIncomingMessageIterator**</b> A FaxIncomingMessageIterator object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

///Used by a fax client application to access a specified fax account's archive of successfully sent outbound fax
///messages. Use this interface to retrieve messages and get the size of the archive. A default implementation of
///<b>IFaxAccountOutgoingArchive</b> is provided as the FaxAccountOutgoingArchive object.
@GUID("5463076D-EC14-491F-926E-B3CEDA5E5662")
interface IFaxAccountOutgoingArchive : IDispatch
{
    ///Specifies the low-order 32-bit value of the size (in bytes) of the archive of outbound fax messages for a
    ///particular fax account. This property is read-only.
    HRESULT get_SizeLow(int* plSizeLow);
    ///Specifies the high-order 32-bit value of the size (in bytes) of the archive of outbound fax messages for a
    ///particular fax account. This property is read-only.
    HRESULT get_SizeHigh(int* plSizeHigh);
    ///Refreshes FaxAccountOutgoingArchive object information for a particular fax account from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///Returns a new iterator (archive cursor) for the archive of outbound fax messages for a particular fax account.
    ///Params:
    ///    lPrefetchSize = Type: <b>long</b> <b>long</b> value that indicates the size of the prefetch buffer. This value determines how
    ///                    many fax messages the iterator object retrieves from the fax server when the object needs to refresh its
    ///                    contents. The default value is lDEFAULT_PREFETCH_SIZE.
    ///    pFaxOutgoingMessageIterator = Type: <b>IFaxOutgoingMessageIterator**</b> A FaxOutgoingMessageIterator object.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    HRESULT GetMessageA(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

///Used by a fax client application to configure the security on a fax server; also permits the calling application to
///set and retrieve a security descriptor for the fax server.
@GUID("17D851F4-D09B-48FC-99C9-8F24C4DB9AB1")
interface IFaxSecurity2 : IDispatch
{
    ///Represents the security descriptor for a IFaxServer2 object. This property is read/write.
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    ///Represents the security descriptor for a IFaxServer2 object. This property is read/write.
    HRESULT put_Descriptor(VARIANT vDescriptor);
    ///Retrieves a combination of the fax server access rights granted to the user referencing this property. For
    ///example, some users have permission to submit fax jobs with high priority while others have permission to submit
    ///jobs with normal or low priority only. This property is read-only.
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM_2* pGrantedRights);
    ///Refreshes FaxSecurity2 object information from the fax server.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
    ///Saves the FaxSecurity object data.
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///Retrieves the security information type. This property is read/write.
    HRESULT get_InformationType(int* plInformationType);
    ///Retrieves the security information type. This property is read/write.
    HRESULT put_InformationType(int lInformationType);
}

///Used by a fax client application to retrieve information about a received fax message in the archive of inbound
///faxes. The archive contains faxes received successfully by the fax service. The interface also includes methods to
///delete a message from the archive and to copy the Tagged Image File Format Class F (TIFF Class F) file associated
///with the fax message to a file on the local computer. The <b>IFaxIncomingMessage2</b> interface is accessed through
///the IFaxAccountIncomingArchive interface or IFaxIncomingMessageIterator interface.
@GUID("F9208503-E2BC-48F3-9EC0-E6236F9B509A")
interface IFaxIncomingMessage2 : IFaxIncomingMessage
{
    ///The <b>Subject</b> property contains the subject associated with the inbound fax message. This property is a
    ///null-terminated string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and
    ///later.</div><div> </div>This property is read/write.
    HRESULT get_Subject(BSTR* pbstrSubject);
    ///The <b>Subject</b> property contains the subject associated with the inbound fax message. This property is a
    ///null-terminated string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and
    ///later.</div><div> </div>This property is read/write.
    HRESULT put_Subject(BSTR bstrSubject);
    ///Contains the name of the sender that is associated with the inbound fax message. This property is a
    ///null-terminated string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and
    ///later.</div><div> </div>This property is read/write.
    HRESULT get_SenderName(BSTR* pbstrSenderName);
    ///Contains the name of the sender that is associated with the inbound fax message. This property is a
    ///null-terminated string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and
    ///later.</div><div> </div>This property is read/write.
    HRESULT put_SenderName(BSTR bstrSenderName);
    ///Contains the sender's fax number associated with the inbound fax message. This property is a null-terminated
    ///string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and later.</div><div>
    ///</div>This property is read/write.
    HRESULT get_SenderFaxNumber(BSTR* pbstrSenderFaxNumber);
    ///Contains the sender's fax number associated with the inbound fax message. This property is a null-terminated
    ///string. <div class="alert"><b>Note</b> This property is supported only in Windows Vista and later.</div><div>
    ///</div>This property is read/write.
    HRESULT put_SenderFaxNumber(BSTR bstrSenderFaxNumber);
    ///A flag that indicates whether the fax has a cover page. <div class="alert"><b>Note</b> This property is supported
    ///only in Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT get_HasCoverPage(short* pbHasCoverPage);
    ///A flag that indicates whether the fax has a cover page. <div class="alert"><b>Note</b> This property is supported
    ///only in Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT put_HasCoverPage(short bHasCoverPage);
    ///Contains the recipients associated with the inbound fax message. This property is a null-terminated string. <div
    ///class="alert"><b>Note</b> This property is supported only in Windows Vista and later.</div><div> </div>This
    ///property is read/write.
    HRESULT get_Recipients(BSTR* pbstrRecipients);
    ///Contains the recipients associated with the inbound fax message. This property is a null-terminated string. <div
    ///class="alert"><b>Note</b> This property is supported only in Windows Vista and later.</div><div> </div>This
    ///property is read/write.
    HRESULT put_Recipients(BSTR bstrRecipients);
    ///Indicates if the fax has been reassigned. <div class="alert"><b>Note</b> This property is supported only in
    ///Windows Vista and later.</div><div> </div>This property is read-only.
    HRESULT get_WasReAssigned(short* pbWasReAssigned);
    ///A flag that indicates if the fax has been read. <div class="alert"><b>Note</b> This property is supported only in
    ///Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT get_Read(short* pbRead);
    ///A flag that indicates if the fax has been read. <div class="alert"><b>Note</b> This property is supported only in
    ///Windows Vista and later.</div><div> </div>This property is read/write.
    HRESULT put_Read(short bRead);
    ///Reassign the fax to one or more recipients. It also commits changes to the IFaxIncomingMessage2::Subject,
    ///IFaxIncomingMessage2::SenderName, IFaxIncomingMessage2::SenderFaxNumber, and IFaxIncomingMessage2::HasCoverPage
    ///properties. <div class="alert"><b>Note</b> This method is supported only in Windows Vista and later.</div><div>
    ///</div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT ReAssign();
    ///Saves the FaxIncomingMessage object's data. <div class="alert"><b>Note</b> This method is supported only in
    ///Windows Vista and later.</div><div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Save();
    ///Refreshes FaxIncomingMessage object information from the fax server. When the <b>Refresh</b> method is called,
    ///any configuration changes made after the last Save method call are lost, except for the properties that are
    ///committed with the IFaxIncomingMessage2::Reassign method: IFaxIncomingMessage2::Subject,
    ///IFaxIncomingMessage2::SenderName, IFaxIncomingMessage2::SenderFaxNumber, and IFaxIncomingMessage2::HasCoverPage.
    ///<div class="alert"><b>Note</b> This method is supported only in Windows Vista and later.</div><div> </div>
    ///Returns:
    ///    Type: <b>HRESULT</b> If this method succeeds, it returns <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">S_OK</b>. Otherwise, it returns an <b
    ///    xmlns:loc="http://microsoft.com/wdcml/l10n">HRESULT</b> error code.
    ///    
    HRESULT Refresh();
}

@GUID("2E037B27-CF8A-4ABD-B1E0-5704943BEA6F")
interface IFaxServerNotify : IDispatch
{
}

///The <b>IFaxServerNotify2</b> interface is used for fax notifications. The fax service calls <b>IFaxServerNotify2</b>
///to send fax event notifications. Events include changes to fax server configuration and activity, changes to incoming
///and outgoing job queues, and changes to incoming and outgoing archives. For more information, see Registering for
///Event Notifications. The <b>IFaxServerNotify2</b> interface supports all the same methods as the IFaxServerNotify
///interface and the additional method OnGeneralServerConfigChanged.
@GUID("EC9C69B9-5FE7-4805-9467-82FCD96AF903")
interface _IFaxServerNotify2 : IDispatch
{
    HRESULT OnIncomingJobAdded(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnIncomingJobRemoved(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnIncomingJobChanged(IFaxServer2 pFaxServer, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnOutgoingJobAdded(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnOutgoingJobRemoved(IFaxServer2 pFaxServer, BSTR bstrJobId);
    HRESULT OnOutgoingJobChanged(IFaxServer2 pFaxServer, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnIncomingMessageAdded(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnIncomingMessageRemoved(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageAdded(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageRemoved(IFaxServer2 pFaxServer, BSTR bstrMessageId);
    HRESULT OnReceiptOptionsChange(IFaxServer2 pFaxServer);
    HRESULT OnActivityLoggingConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnSecurityConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnEventLoggingConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutgoingQueueConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutgoingArchiveConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnIncomingArchiveConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnDevicesConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutboundRoutingGroupsConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnOutboundRoutingRulesConfigChange(IFaxServer2 pFaxServer);
    HRESULT OnServerActivityChange(IFaxServer2 pFaxServer, int lIncomingMessages, int lRoutingMessages, 
                                   int lOutgoingMessages, int lQueuedMessages);
    HRESULT OnQueuesStatusChange(IFaxServer2 pFaxServer, short bOutgoingQueueBlocked, short bOutgoingQueuePaused, 
                                 short bIncomingQueueBlocked);
    HRESULT OnNewCall(IFaxServer2 pFaxServer, int lCallId, int lDeviceId, BSTR bstrCallerId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
    HRESULT OnDeviceStatusChange(IFaxServer2 pFaxServer, int lDeviceId, short bPoweredOff, short bSending, 
                                 short bReceiving, short bRinging);
    HRESULT OnGeneralServerConfigChanged(IFaxServer2 pFaxServer);
}

///The <b>IFaxServerNotify2</b> interface is used for fax notifications. The fax service calls <b>IFaxServerNotify2</b>
///to send fax event notifications. Events include changes to fax server configuration and activity, changes to incoming
///and outgoing job queues, and changes to incoming and outgoing archives. For more information, see Registering for
///Event Notifications. The <b>IFaxServerNotify2</b> interface supports all the same methods as the IFaxServerNotify
///interface and the additional method OnGeneralServerConfigChanged.
@GUID("616CA8D6-A77A-4062-ABFD-0E471241C7AA")
interface IFaxServerNotify2 : IDispatch
{
}

///Called by the fax service to send event notifications about particular fax accounts. This property sends event
///notifications. Events include changes to incoming and outgoing job queues, and changes to incoming and outgoing
///archives.
@GUID("B9B3BC81-AC1B-46F3-B39D-0ADC30E1B788")
interface _IFaxAccountNotify : IDispatch
{
    HRESULT OnIncomingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnIncomingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnIncomingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnOutgoingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnOutgoingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    HRESULT OnOutgoingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    HRESULT OnIncomingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId, short fAddedToReceiveFolder);
    HRESULT OnIncomingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId, short fRemovedFromReceiveFolder);
    HRESULT OnOutgoingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    HRESULT OnOutgoingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
}

///Called by the fax service to send event notifications about particular fax accounts. This property sends event
///notifications. Events include changes to incoming and outgoing job queues, and changes to incoming and outgoing
///archives.
@GUID("0B5E5BD1-B8A9-47A0-A323-EF4A293BA06A")
interface IFaxAccountNotify : IDispatch
{
}


// GUIDs

const GUID CLSID_FaxAccount                  = GUIDOF!FaxAccount;
const GUID CLSID_FaxAccountFolders           = GUIDOF!FaxAccountFolders;
const GUID CLSID_FaxAccountIncomingArchive   = GUIDOF!FaxAccountIncomingArchive;
const GUID CLSID_FaxAccountIncomingQueue     = GUIDOF!FaxAccountIncomingQueue;
const GUID CLSID_FaxAccountOutgoingArchive   = GUIDOF!FaxAccountOutgoingArchive;
const GUID CLSID_FaxAccountOutgoingQueue     = GUIDOF!FaxAccountOutgoingQueue;
const GUID CLSID_FaxAccountSet               = GUIDOF!FaxAccountSet;
const GUID CLSID_FaxAccounts                 = GUIDOF!FaxAccounts;
const GUID CLSID_FaxActivity                 = GUIDOF!FaxActivity;
const GUID CLSID_FaxActivityLogging          = GUIDOF!FaxActivityLogging;
const GUID CLSID_FaxConfiguration            = GUIDOF!FaxConfiguration;
const GUID CLSID_FaxDevice                   = GUIDOF!FaxDevice;
const GUID CLSID_FaxDeviceIds                = GUIDOF!FaxDeviceIds;
const GUID CLSID_FaxDeviceProvider           = GUIDOF!FaxDeviceProvider;
const GUID CLSID_FaxDeviceProviders          = GUIDOF!FaxDeviceProviders;
const GUID CLSID_FaxDevices                  = GUIDOF!FaxDevices;
const GUID CLSID_FaxDocument                 = GUIDOF!FaxDocument;
const GUID CLSID_FaxEventLogging             = GUIDOF!FaxEventLogging;
const GUID CLSID_FaxFolders                  = GUIDOF!FaxFolders;
const GUID CLSID_FaxInboundRouting           = GUIDOF!FaxInboundRouting;
const GUID CLSID_FaxInboundRoutingExtension  = GUIDOF!FaxInboundRoutingExtension;
const GUID CLSID_FaxInboundRoutingExtensions = GUIDOF!FaxInboundRoutingExtensions;
const GUID CLSID_FaxInboundRoutingMethod     = GUIDOF!FaxInboundRoutingMethod;
const GUID CLSID_FaxInboundRoutingMethods    = GUIDOF!FaxInboundRoutingMethods;
const GUID CLSID_FaxIncomingArchive          = GUIDOF!FaxIncomingArchive;
const GUID CLSID_FaxIncomingJob              = GUIDOF!FaxIncomingJob;
const GUID CLSID_FaxIncomingJobs             = GUIDOF!FaxIncomingJobs;
const GUID CLSID_FaxIncomingMessage          = GUIDOF!FaxIncomingMessage;
const GUID CLSID_FaxIncomingMessageIterator  = GUIDOF!FaxIncomingMessageIterator;
const GUID CLSID_FaxIncomingQueue            = GUIDOF!FaxIncomingQueue;
const GUID CLSID_FaxJobStatus                = GUIDOF!FaxJobStatus;
const GUID CLSID_FaxLoggingOptions           = GUIDOF!FaxLoggingOptions;
const GUID CLSID_FaxOutboundRouting          = GUIDOF!FaxOutboundRouting;
const GUID CLSID_FaxOutboundRoutingGroup     = GUIDOF!FaxOutboundRoutingGroup;
const GUID CLSID_FaxOutboundRoutingGroups    = GUIDOF!FaxOutboundRoutingGroups;
const GUID CLSID_FaxOutboundRoutingRule      = GUIDOF!FaxOutboundRoutingRule;
const GUID CLSID_FaxOutboundRoutingRules     = GUIDOF!FaxOutboundRoutingRules;
const GUID CLSID_FaxOutgoingArchive          = GUIDOF!FaxOutgoingArchive;
const GUID CLSID_FaxOutgoingJob              = GUIDOF!FaxOutgoingJob;
const GUID CLSID_FaxOutgoingJobs             = GUIDOF!FaxOutgoingJobs;
const GUID CLSID_FaxOutgoingMessage          = GUIDOF!FaxOutgoingMessage;
const GUID CLSID_FaxOutgoingMessageIterator  = GUIDOF!FaxOutgoingMessageIterator;
const GUID CLSID_FaxOutgoingQueue            = GUIDOF!FaxOutgoingQueue;
const GUID CLSID_FaxReceiptOptions           = GUIDOF!FaxReceiptOptions;
const GUID CLSID_FaxRecipient                = GUIDOF!FaxRecipient;
const GUID CLSID_FaxRecipients               = GUIDOF!FaxRecipients;
const GUID CLSID_FaxSecurity                 = GUIDOF!FaxSecurity;
const GUID CLSID_FaxSecurity2                = GUIDOF!FaxSecurity2;
const GUID CLSID_FaxSender                   = GUIDOF!FaxSender;
const GUID CLSID_FaxServer                   = GUIDOF!FaxServer;

const GUID IID_IFaxAccount                  = GUIDOF!IFaxAccount;
const GUID IID_IFaxAccountFolders           = GUIDOF!IFaxAccountFolders;
const GUID IID_IFaxAccountIncomingArchive   = GUIDOF!IFaxAccountIncomingArchive;
const GUID IID_IFaxAccountIncomingQueue     = GUIDOF!IFaxAccountIncomingQueue;
const GUID IID_IFaxAccountNotify            = GUIDOF!IFaxAccountNotify;
const GUID IID_IFaxAccountOutgoingArchive   = GUIDOF!IFaxAccountOutgoingArchive;
const GUID IID_IFaxAccountOutgoingQueue     = GUIDOF!IFaxAccountOutgoingQueue;
const GUID IID_IFaxAccountSet               = GUIDOF!IFaxAccountSet;
const GUID IID_IFaxAccounts                 = GUIDOF!IFaxAccounts;
const GUID IID_IFaxActivity                 = GUIDOF!IFaxActivity;
const GUID IID_IFaxActivityLogging          = GUIDOF!IFaxActivityLogging;
const GUID IID_IFaxConfiguration            = GUIDOF!IFaxConfiguration;
const GUID IID_IFaxDevice                   = GUIDOF!IFaxDevice;
const GUID IID_IFaxDeviceIds                = GUIDOF!IFaxDeviceIds;
const GUID IID_IFaxDeviceProvider           = GUIDOF!IFaxDeviceProvider;
const GUID IID_IFaxDeviceProviders          = GUIDOF!IFaxDeviceProviders;
const GUID IID_IFaxDevices                  = GUIDOF!IFaxDevices;
const GUID IID_IFaxDocument                 = GUIDOF!IFaxDocument;
const GUID IID_IFaxDocument2                = GUIDOF!IFaxDocument2;
const GUID IID_IFaxEventLogging             = GUIDOF!IFaxEventLogging;
const GUID IID_IFaxFolders                  = GUIDOF!IFaxFolders;
const GUID IID_IFaxInboundRouting           = GUIDOF!IFaxInboundRouting;
const GUID IID_IFaxInboundRoutingExtension  = GUIDOF!IFaxInboundRoutingExtension;
const GUID IID_IFaxInboundRoutingExtensions = GUIDOF!IFaxInboundRoutingExtensions;
const GUID IID_IFaxInboundRoutingMethod     = GUIDOF!IFaxInboundRoutingMethod;
const GUID IID_IFaxInboundRoutingMethods    = GUIDOF!IFaxInboundRoutingMethods;
const GUID IID_IFaxIncomingArchive          = GUIDOF!IFaxIncomingArchive;
const GUID IID_IFaxIncomingJob              = GUIDOF!IFaxIncomingJob;
const GUID IID_IFaxIncomingJobs             = GUIDOF!IFaxIncomingJobs;
const GUID IID_IFaxIncomingMessage          = GUIDOF!IFaxIncomingMessage;
const GUID IID_IFaxIncomingMessage2         = GUIDOF!IFaxIncomingMessage2;
const GUID IID_IFaxIncomingMessageIterator  = GUIDOF!IFaxIncomingMessageIterator;
const GUID IID_IFaxIncomingQueue            = GUIDOF!IFaxIncomingQueue;
const GUID IID_IFaxJobStatus                = GUIDOF!IFaxJobStatus;
const GUID IID_IFaxLoggingOptions           = GUIDOF!IFaxLoggingOptions;
const GUID IID_IFaxOutboundRouting          = GUIDOF!IFaxOutboundRouting;
const GUID IID_IFaxOutboundRoutingGroup     = GUIDOF!IFaxOutboundRoutingGroup;
const GUID IID_IFaxOutboundRoutingGroups    = GUIDOF!IFaxOutboundRoutingGroups;
const GUID IID_IFaxOutboundRoutingRule      = GUIDOF!IFaxOutboundRoutingRule;
const GUID IID_IFaxOutboundRoutingRules     = GUIDOF!IFaxOutboundRoutingRules;
const GUID IID_IFaxOutgoingArchive          = GUIDOF!IFaxOutgoingArchive;
const GUID IID_IFaxOutgoingJob              = GUIDOF!IFaxOutgoingJob;
const GUID IID_IFaxOutgoingJob2             = GUIDOF!IFaxOutgoingJob2;
const GUID IID_IFaxOutgoingJobs             = GUIDOF!IFaxOutgoingJobs;
const GUID IID_IFaxOutgoingMessage          = GUIDOF!IFaxOutgoingMessage;
const GUID IID_IFaxOutgoingMessage2         = GUIDOF!IFaxOutgoingMessage2;
const GUID IID_IFaxOutgoingMessageIterator  = GUIDOF!IFaxOutgoingMessageIterator;
const GUID IID_IFaxOutgoingQueue            = GUIDOF!IFaxOutgoingQueue;
const GUID IID_IFaxReceiptOptions           = GUIDOF!IFaxReceiptOptions;
const GUID IID_IFaxRecipient                = GUIDOF!IFaxRecipient;
const GUID IID_IFaxRecipients               = GUIDOF!IFaxRecipients;
const GUID IID_IFaxSecurity                 = GUIDOF!IFaxSecurity;
const GUID IID_IFaxSecurity2                = GUIDOF!IFaxSecurity2;
const GUID IID_IFaxSender                   = GUIDOF!IFaxSender;
const GUID IID_IFaxServer                   = GUIDOF!IFaxServer;
const GUID IID_IFaxServer2                  = GUIDOF!IFaxServer2;
const GUID IID_IFaxServerNotify             = GUIDOF!IFaxServerNotify;
const GUID IID_IFaxServerNotify2            = GUIDOF!IFaxServerNotify2;
const GUID IID__IFaxAccountNotify           = GUIDOF!_IFaxAccountNotify;
const GUID IID__IFaxServerNotify2           = GUIDOF!_IFaxServerNotify2;
