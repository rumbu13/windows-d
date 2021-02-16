module windows.dataexchange;

public import windows.core;
public import windows.security : SECURITY_QUALITY_OF_SERVICE;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND, LPARAM, WPARAM;

extern(Windows):


// Callbacks

alias FNCALLBACK = ptrdiff_t function(uint wType, uint wFmt, ptrdiff_t hConv, ptrdiff_t hsz1, ptrdiff_t hsz2, 
                                      ptrdiff_t hData, size_t dwData1, size_t dwData2);
alias PFNCALLBACK = ptrdiff_t function(uint wType, uint wFmt, ptrdiff_t hConv, ptrdiff_t hsz1, ptrdiff_t hsz2, 
                                       ptrdiff_t hData, size_t dwData1, size_t dwData2);

// Structs


struct METAFILEPICT
{
    int       mm;
    int       xExt;
    int       yExt;
    ptrdiff_t hMF;
}

struct COPYDATASTRUCT
{
    size_t dwData;
    uint   cbData;
    void*  lpData;
}

struct DDEACK
{
    ushort _bitfield3;
}

struct DDEADVISE
{
    ushort _bitfield4;
    short  cfFormat;
}

struct DDEDATA
{
    ushort   _bitfield5;
    short    cfFormat;
    ubyte[1] Value;
}

struct DDEPOKE
{
    ushort   _bitfield6;
    short    cfFormat;
    ubyte[1] Value;
}

struct DDELN
{
    ushort _bitfield7;
    short  cfFormat;
}

struct DDEUP
{
    ushort   _bitfield8;
    short    cfFormat;
    ubyte[1] rgb;
}

struct HCONVLIST__
{
    int unused;
}

struct HCONV__
{
    int unused;
}

struct HSZ__
{
    int unused;
}

struct HDDEDATA__
{
    int unused;
}

struct HSZPAIR
{
    ptrdiff_t hszSvc;
    ptrdiff_t hszTopic;
}

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

struct CONVINFO
{
    uint        cb;
    size_t      hUser;
    ptrdiff_t   hConvPartner;
    ptrdiff_t   hszSvcPartner;
    ptrdiff_t   hszServiceReq;
    ptrdiff_t   hszTopic;
    ptrdiff_t   hszItem;
    uint        wFmt;
    uint        wType;
    uint        wStatus;
    uint        wConvst;
    uint        wLastError;
    ptrdiff_t   hConvList;
    CONVCONTEXT ConvCtxt;
    HWND        hwnd;
    HWND        hwndPartner;
}

struct DDEML_MSG_HOOK_DATA
{
    size_t  uiLo;
    size_t  uiHi;
    uint    cbData;
    uint[8] Data;
}

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

struct MONCBSTRUCT
{
    uint        cb;
    uint        dwTime;
    HANDLE      hTask;
    uint        dwRet;
    uint        wType;
    uint        wFmt;
    ptrdiff_t   hConv;
    ptrdiff_t   hsz1;
    ptrdiff_t   hsz2;
    ptrdiff_t   hData;
    size_t      dwData1;
    size_t      dwData2;
    CONVCONTEXT cc;
    uint        cbData;
    uint[8]     Data;
}

struct MONHSZSTRUCTA
{
    uint      cb;
    BOOL      fsAction;
    uint      dwTime;
    ptrdiff_t hsz;
    HANDLE    hTask;
    byte[1]   str;
}

struct MONHSZSTRUCTW
{
    uint      cb;
    BOOL      fsAction;
    uint      dwTime;
    ptrdiff_t hsz;
    HANDLE    hTask;
    ushort[1] str;
}

struct MONERRSTRUCT
{
    uint   cb;
    uint   wLastError;
    uint   dwTime;
    HANDLE hTask;
}

struct MONLINKSTRUCT
{
    uint      cb;
    uint      dwTime;
    HANDLE    hTask;
    BOOL      fEstablished;
    BOOL      fNoData;
    ptrdiff_t hszSvc;
    ptrdiff_t hszTopic;
    ptrdiff_t hszItem;
    uint      wFmt;
    BOOL      fServer;
    ptrdiff_t hConvServer;
    ptrdiff_t hConvClient;
}

struct MONCONVSTRUCT
{
    uint      cb;
    BOOL      fConnect;
    uint      dwTime;
    HANDLE    hTask;
    ptrdiff_t hszSvc;
    ptrdiff_t hszTopic;
    ptrdiff_t hConvClient;
    ptrdiff_t hConvServer;
}

