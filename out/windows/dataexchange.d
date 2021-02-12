module windows.dataexchange;

public import windows.security;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct METAFILEPICT
{
    int mm;
    int xExt;
    int yExt;
    int hMF;
}

struct COPYDATASTRUCT
{
    uint dwData;
    uint cbData;
    void* lpData;
}

@DllImport("USER32.dll")
BOOL OpenClipboard(HWND hWndNewOwner);

@DllImport("USER32.dll")
BOOL CloseClipboard();

@DllImport("USER32.dll")
uint GetClipboardSequenceNumber();

@DllImport("USER32.dll")
HWND GetClipboardOwner();

@DllImport("USER32.dll")
HWND SetClipboardViewer(HWND hWndNewViewer);

@DllImport("USER32.dll")
HWND GetClipboardViewer();

@DllImport("USER32.dll")
BOOL ChangeClipboardChain(HWND hWndRemove, HWND hWndNewNext);

@DllImport("USER32.dll")
HANDLE SetClipboardData(uint uFormat, HANDLE hMem);

@DllImport("USER32.dll")
HANDLE GetClipboardData(uint uFormat);

@DllImport("USER32.dll")
uint RegisterClipboardFormatA(const(char)* lpszFormat);

@DllImport("USER32.dll")
uint RegisterClipboardFormatW(const(wchar)* lpszFormat);

@DllImport("USER32.dll")
int CountClipboardFormats();

@DllImport("USER32.dll")
uint EnumClipboardFormats(uint format);

@DllImport("USER32.dll")
int GetClipboardFormatNameA(uint format, const(char)* lpszFormatName, int cchMaxCount);

@DllImport("USER32.dll")
int GetClipboardFormatNameW(uint format, const(wchar)* lpszFormatName, int cchMaxCount);

@DllImport("USER32.dll")
BOOL EmptyClipboard();

@DllImport("USER32.dll")
BOOL IsClipboardFormatAvailable(uint format);

@DllImport("USER32.dll")
int GetPriorityClipboardFormat(char* paFormatPriorityList, int cFormats);

@DllImport("USER32.dll")
HWND GetOpenClipboardWindow();

@DllImport("USER32.dll")
BOOL AddClipboardFormatListener(HWND hwnd);

@DllImport("USER32.dll")
BOOL RemoveClipboardFormatListener(HWND hwnd);

@DllImport("USER32.dll")
BOOL GetUpdatedClipboardFormats(char* lpuiFormats, uint cFormats, uint* pcFormatsOut);

@DllImport("USER32.dll")
BOOL DdeSetQualityOfService(HWND hwndClient, const(SECURITY_QUALITY_OF_SERVICE)* pqosNew, SECURITY_QUALITY_OF_SERVICE* pqosPrev);

@DllImport("USER32.dll")
BOOL ImpersonateDdeClientWindow(HWND hWndClient, HWND hWndServer);

@DllImport("USER32.dll")
LPARAM PackDDElParam(uint msg, uint uiLo, uint uiHi);

@DllImport("USER32.dll")
BOOL UnpackDDElParam(uint msg, LPARAM lParam, uint* puiLo, uint* puiHi);

@DllImport("USER32.dll")
BOOL FreeDDElParam(uint msg, LPARAM lParam);

@DllImport("USER32.dll")
LPARAM ReuseDDElParam(LPARAM lParam, uint msgIn, uint msgOut, uint uiLo, uint uiHi);

