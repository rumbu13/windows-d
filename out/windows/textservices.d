module windows.textservices;

public import system;
public import windows.automation;
public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

const GUID IID_ITfMSAAControl = {0xB5F8FB3B, 0x393F, 0x4F7C, [0x84, 0xCB, 0x50, 0x49, 0x24, 0xC2, 0x70, 0x5A]};
@GUID(0xB5F8FB3B, 0x393F, 0x4F7C, [0x84, 0xCB, 0x50, 0x49, 0x24, 0xC2, 0x70, 0x5A]);
interface ITfMSAAControl : IUnknown
{
    HRESULT SystemEnableMSAA();
    HRESULT SystemDisableMSAA();
}

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

enum TsActiveSelEnd
{
    TS_AE_NONE = 0,
    TS_AE_START = 1,
    TS_AE_END = 2,
}

struct TS_SELECTIONSTYLE
{
    TsActiveSelEnd ase;
    BOOL fInterimChar;
}

struct TS_SELECTION_ACP
{
    int acpStart;
    int acpEnd;
    TS_SELECTIONSTYLE style;
}

struct TS_SELECTION_ANCHOR
{
    IAnchor paStart;
    IAnchor paEnd;
    TS_SELECTIONSTYLE style;
}

struct TS_ATTRVAL
{
    Guid idAttr;
    uint dwOverlapId;
    VARIANT varValue;
}

enum TsLayoutCode
{
    TS_LC_CREATE = 0,
    TS_LC_CHANGE = 1,
    TS_LC_DESTROY = 2,
}

enum TsRunType
{
    TS_RT_PLAIN = 0,
    TS_RT_HIDDEN = 1,
    TS_RT_OPAQUE = 2,
}

struct TS_RUNINFO
{
    uint uCount;
    TsRunType type;
}

const GUID IID_ITextStoreACP = {0x28888FE3, 0xC2A0, 0x483A, [0xA3, 0xEA, 0x8C, 0xB1, 0xCE, 0x51, 0xFF, 0x3D]};
@GUID(0x28888FE3, 0xC2A0, 0x483A, [0xA3, 0xEA, 0x8C, 0xB1, 0xCE, 0x51, 0xFF, 0x3D]);
interface ITextStoreACP : IUnknown
{
    HRESULT AdviseSink(const(Guid)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, TS_TEXTCHANGE* pChange);
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(int acpPos, const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppunk);
    HRESULT QueryInsertEmbedded(const(Guid)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, TS_TEXTCHANGE* pChange);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, TS_TEXTCHANGE* pChange);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, int* pacpNext, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetEndACP(int* pacp);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    HRESULT GetWnd(uint vcView, HWND* phwnd);
}

