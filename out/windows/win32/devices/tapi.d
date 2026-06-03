// Written in the D programming language.

module windows.win32.devices.tapi;

public import windows.core;
public import windows.win32.foundation : BOOL, BSTR, CHAR, HANDLE, HINSTANCE, HRESULT,
                                         HWND, PSTR, PWSTR, SYSTEMTIME, VARIANT_BOOL,
                                         WPARAM;
public import windows.win32.media.directshow : ALLOCATOR_PROPERTIES;
public import windows.win32.media.mediafoundation : AM_MEDIA_TYPE;
public import windows.win32.system.addressbook : IAddrBook, IMAPITable, IMessage, SPropTagArray,
                                                 SPropValue;
public import windows.win32.system.com : CY, IDispatch, IEnumUnknown, IStream,
                                         IUnknown;
public import windows.win32.system.variant : VARIANT;
public import windows.win32.ui.windowsandmessaging : HICON;

extern(Windows) @nogc nothrow:


// Enums


// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_tonemode
alias TAPI_TONEMODE = int;
enum : int
{
    TTM_RINGBACK = 0x00000002,
    TTM_BUSY     = 0x00000004,
    TTM_BEEP     = 0x00000008,
    TTM_BILLING  = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_gatherterm
alias TAPI_GATHERTERM = int;
enum : int
{
    TGT_BUFFERFULL   = 0x00000001,
    TGT_TERMDIGIT    = 0x00000002,
    TGT_FIRSTTIMEOUT = 0x00000004,
    TGT_INTERTIMEOUT = 0x00000008,
    TGT_CANCEL       = 0x00000010,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_event
alias ADDRESS_EVENT = int;
enum : int
{
    AE_STATE          = 0x00000000,
    AE_CAPSCHANGE     = 0x00000001,
    AE_RINGING        = 0x00000002,
    AE_CONFIGCHANGE   = 0x00000003,
    AE_FORWARD        = 0x00000004,
    AE_NEWTERMINAL    = 0x00000005,
    AE_REMOVETERMINAL = 0x00000006,
    AE_MSGWAITON      = 0x00000007,
    AE_MSGWAITOFF     = 0x00000008,
    AE_LASTITEM       = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_state
alias ADDRESS_STATE = int;
enum : int
{
    AS_INSERVICE    = 0x00000000,
    AS_OUTOFSERVICE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_state
alias CALL_STATE = int;
enum : int
{
    CS_IDLE         = 0x00000000,
    CS_INPROGRESS   = 0x00000001,
    CS_CONNECTED    = 0x00000002,
    CS_DISCONNECTED = 0x00000003,
    CS_OFFERING     = 0x00000004,
    CS_HOLD         = 0x00000005,
    CS_QUEUED       = 0x00000006,
    CS_LASTITEM     = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_state_event_cause
alias CALL_STATE_EVENT_CAUSE = int;
enum : int
{
    CEC_NONE                  = 0x00000000,
    CEC_DISCONNECT_NORMAL     = 0x00000001,
    CEC_DISCONNECT_BUSY       = 0x00000002,
    CEC_DISCONNECT_BADADDRESS = 0x00000003,
    CEC_DISCONNECT_NOANSWER   = 0x00000004,
    CEC_DISCONNECT_CANCELLED  = 0x00000005,
    CEC_DISCONNECT_REJECTED   = 0x00000006,
    CEC_DISCONNECT_FAILED     = 0x00000007,
    CEC_DISCONNECT_BLOCKED    = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_media_event
alias CALL_MEDIA_EVENT = int;
enum : int
{
    CME_NEW_STREAM      = 0x00000000,
    CME_STREAM_FAIL     = 0x00000001,
    CME_TERMINAL_FAIL   = 0x00000002,
    CME_STREAM_NOT_USED = 0x00000003,
    CME_STREAM_ACTIVE   = 0x00000004,
    CME_STREAM_INACTIVE = 0x00000005,
    CME_LASTITEM        = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_media_event_cause
alias CALL_MEDIA_EVENT_CAUSE = int;
enum : int
{
    CMC_UNKNOWN            = 0x00000000,
    CMC_BAD_DEVICE         = 0x00000001,
    CMC_CONNECT_FAIL       = 0x00000002,
    CMC_LOCAL_REQUEST      = 0x00000003,
    CMC_REMOTE_REQUEST     = 0x00000004,
    CMC_MEDIA_TIMEOUT      = 0x00000005,
    CMC_MEDIA_RECOVERED    = 0x00000006,
    CMC_QUALITY_OF_SERVICE = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-disconnect_code
alias DISCONNECT_CODE = int;
enum : int
{
    DC_NORMAL   = 0x00000000,
    DC_NOANSWER = 0x00000001,
    DC_REJECTED = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_state
alias TERMINAL_STATE = int;
enum : int
{
    TS_INUSE    = 0x00000000,
    TS_NOTINUSE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_direction
alias TERMINAL_DIRECTION = int;
enum : int
{
    TD_CAPTURE          = 0x00000000,
    TD_RENDER           = 0x00000001,
    TD_BIDIRECTIONAL    = 0x00000002,
    TD_MULTITRACK_MIXED = 0x00000003,
    TD_NONE             = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_type
alias TERMINAL_TYPE = int;
enum : int
{
    TT_STATIC  = 0x00000000,
    TT_DYNAMIC = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_privilege
alias CALL_PRIVILEGE = int;
enum : int
{
    CP_OWNER   = 0x00000000,
    CP_MONITOR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_event
alias TAPI_EVENT = int;
enum : int
{
    TE_TAPIOBJECT         = 0x00000001,
    TE_ADDRESS            = 0x00000002,
    TE_CALLNOTIFICATION   = 0x00000004,
    TE_CALLSTATE          = 0x00000008,
    TE_CALLMEDIA          = 0x00000010,
    TE_CALLHUB            = 0x00000020,
    TE_CALLINFOCHANGE     = 0x00000040,
    TE_PRIVATE            = 0x00000080,
    TE_REQUEST            = 0x00000100,
    TE_AGENT              = 0x00000200,
    TE_AGENTSESSION       = 0x00000400,
    TE_QOSEVENT           = 0x00000800,
    TE_AGENTHANDLER       = 0x00001000,
    TE_ACDGROUP           = 0x00002000,
    TE_QUEUE              = 0x00004000,
    TE_DIGITEVENT         = 0x00008000,
    TE_GENERATEEVENT      = 0x00010000,
    TE_ASRTERMINAL        = 0x00020000,
    TE_TTSTERMINAL        = 0x00040000,
    TE_FILETERMINAL       = 0x00080000,
    TE_TONETERMINAL       = 0x00100000,
    TE_PHONEEVENT         = 0x00200000,
    TE_TONEEVENT          = 0x00400000,
    TE_GATHERDIGITS       = 0x00800000,
    TE_ADDRESSDEVSPECIFIC = 0x01000000,
    TE_PHONEDEVSPECIFIC   = 0x02000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-call_notification_event
alias CALL_NOTIFICATION_EVENT = int;
enum : int
{
    CNE_OWNER    = 0x00000000,
    CNE_MONITOR  = 0x00000001,
    CNE_LASTITEM = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callhub_event
alias CALLHUB_EVENT = int;
enum : int
{
    CHE_CALLJOIN    = 0x00000000,
    CHE_CALLLEAVE   = 0x00000001,
    CHE_CALLHUBNEW  = 0x00000002,
    CHE_CALLHUBIDLE = 0x00000003,
    CHE_LASTITEM    = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callhub_state
alias CALLHUB_STATE = int;
enum : int
{
    CHS_ACTIVE = 0x00000000,
    CHS_IDLE   = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapiobject_event
alias TAPIOBJECT_EVENT = int;
enum : int
{
    TE_ADDRESSCREATE   = 0x00000000,
    TE_ADDRESSREMOVE   = 0x00000001,
    TE_REINIT          = 0x00000002,
    TE_TRANSLATECHANGE = 0x00000003,
    TE_ADDRESSCLOSE    = 0x00000004,
    TE_PHONECREATE     = 0x00000005,
    TE_PHONEREMOVE     = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-tapi_object_type
alias TAPI_OBJECT_TYPE = int;
enum : int
{
    TOT_NONE     = 0x00000000,
    TOT_TAPI     = 0x00000001,
    TOT_ADDRESS  = 0x00000002,
    TOT_TERMINAL = 0x00000003,
    TOT_CALL     = 0x00000004,
    TOT_CALLHUB  = 0x00000005,
    TOT_PHONE    = 0x00000006,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-qos_service_level
alias QOS_SERVICE_LEVEL = int;
enum : int
{
    QSL_NEEDED       = 0x00000001,
    QSL_IF_AVAILABLE = 0x00000002,
    QSL_BEST_EFFORT  = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-qos_event
alias QOS_EVENT = int;
enum : int
{
    QE_NOQOS            = 0x00000001,
    QE_ADMISSIONFAILURE = 0x00000002,
    QE_POLICYFAILURE    = 0x00000003,
    QE_GENERICERROR     = 0x00000004,
    QE_LASTITEM         = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfochange_cause
alias CALLINFOCHANGE_CAUSE = int;
enum : int
{
    CIC_OTHER         = 0x00000000,
    CIC_DEVSPECIFIC   = 0x00000001,
    CIC_BEARERMODE    = 0x00000002,
    CIC_RATE          = 0x00000003,
    CIC_APPSPECIFIC   = 0x00000004,
    CIC_CALLID        = 0x00000005,
    CIC_RELATEDCALLID = 0x00000006,
    CIC_ORIGIN        = 0x00000007,
    CIC_REASON        = 0x00000008,
    CIC_COMPLETIONID  = 0x00000009,
    CIC_NUMOWNERINCR  = 0x0000000a,
    CIC_NUMOWNERDECR  = 0x0000000b,
    CIC_NUMMONITORS   = 0x0000000c,
    CIC_TRUNK         = 0x0000000d,
    CIC_CALLERID      = 0x0000000e,
    CIC_CALLEDID      = 0x0000000f,
    CIC_CONNECTEDID   = 0x00000010,
    CIC_REDIRECTIONID = 0x00000011,
    CIC_REDIRECTINGID = 0x00000012,
    CIC_USERUSERINFO  = 0x00000013,
    CIC_HIGHLEVELCOMP = 0x00000014,
    CIC_LOWLEVELCOMP  = 0x00000015,
    CIC_CHARGINGINFO  = 0x00000016,
    CIC_TREATMENT     = 0x00000017,
    CIC_CALLDATA      = 0x00000018,
    CIC_PRIVILEGE     = 0x00000019,
    CIC_MEDIATYPE     = 0x0000001a,
    CIC_LASTITEM      = 0x0000001a,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_long
alias CALLINFO_LONG = int;
enum : int
{
    CIL_MEDIATYPESAVAILABLE      = 0x00000000,
    CIL_BEARERMODE               = 0x00000001,
    CIL_CALLERIDADDRESSTYPE      = 0x00000002,
    CIL_CALLEDIDADDRESSTYPE      = 0x00000003,
    CIL_CONNECTEDIDADDRESSTYPE   = 0x00000004,
    CIL_REDIRECTIONIDADDRESSTYPE = 0x00000005,
    CIL_REDIRECTINGIDADDRESSTYPE = 0x00000006,
    CIL_ORIGIN                   = 0x00000007,
    CIL_REASON                   = 0x00000008,
    CIL_APPSPECIFIC              = 0x00000009,
    CIL_CALLPARAMSFLAGS          = 0x0000000a,
    CIL_CALLTREATMENT            = 0x0000000b,
    CIL_MINRATE                  = 0x0000000c,
    CIL_MAXRATE                  = 0x0000000d,
    CIL_COUNTRYCODE              = 0x0000000e,
    CIL_CALLID                   = 0x0000000f,
    CIL_RELATEDCALLID            = 0x00000010,
    CIL_COMPLETIONID             = 0x00000011,
    CIL_NUMBEROFOWNERS           = 0x00000012,
    CIL_NUMBEROFMONITORS         = 0x00000013,
    CIL_TRUNK                    = 0x00000014,
    CIL_RATE                     = 0x00000015,
    CIL_GENERATEDIGITDURATION    = 0x00000016,
    CIL_MONITORDIGITMODES        = 0x00000017,
    CIL_MONITORMEDIAMODES        = 0x00000018,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_string
alias CALLINFO_STRING = int;
enum : int
{
    CIS_CALLERIDNAME            = 0x00000000,
    CIS_CALLERIDNUMBER          = 0x00000001,
    CIS_CALLEDIDNAME            = 0x00000002,
    CIS_CALLEDIDNUMBER          = 0x00000003,
    CIS_CONNECTEDIDNAME         = 0x00000004,
    CIS_CONNECTEDIDNUMBER       = 0x00000005,
    CIS_REDIRECTIONIDNAME       = 0x00000006,
    CIS_REDIRECTIONIDNUMBER     = 0x00000007,
    CIS_REDIRECTINGIDNAME       = 0x00000008,
    CIS_REDIRECTINGIDNUMBER     = 0x00000009,
    CIS_CALLEDPARTYFRIENDLYNAME = 0x0000000a,
    CIS_COMMENT                 = 0x0000000b,
    CIS_DISPLAYABLEADDRESS      = 0x0000000c,
    CIS_CALLINGPARTYID          = 0x0000000d,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-callinfo_buffer
alias CALLINFO_BUFFER = int;
enum : int
{
    CIB_USERUSERINFO                 = 0x00000000,
    CIB_DEVSPECIFICBUFFER            = 0x00000001,
    CIB_CALLDATABUFFER               = 0x00000002,
    CIB_CHARGINGINFOBUFFER           = 0x00000003,
    CIB_HIGHLEVELCOMPATIBILITYBUFFER = 0x00000004,
    CIB_LOWLEVELCOMPATIBILITYBUFFER  = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_capability
alias ADDRESS_CAPABILITY = int;
enum : int
{
    AC_ADDRESSTYPES                 = 0x00000000,
    AC_BEARERMODES                  = 0x00000001,
    AC_MAXACTIVECALLS               = 0x00000002,
    AC_MAXONHOLDCALLS               = 0x00000003,
    AC_MAXONHOLDPENDINGCALLS        = 0x00000004,
    AC_MAXNUMCONFERENCE             = 0x00000005,
    AC_MAXNUMTRANSCONF              = 0x00000006,
    AC_MONITORDIGITSUPPORT          = 0x00000007,
    AC_GENERATEDIGITSUPPORT         = 0x00000008,
    AC_GENERATETONEMODES            = 0x00000009,
    AC_GENERATETONEMAXNUMFREQ       = 0x0000000a,
    AC_MONITORTONEMAXNUMFREQ        = 0x0000000b,
    AC_MONITORTONEMAXNUMENTRIES     = 0x0000000c,
    AC_DEVCAPFLAGS                  = 0x0000000d,
    AC_ANSWERMODES                  = 0x0000000e,
    AC_LINEFEATURES                 = 0x0000000f,
    AC_SETTABLEDEVSTATUS            = 0x00000010,
    AC_PARKSUPPORT                  = 0x00000011,
    AC_CALLERIDSUPPORT              = 0x00000012,
    AC_CALLEDIDSUPPORT              = 0x00000013,
    AC_CONNECTEDIDSUPPORT           = 0x00000014,
    AC_REDIRECTIONIDSUPPORT         = 0x00000015,
    AC_REDIRECTINGIDSUPPORT         = 0x00000016,
    AC_ADDRESSCAPFLAGS              = 0x00000017,
    AC_CALLFEATURES1                = 0x00000018,
    AC_CALLFEATURES2                = 0x00000019,
    AC_REMOVEFROMCONFCAPS           = 0x0000001a,
    AC_REMOVEFROMCONFSTATE          = 0x0000001b,
    AC_TRANSFERMODES                = 0x0000001c,
    AC_ADDRESSFEATURES              = 0x0000001d,
    AC_PREDICTIVEAUTOTRANSFERSTATES = 0x0000001e,
    AC_MAXCALLDATASIZE              = 0x0000001f,
    AC_LINEID                       = 0x00000020,
    AC_ADDRESSID                    = 0x00000021,
    AC_FORWARDMODES                 = 0x00000022,
    AC_MAXFORWARDENTRIES            = 0x00000023,
    AC_MAXSPECIFICENTRIES           = 0x00000024,
    AC_MINFWDNUMRINGS               = 0x00000025,
    AC_MAXFWDNUMRINGS               = 0x00000026,
    AC_MAXCALLCOMPLETIONS           = 0x00000027,
    AC_CALLCOMPLETIONCONDITIONS     = 0x00000028,
    AC_CALLCOMPLETIONMODES          = 0x00000029,
    AC_PERMANENTDEVICEID            = 0x0000002a,
    AC_GATHERDIGITSMINTIMEOUT       = 0x0000002b,
    AC_GATHERDIGITSMAXTIMEOUT       = 0x0000002c,
    AC_GENERATEDIGITMINDURATION     = 0x0000002d,
    AC_GENERATEDIGITMAXDURATION     = 0x0000002e,
    AC_GENERATEDIGITDEFAULTDURATION = 0x0000002f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-address_capability_string
alias ADDRESS_CAPABILITY_STRING = int;
enum : int
{
    ACS_PROTOCOL              = 0x00000000,
    ACS_ADDRESSDEVICESPECIFIC = 0x00000001,
    ACS_LINEDEVICESPECIFIC    = 0x00000002,
    ACS_PROVIDERSPECIFIC      = 0x00000003,
    ACS_SWITCHSPECIFIC        = 0x00000004,
    ACS_PERMANENTDEVICEGUID   = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-fullduplex_support
alias FULLDUPLEX_SUPPORT = int;
enum : int
{
    FDS_SUPPORTED    = 0x00000000,
    FDS_NOTSUPPORTED = 0x00000001,
    FDS_UNKNOWN      = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-finish_mode
alias FINISH_MODE = int;
enum : int
{
    FM_ASTRANSFER   = 0x00000000,
    FM_ASCONFERENCE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_privilege
alias PHONE_PRIVILEGE = int;
enum : int
{
    PP_OWNER   = 0x00000000,
    PP_MONITOR = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_hook_switch_device
alias PHONE_HOOK_SWITCH_DEVICE = int;
enum : int
{
    PHSD_HANDSET      = 0x00000001,
    PHSD_SPEAKERPHONE = 0x00000002,
    PHSD_HEADSET      = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_hook_switch_state
alias PHONE_HOOK_SWITCH_STATE = int;
enum : int
{
    PHSS_ONHOOK               = 0x00000001,
    PHSS_OFFHOOK_MIC_ONLY     = 0x00000002,
    PHSS_OFFHOOK_SPEAKER_ONLY = 0x00000004,
    PHSS_OFFHOOK              = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_lamp_mode
alias PHONE_LAMP_MODE = int;
enum : int
{
    LM_DUMMY         = 0x00000001,
    LM_OFF           = 0x00000002,
    LM_STEADY        = 0x00000004,
    LM_WINK          = 0x00000008,
    LM_FLASH         = 0x00000010,
    LM_FLUTTER       = 0x00000020,
    LM_BROKENFLUTTER = 0x00000040,
    LM_UNKNOWN       = 0x00000080,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_long
alias PHONECAPS_LONG = int;
enum : int
{
    PCL_HOOKSWITCHES                = 0x00000000,
    PCL_HANDSETHOOKSWITCHMODES      = 0x00000001,
    PCL_HEADSETHOOKSWITCHMODES      = 0x00000002,
    PCL_SPEAKERPHONEHOOKSWITCHMODES = 0x00000003,
    PCL_DISPLAYNUMROWS              = 0x00000004,
    PCL_DISPLAYNUMCOLUMNS           = 0x00000005,
    PCL_NUMRINGMODES                = 0x00000006,
    PCL_NUMBUTTONLAMPS              = 0x00000007,
    PCL_GENERICPHONE                = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_string
alias PHONECAPS_STRING = int;
enum : int
{
    PCS_PHONENAME    = 0x00000000,
    PCS_PHONEINFO    = 0x00000001,
    PCS_PROVIDERINFO = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phonecaps_buffer
alias PHONECAPS_BUFFER = int;
enum : int
{
    PCB_DEVSPECIFICBUFFER = 0x00000000,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_state
alias PHONE_BUTTON_STATE = int;
enum : int
{
    PBS_UP      = 0x00000001,
    PBS_DOWN    = 0x00000002,
    PBS_UNKNOWN = 0x00000004,
    PBS_UNAVAIL = 0x00000008,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_mode
alias PHONE_BUTTON_MODE = int;
enum : int
{
    PBM_DUMMY   = 0x00000000,
    PBM_CALL    = 0x00000001,
    PBM_FEATURE = 0x00000002,
    PBM_KEYPAD  = 0x00000003,
    PBM_LOCAL   = 0x00000004,
    PBM_DISPLAY = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_button_function
alias PHONE_BUTTON_FUNCTION = int;
enum : int
{
    PBF_UNKNOWN      = 0x00000000,
    PBF_CONFERENCE   = 0x00000001,
    PBF_TRANSFER     = 0x00000002,
    PBF_DROP         = 0x00000003,
    PBF_HOLD         = 0x00000004,
    PBF_RECALL       = 0x00000005,
    PBF_DISCONNECT   = 0x00000006,
    PBF_CONNECT      = 0x00000007,
    PBF_MSGWAITON    = 0x00000008,
    PBF_MSGWAITOFF   = 0x00000009,
    PBF_SELECTRING   = 0x0000000a,
    PBF_ABBREVDIAL   = 0x0000000b,
    PBF_FORWARD      = 0x0000000c,
    PBF_PICKUP       = 0x0000000d,
    PBF_RINGAGAIN    = 0x0000000e,
    PBF_PARK         = 0x0000000f,
    PBF_REJECT       = 0x00000010,
    PBF_REDIRECT     = 0x00000011,
    PBF_MUTE         = 0x00000012,
    PBF_VOLUMEUP     = 0x00000013,
    PBF_VOLUMEDOWN   = 0x00000014,
    PBF_SPEAKERON    = 0x00000015,
    PBF_SPEAKEROFF   = 0x00000016,
    PBF_FLASH        = 0x00000017,
    PBF_DATAON       = 0x00000018,
    PBF_DATAOFF      = 0x00000019,
    PBF_DONOTDISTURB = 0x0000001a,
    PBF_INTERCOM     = 0x0000001b,
    PBF_BRIDGEDAPP   = 0x0000001c,
    PBF_BUSY         = 0x0000001d,
    PBF_CALLAPP      = 0x0000001e,
    PBF_DATETIME     = 0x0000001f,
    PBF_DIRECTORY    = 0x00000020,
    PBF_COVER        = 0x00000021,
    PBF_CALLID       = 0x00000022,
    PBF_LASTNUM      = 0x00000023,
    PBF_NIGHTSRV     = 0x00000024,
    PBF_SENDCALLS    = 0x00000025,
    PBF_MSGINDICATOR = 0x00000026,
    PBF_REPDIAL      = 0x00000027,
    PBF_SETREPDIAL   = 0x00000028,
    PBF_SYSTEMSPEED  = 0x00000029,
    PBF_STATIONSPEED = 0x0000002a,
    PBF_CAMPON       = 0x0000002b,
    PBF_SAVEREPEAT   = 0x0000002c,
    PBF_QUEUECALL    = 0x0000002d,
    PBF_NONE         = 0x0000002e,
    PBF_SEND         = 0x0000002f,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_tone
alias PHONE_TONE = int;
enum : int
{
    PT_KEYPADZERO       = 0x00000000,
    PT_KEYPADONE        = 0x00000001,
    PT_KEYPADTWO        = 0x00000002,
    PT_KEYPADTHREE      = 0x00000003,
    PT_KEYPADFOUR       = 0x00000004,
    PT_KEYPADFIVE       = 0x00000005,
    PT_KEYPADSIX        = 0x00000006,
    PT_KEYPADSEVEN      = 0x00000007,
    PT_KEYPADEIGHT      = 0x00000008,
    PT_KEYPADNINE       = 0x00000009,
    PT_KEYPADSTAR       = 0x0000000a,
    PT_KEYPADPOUND      = 0x0000000b,
    PT_KEYPADA          = 0x0000000c,
    PT_KEYPADB          = 0x0000000d,
    PT_KEYPADC          = 0x0000000e,
    PT_KEYPADD          = 0x0000000f,
    PT_NORMALDIALTONE   = 0x00000010,
    PT_EXTERNALDIALTONE = 0x00000011,
    PT_BUSY             = 0x00000012,
    PT_RINGBACK         = 0x00000013,
    PT_ERRORTONE        = 0x00000014,
    PT_SILENCE          = 0x00000015,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-phone_event
alias PHONE_EVENT = int;
enum : int
{
    PE_DISPLAY        = 0x00000000,
    PE_LAMPMODE       = 0x00000001,
    PE_RINGMODE       = 0x00000002,
    PE_RINGVOLUME     = 0x00000003,
    PE_HOOKSWITCH     = 0x00000004,
    PE_CAPSCHANGE     = 0x00000005,
    PE_BUTTON         = 0x00000006,
    PE_CLOSE          = 0x00000007,
    PE_NUMBERGATHERED = 0x00000008,
    PE_DIALING        = 0x00000009,
    PE_ANSWER         = 0x0000000a,
    PE_DISCONNECT     = 0x0000000b,
    PE_LASTITEM       = 0x0000000b,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-terminal_media_state
alias TERMINAL_MEDIA_STATE = int;
enum : int
{
    TMS_IDLE     = 0x00000000,
    TMS_ACTIVE   = 0x00000001,
    TMS_PAUSED   = 0x00000002,
    TMS_LASTITEM = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ne-tapi3if-ft_state_event_cause
alias FT_STATE_EVENT_CAUSE = int;
enum : int
{
    FTEC_NORMAL      = 0x00000000,
    FTEC_END_OF_FILE = 0x00000001,
    FTEC_READ_ERROR  = 0x00000002,
    FTEC_WRITE_ERROR = 0x00000003,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_event
alias AGENT_EVENT = int;
enum : int
{
    AE_NOT_READY     = 0x00000000,
    AE_READY         = 0x00000001,
    AE_BUSY_ACD      = 0x00000002,
    AE_BUSY_INCOMING = 0x00000003,
    AE_BUSY_OUTGOING = 0x00000004,
    AE_UNKNOWN       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_state
alias AGENT_STATE = int;
enum : int
{
    AS_NOT_READY     = 0x00000000,
    AS_READY         = 0x00000001,
    AS_BUSY_ACD      = 0x00000002,
    AS_BUSY_INCOMING = 0x00000003,
    AS_BUSY_OUTGOING = 0x00000004,
    AS_UNKNOWN       = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_session_event
alias AGENT_SESSION_EVENT = int;
enum : int
{
    ASE_NEW_SESSION = 0x00000000,
    ASE_NOT_READY   = 0x00000001,
    ASE_READY       = 0x00000002,
    ASE_BUSY        = 0x00000003,
    ASE_WRAPUP      = 0x00000004,
    ASE_END         = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agent_session_state
alias AGENT_SESSION_STATE = int;
enum : int
{
    ASST_NOT_READY     = 0x00000000,
    ASST_READY         = 0x00000001,
    ASST_BUSY_ON_CALL  = 0x00000002,
    ASST_BUSY_WRAPUP   = 0x00000003,
    ASST_SESSION_ENDED = 0x00000004,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-agenthandler_event
alias AGENTHANDLER_EVENT = int;
enum : int
{
    AHE_NEW_AGENTHANDLER     = 0x00000000,
    AHE_AGENTHANDLER_REMOVED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-acdgroup_event
alias ACDGROUP_EVENT = int;
enum : int
{
    ACDGE_NEW_GROUP     = 0x00000000,
    ACDGE_GROUP_REMOVED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/ne-tapi3cc-acdqueue_event
alias ACDQUEUE_EVENT = int;
enum : int
{
    ACDQE_NEW_QUEUE     = 0x00000000,
    ACDQE_QUEUE_REMOVED = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_address_event
alias MSP_ADDRESS_EVENT = int;
enum : int
{
    ADDRESS_TERMINAL_AVAILABLE   = 0x00000000,
    ADDRESS_TERMINAL_UNAVAILABLE = 0x00000001,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_call_event
alias MSP_CALL_EVENT = int;
enum : int
{
    CALL_NEW_STREAM      = 0x00000000,
    CALL_STREAM_FAIL     = 0x00000001,
    CALL_TERMINAL_FAIL   = 0x00000002,
    CALL_STREAM_NOT_USED = 0x00000003,
    CALL_STREAM_ACTIVE   = 0x00000004,
    CALL_STREAM_INACTIVE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_call_event_cause
alias MSP_CALL_EVENT_CAUSE = int;
enum : int
{
    CALL_CAUSE_UNKNOWN            = 0x00000000,
    CALL_CAUSE_BAD_DEVICE         = 0x00000001,
    CALL_CAUSE_CONNECT_FAIL       = 0x00000002,
    CALL_CAUSE_LOCAL_REQUEST      = 0x00000003,
    CALL_CAUSE_REMOTE_REQUEST     = 0x00000004,
    CALL_CAUSE_MEDIA_TIMEOUT      = 0x00000005,
    CALL_CAUSE_MEDIA_RECOVERED    = 0x00000006,
    CALL_CAUSE_QUALITY_OF_SERVICE = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/ne-msp-msp_event
alias MSP_EVENT = int;
enum : int
{
    ME_ADDRESS_EVENT       = 0x00000000,
    ME_CALL_EVENT          = 0x00000001,
    ME_TSP_DATA            = 0x00000002,
    ME_PRIVATE_EVENT       = 0x00000003,
    ME_ASR_TERMINAL_EVENT  = 0x00000004,
    ME_TTS_TERMINAL_EVENT  = 0x00000005,
    ME_FILE_TERMINAL_EVENT = 0x00000006,
    ME_TONE_TERMINAL_EVENT = 0x00000007,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/ne-rend-directory_type
alias DIRECTORY_TYPE = int;
enum : int
{
    DT_NTDS = 0x00000001,
    DT_ILS  = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/ne-rend-directory_object_type
alias DIRECTORY_OBJECT_TYPE = int;
enum : int
{
    OT_CONFERENCE = 0x00000001,
    OT_USER       = 0x00000002,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/ne-rend-rnd_advertising_scope
alias RND_ADVERTISING_SCOPE = int;
enum : int
{
    RAS_LOCAL  = 0x00000001,
    RAS_SITE   = 0x00000002,
    RAS_REGION = 0x00000003,
    RAS_WORLD  = 0x00000004,
}

// Constants


enum uint TAPI_CURRENT_VERSION = 0x00020002U;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-addressstate
enum int LINE_ADDRESSSTATE = 0x00000000;

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-callinfo
    LINE_CALLINFO           = 0x00000001,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-callstate
    LINE_CALLSTATE          = 0x00000002,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-close
    LINE_CLOSE              = 0x00000003,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-devspecific
    LINE_DEVSPECIFIC        = 0x00000004,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-devspecificfeature
    LINE_DEVSPECIFICFEATURE = 0x00000005,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-gatherdigits
enum int LINE_GATHERDIGITS = 0x00000006;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-generate
enum int LINE_GENERATE = 0x00000007;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-linedevstate
enum int LINE_LINEDEVSTATE = 0x00000008;

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-monitordigits
    LINE_MONITORDIGITS = 0x00000009,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-monitormedia
    LINE_MONITORMEDIA  = 0x0000000a,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-monitortone
    LINE_MONITORTONE   = 0x0000000b,
}

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-reply
    LINE_REPLY   = 0x0000000c,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-request
    LINE_REQUEST = 0x0000000d,
}

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-button
    PHONE_BUTTON      = 0x0000000e,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-close
    PHONE_CLOSE       = 0x0000000f,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-devspecific
    PHONE_DEVSPECIFIC = 0x00000010,
}

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-reply
    PHONE_REPLY = 0x00000011,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-state
    PHONE_STATE = 0x00000012,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-create
enum int LINE_CREATE = 0x00000013;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-create
enum int PHONE_CREATE = 0x00000014;

enum : int
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-agentspecific
    LINE_AGENTSPECIFIC = 0x00000015,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-agentstatus
    LINE_AGENTSTATUS   = 0x00000016,
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-appnewcall
enum int LINE_APPNEWCALL = 0x00000017;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-proxyrequest
enum int LINE_PROXYREQUEST = 0x00000018;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-remove
enum int LINE_REMOVE = 0x00000019;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/phone-remove
enum int PHONE_REMOVE = 0x0000001a;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-agentsessionstatus
enum int LINE_AGENTSESSIONSTATUS = 0x0000001b;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-queuestatus
enum int LINE_QUEUESTATUS = 0x0000001c;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-agentstatusex
enum int LINE_AGENTSTATUSEX = 0x0000001d;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-groupstatus
enum int LINE_GROUPSTATUS = 0x0000001e;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-proxystatus
enum int LINE_PROXYSTATUS = 0x0000001f;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-appnewcallhub
enum int LINE_APPNEWCALLHUB = 0x00000020;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-callhubclose
enum int LINE_CALLHUBCLOSE = 0x00000021;
// Microsoft documentation: https://learn.microsoft.com/windows/win32/Tapi/line-devspecificex
enum int LINE_DEVSPECIFICEX = 0x00000022;
enum uint INITIALIZE_NEGOTIATION = 0xffffffffU;

enum : uint
{
    LINEADDRCAPFLAGS_FWDNUMRINGS              = 0x00000001U,
    LINEADDRCAPFLAGS_PICKUPGROUPID            = 0x00000002U,
    LINEADDRCAPFLAGS_SECURE                   = 0x00000004U,
    LINEADDRCAPFLAGS_BLOCKIDDEFAULT           = 0x00000008U,
    LINEADDRCAPFLAGS_BLOCKIDOVERRIDE          = 0x00000010U,
    LINEADDRCAPFLAGS_DIALED                   = 0x00000020U,
    LINEADDRCAPFLAGS_ORIGOFFHOOK              = 0x00000040U,
    LINEADDRCAPFLAGS_DESTOFFHOOK              = 0x00000080U,
    LINEADDRCAPFLAGS_FWDCONSULT               = 0x00000100U,
    LINEADDRCAPFLAGS_SETUPCONFNULL            = 0x00000200U,
    LINEADDRCAPFLAGS_AUTORECONNECT            = 0x00000400U,
    LINEADDRCAPFLAGS_COMPLETIONID             = 0x00000800U,
    LINEADDRCAPFLAGS_TRANSFERHELD             = 0x00001000U,
    LINEADDRCAPFLAGS_TRANSFERMAKE             = 0x00002000U,
    LINEADDRCAPFLAGS_CONFERENCEHELD           = 0x00004000U,
    LINEADDRCAPFLAGS_CONFERENCEMAKE           = 0x00008000U,
    LINEADDRCAPFLAGS_PARTIALDIAL              = 0x00010000U,
    LINEADDRCAPFLAGS_FWDSTATUSVALID           = 0x00020000U,
    LINEADDRCAPFLAGS_FWDINTEXTADDR            = 0x00040000U,
    LINEADDRCAPFLAGS_FWDBUSYNAADDR            = 0x00080000U,
    LINEADDRCAPFLAGS_ACCEPTTOALERT            = 0x00100000U,
    LINEADDRCAPFLAGS_CONFDROP                 = 0x00200000U,
    LINEADDRCAPFLAGS_PICKUPCALLWAIT           = 0x00400000U,
    LINEADDRCAPFLAGS_PREDICTIVEDIALER         = 0x00800000U,
    LINEADDRCAPFLAGS_QUEUE                    = 0x01000000U,
    LINEADDRCAPFLAGS_ROUTEPOINT               = 0x02000000U,
    LINEADDRCAPFLAGS_HOLDMAKESNEW             = 0x04000000U,
    LINEADDRCAPFLAGS_NOINTERNALCALLS          = 0x08000000U,
    LINEADDRCAPFLAGS_NOEXTERNALCALLS          = 0x10000000U,
    LINEADDRCAPFLAGS_SETCALLINGID             = 0x20000000U,
    LINEADDRCAPFLAGS_ACDGROUP                 = 0x40000000U,
    LINEADDRCAPFLAGS_NOPSTNADDRESSTRANSLATION = 0x80000000U,
}

enum : uint
{
    LINEADDRESSMODE_ADDRESSID    = 0x00000001U,
    LINEADDRESSMODE_DIALABLEADDR = 0x00000002U,
}

enum : uint
{
    LINEADDRESSSHARING_PRIVATE       = 0x00000001U,
    LINEADDRESSSHARING_BRIDGEDEXCL   = 0x00000002U,
    LINEADDRESSSHARING_BRIDGEDNEW    = 0x00000004U,
    LINEADDRESSSHARING_BRIDGEDSHARED = 0x00000008U,
    LINEADDRESSSHARING_MONITORED     = 0x00000010U,
    LINEADDRESSSTATE_OTHER           = 0x00000001U,
    LINEADDRESSSTATE_DEVSPECIFIC     = 0x00000002U,
    LINEADDRESSSTATE_INUSEZERO       = 0x00000004U,
    LINEADDRESSSTATE_INUSEONE        = 0x00000008U,
    LINEADDRESSSTATE_INUSEMANY       = 0x00000010U,
    LINEADDRESSSTATE_NUMCALLS        = 0x00000020U,
    LINEADDRESSSTATE_FORWARD         = 0x00000040U,
    LINEADDRESSSTATE_TERMINALS       = 0x00000080U,
    LINEADDRESSSTATE_CAPSCHANGE      = 0x00000100U,
    LINEADDRESSTYPE_PHONENUMBER      = 0x00000001U,
    LINEADDRESSTYPE_SDP              = 0x00000002U,
    LINEADDRESSTYPE_EMAILNAME        = 0x00000004U,
    LINEADDRESSTYPE_DOMAINNAME       = 0x00000008U,
    LINEADDRESSTYPE_IPADDRESS        = 0x00000010U,
}

enum : uint
{
    LINEADDRFEATURE_FORWARD         = 0x00000001U,
    LINEADDRFEATURE_MAKECALL        = 0x00000002U,
    LINEADDRFEATURE_PICKUP          = 0x00000004U,
    LINEADDRFEATURE_SETMEDIACONTROL = 0x00000008U,
    LINEADDRFEATURE_SETTERMINAL     = 0x00000010U,
    LINEADDRFEATURE_SETUPCONF       = 0x00000020U,
    LINEADDRFEATURE_UNCOMPLETECALL  = 0x00000040U,
    LINEADDRFEATURE_UNPARK          = 0x00000080U,
    LINEADDRFEATURE_PICKUPHELD      = 0x00000100U,
    LINEADDRFEATURE_PICKUPGROUP     = 0x00000200U,
    LINEADDRFEATURE_PICKUPDIRECT    = 0x00000400U,
    LINEADDRFEATURE_PICKUPWAITING   = 0x00000800U,
    LINEADDRFEATURE_FORWARDFWD      = 0x00001000U,
    LINEADDRFEATURE_FORWARDDND      = 0x00002000U,
}

enum : uint
{
    LINEAGENTFEATURE_SETAGENTGROUP        = 0x00000001U,
    LINEAGENTFEATURE_SETAGENTSTATE        = 0x00000002U,
    LINEAGENTFEATURE_SETAGENTACTIVITY     = 0x00000004U,
    LINEAGENTFEATURE_AGENTSPECIFIC        = 0x00000008U,
    LINEAGENTFEATURE_GETAGENTACTIVITYLIST = 0x00000010U,
    LINEAGENTFEATURE_GETAGENTGROUP        = 0x00000020U,
}

enum : uint
{
    LINEAGENTSTATE_LOGGEDOFF        = 0x00000001U,
    LINEAGENTSTATE_NOTREADY         = 0x00000002U,
    LINEAGENTSTATE_READY            = 0x00000004U,
    LINEAGENTSTATE_BUSYACD          = 0x00000008U,
    LINEAGENTSTATE_BUSYINCOMING     = 0x00000010U,
    LINEAGENTSTATE_BUSYOUTBOUND     = 0x00000020U,
    LINEAGENTSTATE_BUSYOTHER        = 0x00000040U,
    LINEAGENTSTATE_WORKINGAFTERCALL = 0x00000080U,
    LINEAGENTSTATE_UNKNOWN          = 0x00000100U,
    LINEAGENTSTATE_UNAVAIL          = 0x00000200U,
    LINEAGENTSTATUS_GROUP           = 0x00000001U,
    LINEAGENTSTATUS_STATE           = 0x00000002U,
    LINEAGENTSTATUS_NEXTSTATE       = 0x00000004U,
    LINEAGENTSTATUS_ACTIVITY        = 0x00000008U,
    LINEAGENTSTATUS_ACTIVITYLIST    = 0x00000010U,
    LINEAGENTSTATUS_GROUPLIST       = 0x00000020U,
    LINEAGENTSTATUS_CAPSCHANGE      = 0x00000040U,
    LINEAGENTSTATUS_VALIDSTATES     = 0x00000080U,
    LINEAGENTSTATUS_VALIDNEXTSTATES = 0x00000100U,
    LINEAGENTSTATEEX_NOTREADY       = 0x00000001U,
    LINEAGENTSTATEEX_READY          = 0x00000002U,
    LINEAGENTSTATEEX_BUSYACD        = 0x00000004U,
    LINEAGENTSTATEEX_BUSYINCOMING   = 0x00000008U,
    LINEAGENTSTATEEX_BUSYOUTGOING   = 0x00000010U,
    LINEAGENTSTATEEX_UNKNOWN        = 0x00000020U,
    LINEAGENTSTATEEX_RELEASED       = 0x00000040U,
    LINEAGENTSTATUSEX_NEWAGENT      = 0x00000001U,
    LINEAGENTSTATUSEX_STATE         = 0x00000002U,
    LINEAGENTSTATUSEX_UPDATEINFO    = 0x00000004U,
}

enum : uint
{
    LINEAGENTSESSIONSTATE_NOTREADY    = 0x00000001U,
    LINEAGENTSESSIONSTATE_READY       = 0x00000002U,
    LINEAGENTSESSIONSTATE_BUSYONCALL  = 0x00000004U,
    LINEAGENTSESSIONSTATE_BUSYWRAPUP  = 0x00000008U,
    LINEAGENTSESSIONSTATE_ENDED       = 0x00000010U,
    LINEAGENTSESSIONSTATE_RELEASED    = 0x00000020U,
    LINEAGENTSESSIONSTATUS_NEWSESSION = 0x00000001U,
    LINEAGENTSESSIONSTATUS_STATE      = 0x00000002U,
    LINEAGENTSESSIONSTATUS_UPDATEINFO = 0x00000004U,
}

enum : uint
{
    LINEQUEUESTATUS_UPDATEINFO   = 0x00000001U,
    LINEQUEUESTATUS_NEWQUEUE     = 0x00000002U,
    LINEQUEUESTATUS_QUEUEREMOVED = 0x00000004U,
}

enum : uint
{
    LINEGROUPSTATUS_NEWGROUP     = 0x00000001U,
    LINEGROUPSTATUS_GROUPREMOVED = 0x00000002U,
}

enum : uint
{
    LINEPROXYSTATUS_OPEN          = 0x00000001U,
    LINEPROXYSTATUS_CLOSE         = 0x00000002U,
    LINEPROXYSTATUS_ALLOPENFORACD = 0x00000004U,
}

enum : uint
{
    LINEANSWERMODE_NONE = 0x00000001U,
    LINEANSWERMODE_DROP = 0x00000002U,
    LINEANSWERMODE_HOLD = 0x00000004U,
}

enum : uint
{
    LINEBEARERMODE_VOICE            = 0x00000001U,
    LINEBEARERMODE_SPEECH           = 0x00000002U,
    LINEBEARERMODE_MULTIUSE         = 0x00000004U,
    LINEBEARERMODE_DATA             = 0x00000008U,
    LINEBEARERMODE_ALTSPEECHDATA    = 0x00000010U,
    LINEBEARERMODE_NONCALLSIGNALING = 0x00000020U,
    LINEBEARERMODE_PASSTHROUGH      = 0x00000040U,
    LINEBEARERMODE_RESTRICTEDDATA   = 0x00000080U,
}

enum : uint
{
    LINEBUSYMODE_STATION = 0x00000001U,
    LINEBUSYMODE_TRUNK   = 0x00000002U,
    LINEBUSYMODE_UNKNOWN = 0x00000004U,
    LINEBUSYMODE_UNAVAIL = 0x00000008U,
}

enum : uint
{
    LINECALLCOMPLCOND_BUSY     = 0x00000001U,
    LINECALLCOMPLCOND_NOANSWER = 0x00000002U,
    LINECALLCOMPLMODE_CAMPON   = 0x00000001U,
    LINECALLCOMPLMODE_CALLBACK = 0x00000002U,
    LINECALLCOMPLMODE_INTRUDE  = 0x00000004U,
    LINECALLCOMPLMODE_MESSAGE  = 0x00000008U,
}

enum : uint
{
    LINECALLFEATURE_ACCEPT              = 0x00000001U,
    LINECALLFEATURE_ADDTOCONF           = 0x00000002U,
    LINECALLFEATURE_ANSWER              = 0x00000004U,
    LINECALLFEATURE_BLINDTRANSFER       = 0x00000008U,
    LINECALLFEATURE_COMPLETECALL        = 0x00000010U,
    LINECALLFEATURE_COMPLETETRANSF      = 0x00000020U,
    LINECALLFEATURE_DIAL                = 0x00000040U,
    LINECALLFEATURE_DROP                = 0x00000080U,
    LINECALLFEATURE_GATHERDIGITS        = 0x00000100U,
    LINECALLFEATURE_GENERATEDIGITS      = 0x00000200U,
    LINECALLFEATURE_GENERATETONE        = 0x00000400U,
    LINECALLFEATURE_HOLD                = 0x00000800U,
    LINECALLFEATURE_MONITORDIGITS       = 0x00001000U,
    LINECALLFEATURE_MONITORMEDIA        = 0x00002000U,
    LINECALLFEATURE_MONITORTONES        = 0x00004000U,
    LINECALLFEATURE_PARK                = 0x00008000U,
    LINECALLFEATURE_PREPAREADDCONF      = 0x00010000U,
    LINECALLFEATURE_REDIRECT            = 0x00020000U,
    LINECALLFEATURE_REMOVEFROMCONF      = 0x00040000U,
    LINECALLFEATURE_SECURECALL          = 0x00080000U,
    LINECALLFEATURE_SENDUSERUSER        = 0x00100000U,
    LINECALLFEATURE_SETCALLPARAMS       = 0x00200000U,
    LINECALLFEATURE_SETMEDIACONTROL     = 0x00400000U,
    LINECALLFEATURE_SETTERMINAL         = 0x00800000U,
    LINECALLFEATURE_SETUPCONF           = 0x01000000U,
    LINECALLFEATURE_SETUPTRANSFER       = 0x02000000U,
    LINECALLFEATURE_SWAPHOLD            = 0x04000000U,
    LINECALLFEATURE_UNHOLD              = 0x08000000U,
    LINECALLFEATURE_RELEASEUSERUSERINFO = 0x10000000U,
    LINECALLFEATURE_SETTREATMENT        = 0x20000000U,
    LINECALLFEATURE_SETQOS              = 0x40000000U,
    LINECALLFEATURE_SETCALLDATA         = 0x80000000U,
    LINECALLFEATURE2_NOHOLDCONFERENCE   = 0x00000001U,
    LINECALLFEATURE2_ONESTEPTRANSFER    = 0x00000002U,
    LINECALLFEATURE2_COMPLCAMPON        = 0x00000004U,
    LINECALLFEATURE2_COMPLCALLBACK      = 0x00000008U,
    LINECALLFEATURE2_COMPLINTRUDE       = 0x00000010U,
    LINECALLFEATURE2_COMPLMESSAGE       = 0x00000020U,
    LINECALLFEATURE2_TRANSFERNORM       = 0x00000040U,
    LINECALLFEATURE2_TRANSFERCONF       = 0x00000080U,
    LINECALLFEATURE2_PARKDIRECT         = 0x00000100U,
    LINECALLFEATURE2_PARKNONDIRECT      = 0x00000200U,
}

enum : uint
{
    LINECALLHUBTRACKING_NONE          = 0x00000000U,
    LINECALLHUBTRACKING_PROVIDERLEVEL = 0x00000001U,
    LINECALLHUBTRACKING_ALLCALLS      = 0x00000002U,
}

enum : uint
{
    LINECALLINFOSTATE_OTHER         = 0x00000001U,
    LINECALLINFOSTATE_DEVSPECIFIC   = 0x00000002U,
    LINECALLINFOSTATE_BEARERMODE    = 0x00000004U,
    LINECALLINFOSTATE_RATE          = 0x00000008U,
    LINECALLINFOSTATE_MEDIAMODE     = 0x00000010U,
    LINECALLINFOSTATE_APPSPECIFIC   = 0x00000020U,
    LINECALLINFOSTATE_CALLID        = 0x00000040U,
    LINECALLINFOSTATE_RELATEDCALLID = 0x00000080U,
    LINECALLINFOSTATE_ORIGIN        = 0x00000100U,
    LINECALLINFOSTATE_REASON        = 0x00000200U,
    LINECALLINFOSTATE_COMPLETIONID  = 0x00000400U,
    LINECALLINFOSTATE_NUMOWNERINCR  = 0x00000800U,
    LINECALLINFOSTATE_NUMOWNERDECR  = 0x00001000U,
    LINECALLINFOSTATE_NUMMONITORS   = 0x00002000U,
    LINECALLINFOSTATE_TRUNK         = 0x00004000U,
    LINECALLINFOSTATE_CALLERID      = 0x00008000U,
    LINECALLINFOSTATE_CALLEDID      = 0x00010000U,
    LINECALLINFOSTATE_CONNECTEDID   = 0x00020000U,
    LINECALLINFOSTATE_REDIRECTIONID = 0x00040000U,
    LINECALLINFOSTATE_REDIRECTINGID = 0x00080000U,
    LINECALLINFOSTATE_DISPLAY       = 0x00100000U,
    LINECALLINFOSTATE_USERUSERINFO  = 0x00200000U,
    LINECALLINFOSTATE_HIGHLEVELCOMP = 0x00400000U,
    LINECALLINFOSTATE_LOWLEVELCOMP  = 0x00800000U,
    LINECALLINFOSTATE_CHARGINGINFO  = 0x01000000U,
    LINECALLINFOSTATE_TERMINAL      = 0x02000000U,
    LINECALLINFOSTATE_DIALPARAMS    = 0x04000000U,
    LINECALLINFOSTATE_MONITORMODES  = 0x08000000U,
    LINECALLINFOSTATE_TREATMENT     = 0x10000000U,
    LINECALLINFOSTATE_QOS           = 0x20000000U,
    LINECALLINFOSTATE_CALLDATA      = 0x40000000U,
}

enum : uint
{
    LINECALLORIGIN_OUTBOUND   = 0x00000001U,
    LINECALLORIGIN_INTERNAL   = 0x00000002U,
    LINECALLORIGIN_EXTERNAL   = 0x00000004U,
    LINECALLORIGIN_UNKNOWN    = 0x00000010U,
    LINECALLORIGIN_UNAVAIL    = 0x00000020U,
    LINECALLORIGIN_CONFERENCE = 0x00000040U,
    LINECALLORIGIN_INBOUND    = 0x00000080U,
}

enum : uint
{
    LINECALLPARAMFLAGS_SECURE           = 0x00000001U,
    LINECALLPARAMFLAGS_IDLE             = 0x00000002U,
    LINECALLPARAMFLAGS_BLOCKID          = 0x00000004U,
    LINECALLPARAMFLAGS_ORIGOFFHOOK      = 0x00000008U,
    LINECALLPARAMFLAGS_DESTOFFHOOK      = 0x00000010U,
    LINECALLPARAMFLAGS_NOHOLDCONFERENCE = 0x00000020U,
    LINECALLPARAMFLAGS_PREDICTIVEDIAL   = 0x00000040U,
    LINECALLPARAMFLAGS_ONESTEPTRANSFER  = 0x00000080U,
}

enum : uint
{
    LINECALLPARTYID_BLOCKED   = 0x00000001U,
    LINECALLPARTYID_OUTOFAREA = 0x00000002U,
    LINECALLPARTYID_NAME      = 0x00000004U,
    LINECALLPARTYID_ADDRESS   = 0x00000008U,
    LINECALLPARTYID_PARTIAL   = 0x00000010U,
    LINECALLPARTYID_UNKNOWN   = 0x00000020U,
    LINECALLPARTYID_UNAVAIL   = 0x00000040U,
}

enum : uint
{
    LINECALLPRIVILEGE_NONE    = 0x00000001U,
    LINECALLPRIVILEGE_MONITOR = 0x00000002U,
    LINECALLPRIVILEGE_OWNER   = 0x00000004U,
}

enum : uint
{
    LINECALLREASON_DIRECT         = 0x00000001U,
    LINECALLREASON_FWDBUSY        = 0x00000002U,
    LINECALLREASON_FWDNOANSWER    = 0x00000004U,
    LINECALLREASON_FWDUNCOND      = 0x00000008U,
    LINECALLREASON_PICKUP         = 0x00000010U,
    LINECALLREASON_UNPARK         = 0x00000020U,
    LINECALLREASON_REDIRECT       = 0x00000040U,
    LINECALLREASON_CALLCOMPLETION = 0x00000080U,
    LINECALLREASON_TRANSFER       = 0x00000100U,
    LINECALLREASON_REMINDER       = 0x00000200U,
    LINECALLREASON_UNKNOWN        = 0x00000400U,
    LINECALLREASON_UNAVAIL        = 0x00000800U,
    LINECALLREASON_INTRUDE        = 0x00001000U,
    LINECALLREASON_PARKED         = 0x00002000U,
    LINECALLREASON_CAMPEDON       = 0x00004000U,
    LINECALLREASON_ROUTEREQUEST   = 0x00008000U,
}

enum : uint
{
    LINECALLSELECT_LINE              = 0x00000001U,
    LINECALLSELECT_ADDRESS           = 0x00000002U,
    LINECALLSELECT_CALL              = 0x00000004U,
    LINECALLSELECT_DEVICEID          = 0x00000008U,
    LINECALLSELECT_CALLID            = 0x00000010U,
    LINECALLSTATE_IDLE               = 0x00000001U,
    LINECALLSTATE_OFFERING           = 0x00000002U,
    LINECALLSTATE_ACCEPTED           = 0x00000004U,
    LINECALLSTATE_DIALTONE           = 0x00000008U,
    LINECALLSTATE_DIALING            = 0x00000010U,
    LINECALLSTATE_RINGBACK           = 0x00000020U,
    LINECALLSTATE_BUSY               = 0x00000040U,
    LINECALLSTATE_SPECIALINFO        = 0x00000080U,
    LINECALLSTATE_CONNECTED          = 0x00000100U,
    LINECALLSTATE_PROCEEDING         = 0x00000200U,
    LINECALLSTATE_ONHOLD             = 0x00000400U,
    LINECALLSTATE_CONFERENCED        = 0x00000800U,
    LINECALLSTATE_ONHOLDPENDCONF     = 0x00001000U,
    LINECALLSTATE_ONHOLDPENDTRANSFER = 0x00002000U,
    LINECALLSTATE_DISCONNECTED       = 0x00004000U,
    LINECALLSTATE_UNKNOWN            = 0x00008000U,
}

enum : uint
{
    LINECALLTREATMENT_SILENCE  = 0x00000001U,
    LINECALLTREATMENT_RINGBACK = 0x00000002U,
    LINECALLTREATMENT_BUSY     = 0x00000003U,
    LINECALLTREATMENT_MUSIC    = 0x00000004U,
}

enum : uint
{
    LINECARDOPTION_PREDEFINED = 0x00000001U,
    LINECARDOPTION_HIDDEN     = 0x00000002U,
}

enum : uint
{
    LINECONNECTEDMODE_ACTIVE       = 0x00000001U,
    LINECONNECTEDMODE_INACTIVE     = 0x00000002U,
    LINECONNECTEDMODE_ACTIVEHELD   = 0x00000004U,
    LINECONNECTEDMODE_INACTIVEHELD = 0x00000008U,
    LINECONNECTEDMODE_CONFIRMED    = 0x00000010U,
}

enum : uint
{
    LINEDEVCAPFLAGS_CROSSADDRCONF   = 0x00000001U,
    LINEDEVCAPFLAGS_HIGHLEVCOMP     = 0x00000002U,
    LINEDEVCAPFLAGS_LOWLEVCOMP      = 0x00000004U,
    LINEDEVCAPFLAGS_MEDIACONTROL    = 0x00000008U,
    LINEDEVCAPFLAGS_MULTIPLEADDR    = 0x00000010U,
    LINEDEVCAPFLAGS_CLOSEDROP       = 0x00000020U,
    LINEDEVCAPFLAGS_DIALBILLING     = 0x00000040U,
    LINEDEVCAPFLAGS_DIALQUIET       = 0x00000080U,
    LINEDEVCAPFLAGS_DIALDIALTONE    = 0x00000100U,
    LINEDEVCAPFLAGS_MSP             = 0x00000200U,
    LINEDEVCAPFLAGS_CALLHUB         = 0x00000400U,
    LINEDEVCAPFLAGS_CALLHUBTRACKING = 0x00000800U,
    LINEDEVCAPFLAGS_PRIVATEOBJECTS  = 0x00001000U,
    LINEDEVCAPFLAGS_LOCAL           = 0x00002000U,
}

enum : uint
{
    LINEDEVSTATE_OTHER           = 0x00000001U,
    LINEDEVSTATE_RINGING         = 0x00000002U,
    LINEDEVSTATE_CONNECTED       = 0x00000004U,
    LINEDEVSTATE_DISCONNECTED    = 0x00000008U,
    LINEDEVSTATE_MSGWAITON       = 0x00000010U,
    LINEDEVSTATE_MSGWAITOFF      = 0x00000020U,
    LINEDEVSTATE_INSERVICE       = 0x00000040U,
    LINEDEVSTATE_OUTOFSERVICE    = 0x00000080U,
    LINEDEVSTATE_MAINTENANCE     = 0x00000100U,
    LINEDEVSTATE_OPEN            = 0x00000200U,
    LINEDEVSTATE_CLOSE           = 0x00000400U,
    LINEDEVSTATE_NUMCALLS        = 0x00000800U,
    LINEDEVSTATE_NUMCOMPLETIONS  = 0x00001000U,
    LINEDEVSTATE_TERMINALS       = 0x00002000U,
    LINEDEVSTATE_ROAMMODE        = 0x00004000U,
    LINEDEVSTATE_BATTERY         = 0x00008000U,
    LINEDEVSTATE_SIGNAL          = 0x00010000U,
    LINEDEVSTATE_DEVSPECIFIC     = 0x00020000U,
    LINEDEVSTATE_REINIT          = 0x00040000U,
    LINEDEVSTATE_LOCK            = 0x00080000U,
    LINEDEVSTATE_CAPSCHANGE      = 0x00100000U,
    LINEDEVSTATE_CONFIGCHANGE    = 0x00200000U,
    LINEDEVSTATE_TRANSLATECHANGE = 0x00400000U,
    LINEDEVSTATE_COMPLCANCEL     = 0x00800000U,
    LINEDEVSTATE_REMOVED         = 0x01000000U,
    LINEDEVSTATUSFLAGS_CONNECTED = 0x00000001U,
    LINEDEVSTATUSFLAGS_MSGWAIT   = 0x00000002U,
    LINEDEVSTATUSFLAGS_INSERVICE = 0x00000004U,
    LINEDEVSTATUSFLAGS_LOCKED    = 0x00000008U,
}

enum : uint
{
    LINEDIALTONEMODE_NORMAL   = 0x00000001U,
    LINEDIALTONEMODE_SPECIAL  = 0x00000002U,
    LINEDIALTONEMODE_INTERNAL = 0x00000004U,
    LINEDIALTONEMODE_EXTERNAL = 0x00000008U,
    LINEDIALTONEMODE_UNKNOWN  = 0x00000010U,
    LINEDIALTONEMODE_UNAVAIL  = 0x00000020U,
}

enum : uint
{
    LINEDIGITMODE_PULSE   = 0x00000001U,
    LINEDIGITMODE_DTMF    = 0x00000002U,
    LINEDIGITMODE_DTMFEND = 0x00000004U,
}

enum : uint
{
    LINEDISCONNECTMODE_NORMAL            = 0x00000001U,
    LINEDISCONNECTMODE_UNKNOWN           = 0x00000002U,
    LINEDISCONNECTMODE_REJECT            = 0x00000004U,
    LINEDISCONNECTMODE_PICKUP            = 0x00000008U,
    LINEDISCONNECTMODE_FORWARDED         = 0x00000010U,
    LINEDISCONNECTMODE_BUSY              = 0x00000020U,
    LINEDISCONNECTMODE_NOANSWER          = 0x00000040U,
    LINEDISCONNECTMODE_BADADDRESS        = 0x00000080U,
    LINEDISCONNECTMODE_UNREACHABLE       = 0x00000100U,
    LINEDISCONNECTMODE_CONGESTION        = 0x00000200U,
    LINEDISCONNECTMODE_INCOMPATIBLE      = 0x00000400U,
    LINEDISCONNECTMODE_UNAVAIL           = 0x00000800U,
    LINEDISCONNECTMODE_NODIALTONE        = 0x00001000U,
    LINEDISCONNECTMODE_NUMBERCHANGED     = 0x00002000U,
    LINEDISCONNECTMODE_OUTOFORDER        = 0x00004000U,
    LINEDISCONNECTMODE_TEMPFAILURE       = 0x00008000U,
    LINEDISCONNECTMODE_QOSUNAVAIL        = 0x00010000U,
    LINEDISCONNECTMODE_BLOCKED           = 0x00020000U,
    LINEDISCONNECTMODE_DONOTDISTURB      = 0x00040000U,
    LINEDISCONNECTMODE_CANCELLED         = 0x00080000U,
    LINEDISCONNECTMODE_DESTINATIONBARRED = 0x00100000U,
    LINEDISCONNECTMODE_FDNRESTRICT       = 0x00200000U,
}

enum : uint
{
    LINEERR_ALLOCATED         = 0x80000001U,
    LINEERR_BADDEVICEID       = 0x80000002U,
    LINEERR_BEARERMODEUNAVAIL = 0x80000003U,
}

enum : uint
{
    LINEERR_CALLUNAVAIL       = 0x80000005U,
    LINEERR_COMPLETIONOVERRUN = 0x80000006U,
}

enum uint LINEERR_CONFERENCEFULL = 0x80000007U;

enum : uint
{
    LINEERR_DIALBILLING            = 0x80000008U,
    LINEERR_DIALDIALTONE           = 0x80000009U,
    LINEERR_DIALPROMPT             = 0x8000000aU,
    LINEERR_DIALQUIET              = 0x8000000bU,
    LINEERR_INCOMPATIBLEAPIVERSION = 0x8000000cU,
    LINEERR_INCOMPATIBLEEXTVERSION = 0x8000000dU,
}

enum : uint
{
    LINEERR_INIFILECORRUPT         = 0x8000000eU,
    LINEERR_INUSE                  = 0x8000000fU,
    LINEERR_INVALADDRESS           = 0x80000010U,
    LINEERR_INVALADDRESSID         = 0x80000011U,
    LINEERR_INVALADDRESSMODE       = 0x80000012U,
    LINEERR_INVALADDRESSSTATE      = 0x80000013U,
    LINEERR_INVALAPPHANDLE         = 0x80000014U,
    LINEERR_INVALAPPNAME           = 0x80000015U,
    LINEERR_INVALBEARERMODE        = 0x80000016U,
    LINEERR_INVALCALLCOMPLMODE     = 0x80000017U,
    LINEERR_INVALCALLHANDLE        = 0x80000018U,
    LINEERR_INVALCALLPARAMS        = 0x80000019U,
    LINEERR_INVALCALLPRIVILEGE     = 0x8000001aU,
    LINEERR_INVALCALLSELECT        = 0x8000001bU,
    LINEERR_INVALCALLSTATE         = 0x8000001cU,
    LINEERR_INVALCALLSTATELIST     = 0x8000001dU,
    LINEERR_INVALCARD              = 0x8000001eU,
    LINEERR_INVALCOMPLETIONID      = 0x8000001fU,
    LINEERR_INVALCONFCALLHANDLE    = 0x80000020U,
    LINEERR_INVALCONSULTCALLHANDLE = 0x80000021U,
    LINEERR_INVALCOUNTRYCODE       = 0x80000022U,
    LINEERR_INVALDEVICECLASS       = 0x80000023U,
    LINEERR_INVALDEVICEHANDLE      = 0x80000024U,
    LINEERR_INVALDIALPARAMS        = 0x80000025U,
    LINEERR_INVALDIGITLIST         = 0x80000026U,
    LINEERR_INVALDIGITMODE         = 0x80000027U,
    LINEERR_INVALDIGITS            = 0x80000028U,
    LINEERR_INVALEXTVERSION        = 0x80000029U,
    LINEERR_INVALGROUPID           = 0x8000002aU,
    LINEERR_INVALLINEHANDLE        = 0x8000002bU,
    LINEERR_INVALLINESTATE         = 0x8000002cU,
    LINEERR_INVALLOCATION          = 0x8000002dU,
    LINEERR_INVALMEDIALIST         = 0x8000002eU,
    LINEERR_INVALMEDIAMODE         = 0x8000002fU,
    LINEERR_INVALMESSAGEID         = 0x80000030U,
    LINEERR_INVALPARAM             = 0x80000032U,
    LINEERR_INVALPARKID            = 0x80000033U,
    LINEERR_INVALPARKMODE          = 0x80000034U,
    LINEERR_INVALPOINTER           = 0x80000035U,
    LINEERR_INVALPRIVSELECT        = 0x80000036U,
    LINEERR_INVALRATE              = 0x80000037U,
    LINEERR_INVALREQUESTMODE       = 0x80000038U,
    LINEERR_INVALTERMINALID        = 0x80000039U,
    LINEERR_INVALTERMINALMODE      = 0x8000003aU,
    LINEERR_INVALTIMEOUT           = 0x8000003bU,
    LINEERR_INVALTONE              = 0x8000003cU,
    LINEERR_INVALTONELIST          = 0x8000003dU,
    LINEERR_INVALTONEMODE          = 0x8000003eU,
    LINEERR_INVALTRANSFERMODE      = 0x8000003fU,
}

enum uint LINEERR_LINEMAPPERFAILED = 0x80000040U;

enum : uint
{
    LINEERR_NOCONFERENCE  = 0x80000041U,
    LINEERR_NODEVICE      = 0x80000042U,
    LINEERR_NODRIVER      = 0x80000043U,
    LINEERR_NOMEM         = 0x80000044U,
    LINEERR_NOREQUEST     = 0x80000045U,
    LINEERR_NOTOWNER      = 0x80000046U,
    LINEERR_NOTREGISTERED = 0x80000047U,
}

enum : uint
{
    LINEERR_OPERATIONFAILED  = 0x80000048U,
    LINEERR_OPERATIONUNAVAIL = 0x80000049U,
}

enum : uint
{
    LINEERR_RATEUNAVAIL     = 0x8000004aU,
    LINEERR_RESOURCEUNAVAIL = 0x8000004bU,
    LINEERR_REQUESTOVERRUN  = 0x8000004cU,
}

enum uint LINEERR_STRUCTURETOOSMALL = 0x8000004dU;

enum : uint
{
    LINEERR_TARGETNOTFOUND     = 0x8000004eU,
    LINEERR_TARGETSELF         = 0x8000004fU,
    LINEERR_UNINITIALIZED      = 0x80000050U,
    LINEERR_USERUSERINFOTOOBIG = 0x80000051U,
}

enum : uint
{
    LINEERR_REINIT         = 0x80000052U,
    LINEERR_ADDRESSBLOCKED = 0x80000053U,
}

enum uint LINEERR_BILLINGREJECTED = 0x80000054U;
enum uint LINEERR_INVALFEATURE = 0x80000055U;
enum uint LINEERR_NOMULTIPLEINSTANCE = 0x80000056U;

enum : uint
{
    LINEERR_INVALAGENTID       = 0x80000057U,
    LINEERR_INVALAGENTGROUP    = 0x80000058U,
    LINEERR_INVALPASSWORD      = 0x80000059U,
    LINEERR_INVALAGENTSTATE    = 0x8000005aU,
    LINEERR_INVALAGENTACTIVITY = 0x8000005bU,
}

enum uint LINEERR_DIALVOICEDETECT = 0x8000005cU;
enum uint LINEERR_USERCANCELLED = 0x8000005dU;

enum : uint
{
    LINEERR_INVALADDRESSTYPE       = 0x8000005eU,
    LINEERR_INVALAGENTSESSIONSTATE = 0x8000005fU,
}

enum uint LINEERR_DISCONNECTED = 0x80000060U;
enum uint LINEERR_SERVICE_NOT_RUNNING = 0x80000061U;

enum : uint
{
    LINEFEATURE_DEVSPECIFIC     = 0x00000001U,
    LINEFEATURE_DEVSPECIFICFEAT = 0x00000002U,
    LINEFEATURE_FORWARD         = 0x00000004U,
    LINEFEATURE_MAKECALL        = 0x00000008U,
    LINEFEATURE_SETMEDIACONTROL = 0x00000010U,
    LINEFEATURE_SETTERMINAL     = 0x00000020U,
    LINEFEATURE_SETDEVSTATUS    = 0x00000040U,
    LINEFEATURE_FORWARDFWD      = 0x00000080U,
    LINEFEATURE_FORWARDDND      = 0x00000100U,
}

enum : uint
{
    LINEFORWARDMODE_UNCOND         = 0x00000001U,
    LINEFORWARDMODE_UNCONDINTERNAL = 0x00000002U,
    LINEFORWARDMODE_UNCONDEXTERNAL = 0x00000004U,
    LINEFORWARDMODE_UNCONDSPECIFIC = 0x00000008U,
    LINEFORWARDMODE_BUSY           = 0x00000010U,
    LINEFORWARDMODE_BUSYINTERNAL   = 0x00000020U,
    LINEFORWARDMODE_BUSYEXTERNAL   = 0x00000040U,
    LINEFORWARDMODE_BUSYSPECIFIC   = 0x00000080U,
    LINEFORWARDMODE_NOANSW         = 0x00000100U,
    LINEFORWARDMODE_NOANSWINTERNAL = 0x00000200U,
    LINEFORWARDMODE_NOANSWEXTERNAL = 0x00000400U,
    LINEFORWARDMODE_NOANSWSPECIFIC = 0x00000800U,
    LINEFORWARDMODE_BUSYNA         = 0x00001000U,
    LINEFORWARDMODE_BUSYNAINTERNAL = 0x00002000U,
    LINEFORWARDMODE_BUSYNAEXTERNAL = 0x00004000U,
    LINEFORWARDMODE_BUSYNASPECIFIC = 0x00008000U,
    LINEFORWARDMODE_UNKNOWN        = 0x00010000U,
    LINEFORWARDMODE_UNAVAIL        = 0x00020000U,
}

enum : uint
{
    LINEGATHERTERM_BUFFERFULL   = 0x00000001U,
    LINEGATHERTERM_TERMDIGIT    = 0x00000002U,
    LINEGATHERTERM_FIRSTTIMEOUT = 0x00000004U,
    LINEGATHERTERM_INTERTIMEOUT = 0x00000008U,
    LINEGATHERTERM_CANCEL       = 0x00000010U,
}

enum : uint
{
    LINEGENERATETERM_DONE   = 0x00000001U,
    LINEGENERATETERM_CANCEL = 0x00000002U,
}

enum : uint
{
    LINEINITIALIZEEXOPTION_USEHIDDENWINDOW   = 0x00000001U,
    LINEINITIALIZEEXOPTION_USEEVENT          = 0x00000002U,
    LINEINITIALIZEEXOPTION_USECOMPLETIONPORT = 0x00000003U,
    LINEINITIALIZEEXOPTION_CALLHUBTRACKING   = 0x80000000U,
}

enum uint LINELOCATIONOPTION_PULSEDIAL = 0x00000001U;

enum : uint
{
    LINEMAPPER                    = 0xffffffffU,
    LINEMEDIACONTROL_NONE         = 0x00000001U,
    LINEMEDIACONTROL_START        = 0x00000002U,
    LINEMEDIACONTROL_RESET        = 0x00000004U,
    LINEMEDIACONTROL_PAUSE        = 0x00000008U,
    LINEMEDIACONTROL_RESUME       = 0x00000010U,
    LINEMEDIACONTROL_RATEUP       = 0x00000020U,
    LINEMEDIACONTROL_RATEDOWN     = 0x00000040U,
    LINEMEDIACONTROL_RATENORMAL   = 0x00000080U,
    LINEMEDIACONTROL_VOLUMEUP     = 0x00000100U,
    LINEMEDIACONTROL_VOLUMEDOWN   = 0x00000200U,
    LINEMEDIACONTROL_VOLUMENORMAL = 0x00000400U,
}

enum : uint
{
    LINEMEDIAMODE_UNKNOWN          = 0x00000002U,
    LINEMEDIAMODE_INTERACTIVEVOICE = 0x00000004U,
    LINEMEDIAMODE_AUTOMATEDVOICE   = 0x00000008U,
    LINEMEDIAMODE_DATAMODEM        = 0x00000010U,
    LINEMEDIAMODE_G3FAX            = 0x00000020U,
    LINEMEDIAMODE_TDD              = 0x00000040U,
    LINEMEDIAMODE_G4FAX            = 0x00000080U,
    LINEMEDIAMODE_DIGITALDATA      = 0x00000100U,
    LINEMEDIAMODE_TELETEX          = 0x00000200U,
    LINEMEDIAMODE_VIDEOTEX         = 0x00000400U,
    LINEMEDIAMODE_TELEX            = 0x00000800U,
    LINEMEDIAMODE_MIXED            = 0x00001000U,
    LINEMEDIAMODE_ADSI             = 0x00002000U,
    LINEMEDIAMODE_VOICEVIEW        = 0x00004000U,
    LINEMEDIAMODE_VIDEO            = 0x00008000U,
}

enum uint LAST_LINEMEDIAMODE = 0x00008000U;

enum : uint
{
    LINEOFFERINGMODE_ACTIVE   = 0x00000001U,
    LINEOFFERINGMODE_INACTIVE = 0x00000002U,
}

enum : uint
{
    LINEOPENOPTION_SINGLEADDRESS = 0x80000000U,
    LINEOPENOPTION_PROXY         = 0x40000000U,
}

enum : uint
{
    LINEPARKMODE_DIRECTED    = 0x00000001U,
    LINEPARKMODE_NONDIRECTED = 0x00000002U,
}

enum : uint
{
    LINEPROXYREQUEST_SETAGENTGROUP             = 0x00000001U,
    LINEPROXYREQUEST_SETAGENTSTATE             = 0x00000002U,
    LINEPROXYREQUEST_SETAGENTACTIVITY          = 0x00000003U,
    LINEPROXYREQUEST_GETAGENTCAPS              = 0x00000004U,
    LINEPROXYREQUEST_GETAGENTSTATUS            = 0x00000005U,
    LINEPROXYREQUEST_AGENTSPECIFIC             = 0x00000006U,
    LINEPROXYREQUEST_GETAGENTACTIVITYLIST      = 0x00000007U,
    LINEPROXYREQUEST_GETAGENTGROUPLIST         = 0x00000008U,
    LINEPROXYREQUEST_CREATEAGENT               = 0x00000009U,
    LINEPROXYREQUEST_SETAGENTMEASUREMENTPERIOD = 0x0000000aU,
    LINEPROXYREQUEST_GETAGENTINFO              = 0x0000000bU,
    LINEPROXYREQUEST_CREATEAGENTSESSION        = 0x0000000cU,
    LINEPROXYREQUEST_GETAGENTSESSIONLIST       = 0x0000000dU,
    LINEPROXYREQUEST_SETAGENTSESSIONSTATE      = 0x0000000eU,
    LINEPROXYREQUEST_GETAGENTSESSIONINFO       = 0x0000000fU,
    LINEPROXYREQUEST_GETQUEUELIST              = 0x00000010U,
    LINEPROXYREQUEST_SETQUEUEMEASUREMENTPERIOD = 0x00000011U,
    LINEPROXYREQUEST_GETQUEUEINFO              = 0x00000012U,
    LINEPROXYREQUEST_GETGROUPLIST              = 0x00000013U,
    LINEPROXYREQUEST_SETAGENTSTATEEX           = 0x00000014U,
}

enum : uint
{
    LINEREMOVEFROMCONF_NONE = 0x00000001U,
    LINEREMOVEFROMCONF_LAST = 0x00000002U,
    LINEREMOVEFROMCONF_ANY  = 0x00000003U,
}

enum : uint
{
    LINEREQUESTMODE_MAKECALL  = 0x00000001U,
    LINEREQUESTMODE_MEDIACALL = 0x00000002U,
    LINEREQUESTMODE_DROP      = 0x00000004U,
}

enum uint LAST_LINEREQUESTMODE = 0x00000002U;

enum : uint
{
    LINEROAMMODE_UNKNOWN = 0x00000001U,
    LINEROAMMODE_UNAVAIL = 0x00000002U,
    LINEROAMMODE_HOME    = 0x00000004U,
    LINEROAMMODE_ROAMA   = 0x00000008U,
    LINEROAMMODE_ROAMB   = 0x00000010U,
}

enum : uint
{
    LINESPECIALINFO_NOCIRCUIT = 0x00000001U,
    LINESPECIALINFO_CUSTIRREG = 0x00000002U,
    LINESPECIALINFO_REORDER   = 0x00000004U,
    LINESPECIALINFO_UNKNOWN   = 0x00000008U,
    LINESPECIALINFO_UNAVAIL   = 0x00000010U,
}

enum : uint
{
    LINETERMDEV_PHONE          = 0x00000001U,
    LINETERMDEV_HEADSET        = 0x00000002U,
    LINETERMDEV_SPEAKER        = 0x00000004U,
    LINETERMMODE_BUTTONS       = 0x00000001U,
    LINETERMMODE_LAMPS         = 0x00000002U,
    LINETERMMODE_DISPLAY       = 0x00000004U,
    LINETERMMODE_RINGER        = 0x00000008U,
    LINETERMMODE_HOOKSWITCH    = 0x00000010U,
    LINETERMMODE_MEDIATOLINE   = 0x00000020U,
    LINETERMMODE_MEDIAFROMLINE = 0x00000040U,
    LINETERMMODE_MEDIABIDIRECT = 0x00000080U,
}

enum : uint
{
    LINETERMSHARING_PRIVATE    = 0x00000001U,
    LINETERMSHARING_SHAREDEXCL = 0x00000002U,
    LINETERMSHARING_SHAREDCONF = 0x00000004U,
}

enum : uint
{
    LINETOLLLISTOPTION_ADD    = 0x00000001U,
    LINETOLLLISTOPTION_REMOVE = 0x00000002U,
}

enum : uint
{
    LINETONEMODE_CUSTOM   = 0x00000001U,
    LINETONEMODE_RINGBACK = 0x00000002U,
    LINETONEMODE_BUSY     = 0x00000004U,
    LINETONEMODE_BEEP     = 0x00000008U,
    LINETONEMODE_BILLING  = 0x00000010U,
}

enum : uint
{
    LINETRANSFERMODE_TRANSFER   = 0x00000001U,
    LINETRANSFERMODE_CONFERENCE = 0x00000002U,
}

enum : uint
{
    LINETRANSLATEOPTION_CARDOVERRIDE      = 0x00000001U,
    LINETRANSLATEOPTION_CANCELCALLWAITING = 0x00000002U,
    LINETRANSLATEOPTION_FORCELOCAL        = 0x00000004U,
    LINETRANSLATEOPTION_FORCELD           = 0x00000008U,
    LINETRANSLATERESULT_CANONICAL         = 0x00000001U,
    LINETRANSLATERESULT_INTERNATIONAL     = 0x00000002U,
    LINETRANSLATERESULT_LONGDISTANCE      = 0x00000004U,
    LINETRANSLATERESULT_LOCAL             = 0x00000008U,
    LINETRANSLATERESULT_INTOLLLIST        = 0x00000010U,
    LINETRANSLATERESULT_NOTINTOLLLIST     = 0x00000020U,
    LINETRANSLATERESULT_DIALBILLING       = 0x00000040U,
    LINETRANSLATERESULT_DIALQUIET         = 0x00000080U,
    LINETRANSLATERESULT_DIALDIALTONE      = 0x00000100U,
    LINETRANSLATERESULT_DIALPROMPT        = 0x00000200U,
    LINETRANSLATERESULT_VOICEDETECT       = 0x00000400U,
    LINETRANSLATERESULT_NOTRANSLATION     = 0x00000800U,
}

enum : uint
{
    PHONEBUTTONFUNCTION_UNKNOWN      = 0x00000000U,
    PHONEBUTTONFUNCTION_CONFERENCE   = 0x00000001U,
    PHONEBUTTONFUNCTION_TRANSFER     = 0x00000002U,
    PHONEBUTTONFUNCTION_DROP         = 0x00000003U,
    PHONEBUTTONFUNCTION_HOLD         = 0x00000004U,
    PHONEBUTTONFUNCTION_RECALL       = 0x00000005U,
    PHONEBUTTONFUNCTION_DISCONNECT   = 0x00000006U,
    PHONEBUTTONFUNCTION_CONNECT      = 0x00000007U,
    PHONEBUTTONFUNCTION_MSGWAITON    = 0x00000008U,
    PHONEBUTTONFUNCTION_MSGWAITOFF   = 0x00000009U,
    PHONEBUTTONFUNCTION_SELECTRING   = 0x0000000aU,
    PHONEBUTTONFUNCTION_ABBREVDIAL   = 0x0000000bU,
    PHONEBUTTONFUNCTION_FORWARD      = 0x0000000cU,
    PHONEBUTTONFUNCTION_PICKUP       = 0x0000000dU,
    PHONEBUTTONFUNCTION_RINGAGAIN    = 0x0000000eU,
    PHONEBUTTONFUNCTION_PARK         = 0x0000000fU,
    PHONEBUTTONFUNCTION_REJECT       = 0x00000010U,
    PHONEBUTTONFUNCTION_REDIRECT     = 0x00000011U,
    PHONEBUTTONFUNCTION_MUTE         = 0x00000012U,
    PHONEBUTTONFUNCTION_VOLUMEUP     = 0x00000013U,
    PHONEBUTTONFUNCTION_VOLUMEDOWN   = 0x00000014U,
    PHONEBUTTONFUNCTION_SPEAKERON    = 0x00000015U,
    PHONEBUTTONFUNCTION_SPEAKEROFF   = 0x00000016U,
    PHONEBUTTONFUNCTION_FLASH        = 0x00000017U,
    PHONEBUTTONFUNCTION_DATAON       = 0x00000018U,
    PHONEBUTTONFUNCTION_DATAOFF      = 0x00000019U,
    PHONEBUTTONFUNCTION_DONOTDISTURB = 0x0000001aU,
    PHONEBUTTONFUNCTION_INTERCOM     = 0x0000001bU,
    PHONEBUTTONFUNCTION_BRIDGEDAPP   = 0x0000001cU,
    PHONEBUTTONFUNCTION_BUSY         = 0x0000001dU,
    PHONEBUTTONFUNCTION_CALLAPP      = 0x0000001eU,
    PHONEBUTTONFUNCTION_DATETIME     = 0x0000001fU,
    PHONEBUTTONFUNCTION_DIRECTORY    = 0x00000020U,
    PHONEBUTTONFUNCTION_COVER        = 0x00000021U,
    PHONEBUTTONFUNCTION_CALLID       = 0x00000022U,
    PHONEBUTTONFUNCTION_LASTNUM      = 0x00000023U,
    PHONEBUTTONFUNCTION_NIGHTSRV     = 0x00000024U,
    PHONEBUTTONFUNCTION_SENDCALLS    = 0x00000025U,
    PHONEBUTTONFUNCTION_MSGINDICATOR = 0x00000026U,
    PHONEBUTTONFUNCTION_REPDIAL      = 0x00000027U,
    PHONEBUTTONFUNCTION_SETREPDIAL   = 0x00000028U,
    PHONEBUTTONFUNCTION_SYSTEMSPEED  = 0x00000029U,
    PHONEBUTTONFUNCTION_STATIONSPEED = 0x0000002aU,
    PHONEBUTTONFUNCTION_CAMPON       = 0x0000002bU,
    PHONEBUTTONFUNCTION_SAVEREPEAT   = 0x0000002cU,
    PHONEBUTTONFUNCTION_QUEUECALL    = 0x0000002dU,
    PHONEBUTTONFUNCTION_NONE         = 0x0000002eU,
    PHONEBUTTONFUNCTION_SEND         = 0x0000002fU,
    PHONEBUTTONMODE_DUMMY            = 0x00000001U,
    PHONEBUTTONMODE_CALL             = 0x00000002U,
    PHONEBUTTONMODE_FEATURE          = 0x00000004U,
    PHONEBUTTONMODE_KEYPAD           = 0x00000008U,
    PHONEBUTTONMODE_LOCAL            = 0x00000010U,
    PHONEBUTTONMODE_DISPLAY          = 0x00000020U,
    PHONEBUTTONSTATE_UP              = 0x00000001U,
    PHONEBUTTONSTATE_DOWN            = 0x00000002U,
    PHONEBUTTONSTATE_UNKNOWN         = 0x00000004U,
    PHONEBUTTONSTATE_UNAVAIL         = 0x00000008U,
}

enum : uint
{
    PHONEERR_ALLOCATED              = 0x90000001U,
    PHONEERR_BADDEVICEID            = 0x90000002U,
    PHONEERR_INCOMPATIBLEAPIVERSION = 0x90000003U,
    PHONEERR_INCOMPATIBLEEXTVERSION = 0x90000004U,
}

enum : uint
{
    PHONEERR_INIFILECORRUPT      = 0x90000005U,
    PHONEERR_INUSE               = 0x90000006U,
    PHONEERR_INVALAPPHANDLE      = 0x90000007U,
    PHONEERR_INVALAPPNAME        = 0x90000008U,
    PHONEERR_INVALBUTTONLAMPID   = 0x90000009U,
    PHONEERR_INVALBUTTONMODE     = 0x9000000aU,
    PHONEERR_INVALBUTTONSTATE    = 0x9000000bU,
    PHONEERR_INVALDATAID         = 0x9000000cU,
    PHONEERR_INVALDEVICECLASS    = 0x9000000dU,
    PHONEERR_INVALEXTVERSION     = 0x9000000eU,
    PHONEERR_INVALHOOKSWITCHDEV  = 0x9000000fU,
    PHONEERR_INVALHOOKSWITCHMODE = 0x90000010U,
    PHONEERR_INVALLAMPMODE       = 0x90000011U,
    PHONEERR_INVALPARAM          = 0x90000012U,
    PHONEERR_INVALPHONEHANDLE    = 0x90000013U,
    PHONEERR_INVALPHONESTATE     = 0x90000014U,
    PHONEERR_INVALPOINTER        = 0x90000015U,
    PHONEERR_INVALPRIVILEGE      = 0x90000016U,
    PHONEERR_INVALRINGMODE       = 0x90000017U,
    PHONEERR_NODEVICE            = 0x90000018U,
    PHONEERR_NODRIVER            = 0x90000019U,
    PHONEERR_NOMEM               = 0x9000001aU,
    PHONEERR_NOTOWNER            = 0x9000001bU,
    PHONEERR_OPERATIONFAILED     = 0x9000001cU,
    PHONEERR_OPERATIONUNAVAIL    = 0x9000001dU,
}

enum : uint
{
    PHONEERR_RESOURCEUNAVAIL = 0x9000001fU,
    PHONEERR_REQUESTOVERRUN  = 0x90000020U,
}

enum uint PHONEERR_STRUCTURETOOSMALL = 0x90000021U;

enum : uint
{
    PHONEERR_UNINITIALIZED       = 0x90000022U,
    PHONEERR_REINIT              = 0x90000023U,
    PHONEERR_DISCONNECTED        = 0x90000024U,
    PHONEERR_SERVICE_NOT_RUNNING = 0x90000025U,
}

enum : uint
{
    PHONEFEATURE_GETBUTTONINFO        = 0x00000001U,
    PHONEFEATURE_GETDATA              = 0x00000002U,
    PHONEFEATURE_GETDISPLAY           = 0x00000004U,
    PHONEFEATURE_GETGAINHANDSET       = 0x00000008U,
    PHONEFEATURE_GETGAINSPEAKER       = 0x00000010U,
    PHONEFEATURE_GETGAINHEADSET       = 0x00000020U,
    PHONEFEATURE_GETHOOKSWITCHHANDSET = 0x00000040U,
    PHONEFEATURE_GETHOOKSWITCHSPEAKER = 0x00000080U,
    PHONEFEATURE_GETHOOKSWITCHHEADSET = 0x00000100U,
    PHONEFEATURE_GETLAMP              = 0x00000200U,
    PHONEFEATURE_GETRING              = 0x00000400U,
    PHONEFEATURE_GETVOLUMEHANDSET     = 0x00000800U,
    PHONEFEATURE_GETVOLUMESPEAKER     = 0x00001000U,
    PHONEFEATURE_GETVOLUMEHEADSET     = 0x00002000U,
    PHONEFEATURE_SETBUTTONINFO        = 0x00004000U,
    PHONEFEATURE_SETDATA              = 0x00008000U,
    PHONEFEATURE_SETDISPLAY           = 0x00010000U,
    PHONEFEATURE_SETGAINHANDSET       = 0x00020000U,
    PHONEFEATURE_SETGAINSPEAKER       = 0x00040000U,
    PHONEFEATURE_SETGAINHEADSET       = 0x00080000U,
    PHONEFEATURE_SETHOOKSWITCHHANDSET = 0x00100000U,
    PHONEFEATURE_SETHOOKSWITCHSPEAKER = 0x00200000U,
    PHONEFEATURE_SETHOOKSWITCHHEADSET = 0x00400000U,
    PHONEFEATURE_SETLAMP              = 0x00800000U,
    PHONEFEATURE_SETRING              = 0x01000000U,
    PHONEFEATURE_SETVOLUMEHANDSET     = 0x02000000U,
    PHONEFEATURE_SETVOLUMESPEAKER     = 0x04000000U,
    PHONEFEATURE_SETVOLUMEHEADSET     = 0x08000000U,
    PHONEFEATURE_GENERICPHONE         = 0x10000000U,
}

enum : uint
{
    PHONEHOOKSWITCHDEV_HANDSET     = 0x00000001U,
    PHONEHOOKSWITCHDEV_SPEAKER     = 0x00000002U,
    PHONEHOOKSWITCHDEV_HEADSET     = 0x00000004U,
    PHONEHOOKSWITCHMODE_ONHOOK     = 0x00000001U,
    PHONEHOOKSWITCHMODE_MIC        = 0x00000002U,
    PHONEHOOKSWITCHMODE_SPEAKER    = 0x00000004U,
    PHONEHOOKSWITCHMODE_MICSPEAKER = 0x00000008U,
    PHONEHOOKSWITCHMODE_UNKNOWN    = 0x00000010U,
}

enum : uint
{
    PHONEINITIALIZEEXOPTION_USEHIDDENWINDOW   = 0x00000001U,
    PHONEINITIALIZEEXOPTION_USEEVENT          = 0x00000002U,
    PHONEINITIALIZEEXOPTION_USECOMPLETIONPORT = 0x00000003U,
}

enum : uint
{
    PHONELAMPMODE_DUMMY         = 0x00000001U,
    PHONELAMPMODE_OFF           = 0x00000002U,
    PHONELAMPMODE_STEADY        = 0x00000004U,
    PHONELAMPMODE_WINK          = 0x00000008U,
    PHONELAMPMODE_FLASH         = 0x00000010U,
    PHONELAMPMODE_FLUTTER       = 0x00000020U,
    PHONELAMPMODE_BROKENFLUTTER = 0x00000040U,
    PHONELAMPMODE_UNKNOWN       = 0x00000080U,
}

enum : uint
{
    PHONEPRIVILEGE_MONITOR = 0x00000001U,
    PHONEPRIVILEGE_OWNER   = 0x00000002U,
}

enum : uint
{
    PHONESTATE_OTHER             = 0x00000001U,
    PHONESTATE_CONNECTED         = 0x00000002U,
    PHONESTATE_DISCONNECTED      = 0x00000004U,
    PHONESTATE_OWNER             = 0x00000008U,
    PHONESTATE_MONITORS          = 0x00000010U,
    PHONESTATE_DISPLAY           = 0x00000020U,
    PHONESTATE_LAMP              = 0x00000040U,
    PHONESTATE_RINGMODE          = 0x00000080U,
    PHONESTATE_RINGVOLUME        = 0x00000100U,
    PHONESTATE_HANDSETHOOKSWITCH = 0x00000200U,
    PHONESTATE_HANDSETVOLUME     = 0x00000400U,
    PHONESTATE_HANDSETGAIN       = 0x00000800U,
    PHONESTATE_SPEAKERHOOKSWITCH = 0x00001000U,
    PHONESTATE_SPEAKERVOLUME     = 0x00002000U,
    PHONESTATE_SPEAKERGAIN       = 0x00004000U,
    PHONESTATE_HEADSETHOOKSWITCH = 0x00008000U,
    PHONESTATE_HEADSETVOLUME     = 0x00010000U,
    PHONESTATE_HEADSETGAIN       = 0x00020000U,
    PHONESTATE_SUSPEND           = 0x00040000U,
    PHONESTATE_RESUME            = 0x00080000U,
    PHONESTATE_DEVSPECIFIC       = 0x00100000U,
    PHONESTATE_REINIT            = 0x00200000U,
    PHONESTATE_CAPSCHANGE        = 0x00400000U,
    PHONESTATE_REMOVED           = 0x00800000U,
    PHONESTATUSFLAGS_CONNECTED   = 0x00000001U,
    PHONESTATUSFLAGS_SUSPENDED   = 0x00000002U,
}

enum : uint
{
    STRINGFORMAT_ASCII   = 0x00000001U,
    STRINGFORMAT_DBCS    = 0x00000002U,
    STRINGFORMAT_UNICODE = 0x00000003U,
    STRINGFORMAT_BINARY  = 0x00000004U,
}

enum uint TAPI_REPLY = 0x00000463U;

enum : int
{
    TAPIERR_CONNECTED          = 0x00000000,
    TAPIERR_DROPPED            = 0xffffffff,
    TAPIERR_NOREQUESTRECIPIENT = 0xfffffffe,
}

enum int TAPIERR_REQUESTQUEUEFULL = 0xfffffffd;

enum : int
{
    TAPIERR_INVALDESTADDRESS  = 0xfffffffc,
    TAPIERR_INVALWINDOWHANDLE = 0xfffffffb,
    TAPIERR_INVALDEVICECLASS  = 0xfffffffa,
    TAPIERR_INVALDEVICEID     = 0xfffffff9,
}

enum : int
{
    TAPIERR_DEVICECLASSUNAVAIL = 0xfffffff8,
    TAPIERR_DEVICEIDUNAVAIL    = 0xfffffff7,
    TAPIERR_DEVICEINUSE        = 0xfffffff6,
    TAPIERR_DESTBUSY           = 0xfffffff5,
    TAPIERR_DESTNOANSWER       = 0xfffffff4,
    TAPIERR_DESTUNAVAIL        = 0xfffffff3,
    TAPIERR_UNKNOWNWINHANDLE   = 0xfffffff2,
    TAPIERR_UNKNOWNREQUESTID   = 0xfffffff1,
}

enum : int
{
    TAPIERR_REQUESTFAILED    = 0xfffffff0,
    TAPIERR_REQUESTCANCELLED = 0xffffffef,
}

enum int TAPIERR_INVALPOINTER = 0xffffffee;

enum : int
{
    TAPIERR_NOTADMIN       = 0xffffffed,
    TAPIERR_MMCWRITELOCKED = 0xffffffec,
}

enum int TAPIERR_PROVIDERALREADYINSTALLED = 0xffffffeb;

enum : int
{
    TAPIERR_SCP_ALREADY_EXISTS = 0xffffffea,
    TAPIERR_SCP_DOES_NOT_EXIST = 0xffffffe9,
}

enum int TAPIMAXDESTADDRESSSIZE = 0x00000050;
enum int TAPIMAXAPPNAMESIZE = 0x00000028;
enum int TAPIMAXCALLEDPARTYSIZE = 0x00000028;
enum int TAPIMAXCOMMENTSIZE = 0x00000050;

enum : int
{
    TAPIMAXDEVICECLASSSIZE = 0x00000028,
    TAPIMAXDEVICEIDSIZE    = 0x00000028,
}

enum uint INTERFACEMASK = 0x00ff0000U;
enum uint DISPIDMASK = 0x0000ffffU;

enum : uint
{
    IDISPTAPI           = 0x00010000U,
    IDISPTAPICALLCENTER = 0x00020000U,
}

enum uint IDISPCALLINFO = 0x00010000U;
enum uint IDISPBASICCALLCONTROL = 0x00020000U;
enum uint IDISPLEGACYCALLMEDIACONTROL = 0x00030000U;
enum uint IDISPAGGREGATEDMSPCALLOBJ = 0x00040000U;

enum : uint
{
    IDISPADDRESS             = 0x00010000U,
    IDISPADDRESSCAPABILITIES = 0x00020000U,
}

enum uint IDISPMEDIASUPPORT = 0x00030000U;
enum uint IDISPADDRESSTRANSLATION = 0x00040000U;
enum uint IDISPLEGACYADDRESSMEDIACONTROL = 0x00050000U;
enum uint IDISPAGGREGATEDMSPADDRESSOBJ = 0x00060000U;

enum : uint
{
    IDISPPHONE      = 0x00010000U,
    IDISPAPC        = 0x00020000U,
    IDISPMULTITRACK = 0x00010000U,
}

enum : uint
{
    IDISPMEDIACONTROL  = 0x00020000U,
    IDISPMEDIARECORD   = 0x00030000U,
    IDISPMEDIAPLAYBACK = 0x00040000U,
}

enum uint IDISPFILETRACK = 0x00010000U;

enum : uint
{
    TAPIMEDIATYPE_AUDIO      = 0x00000008U,
    TAPIMEDIATYPE_VIDEO      = 0x00008000U,
    TAPIMEDIATYPE_DATAMODEM  = 0x00000010U,
    TAPIMEDIATYPE_G3FAX      = 0x00000020U,
    TAPIMEDIATYPE_MULTITRACK = 0x00010000U,
}

enum uint TSPI_MESSAGE_BASE = 0x000001f4U;
enum uint LINETSPIOPTION_NONREENTRANT = 0x00000001U;

enum : int
{
    TUISPIDLL_OBJECT_LINEID         = 0x00000001,
    TUISPIDLL_OBJECT_PHONEID        = 0x00000002,
    TUISPIDLL_OBJECT_PROVIDERID     = 0x00000003,
    TUISPIDLL_OBJECT_DIALOGINSTANCE = 0x00000004,
}

enum : uint
{
    PRIVATEOBJECT_NONE    = 0x00000001U,
    PRIVATEOBJECT_CALLID  = 0x00000002U,
    PRIVATEOBJECT_LINE    = 0x00000003U,
    PRIVATEOBJECT_CALL    = 0x00000004U,
    PRIVATEOBJECT_PHONE   = 0x00000005U,
    PRIVATEOBJECT_ADDRESS = 0x00000006U,
}

enum uint LINEQOSREQUESTTYPE_SERVICELEVEL = 0x00000001U;

enum : uint
{
    LINEQOSSERVICELEVEL_NEEDED      = 0x00000001U,
    LINEQOSSERVICELEVEL_IFAVAILABLE = 0x00000002U,
    LINEQOSSERVICELEVEL_BESTEFFORT  = 0x00000003U,
}

enum : uint
{
    LINEEQOSINFO_NOQOS            = 0x00000001U,
    LINEEQOSINFO_ADMISSIONFAILURE = 0x00000002U,
    LINEEQOSINFO_POLICYFAILURE    = 0x00000003U,
    LINEEQOSINFO_GENERICERROR     = 0x00000004U,
}

enum uint TSPI_PROC_BASE = 0x000001f4U;

enum : uint
{
    TSPI_LINEACCEPT                    = 0x000001f4U,
    TSPI_LINEADDTOCONFERENCE           = 0x000001f5U,
    TSPI_LINEANSWER                    = 0x000001f6U,
    TSPI_LINEBLINDTRANSFER             = 0x000001f7U,
    TSPI_LINECLOSE                     = 0x000001f8U,
    TSPI_LINECLOSECALL                 = 0x000001f9U,
    TSPI_LINECOMPLETECALL              = 0x000001faU,
    TSPI_LINECOMPLETETRANSFER          = 0x000001fbU,
    TSPI_LINECONDITIONALMEDIADETECTION = 0x000001fcU,
}

enum : uint
{
    TSPI_LINECONFIGDIALOG       = 0x000001fdU,
    TSPI_LINEDEVSPECIFIC        = 0x000001feU,
    TSPI_LINEDEVSPECIFICFEATURE = 0x000001ffU,
}

enum : uint
{
    TSPI_LINEDIAL             = 0x00000200U,
    TSPI_LINEDROP             = 0x00000201U,
    TSPI_LINEFORWARD          = 0x00000202U,
    TSPI_LINEGATHERDIGITS     = 0x00000203U,
    TSPI_LINEGENERATEDIGITS   = 0x00000204U,
    TSPI_LINEGENERATETONE     = 0x00000205U,
    TSPI_LINEGETADDRESSCAPS   = 0x00000206U,
    TSPI_LINEGETADDRESSID     = 0x00000207U,
    TSPI_LINEGETADDRESSSTATUS = 0x00000208U,
    TSPI_LINEGETCALLADDRESSID = 0x00000209U,
    TSPI_LINEGETCALLINFO      = 0x0000020aU,
    TSPI_LINEGETCALLSTATUS    = 0x0000020bU,
    TSPI_LINEGETDEVCAPS       = 0x0000020cU,
    TSPI_LINEGETDEVCONFIG     = 0x0000020dU,
    TSPI_LINEGETEXTENSIONID   = 0x0000020eU,
    TSPI_LINEGETICON          = 0x0000020fU,
    TSPI_LINEGETID            = 0x00000210U,
    TSPI_LINEGETLINEDEVSTATUS = 0x00000211U,
    TSPI_LINEGETNUMADDRESSIDS = 0x00000212U,
}

enum : uint
{
    TSPI_LINEHOLD                 = 0x00000213U,
    TSPI_LINEMAKECALL             = 0x00000214U,
    TSPI_LINEMONITORDIGITS        = 0x00000215U,
    TSPI_LINEMONITORMEDIA         = 0x00000216U,
    TSPI_LINEMONITORTONES         = 0x00000217U,
    TSPI_LINENEGOTIATEEXTVERSION  = 0x00000218U,
    TSPI_LINENEGOTIATETSPIVERSION = 0x00000219U,
}

enum : uint
{
    TSPI_LINEOPEN                   = 0x0000021aU,
    TSPI_LINEPARK                   = 0x0000021bU,
    TSPI_LINEPICKUP                 = 0x0000021cU,
    TSPI_LINEPREPAREADDTOCONFERENCE = 0x0000021dU,
}

enum : uint
{
    TSPI_LINEREDIRECT             = 0x0000021eU,
    TSPI_LINEREMOVEFROMCONFERENCE = 0x0000021fU,
}

enum : uint
{
    TSPI_LINESECURECALL               = 0x00000220U,
    TSPI_LINESELECTEXTVERSION         = 0x00000221U,
    TSPI_LINESENDUSERUSERINFO         = 0x00000222U,
    TSPI_LINESETAPPSPECIFIC           = 0x00000223U,
    TSPI_LINESETCALLPARAMS            = 0x00000224U,
    TSPI_LINESETDEFAULTMEDIADETECTION = 0x00000225U,
    TSPI_LINESETDEVCONFIG             = 0x00000226U,
    TSPI_LINESETMEDIACONTROL          = 0x00000227U,
    TSPI_LINESETMEDIAMODE             = 0x00000228U,
    TSPI_LINESETSTATUSMESSAGES        = 0x00000229U,
    TSPI_LINESETTERMINAL              = 0x0000022aU,
    TSPI_LINESETUPCONFERENCE          = 0x0000022bU,
    TSPI_LINESETUPTRANSFER            = 0x0000022cU,
    TSPI_LINESWAPHOLD                 = 0x0000022dU,
    TSPI_LINEUNCOMPLETECALL           = 0x0000022eU,
    TSPI_LINEUNHOLD                   = 0x0000022fU,
    TSPI_LINEUNPARK                   = 0x00000230U,
}

enum : uint
{
    TSPI_PHONECLOSE                = 0x00000231U,
    TSPI_PHONECONFIGDIALOG         = 0x00000232U,
    TSPI_PHONEDEVSPECIFIC          = 0x00000233U,
    TSPI_PHONEGETBUTTONINFO        = 0x00000234U,
    TSPI_PHONEGETDATA              = 0x00000235U,
    TSPI_PHONEGETDEVCAPS           = 0x00000236U,
    TSPI_PHONEGETDISPLAY           = 0x00000237U,
    TSPI_PHONEGETEXTENSIONID       = 0x00000238U,
    TSPI_PHONEGETGAIN              = 0x00000239U,
    TSPI_PHONEGETHOOKSWITCH        = 0x0000023aU,
    TSPI_PHONEGETICON              = 0x0000023bU,
    TSPI_PHONEGETID                = 0x0000023cU,
    TSPI_PHONEGETLAMP              = 0x0000023dU,
    TSPI_PHONEGETRING              = 0x0000023eU,
    TSPI_PHONEGETSTATUS            = 0x0000023fU,
    TSPI_PHONEGETVOLUME            = 0x00000240U,
    TSPI_PHONENEGOTIATEEXTVERSION  = 0x00000241U,
    TSPI_PHONENEGOTIATETSPIVERSION = 0x00000242U,
}

enum : uint
{
    TSPI_PHONEOPEN              = 0x00000243U,
    TSPI_PHONESELECTEXTVERSION  = 0x00000244U,
    TSPI_PHONESETBUTTONINFO     = 0x00000245U,
    TSPI_PHONESETDATA           = 0x00000246U,
    TSPI_PHONESETDISPLAY        = 0x00000247U,
    TSPI_PHONESETGAIN           = 0x00000248U,
    TSPI_PHONESETHOOKSWITCH     = 0x00000249U,
    TSPI_PHONESETLAMP           = 0x0000024aU,
    TSPI_PHONESETRING           = 0x0000024bU,
    TSPI_PHONESETSTATUSMESSAGES = 0x0000024cU,
    TSPI_PHONESETVOLUME         = 0x0000024dU,
}

enum : uint
{
    TSPI_PROVIDERCONFIG      = 0x0000024eU,
    TSPI_PROVIDERINIT        = 0x0000024fU,
    TSPI_PROVIDERINSTALL     = 0x00000250U,
    TSPI_PROVIDERREMOVE      = 0x00000251U,
    TSPI_PROVIDERSHUTDOWN    = 0x00000252U,
    TSPI_PROVIDERENUMDEVICES = 0x00000253U,
}

enum : uint
{
    TSPI_LINEDROPONCLOSE = 0x00000254U,
    TSPI_LINEDROPNOOWNER = 0x00000255U,
}

enum : uint
{
    TSPI_PROVIDERCREATELINEDEVICE  = 0x00000256U,
    TSPI_PROVIDERCREATEPHONEDEVICE = 0x00000257U,
}

enum uint TSPI_LINESETCURRENTLOCATION = 0x00000258U;
enum uint TSPI_LINECONFIGDIALOGEDIT = 0x00000259U;
enum uint TSPI_LINERELEASEUSERUSERINFO = 0x0000025aU;

enum : uint
{
    TSPI_LINEGETCALLID          = 0x0000025bU,
    TSPI_LINEGETCALLHUBTRACKING = 0x0000025cU,
}

enum uint TSPI_LINESETCALLHUBTRACKING = 0x0000025dU;
enum uint TSPI_LINERECEIVEMSPDATA = 0x0000025eU;

enum : uint
{
    TSPI_LINEMSPIDENTIFY       = 0x0000025fU,
    TSPI_LINECREATEMSPINSTANCE = 0x00000260U,
}

enum uint TSPI_LINECLOSEMSPINSTANCE = 0x00000261U;

enum : uint
{
    IDISPDIROBJECT        = 0x00010000U,
    IDISPDIROBJCONFERENCE = 0x00020000U,
    IDISPDIROBJUSER       = 0x00030000U,
    IDISPDIRECTORY        = 0x00010000U,
}

enum uint IDISPILSCONFIG = 0x00020000U;

enum : uint
{
    RENDBIND_AUTHENTICATE       = 0x00000001U,
    RENDBIND_DEFAULTDOMAINNAME  = 0x00000002U,
    RENDBIND_DEFAULTUSERNAME    = 0x00000004U,
    RENDBIND_DEFAULTPASSWORD    = 0x00000008U,
    RENDBIND_DEFAULTCREDENTIALS = 0x0000000eU,
}

enum : uint
{
    STRM_INITIAL          = 0x00000000U,
    STRM_TERMINALSELECTED = 0x00000001U,
}

enum uint STRM_CONFIGURED = 0x00000002U;

enum : uint
{
    STRM_RUNNING = 0x00000004U,
    STRM_PAUSED  = 0x00000008U,
    STRM_STOPPED = 0x00000010U,
}

enum : HRESULT
{
    TAPI_E_NOTENOUGHMEMORY = HRESULT(0x80040001),
    TAPI_E_NOITEMS         = HRESULT(0x80040002),
    TAPI_E_NOTSUPPORTED    = HRESULT(0x80040003),
}

enum HRESULT TAPI_E_INVALIDMEDIATYPE = HRESULT(0x80040004);
enum HRESULT TAPI_E_OPERATIONFAILED = HRESULT(0x80040005);

enum : HRESULT
{
    TAPI_E_ALLOCATED         = HRESULT(0x80040006),
    TAPI_E_CALLUNAVAIL       = HRESULT(0x80040007),
    TAPI_E_COMPLETIONOVERRUN = HRESULT(0x80040008),
}

enum HRESULT TAPI_E_CONFERENCEFULL = HRESULT(0x80040009);
enum HRESULT TAPI_E_DIALMODIFIERNOTSUPPORTED = HRESULT(0x8004000a);

enum : HRESULT
{
    TAPI_E_INUSE              = HRESULT(0x8004000b),
    TAPI_E_INVALADDRESS       = HRESULT(0x8004000c),
    TAPI_E_INVALADDRESSSTATE  = HRESULT(0x8004000d),
    TAPI_E_INVALCALLPARAMS    = HRESULT(0x8004000e),
    TAPI_E_INVALCALLPRIVILEGE = HRESULT(0x8004000f),
    TAPI_E_INVALCALLSTATE     = HRESULT(0x80040010),
    TAPI_E_INVALCARD          = HRESULT(0x80040011),
    TAPI_E_INVALCOMPLETIONID  = HRESULT(0x80040012),
    TAPI_E_INVALCOUNTRYCODE   = HRESULT(0x80040013),
    TAPI_E_INVALDEVICECLASS   = HRESULT(0x80040014),
    TAPI_E_INVALDIALPARAMS    = HRESULT(0x80040015),
    TAPI_E_INVALDIGITS        = HRESULT(0x80040016),
    TAPI_E_INVALGROUPID       = HRESULT(0x80040017),
    TAPI_E_INVALLOCATION      = HRESULT(0x80040018),
    TAPI_E_INVALMESSAGEID     = HRESULT(0x80040019),
    TAPI_E_INVALPARKID        = HRESULT(0x8004001a),
    TAPI_E_INVALRATE          = HRESULT(0x8004001b),
    TAPI_E_INVALTIMEOUT       = HRESULT(0x8004001c),
    TAPI_E_INVALTONE          = HRESULT(0x8004001d),
    TAPI_E_INVALLIST          = HRESULT(0x8004001e),
    TAPI_E_INVALMODE          = HRESULT(0x8004001f),
    TAPI_E_NOCONFERENCE       = HRESULT(0x80040020),
    TAPI_E_NODEVICE           = HRESULT(0x80040021),
    TAPI_E_NOREQUEST          = HRESULT(0x80040022),
    TAPI_E_NOTOWNER           = HRESULT(0x80040023),
    TAPI_E_NOTREGISTERED      = HRESULT(0x80040024),
}

enum HRESULT TAPI_E_REQUESTOVERRUN = HRESULT(0x80040025);

enum : HRESULT
{
    TAPI_E_TARGETNOTFOUND     = HRESULT(0x80040026),
    TAPI_E_TARGETSELF         = HRESULT(0x80040027),
    TAPI_E_USERUSERINFOTOOBIG = HRESULT(0x80040028),
}

enum : HRESULT
{
    TAPI_E_REINIT         = HRESULT(0x80040029),
    TAPI_E_ADDRESSBLOCKED = HRESULT(0x8004002a),
}

enum HRESULT TAPI_E_BILLINGREJECTED = HRESULT(0x8004002b);

enum : HRESULT
{
    TAPI_E_INVALFEATURE       = HRESULT(0x8004002c),
    TAPI_E_INVALBUTTONLAMPID  = HRESULT(0x8004002d),
    TAPI_E_INVALBUTTONSTATE   = HRESULT(0x8004002e),
    TAPI_E_INVALDATAID        = HRESULT(0x8004002f),
    TAPI_E_INVALHOOKSWITCHDEV = HRESULT(0x80040030),
}

enum : HRESULT
{
    TAPI_E_DROPPED            = HRESULT(0x80040031),
    TAPI_E_NOREQUESTRECIPIENT = HRESULT(0x80040032),
}

enum HRESULT TAPI_E_REQUESTQUEUEFULL = HRESULT(0x80040033);

enum : HRESULT
{
    TAPI_E_DESTBUSY     = HRESULT(0x80040034),
    TAPI_E_DESTNOANSWER = HRESULT(0x80040035),
    TAPI_E_DESTUNAVAIL  = HRESULT(0x80040036),
}

enum : HRESULT
{
    TAPI_E_REQUESTFAILED    = HRESULT(0x80040037),
    TAPI_E_REQUESTCANCELLED = HRESULT(0x80040038),
}

enum : HRESULT
{
    TAPI_E_INVALPRIVILEGE       = HRESULT(0x80040039),
    TAPI_E_INVALIDDIRECTION     = HRESULT(0x8004003a),
    TAPI_E_INVALIDTERMINAL      = HRESULT(0x8004003b),
    TAPI_E_INVALIDTERMINALCLASS = HRESULT(0x8004003c),
}

enum : HRESULT
{
    TAPI_E_NODRIVER           = HRESULT(0x8004003d),
    TAPI_E_MAXSTREAMS         = HRESULT(0x8004003e),
    TAPI_E_NOTERMINALSELECTED = HRESULT(0x8004003f),
}

enum HRESULT TAPI_E_TERMINALINUSE = HRESULT(0x80040040);

enum : HRESULT
{
    TAPI_E_NOTSTOPPED   = HRESULT(0x80040041),
    TAPI_E_MAXTERMINALS = HRESULT(0x80040042),
}

enum HRESULT TAPI_E_INVALIDSTREAM = HRESULT(0x80040043);

enum : HRESULT
{
    TAPI_E_TIMEOUT                       = HRESULT(0x80040044),
    TAPI_E_CALLCENTER_GROUP_REMOVED      = HRESULT(0x80040045),
    TAPI_E_CALLCENTER_QUEUE_REMOVED      = HRESULT(0x80040046),
    TAPI_E_CALLCENTER_NO_AGENT_ID        = HRESULT(0x80040047),
    TAPI_E_CALLCENTER_INVALAGENTID       = HRESULT(0x80040048),
    TAPI_E_CALLCENTER_INVALAGENTGROUP    = HRESULT(0x80040049),
    TAPI_E_CALLCENTER_INVALPASSWORD      = HRESULT(0x8004004a),
    TAPI_E_CALLCENTER_INVALAGENTSTATE    = HRESULT(0x8004004b),
    TAPI_E_CALLCENTER_INVALAGENTACTIVITY = HRESULT(0x8004004c),
}

enum HRESULT TAPI_E_REGISTRY_SETTING_CORRUPT = HRESULT(0x8004004d);
enum HRESULT TAPI_E_TERMINAL_PEER = HRESULT(0x8004004e);
enum HRESULT TAPI_E_PEER_NOT_SET = HRESULT(0x8004004f);

enum : HRESULT
{
    TAPI_E_NOEVENT          = HRESULT(0x80040050),
    TAPI_E_INVALADDRESSTYPE = HRESULT(0x80040051),
}

enum HRESULT TAPI_E_RESOURCEUNAVAIL = HRESULT(0x80040052);
enum HRESULT TAPI_E_PHONENOTOPEN = HRESULT(0x80040053);
enum HRESULT TAPI_E_CALLNOTSELECTED = HRESULT(0x80040054);

enum : HRESULT
{
    TAPI_E_WRONGEVENT         = HRESULT(0x80040055),
    TAPI_E_NOFORMAT           = HRESULT(0x80040056),
    TAPI_E_INVALIDSTREAMSTATE = HRESULT(0x80040057),
}

enum HRESULT TAPI_E_WRONG_STATE = HRESULT(0x80040058);
enum HRESULT TAPI_E_NOT_INITIALIZED = HRESULT(0x80040059);
enum HRESULT TAPI_E_SERVICE_NOT_RUNNING = HRESULT(0x8004005a);

enum : const(wchar)*
{
    // Native encoding: ansi
    OPENTNEFSTREAM   = "OpenTnefStream",
    // Native encoding: ansi
    OPENTNEFSTREAMEX = "OpenTnefStreamEx",
}

// Native encoding: ansi
enum const(wchar)* GETTNEFSTREAMCODEPAGE = "GetTnefStreamCodePage";
enum uint cbDisplayName = 0x00000029U;
enum uint cbEmailName = 0x0000000bU;
enum uint cbSeverName = 0x0000000cU;
enum uint cbTYPE = 0x00000010U;
enum uint cbMaxIdData = 0x000000c8U;

enum : uint
{
    prioLow  = 0x00000003U,
    prioNorm = 0x00000002U,
    prioHigh = 0x00000001U,
}

enum : int
{
    atypNull    = 0x00000000,
    atypFile    = 0x00000001,
    atypOle     = 0x00000002,
    atypPicture = 0x00000003,
}

enum int atypMax = 0x00000004;

// Callbacks

alias LINECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                   size_t dwParam2, size_t dwParam3);
alias PHONECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                    size_t dwParam2, size_t dwParam3);
alias ASYNC_COMPLETION = void function(uint dwRequestID, int lResult);
alias LINEEVENT = void function(HTAPILINE htLine, HTAPICALL htCall, uint dwMsg, size_t dwParam1, size_t dwParam2, 
                                size_t dwParam3);
alias PHONEEVENT = void function(HTAPIPHONE htPhone, uint dwMsg, size_t dwParam1, size_t dwParam2, size_t dwParam3);
alias TUISPIDLLCALLBACK = int function(size_t dwObjectID, uint dwObjectType, void* lpParams, uint dwSize);
alias LPOPENTNEFSTREAM = HRESULT function(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                                          IMessage lpMessage, ushort wKeyVal, ITnef* lppTNEF);
alias LPOPENTNEFSTREAMEX = HRESULT function(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                                            IMessage lpMessage, ushort wKeyVal, IAddrBook lpAdressBook, 
                                            ITnef* lppTNEF);
alias LPGETTNEFSTREAMCODEPAGE = HRESULT function(IStream lpStream, uint* lpulCodepage, uint* lpulSubCodepage);

// Structs


struct HDRVCALL
{
    void* Value;
}

struct HDRVLINE
{
    void* Value;
}

struct HDRVPHONE
{
    void* Value;
}

struct HDRVMSPLINE
{
    void* Value;
}

struct HDRVDIALOGINSTANCE
{
    void* Value;
}

struct HTAPICALL
{
    void* Value;
}

struct HTAPILINE
{
    void* Value;
}

struct HTAPIPHONE
{
    void* Value;
}

struct HPROVIDER
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineaddresscaps
struct LINEADDRESSCAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwLineDeviceID;
    uint dwAddressSize;
    uint dwAddressOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAddressSharing;
    uint dwAddressStates;
    uint dwCallInfoStates;
    uint dwCallerIDFlags;
    uint dwCalledIDFlags;
    uint dwConnectedIDFlags;
    uint dwRedirectionIDFlags;
    uint dwRedirectingIDFlags;
    uint dwCallStates;
    uint dwDialToneModes;
    uint dwBusyModes;
    uint dwSpecialInfo;
    uint dwDisconnectModes;
    uint dwMaxNumActiveCalls;
    uint dwMaxNumOnHoldCalls;
    uint dwMaxNumOnHoldPendingCalls;
    uint dwMaxNumConference;
    uint dwMaxNumTransConf;
    uint dwAddrCapFlags;
    uint dwCallFeatures;
    uint dwRemoveFromConfCaps;
    uint dwRemoveFromConfState;
    uint dwTransferModes;
    uint dwParkModes;
    uint dwForwardModes;
    uint dwMaxForwardEntries;
    uint dwMaxSpecificEntries;
    uint dwMinFwdNumRings;
    uint dwMaxFwdNumRings;
    uint dwMaxCallCompletions;
    uint dwCallCompletionConds;
    uint dwCallCompletionModes;
    uint dwNumCompletionMessages;
    uint dwCompletionMsgTextEntrySize;
    uint dwCompletionMsgTextSize;
    uint dwCompletionMsgTextOffset;
    uint dwAddressFeatures;
    uint dwPredictiveAutoTransferStates;
    uint dwNumCallTreatments;
    uint dwCallTreatmentListSize;
    uint dwCallTreatmentListOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwMaxCallDataSize;
    uint dwCallFeatures2;
    uint dwMaxNoAnswerTimeout;
    uint dwConnectedModes;
    uint dwOfferingModes;
    uint dwAvailableMediaModes;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineaddressstatus
struct LINEADDRESSSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumInUse;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwAddressFeatures;
    uint dwNumRingsNoAnswer;
    uint dwForwardNumEntries;
    uint dwForwardSize;
    uint dwForwardOffset;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentactivityentry
struct LINEAGENTACTIVITYENTRY
{
align (1):
    uint dwID;
    uint dwNameSize;
    uint dwNameOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentactivitylist
struct LINEAGENTACTIVITYLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentcaps
struct LINEAGENTCAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentHandlerInfoSize;
    uint dwAgentHandlerInfoOffset;
    uint dwCapsVersion;
    uint dwFeatures;
    uint dwStates;
    uint dwNextStates;
    uint dwMaxNumGroupEntries;
    uint dwAgentStatusMessages;
    uint dwNumAgentExtensionIDs;
    uint dwAgentExtensionIDListSize;
    uint dwAgentExtensionIDListOffset;
    GUID ProxyGUID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentgroupentry
struct LINEAGENTGROUPENTRY
{
align (1):
    struct GroupID
    {
    align (1):
        uint dwGroupID1;
        uint dwGroupID2;
        uint dwGroupID3;
        uint dwGroupID4;
    }
    uint dwNameSize;
    uint dwNameOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentgrouplist
struct LINEAGENTGROUPLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentstatus
struct LINEAGENTSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwGroupListSize;
    uint dwGroupListOffset;
    uint dwState;
    uint dwNextState;
    uint dwActivityID;
    uint dwActivitySize;
    uint dwActivityOffset;
    uint dwAgentFeatures;
    uint dwValidStates;
    uint dwValidNextStates;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineappinfo
struct LINEAPPINFO
{
align (1):
    uint dwMachineNameSize;
    uint dwMachineNameOffset;
    uint dwUserNameSize;
    uint dwUserNameOffset;
    uint dwModuleFilenameSize;
    uint dwModuleFilenameOffset;
    uint dwFriendlyNameSize;
    uint dwFriendlyNameOffset;
    uint dwMediaModes;
    uint dwAddressID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagententry
struct LINEAGENTENTRY
{
align (1):
    uint hAgent;
    uint dwNameSize;
    uint dwNameOffset;
    uint dwIDSize;
    uint dwIDOffset;
    uint dwPINSize;
    uint dwPINOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentlist
struct LINEAGENTLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentinfo
struct LINEAGENTINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwAgentState;
    uint dwNextAgentState;
    uint dwMeasurementPeriod;
    CY   cyOverallCallRate;
    uint dwNumberOfACDCalls;
    uint dwNumberOfIncomingCalls;
    uint dwNumberOfOutgoingCalls;
    uint dwTotalACDTalkTime;
    uint dwTotalACDCallTime;
    uint dwTotalACDWrapUpTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessionentry
struct LINEAGENTSESSIONENTRY
{
align (1):
    uint hAgentSession;
    uint hAgent;
    GUID GroupID;
    uint dwWorkingAddressID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessionlist
struct LINEAGENTSESSIONLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineagentsessioninfo
struct LINEAGENTSESSIONINFO
{
align (1):
    uint   dwTotalSize;
    uint   dwNeededSize;
    uint   dwUsedSize;
    uint   dwAgentSessionState;
    uint   dwNextAgentSessionState;
    double dateSessionStartTime;
    uint   dwSessionDuration;
    uint   dwNumberOfCalls;
    uint   dwTotalTalkTime;
    uint   dwAverageTalkTime;
    uint   dwTotalCallTime;
    uint   dwAverageCallTime;
    uint   dwTotalWrapUpTime;
    uint   dwAverageWrapUpTime;
    CY     cyACDCallRate;
    uint   dwLongestTimeToAnswer;
    uint   dwAverageTimeToAnswer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeueentry
struct LINEQUEUEENTRY
{
align (1):
    uint dwQueueID;
    uint dwNameSize;
    uint dwNameOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeuelist
struct LINEQUEUELIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linequeueinfo
struct LINEQUEUEINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwMeasurementPeriod;
    uint dwTotalCallsQueued;
    uint dwCurrentCallsQueued;
    uint dwTotalCallsAbandoned;
    uint dwTotalCallsFlowedIn;
    uint dwTotalCallsFlowedOut;
    uint dwLongestEverWaitTime;
    uint dwCurrentLongestWaitTime;
    uint dwAverageWaitTime;
    uint dwFinalDisposition;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproxyrequestlist
struct LINEPROXYREQUESTLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumEntries;
    uint dwListSize;
    uint dwListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedialparams
struct LINEDIALPARAMS
{
align (1):
    uint dwDialPause;
    uint dwDialSpeed;
    uint dwDigitDuration;
    uint dwWaitForDialtone;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallinfo
struct LINECALLINFO
{
align (1):
    uint           dwTotalSize;
    uint           dwNeededSize;
    uint           dwUsedSize;
    uint           hLine;
    uint           dwLineDeviceID;
    uint           dwAddressID;
    uint           dwBearerMode;
    uint           dwRate;
    uint           dwMediaMode;
    uint           dwAppSpecific;
    uint           dwCallID;
    uint           dwRelatedCallID;
    uint           dwCallParamFlags;
    uint           dwCallStates;
    uint           dwMonitorDigitModes;
    uint           dwMonitorMediaModes;
    LINEDIALPARAMS DialParams;
    uint           dwOrigin;
    uint           dwReason;
    uint           dwCompletionID;
    uint           dwNumOwners;
    uint           dwNumMonitors;
    uint           dwCountryCode;
    uint           dwTrunk;
    uint           dwCallerIDFlags;
    uint           dwCallerIDSize;
    uint           dwCallerIDOffset;
    uint           dwCallerIDNameSize;
    uint           dwCallerIDNameOffset;
    uint           dwCalledIDFlags;
    uint           dwCalledIDSize;
    uint           dwCalledIDOffset;
    uint           dwCalledIDNameSize;
    uint           dwCalledIDNameOffset;
    uint           dwConnectedIDFlags;
    uint           dwConnectedIDSize;
    uint           dwConnectedIDOffset;
    uint           dwConnectedIDNameSize;
    uint           dwConnectedIDNameOffset;
    uint           dwRedirectionIDFlags;
    uint           dwRedirectionIDSize;
    uint           dwRedirectionIDOffset;
    uint           dwRedirectionIDNameSize;
    uint           dwRedirectionIDNameOffset;
    uint           dwRedirectingIDFlags;
    uint           dwRedirectingIDSize;
    uint           dwRedirectingIDOffset;
    uint           dwRedirectingIDNameSize;
    uint           dwRedirectingIDNameOffset;
    uint           dwAppNameSize;
    uint           dwAppNameOffset;
    uint           dwDisplayableAddressSize;
    uint           dwDisplayableAddressOffset;
    uint           dwCalledPartySize;
    uint           dwCalledPartyOffset;
    uint           dwCommentSize;
    uint           dwCommentOffset;
    uint           dwDisplaySize;
    uint           dwDisplayOffset;
    uint           dwUserUserInfoSize;
    uint           dwUserUserInfoOffset;
    uint           dwHighLevelCompSize;
    uint           dwHighLevelCompOffset;
    uint           dwLowLevelCompSize;
    uint           dwLowLevelCompOffset;
    uint           dwChargingInfoSize;
    uint           dwChargingInfoOffset;
    uint           dwTerminalModesSize;
    uint           dwTerminalModesOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwCallTreatment;
    uint           dwCallDataSize;
    uint           dwCallDataOffset;
    uint           dwSendingFlowspecSize;
    uint           dwSendingFlowspecOffset;
    uint           dwReceivingFlowspecSize;
    uint           dwReceivingFlowspecOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecalllist
struct LINECALLLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwCallsNumEntries;
    uint dwCallsSize;
    uint dwCallsOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallparams
struct LINECALLPARAMS
{
align (1):
    uint           dwTotalSize;
    uint           dwBearerMode;
    uint           dwMinRate;
    uint           dwMaxRate;
    uint           dwMediaMode;
    uint           dwCallParamFlags;
    uint           dwAddressMode;
    uint           dwAddressID;
    LINEDIALPARAMS DialParams;
    uint           dwOrigAddressSize;
    uint           dwOrigAddressOffset;
    uint           dwDisplayableAddressSize;
    uint           dwDisplayableAddressOffset;
    uint           dwCalledPartySize;
    uint           dwCalledPartyOffset;
    uint           dwCommentSize;
    uint           dwCommentOffset;
    uint           dwUserUserInfoSize;
    uint           dwUserUserInfoOffset;
    uint           dwHighLevelCompSize;
    uint           dwHighLevelCompOffset;
    uint           dwLowLevelCompSize;
    uint           dwLowLevelCompOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwPredictiveAutoTransferStates;
    uint           dwTargetAddressSize;
    uint           dwTargetAddressOffset;
    uint           dwSendingFlowspecSize;
    uint           dwSendingFlowspecOffset;
    uint           dwReceivingFlowspecSize;
    uint           dwReceivingFlowspecOffset;
    uint           dwDeviceClassSize;
    uint           dwDeviceClassOffset;
    uint           dwDeviceConfigSize;
    uint           dwDeviceConfigOffset;
    uint           dwCallDataSize;
    uint           dwCallDataOffset;
    uint           dwNoAnswerTimeout;
    uint           dwCallingPartyIDSize;
    uint           dwCallingPartyIDOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecallstatus
struct LINECALLSTATUS
{
align (1):
    uint       dwTotalSize;
    uint       dwNeededSize;
    uint       dwUsedSize;
    uint       dwCallState;
    uint       dwCallStateMode;
    uint       dwCallPrivilege;
    uint       dwCallFeatures;
    uint       dwDevSpecificSize;
    uint       dwDevSpecificOffset;
    uint       dwCallFeatures2;
    SYSTEMTIME tStateEntryTime;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecalltreatmententry
struct LINECALLTREATMENTENTRY
{
align (1):
    uint dwCallTreatmentID;
    uint dwCallTreatmentNameSize;
    uint dwCallTreatmentNameOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecardentry
struct LINECARDENTRY
{
align (1):
    uint dwPermanentCardID;
    uint dwCardNameSize;
    uint dwCardNameOffset;
    uint dwCardNumberDigits;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
    uint dwOptions;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecountryentry
struct LINECOUNTRYENTRY
{
align (1):
    uint dwCountryID;
    uint dwCountryCode;
    uint dwNextCountryID;
    uint dwCountryNameSize;
    uint dwCountryNameOffset;
    uint dwSameAreaRuleSize;
    uint dwSameAreaRuleOffset;
    uint dwLongDistanceRuleSize;
    uint dwLongDistanceRuleOffset;
    uint dwInternationalRuleSize;
    uint dwInternationalRuleOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linecountrylist
struct LINECOUNTRYLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumCountries;
    uint dwCountryListSize;
    uint dwCountryListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedevcaps
struct LINEDEVCAPS
{
align (1):
    uint           dwTotalSize;
    uint           dwNeededSize;
    uint           dwUsedSize;
    uint           dwProviderInfoSize;
    uint           dwProviderInfoOffset;
    uint           dwSwitchInfoSize;
    uint           dwSwitchInfoOffset;
    uint           dwPermanentLineID;
    uint           dwLineNameSize;
    uint           dwLineNameOffset;
    uint           dwStringFormat;
    uint           dwAddressModes;
    uint           dwNumAddresses;
    uint           dwBearerModes;
    uint           dwMaxRate;
    uint           dwMediaModes;
    uint           dwGenerateToneModes;
    uint           dwGenerateToneMaxNumFreq;
    uint           dwGenerateDigitModes;
    uint           dwMonitorToneMaxNumFreq;
    uint           dwMonitorToneMaxNumEntries;
    uint           dwMonitorDigitModes;
    uint           dwGatherDigitsMinTimeout;
    uint           dwGatherDigitsMaxTimeout;
    uint           dwMedCtlDigitMaxListSize;
    uint           dwMedCtlMediaMaxListSize;
    uint           dwMedCtlToneMaxListSize;
    uint           dwMedCtlCallStateMaxListSize;
    uint           dwDevCapFlags;
    uint           dwMaxNumActiveCalls;
    uint           dwAnswerMode;
    uint           dwRingModes;
    uint           dwLineStates;
    uint           dwUUIAcceptSize;
    uint           dwUUIAnswerSize;
    uint           dwUUIMakeCallSize;
    uint           dwUUIDropSize;
    uint           dwUUISendUserUserInfoSize;
    uint           dwUUICallInfoSize;
    LINEDIALPARAMS MinDialParams;
    LINEDIALPARAMS MaxDialParams;
    LINEDIALPARAMS DefaultDialParams;
    uint           dwNumTerminals;
    uint           dwTerminalCapsSize;
    uint           dwTerminalCapsOffset;
    uint           dwTerminalTextEntrySize;
    uint           dwTerminalTextSize;
    uint           dwTerminalTextOffset;
    uint           dwDevSpecificSize;
    uint           dwDevSpecificOffset;
    uint           dwLineFeatures;
    uint           dwSettableDevStatus;
    uint           dwDeviceClassesSize;
    uint           dwDeviceClassesOffset;
    GUID           PermanentLineGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linedevstatus
struct LINEDEVSTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumOpens;
    uint dwOpenMediaModes;
    uint dwNumActiveCalls;
    uint dwNumOnHoldCalls;
    uint dwNumOnHoldPendCalls;
    uint dwLineFeatures;
    uint dwNumCallCompletions;
    uint dwRingMode;
    uint dwSignalLevel;
    uint dwBatteryLevel;
    uint dwRoamMode;
    uint dwDevStatusFlags;
    uint dwTerminalModesSize;
    uint dwTerminalModesOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwAvailableMediaModes;
    uint dwAppInfoSize;
    uint dwAppInfoOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineextensionid
struct LINEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineforward
struct LINEFORWARD
{
align (1):
    uint dwForwardMode;
    uint dwCallerAddressSize;
    uint dwCallerAddressOffset;
    uint dwDestCountryCode;
    uint dwDestAddressSize;
    uint dwDestAddressOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineforwardlist
struct LINEFORWARDLIST
{
align (1):
    uint           dwTotalSize;
    uint           dwNumEntries;
    LINEFORWARD[1] ForwardList; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linegeneratetone
struct LINEGENERATETONE
{
align (1):
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineinitializeexparams
struct LINEINITIALIZEEXPARAMS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwOptions;
    union Handles
    {
    align (1):
        HANDLE hEvent;
        HANDLE hCompletionPort;
    }
    uint dwCompletionKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linelocationentry
struct LINELOCATIONENTRY
{
align (1):
    uint dwPermanentLocationID;
    uint dwLocationNameSize;
    uint dwLocationNameOffset;
    uint dwCountryCode;
    uint dwCityCodeSize;
    uint dwCityCodeOffset;
    uint dwPreferredCardID;
    uint dwLocalAccessCodeSize;
    uint dwLocalAccessCodeOffset;
    uint dwLongDistanceAccessCodeSize;
    uint dwLongDistanceAccessCodeOffset;
    uint dwTollPrefixListSize;
    uint dwTollPrefixListOffset;
    uint dwCountryID;
    uint dwOptions;
    uint dwCancelCallWaitingSize;
    uint dwCancelCallWaitingOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontrolcallstate
struct LINEMEDIACONTROLCALLSTATE
{
align (1):
    uint dwCallStates;
    uint dwMediaControl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontroldigit
struct LINEMEDIACONTROLDIGIT
{
align (1):
    uint dwDigit;
    uint dwDigitModes;
    uint dwMediaControl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontrolmedia
struct LINEMEDIACONTROLMEDIA
{
align (1):
    uint dwMediaModes;
    uint dwDuration;
    uint dwMediaControl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemediacontroltone
struct LINEMEDIACONTROLTONE
{
align (1):
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
    uint dwMediaControl;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemessage
struct LINEMESSAGE
{
align (1):
    uint   hDevice;
    uint   dwMessageID;
    size_t dwCallbackInstance;
    size_t dwParam1;
    size_t dwParam2;
    size_t dwParam3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linemonitortone
struct LINEMONITORTONE
{
align (1):
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproviderentry
struct LINEPROVIDERENTRY
{
align (1):
    uint dwPermanentProviderID;
    uint dwProviderFilenameSize;
    uint dwProviderFilenameOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproviderlist
struct LINEPROVIDERLIST
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumProviders;
    uint dwProviderListSize;
    uint dwProviderListOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-lineproxyrequest
struct LINEPROXYREQUEST
{
align (1):
    uint dwSize;
    uint dwClientMachineNameSize;
    uint dwClientMachineNameOffset;
    uint dwClientUserNameSize;
    uint dwClientUserNameOffset;
    uint dwClientAppAPIVersion;
    uint dwRequestType;
    union
    {
        struct SetAgentGroup
        {
        align (1):
            uint               dwAddressID;
            LINEAGENTGROUPLIST GroupList;
        }
        struct SetAgentState
        {
        align (1):
            uint dwAddressID;
            uint dwAgentState;
            uint dwNextAgentState;
        }
        struct SetAgentActivity
        {
        align (1):
            uint dwAddressID;
            uint dwActivityID;
        }
        struct GetAgentCaps
        {
        align (1):
            uint          dwAddressID;
            LINEAGENTCAPS AgentCaps;
        }
        struct GetAgentStatus
        {
        align (1):
            uint            dwAddressID;
            LINEAGENTSTATUS AgentStatus;
        }
        struct AgentSpecific
        {
        align (1):
            uint     dwAddressID;
            uint     dwAgentExtensionIDIndex;
            uint     dwSize;
            ubyte[1] Params; // Flexible array
        }
        struct GetAgentActivityList
        {
        align (1):
            uint dwAddressID;
            LINEAGENTACTIVITYLIST ActivityList;
        }
        struct GetAgentGroupList
        {
        align (1):
            uint               dwAddressID;
            LINEAGENTGROUPLIST GroupList;
        }
        struct CreateAgent
        {
        align (1):
            uint hAgent;
            uint dwAgentIDSize;
            uint dwAgentIDOffset;
            uint dwAgentPINSize;
            uint dwAgentPINOffset;
        }
        struct SetAgentStateEx
        {
        align (1):
            uint hAgent;
            uint dwAgentState;
            uint dwNextAgentState;
        }
        struct SetAgentMeasurementPeriod
        {
        align (1):
            uint hAgent;
            uint dwMeasurementPeriod;
        }
        struct GetAgentInfo
        {
        align (1):
            uint          hAgent;
            LINEAGENTINFO AgentInfo;
        }
        struct CreateAgentSession
        {
        align (1):
            uint hAgentSession;
            uint dwAgentPINSize;
            uint dwAgentPINOffset;
            uint hAgent;
            GUID GroupID;
            uint dwWorkingAddressID;
        }
        struct GetAgentSessionList
        {
        align (1):
            uint                 hAgent;
            LINEAGENTSESSIONLIST SessionList;
        }
        struct GetAgentSessionInfo
        {
        align (1):
            uint                 hAgentSession;
            LINEAGENTSESSIONINFO SessionInfo;
        }
        struct SetAgentSessionState
        {
        align (1):
            uint hAgentSession;
            uint dwAgentSessionState;
            uint dwNextAgentSessionState;
        }
        struct GetQueueList
        {
        align (1):
            GUID          GroupID;
            LINEQUEUELIST QueueList;
        }
        struct SetQueueMeasurementPeriod
        {
        align (1):
            uint dwQueueID;
            uint dwMeasurementPeriod;
        }
        struct GetQueueInfo
        {
        align (1):
            uint          dwQueueID;
            LINEQUEUEINFO QueueInfo;
        }
        struct GetGroupList
        {
            LINEAGENTGROUPLIST GroupList;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linereqmakecall
struct LINEREQMAKECALL
{
    CHAR[80] szDestAddress;
    CHAR[40] szAppName;
    CHAR[40] szCalledParty;
    CHAR[80] szComment;
}

struct LINEREQMAKECALLW
{
align (1):
    wchar[80] szDestAddress;
    wchar[40] szAppName;
    wchar[40] szCalledParty;
    wchar[80] szComment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linereqmediacall
struct LINEREQMEDIACALL
{
align (1):
    HWND      hWnd;
    WPARAM    wRequestID;
    CHAR[40]  szDeviceClass;
    ubyte[40] ucDeviceID;
    uint      dwSize;
    uint      dwSecure;
    CHAR[80]  szDestAddress;
    CHAR[40]  szAppName;
    CHAR[40]  szCalledParty;
    CHAR[80]  szComment;
}

struct LINEREQMEDIACALLW
{
align (1):
    HWND      hWnd;
    WPARAM    wRequestID;
    wchar[40] szDeviceClass;
    ubyte[40] ucDeviceID;
    uint      dwSize;
    uint      dwSecure;
    wchar[80] szDestAddress;
    wchar[40] szAppName;
    wchar[40] szCalledParty;
    wchar[80] szComment;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetermcaps
struct LINETERMCAPS
{
align (1):
    uint dwTermDev;
    uint dwTermModes;
    uint dwTermSharing;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetranslatecaps
struct LINETRANSLATECAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwNumLocations;
    uint dwLocationListSize;
    uint dwLocationListOffset;
    uint dwCurrentLocationID;
    uint dwNumCards;
    uint dwCardListSize;
    uint dwCardListOffset;
    uint dwCurrentPreferredCardID;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-linetranslateoutput
struct LINETRANSLATEOUTPUT
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwDialableStringSize;
    uint dwDialableStringOffset;
    uint dwDisplayableStringSize;
    uint dwDisplayableStringOffset;
    uint dwCurrentCountry;
    uint dwDestCountry;
    uint dwTranslateResults;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonebuttoninfo
struct PHONEBUTTONINFO
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwButtonMode;
    uint dwButtonFunction;
    uint dwButtonTextSize;
    uint dwButtonTextOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwButtonState;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonecaps
struct PHONECAPS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwProviderInfoSize;
    uint dwProviderInfoOffset;
    uint dwPhoneInfoSize;
    uint dwPhoneInfoOffset;
    uint dwPermanentPhoneID;
    uint dwPhoneNameSize;
    uint dwPhoneNameOffset;
    uint dwStringFormat;
    uint dwPhoneStates;
    uint dwHookSwitchDevs;
    uint dwHandsetHookSwitchModes;
    uint dwSpeakerHookSwitchModes;
    uint dwHeadsetHookSwitchModes;
    uint dwVolumeFlags;
    uint dwGainFlags;
    uint dwDisplayNumRows;
    uint dwDisplayNumColumns;
    uint dwNumRingModes;
    uint dwNumButtonLamps;
    uint dwButtonModesSize;
    uint dwButtonModesOffset;
    uint dwButtonFunctionsSize;
    uint dwButtonFunctionsOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwNumSetData;
    uint dwSetDataSize;
    uint dwSetDataOffset;
    uint dwNumGetData;
    uint dwGetDataSize;
    uint dwGetDataOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwDeviceClassesSize;
    uint dwDeviceClassesOffset;
    uint dwPhoneFeatures;
    uint dwSettableHandsetHookSwitchModes;
    uint dwSettableSpeakerHookSwitchModes;
    uint dwSettableHeadsetHookSwitchModes;
    uint dwMonitoredHandsetHookSwitchModes;
    uint dwMonitoredSpeakerHookSwitchModes;
    uint dwMonitoredHeadsetHookSwitchModes;
    GUID PermanentPhoneGuid;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phoneextensionid
struct PHONEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phoneinitializeexparams
struct PHONEINITIALIZEEXPARAMS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwOptions;
    union Handles
    {
    align (1):
        HANDLE hEvent;
        HANDLE hCompletionPort;
    }
    uint dwCompletionKey;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonemessage
struct PHONEMESSAGE
{
align (1):
    uint   hDevice;
    uint   dwMessageID;
    size_t dwCallbackInstance;
    size_t dwParam1;
    size_t dwParam2;
    size_t dwParam3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-phonestatus
struct PHONESTATUS
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStatusFlags;
    uint dwNumOwners;
    uint dwNumMonitors;
    uint dwRingMode;
    uint dwRingVolume;
    uint dwHandsetHookSwitchMode;
    uint dwHandsetVolume;
    uint dwHandsetGain;
    uint dwSpeakerHookSwitchMode;
    uint dwSpeakerVolume;
    uint dwSpeakerGain;
    uint dwHeadsetHookSwitchMode;
    uint dwHeadsetVolume;
    uint dwHeadsetGain;
    uint dwDisplaySize;
    uint dwDisplayOffset;
    uint dwLampModesSize;
    uint dwLampModesOffset;
    uint dwOwnerNameSize;
    uint dwOwnerNameOffset;
    uint dwDevSpecificSize;
    uint dwDevSpecificOffset;
    uint dwPhoneFeatures;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/ns-tapi-varstring
struct VARSTRING
{
align (1):
    uint dwTotalSize;
    uint dwNeededSize;
    uint dwUsedSize;
    uint dwStringFormat;
    uint dwStringSize;
    uint dwStringOffset;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tspi/ns-tspi-tuispicreatedialoginstanceparams
struct TUISPICREATEDIALOGINSTANCEPARAMS
{
    uint               dwRequestID;
    HDRVDIALOGINSTANCE hdDlgInst;
    uint               htDlgInst;
    const(PWSTR)       lpszUIDLLName;
    void*              lpParams;
    uint               dwSize;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ns-tapi3if-tapi_customtone
struct TAPI_CUSTOMTONE
{
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/ns-tapi3if-tapi_detecttone
struct TAPI_DETECTTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/ns-msp-msp_event_info
struct MSP_EVENT_INFO
{
    uint      dwSize;
    MSP_EVENT Event;
    int*      hCall;
    union
    {
        struct MSP_ADDRESS_EVENT_INFO
        {
            MSP_ADDRESS_EVENT Type;
            ITTerminal        pTerminal;
        }
        struct MSP_CALL_EVENT_INFO
        {
            MSP_CALL_EVENT       Type;
            MSP_CALL_EVENT_CAUSE Cause;
            ITStream             pStream;
            ITTerminal           pTerminal;
            HRESULT              hrError;
        }
        struct MSP_TSP_DATA
        {
            uint     dwBufferSize;
            ubyte[1] pBuffer; // Flexible array
        }
        struct MSP_PRIVATE_EVENT_INFO
        {
            IDispatch pEvent;
            int       lEventCode;
        }
        struct MSP_FILE_TERMINAL_EVENT_INFO
        {
            ITTerminal           pParentFileTerminal;
            ITFileTrack          pFileTrack;
            TERMINAL_MEDIA_STATE TerminalMediaState;
            FT_STATE_EVENT_CAUSE ftecEventCause;
            HRESULT              hrErrorCode;
        }
        struct MSP_ASR_TERMINAL_EVENT_INFO
        {
            ITTerminal pASRTerminal;
            HRESULT    hrErrorCode;
        }
        struct MSP_TTS_TERMINAL_EVENT_INFO
        {
            ITTerminal pTTSTerminal;
            HRESULT    hrErrorCode;
        }
        struct MSP_TONE_TERMINAL_EVENT_INFO
        {
            ITTerminal pToneTerminal;
            HRESULT    hrErrorCode;
        }
    }
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/stnefproblem
struct STnefProblem
{
    uint ulComponent;
    uint ulAttribute;
    uint ulPropTag;
    int  scode;
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/stnefproblemarray
struct STnefProblemArray
{
    uint            cProblem;
    STnefProblem[1] aProblem; // Flexible array
}

struct RENDDATA
{
align (1):
    ushort atyp;
    uint   ulPosition;
    ushort dxWidth;
    ushort dyHeight;
    uint   dwFlags;
}

struct DTR
{
align (1):
    ushort wYear;
    ushort wMonth;
    ushort wDay;
    ushort wHour;
    ushort wMinute;
    ushort wSecond;
    ushort wDayOfWeek;
}

struct TRP
{
    ushort trpid;
    ushort cbgrtrp;
    ushort cch;
    ushort cbRgb;
}

struct ADDRALIAS
{
    CHAR[41] rgchName;
    CHAR[11] rgchEName;
    CHAR[12] rgchSrvr;
    uint     dibDetail;
    ushort   type;
}

struct NSID
{
    uint      dwSize;
    ubyte[16] uchType;
    uint      xtype;
    int       lTime;
    union address
    {
        ADDRALIAS alias_;
        CHAR[1]   rgchInterNet; // Flexible array
    }
}

// Functions

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineaccept
@DllImport("TAPI32.dll")
int lineAccept(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineAddProvider(const(PSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineAddProviderA(const(PSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineAddProviderW(const(PWSTR) lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineaddtoconference
@DllImport("TAPI32.dll")
int lineAddToConference(uint hConfCall, uint hConsultCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineagentspecific
@DllImport("TAPI32.dll")
int lineAgentSpecific(uint hLine, uint dwAddressID, uint dwAgentExtensionIDIndex, void* lpParams, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineanswer
@DllImport("TAPI32.dll")
int lineAnswer(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineBlindTransfer(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineBlindTransferA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineBlindTransferW(uint hCall, const(PWSTR) lpszDestAddressW, uint dwCountryCode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineclose
@DllImport("TAPI32.dll")
int lineClose(uint hLine);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linecompletecall
@DllImport("TAPI32.dll")
int lineCompleteCall(uint hCall, uint* lpdwCompletionID, uint dwCompletionMode, uint dwMessageID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linecompletetransfer
@DllImport("TAPI32.dll")
int lineCompleteTransfer(uint hCall, uint hConsultCall, uint* lphConfCall, uint dwTransferMode);

@DllImport("TAPI32.dll")
int lineConfigDialog(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineConfigDialogEdit(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass, 
                         const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32.dll")
int lineConfigDialogEditA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32.dll")
int lineConfigDialogEditW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineconfigprovider
@DllImport("TAPI32.dll")
int lineConfigProvider(HWND hwndOwner, uint dwPermanentProviderID);

@DllImport("TAPI32.dll")
int lineCreateAgentW(uint hLine, const(PWSTR) lpszAgentID, const(PWSTR) lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32.dll")
int lineCreateAgentA(uint hLine, const(PSTR) lpszAgentID, const(PSTR) lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32.dll")
int lineCreateAgentSessionW(uint hLine, uint hAgent, const(PWSTR) lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

@DllImport("TAPI32.dll")
int lineCreateAgentSessionA(uint hLine, uint hAgent, const(PSTR) lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedeallocatecall
@DllImport("TAPI32.dll")
int lineDeallocateCall(uint hCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedevspecific
@DllImport("TAPI32.dll")
int lineDevSpecific(uint hLine, uint dwAddressID, uint hCall, void* lpParams, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedevspecificfeature
@DllImport("TAPI32.dll")
int lineDevSpecificFeature(uint hLine, uint dwFeature, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int lineDial(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineDialA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineDialW(uint hCall, const(PWSTR) lpszDestAddress, uint dwCountryCode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linedrop
@DllImport("TAPI32.dll")
int lineDrop(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32.dll")
int lineForward(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineForwardA(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineForwardW(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineGatherDigits(uint hCall, uint dwDigitModes, PSTR lpsDigits, uint dwNumDigits, 
                     const(PSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGatherDigitsA(uint hCall, uint dwDigitModes, PSTR lpsDigits, uint dwNumDigits, 
                      const(PSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGatherDigitsW(uint hCall, uint dwDigitModes, PWSTR lpsDigits, uint dwNumDigits, 
                      const(PWSTR) lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32.dll")
int lineGenerateDigits(uint hCall, uint dwDigitMode, const(PSTR) lpszDigits, uint dwDuration);

@DllImport("TAPI32.dll")
int lineGenerateDigitsA(uint hCall, uint dwDigitMode, const(PSTR) lpszDigits, uint dwDuration);

@DllImport("TAPI32.dll")
int lineGenerateDigitsW(uint hCall, uint dwDigitMode, const(PWSTR) lpszDigits, uint dwDuration);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegeneratetone
@DllImport("TAPI32.dll")
int lineGenerateTone(uint hCall, uint dwToneMode, uint dwDuration, uint dwNumTones, 
                     const(LINEGENERATETONE)* lpTones);

@DllImport("TAPI32.dll")
int lineGetAddressCaps(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                       LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32.dll")
int lineGetAddressID(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PSTR) lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressIDA(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PSTR) lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressIDW(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(PWSTR) lpsAddress, uint dwSize);

@DllImport("TAPI32.dll")
int lineGetAddressStatus(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAddressStatusA(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAddressStatusW(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32.dll")
int lineGetAgentActivityListA(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32.dll")
int lineGetAgentActivityListW(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32.dll")
int lineGetAgentCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32.dll")
int lineGetAgentCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32.dll")
int lineGetAgentGroupListA(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32.dll")
int lineGetAgentGroupListW(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentinfo
@DllImport("TAPI32.dll")
int lineGetAgentInfo(uint hLine, uint hAgent, LINEAGENTINFO* lpAgentInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentsessioninfo
@DllImport("TAPI32.dll")
int lineGetAgentSessionInfo(uint hLine, uint hAgentSession, LINEAGENTSESSIONINFO* lpAgentSessionInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetagentsessionlist
@DllImport("TAPI32.dll")
int lineGetAgentSessionList(uint hLine, uint hAgent, LINEAGENTSESSIONLIST* lpAgentSessionList);

@DllImport("TAPI32.dll")
int lineGetAgentStatusA(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32.dll")
int lineGetAgentStatusW(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32.dll")
int lineGetAppPriority(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetAppPriorityA(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetAppPriorityW(const(PWSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32.dll")
int lineGetCallInfo(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32.dll")
int lineGetCallInfoA(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32.dll")
int lineGetCallInfoW(uint hCall, LINECALLINFO* lpCallInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetcallstatus
@DllImport("TAPI32.dll")
int lineGetCallStatus(uint hCall, LINECALLSTATUS* lpCallStatus);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetconfrelatedcalls
@DllImport("TAPI32.dll")
int lineGetConfRelatedCalls(uint hCall, LINECALLLIST* lpCallList);

@DllImport("TAPI32.dll")
int lineGetCountry(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetCountryA(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetCountryW(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32.dll")
int lineGetDevCaps(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                   LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevCapsA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevCapsW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32.dll")
int lineGetDevConfig(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetDevConfigA(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetDevConfigW(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(PWSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetGroupListA(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32.dll")
int lineGetGroupListW(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32.dll")
int lineGetIcon(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int lineGetIconA(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int lineGetIconW(uint dwDeviceID, const(PWSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int lineGetID(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
              const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetIDA(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetIDW(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(PWSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineGetLineDevStatus(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32.dll")
int lineGetLineDevStatusA(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32.dll")
int lineGetLineDevStatusW(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetmessage
@DllImport("TAPI32.dll")
int lineGetMessage(uint hLineApp, LINEMESSAGE* lpMessage, uint dwTimeout);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetnewcalls
@DllImport("TAPI32.dll")
int lineGetNewCalls(uint hLine, uint dwAddressID, uint dwSelect, LINECALLLIST* lpCallList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetnumrings
@DllImport("TAPI32.dll")
int lineGetNumRings(uint hLine, uint dwAddressID, uint* lpdwNumRings);

@DllImport("TAPI32.dll")
int lineGetProviderList(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32.dll")
int lineGetProviderListA(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32.dll")
int lineGetProviderListW(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetproxystatus
@DllImport("TAPI32.dll")
int lineGetProxyStatus(uint hLineApp, uint dwDeviceID, uint dwAppAPIVersion, 
                       LINEPROXYREQUESTLIST* lpLineProxyReqestList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetqueueinfo
@DllImport("TAPI32.dll")
int lineGetQueueInfo(uint hLine, uint dwQueueID, LINEQUEUEINFO* lpLineQueueInfo);

@DllImport("TAPI32.dll")
int lineGetQueueListA(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32.dll")
int lineGetQueueListW(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32.dll")
int lineGetRequest(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32.dll")
int lineGetRequestA(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32.dll")
int lineGetRequestW(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linegetstatusmessages
@DllImport("TAPI32.dll")
int lineGetStatusMessages(uint hLine, uint* lpdwLineStates, uint* lpdwAddressStates);

@DllImport("TAPI32.dll")
int lineGetTranslateCaps(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineGetTranslateCapsA(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineGetTranslateCapsW(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32.dll")
int lineHandoff(uint hCall, const(PSTR) lpszFileName, uint dwMediaMode);

@DllImport("TAPI32.dll")
int lineHandoffA(uint hCall, const(PSTR) lpszFileName, uint dwMediaMode);

@DllImport("TAPI32.dll")
int lineHandoffW(uint hCall, const(PWSTR) lpszFileName, uint dwMediaMode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linehold
@DllImport("TAPI32.dll")
int lineHold(uint hCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineinitialize
@DllImport("TAPI32.dll")
int lineInitialize(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(PSTR) lpszAppName, 
                   uint* lpdwNumDevs);

@DllImport("TAPI32.dll")
int lineInitializeExA(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(PSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32.dll")
int lineInitializeExW(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(PWSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32.dll")
int lineMakeCall(uint hLine, uint* lphCall, const(PSTR) lpszDestAddress, uint dwCountryCode, 
                 const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineMakeCallA(uint hLine, uint* lphCall, const(PSTR) lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineMakeCallW(uint hLine, uint* lphCall, const(PWSTR) lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitordigits
@DllImport("TAPI32.dll")
int lineMonitorDigits(uint hCall, uint dwDigitModes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitormedia
@DllImport("TAPI32.dll")
int lineMonitorMedia(uint hCall, uint dwMediaModes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linemonitortones
@DllImport("TAPI32.dll")
int lineMonitorTones(uint hCall, const(LINEMONITORTONE)* lpToneList, uint dwNumEntries);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linenegotiateapiversion
@DllImport("TAPI32.dll")
int lineNegotiateAPIVersion(uint hLineApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                            uint* lpdwAPIVersion, LINEEXTENSIONID* lpExtensionID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linenegotiateextversion
@DllImport("TAPI32.dll")
int lineNegotiateExtVersion(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                            uint dwExtHighVersion, uint* lpdwExtVersion);

@DllImport("TAPI32.dll")
int lineOpen(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
             size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineOpenA(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineOpenW(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePark(uint hCall, uint dwParkMode, const(PSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int lineParkA(uint hCall, uint dwParkMode, const(PSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int lineParkW(uint hCall, uint dwParkMode, const(PWSTR) lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32.dll")
int linePickup(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress, const(PSTR) lpszGroupID);

@DllImport("TAPI32.dll")
int linePickupA(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress, const(PSTR) lpszGroupID);

@DllImport("TAPI32.dll")
int linePickupW(uint hLine, uint dwAddressID, uint* lphCall, const(PWSTR) lpszDestAddress, 
                const(PWSTR) lpszGroupID);

@DllImport("TAPI32.dll")
int linePrepareAddToConference(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePrepareAddToConferenceA(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int linePrepareAddToConferenceW(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineproxymessage
@DllImport("TAPI32.dll")
int lineProxyMessage(uint hLine, uint hCall, uint dwMsg, uint dwParam1, uint dwParam2, uint dwParam3);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineproxyresponse
@DllImport("TAPI32.dll")
int lineProxyResponse(uint hLine, LINEPROXYREQUEST* lpProxyRequest, uint dwResult);

@DllImport("TAPI32.dll")
int lineRedirect(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineRedirectA(uint hCall, const(PSTR) lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32.dll")
int lineRedirectW(uint hCall, const(PWSTR) lpszDestAddress, uint dwCountryCode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineregisterrequestrecipient
@DllImport("TAPI32.dll")
int lineRegisterRequestRecipient(uint hLineApp, uint dwRegistrationInstance, uint dwRequestMode, uint bEnable);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linereleaseuseruserinfo
@DllImport("TAPI32.dll")
int lineReleaseUserUserInfo(uint hCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineremovefromconference
@DllImport("TAPI32.dll")
int lineRemoveFromConference(uint hCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineremoveprovider
@DllImport("TAPI32.dll")
int lineRemoveProvider(uint dwPermanentProviderID, HWND hwndOwner);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesecurecall
@DllImport("TAPI32.dll")
int lineSecureCall(uint hCall);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesenduseruserinfo
@DllImport("TAPI32.dll")
int lineSendUserUserInfo(uint hCall, const(PSTR) lpsUserUserInfo, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentactivity
@DllImport("TAPI32.dll")
int lineSetAgentActivity(uint hLine, uint dwAddressID, uint dwActivityID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentgroup
@DllImport("TAPI32.dll")
int lineSetAgentGroup(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentmeasurementperiod
@DllImport("TAPI32.dll")
int lineSetAgentMeasurementPeriod(uint hLine, uint hAgent, uint dwMeasurementPeriod);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentsessionstate
@DllImport("TAPI32.dll")
int lineSetAgentSessionState(uint hLine, uint hAgentSession, uint dwAgentSessionState, 
                             uint dwNextAgentSessionState);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentstateex
@DllImport("TAPI32.dll")
int lineSetAgentStateEx(uint hLine, uint hAgent, uint dwAgentState, uint dwNextAgentState);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetagentstate
@DllImport("TAPI32.dll")
int lineSetAgentState(uint hLine, uint dwAddressID, uint dwAgentState, uint dwNextAgentState);

@DllImport("TAPI32.dll")
int lineSetAppPriority(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, const(PSTR) lpszExtensionName, uint dwPriority);

@DllImport("TAPI32.dll")
int lineSetAppPriorityA(const(PSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(PSTR) lpszExtensionName, uint dwPriority);

@DllImport("TAPI32.dll")
int lineSetAppPriorityW(const(PWSTR) lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(PWSTR) lpszExtensionName, uint dwPriority);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetappspecific
@DllImport("TAPI32.dll")
int lineSetAppSpecific(uint hCall, uint dwAppSpecific);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcalldata
@DllImport("TAPI32.dll")
int lineSetCallData(uint hCall, void* lpCallData, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallparams
@DllImport("TAPI32.dll")
int lineSetCallParams(uint hCall, uint dwBearerMode, uint dwMinRate, uint dwMaxRate, 
                      const(LINEDIALPARAMS)* lpDialParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallprivilege
@DllImport("TAPI32.dll")
int lineSetCallPrivilege(uint hCall, uint dwCallPrivilege);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcallqualityofservice
@DllImport("TAPI32.dll")
int lineSetCallQualityOfService(uint hCall, void* lpSendingFlowspec, uint dwSendingFlowspecSize, 
                                void* lpReceivingFlowspec, uint dwReceivingFlowspecSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcalltreatment
@DllImport("TAPI32.dll")
int lineSetCallTreatment(uint hCall, uint dwTreatment);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetcurrentlocation
@DllImport("TAPI32.dll")
int lineSetCurrentLocation(uint hLineApp, uint dwLocation);

@DllImport("TAPI32.dll")
int lineSetDevConfig(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineSetDevConfigA(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int lineSetDevConfigW(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(PWSTR) lpszDeviceClass);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetlinedevstatus
@DllImport("TAPI32.dll")
int lineSetLineDevStatus(uint hLine, uint dwStatusToChange, uint fStatus);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetmediacontrol
@DllImport("TAPI32.dll")
int lineSetMediaControl(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, 
                        const(LINEMEDIACONTROLDIGIT)* lpDigitList, uint dwDigitNumEntries, 
                        const(LINEMEDIACONTROLMEDIA)* lpMediaList, uint dwMediaNumEntries, 
                        const(LINEMEDIACONTROLTONE)* lpToneList, uint dwToneNumEntries, 
                        const(LINEMEDIACONTROLCALLSTATE)* lpCallStateList, uint dwCallStateNumEntries);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetmediamode
@DllImport("TAPI32.dll")
int lineSetMediaMode(uint hCall, uint dwMediaModes);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetqueuemeasurementperiod
@DllImport("TAPI32.dll")
int lineSetQueueMeasurementPeriod(uint hLine, uint dwQueueID, uint dwMeasurementPeriod);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetnumrings
@DllImport("TAPI32.dll")
int lineSetNumRings(uint hLine, uint dwAddressID, uint dwNumRings);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetstatusmessages
@DllImport("TAPI32.dll")
int lineSetStatusMessages(uint hLine, uint dwLineStates, uint dwAddressStates);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-linesetterminal
@DllImport("TAPI32.dll")
int lineSetTerminal(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, uint dwTerminalModes, 
                    uint dwTerminalID, uint bEnable);

@DllImport("TAPI32.dll")
int lineSetTollList(uint hLineApp, uint dwDeviceID, const(PSTR) lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetTollListA(uint hLineApp, uint dwDeviceID, const(PSTR) lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetTollListW(uint hLineApp, uint dwDeviceID, const(PWSTR) lpszAddressInW, uint dwTollListOption);

@DllImport("TAPI32.dll")
int lineSetupConference(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                        const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupConferenceA(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupConferenceW(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransfer(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransferA(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32.dll")
int lineSetupTransferW(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineshutdown
@DllImport("TAPI32.dll")
int lineShutdown(uint hLineApp);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineswaphold
@DllImport("TAPI32.dll")
int lineSwapHold(uint hActiveCall, uint hHeldCall);

@DllImport("TAPI32.dll")
int lineTranslateAddress(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PSTR) lpszAddressIn, uint dwCard, 
                         uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateAddressA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PSTR) lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateAddressW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(PWSTR) lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32.dll")
int lineTranslateDialog(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                        const(PSTR) lpszAddressIn);

@DllImport("TAPI32.dll")
int lineTranslateDialogA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(PSTR) lpszAddressIn);

@DllImport("TAPI32.dll")
int lineTranslateDialogW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(PWSTR) lpszAddressIn);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineuncompletecall
@DllImport("TAPI32.dll")
int lineUncompleteCall(uint hLine, uint dwCompletionID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-lineunhold
@DllImport("TAPI32.dll")
int lineUnhold(uint hCall);

@DllImport("TAPI32.dll")
int lineUnpark(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress);

@DllImport("TAPI32.dll")
int lineUnparkA(uint hLine, uint dwAddressID, uint* lphCall, const(PSTR) lpszDestAddress);

@DllImport("TAPI32.dll")
int lineUnparkW(uint hLine, uint dwAddressID, uint* lphCall, const(PWSTR) lpszDestAddress);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneclose
@DllImport("TAPI32.dll")
int phoneClose(uint hPhone);

@DllImport("TAPI32.dll")
int phoneConfigDialog(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(PWSTR) lpszDeviceClass);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonedevspecific
@DllImport("TAPI32.dll")
int phoneDevSpecific(uint hPhone, void* lpParams, uint dwSize);

@DllImport("TAPI32.dll")
int phoneGetButtonInfo(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneGetButtonInfoA(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneGetButtonInfoW(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetdata
@DllImport("TAPI32.dll")
int phoneGetData(uint hPhone, uint dwDataID, void* lpData, uint dwSize);

@DllImport("TAPI32.dll")
int phoneGetDevCaps(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32.dll")
int phoneGetDevCapsA(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32.dll")
int phoneGetDevCapsW(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetdisplay
@DllImport("TAPI32.dll")
int phoneGetDisplay(uint hPhone, VARSTRING* lpDisplay);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetgain
@DllImport("TAPI32.dll")
int phoneGetGain(uint hPhone, uint dwHookSwitchDev, uint* lpdwGain);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegethookswitch
@DllImport("TAPI32.dll")
int phoneGetHookSwitch(uint hPhone, uint* lpdwHookSwitchDevs);

@DllImport("TAPI32.dll")
int phoneGetIcon(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetIconA(uint dwDeviceID, const(PSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetIconW(uint dwDeviceID, const(PWSTR) lpszDeviceClass, HICON* lphIcon);

@DllImport("TAPI32.dll")
int phoneGetID(uint hPhone, VARSTRING* lpDeviceID, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneGetIDA(uint hPhone, VARSTRING* lpDeviceID, const(PSTR) lpszDeviceClass);

@DllImport("TAPI32.dll")
int phoneGetIDW(uint hPhone, VARSTRING* lpDeviceID, const(PWSTR) lpszDeviceClass);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetlamp
@DllImport("TAPI32.dll")
int phoneGetLamp(uint hPhone, uint dwButtonLampID, uint* lpdwLampMode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetmessage
@DllImport("TAPI32.dll")
int phoneGetMessage(uint hPhoneApp, PHONEMESSAGE* lpMessage, uint dwTimeout);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetring
@DllImport("TAPI32.dll")
int phoneGetRing(uint hPhone, uint* lpdwRingMode, uint* lpdwVolume);

@DllImport("TAPI32.dll")
int phoneGetStatus(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32.dll")
int phoneGetStatusA(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32.dll")
int phoneGetStatusW(uint hPhone, PHONESTATUS* lpPhoneStatus);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetstatusmessages
@DllImport("TAPI32.dll")
int phoneGetStatusMessages(uint hPhone, uint* lpdwPhoneStates, uint* lpdwButtonModes, uint* lpdwButtonStates);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonegetvolume
@DllImport("TAPI32.dll")
int phoneGetVolume(uint hPhone, uint dwHookSwitchDev, uint* lpdwVolume);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneinitialize
@DllImport("TAPI32.dll")
int phoneInitialize(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(PSTR) lpszAppName, 
                    uint* lpdwNumDevs);

@DllImport("TAPI32.dll")
int phoneInitializeExA(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(PSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

@DllImport("TAPI32.dll")
int phoneInitializeExW(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(PWSTR) lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonenegotiateapiversion
@DllImport("TAPI32.dll")
int phoneNegotiateAPIVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                             uint* lpdwAPIVersion, PHONEEXTENSIONID* lpExtensionID);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonenegotiateextversion
@DllImport("TAPI32.dll")
int phoneNegotiateExtVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                             uint dwExtHighVersion, uint* lpdwExtVersion);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneopen
@DllImport("TAPI32.dll")
int phoneOpen(uint hPhoneApp, uint dwDeviceID, uint* lphPhone, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivilege);

@DllImport("TAPI32.dll")
int phoneSetButtonInfo(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneSetButtonInfoA(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32.dll")
int phoneSetButtonInfoW(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetdata
@DllImport("TAPI32.dll")
int phoneSetData(uint hPhone, uint dwDataID, const(void)* lpData, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetdisplay
@DllImport("TAPI32.dll")
int phoneSetDisplay(uint hPhone, uint dwRow, uint dwColumn, const(PSTR) lpsDisplay, uint dwSize);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetgain
@DllImport("TAPI32.dll")
int phoneSetGain(uint hPhone, uint dwHookSwitchDev, uint dwGain);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesethookswitch
@DllImport("TAPI32.dll")
int phoneSetHookSwitch(uint hPhone, uint dwHookSwitchDevs, uint dwHookSwitchMode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetlamp
@DllImport("TAPI32.dll")
int phoneSetLamp(uint hPhone, uint dwButtonLampID, uint dwLampMode);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetring
@DllImport("TAPI32.dll")
int phoneSetRing(uint hPhone, uint dwRingMode, uint dwVolume);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetstatusmessages
@DllImport("TAPI32.dll")
int phoneSetStatusMessages(uint hPhone, uint dwPhoneStates, uint dwButtonModes, uint dwButtonStates);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phonesetvolume
@DllImport("TAPI32.dll")
int phoneSetVolume(uint hPhone, uint dwHookSwitchDev, uint dwVolume);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-phoneshutdown
@DllImport("TAPI32.dll")
int phoneShutdown(uint hPhoneApp);

@DllImport("TAPI32.dll")
int tapiGetLocationInfo(PSTR lpszCountryCode, PSTR lpszCityCode);

@DllImport("TAPI32.dll")
int tapiGetLocationInfoA(PSTR lpszCountryCode, PSTR lpszCityCode);

@DllImport("TAPI32.dll")
int tapiGetLocationInfoW(PWSTR lpszCountryCodeW, PWSTR lpszCityCodeW);

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi/nf-tapi-tapirequestdrop
@DllImport("TAPI32.dll")
int tapiRequestDrop(HWND hwnd, WPARAM wRequestID);

@DllImport("TAPI32.dll")
int tapiRequestMakeCall(const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, const(PSTR) lpszCalledParty, 
                        const(PSTR) lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMakeCallA(const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, const(PSTR) lpszCalledParty, 
                         const(PSTR) lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMakeCallW(const(PWSTR) lpszDestAddress, const(PWSTR) lpszAppName, const(PWSTR) lpszCalledParty, 
                         const(PWSTR) lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCall(HWND hwnd, WPARAM wRequestID, const(PSTR) lpszDeviceClass, const(PSTR) lpDeviceID, 
                         uint dwSize, uint dwSecure, const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, 
                         const(PSTR) lpszCalledParty, const(PSTR) lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCallA(HWND hwnd, WPARAM wRequestID, const(PSTR) lpszDeviceClass, const(PSTR) lpDeviceID, 
                          uint dwSize, uint dwSecure, const(PSTR) lpszDestAddress, const(PSTR) lpszAppName, 
                          const(PSTR) lpszCalledParty, const(PSTR) lpszComment);

@DllImport("TAPI32.dll")
int tapiRequestMediaCallW(HWND hwnd, WPARAM wRequestID, const(PWSTR) lpszDeviceClass, const(PWSTR) lpDeviceID, 
                          uint dwSize, uint dwSecure, const(PWSTR) lpszDestAddress, const(PWSTR) lpszAppName, 
                          const(PWSTR) lpszCalledParty, const(PWSTR) lpszComment);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/opentnefstream
@DllImport("MAPI32.dll")
HRESULT OpenTnefStream(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, IMessage lpMessage, 
                       ushort wKeyVal, ITnef* lppTNEF);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/opentnefstreamex
@DllImport("MAPI32.dll")
HRESULT OpenTnefStreamEx(void* lpvSupport, IStream lpStream, byte* lpszStreamName, uint ulFlags, 
                         IMessage lpMessage, ushort wKeyVal, IAddrBook lpAdressBook, ITnef* lppTNEF);

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/gettnefstreamcodepage
@DllImport("MAPI32.dll")
HRESULT GetTnefStreamCodepage(IStream lpStream, uint* lpulCodepage, uint* lpulSubCodepage);


// Interfaces

@GUID("21d6d48e-a88b-11d0-83dd-00aa003ccabd")
struct TAPI;

@GUID("e9225296-c759-11d1-a02b-00c04fb6809f")
struct DispatchMapper;

@GUID("ac48ffe0-f8c4-11d1-a030-00c04fb6809f")
struct RequestMakeCall;

@GUID("f1029e5b-cb5b-11d0-8d59-00c04fd91ac0")
struct Rendezvous;

@GUID("df0daef2-a289-11d1-8697-006008b0e5d2")
struct McastAddressAllocation;

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapi
@GUID("b1efc382-9355-11d0-835c-00aa003ccabd")
interface ITTAPI : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-initialize
    HRESULT Initialize();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-shutdown
    HRESULT Shutdown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_addresses
    HRESULT get_Addresses(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumerateaddresses
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-registercallnotifications
    HRESULT RegisterCallNotifications(ITAddress pAddress, VARIANT_BOOL fMonitor, VARIANT_BOOL fOwner, 
                                      int lMediaTypes, int lCallbackInstance, int* plRegister);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-unregisternotifications
    HRESULT UnregisterNotifications(int lRegister);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_callhubs
    HRESULT get_CallHubs(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumeratecallhubs
    HRESULT EnumerateCallHubs(IEnumCallHub* ppEnumCallHub);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setcallhubtracking
    HRESULT SetCallHubTracking(VARIANT pAddresses, VARIANT_BOOL bTracking);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-enumerateprivatetapiobjects
    HRESULT EnumeratePrivateTAPIObjects(IEnumUnknown* ppEnumUnknown);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_privatetapiobjects
    HRESULT get_PrivateTAPIObjects(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-registerrequestrecipient
    HRESULT RegisterRequestRecipient(int lRegistrationInstance, int lRequestMode, VARIANT_BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setassistedtelephonypriority
    HRESULT SetAssistedTelephonyPriority(BSTR pAppFilename, VARIANT_BOOL fPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-setapplicationpriority
    HRESULT SetApplicationPriority(BSTR pAppFilename, int lMediaType, VARIANT_BOOL fPriority);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-put_eventfilter
    HRESULT put_EventFilter(int lFilterMask);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi-get_eventfilter
    HRESULT get_EventFilter(int* plFilterMask);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapi2
@GUID("54fbdc8c-d90f-4dad-9695-b373097f094b")
interface ITTAPI2 : ITTAPI
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-get_phones
    HRESULT get_Phones(VARIANT* pPhones);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-enumeratephones
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapi2-createemptycollectionobject
    HRESULT CreateEmptyCollectionObject(ITCollection2* ppCollection);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediasupport
@GUID("b1efc384-9355-11d0-835c-00aa003ccabd")
interface ITMediaSupport : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediasupport-get_mediatypes
    HRESULT get_MediaTypes(int* plMediaTypes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediasupport-querymediatype
    HRESULT QueryMediaType(int lMediaType, VARIANT_BOOL* pfSupport);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itpluggableterminalclassinfo
@GUID("41757f4a-cf09-4b34-bc96-0a79d2390076")
interface ITPluggableTerminalClassInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_company
    HRESULT get_Company(BSTR* pCompany);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_version
    HRESULT get_Version(BSTR* pVersion);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_terminalclass
    HRESULT get_TerminalClass(BSTR* pTerminalClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_clsid
    HRESULT get_CLSID(BSTR* pCLSID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_direction
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalclassinfo-get_mediatypes
    HRESULT get_MediaTypes(int* pMediaTypes);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itpluggableterminalsuperclassinfo
@GUID("6d54e42c-4625-4359-a6f7-631999107e05")
interface ITPluggableTerminalSuperclassInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalsuperclassinfo-get_name
    HRESULT get_Name(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itpluggableterminalsuperclassinfo-get_clsid
    HRESULT get_CLSID(BSTR* pCLSID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminalsupport
@GUID("b1efc385-9355-11d0-835c-00aa003ccabd")
interface ITTerminalSupport : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-get_staticterminals
    HRESULT get_StaticTerminals(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-enumeratestaticterminals
    HRESULT EnumerateStaticTerminals(IEnumTerminal* ppTerminalEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-get_dynamicterminalclasses
    HRESULT get_DynamicTerminalClasses(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-enumeratedynamicterminalclasses
    HRESULT EnumerateDynamicTerminalClasses(IEnumTerminalClass* ppTerminalClassEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-createterminal
    HRESULT CreateTerminal(BSTR pTerminalClass, int lMediaType, TERMINAL_DIRECTION Direction, 
                           ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport-getdefaultstaticterminal
    HRESULT GetDefaultStaticTerminal(int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminalsupport2
@GUID("f3eb39bc-1b1f-4e99-a0c0-56305c4dd591")
interface ITTerminalSupport2 : ITTerminalSupport
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-get_pluggablesuperclasses
    HRESULT get_PluggableSuperclasses(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-enumeratepluggablesuperclasses
    HRESULT EnumeratePluggableSuperclasses(IEnumPluggableSuperclassInfo* ppSuperclassEnumerator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-get_pluggableterminalclasses
    HRESULT get_PluggableTerminalClasses(BSTR bstrTerminalSuperclass, int lMediaType, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminalsupport2-enumeratepluggableterminalclasses
    HRESULT EnumeratePluggableTerminalClasses(GUID iidTerminalSuperclass, int lMediaType, 
                                              IEnumPluggableTerminalClassInfo* ppClassEnumerator);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddress
@GUID("b1efc386-9355-11d0-835c-00aa003ccabd")
interface ITAddress : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_state
    HRESULT get_State(ADDRESS_STATE* pAddressState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_addressname
    HRESULT get_AddressName(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_serviceprovidername
    HRESULT get_ServiceProviderName(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_tapiobject
    HRESULT get_TAPIObject(ITTAPI* ppTapiObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-createcall
    HRESULT CreateCall(BSTR pDestAddress, int lAddressType, int lMediaTypes, ITBasicCallControl* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_calls
    HRESULT get_Calls(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-enumeratecalls
    HRESULT EnumerateCalls(IEnumCall* ppCallEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_dialableaddress
    HRESULT get_DialableAddress(BSTR* pDialableAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-createforwardinfoobject
    HRESULT CreateForwardInfoObject(ITForwardInformation* ppForwardInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-forward
    HRESULT Forward(ITForwardInformation pForwardInfo, ITBasicCallControl pCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_currentforwardinfo
    HRESULT get_CurrentForwardInfo(ITForwardInformation* ppForwardInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-put_messagewaiting
    HRESULT put_MessageWaiting(VARIANT_BOOL fMessageWaiting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_messagewaiting
    HRESULT get_MessageWaiting(VARIANT_BOOL* pfMessageWaiting);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-put_donotdisturb
    HRESULT put_DoNotDisturb(VARIANT_BOOL fDoNotDisturb);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress-get_donotdisturb
    HRESULT get_DoNotDisturb(VARIANT_BOOL* pfDoNotDisturb);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddress2
@GUID("b0ae5d9b-be51-46c9-b0f7-dfa8a22a8bc4")
interface ITAddress2 : ITAddress
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_phones
    HRESULT get_Phones(VARIANT* pPhones);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-enumeratephones
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-getphonefromterminal
    HRESULT GetPhoneFromTerminal(ITTerminal pTerminal, ITPhone* ppPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_preferredphones
    HRESULT get_PreferredPhones(VARIANT* pPhones);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-enumeratepreferredphones
    HRESULT EnumeratePreferredPhones(IEnumPhone* ppEnumPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-get_eventfilter
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL* pEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-put_eventfilter
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL bEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-devicespecific
    HRESULT DeviceSpecific(ITCallInfo pCall, ubyte* pParams, uint dwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-devicespecificvariant
    HRESULT DeviceSpecificVariant(ITCallInfo pCall, VARIANT varDevSpecificByteArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddress2-negotiateextversion
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresscapabilities
@GUID("8df232f5-821b-11d1-bb5c-00c04fb6809f")
interface ITAddressCapabilities : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_addresscapability
    HRESULT get_AddressCapability(ADDRESS_CAPABILITY AddressCap, int* plCapability);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_addresscapabilitystring
    HRESULT get_AddressCapabilityString(ADDRESS_CAPABILITY_STRING AddressCapString, BSTR* ppCapabilityString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_calltreatments
    HRESULT get_CallTreatments(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratecalltreatments
    HRESULT EnumerateCallTreatments(IEnumBstr* ppEnumCallTreatment);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_completionmessages
    HRESULT get_CompletionMessages(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratecompletionmessages
    HRESULT EnumerateCompletionMessages(IEnumBstr* ppEnumCompletionMessage);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-get_deviceclasses
    HRESULT get_DeviceClasses(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresscapabilities-enumeratedeviceclasses
    HRESULT EnumerateDeviceClasses(IEnumBstr* ppEnumDeviceClass);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphone
@GUID("09d48db4-10cc-4388-9de7-a8465618975a")
interface ITPhone : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-open
    HRESULT Open(PHONE_PRIVILEGE Privilege);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-close
    HRESULT Close();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_addresses
    HRESULT get_Addresses(VARIANT* pAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumerateaddresses
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapslong
    HRESULT get_PhoneCapsLong(PHONECAPS_LONG pclCap, int* plCapability);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapsstring
    HRESULT get_PhoneCapsString(PHONECAPS_STRING pcsCap, BSTR* ppCapability);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_terminals
    HRESULT get_Terminals(ITAddress pAddress, VARIANT* pTerminals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumerateterminals
    HRESULT EnumerateTerminals(ITAddress pAddress, IEnumTerminal* ppEnumTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonmode
    HRESULT get_ButtonMode(int lButtonID, PHONE_BUTTON_MODE* pButtonMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttonmode
    HRESULT put_ButtonMode(int lButtonID, PHONE_BUTTON_MODE ButtonMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonfunction
    HRESULT get_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION* pButtonFunction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttonfunction
    HRESULT put_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION ButtonFunction);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttontext
    HRESULT get_ButtonText(int lButtonID, BSTR* ppButtonText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_buttontext
    HRESULT put_ButtonText(int lButtonID, BSTR bstrButtonText);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_buttonstate
    HRESULT get_ButtonState(int lButtonID, PHONE_BUTTON_STATE* pButtonState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_hookswitchstate
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, 
                                PHONE_HOOK_SWITCH_STATE* pHookSwitchState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_hookswitchstate
    HRESULT put_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, PHONE_HOOK_SWITCH_STATE HookSwitchState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_ringmode
    HRESULT put_RingMode(int lRingMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_ringmode
    HRESULT get_RingMode(int* plRingMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_ringvolume
    HRESULT put_RingVolume(int lRingVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_ringvolume
    HRESULT get_RingVolume(int* plRingVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_privilege
    HRESULT get_Privilege(PHONE_PRIVILEGE* pPrivilege);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-getphonecapsbuffer
    HRESULT GetPhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, uint* pdwSize, ubyte** ppPhoneCapsBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_phonecapsbuffer
    HRESULT get_PhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, VARIANT* pVarBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_lampmode
    HRESULT get_LampMode(int lLampID, PHONE_LAMP_MODE* pLampMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-put_lampmode
    HRESULT put_LampMode(int lLampID, PHONE_LAMP_MODE LampMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_display
    HRESULT get_Display(BSTR* pbstrDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-setdisplay
    HRESULT SetDisplay(int lRow, int lColumn, BSTR bstrDisplay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-get_preferredaddresses
    HRESULT get_PreferredAddresses(VARIANT* pAddresses);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-enumeratepreferredaddresses
    HRESULT EnumeratePreferredAddresses(IEnumAddress* ppEnumAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-devicespecific
    HRESULT DeviceSpecific(ubyte* pParams, uint dwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-devicespecificvariant
    HRESULT DeviceSpecificVariant(VARIANT varDevSpecificByteArray);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphone-negotiateextversion
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itautomatedphonecontrol
@GUID("1ee1af0e-6159-4a61-b79b-6a4ba3fc9dfc")
interface ITAutomatedPhoneControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-starttone
    HRESULT StartTone(PHONE_TONE Tone, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-stoptone
    HRESULT StopTone();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_tone
    HRESULT get_Tone(PHONE_TONE* pTone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-startringer
    HRESULT StartRinger(int lRingMode, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-stopringer
    HRESULT StopRinger();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_ringer
    HRESULT get_Ringer(VARIANT_BOOL* pfRinging);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_phonehandlingenabled
    HRESULT put_PhoneHandlingEnabled(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_phonehandlingenabled
    HRESULT get_PhoneHandlingEnabled(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autoendofnumbertimeout
    HRESULT put_AutoEndOfNumberTimeout(int lTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autoendofnumbertimeout
    HRESULT get_AutoEndOfNumberTimeout(int* plTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autodialtone
    HRESULT put_AutoDialtone(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autodialtone
    HRESULT get_AutoDialtone(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autostoptonesononhook
    HRESULT put_AutoStopTonesOnOnHook(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autostoptonesononhook
    HRESULT get_AutoStopTonesOnOnHook(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autostopringonoffhook
    HRESULT put_AutoStopRingOnOffHook(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autostopringonoffhook
    HRESULT get_AutoStopRingOnOffHook(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autokeypadtones
    HRESULT put_AutoKeypadTones(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autokeypadtones
    HRESULT get_AutoKeypadTones(VARIANT_BOOL* pfEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autokeypadtonesminimumduration
    HRESULT put_AutoKeypadTonesMinimumDuration(int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autokeypadtonesminimumduration
    HRESULT get_AutoKeypadTonesMinimumDuration(int* plDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrol
    HRESULT put_AutoVolumeControl(VARIANT_BOOL fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrol
    HRESULT get_AutoVolumeControl(VARIANT_BOOL* fEnabled);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolstep
    HRESULT put_AutoVolumeControlStep(int lStepSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolstep
    HRESULT get_AutoVolumeControlStep(int* plStepSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolrepeatdelay
    HRESULT put_AutoVolumeControlRepeatDelay(int lDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolrepeatdelay
    HRESULT get_AutoVolumeControlRepeatDelay(int* plDelay);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-put_autovolumecontrolrepeatperiod
    HRESULT put_AutoVolumeControlRepeatPeriod(int lPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_autovolumecontrolrepeatperiod
    HRESULT get_AutoVolumeControlRepeatPeriod(int* plPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-selectcall
    HRESULT SelectCall(ITCallInfo pCall, VARIANT_BOOL fSelectDefaultTerminals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-unselectcall
    HRESULT UnselectCall(ITCallInfo pCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-enumerateselectedcalls
    HRESULT EnumerateSelectedCalls(IEnumCall* ppCallEnum);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itautomatedphonecontrol-get_selectedcalls
    HRESULT get_SelectedCalls(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasiccallcontrol
@GUID("b1efc389-9355-11d0-835c-00aa003ccabd")
interface ITBasicCallControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-connect
    HRESULT Connect(VARIANT_BOOL fSync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-answer
    HRESULT Answer();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-disconnect
    HRESULT Disconnect(DISCONNECT_CODE code);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-hold
    HRESULT Hold(VARIANT_BOOL fHold);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-handoffdirect
    HRESULT HandoffDirect(BSTR pApplicationName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-handoffindirect
    HRESULT HandoffIndirect(int lMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-conference
    HRESULT Conference(ITBasicCallControl pCall, VARIANT_BOOL fSync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-transfer
    HRESULT Transfer(ITBasicCallControl pCall, VARIANT_BOOL fSync);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-blindtransfer
    HRESULT BlindTransfer(BSTR pDestAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-swaphold
    HRESULT SwapHold(ITBasicCallControl pCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-parkdirect
    HRESULT ParkDirect(BSTR pParkAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-parkindirect
    HRESULT ParkIndirect(BSTR* ppNonDirAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-unpark
    HRESULT Unpark();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-setqos
    HRESULT SetQOS(int lMediaType, QOS_SERVICE_LEVEL ServiceLevel);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-pickup
    HRESULT Pickup(BSTR pGroupID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-dial
    HRESULT Dial(BSTR pDestAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-finish
    HRESULT Finish(FINISH_MODE finishMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol-removefromconference
    HRESULT RemoveFromConference();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfo
@GUID("350f85d1-1227-11d3-83d4-00c04fb6809f")
interface ITCallInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callstate
    HRESULT get_CallState(CALL_STATE* pCallState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_privilege
    HRESULT get_Privilege(CALL_PRIVILEGE* pPrivilege);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callhub
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfolong
    HRESULT get_CallInfoLong(CALLINFO_LONG CallInfoLong, int* plCallInfoLongVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfolong
    HRESULT put_CallInfoLong(CALLINFO_LONG CallInfoLong, int lCallInfoLongVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfostring
    HRESULT get_CallInfoString(CALLINFO_STRING CallInfoString, BSTR* ppCallInfoString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfostring
    HRESULT put_CallInfoString(CALLINFO_STRING CallInfoString, BSTR pCallInfoString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-get_callinfobuffer
    HRESULT get_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT* ppCallInfoBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-put_callinfobuffer
    HRESULT put_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT pCallInfoBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-getcallinfobuffer
    HRESULT GetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint* pdwSize, ubyte** ppCallInfoBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-setcallinfobuffer
    HRESULT SetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint dwSize, ubyte* pCallInfoBuffer);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo-releaseuseruserinfo
    HRESULT ReleaseUserUserInfo();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfo2
@GUID("94d70ca6-7ab0-4daa-81ca-b8f8643faec1")
interface ITCallInfo2 : ITCallInfo
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo2-get_eventfilter
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL* pEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfo2-put_eventfilter
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, VARIANT_BOOL bEnable);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itterminal
@GUID("b1efc38a-9355-11d0-835c-00aa003ccabd")
interface ITTerminal : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_name
    HRESULT get_Name(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_state
    HRESULT get_State(TERMINAL_STATE* pTerminalState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_terminaltype
    HRESULT get_TerminalType(TERMINAL_TYPE* pType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_terminalclass
    HRESULT get_TerminalClass(BSTR* ppTerminalClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_mediatype
    HRESULT get_MediaType(int* plMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itterminal-get_direction
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmultitrackterminal
@GUID("fe040091-ade8-4072-95c9-bf7de8c54b44")
interface ITMultiTrackTerminal : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_trackterminals
    HRESULT get_TrackTerminals(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-enumeratetrackterminals
    HRESULT EnumerateTrackTerminals(IEnumTerminal* ppEnumTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-createtrackterminal
    HRESULT CreateTrackTerminal(int MediaType, TERMINAL_DIRECTION TerminalDirection, ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_mediatypesinuse
    HRESULT get_MediaTypesInUse(int* plMediaTypesInUse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-get_directionsinuse
    HRESULT get_DirectionsInUse(TERMINAL_DIRECTION* plDirectionsInUsed);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmultitrackterminal-removetrackterminal
    HRESULT RemoveTrackTerminal(ITTerminal pTrackTerminalToRemove);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itfiletrack
@GUID("31ca6ea9-c08a-4bea-8811-8e9c1ba3ea3a")
interface ITFileTrack : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_format
    HRESULT get_Format(AM_MEDIA_TYPE** ppmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-put_format
    HRESULT put_Format(const(AM_MEDIA_TYPE)* pmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_controllingterminal
    HRESULT get_ControllingTerminal(ITTerminal* ppControllingTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_audioformatforscripting
    HRESULT get_AudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-put_audioformatforscripting
    HRESULT put_AudioFormatForScripting(ITScriptableAudioFormat pAudioFormat);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfiletrack-get_emptyaudioformatforscripting
    HRESULT get_EmptyAudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediaplayback
@GUID("627e8ae6-ae4c-4a69-bb63-2ad625404b77")
interface ITMediaPlayback : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediaplayback-put_playlist
    HRESULT put_PlayList(VARIANT PlayListVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediaplayback-get_playlist
    HRESULT get_PlayList(VARIANT* pPlayListVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediarecord
@GUID("f5dd4592-5476-4cc1-9d4d-fad3eefe7db2")
interface ITMediaRecord : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediarecord-put_filename
    HRESULT put_FileName(BSTR bstrFileName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediarecord-get_filename
    HRESULT get_FileName(BSTR* pbstrFileName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itmediacontrol
@GUID("c445dde8-5199-4bc7-9807-5ffb92e42e09")
interface ITMediaControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-start
    HRESULT Start();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-stop
    HRESULT Stop();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-pause
    HRESULT Pause();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itmediacontrol-get_mediastate
    HRESULT get_MediaState(TERMINAL_MEDIA_STATE* pTerminalMediaState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasicaudioterminal
@GUID("b1efc38d-9355-11d0-835c-00aa003ccabd")
interface ITBasicAudioTerminal : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-put_volume
    HRESULT put_Volume(int lVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-get_volume
    HRESULT get_Volume(int* plVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-put_balance
    HRESULT put_Balance(int lBalance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasicaudioterminal-get_balance
    HRESULT get_Balance(int* plBalance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstaticaudioterminal
@GUID("a86b7871-d14c-48e6-922e-a8d15f984800")
interface ITStaticAudioTerminal : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstaticaudioterminal-get_waveid
    HRESULT get_WaveId(int* plWaveId);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallhub
@GUID("a3c1544e-5b92-11d1-8f4e-00c04fb6809f")
interface ITCallHub : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-clear
    HRESULT Clear();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-enumeratecalls
    HRESULT EnumerateCalls(IEnumCall* ppEnumCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_calls
    HRESULT get_Calls(VARIANT* pCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_numcalls
    HRESULT get_NumCalls(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhub-get_state
    HRESULT get_State(CALLHUB_STATE* pState);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacyaddressmediacontrol
@GUID("ab493640-4c0b-11d2-a046-00c04fb6809f")
interface ITLegacyAddressMediaControl : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-getid
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-getdevconfig
    HRESULT GetDevConfig(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceConfig);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol-setdevconfig
    HRESULT SetDevConfig(BSTR pDeviceClass, uint dwSize, ubyte* pDeviceConfig);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itprivateevent
@GUID("0e269cd0-10d4-4121-9c22-9c85d625650d")
interface ITPrivateEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_callhub
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_eventcode
    HRESULT get_EventCode(int* plEventCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itprivateevent-get_eventinterface
    HRESULT get_EventInterface(IDispatch* pEventInterface);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacyaddressmediacontrol2
@GUID("b0ee512b-a531-409e-9dd9-4099fe86c738")
interface ITLegacyAddressMediaControl2 : ITLegacyAddressMediaControl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol2-configdialog
    HRESULT ConfigDialog(HWND hwndOwner, BSTR pDeviceClass);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacyaddressmediacontrol2-configdialogedit
    HRESULT ConfigDialogEdit(HWND hwndOwner, BSTR pDeviceClass, uint dwSizeIn, ubyte* pDeviceConfigIn, 
                             uint* pdwSizeOut, ubyte** ppDeviceConfigOut);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacycallmediacontrol
@GUID("d624582f-cc23-4436-b8a5-47c625c8045d")
interface ITLegacyCallMediaControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-detectdigits
    HRESULT DetectDigits(int DigitMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-generatedigits
    HRESULT GenerateDigits(BSTR pDigits, int DigitMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-getid
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, ubyte** ppDeviceID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-setmediatype
    HRESULT SetMediaType(int lMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol-monitormedia
    HRESULT MonitorMedia(int lMediaType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacycallmediacontrol2
@GUID("57ca332d-7bc2-44f1-a60c-936fe8d7ce73")
interface ITLegacyCallMediaControl2 : ITLegacyCallMediaControl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatedigits2
    HRESULT GenerateDigits2(BSTR pDigits, int DigitMode, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-gatherdigits
    HRESULT GatherDigits(int DigitMode, int lNumDigits, BSTR pTerminationDigits, int lFirstDigitTimeout, 
                         int lInterDigitTimeout);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-detecttones
    HRESULT DetectTones(TAPI_DETECTTONE* pToneList, int lNumTones);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-detecttonesbycollection
    HRESULT DetectTonesByCollection(ITCollection2 pDetectToneCollection);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatetone
    HRESULT GenerateTone(TAPI_TONEMODE ToneMode, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatecustomtones
    HRESULT GenerateCustomTones(TAPI_CUSTOMTONE* pToneList, int lNumTones, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-generatecustomtonesbycollection
    HRESULT GenerateCustomTonesByCollection(ITCollection2 pCustomToneCollection, int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-createdetecttoneobject
    HRESULT CreateDetectToneObject(ITDetectTone* ppDetectTone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-createcustomtoneobject
    HRESULT CreateCustomToneObject(ITCustomTone* ppCustomTone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacycallmediacontrol2-getidasvariant
    HRESULT GetIDAsVariant(BSTR bstrDeviceClass, VARIANT* pVarDeviceID);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdetecttone
@GUID("961f79bd-3097-49df-a1d6-909b77e89ca0")
interface ITDetectTone : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_appspecific
    HRESULT get_AppSpecific(int* plAppSpecific);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_appspecific
    HRESULT put_AppSpecific(int lAppSpecific);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_duration
    HRESULT get_Duration(int* plDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_duration
    HRESULT put_Duration(int lDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-get_frequency
    HRESULT get_Frequency(int Index, int* plFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdetecttone-put_frequency
    HRESULT put_Frequency(int Index, int lFrequency);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcustomtone
@GUID("357ad764-b3c6-4b2a-8fa5-0722827a9254")
interface ITCustomTone : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_frequency
    HRESULT get_Frequency(int* plFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_frequency
    HRESULT put_Frequency(int lFrequency);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_cadenceon
    HRESULT get_CadenceOn(int* plCadenceOn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_cadenceon
    HRESULT put_CadenceOn(int CadenceOn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_cadenceoff
    HRESULT get_CadenceOff(int* plCadenceOff);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_cadenceoff
    HRESULT put_CadenceOff(int lCadenceOff);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-get_volume
    HRESULT get_Volume(int* plVolume);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcustomtone-put_volume
    HRESULT put_Volume(int lVolume);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumphone
@GUID("f15b7669-4780-4595-8c89-fb369c8cf7aa")
interface IEnumPhone : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-next
    HRESULT Next(uint celt, ITPhone* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumphone-clone
    HRESULT Clone(IEnumPhone* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumterminal
@GUID("ae269cf4-935e-11d0-835c-00aa003ccabd")
interface IEnumTerminal : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-next
    HRESULT Next(uint celt, ITTerminal* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminal-clone
    HRESULT Clone(IEnumTerminal* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumterminalclass
@GUID("ae269cf5-935e-11d0-835c-00aa003ccabd")
interface IEnumTerminalClass : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-next
    HRESULT Next(uint celt, GUID* pElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumterminalclass-clone
    HRESULT Clone(IEnumTerminalClass* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcall
@GUID("ae269cf6-935e-11d0-835c-00aa003ccabd")
interface IEnumCall : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-next
    HRESULT Next(uint celt, ITCallInfo* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcall-clone
    HRESULT Clone(IEnumCall* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumaddress
@GUID("1666fca1-9363-11d0-835c-00aa003ccabd")
interface IEnumAddress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-next
    HRESULT Next(uint celt, ITAddress* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumaddress-clone
    HRESULT Clone(IEnumAddress* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcallhub
@GUID("a3c15450-5b92-11d1-8f4e-00c04fb6809f")
interface IEnumCallHub : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-next
    HRESULT Next(uint celt, ITCallHub* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallhub-clone
    HRESULT Clone(IEnumCallHub* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumbstr
@GUID("35372049-0bc6-11d2-a033-00c04fb6809f")
interface IEnumBstr : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-next
    HRESULT Next(uint celt, BSTR* ppStrings, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumbstr-clone
    HRESULT Clone(IEnumBstr* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumpluggableterminalclassinfo
@GUID("4567450c-dbee-4e3f-aaf5-37bf9ebf5e29")
interface IEnumPluggableTerminalClassInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-next
    HRESULT Next(uint celt, ITPluggableTerminalClassInfo* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggableterminalclassinfo-clone
    HRESULT Clone(IEnumPluggableTerminalClassInfo* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumpluggablesuperclassinfo
@GUID("e9586a80-89e6-4cff-931d-478d5751f4c0")
interface IEnumPluggableSuperclassInfo : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-next
    HRESULT Next(uint celt, ITPluggableTerminalSuperclassInfo* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumpluggablesuperclassinfo-clone
    HRESULT Clone(IEnumPluggableSuperclassInfo* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphoneevent
@GUID("8f942dd8-64ed-4aaf-a77d-b23db0837ead")
interface ITPhoneEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_phone
    HRESULT get_Phone(ITPhone* ppPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_event
    HRESULT get_Event(PHONE_EVENT* pEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_buttonstate
    HRESULT get_ButtonState(PHONE_BUTTON_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_hookswitchstate
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_hookswitchdevice
    HRESULT get_HookSwitchDevice(PHONE_HOOK_SWITCH_DEVICE* pDevice);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_ringmode
    HRESULT get_RingMode(int* plRingMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_buttonlampid
    HRESULT get_ButtonLampId(int* plButtonLampId);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_numbergathered
    HRESULT get_NumberGathered(BSTR* ppNumber);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphoneevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallstateevent
@GUID("62f47097-95c9-11d0-835d-00aa003ccabd")
interface ITCallStateEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_state
    HRESULT get_State(CALL_STATE* pCallState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_cause
    HRESULT get_Cause(CALL_STATE_EVENT_CAUSE* pCEC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallstateevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itphonedevicespecificevent
@GUID("63ffb2a6-872b-4cd3-a501-326e8fb40af7")
interface ITPhoneDeviceSpecificEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_phone
    HRESULT get_Phone(ITPhone* ppPhone);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam1
    HRESULT get_lParam1(int* pParam1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam2
    HRESULT get_lParam2(int* pParam2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itphonedevicespecificevent-get_lparam3
    HRESULT get_lParam3(int* pParam3);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallmediaevent
@GUID("ff36b87f-ec3a-11d0-8ee4-00c04fb6809f")
interface ITCallMediaEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_event
    HRESULT get_Event(CALL_MEDIA_EVENT* pCallMediaEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_error
    HRESULT get_Error(HRESULT* phrError);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_stream
    HRESULT get_Stream(ITStream* ppStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallmediaevent-get_cause
    HRESULT get_Cause(CALL_MEDIA_EVENT_CAUSE* pCause);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitdetectionevent
@GUID("80d3bfac-57d9-11d2-a04a-00c04fb6809f")
interface ITDigitDetectionEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_digit
    HRESULT get_Digit(ubyte* pucDigit);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_digitmode
    HRESULT get_DigitMode(int* pDigitMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_tickcount
    HRESULT get_TickCount(int* plTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitdetectionevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitgenerationevent
@GUID("80d3bfad-57d9-11d2-a04a-00c04fb6809f")
interface ITDigitGenerationEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_generationtermination
    HRESULT get_GenerationTermination(int* plGenerationTermination);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_tickcount
    HRESULT get_TickCount(int* plTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitgenerationevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdigitsgatheredevent
@GUID("e52ec4c1-cba3-441a-9e6a-93cb909e9724")
interface ITDigitsGatheredEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_digits
    HRESULT get_Digits(BSTR* ppDigits);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_gathertermination
    HRESULT get_GatherTermination(TAPI_GATHERTERM* pGatherTermination);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_tickcount
    HRESULT get_TickCount(int* plTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdigitsgatheredevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittonedetectionevent
@GUID("407e0faf-d047-4753-b0c6-8e060373fecd")
interface ITToneDetectionEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_call
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_appspecific
    HRESULT get_AppSpecific(int* plAppSpecific);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_tickcount
    HRESULT get_TickCount(int* plTickCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittonedetectionevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapiobjectevent
@GUID("f4854d48-937a-11d1-bb58-00c04fb6809f")
interface ITTAPIObjectEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_tapiobject
    HRESULT get_TAPIObject(ITTAPI* ppTAPIObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_event
    HRESULT get_Event(TAPIOBJECT_EVENT* pEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapiobjectevent2
@GUID("359dda6e-68ce-4383-bf0b-169133c41b46")
interface ITTAPIObjectEvent2 : ITTAPIObjectEvent
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapiobjectevent2-get_phone
    HRESULT get_Phone(ITPhone* ppPhone);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittapieventnotification
@GUID("eddb9426-3b91-11d1-8f30-00c04fb6809f")
interface ITTAPIEventNotification : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittapieventnotification-event
    HRESULT Event(TAPI_EVENT TapiEvent, IDispatch pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallhubevent
@GUID("a3c15451-5b92-11d1-8f4e-00c04fb6809f")
interface ITCallHubEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_event
    HRESULT get_Event(CALLHUB_EVENT* pEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_callhub
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallhubevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddressevent
@GUID("831ce2d1-83b5-11d1-bb5c-00c04fb6809f")
interface ITAddressEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_event
    HRESULT get_Event(ADDRESS_EVENT* pEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddressdevicespecificevent
@GUID("3acb216b-40bd-487a-8672-5ce77bd7e3a3")
interface ITAddressDeviceSpecificEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam1
    HRESULT get_lParam1(int* pParam1);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam2
    HRESULT get_lParam2(int* pParam2);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddressdevicespecificevent-get_lparam3
    HRESULT get_lParam3(int* pParam3);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itfileterminalevent
@GUID("e4a7fbac-8c17-4427-9f55-9f589ac8af00")
interface ITFileTerminalEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_track
    HRESULT get_Track(ITFileTrack* ppTrackTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_state
    HRESULT get_State(TERMINAL_MEDIA_STATE* pState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_cause
    HRESULT get_Cause(FT_STATE_EVENT_CAUSE* pCause);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itfileterminalevent-get_error
    HRESULT get_Error(HRESULT* phrErrorCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itttsterminalevent
@GUID("d964788f-95a5-461d-ab0c-b9900a6c2713")
interface ITTTSTerminalEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itttsterminalevent-get_error
    HRESULT get_Error(HRESULT* phrErrorCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itasrterminalevent
@GUID("ee016a02-4fa9-467c-933f-5a15b12377d7")
interface ITASRTerminalEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itasrterminalevent-get_error
    HRESULT get_Error(HRESULT* phrErrorCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ittoneterminalevent
@GUID("e6f56009-611f-4945-bbd2-2d0ce5612056")
interface ITToneTerminalEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_terminal
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ittoneterminalevent-get_error
    HRESULT get_Error(HRESULT* phrErrorCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itqosevent
@GUID("cfa3357c-ad77-11d1-bb68-00c04fb6809f")
interface ITQOSEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_event
    HRESULT get_Event(QOS_EVENT* pQosEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itqosevent-get_mediatype
    HRESULT get_MediaType(int* plMediaType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallinfochangeevent
@GUID("5d4b65f9-e51c-11d1-a02f-00c04fb6809f")
interface ITCallInfoChangeEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_cause
    HRESULT get_Cause(CALLINFOCHANGE_CAUSE* pCIC);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallinfochangeevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itrequest
@GUID("ac48ffdf-f8c4-11d1-a030-00c04fb6809f")
interface ITRequest : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequest-makecall
    HRESULT MakeCall(BSTR pDestAddress, BSTR pAppName, BSTR pCalledParty, BSTR pComment);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itrequestevent
@GUID("ac48ffde-f8c4-11d1-a030-00c04fb6809f")
interface ITRequestEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_registrationinstance
    HRESULT get_RegistrationInstance(int* plRegistrationInstance);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_requestmode
    HRESULT get_RequestMode(int* plRequestMode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_destaddress
    HRESULT get_DestAddress(BSTR* ppDestAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_appname
    HRESULT get_AppName(BSTR* ppAppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_calledparty
    HRESULT get_CalledParty(BSTR* ppCalledParty);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itrequestevent-get_comment
    HRESULT get_Comment(BSTR* ppComment);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcollection
@GUID("5ec5acf2-9c02-11d0-8362-00aa003ccabd")
interface ITCollection : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get_count
    HRESULT get_Count(int* lCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get_item
    HRESULT get_Item(int Index, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection-get__newenum
    HRESULT get__NewEnum(IUnknown* ppNewEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcollection2
@GUID("e6dddda5-a6d3-48ff-8737-d32fc4d95477")
interface ITCollection2 : ITCollection
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection2-add
    HRESULT Add(int Index, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcollection2-remove
    HRESULT Remove(int Index);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itforwardinformation
@GUID("449f659e-88a3-11d1-bb5d-00c04fb6809f")
interface ITForwardInformation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-put_numringsnoanswer
    HRESULT put_NumRingsNoAnswer(int lNumRings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_numringsnoanswer
    HRESULT get_NumRingsNoAnswer(int* plNumRings);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-setforwardtype
    HRESULT SetForwardType(int ForwardType, BSTR pDestAddress, BSTR pCallerAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_forwardtypedestination
    HRESULT get_ForwardTypeDestination(int ForwardType, BSTR* ppDestAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-get_forwardtypecaller
    HRESULT get_ForwardTypeCaller(int Forwardtype, BSTR* ppCallerAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-getforwardtype
    HRESULT GetForwardType(int ForwardType, BSTR* ppDestinationAddress, BSTR* ppCallerAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation-clear
    HRESULT Clear();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itforwardinformation2
@GUID("5229b4ed-b260-4382-8e1a-5df3a8a4ccc0")
interface ITForwardInformation2 : ITForwardInformation
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-setforwardtype2
    HRESULT SetForwardType2(int ForwardType, BSTR pDestAddress, int DestAddressType, BSTR pCallerAddress, 
                            int CallerAddressType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-getforwardtype2
    HRESULT GetForwardType2(int ForwardType, BSTR* ppDestinationAddress, int* pDestAddressType, 
                            BSTR* ppCallerAddress, int* pCallerAddressType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-get_forwardtypedestinationaddresstype
    HRESULT get_ForwardTypeDestinationAddressType(int ForwardType, int* pDestAddressType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itforwardinformation2-get_forwardtypecalleraddresstype
    HRESULT get_ForwardTypeCallerAddressType(int Forwardtype, int* pCallerAddressType);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresstranslation
@GUID("0c4d8f03-8ddb-11d1-a09e-00805fc147d3")
interface ITAddressTranslation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-translateaddress
    HRESULT TranslateAddress(BSTR pAddressToTranslate, int lCard, int lTranslateOptions, 
                             ITAddressTranslationInfo* ppTranslated);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-translatedialog
    HRESULT TranslateDialog(ptrdiff_t hwndOwner, BSTR pAddressIn);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-enumeratelocations
    HRESULT EnumerateLocations(IEnumLocation* ppEnumLocation);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-get_locations
    HRESULT get_Locations(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-enumeratecallingcards
    HRESULT EnumerateCallingCards(IEnumCallingCard* ppEnumCallingCard);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslation-get_callingcards
    HRESULT get_CallingCards(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itaddresstranslationinfo
@GUID("afc15945-8d40-11d1-a09e-00805fc147d3")
interface ITAddressTranslationInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_dialablestring
    HRESULT get_DialableString(BSTR* ppDialableString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_displayablestring
    HRESULT get_DisplayableString(BSTR* ppDisplayableString);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_currentcountrycode
    HRESULT get_CurrentCountryCode(int* CountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_destinationcountrycode
    HRESULT get_DestinationCountryCode(int* CountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itaddresstranslationinfo-get_translationresults
    HRESULT get_TranslationResults(int* plResults);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlocationinfo
@GUID("0c4d8eff-8ddb-11d1-a09e-00805fc147d3")
interface ITLocationInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_permanentlocationid
    HRESULT get_PermanentLocationID(int* plLocationID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_countrycode
    HRESULT get_CountryCode(int* plCountryCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_countryid
    HRESULT get_CountryID(int* plCountryID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_options
    HRESULT get_Options(int* plOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_preferredcardid
    HRESULT get_PreferredCardID(int* plCardID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_locationname
    HRESULT get_LocationName(BSTR* ppLocationName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_citycode
    HRESULT get_CityCode(BSTR* ppCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_localaccesscode
    HRESULT get_LocalAccessCode(BSTR* ppCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_longdistanceaccesscode
    HRESULT get_LongDistanceAccessCode(BSTR* ppCode);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_tollprefixlist
    HRESULT get_TollPrefixList(BSTR* ppTollList);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlocationinfo-get_cancelcallwaitingcode
    HRESULT get_CancelCallWaitingCode(BSTR* ppCode);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumlocation
@GUID("0c4d8f01-8ddb-11d1-a09e-00805fc147d3")
interface IEnumLocation : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-next
    HRESULT Next(uint celt, ITLocationInfo* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumlocation-clone
    HRESULT Clone(IEnumLocation* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallingcard
@GUID("0c4d8f00-8ddb-11d1-a09e-00805fc147d3")
interface ITCallingCard : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_permanentcardid
    HRESULT get_PermanentCardID(int* plCardID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_numberofdigits
    HRESULT get_NumberOfDigits(int* plDigits);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_options
    HRESULT get_Options(int* plOptions);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_cardname
    HRESULT get_CardName(BSTR* ppCardName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_sameareadialingrule
    HRESULT get_SameAreaDialingRule(BSTR* ppRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_longdistancedialingrule
    HRESULT get_LongDistanceDialingRule(BSTR* ppRule);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallingcard-get_internationaldialingrule
    HRESULT get_InternationalDialingRule(BSTR* ppRule);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumcallingcard
@GUID("0c4d8f02-8ddb-11d1-a09e-00805fc147d3")
interface IEnumCallingCard : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-next
    HRESULT Next(uint celt, ITCallingCard* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumcallingcard-clone
    HRESULT Clone(IEnumCallingCard* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itcallnotificationevent
@GUID("895801df-3dd6-11d1-8f30-00c04fb6809f")
interface ITCallNotificationEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_call
    HRESULT get_Call(ITCallInfo* ppCall);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_event
    HRESULT get_Event(CALL_NOTIFICATION_EVENT* pCallNotificationEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itcallnotificationevent-get_callbackinstance
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itdispatchmapper
@GUID("e9225295-c759-11d1-a02b-00c04fb6809f")
interface ITDispatchMapper : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itdispatchmapper-querydispatchinterface
    HRESULT QueryDispatchInterface(BSTR pIID, IDispatch pInterfaceToMap, IDispatch* ppReturnedInterface);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstreamcontrol
@GUID("ee3bd604-3868-11d2-a045-00c04fb6809f")
interface ITStreamControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-createstream
    HRESULT CreateStream(int lMediaType, TERMINAL_DIRECTION td, ITStream* ppStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-removestream
    HRESULT RemoveStream(ITStream pStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-enumeratestreams
    HRESULT EnumerateStreams(IEnumStream* ppEnumStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstreamcontrol-get_streams
    HRESULT get_Streams(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itstream
@GUID("ee3bd605-3868-11d2-a045-00c04fb6809f")
interface ITStream : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_mediatype
    HRESULT get_MediaType(int* plMediaType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_direction
    HRESULT get_Direction(TERMINAL_DIRECTION* pTD);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_name
    HRESULT get_Name(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-startstream
    HRESULT StartStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-pausestream
    HRESULT PauseStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-stopstream
    HRESULT StopStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-selectterminal
    HRESULT SelectTerminal(ITTerminal pTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-unselectterminal
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-enumerateterminals
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itstream-get_terminals
    HRESULT get_Terminals(VARIANT* pTerminals);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumstream
@GUID("ee3bd606-3868-11d2-a045-00c04fb6809f")
interface IEnumStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-next
    HRESULT Next(uint celt, ITStream* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumstream-clone
    HRESULT Clone(IEnumStream* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itsubstreamcontrol
@GUID("ee3bd607-3868-11d2-a045-00c04fb6809f")
interface ITSubStreamControl : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-createsubstream
    HRESULT CreateSubStream(ITSubStream* ppSubStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-removesubstream
    HRESULT RemoveSubStream(ITSubStream pSubStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-enumeratesubstreams
    HRESULT EnumerateSubStreams(IEnumSubStream* ppEnumSubStream);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstreamcontrol-get_substreams
    HRESULT get_SubStreams(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itsubstream
@GUID("ee3bd608-3868-11d2-a045-00c04fb6809f")
interface ITSubStream : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-startsubstream
    HRESULT StartSubStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-pausesubstream
    HRESULT PauseSubStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-stopsubstream
    HRESULT StopSubStream();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-selectterminal
    HRESULT SelectTerminal(ITTerminal pTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-unselectterminal
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-enumerateterminals
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-get_terminals
    HRESULT get_Terminals(VARIANT* pTerminals);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itsubstream-get_stream
    HRESULT get_Stream(ITStream* ppITStream);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-ienumsubstream
@GUID("ee3bd609-3868-11d2-a045-00c04fb6809f")
interface IEnumSubStream : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-next
    HRESULT Next(uint celt, ITSubStream* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-ienumsubstream-clone
    HRESULT Clone(IEnumSubStream* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itlegacywavesupport
@GUID("207823ea-e252-11d2-b77e-0080c7135381")
interface ITLegacyWaveSupport : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itlegacywavesupport-isfullduplex
    HRESULT IsFullDuplex(FULLDUPLEX_SUPPORT* pSupport);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itbasiccallcontrol2
@GUID("161a4a56-1e99-4b3f-a46a-168f38a5ee4c")
interface ITBasicCallControl2 : ITBasicCallControl
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-requestterminal
    HRESULT RequestTerminal(BSTR bstrTerminalClassGUID, int lMediaType, TERMINAL_DIRECTION Direction, 
                            ITTerminal* ppTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-selectterminaloncall
    HRESULT SelectTerminalOnCall(ITTerminal pTerminal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itbasiccallcontrol2-unselectterminaloncall
    HRESULT UnselectTerminalOnCall(ITTerminal pTerminal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nn-tapi3if-itscriptableaudioformat
@GUID("b87658bd-3c59-4f64-be74-aede3e86a81e")
interface ITScriptableAudioFormat : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_channels
    HRESULT get_Channels(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_channels
    HRESULT put_Channels(const(int) nNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_samplespersec
    HRESULT get_SamplesPerSec(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_samplespersec
    HRESULT put_SamplesPerSec(const(int) nNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_avgbytespersec
    HRESULT get_AvgBytesPerSec(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_avgbytespersec
    HRESULT put_AvgBytesPerSec(const(int) nNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_blockalign
    HRESULT get_BlockAlign(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_blockalign
    HRESULT put_BlockAlign(const(int) nNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_bitspersample
    HRESULT get_BitsPerSample(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_bitspersample
    HRESULT put_BitsPerSample(const(int) nNewVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-get_formattag
    HRESULT get_FormatTag(int* pVal);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3if/nf-tapi3if-itscriptableaudioformat-put_formattag
    HRESULT put_FormatTag(const(int) nNewVal);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagent
@GUID("5770ece5-4b27-11d1-bf80-00805fc147d3")
interface ITAgent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-enumerateagentsessions
    HRESULT EnumerateAgentSessions(IEnumAgentSession* ppEnumAgentSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-createsession
    HRESULT CreateSession(ITACDGroup pACDGroup, ITAddress pAddress, ITAgentSession* ppAgentSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-createsessionwithpin
    HRESULT CreateSessionWithPIN(ITACDGroup pACDGroup, ITAddress pAddress, BSTR pPIN, 
                                 ITAgentSession* ppAgentSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_id
    HRESULT get_ID(BSTR* ppID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_user
    HRESULT get_User(BSTR* ppUser);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-put_state
    HRESULT put_State(AGENT_STATE AgentState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_state
    HRESULT get_State(AGENT_STATE* pAgentState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-put_measurementperiod
    HRESULT put_MeasurementPeriod(int lPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_measurementperiod
    HRESULT get_MeasurementPeriod(int* plPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_overallcallrate
    HRESULT get_OverallCallRate(CY* pcyCallrate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofacdcalls
    HRESULT get_NumberOfACDCalls(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofincomingcalls
    HRESULT get_NumberOfIncomingCalls(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_numberofoutgoingcalls
    HRESULT get_NumberOfOutgoingCalls(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalacdtalktime
    HRESULT get_TotalACDTalkTime(int* plTalkTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalacdcalltime
    HRESULT get_TotalACDCallTime(int* plCallTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_totalwrapuptime
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagent-get_agentsessions
    HRESULT get_AgentSessions(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentsession
@GUID("5afc3147-4bcc-11d1-bf80-00805fc147d3")
interface ITAgentSession : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_agent
    HRESULT get_Agent(ITAgent* ppAgent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_address
    HRESULT get_Address(ITAddress* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_acdgroup
    HRESULT get_ACDGroup(ITACDGroup* ppACDGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-put_state
    HRESULT put_State(AGENT_SESSION_STATE SessionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_state
    HRESULT get_State(AGENT_SESSION_STATE* pSessionState);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_sessionstarttime
    HRESULT get_SessionStartTime(double* pdateSessionStart);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_sessionduration
    HRESULT get_SessionDuration(int* plDuration);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_numberofcalls
    HRESULT get_NumberOfCalls(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totaltalktime
    HRESULT get_TotalTalkTime(int* plTalkTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagetalktime
    HRESULT get_AverageTalkTime(int* plTalkTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totalcalltime
    HRESULT get_TotalCallTime(int* plCallTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagecalltime
    HRESULT get_AverageCallTime(int* plCallTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_totalwrapuptime
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagewrapuptime
    HRESULT get_AverageWrapUpTime(int* plWrapUpTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_acdcallrate
    HRESULT get_ACDCallRate(CY* pcyCallrate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_longesttimetoanswer
    HRESULT get_LongestTimeToAnswer(int* plAnswerTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsession-get_averagetimetoanswer
    HRESULT get_AverageTimeToAnswer(int* plAnswerTime);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itacdgroup
@GUID("5afc3148-4bcc-11d1-bf80-00805fc147d3")
interface ITACDGroup : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-get_name
    HRESULT get_Name(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-enumeratequeues
    HRESULT EnumerateQueues(IEnumQueue* ppEnumQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroup-get_queues
    HRESULT get_Queues(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itqueue
@GUID("5afc3149-4bcc-11d1-bf80-00805fc147d3")
interface ITQueue : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-put_measurementperiod
    HRESULT put_MeasurementPeriod(int lPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_measurementperiod
    HRESULT get_MeasurementPeriod(int* plPeriod);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsqueued
    HRESULT get_TotalCallsQueued(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_currentcallsqueued
    HRESULT get_CurrentCallsQueued(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsabandoned
    HRESULT get_TotalCallsAbandoned(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsflowedin
    HRESULT get_TotalCallsFlowedIn(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_totalcallsflowedout
    HRESULT get_TotalCallsFlowedOut(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_longesteverwaittime
    HRESULT get_LongestEverWaitTime(int* plWaitTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_currentlongestwaittime
    HRESULT get_CurrentLongestWaitTime(int* plWaitTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_averagewaittime
    HRESULT get_AverageWaitTime(int* plWaitTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_finaldisposition
    HRESULT get_FinalDisposition(int* plCalls);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueue-get_name
    HRESULT get_Name(BSTR* ppName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentevent
@GUID("5afc314a-4bcc-11d1-bf80-00805fc147d3")
interface ITAgentEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentevent-get_agent
    HRESULT get_Agent(ITAgent* ppAgent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentevent-get_event
    HRESULT get_Event(AGENT_EVENT* pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagentsessionevent
@GUID("5afc314b-4bcc-11d1-bf80-00805fc147d3")
interface ITAgentSessionEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsessionevent-get_session
    HRESULT get_Session(ITAgentSession* ppSession);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagentsessionevent-get_event
    HRESULT get_Event(AGENT_SESSION_EVENT* pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itacdgroupevent
@GUID("297f3032-bd11-11d1-a0a7-00805fc147d3")
interface ITACDGroupEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroupevent-get_group
    HRESULT get_Group(ITACDGroup* ppGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itacdgroupevent-get_event
    HRESULT get_Event(ACDGROUP_EVENT* pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itqueueevent
@GUID("297f3033-bd11-11d1-a0a7-00805fc147d3")
interface ITQueueEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueueevent-get_queue
    HRESULT get_Queue(ITQueue* ppQueue);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itqueueevent-get_event
    HRESULT get_Event(ACDQUEUE_EVENT* pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagenthandlerevent
@GUID("297f3034-bd11-11d1-a0a7-00805fc147d3")
interface ITAgentHandlerEvent : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandlerevent-get_agenthandler
    HRESULT get_AgentHandler(ITAgentHandler* ppAgentHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandlerevent-get_event
    HRESULT get_Event(AGENTHANDLER_EVENT* pEvent);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ittapicallcenter
@GUID("5afc3154-4bcc-11d1-bf80-00805fc147d3")
interface ITTAPICallCenter : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ittapicallcenter-enumerateagenthandlers
    HRESULT EnumerateAgentHandlers(IEnumAgentHandler* ppEnumHandler);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ittapicallcenter-get_agenthandlers
    HRESULT get_AgentHandlers(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-itagenthandler
@GUID("587e8c22-9802-11d1-a0a4-00805fc147d3")
interface ITAgentHandler : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_name
    HRESULT get_Name(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-createagent
    HRESULT CreateAgent(ITAgent* ppAgent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-createagentwithid
    HRESULT CreateAgentWithID(BSTR pID, BSTR pPIN, ITAgent* ppAgent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-enumerateacdgroups
    HRESULT EnumerateACDGroups(IEnumACDGroup* ppEnumACDGroup);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-enumerateusableaddresses
    HRESULT EnumerateUsableAddresses(IEnumAddress* ppEnumAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_acdgroups
    HRESULT get_ACDGroups(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-itagenthandler-get_usableaddresses
    HRESULT get_UsableAddresses(VARIANT* pVariant);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagent
@GUID("5afc314d-4bcc-11d1-bf80-00805fc147d3")
interface IEnumAgent : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-next
    HRESULT Next(uint celt, ITAgent* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagent-clone
    HRESULT Clone(IEnumAgent* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagentsession
@GUID("5afc314e-4bcc-11d1-bf80-00805fc147d3")
interface IEnumAgentSession : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-next
    HRESULT Next(uint celt, ITAgentSession* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagentsession-clone
    HRESULT Clone(IEnumAgentSession* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumqueue
@GUID("5afc3158-4bcc-11d1-bf80-00805fc147d3")
interface IEnumQueue : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-next
    HRESULT Next(uint celt, ITQueue* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumqueue-clone
    HRESULT Clone(IEnumQueue* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumacdgroup
@GUID("5afc3157-4bcc-11d1-bf80-00805fc147d3")
interface IEnumACDGroup : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-next
    HRESULT Next(uint celt, ITACDGroup* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumacdgroup-clone
    HRESULT Clone(IEnumACDGroup* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nn-tapi3cc-ienumagenthandler
@GUID("587e8c28-9802-11d1-a0a4-00805fc147d3")
interface IEnumAgentHandler : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-next
    HRESULT Next(uint celt, ITAgentHandler* ppElements, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3cc/nf-tapi3cc-ienumagenthandler-clone
    HRESULT Clone(IEnumAgentHandler* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nn-tapi3ds-itammediaformat
@GUID("0364eb00-4a77-11d1-a671-006097c9a2e8")
interface ITAMMediaFormat : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itammediaformat-get_mediaformat
    HRESULT get_MediaFormat(AM_MEDIA_TYPE** ppmt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itammediaformat-put_mediaformat
    HRESULT put_MediaFormat(const(AM_MEDIA_TYPE)* pmt);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nn-tapi3ds-itallocatorproperties
@GUID("c1bc3c90-bcfe-11d1-9745-00c04fd91ac0")
interface ITAllocatorProperties : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setallocatorproperties
    HRESULT SetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getallocatorproperties
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setallocatebuffers
    HRESULT SetAllocateBuffers(BOOL bAllocBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getallocatebuffers
    HRESULT GetAllocateBuffers(BOOL* pbAllocBuffers);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-setbuffersize
    HRESULT SetBufferSize(uint BufferSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/tapi3ds/nf-tapi3ds-itallocatorproperties-getbuffersize
    HRESULT GetBufferSize(uint* pBufferSize);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itpluggableterminaleventsink
@GUID("6e0887be-ba1a-492e-bd10-4020ec5e33e0")
interface ITPluggableTerminalEventSink : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsink-fireevent
    HRESULT FireEvent(const(MSP_EVENT_INFO)* pMspEventInfo);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itpluggableterminaleventsinkregistration
@GUID("f7115709-a216-4957-a759-060ab32a90d1")
interface ITPluggableTerminalEventSinkRegistration : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsinkregistration-registersink
    HRESULT RegisterSink(ITPluggableTerminalEventSink pEventSink);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itpluggableterminaleventsinkregistration-unregistersink
    HRESULT UnregisterSink();
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nn-msp-itmspaddress
@GUID("ee3bd600-3868-11d2-a045-00c04fb6809f")
interface ITMSPAddress : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-initialize
    HRESULT Initialize(int* hEvent);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-shutdown
    HRESULT Shutdown();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-createmspcall
    HRESULT CreateMSPCall(int* hCall, uint dwReserved, uint dwMediaType, IUnknown pOuterUnknown, 
                          IUnknown* ppStreamControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-shutdownmspcall
    HRESULT ShutdownMSPCall(IUnknown pStreamControl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-receivetspdata
    HRESULT ReceiveTSPData(IUnknown pMSPCall, ubyte* pBuffer, uint dwSize);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/msp/nf-msp-itmspaddress-getevent
    HRESULT GetEvent(uint* pdwSize, ubyte* pEventBuffer);
}

@GUID("9f34325b-7e62-11d2-9457-00c04f8ec888")
interface ITTAPIDispatchEventNotification : IDispatch
{
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobjectconference
@GUID("f1029e5d-cb5b-11d0-8d59-00c04fd91ac0")
interface ITDirectoryObjectConference : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_protocol
    HRESULT get_Protocol(BSTR* ppProtocol);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_originator
    HRESULT get_Originator(BSTR* ppOriginator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_originator
    HRESULT put_Originator(BSTR pOriginator);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_advertisingscope
    HRESULT get_AdvertisingScope(RND_ADVERTISING_SCOPE* pAdvertisingScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_advertisingscope
    HRESULT put_AdvertisingScope(RND_ADVERTISING_SCOPE AdvertisingScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_url
    HRESULT get_Url(BSTR* ppUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_url
    HRESULT put_Url(BSTR pUrl);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_description
    HRESULT get_Description(BSTR* ppDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_description
    HRESULT put_Description(BSTR pDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_isencrypted
    HRESULT get_IsEncrypted(VARIANT_BOOL* pfEncrypted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_isencrypted
    HRESULT put_IsEncrypted(VARIANT_BOOL fEncrypted);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_starttime
    HRESULT get_StartTime(double* pDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_starttime
    HRESULT put_StartTime(double Date);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-get_stoptime
    HRESULT get_StopTime(double* pDate);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectconference-put_stoptime
    HRESULT put_StopTime(double Date);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobjectuser
@GUID("34621d6f-6cff-11d1-aff7-00c04fc31fee")
interface ITDirectoryObjectUser : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectuser-get_ipphoneprimary
    HRESULT get_IPPhonePrimary(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobjectuser-put_ipphoneprimary
    HRESULT put_IPPhonePrimary(BSTR pName);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdialableaddrs
@GUID("34621d70-6cff-11d1-aff7-00c04fc31fee")
interface IEnumDialableAddrs : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-next
    HRESULT Next(uint celt, BSTR* ppElements, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdialableaddrs-clone
    HRESULT Clone(IEnumDialableAddrs* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectoryobject
@GUID("34621d6e-6cff-11d1-aff7-00c04fc31fee")
interface ITDirectoryObject : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_objecttype
    HRESULT get_ObjectType(DIRECTORY_OBJECT_TYPE* pObjectType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_name
    HRESULT get_Name(BSTR* ppName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-put_name
    HRESULT put_Name(BSTR pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_dialableaddrs
    HRESULT get_DialableAddrs(int dwAddressType, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-enumeratedialableaddrs
    HRESULT EnumerateDialableAddrs(uint dwAddressType, IEnumDialableAddrs* ppEnumDialableAddrs);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-get_securitydescriptor
    HRESULT get_SecurityDescriptor(IDispatch* ppSecDes);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectoryobject-put_securitydescriptor
    HRESULT put_SecurityDescriptor(IDispatch pSecDes);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdirectoryobject
@GUID("06c9b64a-306d-11d1-9774-00c04fd91ac0")
interface IEnumDirectoryObject : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-next
    HRESULT Next(uint celt, ITDirectoryObject* pVal, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectoryobject-clone
    HRESULT Clone(IEnumDirectoryObject* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itilsconfig
@GUID("34621d72-6cff-11d1-aff7-00c04fc31fee")
interface ITILSConfig : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itilsconfig-get_port
    HRESULT get_Port(int* pPort);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itilsconfig-put_port
    HRESULT put_Port(int Port);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itdirectory
@GUID("34621d6c-6cff-11d1-aff7-00c04fc31fee")
interface ITDirectory : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_directorytype
    HRESULT get_DirectoryType(DIRECTORY_TYPE* pDirectoryType);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_displayname
    HRESULT get_DisplayName(BSTR* pName);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_isdynamic
    HRESULT get_IsDynamic(VARIANT_BOOL* pfDynamic);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_defaultobjectttl
    HRESULT get_DefaultObjectTTL(int* pTTL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-put_defaultobjectttl
    HRESULT put_DefaultObjectTTL(int TTL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-enableautorefresh
    HRESULT EnableAutoRefresh(VARIANT_BOOL fEnable);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-connect
    HRESULT Connect(VARIANT_BOOL fSecure);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-bind
    HRESULT Bind(BSTR pDomainName, BSTR pUserName, BSTR pPassword, int lFlags);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-adddirectoryobject
    HRESULT AddDirectoryObject(ITDirectoryObject pDirectoryObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-modifydirectoryobject
    HRESULT ModifyDirectoryObject(ITDirectoryObject pDirectoryObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-refreshdirectoryobject
    HRESULT RefreshDirectoryObject(ITDirectoryObject pDirectoryObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-deletedirectoryobject
    HRESULT DeleteDirectoryObject(ITDirectoryObject pDirectoryObject);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-get_directoryobjects
    HRESULT get_DirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itdirectory-enumeratedirectoryobjects
    HRESULT EnumerateDirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                      IEnumDirectoryObject* ppEnumObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-ienumdirectory
@GUID("34621d6d-6cff-11d1-aff7-00c04fc31fee")
interface IEnumDirectory : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-next
    HRESULT Next(uint celt, ITDirectory* ppElements, uint* pcFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-ienumdirectory-clone
    HRESULT Clone(IEnumDirectory* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nn-rend-itrendezvous
@GUID("34621d6b-6cff-11d1-aff7-00c04fc31fee")
interface ITRendezvous : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-get_defaultdirectories
    HRESULT get_DefaultDirectories(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-enumeratedefaultdirectories
    HRESULT EnumerateDefaultDirectories(IEnumDirectory* ppEnumDirectory);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-createdirectory
    HRESULT CreateDirectory(DIRECTORY_TYPE DirectoryType, BSTR pName, ITDirectory* ppDir);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/rend/nf-rend-itrendezvous-createdirectoryobject
    HRESULT CreateDirectoryObject(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                  ITDirectoryObject* ppDirectoryObject);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastscope
@GUID("df0daef4-a289-11d1-8697-006008b0e5d2")
interface IMcastScope : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_scopeid
    HRESULT get_ScopeID(int* pID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_serverid
    HRESULT get_ServerID(int* pID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_interfaceid
    HRESULT get_InterfaceID(int* pID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_scopedescription
    HRESULT get_ScopeDescription(BSTR* ppDescription);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastscope-get_ttl
    HRESULT get_TTL(int* pTTL);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastleaseinfo
@GUID("df0daefd-a289-11d1-8697-006008b0e5d2")
interface IMcastLeaseInfo : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_requestid
    HRESULT get_RequestID(BSTR* ppRequestID);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_leasestarttime
    HRESULT get_LeaseStartTime(double* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-put_leasestarttime
    HRESULT put_LeaseStartTime(double time);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_leasestoptime
    HRESULT get_LeaseStopTime(double* pTime);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-put_leasestoptime
    HRESULT put_LeaseStopTime(double time);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_addresscount
    HRESULT get_AddressCount(int* pCount);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_serveraddress
    HRESULT get_ServerAddress(BSTR* ppAddress);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_ttl
    HRESULT get_TTL(int* pTTL);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-get_addresses
    HRESULT get_Addresses(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastleaseinfo-enumerateaddresses
    HRESULT EnumerateAddresses(IEnumBstr* ppEnumAddresses);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-ienummcastscope
@GUID("df0daf09-a289-11d1-8697-006008b0e5d2")
interface IEnumMcastScope : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-next
    HRESULT Next(uint celt, IMcastScope* ppScopes, uint* pceltFetched);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-reset
    HRESULT Reset();
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-skip
    HRESULT Skip(uint celt);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-ienummcastscope-clone
    HRESULT Clone(IEnumMcastScope* ppEnum);
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nn-mdhcp-imcastaddressallocation
@GUID("df0daef1-a289-11d1-8697-006008b0e5d2")
interface IMcastAddressAllocation : IDispatch
{
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-get_scopes
    HRESULT get_Scopes(VARIANT* pVariant);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-enumeratescopes
    HRESULT EnumerateScopes(IEnumMcastScope* ppEnumMcastScope);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-requestaddress
    HRESULT RequestAddress(IMcastScope pScope, double LeaseStartTime, double LeaseStopTime, int NumAddresses, 
                           IMcastLeaseInfo* ppLeaseResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-renewaddress
    HRESULT RenewAddress(int lReserved, IMcastLeaseInfo pRenewRequest, IMcastLeaseInfo* ppRenewResponse);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-releaseaddress
    HRESULT ReleaseAddress(IMcastLeaseInfo pReleaseRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-createleaseinfo
    HRESULT CreateLeaseInfo(double LeaseStartTime, double LeaseStopTime, uint dwNumAddresses, PWSTR* ppAddresses, 
                            PWSTR pRequestID, PWSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/api/mdhcp/nf-mdhcp-imcastaddressallocation-createleaseinfofromvariant
    HRESULT CreateLeaseInfoFromVariant(double LeaseStartTime, double LeaseStopTime, VARIANT vAddresses, 
                                       BSTR pRequestID, BSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
}

// Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnefiunknown
interface ITnef : IUnknown
{
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-addprops
    HRESULT AddProps(uint ulFlags, uint ulElemID, void* lpvData, SPropTagArray* lpPropList);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-extractprops
    HRESULT ExtractProps(uint ulFlags, SPropTagArray* lpPropList, STnefProblemArray** lpProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-finish
    HRESULT Finish(uint ulFlags, ushort* lpKey, STnefProblemArray** lpProblems);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-opentaggedbody
    HRESULT OpenTaggedBody(IMessage lpMessage, uint ulFlags, IStream* lppStream);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-setprops
    HRESULT SetProps(uint ulFlags, uint ulElemID, uint cValues, SPropValue* lpProps);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-encoderecips
    HRESULT EncodeRecips(uint ulFlags, IMAPITable lpRecipientTable);
    // Microsoft documentation: https://learn.microsoft.com/office/client-developer/outlook/mapi/itnef-finishcomponent
    HRESULT FinishComponent(uint ulFlags, uint ulComponentID, SPropTagArray* lpCustomPropList, 
                            SPropValue* lpCustomProps, SPropTagArray* lpPropList, STnefProblemArray** lpProblems);
}


// GUIDs

const GUID CLSID_DispatchMapper         = GUIDOF!DispatchMapper;
const GUID CLSID_McastAddressAllocation = GUIDOF!McastAddressAllocation;
const GUID CLSID_Rendezvous             = GUIDOF!Rendezvous;
const GUID CLSID_RequestMakeCall        = GUIDOF!RequestMakeCall;
const GUID CLSID_TAPI                   = GUIDOF!TAPI;

const GUID IID_IEnumACDGroup                            = GUIDOF!IEnumACDGroup;
const GUID IID_IEnumAddress                             = GUIDOF!IEnumAddress;
const GUID IID_IEnumAgent                               = GUIDOF!IEnumAgent;
const GUID IID_IEnumAgentHandler                        = GUIDOF!IEnumAgentHandler;
const GUID IID_IEnumAgentSession                        = GUIDOF!IEnumAgentSession;
const GUID IID_IEnumBstr                                = GUIDOF!IEnumBstr;
const GUID IID_IEnumCall                                = GUIDOF!IEnumCall;
const GUID IID_IEnumCallHub                             = GUIDOF!IEnumCallHub;
const GUID IID_IEnumCallingCard                         = GUIDOF!IEnumCallingCard;
const GUID IID_IEnumDialableAddrs                       = GUIDOF!IEnumDialableAddrs;
const GUID IID_IEnumDirectory                           = GUIDOF!IEnumDirectory;
const GUID IID_IEnumDirectoryObject                     = GUIDOF!IEnumDirectoryObject;
const GUID IID_IEnumLocation                            = GUIDOF!IEnumLocation;
const GUID IID_IEnumMcastScope                          = GUIDOF!IEnumMcastScope;
const GUID IID_IEnumPhone                               = GUIDOF!IEnumPhone;
const GUID IID_IEnumPluggableSuperclassInfo             = GUIDOF!IEnumPluggableSuperclassInfo;
const GUID IID_IEnumPluggableTerminalClassInfo          = GUIDOF!IEnumPluggableTerminalClassInfo;
const GUID IID_IEnumQueue                               = GUIDOF!IEnumQueue;
const GUID IID_IEnumStream                              = GUIDOF!IEnumStream;
const GUID IID_IEnumSubStream                           = GUIDOF!IEnumSubStream;
const GUID IID_IEnumTerminal                            = GUIDOF!IEnumTerminal;
const GUID IID_IEnumTerminalClass                       = GUIDOF!IEnumTerminalClass;
const GUID IID_IMcastAddressAllocation                  = GUIDOF!IMcastAddressAllocation;
const GUID IID_IMcastLeaseInfo                          = GUIDOF!IMcastLeaseInfo;
const GUID IID_IMcastScope                              = GUIDOF!IMcastScope;
const GUID IID_ITACDGroup                               = GUIDOF!ITACDGroup;
const GUID IID_ITACDGroupEvent                          = GUIDOF!ITACDGroupEvent;
const GUID IID_ITAMMediaFormat                          = GUIDOF!ITAMMediaFormat;
const GUID IID_ITASRTerminalEvent                       = GUIDOF!ITASRTerminalEvent;
const GUID IID_ITAddress                                = GUIDOF!ITAddress;
const GUID IID_ITAddress2                               = GUIDOF!ITAddress2;
const GUID IID_ITAddressCapabilities                    = GUIDOF!ITAddressCapabilities;
const GUID IID_ITAddressDeviceSpecificEvent             = GUIDOF!ITAddressDeviceSpecificEvent;
const GUID IID_ITAddressEvent                           = GUIDOF!ITAddressEvent;
const GUID IID_ITAddressTranslation                     = GUIDOF!ITAddressTranslation;
const GUID IID_ITAddressTranslationInfo                 = GUIDOF!ITAddressTranslationInfo;
const GUID IID_ITAgent                                  = GUIDOF!ITAgent;
const GUID IID_ITAgentEvent                             = GUIDOF!ITAgentEvent;
const GUID IID_ITAgentHandler                           = GUIDOF!ITAgentHandler;
const GUID IID_ITAgentHandlerEvent                      = GUIDOF!ITAgentHandlerEvent;
const GUID IID_ITAgentSession                           = GUIDOF!ITAgentSession;
const GUID IID_ITAgentSessionEvent                      = GUIDOF!ITAgentSessionEvent;
const GUID IID_ITAllocatorProperties                    = GUIDOF!ITAllocatorProperties;
const GUID IID_ITAutomatedPhoneControl                  = GUIDOF!ITAutomatedPhoneControl;
const GUID IID_ITBasicAudioTerminal                     = GUIDOF!ITBasicAudioTerminal;
const GUID IID_ITBasicCallControl                       = GUIDOF!ITBasicCallControl;
const GUID IID_ITBasicCallControl2                      = GUIDOF!ITBasicCallControl2;
const GUID IID_ITCallHub                                = GUIDOF!ITCallHub;
const GUID IID_ITCallHubEvent                           = GUIDOF!ITCallHubEvent;
const GUID IID_ITCallInfo                               = GUIDOF!ITCallInfo;
const GUID IID_ITCallInfo2                              = GUIDOF!ITCallInfo2;
const GUID IID_ITCallInfoChangeEvent                    = GUIDOF!ITCallInfoChangeEvent;
const GUID IID_ITCallMediaEvent                         = GUIDOF!ITCallMediaEvent;
const GUID IID_ITCallNotificationEvent                  = GUIDOF!ITCallNotificationEvent;
const GUID IID_ITCallStateEvent                         = GUIDOF!ITCallStateEvent;
const GUID IID_ITCallingCard                            = GUIDOF!ITCallingCard;
const GUID IID_ITCollection                             = GUIDOF!ITCollection;
const GUID IID_ITCollection2                            = GUIDOF!ITCollection2;
const GUID IID_ITCustomTone                             = GUIDOF!ITCustomTone;
const GUID IID_ITDetectTone                             = GUIDOF!ITDetectTone;
const GUID IID_ITDigitDetectionEvent                    = GUIDOF!ITDigitDetectionEvent;
const GUID IID_ITDigitGenerationEvent                   = GUIDOF!ITDigitGenerationEvent;
const GUID IID_ITDigitsGatheredEvent                    = GUIDOF!ITDigitsGatheredEvent;
const GUID IID_ITDirectory                              = GUIDOF!ITDirectory;
const GUID IID_ITDirectoryObject                        = GUIDOF!ITDirectoryObject;
const GUID IID_ITDirectoryObjectConference              = GUIDOF!ITDirectoryObjectConference;
const GUID IID_ITDirectoryObjectUser                    = GUIDOF!ITDirectoryObjectUser;
const GUID IID_ITDispatchMapper                         = GUIDOF!ITDispatchMapper;
const GUID IID_ITFileTerminalEvent                      = GUIDOF!ITFileTerminalEvent;
const GUID IID_ITFileTrack                              = GUIDOF!ITFileTrack;
const GUID IID_ITForwardInformation                     = GUIDOF!ITForwardInformation;
const GUID IID_ITForwardInformation2                    = GUIDOF!ITForwardInformation2;
const GUID IID_ITILSConfig                              = GUIDOF!ITILSConfig;
const GUID IID_ITLegacyAddressMediaControl              = GUIDOF!ITLegacyAddressMediaControl;
const GUID IID_ITLegacyAddressMediaControl2             = GUIDOF!ITLegacyAddressMediaControl2;
const GUID IID_ITLegacyCallMediaControl                 = GUIDOF!ITLegacyCallMediaControl;
const GUID IID_ITLegacyCallMediaControl2                = GUIDOF!ITLegacyCallMediaControl2;
const GUID IID_ITLegacyWaveSupport                      = GUIDOF!ITLegacyWaveSupport;
const GUID IID_ITLocationInfo                           = GUIDOF!ITLocationInfo;
const GUID IID_ITMSPAddress                             = GUIDOF!ITMSPAddress;
const GUID IID_ITMediaControl                           = GUIDOF!ITMediaControl;
const GUID IID_ITMediaPlayback                          = GUIDOF!ITMediaPlayback;
const GUID IID_ITMediaRecord                            = GUIDOF!ITMediaRecord;
const GUID IID_ITMediaSupport                           = GUIDOF!ITMediaSupport;
const GUID IID_ITMultiTrackTerminal                     = GUIDOF!ITMultiTrackTerminal;
const GUID IID_ITPhone                                  = GUIDOF!ITPhone;
const GUID IID_ITPhoneDeviceSpecificEvent               = GUIDOF!ITPhoneDeviceSpecificEvent;
const GUID IID_ITPhoneEvent                             = GUIDOF!ITPhoneEvent;
const GUID IID_ITPluggableTerminalClassInfo             = GUIDOF!ITPluggableTerminalClassInfo;
const GUID IID_ITPluggableTerminalEventSink             = GUIDOF!ITPluggableTerminalEventSink;
const GUID IID_ITPluggableTerminalEventSinkRegistration = GUIDOF!ITPluggableTerminalEventSinkRegistration;
const GUID IID_ITPluggableTerminalSuperclassInfo        = GUIDOF!ITPluggableTerminalSuperclassInfo;
const GUID IID_ITPrivateEvent                           = GUIDOF!ITPrivateEvent;
const GUID IID_ITQOSEvent                               = GUIDOF!ITQOSEvent;
const GUID IID_ITQueue                                  = GUIDOF!ITQueue;
const GUID IID_ITQueueEvent                             = GUIDOF!ITQueueEvent;
const GUID IID_ITRendezvous                             = GUIDOF!ITRendezvous;
const GUID IID_ITRequest                                = GUIDOF!ITRequest;
const GUID IID_ITRequestEvent                           = GUIDOF!ITRequestEvent;
const GUID IID_ITScriptableAudioFormat                  = GUIDOF!ITScriptableAudioFormat;
const GUID IID_ITStaticAudioTerminal                    = GUIDOF!ITStaticAudioTerminal;
const GUID IID_ITStream                                 = GUIDOF!ITStream;
const GUID IID_ITStreamControl                          = GUIDOF!ITStreamControl;
const GUID IID_ITSubStream                              = GUIDOF!ITSubStream;
const GUID IID_ITSubStreamControl                       = GUIDOF!ITSubStreamControl;
const GUID IID_ITTAPI                                   = GUIDOF!ITTAPI;
const GUID IID_ITTAPI2                                  = GUIDOF!ITTAPI2;
const GUID IID_ITTAPICallCenter                         = GUIDOF!ITTAPICallCenter;
const GUID IID_ITTAPIDispatchEventNotification          = GUIDOF!ITTAPIDispatchEventNotification;
const GUID IID_ITTAPIEventNotification                  = GUIDOF!ITTAPIEventNotification;
const GUID IID_ITTAPIObjectEvent                        = GUIDOF!ITTAPIObjectEvent;
const GUID IID_ITTAPIObjectEvent2                       = GUIDOF!ITTAPIObjectEvent2;
const GUID IID_ITTTSTerminalEvent                       = GUIDOF!ITTTSTerminalEvent;
const GUID IID_ITTerminal                               = GUIDOF!ITTerminal;
const GUID IID_ITTerminalSupport                        = GUIDOF!ITTerminalSupport;
const GUID IID_ITTerminalSupport2                       = GUIDOF!ITTerminalSupport2;
const GUID IID_ITToneDetectionEvent                     = GUIDOF!ITToneDetectionEvent;
const GUID IID_ITToneTerminalEvent                      = GUIDOF!ITToneTerminalEvent;
