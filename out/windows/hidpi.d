// Written in the D programming language.

module windows.hidpi;

public import windows.core;
public import windows.com : HRESULT;
public import windows.displaydevices : POINT, RECT;
public import windows.gdi : HMONITOR;
public import windows.systemservices : BOOL, HANDLE, PWSTR;
public import windows.windowsandmessaging : HWND;

extern(Windows) @nogc nothrow:


// Enums


///Describes per-monitor DPI scaling behavior overrides for child windows within dialogs. The values in this enumeration
///are bitfields and can be combined.
alias DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS = int;
enum : int
{
    ///The default behavior of the dialog manager. The dialog managed will update the font, size, and position of the
    ///child window on DPI changes.
    DCDC_DEFAULT             = 0x00000000,
    ///Prevents the dialog manager from sending an updated font to the child window via WM_SETFONT in response to a DPI
    ///change.
    DCDC_DISABLE_FONT_UPDATE = 0x00000001,
    ///Prevents the dialog manager from resizing and repositioning the child window in response to a DPI change.
    DCDC_DISABLE_RELAYOUT    = 0x00000002,
}

///In Per Monitor v2 contexts, dialogs will automatically respond to DPI changes by resizing themselves and re-computing
///the positions of their child windows (here referred to as re-layouting). This enum works in conjunction with
///SetDialogDpiChangeBehavior in order to override the default DPI scaling behavior for dialogs. This does not affect
///DPI scaling behavior for the child windows of dialogs (beyond re-layouting), which is controlled by
///DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS.
alias DIALOG_DPI_CHANGE_BEHAVIORS = int;
enum : int
{
    ///The default behavior of the dialog manager. In response to a DPI change, the dialog manager will re-layout each
    ///control, update the font on each control, resize the dialog, and update the dialog's own font.
    DDC_DEFAULT                  = 0x00000000,
    ///Prevents the dialog manager from responding to WM_GETDPISCALEDSIZE and WM_DPICHANGED, disabling all default DPI
    ///scaling behavior.
    DDC_DISABLE_ALL              = 0x00000001,
    ///Prevents the dialog manager from resizing the dialog in response to a DPI change.
    DDC_DISABLE_RESIZE           = 0x00000002,
    ///Prevents the dialog manager from re-layouting all of the dialogue's immediate children HWNDs in response to a DPI
    ///change.
    DDC_DISABLE_CONTROL_RELAYOUT = 0x00000004,
}

///Identifies dots per inch (dpi) awareness values. DPI awareness indicates how much scaling work an application
///performs for DPI versus how much is done by the system. Users have the ability to set the DPI scale factor on their
///displays independent of each other. Some legacy applications are not able to adjust their scaling for multiple DPI
///settings. In order for users to use these applications without content appearing too large or small on displays,
///Windows can apply DPI virtualization to an application, causing it to be automatically be scaled by the system to
///match the DPI of the current display. The <b>PROCESS_DPI_AWARENESS</b> value indicates what level of scaling your
///application handles on its own and how much is provided by Windows. Keep in mind that applications scaled by the
///system may appear blurry and will read virtualized data about the monitor to maintain compatibility.
alias PROCESS_DPI_AWARENESS = int;
enum : int
{
    ///DPI unaware. This app does not scale for DPI changes and is always assumed to have a scale factor of 100% (96
    ///DPI). It will be automatically scaled by the system on any other DPI setting.
    PROCESS_DPI_UNAWARE           = 0x00000000,
    ///System DPI aware. This app does not scale for DPI changes. It will query for the DPI once and use that value for
    ///the lifetime of the app. If the DPI changes, the app will not adjust to the new DPI value. It will be
    ///automatically scaled up or down by the system when the DPI changes from the system value.
    PROCESS_SYSTEM_DPI_AWARE      = 0x00000001,
    ///Per monitor DPI aware. This app checks for the DPI when it is created and adjusts the scale factor whenever the
    ///DPI changes. These applications are not automatically scaled by the system.
    PROCESS_PER_MONITOR_DPI_AWARE = 0x00000002,
}

