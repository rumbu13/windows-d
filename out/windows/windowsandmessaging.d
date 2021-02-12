module windows.windowsandmessaging;

public import windows.com;
public import windows.controls;
public import windows.displaydevices;
public import windows.gdi;
public import windows.kernel;
public import windows.menusandresources;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsstationsanddesktops;
public import windows.xps;

extern(Windows):

alias LPOFNHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct OPENFILENAME_NT4A
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(char)* lpstrFilter;
    const(char)* lpstrCustomFilter;
    uint nMaxCustFilter;
    uint nFilterIndex;
    const(char)* lpstrFile;
    uint nMaxFile;
    const(char)* lpstrFileTitle;
    uint nMaxFileTitle;
    const(char)* lpstrInitialDir;
    const(char)* lpstrTitle;
    uint Flags;
    ushort nFileOffset;
    ushort nFileExtension;
    const(char)* lpstrDefExt;
    LPARAM lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
}

struct OPENFILENAME_NT4W
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(wchar)* lpstrFilter;
    const(wchar)* lpstrCustomFilter;
    uint nMaxCustFilter;
    uint nFilterIndex;
    const(wchar)* lpstrFile;
    uint nMaxFile;
    const(wchar)* lpstrFileTitle;
    uint nMaxFileTitle;
    const(wchar)* lpstrInitialDir;
    const(wchar)* lpstrTitle;
    uint Flags;
    ushort nFileOffset;
    ushort nFileExtension;
    const(wchar)* lpstrDefExt;
    LPARAM lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
}

struct OPENFILENAMEA
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(char)* lpstrFilter;
    const(char)* lpstrCustomFilter;
    uint nMaxCustFilter;
    uint nFilterIndex;
    const(char)* lpstrFile;
    uint nMaxFile;
    const(char)* lpstrFileTitle;
    uint nMaxFileTitle;
    const(char)* lpstrInitialDir;
    const(char)* lpstrTitle;
    uint Flags;
    ushort nFileOffset;
    ushort nFileExtension;
    const(char)* lpstrDefExt;
    LPARAM lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
    void* pvReserved;
    uint dwReserved;
    uint FlagsEx;
}

struct OPENFILENAMEW
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(wchar)* lpstrFilter;
    const(wchar)* lpstrCustomFilter;
    uint nMaxCustFilter;
    uint nFilterIndex;
    const(wchar)* lpstrFile;
    uint nMaxFile;
    const(wchar)* lpstrFileTitle;
    uint nMaxFileTitle;
    const(wchar)* lpstrInitialDir;
    const(wchar)* lpstrTitle;
    uint Flags;
    ushort nFileOffset;
    ushort nFileExtension;
    const(wchar)* lpstrDefExt;
    LPARAM lCustData;
    LPOFNHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
    void* pvReserved;
    uint dwReserved;
    uint FlagsEx;
}

alias LPCCHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct OFNOTIFYA
{
    NMHDR hdr;
    OPENFILENAMEA* lpOFN;
    const(char)* pszFile;
}

struct OFNOTIFYW
{
    NMHDR hdr;
    OPENFILENAMEW* lpOFN;
    const(wchar)* pszFile;
}

struct OFNOTIFYEXA
{
    NMHDR hdr;
    OPENFILENAMEA* lpOFN;
    void* psf;
    void* pidl;
}

struct OFNOTIFYEXW
{
    NMHDR hdr;
    OPENFILENAMEW* lpOFN;
    void* psf;
    void* pidl;
}

struct CHOOSECOLORA
{
    uint lStructSize;
    HWND hwndOwner;
    HWND hInstance;
    uint rgbResult;
    uint* lpCustColors;
    uint Flags;
    LPARAM lCustData;
    LPCCHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
}

struct CHOOSECOLORW
{
    uint lStructSize;
    HWND hwndOwner;
    HWND hInstance;
    uint rgbResult;
    uint* lpCustColors;
    uint Flags;
    LPARAM lCustData;
    LPCCHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
}

alias LPFRHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct FINDREPLACEA
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    uint Flags;
    const(char)* lpstrFindWhat;
    const(char)* lpstrReplaceWith;
    ushort wFindWhatLen;
    ushort wReplaceWithLen;
    LPARAM lCustData;
    LPFRHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
}

struct FINDREPLACEW
{
    uint lStructSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    uint Flags;
    const(wchar)* lpstrFindWhat;
    const(wchar)* lpstrReplaceWith;
    ushort wFindWhatLen;
    ushort wReplaceWithLen;
    LPARAM lCustData;
    LPFRHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
}

alias LPCFHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct CHOOSEFONTA
{
    uint lStructSize;
    HWND hwndOwner;
    HDC hDC;
    LOGFONTA* lpLogFont;
    int iPointSize;
    uint Flags;
    uint rgbColors;
    LPARAM lCustData;
    LPCFHOOKPROC lpfnHook;
    const(char)* lpTemplateName;
    HINSTANCE hInstance;
    const(char)* lpszStyle;
    ushort nFontType;
    ushort ___MISSING_ALIGNMENT__;
    int nSizeMin;
    int nSizeMax;
}

struct CHOOSEFONTW
{
    uint lStructSize;
    HWND hwndOwner;
    HDC hDC;
    LOGFONTW* lpLogFont;
    int iPointSize;
    uint Flags;
    uint rgbColors;
    LPARAM lCustData;
    LPCFHOOKPROC lpfnHook;
    const(wchar)* lpTemplateName;
    HINSTANCE hInstance;
    const(wchar)* lpszStyle;
    ushort nFontType;
    ushort ___MISSING_ALIGNMENT__;
    int nSizeMin;
    int nSizeMax;
}

