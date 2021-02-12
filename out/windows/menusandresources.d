module windows.menusandresources;

public import windows.com;
public import windows.displaydevices;
public import windows.gdi;
public import windows.shell;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

alias HACCEL = int;
alias HMENU = int;
struct MESSAGE_RESOURCE_ENTRY
{
    ushort Length;
    ushort Flags;
    ubyte Text;
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
    MESSAGE_RESOURCE_BLOCK Blocks;
}

alias ENUMRESNAMEPROCA = extern(Windows) BOOL function(int hModule, const(char)* lpType, const(char)* lpName, int lParam);
alias ENUMRESNAMEPROCW = extern(Windows) BOOL function(int hModule, const(wchar)* lpType, const(wchar)* lpName, int lParam);
alias ENUMRESTYPEPROCA = extern(Windows) BOOL function(int hModule, const(char)* lpType, int lParam);
alias ENUMRESTYPEPROCW = extern(Windows) BOOL function(int hModule, const(wchar)* lpType, int lParam);
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

@DllImport("KERNEL32.dll")
BOOL FreeResource(int hResData);

@DllImport("KERNEL32.dll")
int LoadResource(int hModule, int hResInfo);

@DllImport("USER32.dll")
int LoadStringA(HINSTANCE hInstance, uint uID, const(char)* lpBuffer, int cchBufferMax);

@DllImport("USER32.dll")
int LoadStringW(HINSTANCE hInstance, uint uID, const(wchar)* lpBuffer, int cchBufferMax);

@DllImport("KERNEL32.dll")
void* LockResource(int hResData);

@DllImport("KERNEL32.dll")
uint SizeofResource(int hModule, int hResInfo);

