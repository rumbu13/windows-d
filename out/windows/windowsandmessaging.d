module windows.windowsandmessaging;

public import windows.core;
public import windows.com : HRESULT, IUnknown;
public import windows.controls : HPROPSHEETPAGE, NMHDR;
public import windows.displaydevices : POINT, RECT, SIZE;
public import windows.gdi : BLENDFUNCTION, HBRUSH, HCURSOR, HDC, HICON;
public import windows.kernel : LUID;
public import windows.menusandresources : HMENU, MSGBOXCALLBACK, WNDENUMPROC, WNDPROC;
public import windows.shell : LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, HANDLE, HINSTANCE, LRESULT;
public import windows.windowsstationsanddesktops : HDESK;
public import windows.xps : DEVMODEA;

extern(Windows):


// Callbacks

alias LPOFNHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCCHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPFRHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPCFHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPRINTHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPSETUPHOOKPROC = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGEPAINTHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGESETUPHOOK = size_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias DLGPROC = ptrdiff_t function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias TIMERPROC = void function(HWND param0, uint param1, size_t param2, uint param3);
alias HOOKPROC = LRESULT function(int code, WPARAM wParam, LPARAM lParam);
alias SENDASYNCPROC = void function(HWND param0, uint param1, size_t param2, LRESULT param3);
alias PROPENUMPROCA = BOOL function(HWND param0, const(char)* param1, HANDLE param2);
alias PROPENUMPROCW = BOOL function(HWND param0, const(wchar)* param1, HANDLE param2);
alias PROPENUMPROCEXA = BOOL function(HWND param0, const(char)* param1, HANDLE param2, size_t param3);
alias PROPENUMPROCEXW = BOOL function(HWND param0, const(wchar)* param1, HANDLE param2, size_t param3);

// Structs


struct OPENFILENAME_NT4A
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(char)*  lpstrFilter;
    const(char)*  lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    const(char)*  lpstrFile;
    uint          nMaxFile;
    const(char)*  lpstrFileTitle;
    uint          nMaxFileTitle;
    const(char)*  lpstrInitialDir;
    const(char)*  lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(char)*  lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(char)*  lpTemplateName;
}

struct OPENFILENAME_NT4W
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(wchar)* lpstrFilter;
    const(wchar)* lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    const(wchar)* lpstrFile;
    uint          nMaxFile;
    const(wchar)* lpstrFileTitle;
    uint          nMaxFileTitle;
    const(wchar)* lpstrInitialDir;
    const(wchar)* lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(wchar)* lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
}

struct OPENFILENAMEA
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(char)*  lpstrFilter;
    const(char)*  lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    const(char)*  lpstrFile;
    uint          nMaxFile;
    const(char)*  lpstrFileTitle;
    uint          nMaxFileTitle;
    const(char)*  lpstrInitialDir;
    const(char)*  lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(char)*  lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(char)*  lpTemplateName;
    void*         pvReserved;
    uint          dwReserved;
    uint          FlagsEx;
}

struct OPENFILENAMEW
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    const(wchar)* lpstrFilter;
    const(wchar)* lpstrCustomFilter;
    uint          nMaxCustFilter;
    uint          nFilterIndex;
    const(wchar)* lpstrFile;
    uint          nMaxFile;
    const(wchar)* lpstrFileTitle;
    uint          nMaxFileTitle;
    const(wchar)* lpstrInitialDir;
    const(wchar)* lpstrTitle;
    uint          Flags;
    ushort        nFileOffset;
    ushort        nFileExtension;
    const(wchar)* lpstrDefExt;
    LPARAM        lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
    void*         pvReserved;
    uint          dwReserved;
    uint          FlagsEx;
}

struct OFNOTIFYA
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    const(char)*   pszFile;
}

struct OFNOTIFYW
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    const(wchar)*  pszFile;
}

struct OFNOTIFYEXA
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEA* lpOFN;
    void*          psf;
    void*          pidl;
}

struct OFNOTIFYEXW
{
align (1):
    NMHDR          hdr;
    OPENFILENAMEW* lpOFN;
    void*          psf;
    void*          pidl;
}

struct CHOOSECOLORA
{
align (1):
    uint         lStructSize;
    HWND         hwndOwner;
    HWND         hInstance;
    uint         rgbResult;
    uint*        lpCustColors;
    uint         Flags;
    LPARAM       lCustData;
    LPCCHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
}

struct CHOOSECOLORW
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HWND          hInstance;
    uint          rgbResult;
    uint*         lpCustColors;
    uint          Flags;
    LPARAM        lCustData;
    LPCCHOOKPROC  lpfnHook;
    const(wchar)* lpTemplateName;
}

struct FINDREPLACEA
{
align (1):
    uint         lStructSize;
    HWND         hwndOwner;
    HINSTANCE    hInstance;
    uint         Flags;
    const(char)* lpstrFindWhat;
    const(char)* lpstrReplaceWith;
    ushort       wFindWhatLen;
    ushort       wReplaceWithLen;
    LPARAM       lCustData;
    LPFRHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
}

struct FINDREPLACEW
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HINSTANCE     hInstance;
    uint          Flags;
    const(wchar)* lpstrFindWhat;
    const(wchar)* lpstrReplaceWith;
    ushort        wFindWhatLen;
    ushort        wReplaceWithLen;
    LPARAM        lCustData;
    LPFRHOOKPROC  lpfnHook;
    const(wchar)* lpTemplateName;
}