alias LPPRINTHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPSETUPHOOKPROC = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct PRINTDLGA
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    HDC hDC;
    uint Flags;
    ushort nFromPage;
    ushort nToPage;
    ushort nMinPage;
    ushort nMaxPage;
    ushort nCopies;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    const(char)* lpPrintTemplateName;
    const(char)* lpSetupTemplateName;
    int hPrintTemplate;
    int hSetupTemplate;
}

struct PRINTDLGW
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    HDC hDC;
    uint Flags;
    ushort nFromPage;
    ushort nToPage;
    ushort nMinPage;
    ushort nMaxPage;
    ushort nCopies;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPRINTHOOKPROC lpfnPrintHook;
    LPSETUPHOOKPROC lpfnSetupHook;
    const(wchar)* lpPrintTemplateName;
    const(wchar)* lpSetupTemplateName;
    int hPrintTemplate;
    int hSetupTemplate;
}

const GUID IID_IPrintDialogCallback = {0x5852A2C3, 0x6530, 0x11D1, [0xB6, 0xA3, 0x00, 0x00, 0xF8, 0x75, 0x7B, 0xF9]};
@GUID(0x5852A2C3, 0x6530, 0x11D1, [0xB6, 0xA3, 0x00, 0x00, 0xF8, 0x75, 0x7B, 0xF9]);
interface IPrintDialogCallback : IUnknown
{
    HRESULT InitDone();
    HRESULT SelectionChange();
    HRESULT HandleMessage(HWND hDlg, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pResult);
}

const GUID IID_IPrintDialogServices = {0x509AAEDA, 0x5639, 0x11D1, [0xB6, 0xA1, 0x00, 0x00, 0xF8, 0x75, 0x7B, 0xF9]};
@GUID(0x509AAEDA, 0x5639, 0x11D1, [0xB6, 0xA1, 0x00, 0x00, 0xF8, 0x75, 0x7B, 0xF9]);
interface IPrintDialogServices : IUnknown
{
    HRESULT GetCurrentDevMode(DEVMODEA* pDevMode, uint* pcbSize);
    HRESULT GetCurrentPrinterName(const(wchar)* pPrinterName, uint* pcchSize);
    HRESULT GetCurrentPortName(const(wchar)* pPortName, uint* pcchSize);
}

struct PRINTPAGERANGE
{
    uint nFromPage;
    uint nToPage;
}

struct PRINTDLGEXA
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    HDC hDC;
    uint Flags;
    uint Flags2;
    uint ExclusionFlags;
    uint nPageRanges;
    uint nMaxPageRanges;
    PRINTPAGERANGE* lpPageRanges;
    uint nMinPage;
    uint nMaxPage;
    uint nCopies;
    HINSTANCE hInstance;
    const(char)* lpPrintTemplateName;
    IUnknown lpCallback;
    uint nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    uint nStartPage;
    uint dwResultAction;
}

struct PRINTDLGEXW
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    HDC hDC;
    uint Flags;
    uint Flags2;
    uint ExclusionFlags;
    uint nPageRanges;
    uint nMaxPageRanges;
    PRINTPAGERANGE* lpPageRanges;
    uint nMinPage;
    uint nMaxPage;
    uint nCopies;
    HINSTANCE hInstance;
    const(wchar)* lpPrintTemplateName;
    IUnknown lpCallback;
    uint nPropertyPages;
    HPROPSHEETPAGE* lphPropertyPages;
    uint nStartPage;
    uint dwResultAction;
}

struct DEVNAMES
{
    ushort wDriverOffset;
    ushort wDeviceOffset;
    ushort wOutputOffset;
    ushort wDefault;
}

alias LPPAGEPAINTHOOK = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias LPPAGESETUPHOOK = extern(Windows) uint function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
struct PAGESETUPDLGA
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    uint Flags;
    POINT ptPaperSize;
    RECT rtMinMargin;
    RECT rtMargin;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    const(char)* lpPageSetupTemplateName;
    int hPageSetupTemplate;
}

struct PAGESETUPDLGW
{
    uint lStructSize;
    HWND hwndOwner;
    int hDevMode;
    int hDevNames;
    uint Flags;
    POINT ptPaperSize;
    RECT rtMinMargin;
    RECT rtMargin;
    HINSTANCE hInstance;
    LPARAM lCustData;
    LPPAGESETUPHOOK lpfnPageSetupHook;
    LPPAGEPAINTHOOK lpfnPagePaintHook;
    const(wchar)* lpPageSetupTemplateName;
    int hPageSetupTemplate;
}

@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameA(OPENFILENAMEA* param0);

@DllImport("COMDLG32.dll")
BOOL GetOpenFileNameW(OPENFILENAMEW* param0);

@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameA(OPENFILENAMEA* param0);

@DllImport("COMDLG32.dll")
BOOL GetSaveFileNameW(OPENFILENAMEW* param0);

@DllImport("COMDLG32.dll")
short GetFileTitleA(const(char)* param0, const(char)* Buf, ushort cchSize);

@DllImport("COMDLG32.dll")
short GetFileTitleW(const(wchar)* param0, const(wchar)* Buf, ushort cchSize);

