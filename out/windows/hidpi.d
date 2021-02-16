module windows.hidpi;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.systemservices : BOOL, HANDLE;
public import windows.windowsandmessaging : HWND;

extern(Windows):


// Enums


enum : int
{
    DPI_AWARENESS_INVALID           = 0xffffffff,
    DPI_AWARENESS_UNAWARE           = 0x00000000,
    DPI_AWARENESS_SYSTEM_AWARE      = 0x00000001,
    DPI_AWARENESS_PER_MONITOR_AWARE = 0x00000002,
}
alias DPI_AWARENESS = int;

enum : int
{
    DPI_HOSTING_BEHAVIOR_INVALID = 0xffffffff,
    DPI_HOSTING_BEHAVIOR_DEFAULT = 0x00000000,
    DPI_HOSTING_BEHAVIOR_MIXED   = 0x00000001,
}
alias DPI_HOSTING_BEHAVIOR = int;

enum : int
{
    DCDC_DEFAULT             = 0x00000000,
    DCDC_DISABLE_FONT_UPDATE = 0x00000001,
    DCDC_DISABLE_RELAYOUT    = 0x00000002,
}
alias DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS = int;

enum : int
{
    DDC_DEFAULT                  = 0x00000000,
    DDC_DISABLE_ALL              = 0x00000001,
    DDC_DISABLE_RESIZE           = 0x00000002,
    DDC_DISABLE_CONTROL_RELAYOUT = 0x00000004,
}
alias DIALOG_DPI_CHANGE_BEHAVIORS = int;

enum : int
{
    PROCESS_DPI_UNAWARE           = 0x00000000,
    PROCESS_SYSTEM_DPI_AWARE      = 0x00000001,
    PROCESS_PER_MONITOR_DPI_AWARE = 0x00000002,
}
alias PROCESS_DPI_AWARENESS = int;

enum : int
{
    MDT_EFFECTIVE_DPI = 0x00000000,
    MDT_ANGULAR_DPI   = 0x00000001,
    MDT_RAW_DPI       = 0x00000002,
    MDT_DEFAULT       = 0x00000000,
}
alias MONITOR_DPI_TYPE = int;

// Functions

@DllImport("UxTheme")
ptrdiff_t OpenThemeDataForDpi(HWND hwnd, const(wchar)* pszClassList, uint dpi);

@DllImport("USER32")
BOOL SetDialogControlDpiChangeBehavior(HWND hWnd, DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS mask, 
                                       DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS values);

@DllImport("USER32")
DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS GetDialogControlDpiChangeBehavior(HWND hWnd);

@DllImport("USER32")
BOOL SetDialogDpiChangeBehavior(HWND hDlg, DIALOG_DPI_CHANGE_BEHAVIORS mask, DIALOG_DPI_CHANGE_BEHAVIORS values);

@DllImport("USER32")
DIALOG_DPI_CHANGE_BEHAVIORS GetDialogDpiChangeBehavior(HWND hDlg);

@DllImport("USER32")
int GetSystemMetricsForDpi(int nIndex, uint dpi);

@DllImport("USER32")
BOOL AdjustWindowRectExForDpi(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle, uint dpi);

@DllImport("USER32")
BOOL LogicalToPhysicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

@DllImport("USER32")
BOOL PhysicalToLogicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

@DllImport("USER32")
BOOL SystemParametersInfoForDpi(uint uiAction, uint uiParam, void* pvParam, uint fWinIni, uint dpi);

@DllImport("USER32")
ptrdiff_t SetThreadDpiAwarenessContext(ptrdiff_t dpiContext);

@DllImport("USER32")
ptrdiff_t GetThreadDpiAwarenessContext();

@DllImport("USER32")
ptrdiff_t GetWindowDpiAwarenessContext(HWND hwnd);

@DllImport("USER32")
DPI_AWARENESS GetAwarenessFromDpiAwarenessContext(ptrdiff_t value);

@DllImport("USER32")
uint GetDpiFromDpiAwarenessContext(ptrdiff_t value);

@DllImport("USER32")
BOOL AreDpiAwarenessContextsEqual(ptrdiff_t dpiContextA, ptrdiff_t dpiContextB);

@DllImport("USER32")
BOOL IsValidDpiAwarenessContext(ptrdiff_t value);

@DllImport("USER32")
uint GetDpiForWindow(HWND hwnd);

@DllImport("USER32")
uint GetDpiForSystem();

@DllImport("USER32")
uint GetSystemDpiForProcess(HANDLE hProcess);

@DllImport("USER32")
BOOL EnableNonClientDpiScaling(HWND hwnd);

@DllImport("USER32")
BOOL SetProcessDpiAwarenessContext(ptrdiff_t value);

@DllImport("USER32")
DPI_HOSTING_BEHAVIOR SetThreadDpiHostingBehavior(DPI_HOSTING_BEHAVIOR value);

@DllImport("USER32")
DPI_HOSTING_BEHAVIOR GetThreadDpiHostingBehavior();

@DllImport("USER32")
DPI_HOSTING_BEHAVIOR GetWindowDpiHostingBehavior(HWND hwnd);

@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);

@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS* value);

@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT GetDpiForMonitor(ptrdiff_t hmonitor, MONITOR_DPI_TYPE dpiType, uint* dpiX, uint* dpiY);