struct CHOOSEFONTA
{
align (1):
    uint         lStructSize;
    HWND         hwndOwner;
    HDC          hDC;
    LOGFONTA*    lpLogFont;
    int          iPointSize;
    uint         Flags;
    uint         rgbColors;
    LPARAM       lCustData;
    LPCFHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
    HINSTANCE    hInstance;
    const(char)* lpszStyle;
    ushort       nFontType;
    ushort       ___MISSING_ALIGNMENT__;
    int          nSizeMin;
    int          nSizeMax;
}

struct CHOOSEFONTW
{
align (1):
    uint          lStructSize;
    HWND          hwndOwner;
    HDC           hDC;
    LOGFONTW*     lpLogFont;
    int           iPointSize;
    uint          Flags;
    uint          rgbColors;
    LPARAM        lCustData;
    LPCFHOOKPROC  lpfnHook;
    const(wchar)* lpTemplateName;
    HINSTANCE     hInstance;
    const(wchar)* lpszStyle;
    ushort        nFontType;
    ushort        ___MISSING_ALIGNMENT__;
    int           nSizeMin;
    int           nSizeMax;
}

struct PRINTDLGA
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    HDC             hDC;
    uint            Flags;
    ushort          nFromPage;
    ushort          nToPage;
    ushort          nMinPage;
    ushort          nMaxPage;
    ushort          nCopies;
    HINSTANCE       hInstance;
    LPARAM          lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    const(char)*    lpPrintTemplateName;
    const(char)*    lpSetupTemplateName;
    ptrdiff_t       hPrintTemplate;
    ptrdiff_t       hSetupTemplate;
}

struct PRINTDLGW
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    HDC             hDC;
    uint            Flags;
    ushort          nFromPage;
    ushort          nToPage;
    ushort          nMinPage;
    ushort          nMaxPage;
    ushort          nCopies;
    HINSTANCE       hInstance;
    LPARAM          lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    const(wchar)*   lpPrintTemplateName;
    const(wchar)*   lpSetupTemplateName;
    ptrdiff_t       hPrintTemplate;
    ptrdiff_t       hSetupTemplate;
}

struct PRINTPAGERANGE
{
align (1):
    uint nFromPage;
    uint nToPage;
}

struct PRINTDLGEXA
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    HDC             hDC;
    uint            Flags;
    uint            Flags2;
    uint            ExclusionFlags;
    uint            nPageRanges;
    uint            nMaxPageRanges;
    PRINTPAGERANGE* lpPageRanges;
    uint            nMinPage;
    uint            nMaxPage;
    uint            nCopies;
    HINSTANCE       hInstance;
    const(char)*    lpPrintTemplateName;
    IUnknown        lpCallback;
    uint            nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    uint            nStartPage;
    uint            dwResultAction;
}

struct PRINTDLGEXW
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    HDC             hDC;
    uint            Flags;
    uint            Flags2;
    uint            ExclusionFlags;
    uint            nPageRanges;
    uint            nMaxPageRanges;
    PRINTPAGERANGE* lpPageRanges;
    uint            nMinPage;
    uint            nMaxPage;
    uint            nCopies;
    HINSTANCE       hInstance;
    const(wchar)*   lpPrintTemplateName;
    IUnknown        lpCallback;
    uint            nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    uint            nStartPage;
    uint            dwResultAction;
}

struct DEVNAMES
{
align (1):
    ushort wDriverOffset;
    ushort wDeviceOffset;
    ushort wOutputOffset;
    ushort wDefault;
}

struct PAGESETUPDLGA
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    uint            Flags;
    POINT           ptPaperSize;
    RECT            rtMinMargin;
    RECT            rtMargin;
    HINSTANCE       hInstance;
    LPARAM          lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    const(char)*    lpPageSetupTemplateName;
    ptrdiff_t       hPageSetupTemplate;
}

struct PAGESETUPDLGW
{
align (1):
    uint            lStructSize;
    HWND            hwndOwner;
    ptrdiff_t       hDevMode;
    ptrdiff_t       hDevNames;
    uint            Flags;
    POINT           ptPaperSize;
    RECT            rtMinMargin;
    RECT            rtMargin;
    HINSTANCE       hInstance;
    LPARAM          lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    const(wchar)*   lpPageSetupTemplateName;
    ptrdiff_t       hPageSetupTemplate;
}

alias HWND = ptrdiff_t;

alias LPARAM = ptrdiff_t;

alias WPARAM = size_t;

struct CBT_CREATEWNDA
{
    CREATESTRUCTA* lpcs;
    HWND           hwndInsertAfter;
}

struct CBT_CREATEWNDW
{
    CREATESTRUCTW* lpcs;
    HWND           hwndInsertAfter;
}

struct CBTACTIVATESTRUCT
{
    BOOL fMouse;
    HWND hWndActive;
}

struct EVENTMSG
{
    uint message;
    uint paramL;
    uint paramH;
    uint time;
    HWND hwnd;
}

struct CWPSTRUCT
{
    LPARAM lParam;
    WPARAM wParam;
    uint   message;
    HWND   hwnd;
}

struct CWPRETSTRUCT
{
    LRESULT lResult;
    LPARAM  lParam;
    WPARAM  wParam;
    uint    message;
    HWND    hwnd;
}

struct KBDLLHOOKSTRUCT
{
    uint   vkCode;
    uint   scanCode;
    uint   flags;
    uint   time;
    size_t dwExtraInfo;
}

struct MSLLHOOKSTRUCT
{
    POINT  pt;
    uint   mouseData;
    uint   flags;
    uint   time;
    size_t dwExtraInfo;
}

