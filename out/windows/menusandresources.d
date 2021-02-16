module windows.menusandresources;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : HBITMAP, HBRUSH, HCURSOR, HDC, HICON;
public import windows.shell : HELPINFO, LOGFONTA, LOGFONTW;
public import windows.systemservices : BOOL, ENUMRESLANGPROCA, ENUMRESLANGPROCW, HANDLE, HINSTANCE, LRESULT;
public import windows.windowsandmessaging : HOOKPROC, HWND, LPARAM, MSG, UPDATELAYEREDWINDOWINFO, WPARAM;

extern(Windows):


// Enums


enum : int
{
    PT_POINTER  = 0x00000001,
    PT_TOUCH    = 0x00000002,
    PT_PEN      = 0x00000003,
    PT_MOUSE    = 0x00000004,
    PT_TOUCHPAD = 0x00000005,
}
alias POINTER_INPUT_TYPE = int;

enum : int
{
    EDIT_CONTROL_FEATURE_ENTERPRISE_DATA_PROTECTION_PASTE_SUPPORT = 0x00000000,
    EDIT_CONTROL_FEATURE_PASTE_NOTIFICATIONS                      = 0x00000001,
}
alias EDIT_CONTROL_FEATURE = int;

enum : int
{
    HANDEDNESS_LEFT  = 0x00000000,
    HANDEDNESS_RIGHT = 0x00000001,
}
alias HANDEDNESS = int;

enum MrmPlatformVersion : int
{
    MrmPlatformVersion_Default         = 0x00000000,
    MrmPlatformVersion_Windows10_0_0_0 = 0x010a0000,
    MrmPlatformVersion_Windows10_0_0_5 = 0x010a0005,
}

enum MrmPackagingMode : int
{
    MrmPackagingModeStandaloneFile = 0x00000000,
    MrmPackagingModeAutoSplit      = 0x00000001,
    MrmPackagingModeResourcePack   = 0x00000002,
}

enum MrmPackagingOptions : int
{
    MrmPackagingOptionsNone                        = 0x00000000,
    MrmPackagingOptionsOmitSchemaFromResourcePacks = 0x00000001,
    MrmPackagingOptionsSplitLanguageVariants       = 0x00000002,
}

enum MrmDumpType : int
{
    MrmDumpType_Basic    = 0x00000000,
    MrmDumpType_Detailed = 0x00000001,
    MrmDumpType_Schema   = 0x00000002,
}

enum MrmResourceIndexerMessageSeverity : int
{
    MrmResourceIndexerMessageSeverityVerbose = 0x00000000,
    MrmResourceIndexerMessageSeverityInfo    = 0x00000001,
    MrmResourceIndexerMessageSeverityWarning = 0x00000002,
    MrmResourceIndexerMessageSeverityError   = 0x00000003,
}

// Callbacks

alias ENUMRESNAMEPROCA = BOOL function(ptrdiff_t hModule, const(char)* lpType, const(char)* lpName, 
                                       ptrdiff_t lParam);
alias ENUMRESNAMEPROCW = BOOL function(ptrdiff_t hModule, const(wchar)* lpType, const(wchar)* lpName, 
                                       ptrdiff_t lParam);
alias ENUMRESTYPEPROCA = BOOL function(ptrdiff_t hModule, const(char)* lpType, ptrdiff_t lParam);
alias ENUMRESTYPEPROCW = BOOL function(ptrdiff_t hModule, const(wchar)* lpType, ptrdiff_t lParam);
alias WNDPROC = LRESULT function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias WNDENUMPROC = BOOL function(HWND param0, LPARAM param1);
alias PROPENUMPROC = BOOL function();
alias PROPENUMPROCEX = BOOL function();
alias EDITWORDBREAKPROC = int function();
alias NAMEENUMPROCA = BOOL function(const(char)* param0, LPARAM param1);
alias NAMEENUMPROCW = BOOL function(const(wchar)* param0, LPARAM param1);
alias WINSTAENUMPROCA = BOOL function();
alias DESKTOPENUMPROCA = BOOL function();
alias WINSTAENUMPROCW = BOOL function();
alias DESKTOPENUMPROCW = BOOL function();
alias WINSTAENUMPROC = BOOL function();
alias DESKTOPENUMPROC = BOOL function();
alias PREGISTERCLASSNAMEW = ubyte function(const(wchar)* param0);
alias MSGBOXCALLBACK = void function(HELPINFO* lpHelpInfo);

// Structs


alias HACCEL = ptrdiff_t;

alias HMENU = ptrdiff_t;

struct MESSAGE_RESOURCE_ENTRY
{
    ushort   Length;
    ushort   Flags;
    ubyte[1] Text;
}