///Identifies the dots per inch (dpi) setting for a monitor.
alias MONITOR_DPI_TYPE = int;
enum : int
{
    ///The effective DPI. This value should be used when determining the correct scale factor for scaling UI elements.
    ///This incorporates the scale factor set by the user for this specific display.
    MDT_EFFECTIVE_DPI = 0x00000000,
    ///The angular DPI. This DPI ensures rendering at a compliant angular resolution on the screen. This does not
    ///include the scale factor set by the user for this specific display.
    MDT_ANGULAR_DPI   = 0x00000001,
    ///The raw DPI. This value is the linear DPI of the screen as measured on the screen itself. Use this value when you
    ///want to read the pixel density and not the recommended scaling setting. This does not include the scale factor
    ///set by the user for this specific display and is not guaranteed to be a supported DPI value.
    MDT_RAW_DPI       = 0x00000002,
    ///The default DPI setting for a monitor is MDT_EFFECTIVE_DPI.
    MDT_DEFAULT       = 0x00000000,
}

///Identifies the dots per inch (dpi) setting for a thread, process, or window.
alias DPI_AWARENESS = int;
enum : int
{
    ///Invalid DPI awareness. This is an invalid DPI awareness value.
    DPI_AWARENESS_INVALID           = 0xffffffff,
    ///DPI unaware. This process does not scale for DPI changes and is always assumed to have a scale factor of 100% (96
    ///DPI). It will be automatically scaled by the system on any other DPI setting.
    DPI_AWARENESS_UNAWARE           = 0x00000000,
    ///System DPI aware. This process does not scale for DPI changes. It will query for the DPI once and use that value
    ///for the lifetime of the process. If the DPI changes, the process will not adjust to the new DPI value. It will be
    ///automatically scaled up or down by the system when the DPI changes from the system value.
    DPI_AWARENESS_SYSTEM_AWARE      = 0x00000001,
    ///Per monitor DPI aware. This process checks for the DPI when it is created and adjusts the scale factor whenever
    ///the DPI changes. These processes are not automatically scaled by the system.
    DPI_AWARENESS_PER_MONITOR_AWARE = 0x00000002,
}

///Identifies the DPI hosting behavior for a window. This behavior allows windows created in the thread to host child
///windows with a different <b>DPI_AWARENESS_CONTEXT</b>
alias DPI_HOSTING_BEHAVIOR = int;
enum : int
{
    ///Invalid DPI hosting behavior. This usually occurs if the previous SetThreadDpiHostingBehavior call used an
    ///invalid parameter.
    DPI_HOSTING_BEHAVIOR_INVALID = 0xffffffff,
    ///Default DPI hosting behavior. The associated window behaves as normal, and cannot create or re-parent child
    ///windows with a different <b>DPI_AWARENESS_CONTEXT</b>.
    DPI_HOSTING_BEHAVIOR_DEFAULT = 0x00000000,
    ///Mixed DPI hosting behavior. This enables the creation and re-parenting of child windows with different
    ///<b>DPI_AWARENESS_CONTEXT</b>. These child windows will be independently scaled by the OS.
    DPI_HOSTING_BEHAVIOR_MIXED   = 0x00000001,
}

// Functions

///Overrides the default per-monitor DPI scaling behavior of a child window in a dialog.
///Params:
///    hWnd = A handle for the window whose behavior will be modified.
///    mask = A mask specifying the subset of flags to be changed.
///    values = The desired value to be set for the specified subset of flags.
///Returns:
///    This function returns TRUE if the operation was successful, and FALSE otherwise. To get extended error
///    information, call GetLastError. Possible errors are <b>ERROR_INVALID_HANDLE</b> if passed an invalid HWND, and
///    <b>ERROR_ACCESS_DENIED</b> if the windows belongs to another process.
///    
@DllImport("USER32")
BOOL SetDialogControlDpiChangeBehavior(HWND hWnd, DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS mask, 
                                       DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS values);

