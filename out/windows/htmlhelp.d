module windows.htmlhelp;

public import system;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.displaydevices;
public import windows.search;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

struct HHN_NOTIFY
{
    NMHDR hdr;
    const(char)* pszUrl;
}

struct HH_POPUP
{
    int cbStruct;
    HINSTANCE hinst;
    uint idString;
    byte* pszText;
    POINT pt;
    uint clrForeground;
    uint clrBackground;
    RECT rcMargins;
    byte* pszFont;
}

struct HH_AKLINK
{
    int cbStruct;
    BOOL fReserved;
    byte* pszKeywords;
    byte* pszUrl;
    byte* pszMsgText;
    byte* pszMsgTitle;
    byte* pszWindow;
    BOOL fIndexOnFail;
}

struct HH_ENUM_IT
{
    int cbStruct;
    int iType;
    const(char)* pszCatName;
    const(char)* pszITName;
    const(char)* pszITDescription;
}

struct HH_ENUM_CAT
{
    int cbStruct;
    const(char)* pszCatName;
    const(char)* pszCatDescription;
}

struct HH_SET_INFOTYPE
{
    int cbStruct;
    const(char)* pszCatName;
    const(char)* pszInfoTypeName;
}

struct HH_FTS_QUERY
{
    int cbStruct;
    BOOL fUniCodeStrings;
    byte* pszSearchQuery;
    int iProximity;
    BOOL fStemmedSearch;
    BOOL fTitleOnly;
    BOOL fExecute;
    byte* pszWindow;
}

struct HH_WINTYPE
{
    int cbStruct;
    BOOL fUniCodeStrings;
    byte* pszType;
    uint fsValidMembers;
    uint fsWinProperties;
    byte* pszCaption;
    uint dwStyles;
    uint dwExStyles;
    RECT rcWindowPos;
    int nShowState;
    HWND hwndHelp;
    HWND hwndCaller;
    uint* paInfoTypes;
    HWND hwndToolBar;
    HWND hwndNavigation;
    HWND hwndHTML;
    int iNavWidth;
    RECT rcHTML;
    byte* pszToc;
    byte* pszIndex;
    byte* pszFile;
    byte* pszHome;
    uint fsToolBarFlags;
    BOOL fNotExpanded;
    int curNavType;
    int tabpos;
    int idNotify;
    ubyte tabOrder;
    int cHistory;
    byte* pszJump1;
    byte* pszJump2;
    byte* pszUrlJump1;
    byte* pszUrlJump2;
    RECT rcMinSize;
    int cbInfoTypes;
    byte* pszCustomTabs;
}

struct HHNTRACK
{
    NMHDR hdr;
    const(char)* pszCurUrl;
    int idAction;
    HH_WINTYPE* phhWinType;
}

enum HH_GPROPID
{
    HH_GPROPID_SINGLETHREAD = 1,
    HH_GPROPID_TOOLBAR_MARGIN = 2,
    HH_GPROPID_UI_LANGUAGE = 3,
    HH_GPROPID_CURRENT_SUBSET = 4,
    HH_GPROPID_CONTENT_LANGUAGE = 5,
}

struct HH_GLOBAL_PROPERTY
{
    HH_GPROPID id;
    VARIANT var;
}

struct CProperty
{
    uint dwPropID;
    uint cbData;
    uint dwType;
    _Anonymous_e__Union Anonymous;
    BOOL fPersist;
}

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
    HRESULT CreateObject(const(Guid)* rclsid, uint* pdwObjInstance);
    HRESULT GetObjectA(uint dwObjInstance, const(Guid)* riid, void** ppvObj);
    HRESULT GetObjectPersistence(const(wchar)* lpwszObject, uint dwObjInstance, void** ppvPersistence, BOOL fStream);
}

struct IITGroup
{
}

struct IITQuery
{
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

struct IITStopWordList
{
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
    HRESULT SetWordStemmer(const(Guid)* rclsid, IStemmer pStemmer);
    HRESULT GetWordStemmer(IStemmer* ppStemmer);
}

enum PRIORITY
{
    PRIORITY_LOW = 0,
    PRIORITY_NORMAL = 1,
    PRIORITY_HIGH = 2,
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

alias PFNCOLHEAPFREE = extern(Windows) int function(void* param0);
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
    HRESULT Set(int lRowIndex, int lColumnIndex, uint dwData);
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
    HRESULT GetColumn(int lColumnIndex, uint* PropID, uint* dwType, void** lpvDefaultValue, uint* cbSize, PRIORITY* ColumnPriority);
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

