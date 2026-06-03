// Written in the D programming language.

module windows.win32.devices.fax;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, DEVPROPKEY, FILETIME,
                                         HANDLE, HINSTANCE, HRESULT, HWND, PSTR,
                                         PWSTR, SYSTEMTIME, VARIANT_BOOL;
public import windows.win32.graphics.gdi : HDC;
public import windows.win32.system.com : IDispatch, IUnknown;
public import windows.win32.system.io : OVERLAPPED;
public import windows.win32.system.registry : HKEY;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.controls : HPROPSHEETPAGE;

extern(Windows) @nogc nothrow:


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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_job_status_enum
alias FAX_JOB_STATUS_ENUM = int;
enum : int
{
    fjsPENDING          = 0x00000001,
    fjsINPROGRESS       = 0x00000002,
    fjsFAILED           = 0x00000008,
    fjsPAUSED           = 0x00000010,
    fjsNOLINE           = 0x00000020,
    fjsRETRYING         = 0x00000040,
    fjsRETRIES_EXCEEDED = 0x00000080,
    fjsCOMPLETED        = 0x00000100,
    fjsCANCELED         = 0x00000200,
    fjsCANCELING        = 0x00000400,
    fjsROUTING          = 0x00000800,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_job_extended_status_enum
alias FAX_JOB_EXTENDED_STATUS_ENUM = int;
enum : int
{
    fjesNONE               = 0x00000000,
    fjesDISCONNECTED       = 0x00000001,
    fjesINITIALIZING       = 0x00000002,
    fjesDIALING            = 0x00000003,
    fjesTRANSMITTING       = 0x00000004,
    fjesANSWERED           = 0x00000005,
    fjesRECEIVING          = 0x00000006,
    fjesLINE_UNAVAILABLE   = 0x00000007,
    fjesBUSY               = 0x00000008,
    fjesNO_ANSWER          = 0x00000009,
    fjesBAD_ADDRESS        = 0x0000000a,
    fjesNO_DIAL_TONE       = 0x0000000b,
    fjesFATAL_ERROR        = 0x0000000c,
    fjesCALL_DELAYED       = 0x0000000d,
    fjesCALL_BLACKLISTED   = 0x0000000e,
    fjesNOT_FAX_CALL       = 0x0000000f,
    fjesPARTIALLY_RECEIVED = 0x00000010,
    fjesHANDLED            = 0x00000011,
    fjesCALL_COMPLETED     = 0x00000012,
    fjesCALL_ABORTED       = 0x00000013,
    fjesPROPRIETARY        = 0x01000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_job_operations_enum
alias FAX_JOB_OPERATIONS_ENUM = int;
enum : int
{
    fjoVIEW           = 0x00000001,
    fjoPAUSE          = 0x00000002,
    fjoRESUME         = 0x00000004,
    fjoRESTART        = 0x00000008,
    fjoDELETE         = 0x00000010,
    fjoRECIPIENT_INFO = 0x00000020,
    fjoSENDER_INFO    = 0x00000040,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_job_type_enum
alias FAX_JOB_TYPE_ENUM = int;
enum : int
{
    fjtSEND    = 0x00000000,
    fjtRECEIVE = 0x00000001,
    fjtROUTING = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_server_events_type_enum
alias FAX_SERVER_EVENTS_TYPE_ENUM = int;
enum : int
{
    fsetNONE          = 0x00000000,
    fsetIN_QUEUE      = 0x00000001,
    fsetOUT_QUEUE     = 0x00000002,
    fsetCONFIG        = 0x00000004,
    fsetACTIVITY      = 0x00000008,
    fsetQUEUE_STATE   = 0x00000010,
    fsetIN_ARCHIVE    = 0x00000020,
    fsetOUT_ARCHIVE   = 0x00000040,
    fsetFXSSVC_ENDED  = 0x00000080,
    fsetDEVICE_STATUS = 0x00000100,
    fsetINCOMING_CALL = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_server_apiversion_enum
alias FAX_SERVER_APIVERSION_ENUM = int;
enum : int
{
    fsAPI_VERSION_0 = 0x00000000,
    fsAPI_VERSION_1 = 0x00010000,
    fsAPI_VERSION_2 = 0x00020000,
    fsAPI_VERSION_3 = 0x00030000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_smtp_authentication_type_enum
alias FAX_SMTP_AUTHENTICATION_TYPE_ENUM = int;
enum : int
{
    fsatANONYMOUS = 0x00000000,
    fsatBASIC     = 0x00000001,
    fsatNTLM      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_receipt_type_enum
alias FAX_RECEIPT_TYPE_ENUM = int;
enum : int
{
    frtNONE   = 0x00000000,
    frtMAIL   = 0x00000001,
    frtMSGBOX = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_access_rights_enum
alias FAX_ACCESS_RIGHTS_ENUM = int;
enum : int
{
    farSUBMIT_LOW         = 0x00000001,
    farSUBMIT_NORMAL      = 0x00000002,
    farSUBMIT_HIGH        = 0x00000004,
    farQUERY_JOBS         = 0x00000008,
    farMANAGE_JOBS        = 0x00000010,
    farQUERY_CONFIG       = 0x00000020,
    farMANAGE_CONFIG      = 0x00000040,
    farQUERY_IN_ARCHIVE   = 0x00000080,
    farMANAGE_IN_ARCHIVE  = 0x00000100,
    farQUERY_OUT_ARCHIVE  = 0x00000200,
    farMANAGE_OUT_ARCHIVE = 0x00000400,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_priority_type_enum
alias FAX_PRIORITY_TYPE_ENUM = int;
enum : int
{
    fptLOW    = 0x00000000,
    fptNORMAL = 0x00000001,
    fptHIGH   = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_coverpage_type_enum
alias FAX_COVERPAGE_TYPE_ENUM = int;
enum : int
{
    fcptNONE   = 0x00000000,
    fcptLOCAL  = 0x00000001,
    fcptSERVER = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_schedule_type_enum
alias FAX_SCHEDULE_TYPE_ENUM = int;
enum : int
{
    fstNOW             = 0x00000000,
    fstSPECIFIC_TIME   = 0x00000001,
    fstDISCOUNT_PERIOD = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_provider_status_enum
alias FAX_PROVIDER_STATUS_ENUM = int;
enum : int
{
    fpsSUCCESS      = 0x00000000,
    fpsSERVER_ERROR = 0x00000001,
    fpsBAD_GUID     = 0x00000002,
    fpsBAD_VERSION  = 0x00000003,
    fpsCANT_LOAD    = 0x00000004,
    fpsCANT_LINK    = 0x00000005,
    fpsCANT_INIT    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_device_receive_mode_enum
alias FAX_DEVICE_RECEIVE_MODE_ENUM = int;
enum : int
{
    fdrmNO_ANSWER     = 0x00000000,
    fdrmAUTO_ANSWER   = 0x00000001,
    fdrmMANUAL_ANSWER = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_log_level_enum
alias FAX_LOG_LEVEL_ENUM = int;
enum : int
{
    fllNONE = 0x00000000,
    fllMIN  = 0x00000001,
    fllMED  = 0x00000002,
    fllMAX  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_group_status_enum
alias FAX_GROUP_STATUS_ENUM = int;
enum : int
{
    fgsALL_DEV_VALID      = 0x00000000,
    fgsEMPTY              = 0x00000001,
    fgsALL_DEV_NOT_VALID  = 0x00000002,
    fgsSOME_DEV_NOT_VALID = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_rule_status_enum
alias FAX_RULE_STATUS_ENUM = int;
enum : int
{
    frsVALID                    = 0x00000000,
    frsEMPTY_GROUP              = 0x00000001,
    frsALL_GROUP_DEV_NOT_VALID  = 0x00000002,
    frsSOME_GROUP_DEV_NOT_VALID = 0x00000003,
    frsBAD_DEVICE               = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_account_events_type_enum
alias FAX_ACCOUNT_EVENTS_TYPE_ENUM = int;
enum : int
{
    faetNONE         = 0x00000000,
    faetIN_QUEUE     = 0x00000001,
    faetOUT_QUEUE    = 0x00000002,
    faetIN_ARCHIVE   = 0x00000004,
    faetOUT_ARCHIVE  = 0x00000008,
    faetFXSSVC_ENDED = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_access_rights_enum_2
alias FAX_ACCESS_RIGHTS_ENUM_2 = int;
enum : int
{
    far2SUBMIT_LOW            = 0x00000001,
    far2SUBMIT_NORMAL         = 0x00000002,
    far2SUBMIT_HIGH           = 0x00000004,
    far2QUERY_OUT_JOBS        = 0x00000008,
    far2MANAGE_OUT_JOBS       = 0x00000010,
    far2QUERY_CONFIG          = 0x00000020,
    far2MANAGE_CONFIG         = 0x00000040,
    far2QUERY_ARCHIVES        = 0x00000080,
    far2MANAGE_ARCHIVES       = 0x00000100,
    far2MANAGE_RECEIVE_FOLDER = 0x00000200,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/ne-faxcomex-fax_routing_rule_code_enum
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

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/fxsutility/ne-fxsutility-sendtomode
enum SendToMode : int
{
    SEND_TO_FAX_RECIPIENT_ATTACHMENT = 0x00000000,
}

alias STI_DEVICE_MJ_TYPE = int;
enum : int
{
    StiDeviceTypeDefault        = 0x00000000,
    StiDeviceTypeScanner        = 0x00000001,
    StiDeviceTypeDigitalCamera  = 0x00000002,
    StiDeviceTypeStreamingVideo = 0x00000003,
}

// Constants


enum uint prv_DEFAULT_PREFETCH_SIZE = 0x00000064U;
enum uint FS_INITIALIZING = 0x20000000U;
enum uint FS_DIALING = 0x20000001U;
enum uint FS_TRANSMITTING = 0x20000002U;
enum uint FS_RECEIVING = 0x20000004U;
enum uint FS_COMPLETED = 0x20000008U;
enum uint FS_HANDLED = 0x20000010U;
enum uint FS_LINE_UNAVAILABLE = 0x20000020U;

enum : uint
{
    FS_BUSY      = 0x20000040U,
    FS_NO_ANSWER = 0x20000080U,
}

enum uint FS_BAD_ADDRESS = 0x20000100U;
enum uint FS_NO_DIAL_TONE = 0x20000200U;
enum uint FS_DISCONNECTED = 0x20000400U;
enum uint FS_FATAL_ERROR = 0x20000800U;
enum uint FS_NOT_FAX_CALL = 0x20001000U;

enum : uint
{
    FS_CALL_DELAYED     = 0x20002000U,
    FS_CALL_BLACKLISTED = 0x20004000U,
}

enum uint FS_USER_ABORT = 0x20200000U;
enum uint FS_ANSWERED = 0x20800000U;

enum : uint
{
    FAXDEVRECEIVE_SIZE      = 0x00001000U,
    FAXDEVREPORTSTATUS_SIZE = 0x00001000U,
}

enum : const(wchar)*
{
    MS_FAXROUTE_PRINTING_GUID = "{aec1b37c-9af2-11d0-abf7-00c04fd91a4e}",
    MS_FAXROUTE_FOLDER_GUID   = "{92041a90-9af2-11d0-abf7-00c04fd91a4e}",
    MS_FAXROUTE_EMAIL_GUID    = "{6bbf7bfe-9af2-11d0-abf7-00c04fd91a4e}",
}

enum : int
{
    FAX_ERR_START           = 0x00001b59,
    FAX_ERR_SRV_OUTOFMEMORY = 0x00001b59,
}

enum int FAX_ERR_GROUP_NOT_FOUND = 0x00001b5a;
enum int FAX_ERR_BAD_GROUP_CONFIGURATION = 0x00001b5b;
enum int FAX_ERR_GROUP_IN_USE = 0x00001b5c;
enum int FAX_ERR_RULE_NOT_FOUND = 0x00001b5d;

enum : int
{
    FAX_ERR_NOT_NTFS         = 0x00001b5e,
    FAX_ERR_DIRECTORY_IN_USE = 0x00001b5f,
}

enum int FAX_ERR_FILE_ACCESS_DENIED = 0x00001b60;
enum int FAX_ERR_MESSAGE_NOT_FOUND = 0x00001b61;
enum int FAX_ERR_DEVICE_NUM_LIMIT_EXCEEDED = 0x00001b62;
enum int FAX_ERR_NOT_SUPPORTED_ON_THIS_SKU = 0x00001b63;
enum int FAX_ERR_VERSION_MISMATCH = 0x00001b64;
enum int FAX_ERR_RECIPIENTS_LIMIT = 0x00001b65;
enum int FAX_ERR_END = 0x00001b65;
enum HRESULT FAX_E_SRV_OUTOFMEMORY = HRESULT(0x80041b59);
enum HRESULT FAX_E_GROUP_NOT_FOUND = HRESULT(0x80041b5a);
enum HRESULT FAX_E_BAD_GROUP_CONFIGURATION = HRESULT(0x80041b5b);
enum HRESULT FAX_E_GROUP_IN_USE = HRESULT(0x80041b5c);
enum HRESULT FAX_E_RULE_NOT_FOUND = HRESULT(0x80041b5d);

enum : HRESULT
{
    FAX_E_NOT_NTFS         = HRESULT(0x80041b5e),
    FAX_E_DIRECTORY_IN_USE = HRESULT(0x80041b5f),
}

enum HRESULT FAX_E_FILE_ACCESS_DENIED = HRESULT(0x80041b60);
enum HRESULT FAX_E_MESSAGE_NOT_FOUND = HRESULT(0x80041b61);
enum HRESULT FAX_E_DEVICE_NUM_LIMIT_EXCEEDED = HRESULT(0x80041b62);
enum HRESULT FAX_E_NOT_SUPPORTED_ON_THIS_SKU = HRESULT(0x80041b63);
enum HRESULT FAX_E_VERSION_MISMATCH = HRESULT(0x80041b64);
enum HRESULT FAX_E_RECIPIENTS_LIMIT = HRESULT(0x80041b65);
enum uint JT_UNKNOWN = 0x00000000U;

enum : uint
{
    JT_SEND    = 0x00000001U,
    JT_RECEIVE = 0x00000002U,
}

enum uint JT_ROUTING = 0x00000003U;
enum uint JT_FAIL_RECEIVE = 0x00000004U;
enum uint JS_PENDING = 0x00000000U;
enum uint JS_INPROGRESS = 0x00000001U;
enum uint JS_DELETING = 0x00000002U;
enum uint JS_FAILED = 0x00000004U;
enum uint JS_PAUSED = 0x00000008U;
enum uint JS_NOLINE = 0x00000010U;

enum : uint
{
    JS_RETRYING         = 0x00000020U,
    JS_RETRIES_EXCEEDED = 0x00000040U,
}

enum uint FPS_DIALING = 0x20000001U;
enum uint FPS_SENDING = 0x20000002U;
enum uint FPS_RECEIVING = 0x20000004U;
enum uint FPS_COMPLETED = 0x20000008U;
enum uint FPS_HANDLED = 0x20000010U;
enum uint FPS_UNAVAILABLE = 0x20000020U;

enum : uint
{
    FPS_BUSY      = 0x20000040U,
    FPS_NO_ANSWER = 0x20000080U,
}

enum uint FPS_BAD_ADDRESS = 0x20000100U;
enum uint FPS_NO_DIAL_TONE = 0x20000200U;
enum uint FPS_DISCONNECTED = 0x20000400U;
enum uint FPS_FATAL_ERROR = 0x20000800U;
enum uint FPS_NOT_FAX_CALL = 0x20001000U;

enum : uint
{
    FPS_CALL_DELAYED     = 0x20002000U,
    FPS_CALL_BLACKLISTED = 0x20004000U,
}

enum uint FPS_INITIALIZING = 0x20008000U;
enum uint FPS_OFFLINE = 0x20010000U;
enum uint FPS_RINGING = 0x20020000U;
enum uint FPS_AVAILABLE = 0x20100000U;
enum uint FPS_ABORTING = 0x20200000U;
enum uint FPS_ROUTING = 0x20400000U;
enum uint FPS_ANSWERED = 0x20800000U;
enum uint FPF_RECEIVE = 0x00000001U;

enum : uint
{
    FPF_SEND    = 0x00000002U,
    FPF_VIRTUAL = 0x00000004U,
}

enum uint FEI_DIALING = 0x00000001U;
enum uint FEI_SENDING = 0x00000002U;
enum uint FEI_RECEIVING = 0x00000003U;
enum uint FEI_COMPLETED = 0x00000004U;

enum : uint
{
    FEI_BUSY      = 0x00000005U,
    FEI_NO_ANSWER = 0x00000006U,
}

enum uint FEI_BAD_ADDRESS = 0x00000007U;
enum uint FEI_NO_DIAL_TONE = 0x00000008U;
enum uint FEI_DISCONNECTED = 0x00000009U;
enum uint FEI_FATAL_ERROR = 0x0000000aU;
enum uint FEI_NOT_FAX_CALL = 0x0000000bU;

enum : uint
{
    FEI_CALL_DELAYED     = 0x0000000cU,
    FEI_CALL_BLACKLISTED = 0x0000000dU,
}

enum uint FEI_RINGING = 0x0000000eU;
enum uint FEI_ABORTING = 0x0000000fU;
enum uint FEI_ROUTING = 0x00000010U;

enum : uint
{
    FEI_MODEM_POWERED_ON  = 0x00000011U,
    FEI_MODEM_POWERED_OFF = 0x00000012U,
}

enum : uint
{
    FEI_IDLE         = 0x00000013U,
    FEI_FAXSVC_ENDED = 0x00000014U,
}

enum uint FEI_ANSWERED = 0x00000015U;
enum uint FEI_JOB_QUEUED = 0x00000016U;
enum uint FEI_DELETED = 0x00000017U;
enum uint FEI_INITIALIZING = 0x00000018U;
enum uint FEI_LINE_UNAVAILABLE = 0x00000019U;
enum uint FEI_HANDLED = 0x0000001aU;
enum uint FEI_FAXSVC_STARTED = 0x0000001bU;
enum uint FEI_NEVENTS = 0x0000001bU;

enum : uint
{
    FAX_JOB_SUBMIT = 0x00000001U,
    FAX_JOB_QUERY  = 0x00000002U,
}

enum : uint
{
    FAX_CONFIG_QUERY = 0x00000004U,
    FAX_CONFIG_SET   = 0x00000008U,
}

enum : uint
{
    FAX_PORT_QUERY = 0x00000010U,
    FAX_PORT_SET   = 0x00000020U,
}

enum uint FAX_JOB_MANAGE = 0x00000040U;

enum : GUID
{
    FAXSRV_DEVICE_NODETYPE_GUID          = GUID("3115a19a-6251-46ac-9425-14782858b8c9"),
    FAXSRV_DEVICE_PROVIDER_NODETYPE_GUID = GUID("bd38e2ac-b926-4161-8640-0f6956ee2ba3"),
}

enum GUID FAXSRV_ROUTING_METHOD_NODETYPE_GUID = GUID("220d2cb0-85a9-4a43-b6e8-9d66b44f1af5");

enum : const(wchar)*
{
    CF_MSFAXSRV_DEVICE_ID           = "FAXSRV_DeviceID",
    CF_MSFAXSRV_FSP_GUID            = "FAXSRV_FSPGuid",
    CF_MSFAXSRV_SERVER_NAME         = "FAXSRV_ServerName",
    CF_MSFAXSRV_ROUTEEXT_NAME       = "FAXSRV_RoutingExtName",
    CF_MSFAXSRV_ROUTING_METHOD_GUID = "FAXSRV_RoutingMethodGuid",
}

enum uint STI_UNICODE = 0x00000001U;
enum GUID CLSID_Sti = GUID("b323f8e0-2e68-11d0-90ea-00aa0060f86c");
enum GUID GUID_DeviceArrivedLaunch = GUID("740d9ee6-70f1-11d1-ad10-00a02438ad48");

enum : GUID
{
    GUID_ScanImage      = GUID("a6c5a715-8c6e-11d2-977a-0000f87a926f"),
    GUID_ScanPrintImage = GUID("b441f425-8c6e-11d2-977a-0000f87a926f"),
    GUID_ScanFaxImage   = GUID("c00eb793-8c6e-11d2-977a-0000f87a926f"),
}

enum : GUID
{
    GUID_STIUserDefined1 = GUID("c00eb795-8c6e-11d2-977a-0000f87a926f"),
    GUID_STIUserDefined2 = GUID("c77ae9c5-8c6e-11d2-977a-0000f87a926f"),
    GUID_STIUserDefined3 = GUID("c77ae9c6-8c6e-11d2-977a-0000f87a926f"),
}

enum : uint
{
    STI_VERSION_FLAG_MASK    = 0xff000000U,
    STI_VERSION_FLAG_UNICODE = 0x01000000U,
    STI_VERSION_REAL         = 0x00000002U,
    STI_VERSION_MIN_ALLOWED  = 0x00000002U,
    STI_VERSION              = 0x00000002U,
}

enum uint STI_MAX_INTERNAL_NAME_LENGTH = 0x00000080U;

enum : uint
{
    STI_GENCAP_COMMON_MASK           = 0x000000ffU,
    STI_GENCAP_NOTIFICATIONS         = 0x00000001U,
    STI_GENCAP_POLLING_NEEDED        = 0x00000002U,
    STI_GENCAP_GENERATE_ARRIVALEVENT = 0x00000004U,
}

enum : uint
{
    STI_GENCAP_AUTO_PORTSELECT = 0x00000008U,
    STI_GENCAP_WIA             = 0x00000010U,
    STI_GENCAP_SUBSET          = 0x00000020U,
}

enum uint WIA_INCOMPAT_XP = 0x00000001U;

enum : uint
{
    STI_HW_CONFIG_UNKNOWN  = 0x00000001U,
    STI_HW_CONFIG_SCSI     = 0x00000002U,
    STI_HW_CONFIG_USB      = 0x00000004U,
    STI_HW_CONFIG_SERIAL   = 0x00000008U,
    STI_HW_CONFIG_PARALLEL = 0x00000010U,
}

enum : uint
{
    STI_DEVSTATUS_ONLINE_STATE = 0x00000001U,
    STI_DEVSTATUS_EVENTS_STATE = 0x00000002U,
}

enum : uint
{
    STI_ONLINESTATE_OPERATIONAL       = 0x00000001U,
    STI_ONLINESTATE_PENDING           = 0x00000002U,
    STI_ONLINESTATE_ERROR             = 0x00000004U,
    STI_ONLINESTATE_PAUSED            = 0x00000008U,
    STI_ONLINESTATE_PAPER_JAM         = 0x00000010U,
    STI_ONLINESTATE_PAPER_PROBLEM     = 0x00000020U,
    STI_ONLINESTATE_OFFLINE           = 0x00000040U,
    STI_ONLINESTATE_IO_ACTIVE         = 0x00000080U,
    STI_ONLINESTATE_BUSY              = 0x00000100U,
    STI_ONLINESTATE_TRANSFERRING      = 0x00000200U,
    STI_ONLINESTATE_INITIALIZING      = 0x00000400U,
    STI_ONLINESTATE_WARMING_UP        = 0x00000800U,
    STI_ONLINESTATE_USER_INTERVENTION = 0x00001000U,
    STI_ONLINESTATE_POWER_SAVE        = 0x00002000U,
}

enum : uint
{
    STI_EVENTHANDLING_ENABLED = 0x00000001U,
    STI_EVENTHANDLING_POLLING = 0x00000002U,
    STI_EVENTHANDLING_PENDING = 0x00000004U,
}

enum uint STI_DIAGCODE_HWPRESENCE = 0x00000001U;

enum : uint
{
    STI_TRACE_INFORMATION = 0x00000001U,
    STI_TRACE_WARNING     = 0x00000002U,
    STI_TRACE_ERROR       = 0x00000004U,
}

enum : uint
{
    STI_SUBSCRIBE_FLAG_WINDOW = 0x00000001U,
    STI_SUBSCRIBE_FLAG_EVENT  = 0x00000002U,
}

enum uint MAX_NOTIFICATION_DATA = 0x00000040U;
// Native encoding: ansi
enum const(wchar)* STI_ADD_DEVICE_BROADCAST_ACTION = "Arrival";
// Native encoding: ansi
enum const(wchar)* STI_REMOVE_DEVICE_BROADCAST_ACTION = "Removal";
// Native encoding: ansi
enum const(wchar)* STI_ADD_DEVICE_BROADCAST_STRING = "STI\\";
// Native encoding: ansi
enum const(wchar)* STI_REMOVE_DEVICE_BROADCAST_STRING = "STI\\";

enum : uint
{
    STI_DEVICE_CREATE_STATUS = 0x00000001U,
    STI_DEVICE_CREATE_DATA   = 0x00000002U,
    STI_DEVICE_CREATE_BOTH   = 0x00000003U,
    STI_DEVICE_CREATE_MASK   = 0x0000ffffU,
}

enum : uint
{
    STIEDFL_ALLDEVICES   = 0x00000000U,
    STIEDFL_ATTACHEDONLY = 0x00000001U,
}

enum uint STI_RAW_RESERVED = 0x00001000U;

enum : int
{
    STI_OK             = 0x00000000,
    STI_ERROR_NO_ERROR = 0x00000000,
}

enum int STI_NOTCONNECTED = 0x00000001;
enum int STI_CHANGENOEFFECT = 0x00000001;
enum HRESULT STIERR_OLD_VERSION = HRESULT(0x8007047e);

enum : HRESULT
{
    STIERR_BETA_VERSION = HRESULT(0x80070481),
    STIERR_BADDRIVER    = HRESULT(0x80070077),
}

enum int STIERR_DEVICENOTREG = 0x80040154;
enum HRESULT STIERR_OBJECTNOTFOUND = HRESULT(0x80070002);
enum int STIERR_INVALID_PARAM = 0x80070057;
enum int STIERR_NOINTERFACE = 0x80004002;

enum : int
{
    STIERR_GENERIC     = 0x80004005,
    STIERR_OUTOFMEMORY = 0x8007000e,
}

enum int STIERR_UNSUPPORTED = 0x80004001;
enum HRESULT STIERR_NOT_INITIALIZED = HRESULT(0x80070015);
enum HRESULT STIERR_ALREADY_INITIALIZED = HRESULT(0x800704df);
enum HRESULT STIERR_DEVICE_LOCKED = HRESULT(0x80070021);

enum : int
{
    STIERR_READONLY       = 0x80070005,
    STIERR_NOTINITIALIZED = 0x80070005,
}

enum : HRESULT
{
    STIERR_NEEDS_LOCK        = HRESULT(0x8007009e),
    STIERR_SHARING_VIOLATION = HRESULT(0x80070020),
}

enum HRESULT STIERR_HANDLEEXISTS = HRESULT(0x800700b7);

enum : HRESULT
{
    STIERR_INVALID_DEVICE_NAME = HRESULT(0x8007007b),
    STIERR_INVALID_HW_TYPE     = HRESULT(0x8007000d),
}

enum : HRESULT
{
    STIERR_NOEVENTS        = HRESULT(0x80070103),
    STIERR_DEVICE_NOTREADY = HRESULT(0x80070015),
}

enum : const(wchar)*
{
    REGSTR_VAL_TYPE_W          = "Type",
    REGSTR_VAL_VENDOR_NAME_W   = "Vendor",
    REGSTR_VAL_DEVICETYPE_W    = "DeviceType",
    REGSTR_VAL_DEVICESUBTYPE_W = "DeviceSubType",
    REGSTR_VAL_DEV_NAME_W      = "DeviceName",
    REGSTR_VAL_DRIVER_DESC_W   = "DriverDesc",
    REGSTR_VAL_FRIENDLY_NAME_W = "FriendlyName",
    REGSTR_VAL_GENERIC_CAPS_W  = "Capabilities",
    REGSTR_VAL_HARDWARE_W      = "HardwareConfig",
    REGSTR_VAL_HARDWARE        = "HardwareConfig",
    REGSTR_VAL_DEVICE_NAME_W   = "DriverDesc",
    REGSTR_VAL_DATA_W          = "DeviceData",
    REGSTR_VAL_GUID_W          = "GUID",
    REGSTR_VAL_GUID            = "GUID",
    REGSTR_VAL_LAUNCH_APPS_W   = "LaunchApplications",
    REGSTR_VAL_LAUNCH_APPS     = "LaunchApplications",
    REGSTR_VAL_LAUNCHABLE_W    = "Launchable",
    REGSTR_VAL_LAUNCHABLE      = "Launchable",
    REGSTR_VAL_SHUTDOWNDELAY_W = "ShutdownIfUnusedDelay",
    REGSTR_VAL_SHUTDOWNDELAY   = "ShutdownIfUnusedDelay",
}

enum const(wchar)* IS_DIGITAL_CAMERA_STR = "IsDigitalCamera";
enum uint IS_DIGITAL_CAMERA_VAL = 0x00000001U;
enum const(wchar)* SUPPORTS_MSCPLUS_STR = "SupportsMSCPlus";
enum uint SUPPORTS_MSCPLUS_VAL = 0x00000001U;

enum : const(wchar)*
{
    STI_DEVICE_VALUE_TWAIN_NAME            = "TwainDS",
    STI_DEVICE_VALUE_ISIS_NAME             = "ISISDriverName",
    STI_DEVICE_VALUE_ICM_PROFILE           = "ICMProfile",
    STI_DEVICE_VALUE_DEFAULT_LAUNCHAPP     = "DefaultLaunchApp",
    STI_DEVICE_VALUE_TIMEOUT               = "PollTimeout",
    STI_DEVICE_VALUE_DISABLE_NOTIFICATIONS = "DisableNotifications",
}

enum const(wchar)* REGSTR_VAL_BAUDRATE = "BaudRate";

enum : const(wchar)*
{
    // Native encoding: ansi
    STI_DEVICE_VALUE_TWAIN_NAME_A            = "TwainDS",
    // Native encoding: ansi
    STI_DEVICE_VALUE_ISIS_NAME_A             = "ISISDriverName",
    // Native encoding: ansi
    STI_DEVICE_VALUE_ICM_PROFILE_A           = "ICMProfile",
    // Native encoding: ansi
    STI_DEVICE_VALUE_DEFAULT_LAUNCHAPP_A     = "DefaultLaunchApp",
    // Native encoding: ansi
    STI_DEVICE_VALUE_TIMEOUT_A               = "PollTimeout",
    // Native encoding: ansi
    STI_DEVICE_VALUE_DISABLE_NOTIFICATIONS_A = "DisableNotifications",
}

// Native encoding: ansi
enum const(wchar)* REGSTR_VAL_BAUDRATE_A = "BaudRate";

enum : DEVPROPKEY
{
    DEVPKEY_WIA_DeviceType = DEVPROPKEY(GUID("6BDD1FC6-810F-11D0-BEC7-08002BE2092F"), 2),
    DEVPKEY_WIA_USDClassId = DEVPROPKEY(GUID("6BDD1FC6-810F-11D0-BEC7-08002BE2092F"), 3),
}

enum uint STI_USD_GENCAP_NATIVE_PUSHSUPPORT = 0x00000001U;
enum uint STI_DEVICE_CREATE_FOR_MONITOR = 0x01000000U;
enum int lDEFAULT_PREFETCH_SIZE = 0x00000064;
enum ushort wcharREASSIGN_RECIPIENTS_DELIMITER = 0x003b;

// Callbacks

alias PFAXCONNECTFAXSERVERA = BOOL function(const(PSTR) MachineName, HANDLE* FaxHandle);
alias PFAXCONNECTFAXSERVERW = BOOL function(const(PWSTR) MachineName, HANDLE* FaxHandle);
alias PFAXCLOSE = BOOL function(HANDLE FaxHandle);
alias PFAXOPENPORT = BOOL function(HANDLE FaxHandle, uint DeviceId, uint Flags, HANDLE* FaxPortHandle);
alias PFAXCOMPLETEJOBPARAMSA = BOOL function(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);
alias PFAXCOMPLETEJOBPARAMSW = BOOL function(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);
alias PFAXSENDDOCUMENTA = BOOL function(HANDLE FaxHandle, const(PSTR) FileName, FAX_JOB_PARAMA* JobParams, 
                                        const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);
alias PFAXSENDDOCUMENTW = BOOL function(HANDLE FaxHandle, const(PWSTR) FileName, FAX_JOB_PARAMW* JobParams, 
                                        const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);
alias PFAX_RECIPIENT_CALLBACKA = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMA* JobParams, FAX_COVERPAGE_INFOA* CoverpageInfo);
alias PFAX_RECIPIENT_CALLBACKW = BOOL function(HANDLE FaxHandle, uint RecipientNumber, void* Context, 
                                               FAX_JOB_PARAMW* JobParams, FAX_COVERPAGE_INFOW* CoverpageInfo);
alias PFAXSENDDOCUMENTFORBROADCASTA = BOOL function(HANDLE FaxHandle, const(PSTR) FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);
alias PFAXSENDDOCUMENTFORBROADCASTW = BOOL function(HANDLE FaxHandle, const(PWSTR) FileName, uint* FaxJobId, 
                                                    PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);
alias PFAXENUMJOBSA = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);
alias PFAXENUMJOBSW = BOOL function(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);
alias PFAXGETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);
alias PFAXGETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);
alias PFAXSETJOBA = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);
alias PFAXSETJOBW = BOOL function(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);
alias PFAXGETPAGEDATA = BOOL function(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, 
                                      uint* ImageWidth, uint* ImageHeight);
alias PFAXGETDEVICESTATUSA = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);
alias PFAXGETDEVICESTATUSW = BOOL function(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);
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
alias PFAXENABLEROUTINGMETHODA = BOOL function(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, BOOL Enabled);
alias PFAXENABLEROUTINGMETHODW = BOOL function(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, BOOL Enabled);
alias PFAXENUMGLOBALROUTINGINFOA = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXENUMGLOBALROUTINGINFOW = BOOL function(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, 
                                                 uint* MethodsReturned);
alias PFAXSETGLOBALROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);
alias PFAXSETGLOBALROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);
alias PFAXGETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, ubyte** RoutingInfoBuffer, 
                                          uint* RoutingInfoBufferSize);
alias PFAXGETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, 
                                          ubyte** RoutingInfoBuffer, uint* RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOA = BOOL function(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXSETROUTINGINFOW = BOOL function(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, 
                                          const(ubyte)* RoutingInfoBuffer, uint RoutingInfoBufferSize);
alias PFAXINITIALIZEEVENTQUEUE = BOOL function(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, 
                                               HWND hWnd, uint MessageStart);
alias PFAXFREEBUFFER = void function(void* Buffer);
alias PFAXSTARTPRINTJOBA = BOOL function(const(PSTR) PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOA* FaxContextInfo);
alias PFAXSTARTPRINTJOBW = BOOL function(const(PWSTR) PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, 
                                         uint* FaxJobId, FAX_CONTEXT_INFOW* FaxContextInfo);
alias PFAXPRINTCOVERPAGEA = BOOL function(const(FAX_CONTEXT_INFOA)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOA)* CoverPageInfo);
alias PFAXPRINTCOVERPAGEW = BOOL function(const(FAX_CONTEXT_INFOW)* FaxContextInfo, 
                                          const(FAX_COVERPAGE_INFOW)* CoverPageInfo);
alias PFAXREGISTERSERVICEPROVIDERW = BOOL function(const(PWSTR) DeviceProvider, const(PWSTR) FriendlyName, 
                                                   const(PWSTR) ImageName, const(PWSTR) TspName);
alias PFAXUNREGISTERSERVICEPROVIDERW = BOOL function(const(PWSTR) DeviceProvider);
alias PFAX_ROUTING_INSTALLATION_CALLBACKW = BOOL function(HANDLE FaxHandle, void* Context, PWSTR MethodName, 
                                                          PWSTR FriendlyName, PWSTR FunctionName, PWSTR Guid);
alias PFAXREGISTERROUTINGEXTENSIONW = BOOL function(HANDLE FaxHandle, const(PWSTR) ExtensionName, 
                                                    const(PWSTR) FriendlyName, const(PWSTR) ImageName, 
                                                    PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, void* Context);
alias PFAXACCESSCHECK = BOOL function(HANDLE FaxHandle, uint AccessMask);
alias PFAX_SERVICE_CALLBACK = BOOL function(HANDLE FaxHandle, uint DeviceId, size_t Param1, size_t Param2, 
                                            size_t Param3);
alias PFAX_LINECALLBACK = void function(HANDLE FaxHandle, uint hDevice, uint dwMessage, size_t dwInstance, 
                                        size_t dwParam1, size_t dwParam2, size_t dwParam3);
alias PFAX_SEND_CALLBACK = BOOL function(HANDLE FaxHandle, uint CallHandle, uint Reserved1, uint Reserved2);
alias PFAXDEVINITIALIZE = BOOL function(uint param0, HANDLE param1, PFAX_LINECALLBACK* param2, 
                                        PFAX_SERVICE_CALLBACK param3);
alias PFAXDEVVIRTUALDEVICECREATION = BOOL function(uint* DeviceCount, PWSTR DeviceNamePrefix, uint* DeviceIdPrefix, 
                                                   HANDLE CompletionPort, size_t CompletionKey);
alias PFAXDEVSTARTJOB = BOOL function(uint param0, uint param1, HANDLE* param2, HANDLE param3, size_t param4);
alias PFAXDEVENDJOB = BOOL function(HANDLE param0);
alias PFAXDEVSEND = BOOL function(HANDLE param0, FAX_SEND* param1, PFAX_SEND_CALLBACK param2);
alias PFAXDEVRECEIVE = BOOL function(HANDLE param0, uint param1, FAX_RECEIVE* param2);
alias PFAXDEVREPORTSTATUS = BOOL function(HANDLE param0, FAX_DEV_STATUS* param1, uint param2, uint* param3);
alias PFAXDEVABORTOPERATION = BOOL function(HANDLE param0);
alias PFAXDEVCONFIGURE = BOOL function(HPROPSHEETPAGE* param0);
alias PFAXDEVSHUTDOWN = HRESULT function();
alias PFAXROUTEADDFILE = int function(uint JobId, const(PWSTR) FileName, GUID* Guid);
alias PFAXROUTEDELETEFILE = int function(uint JobId, const(PWSTR) FileName);
alias PFAXROUTEGETFILE = BOOL function(uint JobId, uint Index, 
                                       /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(3)))])*/PWSTR FileNameBuffer, 
                                       uint* RequiredSize);
alias PFAXROUTEENUMFILE = BOOL function(uint JobId, GUID* GuidOwner, GUID* GuidCaller, const(PWSTR) FileName, 
                                        void* Context);
alias PFAXROUTEENUMFILES = BOOL function(uint JobId, GUID* Guid, PFAXROUTEENUMFILE FileEnumerator, void* Context);
alias PFAXROUTEMODIFYROUTINGDATA = BOOL function(uint JobId, const(PWSTR) RoutingGuid, ubyte* RoutingData, 
                                                 uint RoutingDataSize);
alias PFAXROUTEINITIALIZE = BOOL function(HANDLE param0, FAX_ROUTE_CALLBACKROUTINES* param1);
alias PFAXROUTEMETHOD = BOOL function(const(FAX_ROUTE)* param0, void** param1, uint* param2);
alias PFAXROUTEDEVICEENABLE = BOOL function(const(PWSTR) param0, uint param1, int param2);
alias PFAXROUTEDEVICECHANGENOTIFICATION = BOOL function(uint param0, BOOL param1);
alias PFAXROUTEGETROUTINGINFO = BOOL function(const(PWSTR) param0, uint param1, ubyte* param2, uint* param3);
alias PFAXROUTESETROUTINGINFO = BOOL function(const(PWSTR) param0, uint param1, const(ubyte)* param2, uint param3);
alias PFAX_EXT_GET_DATA = uint function(uint param0, FAX_ENUM_DEVICE_ID_SOURCE param1, const(PWSTR) param2, 
                                        ubyte** param3, uint* param4);
alias PFAX_EXT_SET_DATA = uint function(HINSTANCE param0, uint param1, FAX_ENUM_DEVICE_ID_SOURCE param2, 
                                        const(PWSTR) param3, ubyte* param4, uint param5);
alias PFAX_EXT_CONFIG_CHANGE = HRESULT function(uint param0, const(PWSTR) param1, ubyte* param2, uint param3);
alias PFAX_EXT_REGISTER_FOR_EVENTS = HANDLE function(HINSTANCE param0, uint param1, 
                                                     FAX_ENUM_DEVICE_ID_SOURCE param2, const(PWSTR) param3, 
                                                     PFAX_EXT_CONFIG_CHANGE param4);
alias PFAX_EXT_UNREGISTER_FOR_EVENTS = uint function(HANDLE param0);
alias PFAX_EXT_FREE_BUFFER = void function(void* param0);
alias PFAX_EXT_INITIALIZE_CONFIG = HRESULT function(PFAX_EXT_GET_DATA param0, PFAX_EXT_SET_DATA param1, 
                                                    PFAX_EXT_REGISTER_FOR_EVENTS param2, 
                                                    PFAX_EXT_UNREGISTER_FOR_EVENTS param3, 
                                                    PFAX_EXT_FREE_BUFFER param4);

// Structs


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_log_categorya
struct FAX_LOG_CATEGORYA
{
    const(PSTR) Name;
    uint        Category;
    uint        Level;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_log_categoryw
struct FAX_LOG_CATEGORYW
{
    const(PWSTR) Name;
    uint         Category;
    uint         Level;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_time
struct FAX_TIME
{
    ushort Hour;
    ushort Minute;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_configurationa
struct FAX_CONFIGURATIONA
{
    uint        SizeOfStruct;
    uint        Retries;
    uint        RetryDelay;
    uint        DirtyDays;
    BOOL        Branding;
    BOOL        UseDeviceTsid;
    BOOL        ServerCp;
    BOOL        PauseServerQueue;
    FAX_TIME    StartCheapTime;
    FAX_TIME    StopCheapTime;
    BOOL        ArchiveOutgoingFaxes;
    const(PSTR) ArchiveDirectory;
    const(PSTR) Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_configurationw
struct FAX_CONFIGURATIONW
{
    uint         SizeOfStruct;
    uint         Retries;
    uint         RetryDelay;
    uint         DirtyDays;
    BOOL         Branding;
    BOOL         UseDeviceTsid;
    BOOL         ServerCp;
    BOOL         PauseServerQueue;
    FAX_TIME     StartCheapTime;
    FAX_TIME     StopCheapTime;
    BOOL         ArchiveOutgoingFaxes;
    const(PWSTR) ArchiveDirectory;
    const(PWSTR) Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_device_statusa
struct FAX_DEVICE_STATUSA
{
    uint        SizeOfStruct;
    const(PSTR) CallerId;
    const(PSTR) Csid;
    uint        CurrentPage;
    uint        DeviceId;
    const(PSTR) DeviceName;
    const(PSTR) DocumentName;
    uint        JobType;
    const(PSTR) PhoneNumber;
    const(PSTR) RoutingString;
    const(PSTR) SenderName;
    const(PSTR) RecipientName;
    uint        Size;
    FILETIME    StartTime;
    uint        Status;
    const(PSTR) StatusString;
    FILETIME    SubmittedTime;
    uint        TotalPages;
    const(PSTR) Tsid;
    const(PSTR) UserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_device_statusw
struct FAX_DEVICE_STATUSW
{
    uint         SizeOfStruct;
    const(PWSTR) CallerId;
    const(PWSTR) Csid;
    uint         CurrentPage;
    uint         DeviceId;
    const(PWSTR) DeviceName;
    const(PWSTR) DocumentName;
    uint         JobType;
    const(PWSTR) PhoneNumber;
    const(PWSTR) RoutingString;
    const(PWSTR) SenderName;
    const(PWSTR) RecipientName;
    uint         Size;
    FILETIME     StartTime;
    uint         Status;
    const(PWSTR) StatusString;
    FILETIME     SubmittedTime;
    uint         TotalPages;
    const(PWSTR) Tsid;
    const(PWSTR) UserName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_job_entrya
struct FAX_JOB_ENTRYA
{
    uint        SizeOfStruct;
    uint        JobId;
    const(PSTR) UserName;
    uint        JobType;
    uint        QueueStatus;
    uint        Status;
    uint        Size;
    uint        PageCount;
    const(PSTR) RecipientNumber;
    const(PSTR) RecipientName;
    const(PSTR) Tsid;
    const(PSTR) SenderName;
    const(PSTR) SenderCompany;
    const(PSTR) SenderDept;
    const(PSTR) BillingCode;
    uint        ScheduleAction;
    SYSTEMTIME  ScheduleTime;
    uint        DeliveryReportType;
    const(PSTR) DeliveryReportAddress;
    const(PSTR) DocumentName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_job_entryw
struct FAX_JOB_ENTRYW
{
    uint         SizeOfStruct;
    uint         JobId;
    const(PWSTR) UserName;
    uint         JobType;
    uint         QueueStatus;
    uint         Status;
    uint         Size;
    uint         PageCount;
    const(PWSTR) RecipientNumber;
    const(PWSTR) RecipientName;
    const(PWSTR) Tsid;
    const(PWSTR) SenderName;
    const(PWSTR) SenderCompany;
    const(PWSTR) SenderDept;
    const(PWSTR) BillingCode;
    uint         ScheduleAction;
    SYSTEMTIME   ScheduleTime;
    uint         DeliveryReportType;
    const(PWSTR) DeliveryReportAddress;
    const(PWSTR) DocumentName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_port_infoa
struct FAX_PORT_INFOA
{
    uint        SizeOfStruct;
    uint        DeviceId;
    uint        State;
    uint        Flags;
    uint        Rings;
    uint        Priority;
    const(PSTR) DeviceName;
    const(PSTR) Tsid;
    const(PSTR) Csid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_port_infow
struct FAX_PORT_INFOW
{
    uint         SizeOfStruct;
    uint         DeviceId;
    uint         State;
    uint         Flags;
    uint         Rings;
    uint         Priority;
    const(PWSTR) DeviceName;
    const(PWSTR) Tsid;
    const(PWSTR) Csid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_routing_methoda
struct FAX_ROUTING_METHODA
{
    uint        SizeOfStruct;
    uint        DeviceId;
    BOOL        Enabled;
    const(PSTR) DeviceName;
    const(PSTR) Guid;
    const(PSTR) FriendlyName;
    const(PSTR) FunctionName;
    const(PSTR) ExtensionImageName;
    const(PSTR) ExtensionFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_routing_methodw
struct FAX_ROUTING_METHODW
{
    uint         SizeOfStruct;
    uint         DeviceId;
    BOOL         Enabled;
    const(PWSTR) DeviceName;
    const(PWSTR) Guid;
    const(PWSTR) FriendlyName;
    const(PWSTR) FunctionName;
    const(PWSTR) ExtensionImageName;
    const(PWSTR) ExtensionFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_global_routing_infoa
struct FAX_GLOBAL_ROUTING_INFOA
{
    uint        SizeOfStruct;
    uint        Priority;
    const(PSTR) Guid;
    const(PSTR) FriendlyName;
    const(PSTR) FunctionName;
    const(PSTR) ExtensionImageName;
    const(PSTR) ExtensionFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_global_routing_infow
struct FAX_GLOBAL_ROUTING_INFOW
{
    uint         SizeOfStruct;
    uint         Priority;
    const(PWSTR) Guid;
    const(PWSTR) FriendlyName;
    const(PWSTR) FunctionName;
    const(PWSTR) ExtensionImageName;
    const(PWSTR) ExtensionFriendlyName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_coverpage_infoa
struct FAX_COVERPAGE_INFOA
{
    uint        SizeOfStruct;
    const(PSTR) CoverPageName;
    BOOL        UseServerCoverPage;
    const(PSTR) RecName;
    const(PSTR) RecFaxNumber;
    const(PSTR) RecCompany;
    const(PSTR) RecStreetAddress;
    const(PSTR) RecCity;
    const(PSTR) RecState;
    const(PSTR) RecZip;
    const(PSTR) RecCountry;
    const(PSTR) RecTitle;
    const(PSTR) RecDepartment;
    const(PSTR) RecOfficeLocation;
    const(PSTR) RecHomePhone;
    const(PSTR) RecOfficePhone;
    const(PSTR) SdrName;
    const(PSTR) SdrFaxNumber;
    const(PSTR) SdrCompany;
    const(PSTR) SdrAddress;
    const(PSTR) SdrTitle;
    const(PSTR) SdrDepartment;
    const(PSTR) SdrOfficeLocation;
    const(PSTR) SdrHomePhone;
    const(PSTR) SdrOfficePhone;
    const(PSTR) Note;
    const(PSTR) Subject;
    SYSTEMTIME  TimeSent;
    uint        PageCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_coverpage_infow
struct FAX_COVERPAGE_INFOW
{
    uint         SizeOfStruct;
    const(PWSTR) CoverPageName;
    BOOL         UseServerCoverPage;
    const(PWSTR) RecName;
    const(PWSTR) RecFaxNumber;
    const(PWSTR) RecCompany;
    const(PWSTR) RecStreetAddress;
    const(PWSTR) RecCity;
    const(PWSTR) RecState;
    const(PWSTR) RecZip;
    const(PWSTR) RecCountry;
    const(PWSTR) RecTitle;
    const(PWSTR) RecDepartment;
    const(PWSTR) RecOfficeLocation;
    const(PWSTR) RecHomePhone;
    const(PWSTR) RecOfficePhone;
    const(PWSTR) SdrName;
    const(PWSTR) SdrFaxNumber;
    const(PWSTR) SdrCompany;
    const(PWSTR) SdrAddress;
    const(PWSTR) SdrTitle;
    const(PWSTR) SdrDepartment;
    const(PWSTR) SdrOfficeLocation;
    const(PWSTR) SdrHomePhone;
    const(PWSTR) SdrOfficePhone;
    const(PWSTR) Note;
    const(PWSTR) Subject;
    SYSTEMTIME   TimeSent;
    uint         PageCount;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_job_parama
struct FAX_JOB_PARAMA
{
    uint        SizeOfStruct;
    const(PSTR) RecipientNumber;
    const(PSTR) RecipientName;
    const(PSTR) Tsid;
    const(PSTR) SenderName;
    const(PSTR) SenderCompany;
    const(PSTR) SenderDept;
    const(PSTR) BillingCode;
    uint        ScheduleAction;
    SYSTEMTIME  ScheduleTime;
    uint        DeliveryReportType;
    const(PSTR) DeliveryReportAddress;
    const(PSTR) DocumentName;
    uint        CallHandle;
    size_t[3]   Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_job_paramw
struct FAX_JOB_PARAMW
{
    uint         SizeOfStruct;
    const(PWSTR) RecipientNumber;
    const(PWSTR) RecipientName;
    const(PWSTR) Tsid;
    const(PWSTR) SenderName;
    const(PWSTR) SenderCompany;
    const(PWSTR) SenderDept;
    const(PWSTR) BillingCode;
    uint         ScheduleAction;
    SYSTEMTIME   ScheduleTime;
    uint         DeliveryReportType;
    const(PWSTR) DeliveryReportAddress;
    const(PWSTR) DocumentName;
    uint         CallHandle;
    size_t[3]    Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_eventa
struct FAX_EVENTA
{
    uint     SizeOfStruct;
    FILETIME TimeStamp;
    uint     DeviceId;
    uint     EventId;
    uint     JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_eventw
struct FAX_EVENTW
{
    uint     SizeOfStruct;
    FILETIME TimeStamp;
    uint     DeviceId;
    uint     EventId;
    uint     JobId;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_print_infoa
struct FAX_PRINT_INFOA
{
    uint        SizeOfStruct;
    const(PSTR) DocName;
    const(PSTR) RecipientName;
    const(PSTR) RecipientNumber;
    const(PSTR) SenderName;
    const(PSTR) SenderCompany;
    const(PSTR) SenderDept;
    const(PSTR) SenderBillingCode;
    const(PSTR) Reserved;
    const(PSTR) DrEmailAddress;
    const(PSTR) OutputFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_print_infow
struct FAX_PRINT_INFOW
{
    uint         SizeOfStruct;
    const(PWSTR) DocName;
    const(PWSTR) RecipientName;
    const(PWSTR) RecipientNumber;
    const(PWSTR) SenderName;
    const(PWSTR) SenderCompany;
    const(PWSTR) SenderDept;
    const(PWSTR) SenderBillingCode;
    const(PWSTR) Reserved;
    const(PWSTR) DrEmailAddress;
    const(PWSTR) OutputFileName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_context_infoa
struct FAX_CONTEXT_INFOA
{
    uint     SizeOfStruct;
    HDC      hDC;
    CHAR[16] ServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winfax/ns-winfax-fax_context_infow
struct FAX_CONTEXT_INFOW
{
    uint      SizeOfStruct;
    HDC       hDC;
    wchar[16] ServerName;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxdev/ns-faxdev-fax_send
struct FAX_SEND
{
    uint    SizeOfStruct;
    PWSTR   FileName;
    PWSTR   CallerName;
    PWSTR   CallerNumber;
    PWSTR   ReceiverName;
    PWSTR   ReceiverNumber;
    BOOL    Branding;
    uint    CallHandle;
    uint[3] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxdev/ns-faxdev-fax_receive
struct FAX_RECEIVE
{
    uint    SizeOfStruct;
    PWSTR   FileName;
    PWSTR   ReceiverName;
    PWSTR   ReceiverNumber;
    uint[4] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxdev/ns-faxdev-fax_dev_status
struct FAX_DEV_STATUS
{
    uint    SizeOfStruct;
    uint    StatusId;
    uint    StringId;
    uint    PageCount;
    PWSTR   CSI;
    PWSTR   CallerId;
    PWSTR   RoutingInfo;
    uint    ErrorCode;
    uint[3] Reserved;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxroute/ns-faxroute-fax_route_callbackroutines
struct FAX_ROUTE_CALLBACKROUTINES
{
    uint                SizeOfStruct;
    PFAXROUTEADDFILE    FaxRouteAddFile;
    PFAXROUTEDELETEFILE FaxRouteDeleteFile;
    PFAXROUTEGETFILE    FaxRouteGetFile;
    PFAXROUTEENUMFILES  FaxRouteEnumFiles;
    PFAXROUTEMODIFYROUTINGDATA FaxRouteModifyRoutingData;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxroute/ns-faxroute-fax_route
struct FAX_ROUTE
{
    uint         SizeOfStruct;
    uint         JobId;
    ulong        ElapsedTime;
    ulong        ReceiveTime;
    uint         PageCount;
    const(PWSTR) Csid;
    const(PWSTR) Tsid;
    const(PWSTR) CallerId;
    const(PWSTR) RoutingInfo;
    const(PWSTR) ReceiverName;
    const(PWSTR) ReceiverNumber;
    const(PWSTR) DeviceName;
    uint         DeviceId;
    ubyte*       RoutingInfoData;
    uint         RoutingInfoDataSize;
}

struct STI_DEV_CAPS
{
    uint dwGeneric;
}

struct STI_DEVICE_INFORMATIONW
{
    uint         dwSize;
    uint         DeviceType;
    wchar[128]   szDeviceInternalName;
    STI_DEV_CAPS DeviceCapabilitiesA;
    uint         dwHardwareConfiguration;
    PWSTR        pszVendorDescription;
    PWSTR        pszDeviceDescription;
    PWSTR        pszPortName;
    PWSTR        pszPropProvider;
    PWSTR        pszLocalName;
}

struct STI_WIA_DEVICE_INFORMATIONW
{
    uint         dwSize;
    uint         DeviceType;
    wchar[128]   szDeviceInternalName;
    STI_DEV_CAPS DeviceCapabilitiesA;
    uint         dwHardwareConfiguration;
    PWSTR        pszVendorDescription;
    PWSTR        pszDeviceDescription;
    PWSTR        pszPortName;
    PWSTR        pszPropProvider;
    PWSTR        pszLocalName;
    PWSTR        pszUiDll;
    PWSTR        pszServer;
}

struct STI_DEVICE_STATUS
{
    uint dwSize;
    uint StatusMask;
    uint dwOnlineState;
    uint dwHardwareStatusCode;
    uint dwEventHandlingState;
    uint dwPollingInterval;
}

struct _ERROR_INFOW
{
    uint       dwSize;
    uint       dwGenericError;
    uint       dwVendorError;
    wchar[255] szExtendedErrorText;
}

struct STI_DIAG
{
    uint         dwSize;
    uint         dwBasicDiagCode;
    uint         dwVendorDiagCode;
    uint         dwStatusMask;
    _ERROR_INFOW sErrorInfo;
}

struct STISUBSCRIBE
{
    uint   dwSize;
    uint   dwFlags;
    uint   dwFilter;
    HWND   hWndNotify;
    HANDLE hEvent;
    uint   uiNotificationMessage;
}

struct STINOTIFY
{
    uint      dwSize;
    GUID      guidNotificationCode;
    ubyte[64] abNotificationData;
}

struct STI_USD_CAPS
{
    uint dwVersion;
    uint dwGenericCaps;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxConnectFaxServerA(const(PSTR) MachineName, HANDLE* FaxHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxConnectFaxServerW(const(PWSTR) MachineName, HANDLE* FaxHandle);

@DllImport("WINFAX.dll")
BOOL FaxClose(HANDLE FaxHandle);

@DllImport("WINFAX.dll")
BOOL FaxOpenPort(HANDLE FaxHandle, uint DeviceId, uint Flags, HANDLE* FaxPortHandle);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxCompleteJobParamsA(FAX_JOB_PARAMA** JobParams, FAX_COVERPAGE_INFOA** CoverpageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxCompleteJobParamsW(FAX_JOB_PARAMW** JobParams, FAX_COVERPAGE_INFOW** CoverpageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSendDocumentA(HANDLE FaxHandle, const(PSTR) FileName, FAX_JOB_PARAMA* JobParams, 
                      const(FAX_COVERPAGE_INFOA)* CoverpageInfo, uint* FaxJobId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSendDocumentW(HANDLE FaxHandle, const(PWSTR) FileName, FAX_JOB_PARAMW* JobParams, 
                      const(FAX_COVERPAGE_INFOW)* CoverpageInfo, uint* FaxJobId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSendDocumentForBroadcastA(HANDLE FaxHandle, const(PSTR) FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKA FaxRecipientCallback, void* Context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSendDocumentForBroadcastW(HANDLE FaxHandle, const(PWSTR) FileName, uint* FaxJobId, 
                                  PFAX_RECIPIENT_CALLBACKW FaxRecipientCallback, void* Context);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumJobsA(HANDLE FaxHandle, FAX_JOB_ENTRYA** JobEntry, uint* JobsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumJobsW(HANDLE FaxHandle, FAX_JOB_ENTRYW** JobEntry, uint* JobsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetJobA(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYA** JobEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetJobW(HANDLE FaxHandle, uint JobId, FAX_JOB_ENTRYW** JobEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetJobA(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYA)* JobEntry);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetJobW(HANDLE FaxHandle, uint JobId, uint Command, const(FAX_JOB_ENTRYW)* JobEntry);

@DllImport("WINFAX.dll")
BOOL FaxGetPageData(HANDLE FaxHandle, uint JobId, ubyte** Buffer, uint* BufferSize, uint* ImageWidth, 
                    uint* ImageHeight);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetDeviceStatusA(HANDLE FaxPortHandle, FAX_DEVICE_STATUSA** DeviceStatus);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetDeviceStatusW(HANDLE FaxPortHandle, FAX_DEVICE_STATUSW** DeviceStatus);

@DllImport("WINFAX.dll")
BOOL FaxAbort(HANDLE FaxHandle, uint JobId);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetConfigurationA(HANDLE FaxHandle, FAX_CONFIGURATIONA** FaxConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetConfigurationW(HANDLE FaxHandle, FAX_CONFIGURATIONW** FaxConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetConfigurationA(HANDLE FaxHandle, const(FAX_CONFIGURATIONA)* FaxConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetConfigurationW(HANDLE FaxHandle, const(FAX_CONFIGURATIONW)* FaxConfig);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetLoggingCategoriesA(HANDLE FaxHandle, FAX_LOG_CATEGORYA** Categories, uint* NumberCategories);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetLoggingCategoriesW(HANDLE FaxHandle, FAX_LOG_CATEGORYW** Categories, uint* NumberCategories);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetLoggingCategoriesA(HANDLE FaxHandle, const(FAX_LOG_CATEGORYA)* Categories, uint NumberCategories);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetLoggingCategoriesW(HANDLE FaxHandle, const(FAX_LOG_CATEGORYW)* Categories, uint NumberCategories);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumPortsA(HANDLE FaxHandle, FAX_PORT_INFOA** PortInfo, uint* PortsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumPortsW(HANDLE FaxHandle, FAX_PORT_INFOW** PortInfo, uint* PortsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetPortA(HANDLE FaxPortHandle, FAX_PORT_INFOA** PortInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetPortW(HANDLE FaxPortHandle, FAX_PORT_INFOW** PortInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetPortA(HANDLE FaxPortHandle, const(FAX_PORT_INFOA)* PortInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetPortW(HANDLE FaxPortHandle, const(FAX_PORT_INFOW)* PortInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumRoutingMethodsA(HANDLE FaxPortHandle, FAX_ROUTING_METHODA** RoutingMethod, uint* MethodsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumRoutingMethodsW(HANDLE FaxPortHandle, FAX_ROUTING_METHODW** RoutingMethod, uint* MethodsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnableRoutingMethodA(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, BOOL Enabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnableRoutingMethodW(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, BOOL Enabled);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumGlobalRoutingInfoA(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOA** RoutingInfo, uint* MethodsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxEnumGlobalRoutingInfoW(HANDLE FaxHandle, FAX_GLOBAL_ROUTING_INFOW** RoutingInfo, uint* MethodsReturned);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetGlobalRoutingInfoA(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOA)* RoutingInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetGlobalRoutingInfoW(HANDLE FaxHandle, const(FAX_GLOBAL_ROUTING_INFOW)* RoutingInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetRoutingInfoA(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxGetRoutingInfoW(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, ubyte** RoutingInfoBuffer, 
                        uint* RoutingInfoBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetRoutingInfoA(HANDLE FaxPortHandle, const(PSTR) RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxSetRoutingInfoW(HANDLE FaxPortHandle, const(PWSTR) RoutingGuid, const(ubyte)* RoutingInfoBuffer, 
                        uint RoutingInfoBufferSize);

@DllImport("WINFAX.dll")
BOOL FaxInitializeEventQueue(HANDLE FaxHandle, HANDLE CompletionPort, size_t CompletionKey, HWND hWnd, 
                             uint MessageStart);

@DllImport("WINFAX.dll")
void FaxFreeBuffer(void* Buffer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxStartPrintJobA(const(PSTR) PrinterName, const(FAX_PRINT_INFOA)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOA* FaxContextInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxStartPrintJobW(const(PWSTR) PrinterName, const(FAX_PRINT_INFOW)* PrintInfo, uint* FaxJobId, 
                       FAX_CONTEXT_INFOW* FaxContextInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxPrintCoverPageA(const(FAX_CONTEXT_INFOA)* FaxContextInfo, const(FAX_COVERPAGE_INFOA)* CoverPageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxPrintCoverPageW(const(FAX_CONTEXT_INFOW)* FaxContextInfo, const(FAX_COVERPAGE_INFOW)* CoverPageInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxRegisterServiceProviderW(const(PWSTR) DeviceProvider, const(PWSTR) FriendlyName, const(PWSTR) ImageName, 
                                 const(PWSTR) TspName);

@DllImport("WINFAX.dll")
BOOL FaxUnregisterServiceProviderW(const(PWSTR) DeviceProvider);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("WINFAX.dll")
BOOL FaxRegisterRoutingExtensionW(HANDLE FaxHandle, const(PWSTR) ExtensionName, const(PWSTR) FriendlyName, 
                                  const(PWSTR) ImageName, PFAX_ROUTING_INSTALLATION_CALLBACKW CallBack, 
                                  void* Context);

@DllImport("WINFAX.dll")
BOOL FaxAccessCheck(HANDLE FaxHandle, uint AccessMask);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fxsutility.dll")
BOOL CanSendToFaxRecipient();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("fxsutility.dll")
uint SendToFaxRecipient(SendToMode sndMode, const(PWSTR) lpFileName);

@DllImport("STI.dll")
HRESULT StiCreateInstanceW(HINSTANCE hinst, uint dwVer, IStillImageW* ppSti, IUnknown punkOuter);


// Interfaces

@GUID("cda8acb0-8cf5-4f6c-9ba2-5931d40c8cae")
struct FaxServer;

@GUID("eb8fe768-875a-4f5f-82c5-03f23aac1bd7")
struct FaxDeviceProviders;

@GUID("5589e28e-23cb-4919-8808-e6101846e80d")
struct FaxDevices;

@GUID("e80248ed-ad65-4218-8108-991924d4e7ed")
struct FaxInboundRouting;

@GUID("c35211d7-5776-48cb-af44-c31be3b2cfe5")
struct FaxFolders;

@GUID("1bf9eea6-ece0-4785-a18b-de56e9eef96a")
struct FaxLoggingOptions;

@GUID("cfef5d0e-e84d-462e-aabb-87d31eb04fef")
struct FaxActivity;

@GUID("c81b385e-b869-4afd-86c0-616498ed9be2")
struct FaxOutboundRouting;

@GUID("6982487b-227b-4c96-a61c-248348b05ab6")
struct FaxReceiptOptions;

@GUID("10c4ddde-abf0-43df-964f-7f3ac21a4c7b")
struct FaxSecurity;

@GUID("0f3f9f91-c838-415e-a4f3-3e828ca445e0")
struct FaxDocument;

@GUID("265d84d0-1850-4360-b7c8-758bbb5f0b96")
struct FaxSender;

@GUID("ea9bdf53-10a9-4d4f-a067-63c8f84f01b0")
struct FaxRecipients;

@GUID("8426c56a-35a1-4c6f-af93-fc952422e2c2")
struct FaxIncomingArchive;

@GUID("69131717-f3f1-40e3-809d-a6cbf7bd85e5")
struct FaxIncomingQueue;

@GUID("43c28403-e04f-474d-990c-b94669148f59")
struct FaxOutgoingArchive;

@GUID("7421169e-8c43-4b0d-bb16-645c8fa40357")
struct FaxOutgoingQueue;

@GUID("6088e1d8-3fc8-45c2-87b1-909a29607ea9")
struct FaxIncomingMessageIterator;

@GUID("1932fcf7-9d43-4d5a-89ff-03861b321736")
struct FaxIncomingMessage;

@GUID("92bf2a6c-37be-43fa-a37d-cb0e5f753b35")
struct FaxOutgoingJobs;

@GUID("71bb429c-0ef9-4915-bec5-a5d897a3e924")
struct FaxOutgoingJob;

@GUID("8a3224d0-d30b-49de-9813-cb385790fbbb")
struct FaxOutgoingMessageIterator;

@GUID("91b4a378-4ad8-4aef-a4dc-97d96e939a3a")
struct FaxOutgoingMessage;

@GUID("a1bb8a43-8866-4fb7-a15d-6266c875a5cc")
struct FaxIncomingJobs;

@GUID("c47311ec-ae32-41b8-ae4b-3eae0629d0c9")
struct FaxIncomingJob;

@GUID("17cf1aa3-f5eb-484a-9c9a-4440a5baabfc")
struct FaxDeviceProvider;

@GUID("59e3a5b2-d676-484b-a6de-720bfa89b5af")
struct FaxDevice;

@GUID("f0a0294e-3bbd-48b8-8f13-8c591a55bdbc")
struct FaxActivityLogging;

@GUID("a6850930-a0f6-4a6f-95b7-db2ebf3d02e3")
struct FaxEventLogging;

@GUID("ccbea1a5-e2b4-4b57-9421-b04b6289464b")
struct FaxOutboundRoutingGroups;

@GUID("0213f3e0-6791-4d77-a271-04d2357c50d6")
struct FaxOutboundRoutingGroup;

@GUID("cdc539ea-7277-460e-8de0-48a0a5760d1f")
struct FaxDeviceIds;

@GUID("d385beca-e624-4473-bfaa-9f4000831f54")
struct FaxOutboundRoutingRules;

@GUID("6549eebf-08d1-475a-828b-3bf105952fa0")
struct FaxOutboundRoutingRule;

@GUID("189a48ed-623c-4c0d-80f2-d66c7b9efec2")
struct FaxInboundRoutingExtensions;

@GUID("1d7dfb51-7207-4436-a0d9-24e32ee56988")
struct FaxInboundRoutingExtension;

@GUID("25fcb76a-b750-4b82-9266-fbbbae8922ba")
struct FaxInboundRoutingMethods;

@GUID("4b9fd75c-0194-4b72-9ce5-02a8205ac7d4")
struct FaxInboundRoutingMethod;

@GUID("7bf222f4-be8d-442f-841d-6132742423bb")
struct FaxJobStatus;

@GUID("60bf3301-7df8-4bd8-9148-7b5801f9efdf")
struct FaxRecipient;

@GUID("5857326f-e7b3-41a7-9c19-a91b463e2d56")
struct FaxConfiguration;

@GUID("fbc23c4b-79e0-4291-bc56-c12e253bbf3a")
struct FaxAccountSet;

@GUID("da1f94aa-ee2c-47c0-8f4f-2a217075b76e")
struct FaxAccounts;

@GUID("a7e0647f-4524-4464-a56d-b9fe666f715e")
struct FaxAccount;

@GUID("85398f49-c034-4a3f-821c-db7d685e8129")
struct FaxAccountFolders;

@GUID("9bcf6094-b4da-45f4-b8d6-ddeb2186652c")
struct FaxAccountIncomingQueue;

@GUID("feeceefb-c149-48ba-bab8-b791e101f62f")
struct FaxAccountOutgoingQueue;

@GUID("14b33db5-4c40-4ecf-9ef8-a360cbe809ed")
struct FaxAccountIncomingArchive;

@GUID("851e7af5-433a-4739-a2df-ad245c2cb98e")
struct FaxAccountOutgoingArchive;

@GUID("735c1248-ec89-4c30-a127-656e92e3c4ea")
struct FaxSecurity2;

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxjobstatus
@GUID("8b86f485-fd7f-4824-886b-40c5caa617cc")
interface IFaxJobStatus : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_status
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_pages
    HRESULT get_Pages(int* plPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_size
    HRESULT get_Size(int* plSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_currentpage
    HRESULT get_CurrentPage(int* plCurrentPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_deviceid
    HRESULT get_DeviceId(int* plDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_extendedstatuscode
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_extendedstatus
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_availableoperations
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_jobtype
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_scheduledtime
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_transmissionstart
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_transmissionend
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_callerid
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxjobstatus-get_routinginformation
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxserver
@GUID("475b6469-90a5-4878-a577-17a86e8e3462")
interface IFaxServer : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-connect
    HRESULT Connect(BSTR bstrServerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_servername
    HRESULT get_ServerName(BSTR* pbstrServerName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-getdeviceproviders
    HRESULT GetDeviceProviders(IFaxDeviceProviders* ppFaxDeviceProviders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-getdevices
    HRESULT GetDevices(IFaxDevices* ppFaxDevices);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_inboundrouting
    HRESULT get_InboundRouting(IFaxInboundRouting* ppFaxInboundRouting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_folders
    HRESULT get_Folders(IFaxFolders* pFaxFolders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_loggingoptions
    HRESULT get_LoggingOptions(IFaxLoggingOptions* ppFaxLoggingOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_majorversion
    HRESULT get_MajorVersion(int* plMajorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_minorversion
    HRESULT get_MinorVersion(int* plMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_majorbuild
    HRESULT get_MajorBuild(int* plMajorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_minorbuild
    HRESULT get_MinorBuild(int* plMinorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_debug
    HRESULT get_Debug(VARIANT_BOOL* pbDebug);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_activity
    HRESULT get_Activity(IFaxActivity* ppFaxActivity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_outboundrouting
    HRESULT get_OutboundRouting(IFaxOutboundRouting* ppFaxOutboundRouting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_receiptoptions
    HRESULT get_ReceiptOptions(IFaxReceiptOptions* ppFaxReceiptOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_security
    HRESULT get_Security(IFaxSecurity* ppFaxSecurity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-disconnect
    HRESULT Disconnect();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-getextensionproperty
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-setextensionproperty
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-listentoserverevents
    HRESULT ListenToServerEvents(FAX_SERVER_EVENTS_TYPE_ENUM EventTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-registerdeviceprovider
    HRESULT RegisterDeviceProvider(BSTR bstrGUID, BSTR bstrFriendlyName, BSTR bstrImageName, BSTR TspName, 
                                   int lFSPIVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-unregisterdeviceprovider
    HRESULT UnregisterDeviceProvider(BSTR bstrUniqueName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-registerinboundroutingextension
    HRESULT RegisterInboundRoutingExtension(BSTR bstrExtensionName, BSTR bstrFriendlyName, BSTR bstrImageName, 
                                            VARIANT vMethods);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-unregisterinboundroutingextension
    HRESULT UnregisterInboundRoutingExtension(BSTR bstrExtensionUniqueName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_registeredevents
    HRESULT get_RegisteredEvents(FAX_SERVER_EVENTS_TYPE_ENUM* pEventTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver-get_apiversion
    HRESULT get_APIVersion(FAX_SERVER_APIVERSION_ENUM* pAPIVersion);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdeviceproviders
@GUID("9fb76f62-4c7e-43a5-b6fd-502893f7e13e")
interface IFaxDeviceProviders : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceproviders-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceproviders-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxDeviceProvider* pFaxDeviceProvider);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceproviders-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdevices
@GUID("9e46783e-f34f-482e-a360-0416becbbd96")
interface IFaxDevices : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevices-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevices-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxDevice* pFaxDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevices-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevices-get_itembyid
    HRESULT get_ItemById(int lId, IFaxDevice* ppFaxDevice);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxinboundrouting
@GUID("8148c20f-9d52-45b1-bf96-38fc12713527")
interface IFaxInboundRouting : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundrouting-getextensions
    HRESULT GetExtensions(IFaxInboundRoutingExtensions* pFaxInboundRoutingExtensions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundrouting-getmethods
    HRESULT GetMethods(IFaxInboundRoutingMethods* pFaxInboundRoutingMethods);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxfolders
@GUID("dce3b2a8-a7ab-42bc-9d0a-3149457261a0")
interface IFaxFolders : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxfolders-get_outgoingqueue
    HRESULT get_OutgoingQueue(IFaxOutgoingQueue* pFaxOutgoingQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxfolders-get_incomingqueue
    HRESULT get_IncomingQueue(IFaxIncomingQueue* pFaxIncomingQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxfolders-get_incomingarchive
    HRESULT get_IncomingArchive(IFaxIncomingArchive* pFaxIncomingArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxfolders-get_outgoingarchive
    HRESULT get_OutgoingArchive(IFaxOutgoingArchive* pFaxOutgoingArchive);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxloggingoptions
@GUID("34e64fb9-6b31-4d32-8b27-d286c0c33606")
interface IFaxLoggingOptions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxloggingoptions-get_eventlogging
    HRESULT get_EventLogging(IFaxEventLogging* pFaxEventLogging);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxloggingoptions-get_activitylogging
    HRESULT get_ActivityLogging(IFaxActivityLogging* pFaxActivityLogging);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxactivity
@GUID("4b106f97-3df5-40f2-bc3c-44cb8115ebdf")
interface IFaxActivity : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivity-get_incomingmessages
    HRESULT get_IncomingMessages(int* plIncomingMessages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivity-get_routingmessages
    HRESULT get_RoutingMessages(int* plRoutingMessages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivity-get_outgoingmessages
    HRESULT get_OutgoingMessages(int* plOutgoingMessages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivity-get_queuedmessages
    HRESULT get_QueuedMessages(int* plQueuedMessages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivity-refresh
    HRESULT Refresh();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutboundrouting
@GUID("25dc05a4-9909-41bd-a95b-7e5d1dec1d43")
interface IFaxOutboundRouting : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundrouting-getgroups
    HRESULT GetGroups(IFaxOutboundRoutingGroups* pFaxOutboundRoutingGroups);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundrouting-getrules
    HRESULT GetRules(IFaxOutboundRoutingRules* pFaxOutboundRoutingRules);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxreceiptoptions
@GUID("378efaeb-5fcb-4afb-b2ee-e16e80614487")
interface IFaxReceiptOptions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_authenticationtype
    HRESULT get_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_authenticationtype
    HRESULT put_AuthenticationType(FAX_SMTP_AUTHENTICATION_TYPE_ENUM Type);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_smtpserver
    HRESULT get_SMTPServer(BSTR* pbstrSMTPServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_smtpserver
    HRESULT put_SMTPServer(BSTR bstrSMTPServer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_smtpport
    HRESULT get_SMTPPort(int* plSMTPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_smtpport
    HRESULT put_SMTPPort(int lSMTPPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_smtpsender
    HRESULT get_SMTPSender(BSTR* pbstrSMTPSender);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_smtpsender
    HRESULT put_SMTPSender(BSTR bstrSMTPSender);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_smtpuser
    HRESULT get_SMTPUser(BSTR* pbstrSMTPUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_smtpuser
    HRESULT put_SMTPUser(BSTR bstrSMTPUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_allowedreceipts
    HRESULT get_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM* pAllowedReceipts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_allowedreceipts
    HRESULT put_AllowedReceipts(FAX_RECEIPT_TYPE_ENUM AllowedReceipts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_smtppassword
    HRESULT get_SMTPPassword(BSTR* pbstrSMTPPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_smtppassword
    HRESULT put_SMTPPassword(BSTR bstrSMTPPassword);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-get_useforinboundrouting
    HRESULT get_UseForInboundRouting(VARIANT_BOOL* pbUseForInboundRouting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxreceiptoptions-put_useforinboundrouting
    HRESULT put_UseForInboundRouting(VARIANT_BOOL bUseForInboundRouting);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxsecurity
@GUID("77b508c1-09c0-47a2-91eb-fce7fdf2690e")
interface IFaxSecurity : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-get_descriptor
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-put_descriptor
    HRESULT put_Descriptor(VARIANT vDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-get_grantedrights
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM* pGrantedRights);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-get_informationtype
    HRESULT get_InformationType(int* plInformationType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity-put_informationtype
    HRESULT put_InformationType(int lInformationType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdocument
@GUID("b207a246-09e3-4a4e-a7dc-fea31d29458f")
interface IFaxDocument : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_body
    HRESULT get_Body(BSTR* pbstrBody);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_body
    HRESULT put_Body(BSTR bstrBody);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_sender
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_recipients
    HRESULT get_Recipients(IFaxRecipients* ppFaxRecipients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_coverpage
    HRESULT get_CoverPage(BSTR* pbstrCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_coverpage
    HRESULT put_CoverPage(BSTR bstrCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_subject
    HRESULT get_Subject(BSTR* pbstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_subject
    HRESULT put_Subject(BSTR bstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_note
    HRESULT get_Note(BSTR* pbstrNote);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_note
    HRESULT put_Note(BSTR bstrNote);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_scheduletime
    HRESULT get_ScheduleTime(double* pdateScheduleTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_scheduletime
    HRESULT put_ScheduleTime(double dateScheduleTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_receiptaddress
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_receiptaddress
    HRESULT put_ReceiptAddress(BSTR bstrReceiptAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_documentname
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_documentname
    HRESULT put_DocumentName(BSTR bstrDocumentName);
    HRESULT get_CallHandle(int* plCallHandle);
    HRESULT put_CallHandle(int lCallHandle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_coverpagetype
    HRESULT get_CoverPageType(FAX_COVERPAGE_TYPE_ENUM* pCoverPageType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_coverpagetype
    HRESULT put_CoverPageType(FAX_COVERPAGE_TYPE_ENUM CoverPageType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_scheduletype
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_scheduletype
    HRESULT put_ScheduleType(FAX_SCHEDULE_TYPE_ENUM ScheduleType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_receipttype
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_receipttype
    HRESULT put_ReceiptType(FAX_RECEIPT_TYPE_ENUM ReceiptType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_groupbroadcastreceipts
    HRESULT get_GroupBroadcastReceipts(VARIANT_BOOL* pbUseGrouping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_groupbroadcastreceipts
    HRESULT put_GroupBroadcastReceipts(VARIANT_BOOL bUseGrouping);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_priority
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_priority
    HRESULT put_Priority(FAX_PRIORITY_TYPE_ENUM Priority);
    HRESULT get_TapiConnection(IDispatch* ppTapiConnection);
    HRESULT putref_TapiConnection(IDispatch pTapiConnection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-submit
    HRESULT Submit(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-connectedsubmit
    HRESULT ConnectedSubmit(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-get_attachfaxtoreceipt
    HRESULT get_AttachFaxToReceipt(VARIANT_BOOL* pbAttachFax);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument-put_attachfaxtoreceipt
    HRESULT put_AttachFaxToReceipt(VARIANT_BOOL bAttachFax);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxsender
@GUID("0d879d7d-f57a-4cc6-a6f9-3ee5d527b46a")
interface IFaxSender : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_billingcode
    HRESULT get_BillingCode(BSTR* pbstrBillingCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_billingcode
    HRESULT put_BillingCode(BSTR bstrBillingCode);
    HRESULT get_City(BSTR* pbstrCity);
    HRESULT put_City(BSTR bstrCity);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_company
    HRESULT get_Company(BSTR* pbstrCompany);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_company
    HRESULT put_Company(BSTR bstrCompany);
    HRESULT get_Country(BSTR* pbstrCountry);
    HRESULT put_Country(BSTR bstrCountry);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_department
    HRESULT get_Department(BSTR* pbstrDepartment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_department
    HRESULT put_Department(BSTR bstrDepartment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_email
    HRESULT get_Email(BSTR* pbstrEmail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_email
    HRESULT put_Email(BSTR bstrEmail);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_faxnumber
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_faxnumber
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_homephone
    HRESULT get_HomePhone(BSTR* pbstrHomePhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_homephone
    HRESULT put_HomePhone(BSTR bstrHomePhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_name
    HRESULT put_Name(BSTR bstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_tsid
    HRESULT put_TSID(BSTR bstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_officephone
    HRESULT get_OfficePhone(BSTR* pbstrOfficePhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_officephone
    HRESULT put_OfficePhone(BSTR bstrOfficePhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_officelocation
    HRESULT get_OfficeLocation(BSTR* pbstrOfficeLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_officelocation
    HRESULT put_OfficeLocation(BSTR bstrOfficeLocation);
    HRESULT get_State(BSTR* pbstrState);
    HRESULT put_State(BSTR bstrState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_streetaddress
    HRESULT get_StreetAddress(BSTR* pbstrStreetAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_streetaddress
    HRESULT put_StreetAddress(BSTR bstrStreetAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-get_title
    HRESULT get_Title(BSTR* pbstrTitle);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-put_title
    HRESULT put_Title(BSTR bstrTitle);
    HRESULT get_ZipCode(BSTR* pbstrZipCode);
    HRESULT put_ZipCode(BSTR bstrZipCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-loaddefaultsender
    HRESULT LoadDefaultSender();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsender-savedefaultsender
    HRESULT SaveDefaultSender();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxrecipient
@GUID("9a3da3a0-538d-42b6-9444-aaa57d0ce2bc")
interface IFaxRecipient : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipient-get_faxnumber
    HRESULT get_FaxNumber(BSTR* pbstrFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipient-put_faxnumber
    HRESULT put_FaxNumber(BSTR bstrFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipient-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipient-put_name
    HRESULT put_Name(BSTR bstrName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxrecipients
@GUID("b9c9de5a-894e-4492-9fa3-08c627c11d5d")
interface IFaxRecipients : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipients-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipients-get_item
    HRESULT get_Item(int lIndex, IFaxRecipient* ppFaxRecipient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipients-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipients-add
    HRESULT Add(BSTR bstrFaxNumber, BSTR bstrRecipientName, IFaxRecipient* ppFaxRecipient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxrecipients-remove
    HRESULT Remove(int lIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingarchive
@GUID("76062cc7-f714-4fbd-aa06-ed6e4a4b70f3")
interface IFaxIncomingArchive : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_usearchive
    HRESULT get_UseArchive(VARIANT_BOOL* pbUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_usearchive
    HRESULT put_UseArchive(VARIANT_BOOL bUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_archivefolder
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_archivefolder
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_sizequotawarning
    HRESULT get_SizeQuotaWarning(VARIANT_BOOL* pbSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_sizequotawarning
    HRESULT put_SizeQuotaWarning(VARIANT_BOOL bSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_highquotawatermark
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_highquotawatermark
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_lowquotawatermark
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_lowquotawatermark
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_agelimit
    HRESULT get_AgeLimit(int* plAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-put_agelimit
    HRESULT put_AgeLimit(int lAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_sizelow
    HRESULT get_SizeLow(int* plSizeLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-get_sizehigh
    HRESULT get_SizeHigh(int* plSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-getmessages
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingarchive-getmessage
    HRESULT GetMessage(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingqueue
@GUID("902e64ef-8fd8-4b75-9725-6014df161545")
interface IFaxIncomingQueue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-get_blocked
    HRESULT get_Blocked(VARIANT_BOOL* pbBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-put_blocked
    HRESULT put_Blocked(VARIANT_BOOL bBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-getjobs
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingqueue-getjob
    HRESULT GetJob(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingarchive
@GUID("c9c28f40-8d80-4e53-810f-9a79919b49fd")
interface IFaxOutgoingArchive : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_usearchive
    HRESULT get_UseArchive(VARIANT_BOOL* pbUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_usearchive
    HRESULT put_UseArchive(VARIANT_BOOL bUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_archivefolder
    HRESULT get_ArchiveFolder(BSTR* pbstrArchiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_archivefolder
    HRESULT put_ArchiveFolder(BSTR bstrArchiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_sizequotawarning
    HRESULT get_SizeQuotaWarning(VARIANT_BOOL* pbSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_sizequotawarning
    HRESULT put_SizeQuotaWarning(VARIANT_BOOL bSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_highquotawatermark
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_highquotawatermark
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_lowquotawatermark
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_lowquotawatermark
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_agelimit
    HRESULT get_AgeLimit(int* plAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-put_agelimit
    HRESULT put_AgeLimit(int lAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_sizelow
    HRESULT get_SizeLow(int* plSizeLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-get_sizehigh
    HRESULT get_SizeHigh(int* plSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-getmessages
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingarchive-getmessage
    HRESULT GetMessage(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingqueue
@GUID("80b1df24-d9ac-4333-b373-487cedc80ce5")
interface IFaxOutgoingQueue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_blocked
    HRESULT get_Blocked(VARIANT_BOOL* pbBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_blocked
    HRESULT put_Blocked(VARIANT_BOOL bBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_paused
    HRESULT get_Paused(VARIANT_BOOL* pbPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_paused
    HRESULT put_Paused(VARIANT_BOOL bPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_allowpersonalcoverpages
    HRESULT get_AllowPersonalCoverPages(VARIANT_BOOL* pbAllowPersonalCoverPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_allowpersonalcoverpages
    HRESULT put_AllowPersonalCoverPages(VARIANT_BOOL bAllowPersonalCoverPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_usedevicetsid
    HRESULT get_UseDeviceTSID(VARIANT_BOOL* pbUseDeviceTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_usedevicetsid
    HRESULT put_UseDeviceTSID(VARIANT_BOOL bUseDeviceTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_retries
    HRESULT put_Retries(int lRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_retrydelay
    HRESULT get_RetryDelay(int* plRetryDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_retrydelay
    HRESULT put_RetryDelay(int lRetryDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_discountratestart
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_discountratestart
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_discountrateend
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_discountrateend
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_agelimit
    HRESULT get_AgeLimit(int* plAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_agelimit
    HRESULT put_AgeLimit(int lAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-get_branding
    HRESULT get_Branding(VARIANT_BOOL* pbBranding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-put_branding
    HRESULT put_Branding(VARIANT_BOOL bBranding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-getjobs
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingqueue-getjob
    HRESULT GetJob(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingmessageiterator
@GUID("fd73ecc4-6f06-4f52-82a8-f7ba06ae3108")
interface IFaxIncomingMessageIterator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-get_message
    HRESULT get_Message(IFaxIncomingMessage* pFaxIncomingMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-get_prefetchsize
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-put_prefetchsize
    HRESULT put_PrefetchSize(int lPrefetchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-get_ateof
    HRESULT get_AtEOF(VARIANT_BOOL* pbEOF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-movefirst
    HRESULT MoveFirst();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessageiterator-movenext
    HRESULT MoveNext();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingmessage
@GUID("7cab88fa-2ef9-4851-b2f3-1d148fed8447")
interface IFaxIncomingMessage : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_id
    HRESULT get_Id(BSTR* pbstrId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_pages
    HRESULT get_Pages(int* plPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_size
    HRESULT get_Size(int* plSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_devicename
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_transmissionstart
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_transmissionend
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_callerid
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-get_routinginformation
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-copytiff
    HRESULT CopyTiff(BSTR bstrTiffPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage-delete
    HRESULT Delete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingjobs
@GUID("2c56d8e6-8c2f-4573-944c-e505f8f5aeed")
interface IFaxOutgoingJobs : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjobs-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjobs-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxOutgoingJob* pFaxOutgoingJob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjobs-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingjob
@GUID("6356daad-6614-4583-bf7a-3ad67bbfc71c")
interface IFaxOutgoingJob : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_subject
    HRESULT get_Subject(BSTR* pbstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_documentname
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_pages
    HRESULT get_Pages(int* plPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_size
    HRESULT get_Size(int* plSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_submissionid
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_id
    HRESULT get_Id(BSTR* pbstrId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_originalscheduledtime
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_submissiontime
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_receipttype
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_priority
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_sender
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_recipient
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_currentpage
    HRESULT get_CurrentPage(int* plCurrentPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_deviceid
    HRESULT get_DeviceId(int* plDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_status
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_extendedstatuscode
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_extendedstatus
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_availableoperations
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_scheduledtime
    HRESULT get_ScheduledTime(double* pdateScheduledTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_transmissionstart
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_transmissionend
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-get_groupbroadcastreceipts
    HRESULT get_GroupBroadcastReceipts(VARIANT_BOOL* pbGroupBroadcastReceipts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-resume
    HRESULT Resume();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-restart
    HRESULT Restart();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-copytiff
    HRESULT CopyTiff(BSTR bstrTiffPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob-cancel
    HRESULT Cancel();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingmessageiterator
@GUID("f5ec5d4f-b840-432f-9980-112fe42a9b7a")
interface IFaxOutgoingMessageIterator : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-get_message
    HRESULT get_Message(IFaxOutgoingMessage* pFaxOutgoingMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-get_ateof
    HRESULT get_AtEOF(VARIANT_BOOL* pbEOF);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-get_prefetchsize
    HRESULT get_PrefetchSize(int* plPrefetchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-put_prefetchsize
    HRESULT put_PrefetchSize(int lPrefetchSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-movefirst
    HRESULT MoveFirst();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessageiterator-movenext
    HRESULT MoveNext();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingmessage
@GUID("f0ea35de-caa5-4a7c-82c7-2b60ba5f2be2")
interface IFaxOutgoingMessage : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_submissionid
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_id
    HRESULT get_Id(BSTR* pbstrId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_subject
    HRESULT get_Subject(BSTR* pbstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_documentname
    HRESULT get_DocumentName(BSTR* pbstrDocumentName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_pages
    HRESULT get_Pages(int* plPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_size
    HRESULT get_Size(int* plSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_originalscheduledtime
    HRESULT get_OriginalScheduledTime(double* pdateOriginalScheduledTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_submissiontime
    HRESULT get_SubmissionTime(double* pdateSubmissionTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_priority
    HRESULT get_Priority(FAX_PRIORITY_TYPE_ENUM* pPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_sender
    HRESULT get_Sender(IFaxSender* ppFaxSender);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_recipient
    HRESULT get_Recipient(IFaxRecipient* ppFaxRecipient);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_devicename
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_transmissionstart
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_transmissionend
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-copytiff
    HRESULT CopyTiff(BSTR bstrTiffPath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage-delete
    HRESULT Delete();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingjobs
@GUID("011f04e9-4fd6-4c23-9513-b6b66bb26be9")
interface IFaxIncomingJobs : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjobs-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjobs-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxIncomingJob* pFaxIncomingJob);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjobs-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingjob
@GUID("207529e6-654a-4916-9f88-4d232ee8a107")
interface IFaxIncomingJob : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_size
    HRESULT get_Size(int* plSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_id
    HRESULT get_Id(BSTR* pbstrId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_currentpage
    HRESULT get_CurrentPage(int* plCurrentPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_deviceid
    HRESULT get_DeviceId(int* plDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_status
    HRESULT get_Status(FAX_JOB_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_extendedstatuscode
    HRESULT get_ExtendedStatusCode(FAX_JOB_EXTENDED_STATUS_ENUM* pExtendedStatusCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_extendedstatus
    HRESULT get_ExtendedStatus(BSTR* pbstrExtendedStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_availableoperations
    HRESULT get_AvailableOperations(FAX_JOB_OPERATIONS_ENUM* pAvailableOperations);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_transmissionstart
    HRESULT get_TransmissionStart(double* pdateTransmissionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_transmissionend
    HRESULT get_TransmissionEnd(double* pdateTransmissionEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_callerid
    HRESULT get_CallerId(BSTR* pbstrCallerId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_routinginformation
    HRESULT get_RoutingInformation(BSTR* pbstrRoutingInformation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-get_jobtype
    HRESULT get_JobType(FAX_JOB_TYPE_ENUM* pJobType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-cancel
    HRESULT Cancel();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingjob-copytiff
    HRESULT CopyTiff(BSTR bstrTiffPath);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdeviceprovider
@GUID("290eac63-83ec-449c-8417-f148df8c682a")
interface IFaxDeviceProvider : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_imagename
    HRESULT get_ImageName(BSTR* pbstrImageName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_uniquename
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_tapiprovidername
    HRESULT get_TapiProviderName(BSTR* pbstrTapiProviderName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_majorversion
    HRESULT get_MajorVersion(int* plMajorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_minorversion
    HRESULT get_MinorVersion(int* plMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_majorbuild
    HRESULT get_MajorBuild(int* plMajorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_minorbuild
    HRESULT get_MinorBuild(int* plMinorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_debug
    HRESULT get_Debug(VARIANT_BOOL* pbDebug);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_status
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_initerrorcode
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceprovider-get_deviceids
    HRESULT get_DeviceIds(VARIANT* pvDeviceIds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdevice
@GUID("49306c59-b52e-4867-9df4-ca5841c956d0")
interface IFaxDevice : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_id
    HRESULT get_Id(int* plId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_devicename
    HRESULT get_DeviceName(BSTR* pbstrDeviceName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_provideruniquename
    HRESULT get_ProviderUniqueName(BSTR* pbstrProviderUniqueName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_poweredoff
    HRESULT get_PoweredOff(VARIANT_BOOL* pbPoweredOff);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_receivingnow
    HRESULT get_ReceivingNow(VARIANT_BOOL* pbReceivingNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_sendingnow
    HRESULT get_SendingNow(VARIANT_BOOL* pbSendingNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_usedroutingmethods
    HRESULT get_UsedRoutingMethods(VARIANT* pvUsedRoutingMethods);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_description
    HRESULT get_Description(BSTR* pbstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_description
    HRESULT put_Description(BSTR bstrDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_sendenabled
    HRESULT get_SendEnabled(VARIANT_BOOL* pbSendEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_sendenabled
    HRESULT put_SendEnabled(VARIANT_BOOL bSendEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_receivemode
    HRESULT get_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM* pReceiveMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_receivemode
    HRESULT put_ReceiveMode(FAX_DEVICE_RECEIVE_MODE_ENUM ReceiveMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_ringsbeforeanswer
    HRESULT get_RingsBeforeAnswer(int* plRingsBeforeAnswer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_ringsbeforeanswer
    HRESULT put_RingsBeforeAnswer(int lRingsBeforeAnswer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_csid
    HRESULT get_CSID(BSTR* pbstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_csid
    HRESULT put_CSID(BSTR bstrCSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_tsid
    HRESULT get_TSID(BSTR* pbstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-put_tsid
    HRESULT put_TSID(BSTR bstrTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-getextensionproperty
    HRESULT GetExtensionProperty(BSTR bstrGUID, VARIANT* pvProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-setextensionproperty
    HRESULT SetExtensionProperty(BSTR bstrGUID, VARIANT vProperty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-useroutingmethod
    HRESULT UseRoutingMethod(BSTR bstrMethodGUID, VARIANT_BOOL bUse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-get_ringingnow
    HRESULT get_RingingNow(VARIANT_BOOL* pbRingingNow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdevice-answercall
    HRESULT AnswerCall();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxactivitylogging
@GUID("1e29078b-5a69-497b-9592-49b7e7faddb5")
interface IFaxActivityLogging : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-get_logincoming
    HRESULT get_LogIncoming(VARIANT_BOOL* pbLogIncoming);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-put_logincoming
    HRESULT put_LogIncoming(VARIANT_BOOL bLogIncoming);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-get_logoutgoing
    HRESULT get_LogOutgoing(VARIANT_BOOL* pbLogOutgoing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-put_logoutgoing
    HRESULT put_LogOutgoing(VARIANT_BOOL bLogOutgoing);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-get_databasepath
    HRESULT get_DatabasePath(BSTR* pbstrDatabasePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-put_databasepath
    HRESULT put_DatabasePath(BSTR bstrDatabasePath);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxactivitylogging-save
    HRESULT Save();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxeventlogging
@GUID("0880d965-20e8-42e4-8e17-944f192caad4")
interface IFaxEventLogging : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-get_initeventslevel
    HRESULT get_InitEventsLevel(FAX_LOG_LEVEL_ENUM* pInitEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-put_initeventslevel
    HRESULT put_InitEventsLevel(FAX_LOG_LEVEL_ENUM InitEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-get_inboundeventslevel
    HRESULT get_InboundEventsLevel(FAX_LOG_LEVEL_ENUM* pInboundEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-put_inboundeventslevel
    HRESULT put_InboundEventsLevel(FAX_LOG_LEVEL_ENUM InboundEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-get_outboundeventslevel
    HRESULT get_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM* pOutboundEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-put_outboundeventslevel
    HRESULT put_OutboundEventsLevel(FAX_LOG_LEVEL_ENUM OutboundEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-get_generaleventslevel
    HRESULT get_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM* pGeneralEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-put_generaleventslevel
    HRESULT put_GeneralEventsLevel(FAX_LOG_LEVEL_ENUM GeneralEventLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxeventlogging-save
    HRESULT Save();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutboundroutinggroups
@GUID("235cbef7-c2de-4bfd-b8da-75097c82c87f")
interface IFaxOutboundRoutingGroups : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroups-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroups-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroups-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroups-add
    HRESULT Add(BSTR bstrName, IFaxOutboundRoutingGroup* pFaxOutboundRoutingGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroups-remove
    HRESULT Remove(VARIANT vIndex);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutboundroutinggroup
@GUID("ca6289a1-7e25-4f87-9a0b-93365734962c")
interface IFaxOutboundRoutingGroup : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroup-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroup-get_status
    HRESULT get_Status(FAX_GROUP_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutinggroup-get_deviceids
    HRESULT get_DeviceIds(IFaxDeviceIds* pFaxDeviceIds);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdeviceids
@GUID("2f0f813f-4ce9-443e-8ca1-738cfaeee149")
interface IFaxDeviceIds : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-get_item
    HRESULT get_Item(int lIndex, int* plDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-add
    HRESULT Add(int lDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-remove
    HRESULT Remove(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdeviceids-setorder
    HRESULT SetOrder(int lDeviceId, int lNewOrder);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutboundroutingrules
@GUID("dcefa1e7-ae7d-4ed6-8521-369edcca5120")
interface IFaxOutboundRoutingRules : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-get_item
    HRESULT get_Item(int lIndex, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-get_count
    HRESULT get_Count(int* plCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-itembycountryandarea
    HRESULT ItemByCountryAndArea(int lCountryCode, int lAreaCode, IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-removebycountryandarea
    HRESULT RemoveByCountryAndArea(int lCountryCode, int lAreaCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-remove
    HRESULT Remove(int lIndex);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrules-add
    HRESULT Add(int lCountryCode, int lAreaCode, VARIANT_BOOL bUseDevice, BSTR bstrGroupName, int lDeviceId, 
                IFaxOutboundRoutingRule* pFaxOutboundRoutingRule);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutboundroutingrule
@GUID("e1f795d5-07c2-469f-b027-acacc23219da")
interface IFaxOutboundRoutingRule : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_countrycode
    HRESULT get_CountryCode(int* plCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_areacode
    HRESULT get_AreaCode(int* plAreaCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_status
    HRESULT get_Status(FAX_RULE_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_usedevice
    HRESULT get_UseDevice(VARIANT_BOOL* pbUseDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-put_usedevice
    HRESULT put_UseDevice(VARIANT_BOOL bUseDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_deviceid
    HRESULT get_DeviceId(int* plDeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-put_deviceid
    HRESULT put_DeviceId(int DeviceId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-get_groupname
    HRESULT get_GroupName(BSTR* pbstrGroupName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-put_groupname
    HRESULT put_GroupName(BSTR bstrGroupName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutboundroutingrule-save
    HRESULT Save();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxinboundroutingextensions
@GUID("2f6c9673-7b26-42de-8eb0-915dcd2a4f4c")
interface IFaxInboundRoutingExtensions : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextensions-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextensions-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingExtension* pFaxInboundRoutingExtension);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextensions-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxinboundroutingextension
@GUID("885b5e08-c26c-4ef9-af83-51580a750be1")
interface IFaxInboundRoutingExtension : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_friendlyname
    HRESULT get_FriendlyName(BSTR* pbstrFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_imagename
    HRESULT get_ImageName(BSTR* pbstrImageName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_uniquename
    HRESULT get_UniqueName(BSTR* pbstrUniqueName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_majorversion
    HRESULT get_MajorVersion(int* plMajorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_minorversion
    HRESULT get_MinorVersion(int* plMinorVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_majorbuild
    HRESULT get_MajorBuild(int* plMajorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_minorbuild
    HRESULT get_MinorBuild(int* plMinorBuild);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_debug
    HRESULT get_Debug(VARIANT_BOOL* pbDebug);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_status
    HRESULT get_Status(FAX_PROVIDER_STATUS_ENUM* pStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_initerrorcode
    HRESULT get_InitErrorCode(int* plInitErrorCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingextension-get_methods
    HRESULT get_Methods(VARIANT* pvMethods);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxinboundroutingmethods
@GUID("783fca10-8908-4473-9d69-f67fbea0c6b9")
interface IFaxInboundRoutingMethods : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethods-get__newenum
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethods-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxInboundRoutingMethod* pFaxInboundRoutingMethod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethods-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.1.2600))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxinboundroutingmethod
@GUID("45700061-ad9d-4776-a8c4-64065492cf4b")
interface IFaxInboundRoutingMethod : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_name
    HRESULT get_Name(BSTR* pbstrName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_guid
    HRESULT get_GUID(BSTR* pbstrGUID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_functionname
    HRESULT get_FunctionName(BSTR* pbstrFunctionName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_extensionfriendlyname
    HRESULT get_ExtensionFriendlyName(BSTR* pbstrExtensionFriendlyName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_extensionimagename
    HRESULT get_ExtensionImageName(BSTR* pbstrExtensionImageName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-get_priority
    HRESULT get_Priority(int* plPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-put_priority
    HRESULT put_Priority(int lPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxinboundroutingmethod-save
    HRESULT Save();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxdocument2
@GUID("e1347661-f9ef-4d6d-b4a5-c0a068b65cff")
interface IFaxDocument2 : IFaxDocument
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument2-get_submissionid
    HRESULT get_SubmissionId(BSTR* pbstrSubmissionId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument2-get_bodies
    HRESULT get_Bodies(VARIANT* pvBodies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument2-put_bodies
    HRESULT put_Bodies(VARIANT vBodies);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument2-submit2
    HRESULT Submit2(BSTR bstrFaxServerName, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxdocument2-connectedsubmit2
    HRESULT ConnectedSubmit2(IFaxServer pFaxServer, VARIANT* pvFaxOutgoingJobIDs, int* plErrorBodyFile);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxconfiguration
@GUID("10f4d0f7-0994-4543-ab6e-506949128c40")
interface IFaxConfiguration : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_usearchive
    HRESULT get_UseArchive(VARIANT_BOOL* pbUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_usearchive
    HRESULT put_UseArchive(VARIANT_BOOL bUseArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_archivelocation
    HRESULT get_ArchiveLocation(BSTR* pbstrArchiveLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_archivelocation
    HRESULT put_ArchiveLocation(BSTR bstrArchiveLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_sizequotawarning
    HRESULT get_SizeQuotaWarning(VARIANT_BOOL* pbSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_sizequotawarning
    HRESULT put_SizeQuotaWarning(VARIANT_BOOL bSizeQuotaWarning);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_highquotawatermark
    HRESULT get_HighQuotaWaterMark(int* plHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_highquotawatermark
    HRESULT put_HighQuotaWaterMark(int lHighQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_lowquotawatermark
    HRESULT get_LowQuotaWaterMark(int* plLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_lowquotawatermark
    HRESULT put_LowQuotaWaterMark(int lLowQuotaWaterMark);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_archiveagelimit
    HRESULT get_ArchiveAgeLimit(int* plArchiveAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_archiveagelimit
    HRESULT put_ArchiveAgeLimit(int lArchiveAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_archivesizelow
    HRESULT get_ArchiveSizeLow(int* plSizeLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_archivesizehigh
    HRESULT get_ArchiveSizeHigh(int* plSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_outgoingqueueblocked
    HRESULT get_OutgoingQueueBlocked(VARIANT_BOOL* pbOutgoingBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_outgoingqueueblocked
    HRESULT put_OutgoingQueueBlocked(VARIANT_BOOL bOutgoingBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_outgoingqueuepaused
    HRESULT get_OutgoingQueuePaused(VARIANT_BOOL* pbOutgoingPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_outgoingqueuepaused
    HRESULT put_OutgoingQueuePaused(VARIANT_BOOL bOutgoingPaused);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_allowpersonalcoverpages
    HRESULT get_AllowPersonalCoverPages(VARIANT_BOOL* pbAllowPersonalCoverPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_allowpersonalcoverpages
    HRESULT put_AllowPersonalCoverPages(VARIANT_BOOL bAllowPersonalCoverPages);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_usedevicetsid
    HRESULT get_UseDeviceTSID(VARIANT_BOOL* pbUseDeviceTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_usedevicetsid
    HRESULT put_UseDeviceTSID(VARIANT_BOOL bUseDeviceTSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_retries
    HRESULT get_Retries(int* plRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_retries
    HRESULT put_Retries(int lRetries);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_retrydelay
    HRESULT get_RetryDelay(int* plRetryDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_retrydelay
    HRESULT put_RetryDelay(int lRetryDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_discountratestart
    HRESULT get_DiscountRateStart(double* pdateDiscountRateStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_discountratestart
    HRESULT put_DiscountRateStart(double dateDiscountRateStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_discountrateend
    HRESULT get_DiscountRateEnd(double* pdateDiscountRateEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_discountrateend
    HRESULT put_DiscountRateEnd(double dateDiscountRateEnd);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_outgoingqueueagelimit
    HRESULT get_OutgoingQueueAgeLimit(int* plOutgoingQueueAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_outgoingqueueagelimit
    HRESULT put_OutgoingQueueAgeLimit(int lOutgoingQueueAgeLimit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_branding
    HRESULT get_Branding(VARIANT_BOOL* pbBranding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_branding
    HRESULT put_Branding(VARIANT_BOOL bBranding);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_incomingqueueblocked
    HRESULT get_IncomingQueueBlocked(VARIANT_BOOL* pbIncomingBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_incomingqueueblocked
    HRESULT put_IncomingQueueBlocked(VARIANT_BOOL bIncomingBlocked);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_autocreateaccountonconnect
    HRESULT get_AutoCreateAccountOnConnect(VARIANT_BOOL* pbAutoCreateAccountOnConnect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_autocreateaccountonconnect
    HRESULT put_AutoCreateAccountOnConnect(VARIANT_BOOL bAutoCreateAccountOnConnect);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-get_incomingfaxesarepublic
    HRESULT get_IncomingFaxesArePublic(VARIANT_BOOL* pbIncomingFaxesArePublic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-put_incomingfaxesarepublic
    HRESULT put_IncomingFaxesArePublic(VARIANT_BOOL bIncomingFaxesArePublic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxconfiguration-save
    HRESULT Save();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxserver2
@GUID("571ced0f-5609-4f40-9176-547e3a72ca7c")
interface IFaxServer2 : IFaxServer
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver2-get_configuration
    HRESULT get_Configuration(IFaxConfiguration* ppFaxConfiguration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver2-get_currentaccount
    HRESULT get_CurrentAccount(IFaxAccount* ppCurrentAccount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver2-get_faxaccountset
    HRESULT get_FaxAccountSet(IFaxAccountSet* ppFaxAccountSet);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxserver2-get_security2
    HRESULT get_Security2(IFaxSecurity2* ppFaxSecurity2);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountset
@GUID("7428fbae-841e-47b8-86f4-2288946dca1b")
interface IFaxAccountSet : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountset-getaccounts
    HRESULT GetAccounts(IFaxAccounts* ppFaxAccounts);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountset-getaccount
    HRESULT GetAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountset-addaccount
    HRESULT AddAccount(BSTR bstrAccountName, IFaxAccount* pFaxAccount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountset-removeaccount
    HRESULT RemoveAccount(BSTR bstrAccountName);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccounts
@GUID("93ea8162-8be7-42d1-ae7b-ec74e2d989da")
interface IFaxAccounts : IDispatch
{
    HRESULT get__NewEnum(IUnknown* ppUnk);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccounts-get_item
    HRESULT get_Item(VARIANT vIndex, IFaxAccount* pFaxAccount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccounts-get_count
    HRESULT get_Count(int* plCount);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccount
@GUID("68535b33-5dc4-4086-be26-b76f9b711006")
interface IFaxAccount : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccount-get_accountname
    HRESULT get_AccountName(BSTR* pbstrAccountName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccount-get_folders
    HRESULT get_Folders(IFaxAccountFolders* ppFolders);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccount-listentoaccountevents
    HRESULT ListenToAccountEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM EventTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccount-get_registeredevents
    HRESULT get_RegisteredEvents(FAX_ACCOUNT_EVENTS_TYPE_ENUM* pRegisteredEvents);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingjob2
@GUID("418a8d96-59a0-4789-b176-edf3dc8fa8f7")
interface IFaxOutgoingJob2 : IFaxOutgoingJob
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob2-get_hascoverpage
    HRESULT get_HasCoverPage(VARIANT_BOOL* pbHasCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob2-get_receiptaddress
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingjob2-get_scheduletype
    HRESULT get_ScheduleType(FAX_SCHEDULE_TYPE_ENUM* pScheduleType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountfolders
@GUID("6463f89d-23d8-46a9-8f86-c47b77ca7926")
interface IFaxAccountFolders : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountfolders-get_outgoingqueue
    HRESULT get_OutgoingQueue(IFaxAccountOutgoingQueue* pFaxOutgoingQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountfolders-get_incomingqueue
    HRESULT get_IncomingQueue(IFaxAccountIncomingQueue* pFaxIncomingQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountfolders-get_incomingarchive
    HRESULT get_IncomingArchive(IFaxAccountIncomingArchive* pFaxIncomingArchive);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountfolders-get_outgoingarchive
    HRESULT get_OutgoingArchive(IFaxAccountOutgoingArchive* pFaxOutgoingArchive);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountincomingqueue
@GUID("dd142d92-0186-4a95-a090-cbc3eadba6b4")
interface IFaxAccountIncomingQueue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingqueue-getjobs
    HRESULT GetJobs(IFaxIncomingJobs* pFaxIncomingJobs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingqueue-getjob
    HRESULT GetJob(BSTR bstrJobId, IFaxIncomingJob* pFaxIncomingJob);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountoutgoingqueue
@GUID("0f1424e9-f22d-4553-b7a5-0d24bd0d7e46")
interface IFaxAccountOutgoingQueue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingqueue-getjobs
    HRESULT GetJobs(IFaxOutgoingJobs* pFaxOutgoingJobs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingqueue-getjob
    HRESULT GetJob(BSTR bstrJobId, IFaxOutgoingJob* pFaxOutgoingJob);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxoutgoingmessage2
@GUID("b37df687-bc88-4b46-b3be-b458b3ea9e7f")
interface IFaxOutgoingMessage2 : IFaxOutgoingMessage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-get_hascoverpage
    HRESULT get_HasCoverPage(VARIANT_BOOL* pbHasCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-get_receipttype
    HRESULT get_ReceiptType(FAX_RECEIPT_TYPE_ENUM* pReceiptType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-get_receiptaddress
    HRESULT get_ReceiptAddress(BSTR* pbstrReceiptAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-get_read
    HRESULT get_Read(VARIANT_BOOL* pbRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-put_read
    HRESULT put_Read(VARIANT_BOOL bRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxoutgoingmessage2-refresh
    HRESULT Refresh();
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountincomingarchive
@GUID("a8a5b6ef-e0d6-4aee-955c-91625bec9db4")
interface IFaxAccountIncomingArchive : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingarchive-get_sizelow
    HRESULT get_SizeLow(int* plSizeLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingarchive-get_sizehigh
    HRESULT get_SizeHigh(int* plSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingarchive-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingarchive-getmessages
    HRESULT GetMessages(int lPrefetchSize, IFaxIncomingMessageIterator* pFaxIncomingMessageIterator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountincomingarchive-getmessage
    HRESULT GetMessage(BSTR bstrMessageId, IFaxIncomingMessage* pFaxIncomingMessage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountoutgoingarchive
@GUID("5463076d-ec14-491f-926e-b3ceda5e5662")
interface IFaxAccountOutgoingArchive : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingarchive-get_sizelow
    HRESULT get_SizeLow(int* plSizeLow);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingarchive-get_sizehigh
    HRESULT get_SizeHigh(int* plSizeHigh);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingarchive-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingarchive-getmessages
    HRESULT GetMessages(int lPrefetchSize, IFaxOutgoingMessageIterator* pFaxOutgoingMessageIterator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxaccountoutgoingarchive-getmessage
    HRESULT GetMessage(BSTR bstrMessageId, IFaxOutgoingMessage* pFaxOutgoingMessage);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxsecurity2
@GUID("17d851f4-d09b-48fc-99c9-8f24c4db9ab1")
interface IFaxSecurity2 : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-get_descriptor
    HRESULT get_Descriptor(VARIANT* pvDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-put_descriptor
    HRESULT put_Descriptor(VARIANT vDescriptor);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-get_grantedrights
    HRESULT get_GrantedRights(FAX_ACCESS_RIGHTS_ENUM_2* pGrantedRights);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-refresh
    HRESULT Refresh();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-get_informationtype
    HRESULT get_InformationType(int* plInformationType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxsecurity2-put_informationtype
    HRESULT put_InformationType(int lInformationType);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxincomingmessage2
@GUID("f9208503-e2bc-48f3-9ec0-e6236f9b509a")
interface IFaxIncomingMessage2 : IFaxIncomingMessage
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_subject
    HRESULT get_Subject(BSTR* pbstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_subject
    HRESULT put_Subject(BSTR bstrSubject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_sendername
    HRESULT get_SenderName(BSTR* pbstrSenderName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_sendername
    HRESULT put_SenderName(BSTR bstrSenderName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_senderfaxnumber
    HRESULT get_SenderFaxNumber(BSTR* pbstrSenderFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_senderfaxnumber
    HRESULT put_SenderFaxNumber(BSTR bstrSenderFaxNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_hascoverpage
    HRESULT get_HasCoverPage(VARIANT_BOOL* pbHasCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_hascoverpage
    HRESULT put_HasCoverPage(VARIANT_BOOL bHasCoverPage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_recipients
    HRESULT get_Recipients(BSTR* pbstrRecipients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_recipients
    HRESULT put_Recipients(BSTR bstrRecipients);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_wasreassigned
    HRESULT get_WasReAssigned(VARIANT_BOOL* pbWasReAssigned);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-get_read
    HRESULT get_Read(VARIANT_BOOL* pbRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-put_read
    HRESULT put_Read(VARIANT_BOOL bRead);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-reassign
    HRESULT ReAssign();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-save
    HRESULT Save();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-ifaxincomingmessage2-refresh
    HRESULT Refresh();
}

@GUID("2e037b27-cf8a-4abd-b1e0-5704943bea6f")
interface IFaxServerNotify : IDispatch
{
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxservernotify2
@GUID("ec9c69b9-5fe7-4805-9467-82fcd96af903")
interface IFaxServerNotify2 : IDispatch
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
    HRESULT OnQueuesStatusChange(IFaxServer2 pFaxServer, VARIANT_BOOL bOutgoingQueueBlocked, 
                                 VARIANT_BOOL bOutgoingQueuePaused, VARIANT_BOOL bIncomingQueueBlocked);
    HRESULT OnNewCall(IFaxServer2 pFaxServer, int lCallId, int lDeviceId, BSTR bstrCallerId);
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
    HRESULT OnDeviceStatusChange(IFaxServer2 pFaxServer, int lDeviceId, VARIANT_BOOL bPoweredOff, 
                                 VARIANT_BOOL bSending, VARIANT_BOOL bReceiving, VARIANT_BOOL bRinging);
    HRESULT OnGeneralServerConfigChanged(IFaxServer2 pFaxServer);
}

//INTERFACEF ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nn-faxcomex-ifaxaccountnotify
@GUID("b9b3bc81-ac1b-46f3-b39d-0adc30e1b788")
interface IFaxAccountNotify : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onincomingjobadded
    HRESULT OnIncomingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onincomingjobremoved
    HRESULT OnIncomingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onincomingjobchanged
    HRESULT OnIncomingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onoutgoingjobadded
    HRESULT OnOutgoingJobAdded(IFaxAccount pFaxAccount, BSTR bstrJobId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onoutgoingjobremoved
    HRESULT OnOutgoingJobRemoved(IFaxAccount pFaxAccount, BSTR bstrJobId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onoutgoingjobchanged
    HRESULT OnOutgoingJobChanged(IFaxAccount pFaxAccount, BSTR bstrJobId, IFaxJobStatus pJobStatus);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onincomingmessageadded
    HRESULT OnIncomingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId, VARIANT_BOOL fAddedToReceiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onincomingmessageremoved
    HRESULT OnIncomingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId, 
                                     VARIANT_BOOL fRemovedFromReceiveFolder);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onoutgoingmessageadded
    HRESULT OnOutgoingMessageAdded(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onoutgoingmessageremoved
    HRESULT OnOutgoingMessageRemoved(IFaxAccount pFaxAccount, BSTR bstrMessageId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/faxcomex/nf-faxcomex-_ifaxaccountnotify-onservershutdown
    HRESULT OnServerShutDown(IFaxServer2 pFaxServer);
}

@GUID("641bd880-2dc8-11d0-90ea-00aa0060f86c")
interface IStillImageW : IUnknown
{
    HRESULT Initialize(HINSTANCE hinst, uint dwVersion);
    HRESULT GetDeviceList(uint dwType, uint dwFlags, uint* pdwItemsReturned, void** ppBuffer);
    HRESULT GetDeviceInfo(PWSTR pwszDeviceName, void** ppBuffer);
    HRESULT CreateDevice(PWSTR pwszDeviceName, uint dwMode, IStiDevice* pDevice, IUnknown punkOuter);
    HRESULT GetDeviceValue(PWSTR pwszDeviceName, PWSTR pValueName, uint* pType, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                           uint* cbData);
    HRESULT SetDeviceValue(PWSTR pwszDeviceName, PWSTR pValueName, uint Type, 
                           /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/ubyte* pData, 
                           uint cbData);
    HRESULT GetSTILaunchInformation(PWSTR pwszDeviceName, uint* pdwEventCode, PWSTR pwszEventName);
    HRESULT RegisterLaunchApplication(PWSTR pwszAppName, PWSTR pwszCommandLine);
    HRESULT UnregisterLaunchApplication(PWSTR pwszAppName);
    HRESULT EnableHwNotifications(const(PWSTR) pwszDeviceName, BOOL bNewState);
    HRESULT GetHwNotificationState(const(PWSTR) pwszDeviceName, BOOL* pbCurrentState);
    HRESULT RefreshDeviceBus(const(PWSTR) pwszDeviceName);
    HRESULT LaunchApplicationForDevice(PWSTR pwszDeviceName, PWSTR pwszAppName, STINOTIFY* pStiNotify);
    HRESULT SetupDeviceParameters(STI_DEVICE_INFORMATIONW* param0);
    HRESULT WriteToErrorLog(uint dwMessageType, const(PWSTR) pszMessage);
}

@GUID("6cfa5a80-2dc8-11d0-90ea-00aa0060f86c")
interface IStiDevice : IUnknown
{
    HRESULT Initialize(HINSTANCE hinst, const(PWSTR) pwszDeviceName, uint dwVersion, uint dwMode);
    HRESULT GetCapabilities(STI_DEV_CAPS* pDevCaps);
    HRESULT GetStatus(STI_DEVICE_STATUS* pDevStatus);
    HRESULT DeviceReset();
    HRESULT Diagnostic(STI_DIAG* pBuffer);
    HRESULT Escape(uint EscapeFunction, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInData, 
                   uint cbInDataSize, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pOutData, 
                   uint dwOutDataSize, uint* pdwActualData);
    HRESULT GetLastError(uint* pdwLastDeviceError);
    HRESULT LockDevice(uint dwTimeOut);
    HRESULT UnLockDevice();
    HRESULT RawReadData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                        uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                         uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawReadCommand(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                           uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteCommand(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                            uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT Subscribe(STISUBSCRIBE* lpSubsribe);
    HRESULT GetLastNotificationData(STINOTIFY* lpNotify);
    HRESULT UnSubscribe();
    HRESULT GetLastErrorInfo(_ERROR_INFOW* pLastErrorInfo);
}

@GUID("128a9860-52dc-11d0-9edf-444553540000")
interface IStiDeviceControl : IUnknown
{
    HRESULT Initialize(uint dwDeviceType, uint dwMode, const(PWSTR) pwszPortName, uint dwFlags);
    HRESULT RawReadData(void* lpBuffer, uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteData(void* lpBuffer, uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawReadCommand(void* lpBuffer, uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteCommand(void* lpBuffer, uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawDeviceControl(uint EscapeFunction, void* lpInData, uint cbInDataSize, void* pOutData, 
                             uint dwOutDataSize, uint* pdwActualData);
    HRESULT GetLastError(uint* lpdwLastError);
    HRESULT GetMyDevicePortName(PWSTR lpszDevicePath, uint cwDevicePathSize);
    HRESULT GetMyDeviceHandle(HANDLE* lph);
    HRESULT GetMyDeviceOpenMode(uint* pdwOpenMode);
    HRESULT WriteToErrorLog(uint dwMessageType, const(PWSTR) pszMessage, uint dwErrorCode);
}

@GUID("0c9bb460-51ac-11d0-90ea-00aa0060f86c")
interface IStiUSD : IUnknown
{
    HRESULT Initialize(IStiDeviceControl pHelDcb, uint dwStiVersion, HKEY hParametersKey);
    HRESULT GetCapabilities(STI_USD_CAPS* pDevCaps);
    HRESULT GetStatus(STI_DEVICE_STATUS* pDevStatus);
    HRESULT DeviceReset();
    HRESULT Diagnostic(STI_DIAG* pBuffer);
    HRESULT Escape(uint EscapeFunction, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/void* lpInData, 
                   uint cbInDataSize, 
                   /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(4)))])*/void* pOutData, 
                   uint cbOutDataSize, uint* pdwActualData);
    HRESULT GetLastError(uint* pdwLastDeviceError);
    HRESULT LockDevice();
    HRESULT UnLockDevice();
    HRESULT RawReadData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                        uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteData(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                         uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawReadCommand(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                           uint* lpdwNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT RawWriteCommand(/*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(1)))])*/void* lpBuffer, 
                            uint nNumberOfBytes, OVERLAPPED* lpOverlapped);
    HRESULT SetNotificationHandle(HANDLE hEvent);
    HRESULT GetNotificationData(STINOTIFY* lpNotify);
    HRESULT GetLastErrorInfo(_ERROR_INFOW* pLastErrorInfo);
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
const GUID IID_IStiDevice                   = GUIDOF!IStiDevice;
const GUID IID_IStiDeviceControl            = GUIDOF!IStiDeviceControl;
const GUID IID_IStiUSD                      = GUIDOF!IStiUSD;
const GUID IID_IStillImageW                 = GUIDOF!IStillImageW;