///Retrieves and per-monitor DPI scaling behavior overrides of a child window in a dialog.
///Params:
///    hWnd = The handle for the window to examine.
///Returns:
///    The flags set on the given window. If passed an invalid handle, this function will return zero, and set its last
///    error to <b>ERROR_INVALID_HANDLE</b>.
///    
@DllImport("USER32")
DIALOG_CONTROL_DPI_CHANGE_BEHAVIORS GetDialogControlDpiChangeBehavior(HWND hWnd);

///Dialogs in Per-Monitor v2 contexts are automatically DPI scaled. This method lets you customize their DPI change
///behavior. This function works in conjunction with the DIALOG_DPI_CHANGE_BEHAVIORS enum in order to override the
///default DPI scaling behavior for dialogs. This function is called on a specified dialog, for which the specified
///flags are individually saved. This function does not affect the DPI scaling behavior for the child windows of the
///dialog in question - that is done with SetDialogControlDpiChangeBehavior.
///Params:
///    hDlg = A handle for the dialog whose behavior will be modified.
///    mask = A mask specifying the subset of flags to be changed.
///    values = The desired value to be set for the specified subset of flags.
///Returns:
///    This function returns TRUE if the operation was successful, and FALSE otherwise. To get extended error
///    information, call GetLastError. Possible errors are <b>ERROR_INVALID_HANDLE</b> if passed an invalid dialog HWND,
///    and <b>ERROR_ACCESS_DENIED</b> if the dialog belongs to another process.
///    
@DllImport("USER32")
BOOL SetDialogDpiChangeBehavior(HWND hDlg, DIALOG_DPI_CHANGE_BEHAVIORS mask, DIALOG_DPI_CHANGE_BEHAVIORS values);

///Returns the flags that might have been set on a given dialog by an earlier call to SetDialogDpiChangeBehavior. If
///that function was never called on the dialog, the return value will be zero.
///Params:
///    hDlg = The handle for the dialog to examine.
///Returns:
///    The flags set on the given dialog. If passed an invalid handle, this function will return zero, and set its last
///    error to <b>ERROR_INVALID_HANDLE</b>.
///    
@DllImport("USER32")
DIALOG_DPI_CHANGE_BEHAVIORS GetDialogDpiChangeBehavior(HWND hDlg);

///Retrieves the specified system metric or system configuration setting taking into account a provided DPI.
///Params:
///    nIndex = The system metric or configuration setting to be retrieved. See GetSystemMetrics for the possible values.
///    dpi = The DPI to use for scaling the metric.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
int GetSystemMetricsForDpi(int nIndex, uint dpi);

///Calculates the required size of the window rectangle, based on the desired size of the client rectangle and the
///provided DPI. This window rectangle can then be passed to the CreateWindowEx function to create a window with a
///client area of the desired size.
///Params:
///    lpRect = A pointer to a <b>RECT</b> structure that contains the coordinates of the top-left and bottom-right corners of
///             the desired client area. When the function returns, the structure contains the coordinates of the top-left and
///             bottom-right corners of the window to accommodate the desired client area.
///    dwStyle = The Window Style of the window whose required size is to be calculated. Note that you cannot specify the
///              <b>WS_OVERLAPPED</b> style.
///    bMenu = Indicates whether the window has a menu.
///    dwExStyle = The Extended Window Style of the window whose required size is to be calculated.
///    dpi = The DPI to use for scaling.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL AdjustWindowRectExForDpi(RECT* lpRect, uint dwStyle, BOOL bMenu, uint dwExStyle, uint dpi);

///Converts a point in a window from logical coordinates into physical coordinates, regardless of the dots per inch
///(dpi) awareness of the caller. For more information about DPI awareness levels, see PROCESS_DPI_AWARENESS.
///Params:
///    hWnd = A handle to the window whose transform is used for the conversion.
///    lpPoint = A pointer to a POINT structure that specifies the logical coordinates to be converted. The new physical
///              coordinates are copied into this structure if the function succeeds.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("USER32")
BOOL LogicalToPhysicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

