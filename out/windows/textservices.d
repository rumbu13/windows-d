module windows.textservices;

public import windows.core;
public import windows.automation : BSTR, VARIANT;
public import windows.com : FORMATETC, HRESULT, IDataObject, IEnumGUID, IEnumString, IUnknown;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : HBITMAP, HICON;
public import windows.structuredstorage : IStream;
public import windows.systemservices : BOOL;
public import windows.windowsandmessaging : HWND, LPARAM, MSG, WPARAM;

extern(Windows):


// Enums


enum TsActiveSelEnd : int
{
    TS_AE_NONE  = 0x00000000,
    TS_AE_START = 0x00000001,
    TS_AE_END   = 0x00000002,
}

enum TsLayoutCode : int
{
    TS_LC_CREATE  = 0x00000000,
    TS_LC_CHANGE  = 0x00000001,
    TS_LC_DESTROY = 0x00000002,
}

enum TsRunType : int
{
    TS_RT_PLAIN  = 0x00000000,
    TS_RT_HIDDEN = 0x00000001,
    TS_RT_OPAQUE = 0x00000002,
}

enum TsGravity : int
{
    TS_GR_BACKWARD = 0x00000000,
    TS_GR_FORWARD  = 0x00000001,
}

enum TsShiftDir : int
{
    TS_SD_BACKWARD = 0x00000000,
    TS_SD_FORWARD  = 0x00000001,
}

enum : int
{
    TF_LBI_CLK_RIGHT = 0x00000001,
    TF_LBI_CLK_LEFT  = 0x00000002,
}
alias TfLBIClick = int;

enum TfLBBalloonStyle : int
{
    TF_LB_BALLOON_RECO = 0x00000000,
    TF_LB_BALLOON_SHOW = 0x00000001,
    TF_LB_BALLOON_MISS = 0x00000002,
}

enum TfAnchor : int
{
    TF_ANCHOR_START = 0x00000000,
    TF_ANCHOR_END   = 0x00000001,
}

enum TfActiveSelEnd : int
{
    TF_AE_NONE  = 0x00000000,
    TF_AE_START = 0x00000001,
    TF_AE_END   = 0x00000002,
}

enum TfLayoutCode : int
{
    TF_LC_CREATE  = 0x00000000,
    TF_LC_CHANGE  = 0x00000001,
    TF_LC_DESTROY = 0x00000002,
}

enum TfGravity : int
{
    TF_GRAVITY_BACKWARD = 0x00000000,
    TF_GRAVITY_FORWARD  = 0x00000001,
}

enum TfShiftDir : int
{
    TF_SD_BACKWARD = 0x00000000,
    TF_SD_FORWARD  = 0x00000001,
}

enum : int
{
    TF_LS_NONE     = 0x00000000,
    TF_LS_SOLID    = 0x00000001,
    TF_LS_DOT      = 0x00000002,
    TF_LS_DASH     = 0x00000003,
    TF_LS_SQUIGGLE = 0x00000004,
}
alias TF_DA_LINESTYLE = int;

enum : int
{
    TF_CT_NONE     = 0x00000000,
    TF_CT_SYSCOLOR = 0x00000001,
    TF_CT_COLORREF = 0x00000002,
}
alias TF_DA_COLORTYPE = int;

enum : int
{
    TF_ATTR_INPUT               = 0x00000000,
    TF_ATTR_TARGET_CONVERTED    = 0x00000001,
    TF_ATTR_CONVERTED           = 0x00000002,
    TF_ATTR_TARGET_NOTCONVERTED = 0x00000003,
    TF_ATTR_INPUT_ERROR         = 0x00000004,
    TF_ATTR_FIXEDCONVERTED      = 0x00000005,
    TF_ATTR_OTHER               = 0xffffffff,
}
alias TF_DA_ATTR_INFO = int;

enum TfCandidateResult : int
{
    CAND_FINALIZED = 0x00000000,
    CAND_SELECTED  = 0x00000001,
    CAND_CANCELED  = 0x00000002,
}

enum TfSapiObject : int
{
    GETIF_RESMGR           = 0x00000000,
    GETIF_RECOCONTEXT      = 0x00000001,
    GETIF_RECOGNIZER       = 0x00000002,
    GETIF_VOICE            = 0x00000003,
    GETIF_DICTGRAM         = 0x00000004,
    GETIF_RECOGNIZERNOINIT = 0x00000005,
}

enum TfIntegratableCandidateListSelectionStyle : int
{
    STYLE_ACTIVE_SELECTION  = 0x00000000,
    STYLE_IMPLIED_SELECTION = 0x00000001,
}

enum TKBLayoutType : int
{
    TKBLT_UNDEFINED = 0x00000000,
    TKBLT_CLASSIC   = 0x00000001,
    TKBLT_OPTIMIZED = 0x00000002,
}

enum InputScope : int
{
    IS_DEFAULT                       = 0x00000000,
    IS_URL                           = 0x00000001,
    IS_FILE_FULLFILEPATH             = 0x00000002,
    IS_FILE_FILENAME                 = 0x00000003,
    IS_EMAIL_USERNAME                = 0x00000004,
    IS_EMAIL_SMTPEMAILADDRESS        = 0x00000005,
    IS_LOGINNAME                     = 0x00000006,
    IS_PERSONALNAME_FULLNAME         = 0x00000007,
    IS_PERSONALNAME_PREFIX           = 0x00000008,
    IS_PERSONALNAME_GIVENNAME        = 0x00000009,
    IS_PERSONALNAME_MIDDLENAME       = 0x0000000a,
    IS_PERSONALNAME_SURNAME          = 0x0000000b,
    IS_PERSONALNAME_SUFFIX           = 0x0000000c,
    IS_ADDRESS_FULLPOSTALADDRESS     = 0x0000000d,
    IS_ADDRESS_POSTALCODE            = 0x0000000e,
    IS_ADDRESS_STREET                = 0x0000000f,
    IS_ADDRESS_STATEORPROVINCE       = 0x00000010,
    IS_ADDRESS_CITY                  = 0x00000011,
    IS_ADDRESS_COUNTRYNAME           = 0x00000012,
    IS_ADDRESS_COUNTRYSHORTNAME      = 0x00000013,
    IS_CURRENCY_AMOUNTANDSYMBOL      = 0x00000014,
    IS_CURRENCY_AMOUNT               = 0x00000015,
    IS_DATE_FULLDATE                 = 0x00000016,
    IS_DATE_MONTH                    = 0x00000017,
    IS_DATE_DAY                      = 0x00000018,
    IS_DATE_YEAR                     = 0x00000019,
    IS_DATE_MONTHNAME                = 0x0000001a,
    IS_DATE_DAYNAME                  = 0x0000001b,
    IS_DIGITS                        = 0x0000001c,
    IS_NUMBER                        = 0x0000001d,
    IS_ONECHAR                       = 0x0000001e,
    IS_PASSWORD                      = 0x0000001f,
    IS_TELEPHONE_FULLTELEPHONENUMBER = 0x00000020,
    IS_TELEPHONE_COUNTRYCODE         = 0x00000021,
    IS_TELEPHONE_AREACODE            = 0x00000022,
    IS_TELEPHONE_LOCALNUMBER         = 0x00000023,
    IS_TIME_FULLTIME                 = 0x00000024,
    IS_TIME_HOUR                     = 0x00000025,
    IS_TIME_MINORSEC                 = 0x00000026,
    IS_NUMBER_FULLWIDTH              = 0x00000027,
    IS_ALPHANUMERIC_HALFWIDTH        = 0x00000028,
    IS_ALPHANUMERIC_FULLWIDTH        = 0x00000029,
    IS_CURRENCY_CHINESE              = 0x0000002a,
    IS_BOPOMOFO                      = 0x0000002b,
    IS_HIRAGANA                      = 0x0000002c,
    IS_KATAKANA_HALFWIDTH            = 0x0000002d,
    IS_KATAKANA_FULLWIDTH            = 0x0000002e,
    IS_HANJA                         = 0x0000002f,
    IS_HANGUL_HALFWIDTH              = 0x00000030,
    IS_HANGUL_FULLWIDTH              = 0x00000031,
    IS_SEARCH                        = 0x00000032,
    IS_FORMULA                       = 0x00000033,
    IS_SEARCH_INCREMENTAL            = 0x00000034,
    IS_CHINESE_HALFWIDTH             = 0x00000035,
    IS_CHINESE_FULLWIDTH             = 0x00000036,
    IS_NATIVE_SCRIPT                 = 0x00000037,
    IS_YOMI                          = 0x00000038,
    IS_TEXT                          = 0x00000039,
    IS_CHAT                          = 0x0000003a,
    IS_NAME_OR_PHONENUMBER           = 0x0000003b,
    IS_EMAILNAME_OR_ADDRESS          = 0x0000003c,
    IS_PRIVATE                       = 0x0000003d,
    IS_MAPS                          = 0x0000003e,
    IS_NUMERIC_PASSWORD              = 0x0000003f,
    IS_NUMERIC_PIN                   = 0x00000040,
    IS_ALPHANUMERIC_PIN              = 0x00000041,
    IS_ALPHANUMERIC_PIN_SET          = 0x00000042,
    IS_FORMULA_NUMBER                = 0x00000043,
    IS_CHAT_WITHOUT_EMOJI            = 0x00000044,
    IS_PHRASELIST                    = 0xffffffff,
    IS_REGULAREXPRESSION             = 0xfffffffe,
    IS_SRGS                          = 0xfffffffd,
    IS_XML                           = 0xfffffffc,
    IS_ENUMSTRING                    = 0xfffffffb,
}

// Structs


struct TS_STATUS
{
    uint dwDynamicFlags;
    uint dwStaticFlags;
}

struct TS_TEXTCHANGE
{
    int acpStart;
    int acpOldEnd;
    int acpNewEnd;
}

struct TS_SELECTIONSTYLE
{
    TsActiveSelEnd ase;
    BOOL           fInterimChar;
}