struct DEBUGHOOKINFO
{
    uint   idThread;
    uint   idThreadInstaller;
    LPARAM lParam;
    WPARAM wParam;
    int    code;
}

struct MOUSEHOOKSTRUCT
{
    POINT  pt;
    HWND   hwnd;
    uint   wHitTestCode;
    size_t dwExtraInfo;
}

struct MOUSEHOOKSTRUCTEX
{
    MOUSEHOOKSTRUCT __AnonymousBase_winuser_L1173_C46;
    uint            mouseData;
}

struct WNDCLASSEXA
{
    uint         cbSize;
    uint         style;
    WNDPROC      lpfnWndProc;
    int          cbClsExtra;
    int          cbWndExtra;
    HINSTANCE    hInstance;
    HICON        hIcon;
    HCURSOR      hCursor;
    HBRUSH       hbrBackground;
    const(char)* lpszMenuName;
    const(char)* lpszClassName;
    HICON        hIconSm;
}

struct WNDCLASSEXW
{
    uint          cbSize;
    uint          style;
    WNDPROC       lpfnWndProc;
    int           cbClsExtra;
    int           cbWndExtra;
    HINSTANCE     hInstance;
    HICON         hIcon;
    HCURSOR       hCursor;
    HBRUSH        hbrBackground;
    const(wchar)* lpszMenuName;
    const(wchar)* lpszClassName;
    HICON         hIconSm;
}

struct WNDCLASSA
{
    uint         style;
    WNDPROC      lpfnWndProc;
    int          cbClsExtra;
    int          cbWndExtra;
    HINSTANCE    hInstance;
    HICON        hIcon;
    HCURSOR      hCursor;
    HBRUSH       hbrBackground;
    const(char)* lpszMenuName;
    const(char)* lpszClassName;
}

struct WNDCLASSW
{
    uint          style;
    WNDPROC       lpfnWndProc;
    int           cbClsExtra;
    int           cbWndExtra;
    HINSTANCE     hInstance;
    HICON         hIcon;
    HCURSOR       hCursor;
    HBRUSH        hbrBackground;
    const(wchar)* lpszMenuName;
    const(wchar)* lpszClassName;
}

struct MSG
{
    HWND   hwnd;
    uint   message;
    WPARAM wParam;
    LPARAM lParam;
    uint   time;
    POINT  pt;
}

struct MINMAXINFO
{
    POINT ptReserved;
    POINT ptMaxSize;
    POINT ptMaxPosition;
    POINT ptMinTrackSize;
    POINT ptMaxTrackSize;
}

struct WINDOWPOS
{
    HWND hwnd;
    HWND hwndInsertAfter;
    int  x;
    int  y;
    int  cx;
    int  cy;
    uint flags;
}

struct NCCALCSIZE_PARAMS
{
    RECT[3]    rgrc;
    WINDOWPOS* lppos;
}

struct CREATESTRUCTA
{
    void*        lpCreateParams;
    HINSTANCE    hInstance;
    HMENU        hMenu;
    HWND         hwndParent;
    int          cy;
    int          cx;
    int          y;
    int          x;
    int          style;
    const(char)* lpszName;
    const(char)* lpszClass;
    uint         dwExStyle;
}

struct CREATESTRUCTW
{
    void*         lpCreateParams;
    HINSTANCE     hInstance;
    HMENU         hMenu;
    HWND          hwndParent;
    int           cy;
    int           cx;
    int           y;
    int           x;
    int           style;
    const(wchar)* lpszName;
    const(wchar)* lpszClass;
    uint          dwExStyle;
}

struct WINDOWPLACEMENT
{
    uint  length;
    uint  flags;
    uint  showCmd;
    POINT ptMinPosition;
    POINT ptMaxPosition;
    RECT  rcNormalPosition;
}

struct STYLESTRUCT
{
    uint styleOld;
    uint styleNew;
}

struct BSMINFO
{
    uint  cbSize;
    HDESK hdesk;
    HWND  hwnd;
    LUID  luid;
}

struct UPDATELAYEREDWINDOWINFO
{
    uint          cbSize;
    HDC           hdcDst;
    const(POINT)* pptDst;
    const(SIZE)*  psize;
    HDC           hdcSrc;
    const(POINT)* pptSrc;
    uint          crKey;
    const(BLENDFUNCTION)* pblend;
    uint          dwFlags;
    const(RECT)*  prcDirty;
}

struct DLGTEMPLATE
{
align (2):
    uint   style;
    uint   dwExtendedStyle;
    ushort cdit;
    short  x;
    short  y;
    short  cx;
    short  cy;
}

struct DLGITEMTEMPLATE
{
align (2):
    uint   style;
    uint   dwExtendedStyle;
    short  x;
    short  y;
    short  cx;
    short  cy;
    ushort id;
}

struct MSGBOXPARAMSA
{
    uint           cbSize;
    HWND           hwndOwner;
    HINSTANCE      hInstance;
    const(char)*   lpszText;
    const(char)*   lpszCaption;
    uint           dwStyle;
    const(char)*   lpszIcon;
    size_t         dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    uint           dwLanguageId;
}

struct MSGBOXPARAMSW
{
    uint           cbSize;
    HWND           hwndOwner;
    HINSTANCE      hInstance;
    const(wchar)*  lpszText;
    const(wchar)*  lpszCaption;
    uint           dwStyle;
    const(wchar)*  lpszIcon;
    size_t         dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    uint           dwLanguageId;
}