const GUID IID_ITextStoreACP2 = {0xF86AD89F, 0x5FE4, 0x4B8D, [0xBB, 0x9F, 0xEF, 0x37, 0x97, 0xA8, 0x4F, 0x1F]};
@GUID(0xF86AD89F, 0x5FE4, 0x4B8D, [0xBB, 0x9F, 0xEF, 0x37, 0x97, 0xA8, 0x4F, 0x1F]);
interface ITextStoreACP2 : IUnknown
{
    HRESULT AdviseSink(const(Guid)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(int acpTestStart, int acpTestEnd, uint cch, int* pacpResultStart, int* pacpResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(int acpStart, int acpEnd, char* pchPlain, uint cchPlainReq, uint* pcchPlainRet, char* prgRunInfo, uint cRunInfoReq, uint* pcRunInfoRet, int* pacpNext);
    HRESULT SetText(uint dwFlags, int acpStart, int acpEnd, const(wchar)* pchText, uint cch, TS_TEXTCHANGE* pChange);
    HRESULT GetFormattedText(int acpStart, int acpEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(int acpPos, const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppunk);
    HRESULT QueryInsertEmbedded(const(Guid)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertEmbedded(uint dwFlags, int acpStart, int acpEnd, IDataObject pDataObject, TS_TEXTCHANGE* pChange);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, int* pacpStart, int* pacpEnd, TS_TEXTCHANGE* pChange);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, int* pacpStart, int* pacpEnd, TS_TEXTCHANGE* pChange);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(int acpPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT FindNextAttrTransition(int acpStart, int acpHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, int* pacpNext, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetEndACP(int* pacp);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetACPFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(uint vcView, int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
}

const GUID IID_ITextStoreACPSink = {0x22D44C94, 0xA419, 0x4542, [0xA2, 0x72, 0xAE, 0x26, 0x09, 0x3E, 0xCE, 0xCF]};
@GUID(0x22D44C94, 0xA419, 0x4542, [0xA2, 0x72, 0xAE, 0x26, 0x09, 0x3E, 0xCE, 0xCF]);
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

enum TsGravity
{
    TS_GR_BACKWARD = 0,
    TS_GR_FORWARD = 1,
}

enum TsShiftDir
{
    TS_SD_BACKWARD = 0,
    TS_SD_FORWARD = 1,
}

const GUID IID_IAnchor = {0x0FEB7E34, 0x5A60, 0x4356, [0x8E, 0xF7, 0xAB, 0xDE, 0xC2, 0xFF, 0x7C, 0xF8]};
@GUID(0x0FEB7E34, 0x5A60, 0x4356, [0x8E, 0xF7, 0xAB, 0xDE, 0xC2, 0xFF, 0x7C, 0xF8]);
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

const GUID IID_ITextStoreAnchor = {0x9B2077B0, 0x5F18, 0x4DEC, [0xBE, 0xE9, 0x3C, 0xC7, 0x22, 0xF5, 0xDF, 0xE0]};
@GUID(0x9B2077B0, 0x5F18, 0x4DEC, [0xBE, 0xE9, 0x3C, 0xC7, 0x22, 0xF5, 0xDF, 0xE0]);
interface ITextStoreAnchor : IUnknown
{
    HRESULT AdviseSink(const(Guid)* riid, IUnknown punk, uint dwMask);
    HRESULT UnadviseSink(IUnknown punk);
    HRESULT RequestLock(uint dwLockFlags, int* phrSession);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT QueryInsert(IAnchor paTestStart, IAnchor paTestEnd, uint cch, IAnchor* ppaResultStart, IAnchor* ppaResultEnd);
    HRESULT GetSelection(uint ulIndex, uint ulCount, char* pSelection, uint* pcFetched);
    HRESULT SetSelection(uint ulCount, char* pSelection);
    HRESULT GetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, char* pchText, uint cchReq, uint* pcch, BOOL fUpdateAnchor);
    HRESULT SetText(uint dwFlags, IAnchor paStart, IAnchor paEnd, const(wchar)* pchText, uint cch);
    HRESULT GetFormattedText(IAnchor paStart, IAnchor paEnd, IDataObject* ppDataObject);
    HRESULT GetEmbedded(uint dwFlags, IAnchor paPos, const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppunk);
    HRESULT InsertEmbedded(uint dwFlags, IAnchor paStart, IAnchor paEnd, IDataObject pDataObject);
    HRESULT RequestSupportedAttrs(uint dwFlags, uint cFilterAttrs, char* paFilterAttrs);
    HRESULT RequestAttrsAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT RequestAttrsTransitioningAtPosition(IAnchor paPos, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags);
    HRESULT FindNextAttrTransition(IAnchor paStart, IAnchor paHalt, uint cFilterAttrs, char* paFilterAttrs, uint dwFlags, int* pfFound, int* plFoundOffset);
    HRESULT RetrieveRequestedAttrs(uint ulCount, char* paAttrVals, uint* pcFetched);
    HRESULT GetStart(IAnchor* ppaStart);
    HRESULT GetEnd(IAnchor* ppaEnd);
    HRESULT GetActiveView(uint* pvcView);
    HRESULT GetAnchorFromPoint(uint vcView, const(POINT)* ptScreen, uint dwFlags, IAnchor* ppaSite);
    HRESULT GetTextExt(uint vcView, IAnchor paStart, IAnchor paEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(uint vcView, RECT* prc);
    HRESULT GetWnd(uint vcView, HWND* phwnd);
    HRESULT QueryInsertEmbedded(const(Guid)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
    HRESULT InsertTextAtSelection(uint dwFlags, const(wchar)* pchText, uint cch, IAnchor* ppaStart, IAnchor* ppaEnd);
    HRESULT InsertEmbeddedAtSelection(uint dwFlags, IDataObject pDataObject, IAnchor* ppaStart, IAnchor* ppaEnd);
}

const GUID IID_ITextStoreAnchorSink = {0xAA80E905, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E905, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
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

const GUID IID_ITfLangBarMgr = {0x87955690, 0xE627, 0x11D2, [0x8D, 0xDB, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x87955690, 0xE627, 0x11D2, [0x8D, 0xDB, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfLangBarMgr : IUnknown
{
    HRESULT AdviseEventSink(ITfLangBarEventSink pSink, HWND hwnd, uint dwFlags, uint* pdwCookie);
    HRESULT UnadviseEventSink(uint dwCookie);
    HRESULT GetThreadMarshalInterface(uint dwThreadId, uint dwType, const(Guid)* riid, IUnknown* ppunk);
    HRESULT GetThreadLangBarItemMgr(uint dwThreadId, ITfLangBarItemMgr* pplbi, uint* pdwThreadid);
    HRESULT GetInputProcessorProfiles(uint dwThreadId, ITfInputProcessorProfiles* ppaip, uint* pdwThreadid);
    HRESULT RestoreLastFocus(uint* pdwThreadId, BOOL fPrev);
    HRESULT SetModalInput(ITfLangBarEventSink pSink, uint dwThreadId, uint dwFlags);
    HRESULT ShowFloating(uint dwFlags);
    HRESULT GetShowFloatingStatus(uint* pdwFlags);
}

const GUID IID_ITfLangBarEventSink = {0x18A4E900, 0xE0AE, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x18A4E900, 0xE0AE, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfLangBarEventSink : IUnknown
{
    HRESULT OnSetFocus(uint dwThreadId);
    HRESULT OnThreadTerminate(uint dwThreadId);
    HRESULT OnThreadItemChange(uint dwThreadId);
    HRESULT OnModalInput(uint dwThreadId, uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT ShowFloating(uint dwFlags);
    HRESULT GetItemFloatingRect(uint dwThreadId, const(Guid)* rguid, RECT* prc);
}

const GUID IID_ITfLangBarItemSink = {0x57DBE1A0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x57DBE1A0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfLangBarItemSink : IUnknown
{
    HRESULT OnUpdate(uint dwFlags);
}

const GUID IID_IEnumTfLangBarItems = {0x583F34D0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x583F34D0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface IEnumTfLangBarItems : IUnknown
{
    HRESULT Clone(IEnumTfLangBarItems* ppEnum);
    HRESULT Next(uint ulCount, char* ppItem, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

struct TF_LANGBARITEMINFO
{
    Guid clsidService;
    Guid guidItem;
    uint dwStyle;
    uint ulSort;
    ushort szDescription;
}

const GUID IID_ITfLangBarItemMgr = {0xBA468C55, 0x9956, 0x4FB1, [0xA5, 0x9D, 0x52, 0xA7, 0xDD, 0x7C, 0xC6, 0xAA]};
@GUID(0xBA468C55, 0x9956, 0x4FB1, [0xA5, 0x9D, 0x52, 0xA7, 0xDD, 0x7C, 0xC6, 0xAA]);
interface ITfLangBarItemMgr : IUnknown
{
    HRESULT EnumItems(IEnumTfLangBarItems* ppEnum);
    HRESULT GetItem(const(Guid)* rguid, ITfLangBarItem* ppItem);
    HRESULT AddItem(ITfLangBarItem punk);
    HRESULT RemoveItem(ITfLangBarItem punk);
    HRESULT AdviseItemSink(ITfLangBarItemSink punk, uint* pdwCookie, const(Guid)* rguidItem);
    HRESULT UnadviseItemSink(uint dwCookie);
    HRESULT GetItemFloatingRect(uint dwThreadId, const(Guid)* rguid, RECT* prc);
    HRESULT GetItemsStatus(uint ulCount, char* prgguid, char* pdwStatus);
    HRESULT GetItemNum(uint* pulCount);
    HRESULT GetItems(uint ulCount, char* ppItem, char* pInfo, char* pdwStatus, uint* pcFetched);
    HRESULT AdviseItemsSink(uint ulCount, char* ppunk, char* pguidItem, char* pdwCookie);
    HRESULT UnadviseItemsSink(uint ulCount, char* pdwCookie);
}

const GUID IID_ITfLangBarItem = {0x73540D69, 0xEDEB, 0x4EE9, [0x96, 0xC9, 0x23, 0xAA, 0x30, 0xB2, 0x59, 0x16]};
@GUID(0x73540D69, 0xEDEB, 0x4EE9, [0x96, 0xC9, 0x23, 0xAA, 0x30, 0xB2, 0x59, 0x16]);
interface ITfLangBarItem : IUnknown
{
    HRESULT GetInfo(TF_LANGBARITEMINFO* pInfo);
    HRESULT GetStatus(uint* pdwStatus);
    HRESULT Show(BOOL fShow);
    HRESULT GetTooltipString(BSTR* pbstrToolTip);
}

const GUID IID_ITfSystemLangBarItemSink = {0x1449D9AB, 0x13CF, 0x4687, [0xAA, 0x3E, 0x8D, 0x8B, 0x18, 0x57, 0x43, 0x96]};
@GUID(0x1449D9AB, 0x13CF, 0x4687, [0xAA, 0x3E, 0x8D, 0x8B, 0x18, 0x57, 0x43, 0x96]);
interface ITfSystemLangBarItemSink : IUnknown
{
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
}

const GUID IID_ITfSystemLangBarItem = {0x1E13E9EC, 0x6B33, 0x4D4A, [0xB5, 0xEB, 0x8A, 0x92, 0xF0, 0x29, 0xF3, 0x56]};
@GUID(0x1E13E9EC, 0x6B33, 0x4D4A, [0xB5, 0xEB, 0x8A, 0x92, 0xF0, 0x29, 0xF3, 0x56]);
interface ITfSystemLangBarItem : IUnknown
{
    HRESULT SetIcon(HICON hIcon);
    HRESULT SetTooltipString(char* pchToolTip, uint cch);
}

const GUID IID_ITfSystemLangBarItemText = {0x5C4CE0E5, 0xBA49, 0x4B52, [0xAC, 0x6B, 0x3B, 0x39, 0x7B, 0x4F, 0x70, 0x1F]};
@GUID(0x5C4CE0E5, 0xBA49, 0x4B52, [0xAC, 0x6B, 0x3B, 0x39, 0x7B, 0x4F, 0x70, 0x1F]);
interface ITfSystemLangBarItemText : IUnknown
{
    HRESULT SetItemText(const(wchar)* pch, uint cch);
    HRESULT GetItemText(BSTR* pbstrText);
}

const GUID IID_ITfSystemDeviceTypeLangBarItem = {0x45672EB9, 0x9059, 0x46A2, [0x83, 0x8D, 0x45, 0x30, 0x35, 0x5F, 0x6A, 0x77]};
@GUID(0x45672EB9, 0x9059, 0x46A2, [0x83, 0x8D, 0x45, 0x30, 0x35, 0x5F, 0x6A, 0x77]);
interface ITfSystemDeviceTypeLangBarItem : IUnknown
{
    HRESULT SetIconMode(uint dwFlags);
    HRESULT GetIconMode(uint* pdwFlags);
}

enum TfLBIClick
{
    TF_LBI_CLK_RIGHT = 1,
    TF_LBI_CLK_LEFT = 2,
}

const GUID IID_ITfLangBarItemButton = {0x28C7F1D0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x28C7F1D0, 0xDE25, 0x11D2, [0xAF, 0xDD, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfLangBarItemButton : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
    HRESULT GetIcon(HICON* phIcon);
    HRESULT GetText(BSTR* pbstrText);
}

const GUID IID_ITfLangBarItemBitmapButton = {0xA26A0525, 0x3FAE, 0x4FA0, [0x89, 0xEE, 0x88, 0xA9, 0x64, 0xF9, 0xF1, 0xB5]};
@GUID(0xA26A0525, 0x3FAE, 0x4FA0, [0x89, 0xEE, 0x88, 0xA9, 0x64, 0xF9, 0xF1, 0xB5]);
interface ITfLangBarItemBitmapButton : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT InitMenu(ITfMenu pMenu);
    HRESULT OnMenuSelect(uint wID);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
    HRESULT GetText(BSTR* pbstrText);
}

const GUID IID_ITfLangBarItemBitmap = {0x73830352, 0xD722, 0x4179, [0xAD, 0xA5, 0xF0, 0x45, 0xC9, 0x8D, 0xF3, 0x55]};
@GUID(0x73830352, 0xD722, 0x4179, [0xAD, 0xA5, 0xF0, 0x45, 0xC9, 0x8D, 0xF3, 0x55]);
interface ITfLangBarItemBitmap : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT DrawBitmap(int bmWidth, int bmHeight, uint dwFlags, HBITMAP* phbmp, HBITMAP* phbmpMask);
}

enum TfLBBalloonStyle
{
    TF_LB_BALLOON_RECO = 0,
    TF_LB_BALLOON_SHOW = 1,
    TF_LB_BALLOON_MISS = 2,
}

struct TF_LBBALLOONINFO
{
    TfLBBalloonStyle style;
    BSTR bstrText;
}

const GUID IID_ITfLangBarItemBalloon = {0x01C2D285, 0xD3C7, 0x4B7B, [0xB5, 0xB5, 0xD9, 0x74, 0x11, 0xD0, 0xC2, 0x83]};
@GUID(0x01C2D285, 0xD3C7, 0x4B7B, [0xB5, 0xB5, 0xD9, 0x74, 0x11, 0xD0, 0xC2, 0x83]);
interface ITfLangBarItemBalloon : ITfLangBarItem
{
    HRESULT OnClick(TfLBIClick click, POINT pt, const(RECT)* prcArea);
    HRESULT GetPreferredSize(const(SIZE)* pszDefault, SIZE* psz);
    HRESULT GetBalloonInfo(TF_LBBALLOONINFO* pInfo);
}

const GUID IID_ITfMenu = {0x6F8A98E4, 0xAAA0, 0x4F15, [0x8C, 0x5B, 0x07, 0xE0, 0xDF, 0x0A, 0x3D, 0xD8]};
@GUID(0x6F8A98E4, 0xAAA0, 0x4F15, [0x8C, 0x5B, 0x07, 0xE0, 0xDF, 0x0A, 0x3D, 0xD8]);
interface ITfMenu : IUnknown
{
    HRESULT AddMenuItem(uint uId, uint dwFlags, HBITMAP hbmp, HBITMAP hbmpMask, const(wchar)* pch, uint cch, ITfMenu* ppMenu);
}

struct TF_PERSISTENT_PROPERTY_HEADER_ACP
{
    Guid guidType;
    int ichStart;
    int cch;
    uint cb;
    uint dwPrivate;
    Guid clsidTIP;
}

struct TF_LANGUAGEPROFILE
{
    Guid clsid;
    ushort langid;
    Guid catid;
    BOOL fActive;
    Guid guidProfile;
}

enum TfAnchor
{
    TF_ANCHOR_START = 0,
    TF_ANCHOR_END = 1,
}

const GUID IID_ITfThreadMgr = {0xAA80E801, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E801, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
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
    HRESULT GetFunctionProvider(const(Guid)* clsid, ITfFunctionProvider* ppFuncProv);
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
}

const GUID IID_ITfThreadMgrEx = {0x3E90ADE3, 0x7594, 0x4CB0, [0xBB, 0x58, 0x69, 0x62, 0x8F, 0x5F, 0x45, 0x8C]};
@GUID(0x3E90ADE3, 0x7594, 0x4CB0, [0xBB, 0x58, 0x69, 0x62, 0x8F, 0x5F, 0x45, 0x8C]);
interface ITfThreadMgrEx : ITfThreadMgr
{
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    HRESULT GetActiveFlags(uint* lpdwFlags);
}

const GUID IID_ITfThreadMgr2 = {0x0AB198EF, 0x6477, 0x4EE8, [0x88, 0x12, 0x67, 0x80, 0xED, 0xB8, 0x2D, 0x5E]};
@GUID(0x0AB198EF, 0x6477, 0x4EE8, [0x88, 0x12, 0x67, 0x80, 0xED, 0xB8, 0x2D, 0x5E]);
interface ITfThreadMgr2 : IUnknown
{
    HRESULT Activate(uint* ptid);
    HRESULT Deactivate();
    HRESULT CreateDocumentMgr(ITfDocumentMgr* ppdim);
    HRESULT EnumDocumentMgrs(IEnumTfDocumentMgrs* ppEnum);
    HRESULT GetFocus(ITfDocumentMgr* ppdimFocus);
    HRESULT SetFocus(ITfDocumentMgr pdimFocus);
    HRESULT IsThreadFocus(int* pfThreadFocus);
    HRESULT GetFunctionProvider(const(Guid)* clsid, ITfFunctionProvider* ppFuncProv);
    HRESULT EnumFunctionProviders(IEnumTfFunctionProviders* ppEnum);
    HRESULT GetGlobalCompartment(ITfCompartmentMgr* ppCompMgr);
    HRESULT ActivateEx(uint* ptid, uint dwFlags);
    HRESULT GetActiveFlags(uint* lpdwFlags);
    HRESULT SuspendKeystrokeHandling();
    HRESULT ResumeKeystrokeHandling();
}

const GUID IID_ITfThreadMgrEventSink = {0xAA80E80E, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E80E, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfThreadMgrEventSink : IUnknown
{
    HRESULT OnInitDocumentMgr(ITfDocumentMgr pdim);
    HRESULT OnUninitDocumentMgr(ITfDocumentMgr pdim);
    HRESULT OnSetFocus(ITfDocumentMgr pdimFocus, ITfDocumentMgr pdimPrevFocus);
    HRESULT OnPushContext(ITfContext pic);
    HRESULT OnPopContext(ITfContext pic);
}

const GUID IID_ITfConfigureSystemKeystrokeFeed = {0x0D2C969A, 0xBC9C, 0x437C, [0x84, 0xEE, 0x95, 0x1C, 0x49, 0xB1, 0xA7, 0x64]};
@GUID(0x0D2C969A, 0xBC9C, 0x437C, [0x84, 0xEE, 0x95, 0x1C, 0x49, 0xB1, 0xA7, 0x64]);
interface ITfConfigureSystemKeystrokeFeed : IUnknown
{
    HRESULT DisableSystemKeystrokeFeed();
    HRESULT EnableSystemKeystrokeFeed();
}

const GUID IID_IEnumTfDocumentMgrs = {0xAA80E808, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E808, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IEnumTfDocumentMgrs : IUnknown
{
    HRESULT Clone(IEnumTfDocumentMgrs* ppEnum);
    HRESULT Next(uint ulCount, char* rgDocumentMgr, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfDocumentMgr = {0xAA80E7F4, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7F4, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfDocumentMgr : IUnknown
{
    HRESULT CreateContext(uint tidOwner, uint dwFlags, IUnknown punk, ITfContext* ppic, uint* pecTextStore);
    HRESULT Push(ITfContext pic);
    HRESULT Pop(uint dwFlags);
    HRESULT GetTop(ITfContext* ppic);
    HRESULT GetBase(ITfContext* ppic);
    HRESULT EnumContexts(IEnumTfContexts* ppEnum);
}

const GUID IID_IEnumTfContexts = {0x8F1A7EA6, 0x1654, 0x4502, [0xA8, 0x6E, 0xB2, 0x90, 0x23, 0x44, 0xD5, 0x07]};
@GUID(0x8F1A7EA6, 0x1654, 0x4502, [0xA8, 0x6E, 0xB2, 0x90, 0x23, 0x44, 0xD5, 0x07]);
interface IEnumTfContexts : IUnknown
{
    HRESULT Clone(IEnumTfContexts* ppEnum);
    HRESULT Next(uint ulCount, char* rgContext, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfCompositionView = {0xD7540241, 0xF9A1, 0x4364, [0xBE, 0xFC, 0xDB, 0xCD, 0x2C, 0x43, 0x95, 0xB7]};
@GUID(0xD7540241, 0xF9A1, 0x4364, [0xBE, 0xFC, 0xDB, 0xCD, 0x2C, 0x43, 0x95, 0xB7]);
interface ITfCompositionView : IUnknown
{
    HRESULT GetOwnerClsid(Guid* pclsid);
    HRESULT GetRange(ITfRange* ppRange);
}

const GUID IID_IEnumITfCompositionView = {0x5EFD22BA, 0x7838, 0x46CB, [0x88, 0xE2, 0xCA, 0xDB, 0x14, 0x12, 0x4F, 0x8F]};
@GUID(0x5EFD22BA, 0x7838, 0x46CB, [0x88, 0xE2, 0xCA, 0xDB, 0x14, 0x12, 0x4F, 0x8F]);
interface IEnumITfCompositionView : IUnknown
{
    HRESULT Clone(IEnumITfCompositionView* ppEnum);
    HRESULT Next(uint ulCount, char* rgCompositionView, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfComposition = {0x20168D64, 0x5A8F, 0x4A5A, [0xB7, 0xBD, 0xCF, 0xA2, 0x9F, 0x4D, 0x0F, 0xD9]};
@GUID(0x20168D64, 0x5A8F, 0x4A5A, [0xB7, 0xBD, 0xCF, 0xA2, 0x9F, 0x4D, 0x0F, 0xD9]);
interface ITfComposition : IUnknown
{
    HRESULT GetRange(ITfRange* ppRange);
    HRESULT ShiftStart(uint ecWrite, ITfRange pNewStart);
    HRESULT ShiftEnd(uint ecWrite, ITfRange pNewEnd);
    HRESULT EndComposition(uint ecWrite);
}

const GUID IID_ITfCompositionSink = {0xA781718C, 0x579A, 0x4B15, [0xA2, 0x80, 0x32, 0xB8, 0x57, 0x7A, 0xCC, 0x5E]};
@GUID(0xA781718C, 0x579A, 0x4B15, [0xA2, 0x80, 0x32, 0xB8, 0x57, 0x7A, 0xCC, 0x5E]);
interface ITfCompositionSink : IUnknown
{
    HRESULT OnCompositionTerminated(uint ecWrite, ITfComposition pComposition);
}

const GUID IID_ITfContextComposition = {0xD40C8AAE, 0xAC92, 0x4FC7, [0x9A, 0x11, 0x0E, 0xE0, 0xE2, 0x3A, 0xA3, 0x9B]};
@GUID(0xD40C8AAE, 0xAC92, 0x4FC7, [0x9A, 0x11, 0x0E, 0xE0, 0xE2, 0x3A, 0xA3, 0x9B]);
interface ITfContextComposition : IUnknown
{
    HRESULT StartComposition(uint ecWrite, ITfRange pCompositionRange, ITfCompositionSink pSink, ITfComposition* ppComposition);
    HRESULT EnumCompositions(IEnumITfCompositionView* ppEnum);
    HRESULT FindComposition(uint ecRead, ITfRange pTestRange, IEnumITfCompositionView* ppEnum);
    HRESULT TakeOwnership(uint ecWrite, ITfCompositionView pComposition, ITfCompositionSink pSink, ITfComposition* ppComposition);
}

const GUID IID_ITfContextOwnerCompositionServices = {0x86462810, 0x593B, 0x4916, [0x97, 0x64, 0x19, 0xC0, 0x8E, 0x9C, 0xE1, 0x10]};
@GUID(0x86462810, 0x593B, 0x4916, [0x97, 0x64, 0x19, 0xC0, 0x8E, 0x9C, 0xE1, 0x10]);
interface ITfContextOwnerCompositionServices : ITfContextComposition
{
    HRESULT TerminateComposition(ITfCompositionView pComposition);
}

const GUID IID_ITfContextOwnerCompositionSink = {0x5F20AA40, 0xB57A, 0x4F34, [0x96, 0xAB, 0x35, 0x76, 0xF3, 0x77, 0xCC, 0x79]};
@GUID(0x5F20AA40, 0xB57A, 0x4F34, [0x96, 0xAB, 0x35, 0x76, 0xF3, 0x77, 0xCC, 0x79]);
interface ITfContextOwnerCompositionSink : IUnknown
{
    HRESULT OnStartComposition(ITfCompositionView pComposition, int* pfOk);
    HRESULT OnUpdateComposition(ITfCompositionView pComposition, ITfRange pRangeNew);
    HRESULT OnEndComposition(ITfCompositionView pComposition);
}

const GUID IID_ITfContextView = {0x2433BF8E, 0x0F9B, 0x435C, [0xBA, 0x2C, 0x18, 0x06, 0x11, 0x97, 0x8C, 0x30]};
@GUID(0x2433BF8E, 0x0F9B, 0x435C, [0xBA, 0x2C, 0x18, 0x06, 0x11, 0x97, 0x8C, 0x30]);
interface ITfContextView : IUnknown
{
    HRESULT GetRangeFromPoint(uint ec, const(POINT)* ppt, uint dwFlags, ITfRange* ppRange);
    HRESULT GetTextExt(uint ec, ITfRange pRange, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(RECT* prc);
    HRESULT GetWnd(HWND* phwnd);
}

const GUID IID_IEnumTfContextViews = {0xF0C0F8DD, 0xCF38, 0x44E1, [0xBB, 0x0F, 0x68, 0xCF, 0x0D, 0x55, 0x1C, 0x78]};
@GUID(0xF0C0F8DD, 0xCF38, 0x44E1, [0xBB, 0x0F, 0x68, 0xCF, 0x0D, 0x55, 0x1C, 0x78]);
interface IEnumTfContextViews : IUnknown
{
    HRESULT Clone(IEnumTfContextViews* ppEnum);
    HRESULT Next(uint ulCount, char* rgViews, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

enum TfActiveSelEnd
{
    TF_AE_NONE = 0,
    TF_AE_START = 1,
    TF_AE_END = 2,
}

struct TF_SELECTIONSTYLE
{
    TfActiveSelEnd ase;
    BOOL fInterimChar;
}

struct TF_SELECTION
{
    ITfRange range;
    TF_SELECTIONSTYLE style;
}

const GUID IID_ITfContext = {0xAA80E7FD, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7FD, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
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
    HRESULT GetProperty(const(Guid)* guidProp, ITfProperty* ppProp);
    HRESULT GetAppProperty(const(Guid)* guidProp, ITfReadOnlyProperty* ppProp);
    HRESULT TrackProperties(char* prgProp, uint cProp, char* prgAppProp, uint cAppProp, ITfReadOnlyProperty* ppProperty);
    HRESULT EnumProperties(IEnumTfProperties* ppEnum);
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppDm);
    HRESULT CreateRangeBackup(uint ec, ITfRange pRange, ITfRangeBackup* ppBackup);
}

const GUID IID_ITfQueryEmbedded = {0x0FAB9BDB, 0xD250, 0x4169, [0x84, 0xE5, 0x6B, 0xE1, 0x18, 0xFD, 0xD7, 0xA8]};
@GUID(0x0FAB9BDB, 0xD250, 0x4169, [0x84, 0xE5, 0x6B, 0xE1, 0x18, 0xFD, 0xD7, 0xA8]);
interface ITfQueryEmbedded : IUnknown
{
    HRESULT QueryInsertEmbedded(const(Guid)* pguidService, const(FORMATETC)* pFormatEtc, int* pfInsertable);
}

const GUID IID_ITfInsertAtSelection = {0x55CE16BA, 0x3014, 0x41C1, [0x9C, 0xEB, 0xFA, 0xDE, 0x14, 0x46, 0xAC, 0x6C]};
@GUID(0x55CE16BA, 0x3014, 0x41C1, [0x9C, 0xEB, 0xFA, 0xDE, 0x14, 0x46, 0xAC, 0x6C]);
interface ITfInsertAtSelection : IUnknown
{
    HRESULT InsertTextAtSelection(uint ec, uint dwFlags, const(wchar)* pchText, int cch, ITfRange* ppRange);
    HRESULT InsertEmbeddedAtSelection(uint ec, uint dwFlags, IDataObject pDataObject, ITfRange* ppRange);
}

const GUID IID_ITfCleanupContextSink = {0x01689689, 0x7ACB, 0x4E9B, [0xAB, 0x7C, 0x7E, 0xA4, 0x6B, 0x12, 0xB5, 0x22]};
@GUID(0x01689689, 0x7ACB, 0x4E9B, [0xAB, 0x7C, 0x7E, 0xA4, 0x6B, 0x12, 0xB5, 0x22]);
interface ITfCleanupContextSink : IUnknown
{
    HRESULT OnCleanupContext(uint ecWrite, ITfContext pic);
}

const GUID IID_ITfCleanupContextDurationSink = {0x45C35144, 0x154E, 0x4797, [0xBE, 0xD8, 0xD3, 0x3A, 0xE7, 0xBF, 0x87, 0x94]};
@GUID(0x45C35144, 0x154E, 0x4797, [0xBE, 0xD8, 0xD3, 0x3A, 0xE7, 0xBF, 0x87, 0x94]);
interface ITfCleanupContextDurationSink : IUnknown
{
    HRESULT OnStartCleanupContext();
    HRESULT OnEndCleanupContext();
}

const GUID IID_ITfReadOnlyProperty = {0x17D49A3D, 0xF8B8, 0x4B2F, [0xB2, 0x54, 0x52, 0x31, 0x9D, 0xD6, 0x4C, 0x53]};
@GUID(0x17D49A3D, 0xF8B8, 0x4B2F, [0xB2, 0x54, 0x52, 0x31, 0x9D, 0xD6, 0x4C, 0x53]);
interface ITfReadOnlyProperty : IUnknown
{
    HRESULT GetType(Guid* pguid);
    HRESULT EnumRanges(uint ec, IEnumTfRanges* ppEnum, ITfRange pTargetRange);
    HRESULT GetValue(uint ec, ITfRange pRange, VARIANT* pvarValue);
    HRESULT GetContext(ITfContext* ppContext);
}

struct TF_PROPERTYVAL
{
    Guid guidId;
    VARIANT varValue;
}

const GUID IID_IEnumTfPropertyValue = {0x8ED8981B, 0x7C10, 0x4D7D, [0x9F, 0xB3, 0xAB, 0x72, 0xE9, 0xC7, 0x5F, 0x72]};
@GUID(0x8ED8981B, 0x7C10, 0x4D7D, [0x9F, 0xB3, 0xAB, 0x72, 0xE9, 0xC7, 0x5F, 0x72]);
interface IEnumTfPropertyValue : IUnknown
{
    HRESULT Clone(IEnumTfPropertyValue* ppEnum);
    HRESULT Next(uint ulCount, char* rgValues, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfMouseTracker = {0x09D146CD, 0xA544, 0x4132, [0x92, 0x5B, 0x7A, 0xFA, 0x8E, 0xF3, 0x22, 0xD0]};
@GUID(0x09D146CD, 0xA544, 0x4132, [0x92, 0x5B, 0x7A, 0xFA, 0x8E, 0xF3, 0x22, 0xD0]);
interface ITfMouseTracker : IUnknown
{
    HRESULT AdviseMouseSink(ITfRange range, ITfMouseSink pSink, uint* pdwCookie);
    HRESULT UnadviseMouseSink(uint dwCookie);
}

const GUID IID_ITfMouseTrackerACP = {0x3BDD78E2, 0xC16E, 0x47FD, [0xB8, 0x83, 0xCE, 0x6F, 0xAC, 0xC1, 0xA2, 0x08]};
@GUID(0x3BDD78E2, 0xC16E, 0x47FD, [0xB8, 0x83, 0xCE, 0x6F, 0xAC, 0xC1, 0xA2, 0x08]);
interface ITfMouseTrackerACP : IUnknown
{
    HRESULT AdviseMouseSink(ITfRangeACP range, ITfMouseSink pSink, uint* pdwCookie);
    HRESULT UnadviseMouseSink(uint dwCookie);
}

const GUID IID_ITfMouseSink = {0xA1ADAAA2, 0x3A24, 0x449D, [0xAC, 0x96, 0x51, 0x83, 0xE7, 0xF5, 0xC2, 0x17]};
@GUID(0xA1ADAAA2, 0x3A24, 0x449D, [0xAC, 0x96, 0x51, 0x83, 0xE7, 0xF5, 0xC2, 0x17]);
interface ITfMouseSink : IUnknown
{
    HRESULT OnMouseEvent(uint uEdge, uint uQuadrant, uint dwBtnStatus, int* pfEaten);
}

const GUID IID_ITfEditRecord = {0x42D4D099, 0x7C1A, 0x4A89, [0xB8, 0x36, 0x6C, 0x6F, 0x22, 0x16, 0x0D, 0xF0]};
@GUID(0x42D4D099, 0x7C1A, 0x4A89, [0xB8, 0x36, 0x6C, 0x6F, 0x22, 0x16, 0x0D, 0xF0]);
interface ITfEditRecord : IUnknown
{
    HRESULT GetSelectionStatus(int* pfChanged);
    HRESULT GetTextAndPropertyUpdates(uint dwFlags, char* prgProperties, uint cProperties, IEnumTfRanges* ppEnum);
}

const GUID IID_ITfTextEditSink = {0x8127D409, 0xCCD3, 0x4683, [0x96, 0x7A, 0xB4, 0x3D, 0x5B, 0x48, 0x2B, 0xF7]};
@GUID(0x8127D409, 0xCCD3, 0x4683, [0x96, 0x7A, 0xB4, 0x3D, 0x5B, 0x48, 0x2B, 0xF7]);
interface ITfTextEditSink : IUnknown
{
    HRESULT OnEndEdit(ITfContext pic, uint ecReadOnly, ITfEditRecord pEditRecord);
}

enum TfLayoutCode
{
    TF_LC_CREATE = 0,
    TF_LC_CHANGE = 1,
    TF_LC_DESTROY = 2,
}

const GUID IID_ITfTextLayoutSink = {0x2AF2D06A, 0xDD5B, 0x4927, [0xA0, 0xB4, 0x54, 0xF1, 0x9C, 0x91, 0xFA, 0xDE]};
@GUID(0x2AF2D06A, 0xDD5B, 0x4927, [0xA0, 0xB4, 0x54, 0xF1, 0x9C, 0x91, 0xFA, 0xDE]);
interface ITfTextLayoutSink : IUnknown
{
    HRESULT OnLayoutChange(ITfContext pic, TfLayoutCode lcode, ITfContextView pView);
}

const GUID IID_ITfStatusSink = {0x6B7D8D73, 0xB267, 0x4F69, [0xB3, 0x2E, 0x1C, 0xA3, 0x21, 0xCE, 0x4F, 0x45]};
@GUID(0x6B7D8D73, 0xB267, 0x4F69, [0xB3, 0x2E, 0x1C, 0xA3, 0x21, 0xCE, 0x4F, 0x45]);
interface ITfStatusSink : IUnknown
{
    HRESULT OnStatusChange(ITfContext pic, uint dwFlags);
}

const GUID IID_ITfEditTransactionSink = {0x708FBF70, 0xB520, 0x416B, [0xB0, 0x6C, 0x2C, 0x41, 0xAB, 0x44, 0xF8, 0xBA]};
@GUID(0x708FBF70, 0xB520, 0x416B, [0xB0, 0x6C, 0x2C, 0x41, 0xAB, 0x44, 0xF8, 0xBA]);
interface ITfEditTransactionSink : IUnknown
{
    HRESULT OnStartEditTransaction(ITfContext pic);
    HRESULT OnEndEditTransaction(ITfContext pic);
}

const GUID IID_ITfContextOwner = {0xAA80E80C, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E80C, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfContextOwner : IUnknown
{
    HRESULT GetACPFromPoint(const(POINT)* ptScreen, uint dwFlags, int* pacp);
    HRESULT GetTextExt(int acpStart, int acpEnd, RECT* prc, int* pfClipped);
    HRESULT GetScreenExt(RECT* prc);
    HRESULT GetStatus(TS_STATUS* pdcs);
    HRESULT GetWnd(HWND* phwnd);
    HRESULT GetAttribute(const(Guid)* rguidAttribute, VARIANT* pvarValue);
}

const GUID IID_ITfContextOwnerServices = {0xB23EB630, 0x3E1C, 0x11D3, [0xA7, 0x45, 0x00, 0x50, 0x04, 0x0A, 0xB4, 0x07]};
@GUID(0xB23EB630, 0x3E1C, 0x11D3, [0xA7, 0x45, 0x00, 0x50, 0x04, 0x0A, 0xB4, 0x07]);
interface ITfContextOwnerServices : IUnknown
{
    HRESULT OnLayoutChange();
    HRESULT OnStatusChange(uint dwFlags);
    HRESULT OnAttributeChange(const(Guid)* rguidAttribute);
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, ITfPersistentPropertyLoaderACP pLoader);
    HRESULT ForceLoadProperty(ITfProperty pProp);
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

const GUID IID_ITfContextKeyEventSink = {0x0552BA5D, 0xC835, 0x4934, [0xBF, 0x50, 0x84, 0x6A, 0xAA, 0x67, 0x43, 0x2F]};
@GUID(0x0552BA5D, 0xC835, 0x4934, [0xBF, 0x50, 0x84, 0x6A, 0xAA, 0x67, 0x43, 0x2F]);
interface ITfContextKeyEventSink : IUnknown
{
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
}

const GUID IID_ITfEditSession = {0xAA80E803, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E803, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfEditSession : IUnknown
{
    HRESULT DoEditSession(uint ec);
}

enum TfGravity
{
    TF_GRAVITY_BACKWARD = 0,
    TF_GRAVITY_FORWARD = 1,
}

enum TfShiftDir
{
    TF_SD_BACKWARD = 0,
    TF_SD_FORWARD = 1,
}

struct TF_HALTCOND
{
    ITfRange pHaltRange;
    TfAnchor aHaltPos;
    uint dwFlags;
}

const GUID IID_ITfRange = {0xAA80E7FF, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7FF, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfRange : IUnknown
{
    HRESULT GetText(uint ec, uint dwFlags, char* pchText, uint cchMax, uint* pcch);
    HRESULT SetText(uint ec, uint dwFlags, const(wchar)* pchText, int cch);
    HRESULT GetFormattedText(uint ec, IDataObject* ppDataObject);
    HRESULT GetEmbedded(uint ec, const(Guid)* rguidService, const(Guid)* riid, IUnknown* ppunk);
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

const GUID IID_ITfRangeACP = {0x057A6296, 0x029B, 0x4154, [0xB7, 0x9A, 0x0D, 0x46, 0x1D, 0x4E, 0xA9, 0x4C]};
@GUID(0x057A6296, 0x029B, 0x4154, [0xB7, 0x9A, 0x0D, 0x46, 0x1D, 0x4E, 0xA9, 0x4C]);
interface ITfRangeACP : ITfRange
{
    HRESULT GetExtent(int* pacpAnchor, int* pcch);
    HRESULT SetExtent(int acpAnchor, int cch);
}

const GUID IID_ITextStoreACPServices = {0xAA80E901, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E901, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITextStoreACPServices : IUnknown
{
    HRESULT Serialize(ITfProperty pProp, ITfRange pRange, TF_PERSISTENT_PROPERTY_HEADER_ACP* pHdr, IStream pStream);
    HRESULT Unserialize(ITfProperty pProp, const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream pStream, ITfPersistentPropertyLoaderACP pLoader);
    HRESULT ForceLoadProperty(ITfProperty pProp);
    HRESULT CreateRange(int acpStart, int acpEnd, ITfRangeACP* ppRange);
}

const GUID IID_ITfRangeBackup = {0x463A506D, 0x6992, 0x49D2, [0x9B, 0x88, 0x93, 0xD5, 0x5E, 0x70, 0xBB, 0x16]};
@GUID(0x463A506D, 0x6992, 0x49D2, [0x9B, 0x88, 0x93, 0xD5, 0x5E, 0x70, 0xBB, 0x16]);
interface ITfRangeBackup : IUnknown
{
    HRESULT Restore(uint ec, ITfRange pRange);
}

const GUID IID_ITfPropertyStore = {0x6834B120, 0x88CB, 0x11D2, [0xBF, 0x45, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x6834B120, 0x88CB, 0x11D2, [0xBF, 0x45, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfPropertyStore : IUnknown
{
    HRESULT GetType(Guid* pguid);
    HRESULT GetDataType(uint* pdwReserved);
    HRESULT GetData(VARIANT* pvarValue);
    HRESULT OnTextUpdated(uint dwFlags, ITfRange pRangeNew, int* pfAccept);
    HRESULT Shrink(ITfRange pRangeNew, int* pfFree);
    HRESULT Divide(ITfRange pRangeThis, ITfRange pRangeNew, ITfPropertyStore* ppPropStore);
    HRESULT Clone(ITfPropertyStore* pPropStore);
    HRESULT GetPropertyRangeCreator(Guid* pclsid);
    HRESULT Serialize(IStream pStream, uint* pcb);
}

const GUID IID_IEnumTfRanges = {0xF99D3F40, 0x8E32, 0x11D2, [0xBF, 0x46, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0xF99D3F40, 0x8E32, 0x11D2, [0xBF, 0x46, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface IEnumTfRanges : IUnknown
{
    HRESULT Clone(IEnumTfRanges* ppEnum);
    HRESULT Next(uint ulCount, char* ppRange, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfCreatePropertyStore = {0x2463FBF0, 0xB0AF, 0x11D2, [0xAF, 0xC5, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x2463FBF0, 0xB0AF, 0x11D2, [0xAF, 0xC5, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfCreatePropertyStore : IUnknown
{
    HRESULT IsStoreSerializable(const(Guid)* guidProp, ITfRange pRange, ITfPropertyStore pPropStore, int* pfSerializable);
    HRESULT CreatePropertyStore(const(Guid)* guidProp, ITfRange pRange, uint cb, IStream pStream, ITfPropertyStore* ppStore);
}

const GUID IID_ITfPersistentPropertyLoaderACP = {0x4EF89150, 0x0807, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x4EF89150, 0x0807, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfPersistentPropertyLoaderACP : IUnknown
{
    HRESULT LoadProperty(const(TF_PERSISTENT_PROPERTY_HEADER_ACP)* pHdr, IStream* ppStream);
}

const GUID IID_ITfProperty = {0xE2449660, 0x9542, 0x11D2, [0xBF, 0x46, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0xE2449660, 0x9542, 0x11D2, [0xBF, 0x46, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfProperty : ITfReadOnlyProperty
{
    HRESULT FindRange(uint ec, ITfRange pRange, ITfRange* ppRange, TfAnchor aPos);
    HRESULT SetValueStore(uint ec, ITfRange pRange, ITfPropertyStore pPropStore);
    HRESULT SetValue(uint ec, ITfRange pRange, const(VARIANT)* pvarValue);
    HRESULT Clear(uint ec, ITfRange pRange);
}

const GUID IID_IEnumTfProperties = {0x19188CB0, 0xACA9, 0x11D2, [0xAF, 0xC5, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x19188CB0, 0xACA9, 0x11D2, [0xAF, 0xC5, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface IEnumTfProperties : IUnknown
{
    HRESULT Clone(IEnumTfProperties* ppEnum);
    HRESULT Next(uint ulCount, char* ppProp, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfCompartment = {0xBB08F7A9, 0x607A, 0x4384, [0x86, 0x23, 0x05, 0x68, 0x92, 0xB6, 0x43, 0x71]};
@GUID(0xBB08F7A9, 0x607A, 0x4384, [0x86, 0x23, 0x05, 0x68, 0x92, 0xB6, 0x43, 0x71]);
interface ITfCompartment : IUnknown
{
    HRESULT SetValue(uint tid, const(VARIANT)* pvarValue);
    HRESULT GetValue(VARIANT* pvarValue);
}

const GUID IID_ITfCompartmentEventSink = {0x743ABD5F, 0xF26D, 0x48DF, [0x8C, 0xC5, 0x23, 0x84, 0x92, 0x41, 0x9B, 0x64]};
@GUID(0x743ABD5F, 0xF26D, 0x48DF, [0x8C, 0xC5, 0x23, 0x84, 0x92, 0x41, 0x9B, 0x64]);
interface ITfCompartmentEventSink : IUnknown
{
    HRESULT OnChange(const(Guid)* rguid);
}

const GUID IID_ITfCompartmentMgr = {0x7DCF57AC, 0x18AD, 0x438B, [0x82, 0x4D, 0x97, 0x9B, 0xFF, 0xB7, 0x4B, 0x7C]};
@GUID(0x7DCF57AC, 0x18AD, 0x438B, [0x82, 0x4D, 0x97, 0x9B, 0xFF, 0xB7, 0x4B, 0x7C]);
interface ITfCompartmentMgr : IUnknown
{
    HRESULT GetCompartment(const(Guid)* rguid, ITfCompartment* ppcomp);
    HRESULT ClearCompartment(uint tid, const(Guid)* rguid);
    HRESULT EnumCompartments(IEnumGUID* ppEnum);
}

const GUID IID_ITfFunction = {0xDB593490, 0x098F, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0xDB593490, 0x098F, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfFunction : IUnknown
{
    HRESULT GetDisplayName(BSTR* pbstrName);
}

const GUID IID_ITfFunctionProvider = {0x101D6610, 0x0990, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x101D6610, 0x0990, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfFunctionProvider : IUnknown
{
    HRESULT GetType(Guid* pguid);
    HRESULT GetDescription(BSTR* pbstrDesc);
    HRESULT GetFunction(const(Guid)* rguid, const(Guid)* riid, IUnknown* ppunk);
}

const GUID IID_IEnumTfFunctionProviders = {0xE4B24DB0, 0x0990, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0xE4B24DB0, 0x0990, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface IEnumTfFunctionProviders : IUnknown
{
    HRESULT Clone(IEnumTfFunctionProviders* ppEnum);
    HRESULT Next(uint ulCount, char* ppCmdobj, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfInputProcessorProfiles = {0x1F02B6C5, 0x7842, 0x4EE6, [0x8A, 0x0B, 0x9A, 0x24, 0x18, 0x3A, 0x95, 0xCA]};
@GUID(0x1F02B6C5, 0x7842, 0x4EE6, [0x8A, 0x0B, 0x9A, 0x24, 0x18, 0x3A, 0x95, 0xCA]);
interface ITfInputProcessorProfiles : IUnknown
{
    HRESULT Register(const(Guid)* rclsid);
    HRESULT Unregister(const(Guid)* rclsid);
    HRESULT AddLanguageProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, const(wchar)* pchDesc, uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex);
    HRESULT RemoveLanguageProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile);
    HRESULT EnumInputProcessorInfo(IEnumGUID* ppEnum);
    HRESULT GetDefaultLanguageProfile(ushort langid, const(Guid)* catid, Guid* pclsid, Guid* pguidProfile);
    HRESULT SetDefaultLanguageProfile(ushort langid, const(Guid)* rclsid, const(Guid)* guidProfiles);
    HRESULT ActivateLanguageProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfiles);
    HRESULT GetActiveLanguageProfile(const(Guid)* rclsid, ushort* plangid, Guid* pguidProfile);
    HRESULT GetLanguageProfileDescription(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, BSTR* pbstrProfile);
    HRESULT GetCurrentLanguage(ushort* plangid);
    HRESULT ChangeCurrentLanguage(ushort langid);
    HRESULT GetLanguageList(char* ppLangId, uint* pulCount);
    HRESULT EnumLanguageProfiles(ushort langid, IEnumTfLanguageProfiles* ppEnum);
    HRESULT EnableLanguageProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, BOOL fEnable);
    HRESULT IsEnabledLanguageProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, int* pfEnable);
    HRESULT EnableLanguageProfileByDefault(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, BOOL fEnable);
    HRESULT SubstituteKeyboardLayout(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, int hKL);
}

const GUID IID_ITfInputProcessorProfilesEx = {0x892F230F, 0xFE00, 0x4A41, [0xA9, 0x8E, 0xFC, 0xD6, 0xDE, 0x0D, 0x35, 0xEF]};
@GUID(0x892F230F, 0xFE00, 0x4A41, [0xA9, 0x8E, 0xFC, 0xD6, 0xDE, 0x0D, 0x35, 0xEF]);
interface ITfInputProcessorProfilesEx : ITfInputProcessorProfiles
{
    HRESULT SetLanguageProfileDisplayName(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, const(wchar)* pchFile, uint cchFile, uint uResId);
}

const GUID IID_ITfInputProcessorProfileSubstituteLayout = {0x4FD67194, 0x1002, 0x4513, [0xBF, 0xF2, 0xC0, 0xDD, 0xF6, 0x25, 0x85, 0x52]};
@GUID(0x4FD67194, 0x1002, 0x4513, [0xBF, 0xF2, 0xC0, 0xDD, 0xF6, 0x25, 0x85, 0x52]);
interface ITfInputProcessorProfileSubstituteLayout : IUnknown
{
    HRESULT GetSubstituteKeyboardLayout(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, int* phKL);
}

const GUID IID_ITfActiveLanguageProfileNotifySink = {0xB246CB75, 0xA93E, 0x4652, [0xBF, 0x8C, 0xB3, 0xFE, 0x0C, 0xFD, 0x7E, 0x57]};
@GUID(0xB246CB75, 0xA93E, 0x4652, [0xBF, 0x8C, 0xB3, 0xFE, 0x0C, 0xFD, 0x7E, 0x57]);
interface ITfActiveLanguageProfileNotifySink : IUnknown
{
    HRESULT OnActivated(const(Guid)* clsid, const(Guid)* guidProfile, BOOL fActivated);
}

const GUID IID_IEnumTfLanguageProfiles = {0x3D61BF11, 0xAC5F, 0x42C8, [0xA4, 0xCB, 0x93, 0x1B, 0xCC, 0x28, 0xC7, 0x44]};
@GUID(0x3D61BF11, 0xAC5F, 0x42C8, [0xA4, 0xCB, 0x93, 0x1B, 0xCC, 0x28, 0xC7, 0x44]);
interface IEnumTfLanguageProfiles : IUnknown
{
    HRESULT Clone(IEnumTfLanguageProfiles* ppEnum);
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfLanguageProfileNotifySink = {0x43C9FE15, 0xF494, 0x4C17, [0x9D, 0xE2, 0xB8, 0xA4, 0xAC, 0x35, 0x0A, 0xA8]};
@GUID(0x43C9FE15, 0xF494, 0x4C17, [0x9D, 0xE2, 0xB8, 0xA4, 0xAC, 0x35, 0x0A, 0xA8]);
interface ITfLanguageProfileNotifySink : IUnknown
{
    HRESULT OnLanguageChange(ushort langid, int* pfAccept);
    HRESULT OnLanguageChanged();
}

struct TF_INPUTPROCESSORPROFILE
{
    uint dwProfileType;
    ushort langid;
    Guid clsid;
    Guid guidProfile;
    Guid catid;
    int hklSubstitute;
    uint dwCaps;
    int hkl;
    uint dwFlags;
}

const GUID IID_ITfInputProcessorProfileMgr = {0x71C6E74C, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0x71C6E74C, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfInputProcessorProfileMgr : IUnknown
{
    HRESULT ActivateProfile(uint dwProfileType, ushort langid, const(Guid)* clsid, const(Guid)* guidProfile, int hkl, uint dwFlags);
    HRESULT DeactivateProfile(uint dwProfileType, ushort langid, const(Guid)* clsid, const(Guid)* guidProfile, int hkl, uint dwFlags);
    HRESULT GetProfile(uint dwProfileType, ushort langid, const(Guid)* clsid, const(Guid)* guidProfile, int hkl, TF_INPUTPROCESSORPROFILE* pProfile);
    HRESULT EnumProfiles(ushort langid, IEnumTfInputProcessorProfiles* ppEnum);
    HRESULT ReleaseInputProcessor(const(Guid)* rclsid, uint dwFlags);
    HRESULT RegisterProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, const(wchar)* pchDesc, uint cchDesc, const(wchar)* pchIconFile, uint cchFile, uint uIconIndex, int hklsubstitute, uint dwPreferredLayout, BOOL bEnabledByDefault, uint dwFlags);
    HRESULT UnregisterProfile(const(Guid)* rclsid, ushort langid, const(Guid)* guidProfile, uint dwFlags);
    HRESULT GetActiveProfile(const(Guid)* catid, TF_INPUTPROCESSORPROFILE* pProfile);
}

const GUID IID_IEnumTfInputProcessorProfiles = {0x71C6E74D, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0x71C6E74D, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface IEnumTfInputProcessorProfiles : IUnknown
{
    HRESULT Clone(IEnumTfInputProcessorProfiles* ppEnum);
    HRESULT Next(uint ulCount, char* pProfile, uint* pcFetch);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfInputProcessorProfileActivationSink = {0x71C6E74E, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0x71C6E74E, 0x0F28, 0x11D8, [0xA8, 0x2A, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfInputProcessorProfileActivationSink : IUnknown
{
    HRESULT OnActivated(uint dwProfileType, ushort langid, const(Guid)* clsid, const(Guid)* catid, const(Guid)* guidProfile, int hkl, uint dwFlags);
}

struct TF_PRESERVEDKEY
{
    uint uVKey;
    uint uModifiers;
}

const GUID IID_ITfKeystrokeMgr = {0xAA80E7F0, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7F0, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfKeystrokeMgr : IUnknown
{
    HRESULT AdviseKeyEventSink(uint tid, ITfKeyEventSink pSink, BOOL fForeground);
    HRESULT UnadviseKeyEventSink(uint tid);
    HRESULT GetForeground(Guid* pclsid);
    HRESULT TestKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT TestKeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT KeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT KeyUp(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT GetPreservedKey(ITfContext pic, const(TF_PRESERVEDKEY)* pprekey, Guid* pguid);
    HRESULT IsPreservedKey(const(Guid)* rguid, const(TF_PRESERVEDKEY)* pprekey, int* pfRegistered);
    HRESULT PreserveKey(uint tid, const(Guid)* rguid, const(TF_PRESERVEDKEY)* prekey, const(wchar)* pchDesc, uint cchDesc);
    HRESULT UnpreserveKey(const(Guid)* rguid, const(TF_PRESERVEDKEY)* pprekey);
    HRESULT SetPreservedKeyDescription(const(Guid)* rguid, const(wchar)* pchDesc, uint cchDesc);
    HRESULT GetPreservedKeyDescription(const(Guid)* rguid, BSTR* pbstrDesc);
    HRESULT SimulatePreservedKey(ITfContext pic, const(Guid)* rguid, int* pfEaten);
}

const GUID IID_ITfKeyEventSink = {0xAA80E7F5, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7F5, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfKeyEventSink : IUnknown
{
    HRESULT OnSetFocus(BOOL fForeground);
    HRESULT OnTestKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnTestKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyDown(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnKeyUp(ITfContext pic, WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT OnPreservedKey(ITfContext pic, const(Guid)* rguid, int* pfEaten);
}

const GUID IID_ITfKeyTraceEventSink = {0x1CD4C13B, 0x1C36, 0x4191, [0xA7, 0x0A, 0x7F, 0x3E, 0x61, 0x1F, 0x36, 0x7D]};
@GUID(0x1CD4C13B, 0x1C36, 0x4191, [0xA7, 0x0A, 0x7F, 0x3E, 0x61, 0x1F, 0x36, 0x7D]);
interface ITfKeyTraceEventSink : IUnknown
{
    HRESULT OnKeyTraceDown(WPARAM wParam, LPARAM lParam);
    HRESULT OnKeyTraceUp(WPARAM wParam, LPARAM lParam);
}

const GUID IID_ITfPreservedKeyNotifySink = {0x6F77C993, 0xD2B1, 0x446E, [0x85, 0x3E, 0x59, 0x12, 0xEF, 0xC8, 0xA2, 0x86]};
@GUID(0x6F77C993, 0xD2B1, 0x446E, [0x85, 0x3E, 0x59, 0x12, 0xEF, 0xC8, 0xA2, 0x86]);
interface ITfPreservedKeyNotifySink : IUnknown
{
    HRESULT OnUpdated(const(TF_PRESERVEDKEY)* pprekey);
}

const GUID IID_ITfMessagePump = {0x8F1B8AD8, 0x0B6B, 0x4874, [0x90, 0xC5, 0xBD, 0x76, 0x01, 0x1E, 0x8F, 0x7C]};
@GUID(0x8F1B8AD8, 0x0B6B, 0x4874, [0x90, 0xC5, 0xBD, 0x76, 0x01, 0x1E, 0x8F, 0x7C]);
interface ITfMessagePump : IUnknown
{
    HRESULT PeekMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, int* pfResult);
    HRESULT GetMessageA(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
    HRESULT PeekMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg, int* pfResult);
    HRESULT GetMessageW(MSG* pMsg, HWND hwnd, uint wMsgFilterMin, uint wMsgFilterMax, int* pfResult);
}

const GUID IID_ITfThreadFocusSink = {0xC0F1DB0C, 0x3A20, 0x405C, [0xA3, 0x03, 0x96, 0xB6, 0x01, 0x0A, 0x88, 0x5F]};
@GUID(0xC0F1DB0C, 0x3A20, 0x405C, [0xA3, 0x03, 0x96, 0xB6, 0x01, 0x0A, 0x88, 0x5F]);
interface ITfThreadFocusSink : IUnknown
{
    HRESULT OnSetThreadFocus();
    HRESULT OnKillThreadFocus();
}

const GUID IID_ITfTextInputProcessor = {0xAA80E7F7, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xAA80E7F7, 0x2021, 0x11D2, [0x93, 0xE0, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface ITfTextInputProcessor : IUnknown
{
    HRESULT Activate(ITfThreadMgr ptim, uint tid);
    HRESULT Deactivate();
}

const GUID IID_ITfTextInputProcessorEx = {0x6E4E2102, 0xF9CD, 0x433D, [0xB4, 0x96, 0x30, 0x3C, 0xE0, 0x3A, 0x65, 0x07]};
@GUID(0x6E4E2102, 0xF9CD, 0x433D, [0xB4, 0x96, 0x30, 0x3C, 0xE0, 0x3A, 0x65, 0x07]);
interface ITfTextInputProcessorEx : ITfTextInputProcessor
{
    HRESULT ActivateEx(ITfThreadMgr ptim, uint tid, uint dwFlags);
}

const GUID IID_ITfClientId = {0xD60A7B49, 0x1B9F, 0x4BE2, [0xB7, 0x02, 0x47, 0xE9, 0xDC, 0x05, 0xDE, 0xC3]};
@GUID(0xD60A7B49, 0x1B9F, 0x4BE2, [0xB7, 0x02, 0x47, 0xE9, 0xDC, 0x05, 0xDE, 0xC3]);
interface ITfClientId : IUnknown
{
    HRESULT GetClientId(const(Guid)* rclsid, uint* ptid);
}

enum TF_DA_LINESTYLE
{
    TF_LS_NONE = 0,
    TF_LS_SOLID = 1,
    TF_LS_DOT = 2,
    TF_LS_DASH = 3,
    TF_LS_SQUIGGLE = 4,
}

enum TF_DA_COLORTYPE
{
    TF_CT_NONE = 0,
    TF_CT_SYSCOLOR = 1,
    TF_CT_COLORREF = 2,
}

struct TF_DA_COLOR
{
    TF_DA_COLORTYPE type;
    _Anonymous_e__Union Anonymous;
}

enum TF_DA_ATTR_INFO
{
    TF_ATTR_INPUT = 0,
    TF_ATTR_TARGET_CONVERTED = 1,
    TF_ATTR_CONVERTED = 2,
    TF_ATTR_TARGET_NOTCONVERTED = 3,
    TF_ATTR_INPUT_ERROR = 4,
    TF_ATTR_FIXEDCONVERTED = 5,
    TF_ATTR_OTHER = -1,
}

struct TF_DISPLAYATTRIBUTE
{
    TF_DA_COLOR crText;
    TF_DA_COLOR crBk;
    TF_DA_LINESTYLE lsStyle;
    BOOL fBoldLine;
    TF_DA_COLOR crLine;
    TF_DA_ATTR_INFO bAttr;
}

const GUID IID_ITfDisplayAttributeInfo = {0x70528852, 0x2F26, 0x4AEA, [0x8C, 0x96, 0x21, 0x51, 0x50, 0x57, 0x89, 0x32]};
@GUID(0x70528852, 0x2F26, 0x4AEA, [0x8C, 0x96, 0x21, 0x51, 0x50, 0x57, 0x89, 0x32]);
interface ITfDisplayAttributeInfo : IUnknown
{
    HRESULT GetGUID(Guid* pguid);
    HRESULT GetDescription(BSTR* pbstrDesc);
    HRESULT GetAttributeInfo(TF_DISPLAYATTRIBUTE* pda);
    HRESULT SetAttributeInfo(const(TF_DISPLAYATTRIBUTE)* pda);
    HRESULT Reset();
}

const GUID IID_IEnumTfDisplayAttributeInfo = {0x7CEF04D7, 0xCB75, 0x4E80, [0xA7, 0xAB, 0x5F, 0x5B, 0xC7, 0xD3, 0x32, 0xDE]};
@GUID(0x7CEF04D7, 0xCB75, 0x4E80, [0xA7, 0xAB, 0x5F, 0x5B, 0xC7, 0xD3, 0x32, 0xDE]);
interface IEnumTfDisplayAttributeInfo : IUnknown
{
    HRESULT Clone(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT Next(uint ulCount, char* rgInfo, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfDisplayAttributeProvider = {0xFEE47777, 0x163C, 0x4769, [0x99, 0x6A, 0x6E, 0x9C, 0x50, 0xAD, 0x8F, 0x54]};
@GUID(0xFEE47777, 0x163C, 0x4769, [0x99, 0x6A, 0x6E, 0x9C, 0x50, 0xAD, 0x8F, 0x54]);
interface ITfDisplayAttributeProvider : IUnknown
{
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT GetDisplayAttributeInfo(const(Guid)* guid, ITfDisplayAttributeInfo* ppInfo);
}

const GUID IID_ITfDisplayAttributeMgr = {0x8DED7393, 0x5DB1, 0x475C, [0x9E, 0x71, 0xA3, 0x91, 0x11, 0xB0, 0xFF, 0x67]};
@GUID(0x8DED7393, 0x5DB1, 0x475C, [0x9E, 0x71, 0xA3, 0x91, 0x11, 0xB0, 0xFF, 0x67]);
interface ITfDisplayAttributeMgr : IUnknown
{
    HRESULT OnUpdateInfo();
    HRESULT EnumDisplayAttributeInfo(IEnumTfDisplayAttributeInfo* ppEnum);
    HRESULT GetDisplayAttributeInfo(const(Guid)* guid, ITfDisplayAttributeInfo* ppInfo, Guid* pclsidOwner);
}

const GUID IID_ITfDisplayAttributeNotifySink = {0xAD56F402, 0xE162, 0x4F25, [0x90, 0x8F, 0x7D, 0x57, 0x7C, 0xF9, 0xBD, 0xA9]};
@GUID(0xAD56F402, 0xE162, 0x4F25, [0x90, 0x8F, 0x7D, 0x57, 0x7C, 0xF9, 0xBD, 0xA9]);
interface ITfDisplayAttributeNotifySink : IUnknown
{
    HRESULT OnUpdateInfo();
}

const GUID IID_ITfCategoryMgr = {0xC3ACEFB5, 0xF69D, 0x4905, [0x93, 0x8F, 0xFC, 0xAD, 0xCF, 0x4B, 0xE8, 0x30]};
@GUID(0xC3ACEFB5, 0xF69D, 0x4905, [0x93, 0x8F, 0xFC, 0xAD, 0xCF, 0x4B, 0xE8, 0x30]);
interface ITfCategoryMgr : IUnknown
{
    HRESULT RegisterCategory(const(Guid)* rclsid, const(Guid)* rcatid, const(Guid)* rguid);
    HRESULT UnregisterCategory(const(Guid)* rclsid, const(Guid)* rcatid, const(Guid)* rguid);
    HRESULT EnumCategoriesInItem(const(Guid)* rguid, IEnumGUID* ppEnum);
    HRESULT EnumItemsInCategory(const(Guid)* rcatid, IEnumGUID* ppEnum);
    HRESULT FindClosestCategory(const(Guid)* rguid, Guid* pcatid, const(Guid)** ppcatidList, uint ulCount);
    HRESULT RegisterGUIDDescription(const(Guid)* rclsid, const(Guid)* rguid, const(wchar)* pchDesc, uint cch);
    HRESULT UnregisterGUIDDescription(const(Guid)* rclsid, const(Guid)* rguid);
    HRESULT GetGUIDDescription(const(Guid)* rguid, BSTR* pbstrDesc);
    HRESULT RegisterGUIDDWORD(const(Guid)* rclsid, const(Guid)* rguid, uint dw);
    HRESULT UnregisterGUIDDWORD(const(Guid)* rclsid, const(Guid)* rguid);
    HRESULT GetGUIDDWORD(const(Guid)* rguid, uint* pdw);
    HRESULT RegisterGUID(const(Guid)* rguid, uint* pguidatom);
    HRESULT GetGUID(uint guidatom, Guid* pguid);
    HRESULT IsEqualTfGuidAtom(uint guidatom, const(Guid)* rguid, int* pfEqual);
}

const GUID IID_ITfSource = {0x4EA48A35, 0x60AE, 0x446F, [0x8F, 0xD6, 0xE6, 0xA8, 0xD8, 0x24, 0x59, 0xF7]};
@GUID(0x4EA48A35, 0x60AE, 0x446F, [0x8F, 0xD6, 0xE6, 0xA8, 0xD8, 0x24, 0x59, 0xF7]);
interface ITfSource : IUnknown
{
    HRESULT AdviseSink(const(Guid)* riid, IUnknown punk, uint* pdwCookie);
    HRESULT UnadviseSink(uint dwCookie);
}

const GUID IID_ITfSourceSingle = {0x73131F9C, 0x56A9, 0x49DD, [0xB0, 0xEE, 0xD0, 0x46, 0x63, 0x3F, 0x75, 0x28]};
@GUID(0x73131F9C, 0x56A9, 0x49DD, [0xB0, 0xEE, 0xD0, 0x46, 0x63, 0x3F, 0x75, 0x28]);
interface ITfSourceSingle : IUnknown
{
    HRESULT AdviseSingleSink(uint tid, const(Guid)* riid, IUnknown punk);
    HRESULT UnadviseSingleSink(uint tid, const(Guid)* riid);
}

const GUID IID_ITfUIElementMgr = {0xEA1EA135, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0xEA1EA135, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfUIElementMgr : IUnknown
{
    HRESULT BeginUIElement(ITfUIElement pElement, int* pbShow, uint* pdwUIElementId);
    HRESULT UpdateUIElement(uint dwUIElementId);
    HRESULT EndUIElement(uint dwUIElementId);
    HRESULT GetUIElement(uint dwUIELementId, ITfUIElement* ppElement);
    HRESULT EnumUIElements(IEnumTfUIElements* ppEnum);
}

const GUID IID_IEnumTfUIElements = {0x887AA91E, 0xACBA, 0x4931, [0x84, 0xDA, 0x3C, 0x52, 0x08, 0xCF, 0x54, 0x3F]};
@GUID(0x887AA91E, 0xACBA, 0x4931, [0x84, 0xDA, 0x3C, 0x52, 0x08, 0xCF, 0x54, 0x3F]);
interface IEnumTfUIElements : IUnknown
{
    HRESULT Clone(IEnumTfUIElements* ppEnum);
    HRESULT Next(uint ulCount, ITfUIElement* ppElement, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfUIElementSink = {0xEA1EA136, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0xEA1EA136, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfUIElementSink : IUnknown
{
    HRESULT BeginUIElement(uint dwUIElementId, int* pbShow);
    HRESULT UpdateUIElement(uint dwUIElementId);
    HRESULT EndUIElement(uint dwUIElementId);
}

const GUID IID_ITfUIElement = {0xEA1EA137, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0xEA1EA137, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfUIElement : IUnknown
{
    HRESULT GetDescription(BSTR* pbstrDescription);
    HRESULT GetGUID(Guid* pguid);
    HRESULT Show(BOOL bShow);
    HRESULT IsShown(int* pbShow);
}

const GUID IID_ITfCandidateListUIElement = {0xEA1EA138, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0xEA1EA138, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
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

const GUID IID_ITfCandidateListUIElementBehavior = {0x85FAD185, 0x58CE, 0x497A, [0x94, 0x60, 0x35, 0x53, 0x66, 0xB6, 0x4B, 0x9A]};
@GUID(0x85FAD185, 0x58CE, 0x497A, [0x94, 0x60, 0x35, 0x53, 0x66, 0xB6, 0x4B, 0x9A]);
interface ITfCandidateListUIElementBehavior : ITfCandidateListUIElement
{
    HRESULT SetSelection(uint nIndex);
    HRESULT Finalize();
    HRESULT Abort();
}

const GUID IID_ITfReadingInformationUIElement = {0xEA1EA139, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]};
@GUID(0xEA1EA139, 0x19DF, 0x11D7, [0xA6, 0xD2, 0x00, 0x06, 0x5B, 0x84, 0x43, 0x5C]);
interface ITfReadingInformationUIElement : ITfUIElement
{
    HRESULT GetUpdatedFlags(uint* pdwFlags);
    HRESULT GetContext(ITfContext* ppic);
    HRESULT GetString(BSTR* pstr);
    HRESULT GetMaxReadingStringLength(uint* pcchMax);
    HRESULT GetErrorIndex(uint* pErrorIndex);
    HRESULT IsVerticalOrderPreferred(int* pfVertical);
}

const GUID IID_ITfTransitoryExtensionUIElement = {0x858F956A, 0x972F, 0x42A2, [0xA2, 0xF2, 0x03, 0x21, 0xE1, 0xAB, 0xE2, 0x09]};
@GUID(0x858F956A, 0x972F, 0x42A2, [0xA2, 0xF2, 0x03, 0x21, 0xE1, 0xAB, 0xE2, 0x09]);
interface ITfTransitoryExtensionUIElement : ITfUIElement
{
    HRESULT GetDocumentMgr(ITfDocumentMgr* ppdim);
}

const GUID IID_ITfTransitoryExtensionSink = {0xA615096F, 0x1C57, 0x4813, [0x8A, 0x15, 0x55, 0xEE, 0x6E, 0x5A, 0x83, 0x9C]};
@GUID(0xA615096F, 0x1C57, 0x4813, [0x8A, 0x15, 0x55, 0xEE, 0x6E, 0x5A, 0x83, 0x9C]);
interface ITfTransitoryExtensionSink : IUnknown
{
    HRESULT OnTransitoryExtensionUpdated(ITfContext pic, uint ecReadOnly, ITfRange pResultRange, ITfRange pCompositionRange, int* pfDeleteResultRange);
}

const GUID IID_ITfToolTipUIElement = {0x52B18B5C, 0x555D, 0x46B2, [0xB0, 0x0A, 0xFA, 0x68, 0x01, 0x44, 0xFB, 0xDB]};
@GUID(0x52B18B5C, 0x555D, 0x46B2, [0xB0, 0x0A, 0xFA, 0x68, 0x01, 0x44, 0xFB, 0xDB]);
interface ITfToolTipUIElement : ITfUIElement
{
    HRESULT GetString(BSTR* pstr);
}

const GUID IID_ITfReverseConversionList = {0x151D69F0, 0x86F4, 0x4674, [0xB7, 0x21, 0x56, 0x91, 0x1E, 0x79, 0x7F, 0x47]};
@GUID(0x151D69F0, 0x86F4, 0x4674, [0xB7, 0x21, 0x56, 0x91, 0x1E, 0x79, 0x7F, 0x47]);
interface ITfReverseConversionList : IUnknown
{
    HRESULT GetLength(uint* puIndex);
    HRESULT GetString(uint uIndex, BSTR* pbstr);
}

const GUID IID_ITfReverseConversion = {0xA415E162, 0x157D, 0x417D, [0x8A, 0x8C, 0x0A, 0xB2, 0x6C, 0x7D, 0x27, 0x81]};
@GUID(0xA415E162, 0x157D, 0x417D, [0x8A, 0x8C, 0x0A, 0xB2, 0x6C, 0x7D, 0x27, 0x81]);
interface ITfReverseConversion : IUnknown
{
    HRESULT DoReverseConversion(const(wchar)* lpstr, ITfReverseConversionList* ppList);
}

const GUID IID_ITfReverseConversionMgr = {0xB643C236, 0xC493, 0x41B6, [0xAB, 0xB3, 0x69, 0x24, 0x12, 0x77, 0x5C, 0xC4]};
@GUID(0xB643C236, 0xC493, 0x41B6, [0xAB, 0xB3, 0x69, 0x24, 0x12, 0x77, 0x5C, 0xC4]);
interface ITfReverseConversionMgr : IUnknown
{
    HRESULT GetReverseConversion(ushort langid, const(Guid)* guidProfile, uint dwflag, ITfReverseConversion* ppReverseConversion);
}

const GUID IID_ITfCandidateString = {0x581F317E, 0xFD9D, 0x443F, [0xB9, 0x72, 0xED, 0x00, 0x46, 0x7C, 0x5D, 0x40]};
@GUID(0x581F317E, 0xFD9D, 0x443F, [0xB9, 0x72, 0xED, 0x00, 0x46, 0x7C, 0x5D, 0x40]);
interface ITfCandidateString : IUnknown
{
    HRESULT GetString(BSTR* pbstr);
    HRESULT GetIndex(uint* pnIndex);
}

const GUID IID_IEnumTfCandidates = {0xDEFB1926, 0x6C80, 0x4CE8, [0x87, 0xD4, 0xD6, 0xB7, 0x2B, 0x81, 0x2B, 0xDE]};
@GUID(0xDEFB1926, 0x6C80, 0x4CE8, [0x87, 0xD4, 0xD6, 0xB7, 0x2B, 0x81, 0x2B, 0xDE]);
interface IEnumTfCandidates : IUnknown
{
    HRESULT Clone(IEnumTfCandidates* ppEnum);
    HRESULT Next(uint ulCount, char* ppCand, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

enum TfCandidateResult
{
    CAND_FINALIZED = 0,
    CAND_SELECTED = 1,
    CAND_CANCELED = 2,
}

const GUID IID_ITfCandidateList = {0xA3AD50FB, 0x9BDB, 0x49E3, [0xA8, 0x43, 0x6C, 0x76, 0x52, 0x0F, 0xBF, 0x5D]};
@GUID(0xA3AD50FB, 0x9BDB, 0x49E3, [0xA8, 0x43, 0x6C, 0x76, 0x52, 0x0F, 0xBF, 0x5D]);
interface ITfCandidateList : IUnknown
{
    HRESULT EnumCandidates(IEnumTfCandidates* ppEnum);
    HRESULT GetCandidate(uint nIndex, ITfCandidateString* ppCand);
    HRESULT GetCandidateNum(uint* pnCnt);
    HRESULT SetResult(uint nIndex, TfCandidateResult imcr);
}

const GUID IID_ITfFnReconversion = {0x4CEA93C0, 0x0A58, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]};
@GUID(0x4CEA93C0, 0x0A58, 0x11D3, [0x8D, 0xF0, 0x00, 0x10, 0x5A, 0x27, 0x99, 0xB5]);
interface ITfFnReconversion : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfConvertable);
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    HRESULT Reconvert(ITfRange pRange);
}

const GUID IID_ITfFnPlayBack = {0xA3A416A4, 0x0F64, 0x11D3, [0xB5, 0xB7, 0x00, 0xC0, 0x4F, 0xC3, 0x24, 0xA1]};
@GUID(0xA3A416A4, 0x0F64, 0x11D3, [0xB5, 0xB7, 0x00, 0xC0, 0x4F, 0xC3, 0x24, 0xA1]);
interface ITfFnPlayBack : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfPlayable);
    HRESULT Play(ITfRange pRange);
}

const GUID IID_ITfFnLangProfileUtil = {0xA87A8574, 0xA6C1, 0x4E15, [0x99, 0xF0, 0x3D, 0x39, 0x65, 0xF5, 0x48, 0xEB]};
@GUID(0xA87A8574, 0xA6C1, 0x4E15, [0x99, 0xF0, 0x3D, 0x39, 0x65, 0xF5, 0x48, 0xEB]);
interface ITfFnLangProfileUtil : ITfFunction
{
    HRESULT RegisterActiveProfiles();
    HRESULT IsProfileAvailableForLang(ushort langid, int* pfAvailable);
}

const GUID IID_ITfFnConfigure = {0x88F567C6, 0x1757, 0x49F8, [0xA1, 0xB2, 0x89, 0x23, 0x4C, 0x1E, 0xEF, 0xF9]};
@GUID(0x88F567C6, 0x1757, 0x49F8, [0xA1, 0xB2, 0x89, 0x23, 0x4C, 0x1E, 0xEF, 0xF9]);
interface ITfFnConfigure : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(Guid)* rguidProfile);
}

const GUID IID_ITfFnConfigureRegisterWord = {0xBB95808A, 0x6D8F, 0x4BCA, [0x84, 0x00, 0x53, 0x90, 0xB5, 0x86, 0xAE, 0xDF]};
@GUID(0xBB95808A, 0x6D8F, 0x4BCA, [0x84, 0x00, 0x53, 0x90, 0xB5, 0x86, 0xAE, 0xDF]);
interface ITfFnConfigureRegisterWord : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(Guid)* rguidProfile, BSTR bstrRegistered);
}

const GUID IID_ITfFnConfigureRegisterEudc = {0xB5E26FF5, 0xD7AD, 0x4304, [0x91, 0x3F, 0x21, 0xA2, 0xED, 0x95, 0xA1, 0xB0]};
@GUID(0xB5E26FF5, 0xD7AD, 0x4304, [0x91, 0x3F, 0x21, 0xA2, 0xED, 0x95, 0xA1, 0xB0]);
interface ITfFnConfigureRegisterEudc : ITfFunction
{
    HRESULT Show(HWND hwndParent, ushort langid, const(Guid)* rguidProfile, BSTR bstrRegistered);
}

const GUID IID_ITfFnShowHelp = {0x5AB1D30C, 0x094D, 0x4C29, [0x8E, 0xA5, 0x0B, 0xF5, 0x9B, 0xE8, 0x7B, 0xF3]};
@GUID(0x5AB1D30C, 0x094D, 0x4C29, [0x8E, 0xA5, 0x0B, 0xF5, 0x9B, 0xE8, 0x7B, 0xF3]);
interface ITfFnShowHelp : ITfFunction
{
    HRESULT Show(HWND hwndParent);
}

const GUID IID_ITfFnBalloon = {0x3BAB89E4, 0x5FBE, 0x45F4, [0xA5, 0xBC, 0xDC, 0xA3, 0x6A, 0xD2, 0x25, 0xA8]};
@GUID(0x3BAB89E4, 0x5FBE, 0x45F4, [0xA5, 0xBC, 0xDC, 0xA3, 0x6A, 0xD2, 0x25, 0xA8]);
interface ITfFnBalloon : IUnknown
{
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}

enum TfSapiObject
{
    GETIF_RESMGR = 0,
    GETIF_RECOCONTEXT = 1,
    GETIF_RECOGNIZER = 2,
    GETIF_VOICE = 3,
    GETIF_DICTGRAM = 4,
    GETIF_RECOGNIZERNOINIT = 5,
}

const GUID IID_ITfFnGetSAPIObject = {0x5C0AB7EA, 0x167D, 0x4F59, [0xBF, 0xB5, 0x46, 0x93, 0x75, 0x5E, 0x90, 0xCA]};
@GUID(0x5C0AB7EA, 0x167D, 0x4F59, [0xBF, 0xB5, 0x46, 0x93, 0x75, 0x5E, 0x90, 0xCA]);
interface ITfFnGetSAPIObject : ITfFunction
{
    HRESULT Get(TfSapiObject sObj, IUnknown* ppunk);
}

const GUID IID_ITfFnPropertyUIStatus = {0x2338AC6E, 0x2B9D, 0x44C0, [0xA7, 0x5E, 0xEE, 0x64, 0xF2, 0x56, 0xB3, 0xBD]};
@GUID(0x2338AC6E, 0x2B9D, 0x44C0, [0xA7, 0x5E, 0xEE, 0x64, 0xF2, 0x56, 0xB3, 0xBD]);
interface ITfFnPropertyUIStatus : ITfFunction
{
    HRESULT GetStatus(const(Guid)* refguidProp, uint* pdw);
    HRESULT SetStatus(const(Guid)* refguidProp, uint dw);
}

const GUID IID_ITfFnLMProcessor = {0x7AFBF8E7, 0xAC4B, 0x4082, [0xB0, 0x58, 0x89, 0x08, 0x99, 0xD3, 0xA0, 0x10]};
@GUID(0x7AFBF8E7, 0xAC4B, 0x4082, [0xB0, 0x58, 0x89, 0x08, 0x99, 0xD3, 0xA0, 0x10]);
interface ITfFnLMProcessor : ITfFunction
{
    HRESULT QueryRange(ITfRange pRange, ITfRange* ppNewRange, int* pfAccepted);
    HRESULT QueryLangID(ushort langid, int* pfAccepted);
    HRESULT GetReconversion(ITfRange pRange, ITfCandidateList* ppCandList);
    HRESULT Reconvert(ITfRange pRange);
    HRESULT QueryKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeydata, int* pfInterested);
    HRESULT InvokeKey(BOOL fUp, WPARAM vKey, LPARAM lparamKeyData);
    HRESULT InvokeFunc(ITfContext pic, const(Guid)* refguidFunc);
}

const GUID IID_ITfFnLMInternal = {0x04B825B1, 0xAC9A, 0x4F7B, [0xB5, 0xAD, 0xC7, 0x16, 0x8F, 0x1E, 0xE4, 0x45]};
@GUID(0x04B825B1, 0xAC9A, 0x4F7B, [0xB5, 0xAD, 0xC7, 0x16, 0x8F, 0x1E, 0xE4, 0x45]);
interface ITfFnLMInternal : ITfFnLMProcessor
{
    HRESULT ProcessLattice(ITfRange pRange);
}

struct TF_LMLATTELEMENT
{
    uint dwFrameStart;
    uint dwFrameLen;
    uint dwFlags;
    _Anonymous_e__Union Anonymous;
    BSTR bstrText;
}

const GUID IID_IEnumTfLatticeElements = {0x56988052, 0x47DA, 0x4A05, [0x91, 0x1A, 0xE3, 0xD9, 0x41, 0xF1, 0x71, 0x45]};
@GUID(0x56988052, 0x47DA, 0x4A05, [0x91, 0x1A, 0xE3, 0xD9, 0x41, 0xF1, 0x71, 0x45]);
interface IEnumTfLatticeElements : IUnknown
{
    HRESULT Clone(IEnumTfLatticeElements* ppEnum);
    HRESULT Next(uint ulCount, char* rgsElements, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_ITfLMLattice = {0xD4236675, 0xA5BF, 0x4570, [0x9D, 0x42, 0x5D, 0x6D, 0x7B, 0x02, 0xD5, 0x9B]};
@GUID(0xD4236675, 0xA5BF, 0x4570, [0x9D, 0x42, 0x5D, 0x6D, 0x7B, 0x02, 0xD5, 0x9B]);
interface ITfLMLattice : IUnknown
{
    HRESULT QueryType(const(Guid)* rguidType, int* pfSupported);
    HRESULT EnumLatticeElements(uint dwFrameStart, const(Guid)* rguidType, IEnumTfLatticeElements* ppEnum);
}

const GUID IID_ITfFnAdviseText = {0x3527268B, 0x7D53, 0x4DD9, [0x92, 0xB7, 0x72, 0x96, 0xAE, 0x46, 0x12, 0x49]};
@GUID(0x3527268B, 0x7D53, 0x4DD9, [0x92, 0xB7, 0x72, 0x96, 0xAE, 0x46, 0x12, 0x49]);
interface ITfFnAdviseText : ITfFunction
{
    HRESULT OnTextUpdate(ITfRange pRange, const(wchar)* pchText, int cch);
    HRESULT OnLatticeUpdate(ITfRange pRange, ITfLMLattice pLattice);
}

const GUID IID_ITfFnSearchCandidateProvider = {0x87A2AD8F, 0xF27B, 0x4920, [0x85, 0x01, 0x67, 0x60, 0x22, 0x80, 0x17, 0x5D]};
@GUID(0x87A2AD8F, 0xF27B, 0x4920, [0x85, 0x01, 0x67, 0x60, 0x22, 0x80, 0x17, 0x5D]);
interface ITfFnSearchCandidateProvider : ITfFunction
{
    HRESULT GetSearchCandidates(BSTR bstrQuery, BSTR bstrApplicationId, ITfCandidateList* pplist);
    HRESULT SetResult(BSTR bstrQuery, BSTR bstrApplicationID, BSTR bstrResult);
}

enum TfIntegratableCandidateListSelectionStyle
{
    STYLE_ACTIVE_SELECTION = 0,
    STYLE_IMPLIED_SELECTION = 1,
}

const GUID IID_ITfIntegratableCandidateListUIElement = {0xC7A6F54F, 0xB180, 0x416F, [0xB2, 0xBF, 0x7B, 0xF2, 0xE4, 0x68, 0x3D, 0x7B]};
@GUID(0xC7A6F54F, 0xB180, 0x416F, [0xB2, 0xBF, 0x7B, 0xF2, 0xE4, 0x68, 0x3D, 0x7B]);
interface ITfIntegratableCandidateListUIElement : IUnknown
{
    HRESULT SetIntegrationStyle(Guid guidIntegrationStyle);
    HRESULT GetSelectionStyle(TfIntegratableCandidateListSelectionStyle* ptfSelectionStyle);
    HRESULT OnKeyDown(WPARAM wParam, LPARAM lParam, int* pfEaten);
    HRESULT ShowCandidateNumbers(int* pfShow);
    HRESULT FinalizeExactCompositionString();
}

enum TKBLayoutType
{
    TKBLT_UNDEFINED = 0,
    TKBLT_CLASSIC = 1,
    TKBLT_OPTIMIZED = 2,
}

const GUID IID_ITfFnGetPreferredTouchKeyboardLayout = {0x5F309A41, 0x590A, 0x4ACC, [0xA9, 0x7F, 0xD8, 0xEF, 0xFF, 0x13, 0xFD, 0xFC]};
@GUID(0x5F309A41, 0x590A, 0x4ACC, [0xA9, 0x7F, 0xD8, 0xEF, 0xFF, 0x13, 0xFD, 0xFC]);
interface ITfFnGetPreferredTouchKeyboardLayout : ITfFunction
{
    HRESULT GetLayout(TKBLayoutType* pTKBLayoutType, ushort* pwPreferredLayoutId);
}

const GUID IID_ITfFnGetLinguisticAlternates = {0xEA163CE2, 0x7A65, 0x4506, [0x82, 0xA3, 0xC5, 0x28, 0x21, 0x5D, 0xA6, 0x4E]};
@GUID(0xEA163CE2, 0x7A65, 0x4506, [0x82, 0xA3, 0xC5, 0x28, 0x21, 0x5D, 0xA6, 0x4E]);
interface ITfFnGetLinguisticAlternates : ITfFunction
{
    HRESULT GetAlternates(ITfRange pRange, ITfCandidateList* ppCandidateList);
}

const GUID IID_IUIManagerEventSink = {0xCD91D690, 0xA7E8, 0x4265, [0x9B, 0x38, 0x8B, 0xB3, 0xBB, 0xAB, 0xA7, 0xDE]};
@GUID(0xCD91D690, 0xA7E8, 0x4265, [0x9B, 0x38, 0x8B, 0xB3, 0xBB, 0xAB, 0xA7, 0xDE]);
interface IUIManagerEventSink : IUnknown
{
    HRESULT OnWindowOpening(RECT* prcBounds);
    HRESULT OnWindowOpened(RECT* prcBounds);
    HRESULT OnWindowUpdating(RECT* prcUpdatedBounds);
    HRESULT OnWindowUpdated(RECT* prcUpdatedBounds);
    HRESULT OnWindowClosing();
    HRESULT OnWindowClosed();
}

enum InputScope
{
    IS_DEFAULT = 0,
    IS_URL = 1,
    IS_FILE_FULLFILEPATH = 2,
    IS_FILE_FILENAME = 3,
    IS_EMAIL_USERNAME = 4,
    IS_EMAIL_SMTPEMAILADDRESS = 5,
    IS_LOGINNAME = 6,
    IS_PERSONALNAME_FULLNAME = 7,
    IS_PERSONALNAME_PREFIX = 8,
    IS_PERSONALNAME_GIVENNAME = 9,
    IS_PERSONALNAME_MIDDLENAME = 10,
    IS_PERSONALNAME_SURNAME = 11,
    IS_PERSONALNAME_SUFFIX = 12,
    IS_ADDRESS_FULLPOSTALADDRESS = 13,
    IS_ADDRESS_POSTALCODE = 14,
    IS_ADDRESS_STREET = 15,
    IS_ADDRESS_STATEORPROVINCE = 16,
    IS_ADDRESS_CITY = 17,
    IS_ADDRESS_COUNTRYNAME = 18,
    IS_ADDRESS_COUNTRYSHORTNAME = 19,
    IS_CURRENCY_AMOUNTANDSYMBOL = 20,
    IS_CURRENCY_AMOUNT = 21,
    IS_DATE_FULLDATE = 22,
    IS_DATE_MONTH = 23,
    IS_DATE_DAY = 24,
    IS_DATE_YEAR = 25,
    IS_DATE_MONTHNAME = 26,
    IS_DATE_DAYNAME = 27,
    IS_DIGITS = 28,
    IS_NUMBER = 29,
    IS_ONECHAR = 30,
    IS_PASSWORD = 31,
    IS_TELEPHONE_FULLTELEPHONENUMBER = 32,
    IS_TELEPHONE_COUNTRYCODE = 33,
    IS_TELEPHONE_AREACODE = 34,
    IS_TELEPHONE_LOCALNUMBER = 35,
    IS_TIME_FULLTIME = 36,
    IS_TIME_HOUR = 37,
    IS_TIME_MINORSEC = 38,
    IS_NUMBER_FULLWIDTH = 39,
    IS_ALPHANUMERIC_HALFWIDTH = 40,
    IS_ALPHANUMERIC_FULLWIDTH = 41,
    IS_CURRENCY_CHINESE = 42,
    IS_BOPOMOFO = 43,
    IS_HIRAGANA = 44,
    IS_KATAKANA_HALFWIDTH = 45,
    IS_KATAKANA_FULLWIDTH = 46,
    IS_HANJA = 47,
    IS_HANGUL_HALFWIDTH = 48,
    IS_HANGUL_FULLWIDTH = 49,
    IS_SEARCH = 50,
    IS_FORMULA = 51,
    IS_SEARCH_INCREMENTAL = 52,
    IS_CHINESE_HALFWIDTH = 53,
    IS_CHINESE_FULLWIDTH = 54,
    IS_NATIVE_SCRIPT = 55,
    IS_YOMI = 56,
    IS_TEXT = 57,
    IS_CHAT = 58,
    IS_NAME_OR_PHONENUMBER = 59,
    IS_EMAILNAME_OR_ADDRESS = 60,
    IS_PRIVATE = 61,
    IS_MAPS = 62,
    IS_NUMERIC_PASSWORD = 63,
    IS_NUMERIC_PIN = 64,
    IS_ALPHANUMERIC_PIN = 65,
    IS_ALPHANUMERIC_PIN_SET = 66,
    IS_FORMULA_NUMBER = 67,
    IS_CHAT_WITHOUT_EMOJI = 68,
    IS_PHRASELIST = -1,
    IS_REGULAREXPRESSION = -2,
    IS_SRGS = -3,
    IS_XML = -4,
    IS_ENUMSTRING = -5,
}

const GUID IID_ITfInputScope = {0xFDE1EAEE, 0x6924, 0x4CDF, [0x91, 0xE7, 0xDA, 0x38, 0xCF, 0xF5, 0x55, 0x9D]};
@GUID(0xFDE1EAEE, 0x6924, 0x4CDF, [0x91, 0xE7, 0xDA, 0x38, 0xCF, 0xF5, 0x55, 0x9D]);
interface ITfInputScope : IUnknown
{
    HRESULT GetInputScopes(char* pprgInputScopes, uint* pcCount);
    HRESULT GetPhrase(char* ppbstrPhrases, uint* pcCount);
    HRESULT GetRegularExpression(BSTR* pbstrRegExp);
    HRESULT GetSRGS(BSTR* pbstrSRGS);
    HRESULT GetXML(BSTR* pbstrXML);
}

const GUID IID_ITfInputScope2 = {0x5731EAA0, 0x6BC2, 0x4681, [0xA5, 0x32, 0x92, 0xFB, 0xB7, 0x4D, 0x7C, 0x41]};
@GUID(0x5731EAA0, 0x6BC2, 0x4681, [0xA5, 0x32, 0x92, 0xFB, 0xB7, 0x4D, 0x7C, 0x41]);
interface ITfInputScope2 : ITfInputScope
{
    HRESULT EnumWordList(IEnumString* ppEnumString);
}

const GUID IID_ITfSpeechUIServer = {0x90E9A944, 0x9244, 0x489F, [0xA7, 0x8F, 0xDE, 0x67, 0xAF, 0xC0, 0x13, 0xA7]};
@GUID(0x90E9A944, 0x9244, 0x489F, [0xA7, 0x8F, 0xDE, 0x67, 0xAF, 0xC0, 0x13, 0xA7]);
interface ITfSpeechUIServer : IUnknown
{
    HRESULT Initialize();
    HRESULT ShowUI(BOOL fShow);
    HRESULT UpdateBalloon(TfLBBalloonStyle style, const(wchar)* pch, uint cch);
}

@DllImport("MsCtfMonitor.dll")
HRESULT InitLocalMsCtfMonitor(uint dwFlags);

@DllImport("MsCtfMonitor.dll")
HRESULT UninitLocalMsCtfMonitor();

