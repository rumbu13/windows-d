module windows.controls;

public import system;
public import windows.automation;
public import windows.com;
public import windows.direct2d;
public import windows.displaydevices;
public import windows.gdi;
public import windows.intl;
public import windows.menusandresources;
public import windows.mmc;
public import windows.pointerinput;
public import windows.shell;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsaccessibility;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;

extern(Windows):

alias HIMAGELIST = int;
alias HPROPSHEETPAGE = int;
struct CRGB
{
    ubyte bRed;
    ubyte bGreen;
    ubyte bBlue;
    ubyte bExtra;
}

struct _PSP
{
}

alias LPFNPSPCALLBACKA = extern(Windows) uint function(HWND hwnd, uint uMsg, PROPSHEETPAGEA* ppsp);
alias LPFNPSPCALLBACKW = extern(Windows) uint function(HWND hwnd, uint uMsg, PROPSHEETPAGEW* ppsp);
struct PROPSHEETPAGEA_V1
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(char)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint* pcRefParent;
}

struct PROPSHEETPAGEA_V2
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(char)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint* pcRefParent;
    const(char)* pszHeaderTitle;
    const(char)* pszHeaderSubTitle;
}

struct PROPSHEETPAGEA_V3
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(char)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint* pcRefParent;
    const(char)* pszHeaderTitle;
    const(char)* pszHeaderSubTitle;
    HANDLE hActCtx;
}

struct PROPSHEETPAGEA
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(char)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKA pfnCallback;
    uint* pcRefParent;
    const(char)* pszHeaderTitle;
    const(char)* pszHeaderSubTitle;
    HANDLE hActCtx;
    _Anonymous3_e__Union Anonymous3;
}

struct PROPSHEETPAGEW_V1
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint* pcRefParent;
}

struct PROPSHEETPAGEW_V2
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint* pcRefParent;
    const(wchar)* pszHeaderTitle;
    const(wchar)* pszHeaderSubTitle;
}

struct PROPSHEETPAGEW_V3
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint* pcRefParent;
    const(wchar)* pszHeaderTitle;
    const(wchar)* pszHeaderSubTitle;
    HANDLE hActCtx;
}

struct PROPSHEETPAGEW
{
    uint dwSize;
    uint dwFlags;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pszTitle;
    DLGPROC pfnDlgProc;
    LPARAM lParam;
    LPFNPSPCALLBACKW pfnCallback;
    uint* pcRefParent;
    const(wchar)* pszHeaderTitle;
    const(wchar)* pszHeaderSubTitle;
    HANDLE hActCtx;
    _Anonymous3_e__Union Anonymous3;
}

alias PFNPROPSHEETCALLBACK = extern(Windows) int function(HWND param0, uint param1, LPARAM param2);
struct PROPSHEETHEADERA_V1
{
    uint dwSize;
    uint dwFlags;
    HWND hwndParent;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    const(char)* pszCaption;
    uint nPages;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    PFNPROPSHEETCALLBACK pfnCallback;
}

struct PROPSHEETHEADERA_V2
{
    uint dwSize;
    uint dwFlags;
    HWND hwndParent;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    const(char)* pszCaption;
    uint nPages;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    PFNPROPSHEETCALLBACK pfnCallback;
    _Anonymous4_e__Union Anonymous4;
    HPALETTE hplWatermark;
    _Anonymous5_e__Union Anonymous5;
}

struct PROPSHEETHEADERW_V1
{
    uint dwSize;
    uint dwFlags;
    HWND hwndParent;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    const(wchar)* pszCaption;
    uint nPages;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    PFNPROPSHEETCALLBACK pfnCallback;
}

struct PROPSHEETHEADERW_V2
{
    uint dwSize;
    uint dwFlags;
    HWND hwndParent;
    HINSTANCE hInstance;
    _Anonymous1_e__Union Anonymous1;
    const(wchar)* pszCaption;
    uint nPages;
    _Anonymous2_e__Union Anonymous2;
    _Anonymous3_e__Union Anonymous3;
    PFNPROPSHEETCALLBACK pfnCallback;
    _Anonymous4_e__Union Anonymous4;
    HPALETTE hplWatermark;
    _Anonymous5_e__Union Anonymous5;
}

alias LPFNADDPROPSHEETPAGE = extern(Windows) BOOL function(HPROPSHEETPAGE param0, LPARAM param1);
alias LPFNADDPROPSHEETPAGES = extern(Windows) BOOL function(void* param0, LPFNADDPROPSHEETPAGE param1, LPARAM param2);
struct PSHNOTIFY
{
    NMHDR hdr;
    LPARAM lParam;
}

struct INITCOMMONCONTROLSEX
{
    uint dwSize;
    uint dwICC;
}

struct COLORSCHEME
{
    uint dwSize;
    uint clrBtnHighlight;
    uint clrBtnShadow;
}

struct NMTOOLTIPSCREATED
{
    NMHDR hdr;
    HWND hwndToolTips;
}

struct NMMOUSE
{
    NMHDR hdr;
    uint dwItemSpec;
    uint dwItemData;
    POINT pt;
    LPARAM dwHitInfo;
}

struct NMOBJECTNOTIFY
{
    NMHDR hdr;
    int iItem;
    const(Guid)* piid;
    void* pObject;
    HRESULT hResult;
    uint dwFlags;
}

struct NMKEY
{
    NMHDR hdr;
    uint nVKey;
    uint uFlags;
}

struct NMCHAR
{
    NMHDR hdr;
    uint ch;
    uint dwItemPrev;
    uint dwItemNext;
}

struct NMCUSTOMTEXT
{
    NMHDR hdr;
    HDC hDC;
    const(wchar)* lpString;
    int nCount;
    RECT* lpRect;
    uint uFormat;
    BOOL fLink;
}

struct NMCUSTOMDRAW
{
    NMHDR hdr;
    uint dwDrawStage;
    HDC hdc;
    RECT rc;
    uint dwItemSpec;
    uint uItemState;
    LPARAM lItemlParam;
}

struct NMTTCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint uDrawFlags;
}

struct NMCUSTOMSPLITRECTINFO
{
    NMHDR hdr;
    RECT rcClient;
    RECT rcButton;
    RECT rcSplit;
}

struct _IMAGELIST
{
}

struct IMAGELISTDRAWPARAMS
{
    uint cbSize;
    HIMAGELIST himl;
    int i;
    HDC hdcDst;
    int x;
    int y;
    int cx;
    int cy;
    int xBitmap;
    int yBitmap;
    uint rgbBk;
    uint rgbFg;
    uint fStyle;
    uint dwRop;
    uint fState;
    uint Frame;
    uint crEffect;
}

struct IMAGEINFO
{
    HBITMAP hbmImage;
    HBITMAP hbmMask;
    int Unused1;
    int Unused2;
    RECT rcImage;
}

struct HD_TEXTFILTERA
{
    const(char)* pszText;
    int cchTextMax;
}

struct HD_TEXTFILTERW
{
    const(wchar)* pszText;
    int cchTextMax;
}

struct HDITEMA
{
    uint mask;
    int cxy;
    const(char)* pszText;
    HBITMAP hbm;
    int cchTextMax;
    int fmt;
    LPARAM lParam;
    int iImage;
    int iOrder;
    uint type;
    void* pvFilter;
    uint state;
}

struct HDITEMW
{
    uint mask;
    int cxy;
    const(wchar)* pszText;
    HBITMAP hbm;
    int cchTextMax;
    int fmt;
    LPARAM lParam;
    int iImage;
    int iOrder;
    uint type;
    void* pvFilter;
    uint state;
}

struct HDLAYOUT
{
    RECT* prc;
    WINDOWPOS* pwpos;
}

struct HDHITTESTINFO
{
    POINT pt;
    uint flags;
    int iItem;
}

struct NMHEADERA
{
    NMHDR hdr;
    int iItem;
    int iButton;
    HDITEMA* pitem;
}

struct NMHEADERW
{
    NMHDR hdr;
    int iItem;
    int iButton;
    HDITEMW* pitem;
}

struct NMHDDISPINFOW
{
    NMHDR hdr;
    int iItem;
    uint mask;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}

struct NMHDDISPINFOA
{
    NMHDR hdr;
    int iItem;
    uint mask;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}

struct NMHDFILTERBTNCLICK
{
    NMHDR hdr;
    int iItem;
    RECT rc;
}

struct TBBUTTON
{
    int iBitmap;
    int idCommand;
    ubyte fsState;
    ubyte fsStyle;
    ubyte bReserved;
    uint dwData;
    int iString;
}

struct COLORMAP
{
    uint from;
    uint to;
}

struct NMTBCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    HBRUSH hbrMonoDither;
    HBRUSH hbrLines;
    HPEN hpenLines;
    uint clrText;
    uint clrMark;
    uint clrTextHighlight;
    uint clrBtnFace;
    uint clrBtnHighlight;
    uint clrHighlightHotTrack;
    RECT rcText;
    int nStringBkMode;
    int nHLStringBkMode;
    int iListGap;
}

struct TBADDBITMAP
{
    HINSTANCE hInst;
    uint nID;
}

struct TBSAVEPARAMSA
{
    HKEY hkr;
    const(char)* pszSubKey;
    const(char)* pszValueName;
}

struct TBSAVEPARAMSW
{
    HKEY hkr;
    const(wchar)* pszSubKey;
    const(wchar)* pszValueName;
}

struct TBINSERTMARK
{
    int iButton;
    uint dwFlags;
}

struct TBREPLACEBITMAP
{
    HINSTANCE hInstOld;
    uint nIDOld;
    HINSTANCE hInstNew;
    uint nIDNew;
    int nButtons;
}

struct TBBUTTONINFOA
{
    uint cbSize;
    uint dwMask;
    int idCommand;
    int iImage;
    ubyte fsState;
    ubyte fsStyle;
    ushort cx;
    uint lParam;
    const(char)* pszText;
    int cchText;
}

struct TBBUTTONINFOW
{
    uint cbSize;
    uint dwMask;
    int idCommand;
    int iImage;
    ubyte fsState;
    ubyte fsStyle;
    ushort cx;
    uint lParam;
    const(wchar)* pszText;
    int cchText;
}

struct TBMETRICS
{
    uint cbSize;
    uint dwMask;
    int cxPad;
    int cyPad;
    int cxBarPad;
    int cyBarPad;
    int cxButtonSpacing;
    int cyButtonSpacing;
}

struct NMTBHOTITEM
{
    NMHDR hdr;
    int idOld;
    int idNew;
    uint dwFlags;
}

struct NMTBSAVE
{
    NMHDR hdr;
    uint* pData;
    uint* pCurrent;
    uint cbData;
    int iItem;
    int cButtons;
    TBBUTTON tbButton;
}

struct NMTBRESTORE
{
    NMHDR hdr;
    uint* pData;
    uint* pCurrent;
    uint cbData;
    int iItem;
    int cButtons;
    int cbBytesPerRecord;
    TBBUTTON tbButton;
}

struct NMTBGETINFOTIPA
{
    NMHDR hdr;
    const(char)* pszText;
    int cchTextMax;
    int iItem;
    LPARAM lParam;
}

struct NMTBGETINFOTIPW
{
    NMHDR hdr;
    const(wchar)* pszText;
    int cchTextMax;
    int iItem;
    LPARAM lParam;
}

struct NMTBDISPINFOA
{
    NMHDR hdr;
    uint dwMask;
    int idCommand;
    uint lParam;
    int iImage;
    const(char)* pszText;
    int cchText;
}

struct NMTBDISPINFOW
{
    NMHDR hdr;
    uint dwMask;
    int idCommand;
    uint lParam;
    int iImage;
    const(wchar)* pszText;
    int cchText;
}

struct NMTOOLBARA
{
    NMHDR hdr;
    int iItem;
    TBBUTTON tbButton;
    int cchText;
    const(char)* pszText;
    RECT rcButton;
}

struct NMTOOLBARW
{
    NMHDR hdr;
    int iItem;
    TBBUTTON tbButton;
    int cchText;
    const(wchar)* pszText;
    RECT rcButton;
}

struct REBARINFO
{
    uint cbSize;
    uint fMask;
    HIMAGELIST himl;
}

struct REBARBANDINFOA
{
    uint cbSize;
    uint fMask;
    uint fStyle;
    uint clrFore;
    uint clrBack;
    const(char)* lpText;
    uint cch;
    int iImage;
    HWND hwndChild;
    uint cxMinChild;
    uint cyMinChild;
    uint cx;
    HBITMAP hbmBack;
    uint wID;
    uint cyChild;
    uint cyMaxChild;
    uint cyIntegral;
    uint cxIdeal;
    LPARAM lParam;
    uint cxHeader;
    RECT rcChevronLocation;
    uint uChevronState;
}

struct REBARBANDINFOW
{
    uint cbSize;
    uint fMask;
    uint fStyle;
    uint clrFore;
    uint clrBack;
    const(wchar)* lpText;
    uint cch;
    int iImage;
    HWND hwndChild;
    uint cxMinChild;
    uint cyMinChild;
    uint cx;
    HBITMAP hbmBack;
    uint wID;
    uint cyChild;
    uint cyMaxChild;
    uint cyIntegral;
    uint cxIdeal;
    LPARAM lParam;
    uint cxHeader;
    RECT rcChevronLocation;
    uint uChevronState;
}

struct NMREBARCHILDSIZE
{
    NMHDR hdr;
    uint uBand;
    uint wID;
    RECT rcChild;
    RECT rcBand;
}

struct NMREBAR
{
    NMHDR hdr;
    uint dwMask;
    uint uBand;
    uint fStyle;
    uint wID;
    LPARAM lParam;
}

struct NMRBAUTOSIZE
{
    NMHDR hdr;
    BOOL fChanged;
    RECT rcTarget;
    RECT rcActual;
}

struct NMREBARCHEVRON
{
    NMHDR hdr;
    uint uBand;
    uint wID;
    LPARAM lParam;
    RECT rc;
    LPARAM lParamNM;
}

struct NMREBARSPLITTER
{
    NMHDR hdr;
    RECT rcSizing;
}

struct NMREBARAUTOBREAK
{
    NMHDR hdr;
    uint uBand;
    uint wID;
    LPARAM lParam;
    uint uMsg;
    uint fStyleCurrent;
    BOOL fAutoBreak;
}

struct RBHITTESTINFO
{
    POINT pt;
    uint flags;
    int iBand;
}

struct TTTOOLINFOA
{
    uint cbSize;
    uint uFlags;
    HWND hwnd;
    uint uId;
    RECT rect;
    HINSTANCE hinst;
    const(char)* lpszText;
    LPARAM lParam;
    void* lpReserved;
}

struct TTTOOLINFOW
{
    uint cbSize;
    uint uFlags;
    HWND hwnd;
    uint uId;
    RECT rect;
    HINSTANCE hinst;
    const(wchar)* lpszText;
    LPARAM lParam;
    void* lpReserved;
}

struct TTGETTITLE
{
    uint dwSize;
    uint uTitleBitmap;
    uint cch;
    ushort* pszTitle;
}

struct TTHITTESTINFOA
{
    HWND hwnd;
    POINT pt;
    TTTOOLINFOA ti;
}

struct TTHITTESTINFOW
{
    HWND hwnd;
    POINT pt;
    TTTOOLINFOW ti;
}

struct NMTTDISPINFOA
{
    NMHDR hdr;
    const(char)* lpszText;
    byte szText;
    HINSTANCE hinst;
    uint uFlags;
    LPARAM lParam;
}

struct NMTTDISPINFOW
{
    NMHDR hdr;
    const(wchar)* lpszText;
    ushort szText;
    HINSTANCE hinst;
    uint uFlags;
    LPARAM lParam;
}

struct NMTRBTHUMBPOSCHANGING
{
    NMHDR hdr;
    uint dwPos;
    int nReason;
}

struct DRAGLISTINFO
{
    uint uNotification;
    HWND hWnd;
    POINT ptCursor;
}

struct UDACCEL
{
    uint nSec;
    uint nInc;
}

struct NMUPDOWN
{
    NMHDR hdr;
    int iPos;
    int iDelta;
}

struct PBRANGE
{
    int iLow;
    int iHigh;
}

struct LITEM
{
    uint mask;
    int iLink;
    uint state;
    uint stateMask;
    ushort szID;
    ushort szUrl;
}

struct LHITTESTINFO
{
    POINT pt;
    LITEM item;
}

struct NMLINK
{
    NMHDR hdr;
    LITEM item;
}

struct LVITEMA
{
    uint mask;
    int iItem;
    int iSubItem;
    uint state;
    uint stateMask;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
    int iIndent;
    int iGroupId;
    uint cColumns;
    uint* puColumns;
    int* piColFmt;
    int iGroup;
}

struct LVITEMW
{
    uint mask;
    int iItem;
    int iSubItem;
    uint state;
    uint stateMask;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
    int iIndent;
    int iGroupId;
    uint cColumns;
    uint* puColumns;
    int* piColFmt;
    int iGroup;
}

struct LVFINDINFOA
{
    uint flags;
    const(char)* psz;
    LPARAM lParam;
    POINT pt;
    uint vkDirection;
}

struct LVFINDINFOW
{
    uint flags;
    const(wchar)* psz;
    LPARAM lParam;
    POINT pt;
    uint vkDirection;
}

struct LVHITTESTINFO
{
    POINT pt;
    uint flags;
    int iItem;
    int iSubItem;
    int iGroup;
}

struct LVCOLUMNA
{
    uint mask;
    int fmt;
    int cx;
    const(char)* pszText;
    int cchTextMax;
    int iSubItem;
    int iImage;
    int iOrder;
    int cxMin;
    int cxDefault;
    int cxIdeal;
}

struct LVCOLUMNW
{
    uint mask;
    int fmt;
    int cx;
    const(wchar)* pszText;
    int cchTextMax;
    int iSubItem;
    int iImage;
    int iOrder;
    int cxMin;
    int cxDefault;
    int cxIdeal;
}

alias PFNLVCOMPARE = extern(Windows) int function(LPARAM param0, LPARAM param1, LPARAM param2);
struct LVBKIMAGEA
{
    uint ulFlags;
    HBITMAP hbm;
    const(char)* pszImage;
    uint cchImageMax;
    int xOffsetPercent;
    int yOffsetPercent;
}

struct LVBKIMAGEW
{
    uint ulFlags;
    HBITMAP hbm;
    const(wchar)* pszImage;
    uint cchImageMax;
    int xOffsetPercent;
    int yOffsetPercent;
}

struct LVGROUP
{
    uint cbSize;
    uint mask;
    const(wchar)* pszHeader;
    int cchHeader;
    const(wchar)* pszFooter;
    int cchFooter;
    int iGroupId;
    uint stateMask;
    uint state;
    uint uAlign;
    const(wchar)* pszSubtitle;
    uint cchSubtitle;
    const(wchar)* pszTask;
    uint cchTask;
    const(wchar)* pszDescriptionTop;
    uint cchDescriptionTop;
    const(wchar)* pszDescriptionBottom;
    uint cchDescriptionBottom;
    int iTitleImage;
    int iExtendedImage;
    int iFirstItem;
    uint cItems;
    const(wchar)* pszSubsetTitle;
    uint cchSubsetTitle;
}

struct LVGROUPMETRICS
{
    uint cbSize;
    uint mask;
    uint Left;
    uint Top;
    uint Right;
    uint Bottom;
    uint crLeft;
    uint crTop;
    uint crRight;
    uint crBottom;
    uint crHeader;
    uint crFooter;
}

alias PFNLVGROUPCOMPARE = extern(Windows) int function(int param0, int param1, void* param2);
struct LVINSERTGROUPSORTED
{
    PFNLVGROUPCOMPARE pfnGroupCompare;
    void* pvData;
    LVGROUP lvGroup;
}