struct TS_SELECTION_ACP
{
    int               acpStart;
    int               acpEnd;
    TS_SELECTIONSTYLE style;
}

struct TS_SELECTION_ANCHOR
{
    IAnchor           paStart;
    IAnchor           paEnd;
    TS_SELECTIONSTYLE style;
}

struct TS_ATTRVAL
{
    GUID    idAttr;
    uint    dwOverlapId;
    VARIANT varValue;
}

struct TS_RUNINFO
{
    uint      uCount;
    TsRunType type;
}

struct TF_LANGBARITEMINFO
{
    GUID       clsidService;
    GUID       guidItem;
    uint       dwStyle;
    uint       ulSort;
    ushort[32] szDescription;
}

struct TF_LBBALLOONINFO
{
    TfLBBalloonStyle style;
    BSTR             bstrText;
}

struct TF_PERSISTENT_PROPERTY_HEADER_ACP
{
    GUID guidType;
    int  ichStart;
    int  cch;
    uint cb;
    uint dwPrivate;
    GUID clsidTIP;
}

struct TF_LANGUAGEPROFILE
{
    GUID   clsid;
    ushort langid;
    GUID   catid;
    BOOL   fActive;
    GUID   guidProfile;
}

struct TF_SELECTIONSTYLE
{
    TfActiveSelEnd ase;
    BOOL           fInterimChar;
}

struct TF_SELECTION
{
    ITfRange          range;
    TF_SELECTIONSTYLE style;
}

struct TF_PROPERTYVAL
{
    GUID    guidId;
    VARIANT varValue;
}

struct TF_HALTCOND
{
    ITfRange pHaltRange;
    TfAnchor aHaltPos;
    uint     dwFlags;
}

struct TF_INPUTPROCESSORPROFILE
{
    uint      dwProfileType;
    ushort    langid;
    GUID      clsid;
    GUID      guidProfile;
    GUID      catid;
    ptrdiff_t hklSubstitute;
    uint      dwCaps;
    ptrdiff_t hkl;
    uint      dwFlags;
}

struct TF_PRESERVEDKEY
{
    uint uVKey;
    uint uModifiers;
}

struct TF_DA_COLOR
{
    TF_DA_COLORTYPE type;
    union
    {
        int  nIndex;
        uint cr;
    }
}

struct TF_DISPLAYATTRIBUTE
{
    TF_DA_COLOR     crText;
    TF_DA_COLOR     crBk;
    TF_DA_LINESTYLE lsStyle;
    BOOL            fBoldLine;
    TF_DA_COLOR     crLine;
    TF_DA_ATTR_INFO bAttr;
}

struct TF_LMLATTELEMENT
{
    uint dwFrameStart;
    uint dwFrameLen;
    uint dwFlags;
    union
    {
        int iCost;
    }
    BSTR bstrText;
}

// Functions

@DllImport("MsCtfMonitor")
HRESULT InitLocalMsCtfMonitor(uint dwFlags);

@DllImport("MsCtfMonitor")
HRESULT UninitLocalMsCtfMonitor();


// Interfaces

@GUID("B5F8FB3B-393F-4F7C-84CB-504924C2705A")
interface ITfMSAAControl : IUnknown
{
    HRESULT SystemEnableMSAA();
    HRESULT SystemDisableMSAA();
}

@GUID("28888FE3-C2A0-483A-A3EA-8CB1CE51FF3D")
interface ITextStoreACP : IUnknown
{
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, 
                    TS_TEXTCHANGE* pChange);
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, 
                                   int* pacpNext, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetEndACP(int* pacp);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    HRESULT GetWnd(uint vcView, HWND* phwnd);
}

@GUID("F86AD89F-5FE4-4B8D-BB9F-EF3797A84F1F")
interface ITextStoreACP2 : IUnknown
{
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, 
                    char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, 
                    TS_TEXTCHANGE* pChange);
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(int acpPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, 
                                  TS_TEXTCHANGE* pChange);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, 
                                      TS_TEXTCHANGE* pChange);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, 
                                   int* pacpNext, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetEndACP(int* pacp);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
}

@GUID("22D44C94-A419-4542-A272-AE26093ECECF")
interface ITextStoreACPSink : IUnknown
{
    HRESULT OnTextChange(uint dwFlags, const(TS_TEXTCHANGE)* pChange);
    HRESULT OnSelectionChange();
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    HRESULT OnStatusChange(uint dwFlags);
    HRESULT OnAttrsChange(int acpStart, int acpEnd, uint cAttrs, char* paAttrs);
    HRESULT OnLockGranted(uint dwLockFlags);
    HRESULT OnStartEditTransaction();
    HRESULT OnEndEditTransaction();
}

@GUID("0FEB7E34-5A60-4356-8EF7-ABDEC2FF7CF8")
interface IAnchor : IUnknown
{
    HRESULT SetGravity(TsGravity gravity);
    HRESULT GetGravity(TsGravity* pgravity);
    HRESULT IsEqual(IAnchor paWith, int* pfEqual);
    HRESULT Compare(IAnchor paWith, int* plResult);
    HRESULT Shift(uint dwFlags, int cchReq, int* pcch, IAnchor paHaltAnchor);
    HRESULT ShiftTo(IAnchor paSite);
    HRESULT ShiftRegion(uint dwFlags, TsShiftDir dir, int* pfNoRegion);
    HRESULT SetChangeHistoryMask(uint dwMask);
    HRESULT GetChangeHistory(uint* pdwHistory);
    HRESULT ClearChangeHistory();
    HRESULT Clone(IAnchor* ppaClone);
}

@GUID("9B2077B0-5F18-4DEC-BEE9-3CC722F5DFE0")
interface ITextStoreAnchor : IUnknown
{
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(IAnchor paTestStart, IAnchor paTestEnd, uint cch, IAnchor* ppaResultStart, 
                        IAnchor* ppaResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, char* pchText, uint cchReq, uint* pcch, 
                    BOOL fUpdateAnchor);
    HRESULT SetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, const(wchar)* pchText, uint cch);
    HRESULT GetFormattedText(IAnchor paStart, IAnchor paEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(uint dwFlags, IAnchor paPos, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    HRESULT InsertEmbedded(uint dwFlags, IAnchor paStart, IAnchor paEnd, IDataObject pDataObject);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, 
                                                uint dwFlags);
    HRESULT FindNextAttrTransition(IAnchor paStart, IAnchor paHalt, uint cFilterAttrs, char* paFilterAttrs, 
                                   uint dwFlags, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetStart(IAnchor* ppaStart);
    HRESULT GetEnd(IAnchor* ppaEnd);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetAnchorFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, IAnchor* ppaSite);
    HRESULT GetTextExt(uint vcView, IAnchor paStart, IAnchor paEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    HRESULT GetWnd(uint vcView, HWND* phwnd);
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, IAnchor* ppaStart, 
                                  IAnchor* ppaEnd);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, IAnchor* ppaStart, IAnchor* ppaEnd);
}

@GUID("AA80E905-2021-11D2-93E0-0060B067B86E")
interface ITextStoreAnchorSink : IUnknown
{
    HRESULT OnTextChange(uint dwFlags, IAnchor paStart, IAnchor paEnd);
    HRESULT OnSelectionChange();
    HRESULT OnLayoutChange(TsLayoutCode lcode, uint vcView);
    HRESULT OnStatusChange(uint dwFlags);
    HRESULT OnAttrsChange(IAnchor paStart, IAnchor paEnd, uint cAttrs, char* paAttrs);
    HRESULT OnLockGranted(uint dwLockFlags);
    HRESULT OnStartEditTransaction();
    HRESULT OnEndEditTransaction();
}

@GUID("87955690-E627-11D2-8DDB-00105A2799B5")
interface ITfLangBarMgr : IUnknown
{
    HRESULT AdviseEventSink(ITfLangBarEventSink pSink, HWND hwnd, uint dwFlags, uint* pdwCookie);
    HRESULT UnadviseEventSink(uint dwCookie);
    HRESULT GetThreadMarshalInterface(uint dwThreadId, uint dwType, const(GUID)* riid, IUnknown* ppunk);
    HRESULT GetThreadLangBarItemMgr(uint dwThreadId, ITfLangBarItemMgr* pplbi, uint* pdwThreadid);
    HRESULT GetInputProcessorProfiles(uint dwThreadId, ITfInputProcessorProfiles* ppaip, uint* pdwThreadid);
    HRESULT RestoreLastFocus(uint* pdwThreadId, BOOL fPrev);
    HRESULT SetModalInput(ITfLangBarEventSink pSink, uint dwThreadId, uint dwFlags);
    HRESULT ShowFloating(uint dwFlags);
    HRESULT GetShowFloatingStatus(uint* pdwFlags);
}