// Functions

@DllImport("USER32")
BOOL OpenClipboard(HWND hWndNewOwner);

@DllImport("USER32")
BOOL CloseClipboard();

@DllImport("USER32")
uint GetClipboardSequenceNumber();

@DllImport("USER32")
HWND GetClipboardOwner();

@DllImport("USER32")
HWND SetClipboardViewer(HWND hWndNewViewer);

@DllImport("USER32")
HWND GetClipboardViewer();

@DllImport("USER32")
BOOL ChangeClipboardChain(HWND hWndRemove, HWND hWndNewNext);

@DllImport("USER32")
HANDLE SetClipboardData(uint uFormat, HANDLE hMem);

@DllImport("USER32")
HANDLE GetClipboardData(uint uFormat);

@DllImport("USER32")
uint RegisterClipboardFormatA(const(char)* lpszFormat);

@DllImport("USER32")
uint RegisterClipboardFormatW(const(wchar)* lpszFormat);

@DllImport("USER32")
int CountClipboardFormats();

@DllImport("USER32")
uint EnumClipboardFormats(uint format);

@DllImport("USER32")
int GetClipboardFormatNameA(uint format, const(char)* lpszFormatName, int cchMaxCount);

@DllImport("USER32")
int GetClipboardFormatNameW(uint format, const(wchar)* lpszFormatName, int cchMaxCount);

@DllImport("USER32")
BOOL EmptyClipboard();

@DllImport("USER32")
BOOL IsClipboardFormatAvailable(uint format);

@DllImport("USER32")
int GetPriorityClipboardFormat(char* paFormatPriorityList, int cFormats);

@DllImport("USER32")
HWND GetOpenClipboardWindow();

@DllImport("USER32")
BOOL AddClipboardFormatListener(HWND hwnd);

@DllImport("USER32")
BOOL RemoveClipboardFormatListener(HWND hwnd);

@DllImport("USER32")
BOOL GetUpdatedClipboardFormats(char* lpuiFormats, uint cFormats, uint* pcFormatsOut);

@DllImport("USER32")
BOOL DdeSetQualityOfService(HWND hwndClient, const(SECURITY_QUALITY_OF_SERVICE)* pqosNew, 
                            SECURITY_QUALITY_OF_SERVICE* pqosPrev);

@DllImport("USER32")
BOOL ImpersonateDdeClientWindow(HWND hWndClient, HWND hWndServer);

@DllImport("USER32")
LPARAM PackDDElParam(uint msg, size_t uiLo, size_t uiHi);

@DllImport("USER32")
BOOL UnpackDDElParam(uint msg, LPARAM lParam, uint* puiLo, uint* puiHi);

@DllImport("USER32")
BOOL FreeDDElParam(uint msg, LPARAM lParam);

@DllImport("USER32")
LPARAM ReuseDDElParam(LPARAM lParam, uint msgIn, uint msgOut, size_t uiLo, size_t uiHi);