@DllImport("USER32.dll")
uint DdeInitializeA(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

@DllImport("USER32.dll")
uint DdeInitializeW(uint* pidInst, PFNCALLBACK pfnCallback, uint afCmd, uint ulRes);

@DllImport("USER32.dll")
BOOL DdeUninitialize(uint idInst);

@DllImport("USER32.dll")
int DdeConnectList(uint idInst, int hszService, int hszTopic, int hConvList, CONVCONTEXT* pCC);

@DllImport("USER32.dll")
int DdeQueryNextServer(int hConvList, int hConvPrev);

@DllImport("USER32.dll")
BOOL DdeDisconnectList(int hConvList);

@DllImport("USER32.dll")
int DdeConnect(uint idInst, int hszService, int hszTopic, CONVCONTEXT* pCC);

@DllImport("USER32.dll")
BOOL DdeDisconnect(int hConv);

@DllImport("USER32.dll")
int DdeReconnect(int hConv);

@DllImport("USER32.dll")
uint DdeQueryConvInfo(int hConv, uint idTransaction, CONVINFO* pConvInfo);

@DllImport("USER32.dll")
BOOL DdeSetUserHandle(int hConv, uint id, uint hUser);

@DllImport("USER32.dll")
BOOL DdeAbandonTransaction(uint idInst, int hConv, uint idTransaction);

@DllImport("USER32.dll")
BOOL DdePostAdvise(uint idInst, int hszTopic, int hszItem);

@DllImport("USER32.dll")
BOOL DdeEnableCallback(uint idInst, int hConv, uint wCmd);

@DllImport("USER32.dll")
BOOL DdeImpersonateClient(int hConv);

@DllImport("USER32.dll")
int DdeNameService(uint idInst, int hsz1, int hsz2, uint afCmd);

@DllImport("USER32.dll")
int DdeClientTransaction(ubyte* pData, uint cbData, int hConv, int hszItem, uint wFmt, uint wType, uint dwTimeout, uint* pdwResult);

@DllImport("USER32.dll")
int DdeCreateDataHandle(uint idInst, char* pSrc, uint cb, uint cbOff, int hszItem, uint wFmt, uint afCmd);

@DllImport("USER32.dll")
int DdeAddData(int hData, char* pSrc, uint cb, uint cbOff);

@DllImport("USER32.dll")
uint DdeGetData(int hData, char* pDst, uint cbMax, uint cbOff);

@DllImport("USER32.dll")
ubyte* DdeAccessData(int hData, uint* pcbDataSize);

@DllImport("USER32.dll")
BOOL DdeUnaccessData(int hData);

@DllImport("USER32.dll")
BOOL DdeFreeDataHandle(int hData);

@DllImport("USER32.dll")
uint DdeGetLastError(uint idInst);

@DllImport("USER32.dll")
int DdeCreateStringHandleA(uint idInst, const(char)* psz, int iCodePage);

@DllImport("USER32.dll")
int DdeCreateStringHandleW(uint idInst, const(wchar)* psz, int iCodePage);

@DllImport("USER32.dll")
uint DdeQueryStringA(uint idInst, int hsz, const(char)* psz, uint cchMax, int iCodePage);

@DllImport("USER32.dll")
uint DdeQueryStringW(uint idInst, int hsz, const(wchar)* psz, uint cchMax, int iCodePage);

@DllImport("USER32.dll")
BOOL DdeFreeStringHandle(uint idInst, int hsz);

@DllImport("USER32.dll")
BOOL DdeKeepStringHandle(uint idInst, int hsz);

@DllImport("USER32.dll")
int DdeCmpStringHandles(int hsz1, int hsz2);

@DllImport("KERNEL32.dll")
ushort GlobalDeleteAtom(ushort nAtom);

@DllImport("KERNEL32.dll")
BOOL InitAtomTable(uint nSize);

@DllImport("KERNEL32.dll")
ushort DeleteAtom(ushort nAtom);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomA(const(char)* lpString);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomW(const(wchar)* lpString);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExA(const(char)* lpString, uint Flags);

@DllImport("KERNEL32.dll")
ushort GlobalAddAtomExW(const(wchar)* lpString, uint Flags);

@DllImport("KERNEL32.dll")
ushort GlobalFindAtomA(const(char)* lpString);

@DllImport("KERNEL32.dll")
ushort GlobalFindAtomW(const(wchar)* lpString);

@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameA(ushort nAtom, const(char)* lpBuffer, int nSize);

@DllImport("KERNEL32.dll")
uint GlobalGetAtomNameW(ushort nAtom, const(wchar)* lpBuffer, int nSize);

@DllImport("KERNEL32.dll")
ushort AddAtomA(const(char)* lpString);

@DllImport("KERNEL32.dll")
ushort AddAtomW(const(wchar)* lpString);

@DllImport("KERNEL32.dll")
ushort FindAtomA(const(char)* lpString);

@DllImport("KERNEL32.dll")
ushort FindAtomW(const(wchar)* lpString);

@DllImport("KERNEL32.dll")
uint GetAtomNameA(ushort nAtom, const(char)* lpBuffer, int nSize);

@DllImport("KERNEL32.dll")
uint GetAtomNameW(ushort nAtom, const(wchar)* lpBuffer, int nSize);

struct DDEACK
{
    ushort _bitfield;
}

struct DDEADVISE
{
    ushort _bitfield;
    short cfFormat;
}

struct DDEDATA
{
    ushort _bitfield;
    short cfFormat;
    ubyte Value;
}

struct DDEPOKE
{
    ushort _bitfield;
    short cfFormat;
    ubyte Value;
}

struct DDELN
{
    ushort _bitfield;
    short cfFormat;
}

struct DDEUP
{
    ushort _bitfield;
    short cfFormat;
    ubyte rgb;
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
    int hszSvc;
    int hszTopic;
}

struct CONVCONTEXT
{
    uint cb;
    uint wFlags;
    uint wCountryID;
    int iCodePage;
    uint dwLangID;
    uint dwSecurity;
    SECURITY_QUALITY_OF_SERVICE qos;
}

struct CONVINFO
{
    uint cb;
    uint hUser;
    int hConvPartner;
    int hszSvcPartner;
    int hszServiceReq;
    int hszTopic;
    int hszItem;
    uint wFmt;
    uint wType;
    uint wStatus;
    uint wConvst;
    uint wLastError;
    int hConvList;
    CONVCONTEXT ConvCtxt;
    HWND hwnd;
    HWND hwndPartner;
}

alias FNCALLBACK = extern(Windows) int function(uint wType, uint wFmt, int hConv, int hsz1, int hsz2, int hData, uint dwData1, uint dwData2);
alias PFNCALLBACK = extern(Windows) int function(uint wType, uint wFmt, int hConv, int hsz1, int hsz2, int hData, uint dwData1, uint dwData2);
struct DDEML_MSG_HOOK_DATA
{
    uint uiLo;
    uint uiHi;
    uint cbData;
    uint Data;
}

struct MONMSGSTRUCT
{
    uint cb;
    HWND hwndTo;
    uint dwTime;
    HANDLE hTask;
    uint wMsg;
    WPARAM wParam;
    LPARAM lParam;
    DDEML_MSG_HOOK_DATA dmhd;
}

struct MONCBSTRUCT
{
    uint cb;
    uint dwTime;
    HANDLE hTask;
    uint dwRet;
    uint wType;
    uint wFmt;
    int hConv;
    int hsz1;
    int hsz2;
    int hData;
    uint dwData1;
    uint dwData2;
    CONVCONTEXT cc;
    uint cbData;
    uint Data;
}

struct MONHSZSTRUCTA
{
    uint cb;
    BOOL fsAction;
    uint dwTime;
    int hsz;
    HANDLE hTask;
    byte str;
}

struct MONHSZSTRUCTW
{
    uint cb;
    BOOL fsAction;
    uint dwTime;
    int hsz;
    HANDLE hTask;
    ushort str;
}

struct MONERRSTRUCT
{
    uint cb;
    uint wLastError;
    uint dwTime;
    HANDLE hTask;
}

struct MONLINKSTRUCT
{
    uint cb;
    uint dwTime;
    HANDLE hTask;
    BOOL fEstablished;
    BOOL fNoData;
    int hszSvc;
    int hszTopic;
    int hszItem;
    uint wFmt;
    BOOL fServer;
    int hConvServer;
    int hConvClient;
}

struct MONCONVSTRUCT
{
    uint cb;
    BOOL fConnect;
    uint dwTime;
    HANDLE hTask;
    int hszSvc;
    int hszTopic;
    int hConvClient;
    int hConvServer;
}