struct MESSAGE_RESOURCE_BLOCK
{
    uint LowId;
    uint HighId;
    uint OffsetToEntries;
}

struct MESSAGE_RESOURCE_DATA
{
    uint NumberOfBlocks;
    MESSAGE_RESOURCE_BLOCK[1] Blocks;
}

struct VS_FIXEDFILEINFO
{
    uint dwSignature;
    uint dwStrucVersion;
    uint dwFileVersionMS;
    uint dwFileVersionLS;
    uint dwProductVersionMS;
    uint dwProductVersionLS;
    uint dwFileFlagsMask;
    uint dwFileFlags;
    uint dwFileOS;
    uint dwFileType;
    uint dwFileSubtype;
    uint dwFileDateMS;
    uint dwFileDateLS;
}

struct SHELLHOOKINFO
{
    HWND hwnd;
    RECT rc;
}

struct HARDWAREHOOKSTRUCT
{
    HWND   hwnd;
    uint   message;
    WPARAM wParam;
    LPARAM lParam;
}

struct MDINEXTMENU
{
    HMENU hmenuIn;
    HMENU hmenuNext;
    HWND  hwndNext;
}

struct ACCEL
{
    ubyte  fVirt;
    ushort key;
    ushort cmd;
}

struct HTOUCHINPUT__
{
    int unused;
}

struct HSYNTHETICPOINTERDEVICE__
{
    int unused;
}

struct TPMPARAMS
{
    uint cbSize;
    RECT rcExclude;
}

struct MENUINFO
{
    uint   cbSize;
    uint   fMask;
    uint   dwStyle;
    uint   cyMax;
    HBRUSH hbrBack;
    uint   dwContextHelpID;
    size_t dwMenuData;
}

struct MENUGETOBJECTINFO
{
    uint  dwFlags;
    uint  uPos;
    HMENU hmenu;
    void* riid;
    void* pvObj;
}

struct MENUITEMINFOA
{
    uint         cbSize;
    uint         fMask;
    uint         fType;
    uint         fState;
    uint         wID;
    HMENU        hSubMenu;
    HBITMAP      hbmpChecked;
    HBITMAP      hbmpUnchecked;
    size_t       dwItemData;
    const(char)* dwTypeData;
    uint         cch;
    HBITMAP      hbmpItem;
}

struct MENUITEMINFOW
{
    uint          cbSize;
    uint          fMask;
    uint          fType;
    uint          fState;
    uint          wID;
    HMENU         hSubMenu;
    HBITMAP       hbmpChecked;
    HBITMAP       hbmpUnchecked;
    size_t        dwItemData;
    const(wchar)* dwTypeData;
    uint          cch;
    HBITMAP       hbmpItem;
}

struct DROPSTRUCT
{
    HWND   hwndSource;
    HWND   hwndSink;
    uint   wFmt;
    size_t dwData;
    POINT  ptDrop;
    uint   dwControlData;
}

struct MENUITEMTEMPLATEHEADER
{
    ushort versionNumber;
    ushort offset;
}

struct MENUITEMTEMPLATE
{
    ushort    mtOption;
    ushort    mtID;
    ushort[1] mtString;
}

struct ICONINFO
{
    BOOL    fIcon;
    uint    xHotspot;
    uint    yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
}

struct CURSORSHAPE
{
    int   xHotSpot;
    int   yHotSpot;
    int   cx;
    int   cy;
    int   cbWidth;
    ubyte Planes;
    ubyte BitsPixel;
}

struct ICONINFOEXA
{
    uint      cbSize;
    BOOL      fIcon;
    uint      xHotspot;
    uint      yHotspot;
    HBITMAP   hbmMask;
    HBITMAP   hbmColor;
    ushort    wResID;
    byte[260] szModName;
    byte[260] szResName;
}

struct ICONINFOEXW
{
    uint        cbSize;
    BOOL        fIcon;
    uint        xHotspot;
    uint        yHotspot;
    HBITMAP     hbmMask;
    HBITMAP     hbmColor;
    ushort      wResID;
    ushort[260] szModName;
    ushort[260] szResName;
}

struct TouchPredictionParameters
{
    uint cbSize;
    uint dwLatency;
    uint dwSampleTime;
    uint bUseHWTimeStamp;
}

struct ICONMETRICSA
{
    uint     cbSize;
    int      iHorzSpacing;
    int      iVertSpacing;
    int      iTitleWrap;
    LOGFONTA lfFont;
}

struct ICONMETRICSW
{
    uint     cbSize;
    int      iHorzSpacing;
    int      iVertSpacing;
    int      iTitleWrap;
    LOGFONTW lfFont;
}

