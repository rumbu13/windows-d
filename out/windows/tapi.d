module windows.tapi;

public import windows.core;
public import windows.automation : BSTR, IDispatch, VARIANT;
public import windows.com : HRESULT, IEnumUnknown, IUnknown;
public import windows.directshow : ALLOCATOR_PROPERTIES, AM_MEDIA_TYPE;
public import windows.systemservices : BOOL, CY, HANDLE, HINSTANCE;
public import windows.windowsandmessaging : HWND, WPARAM;
public import windows.windowsprogramming : SYSTEMTIME;

extern(Windows):


// Enums


enum : int
{
    TTM_RINGBACK = 0x00000002,
    TTM_BUSY     = 0x00000004,
    TTM_BEEP     = 0x00000008,
    TTM_BILLING  = 0x00000010,
}
alias TAPI_TONEMODE = int;

enum : int
{
    TGT_BUFFERFULL   = 0x00000001,
    TGT_TERMDIGIT    = 0x00000002,
    TGT_FIRSTTIMEOUT = 0x00000004,
    TGT_INTERTIMEOUT = 0x00000008,
    TGT_CANCEL       = 0x00000010,
}
alias TAPI_GATHERTERM = int;

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
alias ADDRESS_EVENT = int;

enum : int
{
    AS_INSERVICE    = 0x00000000,
    AS_OUTOFSERVICE = 0x00000001,
}
alias ADDRESS_STATE = int;

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
alias CALL_STATE = int;

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
alias CALL_STATE_EVENT_CAUSE = int;

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
alias CALL_MEDIA_EVENT = int;

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
alias CALL_MEDIA_EVENT_CAUSE = int;

enum : int
{
    DC_NORMAL   = 0x00000000,
    DC_NOANSWER = 0x00000001,
    DC_REJECTED = 0x00000002,
}
alias DISCONNECT_CODE = int;

enum : int
{
    TS_INUSE    = 0x00000000,
    TS_NOTINUSE = 0x00000001,
}
alias TERMINAL_STATE = int;

enum : int
{
    TD_CAPTURE          = 0x00000000,
    TD_RENDER           = 0x00000001,
    TD_BIDIRECTIONAL    = 0x00000002,
    TD_MULTITRACK_MIXED = 0x00000003,
    TD_NONE             = 0x00000004,
}
alias TERMINAL_DIRECTION = int;

enum : int
{
    TT_STATIC  = 0x00000000,
    TT_DYNAMIC = 0x00000001,
}
alias TERMINAL_TYPE = int;

enum : int
{
    CP_OWNER   = 0x00000000,
    CP_MONITOR = 0x00000001,
}
alias CALL_PRIVILEGE = int;

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
alias TAPI_EVENT = int;

enum : int
{
    CNE_OWNER    = 0x00000000,
    CNE_MONITOR  = 0x00000001,
    CNE_LASTITEM = 0x00000001,
}
alias CALL_NOTIFICATION_EVENT = int;

enum : int
{
    CHE_CALLJOIN    = 0x00000000,
    CHE_CALLLEAVE   = 0x00000001,
    CHE_CALLHUBNEW  = 0x00000002,
    CHE_CALLHUBIDLE = 0x00000003,
    CHE_LASTITEM    = 0x00000003,
}
alias CALLHUB_EVENT = int;

enum : int
{
    CHS_ACTIVE = 0x00000000,
    CHS_IDLE   = 0x00000001,
}
alias CALLHUB_STATE = int;

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
alias TAPIOBJECT_EVENT = int;

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
alias TAPI_OBJECT_TYPE = int;

enum : int
{
    QSL_NEEDED       = 0x00000001,
    QSL_IF_AVAILABLE = 0x00000002,
    QSL_BEST_EFFORT  = 0x00000003,
}
alias QOS_SERVICE_LEVEL = int;

enum : int
{
    QE_NOQOS            = 0x00000001,
    QE_ADMISSIONFAILURE = 0x00000002,
    QE_POLICYFAILURE    = 0x00000003,
    QE_GENERICERROR     = 0x00000004,
    QE_LASTITEM         = 0x00000004,
}
alias QOS_EVENT = int;

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
alias CALLINFOCHANGE_CAUSE = int;

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
alias CALLINFO_LONG = int;

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
alias CALLINFO_STRING = int;

enum : int
{
    CIB_USERUSERINFO                 = 0x00000000,
    CIB_DEVSPECIFICBUFFER            = 0x00000001,
    CIB_CALLDATABUFFER               = 0x00000002,
    CIB_CHARGINGINFOBUFFER           = 0x00000003,
    CIB_HIGHLEVELCOMPATIBILITYBUFFER = 0x00000004,
    CIB_LOWLEVELCOMPATIBILITYBUFFER  = 0x00000005,
}
alias CALLINFO_BUFFER = int;

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
alias ADDRESS_CAPABILITY = int;

enum : int
{
    ACS_PROTOCOL              = 0x00000000,
    ACS_ADDRESSDEVICESPECIFIC = 0x00000001,
    ACS_LINEDEVICESPECIFIC    = 0x00000002,
    ACS_PROVIDERSPECIFIC      = 0x00000003,
    ACS_SWITCHSPECIFIC        = 0x00000004,
    ACS_PERMANENTDEVICEGUID   = 0x00000005,
}
alias ADDRESS_CAPABILITY_STRING = int;

enum : int
{
    FDS_SUPPORTED    = 0x00000000,
    FDS_NOTSUPPORTED = 0x00000001,
    FDS_UNKNOWN      = 0x00000002,
}
alias FULLDUPLEX_SUPPORT = int;

enum : int
{
    FM_ASTRANSFER   = 0x00000000,
    FM_ASCONFERENCE = 0x00000001,
}
alias FINISH_MODE = int;

enum : int
{
    PP_OWNER   = 0x00000000,
    PP_MONITOR = 0x00000001,
}
alias PHONE_PRIVILEGE = int;

enum : int
{
    PHSD_HANDSET      = 0x00000001,
    PHSD_SPEAKERPHONE = 0x00000002,
    PHSD_HEADSET      = 0x00000004,
}
alias PHONE_HOOK_SWITCH_DEVICE = int;

enum : int
{
    PHSS_ONHOOK               = 0x00000001,
    PHSS_OFFHOOK_MIC_ONLY     = 0x00000002,
    PHSS_OFFHOOK_SPEAKER_ONLY = 0x00000004,
    PHSS_OFFHOOK              = 0x00000008,
}
alias PHONE_HOOK_SWITCH_STATE = int;

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
alias PHONE_LAMP_MODE = int;

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
alias PHONECAPS_LONG = int;

enum : int
{
    PCS_PHONENAME    = 0x00000000,
    PCS_PHONEINFO    = 0x00000001,
    PCS_PROVIDERINFO = 0x00000002,
}
alias PHONECAPS_STRING = int;

enum : int
{
    PCB_DEVSPECIFICBUFFER = 0x00000000,
}
alias PHONECAPS_BUFFER = int;

enum : int
{
    PBS_UP      = 0x00000001,
    PBS_DOWN    = 0x00000002,
    PBS_UNKNOWN = 0x00000004,
    PBS_UNAVAIL = 0x00000008,
}
alias PHONE_BUTTON_STATE = int;

enum : int
{
    PBM_DUMMY   = 0x00000000,
    PBM_CALL    = 0x00000001,
    PBM_FEATURE = 0x00000002,
    PBM_KEYPAD  = 0x00000003,
    PBM_LOCAL   = 0x00000004,
    PBM_DISPLAY = 0x00000005,
}
alias PHONE_BUTTON_MODE = int;

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
alias PHONE_BUTTON_FUNCTION = int;

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
alias PHONE_TONE = int;

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
alias PHONE_EVENT = int;

enum : int
{
    TMS_IDLE     = 0x00000000,
    TMS_ACTIVE   = 0x00000001,
    TMS_PAUSED   = 0x00000002,
    TMS_LASTITEM = 0x00000002,
}
alias TERMINAL_MEDIA_STATE = int;

enum : int
{
    FTEC_NORMAL      = 0x00000000,
    FTEC_END_OF_FILE = 0x00000001,
    FTEC_READ_ERROR  = 0x00000002,
    FTEC_WRITE_ERROR = 0x00000003,
}
alias FT_STATE_EVENT_CAUSE = int;

enum : int
{
    AE_NOT_READY     = 0x00000000,
    AE_READY         = 0x00000001,
    AE_BUSY_ACD      = 0x00000002,
    AE_BUSY_INCOMING = 0x00000003,
    AE_BUSY_OUTGOING = 0x00000004,
    AE_UNKNOWN       = 0x00000005,
}
alias AGENT_EVENT = int;

enum : int
{
    AS_NOT_READY     = 0x00000000,
    AS_READY         = 0x00000001,
    AS_BUSY_ACD      = 0x00000002,
    AS_BUSY_INCOMING = 0x00000003,
    AS_BUSY_OUTGOING = 0x00000004,
    AS_UNKNOWN       = 0x00000005,
}
alias AGENT_STATE = int;

enum : int
{
    ASE_NEW_SESSION = 0x00000000,
    ASE_NOT_READY   = 0x00000001,
    ASE_READY       = 0x00000002,
    ASE_BUSY        = 0x00000003,
    ASE_WRAPUP      = 0x00000004,
    ASE_END         = 0x00000005,
}
alias AGENT_SESSION_EVENT = int;

enum : int
{
    ASST_NOT_READY     = 0x00000000,
    ASST_READY         = 0x00000001,
    ASST_BUSY_ON_CALL  = 0x00000002,
    ASST_BUSY_WRAPUP   = 0x00000003,
    ASST_SESSION_ENDED = 0x00000004,
}
alias AGENT_SESSION_STATE = int;

enum : int
{
    AHE_NEW_AGENTHANDLER     = 0x00000000,
    AHE_AGENTHANDLER_REMOVED = 0x00000001,
}
alias AGENTHANDLER_EVENT = int;

enum : int
{
    ACDGE_NEW_GROUP     = 0x00000000,
    ACDGE_GROUP_REMOVED = 0x00000001,
}
alias ACDGROUP_EVENT = int;

enum : int
{
    ACDQE_NEW_QUEUE     = 0x00000000,
    ACDQE_QUEUE_REMOVED = 0x00000001,
}
alias ACDQUEUE_EVENT = int;

enum : int
{
    ADDRESS_TERMINAL_AVAILABLE   = 0x00000000,
    ADDRESS_TERMINAL_UNAVAILABLE = 0x00000001,
}
alias MSP_ADDRESS_EVENT = int;

enum : int
{
    CALL_NEW_STREAM      = 0x00000000,
    CALL_STREAM_FAIL     = 0x00000001,
    CALL_TERMINAL_FAIL   = 0x00000002,
    CALL_STREAM_NOT_USED = 0x00000003,
    CALL_STREAM_ACTIVE   = 0x00000004,
    CALL_STREAM_INACTIVE = 0x00000005,
}
alias MSP_CALL_EVENT = int;

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
alias MSP_CALL_EVENT_CAUSE = int;

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
alias MSP_EVENT = int;

enum : int
{
    DT_NTDS = 0x00000001,
    DT_ILS  = 0x00000002,
}
alias DIRECTORY_TYPE = int;

enum : int
{
    OT_CONFERENCE = 0x00000001,
    OT_USER       = 0x00000002,
}
alias DIRECTORY_OBJECT_TYPE = int;

enum : int
{
    RAS_LOCAL  = 0x00000001,
    RAS_SITE   = 0x00000002,
    RAS_REGION = 0x00000003,
    RAS_WORLD  = 0x00000004,
}
alias RND_ADVERTISING_SCOPE = int;

// Callbacks

alias LINECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                   size_t dwParam2, size_t dwParam3);
alias PHONECALLBACK = void function(uint hDevice, uint dwMessage, size_t dwInstance, size_t dwParam1, 
                                    size_t dwParam2, size_t dwParam3);

// Structs


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

struct LINEAGENTACTIVITYENTRY
{
align (1):
    uint dwID;
    uint dwNameSize;
    uint dwNameOffset;
}

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

struct LINEAGENTSESSIONENTRY
{
align (1):
    uint hAgentSession;
    uint hAgent;
    GUID GroupID;
    uint dwWorkingAddressID;
}

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

struct LINEQUEUEENTRY
{
align (1):
    uint dwQueueID;
    uint dwNameSize;
    uint dwNameOffset;
}

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

struct LINEDIALPARAMS
{
align (1):
    uint dwDialPause;
    uint dwDialSpeed;
    uint dwDigitDuration;
    uint dwWaitForDialtone;
}

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