@DllImport("USER32")
uint DdeInitializeA(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

@DllImport("USER32")
uint DdeInitializeW(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

@DllImport("USER32")
BOOL DdeUninitialize(uint idInst);

@DllImport("USER32")
ptrdiff_t DdeConnectList(uint idInst, ptrdiff_t hszService, ptrdiff_t hszTopic, ptrdiff_t hConvList, 
                         CONVCONTEXT* pCC);

@DllImport("USER32")
ptrdiff_t DdeQueryNextServer(ptrdiff_t hConvList, ptrdiff_t hConvPrev);

@DllImport("USER32")
BOOL DdeDisconnectList(ptrdiff_t hConvList);

@DllImport("USER32")
ptrdiff_t DdeConnect(uint idInst, ptrdiff_t hszService, ptrdiff_t hszTopic, CONVCONTEXT* pCC);

@DllImport("USER32")
BOOL DdeDisconnect(ptrdiff_t hConv);

@DllImport("USER32")
ptrdiff_t DdeReconnect(ptrdiff_t hConv);

@DllImport("USER32")
uint DdeQueryConvInfo(ptrdiff_t hConv, uint idTransaction, CONVINFO* pConvInfo);

@DllImport("USER32")
BOOL DdeSetUserHandle(ptrdiff_t hConv, uint id, size_t hUser);

@DllImport("USER32")
BOOL DdeAbandonTransaction(uint idInst, ptrdiff_t hConv, uint idTransaction);

@DllImport("USER32")
BOOL DdePostAdvise(uint idInst, ptrdiff_t hszTopic, ptrdiff_t hszItem);

@DllImport("USER32")
BOOL DdeEnableCallback(uint idInst, ptrdiff_t hConv, uint wCmd);

@DllImport("USER32")
BOOL DdeImpersonateClient(ptrdiff_t hConv);

@DllImport("USER32")
ptrdiff_t DdeNameService(uint idInst, ptrdiff_t hsz1, ptrdiff_t hsz2, uint afCmd);

@DllImport("USER32")
ptrdiff_t DdeClientTransaction(ubyte* pData, uint cbData, ptrdiff_t hConv, ptrdiff_t hszItem, uint wFmt, 
                               uint wType, uint dwTimeout, uint* pdwResult);

@DllImport("USER32")
ptrdiff_t DdeCreateDataHandle(uint idInst, char* pSrc, uint cb, uint cbOff, ptrdiff_t hszItem, uint wFmt, 
                              uint afCmd);

@DllImport("USER32")
ptrdiff_t DdeAddData(ptrdiff_t hData, char* pSrc, uint cb, uint cbOff);

@DllImport("USER32")
uint DdeGetData(ptrdiff_t hData, char* pDst, uint cbMax, uint cbOff);

@DllImport("USER32")
ubyte* DdeAccessData(ptrdiff_t hData, uint* pcbDataSize);

@DllImport("USER32")
BOOL DdeUnaccessData(ptrdiff_t hData);

@DllImport("USER32")
BOOL DdeFreeDataHandle(ptrdiff_t hData);

@DllImport("USER32")
uint DdeGetLastError(uint idInst);

@DllImport("USER32")
ptrdiff_t DdeCreateStringHandleA(uint idInst, const(char)* psz, int iCodePage);

@DllImport("USER32")
ptrdiff_t DdeCreateStringHandleW(uint idInst, const(wchar)* psz, int iCodePage);

@DllImport("USER32")
uint DdeQueryStringA(uint idInst, ptrdiff_t hsz, const(char)* psz, uint cchMax, int iCodePage);

@DllImport("USER32")
uint DdeQueryStringW(uint idInst, ptrdiff_t hsz, const(wchar)* psz, uint cchMax, int iCodePage);

@DllImport("USER32")
BOOL DdeFreeStringHandle(uint idInst, ptrdiff_t hsz);

@DllImport("USER32")
BOOL DdeKeepStringHandle(uint idInst, ptrdiff_t hsz);

@DllImport("USER32")
int DdeCmpStringHandles(ptrdiff_t hsz1, ptrdiff_t hsz2);

@DllImport("KERNEL32")
ushort GlobalDeleteAtom(ushort nAtom);

@DllImport("KERNEL32")
BOOL InitAtomTable(uint nSize);

@DllImport("KERNEL32")
ushort DeleteAtom(ushort nAtom);

@DllImport("KERNEL32")
ushort GlobalAddAtomA(const(char)* lpString);

@DllImport("KERNEL32")
ushort GlobalAddAtomW(const(wchar)* lpString);

@DllImport("KERNEL32")
ushort GlobalAddAtomExA(const(char)* lpString, uint Flags);

@DllImport("KERNEL32")
ushort GlobalAddAtomExW(const(wchar)* lpString, uint Flags);

@DllImport("KERNEL32")
ushort GlobalFindAtomA(const(char)* lpString);

@DllImport("KERNEL32")
ushort GlobalFindAtomW(const(wchar)* lpString);

@DllImport("KERNEL32")
uint GlobalGetAtomNameA(ushort nAtom, const(char)* lpBuffer, int nSize);

@DllImport("KERNEL32")
uint GlobalGetAtomNameW(ushort nAtom, const(wchar)* lpBuffer, int nSize);

@DllImport("KERNEL32")
ushort AddAtomA(const(char)* lpString);

@DllImport("KERNEL32")
ushort AddAtomW(const(wchar)* lpString);

@DllImport("KERNEL32")
ushort FindAtomA(const(char)* lpString);

@DllImport("KERNEL32")
ushort FindAtomW(const(wchar)* lpString);

@DllImport("KERNEL32")
uint GetAtomNameA(ushort nAtom, const(char)* lpBuffer, int nSize);

@DllImport("KERNEL32")
uint GetAtomNameW(ushort nAtom, const(wchar)* lpBuffer, int nSize);