struct MDICREATESTRUCTA
{
    const(char)* szClass;
    const(char)* szTitle;
    HANDLE       hOwner;
    int          x;
    int          y;
    int          cx;
    int          cy;
    uint         style;
    LPARAM       lParam;
}

struct MDICREATESTRUCTW
{
    const(wchar)* szClass;
    const(wchar)* szTitle;
    HANDLE        hOwner;
    int           x;
    int           y;
    int           cx;
    int           cy;
    uint          style;
    LPARAM        lParam;
}

struct CLIENTCREATESTRUCT
{
    HANDLE hWindowMenu;
    uint   idFirstChild;
}

struct NONCLIENTMETRICSA
{
    uint     cbSize;
    int      iBorderWidth;
    int      iScrollWidth;
    int      iScrollHeight;
    int      iCaptionWidth;
    int      iCaptionHeight;
    LOGFONTA lfCaptionFont;
    int      iSmCaptionWidth;
    int      iSmCaptionHeight;
    LOGFONTA lfSmCaptionFont;
    int      iMenuWidth;
    int      iMenuHeight;
    LOGFONTA lfMenuFont;
    LOGFONTA lfStatusFont;
    LOGFONTA lfMessageFont;
    int      iPaddedBorderWidth;
}

struct NONCLIENTMETRICSW
{
    uint     cbSize;
    int      iBorderWidth;
    int      iScrollWidth;
    int      iScrollHeight;
    int      iCaptionWidth;
    int      iCaptionHeight;
    LOGFONTW lfCaptionFont;
    int      iSmCaptionWidth;
    int      iSmCaptionHeight;
    LOGFONTW lfSmCaptionFont;
    int      iMenuWidth;
    int      iMenuHeight;
    LOGFONTW lfMenuFont;
    LOGFONTW lfStatusFont;
    LOGFONTW lfMessageFont;
    int      iPaddedBorderWidth;
}

struct MINIMIZEDMETRICS
{
    uint cbSize;
    int  iWidth;
    int  iHorzGap;
    int  iVertGap;
    int  iArrange;
}

struct ANIMATIONINFO
{
    uint cbSize;
    int  iMinAnimate;
}

struct AUDIODESCRIPTION
{
    uint cbSize;
    BOOL Enabled;
    uint Locale;
}

struct GUITHREADINFO
{
    uint cbSize;
    uint flags;
    HWND hwndActive;
    HWND hwndFocus;
    HWND hwndCapture;
    HWND hwndMenuOwner;
    HWND hwndMoveSize;
    HWND hwndCaret;
    RECT rcCaret;
}

struct WINDOWINFO
{
    uint   cbSize;
    RECT   rcWindow;
    RECT   rcClient;
    uint   dwStyle;
    uint   dwExStyle;
    uint   dwWindowStatus;
    uint   cxWindowBorders;
    uint   cyWindowBorders;
    ushort atomWindowType;
    ushort wCreatorVersion;
}

struct TITLEBARINFO
{
    uint    cbSize;
    RECT    rcTitleBar;
    uint[6] rgstate;
}

struct TITLEBARINFOEX
{
    uint    cbSize;
    RECT    rcTitleBar;
    uint[6] rgstate;
    RECT[6] rgrect;
}

struct ALTTABINFO
{
    uint  cbSize;
    int   cItems;
    int   cColumns;
    int   cRows;
    int   iColFocus;
    int   iRowFocus;
    int   cxItem;
    int   cyItem;
    POINT ptStart;
}

struct CHANGEFILTERSTRUCT
{
    uint cbSize;
    uint ExtStatus;
}

// Functions

@DllImport("COMDLG32")
BOOL GetOpenFileNameA(OPENFILENAMEA* param0);

@DllImport("COMDLG32")
BOOL GetOpenFileNameW(OPENFILENAMEW* param0);

@DllImport("COMDLG32")
BOOL GetSaveFileNameA(OPENFILENAMEA* param0);

@DllImport("COMDLG32")
BOOL GetSaveFileNameW(OPENFILENAMEW* param0);

@DllImport("COMDLG32")
short GetFileTitleA(const(char)* param0, const(char)* Buf, ushort cchSize);

@DllImport("COMDLG32")
short GetFileTitleW(const(wchar)* param0, const(wchar)* Buf, ushort cchSize);

@DllImport("COMDLG32")
BOOL ChooseColorA(CHOOSECOLORA* param0);

@DllImport("COMDLG32")
BOOL ChooseColorW(CHOOSECOLORW* param0);

@DllImport("COMDLG32")
HWND FindTextA(FINDREPLACEA* param0);

@DllImport("COMDLG32")
HWND FindTextW(FINDREPLACEW* param0);

@DllImport("COMDLG32")
HWND ReplaceTextA(FINDREPLACEA* param0);

@DllImport("COMDLG32")
HWND ReplaceTextW(FINDREPLACEW* param0);

@DllImport("COMDLG32")
BOOL ChooseFontA(CHOOSEFONTA* param0);

@DllImport("COMDLG32")
BOOL ChooseFontW(CHOOSEFONTW* param0);

@DllImport("COMDLG32")
BOOL PrintDlgA(PRINTDLGA* pPD);

@DllImport("COMDLG32")
BOOL PrintDlgW(PRINTDLGW* pPD);

@DllImport("COMDLG32")
HRESULT PrintDlgExA(PRINTDLGEXA* pPD);

@DllImport("COMDLG32")
HRESULT PrintDlgExW(PRINTDLGEXW* pPD);

@DllImport("COMDLG32")
uint CommDlgExtendedError();

