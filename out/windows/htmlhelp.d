module windows.htmlhelp;

public import windows.core;
public import windows.automation : VARIANT;
public import windows.com : HRESULT, IPersistStreamInit, IUnknown;
public import windows.controls : NMHDR;
public import windows.displaydevices : POINT, RECT;
public import windows.search : IStemmer;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL, HINSTANCE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    HH_GPROPID_SINGLETHREAD     = 0x00000001,
    HH_GPROPID_TOOLBAR_MARGIN   = 0x00000002,
    HH_GPROPID_UI_LANGUAGE      = 0x00000003,
    HH_GPROPID_CURRENT_SUBSET   = 0x00000004,
    HH_GPROPID_CONTENT_LANGUAGE = 0x00000005,
}
alias HH_GPROPID = int;

enum : int
{
    PRIORITY_LOW    = 0x00000000,
    PRIORITY_NORMAL = 0x00000001,
    PRIORITY_HIGH   = 0x00000002,
}
alias PRIORITY = int;

// Constants


enum : int
{
    HHWIN_NAVTYPE_TOC          = 0x00000000,
    HHWIN_NAVTYPE_INDEX        = 0x00000001,
    HHWIN_NAVTYPE_SEARCH       = 0x00000002,
    HHWIN_NAVTYPE_FAVORITES    = 0x00000003,
    HHWIN_NAVTYPE_HISTORY      = 0x00000004,
    HHWIN_NAVTYPE_AUTHOR       = 0x00000005,
    HHWIN_NAVTYPE_CUSTOM_FIRST = 0x0000000b,
}

enum int IT_EXCLUSIVE = 0x00000001;

enum : int
{
    HHWIN_NAVTAB_TOP    = 0x00000000,
    HHWIN_NAVTAB_LEFT   = 0x00000001,
    HHWIN_NAVTAB_BOTTOM = 0x00000002,
}

enum : int
{
    HH_TAB_INDEX        = 0x00000001,
    HH_TAB_SEARCH       = 0x00000002,
    HH_TAB_FAVORITES    = 0x00000003,
    HH_TAB_HISTORY      = 0x00000004,
    HH_TAB_AUTHOR       = 0x00000005,
    HH_TAB_CUSTOM_FIRST = 0x0000000b,
    HH_TAB_CUSTOM_LAST  = 0x00000013,
}

enum : int
{
    HHACT_TAB_INDEX     = 0x00000001,
    HHACT_TAB_SEARCH    = 0x00000002,
    HHACT_TAB_HISTORY   = 0x00000003,
    HHACT_TAB_FAVORITES = 0x00000004,
}

enum : int
{
    HHACT_CONTRACT  = 0x00000006,
    HHACT_BACK      = 0x00000007,
    HHACT_FORWARD   = 0x00000008,
    HHACT_STOP      = 0x00000009,
    HHACT_REFRESH   = 0x0000000a,
    HHACT_HOME      = 0x0000000b,
    HHACT_SYNC      = 0x0000000c,
    HHACT_OPTIONS   = 0x0000000d,
    HHACT_PRINT     = 0x0000000e,
    HHACT_HIGHLIGHT = 0x0000000f,
}

enum : int
{
    HHACT_JUMP1     = 0x00000011,
    HHACT_JUMP2     = 0x00000012,
    HHACT_ZOOM      = 0x00000013,
    HHACT_TOC_NEXT  = 0x00000014,
    HHACT_TOC_PREV  = 0x00000015,
    HHACT_NOTES     = 0x00000016,
    HHACT_LAST_ENUM = 0x00000017,
}

// Callbacks

alias PFNCOLHEAPFREE = int function(void* param0);

// Structs


struct HHN_NOTIFY
{
    NMHDR        hdr;
    const(char)* pszUrl;
}

struct HH_POPUP
{
    int       cbStruct;
    HINSTANCE hinst;
    uint      idString;
    byte*     pszText;
    POINT     pt;
    uint      clrForeground;
    uint      clrBackground;
    RECT      rcMargins;
    byte*     pszFont;
}

struct HH_AKLINK
{
    int   cbStruct;
    BOOL  fReserved;
    byte* pszKeywords;
    byte* pszUrl;
    byte* pszMsgText;
    byte* pszMsgTitle;
    byte* pszWindow;
    BOOL  fIndexOnFail;
}

struct HH_ENUM_IT
{
    int          cbStruct;
    int          iType;
    const(char)* pszCatName;
    const(char)* pszITName;
    const(char)* pszITDescription;
}

struct HH_ENUM_CAT
{
    int          cbStruct;
    const(char)* pszCatName;
    const(char)* pszCatDescription;
}