@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesExA(int hModule, const(char)* lpType, const(char)* lpName, ENUMRESLANGPROCA lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesExW(int hModule, const(wchar)* lpType, const(wchar)* lpName, ENUMRESLANGPROCW lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesExA(int hModule, const(char)* lpType, ENUMRESNAMEPROCA lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesExW(int hModule, const(wchar)* lpType, ENUMRESNAMEPROCW lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesExA(int hModule, ENUMRESTYPEPROCA lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesExW(int hModule, ENUMRESTYPEPROCW lpEnumFunc, int lParam, uint dwFlags, ushort LangId);

@DllImport("USER32.dll")
int wvsprintfA(const(char)* param0, const(char)* param1, byte* arglist);

@DllImport("USER32.dll")
int wvsprintfW(const(wchar)* param0, const(wchar)* param1, byte* arglist);

@DllImport("USER32.dll")
int wsprintfA(const(char)* param0, const(char)* param1);

@DllImport("USER32.dll")
int wsprintfW(const(wchar)* param0, const(wchar)* param1);

@DllImport("USER32.dll")
BOOL SetMessageQueue(int cMessagesMax);

@DllImport("USER32.dll")
int BroadcastSystemMessageA(uint flags, uint* lpInfo, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL IsMenu(HMENU hMenu);

@DllImport("USER32.dll")
BOOL UpdateLayeredWindowIndirect(HWND hWnd, const(UPDATELAYEREDWINDOWINFO)* pULWInfo);

@DllImport("USER32.dll")
LRESULT DefDlgProcA(HWND hDlg, uint Msg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL CharToOemA(const(char)* pSrc, const(char)* pDst);

@DllImport("USER32.dll")
BOOL CharToOemW(const(wchar)* pSrc, const(char)* pDst);

@DllImport("USER32.dll")
BOOL OemToCharA(const(char)* pSrc, const(char)* pDst);

@DllImport("USER32.dll")
BOOL OemToCharW(const(char)* pSrc, const(wchar)* pDst);

@DllImport("USER32.dll")
BOOL CharToOemBuffA(const(char)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32.dll")
BOOL CharToOemBuffW(const(wchar)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32.dll")
BOOL OemToCharBuffA(const(char)* lpszSrc, const(char)* lpszDst, uint cchDstLength);

@DllImport("USER32.dll")
BOOL OemToCharBuffW(const(char)* lpszSrc, const(wchar)* lpszDst, uint cchDstLength);

@DllImport("USER32.dll")
byte* CharUpperA(const(char)* lpsz);

@DllImport("USER32.dll")
ushort* CharUpperW(const(wchar)* lpsz);

@DllImport("USER32.dll")
uint CharUpperBuffA(const(char)* lpsz, uint cchLength);

@DllImport("USER32.dll")
uint CharUpperBuffW(const(wchar)* lpsz, uint cchLength);

@DllImport("USER32.dll")
byte* CharLowerA(const(char)* lpsz);

@DllImport("USER32.dll")
ushort* CharLowerW(const(wchar)* lpsz);

@DllImport("USER32.dll")
uint CharLowerBuffA(const(char)* lpsz, uint cchLength);

@DllImport("USER32.dll")
uint CharLowerBuffW(const(wchar)* lpsz, uint cchLength);

@DllImport("USER32.dll")
byte* CharNextA(const(char)* lpsz);

@DllImport("USER32.dll")
ushort* CharNextW(const(wchar)* lpsz);

@DllImport("USER32.dll")
byte* CharPrevA(const(char)* lpszStart, const(char)* lpszCurrent);

@DllImport("USER32.dll")
ushort* CharPrevW(const(wchar)* lpszStart, const(wchar)* lpszCurrent);

@DllImport("USER32.dll")
byte* CharNextExA(ushort CodePage, const(char)* lpCurrentChar, uint dwFlags);

@DllImport("USER32.dll")
byte* CharPrevExA(ushort CodePage, const(char)* lpStart, const(char)* lpCurrentChar, uint dwFlags);

@DllImport("USER32.dll")
BOOL IsCharAlphaA(byte ch);

@DllImport("USER32.dll")
BOOL IsCharAlphaW(ushort ch);

@DllImport("USER32.dll")
BOOL IsCharAlphaNumericA(byte ch);

@DllImport("USER32.dll")
BOOL IsCharAlphaNumericW(ushort ch);

@DllImport("USER32.dll")
BOOL IsCharUpperA(byte ch);

@DllImport("USER32.dll")
BOOL IsCharUpperW(ushort ch);

@DllImport("USER32.dll")
BOOL IsCharLowerA(byte ch);

@DllImport("USER32.dll")
HACCEL LoadAcceleratorsA(HINSTANCE hInstance, const(char)* lpTableName);

@DllImport("USER32.dll")
HACCEL LoadAcceleratorsW(HINSTANCE hInstance, const(wchar)* lpTableName);

@DllImport("USER32.dll")
HACCEL CreateAcceleratorTableA(char* paccel, int cAccel);

@DllImport("USER32.dll")
HACCEL CreateAcceleratorTableW(char* paccel, int cAccel);

@DllImport("USER32.dll")
BOOL DestroyAcceleratorTable(HACCEL hAccel);

@DllImport("USER32.dll")
int CopyAcceleratorTableA(HACCEL hAccelSrc, char* lpAccelDst, int cAccelEntries);

@DllImport("USER32.dll")
int CopyAcceleratorTableW(HACCEL hAccelSrc, char* lpAccelDst, int cAccelEntries);

@DllImport("USER32.dll")
int TranslateAcceleratorA(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

@DllImport("USER32.dll")
int TranslateAcceleratorW(HWND hWnd, HACCEL hAccTable, MSG* lpMsg);

@DllImport("USER32.dll")
HMENU LoadMenuA(HINSTANCE hInstance, const(char)* lpMenuName);

@DllImport("USER32.dll")
HMENU LoadMenuW(HINSTANCE hInstance, const(wchar)* lpMenuName);

@DllImport("USER32.dll")
HMENU LoadMenuIndirectA(const(void)* lpMenuTemplate);

@DllImport("USER32.dll")
HMENU LoadMenuIndirectW(const(void)* lpMenuTemplate);

@DllImport("USER32.dll")
HMENU GetMenu(HWND hWnd);

@DllImport("USER32.dll")
BOOL SetMenu(HWND hWnd, HMENU hMenu);

@DllImport("USER32.dll")
BOOL ChangeMenuA(HMENU hMenu, uint cmd, const(char)* lpszNewItem, uint cmdInsert, uint flags);

@DllImport("USER32.dll")
BOOL ChangeMenuW(HMENU hMenu, uint cmd, const(wchar)* lpszNewItem, uint cmdInsert, uint flags);

@DllImport("USER32.dll")
BOOL HiliteMenuItem(HWND hWnd, HMENU hMenu, uint uIDHiliteItem, uint uHilite);

@DllImport("USER32.dll")
int GetMenuStringA(HMENU hMenu, uint uIDItem, const(char)* lpString, int cchMax, uint flags);

@DllImport("USER32.dll")
int GetMenuStringW(HMENU hMenu, uint uIDItem, const(wchar)* lpString, int cchMax, uint flags);

@DllImport("USER32.dll")
uint GetMenuState(HMENU hMenu, uint uId, uint uFlags);

@DllImport("USER32.dll")
BOOL DrawMenuBar(HWND hWnd);

@DllImport("USER32.dll")
HMENU GetSystemMenu(HWND hWnd, BOOL bRevert);

@DllImport("USER32.dll")
HMENU CreateMenu();

@DllImport("USER32.dll")
HMENU CreatePopupMenu();

@DllImport("USER32.dll")
BOOL DestroyMenu(HMENU hMenu);

@DllImport("USER32.dll")
uint CheckMenuItem(HMENU hMenu, uint uIDCheckItem, uint uCheck);

@DllImport("USER32.dll")
BOOL EnableMenuItem(HMENU hMenu, uint uIDEnableItem, uint uEnable);

@DllImport("USER32.dll")
HMENU GetSubMenu(HMENU hMenu, int nPos);

@DllImport("USER32.dll")
uint GetMenuItemID(HMENU hMenu, int nPos);

@DllImport("USER32.dll")
int GetMenuItemCount(HMENU hMenu);

@DllImport("USER32.dll")
BOOL InsertMenuA(HMENU hMenu, uint uPosition, uint uFlags, uint uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32.dll")
BOOL InsertMenuW(HMENU hMenu, uint uPosition, uint uFlags, uint uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32.dll")
BOOL AppendMenuA(HMENU hMenu, uint uFlags, uint uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32.dll")
BOOL AppendMenuW(HMENU hMenu, uint uFlags, uint uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32.dll")
BOOL ModifyMenuA(HMENU hMnu, uint uPosition, uint uFlags, uint uIDNewItem, const(char)* lpNewItem);

@DllImport("USER32.dll")
BOOL ModifyMenuW(HMENU hMnu, uint uPosition, uint uFlags, uint uIDNewItem, const(wchar)* lpNewItem);

@DllImport("USER32.dll")
BOOL RemoveMenu(HMENU hMenu, uint uPosition, uint uFlags);

@DllImport("USER32.dll")
BOOL DeleteMenu(HMENU hMenu, uint uPosition, uint uFlags);

@DllImport("USER32.dll")
BOOL SetMenuItemBitmaps(HMENU hMenu, uint uPosition, uint uFlags, HBITMAP hBitmapUnchecked, HBITMAP hBitmapChecked);

@DllImport("USER32.dll")
int GetMenuCheckMarkDimensions();

@DllImport("USER32.dll")
BOOL TrackPopupMenu(HMENU hMenu, uint uFlags, int x, int y, int nReserved, HWND hWnd, const(RECT)* prcRect);

@DllImport("USER32.dll")
BOOL TrackPopupMenuEx(HMENU hMenu, uint uFlags, int x, int y, HWND hwnd, TPMPARAMS* lptpm);

@DllImport("USER32.dll")
BOOL GetMenuInfo(HMENU param0, MENUINFO* param1);

@DllImport("USER32.dll")
BOOL SetMenuInfo(HMENU param0, MENUINFO* param1);

@DllImport("USER32.dll")
BOOL EndMenu();

@DllImport("USER32.dll")
BOOL InsertMenuItemA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmi);

@DllImport("USER32.dll")
BOOL InsertMenuItemW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmi);

@DllImport("USER32.dll")
BOOL GetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOA* lpmii);

@DllImport("USER32.dll")
BOOL GetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPosition, MENUITEMINFOW* lpmii);

@DllImport("USER32.dll")
BOOL SetMenuItemInfoA(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOA* lpmii);

@DllImport("USER32.dll")
BOOL SetMenuItemInfoW(HMENU hmenu, uint item, BOOL fByPositon, MENUITEMINFOW* lpmii);

@DllImport("USER32.dll")
uint GetMenuDefaultItem(HMENU hMenu, uint fByPos, uint gmdiFlags);

@DllImport("USER32.dll")
BOOL SetMenuDefaultItem(HMENU hMenu, uint uItem, uint fByPos);

@DllImport("USER32.dll")
BOOL GetMenuItemRect(HWND hWnd, HMENU hMenu, uint uItem, RECT* lprcItem);

@DllImport("USER32.dll")
int MenuItemFromPoint(HWND hWnd, HMENU hMenu, POINT ptScreen);

@DllImport("USER32.dll")
uint DragObject(HWND hwndParent, HWND hwndFrom, uint fmt, uint data, HCURSOR hcur);

@DllImport("USER32.dll")
BOOL DrawIcon(HDC hDC, int X, int Y, HICON hIcon);

@DllImport("USER32.dll")
int ShowCursor(BOOL bShow);

@DllImport("USER32.dll")
BOOL SetCursorPos(int X, int Y);

@DllImport("USER32.dll")
BOOL SetPhysicalCursorPos(int X, int Y);

@DllImport("USER32.dll")
HCURSOR SetCursor(HCURSOR hCursor);

@DllImport("USER32.dll")
BOOL GetCursorPos(POINT* lpPoint);

@DllImport("USER32.dll")
BOOL GetPhysicalCursorPos(POINT* lpPoint);

@DllImport("USER32.dll")
BOOL GetClipCursor(RECT* lpRect);

@DllImport("USER32.dll")
HCURSOR GetCursor();

@DllImport("USER32.dll")
BOOL CreateCaret(HWND hWnd, HBITMAP hBitmap, int nWidth, int nHeight);

@DllImport("USER32.dll")
uint GetCaretBlinkTime();

@DllImport("USER32.dll")
BOOL SetCaretBlinkTime(uint uMSeconds);

@DllImport("USER32.dll")
BOOL DestroyCaret();

@DllImport("USER32.dll")
BOOL HideCaret(HWND hWnd);

@DllImport("USER32.dll")
BOOL ShowCaret(HWND hWnd);

@DllImport("USER32.dll")
BOOL SetCaretPos(int X, int Y);

@DllImport("USER32.dll")
BOOL GetCaretPos(POINT* lpPoint);

@DllImport("USER32.dll")
BOOL ClipCursor(const(RECT)* lpRect);

@DllImport("USER32.dll")
ushort GetWindowWord(HWND hWnd, int nIndex);

@DllImport("USER32.dll")
ushort SetWindowWord(HWND hWnd, int nIndex, ushort wNewWord);

@DllImport("USER32.dll")
int SetWindowsHookA(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32.dll")
int SetWindowsHookW(int nFilterType, HOOKPROC pfnFilterProc);

@DllImport("USER32.dll")
BOOL UnhookWindowsHook(int nCode, HOOKPROC pfnFilterProc);

@DllImport("USER32.dll")
BOOL CheckMenuRadioItem(HMENU hmenu, uint first, uint last, uint check, uint flags);

@DllImport("USER32.dll")
HCURSOR LoadCursorA(HINSTANCE hInstance, const(char)* lpCursorName);

@DllImport("USER32.dll")
HCURSOR LoadCursorW(HINSTANCE hInstance, const(wchar)* lpCursorName);

@DllImport("USER32.dll")
HCURSOR LoadCursorFromFileA(const(char)* lpFileName);

@DllImport("USER32.dll")
HCURSOR LoadCursorFromFileW(const(wchar)* lpFileName);

@DllImport("USER32.dll")
HCURSOR CreateCursor(HINSTANCE hInst, int xHotSpot, int yHotSpot, int nWidth, int nHeight, const(void)* pvANDPlane, const(void)* pvXORPlane);

@DllImport("USER32.dll")
BOOL DestroyCursor(HCURSOR hCursor);

@DllImport("USER32.dll")
BOOL SetSystemCursor(HCURSOR hcur, uint id);

@DllImport("USER32.dll")
HICON LoadIconA(HINSTANCE hInstance, const(char)* lpIconName);

@DllImport("USER32.dll")
HICON LoadIconW(HINSTANCE hInstance, const(wchar)* lpIconName);

@DllImport("USER32.dll")
uint PrivateExtractIconsA(const(char)* szFileName, int nIconIndex, int cxIcon, int cyIcon, char* phicon, char* piconid, uint nIcons, uint flags);

@DllImport("USER32.dll")
uint PrivateExtractIconsW(const(wchar)* szFileName, int nIconIndex, int cxIcon, int cyIcon, char* phicon, char* piconid, uint nIcons, uint flags);

@DllImport("USER32.dll")
HICON CreateIcon(HINSTANCE hInstance, int nWidth, int nHeight, ubyte cPlanes, ubyte cBitsPixel, const(ubyte)* lpbANDbits, const(ubyte)* lpbXORbits);

@DllImport("USER32.dll")
BOOL DestroyIcon(HICON hIcon);

@DllImport("USER32.dll")
int LookupIconIdFromDirectory(char* presbits, BOOL fIcon);

@DllImport("USER32.dll")
int LookupIconIdFromDirectoryEx(char* presbits, BOOL fIcon, int cxDesired, int cyDesired, uint Flags);

@DllImport("USER32.dll")
HICON CreateIconFromResource(char* presbits, uint dwResSize, BOOL fIcon, uint dwVer);

@DllImport("USER32.dll")
HICON CreateIconFromResourceEx(char* presbits, uint dwResSize, BOOL fIcon, uint dwVer, int cxDesired, int cyDesired, uint Flags);

@DllImport("USER32.dll")
HANDLE LoadImageA(HINSTANCE hInst, const(char)* name, uint type, int cx, int cy, uint fuLoad);

@DllImport("USER32.dll")
HANDLE LoadImageW(HINSTANCE hInst, const(wchar)* name, uint type, int cx, int cy, uint fuLoad);

@DllImport("USER32.dll")
HANDLE CopyImage(HANDLE h, uint type, int cx, int cy, uint flags);

@DllImport("USER32.dll")
BOOL DrawIconEx(HDC hdc, int xLeft, int yTop, HICON hIcon, int cxWidth, int cyWidth, uint istepIfAniCur, HBRUSH hbrFlickerFreeDraw, uint diFlags);

@DllImport("USER32.dll")
HICON CreateIconIndirect(ICONINFO* piconinfo);

@DllImport("USER32.dll")
HICON CopyIcon(HICON hIcon);

@DllImport("USER32.dll")
BOOL GetIconInfo(HICON hIcon, ICONINFO* piconinfo);

@DllImport("USER32.dll")
BOOL GetIconInfoExA(HICON hicon, ICONINFOEXA* piconinfo);

@DllImport("USER32.dll")
BOOL GetIconInfoExW(HICON hicon, ICONINFOEXW* piconinfo);

@DllImport("USER32.dll")
void SetDebugErrorLevel(uint dwLevel);

@DllImport("USER32.dll")
BOOL CancelShutdown();

@DllImport("USER32.dll")
BOOL InheritWindowMonitor(HWND hwnd, HWND hwndInherit);

@DllImport("USER32.dll")
int GetDpiAwarenessContextForProcess(HANDLE hProcess);

@DllImport("USER32.dll")
BOOL GetCursorInfo(CURSORINFO* pci);

@DllImport("USER32.dll")
BOOL GetMenuBarInfo(HWND hwnd, int idObject, int idItem, MENUBARINFO* pmbi);

@DllImport("USER32.dll")
uint RealGetWindowClassA(HWND hwnd, const(char)* ptszClassName, uint cchClassNameMax);

@DllImport("VERSION.dll")
uint VerFindFileA(uint uFlags, const(char)* szFileName, const(char)* szWinDir, const(char)* szAppDir, const(char)* szCurDir, uint* puCurDirLen, const(char)* szDestDir, uint* puDestDirLen);

@DllImport("VERSION.dll")
uint VerFindFileW(uint uFlags, const(wchar)* szFileName, const(wchar)* szWinDir, const(wchar)* szAppDir, const(wchar)* szCurDir, uint* puCurDirLen, const(wchar)* szDestDir, uint* puDestDirLen);

@DllImport("VERSION.dll")
uint VerInstallFileA(uint uFlags, const(char)* szSrcFileName, const(char)* szDestFileName, const(char)* szSrcDir, const(char)* szDestDir, const(char)* szCurDir, const(char)* szTmpFile, uint* puTmpFileLen);

@DllImport("VERSION.dll")
uint VerInstallFileW(uint uFlags, const(wchar)* szSrcFileName, const(wchar)* szDestFileName, const(wchar)* szSrcDir, const(wchar)* szDestDir, const(wchar)* szCurDir, const(wchar)* szTmpFile, uint* puTmpFileLen);

@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeA(const(char)* lptstrFilename, uint* lpdwHandle);

@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeW(const(wchar)* lptstrFilename, uint* lpdwHandle);

@DllImport("VERSION.dll")
BOOL GetFileVersionInfoA(const(char)* lptstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION.dll")
BOOL GetFileVersionInfoW(const(wchar)* lptstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeExA(uint dwFlags, const(char)* lpwstrFilename, uint* lpdwHandle);

@DllImport("VERSION.dll")
uint GetFileVersionInfoSizeExW(uint dwFlags, const(wchar)* lpwstrFilename, uint* lpdwHandle);

@DllImport("VERSION.dll")
BOOL GetFileVersionInfoExA(uint dwFlags, const(char)* lpwstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("VERSION.dll")
BOOL GetFileVersionInfoExW(uint dwFlags, const(wchar)* lpwstrFilename, uint dwHandle, uint dwLen, char* lpData);

@DllImport("KERNEL32.dll")
uint VerLanguageNameA(uint wLang, const(char)* szLang, uint cchLang);

@DllImport("KERNEL32.dll")
uint VerLanguageNameW(uint wLang, const(wchar)* szLang, uint cchLang);

@DllImport("VERSION.dll")
BOOL VerQueryValueA(void* pBlock, const(char)* lpSubBlock, void** lplpBuffer, uint* puLen);

@DllImport("VERSION.dll")
BOOL VerQueryValueW(void* pBlock, const(wchar)* lpSubBlock, void** lplpBuffer, uint* puLen);

@DllImport("MrmSupport.dll")
HRESULT CreateResourceIndexer(const(wchar)* projectRoot, const(wchar)* extensionDllPath, void** ppResourceIndexer);

@DllImport("MrmSupport.dll")
void DestroyResourceIndexer(void* resourceIndexer);

@DllImport("MrmSupport.dll")
HRESULT IndexFilePath(void* resourceIndexer, const(wchar)* filePath, ushort** ppResourceUri, uint* pQualifierCount, char* ppQualifiers);

@DllImport("MrmSupport.dll")
void DestroyIndexedResults(const(wchar)* resourceUri, uint qualifierCount, char* qualifiers);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceIndexer(const(wchar)* packageFamilyName, const(wchar)* projectRoot, MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaFile(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, const(wchar)* schemaFile, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceIndexerFromPreviousPriFile(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, const(wchar)* priFile, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceIndexerFromPreviousSchemaData(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, char* schemaXmlData, uint schemaXmlSize, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceIndexerFromPreviousPriData(const(wchar)* projectRoot, MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, char* priData, uint priSize, MrmResourceIndexerHandle* indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmIndexString(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, const(wchar)* resourceString, const(wchar)* qualifiers);

@DllImport("MrmSupport.dll")
HRESULT MrmIndexEmbeddedData(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, char* embeddedData, uint embeddedDataSize, const(wchar)* qualifiers);

@DllImport("MrmSupport.dll")
HRESULT MrmIndexFile(MrmResourceIndexerHandle indexer, const(wchar)* resourceUri, const(wchar)* filePath, const(wchar)* qualifiers);

@DllImport("MrmSupport.dll")
HRESULT MrmIndexFileAutoQualifiers(MrmResourceIndexerHandle indexer, const(wchar)* filePath);

@DllImport("MrmSupport.dll")
HRESULT MrmIndexResourceContainerAutoQualifiers(MrmResourceIndexerHandle indexer, const(wchar)* containerPath);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceFile(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, MrmPackagingOptions packagingOptions, const(wchar)* outputDirectory);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateResourceFileInMemory(MrmResourceIndexerHandle indexer, MrmPackagingMode packagingMode, MrmPackagingOptions packagingOptions, ubyte** outputPriData, uint* outputPriSize);

@DllImport("MrmSupport.dll")
HRESULT MrmPeekResourceIndexerMessages(MrmResourceIndexerHandle handle, char* messages, uint* numMsgs);

@DllImport("MrmSupport.dll")
HRESULT MrmDestroyIndexerAndMessages(MrmResourceIndexerHandle indexer);

@DllImport("MrmSupport.dll")
HRESULT MrmFreeMemory(ubyte* data);

@DllImport("MrmSupport.dll")
HRESULT MrmDumpPriFile(const(wchar)* indexFileName, const(wchar)* schemaPriFile, MrmDumpType dumpType, const(wchar)* outputXmlFile);

@DllImport("MrmSupport.dll")
HRESULT MrmDumpPriFileInMemory(const(wchar)* indexFileName, const(wchar)* schemaPriFile, MrmDumpType dumpType, ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport.dll")
HRESULT MrmDumpPriDataInMemory(char* inputPriData, uint inputPriSize, char* schemaPriData, uint schemaPriSize, MrmDumpType dumpType, ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateConfig(MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, const(wchar)* outputXmlFile);

@DllImport("MrmSupport.dll")
HRESULT MrmCreateConfigInMemory(MrmPlatformVersion platformVersion, const(wchar)* defaultQualifiers, ubyte** outputXmlData, uint* outputXmlSize);

@DllImport("KERNEL32.dll")
int lstrcmpA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32.dll")
int lstrcmpW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32.dll")
int lstrcmpiA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32.dll")
int lstrcmpiW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32.dll")
byte* lstrcpynA(const(char)* lpString1, const(char)* lpString2, int iMaxLength);

@DllImport("KERNEL32.dll")
ushort* lstrcpynW(const(wchar)* lpString1, const(wchar)* lpString2, int iMaxLength);

@DllImport("KERNEL32.dll")
byte* lstrcpyA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32.dll")
ushort* lstrcpyW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32.dll")
byte* lstrcatA(const(char)* lpString1, const(char)* lpString2);

@DllImport("KERNEL32.dll")
ushort* lstrcatW(const(wchar)* lpString1, const(wchar)* lpString2);

@DllImport("KERNEL32.dll")
int lstrlenA(const(char)* lpString);

@DllImport("KERNEL32.dll")
int lstrlenW(const(wchar)* lpString);

@DllImport("KERNEL32.dll")
int FindResourceA(int hModule, const(char)* lpName, const(char)* lpType);

@DllImport("KERNEL32.dll")
int FindResourceExA(int hModule, const(char)* lpType, const(char)* lpName, ushort wLanguage);

@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesA(int hModule, ENUMRESTYPEPROCA lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumResourceTypesW(int hModule, ENUMRESTYPEPROCW lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumResourceNamesA(int hModule, const(char)* lpType, ENUMRESNAMEPROCA lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesA(int hModule, const(char)* lpType, const(char)* lpName, ENUMRESLANGPROCA lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
BOOL EnumResourceLanguagesW(int hModule, const(wchar)* lpType, const(wchar)* lpName, ENUMRESLANGPROCW lpEnumFunc, int lParam);

@DllImport("KERNEL32.dll")
HANDLE BeginUpdateResourceA(const(char)* pFileName, BOOL bDeleteExistingResources);

@DllImport("KERNEL32.dll")
HANDLE BeginUpdateResourceW(const(wchar)* pFileName, BOOL bDeleteExistingResources);

@DllImport("KERNEL32.dll")
BOOL UpdateResourceA(HANDLE hUpdate, const(char)* lpType, const(char)* lpName, ushort wLanguage, char* lpData, uint cb);

@DllImport("KERNEL32.dll")
BOOL UpdateResourceW(HANDLE hUpdate, const(wchar)* lpType, const(wchar)* lpName, ushort wLanguage, char* lpData, uint cb);

@DllImport("KERNEL32.dll")
BOOL EndUpdateResourceA(HANDLE hUpdate, BOOL fDiscard);

@DllImport("KERNEL32.dll")
BOOL EndUpdateResourceW(HANDLE hUpdate, BOOL fDiscard);

alias WNDPROC = extern(Windows) LRESULT function(HWND param0, uint param1, WPARAM param2, LPARAM param3);
alias WNDENUMPROC = extern(Windows) BOOL function(HWND param0, LPARAM param1);
alias PROPENUMPROC = extern(Windows) BOOL function();
alias PROPENUMPROCEX = extern(Windows) BOOL function();
alias EDITWORDBREAKPROC = extern(Windows) int function();
alias NAMEENUMPROCA = extern(Windows) BOOL function(const(char)* param0, LPARAM param1);
alias NAMEENUMPROCW = extern(Windows) BOOL function(const(wchar)* param0, LPARAM param1);
alias WINSTAENUMPROCA = extern(Windows) BOOL function();
alias DESKTOPENUMPROCA = extern(Windows) BOOL function();
alias WINSTAENUMPROCW = extern(Windows) BOOL function();
alias DESKTOPENUMPROCW = extern(Windows) BOOL function();
alias WINSTAENUMPROC = extern(Windows) BOOL function();
alias DESKTOPENUMPROC = extern(Windows) BOOL function();
struct SHELLHOOKINFO
{
    HWND hwnd;
    RECT rc;
}

struct HARDWAREHOOKSTRUCT
{
    HWND hwnd;
    uint message;
    WPARAM wParam;
    LPARAM lParam;
}

struct MDINEXTMENU
{
    HMENU hmenuIn;
    HMENU hmenuNext;
    HWND hwndNext;
}

struct ACCEL
{
    ubyte fVirt;
    ushort key;
    ushort cmd;
}

alias PREGISTERCLASSNAMEW = extern(Windows) ubyte function(const(wchar)* param0);
struct HTOUCHINPUT__
{
    int unused;
}

enum POINTER_INPUT_TYPE
{
    PT_POINTER = 1,
    PT_TOUCH = 2,
    PT_PEN = 3,
    PT_MOUSE = 4,
    PT_TOUCHPAD = 5,
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
    uint cbSize;
    uint fMask;
    uint dwStyle;
    uint cyMax;
    HBRUSH hbrBack;
    uint dwContextHelpID;
    uint dwMenuData;
}

struct MENUGETOBJECTINFO
{
    uint dwFlags;
    uint uPos;
    HMENU hmenu;
    void* riid;
    void* pvObj;
}

struct MENUITEMINFOA
{
    uint cbSize;
    uint fMask;
    uint fType;
    uint fState;
    uint wID;
    HMENU hSubMenu;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    uint dwItemData;
    const(char)* dwTypeData;
    uint cch;
    HBITMAP hbmpItem;
}

struct MENUITEMINFOW
{
    uint cbSize;
    uint fMask;
    uint fType;
    uint fState;
    uint wID;
    HMENU hSubMenu;
    HBITMAP hbmpChecked;
    HBITMAP hbmpUnchecked;
    uint dwItemData;
    const(wchar)* dwTypeData;
    uint cch;
    HBITMAP hbmpItem;
}

struct DROPSTRUCT
{
    HWND hwndSource;
    HWND hwndSink;
    uint wFmt;
    uint dwData;
    POINT ptDrop;
    uint dwControlData;
}

alias MSGBOXCALLBACK = extern(Windows) void function(HELPINFO* lpHelpInfo);
struct MENUITEMTEMPLATEHEADER
{
    ushort versionNumber;
    ushort offset;
}

struct MENUITEMTEMPLATE
{
    ushort mtOption;
    ushort mtID;
    ushort mtString;
}

struct ICONINFO
{
    BOOL fIcon;
    uint xHotspot;
    uint yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
}

struct CURSORSHAPE
{
    int xHotSpot;
    int yHotSpot;
    int cx;
    int cy;
    int cbWidth;
    ubyte Planes;
    ubyte BitsPixel;
}

struct ICONINFOEXA
{
    uint cbSize;
    BOOL fIcon;
    uint xHotspot;
    uint yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
    ushort wResID;
    byte szModName;
    byte szResName;
}

struct ICONINFOEXW
{
    uint cbSize;
    BOOL fIcon;
    uint xHotspot;
    uint yHotspot;
    HBITMAP hbmMask;
    HBITMAP hbmColor;
    ushort wResID;
    ushort szModName;
    ushort szResName;
}

enum EDIT_CONTROL_FEATURE
{
    EDIT_CONTROL_FEATURE_ENTERPRISE_DATA_PROTECTION_PASTE_SUPPORT = 0,
    EDIT_CONTROL_FEATURE_PASTE_NOTIFICATIONS = 1,
}

struct TouchPredictionParameters
{
    uint cbSize;
    uint dwLatency;
    uint dwSampleTime;
    uint bUseHWTimeStamp;
}

enum HANDEDNESS
{
    HANDEDNESS_LEFT = 0,
    HANDEDNESS_RIGHT = 1,
}

struct ICONMETRICSA
{
    uint cbSize;
    int iHorzSpacing;
    int iVertSpacing;
    int iTitleWrap;
    LOGFONTA lfFont;
}

struct ICONMETRICSW
{
    uint cbSize;
    int iHorzSpacing;
    int iVertSpacing;
    int iTitleWrap;
    LOGFONTW lfFont;
}

struct CURSORINFO
{
    uint cbSize;
    uint flags;
    HCURSOR hCursor;
    POINT ptScreenPos;
}

struct MENUBARINFO
{
    uint cbSize;
    RECT rcBar;
    HMENU hMenu;
    HWND hwndMenu;
    int _bitfield;
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

enum MrmPlatformVersion
{
    MrmPlatformVersion_Default = 0,
    MrmPlatformVersion_Windows10_0_0_0 = 17432576,
    MrmPlatformVersion_Windows10_0_0_5 = 17432581,
}

struct MrmResourceIndexerHandle
{
    void* handle;
}

enum MrmPackagingMode
{
    MrmPackagingModeStandaloneFile = 0,
    MrmPackagingModeAutoSplit = 1,
    MrmPackagingModeResourcePack = 2,
}

enum MrmPackagingOptions
{
    MrmPackagingOptionsNone = 0,
    MrmPackagingOptionsOmitSchemaFromResourcePacks = 1,
    MrmPackagingOptionsSplitLanguageVariants = 2,
}

enum MrmDumpType
{
    MrmDumpType_Basic = 0,
    MrmDumpType_Detailed = 1,
    MrmDumpType_Schema = 2,
}

enum MrmResourceIndexerMessageSeverity
{
    MrmResourceIndexerMessageSeverityVerbose = 0,
    MrmResourceIndexerMessageSeverityInfo = 1,
    MrmResourceIndexerMessageSeverityWarning = 2,
    MrmResourceIndexerMessageSeverityError = 3,
}

struct MrmResourceIndexerMessage
{
    MrmResourceIndexerMessageSeverity severity;
    uint id;
    const(wchar)* text;
}

