module windows.hidpi;

public import windows.com;
public import windows.displaydevices;
public import windows.systemservices;
public import windows.windowsandmessaging;

extern(Windows):

enum DPI_AWARENESS
{
    DPI_AWARENESS_INVALID = -1,
    DPI_AWARENESS_UNAWARE = 0,
    DPI_AWARENESS_SYSTEM_AWARE = 1,
    DPI_AWARENESS_PER_MONITOR_AWARE = 2,
}

enum DPI_HOSTING_BEHAVIOR
{
    DPI_HOSTING_BEHAVIOR_INVALID = -1,
    DPI_HOSTING_BEHAVIOR_DEFAULT = 0,
    DPI_HOSTING_BEHAVIOR_MIXED = 1,
}

@DllImport("UxTheme.dll")
int OpenThemeDataForDpi(HWND hwnd, const(wchar)* pszClassList, uint dpi);

@DllImport("USER32.dll")
BOOL SetDialogControlDpiChangeBehavior(HWND hWnd, DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS mask, DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS values);

@DllImport("USER32.dll")
DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS GetDialogControlDpiChangeBehavior(HWND hWnd);

@DllImport("USER32.dll")
BOOL SetDialogDpiChangeBehavior(HWND hDlg, DIALOG_DPI_CHANGE_BEHAVIORS mask, DIALOG_DPI_CHANGE_BEHAVIORS values);

@DllImport("USER32.dll")
DIALOG_DPI_CHANGE_BEHAVIORS GetDialogDpiChangeBehavior(HWND hDlg);

@DllImport("USER32.dll")
int GetSystemMetricsForDpi(int nIndex, uint dpi);

@DllImport("USER32.dll")
BOOL AdjustWindowRectExForDpi(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle, uint dpi);

@DllImport("USER32.dll")
BOOL LogicalToPhysicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
BOOL PhysicalToLogicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

@DllImport("USER32.dll")
BOOL SystemParametersInfoForDpi(uint uiAction, uint uiParam, void* pvParam, uint fWinIni, uint dpi);

@DllImport("USER32.dll")
int SetThreadDpiAwarenessContext(int dpiContext);

@DllImport("USER32.dll")
int GetThreadDpiAwarenessContext();

@DllImport("USER32.dll")
int GetWindowDpiAwarenessContext(HWND hwnd);

@DllImport("USER32.dll")
DPI_AWARENESS GetAwarenessFromDpiAwarenessContext(int value);

@DllImport("USER32.dll")
uint GetDpiFromDpiAwarenessContext(int value);

@DllImport("USER32.dll")
BOOL AreDpiAwarenessContextsEqual(int dpiContextA, int dpiContextB);

@DllImport("USER32.dll")
BOOL IsValidDpiAwarenessContext(int value);

@DllImport("USER32.dll")
uint GetDpiForWindow(HWND hwnd);

@DllImport("USER32.dll")
uint GetDpiForSystem();

@DllImport("USER32.dll")
uint GetSystemDpiForProcess(HANDLE hProcess);

@DllImport("USER32.dll")
BOOL EnableNonClientDpiScaling(HWND hwnd);

@DllImport("USER32.dll")
BOOL SetProcessDpiAwarenessContext(int value);

@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR SetThreadDpiHostingBehavior(DPI_HOSTING_BEHAVIOR value);

@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR GetThreadDpiHostingBehavior();

@DllImport("USER32.dll")
DPI_HOSTING_BEHAVIOR GetWindowDpiHostingBehavior(HWND hwnd);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS* value);

@DllImport("api-ms-win-shcore-scaling-l1-1-1.dll")
HRESULT GetDpiForMonitor(int hmonitor, MONITOR_DPI_TYPE dpiType, uint* dpiX, uint* dpiY);

enum DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS
{
    DCDC_DEFAULT = 0,
    DCDC_DISABLE_FONT_UPDATE = 1,
    DCDC_DISABLE_RELAYOUT = 2,
}

enum DIALOG_DPI_CHANGE_BEHAVIORS
{
    DDC_DEFAULT = 0,
    DDC_DISABLE_ALL = 1,
    DDC_DISABLE_RESIZE = 2,
    DDC_DISABLE_CONTROL_RELAYOUT = 4,
}

enum PROCESS_DPI_AWARENESS
{
    PROCESS_DPI_UNAWARE = 0,
    PROCESS_SYSTEM_DPI_AWARE = 1,
    PROCESS_PER_MONITOR_DPI_AWARE = 2,
}

enum MONITOR_DPI_TYPE
{
    MDT_EFFECTIVE_DPI = 0,
    MDT_ANGULAR_DPI = 1,
    MDT_RAW_DPI = 2,
    MDT_DEFAULT = 0,
}