struct HH_SET_INFOTYPE
{
    int          cbStruct;
    const(char)* pszCatName;
    const(char)* pszInfoTypeName;
}

struct HH_FTS_QUERY
{
    int   cbStruct;
    BOOL  fUniCodeStrings;
    byte* pszSearchQuery;
    int   iProximity;
    BOOL  fStemmedSearch;
    BOOL  fTitleOnly;
    BOOL  fExecute;
    byte* pszWindow;
}

struct HH_WINTYPE
{
    int       cbStruct;
    BOOL      fUniCodeStrings;
    byte*     pszType;
    uint      fsValidMembers;
    uint      fsWinProperties;
    byte*     pszCaption;
    uint      dwStyles;
    uint      dwExStyles;
    RECT      rcWindowPos;
    int       nShowState;
    HWND      hwndHelp;
    HWND      hwndCaller;
    uint*     paInfoTypes;
    HWND      hwndToolBar;
    HWND      hwndNavigation;
    HWND      hwndHTML;
    int       iNavWidth;
    RECT      rcHTML;
    byte*     pszToc;
    byte*     pszIndex;
    byte*     pszFile;
    byte*     pszHome;
    uint      fsToolBarFlags;
    BOOL      fNotExpanded;
    int       curNavType;
    int       tabpos;
    int       idNotify;
    ubyte[20] tabOrder;
    int       cHistory;
    byte*     pszJump1;
    byte*     pszJump2;
    byte*     pszUrlJump1;
    byte*     pszUrlJump2;
    RECT      rcMinSize;
    int       cbInfoTypes;
    byte*     pszCustomTabs;
}

struct HHNTRACK
{
    NMHDR        hdr;
    const(char)* pszCurUrl;
    int          idAction;
    HH_WINTYPE*  phhWinType;
}

struct HH_GLOBAL_PROPERTY
{
    HH_GPROPID id;
    VARIANT    var;
}

struct CProperty
{
    uint dwPropID;
    uint cbData;
    uint dwType;
    union
    {
        const(wchar)* lpszwData;
        void*         lpvData;
        uint          dwValue;
    }
    BOOL fPersist;
}

struct IITGroup
{
}

struct IITQuery
{
}

struct IITStopWordList
{
}

struct ROWSTATUS
{
    int lRowFirst;
    int cRows;
    int cProperties;
    int cRowsTotal;
}

struct COLUMNSTATUS
{
    int cPropCount;
    int cPropsLoaded;
}

// Interfaces

interface IITPropList : IPersistStreamInit
{
    HRESULT Set(uint PropID, uint dwData, uint dwOperation);
    HRESULT Set(uint PropID, void* lpvData, uint cbData, uint dwOperation);
    HRESULT Set(uint PropID, const(wchar)* lpszwString, uint dwOperation);
    HRESULT Add(CProperty* Prop);
    HRESULT Get(uint PropID, CProperty* Property);
    HRESULT Clear();
    HRESULT SetPersist(uint PropID, BOOL fPersist);
    HRESULT SetPersist(BOOL fPersist);
    HRESULT GetFirst(CProperty* Property);
    HRESULT GetNext(CProperty* Property);
    HRESULT GetPropCount(int* cProp);
    HRESULT SaveHeader(void* lpvData, uint dwHdrSize);
    HRESULT SaveData(void* lpvHeader, uint dwHdrSize, void* lpvData, uint dwBufSize);
    HRESULT GetHeaderSize(uint* dwHdrSize);
    HRESULT GetDataSize(void* lpvHeader, uint dwHdrSize, uint* dwDataSize);
    HRESULT SaveDataToStream(void* lpvHeader, uint dwHdrSize, IStream pStream);
    HRESULT LoadFromMem(void* lpvData, uint dwBufSize);
    HRESULT SaveToMem(void* lpvData, uint dwBufSize);
}

interface IITDatabase : IUnknown
{
    HRESULT Open(const(wchar)* lpszHost, const(wchar)* lpszMoniker, uint dwFlags);
    HRESULT Close();
    HRESULT CreateObject(const(GUID)* rclsid, uint* pdwObjInstance);
    HRESULT GetObjectA(uint dwObjInstance, const(GUID)* riid, void** ppvObj);
    HRESULT GetObjectPersistence(const(wchar)* lpwszObject, uint dwObjInstance, void** ppvPersistence, 
                                 BOOL fStream);
}