struct LINECALLTREATMENTENTRY
{
align (1):
    uint dwCallTreatmentID;
    uint dwCallTreatmentNameSize;
    uint dwCallTreatmentNameOffset;
}

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

struct LINEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

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

struct LINEFORWARDLIST
{
align (1):
    uint           dwTotalSize;
    uint           dwNumEntries;
    LINEFORWARD[1] ForwardList;
}

struct LINEGENERATETONE
{
align (1):
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

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

struct LINEMEDIACONTROLCALLSTATE
{
align (1):
    uint dwCallStates;
    uint dwMediaControl;
}

struct LINEMEDIACONTROLDIGIT
{
align (1):
    uint dwDigit;
    uint dwDigitModes;
    uint dwMediaControl;
}

struct LINEMEDIACONTROLMEDIA
{
align (1):
    uint dwMediaModes;
    uint dwDuration;
    uint dwMediaControl;
}

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

struct LINEMONITORTONE
{
align (1):
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

struct LINEPROVIDERENTRY
{
align (1):
    uint dwPermanentProviderID;
    uint dwProviderFilenameSize;
    uint dwProviderFilenameOffset;
}

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
            ubyte[1] Params;
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

struct LINEREQMAKECALL
{
    byte[80] szDestAddress;
    byte[40] szAppName;
    byte[40] szCalledParty;
    byte[80] szComment;
}

struct linereqmakecallW_tag
{
align (1):
    ushort[80] szDestAddress;
    ushort[40] szAppName;
    ushort[40] szCalledParty;
    ushort[80] szComment;
}

struct LINEREQMEDIACALL
{
align (1):
    HWND      hWnd;
    WPARAM    wRequestID;
    byte[40]  szDeviceClass;
    ubyte[40] ucDeviceID;
    uint      dwSize;
    uint      dwSecure;
    byte[80]  szDestAddress;
    byte[40]  szAppName;
    byte[40]  szCalledParty;
    byte[80]  szComment;
}

struct linereqmediacallW_tag
{
align (1):
    HWND       hWnd;
    WPARAM     wRequestID;
    ushort[40] szDeviceClass;
    ubyte[40]  ucDeviceID;
    uint       dwSize;
    uint       dwSecure;
    ushort[80] szDestAddress;
    ushort[40] szAppName;
    ushort[40] szCalledParty;
    ushort[80] szComment;
}

struct LINETERMCAPS
{
align (1):
    uint dwTermDev;
    uint dwTermModes;
    uint dwTermSharing;
}

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

struct PHONEEXTENSIONID
{
align (1):
    uint dwExtensionID0;
    uint dwExtensionID1;
    uint dwExtensionID2;
    uint dwExtensionID3;
}

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

struct TAPI_CUSTOMTONE
{
    uint dwFrequency;
    uint dwCadenceOn;
    uint dwCadenceOff;
    uint dwVolume;
}

struct TAPI_DETECTTONE
{
    uint dwAppSpecific;
    uint dwDuration;
    uint dwFrequency1;
    uint dwFrequency2;
    uint dwFrequency3;
}

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
            ubyte[1] pBuffer;
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

// Functions

@DllImport("TAPI32")
int lineAccept(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32")
int lineAddProvider(const(char)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32")
int lineAddProviderA(const(char)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32")
int lineAddProviderW(const(wchar)* lpszProviderFilename, HWND hwndOwner, uint* lpdwPermanentProviderID);

@DllImport("TAPI32")
int lineAddToConference(uint hConfCall, uint hConsultCall);

@DllImport("TAPI32")
int lineAgentSpecific(uint hLine, uint dwAddressID, uint dwAgentExtensionIDIndex, void* lpParams, uint dwSize);

@DllImport("TAPI32")
int lineAnswer(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32")
int lineBlindTransfer(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineBlindTransferA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineBlindTransferW(uint hCall, const(wchar)* lpszDestAddressW, uint dwCountryCode);

@DllImport("TAPI32")
int lineClose(uint hLine);

@DllImport("TAPI32")
int lineCompleteCall(uint hCall, uint* lpdwCompletionID, uint dwCompletionMode, uint dwMessageID);

@DllImport("TAPI32")
int lineCompleteTransfer(uint hCall, uint hConsultCall, uint* lphConfCall, uint dwTransferMode);

@DllImport("TAPI32")
int lineConfigDialog(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int lineConfigDialogEdit(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass, 
                         const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32")
int lineConfigDialogEditA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32")
int lineConfigDialogEditW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass, 
                          const(void)* lpDeviceConfigIn, uint dwSize, VARSTRING* lpDeviceConfigOut);

@DllImport("TAPI32")
int lineConfigProvider(HWND hwndOwner, uint dwPermanentProviderID);

@DllImport("TAPI32")
int lineCreateAgentW(uint hLine, const(wchar)* lpszAgentID, const(wchar)* lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32")
int lineCreateAgentA(uint hLine, const(char)* lpszAgentID, const(char)* lpszAgentPIN, uint* lphAgent);

@DllImport("TAPI32")
int lineCreateAgentSessionW(uint hLine, uint hAgent, const(wchar)* lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

@DllImport("TAPI32")
int lineCreateAgentSessionA(uint hLine, uint hAgent, const(char)* lpszAgentPIN, uint dwWorkingAddressID, 
                            GUID* lpGroupID, uint* lphAgentSession);

@DllImport("TAPI32")
int lineDeallocateCall(uint hCall);

@DllImport("TAPI32")
int lineDevSpecific(uint hLine, uint dwAddressID, uint hCall, void* lpParams, uint dwSize);

@DllImport("TAPI32")
int lineDevSpecificFeature(uint hLine, uint dwFeature, void* lpParams, uint dwSize);

@DllImport("TAPI32")
int lineDial(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineDialA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineDialW(uint hCall, const(wchar)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineDrop(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32")
int lineForward(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineForwardA(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineForwardW(uint hLine, uint bAllAddresses, uint dwAddressID, const(LINEFORWARDLIST)* lpForwardList, 
                 uint dwNumRingsNoAnswer, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineGatherDigits(uint hCall, uint dwDigitModes, const(char)* lpsDigits, uint dwNumDigits, 
                     const(char)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32")
int lineGatherDigitsA(uint hCall, uint dwDigitModes, const(char)* lpsDigits, uint dwNumDigits, 
                      const(char)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32")
int lineGatherDigitsW(uint hCall, uint dwDigitModes, const(wchar)* lpsDigits, uint dwNumDigits, 
                      const(wchar)* lpszTerminationDigits, uint dwFirstDigitTimeout, uint dwInterDigitTimeout);

@DllImport("TAPI32")
int lineGenerateDigits(uint hCall, uint dwDigitMode, const(char)* lpszDigits, uint dwDuration);

@DllImport("TAPI32")
int lineGenerateDigitsA(uint hCall, uint dwDigitMode, const(char)* lpszDigits, uint dwDuration);

@DllImport("TAPI32")
int lineGenerateDigitsW(uint hCall, uint dwDigitMode, const(wchar)* lpszDigits, uint dwDuration);

@DllImport("TAPI32")
int lineGenerateTone(uint hCall, uint dwToneMode, uint dwDuration, uint dwNumTones, 
                     const(LINEGENERATETONE)* lpTones);

@DllImport("TAPI32")
int lineGetAddressCaps(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                       LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32")
int lineGetAddressCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32")
int lineGetAddressCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAPIVersion, uint dwExtVersion, 
                        LINEADDRESSCAPS* lpAddressCaps);

@DllImport("TAPI32")
int lineGetAddressID(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(char)* lpsAddress, uint dwSize);

@DllImport("TAPI32")
int lineGetAddressIDA(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(char)* lpsAddress, uint dwSize);

@DllImport("TAPI32")
int lineGetAddressIDW(uint hLine, uint* lpdwAddressID, uint dwAddressMode, const(wchar)* lpsAddress, uint dwSize);

@DllImport("TAPI32")
int lineGetAddressStatus(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32")
int lineGetAddressStatusA(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32")
int lineGetAddressStatusW(uint hLine, uint dwAddressID, LINEADDRESSSTATUS* lpAddressStatus);

@DllImport("TAPI32")
int lineGetAgentActivityListA(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32")
int lineGetAgentActivityListW(uint hLine, uint dwAddressID, LINEAGENTACTIVITYLIST* lpAgentActivityList);

@DllImport("TAPI32")
int lineGetAgentCapsA(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32")
int lineGetAgentCapsW(uint hLineApp, uint dwDeviceID, uint dwAddressID, uint dwAppAPIVersion, 
                      LINEAGENTCAPS* lpAgentCaps);

@DllImport("TAPI32")
int lineGetAgentGroupListA(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32")
int lineGetAgentGroupListW(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32")
int lineGetAgentInfo(uint hLine, uint hAgent, LINEAGENTINFO* lpAgentInfo);

@DllImport("TAPI32")
int lineGetAgentSessionInfo(uint hLine, uint hAgentSession, LINEAGENTSESSIONINFO* lpAgentSessionInfo);

@DllImport("TAPI32")
int lineGetAgentSessionList(uint hLine, uint hAgent, LINEAGENTSESSIONLIST* lpAgentSessionList);

@DllImport("TAPI32")
int lineGetAgentStatusA(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32")
int lineGetAgentStatusW(uint hLine, uint dwAddressID, LINEAGENTSTATUS* lpAgentStatus);

@DllImport("TAPI32")
int lineGetAppPriority(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32")
int lineGetAppPriorityA(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32")
int lineGetAppPriorityW(const(wchar)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, VARSTRING* lpExtensionName, uint* lpdwPriority);

@DllImport("TAPI32")
int lineGetCallInfo(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32")
int lineGetCallInfoA(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32")
int lineGetCallInfoW(uint hCall, LINECALLINFO* lpCallInfo);

@DllImport("TAPI32")
int lineGetCallStatus(uint hCall, LINECALLSTATUS* lpCallStatus);

@DllImport("TAPI32")
int lineGetConfRelatedCalls(uint hCall, LINECALLLIST* lpCallList);

@DllImport("TAPI32")
int lineGetCountry(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32")
int lineGetCountryA(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32")
int lineGetCountryW(uint dwCountryID, uint dwAPIVersion, LINECOUNTRYLIST* lpLineCountryList);

@DllImport("TAPI32")
int lineGetDevCaps(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                   LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32")
int lineGetDevCapsA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32")
int lineGetDevCapsW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, 
                    LINEDEVCAPS* lpLineDevCaps);

@DllImport("TAPI32")
int lineGetDevConfig(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetDevConfigA(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetDevConfigW(uint dwDeviceID, VARSTRING* lpDeviceConfig, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetGroupListA(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32")
int lineGetGroupListW(uint hLine, LINEAGENTGROUPLIST* lpGroupList);

@DllImport("TAPI32")
int lineGetIcon(uint dwDeviceID, const(char)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int lineGetIconA(uint dwDeviceID, const(char)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int lineGetIconW(uint dwDeviceID, const(wchar)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int lineGetID(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
              const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetIDA(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetIDW(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, VARSTRING* lpDeviceID, 
               const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int lineGetLineDevStatus(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32")
int lineGetLineDevStatusA(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32")
int lineGetLineDevStatusW(uint hLine, LINEDEVSTATUS* lpLineDevStatus);

@DllImport("TAPI32")
int lineGetMessage(uint hLineApp, LINEMESSAGE* lpMessage, uint dwTimeout);

@DllImport("TAPI32")
int lineGetNewCalls(uint hLine, uint dwAddressID, uint dwSelect, LINECALLLIST* lpCallList);

@DllImport("TAPI32")
int lineGetNumRings(uint hLine, uint dwAddressID, uint* lpdwNumRings);

@DllImport("TAPI32")
int lineGetProviderList(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32")
int lineGetProviderListA(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32")
int lineGetProviderListW(uint dwAPIVersion, LINEPROVIDERLIST* lpProviderList);

@DllImport("TAPI32")
int lineGetProxyStatus(uint hLineApp, uint dwDeviceID, uint dwAppAPIVersion, 
                       LINEPROXYREQUESTLIST* lpLineProxyReqestList);

@DllImport("TAPI32")
int lineGetQueueInfo(uint hLine, uint dwQueueID, LINEQUEUEINFO* lpLineQueueInfo);

@DllImport("TAPI32")
int lineGetQueueListA(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32")
int lineGetQueueListW(uint hLine, GUID* lpGroupID, LINEQUEUELIST* lpQueueList);

@DllImport("TAPI32")
int lineGetRequest(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32")
int lineGetRequestA(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32")
int lineGetRequestW(uint hLineApp, uint dwRequestMode, void* lpRequestBuffer);

@DllImport("TAPI32")
int lineGetStatusMessages(uint hLine, uint* lpdwLineStates, uint* lpdwAddressStates);

@DllImport("TAPI32")
int lineGetTranslateCaps(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32")
int lineGetTranslateCapsA(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32")
int lineGetTranslateCapsW(uint hLineApp, uint dwAPIVersion, LINETRANSLATECAPS* lpTranslateCaps);

@DllImport("TAPI32")
int lineHandoff(uint hCall, const(char)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32")
int lineHandoffA(uint hCall, const(char)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32")
int lineHandoffW(uint hCall, const(wchar)* lpszFileName, uint dwMediaMode);

@DllImport("TAPI32")
int lineHold(uint hCall);

@DllImport("TAPI32")
int lineInitialize(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, const(char)* lpszAppName, 
                   uint* lpdwNumDevs);

@DllImport("TAPI32")
int lineInitializeExA(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(char)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32")
int lineInitializeExW(uint* lphLineApp, HINSTANCE hInstance, LINECALLBACK lpfnCallback, 
                      const(wchar)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                      LINEINITIALIZEEXPARAMS* lpLineInitializeExParams);

@DllImport("TAPI32")
int lineMakeCall(uint hLine, uint* lphCall, const(char)* lpszDestAddress, uint dwCountryCode, 
                 const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineMakeCallA(uint hLine, uint* lphCall, const(char)* lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineMakeCallW(uint hLine, uint* lphCall, const(wchar)* lpszDestAddress, uint dwCountryCode, 
                  const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineMonitorDigits(uint hCall, uint dwDigitModes);

@DllImport("TAPI32")
int lineMonitorMedia(uint hCall, uint dwMediaModes);

@DllImport("TAPI32")
int lineMonitorTones(uint hCall, const(LINEMONITORTONE)* lpToneList, uint dwNumEntries);

@DllImport("TAPI32")
int lineNegotiateAPIVersion(uint hLineApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                            uint* lpdwAPIVersion, LINEEXTENSIONID* lpExtensionID);

@DllImport("TAPI32")
int lineNegotiateExtVersion(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                            uint dwExtHighVersion, uint* lpdwExtVersion);

@DllImport("TAPI32")
int lineOpen(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
             size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineOpenA(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineOpenW(uint hLineApp, uint dwDeviceID, uint* lphLine, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivileges, uint dwMediaModes, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int linePark(uint hCall, uint dwParkMode, const(char)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32")
int lineParkA(uint hCall, uint dwParkMode, const(char)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32")
int lineParkW(uint hCall, uint dwParkMode, const(wchar)* lpszDirAddress, VARSTRING* lpNonDirAddress);

@DllImport("TAPI32")
int linePickup(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress, const(char)* lpszGroupID);

@DllImport("TAPI32")
int linePickupA(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress, 
                const(char)* lpszGroupID);

@DllImport("TAPI32")
int linePickupW(uint hLine, uint dwAddressID, uint* lphCall, const(wchar)* lpszDestAddress, 
                const(wchar)* lpszGroupID);

@DllImport("TAPI32")
int linePrepareAddToConference(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int linePrepareAddToConferenceA(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int linePrepareAddToConferenceW(uint hConfCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineProxyMessage(uint hLine, uint hCall, uint dwMsg, uint dwParam1, uint dwParam2, uint dwParam3);

@DllImport("TAPI32")
int lineProxyResponse(uint hLine, LINEPROXYREQUEST* lpProxyRequest, uint dwResult);

@DllImport("TAPI32")
int lineRedirect(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineRedirectA(uint hCall, const(char)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineRedirectW(uint hCall, const(wchar)* lpszDestAddress, uint dwCountryCode);

@DllImport("TAPI32")
int lineRegisterRequestRecipient(uint hLineApp, uint dwRegistrationInstance, uint dwRequestMode, uint bEnable);

@DllImport("TAPI32")
int lineReleaseUserUserInfo(uint hCall);

@DllImport("TAPI32")
int lineRemoveFromConference(uint hCall);

@DllImport("TAPI32")
int lineRemoveProvider(uint dwPermanentProviderID, HWND hwndOwner);

@DllImport("TAPI32")
int lineSecureCall(uint hCall);

@DllImport("TAPI32")
int lineSendUserUserInfo(uint hCall, const(char)* lpsUserUserInfo, uint dwSize);

@DllImport("TAPI32")
int lineSetAgentActivity(uint hLine, uint dwAddressID, uint dwActivityID);

@DllImport("TAPI32")
int lineSetAgentGroup(uint hLine, uint dwAddressID, LINEAGENTGROUPLIST* lpAgentGroupList);

@DllImport("TAPI32")
int lineSetAgentMeasurementPeriod(uint hLine, uint hAgent, uint dwMeasurementPeriod);

@DllImport("TAPI32")
int lineSetAgentSessionState(uint hLine, uint hAgentSession, uint dwAgentSessionState, 
                             uint dwNextAgentSessionState);

@DllImport("TAPI32")
int lineSetAgentStateEx(uint hLine, uint hAgent, uint dwAgentState, uint dwNextAgentState);

@DllImport("TAPI32")
int lineSetAgentState(uint hLine, uint dwAddressID, uint dwAgentState, uint dwNextAgentState);

@DllImport("TAPI32")
int lineSetAppPriority(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                       uint dwRequestMode, const(char)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32")
int lineSetAppPriorityA(const(char)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(char)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32")
int lineSetAppPriorityW(const(wchar)* lpszAppFilename, uint dwMediaMode, LINEEXTENSIONID* lpExtensionID, 
                        uint dwRequestMode, const(wchar)* lpszExtensionName, uint dwPriority);

@DllImport("TAPI32")
int lineSetAppSpecific(uint hCall, uint dwAppSpecific);

@DllImport("TAPI32")
int lineSetCallData(uint hCall, void* lpCallData, uint dwSize);

@DllImport("TAPI32")
int lineSetCallParams(uint hCall, uint dwBearerMode, uint dwMinRate, uint dwMaxRate, 
                      const(LINEDIALPARAMS)* lpDialParams);

@DllImport("TAPI32")
int lineSetCallPrivilege(uint hCall, uint dwCallPrivilege);

@DllImport("TAPI32")
int lineSetCallQualityOfService(uint hCall, void* lpSendingFlowspec, uint dwSendingFlowspecSize, 
                                void* lpReceivingFlowspec, uint dwReceivingFlowspecSize);

@DllImport("TAPI32")
int lineSetCallTreatment(uint hCall, uint dwTreatment);

@DllImport("TAPI32")
int lineSetCurrentLocation(uint hLineApp, uint dwLocation);

@DllImport("TAPI32")
int lineSetDevConfig(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineSetDevConfigA(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int lineSetDevConfigW(uint dwDeviceID, const(void)* lpDeviceConfig, uint dwSize, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int lineSetLineDevStatus(uint hLine, uint dwStatusToChange, uint fStatus);

@DllImport("TAPI32")
int lineSetMediaControl(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, 
                        const(LINEMEDIACONTROLDIGIT)* lpDigitList, uint dwDigitNumEntries, 
                        const(LINEMEDIACONTROLMEDIA)* lpMediaList, uint dwMediaNumEntries, 
                        const(LINEMEDIACONTROLTONE)* lpToneList, uint dwToneNumEntries, 
                        const(LINEMEDIACONTROLCALLSTATE)* lpCallStateList, uint dwCallStateNumEntries);

@DllImport("TAPI32")
int lineSetMediaMode(uint hCall, uint dwMediaModes);

@DllImport("TAPI32")
int lineSetQueueMeasurementPeriod(uint hLine, uint dwQueueID, uint dwMeasurementPeriod);

@DllImport("TAPI32")
int lineSetNumRings(uint hLine, uint dwAddressID, uint dwNumRings);

@DllImport("TAPI32")
int lineSetStatusMessages(uint hLine, uint dwLineStates, uint dwAddressStates);

@DllImport("TAPI32")
int lineSetTerminal(uint hLine, uint dwAddressID, uint hCall, uint dwSelect, uint dwTerminalModes, 
                    uint dwTerminalID, uint bEnable);

@DllImport("TAPI32")
int lineSetTollList(uint hLineApp, uint dwDeviceID, const(char)* lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32")
int lineSetTollListA(uint hLineApp, uint dwDeviceID, const(char)* lpszAddressIn, uint dwTollListOption);

@DllImport("TAPI32")
int lineSetTollListW(uint hLineApp, uint dwDeviceID, const(wchar)* lpszAddressInW, uint dwTollListOption);

@DllImport("TAPI32")
int lineSetupConference(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                        const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineSetupConferenceA(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineSetupConferenceW(uint hCall, uint hLine, uint* lphConfCall, uint* lphConsultCall, uint dwNumParties, 
                         const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineSetupTransfer(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineSetupTransferA(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineSetupTransferW(uint hCall, uint* lphConsultCall, const(LINECALLPARAMS)* lpCallParams);

@DllImport("TAPI32")
int lineShutdown(uint hLineApp);

@DllImport("TAPI32")
int lineSwapHold(uint hActiveCall, uint hHeldCall);

@DllImport("TAPI32")
int lineTranslateAddress(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(char)* lpszAddressIn, 
                         uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32")
int lineTranslateAddressA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(char)* lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32")
int lineTranslateAddressW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, const(wchar)* lpszAddressIn, 
                          uint dwCard, uint dwTranslateOptions, LINETRANSLATEOUTPUT* lpTranslateOutput);

@DllImport("TAPI32")
int lineTranslateDialog(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                        const(char)* lpszAddressIn);

@DllImport("TAPI32")
int lineTranslateDialogA(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(char)* lpszAddressIn);

@DllImport("TAPI32")
int lineTranslateDialogW(uint hLineApp, uint dwDeviceID, uint dwAPIVersion, HWND hwndOwner, 
                         const(wchar)* lpszAddressIn);

@DllImport("TAPI32")
int lineUncompleteCall(uint hLine, uint dwCompletionID);

@DllImport("TAPI32")
int lineUnhold(uint hCall);

@DllImport("TAPI32")
int lineUnpark(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress);

@DllImport("TAPI32")
int lineUnparkA(uint hLine, uint dwAddressID, uint* lphCall, const(char)* lpszDestAddress);

@DllImport("TAPI32")
int lineUnparkW(uint hLine, uint dwAddressID, uint* lphCall, const(wchar)* lpszDestAddress);

@DllImport("TAPI32")
int phoneClose(uint hPhone);

@DllImport("TAPI32")
int phoneConfigDialog(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneConfigDialogA(uint dwDeviceID, HWND hwndOwner, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneConfigDialogW(uint dwDeviceID, HWND hwndOwner, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneDevSpecific(uint hPhone, void* lpParams, uint dwSize);

@DllImport("TAPI32")
int phoneGetButtonInfo(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32")
int phoneGetButtonInfoA(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32")
int phoneGetButtonInfoW(uint hPhone, uint dwButtonLampID, PHONEBUTTONINFO* lpButtonInfo);

@DllImport("TAPI32")
int phoneGetData(uint hPhone, uint dwDataID, void* lpData, uint dwSize);

@DllImport("TAPI32")
int phoneGetDevCaps(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32")
int phoneGetDevCapsA(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32")
int phoneGetDevCapsW(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtVersion, PHONECAPS* lpPhoneCaps);

@DllImport("TAPI32")
int phoneGetDisplay(uint hPhone, VARSTRING* lpDisplay);

@DllImport("TAPI32")
int phoneGetGain(uint hPhone, uint dwHookSwitchDev, uint* lpdwGain);

@DllImport("TAPI32")
int phoneGetHookSwitch(uint hPhone, uint* lpdwHookSwitchDevs);

@DllImport("TAPI32")
int phoneGetIcon(uint dwDeviceID, const(char)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int phoneGetIconA(uint dwDeviceID, const(char)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int phoneGetIconW(uint dwDeviceID, const(wchar)* lpszDeviceClass, ptrdiff_t* lphIcon);

@DllImport("TAPI32")
int phoneGetID(uint hPhone, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneGetIDA(uint hPhone, VARSTRING* lpDeviceID, const(char)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneGetIDW(uint hPhone, VARSTRING* lpDeviceID, const(wchar)* lpszDeviceClass);

@DllImport("TAPI32")
int phoneGetLamp(uint hPhone, uint dwButtonLampID, uint* lpdwLampMode);

@DllImport("TAPI32")
int phoneGetMessage(uint hPhoneApp, PHONEMESSAGE* lpMessage, uint dwTimeout);

@DllImport("TAPI32")
int phoneGetRing(uint hPhone, uint* lpdwRingMode, uint* lpdwVolume);

@DllImport("TAPI32")
int phoneGetStatus(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32")
int phoneGetStatusA(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32")
int phoneGetStatusW(uint hPhone, PHONESTATUS* lpPhoneStatus);

@DllImport("TAPI32")
int phoneGetStatusMessages(uint hPhone, uint* lpdwPhoneStates, uint* lpdwButtonModes, uint* lpdwButtonStates);

@DllImport("TAPI32")
int phoneGetVolume(uint hPhone, uint dwHookSwitchDev, uint* lpdwVolume);

@DllImport("TAPI32")
int phoneInitialize(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, const(char)* lpszAppName, 
                    uint* lpdwNumDevs);

@DllImport("TAPI32")
int phoneInitializeExA(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(char)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

@DllImport("TAPI32")
int phoneInitializeExW(uint* lphPhoneApp, HINSTANCE hInstance, PHONECALLBACK lpfnCallback, 
                       const(wchar)* lpszFriendlyAppName, uint* lpdwNumDevs, uint* lpdwAPIVersion, 
                       PHONEINITIALIZEEXPARAMS* lpPhoneInitializeExParams);

@DllImport("TAPI32")
int phoneNegotiateAPIVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPILowVersion, uint dwAPIHighVersion, 
                             uint* lpdwAPIVersion, PHONEEXTENSIONID* lpExtensionID);

@DllImport("TAPI32")
int phoneNegotiateExtVersion(uint hPhoneApp, uint dwDeviceID, uint dwAPIVersion, uint dwExtLowVersion, 
                             uint dwExtHighVersion, uint* lpdwExtVersion);

@DllImport("TAPI32")
int phoneOpen(uint hPhoneApp, uint dwDeviceID, uint* lphPhone, uint dwAPIVersion, uint dwExtVersion, 
              size_t dwCallbackInstance, uint dwPrivilege);

@DllImport("TAPI32")
int phoneSetButtonInfo(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32")
int phoneSetButtonInfoA(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32")
int phoneSetButtonInfoW(uint hPhone, uint dwButtonLampID, const(PHONEBUTTONINFO)* lpButtonInfo);

@DllImport("TAPI32")
int phoneSetData(uint hPhone, uint dwDataID, const(void)* lpData, uint dwSize);

@DllImport("TAPI32")
int phoneSetDisplay(uint hPhone, uint dwRow, uint dwColumn, const(char)* lpsDisplay, uint dwSize);

@DllImport("TAPI32")
int phoneSetGain(uint hPhone, uint dwHookSwitchDev, uint dwGain);

@DllImport("TAPI32")
int phoneSetHookSwitch(uint hPhone, uint dwHookSwitchDevs, uint dwHookSwitchMode);

@DllImport("TAPI32")
int phoneSetLamp(uint hPhone, uint dwButtonLampID, uint dwLampMode);

@DllImport("TAPI32")
int phoneSetRing(uint hPhone, uint dwRingMode, uint dwVolume);

@DllImport("TAPI32")
int phoneSetStatusMessages(uint hPhone, uint dwPhoneStates, uint dwButtonModes, uint dwButtonStates);

@DllImport("TAPI32")
int phoneSetVolume(uint hPhone, uint dwHookSwitchDev, uint dwVolume);

@DllImport("TAPI32")
int phoneShutdown(uint hPhoneApp);

@DllImport("TAPI32")
int tapiGetLocationInfo(const(char)* lpszCountryCode, const(char)* lpszCityCode);

@DllImport("TAPI32")
int tapiGetLocationInfoA(const(char)* lpszCountryCode, const(char)* lpszCityCode);

@DllImport("TAPI32")
int tapiGetLocationInfoW(const(wchar)* lpszCountryCodeW, const(wchar)* lpszCityCodeW);

@DllImport("TAPI32")
int tapiRequestDrop(HWND hwnd, WPARAM wRequestID);

@DllImport("TAPI32")
int tapiRequestMakeCall(const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, 
                        const(char)* lpszComment);

@DllImport("TAPI32")
int tapiRequestMakeCallA(const(char)* lpszDestAddress, const(char)* lpszAppName, const(char)* lpszCalledParty, 
                         const(char)* lpszComment);

@DllImport("TAPI32")
int tapiRequestMakeCallW(const(wchar)* lpszDestAddress, const(wchar)* lpszAppName, const(wchar)* lpszCalledParty, 
                         const(wchar)* lpszComment);

@DllImport("TAPI32")
int tapiRequestMediaCall(HWND hwnd, WPARAM wRequestID, const(char)* lpszDeviceClass, const(char)* lpDeviceID, 
                         uint dwSize, uint dwSecure, const(char)* lpszDestAddress, const(char)* lpszAppName, 
                         const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32")
int tapiRequestMediaCallA(HWND hwnd, WPARAM wRequestID, const(char)* lpszDeviceClass, const(char)* lpDeviceID, 
                          uint dwSize, uint dwSecure, const(char)* lpszDestAddress, const(char)* lpszAppName, 
                          const(char)* lpszCalledParty, const(char)* lpszComment);

@DllImport("TAPI32")
int tapiRequestMediaCallW(HWND hwnd, WPARAM wRequestID, const(wchar)* lpszDeviceClass, const(wchar)* lpDeviceID, 
                          uint dwSize, uint dwSecure, const(wchar)* lpszDestAddress, const(wchar)* lpszAppName, 
                          const(wchar)* lpszCalledParty, const(wchar)* lpszComment);


// Interfaces

@GUID("21D6D48E-A88B-11D0-83DD-00AA003CCABD")
struct TAPI;

@GUID("E9225296-C759-11D1-A02B-00C04FB6809F")
struct DispatchMapper;

@GUID("AC48FFE0-F8C4-11D1-A030-00C04FB6809F")
struct RequestMakeCall;

@GUID("F1029E5B-CB5B-11D0-8D59-00C04FD91AC0")
struct Rendezvous;

@GUID("DF0DAEF2-A289-11D1-8697-006008B0E5D2")
struct McastAddressAllocation;

@GUID("B1EFC382-9355-11D0-835C-00AA003CCABD")
interface ITTAPI : IDispatch
{
    HRESULT Initialize();
    HRESULT Shutdown();
    HRESULT get_Addresses(VARIANT* pVariant);
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    HRESULT RegisterCallNotifications(ITAddress pAddress, short fMonitor, short fOwner, int lMediaTypes, 
                                      int lCallbackInstance, int* plRegister);
    HRESULT UnregisterNotifications(int lRegister);
    HRESULT get_CallHubs(VARIANT* pVariant);
    HRESULT EnumerateCallHubs(IEnumCallHub* ppEnumCallHub);
    HRESULT SetCallHubTracking(VARIANT pAddresses, short bTracking);
    HRESULT EnumeratePrivateTAPIObjects(IEnumUnknown* ppEnumUnknown);
    HRESULT get_PrivateTAPIObjects(VARIANT* pVariant);
    HRESULT RegisterRequestRecipient(int lRegistrationInstance, int lRequestMode, short fEnable);
    HRESULT SetAssistedTelephonyPriority(BSTR pAppFilename, short fPriority);
    HRESULT SetApplicationPriority(BSTR pAppFilename, int lMediaType, short fPriority);
    HRESULT put_EventFilter(int lFilterMask);
    HRESULT get_EventFilter(int* plFilterMask);
}

@GUID("54FBDC8C-D90F-4DAD-9695-B373097F094B")
interface ITTAPI2 : ITTAPI
{
    HRESULT get_Phones(VARIANT* pPhones);
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    HRESULT CreateEmptyCollectionObject(ITCollection2* ppCollection);
}

@GUID("B1EFC384-9355-11D0-835C-00AA003CCABD")
interface ITMediaSupport : IDispatch
{
    HRESULT get_MediaTypes(int* plMediaTypes);
    HRESULT QueryMediaType(int lMediaType, short* pfSupport);
}

@GUID("41757F4A-CF09-4B34-BC96-0A79D2390076")
interface ITPluggableTerminalClassInfo : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_Company(BSTR* pCompany);
    HRESULT get_Version(BSTR* pVersion);
    HRESULT get_TerminalClass(BSTR* pTerminalClass);
    HRESULT get_CLSID(BSTR* pCLSID);
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
    HRESULT get_MediaTypes(int* pMediaTypes);
}

@GUID("6D54E42C-4625-4359-A6F7-631999107E05")
interface ITPluggableTerminalSuperclassInfo : IDispatch
{
    HRESULT get_Name(BSTR* pName);
    HRESULT get_CLSID(BSTR* pCLSID);
}

@GUID("B1EFC385-9355-11D0-835C-00AA003CCABD")
interface ITTerminalSupport : IDispatch
{
    HRESULT get_StaticTerminals(VARIANT* pVariant);
    HRESULT EnumerateStaticTerminals(IEnumTerminal* ppTerminalEnumerator);
    HRESULT get_DynamicTerminalClasses(VARIANT* pVariant);
    HRESULT EnumerateDynamicTerminalClasses(IEnumTerminalClass* ppTerminalClassEnumerator);
    HRESULT CreateTerminal(BSTR pTerminalClass, int lMediaType, TERMINAL_DIRECTION Direction, 
                           ITTerminal* ppTerminal);
    HRESULT GetDefaultStaticTerminal(int lMediaType, TERMINAL_DIRECTION Direction, ITTerminal* ppTerminal);
}

@GUID("F3EB39BC-1B1F-4E99-A0C0-56305C4DD591")
interface ITTerminalSupport2 : ITTerminalSupport
{
    HRESULT get_PluggableSuperclasses(VARIANT* pVariant);
    HRESULT EnumeratePluggableSuperclasses(IEnumPluggableSuperclassInfo* ppSuperclassEnumerator);
    HRESULT get_PluggableTerminalClasses(BSTR bstrTerminalSuperclass, int lMediaType, VARIANT* pVariant);
    HRESULT EnumeratePluggableTerminalClasses(GUID iidTerminalSuperclass, int lMediaType, 
                                              IEnumPluggableTerminalClassInfo* ppClassEnumerator);
}

@GUID("B1EFC386-9355-11D0-835C-00AA003CCABD")
interface ITAddress : IDispatch
{
    HRESULT get_State(ADDRESS_STATE* pAddressState);
    HRESULT get_AddressName(BSTR* ppName);
    HRESULT get_ServiceProviderName(BSTR* ppName);
    HRESULT get_TAPIObject(ITTAPI* ppTapiObject);
    HRESULT CreateCall(BSTR pDestAddress, int lAddressType, int lMediaTypes, ITBasicCallControl* ppCall);
    HRESULT get_Calls(VARIANT* pVariant);
    HRESULT EnumerateCalls(IEnumCall* ppCallEnum);
    HRESULT get_DialableAddress(BSTR* pDialableAddress);
    HRESULT CreateForwardInfoObject(ITForwardInformation* ppForwardInfo);
    HRESULT Forward(ITForwardInformation pForwardInfo, ITBasicCallControl pCall);
    HRESULT get_CurrentForwardInfo(ITForwardInformation* ppForwardInfo);
    HRESULT put_MessageWaiting(short fMessageWaiting);
    HRESULT get_MessageWaiting(short* pfMessageWaiting);
    HRESULT put_DoNotDisturb(short fDoNotDisturb);
    HRESULT get_DoNotDisturb(short* pfDoNotDisturb);
}

@GUID("B0AE5D9B-BE51-46C9-B0F7-DFA8A22A8BC4")
interface ITAddress2 : ITAddress
{
    HRESULT get_Phones(VARIANT* pPhones);
    HRESULT EnumeratePhones(IEnumPhone* ppEnumPhone);
    HRESULT GetPhoneFromTerminal(ITTerminal pTerminal, ITPhone* ppPhone);
    HRESULT get_PreferredPhones(VARIANT* pPhones);
    HRESULT EnumeratePreferredPhones(IEnumPhone* ppEnumPhone);
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short* pEnable);
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short bEnable);
    HRESULT DeviceSpecific(ITCallInfo pCall, ubyte* pParams, uint dwSize);
    HRESULT DeviceSpecificVariant(ITCallInfo pCall, VARIANT varDevSpecificByteArray);
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

@GUID("8DF232F5-821B-11D1-BB5C-00C04FB6809F")
interface ITAddressCapabilities : IDispatch
{
    HRESULT get_AddressCapability(ADDRESS_CAPABILITY AddressCap, int* plCapability);
    HRESULT get_AddressCapabilityString(ADDRESS_CAPABILITY_STRING AddressCapString, BSTR* ppCapabilityString);
    HRESULT get_CallTreatments(VARIANT* pVariant);
    HRESULT EnumerateCallTreatments(IEnumBstr* ppEnumCallTreatment);
    HRESULT get_CompletionMessages(VARIANT* pVariant);
    HRESULT EnumerateCompletionMessages(IEnumBstr* ppEnumCompletionMessage);
    HRESULT get_DeviceClasses(VARIANT* pVariant);
    HRESULT EnumerateDeviceClasses(IEnumBstr* ppEnumDeviceClass);
}

@GUID("09D48DB4-10CC-4388-9DE7-A8465618975A")
interface ITPhone : IDispatch
{
    HRESULT Open(PHONE_PRIVILEGE Privilege);
    HRESULT Close();
    HRESULT get_Addresses(VARIANT* pAddresses);
    HRESULT EnumerateAddresses(IEnumAddress* ppEnumAddress);
    HRESULT get_PhoneCapsLong(PHONECAPS_LONG pclCap, int* plCapability);
    HRESULT get_PhoneCapsString(PHONECAPS_STRING pcsCap, BSTR* ppCapability);
    HRESULT get_Terminals(ITAddress pAddress, VARIANT* pTerminals);
    HRESULT EnumerateTerminals(ITAddress pAddress, IEnumTerminal* ppEnumTerminal);
    HRESULT get_ButtonMode(int lButtonID, PHONE_BUTTON_MODE* pButtonMode);
    HRESULT put_ButtonMode(int lButtonID, PHONE_BUTTON_MODE ButtonMode);
    HRESULT get_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION* pButtonFunction);
    HRESULT put_ButtonFunction(int lButtonID, PHONE_BUTTON_FUNCTION ButtonFunction);
    HRESULT get_ButtonText(int lButtonID, BSTR* ppButtonText);
    HRESULT put_ButtonText(int lButtonID, BSTR bstrButtonText);
    HRESULT get_ButtonState(int lButtonID, PHONE_BUTTON_STATE* pButtonState);
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, 
                                PHONE_HOOK_SWITCH_STATE* pHookSwitchState);
    HRESULT put_HookSwitchState(PHONE_HOOK_SWITCH_DEVICE HookSwitchDevice, PHONE_HOOK_SWITCH_STATE HookSwitchState);
    HRESULT put_RingMode(int lRingMode);
    HRESULT get_RingMode(int* plRingMode);
    HRESULT put_RingVolume(int lRingVolume);
    HRESULT get_RingVolume(int* plRingVolume);
    HRESULT get_Privilege(PHONE_PRIVILEGE* pPrivilege);
    HRESULT GetPhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, uint* pdwSize, ubyte** ppPhoneCapsBuffer);
    HRESULT get_PhoneCapsBuffer(PHONECAPS_BUFFER pcbCaps, VARIANT* pVarBuffer);
    HRESULT get_LampMode(int lLampID, PHONE_LAMP_MODE* pLampMode);
    HRESULT put_LampMode(int lLampID, PHONE_LAMP_MODE LampMode);
    HRESULT get_Display(BSTR* pbstrDisplay);
    HRESULT SetDisplay(int lRow, int lColumn, BSTR bstrDisplay);
    HRESULT get_PreferredAddresses(VARIANT* pAddresses);
    HRESULT EnumeratePreferredAddresses(IEnumAddress* ppEnumAddress);
    HRESULT DeviceSpecific(ubyte* pParams, uint dwSize);
    HRESULT DeviceSpecificVariant(VARIANT varDevSpecificByteArray);
    HRESULT NegotiateExtVersion(int lLowVersion, int lHighVersion, int* plExtVersion);
}

@GUID("1EE1AF0E-6159-4A61-B79B-6A4BA3FC9DFC")
interface ITAutomatedPhoneControl : IDispatch
{
    HRESULT StartTone(PHONE_TONE Tone, int lDuration);
    HRESULT StopTone();
    HRESULT get_Tone(PHONE_TONE* pTone);
    HRESULT StartRinger(int lRingMode, int lDuration);
    HRESULT StopRinger();
    HRESULT get_Ringer(short* pfRinging);
    HRESULT put_PhoneHandlingEnabled(short fEnabled);
    HRESULT get_PhoneHandlingEnabled(short* pfEnabled);
    HRESULT put_AutoEndOfNumberTimeout(int lTimeout);
    HRESULT get_AutoEndOfNumberTimeout(int* plTimeout);
    HRESULT put_AutoDialtone(short fEnabled);
    HRESULT get_AutoDialtone(short* pfEnabled);
    HRESULT put_AutoStopTonesOnOnHook(short fEnabled);
    HRESULT get_AutoStopTonesOnOnHook(short* pfEnabled);
    HRESULT put_AutoStopRingOnOffHook(short fEnabled);
    HRESULT get_AutoStopRingOnOffHook(short* pfEnabled);
    HRESULT put_AutoKeypadTones(short fEnabled);
    HRESULT get_AutoKeypadTones(short* pfEnabled);
    HRESULT put_AutoKeypadTonesMinimumDuration(int lDuration);
    HRESULT get_AutoKeypadTonesMinimumDuration(int* plDuration);
    HRESULT put_AutoVolumeControl(short fEnabled);
    HRESULT get_AutoVolumeControl(short* fEnabled);
    HRESULT put_AutoVolumeControlStep(int lStepSize);
    HRESULT get_AutoVolumeControlStep(int* plStepSize);
    HRESULT put_AutoVolumeControlRepeatDelay(int lDelay);
    HRESULT get_AutoVolumeControlRepeatDelay(int* plDelay);
    HRESULT put_AutoVolumeControlRepeatPeriod(int lPeriod);
    HRESULT get_AutoVolumeControlRepeatPeriod(int* plPeriod);
    HRESULT SelectCall(ITCallInfo pCall, short fSelectDefaultTerminals);
    HRESULT UnselectCall(ITCallInfo pCall);
    HRESULT EnumerateSelectedCalls(IEnumCall* ppCallEnum);
    HRESULT get_SelectedCalls(VARIANT* pVariant);
}

@GUID("B1EFC389-9355-11D0-835C-00AA003CCABD")
interface ITBasicCallControl : IDispatch
{
    HRESULT Connect(short fSync);
    HRESULT Answer();
    HRESULT Disconnect(DISCONNECT_CODE code);
    HRESULT Hold(short fHold);
    HRESULT HandoffDirect(BSTR pApplicationName);
    HRESULT HandoffIndirect(int lMediaType);
    HRESULT Conference(ITBasicCallControl pCall, short fSync);
    HRESULT Transfer(ITBasicCallControl pCall, short fSync);
    HRESULT BlindTransfer(BSTR pDestAddress);
    HRESULT SwapHold(ITBasicCallControl pCall);
    HRESULT ParkDirect(BSTR pParkAddress);
    HRESULT ParkIndirect(BSTR* ppNonDirAddress);
    HRESULT Unpark();
    HRESULT SetQOS(int lMediaType, QOS_SERVICE_LEVEL ServiceLevel);
    HRESULT Pickup(BSTR pGroupID);
    HRESULT Dial(BSTR pDestAddress);
    HRESULT Finish(FINISH_MODE finishMode);
    HRESULT RemoveFromConference();
}

@GUID("350F85D1-1227-11D3-83D4-00C04FB6809F")
interface ITCallInfo : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_CallState(CALL_STATE* pCallState);
    HRESULT get_Privilege(CALL_PRIVILEGE* pPrivilege);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_CallInfoLong(CALLINFO_LONG CallInfoLong, int* plCallInfoLongVal);
    HRESULT put_CallInfoLong(CALLINFO_LONG CallInfoLong, int lCallInfoLongVal);
    HRESULT get_CallInfoString(CALLINFO_STRING CallInfoString, BSTR* ppCallInfoString);
    HRESULT put_CallInfoString(CALLINFO_STRING CallInfoString, BSTR pCallInfoString);
    HRESULT get_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT* ppCallInfoBuffer);
    HRESULT put_CallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, VARIANT pCallInfoBuffer);
    HRESULT GetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint* pdwSize, char* ppCallInfoBuffer);
    HRESULT SetCallInfoBuffer(CALLINFO_BUFFER CallInfoBuffer, uint dwSize, char* pCallInfoBuffer);
    HRESULT ReleaseUserUserInfo();
}

@GUID("94D70CA6-7AB0-4DAA-81CA-B8F8643FAEC1")
interface ITCallInfo2 : ITCallInfo
{
    HRESULT get_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short* pEnable);
    HRESULT put_EventFilter(TAPI_EVENT TapiEvent, int lSubEvent, short bEnable);
}

@GUID("B1EFC38A-9355-11D0-835C-00AA003CCABD")
interface ITTerminal : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT get_State(TERMINAL_STATE* pTerminalState);
    HRESULT get_TerminalType(TERMINAL_TYPE* pType);
    HRESULT get_TerminalClass(BSTR* ppTerminalClass);
    HRESULT get_MediaType(int* plMediaType);
    HRESULT get_Direction(TERMINAL_DIRECTION* pDirection);
}

@GUID("FE040091-ADE8-4072-95C9-BF7DE8C54B44")
interface ITMultiTrackTerminal : IDispatch
{
    HRESULT get_TrackTerminals(VARIANT* pVariant);
    HRESULT EnumerateTrackTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT CreateTrackTerminal(int MediaType, TERMINAL_DIRECTION TerminalDirection, ITTerminal* ppTerminal);
    HRESULT get_MediaTypesInUse(int* plMediaTypesInUse);
    HRESULT get_DirectionsInUse(TERMINAL_DIRECTION* plDirectionsInUsed);
    HRESULT RemoveTrackTerminal(ITTerminal pTrackTerminalToRemove);
}

@GUID("31CA6EA9-C08A-4BEA-8811-8E9C1BA3EA3A")
interface ITFileTrack : IDispatch
{
    HRESULT get_Format(AM_MEDIA_TYPE** ppmt);
    HRESULT put_Format(const(AM_MEDIA_TYPE)* pmt);
    HRESULT get_ControllingTerminal(ITTerminal* ppControllingTerminal);
    HRESULT get_AudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
    HRESULT put_AudioFormatForScripting(ITScriptableAudioFormat pAudioFormat);
    HRESULT get_EmptyAudioFormatForScripting(ITScriptableAudioFormat* ppAudioFormat);
}

@GUID("627E8AE6-AE4C-4A69-BB63-2AD625404B77")
interface ITMediaPlayback : IDispatch
{
    HRESULT put_PlayList(VARIANT PlayListVariant);
    HRESULT get_PlayList(VARIANT* pPlayListVariant);
}

@GUID("F5DD4592-5476-4CC1-9D4D-FAD3EEFE7DB2")
interface ITMediaRecord : IDispatch
{
    HRESULT put_FileName(BSTR bstrFileName);
    HRESULT get_FileName(BSTR* pbstrFileName);
}

@GUID("C445DDE8-5199-4BC7-9807-5FFB92E42E09")
interface ITMediaControl : IDispatch
{
    HRESULT Start();
    HRESULT Stop();
    HRESULT Pause();
    HRESULT get_MediaState(TERMINAL_MEDIA_STATE* pTerminalMediaState);
}

@GUID("B1EFC38D-9355-11D0-835C-00AA003CCABD")
interface ITBasicAudioTerminal : IDispatch
{
    HRESULT put_Volume(int lVolume);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Balance(int lBalance);
    HRESULT get_Balance(int* plBalance);
}

@GUID("A86B7871-D14C-48E6-922E-A8D15F984800")
interface ITStaticAudioTerminal : IDispatch
{
    HRESULT get_WaveId(int* plWaveId);
}

@GUID("A3C1544E-5B92-11D1-8F4E-00C04FB6809F")
interface ITCallHub : IDispatch
{
    HRESULT Clear();
    HRESULT EnumerateCalls(IEnumCall* ppEnumCall);
    HRESULT get_Calls(VARIANT* pCalls);
    HRESULT get_NumCalls(int* plCalls);
    HRESULT get_State(CALLHUB_STATE* pState);
}

@GUID("AB493640-4C0B-11D2-A046-00C04FB6809F")
interface ITLegacyAddressMediaControl : IUnknown
{
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceID);
    HRESULT GetDevConfig(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceConfig);
    HRESULT SetDevConfig(BSTR pDeviceClass, uint dwSize, char* pDeviceConfig);
}

@GUID("0E269CD0-10D4-4121-9C22-9C85D625650D")
interface ITPrivateEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_EventCode(int* plEventCode);
    HRESULT get_EventInterface(IDispatch* pEventInterface);
}

@GUID("B0EE512B-A531-409E-9DD9-4099FE86C738")
interface ITLegacyAddressMediaControl2 : ITLegacyAddressMediaControl
{
    HRESULT ConfigDialog(HWND hwndOwner, BSTR pDeviceClass);
    HRESULT ConfigDialogEdit(HWND hwndOwner, BSTR pDeviceClass, uint dwSizeIn, char* pDeviceConfigIn, 
                             uint* pdwSizeOut, char* ppDeviceConfigOut);
}

@GUID("D624582F-CC23-4436-B8A5-47C625C8045D")
interface ITLegacyCallMediaControl : IDispatch
{
    HRESULT DetectDigits(int DigitMode);
    HRESULT GenerateDigits(BSTR pDigits, int DigitMode);
    HRESULT GetID(BSTR pDeviceClass, uint* pdwSize, char* ppDeviceID);
    HRESULT SetMediaType(int lMediaType);
    HRESULT MonitorMedia(int lMediaType);
}

@GUID("57CA332D-7BC2-44F1-A60C-936FE8D7CE73")
interface ITLegacyCallMediaControl2 : ITLegacyCallMediaControl
{
    HRESULT GenerateDigits2(BSTR pDigits, int DigitMode, int lDuration);
    HRESULT GatherDigits(int DigitMode, int lNumDigits, BSTR pTerminationDigits, int lFirstDigitTimeout, 
                         int lInterDigitTimeout);
    HRESULT DetectTones(TAPI_DETECTTONE* pToneList, int lNumTones);
    HRESULT DetectTonesByCollection(ITCollection2 pDetectToneCollection);
    HRESULT GenerateTone(TAPI_TONEMODE ToneMode, int lDuration);
    HRESULT GenerateCustomTones(TAPI_CUSTOMTONE* pToneList, int lNumTones, int lDuration);
    HRESULT GenerateCustomTonesByCollection(ITCollection2 pCustomToneCollection, int lDuration);
    HRESULT CreateDetectToneObject(ITDetectTone* ppDetectTone);
    HRESULT CreateCustomToneObject(ITCustomTone* ppCustomTone);
    HRESULT GetIDAsVariant(BSTR bstrDeviceClass, VARIANT* pVarDeviceID);
}

@GUID("961F79BD-3097-49DF-A1D6-909B77E89CA0")
interface ITDetectTone : IDispatch
{
    HRESULT get_AppSpecific(int* plAppSpecific);
    HRESULT put_AppSpecific(int lAppSpecific);
    HRESULT get_Duration(int* plDuration);
    HRESULT put_Duration(int lDuration);
    HRESULT get_Frequency(int Index, int* plFrequency);
    HRESULT put_Frequency(int Index, int lFrequency);
}

@GUID("357AD764-B3C6-4B2A-8FA5-0722827A9254")
interface ITCustomTone : IDispatch
{
    HRESULT get_Frequency(int* plFrequency);
    HRESULT put_Frequency(int lFrequency);
    HRESULT get_CadenceOn(int* plCadenceOn);
    HRESULT put_CadenceOn(int CadenceOn);
    HRESULT get_CadenceOff(int* plCadenceOff);
    HRESULT put_CadenceOff(int lCadenceOff);
    HRESULT get_Volume(int* plVolume);
    HRESULT put_Volume(int lVolume);
}

@GUID("F15B7669-4780-4595-8C89-FB369C8CF7AA")
interface IEnumPhone : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPhone* ppEnum);
}

@GUID("AE269CF4-935E-11D0-835C-00AA003CCABD")
interface IEnumTerminal : IUnknown
{
    HRESULT Next(uint celt, ITTerminal* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumTerminal* ppEnum);
}

@GUID("AE269CF5-935E-11D0-835C-00AA003CCABD")
interface IEnumTerminalClass : IUnknown
{
    HRESULT Next(uint celt, char* pElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumTerminalClass* ppEnum);
}

@GUID("AE269CF6-935E-11D0-835C-00AA003CCABD")
interface IEnumCall : IUnknown
{
    HRESULT Next(uint celt, ITCallInfo* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCall* ppEnum);
}

@GUID("1666FCA1-9363-11D0-835C-00AA003CCABD")
interface IEnumAddress : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAddress* ppEnum);
}

@GUID("A3C15450-5B92-11D1-8F4E-00C04FB6809F")
interface IEnumCallHub : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCallHub* ppEnum);
}

@GUID("35372049-0BC6-11D2-A033-00C04FB6809F")
interface IEnumBstr : IUnknown
{
    HRESULT Next(uint celt, char* ppStrings, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumBstr* ppEnum);
}

@GUID("4567450C-DBEE-4E3F-AAF5-37BF9EBF5E29")
interface IEnumPluggableTerminalClassInfo : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPluggableTerminalClassInfo* ppEnum);
}

@GUID("E9586A80-89E6-4CFF-931D-478D5751F4C0")
interface IEnumPluggableSuperclassInfo : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumPluggableSuperclassInfo* ppEnum);
}

@GUID("8F942DD8-64ED-4AAF-A77D-B23DB0837EAD")
interface ITPhoneEvent : IDispatch
{
    HRESULT get_Phone(ITPhone* ppPhone);
    HRESULT get_Event(PHONE_EVENT* pEvent);
    HRESULT get_ButtonState(PHONE_BUTTON_STATE* pState);
    HRESULT get_HookSwitchState(PHONE_HOOK_SWITCH_STATE* pState);
    HRESULT get_HookSwitchDevice(PHONE_HOOK_SWITCH_DEVICE* pDevice);
    HRESULT get_RingMode(int* plRingMode);
    HRESULT get_ButtonLampId(int* plButtonLampId);
    HRESULT get_NumberGathered(BSTR* ppNumber);
    HRESULT get_Call(ITCallInfo* ppCallInfo);
}

@GUID("62F47097-95C9-11D0-835D-00AA003CCABD")
interface ITCallStateEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_State(CALL_STATE* pCallState);
    HRESULT get_Cause(CALL_STATE_EVENT_CAUSE* pCEC);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("63FFB2A6-872B-4CD3-A501-326E8FB40AF7")
interface ITPhoneDeviceSpecificEvent : IDispatch
{
    HRESULT get_Phone(ITPhone* ppPhone);
    HRESULT get_lParam1(int* pParam1);
    HRESULT get_lParam2(int* pParam2);
    HRESULT get_lParam3(int* pParam3);
}

@GUID("FF36B87F-EC3A-11D0-8EE4-00C04FB6809F")
interface ITCallMediaEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Event(CALL_MEDIA_EVENT* pCallMediaEvent);
    HRESULT get_Error(int* phrError);
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Stream(ITStream* ppStream);
    HRESULT get_Cause(CALL_MEDIA_EVENT_CAUSE* pCause);
}

@GUID("80D3BFAC-57D9-11D2-A04A-00C04FB6809F")
interface ITDigitDetectionEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Digit(ubyte* pucDigit);
    HRESULT get_DigitMode(int* pDigitMode);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("80D3BFAD-57D9-11D2-A04A-00C04FB6809F")
interface ITDigitGenerationEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_GenerationTermination(int* plGenerationTermination);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("E52EC4C1-CBA3-441A-9E6A-93CB909E9724")
interface ITDigitsGatheredEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_Digits(BSTR* ppDigits);
    HRESULT get_GatherTermination(TAPI_GATHERTERM* pGatherTermination);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("407E0FAF-D047-4753-B0C6-8E060373FECD")
interface ITToneDetectionEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCallInfo);
    HRESULT get_AppSpecific(int* plAppSpecific);
    HRESULT get_TickCount(int* plTickCount);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("F4854D48-937A-11D1-BB58-00C04FB6809F")
interface ITTAPIObjectEvent : IDispatch
{
    HRESULT get_TAPIObject(ITTAPI* ppTAPIObject);
    HRESULT get_Event(TAPIOBJECT_EVENT* pEvent);
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("359DDA6E-68CE-4383-BF0B-169133C41B46")
interface ITTAPIObjectEvent2 : ITTAPIObjectEvent
{
    HRESULT get_Phone(ITPhone* ppPhone);
}

@GUID("EDDB9426-3B91-11D1-8F30-00C04FB6809F")
interface ITTAPIEventNotification : IUnknown
{
    HRESULT Event(TAPI_EVENT TapiEvent, IDispatch pEvent);
}

@GUID("A3C15451-5B92-11D1-8F4E-00C04FB6809F")
interface ITCallHubEvent : IDispatch
{
    HRESULT get_Event(CALLHUB_EVENT* pEvent);
    HRESULT get_CallHub(ITCallHub* ppCallHub);
    HRESULT get_Call(ITCallInfo* ppCall);
}

@GUID("831CE2D1-83B5-11D1-BB5C-00C04FB6809F")
interface ITAddressEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Event(ADDRESS_EVENT* pEvent);
    HRESULT get_Terminal(ITTerminal* ppTerminal);
}

@GUID("3ACB216B-40BD-487A-8672-5CE77BD7E3A3")
interface ITAddressDeviceSpecificEvent : IDispatch
{
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_lParam1(int* pParam1);
    HRESULT get_lParam2(int* pParam2);
    HRESULT get_lParam3(int* pParam3);
}

@GUID("E4A7FBAC-8C17-4427-9F55-9F589AC8AF00")
interface ITFileTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Track(ITFileTrack* ppTrackTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_State(TERMINAL_MEDIA_STATE* pState);
    HRESULT get_Cause(FT_STATE_EVENT_CAUSE* pCause);
    HRESULT get_Error(int* phrErrorCode);
}

@GUID("D964788F-95A5-461D-AB0C-B9900A6C2713")
interface ITTTSTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

@GUID("EE016A02-4FA9-467C-933F-5A15B12377D7")
interface ITASRTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

@GUID("E6F56009-611F-4945-BBD2-2D0CE5612056")
interface ITToneTerminalEvent : IDispatch
{
    HRESULT get_Terminal(ITTerminal* ppTerminal);
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Error(int* phrErrorCode);
}

@GUID("CFA3357C-AD77-11D1-BB68-00C04FB6809F")
interface ITQOSEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Event(QOS_EVENT* pQosEvent);
    HRESULT get_MediaType(int* plMediaType);
}

@GUID("5D4B65F9-E51C-11D1-A02F-00C04FB6809F")
interface ITCallInfoChangeEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Cause(CALLINFOCHANGE_CAUSE* pCIC);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("AC48FFDF-F8C4-11D1-A030-00C04FB6809F")
interface ITRequest : IDispatch
{
    HRESULT MakeCall(BSTR pDestAddress, BSTR pAppName, BSTR pCalledParty, BSTR pComment);
}

@GUID("AC48FFDE-F8C4-11D1-A030-00C04FB6809F")
interface ITRequestEvent : IDispatch
{
    HRESULT get_RegistrationInstance(int* plRegistrationInstance);
    HRESULT get_RequestMode(int* plRequestMode);
    HRESULT get_DestAddress(BSTR* ppDestAddress);
    HRESULT get_AppName(BSTR* ppAppName);
    HRESULT get_CalledParty(BSTR* ppCalledParty);
    HRESULT get_Comment(BSTR* ppComment);
}

@GUID("5EC5ACF2-9C02-11D0-8362-00AA003CCABD")
interface ITCollection : IDispatch
{
    HRESULT get_Count(int* lCount);
    HRESULT get_Item(int Index, VARIANT* pVariant);
    HRESULT get__NewEnum(IUnknown* ppNewEnum);
}

@GUID("E6DDDDA5-A6D3-48FF-8737-D32FC4D95477")
interface ITCollection2 : ITCollection
{
    HRESULT Add(int Index, VARIANT* pVariant);
    HRESULT Remove(int Index);
}

@GUID("449F659E-88A3-11D1-BB5D-00C04FB6809F")
interface ITForwardInformation : IDispatch
{
    HRESULT put_NumRingsNoAnswer(int lNumRings);
    HRESULT get_NumRingsNoAnswer(int* plNumRings);
    HRESULT SetForwardType(int ForwardType, BSTR pDestAddress, BSTR pCallerAddress);
    HRESULT get_ForwardTypeDestination(int ForwardType, BSTR* ppDestAddress);
    HRESULT get_ForwardTypeCaller(int Forwardtype, BSTR* ppCallerAddress);
    HRESULT GetForwardType(int ForwardType, BSTR* ppDestinationAddress, BSTR* ppCallerAddress);
    HRESULT Clear();
}

@GUID("5229B4ED-B260-4382-8E1A-5DF3A8A4CCC0")
interface ITForwardInformation2 : ITForwardInformation
{
    HRESULT SetForwardType2(int ForwardType, BSTR pDestAddress, int DestAddressType, BSTR pCallerAddress, 
                            int CallerAddressType);
    HRESULT GetForwardType2(int ForwardType, BSTR* ppDestinationAddress, int* pDestAddressType, 
                            BSTR* ppCallerAddress, int* pCallerAddressType);
    HRESULT get_ForwardTypeDestinationAddressType(int ForwardType, int* pDestAddressType);
    HRESULT get_ForwardTypeCallerAddressType(int Forwardtype, int* pCallerAddressType);
}

@GUID("0C4D8F03-8DDB-11D1-A09E-00805FC147D3")
interface ITAddressTranslation : IDispatch
{
    HRESULT TranslateAddress(BSTR pAddressToTranslate, int lCard, int lTranslateOptions, 
                             ITAddressTranslationInfo* ppTranslated);
    HRESULT TranslateDialog(int hwndOwner, BSTR pAddressIn);
    HRESULT EnumerateLocations(IEnumLocation* ppEnumLocation);
    HRESULT get_Locations(VARIANT* pVariant);
    HRESULT EnumerateCallingCards(IEnumCallingCard* ppEnumCallingCard);
    HRESULT get_CallingCards(VARIANT* pVariant);
}

@GUID("AFC15945-8D40-11D1-A09E-00805FC147D3")
interface ITAddressTranslationInfo : IDispatch
{
    HRESULT get_DialableString(BSTR* ppDialableString);
    HRESULT get_DisplayableString(BSTR* ppDisplayableString);
    HRESULT get_CurrentCountryCode(int* CountryCode);
    HRESULT get_DestinationCountryCode(int* CountryCode);
    HRESULT get_TranslationResults(int* plResults);
}

@GUID("0C4D8EFF-8DDB-11D1-A09E-00805FC147D3")
interface ITLocationInfo : IDispatch
{
    HRESULT get_PermanentLocationID(int* plLocationID);
    HRESULT get_CountryCode(int* plCountryCode);
    HRESULT get_CountryID(int* plCountryID);
    HRESULT get_Options(int* plOptions);
    HRESULT get_PreferredCardID(int* plCardID);
    HRESULT get_LocationName(BSTR* ppLocationName);
    HRESULT get_CityCode(BSTR* ppCode);
    HRESULT get_LocalAccessCode(BSTR* ppCode);
    HRESULT get_LongDistanceAccessCode(BSTR* ppCode);
    HRESULT get_TollPrefixList(BSTR* ppTollList);
    HRESULT get_CancelCallWaitingCode(BSTR* ppCode);
}

@GUID("0C4D8F01-8DDB-11D1-A09E-00805FC147D3")
interface IEnumLocation : IUnknown
{
    HRESULT Next(uint celt, ITLocationInfo* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumLocation* ppEnum);
}

@GUID("0C4D8F00-8DDB-11D1-A09E-00805FC147D3")
interface ITCallingCard : IDispatch
{
    HRESULT get_PermanentCardID(int* plCardID);
    HRESULT get_NumberOfDigits(int* plDigits);
    HRESULT get_Options(int* plOptions);
    HRESULT get_CardName(BSTR* ppCardName);
    HRESULT get_SameAreaDialingRule(BSTR* ppRule);
    HRESULT get_LongDistanceDialingRule(BSTR* ppRule);
    HRESULT get_InternationalDialingRule(BSTR* ppRule);
}

@GUID("0C4D8F02-8DDB-11D1-A09E-00805FC147D3")
interface IEnumCallingCard : IUnknown
{
    HRESULT Next(uint celt, ITCallingCard* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumCallingCard* ppEnum);
}

@GUID("895801DF-3DD6-11D1-8F30-00C04FB6809F")
interface ITCallNotificationEvent : IDispatch
{
    HRESULT get_Call(ITCallInfo* ppCall);
    HRESULT get_Event(CALL_NOTIFICATION_EVENT* pCallNotificationEvent);
    HRESULT get_CallbackInstance(int* plCallbackInstance);
}

@GUID("E9225295-C759-11D1-A02B-00C04FB6809F")
interface ITDispatchMapper : IDispatch
{
    HRESULT QueryDispatchInterface(BSTR pIID, IDispatch pInterfaceToMap, IDispatch* ppReturnedInterface);
}

@GUID("EE3BD604-3868-11D2-A045-00C04FB6809F")
interface ITStreamControl : IDispatch
{
    HRESULT CreateStream(int lMediaType, TERMINAL_DIRECTION td, ITStream* ppStream);
    HRESULT RemoveStream(ITStream pStream);
    HRESULT EnumerateStreams(IEnumStream* ppEnumStream);
    HRESULT get_Streams(VARIANT* pVariant);
}

@GUID("EE3BD605-3868-11D2-A045-00C04FB6809F")
interface ITStream : IDispatch
{
    HRESULT get_MediaType(int* plMediaType);
    HRESULT get_Direction(TERMINAL_DIRECTION* pTD);
    HRESULT get_Name(BSTR* ppName);
    HRESULT StartStream();
    HRESULT PauseStream();
    HRESULT StopStream();
    HRESULT SelectTerminal(ITTerminal pTerminal);
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT get_Terminals(VARIANT* pTerminals);
}

@GUID("EE3BD606-3868-11D2-A045-00C04FB6809F")
interface IEnumStream : IUnknown
{
    HRESULT Next(uint celt, ITStream* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumStream* ppEnum);
}

@GUID("EE3BD607-3868-11D2-A045-00C04FB6809F")
interface ITSubStreamControl : IDispatch
{
    HRESULT CreateSubStream(ITSubStream* ppSubStream);
    HRESULT RemoveSubStream(ITSubStream pSubStream);
    HRESULT EnumerateSubStreams(IEnumSubStream* ppEnumSubStream);
    HRESULT get_SubStreams(VARIANT* pVariant);
}

@GUID("EE3BD608-3868-11D2-A045-00C04FB6809F")
interface ITSubStream : IDispatch
{
    HRESULT StartSubStream();
    HRESULT PauseSubStream();
    HRESULT StopSubStream();
    HRESULT SelectTerminal(ITTerminal pTerminal);
    HRESULT UnselectTerminal(ITTerminal pTerminal);
    HRESULT EnumerateTerminals(IEnumTerminal* ppEnumTerminal);
    HRESULT get_Terminals(VARIANT* pTerminals);
    HRESULT get_Stream(ITStream* ppITStream);
}

@GUID("EE3BD609-3868-11D2-A045-00C04FB6809F")
interface IEnumSubStream : IUnknown
{
    HRESULT Next(uint celt, ITSubStream* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumSubStream* ppEnum);
}

@GUID("207823EA-E252-11D2-B77E-0080C7135381")
interface ITLegacyWaveSupport : IDispatch
{
    HRESULT IsFullDuplex(FULLDUPLEX_SUPPORT* pSupport);
}

@GUID("161A4A56-1E99-4B3F-A46A-168F38A5EE4C")
interface ITBasicCallControl2 : ITBasicCallControl
{
    HRESULT RequestTerminal(BSTR bstrTerminalClassGUID, int lMediaType, TERMINAL_DIRECTION Direction, 
                            ITTerminal* ppTerminal);
    HRESULT SelectTerminalOnCall(ITTerminal pTerminal);
    HRESULT UnselectTerminalOnCall(ITTerminal pTerminal);
}

@GUID("B87658BD-3C59-4F64-BE74-AEDE3E86A81E")
interface ITScriptableAudioFormat : IDispatch
{
    HRESULT get_Channels(int* pVal);
    HRESULT put_Channels(const(int) nNewVal);
    HRESULT get_SamplesPerSec(int* pVal);
    HRESULT put_SamplesPerSec(const(int) nNewVal);
    HRESULT get_AvgBytesPerSec(int* pVal);
    HRESULT put_AvgBytesPerSec(const(int) nNewVal);
    HRESULT get_BlockAlign(int* pVal);
    HRESULT put_BlockAlign(const(int) nNewVal);
    HRESULT get_BitsPerSample(int* pVal);
    HRESULT put_BitsPerSample(const(int) nNewVal);
    HRESULT get_FormatTag(int* pVal);
    HRESULT put_FormatTag(const(int) nNewVal);
}

@GUID("5770ECE5-4B27-11D1-BF80-00805FC147D3")
interface ITAgent : IDispatch
{
    HRESULT EnumerateAgentSessions(IEnumAgentSession* ppEnumAgentSession);
    HRESULT CreateSession(ITACDGroup pACDGroup, ITAddress pAddress, ITAgentSession* ppAgentSession);
    HRESULT CreateSessionWithPIN(ITACDGroup pACDGroup, ITAddress pAddress, BSTR pPIN, 
                                 ITAgentSession* ppAgentSession);
    HRESULT get_ID(BSTR* ppID);
    HRESULT get_User(BSTR* ppUser);
    HRESULT put_State(AGENT_STATE AgentState);
    HRESULT get_State(AGENT_STATE* pAgentState);
    HRESULT put_MeasurementPeriod(int lPeriod);
    HRESULT get_MeasurementPeriod(int* plPeriod);
    HRESULT get_OverallCallRate(CY* pcyCallrate);
    HRESULT get_NumberOfACDCalls(int* plCalls);
    HRESULT get_NumberOfIncomingCalls(int* plCalls);
    HRESULT get_NumberOfOutgoingCalls(int* plCalls);
    HRESULT get_TotalACDTalkTime(int* plTalkTime);
    HRESULT get_TotalACDCallTime(int* plCallTime);
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    HRESULT get_AgentSessions(VARIANT* pVariant);
}

@GUID("5AFC3147-4BCC-11D1-BF80-00805FC147D3")
interface ITAgentSession : IDispatch
{
    HRESULT get_Agent(ITAgent* ppAgent);
    HRESULT get_Address(ITAddress* ppAddress);
    HRESULT get_ACDGroup(ITACDGroup* ppACDGroup);
    HRESULT put_State(AGENT_SESSION_STATE SessionState);
    HRESULT get_State(AGENT_SESSION_STATE* pSessionState);
    HRESULT get_SessionStartTime(double* pdateSessionStart);
    HRESULT get_SessionDuration(int* plDuration);
    HRESULT get_NumberOfCalls(int* plCalls);
    HRESULT get_TotalTalkTime(int* plTalkTime);
    HRESULT get_AverageTalkTime(int* plTalkTime);
    HRESULT get_TotalCallTime(int* plCallTime);
    HRESULT get_AverageCallTime(int* plCallTime);
    HRESULT get_TotalWrapUpTime(int* plWrapUpTime);
    HRESULT get_AverageWrapUpTime(int* plWrapUpTime);
    HRESULT get_ACDCallRate(CY* pcyCallrate);
    HRESULT get_LongestTimeToAnswer(int* plAnswerTime);
    HRESULT get_AverageTimeToAnswer(int* plAnswerTime);
}

@GUID("5AFC3148-4BCC-11D1-BF80-00805FC147D3")
interface ITACDGroup : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT EnumerateQueues(IEnumQueue* ppEnumQueue);
    HRESULT get_Queues(VARIANT* pVariant);
}

@GUID("5AFC3149-4BCC-11D1-BF80-00805FC147D3")
interface ITQueue : IDispatch
{
    HRESULT put_MeasurementPeriod(int lPeriod);
    HRESULT get_MeasurementPeriod(int* plPeriod);
    HRESULT get_TotalCallsQueued(int* plCalls);
    HRESULT get_CurrentCallsQueued(int* plCalls);
    HRESULT get_TotalCallsAbandoned(int* plCalls);
    HRESULT get_TotalCallsFlowedIn(int* plCalls);
    HRESULT get_TotalCallsFlowedOut(int* plCalls);
    HRESULT get_LongestEverWaitTime(int* plWaitTime);
    HRESULT get_CurrentLongestWaitTime(int* plWaitTime);
    HRESULT get_AverageWaitTime(int* plWaitTime);
    HRESULT get_FinalDisposition(int* plCalls);
    HRESULT get_Name(BSTR* ppName);
}

@GUID("5AFC314A-4BCC-11D1-BF80-00805FC147D3")
interface ITAgentEvent : IDispatch
{
    HRESULT get_Agent(ITAgent* ppAgent);
    HRESULT get_Event(AGENT_EVENT* pEvent);
}

@GUID("5AFC314B-4BCC-11D1-BF80-00805FC147D3")
interface ITAgentSessionEvent : IDispatch
{
    HRESULT get_Session(ITAgentSession* ppSession);
    HRESULT get_Event(AGENT_SESSION_EVENT* pEvent);
}

@GUID("297F3032-BD11-11D1-A0A7-00805FC147D3")
interface ITACDGroupEvent : IDispatch
{
    HRESULT get_Group(ITACDGroup* ppGroup);
    HRESULT get_Event(ACDGROUP_EVENT* pEvent);
}

@GUID("297F3033-BD11-11D1-A0A7-00805FC147D3")
interface ITQueueEvent : IDispatch
{
    HRESULT get_Queue(ITQueue* ppQueue);
    HRESULT get_Event(ACDQUEUE_EVENT* pEvent);
}

@GUID("297F3034-BD11-11D1-A0A7-00805FC147D3")
interface ITAgentHandlerEvent : IDispatch
{
    HRESULT get_AgentHandler(ITAgentHandler* ppAgentHandler);
    HRESULT get_Event(AGENTHANDLER_EVENT* pEvent);
}

@GUID("5AFC3154-4BCC-11D1-BF80-00805FC147D3")
interface ITTAPICallCenter : IDispatch
{
    HRESULT EnumerateAgentHandlers(IEnumAgentHandler* ppEnumHandler);
    HRESULT get_AgentHandlers(VARIANT* pVariant);
}

@GUID("587E8C22-9802-11D1-A0A4-00805FC147D3")
interface ITAgentHandler : IDispatch
{
    HRESULT get_Name(BSTR* ppName);
    HRESULT CreateAgent(ITAgent* ppAgent);
    HRESULT CreateAgentWithID(BSTR pID, BSTR pPIN, ITAgent* ppAgent);
    HRESULT EnumerateACDGroups(IEnumACDGroup* ppEnumACDGroup);
    HRESULT EnumerateUsableAddresses(IEnumAddress* ppEnumAddress);
    HRESULT get_ACDGroups(VARIANT* pVariant);
    HRESULT get_UsableAddresses(VARIANT* pVariant);
}

@GUID("5AFC314D-4BCC-11D1-BF80-00805FC147D3")
interface IEnumAgent : IUnknown
{
    HRESULT Next(uint celt, ITAgent* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgent* ppEnum);
}

@GUID("5AFC314E-4BCC-11D1-BF80-00805FC147D3")
interface IEnumAgentSession : IUnknown
{
    HRESULT Next(uint celt, ITAgentSession* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgentSession* ppEnum);
}

@GUID("5AFC3158-4BCC-11D1-BF80-00805FC147D3")
interface IEnumQueue : IUnknown
{
    HRESULT Next(uint celt, ITQueue* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumQueue* ppEnum);
}

@GUID("5AFC3157-4BCC-11D1-BF80-00805FC147D3")
interface IEnumACDGroup : IUnknown
{
    HRESULT Next(uint celt, ITACDGroup* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumACDGroup* ppEnum);
}

@GUID("587E8C28-9802-11D1-A0A4-00805FC147D3")
interface IEnumAgentHandler : IUnknown
{
    HRESULT Next(uint celt, ITAgentHandler* ppElements, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumAgentHandler* ppEnum);
}

@GUID("0364EB00-4A77-11D1-A671-006097C9A2E8")
interface ITAMMediaFormat : IUnknown
{
    HRESULT get_MediaFormat(AM_MEDIA_TYPE** ppmt);
    HRESULT put_MediaFormat(const(AM_MEDIA_TYPE)* pmt);
}

@GUID("C1BC3C90-BCFE-11D1-9745-00C04FD91AC0")
interface ITAllocatorProperties : IUnknown
{
    HRESULT SetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    HRESULT GetAllocatorProperties(ALLOCATOR_PROPERTIES* pAllocProperties);
    HRESULT SetAllocateBuffers(BOOL bAllocBuffers);
    HRESULT GetAllocateBuffers(int* pbAllocBuffers);
    HRESULT SetBufferSize(uint BufferSize);
    HRESULT GetBufferSize(uint* pBufferSize);
}

@GUID("6E0887BE-BA1A-492E-BD10-4020EC5E33E0")
interface ITPluggableTerminalEventSink : IUnknown
{
    HRESULT FireEvent(const(MSP_EVENT_INFO)* pMspEventInfo);
}

@GUID("F7115709-A216-4957-A759-060AB32A90D1")
interface ITPluggableTerminalEventSinkRegistration : IUnknown
{
    HRESULT RegisterSink(ITPluggableTerminalEventSink pEventSink);
    HRESULT UnregisterSink();
}

@GUID("EE3BD600-3868-11D2-A045-00C04FB6809F")
interface ITMSPAddress : IUnknown
{
    HRESULT Initialize(int* hEvent);
    HRESULT Shutdown();
    HRESULT CreateMSPCall(int* hCall, uint dwReserved, uint dwMediaType, IUnknown pOuterUnknown, 
                          IUnknown* ppStreamControl);
    HRESULT ShutdownMSPCall(IUnknown pStreamControl);
    HRESULT ReceiveTSPData(IUnknown pMSPCall, char* pBuffer, uint dwSize);
    HRESULT GetEvent(uint* pdwSize, char* pEventBuffer);
}

@GUID("9F34325B-7E62-11D2-9457-00C04F8EC888")
interface ITTAPIDispatchEventNotification : IDispatch
{
}

@GUID("F1029E5D-CB5B-11D0-8D59-00C04FD91AC0")
interface ITDirectoryObjectConference : IDispatch
{
    HRESULT get_Protocol(BSTR* ppProtocol);
    HRESULT get_Originator(BSTR* ppOriginator);
    HRESULT put_Originator(BSTR pOriginator);
    HRESULT get_AdvertisingScope(RND_ADVERTISING_SCOPE* pAdvertisingScope);
    HRESULT put_AdvertisingScope(RND_ADVERTISING_SCOPE AdvertisingScope);
    HRESULT get_Url(BSTR* ppUrl);
    HRESULT put_Url(BSTR pUrl);
    HRESULT get_Description(BSTR* ppDescription);
    HRESULT put_Description(BSTR pDescription);
    HRESULT get_IsEncrypted(short* pfEncrypted);
    HRESULT put_IsEncrypted(short fEncrypted);
    HRESULT get_StartTime(double* pDate);
    HRESULT put_StartTime(double Date);
    HRESULT get_StopTime(double* pDate);
    HRESULT put_StopTime(double Date);
}

@GUID("34621D6F-6CFF-11D1-AFF7-00C04FC31FEE")
interface ITDirectoryObjectUser : IDispatch
{
    HRESULT get_IPPhonePrimary(BSTR* ppName);
    HRESULT put_IPPhonePrimary(BSTR pName);
}

@GUID("34621D70-6CFF-11D1-AFF7-00C04FC31FEE")
interface IEnumDialableAddrs : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDialableAddrs* ppEnum);
}

@GUID("34621D6E-6CFF-11D1-AFF7-00C04FC31FEE")
interface ITDirectoryObject : IDispatch
{
    HRESULT get_ObjectType(DIRECTORY_OBJECT_TYPE* pObjectType);
    HRESULT get_Name(BSTR* ppName);
    HRESULT put_Name(BSTR pName);
    HRESULT get_DialableAddrs(int dwAddressType, VARIANT* pVariant);
    HRESULT EnumerateDialableAddrs(uint dwAddressType, IEnumDialableAddrs* ppEnumDialableAddrs);
    HRESULT get_SecurityDescriptor(IDispatch* ppSecDes);
    HRESULT put_SecurityDescriptor(IDispatch pSecDes);
}

@GUID("06C9B64A-306D-11D1-9774-00C04FD91AC0")
interface IEnumDirectoryObject : IUnknown
{
    HRESULT Next(uint celt, char* pVal, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDirectoryObject* ppEnum);
}

@GUID("34621D72-6CFF-11D1-AFF7-00C04FC31FEE")
interface ITILSConfig : IDispatch
{
    HRESULT get_Port(int* pPort);
    HRESULT put_Port(int Port);
}

@GUID("34621D6C-6CFF-11D1-AFF7-00C04FC31FEE")
interface ITDirectory : IDispatch
{
    HRESULT get_DirectoryType(DIRECTORY_TYPE* pDirectoryType);
    HRESULT get_DisplayName(BSTR* pName);
    HRESULT get_IsDynamic(short* pfDynamic);
    HRESULT get_DefaultObjectTTL(int* pTTL);
    HRESULT put_DefaultObjectTTL(int TTL);
    HRESULT EnableAutoRefresh(short fEnable);
    HRESULT Connect(short fSecure);
    HRESULT Bind(BSTR pDomainName, BSTR pUserName, BSTR pPassword, int lFlags);
    HRESULT AddDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT ModifyDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT RefreshDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT DeleteDirectoryObject(ITDirectoryObject pDirectoryObject);
    HRESULT get_DirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, VARIANT* pVariant);
    HRESULT EnumerateDirectoryObjects(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                      IEnumDirectoryObject* ppEnumObject);
}

@GUID("34621D6D-6CFF-11D1-AFF7-00C04FC31FEE")
interface IEnumDirectory : IUnknown
{
    HRESULT Next(uint celt, char* ppElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumDirectory* ppEnum);
}

@GUID("34621D6B-6CFF-11D1-AFF7-00C04FC31FEE")
interface ITRendezvous : IDispatch
{
    HRESULT get_DefaultDirectories(VARIANT* pVariant);
    HRESULT EnumerateDefaultDirectories(IEnumDirectory* ppEnumDirectory);
    HRESULT CreateDirectoryA(DIRECTORY_TYPE DirectoryType, BSTR pName, ITDirectory* ppDir);
    HRESULT CreateDirectoryObject(DIRECTORY_OBJECT_TYPE DirectoryObjectType, BSTR pName, 
                                  ITDirectoryObject* ppDirectoryObject);
}

@GUID("DF0DAEF4-A289-11D1-8697-006008B0E5D2")
interface IMcastScope : IDispatch
{
    HRESULT get_ScopeID(int* pID);
    HRESULT get_ServerID(int* pID);
    HRESULT get_InterfaceID(int* pID);
    HRESULT get_ScopeDescription(BSTR* ppDescription);
    HRESULT get_TTL(int* pTTL);
}

@GUID("DF0DAEFD-A289-11D1-8697-006008B0E5D2")
interface IMcastLeaseInfo : IDispatch
{
    HRESULT get_RequestID(BSTR* ppRequestID);
    HRESULT get_LeaseStartTime(double* pTime);
    HRESULT put_LeaseStartTime(double time);
    HRESULT get_LeaseStopTime(double* pTime);
    HRESULT put_LeaseStopTime(double time);
    HRESULT get_AddressCount(int* pCount);
    HRESULT get_ServerAddress(BSTR* ppAddress);
    HRESULT get_TTL(int* pTTL);
    HRESULT get_Addresses(VARIANT* pVariant);
    HRESULT EnumerateAddresses(IEnumBstr* ppEnumAddresses);
}

@GUID("DF0DAF09-A289-11D1-8697-006008B0E5D2")
interface IEnumMcastScope : IUnknown
{
    HRESULT Next(uint celt, IMcastScope* ppScopes, uint* pceltFetched);
    HRESULT Reset();
    HRESULT Skip(uint celt);
    HRESULT Clone(IEnumMcastScope* ppEnum);
}

@GUID("DF0DAEF1-A289-11D1-8697-006008B0E5D2")
interface IMcastAddressAllocation : IDispatch
{
    HRESULT get_Scopes(VARIANT* pVariant);
    HRESULT EnumerateScopes(IEnumMcastScope* ppEnumMcastScope);
    HRESULT RequestAddress(IMcastScope pScope, double LeaseStartTime, double LeaseStopTime, int NumAddresses, 
                           IMcastLeaseInfo* ppLeaseResponse);
    HRESULT RenewAddress(int lReserved, IMcastLeaseInfo pRenewRequest, IMcastLeaseInfo* ppRenewResponse);
    HRESULT ReleaseAddress(IMcastLeaseInfo pReleaseRequest);
    HRESULT CreateLeaseInfo(double LeaseStartTime, double LeaseStopTime, uint dwNumAddresses, ushort** ppAddresses, 
                            const(wchar)* pRequestID, const(wchar)* pServerAddress, 
                            IMcastLeaseInfo* ppReleaseRequest);
    HRESULT CreateLeaseInfoFromVariant(double LeaseStartTime, double LeaseStopTime, VARIANT vAddresses, 
                                       BSTR pRequestID, BSTR pServerAddress, IMcastLeaseInfo* ppReleaseRequest);
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
