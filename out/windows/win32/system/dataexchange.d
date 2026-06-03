// Written in the D programming language.

module windows.win32.system.dataexchange;

public import windows.core;
public import windows.win32.foundation : BOOL, CHAR, HANDLE, HWND, LPARAM, PSTR,
                                         PWSTR, WPARAM;
public import windows.win32.graphics.gdi : HDC, HENHMETAFILE, HMETAFILE;
public import windows.win32.security : SECURITY_QUALITY_OF_SERVICE;

extern(Windows) @nogc nothrow:


// Enums


alias DDE_ENABLE_CALLBACK_CMD = uint;
enum : uint
{
    EC_ENABLEALL    = 0x00000000U,
    EC_ENABLEONE    = 0x00000080U,
    EC_DISABLE      = 0x00000008U,
    EC_QUERYWAITING = 0x00000002U,
}

alias DDE_INITIALIZE_COMMAND = uint;
enum : uint
{
    APPCLASS_MONITOR          = 0x00000001U,
    APPCLASS_STANDARD         = 0x00000000U,
    APPCMD_CLIENTONLY         = 0x00000010U,
    APPCMD_FILTERINITS        = 0x00000020U,
    CBF_FAIL_ALLSVRXACTIONS   = 0x0003f000U,
    CBF_FAIL_ADVISES          = 0x00004000U,
    CBF_FAIL_CONNECTIONS      = 0x00002000U,
    CBF_FAIL_EXECUTES         = 0x00008000U,
    CBF_FAIL_POKES            = 0x00010000U,
    CBF_FAIL_REQUESTS         = 0x00020000U,
    CBF_FAIL_SELFCONNECTIONS  = 0x00001000U,
    CBF_SKIP_ALLNOTIFICATIONS = 0x003c0000U,
    CBF_SKIP_CONNECT_CONFIRMS = 0x00040000U,
    CBF_SKIP_DISCONNECTS      = 0x00200000U,
    CBF_SKIP_REGISTRATIONS    = 0x00080000U,
    CBF_SKIP_UNREGISTRATIONS  = 0x00100000U,
    MF_CALLBACKS              = 0x08000000U,
    MF_CONV                   = 0x40000000U,
    MF_ERRORS                 = 0x10000000U,
    MF_HSZ_INFO               = 0x01000000U,
    MF_LINKS                  = 0x20000000U,
    MF_POSTMSGS               = 0x04000000U,
    MF_SENDMSGS               = 0x02000000U,
}

alias DDE_NAME_SERVICE_CMD = uint;
enum : uint
{
    DNS_REGISTER   = 0x00000001U,
    DNS_UNREGISTER = 0x00000002U,
    DNS_FILTERON   = 0x00000004U,
    DNS_FILTEROFF  = 0x00000008U,
}

alias DDE_CLIENT_TRANSACTION_TYPE = uint;
enum : uint
{
    XTYP_ADVSTART        = 0x00001030U,
    XTYP_ADVSTOP         = 0x00008040U,
    XTYP_EXECUTE         = 0x00004050U,
    XTYP_POKE            = 0x00004090U,
    XTYP_REQUEST         = 0x000020b0U,
    XTYP_ADVDATA         = 0x00004010U,
    XTYP_ADVREQ          = 0x00002022U,
    XTYP_CONNECT         = 0x00001062U,
    XTYP_CONNECT_CONFIRM = 0x00008072U,
    XTYP_DISCONNECT      = 0x000080c2U,
    XTYP_MONITOR         = 0x000080f2U,
    XTYP_REGISTER        = 0x000080a2U,
    XTYP_UNREGISTER      = 0x000080d2U,
    XTYP_WILDCONNECT     = 0x000020e2U,
    XTYP_XACT_COMPLETE   = 0x00008080U,
}

alias CONVINFO_CONVERSATION_STATE = uint;
enum : uint
{
    XST_ADVACKRCVD     = 0x0000000dU,
    XST_ADVDATAACKRCVD = 0x00000010U,
    XST_ADVDATASENT    = 0x0000000fU,
    XST_ADVSENT        = 0x0000000bU,
    XST_CONNECTED      = 0x00000002U,
    XST_DATARCVD       = 0x00000006U,
    XST_EXECACKRCVD    = 0x0000000aU,
    XST_EXECSENT       = 0x00000009U,
    XST_INCOMPLETE     = 0x00000001U,
    XST_INIT1          = 0x00000003U,
    XST_INIT2          = 0x00000004U,
    XST_NULL           = 0x00000000U,
    XST_POKEACKRCVD    = 0x00000008U,
    XST_POKESENT       = 0x00000007U,
    XST_REQSENT        = 0x00000005U,
    XST_UNADVACKRCVD   = 0x0000000eU,
    XST_UNADVSENT      = 0x0000000cU,
}