@GUID("18A4E900-E0AE-11D2-AFDD-00105A2799B5")
interface ITfLangBarEventSink : IUnknown
{
    HRESULT OnSetFocus(uint dwThreadId);
    HRESULT OnThreadTerminate(uint dwThreadId);
    HRESULT OnThreadItemChange(uint dwThreadId);
    HRESULT OnModalInput(uint dwThreadId, uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT ShowFloating(uint dwFlags);
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
}

@GUID("57DBE1A0-DE25-11D2-AFDD-00105A2799B5")
interface ITfLangBarItemSink : IUnknown
{
    HRESULT OnUpdate(uint dwFlags);
}

@GUID("583F34D0-DE25-11D2-AFDD-00105A2799B5")
interface IEnumTfLangBarItems : IUnknown
{
    HRESULT Clone(IEnumTfLangBarItems* ppEnum);
    HRESULT Next(uint ulCount, char* ppItem, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("BA468C55-9956-4FB1-A59D-52A7DD7CC6AA")
interface ITfLangBarItemMgr : IUnknown
{
    HRESULT EnumItems(IEnumTfLangBarItems* ppEnum);
    HRESULT GetItem(const(GUID)* rguid, ITfLangBarItem* ppItem);
    HRESULT AddItem(ITfLangBarItem punk);
    HRESULT RemoveItem(ITfLangBarItem punk);
    HRESULT AdviseItemSink(ITfLangBarItemSink punk, uint* pdwCookie, const(GUID)* rguidItem);
    HRESULT UnadviseItemSink(uint dwCookie);
    HRESULT GetItemFloatingRect(uint dwThreadId, const(GUID)* rguid, RECT* prc);
    HRESULT GetItemsStatus(uint ulCount, char* prgguid, char* pdwStatus);
    HRESULT GetItemNum(uint* pulCount);
    HRESULT GetItems(uint ulCount, char* ppItem, char* pInfo, char* pdwStatus, uint* pcFetched);
    HRESULT AdviseItemsSink(uint ulCount, char* ppunk, char* pguidItem, char* pdwCookie);
    HRESULT UnadviseItemsSink(uint ulCount, char* pdwCookie);
}

@GUID("73540D69-EDEB-4EE9-96C9-23AA30B25916")
interface ITfLangBarItem : IUnknown
{
    HRESULT GetInfo(TF_LANGBARITEMINFO* pInfo);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Show(BOOL fShow);
    HRESULT GetTooltipString(BSTR* pbstrToolTip);
}

@GUID("1449D9AB-13CF-4687-AA3E-8D8B18574396")
interface ITfSystemLangBarItemSink : IUnknown
{
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
}

@GUID("1E13E9EC-6B33-4D4A-B5EB-8A92F029F356")
interface ITfSystemLangBarItem : IUnknown
{
    HRESULT SetIcon(HICON hIcon);
    HRESULT SetTooltipString(char* pchToolTip, uint cch);
}

@GUID("5C4CE0E5-BA49-4B52-AC6B-3B397B4F701F")
interface ITfSystemLangBarItemText : IUnknown
{
    HRESULT SetItemText(const(wchar)* pch, uint cch);
    HRESULT GetItemText(BSTR* pbstrText);
}

@GUID("45672EB9-9059-46A2-838D-4530355F6A77")
interface ITfSystemDeviceTypeLangBarItem : IUnknown
{
    HRESULT SetIconMode(uint dwFlags);
    HRESULT GetIconMode(uint* pdwFlags);
}

@GUID("28C7F1D0-DE25-11D2-AFDD-00105A2799B5")
interface ITfLangBarItemButton : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
    HRESULT GetIcon(HICON* phIcon);
    HRESULT GetText(BSTR* pbstrText);
}

@GUID("A26A0525-3FAE-4FA0-89EE-88A964F9F1B5")
interface ITfLangBarItemBitmapButton : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
    HRESULT GetText(BSTR* pbstrText);
}

@GUID("73830352-D722-4179-ADA5-F045C98DF355")
interface ITfLangBarItemBitmap : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
}

@GUID("01C2D285-D3C7-4B7B-B5B5-D97411D0C283")
interface ITfLangBarItemBalloon : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT GetBalloonInfo(TF_LBBALLOONINFO* pInfo);
}

@GUID("6F8A98E4-AAA0-4F15-8C5B-07E0DF0A3DD8")
interface ITfMenu : IUnknown
{
    HRESULT AddMenuItem(uint uId, uint dwFlags, HBITMAP hbmp, HBITMAP hbmpMask, const(wchar)* pch, uint cch, 
                        ITfMenu* ppMenu);
}

@GUID("AA80E801-2021-11D2-93E0-0060B067B86E")
interface ITfThreadMgr : IUnknown
{
    HRESULT Activate(uint* ptid);
    HRESULT Deactivate();
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    HRESULT AssociateFocus(HWND hwnd, ITfDocumentMgr pdimNew, ITfDocumentMgr* ppdimPrev);
    HRESULT IsThreadFocus(int* pfThreadFocus);
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
}

@GUID("3E90ADE3-7594-4CB0-BB58-69628F5F458C")
interface ITfThreadMgrEx : ITfThreadMgr
{
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    HRESULT GetActiveFlags(uint* lpdwFlags);
}

@GUID("0AB198EF-6477-4EE8-8812-6780EDB82D5E")
interface ITfThreadMgr2 : IUnknown
{
    HRESULT Activate(uint* ptid);
    HRESULT Deactivate();
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    HRESULT IsThreadFocus(int* pfThreadFocus);
    HRESULT GetFunctionProvider(const(GUID)* clsid, ITfFunctionProvider* ppFuncProv);
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    HRESULT GetActiveFlags(uint* lpdwFlags);
    HRESULT SuspendKeystrokeHandling();
    HRESULT ResumeKeystrokeHandling();
}

@GUID("AA80E80E-2021-11D2-93E0-0060B067B86E")
interface ITfThreadMgrEventSink : IUnknown
{
    HRESULT OnInitDocumentMgr(ITfDocumentMgr pdim);
    HRESULT OnUninitDocumentMgr(ITfDocumentMgr pdim);
    HRESULT OnSetFocus(ITfDocumentMgr pdimFocus, ITfDocumentMgr pdimPrevFocus);
    HRESULT OnPushContext(ITfContext pic);
    HRESULT OnPopContext(ITfContext pic);
}

@GUID("0D2C969A-BC9C-437C-84EE-951C49B1A764")
interface ITfConfigureSystemKeystrokeFeed : IUnknown
{
    HRESULT DisableSystemKeystrokeFeed();
    HRESULT EnableSystemKeystrokeFeed();
}