struct LVTILEVIEWINFO
{
    uint cbSize;
    uint dwMask;
    uint dwFlags;
    SIZE sizeTile;
    int cLines;
    RECT rcLabelMargin;
}

struct LVTILEINFO
{
    uint cbSize;
    int iItem;
    uint cColumns;
    uint* puColumns;
    int* piColFmt;
}

struct LVINSERTMARK
{
    uint cbSize;
    uint dwFlags;
    int iItem;
    uint dwReserved;
}

struct LVSETINFOTIP
{
    uint cbSize;
    uint dwFlags;
    const(wchar)* pszText;
    int iItem;
    int iSubItem;
}

struct LVFOOTERINFO
{
    uint mask;
    const(wchar)* pszText;
    int cchTextMax;
    uint cItems;
}

struct LVFOOTERITEM
{
    uint mask;
    int iItem;
    const(wchar)* pszText;
    int cchTextMax;
    uint state;
    uint stateMask;
}

struct LVITEMINDEX
{
    int iItem;
    int iGroup;
}

struct NMLISTVIEW
{
    NMHDR hdr;
    int iItem;
    int iSubItem;
    uint uNewState;
    uint uOldState;
    uint uChanged;
    POINT ptAction;
    LPARAM lParam;
}

struct NMITEMACTIVATE
{
    NMHDR hdr;
    int iItem;
    int iSubItem;
    uint uNewState;
    uint uOldState;
    uint uChanged;
    POINT ptAction;
    LPARAM lParam;
    uint uKeyFlags;
}

struct NMLVCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint clrText;
    uint clrTextBk;
    int iSubItem;
    uint dwItemType;
    uint clrFace;
    int iIconEffect;
    int iIconPhase;
    int iPartId;
    int iStateId;
    RECT rcText;
    uint uAlign;
}

struct NMLVCACHEHINT
{
    NMHDR hdr;
    int iFrom;
    int iTo;
}

struct NMLVFINDITEMA
{
    NMHDR hdr;
    int iStart;
    LVFINDINFOA lvfi;
}

struct NMLVFINDITEMW
{
    NMHDR hdr;
    int iStart;
    LVFINDINFOW lvfi;
}

struct NMLVODSTATECHANGE
{
    NMHDR hdr;
    int iFrom;
    int iTo;
    uint uNewState;
    uint uOldState;
}

struct NMLVDISPINFOA
{
    NMHDR hdr;
    LVITEMA item;
}

struct NMLVDISPINFOW
{
    NMHDR hdr;
    LVITEMW item;
}

struct NMLVKEYDOWN
{
    NMHDR hdr;
    ushort wVKey;
    uint flags;
}

struct NMLVLINK
{
    NMHDR hdr;
    LITEM link;
    int iItem;
    int iSubItem;
}

struct NMLVGETINFOTIPA
{
    NMHDR hdr;
    uint dwFlags;
    const(char)* pszText;
    int cchTextMax;
    int iItem;
    int iSubItem;
    LPARAM lParam;
}

struct NMLVGETINFOTIPW
{
    NMHDR hdr;
    uint dwFlags;
    const(wchar)* pszText;
    int cchTextMax;
    int iItem;
    int iSubItem;
    LPARAM lParam;
}

struct NMLVSCROLL
{
    NMHDR hdr;
    int dx;
    int dy;
}

struct NMLVEMPTYMARKUP
{
    NMHDR hdr;
    uint dwFlags;
    ushort szMarkup;
}

struct _TREEITEM
{
}

struct NMTVSTATEIMAGECHANGING
{
    NMHDR hdr;
    _TREEITEM* hti;
    int iOldStateImageIndex;
    int iNewStateImageIndex;
}

struct TVITEMA
{
    uint mask;
    _TREEITEM* hItem;
    uint state;
    uint stateMask;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int cChildren;
    LPARAM lParam;
}

struct TVITEMW
{
    uint mask;
    _TREEITEM* hItem;
    uint state;
    uint stateMask;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int cChildren;
    LPARAM lParam;
}

struct TVITEMEXA
{
    uint mask;
    _TREEITEM* hItem;
    uint state;
    uint stateMask;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int cChildren;
    LPARAM lParam;
    int iIntegral;
    uint uStateEx;
    HWND hwnd;
    int iExpandedImage;
    int iReserved;
}

struct TVITEMEXW
{
    uint mask;
    _TREEITEM* hItem;
    uint state;
    uint stateMask;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int cChildren;
    LPARAM lParam;
    int iIntegral;
    uint uStateEx;
    HWND hwnd;
    int iExpandedImage;
    int iReserved;
}

struct TVINSERTSTRUCTA
{
    _TREEITEM* hParent;
    _TREEITEM* hInsertAfter;
    _Anonymous_e__Union Anonymous;
}

struct TVINSERTSTRUCTW
{
    _TREEITEM* hParent;
    _TREEITEM* hInsertAfter;
    _Anonymous_e__Union Anonymous;
}

struct TVHITTESTINFO
{
    POINT pt;
    uint flags;
    _TREEITEM* hItem;
}

enum TVITEMPART
{
    TVGIPR_BUTTON = 1,
}

struct TVGETITEMPARTRECTINFO
{
    _TREEITEM* hti;
    RECT* prc;
    TVITEMPART partID;
}

alias PFNTVCOMPARE = extern(Windows) int function(LPARAM lParam1, LPARAM lParam2, LPARAM lParamSort);
struct TVSORTCB
{
    _TREEITEM* hParent;
    PFNTVCOMPARE lpfnCompare;
    LPARAM lParam;
}

struct NMTREEVIEWA
{
    NMHDR hdr;
    uint action;
    TVITEMA itemOld;
    TVITEMA itemNew;
    POINT ptDrag;
}

struct NMTREEVIEWW
{
    NMHDR hdr;
    uint action;
    TVITEMW itemOld;
    TVITEMW itemNew;
    POINT ptDrag;
}

struct NMTVDISPINFOA
{
    NMHDR hdr;
    TVITEMA item;
}

struct NMTVDISPINFOW
{
    NMHDR hdr;
    TVITEMW item;
}

struct NMTVDISPINFOEXA
{
    NMHDR hdr;
    TVITEMEXA item;
}

struct NMTVDISPINFOEXW
{
    NMHDR hdr;
    TVITEMEXW item;
}

struct NMTVKEYDOWN
{
    NMHDR hdr;
    ushort wVKey;
    uint flags;
}

struct NMTVCUSTOMDRAW
{
    NMCUSTOMDRAW nmcd;
    uint clrText;
    uint clrTextBk;
    int iLevel;
}

struct NMTVGETINFOTIPA
{
    NMHDR hdr;
    const(char)* pszText;
    int cchTextMax;
    _TREEITEM* hItem;
    LPARAM lParam;
}

struct NMTVGETINFOTIPW
{
    NMHDR hdr;
    const(wchar)* pszText;
    int cchTextMax;
    _TREEITEM* hItem;
    LPARAM lParam;
}

struct NMTVITEMCHANGE
{
    NMHDR hdr;
    uint uChanged;
    _TREEITEM* hItem;
    uint uStateNew;
    uint uStateOld;
    LPARAM lParam;
}

struct NMTVASYNCDRAW
{
    NMHDR hdr;
    IMAGELISTDRAWPARAMS* pimldp;
    HRESULT hr;
    _TREEITEM* hItem;
    LPARAM lParam;
    uint dwRetFlags;
    int iRetImageIndex;
}

struct COMBOBOXEXITEMA
{
    uint mask;
    int iItem;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int iOverlay;
    int iIndent;
    LPARAM lParam;
}

struct COMBOBOXEXITEMW
{
    uint mask;
    int iItem;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    int iSelectedImage;
    int iOverlay;
    int iIndent;
    LPARAM lParam;
}

struct NMCOMBOBOXEXA
{
    NMHDR hdr;
    COMBOBOXEXITEMA ceItem;
}

struct NMCOMBOBOXEXW
{
    NMHDR hdr;
    COMBOBOXEXITEMW ceItem;
}

struct NMCBEDRAGBEGINW
{
    NMHDR hdr;
    int iItemid;
    ushort szText;
}

struct NMCBEDRAGBEGINA
{
    NMHDR hdr;
    int iItemid;
    byte szText;
}

struct NMCBEENDEDITW
{
    NMHDR hdr;
    BOOL fChanged;
    int iNewSelection;
    ushort szText;
    int iWhy;
}

struct NMCBEENDEDITA
{
    NMHDR hdr;
    BOOL fChanged;
    int iNewSelection;
    byte szText;
    int iWhy;
}

struct TCITEMHEADERA
{
    uint mask;
    uint lpReserved1;
    uint lpReserved2;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
}

struct TCITEMHEADERW
{
    uint mask;
    uint lpReserved1;
    uint lpReserved2;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
}

struct TCITEMA
{
    uint mask;
    uint dwState;
    uint dwStateMask;
    const(char)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}

struct TCITEMW
{
    uint mask;
    uint dwState;
    uint dwStateMask;
    const(wchar)* pszText;
    int cchTextMax;
    int iImage;
    LPARAM lParam;
}

struct TCHITTESTINFO
{
    POINT pt;
    uint flags;
}

struct NMTCKEYDOWN
{
    NMHDR hdr;
    ushort wVKey;
    uint flags;
}

struct MCHITTESTINFO
{
    uint cbSize;
    POINT pt;
    uint uHit;
    SYSTEMTIME st;
    RECT rc;
    int iOffset;
    int iRow;
    int iCol;
}

struct MCGRIDINFO
{
    uint cbSize;
    uint dwPart;
    uint dwFlags;
    int iCalendar;
    int iRow;
    int iCol;
    BOOL bSelected;
    SYSTEMTIME stStart;
    SYSTEMTIME stEnd;
    RECT rc;
    const(wchar)* pszName;
    uint cchName;
}

struct NMSELCHANGE
{
    NMHDR nmhdr;
    SYSTEMTIME stSelStart;
    SYSTEMTIME stSelEnd;
}

struct NMDAYSTATE
{
    NMHDR nmhdr;
    SYSTEMTIME stStart;
    int cDayState;
    uint* prgDayState;
}

struct NMVIEWCHANGE
{
    NMHDR nmhdr;
    uint dwOldView;
    uint dwNewView;
}

struct DATETIMEPICKERINFO
{
    uint cbSize;
    RECT rcCheck;
    uint stateCheck;
    RECT rcButton;
    uint stateButton;
    HWND hwndEdit;
    HWND hwndUD;
    HWND hwndDropDown;
}

struct NMDATETIMECHANGE
{
    NMHDR nmhdr;
    uint dwFlags;
    SYSTEMTIME st;
}

struct NMDATETIMESTRINGA
{
    NMHDR nmhdr;
    const(char)* pszUserString;
    SYSTEMTIME st;
    uint dwFlags;
}

struct NMDATETIMESTRINGW
{
    NMHDR nmhdr;
    const(wchar)* pszUserString;
    SYSTEMTIME st;
    uint dwFlags;
}

struct NMDATETIMEWMKEYDOWNA
{
    NMHDR nmhdr;
    int nVirtKey;
    const(char)* pszFormat;
    SYSTEMTIME st;
}

struct NMDATETIMEWMKEYDOWNW
{
    NMHDR nmhdr;
    int nVirtKey;
    const(wchar)* pszFormat;
    SYSTEMTIME st;
}

struct NMDATETIMEFORMATA
{
    NMHDR nmhdr;
    const(char)* pszFormat;
    SYSTEMTIME st;
    const(char)* pszDisplay;
    byte szDisplay;
}

struct NMDATETIMEFORMATW
{
    NMHDR nmhdr;
    const(wchar)* pszFormat;
    SYSTEMTIME st;
    const(wchar)* pszDisplay;
    ushort szDisplay;
}

struct NMDATETIMEFORMATQUERYA
{
    NMHDR nmhdr;
    const(char)* pszFormat;
    SIZE szMax;
}

struct NMDATETIMEFORMATQUERYW
{
    NMHDR nmhdr;
    const(wchar)* pszFormat;
    SIZE szMax;
}

struct NMIPADDRESS
{
    NMHDR hdr;
    int iField;
    int iValue;
}

struct NMPGSCROLL
{
    NMHDR hdr;
    ushort fwKeys;
    RECT rcParent;
    int iDir;
    int iXpos;
    int iYpos;
    int iScroll;
}

struct NMPGCALCSIZE
{
    NMHDR hdr;
    uint dwFlag;
    int iWidth;
    int iHeight;
}

struct NMPGHOTITEM
{
    NMHDR hdr;
    int idOld;
    int idNew;
    uint dwFlags;
}

struct BUTTON_IMAGELIST
{
    HIMAGELIST himl;
    RECT margin;
    uint uAlign;
}

struct NMBCHOTITEM
{
    NMHDR hdr;
    uint dwFlags;
}

struct BUTTON_SPLITINFO
{
    uint mask;
    HIMAGELIST himlGlyph;
    uint uSplitStyle;
    SIZE size;
}

struct NMBCDROPDOWN
{
    NMHDR hdr;
    RECT rcButton;
}

struct EDITBALLOONTIP
{
    uint cbStruct;
    const(wchar)* pszTitle;
    const(wchar)* pszText;
    int ttiIcon;
}

enum EC_ENDOFLINE
{
    EC_ENDOFLINE_DETECTFROMCONTENT = 0,
    EC_ENDOFLINE_CRLF = 1,
    EC_ENDOFLINE_CR = 2,
    EC_ENDOFLINE_LF = 3,
}

enum EC_SEARCHWEB_ENTRYPOINT
{
    EC_SEARCHWEB_ENTRYPOINT_EXTERNAL = 0,
    EC_SEARCHWEB_ENTRYPOINT_CONTEXTMENU = 1,
}

struct NMSEARCHWEB
{
    NMHDR hdr;
    EC_SEARCHWEB_ENTRYPOINT entrypoint;
    BOOL hasQueryText;
    BOOL invokeSucceeded;
}

alias PFTASKDIALOGCALLBACK = extern(Windows) HRESULT function(HWND hwnd, uint msg, WPARAM wParam, LPARAM lParam, int lpRefData);
enum _TASKDIALOG_FLAGS
{
    TDF_ENABLE_HYPERLINKS = 1,
    TDF_USE_HICON_MAIN = 2,
    TDF_USE_HICON_FOOTER = 4,
    TDF_ALLOW_DIALOG_CANCELLATION = 8,
    TDF_USE_COMMAND_LINKS = 16,
    TDF_USE_COMMAND_LINKS_NO_ICON = 32,
    TDF_EXPAND_FOOTER_AREA = 64,
    TDF_EXPANDED_BY_DEFAULT = 128,
    TDF_VERIFICATION_FLAG_CHECKED = 256,
    TDF_SHOW_PROGRESS_BAR = 512,
    TDF_SHOW_MARQUEE_PROGRESS_BAR = 1024,
    TDF_CALLBACK_TIMER = 2048,
    TDF_POSITION_RELATIVE_TO_WINDOW = 4096,
    TDF_RTL_LAYOUT = 8192,
    TDF_NO_DEFAULT_RADIO_BUTTON = 16384,
    TDF_CAN_BE_MINIMIZED = 32768,
    TDF_NO_SET_FOREGROUND = 65536,
    TDF_SIZE_TO_CONTENT = 16777216,
}

enum TASKDIALOG_MESSAGES
{
    TDM_NAVIGATE_PAGE = 1125,
    TDM_CLICK_BUTTON = 1126,
    TDM_SET_MARQUEE_PROGRESS_BAR = 1127,
    TDM_SET_PROGRESS_BAR_STATE = 1128,
    TDM_SET_PROGRESS_BAR_RANGE = 1129,
    TDM_SET_PROGRESS_BAR_POS = 1130,
    TDM_SET_PROGRESS_BAR_MARQUEE = 1131,
    TDM_SET_ELEMENT_TEXT = 1132,
    TDM_CLICK_RADIO_BUTTON = 1134,
    TDM_ENABLE_BUTTON = 1135,
    TDM_ENABLE_RADIO_BUTTON = 1136,
    TDM_CLICK_VERIFICATION = 1137,
    TDM_UPDATE_ELEMENT_TEXT = 1138,
    TDM_SET_BUTTON_ELEVATION_REQUIRED_STATE = 1139,
    TDM_UPDATE_ICON = 1140,
}

enum TASKDIALOG_NOTIFICATIONS
{
    TDN_CREATED = 0,
    TDN_NAVIGATED = 1,
    TDN_BUTTON_CLICKED = 2,
    TDN_HYPERLINK_CLICKED = 3,
    TDN_TIMER = 4,
    TDN_DESTROYED = 5,
    TDN_RADIO_BUTTON_CLICKED = 6,
    TDN_DIALOG_CONSTRUCTED = 7,
    TDN_VERIFICATION_CLICKED = 8,
    TDN_HELP = 9,
    TDN_EXPANDO_BUTTON_CLICKED = 10,
}

struct TASKDIALOG_BUTTON
{
    int nButtonID;
    const(wchar)* pszButtonText;
}

enum TASKDIALOG_ELEMENTS
{
    TDE_CONTENT = 0,
    TDE_EXPANDED_INFORMATION = 1,
    TDE_FOOTER = 2,
    TDE_MAIN_INSTRUCTION = 3,
}

enum TASKDIALOG_ICON_ELEMENTS
{
    TDIE_ICON_MAIN = 0,
    TDIE_ICON_FOOTER = 1,
}

enum _TASKDIALOG_COMMON_BUTTON_FLAGS
{
    TDCBF_OK_BUTTON = 1,
    TDCBF_YES_BUTTON = 2,
    TDCBF_NO_BUTTON = 4,
    TDCBF_CANCEL_BUTTON = 8,
    TDCBF_RETRY_BUTTON = 16,
    TDCBF_CLOSE_BUTTON = 32,
}

struct TASKDIALOGCONFIG
{
    uint cbSize;
    HWND hwndParent;
    HINSTANCE hInstance;
    int dwFlags;
    int dwCommonButtons;
    const(wchar)* pszWindowTitle;
    _Anonymous1_e__Union Anonymous1;
    const(wchar)* pszMainInstruction;
    const(wchar)* pszContent;
    uint cButtons;
    const(TASKDIALOG_BUTTON)* pButtons;
    int nDefaultButton;
    uint cRadioButtons;
    const(TASKDIALOG_BUTTON)* pRadioButtons;
    int nDefaultRadioButton;
    const(wchar)* pszVerificationText;
    const(wchar)* pszExpandedInformation;
    const(wchar)* pszExpandedControlText;
    const(wchar)* pszCollapsedControlText;
    _Anonymous2_e__Union Anonymous2;
    const(wchar)* pszFooter;
    PFTASKDIALOGCALLBACK pfCallback;
    int lpCallbackData;
    uint cxWidth;
}

alias PFNDAENUMCALLBACK = extern(Windows) int function(void* p, void* pData);
alias PFNDAENUMCALLBACKCONST = extern(Windows) int function(const(void)* p, void* pData);
alias PFNDACOMPARE = extern(Windows) int function(void* p1, void* p2, LPARAM lParam);
alias PFNDACOMPARECONST = extern(Windows) int function(const(void)* p1, const(void)* p2, LPARAM lParam);
struct _DSA
{
}

struct _DPA
{
}

struct DPASTREAMINFO
{
    int iPos;
    void* pvItem;
}

alias PFNDPASTREAM = extern(Windows) HRESULT function(DPASTREAMINFO* pinfo, IStream pstream, void* pvInstData);
alias PFNDPAMERGE = extern(Windows) void* function(uint uMsg, void* pvDest, void* pvSrc, LPARAM lParam);
alias PFNDPAMERGECONST = extern(Windows) void* function(uint uMsg, const(void)* pvDest, const(void)* pvSrc, LPARAM lParam);
enum _LI_METRIC
{
    LIM_SMALL = 0,
    LIM_LARGE = 1,
}