///Converts a point in a window from physical coordinates into logical coordinates, regardless of the dots per inch
///(dpi) awareness of the caller. For more information about DPI awareness levels, see PROCESS_DPI_AWARENESS.
///Params:
///    hWnd = A handle to the window whose transform is used for the conversion.
///    lpPoint = A pointer to a POINT structure that specifies the physical/screen coordinates to be converted. The new logical
///              coordinates are copied into this structure if the function succeeds.
///Returns:
///    Returns <b>TRUE</b> if successful, or <b>FALSE</b> otherwise.
///    
@DllImport("USER32")
BOOL PhysicalToLogicalPointForPerMonitorDPI(HWND hWnd, POINT* lpPoint);

///Retrieves the value of one of the system-wide parameters, taking into account the provided DPI value.
///Params:
///    uiAction = The system-wide parameter to be retrieved. This function is only intended for use with
///               <b>SPI_GETICONTITLELOGFONT</b>, <b>SPI_GETICONMETRICS</b>, or <b>SPI_GETNONCLIENTMETRICS</b>. See
///               SystemParametersInfo for more information on these values.
///    uiParam = A parameter whose usage and format depends on the system parameter being queried. For more information about
///              system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you must specify zero for
///              this parameter.
///    pvParam = A parameter whose usage and format depends on the system parameter being queried. For more information about
///              system-wide parameters, see the <i>uiAction</i> parameter. If not otherwise indicated, you must specify
///              <b>NULL</b> for this parameter. For information on the <b>PVOID</b> datatype, see Windows Data Types.
///    fWinIni = Has no effect for with this API. This parameter only has an effect if you're setting parameter.
///    dpi = The DPI to use for scaling the metric.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL SystemParametersInfoForDpi(uint uiAction, uint uiParam, void* pvParam, uint fWinIni, uint dpi);

///Set the DPI awareness for the current thread to the provided value.
///Params:
///    dpiContext = The new DPI_AWARENESS_CONTEXT for the current thread. This context includes the DPI_AWARENESS value.
///Returns:
///    The old DPI_AWARENESS_CONTEXT for the thread. If the <i>dpiContext</i> is invalid, the thread will not be updated
///    and the return value will be <b>NULL</b>. You can use this value to restore the old <b>DPI_AWARENESS_CONTEXT</b>
///    after overriding it with a predefined value.
///    
@DllImport("USER32")
ptrdiff_t SetThreadDpiAwarenessContext(ptrdiff_t dpiContext);

///Gets the DPI_AWARENESS_CONTEXT for the current thread.
///Returns:
///    The current DPI_AWARENESS_CONTEXT for the thread.
///    
@DllImport("USER32")
ptrdiff_t GetThreadDpiAwarenessContext();

///Returns the DPI_AWARENESS_CONTEXT associated with a window.
///Params:
///    hwnd = The window to query.
///Returns:
///    The DPI_AWARENESS_CONTEXT for the provided window. If the window is not valid, the return value is <b>NULL</b>.
///    
@DllImport("USER32")
ptrdiff_t GetWindowDpiAwarenessContext(HWND hwnd);

///Retrieves the DPI_AWARENESS value from a <b>DPI_AWARENESS_CONTEXT</b>.
///Params:
///    value = The <b>DPI_AWARENESS_CONTEXT</b> you want to examine.
///Returns:
///    The DPI_AWARENESS. If the provided <i>value</i> is <b>null</b> or invalid, this method will return
///    <b>DPI_AWARENESS_INVALID</b>.
///    
@DllImport("USER32")
DPI_AWARENESS GetAwarenessFromDpiAwarenessContext(ptrdiff_t value);

///Retrieves the DPI from a given DPI_AWARENESS_CONTEXT handle. This enables you to determine the DPI of a thread
///without needed to examine a window created within that thread.
///Params:
///    value = The <b>DPI_AWARENESS_CONTEXT</b> handle to examine.
///Returns:
///    The DPI value associated with the <b>DPI_AWARENESS_CONTEXT</b> handle.
///    
@DllImport("USER32")
uint GetDpiFromDpiAwarenessContext(ptrdiff_t value);