@GUID("AA80E808-2021-11D2-93E0-0060B067B86E")
interface IEnumTfDocumentMgrs : IUnknown
{
    HRESULT Clone(IEnumTfDocumentMgrs* ppEnum);
    HRESULT Next(uint ulCount, char* rgDocumentMgr, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("AA80E7F4-2021-11D2-93E0-0060B067B86E")
interface ITfDocumentMgr : IUnknown
{
    HRESULT CreateContext(uint tidOwner, uint dwFlags, IUnknown punk, ITfContext* ppic, uint* pecTextStore);
    HRESULT Push(ITfContext pic);
    HRESULT Pop(uint dwFlags);
    HRESULT GetTop(ITfContext* ppic);
    HRESULT GetBase(ITfContext* ppic);
    HRESULT EnumContexts(IEnumTfContexts* ppEnum);
}

@GUID("8F1A7EA6-1654-4502-A86E-B2902344D507")
interface IEnumTfContexts : IUnknown
{
    HRESULT Clone(IEnumTfContexts* ppEnum);
    HRESULT Next(uint ulCount, char* rgContext, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("D7540241-F9A1-4364-BEFC-DBCD2C4395B7")
interface ITfCompositionView : IUnknown
{
    HRESULT GetOwnerClsid(GUID* pclsid);
    HRESULT GetRange(ITfRange* ppRange);
}

@GUID("5EFD22BA-7838-46CB-88E2-CADB14124F8F")
interface IEnumITfCompositionView : IUnknown
{
    HRESULT Clone(IEnumITfCompositionView* ppEnum);
    HRESULT Next(uint ulCount, char* rgCompositionView, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("20168D64-5A8F-4A5A-B7BD-CFA29F4D0FD9")
interface ITfComposition : IUnknown
{
    HRESULT GetRange(ITfRange* ppRange);
    HRESULT ShiftStart(uint ecWrite, ITfRange pNewStart);
    HRESULT ShiftEnd(uint ecWrite, ITfRange pNewEnd);
    HRESULT EndComposition(uint ecWrite);
}

@GUID("A781718C-579A-4B15-A280-32B8577ACC5E")
interface ITfCompositionSink : IUnknown
{
    HRESULT OnCompositionTerminated(uint ecWrite, ITfComposition pComposition);
}

@GUID("D40C8AAE-AC92-4FC7-9A11-0EE0E23AA39B")
interface ITfContextComposition : IUnknown
{
    HRESULT StartComposition(uint ecWrite, ITfRange pCompositionRange, ITfCompositionSink pSink, 
                             ITfComposition* ppComposition);
    HRESULT EnumCompositions(IEnumITfCompositionView* ppEnum);
    HRESULT FindComposition(uint ecRead, ITfRange pTestRange, IEnumITfCompositionView* ppEnum);
    HRESULT TakeOwnership(uint ecWrite, ITfCompositionView pComposition, ITfCompositionSink pSink, 
                          ITfComposition* ppComposition);
}

@GUID("86462810-593B-4916-9764-19C08E9CE110")
interface ITfContextOwnerCompositionServices : ITfContextComposition
{
    HRESULT TerminateComposition(ITfCompositionView pComposition);
}

@GUID("5F20AA40-B57A-4F34-96AB-3576F377CC79")
interface ITfContextOwnerCompositionSink : IUnknown
{
    HRESULT OnStartComposition(ITfCompositionView pComposition, int* pfOk);
    HRESULT OnUpdateComposition(ITfCompositionView pComposition, ITfRange pRangeNew);
    HRESULT OnEndComposition(ITfCompositionView pComposition);
}

@GUID("2433BF8E-0F9B-435C-BA2C-180611978C30")
interface ITfContextView : IUnknown
{
    HRESULT GetRangeFromPoint(uint ec, const(POINT)* ppt, uint dwFlags, ITfRange* ppRange);
    HRESULT GetTextExt(uint ec, ITfRange pRange, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(RECT* prc);
    HRESULT GetWnd(HWND* phwnd);
}

@GUID("F0C0F8DD-CF38-44E1-BB0F-68CF0D551C78")
interface IEnumTfContextViews : IUnknown
{
    HRESULT Clone(IEnumTfContextViews* ppEnum);
    HRESULT Next(uint ulCount, char* rgViews, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("AA80E7FD-2021-11D2-93E0-0060B067B86E")
interface ITfContext : IUnknown
{
    HRESULT RequestEditSession(uint tid, ITfEditSession pes, uint dwFlags, int* phrSession);
    HRESULT InWriteSession(uint tid, int* pfWriteSession);
    HRESULT GetSelection(uint ec, uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ec, uint ulCount, char* pSelection);
    HRESULT GetStart(uint ec, ITfRange* ppStart);
    HRESULT GetEnd(uint ec, ITfRange* ppEnd);
    HRESULT GetActiveView(ITfContextView* ppView);
    HRESULT EnumViews(IEnumTfContextViews* ppEnum);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT GetProperty(const(GUID)* guidProp, ITfProperty* ppProp);
    HRESULT GetAppProperty(const(GUID)* guidProp, ITfReadOnlyProperty* ppProp);
    HRESULT TrackProperties(char* prgProp, uint cProp, char* prgAppProp, uint cAppProp, 
                            ITfReadOnlyProperty* ppProperty);
    HRESULT EnumProperties(IEnumTfProperties* ppEnum);
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppDm);
    HRESULT CreateRangeBackup(uint ec, ITfRange pRange, ITfRangeBackup* ppBackup);
}

@GUID("0FAB9BDB-D250-4169-84E5-6BE118FDD7A8")
interface ITfQueryEmbedded : IUnknown
{
    HRESULT QueryInsertEmbedded(const(GUID)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
}

@GUID("55CE16BA-3014-41C1-9CEB-FADE1446AC6C")
interface ITfInsertAtSelection : IUnknown
{
    HRESULT InsertTextAtSelection(uint ec, uint dwFlags, const(wchar)* pchText, int cch, ITfRange* ppRange);
    HRESULT InsertEmbeddedAtSelection(uint ec, uint dwFlags, IDataObject pDataObject, ITfRange* ppRange);
}

@GUID("01689689-7ACB-4E9B-AB7C-7EA46B12B522")
interface ITfCleanupContextSink : IUnknown
{
    HRESULT OnCleanupContext(uint ecWrite, ITfContext pic);
}

@GUID("45C35144-154E-4797-BED8-D33AE7BF8794")
interface ITfCleanupContextDurationSink : IUnknown
{
    HRESULT OnStartCleanupContext();
    HRESULT OnEndCleanupContext();
}

@GUID("17D49A3D-F8B8-4B2F-B254-52319DD64C53")
interface ITfReadOnlyProperty : IUnknown
{
    HRESULT GetType(GUID* pguid);
    HRESULT EnumRanges(uint ec, IEnumTfRanges* ppEnum, ITfRange pTargetRange);
    HRESULT GetValue(uint ec, ITfRange pRange, VARIANT* pvarValue);
    HRESULT GetContext(ITfContext* ppContext);
}

@GUID("8ED8981B-7C10-4D7D-9FB3-AB72E9C75F72")
interface IEnumTfPropertyValue : IUnknown
{
    HRESULT Clone(IEnumTfPropertyValue* ppEnum);
    HRESULT Next(uint ulCount, char* rgValues, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("09D146CD-A544-4132-925B-7AFA8EF322D0")
interface ITfMouseTracker : IUnknown
{
    HRESULT AdviseMouseSink(ITfRange range, ITfMouseSink pSink, uint* pdwCookie);
    HRESULT UnadviseMouseSink(uint dwCookie);
}

@GUID("3BDD78E2-C16E-47FD-B883-CE6FACC1A208")
interface ITfMouseTrackerACP : IUnknown
{
    HRESULT AdviseMouseSink(ITfRangeACP range, ITfMouseSink pSink, uint* pdwCookie);
    HRESULT UnadviseMouseSink(uint dwCookie);
}

@GUID("A1ADAAA2-3A24-449D-AC96-5183E7F5C217")
interface ITfMouseSink : IUnknown
{
    HRESULT OnMouseEvent(uint uEdge, uint uQuadrant, uint dwBtnStatus, int* pfEaten);
}

@GUID("42D4D099-7C1A-4A89-B836-6C6F22160DF0")
interface ITfEditRecord : IUnknown
{
    HRESULT GetSelectionStatus(int* pfChanged);
    HRESULT GetTextAndPropertyUpdates(uint dwFlags, char* prgProperties, uint cProperties, IEnumTfRanges* ppEnum);
}

@GUID("8127D409-CCD3-4683-967A-B43D5B482BF7")
interface ITfTextEditSink : IUnknown
{
    HRESULT OnEndEdit(ITfContext pic, uint ecReadOnly, ITfEditRecord pEditRecord);
}

@GUID("2AF2D06A-DD5B-4927-A0B4-54F19C91FADE")
interface ITfTextLayoutSink : IUnknown
{
    HRESULT OnLayoutChange(ITfContext pic, TfLayoutCode lcode, ITfContextView pView);
}

@GUID("6B7D8D73-B267-4F69-B32E-1CA321CE4F45")
interface ITfStatusSink : IUnknown
{
    HRESULT OnStatusChange(ITfContext pic, uint dwFlags);
}

@GUID("708FBF70-B520-416B-B06C-2C41AB44F8BA")
interface ITfEditTransactionSink : IUnknown
{
    HRESULT OnStartEditTransaction(ITfContext pic);
    HRESULT OnEndEditTransaction(ITfContext pic);
}

@GUID("AA80E80C-2021-11D2-93E0-0060B067B86E")
interface ITfContextOwner : IUnknown
{
    HRESULT GetACPFromPoint(const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(RECT* prc);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT GetWnd(HWND* phwnd);
    HRESULT GetAttribute(const(GUID)* rguidAttribute, VARIANT* pvarValue);
}

@GUID("B23EB630-3E1C-11D3-A745-0050040AB407")
interface ITfContextOwnerServices : IUnknown
{
    HRESULT OnLayoutChange();
    HRESULT OnStatusChange(uint dwFlags);
    HRESULT OnAttributeChange(const(GUID)* rguidAttribute);
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    HRESULT ForceLoadProperty(ITfProperty pProp);
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

@GUID("0552BA5D-C835-4934-BF50-846AAA67432F")
interface ITfContextKeyEventSink : IUnknown
{
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
}

@GUID("AA80E803-2021-11D2-93E0-0060B067B86E")
interface ITfEditSession : IUnknown
{
    HRESULT DoEditSession(uint ec);
}

@GUID("AA80E7FF-2021-11D2-93E0-0060B067B86E")
interface ITfRange : IUnknown
{
    HRESULT GetText(uint ec, uint dwFlags, char* pchText, uint cchMax, uint* pcch);
    HRESULT SetText(uint ec, uint dwFlags, const(wchar)* pchText, int cch);
    HRESULT GetFormattedText(uint ec, IDataObject* ppDataObject);
    HRESULT GetEmbedded(uint ec, const(GUID)* rguidService, const(GUID)* riid, IUnknown* ppunk);
    HRESULT InsertEmbedded(uint ec, uint dwFlags, IDataObject pDataObject);
    HRESULT ShiftStart(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    HRESULT ShiftEnd(uint ec, int cchReq, int* pcch, const(TF_HALTCOND)* pHalt);
    HRESULT ShiftStartToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    HRESULT ShiftEndToRange(uint ec, ITfRange pRange, TfAnchor aPos);
    HRESULT ShiftStartRegion(uint ec, TfShiftDir dir, int* pfNoRegion);
    HRESULT ShiftEndRegion(uint ec, TfShiftDir dir, int* pfNoRegion);
    HRESULT IsEmpty(uint ec, int* pfEmpty);
    HRESULT Collapse(uint ec, TfAnchor aPos);
    HRESULT IsEqualStart(uint ec, ITfRange pWith, TfAnchor aPos, int* pfEqual);
    HRESULT IsEqualEnd(uint ec, ITfRange pWith, TfAnchor aPos, int* pfEqual);
    HRESULT CompareStart(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    HRESULT CompareEnd(uint ec, ITfRange pWith, TfAnchor aPos, int* plResult);
    HRESULT AdjustForInsert(uint ec, uint cchInsert, int* pfInsertOk);
    HRESULT GetGravity(TfGravity* pgStart, TfGravity* pgEnd);
    HRESULT SetGravity(uint ec, TfGravity gStart, TfGravity gEnd);
    HRESULT Clone(ITfRange* ppClone);
    HRESULT GetContext(ITfContext* ppContext);
}

@GUID("057A6296-029B-4154-B79A-0D461D4EA94C")
interface ITfRangeACP : ITfRange
{
    HRESULT GetExtent(int* pacpAnchor, int* pcch);
    HRESULT SetExtent(int acpAnchor, int cch);
}

@GUID("AA80E901-2021-11D2-93E0-0060B067B86E")
interface ITextStoreACPServices : IUnknown
{
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, 
                        ITfPersistentPropertyLoaderACP pLoader);
    HRESULT ForceLoadProperty(ITfProperty pProp);
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

@GUID("463A506D-6992-49D2-9B88-93D55E70BB16")
interface ITfRangeBackup : IUnknown
{
    HRESULT Restore(uint ec, ITfRange pRange);
}

@GUID("6834B120-88CB-11D2-BF45-00105A2799B5")
interface ITfPropertyStore : IUnknown
{
    HRESULT GetType(GUID* pguid);
    HRESULT GetDataType(uint* pdwReserved);
    HRESULT GetData(VARIANT* pvarValue);
    HRESULT OnTextUpdated(uint dwFlags, ITfRange pRangeNew, int* pfAccept);
    HRESULT Shrink(ITfRange pRangeNew, int* pfFree);
    HRESULT Divide(ITfRange pRangeThis, ITfRange pRangeNew, ITfPropertyStore* ppPropStore);
    HRESULT Clone(ITfPropertyStore* pPropStore);
    HRESULT GetPropertyRangeCreator(GUID* pclsid);
    HRESULT Serialize(IStream pStream, uint* pcb);
}

@GUID("F99D3F40-8E32-11D2-BF46-00105A2799B5")
interface IEnumTfRanges : IUnknown
{
    HRESULT Clone(IEnumTfRanges* ppEnum);
    HRESULT Next(uint ulCount, char* ppRange, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("2463FBF0-B0AF-11D2-AFC5-00105A2799B5")
interface ITfCreatePropertyStore : IUnknown
{
    HRESULT IsStoreSerializable(const(GUID)* guidProp, ITfRange pRange, ITfPropertyStore pPropStore, 
                                int* pfSerializable);
    HRESULT CreatePropertyStore(const(GUID)* guidProp, ITfRange pRange, uint cb, IStream pStream, 
                                ITfPropertyStore* ppStore);
}

@GUID("4EF89150-0807-11D3-8DF0-00105A2799B5")
interface ITfPersistentPropertyLoaderACP : IUnknown
{
    HRESULT LoadProperty(const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream* ppStream);
}

@GUID("E2449660-9542-11D2-BF46-00105A2799B5")
interface ITfProperty : ITfReadOnlyProperty
{
    HRESULT FindRange(uint ec, ITfRange pRange, ITfRange* ppRange, TfAnchor aPos);
    HRESULT SetValueStore(uint ec, ITfRange pRange, ITfPropertyStore pPropStore);
    HRESULT SetValue(uint ec, ITfRange pRange, const(VARIANT)* pvarValue);
    HRESULT Clear(uint ec, ITfRange pRange);
}

@GUID("19188CB0-ACA9-11D2-AFC5-00105A2799B5")
interface IEnumTfProperties : IUnknown
{
    HRESULT Clone(IEnumTfProperties* ppEnum);
    HRESULT Next(uint ulCount, char* ppProp, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("BB08F7A9-607A-4384-8623-056892B64371")
interface ITfCompartment : IUnknown
{
    HRESULT SetValue(uint tid, const(VARIANT)* pvarValue);
    HRESULT GetValue(VARIANT* pvarValue);
}

@GUID("743ABD5F-F26D-48DF-8CC5-238492419B64")
interface ITfCompartmentEventSink : IUnknown
{
    HRESULT OnChange(const(GUID)* rguid);
}

@GUID("7DCF57AC-18AD-438B-824D-979BFFB74B7C")
interface ITfCompartmentMgr : IUnknown
{
    HRESULT GetCompartment(const(GUID)* rguid, ITfCompartment* ppcomp);
    HRESULT ClearCompartment(uint tid, const(GUID)* rguid);
    HRESULT EnumCompartments(IEnumGUID* ppEnum);
}

@GUID("DB593490-098F-11D3-8DF0-00105A2799B5")
interface ITfFunction : IUnknown
{
    HRESULT GetDisplayName(BSTR* pbstrName);
}

@GUID("101D6610-0990-11D3-8DF0-00105A2799B5")
interface ITfFunctionProvider : IUnknown
{
    HRESULT GetType(GUID* pguid);
    HRESULT GetDescription(BSTR* pbstrDesc);
    HRESULT GetFunction(const(GUID)* rguid, const(GUID)* riid, IUnknown* ppunk);
}

@GUID("E4B24DB0-0990-11D3-8DF0-00105A2799B5")
interface IEnumTfFunctionProviders : IUnknown
{
    HRESULT Clone(IEnumTfFunctionProviders* ppEnum);
    HRESULT Next(uint ulCount, char* ppCmdobj, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("1F02B6C5-7842-4EE6-8A0B-9A24183A95CA")
interface ITfInputProcessorProfiles : IUnknown
{
    HRESULT Register(const(GUID)* rclsid);
    HRESULT Unregister(const(GUID)* rclsid);
    HRESULT AddLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(wchar)* pchDesc, 
                               uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex);
    HRESULT RemoveLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile);
    HRESULT EnumInputProcessorInfo(IEnumGUID* ppEnum);
    HRESULT GetDefaultLanguageProfile(ushort langid, const(GUID)* catid, GUID* pclsid, GUID* pguidProfile);
    HRESULT SetDefaultLanguageProfile(ushort langid, const(GUID)* rclsid, const(GUID)* guidProfiles);
    HRESULT ActivateLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfiles);
    HRESULT GetActiveLanguageProfile(const(GUID)* rclsid, ushort* plangid, GUID* pguidProfile);
    HRESULT GetLanguageProfileDescription(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          BSTR* pbstrProfile);
    HRESULT GetCurrentLanguage(ushort* plangid);
    HRESULT ChangeCurrentLanguage(ushort langid);
    HRESULT GetLanguageList(char* ppLangId, uint* pulCount);
    HRESULT EnumLanguageProfiles(ushort langid, IEnumTfLanguageProfiles* ppEnum);
    HRESULT EnableLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, BOOL fEnable);
    HRESULT IsEnabledLanguageProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, int* pfEnable);
    HRESULT EnableLanguageProfileByDefault(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                           BOOL fEnable);
    HRESULT SubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, ptrdiff_t hKL);
}

@GUID("892F230F-FE00-4A41-A98E-FCD6DE0D35EF")
interface ITfInputProcessorProfilesEx : ITfInputProcessorProfiles
{
    HRESULT SetLanguageProfileDisplayName(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                          const(wchar)* pchFile, uint cchFile, uint uResId);
}

@GUID("4FD67194-1002-4513-BFF2-C0DDF6258552")
interface ITfInputProcessorProfileSubstituteLayout : IUnknown
{
    HRESULT GetSubstituteKeyboardLayout(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, 
                                        ptrdiff_t* phKL);
}

@GUID("B246CB75-A93E-4652-BF8C-B3FE0CFD7E57")
interface ITfActiveLanguageProfileNotifySink : IUnknown
{
    HRESULT OnActivated(const(GUID)* clsid, const(GUID)* guidProfile, BOOL fActivated);
}

@GUID("3D61BF11-AC5F-42C8-A4CB-931BCC28C744")
interface IEnumTfLanguageProfiles : IUnknown
{
    HRESULT Clone(IEnumTfLanguageProfiles* ppEnum);
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("43C9FE15-F494-4C17-9DE2-B8A4AC350AA8")
interface ITfLanguageProfileNotifySink : IUnknown
{
    HRESULT OnLanguageChange(ushort langid, int* pfAccept);
    HRESULT OnLanguageChanged();
}

@GUID("71C6E74C-0F28-11D8-A82A-00065B84435C")
interface ITfInputProcessorProfileMgr : IUnknown
{
    HRESULT ActivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                            ptrdiff_t hkl, uint dwFlags);
    HRESULT DeactivateProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                              ptrdiff_t hkl, uint dwFlags);
    HRESULT GetProfile(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* guidProfile, 
                       ptrdiff_t hkl, TF_INPUTPROCESSORPROFILE* pProfile);
    HRESULT EnumProfiles(ushort langid, IEnumTfInputProcessorProfiles* ppEnum);
    HRESULT ReleaseInputProcessor(const(GUID)* rclsid, uint dwFlags);
    HRESULT RegisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, const(wchar)* pchDesc, 
                            uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex, 
                            ptrdiff_t hklsubstitute, uint dwPreferredLayout, BOOL bEnabledByDefault, uint dwFlags);
    HRESULT UnregisterProfile(const(GUID)* rclsid, ushort langid, const(GUID)* guidProfile, uint dwFlags);
    HRESULT GetActiveProfile(const(GUID)* catid, TF_INPUTPROCESSORPROFILE* pProfile);
}

@GUID("71C6E74D-0F28-11D8-A82A-00065B84435C")
interface IEnumTfInputProcessorProfiles : IUnknown
{
    HRESULT Clone(IEnumTfInputProcessorProfiles* ppEnum);
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("71C6E74E-0F28-11D8-A82A-00065B84435C")
interface ITfInputProcessorProfileActivationSink : IUnknown
{
    HRESULT OnActivated(uint dwProfileType, ushort langid, const(GUID)* clsid, const(GUID)* catid, 
                        const(GUID)* guidProfile, ptrdiff_t hkl, uint dwFlags);
}

@GUID("AA80E7F0-2021-11D2-93E0-0060B067B86E")
interface ITfKeystrokeMgr : IUnknown
{
    HRESULT AdviseKeyEventSink(uint tid, ITfKeyEventSink pSink, BOOL fForeground);
    HRESULT UnadviseKeyEventSink(uint tid);
    HRESULT GetForeground(GUID* pclsid);
    HRESULT TestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT TestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT KeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT KeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT GetPreservedKey(ITfContext pic, const(TF_PRESERVEDKEY)* pprekey, GUID* pguid);
    HRESULT IsPreservedKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey, int* pfRegistered);
    HRESULT PreserveKey(uint tid, const(GUID)* rguid, const(TF_PRESERVEDKEY)* prekey, const(wchar)* pchDesc, 
                        uint cchDesc);
    HRESULT UnpreserveKey(const(GUID)* rguid, const(TF_PRESERVEDKEY)* pprekey);
    HRESULT SetPreservedKeyDescription(const(GUID)* rguid, const(wchar)* pchDesc, uint cchDesc);
    HRESULT GetPreservedKeyDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    HRESULT SimulatePreservedKey(ITfContext pic, const(GUID)* rguid, int* pfEaten);
}

@GUID("AA80E7F5-2021-11D2-93E0-0060B067B86E")
interface ITfKeyEventSink : IUnknown
{
    HRESULT OnSetFocus(BOOL fForeground);
    HRESULT OnTestKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnPreservedKey(ITfContext pic, const(GUID)* rguid, int* pfEaten);
}

@GUID("1CD4C13B-1C36-4191-A70A-7F3E611F367D")
interface ITfKeyTraceEventSink : IUnknown
{
    HRESULT OnKeyTraceDown(WPARAM wParam, LPARAM lParam);
    HRESULT OnKeyTraceUp(WPARAM wParam, LPARAM lParam);
}

@GUID("6F77C993-D2B1-446E-853E-5912EFC8A286")
interface ITfPreservedKeyNotifySink : IUnknown
{
    HRESULT OnUpdated(const(TF_PRESERVEDKEY)* pprekey);
}

@GUID("8F1B8AD8-0B6B-4874-90C5-BD76011E8F7C")
interface ITfMessagePump : IUnknown
{
    HRESULT PeekMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         int* pfResult);
    HRESULT GetMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
    HRESULT PeekMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, 
                         int* pfResult);
    HRESULT GetMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
}

@GUID("C0F1DB0C-3A20-405C-A303-96B6010A885F")
interface ITfThreadFocusSink : IUnknown
{
    HRESULT OnSetThreadFocus();
    HRESULT OnKillThreadFocus();
}

@GUID("AA80E7F7-2021-11D2-93E0-0060B067B86E")
interface ITfTextInputProcessor : IUnknown
{
    HRESULT Activate(ITfThreadMgr ptim, uint tid);
    HRESULT Deactivate();
}

@GUID("6E4E2102-F9CD-433D-B496-303CE03A6507")
interface ITfTextInputProcessorEx : ITfTextInputProcessor
{
    HRESULT ActivateEx(ITfThreadMgr ptim, uint tid, uint dwFlags);
}

@GUID("D60A7B49-1B9F-4BE2-B702-47E9DC05DEC3")
interface ITfClientId : IUnknown
{
    HRESULT GetClientId(const(GUID)* rclsid, uint* ptid);
}

@GUID("70528852-2F26-4AEA-8C96-215150578932")
interface ITfDisplayAttributeInfo : IUnknown
{
    HRESULT GetGUID(GUID* pguid);
    HRESULT GetDescription(BSTR* pbstrDesc);
    HRESULT GetAttributeInfo(TF_DISPLAYATTRIBUTE* pda);
    HRESULT SetAttributeInfo(const(TF_DISPLAYATTRIBUTE)* pda);
    HRESULT Reset();
}

@GUID("7CEF04D7-CB75-4E80-A7AB-5F5BC7D332DE")
interface IEnumTfDisplayAttributeInfo : IUnknown
{
    HRESULT Clone(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT Next(uint ulCount, char* rgInfo, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("FEE47777-163C-4769-996A-6E9C50AD8F54")
interface ITfDisplayAttributeProvider : IUnknown
{
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo);
}

@GUID("8DED7393-5DB1-475C-9E71-A39111B0FF67")
interface ITfDisplayAttributeMgr : IUnknown
{
    HRESULT OnUpdateInfo();
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT GetDisplayAttributeInfo(const(GUID)* guid, ITfDisplayAttributeInfo* ppInfo, GUID* pclsidOwner);
}

@GUID("AD56F402-E162-4F25-908F-7D577CF9BDA9")
interface ITfDisplayAttributeNotifySink : IUnknown
{
    HRESULT OnUpdateInfo();
}

@GUID("C3ACEFB5-F69D-4905-938F-FCADCF4BE830")
interface ITfCategoryMgr : IUnknown
{
    HRESULT RegisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    HRESULT UnregisterCategory(const(GUID)* rclsid, const(GUID)* rcatid, const(GUID)* rguid);
    HRESULT EnumCategoriesInItem(const(GUID)* rguid, IEnumGUID* ppEnum);
    HRESULT EnumItemsInCategory(const(GUID)* rcatid, IEnumGUID* ppEnum);
    HRESULT FindClosestCategory(const(GUID)* rguid, GUID* pcatid, const(GUID)** ppcatidList, uint ulCount);
    HRESULT RegisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid, const(wchar)* pchDesc, uint cch);
    HRESULT UnregisterGUIDDescription(const(GUID)* rclsid, const(GUID)* rguid);
    HRESULT GetGUIDDescription(const(GUID)* rguid, BSTR* pbstrDesc);
    HRESULT RegisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid, uint dw);
    HRESULT UnregisterGUIDDWORD(const(GUID)* rclsid, const(GUID)* rguid);
    HRESULT GetGUIDDWORD(const(GUID)* rguid, uint* pdw);
    HRESULT RegisterGUID(const(GUID)* rguid, uint* pguidatom);
    HRESULT GetGUID(uint guidatom, GUID* pguid);
    HRESULT IsEqualTfGuidAtom(uint guidatom, const(GUID)* rguid, int* pfEqual);
}

@GUID("4EA48A35-60AE-446F-8FD6-E6A8D82459F7")
interface ITfSource : IUnknown
{
    HRESULT AdviseSink(const(GUID)* riid, IUnknown punk, uint* pdwCookie);
    HRESULT UnadviseSink(uint dwCookie);
}

@GUID("73131F9C-56A9-49DD-B0EE-D046633F7528")
interface ITfSourceSingle : IUnknown
{
    HRESULT AdviseSingleSink(uint tid, const(GUID)* riid, IUnknown punk);
    HRESULT UnadviseSingleSink(uint tid, const(GUID)* riid);
}

@GUID("EA1EA135-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElementMgr : IUnknown
{
    HRESULT BeginUIElement(ITfUIElement pElement, int* pbShow, uint* pdwUIElementId);
    HRESULT UpdateUIElement(uint dwUIElementId);
    HRESULT EndUIElement(uint dwUIElementId);
    HRESULT GetUIElement(uint dwUIELementId, ITfUIElement* ppElement);
    HRESULT EnumUIElements(IEnumTfUIElements* ppEnum);
}

@GUID("887AA91E-ACBA-4931-84DA-3C5208CF543F")
interface IEnumTfUIElements : IUnknown
{
    HRESULT Clone(IEnumTfUIElements* ppEnum);
    HRESULT Next(uint ulCount, ITfUIElement* ppElement, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("EA1EA136-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElementSink : IUnknown
{
    HRESULT BeginUIElement(uint dwUIElementId, int* pbShow);
    HRESULT UpdateUIElement(uint dwUIElementId);
    HRESULT EndUIElement(uint dwUIElementId);
}

@GUID("EA1EA137-19DF-11D7-A6D2-00065B84435C")
interface ITfUIElement : IUnknown
{
    HRESULT GetDescription(BSTR* pbstrDescription);
    HRESULT GetGUID(GUID* pguid);
    HRESULT Show(BOOL bShow);
    HRESULT IsShown(int* pbShow);
}

@GUID("EA1EA138-19DF-11D7-A6D2-00065B84435C")
interface ITfCandidateListUIElement : ITfUIElement
{
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
    HRESULT GetCount(uint* puCount);
    HRESULT GetSelection(uint* puIndex);
    HRESULT GetString(uint uIndex, BSTR* pstr);
    HRESULT GetPageIndex(uint* pIndex, uint uSize, uint* puPageCnt);
    HRESULT SetPageIndex(uint* pIndex, uint uPageCnt);
    HRESULT GetCurrentPage(uint* puPage);
}

@GUID("85FAD185-58CE-497A-9460-355366B64B9A")
interface ITfCandidateListUIElementBehavior : ITfCandidateListUIElement
{
    HRESULT SetSelection(uint nIndex);
    HRESULT Finalize();
    HRESULT Abort();
}

@GUID("EA1EA139-19DF-11D7-A6D2-00065B84435C")
interface ITfReadingInformationUIElement : ITfUIElement
{
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    HRESULT GetContext(ITfContext* ppic);
    HRESULT GetString(BSTR* pstr);
    HRESULT GetMaxReadingStringLength(uint* pcchMax);
    HRESULT GetErrorIndex(uint* pErrorIndex);
    HRESULT IsVerticalOrderPreferred(int* pfVertical);
}

@GUID("858F956A-972F-42A2-A2F2-0321E1ABE209")
interface ITfTransitoryExtensionUIElement : ITfUIElement
{
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
}

@GUID("A615096F-1C57-4813-8A15-55EE6E5A839C")
interface ITfTransitoryExtensionSink : IUnknown
{
    HRESULT OnTransitoryExtensionUpdated(ITfContext pic, uint ecReadOnly, ITfRange pResultRange, 
                                         ITfRange pCompositionRange, int* pfDeleteResultRange);
}

@GUID("52B18B5C-555D-46B2-B00A-FA680144FBDB")
interface ITfToolTipUIElement : ITfUIElement
{
    HRESULT GetString(BSTR* pstr);
}

@GUID("151D69F0-86F4-4674-B721-56911E797F47")
interface ITfReverseConversionList : IUnknown
{
    HRESULT GetLength(uint* puIndex);
    HRESULT GetString(uint uIndex, BSTR* pbstr);
}

@GUID("A415E162-157D-417D-8A8C-0AB26C7D2781")
interface ITfReverseConversion : IUnknown
{
    HRESULT DoReverseConversion(const(wchar)* lpstr, ITfReverseConversionList* ppList);
}

@GUID("B643C236-C493-41B6-ABB3-692412775CC4")
interface ITfReverseConversionMgr : IUnknown
{
    HRESULT GetReverseConversion(ushort langid, const(GUID)* guidProfile, uint dwflag, 
                                 ITfReverseConversion* ppReverseConversion);
}

@GUID("581F317E-FD9D-443F-B972-ED00467C5D40")
interface ITfCandidateString : IUnknown
{
    HRESULT GetString(BSTR* pbstr);
    HRESULT GetIndex(uint* pnIndex);
}

@GUID("DEFB1926-6C80-4CE8-87D4-D6B72B812BDE")
interface IEnumTfCandidates : IUnknown
{
    HRESULT Clone(IEnumTfCandidates* ppEnum);
    HRESULT Next(uint ulCount, char* ppCand, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("A3AD50FB-9BDB-49E3-A843-6C76520FBF5D")
interface ITfCandidateList : IUnknown
{
    HRESULT EnumCandidates(IEnumTfCandidates* ppEnum);
    HRESULT GetCandidate(uint nIndex, ITfCandidateString* ppCand);
    HRESULT GetCandidateNum(uint* pnCnt);
    HRESULT SetResult(uint nIndex, TfCandidateResult imcr);
}

@GUID("4CEA93C0-0A58-11D3-8DF0-00105A2799B5")
interface ITfFnReconversion : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfConvertable);
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    HRESULT Reconvert(ITfRange pRange);
}

@GUID("A3A416A4-0F64-11D3-B5B7-00C04FC324A1")
interface ITfFnPlayBack : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfPlayable);
    HRESULT Play(ITfRange pRange);
}

@GUID("A87A8574-A6C1-4E15-99F0-3D3965F548EB")
interface ITfFnLangProfileUtil : ITfFunction
{
    HRESULT RegisterActiveProfiles();
    HRESULT IsProfileAvailableForLang(ushort langid, int* pfAvailable);
}

@GUID("88F567C6-1757-49F8-A1B2-89234C1EEFF9")
interface ITfFnConfigure : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile);
}

@GUID("BB95808A-6D8F-4BCA-8400-5390B586AEDF")
interface ITfFnConfigureRegisterWord : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

@GUID("B5E26FF5-D7AD-4304-913F-21A2ED95A1B0")
interface ITfFnConfigureRegisterEudc : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(GUID)* rguidProfile, BSTR bstrRegistered);
}

@GUID("5AB1D30C-094D-4C29-8EA5-0BF59BE87BF3")
interface ITfFnShowHelp : ITfFunction
{
    HRESULT Show(HWND hwndParent);
}

@GUID("3BAB89E4-5FBE-45F4-A5BC-DCA36AD225A8")
interface ITfFnBalloon : IUnknown
{
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}

@GUID("5C0AB7EA-167D-4F59-BFB5-4693755E90CA")
interface ITfFnGetSAPIObject : ITfFunction
{
    HRESULT Get(TfSapiObject sObj, IUnknown* ppunk);
}

@GUID("2338AC6E-2B9D-44C0-A75E-EE64F256B3BD")
interface ITfFnPropertyUIStatus : ITfFunction
{
    HRESULT GetStatus(const(GUID)* refguidProp, uint* pdw);
    HRESULT SetStatus(const(GUID)* refguidProp, uint dw);
}

@GUID("7AFBF8E7-AC4B-4082-B058-890899D3A010")
interface ITfFnLMProcessor : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfAccepted);
    HRESULT QueryLangID(ushort langid, int* pfAccepted);
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    HRESULT Reconvert(ITfRange pRange);
    HRESULT QueryKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeydata, int* pfInterested);
    HRESULT InvokeKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeyData);
    HRESULT InvokeFunc(ITfContext pic, const(GUID)* refguidFunc);
}

@GUID("04B825B1-AC9A-4F7B-B5AD-C7168F1EE445")
interface ITfFnLMInternal : ITfFnLMProcessor
{
    HRESULT ProcessLattice(ITfRange pRange);
}

@GUID("56988052-47DA-4A05-911A-E3D941F17145")
interface IEnumTfLatticeElements : IUnknown
{
    HRESULT Clone(IEnumTfLatticeElements* ppEnum);
    HRESULT Next(uint ulCount, char* rgsElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

@GUID("D4236675-A5BF-4570-9D42-5D6D7B02D59B")
interface ITfLMLattice : IUnknown
{
    HRESULT QueryType(const(GUID)* rguidType, int* pfSupported);
    HRESULT EnumLatticeElements(uint dwFrameStart, const(GUID)* rguidType, IEnumTfLatticeElements* ppEnum);
}

@GUID("3527268B-7D53-4DD9-92B7-7296AE461249")
interface ITfFnAdviseText : ITfFunction
{
    HRESULT OnTextUpdate(ITfRange pRange, const(wchar)* pchText, int cch);
    HRESULT OnLatticeUpdate(ITfRange pRange, ITfLMLattice pLattice);
}

@GUID("87A2AD8F-F27B-4920-8501-67602280175D")
interface ITfFnSearchCandidateProvider : ITfFunction
{
    HRESULT GetSearchCandidates(BSTR bstrQuery, BSTR bstrApplicationId, ITfCandidateList* pplist);
    HRESULT SetResult(BSTR bstrQuery, BSTR bstrApplicationID, BSTR bstrResult);
}

@GUID("C7A6F54F-B180-416F-B2BF-7BF2E4683D7B")
interface ITfIntegratableCandidateListUIElement : IUnknown
{
    HRESULT SetIntegrationStyle(GUID guidIntegrationStyle);
    HRESULT GetSelectionStyle(TfIntegratableCandidateListSelectionStyle* ptfSelectionStyle);
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT ShowCandidateNumbers(int* pfShow);
    HRESULT FinalizeExactCompositionString();
}

@GUID("5F309A41-590A-4ACC-A97F-D8EFFF13FDFC")
interface ITfFnGetPreferredTouchKeyboardLayout : ITfFunction
{
    HRESULT GetLayout(TKBLayoutType* pTKBLayoutType, ushort* pwPreferredLayoutId);
}

@GUID("EA163CE2-7A65-4506-82A3-C528215DA64E")
interface ITfFnGetLinguisticAlternates : ITfFunction
{
    HRESULT GetAlternates(ITfRange pRange, ITfCandidateList* ppCandidateList);
}

@GUID("CD91D690-A7E8-4265-9B38-8BB3BBABA7DE")
interface IUIManagerEventSink : IUnknown
{
    HRESULT OnWindowOpening(RECT* prcBounds);
    HRESULT OnWindowOpened(RECT* prcBounds);
    HRESULT OnWindowUpdating(RECT* prcUpdatedBounds);
    HRESULT OnWindowUpdated(RECT* prcUpdatedBounds);
    HRESULT OnWindowClosing();
    HRESULT OnWindowClosed();
}

@GUID("FDE1EAEE-6924-4CDF-91E7-DA38CFF5559D")
interface ITfInputScope : IUnknown
{
    HRESULT GetInputScopes(char* pprgInputScopes, uint* pcCount);
    HRESULT GetPhrase(char* ppbstrPhrases, uint* pcCount);
    HRESULT GetRegularExpression(BSTR* pbstrRegExp);
    HRESULT GetSRGS(BSTR* pbstrSRGS);
    HRESULT GetXML(BSTR* pbstrXML);
}

@GUID("5731EAA0-6BC2-4681-A532-92FBB74D7C41")
interface ITfInputScope2 : ITfInputScope
{
    HRESULT EnumWordList(IEnumString* ppEnumString);
}

@GUID("90E9A944-9244-489F-A78F-DE67AFC013A7")
interface ITfSpeechUIServer : IUnknown
{
    HRESULT Initialize();
    HRESULT ShowUI(BOOL fShow);
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}


// GUIDs


const GUID IID_IAnchor                                  = GUIDOF!IAnchor;
const GUID IID_IEnumITfCompositionView                  = GUIDOF!IEnumITfCompositionView;
const GUID IID_IEnumTfCandidates                        = GUIDOF!IEnumTfCandidates;
const GUID IID_IEnumTfContextViews                      = GUIDOF!IEnumTfContextViews;
const GUID IID_IEnumTfContexts                          = GUIDOF!IEnumTfContexts;
const GUID IID_IEnumTfDisplayAttributeInfo              = GUIDOF!IEnumTfDisplayAttributeInfo;
const GUID IID_IEnumTfDocumentMgrs                      = GUIDOF!IEnumTfDocumentMgrs;
const GUID IID_IEnumTfFunctionProviders                 = GUIDOF!IEnumTfFunctionProviders;
const GUID IID_IEnumTfInputProcessorProfiles            = GUIDOF!IEnumTfInputProcessorProfiles;
const GUID IID_IEnumTfLangBarItems                      = GUIDOF!IEnumTfLangBarItems;
const GUID IID_IEnumTfLanguageProfiles                  = GUIDOF!IEnumTfLanguageProfiles;
const GUID IID_IEnumTfLatticeElements                   = GUIDOF!IEnumTfLatticeElements;
const GUID IID_IEnumTfProperties                        = GUIDOF!IEnumTfProperties;
const GUID IID_IEnumTfPropertyValue                     = GUIDOF!IEnumTfPropertyValue;
const GUID IID_IEnumTfRanges                            = GUIDOF!IEnumTfRanges;
const GUID IID_IEnumTfUIElements                        = GUIDOF!IEnumTfUIElements;
const GUID IID_ITextStoreACP                            = GUIDOF!ITextStoreACP;
const GUID IID_ITextStoreACP2                           = GUIDOF!ITextStoreACP2;
const GUID IID_ITextStoreACPServices                    = GUIDOF!ITextStoreACPServices;
const GUID IID_ITextStoreACPSink                        = GUIDOF!ITextStoreACPSink;
const GUID IID_ITextStoreAnchor                         = GUIDOF!ITextStoreAnchor;
const GUID IID_ITextStoreAnchorSink                     = GUIDOF!ITextStoreAnchorSink;
const GUID IID_ITfActiveLanguageProfileNotifySink       = GUIDOF!ITfActiveLanguageProfileNotifySink;
const GUID IID_ITfCandidateList                         = GUIDOF!ITfCandidateList;
const GUID IID_ITfCandidateListUIElement                = GUIDOF!ITfCandidateListUIElement;
const GUID IID_ITfCandidateListUIElementBehavior        = GUIDOF!ITfCandidateListUIElementBehavior;
const GUID IID_ITfCandidateString                       = GUIDOF!ITfCandidateString;
const GUID IID_ITfCategoryMgr                           = GUIDOF!ITfCategoryMgr;
const GUID IID_ITfCleanupContextDurationSink            = GUIDOF!ITfCleanupContextDurationSink;
const GUID IID_ITfCleanupContextSink                    = GUIDOF!ITfCleanupContextSink;
const GUID IID_ITfClientId                              = GUIDOF!ITfClientId;
const GUID IID_ITfCompartment                           = GUIDOF!ITfCompartment;
const GUID IID_ITfCompartmentEventSink                  = GUIDOF!ITfCompartmentEventSink;
const GUID IID_ITfCompartmentMgr                        = GUIDOF!ITfCompartmentMgr;
const GUID IID_ITfComposition                           = GUIDOF!ITfComposition;
const GUID IID_ITfCompositionSink                       = GUIDOF!ITfCompositionSink;
const GUID IID_ITfCompositionView                       = GUIDOF!ITfCompositionView;
const GUID IID_ITfConfigureSystemKeystrokeFeed          = GUIDOF!ITfConfigureSystemKeystrokeFeed;
const GUID IID_ITfContext                               = GUIDOF!ITfContext;
const GUID IID_ITfContextComposition                    = GUIDOF!ITfContextComposition;
const GUID IID_ITfContextKeyEventSink                   = GUIDOF!ITfContextKeyEventSink;
const GUID IID_ITfContextOwner                          = GUIDOF!ITfContextOwner;
const GUID IID_ITfContextOwnerCompositionServices       = GUIDOF!ITfContextOwnerCompositionServices;
const GUID IID_ITfContextOwnerCompositionSink           = GUIDOF!ITfContextOwnerCompositionSink;
const GUID IID_ITfContextOwnerServices                  = GUIDOF!ITfContextOwnerServices;
const GUID IID_ITfContextView                           = GUIDOF!ITfContextView;
const GUID IID_ITfCreatePropertyStore                   = GUIDOF!ITfCreatePropertyStore;
const GUID IID_ITfDisplayAttributeInfo                  = GUIDOF!ITfDisplayAttributeInfo;
const GUID IID_ITfDisplayAttributeMgr                   = GUIDOF!ITfDisplayAttributeMgr;
const GUID IID_ITfDisplayAttributeNotifySink            = GUIDOF!ITfDisplayAttributeNotifySink;
const GUID IID_ITfDisplayAttributeProvider              = GUIDOF!ITfDisplayAttributeProvider;
const GUID IID_ITfDocumentMgr                           = GUIDOF!ITfDocumentMgr;
const GUID IID_ITfEditRecord                            = GUIDOF!ITfEditRecord;
const GUID IID_ITfEditSession                           = GUIDOF!ITfEditSession;
const GUID IID_ITfEditTransactionSink                   = GUIDOF!ITfEditTransactionSink;
const GUID IID_ITfFnAdviseText                          = GUIDOF!ITfFnAdviseText;
const GUID IID_ITfFnBalloon                             = GUIDOF!ITfFnBalloon;
const GUID IID_ITfFnConfigure                           = GUIDOF!ITfFnConfigure;
const GUID IID_ITfFnConfigureRegisterEudc               = GUIDOF!ITfFnConfigureRegisterEudc;
const GUID IID_ITfFnConfigureRegisterWord               = GUIDOF!ITfFnConfigureRegisterWord;
const GUID IID_ITfFnGetLinguisticAlternates             = GUIDOF!ITfFnGetLinguisticAlternates;
const GUID IID_ITfFnGetPreferredTouchKeyboardLayout     = GUIDOF!ITfFnGetPreferredTouchKeyboardLayout;
const GUID IID_ITfFnGetSAPIObject                       = GUIDOF!ITfFnGetSAPIObject;
const GUID IID_ITfFnLMInternal                          = GUIDOF!ITfFnLMInternal;
const GUID IID_ITfFnLMProcessor                         = GUIDOF!ITfFnLMProcessor;
const GUID IID_ITfFnLangProfileUtil                     = GUIDOF!ITfFnLangProfileUtil;
const GUID IID_ITfFnPlayBack                            = GUIDOF!ITfFnPlayBack;
const GUID IID_ITfFnPropertyUIStatus                    = GUIDOF!ITfFnPropertyUIStatus;
const GUID IID_ITfFnReconversion                        = GUIDOF!ITfFnReconversion;
const GUID IID_ITfFnSearchCandidateProvider             = GUIDOF!ITfFnSearchCandidateProvider;
const GUID IID_ITfFnShowHelp                            = GUIDOF!ITfFnShowHelp;
const GUID IID_ITfFunction                              = GUIDOF!ITfFunction;
const GUID IID_ITfFunctionProvider                      = GUIDOF!ITfFunctionProvider;
const GUID IID_ITfInputProcessorProfileActivationSink   = GUIDOF!ITfInputProcessorProfileActivationSink;
const GUID IID_ITfInputProcessorProfileMgr              = GUIDOF!ITfInputProcessorProfileMgr;
const GUID IID_ITfInputProcessorProfileSubstituteLayout = GUIDOF!ITfInputProcessorProfileSubstituteLayout;
const GUID IID_ITfInputProcessorProfiles                = GUIDOF!ITfInputProcessorProfiles;
const GUID IID_ITfInputProcessorProfilesEx              = GUIDOF!ITfInputProcessorProfilesEx;
const GUID IID_ITfInputScope                            = GUIDOF!ITfInputScope;
const GUID IID_ITfInputScope2                           = GUIDOF!ITfInputScope2;
const GUID IID_ITfInsertAtSelection                     = GUIDOF!ITfInsertAtSelection;
const GUID IID_ITfIntegratableCandidateListUIElement    = GUIDOF!ITfIntegratableCandidateListUIElement;
const GUID IID_ITfKeyEventSink                          = GUIDOF!ITfKeyEventSink;
const GUID IID_ITfKeyTraceEventSink                     = GUIDOF!ITfKeyTraceEventSink;
const GUID IID_ITfKeystrokeMgr                          = GUIDOF!ITfKeystrokeMgr;
const GUID IID_ITfLMLattice                             = GUIDOF!ITfLMLattice;
const GUID IID_ITfLangBarEventSink                      = GUIDOF!ITfLangBarEventSink;
const GUID IID_ITfLangBarItem                           = GUIDOF!ITfLangBarItem;
const GUID IID_ITfLangBarItemBalloon                    = GUIDOF!ITfLangBarItemBalloon;
const GUID IID_ITfLangBarItemBitmap                     = GUIDOF!ITfLangBarItemBitmap;
const GUID IID_ITfLangBarItemBitmapButton               = GUIDOF!ITfLangBarItemBitmapButton;
const GUID IID_ITfLangBarItemButton                     = GUIDOF!ITfLangBarItemButton;
const GUID IID_ITfLangBarItemMgr                        = GUIDOF!ITfLangBarItemMgr;
const GUID IID_ITfLangBarItemSink                       = GUIDOF!ITfLangBarItemSink;
const GUID IID_ITfLangBarMgr                            = GUIDOF!ITfLangBarMgr;
const GUID IID_ITfLanguageProfileNotifySink             = GUIDOF!ITfLanguageProfileNotifySink;
const GUID IID_ITfMSAAControl                           = GUIDOF!ITfMSAAControl;
const GUID IID_ITfMenu                                  = GUIDOF!ITfMenu;
const GUID IID_ITfMessagePump                           = GUIDOF!ITfMessagePump;
const GUID IID_ITfMouseSink                             = GUIDOF!ITfMouseSink;
const GUID IID_ITfMouseTracker                          = GUIDOF!ITfMouseTracker;
const GUID IID_ITfMouseTrackerACP                       = GUIDOF!ITfMouseTrackerACP;
const GUID IID_ITfPersistentPropertyLoaderACP           = GUIDOF!ITfPersistentPropertyLoaderACP;
const GUID IID_ITfPreservedKeyNotifySink                = GUIDOF!ITfPreservedKeyNotifySink;
const GUID IID_ITfProperty                              = GUIDOF!ITfProperty;
const GUID IID_ITfPropertyStore                         = GUIDOF!ITfPropertyStore;
const GUID IID_ITfQueryEmbedded                         = GUIDOF!ITfQueryEmbedded;
const GUID IID_ITfRange                                 = GUIDOF!ITfRange;
const GUID IID_ITfRangeACP                              = GUIDOF!ITfRangeACP;
const GUID IID_ITfRangeBackup                           = GUIDOF!ITfRangeBackup;
const GUID IID_ITfReadOnlyProperty                      = GUIDOF!ITfReadOnlyProperty;
const GUID IID_ITfReadingInformationUIElement           = GUIDOF!ITfReadingInformationUIElement;
const GUID IID_ITfReverseConversion                     = GUIDOF!ITfReverseConversion;
const GUID IID_ITfReverseConversionList                 = GUIDOF!ITfReverseConversionList;
const GUID IID_ITfReverseConversionMgr                  = GUIDOF!ITfReverseConversionMgr;
const GUID IID_ITfSource                                = GUIDOF!ITfSource;
const GUID IID_ITfSourceSingle                          = GUIDOF!ITfSourceSingle;
const GUID IID_ITfSpeechUIServer                        = GUIDOF!ITfSpeechUIServer;
const GUID IID_ITfStatusSink                            = GUIDOF!ITfStatusSink;
const GUID IID_ITfSystemDeviceTypeLangBarItem           = GUIDOF!ITfSystemDeviceTypeLangBarItem;
const GUID IID_ITfSystemLangBarItem                     = GUIDOF!ITfSystemLangBarItem;
const GUID IID_ITfSystemLangBarItemSink                 = GUIDOF!ITfSystemLangBarItemSink;
const GUID IID_ITfSystemLangBarItemText                 = GUIDOF!ITfSystemLangBarItemText;
const GUID IID_ITfTextEditSink                          = GUIDOF!ITfTextEditSink;
const GUID IID_ITfTextInputProcessor                    = GUIDOF!ITfTextInputProcessor;
const GUID IID_ITfTextInputProcessorEx                  = GUIDOF!ITfTextInputProcessorEx;
const GUID IID_ITfTextLayoutSink                        = GUIDOF!ITfTextLayoutSink;
const GUID IID_ITfThreadFocusSink                       = GUIDOF!ITfThreadFocusSink;
const GUID IID_ITfThreadMgr                             = GUIDOF!ITfThreadMgr;
const GUID IID_ITfThreadMgr2                            = GUIDOF!ITfThreadMgr2;
const GUID IID_ITfThreadMgrEventSink                    = GUIDOF!ITfThreadMgrEventSink;
const GUID IID_ITfThreadMgrEx                           = GUIDOF!ITfThreadMgrEx;
const GUID IID_ITfToolTipUIElement                      = GUIDOF!ITfToolTipUIElement;
const GUID IID_ITfTransitoryExtensionSink               = GUIDOF!ITfTransitoryExtensionSink;
const GUID IID_ITfTransitoryExtensionUIElement          = GUIDOF!ITfTransitoryExtensionUIElement;
const GUID IID_ITfUIElement                             = GUIDOF!ITfUIElement;
const GUID IID_ITfUIElementMgr                          = GUIDOF!ITfUIElementMgr;
const GUID IID_ITfUIElementSink                         = GUIDOF!ITfUIElementSink;
const GUID IID_IUIManagerEventSink                      = GUIDOF!IUIManagerEventSink;