@DllImport("COMDLG32.dll")
BOOL ChooseColorA(CHOOSECOLORA* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseColorW(CHOOSECOLORW* param0);

@DllImport("COMDLG32.dll")
HWND FindTextA(FINDREPLACEA* param0);

@DllImport("COMDLG32.dll")
HWND FindTextW(FINDREPLACEW* param0);

@DllImport("COMDLG32.dll")
HWND ReplaceTextA(FINDREPLACEA* param0);

@DllImport("COMDLG32.dll")
HWND ReplaceTextW(FINDREPLACEW* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseFontA(CHOOSEFONTA* param0);

@DllImport("COMDLG32.dll")
BOOL ChooseFontW(CHOOSEFONTW* param0);

@DllImport("COMDLG32.dll")
BOOL PrintDlgA(PRINTDLGA* pPD);

@DllImport("COMDLG32.dll")
BOOL PrintDlgW(PRINTDLGW* pPD);

@DllImport("COMDLG32.dll")
HRESULT PrintDlgExA(PRINTDLGEXA* pPD);

@DllImport("COMDLG32.dll")
HRESULT PrintDlgExW(PRINTDLGEXW* pPD);

@DllImport("COMDLG32.dll")
uint CommDlgExtendedError();

@DllImport("COMDLG32.dll")
BOOL PageSetupDlgA(PAGESETUPDLGA* param0);

@DllImport("COMDLG32.dll")
BOOL PageSetupDlgW(PAGESETUPDLGW* param0);

@DllImport("USER32.dll")
BOOL IsHungAppWindow(HWND hwnd);

@DllImport("USER32.dll")
uint RegisterWindowMessageA(const(char)* lpString);

@DllImport("USER32.dll")
uint RegisterWindowMessageW(const(wchar)* lpString);

@DllImport("USER32.dll")
BOOL GetMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

@DllImport("USER32.dll")
BOOL GetMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax);

@DllImport("USER32.dll")
BOOL TranslateMessage(const(MSG)* lpMsg);

@DllImport("USER32.dll")
LRESULT DispatchMessageA(const(MSG)* lpMsg);

@DllImport("USER32.dll")
LRESULT DispatchMessageW(const(MSG)* lpMsg);

@DllImport("USER32.dll")
BOOL PeekMessageA(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

@DllImport("USER32.dll")
BOOL PeekMessageW(MSG* lpMsg, HWND hWnd, uint wMsgFilterMin, uint wMsgFilterMax, uint wRemoveMsg);

@DllImport("USER32.dll")
uint GetMessagePos();

@DllImport("USER32.dll")
int GetMessageTime();

@DllImport("USER32.dll")
LPARAM GetMessageExtraInfo();

@DllImport("USER32.dll")
LPARAM SetMessageExtraInfo(LPARAM lParam);

@DllImport("USER32.dll")
LRESULT SendMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT SendMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT SendMessageTimeoutA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, uint* lpdwResult);

@DllImport("USER32.dll")
LRESULT SendMessageTimeoutW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, uint fuFlags, uint uTimeout, uint* lpdwResult);

@DllImport("USER32.dll")
BOOL SendNotifyMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL SendNotifyMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL SendMessageCallbackA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, uint dwData);

@DllImport("USER32.dll")
BOOL SendMessageCallbackW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, SENDASYNCPROC lpResultCallBack, uint dwData);

@DllImport("USER32.dll")
int BroadcastSystemMessageExA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

@DllImport("USER32.dll")
int BroadcastSystemMessageExW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam, BSMINFO* pbsmInfo);