const GUID CLSID_ImageList = {0x7C476BA2, 0x02B1, 0x48F4, [0x80, 0x48, 0xB2, 0x46, 0x19, 0xDD, 0xC0, 0x58]};
@GUID(0x7C476BA2, 0x02B1, 0x48F4, [0x80, 0x48, 0xB2, 0x46, 0x19, 0xDD, 0xC0, 0x58]);
struct ImageList;

const GUID IID_IImageList = {0x46EB5926, 0x582E, 0x4017, [0x9F, 0xDF, 0xE8, 0x99, 0x8D, 0xAA, 0x09, 0x50]};
@GUID(0x46EB5926, 0x582E, 0x4017, [0x9F, 0xDF, 0xE8, 0x99, 0x8D, 0xAA, 0x09, 0x50]);
interface IImageList : IUnknown
{
    HRESULT Add(HBITMAP hbmImage, HBITMAP hbmMask, int* pi);
    HRESULT ReplaceIcon(int i, HICON hicon, int* pi);
    HRESULT SetOverlayImage(int iImage, int iOverlay);
    HRESULT Replace(int i, HBITMAP hbmImage, HBITMAP hbmMask);
    HRESULT AddMasked(HBITMAP hbmImage, uint crMask, int* pi);
    HRESULT Draw(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT Remove(int i);
    HRESULT GetIcon(int i, uint flags, HICON* picon);
    HRESULT GetImageInfo(int i, IMAGEINFO* pImageInfo);
    HRESULT Copy(int iDst, IUnknown punkSrc, int iSrc, uint uFlags);
    HRESULT Merge(int i1, IUnknown punk2, int i2, int dx, int dy, const(Guid)* riid, void** ppv);
    HRESULT Clone(const(Guid)* riid, void** ppv);
    HRESULT GetImageRect(int i, RECT* prc);
    HRESULT GetIconSize(int* cx, int* cy);
    HRESULT SetIconSize(int cx, int cy);
    HRESULT GetImageCount(int* pi);
    HRESULT SetImageCount(uint uNewCount);
    HRESULT SetBkColor(uint clrBk, uint* pclr);
    HRESULT GetBkColor(uint* pclr);
    HRESULT BeginDrag(int iTrack, int dxHotspot, int dyHotspot);
    HRESULT EndDrag();
    HRESULT DragEnter(HWND hwndLock, int x, int y);
    HRESULT DragLeave(HWND hwndLock);
    HRESULT DragMove(int x, int y);
    HRESULT SetDragCursorImage(IUnknown punk, int iDrag, int dxHotspot, int dyHotspot);
    HRESULT DragShowNolock(BOOL fShow);
    HRESULT GetDragImage(POINT* ppt, POINT* pptHotspot, const(Guid)* riid, void** ppv);
    HRESULT GetItemFlags(int i, uint* dwFlags);
    HRESULT GetOverlayImage(int iOverlay, int* piIndex);
}

struct IMAGELISTSTATS
{
    uint cbSize;
    int cAlloc;
    int cUsed;
    int cStandby;
}

const GUID IID_IImageList2 = {0x192B9D83, 0x50FC, 0x457B, [0x90, 0xA0, 0x2B, 0x82, 0xA8, 0xB5, 0xDA, 0xE1]};
@GUID(0x192B9D83, 0x50FC, 0x457B, [0x90, 0xA0, 0x2B, 0x82, 0xA8, 0xB5, 0xDA, 0xE1]);
interface IImageList2 : IImageList
{
    HRESULT SetOverlayImage(int iImage, int iOverlay);
    HRESULT Replace(int i, HBITMAP hbmImage, HBITMAP hbmMask);
    HRESULT AddMasked(HBITMAP hbmImage, uint crMask, int* pi);
    HRESULT Draw(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT Remove(int i);
    HRESULT GetIcon(int i, uint flags, HICON* picon);
    HRESULT GetImageInfo(int i, IMAGEINFO* pImageInfo);
    HRESULT Copy(int iDst, IUnknown punkSrc, int iSrc, uint uFlags);
    HRESULT Merge(int i1, IUnknown punk2, int i2, int dx, int dy, const(Guid)* riid, void** ppv);
    HRESULT Clone(const(Guid)* riid, void** ppv);
    HRESULT GetImageRect(int i, RECT* prc);
    HRESULT GetIconSize(int* cx, int* cy);
    HRESULT SetIconSize(int cx, int cy);
    HRESULT GetImageCount(int* pi);
    HRESULT SetImageCount(uint uNewCount);
    HRESULT SetBkColor(uint clrBk, uint* pclr);
    HRESULT GetBkColor(uint* pclr);
    HRESULT BeginDrag(int iTrack, int dxHotspot, int dyHotspot);
    HRESULT EndDrag();
    HRESULT DragEnter(HWND hwndLock, int x, int y);
    HRESULT DragLeave(HWND hwndLock);
    HRESULT DragMove(int x, int y);
    HRESULT SetDragCursorImage(IUnknown punk, int iDrag, int dxHotspot, int dyHotspot);
    HRESULT DragShowNolock(BOOL fShow);
    HRESULT GetDragImage(POINT* ppt, POINT* pptHotspot, const(Guid)* riid, void** ppv);
    HRESULT GetItemFlags(int i, uint* dwFlags);
    HRESULT GetOverlayImage(int iOverlay, int* piIndex);
    HRESULT Resize(int cxNewIconSize, int cyNewIconSize);
    HRESULT GetOriginalSize(int iImage, uint dwFlags, int* pcx, int* pcy);
    HRESULT SetOriginalSize(int iImage, int cx, int cy);
    HRESULT SetCallback(IUnknown punk);
    HRESULT GetCallback(const(Guid)* riid, void** ppv);
    HRESULT ForceImagePresent(int iImage, uint dwFlags);
    HRESULT DiscardImages(int iFirstImage, int iLastImage, uint dwFlags);
    HRESULT PreloadImages(IMAGELISTDRAWPARAMS* pimldp);
    HRESULT GetStatistics(IMAGELISTSTATS* pils);
    HRESULT Initialize(int cx, int cy, uint flags, int cInitial, int cGrow);
    HRESULT Replace2(int i, HBITMAP hbmImage, HBITMAP hbmMask, IUnknown punk, uint dwFlags);
    HRESULT ReplaceFromImageList(int i, IImageList pil, int iSrc, IUnknown punk, uint dwFlags);
}

enum TEXTMODE
{
    TM_PLAINTEXT = 1,
    TM_RICHTEXT = 2,
    TM_SINGLELEVELUNDO = 4,
    TM_MULTILEVELUNDO = 8,
    TM_SINGLECODEPAGE = 16,
    TM_MULTICODEPAGE = 32,
}

struct IMECOMPTEXT
{
    int cb;
    uint flags;
}

struct TABLEROWPARMS
{
    ubyte cbRow;
    ubyte cbCell;
    ubyte cCell;
    ubyte cRow;
    int dxCellMargin;
    int dxIndent;
    int dyHeight;
    uint _bitfield;
    int cpStartRow;
    ubyte bTableLevel;
    ubyte iCell;
}

struct TABLECELLPARMS
{
    int dxWidth;
    ushort _bitfield;
    ushort wShading;
    short dxBrdrLeft;
    short dyBrdrTop;
    short dxBrdrRight;
    short dyBrdrBottom;
    uint crBrdrLeft;
    uint crBrdrTop;
    uint crBrdrRight;
    uint crBrdrBottom;
    uint crBackPat;
    uint crForePat;
}

alias AutoCorrectProc = extern(Windows) int function(ushort langid, const(wchar)* pszBefore, ushort* pszAfter, int cchAfter, int* pcchReplaced);
struct RICHEDIT_IMAGE_PARAMETERS
{
    int xWidth;
    int yHeight;
    int Ascent;
    int Type;
    const(wchar)* pwszAlternateText;
    IStream pIStream;
}

struct ENDCOMPOSITIONNOTIFY
{
    NMHDR nmhdr;
    uint dwCode;
}

alias EDITWORDBREAKPROCEX = extern(Windows) int function(byte* pchText, int cchText, ubyte bCharSet, int action);
struct CHARFORMATA
{
    uint cbSize;
    uint dwMask;
    uint dwEffects;
    int yHeight;
    int yOffset;
    uint crTextColor;
    ubyte bCharSet;
    ubyte bPitchAndFamily;
    byte szFaceName;
}

struct CHARFORMATW
{
    uint cbSize;
    uint dwMask;
    uint dwEffects;
    int yHeight;
    int yOffset;
    uint crTextColor;
    ubyte bCharSet;
    ubyte bPitchAndFamily;
    ushort szFaceName;
}

struct CHARFORMAT2W
{
    CHARFORMATW __AnonymousBase_richedit_L711_C23;
    ushort wWeight;
    short sSpacing;
    uint crBackColor;
    uint lcid;
    _Anonymous_e__Union Anonymous;
    short sStyle;
    ushort wKerning;
    ubyte bUnderlineType;
    ubyte bAnimation;
    ubyte bRevAuthor;
    ubyte bUnderlineColor;
}

struct CHARFORMAT2A
{
    CHARFORMATA __AnonymousBase_richedit_L736_C23;
    ushort wWeight;
    short sSpacing;
    uint crBackColor;
    uint lcid;
    _Anonymous_e__Union Anonymous;
    short sStyle;
    ushort wKerning;
    ubyte bUnderlineType;
    ubyte bAnimation;
    ubyte bRevAuthor;
    ubyte bUnderlineColor;
}

struct CHARRANGE
{
    int cpMin;
    int cpMax;
}

struct TEXTRANGEA
{
    CHARRANGE chrg;
    const(char)* lpstrText;
}

struct TEXTRANGEW
{
    CHARRANGE chrg;
    const(wchar)* lpstrText;
}

alias EDITSTREAMCALLBACK = extern(Windows) uint function(uint dwCookie, ubyte* pbBuff, int cb, int* pcb);
struct EDITSTREAM
{
    uint dwCookie;
    uint dwError;
    EDITSTREAMCALLBACK pfnCallback;
}

struct FINDTEXTA
{
    CHARRANGE chrg;
    const(char)* lpstrText;
}

struct FINDTEXTW
{
    CHARRANGE chrg;
    const(wchar)* lpstrText;
}

struct FINDTEXTEXA
{
    CHARRANGE chrg;
    const(char)* lpstrText;
    CHARRANGE chrgText;
}

struct FINDTEXTEXW
{
    CHARRANGE chrg;
    const(wchar)* lpstrText;
    CHARRANGE chrgText;
}

struct FORMATRANGE
{
    HDC hdc;
    HDC hdcTarget;
    RECT rc;
    RECT rcPage;
    CHARRANGE chrg;
}

struct PARAFORMAT
{
    uint cbSize;
    uint dwMask;
    ushort wNumbering;
    _Anonymous_e__Union Anonymous;
    int dxStartIndent;
    int dxRightIndent;
    int dxOffset;
    ushort wAlignment;
    short cTabCount;
    int rgxTabs;
}

struct PARAFORMAT2
{
    PARAFORMAT __AnonymousBase_richedit_L1149_C22;
    int dySpaceBefore;
    int dySpaceAfter;
    int dyLineSpacing;
    short sStyle;
    ubyte bLineSpacingRule;
    ubyte bOutlineLevel;
    ushort wShadingWeight;
    ushort wShadingStyle;
    ushort wNumberingStart;
    ushort wNumberingStyle;
    ushort wNumberingTab;
    ushort wBorderSpace;
    ushort wBorderWidth;
    ushort wBorders;
}

struct MSGFILTER
{
    NMHDR nmhdr;
    uint msg;
    WPARAM wParam;
    LPARAM lParam;
}

struct REQRESIZE
{
    NMHDR nmhdr;
    RECT rc;
}

struct SELCHANGE
{
    NMHDR nmhdr;
    CHARRANGE chrg;
    ushort seltyp;
}

struct _grouptypingchange
{
    NMHDR nmhdr;
    BOOL fGroupTyping;
}

struct CLIPBOARDFORMAT
{
    NMHDR nmhdr;
    ushort cf;
}

struct GETCONTEXTMENUEX
{
    CHARRANGE chrg;
    uint dwFlags;
    POINT pt;
    void* pvReserved;
}

struct ENDROPFILES
{
    NMHDR nmhdr;
    HANDLE hDrop;
    int cp;
    BOOL fProtected;
}

struct ENPROTECTED
{
    NMHDR nmhdr;
    uint msg;
    WPARAM wParam;
    LPARAM lParam;
    CHARRANGE chrg;
}

struct ENSAVECLIPBOARD
{
    NMHDR nmhdr;
    int cObjectCount;
    int cch;
}

struct ENOLEOPFAILED
{
    NMHDR nmhdr;
    int iob;
    int lOper;
    HRESULT hr;
}

struct OBJECTPOSITIONS
{
    NMHDR nmhdr;
    int cObjectCount;
    int* pcpPositions;
}

struct ENLINK
{
    NMHDR nmhdr;
    uint msg;
    WPARAM wParam;
    LPARAM lParam;
    CHARRANGE chrg;
}

struct ENLOWFIRTF
{
    NMHDR nmhdr;
    byte* szControl;
}

struct ENCORRECTTEXT
{
    NMHDR nmhdr;
    CHARRANGE chrg;
    ushort seltyp;
}

struct PUNCTUATION
{
    uint iSize;
    const(char)* szPunctuation;
}

struct COMPCOLOR
{
    uint crText;
    uint crBackground;
    uint dwEffects;
}

struct REPASTESPECIAL
{
    uint dwAspect;
    uint dwParam;
}

enum UNDONAMEID
{
    UID_UNKNOWN = 0,
    UID_TYPING = 1,
    UID_DELETE = 2,
    UID_DRAGDROP = 3,
    UID_CUT = 4,
    UID_PASTE = 5,
    UID_AUTOTABLE = 6,
}

struct SETTEXTEX
{
    uint flags;
    uint codepage;
}

struct GETTEXTEX
{
    uint cb;
    uint flags;
    uint codepage;
    const(char)* lpDefaultChar;
    int* lpUsedDefChar;
}

struct GETTEXTLENGTHEX
{
    uint flags;
    uint codepage;
}

struct BIDIOPTIONS
{
    uint cbSize;
    ushort wMask;
    ushort wEffects;
}

enum KHYPH
{
    khyphNil = 0,
    khyphNormal = 1,
    khyphAddBefore = 2,
    khyphChangeBefore = 3,
    khyphDeleteBefore = 4,
    khyphChangeAfter = 5,
    khyphDelAndChange = 6,
}

struct hyphresult
{
    KHYPH khyph;
    int ichHyph;
    ushort chHyph;
}

struct HYPHENATEINFO
{
    short cbSize;
    short dxHyphenateZone;
    int pfnHyphenate;
}

enum tomConstants
{
    tomFalse = 0,
    tomTrue = -1,
    tomUndefined = -9999999,
    tomToggle = -9999998,
    tomAutoColor = -9999997,
    tomDefault = -9999996,
    tomSuspend = -9999995,
    tomResume = -9999994,
    tomApplyNow = 0,
    tomApplyLater = 1,
    tomTrackParms = 2,
    tomCacheParms = 3,
    tomApplyTmp = 4,
    tomDisableSmartFont = 8,
    tomEnableSmartFont = 9,
    tomUsePoints = 10,
    tomUseTwips = 11,
    tomBackward = -1073741823,
    tomForward = 1073741823,
    tomMove = 0,
    tomExtend = 1,
    tomNoSelection = 0,
    tomSelectionIP = 1,
    tomSelectionNormal = 2,
    tomSelectionFrame = 3,
    tomSelectionColumn = 4,
    tomSelectionRow = 5,
    tomSelectionBlock = 6,
    tomSelectionInlineShape = 7,
    tomSelectionShape = 8,
    tomSelStartActive = 1,
    tomSelAtEOL = 2,
    tomSelOvertype = 4,
    tomSelActive = 8,
    tomSelReplace = 16,
    tomEnd = 0,
    tomStart = 32,
    tomCollapseEnd = 0,
    tomCollapseStart = 1,
    tomClientCoord = 256,
    tomAllowOffClient = 512,
    tomTransform = 1024,
    tomObjectArg = 2048,
    tomAtEnd = 4096,
    tomNone = 0,
    tomSingle = 1,
    tomWords = 2,
    tomDouble = 3,
    tomDotted = 4,
    tomDash = 5,
    tomDashDot = 6,
    tomDashDotDot = 7,
    tomWave = 8,
    tomThick = 9,
    tomHair = 10,
    tomDoubleWave = 11,
    tomHeavyWave = 12,
    tomLongDash = 13,
    tomThickDash = 14,
    tomThickDashDot = 15,
    tomThickDashDotDot = 16,
    tomThickDotted = 17,
    tomThickLongDash = 18,
    tomLineSpaceSingle = 0,
    tomLineSpace1pt5 = 1,
    tomLineSpaceDouble = 2,
    tomLineSpaceAtLeast = 3,
    tomLineSpaceExactly = 4,
    tomLineSpaceMultiple = 5,
    tomLineSpacePercent = 6,
    tomAlignLeft = 0,
    tomAlignCenter = 1,
    tomAlignRight = 2,
    tomAlignJustify = 3,
    tomAlignDecimal = 3,
    tomAlignBar = 4,
    tomDefaultTab = 5,
    tomAlignInterWord = 3,
    tomAlignNewspaper = 4,
    tomAlignInterLetter = 5,
    tomAlignScaled = 6,
    tomSpaces = 0,
    tomDots = 1,
    tomDashes = 2,
    tomLines = 3,
    tomThickLines = 4,
    tomEquals = 5,
    tomTabBack = -3,
    tomTabNext = -2,
    tomTabHere = -1,
    tomListNone = 0,
    tomListBullet = 1,
    tomListNumberAsArabic = 2,
    tomListNumberAsLCLetter = 3,
    tomListNumberAsUCLetter = 4,
    tomListNumberAsLCRoman = 5,
    tomListNumberAsUCRoman = 6,
    tomListNumberAsSequence = 7,
    tomListNumberedCircle = 8,
    tomListNumberedBlackCircleWingding = 9,
    tomListNumberedWhiteCircleWingding = 10,
    tomListNumberedArabicWide = 11,
    tomListNumberedChS = 12,
    tomListNumberedChT = 13,
    tomListNumberedJpnChS = 14,
    tomListNumberedJpnKor = 15,
    tomListNumberedArabic1 = 16,
    tomListNumberedArabic2 = 17,
    tomListNumberedHebrew = 18,
    tomListNumberedThaiAlpha = 19,
    tomListNumberedThaiNum = 20,
    tomListNumberedHindiAlpha = 21,
    tomListNumberedHindiAlpha1 = 22,
    tomListNumberedHindiNum = 23,
    tomListParentheses = 65536,
    tomListPeriod = 131072,
    tomListPlain = 196608,
    tomListNoNumber = 262144,
    tomListMinus = 524288,
    tomIgnoreNumberStyle = 16777216,
    tomParaStyleNormal = -1,
    tomParaStyleHeading1 = -2,
    tomParaStyleHeading2 = -3,
    tomParaStyleHeading3 = -4,
    tomParaStyleHeading4 = -5,
    tomParaStyleHeading5 = -6,
    tomParaStyleHeading6 = -7,
    tomParaStyleHeading7 = -8,
    tomParaStyleHeading8 = -9,
    tomParaStyleHeading9 = -10,
    tomCharacter = 1,
    tomWord = 2,
    tomSentence = 3,
    tomParagraph = 4,
    tomLine = 5,
    tomStory = 6,
    tomScreen = 7,
    tomSection = 8,
    tomTableColumn = 9,
    tomColumn = 9,
    tomRow = 10,
    tomWindow = 11,
    tomCell = 12,
    tomCharFormat = 13,
    tomParaFormat = 14,
    tomTable = 15,
    tomObject = 16,
    tomPage = 17,
    tomHardParagraph = 18,
    tomCluster = 19,
    tomInlineObject = 20,
    tomInlineObjectArg = 21,
    tomLeafLine = 22,
    tomLayoutColumn = 23,
    tomProcessId = 1073741825,
    tomMatchWord = 2,
    tomMatchCase = 4,
    tomMatchPattern = 8,
    tomUnknownStory = 0,
    tomMainTextStory = 1,
    tomFootnotesStory = 2,
    tomEndnotesStory = 3,
    tomCommentsStory = 4,
    tomTextFrameStory = 5,
    tomEvenPagesHeaderStory = 6,
    tomPrimaryHeaderStory = 7,
    tomEvenPagesFooterStory = 8,
    tomPrimaryFooterStory = 9,
    tomFirstPageHeaderStory = 10,
    tomFirstPageFooterStory = 11,
    tomScratchStory = 127,
    tomFindStory = 128,
    tomReplaceStory = 129,
    tomStoryInactive = 0,
    tomStoryActiveDisplay = 1,
    tomStoryActiveUI = 2,
    tomStoryActiveDisplayUI = 3,
    tomNoAnimation = 0,
    tomLasVegasLights = 1,
    tomBlinkingBackground = 2,
    tomSparkleText = 3,
    tomMarchingBlackAnts = 4,
    tomMarchingRedAnts = 5,
    tomShimmer = 6,
    tomWipeDown = 7,
    tomWipeRight = 8,
    tomAnimationMax = 8,
    tomLowerCase = 0,
    tomUpperCase = 1,
    tomTitleCase = 2,
    tomSentenceCase = 4,
    tomToggleCase = 5,
    tomReadOnly = 256,
    tomShareDenyRead = 512,
    tomShareDenyWrite = 1024,
    tomPasteFile = 4096,
    tomCreateNew = 16,
    tomCreateAlways = 32,
    tomOpenExisting = 48,
    tomOpenAlways = 64,
    tomTruncateExisting = 80,
    tomRTF = 1,
    tomText = 2,
    tomHTML = 3,
    tomWordDocument = 4,
    tomBold = -2147483647,
    tomItalic = -2147483646,
    tomUnderline = -2147483644,
    tomStrikeout = -2147483640,
    tomProtected = -2147483632,
    tomLink = -2147483616,
    tomSmallCaps = -2147483584,
    tomAllCaps = -2147483520,
    tomHidden = -2147483392,
    tomOutline = -2147483136,
    tomShadow = -2147482624,
    tomEmboss = -2147481600,
    tomImprint = -2147479552,
    tomDisabled = -2147475456,
    tomRevised = -2147467264,
    tomSubscriptCF = -2147418112,
    tomSuperscriptCF = -2147352576,
    tomFontBound = -2146435072,
    tomLinkProtected = -2139095040,
    tomInlineObjectStart = -2130706432,
    tomExtendedChar = -2113929216,
    tomAutoBackColor = -2080374784,
    tomMathZoneNoBuildUp = -2013265920,
    tomMathZone = -1879048192,
    tomMathZoneOrdinary = -1610612736,
    tomAutoTextColor = -1073741824,
    tomMathZoneDisplay = 262144,
    tomParaEffectRTL = 1,
    tomParaEffectKeep = 2,
    tomParaEffectKeepNext = 4,
    tomParaEffectPageBreakBefore = 8,
    tomParaEffectNoLineNumber = 16,
    tomParaEffectNoWidowControl = 32,
    tomParaEffectDoNotHyphen = 64,
    tomParaEffectSideBySide = 128,
    tomParaEffectCollapsed = 256,
    tomParaEffectOutlineLevel = 512,
    tomParaEffectBox = 1024,
    tomParaEffectTableRowDelimiter = 4096,
    tomParaEffectTable = 16384,
    tomModWidthPairs = 1,
    tomModWidthSpace = 2,
    tomAutoSpaceAlpha = 4,
    tomAutoSpaceNumeric = 8,
    tomAutoSpaceParens = 16,
    tomEmbeddedFont = 32,
    tomDoublestrike = 64,
    tomOverlapping = 128,
    tomNormalCaret = 0,
    tomKoreanBlockCaret = 1,
    tomNullCaret = 2,
    tomIncludeInset = 1,
    tomUnicodeBiDi = 1,
    tomMathCFCheck = 4,
    tomUnlink = 8,
    tomUnhide = 16,
    tomCheckTextLimit = 32,
    tomIgnoreCurrentFont = 0,
    tomMatchCharRep = 1,
    tomMatchFontSignature = 2,
    tomMatchAscii = 4,
    tomGetHeightOnly = 8,
    tomMatchMathFont = 16,
    tomCharset = -2147483648,
    tomCharRepFromLcid = 1073741824,
    tomAnsi = 0,
    tomEastEurope = 1,
    tomCyrillic = 2,
    tomGreek = 3,
    tomTurkish = 4,
    tomHebrew = 5,
    tomArabic = 6,
    tomBaltic = 7,
    tomVietnamese = 8,
    tomDefaultCharRep = 9,
    tomSymbol = 10,
    tomThai = 11,
    tomShiftJIS = 12,
    tomGB2312 = 13,
    tomHangul = 14,
    tomBIG5 = 15,
    tomPC437 = 16,
    tomOEM = 17,
    tomMac = 18,
    tomArmenian = 19,
    tomSyriac = 20,
    tomThaana = 21,
    tomDevanagari = 22,
    tomBengali = 23,
    tomGurmukhi = 24,
    tomGujarati = 25,
    tomOriya = 26,
    tomTamil = 27,
    tomTelugu = 28,
    tomKannada = 29,
    tomMalayalam = 30,
    tomSinhala = 31,
    tomLao = 32,
    tomTibetan = 33,
    tomMyanmar = 34,
    tomGeorgian = 35,
    tomJamo = 36,
    tomEthiopic = 37,
    tomCherokee = 38,
    tomAboriginal = 39,
    tomOgham = 40,
    tomRunic = 41,
    tomKhmer = 42,
    tomMongolian = 43,
    tomBraille = 44,
    tomYi = 45,
    tomLimbu = 46,
    tomTaiLe = 47,
    tomNewTaiLue = 48,
    tomSylotiNagri = 49,
    tomKharoshthi = 50,
    tomKayahli = 51,
    tomUsymbol = 52,
    tomEmoji = 53,
    tomGlagolitic = 54,
    tomLisu = 55,
    tomVai = 56,
    tomNKo = 57,
    tomOsmanya = 58,
    tomPhagsPa = 59,
    tomGothic = 60,
    tomDeseret = 61,
    tomTifinagh = 62,
    tomCharRepMax = 63,
    tomRE10Mode = 1,
    tomUseAtFont = 2,
    tomTextFlowMask = 12,
    tomTextFlowES = 0,
    tomTextFlowSW = 4,
    tomTextFlowWN = 8,
    tomTextFlowNE = 12,
    tomNoIME = 524288,
    tomSelfIME = 262144,
    tomNoUpScroll = 65536,
    tomNoVpScroll = 262144,
    tomNoLink = 0,
    tomClientLink = 1,
    tomFriendlyLinkName = 2,
    tomFriendlyLinkAddress = 3,
    tomAutoLinkURL = 4,
    tomAutoLinkEmail = 5,
    tomAutoLinkPhone = 6,
    tomAutoLinkPath = 7,
    tomCompressNone = 0,
    tomCompressPunctuation = 1,
    tomCompressPunctuationAndKana = 2,
    tomCompressMax = 2,
    tomUnderlinePositionAuto = 0,
    tomUnderlinePositionBelow = 1,
    tomUnderlinePositionAbove = 2,
    tomUnderlinePositionMax = 2,
    tomFontAlignmentAuto = 0,
    tomFontAlignmentTop = 1,
    tomFontAlignmentBaseline = 2,
    tomFontAlignmentBottom = 3,
    tomFontAlignmentCenter = 4,
    tomFontAlignmentMax = 4,
    tomRubyBelow = 128,
    tomRubyAlignCenter = 0,
    tomRubyAlign010 = 1,
    tomRubyAlign121 = 2,
    tomRubyAlignLeft = 3,
    tomRubyAlignRight = 4,
    tomLimitsDefault = 0,
    tomLimitsUnderOver = 1,
    tomLimitsSubSup = 2,
    tomUpperLimitAsSuperScript = 3,
    tomLimitsOpposite = 4,
    tomShowLLimPlaceHldr = 8,
    tomShowULimPlaceHldr = 16,
    tomDontGrowWithContent = 64,
    tomGrowWithContent = 128,
    tomSubSupAlign = 1,
    tomLimitAlignMask = 3,
    tomLimitAlignCenter = 0,
    tomLimitAlignLeft = 1,
    tomLimitAlignRight = 2,
    tomShowDegPlaceHldr = 8,
    tomAlignDefault = 0,
    tomAlignMatchAscentDescent = 2,
    tomMathVariant = 32,
    tomStyleDefault = 0,
    tomStyleScriptScriptCramped = 1,
    tomStyleScriptScript = 2,
    tomStyleScriptCramped = 3,
    tomStyleScript = 4,
    tomStyleTextCramped = 5,
    tomStyleText = 6,
    tomStyleDisplayCramped = 7,
    tomStyleDisplay = 8,
    tomMathRelSize = 64,
    tomDecDecSize = 254,
    tomDecSize = 255,
    tomIncSize = 65,
    tomIncIncSize = 66,
    tomGravityUI = 0,
    tomGravityBack = 1,
    tomGravityFore = 2,
    tomGravityIn = 3,
    tomGravityOut = 4,
    tomGravityBackward = 536870912,
    tomGravityForward = 1073741824,
    tomAdjustCRLF = 1,
    tomUseCRLF = 2,
    tomTextize = 4,
    tomAllowFinalEOP = 8,
    tomFoldMathAlpha = 16,
    tomNoHidden = 32,
    tomIncludeNumbering = 64,
    tomTranslateTableCell = 128,
    tomNoMathZoneBrackets = 256,
    tomConvertMathChar = 512,
    tomNoUCGreekItalic = 1024,
    tomAllowMathBold = 2048,
    tomLanguageTag = 4096,
    tomConvertRTF = 8192,
    tomApplyRtfDocProps = 16384,
    tomPhantomShow = 1,
    tomPhantomZeroWidth = 2,
    tomPhantomZeroAscent = 4,
    tomPhantomZeroDescent = 8,
    tomPhantomTransparent = 16,
    tomPhantomASmash = 5,
    tomPhantomDSmash = 9,
    tomPhantomHSmash = 3,
    tomPhantomSmash = 13,
    tomPhantomHorz = 12,
    tomPhantomVert = 2,
    tomBoxHideTop = 1,
    tomBoxHideBottom = 2,
    tomBoxHideLeft = 4,
    tomBoxHideRight = 8,
    tomBoxStrikeH = 16,
    tomBoxStrikeV = 32,
    tomBoxStrikeTLBR = 64,
    tomBoxStrikeBLTR = 128,
    tomBoxAlignCenter = 1,
    tomSpaceMask = 28,
    tomSpaceDefault = 0,
    tomSpaceUnary = 4,
    tomSpaceBinary = 8,
    tomSpaceRelational = 12,
    tomSpaceSkip = 16,
    tomSpaceOrd = 20,
    tomSpaceDifferential = 24,
    tomSizeText = 32,
    tomSizeScript = 64,
    tomSizeScriptScript = 96,
    tomNoBreak = 128,
    tomTransparentForPositioning = 256,
    tomTransparentForSpacing = 512,
    tomStretchCharBelow = 0,
    tomStretchCharAbove = 1,
    tomStretchBaseBelow = 2,
    tomStretchBaseAbove = 3,
    tomMatrixAlignMask = 3,
    tomMatrixAlignCenter = 0,
    tomMatrixAlignTopRow = 1,
    tomMatrixAlignBottomRow = 3,
    tomShowMatPlaceHldr = 8,
    tomEqArrayLayoutWidth = 1,
    tomEqArrayAlignMask = 12,
    tomEqArrayAlignCenter = 0,
    tomEqArrayAlignTopRow = 4,
    tomEqArrayAlignBottomRow = 12,
    tomMathManualBreakMask = 127,
    tomMathBreakLeft = 125,
    tomMathBreakCenter = 126,
    tomMathBreakRight = 127,
    tomMathEqAlign = 128,
    tomMathArgShadingStart = 593,
    tomMathArgShadingEnd = 594,
    tomMathObjShadingStart = 595,
    tomMathObjShadingEnd = 596,
    tomFunctionTypeNone = 0,
    tomFunctionTypeTakesArg = 1,
    tomFunctionTypeTakesLim = 2,
    tomFunctionTypeTakesLim2 = 3,
    tomFunctionTypeIsLim = 4,
    tomMathParaAlignDefault = 0,
    tomMathParaAlignCenterGroup = 1,
    tomMathParaAlignCenter = 2,
    tomMathParaAlignLeft = 3,
    tomMathParaAlignRight = 4,
    tomMathDispAlignMask = 3,
    tomMathDispAlignCenterGroup = 0,
    tomMathDispAlignCenter = 1,
    tomMathDispAlignLeft = 2,
    tomMathDispAlignRight = 3,
    tomMathDispIntUnderOver = 4,
    tomMathDispFracTeX = 8,
    tomMathDispNaryGrow = 16,
    tomMathDocEmptyArgMask = 96,
    tomMathDocEmptyArgAuto = 0,
    tomMathDocEmptyArgAlways = 32,
    tomMathDocEmptyArgNever = 64,
    tomMathDocSbSpOpUnchanged = 128,
    tomMathDocDiffMask = 768,
    tomMathDocDiffDefault = 0,
    tomMathDocDiffUpright = 256,
    tomMathDocDiffItalic = 512,
    tomMathDocDiffOpenItalic = 768,
    tomMathDispNarySubSup = 1024,
    tomMathDispDef = 2048,
    tomMathEnableRtl = 4096,
    tomMathBrkBinMask = 196608,
    tomMathBrkBinBefore = 0,
    tomMathBrkBinAfter = 65536,
    tomMathBrkBinDup = 131072,
    tomMathBrkBinSubMask = 786432,
    tomMathBrkBinSubMM = 0,
    tomMathBrkBinSubPM = 262144,
    tomMathBrkBinSubMP = 524288,
    tomSelRange = 597,
    tomHstring = 596,
    tomFontPropTeXStyle = 828,
    tomFontPropAlign = 829,
    tomFontStretch = 830,
    tomFontStyle = 831,
    tomFontStyleUpright = 0,
    tomFontStyleOblique = 1,
    tomFontStyleItalic = 2,
    tomFontStretchDefault = 0,
    tomFontStretchUltraCondensed = 1,
    tomFontStretchExtraCondensed = 2,
    tomFontStretchCondensed = 3,
    tomFontStretchSemiCondensed = 4,
    tomFontStretchNormal = 5,
    tomFontStretchSemiExpanded = 6,
    tomFontStretchExpanded = 7,
    tomFontStretchExtraExpanded = 8,
    tomFontStretchUltraExpanded = 9,
    tomFontWeightDefault = 0,
    tomFontWeightThin = 100,
    tomFontWeightExtraLight = 200,
    tomFontWeightLight = 300,
    tomFontWeightNormal = 400,
    tomFontWeightRegular = 400,
    tomFontWeightMedium = 500,
    tomFontWeightSemiBold = 600,
    tomFontWeightBold = 700,
    tomFontWeightExtraBold = 800,
    tomFontWeightBlack = 900,
    tomFontWeightHeavy = 900,
    tomFontWeightExtraBlack = 950,
    tomParaPropMathAlign = 1079,
    tomDocMathBuild = 128,
    tomMathLMargin = 129,
    tomMathRMargin = 130,
    tomMathWrapIndent = 131,
    tomMathWrapRight = 132,
    tomMathPostSpace = 134,
    tomMathPreSpace = 133,
    tomMathInterSpace = 135,
    tomMathIntraSpace = 136,
    tomCanCopy = 137,
    tomCanRedo = 138,
    tomCanUndo = 139,
    tomUndoLimit = 140,
    tomDocAutoLink = 141,
    tomEllipsisMode = 142,
    tomEllipsisState = 143,
    tomEllipsisNone = 0,
    tomEllipsisEnd = 1,
    tomEllipsisWord = 3,
    tomEllipsisPresent = 1,
    tomVTopCell = 1,
    tomVLowCell = 2,
    tomHStartCell = 4,
    tomHContCell = 8,
    tomRowUpdate = 1,
    tomRowApplyDefault = 0,
    tomCellStructureChangeOnly = 1,
    tomRowHeightActual = 2059,
}

enum OBJECTTYPE
{
    tomSimpleText = 0,
    tomRuby = 1,
    tomHorzVert = 2,
    tomWarichu = 3,
    tomEq = 9,
    tomMath = 10,
    tomAccent = 10,
    tomBox = 11,
    tomBoxedFormula = 12,
    tomBrackets = 13,
    tomBracketsWithSeps = 14,
    tomEquationArray = 15,
    tomFraction = 16,
    tomFunctionApply = 17,
    tomLeftSubSup = 18,
    tomLowerLimit = 19,
    tomMatrix = 20,
    tomNary = 21,
    tomOpChar = 22,
    tomOverbar = 23,
    tomPhantom = 24,
    tomRadical = 25,
    tomSlashedFraction = 26,
    tomStack = 27,
    tomStretchStack = 28,
    tomSubscript = 29,
    tomSubSup = 30,
    tomSuperscript = 31,
    tomUnderbar = 32,
    tomUpperLimit = 33,
    tomObjectMax = 33,
}

enum MANCODE
{
    MBOLD = 16,
    MITAL = 32,
    MGREEK = 64,
    MROMN = 0,
    MSCRP = 1,
    MFRAK = 2,
    MOPEN = 3,
    MSANS = 4,
    MMONO = 5,
    MMATH = 6,
    MISOL = 7,
    MINIT = 8,
    MTAIL = 9,
    MSTRCH = 10,
    MLOOP = 11,
    MOPENA = 12,
}

const GUID IID_ITextDocument = {0x8CC497C0, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C0, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextDocument : IDispatch
{
    HRESULT GetName(BSTR* pName);
    HRESULT GetSelection(ITextSelection* ppSel);
    HRESULT GetStoryCount(int* pCount);
    HRESULT GetStoryRanges(ITextStoryRanges* ppStories);
    HRESULT GetSaved(int* pValue);
    HRESULT SetSaved(int Value);
    HRESULT GetDefaultTabStop(float* pValue);
    HRESULT SetDefaultTabStop(float Value);
    HRESULT New();
    HRESULT Open(VARIANT* pVar, int Flags, int CodePage);
    HRESULT Save(VARIANT* pVar, int Flags, int CodePage);
    HRESULT Freeze(int* pCount);
    HRESULT Unfreeze(int* pCount);
    HRESULT BeginEditCollection();
    HRESULT EndEditCollection();
    HRESULT Undo(int Count, int* pCount);
    HRESULT Redo(int Count, int* pCount);
    HRESULT Range(int cpActive, int cpAnchor, ITextRange* ppRange);
    HRESULT RangeFromPoint(int x, int y, ITextRange* ppRange);
}

const GUID IID_ITextRange = {0x8CC497C2, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C2, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextRange : IDispatch
{
    HRESULT GetText(BSTR* pbstr);
    HRESULT SetText(BSTR bstr);
    HRESULT GetChar(int* pChar);
    HRESULT SetChar(int Char);
    HRESULT GetDuplicate(ITextRange* ppRange);
    HRESULT GetFormattedText(ITextRange* ppRange);
    HRESULT SetFormattedText(ITextRange pRange);
    HRESULT GetStart(int* pcpFirst);
    HRESULT SetStart(int cpFirst);
    HRESULT GetEnd(int* pcpLim);
    HRESULT SetEnd(int cpLim);
    HRESULT GetFont(ITextFont* ppFont);
    HRESULT SetFont(ITextFont pFont);
    HRESULT GetPara(ITextPara* ppPara);
    HRESULT SetPara(ITextPara pPara);
    HRESULT GetStoryLength(int* pCount);
    HRESULT GetStoryType(int* pValue);
    HRESULT Collapse(int bStart);
    HRESULT Expand(int Unit, int* pDelta);
    HRESULT GetIndex(int Unit, int* pIndex);
    HRESULT SetIndex(int Unit, int Index, int Extend);
    HRESULT SetRange(int cpAnchor, int cpActive);
    HRESULT InRange(ITextRange pRange, int* pValue);
    HRESULT InStory(ITextRange pRange, int* pValue);
    HRESULT IsEqual(ITextRange pRange, int* pValue);
    HRESULT Select();
    HRESULT StartOf(int Unit, int Extend, int* pDelta);
    HRESULT EndOf(int Unit, int Extend, int* pDelta);
    HRESULT Move(int Unit, int Count, int* pDelta);
    HRESULT MoveStart(int Unit, int Count, int* pDelta);
    HRESULT MoveEnd(int Unit, int Count, int* pDelta);
    HRESULT MoveWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveStartWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveEndWhile(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveStartUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT MoveEndUntil(VARIANT* Cset, int Count, int* pDelta);
    HRESULT FindTextA(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT FindTextStart(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT FindTextEnd(BSTR bstr, int Count, int Flags, int* pLength);
    HRESULT Delete(int Unit, int Count, int* pDelta);
    HRESULT Cut(VARIANT* pVar);
    HRESULT Copy(VARIANT* pVar);
    HRESULT Paste(VARIANT* pVar, int Format);
    HRESULT CanPaste(VARIANT* pVar, int Format, int* pValue);
    HRESULT CanEdit(int* pValue);
    HRESULT ChangeCase(int Type);
    HRESULT GetPoint(int Type, int* px, int* py);
    HRESULT SetPoint(int x, int y, int Type, int Extend);
    HRESULT ScrollIntoView(int Value);
    HRESULT GetEmbeddedObject(IUnknown* ppObject);
}

const GUID IID_ITextSelection = {0x8CC497C1, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C1, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextSelection : ITextRange
{
    HRESULT GetFlags(int* pFlags);
    HRESULT SetFlags(int Flags);
    HRESULT GetType(int* pType);
    HRESULT MoveLeft(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveRight(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveUp(int Unit, int Count, int Extend, int* pDelta);
    HRESULT MoveDown(int Unit, int Count, int Extend, int* pDelta);
    HRESULT HomeKey(int Unit, int Extend, int* pDelta);
    HRESULT EndKey(int Unit, int Extend, int* pDelta);
    HRESULT TypeText(BSTR bstr);
}

const GUID IID_ITextFont = {0x8CC497C3, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C3, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextFont : IDispatch
{
    HRESULT GetDuplicate(ITextFont* ppFont);
    HRESULT SetDuplicate(ITextFont pFont);
    HRESULT CanChange(int* pValue);
    HRESULT IsEqual(ITextFont pFont, int* pValue);
    HRESULT Reset(int Value);
    HRESULT GetStyle(int* pValue);
    HRESULT SetStyle(int Value);
    HRESULT GetAllCaps(int* pValue);
    HRESULT SetAllCaps(int Value);
    HRESULT GetAnimation(int* pValue);
    HRESULT SetAnimation(int Value);
    HRESULT GetBackColor(int* pValue);
    HRESULT SetBackColor(int Value);
    HRESULT GetBold(int* pValue);
    HRESULT SetBold(int Value);
    HRESULT GetEmboss(int* pValue);
    HRESULT SetEmboss(int Value);
    HRESULT GetForeColor(int* pValue);
    HRESULT SetForeColor(int Value);
    HRESULT GetHidden(int* pValue);
    HRESULT SetHidden(int Value);
    HRESULT GetEngrave(int* pValue);
    HRESULT SetEngrave(int Value);
    HRESULT GetItalic(int* pValue);
    HRESULT SetItalic(int Value);
    HRESULT GetKerning(float* pValue);
    HRESULT SetKerning(float Value);
    HRESULT GetLanguageID(int* pValue);
    HRESULT SetLanguageID(int Value);
    HRESULT GetName(BSTR* pbstr);
    HRESULT SetName(BSTR bstr);
    HRESULT GetOutline(int* pValue);
    HRESULT SetOutline(int Value);
    HRESULT GetPosition(float* pValue);
    HRESULT SetPosition(float Value);
    HRESULT GetProtected(int* pValue);
    HRESULT SetProtected(int Value);
    HRESULT GetShadow(int* pValue);
    HRESULT SetShadow(int Value);
    HRESULT GetSize(float* pValue);
    HRESULT SetSize(float Value);
    HRESULT GetSmallCaps(int* pValue);
    HRESULT SetSmallCaps(int Value);
    HRESULT GetSpacing(float* pValue);
    HRESULT SetSpacing(float Value);
    HRESULT GetStrikeThrough(int* pValue);
    HRESULT SetStrikeThrough(int Value);
    HRESULT GetSubscript(int* pValue);
    HRESULT SetSubscript(int Value);
    HRESULT GetSuperscript(int* pValue);
    HRESULT SetSuperscript(int Value);
    HRESULT GetUnderline(int* pValue);
    HRESULT SetUnderline(int Value);
    HRESULT GetWeight(int* pValue);
    HRESULT SetWeight(int Value);
}

const GUID IID_ITextPara = {0x8CC497C4, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C4, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextPara : IDispatch
{
    HRESULT GetDuplicate(ITextPara* ppPara);
    HRESULT SetDuplicate(ITextPara pPara);
    HRESULT CanChange(int* pValue);
    HRESULT IsEqual(ITextPara pPara, int* pValue);
    HRESULT Reset(int Value);
    HRESULT GetStyle(int* pValue);
    HRESULT SetStyle(int Value);
    HRESULT GetAlignment(int* pValue);
    HRESULT SetAlignment(int Value);
    HRESULT GetHyphenation(int* pValue);
    HRESULT SetHyphenation(int Value);
    HRESULT GetFirstLineIndent(float* pValue);
    HRESULT GetKeepTogether(int* pValue);
    HRESULT SetKeepTogether(int Value);
    HRESULT GetKeepWithNext(int* pValue);
    HRESULT SetKeepWithNext(int Value);
    HRESULT GetLeftIndent(float* pValue);
    HRESULT GetLineSpacing(float* pValue);
    HRESULT GetLineSpacingRule(int* pValue);
    HRESULT GetListAlignment(int* pValue);
    HRESULT SetListAlignment(int Value);
    HRESULT GetListLevelIndex(int* pValue);
    HRESULT SetListLevelIndex(int Value);
    HRESULT GetListStart(int* pValue);
    HRESULT SetListStart(int Value);
    HRESULT GetListTab(float* pValue);
    HRESULT SetListTab(float Value);
    HRESULT GetListType(int* pValue);
    HRESULT SetListType(int Value);
    HRESULT GetNoLineNumber(int* pValue);
    HRESULT SetNoLineNumber(int Value);
    HRESULT GetPageBreakBefore(int* pValue);
    HRESULT SetPageBreakBefore(int Value);
    HRESULT GetRightIndent(float* pValue);
    HRESULT SetRightIndent(float Value);
    HRESULT SetIndents(float First, float Left, float Right);
    HRESULT SetLineSpacing(int Rule, float Spacing);
    HRESULT GetSpaceAfter(float* pValue);
    HRESULT SetSpaceAfter(float Value);
    HRESULT GetSpaceBefore(float* pValue);
    HRESULT SetSpaceBefore(float Value);
    HRESULT GetWidowControl(int* pValue);
    HRESULT SetWidowControl(int Value);
    HRESULT GetTabCount(int* pCount);
    HRESULT AddTab(float tbPos, int tbAlign, int tbLeader);
    HRESULT ClearAllTabs();
    HRESULT DeleteTab(float tbPos);
    HRESULT GetTab(int iTab, float* ptbPos, int* ptbAlign, int* ptbLeader);
}

const GUID IID_ITextStoryRanges = {0x8CC497C5, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]};
@GUID(0x8CC497C5, 0xA1DF, 0x11CE, [0x80, 0x98, 0x00, 0xAA, 0x00, 0x47, 0xBE, 0x5D]);
interface ITextStoryRanges : IDispatch
{
    HRESULT _NewEnum(IUnknown* ppunkEnum);
    HRESULT Item(int Index, ITextRange* ppRange);
    HRESULT GetCount(int* pCount);
}

const GUID IID_ITextDocument2 = {0xC241F5E0, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E0, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextDocument2 : ITextDocument
{
    HRESULT GetCaretType(int* pValue);
    HRESULT SetCaretType(int Value);
    HRESULT GetDisplays(ITextDisplays* ppDisplays);
    HRESULT GetDocumentFont(ITextFont2* ppFont);
    HRESULT SetDocumentFont(ITextFont2 pFont);
    HRESULT GetDocumentPara(ITextPara2* ppPara);
    HRESULT SetDocumentPara(ITextPara2 pPara);
    HRESULT GetEastAsianFlags(int* pFlags);
    HRESULT GetGenerator(BSTR* pbstr);
    HRESULT SetIMEInProgress(int Value);
    HRESULT GetNotificationMode(int* pValue);
    HRESULT SetNotificationMode(int Value);
    HRESULT GetSelection2(ITextSelection2* ppSel);
    HRESULT GetStoryRanges2(ITextStoryRanges2* ppStories);
    HRESULT GetTypographyOptions(int* pOptions);
    HRESULT GetVersion(int* pValue);
    HRESULT GetWindow(long* pHwnd);
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT CheckTextLimit(int cch, int* pcch);
    HRESULT GetCallManager(IUnknown* ppVoid);
    HRESULT GetClientRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    HRESULT GetEffectColor(int Index, int* pValue);
    HRESULT GetImmContext(long* pContext);
    HRESULT GetPreferredFont(int cp, int CharRep, int Options, int curCharRep, int curFontSize, BSTR* pbstr, int* pPitchAndFamily, int* pNewFontSize);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetStrings(ITextStrings* ppStrs);
    HRESULT Notify(int Notify);
    HRESULT Range2(int cpActive, int cpAnchor, ITextRange2* ppRange);
    HRESULT RangeFromPoint2(int x, int y, int Type, ITextRange2* ppRange);
    HRESULT ReleaseCallManager(IUnknown pVoid);
    HRESULT ReleaseImmContext(long Context);
    HRESULT SetEffectColor(int Index, int Value);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetTypographyOptions(int Options, int Mask);
    HRESULT SysBeep();
    HRESULT Update(int Value);
    HRESULT UpdateWindow();
    HRESULT GetMathProperties(int* pOptions);
    HRESULT SetMathProperties(int Options, int Mask);
    HRESULT GetActiveStory(ITextStory* ppStory);
    HRESULT SetActiveStory(ITextStory pStory);
    HRESULT GetMainStory(ITextStory* ppStory);
    HRESULT GetNewStory(ITextStory* ppStory);
    HRESULT GetStory(int Index, ITextStory* ppStory);
}

const GUID IID_ITextRange2 = {0xC241F5E2, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E2, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextRange2 : ITextSelection
{
    HRESULT GetCch(int* pcch);
    HRESULT GetCells(IUnknown* ppCells);
    HRESULT GetColumn(IUnknown* ppColumn);
    HRESULT GetCount(int* pCount);
    HRESULT GetDuplicate2(ITextRange2* ppRange);
    HRESULT GetFont2(ITextFont2* ppFont);
    HRESULT SetFont2(ITextFont2 pFont);
    HRESULT GetFormattedText2(ITextRange2* ppRange);
    HRESULT SetFormattedText2(ITextRange2 pRange);
    HRESULT GetGravity(int* pValue);
    HRESULT SetGravity(int Value);
    HRESULT GetPara2(ITextPara2* ppPara);
    HRESULT SetPara2(ITextPara2 pPara);
    HRESULT GetRow(ITextRow* ppRow);
    HRESULT GetStartPara(int* pValue);
    HRESULT GetTable(IUnknown* ppTable);
    HRESULT GetURL(BSTR* pbstr);
    HRESULT SetURL(BSTR bstr);
    HRESULT AddSubrange(int cp1, int cp2, int Activate);
    HRESULT BuildUpMath(int Flags);
    HRESULT DeleteSubrange(int cpFirst, int cpLim);
    HRESULT Find(ITextRange2 pRange, int Count, int Flags, int* pDelta);
    HRESULT GetChar2(int* pChar, int Offset);
    HRESULT GetDropCap(int* pcLine, int* pPosition);
    HRESULT GetInlineObject(int* pType, int* pAlign, int* pChar, int* pChar1, int* pChar2, int* pCount, int* pTeXStyle, int* pcCol, int* pLevel);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom, int* pHit);
    HRESULT GetSubrange(int iSubrange, int* pcpFirst, int* pcpLim);
    HRESULT GetText2(int Flags, BSTR* pbstr);
    HRESULT HexToUnicode();
    HRESULT InsertTable(int cCol, int cRow, int AutoFit);
    HRESULT Linearize(int Flags);
    HRESULT SetActiveSubrange(int cpAnchor, int cpActive);
    HRESULT SetDropCap(int cLine, int Position);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetText2(int Flags, BSTR bstr);
    HRESULT UnicodeToHex();
    HRESULT SetInlineObject(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol);
    HRESULT GetMathFunctionType(BSTR bstr, int* pValue);
    HRESULT InsertImage(int width, int height, int ascent, int Type, BSTR bstrAltText, IStream pStream);
}

const GUID IID_ITextSelection2 = {0xC241F5E1, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E1, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextSelection2 : ITextRange2
{
}

const GUID IID_ITextFont2 = {0xC241F5E3, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E3, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextFont2 : ITextFont
{
    HRESULT GetCount(int* pCount);
    HRESULT GetAutoLigatures(int* pValue);
    HRESULT SetAutoLigatures(int Value);
    HRESULT GetAutospaceAlpha(int* pValue);
    HRESULT SetAutospaceAlpha(int Value);
    HRESULT GetAutospaceNumeric(int* pValue);
    HRESULT SetAutospaceNumeric(int Value);
    HRESULT GetAutospaceParens(int* pValue);
    HRESULT SetAutospaceParens(int Value);
    HRESULT GetCharRep(int* pValue);
    HRESULT SetCharRep(int Value);
    HRESULT GetCompressionMode(int* pValue);
    HRESULT SetCompressionMode(int Value);
    HRESULT GetCookie(int* pValue);
    HRESULT SetCookie(int Value);
    HRESULT GetDoubleStrike(int* pValue);
    HRESULT SetDoubleStrike(int Value);
    HRESULT GetDuplicate2(ITextFont2* ppFont);
    HRESULT SetDuplicate2(ITextFont2 pFont);
    HRESULT GetLinkType(int* pValue);
    HRESULT GetMathZone(int* pValue);
    HRESULT SetMathZone(int Value);
    HRESULT GetModWidthPairs(int* pValue);
    HRESULT SetModWidthPairs(int Value);
    HRESULT GetModWidthSpace(int* pValue);
    HRESULT SetModWidthSpace(int Value);
    HRESULT GetOldNumbers(int* pValue);
    HRESULT SetOldNumbers(int Value);
    HRESULT GetOverlapping(int* pValue);
    HRESULT SetOverlapping(int Value);
    HRESULT GetPositionSubSuper(int* pValue);
    HRESULT SetPositionSubSuper(int Value);
    HRESULT GetScaling(int* pValue);
    HRESULT SetScaling(int Value);
    HRESULT GetSpaceExtension(float* pValue);
    HRESULT SetSpaceExtension(float Value);
    HRESULT GetUnderlinePositionMode(int* pValue);
    HRESULT SetUnderlinePositionMode(int Value);
    HRESULT GetEffects(int* pValue, int* pMask);
    HRESULT GetEffects2(int* pValue, int* pMask);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetPropertyInfo(int Index, int* pType, int* pValue);
    HRESULT IsEqual2(ITextFont2 pFont, int* pB);
    HRESULT SetEffects(int Value, int Mask);
    HRESULT SetEffects2(int Value, int Mask);
    HRESULT SetProperty(int Type, int Value);
}

const GUID IID_ITextPara2 = {0xC241F5E4, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E4, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextPara2 : ITextPara
{
    HRESULT GetBorders(IUnknown* ppBorders);
    HRESULT GetDuplicate2(ITextPara2* ppPara);
    HRESULT SetDuplicate2(ITextPara2 pPara);
    HRESULT GetFontAlignment(int* pValue);
    HRESULT SetFontAlignment(int Value);
    HRESULT GetHangingPunctuation(int* pValue);
    HRESULT SetHangingPunctuation(int Value);
    HRESULT GetSnapToGrid(int* pValue);
    HRESULT SetSnapToGrid(int Value);
    HRESULT GetTrimPunctuationAtStart(int* pValue);
    HRESULT SetTrimPunctuationAtStart(int Value);
    HRESULT GetEffects(int* pValue, int* pMask);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT IsEqual2(ITextPara2 pPara, int* pB);
    HRESULT SetEffects(int Value, int Mask);
    HRESULT SetProperty(int Type, int Value);
}

const GUID IID_ITextStoryRanges2 = {0xC241F5E5, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E5, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextStoryRanges2 : ITextStoryRanges
{
    HRESULT Item2(int Index, ITextRange2* ppRange);
}

const GUID IID_ITextStory = {0xC241F5F3, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5F3, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextStory : IUnknown
{
    HRESULT GetActive(int* pValue);
    HRESULT SetActive(int Value);
    HRESULT GetDisplay(IUnknown* ppDisplay);
    HRESULT GetIndex(int* pValue);
    HRESULT GetType(int* pValue);
    HRESULT SetType(int Value);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT GetRange(int cpActive, int cpAnchor, ITextRange2* ppRange);
    HRESULT GetText(int Flags, BSTR* pbstr);
    HRESULT SetFormattedText(IUnknown pUnk);
    HRESULT SetProperty(int Type, int Value);
    HRESULT SetText(int Flags, BSTR bstr);
}

const GUID IID_ITextStrings = {0xC241F5E7, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5E7, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextStrings : IDispatch
{
    HRESULT Item(int Index, ITextRange2* ppRange);
    HRESULT GetCount(int* pCount);
    HRESULT Add(BSTR bstr);
    HRESULT Append(ITextRange2 pRange, int iString);
    HRESULT Cat2(int iString);
    HRESULT CatTop2(BSTR bstr);
    HRESULT DeleteRange(ITextRange2 pRange);
    HRESULT EncodeFunction(int Type, int Align, int Char, int Char1, int Char2, int Count, int TeXStyle, int cCol, ITextRange2 pRange);
    HRESULT GetCch(int iString, int* pcch);
    HRESULT InsertNullStr(int iString);
    HRESULT MoveBoundary(int iString, int cch);
    HRESULT PrefixTop(BSTR bstr);
    HRESULT Remove(int iString, int cString);
    HRESULT SetFormattedText(ITextRange2 pRangeD, ITextRange2 pRangeS);
    HRESULT SetOpCp(int iString, int cp);
    HRESULT SuffixTop(BSTR bstr, ITextRange2 pRange);
    HRESULT Swap();
}

const GUID IID_ITextRow = {0xC241F5EF, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5EF, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextRow : IDispatch
{
    HRESULT GetAlignment(int* pValue);
    HRESULT SetAlignment(int Value);
    HRESULT GetCellCount(int* pValue);
    HRESULT SetCellCount(int Value);
    HRESULT GetCellCountCache(int* pValue);
    HRESULT SetCellCountCache(int Value);
    HRESULT GetCellIndex(int* pValue);
    HRESULT SetCellIndex(int Value);
    HRESULT GetCellMargin(int* pValue);
    HRESULT SetCellMargin(int Value);
    HRESULT GetHeight(int* pValue);
    HRESULT SetHeight(int Value);
    HRESULT GetIndent(int* pValue);
    HRESULT SetIndent(int Value);
    HRESULT GetKeepTogether(int* pValue);
    HRESULT SetKeepTogether(int Value);
    HRESULT GetKeepWithNext(int* pValue);
    HRESULT SetKeepWithNext(int Value);
    HRESULT GetNestLevel(int* pValue);
    HRESULT GetRTL(int* pValue);
    HRESULT SetRTL(int Value);
    HRESULT GetCellAlignment(int* pValue);
    HRESULT SetCellAlignment(int Value);
    HRESULT GetCellColorBack(int* pValue);
    HRESULT SetCellColorBack(int Value);
    HRESULT GetCellColorFore(int* pValue);
    HRESULT SetCellColorFore(int Value);
    HRESULT GetCellMergeFlags(int* pValue);
    HRESULT SetCellMergeFlags(int Value);
    HRESULT GetCellShading(int* pValue);
    HRESULT SetCellShading(int Value);
    HRESULT GetCellVerticalText(int* pValue);
    HRESULT SetCellVerticalText(int Value);
    HRESULT GetCellWidth(int* pValue);
    HRESULT SetCellWidth(int Value);
    HRESULT GetCellBorderColors(int* pcrLeft, int* pcrTop, int* pcrRight, int* pcrBottom);
    HRESULT GetCellBorderWidths(int* pduLeft, int* pduTop, int* pduRight, int* pduBottom);
    HRESULT SetCellBorderColors(int crLeft, int crTop, int crRight, int crBottom);
    HRESULT SetCellBorderWidths(int duLeft, int duTop, int duRight, int duBottom);
    HRESULT Apply(int cRow, int Flags);
    HRESULT CanChange(int* pValue);
    HRESULT GetProperty(int Type, int* pValue);
    HRESULT Insert(int cRow);
    HRESULT IsEqual(ITextRow pRow, int* pB);
    HRESULT Reset(int Value);
    HRESULT SetProperty(int Type, int Value);
}

const GUID IID_ITextDisplays = {0xC241F5F2, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]};
@GUID(0xC241F5F2, 0x7206, 0x11D8, [0xA2, 0xC7, 0x00, 0xA0, 0xD1, 0xD6, 0xC6, 0xB3]);
interface ITextDisplays : IDispatch
{
}

const GUID IID_ITextDocument2Old = {0x01C25500, 0x4268, 0x11D1, [0x88, 0x3A, 0x3C, 0x8B, 0x00, 0xC1, 0x00, 0x00]};
@GUID(0x01C25500, 0x4268, 0x11D1, [0x88, 0x3A, 0x3C, 0x8B, 0x00, 0xC1, 0x00, 0x00]);
interface ITextDocument2Old : ITextDocument
{
    HRESULT AttachMsgFilter(IUnknown pFilter);
    HRESULT SetEffectColor(int Index, uint cr);
    HRESULT GetEffectColor(int Index, uint* pcr);
    HRESULT GetCaretType(int* pCaretType);
    HRESULT SetCaretType(int CaretType);
    HRESULT GetImmContext(long* pContext);
    HRESULT ReleaseImmContext(long Context);
    HRESULT GetPreferredFont(int cp, int CharRep, int Option, int CharRepCur, int curFontSize, BSTR* pbstr, int* pPitchAndFamily, int* pNewFontSize);
    HRESULT GetNotificationMode(int* pMode);
    HRESULT SetNotificationMode(int Mode);
    HRESULT GetClientRect(int Type, int* pLeft, int* pTop, int* pRight, int* pBottom);
    HRESULT GetSelection2(ITextSelection* ppSel);
    HRESULT GetWindow(int* phWnd);
    HRESULT GetFEFlags(int* pFlags);
    HRESULT UpdateWindow();
    HRESULT CheckTextLimit(int cch, int* pcch);
    HRESULT IMEInProgress(int Value);
    HRESULT SysBeep();
    HRESULT Update(int Mode);
    HRESULT Notify(int Notify);
    HRESULT GetDocumentFont(ITextFont* ppITextFont);
    HRESULT GetDocumentPara(ITextPara* ppITextPara);
    HRESULT GetCallManager(IUnknown* ppVoid);
    HRESULT ReleaseCallManager(IUnknown pVoid);
}

struct REOBJECT
{
    uint cbStruct;
    int cp;
    Guid clsid;
    IOleObject poleobj;
    IStorage pstg;
    IOleClientSite polesite;
    SIZE sizel;
    uint dvaspect;
    uint dwFlags;
    uint dwUser;
}

interface IRichEditOle : IUnknown
{
    HRESULT GetClientSite(IOleClientSite* lplpolesite);
    int GetObjectCount();
    int GetLinkCount();
    HRESULT GetObjectA(int iob, REOBJECT* lpreobject, uint dwFlags);
    HRESULT InsertObject(REOBJECT* lpreobject);
    HRESULT ConvertObject(int iob, const(Guid)* rclsidNew, const(char)* lpstrUserTypeNew);
    HRESULT ActivateAs(const(Guid)* rclsid, const(Guid)* rclsidAs);
    HRESULT SetHostNames(const(char)* lpstrContainerApp, const(char)* lpstrContainerObj);
    HRESULT SetLinkAvailable(int iob, BOOL fAvailable);
    HRESULT SetDvaspect(int iob, uint dvaspect);
    HRESULT HandsOffStorage(int iob);
    HRESULT SaveCompleted(int iob, IStorage lpstg);
    HRESULT InPlaceDeactivate();
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    HRESULT ImportDataObject(IDataObject lpdataobj, ushort cf, int hMetaPict);
}

interface IRichEditOleCallback : IUnknown
{
    HRESULT GetNewStorage(IStorage* lplpstg);
    HRESULT GetInPlaceContext(IOleInPlaceFrame* lplpFrame, IOleInPlaceUIWindow* lplpDoc, OIFI* lpFrameInfo);
    HRESULT ShowContainerUI(BOOL fShow);
    HRESULT QueryInsertObject(Guid* lpclsid, IStorage lpstg, int cp);
    HRESULT DeleteObject(IOleObject lpoleobj);
    HRESULT QueryAcceptData(IDataObject lpdataobj, ushort* lpcfFormat, uint reco, BOOL fReally, int hMetaPict);
    HRESULT ContextSensitiveHelp(BOOL fEnterMode);
    HRESULT GetClipboardData(CHARRANGE* lpchrg, uint reco, IDataObject* lplpdataobj);
    HRESULT GetDragDropEffect(BOOL fDrag, uint grfKeyState, uint* pdwEffect);
    HRESULT GetContextMenu(ushort seltype, IOleObject lpoleobj, CHARRANGE* lpchrg, HMENU* lphmenu);
}

enum TXTBACKSTYLE
{
    TXTBACK_TRANSPARENT = 0,
    TXTBACK_OPAQUE = 1,
}

enum TXTHITRESULT
{
    TXTHITRESULT_NOHIT = 0,
    TXTHITRESULT_TRANSPARENT = 1,
    TXTHITRESULT_CLOSE = 2,
    TXTHITRESULT_HIT = 3,
}

enum TXTNATURALSIZE
{
    TXTNS_FITTOCONTENT2 = 0,
    TXTNS_FITTOCONTENT = 1,
    TXTNS_ROUNDTOLINE = 2,
    TXTNS_FITTOCONTENT3 = 3,
    TXTNS_FITTOCONTENTWSP = 4,
    TXTNS_INCLUDELASTLINE = 1073741824,
    TXTNS_EMU = -2147483648,
}

enum TXTVIEW
{
    TXTVIEW_ACTIVE = 0,
    TXTVIEW_INACTIVE = -1,
}

enum CHANGETYPE
{
    CN_GENERIC = 0,
    CN_TEXTCHANGED = 1,
    CN_NEWUNDO = 2,
    CN_NEWREDO = 4,
}

struct CHANGENOTIFY
{
    uint dwChangeType;
    void* pvCookieData;
}

interface ITextServices : IUnknown
{
    HRESULT TxSendMessage(uint msg, WPARAM wparam, LPARAM lparam, LRESULT* plresult);
    HRESULT TxDraw(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, HDC hicTargetDev, RECTL* lprcBounds, RECTL* lprcWBounds, RECT* lprcUpdate, BOOL********** pfnContinue, uint dwContinue, int lViewId);
    HRESULT TxGetHScroll(int* plMin, int* plMax, int* plPos, int* plPage, int* pfEnabled);
    HRESULT TxGetVScroll(int* plMin, int* plMax, int* plPos, int* plPage, int* pfEnabled);
    HRESULT OnTxSetCursor(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, HDC hicTargetDev, RECT* lprcClient, int x, int y);
    HRESULT TxQueryHitPoint(uint dwDrawAspect, int lindex, void* pvAspect, DVTARGETDEVICE* ptd, HDC hdcDraw, HDC hicTargetDev, RECT* lprcClient, int x, int y, uint* pHitResult);
    HRESULT OnTxInPlaceActivate(RECT* prcClient);
    HRESULT OnTxInPlaceDeactivate();
    HRESULT OnTxUIActivate();
    HRESULT OnTxUIDeactivate();
    HRESULT TxGetText(BSTR* pbstrText);
    HRESULT TxSetText(const(wchar)* pszText);
    HRESULT TxGetCurTargetX(int* param0);
    HRESULT TxGetBaseLinePos(int* param0);
    HRESULT TxGetNaturalSize(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, const(SIZE)* psizelExtent, int* pwidth, int* pheight);
    HRESULT TxGetDropTarget(IDropTarget* ppDropTarget);
    HRESULT OnTxPropertyBitsChange(uint dwMask, uint dwBits);
    HRESULT TxGetCachedSize(uint* pdwWidth, uint* pdwHeight);
}

enum CARET_FLAGS
{
    CARET_NONE = 0,
    CARET_CUSTOM = 1,
    CARET_RTL = 2,
    CARET_ITALIC = 32,
    CARET_NULL = 64,
    CARET_ROTATE90 = 128,
}

struct CARET_INFO
{
    HBITMAP hbitmap;
    CARET_FLAGS caretFlags;
}

interface ITextHost : IUnknown
{
    HDC TxGetDC();
    int TxReleaseDC(HDC hdc);
    BOOL TxShowScrollBar(int fnBar, BOOL fShow);
    BOOL TxEnableScrollBar(int fuSBFlags, int fuArrowflags);
    BOOL TxSetScrollRange(int fnBar, int nMinPos, int nMaxPos, BOOL fRedraw);
    BOOL TxSetScrollPos(int fnBar, int nPos, BOOL fRedraw);
    void TxInvalidateRect(RECT* prc, BOOL fMode);
    void TxViewChange(BOOL fUpdate);
    BOOL TxCreateCaret(HBITMAP hbmp, int xWidth, int yHeight);
    BOOL TxShowCaret(BOOL fShow);
    BOOL TxSetCaretPos(int x, int y);
    BOOL TxSetTimer(uint idTimer, uint uTimeout);
    void TxKillTimer(uint idTimer);
    void TxScrollWindowEx(int dx, int dy, RECT* lprcScroll, RECT* lprcClip, HRGN hrgnUpdate, RECT* lprcUpdate, uint fuScroll);
    void TxSetCapture(BOOL fCapture);
    void TxSetFocus();
    void TxSetCursor(HCURSOR hcur, BOOL fText);
    BOOL TxScreenToClient(POINT* lppt);
    BOOL TxClientToScreen(POINT* lppt);
    HRESULT TxActivate(int* plOldState);
    HRESULT TxDeactivate(int lNewState);
    HRESULT TxGetClientRect(RECT* prc);
    HRESULT TxGetViewInset(RECT* prc);
    HRESULT TxGetCharFormat(const(CHARFORMATW)** ppCF);
    HRESULT TxGetParaFormat(const(PARAFORMAT)** ppPF);
    uint TxGetSysColor(int nIndex);
    HRESULT TxGetBackStyle(TXTBACKSTYLE* pstyle);
    HRESULT TxGetMaxLength(uint* plength);
    HRESULT TxGetScrollBars(uint* pdwScrollBar);
    HRESULT TxGetPasswordChar(byte* pch);
    HRESULT TxGetAcceleratorPos(int* pcp);
    HRESULT TxGetExtent(SIZE* lpExtent);
    HRESULT OnTxCharFormatChange(const(CHARFORMATW)* pCF);
    HRESULT OnTxParaFormatChange(const(PARAFORMAT)* pPF);
    HRESULT TxGetPropertyBits(uint dwMask, uint* pdwBits);
    HRESULT TxNotify(uint iNotify, void* pv);
    HIMC__* TxImmGetContext();
    void TxImmReleaseContext(HIMC__* himc);
    HRESULT TxGetSelectionBarWidth(int* lSelBarWidth);
}

interface IRicheditWindowlessAccessibility : IUnknown
{
    HRESULT CreateProvider(IRawElementProviderWindowlessSite pSite, IRawElementProviderSimple* ppProvider);
}

interface IRichEditUiaInformation : IUnknown
{
    HRESULT GetBoundaryRectangle(UiaRect* pUiaRect);
    HRESULT IsVisible();
}

interface IRicheditUiaOverrides : IUnknown
{
    HRESULT GetPropertyOverrideValue(int propertyId, VARIANT* pRetValue);
}

alias PCreateTextServices = extern(Windows) HRESULT function(IUnknown punkOuter, ITextHost pITextHost, IUnknown* ppUnk);
alias PShutdownTextServices = extern(Windows) HRESULT function(IUnknown pTextServices);
interface ITextHost2 : ITextHost
{
    BOOL TxIsDoubleClickPending();
    HRESULT TxGetWindow(HWND* phwnd);
    HRESULT TxSetForegroundWindow();
    HPALETTE TxGetPalette();
    HRESULT TxGetEastAsianFlags(int* pFlags);
    HCURSOR TxSetCursor2(HCURSOR hcur, BOOL bText);
    void TxFreeTextServicesNotification();
    HRESULT TxGetEditStyle(uint dwItem, uint* pdwData);
    HRESULT TxGetWindowStyles(uint* pdwStyle, uint* pdwExStyle);
    HRESULT TxShowDropCaret(BOOL fShow, HDC hdc, RECT* prc);
    HRESULT TxDestroyCaret();
    HRESULT TxGetHorzExtent(int* plHorzExtent);
}

interface ITextServices2 : ITextServices
{
    HRESULT TxGetNaturalSize2(uint dwAspect, HDC hdcDraw, HDC hicTargetDev, DVTARGETDEVICE* ptd, uint dwMode, const(SIZE)* psizelExtent, int* pwidth, int* pheight, int* pascent);
    HRESULT TxDrawD2D(ID2D1RenderTarget pRenderTarget, RECTL* lprcBounds, RECT* lprcUpdate, int lViewId);
}

enum TA_PROPERTY
{
    TAP_FLAGS = 0,
    TAP_TRANSFORMCOUNT = 1,
    TAP_STAGGERDELAY = 2,
    TAP_STAGGERDELAYCAP = 3,
    TAP_STAGGERDELAYFACTOR = 4,
    TAP_ZORDER = 5,
}

enum TA_PROPERTY_FLAG
{
    TAPF_NONE = 0,
    TAPF_HASSTAGGER = 1,
    TAPF_ISRTLAWARE = 2,
    TAPF_ALLOWCOLLECTION = 4,
    TAPF_HASBACKGROUND = 8,
    TAPF_HASPERSPECTIVE = 16,
}

enum TA_TRANSFORM_TYPE
{
    TATT_TRANSLATE_2D = 0,
    TATT_SCALE_2D = 1,
    TATT_OPACITY = 2,
    TATT_CLIP = 3,
}

enum TA_TRANSFORM_FLAG
{
    TATF_NONE = 0,
    TATF_TARGETVALUES_USER = 1,
    TATF_HASINITIALVALUES = 2,
    TATF_HASORIGINVALUES = 4,
}

struct TA_TRANSFORM
{
    TA_TRANSFORM_TYPE eTransformType;
    uint dwTimingFunctionId;
    uint dwStartTime;
    uint dwDurationTime;
    TA_TRANSFORM_FLAG eFlags;
}

struct TA_TRANSFORM_2D
{
    TA_TRANSFORM header;
    float rX;
    float rY;
    float rInitialX;
    float rInitialY;
    float rOriginX;
    float rOriginY;
}

struct TA_TRANSFORM_OPACITY
{
    TA_TRANSFORM header;
    float rOpacity;
    float rInitialOpacity;
}

struct TA_TRANSFORM_CLIP
{
    TA_TRANSFORM header;
    float rLeft;
    float rTop;
    float rRight;
    float rBottom;
    float rInitialLeft;
    float rInitialTop;
    float rInitialRight;
    float rInitialBottom;
}

enum TA_TIMINGFUNCTION_TYPE
{
    TTFT_UNDEFINED = 0,
    TTFT_CUBIC_BEZIER = 1,
}

struct TA_TIMINGFUNCTION
{
    TA_TIMINGFUNCTION_TYPE eTimingFunctionType;
}

struct TA_CUBIC_BEZIER
{
    TA_TIMINGFUNCTION header;
    float rX0;
    float rY0;
    float rX1;
    float rY1;
}

struct DTBGOPTS
{
    uint dwSize;
    uint dwFlags;
    RECT rcClip;
}

enum THEMESIZE
{
    TS_MIN = 0,
    TS_TRUE = 1,
    TS_DRAW = 2,
}

struct MARGINS
{
    int cxLeftWidth;
    int cxRightWidth;
    int cyTopHeight;
    int cyBottomHeight;
}

struct INTLIST
{
    int iValueCount;
    int iValues;
}

enum PROPERTYORIGIN
{
    PO_STATE = 0,
    PO_PART = 1,
    PO_CLASS = 2,
    PO_GLOBAL = 3,
    PO_NOTFOUND = 4,
}

enum WINDOWTHEMEATTRIBUTETYPE
{
    WTA_NONCLIENT = 1,
}

struct WTA_OPTIONS
{
    uint dwFlags;
    uint dwMask;
}

alias DTT_CALLBACK_PROC = extern(Windows) int function(HDC hdc, const(wchar)* pszText, int cchText, RECT* prc, uint dwFlags, LPARAM lParam);
struct DTTOPTS
{
    uint dwSize;
    uint dwFlags;
    uint crText;
    uint crBorder;
    uint crShadow;
    int iTextShadowType;
    POINT ptShadowOffset;
    int iBorderSize;
    int iFontPropId;
    int iColorPropId;
    int iStateId;
    BOOL fApplyOverlay;
    int iGlowSize;
    DTT_CALLBACK_PROC pfnDrawTextCallback;
    LPARAM lParam;
}

enum BP_BUFFERFORMAT
{
    BPBF_COMPATIBLEBITMAP = 0,
    BPBF_DIB = 1,
    BPBF_TOPDOWNDIB = 2,
    BPBF_TOPDOWNMONODIB = 3,
}

enum BP_ANIMATIONSTYLE
{
    BPAS_NONE = 0,
    BPAS_LINEAR = 1,
    BPAS_CUBIC = 2,
    BPAS_SINE = 3,
}

struct BP_ANIMATIONPARAMS
{
    uint cbSize;
    uint dwFlags;
    BP_ANIMATIONSTYLE style;
    uint dwDuration;
}

struct BP_PAINTPARAMS
{
    uint cbSize;
    uint dwFlags;
    const(RECT)* prcExclude;
    const(BLENDFUNCTION)* pBlendFunction;
}

@DllImport("COMCTL32.dll")
HPROPSHEETPAGE CreatePropertySheetPageA(PROPSHEETPAGEA* constPropSheetPagePointer);

@DllImport("COMCTL32.dll")
HPROPSHEETPAGE CreatePropertySheetPageW(PROPSHEETPAGEW* constPropSheetPagePointer);

@DllImport("COMCTL32.dll")
BOOL DestroyPropertySheetPage(HPROPSHEETPAGE param0);

@DllImport("COMCTL32.dll")
int PropertySheetA(PROPSHEETHEADERA_V2* param0);

@DllImport("COMCTL32.dll")
int PropertySheetW(PROPSHEETHEADERW_V2* param0);

@DllImport("COMCTL32.dll")
void InitCommonControls();

@DllImport("COMCTL32.dll")
BOOL InitCommonControlsEx(const(INITCOMMONCONTROLSEX)* picce);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_Create(int cx, int cy, uint flags, int cInitial, int cGrow);

@DllImport("COMCTL32.dll")
BOOL ImageList_Destroy(HIMAGELIST himl);

@DllImport("COMCTL32.dll")
int ImageList_GetImageCount(HIMAGELIST himl);

@DllImport("COMCTL32.dll")
BOOL ImageList_SetImageCount(HIMAGELIST himl, uint uNewCount);

@DllImport("COMCTL32.dll")
int ImageList_Add(HIMAGELIST himl, HBITMAP hbmImage, HBITMAP hbmMask);

@DllImport("COMCTL32.dll")
int ImageList_ReplaceIcon(HIMAGELIST himl, int i, HICON hicon);

@DllImport("COMCTL32.dll")
uint ImageList_SetBkColor(HIMAGELIST himl, uint clrBk);

@DllImport("COMCTL32.dll")
uint ImageList_GetBkColor(HIMAGELIST himl);

@DllImport("COMCTL32.dll")
BOOL ImageList_SetOverlayImage(HIMAGELIST himl, int iImage, int iOverlay);

@DllImport("COMCTL32.dll")
BOOL ImageList_Draw(HIMAGELIST himl, int i, HDC hdcDst, int x, int y, uint fStyle);

@DllImport("COMCTL32.dll")
BOOL ImageList_Replace(HIMAGELIST himl, int i, HBITMAP hbmImage, HBITMAP hbmMask);

@DllImport("COMCTL32.dll")
int ImageList_AddMasked(HIMAGELIST himl, HBITMAP hbmImage, uint crMask);

@DllImport("COMCTL32.dll")
BOOL ImageList_DrawEx(HIMAGELIST himl, int i, HDC hdcDst, int x, int y, int dx, int dy, uint rgbBk, uint rgbFg, uint fStyle);

@DllImport("COMCTL32.dll")
BOOL ImageList_DrawIndirect(IMAGELISTDRAWPARAMS* pimldp);

@DllImport("COMCTL32.dll")
BOOL ImageList_Remove(HIMAGELIST himl, int i);

@DllImport("COMCTL32.dll")
HICON ImageList_GetIcon(HIMAGELIST himl, int i, uint flags);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_LoadImageA(HINSTANCE hi, const(char)* lpbmp, int cx, int cGrow, uint crMask, uint uType, uint uFlags);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_LoadImageW(HINSTANCE hi, const(wchar)* lpbmp, int cx, int cGrow, uint crMask, uint uType, uint uFlags);

@DllImport("COMCTL32.dll")
BOOL ImageList_Copy(HIMAGELIST himlDst, int iDst, HIMAGELIST himlSrc, int iSrc, uint uFlags);

@DllImport("COMCTL32.dll")
BOOL ImageList_BeginDrag(HIMAGELIST himlTrack, int iTrack, int dxHotspot, int dyHotspot);

@DllImport("COMCTL32.dll")
void ImageList_EndDrag();

@DllImport("COMCTL32.dll")
BOOL ImageList_DragEnter(HWND hwndLock, int x, int y);

@DllImport("COMCTL32.dll")
BOOL ImageList_DragLeave(HWND hwndLock);

@DllImport("COMCTL32.dll")
BOOL ImageList_DragMove(int x, int y);

@DllImport("COMCTL32.dll")
BOOL ImageList_SetDragCursorImage(HIMAGELIST himlDrag, int iDrag, int dxHotspot, int dyHotspot);

@DllImport("COMCTL32.dll")
BOOL ImageList_DragShowNolock(BOOL fShow);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_GetDragImage(POINT* ppt, POINT* pptHotspot);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_Read(IStream pstm);

@DllImport("COMCTL32.dll")
BOOL ImageList_Write(HIMAGELIST himl, IStream pstm);

@DllImport("COMCTL32.dll")
HRESULT ImageList_ReadEx(uint dwFlags, IStream pstm, const(Guid)* riid, void** ppv);

@DllImport("COMCTL32.dll")
HRESULT ImageList_WriteEx(HIMAGELIST himl, uint dwFlags, IStream pstm);

@DllImport("COMCTL32.dll")
BOOL ImageList_GetIconSize(HIMAGELIST himl, int* cx, int* cy);

@DllImport("COMCTL32.dll")
BOOL ImageList_SetIconSize(HIMAGELIST himl, int cx, int cy);

@DllImport("COMCTL32.dll")
BOOL ImageList_GetImageInfo(HIMAGELIST himl, int i, IMAGEINFO* pImageInfo);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_Merge(HIMAGELIST himl1, int i1, HIMAGELIST himl2, int i2, int dx, int dy);

@DllImport("COMCTL32.dll")
HIMAGELIST ImageList_Duplicate(HIMAGELIST himl);

@DllImport("COMCTL32.dll")
HRESULT HIMAGELIST_QueryInterface(HIMAGELIST himl, const(Guid)* riid, void** ppv);

@DllImport("COMCTL32.dll")
HWND CreateToolbarEx(HWND hwnd, uint ws, uint wID, int nBitmaps, HINSTANCE hBMInst, uint wBMID, TBBUTTON* lpButtons, int iNumButtons, int dxButton, int dyButton, int dxBitmap, int dyBitmap, uint uStructSize);

@DllImport("COMCTL32.dll")
HBITMAP CreateMappedBitmap(HINSTANCE hInstance, int idBitmap, uint wFlags, COLORMAP* lpColorMap, int iNumMaps);

@DllImport("COMCTL32.dll")
void DrawStatusTextA(HDC hDC, RECT* lprc, const(char)* pszText, uint uFlags);

@DllImport("COMCTL32.dll")
void DrawStatusTextW(HDC hDC, RECT* lprc, const(wchar)* pszText, uint uFlags);

@DllImport("COMCTL32.dll")
HWND CreateStatusWindowA(int style, const(char)* lpszText, HWND hwndParent, uint wID);

@DllImport("COMCTL32.dll")
HWND CreateStatusWindowW(int style, const(wchar)* lpszText, HWND hwndParent, uint wID);

@DllImport("COMCTL32.dll")
void MenuHelp(uint uMsg, WPARAM wParam, LPARAM lParam, HMENU hMainMenu, HINSTANCE hInst, HWND hwndStatus, uint* lpwIDs);

@DllImport("COMCTL32.dll")
BOOL ShowHideMenuCtl(HWND hWnd, uint uFlags, int* lpInfo);

@DllImport("COMCTL32.dll")
void GetEffectiveClientRect(HWND hWnd, RECT* lprc, const(int)* lpInfo);

@DllImport("COMCTL32.dll")
BOOL MakeDragList(HWND hLB);

@DllImport("COMCTL32.dll")
void DrawInsert(HWND handParent, HWND hLB, int nItem);

@DllImport("COMCTL32.dll")
int LBItemFromPt(HWND hLB, POINT pt, BOOL bAutoScroll);

@DllImport("COMCTL32.dll")
HWND CreateUpDownControl(uint dwStyle, int x, int y, int cx, int cy, HWND hParent, int nID, HINSTANCE hInst, HWND hBuddy, int nUpper, int nLower, int nPos);

@DllImport("COMCTL32.dll")
HRESULT TaskDialogIndirect(const(TASKDIALOGCONFIG)* pTaskConfig, int* pnButton, int* pnRadioButton, int* pfVerificationFlagChecked);

@DllImport("COMCTL32.dll")
HRESULT TaskDialog(HWND hwndOwner, HINSTANCE hInstance, const(wchar)* pszWindowTitle, const(wchar)* pszMainInstruction, const(wchar)* pszContent, int dwCommonButtons, const(wchar)* pszIcon, int* pnButton);

@DllImport("COMCTL32.dll")
void InitMUILanguage(ushort uiLang);

@DllImport("COMCTL32.dll")
ushort GetMUILanguage();

@DllImport("COMCTL32.dll")
_DSA* DSA_Create(int cbItem, int cItemGrow);

@DllImport("COMCTL32.dll")
BOOL DSA_Destroy(_DSA* hdsa);

@DllImport("COMCTL32.dll")
void DSA_DestroyCallback(_DSA* hdsa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32.dll")
BOOL DSA_DeleteItem(_DSA* hdsa, int i);

@DllImport("COMCTL32.dll")
BOOL DSA_DeleteAllItems(_DSA* hdsa);

@DllImport("COMCTL32.dll")
void DSA_EnumCallback(_DSA* hdsa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32.dll")
int DSA_InsertItem(_DSA* hdsa, int i, const(void)* pitem);

@DllImport("COMCTL32.dll")
void* DSA_GetItemPtr(_DSA* hdsa, int i);

@DllImport("COMCTL32.dll")
BOOL DSA_GetItem(_DSA* hdsa, int i, char* pitem);

@DllImport("COMCTL32.dll")
BOOL DSA_SetItem(_DSA* hdsa, int i, const(void)* pitem);

@DllImport("COMCTL32.dll")
_DSA* DSA_Clone(_DSA* hdsa);

@DllImport("COMCTL32.dll")
ulong DSA_GetSize(_DSA* hdsa);

@DllImport("COMCTL32.dll")
BOOL DSA_Sort(_DSA* pdsa, PFNDACOMPARE pfnCompare, LPARAM lParam);

@DllImport("COMCTL32.dll")
_DPA* DPA_Create(int cItemGrow);

@DllImport("COMCTL32.dll")
_DPA* DPA_CreateEx(int cpGrow, HANDLE hheap);

@DllImport("COMCTL32.dll")
_DPA* DPA_Clone(const(_DPA)* hdpa, _DPA* hdpaNew);

@DllImport("COMCTL32.dll")
BOOL DPA_Destroy(_DPA* hdpa);

@DllImport("COMCTL32.dll")
void DPA_DestroyCallback(_DPA* hdpa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32.dll")
void* DPA_DeletePtr(_DPA* hdpa, int i);

@DllImport("COMCTL32.dll")
BOOL DPA_DeleteAllPtrs(_DPA* hdpa);

@DllImport("COMCTL32.dll")
void DPA_EnumCallback(_DPA* hdpa, PFNDAENUMCALLBACK pfnCB, void* pData);

@DllImport("COMCTL32.dll")
BOOL DPA_Grow(_DPA* pdpa, int cp);

@DllImport("COMCTL32.dll")
int DPA_InsertPtr(_DPA* hdpa, int i, void* p);

@DllImport("COMCTL32.dll")
BOOL DPA_SetPtr(_DPA* hdpa, int i, void* p);

@DllImport("COMCTL32.dll")
void* DPA_GetPtr(_DPA* hdpa, int i);

@DllImport("COMCTL32.dll")
int DPA_GetPtrIndex(_DPA* hdpa, const(void)* p);

@DllImport("COMCTL32.dll")
ulong DPA_GetSize(_DPA* hdpa);

@DllImport("COMCTL32.dll")
BOOL DPA_Sort(_DPA* hdpa, PFNDACOMPARE pfnCompare, LPARAM lParam);

@DllImport("COMCTL32.dll")
HRESULT DPA_LoadStream(_DPA** phdpa, PFNDPASTREAM pfn, IStream pstream, void* pvInstData);

@DllImport("COMCTL32.dll")
HRESULT DPA_SaveStream(_DPA* hdpa, PFNDPASTREAM pfn, IStream pstream, void* pvInstData);

@DllImport("COMCTL32.dll")
BOOL DPA_Merge(_DPA* hdpaDest, _DPA* hdpaSrc, uint dwFlags, PFNDACOMPARE pfnCompare, PFNDPAMERGE pfnMerge, LPARAM lParam);

@DllImport("COMCTL32.dll")
int DPA_Search(_DPA* hdpa, void* pFind, int iStart, PFNDACOMPARE pfnCompare, LPARAM lParam, uint options);

@DllImport("COMCTL32.dll")
BOOL Str_SetPtrW(ushort** ppsz, const(wchar)* psz);

@DllImport("COMCTL32.dll")
BOOL FlatSB_EnableScrollBar(HWND param0, int param1, uint param2);

@DllImport("COMCTL32.dll")
BOOL FlatSB_ShowScrollBar(HWND param0, int code, BOOL param2);

@DllImport("COMCTL32.dll")
BOOL FlatSB_GetScrollRange(HWND param0, int code, int* param2, int* param3);

@DllImport("COMCTL32.dll")
BOOL FlatSB_GetScrollInfo(HWND param0, int code, SCROLLINFO* param2);

@DllImport("COMCTL32.dll")
int FlatSB_GetScrollPos(HWND param0, int code);

@DllImport("COMCTL32.dll")
BOOL FlatSB_GetScrollProp(HWND param0, int propIndex, int* param2);

@DllImport("COMCTL32.dll")
int FlatSB_SetScrollPos(HWND param0, int code, int pos, BOOL fRedraw);

@DllImport("COMCTL32.dll")
int FlatSB_SetScrollInfo(HWND param0, int code, SCROLLINFO* psi, BOOL fRedraw);

@DllImport("COMCTL32.dll")
int FlatSB_SetScrollRange(HWND param0, int code, int min, int max, BOOL fRedraw);

@DllImport("COMCTL32.dll")
BOOL FlatSB_SetScrollProp(HWND param0, uint index, int newValue, BOOL param3);

@DllImport("COMCTL32.dll")
BOOL InitializeFlatSB(HWND param0);

@DllImport("COMCTL32.dll")
HRESULT UninitializeFlatSB(HWND param0);

@DllImport("COMCTL32.dll")
HRESULT LoadIconMetric(HINSTANCE hinst, const(wchar)* pszName, int lims, HICON* phico);

@DllImport("COMCTL32.dll")
HRESULT LoadIconWithScaleDown(HINSTANCE hinst, const(wchar)* pszName, int cx, int cy, HICON* phico);

@DllImport("COMCTL32.dll")
int DrawShadowText(HDC hdc, const(wchar)* pszText, uint cch, RECT* prc, uint dwFlags, uint crText, uint crShadow, int ixOffset, int iyOffset);

@DllImport("COMCTL32.dll")
HRESULT ImageList_CoCreateInstance(const(Guid)* rclsid, const(IUnknown) punkOuter, const(Guid)* riid, void** ppv);

@DllImport("UXTHEME.dll")
HRESULT GetThemeAnimationProperty(int hTheme, int iStoryboardId, int iTargetId, TA_PROPERTY eProperty, char* pvProperty, uint cbSize, uint* pcbSizeOut);

@DllImport("UXTHEME.dll")
HRESULT GetThemeAnimationTransform(int hTheme, int iStoryboardId, int iTargetId, uint dwTransformIndex, char* pTransform, uint cbSize, uint* pcbSizeOut);

@DllImport("UXTHEME.dll")
HRESULT GetThemeTimingFunction(int hTheme, int iTimingFunctionId, char* pTimingFunction, uint cbSize, uint* pcbSizeOut);

@DllImport("UXTHEME.dll")
int OpenThemeData(HWND hwnd, const(wchar)* pszClassList);

@DllImport("UXTHEME.dll")
int OpenThemeDataEx(HWND hwnd, const(wchar)* pszClassList, uint dwFlags);

@DllImport("UXTHEME.dll")
HRESULT CloseThemeData(int hTheme);

@DllImport("UXTHEME.dll")
HRESULT DrawThemeBackground(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, RECT* pClipRect);

@DllImport("UXTHEME.dll")
HRESULT DrawThemeBackgroundEx(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, const(DTBGOPTS)* pOptions);

@DllImport("UxTheme.dll")
HRESULT DrawThemeText(int hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, int cchText, uint dwTextFlags, uint dwTextFlags2, RECT* pRect);

@DllImport("UXTHEME.dll")
HRESULT GetThemeBackgroundContentRect(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pBoundingRect, RECT* pContentRect);

@DllImport("UXTHEME.dll")
HRESULT GetThemeBackgroundExtent(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pContentRect, RECT* pExtentRect);

@DllImport("UxTheme.dll")
HRESULT GetThemeBackgroundRegion(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, HRGN* pRegion);

@DllImport("UXTHEME.dll")
HRESULT GetThemePartSize(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* prc, THEMESIZE eSize, SIZE* psz);

@DllImport("UxTheme.dll")
HRESULT GetThemeTextExtent(int hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, int cchCharCount, uint dwTextFlags, RECT* pBoundingRect, RECT* pExtentRect);

@DllImport("UxTheme.dll")
HRESULT GetThemeTextMetrics(int hTheme, HDC hdc, int iPartId, int iStateId, TEXTMETRICW* ptm);

@DllImport("UxTheme.dll")
HRESULT HitTestThemeBackground(int hTheme, HDC hdc, int iPartId, int iStateId, uint dwOptions, RECT* pRect, HRGN hrgn, POINT ptTest, ushort* pwHitTestCode);

@DllImport("UxTheme.dll")
HRESULT DrawThemeEdge(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pDestRect, uint uEdge, uint uFlags, RECT* pContentRect);

@DllImport("UxTheme.dll")
HRESULT DrawThemeIcon(int hTheme, HDC hdc, int iPartId, int iStateId, RECT* pRect, HIMAGELIST himl, int iImageIndex);

@DllImport("UXTHEME.dll")
BOOL IsThemePartDefined(int hTheme, int iPartId, int iStateId);

@DllImport("UxTheme.dll")
BOOL IsThemeBackgroundPartiallyTransparent(int hTheme, int iPartId, int iStateId);

@DllImport("UXTHEME.dll")
HRESULT GetThemeColor(int hTheme, int iPartId, int iStateId, int iPropId, uint* pColor);

@DllImport("UXTHEME.dll")
HRESULT GetThemeMetric(int hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UxTheme.dll")
HRESULT GetThemeString(int hTheme, int iPartId, int iStateId, int iPropId, const(wchar)* pszBuff, int cchMaxBuffChars);

@DllImport("UxTheme.dll")
HRESULT GetThemeBool(int hTheme, int iPartId, int iStateId, int iPropId, int* pfVal);

@DllImport("UXTHEME.dll")
HRESULT GetThemeInt(int hTheme, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UXTHEME.dll")
HRESULT GetThemeEnumValue(int hTheme, int iPartId, int iStateId, int iPropId, int* piVal);

@DllImport("UXTHEME.dll")
HRESULT GetThemePosition(int hTheme, int iPartId, int iStateId, int iPropId, POINT* pPoint);

@DllImport("UXTHEME.dll")
HRESULT GetThemeFont(int hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, LOGFONTW* pFont);

@DllImport("UXTHEME.dll")
HRESULT GetThemeRect(int hTheme, int iPartId, int iStateId, int iPropId, RECT* pRect);

@DllImport("UXTHEME.dll")
HRESULT GetThemeMargins(int hTheme, HDC hdc, int iPartId, int iStateId, int iPropId, RECT* prc, MARGINS* pMargins);

@DllImport("UxTheme.dll")
HRESULT GetThemeIntList(int hTheme, int iPartId, int iStateId, int iPropId, INTLIST* pIntList);

@DllImport("UxTheme.dll")
HRESULT GetThemePropertyOrigin(int hTheme, int iPartId, int iStateId, int iPropId, PROPERTYORIGIN* pOrigin);

@DllImport("UXTHEME.dll")
HRESULT SetWindowTheme(HWND hwnd, const(wchar)* pszSubAppName, const(wchar)* pszSubIdList);

@DllImport("UxTheme.dll")
HRESULT GetThemeFilename(int hTheme, int iPartId, int iStateId, int iPropId, const(wchar)* pszThemeFileName, int cchMaxBuffChars);

@DllImport("UxTheme.dll")
uint GetThemeSysColor(int hTheme, int iColorId);

@DllImport("UxTheme.dll")
HBRUSH GetThemeSysColorBrush(int hTheme, int iColorId);

@DllImport("UxTheme.dll")
BOOL GetThemeSysBool(int hTheme, int iBoolId);

@DllImport("UxTheme.dll")
int GetThemeSysSize(int hTheme, int iSizeId);

@DllImport("UxTheme.dll")
HRESULT GetThemeSysFont(int hTheme, int iFontId, LOGFONTW* plf);

@DllImport("UxTheme.dll")
HRESULT GetThemeSysString(int hTheme, int iStringId, const(wchar)* pszStringBuff, int cchMaxStringChars);

@DllImport("UxTheme.dll")
HRESULT GetThemeSysInt(int hTheme, int iIntId, int* piValue);

@DllImport("UXTHEME.dll")
BOOL IsThemeActive();

@DllImport("UXTHEME.dll")
BOOL IsAppThemed();

@DllImport("UXTHEME.dll")
int GetWindowTheme(HWND hwnd);

@DllImport("UxTheme.dll")
HRESULT EnableThemeDialogTexture(HWND hwnd, uint dwFlags);

@DllImport("UxTheme.dll")
BOOL IsThemeDialogTextureEnabled(HWND hwnd);

@DllImport("UXTHEME.dll")
uint GetThemeAppProperties();

@DllImport("UxTheme.dll")
void SetThemeAppProperties(uint dwFlags);

@DllImport("UXTHEME.dll")
HRESULT GetCurrentThemeName(const(wchar)* pszThemeFileName, int cchMaxNameChars, const(wchar)* pszColorBuff, int cchMaxColorChars, const(wchar)* pszSizeBuff, int cchMaxSizeChars);

@DllImport("UxTheme.dll")
HRESULT GetThemeDocumentationProperty(const(wchar)* pszThemeName, const(wchar)* pszPropertyName, const(wchar)* pszValueBuff, int cchMaxValChars);

@DllImport("UXTHEME.dll")
HRESULT DrawThemeParentBackground(HWND hwnd, HDC hdc, const(RECT)* prc);

@DllImport("UxTheme.dll")
HRESULT EnableTheming(BOOL fEnable);

@DllImport("UxTheme.dll")
HRESULT DrawThemeParentBackgroundEx(HWND hwnd, HDC hdc, uint dwFlags, const(RECT)* prc);

@DllImport("UXTHEME.dll")
HRESULT SetWindowThemeAttribute(HWND hwnd, WINDOWTHEMEATTRIBUTETYPE eAttribute, char* pvAttribute, uint cbAttribute);

@DllImport("UXTHEME.dll")
HRESULT DrawThemeTextEx(int hTheme, HDC hdc, int iPartId, int iStateId, const(wchar)* pszText, int cchText, uint dwTextFlags, RECT* pRect, const(DTTOPTS)* pOptions);

@DllImport("UXTHEME.dll")
HRESULT GetThemeBitmap(int hTheme, int iPartId, int iStateId, int iPropId, uint dwFlags, HBITMAP* phBitmap);

@DllImport("UXTHEME.dll")
HRESULT GetThemeStream(int hTheme, int iPartId, int iStateId, int iPropId, void** ppvStream, uint* pcbStream, HINSTANCE hInst);

@DllImport("UXTHEME.dll")
HRESULT BufferedPaintInit();

@DllImport("UXTHEME.dll")
HRESULT BufferedPaintUnInit();

@DllImport("UXTHEME.dll")
int BeginBufferedPaint(HDC hdcTarget, const(RECT)* prcTarget, BP_BUFFERFORMAT dwFormat, BP_PAINTPARAMS* pPaintParams, HDC* phdc);

@DllImport("UXTHEME.dll")
HRESULT EndBufferedPaint(int hBufferedPaint, BOOL fUpdateTarget);

@DllImport("UxTheme.dll")
HRESULT GetBufferedPaintTargetRect(int hBufferedPaint, RECT* prc);

@DllImport("UxTheme.dll")
HDC GetBufferedPaintTargetDC(int hBufferedPaint);

@DllImport("UxTheme.dll")
HDC GetBufferedPaintDC(int hBufferedPaint);

@DllImport("UXTHEME.dll")
HRESULT GetBufferedPaintBits(int hBufferedPaint, RGBQUAD** ppbBuffer, int* pcxRow);

@DllImport("UXTHEME.dll")
HRESULT BufferedPaintClear(int hBufferedPaint, const(RECT)* prc);

@DllImport("UxTheme.dll")
HRESULT BufferedPaintSetAlpha(int hBufferedPaint, const(RECT)* prc, ubyte alpha);

@DllImport("UXTHEME.dll")
HRESULT BufferedPaintStopAllAnimations(HWND hwnd);

@DllImport("UxTheme.dll")
int BeginBufferedAnimation(HWND hwnd, HDC hdcTarget, const(RECT)* prcTarget, BP_BUFFERFORMAT dwFormat, BP_PAINTPARAMS* pPaintParams, BP_ANIMATIONPARAMS* pAnimationParams, HDC* phdcFrom, HDC* phdcTo);

@DllImport("UxTheme.dll")
HRESULT EndBufferedAnimation(int hbpAnimation, BOOL fUpdateTarget);

@DllImport("UxTheme.dll")
BOOL BufferedPaintRenderAnimation(HWND hwnd, HDC hdcTarget);

@DllImport("UXTHEME.dll")
BOOL IsCompositionActive();

@DllImport("UxTheme.dll")
HRESULT GetThemeTransitionDuration(int hTheme, int iPartId, int iStateIdFrom, int iStateIdTo, int iPropId, uint* pdwDuration);

@DllImport("USER32.dll")
BOOL CheckDlgButton(HWND hDlg, int nIDButton, uint uCheck);

@DllImport("USER32.dll")
BOOL CheckRadioButton(HWND hDlg, int nIDFirstButton, int nIDLastButton, int nIDCheckButton);

@DllImport("USER32.dll")
uint IsDlgButtonChecked(HWND hDlg, int nIDButton);

@DllImport("USER32.dll")
BOOL IsCharLowerW(ushort ch);

@DllImport("USER32.dll")
BOOL InitializeTouchInjection(uint maxCount, uint dwMode);

@DllImport("USER32.dll")
BOOL InjectTouchInput(uint count, char* contacts);

@DllImport("USER32.dll")
int CreateSyntheticPointerDevice(uint pointerType, uint maxCount, POINTER_FEEDBACK_MODE mode);

@DllImport("USER32.dll")
BOOL InjectSyntheticPointerInput(int device, char* pointerInfo, uint count);

@DllImport("USER32.dll")
void DestroySyntheticPointerDevice(int device);

@DllImport("USER32.dll")
BOOL RegisterTouchHitTestingWindow(HWND hwnd, uint value);

@DllImport("USER32.dll")
BOOL EvaluateProximityToRect(const(RECT)* controlBoundingBox, const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, TOUCH_HIT_TESTING_PROXIMITY_EVALUATION* pProximityEval);

@DllImport("USER32.dll")
BOOL EvaluateProximityToPolygon(uint numVertices, char* controlPolygon, const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, TOUCH_HIT_TESTING_PROXIMITY_EVALUATION* pProximityEval);

@DllImport("USER32.dll")
LRESULT PackTouchHitTestingProximityEvaluation(const(TOUCH_HIT_TESTING_INPUT)* pHitTestingInput, const(TOUCH_HIT_TESTING_PROXIMITY_EVALUATION)* pProximityEval);

@DllImport("USER32.dll")
BOOL GetWindowFeedbackSetting(HWND hwnd, FEEDBACK_TYPE feedback, uint dwFlags, uint* pSize, char* config);

@DllImport("USER32.dll")
BOOL SetWindowFeedbackSetting(HWND hwnd, FEEDBACK_TYPE feedback, uint dwFlags, uint size, char* configuration);

@DllImport("USER32.dll")
BOOL ScrollWindow(HWND hWnd, int XAmount, int YAmount, const(RECT)* lpRect, const(RECT)* lpClipRect);

@DllImport("USER32.dll")
BOOL ScrollDC(HDC hDC, int dx, int dy, const(RECT)* lprcScroll, const(RECT)* lprcClip, HRGN hrgnUpdate, RECT* lprcUpdate);

@DllImport("USER32.dll")
int ScrollWindowEx(HWND hWnd, int dx, int dy, const(RECT)* prcScroll, const(RECT)* prcClip, HRGN hrgnUpdate, RECT* prcUpdate, uint flags);

@DllImport("USER32.dll")
int SetScrollPos(HWND hWnd, int nBar, int nPos, BOOL bRedraw);

@DllImport("USER32.dll")
int GetScrollPos(HWND hWnd, int nBar);

@DllImport("USER32.dll")
BOOL SetScrollRange(HWND hWnd, int nBar, int nMinPos, int nMaxPos, BOOL bRedraw);

@DllImport("USER32.dll")
BOOL GetScrollRange(HWND hWnd, int nBar, int* lpMinPos, int* lpMaxPos);

@DllImport("USER32.dll")
BOOL ShowScrollBar(HWND hWnd, int wBar, BOOL bShow);

@DllImport("USER32.dll")
BOOL EnableScrollBar(HWND hWnd, uint wSBflags, uint wArrows);

@DllImport("USER32.dll")
int DlgDirListA(HWND hDlg, const(char)* lpPathSpec, int nIDListBox, int nIDStaticPath, uint uFileType);

@DllImport("USER32.dll")
int DlgDirListW(HWND hDlg, const(wchar)* lpPathSpec, int nIDListBox, int nIDStaticPath, uint uFileType);

@DllImport("USER32.dll")
BOOL DlgDirSelectExA(HWND hwndDlg, const(char)* lpString, int chCount, int idListBox);

@DllImport("USER32.dll")
BOOL DlgDirSelectExW(HWND hwndDlg, const(wchar)* lpString, int chCount, int idListBox);

@DllImport("USER32.dll")
int DlgDirListComboBoxA(HWND hDlg, const(char)* lpPathSpec, int nIDComboBox, int nIDStaticPath, uint uFiletype);

@DllImport("USER32.dll")
int DlgDirListComboBoxW(HWND hDlg, const(wchar)* lpPathSpec, int nIDComboBox, int nIDStaticPath, uint uFiletype);

@DllImport("USER32.dll")
BOOL DlgDirSelectComboBoxExA(HWND hwndDlg, const(char)* lpString, int cchOut, int idComboBox);

@DllImport("USER32.dll")
BOOL DlgDirSelectComboBoxExW(HWND hwndDlg, const(wchar)* lpString, int cchOut, int idComboBox);

@DllImport("USER32.dll")
int SetScrollInfo(HWND hwnd, int nBar, SCROLLINFO* lpsi, BOOL redraw);

@DllImport("USER32.dll")
BOOL GetScrollInfo(HWND hwnd, int nBar, SCROLLINFO* lpsi);

@DllImport("USER32.dll")
BOOL GetScrollBarInfo(HWND hwnd, int idObject, SCROLLBARINFO* psbi);

@DllImport("USER32.dll")
BOOL GetComboBoxInfo(HWND hwndCombo, COMBOBOXINFO* pcbi);

@DllImport("USER32.dll")
uint GetListBoxInfo(HWND hwnd);

@DllImport("USER32.dll")
BOOL GetPointerDevices(uint* deviceCount, char* pointerDevices);

@DllImport("USER32.dll")
BOOL GetPointerDevice(HANDLE device, POINTER_DEVICE_INFO* pointerDevice);

@DllImport("USER32.dll")
BOOL GetPointerDeviceProperties(HANDLE device, uint* propertyCount, char* pointerProperties);

@DllImport("USER32.dll")
BOOL RegisterPointerDeviceNotifications(HWND window, BOOL notifyRange);

@DllImport("USER32.dll")
BOOL GetPointerDeviceRects(HANDLE device, RECT* pointerDeviceRect, RECT* displayRect);

@DllImport("USER32.dll")
BOOL GetPointerDeviceCursors(HANDLE device, uint* cursorCount, char* deviceCursors);

@DllImport("USER32.dll")
BOOL GetRawPointerDeviceData(uint pointerId, uint historyCount, uint propertiesCount, char* pProperties, char* pValues);

@DllImport("USER32.dll")
BOOL GetCurrentInputMessageSource(INPUT_MESSAGE_SOURCE* inputMessageSource);

@DllImport("USER32.dll")
BOOL GetCIMSSM(INPUT_MESSAGE_SOURCE* inputMessageSource);

alias EDITWORDBREAKPROCA = extern(Windows) int function(const(char)* lpch, int ichCurrent, int cch, int code);
alias EDITWORDBREAKPROCW = extern(Windows) int function(const(wchar)* lpch, int ichCurrent, int cch, int code);
struct NMHDR
{
    HWND hwndFrom;
    uint idFrom;
    uint code;
}

struct MEASUREITEMSTRUCT
{
    uint CtlType;
    uint CtlID;
    uint itemID;
    uint itemWidth;
    uint itemHeight;
    uint itemData;
}

struct DRAWITEMSTRUCT
{
    uint CtlType;
    uint CtlID;
    uint itemID;
    uint itemAction;
    uint itemState;
    HWND hwndItem;
    HDC hDC;
    RECT rcItem;
    uint itemData;
}

struct DELETEITEMSTRUCT
{
    uint CtlType;
    uint CtlID;
    uint itemID;
    HWND hwndItem;
    uint itemData;
}

struct COMPAREITEMSTRUCT
{
    uint CtlType;
    uint CtlID;
    HWND hwndItem;
    uint itemID1;
    uint itemData1;
    uint itemID2;
    uint itemData2;
    uint dwLocaleId;
}

enum POINTER_FEEDBACK_MODE
{
    POINTER_FEEDBACK_DEFAULT = 1,
    POINTER_FEEDBACK_INDIRECT = 2,
    POINTER_FEEDBACK_NONE = 3,
}

struct USAGE_PROPERTIES
{
    ushort level;
    ushort page;
    ushort usage;
    int logicalMinimum;
    int logicalMaximum;
    ushort unit;
    ushort exponent;
    ubyte count;
    int physicalMinimum;
    int physicalMaximum;
}

struct POINTER_TYPE_INFO
{
    uint type;
    _Anonymous_e__Union Anonymous;
}

struct INPUT_INJECTION_VALUE
{
    ushort page;
    ushort usage;
    int value;
    ushort index;
}

struct TOUCH_HIT_TESTING_PROXIMITY_EVALUATION
{
    ushort score;
    POINT adjustedPoint;
}

struct TOUCH_HIT_TESTING_INPUT
{
    uint pointerId;
    POINT point;
    RECT boundingBox;
    RECT nonOccludedBoundingBox;
    uint orientation;
}

enum FEEDBACK_TYPE
{
    FEEDBACK_TOUCH_CONTACTVISUALIZATION = 1,
    FEEDBACK_PEN_BARRELVISUALIZATION = 2,
    FEEDBACK_PEN_TAP = 3,
    FEEDBACK_PEN_DOUBLETAP = 4,
    FEEDBACK_PEN_PRESSANDHOLD = 5,
    FEEDBACK_PEN_RIGHTTAP = 6,
    FEEDBACK_TOUCH_TAP = 7,
    FEEDBACK_TOUCH_DOUBLETAP = 8,
    FEEDBACK_TOUCH_PRESSANDHOLD = 9,
    FEEDBACK_TOUCH_RIGHTTAP = 10,
    FEEDBACK_GESTURE_PRESSANDTAP = 11,
    FEEDBACK_MAX = -1,
}

struct SCROLLINFO
{
    uint cbSize;
    uint fMask;
    int nMin;
    int nMax;
    uint nPage;
    int nPos;
    int nTrackPos;
}

struct SCROLLBARINFO
{
    uint cbSize;
    RECT rcScrollBar;
    int dxyLineButton;
    int xyThumbTop;
    int xyThumbBottom;
    int reserved;
    uint rgstate;
}

struct COMBOBOXINFO
{
    uint cbSize;
    RECT rcItem;
    RECT rcButton;
    uint stateButton;
    HWND hwndCombo;
    HWND hwndItem;
    HWND hwndList;
}

enum POINTER_DEVICE_TYPE
{
    POINTER_DEVICE_TYPE_INTEGRATED_PEN = 1,
    POINTER_DEVICE_TYPE_EXTERNAL_PEN = 2,
    POINTER_DEVICE_TYPE_TOUCH = 3,
    POINTER_DEVICE_TYPE_TOUCH_PAD = 4,
    POINTER_DEVICE_TYPE_MAX = -1,
}

struct POINTER_DEVICE_INFO
{
    uint displayOrientation;
    HANDLE device;
    POINTER_DEVICE_TYPE pointerDeviceType;
    int monitor;
    uint startingCursorId;
    ushort maxActiveContacts;
    ushort productString;
}

struct POINTER_DEVICE_PROPERTY
{
    int logicalMin;
    int logicalMax;
    int physicalMin;
    int physicalMax;
    uint unit;
    uint unitExponent;
    ushort usagePageId;
    ushort usageId;
}

enum POINTER_DEVICE_CURSOR_TYPE
{
    POINTER_DEVICE_CURSOR_TYPE_UNKNOWN = 0,
    POINTER_DEVICE_CURSOR_TYPE_TIP = 1,
    POINTER_DEVICE_CURSOR_TYPE_ERASER = 2,
    POINTER_DEVICE_CURSOR_TYPE_MAX = -1,
}

struct POINTER_DEVICE_CURSOR_INFO
{
    uint cursorId;
    POINTER_DEVICE_CURSOR_TYPE cursor;
}

enum INPUT_MESSAGE_DEVICE_TYPE
{
    IMDT_UNAVAILABLE = 0,
    IMDT_KEYBOARD = 1,
    IMDT_MOUSE = 2,
    IMDT_TOUCH = 4,
    IMDT_PEN = 8,
    IMDT_TOUCHPAD = 16,
}

enum INPUT_MESSAGE_ORIGIN_ID
{
    IMO_UNAVAILABLE = 0,
    IMO_HARDWARE = 1,
    IMO_INJECTED = 2,
    IMO_SYSTEM = 4,
}

struct INPUT_MESSAGE_SOURCE
{
    INPUT_MESSAGE_DEVICE_TYPE deviceType;
    INPUT_MESSAGE_ORIGIN_ID originId;
}