alias CONVINFO_STATUS = uint;
enum : uint
{
    ST_ADVISE     = 0x00000002U,
    ST_BLOCKED    = 0x00000008U,
    ST_BLOCKNEXT  = 0x00000080U,
    ST_CLIENT     = 0x00000010U,
    ST_CONNECTED  = 0x00000001U,
    ST_INLIST     = 0x00000040U,
    ST_ISLOCAL    = 0x00000004U,
    ST_ISSELF     = 0x00000100U,
    ST_TERMINATED = 0x00000020U,
}

// Constants


enum : uint
{
    WM_DDE_FIRST     = 0x000003e0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-initiate
    WM_DDE_INITIATE  = 0x000003e0U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-terminate
    WM_DDE_TERMINATE = 0x000003e1U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-advise
    WM_DDE_ADVISE    = 0x000003e2U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-unadvise
    WM_DDE_UNADVISE  = 0x000003e3U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-ack
    WM_DDE_ACK       = 0x000003e4U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-data
    WM_DDE_DATA      = 0x000003e5U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-request
    WM_DDE_REQUEST   = 0x000003e6U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-poke
    WM_DDE_POKE      = 0x000003e7U,
    // Microsoft documentation: https://learn.microsoft.com/windows/win32/dataxchg/wm-dde-execute
    WM_DDE_EXECUTE   = 0x000003e8U,
    WM_DDE_LAST      = 0x000003e8U,
}

enum uint CADV_LATEACK = 0x0000ffffU;

enum : uint
{
    DDE_FACK      = 0x00008000U,
    DDE_FBUSY     = 0x00004000U,
    DDE_FDEFERUPD = 0x00004000U,
}

enum : uint
{
    DDE_FACKREQ    = 0x00008000U,
    DDE_FRELEASE   = 0x00002000U,
    DDE_FREQUESTED = 0x00001000U,
}

enum uint DDE_FAPPSTATUS = 0x000000ffU;
enum uint DDE_FNOTPROCESSED = 0x00000000U;
enum uint MSGF_DDEMGR = 0x00008001U;

enum : int
{
    CP_WINANSI    = 0x000003ec,
    CP_WINUNICODE = 0x000004b0,
    CP_WINNEUTRAL = 0x000004b0,
}

enum : uint
{
    XTYPF_NOBLOCK = 0x00000002U,
    XTYPF_NODATA  = 0x00000004U,
    XTYPF_ACKREQ  = 0x00000008U,
}

enum : uint
{
    XCLASS_MASK         = 0x0000fc00U,
    XCLASS_BOOL         = 0x00001000U,
    XCLASS_DATA         = 0x00002000U,
    XCLASS_FLAGS        = 0x00004000U,
    XCLASS_NOTIFICATION = 0x00008000U,
}

enum : uint
{
    XTYP_MASK  = 0x000000f0U,
    XTYP_SHIFT = 0x00000004U,
}

enum uint TIMEOUT_ASYNC = 0xffffffffU;
enum uint QID_SYNC = 0xffffffffU;

enum : const(wchar)*
{
    SZDDESYS_TOPIC         = "System",
    SZDDESYS_ITEM_TOPICS   = "Topics",
    SZDDESYS_ITEM_SYSITEMS = "SysItems",
    SZDDESYS_ITEM_RTNMSG   = "ReturnMessage",
    SZDDESYS_ITEM_STATUS   = "Status",
    SZDDESYS_ITEM_FORMATS  = "Formats",
    SZDDESYS_ITEM_HELP     = "Help",
}

enum const(wchar)* SZDDE_ITEM_ITEMLIST = "TopicItemList";
enum int APPCMD_MASK = 0x00000ff0;
enum int APPCLASS_MASK = 0x0000000f;
enum uint HDATA_APPOWNED = 0x00000001U;

enum : uint
{
    DMLERR_NO_ERROR      = 0x00000000U,
    DMLERR_FIRST         = 0x00004000U,
    DMLERR_ADVACKTIMEOUT = 0x00004000U,
}

enum : uint
{
    DMLERR_BUSY           = 0x00004001U,
    DMLERR_DATAACKTIMEOUT = 0x00004002U,
}

enum : uint
{
    DMLERR_DLL_NOT_INITIALIZED = 0x00004003U,
    DMLERR_DLL_USAGE           = 0x00004004U,
    DMLERR_EXECACKTIMEOUT      = 0x00004005U,
}