///Determines whether two <b>DPI_AWARENESS_CONTEXT</b> values are identical.
///Params:
///    dpiContextA = The first value to compare.
///    dpiContextB = The second value to compare.
///Returns:
///    Returns <b>TRUE</b> if the values are equal, otherwise <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL AreDpiAwarenessContextsEqual(ptrdiff_t dpiContextA, ptrdiff_t dpiContextB);

///Determines if a specified <b>DPI_AWARENESS_CONTEXT</b> is valid and supported by the current system.
///Params:
///    value = The context that you want to determine if it is supported.
///Returns:
///    <b>TRUE</b> if the provided context is supported, otherwise <b>FALSE</b>.
///    
@DllImport("USER32")
BOOL IsValidDpiAwarenessContext(ptrdiff_t value);

///Returns the dots per inch (dpi) value for the associated window.
///Params:
///    hwnd = The window you want to get information about.
///Returns:
///    The DPI for the window which depends on the DPI_AWARENESS of the window. See the Remarks for more information. An
///    invalid <i>hwnd</i> value will result in a return value of 0.
///    
@DllImport("USER32")
uint GetDpiForWindow(HWND hwnd);

///Returns the system DPI.
///Returns:
///    The system DPI value.
///    
@DllImport("USER32")
uint GetDpiForSystem();

///Retrieves the system DPI associated with a given process. This is useful for avoiding compatibility issues that arise
///from sharing DPI-sensitive information between multiple system-aware processes with different system DPI values.
///Params:
///    hProcess = The handle for the process to examine. If this value is null, this API behaves identically to GetDpiForSystem.
///Returns:
///    The process's system DPI value.
///    
@DllImport("USER32")
uint GetSystemDpiForProcess(HANDLE hProcess);

///In high-DPI displays, enables automatic display scaling of the non-client area portions of the specified top-level
///window. Must be called during the initialization of that window.<div class="alert"><b>Note</b> Applications running
///at a DPI_AWARENESS_CONTEXT of <b>DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2</b> automatically scale their non-client
///areas by default. They do not need to call this function.</div> <div> </div>
///Params:
///    hwnd = The window that should have automatic scaling enabled.
///Returns:
///    If the function succeeds, the return value is nonzero. If the function fails, the return value is zero. To get
///    extended error information, call GetLastError.
///    
@DllImport("USER32")
BOOL EnableNonClientDpiScaling(HWND hwnd);

///It is recommended that you set the process-default DPI awareness via application manifest. See Setting the default
///DPI awareness for a process for more information. Setting the process-default DPI awareness via API call can lead to
///unexpected application behavior. Sets the current process to a specified dots per inch (dpi) awareness context. The
///DPI awareness contexts are from the DPI_AWARENESS_CONTEXT value.
///Params:
///    value = A DPI_AWARENESS_CONTEXT handle to set.
///Returns:
///    This function returns TRUE if the operation was successful, and FALSE otherwise. To get extended error
///    information, call GetLastError. Possible errors are <b>ERROR_INVALID_PARAMETER</b> for an invalid input, and
///    <b>ERROR_ACCESS_DENIED</b> if the default API awareness mode for the process has already been set (via a previous
///    API call or within the application manifest).
///    
@DllImport("USER32")
BOOL SetProcessDpiAwarenessContext(ptrdiff_t value);

///Sets the thread's DPI_HOSTING_BEHAVIOR. This behavior allows windows created in the thread to host child windows with
///a different <b>DPI_AWARENESS_CONTEXT</b>.
///Params:
///    value = The new DPI_HOSTING_BEHAVIOR value for the current thread.
///Returns:
///    The previous DPI_HOSTING_BEHAVIOR for the thread. If the hosting behavior passed in is invalid, the thread will
///    not be updated and the return value will be <b>DPI_HOSTING_BEHAVIOR_INVALID</b>. You can use this value to
///    restore the old <b>DPI_HOSTING_BEHAVIOR</b> after overriding it with a predefined value.
///    
@DllImport("USER32")
DPI_HOSTING_BEHAVIOR SetThreadDpiHostingBehavior(DPI_HOSTING_BEHAVIOR value);

