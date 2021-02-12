module windows.shell;

public import system;
public import windows.activedirectory;
public import windows.audio;
public import windows.automation;
public import windows.com;
public import windows.controls;
public import windows.debug;
public import windows.displaydevices;
public import windows.filesystem;
public import windows.gdi;
public import windows.intl;
public import windows.iphelper;
public import windows.menusandresources;
public import windows.search;
public import windows.security;
public import windows.structuredstorage;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.windowsprogramming;
public import windows.windowspropertiessystem;

extern(Windows):

struct LOGFONTA
{
    int lfHeight;
    int lfWidth;
    int lfEscapement;
    int lfOrientation;
    int lfWeight;
    ubyte lfItalic;
    ubyte lfUnderline;
    ubyte lfStrikeOut;
    ubyte lfCharSet;
    ubyte lfOutPrecision;
    ubyte lfClipPrecision;
    ubyte lfQuality;
    ubyte lfPitchAndFamily;
    byte lfFaceName;
}

struct LOGFONTW
{
    int lfHeight;
    int lfWidth;
    int lfEscapement;
    int lfOrientation;
    int lfWeight;
    ubyte lfItalic;
    ubyte lfUnderline;
    ubyte lfStrikeOut;
    ubyte lfCharSet;
    ubyte lfOutPrecision;
    ubyte lfClipPrecision;
    ubyte lfQuality;
    ubyte lfPitchAndFamily;
    ushort lfFaceName;
}

struct SOFTDISTINFO
{
    uint cbSize;
    uint dwFlags;
    uint dwAdState;
    const(wchar)* szTitle;
    const(wchar)* szAbstract;
    const(wchar)* szHREF;
    uint dwInstalledVersionMS;
    uint dwInstalledVersionLS;
    uint dwUpdateVersionMS;
    uint dwUpdateVersionLS;
    uint dwAdvertisedVersionMS;
    uint dwAdvertisedVersionLS;
    uint dwReserved;
}

alias ShFindChangeNotifcationHandle = int;
alias SUBCLASSPROC = extern(Windows) LRESULT function(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, uint uIdSubclass, uint dwRefData);
@DllImport("COMCTL32.dll")
BOOL SetWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, uint uIdSubclass, uint dwRefData);

@DllImport("COMCTL32.dll")
BOOL GetWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, uint uIdSubclass, uint* pdwRefData);

@DllImport("COMCTL32.dll")
BOOL RemoveWindowSubclass(HWND hWnd, SUBCLASSPROC pfnSubclass, uint uIdSubclass);

@DllImport("COMCTL32.dll")
LRESULT DefSubclassProc(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("USER32.dll")
BOOL SetWindowContextHelpId(HWND param0, uint param1);

@DllImport("USER32.dll")
uint GetWindowContextHelpId(HWND param0);

@DllImport("USER32.dll")
BOOL SetMenuContextHelpId(HMENU param0, uint param1);

@DllImport("USER32.dll")
uint GetMenuContextHelpId(HMENU param0);

@DllImport("USER32.dll")
BOOL WinHelpA(HWND hWndMain, const(char)* lpszHelp, uint uCommand, uint dwData);

@DllImport("USER32.dll")
BOOL WinHelpW(HWND hWndMain, const(wchar)* lpszHelp, uint uCommand, uint dwData);

@DllImport("USERENV.dll")
BOOL LoadUserProfileA(HANDLE hToken, PROFILEINFOA* lpProfileInfo);

@DllImport("USERENV.dll")
BOOL LoadUserProfileW(HANDLE hToken, PROFILEINFOW* lpProfileInfo);

@DllImport("USERENV.dll")
BOOL UnloadUserProfile(HANDLE hToken, HANDLE hProfile);

@DllImport("USERENV.dll")
BOOL GetProfilesDirectoryA(const(char)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetProfilesDirectoryW(const(wchar)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetProfileType(uint* dwFlags);

@DllImport("USERENV.dll")
BOOL DeleteProfileA(const(char)* lpSidString, const(char)* lpProfilePath, const(char)* lpComputerName);

@DllImport("USERENV.dll")
BOOL DeleteProfileW(const(wchar)* lpSidString, const(wchar)* lpProfilePath, const(wchar)* lpComputerName);

@DllImport("USERENV.dll")
HRESULT CreateProfile(const(wchar)* pszUserSid, const(wchar)* pszUserName, const(wchar)* pszProfilePath, uint cchProfilePath);

@DllImport("USERENV.dll")
BOOL GetDefaultUserProfileDirectoryA(const(char)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetDefaultUserProfileDirectoryW(const(wchar)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetAllUsersProfileDirectoryA(const(char)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetAllUsersProfileDirectoryW(const(wchar)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetUserProfileDirectoryA(HANDLE hToken, const(char)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL GetUserProfileDirectoryW(HANDLE hToken, const(wchar)* lpProfileDir, uint* lpcchSize);

@DllImport("USERENV.dll")
BOOL CreateEnvironmentBlock(void** lpEnvironment, HANDLE hToken, BOOL bInherit);

@DllImport("USERENV.dll")
BOOL DestroyEnvironmentBlock(void* lpEnvironment);

@DllImport("USERENV.dll")
BOOL ExpandEnvironmentStringsForUserA(HANDLE hToken, const(char)* lpSrc, const(char)* lpDest, uint dwSize);

@DllImport("USERENV.dll")
BOOL ExpandEnvironmentStringsForUserW(HANDLE hToken, const(wchar)* lpSrc, const(wchar)* lpDest, uint dwSize);

@DllImport("USERENV.dll")
HRESULT CreateAppContainerProfile(const(wchar)* pszAppContainerName, const(wchar)* pszDisplayName, const(wchar)* pszDescription, char* pCapabilities, uint dwCapabilityCount, void** ppSidAppContainerSid);

@DllImport("USERENV.dll")
HRESULT DeleteAppContainerProfile(const(wchar)* pszAppContainerName);

@DllImport("USERENV.dll")
HRESULT GetAppContainerRegistryLocation(uint desiredAccess, HKEY* phAppContainerKey);

@DllImport("USERENV.dll")
HRESULT GetAppContainerFolderPath(const(wchar)* pszAppContainerSid, ushort** ppszPath);

@DllImport("USERENV.dll")
HRESULT DeriveAppContainerSidFromAppContainerName(const(wchar)* pszAppContainerName, void** ppsidAppContainerSid);

@DllImport("USERENV.dll")
HRESULT DeriveRestrictedAppContainerSidFromAppContainerSidAndRestrictedName(void* psidAppContainerSid, const(wchar)* pszRestrictedAppContainerName, void** ppsidRestrictedAppContainerSid);

@DllImport("SHELL32.dll")
ushort** CommandLineToArgvW(const(wchar)* lpCmdLine, int* pNumArgs);

@DllImport("SHELL32.dll")
uint DragQueryFileA(HDROP__* hDrop, uint iFile, const(char)* lpszFile, uint cch);

@DllImport("SHELL32.dll")
uint DragQueryFileW(HDROP__* hDrop, uint iFile, const(wchar)* lpszFile, uint cch);

@DllImport("SHELL32.dll")
BOOL DragQueryPoint(HDROP__* hDrop, POINT* ppt);

@DllImport("SHELL32.dll")
void DragFinish(HDROP__* hDrop);

@DllImport("SHELL32.dll")
void DragAcceptFiles(HWND hWnd, BOOL fAccept);

@DllImport("SHELL32.dll")
HINSTANCE ShellExecuteA(HWND hwnd, const(char)* lpOperation, const(char)* lpFile, const(char)* lpParameters, const(char)* lpDirectory, int nShowCmd);

@DllImport("SHELL32.dll")
HINSTANCE ShellExecuteW(HWND hwnd, const(wchar)* lpOperation, const(wchar)* lpFile, const(wchar)* lpParameters, const(wchar)* lpDirectory, int nShowCmd);

@DllImport("SHELL32.dll")
HINSTANCE FindExecutableA(const(char)* lpFile, const(char)* lpDirectory, const(char)* lpResult);

@DllImport("SHELL32.dll")
HINSTANCE FindExecutableW(const(wchar)* lpFile, const(wchar)* lpDirectory, const(wchar)* lpResult);

@DllImport("SHELL32.dll")
int ShellAboutA(HWND hWnd, const(char)* szApp, const(char)* szOtherStuff, HICON hIcon);

@DllImport("SHELL32.dll")
int ShellAboutW(HWND hWnd, const(wchar)* szApp, const(wchar)* szOtherStuff, HICON hIcon);

@DllImport("SHELL32.dll")
HICON DuplicateIcon(HINSTANCE hInst, HICON hIcon);

@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconA(HINSTANCE hInst, const(char)* pszIconPath, ushort* piIcon);

@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconW(HINSTANCE hInst, const(wchar)* pszIconPath, ushort* piIcon);

@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconExA(HINSTANCE hInst, const(char)* pszIconPath, ushort* piIconIndex, ushort* piIconId);

@DllImport("SHELL32.dll")
HICON ExtractAssociatedIconExW(HINSTANCE hInst, const(wchar)* pszIconPath, ushort* piIconIndex, ushort* piIconId);

@DllImport("SHELL32.dll")
HICON ExtractIconA(HINSTANCE hInst, const(char)* pszExeFileName, uint nIconIndex);

@DllImport("SHELL32.dll")
HICON ExtractIconW(HINSTANCE hInst, const(wchar)* pszExeFileName, uint nIconIndex);

@DllImport("SHELL32.dll")
uint SHAppBarMessage(uint dwMessage, APPBARDATA* pData);

@DllImport("SHELL32.dll")
uint DoEnvironmentSubstA(const(char)* pszSrc, uint cchSrc);

@DllImport("SHELL32.dll")
uint DoEnvironmentSubstW(const(wchar)* pszSrc, uint cchSrc);

@DllImport("SHELL32.dll")
uint ExtractIconExA(const(char)* lpszFile, int nIconIndex, char* phiconLarge, char* phiconSmall, uint nIcons);

@DllImport("SHELL32.dll")
uint ExtractIconExW(const(wchar)* lpszFile, int nIconIndex, char* phiconLarge, char* phiconSmall, uint nIcons);

@DllImport("SHELL32.dll")
int SHFileOperationA(SHFILEOPSTRUCTA* lpFileOp);

@DllImport("SHELL32.dll")
int SHFileOperationW(SHFILEOPSTRUCTW* lpFileOp);

@DllImport("SHELL32.dll")
void SHFreeNameMappings(HANDLE hNameMappings);

@DllImport("SHELL32.dll")
BOOL ShellExecuteExA(SHELLEXECUTEINFOA* pExecInfo);

@DllImport("SHELL32.dll")
BOOL ShellExecuteExW(SHELLEXECUTEINFOW* pExecInfo);

@DllImport("SHELL32.dll")
BOOL SHCreateProcessAsUserW(SHCREATEPROCESSINFOW* pscpi);

@DllImport("SHELL32.dll")
HRESULT SHEvaluateSystemCommandTemplate(const(wchar)* pszCmdTemplate, ushort** ppszApplication, ushort** ppszCommandLine, ushort** ppszParameters);

@DllImport("SHELL32.dll")
HRESULT AssocCreateForClasses(char* rgClasses, uint cClasses, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHQueryRecycleBinA(const(char)* pszRootPath, SHQUERYRBINFO* pSHQueryRBInfo);

@DllImport("SHELL32.dll")
HRESULT SHQueryRecycleBinW(const(wchar)* pszRootPath, SHQUERYRBINFO* pSHQueryRBInfo);

@DllImport("SHELL32.dll")
HRESULT SHEmptyRecycleBinA(HWND hwnd, const(char)* pszRootPath, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHEmptyRecycleBinW(HWND hwnd, const(wchar)* pszRootPath, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHQueryUserNotificationState(QUERY_USER_NOTIFICATION_STATE* pquns);

@DllImport("SHELL32.dll")
BOOL Shell_NotifyIconA(uint dwMessage, NOTIFYICONDATAA* lpData);

@DllImport("SHELL32.dll")
BOOL Shell_NotifyIconW(uint dwMessage, NOTIFYICONDATAW* lpData);

@DllImport("SHELL32.dll")
HRESULT Shell_NotifyIconGetRect(const(NOTIFYICONIDENTIFIER)* identifier, RECT* iconLocation);

@DllImport("SHELL32.dll")
uint SHGetFileInfoA(const(char)* pszPath, uint dwFileAttributes, char* psfi, uint cbFileInfo, uint uFlags);

@DllImport("SHELL32.dll")
uint SHGetFileInfoW(const(wchar)* pszPath, uint dwFileAttributes, char* psfi, uint cbFileInfo, uint uFlags);

@DllImport("SHELL32.dll")
HRESULT SHGetStockIconInfo(SHSTOCKICONID siid, uint uFlags, SHSTOCKICONINFO* psii);

@DllImport("SHELL32.dll")
BOOL SHGetDiskFreeSpaceExA(const(char)* pszDirectoryName, ULARGE_INTEGER* pulFreeBytesAvailableToCaller, ULARGE_INTEGER* pulTotalNumberOfBytes, ULARGE_INTEGER* pulTotalNumberOfFreeBytes);

@DllImport("SHELL32.dll")
BOOL SHGetDiskFreeSpaceExW(const(wchar)* pszDirectoryName, ULARGE_INTEGER* pulFreeBytesAvailableToCaller, ULARGE_INTEGER* pulTotalNumberOfBytes, ULARGE_INTEGER* pulTotalNumberOfFreeBytes);

@DllImport("SHELL32.dll")
BOOL SHGetNewLinkInfoA(const(char)* pszLinkTo, const(char)* pszDir, const(char)* pszName, int* pfMustCopy, uint uFlags);

@DllImport("SHELL32.dll")
BOOL SHGetNewLinkInfoW(const(wchar)* pszLinkTo, const(wchar)* pszDir, const(wchar)* pszName, int* pfMustCopy, uint uFlags);

@DllImport("SHELL32.dll")
BOOL SHInvokePrinterCommandA(HWND hwnd, uint uAction, const(char)* lpBuf1, const(char)* lpBuf2, BOOL fModal);

@DllImport("SHELL32.dll")
BOOL SHInvokePrinterCommandW(HWND hwnd, uint uAction, const(wchar)* lpBuf1, const(wchar)* lpBuf2, BOOL fModal);

@DllImport("SHELL32.dll")
HRESULT SHLoadNonloadedIconOverlayIdentifiers();

@DllImport("SHELL32.dll")
HRESULT SHIsFileAvailableOffline(const(wchar)* pwszPath, uint* pdwStatus);

@DllImport("SHELL32.dll")
HRESULT SHSetLocalizedName(const(wchar)* pszPath, const(wchar)* pszResModule, int idsRes);

@DllImport("SHELL32.dll")
HRESULT SHRemoveLocalizedName(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetLocalizedName(const(wchar)* pszPath, const(wchar)* pszResModule, uint cch, int* pidsRes);

@DllImport("SHLWAPI.dll")
int ShellMessageBoxA(HINSTANCE hAppInst, HWND hWnd, const(char)* lpcText, const(char)* lpcTitle, uint fuStyle);

@DllImport("SHLWAPI.dll")
int ShellMessageBoxW(HINSTANCE hAppInst, HWND hWnd, const(wchar)* lpcText, const(wchar)* lpcTitle, uint fuStyle);

@DllImport("SHELL32.dll")
BOOL IsLFNDriveA(const(char)* pszPath);

@DllImport("SHELL32.dll")
BOOL IsLFNDriveW(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHEnumerateUnreadMailAccountsW(HKEY hKeyUser, uint dwIndex, const(wchar)* pszMailAddress, int cchMailAddress);

@DllImport("SHELL32.dll")
HRESULT SHGetUnreadMailCountW(HKEY hKeyUser, const(wchar)* pszMailAddress, uint* pdwCount, FILETIME* pFileTime, const(wchar)* pszShellExecuteCommand, int cchShellExecuteCommand);

@DllImport("SHELL32.dll")
HRESULT SHSetUnreadMailCountW(const(wchar)* pszMailAddress, uint dwCount, const(wchar)* pszShellExecuteCommand);

@DllImport("SHELL32.dll")
BOOL SHTestTokenMembership(HANDLE hToken, uint ulRID);

@DllImport("SHELL32.dll")
HRESULT SHGetImageList(int iImageList, const(Guid)* riid, void** ppvObj);

@DllImport("SHELL32.dll")
BOOL InitNetworkAddressControl();

@DllImport("SHELL32.dll")
HRESULT SHGetDriveMedia(const(wchar)* pszDrive, uint* pdwMediaContent);

@DllImport("SHELL32.dll")
ITEMIDLIST* SHSimpleIDListFromPath(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromIDList(ITEMIDLIST* pidl, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromParsingName(const(wchar)* pszPath, IBindCtx pbc, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateItemWithParent(ITEMIDLIST* pidlParent, IShellFolder psfParent, ITEMIDLIST* pidl, const(Guid)* riid, void** ppvItem);

@DllImport("SHELL32.dll")
HRESULT SHCreateItemFromRelativeName(IShellItem psiParent, const(wchar)* pszName, IBindCtx pbc, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateItemInKnownFolder(const(Guid)* kfid, uint dwKFFlags, const(wchar)* pszItem, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHGetIDListFromObject(IUnknown punk, ITEMIDLIST** ppidl);

@DllImport("SHELL32.dll")
HRESULT SHGetItemFromObject(IUnknown punk, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHGetNameFromIDList(ITEMIDLIST* pidl, SIGDN sigdnName, ushort** ppszName);

@DllImport("SHELL32.dll")
HRESULT SHGetItemFromDataObject(IDataObject pdtobj, DATAOBJ_GET_ITEM_FLAGS dwFlags, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArray(ITEMIDLIST* pidlParent, IShellFolder psf, uint cidl, char* ppidl, IShellItemArray* ppsiItemArray);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromDataObject(IDataObject pdo, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromIDLists(uint cidl, char* rgpidl, IShellItemArray* ppsiItemArray);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellItemArrayFromShellItem(IShellItem psi, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateAssociationRegistration(const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultExtractIcon(const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SetCurrentProcessExplicitAppUserModelID(const(wchar)* AppID);

@DllImport("SHELL32.dll")
HRESULT GetCurrentProcessExplicitAppUserModelID(ushort** AppID);

@DllImport("SHELL32.dll")
HRESULT SHGetTemporaryPropertyForItem(IShellItem psi, const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);

@DllImport("SHELL32.dll")
HRESULT SHSetTemporaryPropertyForItem(IShellItem psi, const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar);

@DllImport("SHELL32.dll")
HRESULT SHShowManageLibraryUI(IShellItem psiLibrary, HWND hwndOwner, const(wchar)* pszTitle, const(wchar)* pszInstruction, LIBRARYMANAGEDIALOGOPTIONS lmdOptions);

@DllImport("SHELL32.dll")
HRESULT SHResolveLibrary(IShellItem psiLibrary);

@DllImport("SHELL32.dll")
HRESULT SHAssocEnumHandlers(const(wchar)* pszExtra, ASSOC_FILTER afFilter, IEnumAssocHandlers* ppEnumHandler);

@DllImport("SHELL32.dll")
HRESULT SHAssocEnumHandlersForProtocolByApplication(const(wchar)* protocol, const(Guid)* riid, void** enumHandlers);

@DllImport("OLE32.dll")
uint HMONITOR_UserSize(uint* param0, uint param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserMarshal(uint* param0, ubyte* param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserUnmarshal(uint* param0, char* param1, int* param2);

@DllImport("OLE32.dll")
void HMONITOR_UserFree(uint* param0, int* param1);

@DllImport("OLE32.dll")
uint HMONITOR_UserSize64(uint* param0, uint param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserMarshal64(uint* param0, ubyte* param1, int* param2);

@DllImport("OLE32.dll")
ubyte* HMONITOR_UserUnmarshal64(uint* param0, char* param1, int* param2);

@DllImport("OLE32.dll")
void HMONITOR_UserFree64(uint* param0, int* param1);

@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultPropertiesOp(IShellItem psi, IFileOperation* ppFileOp);

@DllImport("SHELL32.dll")
HRESULT SHSetDefaultProperties(HWND hwnd, IShellItem psi, uint dwFileOpFlags, IFileOperationProgressSink pfops);

@DllImport("SHELL32.dll")
HRESULT SHGetMalloc(IMalloc* ppMalloc);

@DllImport("SHELL32.dll")
void* SHAlloc(uint cb);

@DllImport("SHELL32.dll")
void SHFree(void* pv);

@DllImport("SHELL32.dll")
int SHGetIconOverlayIndexA(const(char)* pszIconPath, int iIconIndex);

@DllImport("SHELL32.dll")
int SHGetIconOverlayIndexW(const(wchar)* pszIconPath, int iIconIndex);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILClone(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILCloneFirst(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILCombine(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);

@DllImport("SHELL32.dll")
void ILFree(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILGetNext(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
uint ILGetSize(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILFindChild(ITEMIDLIST* pidlParent, ITEMIDLIST* pidlChild);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILFindLastID(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
BOOL ILRemoveLastID(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
BOOL ILIsEqual(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);

@DllImport("SHELL32.dll")
BOOL ILIsParent(ITEMIDLIST* pidl1, ITEMIDLIST* pidl2, BOOL fImmediate);

@DllImport("SHELL32.dll")
HRESULT ILSaveToStream(IStream pstm, ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
HRESULT ILLoadFromStreamEx(IStream pstm, ITEMIDLIST** pidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILCreateFromPathA(const(char)* pszPath);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILCreateFromPathW(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHILCreateFromPath(const(wchar)* pszPath, ITEMIDLIST** ppidl, uint* rgfInOut);

@DllImport("SHELL32.dll")
ITEMIDLIST* ILAppendID(ITEMIDLIST* pidl, SHITEMID* pmkid, BOOL fAppend);

@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListEx(ITEMIDLIST* pidl, const(wchar)* pszPath, uint cchPath, int uOpts);

@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListA(ITEMIDLIST* pidl, const(char)* pszPath);

@DllImport("SHELL32.dll")
BOOL SHGetPathFromIDListW(ITEMIDLIST* pidl, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
int SHCreateDirectory(HWND hwnd, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
int SHCreateDirectoryExA(HWND hwnd, const(char)* pszPath, const(SECURITY_ATTRIBUTES)* psa);

@DllImport("SHELL32.dll")
int SHCreateDirectoryExW(HWND hwnd, const(wchar)* pszPath, const(SECURITY_ATTRIBUTES)* psa);

@DllImport("SHELL32.dll")
HRESULT SHOpenFolderAndSelectItems(ITEMIDLIST* pidlFolder, uint cidl, char* apidl, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellItem(ITEMIDLIST* pidlParent, IShellFolder psfParent, ITEMIDLIST* pidl, IShellItem* ppsi);

@DllImport("SHELL32.dll")
HRESULT SHGetSpecialFolderLocation(HWND hwnd, int csidl, ITEMIDLIST** ppidl);

@DllImport("SHELL32.dll")
ITEMIDLIST* SHCloneSpecialIDList(HWND hwnd, int csidl, BOOL fCreate);

@DllImport("SHELL32.dll")
BOOL SHGetSpecialFolderPathA(HWND hwnd, const(char)* pszPath, int csidl, BOOL fCreate);

@DllImport("SHELL32.dll")
BOOL SHGetSpecialFolderPathW(HWND hwnd, const(wchar)* pszPath, int csidl, BOOL fCreate);

@DllImport("SHELL32.dll")
void SHFlushSFCache();

@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathA(HWND hwnd, int csidl, HANDLE hToken, uint dwFlags, const(char)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathW(HWND hwnd, int csidl, HANDLE hToken, uint dwFlags, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetFolderLocation(HWND hwnd, int csidl, HANDLE hToken, uint dwFlags, ITEMIDLIST** ppidl);

@DllImport("SHELL32.dll")
HRESULT SHSetFolderPathA(int csidl, HANDLE hToken, uint dwFlags, const(char)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHSetFolderPathW(int csidl, HANDLE hToken, uint dwFlags, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathAndSubDirA(HWND hwnd, int csidl, HANDLE hToken, uint dwFlags, const(char)* pszSubDir, const(char)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetFolderPathAndSubDirW(HWND hwnd, int csidl, HANDLE hToken, uint dwFlags, const(wchar)* pszSubDir, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderIDList(const(Guid)* rfid, uint dwFlags, HANDLE hToken, ITEMIDLIST** ppidl);

@DllImport("SHELL32.dll")
HRESULT SHSetKnownFolderPath(const(Guid)* rfid, uint dwFlags, HANDLE hToken, const(wchar)* pszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderPath(const(Guid)* rfid, uint dwFlags, HANDLE hToken, ushort** ppszPath);

@DllImport("SHELL32.dll")
HRESULT SHGetKnownFolderItem(const(Guid)* rfid, KNOWN_FOLDER_FLAG flags, HANDLE hToken, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHGetSetFolderCustomSettings(SHFOLDERCUSTOMSETTINGS* pfcs, const(wchar)* pszPath, uint dwReadWrite);

@DllImport("SHELL32.dll")
ITEMIDLIST* SHBrowseForFolderA(BROWSEINFOA* lpbi);

@DllImport("SHELL32.dll")
ITEMIDLIST* SHBrowseForFolderW(BROWSEINFOW* lpbi);

@DllImport("SHELL32.dll")
HRESULT SHLoadInProc(const(Guid)* rclsid);

@DllImport("SHELL32.dll")
HRESULT SHGetDesktopFolder(IShellFolder* ppshf);

@DllImport("SHELL32.dll")
void SHChangeNotify(int wEventId, uint uFlags, void* dwItem1, void* dwItem2);

@DllImport("SHELL32.dll")
void SHAddToRecentDocs(uint uFlags, void* pv);

@DllImport("SHELL32.dll")
int SHHandleUpdateImage(ITEMIDLIST* pidlExtra);

@DllImport("SHELL32.dll")
void SHUpdateImageA(const(char)* pszHashItem, int iIndex, uint uFlags, int iImageIndex);

@DllImport("SHELL32.dll")
void SHUpdateImageW(const(wchar)* pszHashItem, int iIndex, uint uFlags, int iImageIndex);

@DllImport("SHELL32.dll")
uint SHChangeNotifyRegister(HWND hwnd, int fSources, int fEvents, uint wMsg, int cEntries, const(SHChangeNotifyEntry)* pshcne);

@DllImport("SHELL32.dll")
BOOL SHChangeNotifyDeregister(uint ulID);

@DllImport("SHELL32.dll")
ShFindChangeNotifcationHandle SHChangeNotification_Lock(HANDLE hChange, uint dwProcId, ITEMIDLIST*** pppidl, int* plEvent);

@DllImport("SHELL32.dll")
BOOL SHChangeNotification_Unlock(HANDLE hLock);

@DllImport("SHELL32.dll")
HRESULT SHGetRealIDL(IShellFolder psf, ITEMIDLIST* pidlSimple, ITEMIDLIST** ppidlReal);

@DllImport("SHELL32.dll")
HRESULT SHGetInstanceExplorer(IUnknown* ppunk);

@DllImport("SHELL32.dll")
HRESULT SHGetDataFromIDListA(IShellFolder psf, ITEMIDLIST* pidl, int nFormat, char* pv, int cb);

@DllImport("SHELL32.dll")
HRESULT SHGetDataFromIDListW(IShellFolder psf, ITEMIDLIST* pidl, int nFormat, char* pv, int cb);

@DllImport("SHELL32.dll")
int RestartDialog(HWND hwnd, const(wchar)* pszPrompt, uint dwReturn);

@DllImport("SHELL32.dll")
int RestartDialogEx(HWND hwnd, const(wchar)* pszPrompt, uint dwReturn, uint dwReasonCode);

@DllImport("SHELL32.dll")
HRESULT SHCoCreateInstance(const(wchar)* pszCLSID, const(Guid)* pclsid, IUnknown pUnkOuter, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHCreateDataObject(ITEMIDLIST* pidlFolder, uint cidl, char* apidl, IDataObject pdtInner, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT CIDLData_CreateFromIDArray(ITEMIDLIST* pidlFolder, uint cidl, char* apidl, IDataObject* ppdtobj);

@DllImport("SHELL32.dll")
HRESULT SHCreateStdEnumFmtEtc(uint cfmt, char* afmt, IEnumFORMATETC* ppenumFormatEtc);

@DllImport("SHELL32.dll")
HRESULT SHDoDragDrop(HWND hwnd, IDataObject pdata, IDropSource pdsrc, uint dwEffect, uint* pdwEffect);

@DllImport("SHELL32.dll")
BOOL DAD_SetDragImage(HIMAGELIST him, POINT* pptOffset);

@DllImport("SHELL32.dll")
BOOL DAD_DragEnterEx(HWND hwndTarget, const(POINT) ptStart);

@DllImport("SHELL32.dll")
BOOL DAD_DragEnterEx2(HWND hwndTarget, const(POINT) ptStart, IDataObject pdtObject);

@DllImport("SHELL32.dll")
BOOL DAD_ShowDragImage(BOOL fShow);

@DllImport("SHELL32.dll")
BOOL DAD_DragMove(POINT pt);

@DllImport("SHELL32.dll")
BOOL DAD_DragLeave();

@DllImport("SHELL32.dll")
BOOL DAD_AutoScroll(HWND hwnd, AUTO_SCROLL_DATA* pad, const(POINT)* pptNow);

@DllImport("SHELL32.dll")
BOOL ReadCabinetState(char* pcs, int cLength);

@DllImport("SHELL32.dll")
BOOL WriteCabinetState(CABINETSTATE* pcs);

@DllImport("SHELL32.dll")
BOOL PathMakeUniqueName(const(wchar)* pszUniqueName, uint cchMax, const(wchar)* pszTemplate, const(wchar)* pszLongPlate, const(wchar)* pszDir);

@DllImport("SHELL32.dll")
BOOL PathIsExe(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
int PathCleanupSpec(const(wchar)* pszDir, const(wchar)* pszSpec);

@DllImport("SHELL32.dll")
int PathResolve(const(wchar)* pszPath, ushort** dirs, uint fFlags);

@DllImport("SHELL32.dll")
BOOL GetFileNameFromBrowse(HWND hwnd, const(wchar)* pszFilePath, uint cchFilePath, const(wchar)* pszWorkingDir, const(wchar)* pszDefExt, const(wchar)* pszFilters, const(wchar)* pszTitle);

@DllImport("SHELL32.dll")
int DriveType(int iDrive);

@DllImport("SHELL32.dll")
int RealDriveType(int iDrive, BOOL fOKToHitNet);

@DllImport("SHELL32.dll")
int IsNetDrive(int iDrive);

@DllImport("SHELL32.dll")
uint Shell_MergeMenus(HMENU hmDst, HMENU hmSrc, uint uInsert, uint uIDAdjust, uint uIDAdjustMax, uint uFlags);

@DllImport("SHELL32.dll")
BOOL SHObjectProperties(HWND hwnd, uint shopObjectType, const(wchar)* pszObjectName, const(wchar)* pszPropertyPage);

@DllImport("SHELL32.dll")
uint SHFormatDrive(HWND hwnd, uint drive, uint fmtID, uint options);

@DllImport("SHELL32.dll")
void SHDestroyPropSheetExtArray(HPSXA__* hpsxa);

@DllImport("SHELL32.dll")
uint SHAddFromPropSheetExtArray(HPSXA__* hpsxa, LPFNADDPROPSHEETPAGE lpfnAddPage, LPARAM lParam);

@DllImport("SHELL32.dll")
uint SHReplaceFromPropSheetExtArray(HPSXA__* hpsxa, uint uPageID, LPFNADDPROPSHEETPAGE lpfnReplaceWith, LPARAM lParam);

@DllImport("SHELL32.dll")
IStream OpenRegStream(HKEY hkey, const(wchar)* pszSubkey, const(wchar)* pszValue, uint grfMode);

@DllImport("SHELL32.dll")
BOOL SHFindFiles(ITEMIDLIST* pidlFolder, ITEMIDLIST* pidlSaveFile);

@DllImport("SHELL32.dll")
void PathGetShortPath(const(wchar)* pszLongPath);

@DllImport("SHELL32.dll")
BOOL PathYetAnotherMakeUniqueName(const(wchar)* pszUniqueName, const(wchar)* pszPath, const(wchar)* pszShort, const(wchar)* pszFileSpec);

@DllImport("SHELL32.dll")
BOOL Win32DeleteFile(const(wchar)* pszPath);

@DllImport("SHELL32.dll")
uint SHRestricted(RESTRICTIONS rest);

@DllImport("SHELL32.dll")
BOOL SignalFileOpen(ITEMIDLIST* pidl);

@DllImport("SHELL32.dll")
HRESULT AssocGetDetailsOfPropKey(IShellFolder psf, ITEMIDLIST* pidl, const(PROPERTYKEY)* pkey, VARIANT* pv, int* pfFoundPropKey);

@DllImport("SHELL32.dll")
HRESULT SHStartNetConnectionDialogW(HWND hwnd, const(wchar)* pszRemoteName, uint dwType);

@DllImport("SHELL32.dll")
HRESULT SHDefExtractIconA(const(char)* pszIconFile, int iIndex, uint uFlags, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);

@DllImport("SHELL32.dll")
HRESULT SHDefExtractIconW(const(wchar)* pszIconFile, int iIndex, uint uFlags, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);

@DllImport("SHELL32.dll")
HRESULT SHOpenWithDialog(HWND hwndParent, const(OPENASINFO)* poainfo);

@DllImport("SHELL32.dll")
BOOL Shell_GetImageLists(HIMAGELIST* phiml, HIMAGELIST* phimlSmall);

@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndex(const(wchar)* pwszIconPath, int iIconIndex, uint uIconFlags);

@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndexA(const(char)* pszIconPath, int iIconIndex, uint uIconFlags);

@DllImport("SHELL32.dll")
int Shell_GetCachedImageIndexW(const(wchar)* pszIconPath, int iIconIndex, uint uIconFlags);

@DllImport("SHELL32.dll")
BOOL SHValidateUNC(HWND hwndOwner, const(wchar)* pszFile, uint fConnect);

@DllImport("SHELL32.dll")
void SHSetInstanceExplorer(IUnknown punk);

@DllImport("SHELL32.dll")
BOOL IsUserAnAdmin();

@DllImport("SHELL32.dll")
LRESULT SHShellFolderView_Message(HWND hwndMain, uint uMsg, LPARAM lParam);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellFolderView(const(SFV_CREATE)* pcsfv, IShellView* ppsv);

@DllImport("SHELL32.dll")
HRESULT CDefFolderMenu_Create2(ITEMIDLIST* pidlFolder, HWND hwnd, uint cidl, char* apidl, IShellFolder psf, LPFNDFMCALLBACK pfn, uint nKeys, char* ahkeys, IContextMenu* ppcm);

@DllImport("SHELL32.dll")
HRESULT SHCreateDefaultContextMenu(const(DEFCONTEXTMENU)* pdcm, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
IContextMenu SHFind_InitMenuPopup(HMENU hmenu, HWND hwndOwner, uint idCmdFirst, uint idCmdLast);

@DllImport("SHELL32.dll")
HRESULT SHCreateShellFolderViewEx(CSFV* pcsfv, IShellView* ppsv);

@DllImport("SHELL32.dll")
void SHGetSetSettings(SHELLSTATEA* lpss, uint dwMask, BOOL bSet);

@DllImport("SHELL32.dll")
void SHGetSettings(SHELLFLAGSTATE* psfs, uint dwMask);

@DllImport("SHELL32.dll")
HRESULT SHBindToParent(ITEMIDLIST* pidl, const(Guid)* riid, void** ppv, ITEMIDLIST** ppidlLast);

@DllImport("SHELL32.dll")
HRESULT SHBindToFolderIDListParent(IShellFolder psfRoot, ITEMIDLIST* pidl, const(Guid)* riid, void** ppv, ITEMIDLIST** ppidlLast);

@DllImport("SHELL32.dll")
HRESULT SHBindToFolderIDListParentEx(IShellFolder psfRoot, ITEMIDLIST* pidl, IBindCtx ppbc, const(Guid)* riid, void** ppv, ITEMIDLIST** ppidlLast);

@DllImport("SHELL32.dll")
HRESULT SHBindToObject(IShellFolder psf, ITEMIDLIST* pidl, IBindCtx pbc, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHParseDisplayName(const(wchar)* pszName, IBindCtx pbc, ITEMIDLIST** ppidl, uint sfgaoIn, uint* psfgaoOut);

@DllImport("SHELL32.dll")
HRESULT SHPathPrepareForWriteA(HWND hwnd, IUnknown punkEnableModless, const(char)* pszPath, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHPathPrepareForWriteW(HWND hwnd, IUnknown punkEnableModless, const(wchar)* pszPath, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHCreateFileExtractIconW(const(wchar)* pszFile, uint dwFileAttributes, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
HRESULT SHLimitInputEdit(HWND hwndEdit, IShellFolder psf);

@DllImport("SHELL32.dll")
HRESULT SHGetAttributesFromDataObject(IDataObject pdo, uint dwAttributeMask, uint* pdwAttributes, uint* pcItems);

@DllImport("SHELL32.dll")
int SHMapPIDLToSystemImageListIndex(IShellFolder pshf, ITEMIDLIST* pidl, int* piIndexSel);

@DllImport("SHELL32.dll")
HRESULT SHCLSIDFromString(const(wchar)* psz, Guid* pclsid);

@DllImport("SHELL32.dll")
int PickIconDlg(HWND hwnd, const(wchar)* pszIconPath, uint cchIconPath, int* piIconIndex);

@DllImport("SHELL32.dll")
HRESULT StgMakeUniqueName(IStorage pstgParent, const(wchar)* pszFileSpec, uint grfMode, const(Guid)* riid, void** ppv);

@DllImport("SHELL32.dll")
void SHChangeNotifyRegisterThread(SCNRT_STATUS status);

@DllImport("SHELL32.dll")
void PathQualify(const(wchar)* psz);

@DllImport("SHELL32.dll")
BOOL PathIsSlowA(const(char)* pszFile, uint dwAttr);

@DllImport("SHELL32.dll")
BOOL PathIsSlowW(const(wchar)* pszFile, uint dwAttr);

@DllImport("SHELL32.dll")
HPSXA__* SHCreatePropSheetExtArray(HKEY hKey, const(wchar)* pszSubKey, uint max_iface);

@DllImport("SHELL32.dll")
BOOL SHOpenPropSheetW(const(wchar)* pszCaption, char* ahkeys, uint ckeys, const(Guid)* pclsidDefault, IDataObject pdtobj, IShellBrowser psb, const(wchar)* pStartPage);

@DllImport("SHDOCVW.dll")
uint SoftwareUpdateMessageBox(HWND hWnd, const(wchar)* pszDistUnit, uint dwFlags, SOFTDISTINFO* psdi);

@DllImport("SHELL32.dll")
HRESULT SHMultiFileProperties(IDataObject pdtobj, uint dwFlags);

@DllImport("SHELL32.dll")
HRESULT SHCreateQueryCancelAutoPlayMoniker(IMoniker* ppmoniker);

@DllImport("SHDOCVW.dll")
BOOL ImportPrivacySettings(const(wchar)* pszFilename, int* pfParsePrivacyPreferences, int* pfParsePerSiteRules);

@DllImport("SHDOCVW.dll")
HRESULT DoPrivacyDlg(HWND hwndOwner, const(wchar)* pszUrl, IEnumPrivacyRecords pPrivacyEnum, BOOL fReportAllSites);

@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
DEVICE_SCALE_FACTOR GetScaleFactorForDevice(DISPLAY_DEVICE_TYPE deviceType);

@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
HRESULT RegisterScaleChangeNotifications(DISPLAY_DEVICE_TYPE displayDevice, HWND hwndNotify, uint uMsgNotify, uint* pdwCookie);

@DllImport("api-ms-win-shcore-scaling-l1-1-0.dll")
HRESULT RevokeScaleChangeNotifications(DISPLAY_DEVICE_TYPE displayDevice, uint dwCookie);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetScaleFactorForMonitor(int hMon, DEVICE_SCALE_FACTOR* pScale);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT RegisterScaleChangeEvent(HANDLE hEvent, uint* pdwCookie);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT UnregisterScaleChangeEvent(uint dwCookie);

@DllImport("api-ms-win-shcore-scaling-l1-1-2.dll")
uint GetDpiForShellUIComponent(SHELL_UI_COMPONENT param0);

@DllImport("SHLWAPI.dll")
byte* StrChrA(const(char)* pszStart, ushort wMatch);

@DllImport("SHLWAPI.dll")
ushort* StrChrW(const(wchar)* pszStart, ushort wMatch);

@DllImport("SHLWAPI.dll")
byte* StrChrIA(const(char)* pszStart, ushort wMatch);

@DllImport("SHLWAPI.dll")
ushort* StrChrIW(const(wchar)* pszStart, ushort wMatch);

@DllImport("SHLWAPI.dll")
ushort* StrChrNW(const(wchar)* pszStart, ushort wMatch, uint cchMax);

@DllImport("SHLWAPI.dll")
ushort* StrChrNIW(const(wchar)* pszStart, ushort wMatch, uint cchMax);

@DllImport("SHLWAPI.dll")
int StrCmpNA(const(char)* psz1, const(char)* psz2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNW(const(wchar)* psz1, const(wchar)* psz2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNIA(const(char)* psz1, const(char)* psz2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNIW(const(wchar)* psz1, const(wchar)* psz2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCSpnA(const(char)* pszStr, const(char)* pszSet);

@DllImport("SHLWAPI.dll")
int StrCSpnW(const(wchar)* pszStr, const(wchar)* pszSet);

@DllImport("SHLWAPI.dll")
int StrCSpnIA(const(char)* pszStr, const(char)* pszSet);

@DllImport("SHLWAPI.dll")
int StrCSpnIW(const(wchar)* pszStr, const(wchar)* pszSet);

@DllImport("SHLWAPI.dll")
byte* StrDupA(const(char)* pszSrch);

@DllImport("SHLWAPI.dll")
ushort* StrDupW(const(wchar)* pszSrch);

@DllImport("SHLWAPI.dll")
HRESULT StrFormatByteSizeEx(ulong ull, int flags, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
byte* StrFormatByteSizeA(uint dw, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
byte* StrFormatByteSize64A(long qdw, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
ushort* StrFormatByteSizeW(long qdw, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
ushort* StrFormatKBSizeW(long qdw, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
byte* StrFormatKBSizeA(long qdw, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
int StrFromTimeIntervalA(const(char)* pszOut, uint cchMax, uint dwTimeMS, int digits);

@DllImport("SHLWAPI.dll")
int StrFromTimeIntervalW(const(wchar)* pszOut, uint cchMax, uint dwTimeMS, int digits);

@DllImport("SHLWAPI.dll")
BOOL StrIsIntlEqualA(BOOL fCaseSens, const(char)* pszString1, const(char)* pszString2, int nChar);

@DllImport("SHLWAPI.dll")
BOOL StrIsIntlEqualW(BOOL fCaseSens, const(wchar)* pszString1, const(wchar)* pszString2, int nChar);

@DllImport("SHLWAPI.dll")
byte* StrNCatA(const(char)* psz1, const(char)* psz2, int cchMax);

@DllImport("SHLWAPI.dll")
ushort* StrNCatW(const(wchar)* psz1, const(wchar)* psz2, int cchMax);

@DllImport("SHLWAPI.dll")
byte* StrPBrkA(const(char)* psz, const(char)* pszSet);

@DllImport("SHLWAPI.dll")
ushort* StrPBrkW(const(wchar)* psz, const(wchar)* pszSet);

@DllImport("SHLWAPI.dll")
byte* StrRChrA(const(char)* pszStart, const(char)* pszEnd, ushort wMatch);

@DllImport("SHLWAPI.dll")
ushort* StrRChrW(const(wchar)* pszStart, const(wchar)* pszEnd, ushort wMatch);

@DllImport("SHLWAPI.dll")
byte* StrRChrIA(const(char)* pszStart, const(char)* pszEnd, ushort wMatch);

@DllImport("SHLWAPI.dll")
ushort* StrRChrIW(const(wchar)* pszStart, const(wchar)* pszEnd, ushort wMatch);

@DllImport("SHLWAPI.dll")
byte* StrRStrIA(const(char)* pszSource, const(char)* pszLast, const(char)* pszSrch);

@DllImport("SHLWAPI.dll")
ushort* StrRStrIW(const(wchar)* pszSource, const(wchar)* pszLast, const(wchar)* pszSrch);

@DllImport("SHLWAPI.dll")
int StrSpnA(const(char)* psz, const(char)* pszSet);

@DllImport("SHLWAPI.dll")
int StrSpnW(const(wchar)* psz, const(wchar)* pszSet);

@DllImport("SHLWAPI.dll")
byte* StrStrA(const(char)* pszFirst, const(char)* pszSrch);

@DllImport("SHLWAPI.dll")
ushort* StrStrW(const(wchar)* pszFirst, const(wchar)* pszSrch);

@DllImport("SHLWAPI.dll")
byte* StrStrIA(const(char)* pszFirst, const(char)* pszSrch);

@DllImport("SHLWAPI.dll")
ushort* StrStrIW(const(wchar)* pszFirst, const(wchar)* pszSrch);

@DllImport("SHLWAPI.dll")
ushort* StrStrNW(const(wchar)* pszFirst, const(wchar)* pszSrch, uint cchMax);

@DllImport("SHLWAPI.dll")
ushort* StrStrNIW(const(wchar)* pszFirst, const(wchar)* pszSrch, uint cchMax);

@DllImport("SHLWAPI.dll")
int StrToIntA(const(char)* pszSrc);

@DllImport("SHLWAPI.dll")
int StrToIntW(const(wchar)* pszSrc);

@DllImport("SHLWAPI.dll")
BOOL StrToIntExA(const(char)* pszString, int dwFlags, int* piRet);

@DllImport("SHLWAPI.dll")
BOOL StrToIntExW(const(wchar)* pszString, int dwFlags, int* piRet);

@DllImport("SHLWAPI.dll")
BOOL StrToInt64ExA(const(char)* pszString, int dwFlags, long* pllRet);

@DllImport("SHLWAPI.dll")
BOOL StrToInt64ExW(const(wchar)* pszString, int dwFlags, long* pllRet);

@DllImport("SHLWAPI.dll")
BOOL StrTrimA(const(char)* psz, const(char)* pszTrimChars);

@DllImport("SHLWAPI.dll")
BOOL StrTrimW(const(wchar)* psz, const(wchar)* pszTrimChars);

@DllImport("SHLWAPI.dll")
ushort* StrCatW(const(wchar)* psz1, const(wchar)* psz2);

@DllImport("SHLWAPI.dll")
int StrCmpW(const(wchar)* psz1, const(wchar)* psz2);

@DllImport("SHLWAPI.dll")
int StrCmpIW(const(wchar)* psz1, const(wchar)* psz2);

@DllImport("SHLWAPI.dll")
ushort* StrCpyW(const(wchar)* psz1, const(wchar)* psz2);

@DllImport("SHLWAPI.dll")
ushort* StrCpyNW(const(wchar)* pszDst, const(wchar)* pszSrc, int cchMax);

@DllImport("SHLWAPI.dll")
ushort* StrCatBuffW(const(wchar)* pszDest, const(wchar)* pszSrc, int cchDestBuffSize);

@DllImport("SHLWAPI.dll")
byte* StrCatBuffA(const(char)* pszDest, const(char)* pszSrc, int cchDestBuffSize);

@DllImport("SHLWAPI.dll")
BOOL ChrCmpIA(ushort w1, ushort w2);

@DllImport("SHLWAPI.dll")
BOOL ChrCmpIW(ushort w1, ushort w2);

@DllImport("SHLWAPI.dll")
int wvnsprintfA(const(char)* pszDest, int cchDest, const(char)* pszFmt, byte* arglist);

@DllImport("SHLWAPI.dll")
int wvnsprintfW(const(wchar)* pszDest, int cchDest, const(wchar)* pszFmt, byte* arglist);

@DllImport("SHLWAPI.dll")
int wnsprintfA(const(char)* pszDest, int cchDest, const(char)* pszFmt);

@DllImport("SHLWAPI.dll")
int wnsprintfW(const(wchar)* pszDest, int cchDest, const(wchar)* pszFmt);

@DllImport("SHLWAPI.dll")
HRESULT StrRetToStrA(STRRET* pstr, ITEMIDLIST* pidl, byte** ppsz);

@DllImport("SHLWAPI.dll")
HRESULT StrRetToStrW(STRRET* pstr, ITEMIDLIST* pidl, ushort** ppsz);

@DllImport("SHLWAPI.dll")
HRESULT StrRetToBufA(STRRET* pstr, ITEMIDLIST* pidl, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
HRESULT StrRetToBufW(STRRET* pstr, ITEMIDLIST* pidl, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
HRESULT SHStrDupA(const(char)* psz, ushort** ppwsz);

@DllImport("SHLWAPI.dll")
HRESULT SHStrDupW(const(wchar)* psz, ushort** ppwsz);

@DllImport("SHLWAPI.dll")
int StrCmpLogicalW(const(wchar)* psz1, const(wchar)* psz2);

@DllImport("SHLWAPI.dll")
uint StrCatChainW(const(wchar)* pszDst, uint cchDst, uint ichAt, const(wchar)* pszSrc);

@DllImport("SHLWAPI.dll")
HRESULT StrRetToBSTR(STRRET* pstr, ITEMIDLIST* pidl, BSTR* pbstr);

@DllImport("SHLWAPI.dll")
HRESULT SHLoadIndirectString(const(wchar)* pszSource, const(wchar)* pszOutBuf, uint cchOutBuf, void** ppvReserved);

@DllImport("SHLWAPI.dll")
BOOL IsCharSpaceA(byte wch);

@DllImport("SHLWAPI.dll")
BOOL IsCharSpaceW(ushort wch);

@DllImport("SHLWAPI.dll")
int StrCmpCA(const(char)* pszStr1, const(char)* pszStr2);

@DllImport("SHLWAPI.dll")
int StrCmpCW(const(wchar)* pszStr1, const(wchar)* pszStr2);

@DllImport("SHLWAPI.dll")
int StrCmpICA(const(char)* pszStr1, const(char)* pszStr2);

@DllImport("SHLWAPI.dll")
int StrCmpICW(const(wchar)* pszStr1, const(wchar)* pszStr2);

@DllImport("SHLWAPI.dll")
int StrCmpNCA(const(char)* pszStr1, const(char)* pszStr2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNCW(const(wchar)* pszStr1, const(wchar)* pszStr2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNICA(const(char)* pszStr1, const(char)* pszStr2, int nChar);

@DllImport("SHLWAPI.dll")
int StrCmpNICW(const(wchar)* pszStr1, const(wchar)* pszStr2, int nChar);

@DllImport("SHLWAPI.dll")
BOOL IntlStrEqWorkerA(BOOL fCaseSens, const(char)* lpString1, const(char)* lpString2, int nChar);

@DllImport("SHLWAPI.dll")
BOOL IntlStrEqWorkerW(BOOL fCaseSens, const(wchar)* lpString1, const(wchar)* lpString2, int nChar);

@DllImport("SHLWAPI.dll")
byte* PathAddBackslashA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathAddBackslashW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathAddExtensionA(const(char)* pszPath, const(char)* pszExt);

@DllImport("SHLWAPI.dll")
BOOL PathAddExtensionW(const(wchar)* pszPath, const(wchar)* pszExt);

@DllImport("SHLWAPI.dll")
BOOL PathAppendA(const(char)* pszPath, const(char)* pszMore);

@DllImport("SHLWAPI.dll")
BOOL PathAppendW(const(wchar)* pszPath, const(wchar)* pszMore);

@DllImport("SHLWAPI.dll")
byte* PathBuildRootA(const(char)* pszRoot, int iDrive);

@DllImport("SHLWAPI.dll")
ushort* PathBuildRootW(const(wchar)* pszRoot, int iDrive);

@DllImport("SHLWAPI.dll")
BOOL PathCanonicalizeA(const(char)* pszBuf, const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathCanonicalizeW(const(wchar)* pszBuf, const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathCombineA(const(char)* pszDest, const(char)* pszDir, const(char)* pszFile);

@DllImport("SHLWAPI.dll")
ushort* PathCombineW(const(wchar)* pszDest, const(wchar)* pszDir, const(wchar)* pszFile);

@DllImport("SHLWAPI.dll")
BOOL PathCompactPathA(HDC hDC, const(char)* pszPath, uint dx);

@DllImport("SHLWAPI.dll")
BOOL PathCompactPathW(HDC hDC, const(wchar)* pszPath, uint dx);

@DllImport("SHLWAPI.dll")
BOOL PathCompactPathExA(const(char)* pszOut, const(char)* pszSrc, uint cchMax, uint dwFlags);

@DllImport("SHLWAPI.dll")
BOOL PathCompactPathExW(const(wchar)* pszOut, const(wchar)* pszSrc, uint cchMax, uint dwFlags);

@DllImport("SHLWAPI.dll")
int PathCommonPrefixA(const(char)* pszFile1, const(char)* pszFile2, const(char)* achPath);

@DllImport("SHLWAPI.dll")
int PathCommonPrefixW(const(wchar)* pszFile1, const(wchar)* pszFile2, const(wchar)* achPath);

@DllImport("SHLWAPI.dll")
BOOL PathFileExistsA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathFileExistsW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathFindExtensionA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathFindExtensionW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathFindFileNameA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathFindFileNameW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathFindNextComponentA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathFindNextComponentW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathFindOnPathA(const(char)* pszPath, byte** ppszOtherDirs);

@DllImport("SHLWAPI.dll")
BOOL PathFindOnPathW(const(wchar)* pszPath, ushort** ppszOtherDirs);

@DllImport("SHLWAPI.dll")
byte* PathFindSuffixArrayA(const(char)* pszPath, char* apszSuffix, int iArraySize);

@DllImport("SHLWAPI.dll")
ushort* PathFindSuffixArrayW(const(wchar)* pszPath, char* apszSuffix, int iArraySize);

@DllImport("SHLWAPI.dll")
byte* PathGetArgsA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathGetArgsW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsLFNFileSpecA(const(char)* pszName);

@DllImport("SHLWAPI.dll")
BOOL PathIsLFNFileSpecW(const(wchar)* pszName);

@DllImport("SHLWAPI.dll")
uint PathGetCharTypeA(ubyte ch);

@DllImport("SHLWAPI.dll")
uint PathGetCharTypeW(ushort ch);

@DllImport("SHLWAPI.dll")
int PathGetDriveNumberA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
int PathGetDriveNumberW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryEmptyA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsDirectoryEmptyW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsFileSpecA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsFileSpecW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsPrefixA(const(char)* pszPrefix, const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsPrefixW(const(wchar)* pszPrefix, const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsRelativeA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsRelativeW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsRootA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsRootW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsSameRootA(const(char)* pszPath1, const(char)* pszPath2);

@DllImport("SHLWAPI.dll")
BOOL PathIsSameRootW(const(wchar)* pszPath1, const(wchar)* pszPath2);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsNetworkPathA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsNetworkPathW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerShareA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsUNCServerShareW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsContentTypeA(const(char)* pszPath, const(char)* pszContentType);

@DllImport("SHLWAPI.dll")
BOOL PathIsContentTypeW(const(wchar)* pszPath, const(wchar)* pszContentType);

@DllImport("SHLWAPI.dll")
BOOL PathIsURLA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsURLW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathMakePrettyA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathMakePrettyW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathMatchSpecA(const(char)* pszFile, const(char)* pszSpec);

@DllImport("SHLWAPI.dll")
BOOL PathMatchSpecW(const(wchar)* pszFile, const(wchar)* pszSpec);

@DllImport("SHLWAPI.dll")
HRESULT PathMatchSpecExA(const(char)* pszFile, const(char)* pszSpec, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT PathMatchSpecExW(const(wchar)* pszFile, const(wchar)* pszSpec, uint dwFlags);

@DllImport("SHLWAPI.dll")
int PathParseIconLocationA(const(char)* pszIconFile);

@DllImport("SHLWAPI.dll")
int PathParseIconLocationW(const(wchar)* pszIconFile);

@DllImport("SHLWAPI.dll")
BOOL PathQuoteSpacesA(const(char)* lpsz);

@DllImport("SHLWAPI.dll")
BOOL PathQuoteSpacesW(const(wchar)* lpsz);

@DllImport("SHLWAPI.dll")
BOOL PathRelativePathToA(const(char)* pszPath, const(char)* pszFrom, uint dwAttrFrom, const(char)* pszTo, uint dwAttrTo);

@DllImport("SHLWAPI.dll")
BOOL PathRelativePathToW(const(wchar)* pszPath, const(wchar)* pszFrom, uint dwAttrFrom, const(wchar)* pszTo, uint dwAttrTo);

@DllImport("SHLWAPI.dll")
void PathRemoveArgsA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathRemoveArgsW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathRemoveBackslashA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathRemoveBackslashW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
void PathRemoveBlanksA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathRemoveBlanksW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
void PathRemoveExtensionA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathRemoveExtensionW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathRemoveFileSpecA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathRemoveFileSpecW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathRenameExtensionA(const(char)* pszPath, const(char)* pszExt);

@DllImport("SHLWAPI.dll")
BOOL PathRenameExtensionW(const(wchar)* pszPath, const(wchar)* pszExt);

@DllImport("SHLWAPI.dll")
BOOL PathSearchAndQualifyA(const(char)* pszPath, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
BOOL PathSearchAndQualifyW(const(wchar)* pszPath, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
void PathSetDlgItemPathA(HWND hDlg, int id, const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathSetDlgItemPathW(HWND hDlg, int id, const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
byte* PathSkipRootA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
ushort* PathSkipRootW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
void PathStripPathA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathStripPathW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathStripToRootA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathStripToRootW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathUnquoteSpacesA(const(char)* lpsz);

@DllImport("SHLWAPI.dll")
BOOL PathUnquoteSpacesW(const(wchar)* lpsz);

@DllImport("SHLWAPI.dll")
BOOL PathMakeSystemFolderA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathMakeSystemFolderW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathUnmakeSystemFolderA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathUnmakeSystemFolderW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathIsSystemFolderA(const(char)* pszPath, uint dwAttrb);

@DllImport("SHLWAPI.dll")
BOOL PathIsSystemFolderW(const(wchar)* pszPath, uint dwAttrb);

@DllImport("SHLWAPI.dll")
void PathUndecorateA(const(char)* pszPath);

@DllImport("SHLWAPI.dll")
void PathUndecorateW(const(wchar)* pszPath);

@DllImport("SHLWAPI.dll")
BOOL PathUnExpandEnvStringsA(const(char)* pszPath, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
BOOL PathUnExpandEnvStringsW(const(wchar)* pszPath, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
int UrlCompareA(const(char)* psz1, const(char)* psz2, BOOL fIgnoreSlash);

@DllImport("SHLWAPI.dll")
int UrlCompareW(const(wchar)* psz1, const(wchar)* psz2, BOOL fIgnoreSlash);

@DllImport("SHLWAPI.dll")
HRESULT UrlCombineA(const(char)* pszBase, const(char)* pszRelative, const(char)* pszCombined, uint* pcchCombined, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlCombineW(const(wchar)* pszBase, const(wchar)* pszRelative, const(wchar)* pszCombined, uint* pcchCombined, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlCanonicalizeA(const(char)* pszUrl, const(char)* pszCanonicalized, uint* pcchCanonicalized, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlCanonicalizeW(const(wchar)* pszUrl, const(wchar)* pszCanonicalized, uint* pcchCanonicalized, uint dwFlags);

@DllImport("SHLWAPI.dll")
BOOL UrlIsOpaqueA(const(char)* pszURL);

@DllImport("SHLWAPI.dll")
BOOL UrlIsOpaqueW(const(wchar)* pszURL);

@DllImport("SHLWAPI.dll")
BOOL UrlIsNoHistoryA(const(char)* pszURL);

@DllImport("SHLWAPI.dll")
BOOL UrlIsNoHistoryW(const(wchar)* pszURL);

@DllImport("SHLWAPI.dll")
BOOL UrlIsA(const(char)* pszUrl, URLIS UrlIs);

@DllImport("SHLWAPI.dll")
BOOL UrlIsW(const(wchar)* pszUrl, URLIS UrlIs);

@DllImport("SHLWAPI.dll")
byte* UrlGetLocationA(const(char)* pszURL);

@DllImport("SHLWAPI.dll")
ushort* UrlGetLocationW(const(wchar)* pszURL);

@DllImport("SHLWAPI.dll")
HRESULT UrlUnescapeA(const(char)* pszUrl, const(char)* pszUnescaped, uint* pcchUnescaped, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlUnescapeW(const(wchar)* pszUrl, const(wchar)* pszUnescaped, uint* pcchUnescaped, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlEscapeA(const(char)* pszUrl, const(char)* pszEscaped, uint* pcchEscaped, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlEscapeW(const(wchar)* pszUrl, const(wchar)* pszEscaped, uint* pcchEscaped, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlCreateFromPathA(const(char)* pszPath, const(char)* pszUrl, uint* pcchUrl, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlCreateFromPathW(const(wchar)* pszPath, const(wchar)* pszUrl, uint* pcchUrl, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlA(const(char)* pszUrl, const(char)* pszPath, uint* pcchPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlW(const(wchar)* pszUrl, const(wchar)* pszPath, uint* pcchPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT PathCreateFromUrlAlloc(const(wchar)* pszIn, ushort** ppszOut, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlHashA(const(char)* pszUrl, char* pbHash, uint cbHash);

@DllImport("SHLWAPI.dll")
HRESULT UrlHashW(const(wchar)* pszUrl, char* pbHash, uint cbHash);

@DllImport("SHLWAPI.dll")
HRESULT UrlGetPartW(const(wchar)* pszIn, const(wchar)* pszOut, uint* pcchOut, uint dwPart, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlGetPartA(const(char)* pszIn, const(char)* pszOut, uint* pcchOut, uint dwPart, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlApplySchemeA(const(char)* pszIn, const(char)* pszOut, uint* pcchOut, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT UrlApplySchemeW(const(wchar)* pszIn, const(wchar)* pszOut, uint* pcchOut, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT HashData(char* pbData, uint cbData, char* pbHash, uint cbHash);

@DllImport("SHLWAPI.dll")
HRESULT UrlFixupW(const(wchar)* pcszUrl, const(wchar)* pszTranslatedUrl, uint cchMax);

@DllImport("SHLWAPI.dll")
HRESULT ParseURLA(const(char)* pcszURL, PARSEDURLA* ppu);

@DllImport("SHLWAPI.dll")
HRESULT ParseURLW(const(wchar)* pcszURL, PARSEDURLW* ppu);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteEmptyKeyA(HKEY hkey, const(char)* pszSubKey);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteEmptyKeyW(HKEY hkey, const(wchar)* pszSubKey);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteKeyA(HKEY hkey, const(char)* pszSubKey);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteKeyW(HKEY hkey, const(wchar)* pszSubKey);

@DllImport("SHLWAPI.dll")
HKEY SHRegDuplicateHKey(HKEY hkey);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteValueA(HKEY hkey, const(char)* pszSubKey, const(char)* pszValue);

@DllImport("SHLWAPI.dll")
LSTATUS SHDeleteValueW(HKEY hkey, const(wchar)* pszSubKey, const(wchar)* pszValue);

@DllImport("SHLWAPI.dll")
LSTATUS SHGetValueA(HKEY hkey, const(char)* pszSubKey, const(char)* pszValue, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHGetValueW(HKEY hkey, const(wchar)* pszSubKey, const(wchar)* pszValue, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHSetValueA(HKEY hkey, const(char)* pszSubKey, const(char)* pszValue, uint dwType, char* pvData, uint cbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHSetValueW(HKEY hkey, const(wchar)* pszSubKey, const(wchar)* pszValue, uint dwType, char* pvData, uint cbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetValueA(HKEY hkey, const(char)* pszSubKey, const(char)* pszValue, int srrfFlags, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetValueW(HKEY hkey, const(wchar)* pszSubKey, const(wchar)* pszValue, int srrfFlags, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetValueFromHKCUHKLM(const(wchar)* pwszKey, const(wchar)* pwszValue, int srrfFlags, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHQueryValueExA(HKEY hkey, const(char)* pszValue, uint* pdwReserved, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHQueryValueExW(HKEY hkey, const(wchar)* pszValue, uint* pdwReserved, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHEnumKeyExA(HKEY hkey, uint dwIndex, const(char)* pszName, uint* pcchName);

@DllImport("SHLWAPI.dll")
LSTATUS SHEnumKeyExW(HKEY hkey, uint dwIndex, const(wchar)* pszName, uint* pcchName);

@DllImport("SHLWAPI.dll")
LSTATUS SHEnumValueA(HKEY hkey, uint dwIndex, const(char)* pszValueName, uint* pcchValueName, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHEnumValueW(HKEY hkey, uint dwIndex, const(wchar)* pszValueName, uint* pcchValueName, uint* pdwType, char* pvData, uint* pcbData);

@DllImport("SHLWAPI.dll")
LSTATUS SHQueryInfoKeyA(HKEY hkey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, uint* pcchMaxValueNameLen);

@DllImport("SHLWAPI.dll")
LSTATUS SHQueryInfoKeyW(HKEY hkey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, uint* pcchMaxValueNameLen);

@DllImport("SHLWAPI.dll")
LSTATUS SHCopyKeyA(HKEY hkeySrc, const(char)* pszSrcSubKey, HKEY hkeyDest, uint fReserved);

@DllImport("SHLWAPI.dll")
LSTATUS SHCopyKeyW(HKEY hkeySrc, const(wchar)* pszSrcSubKey, HKEY hkeyDest, uint fReserved);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetPathA(HKEY hKey, const(char)* pcszSubKey, const(char)* pcszValue, const(char)* pszPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetPathW(HKEY hKey, const(wchar)* pcszSubKey, const(wchar)* pcszValue, const(wchar)* pszPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegSetPathA(HKEY hKey, const(char)* pcszSubKey, const(char)* pcszValue, const(char)* pcszPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegSetPathW(HKEY hKey, const(wchar)* pcszSubKey, const(wchar)* pcszValue, const(wchar)* pcszPath, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegCreateUSKeyA(const(char)* pszPath, uint samDesired, int hRelativeUSKey, int* phNewUSKey, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegCreateUSKeyW(const(wchar)* pwzPath, uint samDesired, int hRelativeUSKey, int* phNewUSKey, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegOpenUSKeyA(const(char)* pszPath, uint samDesired, int hRelativeUSKey, int* phNewUSKey, BOOL fIgnoreHKCU);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegOpenUSKeyW(const(wchar)* pwzPath, uint samDesired, int hRelativeUSKey, int* phNewUSKey, BOOL fIgnoreHKCU);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegQueryUSValueA(int hUSKey, const(char)* pszValue, uint* pdwType, char* pvData, uint* pcbData, BOOL fIgnoreHKCU, char* pvDefaultData, uint dwDefaultDataSize);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegQueryUSValueW(int hUSKey, const(wchar)* pszValue, uint* pdwType, char* pvData, uint* pcbData, BOOL fIgnoreHKCU, char* pvDefaultData, uint dwDefaultDataSize);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegWriteUSValueA(int hUSKey, const(char)* pszValue, uint dwType, char* pvData, uint cbData, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegWriteUSValueW(int hUSKey, const(wchar)* pwzValue, uint dwType, char* pvData, uint cbData, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegDeleteUSValueA(int hUSKey, const(char)* pszValue, SHREGDEL_FLAGS delRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegDeleteUSValueW(int hUSKey, const(wchar)* pwzValue, SHREGDEL_FLAGS delRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegDeleteEmptyUSKeyW(int hUSKey, const(wchar)* pwzSubKey, SHREGDEL_FLAGS delRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegDeleteEmptyUSKeyA(int hUSKey, const(char)* pszSubKey, SHREGDEL_FLAGS delRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegEnumUSKeyA(int hUSKey, uint dwIndex, const(char)* pszName, uint* pcchName, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegEnumUSKeyW(int hUSKey, uint dwIndex, const(wchar)* pwzName, uint* pcchName, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegEnumUSValueA(int hUSkey, uint dwIndex, const(char)* pszValueName, uint* pcchValueName, uint* pdwType, char* pvData, uint* pcbData, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegEnumUSValueW(int hUSkey, uint dwIndex, const(wchar)* pszValueName, uint* pcchValueName, uint* pdwType, char* pvData, uint* pcbData, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegQueryInfoUSKeyA(int hUSKey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, uint* pcchMaxValueNameLen, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegQueryInfoUSKeyW(int hUSKey, uint* pcSubKeys, uint* pcchMaxSubKeyLen, uint* pcValues, uint* pcchMaxValueNameLen, SHREGENUM_FLAGS enumRegFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegCloseUSKey(int hUSKey);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetUSValueA(const(char)* pszSubKey, const(char)* pszValue, uint* pdwType, char* pvData, uint* pcbData, BOOL fIgnoreHKCU, char* pvDefaultData, uint dwDefaultDataSize);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegGetUSValueW(const(wchar)* pszSubKey, const(wchar)* pszValue, uint* pdwType, char* pvData, uint* pcbData, BOOL fIgnoreHKCU, char* pvDefaultData, uint dwDefaultDataSize);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegSetUSValueA(const(char)* pszSubKey, const(char)* pszValue, uint dwType, char* pvData, uint cbData, uint dwFlags);

@DllImport("SHLWAPI.dll")
LSTATUS SHRegSetUSValueW(const(wchar)* pwzSubKey, const(wchar)* pwzValue, uint dwType, char* pvData, uint cbData, uint dwFlags);

@DllImport("SHLWAPI.dll")
int SHRegGetIntW(HKEY hk, const(wchar)* pwzKey, int iDefault);

@DllImport("SHLWAPI.dll")
BOOL SHRegGetBoolUSValueA(const(char)* pszSubKey, const(char)* pszValue, BOOL fIgnoreHKCU, BOOL fDefault);

@DllImport("SHLWAPI.dll")
BOOL SHRegGetBoolUSValueW(const(wchar)* pszSubKey, const(wchar)* pszValue, BOOL fIgnoreHKCU, BOOL fDefault);

@DllImport("SHLWAPI.dll")
HRESULT AssocCreate(Guid clsid, const(Guid)* riid, void** ppv);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringA(uint flags, ASSOCSTR str, const(char)* pszAssoc, const(char)* pszExtra, const(char)* pszOut, uint* pcchOut);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringW(uint flags, ASSOCSTR str, const(wchar)* pszAssoc, const(wchar)* pszExtra, const(wchar)* pszOut, uint* pcchOut);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringByKeyA(uint flags, ASSOCSTR str, HKEY hkAssoc, const(char)* pszExtra, const(char)* pszOut, uint* pcchOut);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryStringByKeyW(uint flags, ASSOCSTR str, HKEY hkAssoc, const(wchar)* pszExtra, const(wchar)* pszOut, uint* pcchOut);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryKeyA(uint flags, ASSOCKEY key, const(char)* pszAssoc, const(char)* pszExtra, HKEY* phkeyOut);

@DllImport("SHLWAPI.dll")
HRESULT AssocQueryKeyW(uint flags, ASSOCKEY key, const(wchar)* pszAssoc, const(wchar)* pszExtra, HKEY* phkeyOut);

@DllImport("SHLWAPI.dll")
BOOL AssocIsDangerous(const(wchar)* pszAssoc);

@DllImport("SHLWAPI.dll")
HRESULT AssocGetPerceivedType(const(wchar)* pszExt, PERCEIVED* ptype, uint* pflag, ushort** ppszType);

@DllImport("SHLWAPI.dll")
IStream SHOpenRegStreamA(HKEY hkey, const(char)* pszSubkey, const(char)* pszValue, uint grfMode);

@DllImport("SHLWAPI.dll")
IStream SHOpenRegStreamW(HKEY hkey, const(wchar)* pszSubkey, const(wchar)* pszValue, uint grfMode);

@DllImport("SHLWAPI.dll")
IStream SHOpenRegStream2A(HKEY hkey, const(char)* pszSubkey, const(char)* pszValue, uint grfMode);

@DllImport("SHLWAPI.dll")
IStream SHOpenRegStream2W(HKEY hkey, const(wchar)* pszSubkey, const(wchar)* pszValue, uint grfMode);

@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileA(const(char)* pszFile, uint grfMode, IStream* ppstm);

@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileW(const(wchar)* pszFile, uint grfMode, IStream* ppstm);

@DllImport("SHLWAPI.dll")
HRESULT SHCreateStreamOnFileEx(const(wchar)* pszFile, uint grfMode, uint dwAttributes, BOOL fCreate, IStream pstmTemplate, IStream* ppstm);

@DllImport("SHLWAPI.dll")
IStream SHCreateMemStream(char* pInit, uint cbInit);

@DllImport("SHLWAPI.dll")
HRESULT GetAcceptLanguagesA(const(char)* pszLanguages, uint* pcchLanguages);

@DllImport("SHLWAPI.dll")
HRESULT GetAcceptLanguagesW(const(wchar)* pszLanguages, uint* pcchLanguages);

@DllImport("SHLWAPI.dll")
void IUnknown_Set(IUnknown* ppunk, IUnknown punk);

@DllImport("SHLWAPI.dll")
void IUnknown_AtomicRelease(void** ppunk);

@DllImport("SHLWAPI.dll")
HRESULT IUnknown_GetWindow(IUnknown punk, HWND* phwnd);

@DllImport("SHLWAPI.dll")
HRESULT IUnknown_SetSite(IUnknown punk, IUnknown punkSite);

@DllImport("SHLWAPI.dll")
HRESULT IUnknown_GetSite(IUnknown punk, const(Guid)* riid, void** ppv);

@DllImport("SHLWAPI.dll")
HRESULT IUnknown_QueryService(IUnknown punk, const(Guid)* guidService, const(Guid)* riid, void** ppvOut);

@DllImport("SHLWAPI.dll")
HRESULT IStream_Read(IStream pstm, char* pv, uint cb);

@DllImport("SHLWAPI.dll")
HRESULT IStream_Write(IStream pstm, char* pv, uint cb);

@DllImport("SHLWAPI.dll")
HRESULT IStream_Reset(IStream pstm);

@DllImport("SHLWAPI.dll")
HRESULT IStream_Size(IStream pstm, ULARGE_INTEGER* pui);

@DllImport("SHLWAPI.dll")
HRESULT ConnectToConnectionPoint(IUnknown punk, const(Guid)* riidEvent, BOOL fConnect, IUnknown punkTarget, uint* pdwCookie, IConnectionPoint* ppcpOut);

@DllImport("SHLWAPI.dll")
HRESULT IStream_ReadPidl(IStream pstm, ITEMIDLIST** ppidlOut);

@DllImport("SHLWAPI.dll")
HRESULT IStream_WritePidl(IStream pstm, ITEMIDLIST* pidlWrite);

@DllImport("SHLWAPI.dll")
HRESULT IStream_ReadStr(IStream pstm, ushort** ppsz);

@DllImport("SHLWAPI.dll")
HRESULT IStream_WriteStr(IStream pstm, const(wchar)* psz);

@DllImport("SHLWAPI.dll")
HRESULT IStream_Copy(IStream pstmFrom, IStream pstmTo, uint cb);

@DllImport("SHLWAPI.dll")
HRESULT SHGetViewStatePropertyBag(ITEMIDLIST* pidl, const(wchar)* pszBagName, uint dwFlags, const(Guid)* riid, void** ppv);

@DllImport("SHLWAPI.dll")
int SHFormatDateTimeA(const(FILETIME)* pft, uint* pdwFlags, const(char)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
int SHFormatDateTimeW(const(FILETIME)* pft, uint* pdwFlags, const(wchar)* pszBuf, uint cchBuf);

@DllImport("SHLWAPI.dll")
int SHAnsiToUnicode(const(char)* pszSrc, const(wchar)* pwszDst, int cwchBuf);

@DllImport("SHLWAPI.dll")
int SHAnsiToAnsi(const(char)* pszSrc, const(char)* pszDst, int cchBuf);

@DllImport("SHLWAPI.dll")
int SHUnicodeToAnsi(const(wchar)* pwszSrc, const(char)* pszDst, int cchBuf);

@DllImport("SHLWAPI.dll")
int SHUnicodeToUnicode(const(wchar)* pwzSrc, const(wchar)* pwzDst, int cwchBuf);

@DllImport("SHLWAPI.dll")
int SHMessageBoxCheckA(HWND hwnd, const(char)* pszText, const(char)* pszCaption, uint uType, int iDefault, const(char)* pszRegVal);

@DllImport("SHLWAPI.dll")
int SHMessageBoxCheckW(HWND hwnd, const(wchar)* pszText, const(wchar)* pszCaption, uint uType, int iDefault, const(wchar)* pszRegVal);

@DllImport("SHLWAPI.dll")
LRESULT SHSendMessageBroadcastA(uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("SHLWAPI.dll")
LRESULT SHSendMessageBroadcastW(uint uMsg, WPARAM wParam, LPARAM lParam);

@DllImport("SHLWAPI.dll")
byte SHStripMneumonicA(const(char)* pszMenu);

@DllImport("SHLWAPI.dll")
ushort SHStripMneumonicW(const(wchar)* pszMenu);

@DllImport("SHLWAPI.dll")
BOOL IsOS(uint dwOS);

@DllImport("SHLWAPI.dll")
int SHGlobalCounterGetValue(const(SHGLOBALCOUNTER) id);

@DllImport("SHLWAPI.dll")
int SHGlobalCounterIncrement(const(SHGLOBALCOUNTER) id);

@DllImport("SHLWAPI.dll")
int SHGlobalCounterDecrement(const(SHGLOBALCOUNTER) id);

@DllImport("SHLWAPI.dll")
HANDLE SHAllocShared(char* pvData, uint dwSize, uint dwProcessId);

@DllImport("SHLWAPI.dll")
BOOL SHFreeShared(HANDLE hData, uint dwProcessId);

@DllImport("SHLWAPI.dll")
void* SHLockShared(HANDLE hData, uint dwProcessId);

@DllImport("SHLWAPI.dll")
BOOL SHUnlockShared(char* pvData);

@DllImport("SHLWAPI.dll")
uint WhichPlatform();

@DllImport("SHLWAPI.dll")
HRESULT QISearch(void* that, QITAB* pqit, const(Guid)* riid, void** ppv);

@DllImport("SHLWAPI.dll")
BOOL SHIsLowMemoryMachine(uint dwType);

@DllImport("SHLWAPI.dll")
int GetMenuPosFromID(HMENU hmenu, uint id);

@DllImport("SHLWAPI.dll")
HRESULT SHGetInverseCMAP(char* pbMap, uint cbMap);

@DllImport("SHLWAPI.dll")
HRESULT SHAutoComplete(HWND hwndEdit, uint dwFlags);

@DllImport("SHLWAPI.dll")
HRESULT SHCreateThreadRef(int* pcRef, IUnknown* ppunk);

@DllImport("SHLWAPI.dll")
HRESULT SHSetThreadRef(IUnknown punk);

@DllImport("SHLWAPI.dll")
HRESULT SHGetThreadRef(IUnknown* ppunk);

@DllImport("SHLWAPI.dll")
BOOL SHSkipJunction(IBindCtx pbc, const(Guid)* pclsid);

@DllImport("SHLWAPI.dll")
BOOL SHCreateThread(LPTHREAD_START_ROUTINE pfnThreadProc, void* pData, uint flags, LPTHREAD_START_ROUTINE pfnCallback);

@DllImport("SHLWAPI.dll")
BOOL SHCreateThreadWithHandle(LPTHREAD_START_ROUTINE pfnThreadProc, void* pData, uint flags, LPTHREAD_START_ROUTINE pfnCallback, HANDLE* pHandle);

@DllImport("SHLWAPI.dll")
HRESULT SHReleaseThreadRef();

@DllImport("SHLWAPI.dll")
HPALETTE SHCreateShellPalette(HDC hdc);

@DllImport("SHLWAPI.dll")
void ColorRGBToHLS(uint clrRGB, ushort* pwHue, ushort* pwLuminance, ushort* pwSaturation);

@DllImport("SHLWAPI.dll")
uint ColorHLSToRGB(ushort wHue, ushort wLuminance, ushort wSaturation);

@DllImport("SHLWAPI.dll")
uint ColorAdjustLuma(uint clrRGB, int n, BOOL fScale);

@DllImport("SHLWAPI.dll")
BOOL IsInternetESCEnabled();

@DllImport("hlink.dll")
HRESULT HlinkCreateFromMoniker(IMoniker pimkTrgt, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName, IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateFromString(const(wchar)* pwzTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName, IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateFromData(IDataObject piDataObj, IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkQueryCreateFromData(IDataObject piDataObj);

@DllImport("hlink.dll")
HRESULT HlinkClone(IHlink pihl, const(Guid)* riid, IHlinkSite pihlsiteForClone, uint dwSiteData, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkCreateBrowseContext(IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkNavigateToStringReference(const(wchar)* pwzTarget, const(wchar)* pwzLocation, IHlinkSite pihlsite, uint dwSiteData, IHlinkFrame pihlframe, uint grfHLNF, IBindCtx pibc, IBindStatusCallback pibsc, IHlinkBrowseContext pihlbc);

@DllImport("hlink.dll")
HRESULT HlinkNavigate(IHlink pihl, IHlinkFrame pihlframe, uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, IHlinkBrowseContext pihlbc);

@DllImport("hlink.dll")
HRESULT HlinkOnNavigate(IHlinkFrame pihlframe, IHlinkBrowseContext pihlbc, uint grfHLNF, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName, uint* puHLID);

@DllImport("hlink.dll")
HRESULT HlinkUpdateStackItem(IHlinkFrame pihlframe, IHlinkBrowseContext pihlbc, uint uHLID, IMoniker pimkTrgt, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName);

@DllImport("hlink.dll")
HRESULT HlinkOnRenameDocument(uint dwReserved, IHlinkBrowseContext pihlbc, IMoniker pimkOld, IMoniker pimkNew);

@DllImport("hlink.dll")
HRESULT HlinkResolveMonikerForData(IMoniker pimkReference, uint reserved, IBindCtx pibc, uint cFmtetc, FORMATETC* rgFmtetc, IBindStatusCallback pibsc, IMoniker pimkBase);

@DllImport("hlink.dll")
HRESULT HlinkResolveStringForData(const(wchar)* pwzReference, uint reserved, IBindCtx pibc, uint cFmtetc, FORMATETC* rgFmtetc, IBindStatusCallback pibsc, IMoniker pimkBase);

@DllImport("hlink.dll")
HRESULT HlinkParseDisplayName(IBindCtx pibc, const(wchar)* pwzDisplayName, BOOL fNoForceAbs, uint* pcchEaten, IMoniker* ppimk);

@DllImport("hlink.dll")
HRESULT HlinkCreateExtensionServices(const(wchar)* pwzAdditionalHeaders, HWND phwnd, const(wchar)* pszUsername, const(wchar)* pszPassword, IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkPreprocessMoniker(IBindCtx pibc, IMoniker pimkIn, IMoniker* ppimkOut);

@DllImport("hlink.dll")
HRESULT OleSaveToStreamEx(IUnknown piunk, IStream pistm, BOOL fClearDirty);

@DllImport("hlink.dll")
HRESULT HlinkSetSpecialReference(uint uReference, const(wchar)* pwzReference);

@DllImport("hlink.dll")
HRESULT HlinkGetSpecialReference(uint uReference, ushort** ppwzReference);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcut(uint grfHLSHORTCUTF, IHlink pihl, const(wchar)* pwzDir, const(wchar)* pwzFileName, ushort** ppwzShortcutFile, uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcutFromMoniker(uint grfHLSHORTCUTF, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzDir, const(wchar)* pwzFileName, ushort** ppwzShortcutFile, uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkCreateShortcutFromString(uint grfHLSHORTCUTF, const(wchar)* pwzTarget, const(wchar)* pwzLocation, const(wchar)* pwzDir, const(wchar)* pwzFileName, ushort** ppwzShortcutFile, uint dwReserved);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcut(const(wchar)* pwzShortcutFileName, IHlinkSite pihlsite, uint dwSiteData, IUnknown piunkOuter, const(Guid)* riid, void** ppvObj);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcutToMoniker(const(wchar)* pwzShortcutFileName, IMoniker* ppimkTarget, ushort** ppwzLocation);

@DllImport("hlink.dll")
HRESULT HlinkResolveShortcutToString(const(wchar)* pwzShortcutFileName, ushort** ppwzTarget, ushort** ppwzLocation);

@DllImport("hlink.dll")
HRESULT HlinkIsShortcut(const(wchar)* pwzFileName);

@DllImport("hlink.dll")
HRESULT HlinkGetValueFromParams(const(wchar)* pwzParams, const(wchar)* pwzName, ushort** ppwzValue);

@DllImport("hlink.dll")
HRESULT HlinkTranslateURL(const(wchar)* pwzURL, uint grfFlags, ushort** ppwzTranslatedURL);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
BOOL PathIsUNCEx(const(wchar)* pszPath, ushort** ppszServer);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
BOOL PathCchIsRoot(const(wchar)* pszPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddBackslashEx(const(wchar)* pszPath, uint cchPath, ushort** ppszEnd, uint* pcchRemaining);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddBackslash(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveBackslashEx(const(wchar)* pszPath, uint cchPath, ushort** ppszEnd, uint* pcchRemaining);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveBackslash(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchSkipRoot(const(wchar)* pszPath, ushort** ppszRootEnd);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchStripToRoot(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveFileSpec(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchFindExtension(const(wchar)* pszPath, uint cchPath, ushort** ppszExt);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAddExtension(const(wchar)* pszPath, uint cchPath, const(wchar)* pszExt);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRenameExtension(const(wchar)* pszPath, uint cchPath, const(wchar)* pszExt);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchRemoveExtension(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCanonicalizeEx(const(wchar)* pszPathOut, uint cchPathOut, const(wchar)* pszPathIn, uint dwFlags);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCanonicalize(const(wchar)* pszPathOut, uint cchPathOut, const(wchar)* pszPathIn);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCombineEx(const(wchar)* pszPathOut, uint cchPathOut, const(wchar)* pszPathIn, const(wchar)* pszMore, uint dwFlags);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchCombine(const(wchar)* pszPathOut, uint cchPathOut, const(wchar)* pszPathIn, const(wchar)* pszMore);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAppendEx(const(wchar)* pszPath, uint cchPath, const(wchar)* pszMore, uint dwFlags);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchAppend(const(wchar)* pszPath, uint cchPath, const(wchar)* pszMore);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathCchStripPrefix(const(wchar)* pszPath, uint cchPath);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathAllocCombine(const(wchar)* pszPathIn, const(wchar)* pszMore, uint dwFlags, ushort** ppszPathOut);

@DllImport("api-ms-win-core-path-l1-1-0.dll")
HRESULT PathAllocCanonicalize(const(wchar)* pszPathIn, uint dwFlags, ushort** ppszPathOut);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-0.dll")
uint RegisterAppStateChangeNotification(PAPPSTATE_CHANGE_ROUTINE Routine, void* Context, _APPSTATE_REGISTRATION** Registration);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-0.dll")
void UnregisterAppStateChangeNotification(_APPSTATE_REGISTRATION* Registration);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-1.dll")
uint RegisterAppConstrainedChangeNotification(PAPPCONSTRAIN_CHANGE_ROUTINE Routine, void* Context, _APPCONSTRAIN_REGISTRATION** Registration);

@DllImport("api-ms-win-core-psm-appnotify-l1-1-1.dll")
void UnregisterAppConstrainedChangeNotification(_APPCONSTRAIN_REGISTRATION* Registration);

const GUID IID_INotifyReplica = {0x99180163, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x99180163, 0xDA16, 0x101A, [0x93, 0x5C, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface INotifyReplica : IUnknown
{
    HRESULT YouAreAReplica(uint ulcOtherReplicas, char* rgpmkOtherReplicas);
}

struct HELPINFO
{
    uint cbSize;
    int iContextType;
    int iCtrlId;
    HANDLE hItemHandle;
    uint dwContextId;
    POINT MousePos;
}

struct MULTIKEYHELPA
{
    uint mkSize;
    byte mkKeylist;
    byte szKeyphrase;
}

struct MULTIKEYHELPW
{
    uint mkSize;
    ushort mkKeylist;
    ushort szKeyphrase;
}

struct HELPWININFOA
{
    int wStructSize;
    int x;
    int y;
    int dx;
    int dy;
    int wMax;
    byte rgchMember;
}

struct HELPWININFOW
{
    int wStructSize;
    int x;
    int y;
    int dx;
    int dy;
    int wMax;
    ushort rgchMember;
}

struct APPCATEGORYINFO
{
    uint Locale;
    const(wchar)* pszDescription;
    Guid AppCategoryId;
}

struct APPCATEGORYINFOLIST
{
    uint cCategory;
    APPCATEGORYINFO* pCategoryInfo;
}

const GUID IID_IInitializeWithFile = {0xB7D14566, 0x0509, 0x4CCE, [0xA7, 0x1F, 0x0A, 0x55, 0x42, 0x33, 0xBD, 0x9B]};
@GUID(0xB7D14566, 0x0509, 0x4CCE, [0xA7, 0x1F, 0x0A, 0x55, 0x42, 0x33, 0xBD, 0x9B]);
interface IInitializeWithFile : IUnknown
{
    HRESULT Initialize(const(wchar)* pszFilePath, uint grfMode);
}

const GUID IID_IInitializeWithStream = {0xB824B49D, 0x22AC, 0x4161, [0xAC, 0x8A, 0x99, 0x16, 0xE8, 0xFA, 0x3F, 0x7F]};
@GUID(0xB824B49D, 0x22AC, 0x4161, [0xAC, 0x8A, 0x99, 0x16, 0xE8, 0xFA, 0x3F, 0x7F]);
interface IInitializeWithStream : IUnknown
{
    HRESULT Initialize(IStream pstream, uint grfMode);
}

const GUID IID_INamedPropertyStore = {0x71604B0F, 0x97B0, 0x4764, [0x85, 0x77, 0x2F, 0x13, 0xE9, 0x8A, 0x14, 0x22]};
@GUID(0x71604B0F, 0x97B0, 0x4764, [0x85, 0x77, 0x2F, 0x13, 0xE9, 0x8A, 0x14, 0x22]);
interface INamedPropertyStore : IUnknown
{
    HRESULT GetNamedValue(const(wchar)* pszName, PROPVARIANT* ppropvar);
    HRESULT SetNamedValue(const(wchar)* pszName, const(PROPVARIANT)* propvar);
    HRESULT GetNameCount(uint* pdwCount);
    HRESULT GetNameAt(uint iProp, BSTR* pbstrName);
}

const GUID IID_IObjectWithPropertyKey = {0xFC0CA0A7, 0xC316, 0x4FD2, [0x90, 0x31, 0x3E, 0x62, 0x8E, 0x6D, 0x4F, 0x23]};
@GUID(0xFC0CA0A7, 0xC316, 0x4FD2, [0x90, 0x31, 0x3E, 0x62, 0x8E, 0x6D, 0x4F, 0x23]);
interface IObjectWithPropertyKey : IUnknown
{
    HRESULT SetPropertyKey(const(PROPERTYKEY)* key);
    HRESULT GetPropertyKey(PROPERTYKEY* pkey);
}

const GUID IID_IDelayedPropertyStoreFactory = {0x40D4577F, 0xE237, 0x4BDB, [0xBD, 0x69, 0x58, 0xF0, 0x89, 0x43, 0x1B, 0x6A]};
@GUID(0x40D4577F, 0xE237, 0x4BDB, [0xBD, 0x69, 0x58, 0xF0, 0x89, 0x43, 0x1B, 0x6A]);
interface IDelayedPropertyStoreFactory : IPropertyStoreFactory
{
    HRESULT GetDelayedPropertyStore(GETPROPERTYSTOREFLAGS flags, uint dwStoreId, const(Guid)* riid, void** ppv);
}

const GUID IID_IPersistSerializedPropStorage = {0xE318AD57, 0x0AA0, 0x450F, [0xAC, 0xA5, 0x6F, 0xAB, 0x71, 0x03, 0xD9, 0x17]};
@GUID(0xE318AD57, 0x0AA0, 0x450F, [0xAC, 0xA5, 0x6F, 0xAB, 0x71, 0x03, 0xD9, 0x17]);
interface IPersistSerializedPropStorage : IUnknown
{
    HRESULT SetFlags(int flags);
    HRESULT SetPropertyStorage(char* psps, uint cb);
    HRESULT GetPropertyStorage(SERIALIZEDPROPSTORAGE** ppsps, uint* pcb);
}

const GUID IID_IPersistSerializedPropStorage2 = {0x77EFFA68, 0x4F98, 0x4366, [0xBA, 0x72, 0x57, 0x3B, 0x3D, 0x88, 0x05, 0x71]};
@GUID(0x77EFFA68, 0x4F98, 0x4366, [0xBA, 0x72, 0x57, 0x3B, 0x3D, 0x88, 0x05, 0x71]);
interface IPersistSerializedPropStorage2 : IPersistSerializedPropStorage
{
    HRESULT GetPropertyStorageSize(uint* pcb);
    HRESULT GetPropertyStorageBuffer(char* psps, uint cb, uint* pcbWritten);
}

const GUID IID_ICreateObject = {0x75121952, 0xE0D0, 0x43E5, [0x93, 0x80, 0x1D, 0x80, 0x48, 0x3A, 0xCF, 0x72]};
@GUID(0x75121952, 0xE0D0, 0x43E5, [0x93, 0x80, 0x1D, 0x80, 0x48, 0x3A, 0xCF, 0x72]);
interface ICreateObject : IUnknown
{
    HRESULT CreateObject(const(Guid)* clsid, IUnknown pUnkOuter, const(Guid)* riid, void** ppv);
}

struct HDROP__
{
    int unused;
}

struct DRAGINFOA
{
    uint uSize;
    POINT pt;
    BOOL fNC;
    const(char)* lpFileList;
    uint grfKeyState;
}

struct DRAGINFOW
{
    uint uSize;
    POINT pt;
    BOOL fNC;
    const(wchar)* lpFileList;
    uint grfKeyState;
}

struct APPBARDATA
{
    uint cbSize;
    HWND hWnd;
    uint uCallbackMessage;
    uint uEdge;
    RECT rc;
    LPARAM lParam;
}

struct SHFILEOPSTRUCTA
{
    HWND hwnd;
    uint wFunc;
    byte* pFrom;
    byte* pTo;
    ushort fFlags;
    BOOL fAnyOperationsAborted;
    void* hNameMappings;
    const(char)* lpszProgressTitle;
}

struct SHFILEOPSTRUCTW
{
    HWND hwnd;
    uint wFunc;
    const(wchar)* pFrom;
    const(wchar)* pTo;
    ushort fFlags;
    BOOL fAnyOperationsAborted;
    void* hNameMappings;
    const(wchar)* lpszProgressTitle;
}

struct SHNAMEMAPPINGA
{
    const(char)* pszOldPath;
    const(char)* pszNewPath;
    int cchOldPath;
    int cchNewPath;
}

struct SHNAMEMAPPINGW
{
    const(wchar)* pszOldPath;
    const(wchar)* pszNewPath;
    int cchOldPath;
    int cchNewPath;
}

struct SHELLEXECUTEINFOA
{
    uint cbSize;
    uint fMask;
    HWND hwnd;
    const(char)* lpVerb;
    const(char)* lpFile;
    const(char)* lpParameters;
    const(char)* lpDirectory;
    int nShow;
    HINSTANCE hInstApp;
    void* lpIDList;
    const(char)* lpClass;
    HKEY hkeyClass;
    uint dwHotKey;
    _Anonymous_e__Union Anonymous;
    HANDLE hProcess;
}

struct SHELLEXECUTEINFOW
{
    uint cbSize;
    uint fMask;
    HWND hwnd;
    const(wchar)* lpVerb;
    const(wchar)* lpFile;
    const(wchar)* lpParameters;
    const(wchar)* lpDirectory;
    int nShow;
    HINSTANCE hInstApp;
    void* lpIDList;
    const(wchar)* lpClass;
    HKEY hkeyClass;
    uint dwHotKey;
    _Anonymous_e__Union Anonymous;
    HANDLE hProcess;
}

struct SHCREATEPROCESSINFOW
{
    uint cbSize;
    uint fMask;
    HWND hwnd;
    const(wchar)* pszFile;
    const(wchar)* pszParameters;
    const(wchar)* pszCurrentDirectory;
    HANDLE hUserToken;
    SECURITY_ATTRIBUTES* lpProcessAttributes;
    SECURITY_ATTRIBUTES* lpThreadAttributes;
    BOOL bInheritHandles;
    uint dwCreationFlags;
    STARTUPINFOW* lpStartupInfo;
    PROCESS_INFORMATION* lpProcessInformation;
}

enum ASSOCCLASS
{
    ASSOCCLASS_SHELL_KEY = 0,
    ASSOCCLASS_PROGID_KEY = 1,
    ASSOCCLASS_PROGID_STR = 2,
    ASSOCCLASS_CLSID_KEY = 3,
    ASSOCCLASS_CLSID_STR = 4,
    ASSOCCLASS_APP_KEY = 5,
    ASSOCCLASS_APP_STR = 6,
    ASSOCCLASS_SYSTEM_STR = 7,
    ASSOCCLASS_FOLDER = 8,
    ASSOCCLASS_STAR = 9,
    ASSOCCLASS_FIXED_PROGID_STR = 10,
    ASSOCCLASS_PROTOCOL_STR = 11,
}

struct ASSOCIATIONELEMENT
{
    ASSOCCLASS ac;
    HKEY hkClass;
    const(wchar)* pszClass;
}

struct SHQUERYRBINFO
{
    uint cbSize;
    long i64Size;
    long i64NumItems;
}

enum QUERY_USER_NOTIFICATION_STATE
{
    QUNS_NOT_PRESENT = 1,
    QUNS_BUSY = 2,
    QUNS_RUNNING_D3D_FULL_SCREEN = 3,
    QUNS_PRESENTATION_MODE = 4,
    QUNS_ACCEPTS_NOTIFICATIONS = 5,
    QUNS_QUIET_TIME = 6,
    QUNS_APP = 7,
}

struct NOTIFYICONDATAA
{
    uint cbSize;
    HWND hWnd;
    uint uID;
    uint uFlags;
    uint uCallbackMessage;
    HICON hIcon;
    byte szTip;
    uint dwState;
    uint dwStateMask;
    byte szInfo;
    _Anonymous_e__Union Anonymous;
    byte szInfoTitle;
    uint dwInfoFlags;
    Guid guidItem;
    HICON hBalloonIcon;
}

struct NOTIFYICONDATAW
{
    uint cbSize;
    HWND hWnd;
    uint uID;
    uint uFlags;
    uint uCallbackMessage;
    HICON hIcon;
    ushort szTip;
    uint dwState;
    uint dwStateMask;
    ushort szInfo;
    _Anonymous_e__Union Anonymous;
    ushort szInfoTitle;
    uint dwInfoFlags;
    Guid guidItem;
    HICON hBalloonIcon;
}

struct NOTIFYICONIDENTIFIER
{
    uint cbSize;
    HWND hWnd;
    uint uID;
    Guid guidItem;
}

struct SHFILEINFOA
{
    HICON hIcon;
    int iIcon;
    uint dwAttributes;
    byte szDisplayName;
    byte szTypeName;
}

struct SHFILEINFOW
{
    HICON hIcon;
    int iIcon;
    uint dwAttributes;
    ushort szDisplayName;
    ushort szTypeName;
}

struct SHSTOCKICONINFO
{
    uint cbSize;
    HICON hIcon;
    int iSysImageIndex;
    int iIcon;
    ushort szPath;
}

enum SHSTOCKICONID
{
    SIID_DOCNOASSOC = 0,
    SIID_DOCASSOC = 1,
    SIID_APPLICATION = 2,
    SIID_FOLDER = 3,
    SIID_FOLDEROPEN = 4,
    SIID_DRIVE525 = 5,
    SIID_DRIVE35 = 6,
    SIID_DRIVEREMOVE = 7,
    SIID_DRIVEFIXED = 8,
    SIID_DRIVENET = 9,
    SIID_DRIVENETDISABLED = 10,
    SIID_DRIVECD = 11,
    SIID_DRIVERAM = 12,
    SIID_WORLD = 13,
    SIID_SERVER = 15,
    SIID_PRINTER = 16,
    SIID_MYNETWORK = 17,
    SIID_FIND = 22,
    SIID_HELP = 23,
    SIID_SHARE = 28,
    SIID_LINK = 29,
    SIID_SLOWFILE = 30,
    SIID_RECYCLER = 31,
    SIID_RECYCLERFULL = 32,
    SIID_MEDIACDAUDIO = 40,
    SIID_LOCK = 47,
    SIID_AUTOLIST = 49,
    SIID_PRINTERNET = 50,
    SIID_SERVERSHARE = 51,
    SIID_PRINTERFAX = 52,
    SIID_PRINTERFAXNET = 53,
    SIID_PRINTERFILE = 54,
    SIID_STACK = 55,
    SIID_MEDIASVCD = 56,
    SIID_STUFFEDFOLDER = 57,
    SIID_DRIVEUNKNOWN = 58,
    SIID_DRIVEDVD = 59,
    SIID_MEDIADVD = 60,
    SIID_MEDIADVDRAM = 61,
    SIID_MEDIADVDRW = 62,
    SIID_MEDIADVDR = 63,
    SIID_MEDIADVDROM = 64,
    SIID_MEDIACDAUDIOPLUS = 65,
    SIID_MEDIACDRW = 66,
    SIID_MEDIACDR = 67,
    SIID_MEDIACDBURN = 68,
    SIID_MEDIABLANKCD = 69,
    SIID_MEDIACDROM = 70,
    SIID_AUDIOFILES = 71,
    SIID_IMAGEFILES = 72,
    SIID_VIDEOFILES = 73,
    SIID_MIXEDFILES = 74,
    SIID_FOLDERBACK = 75,
    SIID_FOLDERFRONT = 76,
    SIID_SHIELD = 77,
    SIID_WARNING = 78,
    SIID_INFO = 79,
    SIID_ERROR = 80,
    SIID_KEY = 81,
    SIID_SOFTWARE = 82,
    SIID_RENAME = 83,
    SIID_DELETE = 84,
    SIID_MEDIAAUDIODVD = 85,
    SIID_MEDIAMOVIEDVD = 86,
    SIID_MEDIAENHANCEDCD = 87,
    SIID_MEDIAENHANCEDDVD = 88,
    SIID_MEDIAHDDVD = 89,
    SIID_MEDIABLURAY = 90,
    SIID_MEDIAVCD = 91,
    SIID_MEDIADVDPLUSR = 92,
    SIID_MEDIADVDPLUSRW = 93,
    SIID_DESKTOPPC = 94,
    SIID_MOBILEPC = 95,
    SIID_USERS = 96,
    SIID_MEDIASMARTMEDIA = 97,
    SIID_MEDIACOMPACTFLASH = 98,
    SIID_DEVICECELLPHONE = 99,
    SIID_DEVICECAMERA = 100,
    SIID_DEVICEVIDEOCAMERA = 101,
    SIID_DEVICEAUDIOPLAYER = 102,
    SIID_NETWORKCONNECT = 103,
    SIID_INTERNET = 104,
    SIID_ZIPFILE = 105,
    SIID_SETTINGS = 106,
    SIID_DRIVEHDDVD = 132,
    SIID_DRIVEBD = 133,
    SIID_MEDIAHDDVDROM = 134,
    SIID_MEDIAHDDVDR = 135,
    SIID_MEDIAHDDVDRAM = 136,
    SIID_MEDIABDROM = 137,
    SIID_MEDIABDR = 138,
    SIID_MEDIABDRE = 139,
    SIID_CLUSTEREDDRIVE = 140,
    SIID_MAX_ICONS = 181,
}

struct OPEN_PRINTER_PROPS_INFOA
{
    uint dwSize;
    const(char)* pszSheetName;
    uint uSheetIndex;
    uint dwFlags;
    BOOL bModal;
}

struct OPEN_PRINTER_PROPS_INFOW
{
    uint dwSize;
    const(wchar)* pszSheetName;
    uint uSheetIndex;
    uint dwFlags;
    BOOL bModal;
}

alias PFNCANSHAREFOLDERW = extern(Windows) HRESULT function(const(wchar)* pszPath);
alias PFNSHOWSHAREFOLDERUIW = extern(Windows) HRESULT function(HWND hwndParent, const(wchar)* pszPath);
struct IMarkupCallback
{
}

struct IControlMarkup
{
}

const GUID CLSID_QueryCancelAutoPlay = {0x331F1768, 0x05A9, 0x4DDD, [0xB8, 0x6E, 0xDA, 0xE3, 0x4D, 0xDC, 0x99, 0x8A]};
@GUID(0x331F1768, 0x05A9, 0x4DDD, [0xB8, 0x6E, 0xDA, 0xE3, 0x4D, 0xDC, 0x99, 0x8A]);
struct QueryCancelAutoPlay;

const GUID CLSID_TimeCategorizer = {0x3BB4118F, 0xDDFD, 0x4D30, [0xA3, 0x48, 0x9F, 0xB5, 0xD6, 0xBF, 0x1A, 0xFE]};
@GUID(0x3BB4118F, 0xDDFD, 0x4D30, [0xA3, 0x48, 0x9F, 0xB5, 0xD6, 0xBF, 0x1A, 0xFE]);
struct TimeCategorizer;

const GUID CLSID_AlphabeticalCategorizer = {0x3C2654C6, 0x7372, 0x4F6B, [0xB3, 0x10, 0x55, 0xD6, 0x12, 0x8F, 0x49, 0xD2]};
@GUID(0x3C2654C6, 0x7372, 0x4F6B, [0xB3, 0x10, 0x55, 0xD6, 0x12, 0x8F, 0x49, 0xD2]);
struct AlphabeticalCategorizer;

const GUID CLSID_MergedCategorizer = {0x8E827C11, 0x33E7, 0x4BC1, [0xB2, 0x42, 0x8C, 0xD9, 0xA1, 0xC2, 0xB3, 0x04]};
@GUID(0x8E827C11, 0x33E7, 0x4BC1, [0xB2, 0x42, 0x8C, 0xD9, 0xA1, 0xC2, 0xB3, 0x04]);
struct MergedCategorizer;

const GUID CLSID_ImageProperties = {0x7AB770C7, 0x0E23, 0x4D7A, [0x8A, 0xA2, 0x19, 0xBF, 0xAD, 0x47, 0x98, 0x29]};
@GUID(0x7AB770C7, 0x0E23, 0x4D7A, [0x8A, 0xA2, 0x19, 0xBF, 0xAD, 0x47, 0x98, 0x29]);
struct ImageProperties;

const GUID CLSID_CDBurn = {0xFBEB8A05, 0xBEEE, 0x4442, [0x80, 0x4E, 0x40, 0x9D, 0x6C, 0x45, 0x15, 0xE9]};
@GUID(0xFBEB8A05, 0xBEEE, 0x4442, [0x80, 0x4E, 0x40, 0x9D, 0x6C, 0x45, 0x15, 0xE9]);
struct CDBurn;

const GUID CLSID_StartMenuPin = {0xA2A9545D, 0xA0C2, 0x42B4, [0x97, 0x08, 0xA0, 0xB2, 0xBA, 0xDD, 0x77, 0xC8]};
@GUID(0xA2A9545D, 0xA0C2, 0x42B4, [0x97, 0x08, 0xA0, 0xB2, 0xBA, 0xDD, 0x77, 0xC8]);
struct StartMenuPin;

const GUID CLSID_WebWizardHost = {0xC827F149, 0x55C1, 0x4D28, [0x93, 0x5E, 0x57, 0xE4, 0x7C, 0xAE, 0xD9, 0x73]};
@GUID(0xC827F149, 0x55C1, 0x4D28, [0x93, 0x5E, 0x57, 0xE4, 0x7C, 0xAE, 0xD9, 0x73]);
struct WebWizardHost;

const GUID CLSID_PublishDropTarget = {0xCC6EEFFB, 0x43F6, 0x46C5, [0x96, 0x19, 0x51, 0xD5, 0x71, 0x96, 0x7F, 0x7D]};
@GUID(0xCC6EEFFB, 0x43F6, 0x46C5, [0x96, 0x19, 0x51, 0xD5, 0x71, 0x96, 0x7F, 0x7D]);
struct PublishDropTarget;

const GUID CLSID_PublishingWizard = {0x6B33163C, 0x76A5, 0x4B6C, [0xBF, 0x21, 0x45, 0xDE, 0x9C, 0xD5, 0x03, 0xA1]};
@GUID(0x6B33163C, 0x76A5, 0x4B6C, [0xBF, 0x21, 0x45, 0xDE, 0x9C, 0xD5, 0x03, 0xA1]);
struct PublishingWizard;

const GUID CLSID_InternetPrintOrdering = {0xADD36AA8, 0x751A, 0x4579, [0xA2, 0x66, 0xD6, 0x6F, 0x52, 0x02, 0xCC, 0xBB]};
@GUID(0xADD36AA8, 0x751A, 0x4579, [0xA2, 0x66, 0xD6, 0x6F, 0x52, 0x02, 0xCC, 0xBB]);
struct InternetPrintOrdering;

const GUID CLSID_FolderViewHost = {0x20B1CB23, 0x6968, 0x4EB9, [0xB7, 0xD4, 0xA6, 0x6D, 0x00, 0xD0, 0x7C, 0xEE]};
@GUID(0x20B1CB23, 0x6968, 0x4EB9, [0xB7, 0xD4, 0xA6, 0x6D, 0x00, 0xD0, 0x7C, 0xEE]);
struct FolderViewHost;

const GUID CLSID_ExplorerBrowser = {0x71F96385, 0xDDD6, 0x48D3, [0xA0, 0xC1, 0xAE, 0x06, 0xE8, 0xB0, 0x55, 0xFB]};
@GUID(0x71F96385, 0xDDD6, 0x48D3, [0xA0, 0xC1, 0xAE, 0x06, 0xE8, 0xB0, 0x55, 0xFB]);
struct ExplorerBrowser;

const GUID CLSID_ImageRecompress = {0x6E33091C, 0xD2F8, 0x4740, [0xB5, 0x5E, 0x2E, 0x11, 0xD1, 0x47, 0x7A, 0x2C]};
@GUID(0x6E33091C, 0xD2F8, 0x4740, [0xB5, 0x5E, 0x2E, 0x11, 0xD1, 0x47, 0x7A, 0x2C]);
struct ImageRecompress;

const GUID CLSID_TrayBandSiteService = {0xF60AD0A0, 0xE5E1, 0x45CB, [0xB5, 0x1A, 0xE1, 0x5B, 0x9F, 0x8B, 0x29, 0x34]};
@GUID(0xF60AD0A0, 0xE5E1, 0x45CB, [0xB5, 0x1A, 0xE1, 0x5B, 0x9F, 0x8B, 0x29, 0x34]);
struct TrayBandSiteService;

const GUID CLSID_TrayDeskBand = {0xE6442437, 0x6C68, 0x4F52, [0x94, 0xDD, 0x2C, 0xFE, 0xD2, 0x67, 0xEF, 0xB9]};
@GUID(0xE6442437, 0x6C68, 0x4F52, [0x94, 0xDD, 0x2C, 0xFE, 0xD2, 0x67, 0xEF, 0xB9]);
struct TrayDeskBand;

const GUID CLSID_AttachmentServices = {0x4125DD96, 0xE03A, 0x4103, [0x8F, 0x70, 0xE0, 0x59, 0x7D, 0x80, 0x3B, 0x9C]};
@GUID(0x4125DD96, 0xE03A, 0x4103, [0x8F, 0x70, 0xE0, 0x59, 0x7D, 0x80, 0x3B, 0x9C]);
struct AttachmentServices;

const GUID CLSID_DocPropShellExtension = {0x883373C3, 0xBF89, 0x11D1, [0xBE, 0x35, 0x08, 0x00, 0x36, 0xB1, 0x1A, 0x03]};
@GUID(0x883373C3, 0xBF89, 0x11D1, [0xBE, 0x35, 0x08, 0x00, 0x36, 0xB1, 0x1A, 0x03]);
struct DocPropShellExtension;

const GUID CLSID_FSCopyHandler = {0xD197380A, 0x0A79, 0x4DC8, [0xA0, 0x33, 0xED, 0x88, 0x2C, 0x2F, 0xA1, 0x4B]};
@GUID(0xD197380A, 0x0A79, 0x4DC8, [0xA0, 0x33, 0xED, 0x88, 0x2C, 0x2F, 0xA1, 0x4B]);
struct FSCopyHandler;

const GUID CLSID_PreviousVersions = {0x596AB062, 0xB4D2, 0x4215, [0x9F, 0x74, 0xE9, 0x10, 0x9B, 0x0A, 0x81, 0x53]};
@GUID(0x596AB062, 0xB4D2, 0x4215, [0x9F, 0x74, 0xE9, 0x10, 0x9B, 0x0A, 0x81, 0x53]);
struct PreviousVersions;

const GUID CLSID_NamespaceTreeControl = {0xAE054212, 0x3535, 0x4430, [0x83, 0xED, 0xD5, 0x01, 0xAA, 0x66, 0x80, 0xE6]};
@GUID(0xAE054212, 0x3535, 0x4430, [0x83, 0xED, 0xD5, 0x01, 0xAA, 0x66, 0x80, 0xE6]);
struct NamespaceTreeControl;

const GUID CLSID_IENamespaceTreeControl = {0xACE52D03, 0xE5CD, 0x4B20, [0x82, 0xFF, 0xE7, 0x1B, 0x11, 0xBE, 0xAE, 0x1D]};
@GUID(0xACE52D03, 0xE5CD, 0x4B20, [0x82, 0xFF, 0xE7, 0x1B, 0x11, 0xBE, 0xAE, 0x1D]);
struct IENamespaceTreeControl;

const GUID CLSID_ApplicationAssociationRegistrationUI = {0x1968106D, 0xF3B5, 0x44CF, [0x89, 0x0E, 0x11, 0x6F, 0xCB, 0x9E, 0xCE, 0xF1]};
@GUID(0x1968106D, 0xF3B5, 0x44CF, [0x89, 0x0E, 0x11, 0x6F, 0xCB, 0x9E, 0xCE, 0xF1]);
struct ApplicationAssociationRegistrationUI;

const GUID CLSID_DesktopGadget = {0x924CCC1B, 0x6562, 0x4C85, [0x86, 0x57, 0xD1, 0x77, 0x92, 0x52, 0x22, 0xB6]};
@GUID(0x924CCC1B, 0x6562, 0x4C85, [0x86, 0x57, 0xD1, 0x77, 0x92, 0x52, 0x22, 0xB6]);
struct DesktopGadget;

const GUID CLSID_AccessibilityDockingService = {0x29CE1D46, 0xB481, 0x4AA0, [0xA0, 0x8A, 0xD3, 0xEB, 0xC8, 0xAC, 0xA4, 0x02]};
@GUID(0x29CE1D46, 0xB481, 0x4AA0, [0xA0, 0x8A, 0xD3, 0xEB, 0xC8, 0xAC, 0xA4, 0x02]);
struct AccessibilityDockingService;

const GUID CLSID_ExecuteFolder = {0x11DBB47C, 0xA525, 0x400B, [0x9E, 0x80, 0xA5, 0x46, 0x15, 0xA0, 0x90, 0xC0]};
@GUID(0x11DBB47C, 0xA525, 0x400B, [0x9E, 0x80, 0xA5, 0x46, 0x15, 0xA0, 0x90, 0xC0]);
struct ExecuteFolder;

const GUID CLSID_VirtualDesktopManager = {0xAA509086, 0x5CA9, 0x4C25, [0x8F, 0x95, 0x58, 0x9D, 0x3C, 0x07, 0xB4, 0x8A]};
@GUID(0xAA509086, 0x5CA9, 0x4C25, [0x8F, 0x95, 0x58, 0x9D, 0x3C, 0x07, 0xB4, 0x8A]);
struct VirtualDesktopManager;

const GUID CLSID_StorageProviderBanners = {0x7CCDF9F4, 0xE576, 0x455A, [0x8B, 0xC7, 0xF6, 0xEC, 0x68, 0xD6, 0xF0, 0x63]};
@GUID(0x7CCDF9F4, 0xE576, 0x455A, [0x8B, 0xC7, 0xF6, 0xEC, 0x68, 0xD6, 0xF0, 0x63]);
struct StorageProviderBanners;

struct SHITEMID
{
    ushort cb;
    ubyte abID;
}

struct ITEMIDLIST
{
    SHITEMID mkid;
}

enum STRRET_TYPE
{
    STRRET_WSTR = 0,
    STRRET_OFFSET = 1,
    STRRET_CSTR = 2,
}

struct STRRET
{
    uint uType;
    _Anonymous_e__Union Anonymous;
}

struct SHELLDETAILS
{
    int fmt;
    int cxChar;
    STRRET str;
}

enum PERCEIVED
{
    PERCEIVED_TYPE_FIRST = -3,
    PERCEIVED_TYPE_CUSTOM = -3,
    PERCEIVED_TYPE_UNSPECIFIED = -2,
    PERCEIVED_TYPE_FOLDER = -1,
    PERCEIVED_TYPE_UNKNOWN = 0,
    PERCEIVED_TYPE_TEXT = 1,
    PERCEIVED_TYPE_IMAGE = 2,
    PERCEIVED_TYPE_AUDIO = 3,
    PERCEIVED_TYPE_VIDEO = 4,
    PERCEIVED_TYPE_COMPRESSED = 5,
    PERCEIVED_TYPE_DOCUMENT = 6,
    PERCEIVED_TYPE_SYSTEM = 7,
    PERCEIVED_TYPE_APPLICATION = 8,
    PERCEIVED_TYPE_GAMEMEDIA = 9,
    PERCEIVED_TYPE_CONTACTS = 10,
    PERCEIVED_TYPE_LAST = 10,
}

struct COMDLG_FILTERSPEC
{
    const(wchar)* pszName;
    const(wchar)* pszSpec;
}

enum SHCOLSTATE
{
    SHCOLSTATE_DEFAULT = 0,
    SHCOLSTATE_TYPE_STR = 1,
    SHCOLSTATE_TYPE_INT = 2,
    SHCOLSTATE_TYPE_DATE = 3,
    SHCOLSTATE_TYPEMASK = 15,
    SHCOLSTATE_ONBYDEFAULT = 16,
    SHCOLSTATE_SLOW = 32,
    SHCOLSTATE_EXTENDED = 64,
    SHCOLSTATE_SECONDARYUI = 128,
    SHCOLSTATE_HIDDEN = 256,
    SHCOLSTATE_PREFER_VARCMP = 512,
    SHCOLSTATE_PREFER_FMTCMP = 1024,
    SHCOLSTATE_NOSORTBYFOLDERNESS = 2048,
    SHCOLSTATE_VIEWONLY = 65536,
    SHCOLSTATE_BATCHREAD = 131072,
    SHCOLSTATE_NO_GROUPBY = 262144,
    SHCOLSTATE_FIXED_WIDTH = 4096,
    SHCOLSTATE_NODPISCALE = 8192,
    SHCOLSTATE_FIXED_RATIO = 16384,
    SHCOLSTATE_DISPLAYMASK = 61440,
}

enum DEVICE_SCALE_FACTOR
{
    DEVICE_SCALE_FACTOR_INVALID = 0,
    SCALE_100_PERCENT = 100,
    SCALE_120_PERCENT = 120,
    SCALE_125_PERCENT = 125,
    SCALE_140_PERCENT = 140,
    SCALE_150_PERCENT = 150,
    SCALE_160_PERCENT = 160,
    SCALE_175_PERCENT = 175,
    SCALE_180_PERCENT = 180,
    SCALE_200_PERCENT = 200,
    SCALE_225_PERCENT = 225,
    SCALE_250_PERCENT = 250,
    SCALE_300_PERCENT = 300,
    SCALE_350_PERCENT = 350,
    SCALE_400_PERCENT = 400,
    SCALE_450_PERCENT = 450,
    SCALE_500_PERCENT = 500,
}

const GUID IID_IObjectArray = {0x92CA9DCD, 0x5622, 0x4BBA, [0xA8, 0x05, 0x5E, 0x9F, 0x54, 0x1B, 0xD8, 0xC9]};
@GUID(0x92CA9DCD, 0x5622, 0x4BBA, [0xA8, 0x05, 0x5E, 0x9F, 0x54, 0x1B, 0xD8, 0xC9]);
interface IObjectArray : IUnknown
{
    HRESULT GetCount(uint* pcObjects);
    HRESULT GetAt(uint uiIndex, const(Guid)* riid, void** ppv);
}

const GUID IID_IObjectCollection = {0x5632B1A4, 0xE38A, 0x400A, [0x92, 0x8A, 0xD4, 0xCD, 0x63, 0x23, 0x02, 0x95]};
@GUID(0x5632B1A4, 0xE38A, 0x400A, [0x92, 0x8A, 0xD4, 0xCD, 0x63, 0x23, 0x02, 0x95]);
interface IObjectCollection : IObjectArray
{
    HRESULT AddObject(IUnknown punk);
    HRESULT AddFromArray(IObjectArray poaSource);
    HRESULT RemoveObjectAt(uint uiIndex);
    HRESULT Clear();
}

const GUID CLSID_DesktopWallpaper = {0xC2CF3110, 0x460E, 0x4FC1, [0xB9, 0xD0, 0x8A, 0x1C, 0x0C, 0x9C, 0xC4, 0xBD]};
@GUID(0xC2CF3110, 0x460E, 0x4FC1, [0xB9, 0xD0, 0x8A, 0x1C, 0x0C, 0x9C, 0xC4, 0xBD]);
struct DesktopWallpaper;

const GUID CLSID_ShellDesktop = {0x00021400, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00021400, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
struct ShellDesktop;

const GUID CLSID_ShellFSFolder = {0xF3364BA0, 0x65B9, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x4A, 0xE8, 0x37]};
@GUID(0xF3364BA0, 0x65B9, 0x11CE, [0xA9, 0xBA, 0x00, 0xAA, 0x00, 0x4A, 0xE8, 0x37]);
struct ShellFSFolder;

const GUID CLSID_NetworkPlaces = {0x208D2C60, 0x3AEA, 0x1069, [0xA2, 0xD7, 0x08, 0x00, 0x2B, 0x30, 0x30, 0x9D]};
@GUID(0x208D2C60, 0x3AEA, 0x1069, [0xA2, 0xD7, 0x08, 0x00, 0x2B, 0x30, 0x30, 0x9D]);
struct NetworkPlaces;

const GUID CLSID_ShellLink = {0x00021401, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00021401, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
struct ShellLink;

const GUID CLSID_DriveSizeCategorizer = {0x94357B53, 0xCA29, 0x4B78, [0x83, 0xAE, 0xE8, 0xFE, 0x74, 0x09, 0x13, 0x4F]};
@GUID(0x94357B53, 0xCA29, 0x4B78, [0x83, 0xAE, 0xE8, 0xFE, 0x74, 0x09, 0x13, 0x4F]);
struct DriveSizeCategorizer;

const GUID CLSID_DriveTypeCategorizer = {0xB0A8F3CF, 0x4333, 0x4BAB, [0x88, 0x73, 0x1C, 0xCB, 0x1C, 0xAD, 0xA4, 0x8B]};
@GUID(0xB0A8F3CF, 0x4333, 0x4BAB, [0x88, 0x73, 0x1C, 0xCB, 0x1C, 0xAD, 0xA4, 0x8B]);
struct DriveTypeCategorizer;

const GUID CLSID_FreeSpaceCategorizer = {0xB5607793, 0x24AC, 0x44C7, [0x82, 0xE2, 0x83, 0x17, 0x26, 0xAA, 0x6C, 0xB7]};
@GUID(0xB5607793, 0x24AC, 0x44C7, [0x82, 0xE2, 0x83, 0x17, 0x26, 0xAA, 0x6C, 0xB7]);
struct FreeSpaceCategorizer;

const GUID CLSID_SizeCategorizer = {0x55D7B852, 0xF6D1, 0x42F2, [0xAA, 0x75, 0x87, 0x28, 0xA1, 0xB2, 0xD2, 0x64]};
@GUID(0x55D7B852, 0xF6D1, 0x42F2, [0xAA, 0x75, 0x87, 0x28, 0xA1, 0xB2, 0xD2, 0x64]);
struct SizeCategorizer;

const GUID CLSID_PropertiesUI = {0xD912F8CF, 0x0396, 0x4915, [0x88, 0x4E, 0xFB, 0x42, 0x5D, 0x32, 0x94, 0x3B]};
@GUID(0xD912F8CF, 0x0396, 0x4915, [0x88, 0x4E, 0xFB, 0x42, 0x5D, 0x32, 0x94, 0x3B]);
struct PropertiesUI;

const GUID CLSID_UserNotification = {0x0010890E, 0x8789, 0x413C, [0xAD, 0xBC, 0x48, 0xF5, 0xB5, 0x11, 0xB3, 0xAF]};
@GUID(0x0010890E, 0x8789, 0x413C, [0xAD, 0xBC, 0x48, 0xF5, 0xB5, 0x11, 0xB3, 0xAF]);
struct UserNotification;

const GUID CLSID_TaskbarList = {0x56FDF344, 0xFD6D, 0x11D0, [0x95, 0x8A, 0x00, 0x60, 0x97, 0xC9, 0xA0, 0x90]};
@GUID(0x56FDF344, 0xFD6D, 0x11D0, [0x95, 0x8A, 0x00, 0x60, 0x97, 0xC9, 0xA0, 0x90]);
struct TaskbarList;

const GUID CLSID_ShellItem = {0x9AC9FBE1, 0xE0A2, 0x4AD6, [0xB4, 0xEE, 0xE2, 0x12, 0x01, 0x3E, 0xA9, 0x17]};
@GUID(0x9AC9FBE1, 0xE0A2, 0x4AD6, [0xB4, 0xEE, 0xE2, 0x12, 0x01, 0x3E, 0xA9, 0x17]);
struct ShellItem;

const GUID CLSID_NamespaceWalker = {0x72EB61E0, 0x8672, 0x4303, [0x91, 0x75, 0xF2, 0xE4, 0xC6, 0x8B, 0x2E, 0x7C]};
@GUID(0x72EB61E0, 0x8672, 0x4303, [0x91, 0x75, 0xF2, 0xE4, 0xC6, 0x8B, 0x2E, 0x7C]);
struct NamespaceWalker;

const GUID CLSID_FileOperation = {0x3AD05575, 0x8857, 0x4850, [0x92, 0x77, 0x11, 0xB8, 0x5B, 0xDB, 0x8E, 0x09]};
@GUID(0x3AD05575, 0x8857, 0x4850, [0x92, 0x77, 0x11, 0xB8, 0x5B, 0xDB, 0x8E, 0x09]);
struct FileOperation;

const GUID CLSID_FileOpenDialog = {0xDC1C5A9C, 0xE88A, 0x4DDE, [0xA5, 0xA1, 0x60, 0xF8, 0x2A, 0x20, 0xAE, 0xF7]};
@GUID(0xDC1C5A9C, 0xE88A, 0x4DDE, [0xA5, 0xA1, 0x60, 0xF8, 0x2A, 0x20, 0xAE, 0xF7]);
struct FileOpenDialog;

const GUID CLSID_FileSaveDialog = {0xC0B4E2F3, 0xBA21, 0x4773, [0x8D, 0xBA, 0x33, 0x5E, 0xC9, 0x46, 0xEB, 0x8B]};
@GUID(0xC0B4E2F3, 0xBA21, 0x4773, [0x8D, 0xBA, 0x33, 0x5E, 0xC9, 0x46, 0xEB, 0x8B]);
struct FileSaveDialog;

const GUID CLSID_KnownFolderManager = {0x4DF0C730, 0xDF9D, 0x4AE3, [0x91, 0x53, 0xAA, 0x6B, 0x82, 0xE9, 0x79, 0x5A]};
@GUID(0x4DF0C730, 0xDF9D, 0x4AE3, [0x91, 0x53, 0xAA, 0x6B, 0x82, 0xE9, 0x79, 0x5A]);
struct KnownFolderManager;

const GUID CLSID_SharingConfigurationManager = {0x49F371E1, 0x8C5C, 0x4D9C, [0x9A, 0x3B, 0x54, 0xA6, 0x82, 0x7F, 0x51, 0x3C]};
@GUID(0x49F371E1, 0x8C5C, 0x4D9C, [0x9A, 0x3B, 0x54, 0xA6, 0x82, 0x7F, 0x51, 0x3C]);
struct SharingConfigurationManager;

const GUID CLSID_NetworkConnections = {0x7007ACC7, 0x3202, 0x11D1, [0xAA, 0xD2, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]};
@GUID(0x7007ACC7, 0x3202, 0x11D1, [0xAA, 0xD2, 0x00, 0x80, 0x5F, 0xC1, 0x27, 0x0E]);
struct NetworkConnections;

const GUID CLSID_ScheduledTasks = {0xD6277990, 0x4C6A, 0x11CF, [0x8D, 0x87, 0x00, 0xAA, 0x00, 0x60, 0xF5, 0xBF]};
@GUID(0xD6277990, 0x4C6A, 0x11CF, [0x8D, 0x87, 0x00, 0xAA, 0x00, 0x60, 0xF5, 0xBF]);
struct ScheduledTasks;

const GUID CLSID_ApplicationAssociationRegistration = {0x591209C7, 0x767B, 0x42B2, [0x9F, 0xBA, 0x44, 0xEE, 0x46, 0x15, 0xF2, 0xC7]};
@GUID(0x591209C7, 0x767B, 0x42B2, [0x9F, 0xBA, 0x44, 0xEE, 0x46, 0x15, 0xF2, 0xC7]);
struct ApplicationAssociationRegistration;

const GUID CLSID_SearchFolderItemFactory = {0x14010E02, 0xBBBD, 0x41F0, [0x88, 0xE3, 0xED, 0xA3, 0x71, 0x21, 0x65, 0x84]};
@GUID(0x14010E02, 0xBBBD, 0x41F0, [0x88, 0xE3, 0xED, 0xA3, 0x71, 0x21, 0x65, 0x84]);
struct SearchFolderItemFactory;

const GUID CLSID_OpenControlPanel = {0x06622D85, 0x6856, 0x4460, [0x8D, 0xE1, 0xA8, 0x19, 0x21, 0xB4, 0x1C, 0x4B]};
@GUID(0x06622D85, 0x6856, 0x4460, [0x8D, 0xE1, 0xA8, 0x19, 0x21, 0xB4, 0x1C, 0x4B]);
struct OpenControlPanel;

const GUID CLSID_MailRecipient = {0x9E56BE60, 0xC50F, 0x11CF, [0x9A, 0x2C, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xCE]};
@GUID(0x9E56BE60, 0xC50F, 0x11CF, [0x9A, 0x2C, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xCE]);
struct MailRecipient;

const GUID CLSID_NetworkExplorerFolder = {0xF02C1A0D, 0xBE21, 0x4350, [0x88, 0xB0, 0x73, 0x67, 0xFC, 0x96, 0xEF, 0x3C]};
@GUID(0xF02C1A0D, 0xBE21, 0x4350, [0x88, 0xB0, 0x73, 0x67, 0xFC, 0x96, 0xEF, 0x3C]);
struct NetworkExplorerFolder;

const GUID CLSID_DestinationList = {0x77F10CF0, 0x3DB5, 0x4966, [0xB5, 0x20, 0xB7, 0xC5, 0x4F, 0xD3, 0x5E, 0xD6]};
@GUID(0x77F10CF0, 0x3DB5, 0x4966, [0xB5, 0x20, 0xB7, 0xC5, 0x4F, 0xD3, 0x5E, 0xD6]);
struct DestinationList;

const GUID CLSID_ApplicationDestinations = {0x86C14003, 0x4D6B, 0x4EF3, [0xA7, 0xB4, 0x05, 0x06, 0x66, 0x3B, 0x2E, 0x68]};
@GUID(0x86C14003, 0x4D6B, 0x4EF3, [0xA7, 0xB4, 0x05, 0x06, 0x66, 0x3B, 0x2E, 0x68]);
struct ApplicationDestinations;

const GUID CLSID_ApplicationDocumentLists = {0x86BEC222, 0x30F2, 0x47E0, [0x9F, 0x25, 0x60, 0xD1, 0x1C, 0xD7, 0x5C, 0x28]};
@GUID(0x86BEC222, 0x30F2, 0x47E0, [0x9F, 0x25, 0x60, 0xD1, 0x1C, 0xD7, 0x5C, 0x28]);
struct ApplicationDocumentLists;

const GUID CLSID_HomeGroup = {0xDE77BA04, 0x3C92, 0x4D11, [0xA1, 0xA5, 0x42, 0x35, 0x2A, 0x53, 0xE0, 0xE3]};
@GUID(0xDE77BA04, 0x3C92, 0x4D11, [0xA1, 0xA5, 0x42, 0x35, 0x2A, 0x53, 0xE0, 0xE3]);
struct HomeGroup;

const GUID CLSID_ShellLibrary = {0xD9B3211D, 0xE57F, 0x4426, [0xAA, 0xEF, 0x30, 0xA8, 0x06, 0xAD, 0xD3, 0x97]};
@GUID(0xD9B3211D, 0xE57F, 0x4426, [0xAA, 0xEF, 0x30, 0xA8, 0x06, 0xAD, 0xD3, 0x97]);
struct ShellLibrary;

const GUID CLSID_AppStartupLink = {0x273EB5E7, 0x88B0, 0x4843, [0xBF, 0xEF, 0xE2, 0xC8, 0x1D, 0x43, 0xAA, 0xE5]};
@GUID(0x273EB5E7, 0x88B0, 0x4843, [0xBF, 0xEF, 0xE2, 0xC8, 0x1D, 0x43, 0xAA, 0xE5]);
struct AppStartupLink;

const GUID CLSID_EnumerableObjectCollection = {0x2D3468C1, 0x36A7, 0x43B6, [0xAC, 0x24, 0xD3, 0xF0, 0x2F, 0xD9, 0x60, 0x7A]};
@GUID(0x2D3468C1, 0x36A7, 0x43B6, [0xAC, 0x24, 0xD3, 0xF0, 0x2F, 0xD9, 0x60, 0x7A]);
struct EnumerableObjectCollection;

const GUID CLSID_FrameworkInputPane = {0xD5120AA3, 0x46BA, 0x44C5, [0x82, 0x2D, 0xCA, 0x80, 0x92, 0xC1, 0xFC, 0x72]};
@GUID(0xD5120AA3, 0x46BA, 0x44C5, [0x82, 0x2D, 0xCA, 0x80, 0x92, 0xC1, 0xFC, 0x72]);
struct FrameworkInputPane;

const GUID CLSID_DefFolderMenu = {0xC63382BE, 0x7933, 0x48D0, [0x9A, 0xC8, 0x85, 0xFB, 0x46, 0xBE, 0x2F, 0xDD]};
@GUID(0xC63382BE, 0x7933, 0x48D0, [0x9A, 0xC8, 0x85, 0xFB, 0x46, 0xBE, 0x2F, 0xDD]);
struct DefFolderMenu;

const GUID CLSID_AppVisibility = {0x7E5FE3D9, 0x985F, 0x4908, [0x91, 0xF9, 0xEE, 0x19, 0xF9, 0xFD, 0x15, 0x14]};
@GUID(0x7E5FE3D9, 0x985F, 0x4908, [0x91, 0xF9, 0xEE, 0x19, 0xF9, 0xFD, 0x15, 0x14]);
struct AppVisibility;

const GUID CLSID_AppShellVerbHandler = {0x4ED3A719, 0xCEA8, 0x4BD9, [0x91, 0x0D, 0xE2, 0x52, 0xF9, 0x97, 0xAF, 0xC2]};
@GUID(0x4ED3A719, 0xCEA8, 0x4BD9, [0x91, 0x0D, 0xE2, 0x52, 0xF9, 0x97, 0xAF, 0xC2]);
struct AppShellVerbHandler;

const GUID CLSID_ExecuteUnknown = {0xE44E9428, 0xBDBC, 0x4987, [0xA0, 0x99, 0x40, 0xDC, 0x8F, 0xD2, 0x55, 0xE7]};
@GUID(0xE44E9428, 0xBDBC, 0x4987, [0xA0, 0x99, 0x40, 0xDC, 0x8F, 0xD2, 0x55, 0xE7]);
struct ExecuteUnknown;

const GUID CLSID_PackageDebugSettings = {0xB1AEC16F, 0x2383, 0x4852, [0xB0, 0xE9, 0x8F, 0x0B, 0x1D, 0xC6, 0x6B, 0x4D]};
@GUID(0xB1AEC16F, 0x2383, 0x4852, [0xB0, 0xE9, 0x8F, 0x0B, 0x1D, 0xC6, 0x6B, 0x4D]);
struct PackageDebugSettings;

const GUID CLSID_SuspensionDependencyManager = {0x6B273FC5, 0x61FD, 0x4918, [0x95, 0xA2, 0xC3, 0xB5, 0xE9, 0xD7, 0xF5, 0x81]};
@GUID(0x6B273FC5, 0x61FD, 0x4918, [0x95, 0xA2, 0xC3, 0xB5, 0xE9, 0xD7, 0xF5, 0x81]);
struct SuspensionDependencyManager;

const GUID CLSID_ApplicationActivationManager = {0x45BA127D, 0x10A8, 0x46EA, [0x8A, 0xB7, 0x56, 0xEA, 0x90, 0x78, 0x94, 0x3C]};
@GUID(0x45BA127D, 0x10A8, 0x46EA, [0x8A, 0xB7, 0x56, 0xEA, 0x90, 0x78, 0x94, 0x3C]);
struct ApplicationActivationManager;

const GUID CLSID_ApplicationDesignModeSettings = {0x958A6FB5, 0xDCB2, 0x4FAF, [0xAA, 0xFD, 0x7F, 0xB0, 0x54, 0xAD, 0x1A, 0x3B]};
@GUID(0x958A6FB5, 0xDCB2, 0x4FAF, [0xAA, 0xFD, 0x7F, 0xB0, 0x54, 0xAD, 0x1A, 0x3B]);
struct ApplicationDesignModeSettings;

struct CMINVOKECOMMANDINFO
{
    uint cbSize;
    uint fMask;
    HWND hwnd;
    const(char)* lpVerb;
    const(char)* lpParameters;
    const(char)* lpDirectory;
    int nShow;
    uint dwHotKey;
    HANDLE hIcon;
}

struct CMINVOKECOMMANDINFOEX
{
    uint cbSize;
    uint fMask;
    HWND hwnd;
    const(char)* lpVerb;
    const(char)* lpParameters;
    const(char)* lpDirectory;
    int nShow;
    uint dwHotKey;
    HANDLE hIcon;
    const(char)* lpTitle;
    const(wchar)* lpVerbW;
    const(wchar)* lpParametersW;
    const(wchar)* lpDirectoryW;
    const(wchar)* lpTitleW;
    POINT ptInvoke;
}

const GUID IID_IContextMenu = {0x000214E4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IContextMenu : IUnknown
{
    HRESULT QueryContextMenu(HMENU hmenu, uint indexMenu, uint idCmdFirst, uint idCmdLast, uint uFlags);
    HRESULT InvokeCommand(CMINVOKECOMMANDINFO* pici);
    HRESULT GetCommandString(uint idCmd, uint uType, uint* pReserved, char* pszName, uint cchMax);
}

const GUID IID_IContextMenu2 = {0x000214F4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F4, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IContextMenu2 : IContextMenu
{
    HRESULT HandleMenuMsg(uint uMsg, WPARAM wParam, LPARAM lParam);
}

const GUID IID_IContextMenu3 = {0xBCFCE0A0, 0xEC17, 0x11D0, [0x8D, 0x10, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]};
@GUID(0xBCFCE0A0, 0xEC17, 0x11D0, [0x8D, 0x10, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]);
interface IContextMenu3 : IContextMenu2
{
    HRESULT HandleMenuMsg2(uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
}

const GUID IID_IExecuteCommand = {0x7F9185B0, 0xCB92, 0x43C5, [0x80, 0xA9, 0x92, 0x27, 0x7A, 0x4F, 0x7B, 0x54]};
@GUID(0x7F9185B0, 0xCB92, 0x43C5, [0x80, 0xA9, 0x92, 0x27, 0x7A, 0x4F, 0x7B, 0x54]);
interface IExecuteCommand : IUnknown
{
    HRESULT SetKeyState(uint grfKeyState);
    HRESULT SetParameters(const(wchar)* pszParameters);
    HRESULT SetPosition(POINT pt);
    HRESULT SetShowWindow(int nShow);
    HRESULT SetNoShowUI(BOOL fNoShowUI);
    HRESULT SetDirectory(const(wchar)* pszDirectory);
    HRESULT Execute();
}

const GUID IID_IPersistFolder = {0x000214EA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214EA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IPersistFolder : IPersist
{
    HRESULT Initialize(ITEMIDLIST* pidl);
}

const GUID IID_IRunnableTask = {0x85788D00, 0x6807, 0x11D0, [0xB8, 0x10, 0x00, 0xC0, 0x4F, 0xD7, 0x06, 0xEC]};
@GUID(0x85788D00, 0x6807, 0x11D0, [0xB8, 0x10, 0x00, 0xC0, 0x4F, 0xD7, 0x06, 0xEC]);
interface IRunnableTask : IUnknown
{
    HRESULT Run();
    HRESULT Kill(BOOL bWait);
    HRESULT Suspend();
    HRESULT Resume();
    uint IsRunning();
}

const GUID IID_IShellTaskScheduler = {0x6CCB7BE0, 0x6807, 0x11D0, [0xB8, 0x10, 0x00, 0xC0, 0x4F, 0xD7, 0x06, 0xEC]};
@GUID(0x6CCB7BE0, 0x6807, 0x11D0, [0xB8, 0x10, 0x00, 0xC0, 0x4F, 0xD7, 0x06, 0xEC]);
interface IShellTaskScheduler : IUnknown
{
    HRESULT AddTask(IRunnableTask prt, const(Guid)* rtoid, uint lParam, uint dwPriority);
    HRESULT RemoveTasks(const(Guid)* rtoid, uint lParam, BOOL bWaitIfRunning);
    uint CountTasks(const(Guid)* rtoid);
    HRESULT Status(uint dwReleaseStatus, uint dwThreadTimeout);
}

const GUID IID_IPersistFolder2 = {0x1AC3D9F0, 0x175C, 0x11D1, [0x95, 0xBE, 0x00, 0x60, 0x97, 0x97, 0xEA, 0x4F]};
@GUID(0x1AC3D9F0, 0x175C, 0x11D1, [0x95, 0xBE, 0x00, 0x60, 0x97, 0x97, 0xEA, 0x4F]);
interface IPersistFolder2 : IPersistFolder
{
    HRESULT GetCurFolder(ITEMIDLIST** ppidl);
}

struct PERSIST_FOLDER_TARGET_INFO
{
    ITEMIDLIST* pidlTargetFolder;
    ushort szTargetParsingName;
    ushort szNetworkProvider;
    uint dwAttributes;
    int csidl;
}

const GUID IID_IPersistFolder3 = {0xCEF04FDF, 0xFE72, 0x11D2, [0x87, 0xA5, 0x00, 0xC0, 0x4F, 0x68, 0x37, 0xCF]};
@GUID(0xCEF04FDF, 0xFE72, 0x11D2, [0x87, 0xA5, 0x00, 0xC0, 0x4F, 0x68, 0x37, 0xCF]);
interface IPersistFolder3 : IPersistFolder2
{
    HRESULT InitializeEx(IBindCtx pbc, ITEMIDLIST* pidlRoot, const(PERSIST_FOLDER_TARGET_INFO)* ppfti);
    HRESULT GetFolderTargetInfo(PERSIST_FOLDER_TARGET_INFO* ppfti);
}

const GUID IID_IPersistIDList = {0x1079ACFC, 0x29BD, 0x11D3, [0x8E, 0x0D, 0x00, 0xC0, 0x4F, 0x68, 0x37, 0xD5]};
@GUID(0x1079ACFC, 0x29BD, 0x11D3, [0x8E, 0x0D, 0x00, 0xC0, 0x4F, 0x68, 0x37, 0xD5]);
interface IPersistIDList : IPersist
{
    HRESULT SetIDList(ITEMIDLIST* pidl);
    HRESULT GetIDList(ITEMIDLIST** ppidl);
}

const GUID IID_IEnumIDList = {0x000214F2, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F2, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IEnumIDList : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumIDList* ppenum);
}

const GUID IID_IEnumFullIDList = {0xD0191542, 0x7954, 0x4908, [0xBC, 0x06, 0xB2, 0x36, 0x0B, 0xBE, 0x45, 0xBA]};
@GUID(0xD0191542, 0x7954, 0x4908, [0xBC, 0x06, 0xB2, 0x36, 0x0B, 0xBE, 0x45, 0xBA]);
interface IEnumFullIDList : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumFullIDList* ppenum);
}

enum _SHGDNF
{
    SHGDN_NORMAL = 0,
    SHGDN_INFOLDER = 1,
    SHGDN_FOREDITING = 4096,
    SHGDN_FORADDRESSBAR = 16384,
    SHGDN_FORPARSING = 32768,
}

enum _SHCONTF
{
    SHCONTF_CHECKING_FOR_CHILDREN = 16,
    SHCONTF_FOLDERS = 32,
    SHCONTF_NONFOLDERS = 64,
    SHCONTF_INCLUDEHIDDEN = 128,
    SHCONTF_INIT_ON_FIRST_NEXT = 256,
    SHCONTF_NETPRINTERSRCH = 512,
    SHCONTF_SHAREABLE = 1024,
    SHCONTF_STORAGE = 2048,
    SHCONTF_NAVIGATION_ENUM = 4096,
    SHCONTF_FASTITEMS = 8192,
    SHCONTF_FLATLIST = 16384,
    SHCONTF_ENABLE_ASYNC = 32768,
    SHCONTF_INCLUDESUPERHIDDEN = 65536,
}

enum STORAGE_PROVIDER_FILE_FLAGS
{
    SPFF_NONE = 0,
    SPFF_DOWNLOAD_BY_DEFAULT = 1,
    SPFF_CREATED_ON_THIS_DEVICE = 2,
}

enum MERGE_UPDATE_STATUS
{
    MUS_COMPLETE = 0,
    MUS_USERINPUTNEEDED = 1,
    MUS_FAILED = 2,
}

const GUID IID_IFileSyncMergeHandler = {0xD97B5AAC, 0xC792, 0x433C, [0x97, 0x5D, 0x35, 0xC4, 0xEA, 0xDC, 0x7A, 0x9D]};
@GUID(0xD97B5AAC, 0xC792, 0x433C, [0x97, 0x5D, 0x35, 0xC4, 0xEA, 0xDC, 0x7A, 0x9D]);
interface IFileSyncMergeHandler : IUnknown
{
    HRESULT Merge(const(wchar)* localFilePath, const(wchar)* serverFilePath, MERGE_UPDATE_STATUS* updateStatus);
    HRESULT ShowResolveConflictUIAsync(const(wchar)* localFilePath, int monitorToDisplayOn);
}

enum FOLDER_ENUM_MODE
{
    FEM_VIEWRESULT = 0,
    FEM_NAVIGATION = 1,
}

const GUID IID_IObjectWithFolderEnumMode = {0x6A9D9026, 0x0E6E, 0x464C, [0xB0, 0x00, 0x42, 0xEC, 0xC0, 0x7D, 0xE6, 0x73]};
@GUID(0x6A9D9026, 0x0E6E, 0x464C, [0xB0, 0x00, 0x42, 0xEC, 0xC0, 0x7D, 0xE6, 0x73]);
interface IObjectWithFolderEnumMode : IUnknown
{
    HRESULT SetMode(FOLDER_ENUM_MODE feMode);
    HRESULT GetMode(FOLDER_ENUM_MODE* pfeMode);
}

const GUID IID_IParseAndCreateItem = {0x67EFED0E, 0xE827, 0x4408, [0xB4, 0x93, 0x78, 0xF3, 0x98, 0x2B, 0x68, 0x5C]};
@GUID(0x67EFED0E, 0xE827, 0x4408, [0xB4, 0x93, 0x78, 0xF3, 0x98, 0x2B, 0x68, 0x5C]);
interface IParseAndCreateItem : IUnknown
{
    HRESULT SetItem(IShellItem psi);
    HRESULT GetItem(const(Guid)* riid, void** ppv);
}

const GUID IID_IShellFolder = {0x000214E6, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E6, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellFolder : IUnknown
{
    HRESULT ParseDisplayName(HWND hwnd, IBindCtx pbc, const(wchar)* pszDisplayName, uint* pchEaten, ITEMIDLIST** ppidl, uint* pdwAttributes);
    HRESULT EnumObjects(HWND hwnd, uint grfFlags, IEnumIDList* ppenumIDList);
    HRESULT BindToObject(ITEMIDLIST* pidl, IBindCtx pbc, const(Guid)* riid, void** ppv);
    HRESULT BindToStorage(ITEMIDLIST* pidl, IBindCtx pbc, const(Guid)* riid, void** ppv);
    HRESULT CompareIDs(LPARAM lParam, ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);
    HRESULT CreateViewObject(HWND hwndOwner, const(Guid)* riid, void** ppv);
    HRESULT GetAttributesOf(uint cidl, char* apidl, uint* rgfInOut);
    HRESULT GetUIObjectOf(HWND hwndOwner, uint cidl, char* apidl, const(Guid)* riid, uint* rgfReserved, void** ppv);
    HRESULT GetDisplayNameOf(ITEMIDLIST* pidl, uint uFlags, STRRET* pName);
    HRESULT SetNameOf(HWND hwnd, ITEMIDLIST* pidl, const(wchar)* pszName, uint uFlags, ITEMIDLIST** ppidlOut);
}

struct EXTRASEARCH
{
    Guid guidSearch;
    ushort wszFriendlyName;
    ushort wszUrl;
}

const GUID IID_IEnumExtraSearch = {0x0E700BE1, 0x9DB6, 0x11D1, [0xA1, 0xCE, 0x00, 0xC0, 0x4F, 0xD7, 0x5D, 0x13]};
@GUID(0x0E700BE1, 0x9DB6, 0x11D1, [0xA1, 0xCE, 0x00, 0xC0, 0x4F, 0xD7, 0x5D, 0x13]);
interface IEnumExtraSearch : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumExtraSearch* ppenum);
}

const GUID IID_IShellFolder2 = {0x93F2F68C, 0x1D1B, 0x11D3, [0xA3, 0x0E, 0x00, 0xC0, 0x4F, 0x79, 0xAB, 0xD1]};
@GUID(0x93F2F68C, 0x1D1B, 0x11D3, [0xA3, 0x0E, 0x00, 0xC0, 0x4F, 0x79, 0xAB, 0xD1]);
interface IShellFolder2 : IShellFolder
{
    HRESULT GetDefaultSearchGUID(Guid* pguid);
    HRESULT EnumSearches(IEnumExtraSearch* ppenum);
    HRESULT GetDefaultColumn(uint dwRes, uint* pSort, uint* pDisplay);
    HRESULT GetDefaultColumnState(uint iColumn, uint* pcsFlags);
    HRESULT GetDetailsEx(ITEMIDLIST* pidl, const(PROPERTYKEY)* pscid, VARIANT* pv);
    HRESULT GetDetailsOf(ITEMIDLIST* pidl, uint iColumn, SHELLDETAILS* psd);
    HRESULT MapColumnToSCID(uint iColumn, PROPERTYKEY* pscid);
}

enum FOLDERFLAGS
{
    FWF_NONE = 0,
    FWF_AUTOARRANGE = 1,
    FWF_ABBREVIATEDNAMES = 2,
    FWF_SNAPTOGRID = 4,
    FWF_OWNERDATA = 8,
    FWF_BESTFITWINDOW = 16,
    FWF_DESKTOP = 32,
    FWF_SINGLESEL = 64,
    FWF_NOSUBFOLDERS = 128,
    FWF_TRANSPARENT = 256,
    FWF_NOCLIENTEDGE = 512,
    FWF_NOSCROLL = 1024,
    FWF_ALIGNLEFT = 2048,
    FWF_NOICONS = 4096,
    FWF_SHOWSELALWAYS = 8192,
    FWF_NOVISIBLE = 16384,
    FWF_SINGLECLICKACTIVATE = 32768,
    FWF_NOWEBVIEW = 65536,
    FWF_HIDEFILENAMES = 131072,
    FWF_CHECKSELECT = 262144,
    FWF_NOENUMREFRESH = 524288,
    FWF_NOGROUPING = 1048576,
    FWF_FULLROWSELECT = 2097152,
    FWF_NOFILTERS = 4194304,
    FWF_NOCOLUMNHEADER = 8388608,
    FWF_NOHEADERINALLVIEWS = 16777216,
    FWF_EXTENDEDTILES = 33554432,
    FWF_TRICHECKSELECT = 67108864,
    FWF_AUTOCHECKSELECT = 134217728,
    FWF_NOBROWSERVIEWSTATE = 268435456,
    FWF_SUBSETGROUPS = 536870912,
    FWF_USESEARCHFOLDER = 1073741824,
    FWF_ALLOWRTLREADING = -2147483648,
}

enum FOLDERVIEWMODE
{
    FVM_AUTO = -1,
    FVM_FIRST = 1,
    FVM_ICON = 1,
    FVM_SMALLICON = 2,
    FVM_LIST = 3,
    FVM_DETAILS = 4,
    FVM_THUMBNAIL = 5,
    FVM_TILE = 6,
    FVM_THUMBSTRIP = 7,
    FVM_CONTENT = 8,
    FVM_LAST = 8,
}

enum FOLDERLOGICALVIEWMODE
{
    FLVM_UNSPECIFIED = -1,
    FLVM_FIRST = 1,
    FLVM_DETAILS = 1,
    FLVM_TILES = 2,
    FLVM_ICONS = 3,
    FLVM_LIST = 4,
    FLVM_CONTENT = 5,
    FLVM_LAST = 5,
}

struct FOLDERSETTINGS
{
    uint ViewMode;
    uint fFlags;
}

enum _SVSIF
{
    SVSI_DESELECT = 0,
    SVSI_SELECT = 1,
    SVSI_EDIT = 3,
    SVSI_DESELECTOTHERS = 4,
    SVSI_ENSUREVISIBLE = 8,
    SVSI_FOCUSED = 16,
    SVSI_TRANSLATEPT = 32,
    SVSI_SELECTIONMARK = 64,
    SVSI_POSITIONITEM = 128,
    SVSI_CHECK = 256,
    SVSI_CHECK2 = 512,
    SVSI_KEYBOARDSELECT = 1025,
    SVSI_NOTAKEFOCUS = 1073741824,
}

enum _SVGIO
{
    SVGIO_BACKGROUND = 0,
    SVGIO_SELECTION = 1,
    SVGIO_ALLVIEW = 2,
    SVGIO_CHECKED = 3,
    SVGIO_TYPE_MASK = 15,
    SVGIO_FLAG_VIEWORDER = -2147483648,
}

enum SVUIA_STATUS
{
    SVUIA_DEACTIVATE = 0,
    SVUIA_ACTIVATE_NOFOCUS = 1,
    SVUIA_ACTIVATE_FOCUS = 2,
    SVUIA_INPLACEACTIVATE = 3,
}

alias LPFNSVADDPROPSHEETPAGE = extern(Windows) BOOL function();
const GUID IID_IShellView = {0x000214E3, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E3, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellView : IOleWindow
{
    HRESULT TranslateAcceleratorA(MSG* pmsg);
    HRESULT EnableModeless(BOOL fEnable);
    HRESULT UIActivate(uint uState);
    HRESULT Refresh();
    HRESULT CreateViewWindow(IShellView psvPrevious, FOLDERSETTINGS* pfs, IShellBrowser psb, RECT* prcView, HWND* phWnd);
    HRESULT DestroyViewWindow();
    HRESULT GetCurrentInfo(FOLDERSETTINGS* pfs);
    HRESULT AddPropertySheetPages(uint dwReserved, LPFNSVADDPROPSHEETPAGE pfn, LPARAM lparam);
    HRESULT SaveViewState();
    HRESULT SelectItem(ITEMIDLIST* pidlItem, uint uFlags);
    HRESULT GetItemObject(uint uItem, const(Guid)* riid, void** ppv);
}

struct SV2CVW2_PARAMS
{
    uint cbSize;
    IShellView psvPrev;
    FOLDERSETTINGS* pfs;
    IShellBrowser psbOwner;
    RECT* prcView;
    const(Guid)* pvid;
    HWND hwndView;
}

const GUID IID_IShellView2 = {0x88E39E80, 0x3578, 0x11CF, [0xAE, 0x69, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]};
@GUID(0x88E39E80, 0x3578, 0x11CF, [0xAE, 0x69, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]);
interface IShellView2 : IShellView
{
    HRESULT GetView(Guid* pvid, uint uView);
    HRESULT CreateViewWindow2(SV2CVW2_PARAMS* lpParams);
    HRESULT HandleRename(ITEMIDLIST* pidlNew);
    HRESULT SelectAndPositionItem(ITEMIDLIST* pidlItem, uint uFlags, POINT* ppt);
}

const GUID IID_IFolderView = {0xCDE725B0, 0xCCC9, 0x4519, [0x91, 0x7E, 0x32, 0x5D, 0x72, 0xFA, 0xB4, 0xCE]};
@GUID(0xCDE725B0, 0xCCC9, 0x4519, [0x91, 0x7E, 0x32, 0x5D, 0x72, 0xFA, 0xB4, 0xCE]);
interface IFolderView : IUnknown
{
    HRESULT GetCurrentViewMode(uint* pViewMode);
    HRESULT SetCurrentViewMode(uint ViewMode);
    HRESULT GetFolder(const(Guid)* riid, void** ppv);
    HRESULT Item(int iItemIndex, ITEMIDLIST** ppidl);
    HRESULT ItemCount(uint uFlags, int* pcItems);
    HRESULT Items(uint uFlags, const(Guid)* riid, void** ppv);
    HRESULT GetSelectionMarkedItem(int* piItem);
    HRESULT GetFocusedItem(int* piItem);
    HRESULT GetItemPosition(ITEMIDLIST* pidl, POINT* ppt);
    HRESULT GetSpacing(POINT* ppt);
    HRESULT GetDefaultSpacing(POINT* ppt);
    HRESULT GetAutoArrange();
    HRESULT SelectItem(int iItem, uint dwFlags);
    HRESULT SelectAndPositionItems(uint cidl, char* apidl, char* apt, uint dwFlags);
}

enum tagSORTDIRECTION
{
    SORT_DESCENDING = -1,
    SORT_ASCENDING = 1,
}

struct SORTCOLUMN
{
    PROPERTYKEY propkey;
    int direction;
}

enum FVTEXTTYPE
{
    FVST_EMPTYTEXT = 0,
}

const GUID IID_IFolderView2 = {0x1AF3A467, 0x214F, 0x4298, [0x90, 0x8E, 0x06, 0xB0, 0x3E, 0x0B, 0x39, 0xF9]};
@GUID(0x1AF3A467, 0x214F, 0x4298, [0x90, 0x8E, 0x06, 0xB0, 0x3E, 0x0B, 0x39, 0xF9]);
interface IFolderView2 : IFolderView
{
    HRESULT SetGroupBy(const(PROPERTYKEY)* key, BOOL fAscending);
    HRESULT GetGroupBy(PROPERTYKEY* pkey, int* pfAscending);
    HRESULT SetViewProperty(ITEMIDLIST* pidl, const(PROPERTYKEY)* propkey, const(PROPVARIANT)* propvar);
    HRESULT GetViewProperty(ITEMIDLIST* pidl, const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);
    HRESULT SetTileViewProperties(ITEMIDLIST* pidl, const(wchar)* pszPropList);
    HRESULT SetExtendedTileViewProperties(ITEMIDLIST* pidl, const(wchar)* pszPropList);
    HRESULT SetText(FVTEXTTYPE iType, const(wchar)* pwszText);
    HRESULT SetCurrentFolderFlags(uint dwMask, uint dwFlags);
    HRESULT GetCurrentFolderFlags(uint* pdwFlags);
    HRESULT GetSortColumnCount(int* pcColumns);
    HRESULT SetSortColumns(char* rgSortColumns, int cColumns);
    HRESULT GetSortColumns(char* rgSortColumns, int cColumns);
    HRESULT GetItem(int iItem, const(Guid)* riid, void** ppv);
    HRESULT GetVisibleItem(int iStart, BOOL fPrevious, int* piItem);
    HRESULT GetSelectedItem(int iStart, int* piItem);
    HRESULT GetSelection(BOOL fNoneImpliesFolder, IShellItemArray* ppsia);
    HRESULT GetSelectionState(ITEMIDLIST* pidl, uint* pdwFlags);
    HRESULT InvokeVerbOnSelection(const(char)* pszVerb);
    HRESULT SetViewModeAndIconSize(FOLDERVIEWMODE uViewMode, int iImageSize);
    HRESULT GetViewModeAndIconSize(FOLDERVIEWMODE* puViewMode, int* piImageSize);
    HRESULT SetGroupSubsetCount(uint cVisibleRows);
    HRESULT GetGroupSubsetCount(uint* pcVisibleRows);
    HRESULT SetRedraw(BOOL fRedrawOn);
    HRESULT IsMoveInSameFolder();
    HRESULT DoRename();
}

const GUID IID_IFolderViewSettings = {0xAE8C987D, 0x8797, 0x4ED3, [0xBE, 0x72, 0x2A, 0x47, 0xDD, 0x93, 0x8D, 0xB0]};
@GUID(0xAE8C987D, 0x8797, 0x4ED3, [0xBE, 0x72, 0x2A, 0x47, 0xDD, 0x93, 0x8D, 0xB0]);
interface IFolderViewSettings : IUnknown
{
    HRESULT GetColumnPropertyList(const(Guid)* riid, void** ppv);
    HRESULT GetGroupByProperty(PROPERTYKEY* pkey, int* pfGroupAscending);
    HRESULT GetViewMode(FOLDERLOGICALVIEWMODE* plvm);
    HRESULT GetIconSize(uint* puIconSize);
    HRESULT GetFolderFlags(FOLDERFLAGS* pfolderMask, FOLDERFLAGS* pfolderFlags);
    HRESULT GetSortColumns(char* rgSortColumns, uint cColumnsIn, uint* pcColumnsOut);
    HRESULT GetGroupSubsetCount(uint* pcVisibleRows);
}

const GUID IID_IInitializeNetworkFolder = {0x6E0F9881, 0x42A8, 0x4F2A, [0x97, 0xF8, 0x8A, 0xF4, 0xE0, 0x26, 0xD9, 0x2D]};
@GUID(0x6E0F9881, 0x42A8, 0x4F2A, [0x97, 0xF8, 0x8A, 0xF4, 0xE0, 0x26, 0xD9, 0x2D]);
interface IInitializeNetworkFolder : IUnknown
{
    HRESULT Initialize(ITEMIDLIST* pidl, ITEMIDLIST* pidlTarget, uint uDisplayType, const(wchar)* pszResName, const(wchar)* pszProvider);
}

const GUID IID_INetworkFolderInternal = {0xCEB38218, 0xC971, 0x47BB, [0xA7, 0x03, 0xF0, 0xBC, 0x99, 0xCC, 0xDB, 0x81]};
@GUID(0xCEB38218, 0xC971, 0x47BB, [0xA7, 0x03, 0xF0, 0xBC, 0x99, 0xCC, 0xDB, 0x81]);
interface INetworkFolderInternal : IUnknown
{
    HRESULT GetResourceDisplayType(uint* displayType);
    HRESULT GetIDList(ITEMIDLIST** idList);
    HRESULT GetProvider(uint itemIdCount, char* itemIds, uint providerMaxLength, const(wchar)* provider);
}

const GUID IID_IPreviewHandlerVisuals = {0x196BF9A5, 0xB346, 0x4EF0, [0xAA, 0x1E, 0x5D, 0xCD, 0xB7, 0x67, 0x68, 0xB1]};
@GUID(0x196BF9A5, 0xB346, 0x4EF0, [0xAA, 0x1E, 0x5D, 0xCD, 0xB7, 0x67, 0x68, 0xB1]);
interface IPreviewHandlerVisuals : IUnknown
{
    HRESULT SetBackgroundColor(uint color);
    HRESULT SetFont(const(LOGFONTW)* plf);
    HRESULT SetTextColor(uint color);
}

const GUID IID_ICommDlgBrowser = {0x000214F1, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F1, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICommDlgBrowser : IUnknown
{
    HRESULT OnDefaultCommand(IShellView ppshv);
    HRESULT OnStateChange(IShellView ppshv, uint uChange);
    HRESULT IncludeObject(IShellView ppshv, ITEMIDLIST* pidl);
}

const GUID IID_ICommDlgBrowser2 = {0x10339516, 0x2894, 0x11D2, [0x90, 0x39, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]};
@GUID(0x10339516, 0x2894, 0x11D2, [0x90, 0x39, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]);
interface ICommDlgBrowser2 : ICommDlgBrowser
{
    HRESULT Notify(IShellView ppshv, uint dwNotifyType);
    HRESULT GetDefaultMenuText(IShellView ppshv, const(wchar)* pszText, int cchMax);
    HRESULT GetViewFlags(uint* pdwFlags);
}

enum CM_MASK
{
    CM_MASK_WIDTH = 1,
    CM_MASK_DEFAULTWIDTH = 2,
    CM_MASK_IDEALWIDTH = 4,
    CM_MASK_NAME = 8,
    CM_MASK_STATE = 16,
}

enum CM_STATE
{
    CM_STATE_NONE = 0,
    CM_STATE_VISIBLE = 1,
    CM_STATE_FIXEDWIDTH = 2,
    CM_STATE_NOSORTBYFOLDERNESS = 4,
    CM_STATE_ALWAYSVISIBLE = 8,
}

enum CM_ENUM_FLAGS
{
    CM_ENUM_ALL = 1,
    CM_ENUM_VISIBLE = 2,
}

enum CM_SET_WIDTH_VALUE
{
    CM_WIDTH_USEDEFAULT = -1,
    CM_WIDTH_AUTOSIZE = -2,
}

struct CM_COLUMNINFO
{
    uint cbSize;
    uint dwMask;
    uint dwState;
    uint uWidth;
    uint uDefaultWidth;
    uint uIdealWidth;
    ushort wszName;
}

const GUID IID_IColumnManager = {0xD8EC27BB, 0x3F3B, 0x4042, [0xB1, 0x0A, 0x4A, 0xCF, 0xD9, 0x24, 0xD4, 0x53]};
@GUID(0xD8EC27BB, 0x3F3B, 0x4042, [0xB1, 0x0A, 0x4A, 0xCF, 0xD9, 0x24, 0xD4, 0x53]);
interface IColumnManager : IUnknown
{
    HRESULT SetColumnInfo(const(PROPERTYKEY)* propkey, const(CM_COLUMNINFO)* pcmci);
    HRESULT GetColumnInfo(const(PROPERTYKEY)* propkey, CM_COLUMNINFO* pcmci);
    HRESULT GetColumnCount(CM_ENUM_FLAGS dwFlags, uint* puCount);
    HRESULT GetColumns(CM_ENUM_FLAGS dwFlags, char* rgkeyOrder, uint cColumns);
    HRESULT SetColumns(char* rgkeyOrder, uint cVisible);
}

const GUID IID_IFolderFilterSite = {0xC0A651F5, 0xB48B, 0x11D2, [0xB5, 0xED, 0x00, 0x60, 0x97, 0xC6, 0x86, 0xF6]};
@GUID(0xC0A651F5, 0xB48B, 0x11D2, [0xB5, 0xED, 0x00, 0x60, 0x97, 0xC6, 0x86, 0xF6]);
interface IFolderFilterSite : IUnknown
{
    HRESULT SetFilter(IUnknown punk);
}

const GUID IID_IFolderFilter = {0x9CC22886, 0xDC8E, 0x11D2, [0xB1, 0xD0, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]};
@GUID(0x9CC22886, 0xDC8E, 0x11D2, [0xB1, 0xD0, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]);
interface IFolderFilter : IUnknown
{
    HRESULT ShouldShow(IShellFolder psf, ITEMIDLIST* pidlFolder, ITEMIDLIST* pidlItem);
    HRESULT GetEnumFlags(IShellFolder psf, ITEMIDLIST* pidlFolder, HWND* phwnd, uint* pgrfFlags);
}

const GUID IID_IInputObjectSite = {0xF1DB8392, 0x7331, 0x11D0, [0x8C, 0x99, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0xF1DB8392, 0x7331, 0x11D0, [0x8C, 0x99, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface IInputObjectSite : IUnknown
{
    HRESULT OnFocusChangeIS(IUnknown punkObj, BOOL fSetFocus);
}

const GUID IID_IInputObject = {0x68284FAA, 0x6A48, 0x11D0, [0x8C, 0x78, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xB4]};
@GUID(0x68284FAA, 0x6A48, 0x11D0, [0x8C, 0x78, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xB4]);
interface IInputObject : IUnknown
{
    HRESULT UIActivateIO(BOOL fActivate, MSG* pMsg);
    HRESULT HasFocusIO();
    HRESULT TranslateAcceleratorIO(MSG* pMsg);
}

const GUID IID_IInputObject2 = {0x6915C085, 0x510B, 0x44CD, [0x94, 0xAF, 0x28, 0xDF, 0xA5, 0x6C, 0xF9, 0x2B]};
@GUID(0x6915C085, 0x510B, 0x44CD, [0x94, 0xAF, 0x28, 0xDF, 0xA5, 0x6C, 0xF9, 0x2B]);
interface IInputObject2 : IInputObject
{
    HRESULT TranslateAcceleratorGlobal(MSG* pMsg);
}

const GUID IID_IShellIcon = {0x000214E5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellIcon : IUnknown
{
    HRESULT GetIconOf(ITEMIDLIST* pidl, uint flags, int* pIconIndex);
}

const GUID IID_IShellBrowser = {0x000214E2, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E2, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellBrowser : IOleWindow
{
    HRESULT InsertMenusSB(HMENU hmenuShared, OleMenuGroupWidths* lpMenuWidths);
    HRESULT SetMenuSB(HMENU hmenuShared, int holemenuRes, HWND hwndActiveObject);
    HRESULT RemoveMenusSB(HMENU hmenuShared);
    HRESULT SetStatusTextSB(const(wchar)* pszStatusText);
    HRESULT EnableModelessSB(BOOL fEnable);
    HRESULT TranslateAcceleratorSB(MSG* pmsg, ushort wID);
    HRESULT BrowseObject(ITEMIDLIST* pidl, uint wFlags);
    HRESULT GetViewStateStream(uint grfMode, IStream* ppStrm);
    HRESULT GetControlWindow(uint id, HWND* phwnd);
    HRESULT SendControlMsg(uint id, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* pret);
    HRESULT QueryActiveShellView(IShellView* ppshv);
    HRESULT OnViewWindowActive(IShellView pshv);
    HRESULT SetToolbarItems(char* lpButtons, uint nButtons, uint uFlags);
}

const GUID IID_IProfferService = {0xCB728B20, 0xF786, 0x11CE, [0x92, 0xAD, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xD0]};
@GUID(0xCB728B20, 0xF786, 0x11CE, [0x92, 0xAD, 0x00, 0xAA, 0x00, 0xA7, 0x4C, 0xD0]);
interface IProfferService : IUnknown
{
    HRESULT ProfferService(const(Guid)* guidService, IServiceProvider psp, uint* pdwCookie);
    HRESULT RevokeService(uint dwCookie);
}

enum SIGDN
{
    SIGDN_NORMALDISPLAY = 0,
    SIGDN_PARENTRELATIVEPARSING = -2147385343,
    SIGDN_DESKTOPABSOLUTEPARSING = -2147319808,
    SIGDN_PARENTRELATIVEEDITING = -2147282943,
    SIGDN_DESKTOPABSOLUTEEDITING = -2147172352,
    SIGDN_FILESYSPATH = -2147123200,
    SIGDN_URL = -2147057664,
    SIGDN_PARENTRELATIVEFORADDRESSBAR = -2146975743,
    SIGDN_PARENTRELATIVE = -2146959359,
    SIGDN_PARENTRELATIVEFORUI = -2146877439,
}

enum _SICHINTF
{
    SICHINT_DISPLAY = 0,
    SICHINT_ALLFIELDS = -2147483648,
    SICHINT_CANONICAL = 268435456,
    SICHINT_TEST_FILESYSPATH_IF_NOT_EQUAL = 536870912,
}

const GUID IID_IShellItem = {0x43826D1E, 0xE718, 0x42EE, [0xBC, 0x55, 0xA1, 0xE2, 0x61, 0xC3, 0x7B, 0xFE]};
@GUID(0x43826D1E, 0xE718, 0x42EE, [0xBC, 0x55, 0xA1, 0xE2, 0x61, 0xC3, 0x7B, 0xFE]);
interface IShellItem : IUnknown
{
    HRESULT BindToHandler(IBindCtx pbc, const(Guid)* bhid, const(Guid)* riid, void** ppv);
    HRESULT GetParent(IShellItem* ppsi);
    HRESULT GetDisplayName(SIGDN sigdnName, ushort** ppszName);
    HRESULT GetAttributes(uint sfgaoMask, uint* psfgaoAttribs);
    HRESULT Compare(IShellItem psi, uint hint, int* piOrder);
}

enum DATAOBJ_GET_ITEM_FLAGS
{
    DOGIF_DEFAULT = 0,
    DOGIF_TRAVERSE_LINK = 1,
    DOGIF_NO_HDROP = 2,
    DOGIF_NO_URL = 4,
    DOGIF_ONLY_IF_ONE = 8,
}

const GUID IID_IShellItem2 = {0x7E9FB0D3, 0x919F, 0x4307, [0xAB, 0x2E, 0x9B, 0x18, 0x60, 0x31, 0x0C, 0x93]};
@GUID(0x7E9FB0D3, 0x919F, 0x4307, [0xAB, 0x2E, 0x9B, 0x18, 0x60, 0x31, 0x0C, 0x93]);
interface IShellItem2 : IShellItem
{
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyStoreWithCreateObject(GETPROPERTYSTOREFLAGS flags, IUnknown punkCreateObject, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyStoreForKeys(char* rgKeys, uint cKeys, GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyDescriptionList(const(PROPERTYKEY)* keyType, const(Guid)* riid, void** ppv);
    HRESULT Update(IBindCtx pbc);
    HRESULT GetProperty(const(PROPERTYKEY)* key, PROPVARIANT* ppropvar);
    HRESULT GetCLSID(const(PROPERTYKEY)* key, Guid* pclsid);
    HRESULT GetFileTime(const(PROPERTYKEY)* key, FILETIME* pft);
    HRESULT GetInt32(const(PROPERTYKEY)* key, int* pi);
    HRESULT GetString(const(PROPERTYKEY)* key, ushort** ppsz);
    HRESULT GetUInt32(const(PROPERTYKEY)* key, uint* pui);
    HRESULT GetUInt64(const(PROPERTYKEY)* key, ulong* pull);
    HRESULT GetBool(const(PROPERTYKEY)* key, int* pf);
}

enum _SIIGBF
{
    SIIGBF_RESIZETOFIT = 0,
    SIIGBF_BIGGERSIZEOK = 1,
    SIIGBF_MEMORYONLY = 2,
    SIIGBF_ICONONLY = 4,
    SIIGBF_THUMBNAILONLY = 8,
    SIIGBF_INCACHEONLY = 16,
    SIIGBF_CROPTOSQUARE = 32,
    SIIGBF_WIDETHUMBNAILS = 64,
    SIIGBF_ICONBACKGROUND = 128,
    SIIGBF_SCALEUP = 256,
}

const GUID IID_IShellItemImageFactory = {0xBCC18B79, 0xBA16, 0x442F, [0x80, 0xC4, 0x8A, 0x59, 0xC3, 0x0C, 0x46, 0x3B]};
@GUID(0xBCC18B79, 0xBA16, 0x442F, [0x80, 0xC4, 0x8A, 0x59, 0xC3, 0x0C, 0x46, 0x3B]);
interface IShellItemImageFactory : IUnknown
{
    HRESULT GetImage(SIZE size, int flags, HBITMAP* phbm);
}

const GUID IID_IEnumShellItems = {0x70629033, 0xE363, 0x4A28, [0xA5, 0x67, 0x0D, 0xB7, 0x80, 0x06, 0xE6, 0xD7]};
@GUID(0x70629033, 0xE363, 0x4A28, [0xA5, 0x67, 0x0D, 0xB7, 0x80, 0x06, 0xE6, 0xD7]);
interface IEnumShellItems : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumShellItems* ppenum);
}

enum STGOP
{
    STGOP_MOVE = 1,
    STGOP_COPY = 2,
    STGOP_SYNC = 3,
    STGOP_REMOVE = 5,
    STGOP_RENAME = 6,
    STGOP_APPLYPROPERTIES = 8,
    STGOP_NEW = 10,
}

enum _TRANSFER_SOURCE_FLAGS
{
    TSF_NORMAL = 0,
    TSF_FAIL_EXIST = 0,
    TSF_RENAME_EXIST = 1,
    TSF_OVERWRITE_EXIST = 2,
    TSF_ALLOW_DECRYPTION = 4,
    TSF_NO_SECURITY = 8,
    TSF_COPY_CREATION_TIME = 16,
    TSF_COPY_WRITE_TIME = 32,
    TSF_USE_FULL_ACCESS = 64,
    TSF_DELETE_RECYCLE_IF_POSSIBLE = 128,
    TSF_COPY_HARD_LINK = 256,
    TSF_COPY_LOCALIZED_NAME = 512,
    TSF_MOVE_AS_COPY_DELETE = 1024,
    TSF_SUSPEND_SHELLEVENTS = 2048,
}

enum _TRANSFER_ADVISE_STATE
{
    TS_NONE = 0,
    TS_PERFORMING = 1,
    TS_PREPARING = 2,
    TS_INDETERMINATE = 4,
}

const GUID IID_ITransferAdviseSink = {0xD594D0D8, 0x8DA7, 0x457B, [0xB3, 0xB4, 0xCE, 0x5D, 0xBA, 0xAC, 0x0B, 0x88]};
@GUID(0xD594D0D8, 0x8DA7, 0x457B, [0xB3, 0xB4, 0xCE, 0x5D, 0xBA, 0xAC, 0x0B, 0x88]);
interface ITransferAdviseSink : IUnknown
{
    HRESULT UpdateProgress(ulong ullSizeCurrent, ulong ullSizeTotal, int nFilesCurrent, int nFilesTotal, int nFoldersCurrent, int nFoldersTotal);
    HRESULT UpdateTransferState(uint ts);
    HRESULT ConfirmOverwrite(IShellItem psiSource, IShellItem psiDestParent, const(wchar)* pszName);
    HRESULT ConfirmEncryptionLoss(IShellItem psiSource);
    HRESULT FileFailure(IShellItem psi, const(wchar)* pszItem, HRESULT hrError, const(wchar)* pszRename, uint cchRename);
    HRESULT SubStreamFailure(IShellItem psi, const(wchar)* pszStreamName, HRESULT hrError);
    HRESULT PropertyFailure(IShellItem psi, const(PROPERTYKEY)* pkey, HRESULT hrError);
}

const GUID IID_ITransferSource = {0x00ADB003, 0xBDE9, 0x45C6, [0x8E, 0x29, 0xD0, 0x9F, 0x93, 0x53, 0xE1, 0x08]};
@GUID(0x00ADB003, 0xBDE9, 0x45C6, [0x8E, 0x29, 0xD0, 0x9F, 0x93, 0x53, 0xE1, 0x08]);
interface ITransferSource : IUnknown
{
    HRESULT Advise(ITransferAdviseSink psink, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT SetProperties(IPropertyChangeArray pproparray);
    HRESULT OpenItem(IShellItem psi, uint flags, const(Guid)* riid, void** ppv);
    HRESULT MoveItem(IShellItem psi, IShellItem psiParentDst, const(wchar)* pszNameDst, uint flags, IShellItem* ppsiNew);
    HRESULT RecycleItem(IShellItem psiSource, IShellItem psiParentDest, uint flags, IShellItem* ppsiNewDest);
    HRESULT RemoveItem(IShellItem psiSource, uint flags);
    HRESULT RenameItem(IShellItem psiSource, const(wchar)* pszNewName, uint flags, IShellItem* ppsiNewDest);
    HRESULT LinkItem(IShellItem psiSource, IShellItem psiParentDest, const(wchar)* pszNewName, uint flags, IShellItem* ppsiNewDest);
    HRESULT ApplyPropertiesToItem(IShellItem psiSource, IShellItem* ppsiNew);
    HRESULT GetDefaultDestinationName(IShellItem psiSource, IShellItem psiParentDest, ushort** ppszDestinationName);
    HRESULT EnterFolder(IShellItem psiChildFolderDest);
    HRESULT LeaveFolder(IShellItem psiChildFolderDest);
}

struct SHELL_ITEM_RESOURCE
{
    Guid guidType;
    ushort szName;
}

const GUID IID_IEnumResources = {0x2DD81FE3, 0xA83C, 0x4DA9, [0xA3, 0x30, 0x47, 0x24, 0x9D, 0x34, 0x5B, 0xA1]};
@GUID(0x2DD81FE3, 0xA83C, 0x4DA9, [0xA3, 0x30, 0x47, 0x24, 0x9D, 0x34, 0x5B, 0xA1]);
interface IEnumResources : IUnknown
{
    HRESULT Next(uint celt, char* psir, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumResources* ppenumr);
}

const GUID IID_IShellItemResources = {0xFF5693BE, 0x2CE0, 0x4D48, [0xB5, 0xC5, 0x40, 0x81, 0x7D, 0x1A, 0xCD, 0xB9]};
@GUID(0xFF5693BE, 0x2CE0, 0x4D48, [0xB5, 0xC5, 0x40, 0x81, 0x7D, 0x1A, 0xCD, 0xB9]);
interface IShellItemResources : IUnknown
{
    HRESULT GetAttributes(uint* pdwAttributes);
    HRESULT GetSize(ulong* pullSize);
    HRESULT GetTimes(FILETIME* pftCreation, FILETIME* pftWrite, FILETIME* pftAccess);
    HRESULT SetTimes(const(FILETIME)* pftCreation, const(FILETIME)* pftWrite, const(FILETIME)* pftAccess);
    HRESULT GetResourceDescription(const(SHELL_ITEM_RESOURCE)* pcsir, ushort** ppszDescription);
    HRESULT EnumResources(IEnumResources* ppenumr);
    HRESULT SupportsResource(const(SHELL_ITEM_RESOURCE)* pcsir);
    HRESULT OpenResource(const(SHELL_ITEM_RESOURCE)* pcsir, const(Guid)* riid, void** ppv);
    HRESULT CreateResource(const(SHELL_ITEM_RESOURCE)* pcsir, const(Guid)* riid, void** ppv);
    HRESULT MarkForDelete();
}

const GUID IID_ITransferDestination = {0x48ADDD32, 0x3CA5, 0x4124, [0xAB, 0xE3, 0xB5, 0xA7, 0x25, 0x31, 0xB2, 0x07]};
@GUID(0x48ADDD32, 0x3CA5, 0x4124, [0xAB, 0xE3, 0xB5, 0xA7, 0x25, 0x31, 0xB2, 0x07]);
interface ITransferDestination : IUnknown
{
    HRESULT Advise(ITransferAdviseSink psink, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT CreateItem(const(wchar)* pszName, uint dwAttributes, ulong ullSize, uint flags, const(Guid)* riidItem, void** ppvItem, const(Guid)* riidResources, void** ppvResources);
}

const GUID IID_IFileOperationProgressSink = {0x04B0F1A7, 0x9490, 0x44BC, [0x96, 0xE1, 0x42, 0x96, 0xA3, 0x12, 0x52, 0xE2]};
@GUID(0x04B0F1A7, 0x9490, 0x44BC, [0x96, 0xE1, 0x42, 0x96, 0xA3, 0x12, 0x52, 0xE2]);
interface IFileOperationProgressSink : IUnknown
{
    HRESULT StartOperations();
    HRESULT FinishOperations(HRESULT hrResult);
    HRESULT PreRenameItem(uint dwFlags, IShellItem psiItem, const(wchar)* pszNewName);
    HRESULT PostRenameItem(uint dwFlags, IShellItem psiItem, const(wchar)* pszNewName, HRESULT hrRename, IShellItem psiNewlyCreated);
    HRESULT PreMoveItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszNewName);
    HRESULT PostMoveItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszNewName, HRESULT hrMove, IShellItem psiNewlyCreated);
    HRESULT PreCopyItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszNewName);
    HRESULT PostCopyItem(uint dwFlags, IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszNewName, HRESULT hrCopy, IShellItem psiNewlyCreated);
    HRESULT PreDeleteItem(uint dwFlags, IShellItem psiItem);
    HRESULT PostDeleteItem(uint dwFlags, IShellItem psiItem, HRESULT hrDelete, IShellItem psiNewlyCreated);
    HRESULT PreNewItem(uint dwFlags, IShellItem psiDestinationFolder, const(wchar)* pszNewName);
    HRESULT PostNewItem(uint dwFlags, IShellItem psiDestinationFolder, const(wchar)* pszNewName, const(wchar)* pszTemplateName, uint dwFileAttributes, HRESULT hrNew, IShellItem psiNewItem);
    HRESULT UpdateProgress(uint iWorkTotal, uint iWorkSoFar);
    HRESULT ResetTimer();
    HRESULT PauseTimer();
    HRESULT ResumeTimer();
}

enum SIATTRIBFLAGS
{
    SIATTRIBFLAGS_AND = 1,
    SIATTRIBFLAGS_OR = 2,
    SIATTRIBFLAGS_APPCOMPAT = 3,
    SIATTRIBFLAGS_MASK = 3,
    SIATTRIBFLAGS_ALLITEMS = 16384,
}

const GUID IID_IShellItemArray = {0xB63EA76D, 0x1F85, 0x456F, [0xA1, 0x9C, 0x48, 0x15, 0x9E, 0xFA, 0x85, 0x8B]};
@GUID(0xB63EA76D, 0x1F85, 0x456F, [0xA1, 0x9C, 0x48, 0x15, 0x9E, 0xFA, 0x85, 0x8B]);
interface IShellItemArray : IUnknown
{
    HRESULT BindToHandler(IBindCtx pbc, const(Guid)* bhid, const(Guid)* riid, void** ppvOut);
    HRESULT GetPropertyStore(GETPROPERTYSTOREFLAGS flags, const(Guid)* riid, void** ppv);
    HRESULT GetPropertyDescriptionList(const(PROPERTYKEY)* keyType, const(Guid)* riid, void** ppv);
    HRESULT GetAttributes(SIATTRIBFLAGS AttribFlags, uint sfgaoMask, uint* psfgaoAttribs);
    HRESULT GetCount(uint* pdwNumItems);
    HRESULT GetItemAt(uint dwIndex, IShellItem* ppsi);
    HRESULT EnumItems(IEnumShellItems* ppenumShellItems);
}

const GUID IID_IInitializeWithItem = {0x7F73BE3F, 0xFB79, 0x493C, [0xA6, 0xC7, 0x7E, 0xE1, 0x4E, 0x24, 0x58, 0x41]};
@GUID(0x7F73BE3F, 0xFB79, 0x493C, [0xA6, 0xC7, 0x7E, 0xE1, 0x4E, 0x24, 0x58, 0x41]);
interface IInitializeWithItem : IUnknown
{
    HRESULT Initialize(IShellItem psi, uint grfMode);
}

const GUID IID_IObjectWithSelection = {0x1C9CD5BB, 0x98E9, 0x4491, [0xA6, 0x0F, 0x31, 0xAA, 0xCC, 0x72, 0xB8, 0x3C]};
@GUID(0x1C9CD5BB, 0x98E9, 0x4491, [0xA6, 0x0F, 0x31, 0xAA, 0xCC, 0x72, 0xB8, 0x3C]);
interface IObjectWithSelection : IUnknown
{
    HRESULT SetSelection(IShellItemArray psia);
    HRESULT GetSelection(const(Guid)* riid, void** ppv);
}

const GUID IID_IObjectWithBackReferences = {0x321A6A6A, 0xD61F, 0x4BF3, [0x97, 0xAE, 0x14, 0xBE, 0x29, 0x86, 0xBB, 0x36]};
@GUID(0x321A6A6A, 0xD61F, 0x4BF3, [0x97, 0xAE, 0x14, 0xBE, 0x29, 0x86, 0xBB, 0x36]);
interface IObjectWithBackReferences : IUnknown
{
    HRESULT RemoveBackReferences();
}

enum _PROPERTYUI_NAME_FLAGS
{
    PUIFNF_DEFAULT = 0,
    PUIFNF_MNEMONIC = 1,
}

enum _PROPERTYUI_FORMAT_FLAGS
{
    PUIFFDF_DEFAULT = 0,
    PUIFFDF_RIGHTTOLEFT = 1,
    PUIFFDF_SHORTFORMAT = 2,
    PUIFFDF_NOTIME = 4,
    PUIFFDF_FRIENDLYDATE = 8,
}

const GUID IID_ICategoryProvider = {0x9AF64809, 0x5864, 0x4C26, [0xA7, 0x20, 0xC1, 0xF7, 0x8C, 0x08, 0x6E, 0xE3]};
@GUID(0x9AF64809, 0x5864, 0x4C26, [0xA7, 0x20, 0xC1, 0xF7, 0x8C, 0x08, 0x6E, 0xE3]);
interface ICategoryProvider : IUnknown
{
    HRESULT CanCategorizeOnSCID(const(PROPERTYKEY)* pscid);
    HRESULT GetDefaultCategory(Guid* pguid, PROPERTYKEY* pscid);
    HRESULT GetCategoryForSCID(const(PROPERTYKEY)* pscid, Guid* pguid);
    HRESULT EnumCategories(IEnumGUID* penum);
    HRESULT GetCategoryName(const(Guid)* pguid, const(wchar)* pszName, uint cch);
    HRESULT CreateCategory(const(Guid)* pguid, const(Guid)* riid, void** ppv);
}

enum CATEGORYINFO_FLAGS
{
    CATINFO_NORMAL = 0,
    CATINFO_COLLAPSED = 1,
    CATINFO_HIDDEN = 2,
    CATINFO_EXPANDED = 4,
    CATINFO_NOHEADER = 8,
    CATINFO_NOTCOLLAPSIBLE = 16,
    CATINFO_NOHEADERCOUNT = 32,
    CATINFO_SUBSETTED = 64,
    CATINFO_SEPARATE_IMAGES = 128,
    CATINFO_SHOWEMPTY = 256,
}

enum CATSORT_FLAGS
{
    CATSORT_DEFAULT = 0,
    CATSORT_NAME = 1,
}

struct CATEGORY_INFO
{
    CATEGORYINFO_FLAGS cif;
    ushort wszName;
}

const GUID IID_ICategorizer = {0xA3B14589, 0x9174, 0x49A8, [0x89, 0xA3, 0x06, 0xA1, 0xAE, 0x2B, 0x9B, 0xA7]};
@GUID(0xA3B14589, 0x9174, 0x49A8, [0x89, 0xA3, 0x06, 0xA1, 0xAE, 0x2B, 0x9B, 0xA7]);
interface ICategorizer : IUnknown
{
    HRESULT GetDescription(const(wchar)* pszDesc, uint cch);
    HRESULT GetCategory(uint cidl, char* apidl, char* rgCategoryIds);
    HRESULT GetCategoryInfo(uint dwCategoryId, CATEGORY_INFO* pci);
    HRESULT CompareCategory(CATSORT_FLAGS csfFlags, uint dwCategoryId1, uint dwCategoryId2);
}

struct SHDRAGIMAGE
{
    SIZE sizeDragImage;
    POINT ptOffset;
    HBITMAP hbmpDragImage;
    uint crColorKey;
}

const GUID IID_IDropTargetHelper = {0x4657278B, 0x411B, 0x11D2, [0x83, 0x9A, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0x4657278B, 0x411B, 0x11D2, [0x83, 0x9A, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
interface IDropTargetHelper : IUnknown
{
    HRESULT DragEnter(HWND hwndTarget, IDataObject pDataObject, POINT* ppt, uint dwEffect);
    HRESULT DragLeave();
    HRESULT DragOver(POINT* ppt, uint dwEffect);
    HRESULT Drop(IDataObject pDataObject, POINT* ppt, uint dwEffect);
    HRESULT Show(BOOL fShow);
}

const GUID IID_IDragSourceHelper = {0xDE5BF786, 0x477A, 0x11D2, [0x83, 0x9D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0xDE5BF786, 0x477A, 0x11D2, [0x83, 0x9D, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
interface IDragSourceHelper : IUnknown
{
    HRESULT InitializeFromBitmap(SHDRAGIMAGE* pshdi, IDataObject pDataObject);
    HRESULT InitializeFromWindow(HWND hwnd, POINT* ppt, IDataObject pDataObject);
}

enum SLR_FLAGS
{
    SLR_NONE = 0,
    SLR_NO_UI = 1,
    SLR_ANY_MATCH = 2,
    SLR_UPDATE = 4,
    SLR_NOUPDATE = 8,
    SLR_NOSEARCH = 16,
    SLR_NOTRACK = 32,
    SLR_NOLINKINFO = 64,
    SLR_INVOKE_MSI = 128,
    SLR_NO_UI_WITH_MSG_PUMP = 257,
    SLR_OFFER_DELETE_WITHOUT_FILE = 512,
    SLR_KNOWNFOLDER = 1024,
    SLR_MACHINE_IN_LOCAL_TARGET = 2048,
    SLR_UPDATE_MACHINE_AND_SID = 4096,
    SLR_NO_OBJECT_ID = 8192,
}

enum SLGP_FLAGS
{
    SLGP_SHORTPATH = 1,
    SLGP_UNCPRIORITY = 2,
    SLGP_RAWPATH = 4,
    SLGP_RELATIVEPRIORITY = 8,
}

const GUID IID_IShellLinkA = {0x000214EE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214EE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellLinkA : IUnknown
{
    HRESULT GetPath(const(char)* pszFile, int cch, WIN32_FIND_DATAA* pfd, uint fFlags);
    HRESULT GetIDList(ITEMIDLIST** ppidl);
    HRESULT SetIDList(ITEMIDLIST* pidl);
    HRESULT GetDescription(const(char)* pszName, int cch);
    HRESULT SetDescription(const(char)* pszName);
    HRESULT GetWorkingDirectory(const(char)* pszDir, int cch);
    HRESULT SetWorkingDirectory(const(char)* pszDir);
    HRESULT GetArguments(const(char)* pszArgs, int cch);
    HRESULT SetArguments(const(char)* pszArgs);
    HRESULT GetHotkey(ushort* pwHotkey);
    HRESULT SetHotkey(ushort wHotkey);
    HRESULT GetShowCmd(int* piShowCmd);
    HRESULT SetShowCmd(int iShowCmd);
    HRESULT GetIconLocation(const(char)* pszIconPath, int cch, int* piIcon);
    HRESULT SetIconLocation(const(char)* pszIconPath, int iIcon);
    HRESULT SetRelativePath(const(char)* pszPathRel, uint dwReserved);
    HRESULT Resolve(HWND hwnd, uint fFlags);
    HRESULT SetPath(const(char)* pszFile);
}

const GUID IID_IShellLinkW = {0x000214F9, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F9, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellLinkW : IUnknown
{
    HRESULT GetPath(const(wchar)* pszFile, int cch, WIN32_FIND_DATAW* pfd, uint fFlags);
    HRESULT GetIDList(ITEMIDLIST** ppidl);
    HRESULT SetIDList(ITEMIDLIST* pidl);
    HRESULT GetDescription(const(wchar)* pszName, int cch);
    HRESULT SetDescription(const(wchar)* pszName);
    HRESULT GetWorkingDirectory(const(wchar)* pszDir, int cch);
    HRESULT SetWorkingDirectory(const(wchar)* pszDir);
    HRESULT GetArguments(const(wchar)* pszArgs, int cch);
    HRESULT SetArguments(const(wchar)* pszArgs);
    HRESULT GetHotkey(ushort* pwHotkey);
    HRESULT SetHotkey(ushort wHotkey);
    HRESULT GetShowCmd(int* piShowCmd);
    HRESULT SetShowCmd(int iShowCmd);
    HRESULT GetIconLocation(const(wchar)* pszIconPath, int cch, int* piIcon);
    HRESULT SetIconLocation(const(wchar)* pszIconPath, int iIcon);
    HRESULT SetRelativePath(const(wchar)* pszPathRel, uint dwReserved);
    HRESULT Resolve(HWND hwnd, uint fFlags);
    HRESULT SetPath(const(wchar)* pszFile);
}

const GUID IID_IShellLinkDataList = {0x45E2B4AE, 0xB1C3, 0x11D0, [0xB9, 0x2F, 0x00, 0xA0, 0xC9, 0x03, 0x12, 0xE1]};
@GUID(0x45E2B4AE, 0xB1C3, 0x11D0, [0xB9, 0x2F, 0x00, 0xA0, 0xC9, 0x03, 0x12, 0xE1]);
interface IShellLinkDataList : IUnknown
{
    HRESULT AddDataBlock(void* pDataBlock);
    HRESULT CopyDataBlock(uint dwSig, void** ppDataBlock);
    HRESULT RemoveDataBlock(uint dwSig);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT SetFlags(uint dwFlags);
}

const GUID IID_IResolveShellLink = {0x5CD52983, 0x9449, 0x11D2, [0x96, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0xAD, 0xF0]};
@GUID(0x5CD52983, 0x9449, 0x11D2, [0x96, 0x3A, 0x00, 0xC0, 0x4F, 0x79, 0xAD, 0xF0]);
interface IResolveShellLink : IUnknown
{
    HRESULT ResolveShellLink(IUnknown punkLink, HWND hwnd, uint fFlags);
}

enum _SPINITF
{
    SPINITF_NORMAL = 0,
    SPINITF_MODAL = 1,
    SPINITF_NOMINIMIZE = 8,
}

const GUID IID_IActionProgressDialog = {0x49FF1172, 0xEADC, 0x446D, [0x92, 0x85, 0x15, 0x64, 0x53, 0xA6, 0x43, 0x1C]};
@GUID(0x49FF1172, 0xEADC, 0x446D, [0x92, 0x85, 0x15, 0x64, 0x53, 0xA6, 0x43, 0x1C]);
interface IActionProgressDialog : IUnknown
{
    HRESULT Initialize(uint flags, const(wchar)* pszTitle, const(wchar)* pszCancel);
    HRESULT Stop();
}

enum _SPBEGINF
{
    SPBEGINF_NORMAL = 0,
    SPBEGINF_AUTOTIME = 2,
    SPBEGINF_NOPROGRESSBAR = 16,
    SPBEGINF_MARQUEEPROGRESS = 32,
    SPBEGINF_NOCANCELBUTTON = 64,
}

enum SPACTION
{
    SPACTION_NONE = 0,
    SPACTION_MOVING = 1,
    SPACTION_COPYING = 2,
    SPACTION_RECYCLING = 3,
    SPACTION_APPLYINGATTRIBS = 4,
    SPACTION_DOWNLOADING = 5,
    SPACTION_SEARCHING_INTERNET = 6,
    SPACTION_CALCULATING = 7,
    SPACTION_UPLOADING = 8,
    SPACTION_SEARCHING_FILES = 9,
    SPACTION_DELETING = 10,
    SPACTION_RENAMING = 11,
    SPACTION_FORMATTING = 12,
    SPACTION_COPY_MOVING = 13,
}

enum SPTEXT
{
    SPTEXT_ACTIONDESCRIPTION = 1,
    SPTEXT_ACTIONDETAIL = 2,
}

const GUID IID_IActionProgress = {0x49FF1173, 0xEADC, 0x446D, [0x92, 0x85, 0x15, 0x64, 0x53, 0xA6, 0x43, 0x1C]};
@GUID(0x49FF1173, 0xEADC, 0x446D, [0x92, 0x85, 0x15, 0x64, 0x53, 0xA6, 0x43, 0x1C]);
interface IActionProgress : IUnknown
{
    HRESULT Begin(SPACTION action, uint flags);
    HRESULT UpdateProgress(ulong ulCompleted, ulong ulTotal);
    HRESULT UpdateText(SPTEXT sptext, const(wchar)* pszText, BOOL fMayCompact);
    HRESULT QueryCancel(int* pfCancelled);
    HRESULT ResetCancel();
    HRESULT End();
}

const GUID IID_IShellExtInit = {0x000214E8, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E8, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellExtInit : IUnknown
{
    HRESULT Initialize(ITEMIDLIST* pidlFolder, IDataObject pdtobj, HKEY hkeyProgID);
}

enum _EXPPS
{
    EXPPS_FILETYPES = 1,
}

const GUID IID_IShellPropSheetExt = {0x000214E9, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E9, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellPropSheetExt : IUnknown
{
    HRESULT AddPages(LPFNSVADDPROPSHEETPAGE pfnAddPage, LPARAM lParam);
    HRESULT ReplacePage(uint uPageID, LPFNSVADDPROPSHEETPAGE pfnReplaceWith, LPARAM lParam);
}

const GUID IID_IRemoteComputer = {0x000214FE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214FE, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IRemoteComputer : IUnknown
{
    HRESULT Initialize(const(wchar)* pszMachine, BOOL bEnumerating);
}

const GUID IID_IQueryContinue = {0x7307055C, 0xB24A, 0x486B, [0x9F, 0x25, 0x16, 0x3E, 0x59, 0x7A, 0x28, 0xA9]};
@GUID(0x7307055C, 0xB24A, 0x486B, [0x9F, 0x25, 0x16, 0x3E, 0x59, 0x7A, 0x28, 0xA9]);
interface IQueryContinue : IUnknown
{
    HRESULT QueryContinue();
}

const GUID IID_IObjectWithCancelEvent = {0xF279B885, 0x0AE9, 0x4B85, [0xAC, 0x06, 0xDD, 0xEC, 0xF9, 0x40, 0x89, 0x41]};
@GUID(0xF279B885, 0x0AE9, 0x4B85, [0xAC, 0x06, 0xDD, 0xEC, 0xF9, 0x40, 0x89, 0x41]);
interface IObjectWithCancelEvent : IUnknown
{
    HRESULT GetCancelEvent(HANDLE* phEvent);
}

const GUID IID_IUserNotification = {0xBA9711BA, 0x5893, 0x4787, [0xA7, 0xE1, 0x41, 0x27, 0x71, 0x51, 0x55, 0x0B]};
@GUID(0xBA9711BA, 0x5893, 0x4787, [0xA7, 0xE1, 0x41, 0x27, 0x71, 0x51, 0x55, 0x0B]);
interface IUserNotification : IUnknown
{
    HRESULT SetBalloonInfo(const(wchar)* pszTitle, const(wchar)* pszText, uint dwInfoFlags);
    HRESULT SetBalloonRetry(uint dwShowTime, uint dwInterval, uint cRetryCount);
    HRESULT SetIconInfo(HICON hIcon, const(wchar)* pszToolTip);
    HRESULT Show(IQueryContinue pqc, uint dwContinuePollInterval);
    HRESULT PlaySoundA(const(wchar)* pszSoundName);
}

const GUID IID_IItemNameLimits = {0x1DF0D7F1, 0xB267, 0x4D28, [0x8B, 0x10, 0x12, 0xE2, 0x32, 0x02, 0xA5, 0xC4]};
@GUID(0x1DF0D7F1, 0xB267, 0x4D28, [0x8B, 0x10, 0x12, 0xE2, 0x32, 0x02, 0xA5, 0xC4]);
interface IItemNameLimits : IUnknown
{
    HRESULT GetValidCharacters(ushort** ppwszValidChars, ushort** ppwszInvalidChars);
    HRESULT GetMaxLength(const(wchar)* pszName, int* piMaxNameLen);
}

const GUID IID_ISearchFolderItemFactory = {0xA0FFBC28, 0x5482, 0x4366, [0xBE, 0x27, 0x3E, 0x81, 0xE7, 0x8E, 0x06, 0xC2]};
@GUID(0xA0FFBC28, 0x5482, 0x4366, [0xBE, 0x27, 0x3E, 0x81, 0xE7, 0x8E, 0x06, 0xC2]);
interface ISearchFolderItemFactory : IUnknown
{
    HRESULT SetDisplayName(const(wchar)* pszDisplayName);
    HRESULT SetFolderTypeID(Guid ftid);
    HRESULT SetFolderLogicalViewMode(FOLDERLOGICALVIEWMODE flvm);
    HRESULT SetIconSize(int iIconSize);
    HRESULT SetVisibleColumns(uint cVisibleColumns, char* rgKey);
    HRESULT SetSortColumns(uint cSortColumns, char* rgSortColumns);
    HRESULT SetGroupColumn(const(PROPERTYKEY)* keyGroup);
    HRESULT SetStacks(uint cStackKeys, char* rgStackKeys);
    HRESULT SetScope(IShellItemArray psiaScope);
    HRESULT SetCondition(ICondition pCondition);
    HRESULT GetShellItem(const(Guid)* riid, void** ppv);
    HRESULT GetIDList(ITEMIDLIST** ppidl);
}

const GUID IID_IExtractImage = {0xBB2E617C, 0x0920, 0x11D1, [0x9A, 0x0B, 0x00, 0xC0, 0x4F, 0xC2, 0xD6, 0xC1]};
@GUID(0xBB2E617C, 0x0920, 0x11D1, [0x9A, 0x0B, 0x00, 0xC0, 0x4F, 0xC2, 0xD6, 0xC1]);
interface IExtractImage : IUnknown
{
    HRESULT GetLocation(const(wchar)* pszPathBuffer, uint cch, uint* pdwPriority, const(SIZE)* prgSize, uint dwRecClrDepth, uint* pdwFlags);
    HRESULT Extract(HBITMAP* phBmpThumbnail);
}

const GUID IID_IExtractImage2 = {0x953BB1EE, 0x93B4, 0x11D1, [0x98, 0xA3, 0x00, 0xC0, 0x4F, 0xB6, 0x87, 0xDA]};
@GUID(0x953BB1EE, 0x93B4, 0x11D1, [0x98, 0xA3, 0x00, 0xC0, 0x4F, 0xB6, 0x87, 0xDA]);
interface IExtractImage2 : IExtractImage
{
    HRESULT GetDateStamp(FILETIME* pDateStamp);
}

const GUID IID_IThumbnailHandlerFactory = {0xE35B4B2E, 0x00DA, 0x4BC1, [0x9F, 0x13, 0x38, 0xBC, 0x11, 0xF5, 0xD4, 0x17]};
@GUID(0xE35B4B2E, 0x00DA, 0x4BC1, [0x9F, 0x13, 0x38, 0xBC, 0x11, 0xF5, 0xD4, 0x17]);
interface IThumbnailHandlerFactory : IUnknown
{
    HRESULT GetThumbnailHandler(ITEMIDLIST* pidlChild, IBindCtx pbc, const(Guid)* riid, void** ppv);
}

const GUID IID_IParentAndItem = {0xB3A4B685, 0xB685, 0x4805, [0x99, 0xD9, 0x5D, 0xEA, 0xD2, 0x87, 0x32, 0x36]};
@GUID(0xB3A4B685, 0xB685, 0x4805, [0x99, 0xD9, 0x5D, 0xEA, 0xD2, 0x87, 0x32, 0x36]);
interface IParentAndItem : IUnknown
{
    HRESULT SetParentAndItem(ITEMIDLIST* pidlParent, IShellFolder psf, ITEMIDLIST* pidlChild);
    HRESULT GetParentAndItem(ITEMIDLIST** ppidlParent, IShellFolder* ppsf, ITEMIDLIST** ppidlChild);
}

const GUID IID_IDockingWindow = {0x012DD920, 0x7B26, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0x012DD920, 0x7B26, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface IDockingWindow : IOleWindow
{
    HRESULT ShowDW(BOOL fShow);
    HRESULT CloseDW(uint dwReserved);
    HRESULT ResizeBorderDW(RECT* prcBorder, IUnknown punkToolbarSite, BOOL fReserved);
}

struct DESKBANDINFO
{
    uint dwMask;
    POINTL ptMinSize;
    POINTL ptMaxSize;
    POINTL ptIntegral;
    POINTL ptActual;
    ushort wszTitle;
    uint dwModeFlags;
    uint crBkgnd;
}

enum tagDESKBANDCID
{
    DBID_BANDINFOCHANGED = 0,
    DBID_SHOWONLY = 1,
    DBID_MAXIMIZEBAND = 2,
    DBID_PUSHCHEVRON = 3,
    DBID_DELAYINIT = 4,
    DBID_FINISHINIT = 5,
    DBID_SETWINDOWTHEME = 6,
    DBID_PERMITAUTOHIDE = 7,
}

const GUID IID_IDeskBand = {0xEB0FE172, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]};
@GUID(0xEB0FE172, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]);
interface IDeskBand : IDockingWindow
{
    HRESULT GetBandInfo(uint dwBandID, uint dwViewMode, DESKBANDINFO* pdbi);
}

const GUID IID_IDeskBandInfo = {0x77E425FC, 0xCBF9, 0x4307, [0xBA, 0x6A, 0xBB, 0x57, 0x27, 0x74, 0x56, 0x61]};
@GUID(0x77E425FC, 0xCBF9, 0x4307, [0xBA, 0x6A, 0xBB, 0x57, 0x27, 0x74, 0x56, 0x61]);
interface IDeskBandInfo : IUnknown
{
    HRESULT GetDefaultBandWidth(uint dwBandID, uint dwViewMode, int* pnWidth);
}

const GUID IID_ITaskbarList = {0x56FDF342, 0xFD6D, 0x11D0, [0x95, 0x8A, 0x00, 0x60, 0x97, 0xC9, 0xA0, 0x90]};
@GUID(0x56FDF342, 0xFD6D, 0x11D0, [0x95, 0x8A, 0x00, 0x60, 0x97, 0xC9, 0xA0, 0x90]);
interface ITaskbarList : IUnknown
{
    HRESULT HrInit();
    HRESULT AddTab(HWND hwnd);
    HRESULT DeleteTab(HWND hwnd);
    HRESULT ActivateTab(HWND hwnd);
    HRESULT SetActiveAlt(HWND hwnd);
}

const GUID IID_ITaskbarList2 = {0x602D4995, 0xB13A, 0x429B, [0xA6, 0x6E, 0x19, 0x35, 0xE4, 0x4F, 0x43, 0x17]};
@GUID(0x602D4995, 0xB13A, 0x429B, [0xA6, 0x6E, 0x19, 0x35, 0xE4, 0x4F, 0x43, 0x17]);
interface ITaskbarList2 : ITaskbarList
{
    HRESULT MarkFullscreenWindow(HWND hwnd, BOOL fFullscreen);
}

enum THUMBBUTTONFLAGS
{
    THBF_ENABLED = 0,
    THBF_DISABLED = 1,
    THBF_DISMISSONCLICK = 2,
    THBF_NOBACKGROUND = 4,
    THBF_HIDDEN = 8,
    THBF_NONINTERACTIVE = 16,
}

enum THUMBBUTTONMASK
{
    THB_BITMAP = 1,
    THB_ICON = 2,
    THB_TOOLTIP = 4,
    THB_FLAGS = 8,
}

struct THUMBBUTTON
{
    THUMBBUTTONMASK dwMask;
    uint iId;
    uint iBitmap;
    HICON hIcon;
    ushort szTip;
    THUMBBUTTONFLAGS dwFlags;
}

enum TBPFLAG
{
    TBPF_NOPROGRESS = 0,
    TBPF_INDETERMINATE = 1,
    TBPF_NORMAL = 2,
    TBPF_ERROR = 4,
    TBPF_PAUSED = 8,
}

const GUID IID_ITaskbarList3 = {0xEA1AFB91, 0x9E28, 0x4B86, [0x90, 0xE9, 0x9E, 0x9F, 0x8A, 0x5E, 0xEF, 0xAF]};
@GUID(0xEA1AFB91, 0x9E28, 0x4B86, [0x90, 0xE9, 0x9E, 0x9F, 0x8A, 0x5E, 0xEF, 0xAF]);
interface ITaskbarList3 : ITaskbarList2
{
    HRESULT SetProgressValue(HWND hwnd, ulong ullCompleted, ulong ullTotal);
    HRESULT SetProgressState(HWND hwnd, TBPFLAG tbpFlags);
    HRESULT RegisterTab(HWND hwndTab, HWND hwndMDI);
    HRESULT UnregisterTab(HWND hwndTab);
    HRESULT SetTabOrder(HWND hwndTab, HWND hwndInsertBefore);
    HRESULT SetTabActive(HWND hwndTab, HWND hwndMDI, uint dwReserved);
    HRESULT ThumbBarAddButtons(HWND hwnd, uint cButtons, char* pButton);
    HRESULT ThumbBarUpdateButtons(HWND hwnd, uint cButtons, char* pButton);
    HRESULT ThumbBarSetImageList(HWND hwnd, HIMAGELIST himl);
    HRESULT SetOverlayIcon(HWND hwnd, HICON hIcon, const(wchar)* pszDescription);
    HRESULT SetThumbnailTooltip(HWND hwnd, const(wchar)* pszTip);
    HRESULT SetThumbnailClip(HWND hwnd, RECT* prcClip);
}

enum STPFLAG
{
    STPF_NONE = 0,
    STPF_USEAPPTHUMBNAILALWAYS = 1,
    STPF_USEAPPTHUMBNAILWHENACTIVE = 2,
    STPF_USEAPPPEEKALWAYS = 4,
    STPF_USEAPPPEEKWHENACTIVE = 8,
}

const GUID IID_ITaskbarList4 = {0xC43DC798, 0x95D1, 0x4BEA, [0x90, 0x30, 0xBB, 0x99, 0xE2, 0x98, 0x3A, 0x1A]};
@GUID(0xC43DC798, 0x95D1, 0x4BEA, [0x90, 0x30, 0xBB, 0x99, 0xE2, 0x98, 0x3A, 0x1A]);
interface ITaskbarList4 : ITaskbarList3
{
    HRESULT SetTabProperties(HWND hwndTab, STPFLAG stpFlags);
}

const GUID IID_IExplorerBrowserEvents = {0x361BBDC7, 0xE6EE, 0x4E13, [0xBE, 0x58, 0x58, 0xE2, 0x24, 0x0C, 0x81, 0x0F]};
@GUID(0x361BBDC7, 0xE6EE, 0x4E13, [0xBE, 0x58, 0x58, 0xE2, 0x24, 0x0C, 0x81, 0x0F]);
interface IExplorerBrowserEvents : IUnknown
{
    HRESULT OnNavigationPending(ITEMIDLIST* pidlFolder);
    HRESULT OnViewCreated(IShellView psv);
    HRESULT OnNavigationComplete(ITEMIDLIST* pidlFolder);
    HRESULT OnNavigationFailed(ITEMIDLIST* pidlFolder);
}

enum EXPLORER_BROWSER_OPTIONS
{
    EBO_NONE = 0,
    EBO_NAVIGATEONCE = 1,
    EBO_SHOWFRAMES = 2,
    EBO_ALWAYSNAVIGATE = 4,
    EBO_NOTRAVELLOG = 8,
    EBO_NOWRAPPERWINDOW = 16,
    EBO_HTMLSHAREPOINTVIEW = 32,
    EBO_NOBORDER = 64,
    EBO_NOPERSISTVIEWSTATE = 128,
}

enum EXPLORER_BROWSER_FILL_FLAGS
{
    EBF_NONE = 0,
    EBF_SELECTFROMDATAOBJECT = 256,
    EBF_NODROPTARGET = 512,
}

const GUID IID_IExplorerBrowser = {0xDFD3B6B5, 0xC10C, 0x4BE9, [0x85, 0xF6, 0xA6, 0x69, 0x69, 0xF4, 0x02, 0xF6]};
@GUID(0xDFD3B6B5, 0xC10C, 0x4BE9, [0x85, 0xF6, 0xA6, 0x69, 0x69, 0xF4, 0x02, 0xF6]);
interface IExplorerBrowser : IUnknown
{
    HRESULT Initialize(HWND hwndParent, const(RECT)* prc, const(FOLDERSETTINGS)* pfs);
    HRESULT Destroy();
    HRESULT SetRect(int* phdwp, RECT rcBrowser);
    HRESULT SetPropertyBag(const(wchar)* pszPropertyBag);
    HRESULT SetEmptyText(const(wchar)* pszEmptyText);
    HRESULT SetFolderSettings(const(FOLDERSETTINGS)* pfs);
    HRESULT Advise(IExplorerBrowserEvents psbe, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT SetOptions(EXPLORER_BROWSER_OPTIONS dwFlag);
    HRESULT GetOptions(EXPLORER_BROWSER_OPTIONS* pdwFlag);
    HRESULT BrowseToIDList(ITEMIDLIST* pidl, uint uFlags);
    HRESULT BrowseToObject(IUnknown punk, uint uFlags);
    HRESULT FillFromObject(IUnknown punk, EXPLORER_BROWSER_FILL_FLAGS dwFlags);
    HRESULT RemoveAll();
    HRESULT GetCurrentView(const(Guid)* riid, void** ppv);
}

const GUID IID_IEnumObjects = {0x2C1C7E2E, 0x2D0E, 0x4059, [0x83, 0x1E, 0x1E, 0x6F, 0x82, 0x33, 0x5C, 0x2E]};
@GUID(0x2C1C7E2E, 0x2D0E, 0x4059, [0x83, 0x1E, 0x1E, 0x6F, 0x82, 0x33, 0x5C, 0x2E]);
interface IEnumObjects : IUnknown
{
    HRESULT Next(uint celt, const(Guid)* riid, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumObjects* ppenum);
}

enum _OPPROGDLGF
{
    OPPROGDLG_DEFAULT = 0,
    OPPROGDLG_ENABLEPAUSE = 128,
    OPPROGDLG_ALLOWUNDO = 256,
    OPPROGDLG_DONTDISPLAYSOURCEPATH = 512,
    OPPROGDLG_DONTDISPLAYDESTPATH = 1024,
    OPPROGDLG_NOMULTIDAYESTIMATES = 2048,
    OPPROGDLG_DONTDISPLAYLOCATIONS = 4096,
}

enum _PDMODE
{
    PDM_DEFAULT = 0,
    PDM_RUN = 1,
    PDM_PREFLIGHT = 2,
    PDM_UNDOING = 4,
    PDM_ERRORSBLOCKING = 8,
    PDM_INDETERMINATE = 16,
}

const GUID IID_IOperationsProgressDialog = {0x0C9FB851, 0xE5C9, 0x43EB, [0xA3, 0x70, 0xF0, 0x67, 0x7B, 0x13, 0x87, 0x4C]};
@GUID(0x0C9FB851, 0xE5C9, 0x43EB, [0xA3, 0x70, 0xF0, 0x67, 0x7B, 0x13, 0x87, 0x4C]);
interface IOperationsProgressDialog : IUnknown
{
    HRESULT StartProgressDialog(HWND hwndOwner, uint flags);
    HRESULT StopProgressDialog();
    HRESULT SetOperation(SPACTION action);
    HRESULT SetMode(uint mode);
    HRESULT UpdateProgress(ulong ullPointsCurrent, ulong ullPointsTotal, ulong ullSizeCurrent, ulong ullSizeTotal, ulong ullItemsCurrent, ulong ullItemsTotal);
    HRESULT UpdateLocations(IShellItem psiSource, IShellItem psiTarget, IShellItem psiItem);
    HRESULT ResetTimer();
    HRESULT PauseTimer();
    HRESULT ResumeTimer();
    HRESULT GetMilliseconds(ulong* pullElapsed, ulong* pullRemaining);
    HRESULT GetOperationStatus(PDOPSTATUS* popstatus);
}

const GUID IID_IIOCancelInformation = {0xF5B0BF81, 0x8CB5, 0x4B1B, [0x94, 0x49, 0x1A, 0x15, 0x9E, 0x0C, 0x73, 0x3C]};
@GUID(0xF5B0BF81, 0x8CB5, 0x4B1B, [0x94, 0x49, 0x1A, 0x15, 0x9E, 0x0C, 0x73, 0x3C]);
interface IIOCancelInformation : IUnknown
{
    HRESULT SetCancelInformation(uint dwThreadID, uint uMsgCancel);
    HRESULT GetCancelInformation(uint* pdwThreadID, uint* puMsgCancel);
}

const GUID IID_IFileOperation = {0x947AAB5F, 0x0A5C, 0x4C13, [0xB4, 0xD6, 0x4B, 0xF7, 0x83, 0x6F, 0xC9, 0xF8]};
@GUID(0x947AAB5F, 0x0A5C, 0x4C13, [0xB4, 0xD6, 0x4B, 0xF7, 0x83, 0x6F, 0xC9, 0xF8]);
interface IFileOperation : IUnknown
{
    HRESULT Advise(IFileOperationProgressSink pfops, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT SetOperationFlags(uint dwOperationFlags);
    HRESULT SetProgressMessage(const(wchar)* pszMessage);
    HRESULT SetProgressDialog(IOperationsProgressDialog popd);
    HRESULT SetProperties(IPropertyChangeArray pproparray);
    HRESULT SetOwnerWindow(HWND hwndOwner);
    HRESULT ApplyPropertiesToItem(IShellItem psiItem);
    HRESULT ApplyPropertiesToItems(IUnknown punkItems);
    HRESULT RenameItem(IShellItem psiItem, const(wchar)* pszNewName, IFileOperationProgressSink pfopsItem);
    HRESULT RenameItems(IUnknown pUnkItems, const(wchar)* pszNewName);
    HRESULT MoveItem(IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszNewName, IFileOperationProgressSink pfopsItem);
    HRESULT MoveItems(IUnknown punkItems, IShellItem psiDestinationFolder);
    HRESULT CopyItem(IShellItem psiItem, IShellItem psiDestinationFolder, const(wchar)* pszCopyName, IFileOperationProgressSink pfopsItem);
    HRESULT CopyItems(IUnknown punkItems, IShellItem psiDestinationFolder);
    HRESULT DeleteItem(IShellItem psiItem, IFileOperationProgressSink pfopsItem);
    HRESULT DeleteItems(IUnknown punkItems);
    HRESULT NewItem(IShellItem psiDestinationFolder, uint dwFileAttributes, const(wchar)* pszName, const(wchar)* pszTemplateName, IFileOperationProgressSink pfopsItem);
    HRESULT PerformOperations();
    HRESULT GetAnyOperationsAborted(int* pfAnyOperationsAborted);
}

enum FILE_OPERATION_FLAGS2
{
    FOF2_NONE = 0,
    FOF2_MERGEFOLDERSONCOLLISION = 1,
}

const GUID IID_IFileOperation2 = {0xCD8F23C1, 0x8F61, 0x4916, [0x90, 0x9D, 0x55, 0xBD, 0xD0, 0x91, 0x87, 0x53]};
@GUID(0xCD8F23C1, 0x8F61, 0x4916, [0x90, 0x9D, 0x55, 0xBD, 0xD0, 0x91, 0x87, 0x53]);
interface IFileOperation2 : IFileOperation
{
    HRESULT SetOperationFlags2(FILE_OPERATION_FLAGS2 operationFlags2);
}

const GUID IID_IObjectProvider = {0xA6087428, 0x3BE3, 0x4D73, [0xB3, 0x08, 0x7C, 0x04, 0xA5, 0x40, 0xBF, 0x1A]};
@GUID(0xA6087428, 0x3BE3, 0x4D73, [0xB3, 0x08, 0x7C, 0x04, 0xA5, 0x40, 0xBF, 0x1A]);
interface IObjectProvider : IUnknown
{
    HRESULT QueryObject(const(Guid)* guidObject, const(Guid)* riid, void** ppvOut);
}

const GUID IID_INamespaceWalkCB = {0xD92995F8, 0xCF5E, 0x4A76, [0xBF, 0x59, 0xEA, 0xD3, 0x9E, 0xA2, 0xB9, 0x7E]};
@GUID(0xD92995F8, 0xCF5E, 0x4A76, [0xBF, 0x59, 0xEA, 0xD3, 0x9E, 0xA2, 0xB9, 0x7E]);
interface INamespaceWalkCB : IUnknown
{
    HRESULT FoundItem(IShellFolder psf, ITEMIDLIST* pidl);
    HRESULT EnterFolder(IShellFolder psf, ITEMIDLIST* pidl);
    HRESULT LeaveFolder(IShellFolder psf, ITEMIDLIST* pidl);
    HRESULT InitializeProgressDialog(ushort** ppszTitle, ushort** ppszCancel);
}

const GUID IID_INamespaceWalkCB2 = {0x7AC7492B, 0xC38E, 0x438A, [0x87, 0xDB, 0x68, 0x73, 0x78, 0x44, 0xFF, 0x70]};
@GUID(0x7AC7492B, 0xC38E, 0x438A, [0x87, 0xDB, 0x68, 0x73, 0x78, 0x44, 0xFF, 0x70]);
interface INamespaceWalkCB2 : INamespaceWalkCB
{
    HRESULT WalkComplete(HRESULT hr);
}

enum NAMESPACEWALKFLAG
{
    NSWF_DEFAULT = 0,
    NSWF_NONE_IMPLIES_ALL = 1,
    NSWF_ONE_IMPLIES_ALL = 2,
    NSWF_DONT_TRAVERSE_LINKS = 4,
    NSWF_DONT_ACCUMULATE_RESULT = 8,
    NSWF_TRAVERSE_STREAM_JUNCTIONS = 16,
    NSWF_FILESYSTEM_ONLY = 32,
    NSWF_SHOW_PROGRESS = 64,
    NSWF_FLAG_VIEWORDER = 128,
    NSWF_IGNORE_AUTOPLAY_HIDA = 256,
    NSWF_ASYNC = 512,
    NSWF_DONT_RESOLVE_LINKS = 1024,
    NSWF_ACCUMULATE_FOLDERS = 2048,
    NSWF_DONT_SORT = 4096,
    NSWF_USE_TRANSFER_MEDIUM = 8192,
    NSWF_DONT_TRAVERSE_STREAM_JUNCTIONS = 16384,
    NSWF_ANY_IMPLIES_ALL = 32768,
}

const GUID IID_INamespaceWalk = {0x57CED8A7, 0x3F4A, 0x432C, [0x93, 0x50, 0x30, 0xF2, 0x44, 0x83, 0xF7, 0x4F]};
@GUID(0x57CED8A7, 0x3F4A, 0x432C, [0x93, 0x50, 0x30, 0xF2, 0x44, 0x83, 0xF7, 0x4F]);
interface INamespaceWalk : IUnknown
{
    HRESULT Walk(IUnknown punkToWalk, uint dwFlags, int cDepth, INamespaceWalkCB pnswcb);
    HRESULT GetIDArrayResult(uint* pcItems, char* prgpidl);
}

struct BANDSITEINFO
{
    uint dwMask;
    uint dwState;
    uint dwStyle;
}

enum tagBANDSITECID
{
    BSID_BANDADDED = 0,
    BSID_BANDREMOVED = 1,
}

const GUID IID_IBandSite = {0x4CF504B0, 0xDE96, 0x11D0, [0x8B, 0x3F, 0x00, 0xA0, 0xC9, 0x11, 0xE8, 0xE5]};
@GUID(0x4CF504B0, 0xDE96, 0x11D0, [0x8B, 0x3F, 0x00, 0xA0, 0xC9, 0x11, 0xE8, 0xE5]);
interface IBandSite : IUnknown
{
    HRESULT AddBand(IUnknown punk);
    HRESULT EnumBands(uint uBand, uint* pdwBandID);
    HRESULT QueryBand(uint dwBandID, IDeskBand* ppstb, uint* pdwState, const(wchar)* pszName, int cchName);
    HRESULT SetBandState(uint dwBandID, uint dwMask, uint dwState);
    HRESULT RemoveBand(uint dwBandID);
    HRESULT GetBandObject(uint dwBandID, const(Guid)* riid, void** ppv);
    HRESULT SetBandSiteInfo(const(BANDSITEINFO)* pbsinfo);
    HRESULT GetBandSiteInfo(BANDSITEINFO* pbsinfo);
}

const GUID IID_IModalWindow = {0xB4DB1657, 0x70D7, 0x485E, [0x8E, 0x3E, 0x6F, 0xCB, 0x5A, 0x5C, 0x18, 0x02]};
@GUID(0xB4DB1657, 0x70D7, 0x485E, [0x8E, 0x3E, 0x6F, 0xCB, 0x5A, 0x5C, 0x18, 0x02]);
interface IModalWindow : IUnknown
{
    HRESULT Show(HWND hwndOwner);
}

const GUID IID_IContextMenuSite = {0x0811AEBE, 0x0B87, 0x4C54, [0x9E, 0x72, 0x54, 0x8C, 0xF6, 0x49, 0x01, 0x6B]};
@GUID(0x0811AEBE, 0x0B87, 0x4C54, [0x9E, 0x72, 0x54, 0x8C, 0xF6, 0x49, 0x01, 0x6B]);
interface IContextMenuSite : IUnknown
{
    HRESULT DoContextMenuPopup(IUnknown punkContextMenu, uint fFlags, POINT pt);
}

enum tagMENUBANDHANDLERCID
{
    MBHANDCID_PIDLSELECT = 0,
}

const GUID IID_IMenuBand = {0x568804CD, 0xCBD7, 0x11D0, [0x98, 0x16, 0x00, 0xC0, 0x4F, 0xD9, 0x19, 0x72]};
@GUID(0x568804CD, 0xCBD7, 0x11D0, [0x98, 0x16, 0x00, 0xC0, 0x4F, 0xD9, 0x19, 0x72]);
interface IMenuBand : IUnknown
{
    HRESULT IsMenuMessage(MSG* pmsg);
    HRESULT TranslateMenuMessage(MSG* pmsg, LRESULT* plRet);
}

const GUID IID_IRegTreeItem = {0xA9521922, 0x0812, 0x4D44, [0x9E, 0xC3, 0x7F, 0xD3, 0x8C, 0x72, 0x6F, 0x3D]};
@GUID(0xA9521922, 0x0812, 0x4D44, [0x9E, 0xC3, 0x7F, 0xD3, 0x8C, 0x72, 0x6F, 0x3D]);
interface IRegTreeItem : IUnknown
{
    HRESULT GetCheckState(int* pbCheck);
    HRESULT SetCheckState(BOOL bCheck);
}

const GUID IID_IDeskBar = {0xEB0FE173, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]};
@GUID(0xEB0FE173, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]);
interface IDeskBar : IOleWindow
{
    HRESULT SetClient(IUnknown punkClient);
    HRESULT GetClient(IUnknown* ppunkClient);
    HRESULT OnPosRectChangeDB(RECT* prc);
}

enum tagMENUPOPUPSELECT
{
    MPOS_EXECUTE = 0,
    MPOS_FULLCANCEL = 1,
    MPOS_CANCELLEVEL = 2,
    MPOS_SELECTLEFT = 3,
    MPOS_SELECTRIGHT = 4,
    MPOS_CHILDTRACKING = 5,
}

enum tagMENUPOPUPPOPUPFLAGS
{
    MPPF_SETFOCUS = 1,
    MPPF_INITIALSELECT = 2,
    MPPF_NOANIMATE = 4,
    MPPF_KEYBOARD = 16,
    MPPF_REPOSITION = 32,
    MPPF_FORCEZORDER = 64,
    MPPF_FINALSELECT = 128,
    MPPF_TOP = 536870912,
    MPPF_LEFT = 1073741824,
    MPPF_RIGHT = 1610612736,
    MPPF_BOTTOM = -2147483648,
    MPPF_POS_MASK = -536870912,
    MPPF_ALIGN_LEFT = 33554432,
    MPPF_ALIGN_RIGHT = 67108864,
}

const GUID IID_IMenuPopup = {0xD1E7AFEB, 0x6A2E, 0x11D0, [0x8C, 0x78, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xB4]};
@GUID(0xD1E7AFEB, 0x6A2E, 0x11D0, [0x8C, 0x78, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xB4]);
interface IMenuPopup : IDeskBar
{
    HRESULT Popup(POINTL* ppt, RECTL* prcExclude, int dwFlags);
    HRESULT OnSelect(uint dwSelectType);
    HRESULT SetSubMenu(IMenuPopup pmp, BOOL fSet);
}

enum FILE_USAGE_TYPE
{
    FUT_PLAYING = 0,
    FUT_EDITING = 1,
    FUT_GENERIC = 2,
}

const GUID IID_IFileIsInUse = {0x64A1CBF0, 0x3A1A, 0x4461, [0x91, 0x58, 0x37, 0x69, 0x69, 0x69, 0x39, 0x50]};
@GUID(0x64A1CBF0, 0x3A1A, 0x4461, [0x91, 0x58, 0x37, 0x69, 0x69, 0x69, 0x39, 0x50]);
interface IFileIsInUse : IUnknown
{
    HRESULT GetAppName(ushort** ppszName);
    HRESULT GetUsage(FILE_USAGE_TYPE* pfut);
    HRESULT GetCapabilities(uint* pdwCapFlags);
    HRESULT GetSwitchToHWND(HWND* phwnd);
    HRESULT CloseFile();
}

enum FDE_OVERWRITE_RESPONSE
{
    FDEOR_DEFAULT = 0,
    FDEOR_ACCEPT = 1,
    FDEOR_REFUSE = 2,
}

enum FDE_SHAREVIOLATION_RESPONSE
{
    FDESVR_DEFAULT = 0,
    FDESVR_ACCEPT = 1,
    FDESVR_REFUSE = 2,
}

enum FDAP
{
    FDAP_BOTTOM = 0,
    FDAP_TOP = 1,
}

const GUID IID_IFileDialogEvents = {0x973510DB, 0x7D7F, 0x452B, [0x89, 0x75, 0x74, 0xA8, 0x58, 0x28, 0xD3, 0x54]};
@GUID(0x973510DB, 0x7D7F, 0x452B, [0x89, 0x75, 0x74, 0xA8, 0x58, 0x28, 0xD3, 0x54]);
interface IFileDialogEvents : IUnknown
{
    HRESULT OnFileOk(IFileDialog pfd);
    HRESULT OnFolderChanging(IFileDialog pfd, IShellItem psiFolder);
    HRESULT OnFolderChange(IFileDialog pfd);
    HRESULT OnSelectionChange(IFileDialog pfd);
    HRESULT OnShareViolation(IFileDialog pfd, IShellItem psi, FDE_SHAREVIOLATION_RESPONSE* pResponse);
    HRESULT OnTypeChange(IFileDialog pfd);
    HRESULT OnOverwrite(IFileDialog pfd, IShellItem psi, FDE_OVERWRITE_RESPONSE* pResponse);
}

enum _FILEOPENDIALOGOPTIONS
{
    FOS_OVERWRITEPROMPT = 2,
    FOS_STRICTFILETYPES = 4,
    FOS_NOCHANGEDIR = 8,
    FOS_PICKFOLDERS = 32,
    FOS_FORCEFILESYSTEM = 64,
    FOS_ALLNONSTORAGEITEMS = 128,
    FOS_NOVALIDATE = 256,
    FOS_ALLOWMULTISELECT = 512,
    FOS_PATHMUSTEXIST = 2048,
    FOS_FILEMUSTEXIST = 4096,
    FOS_CREATEPROMPT = 8192,
    FOS_SHAREAWARE = 16384,
    FOS_NOREADONLYRETURN = 32768,
    FOS_NOTESTFILECREATE = 65536,
    FOS_HIDEMRUPLACES = 131072,
    FOS_HIDEPINNEDPLACES = 262144,
    FOS_NODEREFERENCELINKS = 1048576,
    FOS_OKBUTTONNEEDSINTERACTION = 2097152,
    FOS_DONTADDTORECENT = 33554432,
    FOS_FORCESHOWHIDDEN = 268435456,
    FOS_DEFAULTNOMINIMODE = 536870912,
    FOS_FORCEPREVIEWPANEON = 1073741824,
    FOS_SUPPORTSTREAMABLEITEMS = -2147483648,
}

const GUID IID_IFileDialog = {0x42F85136, 0xDB7E, 0x439C, [0x85, 0xF1, 0xE4, 0x07, 0x5D, 0x13, 0x5F, 0xC8]};
@GUID(0x42F85136, 0xDB7E, 0x439C, [0x85, 0xF1, 0xE4, 0x07, 0x5D, 0x13, 0x5F, 0xC8]);
interface IFileDialog : IModalWindow
{
    HRESULT SetFileTypes(uint cFileTypes, char* rgFilterSpec);
    HRESULT SetFileTypeIndex(uint iFileType);
    HRESULT GetFileTypeIndex(uint* piFileType);
    HRESULT Advise(IFileDialogEvents pfde, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT SetOptions(uint fos);
    HRESULT GetOptions(uint* pfos);
    HRESULT SetDefaultFolder(IShellItem psi);
    HRESULT SetFolder(IShellItem psi);
    HRESULT GetFolder(IShellItem* ppsi);
    HRESULT GetCurrentSelection(IShellItem* ppsi);
    HRESULT SetFileName(const(wchar)* pszName);
    HRESULT GetFileName(ushort** pszName);
    HRESULT SetTitle(const(wchar)* pszTitle);
    HRESULT SetOkButtonLabel(const(wchar)* pszText);
    HRESULT SetFileNameLabel(const(wchar)* pszLabel);
    HRESULT GetResult(IShellItem* ppsi);
    HRESULT AddPlace(IShellItem psi, FDAP fdap);
    HRESULT SetDefaultExtension(const(wchar)* pszDefaultExtension);
    HRESULT Close(HRESULT hr);
    HRESULT SetClientGuid(const(Guid)* guid);
    HRESULT ClearClientData();
    HRESULT SetFilter(IShellItemFilter pFilter);
}

const GUID IID_IFileSaveDialog = {0x84BCCD23, 0x5FDE, 0x4CDB, [0xAE, 0xA4, 0xAF, 0x64, 0xB8, 0x3D, 0x78, 0xAB]};
@GUID(0x84BCCD23, 0x5FDE, 0x4CDB, [0xAE, 0xA4, 0xAF, 0x64, 0xB8, 0x3D, 0x78, 0xAB]);
interface IFileSaveDialog : IFileDialog
{
    HRESULT SetSaveAsItem(IShellItem psi);
    HRESULT SetProperties(IPropertyStore pStore);
    HRESULT SetCollectedProperties(IPropertyDescriptionList pList, BOOL fAppendDefault);
    HRESULT GetProperties(IPropertyStore* ppStore);
    HRESULT ApplyProperties(IShellItem psi, IPropertyStore pStore, HWND hwnd, IFileOperationProgressSink pSink);
}

const GUID IID_IFileOpenDialog = {0xD57C7288, 0xD4AD, 0x4768, [0xBE, 0x02, 0x9D, 0x96, 0x95, 0x32, 0xD9, 0x60]};
@GUID(0xD57C7288, 0xD4AD, 0x4768, [0xBE, 0x02, 0x9D, 0x96, 0x95, 0x32, 0xD9, 0x60]);
interface IFileOpenDialog : IFileDialog
{
    HRESULT GetResults(IShellItemArray* ppenum);
    HRESULT GetSelectedItems(IShellItemArray* ppsai);
}

enum CDCONTROLSTATEF
{
    CDCS_INACTIVE = 0,
    CDCS_ENABLED = 1,
    CDCS_VISIBLE = 2,
    CDCS_ENABLEDVISIBLE = 3,
}

const GUID IID_IFileDialogCustomize = {0xE6FDD21A, 0x163F, 0x4975, [0x9C, 0x8C, 0xA6, 0x9F, 0x1B, 0xA3, 0x70, 0x34]};
@GUID(0xE6FDD21A, 0x163F, 0x4975, [0x9C, 0x8C, 0xA6, 0x9F, 0x1B, 0xA3, 0x70, 0x34]);
interface IFileDialogCustomize : IUnknown
{
    HRESULT EnableOpenDropDown(uint dwIDCtl);
    HRESULT AddMenu(uint dwIDCtl, const(wchar)* pszLabel);
    HRESULT AddPushButton(uint dwIDCtl, const(wchar)* pszLabel);
    HRESULT AddComboBox(uint dwIDCtl);
    HRESULT AddRadioButtonList(uint dwIDCtl);
    HRESULT AddCheckButton(uint dwIDCtl, const(wchar)* pszLabel, BOOL bChecked);
    HRESULT AddEditBox(uint dwIDCtl, const(wchar)* pszText);
    HRESULT AddSeparator(uint dwIDCtl);
    HRESULT AddText(uint dwIDCtl, const(wchar)* pszText);
    HRESULT SetControlLabel(uint dwIDCtl, const(wchar)* pszLabel);
    HRESULT GetControlState(uint dwIDCtl, CDCONTROLSTATEF* pdwState);
    HRESULT SetControlState(uint dwIDCtl, CDCONTROLSTATEF dwState);
    HRESULT GetEditBoxText(uint dwIDCtl, ushort** ppszText);
    HRESULT SetEditBoxText(uint dwIDCtl, const(wchar)* pszText);
    HRESULT GetCheckButtonState(uint dwIDCtl, int* pbChecked);
    HRESULT SetCheckButtonState(uint dwIDCtl, BOOL bChecked);
    HRESULT AddControlItem(uint dwIDCtl, uint dwIDItem, const(wchar)* pszLabel);
    HRESULT RemoveControlItem(uint dwIDCtl, uint dwIDItem);
    HRESULT RemoveAllControlItems(uint dwIDCtl);
    HRESULT GetControlItemState(uint dwIDCtl, uint dwIDItem, CDCONTROLSTATEF* pdwState);
    HRESULT SetControlItemState(uint dwIDCtl, uint dwIDItem, CDCONTROLSTATEF dwState);
    HRESULT GetSelectedControlItem(uint dwIDCtl, uint* pdwIDItem);
    HRESULT SetSelectedControlItem(uint dwIDCtl, uint dwIDItem);
    HRESULT StartVisualGroup(uint dwIDCtl, const(wchar)* pszLabel);
    HRESULT EndVisualGroup();
    HRESULT MakeProminent(uint dwIDCtl);
    HRESULT SetControlItemText(uint dwIDCtl, uint dwIDItem, const(wchar)* pszLabel);
}

enum ASSOCIATIONLEVEL
{
    AL_MACHINE = 0,
    AL_EFFECTIVE = 1,
    AL_USER = 2,
}

enum ASSOCIATIONTYPE
{
    AT_FILEEXTENSION = 0,
    AT_URLPROTOCOL = 1,
    AT_STARTMENUCLIENT = 2,
    AT_MIMETYPE = 3,
}

const GUID IID_IApplicationAssociationRegistration = {0x4E530B0A, 0xE611, 0x4C77, [0xA3, 0xAC, 0x90, 0x31, 0xD0, 0x22, 0x28, 0x1B]};
@GUID(0x4E530B0A, 0xE611, 0x4C77, [0xA3, 0xAC, 0x90, 0x31, 0xD0, 0x22, 0x28, 0x1B]);
interface IApplicationAssociationRegistration : IUnknown
{
    HRESULT QueryCurrentDefault(const(wchar)* pszQuery, ASSOCIATIONTYPE atQueryType, ASSOCIATIONLEVEL alQueryLevel, ushort** ppszAssociation);
    HRESULT QueryAppIsDefault(const(wchar)* pszQuery, ASSOCIATIONTYPE atQueryType, ASSOCIATIONLEVEL alQueryLevel, const(wchar)* pszAppRegistryName, int* pfDefault);
    HRESULT QueryAppIsDefaultAll(ASSOCIATIONLEVEL alQueryLevel, const(wchar)* pszAppRegistryName, int* pfDefault);
    HRESULT SetAppAsDefault(const(wchar)* pszAppRegistryName, const(wchar)* pszSet, ASSOCIATIONTYPE atSetType);
    HRESULT SetAppAsDefaultAll(const(wchar)* pszAppRegistryName);
    HRESULT ClearUserAssociations();
}

struct DELEGATEITEMID
{
    ushort cbSize;
    ushort wOuter;
    ushort cbInner;
    ubyte rgb;
}

const GUID IID_IDelegateFolder = {0xADD8BA80, 0x002B, 0x11D0, [0x8F, 0x0F, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]};
@GUID(0xADD8BA80, 0x002B, 0x11D0, [0x8F, 0x0F, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]);
interface IDelegateFolder : IUnknown
{
    HRESULT SetItemAlloc(IMalloc pmalloc);
}

enum _BROWSERFRAMEOPTIONS
{
    BFO_NONE = 0,
    BFO_BROWSER_PERSIST_SETTINGS = 1,
    BFO_RENAME_FOLDER_OPTIONS_TOINTERNET = 2,
    BFO_BOTH_OPTIONS = 4,
    BIF_PREFER_INTERNET_SHORTCUT = 8,
    BFO_BROWSE_NO_IN_NEW_PROCESS = 16,
    BFO_ENABLE_HYPERLINK_TRACKING = 32,
    BFO_USE_IE_OFFLINE_SUPPORT = 64,
    BFO_SUBSTITUE_INTERNET_START_PAGE = 128,
    BFO_USE_IE_LOGOBANDING = 256,
    BFO_ADD_IE_TOCAPTIONBAR = 512,
    BFO_USE_DIALUP_REF = 1024,
    BFO_USE_IE_TOOLBAR = 2048,
    BFO_NO_PARENT_FOLDER_SUPPORT = 4096,
    BFO_NO_REOPEN_NEXT_RESTART = 8192,
    BFO_GO_HOME_PAGE = 16384,
    BFO_PREFER_IEPROCESS = 32768,
    BFO_SHOW_NAVIGATION_CANCELLED = 65536,
    BFO_USE_IE_STATUSBAR = 131072,
    BFO_QUERY_ALL = -1,
}

const GUID IID_IBrowserFrameOptions = {0x10DF43C8, 0x1DBE, 0x11D3, [0x8B, 0x34, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]};
@GUID(0x10DF43C8, 0x1DBE, 0x11D3, [0x8B, 0x34, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]);
interface IBrowserFrameOptions : IUnknown
{
    HRESULT GetFrameOptions(uint dwMask, uint* pdwOptions);
}

enum NWMF
{
    NWMF_UNLOADING = 1,
    NWMF_USERINITED = 2,
    NWMF_FIRST = 4,
    NWMF_OVERRIDEKEY = 8,
    NWMF_SHOWHELP = 16,
    NWMF_HTMLDIALOG = 32,
    NWMF_FROMDIALOGCHILD = 64,
    NWMF_USERREQUESTED = 128,
    NWMF_USERALLOWED = 256,
    NWMF_FORCEWINDOW = 65536,
    NWMF_FORCETAB = 131072,
    NWMF_SUGGESTWINDOW = 262144,
    NWMF_SUGGESTTAB = 524288,
    NWMF_INACTIVETAB = 1048576,
}

const GUID IID_INewWindowManager = {0xD2BC4C84, 0x3F72, 0x4A52, [0xA6, 0x04, 0x7B, 0xCB, 0xF3, 0x98, 0x2C, 0xBB]};
@GUID(0xD2BC4C84, 0x3F72, 0x4A52, [0xA6, 0x04, 0x7B, 0xCB, 0xF3, 0x98, 0x2C, 0xBB]);
interface INewWindowManager : IUnknown
{
    HRESULT EvaluateNewWindow(const(wchar)* pszUrl, const(wchar)* pszName, const(wchar)* pszUrlContext, const(wchar)* pszFeatures, BOOL fReplace, uint dwFlags, uint dwUserActionTime);
}

enum ATTACHMENT_PROMPT
{
    ATTACHMENT_PROMPT_NONE = 0,
    ATTACHMENT_PROMPT_SAVE = 1,
    ATTACHMENT_PROMPT_EXEC = 2,
    ATTACHMENT_PROMPT_EXEC_OR_SAVE = 3,
}

enum ATTACHMENT_ACTION
{
    ATTACHMENT_ACTION_CANCEL = 0,
    ATTACHMENT_ACTION_SAVE = 1,
    ATTACHMENT_ACTION_EXEC = 2,
}

const GUID IID_IAttachmentExecute = {0x73DB1241, 0x1E85, 0x4581, [0x8E, 0x4F, 0xA8, 0x1E, 0x1D, 0x0F, 0x8C, 0x57]};
@GUID(0x73DB1241, 0x1E85, 0x4581, [0x8E, 0x4F, 0xA8, 0x1E, 0x1D, 0x0F, 0x8C, 0x57]);
interface IAttachmentExecute : IUnknown
{
    HRESULT SetClientTitle(const(wchar)* pszTitle);
    HRESULT SetClientGuid(const(Guid)* guid);
    HRESULT SetLocalPath(const(wchar)* pszLocalPath);
    HRESULT SetFileName(const(wchar)* pszFileName);
    HRESULT SetSource(const(wchar)* pszSource);
    HRESULT SetReferrer(const(wchar)* pszReferrer);
    HRESULT CheckPolicy();
    HRESULT Prompt(HWND hwnd, ATTACHMENT_PROMPT prompt, ATTACHMENT_ACTION* paction);
    HRESULT Save();
    HRESULT Execute(HWND hwnd, const(wchar)* pszVerb, HANDLE* phProcess);
    HRESULT SaveWithUI(HWND hwnd);
    HRESULT ClearClientState();
}

struct SMDATA
{
    uint dwMask;
    uint dwFlags;
    HMENU hmenu;
    HWND hwnd;
    uint uId;
    uint uIdParent;
    uint uIdAncestor;
    IUnknown punk;
    ITEMIDLIST* pidlFolder;
    ITEMIDLIST* pidlItem;
    IShellFolder psf;
    void* pvUserData;
}

struct SMINFO
{
    uint dwMask;
    uint dwType;
    uint dwFlags;
    int iIcon;
}

struct SMCSHCHANGENOTIFYSTRUCT
{
    int lEvent;
    ITEMIDLIST* pidl1;
    ITEMIDLIST* pidl2;
}

enum tagSMINFOMASK
{
    SMIM_TYPE = 1,
    SMIM_FLAGS = 2,
    SMIM_ICON = 4,
}

enum tagSMINFOTYPE
{
    SMIT_SEPARATOR = 1,
    SMIT_STRING = 2,
}

enum tagSMINFOFLAGS
{
    SMIF_ICON = 1,
    SMIF_ACCELERATOR = 2,
    SMIF_DROPTARGET = 4,
    SMIF_SUBMENU = 8,
    SMIF_CHECKED = 32,
    SMIF_DROPCASCADE = 64,
    SMIF_HIDDEN = 128,
    SMIF_DISABLED = 256,
    SMIF_TRACKPOPUP = 512,
    SMIF_DEMOTED = 1024,
    SMIF_ALTSTATE = 2048,
    SMIF_DRAGNDROP = 4096,
    SMIF_NEW = 8192,
}

const GUID IID_IShellMenuCallback = {0x4CA300A1, 0x9B8D, 0x11D1, [0x8B, 0x22, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0x4CA300A1, 0x9B8D, 0x11D1, [0x8B, 0x22, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
interface IShellMenuCallback : IUnknown
{
    HRESULT CallbackSM(SMDATA* psmd, uint uMsg, WPARAM wParam, LPARAM lParam);
}

const GUID IID_IShellMenu = {0xEE1F7637, 0xE138, 0x11D1, [0x83, 0x79, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0xEE1F7637, 0xE138, 0x11D1, [0x83, 0x79, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
interface IShellMenu : IUnknown
{
    HRESULT Initialize(IShellMenuCallback psmc, uint uId, uint uIdAncestor, uint dwFlags);
    HRESULT GetMenuInfo(IShellMenuCallback* ppsmc, uint* puId, uint* puIdAncestor, uint* pdwFlags);
    HRESULT SetShellFolder(IShellFolder psf, ITEMIDLIST* pidlFolder, HKEY hKey, uint dwFlags);
    HRESULT GetShellFolder(uint* pdwFlags, ITEMIDLIST** ppidl, const(Guid)* riid, void** ppv);
    HRESULT SetMenu(HMENU hmenu, HWND hwnd, uint dwFlags);
    HRESULT GetMenu(HMENU* phmenu, HWND* phwnd, uint* pdwFlags);
    HRESULT InvalidateItem(SMDATA* psmd, uint dwFlags);
    HRESULT GetState(SMDATA* psmd);
    HRESULT SetMenuToolbar(IUnknown punk, uint dwFlags);
}

enum KF_CATEGORY
{
    KF_CATEGORY_VIRTUAL = 1,
    KF_CATEGORY_FIXED = 2,
    KF_CATEGORY_COMMON = 3,
    KF_CATEGORY_PERUSER = 4,
}

enum _KF_DEFINITION_FLAGS
{
    KFDF_LOCAL_REDIRECT_ONLY = 2,
    KFDF_ROAMABLE = 4,
    KFDF_PRECREATE = 8,
    KFDF_STREAM = 16,
    KFDF_PUBLISHEXPANDEDPATH = 32,
    KFDF_NO_REDIRECT_UI = 64,
}

enum _KF_REDIRECT_FLAGS
{
    KF_REDIRECT_USER_EXCLUSIVE = 1,
    KF_REDIRECT_COPY_SOURCE_DACL = 2,
    KF_REDIRECT_OWNER_USER = 4,
    KF_REDIRECT_SET_OWNER_EXPLICIT = 8,
    KF_REDIRECT_CHECK_ONLY = 16,
    KF_REDIRECT_WITH_UI = 32,
    KF_REDIRECT_UNPIN = 64,
    KF_REDIRECT_PIN = 128,
    KF_REDIRECT_COPY_CONTENTS = 512,
    KF_REDIRECT_DEL_SOURCE_CONTENTS = 1024,
    KF_REDIRECT_EXCLUDE_ALL_KNOWN_SUBFOLDERS = 2048,
}

enum _KF_REDIRECTION_CAPABILITIES
{
    KF_REDIRECTION_CAPABILITIES_ALLOW_ALL = 255,
    KF_REDIRECTION_CAPABILITIES_REDIRECTABLE = 1,
    KF_REDIRECTION_CAPABILITIES_DENY_ALL = 1048320,
    KF_REDIRECTION_CAPABILITIES_DENY_POLICY_REDIRECTED = 256,
    KF_REDIRECTION_CAPABILITIES_DENY_POLICY = 512,
    KF_REDIRECTION_CAPABILITIES_DENY_PERMISSIONS = 1024,
}

struct KNOWNFOLDER_DEFINITION
{
    KF_CATEGORY category;
    const(wchar)* pszName;
    const(wchar)* pszDescription;
    Guid fidParent;
    const(wchar)* pszRelativePath;
    const(wchar)* pszParsingName;
    const(wchar)* pszTooltip;
    const(wchar)* pszLocalizedName;
    const(wchar)* pszIcon;
    const(wchar)* pszSecurity;
    uint dwAttributes;
    uint kfdFlags;
    Guid ftidType;
}

const GUID IID_IKnownFolder = {0x3AA7AF7E, 0x9B36, 0x420C, [0xA8, 0xE3, 0xF7, 0x7D, 0x46, 0x74, 0xA4, 0x88]};
@GUID(0x3AA7AF7E, 0x9B36, 0x420C, [0xA8, 0xE3, 0xF7, 0x7D, 0x46, 0x74, 0xA4, 0x88]);
interface IKnownFolder : IUnknown
{
    HRESULT GetId(Guid* pkfid);
    HRESULT GetCategory(KF_CATEGORY* pCategory);
    HRESULT GetShellItem(uint dwFlags, const(Guid)* riid, void** ppv);
    HRESULT GetPath(uint dwFlags, ushort** ppszPath);
    HRESULT SetPath(uint dwFlags, const(wchar)* pszPath);
    HRESULT GetIDList(uint dwFlags, ITEMIDLIST** ppidl);
    HRESULT GetFolderType(Guid* pftid);
    HRESULT GetRedirectionCapabilities(uint* pCapabilities);
    HRESULT GetFolderDefinition(KNOWNFOLDER_DEFINITION* pKFD);
}

enum FFFP_MODE
{
    FFFP_EXACTMATCH = 0,
    FFFP_NEARESTPARENTMATCH = 1,
}

const GUID IID_IKnownFolderManager = {0x8BE2D872, 0x86AA, 0x4D47, [0xB7, 0x76, 0x32, 0xCC, 0xA4, 0x0C, 0x70, 0x18]};
@GUID(0x8BE2D872, 0x86AA, 0x4D47, [0xB7, 0x76, 0x32, 0xCC, 0xA4, 0x0C, 0x70, 0x18]);
interface IKnownFolderManager : IUnknown
{
    HRESULT FolderIdFromCsidl(int nCsidl, Guid* pfid);
    HRESULT FolderIdToCsidl(const(Guid)* rfid, int* pnCsidl);
    HRESULT GetFolderIds(char* ppKFId, uint* pCount);
    HRESULT GetFolder(const(Guid)* rfid, IKnownFolder* ppkf);
    HRESULT GetFolderByName(const(wchar)* pszCanonicalName, IKnownFolder* ppkf);
    HRESULT RegisterFolder(const(Guid)* rfid, const(KNOWNFOLDER_DEFINITION)* pKFD);
    HRESULT UnregisterFolder(const(Guid)* rfid);
    HRESULT FindFolderFromPath(const(wchar)* pszPath, FFFP_MODE mode, IKnownFolder* ppkf);
    HRESULT FindFolderFromIDList(ITEMIDLIST* pidl, IKnownFolder* ppkf);
    HRESULT Redirect(const(Guid)* rfid, HWND hwnd, uint flags, const(wchar)* pszTargetPath, uint cFolders, char* pExclusion, ushort** ppszError);
}

enum SHARE_ROLE
{
    SHARE_ROLE_INVALID = -1,
    SHARE_ROLE_READER = 0,
    SHARE_ROLE_CONTRIBUTOR = 1,
    SHARE_ROLE_CO_OWNER = 2,
    SHARE_ROLE_OWNER = 3,
    SHARE_ROLE_CUSTOM = 4,
    SHARE_ROLE_MIXED = 5,
}

enum DEF_SHARE_ID
{
    DEFSHAREID_USERS = 1,
    DEFSHAREID_PUBLIC = 2,
}

const GUID IID_ISharingConfigurationManager = {0xB4CD448A, 0x9C86, 0x4466, [0x92, 0x01, 0x2E, 0x62, 0x10, 0x5B, 0x87, 0xAE]};
@GUID(0xB4CD448A, 0x9C86, 0x4466, [0x92, 0x01, 0x2E, 0x62, 0x10, 0x5B, 0x87, 0xAE]);
interface ISharingConfigurationManager : IUnknown
{
    HRESULT CreateShare(DEF_SHARE_ID dsid, SHARE_ROLE role);
    HRESULT DeleteShare(DEF_SHARE_ID dsid);
    HRESULT ShareExists(DEF_SHARE_ID dsid);
    HRESULT GetSharePermissions(DEF_SHARE_ID dsid, SHARE_ROLE* pRole);
    HRESULT SharePrinters();
    HRESULT StopSharingPrinters();
    HRESULT ArePrintersShared();
}

const GUID IID_IRelatedItem = {0xA73CE67A, 0x8AB1, 0x44F1, [0x8D, 0x43, 0xD2, 0xFC, 0xBF, 0x6B, 0x1C, 0xD0]};
@GUID(0xA73CE67A, 0x8AB1, 0x44F1, [0x8D, 0x43, 0xD2, 0xFC, 0xBF, 0x6B, 0x1C, 0xD0]);
interface IRelatedItem : IUnknown
{
    HRESULT GetItemIDList(ITEMIDLIST** ppidl);
    HRESULT GetItem(IShellItem* ppsi);
}

const GUID IID_IIdentityName = {0x7D903FCA, 0xD6F9, 0x4810, [0x83, 0x32, 0x94, 0x6C, 0x01, 0x77, 0xE2, 0x47]};
@GUID(0x7D903FCA, 0xD6F9, 0x4810, [0x83, 0x32, 0x94, 0x6C, 0x01, 0x77, 0xE2, 0x47]);
interface IIdentityName : IRelatedItem
{
}

const GUID IID_IDelegateItem = {0x3C5A1C94, 0xC951, 0x4CB7, [0xBB, 0x6D, 0x3B, 0x93, 0xF3, 0x0C, 0xCE, 0x93]};
@GUID(0x3C5A1C94, 0xC951, 0x4CB7, [0xBB, 0x6D, 0x3B, 0x93, 0xF3, 0x0C, 0xCE, 0x93]);
interface IDelegateItem : IRelatedItem
{
}

const GUID IID_ICurrentItem = {0x240A7174, 0xD653, 0x4A1D, [0xA6, 0xD3, 0xD4, 0x94, 0x3C, 0xFB, 0xFE, 0x3D]};
@GUID(0x240A7174, 0xD653, 0x4A1D, [0xA6, 0xD3, 0xD4, 0x94, 0x3C, 0xFB, 0xFE, 0x3D]);
interface ICurrentItem : IRelatedItem
{
}

const GUID IID_ITransferMediumItem = {0x77F295D5, 0x2D6F, 0x4E19, [0xB8, 0xAE, 0x32, 0x2F, 0x3E, 0x72, 0x1A, 0xB5]};
@GUID(0x77F295D5, 0x2D6F, 0x4E19, [0xB8, 0xAE, 0x32, 0x2F, 0x3E, 0x72, 0x1A, 0xB5]);
interface ITransferMediumItem : IRelatedItem
{
}

const GUID IID_IDisplayItem = {0xC6FD5997, 0x9F6B, 0x4888, [0x87, 0x03, 0x94, 0xE8, 0x0E, 0x8C, 0xDE, 0x3F]};
@GUID(0xC6FD5997, 0x9F6B, 0x4888, [0x87, 0x03, 0x94, 0xE8, 0x0E, 0x8C, 0xDE, 0x3F]);
interface IDisplayItem : IRelatedItem
{
}

const GUID IID_IViewStateIdentityItem = {0x9D264146, 0xA94F, 0x4195, [0x9F, 0x9F, 0x3B, 0xB1, 0x2C, 0xE0, 0xC9, 0x55]};
@GUID(0x9D264146, 0xA94F, 0x4195, [0x9F, 0x9F, 0x3B, 0xB1, 0x2C, 0xE0, 0xC9, 0x55]);
interface IViewStateIdentityItem : IRelatedItem
{
}

const GUID IID_IPreviewItem = {0x36149969, 0x0A8F, 0x49C8, [0x8B, 0x00, 0x4A, 0xEC, 0xB2, 0x02, 0x22, 0xFB]};
@GUID(0x36149969, 0x0A8F, 0x49C8, [0x8B, 0x00, 0x4A, 0xEC, 0xB2, 0x02, 0x22, 0xFB]);
interface IPreviewItem : IRelatedItem
{
}

const GUID IID_IDestinationStreamFactory = {0x8A87781B, 0x39A7, 0x4A1F, [0xAA, 0xB3, 0xA3, 0x9B, 0x9C, 0x34, 0xA7, 0xD9]};
@GUID(0x8A87781B, 0x39A7, 0x4A1F, [0xAA, 0xB3, 0xA3, 0x9B, 0x9C, 0x34, 0xA7, 0xD9]);
interface IDestinationStreamFactory : IUnknown
{
    HRESULT GetDestinationStream(IStream* ppstm);
}

const GUID IID_ICreateProcessInputs = {0xF6EF6140, 0xE26F, 0x4D82, [0xBA, 0xC4, 0xE9, 0xBA, 0x5F, 0xD2, 0x39, 0xA8]};
@GUID(0xF6EF6140, 0xE26F, 0x4D82, [0xBA, 0xC4, 0xE9, 0xBA, 0x5F, 0xD2, 0x39, 0xA8]);
interface ICreateProcessInputs : IUnknown
{
    HRESULT GetCreateFlags(uint* pdwCreationFlags);
    HRESULT SetCreateFlags(uint dwCreationFlags);
    HRESULT AddCreateFlags(uint dwCreationFlags);
    HRESULT SetHotKey(ushort wHotKey);
    HRESULT AddStartupFlags(uint dwStartupInfoFlags);
    HRESULT SetTitle(const(wchar)* pszTitle);
    HRESULT SetEnvironmentVariableA(const(wchar)* pszName, const(wchar)* pszValue);
}

const GUID IID_ICreatingProcess = {0xC2B937A9, 0x3110, 0x4398, [0x8A, 0x56, 0xF3, 0x4C, 0x63, 0x42, 0xD2, 0x44]};
@GUID(0xC2B937A9, 0x3110, 0x4398, [0x8A, 0x56, 0xF3, 0x4C, 0x63, 0x42, 0xD2, 0x44]);
interface ICreatingProcess : IUnknown
{
    HRESULT OnCreating(ICreateProcessInputs pcpi);
}

const GUID IID_ILaunchUIContext = {0x1791E8F6, 0x21C7, 0x4340, [0x88, 0x2A, 0xA6, 0xA9, 0x3E, 0x3F, 0xD7, 0x3B]};
@GUID(0x1791E8F6, 0x21C7, 0x4340, [0x88, 0x2A, 0xA6, 0xA9, 0x3E, 0x3F, 0xD7, 0x3B]);
interface ILaunchUIContext : IUnknown
{
    HRESULT SetAssociatedWindow(HWND value);
    HRESULT SetTabGroupingPreference(uint value);
}

const GUID IID_ILaunchUIContextProvider = {0x0D12C4C8, 0xA3D9, 0x4E24, [0x94, 0xC1, 0x0E, 0x20, 0xC5, 0xA9, 0x56, 0xC4]};
@GUID(0x0D12C4C8, 0xA3D9, 0x4E24, [0x94, 0xC1, 0x0E, 0x20, 0xC5, 0xA9, 0x56, 0xC4]);
interface ILaunchUIContextProvider : IUnknown
{
    HRESULT UpdateContext(ILaunchUIContext context);
}

enum _NMCII_FLAGS
{
    NMCII_NONE = 0,
    NMCII_ITEMS = 1,
    NMCII_FOLDERS = 2,
}

enum _NMCSAEI_FLAGS
{
    NMCSAEI_SELECT = 0,
    NMCSAEI_EDIT = 1,
}

const GUID IID_INewMenuClient = {0xDCB07FDC, 0x3BB5, 0x451C, [0x90, 0xBE, 0x96, 0x66, 0x44, 0xFE, 0xD7, 0xB0]};
@GUID(0xDCB07FDC, 0x3BB5, 0x451C, [0x90, 0xBE, 0x96, 0x66, 0x44, 0xFE, 0xD7, 0xB0]);
interface INewMenuClient : IUnknown
{
    HRESULT IncludeItems(int* pflags);
    HRESULT SelectAndEditItem(ITEMIDLIST* pidlItem, int flags);
}

const GUID IID_IInitializeWithBindCtx = {0x71C0D2BC, 0x726D, 0x45CC, [0xA6, 0xC0, 0x2E, 0x31, 0xC1, 0xDB, 0x21, 0x59]};
@GUID(0x71C0D2BC, 0x726D, 0x45CC, [0xA6, 0xC0, 0x2E, 0x31, 0xC1, 0xDB, 0x21, 0x59]);
interface IInitializeWithBindCtx : IUnknown
{
    HRESULT Initialize(IBindCtx pbc);
}

const GUID IID_IShellItemFilter = {0x2659B475, 0xEEB8, 0x48B7, [0x8F, 0x07, 0xB3, 0x78, 0x81, 0x0F, 0x48, 0xCF]};
@GUID(0x2659B475, 0xEEB8, 0x48B7, [0x8F, 0x07, 0xB3, 0x78, 0x81, 0x0F, 0x48, 0xCF]);
interface IShellItemFilter : IUnknown
{
    HRESULT IncludeItem(IShellItem psi);
    HRESULT GetEnumFlagsForItem(IShellItem psi, uint* pgrfFlags);
}

enum _NSTCSTYLE
{
    NSTCS_HASEXPANDOS = 1,
    NSTCS_HASLINES = 2,
    NSTCS_SINGLECLICKEXPAND = 4,
    NSTCS_FULLROWSELECT = 8,
    NSTCS_SPRINGEXPAND = 16,
    NSTCS_HORIZONTALSCROLL = 32,
    NSTCS_ROOTHASEXPANDO = 64,
    NSTCS_SHOWSELECTIONALWAYS = 128,
    NSTCS_NOINFOTIP = 512,
    NSTCS_EVENHEIGHT = 1024,
    NSTCS_NOREPLACEOPEN = 2048,
    NSTCS_DISABLEDRAGDROP = 4096,
    NSTCS_NOORDERSTREAM = 8192,
    NSTCS_RICHTOOLTIP = 16384,
    NSTCS_BORDER = 32768,
    NSTCS_NOEDITLABELS = 65536,
    NSTCS_TABSTOP = 131072,
    NSTCS_FAVORITESMODE = 524288,
    NSTCS_AUTOHSCROLL = 1048576,
    NSTCS_FADEINOUTEXPANDOS = 2097152,
    NSTCS_EMPTYTEXT = 4194304,
    NSTCS_CHECKBOXES = 8388608,
    NSTCS_PARTIALCHECKBOXES = 16777216,
    NSTCS_EXCLUSIONCHECKBOXES = 33554432,
    NSTCS_DIMMEDCHECKBOXES = 67108864,
    NSTCS_NOINDENTCHECKS = 134217728,
    NSTCS_ALLOWJUNCTIONS = 268435456,
    NSTCS_SHOWTABSBUTTON = 536870912,
    NSTCS_SHOWDELETEBUTTON = 1073741824,
    NSTCS_SHOWREFRESHBUTTON = -2147483648,
}

enum _NSTCROOTSTYLE
{
    NSTCRS_VISIBLE = 0,
    NSTCRS_HIDDEN = 1,
    NSTCRS_EXPANDED = 2,
}

enum _NSTCITEMSTATE
{
    NSTCIS_NONE = 0,
    NSTCIS_SELECTED = 1,
    NSTCIS_EXPANDED = 2,
    NSTCIS_BOLD = 4,
    NSTCIS_DISABLED = 8,
    NSTCIS_SELECTEDNOEXPAND = 16,
}

enum NSTCGNI
{
    NSTCGNI_NEXT = 0,
    NSTCGNI_NEXTVISIBLE = 1,
    NSTCGNI_PREV = 2,
    NSTCGNI_PREVVISIBLE = 3,
    NSTCGNI_PARENT = 4,
    NSTCGNI_CHILD = 5,
    NSTCGNI_FIRSTVISIBLE = 6,
    NSTCGNI_LASTVISIBLE = 7,
}

const GUID IID_INameSpaceTreeControl = {0x028212A3, 0xB627, 0x47E9, [0x88, 0x56, 0xC1, 0x42, 0x65, 0x55, 0x4E, 0x4F]};
@GUID(0x028212A3, 0xB627, 0x47E9, [0x88, 0x56, 0xC1, 0x42, 0x65, 0x55, 0x4E, 0x4F]);
interface INameSpaceTreeControl : IUnknown
{
    HRESULT Initialize(HWND hwndParent, RECT* prc, uint nsctsFlags);
    HRESULT TreeAdvise(IUnknown punk, uint* pdwCookie);
    HRESULT TreeUnadvise(uint dwCookie);
    HRESULT AppendRoot(IShellItem psiRoot, uint grfEnumFlags, uint grfRootStyle, IShellItemFilter pif);
    HRESULT InsertRoot(int iIndex, IShellItem psiRoot, uint grfEnumFlags, uint grfRootStyle, IShellItemFilter pif);
    HRESULT RemoveRoot(IShellItem psiRoot);
    HRESULT RemoveAllRoots();
    HRESULT GetRootItems(IShellItemArray* ppsiaRootItems);
    HRESULT SetItemState(IShellItem psi, uint nstcisMask, uint nstcisFlags);
    HRESULT GetItemState(IShellItem psi, uint nstcisMask, uint* pnstcisFlags);
    HRESULT GetSelectedItems(IShellItemArray* psiaItems);
    HRESULT GetItemCustomState(IShellItem psi, int* piStateNumber);
    HRESULT SetItemCustomState(IShellItem psi, int iStateNumber);
    HRESULT EnsureItemVisible(IShellItem psi);
    HRESULT SetTheme(const(wchar)* pszTheme);
    HRESULT GetNextItem(IShellItem psi, NSTCGNI nstcgi, IShellItem* ppsiNext);
    HRESULT HitTest(POINT* ppt, IShellItem* ppsiOut);
    HRESULT GetItemRect(IShellItem psi, RECT* prect);
    HRESULT CollapseAll();
}

enum NSTCFOLDERCAPABILITIES
{
    NSTCFC_NONE = 0,
    NSTCFC_PINNEDITEMFILTERING = 1,
    NSTCFC_DELAY_REGISTER_NOTIFY = 2,
}

const GUID IID_INameSpaceTreeControlFolderCapabilities = {0xE9701183, 0xE6B3, 0x4FF2, [0x85, 0x68, 0x81, 0x36, 0x15, 0xFE, 0xC7, 0xBE]};
@GUID(0xE9701183, 0xE6B3, 0x4FF2, [0x85, 0x68, 0x81, 0x36, 0x15, 0xFE, 0xC7, 0xBE]);
interface INameSpaceTreeControlFolderCapabilities : IUnknown
{
    HRESULT GetFolderCapabilities(NSTCFOLDERCAPABILITIES nfcMask, NSTCFOLDERCAPABILITIES* pnfcValue);
}

const GUID IID_IPreviewHandler = {0x8895B1C6, 0xB41F, 0x4C1C, [0xA5, 0x62, 0x0D, 0x56, 0x42, 0x50, 0x83, 0x6F]};
@GUID(0x8895B1C6, 0xB41F, 0x4C1C, [0xA5, 0x62, 0x0D, 0x56, 0x42, 0x50, 0x83, 0x6F]);
interface IPreviewHandler : IUnknown
{
    HRESULT SetWindow(HWND hwnd, const(RECT)* prc);
    HRESULT SetRect(const(RECT)* prc);
    HRESULT DoPreview();
    HRESULT Unload();
    HRESULT SetFocus();
    HRESULT QueryFocus(HWND* phwnd);
    HRESULT TranslateAcceleratorA(MSG* pmsg);
}

struct PREVIEWHANDLERFRAMEINFO
{
    HACCEL haccel;
    uint cAccelEntries;
}

const GUID IID_IPreviewHandlerFrame = {0xFEC87AAF, 0x35F9, 0x447A, [0xAD, 0xB7, 0x20, 0x23, 0x44, 0x91, 0x40, 0x1A]};
@GUID(0xFEC87AAF, 0x35F9, 0x447A, [0xAD, 0xB7, 0x20, 0x23, 0x44, 0x91, 0x40, 0x1A]);
interface IPreviewHandlerFrame : IUnknown
{
    HRESULT GetWindowContext(PREVIEWHANDLERFRAMEINFO* pinfo);
    HRESULT TranslateAcceleratorA(MSG* pmsg);
}

enum _EXPLORERPANESTATE
{
    EPS_DONTCARE = 0,
    EPS_DEFAULT_ON = 1,
    EPS_DEFAULT_OFF = 2,
    EPS_STATEMASK = 65535,
    EPS_INITIALSTATE = 65536,
    EPS_FORCE = 131072,
}

const GUID IID_IExplorerPaneVisibility = {0xE07010EC, 0xBC17, 0x44C0, [0x97, 0xB0, 0x46, 0xC7, 0xC9, 0x5B, 0x9E, 0xDC]};
@GUID(0xE07010EC, 0xBC17, 0x44C0, [0x97, 0xB0, 0x46, 0xC7, 0xC9, 0x5B, 0x9E, 0xDC]);
interface IExplorerPaneVisibility : IUnknown
{
    HRESULT GetPaneState(const(Guid)* ep, uint* peps);
}

const GUID IID_IContextMenuCB = {0x3409E930, 0x5A39, 0x11D1, [0x83, 0xFA, 0x00, 0xA0, 0xC9, 0x0D, 0xC8, 0x49]};
@GUID(0x3409E930, 0x5A39, 0x11D1, [0x83, 0xFA, 0x00, 0xA0, 0xC9, 0x0D, 0xC8, 0x49]);
interface IContextMenuCB : IUnknown
{
    HRESULT CallBack(IShellFolder psf, HWND hwndOwner, IDataObject pdtobj, uint uMsg, WPARAM wParam, LPARAM lParam);
}

const GUID IID_IDefaultExtractIconInit = {0x41DED17D, 0xD6B3, 0x4261, [0x99, 0x7D, 0x88, 0xC6, 0x0E, 0x4B, 0x1D, 0x58]};
@GUID(0x41DED17D, 0xD6B3, 0x4261, [0x99, 0x7D, 0x88, 0xC6, 0x0E, 0x4B, 0x1D, 0x58]);
interface IDefaultExtractIconInit : IUnknown
{
    HRESULT SetFlags(uint uFlags);
    HRESULT SetKey(HKEY hkey);
    HRESULT SetNormalIcon(const(wchar)* pszFile, int iIcon);
    HRESULT SetOpenIcon(const(wchar)* pszFile, int iIcon);
    HRESULT SetShortcutIcon(const(wchar)* pszFile, int iIcon);
    HRESULT SetDefaultIcon(const(wchar)* pszFile, int iIcon);
}

enum _EXPCMDSTATE
{
    ECS_ENABLED = 0,
    ECS_DISABLED = 1,
    ECS_HIDDEN = 2,
    ECS_CHECKBOX = 4,
    ECS_CHECKED = 8,
    ECS_RADIOCHECK = 16,
}

enum _EXPCMDFLAGS
{
    ECF_DEFAULT = 0,
    ECF_HASSUBCOMMANDS = 1,
    ECF_HASSPLITBUTTON = 2,
    ECF_HIDELABEL = 4,
    ECF_ISSEPARATOR = 8,
    ECF_HASLUASHIELD = 16,
    ECF_SEPARATORBEFORE = 32,
    ECF_SEPARATORAFTER = 64,
    ECF_ISDROPDOWN = 128,
    ECF_TOGGLEABLE = 256,
    ECF_AUTOMENUICONS = 512,
}

const GUID IID_IExplorerCommand = {0xA08CE4D0, 0xFA25, 0x44AB, [0xB5, 0x7C, 0xC7, 0xB1, 0xC3, 0x23, 0xE0, 0xB9]};
@GUID(0xA08CE4D0, 0xFA25, 0x44AB, [0xB5, 0x7C, 0xC7, 0xB1, 0xC3, 0x23, 0xE0, 0xB9]);
interface IExplorerCommand : IUnknown
{
    HRESULT GetTitle(IShellItemArray psiItemArray, ushort** ppszName);
    HRESULT GetIcon(IShellItemArray psiItemArray, ushort** ppszIcon);
    HRESULT GetToolTip(IShellItemArray psiItemArray, ushort** ppszInfotip);
    HRESULT GetCanonicalName(Guid* pguidCommandName);
    HRESULT GetState(IShellItemArray psiItemArray, BOOL fOkToBeSlow, uint* pCmdState);
    HRESULT Invoke(IShellItemArray psiItemArray, IBindCtx pbc);
    HRESULT GetFlags(uint* pFlags);
    HRESULT EnumSubCommands(IEnumExplorerCommand* ppEnum);
}

const GUID IID_IExplorerCommandState = {0xBDDACB60, 0x7657, 0x47AE, [0x84, 0x45, 0xD2, 0x3E, 0x1A, 0xCF, 0x82, 0xAE]};
@GUID(0xBDDACB60, 0x7657, 0x47AE, [0x84, 0x45, 0xD2, 0x3E, 0x1A, 0xCF, 0x82, 0xAE]);
interface IExplorerCommandState : IUnknown
{
    HRESULT GetState(IShellItemArray psiItemArray, BOOL fOkToBeSlow, uint* pCmdState);
}

const GUID IID_IInitializeCommand = {0x85075ACF, 0x231F, 0x40EA, [0x96, 0x10, 0xD2, 0x6B, 0x7B, 0x58, 0xF6, 0x38]};
@GUID(0x85075ACF, 0x231F, 0x40EA, [0x96, 0x10, 0xD2, 0x6B, 0x7B, 0x58, 0xF6, 0x38]);
interface IInitializeCommand : IUnknown
{
    HRESULT Initialize(const(wchar)* pszCommandName, IPropertyBag ppb);
}

const GUID IID_IEnumExplorerCommand = {0xA88826F8, 0x186F, 0x4987, [0xAA, 0xDE, 0xEA, 0x0C, 0xEF, 0x8F, 0xBF, 0xE8]};
@GUID(0xA88826F8, 0x186F, 0x4987, [0xAA, 0xDE, 0xEA, 0x0C, 0xEF, 0x8F, 0xBF, 0xE8]);
interface IEnumExplorerCommand : IUnknown
{
    HRESULT Next(uint celt, char* pUICommand, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumExplorerCommand* ppenum);
}

const GUID IID_IExplorerCommandProvider = {0x64961751, 0x0835, 0x43C0, [0x8F, 0xFE, 0xD5, 0x76, 0x86, 0x53, 0x0E, 0x64]};
@GUID(0x64961751, 0x0835, 0x43C0, [0x8F, 0xFE, 0xD5, 0x76, 0x86, 0x53, 0x0E, 0x64]);
interface IExplorerCommandProvider : IUnknown
{
    HRESULT GetCommands(IUnknown punkSite, const(Guid)* riid, void** ppv);
    HRESULT GetCommand(const(Guid)* rguidCommandId, const(Guid)* riid, void** ppv);
}

enum CPVIEW
{
    CPVIEW_CLASSIC = 0,
    CPVIEW_ALLITEMS = 0,
    CPVIEW_CATEGORY = 1,
    CPVIEW_HOME = 1,
}

const GUID IID_IOpenControlPanel = {0xD11AD862, 0x66DE, 0x4DF4, [0xBF, 0x6C, 0x1F, 0x56, 0x21, 0x99, 0x6A, 0xF1]};
@GUID(0xD11AD862, 0x66DE, 0x4DF4, [0xBF, 0x6C, 0x1F, 0x56, 0x21, 0x99, 0x6A, 0xF1]);
interface IOpenControlPanel : IUnknown
{
    HRESULT Open(const(wchar)* pszName, const(wchar)* pszPage, IUnknown punkSite);
    HRESULT GetPath(const(wchar)* pszName, const(wchar)* pszPath, uint cchPath);
    HRESULT GetCurrentView(CPVIEW* pView);
}

const GUID IID_IFileSystemBindData = {0x01E18D10, 0x4D8B, 0x11D2, [0x85, 0x5D, 0x00, 0x60, 0x08, 0x05, 0x93, 0x67]};
@GUID(0x01E18D10, 0x4D8B, 0x11D2, [0x85, 0x5D, 0x00, 0x60, 0x08, 0x05, 0x93, 0x67]);
interface IFileSystemBindData : IUnknown
{
    HRESULT SetFindData(const(WIN32_FIND_DATAW)* pfd);
    HRESULT GetFindData(WIN32_FIND_DATAW* pfd);
}

const GUID IID_IFileSystemBindData2 = {0x3ACF075F, 0x71DB, 0x4AFA, [0x81, 0xF0, 0x3F, 0xC4, 0xFD, 0xF2, 0xA5, 0xB8]};
@GUID(0x3ACF075F, 0x71DB, 0x4AFA, [0x81, 0xF0, 0x3F, 0xC4, 0xFD, 0xF2, 0xA5, 0xB8]);
interface IFileSystemBindData2 : IFileSystemBindData
{
    HRESULT SetFileID(LARGE_INTEGER liFileID);
    HRESULT GetFileID(LARGE_INTEGER* pliFileID);
    HRESULT SetJunctionCLSID(const(Guid)* clsid);
    HRESULT GetJunctionCLSID(Guid* pclsid);
}

enum KNOWNDESTCATEGORY
{
    KDC_FREQUENT = 1,
    KDC_RECENT = 2,
}

const GUID IID_ICustomDestinationList = {0x6332DEBF, 0x87B5, 0x4670, [0x90, 0xC0, 0x5E, 0x57, 0xB4, 0x08, 0xA4, 0x9E]};
@GUID(0x6332DEBF, 0x87B5, 0x4670, [0x90, 0xC0, 0x5E, 0x57, 0xB4, 0x08, 0xA4, 0x9E]);
interface ICustomDestinationList : IUnknown
{
    HRESULT SetAppID(const(wchar)* pszAppID);
    HRESULT BeginList(uint* pcMinSlots, const(Guid)* riid, void** ppv);
    HRESULT AppendCategory(const(wchar)* pszCategory, IObjectArray poa);
    HRESULT AppendKnownCategory(KNOWNDESTCATEGORY category);
    HRESULT AddUserTasks(IObjectArray poa);
    HRESULT CommitList();
    HRESULT GetRemovedDestinations(const(Guid)* riid, void** ppv);
    HRESULT DeleteList(const(wchar)* pszAppID);
    HRESULT AbortList();
}

const GUID IID_IApplicationDestinations = {0x12337D35, 0x94C6, 0x48A0, [0xBC, 0xE7, 0x6A, 0x9C, 0x69, 0xD4, 0xD6, 0x00]};
@GUID(0x12337D35, 0x94C6, 0x48A0, [0xBC, 0xE7, 0x6A, 0x9C, 0x69, 0xD4, 0xD6, 0x00]);
interface IApplicationDestinations : IUnknown
{
    HRESULT SetAppID(const(wchar)* pszAppID);
    HRESULT RemoveDestination(IUnknown punk);
    HRESULT RemoveAllDestinations();
}

enum APPDOCLISTTYPE
{
    ADLT_RECENT = 0,
    ADLT_FREQUENT = 1,
}

const GUID IID_IApplicationDocumentLists = {0x3C594F9F, 0x9F30, 0x47A1, [0x97, 0x9A, 0xC9, 0xE8, 0x3D, 0x3D, 0x0A, 0x06]};
@GUID(0x3C594F9F, 0x9F30, 0x47A1, [0x97, 0x9A, 0xC9, 0xE8, 0x3D, 0x3D, 0x0A, 0x06]);
interface IApplicationDocumentLists : IUnknown
{
    HRESULT SetAppID(const(wchar)* pszAppID);
    HRESULT GetList(APPDOCLISTTYPE listtype, uint cItemsDesired, const(Guid)* riid, void** ppv);
}

const GUID IID_IObjectWithAppUserModelID = {0x36DB0196, 0x9665, 0x46D1, [0x9B, 0xA7, 0xD3, 0x70, 0x9E, 0xEC, 0xF9, 0xED]};
@GUID(0x36DB0196, 0x9665, 0x46D1, [0x9B, 0xA7, 0xD3, 0x70, 0x9E, 0xEC, 0xF9, 0xED]);
interface IObjectWithAppUserModelID : IUnknown
{
    HRESULT SetAppID(const(wchar)* pszAppID);
    HRESULT GetAppID(ushort** ppszAppID);
}

const GUID IID_IObjectWithProgID = {0x71E806FB, 0x8DEE, 0x46FC, [0xBF, 0x8C, 0x77, 0x48, 0xA8, 0xA1, 0xAE, 0x13]};
@GUID(0x71E806FB, 0x8DEE, 0x46FC, [0xBF, 0x8C, 0x77, 0x48, 0xA8, 0xA1, 0xAE, 0x13]);
interface IObjectWithProgID : IUnknown
{
    HRESULT SetProgID(const(wchar)* pszProgID);
    HRESULT GetProgID(ushort** ppszProgID);
}

const GUID IID_IUpdateIDList = {0x6589B6D2, 0x5F8D, 0x4B9E, [0xB7, 0xE0, 0x23, 0xCD, 0xD9, 0x71, 0x7D, 0x8C]};
@GUID(0x6589B6D2, 0x5F8D, 0x4B9E, [0xB7, 0xE0, 0x23, 0xCD, 0xD9, 0x71, 0x7D, 0x8C]);
interface IUpdateIDList : IUnknown
{
    HRESULT Update(IBindCtx pbc, ITEMIDLIST* pidlIn, ITEMIDLIST** ppidlOut);
}

enum DESKTOP_SLIDESHOW_OPTIONS
{
    DSO_SHUFFLEIMAGES = 1,
}

enum DESKTOP_SLIDESHOW_STATE
{
    DSS_ENABLED = 1,
    DSS_SLIDESHOW = 2,
    DSS_DISABLED_BY_REMOTE_SESSION = 4,
}

enum DESKTOP_SLIDESHOW_DIRECTION
{
    DSD_FORWARD = 0,
    DSD_BACKWARD = 1,
}

enum DESKTOP_WALLPAPER_POSITION
{
    DWPOS_CENTER = 0,
    DWPOS_TILE = 1,
    DWPOS_STRETCH = 2,
    DWPOS_FIT = 3,
    DWPOS_FILL = 4,
    DWPOS_SPAN = 5,
}

const GUID IID_IDesktopWallpaper = {0xB92B56A9, 0x8B55, 0x4E14, [0x9A, 0x89, 0x01, 0x99, 0xBB, 0xB6, 0xF9, 0x3B]};
@GUID(0xB92B56A9, 0x8B55, 0x4E14, [0x9A, 0x89, 0x01, 0x99, 0xBB, 0xB6, 0xF9, 0x3B]);
interface IDesktopWallpaper : IUnknown
{
    HRESULT SetWallpaper(const(wchar)* monitorID, const(wchar)* wallpaper);
    HRESULT GetWallpaper(const(wchar)* monitorID, ushort** wallpaper);
    HRESULT GetMonitorDevicePathAt(uint monitorIndex, ushort** monitorID);
    HRESULT GetMonitorDevicePathCount(uint* count);
    HRESULT GetMonitorRECT(const(wchar)* monitorID, RECT* displayRect);
    HRESULT SetBackgroundColor(uint color);
    HRESULT GetBackgroundColor(uint* color);
    HRESULT SetPosition(DESKTOP_WALLPAPER_POSITION position);
    HRESULT GetPosition(DESKTOP_WALLPAPER_POSITION* position);
    HRESULT SetSlideshow(IShellItemArray items);
    HRESULT GetSlideshow(IShellItemArray* items);
    HRESULT SetSlideshowOptions(DESKTOP_SLIDESHOW_OPTIONS options, uint slideshowTick);
    HRESULT GetSlideshowOptions(DESKTOP_SLIDESHOW_OPTIONS* options, uint* slideshowTick);
    HRESULT AdvanceSlideshow(const(wchar)* monitorID, DESKTOP_SLIDESHOW_DIRECTION direction);
    HRESULT GetStatus(DESKTOP_SLIDESHOW_STATE* state);
    HRESULT Enable(BOOL enable);
}

enum HOMEGROUPSHARINGCHOICES
{
    HGSC_NONE = 0,
    HGSC_MUSICLIBRARY = 1,
    HGSC_PICTURESLIBRARY = 2,
    HGSC_VIDEOSLIBRARY = 4,
    HGSC_DOCUMENTSLIBRARY = 8,
    HGSC_PRINTERS = 16,
}

const GUID IID_IHomeGroup = {0x7A3BD1D9, 0x35A9, 0x4FB3, [0xA4, 0x67, 0xF4, 0x8C, 0xAC, 0x35, 0xE2, 0xD0]};
@GUID(0x7A3BD1D9, 0x35A9, 0x4FB3, [0xA4, 0x67, 0xF4, 0x8C, 0xAC, 0x35, 0xE2, 0xD0]);
interface IHomeGroup : IUnknown
{
    HRESULT IsMember(int* member);
    HRESULT ShowSharingWizard(HWND owner, HOMEGROUPSHARINGCHOICES* sharingchoices);
}

const GUID IID_IInitializeWithPropertyStore = {0xC3E12EB5, 0x7D8D, 0x44F8, [0xB6, 0xDD, 0x0E, 0x77, 0xB3, 0x4D, 0x6D, 0xE4]};
@GUID(0xC3E12EB5, 0x7D8D, 0x44F8, [0xB6, 0xDD, 0x0E, 0x77, 0xB3, 0x4D, 0x6D, 0xE4]);
interface IInitializeWithPropertyStore : IUnknown
{
    HRESULT Initialize(IPropertyStore pps);
}

const GUID IID_IOpenSearchSource = {0xF0EE7333, 0xE6FC, 0x479B, [0x9F, 0x25, 0xA8, 0x60, 0xC2, 0x34, 0xA3, 0x8E]};
@GUID(0xF0EE7333, 0xE6FC, 0x479B, [0x9F, 0x25, 0xA8, 0x60, 0xC2, 0x34, 0xA3, 0x8E]);
interface IOpenSearchSource : IUnknown
{
    HRESULT GetResults(HWND hwnd, const(wchar)* pszQuery, uint dwStartIndex, uint dwCount, const(Guid)* riid, void** ppv);
}

enum LIBRARYFOLDERFILTER
{
    LFF_FORCEFILESYSTEM = 1,
    LFF_STORAGEITEMS = 2,
    LFF_ALLITEMS = 3,
}

enum LIBRARYOPTIONFLAGS
{
    LOF_DEFAULT = 0,
    LOF_PINNEDTONAVPANE = 1,
    LOF_MASK_ALL = 1,
}

enum DEFAULTSAVEFOLDERTYPE
{
    DSFT_DETECT = 1,
    DSFT_PRIVATE = 2,
    DSFT_PUBLIC = 3,
}

enum LIBRARYSAVEFLAGS
{
    LSF_FAILIFTHERE = 0,
    LSF_OVERRIDEEXISTING = 1,
    LSF_MAKEUNIQUENAME = 2,
}

const GUID IID_IShellLibrary = {0x11A66EFA, 0x382E, 0x451A, [0x92, 0x34, 0x1E, 0x0E, 0x12, 0xEF, 0x30, 0x85]};
@GUID(0x11A66EFA, 0x382E, 0x451A, [0x92, 0x34, 0x1E, 0x0E, 0x12, 0xEF, 0x30, 0x85]);
interface IShellLibrary : IUnknown
{
    HRESULT LoadLibraryFromItem(IShellItem psiLibrary, uint grfMode);
    HRESULT LoadLibraryFromKnownFolder(const(Guid)* kfidLibrary, uint grfMode);
    HRESULT AddFolder(IShellItem psiLocation);
    HRESULT RemoveFolder(IShellItem psiLocation);
    HRESULT GetFolders(LIBRARYFOLDERFILTER lff, const(Guid)* riid, void** ppv);
    HRESULT ResolveFolder(IShellItem psiFolderToResolve, uint dwTimeout, const(Guid)* riid, void** ppv);
    HRESULT GetDefaultSaveFolder(DEFAULTSAVEFOLDERTYPE dsft, const(Guid)* riid, void** ppv);
    HRESULT SetDefaultSaveFolder(DEFAULTSAVEFOLDERTYPE dsft, IShellItem psi);
    HRESULT GetOptions(LIBRARYOPTIONFLAGS* plofOptions);
    HRESULT SetOptions(LIBRARYOPTIONFLAGS lofMask, LIBRARYOPTIONFLAGS lofOptions);
    HRESULT GetFolderType(Guid* pftid);
    HRESULT SetFolderType(const(Guid)* ftid);
    HRESULT GetIcon(ushort** ppszIcon);
    HRESULT SetIcon(const(wchar)* pszIcon);
    HRESULT Commit();
    HRESULT Save(IShellItem psiFolderToSaveIn, const(wchar)* pszLibraryName, LIBRARYSAVEFLAGS lsf, IShellItem* ppsiSavedTo);
    HRESULT SaveInKnownFolder(const(Guid)* kfidToSaveIn, const(wchar)* pszLibraryName, LIBRARYSAVEFLAGS lsf, IShellItem* ppsiSavedTo);
}

enum DEFAULT_FOLDER_MENU_RESTRICTIONS
{
    DFMR_DEFAULT = 0,
    DFMR_NO_STATIC_VERBS = 8,
    DFMR_STATIC_VERBS_ONLY = 16,
    DFMR_NO_RESOURCE_VERBS = 32,
    DFMR_OPTIN_HANDLERS_ONLY = 64,
    DFMR_RESOURCE_AND_FOLDER_VERBS_ONLY = 128,
    DFMR_USE_SPECIFIED_HANDLERS = 256,
    DFMR_USE_SPECIFIED_VERBS = 512,
    DFMR_NO_ASYNC_VERBS = 1024,
    DFMR_NO_NATIVECPU_VERBS = 2048,
}

const GUID IID_IDefaultFolderMenuInitialize = {0x7690AA79, 0xF8FC, 0x4615, [0xA3, 0x27, 0x36, 0xF7, 0xD1, 0x8F, 0x5D, 0x91]};
@GUID(0x7690AA79, 0xF8FC, 0x4615, [0xA3, 0x27, 0x36, 0xF7, 0xD1, 0x8F, 0x5D, 0x91]);
interface IDefaultFolderMenuInitialize : IUnknown
{
    HRESULT Initialize(HWND hwnd, IContextMenuCB pcmcb, ITEMIDLIST* pidlFolder, IShellFolder psf, uint cidl, ITEMIDLIST** apidl, IUnknown punkAssociation, uint cKeys, const(int)* aKeys);
    HRESULT SetMenuRestrictions(DEFAULT_FOLDER_MENU_RESTRICTIONS dfmrValues);
    HRESULT GetMenuRestrictions(DEFAULT_FOLDER_MENU_RESTRICTIONS dfmrMask, DEFAULT_FOLDER_MENU_RESTRICTIONS* pdfmrValues);
    HRESULT SetHandlerClsid(const(Guid)* rclsid);
}

enum ACTIVATEOPTIONS
{
    AO_NONE = 0,
    AO_DESIGNMODE = 1,
    AO_NOERRORUI = 2,
    AO_NOSPLASHSCREEN = 4,
    AO_PRELAUNCH = 33554432,
}

const GUID IID_IApplicationActivationManager = {0x2E941141, 0x7F97, 0x4756, [0xBA, 0x1D, 0x9D, 0xEC, 0xDE, 0x89, 0x4A, 0x3D]};
@GUID(0x2E941141, 0x7F97, 0x4756, [0xBA, 0x1D, 0x9D, 0xEC, 0xDE, 0x89, 0x4A, 0x3D]);
interface IApplicationActivationManager : IUnknown
{
    HRESULT ActivateApplication(const(wchar)* appUserModelId, const(wchar)* arguments, ACTIVATEOPTIONS options, uint* processId);
    HRESULT ActivateForFile(const(wchar)* appUserModelId, IShellItemArray itemArray, const(wchar)* verb, uint* processId);
    HRESULT ActivateForProtocol(const(wchar)* appUserModelId, IShellItemArray itemArray, uint* processId);
}

const GUID IID_IVirtualDesktopManager = {0xA5CD92FF, 0x29BE, 0x454C, [0x8D, 0x04, 0xD8, 0x28, 0x79, 0xFB, 0x3F, 0x1B]};
@GUID(0xA5CD92FF, 0x29BE, 0x454C, [0x8D, 0x04, 0xD8, 0x28, 0x79, 0xFB, 0x3F, 0x1B]);
interface IVirtualDesktopManager : IUnknown
{
    HRESULT IsWindowOnCurrentVirtualDesktop(HWND topLevelWindow, int* onCurrentDesktop);
    HRESULT GetWindowDesktopId(HWND topLevelWindow, Guid* desktopId);
    HRESULT MoveWindowToDesktop(HWND topLevelWindow, const(Guid)* desktopId);
}

enum LIBRARYMANAGEDIALOGOPTIONS
{
    LMD_DEFAULT = 0,
    LMD_ALLOWUNINDEXABLENETWORKLOCATIONS = 1,
}

const GUID IID_IAssocHandlerInvoker = {0x92218CAB, 0xECAA, 0x4335, [0x81, 0x33, 0x80, 0x7F, 0xD2, 0x34, 0xC2, 0xEE]};
@GUID(0x92218CAB, 0xECAA, 0x4335, [0x81, 0x33, 0x80, 0x7F, 0xD2, 0x34, 0xC2, 0xEE]);
interface IAssocHandlerInvoker : IUnknown
{
    HRESULT SupportsSelection();
    HRESULT Invoke();
}

enum AHTYPE
{
    AHTYPE_UNDEFINED = 0,
    AHTYPE_USER_APPLICATION = 8,
    AHTYPE_ANY_APPLICATION = 16,
    AHTYPE_MACHINEDEFAULT = 32,
    AHTYPE_PROGID = 64,
    AHTYPE_APPLICATION = 128,
    AHTYPE_CLASS_APPLICATION = 256,
    AHTYPE_ANY_PROGID = 512,
}

const GUID IID_IAssocHandler = {0xF04061AC, 0x1659, 0x4A3F, [0xA9, 0x54, 0x77, 0x5A, 0xA5, 0x7F, 0xC0, 0x83]};
@GUID(0xF04061AC, 0x1659, 0x4A3F, [0xA9, 0x54, 0x77, 0x5A, 0xA5, 0x7F, 0xC0, 0x83]);
interface IAssocHandler : IUnknown
{
    HRESULT GetName(ushort** ppsz);
    HRESULT GetUIName(ushort** ppsz);
    HRESULT GetIconLocation(ushort** ppszPath, int* pIndex);
    HRESULT IsRecommended();
    HRESULT MakeDefault(const(wchar)* pszDescription);
    HRESULT Invoke(IDataObject pdo);
    HRESULT CreateInvoker(IDataObject pdo, IAssocHandlerInvoker* ppInvoker);
}

const GUID IID_IEnumAssocHandlers = {0x973810AE, 0x9599, 0x4B88, [0x9E, 0x4D, 0x6E, 0xE9, 0x8C, 0x95, 0x52, 0xDA]};
@GUID(0x973810AE, 0x9599, 0x4B88, [0x9E, 0x4D, 0x6E, 0xE9, 0x8C, 0x95, 0x52, 0xDA]);
interface IEnumAssocHandlers : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
}

enum ASSOC_FILTER
{
    ASSOC_FILTER_NONE = 0,
    ASSOC_FILTER_RECOMMENDED = 1,
}

const GUID IID_IDataObjectProvider = {0x3D25F6D6, 0x4B2A, 0x433C, [0x91, 0x84, 0x7C, 0x33, 0xAD, 0x35, 0xD0, 0x01]};
@GUID(0x3D25F6D6, 0x4B2A, 0x433C, [0x91, 0x84, 0x7C, 0x33, 0xAD, 0x35, 0xD0, 0x01]);
interface IDataObjectProvider : IUnknown
{
    HRESULT GetDataObject(IDataObject* dataObject);
    HRESULT SetDataObject(IDataObject dataObject);
}

const GUID IID_IDataTransferManagerInterop = {0x3A3DCD6C, 0x3EAB, 0x43DC, [0xBC, 0xDE, 0x45, 0x67, 0x1C, 0xE8, 0x00, 0xC8]};
@GUID(0x3A3DCD6C, 0x3EAB, 0x43DC, [0xBC, 0xDE, 0x45, 0x67, 0x1C, 0xE8, 0x00, 0xC8]);
interface IDataTransferManagerInterop : IUnknown
{
    HRESULT GetForWindow(HWND appWindow, const(Guid)* riid, void** dataTransferManager);
    HRESULT ShowShareUIForWindow(HWND appWindow);
}

const GUID IID_IFrameworkInputPaneHandler = {0x226C537B, 0x1E76, 0x4D9E, [0xA7, 0x60, 0x33, 0xDB, 0x29, 0x92, 0x2F, 0x18]};
@GUID(0x226C537B, 0x1E76, 0x4D9E, [0xA7, 0x60, 0x33, 0xDB, 0x29, 0x92, 0x2F, 0x18]);
interface IFrameworkInputPaneHandler : IUnknown
{
    HRESULT Showing(RECT* prcInputPaneScreenLocation, BOOL fEnsureFocusedElementInView);
    HRESULT Hiding(BOOL fEnsureFocusedElementInView);
}

const GUID IID_IFrameworkInputPane = {0x5752238B, 0x24F0, 0x495A, [0x82, 0xF1, 0x2F, 0xD5, 0x93, 0x05, 0x67, 0x96]};
@GUID(0x5752238B, 0x24F0, 0x495A, [0x82, 0xF1, 0x2F, 0xD5, 0x93, 0x05, 0x67, 0x96]);
interface IFrameworkInputPane : IUnknown
{
    HRESULT Advise(IUnknown pWindow, IFrameworkInputPaneHandler pHandler, uint* pdwCookie);
    HRESULT AdviseWithHWND(HWND hwnd, IFrameworkInputPaneHandler pHandler, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
    HRESULT Location(RECT* prcInputPaneScreenLocation);
}

enum MONITOR_APP_VISIBILITY
{
    MAV_UNKNOWN = 0,
    MAV_NO_APP_VISIBLE = 1,
    MAV_APP_VISIBLE = 2,
}

const GUID IID_IAppVisibilityEvents = {0x6584CE6B, 0x7D82, 0x49C2, [0x89, 0xC9, 0xC6, 0xBC, 0x02, 0xBA, 0x8C, 0x38]};
@GUID(0x6584CE6B, 0x7D82, 0x49C2, [0x89, 0xC9, 0xC6, 0xBC, 0x02, 0xBA, 0x8C, 0x38]);
interface IAppVisibilityEvents : IUnknown
{
    HRESULT AppVisibilityOnMonitorChanged(int hMonitor, MONITOR_APP_VISIBILITY previousMode, MONITOR_APP_VISIBILITY currentMode);
    HRESULT LauncherVisibilityChange(BOOL currentVisibleState);
}

const GUID IID_IAppVisibility = {0x2246EA2D, 0xCAEA, 0x4444, [0xA3, 0xC4, 0x6D, 0xE8, 0x27, 0xE4, 0x43, 0x13]};
@GUID(0x2246EA2D, 0xCAEA, 0x4444, [0xA3, 0xC4, 0x6D, 0xE8, 0x27, 0xE4, 0x43, 0x13]);
interface IAppVisibility : IUnknown
{
    HRESULT GetAppVisibilityOnMonitor(int hMonitor, MONITOR_APP_VISIBILITY* pMode);
    HRESULT IsLauncherVisible(int* pfVisible);
    HRESULT Advise(IAppVisibilityEvents pCallback, uint* pdwCookie);
    HRESULT Unadvise(uint dwCookie);
}

enum PACKAGE_EXECUTION_STATE
{
    PES_UNKNOWN = 0,
    PES_RUNNING = 1,
    PES_SUSPENDING = 2,
    PES_SUSPENDED = 3,
    PES_TERMINATED = 4,
}

const GUID IID_IPackageExecutionStateChangeNotification = {0x1BB12A62, 0x2AD8, 0x432B, [0x8C, 0xCF, 0x0C, 0x2C, 0x52, 0xAF, 0xCD, 0x5B]};
@GUID(0x1BB12A62, 0x2AD8, 0x432B, [0x8C, 0xCF, 0x0C, 0x2C, 0x52, 0xAF, 0xCD, 0x5B]);
interface IPackageExecutionStateChangeNotification : IUnknown
{
    HRESULT OnStateChanged(const(wchar)* pszPackageFullName, PACKAGE_EXECUTION_STATE pesNewState);
}

const GUID IID_IPackageDebugSettings = {0xF27C3930, 0x8029, 0x4AD1, [0x94, 0xE3, 0x3D, 0xBA, 0x41, 0x78, 0x10, 0xC1]};
@GUID(0xF27C3930, 0x8029, 0x4AD1, [0x94, 0xE3, 0x3D, 0xBA, 0x41, 0x78, 0x10, 0xC1]);
interface IPackageDebugSettings : IUnknown
{
    HRESULT EnableDebugging(const(wchar)* packageFullName, const(wchar)* debuggerCommandLine, const(wchar)* environment);
    HRESULT DisableDebugging(const(wchar)* packageFullName);
    HRESULT Suspend(const(wchar)* packageFullName);
    HRESULT Resume(const(wchar)* packageFullName);
    HRESULT TerminateAllProcesses(const(wchar)* packageFullName);
    HRESULT SetTargetSessionId(uint sessionId);
    HRESULT EnumerateBackgroundTasks(const(wchar)* packageFullName, uint* taskCount, Guid** taskIds, ushort*** taskNames);
    HRESULT ActivateBackgroundTask(Guid* taskId);
    HRESULT StartServicing(const(wchar)* packageFullName);
    HRESULT StopServicing(const(wchar)* packageFullName);
    HRESULT StartSessionRedirection(const(wchar)* packageFullName, uint sessionId);
    HRESULT StopSessionRedirection(const(wchar)* packageFullName);
    HRESULT GetPackageExecutionState(const(wchar)* packageFullName, PACKAGE_EXECUTION_STATE* packageExecutionState);
    HRESULT RegisterForPackageStateChanges(const(wchar)* packageFullName, IPackageExecutionStateChangeNotification pPackageExecutionStateChangeNotification, uint* pdwCookie);
    HRESULT UnregisterForPackageStateChanges(uint dwCookie);
}

const GUID IID_IPackageDebugSettings2 = {0x6E3194BB, 0xAB82, 0x4D22, [0x93, 0xF5, 0xFA, 0xBD, 0xA4, 0x0E, 0x7B, 0x16]};
@GUID(0x6E3194BB, 0xAB82, 0x4D22, [0x93, 0xF5, 0xFA, 0xBD, 0xA4, 0x0E, 0x7B, 0x16]);
interface IPackageDebugSettings2 : IPackageDebugSettings
{
    HRESULT EnumerateApps(const(wchar)* packageFullName, uint* appCount, ushort*** appUserModelIds, ushort*** appDisplayNames);
}

const GUID IID_ISuspensionDependencyManager = {0x52B83A42, 0x2543, 0x416A, [0x81, 0xD9, 0xC0, 0xDE, 0x79, 0x69, 0xC8, 0xB3]};
@GUID(0x52B83A42, 0x2543, 0x416A, [0x81, 0xD9, 0xC0, 0xDE, 0x79, 0x69, 0xC8, 0xB3]);
interface ISuspensionDependencyManager : IUnknown
{
    HRESULT RegisterAsChild(HANDLE processHandle);
    HRESULT GroupChildWithParent(HANDLE childProcessHandle);
    HRESULT UngroupChildFromParent(HANDLE childProcessHandle);
}

enum AHE_TYPE
{
    AHE_DESKTOP = 0,
    AHE_IMMERSIVE = 1,
}

const GUID IID_IExecuteCommandApplicationHostEnvironment = {0x18B21AA9, 0xE184, 0x4FF0, [0x9F, 0x5E, 0xF8, 0x82, 0xD0, 0x37, 0x71, 0xB3]};
@GUID(0x18B21AA9, 0xE184, 0x4FF0, [0x9F, 0x5E, 0xF8, 0x82, 0xD0, 0x37, 0x71, 0xB3]);
interface IExecuteCommandApplicationHostEnvironment : IUnknown
{
    HRESULT GetValue(AHE_TYPE* pahe);
}

enum EC_HOST_UI_MODE
{
    ECHUIM_DESKTOP = 0,
    ECHUIM_IMMERSIVE = 1,
    ECHUIM_SYSTEM_LAUNCHER = 2,
}

const GUID IID_IExecuteCommandHost = {0x4B6832A2, 0x5F04, 0x4C9D, [0xB8, 0x9D, 0x72, 0x7A, 0x15, 0xD1, 0x03, 0xE7]};
@GUID(0x4B6832A2, 0x5F04, 0x4C9D, [0xB8, 0x9D, 0x72, 0x7A, 0x15, 0xD1, 0x03, 0xE7]);
interface IExecuteCommandHost : IUnknown
{
    HRESULT GetUIMode(EC_HOST_UI_MODE* pUIMode);
}

enum APPLICATION_VIEW_STATE
{
    AVS_FULLSCREEN_LANDSCAPE = 0,
    AVS_FILLED = 1,
    AVS_SNAPPED = 2,
    AVS_FULLSCREEN_PORTRAIT = 3,
}

enum EDGE_GESTURE_KIND
{
    EGK_TOUCH = 0,
    EGK_KEYBOARD = 1,
    EGK_MOUSE = 2,
}

const GUID IID_IApplicationDesignModeSettings = {0x2A3DEE9A, 0xE31D, 0x46D6, [0x85, 0x08, 0xBC, 0xC5, 0x97, 0xDB, 0x35, 0x57]};
@GUID(0x2A3DEE9A, 0xE31D, 0x46D6, [0x85, 0x08, 0xBC, 0xC5, 0x97, 0xDB, 0x35, 0x57]);
interface IApplicationDesignModeSettings : IUnknown
{
    HRESULT SetNativeDisplaySize(SIZE nativeDisplaySizePixels);
    HRESULT SetScaleFactor(DEVICE_SCALE_FACTOR scaleFactor);
    HRESULT SetApplicationViewState(APPLICATION_VIEW_STATE viewState);
    HRESULT ComputeApplicationSize(SIZE* applicationSizePixels);
    HRESULT IsApplicationViewStateSupported(APPLICATION_VIEW_STATE viewState, SIZE nativeDisplaySizePixels, DEVICE_SCALE_FACTOR scaleFactor, int* supported);
    HRESULT TriggerEdgeGesture(EDGE_GESTURE_KIND edgeGestureKind);
}

enum NATIVE_DISPLAY_ORIENTATION
{
    NDO_LANDSCAPE = 0,
    NDO_PORTRAIT = 1,
}

enum APPLICATION_VIEW_ORIENTATION
{
    AVO_LANDSCAPE = 0,
    AVO_PORTRAIT = 1,
}

enum ADJACENT_DISPLAY_EDGES
{
    ADE_NONE = 0,
    ADE_LEFT = 1,
    ADE_RIGHT = 2,
}

enum APPLICATION_VIEW_MIN_WIDTH
{
    AVMW_DEFAULT = 0,
    AVMW_320 = 1,
    AVMW_500 = 2,
}

const GUID IID_IApplicationDesignModeSettings2 = {0x490514E1, 0x675A, 0x4D6E, [0xA5, 0x8D, 0xE5, 0x49, 0x01, 0xB4, 0xCA, 0x2F]};
@GUID(0x490514E1, 0x675A, 0x4D6E, [0xA5, 0x8D, 0xE5, 0x49, 0x01, 0xB4, 0xCA, 0x2F]);
interface IApplicationDesignModeSettings2 : IApplicationDesignModeSettings
{
    HRESULT SetNativeDisplayOrientation(NATIVE_DISPLAY_ORIENTATION nativeDisplayOrientation);
    HRESULT SetApplicationViewOrientation(APPLICATION_VIEW_ORIENTATION viewOrientation);
    HRESULT SetAdjacentDisplayEdges(ADJACENT_DISPLAY_EDGES adjacentDisplayEdges);
    HRESULT SetIsOnLockScreen(BOOL isOnLockScreen);
    HRESULT SetApplicationViewMinWidth(APPLICATION_VIEW_MIN_WIDTH viewMinWidth);
    HRESULT GetApplicationSizeBounds(SIZE* minApplicationSizePixels, SIZE* maxApplicationSizePixels);
    HRESULT GetApplicationViewOrientation(SIZE applicationSizePixels, APPLICATION_VIEW_ORIENTATION* viewOrientation);
}

const GUID IID_ILaunchTargetMonitor = {0x266FBC7E, 0x490D, 0x46ED, [0xA9, 0x6B, 0x22, 0x74, 0xDB, 0x25, 0x20, 0x03]};
@GUID(0x266FBC7E, 0x490D, 0x46ED, [0xA9, 0x6B, 0x22, 0x74, 0xDB, 0x25, 0x20, 0x03]);
interface ILaunchTargetMonitor : IUnknown
{
    HRESULT GetMonitor(int* monitor);
}

enum APPLICATION_VIEW_SIZE_PREFERENCE
{
    AVSP_DEFAULT = 0,
    AVSP_USE_LESS = 1,
    AVSP_USE_HALF = 2,
    AVSP_USE_MORE = 3,
    AVSP_USE_MINIMUM = 4,
    AVSP_USE_NONE = 5,
    AVSP_CUSTOM = 6,
}

const GUID IID_ILaunchSourceViewSizePreference = {0xE5AA01F7, 0x1FB8, 0x4830, [0x87, 0x20, 0x4E, 0x67, 0x34, 0xCB, 0xD5, 0xF3]};
@GUID(0xE5AA01F7, 0x1FB8, 0x4830, [0x87, 0x20, 0x4E, 0x67, 0x34, 0xCB, 0xD5, 0xF3]);
interface ILaunchSourceViewSizePreference : IUnknown
{
    HRESULT GetSourceViewToPosition(HWND* hwnd);
    HRESULT GetSourceViewSizePreference(APPLICATION_VIEW_SIZE_PREFERENCE* sourceSizeAfterLaunch);
}

const GUID IID_ILaunchTargetViewSizePreference = {0x2F0666C6, 0x12F7, 0x4360, [0xB5, 0x11, 0xA3, 0x94, 0xA0, 0x55, 0x37, 0x25]};
@GUID(0x2F0666C6, 0x12F7, 0x4360, [0xB5, 0x11, 0xA3, 0x94, 0xA0, 0x55, 0x37, 0x25]);
interface ILaunchTargetViewSizePreference : IUnknown
{
    HRESULT GetTargetViewSizePreference(APPLICATION_VIEW_SIZE_PREFERENCE* targetSizeOnLaunch);
}

const GUID IID_ILaunchSourceAppUserModelId = {0x989191AC, 0x28FF, 0x4CF0, [0x95, 0x84, 0xE0, 0xD0, 0x78, 0xBC, 0x23, 0x96]};
@GUID(0x989191AC, 0x28FF, 0x4CF0, [0x95, 0x84, 0xE0, 0xD0, 0x78, 0xBC, 0x23, 0x96]);
interface ILaunchSourceAppUserModelId : IUnknown
{
    HRESULT GetAppUserModelId(ushort** launchingApp);
}

const GUID IID_IInitializeWithWindow = {0x3E68D4BD, 0x7135, 0x4D10, [0x80, 0x18, 0x9F, 0xB6, 0xD9, 0xF3, 0x3F, 0xA1]};
@GUID(0x3E68D4BD, 0x7135, 0x4D10, [0x80, 0x18, 0x9F, 0xB6, 0xD9, 0xF3, 0x3F, 0xA1]);
interface IInitializeWithWindow : IUnknown
{
    HRESULT Initialize(HWND hwnd);
}

const GUID IID_IHandlerInfo = {0x997706EF, 0xF880, 0x453B, [0x81, 0x18, 0x39, 0xE1, 0xA2, 0xD2, 0x65, 0x5A]};
@GUID(0x997706EF, 0xF880, 0x453B, [0x81, 0x18, 0x39, 0xE1, 0xA2, 0xD2, 0x65, 0x5A]);
interface IHandlerInfo : IUnknown
{
    HRESULT GetApplicationDisplayName(ushort** value);
    HRESULT GetApplicationPublisher(ushort** value);
    HRESULT GetApplicationIconReference(ushort** value);
}

const GUID IID_IHandlerInfo2 = {0x31CCA04C, 0x04D3, 0x4EA9, [0x90, 0xDE, 0x97, 0xB1, 0x5E, 0x87, 0xA5, 0x32]};
@GUID(0x31CCA04C, 0x04D3, 0x4EA9, [0x90, 0xDE, 0x97, 0xB1, 0x5E, 0x87, 0xA5, 0x32]);
interface IHandlerInfo2 : IHandlerInfo
{
    HRESULT GetApplicationId(ushort** value);
}

const GUID IID_IHandlerActivationHost = {0x35094A87, 0x8BB1, 0x4237, [0x96, 0xC6, 0xC4, 0x17, 0xEE, 0xBD, 0xB0, 0x78]};
@GUID(0x35094A87, 0x8BB1, 0x4237, [0x96, 0xC6, 0xC4, 0x17, 0xEE, 0xBD, 0xB0, 0x78]);
interface IHandlerActivationHost : IUnknown
{
    HRESULT BeforeCoCreateInstance(const(Guid)* clsidHandler, IShellItemArray itemsBeingActivated, IHandlerInfo handlerInfo);
    HRESULT BeforeCreateProcess(const(wchar)* applicationPath, const(wchar)* commandLine, IHandlerInfo handlerInfo);
}

const GUID IID_IAppActivationUIInfo = {0xABAD189D, 0x9FA3, 0x4278, [0xB3, 0xCA, 0x8C, 0xA4, 0x48, 0xA8, 0x8D, 0xCB]};
@GUID(0xABAD189D, 0x9FA3, 0x4278, [0xB3, 0xCA, 0x8C, 0xA4, 0x48, 0xA8, 0x8D, 0xCB]);
interface IAppActivationUIInfo : IUnknown
{
    HRESULT GetMonitor(int* value);
    HRESULT GetInvokePoint(POINT* value);
    HRESULT GetShowCommand(int* value);
    HRESULT GetShowUI(int* value);
    HRESULT GetKeyState(uint* value);
}

enum FLYOUT_PLACEMENT
{
    FP_DEFAULT = 0,
    FP_ABOVE = 1,
    FP_BELOW = 2,
    FP_LEFT = 3,
    FP_RIGHT = 4,
}

const GUID IID_IContactManagerInterop = {0x99EACBA7, 0xE073, 0x43B6, [0xA8, 0x96, 0x55, 0xAF, 0xE4, 0x8A, 0x08, 0x33]};
@GUID(0x99EACBA7, 0xE073, 0x43B6, [0xA8, 0x96, 0x55, 0xAF, 0xE4, 0x8A, 0x08, 0x33]);
interface IContactManagerInterop : IUnknown
{
    HRESULT ShowContactCardForWindow(HWND appWindow, IUnknown contact, const(RECT)* selection, FLYOUT_PLACEMENT preferredPlacement);
}

const GUID IID_IShellIconOverlayIdentifier = {0x0C6C4200, 0xC589, 0x11D0, [0x99, 0x9A, 0x00, 0xC0, 0x4F, 0xD6, 0x55, 0xE1]};
@GUID(0x0C6C4200, 0xC589, 0x11D0, [0x99, 0x9A, 0x00, 0xC0, 0x4F, 0xD6, 0x55, 0xE1]);
interface IShellIconOverlayIdentifier : IUnknown
{
    HRESULT IsMemberOf(const(wchar)* pwszPath, uint dwAttrib);
    HRESULT GetOverlayInfo(const(wchar)* pwszIconFile, int cchMax, int* pIndex, uint* pdwFlags);
    HRESULT GetPriority(int* pPriority);
}

enum BANNER_NOTIFICATION_EVENT
{
    BNE_Rendered = 0,
    BNE_Hovered = 1,
    BNE_Closed = 2,
    BNE_Dismissed = 3,
    BNE_Button1Clicked = 4,
    BNE_Button2Clicked = 5,
}

struct BANNER_NOTIFICATION
{
    BANNER_NOTIFICATION_EVENT event;
    const(wchar)* providerIdentity;
    const(wchar)* contentId;
}

const GUID IID_IBannerNotificationHandler = {0x8D7B2BA7, 0xDB05, 0x46A8, [0x82, 0x3C, 0xD2, 0xB6, 0xDE, 0x08, 0xEE, 0x91]};
@GUID(0x8D7B2BA7, 0xDB05, 0x46A8, [0x82, 0x3C, 0xD2, 0xB6, 0xDE, 0x08, 0xEE, 0x91]);
interface IBannerNotificationHandler : IUnknown
{
    HRESULT OnBannerEvent(const(BANNER_NOTIFICATION)* notification);
}

enum SORT_ORDER_TYPE
{
    SOT_DEFAULT = 0,
    SOT_IGNORE_FOLDERNESS = 1,
}

const GUID IID_ISortColumnArray = {0x6DFC60FB, 0xF2E9, 0x459B, [0xBE, 0xB5, 0x28, 0x8F, 0x1A, 0x7C, 0x7D, 0x54]};
@GUID(0x6DFC60FB, 0xF2E9, 0x459B, [0xBE, 0xB5, 0x28, 0x8F, 0x1A, 0x7C, 0x7D, 0x54]);
interface ISortColumnArray : IUnknown
{
    HRESULT GetCount(uint* columnCount);
    HRESULT GetAt(uint index, SORTCOLUMN* sortcolumn);
    HRESULT GetSortType(SORT_ORDER_TYPE* type);
}

const GUID IID_IPropertyKeyStore = {0x75BD59AA, 0xF23B, 0x4963, [0xAB, 0xA4, 0x0B, 0x35, 0x57, 0x52, 0xA9, 0x1B]};
@GUID(0x75BD59AA, 0xF23B, 0x4963, [0xAB, 0xA4, 0x0B, 0x35, 0x57, 0x52, 0xA9, 0x1B]);
interface IPropertyKeyStore : IUnknown
{
    HRESULT GetKeyCount(int* keyCount);
    HRESULT GetKeyAt(int index, PROPERTYKEY* pkey);
    HRESULT AppendKey(const(PROPERTYKEY)* key);
    HRESULT DeleteKey(int index);
    HRESULT IsKeyInStore(const(PROPERTYKEY)* key);
    HRESULT RemoveKey(const(PROPERTYKEY)* key);
}

const GUID IID_IQueryCodePage = {0xC7B236CE, 0xEE80, 0x11D0, [0x98, 0x5F, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]};
@GUID(0xC7B236CE, 0xEE80, 0x11D0, [0x98, 0x5F, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]);
interface IQueryCodePage : IUnknown
{
    HRESULT GetCodePage(uint* puiCodePage);
    HRESULT SetCodePage(uint uiCodePage);
}

enum FOLDERVIEWOPTIONS
{
    FVO_DEFAULT = 0,
    FVO_VISTALAYOUT = 1,
    FVO_CUSTOMPOSITION = 2,
    FVO_CUSTOMORDERING = 4,
    FVO_SUPPORTHYPERLINKS = 8,
    FVO_NOANIMATIONS = 16,
    FVO_NOSCROLLTIPS = 32,
}

const GUID IID_IFolderViewOptions = {0x3CC974D2, 0xB302, 0x4D36, [0xAD, 0x3E, 0x06, 0xD9, 0x3F, 0x69, 0x5D, 0x3F]};
@GUID(0x3CC974D2, 0xB302, 0x4D36, [0xAD, 0x3E, 0x06, 0xD9, 0x3F, 0x69, 0x5D, 0x3F]);
interface IFolderViewOptions : IUnknown
{
    HRESULT SetFolderViewOptions(FOLDERVIEWOPTIONS fvoMask, FOLDERVIEWOPTIONS fvoFlags);
    HRESULT GetFolderViewOptions(FOLDERVIEWOPTIONS* pfvoFlags);
}

enum _SV3CVW3_FLAGS
{
    SV3CVW3_DEFAULT = 0,
    SV3CVW3_NONINTERACTIVE = 1,
    SV3CVW3_FORCEVIEWMODE = 2,
    SV3CVW3_FORCEFOLDERFLAGS = 4,
}

const GUID IID_IShellView3 = {0xEC39FA88, 0xF8AF, 0x41C5, [0x84, 0x21, 0x38, 0xBE, 0xD2, 0x8F, 0x46, 0x73]};
@GUID(0xEC39FA88, 0xF8AF, 0x41C5, [0x84, 0x21, 0x38, 0xBE, 0xD2, 0x8F, 0x46, 0x73]);
interface IShellView3 : IShellView2
{
    HRESULT CreateViewWindow3(IShellBrowser psbOwner, IShellView psvPrev, uint dwViewFlags, FOLDERFLAGS dwMask, FOLDERFLAGS dwFlags, FOLDERVIEWMODE fvMode, const(Guid)* pvid, const(RECT)* prcView, HWND* phwndView);
}

const GUID IID_ISearchBoxInfo = {0x6AF6E03F, 0xD664, 0x4EF4, [0x96, 0x26, 0xF7, 0xE0, 0xED, 0x36, 0x75, 0x5E]};
@GUID(0x6AF6E03F, 0xD664, 0x4EF4, [0x96, 0x26, 0xF7, 0xE0, 0xED, 0x36, 0x75, 0x5E]);
interface ISearchBoxInfo : IUnknown
{
    HRESULT GetCondition(const(Guid)* riid, void** ppv);
    HRESULT GetText(ushort** ppsz);
}

enum VPWATERMARKFLAGS
{
    VPWF_DEFAULT = 0,
    VPWF_ALPHABLEND = 1,
}

enum VPCOLORFLAGS
{
    VPCF_TEXT = 1,
    VPCF_BACKGROUND = 2,
    VPCF_SORTCOLUMN = 3,
    VPCF_SUBTEXT = 4,
    VPCF_TEXTBACKGROUND = 5,
}

const GUID IID_IVisualProperties = {0xE693CF68, 0xD967, 0x4112, [0x87, 0x63, 0x99, 0x17, 0x2A, 0xEE, 0x5E, 0x5A]};
@GUID(0xE693CF68, 0xD967, 0x4112, [0x87, 0x63, 0x99, 0x17, 0x2A, 0xEE, 0x5E, 0x5A]);
interface IVisualProperties : IUnknown
{
    HRESULT SetWatermark(HBITMAP hbmp, VPWATERMARKFLAGS vpwf);
    HRESULT SetColor(VPCOLORFLAGS vpcf, uint cr);
    HRESULT GetColor(VPCOLORFLAGS vpcf, uint* pcr);
    HRESULT SetItemHeight(int cyItemInPixels);
    HRESULT GetItemHeight(int* cyItemInPixels);
    HRESULT SetFont(const(LOGFONTW)* plf, BOOL bRedraw);
    HRESULT GetFont(LOGFONTW* plf);
    HRESULT SetTheme(const(wchar)* pszSubAppName, const(wchar)* pszSubIdList);
}

const GUID IID_ICommDlgBrowser3 = {0xC8AD25A1, 0x3294, 0x41EE, [0x81, 0x65, 0x71, 0x17, 0x4B, 0xD0, 0x1C, 0x57]};
@GUID(0xC8AD25A1, 0x3294, 0x41EE, [0x81, 0x65, 0x71, 0x17, 0x4B, 0xD0, 0x1C, 0x57]);
interface ICommDlgBrowser3 : ICommDlgBrowser2
{
    HRESULT OnColumnClicked(IShellView ppshv, int iColumn);
    HRESULT GetCurrentFilter(const(wchar)* pszFileSpec, int cchFileSpec);
    HRESULT OnPreViewCreated(IShellView ppshv);
}

const GUID IID_IUserAccountChangeCallback = {0xA561E69A, 0xB4B8, 0x4113, [0x91, 0xA5, 0x64, 0xC6, 0xBC, 0xCA, 0x34, 0x30]};
@GUID(0xA561E69A, 0xB4B8, 0x4113, [0x91, 0xA5, 0x64, 0xC6, 0xBC, 0xCA, 0x34, 0x30]);
interface IUserAccountChangeCallback : IUnknown
{
    HRESULT OnPictureChange(const(wchar)* pszUserName);
}

const GUID IID_IStreamAsync = {0xFE0B6665, 0xE0CA, 0x49B9, [0xA1, 0x78, 0x2B, 0x5C, 0xB4, 0x8D, 0x92, 0xA5]};
@GUID(0xFE0B6665, 0xE0CA, 0x49B9, [0xA1, 0x78, 0x2B, 0x5C, 0xB4, 0x8D, 0x92, 0xA5]);
interface IStreamAsync : IStream
{
    HRESULT ReadAsync(char* pv, uint cb, uint* pcbRead, OVERLAPPED* lpOverlapped);
    HRESULT WriteAsync(char* lpBuffer, uint cb, uint* pcbWritten, OVERLAPPED* lpOverlapped);
    HRESULT OverlappedResult(OVERLAPPED* lpOverlapped, uint* lpNumberOfBytesTransferred, BOOL bWait);
    HRESULT CancelIo();
}

const GUID IID_IStreamUnbufferedInfo = {0x8A68FDDA, 0x1FDC, 0x4C20, [0x8C, 0xEB, 0x41, 0x66, 0x43, 0xB5, 0xA6, 0x25]};
@GUID(0x8A68FDDA, 0x1FDC, 0x4C20, [0x8C, 0xEB, 0x41, 0x66, 0x43, 0xB5, 0xA6, 0x25]);
interface IStreamUnbufferedInfo : IUnknown
{
    HRESULT GetSectorSize(uint* pcbSectorSize);
}

enum DSH_FLAGS
{
    DSH_ALLOWDROPDESCRIPTIONTEXT = 1,
}

const GUID IID_IDragSourceHelper2 = {0x83E07D0D, 0x0C5F, 0x4163, [0xBF, 0x1A, 0x60, 0xB2, 0x74, 0x05, 0x1E, 0x40]};
@GUID(0x83E07D0D, 0x0C5F, 0x4163, [0xBF, 0x1A, 0x60, 0xB2, 0x74, 0x05, 0x1E, 0x40]);
interface IDragSourceHelper2 : IDragSourceHelper
{
    HRESULT SetFlags(uint dwFlags);
}

const GUID IID_IHWEventHandler = {0xC1FB73D0, 0xEC3A, 0x4BA2, [0xB5, 0x12, 0x8C, 0xDB, 0x91, 0x87, 0xB6, 0xD1]};
@GUID(0xC1FB73D0, 0xEC3A, 0x4BA2, [0xB5, 0x12, 0x8C, 0xDB, 0x91, 0x87, 0xB6, 0xD1]);
interface IHWEventHandler : IUnknown
{
    HRESULT Initialize(const(wchar)* pszParams);
    HRESULT HandleEvent(const(wchar)* pszDeviceID, const(wchar)* pszAltDeviceID, const(wchar)* pszEventType);
    HRESULT HandleEventWithContent(const(wchar)* pszDeviceID, const(wchar)* pszAltDeviceID, const(wchar)* pszEventType, const(wchar)* pszContentTypeHandler, IDataObject pdataobject);
}

const GUID IID_IHWEventHandler2 = {0xCFCC809F, 0x295D, 0x42E8, [0x9F, 0xFC, 0x42, 0x4B, 0x33, 0xC4, 0x87, 0xE6]};
@GUID(0xCFCC809F, 0x295D, 0x42E8, [0x9F, 0xFC, 0x42, 0x4B, 0x33, 0xC4, 0x87, 0xE6]);
interface IHWEventHandler2 : IHWEventHandler
{
    HRESULT HandleEventWithHWND(const(wchar)* pszDeviceID, const(wchar)* pszAltDeviceID, const(wchar)* pszEventType, HWND hwndOwner);
}

const GUID IID_IQueryCancelAutoPlay = {0xDDEFE873, 0x6997, 0x4E68, [0xBE, 0x26, 0x39, 0xB6, 0x33, 0xAD, 0xBE, 0x12]};
@GUID(0xDDEFE873, 0x6997, 0x4E68, [0xBE, 0x26, 0x39, 0xB6, 0x33, 0xAD, 0xBE, 0x12]);
interface IQueryCancelAutoPlay : IUnknown
{
    HRESULT AllowAutoPlay(const(wchar)* pszPath, uint dwContentType, const(wchar)* pszLabel, uint dwSerialNumber);
}

const GUID IID_IDynamicHWHandler = {0xDC2601D7, 0x059E, 0x42FC, [0xA0, 0x9D, 0x2A, 0xFD, 0x21, 0xB6, 0xD5, 0xF7]};
@GUID(0xDC2601D7, 0x059E, 0x42FC, [0xA0, 0x9D, 0x2A, 0xFD, 0x21, 0xB6, 0xD5, 0xF7]);
interface IDynamicHWHandler : IUnknown
{
    HRESULT GetDynamicInfo(const(wchar)* pszDeviceID, uint dwContentType, ushort** ppszAction);
}

const GUID IID_IUserNotificationCallback = {0x19108294, 0x0441, 0x4AFF, [0x80, 0x13, 0xFA, 0x0A, 0x73, 0x0B, 0x0B, 0xEA]};
@GUID(0x19108294, 0x0441, 0x4AFF, [0x80, 0x13, 0xFA, 0x0A, 0x73, 0x0B, 0x0B, 0xEA]);
interface IUserNotificationCallback : IUnknown
{
    HRESULT OnBalloonUserClick(POINT* pt);
    HRESULT OnLeftClick(POINT* pt);
    HRESULT OnContextMenu(POINT* pt);
}

const GUID IID_IUserNotification2 = {0x215913CC, 0x57EB, 0x4FAB, [0xAB, 0x5A, 0xE5, 0xFA, 0x7B, 0xEA, 0x2A, 0x6C]};
@GUID(0x215913CC, 0x57EB, 0x4FAB, [0xAB, 0x5A, 0xE5, 0xFA, 0x7B, 0xEA, 0x2A, 0x6C]);
interface IUserNotification2 : IUnknown
{
    HRESULT SetBalloonInfo(const(wchar)* pszTitle, const(wchar)* pszText, uint dwInfoFlags);
    HRESULT SetBalloonRetry(uint dwShowTime, uint dwInterval, uint cRetryCount);
    HRESULT SetIconInfo(HICON hIcon, const(wchar)* pszToolTip);
    HRESULT Show(IQueryContinue pqc, uint dwContinuePollInterval, IUserNotificationCallback pSink);
    HRESULT PlaySoundA(const(wchar)* pszSoundName);
}

const GUID IID_IDeskBand2 = {0x79D16DE4, 0xABEE, 0x4021, [0x8D, 0x9D, 0x91, 0x69, 0xB2, 0x61, 0xD6, 0x57]};
@GUID(0x79D16DE4, 0xABEE, 0x4021, [0x8D, 0x9D, 0x91, 0x69, 0xB2, 0x61, 0xD6, 0x57]);
interface IDeskBand2 : IDeskBand
{
    HRESULT CanRenderComposited(int* pfCanRenderComposited);
    HRESULT SetCompositionState(BOOL fCompositionEnabled);
    HRESULT GetCompositionState(int* pfCompositionEnabled);
}

const GUID IID_IStartMenuPinnedList = {0x4CD19ADA, 0x25A5, 0x4A32, [0xB3, 0xB7, 0x34, 0x7B, 0xEE, 0x5B, 0xE3, 0x6B]};
@GUID(0x4CD19ADA, 0x25A5, 0x4A32, [0xB3, 0xB7, 0x34, 0x7B, 0xEE, 0x5B, 0xE3, 0x6B]);
interface IStartMenuPinnedList : IUnknown
{
    HRESULT RemoveFromList(IShellItem pitem);
}

const GUID IID_ICDBurn = {0x3D73A659, 0xE5D0, 0x4D42, [0xAF, 0xC0, 0x51, 0x21, 0xBA, 0x42, 0x5C, 0x8D]};
@GUID(0x3D73A659, 0xE5D0, 0x4D42, [0xAF, 0xC0, 0x51, 0x21, 0xBA, 0x42, 0x5C, 0x8D]);
interface ICDBurn : IUnknown
{
    HRESULT GetRecorderDriveLetter(const(wchar)* pszDrive, uint cch);
    HRESULT Burn(HWND hwnd);
    HRESULT HasRecordableDrive(int* pfHasRecorder);
}

const GUID IID_IWizardSite = {0x88960F5B, 0x422F, 0x4E7B, [0x80, 0x13, 0x73, 0x41, 0x53, 0x81, 0xC3, 0xC3]};
@GUID(0x88960F5B, 0x422F, 0x4E7B, [0x80, 0x13, 0x73, 0x41, 0x53, 0x81, 0xC3, 0xC3]);
interface IWizardSite : IUnknown
{
    HRESULT GetPreviousPage(HPROPSHEETPAGE* phpage);
    HRESULT GetNextPage(HPROPSHEETPAGE* phpage);
    HRESULT GetCancelledPage(HPROPSHEETPAGE* phpage);
}

const GUID IID_IWizardExtension = {0xC02EA696, 0x86CC, 0x491E, [0x9B, 0x23, 0x74, 0x39, 0x4A, 0x04, 0x44, 0xA8]};
@GUID(0xC02EA696, 0x86CC, 0x491E, [0x9B, 0x23, 0x74, 0x39, 0x4A, 0x04, 0x44, 0xA8]);
interface IWizardExtension : IUnknown
{
    HRESULT AddPages(char* aPages, uint cPages, uint* pnPagesAdded);
    HRESULT GetFirstPage(HPROPSHEETPAGE* phpage);
    HRESULT GetLastPage(HPROPSHEETPAGE* phpage);
}

const GUID IID_IWebWizardExtension = {0x0E6B3F66, 0x98D1, 0x48C0, [0xA2, 0x22, 0xFB, 0xDE, 0x74, 0xE2, 0xFB, 0xC5]};
@GUID(0x0E6B3F66, 0x98D1, 0x48C0, [0xA2, 0x22, 0xFB, 0xDE, 0x74, 0xE2, 0xFB, 0xC5]);
interface IWebWizardExtension : IWizardExtension
{
    HRESULT SetInitialURL(const(wchar)* pszURL);
    HRESULT SetErrorURL(const(wchar)* pszErrorURL);
}

const GUID IID_IPublishingWizard = {0xAA9198BB, 0xCCEC, 0x472D, [0xBE, 0xED, 0x19, 0xA4, 0xF6, 0x73, 0x3F, 0x7A]};
@GUID(0xAA9198BB, 0xCCEC, 0x472D, [0xBE, 0xED, 0x19, 0xA4, 0xF6, 0x73, 0x3F, 0x7A]);
interface IPublishingWizard : IWizardExtension
{
    HRESULT Initialize(IDataObject pdo, uint dwOptions, const(wchar)* pszServiceScope);
    HRESULT GetTransferManifest(int* phrFromTransfer, IXMLDOMDocument* pdocManifest);
}

const GUID IID_IFolderViewHost = {0x1EA58F02, 0xD55A, 0x411D, [0xB0, 0x9E, 0x9E, 0x65, 0xAC, 0x21, 0x60, 0x5B]};
@GUID(0x1EA58F02, 0xD55A, 0x411D, [0xB0, 0x9E, 0x9E, 0x65, 0xAC, 0x21, 0x60, 0x5B]);
interface IFolderViewHost : IUnknown
{
    HRESULT Initialize(HWND hwndParent, IDataObject pdo, RECT* prc);
}

const GUID IID_IAccessibleObject = {0x95A391C5, 0x9ED4, 0x4C28, [0x84, 0x01, 0xAB, 0x9E, 0x06, 0x71, 0x9E, 0x11]};
@GUID(0x95A391C5, 0x9ED4, 0x4C28, [0x84, 0x01, 0xAB, 0x9E, 0x06, 0x71, 0x9E, 0x11]);
interface IAccessibleObject : IUnknown
{
    HRESULT SetAccessibleName(const(wchar)* pszName);
}

const GUID IID_IResultsFolder = {0x96E5AE6D, 0x6AE1, 0x4B1C, [0x90, 0x0C, 0xC6, 0x48, 0x0E, 0xAA, 0x88, 0x28]};
@GUID(0x96E5AE6D, 0x6AE1, 0x4B1C, [0x90, 0x0C, 0xC6, 0x48, 0x0E, 0xAA, 0x88, 0x28]);
interface IResultsFolder : IUnknown
{
    HRESULT AddItem(IShellItem psi);
    HRESULT AddIDList(ITEMIDLIST* pidl, ITEMIDLIST** ppidlAdded);
    HRESULT RemoveItem(IShellItem psi);
    HRESULT RemoveIDList(ITEMIDLIST* pidl);
    HRESULT RemoveAll();
}

const GUID IID_IAutoCompleteDropDown = {0x3CD141F4, 0x3C6A, 0x11D2, [0xBC, 0xAA, 0x00, 0xC0, 0x4F, 0xD9, 0x29, 0xDB]};
@GUID(0x3CD141F4, 0x3C6A, 0x11D2, [0xBC, 0xAA, 0x00, 0xC0, 0x4F, 0xD9, 0x29, 0xDB]);
interface IAutoCompleteDropDown : IUnknown
{
    HRESULT GetDropDownStatus(uint* pdwFlags, ushort** ppwszString);
    HRESULT ResetEnumerator();
}

enum tagCDBURNINGEXTENSIONRET
{
    CDBE_RET_DEFAULT = 0,
    CDBE_RET_DONTRUNOTHEREXTS = 1,
    CDBE_RET_STOPWIZARD = 2,
}

enum _CDBE_ACTIONS
{
    CDBE_TYPE_MUSIC = 1,
    CDBE_TYPE_DATA = 2,
    CDBE_TYPE_ALL = -1,
}

const GUID IID_ICDBurnExt = {0x2271DCCA, 0x74FC, 0x4414, [0x8F, 0xB7, 0xC5, 0x6B, 0x05, 0xAC, 0xE2, 0xD7]};
@GUID(0x2271DCCA, 0x74FC, 0x4414, [0x8F, 0xB7, 0xC5, 0x6B, 0x05, 0xAC, 0xE2, 0xD7]);
interface ICDBurnExt : IUnknown
{
    HRESULT GetSupportedActionTypes(uint* pdwActions);
}

const GUID IID_IEnumReadyCallback = {0x61E00D45, 0x8FFF, 0x4E60, [0x92, 0x4E, 0x65, 0x37, 0xB6, 0x16, 0x12, 0xDD]};
@GUID(0x61E00D45, 0x8FFF, 0x4E60, [0x92, 0x4E, 0x65, 0x37, 0xB6, 0x16, 0x12, 0xDD]);
interface IEnumReadyCallback : IUnknown
{
    HRESULT EnumReady();
}

const GUID IID_IEnumerableView = {0x8C8BF236, 0x1AEC, 0x495F, [0x98, 0x94, 0x91, 0xD5, 0x7C, 0x3C, 0x68, 0x6F]};
@GUID(0x8C8BF236, 0x1AEC, 0x495F, [0x98, 0x94, 0x91, 0xD5, 0x7C, 0x3C, 0x68, 0x6F]);
interface IEnumerableView : IUnknown
{
    HRESULT SetEnumReadyCallback(IEnumReadyCallback percb);
    HRESULT CreateEnumIDListFromContents(ITEMIDLIST* pidlFolder, uint dwEnumFlags, IEnumIDList* ppEnumIDList);
}

const GUID IID_IInsertItem = {0xD2B57227, 0x3D23, 0x4B95, [0x93, 0xC0, 0x49, 0x2B, 0xD4, 0x54, 0xC3, 0x56]};
@GUID(0xD2B57227, 0x3D23, 0x4B95, [0x93, 0xC0, 0x49, 0x2B, 0xD4, 0x54, 0xC3, 0x56]);
interface IInsertItem : IUnknown
{
    HRESULT InsertItem(ITEMIDLIST* pidl);
}

const GUID IID_IFolderBandPriv = {0x47C01F95, 0xE185, 0x412C, [0xB5, 0xC5, 0x4F, 0x27, 0xDF, 0x96, 0x5A, 0xEA]};
@GUID(0x47C01F95, 0xE185, 0x412C, [0xB5, 0xC5, 0x4F, 0x27, 0xDF, 0x96, 0x5A, 0xEA]);
interface IFolderBandPriv : IUnknown
{
    HRESULT SetCascade(BOOL fCascade);
    HRESULT SetAccelerators(BOOL fAccelerators);
    HRESULT SetNoIcons(BOOL fNoIcons);
    HRESULT SetNoText(BOOL fNoText);
}

const GUID IID_IImageRecompress = {0x505F1513, 0x6B3E, 0x4892, [0xA2, 0x72, 0x59, 0xF8, 0x88, 0x9A, 0x4D, 0x3E]};
@GUID(0x505F1513, 0x6B3E, 0x4892, [0xA2, 0x72, 0x59, 0xF8, 0x88, 0x9A, 0x4D, 0x3E]);
interface IImageRecompress : IUnknown
{
    HRESULT RecompressImage(IShellItem psi, int cx, int cy, int iQuality, IStorage pstg, IStream* ppstrmOut);
}

const GUID IID_IFileDialogControlEvents = {0x36116642, 0xD713, 0x4B97, [0x9B, 0x83, 0x74, 0x84, 0xA9, 0xD0, 0x04, 0x33]};
@GUID(0x36116642, 0xD713, 0x4B97, [0x9B, 0x83, 0x74, 0x84, 0xA9, 0xD0, 0x04, 0x33]);
interface IFileDialogControlEvents : IUnknown
{
    HRESULT OnItemSelected(IFileDialogCustomize pfdc, uint dwIDCtl, uint dwIDItem);
    HRESULT OnButtonClicked(IFileDialogCustomize pfdc, uint dwIDCtl);
    HRESULT OnCheckButtonToggled(IFileDialogCustomize pfdc, uint dwIDCtl, BOOL bChecked);
    HRESULT OnControlActivating(IFileDialogCustomize pfdc, uint dwIDCtl);
}

const GUID IID_IFileDialog2 = {0x61744FC7, 0x85B5, 0x4791, [0xA9, 0xB0, 0x27, 0x22, 0x76, 0x30, 0x9B, 0x13]};
@GUID(0x61744FC7, 0x85B5, 0x4791, [0xA9, 0xB0, 0x27, 0x22, 0x76, 0x30, 0x9B, 0x13]);
interface IFileDialog2 : IFileDialog
{
    HRESULT SetCancelButtonLabel(const(wchar)* pszLabel);
    HRESULT SetNavigationRoot(IShellItem psi);
}

const GUID IID_IApplicationAssociationRegistrationUI = {0x1F76A169, 0xF994, 0x40AC, [0x8F, 0xC8, 0x09, 0x59, 0xE8, 0x87, 0x47, 0x10]};
@GUID(0x1F76A169, 0xF994, 0x40AC, [0x8F, 0xC8, 0x09, 0x59, 0xE8, 0x87, 0x47, 0x10]);
interface IApplicationAssociationRegistrationUI : IUnknown
{
    HRESULT LaunchAdvancedAssociationUI(const(wchar)* pszAppRegistryName);
}

const GUID IID_IShellRunDll = {0xFCE4BDE0, 0x4B68, 0x4B80, [0x8E, 0x9C, 0x74, 0x26, 0x31, 0x5A, 0x73, 0x88]};
@GUID(0xFCE4BDE0, 0x4B68, 0x4B80, [0x8E, 0x9C, 0x74, 0x26, 0x31, 0x5A, 0x73, 0x88]);
interface IShellRunDll : IUnknown
{
    HRESULT Run(const(wchar)* pszArgs);
}

const GUID IID_IPreviousVersionsInfo = {0x76E54780, 0xAD74, 0x48E3, [0xA6, 0x95, 0x3B, 0xA9, 0xA0, 0xAF, 0xF1, 0x0D]};
@GUID(0x76E54780, 0xAD74, 0x48E3, [0xA6, 0x95, 0x3B, 0xA9, 0xA0, 0xAF, 0xF1, 0x0D]);
interface IPreviousVersionsInfo : IUnknown
{
    HRESULT AreSnapshotsAvailable(const(wchar)* pszPath, BOOL fOkToBeSlow, int* pfAvailable);
}

const GUID IID_IUseToBrowseItem = {0x05EDDA5C, 0x98A3, 0x4717, [0x8A, 0xDB, 0xC5, 0xE7, 0xDA, 0x99, 0x1E, 0xB1]};
@GUID(0x05EDDA5C, 0x98A3, 0x4717, [0x8A, 0xDB, 0xC5, 0xE7, 0xDA, 0x99, 0x1E, 0xB1]);
interface IUseToBrowseItem : IRelatedItem
{
}

enum NSTCSTYLE2
{
    NSTCS2_DEFAULT = 0,
    NSTCS2_INTERRUPTNOTIFICATIONS = 1,
    NSTCS2_SHOWNULLSPACEMENU = 2,
    NSTCS2_DISPLAYPADDING = 4,
    NSTCS2_DISPLAYPINNEDONLY = 8,
    NTSCS2_NOSINGLETONAUTOEXPAND = 16,
    NTSCS2_NEVERINSERTNONENUMERATED = 32,
}

const GUID IID_INameSpaceTreeControl2 = {0x7CC7AED8, 0x290E, 0x49BC, [0x89, 0x45, 0xC1, 0x40, 0x1C, 0xC9, 0x30, 0x6C]};
@GUID(0x7CC7AED8, 0x290E, 0x49BC, [0x89, 0x45, 0xC1, 0x40, 0x1C, 0xC9, 0x30, 0x6C]);
interface INameSpaceTreeControl2 : INameSpaceTreeControl
{
    HRESULT SetControlStyle(uint nstcsMask, uint nstcsStyle);
    HRESULT GetControlStyle(uint nstcsMask, uint* pnstcsStyle);
    HRESULT SetControlStyle2(NSTCSTYLE2 nstcsMask, NSTCSTYLE2 nstcsStyle);
    HRESULT GetControlStyle2(NSTCSTYLE2 nstcsMask, NSTCSTYLE2* pnstcsStyle);
}

enum _NSTCEHITTEST
{
    NSTCEHT_NOWHERE = 1,
    NSTCEHT_ONITEMICON = 2,
    NSTCEHT_ONITEMLABEL = 4,
    NSTCEHT_ONITEMINDENT = 8,
    NSTCEHT_ONITEMBUTTON = 16,
    NSTCEHT_ONITEMRIGHT = 32,
    NSTCEHT_ONITEMSTATEICON = 64,
    NSTCEHT_ONITEM = 70,
    NSTCEHT_ONITEMTABBUTTON = 4096,
}

enum _NSTCECLICKTYPE
{
    NSTCECT_LBUTTON = 1,
    NSTCECT_MBUTTON = 2,
    NSTCECT_RBUTTON = 3,
    NSTCECT_BUTTON = 3,
    NSTCECT_DBLCLICK = 4,
}

const GUID IID_INameSpaceTreeControlEvents = {0x93D77985, 0xB3D8, 0x4484, [0x83, 0x18, 0x67, 0x2C, 0xDD, 0xA0, 0x02, 0xCE]};
@GUID(0x93D77985, 0xB3D8, 0x4484, [0x83, 0x18, 0x67, 0x2C, 0xDD, 0xA0, 0x02, 0xCE]);
interface INameSpaceTreeControlEvents : IUnknown
{
    HRESULT OnItemClick(IShellItem psi, uint nstceHitTest, uint nstceClickType);
    HRESULT OnPropertyItemCommit(IShellItem psi);
    HRESULT OnItemStateChanging(IShellItem psi, uint nstcisMask, uint nstcisState);
    HRESULT OnItemStateChanged(IShellItem psi, uint nstcisMask, uint nstcisState);
    HRESULT OnSelectionChanged(IShellItemArray psiaSelection);
    HRESULT OnKeyboardInput(uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT OnBeforeExpand(IShellItem psi);
    HRESULT OnAfterExpand(IShellItem psi);
    HRESULT OnBeginLabelEdit(IShellItem psi);
    HRESULT OnEndLabelEdit(IShellItem psi);
    HRESULT OnGetToolTip(IShellItem psi, const(wchar)* pszTip, int cchTip);
    HRESULT OnBeforeItemDelete(IShellItem psi);
    HRESULT OnItemAdded(IShellItem psi, BOOL fIsRoot);
    HRESULT OnItemDeleted(IShellItem psi, BOOL fIsRoot);
    HRESULT OnBeforeContextMenu(IShellItem psi, const(Guid)* riid, void** ppv);
    HRESULT OnAfterContextMenu(IShellItem psi, IContextMenu pcmIn, const(Guid)* riid, void** ppv);
    HRESULT OnBeforeStateImageChange(IShellItem psi);
    HRESULT OnGetDefaultIconIndex(IShellItem psi, int* piDefaultIcon, int* piOpenIcon);
}

const GUID IID_INameSpaceTreeControlDropHandler = {0xF9C665D6, 0xC2F2, 0x4C19, [0xBF, 0x33, 0x83, 0x22, 0xD7, 0x35, 0x2F, 0x51]};
@GUID(0xF9C665D6, 0xC2F2, 0x4C19, [0xBF, 0x33, 0x83, 0x22, 0xD7, 0x35, 0x2F, 0x51]);
interface INameSpaceTreeControlDropHandler : IUnknown
{
    HRESULT OnDragEnter(IShellItem psiOver, IShellItemArray psiaData, BOOL fOutsideSource, uint grfKeyState, uint* pdwEffect);
    HRESULT OnDragOver(IShellItem psiOver, IShellItemArray psiaData, uint grfKeyState, uint* pdwEffect);
    HRESULT OnDragPosition(IShellItem psiOver, IShellItemArray psiaData, int iNewPosition, int iOldPosition);
    HRESULT OnDrop(IShellItem psiOver, IShellItemArray psiaData, int iPosition, uint grfKeyState, uint* pdwEffect);
    HRESULT OnDropPosition(IShellItem psiOver, IShellItemArray psiaData, int iNewPosition, int iOldPosition);
    HRESULT OnDragLeave(IShellItem psiOver);
}

const GUID IID_INameSpaceTreeAccessible = {0x71F312DE, 0x43ED, 0x4190, [0x84, 0x77, 0xE9, 0x53, 0x6B, 0x82, 0x35, 0x0B]};
@GUID(0x71F312DE, 0x43ED, 0x4190, [0x84, 0x77, 0xE9, 0x53, 0x6B, 0x82, 0x35, 0x0B]);
interface INameSpaceTreeAccessible : IUnknown
{
    HRESULT OnGetDefaultAccessibilityAction(IShellItem psi, BSTR* pbstrDefaultAction);
    HRESULT OnDoDefaultAccessibilityAction(IShellItem psi);
    HRESULT OnGetAccessibilityRole(IShellItem psi, VARIANT* pvarRole);
}

struct NSTCCUSTOMDRAW
{
    IShellItem psi;
    uint uItemState;
    uint nstcis;
    const(wchar)* pszText;
    int iImage;
    HIMAGELIST himl;
    int iLevel;
    int iIndent;
}

const GUID IID_INameSpaceTreeControlCustomDraw = {0x2D3BA758, 0x33EE, 0x42D5, [0xBB, 0x7B, 0x5F, 0x34, 0x31, 0xD8, 0x6C, 0x78]};
@GUID(0x2D3BA758, 0x33EE, 0x42D5, [0xBB, 0x7B, 0x5F, 0x34, 0x31, 0xD8, 0x6C, 0x78]);
interface INameSpaceTreeControlCustomDraw : IUnknown
{
    HRESULT PrePaint(HDC hdc, RECT* prc, LRESULT* plres);
    HRESULT PostPaint(HDC hdc, RECT* prc);
    HRESULT ItemPrePaint(HDC hdc, RECT* prc, NSTCCUSTOMDRAW* pnstccdItem, uint* pclrText, uint* pclrTextBk, LRESULT* plres);
    HRESULT ItemPostPaint(HDC hdc, RECT* prc, NSTCCUSTOMDRAW* pnstccdItem);
}

const GUID IID_ITrayDeskBand = {0x6D67E846, 0x5B9C, 0x4DB8, [0x9C, 0xBC, 0xDD, 0xE1, 0x2F, 0x42, 0x54, 0xF1]};
@GUID(0x6D67E846, 0x5B9C, 0x4DB8, [0x9C, 0xBC, 0xDD, 0xE1, 0x2F, 0x42, 0x54, 0xF1]);
interface ITrayDeskBand : IUnknown
{
    HRESULT ShowDeskBand(const(Guid)* clsid);
    HRESULT HideDeskBand(const(Guid)* clsid);
    HRESULT IsDeskBandShown(const(Guid)* clsid);
    HRESULT DeskBandRegistrationChanged();
}

const GUID IID_IBandHost = {0xB9075C7C, 0xD48E, 0x403F, [0xAB, 0x99, 0xD6, 0xC7, 0x7A, 0x10, 0x84, 0xAC]};
@GUID(0xB9075C7C, 0xD48E, 0x403F, [0xAB, 0x99, 0xD6, 0xC7, 0x7A, 0x10, 0x84, 0xAC]);
interface IBandHost : IUnknown
{
    HRESULT CreateBand(const(Guid)* rclsidBand, BOOL fAvailable, BOOL fVisible, const(Guid)* riid, void** ppv);
    HRESULT SetBandAvailability(const(Guid)* rclsidBand, BOOL fAvailable);
    HRESULT DestroyBand(const(Guid)* rclsidBand);
}

const GUID IID_IComputerInfoChangeNotify = {0x0DF60D92, 0x6818, 0x46D6, [0xB3, 0x58, 0xD6, 0x61, 0x70, 0xDD, 0xE4, 0x66]};
@GUID(0x0DF60D92, 0x6818, 0x46D6, [0xB3, 0x58, 0xD6, 0x61, 0x70, 0xDD, 0xE4, 0x66]);
interface IComputerInfoChangeNotify : IUnknown
{
    HRESULT ComputerInfoChanged();
}

const GUID IID_IDesktopGadget = {0xC1646BC4, 0xF298, 0x4F91, [0xA2, 0x04, 0xEB, 0x2D, 0xD1, 0x70, 0x9D, 0x1A]};
@GUID(0xC1646BC4, 0xF298, 0x4F91, [0xA2, 0x04, 0xEB, 0x2D, 0xD1, 0x70, 0x9D, 0x1A]);
interface IDesktopGadget : IUnknown
{
    HRESULT RunGadget(const(wchar)* gadgetPath);
}

enum UNDOCK_REASON
{
    UR_RESOLUTION_CHANGE = 0,
    UR_MONITOR_DISCONNECT = 1,
}

const GUID IID_IStorageProviderBanners = {0x5EFB46D7, 0x47C0, 0x4B68, [0xAC, 0xDA, 0xDE, 0xD4, 0x7C, 0x90, 0xEC, 0x91]};
@GUID(0x5EFB46D7, 0x47C0, 0x4B68, [0xAC, 0xDA, 0xDE, 0xD4, 0x7C, 0x90, 0xEC, 0x91]);
interface IStorageProviderBanners : IUnknown
{
    HRESULT SetBanner(const(wchar)* providerIdentity, const(wchar)* subscriptionId, const(wchar)* contentId);
    HRESULT ClearBanner(const(wchar)* providerIdentity, const(wchar)* subscriptionId);
    HRESULT ClearAllBanners(const(wchar)* providerIdentity);
    HRESULT GetBanner(const(wchar)* providerIdentity, const(wchar)* subscriptionId, ushort** contentId);
}

const GUID CLSID_ShellFolderViewOC = {0x9BA05971, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]};
@GUID(0x9BA05971, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]);
struct ShellFolderViewOC;

const GUID CLSID_ShellFolderItem = {0x2FE352EA, 0xFD1F, 0x11D2, [0xB1, 0xF4, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]};
@GUID(0x2FE352EA, 0xFD1F, 0x11D2, [0xB1, 0xF4, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]);
struct ShellFolderItem;

const GUID CLSID_ShellLinkObject = {0x11219420, 0x1768, 0x11D1, [0x95, 0xBE, 0x00, 0x60, 0x97, 0x97, 0xEA, 0x4F]};
@GUID(0x11219420, 0x1768, 0x11D1, [0x95, 0xBE, 0x00, 0x60, 0x97, 0x97, 0xEA, 0x4F]);
struct ShellLinkObject;

const GUID CLSID_ShellFolderView = {0x62112AA1, 0xEBE4, 0x11CF, [0xA5, 0xFB, 0x00, 0x20, 0xAF, 0xE7, 0x29, 0x2D]};
@GUID(0x62112AA1, 0xEBE4, 0x11CF, [0xA5, 0xFB, 0x00, 0x20, 0xAF, 0xE7, 0x29, 0x2D]);
struct ShellFolderView;

const GUID CLSID_Shell = {0x13709620, 0xC279, 0x11CE, [0xA4, 0x9E, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x13709620, 0xC279, 0x11CE, [0xA4, 0x9E, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct Shell;

const GUID CLSID_ShellDispatchInproc = {0x0A89A860, 0xD7B1, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x0A89A860, 0xD7B1, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
struct ShellDispatchInproc;

const GUID CLSID_FileSearchBand = {0xC4EE31F3, 0x4768, 0x11D2, [0xBE, 0x5C, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]};
@GUID(0xC4EE31F3, 0x4768, 0x11D2, [0xBE, 0x5C, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]);
struct FileSearchBand;

enum OfflineFolderStatus
{
    OFS_INACTIVE = -1,
    OFS_ONLINE = 0,
    OFS_OFFLINE = 1,
    OFS_SERVERBACK = 2,
    OFS_DIRTYCACHE = 3,
}

enum ShellFolderViewOptions
{
    SFVVO_SHOWALLOBJECTS = 1,
    SFVVO_SHOWEXTENSIONS = 2,
    SFVVO_SHOWCOMPCOLOR = 8,
    SFVVO_SHOWSYSFILES = 32,
    SFVVO_WIN95CLASSIC = 64,
    SFVVO_DOUBLECLICKINWEBVIEW = 128,
    SFVVO_DESKTOPHTML = 512,
}

enum ShellSpecialFolderConstants
{
    ssfDESKTOP = 0,
    ssfPROGRAMS = 2,
    ssfCONTROLS = 3,
    ssfPRINTERS = 4,
    ssfPERSONAL = 5,
    ssfFAVORITES = 6,
    ssfSTARTUP = 7,
    ssfRECENT = 8,
    ssfSENDTO = 9,
    ssfBITBUCKET = 10,
    ssfSTARTMENU = 11,
    ssfDESKTOPDIRECTORY = 16,
    ssfDRIVES = 17,
    ssfNETWORK = 18,
    ssfNETHOOD = 19,
    ssfFONTS = 20,
    ssfTEMPLATES = 21,
    ssfCOMMONSTARTMENU = 22,
    ssfCOMMONPROGRAMS = 23,
    ssfCOMMONSTARTUP = 24,
    ssfCOMMONDESKTOPDIR = 25,
    ssfAPPDATA = 26,
    ssfPRINTHOOD = 27,
    ssfLOCALAPPDATA = 28,
    ssfALTSTARTUP = 29,
    ssfCOMMONALTSTARTUP = 30,
    ssfCOMMONFAVORITES = 31,
    ssfINTERNETCACHE = 32,
    ssfCOOKIES = 33,
    ssfHISTORY = 34,
    ssfCOMMONAPPDATA = 35,
    ssfWINDOWS = 36,
    ssfSYSTEM = 37,
    ssfPROGRAMFILES = 38,
    ssfMYPICTURES = 39,
    ssfPROFILE = 40,
    ssfSYSTEMx86 = 41,
    ssfPROGRAMFILESx86 = 48,
}

const GUID IID_IFolderViewOC = {0x9BA05970, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]};
@GUID(0x9BA05970, 0xF6A8, 0x11CF, [0xA4, 0x42, 0x00, 0xA0, 0xC9, 0x0A, 0x8F, 0x39]);
interface IFolderViewOC : IDispatch
{
    HRESULT SetFolderView(IDispatch pdisp);
}

const GUID IID_DShellFolderViewEvents = {0x62112AA2, 0xEBE4, 0x11CF, [0xA5, 0xFB, 0x00, 0x20, 0xAF, 0xE7, 0x29, 0x2D]};
@GUID(0x62112AA2, 0xEBE4, 0x11CF, [0xA5, 0xFB, 0x00, 0x20, 0xAF, 0xE7, 0x29, 0x2D]);
interface DShellFolderViewEvents : IDispatch
{
}

const GUID IID_DFConstraint = {0x4A3DF050, 0x23BD, 0x11D2, [0x93, 0x9F, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xBA]};
@GUID(0x4A3DF050, 0x23BD, 0x11D2, [0x93, 0x9F, 0x00, 0xA0, 0xC9, 0x1E, 0xED, 0xBA]);
interface DFConstraint : IDispatch
{
    HRESULT get_Name(BSTR* pbs);
    HRESULT get_Value(VARIANT* pv);
}

const GUID IID_FolderItem = {0xFAC32C80, 0xCBE4, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xFAC32C80, 0xCBE4, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface FolderItem : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_Name(BSTR* pbs);
    HRESULT put_Name(BSTR bs);
    HRESULT get_Path(BSTR* pbs);
    HRESULT get_GetLink(IDispatch* ppid);
    HRESULT get_GetFolder(IDispatch* ppid);
    HRESULT get_IsLink(short* pb);
    HRESULT get_IsFolder(short* pb);
    HRESULT get_IsFileSystem(short* pb);
    HRESULT get_IsBrowsable(short* pb);
    HRESULT get_ModifyDate(double* pdt);
    HRESULT put_ModifyDate(double dt);
    HRESULT get_Size(int* pul);
    HRESULT get_Type(BSTR* pbs);
    HRESULT Verbs(FolderItemVerbs* ppfic);
    HRESULT InvokeVerb(VARIANT vVerb);
}

const GUID IID_FolderItems = {0x744129E0, 0xCBE5, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x744129E0, 0xCBE5, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface FolderItems : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT Item(VARIANT index, FolderItem* ppid);
    HRESULT _NewEnum(IUnknown* ppunk);
}

const GUID IID_FolderItemVerb = {0x08EC3E00, 0x50B0, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]};
@GUID(0x08EC3E00, 0x50B0, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]);
interface FolderItemVerb : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_Name(BSTR* pbs);
    HRESULT DoIt();
}

const GUID IID_FolderItemVerbs = {0x1F8352C0, 0x50B0, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]};
@GUID(0x1F8352C0, 0x50B0, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]);
interface FolderItemVerbs : IDispatch
{
    HRESULT get_Count(int* plCount);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT Item(VARIANT index, FolderItemVerb* ppid);
    HRESULT _NewEnum(IUnknown* ppunk);
}

const GUID IID_Folder = {0xBBCBDE60, 0xC3FF, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xBBCBDE60, 0xC3FF, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface Folder : IDispatch
{
    HRESULT get_Title(BSTR* pbs);
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_ParentFolder(Folder* ppsf);
    HRESULT Items(FolderItems* ppid);
    HRESULT ParseName(BSTR bName, FolderItem* ppid);
    HRESULT NewFolder(BSTR bName, VARIANT vOptions);
    HRESULT MoveHere(VARIANT vItem, VARIANT vOptions);
    HRESULT CopyHere(VARIANT vItem, VARIANT vOptions);
    HRESULT GetDetailsOf(VARIANT vItem, int iColumn, BSTR* pbs);
}

const GUID IID_Folder2 = {0xF0D2D8EF, 0x3890, 0x11D2, [0xBF, 0x8B, 0x00, 0xC0, 0x4F, 0xB9, 0x36, 0x61]};
@GUID(0xF0D2D8EF, 0x3890, 0x11D2, [0xBF, 0x8B, 0x00, 0xC0, 0x4F, 0xB9, 0x36, 0x61]);
interface Folder2 : Folder
{
    HRESULT get_Self(FolderItem* ppfi);
    HRESULT get_OfflineStatus(int* pul);
    HRESULT Synchronize();
    HRESULT get_HaveToShowWebViewBarricade(short* pbHaveToShowWebViewBarricade);
    HRESULT DismissedWebViewBarricade();
}

const GUID IID_Folder3 = {0xA7AE5F64, 0xC4D7, 0x4D7F, [0x93, 0x07, 0x4D, 0x24, 0xEE, 0x54, 0xB8, 0x41]};
@GUID(0xA7AE5F64, 0xC4D7, 0x4D7F, [0x93, 0x07, 0x4D, 0x24, 0xEE, 0x54, 0xB8, 0x41]);
interface Folder3 : Folder2
{
    HRESULT get_ShowWebViewBarricade(short* pbShowWebViewBarricade);
    HRESULT put_ShowWebViewBarricade(short bShowWebViewBarricade);
}

const GUID IID_FolderItem2 = {0xEDC817AA, 0x92B8, 0x11D1, [0xB0, 0x75, 0x00, 0xC0, 0x4F, 0xC3, 0x3A, 0xA5]};
@GUID(0xEDC817AA, 0x92B8, 0x11D1, [0xB0, 0x75, 0x00, 0xC0, 0x4F, 0xC3, 0x3A, 0xA5]);
interface FolderItem2 : FolderItem
{
    HRESULT InvokeVerbEx(VARIANT vVerb, VARIANT vArgs);
    HRESULT ExtendedProperty(BSTR bstrPropName, VARIANT* pvRet);
}

const GUID IID_FolderItems2 = {0xC94F0AD0, 0xF363, 0x11D2, [0xA3, 0x27, 0x00, 0xC0, 0x4F, 0x8E, 0xEC, 0x7F]};
@GUID(0xC94F0AD0, 0xF363, 0x11D2, [0xA3, 0x27, 0x00, 0xC0, 0x4F, 0x8E, 0xEC, 0x7F]);
interface FolderItems2 : FolderItems
{
    HRESULT InvokeVerbEx(VARIANT vVerb, VARIANT vArgs);
}

const GUID IID_FolderItems3 = {0xEAA7C309, 0xBBEC, 0x49D5, [0x82, 0x1D, 0x64, 0xD9, 0x66, 0xCB, 0x66, 0x7F]};
@GUID(0xEAA7C309, 0xBBEC, 0x49D5, [0x82, 0x1D, 0x64, 0xD9, 0x66, 0xCB, 0x66, 0x7F]);
interface FolderItems3 : FolderItems2
{
    HRESULT Filter(int grfFlags, BSTR bstrFileSpec);
    HRESULT get_Verbs(FolderItemVerbs* ppfic);
}

const GUID IID_IShellLinkDual = {0x88A05C00, 0xF000, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0x88A05C00, 0xF000, 0x11CE, [0x83, 0x50, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface IShellLinkDual : IDispatch
{
    HRESULT get_Path(BSTR* pbs);
    HRESULT put_Path(BSTR bs);
    HRESULT get_Description(BSTR* pbs);
    HRESULT put_Description(BSTR bs);
    HRESULT get_WorkingDirectory(BSTR* pbs);
    HRESULT put_WorkingDirectory(BSTR bs);
    HRESULT get_Arguments(BSTR* pbs);
    HRESULT put_Arguments(BSTR bs);
    HRESULT get_Hotkey(int* piHK);
    HRESULT put_Hotkey(int iHK);
    HRESULT get_ShowCommand(int* piShowCommand);
    HRESULT put_ShowCommand(int iShowCommand);
    HRESULT Resolve(int fFlags);
    HRESULT GetIconLocation(BSTR* pbs, int* piIcon);
    HRESULT SetIconLocation(BSTR bs, int iIcon);
    HRESULT Save(VARIANT vWhere);
}

const GUID IID_IShellLinkDual2 = {0x317EE249, 0xF12E, 0x11D2, [0xB1, 0xE4, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]};
@GUID(0x317EE249, 0xF12E, 0x11D2, [0xB1, 0xE4, 0x00, 0xC0, 0x4F, 0x8E, 0xEB, 0x3E]);
interface IShellLinkDual2 : IShellLinkDual
{
    HRESULT get_Target(FolderItem* ppfi);
}

const GUID IID_IShellFolderViewDual = {0xE7A1AF80, 0x4D96, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]};
@GUID(0xE7A1AF80, 0x4D96, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]);
interface IShellFolderViewDual : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT get_Folder(Folder* ppid);
    HRESULT SelectedItems(FolderItems* ppid);
    HRESULT get_FocusedItem(FolderItem* ppid);
    HRESULT SelectItem(VARIANT* pvfi, int dwFlags);
    HRESULT PopupItemMenu(FolderItem pfi, VARIANT vx, VARIANT vy, BSTR* pbs);
    HRESULT get_Script(IDispatch* ppDisp);
    HRESULT get_ViewOptions(int* plViewOptions);
}

const GUID IID_IShellFolderViewDual2 = {0x31C147B6, 0x0ADE, 0x4A3C, [0xB5, 0x14, 0xDD, 0xF9, 0x32, 0xEF, 0x6D, 0x17]};
@GUID(0x31C147B6, 0x0ADE, 0x4A3C, [0xB5, 0x14, 0xDD, 0xF9, 0x32, 0xEF, 0x6D, 0x17]);
interface IShellFolderViewDual2 : IShellFolderViewDual
{
    HRESULT get_CurrentViewMode(uint* pViewMode);
    HRESULT put_CurrentViewMode(uint ViewMode);
    HRESULT SelectItemRelative(int iRelative);
}

const GUID IID_IShellFolderViewDual3 = {0x29EC8E6C, 0x46D3, 0x411F, [0xBA, 0xAA, 0x61, 0x1A, 0x6C, 0x9C, 0xAC, 0x66]};
@GUID(0x29EC8E6C, 0x46D3, 0x411F, [0xBA, 0xAA, 0x61, 0x1A, 0x6C, 0x9C, 0xAC, 0x66]);
interface IShellFolderViewDual3 : IShellFolderViewDual2
{
    HRESULT get_GroupBy(BSTR* pbstrGroupBy);
    HRESULT put_GroupBy(BSTR bstrGroupBy);
    HRESULT get_FolderFlags(uint* pdwFlags);
    HRESULT put_FolderFlags(uint dwFlags);
    HRESULT get_SortColumns(BSTR* pbstrSortColumns);
    HRESULT put_SortColumns(BSTR bstrSortColumns);
    HRESULT put_IconSize(int iIconSize);
    HRESULT get_IconSize(int* piIconSize);
    HRESULT FilterView(BSTR bstrFilterText);
}

const GUID IID_IShellDispatch = {0xD8F015C0, 0xC278, 0x11CE, [0xA4, 0x9E, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]};
@GUID(0xD8F015C0, 0xC278, 0x11CE, [0xA4, 0x9E, 0x44, 0x45, 0x53, 0x54, 0x00, 0x00]);
interface IShellDispatch : IDispatch
{
    HRESULT get_Application(IDispatch* ppid);
    HRESULT get_Parent(IDispatch* ppid);
    HRESULT NameSpace(VARIANT vDir, Folder* ppsdf);
    HRESULT BrowseForFolder(int Hwnd, BSTR Title, int Options, VARIANT RootFolder, Folder* ppsdf);
    HRESULT Windows(IDispatch* ppid);
    HRESULT Open(VARIANT vDir);
    HRESULT Explore(VARIANT vDir);
    HRESULT MinimizeAll();
    HRESULT UndoMinimizeALL();
    HRESULT FileRun();
    HRESULT CascadeWindows();
    HRESULT TileVertically();
    HRESULT TileHorizontally();
    HRESULT ShutdownWindows();
    HRESULT Suspend();
    HRESULT EjectPC();
    HRESULT SetTime();
    HRESULT TrayProperties();
    HRESULT Help();
    HRESULT FindFiles();
    HRESULT FindComputer();
    HRESULT RefreshMenu();
    HRESULT ControlPanelItem(BSTR bstrDir);
}

const GUID IID_IShellDispatch2 = {0xA4C6892C, 0x3BA9, 0x11D2, [0x9D, 0xEA, 0x00, 0xC0, 0x4F, 0xB1, 0x61, 0x62]};
@GUID(0xA4C6892C, 0x3BA9, 0x11D2, [0x9D, 0xEA, 0x00, 0xC0, 0x4F, 0xB1, 0x61, 0x62]);
interface IShellDispatch2 : IShellDispatch
{
    HRESULT IsRestricted(BSTR Group, BSTR Restriction, int* plRestrictValue);
    HRESULT ShellExecuteA(BSTR File, VARIANT vArgs, VARIANT vDir, VARIANT vOperation, VARIANT vShow);
    HRESULT FindPrinter(BSTR name, BSTR location, BSTR model);
    HRESULT GetSystemInformation(BSTR name, VARIANT* pv);
    HRESULT ServiceStart(BSTR ServiceName, VARIANT Persistent, VARIANT* pSuccess);
    HRESULT ServiceStop(BSTR ServiceName, VARIANT Persistent, VARIANT* pSuccess);
    HRESULT IsServiceRunning(BSTR ServiceName, VARIANT* pRunning);
    HRESULT CanStartStopService(BSTR ServiceName, VARIANT* pCanStartStop);
    HRESULT ShowBrowserBar(BSTR bstrClsid, VARIANT bShow, VARIANT* pSuccess);
}

const GUID IID_IShellDispatch3 = {0x177160CA, 0xBB5A, 0x411C, [0x84, 0x1D, 0xBD, 0x38, 0xFA, 0xCD, 0xEA, 0xA0]};
@GUID(0x177160CA, 0xBB5A, 0x411C, [0x84, 0x1D, 0xBD, 0x38, 0xFA, 0xCD, 0xEA, 0xA0]);
interface IShellDispatch3 : IShellDispatch2
{
    HRESULT AddToRecent(VARIANT varFile, BSTR bstrCategory);
}

const GUID IID_IShellDispatch4 = {0xEFD84B2D, 0x4BCF, 0x4298, [0xBE, 0x25, 0xEB, 0x54, 0x2A, 0x59, 0xFB, 0xDA]};
@GUID(0xEFD84B2D, 0x4BCF, 0x4298, [0xBE, 0x25, 0xEB, 0x54, 0x2A, 0x59, 0xFB, 0xDA]);
interface IShellDispatch4 : IShellDispatch3
{
    HRESULT WindowsSecurity();
    HRESULT ToggleDesktop();
    HRESULT ExplorerPolicy(BSTR bstrPolicyName, VARIANT* pValue);
    HRESULT GetSetting(int lSetting, short* pResult);
}

const GUID IID_IShellDispatch5 = {0x866738B9, 0x6CF2, 0x4DE8, [0x87, 0x67, 0xF7, 0x94, 0xEB, 0xE7, 0x4F, 0x4E]};
@GUID(0x866738B9, 0x6CF2, 0x4DE8, [0x87, 0x67, 0xF7, 0x94, 0xEB, 0xE7, 0x4F, 0x4E]);
interface IShellDispatch5 : IShellDispatch4
{
    HRESULT WindowSwitcher();
}

const GUID IID_IShellDispatch6 = {0x286E6F1B, 0x7113, 0x4355, [0x95, 0x62, 0x96, 0xB7, 0xE9, 0xD6, 0x4C, 0x54]};
@GUID(0x286E6F1B, 0x7113, 0x4355, [0x95, 0x62, 0x96, 0xB7, 0xE9, 0xD6, 0x4C, 0x54]);
interface IShellDispatch6 : IShellDispatch5
{
    HRESULT SearchCommand();
}

const GUID IID_IFileSearchBand = {0x2D91EEA1, 0x9932, 0x11D2, [0xBE, 0x86, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]};
@GUID(0x2D91EEA1, 0x9932, 0x11D2, [0xBE, 0x86, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]);
interface IFileSearchBand : IDispatch
{
    HRESULT SetFocus();
    HRESULT SetSearchParameters(BSTR* pbstrSearchID, short bNavToResults, VARIANT* pvarScope, VARIANT* pvarQueryFile);
    HRESULT get_SearchID(BSTR* pbstrSearchID);
    HRESULT get_Scope(VARIANT* pvarScope);
    HRESULT get_QueryFile(VARIANT* pvarFile);
}

const GUID IID_IWebWizardHost = {0x18BCC359, 0x4990, 0x4BFB, [0xB9, 0x51, 0x3C, 0x83, 0x70, 0x2B, 0xE5, 0xF9]};
@GUID(0x18BCC359, 0x4990, 0x4BFB, [0xB9, 0x51, 0x3C, 0x83, 0x70, 0x2B, 0xE5, 0xF9]);
interface IWebWizardHost : IDispatch
{
    HRESULT FinalBack();
    HRESULT FinalNext();
    HRESULT Cancel();
    HRESULT put_Caption(BSTR bstrCaption);
    HRESULT get_Caption(BSTR* pbstrCaption);
    HRESULT put_Property(BSTR bstrPropertyName, VARIANT* pvProperty);
    HRESULT get_Property(BSTR bstrPropertyName, VARIANT* pvProperty);
    HRESULT SetWizardButtons(short vfEnableBack, short vfEnableNext, short vfLastPage);
    HRESULT SetHeaderText(BSTR bstrHeaderTitle, BSTR bstrHeaderSubtitle);
}

const GUID IID_IWebWizardHost2 = {0xF9C013DC, 0x3C23, 0x4041, [0x8E, 0x39, 0xCF, 0xB4, 0x02, 0xF7, 0xEA, 0x59]};
@GUID(0xF9C013DC, 0x3C23, 0x4041, [0x8E, 0x39, 0xCF, 0xB4, 0x02, 0xF7, 0xEA, 0x59]);
interface IWebWizardHost2 : IWebWizardHost
{
    HRESULT SignString(BSTR value, BSTR* signedValue);
}

const GUID IID_INewWDEvents = {0x0751C551, 0x7568, 0x41C9, [0x8E, 0x5B, 0xE2, 0x2E, 0x38, 0x91, 0x92, 0x36]};
@GUID(0x0751C551, 0x7568, 0x41C9, [0x8E, 0x5B, 0xE2, 0x2E, 0x38, 0x91, 0x92, 0x36]);
interface INewWDEvents : IWebWizardHost
{
    HRESULT PassportAuthenticate(BSTR bstrSignInUrl, short* pvfAuthenitcated);
}

const GUID IID_IAutoComplete = {0x00BB2762, 0x6A77, 0x11D0, [0xA5, 0x35, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]};
@GUID(0x00BB2762, 0x6A77, 0x11D0, [0xA5, 0x35, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]);
interface IAutoComplete : IUnknown
{
    HRESULT Init(HWND hwndEdit, IUnknown punkACL, const(wchar)* pwszRegKeyPath, const(wchar)* pwszQuickComplete);
    HRESULT Enable(BOOL fEnable);
}

enum AUTOCOMPLETEOPTIONS
{
    ACO_NONE = 0,
    ACO_AUTOSUGGEST = 1,
    ACO_AUTOAPPEND = 2,
    ACO_SEARCH = 4,
    ACO_FILTERPREFIXES = 8,
    ACO_USETAB = 16,
    ACO_UPDOWNKEYDROPSLIST = 32,
    ACO_RTLREADING = 64,
    ACO_WORD_FILTER = 128,
    ACO_NOPREFIXFILTERING = 256,
}

const GUID IID_IAutoComplete2 = {0xEAC04BC0, 0x3791, 0x11D2, [0xBB, 0x95, 0x00, 0x60, 0x97, 0x7B, 0x46, 0x4C]};
@GUID(0xEAC04BC0, 0x3791, 0x11D2, [0xBB, 0x95, 0x00, 0x60, 0x97, 0x7B, 0x46, 0x4C]);
interface IAutoComplete2 : IAutoComplete
{
    HRESULT SetOptions(uint dwFlag);
    HRESULT GetOptions(uint* pdwFlag);
}

enum ACENUMOPTION
{
    ACEO_NONE = 0,
    ACEO_MOSTRECENTFIRST = 1,
    ACEO_FIRSTUNUSED = 65536,
}

const GUID IID_IEnumACString = {0x8E74C210, 0xCF9D, 0x4EAF, [0xA4, 0x03, 0x73, 0x56, 0x42, 0x8F, 0x0A, 0x5A]};
@GUID(0x8E74C210, 0xCF9D, 0x4EAF, [0xA4, 0x03, 0x73, 0x56, 0x42, 0x8F, 0x0A, 0x5A]);
interface IEnumACString : IEnumString
{
    HRESULT NextItem(const(wchar)* pszUrl, uint cchMax, uint* pulSortIndex);
    HRESULT SetEnumOptions(uint dwOptions);
    HRESULT GetEnumOptions(uint* pdwOptions);
}

const GUID IID_IDataObjectAsyncCapability = {0x3D8B0590, 0xF691, 0x11D2, [0x8E, 0xA9, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]};
@GUID(0x3D8B0590, 0xF691, 0x11D2, [0x8E, 0xA9, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]);
interface IDataObjectAsyncCapability : IUnknown
{
    HRESULT SetAsyncMode(BOOL fDoOpAsync);
    HRESULT GetAsyncMode(int* pfIsOpAsync);
    HRESULT StartOperation(IBindCtx pbcReserved);
    HRESULT InOperation(int* pfInAsyncOp);
    HRESULT EndOperation(HRESULT hResult, IBindCtx pbcReserved, uint dwEffects);
}

const GUID IID_IExtractIconA = {0x000214EB, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214EB, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IExtractIconA : IUnknown
{
    HRESULT GetIconLocation(uint uFlags, const(char)* pszIconFile, uint cchMax, int* piIndex, uint* pwFlags);
    HRESULT Extract(const(char)* pszFile, uint nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);
}

const GUID IID_IExtractIconW = {0x000214FA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214FA, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IExtractIconW : IUnknown
{
    HRESULT GetIconLocation(uint uFlags, const(wchar)* pszIconFile, uint cchMax, int* piIndex, uint* pwFlags);
    HRESULT Extract(const(wchar)* pszFile, uint nIconIndex, HICON* phiconLarge, HICON* phiconSmall, uint nIconSize);
}

const GUID IID_IShellIconOverlayManager = {0xF10B5E34, 0xDD3B, 0x42A7, [0xAA, 0x7D, 0x2F, 0x4E, 0xC5, 0x4B, 0xB0, 0x9B]};
@GUID(0xF10B5E34, 0xDD3B, 0x42A7, [0xAA, 0x7D, 0x2F, 0x4E, 0xC5, 0x4B, 0xB0, 0x9B]);
interface IShellIconOverlayManager : IUnknown
{
    HRESULT GetFileOverlayInfo(const(wchar)* pwszPath, uint dwAttrib, int* pIndex, uint dwflags);
    HRESULT GetReservedOverlayInfo(const(wchar)* pwszPath, uint dwAttrib, int* pIndex, uint dwflags, int iReservedID);
    HRESULT RefreshOverlayImages(uint dwFlags);
    HRESULT LoadNonloadedOverlayIdentifiers();
    HRESULT OverlayIndexFromImageIndex(int iImage, int* piIndex, BOOL fAdd);
}

const GUID IID_IShellIconOverlay = {0x7D688A70, 0xC613, 0x11D0, [0x99, 0x9B, 0x00, 0xC0, 0x4F, 0xD6, 0x55, 0xE1]};
@GUID(0x7D688A70, 0xC613, 0x11D0, [0x99, 0x9B, 0x00, 0xC0, 0x4F, 0xD6, 0x55, 0xE1]);
interface IShellIconOverlay : IUnknown
{
    HRESULT GetOverlayIndex(ITEMIDLIST* pidl, int* pIndex);
    HRESULT GetOverlayIconIndex(ITEMIDLIST* pidl, int* pIconIndex);
}

enum SHELL_LINK_DATA_FLAGS
{
    SLDF_DEFAULT = 0,
    SLDF_HAS_ID_LIST = 1,
    SLDF_HAS_LINK_INFO = 2,
    SLDF_HAS_NAME = 4,
    SLDF_HAS_RELPATH = 8,
    SLDF_HAS_WORKINGDIR = 16,
    SLDF_HAS_ARGS = 32,
    SLDF_HAS_ICONLOCATION = 64,
    SLDF_UNICODE = 128,
    SLDF_FORCE_NO_LINKINFO = 256,
    SLDF_HAS_EXP_SZ = 512,
    SLDF_RUN_IN_SEPARATE = 1024,
    SLDF_HAS_DARWINID = 4096,
    SLDF_RUNAS_USER = 8192,
    SLDF_HAS_EXP_ICON_SZ = 16384,
    SLDF_NO_PIDL_ALIAS = 32768,
    SLDF_FORCE_UNCNAME = 65536,
    SLDF_RUN_WITH_SHIMLAYER = 131072,
    SLDF_FORCE_NO_LINKTRACK = 262144,
    SLDF_ENABLE_TARGET_METADATA = 524288,
    SLDF_DISABLE_LINK_PATH_TRACKING = 1048576,
    SLDF_DISABLE_KNOWNFOLDER_RELATIVE_TRACKING = 2097152,
    SLDF_NO_KF_ALIAS = 4194304,
    SLDF_ALLOW_LINK_TO_LINK = 8388608,
    SLDF_UNALIAS_ON_SAVE = 16777216,
    SLDF_PREFER_ENVIRONMENT_PATH = 33554432,
    SLDF_KEEP_LOCAL_IDLIST_FOR_UNC_TARGET = 67108864,
    SLDF_PERSIST_VOLUME_ID_RELATIVE = 134217728,
    SLDF_VALID = 268433407,
    SLDF_RESERVED = -2147483648,
}

struct DATABLOCK_HEADER
{
    uint cbSize;
    uint dwSignature;
}

struct NT_CONSOLE_PROPS
{
    DATABLOCK_HEADER dbh;
    ushort wFillAttribute;
    ushort wPopupFillAttribute;
    COORD dwScreenBufferSize;
    COORD dwWindowSize;
    COORD dwWindowOrigin;
    uint nFont;
    uint nInputBufferSize;
    COORD dwFontSize;
    uint uFontFamily;
    uint uFontWeight;
    ushort FaceName;
    uint uCursorSize;
    BOOL bFullScreen;
    BOOL bQuickEdit;
    BOOL bInsertMode;
    BOOL bAutoPosition;
    uint uHistoryBufferSize;
    uint uNumberOfHistoryBuffers;
    BOOL bHistoryNoDup;
    uint ColorTable;
}

struct NT_FE_CONSOLE_PROPS
{
    DATABLOCK_HEADER dbh;
    uint uCodePage;
}

struct EXP_DARWIN_LINK
{
    DATABLOCK_HEADER dbh;
    byte szDarwinID;
    ushort szwDarwinID;
}

struct EXP_SPECIAL_FOLDER
{
    uint cbSize;
    uint dwSignature;
    uint idSpecialFolder;
    uint cbOffset;
}

struct EXP_SZ_LINK
{
    uint cbSize;
    uint dwSignature;
    byte szTarget;
    ushort swzTarget;
}

struct EXP_PROPERTYSTORAGE
{
    uint cbSize;
    uint dwSignature;
    ubyte abPropertyStorage;
}

const GUID IID_IShellExecuteHookA = {0x000214F5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F5, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellExecuteHookA : IUnknown
{
    HRESULT Execute(SHELLEXECUTEINFOA* pei);
}

const GUID IID_IShellExecuteHookW = {0x000214FB, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214FB, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellExecuteHookW : IUnknown
{
    HRESULT Execute(SHELLEXECUTEINFOW* pei);
}

const GUID IID_IURLSearchHook = {0xAC60F6A0, 0x0FD9, 0x11D0, [0x99, 0xCB, 0x00, 0xC0, 0x4F, 0xD6, 0x44, 0x97]};
@GUID(0xAC60F6A0, 0x0FD9, 0x11D0, [0x99, 0xCB, 0x00, 0xC0, 0x4F, 0xD6, 0x44, 0x97]);
interface IURLSearchHook : IUnknown
{
    HRESULT Translate(const(wchar)* pwszSearchURL, uint cchBufferSize);
}

const GUID IID_ISearchContext = {0x09F656A2, 0x41AF, 0x480C, [0x88, 0xF7, 0x16, 0xCC, 0x0D, 0x16, 0x46, 0x15]};
@GUID(0x09F656A2, 0x41AF, 0x480C, [0x88, 0xF7, 0x16, 0xCC, 0x0D, 0x16, 0x46, 0x15]);
interface ISearchContext : IUnknown
{
    HRESULT GetSearchUrl(BSTR* pbstrSearchUrl);
    HRESULT GetSearchText(BSTR* pbstrSearchText);
    HRESULT GetSearchStyle(uint* pdwSearchStyle);
}

const GUID IID_IURLSearchHook2 = {0x5EE44DA4, 0x6D32, 0x46E3, [0x86, 0xBC, 0x07, 0x54, 0x0D, 0xED, 0xD0, 0xE0]};
@GUID(0x5EE44DA4, 0x6D32, 0x46E3, [0x86, 0xBC, 0x07, 0x54, 0x0D, 0xED, 0xD0, 0xE0]);
interface IURLSearchHook2 : IURLSearchHook
{
    HRESULT TranslateWithSearchContext(const(wchar)* pwszSearchURL, uint cchBufferSize, ISearchContext pSearchContext);
}

enum SHGFP_TYPE
{
    SHGFP_TYPE_CURRENT = 0,
    SHGFP_TYPE_DEFAULT = 1,
}

enum KNOWN_FOLDER_FLAG
{
    KF_FLAG_DEFAULT = 0,
    KF_FLAG_FORCE_APP_DATA_REDIRECTION = 524288,
    KF_FLAG_RETURN_FILTER_REDIRECTION_TARGET = 262144,
    KF_FLAG_FORCE_PACKAGE_REDIRECTION = 131072,
    KF_FLAG_NO_PACKAGE_REDIRECTION = 65536,
    KF_FLAG_FORCE_APPCONTAINER_REDIRECTION = 131072,
    KF_FLAG_NO_APPCONTAINER_REDIRECTION = 65536,
    KF_FLAG_CREATE = 32768,
    KF_FLAG_DONT_VERIFY = 16384,
    KF_FLAG_DONT_UNEXPAND = 8192,
    KF_FLAG_NO_ALIAS = 4096,
    KF_FLAG_INIT = 2048,
    KF_FLAG_DEFAULT_PATH = 1024,
    KF_FLAG_NOT_PARENT_RELATIVE = 512,
    KF_FLAG_SIMPLE_IDLIST = 256,
    KF_FLAG_ALIAS_ONLY = -2147483648,
}

struct SHFOLDERCUSTOMSETTINGS
{
    uint dwSize;
    uint dwMask;
    Guid* pvid;
    const(wchar)* pszWebViewTemplate;
    uint cchWebViewTemplate;
    const(wchar)* pszWebViewTemplateVersion;
    const(wchar)* pszInfoTip;
    uint cchInfoTip;
    Guid* pclsid;
    uint dwFlags;
    const(wchar)* pszIconFile;
    uint cchIconFile;
    int iIconIndex;
    const(wchar)* pszLogo;
    uint cchLogo;
}

struct BROWSEINFOA
{
    HWND hwndOwner;
    ITEMIDLIST* pidlRoot;
    const(char)* pszDisplayName;
    const(char)* lpszTitle;
    uint ulFlags;
    BFFCALLBACK lpfn;
    LPARAM lParam;
    int iImage;
}

struct BROWSEINFOW
{
    HWND hwndOwner;
    ITEMIDLIST* pidlRoot;
    const(wchar)* pszDisplayName;
    const(wchar)* lpszTitle;
    uint ulFlags;
    BFFCALLBACK lpfn;
    LPARAM lParam;
    int iImage;
}

const GUID IID_IShellDetails = {0x000214EC, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214EC, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IShellDetails : IUnknown
{
    HRESULT GetDetailsOf(ITEMIDLIST* pidl, uint iColumn, SHELLDETAILS* pDetails);
    HRESULT ColumnClick(uint iColumn);
}

const GUID IID_IObjMgr = {0x00BB2761, 0x6A77, 0x11D0, [0xA5, 0x35, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]};
@GUID(0x00BB2761, 0x6A77, 0x11D0, [0xA5, 0x35, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]);
interface IObjMgr : IUnknown
{
    HRESULT Append(IUnknown punk);
    HRESULT Remove(IUnknown punk);
}

const GUID IID_IACList = {0x77A130B0, 0x94FD, 0x11D0, [0xA5, 0x44, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]};
@GUID(0x77A130B0, 0x94FD, 0x11D0, [0xA5, 0x44, 0x00, 0xC0, 0x4F, 0xD7, 0xD0, 0x62]);
interface IACList : IUnknown
{
    HRESULT Expand(const(wchar)* pszExpand);
}

enum AUTOCOMPLETELISTOPTIONS
{
    ACLO_NONE = 0,
    ACLO_CURRENTDIR = 1,
    ACLO_MYCOMPUTER = 2,
    ACLO_DESKTOP = 4,
    ACLO_FAVORITES = 8,
    ACLO_FILESYSONLY = 16,
    ACLO_FILESYSDIRS = 32,
    ACLO_VIRTUALNAMESPACE = 64,
}

const GUID IID_IACList2 = {0x470141A0, 0x5186, 0x11D2, [0xBB, 0xB6, 0x00, 0x60, 0x97, 0x7B, 0x46, 0x4C]};
@GUID(0x470141A0, 0x5186, 0x11D2, [0xBB, 0xB6, 0x00, 0x60, 0x97, 0x7B, 0x46, 0x4C]);
interface IACList2 : IACList
{
    HRESULT SetOptions(uint dwFlag);
    HRESULT GetOptions(uint* pdwFlag);
}

const GUID IID_IProgressDialog = {0xEBBC7C04, 0x315E, 0x11D2, [0xB6, 0x2F, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]};
@GUID(0xEBBC7C04, 0x315E, 0x11D2, [0xB6, 0x2F, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]);
interface IProgressDialog : IUnknown
{
    HRESULT StartProgressDialog(HWND hwndParent, IUnknown punkEnableModless, uint dwFlags, void* pvResevered);
    HRESULT StopProgressDialog();
    HRESULT SetTitle(const(wchar)* pwzTitle);
    HRESULT SetAnimation(HINSTANCE hInstAnimation, uint idAnimation);
    BOOL HasUserCancelled();
    HRESULT SetProgress(uint dwCompleted, uint dwTotal);
    HRESULT SetProgress64(ulong ullCompleted, ulong ullTotal);
    HRESULT SetLine(uint dwLineNum, const(wchar)* pwzString, BOOL fCompactPath, void* pvResevered);
    HRESULT SetCancelMsg(const(wchar)* pwzCancelMsg, void* pvResevered);
    HRESULT Timer(uint dwTimerAction, void* pvResevered);
}

const GUID IID_IDockingWindowSite = {0x2A342FC2, 0x7B26, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0x2A342FC2, 0x7B26, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface IDockingWindowSite : IOleWindow
{
    HRESULT GetBorderDW(IUnknown punkObj, RECT* prcBorder);
    HRESULT RequestBorderSpaceDW(IUnknown punkObj, RECT* pbw);
    HRESULT SetBorderSpaceDW(IUnknown punkObj, RECT* pbw);
}

struct NRESARRAY
{
    uint cItems;
    NETRESOURCEA nr;
}

struct CIDA
{
    uint cidl;
    uint aoffset;
}

enum FD_FLAGS
{
    FD_CLSID = 1,
    FD_SIZEPOINT = 2,
    FD_ATTRIBUTES = 4,
    FD_CREATETIME = 8,
    FD_ACCESSTIME = 16,
    FD_WRITESTIME = 32,
    FD_FILESIZE = 64,
    FD_PROGRESSUI = 16384,
    FD_LINKUI = 32768,
    FD_UNICODE = -2147483648,
}

struct FILEDESCRIPTORA
{
    uint dwFlags;
    Guid clsid;
    SIZE sizel;
    POINTL pointl;
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint nFileSizeHigh;
    uint nFileSizeLow;
    byte cFileName;
}

struct FILEDESCRIPTORW
{
    uint dwFlags;
    Guid clsid;
    SIZE sizel;
    POINTL pointl;
    uint dwFileAttributes;
    FILETIME ftCreationTime;
    FILETIME ftLastAccessTime;
    FILETIME ftLastWriteTime;
    uint nFileSizeHigh;
    uint nFileSizeLow;
    ushort cFileName;
}

struct FILEGROUPDESCRIPTORA
{
    uint cItems;
    FILEDESCRIPTORA fgd;
}

struct FILEGROUPDESCRIPTORW
{
    uint cItems;
    FILEDESCRIPTORW fgd;
}

struct DROPFILES
{
    uint pFiles;
    POINT pt;
    BOOL fNC;
    BOOL fWide;
}

struct FILE_ATTRIBUTES_ARRAY
{
    uint cItems;
    uint dwSumFileAttributes;
    uint dwProductFileAttributes;
    uint rgdwFileAttributes;
}

enum DROPIMAGETYPE
{
    DROPIMAGE_INVALID = -1,
    DROPIMAGE_NONE = 0,
    DROPIMAGE_COPY = 1,
    DROPIMAGE_MOVE = 2,
    DROPIMAGE_LINK = 4,
    DROPIMAGE_LABEL = 6,
    DROPIMAGE_WARNING = 7,
    DROPIMAGE_NOIMAGE = 8,
}

struct DROPDESCRIPTION
{
    DROPIMAGETYPE type;
    ushort szMessage;
    ushort szInsert;
}

struct SHChangeNotifyEntry
{
    ITEMIDLIST* pidl;
    BOOL fRecursive;
}

const GUID IID_IShellChangeNotify = {0xD82BE2B1, 0x5764, 0x11D0, [0xA9, 0x6E, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]};
@GUID(0xD82BE2B1, 0x5764, 0x11D0, [0xA9, 0x6E, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]);
interface IShellChangeNotify : IUnknown
{
    HRESULT OnChange(int lEvent, ITEMIDLIST* pidl1, ITEMIDLIST* pidl2);
}

const GUID IID_IQueryInfo = {0x00021500, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x00021500, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface IQueryInfo : IUnknown
{
    HRESULT GetInfoTip(uint dwFlags, ushort** ppwszTip);
    HRESULT GetInfoFlags(uint* pdwFlags);
}

enum SHARD
{
    SHARD_PIDL = 1,
    SHARD_PATHA = 2,
    SHARD_PATHW = 3,
    SHARD_APPIDINFO = 4,
    SHARD_APPIDINFOIDLIST = 5,
    SHARD_LINK = 6,
    SHARD_APPIDINFOLINK = 7,
    SHARD_SHELLITEM = 8,
}

struct SHARDAPPIDINFO
{
    IShellItem psi;
    const(wchar)* pszAppID;
}

struct SHARDAPPIDINFOIDLIST
{
    ITEMIDLIST* pidl;
    const(wchar)* pszAppID;
}

struct SHARDAPPIDINFOLINK
{
    IShellLinkA psl;
    const(wchar)* pszAppID;
}

struct SHChangeDWORDAsIDList
{
    ushort cb;
    uint dwItem1;
    uint dwItem2;
    ushort cbZero;
}

struct SHChangeUpdateImageIDList
{
    ushort cb;
    int iIconIndex;
    int iCurIndex;
    uint uFlags;
    uint dwProcessID;
    ushort szName;
    ushort cbZero;
}

enum SCNRT_STATUS
{
    SCNRT_ENABLE = 0,
    SCNRT_DISABLE = 1,
}

struct SHDESCRIPTIONID
{
    uint dwDescriptionId;
    Guid clsid;
}

struct AUTO_SCROLL_DATA
{
    int iNextSample;
    uint dwLastScroll;
    BOOL bFull;
    POINT pts;
    uint dwTimes;
}

struct CABINETSTATE
{
    ushort cLength;
    ushort nVersion;
    int _bitfield;
    uint fMenuEnumFilter;
}

struct HPSXA__
{
    int unused;
}

enum RESTRICTIONS
{
    REST_NONE = 0,
    REST_NORUN = 1,
    REST_NOCLOSE = 2,
    REST_NOSAVESET = 4,
    REST_NOFILEMENU = 8,
    REST_NOSETFOLDERS = 16,
    REST_NOSETTASKBAR = 32,
    REST_NODESKTOP = 64,
    REST_NOFIND = 128,
    REST_NODRIVES = 256,
    REST_NODRIVEAUTORUN = 512,
    REST_NODRIVETYPEAUTORUN = 1024,
    REST_NONETHOOD = 2048,
    REST_STARTBANNER = 4096,
    REST_RESTRICTRUN = 8192,
    REST_NOPRINTERTABS = 16384,
    REST_NOPRINTERDELETE = 32768,
    REST_NOPRINTERADD = 65536,
    REST_NOSTARTMENUSUBFOLDERS = 131072,
    REST_MYDOCSONNET = 262144,
    REST_NOEXITTODOS = 524288,
    REST_ENFORCESHELLEXTSECURITY = 1048576,
    REST_LINKRESOLVEIGNORELINKINFO = 2097152,
    REST_NOCOMMONGROUPS = 4194304,
    REST_SEPARATEDESKTOPPROCESS = 8388608,
    REST_NOWEB = 16777216,
    REST_NOTRAYCONTEXTMENU = 33554432,
    REST_NOVIEWCONTEXTMENU = 67108864,
    REST_NONETCONNECTDISCONNECT = 134217728,
    REST_STARTMENULOGOFF = 268435456,
    REST_NOSETTINGSASSIST = 536870912,
    REST_NOINTERNETICON = 1073741825,
    REST_NORECENTDOCSHISTORY = 1073741826,
    REST_NORECENTDOCSMENU = 1073741827,
    REST_NOACTIVEDESKTOP = 1073741828,
    REST_NOACTIVEDESKTOPCHANGES = 1073741829,
    REST_NOFAVORITESMENU = 1073741830,
    REST_CLEARRECENTDOCSONEXIT = 1073741831,
    REST_CLASSICSHELL = 1073741832,
    REST_NOCUSTOMIZEWEBVIEW = 1073741833,
    REST_NOHTMLWALLPAPER = 1073741840,
    REST_NOCHANGINGWALLPAPER = 1073741841,
    REST_NODESKCOMP = 1073741842,
    REST_NOADDDESKCOMP = 1073741843,
    REST_NODELDESKCOMP = 1073741844,
    REST_NOCLOSEDESKCOMP = 1073741845,
    REST_NOCLOSE_DRAGDROPBAND = 1073741846,
    REST_NOMOVINGBAND = 1073741847,
    REST_NOEDITDESKCOMP = 1073741848,
    REST_NORESOLVESEARCH = 1073741849,
    REST_NORESOLVETRACK = 1073741850,
    REST_FORCECOPYACLWITHFILE = 1073741851,
    REST_NOFORGETSOFTWAREUPDATE = 1073741853,
    REST_NOSETACTIVEDESKTOP = 1073741854,
    REST_NOUPDATEWINDOWS = 1073741855,
    REST_NOCHANGESTARMENU = 1073741856,
    REST_NOFOLDEROPTIONS = 1073741857,
    REST_HASFINDCOMPUTERS = 1073741858,
    REST_INTELLIMENUS = 1073741859,
    REST_RUNDLGMEMCHECKBOX = 1073741860,
    REST_ARP_ShowPostSetup = 1073741861,
    REST_NOCSC = 1073741862,
    REST_NOCONTROLPANEL = 1073741863,
    REST_ENUMWORKGROUP = 1073741864,
    REST_ARP_NOARP = 1073741865,
    REST_ARP_NOREMOVEPAGE = 1073741866,
    REST_ARP_NOADDPAGE = 1073741867,
    REST_ARP_NOWINSETUPPAGE = 1073741868,
    REST_GREYMSIADS = 1073741869,
    REST_NOCHANGEMAPPEDDRIVELABEL = 1073741870,
    REST_NOCHANGEMAPPEDDRIVECOMMENT = 1073741871,
    REST_MaxRecentDocs = 1073741872,
    REST_NONETWORKCONNECTIONS = 1073741873,
    REST_FORCESTARTMENULOGOFF = 1073741874,
    REST_NOWEBVIEW = 1073741875,
    REST_NOCUSTOMIZETHISFOLDER = 1073741876,
    REST_NOENCRYPTION = 1073741877,
    REST_DONTSHOWSUPERHIDDEN = 1073741879,
    REST_NOSHELLSEARCHBUTTON = 1073741880,
    REST_NOHARDWARETAB = 1073741881,
    REST_NORUNASINSTALLPROMPT = 1073741882,
    REST_PROMPTRUNASINSTALLNETPATH = 1073741883,
    REST_NOMANAGEMYCOMPUTERVERB = 1073741884,
    REST_DISALLOWRUN = 1073741886,
    REST_NOWELCOMESCREEN = 1073741887,
    REST_RESTRICTCPL = 1073741888,
    REST_DISALLOWCPL = 1073741889,
    REST_NOSMBALLOONTIP = 1073741890,
    REST_NOSMHELP = 1073741891,
    REST_NOWINKEYS = 1073741892,
    REST_NOENCRYPTONMOVE = 1073741893,
    REST_NOLOCALMACHINERUN = 1073741894,
    REST_NOCURRENTUSERRUN = 1073741895,
    REST_NOLOCALMACHINERUNONCE = 1073741896,
    REST_NOCURRENTUSERRUNONCE = 1073741897,
    REST_FORCEACTIVEDESKTOPON = 1073741898,
    REST_NOVIEWONDRIVE = 1073741900,
    REST_NONETCRAWL = 1073741901,
    REST_NOSHAREDDOCUMENTS = 1073741902,
    REST_NOSMMYDOCS = 1073741903,
    REST_NOSMMYPICS = 1073741904,
    REST_ALLOWBITBUCKDRIVES = 1073741905,
    REST_NONLEGACYSHELLMODE = 1073741906,
    REST_NOCONTROLPANELBARRICADE = 1073741907,
    REST_NOSTARTPAGE = 1073741908,
    REST_NOAUTOTRAYNOTIFY = 1073741909,
    REST_NOTASKGROUPING = 1073741910,
    REST_NOCDBURNING = 1073741911,
    REST_MYCOMPNOPROP = 1073741912,
    REST_MYDOCSNOPROP = 1073741913,
    REST_NOSTARTPANEL = 1073741914,
    REST_NODISPLAYAPPEARANCEPAGE = 1073741915,
    REST_NOTHEMESTAB = 1073741916,
    REST_NOVISUALSTYLECHOICE = 1073741917,
    REST_NOSIZECHOICE = 1073741918,
    REST_NOCOLORCHOICE = 1073741919,
    REST_SETVISUALSTYLE = 1073741920,
    REST_STARTRUNNOHOMEPATH = 1073741921,
    REST_NOUSERNAMEINSTARTPANEL = 1073741922,
    REST_NOMYCOMPUTERICON = 1073741923,
    REST_NOSMNETWORKPLACES = 1073741924,
    REST_NOSMPINNEDLIST = 1073741925,
    REST_NOSMMYMUSIC = 1073741926,
    REST_NOSMEJECTPC = 1073741927,
    REST_NOSMMOREPROGRAMS = 1073741928,
    REST_NOSMMFUPROGRAMS = 1073741929,
    REST_NOTRAYITEMSDISPLAY = 1073741930,
    REST_NOTOOLBARSONTASKBAR = 1073741931,
    REST_NOSMCONFIGUREPROGRAMS = 1073741935,
    REST_HIDECLOCK = 1073741936,
    REST_NOLOWDISKSPACECHECKS = 1073741937,
    REST_NOENTIRENETWORK = 1073741938,
    REST_NODESKTOPCLEANUP = 1073741939,
    REST_BITBUCKNUKEONDELETE = 1073741940,
    REST_BITBUCKCONFIRMDELETE = 1073741941,
    REST_BITBUCKNOPROP = 1073741942,
    REST_NODISPBACKGROUND = 1073741943,
    REST_NODISPSCREENSAVEPG = 1073741944,
    REST_NODISPSETTINGSPG = 1073741945,
    REST_NODISPSCREENSAVEPREVIEW = 1073741946,
    REST_NODISPLAYCPL = 1073741947,
    REST_HIDERUNASVERB = 1073741948,
    REST_NOTHUMBNAILCACHE = 1073741949,
    REST_NOSTRCMPLOGICAL = 1073741950,
    REST_NOPUBLISHWIZARD = 1073741951,
    REST_NOONLINEPRINTSWIZARD = 1073741952,
    REST_NOWEBSERVICES = 1073741953,
    REST_ALLOWUNHASHEDWEBVIEW = 1073741954,
    REST_ALLOWLEGACYWEBVIEW = 1073741955,
    REST_REVERTWEBVIEWSECURITY = 1073741956,
    REST_INHERITCONSOLEHANDLES = 1073741958,
    REST_NOREMOTERECURSIVEEVENTS = 1073741961,
    REST_NOREMOTECHANGENOTIFY = 1073741969,
    REST_NOENUMENTIRENETWORK = 1073741971,
    REST_NOINTERNETOPENWITH = 1073741973,
    REST_DONTRETRYBADNETNAME = 1073741979,
    REST_ALLOWFILECLSIDJUNCTIONS = 1073741980,
    REST_NOUPNPINSTALL = 1073741981,
    REST_ARP_DONTGROUPPATCHES = 1073741996,
    REST_ARP_NOCHOOSEPROGRAMSPAGE = 1073741997,
    REST_NODISCONNECT = 1090519041,
    REST_NOSECURITY = 1090519042,
    REST_NOFILEASSOCIATE = 1090519043,
    REST_ALLOWCOMMENTTOGGLE = 1090519044,
}

enum tagOPEN_AS_INFO_FLAGS
{
    OAIF_ALLOW_REGISTRATION = 1,
    OAIF_REGISTER_EXT = 2,
    OAIF_EXEC = 4,
    OAIF_FORCE_REGISTRATION = 8,
    OAIF_HIDE_REGISTRATION = 32,
    OAIF_URL_PROTOCOL = 64,
    OAIF_FILE_IS_URI = 128,
}

struct OPENASINFO
{
    const(wchar)* pcszFile;
    const(wchar)* pcszClass;
    int oaifInFlags;
}

const GUID IID_IShellFolderViewCB = {0x2047E320, 0xF2A9, 0x11CE, [0xAE, 0x65, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]};
@GUID(0x2047E320, 0xF2A9, 0x11CE, [0xAE, 0x65, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]);
interface IShellFolderViewCB : IUnknown
{
    HRESULT MessageSFVCB(uint uMsg, WPARAM wParam, LPARAM lParam);
}

struct QCMINFO_IDMAP_PLACEMENT
{
    uint id;
    uint fFlags;
}

struct QCMINFO_IDMAP
{
    uint nMaxIds;
    QCMINFO_IDMAP_PLACEMENT pIdList;
}

struct QCMINFO
{
    HMENU hmenu;
    uint indexMenu;
    uint idCmdFirst;
    uint idCmdLast;
    const(QCMINFO_IDMAP)* pIdMap;
}

struct DETAILSINFO
{
    ITEMIDLIST* pidl;
    int fmt;
    int cxChar;
    STRRET str;
    int iImage;
}

struct SFVM_PROPPAGE_DATA
{
    uint dwReserved;
    LPFNADDPROPSHEETPAGE pfn;
    LPARAM lParam;
}

struct SFVM_HELPTOPIC_DATA
{
    ushort wszHelpFile;
    ushort wszHelpTopic;
}

struct ITEMSPACING
{
    int cxSmall;
    int cySmall;
    int cxLarge;
    int cyLarge;
}

const GUID IID_IShellFolderView = {0x37A378C0, 0xF82D, 0x11CE, [0xAE, 0x65, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]};
@GUID(0x37A378C0, 0xF82D, 0x11CE, [0xAE, 0x65, 0x08, 0x00, 0x2B, 0x2E, 0x12, 0x62]);
interface IShellFolderView : IUnknown
{
    HRESULT Rearrange(LPARAM lParamSort);
    HRESULT GetArrangeParam(LPARAM* plParamSort);
    HRESULT ArrangeGrid();
    HRESULT AutoArrange();
    HRESULT GetAutoArrange();
    HRESULT AddObject(ITEMIDLIST* pidl, uint* puItem);
    HRESULT GetObjectA(ITEMIDLIST** ppidl, uint uItem);
    HRESULT RemoveObject(ITEMIDLIST* pidl, uint* puItem);
    HRESULT GetObjectCount(uint* puCount);
    HRESULT SetObjectCount(uint uCount, uint dwFlags);
    HRESULT UpdateObject(ITEMIDLIST* pidlOld, ITEMIDLIST* pidlNew, uint* puItem);
    HRESULT RefreshObject(ITEMIDLIST* pidl, uint* puItem);
    HRESULT SetRedraw(BOOL bRedraw);
    HRESULT GetSelectedCount(uint* puSelected);
    HRESULT GetSelectedObjects(ITEMIDLIST*** pppidl, uint* puItems);
    HRESULT IsDropOnSource(IDropTarget pDropTarget);
    HRESULT GetDragPoint(POINT* ppt);
    HRESULT GetDropPoint(POINT* ppt);
    HRESULT MoveIcons(IDataObject pDataObject);
    HRESULT SetItemPos(ITEMIDLIST* pidl, POINT* ppt);
    HRESULT IsBkDropTarget(IDropTarget pDropTarget);
    HRESULT SetClipboard(BOOL bMove);
    HRESULT SetPoints(IDataObject pDataObject);
    HRESULT GetItemSpacing(ITEMSPACING* pSpacing);
    HRESULT SetCallback(IShellFolderViewCB pNewCB, IShellFolderViewCB* ppOldCB);
    HRESULT Select(uint dwFlags);
    HRESULT QuerySupport(uint* pdwSupport);
    HRESULT SetAutomationObject(IDispatch pdisp);
}

struct SFV_CREATE
{
    uint cbSize;
    IShellFolder pshf;
    IShellView psvOuter;
    IShellFolderViewCB psfvcb;
}

alias LPFNDFMCALLBACK = extern(Windows) HRESULT function(IShellFolder psf, HWND hwnd, IDataObject pdtobj, uint uMsg, WPARAM wParam, LPARAM lParam);
struct DEFCONTEXTMENU
{
    HWND hwnd;
    IContextMenuCB pcmcb;
    ITEMIDLIST* pidlFolder;
    IShellFolder psf;
    uint cidl;
    ITEMIDLIST** apidl;
    IUnknown punkAssociationInfo;
    uint cKeys;
    const(int)* aKeys;
}

struct DFMICS
{
    uint cbSize;
    uint fMask;
    LPARAM lParam;
    uint idCmdFirst;
    uint idDefMax;
    CMINVOKECOMMANDINFO* pici;
    IUnknown punkSite;
}

alias LPFNVIEWCALLBACK = extern(Windows) HRESULT function(IShellView psvOuter, IShellFolder psf, HWND hwndMain, uint uMsg, WPARAM wParam, LPARAM lParam);
struct CSFV
{
    uint cbSize;
    IShellFolder pshf;
    IShellView psvOuter;
    ITEMIDLIST* pidl;
    int lEvents;
    LPFNVIEWCALLBACK pfnCallback;
    FOLDERVIEWMODE fvm;
}

struct SHELLSTATEA
{
    int _bitfield1;
    uint dwWin95Unused;
    uint uWin95Unused;
    int lParamSort;
    int iSortDirection;
    uint version;
    uint uNotUsed;
    int _bitfield2;
}

struct SHELLSTATEW
{
    int _bitfield1;
    uint dwWin95Unused;
    uint uWin95Unused;
    int lParamSort;
    int iSortDirection;
    uint version;
    uint uNotUsed;
    int _bitfield2;
}

struct SHELLFLAGSTATE
{
    int _bitfield;
}

const GUID IID_INamedPropertyBag = {0xFB700430, 0x952C, 0x11D1, [0x94, 0x6F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]};
@GUID(0xFB700430, 0x952C, 0x11D1, [0x94, 0x6F, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]);
interface INamedPropertyBag : IUnknown
{
    HRESULT ReadPropertyNPB(const(wchar)* pszBagname, const(wchar)* pszPropName, PROPVARIANT* pVar);
    HRESULT WritePropertyNPB(const(wchar)* pszBagname, const(wchar)* pszPropName, PROPVARIANT* pVar);
    HRESULT RemovePropertyNPB(const(wchar)* pszBagname, const(wchar)* pszPropName);
}

enum IESHORTCUTFLAGS
{
    IESHORTCUT_NEWBROWSER = 1,
    IESHORTCUT_OPENNEWTAB = 2,
    IESHORTCUT_FORCENAVIGATE = 4,
    IESHORTCUT_BACKGROUNDTAB = 8,
}

const GUID IID_INewShortcutHookA = {0x000214E1, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214E1, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface INewShortcutHookA : IUnknown
{
    HRESULT SetReferent(const(char)* pcszReferent, HWND hwnd);
    HRESULT GetReferent(const(char)* pszReferent, int cchReferent);
    HRESULT SetFolder(const(char)* pcszFolder);
    HRESULT GetFolder(const(char)* pszFolder, int cchFolder);
    HRESULT GetName(const(char)* pszName, int cchName);
    HRESULT GetExtension(const(char)* pszExtension, int cchExtension);
}

const GUID IID_INewShortcutHookW = {0x000214F7, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214F7, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface INewShortcutHookW : IUnknown
{
    HRESULT SetReferent(const(wchar)* pcszReferent, HWND hwnd);
    HRESULT GetReferent(const(wchar)* pszReferent, int cchReferent);
    HRESULT SetFolder(const(wchar)* pcszFolder);
    HRESULT GetFolder(const(wchar)* pszFolder, int cchFolder);
    HRESULT GetName(const(wchar)* pszName, int cchName);
    HRESULT GetExtension(const(wchar)* pszExtension, int cchExtension);
}

const GUID IID_ICopyHookA = {0x000214EF, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214EF, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICopyHookA : IUnknown
{
    uint CopyCallback(HWND hwnd, uint wFunc, uint wFlags, const(char)* pszSrcFile, uint dwSrcAttribs, const(char)* pszDestFile, uint dwDestAttribs);
}

const GUID IID_ICopyHookW = {0x000214FC, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]};
@GUID(0x000214FC, 0x0000, 0x0000, [0xC0, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x46]);
interface ICopyHookW : IUnknown
{
    uint CopyCallback(HWND hwnd, uint wFunc, uint wFlags, const(wchar)* pszSrcFile, uint dwSrcAttribs, const(wchar)* pszDestFile, uint dwDestAttribs);
}

const GUID IID_ICurrentWorkingDirectory = {0x91956D21, 0x9276, 0x11D1, [0x92, 0x1A, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]};
@GUID(0x91956D21, 0x9276, 0x11D1, [0x92, 0x1A, 0x00, 0x60, 0x97, 0xDF, 0x5B, 0xD4]);
interface ICurrentWorkingDirectory : IUnknown
{
    HRESULT GetDirectory(const(wchar)* pwzPath, uint cchSize);
    HRESULT SetDirectory(const(wchar)* pwzPath);
}

const GUID IID_IDockingWindowFrame = {0x47D2657A, 0x7B27, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0x47D2657A, 0x7B27, 0x11D0, [0x8C, 0xA9, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface IDockingWindowFrame : IOleWindow
{
    HRESULT AddToolbar(IUnknown punkSrc, const(wchar)* pwszItem, uint dwAddFlags);
    HRESULT RemoveToolbar(IUnknown punkSrc, uint dwRemoveFlags);
    HRESULT FindToolbar(const(wchar)* pwszItem, const(Guid)* riid, void** ppv);
}

const GUID IID_IThumbnailCapture = {0x4EA39266, 0x7211, 0x409F, [0xB6, 0x22, 0xF6, 0x3D, 0xBD, 0x16, 0xC5, 0x33]};
@GUID(0x4EA39266, 0x7211, 0x409F, [0xB6, 0x22, 0xF6, 0x3D, 0xBD, 0x16, 0xC5, 0x33]);
interface IThumbnailCapture : IUnknown
{
    HRESULT CaptureThumbnail(const(SIZE)* pMaxSize, IUnknown pHTMLDoc2, HBITMAP* phbmThumbnail);
}

struct BANDINFOSFB
{
    uint dwMask;
    uint dwStateMask;
    uint dwState;
    uint crBkgnd;
    uint crBtnLt;
    uint crBtnDk;
    ushort wViewMode;
    ushort wAlign;
    IShellFolder psf;
    ITEMIDLIST* pidl;
}

const GUID IID_IShellFolderBand = {0x7FE80CC8, 0xC247, 0x11D0, [0xB9, 0x3A, 0x00, 0xA0, 0xC9, 0x03, 0x12, 0xE1]};
@GUID(0x7FE80CC8, 0xC247, 0x11D0, [0xB9, 0x3A, 0x00, 0xA0, 0xC9, 0x03, 0x12, 0xE1]);
interface IShellFolderBand : IUnknown
{
    HRESULT InitializeSFB(IShellFolder psf, ITEMIDLIST* pidl);
    HRESULT SetBandInfoSFB(BANDINFOSFB* pbi);
    HRESULT GetBandInfoSFB(BANDINFOSFB* pbi);
}

const GUID IID_IDeskBarClient = {0xEB0FE175, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]};
@GUID(0xEB0FE175, 0x1A3A, 0x11D0, [0x89, 0xB3, 0x00, 0xA0, 0xC9, 0x0A, 0x90, 0xAC]);
interface IDeskBarClient : IOleWindow
{
    HRESULT SetDeskBarSite(IUnknown punkSite);
    HRESULT SetModeDBC(uint dwMode);
    HRESULT UIActivateDBC(uint dwState);
    HRESULT GetSize(uint dwWhich, RECT* prc);
}

struct SHCOLUMNINFO
{
    PROPERTYKEY scid;
    ushort vt;
    uint fmt;
    uint cChars;
    uint csFlags;
    ushort wszTitle;
    ushort wszDescription;
}

struct SHCOLUMNINIT
{
    uint dwFlags;
    uint dwReserved;
    ushort wszFolder;
}

struct SHCOLUMNDATA
{
    uint dwFlags;
    uint dwFileAttributes;
    uint dwReserved;
    ushort* pwszExt;
    ushort wszFile;
}

const GUID IID_IColumnProvider = {0xE8025004, 0x1C42, 0x11D2, [0xBE, 0x2C, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]};
@GUID(0xE8025004, 0x1C42, 0x11D2, [0xBE, 0x2C, 0x00, 0xA0, 0xC9, 0xA8, 0x3D, 0xA1]);
interface IColumnProvider : IUnknown
{
    HRESULT Initialize(SHCOLUMNINIT* psci);
    HRESULT GetColumnInfo(uint dwIndex, SHCOLUMNINFO* psci);
    HRESULT GetItemData(PROPERTYKEY* pscid, SHCOLUMNDATA* pscd, VARIANT* pvarData);
}

struct SHChangeProductKeyAsIDList
{
    ushort cb;
    ushort wszProductKey;
    ushort cbZero;
}

const GUID IID_IDocViewSite = {0x87D605E0, 0xC511, 0x11CF, [0x89, 0xA9, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x29]};
@GUID(0x87D605E0, 0xC511, 0x11CF, [0x89, 0xA9, 0x00, 0xA0, 0xC9, 0x05, 0x41, 0x29]);
interface IDocViewSite : IUnknown
{
    HRESULT OnSetTitle(VARIANT* pvTitle);
}

const GUID IID_IInitializeObject = {0x4622AD16, 0xFF23, 0x11D0, [0x8D, 0x34, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]};
@GUID(0x4622AD16, 0xFF23, 0x11D0, [0x8D, 0x34, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]);
interface IInitializeObject : IUnknown
{
    HRESULT Initialize();
}

const GUID IID_IBanneredBar = {0x596A9A94, 0x013E, 0x11D1, [0x8D, 0x34, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]};
@GUID(0x596A9A94, 0x013E, 0x11D1, [0x8D, 0x34, 0x00, 0xA0, 0xC9, 0x0F, 0x27, 0x19]);
interface IBanneredBar : IUnknown
{
    HRESULT SetIconSize(uint iIcon);
    HRESULT GetIconSize(uint* piIcon);
    HRESULT SetBitmap(HBITMAP hBitmap);
    HRESULT GetBitmap(HBITMAP* phBitmap);
}

struct TBINFO
{
    uint cbuttons;
    uint uFlags;
}

struct SFV_SETITEMPOS
{
    ITEMIDLIST* pidl;
    POINT pt;
}

struct AASHELLMENUFILENAME
{
    short cbTotal;
    ubyte rgbReserved;
    ushort szFileName;
}

struct AASHELLMENUITEM
{
    void* lpReserved1;
    int iReserved;
    uint uiReserved;
    AASHELLMENUFILENAME* lpName;
    const(wchar)* psz;
}

enum DISPLAY_DEVICE_TYPE
{
    DEVICE_PRIMARY = 0,
    DEVICE_IMMERSIVE = 1,
}

enum SCALE_CHANGE_FLAGS
{
    SCF_VALUE_NONE = 0,
    SCF_SCALE = 1,
    SCF_PHYSICAL = 2,
}

enum SHELL_UI_COMPONENT
{
    SHELL_UI_COMPONENT_TASKBARS = 0,
    SHELL_UI_COMPONENT_NOTIFICATIONAREA = 1,
    SHELL_UI_COMPONENT_DESKBAND = 2,
}

enum tagSFBS_FLAGS
{
    SFBS_FLAGS_ROUND_TO_NEAREST_DISPLAYED_DIGIT = 1,
    SFBS_FLAGS_TRUNCATE_UNDISPLAYED_DECIMAL_DIGITS = 2,
}

enum URL_SCHEME
{
    URL_SCHEME_INVALID = -1,
    URL_SCHEME_UNKNOWN = 0,
    URL_SCHEME_FTP = 1,
    URL_SCHEME_HTTP = 2,
    URL_SCHEME_GOPHER = 3,
    URL_SCHEME_MAILTO = 4,
    URL_SCHEME_NEWS = 5,
    URL_SCHEME_NNTP = 6,
    URL_SCHEME_TELNET = 7,
    URL_SCHEME_WAIS = 8,
    URL_SCHEME_FILE = 9,
    URL_SCHEME_MK = 10,
    URL_SCHEME_HTTPS = 11,
    URL_SCHEME_SHELL = 12,
    URL_SCHEME_SNEWS = 13,
    URL_SCHEME_LOCAL = 14,
    URL_SCHEME_JAVASCRIPT = 15,
    URL_SCHEME_VBSCRIPT = 16,
    URL_SCHEME_ABOUT = 17,
    URL_SCHEME_RES = 18,
    URL_SCHEME_MSSHELLROOTED = 19,
    URL_SCHEME_MSSHELLIDLIST = 20,
    URL_SCHEME_MSHELP = 21,
    URL_SCHEME_MSSHELLDEVICE = 22,
    URL_SCHEME_WILDCARD = 23,
    URL_SCHEME_SEARCH_MS = 24,
    URL_SCHEME_SEARCH = 25,
    URL_SCHEME_KNOWNFOLDER = 26,
    URL_SCHEME_MAXVALUE = 27,
}

enum URL_PART
{
    URL_PART_NONE = 0,
    URL_PART_SCHEME = 1,
    URL_PART_HOSTNAME = 2,
    URL_PART_USERNAME = 3,
    URL_PART_PASSWORD = 4,
    URL_PART_PORT = 5,
    URL_PART_QUERY = 6,
}

enum URLIS
{
    URLIS_URL = 0,
    URLIS_OPAQUE = 1,
    URLIS_NOHISTORY = 2,
    URLIS_FILEURL = 3,
    URLIS_APPLIABLE = 4,
    URLIS_DIRECTORY = 5,
    URLIS_HASQUERY = 6,
}

struct PARSEDURLA
{
    uint cbSize;
    const(char)* pszProtocol;
    uint cchProtocol;
    const(char)* pszSuffix;
    uint cchSuffix;
    uint nScheme;
}

struct PARSEDURLW
{
    uint cbSize;
    const(wchar)* pszProtocol;
    uint cchProtocol;
    const(wchar)* pszSuffix;
    uint cchSuffix;
    uint nScheme;
}

enum SHREGDEL_FLAGS
{
    SHREGDEL_DEFAULT = 0,
    SHREGDEL_HKCU = 1,
    SHREGDEL_HKLM = 16,
    SHREGDEL_BOTH = 17,
}

enum SHREGENUM_FLAGS
{
    SHREGENUM_DEFAULT = 0,
    SHREGENUM_HKCU = 1,
    SHREGENUM_HKLM = 16,
    SHREGENUM_BOTH = 17,
}

enum ASSOCSTR
{
    ASSOCSTR_COMMAND = 1,
    ASSOCSTR_EXECUTABLE = 2,
    ASSOCSTR_FRIENDLYDOCNAME = 3,
    ASSOCSTR_FRIENDLYAPPNAME = 4,
    ASSOCSTR_NOOPEN = 5,
    ASSOCSTR_SHELLNEWVALUE = 6,
    ASSOCSTR_DDECOMMAND = 7,
    ASSOCSTR_DDEIFEXEC = 8,
    ASSOCSTR_DDEAPPLICATION = 9,
    ASSOCSTR_DDETOPIC = 10,
    ASSOCSTR_INFOTIP = 11,
    ASSOCSTR_QUICKTIP = 12,
    ASSOCSTR_TILEINFO = 13,
    ASSOCSTR_CONTENTTYPE = 14,
    ASSOCSTR_DEFAULTICON = 15,
    ASSOCSTR_SHELLEXTENSION = 16,
    ASSOCSTR_DROPTARGET = 17,
    ASSOCSTR_DELEGATEEXECUTE = 18,
    ASSOCSTR_SUPPORTED_URI_PROTOCOLS = 19,
    ASSOCSTR_PROGID = 20,
    ASSOCSTR_APPID = 21,
    ASSOCSTR_APPPUBLISHER = 22,
    ASSOCSTR_APPICONREFERENCE = 23,
    ASSOCSTR_MAX = 24,
}

enum ASSOCKEY
{
    ASSOCKEY_SHELLEXECCLASS = 1,
    ASSOCKEY_APP = 2,
    ASSOCKEY_CLASS = 3,
    ASSOCKEY_BASECLASS = 4,
    ASSOCKEY_MAX = 5,
}

enum ASSOCDATA
{
    ASSOCDATA_MSIDESCRIPTOR = 1,
    ASSOCDATA_NOACTIVATEHANDLER = 2,
    ASSOCDATA_UNUSED1 = 3,
    ASSOCDATA_HASPERUSERASSOC = 4,
    ASSOCDATA_EDITFLAGS = 5,
    ASSOCDATA_VALUE = 6,
    ASSOCDATA_MAX = 7,
}

enum ASSOCENUM
{
    ASSOCENUM_NONE = 0,
}

enum FILETYPEATTRIBUTEFLAGS
{
    FTA_None = 0,
    FTA_Exclude = 1,
    FTA_Show = 2,
    FTA_HasExtension = 4,
    FTA_NoEdit = 8,
    FTA_NoRemove = 16,
    FTA_NoNewVerb = 32,
    FTA_NoEditVerb = 64,
    FTA_NoRemoveVerb = 128,
    FTA_NoEditDesc = 256,
    FTA_NoEditIcon = 512,
    FTA_NoEditDflt = 1024,
    FTA_NoEditVerbCmd = 2048,
    FTA_NoEditVerbExe = 4096,
    FTA_NoDDE = 8192,
    FTA_NoEditMIME = 32768,
    FTA_OpenIsSafe = 65536,
    FTA_AlwaysUnsafe = 131072,
    FTA_NoRecentDocs = 1048576,
    FTA_SafeForElevation = 2097152,
    FTA_AlwaysUseDirectInvoke = 4194304,
}

const GUID IID_IQueryAssociations = {0xC46CA590, 0x3C3F, 0x11D2, [0xBE, 0xE6, 0x00, 0x00, 0xF8, 0x05, 0xCA, 0x57]};
@GUID(0xC46CA590, 0x3C3F, 0x11D2, [0xBE, 0xE6, 0x00, 0x00, 0xF8, 0x05, 0xCA, 0x57]);
interface IQueryAssociations : IUnknown
{
    HRESULT Init(uint flags, const(wchar)* pszAssoc, HKEY hkProgid, HWND hwnd);
    HRESULT GetString(uint flags, ASSOCSTR str, const(wchar)* pszExtra, const(wchar)* pszOut, uint* pcchOut);
    HRESULT GetKey(uint flags, ASSOCKEY key, const(wchar)* pszExtra, HKEY* phkeyOut);
    HRESULT GetData(uint flags, ASSOCDATA data, const(wchar)* pszExtra, char* pvOut, uint* pcbOut);
    HRESULT GetEnum(uint flags, ASSOCENUM assocenum, const(wchar)* pszExtra, const(Guid)* riid, void** ppvOut);
}

enum SHGLOBALCOUNTER
{
    GLOBALCOUNTER_SEARCHMANAGER = 0,
    GLOBALCOUNTER_SEARCHOPTIONS = 1,
    GLOBALCOUNTER_FOLDERSETTINGSCHANGE = 2,
    GLOBALCOUNTER_RATINGS = 3,
    GLOBALCOUNTER_APPROVEDSITES = 4,
    GLOBALCOUNTER_RESTRICTIONS = 5,
    GLOBALCOUNTER_SHELLSETTINGSCHANGED = 6,
    GLOBALCOUNTER_SYSTEMPIDLCHANGE = 7,
    GLOBALCOUNTER_OVERLAYMANAGER = 8,
    GLOBALCOUNTER_QUERYASSOCIATIONS = 9,
    GLOBALCOUNTER_IESESSIONS = 10,
    GLOBALCOUNTER_IEONLY_SESSIONS = 11,
    GLOBALCOUNTER_APPLICATION_DESTINATIONS = 12,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_CSCSYNCINPROGRESS = 13,
    GLOBALCOUNTER_BITBUCKETNUMDELETERS = 14,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SHARES = 15,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_A = 16,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_B = 17,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_C = 18,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_D = 19,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_E = 20,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_F = 21,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_G = 22,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_H = 23,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_I = 24,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_J = 25,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_K = 26,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_L = 27,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_M = 28,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_N = 29,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_O = 30,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_P = 31,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Q = 32,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_R = 33,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_S = 34,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_T = 35,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_U = 36,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_V = 37,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_W = 38,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_X = 39,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Y = 40,
    GLOBALCOUNTER_RECYCLEDIRTYCOUNT_DRIVE_Z = 41,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEDIRTYCOUNT_SERVERDRIVE = 42,
    __UNUSED_RECYCLE_WAS_GLOBALCOUNTER_RECYCLEGLOBALDIRTYCOUNT = 43,
    GLOBALCOUNTER_RECYCLEBINENUM = 44,
    GLOBALCOUNTER_RECYCLEBINCORRUPTED = 45,
    GLOBALCOUNTER_RATINGS_STATECOUNTER = 46,
    GLOBALCOUNTER_PRIVATE_PROFILE_CACHE = 47,
    GLOBALCOUNTER_INTERNETTOOLBAR_LAYOUT = 48,
    GLOBALCOUNTER_FOLDERDEFINITION_CACHE = 49,
    GLOBALCOUNTER_COMMONPLACES_LIST_CACHE = 50,
    GLOBALCOUNTER_PRIVATE_PROFILE_CACHE_MACHINEWIDE = 51,
    GLOBALCOUNTER_ASSOCCHANGED = 52,
    GLOBALCOUNTER_APP_ITEMS_STATE_STORE_CACHE = 53,
    GLOBALCOUNTER_SETTINGSYNC_ENABLED = 54,
    GLOBALCOUNTER_APPSFOLDER_FILETYPEASSOCIATION_COUNTER = 55,
    GLOBALCOUNTER_USERINFOCHANGED = 56,
    GLOBALCOUNTER_SYNC_ENGINE_INFORMATION_CACHE_MACHINEWIDE = 57,
    GLOBALCOUNTER_BANNERS_DATAMODEL_CACHE_MACHINEWIDE = 58,
    GLOBALCOUNTER_MAXIMUMVALUE = 59,
}

struct QITAB
{
    const(Guid)* piid;
    uint dwOffset;
}

struct DLLVERSIONINFO
{
    uint cbSize;
    uint dwMajorVersion;
    uint dwMinorVersion;
    uint dwBuildNumber;
    uint dwPlatformID;
}

struct DLLVERSIONINFO2
{
    DLLVERSIONINFO info1;
    uint dwFlags;
    ulong ullVersion;
}

alias DLLGETVERSIONPROC = extern(Windows) HRESULT function(DLLVERSIONINFO* param0);
enum APPINFODATAFLAGS
{
    AIM_DISPLAYNAME = 1,
    AIM_VERSION = 2,
    AIM_PUBLISHER = 4,
    AIM_PRODUCTID = 8,
    AIM_REGISTEREDOWNER = 16,
    AIM_REGISTEREDCOMPANY = 32,
    AIM_LANGUAGE = 64,
    AIM_SUPPORTURL = 128,
    AIM_SUPPORTTELEPHONE = 256,
    AIM_HELPLINK = 512,
    AIM_INSTALLLOCATION = 1024,
    AIM_INSTALLSOURCE = 2048,
    AIM_INSTALLDATE = 4096,
    AIM_CONTACT = 16384,
    AIM_COMMENTS = 32768,
    AIM_IMAGE = 131072,
    AIM_READMEURL = 262144,
    AIM_UPDATEINFOURL = 524288,
}

struct APPINFODATA
{
    uint cbSize;
    uint dwMask;
    const(wchar)* pszDisplayName;
    const(wchar)* pszVersion;
    const(wchar)* pszPublisher;
    const(wchar)* pszProductID;
    const(wchar)* pszRegisteredOwner;
    const(wchar)* pszRegisteredCompany;
    const(wchar)* pszLanguage;
    const(wchar)* pszSupportUrl;
    const(wchar)* pszSupportTelephone;
    const(wchar)* pszHelpLink;
    const(wchar)* pszInstallLocation;
    const(wchar)* pszInstallSource;
    const(wchar)* pszInstallDate;
    const(wchar)* pszContact;
    const(wchar)* pszComments;
    const(wchar)* pszImage;
    const(wchar)* pszReadmeUrl;
    const(wchar)* pszUpdateInfoUrl;
}

enum APPACTIONFLAGS
{
    APPACTION_INSTALL = 1,
    APPACTION_UNINSTALL = 2,
    APPACTION_MODIFY = 4,
    APPACTION_REPAIR = 8,
    APPACTION_UPGRADE = 16,
    APPACTION_CANGETSIZE = 32,
    APPACTION_MODIFYREMOVE = 128,
    APPACTION_ADDLATER = 256,
    APPACTION_UNSCHEDULE = 512,
}

struct SLOWAPPINFO
{
    ulong ullSize;
    FILETIME ftLastUsed;
    int iTimesUsed;
    const(wchar)* pszImage;
}

const GUID IID_IShellApp = {0xA3E14960, 0x935F, 0x11D1, [0xB8, 0xB8, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]};
@GUID(0xA3E14960, 0x935F, 0x11D1, [0xB8, 0xB8, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]);
interface IShellApp : IUnknown
{
    HRESULT GetAppInfo(APPINFODATA* pai);
    HRESULT GetPossibleActions(uint* pdwActions);
    HRESULT GetSlowAppInfo(SLOWAPPINFO* psaid);
    HRESULT GetCachedSlowAppInfo(SLOWAPPINFO* psaid);
    HRESULT IsInstalled();
}

enum PUBAPPINFOFLAGS
{
    PAI_SOURCE = 1,
    PAI_ASSIGNEDTIME = 2,
    PAI_PUBLISHEDTIME = 4,
    PAI_SCHEDULEDTIME = 8,
    PAI_EXPIRETIME = 16,
}

struct PUBAPPINFO
{
    uint cbSize;
    uint dwMask;
    const(wchar)* pszSource;
    SYSTEMTIME stAssigned;
    SYSTEMTIME stPublished;
    SYSTEMTIME stScheduled;
    SYSTEMTIME stExpire;
}

const GUID IID_IPublishedApp = {0x1BC752E0, 0x9046, 0x11D1, [0xB8, 0xB3, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]};
@GUID(0x1BC752E0, 0x9046, 0x11D1, [0xB8, 0xB3, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]);
interface IPublishedApp : IShellApp
{
    HRESULT Install(SYSTEMTIME* pstInstall);
    HRESULT GetPublishedAppInfo(PUBAPPINFO* ppai);
    HRESULT Unschedule();
}

const GUID IID_IPublishedApp2 = {0x12B81347, 0x1B3A, 0x4A04, [0xAA, 0x61, 0x3F, 0x76, 0x8B, 0x67, 0xFD, 0x7E]};
@GUID(0x12B81347, 0x1B3A, 0x4A04, [0xAA, 0x61, 0x3F, 0x76, 0x8B, 0x67, 0xFD, 0x7E]);
interface IPublishedApp2 : IPublishedApp
{
    HRESULT Install2(SYSTEMTIME* pstInstall, HWND hwndParent);
}

const GUID IID_IEnumPublishedApps = {0x0B124F8C, 0x91F0, 0x11D1, [0xB8, 0xB5, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]};
@GUID(0x0B124F8C, 0x91F0, 0x11D1, [0xB8, 0xB5, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]);
interface IEnumPublishedApps : IUnknown
{
    HRESULT Next(IPublishedApp* pia);
    HRESULT Reset();
}

const GUID IID_IAppPublisher = {0x07250A10, 0x9CF9, 0x11D1, [0x90, 0x76, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]};
@GUID(0x07250A10, 0x9CF9, 0x11D1, [0x90, 0x76, 0x00, 0x60, 0x08, 0x05, 0x93, 0x82]);
interface IAppPublisher : IUnknown
{
    HRESULT GetNumberOfCategories(uint* pdwCat);
    HRESULT GetCategories(APPCATEGORYINFOLIST* pAppCategoryList);
    HRESULT GetNumberOfApps(uint* pdwApps);
    HRESULT EnumApps(Guid* pAppCategoryId, IEnumPublishedApps* ppepa);
}

const GUID CLSID_PasswordCredentialProvider = {0x60B78E88, 0xEAD8, 0x445C, [0x9C, 0xFD, 0x0B, 0x87, 0xF7, 0x4E, 0xA6, 0xCD]};
@GUID(0x60B78E88, 0xEAD8, 0x445C, [0x9C, 0xFD, 0x0B, 0x87, 0xF7, 0x4E, 0xA6, 0xCD]);
struct PasswordCredentialProvider;

const GUID CLSID_V1PasswordCredentialProvider = {0x6F45DC1E, 0x5384, 0x457A, [0xBC, 0x13, 0x2C, 0xD8, 0x1B, 0x0D, 0x28, 0xED]};
@GUID(0x6F45DC1E, 0x5384, 0x457A, [0xBC, 0x13, 0x2C, 0xD8, 0x1B, 0x0D, 0x28, 0xED]);
struct V1PasswordCredentialProvider;

const GUID CLSID_PINLogonCredentialProvider = {0xCB82EA12, 0x9F71, 0x446D, [0x89, 0xE1, 0x8D, 0x09, 0x24, 0xE1, 0x25, 0x6E]};
@GUID(0xCB82EA12, 0x9F71, 0x446D, [0x89, 0xE1, 0x8D, 0x09, 0x24, 0xE1, 0x25, 0x6E]);
struct PINLogonCredentialProvider;

const GUID CLSID_NPCredentialProvider = {0x3DD6BEC0, 0x8193, 0x4FFE, [0xAE, 0x25, 0xE0, 0x8E, 0x39, 0xEA, 0x40, 0x63]};
@GUID(0x3DD6BEC0, 0x8193, 0x4FFE, [0xAE, 0x25, 0xE0, 0x8E, 0x39, 0xEA, 0x40, 0x63]);
struct NPCredentialProvider;

const GUID CLSID_SmartcardCredentialProvider = {0x8FD7E19C, 0x3BF7, 0x489B, [0xA7, 0x2C, 0x84, 0x6A, 0xB3, 0x67, 0x8C, 0x96]};
@GUID(0x8FD7E19C, 0x3BF7, 0x489B, [0xA7, 0x2C, 0x84, 0x6A, 0xB3, 0x67, 0x8C, 0x96]);
struct SmartcardCredentialProvider;

const GUID CLSID_V1SmartcardCredentialProvider = {0x8BF9A910, 0xA8FF, 0x457F, [0x99, 0x9F, 0xA5, 0xCA, 0x10, 0xB4, 0xA8, 0x85]};
@GUID(0x8BF9A910, 0xA8FF, 0x457F, [0x99, 0x9F, 0xA5, 0xCA, 0x10, 0xB4, 0xA8, 0x85]);
struct V1SmartcardCredentialProvider;

const GUID CLSID_SmartcardPinProvider = {0x94596C7E, 0x3744, 0x41CE, [0x89, 0x3E, 0xBB, 0xF0, 0x91, 0x22, 0xF7, 0x6A]};
@GUID(0x94596C7E, 0x3744, 0x41CE, [0x89, 0x3E, 0xBB, 0xF0, 0x91, 0x22, 0xF7, 0x6A]);
struct SmartcardPinProvider;

const GUID CLSID_SmartcardReaderSelectionProvider = {0x1B283861, 0x754F, 0x4022, [0xAD, 0x47, 0xA5, 0xEA, 0xAA, 0x61, 0x88, 0x94]};
@GUID(0x1B283861, 0x754F, 0x4022, [0xAD, 0x47, 0xA5, 0xEA, 0xAA, 0x61, 0x88, 0x94]);
struct SmartcardReaderSelectionProvider;

const GUID CLSID_SmartcardWinRTProvider = {0x1EE7337F, 0x85AC, 0x45E2, [0xA2, 0x3C, 0x37, 0xC7, 0x53, 0x20, 0x97, 0x69]};
@GUID(0x1EE7337F, 0x85AC, 0x45E2, [0xA2, 0x3C, 0x37, 0xC7, 0x53, 0x20, 0x97, 0x69]);
struct SmartcardWinRTProvider;

const GUID CLSID_GenericCredentialProvider = {0x25CBB996, 0x92ED, 0x457E, [0xB2, 0x8C, 0x47, 0x74, 0x08, 0x4B, 0xD5, 0x62]};
@GUID(0x25CBB996, 0x92ED, 0x457E, [0xB2, 0x8C, 0x47, 0x74, 0x08, 0x4B, 0xD5, 0x62]);
struct GenericCredentialProvider;

const GUID CLSID_RASProvider = {0x5537E283, 0xB1E7, 0x4EF8, [0x9C, 0x6E, 0x7A, 0xB0, 0xAF, 0xE5, 0x05, 0x6D]};
@GUID(0x5537E283, 0xB1E7, 0x4EF8, [0x9C, 0x6E, 0x7A, 0xB0, 0xAF, 0xE5, 0x05, 0x6D]);
struct RASProvider;

const GUID CLSID_OnexCredentialProvider = {0x07AA0886, 0xCC8D, 0x4E19, [0xA4, 0x10, 0x1C, 0x75, 0xAF, 0x68, 0x6E, 0x62]};
@GUID(0x07AA0886, 0xCC8D, 0x4E19, [0xA4, 0x10, 0x1C, 0x75, 0xAF, 0x68, 0x6E, 0x62]);
struct OnexCredentialProvider;

const GUID CLSID_OnexPlapSmartcardCredentialProvider = {0x33C86CD6, 0x705F, 0x4BA1, [0x9A, 0xDB, 0x67, 0x07, 0x0B, 0x83, 0x77, 0x75]};
@GUID(0x33C86CD6, 0x705F, 0x4BA1, [0x9A, 0xDB, 0x67, 0x07, 0x0B, 0x83, 0x77, 0x75]);
struct OnexPlapSmartcardCredentialProvider;

const GUID CLSID_VaultProvider = {0x503739D0, 0x4C5E, 0x4CFD, [0xB3, 0xBA, 0xD8, 0x81, 0x33, 0x4F, 0x0D, 0xF2]};
@GUID(0x503739D0, 0x4C5E, 0x4CFD, [0xB3, 0xBA, 0xD8, 0x81, 0x33, 0x4F, 0x0D, 0xF2]);
struct VaultProvider;

const GUID CLSID_WinBioCredentialProvider = {0xBEC09223, 0xB018, 0x416D, [0xA0, 0xAC, 0x52, 0x39, 0x71, 0xB6, 0x39, 0xF5]};
@GUID(0xBEC09223, 0xB018, 0x416D, [0xA0, 0xAC, 0x52, 0x39, 0x71, 0xB6, 0x39, 0xF5]);
struct WinBioCredentialProvider;

const GUID CLSID_V1WinBioCredentialProvider = {0xAC3AC249, 0xE820, 0x4343, [0xA6, 0x5B, 0x37, 0x7A, 0xC6, 0x34, 0xDC, 0x09]};
@GUID(0xAC3AC249, 0xE820, 0x4343, [0xA6, 0x5B, 0x37, 0x7A, 0xC6, 0x34, 0xDC, 0x09]);
struct V1WinBioCredentialProvider;

enum CREDENTIAL_PROVIDER_USAGE_SCENARIO
{
    CPUS_INVALID = 0,
    CPUS_LOGON = 1,
    CPUS_UNLOCK_WORKSTATION = 2,
    CPUS_CHANGE_PASSWORD = 3,
    CPUS_CREDUI = 4,
    CPUS_PLAP = 5,
}

enum CREDENTIAL_PROVIDER_FIELD_TYPE
{
    CPFT_INVALID = 0,
    CPFT_LARGE_TEXT = 1,
    CPFT_SMALL_TEXT = 2,
    CPFT_COMMAND_LINK = 3,
    CPFT_EDIT_TEXT = 4,
    CPFT_PASSWORD_TEXT = 5,
    CPFT_TILE_IMAGE = 6,
    CPFT_CHECKBOX = 7,
    CPFT_COMBOBOX = 8,
    CPFT_SUBMIT_BUTTON = 9,
}

enum CREDENTIAL_PROVIDER_FIELD_STATE
{
    CPFS_HIDDEN = 0,
    CPFS_DISPLAY_IN_SELECTED_TILE = 1,
    CPFS_DISPLAY_IN_DESELECTED_TILE = 2,
    CPFS_DISPLAY_IN_BOTH = 3,
}

enum CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE
{
    CPFIS_NONE = 0,
    CPFIS_READONLY = 1,
    CPFIS_DISABLED = 2,
    CPFIS_FOCUSED = 3,
}

struct CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR
{
    uint dwFieldID;
    CREDENTIAL_PROVIDER_FIELD_TYPE cpft;
    const(wchar)* pszLabel;
    Guid guidFieldType;
}

enum CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE
{
    CPGSR_NO_CREDENTIAL_NOT_FINISHED = 0,
    CPGSR_NO_CREDENTIAL_FINISHED = 1,
    CPGSR_RETURN_CREDENTIAL_FINISHED = 2,
    CPGSR_RETURN_NO_CREDENTIAL_FINISHED = 3,
}

enum CREDENTIAL_PROVIDER_STATUS_ICON
{
    CPSI_NONE = 0,
    CPSI_ERROR = 1,
    CPSI_WARNING = 2,
    CPSI_SUCCESS = 3,
}

struct CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION
{
    uint ulAuthenticationPackage;
    Guid clsidCredentialProvider;
    uint cbSerialization;
    ubyte* rgbSerialization;
}

enum CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS
{
    CPAO_NONE = 0,
    CPAO_EMPTY_LOCAL = 1,
    CPAO_EMPTY_CONNECTED = 2,
}

enum CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS
{
    CPCFO_NONE = 0,
    CPCFO_ENABLE_PASSWORD_REVEAL = 1,
    CPCFO_IS_EMAIL_ADDRESS = 2,
    CPCFO_ENABLE_TOUCH_KEYBOARD_AUTO_INVOKE = 4,
    CPCFO_NUMBERS_ONLY = 8,
    CPCFO_SHOW_ENGLISH_KEYBOARD = 16,
}

const GUID IID_ICredentialProviderCredential = {0x63913A93, 0x40C1, 0x481A, [0x81, 0x8D, 0x40, 0x72, 0xFF, 0x8C, 0x70, 0xCC]};
@GUID(0x63913A93, 0x40C1, 0x481A, [0x81, 0x8D, 0x40, 0x72, 0xFF, 0x8C, 0x70, 0xCC]);
interface ICredentialProviderCredential : IUnknown
{
    HRESULT Advise(ICredentialProviderCredentialEvents pcpce);
    HRESULT UnAdvise();
    HRESULT SetSelected(int* pbAutoLogon);
    HRESULT SetDeselected();
    HRESULT GetFieldState(uint dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE* pcpfs, CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE* pcpfis);
    HRESULT GetStringValue(uint dwFieldID, ushort** ppsz);
    HRESULT GetBitmapValue(uint dwFieldID, HBITMAP* phbmp);
    HRESULT GetCheckboxValue(uint dwFieldID, int* pbChecked, ushort** ppszLabel);
    HRESULT GetSubmitButtonValue(uint dwFieldID, uint* pdwAdjacentTo);
    HRESULT GetComboBoxValueCount(uint dwFieldID, uint* pcItems, uint* pdwSelectedItem);
    HRESULT GetComboBoxValueAt(uint dwFieldID, uint dwItem, ushort** ppszItem);
    HRESULT SetStringValue(uint dwFieldID, const(wchar)* psz);
    HRESULT SetCheckboxValue(uint dwFieldID, BOOL bChecked);
    HRESULT SetComboBoxSelectedValue(uint dwFieldID, uint dwSelectedItem);
    HRESULT CommandLinkClicked(uint dwFieldID);
    HRESULT GetSerialization(CREDENTIAL_PROVIDER_GET_SERIALIZATION_RESPONSE* pcpgsr, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION* pcpcs, ushort** ppszOptionalStatusText, CREDENTIAL_PROVIDER_STATUS_ICON* pcpsiOptionalStatusIcon);
    HRESULT ReportResult(NTSTATUS ntsStatus, NTSTATUS ntsSubstatus, ushort** ppszOptionalStatusText, CREDENTIAL_PROVIDER_STATUS_ICON* pcpsiOptionalStatusIcon);
}

const GUID IID_IQueryContinueWithStatus = {0x9090BE5B, 0x502B, 0x41FB, [0xBC, 0xCC, 0x00, 0x49, 0xA6, 0xC7, 0x25, 0x4B]};
@GUID(0x9090BE5B, 0x502B, 0x41FB, [0xBC, 0xCC, 0x00, 0x49, 0xA6, 0xC7, 0x25, 0x4B]);
interface IQueryContinueWithStatus : IQueryContinue
{
    HRESULT SetStatusMessage(const(wchar)* psz);
}

const GUID IID_IConnectableCredentialProviderCredential = {0x9387928B, 0xAC75, 0x4BF9, [0x8A, 0xB2, 0x2B, 0x93, 0xC4, 0xA5, 0x52, 0x90]};
@GUID(0x9387928B, 0xAC75, 0x4BF9, [0x8A, 0xB2, 0x2B, 0x93, 0xC4, 0xA5, 0x52, 0x90]);
interface IConnectableCredentialProviderCredential : ICredentialProviderCredential
{
    HRESULT Connect(IQueryContinueWithStatus pqcws);
    HRESULT Disconnect();
}

const GUID IID_ICredentialProviderCredentialEvents = {0xFA6FA76B, 0x66B7, 0x4B11, [0x95, 0xF1, 0x86, 0x17, 0x11, 0x18, 0xE8, 0x16]};
@GUID(0xFA6FA76B, 0x66B7, 0x4B11, [0x95, 0xF1, 0x86, 0x17, 0x11, 0x18, 0xE8, 0x16]);
interface ICredentialProviderCredentialEvents : IUnknown
{
    HRESULT SetFieldState(ICredentialProviderCredential pcpc, uint dwFieldID, CREDENTIAL_PROVIDER_FIELD_STATE cpfs);
    HRESULT SetFieldInteractiveState(ICredentialProviderCredential pcpc, uint dwFieldID, CREDENTIAL_PROVIDER_FIELD_INTERACTIVE_STATE cpfis);
    HRESULT SetFieldString(ICredentialProviderCredential pcpc, uint dwFieldID, const(wchar)* psz);
    HRESULT SetFieldCheckbox(ICredentialProviderCredential pcpc, uint dwFieldID, BOOL bChecked, const(wchar)* pszLabel);
    HRESULT SetFieldBitmap(ICredentialProviderCredential pcpc, uint dwFieldID, HBITMAP hbmp);
    HRESULT SetFieldComboBoxSelectedItem(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwSelectedItem);
    HRESULT DeleteFieldComboBoxItem(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwItem);
    HRESULT AppendFieldComboBoxItem(ICredentialProviderCredential pcpc, uint dwFieldID, const(wchar)* pszItem);
    HRESULT SetFieldSubmitButton(ICredentialProviderCredential pcpc, uint dwFieldID, uint dwAdjacentTo);
    HRESULT OnCreatingWindow(HWND* phwndOwner);
}

const GUID IID_ICredentialProvider = {0xD27C3481, 0x5A1C, 0x45B2, [0x8A, 0xAA, 0xC2, 0x0E, 0xBB, 0xE8, 0x22, 0x9E]};
@GUID(0xD27C3481, 0x5A1C, 0x45B2, [0x8A, 0xAA, 0xC2, 0x0E, 0xBB, 0xE8, 0x22, 0x9E]);
interface ICredentialProvider : IUnknown
{
    HRESULT SetUsageScenario(CREDENTIAL_PROVIDER_USAGE_SCENARIO cpus, uint dwFlags);
    HRESULT SetSerialization(const(CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION)* pcpcs);
    HRESULT Advise(ICredentialProviderEvents pcpe, uint upAdviseContext);
    HRESULT UnAdvise();
    HRESULT GetFieldDescriptorCount(uint* pdwCount);
    HRESULT GetFieldDescriptorAt(uint dwIndex, CREDENTIAL_PROVIDER_FIELD_DESCRIPTOR** ppcpfd);
    HRESULT GetCredentialCount(uint* pdwCount, uint* pdwDefault, int* pbAutoLogonWithDefault);
    HRESULT GetCredentialAt(uint dwIndex, ICredentialProviderCredential* ppcpc);
}

const GUID IID_ICredentialProviderEvents = {0x34201E5A, 0xA787, 0x41A3, [0xA5, 0xA4, 0xBD, 0x6D, 0xCF, 0x2A, 0x85, 0x4E]};
@GUID(0x34201E5A, 0xA787, 0x41A3, [0xA5, 0xA4, 0xBD, 0x6D, 0xCF, 0x2A, 0x85, 0x4E]);
interface ICredentialProviderEvents : IUnknown
{
    HRESULT CredentialsChanged(uint upAdviseContext);
}

const GUID IID_ICredentialProviderFilter = {0xA5DA53F9, 0xD475, 0x4080, [0xA1, 0x20, 0x91, 0x0C, 0x4A, 0x73, 0x98, 0x80]};
@GUID(0xA5DA53F9, 0xD475, 0x4080, [0xA1, 0x20, 0x91, 0x0C, 0x4A, 0x73, 0x98, 0x80]);
interface ICredentialProviderFilter : IUnknown
{
    HRESULT Filter(CREDENTIAL_PROVIDER_USAGE_SCENARIO cpus, uint dwFlags, char* rgclsidProviders, char* rgbAllow, uint cProviders);
    HRESULT UpdateRemoteCredential(const(CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION)* pcpcsIn, CREDENTIAL_PROVIDER_CREDENTIAL_SERIALIZATION* pcpcsOut);
}

const GUID IID_ICredentialProviderCredential2 = {0xFD672C54, 0x40EA, 0x4D6E, [0x9B, 0x49, 0xCF, 0xB1, 0xA7, 0x50, 0x7B, 0xD7]};
@GUID(0xFD672C54, 0x40EA, 0x4D6E, [0x9B, 0x49, 0xCF, 0xB1, 0xA7, 0x50, 0x7B, 0xD7]);
interface ICredentialProviderCredential2 : ICredentialProviderCredential
{
    HRESULT GetUserSid(ushort** sid);
}

const GUID IID_ICredentialProviderCredentialWithFieldOptions = {0xDBC6FB30, 0xC843, 0x49E3, [0xA6, 0x45, 0x57, 0x3E, 0x6F, 0x39, 0x44, 0x6A]};
@GUID(0xDBC6FB30, 0xC843, 0x49E3, [0xA6, 0x45, 0x57, 0x3E, 0x6F, 0x39, 0x44, 0x6A]);
interface ICredentialProviderCredentialWithFieldOptions : IUnknown
{
    HRESULT GetFieldOptions(uint fieldID, CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS* options);
}

const GUID IID_ICredentialProviderCredentialEvents2 = {0xB53C00B6, 0x9922, 0x4B78, [0xB1, 0xF4, 0xDD, 0xFE, 0x77, 0x4D, 0xC3, 0x9B]};
@GUID(0xB53C00B6, 0x9922, 0x4B78, [0xB1, 0xF4, 0xDD, 0xFE, 0x77, 0x4D, 0xC3, 0x9B]);
interface ICredentialProviderCredentialEvents2 : ICredentialProviderCredentialEvents
{
    HRESULT BeginFieldUpdates();
    HRESULT EndFieldUpdates();
    HRESULT SetFieldOptions(ICredentialProviderCredential credential, uint fieldID, CREDENTIAL_PROVIDER_CREDENTIAL_FIELD_OPTIONS options);
}

const GUID IID_ICredentialProviderUser = {0x13793285, 0x3EA6, 0x40FD, [0xB4, 0x20, 0x15, 0xF4, 0x7D, 0xA4, 0x1F, 0xBB]};
@GUID(0x13793285, 0x3EA6, 0x40FD, [0xB4, 0x20, 0x15, 0xF4, 0x7D, 0xA4, 0x1F, 0xBB]);
interface ICredentialProviderUser : IUnknown
{
    HRESULT GetSid(ushort** sid);
    HRESULT GetProviderID(Guid* providerID);
    HRESULT GetStringValue(const(PROPERTYKEY)* key, ushort** stringValue);
    HRESULT GetValue(const(PROPERTYKEY)* key, PROPVARIANT* value);
}

const GUID IID_ICredentialProviderUserArray = {0x90C119AE, 0x0F18, 0x4520, [0xA1, 0xF1, 0x11, 0x43, 0x66, 0xA4, 0x0F, 0xE8]};
@GUID(0x90C119AE, 0x0F18, 0x4520, [0xA1, 0xF1, 0x11, 0x43, 0x66, 0xA4, 0x0F, 0xE8]);
interface ICredentialProviderUserArray : IUnknown
{
    HRESULT SetProviderFilter(const(Guid)* guidProviderToFilterTo);
    HRESULT GetAccountOptions(CREDENTIAL_PROVIDER_ACCOUNT_OPTIONS* credentialProviderAccountOptions);
    HRESULT GetCount(uint* userCount);
    HRESULT GetAt(uint userIndex, ICredentialProviderUser* user);
}

const GUID IID_ICredentialProviderSetUserArray = {0x095C1484, 0x1C0C, 0x4388, [0x9C, 0x6D, 0x50, 0x0E, 0x61, 0xBF, 0x84, 0xBD]};
@GUID(0x095C1484, 0x1C0C, 0x4388, [0x9C, 0x6D, 0x50, 0x0E, 0x61, 0xBF, 0x84, 0xBD]);
interface ICredentialProviderSetUserArray : IUnknown
{
    HRESULT SetUserArray(ICredentialProviderUserArray users);
}

const GUID CLSID_SyncMgrClient = {0x1202DB60, 0x1DAC, 0x42C5, [0xAE, 0xD5, 0x1A, 0xBD, 0xD4, 0x32, 0x24, 0x8E]};
@GUID(0x1202DB60, 0x1DAC, 0x42C5, [0xAE, 0xD5, 0x1A, 0xBD, 0xD4, 0x32, 0x24, 0x8E]);
struct SyncMgrClient;

const GUID CLSID_SyncMgrControl = {0x1A1F4206, 0x0688, 0x4E7F, [0xBE, 0x03, 0xD8, 0x2E, 0xC6, 0x9D, 0xF9, 0xA5]};
@GUID(0x1A1F4206, 0x0688, 0x4E7F, [0xBE, 0x03, 0xD8, 0x2E, 0xC6, 0x9D, 0xF9, 0xA5]);
struct SyncMgrControl;

const GUID CLSID_SyncMgrScheduleWizard = {0x8D8B8E30, 0xC451, 0x421B, [0x85, 0x53, 0xD2, 0x97, 0x6A, 0xFA, 0x64, 0x8C]};
@GUID(0x8D8B8E30, 0xC451, 0x421B, [0x85, 0x53, 0xD2, 0x97, 0x6A, 0xFA, 0x64, 0x8C]);
struct SyncMgrScheduleWizard;

const GUID CLSID_SyncMgrFolder = {0x9C73F5E5, 0x7AE7, 0x4E32, [0xA8, 0xE8, 0x8D, 0x23, 0xB8, 0x52, 0x55, 0xBF]};
@GUID(0x9C73F5E5, 0x7AE7, 0x4E32, [0xA8, 0xE8, 0x8D, 0x23, 0xB8, 0x52, 0x55, 0xBF]);
struct SyncMgrFolder;

const GUID CLSID_SyncSetupFolder = {0x2E9E59C0, 0xB437, 0x4981, [0xA6, 0x47, 0x9C, 0x34, 0xB9, 0xB9, 0x08, 0x91]};
@GUID(0x2E9E59C0, 0xB437, 0x4981, [0xA6, 0x47, 0x9C, 0x34, 0xB9, 0xB9, 0x08, 0x91]);
struct SyncSetupFolder;

const GUID CLSID_ConflictFolder = {0x289978AC, 0xA101, 0x4341, [0xA8, 0x17, 0x21, 0xEB, 0xA7, 0xFD, 0x04, 0x6D]};
@GUID(0x289978AC, 0xA101, 0x4341, [0xA8, 0x17, 0x21, 0xEB, 0xA7, 0xFD, 0x04, 0x6D]);
struct ConflictFolder;

const GUID CLSID_SyncResultsFolder = {0x71D99464, 0x3B6B, 0x475C, [0xB2, 0x41, 0xE1, 0x58, 0x83, 0x20, 0x75, 0x29]};
@GUID(0x71D99464, 0x3B6B, 0x475C, [0xB2, 0x41, 0xE1, 0x58, 0x83, 0x20, 0x75, 0x29]);
struct SyncResultsFolder;

const GUID CLSID_SimpleConflictPresenter = {0x7A0F6AB7, 0xED84, 0x46B6, [0xB4, 0x7E, 0x02, 0xAA, 0x15, 0x9A, 0x15, 0x2B]};
@GUID(0x7A0F6AB7, 0xED84, 0x46B6, [0xB4, 0x7E, 0x02, 0xAA, 0x15, 0x9A, 0x15, 0x2B]);
struct SimpleConflictPresenter;

const GUID IID_ISyncMgrHandlerCollection = {0xA7F337A3, 0xD20B, 0x45CB, [0x9E, 0xD7, 0x87, 0xD0, 0x94, 0xCA, 0x50, 0x45]};
@GUID(0xA7F337A3, 0xD20B, 0x45CB, [0x9E, 0xD7, 0x87, 0xD0, 0x94, 0xCA, 0x50, 0x45]);
interface ISyncMgrHandlerCollection : IUnknown
{
    HRESULT GetHandlerEnumerator(IEnumString* ppenum);
    HRESULT BindToHandler(const(wchar)* pszHandlerID, const(Guid)* riid, void** ppv);
}

enum SYNCMGR_HANDLER_CAPABILITIES
{
    SYNCMGR_HCM_NONE = 0,
    SYNCMGR_HCM_PROVIDES_ICON = 1,
    SYNCMGR_HCM_EVENT_STORE = 2,
    SYNCMGR_HCM_CONFLICT_STORE = 4,
    SYNCMGR_HCM_SUPPORTS_CONCURRENT_SESSIONS = 16,
    SYNCMGR_HCM_CAN_BROWSE_CONTENT = 65536,
    SYNCMGR_HCM_CAN_SHOW_SCHEDULE = 131072,
    SYNCMGR_HCM_QUERY_BEFORE_ACTIVATE = 1048576,
    SYNCMGR_HCM_QUERY_BEFORE_DEACTIVATE = 2097152,
    SYNCMGR_HCM_QUERY_BEFORE_ENABLE = 4194304,
    SYNCMGR_HCM_QUERY_BEFORE_DISABLE = 8388608,
    SYNCMGR_HCM_VALID_MASK = 15925271,
}

enum SYNCMGR_HANDLER_POLICIES
{
    SYNCMGR_HPM_NONE = 0,
    SYNCMGR_HPM_PREVENT_ACTIVATE = 1,
    SYNCMGR_HPM_PREVENT_DEACTIVATE = 2,
    SYNCMGR_HPM_PREVENT_ENABLE = 4,
    SYNCMGR_HPM_PREVENT_DISABLE = 8,
    SYNCMGR_HPM_PREVENT_START_SYNC = 16,
    SYNCMGR_HPM_PREVENT_STOP_SYNC = 32,
    SYNCMGR_HPM_DISABLE_ENABLE = 256,
    SYNCMGR_HPM_DISABLE_DISABLE = 512,
    SYNCMGR_HPM_DISABLE_START_SYNC = 1024,
    SYNCMGR_HPM_DISABLE_STOP_SYNC = 2048,
    SYNCMGR_HPM_DISABLE_BROWSE = 4096,
    SYNCMGR_HPM_DISABLE_SCHEDULE = 8192,
    SYNCMGR_HPM_HIDDEN_BY_DEFAULT = 65536,
    SYNCMGR_HPM_BACKGROUND_SYNC_ONLY = 48,
    SYNCMGR_HPM_VALID_MASK = 77631,
}

const GUID IID_ISyncMgrHandler = {0x04EC2E43, 0xAC77, 0x49F9, [0x9B, 0x98, 0x03, 0x07, 0xEF, 0x7A, 0x72, 0xA2]};
@GUID(0x04EC2E43, 0xAC77, 0x49F9, [0x9B, 0x98, 0x03, 0x07, 0xEF, 0x7A, 0x72, 0xA2]);
interface ISyncMgrHandler : IUnknown
{
    HRESULT GetName(ushort** ppszName);
    HRESULT GetHandlerInfo(ISyncMgrHandlerInfo* ppHandlerInfo);
    HRESULT GetObjectA(const(Guid)* rguidObjectID, const(Guid)* riid, void** ppv);
    HRESULT GetCapabilities(SYNCMGR_HANDLER_CAPABILITIES* pmCapabilities);
    HRESULT GetPolicies(SYNCMGR_HANDLER_POLICIES* pmPolicies);
    HRESULT Activate(BOOL fActivate);
    HRESULT Enable(BOOL fEnable);
    HRESULT Synchronize(char* ppszItemIDs, uint cItems, HWND hwndOwner, ISyncMgrSessionCreator pSessionCreator, IUnknown punk);
}

enum SYNCMGR_HANDLER_TYPE
{
    SYNCMGR_HT_UNSPECIFIED = 0,
    SYNCMGR_HT_APPLICATION = 1,
    SYNCMGR_HT_DEVICE = 2,
    SYNCMGR_HT_FOLDER = 3,
    SYNCMGR_HT_SERVICE = 4,
    SYNCMGR_HT_COMPUTER = 5,
    SYNCMGR_HT_MIN = 0,
    SYNCMGR_HT_MAX = 5,
}

const GUID IID_ISyncMgrHandlerInfo = {0x4FF1D798, 0xECF7, 0x4524, [0xAA, 0x81, 0x1E, 0x36, 0x2A, 0x0A, 0xEF, 0x3A]};
@GUID(0x4FF1D798, 0xECF7, 0x4524, [0xAA, 0x81, 0x1E, 0x36, 0x2A, 0x0A, 0xEF, 0x3A]);
interface ISyncMgrHandlerInfo : IUnknown
{
    HRESULT GetType(SYNCMGR_HANDLER_TYPE* pnType);
    HRESULT GetTypeLabel(ushort** ppszTypeLabel);
    HRESULT GetComment(ushort** ppszComment);
    HRESULT GetLastSyncTime(FILETIME* pftLastSync);
    HRESULT IsActive();
    HRESULT IsEnabled();
    HRESULT IsConnected();
}

const GUID IID_ISyncMgrSyncItemContainer = {0x90701133, 0xBE32, 0x4129, [0xA6, 0x5C, 0x99, 0xE6, 0x16, 0xCA, 0xFF, 0xF4]};
@GUID(0x90701133, 0xBE32, 0x4129, [0xA6, 0x5C, 0x99, 0xE6, 0x16, 0xCA, 0xFF, 0xF4]);
interface ISyncMgrSyncItemContainer : IUnknown
{
    HRESULT GetSyncItem(const(wchar)* pszItemID, ISyncMgrSyncItem* ppItem);
    HRESULT GetSyncItemEnumerator(IEnumSyncMgrSyncItems* ppenum);
    HRESULT GetSyncItemCount(uint* pcItems);
}

enum SYNCMGR_ITEM_CAPABILITIES
{
    SYNCMGR_ICM_NONE = 0,
    SYNCMGR_ICM_PROVIDES_ICON = 1,
    SYNCMGR_ICM_EVENT_STORE = 2,
    SYNCMGR_ICM_CONFLICT_STORE = 4,
    SYNCMGR_ICM_CAN_DELETE = 16,
    SYNCMGR_ICM_CAN_BROWSE_CONTENT = 65536,
    SYNCMGR_ICM_QUERY_BEFORE_ENABLE = 1048576,
    SYNCMGR_ICM_QUERY_BEFORE_DISABLE = 2097152,
    SYNCMGR_ICM_QUERY_BEFORE_DELETE = 4194304,
    SYNCMGR_ICM_VALID_MASK = 7405591,
}

enum SYNCMGR_ITEM_POLICIES
{
    SYNCMGR_IPM_NONE = 0,
    SYNCMGR_IPM_PREVENT_ENABLE = 1,
    SYNCMGR_IPM_PREVENT_DISABLE = 2,
    SYNCMGR_IPM_PREVENT_START_SYNC = 4,
    SYNCMGR_IPM_PREVENT_STOP_SYNC = 8,
    SYNCMGR_IPM_DISABLE_ENABLE = 16,
    SYNCMGR_IPM_DISABLE_DISABLE = 32,
    SYNCMGR_IPM_DISABLE_START_SYNC = 64,
    SYNCMGR_IPM_DISABLE_STOP_SYNC = 128,
    SYNCMGR_IPM_DISABLE_BROWSE = 256,
    SYNCMGR_IPM_DISABLE_DELETE = 512,
    SYNCMGR_IPM_HIDDEN_BY_DEFAULT = 65536,
    SYNCMGR_IPM_VALID_MASK = 66303,
}

const GUID IID_ISyncMgrSyncItem = {0xB20B24CE, 0x2593, 0x4F04, [0xBD, 0x8B, 0x7A, 0xD6, 0xC4, 0x50, 0x51, 0xCD]};
@GUID(0xB20B24CE, 0x2593, 0x4F04, [0xBD, 0x8B, 0x7A, 0xD6, 0xC4, 0x50, 0x51, 0xCD]);
interface ISyncMgrSyncItem : IUnknown
{
    HRESULT GetItemID(ushort** ppszItemID);
    HRESULT GetName(ushort** ppszName);
    HRESULT GetItemInfo(ISyncMgrSyncItemInfo* ppItemInfo);
    HRESULT GetObjectA(const(Guid)* rguidObjectID, const(Guid)* riid, void** ppv);
    HRESULT GetCapabilities(SYNCMGR_ITEM_CAPABILITIES* pmCapabilities);
    HRESULT GetPolicies(SYNCMGR_ITEM_POLICIES* pmPolicies);
    HRESULT Enable(BOOL fEnable);
    HRESULT Delete();
}

const GUID IID_ISyncMgrSyncItemInfo = {0xE7FD9502, 0xBE0C, 0x4464, [0x90, 0xA1, 0x2B, 0x52, 0x77, 0x03, 0x12, 0x32]};
@GUID(0xE7FD9502, 0xBE0C, 0x4464, [0x90, 0xA1, 0x2B, 0x52, 0x77, 0x03, 0x12, 0x32]);
interface ISyncMgrSyncItemInfo : IUnknown
{
    HRESULT GetTypeLabel(ushort** ppszTypeLabel);
    HRESULT GetComment(ushort** ppszComment);
    HRESULT GetLastSyncTime(FILETIME* pftLastSync);
    HRESULT IsEnabled();
    HRESULT IsConnected();
}

const GUID IID_IEnumSyncMgrSyncItems = {0x54B3ABF3, 0xF085, 0x4181, [0xB5, 0x46, 0xE2, 0x9C, 0x40, 0x3C, 0x72, 0x6B]};
@GUID(0x54B3ABF3, 0xF085, 0x4181, [0xB5, 0x46, 0xE2, 0x9C, 0x40, 0x3C, 0x72, 0x6B]);
interface IEnumSyncMgrSyncItems : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncMgrSyncItems* ppenum);
}

enum SYNCMGR_PROGRESS_STATUS
{
    SYNCMGR_PS_UPDATING = 1,
    SYNCMGR_PS_UPDATING_INDETERMINATE = 2,
    SYNCMGR_PS_SUCCEEDED = 3,
    SYNCMGR_PS_FAILED = 4,
    SYNCMGR_PS_CANCELED = 5,
    SYNCMGR_PS_DISCONNECTED = 6,
    SYNCMGR_PS_MAX = 6,
}

enum SYNCMGR_CANCEL_REQUEST
{
    SYNCMGR_CR_NONE = 0,
    SYNCMGR_CR_CANCEL_ITEM = 1,
    SYNCMGR_CR_CANCEL_ALL = 2,
    SYNCMGR_CR_MAX = 2,
}

enum SYNCMGR_EVENT_LEVEL
{
    SYNCMGR_EL_INFORMATION = 1,
    SYNCMGR_EL_WARNING = 2,
    SYNCMGR_EL_ERROR = 3,
    SYNCMGR_EL_MAX = 3,
}

enum SYNCMGR_EVENT_FLAGS
{
    SYNCMGR_EF_NONE = 0,
    SYNCMGR_EF_VALID = 0,
}

const GUID IID_ISyncMgrSessionCreator = {0x17F48517, 0xF305, 0x4321, [0xA0, 0x8D, 0xB2, 0x5A, 0x83, 0x49, 0x18, 0xFD]};
@GUID(0x17F48517, 0xF305, 0x4321, [0xA0, 0x8D, 0xB2, 0x5A, 0x83, 0x49, 0x18, 0xFD]);
interface ISyncMgrSessionCreator : IUnknown
{
    HRESULT CreateSession(const(wchar)* pszHandlerID, char* ppszItemIDs, uint cItems, ISyncMgrSyncCallback* ppCallback);
}

const GUID IID_ISyncMgrSyncCallback = {0x884CCD87, 0xB139, 0x4937, [0xA4, 0xBA, 0x4F, 0x8E, 0x19, 0x51, 0x3F, 0xBE]};
@GUID(0x884CCD87, 0xB139, 0x4937, [0xA4, 0xBA, 0x4F, 0x8E, 0x19, 0x51, 0x3F, 0xBE]);
interface ISyncMgrSyncCallback : IUnknown
{
    HRESULT ReportProgress(const(wchar)* pszItemID, const(wchar)* pszProgressText, SYNCMGR_PROGRESS_STATUS nStatus, uint uCurrentStep, uint uMaxStep, SYNCMGR_CANCEL_REQUEST* pnCancelRequest);
    HRESULT SetHandlerProgressText(const(wchar)* pszProgressText, SYNCMGR_CANCEL_REQUEST* pnCancelRequest);
    HRESULT ReportEventA(const(wchar)* pszItemID, SYNCMGR_EVENT_LEVEL nLevel, SYNCMGR_EVENT_FLAGS nFlags, const(wchar)* pszName, const(wchar)* pszDescription, const(wchar)* pszLinkText, const(wchar)* pszLinkReference, const(wchar)* pszContext, Guid* pguidEventID);
    HRESULT CanContinue(const(wchar)* pszItemID);
    HRESULT QueryForAdditionalItems(IEnumString* ppenumItemIDs, IEnumUnknown* ppenumPunks);
    HRESULT AddItemToSession(const(wchar)* pszItemID);
    HRESULT AddIUnknownToSession(IUnknown punk);
    HRESULT ProposeItem(ISyncMgrSyncItem pNewItem);
    HRESULT CommitItem(const(wchar)* pszItemID);
    HRESULT ReportManualSync();
}

const GUID IID_ISyncMgrUIOperation = {0xFC7CFA47, 0xDFE1, 0x45B5, [0xA0, 0x49, 0x8C, 0xFD, 0x82, 0xBE, 0xC2, 0x71]};
@GUID(0xFC7CFA47, 0xDFE1, 0x45B5, [0xA0, 0x49, 0x8C, 0xFD, 0x82, 0xBE, 0xC2, 0x71]);
interface ISyncMgrUIOperation : IUnknown
{
    HRESULT Run(HWND hwndOwner);
}

const GUID IID_ISyncMgrEventLinkUIOperation = {0x64522E52, 0x848B, 0x4015, [0x89, 0xCE, 0x5A, 0x36, 0xF0, 0x0B, 0x94, 0xFF]};
@GUID(0x64522E52, 0x848B, 0x4015, [0x89, 0xCE, 0x5A, 0x36, 0xF0, 0x0B, 0x94, 0xFF]);
interface ISyncMgrEventLinkUIOperation : ISyncMgrUIOperation
{
    HRESULT Init(const(Guid)* rguidEventID, ISyncMgrEvent pEvent);
}

const GUID IID_ISyncMgrScheduleWizardUIOperation = {0x459A6C84, 0x21D2, 0x4DDC, [0x8A, 0x53, 0xF0, 0x23, 0xA4, 0x60, 0x66, 0xF2]};
@GUID(0x459A6C84, 0x21D2, 0x4DDC, [0x8A, 0x53, 0xF0, 0x23, 0xA4, 0x60, 0x66, 0xF2]);
interface ISyncMgrScheduleWizardUIOperation : ISyncMgrUIOperation
{
    HRESULT InitWizard(const(wchar)* pszHandlerID);
}

const GUID IID_ISyncMgrSyncResult = {0x2B90F17E, 0x5A3E, 0x4B33, [0xBB, 0x7F, 0x1B, 0xC4, 0x80, 0x56, 0xB9, 0x4D]};
@GUID(0x2B90F17E, 0x5A3E, 0x4B33, [0xBB, 0x7F, 0x1B, 0xC4, 0x80, 0x56, 0xB9, 0x4D]);
interface ISyncMgrSyncResult : IUnknown
{
    HRESULT Result(SYNCMGR_PROGRESS_STATUS nStatus, uint cError, uint cConflicts);
}

enum SYNCMGR_CONTROL_FLAGS
{
    SYNCMGR_CF_NONE = 0,
    SYNCMGR_CF_NOWAIT = 0,
    SYNCMGR_CF_WAIT = 1,
    SYNCMGR_CF_NOUI = 2,
    SYNCMGR_CF_VALID = 3,
}

enum SYNCMGR_SYNC_CONTROL_FLAGS
{
    SYNCMGR_SCF_NONE = 0,
    SYNCMGR_SCF_IGNORE_IF_ALREADY_SYNCING = 1,
    SYNCMGR_SCF_VALID = 1,
}

enum SYNCMGR_UPDATE_REASON
{
    SYNCMGR_UR_ADDED = 0,
    SYNCMGR_UR_CHANGED = 1,
    SYNCMGR_UR_REMOVED = 2,
    SYNCMGR_UR_MAX = 2,
}

const GUID IID_ISyncMgrControl = {0x9B63616C, 0x36B2, 0x46BC, [0x95, 0x9F, 0xC1, 0x59, 0x39, 0x52, 0xD1, 0x9B]};
@GUID(0x9B63616C, 0x36B2, 0x46BC, [0x95, 0x9F, 0xC1, 0x59, 0x39, 0x52, 0xD1, 0x9B]);
interface ISyncMgrControl : IUnknown
{
    HRESULT StartHandlerSync(const(wchar)* pszHandlerID, HWND hwndOwner, IUnknown punk, SYNCMGR_SYNC_CONTROL_FLAGS nSyncControlFlags, ISyncMgrSyncResult pResult);
    HRESULT StartItemSync(const(wchar)* pszHandlerID, char* ppszItemIDs, uint cItems, HWND hwndOwner, IUnknown punk, SYNCMGR_SYNC_CONTROL_FLAGS nSyncControlFlags, ISyncMgrSyncResult pResult);
    HRESULT StartSyncAll(HWND hwndOwner);
    HRESULT StopHandlerSync(const(wchar)* pszHandlerID);
    HRESULT StopItemSync(const(wchar)* pszHandlerID, char* ppszItemIDs, uint cItems);
    HRESULT StopSyncAll();
    HRESULT UpdateHandlerCollection(const(Guid)* rclsidCollectionID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT UpdateHandler(const(wchar)* pszHandlerID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT UpdateItem(const(wchar)* pszHandlerID, const(wchar)* pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT UpdateEvents(const(wchar)* pszHandlerID, const(wchar)* pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT UpdateConflict(const(wchar)* pszHandlerID, const(wchar)* pszItemID, ISyncMgrConflict pConflict, SYNCMGR_UPDATE_REASON nReason);
    HRESULT UpdateConflicts(const(wchar)* pszHandlerID, const(wchar)* pszItemID, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT ActivateHandler(BOOL fActivate, const(wchar)* pszHandlerID, HWND hwndOwner, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT EnableHandler(BOOL fEnable, const(wchar)* pszHandlerID, HWND hwndOwner, SYNCMGR_CONTROL_FLAGS nControlFlags);
    HRESULT EnableItem(BOOL fEnable, const(wchar)* pszHandlerID, const(wchar)* pszItemID, HWND hwndOwner, SYNCMGR_CONTROL_FLAGS nControlFlags);
}

const GUID IID_ISyncMgrEventStore = {0x37E412F9, 0x016E, 0x44C2, [0x81, 0xFF, 0xDB, 0x3A, 0xDD, 0x77, 0x42, 0x66]};
@GUID(0x37E412F9, 0x016E, 0x44C2, [0x81, 0xFF, 0xDB, 0x3A, 0xDD, 0x77, 0x42, 0x66]);
interface ISyncMgrEventStore : IUnknown
{
    HRESULT GetEventEnumerator(IEnumSyncMgrEvents* ppenum);
    HRESULT GetEventCount(uint* pcEvents);
    HRESULT GetEvent(const(Guid)* rguidEventID, ISyncMgrEvent* ppEvent);
    HRESULT RemoveEvent(char* pguidEventIDs, uint cEvents);
}

const GUID IID_ISyncMgrEvent = {0xFEE0EF8B, 0x46BD, 0x4DB4, [0xB7, 0xE6, 0xFF, 0x2C, 0x68, 0x73, 0x13, 0xBC]};
@GUID(0xFEE0EF8B, 0x46BD, 0x4DB4, [0xB7, 0xE6, 0xFF, 0x2C, 0x68, 0x73, 0x13, 0xBC]);
interface ISyncMgrEvent : IUnknown
{
    HRESULT GetEventID(Guid* pguidEventID);
    HRESULT GetHandlerID(ushort** ppszHandlerID);
    HRESULT GetItemID(ushort** ppszItemID);
    HRESULT GetLevel(SYNCMGR_EVENT_LEVEL* pnLevel);
    HRESULT GetFlags(SYNCMGR_EVENT_FLAGS* pnFlags);
    HRESULT GetTime(FILETIME* pfCreationTime);
    HRESULT GetName(ushort** ppszName);
    HRESULT GetDescription(ushort** ppszDescription);
    HRESULT GetLinkText(ushort** ppszLinkText);
    HRESULT GetLinkReference(ushort** ppszLinkReference);
    HRESULT GetContext(ushort** ppszContext);
}

const GUID IID_IEnumSyncMgrEvents = {0xC81A1D4E, 0x8CF7, 0x4683, [0x80, 0xE0, 0xBC, 0xAE, 0x88, 0xD6, 0x77, 0xB6]};
@GUID(0xC81A1D4E, 0x8CF7, 0x4683, [0x80, 0xE0, 0xBC, 0xAE, 0x88, 0xD6, 0x77, 0xB6]);
interface IEnumSyncMgrEvents : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncMgrEvents* ppenum);
}

struct SYNCMGR_CONFLICT_ID_INFO
{
    BYTE_BLOB* pblobID;
    BYTE_BLOB* pblobExtra;
}

const GUID IID_ISyncMgrConflictStore = {0xCF8FC579, 0xC396, 0x4774, [0x85, 0xF1, 0xD9, 0x08, 0xA8, 0x31, 0x15, 0x6E]};
@GUID(0xCF8FC579, 0xC396, 0x4774, [0x85, 0xF1, 0xD9, 0x08, 0xA8, 0x31, 0x15, 0x6E]);
interface ISyncMgrConflictStore : IUnknown
{
    HRESULT EnumConflicts(const(wchar)* pszHandlerID, const(wchar)* pszItemID, IEnumSyncMgrConflict* ppEnum);
    HRESULT BindToConflict(const(SYNCMGR_CONFLICT_ID_INFO)* pConflictIdInfo, const(Guid)* riid, void** ppv);
    HRESULT RemoveConflicts(char* rgConflictIdInfo, uint cConflicts);
    HRESULT GetCount(const(wchar)* pszHandlerID, const(wchar)* pszItemID, uint* pnConflicts);
}

const GUID IID_IEnumSyncMgrConflict = {0x82705914, 0xDDA3, 0x4893, [0xBA, 0x99, 0x49, 0xDE, 0x6C, 0x8C, 0x80, 0x36]};
@GUID(0x82705914, 0xDDA3, 0x4893, [0xBA, 0x99, 0x49, 0xDE, 0x6C, 0x8C, 0x80, 0x36]);
interface IEnumSyncMgrConflict : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumSyncMgrConflict* ppenum);
}

enum SYNCMGR_CONFLICT_ITEM_TYPE
{
    SYNCMGR_CIT_UPDATED = 1,
    SYNCMGR_CIT_DELETED = 2,
}

const GUID IID_ISyncMgrConflict = {0x9C204249, 0xC443, 0x4BA4, [0x85, 0xED, 0xC9, 0x72, 0x68, 0x1D, 0xB1, 0x37]};
@GUID(0x9C204249, 0xC443, 0x4BA4, [0x85, 0xED, 0xC9, 0x72, 0x68, 0x1D, 0xB1, 0x37]);
interface ISyncMgrConflict : IUnknown
{
    HRESULT GetProperty(const(PROPERTYKEY)* propkey, PROPVARIANT* ppropvar);
    HRESULT GetConflictIdInfo(SYNCMGR_CONFLICT_ID_INFO* pConflictIdInfo);
    HRESULT GetItemsArray(ISyncMgrConflictItems* ppArray);
    HRESULT Resolve(ISyncMgrConflictResolveInfo pResolveInfo);
    HRESULT GetResolutionHandler(const(Guid)* riid, void** ppvResolutionHandler);
}

enum SYNCMGR_RESOLUTION_ABILITIES
{
    SYNCMGR_RA_KEEPOTHER = 1,
    SYNCMGR_RA_KEEPRECENT = 2,
    SYNCMGR_RA_REMOVEFROMSYNCSET = 4,
    SYNCMGR_RA_KEEP_SINGLE = 8,
    SYNCMGR_RA_KEEP_MULTIPLE = 16,
    SYNCMGR_RA_VALID = 31,
}

enum SYNCMGR_RESOLUTION_FEEDBACK
{
    SYNCMGR_RF_CONTINUE = 0,
    SYNCMGR_RF_REFRESH = 1,
    SYNCMGR_RF_CANCEL = 2,
}

const GUID IID_ISyncMgrResolutionHandler = {0x40A3D052, 0x8BFF, 0x4C4B, [0xA3, 0x38, 0xD4, 0xA3, 0x95, 0x70, 0x0D, 0xE9]};
@GUID(0x40A3D052, 0x8BFF, 0x4C4B, [0xA3, 0x38, 0xD4, 0xA3, 0x95, 0x70, 0x0D, 0xE9]);
interface ISyncMgrResolutionHandler : IUnknown
{
    HRESULT QueryAbilities(uint* pdwAbilities);
    HRESULT KeepOther(IShellItem psiOther, SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    HRESULT KeepRecent(SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    HRESULT RemoveFromSyncSet(SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
    HRESULT KeepItems(ISyncMgrConflictResolutionItems pArray, SYNCMGR_RESOLUTION_FEEDBACK* pFeedback);
}

const GUID IID_ISyncMgrConflictPresenter = {0x0B4F5353, 0xFD2B, 0x42CD, [0x87, 0x63, 0x47, 0x79, 0xF2, 0xD5, 0x08, 0xA3]};
@GUID(0x0B4F5353, 0xFD2B, 0x42CD, [0x87, 0x63, 0x47, 0x79, 0xF2, 0xD5, 0x08, 0xA3]);
interface ISyncMgrConflictPresenter : IUnknown
{
    HRESULT PresentConflict(ISyncMgrConflict pConflict, ISyncMgrConflictResolveInfo pResolveInfo);
}

enum SYNCMGR_PRESENTER_NEXT_STEP
{
    SYNCMGR_PNS_CONTINUE = 0,
    SYNCMGR_PNS_DEFAULT = 1,
    SYNCMGR_PNS_CANCEL = 2,
}

enum SYNCMGR_PRESENTER_CHOICE
{
    SYNCMGR_PC_NO_CHOICE = 0,
    SYNCMGR_PC_KEEP_ONE = 1,
    SYNCMGR_PC_KEEP_MULTIPLE = 2,
    SYNCMGR_PC_KEEP_RECENT = 3,
    SYNCMGR_PC_REMOVE_FROM_SYNC_SET = 4,
    SYNCMGR_PC_SKIP = 5,
}

const GUID IID_ISyncMgrConflictResolveInfo = {0xC405A219, 0x25A2, 0x442E, [0x87, 0x43, 0xB8, 0x45, 0xA2, 0xCE, 0xE9, 0x3F]};
@GUID(0xC405A219, 0x25A2, 0x442E, [0x87, 0x43, 0xB8, 0x45, 0xA2, 0xCE, 0xE9, 0x3F]);
interface ISyncMgrConflictResolveInfo : IUnknown
{
    HRESULT GetIterationInfo(uint* pnCurrentConflict, uint* pcConflicts, uint* pcRemainingForApplyToAll);
    HRESULT GetPresenterNextStep(SYNCMGR_PRESENTER_NEXT_STEP* pnPresenterNextStep);
    HRESULT GetPresenterChoice(SYNCMGR_PRESENTER_CHOICE* pnPresenterChoice, int* pfApplyToAll);
    HRESULT GetItemChoiceCount(uint* pcChoices);
    HRESULT GetItemChoice(uint iChoice, uint* piChoiceIndex);
    HRESULT SetPresenterNextStep(SYNCMGR_PRESENTER_NEXT_STEP nPresenterNextStep);
    HRESULT SetPresenterChoice(SYNCMGR_PRESENTER_CHOICE nPresenterChoice, BOOL fApplyToAll);
    HRESULT SetItemChoices(uint* prgiConflictItemIndexes, uint cChoices);
}

const GUID IID_ISyncMgrConflictFolder = {0x59287F5E, 0xBC81, 0x4FCA, [0xA7, 0xF1, 0xE5, 0xA8, 0xEC, 0xDB, 0x1D, 0x69]};
@GUID(0x59287F5E, 0xBC81, 0x4FCA, [0xA7, 0xF1, 0xE5, 0xA8, 0xEC, 0xDB, 0x1D, 0x69]);
interface ISyncMgrConflictFolder : IUnknown
{
    HRESULT GetConflictIDList(ISyncMgrConflict pConflict, ITEMIDLIST** ppidlConflict);
}

struct CONFIRM_CONFLICT_ITEM
{
    IShellItem2 pShellItem;
    const(wchar)* pszOriginalName;
    const(wchar)* pszAlternateName;
    const(wchar)* pszLocationShort;
    const(wchar)* pszLocationFull;
    SYNCMGR_CONFLICT_ITEM_TYPE nType;
}

struct CONFIRM_CONFLICT_RESULT_INFO
{
    const(wchar)* pszNewName;
    uint iItemIndex;
}

const GUID IID_ISyncMgrConflictItems = {0x9C7EAD52, 0x8023, 0x4936, [0xA4, 0xDB, 0xD2, 0xA9, 0xA9, 0x9E, 0x43, 0x6A]};
@GUID(0x9C7EAD52, 0x8023, 0x4936, [0xA4, 0xDB, 0xD2, 0xA9, 0xA9, 0x9E, 0x43, 0x6A]);
interface ISyncMgrConflictItems : IUnknown
{
    HRESULT GetCount(uint* pCount);
    HRESULT GetItem(uint iIndex, CONFIRM_CONFLICT_ITEM* pItemInfo);
}

const GUID IID_ISyncMgrConflictResolutionItems = {0x458725B9, 0x129D, 0x4135, [0xA9, 0x98, 0x9C, 0xEA, 0xFE, 0xC2, 0x70, 0x07]};
@GUID(0x458725B9, 0x129D, 0x4135, [0xA9, 0x98, 0x9C, 0xEA, 0xFE, 0xC2, 0x70, 0x07]);
interface ISyncMgrConflictResolutionItems : IUnknown
{
    HRESULT GetCount(uint* pCount);
    HRESULT GetItem(uint iIndex, CONFIRM_CONFLICT_RESULT_INFO* pItemInfo);
}

const GUID CLSID_InputPanelConfiguration = {0x2853ADD3, 0xF096, 0x4C63, [0xA7, 0x8F, 0x7F, 0xA3, 0xEA, 0x83, 0x7F, 0xB7]};
@GUID(0x2853ADD3, 0xF096, 0x4C63, [0xA7, 0x8F, 0x7F, 0xA3, 0xEA, 0x83, 0x7F, 0xB7]);
struct InputPanelConfiguration;

const GUID IID_IInputPanelConfiguration = {0x41C81592, 0x514C, 0x48BD, [0xA2, 0x2E, 0xE6, 0xAF, 0x63, 0x85, 0x21, 0xA6]};
@GUID(0x41C81592, 0x514C, 0x48BD, [0xA2, 0x2E, 0xE6, 0xAF, 0x63, 0x85, 0x21, 0xA6]);
interface IInputPanelConfiguration : IUnknown
{
    HRESULT EnableFocusTracking();
}

const GUID IID_IInputPanelInvocationConfiguration = {0xA213F136, 0x3B45, 0x4362, [0xA3, 0x32, 0xEF, 0xB6, 0x54, 0x7C, 0xD4, 0x32]};
@GUID(0xA213F136, 0x3B45, 0x4362, [0xA3, 0x32, 0xEF, 0xB6, 0x54, 0x7C, 0xD4, 0x32]);
interface IInputPanelInvocationConfiguration : IUnknown
{
    HRESULT RequireTouchInEditControl();
}

const GUID CLSID_LocalThumbnailCache = {0x50EF4544, 0xAC9F, 0x4A8E, [0xB2, 0x1B, 0x8A, 0x26, 0x18, 0x0D, 0xB1, 0x3F]};
@GUID(0x50EF4544, 0xAC9F, 0x4A8E, [0xB2, 0x1B, 0x8A, 0x26, 0x18, 0x0D, 0xB1, 0x3F]);
struct LocalThumbnailCache;

const GUID CLSID_SharedBitmap = {0x4DB26476, 0x6787, 0x4046, [0xB8, 0x36, 0xE8, 0x41, 0x2A, 0x9E, 0x8A, 0x27]};
@GUID(0x4DB26476, 0x6787, 0x4046, [0xB8, 0x36, 0xE8, 0x41, 0x2A, 0x9E, 0x8A, 0x27]);
struct SharedBitmap;

enum WTS_FLAGS
{
    WTS_NONE = 0,
    WTS_EXTRACT = 0,
    WTS_INCACHEONLY = 1,
    WTS_FASTEXTRACT = 2,
    WTS_FORCEEXTRACTION = 4,
    WTS_SLOWRECLAIM = 8,
    WTS_EXTRACTDONOTCACHE = 32,
    WTS_SCALETOREQUESTEDSIZE = 64,
    WTS_SKIPFASTEXTRACT = 128,
    WTS_EXTRACTINPROC = 256,
    WTS_CROPTOSQUARE = 512,
    WTS_INSTANCESURROGATE = 1024,
    WTS_REQUIRESURROGATE = 2048,
    WTS_APPSTYLE = 8192,
    WTS_WIDETHUMBNAILS = 16384,
    WTS_IDEALCACHESIZEONLY = 32768,
    WTS_SCALEUP = 65536,
}

enum WTS_CACHEFLAGS
{
    WTS_DEFAULT = 0,
    WTS_LOWQUALITY = 1,
    WTS_CACHED = 2,
}

enum WTS_CONTEXTFLAGS
{
    WTSCF_DEFAULT = 0,
    WTSCF_APPSTYLE = 1,
    WTSCF_SQUARE = 2,
    WTSCF_WIDE = 4,
    WTSCF_FAST = 8,
}

enum WTS_ALPHATYPE
{
    WTSAT_UNKNOWN = 0,
    WTSAT_RGB = 1,
    WTSAT_ARGB = 2,
}

struct WTS_THUMBNAILID
{
    ubyte rgbKey;
}

const GUID IID_ISharedBitmap = {0x091162A4, 0xBC96, 0x411F, [0xAA, 0xE8, 0xC5, 0x12, 0x2C, 0xD0, 0x33, 0x63]};
@GUID(0x091162A4, 0xBC96, 0x411F, [0xAA, 0xE8, 0xC5, 0x12, 0x2C, 0xD0, 0x33, 0x63]);
interface ISharedBitmap : IUnknown
{
    HRESULT GetSharedBitmap(HBITMAP* phbm);
    HRESULT GetSize(SIZE* pSize);
    HRESULT GetFormat(WTS_ALPHATYPE* pat);
    HRESULT InitializeBitmap(HBITMAP hbm, WTS_ALPHATYPE wtsAT);
    HRESULT Detach(HBITMAP* phbm);
}

const GUID IID_IThumbnailCache = {0xF676C15D, 0x596A, 0x4CE2, [0x82, 0x34, 0x33, 0x99, 0x6F, 0x44, 0x5D, 0xB1]};
@GUID(0xF676C15D, 0x596A, 0x4CE2, [0x82, 0x34, 0x33, 0x99, 0x6F, 0x44, 0x5D, 0xB1]);
interface IThumbnailCache : IUnknown
{
    HRESULT GetThumbnail(IShellItem pShellItem, uint cxyRequestedThumbSize, WTS_FLAGS flags, ISharedBitmap* ppvThumb, WTS_CACHEFLAGS* pOutFlags, WTS_THUMBNAILID* pThumbnailID);
    HRESULT GetThumbnailByID(WTS_THUMBNAILID thumbnailID, uint cxyRequestedThumbSize, ISharedBitmap* ppvThumb, WTS_CACHEFLAGS* pOutFlags);
}

const GUID IID_IThumbnailProvider = {0xE357FCCD, 0xA995, 0x4576, [0xB0, 0x1F, 0x23, 0x46, 0x30, 0x15, 0x4E, 0x96]};
@GUID(0xE357FCCD, 0xA995, 0x4576, [0xB0, 0x1F, 0x23, 0x46, 0x30, 0x15, 0x4E, 0x96]);
interface IThumbnailProvider : IUnknown
{
    HRESULT GetThumbnail(uint cx, HBITMAP* phbmp, WTS_ALPHATYPE* pdwAlpha);
}

const GUID IID_IThumbnailSettings = {0xF4376F00, 0xBEF5, 0x4D45, [0x80, 0xF3, 0x1E, 0x02, 0x3B, 0xBF, 0x12, 0x09]};
@GUID(0xF4376F00, 0xBEF5, 0x4D45, [0x80, 0xF3, 0x1E, 0x02, 0x3B, 0xBF, 0x12, 0x09]);
interface IThumbnailSettings : IUnknown
{
    HRESULT SetContext(WTS_CONTEXTFLAGS dwContext);
}

const GUID IID_IThumbnailCachePrimer = {0x0F03F8FE, 0x2B26, 0x46F0, [0x96, 0x5A, 0x21, 0x2A, 0xA8, 0xD6, 0x6B, 0x76]};
@GUID(0x0F03F8FE, 0x2B26, 0x46F0, [0x96, 0x5A, 0x21, 0x2A, 0xA8, 0xD6, 0x6B, 0x76]);
interface IThumbnailCachePrimer : IUnknown
{
    HRESULT PageInThumbnail(IShellItem psi, WTS_FLAGS wtsFlags, uint cxyRequestedThumbSize);
}

const GUID CLSID_ShellImageDataFactory = {0x66E4E4FB, 0xF385, 0x4DD0, [0x8D, 0x74, 0xA2, 0xEF, 0xD1, 0xBC, 0x61, 0x78]};
@GUID(0x66E4E4FB, 0xF385, 0x4DD0, [0x8D, 0x74, 0xA2, 0xEF, 0xD1, 0xBC, 0x61, 0x78]);
struct ShellImageDataFactory;

const GUID IID_IShellImageDataFactory = {0x9BE8ED5C, 0xEDAB, 0x4D75, [0x90, 0xF3, 0xBD, 0x5B, 0xDB, 0xB2, 0x1C, 0x82]};
@GUID(0x9BE8ED5C, 0xEDAB, 0x4D75, [0x90, 0xF3, 0xBD, 0x5B, 0xDB, 0xB2, 0x1C, 0x82]);
interface IShellImageDataFactory : IUnknown
{
    HRESULT CreateIShellImageData(IShellImageData* ppshimg);
    HRESULT CreateImageFromFile(const(wchar)* pszPath, IShellImageData* ppshimg);
    HRESULT CreateImageFromStream(IStream pStream, IShellImageData* ppshimg);
    HRESULT GetDataFormatFromPath(const(wchar)* pszPath, Guid* pDataFormat);
}

const GUID IID_IShellImageData = {0xBFDEEC12, 0x8040, 0x4403, [0xA5, 0xEA, 0x9E, 0x07, 0xDA, 0xFC, 0xF5, 0x30]};
@GUID(0xBFDEEC12, 0x8040, 0x4403, [0xA5, 0xEA, 0x9E, 0x07, 0xDA, 0xFC, 0xF5, 0x30]);
interface IShellImageData : IUnknown
{
    HRESULT Decode(uint dwFlags, uint cxDesired, uint cyDesired);
    HRESULT Draw(HDC hdc, RECT* prcDest, RECT* prcSrc);
    HRESULT NextFrame();
    HRESULT NextPage();
    HRESULT PrevPage();
    HRESULT IsTransparent();
    HRESULT IsAnimated();
    HRESULT IsVector();
    HRESULT IsMultipage();
    HRESULT IsEditable();
    HRESULT IsPrintable();
    HRESULT IsDecoded();
    HRESULT GetCurrentPage(uint* pnPage);
    HRESULT GetPageCount(uint* pcPages);
    HRESULT SelectPage(uint iPage);
    HRESULT GetSize(SIZE* pSize);
    HRESULT GetRawDataFormat(Guid* pDataFormat);
    HRESULT GetPixelFormat(uint* pFormat);
    HRESULT GetDelay(uint* pdwDelay);
    HRESULT GetProperties(uint dwMode, IPropertySetStorage* ppPropSet);
    HRESULT Rotate(uint dwAngle);
    HRESULT Scale(uint cx, uint cy, uint hints);
    HRESULT DiscardEdit();
    HRESULT SetEncoderParams(IPropertyBag pbagEnc);
    HRESULT DisplayName(const(wchar)* wszName, uint cch);
    HRESULT GetResolution(uint* puResolutionX, uint* puResolutionY);
    HRESULT GetEncoderParams(Guid* pguidFmt, ubyte** ppEncParams);
    HRESULT RegisterAbort(IShellImageDataAbort pAbort, IShellImageDataAbort* ppAbortPrev);
    HRESULT CloneFrame(ubyte** ppImg);
    HRESULT ReplaceFrame(ubyte* pImg);
}

const GUID IID_IShellImageDataAbort = {0x53FB8E58, 0x50C0, 0x4003, [0xB4, 0xAA, 0x0C, 0x8D, 0xF2, 0x8E, 0x7F, 0x3A]};
@GUID(0x53FB8E58, 0x50C0, 0x4003, [0xB4, 0xAA, 0x0C, 0x8D, 0xF2, 0x8E, 0x7F, 0x3A]);
interface IShellImageDataAbort : IUnknown
{
    HRESULT QueryAbort();
}

const GUID IID_IStorageProviderPropertyHandler = {0x301DFBE5, 0x524C, 0x4B0F, [0x8B, 0x2D, 0x21, 0xC4, 0x0B, 0x3A, 0x29, 0x88]};
@GUID(0x301DFBE5, 0x524C, 0x4B0F, [0x8B, 0x2D, 0x21, 0xC4, 0x0B, 0x3A, 0x29, 0x88]);
interface IStorageProviderPropertyHandler : IUnknown
{
    HRESULT RetrieveProperties(char* propertiesToRetrieve, uint propertiesToRetrieveCount, IPropertyStore* retrievedProperties);
    HRESULT SaveProperties(IPropertyStore propertiesToSave);
}

const GUID IID_IStorageProviderHandler = {0x162C6FB5, 0x44D3, 0x435B, [0x90, 0x3D, 0xE6, 0x13, 0xFA, 0x09, 0x3F, 0xB5]};
@GUID(0x162C6FB5, 0x44D3, 0x435B, [0x90, 0x3D, 0xE6, 0x13, 0xFA, 0x09, 0x3F, 0xB5]);
interface IStorageProviderHandler : IUnknown
{
    HRESULT GetPropertyHandlerFromPath(const(wchar)* path, IStorageProviderPropertyHandler* propertyHandler);
    HRESULT GetPropertyHandlerFromUri(const(wchar)* uri, IStorageProviderPropertyHandler* propertyHandler);
    HRESULT GetPropertyHandlerFromFileId(const(wchar)* fileId, IStorageProviderPropertyHandler* propertyHandler);
}

const GUID CLSID_SyncMgr = {0x6295DF27, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF27, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
struct SyncMgr;

enum SYNCMGRSTATUS
{
    SYNCMGRSTATUS_STOPPED = 0,
    SYNCMGRSTATUS_SKIPPED = 1,
    SYNCMGRSTATUS_PENDING = 2,
    SYNCMGRSTATUS_UPDATING = 3,
    SYNCMGRSTATUS_SUCCEEDED = 4,
    SYNCMGRSTATUS_FAILED = 5,
    SYNCMGRSTATUS_PAUSED = 6,
    SYNCMGRSTATUS_RESUMING = 7,
    SYNCMGRSTATUS_UPDATING_INDETERMINATE = 8,
    SYNCMGRSTATUS_DELETED = 256,
}

struct SYNCMGRPROGRESSITEM
{
    uint cbSize;
    uint mask;
    const(wchar)* lpcStatusText;
    uint dwStatusType;
    int iProgValue;
    int iMaxValue;
}

enum SYNCMGRLOGLEVEL
{
    SYNCMGRLOGLEVEL_INFORMATION = 1,
    SYNCMGRLOGLEVEL_WARNING = 2,
    SYNCMGRLOGLEVEL_ERROR = 3,
    SYNCMGRLOGLEVEL_LOGLEVELMAX = 3,
}

enum SYNCMGRERRORFLAGS
{
    SYNCMGRERRORFLAG_ENABLEJUMPTEXT = 1,
}

struct SYNCMGRLOGERRORINFO
{
    uint cbSize;
    uint mask;
    uint dwSyncMgrErrorFlags;
    Guid ErrorID;
    Guid ItemID;
}

const GUID IID_ISyncMgrSynchronizeCallback = {0x6295DF41, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF41, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
interface ISyncMgrSynchronizeCallback : IUnknown
{
    HRESULT ShowPropertiesCompleted(HRESULT hr);
    HRESULT PrepareForSyncCompleted(HRESULT hr);
    HRESULT SynchronizeCompleted(HRESULT hr);
    HRESULT ShowErrorCompleted(HRESULT hr, uint cItems, char* pItemIDs);
    HRESULT EnableModeless(BOOL fEnable);
    HRESULT Progress(const(Guid)* ItemID, const(SYNCMGRPROGRESSITEM)* pSyncProgressItem);
    HRESULT LogError(uint dwErrorLevel, const(wchar)* pszErrorText, const(SYNCMGRLOGERRORINFO)* pSyncLogError);
    HRESULT DeleteLogError(const(Guid)* ErrorID, uint dwReserved);
    HRESULT EstablishConnection(const(wchar)* pwszConnection, uint dwReserved);
}

enum SYNCMGRITEMFLAGS
{
    SYNCMGRITEM_HASPROPERTIES = 1,
    SYNCMGRITEM_TEMPORARY = 2,
    SYNCMGRITEM_ROAMINGUSER = 4,
    SYNCMGRITEM_LASTUPDATETIME = 8,
    SYNCMGRITEM_MAYDELETEITEM = 16,
    SYNCMGRITEM_HIDDEN = 32,
}

struct SYNCMGRITEM
{
    uint cbSize;
    uint dwFlags;
    Guid ItemID;
    uint dwItemState;
    HICON hIcon;
    ushort wszItemName;
    FILETIME ftLastUpdate;
}

const GUID IID_ISyncMgrEnumItems = {0x6295DF2A, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF2A, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
interface ISyncMgrEnumItems : IUnknown
{
    HRESULT Next(uint celt, char* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(ISyncMgrEnumItems* ppenum);
}

enum SYNCMGRFLAG
{
    SYNCMGRFLAG_CONNECT = 1,
    SYNCMGRFLAG_PENDINGDISCONNECT = 2,
    SYNCMGRFLAG_MANUAL = 3,
    SYNCMGRFLAG_IDLE = 4,
    SYNCMGRFLAG_INVOKE = 5,
    SYNCMGRFLAG_SCHEDULED = 6,
    SYNCMGRFLAG_EVENTMASK = 255,
    SYNCMGRFLAG_SETTINGS = 256,
    SYNCMGRFLAG_MAYBOTHERUSER = 512,
}

enum SYNCMGRHANDLERFLAGS
{
    SYNCMGRHANDLER_HASPROPERTIES = 1,
    SYNCMGRHANDLER_MAYESTABLISHCONNECTION = 2,
    SYNCMGRHANDLER_ALWAYSLISTHANDLER = 4,
    SYNCMGRHANDLER_HIDDEN = 8,
}

struct SYNCMGRHANDLERINFO
{
    uint cbSize;
    HICON hIcon;
    uint SyncMgrHandlerFlags;
    ushort wszHandlerName;
}

enum SYNCMGRITEMSTATE
{
    SYNCMGRITEMSTATE_UNCHECKED = 0,
    SYNCMGRITEMSTATE_CHECKED = 1,
}

const GUID IID_ISyncMgrSynchronize = {0x6295DF40, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF40, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
interface ISyncMgrSynchronize : IUnknown
{
    HRESULT Initialize(uint dwReserved, uint dwSyncMgrFlags, uint cbCookie, char* lpCookie);
    HRESULT GetHandlerInfo(SYNCMGRHANDLERINFO** ppSyncMgrHandlerInfo);
    HRESULT EnumSyncMgrItems(ISyncMgrEnumItems* ppSyncMgrEnumItems);
    HRESULT GetItemObject(const(Guid)* ItemID, const(Guid)* riid, void** ppv);
    HRESULT ShowProperties(HWND hWndParent, const(Guid)* ItemID);
    HRESULT SetProgressCallback(ISyncMgrSynchronizeCallback lpCallBack);
    HRESULT PrepareForSync(uint cbNumItems, char* pItemIDs, HWND hWndParent, uint dwReserved);
    HRESULT Synchronize(HWND hWndParent);
    HRESULT SetItemStatus(const(Guid)* pItemID, uint dwSyncMgrStatus);
    HRESULT ShowError(HWND hWndParent, const(Guid)* ErrorID);
}

enum SYNCMGRINVOKEFLAGS
{
    SYNCMGRINVOKE_STARTSYNC = 2,
    SYNCMGRINVOKE_MINIMIZED = 4,
}

const GUID IID_ISyncMgrSynchronizeInvoke = {0x6295DF2C, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF2C, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
interface ISyncMgrSynchronizeInvoke : IUnknown
{
    HRESULT UpdateItems(uint dwInvokeFlags, const(Guid)* clsid, uint cbCookie, char* pCookie);
    HRESULT UpdateAll();
}

enum SYNCMGRREGISTERFLAGS
{
    SYNCMGRREGISTERFLAG_CONNECT = 1,
    SYNCMGRREGISTERFLAG_PENDINGDISCONNECT = 2,
    SYNCMGRREGISTERFLAG_IDLE = 4,
}

const GUID IID_ISyncMgrRegister = {0x6295DF42, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]};
@GUID(0x6295DF42, 0x35EE, 0x11D1, [0x87, 0x07, 0x00, 0xC0, 0x4F, 0xD9, 0x33, 0x27]);
interface ISyncMgrRegister : IUnknown
{
    HRESULT RegisterSyncMgrHandler(const(Guid)* clsidHandler, const(wchar)* pwszDescription, uint dwSyncMgrRegisterFlags);
    HRESULT UnregisterSyncMgrHandler(const(Guid)* clsidHandler, uint dwReserved);
    HRESULT GetHandlerRegistrationInfo(const(Guid)* clsidHandler, uint* pdwSyncMgrRegisterFlags);
}

const GUID CLSID_ThumbnailStreamCache = {0xCBE0FED3, 0x4B91, 0x4E90, [0x83, 0x54, 0x8A, 0x8C, 0x84, 0xEC, 0x68, 0x72]};
@GUID(0xCBE0FED3, 0x4B91, 0x4E90, [0x83, 0x54, 0x8A, 0x8C, 0x84, 0xEC, 0x68, 0x72]);
struct ThumbnailStreamCache;

enum ThumbnailStreamCacheOptions
{
    ExtractIfNotCached = 0,
    ReturnOnlyIfCached = 1,
    ResizeThumbnail = 2,
    AllowSmallerSize = 4,
}

const GUID IID_IThumbnailStreamCache = {0x90E11430, 0x9569, 0x41D8, [0xAE, 0x75, 0x6D, 0x4D, 0x2A, 0xE7, 0xCC, 0xA0]};
@GUID(0x90E11430, 0x9569, 0x41D8, [0xAE, 0x75, 0x6D, 0x4D, 0x2A, 0xE7, 0xCC, 0xA0]);
interface IThumbnailStreamCache : IUnknown
{
    HRESULT GetThumbnailStream(const(wchar)* path, ulong cacheId, ThumbnailStreamCacheOptions options, uint requestedThumbnailSize, SIZE* thumbnailSize, IStream* thumbnailStream);
    HRESULT SetThumbnailStream(const(wchar)* path, ulong cacheId, SIZE thumbnailSize, IStream thumbnailStream);
}

const GUID CLSID_TrackShellMenu = {0x8278F931, 0x2A3E, 0x11D2, [0x83, 0x8F, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0x8278F931, 0x2A3E, 0x11D2, [0x83, 0x8F, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
struct TrackShellMenu;

struct WINDOWDATA
{
    uint dwWindowID;
    uint uiCP;
    ITEMIDLIST* pidl;
    const(wchar)* lpszUrl;
    const(wchar)* lpszUrlLocation;
    const(wchar)* lpszTitle;
}

const GUID IID_ITravelLogEntry = {0x7EBFDD87, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]};
@GUID(0x7EBFDD87, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]);
interface ITravelLogEntry : IUnknown
{
    HRESULT GetTitle(ushort** ppszTitle);
    HRESULT GetURL(ushort** ppszURL);
}

const GUID IID_ITravelLogClient = {0x241C033E, 0xE659, 0x43DA, [0xAA, 0x4D, 0x40, 0x86, 0xDB, 0xC4, 0x75, 0x8D]};
@GUID(0x241C033E, 0xE659, 0x43DA, [0xAA, 0x4D, 0x40, 0x86, 0xDB, 0xC4, 0x75, 0x8D]);
interface ITravelLogClient : IUnknown
{
    HRESULT FindWindowByIndex(uint dwID, IUnknown* ppunk);
    HRESULT GetWindowData(IStream pStream, WINDOWDATA* pWinData);
    HRESULT LoadHistoryPosition(const(wchar)* pszUrlLocation, uint dwPosition);
}

const GUID IID_IEnumTravelLogEntry = {0x7EBFDD85, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]};
@GUID(0x7EBFDD85, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]);
interface IEnumTravelLogEntry : IUnknown
{
    HRESULT Next(uint cElt, char* rgElt, uint* pcEltFetched);
    HRESULT Skip(uint cElt);
    HRESULT Reset();
    HRESULT Clone(IEnumTravelLogEntry* ppEnum);
}

enum tagTLENUMF
{
    TLEF_RELATIVE_INCLUDE_CURRENT = 1,
    TLEF_RELATIVE_BACK = 16,
    TLEF_RELATIVE_FORE = 32,
    TLEF_INCLUDE_UNINVOKEABLE = 64,
    TLEF_ABSOLUTE = 49,
    TLEF_EXCLUDE_SUBFRAME_ENTRIES = 128,
    TLEF_EXCLUDE_ABOUT_PAGES = 256,
}

const GUID IID_ITravelLogStg = {0x7EBFDD80, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]};
@GUID(0x7EBFDD80, 0xAD18, 0x11D3, [0xA4, 0xC5, 0x00, 0xC0, 0x4F, 0x72, 0xD6, 0xB8]);
interface ITravelLogStg : IUnknown
{
    HRESULT CreateEntry(const(wchar)* pszUrl, const(wchar)* pszTitle, ITravelLogEntry ptleRelativeTo, BOOL fPrepend, ITravelLogEntry* pptle);
    HRESULT TravelTo(ITravelLogEntry ptle);
    HRESULT EnumEntries(uint flags, IEnumTravelLogEntry* ppenum);
    HRESULT FindEntries(uint flags, const(wchar)* pszUrl, IEnumTravelLogEntry* ppenum);
    HRESULT GetCount(uint flags, uint* pcEntries);
    HRESULT RemoveEntry(ITravelLogEntry ptle);
    HRESULT GetRelativeEntry(int iOffset, ITravelLogEntry* ptle);
}

enum _HLSR_NOREDEF10
{
    HLSR_HOME = 0,
    HLSR_SEARCHPAGE = 1,
    HLSR_HISTORYFOLDER = 2,
}

enum _HLSHORTCUTF__NOREDEF10
{
    HLSHORTCUTF_DEFAULT = 0,
    HLSHORTCUTF_DONTACTUALLYCREATE = 1,
    HLSHORTCUTF_USEFILENAMEFROMFRIENDLYNAME = 2,
    HLSHORTCUTF_USEUNIQUEFILENAME = 4,
    HLSHORTCUTF_MAYUSEEXISTINGSHORTCUT = 8,
}

enum _HLTRANSLATEF_NOREDEF10
{
    HLTRANSLATEF_DEFAULT = 0,
    HLTRANSLATEF_DONTAPPLYDEFAULTPREFIX = 1,
}

enum __MIDL_IHlink_0001
{
    HLNF_INTERNALJUMP = 1,
    HLNF_OPENINNEWWINDOW = 2,
    HLNF_NAVIGATINGBACK = 4,
    HLNF_NAVIGATINGFORWARD = 8,
    HLNF_NAVIGATINGTOSTACKITEM = 16,
    HLNF_CREATENOHISTORY = 32,
}

enum __MIDL_IHlink_0002
{
    HLINKGETREF_DEFAULT = 0,
    HLINKGETREF_ABSOLUTE = 1,
    HLINKGETREF_RELATIVE = 2,
}

enum __MIDL_IHlink_0003
{
    HLFNAMEF_DEFAULT = 0,
    HLFNAMEF_TRYCACHE = 1,
    HLFNAMEF_TRYPRETTYTARGET = 2,
    HLFNAMEF_TRYFULLTARGET = 4,
    HLFNAMEF_TRYWIN95SHORTCUT = 8,
}

enum __MIDL_IHlink_0004
{
    HLINKMISC_RELATIVE = 1,
}

enum __MIDL_IHlink_0005
{
    HLINKSETF_TARGET = 1,
    HLINKSETF_LOCATION = 2,
}

const GUID IID_IHlink = {0x79EAC9C3, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C3, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHlink : IUnknown
{
    HRESULT SetHlinkSite(IHlinkSite pihlSite, uint dwSiteData);
    HRESULT GetHlinkSite(IHlinkSite* ppihlSite, uint* pdwSiteData);
    HRESULT SetMonikerReference(uint grfHLSETF, IMoniker pimkTarget, const(wchar)* pwzLocation);
    HRESULT GetMonikerReference(uint dwWhichRef, IMoniker* ppimkTarget, ushort** ppwzLocation);
    HRESULT SetStringReference(uint grfHLSETF, const(wchar)* pwzTarget, const(wchar)* pwzLocation);
    HRESULT GetStringReference(uint dwWhichRef, ushort** ppwzTarget, ushort** ppwzLocation);
    HRESULT SetFriendlyName(const(wchar)* pwzFriendlyName);
    HRESULT GetFriendlyName(uint grfHLFNAMEF, ushort** ppwzFriendlyName);
    HRESULT SetTargetFrameName(const(wchar)* pwzTargetFrameName);
    HRESULT GetTargetFrameName(ushort** ppwzTargetFrameName);
    HRESULT GetMiscStatus(uint* pdwStatus);
    HRESULT Navigate(uint grfHLNF, IBindCtx pibc, IBindStatusCallback pibsc, IHlinkBrowseContext pihlbc);
    HRESULT SetAdditionalParams(const(wchar)* pwzAdditionalParams);
    HRESULT GetAdditionalParams(ushort** ppwzAdditionalParams);
}

enum __MIDL_IHlinkSite_0001
{
    HLINKWHICHMK_CONTAINER = 1,
    HLINKWHICHMK_BASE = 2,
}

const GUID IID_IHlinkSite = {0x79EAC9C2, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C2, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHlinkSite : IUnknown
{
    HRESULT QueryService(uint dwSiteData, const(Guid)* guidService, const(Guid)* riid, IUnknown* ppiunk);
    HRESULT GetMoniker(uint dwSiteData, uint dwAssign, uint dwWhich, IMoniker* ppimk);
    HRESULT ReadyToNavigate(uint dwSiteData, uint dwReserved);
    HRESULT OnNavigationComplete(uint dwSiteData, uint dwreserved, HRESULT hrError, const(wchar)* pwzError);
}

const GUID IID_IHlinkTarget = {0x79EAC9C4, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C4, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHlinkTarget : IUnknown
{
    HRESULT SetBrowseContext(IHlinkBrowseContext pihlbc);
    HRESULT GetBrowseContext(IHlinkBrowseContext* ppihlbc);
    HRESULT Navigate(uint grfHLNF, const(wchar)* pwzJumpLocation);
    HRESULT GetMoniker(const(wchar)* pwzLocation, uint dwAssign, IMoniker* ppimkLocation);
    HRESULT GetFriendlyName(const(wchar)* pwzLocation, ushort** ppwzFriendlyName);
}

const GUID IID_IHlinkFrame = {0x79EAC9C5, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C5, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHlinkFrame : IUnknown
{
    HRESULT SetBrowseContext(IHlinkBrowseContext pihlbc);
    HRESULT GetBrowseContext(IHlinkBrowseContext* ppihlbc);
    HRESULT Navigate(uint grfHLNF, IBindCtx pbc, IBindStatusCallback pibsc, IHlink pihlNavigate);
    HRESULT OnNavigate(uint grfHLNF, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName, uint dwreserved);
    HRESULT UpdateHlink(uint uHLID, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName);
}

struct HLITEM
{
    uint uHLID;
    const(wchar)* pwzFriendlyName;
}

const GUID IID_IEnumHLITEM = {0x79EAC9C6, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C6, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IEnumHLITEM : IUnknown
{
    HRESULT Next(uint celt, HLITEM* rgelt, uint* pceltFetched);
    HRESULT Skip(uint celt);
    HRESULT Reset();
    HRESULT Clone(IEnumHLITEM* ppienumhlitem);
}

enum __MIDL_IHlinkBrowseContext_0001
{
    HLTB_DOCKEDLEFT = 0,
    HLTB_DOCKEDTOP = 1,
    HLTB_DOCKEDRIGHT = 2,
    HLTB_DOCKEDBOTTOM = 3,
    HLTB_FLOATING = 4,
}

struct HLTBINFO
{
    uint uDockType;
    RECT rcTbPos;
}

enum __MIDL_IHlinkBrowseContext_0002
{
    HLBWIF_HASFRAMEWNDINFO = 1,
    HLBWIF_HASDOCWNDINFO = 2,
    HLBWIF_FRAMEWNDMAXIMIZED = 4,
    HLBWIF_DOCWNDMAXIMIZED = 8,
    HLBWIF_HASWEBTOOLBARINFO = 16,
    HLBWIF_WEBTOOLBARHIDDEN = 32,
}

struct HLBWINFO
{
    uint cbSize;
    uint grfHLBWIF;
    RECT rcFramePos;
    RECT rcDocPos;
    HLTBINFO hltbinfo;
}

enum __MIDL_IHlinkBrowseContext_0003
{
    HLID_INVALID = 0,
    HLID_PREVIOUS = -1,
    HLID_NEXT = -2,
    HLID_CURRENT = -3,
    HLID_STACKBOTTOM = -4,
    HLID_STACKTOP = -5,
}

enum __MIDL_IHlinkBrowseContext_0004
{
    HLQF_ISVALID = 1,
    HLQF_ISCURRENT = 2,
}

const GUID IID_IHlinkBrowseContext = {0x79EAC9C7, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9C7, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IHlinkBrowseContext : IUnknown
{
    HRESULT Register(uint reserved, IUnknown piunk, IMoniker pimk, uint* pdwRegister);
    HRESULT GetObjectA(IMoniker pimk, BOOL fBindIfRootRegistered, IUnknown* ppiunk);
    HRESULT Revoke(uint dwRegister);
    HRESULT SetBrowseWindowInfo(HLBWINFO* phlbwi);
    HRESULT GetBrowseWindowInfo(HLBWINFO* phlbwi);
    HRESULT SetInitialHlink(IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName);
    HRESULT OnNavigateHlink(uint grfHLNF, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName, uint* puHLID);
    HRESULT UpdateHlink(uint uHLID, IMoniker pimkTarget, const(wchar)* pwzLocation, const(wchar)* pwzFriendlyName);
    HRESULT EnumNavigationStack(uint dwReserved, uint grfHLFNAMEF, IEnumHLITEM* ppienumhlitem);
    HRESULT QueryHlink(uint grfHLQF, uint uHLID);
    HRESULT GetHlink(uint uHLID, IHlink* ppihl);
    HRESULT SetCurrentHlink(uint uHLID);
    HRESULT Clone(IUnknown piunkOuter, const(Guid)* riid, IUnknown* ppiunkObj);
    HRESULT Close(uint reserved);
}

const GUID IID_IExtensionServices = {0x79EAC9CB, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]};
@GUID(0x79EAC9CB, 0xBAF9, 0x11CE, [0x8C, 0x82, 0x00, 0xAA, 0x00, 0x4B, 0xA9, 0x0B]);
interface IExtensionServices : IUnknown
{
    HRESULT SetAdditionalHeaders(const(wchar)* pwzAdditionalHeaders);
    HRESULT SetAuthenticateData(HWND phwnd, const(wchar)* pwzUsername, const(wchar)* pwzPassword);
}

const GUID IID_ITravelEntry = {0xF46EDB3B, 0xBC2F, 0x11D0, [0x94, 0x12, 0x00, 0xAA, 0x00, 0xA3, 0xEB, 0xD3]};
@GUID(0xF46EDB3B, 0xBC2F, 0x11D0, [0x94, 0x12, 0x00, 0xAA, 0x00, 0xA3, 0xEB, 0xD3]);
interface ITravelEntry : IUnknown
{
    HRESULT Invoke(IUnknown punk);
    HRESULT Update(IUnknown punk, BOOL fIsLocalAnchor);
    HRESULT GetPidl(ITEMIDLIST** ppidl);
}

const GUID IID_ITravelLog = {0x66A9CB08, 0x4802, 0x11D2, [0xA5, 0x61, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0x66A9CB08, 0x4802, 0x11D2, [0xA5, 0x61, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface ITravelLog : IUnknown
{
    HRESULT AddEntry(IUnknown punk, BOOL fIsLocalAnchor);
    HRESULT UpdateEntry(IUnknown punk, BOOL fIsLocalAnchor);
    HRESULT UpdateExternal(IUnknown punk, IUnknown punkHLBrowseContext);
    HRESULT Travel(IUnknown punk, int iOffset);
    HRESULT GetTravelEntry(IUnknown punk, int iOffset, ITravelEntry* ppte);
    HRESULT FindTravelEntry(IUnknown punk, ITEMIDLIST* pidl, ITravelEntry* ppte);
    HRESULT GetToolTipText(IUnknown punk, int iOffset, int idsTemplate, const(wchar)* pwzText, uint cchText);
    HRESULT InsertMenuEntries(IUnknown punk, HMENU hmenu, int nPos, int idFirst, int idLast, uint dwFlags);
    HRESULT Clone(ITravelLog* pptl);
    uint CountEntries(IUnknown punk);
    HRESULT Revert();
}

interface CIE4ConnectionPoint : IConnectionPoint
{
    HRESULT DoInvokeIE4(int* pf, void** ppv, int dispid, DISPPARAMS* pdispparams);
    HRESULT DoInvokePIDLIE4(int dispid, ITEMIDLIST* pidl, BOOL fCanCancel);
}

const GUID IID_IExpDispSupportXP = {0x2F0DD58C, 0xF789, 0x4F14, [0x99, 0xFB, 0x92, 0x93, 0xB3, 0xC9, 0xC2, 0x12]};
@GUID(0x2F0DD58C, 0xF789, 0x4F14, [0x99, 0xFB, 0x92, 0x93, 0xB3, 0xC9, 0xC2, 0x12]);
interface IExpDispSupportXP : IUnknown
{
    HRESULT FindCIE4ConnectionPoint(const(Guid)* riid, CIE4ConnectionPoint* ppccp);
    HRESULT OnTranslateAccelerator(MSG* pMsg, uint grfModifiers);
    HRESULT OnInvoke(int dispidMember, const(Guid)* iid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, VARIANT* pVarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

const GUID IID_IExpDispSupport = {0x0D7D1D00, 0x6FC0, 0x11D0, [0xA9, 0x74, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]};
@GUID(0x0D7D1D00, 0x6FC0, 0x11D0, [0xA9, 0x74, 0x00, 0xC0, 0x4F, 0xD7, 0x05, 0xA2]);
interface IExpDispSupport : IUnknown
{
    HRESULT FindConnectionPoint(const(Guid)* riid, IConnectionPoint* ppccp);
    HRESULT OnTranslateAccelerator(MSG* pMsg, uint grfModifiers);
    HRESULT OnInvoke(int dispidMember, const(Guid)* iid, uint lcid, ushort wFlags, DISPPARAMS* pdispparams, VARIANT* pVarResult, EXCEPINFO* pexcepinfo, uint* puArgErr);
}

enum BNSTATE
{
    BNS_NORMAL = 0,
    BNS_BEGIN_NAVIGATE = 1,
    BNS_NAVIGATE = 2,
}

enum SHELLBROWSERSHOWCONTROL
{
    SBSC_HIDE = 0,
    SBSC_SHOW = 1,
    SBSC_TOGGLE = 2,
    SBSC_QUERY = 3,
}

const GUID IID_IBrowserService = {0x02BA3B52, 0x0547, 0x11D1, [0xB8, 0x33, 0x00, 0xC0, 0x4F, 0xC9, 0xB3, 0x1F]};
@GUID(0x02BA3B52, 0x0547, 0x11D1, [0xB8, 0x33, 0x00, 0xC0, 0x4F, 0xC9, 0xB3, 0x1F]);
interface IBrowserService : IUnknown
{
    HRESULT GetParentSite(IOleInPlaceSite* ppipsite);
    HRESULT SetTitle(IShellView psv, const(wchar)* pszName);
    HRESULT GetTitle(IShellView psv, const(wchar)* pszName, uint cchName);
    HRESULT GetOleObject(IOleObject* ppobjv);
    HRESULT GetTravelLog(ITravelLog* pptl);
    HRESULT ShowControlWindow(uint id, BOOL fShow);
    HRESULT IsControlWindowShown(uint id, int* pfShown);
    HRESULT IEGetDisplayName(ITEMIDLIST* pidl, const(wchar)* pwszName, uint uFlags);
    HRESULT IEParseDisplayName(uint uiCP, const(wchar)* pwszPath, ITEMIDLIST** ppidlOut);
    HRESULT DisplayParseError(HRESULT hres, const(wchar)* pwszPath);
    HRESULT NavigateToPidl(ITEMIDLIST* pidl, uint grfHLNF);
    HRESULT SetNavigateState(BNSTATE bnstate);
    HRESULT GetNavigateState(BNSTATE* pbnstate);
    HRESULT NotifyRedirect(IShellView psv, ITEMIDLIST* pidl, int* pfDidBrowse);
    HRESULT UpdateWindowList();
    HRESULT UpdateBackForwardState();
    HRESULT SetFlags(uint dwFlags, uint dwFlagMask);
    HRESULT GetFlags(uint* pdwFlags);
    HRESULT CanNavigateNow();
    HRESULT GetPidl(ITEMIDLIST** ppidl);
    HRESULT SetReferrer(ITEMIDLIST* pidl);
    uint GetBrowserIndex();
    HRESULT GetBrowserByIndex(uint dwID, IUnknown* ppunk);
    HRESULT GetHistoryObject(IOleObject* ppole, IStream* pstm, IBindCtx* ppbc);
    HRESULT SetHistoryObject(IOleObject pole, BOOL fIsLocalAnchor);
    HRESULT CacheOLEServer(IOleObject pole);
    HRESULT GetSetCodePage(VARIANT* pvarIn, VARIANT* pvarOut);
    HRESULT OnHttpEquiv(IShellView psv, BOOL fDone, VARIANT* pvarargIn, VARIANT* pvarargOut);
    HRESULT GetPalette(HPALETTE* hpal);
    HRESULT RegisterWindow(BOOL fForceRegister, int swc);
}

const GUID IID_IShellService = {0x5836FB00, 0x8187, 0x11CF, [0xA1, 0x2B, 0x00, 0xAA, 0x00, 0x4A, 0xE8, 0x37]};
@GUID(0x5836FB00, 0x8187, 0x11CF, [0xA1, 0x2B, 0x00, 0xAA, 0x00, 0x4A, 0xE8, 0x37]);
interface IShellService : IUnknown
{
    HRESULT SetOwner(IUnknown punkOwner);
}

enum SECURELOCKCODE
{
    SECURELOCK_NOCHANGE = -1,
    SECURELOCK_SET_UNSECURE = 0,
    SECURELOCK_SET_MIXED = 1,
    SECURELOCK_SET_SECUREUNKNOWNBIT = 2,
    SECURELOCK_SET_SECURE40BIT = 3,
    SECURELOCK_SET_SECURE56BIT = 4,
    SECURELOCK_SET_FORTEZZA = 5,
    SECURELOCK_SET_SECURE128BIT = 6,
    SECURELOCK_FIRSTSUGGEST = 7,
    SECURELOCK_SUGGEST_UNSECURE = 7,
    SECURELOCK_SUGGEST_MIXED = 8,
    SECURELOCK_SUGGEST_SECUREUNKNOWNBIT = 9,
    SECURELOCK_SUGGEST_SECURE40BIT = 10,
    SECURELOCK_SUGGEST_SECURE56BIT = 11,
    SECURELOCK_SUGGEST_FORTEZZA = 12,
    SECURELOCK_SUGGEST_SECURE128BIT = 13,
}

struct BASEBROWSERDATAXP
{
    HWND _hwnd;
    ITravelLog _ptl;
    IHlinkFrame _phlf;
    IWebBrowser2 _pautoWB2;
    IExpDispSupportXP _pautoEDS;
    IShellService _pautoSS;
    int _eSecureLockIcon;
    uint _bitfield;
    uint _uActivateState;
    ITEMIDLIST* _pidlViewState;
    IOleCommandTarget _pctView;
    ITEMIDLIST* _pidlCur;
    IShellView _psv;
    IShellFolder _psf;
    HWND _hwndView;
    const(wchar)* _pszTitleCur;
    ITEMIDLIST* _pidlPending;
    IShellView _psvPending;
    IShellFolder _psfPending;
    HWND _hwndViewPending;
    const(wchar)* _pszTitlePending;
    BOOL _fIsViewMSHTML;
    BOOL _fPrivacyImpacted;
    Guid _clsidView;
    Guid _clsidViewPending;
    HWND _hwndFrame;
}

struct BASEBROWSERDATALH
{
    HWND _hwnd;
    ITravelLog _ptl;
    IHlinkFrame _phlf;
    IWebBrowser2 _pautoWB2;
    IExpDispSupport _pautoEDS;
    IShellService _pautoSS;
    int _eSecureLockIcon;
    uint _bitfield;
    uint _uActivateState;
    ITEMIDLIST* _pidlViewState;
    IOleCommandTarget _pctView;
    ITEMIDLIST* _pidlCur;
    IShellView _psv;
    IShellFolder _psf;
    HWND _hwndView;
    const(wchar)* _pszTitleCur;
    ITEMIDLIST* _pidlPending;
    IShellView _psvPending;
    IShellFolder _psfPending;
    HWND _hwndViewPending;
    const(wchar)* _pszTitlePending;
    BOOL _fIsViewMSHTML;
    BOOL _fPrivacyImpacted;
    Guid _clsidView;
    Guid _clsidViewPending;
    HWND _hwndFrame;
    int _lPhishingFilterStatus;
}

struct FOLDERSETDATA
{
    FOLDERSETTINGS _fs;
    Guid _vidRestore;
    uint _dwViewPriority;
}

struct TOOLBARITEM
{
    IDockingWindow ptbar;
    RECT rcBorderTool;
    const(wchar)* pwszItem;
    BOOL fShow;
    int hMon;
}

const GUID IID_IBrowserService2 = {0x68BD21CC, 0x438B, 0x11D2, [0xA5, 0x60, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]};
@GUID(0x68BD21CC, 0x438B, 0x11D2, [0xA5, 0x60, 0x00, 0xA0, 0xC9, 0x2D, 0xBF, 0xE8]);
interface IBrowserService2 : IBrowserService
{
    LRESULT WndProcBS(HWND hwnd, uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT SetAsDefFolderSettings();
    HRESULT GetViewRect(RECT* prc);
    HRESULT OnSize(WPARAM wParam);
    HRESULT OnCreate(CREATESTRUCTW* pcs);
    LRESULT OnCommand(WPARAM wParam, LPARAM lParam);
    HRESULT OnDestroy();
    LRESULT OnNotify(NMHDR* pnm);
    HRESULT OnSetFocus();
    HRESULT OnFrameWindowActivateBS(BOOL fActive);
    HRESULT ReleaseShellView();
    HRESULT ActivatePendingView();
    HRESULT CreateViewWindow(IShellView psvNew, IShellView psvOld, RECT* prcView, HWND* phwnd);
    HRESULT CreateBrowserPropSheetExt(const(Guid)* riid, void** ppv);
    HRESULT GetViewWindow(HWND* phwndView);
    HRESULT GetBaseBrowserData(BASEBROWSERDATALH** pbbd);
    BASEBROWSERDATALH* PutBaseBrowserData();
    HRESULT InitializeTravelLog(ITravelLog ptl, uint dw);
    HRESULT SetTopBrowser();
    HRESULT Offline(int iCmd);
    HRESULT AllowViewResize(BOOL f);
    HRESULT SetActivateState(uint u);
    HRESULT UpdateSecureLockIcon(int eSecureLock);
    HRESULT InitializeDownloadManager();
    HRESULT InitializeTransitionSite();
    HRESULT _Initialize(HWND hwnd, IUnknown pauto);
    HRESULT _CancelPendingNavigationAsync();
    HRESULT _CancelPendingView();
    HRESULT _MaySaveChanges();
    HRESULT _PauseOrResumeView(BOOL fPaused);
    HRESULT _DisableModeless();
    HRESULT _NavigateToPidl2(ITEMIDLIST* pidl, uint grfHLNF, uint dwFlags);
    HRESULT _TryShell2Rename(IShellView psv, ITEMIDLIST* pidlNew);
    HRESULT _SwitchActivationNow();
    HRESULT _ExecChildren(IUnknown punkBar, BOOL fBroadcast, const(Guid)* pguidCmdGroup, uint nCmdID, uint nCmdexecopt, VARIANT* pvarargIn, VARIANT* pvarargOut);
    HRESULT _SendChildren(HWND hwndBar, BOOL fBroadcast, uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT GetFolderSetData(FOLDERSETDATA* pfsd);
    HRESULT _OnFocusChange(uint itb);
    HRESULT v_ShowHideChildWindows(BOOL fChildOnly);
    uint _get_itbLastFocus();
    HRESULT _put_itbLastFocus(uint itbLastFocus);
    HRESULT _UIActivateView(uint uState);
    HRESULT _GetViewBorderRect(RECT* prc);
    HRESULT _UpdateViewRectSize();
    HRESULT _ResizeNextBorder(uint itb);
    HRESULT _ResizeView();
    HRESULT _GetEffectiveClientArea(RECT* lprectBorder, int hmon);
    IStream v_GetViewStream(ITEMIDLIST* pidl, uint grfMode, const(wchar)* pwszName);
    LRESULT ForwardViewMsg(uint uMsg, WPARAM wParam, LPARAM lParam);
    HRESULT SetAcceleratorMenu(HACCEL hacc);
    int _GetToolbarCount();
    TOOLBARITEM* _GetToolbarItem(int itb);
    HRESULT _SaveToolbars(IStream pstm);
    HRESULT _LoadToolbars(IStream pstm);
    HRESULT _CloseAndReleaseToolbars(BOOL fClose);
    HRESULT v_MayGetNextToolbarFocus(MSG* lpMsg, uint itbNext, int citb, TOOLBARITEM** pptbi, HWND* phwnd);
    HRESULT _ResizeNextBorderHelper(uint itb, BOOL bUseHmonitor);
    uint _FindTBar(IUnknown punkSrc);
    HRESULT _SetFocus(TOOLBARITEM* ptbi, HWND hwnd, MSG* lpMsg);
    HRESULT v_MayTranslateAccelerator(MSG* pmsg);
    HRESULT _GetBorderDWHelper(IUnknown punkSrc, RECT* lprectBorder, BOOL bUseHmonitor);
    HRESULT v_CheckZoneCrossing(ITEMIDLIST* pidl);
}

enum IEPDNFLAGS
{
    IEPDN_BINDINGUI = 1,
}

const GUID IID_IBrowserService3 = {0x27D7CE21, 0x762D, 0x48F3, [0x86, 0xF3, 0x40, 0xE2, 0xFD, 0x37, 0x49, 0xC4]};
@GUID(0x27D7CE21, 0x762D, 0x48F3, [0x86, 0xF3, 0x40, 0xE2, 0xFD, 0x37, 0x49, 0xC4]);
interface IBrowserService3 : IBrowserService2
{
    HRESULT _PositionViewWindow(HWND hwnd, RECT* prc);
    HRESULT IEParseDisplayNameEx(uint uiCP, const(wchar)* pwszPath, uint dwFlags, ITEMIDLIST** ppidlOut);
}

const GUID IID_IBrowserService4 = {0x639F1BFF, 0xE135, 0x4096, [0xAB, 0xD8, 0xE0, 0xF5, 0x04, 0xD6, 0x49, 0xA4]};
@GUID(0x639F1BFF, 0xE135, 0x4096, [0xAB, 0xD8, 0xE0, 0xF5, 0x04, 0xD6, 0x49, 0xA4]);
interface IBrowserService4 : IBrowserService3
{
    HRESULT ActivateView(BOOL fPendingView);
    HRESULT SaveViewState();
    HRESULT _ResizeAllBorders();
}

const GUID IID_ITrackShellMenu = {0x8278F932, 0x2A3E, 0x11D2, [0x83, 0x8F, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]};
@GUID(0x8278F932, 0x2A3E, 0x11D2, [0x83, 0x8F, 0x00, 0xC0, 0x4F, 0xD9, 0x18, 0xD0]);
interface ITrackShellMenu : IShellMenu
{
    HRESULT SetObscured(HWND hwndTB, IUnknown punkBand, uint dwSMSetFlags);
    HRESULT Popup(HWND hwnd, POINTL* ppt, RECTL* prcExclude, int dwFlags);
}

const GUID CLSID_ImageTranscode = {0x17B75166, 0x928F, 0x417D, [0x96, 0x85, 0x64, 0xAA, 0x13, 0x55, 0x65, 0xC1]};
@GUID(0x17B75166, 0x928F, 0x417D, [0x96, 0x85, 0x64, 0xAA, 0x13, 0x55, 0x65, 0xC1]);
struct ImageTranscode;

enum TI_FLAGS
{
    TI_BITMAP = 1,
    TI_JPEG = 2,
}

const GUID IID_ITranscodeImage = {0xBAE86DDD, 0xDC11, 0x421C, [0xB7, 0xAB, 0xCC, 0x55, 0xD1, 0xD6, 0x5C, 0x44]};
@GUID(0xBAE86DDD, 0xDC11, 0x421C, [0xB7, 0xAB, 0xCC, 0x55, 0xD1, 0xD6, 0x5C, 0x44]);
interface ITranscodeImage : IUnknown
{
    HRESULT TranscodeImage(IShellItem pShellItem, uint uiMaxWidth, uint uiMaxHeight, uint flags, IStream pvImage, uint* puiWidth, uint* puiHeight);
}

enum PATHCCH_OPTIONS
{
    PATHCCH_NONE = 0,
    PATHCCH_ALLOW_LONG_PATHS = 1,
    PATHCCH_FORCE_ENABLE_LONG_NAME_PROCESS = 2,
    PATHCCH_FORCE_DISABLE_LONG_NAME_PROCESS = 4,
    PATHCCH_DO_NOT_NORMALIZE_SEGMENTS = 8,
    PATHCCH_ENSURE_IS_EXTENDED_LENGTH_PATH = 16,
    PATHCCH_ENSURE_TRAILING_SLASH = 32,
}

alias APPLET_PROC = extern(Windows) int function(HWND hwndCpl, uint msg, LPARAM lParam1, LPARAM lParam2);
struct CPLINFO
{
    int idIcon;
    int idName;
    int idInfo;
    int lData;
}

struct NEWCPLINFOA
{
    uint dwSize;
    uint dwFlags;
    uint dwHelpContext;
    int lData;
    HICON hIcon;
    byte szName;
    byte szInfo;
    byte szHelpFile;
}

struct NEWCPLINFOW
{
    uint dwSize;
    uint dwFlags;
    uint dwHelpContext;
    int lData;
    HICON hIcon;
    ushort szName;
    ushort szInfo;
    ushort szHelpFile;
}

struct PROFILEINFOA
{
    uint dwSize;
    uint dwFlags;
    const(char)* lpUserName;
    const(char)* lpProfilePath;
    const(char)* lpDefaultPath;
    const(char)* lpServerName;
    const(char)* lpPolicyPath;
    HANDLE hProfile;
}

struct PROFILEINFOW
{
    uint dwSize;
    uint dwFlags;
    const(wchar)* lpUserName;
    const(wchar)* lpProfilePath;
    const(wchar)* lpDefaultPath;
    const(wchar)* lpServerName;
    const(wchar)* lpPolicyPath;
    HANDLE hProfile;
}

enum iurl_seturl_flags
{
    IURL_SETURL_FL_GUESS_PROTOCOL = 1,
    IURL_SETURL_FL_USE_DEFAULT_PROTOCOL = 2,
}

enum iurl_invokecommand_flags
{
    IURL_INVOKECOMMAND_FL_ALLOW_UI = 1,
    IURL_INVOKECOMMAND_FL_USE_DEFAULT_VERB = 2,
    IURL_INVOKECOMMAND_FL_DDEWAIT = 4,
    IURL_INVOKECOMMAND_FL_ASYNCOK = 8,
    IURL_INVOKECOMMAND_FL_LOG_USAGE = 16,
}

struct urlinvokecommandinfoA
{
    uint dwcbSize;
    uint dwFlags;
    HWND hwndParent;
    const(char)* pcszVerb;
}

struct urlinvokecommandinfoW
{
    uint dwcbSize;
    uint dwFlags;
    HWND hwndParent;
    const(wchar)* pcszVerb;
}

const GUID IID_IUniformResourceLocatorA = {0xFBF23B80, 0xE3F0, 0x101B, [0x84, 0x88, 0x00, 0xAA, 0x00, 0x3E, 0x56, 0xF8]};
@GUID(0xFBF23B80, 0xE3F0, 0x101B, [0x84, 0x88, 0x00, 0xAA, 0x00, 0x3E, 0x56, 0xF8]);
interface IUniformResourceLocatorA : IUnknown
{
    HRESULT SetURL(const(char)* pcszURL, uint dwInFlags);
    HRESULT GetURL(byte** ppszURL);
    HRESULT InvokeCommand(urlinvokecommandinfoA* purlici);
}

const GUID IID_IUniformResourceLocatorW = {0xCABB0DA0, 0xDA57, 0x11CF, [0x99, 0x74, 0x00, 0x20, 0xAF, 0xD7, 0x97, 0x62]};
@GUID(0xCABB0DA0, 0xDA57, 0x11CF, [0x99, 0x74, 0x00, 0x20, 0xAF, 0xD7, 0x97, 0x62]);
interface IUniformResourceLocatorW : IUnknown
{
    HRESULT SetURL(const(wchar)* pcszURL, uint dwInFlags);
    HRESULT GetURL(ushort** ppszURL);
    HRESULT InvokeCommand(urlinvokecommandinfoW* purlici);
}

enum translateurl_in_flags
{
    TRANSLATEURL_FL_GUESS_PROTOCOL = 1,
    TRANSLATEURL_FL_USE_DEFAULT_PROTOCOL = 2,
}

enum urlassociationdialog_in_flags
{
    URLASSOCDLG_FL_USE_DEFAULT_NAME = 1,
    URLASSOCDLG_FL_REGISTER_ASSOC = 2,
}

enum mimeassociationdialog_in_flags
{
    MIMEASSOCDLG_FL_REGISTER_ASSOC = 1,
}

alias PAPPSTATE_CHANGE_ROUTINE = extern(Windows) void function(ubyte Quiesced, void* Context);
struct _APPSTATE_REGISTRATION
{
}

alias PAPPCONSTRAIN_CHANGE_ROUTINE = extern(Windows) void function(ubyte Constrained, void* Context);
struct _APPCONSTRAIN_REGISTRATION
{
}

const GUID CLSID_CActiveIMM = {0x4955DD33, 0xB159, 0x11D0, [0x8F, 0xCF, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]};
@GUID(0x4955DD33, 0xB159, 0x11D0, [0x8F, 0xCF, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]);
struct CActiveIMM;

struct __MIDL___MIDL_itf_dimm_0000_0000_0012
{
    HWND hWnd;
    BOOL fOpen;
    POINT ptStatusWndPos;
    POINT ptSoftKbdPos;
    uint fdwConversion;
    uint fdwSentence;
    _lfFont_e__Union lfFont;
    COMPOSITIONFORM cfCompForm;
    CANDIDATEFORM cfCandForm;
    HIMCC__* hCompStr;
    HIMCC__* hCandInfo;
    HIMCC__* hGuideLine;
    HIMCC__* hPrivate;
    uint dwNumMsgBuf;
    HIMCC__* hMsgBuf;
    uint fdwInit;
    uint dwReserve;
}

struct __MIDL___MIDL_itf_dimm_0000_0000_0014
{
    uint dwPrivateDataSize;
    uint fdwProperty;
    uint fdwConversionCaps;
    uint fdwSentenceCaps;
    uint fdwUICaps;
    uint fdwSCSCaps;
    uint fdwSelectCaps;
}

const GUID IID_IEnumRegisterWordA = {0x08C03412, 0xF96B, 0x11D0, [0xA4, 0x75, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]};
@GUID(0x08C03412, 0xF96B, 0x11D0, [0xA4, 0x75, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]);
interface IEnumRegisterWordA : IUnknown
{
    HRESULT Clone(IEnumRegisterWordA* ppEnum);
    HRESULT Next(uint ulCount, REGISTERWORDA* rgRegisterWord, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_IEnumRegisterWordW = {0x4955DD31, 0xB159, 0x11D0, [0x8F, 0xCF, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]};
@GUID(0x4955DD31, 0xB159, 0x11D0, [0x8F, 0xCF, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]);
interface IEnumRegisterWordW : IUnknown
{
    HRESULT Clone(IEnumRegisterWordW* ppEnum);
    HRESULT Next(uint ulCount, REGISTERWORDW* rgRegisterWord, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_IEnumInputContext = {0x09B5EAB0, 0xF997, 0x11D1, [0x93, 0xD4, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0x09B5EAB0, 0xF997, 0x11D1, [0x93, 0xD4, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IEnumInputContext : IUnknown
{
    HRESULT Clone(IEnumInputContext* ppEnum);
    HRESULT Next(uint ulCount, HIMC__** rgInputContext, uint* pcFetched);
    HRESULT Reset();
    HRESULT Skip(uint ulCount);
}

const GUID IID_IActiveIMMRegistrar = {0xB3458082, 0xBD00, 0x11D1, [0x93, 0x9B, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xB3458082, 0xBD00, 0x11D1, [0x93, 0x9B, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IActiveIMMRegistrar : IUnknown
{
    HRESULT RegisterIME(const(Guid)* rclsid, ushort lgid, const(wchar)* pszIconFile, const(wchar)* pszDesc);
    HRESULT UnregisterIME(const(Guid)* rclsid);
}

const GUID IID_IActiveIMMMessagePumpOwner = {0xB5CF2CFA, 0x8AEB, 0x11D1, [0x93, 0x64, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xB5CF2CFA, 0x8AEB, 0x11D1, [0x93, 0x64, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IActiveIMMMessagePumpOwner : IUnknown
{
    HRESULT Start();
    HRESULT End();
    HRESULT OnTranslateMessage(const(MSG)* pMsg);
    HRESULT Pause(uint* pdwCookie);
    HRESULT Resume(uint dwCookie);
}

const GUID IID_IActiveIMMApp = {0x08C0E040, 0x62D1, 0x11D1, [0x93, 0x26, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0x08C0E040, 0x62D1, 0x11D1, [0x93, 0x26, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IActiveIMMApp : IUnknown
{
    HRESULT AssociateContext(HWND hWnd, HIMC__* hIME, HIMC__** phPrev);
    HRESULT ConfigureIMEA(int hKL, HWND hWnd, uint dwMode, REGISTERWORDA* pData);
    HRESULT ConfigureIMEW(int hKL, HWND hWnd, uint dwMode, REGISTERWORDW* pData);
    HRESULT CreateContext(HIMC__** phIMC);
    HRESULT DestroyContext(HIMC__* hIME);
    HRESULT EnumRegisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szRegister, void* pData, IEnumRegisterWordA* pEnum);
    HRESULT EnumRegisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szRegister, void* pData, IEnumRegisterWordW* pEnum);
    HRESULT EscapeA(int hKL, HIMC__* hIMC, uint uEscape, void* pData, LRESULT* plResult);
    HRESULT EscapeW(int hKL, HIMC__* hIMC, uint uEscape, void* pData, LRESULT* plResult);
    HRESULT GetCandidateListA(HIMC__* hIMC, uint dwIndex, uint uBufLen, CANDIDATELIST* pCandList, uint* puCopied);
    HRESULT GetCandidateListW(HIMC__* hIMC, uint dwIndex, uint uBufLen, CANDIDATELIST* pCandList, uint* puCopied);
    HRESULT GetCandidateListCountA(HIMC__* hIMC, uint* pdwListSize, uint* pdwBufLen);
    HRESULT GetCandidateListCountW(HIMC__* hIMC, uint* pdwListSize, uint* pdwBufLen);
    HRESULT GetCandidateWindow(HIMC__* hIMC, uint dwIndex, CANDIDATEFORM* pCandidate);
    HRESULT GetCompositionFontA(HIMC__* hIMC, LOGFONTA* plf);
    HRESULT GetCompositionFontW(HIMC__* hIMC, LOGFONTW* plf);
    HRESULT GetCompositionStringA(HIMC__* hIMC, uint dwIndex, uint dwBufLen, int* plCopied, void* pBuf);
    HRESULT GetCompositionStringW(HIMC__* hIMC, uint dwIndex, uint dwBufLen, int* plCopied, void* pBuf);
    HRESULT GetCompositionWindow(HIMC__* hIMC, COMPOSITIONFORM* pCompForm);
    HRESULT GetContext(HWND hWnd, HIMC__** phIMC);
    HRESULT GetConversionListA(int hKL, HIMC__* hIMC, const(char)* pSrc, uint uBufLen, uint uFlag, CANDIDATELIST* pDst, uint* puCopied);
    HRESULT GetConversionListW(int hKL, HIMC__* hIMC, const(wchar)* pSrc, uint uBufLen, uint uFlag, CANDIDATELIST* pDst, uint* puCopied);
    HRESULT GetConversionStatus(HIMC__* hIMC, uint* pfdwConversion, uint* pfdwSentence);
    HRESULT GetDefaultIMEWnd(HWND hWnd, HWND* phDefWnd);
    HRESULT GetDescriptionA(int hKL, uint uBufLen, const(char)* szDescription, uint* puCopied);
    HRESULT GetDescriptionW(int hKL, uint uBufLen, const(wchar)* szDescription, uint* puCopied);
    HRESULT GetGuideLineA(HIMC__* hIMC, uint dwIndex, uint dwBufLen, const(char)* pBuf, uint* pdwResult);
    HRESULT GetGuideLineW(HIMC__* hIMC, uint dwIndex, uint dwBufLen, const(wchar)* pBuf, uint* pdwResult);
    HRESULT GetIMEFileNameA(int hKL, uint uBufLen, const(char)* szFileName, uint* puCopied);
    HRESULT GetIMEFileNameW(int hKL, uint uBufLen, const(wchar)* szFileName, uint* puCopied);
    HRESULT GetOpenStatus(HIMC__* hIMC);
    HRESULT GetProperty(int hKL, uint fdwIndex, uint* pdwProperty);
    HRESULT GetRegisterWordStyleA(int hKL, uint nItem, STYLEBUFA* pStyleBuf, uint* puCopied);
    HRESULT GetRegisterWordStyleW(int hKL, uint nItem, STYLEBUFW* pStyleBuf, uint* puCopied);
    HRESULT GetStatusWindowPos(HIMC__* hIMC, POINT* pptPos);
    HRESULT GetVirtualKey(HWND hWnd, uint* puVirtualKey);
    HRESULT InstallIMEA(const(char)* szIMEFileName, const(char)* szLayoutText, int* phKL);
    HRESULT InstallIMEW(const(wchar)* szIMEFileName, const(wchar)* szLayoutText, int* phKL);
    HRESULT IsIME(int hKL);
    HRESULT IsUIMessageA(HWND hWndIME, uint msg, WPARAM wParam, LPARAM lParam);
    HRESULT IsUIMessageW(HWND hWndIME, uint msg, WPARAM wParam, LPARAM lParam);
    HRESULT NotifyIME(HIMC__* hIMC, uint dwAction, uint dwIndex, uint dwValue);
    HRESULT RegisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szRegister);
    HRESULT RegisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szRegister);
    HRESULT ReleaseContext(HWND hWnd, HIMC__* hIMC);
    HRESULT SetCandidateWindow(HIMC__* hIMC, CANDIDATEFORM* pCandidate);
    HRESULT SetCompositionFontA(HIMC__* hIMC, LOGFONTA* plf);
    HRESULT SetCompositionFontW(HIMC__* hIMC, LOGFONTW* plf);
    HRESULT SetCompositionStringA(HIMC__* hIMC, uint dwIndex, void* pComp, uint dwCompLen, void* pRead, uint dwReadLen);
    HRESULT SetCompositionStringW(HIMC__* hIMC, uint dwIndex, void* pComp, uint dwCompLen, void* pRead, uint dwReadLen);
    HRESULT SetCompositionWindow(HIMC__* hIMC, COMPOSITIONFORM* pCompForm);
    HRESULT SetConversionStatus(HIMC__* hIMC, uint fdwConversion, uint fdwSentence);
    HRESULT SetOpenStatus(HIMC__* hIMC, BOOL fOpen);
    HRESULT SetStatusWindowPos(HIMC__* hIMC, POINT* pptPos);
    HRESULT SimulateHotKey(HWND hWnd, uint dwHotKeyID);
    HRESULT UnregisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szUnregister);
    HRESULT UnregisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szUnregister);
    HRESULT Activate(BOOL fRestoreLayout);
    HRESULT Deactivate();
    HRESULT OnDefWindowProc(HWND hWnd, uint Msg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT FilterClientWindows(ushort* aaClassList, uint uSize);
    HRESULT GetCodePageA(int hKL, uint* uCodePage);
    HRESULT GetLangId(int hKL, ushort* plid);
    HRESULT AssociateContextEx(HWND hWnd, HIMC__* hIMC, uint dwFlags);
    HRESULT DisableIME(uint idThread);
    HRESULT GetImeMenuItemsA(HIMC__* hIMC, uint dwFlags, uint dwType, IMEMENUITEMINFOA* pImeParentMenu, IMEMENUITEMINFOA* pImeMenu, uint dwSize, uint* pdwResult);
    HRESULT GetImeMenuItemsW(HIMC__* hIMC, uint dwFlags, uint dwType, IMEMENUITEMINFOW* pImeParentMenu, IMEMENUITEMINFOW* pImeMenu, uint dwSize, uint* pdwResult);
    HRESULT EnumInputContext(uint idThread, IEnumInputContext* ppEnum);
}

const GUID IID_IActiveIMMIME = {0x08C03411, 0xF96B, 0x11D0, [0xA4, 0x75, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]};
@GUID(0x08C03411, 0xF96B, 0x11D0, [0xA4, 0x75, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]);
interface IActiveIMMIME : IUnknown
{
    HRESULT AssociateContext(HWND hWnd, HIMC__* hIME, HIMC__** phPrev);
    HRESULT ConfigureIMEA(int hKL, HWND hWnd, uint dwMode, REGISTERWORDA* pData);
    HRESULT ConfigureIMEW(int hKL, HWND hWnd, uint dwMode, REGISTERWORDW* pData);
    HRESULT CreateContext(HIMC__** phIMC);
    HRESULT DestroyContext(HIMC__* hIME);
    HRESULT EnumRegisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szRegister, void* pData, IEnumRegisterWordA* pEnum);
    HRESULT EnumRegisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szRegister, void* pData, IEnumRegisterWordW* pEnum);
    HRESULT EscapeA(int hKL, HIMC__* hIMC, uint uEscape, void* pData, LRESULT* plResult);
    HRESULT EscapeW(int hKL, HIMC__* hIMC, uint uEscape, void* pData, LRESULT* plResult);
    HRESULT GetCandidateListA(HIMC__* hIMC, uint dwIndex, uint uBufLen, CANDIDATELIST* pCandList, uint* puCopied);
    HRESULT GetCandidateListW(HIMC__* hIMC, uint dwIndex, uint uBufLen, CANDIDATELIST* pCandList, uint* puCopied);
    HRESULT GetCandidateListCountA(HIMC__* hIMC, uint* pdwListSize, uint* pdwBufLen);
    HRESULT GetCandidateListCountW(HIMC__* hIMC, uint* pdwListSize, uint* pdwBufLen);
    HRESULT GetCandidateWindow(HIMC__* hIMC, uint dwIndex, CANDIDATEFORM* pCandidate);
    HRESULT GetCompositionFontA(HIMC__* hIMC, LOGFONTA* plf);
    HRESULT GetCompositionFontW(HIMC__* hIMC, LOGFONTW* plf);
    HRESULT GetCompositionStringA(HIMC__* hIMC, uint dwIndex, uint dwBufLen, int* plCopied, void* pBuf);
    HRESULT GetCompositionStringW(HIMC__* hIMC, uint dwIndex, uint dwBufLen, int* plCopied, void* pBuf);
    HRESULT GetCompositionWindow(HIMC__* hIMC, COMPOSITIONFORM* pCompForm);
    HRESULT GetContext(HWND hWnd, HIMC__** phIMC);
    HRESULT GetConversionListA(int hKL, HIMC__* hIMC, const(char)* pSrc, uint uBufLen, uint uFlag, CANDIDATELIST* pDst, uint* puCopied);
    HRESULT GetConversionListW(int hKL, HIMC__* hIMC, const(wchar)* pSrc, uint uBufLen, uint uFlag, CANDIDATELIST* pDst, uint* puCopied);
    HRESULT GetConversionStatus(HIMC__* hIMC, uint* pfdwConversion, uint* pfdwSentence);
    HRESULT GetDefaultIMEWnd(HWND hWnd, HWND* phDefWnd);
    HRESULT GetDescriptionA(int hKL, uint uBufLen, const(char)* szDescription, uint* puCopied);
    HRESULT GetDescriptionW(int hKL, uint uBufLen, const(wchar)* szDescription, uint* puCopied);
    HRESULT GetGuideLineA(HIMC__* hIMC, uint dwIndex, uint dwBufLen, const(char)* pBuf, uint* pdwResult);
    HRESULT GetGuideLineW(HIMC__* hIMC, uint dwIndex, uint dwBufLen, const(wchar)* pBuf, uint* pdwResult);
    HRESULT GetIMEFileNameA(int hKL, uint uBufLen, const(char)* szFileName, uint* puCopied);
    HRESULT GetIMEFileNameW(int hKL, uint uBufLen, const(wchar)* szFileName, uint* puCopied);
    HRESULT GetOpenStatus(HIMC__* hIMC);
    HRESULT GetProperty(int hKL, uint fdwIndex, uint* pdwProperty);
    HRESULT GetRegisterWordStyleA(int hKL, uint nItem, STYLEBUFA* pStyleBuf, uint* puCopied);
    HRESULT GetRegisterWordStyleW(int hKL, uint nItem, STYLEBUFW* pStyleBuf, uint* puCopied);
    HRESULT GetStatusWindowPos(HIMC__* hIMC, POINT* pptPos);
    HRESULT GetVirtualKey(HWND hWnd, uint* puVirtualKey);
    HRESULT InstallIMEA(const(char)* szIMEFileName, const(char)* szLayoutText, int* phKL);
    HRESULT InstallIMEW(const(wchar)* szIMEFileName, const(wchar)* szLayoutText, int* phKL);
    HRESULT IsIME(int hKL);
    HRESULT IsUIMessageA(HWND hWndIME, uint msg, WPARAM wParam, LPARAM lParam);
    HRESULT IsUIMessageW(HWND hWndIME, uint msg, WPARAM wParam, LPARAM lParam);
    HRESULT NotifyIME(HIMC__* hIMC, uint dwAction, uint dwIndex, uint dwValue);
    HRESULT RegisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szRegister);
    HRESULT RegisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szRegister);
    HRESULT ReleaseContext(HWND hWnd, HIMC__* hIMC);
    HRESULT SetCandidateWindow(HIMC__* hIMC, CANDIDATEFORM* pCandidate);
    HRESULT SetCompositionFontA(HIMC__* hIMC, LOGFONTA* plf);
    HRESULT SetCompositionFontW(HIMC__* hIMC, LOGFONTW* plf);
    HRESULT SetCompositionStringA(HIMC__* hIMC, uint dwIndex, void* pComp, uint dwCompLen, void* pRead, uint dwReadLen);
    HRESULT SetCompositionStringW(HIMC__* hIMC, uint dwIndex, void* pComp, uint dwCompLen, void* pRead, uint dwReadLen);
    HRESULT SetCompositionWindow(HIMC__* hIMC, COMPOSITIONFORM* pCompForm);
    HRESULT SetConversionStatus(HIMC__* hIMC, uint fdwConversion, uint fdwSentence);
    HRESULT SetOpenStatus(HIMC__* hIMC, BOOL fOpen);
    HRESULT SetStatusWindowPos(HIMC__* hIMC, POINT* pptPos);
    HRESULT SimulateHotKey(HWND hWnd, uint dwHotKeyID);
    HRESULT UnregisterWordA(int hKL, const(char)* szReading, uint dwStyle, const(char)* szUnregister);
    HRESULT UnregisterWordW(int hKL, const(wchar)* szReading, uint dwStyle, const(wchar)* szUnregister);
    HRESULT GenerateMessage(HIMC__* hIMC);
    HRESULT LockIMC(HIMC__* hIMC, __MIDL___MIDL_itf_dimm_0000_0000_0012** ppIMC);
    HRESULT UnlockIMC(HIMC__* hIMC);
    HRESULT GetIMCLockCount(HIMC__* hIMC, uint* pdwLockCount);
    HRESULT CreateIMCC(uint dwSize, HIMCC__** phIMCC);
    HRESULT DestroyIMCC(HIMCC__* hIMCC);
    HRESULT LockIMCC(HIMCC__* hIMCC, void** ppv);
    HRESULT UnlockIMCC(HIMCC__* hIMCC);
    HRESULT ReSizeIMCC(HIMCC__* hIMCC, uint dwSize, HIMCC__** phIMCC);
    HRESULT GetIMCCSize(HIMCC__* hIMCC, uint* pdwSize);
    HRESULT GetIMCCLockCount(HIMCC__* hIMCC, uint* pdwLockCount);
    HRESULT GetHotKey(uint dwHotKeyID, uint* puModifiers, uint* puVKey, int* phKL);
    HRESULT SetHotKey(uint dwHotKeyID, uint uModifiers, uint uVKey, int hKL);
    HRESULT CreateSoftKeyboard(uint uType, HWND hOwner, int x, int y, HWND* phSoftKbdWnd);
    HRESULT DestroySoftKeyboard(HWND hSoftKbdWnd);
    HRESULT ShowSoftKeyboard(HWND hSoftKbdWnd, int nCmdShow);
    HRESULT GetCodePageA(int hKL, uint* uCodePage);
    HRESULT GetLangId(int hKL, ushort* plid);
    HRESULT KeybdEvent(ushort lgidIME, ubyte bVk, ubyte bScan, uint dwFlags, uint dwExtraInfo);
    HRESULT LockModal();
    HRESULT UnlockModal();
    HRESULT AssociateContextEx(HWND hWnd, HIMC__* hIMC, uint dwFlags);
    HRESULT DisableIME(uint idThread);
    HRESULT GetImeMenuItemsA(HIMC__* hIMC, uint dwFlags, uint dwType, IMEMENUITEMINFOA* pImeParentMenu, IMEMENUITEMINFOA* pImeMenu, uint dwSize, uint* pdwResult);
    HRESULT GetImeMenuItemsW(HIMC__* hIMC, uint dwFlags, uint dwType, IMEMENUITEMINFOW* pImeParentMenu, IMEMENUITEMINFOW* pImeMenu, uint dwSize, uint* pdwResult);
    HRESULT EnumInputContext(uint idThread, IEnumInputContext* ppEnum);
    HRESULT RequestMessageA(HIMC__* hIMC, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT RequestMessageW(HIMC__* hIMC, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT SendIMCA(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT SendIMCW(HWND hWnd, uint uMsg, WPARAM wParam, LPARAM lParam, LRESULT* plResult);
    HRESULT IsSleeping();
}

const GUID IID_IActiveIME = {0x6FE20962, 0xD077, 0x11D0, [0x8F, 0xE7, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]};
@GUID(0x6FE20962, 0xD077, 0x11D0, [0x8F, 0xE7, 0x00, 0xAA, 0x00, 0x6B, 0xCC, 0x59]);
interface IActiveIME : IUnknown
{
    HRESULT Inquire(uint dwSystemInfoFlags, __MIDL___MIDL_itf_dimm_0000_0000_0014* pIMEInfo, const(wchar)* szWndClass, uint* pdwPrivate);
    HRESULT ConversionList(HIMC__* hIMC, const(wchar)* szSource, uint uFlag, uint uBufLen, CANDIDATELIST* pDest, uint* puCopied);
    HRESULT Configure(int hKL, HWND hWnd, uint dwMode, REGISTERWORDW* pRegisterWord);
    HRESULT Destroy(uint uReserved);
    HRESULT Escape(HIMC__* hIMC, uint uEscape, void* pData, LRESULT* plResult);
    HRESULT SetActiveContext(HIMC__* hIMC, BOOL fFlag);
    HRESULT ProcessKey(HIMC__* hIMC, uint uVirKey, uint lParam, ubyte* pbKeyState);
    HRESULT Notify(HIMC__* hIMC, uint dwAction, uint dwIndex, uint dwValue);
    HRESULT Select(HIMC__* hIMC, BOOL fSelect);
    HRESULT SetCompositionString(HIMC__* hIMC, uint dwIndex, void* pComp, uint dwCompLen, void* pRead, uint dwReadLen);
    HRESULT ToAsciiEx(uint uVirKey, uint uScanCode, ubyte* pbKeyState, uint fuState, HIMC__* hIMC, uint* pdwTransBuf, uint* puSize);
    HRESULT RegisterWord(const(wchar)* szReading, uint dwStyle, const(wchar)* szString);
    HRESULT UnregisterWord(const(wchar)* szReading, uint dwStyle, const(wchar)* szString);
    HRESULT GetRegisterWordStyle(uint nItem, STYLEBUFW* pStyleBuf, uint* puBufSize);
    HRESULT EnumRegisterWord(const(wchar)* szReading, uint dwStyle, const(wchar)* szRegister, void* pData, IEnumRegisterWordW* ppEnum);
    HRESULT GetCodePageA(uint* uCodePage);
    HRESULT GetLangId(ushort* plid);
}

const GUID IID_IActiveIME2 = {0xE1C4BF0E, 0x2D53, 0x11D2, [0x93, 0xE1, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]};
@GUID(0xE1C4BF0E, 0x2D53, 0x11D2, [0x93, 0xE1, 0x00, 0x60, 0xB0, 0x67, 0xB8, 0x6E]);
interface IActiveIME2 : IActiveIME
{
    HRESULT Sleep();
    HRESULT Unsleep(BOOL fDead);
}

struct NC_ADDRESS
{
    NET_ADDRESS_INFO* pAddrInfo;
    ushort PortNumber;
    ubyte PrefixLength;
}

enum ShellWindowTypeConstants
{
    SWC_EXPLORER = 0,
    SWC_BROWSER = 1,
    SWC_3RDPARTY = 2,
    SWC_CALLBACK = 4,
    SWC_DESKTOP = 8,
}

enum ShellWindowFindWindowOptions
{
    SWFO_NEEDDISPATCH = 1,
    SWFO_INCLUDEPENDING = 2,
    SWFO_COOKIEPASSED = 4,
}

const GUID IID_IShellWindows = {0x85CB6900, 0x4D95, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]};
@GUID(0x85CB6900, 0x4D95, 0x11CF, [0x96, 0x0C, 0x00, 0x80, 0xC7, 0xF4, 0xEE, 0x85]);
interface IShellWindows : IDispatch
{
    HRESULT get_Count(int* Count);
    HRESULT Item(VARIANT index, IDispatch* Folder);
    HRESULT _NewEnum(IUnknown* ppunk);
    HRESULT Register(IDispatch pid, int hwnd, int swClass, int* plCookie);
    HRESULT RegisterPending(int lThreadId, VARIANT* pvarloc, VARIANT* pvarlocRoot, int swClass, int* plCookie);
    HRESULT Revoke(int lCookie);
    HRESULT OnNavigate(int lCookie, VARIANT* pvarLoc);
    HRESULT OnActivated(int lCookie, short fActive);
    HRESULT FindWindowSW(VARIANT* pvarLoc, VARIANT* pvarLocRoot, int swClass, int* phwnd, int swfwOptions, IDispatch* ppdispOut);
    HRESULT OnCreated(int lCookie, IUnknown punk);
    HRESULT ProcessAttachDetach(short fAttach);
}

struct SERIALIZEDPROPERTYVALUE
{
    uint dwType;
    ubyte rgb;
}