enum uint DMLERR_INVALIDPARAMETER = 0x00004006U;

enum : uint
{
    DMLERR_LOW_MEMORY   = 0x00004007U,
    DMLERR_MEMORY_ERROR = 0x00004008U,
}

enum : uint
{
    DMLERR_NOTPROCESSED        = 0x00004009U,
    DMLERR_NO_CONV_ESTABLISHED = 0x0000400aU,
}

enum : uint
{
    DMLERR_POKEACKTIMEOUT = 0x0000400bU,
    DMLERR_POSTMSG_FAILED = 0x0000400cU,
}

enum : uint
{
    DMLERR_REENTRANCY       = 0x0000400dU,
    DMLERR_SERVER_DIED      = 0x0000400eU,
    DMLERR_SYS_ERROR        = 0x0000400fU,
    DMLERR_UNADVACKTIMEOUT  = 0x00004010U,
    DMLERR_UNFOUND_QUEUE_ID = 0x00004011U,
}

enum uint DMLERR_LAST = 0x00004011U;
enum uint MH_CREATE = 0x00000001U;

enum : uint
{
    MH_KEEP   = 0x00000002U,
    MH_DELETE = 0x00000003U,
}

enum uint MH_CLEANUP = 0x00000004U;
enum uint MAX_MONITORS = 0x00000004U;
enum uint MF_MASK = 0xff000000U;

// Callbacks

alias PFNCALLBACK = HDDEDATA function(uint wType, uint wFmt, HCONV hConv, HSZ hsz1, HSZ hsz2, HDDEDATA hData, 
                                      size_t dwData1, size_t dwData2);

// Structs


//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HSZ
{
    void* Value;
}

@RAIIFree!DdeDisconnect
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCONV
{
    void* Value;
}

@RAIIFree!DdeDisconnectList
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(-1))], [])
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HCONVLIST
{
    void* Value;
}