@DllImport("USER32.dll")
int BroadcastSystemMessageW(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL PostMessageA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL PostMessageW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL PostThreadMessageA(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL PostThreadMessageW(uint idThread, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL ReplyMessage(LRESULT lResult);

@DllImport("USER32.dll")
BOOL WaitMessage();

@DllImport("USER32.dll")
LRESULT DefWindowProcA(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT DefWindowProcW(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
void PostQuitMessage(int nExitCode);

@DllImport("USER32.dll")
LRESULT CallWindowProcA(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT CallWindowProcW(WNDPROC lpPrevWndFunc, HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL InSendMessage();

@DllImport("USER32.dll")
uint InSendMessageEx(void* lpReserved);

@DllImport("USER32.dll")
ushort RegisterClassA(const(WNDCLASSA)* lpWndClass);

@DllImport("USER32.dll")
ushort RegisterClassW(const(WNDCLASSW)* lpWndClass);

@DllImport("USER32.dll")
BOOL UnregisterClassA(const(char)* lpClassName, HINSTANCE hInstance);

@DllImport("USER32.dll")
BOOL UnregisterClassW(const(wchar)* lpClassName, HINSTANCE hInstance);

@DllImport("USER32.dll")
BOOL GetClassInfoA(HINSTANCE hInstance, const(char)* lpClassName, WNDCLASSA* lpWndClass);

@DllImport("USER32.dll")
BOOL GetClassInfoW(HINSTANCE hInstance, const(wchar)* lpClassName, WNDCLASSW* lpWndClass);

@DllImport("USER32.dll")
ushort RegisterClassExA(const(WNDCLASSEXA)* param0);

@DllImport("USER32.dll")
ushort RegisterClassExW(const(WNDCLASSEXW)* param0);

@DllImport("USER32.dll")
BOOL GetClassInfoExA(HINSTANCE hInstance, const(char)* lpszClass, WNDCLASSEXA* lpwcx);

@DllImport("USER32.dll")
BOOL GetClassInfoExW(HINSTANCE hInstance, const(wchar)* lpszClass, WNDCLASSEXW* lpwcx);

@DllImport("USER32.dll")
HWND CreateWindowExA(uint dwExStyle, const(char)* lpClassName, const(char)* lpWindowName, uint dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, void* lpParam);

@DllImport("USER32.dll")
HWND CreateWindowExW(uint dwExStyle, const(wchar)* lpClassName, const(wchar)* lpWindowName, uint dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HMENU hMenu, HINSTANCE hInstance, void* lpParam);

@DllImport("USER32.dll")
BOOL IsWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL IsChild(HWND hWndParent, HWND hWnd);

@DllImport("USER32.dll")
BOOL DestroyWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL ShowWindow(HWND hWnd, int nCmdShow);

@DllImport("USER32.dll")
BOOL AnimateWindow(HWND hWnd, uint dwTime, uint dwFlags);

@DllImport("USER32.dll")
BOOL UpdateLayeredWindow(HWND hWnd, HDC hdcDst, POINT* pptDst, SIZE* psize, HDC hdcSrc, POINT* pptSrc, uint crKey, BLENDFUNCTION* pblend, uint dwFlags);

@DllImport("USER32.dll")
BOOL GetLayeredWindowAttributes(HWND hwnd, uint* pcrKey, ubyte* pbAlpha, uint* pdwFlags);

@DllImport("USER32.dll")
BOOL SetLayeredWindowAttributes(HWND hwnd, uint crKey, ubyte bAlpha, uint dwFlags);

@DllImport("USER32.dll")
BOOL ShowWindowAsync(HWND hWnd, int nCmdShow);

@DllImport("USER32.dll")
BOOL ShowOwnedPopups(HWND hWnd, BOOL fShow);

@DllImport("USER32.dll")
BOOL OpenIcon(HWND hWnd);

@DllImport("USER32.dll")
BOOL CloseWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL MoveWindow(HWND hWnd, int X, int Y, int nWidth, int nHeight, BOOL bRepaint);

@DllImport("USER32.dll")
BOOL SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);

@DllImport("USER32.dll")
BOOL GetWindowPlacement(HWND hWnd, WINDOWPLACEMENT* lpwndpl);

@DllImport("USER32.dll")
BOOL SetWindowPlacement(HWND hWnd, const(WINDOWPLACEMENT)* lpwndpl);

@DllImport("USER32.dll")
BOOL GetWindowDisplayAffinity(HWND hWnd, uint* pdwAffinity);

@DllImport("USER32.dll")
BOOL SetWindowDisplayAffinity(HWND hWnd, uint dwAffinity);

@DllImport("USER32.dll")
int BeginDeferWindowPos(int nNumWindows);

@DllImport("USER32.dll")
int DeferWindowPos(int hWinPosInfo, HWND hWnd, HWND hWndInsertAfter, int x, int y, int cx, int cy, uint uFlags);

@DllImport("USER32.dll")
BOOL EndDeferWindowPos(int hWinPosInfo);

@DllImport("USER32.dll")
BOOL IsWindowVisible(HWND hWnd);

@DllImport("USER32.dll")
BOOL IsIconic(HWND hWnd);

@DllImport("USER32.dll")
BOOL AnyPopup();

@DllImport("USER32.dll")
BOOL BringWindowToTop(HWND hWnd);

@DllImport("USER32.dll")
BOOL IsZoomed(HWND hWnd);

@DllImport("USER32.dll")
HWND CreateDialogParamA(HINSTANCE hInstance, const(char)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
HWND CreateDialogParamW(HINSTANCE hInstance, const(wchar)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
HWND CreateDialogIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
HWND CreateDialogIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* lpTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
int DialogBoxParamA(HINSTANCE hInstance, const(char)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
int DialogBoxParamW(HINSTANCE hInstance, const(wchar)* lpTemplateName, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
int DialogBoxIndirectParamA(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
int DialogBoxIndirectParamW(HINSTANCE hInstance, DLGTEMPLATE* hDialogTemplate, HWND hWndParent, DLGPROC lpDialogFunc, LPARAM dwInitParam);

@DllImport("USER32.dll")
BOOL EndDialog(HWND hDlg, int nResult);

@DllImport("USER32.dll")
HWND GetDlgItem(HWND hDlg, int nIDDlgItem);

@DllImport("USER32.dll")
BOOL SetDlgItemInt(HWND hDlg, int nIDDlgItem, uint uValue, BOOL bSigned);

@DllImport("USER32.dll")
uint GetDlgItemInt(HWND hDlg, int nIDDlgItem, int* lpTranslated, BOOL bSigned);

@DllImport("USER32.dll")
BOOL SetDlgItemTextA(HWND hDlg, int nIDDlgItem, const(char)* lpString);

@DllImport("USER32.dll")
BOOL SetDlgItemTextW(HWND hDlg, int nIDDlgItem, const(wchar)* lpString);

@DllImport("USER32.dll")
uint GetDlgItemTextA(HWND hDlg, int nIDDlgItem, const(char)* lpString, int cchMax);

@DllImport("USER32.dll")
uint GetDlgItemTextW(HWND hDlg, int nIDDlgItem, const(wchar)* lpString, int cchMax);

@DllImport("USER32.dll")
LRESULT SendDlgItemMessageA(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT SendDlgItemMessageW(HWND hDlg, int nIDDlgItem, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
HWND GetNextDlgGroupItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

@DllImport("USER32.dll")
HWND GetNextDlgTabItem(HWND hDlg, HWND hCtl, BOOL bPrevious);

@DllImport("USER32.dll")
int GetDlgCtrlID(HWND hWnd);

@DllImport("USER32.dll")
int GetDialogBaseUnits();

@DllImport("USER32.dll")
LRESULT DefDlgProcW(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL CallMsgFilterA(MSG* lpMsg, int nCode);

@DllImport("USER32.dll")
BOOL CallMsgFilterW(MSG* lpMsg, int nCode);

@DllImport("USER32.dll")
BOOL GetInputState();

@DllImport("USER32.dll")
uint GetQueueStatus(uint flags);

@DllImport("USER32.dll")
uint SetTimer(HWND hWnd, uint nIDEvent, uint uElapse, TIMERPROC lpTimerFunc);

@DllImport("USER32.dll")
uint SetCoalescableTimer(HWND hWnd, uint nIDEvent, uint uElapse, TIMERPROC lpTimerFunc, uint uToleranceDelay);

@DllImport("USER32.dll")
BOOL KillTimer(HWND hWnd, uint uIDEvent);

@DllImport("USER32.dll")
BOOL IsWindowUnicode(HWND hWnd);

@DllImport("USER32.dll")
int GetSystemMetrics(int nIndex);

@DllImport("USER32.dll")
BOOL CalculatePopupWindowPosition(const(POINT)* anchorPoint, const(SIZE)* windowSize, uint flags, RECT* excludeRect, RECT* popupWindowPosition);

@DllImport("USER32.dll")
HWND GetForegroundWindow();

@DllImport("USER32.dll")
void SwitchToThisWindow(HWND hwnd, BOOL fUnknown);

@DllImport("USER32.dll")
BOOL SetForegroundWindow(HWND hWnd);

@DllImport("USER32.dll")
BOOL AllowSetForegroundWindow(uint dwProcessId);

@DllImport("USER32.dll")
BOOL LockSetForegroundWindow(uint uLockCode);

@DllImport("USER32.dll")
BOOL SetPropA(HWND hWnd, const(char)* lpString, HANDLE hData);

@DllImport("USER32.dll")
BOOL SetPropW(HWND hWnd, const(wchar)* lpString, HANDLE hData);

@DllImport("USER32.dll")
HANDLE GetPropA(HWND hWnd, const(char)* lpString);

@DllImport("USER32.dll")
HANDLE GetPropW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32.dll")
HANDLE RemovePropA(HWND hWnd, const(char)* lpString);

@DllImport("USER32.dll")
HANDLE RemovePropW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32.dll")
int EnumPropsExA(HWND hWnd, PROPENUMPROCEXA lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
int EnumPropsExW(HWND hWnd, PROPENUMPROCEXW lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
int EnumPropsA(HWND hWnd, PROPENUMPROCA lpEnumFunc);

@DllImport("USER32.dll")
int EnumPropsW(HWND hWnd, PROPENUMPROCW lpEnumFunc);

@DllImport("USER32.dll")
BOOL SetWindowTextA(HWND hWnd, const(char)* lpString);

@DllImport("USER32.dll")
BOOL SetWindowTextW(HWND hWnd, const(wchar)* lpString);

@DllImport("USER32.dll")
int GetWindowTextA(HWND hWnd, const(char)* lpString, int nMaxCount);

@DllImport("USER32.dll")
int GetWindowTextW(HWND hWnd, const(wchar)* lpString, int nMaxCount);

@DllImport("USER32.dll")
int GetWindowTextLengthA(HWND hWnd);

@DllImport("USER32.dll")
int GetWindowTextLengthW(HWND hWnd);

@DllImport("USER32.dll")
BOOL GetClientRect(HWND hWnd, RECT* lpRect);

@DllImport("USER32.dll")
BOOL GetWindowRect(HWND hWnd, RECT* lpRect);

@DllImport("USER32.dll")
BOOL AdjustWindowRect(RECT* lpRect, uint dwStyle, BOOL bMenu);

@DllImport("USER32.dll")
BOOL AdjustWindowRectEx(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle);

@DllImport("USER32.dll")
int MessageBoxA(HWND hWnd, const(char)* lpText, const(char)* lpCaption, uint uType);

@DllImport("USER32.dll")
int MessageBoxW(HWND hWnd, const(wchar)* lpText, const(wchar)* lpCaption, uint uType);

@DllImport("USER32.dll")
int MessageBoxExA(HWND hWnd, const(char)* lpText, const(char)* lpCaption, uint uType, ushort wLanguageId);

@DllImport("USER32.dll")
int MessageBoxExW(HWND hWnd, const(wchar)* lpText, const(wchar)* lpCaption, uint uType, ushort wLanguageId);

@DllImport("USER32.dll")
int MessageBoxIndirectA(const(MSGBOXPARAMSA)* lpmbp);

@DllImport("USER32.dll")
int MessageBoxIndirectW(const(MSGBOXPARAMSW)* lpmbp);

@DllImport("USER32.dll")
BOOL LogicalToPhysicalPoint(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
BOOL PhysicalToLogicalPoint(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
HWND WindowFromPoint(POINT Point);

@DllImport("USER32.dll")
HWND WindowFromPhysicalPoint(POINT Point);

@DllImport("USER32.dll")
HWND ChildWindowFromPoint(HWND hWndParent, POINT Point);

@DllImport("USER32.dll")
HWND ChildWindowFromPointEx(HWND hwnd, POINT pt, uint flags);

@DllImport("USER32.dll")
uint GetSysColor(int nIndex);

@DllImport("USER32.dll")
BOOL SetSysColors(int cElements, char* lpaElements, char* lpaRgbValues);

@DllImport("USER32.dll")
int GetWindowLongA(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
int GetWindowLongW(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
int SetWindowLongA(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32.dll")
int SetWindowLongW(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32.dll")
ushort GetClassWord(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
ushort SetClassWord(HWND hWnd, int nIndex, ushort wNewWord);

@DllImport("USER32.dll")
uint GetClassLongA(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
uint GetClassLongW(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
uint SetClassLongA(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32.dll")
uint SetClassLongW(HWND hWnd, int nIndex, int dwNewLong);

@DllImport("USER32.dll")
BOOL GetProcessDefaultLayout(uint* pdwDefaultLayout);

@DllImport("USER32.dll")
BOOL SetProcessDefaultLayout(uint dwDefaultLayout);

@DllImport("USER32.dll")
HWND GetDesktopWindow();

@DllImport("USER32.dll")
HWND GetParent(HWND hWnd);

@DllImport("USER32.dll")
HWND SetParent(HWND hWndChild, HWND hWndNewParent);

@DllImport("USER32.dll")
BOOL EnumChildWindows(HWND hWndParent, WNDENUMPROC lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
HWND FindWindowA(const(char)* lpClassName, const(char)* lpWindowName);

@DllImport("USER32.dll")
HWND FindWindowW(const(wchar)* lpClassName, const(wchar)* lpWindowName);

@DllImport("USER32.dll")
HWND FindWindowExA(HWND hWndParent, HWND hWndChildAfter, const(char)* lpszClass, const(char)* lpszWindow);

@DllImport("USER32.dll")
HWND FindWindowExW(HWND hWndParent, HWND hWndChildAfter, const(wchar)* lpszClass, const(wchar)* lpszWindow);

@DllImport("USER32.dll")
HWND GetShellWindow();

@DllImport("USER32.dll")
BOOL RegisterShellHookWindow(HWND hwnd);

@DllImport("USER32.dll")
BOOL DeregisterShellHookWindow(HWND hwnd);

@DllImport("USER32.dll")
BOOL EnumWindows(WNDENUMPROC lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
BOOL EnumThreadWindows(uint dwThreadId, WNDENUMPROC lpfn, LPARAM lParam);

@DllImport("USER32.dll")
int GetClassNameA(HWND hWnd, const(char)* lpClassName, int nMaxCount);

@DllImport("USER32.dll")
int GetClassNameW(HWND hWnd, const(wchar)* lpClassName, int nMaxCount);

@DllImport("USER32.dll")
HWND GetTopWindow(HWND hWnd);

@DllImport("USER32.dll")
uint GetWindowThreadProcessId(HWND hWnd, uint* lpdwProcessId);

@DllImport("USER32.dll")
BOOL IsGUIThread(BOOL bConvert);

@DllImport("USER32.dll")
HWND GetLastActivePopup(HWND hWnd);

@DllImport("USER32.dll")
HWND GetWindow(HWND hWnd, uint uCmd);

@DllImport("USER32.dll")
int SetWindowsHookExA(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

@DllImport("USER32.dll")
int SetWindowsHookExW(int idHook, HOOKPROC lpfn, HINSTANCE hmod, uint dwThreadId);

@DllImport("USER32.dll")
BOOL UnhookWindowsHookEx(int hhk);

@DllImport("USER32.dll")
LRESULT CallNextHookEx(int hhk, int nCode, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL IsDialogMessageA(HWND hDlg, MSG* lpMsg);

@DllImport("USER32.dll")
BOOL IsDialogMessageW(HWND hDlg, MSG* lpMsg);

@DllImport("USER32.dll")
BOOL MapDialogRect(HWND hDlg, RECT* lpRect);

@DllImport("USER32.dll")
LRESULT DefFrameProcA(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT DefFrameProcW(HWND hWnd, HWND hWndMDIClient, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT DefMDIChildProcA(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
LRESULT DefMDIChildProcW(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL TranslateMDISysAccel(HWND hWndClient, MSG* lpMsg);

@DllImport("USER32.dll")
uint ArrangeIconicWindows(HWND hWnd);

@DllImport("USER32.dll")
HWND CreateMDIWindowA(const(char)* lpClassName, const(char)* lpWindowName, uint dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

@DllImport("USER32.dll")
HWND CreateMDIWindowW(const(wchar)* lpClassName, const(wchar)* lpWindowName, uint dwStyle, int X, int Y, int nWidth, int nHeight, HWND hWndParent, HINSTANCE hInstance, LPARAM lParam);

@DllImport("USER32.dll")
ushort TileWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, char* lpKids);

@DllImport("USER32.dll")
ushort CascadeWindows(HWND hwndParent, uint wHow, const(RECT)* lpRect, uint cKids, char* lpKids);

@DllImport("USER32.dll")
BOOL SystemParametersInfoA(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

@DllImport("USER32.dll")
BOOL SystemParametersInfoW(uint uiAction, uint uiParam, void* pvParam, uint fWinIni);

@DllImport("USER32.dll")
BOOL SoundSentry();

@DllImport("USER32.dll")
int InternalGetWindowText(HWND hWnd, const(wchar)* pString, int cchMaxCount);

@DllImport("USER32.dll")
BOOL GetGUIThreadInfo(uint idThread, GUITHREADINFO* pgui);

@DllImport("USER32.dll")
BOOL SetProcessDPIAware();

@DllImport("USER32.dll")
BOOL IsProcessDPIAware();

@DllImport("USER32.dll")
uint GetWindowModuleFileNameA(HWND hwnd, const(char)* pszFileName, uint cchFileNameMax);

@DllImport("USER32.dll")
uint GetWindowModuleFileNameW(HWND hwnd, const(wchar)* pszFileName, uint cchFileNameMax);

@DllImport("USER32.dll")
BOOL GetWindowInfo(HWND hwnd, WINDOWINFO* pwi);

@DllImport("USER32.dll")
BOOL GetTitleBarInfo(HWND hwnd, TITLEBARINFO* pti);

@DllImport("USER32.dll")
HWND GetAncestor(HWND hwnd, uint gaFlags);

@DllImport("USER32.dll")
HWND RealChildWindowFromPoint(HWND hwndParent, POINT ptParentClientCoords);

@DllImport("USER32.dll")
uint RealGetWindowClassW(HWND hwnd, const(wchar)* ptszClassName, uint cchClassNameMax);

@DllImport("USER32.dll")
BOOL GetAltTabInfoA(HWND hwnd, int iItem, ALTTABINFO* pati, const(char)* pszItemText, uint cchItemText);

@DllImport("USER32.dll")
BOOL GetAltTabInfoW(HWND hwnd, int iItem, ALTTABINFO* pati, const(wchar)* pszItemText, uint cchItemText);

@DllImport("USER32.dll")
BOOL ChangeWindowMessageFilter(uint message, uint dwFlag);

@DllImport("USER32.dll")
BOOL ChangeWindowMessageFilterEx(HWND hwnd, uint message, uint action, CHANGEFILTERSTRUCT* pChangeFilterStruct);

alias HWND = int;
alias LPARAM = int;
alias WPARAM = uint;
alias DLGPROC = extern(Windows) int function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias TIMERPROC = extern(Windows) void function(HWND param0, uint param1, uint param2, uint param3);
alias HOOKPROC = extern(Windows) LRESULT function(int code, WPARAM wParam, LPARAM lParam);
alias SENDASYNCPROC = extern(Windows) void function(HWND param0, uint param1, uint param2, LRESULT param3);
alias PROPENUMPROCA = extern(Windows) BOOL function(HWND param0, const(char)* param1, HANDLE param2);
alias PROPENUMPROCW = extern(Windows) BOOL function(HWND param0, const(wchar)* param1, HANDLE param2);
alias PROPENUMPROCEXA = extern(Windows) BOOL function(HWND param0, const(char)* param1, HANDLE param2, uint param3);
alias PROPENUMPROCEXW = extern(Windows) BOOL function(HWND param0, const(wchar)* param1, HANDLE param2, uint param3);
struct CBT_CREATEWNDA
{
    CREATESTRUCTA* lpcs;
    HWND hwndInsertAfter;
}

struct CBT_CREATEWNDW
{
    CREATESTRUCTW* lpcs;
    HWND hwndInsertAfter;
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
    uint message;
    HWND hwnd;
}

struct CWPRETSTRUCT
{
    LRESULT lResult;
    LPARAM lParam;
    WPARAM wParam;
    uint message;
    HWND hwnd;
}

struct KBDLLHOOKSTRUCT
{
    uint vkCode;
    uint scanCode;
    uint flags;
    uint time;
    uint dwExtraInfo;
}

struct MSLLHOOKSTRUCT
{
    POINT pt;
    uint mouseData;
    uint flags;
    uint time;
    uint dwExtraInfo;
}

struct DEBUGHOOKINFO
{
    uint idThread;
    uint idThreadInstaller;
    LPARAM lParam;
    WPARAM wParam;
    int code;
}

struct MOUSEHOOKSTRUCT
{
    POINT pt;
    HWND hwnd;
    uint wHitTestCode;
    uint dwExtraInfo;
}

struct MOUSEHOOKSTRUCTEX
{
    MOUSEHOOKSTRUCT __AnonymousBase_winuser_L1173_C46;
    uint mouseData;
}

struct WNDCLASSEXA
{
    uint cbSize;
    uint style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    const(char)* lpszMenuName;
    const(char)* lpszClassName;
    HICON hIconSm;
}

struct WNDCLASSEXW
{
    uint cbSize;
    uint style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    const(wchar)* lpszMenuName;
    const(wchar)* lpszClassName;
    HICON hIconSm;
}

struct WNDCLASSA
{
    uint style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    const(char)* lpszMenuName;
    const(char)* lpszClassName;
}

struct WNDCLASSW
{
    uint style;
    WNDPROC lpfnWndProc;
    int cbClsExtra;
    int cbWndExtra;
    HINSTANCE hInstance;
    HICON hIcon;
    HCURSOR hCursor;
    HBRUSH hbrBackground;
    const(wchar)* lpszMenuName;
    const(wchar)* lpszClassName;
}

struct MSG
{
    HWND hwnd;
    uint message;
    WPARAM wParam;
    LPARAM lParam;
    uint time;
    POINT pt;
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
    int x;
    int y;
    int cx;
    int cy;
    uint flags;
}

struct NCCALCSIZE_PARAMS
{
    RECT rgrc;
    WINDOWPOS* lppos;
}

struct CREATESTRUCTA
{
    void* lpCreateParams;
    HINSTANCE hInstance;
    HMENU hMenu;
    HWND hwndParent;
    int cy;
    int cx;
    int y;
    int x;
    int style;
    const(char)* lpszName;
    const(char)* lpszClass;
    uint dwExStyle;
}

struct CREATESTRUCTW
{
    void* lpCreateParams;
    HINSTANCE hInstance;
    HMENU hMenu;
    HWND hwndParent;
    int cy;
    int cx;
    int y;
    int x;
    int style;
    const(wchar)* lpszName;
    const(wchar)* lpszClass;
    uint dwExStyle;
}

struct WINDOWPLACEMENT
{
    uint length;
    uint flags;
    uint showCmd;
    POINT ptMinPosition;
    POINT ptMaxPosition;
    RECT rcNormalPosition;
}

struct STYLESTRUCT
{
    uint styleOld;
    uint styleNew;
}

struct BSMINFO
{
    uint cbSize;
    HDESK hdesk;
    HWND hwnd;
    LUID luid;
}

struct UPDATELAYEREDWINDOWINFO
{
    uint cbSize;
    HDC hdcDst;
    const(POINT)* pptDst;
    const(SIZE)* psize;
    HDC hdcSrc;
    const(POINT)* pptSrc;
    uint crKey;
    const(BLENDFUNCTION)* pblend;
    uint dwFlags;
    const(RECT)* prcDirty;
}

struct DLGTEMPLATE
{
    uint style;
    uint dwExtendedStyle;
    ushort cdit;
    short x;
    short y;
    short cx;
    short cy;
}

struct DLGITEMTEMPLATE
{
    uint style;
    uint dwExtendedStyle;
    short x;
    short y;
    short cx;
    short cy;
    ushort id;
}

struct MSGBOXPARAMSA
{
    uint cbSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(char)* lpszText;
    const(char)* lpszCaption;
    uint dwStyle;
    const(char)* lpszIcon;
    uint dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    uint dwLanguageId;
}

struct MSGBOXPARAMSW
{
    uint cbSize;
    HWND hwndOwner;
    HINSTANCE hInstance;
    const(wchar)* lpszText;
    const(wchar)* lpszCaption;
    uint dwStyle;
    const(wchar)* lpszIcon;
    uint dwContextHelpId;
    MSGBOXCALLBACK lpfnMsgBoxCallback;
    uint dwLanguageId;
}

struct MDICREATESTRUCTA
{
    const(char)* szClass;
    const(char)* szTitle;
    HANDLE hOwner;
    int x;
    int y;
    int cx;
    int cy;
    uint style;
    LPARAM lParam;
}

struct MDICREATESTRUCTW
{
    const(wchar)* szClass;
    const(wchar)* szTitle;
    HANDLE hOwner;
    int x;
    int y;
    int cx;
    int cy;
    uint style;
    LPARAM lParam;
}

struct CLIENTCREATESTRUCT
{
    HANDLE hWindowMenu;
    uint idFirstChild;
}

struct NONCLIENTMETRICSA
{
    uint cbSize;
    int iBorderWidth;
    int iScrollWidth;
    int iScrollHeight;
    int iCaptionWidth;
    int iCaptionHeight;
    LOGFONTA lfCaptionFont;
    int iSmCaptionWidth;
    int iSmCaptionHeight;
    LOGFONTA lfSmCaptionFont;
    int iMenuWidth;
    int iMenuHeight;
    LOGFONTA lfMenuFont;
    LOGFONTA lfStatusFont;
    LOGFONTA lfMessageFont;
    int iPaddedBorderWidth;
}

struct NONCLIENTMETRICSW
{
    uint cbSize;
    int iBorderWidth;
    int iScrollWidth;
    int iScrollHeight;
    int iCaptionWidth;
    int iCaptionHeight;
    LOGFONTW lfCaptionFont;
    int iSmCaptionWidth;
    int iSmCaptionHeight;
    LOGFONTW lfSmCaptionFont;
    int iMenuWidth;
    int iMenuHeight;
    LOGFONTW lfMenuFont;
    LOGFONTW lfStatusFont;
    LOGFONTW lfMessageFont;
    int iPaddedBorderWidth;
}

struct MINIMIZEDMETRICS
{
    uint cbSize;
    int iWidth;
    int iHorzGap;
    int iVertGap;
    int iArrange;
}

struct ANIMATIONINFO
{
    uint cbSize;
    int iMinAnimate;
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
    uint cbSize;
    RECT rcWindow;
    RECT rcClient;
    uint dwStyle;
    uint dwExStyle;
    uint dwWindowStatus;
    uint cxWindowBorders;
    uint cyWindowBorders;
    ushort atomWindowType;
    ushort wCreatorVersion;
}

struct TITLEBARINFO
{
    uint cbSize;
    RECT rcTitleBar;
    uint rgstate;
}

struct TITLEBARINFOEX
{
    uint cbSize;
    RECT rcTitleBar;
    uint rgstate;
    RECT rgrect;
}

struct ALTTABINFO
{
    uint cbSize;
    int cItems;
    int cColumns;
    int cRows;
    int iColFocus;
    int iRowFocus;
    int cxItem;
    int cyItem;
    POINT ptStart;
}

struct CHANGEFILTERSTRUCT
{
    uint cbSize;
    uint ExtStatus;
}

