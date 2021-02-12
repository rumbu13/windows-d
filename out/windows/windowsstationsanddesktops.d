module windows.windowsstationsanddesktops;

public import windows.displaydevices;
public import windows.menusandresources;
public import windows.systemservices;
public import windows.windowsandmessaging;
public import windows.xps;

extern(Windows):

alias HDESK = int;
struct USEROBJECTFLAGS
{
    BOOL fInherit;
    BOOL fReserved;
    uint dwFlags;
}

@DllImport("USER32.dll")
HDESK CreateDesktopA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32.dll")
HDESK CreateDesktopW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32.dll")
HDESK CreateDesktopExA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

@DllImport("USER32.dll")
HDESK CreateDesktopExW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

@DllImport("USER32.dll")
HDESK OpenDesktopA(const(char)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32.dll")
HDESK OpenDesktopW(const(wchar)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32.dll")
HDESK OpenInputDesktop(uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32.dll")
BOOL EnumDesktopsA(int hwinsta, DESKTOPENUMPROCA lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
BOOL EnumDesktopsW(int hwinsta, DESKTOPENUMPROCW lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
BOOL EnumDesktopWindows(HDESK hDesktop, WNDENUMPROC lpfn, LPARAM lParam);

@DllImport("USER32.dll")
BOOL SwitchDesktop(HDESK hDesktop);

@DllImport("USER32.dll")
BOOL SetThreadDesktop(HDESK hDesktop);

@DllImport("USER32.dll")
BOOL CloseDesktop(HDESK hDesktop);

@DllImport("USER32.dll")
HDESK GetThreadDesktop(uint dwThreadId);

@DllImport("USER32.dll")
int CreateWindowStationA(const(char)* lpwinsta, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32.dll")
int CreateWindowStationW(const(wchar)* lpwinsta, uint dwFlags, uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32.dll")
int OpenWindowStationA(const(char)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32.dll")
int OpenWindowStationW(const(wchar)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32.dll")
BOOL EnumWindowStationsA(WINSTAENUMPROCA lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
BOOL EnumWindowStationsW(WINSTAENUMPROCW lpEnumFunc, LPARAM lParam);

@DllImport("USER32.dll")
BOOL CloseWindowStation(int hWinSta);

@DllImport("USER32.dll")
BOOL SetProcessWindowStation(int hWinSta);

@DllImport("USER32.dll")
int GetProcessWindowStation();

@DllImport("USER32.dll")
BOOL GetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

@DllImport("USER32.dll")
BOOL GetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

@DllImport("USER32.dll")
BOOL SetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);

@DllImport("USER32.dll")
BOOL SetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);