@RAIIFree!DdeFreeDataHandle
//STRUCT ATTR: InvalidHandleValueAttribute : CustomAttributeSig([FixedArgSig(ElementSig(0))], [])
struct HDDEDATA
{
    void* Value;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddeack
struct DDEACK
{
    // Native bit field: bAppReturnCode: [0-7], reserved: [8-13], fBusy: [14], fAck: [15]
    ushort _bitfield0;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddeadvise
struct DDEADVISE
{
    // Native bit field: reserved: [0-13], fDeferUpd: [14], fAckReq: [15]
    ushort _bitfield0;
    short  cfFormat;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddedata
struct DDEDATA
{
    // Native bit field: unused: [0-11], fResponse: [12], fRelease: [13], reserved: [14], fAckReq: [15]
    ushort   _bitfield0;
    short    cfFormat;
    ubyte[1] Value; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/dde/ns-dde-ddepoke
struct DDEPOKE
{
    // Native bit field: unused: [0-12], fRelease: [13], fReserved: [14-15]
    ushort   _bitfield0;
    short    cfFormat;
    ubyte[1] Value; // Flexible array
}

struct DDELN
{
    // Native bit field: unused: [0-12], fRelease: [13], fDeferUpd: [14], fAckReq: [15]
    ushort _bitfield0;
    short  cfFormat;
}

struct DDEUP
{
    // Native bit field: unused: [0-11], fAck: [12], fRelease: [13], fReserved: [14], fAckReq: [15]
    ushort   _bitfield0;
    short    cfFormat;
    ubyte[1] rgb; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-hszpair
struct HSZPAIR
{
    HSZ hszSvc;
    HSZ hszTopic;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-convcontext
struct CONVCONTEXT
{
    uint cb;
    uint wFlags;
    uint wCountryID;
    int  iCodePage;
    uint dwLangID;
    uint dwSecurity;
    SECURITY_QUALITY_OF_SERVICE qos;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-convinfo
struct CONVINFO
{
    uint            cb;
    size_t          hUser;
    HCONV           hConvPartner;
    HSZ             hszSvcPartner;
    HSZ             hszServiceReq;
    HSZ             hszTopic;
    HSZ             hszItem;
    uint            wFmt;
    DDE_CLIENT_TRANSACTION_TYPE wType;
    CONVINFO_STATUS wStatus;
    CONVINFO_CONVERSATION_STATE wConvst;
    uint            wLastError;
    HCONVLIST       hConvList;
    CONVCONTEXT     ConvCtxt;
    HWND            hwnd;
    HWND            hwndPartner;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-ddeml_msg_hook_data
struct DDEML_MSG_HOOK_DATA
{
    size_t  uiLo;
    size_t  uiHi;
    uint    cbData;
    uint[8] Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monmsgstruct
struct MONMSGSTRUCT
{
    uint                cb;
    HWND                hwndTo;
    uint                dwTime;
    HANDLE              hTask;
    uint                wMsg;
    WPARAM              wParam;
    LPARAM              lParam;
    DDEML_MSG_HOOK_DATA dmhd;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-moncbstruct
struct MONCBSTRUCT
{
    uint        cb;
    uint        dwTime;
    HANDLE      hTask;
    uint        dwRet;
    uint        wType;
    uint        wFmt;
    HCONV       hConv;
    HSZ         hsz1;
    HSZ         hsz2;
    HDDEDATA    hData;
    size_t      dwData1;
    size_t      dwData2;
    CONVCONTEXT cc;
    uint        cbData;
    uint[8]     Data;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monhszstructa
struct MONHSZSTRUCTA
{
    uint    cb;
    BOOL    fsAction;
    uint    dwTime;
    HSZ     hsz;
    HANDLE  hTask;
    CHAR[1] str; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monhszstructw
struct MONHSZSTRUCTW
{
    uint     cb;
    BOOL     fsAction;
    uint     dwTime;
    HSZ      hsz;
    HANDLE   hTask;
    wchar[1] str; // Flexible array
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monerrstruct
struct MONERRSTRUCT
{
    uint   cb;
    uint   wLastError;
    uint   dwTime;
    HANDLE hTask;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monlinkstruct
struct MONLINKSTRUCT
{
    uint   cb;
    uint   dwTime;
    HANDLE hTask;
    BOOL   fEstablished;
    BOOL   fNoData;
    HSZ    hszSvc;
    HSZ    hszTopic;
    HSZ    hszItem;
    uint   wFmt;
    BOOL   fServer;
    HCONV  hConvServer;
    HCONV  hConvClient;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/ddeml/ns-ddeml-monconvstruct
struct MONCONVSTRUCT
{
    uint   cb;
    BOOL   fConnect;
    uint   dwTime;
    HANDLE hTask;
    HSZ    hszSvc;
    HSZ    hszTopic;
    HCONV  hConvClient;
    HCONV  hConvServer;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/wingdi/ns-wingdi-metafilepict
struct METAFILEPICT
{
    int       mm;
    int       xExt;
    int       yExt;
    HMETAFILE hMF;
}

// Microsoft documentation: https://learn.microsoft.com/windows/win32/api/winuser/ns-winuser-copydatastruct
struct COPYDATASTRUCT
{
    size_t dwData;
    uint   cbData;
    void*  lpData;
}

// Functions

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeSetQualityOfService(HWND hwndClient, const(SECURITY_QUALITY_OF_SERVICE)* pqosNew, 
                            SECURITY_QUALITY_OF_SERVICE* pqosPrev);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL ImpersonateDdeClientWindow(HWND hWndClient, HWND hWndServer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
LPARAM PackDDElParam(uint msg, size_t uiLo, size_t uiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL UnpackDDElParam(uint msg, LPARAM lParam, size_t* puiLo, size_t* puiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL FreeDDElParam(uint msg, LPARAM lParam);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
LPARAM ReuseDDElParam(LPARAM lParam, uint msgIn, uint msgOut, size_t uiLo, size_t uiHi);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeInitializeA(uint* pidInst, PFNCALLBACK pfnCallback, DDE_INITIALIZE_COMMAND afCmd, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ulRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeInitializeW(uint* pidInst, PFNCALLBACK pfnCallback, DDE_INITIALIZE_COMMAND afCmd, 
                    /*PARAM ATTR: ReservedAttribute : CustomAttributeSig([], [])*/uint ulRes);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeUninitialize(uint idInst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HCONVLIST DdeConnectList(uint idInst, HSZ hszService, HSZ hszTopic, HCONVLIST hConvList, CONVCONTEXT* pCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HCONV DdeQueryNextServer(HCONVLIST hConvList, HCONV hConvPrev);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeDisconnectList(HCONVLIST hConvList);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HCONV DdeConnect(uint idInst, HSZ hszService, HSZ hszTopic, CONVCONTEXT* pCC);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeDisconnect(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HCONV DdeReconnect(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeQueryConvInfo(HCONV hConv, uint idTransaction, CONVINFO* pConvInfo);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeSetUserHandle(HCONV hConv, uint id, size_t hUser);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeAbandonTransaction(uint idInst, HCONV hConv, uint idTransaction);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdePostAdvise(uint idInst, HSZ hszTopic, HSZ hszItem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeEnableCallback(uint idInst, HCONV hConv, DDE_ENABLE_CALLBACK_CMD wCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeImpersonateClient(HCONV hConv);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDDEDATA DdeNameService(uint idInst, HSZ hsz1, HSZ hsz2, DDE_NAME_SERVICE_CMD afCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDDEDATA DdeClientTransaction(ubyte* pData, uint cbData, HCONV hConv, HSZ hszItem, uint wFmt, 
                              DDE_CLIENT_TRANSACTION_TYPE wType, uint dwTimeout, uint* pdwResult);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDDEDATA DdeCreateDataHandle(uint idInst, 
                             /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pSrc, 
                             uint cb, uint cbOff, HSZ hszItem, uint wFmt, uint afCmd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HDDEDATA DdeAddData(HDDEDATA hData, 
                    /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pSrc, 
                    uint cb, uint cbOff);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeGetData(HDDEDATA hData, 
                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(2)))])*/ubyte* pDst, 
                uint cbMax, uint cbOff);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
ubyte* DdeAccessData(HDDEDATA hData, uint* pcbDataSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeUnaccessData(HDDEDATA hData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeFreeDataHandle(HDDEDATA hData);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeGetLastError(uint idInst);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HSZ DdeCreateStringHandleA(uint idInst, const(PSTR) psz, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HSZ DdeCreateStringHandleW(uint idInst, const(PWSTR) psz, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeQueryStringA(uint idInst, HSZ hsz, PSTR psz, uint cchMax, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint DdeQueryStringW(uint idInst, HSZ hsz, PWSTR psz, uint cchMax, int iCodePage);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeFreeStringHandle(uint idInst, HSZ hsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL DdeKeepStringHandle(uint idInst, HSZ hsz);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int DdeCmpStringHandles(HSZ hsz1, HSZ hsz2);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("GDI32.dll")
HENHMETAFILE SetWinMetaFileBits(uint nSize, 
                                /*PARAM ATTR: MemorySizeAttribute : CustomAttributeSig([], [NamedArgSig("BytesParamIndex", FixedArgSig(ElementSig(0)))])*/const(ubyte)* lpMeta16Data, 
                                HDC hdcRef, const(METAFILEPICT)* lpMFP);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL OpenClipboard(HWND hWndNewOwner);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL CloseClipboard();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint GetClipboardSequenceNumber();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWND GetClipboardOwner();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWND SetClipboardViewer(HWND hWndNewViewer);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWND GetClipboardViewer();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL ChangeClipboardChain(HWND hWndRemove, HWND hWndNewNext);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HANDLE SetClipboardData(uint uFormat, HANDLE hMem);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HANDLE GetClipboardData(uint uFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint RegisterClipboardFormatA(const(PSTR) lpszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint RegisterClipboardFormatW(const(PWSTR) lpszFormat);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int CountClipboardFormats();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
uint EnumClipboardFormats(uint format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int GetClipboardFormatNameA(uint format, PSTR lpszFormatName, int cchMaxCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int GetClipboardFormatNameW(uint format, PWSTR lpszFormatName, int cchMaxCount);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL EmptyClipboard();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
BOOL IsClipboardFormatAvailable(uint format);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
int GetPriorityClipboardFormat(uint* paFormatPriorityList, int cFormats);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("USER32.dll")
HWND GetOpenClipboardWindow();

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL AddClipboardFormatListener(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL RemoveClipboardFormatListener(HWND hwnd);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows6.0.6000))], [])
@DllImport("USER32.dll")
BOOL GetUpdatedClipboardFormats(uint* lpuiFormats, uint cFormats, uint* pcFormatsOut);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GlobalDeleteAtom(ushort nAtom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
BOOL InitAtomTable(uint nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort DeleteAtom(ushort nAtom);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GlobalAddAtomW(const(PWSTR) lpString);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExA(const(PSTR) lpString, uint Flags);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExW(const(PWSTR) lpString, uint Flags);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GlobalFindAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort GlobalFindAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort AddAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort AddAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort FindAtomA(const(PSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
ushort FindAtomW(const(PWSTR) lpString);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetAtomNameA(ushort nAtom, PSTR lpBuffer, int nSize);

//METH ATTR: SupportedOSPlatformAttribute : CustomAttributeSig([FixedArgSig(ElementSig(windows5.0))], [])
@DllImport("KERNEL32.dll")
uint GetAtomNameW(ushort nAtom, PWSTR lpBuffer, int nSize);