@DllImport("COMDLG32")
BOOL PageSetupDlgA(PAGESETUPDLGA* param0);

@DllImport("COMDLG32")
BOOL PageSetupDlgW(PAGESETUPDLGW* param0);

@DllImport("USER32")
BOOL IsHungAppWindow(HWND hwnd);

@DllImport("USER32")
uint RegisterWindowMessageA(const(char)* lpString);

@DllImport("USER32")
uint RegisterWindowMessageW(const(wchar)* lpString);

@DllImport("USER32")
BOOL GetMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

@DllImport("USER32")
BOOL GetMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

@DllImport("USER32")
BOOL TranslateMessage(const(MSG)* lpMsg);

@DllImport("USER32")
LRESULT DispatchMessageA(const(MSG)* lpMsg);

@DllImport("USER32")
LRESULT DispatchMessageW(const(MSG)* lpMsg);

@DllImport("USER32")
BOOL PeekMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

@DllImport("USER32")
BOOL PeekMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

@DllImport("USER32")
uint GetMessagePos();

@DllImport("USER32")
int GetMessageTime();

@DllImport("USER32")
LPARAM GetMessageExtraInfo();

@DllImport("USER32")
LPARAM SetMessageExtraInfo(LPARAM lParam);

@DllImport("USER32")
LRESULT SendMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT SendMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT SendMessageTimeoutA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, 
                            size_t* lpdwResult);

@DllImport("USER32")
LRESULT SendMessageTimeoutW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, 
                            size_t* lpdwResult);

@DllImport("USER32")
BOOL SendNotifyMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL SendNotifyMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL SendMessageCallbackA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, 
                          size_t dwData);

@DllImport("USER32")
BOOL SendMessageCallbackW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, 
                          size_t dwData);

@DllImport("USER32")
int BroadcastSystemMessageExA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

@DllImport("USER32")
int BroadcastSystemMessageExW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