interface IITWordWheel : IUnknown
{
    HRESULT Open(IITDatabase lpITDB, const(wchar)* lpszMoniker, uint dwFlags);
    HRESULT Close();
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT GetSorterInstance(uint* pdwObjInstance);
    HRESULT Count(int* pcEntries);
    HRESULT Lookup(int lEntry, void* lpvKeyBuf, uint cbKeyBuf);
    HRESULT Lookup(int lEntry, IITResultSet lpITResult, int cEntries);
    HRESULT Lookup(void* lpcvPrefix, BOOL fExactMatch, int* plEntry);
    HRESULT SetGroup(IITGroup* piitGroup);
    HRESULT GetGroup(IITGroup** ppiitGroup);
    HRESULT GetDataCount(int lEntry, uint* pdwCount);
    HRESULT GetData(int lEntry, IITResultSet lpITResult);
    HRESULT GetDataColumns(IITResultSet pRS);
}

interface IStemSink : IUnknown
{
    HRESULT PutAltWord(const(wchar)* pwcInBuf, uint cwc);
    HRESULT PutWord(const(wchar)* pwcInBuf, uint cwc);
}

interface IStemmerConfig : IUnknown
{
    HRESULT SetLocaleInfoA(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT SetControlInfo(uint grfStemFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfStemFlags, uint* pdwReserved);
    HRESULT LoadExternalStemmerData(IStream pStream, uint dwExtDataType);
}

interface IWordBreakerConfig : IUnknown
{
    HRESULT SetLocaleInfoA(uint dwCodePageID, uint lcid);
    HRESULT GetLocaleInfoA(uint* pdwCodePageID, uint* plcid);
    HRESULT SetBreakWordType(uint dwBreakWordType);
    HRESULT GetBreakWordType(uint* pdwBreakWordType);
    HRESULT SetControlInfo(uint grfBreakFlags, uint dwReserved);
    HRESULT GetControlInfo(uint* pgrfBreakFlags, uint* pdwReserved);
    HRESULT LoadExternalBreakerData(IStream pStream, uint dwExtDataType);
    HRESULT SetWordStemmer(const(GUID)* rclsid, IStemmer pStemmer);
    HRESULT GetWordStemmer(IStemmer* ppStemmer);
}

interface IITResultSet : IUnknown
{
    HRESULT SetColumnPriority(int lColumnIndex, PRIORITY ColumnPriority);
    HRESULT SetColumnHeap(int lColumnIndex, void* lpvHeap, PFNCOLHEAPFREE pfnColHeapFree);
    HRESULT SetKeyProp(uint PropID);
    HRESULT Add(void* lpvHdr);
    HRESULT Add(uint PropID, void* lpvDefaultData, uint cbData, PRIORITY Priority);
    HRESULT Add(uint PropID, const(wchar)* lpszwDefault, PRIORITY Priority);
    HRESULT Add(uint PropID, uint dwDefaultData, PRIORITY Priority);
    HRESULT Append(void* lpvHdr, void* lpvData);
    HRESULT Set(int lRowIndex, void* lpvHdr, void* lpvData);
    HRESULT Set(int lRowIndex, int lColumnIndex, size_t dwData);
    HRESULT Set(int lRowIndex, int lColumnIndex, const(wchar)* lpwStr);
    HRESULT Set(int lRowIndex, int lColumnIndex, void* lpvData, uint cbData);
    HRESULT Copy(IITResultSet pRSCopy);
    HRESULT AppendRows(IITResultSet pResSrc, int lRowSrcFirst, int cSrcRows, int* lRowFirstDest);
    HRESULT Get(int lRowIndex, int lColumnIndex, CProperty* Prop);
    HRESULT GetKeyProp(uint* KeyPropID);
    HRESULT GetColumnPriority(int lColumnIndex, PRIORITY* ColumnPriority);
    HRESULT GetRowCount(int* lNumberOfRows);
    HRESULT GetColumnCount(int* lNumberOfColumns);
    HRESULT GetColumn(int lColumnIndex, uint* PropID);
    HRESULT GetColumn(int lColumnIndex, uint* PropID, uint* dwType, void** lpvDefaultValue, uint* cbSize, 
                      PRIORITY* ColumnPriority);
    HRESULT GetColumnFromPropID(uint PropID, int* lColumnIndex);
    HRESULT Clear();
    HRESULT ClearRows();
    HRESULT Free();
    HRESULT IsCompleted();
    HRESULT Cancel();
    HRESULT Pause(BOOL fPause);
    HRESULT GetRowStatus(int lRowFirst, int cRows, ROWSTATUS* lpRowStatus);
    HRESULT GetColumnStatus(COLUMNSTATUS* lpColStatus);
}