struct CURSORINFO
{
    uint    cbSize;
    uint    flags;
    HCURSOR hCursor;
    POINT   ptScreenPos;
}

struct MENUBARINFO
{
    uint  cbSize;
    RECT  rcBar;
    HMENU hMenu;
    HWND  hwndMenu;
    int   _bitfield69;
}

struct HRAWINPUT__
{
    int unused;
}

struct HGESTUREINFO__
{
    int unused;
}

struct IndexedResourceQualifier
{
    const(wchar)* name;
    const(wchar)* value;
}

struct MrmResourceIndexerHandle
{
    void* handle;
}

struct MrmResourceIndexerMessage
{
    MrmResourceIndexerMessageSeverity severity;
    uint          id;
    const(wchar)* text;
}

// Functions

@DllImport("KERNEL32")
BOOL FreeResource(ptrdiff_t hResData);

@DllImport("KERNEL32")
ptrdiff_t LoadResource(ptrdiff_t hModule, ptrdiff_t hResInfo);

@DllImport("USER32")
int LoadStringA(HINSTANCE hInstance, uint uID, const(char)* lpBuffer, int cchBufferMax);

@DllImport("USER32")
int LoadStringW(HINSTANCE hInstance, uint uID, const(wchar)* lpBuffer, int cchBufferMax);

@DllImport("KERNEL32")
void* LockResource(ptrdiff_t hResData);

@DllImport("KERNEL32")
uint SizeofResource(ptrdiff_t hModule, ptrdiff_t hResInfo);