@DllImport("USER32")
int BroadcastSystemMessageW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL PostMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL PostMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL PostThreadMessageA(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL PostThreadMessageW(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL ReplyMessage(LRESULT lResult);

@DllImport("USER32")
BOOL WaitMessage();

@DllImport("USER32")
LRESULT DefWindowProcA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT DefWindowProcW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
void PostQuitMessage(int nExitCode);

@DllImport("USER32")
LRESULT CallWindowProcA(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT CallWindowProcW(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL InSendMessage();

@DllImport("USER32")
uint InSendMessageEx(void* lpReserved);

@DllImport("USER32")
ushort RegisterClassA(const(WNDCLASSA)* lpWndClass);

@DllImport("USER32")
ushort RegisterClassW(const(WNDCLASSW)* lpWndClass);

@DllImport("USER32")
BOOL UnregisterClassA(const(char)* lpClassName, HINSTANCE hInstance);

@DllImport("USER32")
BOOL UnregisterClassW(const(wchar)* lpClassName, HINSTANCE hInstance);

@DllImport("USER32")
BOOL GetClassInfoA(HINSTANCE hInstance, const(char)* lpClassName, WNDCLASSA* lpWndClass);

@DllImport("USER32")
BOOL GetClassInfoW(HINSTANCE hInstance, const(wchar)* lpClassName, WNDCLASSW* lpWndClass);

@DllImport("USER32")
ushort RegisterClassExA(const(WNDCLASSEXA)* param0);

@DllImport("USER32")
ushort RegisterClassExW(const(WNDCLASSEXW)* param0);

@DllImport("USER32")
BOOL GetClassInfoExA(HINSTANCE hInstance, const(char)* lpszClass, WNDCLASSEXA* lpwcx);

@DllImport("USER32")
BOOL GetClassInfoExW(HINSTANCE hInstance, const(wchar)* lpszClass, WNDCLASSEXW* lpwcx);

@DllImport("USER32")
HWND CreateWindowExA(uint dwExStyle, const(char)* lpClassName, const(char)* lpWindowName, uint dwStyle, int X, 
                     int Y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, 
                     void* lpParam);

@DllImport("USER32")
HWND CreateWindowExW(uint dwExStyle, const(wchar)* lpClassName, const(wchar)* lpWindowName, uint dwStyle, int X, 
                     int Y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, 
                     void* lpParam);

@DllImport("USER32")
BOOL IsWindow(HWND hWnd);

@DllImport("USER32")
BOOL IsChild(HWND hWndParent, HWND hWnd);

@DllImport("USER32")
BOOL DestroyWindow(HWND hWnd);

@DllImport("USER32")
BOOL ShowWindow(HWND hWnd, int nCmdShow);

@DllImport("USER32")
BOOL AnimateWindow(HWND hWnd, uint dwTime, uint dwFlags);

@DllImport("USER32")
BOOL UpdateLayeredWindow(HWND hWnd, HDC hdcDst, POINT* pptDst, SIZE* psize, HDC hdcSrc, POINT* pptSrc, uint crKey, 
                         BLENDFUNCTION* pblend, uint dwFlags);

@DllImport("USER32")
BOOL GetLayeredWindowAttributes(HWND hwnd, uint* pcrKey, ubyte* pbAlpha, uint* pdwFlags);

@DllImport("USER32")
BOOL SetLayeredWindowAttributes(HWND hwnd, uint crKey, ubyte bAlpha, uint dwFlags);

@DllImport("USER32")
BOOL ShowWindowAsync(HWND hWnd, int nCmdShow);

@DllImport("USER32")
BOOL ShowOwnedPopups(HWND hWnd, BOOL fShow);

@DllImport("USER32")
BOOL OpenIcon(HWND hWnd);

@DllImport("USER32")
BOOL CloseWindow(HWND hWnd);

@DllImport("USER32")
BOOL MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);

@DllImport("USER32")
BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

@DllImport("USER32")
BOOL GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT* lpwndpl);

@DllImport("USER32")
BOOL SetWindowPlacement(HWND hWnd, const(WINDOWPLACEMENT)* lpwndpl);

@DllImport("USER32")
BOOL GetWindowDisplayAffinity(HWND hWnd, uint* pdwAffinity);

@DllImport("USER32")
BOOL SetWindowDisplayAffinity(HWND hWnd, uint dwAffinity);

@DllImport("USER32")
ptrdiff_t BeginDeferWindowPos(int nNumWindows);

@DllImport("USER32")
ptrdiff_t DeferWindowPos(ptrdiff_t hWinPosInfo, HWND hWnd, HWND hWndInsertAfter, int x, int y, int cx, int cy, 
                         uint uFlags);

@DllImport("USER32")
BOOL EndDeferWindowPos(ptrdiff_t hWinPosInfo);

@DllImport("USER32")
BOOL IsWindowVisible(HWND hWnd);

@DllImport("USER32")
BOOL IsIconic(HWND hWnd);

@DllImport("USER32")
BOOL AnyPopup();

@DllImport("USER32")
BOOL BringWindowToTop(HWND hWnd);

@DllImport("USER32")
BOOL IsZoomed(HWND hWnd);

@DllImport("USER32")
HWND CreateDialogParamA(HINSTANCE hInstance, const(char)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                        LPARAM dwInitParam);

@DllImport("USER32")
HWND CreateDialogParamW(HINSTANCE hInstance, const(wchar)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                        LPARAM dwInitParam);

@DllImport("USER32")
HWND CreateDialogIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, 
                                DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32")
HWND CreateDialogIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, 
                                DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32")
ptrdiff_t DialogBoxParamA(HINSTANCE hInstance, const(char)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                          LPARAM dwInitParam);

@DllImport("USER32")
ptrdiff_t DialogBoxParamW(HINSTANCE hInstance, const(wchar)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, 
                          LPARAM dwInitParam);

@DllImport("USER32")
ptrdiff_t DialogBoxIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, 
                                  DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32")
ptrdiff_t DialogBoxIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, 
                                  DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32")
BOOL EndDialog(HWND hDlg, ptrdiff_t nResult);

@DllImport("USER32")
HWND GetDlgItem(HWND hDlg, int nIDDlgItem);

@DllImport("USER32")
BOOL SetDlgItemInt(HWND hDlg, int nIDDlgItem, uint uValue, BOOL bSigned);

@DllImport("USER32")
uint GetDlgItemInt(HWND hDlg, int nIDDlgItem, int* lpTranslated, BOOL bSigned);

@DllImport("USER32")
BOOL SetDlgItemTextA(HWND hDlg, int nIDDlgItem, const(char)* lpString);

@DllImport("USER32")
BOOL SetDlgItemTextW(HWND hDlg, int nIDDlgItem, const(wchar)* lpString);

@DllImport("USER32")
uint GetDlgItemTextA(HWND hDlg, int nIDDlgItem, const(char)* lpString, int cchMax);

@DllImport("USER32")
uint GetDlgItemTextW(HWND hDlg, int nIDDlgItem, const(wchar)* lpString, int cchMax);

@DllImport("USER32")
LRESULT SendDlgItemMessageA(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT SendDlgItemMessageW(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
HWND GetNextDlgGroupItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

@DllImport("USER32")
HWND GetNextDlgTabItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

@DllImport("USER32")
int GetDlgCtrlID(HWND hWnd);

@DllImport("USER32")
int GetDialogBaseUnits();

@DllImport("USER32")
LRESULT DefDlgProcW(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL CallMsgFilterA(MSG* lpMsg, int nCode);

@DllImport("USER32")
BOOL CallMsgFilterW(MSG* lpMsg, int nCode);

@DllImport("USER32")
BOOL GetInputState();

@DllImport("USER32")
uint GetQueueStatus(uint flags);

@DllImport("USER32")
size_t SetTimer(HWND hWnd, size_t nIDEvent, uint uElapse, TIMERPROC lpTimerFunc);

@DllImport("USER32")
size_t SetCoalescableTimer(HWND hWnd, size_t nIDEvent, uint uElapse, TIMERPROC lpTimerFunc, uint uToleranceDelay);

@DllImport("USER32")
BOOL KillTimer(HWND hWnd, size_t uIDEvent);

@DllImport("USER32")
BOOL IsWindowUnicode(HWND hWnd);

@DllImport("USER32")
int GetSystemMetrics(int nIndex);

@DllImport("USER32")
BOOL CalculatePopupWindowPosition(const(POINT)* anchorPoint, const(SIZE)* windowSize, uint flags, 
                                  RECT* excludeRect, RECT* popupWindowPosition);

@DllImport("USER32")
HWND GetForegroundWindow();

@DllImport("USER32")
void SwitchToThisWindow(HWND hwnd, BOOL fUnknown);

@DllImport("USER32")
BOOL SetForegroundWindow(HWND hWnd);

@DllImport("USER32")
BOOL AllowSetForegroundWindow(uint dwProcessId);

@DllImport("USER32")
BOOL LockSetForegroundWindow(uint uLockCode);

@DllImport("USER32")
BOOL SetPropA(HWND hWnd, const(char)* lpString, HANDLE hData);

@DllImport("USER32")
BOOL SetPropW(HWND hWnd, const(wchar)* lpString, HANDLE hData);

@DllImport("USER32")
HANDLE GetPropA(HWND hWnd, const(char)* lpString);

@DllImport("USER32")
HANDLE GetPropW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32")
HANDLE RemovePropA(HWND hWnd, const(char)* lpString);

@DllImport("USER32")
HANDLE RemovePropW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32")
int EnumPropsExA(HWND hWnd, PROPENUMPROCEXA lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
int EnumPropsExW(HWND hWnd, PROPENUMPROCEXW lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
int EnumPropsA(HWND hWnd, PROPENUMPROCA lpEnumFunc);

@DllImport("USER32")
int EnumPropsW(HWND hWnd, PROPENUMPROCW lpEnumFunc);

@DllImport("USER32")
BOOL SetWindowTextA(HWND hWnd, const(char)* lpString);

@DllImport("USER32")
BOOL SetWindowTextW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32")
int GetWindowTextA(HWND hWnd, const(char)* lpString, int nMaxCount);

@DllImport("USER32")
int GetWindowTextW(HWND hWnd, const(wchar)* lpString, int nMaxCount);

@DllImport("USER32")
int GetWindowTextLengthA(HWND hWnd);

@DllImport("USER32")
int GetWindowTextLengthW(HWND hWnd);

@DllImport("USER32")
BOOL GetClientRect(HWND hWnd, RECT* lpRect);

@DllImport("USER32")
BOOL GetWindowRect(HWND hWnd, RECT* lpRect);

@DllImport("USER32")
BOOL AdjustWindowRect(RECT* lpRect, uint dwStyle, BOOL bMenu);

@DllImport("USER32")
BOOL AdjustWindowRectEx(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle);

@DllImport("USER32")
int MessageBoxA(HWND hWnd, const(char)* lpText, const(char)* lpCaption, uint uType);

@DllImport("USER32")
int MessageBoxW(HWND hWnd, const(wchar)* lpText, const(wchar)* lpCaption, uint uType);

@DllImport("USER32")
int MessageBoxExA(HWND hWnd, const(char)* lpText, const(char)* lpCaption, uint uType, ushort wLanguageId);

@DllImport("USER32")
int MessageBoxExW(HWND hWnd, const(wchar)* lpText, const(wchar)* lpCaption, uint uType, ushort wLanguageId);

@DllImport("USER32")
int MessageBoxIndirectA(const(MSGBOXPARAMSA)* lpmbp);

@DllImport("USER32")
int MessageBoxIndirectW(const(MSGBOXPARAMSW)* lpmbp);

@DllImport("USER32")
BOOL LogicalToPhysicalPoint(HWND hWnd, POINT* lpPoint);

@DllImport("USER32")
BOOL PhysicalToLogicalPoint(HWND hWnd, POINT* lpPoint);

@DllImport("USER32")
HWND WindowFromPoint(POINT Point);

@DllImport("USER32")
HWND WindowFromPhysicalPoint(POINT Point);

@DllImport("USER32")
HWND ChildWindowFromPoint(HWND hWndParent, POINT Point);

@DllImport("USER32")
HWND ChildWindowFromPointEx(HWND hwnd, POINT pt, uint flags);

@DllImport("USER32")
uint GetSysColor(int nIndex);

@DllImport("USER32")
BOOL SetSysColors(int cElements, char* lpaElements, char* lpaRgbValues);

@DllImport("USER32")
int GetWindowLongA(HWND hWnd, int nIndex);

@DllImport("USER32")
int GetWindowLongW(HWND hWnd, int nIndex);

@DllImport("USER32")
int SetWindowLongA(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32")
int SetWindowLongW(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32")
ushort GetClassWord(HWND hWnd, int nIndex);

@DllImport("USER32")
ushort SetClassWord(HWND hWnd, int nIndex, ushort wNewWord);

@DllImport("USER32")
uint GetClassLongA(HWND hWnd, int nIndex);

@DllImport("USER32")
uint GetClassLongW(HWND hWnd, int nIndex);

@DllImport("USER32")
uint SetClassLongA(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32")
uint SetClassLongW(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32")
BOOL GetProcessDefaultLayout(uint* pdwDefaultLayout);

@DllImport("USER32")
BOOL SetProcessDefaultLayout(uint dwDefaultLayout);

@DllImport("USER32")
HWND GetDesktopWindow();

@DllImport("USER32")
HWND GetParent(HWND hWnd);

@DllImport("USER32")
HWND SetParent(HWND hWndChild, HWND hWndNewParent);

@DllImport("USER32")
BOOL EnumChildWindows(HWND hWndParent, WNDENUMPROC lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
HWND FindWindowA(const(char)* lpClassName, const(char)* lpWindowName);

@DllImport("USER32")
HWND FindWindowW(const(wchar)* lpClassName, const(wchar)* lpWindowName);

@DllImport("USER32")
HWND FindWindowExA(HWND hWndParent, HWND hWndChildAfter, const(char)* lpszClass, const(char)* lpszWindow);

@DllImport("USER32")
HWND FindWindowExW(HWND hWndParent, HWND hWndChildAfter, const(wchar)* lpszClass, const(wchar)* lpszWindow);

@DllImport("USER32")
HWND GetShellWindow();

@DllImport("USER32")
BOOL RegisterShellHookWindow(HWND hwnd);

@DllImport("USER32")
BOOL DeregisterShellHookWindow(HWND hwnd);

@DllImport("USER32")
BOOL EnumWindows(WNDENUMPROC lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
BOOL EnumThreadWindows(uint dwThreadId, WNDENUMPROC lpfn, LPARAM lParam);

@DllImport("USER32")
int GetClassNameA(HWND hWnd, const(char)* lpClassName, int nMaxCount);

@DllImport("USER32")
int GetClassNameW(HWND hWnd, const(wchar)* lpClassName, int nMaxCount);

@DllImport("USER32")
HWND GetTopWindow(HWND hWnd);

@DllImport("USER32")
uint GetWindowThreadProcessId(HWND hWnd, uint* lpdwProcessId);

@DllImport("USER32")
BOOL IsGUIThread(BOOL bConvert);

@DllImport("USER32")
HWND GetLastActivePopup(HWND hWnd);

@DllImport("USER32")
HWND GetWindow(HWND hWnd, uint uCmd);

@DllImport("USER32")
ptrdiff_t SetWindowsHookExA(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

@DllImport("USER32")
ptrdiff_t SetWindowsHookExW(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

@DllImport("USER32")
BOOL UnhookWindowsHookEx(ptrdiff_t hhk);

@DllImport("USER32")
LRESULT CallNextHookEx(ptrdiff_t hhk, int nCode, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL IsDialogMessageA(HWND hDlg, MSG* lpMsg);

@DllImport("USER32")
BOOL IsDialogMessageW(HWND hDlg, MSG* lpMsg);

@DllImport("USER32")
BOOL MapDialogRect(HWND hDlg, RECT* lpRect);

@DllImport("USER32")
LRESULT DefFrameProcA(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT DefFrameProcW(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT DefMDIChildProcA(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
LRESULT DefMDIChildProcW(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL TranslateMDISysAccel(HWND hWndClient, MSG* lpMsg);

@DllImport("USER32")
uint ArrangeIconicWindows(HWND hWnd);

@DllImport("USER32")
HWND CreateMDIWindowA(const(char)* lpClassName, const(char)* lpWindowName, uint dwStyle, int X, int Y, int nWidth, 
                      int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

@DllImport("USER32")
HWND CreateMDIWindowW(const(wchar)* lpClassName, const(wchar)* lpWindowName, uint dwStyle, int X, int Y, 
                      int nWidth, int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

@DllImport("USER32")
ushort TileWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, char* lpKids);

@DllImport("USER32")
ushort CascadeWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, char* lpKids);

@DllImport("USER32")
BOOL SystemParametersInfoA(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

@DllImport("USER32")
BOOL SystemParametersInfoW(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

@DllImport("USER32")
BOOL SoundSentry();

@DllImport("USER32")
int InternalGetWindowText(HWND hWnd, const(wchar)* pString, int cchMaxCount);

@DllImport("USER32")
BOOL GetGUIThreadInfo(uint idThread, GUITHREADINFO* pgui);

@DllImport("USER32")
BOOL SetProcessDPIAware();

@DllImport("USER32")
BOOL IsProcessDPIAware();

@DllImport("USER32")
uint GetWindowModuleFileNameA(HWND hwnd, const(char)* pszFileName, uint cchFileNameMax);

@DllImport("USER32")
uint GetWindowModuleFileNameW(HWND hwnd, const(wchar)* pszFileName, uint cchFileNameMax);

@DllImport("USER32")
BOOL GetWindowInfo(HWND hwnd, WINDOWINFO* pwi);

@DllImport("USER32")
BOOL GetTitleBarInfo(HWND hwnd, TITLEBARINFO* pti);

@DllImport("USER32")
HWND GetAncestor(HWND hwnd, uint gaFlags);

@DllImport("USER32")
HWND RealChildWindowFromPoint(HWND hwndParent, POINT ptParentClientCoords);

@DllImport("USER32")
uint RealGetWindowClassW(HWND hwnd, const(wchar)* ptszClassName, uint cchClassNameMax);

@DllImport("USER32")
BOOL GetAltTabInfoA(HWND hwnd, int iItem, ALTTABINFO* pati, const(char)* pszItemText, uint cchItemText);

@DllImport("USER32")
BOOL GetAltTabInfoW(HWND hwnd, int iItem, ALTTABINFO* pati, const(wchar)* pszItemText, uint cchItemText);

@DllImport("USER32")
BOOL ChangeWindowMessageFilter(uint message, uint dwFlag);

@DllImport("USER32")
BOOL ChangeWindowMessageFilterEx(HWND hwnd, uint message, uint action, CHANGEFILTERSTRUCT* pChangeFilterStruct);


// Interfaces

@GUID("5852A2C3-6530-11D1-B6A3-0000F8757BF9")
interface IPrintDialogCallback : IUnknown
{
    HRESULT InitDone();
    HRESULT SelectionChange();
    HRESULT HandleMessage(HWND hDlg, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pResult);
}

@GUID("509AAEDA-5639-11D1-B6A1-0000F8757BF9")
interface IPrintDialogServices : IUnknown
{
    HRESULT GetCurrentDevMode(DEVMODEA* pDevMode, uint* pcbSize);
    HRESULT GetCurrentPrinterName(const(wchar)* pPrinterName, uint* pcchSize);
    HRESULT GetCurrentPortName(const(wchar)* pPortName, uint* pcchSize);
}


// GUIDs


const GUID IID_IPrintDialogCallback = GUIDOF!IPrintDialogCallback;
const GUID IID_IPrintDialogServices = GUIDOF!IPrintDialogServices;