///Retrieves the DPI_HOSTING_BEHAVIOR from the current thread.
///Returns:
///    The DPI_HOSTING_BEHAVIOR of the current thread.
///    
@DllImport("USER32")
DPI_HOSTING_BEHAVIOR GetThreadDpiHostingBehavior();

///Returns the DPI_HOSTING_BEHAVIOR of the specified window.
///Params:
///    hwnd = The handle for the window to examine.
///Returns:
///    The DPI_HOSTING_BEHAVIOR of the specified window.
///    
@DllImport("USER32")
DPI_HOSTING_BEHAVIOR GetWindowDpiHostingBehavior(HWND hwnd);

///It is recommended that you set the process-default DPI awareness via application manifest. See Setting the default
///DPI awareness for a process for more information. Setting the process-default DPI awareness via API call can lead to
///unexpected application behavior. Sets the process-default DPI awareness level. This is equivalent to calling
///SetProcessDpiAwarenessContext with the corresponding DPI_AWARENESS_CONTEXT value.
///Params:
///    value = The DPI awareness value to set. Possible values are from the PROCESS_DPI_AWARENESSenumeration.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The DPI awareness for the app was
///    set successfully. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td
///    width="60%"> The value passed in is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The DPI awareness is already set, either by calling
///    this API previously or through the application (.exe) manifest. </td> </tr> </table>
///    
@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT SetProcessDpiAwareness(PROCESS_DPI_AWARENESS value);

///Retrieves the dots per inch (dpi) awareness of the specified process.
///Params:
///    hprocess = Handle of the process that is being queried. If this parameter is NULL, the current process is queried.
///    value = The DPI awareness of the specified process. Possible values are from the PROCESS_DPI_AWARENESS enumeration.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function successfully retrieved
///    the DPI awareness of the specified process. </td> </tr> <tr> <td width="40%"> <dl> <dt><b>E_INVALIDARG</b></dt>
///    </dl> </td> <td width="60%"> The handle or pointer passed in is not valid. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_ACCESSDENIED</b></dt> </dl> </td> <td width="60%"> The application does not have sufficient privileges.
///    </td> </tr> </table>
///    
@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT GetProcessDpiAwareness(HANDLE hprocess, PROCESS_DPI_AWARENESS* value);

///Queries the dots per inch (dpi) of a display.
///Params:
///    hmonitor = Handle of the monitor being queried.
///    dpiType = The type of DPI being queried. Possible values are from the MONITOR_DPI_TYPE enumeration.
///    dpiX = The value of the DPI along the X axis. This value always refers to the horizontal edge, even when the screen is
///           rotated.
///    dpiY = The value of the DPI along the Y axis. This value always refers to the vertical edge, even when the screen is
///           rotated.
///Returns:
///    This function returns one of the following values. <table> <tr> <th>Return code</th> <th>Description</th> </tr>
///    <tr> <td width="40%"> <dl> <dt><b>S_OK</b></dt> </dl> </td> <td width="60%"> The function successfully returns
///    the X and Y DPI values for the specified monitor. </td> </tr> <tr> <td width="40%"> <dl>
///    <dt><b>E_INVALIDARG</b></dt> </dl> </td> <td width="60%"> The handle, DPI type, or pointers passed in are not
///    valid. </td> </tr> </table>
///    
@DllImport("api-ms-win-shcore-scaling-l1-1-1")
HRESULT GetDpiForMonitor(HMONITOR hmonitor, MONITOR_DPI_TYPE dpiType, uint* dpiX, uint* dpiY);

///A variant of OpenThemeData that opens a theme handle associated with a specific DPI.
///Params:
///    hwnd = The handle of the window for which theme data is required.
///    pszClassList = A pointer to a string that contains a semicolon-separated list of classes.
///    dpi = The specified DPI value with which to associate the theme handle. The function will return an error if this value
///          is outside of those that correspond to the set of connected monitors.
///Returns:
///    See OpenThemeData.
///    
@DllImport("UxTheme")
ptrdiff_t OpenThemeDataForDpi(HWND hwnd, const(PWSTR) pszClassList, uint dpi);