@DllImport("KERNEL32")
BOOL EnumResourceLanguagesExA(ptrdiff_t hModule, const(char)* lpType, const(char)* lpName, 
                              ENUMRESLANGPROCA lpEnumFunc, ptrdiff_t lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32")
BOOL EnumResourceLanguagesExW(ptrdiff_t hModule, const(wchar)* lpType, const(wchar)* lpName, 
                              ENUMRESLANGPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32")
BOOL EnumResourceNamesExA(ptrdiff_t hModule, const(char)* lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

@DllImport("KERNEL32")
BOOL EnumResourceNamesExW(ptrdiff_t hModule, const(wchar)* lpType, ENUMRESNAMEPROCW lpEnumFunc, ptrdiff_t lParam, 
                          uint dwFlags, ushort LangId);

@DllImport("KERNEL32")
BOOL EnumResourceTypesExA(ptrdiff_t hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

@DllImport("KERNEL32")
BOOL EnumResourceTypesExW(ptrdiff_t hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam, uint dwFlags, 
                          ushort LangId);

@DllImport("USER32")
int wvsprintfA(const(char)* param0, const(char)* param1, byte* arglist);

@DllImport("USER32")
int wvsprintfW(const(wchar)* param0, const(wchar)* param1, byte* arglist);

@DllImport("USER32")
int wsprintfA(const(char)* param0, const(char)* param1);

@DllImport("USER32")
int wsprintfW(const(wchar)* param0, const(wchar)* param1);

@DllImport("USER32")
BOOL SetMessageQueue(int cMessagesMax);

@DllImport("USER32")
int BroadcastSystemMessageA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL IsMenu(HMENU hMenu);

@DllImport("USER32")
BOOL UpdateLayeredWindowIndirect(HWND hWnd, const(UPDATELAYEREDWINDOWINFO)* pULWInfo);

@DllImport("USER32")
LRESULT DefDlgProcA(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32")
BOOL CharToOemA(const(char)* pSrc, const(char)* pDst);

@DllImport("USER32")
BOOL CharToOemW(const(wchar)* pSrc, const(char)* pDst);

@DllImport("USER32")
BOOL OemToCharA(const(char)* pSrc, const(char)* pDst);

@DllImport("USER32")
BOOL OemToCharW(const(char)* pSrc, const(wchar)* pDst);

@DllImport("USER32")
BOOL CharToOemBuffA(const(char)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32")
BOOL CharToOemBuffW(const(wchar)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32")
BOOL OemToCharBuffA(const(char)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32")
BOOL OemToCharBuffW(const(char)* lpszSrc, const(wchar)* lpszDst, uint cchDstLength);

@DllImport("USER32")
byte* CharUpperA(const(char)* lpsz);

@DllImport("USER32")
ushort* CharUpperW(const(wchar)* lpsz);

@DllImport("USER32")
uint CharUpperBuffA(const(char)* lpsz, uint cchLength);

@DllImport("USER32")
uint CharUpperBuffW(const(wchar)* lpsz, uint cchLength);

@DllImport("USER32")
byte* CharLowerA(const(char)* lpsz);

@DllImport("USER32")
ushort* CharLowerW(const(wchar)* lpsz);

@DllImport("USER32")
uint CharLowerBuffA(const(char)* lpsz, uint cchLength);

@DllImport("USER32")
uint CharLowerBuffW(const(wchar)* lpsz, uint cchLength);

@DllImport("USER32")
byte* CharNextA(const(char)* lpsz);

@DllImport("USER32")
ushort* CharNextW(const(wchar)* lpsz);

@DllImport("USER32")
byte* CharPrevA(const(char)* lpszStart, const(char)* lpszCurrent);

@DllImport("USER32")
ushort* CharPrevW(const(wchar)* lpszStart, const(wchar)* lpszCurrent);

@DllImport("USER32")
byte* CharNextExA(ushort CodePage, const(char)* lpCurrentChar, uint dwFlags);

@DllImport("USER32")
byte* CharPrevExA(ushort CodePage, const(char)* lpStart, const(char)* lpCurrentChar, uint dwFlags);

@DllImport("USER32")
BOOL IsCharAlphaA(byte ch);

@DllImport("USER32")
BOOL IsCharAlphaW(ushort ch);

@DllImport("USER32")
BOOL IsCharAlphaNumericA(byte ch);

@DllImport("USER32")
BOOL IsCharAlphaNumericW(ushort ch);

@DllImport("USER32")
BOOL IsCharUpperA(byte ch);

@DllImport("USER32")
BOOL IsCharUpperW(ushort ch);

@DllImport("USER32")
BOOL IsCharLowerA(byte ch);

@DllImport("USER32")
HACCEL LoadAcceleratorsA(HINSTANCE hInstance, const(char)* lpTableName);

@DllImport("USER32")
HACCEL LoadAcceleratorsW(HINSTANCE hInstance, const(wchar)* lpTableName);

@DllImport("USER32")
HACCEL CreateAcceleratorTableA(char* paccel, int cAccel);

@DllImport("USER32")
HACCEL CreateAcceleratorTableW(char* paccel, int cAccel);

@DllImport("USER32")
BOOL DestroyAcceleratorTable(HACCEL hAccel);

@DllImport("USER32")
int CopyAcceleratorTableA(HACCEL hAccelSrc, char* lpAccelDst, int cAccelEntries);

@DllImport("USER32")
int CopyAcceleratorTableW(HACCEL hAccelSrc, char* lpAccelDst, int cAccelEntries);

@DllImport("USER32")
int TranslateAcceleratorA(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

@DllImport("USER32")
int TranslateAcceleratorW(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

@DllImport("USER32")
HMENU LoadMenuA(HINSTANCE hInstance, const(char)* lpMenuName);

@DllImport("USER32")
HMENU LoadMenuW(HINSTANCE hInstance, const(wchar)* lpMenuName);

@DllImport("USER32")
HMENU LoadMenuIndirectA(const(void)* lpMenuTemplate);

@DllImport("USER32")
HMENU LoadMenuIndirectW(const(void)* lpMenuTemplate);

@DllImport("USER32")
HMENU GetMenu(HWND hWnd);

@DllImport("USER32")
BOOL SetMenu(HWND hWnd, HMENU hMenu);

@DllImport("USER32")
BOOL ChangeMenuA(HMENU hMenu, uint cmd, const(char)* lpszNewItem, uint cmdInsert, uint flags);

@DllImport("USER32")
BOOL ChangeMenuW(HMENU hMenu, uint cmd, const(wchar)* lpszNewItem, uint cmdInsert, uint flags);

@DllImport("USER32")
BOOL HiliteMenuItem(HWND hWnd, HMENU hMenu, uint uIDHiliteItem, uint uHilite);

@DllImport("USER32")
int GetMenuStringA(HMENU hMenu, uint uIDItem, const(char)* lpString, int cchMax, uint flags);

@DllImport("USER32")
int GetMenuStringW(HMENU hMenu, uint uIDItem, const(wchar)* lpString, int cchMax, uint flags);

@DllImport("USER32")
uint GetMenuState(HMENU hMenu, uint uId, uint uFlags);

@DllImport("USER32")
BOOL DrawMenuBar(HWND hWnd);

@DllImport("USER32")
HMENU GetSystemMenu(HWND hWnd, BOOL bRevert);

@DllImport("USER32")
HMENU CreateMenu();

@DllImport("USER32")
HMENU CreatePopupMenu();

@DllImport("USER32")
BOOL DestroyMenu(HMENU hMenu);

@DllImport("USER32")
uint CheckMenuItem(HMENU hMenu, uint uIDCheckItem, uint uCheck);

@DllImport("USER32")
BOOL EnableMenuItem(HMENU hMenu, uint uIDEnableItem, uint uEnable);

@DllImport("USER32")
HMENU GetSubMenu(HMENU hMenu, int nPos);

@DllImport("USER32")
uint GetMenuItemID(HMENU hMenu, int nPos);

@DllImport("USER32")
int GetMenuItemCount(HMENU hMenu);

@DllImport("USER32")
BOOL InsertMenuA(HMENU hMenu, uint uPosition, uint uFlags, size_t uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32")
BOOL InsertMenuW(HMENU hMenu, uint uPosition, uint uFlags, size_t uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32")
BOOL AppendMenuA(HMENU hMenu, uint uFlags, size_t uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32")
BOOL AppendMenuW(HMENU hMenu, uint uFlags, size_t uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32")
BOOL ModifyMenuA(HMENU hMnu, uint uPosition, uint uFlags, size_t uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32")
BOOL ModifyMenuW(HMENU hMnu, uint uPosition, uint uFlags, size_t uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32")
BOOL RemoveMenu(HMENU hMenu, uint uPosition, uint uFlags);

@DllImport("USER32")
BOOL DeleteMenu(HMENU hMenu, uint uPosition, uint uFlags);

@DllImport("USER32")
BOOL SetMenuItemBitmaps(HMENU hMenu, uint uPosition, uint uFlags, HBITMAP hBitmapUnchecked, HBITMAP hBitmapChecked);

@DllImport("USER32")
int GetMenuCheckMarkDimensions();

@DllImport("USER32")
BOOL TrackPopupMenu(HMENU hMenu, uint uFlags, int x, int y, int nReserved, HWND hWnd, const(RECT)* prcRect);

@DllImport("USER32")
BOOL TrackPopupMenuEx(HMENU hMenu, uint uFlags, int x, int y, HWND hwnd, TPMPARAMS* lptpm);

@DllImport("USER32")
BOOL GetMenuInfo(HMENU param0, MENUINFO* param1);

@DllImport("USER32")
BOOL SetMenuInfo(HMENU param0, MENUINFO* param1);

@DllImport("USER32")
BOOL EndMenu();

@DllImport("USER32")
BOOL InsertMenuItemA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmi);

@DllImport("USER32")
BOOL InsertMenuItemW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmi);

@DllImport("USER32")
BOOL GetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmii);

@DllImport("USER32")
BOOL GetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmii);

@DllImport("USER32")
BOOL SetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOA* lpmii);

@DllImport("USER32")
BOOL SetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOW* lpmii);

@DllImport("USER32")
uint GetMenuDefaultItem(HMENU hMenu, uint fByPos, uint gmdiFlags);

@DllImport("USER32")
BOOL SetMenuDefaultItem(HMENU hMenu, uint uItem, uint fByPos);

@DllImport("USER32")
BOOL GetMenuItemRect(HWND hWnd, HMENU hMenu, uint uItem, RECT* lprcItem);

@DllImport("USER32")
int MenuItemFromPoint(HWND hWnd, HMENU hMenu, POINT ptScreen);

@DllImport("USER32")
uint DragObject(HWND hwndParent, HWND hwndFrom, uint fmt, size_t data, HCURSOR hcur);

@DllImport("USER32")
BOOL DrawIcon(HDC hDC, int X, int Y, HICON hIcon);

@DllImport("USER32")
int ShowCursor(BOOL bShow);

@DllImport("USER32")
BOOL SetCursorPos(int X, int Y);

@DllImport("USER32")
BOOL SetPhysicalCursorPos(int X, int Y);

@DllImport("USER32")
HCURSOR SetCursor(HCURSOR hCursor);

@DllImport("USER32")
BOOL GetCursorPos(POINT* lpPoint);

@DllImport("USER32")
BOOL GetPhysicalCursorPos(POINT* lpPoint);

@DllImport("USER32")
BOOL GetClipCursor(RECT* lpRect);

@DllImport("USER32")
HCURSOR GetCursor();

@DllImport("USER32")
BOOL CreateCaret(HWND hWnd, HBITMAP hBitmap, int nWidth, int nHeight);

@DllImport("USER32")
uint GetCaretBlinkTime();

@DllImport("USER32")
BOOL SetCaretBlinkTime(uint uMSeconds);

@DllImport("USER32")
BOOL DestroyCaret();

@DllImport("USER32")
BOOL HideCaret(HWND hWnd);

@DllImport("USER32")
BOOL ShowCaret(HWND hWnd);

@DllImport("USER32")
BOOL SetCaretPos(int X, int Y);

@DllImport("USER32")
BOOL GetCaretPos(POINT* lpPoint);

@DllImport("USER32")
BOOL ClipCursor(const(RECT)* lpRect);

@DllImport("USER32")
ushort GetWindowWord(HWND hWnd, int nIndex);

@DllImport("USER32")
ushort SetWindowWord(HWND hWnd, int nIndex, ushort wNewWord);

@DllImport("USER32")
ptrdiff_t SetWindowsHookA(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32")
ptrdiff_t SetWindowsHookW(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32")
BOOL UnhookWindowsHook(int nCode, HOOKPROC pfnFilterProc);

@DllImport("USER32")
BOOL CheckMenuRadioItem(HMENU hmenu, uint first, uint last, uint check, uint flags);

@DllImport("USER32")
HCURSOR LoadCursorA(HINSTANCE hInstance, const(char)* lpCursorName);

@DllImport("USER32")
HCURSOR LoadCursorW(HINSTANCE hInstance, const(wchar)* lpCursorName);

@DllImport("USER32")
HCURSOR LoadCursorFromFileA(const(char)* lpFileName);

@DllImport("USER32")
HCURSOR LoadCursorFromFileW(const(wchar)* lpFileName);

@DllImport("USER32")
HCURSOR CreateCursor(HINSTANCE hInst, int xHotSpot, int yHotSpot, int nWidth, int nHeight, const(void)* pvANDPlane, 
                     const(void)* pvXORPlane);

@DllImport("USER32")
BOOL DestroyCursor(HCURSOR hCursor);

@DllImport("USER32")
BOOL SetSystemCursor(HCURSOR hcur, uint id);

@DllImport("USER32")
HICON LoadIconA(HINSTANCE hInstance, const(char)* lpIconName);

@DllImport("USER32")
HICON LoadIconW(HINSTANCE hInstance, const(wchar)* lpIconName);

@DllImport("USER32")
uint PrivateExtractIconsA(const(char)* szFileName, int nIconIndex, int cxIcon, int cyIcon, char* phicon, 
                          char* piconid, uint nIcons, uint flags);

@DllImport("USER32")
uint PrivateExtractIconsW(const(wchar)* szFileName, int nIconIndex, int cxIcon, int cyIcon, char* phicon, 
                          char* piconid, uint nIcons, uint flags);

@DllImport("USER32")
HICON CreateIcon(HINSTANCE hInstance, int nWidth, int nHeight, ubyte cPlanes, ubyte cBitsPixel, 
                 const(ubyte)* lpbANDbits, const(ubyte)* lpbXORbits);

@DllImport("USER32")
BOOL DestroyIcon(HICON hIcon);

@DllImport("USER32")
int LookupIconIdFromDirectory(char* presbits, BOOL fIcon);

@DllImport("USER32")
int LookupIconIdFromDirectoryEx(char* presbits, BOOL fIcon, int cxDesired, int cyDesired, uint Flags);

@DllImport("USER32")
HICON CreateIconFromResource(char* presbits, uint dwResSize, BOOL fIcon, uint dwVer);

@DllImport("USER32")
HICON CreateIconFromResourceEx(char* presbits, uint dwResSize, BOOL fIcon, uint dwVer, int cxDesired, 
                               int cyDesired, uint Flags);

@DllImport("USER32")
HANDLE LoadImageA(HINSTANCE hInst, const(char)* name, uint type, int cx, int cy, uint fuLoad);

@DllImport("USER32")
HANDLE LoadImageW(HINSTANCE hInst, const(wchar)* name, uint type, int cx, int cy, uint fuLoad);

@DllImport("USER32")
HANDLE CopyImage(HANDLE h, uint type, int cx, int cy, uint flags);

@DllImport("USER32")
BOOL DrawIconEx(HDC hdc, int xLeft, int yTop, HICON hIcon, int cxWidth, int cyWidth, uint istepIfAniCur, 
                HBRUSH hbrFlickerFreeDraw, uint diFlags);

@DllImport("USER32")
HICON CreateIconIndirect(ICONINFO* piconinfo);

@DllImport("USER32")
HICON CopyIcon(HICON hIcon);

@DllImport("USER32")
BOOL GetIconInfo(HICON hIcon, ICONINFO* piconinfo);

@DllImport("USER32")
BOOL GetIconInfoExA(HICON hicon, ICONINFOEXA* piconinfo);

@DllImport("USER32")
BOOL GetIconInfoExW(HICON hicon, ICONINFOEXW* piconinfo);

@DllImport("USER32")
void SetDebugErrorLevel(uint dwLevel);

@DllImport("USER32")
BOOL CancelShutdown();

@DllImport("USER32")
BOOL InheritWindowMonitor(HWND hwnd, HWND hwndInherit);

@DllImport("USER32")
ptrdiff_t GetDpiAwarenessContextForProcess(HANDLE hProcess);

@DllImport("USER32")
BOOL GetCursorInfo(CURSORINFO* pci);

@DllImport("USER32")
BOOL GetMenuBarInfo(HWND hwnd, int idObject, int idItem, MENUBARINFO* pmbi);

@DllImport("USER32")
uint RealGetWindowClassA(HWND hwnd, const(char)* ptszClassName, uint cchClassNameMax);

@DllImport("VERSION")
uint VerFindFileA(uint uFlags, const(char)* szFileName, const(char)* szWinDir, const(char)* szAppDir, 
                  const(char)* szCurDir, uint* puCurDirLen, const(char)* szDestDir, uint* puDestDirLen);

@DllImport("VERSION")
uint VerFindFileW(uint uFlags, const(wchar)* szFileName, const(wchar)* szWinDir, const(wchar)* szAppDir, 
                  const(wchar)* szCurDir, uint* puCurDirLen, const(wchar)* szDestDir, uint* puDestDirLen);

@DllImport("VERSION")
uint VerInstallFileA(uint uFlags, const(char)* szSrcFileName, const(char)* szDestFileName, const(char)* szSrcDir, 
                     const(char)* szDestDir, const(char)* szCurDir, const(char)* szTmpFile, uint* puTmpFileLen);

@DllImport("VERSION")
uint VerInstallFileW(uint uFlags, const(wchar)* szSrcFileName, const(wchar)* szDestFileName, 
                     const(wchar)* szSrcDir, const(wchar)* szDestDir, const(wchar)* szCurDir, 
                     const(wchar)* szTmpFile, uint* puTmpFileLen);

@DllImport("VERSION")
uint GetFileVersionInfoSizeA(const(char)* lptstrFilename, uint* lpdwHandle);

@DllImport("VERSION")
uint GetFileVersionInfoSizeW(const(wchar)* lptstrFilename, uint* lpdwHandle);

@DllImport("VERSION")
BOOL GetFileVersionInfoA(const(char)* lptstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION")
BOOL GetFileVersionInfoW(const(wchar)* lptstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION")
uint GetFileVersionInfoSizeExA(uint dwFlags, const(char)* lpwstrFilename, uint* lpdwHandle);

@DllImport("VERSION")
uint GetFileVersionInfoSizeExW(uint dwFlags, const(wchar)* lpwstrFilename, uint* lpdwHandle);

@DllImport("VERSION")
BOOL GetFileVersionInfoExA(uint dwFlags, const(char)* lpwstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION")
BOOL GetFileVersionInfoExW(uint dwFlags, const(wchar)* lpwstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("KERNEL32")
uint VerLanguageNameA(uint wLang, const(char)* szLang, uint cchLang);

@DllImport("KERNEL32")
uint VerLanguageNameW(uint wLang, const(wchar)* szLang, uint cchLang);

@DllImport("VERSION")
BOOL VerQueryValueA(void* pBlock, const(char)* lpSubBlock, void** lplpBuffer, uint* puLen);

@DllImport("VERSION")
BOOL VerQueryValueW(void* pBlock, const(wchar)* lpSubBlock, void** lplpBuffer, uint* puLen);

@DllImport("MrmSupport")
HRESULT CreateResourceIndexer(const(wchar)* projectRoot, const(wchar)* extensionDllPath, void** ppResourceIndexer);

@DllImport("MrmSupport")
void DestroyResourceIndexer(void* resourceIndexer);

@DllImport("MrmSupport")
HRESULT IndexFilePath(void* resourceIndexer, const(wchar)* filePath, ushort** ppResourceUri, uint* pQualifierCount, 
                      char* ppQualifiers);

@DllImport("MrmSupport")
void DestroyIndexedResults(const(wchar)* resourceUri, uint qualifierCount, char* qualifiers);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexer(const(wchar)* packageFamilyName, const(wchar)* projectRoot, 
                                 MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, 
                                 MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaFile(const(wchar)* projectRoot, 
                                                       MrmPlatformVersion platformVersion, 
                                                       const(wchar)* defaultQualifiers, const(wchar)* schemaFile, 
                                                       MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousPriFile(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, 
                                                    const(wchar)* defaultQualifiers, const(wchar)* priFile, 
                                                    MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaData(const(wchar)* projectRoot, 
                                                       MrmPlatformVersion platformVersion, 
                                                       const(wchar)* defaultQualifiers, char* schemaXmlData, 
                                                       uint schemaXmlSize, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceIndexerFromPreviousPriData(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, 
                                                    const(wchar)* defaultQualifiers, char* priData, uint priSize, 
                                                    MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport")
HRESULT MrmIndexString(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, const(wchar)* resourceString, 
                       const(wchar)* qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexEmbeddedData(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, char* embeddedData, 
                             uint embeddedDataSize, const(wchar)* qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexFile(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, const(wchar)* filePath, 
                     const(wchar)* qualifiers);

@DllImport("MrmSupport")
HRESULT MrmIndexFileAutoQualifiers(MrmResourceIndexerHandle indexer, const(wchar)* filePath);

@DllImport("MrmSupport")
HRESULT MrmIndexResourceContainerAutoQualifiers(MrmResourceIndexerHandle indexer, const(wchar)* containerPath);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceFile(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, 
                              MrmPackagingOptions packagingOptions, const(wchar)* outputDirectory);

@DllImport("MrmSupport")
HRESULT MrmCreateResourceFileInMemory(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, 
                                      MrmPackagingOptions packagingOptions, ubyte** outputPriData, 
                                      uint* outputPriSize);

@DllImport("MrmSupport")
HRESULT MrmPeekResourceIndexerMessages(MrmResourceIndexerHandle handle, char* messages, uint* numMsgs);

@DllImport("MrmSupport")
HRESULT MrmDestroyIndexerAndMessages(MrmResourceIndexerHandle indexer);

@DllImport("MrmSupport")
HRESULT MrmFreeMemory(ubyte* data);

@DllImport("MrmSupport")
HRESULT MrmDumpPriFile(const(wchar)* indexFileName, const(wchar)* schemaPriFile, MrmDumpType dumpType, 
                       const(wchar)* outputXmlFile);

@DllImport("MrmSupport")
HRESULT MrmDumpPriFileInMemory(const(wchar)* indexFileName, const(wchar)* schemaPriFile, MrmDumpType dumpType, 
                               ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport")
HRESULT MrmDumpPriDataInMemory(char* inputPriData, uint inputPriSize, char* schemaPriData, uint schemaPriSize, 
                               MrmDumpType dumpType, ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport")
HRESULT MrmCreateConfig(MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, 
                        const(wchar)* outputXmlFile);

@DllImport("MrmSupport")
HRESULT MrmCreateConfigInMemory(MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, 
                                ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("KERNEL32")
int lstrcmpA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32")
int lstrcmpW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32")
int lstrcmpiA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32")
int lstrcmpiW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32")
byte* lstrcpynA(const(char)* lpString1, const(char)* lpString2, int iMaxLength);

@DllImport("KERNEL32")
ushort* lstrcpynW(const(wchar)* lpString1, const(wchar)* lpString2, int iMaxLength);

@DllImport("KERNEL32")
byte* lstrcpyA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32")
ushort* lstrcpyW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32")
byte* lstrcatA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32")
ushort* lstrcatW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32")
int lstrlenA(const(char)* lpString);

@DllImport("KERNEL32")
int lstrlenW(const(wchar)* lpString);

@DllImport("KERNEL32")
ptrdiff_t FindResourceA(ptrdiff_t hModule, const(char)* lpName, const(char)* lpType);

@DllImport("KERNEL32")
ptrdiff_t FindResourceExA(ptrdiff_t hModule, const(char)* lpType, const(char)* lpName, ushort wLanguage);

@DllImport("KERNEL32")
BOOL EnumResourceTypesA(ptrdiff_t hModule, ENUMRESTYPEPROCA lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumResourceTypesW(ptrdiff_t hModule, ENUMRESTYPEPROCW lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumResourceNamesA(ptrdiff_t hModule, const(char)* lpType, ENUMRESNAMEPROCA lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumResourceLanguagesA(ptrdiff_t hModule, const(char)* lpType, const(char)* lpName, 
                            ENUMRESLANGPROCA lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
BOOL EnumResourceLanguagesW(ptrdiff_t hModule, const(wchar)* lpType, const(wchar)* lpName, 
                            ENUMRESLANGPROCW lpEnumFunc, ptrdiff_t lParam);

@DllImport("KERNEL32")
HANDLE BeginUpdateResourceA(const(char)* pFileName, BOOL bDeleteExistingResources);

@DllImport("KERNEL32")
HANDLE BeginUpdateResourceW(const(wchar)* pFileName, BOOL bDeleteExistingResources);

@DllImport("KERNEL32")
BOOL UpdateResourceA(HANDLE hUpdate, const(char)* lpType, const(char)* lpName, ushort wLanguage, char* lpData, 
                     uint cb);

@DllImport("KERNEL32")
BOOL UpdateResourceW(HANDLE hUpdate, const(wchar)* lpType, const(wchar)* lpName, ushort wLanguage, char* lpData, 
                     uint cb);

@DllImport("KERNEL32")
BOOL EndUpdateResourceA(HANDLE hUpdate, BOOL fDiscard);

@DllImport("KERNEL32")
BOOL EndUpdateResourceW(HANDLE hUpdate, BOOL fDiscard);


