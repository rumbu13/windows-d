module windows.windowsstationsanddesktops;

public import windows.core;
public import windows.displaydevices : DEVMODEW;
public import windows.menusandresources : DESKTOPENUMPROCA, DESKTOPENUMPROCW, WINSTAENUMPROCA, WINSTAENUMPROCW,
                                          WNDENUMPROC;
public import windows.systemservices : BOOL, HANDLE, SECURITY_ATTRIBUTES;
public import windows.windowsandmessaging : LPARAM;
public import windows.xps : DEVMODEA;

extern(Windows):


// Structs


alias HDESK = ptrdiff_t;

struct USEROBJECTFLAGS
{
    BOOL fInherit;
    BOOL fReserved;
    uint dwFlags;
}

// Functions

@DllImport("USER32")
HDESK CreateDesktopA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, 
                     uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32")
HDESK CreateDesktopW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, 
                     uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32")
HDESK CreateDesktopExA(const(char)* lpszDesktop, const(char)* lpszDevice, DEVMODEA* pDevmode, uint dwFlags, 
                       uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

@DllImport("USER32")
HDESK CreateDesktopExW(const(wchar)* lpszDesktop, const(wchar)* lpszDevice, DEVMODEW* pDevmode, uint dwFlags, 
                       uint dwDesiredAccess, SECURITY_ATTRIBUTES* lpsa, uint ulHeapSize, void* pvoid);

@DllImport("USER32")
HDESK OpenDesktopA(const(char)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32")
HDESK OpenDesktopW(const(wchar)* lpszDesktop, uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32")
HDESK OpenInputDesktop(uint dwFlags, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32")
BOOL EnumDesktopsA(ptrdiff_t hwinsta, DESKTOPENUMPROCA lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
BOOL EnumDesktopsW(ptrdiff_t hwinsta, DESKTOPENUMPROCW lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
BOOL EnumDesktopWindows(HDESK hDesktop, WNDENUMPROC lpfn, LPARAM lParam);

@DllImport("USER32")
BOOL SwitchDesktop(HDESK hDesktop);

@DllImport("USER32")
BOOL SetThreadDesktop(HDESK hDesktop);

@DllImport("USER32")
BOOL CloseDesktop(HDESK hDesktop);

@DllImport("USER32")
HDESK GetThreadDesktop(uint dwThreadId);

@DllImport("USER32")
ptrdiff_t CreateWindowStationA(const(char)* lpwinsta, uint dwFlags, uint dwDesiredAccess, 
                               SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32")
ptrdiff_t CreateWindowStationW(const(wchar)* lpwinsta, uint dwFlags, uint dwDesiredAccess, 
                               SECURITY_ATTRIBUTES* lpsa);

@DllImport("USER32")
ptrdiff_t OpenWindowStationA(const(char)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32")
ptrdiff_t OpenWindowStationW(const(wchar)* lpszWinSta, BOOL fInherit, uint dwDesiredAccess);

@DllImport("USER32")
BOOL EnumWindowStationsA(WINSTAENUMPROCA lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
BOOL EnumWindowStationsW(WINSTAENUMPROCW lpEnumFunc, LPARAM lParam);

@DllImport("USER32")
BOOL CloseWindowStation(ptrdiff_t hWinSta);

@DllImport("USER32")
BOOL SetProcessWindowStation(ptrdiff_t hWinSta);

@DllImport("USER32")
ptrdiff_t GetProcessWindowStation();

@DllImport("USER32")
BOOL GetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

@DllImport("USER32")
BOOL GetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength, uint* lpnLengthNeeded);

@DllImport("USER32")
BOOL SetUserObjectInformationA(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);

@DllImport("USER32")
BOOL SetUserObjectInformationW(HANDLE hObj, int nIndex, char* pvInfo, uint nLength);


